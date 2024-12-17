Return-Path: <netdev+bounces-152645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3143D9F4F8F
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 16:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D18091883CF6
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 15:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6A41F759C;
	Tue, 17 Dec 2024 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHESXQ42"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D996EAC6;
	Tue, 17 Dec 2024 15:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734449748; cv=none; b=sGEcmBl6ydc8ArOGOQLEifzdvzvT31ec+YJoz5uCATYhij1FGdgdpkAzQvMQg43czwxjINY8OAI/58mhAkIZkRuU6Tb1eJA7qpm26fzJxI2821ChG7QYg77x6P9DXywZ70eofDPOJtBQRwcqkM46fS9IfhsrgphdzQWC4fnuPx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734449748; c=relaxed/simple;
	bh=FpD5UynaL06QwYdt5J8Ahluf6VvLqe4g4Ov9ExwUZ/Y=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=uR1kchNJLKYJb6CY9idXGKrGk3HClryGNy4v6HfBYD7v/ncdyKm1Qov1MO/MAkskJ1yp3a/C6CThaL4erbcFmsxTQOxsk71dM0Yc1ezwF0m0n+bX4fmhWx+jx47zO5o4EEL1qeKX5JXzg6IfNFOh2/m2IfAfiJXuoUDulTM09nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHESXQ42; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-467a3f1e667so29295971cf.0;
        Tue, 17 Dec 2024 07:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734449745; x=1735054545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZqRohsxgDqGeXZWJE1OO5VcgJ9YhttJf/CwCIN3nfg=;
        b=hHESXQ42QBXUUE6/rQ0rjVDbiHaFwFSP7vUPzIw2JykGFn4SzK1jOjEDFLevhyiQGT
         wEwEoq3uYUZxzDdoX9+Rrmn2KWHhprhmmT1zzz6ykmAgxrN2yLDEswMqNza0+hy8QjVZ
         SpyB07pbo+mBT7PzpRcc4CRGrNdPvlS91+mNj/6+VT/9M+IJzB8UuK37QLkIsJdCjM06
         dczBdQP6IALYJ0GjgKF3K48ZaqpRWeRnv8hI7jAP1hormE9mIkMeGN/70X8EbCMRwKo1
         ArWWfnzT0wNrM7pJdtGSu5SNcjkwZgvwDtEwn/XgtrqBbBm2KmC/CdNzZ5Lu8x+BqU+p
         73nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734449745; x=1735054545;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LZqRohsxgDqGeXZWJE1OO5VcgJ9YhttJf/CwCIN3nfg=;
        b=LZbGcZ7iUvpULimscg+6ekiyXlRVOKdGggYXS9R/IZW+9riUd10m7LklKTsiL4f5kN
         dqx1YMacgs20erM6sB1lh42if9UZZFOCJK82VDNHvuX/y2rytxTfpxD3hehqbD2tmRni
         o+yNASoTyUb09uRwh69I2T7CeMvdVL8QRdcqQTFu9QYDHLXZ3L5kTuRYLE/JKcCMKSmg
         H4oH368YKcu8p8gUS/2pPcWnCps7lXRNPVIiPbo9S2+bfXosQOw8O2+Cm72PQMeGhK61
         5HfI1R903ynBkkRpKOgE9LYUQiIQ3DLXd7rD8EgkCIF9He6behKPegxSct/dyWKsNXN/
         qUtg==
X-Forwarded-Encrypted: i=1; AJvYcCVCtsv+qulzEXV124Q5a9D7l4rQUHQTe2bSL4zPXWN1Knbyq5eUUrlKKpBg73kdGUTo9Dx8ctVkGXQSC+OmRs8=@vger.kernel.org, AJvYcCVjqwo/BdQBaJK90gsx7tuGaNMd2QmE1KKwgA04Y7E7USP1XvVl2PmaLovIlqJV1RXizpyD5c6G/U7DyV/w@vger.kernel.org, AJvYcCX/lmd8HWY3VojiNkOxx0hlFq2M5tpJI3UgOyZLGWkKB2zFAu4l8AEXxjkH5+AobcxdNt6K+eX9@vger.kernel.org
X-Gm-Message-State: AOJu0YzIHNjyBxUhs3iDaNnOcdCCtOUNU8js5gXyDJ89qi6iXikoT15P
	ebKv5bALP4UHUsWtOeyG5PU/utc68QThghCnoYp1PUP7NABb0mv0
