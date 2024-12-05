Return-Path: <netdev+bounces-149315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA7F9E51AB
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41676283352
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 09:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8AE1D8DE8;
	Thu,  5 Dec 2024 09:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AE3yLg/O"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD971D63D4
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 09:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733392063; cv=none; b=jJBy2200GEs25/bfJ54UKpofLowsw8e+8pDm2FoUdfRM1rdqgImR59hs7bCwW09K/N4Jpb5gWsGEK28c7puGjLiZHJRdqIanaTco9uqhkzl10Kjs2a/W/xdkYVVBbrayfQMnTHu/Dx3itFN/zQ1I5Dm/xMRgv6QxDl6We6z/4KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733392063; c=relaxed/simple;
	bh=wjEAfD6wcnNghAmHkwrxJtWCztMHJQ8MKYIBzuIGluE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=r4tJkkzCN9WZi1XMvqtZS+KUwz/EJ+YDVwHmqcKVKYkKrKv/ze1xwz6vhMjv+Eb9IU8KvO38Fjjv0NB5Er+nTXCzpVKUzxUD2+3muaqoKvM5L8jIu1k+jJ7lqXVh6I+5cegjg1v2vHvfRO42vylx9wEQMD8v3RkOq/xGI6rYnSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=unknown smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AE3yLg/O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733392046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JWUkSRUIv2Qev94E+Vreya1sHRnnDj7AgHzjxrRejBo=;
	b=AE3yLg/O067gikBq2QgxFwwaCrBVRCiuD09P4yYEh61aBSTqC/cVpPm38mtwGl8XcMZmpB
	ka5ssGF/8vDuIwYN0vPZCTsiZQ0sGspDj2jHSgUc9A60ZlyDCxACLjf/9qL2A7jHlgcjde
	REonefU09l1RmjYhr6yI6t2ZsXorTsI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-eKLc8WoGM_e0dtvtyGmiWQ-1; Thu, 05 Dec 2024 04:47:25 -0500
X-MC-Unique: eKLc8WoGM_e0dtvtyGmiWQ-1
X-Mimecast-MFC-AGG-ID: eKLc8WoGM_e0dtvtyGmiWQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385df115300so461334f8f.2
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 01:47:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733392044; x=1733996844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JWUkSRUIv2Qev94E+Vreya1sHRnnDj7AgHzjxrRejBo=;
        b=N9omG/LvXt4J+7W/2EuqpIkuP+DIBxv1knfZmwVi+Ug+zfakqodn/Y9iiJZMNaWMMH
         /guYczVTT72/OCJj7B5Nvu7o8aUFohzWwL4e9Au3DB2z1k8HQJnEW7Wfu5iPe8b8yk7l
         ZVE71T24/fVRSTvoxRK6Qsn89bGNcR2urQou9ao4m0r3hO5rAHEV/ihMjFowvJ9LPzYL
         NkCBcoVkbaSCdAwkVAkQ5fEzWCJUsJ11n4iudXpQjZHV5DZFR+N2YLJ7gzSEwtaFUVuk
         vQStUj6ZbzTy+EurmkjvS/VYFxq4q6StyAKYydcgStwWyJuiJc9XCS0XEcIcpBvtVgSF
         V+lg==
X-Forwarded-Encrypted: i=1; AJvYcCW/Bh/UYPWyZkNgwICwwVAlUgY4w6Enel4Jdfc2vtQ555VSSfg6ZiXlwNr5G/VvqeOdsZ6SboU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL0k+PBArMxNyPz7BQvPjQaZE7IH4VCKQfEu1fSedFfPhe6jDr
	h6r43Xr/lWwAH6x1y2Yy9DPpFb67YkOLhP3z1y9d/t9BT/qlhCLYY25JYhZrUm4pXNpyaqcUFfK
	xSRGK7wZ/TCB6FVy77jUNipgEKH4EVS0XJdfsbYvvMQCey/DWulDBWA==
