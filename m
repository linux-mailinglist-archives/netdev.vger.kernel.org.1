Return-Path: <netdev+bounces-150795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BE89EB91F
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 19:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC6E1889678
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 18:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B39A20469D;
	Tue, 10 Dec 2024 18:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="KrbqDoSE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93277204696
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 18:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733854498; cv=none; b=KMj/Fb1IvA23cRUJizgqBkC8nUmPf31M0Gi8ZrbsX3RRG813nCXpe9da9oELkKmaLkMeKO0OPakmCUjMGnPSfI+00YhQDJrRNz4FiV60urUfUMGet1H+e6rHxYlzWTvCL9oXLtf7UOMERcHpE0Cyb9m4Wd/T0gWhYJZh4pvIlqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733854498; c=relaxed/simple;
	bh=Q2n8EHNjE7rji0tpVZ7Wr3SuPG/rdYodtbYcmVlF374=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=azeBMXaDIaIB9JArOw4CDtaFo4FLWSX/fGN5RSu6n0ROjY73DWUHnQgNJkltq97T8zVDgqb8NoM9GDiG715aO5vvy0lfb/BX9F43q8DPbABeUlrEKo8Hbbm1YgqbZxL34K3jU5eYkxqsXmdY4t+46G/s1UJK3MZ2qoR8r/qHZos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=KrbqDoSE; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21654fdd5daso22427605ad.1
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 10:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1733854496; x=1734459296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eo+6Oajm1C98G2oRWlTPQQQ+k/zBYhXn/cEAqVWjn1U=;
        b=KrbqDoSE0c1mFBZQRZlZJElkVbrqJH7NPBidX5s7n1+K2L4rxKohZbTr1h6Mx6kgU9
         uNW+2g0pY3dR3DukpebMw5Ef59Te1v3tB001VATS8FpyuNDQBDV8t01WX7Ctoj4nA5vA
         1t+ekObTAJhMbBtaU/o6aGEw9mBI/jH8NAcDMwihu0a9Smf5bvtNM/gqvSPkmKZieXyl
         a4fGA3j53PD/eeqoV3Lr/mGpU/QnnXmeSaBwe5D0ogbDS8OA+j9a4M3oVnGbGlD5Kfrm
         VC/CMIMCucLQ53JnKCFzaQP93JjB3FxXTuZejis5TYjjLDiqJkxrC59mhzKY6iOb0Ff5
         vWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733854496; x=1734459296;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eo+6Oajm1C98G2oRWlTPQQQ+k/zBYhXn/cEAqVWjn1U=;
        b=j/gQ1KNEBuZUD/+3eoHH52lQDJHJrfNtzjOKO4QuAFjW1IqWsOsMcZJbxYsudf/KD1
         yUWR5YekQIBozrulu7WFquvTR1prDra6jtD0ilweqUI0pw+iXIl6A1TzsL3S7KwH3rDu
         tI6aJdLqfrH1sU0DSG7EvDr0TqYFoGOkbrbHSIYLVcPVbxrFn26NvkIcdDK9eF7D45s+
         +Cee3DQTHHnOUDpgvr7WOyivcPtJ3HFCXjhVgCaL67AIC9kdRGtnC3+PMoYw5DVAf+ny
         NmPQ7XaoRSvRatGEo2RoQ8OYC0m25KxV0InHuvX3p3UDFPfVElvKA7bFzc3q87FcxFJA
         +GPg==
X-Forwarded-Encrypted: i=1; AJvYcCX6VsAzLLAUiJnURdvZcFZOivgJHTtfoe8GMDXjdNSo7vNm2m5RHEDjZGxfF3PF5boIjwlwA+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp9uBIRXmqVKgl/PsPgOfBKCZd4Cn6AgIdS7UFQD1z7RZQJUkF
	+9M0QAnDtREOApjb3rCaoB/ttrdR/MvTqnj3Wo5HE1ykFkBKqw1cfMZLBua4/bQ=
