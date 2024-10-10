Return-Path: <netdev+bounces-134402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AE3999357
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 22:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1EEF1C20F79
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 20:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49901CEAD8;
	Thu, 10 Oct 2024 20:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYCKTvji"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C13E188A08
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 20:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728590886; cv=none; b=nP5EkBrWS0v6BXbBYwJROFDRRSsaPz8hOghahKoxM76b1aS63khVA4TKHoQ2fT3lQWrKrozo+8LCCgCpirCw+1Tg4LpQytm+pyStGwoCHiVRDYIVNAeSSm7VjMnpuP6oaXYytMihbzrNBXUosvk/yYLZ3jI1DTb2E18noB2ezHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728590886; c=relaxed/simple;
	bh=q1Dbxy2oSJz+fI5Eq3EIbME3PNazC9b6hZf46TNWfUo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dwogs9q5z0ZObfokHuuZfLCZsWvI+SAwG9T/swwaA/qwx4JRgjLYpQ8UxgD1EWG+YFrFDEfJsL020GuBwViEz/WCkY7t4flnQ0zp0+kL3c/cFUPnYKsScJz6fImeeC6SPwnr8abPSJTRIaP3WP1WYS4CTn0tzRHw1+EqHPUse8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYCKTvji; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c924667851so1588162a12.3
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 13:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728590883; x=1729195683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9uKypuGUrFMAV96E6Fg8fBL+I6FVZam4/4rBokIhdkg=;
        b=bYCKTvjiH6+PA+IGVyY/tTPdIuz4MDkFFM3jNRSBRJDCrigK8OuDuq6dRhuVQbiCp9
         HbI7s+LDv4OncTMI/orssmnB0D2GGW1nRodFGhJdVHdsmYMQ+0Cok174XnOuFbMkuiNJ
         LnupIxYXH4CzlQD/3tNtkL0mEZUQs/6YGCP+Q3RrMuQ/2R6V1awJrsfoFb3O5yw04LDR
         bxpPCMWdUdnrV7n/pJJbShqimRNATy0BDn0gAFWuQxPntlOHz4XVkHpRSw7QPg690jpM
         V/4L9S8twVDZj1M48Vo0TFONJXHL/ihyYC3PyM+eGCmD2P47cv7wDbYeDx0bOct8i3tV
         uM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728590883; x=1729195683;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9uKypuGUrFMAV96E6Fg8fBL+I6FVZam4/4rBokIhdkg=;
        b=t1gt+CtkrgJD5bUFEGP9RxJTpMeQqAqkd9unSdZuDbXnLoVV9myjh0BImkExXaZd99
         QkpghVh0xj9M/BkPewAs9R64Aw+kOvNGzFJ4fx3vtzhbiFfnjSvao4msz1cY+FT34CSM
         x+NMPgEqCQT3bELkIRKcPKHJH43WGyF512a/KfN2uTd/I83gT5zMOH2hTsctFd7fhxjB
         DRlFE+KpMz0BlKhJycSmHGt/6JhhaPaKNIzauOLseB5g/418gmUjbSGNXDf67K9xPIT2
         HAWkDntR78HErTJbLNG1PwA/6sGIHFrzbIJtarKRPkI9R1zK4dVdza96aSzpJOvX6jg8
         NHMQ==
X-Gm-Message-State: AOJu0Yx27kHIk11WnKHMe5mZX0075bBZrvlaCnC5l45ow6zIay3bCxQd
	2xxGaERz7/VqgTlpaxYPej2RzcHt8yaJYy6LrO3DaoAIc+jarJlP
X-Google-Smtp-Source: AGHT+IEu92E+uJEnjS0mMOj4ncZZp6fuOwxIy7JNwBWbIKdKlatcgQOPlQc1IVGJ6eOIA/YMTBMKsw==
X-Received: by 2002:a17:907:97cd:b0:a8d:4631:83a9 with SMTP id a640c23a62f3a-a99b9307049mr15006566b.3.1728590882999;
        Thu, 10 Oct 2024 13:08:02 -0700 (PDT)
