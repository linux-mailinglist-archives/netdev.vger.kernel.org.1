Return-Path: <netdev+bounces-81180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6B8886737
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 08:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD168B225F3
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 07:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04BA10799;
	Fri, 22 Mar 2024 07:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2NyLWoA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4CA10A1F
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 07:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711090903; cv=none; b=ZmOVE9QRqjg5P0BzYCz/G2l6z0/4tcJJmfc9EL8e757h4M7j9YiNfkhlTIDsAeCwBbglq/c6zIJ/aCJxcTEJTf1KVFarUTxGx56LYXJPS3MoF0DJ6RYKDheLY2MbDwj7NfLC5OjfP4Ki5M8wJ8SDniC5L5DbBuO5upRjA9wbifE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711090903; c=relaxed/simple;
	bh=Dg8FhQt7HgEjDLfzkGBsYmC9DNYjUCTFQnv1Yb1JZBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFRLfBQWw+wQaEIRG36fUCX43ZNLRQFzPTdshv/Jk71m8sxy4j2J/7nUp5VJRNDzrCrBh9J63s6toU7aLW82mUP8WqJE3HCY5lVPbLJu4fPLPWPg0um/rlppGKrTlDHFimrEKj5llF6Iez5UYlYscLm6x54sHo0NdnJs38UkRes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2NyLWoA; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56bdf81706aso539800a12.2
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 00:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711090900; x=1711695700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O4OpwjcQToTCNpXHQ7FHkCTTN56XQi1W2wVVc5RTmDQ=;
        b=m2NyLWoApQLXVdJ+TmlNj2iotX6esplcg1NWNuhMtcCqfPqtfzayaT/0zLrbMu9GJh
         WJkTm4bB7QmIi6gs8d2MkkwoiI+mWLLFWZt6Jgq93wubgIlenl3fdWfyTCfkBP1mT6IJ
         Ky4vTVgX0eEYian7opQZdP29z6iP9WUuvNAaB96e8nXLgX5sEDycl4qFThkEoVNsk5mX
         WFECZo0xriCTjO3kHzp8uFuNk7sEqa/mtp8nv9irA7WOFlBHOzb3U6lDkbmYvRQZUdq+
         8XRK8enaqo54e/EqyB2TWp3Bz2nXldYoSE0lJoBRdFjOGBKxKyMz0UijmKBvyEYHePY6
         yZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711090900; x=1711695700;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4OpwjcQToTCNpXHQ7FHkCTTN56XQi1W2wVVc5RTmDQ=;
        b=K/iwEwj5Z0ikis02f6WHoJRBINeoz5GGnEoVj7qTm3ZsK4QQ99wNCgYae7Bk0pllXq
         pdGaiF4jwdsoSDdfev5LFfpP/mM70d8YbX68bM83Be83WftCgzgiG4gQOmXtQ9CfE22l
         m4n4CE/3ChqqrmVyDJbfdlLzd3ykB0IYZXgMKy8JRPE7Ve8VrV2XYqK/shxm7dOSIgoW
         qCX0PaBPvf2EZeq5K9TGYfB9uLV9UIfLoZYT67BH2AIdRA3WDI4NTFxFkif2f/wlBxyI
         3rViqQ63vMsuEYGAZEVyr5tZTqknMK0ollLP8Bhcnup6XKB/6bTYT+VSHT+oiAVf/fdg
         gKfA==
X-Gm-Message-State: AOJu0Yw+JMHrobchg4pyOFHTmzKfBDyh5ErXn7QDEo5RNtLNywSqh4CI
	VlmI4UJ5aI/C4j/lDfH0TcUdbg0xmcmUwWux0pvEf5SBjGQFYzYn
X-Google-Smtp-Source: AGHT+IGlzoBUPrOKRIgk0jlz3YAb24Svyx96xuC7ecyXPZOzKZlTq2vwRUCHho8Fje9zBuEAasn1YA==
X-Received: by 2002:a50:cd1c:0:b0:56b:6ec6:af2f with SMTP id z28-20020a50cd1c000000b0056b6ec6af2fmr897720edi.6.1711090900007;
        Fri, 22 Mar 2024 00:01:40 -0700 (PDT)
