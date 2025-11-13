Return-Path: <netdev+bounces-238320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC588C573E7
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894C63A48DD
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4733337BB5;
	Thu, 13 Nov 2025 11:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKYoIPe+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="F3U0yLAl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1094D27B34E
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 11:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033900; cv=none; b=P4EaFT8+Kg+/yq/qYhdtbfKE6BH2AuiBD9ODDOyAqy/5PBWINhrH4k7O3LPRpIP0B0jfpWZkhtFY/sbp1PlCrYIuIfsSZTspqhQVQEDIdDI9/EwdYhP4BItEJoY3uReCBthdm5HwhgsiA7TRxmFEyLu7fFWLTA4242SjWnU2tkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033900; c=relaxed/simple;
	bh=Pm9l86aVoXbyC3LVoUNlqZ2S5nSTtFLy3SJecOO+0o4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HpSCTBm7WWUymKef3nyD5U2YBgF+dOM8Azj9gFb2mdYVBSyNA7WKwy+MPRKzNYXKxkC7jkNAIlL8llUPbalstXe5rlAKs52R8moHdUzTBHiaqBRPYQTCO6j/3JshJTg4SxXJphOZQPdb7VRTfTwpiV6lzQVRFSP2WUskNNoy3cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZKYoIPe+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=F3U0yLAl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763033897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MHxO2BrOWyHTXIMfNUmqV/Mty139oF6xYTyw1GhIrkA=;
	b=ZKYoIPe+BFl5hIVflRM/+GZNJ+UPBvwsxNv9D7cjlr6Ry3R5BFjtJmWsqmeGAtS/F5dJir
	G1EOgvjIMFJYSO8Dag9qzXU5axh2iW6jzRuxQqTlxHkF8r71F/krL779IjuEFwhV0KMXnU
	u8nUAkl3U7VcePLjl0zjh/HKZSqHQP8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-5jHXlV57MAW-C2_ESvjyQg-1; Thu, 13 Nov 2025 06:38:16 -0500
X-MC-Unique: 5jHXlV57MAW-C2_ESvjyQg-1
X-Mimecast-MFC-AGG-ID: 5jHXlV57MAW-C2_ESvjyQg_1763033895
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-475e032d81bso4242425e9.3
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 03:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763033895; x=1763638695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MHxO2BrOWyHTXIMfNUmqV/Mty139oF6xYTyw1GhIrkA=;
        b=F3U0yLAlZrzsFDo9ghLfyfGpnr+A4lBkH94987/Yfs2uQawo91q0Tc9oVeye7HsQeK
         Wct12LB4sQi4KftYr+TkmOBayeM4R9yqgJuZHJZwT0aMdfSPUS9DOE25Qj6cVpm65APa
         mtD1zghNfsMJhqUpZKaGnOqIR6bhGAlP/Sa6juDeUspQcr+6R+Nbtj/oaUdUAQE6t/lz
         pVwIXNZa1MPrOXeN/HoUjf5/lKNs8EMitrreQbyPgxTUs3HbLycfiaCMEKxh0/aA1Ioq
         aXHl9/SGB7wi2rDU24XJi/2K6m0ZHa9zy21sBDQGPiQZywNnXxnaWGs1fGeN1jv9pw96
         KJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763033895; x=1763638695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MHxO2BrOWyHTXIMfNUmqV/Mty139oF6xYTyw1GhIrkA=;
        b=Vb+BGy2laz4ewh/B4YZj/ZPMxHWNUZU/0ll4XgQOtksw6HixejHJhjcUFnkSUTnU2w
         tgzFtJNJZG3r+XXuKmvUAxe5z1fA8aE50EVKRzbzC/f3YwHcH7lY3gVoJHbgWbiqaHDZ
         awKlYcLbV3mwMnF5rS7YtFRzF6h08DJAjUAwB+CXA9s7a7pTR4CHXF1bcBJsZ+rhM+gt
         Frb4MQwsCB8Pkd6p85gbQeXivBPGHZ1FLOorZM3cJ6uzylok65kSGObCif6YMtAsks0j
         ozGRvwN+0DDghyTC40a+w7bcbYZzrFXfUBUiLzK5A1UuwfAuCpeSN3ufl9D22Hqo68MY
         aczA==
