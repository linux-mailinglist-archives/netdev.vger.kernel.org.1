Return-Path: <netdev+bounces-81194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D7D886812
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 09:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110641C21526
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 08:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0C916428;
	Fri, 22 Mar 2024 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="nVJlp8GX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8702C168D9
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 08:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711095417; cv=none; b=b8821jT89rA18oXEqxlup69SktWexZbo8aDxQrWeH6m1Gcs62k2GjhqfW9aHCg6teaq18O4gvV85JiqOl7fDUjQb01Sg2FtQ06djLzpVWkqwhRsF+KA+nO8wVRdEYHA+tQKm+Eis4aVo3Pe7aRQyewbpPIQX7RfGj5IlF5scjSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711095417; c=relaxed/simple;
	bh=l39Kzwhk2oCmpGaik1tRTMAeTUKSMINYVASXw+4omn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5Qyf2u7DSnJyVsZchmpJDoywYaKielH/zfkUZ5X4MIX8XrzuuAjWykJnTmA8uI6GMyanyNcHCJtVKtuIqtRHhrMV5NssYgntrXoAbUBoN7PzXEvbRkknUu9/2IAsHN1CBfSumojCRbjYsBEDqsuVMh8tn5fNSXYrNTqoQWrM/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=nVJlp8GX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41464711dc8so15069485e9.1
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 01:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1711095413; x=1711700213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PB54NDFUedyRI5XOiQhGkPf9QFhhfzoP+DfSevmI9uw=;
        b=nVJlp8GX/afjxt1ANEJLgJDBsE/0qpg9uq2o1/c+hIot5DMWxV7EBqPgMkKXUuxeNR
         SwAjtwfqs692SbHAjwhWOgyBTHOOjAdmgj8+FNqe3UvnsyeRBWqs7wRZccykpGEv0v28
         wq1grgrJTr9Vu6AjQD9SDfzpWa+915tGK6yZupdxGaVFNgE/TfbDtCF93gL8F+Y5ruYH
         Z5Ov/zMSssTw+tjsKeoRrsrleZI/cklwp3RkfgHi4+aMfF2bUuXIavi9vGlOzcfwEX78
         UltWJqUzVhlu3QB8u3Xl/nz8lJNl29Wm+RJDKGA7W1VO8+6PMP8lMsxv5oggoHvcXRN7
         ZQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711095413; x=1711700213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PB54NDFUedyRI5XOiQhGkPf9QFhhfzoP+DfSevmI9uw=;
        b=lgEeXqRDQqZdE8XYZFcYkoInucrDgkq8x1muVN3Qpsn12x9iQ/nAbw6sYy8PDeiZQK
         jzwUIunzqOsETpCUZYScSvVhqgPzB+8HmKQzhrUU7cVqJOg7jLJ4e0gdN7ZLTAzRe9pT
         cywR1KZQuqbs9bqcMTWZH2Z6NoCbU0MOFlHkT7kt3gTJGTVIRPC94uPLbdqUnxt5txmk
         CtniFc7fgBMwdlVqx3t4ffN4DlFYE4fOXqt29s/iwV/+BZPa3j4Ai1fZ4doehGUKRaNZ
         gAx9vFsl5plPoMhlIRGtsDgEBJxJVuYsevDzQC1n2Hbq+rI8d913X+SPVRHbIDzoO06i
         pYLg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ/RYQ5j4zUnxThqJhKr5SGZ+JoWcVdqU6yAgXH/2yzScPPrT+uW2UrwgfVOAHaf0Pbesy5udpRKN6rzhCOvcS/+r+XdkD
X-Gm-Message-State: AOJu0YzAlNe5cbsxtJ0O/Lq3fQ4J1hMPBpidY1V2YVVodcPZAwqcoZO/
	jxssyVpSyPBh+3wACoUIWWz/fEMXEPvEAV6jyrWOuP+3hgUD9DjIAQ77HIy0y+mg/umD+6hia53
	sVqk=
X-Google-Smtp-Source: AGHT+IGfGWLQEzN5dPFkicOLrYnQsH+knmMtXfSU3ThnyvdvpIzpG4p6EFl45MbiBK4I2HJTHXqTpw==
X-Received: by 2002:a05:600c:5487:b0:413:2c11:f795 with SMTP id iv7-20020a05600c548700b004132c11f795mr1009655wmb.39.1711095412789;
        Fri, 22 Mar 2024 01:16:52 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id fk12-20020a05600c0ccc00b004147dd0915dsm329682wmb.21.2024.03.22.01.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 01:16:52 -0700 (PDT)
