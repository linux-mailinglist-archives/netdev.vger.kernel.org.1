Return-Path: <netdev+bounces-193389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8C2AC3BE2
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 10:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B10093A45D0
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 08:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6631E5B88;
	Mon, 26 May 2025 08:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bell-sw-com.20230601.gappssmtp.com header.i=@bell-sw-com.20230601.gappssmtp.com header.b="rzIVY1n6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44B82AEFE
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748248956; cv=none; b=oAyza1rHUje/95Lbnjn9fadCwCTsBXvYZ08qTb0zxIoJ3iK3BjVp7nm/9X3ISPDUbBLCZZtzmc0uGy7yemM2dxtYa0kJE7bl5s3h7ZokQDsGH2NDtv+8laFruoNo72qkeWHT1VrYeZue7IoYSUvbI7cvg4BzcU3hREBju6fUTxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748248956; c=relaxed/simple;
	bh=/1xN60Z/a+3aRQBwEskRT6CPFPk//+bjzxKTJ6v9ngA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tD7pbCQUmdbomf71N3Q4skKVRvp7ugcgB8ApWTkc4ybyH3C85zHNgQoL1csqVWMJ9inEJ8VQudDmMtYZq4sfvePEf6MfAKUdJU9JqrFoFYyZx7zyhxF5ScDSBd4+GhQf5kA9zITeMYjWWFf+3t/mqJ7ZD0iHHQsBQ5X4/PpGUHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell-sw.com; spf=pass smtp.mailfrom=bell-sw.com; dkim=pass (2048-bit key) header.d=bell-sw-com.20230601.gappssmtp.com header.i=@bell-sw-com.20230601.gappssmtp.com header.b=rzIVY1n6; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell-sw.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bell-sw.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-328114b262aso19626261fa.3
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 01:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bell-sw-com.20230601.gappssmtp.com; s=20230601; t=1748248952; x=1748853752; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yYw8tg6P7wN29q3bWWjh87GXBSsui1vsmZC9VYdDMvA=;
        b=rzIVY1n6MZ9aGDp9c08quU7h9zsp3lTv54wKCif4jwyNkNrp4Z2sDo3RIWg5gJefzn
         pqjohuDh2UE/bOV278o21IjZgEHOXEkjMD81/QB/fJbc17R38MPJ+ZUzBWR9va/y6F/M
         nHilVjGSh4CksjbbDxh3wlbmnPJMyF36lTAhy/aQBZqr6mpzzmLd5qq12+/SuctBQ7Xv
         YIZRYF+/TdK9E7f1yXGfq+sXDExzYwTIWBF+N6U19GDbp5T+y/4JuygpAzrniWCxs5UP
         WoVYufq+D7onSFVNSa8rTx5K0QHnhMSHoWY6Q0BzHCRtcq/nnM6RhvO6GFUUwxG8YQ3T
         lpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748248952; x=1748853752;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yYw8tg6P7wN29q3bWWjh87GXBSsui1vsmZC9VYdDMvA=;
        b=G3pBwKWy37LbqTsM3CN/9ihzoJBYKqqkhnxS7PL3+0SJuE0UMMAlOM1A7c7rfWy8KE
         zmJ2o3PqWUWMaGMvuOvhuvQoTOGjC2/2iqmpdLUuVeQn7ibWY3Lv58SQqoAAW6EI2k23
         vAd557tBKp0q5NRO4kEb56aC8XlKY4OwD0l+RKWAE/22A6IQdoEH/398NsMyN6zdsXBb
         v7O6hFAD1/nckBanOR0XpvmtDauhguLALEMBYjbzbomZXmjku/uwo2Nwmdef/RoH+dHr
         NWSL9d1t7KqkyvDRKx478Cvz2k/1EWLCqYbuEcgvBr8kI+fGacjbKP2t3oDMFmL4HSis
         Iivw==
