Return-Path: <netdev+bounces-143826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 059579C45D0
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 20:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7B72839F1
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 19:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B00E1AB6DA;
	Mon, 11 Nov 2024 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="lDhoAUlQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3087D1AAE00
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 19:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731353234; cv=none; b=QuUlr2H8i9+qc8YgdN3VXmLAtzSDAv4dcCKhqTggWpFi8OuY6nPGbCAS+zBsGe4L/CccOzJaRbtENnDCoLdlIuPsEX45EumNF9jojkCg1NFhlvqUHTDP1vkN7gfcPuL7h8QrThlJJztGi+ODar2U5r9oEjDV/m2alKQgZqZqxCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731353234; c=relaxed/simple;
	bh=rWDrb9TdsoW2zowseo7LWCXDFB5Vn8h5HgXc5vvc0Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBlKYT6xSqJV0wWYxF5LXH04GzELKLK3HricG0/fdX/keA0vmkzbxq4wjXbvF1aJXVhCSYkYa5gKm5NzAeYVIVPi/CjLL9T0HwsFEY2TNYdclSTQoSnBI4CFIej0Vjknp6MbG6PHo0Inlvu3U65B0J1Igcg0q4LwGOF5il7cqTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=lDhoAUlQ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-720d5ada03cso4942735b3a.1
        for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 11:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731353228; x=1731958028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyvZijSaVwszmlc/DaE9BEpZ4WIzbItVNXuhvnFbh8I=;
        b=lDhoAUlQSJqx0gIi/6ns5MsAmGRuDQq72mTZOfFSeVGuAD47sdZP62L2Li2oTjR963
         X0qtXmKv35t7iWcCExi8UzaPbOlId2Nfdjb+f2MDiP3/NpCa0naz00lAcqyFbZAs9YA7
         FFaEbdSCQ2ccUV/x5LK26aadA6ssdKI6qJznY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731353228; x=1731958028;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KyvZijSaVwszmlc/DaE9BEpZ4WIzbItVNXuhvnFbh8I=;
        b=TsbhER/OkwZodOSZs0ustiSWkopA03waSAXxAElTGDD6oQ8dLQ1i1Gboj4c8VrgaA1
         O/c5OsZ2ibNvBLm8jmcx1TPMklUc+QHoYo/DsMS8ZTWNUGzn0AxrVMaUKsyK1EgBJBvc
         XBaaWG+7URh1GfCtnAwpmB3Yu6uPp8jcyn9y/BHq9TeXAVlWK+gpLQfZhQukwHR7fT/b
         cOf0j6C2PpfAER/l+Hg5tpaI3XghUxWLrbSr3gs7uwyg1Gl9YyJP9zgz9g58qmmyq2H7
         S3agxXAyV01B8rv9flWTRGFBTz3dcxtr+XUMdoJZUfQQ1IGJIYU0wjCgATte65ShcBLP
         7eYA==
X-Forwarded-Encrypted: i=1; AJvYcCXzyB2KdtGxgfVyz/tw+jK2DXNHvyRcJTDEaXfT6LddDNB7Sfh4IITw4mSMjHk64aHbxv5cyao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp8zEOqi+N6/hWtI1BMWMA4DOTZIlkYOjnQVo8160V6Cj7LIMy
	JnS8XLtE9h8/UjzS6LXjYPC9LVXB1wBvi6FxKQ093w1soAc4VswbhXjW/9dvGaE=
X-Google-Smtp-Source: AGHT+IGcqd4bsCoWMwUfj0g4nfgfukA+f52wfyN0peClu/5++Qaqz0FRNT7R8DTcAUURXNfZDc6V2w==
X-Received: by 2002:a05:6a00:3d01:b0:71e:7c25:8217 with SMTP id d2e1a72fcca58-72413380e56mr16473391b3a.25.1731353228268;
        Mon, 11 Nov 2024 11:27:08 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a18dd2sm9747704b3a.148.2024.11.11.11.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 11:27:07 -0800 (PST)