X-Gm-Gg: ASbGncuZiihoFV7o2TrrrD0lnVFhbIrAUU66IsYeldivhwFUrzUszskSz19ZtBJ5471
	l8UPm6gaiymRrb96suxWRMPtMWUWtPZ4kXxIuXooAslbGXSFWrgAnkFrKe7BflVSWZIgRKe3l/e
	Q5MvU8eBh740SdRFU2e1/sXmBoxIDGLHzM4ZaZUA5akAbnbPRxhZB8qRTfURGDSHquinkm4en17
	ygxPjCXGwQy2Y9qyDpB62WXgkExL4cB8eY2iCsMLptFZB/jiS7ris6dSMB9EicoE5g6fGnt3w8V
	jyH75eqk+Ynp0Og=
X-Google-Smtp-Source: AGHT+IGkDBE8KL4yrp/KU/hGe1OPuoZUJdRluL9CpPNEWHRhwkS3VB3Ai6J1Sw1ArGZGFmMzbz60oA==
X-Received: by 2002:a17:903:41cf:b0:216:282d:c69b with SMTP id d9443c01a7336-2177851756fmr1398255ad.50.1733854495742;
        Tue, 10 Dec 2024 10:14:55 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1256:1:80c:c984:f4f1:951f? ([2620:10d:c090:500::6:fd3a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216426f8ca4sm44936535ad.278.2024.12.10.10.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 10:14:55 -0800 (PST)
Message-ID: <0bc60b9d-fbf7-4421-ab6a-5854355d68f4@davidwei.uk>
Date: Tue, 10 Dec 2024 10:14:53 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 3/3] bnxt_en: handle tpa_info in queue API
 implementation
Content-Language: en-GB
To: Yunsheng Lin <linyunsheng@huawei.com>, netdev@vger.kernel.org,
 Michael Chan <michael.chan@broadcom.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20241204041022.56512-1-dw@davidwei.uk>
 <20241204041022.56512-4-dw@davidwei.uk>
 <9ca8506d-c42d-40a0-9532-7a95c06fed39@huawei.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <9ca8506d-c42d-40a0-9532-7a95c06fed39@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-12-10 04:25, Yunsheng Lin wrote:
> On 2024/12/4 12:10, David Wei wrote:
> 
>>  	bnxt_copy_rx_ring(bp, rxr, clone);
>> @@ -15563,6 +15580,8 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
>>  	bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
>>  	rxr->rx_next_cons = 0;
>>  	page_pool_disable_direct_recycling(rxr->page_pool);
>> +	if (bnxt_separate_head_pool())
>> +		page_pool_disable_direct_recycling(rxr->head_pool);
> 
> Hi, David
> As mentioned in [1], is the above page_pool_disable_direct_recycling()
> really needed?
> 
> Is there any NAPI API called in the implementation of netdev_queue_mgmt_ops?
> It doesn't seem obvious there is any NAPI API like napi_enable() &
> ____napi_schedule() that is called in bnxt_queue_start()/bnxt_queue_stop()/
> bnxt_queue_mem_alloc()/bnxt_queue_mem_free() through code reading.
> 
> 1. https://lore.kernel.org/all/c2b306af-4817-4169-814b-adbf25803919@huawei.com/

Hi Yunsheng, there are explicitly no napi_enable/disable() calls in the
bnxt implementation of netdev_queue_mgmt_ops due to ... let's say HW/FW
quirks. I looked back at my discussions w/ Broadcom, and IIU/RC
bnxt_hwrm_vnic_update() will prevent any work from coming into the rxq
that I'm trying to stop. Calling napi_disable() has unintended side
effects on the Tx side.

The intent of the call to page_pool_disable_direct_recycling() is to
prevent pages from the old page pool from being returned into the fast
cache. These pages must be returned via page_pool_return_page() so that
the it can eventually be freed in page_pool_release_retry().

I'm going to take a look at your discussions in [1] and respond there.