X-Gm-Gg: ASbGncslWptjJzQLo7GqhAkkJree7jA5EB4GXhUwzN8MT6/+dM8cghObVlpvA72gkDe
	Zn7mJ/jVTuvUKH/lChKF5/z5AOfLuCSRYiRLNtnaUamldusJrrIbUaypg1Vc2najujIoNaAyWkw
	UQME2GUW04nrHB2HB/Hz7ho1sZOQNz2+DSsiGdA9iyofILR+BU5D4FVFOCmw6yxiM09amHD+08o
	1vBDtjFXlliWGPKXIWSSYKMJLW7kci6e/8m6dnA/TZywtnuLamN1uxfgGlLh0u9Q3Er19Poz59L
	zNaQ8uiHMipQ28pFIG8M20GD3P8V23ojJQ==
X-Google-Smtp-Source: AGHT+IGafvON1jQeIMfI3YBLEkTEeE7VOYrLT9uhcSvM20sGMVMJLGWZF8Rf0bWihbamUSQ4TcGjJw==
X-Received: by 2002:a05:622a:144:b0:462:fef1:e1f5 with SMTP id d75a77b69052e-467a578bfb4mr293351011cf.26.1734449745250;
        Tue, 17 Dec 2024 07:35:45 -0800 (PST)
Received: from localhost (96.206.236.35.bc.googleusercontent.com. [35.236.206.96])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7047aa6f8sm327843685a.25.2024.12.17.07.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 07:35:44 -0800 (PST)
Date: Tue, 17 Dec 2024 10:35:44 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kees Cook <kees@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>
Cc: Kees Cook <kees@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Joe Damato <jdamato@fastly.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
Message-ID: <67619a5029d2c_a046929426@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241217012445.work.979-kees@kernel.org>
References: <20241217012445.work.979-kees@kernel.org>
Subject: Re: [PATCH] net: core: dev.c confirmed to use classic sockaddr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kees Cook wrote:
> As part of trying to clean up struct sock_addr, add comments about the
> sockaddr arguments of dev_[gs]et_mac_address() being actual classic "max
> 14 bytes in sa_data" sockaddr instances and not struct sockaddr_storage.

What is this assertion based on?

I see various non-Ethernet .ndo_set_mac_address implementations, which
dev_set_mac_address calls. And dev_set_mac_addr_user is called from
rtnetlink do_setlink. Which kmalloc's sa based on dev->addr_len.

> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> ---
>  net/core/dev.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 45a8c3dd4a64..5abfd29a35bf 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -9183,7 +9183,8 @@ EXPORT_SYMBOL(dev_pre_changeaddr_notify);
>  /**
>   *	dev_set_mac_address - Change Media Access Control Address
>   *	@dev: device
> - *	@sa: new address
> + *	@sa: new address in a classic "struct sockaddr", which will never
> + *	     have more than 14 bytes in @sa::sa_data
>   *	@extack: netlink extended ack
>   *
>   *	Change the hardware (MAC) address of the device
> @@ -9217,6 +9218,7 @@ EXPORT_SYMBOL(dev_set_mac_address);
>  
>  DECLARE_RWSEM(dev_addr_sem);
>  
> +/* "sa" is a classic sockaddr: it will only ever use 14 bytes from sa_data. */
>  int dev_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
>  			     struct netlink_ext_ack *extack)
>  {
> @@ -9229,6 +9231,7 @@ int dev_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
>  }
>  EXPORT_SYMBOL(dev_set_mac_address_user);
>  
> +/* "sa" is a classic sockaddr: it will only ever use 14 bytes from sa_data. */
>  int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name)
>  {
>  	size_t size = sizeof(sa->sa_data_min);
> -- 
> 2.34.1
> 



