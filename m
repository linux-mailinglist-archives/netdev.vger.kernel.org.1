Return-Path: <netdev+bounces-230840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B29BF058C
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 11:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC88E1891E8D
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 09:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DD42F6179;
	Mon, 20 Oct 2025 09:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="LeuAtfk6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A0F2F60DF
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 09:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954297; cv=none; b=oeM6Ae+0VwElGetluXNWujVHmkELb53Qp4zQ4MZs4EVqLcRZNWnM+WdcPTY+hhRu0a4VDuWiePU0mdH9RTvNPNnPI4JqlzsvnEfM7APkmml0gF/oZTs3vvJD2h+GeWzYdmDioPDEPP/BlEGcECSetJxS2LAiF/WM6lk+I6gRiD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954297; c=relaxed/simple;
	bh=Q5z9jBs2d1yqyo4IMVnwiAJJFG2lNWoveJnJYYYb72Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YmOSiUgM28zfmCey596qP4hjC59v75NeI0Ye8geFOnroIKfOMohInEsyCpyg19qae5XhvDqGIJgh7qVu2X+W0T9AYOc6JyJ0RkfCHpUgNzduxM0iEc9ZPaLl17FwLxmlI0X2cjjmpLHgNGCqiub2/PxiNPhS1PUajkNnTCgBSXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=LeuAtfk6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-471810a77c1so2982965e9.2
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 02:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1760954294; x=1761559094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZG2fowO+mJb7smhgnOrt1ejBOQrLnjkFlGvhGFZSD7M=;
        b=LeuAtfk6mVYEAS+ZpNbMSgLIRfzpwZapCvN6bsZljbAGgsEeY6wR0KxKDFGOdGdCDe
         walDQ02TCrvDuFs57gXVQU6Rhqh1BJYVfJdBPF1jVcz5DxbJAAlkVS0jCOAAMvQNAmbF
         DFPZ5/I1uzBy2+fCaqJ4JQvsNIFlDLJD6uaDRE6njkQ3QvYM1KW009BFz1zprDAdn1FX
         7wHnvS+HHWvd8HBMi2xfoVQIZZjRe0lyrnG98cfZzq9Ia4b8NTJ0F+D49KF/lP6rXw8o
         HINJqZIiKvEK+ceHpt/kIkjlJgyIX3boy9B7HKlxSS2u6PT79lkEN6sKcskQ/M8cuiv5
         tosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760954294; x=1761559094;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZG2fowO+mJb7smhgnOrt1ejBOQrLnjkFlGvhGFZSD7M=;
        b=XjOq5j2gxoHiTlMT8/3aANu8HzBTUmzjTgltR0sz19yoyiRI8tW0PShz9KuNq5lJ4K
         534Y8q06xbSYeZAJ0Y8NgiBm+ht5r93BGPXOWwPWVfRLq9WPUXVr87283FK//IjDpJ2F
         EH0ij7j4U8s3+PrA6/+0YTXrY6MhvCem78ARHZRm//hbw2X8sdc1aqgr6PmHouOIfYqa
         ttniTPEk5olLA7p1hUVnN7WdXDmMbEbh/Fvg4Fi3GhNOZGf6N9slnDFDAdzWMwbHAdeL
         ICYFOAjuLOwc0YZ1Gnx1pm4d4yJtjJ/xBy4IXACwSVouKKNZx+ToEJM3rwlzH8zqXyE7
         Oavg==
X-Forwarded-Encrypted: i=1; AJvYcCV3/xR4n1/ILs+SxfXA3rnc7mTucOSGfZ61nRWrqjcZASHX41rtgKRyw1kSqHa0YX62FkC3B5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzNeVm0Orw4Vq1ZGAunCzb2VmzfGZ9ePAJMdSLFgE96Dng0CEO
	zqs82/eizEA73BlwddoS4lF+T5z19EO2BXIIpaz5siwpaamFUCc6xw8/zheC206okuk=