X-Forwarded-Encrypted: i=1; AJvYcCWRgX2jVo6cKvaXx5f9e+13RtdSh38bUw2sfdKmCCYtw+Oiyud1SPCw8YrmEIh40BXHOTLxafE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0boA0yDlVKnSr9ujp0khF2fYg78Sq3Ej0y+ksRQRM8kTFnBXH
	kqZZ3SJT0Y93WvifeSx7odK32/Ddc9FJ1e+lup42M4xUIadG9S4GW4GRYIjtQ1gvdg==
X-Gm-Gg: ASbGncuceySLQgGcci0uPAbGxcLzDCpuRc5k9sLWRv3yylfXmjJ73dLZLmzFAjUx6Oo
	pJ3A03Sf35RkvDzy+F5BeAfUHlONWHTkDeIdGOSPgV43xC7AAAppc/GFXDCeGIQKs5UTDfyqo7n
	cD47ntmv2o+7kF5ktPJz3Mo92UNwsBeZnbllJjslVzK5ZkDFm6GMPWSDox/LUvo5ox+5y5he1Kz
	G6ZqiTdWTXbV4ySMiBO9QsgtpPFdRPfe0ZrdcmjWViuiWd+tGm9C/1yikAMrpsB/xwcvgPZ9oJ8
	n97OwPBzNKHMyagAgl+DgNJm3Nf3JYz7udFHMkF6Ifwt1AkOVYNjtMvZrIZ+/g==
X-Google-Smtp-Source: AGHT+IGNIBbsxaN3nrFZfhKFkfehHzZGXJ0BcTVbmHBvOYfgUEOm61DWqo7NA6gNrnv+HXfWyxaMkg==
X-Received: by 2002:a05:651c:b13:b0:30c:514c:55d4 with SMTP id 38308e7fff4ca-3295ba24d52mr18420461fa.16.1748248951704;
        Mon, 26 May 2025 01:42:31 -0700 (PDT)
Received: from [192.168.1.54] ([91.247.149.7])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3280fe585cdsm44495121fa.71.2025.05.26.01.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 01:42:31 -0700 (PDT)
Message-ID: <52d96554-23f6-4bde-84d9-e0a7a40b0bc3@bell-sw.com>
Date: Mon, 26 May 2025 08:42:30 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Subject: Re: [PATCH net-next] net: lan743x: fix 'channel' index check before
 writing ptp->extts[]
To: Rengarajan.S@microchip.com, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, Bryan.Whitehead@microchip.com,
 davem@davemloft.net, Raju.Lakkaraju@microchip.com, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, UNGLinuxDriver@microchip.com,
 richardcochran@gmail.com
References: <20250522141357.295240-1-aleksei.kodanev@bell-sw.com>
 <ae5090d780d6214311f030818f47b48a9b04fe4a.camel@microchip.com>
Content-Language: en-US
Autocrypt: addr=aleksei.kodanev@bell-sw.com; keydata=
 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
 SKzhlhbWzHw=
In-Reply-To: <ae5090d780d6214311f030818f47b48a9b04fe4a.camel@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Rengarajan!
On 23.05.2025 20:21, Rengarajan.S@microchip.com wrote:
> Hi Alexey,
> 
> On Thu, 2025-05-22 at 14:13 +0000, Alexey Kodanev wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>> know the content is safe
>>
>> Before calling lan743x_ptp_io_event_clock_get(), the 'channel' value
>> is checked against the maximum value of
>> PCI11X1X_PTP_IO_MAX_CHANNELS(8).
>> This seems correct at first and aligns with the PTP interrupt status
>> register (PTP_INT_STS) specifications.
>>
>> However, lan743x_ptp_io_event_clock_get() writes to ptp->extts[] with
>> only LAN743X_PTP_N_EXTTS(4) elements, using channel as an index:
>>
>>     lan743x_ptp_io_event_clock_get(..., u8 channel,...)
>>     {
>>         ...
>>         /* Update Local timestamp */
>>         extts = &ptp->extts[channel];
>>         extts->ts.tv_sec = sec;
>>         ...
>>     }
>>
> 
> As per the PTP_INT_STS definition, there are 8 sets of capture
> registers that can be configured as GPIO inputs. However, using
> LAN743X_PTP_N_EXTTS (4) restricts processing to only 4 GPIOs. Would it
> be more appropriate to update LAN743X_PTP_N_EXTTS to 8? This would
> ensure that extts = &ptp->extts[channel]; remains valid for all 8
> potential channel indices. 
> 