Date: Fri, 22 Mar 2024 09:16:49 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: pseudoc <atlas.yu@canonical.com>, nic_swsd@realtek.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ChunHao Lin <hau@realtek.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH] r8169: skip DASH fw status checks when DASH is disabled
Message-ID: <Zf0-cXhouMkgebDR@nanopsycho>
References: <20240322034617.23742-1-atlas.yu@canonical.com>
 <50974cc4-ca03-465c-8c3d-a9d78ee448ed@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50974cc4-ca03-465c-8c3d-a9d78ee448ed@gmail.com>

Fri, Mar 22, 2024 at 08:01:40AM CET, hkallweit1@gmail.com wrote:
>On 22.03.2024 04:46, pseudoc wrote:
>> On devices that support DASH, the current code in the "rtl_loop_wait" function
>> raises false alarms when DASH is disabled. This occurs because the function
>> attempts to wait for the DASH firmware to be ready, even though it's not
>> relevant in this case.
>> 
>
>To me this seems to be somewhat in conflict with the commit message of the
>original change. There's a statement that DASH firmware may influence driver
>behavior even if DASH is disabled.
>I think we have to consider three cases in the driver:
>1. DASH enabled (implies firmware is present)
>2. DASH disabled (firmware present)
>3. DASH disabled (no firmware)
>
>I assume your change is for case 3.
>
>Is there a way to detect firmware presence on driver load?
>
>> r8169 0000:0c:00.0 eth0: RTL8168ep/8111ep, 38:7c:76:49:08:d9, XID 502, IRQ 86
>> r8169 0000:0c:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
>> r8169 0000:0c:00.0 eth0: DASH disabled
>> ...
>> r8169 0000:0c:00.0 eth0: rtl_ep_ocp_read_cond == 0 (loop: 30, delay: 10000).
>> 
>> This patch modifies the driver start/stop functions to skip checking the DASH
>> firmware status when DASH is explicitly disabled. This prevents unnecessary
>> delays and false alarms.
>> 
>> The patch has been tested on several ThinkStation P8/PX workstations.
>> 
>> Fixes: 0ab0c45d8aae ("r8169: add handling DASH when DASH is disabled")
>
>SoB is missing

Also, please fix the From email header to contain the same proper name
and email address as SoB tag.

Also, indicate the targetting tree. Please make sure you read again:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html?highlight=network#tl-dr

pw-bot: cr

>
>> ---
>>  drivers/net/ethernet/realtek/r8169_main.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>> 
>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>> index 5c879a5c86d7..a39520a3f41d 100644
>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>> @@ -1317,6 +1317,8 @@ static void rtl8168ep_stop_cmac(struct rtl8169_private *tp)
>>  static void rtl8168dp_driver_start(struct rtl8169_private *tp)
>>  {
>>  	r8168dp_oob_notify(tp, OOB_CMD_DRIVER_START);
>> +	if (!tp->dash_enabled)
>> +		return;
>>  	rtl_loop_wait_high(tp, &rtl_dp_ocp_read_cond, 10000, 10);
>>  }
>>  
>> @@ -1324,6 +1326,8 @@ static void rtl8168ep_driver_start(struct rtl8169_private *tp)
>>  {
>>  	r8168ep_ocp_write(tp, 0x01, 0x180, OOB_CMD_DRIVER_START);
>>  	r8168ep_ocp_write(tp, 0x01, 0x30, r8168ep_ocp_read(tp, 0x30) | 0x01);
>> +	if (!tp->dash_enabled)
>> +		return;
>>  	rtl_loop_wait_high(tp, &rtl_ep_ocp_read_cond, 10000, 30);
>>  }
>>  
>> @@ -1338,6 +1342,8 @@ static void rtl8168_driver_start(struct rtl8169_private *tp)
>>  static void rtl8168dp_driver_stop(struct rtl8169_private *tp)
>>  {
>>  	r8168dp_oob_notify(tp, OOB_CMD_DRIVER_STOP);
>> +	if (!tp->dash_enabled)
>> +		return;
>>  	rtl_loop_wait_low(tp, &rtl_dp_ocp_read_cond, 10000, 10);
>>  }
>>  
>> @@ -1346,6 +1352,8 @@ static void rtl8168ep_driver_stop(struct rtl8169_private *tp)
>>  	rtl8168ep_stop_cmac(tp);
>>  	r8168ep_ocp_write(tp, 0x01, 0x180, OOB_CMD_DRIVER_STOP);
>>  	r8168ep_ocp_write(tp, 0x01, 0x30, r8168ep_ocp_read(tp, 0x30) | 0x01);
>> +	if (!tp->dash_enabled)
>> +		return;
>>  	rtl_loop_wait_low(tp, &rtl_ep_ocp_read_cond, 10000, 10);
>>  }
>>  
>
>

