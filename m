Return-Path: <netdev+bounces-158596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2D5A12A03
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 18:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3644C3A3D45
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 17:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109EA1AB50C;
	Wed, 15 Jan 2025 17:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="v/5iIPyr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73246150994
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 17:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736962722; cv=none; b=HrMKBiCZlmhy6vfXBxu+KwxQ4rG10FR6kX5VU6SLIGZ7hlcWoU1Y70VqWN6OFuYJfORWo6QejD3TCPzzchrQlsw9mwdHf7ucfBMzioYVMP5UmpV3v+IRQxYM917WO+aFbq55KHhFMIhiySyrh0IPo3KMNt4iodsyTGUp2erjsQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736962722; c=relaxed/simple;
	bh=cCVtDtI3L9QMh6P2HaAgCq28O/T4xEBL4t88d6cSS7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIsA4qleBorahXquZq6zlpI/Q2KtZ6KyWopWzbLdC3+LjHuHiZNKI9lGL904ijXk739ncwSsywTlFnqpF8pufBTLc4yYzNrDKQ0xgBPZQJD5d2bk0aXbASwHzuZ0yATBC/x+from8GQg30cNLTEgin3lDZOmoJvhUzy42DxmxSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=v/5iIPyr; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21628b3fe7dso122479815ad.3
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 09:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736962719; x=1737567519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4H2dDO5oqjOdgcji2cLVYChhEYMYo6QJGh5tEb4A6Q=;
        b=v/5iIPyrMCQ+xqiAeLXPiIHWnzaw5+g8v5/VC7qG/Taesmwd2dY+99rstKXzIeix5E
         ZEHfqE8ux9sjOCSy90bTIEmGnVmq7fKy6raC3ZDxQVokIEi8I0ydiw1uYVgd44QHC+XM
         DwpwuRxnUpIj6jscDabnoE7JHOzNaWS80ZaKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736962719; x=1737567519;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p4H2dDO5oqjOdgcji2cLVYChhEYMYo6QJGh5tEb4A6Q=;
        b=EkVTpOf4/2GVS0+hQ7rcIE19ueHILSVQewNiCss28ZJWtF8habzC9yjLhaB3nodK2s
         xwtU7gncvu73ACl91X8gtThZkM3B1udLoUJsaja5xcTXsdomas1GCvGgtCEth/N4/d1J
         5vDXHwjCrxx8L6k/WpYVBMwjmt9cNxLqENDNZXpwOLypak/NTwaslh/nBg10Y2jCCkKE
         LeB9EGxnJnV4h/qB4+b4tDN4sHdKLgVTzaLeOGnObAT++Dyplzm6mNZLZaGYfqaaMUiT
         Q5Y/Q8O8XJtai1F4imu5Icymu6cNMhoRjRuV93UYTG9yIdemIHGxmAzEUqpBCRFU3ZHs
         J4WA==
X-Forwarded-Encrypted: i=1; AJvYcCWHs14eVQ/eslqgdlcbx4KaDGa9oMGfM4BBph5et8XGL+TWD0qZEj5+BGkn/olBXgo2auKVP68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4X6Z8uNqBU+TQ9dt03yzZuX93et83GYL7DWTRw8w4JJISWeA6
	Q6BLOKyLEkxGnEQxmDcSZ6Xzl22gxdmNZK6yLZ/cOQA0KEJ0ZZh8AvypSaxFbsU=
X-Gm-Gg: ASbGncslcs1Jbr2cKYh8NgrPBePBlBWVykuweu0XtYupJtikFLplwso0ObqtknQ9660
	YLe+tA2tBKudp8NNp9HnllfLtXkG+UZj7mjTtMgSRGju2FS9ABDU/XRiE2YkPwmvif1uUPEKROS
	J9rPfyAqG7FVXgck7HWBxQy+fSytxrLdLiNnK8i2b8QFgHHYgbAYi1z7o8DE+dN+Yi1FbhEBI7h
	Zo9W5Dap17XdMczX6TjK8hpAbWLJvbCTiDvnEa8/gSUB9TXFnCV9pElnN9Cw8KKCoKUsq3IRPC9
	DA+GWGxF9WYdvofLq1OAtSY=
X-Google-Smtp-Source: AGHT+IGtF5HTNfkxn2kiIHCJVZmMSRnqGMzuxU3E5MQKOylnC/s74SbaEpbh6Lam1G4blDN8suUzJA==
X-Received: by 2002:a05:6a00:9294:b0:725:cfa3:bc76 with SMTP id d2e1a72fcca58-72d21f115b4mr46941225b3a.4.1736962719624;
        Wed, 15 Jan 2025 09:38:39 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4056d5aesm9458749b3a.43.2025.01.15.09.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 09:38:39 -0800 (PST)
Date: Wed, 15 Jan 2025 09:38:36 -0800
From: Joe Damato <jdamato@fastly.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 00/11] af_unix: Set skb drop reason in every
 kfree_skb() path.
Message-ID: <Z4fynNxk3FJ8BCWA@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20250112040810.14145-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250112040810.14145-1-kuniyu@amazon.com>

On Sun, Jan 12, 2025 at 01:07:59PM +0900, Kuniyuki Iwashima wrote:
> There is a potential user for skb drop reason for AF_UNIX.
> 
> This series sets skb drop reason for every kfree_skb() path
> in AF_UNIX code.
> 
> Link: https://lore.kernel.org/netdev/CAAf2ycmZHti95WaBR3s+L5Epm1q7sXmvZ-EqCK=-oZj=45tOwQ@mail.gmail.com/
> 
> 
> Changes:
>   v2:
>     * Drop the old patch 6 to silence false-positive uninit warning
> 
>   v1: https://lore.kernel.org/netdev/20250110092641.85905-1-kuniyu@amazon.com/
> 
> 
> Kuniyuki Iwashima (11):
>   net: dropreason: Gather SOCKET_ drop reasons.
>   af_unix: Set drop reason in unix_release_sock().
>   af_unix: Set drop reason in unix_sock_destructor().
>   af_unix: Set drop reason in __unix_gc().
>   af_unix: Set drop reason in unix_stream_connect().
>   af_unix: Set drop reason in unix_stream_sendmsg().
>   af_unix: Set drop reason in queue_oob().
>   af_unix: Set drop reason in manage_oob().
>   af_unix: Set drop reason in unix_stream_read_skb().
>   af_unix: Set drop reason in unix_dgram_disconnected().
>   af_unix: Set drop reason in unix_dgram_sendmsg().
> 
>  include/net/dropreason-core.h |  46 ++++++++--
>  net/unix/af_unix.c            | 153 +++++++++++++++++++++++++---------
>  net/unix/garbage.c            |   2 +-
>  3 files changed, 154 insertions(+), 47 deletions(-)

I know there's feedback from others on some parts of this series but
I wanted to say thank you for the detailed commit messages that
include python examples.

I found that very refreshing and helpful when attempting to review
the code you've proposed; thanks for putting in the extra effort to
include those examples in the commit messages.