Yes, thought about the same, but I'm not sure why it was initially
limited to using only 4 channels in LAN743X_PTP_N_EXTTS.

Would it be okay to add the following to the patch?

--- a/drivers/net/ethernet/microchip/lan743x_ptp.h
+++ b/drivers/net/ethernet/microchip/lan743x_ptp.h
@@ -18,9 +18,8 @@
  */
 #define LAN743X_PTP_N_EVENT_CHAN       2
 #define LAN743X_PTP_N_PEROUT           LAN743X_PTP_N_EVENT_CHAN
-#define LAN743X_PTP_N_EXTTS            4
+#define LAN743X_PTP_N_EXTTS            8       /* supports 8 GPIOs */
 #define LAN743X_PTP_N_PPS              0
-#define PCI11X1X_PTP_IO_MAX_CHANNELS   8
 #define PTP_CMD_CTL_TIMEOUT_CNT                50


>> To avoid a potential out-of-bounds write, let's use the maximum
>> value actually defined for the timestamp array to ensure valid
>> access to ptp->extts[channel] within its actual bounds.
>>
>> Detected using the static analysis tool - Svace.
>> Fixes: 60942c397af6 ("net: lan743x: Add support for PTP-IO Event
>> Input External Timestamp (extts)")
>> Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
>> ---
>>
>> Note that PCI11X1X_PTP_IO_MAX_CHANNELS will be unused after this
>> patch.
>> Could it perhaps be used to define LAN743X_PTP_N_EXTTS to support
>> size 8?
>>
>>  drivers/net/ethernet/microchip/lan743x_ptp.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.c
>> b/drivers/net/ethernet/microchip/lan743x_ptp.c
>> index 0be44dcb3393..1ef7978e768b 100644
>> --- a/drivers/net/ethernet/microchip/lan743x_ptp.c
>> +++ b/drivers/net/ethernet/microchip/lan743x_ptp.c
>> @@ -1121,7 +1121,7 @@ static long lan743x_ptpci_do_aux_work(struct
>> ptp_clock_info *ptpci)
>>                                                         PTP_INT_IO_FE
>> _MASK_) >>
>>                                                         PTP_INT_IO_FE
>> _SHIFT_);
>>                                 if (channel >= 0 &&
>> -                                   channel <
>> PCI11X1X_PTP_IO_MAX_CHANNELS) {
>> +                                   channel < LAN743X_PTP_N_EXTTS) {
>>                                         lan743x_ptp_io_event_clock_ge
>> t(adapter,
>>                                                                      
>>   true,
>>                                                                      
>>   channel,
>> @@ -1154,7 +1154,7 @@ static long lan743x_ptpci_do_aux_work(struct
>> ptp_clock_info *ptpci)
>>                                                        PTP_INT_IO_RE_
>> MASK_) >>
>>                                                        PTP_INT_IO_RE_
>> SHIFT_);
>>                                 if (channel >= 0 &&
>> -                                   channel <
>> PCI11X1X_PTP_IO_MAX_CHANNELS) {
>> +                                   channel < LAN743X_PTP_N_EXTTS) {
>>                                         lan743x_ptp_io_event_clock_ge
>> t(adapter,
>>                                                                      
>>   false,
>>                                                                      
>>   channel,
>> --
>> 2.25.1
>>