X-Gm-Gg: ASbGncvIejPNoZw+5oqxRm+U5TIqfMPHAnkUmKSIPd19hx26NQmKJg9fLaWKudvYo/s
	cUaAkg6AJdMlLfhB6RSnOYmJrke6THwCrNlO6CDkzMACwMHlUT9YhnERwjppyXgPWWX48wUoy4C
	PiCktC8FN7KuSkkHYXHnDGGQakqpDeoZR6bmqGNgZAfq7/H/9G36TL7oWAGTtVpXhYor61sTh+7
	yrCWUF9g86AgrFakKWVO+YtcXxRhEUL9ZT23LRXGPizU7lTH4D0PlkPNKtriW/EtlKxCvfxfz2Y
	lNSrn+oMawGxmAx++BizmNzMtUCGqFMFoM1EWjPj5Q7z5vd9BbgLzt/+zAbrOniuKlEm8rhOJUm
	bdumpbOkDDk8k/jSL/w1AZ2HrgQxwgChiHQSlqNh2+FlkW2qKPpPYqPLPZcI1Q6u2i/uUKaNiT+
	uDQYx3g8CtNX0Tis91u9979wx83WQ2paiHEQscuK5BUt667hiBSG5th0OKQTeZhSE=
X-Google-Smtp-Source: AGHT+IFYnlyoPCeG/0yM+cJoBbquSFLsYOZxHvb3GvwfNtBapFKQvnIdLtEnmirPV8bFIW5IIdb/nQ==
X-Received: by 2002:a05:600c:3b04:b0:471:12be:744 with SMTP id 5b1f17b1804b1-47117932dd5mr49072285e9.8.1760954294079;
        Mon, 20 Oct 2025 02:58:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47152959b55sm141457455e9.6.2025.10.20.02.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 02:58:13 -0700 (PDT)
Message-ID: <61394377-195d-455c-b782-93f7f9c3072e@6wind.com>
Date: Mon, 20 Oct 2025 11:58:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: Proxy ARP NetNS Awareness
To: Household Cang <canghousehold@aol.com>,
 Vladimir Oltean <olteanv@gmail.com>, Lucas Pereira <lucasvp@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Sylvain Girard <sylvain.girard@se.com>,
 Pascal EBERHARD <pascal.eberhard@se.com>,
 Richard Tresidder <rtresidd@electromag.com.au>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20231218162326.173127-1-romain.gantois@bootlin.com>
 <0351C5C2-FEE2-4AED-84C8-9DCACCE4ED0A@aol.com>
 <20231222123023.voxoxfcckxsz2vce@skbuf>
 <SJ2PR22MB45547404DA1CA10A201B2BE0A294A@SJ2PR22MB4554.namprd22.prod.outlook.com>
 <21658780.3286902.1760684176107@mail.yahoo.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <21658780.3286902.1760684176107@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 17/10/2025 à 08:56, Household Cang a écrit :
> Last light the Linux Librechat was focused on digging the kernel code surrounding /net/ipv4/arp.c and /net/core/net_namespace.c to answer whether the proxy_arp feature enabled by sysctl is namespace aware.
> 
> After many hours of tracing from namespace-generating unshare --net command all the way to the kernel net_namespace.c gave us some clues that the main ns and new ns converged at arp_net_init() in arp.c. And I am currently stuck on this line 1497
> 
> proc_create_net("arp", 0444, net->proc_net, &arp_seq_ops,
>             sizeof(struct neigh_seq_state))
> 
> It is unknown whether this function creates a "view" to the ARP neighbor table such that each netns has a different view to the neighbor table, OR each netns maintains its own neighbor table. Either way, the implication is whether proxy_arp enabled by sysctl is restricted to the current netns.
Each netns maintains its own neighbor tables.
The sysctl proxy_arp is per netns.

Nicolas

> 
> If proxy_arp is retricted to the current netns, then the Debian documentation on wireless bridge-less pseudo-bridge https://wiki.debian.org/BridgeNetworkConnections may be wrong in insinuating that the proxy_arp feature in the modern kernel can replace parprouted userspace program.
> 
> The current documentation with sysctl net-related options are really vague in terms of netns interaction. arp_ignore, arp_announce, arp_filter did not do a good job of disambiguating whether any of these arp features can or cannot work across namespaces, or the reasons for the behavior.
> 
> From the arp_filter option description, this line "IP addresses are owned by the complete host on Linux, not by particular interfaces." is a single-netns statement, but highly suggests that arp operations are per namespace.
> 
> When a virtual ethernet pair is created between two netns, parprouted userspace program can relay arps across namespaces, but the kernel proxy_arp cannot.
> 
> Thank you for any insights and feel free to forward to subject matter experts.
> I really want to get to the bottom of this.
> 
> Lucas
> 