X-Gm-Gg: ASbGncuulWUGg6nMf/udunYdNfVKGq2IE3GWNhdWBBTLUBAUutRN9jO5cD3UZ053Xwg
	Ot7QtAwtacLfDcZX1uf2et4uRdVUbmlUVaJyUcqWBsfe6AVlBbqdRWAU3zqTgSl9pEz/PfjLATe
	Yx8HxF1WsugAHayHy0Hov+XL3zI06nisox3ERmA5/N1x4gdd8+L+R6VMMFksoptKGl+j6g0AenF
	Cegx6agP4m9yszmIljMYg0GHhFV46ZAhD9wF58D0PaNx0ZmgVi4b9IX0cx/sBzQlSxkK6J0KGRG
X-Received: by 2002:a05:6000:2b05:b0:385:ee59:4508 with SMTP id ffacd0b85a97d-385fd3f8e35mr5666649f8f.15.1733392043739;
        Thu, 05 Dec 2024 01:47:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3Mp3k22VB7mLeM0ZR6NDs+ALbdZOCqmImOdXeOZGVFr6niHrWzqW/fDZVe8P+oBZgYroXpA==
X-Received: by 2002:a05:6000:2b05:b0:385:ee59:4508 with SMTP id ffacd0b85a97d-385fd3f8e35mr5666635f8f.15.1733392043282;
        Thu, 05 Dec 2024 01:47:23 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861ecf446esm1462734f8f.20.2024.12.05.01.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 01:47:22 -0800 (PST)
Message-ID: <ec73fe36-978b-4e3a-a5de-5aafb54af9a8@redhat.com>
Date: Thu, 5 Dec 2024 10:47:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/5] net: phy: microchip_ptp : Add ptp library
 for Microchip phys
To: Divya Koppera <divya.koppera@microchip.com>, andrew@lunn.ch,
 arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, richardcochran@gmail.com,
 vadim.fedorenko@linux.dev
References: <20241203085248.14575-1-divya.koppera@microchip.com>
 <20241203085248.14575-3-divya.koppera@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241203085248.14575-3-divya.koppera@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/24 09:52, Divya Koppera wrote:
> +struct mchp_ptp_clock *mchp_ptp_probe(struct phy_device *phydev, u8 mmd,
> +				      u16 clk_base_addr, u16 port_base_addr)
> +{
> +	struct mchp_ptp_clock *clock;
> +	int rc;
> +
> +	clock = devm_kzalloc(&phydev->mdio.dev, sizeof(*clock), GFP_KERNEL);
> +	if (!clock)
> +		return ERR_PTR(-ENOMEM);
> +
> +	clock->port_base_addr	= port_base_addr;
> +	clock->clk_base_addr	= clk_base_addr;
> +	clock->mmd		= mmd;
> +
> +	/* Register PTP clock */
> +	clock->caps.owner          = THIS_MODULE;
> +	snprintf(clock->caps.name, 30, "%s", phydev->drv->name);
> +	clock->caps.max_adj        = MCHP_PTP_MAX_ADJ;
> +	clock->caps.n_ext_ts       = 0;
> +	clock->caps.pps            = 0;
> +	clock->caps.adjfine        = mchp_ptp_ltc_adjfine;
> +	clock->caps.adjtime        = mchp_ptp_ltc_adjtime;
> +	clock->caps.gettime64      = mchp_ptp_ltc_gettime64;
> +	clock->caps.settime64      = mchp_ptp_ltc_settime64;
> +	clock->ptp_clock = ptp_clock_register(&clock->caps,
> +					      &phydev->mdio.dev);
> +	if (IS_ERR(clock->ptp_clock))
> +		return ERR_PTR(-EINVAL);
> +
> +	/* Initialize the SW */
> +	skb_queue_head_init(&clock->tx_queue);
> +	skb_queue_head_init(&clock->rx_queue);
> +	INIT_LIST_HEAD(&clock->rx_ts_list);
> +	spin_lock_init(&clock->rx_ts_lock);
> +	mutex_init(&clock->ptp_lock);

The s/w initialization is completed after successfully registering the
new ptp clock, is that safe? It looks like it may race with ptp callbacks.

Cheers,

Paolo