X-Forwarded-Encrypted: i=1; AJvYcCVxZDiq6GH3JL1Qa6qcbHgCZfWp5YOSTBDnZRDGVPPlZiwEsGlUis0XJ2kPAJ3arDQFClHWW24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz49QV90t6tUvNIPwGq8dpaqmxTiaKEzlecimBARN//wHiiizuQ
	X0f41YEQIpcr+zHOtVWIlUyXUqFzUzYZNIbExXX3LX0j/SjmZjE+iIGU4IsQ9XqsC1ebxEbVJGj
	u+7UX9xMJ7D12B4HV9TEjQyGRjnHl1i/nEmGljZ8ZW92CvFC6uEA9erFo6w==
X-Gm-Gg: ASbGncvXNKrce7MLI8bey55eHFEd46ftswT10cgl6jojGddYywD7ZRb3l2BjbCpnC0J
	Hove1FsiNcIn6Pybr/NV5iJZnuykMDqH8Dl9De24F9O8a4kLLm1nA8VDanaOooKs+HXrEvtn4he
	wc3A6yf8cgO5WDLzZL6npYkEYW8v2bvbbitww1kQfhuXfZ0eJPymScTkylMw5Dm+zzP8Pe7zMVb
	n5Mdqe5ja7VWVdg1GTqhVpwwLdrX0d0pxJRHF0EzMNhi6sVCTkRgQBfneKKcC2ThKzZF+yNjSLU
	jcKst31qwW460suCjaPTosvBAN/0fUBsFBpmqJqRas4xHmoBnEqcJYTQYxq8eKfSVRdpn5cAwxx
	fAsRWbGOtuCKM
X-Received: by 2002:a05:600c:4593:b0:475:dd7f:f6cd with SMTP id 5b1f17b1804b1-477870b92f6mr62489215e9.35.1763033895416;
        Thu, 13 Nov 2025 03:38:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqibAeC+wJMoX0xryKgrYRi/EQVzzHpY8hZdvijoDFG66NmayYcdxhZkGs0YgOU+Yjg5XJCA==
X-Received: by 2002:a05:600c:4593:b0:475:dd7f:f6cd with SMTP id 5b1f17b1804b1-477870b92f6mr62488765e9.35.1763033895021;
        Thu, 13 Nov 2025 03:38:15 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778c856c95sm30970745e9.7.2025.11.13.03.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 03:38:14 -0800 (PST)
Message-ID: <987c6e54-992e-4074-b46a-b0a3e3aff874@redhat.com>
Date: Thu, 13 Nov 2025 12:38:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 3/5] eea: probe the netdevice and create
 adminq
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Vivian Wang <wangruikang@iscas.ac.cn>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Dust Li <dust.li@linux.alibaba.com>
References: <20251110114648.8972-1-xuanzhuo@linux.alibaba.com>
 <20251110114648.8972-4-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251110114648.8972-4-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/25 12:46 PM, Xuan Zhuo wrote:
> +static int eea_netdev_init_features(struct net_device *netdev,
> +				    struct eea_net *enet,
> +				    struct eea_device *edev)
> +{
> +	struct eea_aq_cfg *cfg;
> +	int err;
> +	u32 mtu;
> +
> +	cfg = kmalloc(sizeof(*cfg), GFP_KERNEL);
> +	if (!cfg)
> +		return -ENOMEM;
> +
> +	err = eea_adminq_query_cfg(enet, cfg);
> +	if (err)
> +		goto err_free;
> +
> +	mtu = le16_to_cpu(cfg->mtu);
> +	if (mtu < ETH_MIN_MTU) {
> +		dev_err(edev->dma_dev, "The device gave us an invalid MTU. Here we can only exit the initialization. %d < %d",

Minor nit: missing trailing '\n'.

/P


