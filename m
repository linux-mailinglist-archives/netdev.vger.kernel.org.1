Return-Path: <netdev+bounces-80609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDDA87FEF2
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 14:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70A0F1F25D3B
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 13:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9E13FBB9;
	Tue, 19 Mar 2024 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMWO+DAm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F321CD07
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 13:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710855503; cv=none; b=bi7Ph7TgpUwp9E7sOdO+iipl/koqIQ6juSQR/DnpbZKE1HTvSIbt8SXEnG3DjPM3Vo6u4yCXggY1rhioKH0w28PdhyHKLiTWhticsjgFpF4o5QZQtTJuQbU4+DvWHr4lIH90J4mRtkIXZIvZmqV9OSlEuTmTz2uz1s5NjJBxVuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710855503; c=relaxed/simple;
	bh=tSHRVWVCaQDDKtEnBIp5/qPMDP6QXslpOQO/04Slp6M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ReGy1RENZ0blrTLHdkoNRT2s+LiQwHMu4Li9SvKfbYjvplPV4rOXdNi5BDkQRfa59yhxZGpp9kyxhVw0vcRdQY2bBphe6PvoKi8zQhsgN6aVO0KHcuIRYcUDtObl558/wu8EL6xKOjwE7gxKizLtj2ab8xWaTzHZ3ioDbBCvHds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMWO+DAm; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-69625f89aa2so10596716d6.3
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 06:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710855501; x=1711460301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g12kGMVxNRGMBz62Padxly1gI7hznd+OZGFrqWcWQrw=;
        b=AMWO+DAm+S2/k/aEs1Ux3cYhlrYPGqcRvtE1qT5pDxdU1/UiLnizRgLrmglHrr+fWz
         gZ8vt5s7KPeG6lFFBQM29olIgQihD9W6HASAMTuWwWLselai/VS0dwoYxlWTYt98+XEQ
         Veibdy8oOYLT9GoxQB1h8hokelvIdlCnUIVKxuflB3mreKsVKoX6O/JvBWh8gl/fgox/
         nWrCfh24FAk4AdU0/W1t1cvyQUgm7JnPayN9dylAGkK7Jou3db4vfm8cnsetdUtMZsl1
         arQQqOwE64Ech6tbubAqc9N3dSrNy9oTnTzop2ncbNUe5dqPzRJ+ISIBN/v6pM8w0lAs
         +A+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710855501; x=1711460301;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g12kGMVxNRGMBz62Padxly1gI7hznd+OZGFrqWcWQrw=;
        b=dZqkuqCfCBg4rUPxTDotHlDR8IpoKVLtkF+DThxtEsoeN0tz7c47eRUyynM5IfzlwA
         q12jySf06vk9Fap+6Pus0Qzi9QhD/xkzWMf30tRmCDILXIVpDcankanCUE9KQhQ+Y3HW
         IGvmbGIHv/qlxjmmTWCl7MyEgjKfFJV1ViQHjWBRKADLCHyA0kn2brYs4oGzKb8Gszsj
         a+XcJWPjD+Awmnhlfwa53qkVau7NZnPJ+vz1VWWnGac450H+5QCGQWJ8sGco9Zxv0tJn
         F9Ng9CQCk/81jWcugMEWhd5IoZTxU1QHSWGh4pfij3fHqG3LDZH1irZgZ5KymhUY7186
         NdGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD7Qd69TLTrHX/xnJp980iyX75sMAZoC2ViJ87DvoLtgMWwt0myF0M2S7VYEEZ9xKztbknZhjN7Lt/jv+G5oJJZP19qTMT
X-Gm-Message-State: AOJu0YwrAZdlPiTsGWygBFWMEPOgI9Y4OVYn5VJLeopipY9Ykh3evOcC
	Ya0YL3egAo/5Lttn9CwpAFKhlZ/F9GjW743JhRz/uQOJtMIjbrqE
X-Google-Smtp-Source: AGHT+IHcQb6xDi68YhTEkzsKk/kpfzTOQMisNdt8SimlbY5UKnusKLsRIDBxRoMsqQNWWdjOLGnKDQ==
X-Received: by 2002:ad4:42a1:0:b0:696:314a:281 with SMTP id e1-20020ad442a1000000b00696314a0281mr1895039qvr.58.1710855500945;
        Tue, 19 Mar 2024 06:38:20 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id 2-20020a05621420a200b00696143c7ed3sm2778349qvd.38.2024.03.19.06.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 06:38:20 -0700 (PDT)
Date: Tue, 19 Mar 2024 09:38:20 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Antoine Tenart <atenart@kernel.org>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>, 
 steffen.klassert@secunet.com, 
 willemdebruijn.kernel@gmail.com, 
 netdev@vger.kernel.org
Message-ID: <65f9954c70e28_11543d294f3@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240319093140.499123-4-atenart@kernel.org>
References: <20240319093140.499123-1-atenart@kernel.org>
 <20240319093140.499123-4-atenart@kernel.org>
Subject: Re: [PATCH net v2 3/4] udp: do not transition UDP fraglist to
 unnecessary checksum
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Antoine Tenart wrote:
> udp4/6_gro_complete transition fraglist packets to CHECKSUM_UNNECESSARY
> and sets their checksum level based on if the packet is recognized to be
> a tunneled one. However there is no safe way to detect a packet is a
> tunneled one and in case such packet is GROed at the UDP level, setting
> a wrong checksum level will lead to later errors. For example if those
> packets are forwarded to the Tx path they could produce the following
> dump:
> 
>   gen01: hw csum failure
>   skb len=3008 headroom=160 headlen=1376 tailroom=0
>   mac=(106,14) net=(120,40) trans=160
>   shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
>   csum(0xffff232e ip_summed=2 complete_sw=0 valid=0 level=0)
>   hash(0x77e3d716 sw=1 l4=1) proto=0x86dd pkttype=0 iif=12
>   ...
> 
> Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
> Signed-off-by: Antoine Tenart <atenart@kernel.org>

The original patch converted to CHECKSUM_UNNECESSARY for a reason.
The skb->csum of the main gso_skb is not valid?

Should instead only the csum_level be adjusted, to always keep
csum_level == 0?

