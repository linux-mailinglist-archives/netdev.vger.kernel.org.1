Return-Path: <netdev+bounces-119528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0D1956143
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 04:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A241C20A16
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 02:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F11F44C68;
	Mon, 19 Aug 2024 02:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeKYESec"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF5F381C2
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 02:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724036013; cv=none; b=bVyo34f9XapOdIJCDj+sBcjcLr9G/HweFv9gBmB+dCZ3FGlsGkngB6IVroIdspdb23m2Nm+dtnxwCnLBO6MpmX7pW60n4gkwATXZwK0RSCH/pxjh9yq3471iCrFb1HHCNFtvKEpkADyrzhQhqpbio3AefN3MqW0YtBNJkehLgOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724036013; c=relaxed/simple;
	bh=Vu66Lmc91PJwALCgo0LGiIO7A0PagwZetHeinr4Ypc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JV2+EXZtKETXn2ED7jNHX31IPDuxm2XfinXKcAj/9pWZ6Zkh1nQFHULuhPTM3bQD579rXzdpaRof/ZbfZtYFG1eg6PafiGSRd4twYai/2FNHBTsMGqxxXmaHz3ph9MFD+S/M5eMtXClrHtpTH9DiIU8XTIn657Y3k4mEIL12eJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeKYESec; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5d5ed6f51cfso2622669eaf.0
        for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 19:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724036011; x=1724640811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DHVqwDNbcMXDKGHHohcjGPD9lXWXJwXCsriGjZ8MC8c=;
        b=KeKYESecxgJS6RIeHwFNZi8DxP99kkRODlDStjYydkwpIIJEOws/IZPvJBbKdiNDwl
         UyoPVpd/MXh3roNAgk917iY19jdvEO4IkkIPdS0x78F7IVfNZVHM2ETRiVwZBm59PYtm
         1IvHn9grQw6XKZe1pq0JBncMAyd7J1qyP+cjvpntGkhBBMJSMlLreSSr11RiAeiSKfpA
         lr8bUTF7yIn6Ex/reVn9A4HyQZyvAdJRpPnD2MKGBbQV5gNfX+rrqWhkkEf/1LJQ21KR
         jWs5JUB87Nedc4RmA8gmL8Hb0J+vAeZlV21tyl7tsqhKDEPUFmahKXumdJq869VnLBOF
         f3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724036011; x=1724640811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHVqwDNbcMXDKGHHohcjGPD9lXWXJwXCsriGjZ8MC8c=;
        b=KOZzN6t9QK8OrIvaHLrI7LI88XaS4iYfaqHryrCu3XPlOurASjj6LWyklvqCVBjdsu
         6uUysimoGD3J5iQ5W3g2sBcD55FhIa8DUYFUbUQ9RrjR2J2rM7tV+BI4ONRxFtTJzrVQ
         W3UOajcT2xBUiRwnlocDWU7M+fl84L/8o3R0Xs4gDy2d52QiiU5acCwHN/8PMl60vbm/
         g1zQbZVMWtP33CpCXivl9OF/3XR+qBjtH1hUkuBBeGGqSTK/eALRaAjtOsjJIs5OE98Y
         cA0GXy3o1zr/PIjDuu/rvZGctDyhdOkHgw2uzbrnpUIGqCbt65evThXxmHNyIFKRUQ2p
         rFcg==
X-Gm-Message-State: AOJu0YyNsAcLrM6aFckTavBlsYd9jjQ8+cOSEWSW8woe7fjk6BK6/8RJ
	DR4b0mTU68MiXG9w5YZHAkRZ+hOAcE6ZWhcsXdhaeEQ6dcap4Dmt
X-Google-Smtp-Source: AGHT+IEKiMjZwG7VyiA/VAq8QYnemBlt0dWVntSLYff3CCsJNLkYgYPWGrWi8reTxryvvwheEIlVKg==
X-Received: by 2002:a05:6358:9049:b0:1a5:b0f7:251 with SMTP id e5c5f4694b2df-1b393284e1bmr1346104655d.24.1724036010884;
        Sun, 18 Aug 2024 19:53:30 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127add7c89sm5791177b3a.5.2024.08.18.19.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 19:53:30 -0700 (PDT)
Date: Mon, 19 Aug 2024 10:53:14 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
	davem@davemloft.net, jv@jvosburgh.net, andy@greyhouse.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jarod@redhat.com
Subject: Re: [PATCH net 2/4] bonding: fix null pointer deref in
 bond_ipsec_offload_ok
Message-ID: <ZsKzmpnXsKLAneIe@Laptop-X1>
References: <20240816114813.326645-1-razor@blackwall.org>
 <20240816114813.326645-3-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816114813.326645-3-razor@blackwall.org>

On Fri, Aug 16, 2024 at 02:48:11PM +0300, Nikolay Aleksandrov wrote:
> We must check if there is an active slave before dereferencing the pointer.
> 
> Fixes: 18cb261afd7b ("bonding: support hardware encryption offload to slaves")
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>  drivers/net/bonding/bond_main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 85b5868deeea..65ddb71eebcd 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -604,6 +604,8 @@ static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
>  	bond = netdev_priv(bond_dev);
>  	rcu_read_lock();
>  	curr_active = rcu_dereference(bond->curr_active_slave);
> +	if (!curr_active)
> +		goto out;
>  	real_dev = curr_active->dev;
>  
>  	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)
> -- 
> 2.44.0
> 

BTW, the bond_ipsec_offload_ok() only checks !xs->xso.real_dev, should we also
add WARN_ON(xs->xso.real_dev != slave->dev) checking?

Thanks
Hangbin