Date: Mon, 11 Nov 2024 11:27:05 -0800
From: Joe Damato <jdamato@fastly.com>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: ecree.xilinx@gmail.com, davem@davemloft.net, mkubecek@suse.cz,
	kuba@kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH ethtool-next v2] rxclass: Make output for RSS context
 action explicit
Message-ID: <ZzJaiSoer9VAAjHo@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Daniel Xu <dxu@dxuuu.xyz>, ecree.xilinx@gmail.com,
	davem@davemloft.net, mkubecek@suse.cz, kuba@kernel.org,
	martin.lau@linux.dev, netdev@vger.kernel.org, kernel-team@meta.com
References: <978e1192c07e970b8944c2a729ae42bf97667a53.1731107871.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <978e1192c07e970b8944c2a729ae42bf97667a53.1731107871.git.dxu@dxuuu.xyz>

On Mon, Nov 11, 2024 at 12:05:38PM -0700, Daniel Xu wrote:
> Currently `ethtool -n` prints out misleading output if the action for an
> ntuple rule is to redirect to an RSS context. For example:
> 
>     # ethtool -X eth0 hfunc toeplitz context new start 24 equal 8
>     New RSS context is 1
> 
>     # ethtool -N eth0 flow-type ip6 dst-ip $IP6 context 1
>     Added rule with ID 0
> 
>     # ethtool -n eth0 rule 0
>     Filter: 0
>             Rule Type: Raw IPv6
>             Src IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
>             Dest IP addr: <redacted> mask: ::
>             Traffic Class: 0x0 mask: 0xff
>             Protocol: 0 mask: 0xff
>             L4 bytes: 0x0 mask: 0xffffffff
>             RSS Context ID: 1
>             Action: Direct to queue 0
> 
> The above output suggests that the HW will direct to queue 0 where in
> reality queue 0 is just the base offset from which the redirection table
> lookup in the RSS context is added to.
> 
> Fix by making output more clear. Also suppress base offset queue for the
> common case of 0. Example of new output:
> 
>     # ./ethtool -n eth0 rule 0
>     Filter: 0
>             Rule Type: Raw IPv6
>             Src IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
>             Dest IP addr: <redacted> mask: ::
>             Traffic Class: 0x0 mask: 0xff
>             Protocol: 0 mask: 0xff
>             L4 bytes: 0x0 mask: 0xffffffff
>             Action: Direct to RSS context id 1
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
> Changes from v1:
> * Reword to support queue base offset API
> * Fix compile error
> * Improve wording (also a transcription error)
> 
>  rxclass.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

I tested this on a machine with an mlx5 NIC.

FWIW: I only learned about ring_cookie from this thread, so I don't
feel qualified to give an official "Reviewed-by", but:

Before the patch:

sudo ethtool -L eth2 combined 18
sudo ethtool -X eth2 weight 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 context new
sudo ethtool -U eth2 flow-type tcp4 dst-port 11211 context 1

$ ethtool -n eth2 rule 1023
Filter: 1023
	Rule Type: TCP over IPv4
	Src IP addr: 0.0.0.0 mask: 255.255.255.255
	Dest IP addr: 0.0.0.0 mask: 255.255.255.255
	TOS: 0x0 mask: 0xff
	Src port: 0 mask: 0xffff
	Dest port: 11211 mask: 0x0
	RSS Context ID: 1
	Action: Direct to queue 0

After the patch:

$ ./ethtool -n eth2 rule 1023
Filter: 1023
	Rule Type: TCP over IPv4
	Src IP addr: 0.0.0.0 mask: 255.255.255.255
	Dest IP addr: 0.0.0.0 mask: 255.255.255.255
	TOS: 0x0 mask: 0xff
	Src port: 0 mask: 0xffff
	Dest port: 11211 mask: 0x0
	Action: Direct to RSS context id 1

The results after the patch make more sense to me, personally. I
have NOT audited mlx5 at all, so no idea how (or if) it deals with
ring_cookie.

It'd be really great to add the bit about "queue base offset" to the
man page for ethtool.

All that said, since I tested it and it works and makes sense to me:

Tested-by: Joe Damato <jdamato@fastly.com>

