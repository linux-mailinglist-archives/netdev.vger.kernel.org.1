Return-Path: <netdev+bounces-248490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E9225D09FFD
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 13:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2F1530E476F
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 12:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9739933C53A;
	Fri,  9 Jan 2026 12:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="ItA+EMb9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EF2336EDA
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 12:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962147; cv=none; b=tfVdkn+Vs9K/B/QMtSJuBhW+LOM2CIwz/J+I8rFgQxzUDzyWzSyqkqAteLjlQC8kJR4rhjTNrAMo7ElvABzy/KO70n1sFrsOMHc/EIILBjGQ9kyf1vKJQROpFq0UvNqPHCFuj8Xnv0LZ6yx0omuJ74zpiLcn07DZFtPYXbiPhpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962147; c=relaxed/simple;
	bh=DDzuXc3q1Tz0WvFP6x9HQpJ8rU+Z/fWcqzCh0muALuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ENFLOGNVQ+wQs7ObgZrqFhFJkUPlcySFv9f3JqV+E8ZZ9rzu5RYZ/CKlklKknqtT07wmUvJzGRX+KurSJMCqRv3VRguwUFVEVeWVXPgFwmr6v1ysM25YK0KOoENqjytSYJBQ6kpKU9ikC6GSQ2HOlM0XltZEdEW8a8QgZbVWqpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=ItA+EMb9; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b7a72874af1so773082066b.3
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 04:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1767962144; x=1768566944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OvOuPMMiAx1s7+V+l8xKqTUgjaDGQGTF5xyeJ50K4T4=;
        b=ItA+EMb9Hl8kK8c0T8kOtl7yWTCpmnNOoLRpwU1F9axi8Qo2VHvurkz6Kr4ZSgFsbV
         P+m3BLfb7ppOjGyQTXnlHUdrKupmmP6vZyVZejxrQcAIoZCSChswaG751uyfSOcpo7Hg
         anVaawwNJpFBvbRepXMOpKBeds/gDA4ObWit0rAYCGRKfruosCuQzYU7+94rAv8NH8xU
         HVDY9YXBAb22UHlE3WUdUJ17ah1oiQQqqY0kEBp1ktS5YavytBTAnRbXjr+1dAma9Qzl
         89cg/Ya15C5eMoGm0l5djgoohkPdUqurQPz4wemPAmlmqIviOkypqsawivrPnb1FTTvG
         BJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767962144; x=1768566944;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OvOuPMMiAx1s7+V+l8xKqTUgjaDGQGTF5xyeJ50K4T4=;
        b=kefBIKwwtFt7SVFTKWsEO9J8cHwsxGV7aAV3c+MNXlhCfVjrskyS11xuZTUBqzWwfk
         QOryZlxNrA00huyyHsIDojog16t2EsLvrd/mDj8Tn/l/ALNzD//WRF5FUDPXd9YgRX0M
         lh0HsivudFO+6VvcV1Xo7B57BHzJyDj+r6in5an/CUb6p1rCasK4wwmGaE1MiE+BZEwQ
         ZNTSupR7FP0CaWcRHTSJAuoL5aBCpAJQnBOwsvyiyM2iFi2IkzcMy+ZQqPnrTDPzQIeN
         6kIWoeqHp9dyJXPmhNcnVMkxOQb7XGdER0bYjYFzupowT6Xf/HwJiO55Jneo+Ybag+Ss
         hW9A==
X-Forwarded-Encrypted: i=1; AJvYcCUHi9u4lY1vEPCSWHuSzNG3GW3plDgJ9XZ/hbj4qH5Cj6wqfj8y/yX4DN0FFYj6t+jBcK2J+Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGSfo6VggCV0FtsH8zcr+PlUMMQObfpza+d4wavQpO2rWXC5/R
	uU+7hvkT6nIWCMaLxe436gEznZGtdraMz3TKmrq45+RKVlhOFkKGbRLriDdrhpxjHk52WL050V7
	+Ja5w