Received: from ?IPV6:2a02:3100:ac3e:8500:8533:85c:8e6e:f61b? (dynamic-2a02-3100-ac3e-8500-8533-085c-8e6e-f61b.310.pool.telefonica.de. [2a02:3100:ac3e:8500:8533:85c:8e6e:f61b])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a99a80f2187sm130525566b.201.2024.10.10.13.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 13:08:02 -0700 (PDT)
Message-ID: <30edd5d2-13aa-409f-9b12-f0c775c81f02@gmail.com>
Date: Thu, 10 Oct 2024 22:08:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] r8169: use the extended tally counter
 available from RTL8125
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <43b100c5-9d53-46eb-bee0-940ab948722a@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <43b100c5-9d53-46eb-bee0-940ab948722a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10.10.2024 12:50, Heiner Kallweit wrote:
> The new hw stat fields partially duplicate existing fields, but with a
> larger field size now. Use these new fields to reduce the risk of
> overflows. In addition add support for relevant new fields which are
> available from RTL8125 only.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - added code for enabling the extended tally counter
> - included relevant new fields 
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 40 ++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 665105430..71339910b 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -1777,11 +1777,26 @@ static const char rtl8169_gstrings[][ETH_GSTRING_LEN] = {
>  	"tx_underrun",
>  };
>  
> +static const char rtl8125_gstrings[][ETH_GSTRING_LEN] = {
> +	"tx_bytes",
> +	"rx_bytes",
> +	"tx_pause_on",
> +	"tx_pause_off",
> +	"rx_pause_on",
> +	"rx_pause_off",
> +};
> +
>  static int rtl8169_get_sset_count(struct net_device *dev, int sset)
>  {
>  	switch (sset) {
>  	case ETH_SS_STATS:
> -		return ARRAY_SIZE(rtl8169_gstrings);
> +		struct rtl8169_private *tp = netdev_priv(dev);
> +
> +		if (rtl_is_8125(tp))
> +			return ARRAY_SIZE(rtl8169_gstrings) +
> +			       ARRAY_SIZE(rtl8125_gstrings);
> +		else
> +			return ARRAY_SIZE(rtl8169_gstrings);
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -1873,13 +1888,33 @@ static void rtl8169_get_ethtool_stats(struct net_device *dev,
>  	data[10] = le32_to_cpu(counters->rx_multicast);
>  	data[11] = le16_to_cpu(counters->tx_aborted);
>  	data[12] = le16_to_cpu(counters->tx_underrun);
> +
> +	if (rtl_is_8125(tp)) {
> +		data[5] = le32_to_cpu(counters->align_errors32);
> +		data[10] = le64_to_cpu(counters->rx_multicast64);
> +		data[11] = le32_to_cpu(counters->tx_aborted32);
> +		data[12] = le32_to_cpu(counters->tx_underrun32);
> +
> +		data[13] = le64_to_cpu(counters->tx_octets);
> +		data[14] = le64_to_cpu(counters->rx_octets);
> +		data[15] = le32_to_cpu(counters->tx_pause_on);
> +		data[16] = le32_to_cpu(counters->tx_pause_off);
> +		data[17] = le32_to_cpu(counters->rx_pause_on);
> +		data[18] = le32_to_cpu(counters->rx_pause_off);
> +	}
>  }
>  
>  static void rtl8169_get_strings(struct net_device *dev, u32 stringset, u8 *data)
>  {
>  	switch(stringset) {
>  	case ETH_SS_STATS:
> +		struct rtl8169_private *tp = netdev_priv(dev);

patchwork lists the following warning for a clang build:
warning: label followed by a declaration is a C23 extension [-Wc23-extensions]

gcc 14.2.1 however had no problem with this code, and also checkpatch didn't
complain. Is this code acceptable or should it be changed?