Received: from ?IPV6:2a01:c23:b9ee:2200:348a:f751:f261:95e1? (dynamic-2a01-0c23-b9ee-2200-348a-f751-f261-95e1.c23.pool.telefonica.de. [2a01:c23:b9ee:2200:348a:f751:f261:95e1])
        by smtp.googlemail.com with ESMTPSA id 11-20020a0564021f4b00b0056bdf694890sm507196edz.43.2024.03.22.00.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 00:01:39 -0700 (PDT)
Message-ID: <50974cc4-ca03-465c-8c3d-a9d78ee448ed@gmail.com>
Date: Fri, 22 Mar 2024 08:01:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] r8169: skip DASH fw status checks when DASH is disabled
To: pseudoc <atlas.yu@canonical.com>, nic_swsd@realtek.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ChunHao Lin <hau@realtek.com>
Cc: netdev@vger.kernel.org
References: <20240322034617.23742-1-atlas.yu@canonical.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20240322034617.23742-1-atlas.yu@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.03.2024 04:46, pseudoc wrote:
> On devices that support DASH, the current code in the "rtl_loop_wait" function
> raises false alarms when DASH is disabled. This occurs because the function
> attempts to wait for the DASH firmware to be ready, even though it's not
> relevant in this case.
> 

To me this seems to be somewhat in conflict with the commit message of the
original change. There's a statement that DASH firmware may influence driver
behavior even if DASH is disabled.
I think we have to consider three cases in the driver:
1. DASH enabled (implies firmware is present)
2. DASH disabled (firmware present)
3. DASH disabled (no firmware)

I assume your change is for case 3.

Is there a way to detect firmware presence on driver load?

> r8169 0000:0c:00.0 eth0: RTL8168ep/8111ep, 38:7c:76:49:08:d9, XID 502, IRQ 86
> r8169 0000:0c:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
> r8169 0000:0c:00.0 eth0: DASH disabled
> ...
> r8169 0000:0c:00.0 eth0: rtl_ep_ocp_read_cond == 0 (loop: 30, delay: 10000).
> 
> This patch modifies the driver start/stop functions to skip checking the DASH
> firmware status when DASH is explicitly disabled. This prevents unnecessary
> delays and false alarms.
> 
> The patch has been tested on several ThinkStation P8/PX workstations.
> 
> Fixes: 0ab0c45d8aae ("r8169: add handling DASH when DASH is disabled")

SoB is missing

> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 5c879a5c86d7..a39520a3f41d 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -1317,6 +1317,8 @@ static void rtl8168ep_stop_cmac(struct rtl8169_private *tp)
>  static void rtl8168dp_driver_start(struct rtl8169_private *tp)
>  {
>  	r8168dp_oob_notify(tp, OOB_CMD_DRIVER_START);
> +	if (!tp->dash_enabled)
> +		return;
>  	rtl_loop_wait_high(tp, &rtl_dp_ocp_read_cond, 10000, 10);
>  }
>  
> @@ -1324,6 +1326,8 @@ static void rtl8168ep_driver_start(struct rtl8169_private *tp)
>  {
>  	r8168ep_ocp_write(tp, 0x01, 0x180, OOB_CMD_DRIVER_START);
>  	r8168ep_ocp_write(tp, 0x01, 0x30, r8168ep_ocp_read(tp, 0x30) | 0x01);
> +	if (!tp->dash_enabled)
> +		return;
>  	rtl_loop_wait_high(tp, &rtl_ep_ocp_read_cond, 10000, 30);
>  }
>  
> @@ -1338,6 +1342,8 @@ static void rtl8168_driver_start(struct rtl8169_private *tp)
>  static void rtl8168dp_driver_stop(struct rtl8169_private *tp)
>  {
>  	r8168dp_oob_notify(tp, OOB_CMD_DRIVER_STOP);
> +	if (!tp->dash_enabled)
> +		return;
>  	rtl_loop_wait_low(tp, &rtl_dp_ocp_read_cond, 10000, 10);
>  }
>  
> @@ -1346,6 +1352,8 @@ static void rtl8168ep_driver_stop(struct rtl8169_private *tp)
>  	rtl8168ep_stop_cmac(tp);
>  	r8168ep_ocp_write(tp, 0x01, 0x180, OOB_CMD_DRIVER_STOP);
>  	r8168ep_ocp_write(tp, 0x01, 0x30, r8168ep_ocp_read(tp, 0x30) | 0x01);
> +	if (!tp->dash_enabled)
> +		return;
>  	rtl_loop_wait_low(tp, &rtl_ep_ocp_read_cond, 10000, 10);
>  }
>  