X-Gm-Gg: AY/fxX4DB8C9OUcpJZtWZTl/BfNhqJGYC2/FDnSsC+PoPM3+NyRWYY/3KGrarzWIn2X
	XaUcVrQQzt9qPU42zOPrbfifi0SyEVuIovb8KaeAjLBMOyS0HtFzhOJDOUwPKuofzcgThNMQSXC
	KAHwaF5sDNBZU+rveguA53+LZAPVzD5hUEeeR5kPmBByQjB680PGpfp/2wmXSXMAaaS5Q1em4xb
	16Q9u1gASkmkp+9KrMlV1vRE1ZTS4ISrB5eXCg3WdBDsWUvu3p+DjVbixWMur5FBA6cLBc5usVL
	iXY2pKqIsMZawwl83IuTlEjBlGPLAWNRWIzC8mYAszny6+ccU2TIZIZtAN9tIg+5OZvGjhIjqGx
	tD95SaJ7qSTFHYJBF52hvVeI8auolBUlBzfBrIaFpWR791Kf5LYJmQWuXHJYmdEdzc8CHw4q866
	xsm9LMZIx+EfrHS4TeR1PxPuxn1m3uGgpYX7leNtTyxkyUW/epGyHEm/eglrcCwV07oyEC1w==
X-Google-Smtp-Source: AGHT+IG8TQGDznAg3o3Qxai11yd1QN0mIrhsIx0cgYi0t54RtVRUe0zv2z5wnMmm2ZiszHAs0SE4xw==
X-Received: by 2002:a17:907:a06:b0:b83:32b7:21b0 with SMTP id a640c23a62f3a-b8444c98cf3mr872414766b.17.1767962143988;
        Fri, 09 Jan 2026 04:35:43 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a230db0sm1118762766b.2.2026.01.09.04.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 04:35:43 -0800 (PST)
Message-ID: <b070f4f6-e81b-4674-954b-609ad17f1cda@blackwall.org>
Date: Fri, 9 Jan 2026 14:35:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next v2 2/5] net: thunderbolt: Allow changing
 MTU of the device
To: Mika Westerberg <mika.westerberg@linux.intel.com>, netdev@vger.kernel.org
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>, Ian MacDonald
 <ian@netstatz.com>, Salvatore Bonaccorso <carnil@debian.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jay Vosburgh <jv@jvosburgh.net>, Simon Horman <horms@kernel.org>
References: <20260109122606.3586895-1-mika.westerberg@linux.intel.com>
 <20260109122606.3586895-3-mika.westerberg@linux.intel.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260109122606.3586895-3-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/01/2026 14:26, Mika Westerberg wrote:
> In some cases it is useful to be able to use different MTU than the
> default one. Especially when dealing against non-Linux networking stack.
> For this reason add possibility to change the MTU of the device.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>   drivers/net/thunderbolt/main.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
> index 57b226afeb84..20bac55a3e20 100644
> --- a/drivers/net/thunderbolt/main.c
> +++ b/drivers/net/thunderbolt/main.c
> @@ -1257,12 +1257,23 @@ static void tbnet_get_stats64(struct net_device *dev,
>   	stats->rx_missed_errors = net->stats.rx_missed_errors;
>   }
>   
> +static int tbnet_change_mtu(struct net_device *dev, int new_mtu)
> +{
> +	/* Keep the MTU within supported range */
> +	if (new_mtu < 68 || new_mtu > (TBNET_MAX_MTU - ETH_HLEN))
> +		return -EINVAL;
> +
> +	dev->mtu = new_mtu;
> +	return 0;
> +}
> +
>   static const struct net_device_ops tbnet_netdev_ops = {
>   	.ndo_open = tbnet_open,
>   	.ndo_stop = tbnet_stop,
>   	.ndo_start_xmit = tbnet_start_xmit,
>   	.ndo_set_mac_address = eth_mac_addr,
>   	.ndo_get_stats64 = tbnet_get_stats64,
> +	.ndo_change_mtu	= tbnet_change_mtu,
>   };
>   
>   static void tbnet_generate_mac(struct net_device *dev)

You can use struct net_device's min/max_mtu instead of a custom 
ndo_change_mtu.
They will be validated by dev_validate_mtu().

Cheers,
  Nik



