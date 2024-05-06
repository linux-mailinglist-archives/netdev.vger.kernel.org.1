Return-Path: <netdev+bounces-93555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 266298BC4F0
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 02:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5BD72821C0
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 00:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3949479C0;
	Mon,  6 May 2024 00:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="vhRHRF3z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59D863B9
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 00:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714956223; cv=none; b=kI5nEkQs+NGesc3Zp+8Cb70ZZR1i/NxovAjg1eLroB6cKSZufVZsSIsiwLzqEsUwXrOAHIwzsYgwUVeh/IBstPXP1H/Fv3fYAGUV4AwyyevlUIRts6h/IT+ONehHbfa/X01KwzJ4+O5L+QefOJ/tYD8NwN+T3d3JkguVZ2Cr/Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714956223; c=relaxed/simple;
	bh=cVrYrJjIL1ENeC+YE2zncARQ2y05Ejc2T4gjFjbDLH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aAxxkECDNsNZmVP1iBjFC+g82RDLNDNyGtQGzNnPargtyn7wi/1oOzBXT20I4c8jS6j8n3bKMrDZurmAvKgxKk4adWWkxweghXaXqL8cqgrR/CdREjdJhe6Y0oSjz342a7BMuute9Pt3xHQqgeCz9MiEtvgNN1V7vN6Z78bdufY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=vhRHRF3z; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f4603237e0so611363b3a.0
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 17:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714956221; x=1715561021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KzU8eSaK5Fr9+W3OKDfKYPK1CZLZ+u9LELzEZOgkryU=;
        b=vhRHRF3zEyvaLtoDXtFl//Nw0OjnLQwRksKEzkWm06KEyM22pBvZwFMizdAnOjvODd
         JpVnQbPZfkMpZJg8Yr/hdMjJOSig45lUWfzr9v9AqX/n6Ygga+8V6KwAx8uHJ19bdeYy
         q2fybDhWclMIZ7Sfnia6NWKFbGtVfJw2yEMbRgy490tFeEdqC7Em2ZWgTue1NxQhCqua
         wrfah/E2uYZU8IiRWD5kL3aDYO6kx93hiH1l5oMzvjHN2DZxXZbuNwpqmJLONlr5LA2E
         6YLgT2Vc1MSCyhogutgwHRQfvA6XbvG+BlL3V/lKuKPriyUcm+sOLlFg/bCx3dEzzMwf
         HuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714956221; x=1715561021;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KzU8eSaK5Fr9+W3OKDfKYPK1CZLZ+u9LELzEZOgkryU=;
        b=nEeKyJEnAITkJkLPRrfk9XCuECyH50CBuQcQ6BqTZbpfThh6NGvhAzXjoFaLbYszs6
         8EyjTtlR/7wS0MI/zhbAXMNtKW57PNkD8AaoZX6F9YuG4b5zaDcnX0pDn+2loE9kVkjd
         MoiIsm8cj/YAIz3fLhsoV9ucY3F/bx45VOF9D5hNUMoZXLNGpg/qTHPqm9bchWRh9MLv
         lTPSRIVkZzJE1l3IBxRc7+RprnpdvOwSxKBdqvtCOa4FdkLRz97iQVIiJ7yxG09VHfcg
         xZ6Bsg/PVFrJJCPfyuke0q1sHMFsyYn0AN5bQBrdm1Gp9NACxsutZSJ/cxeBgMkYQwVa
         mdnA==
X-Gm-Message-State: AOJu0YxV0dKtRDPC3Q7K1GgXH+DiWiSe5QU4XC37gX1/843Tuw1aAGQj
	UQIn4DFKcCM6Iye07evTaWVI1VwCY49lls+RIGKEZ5TbgnOf5XdcIyos6a3oX2Y=
X-Google-Smtp-Source: AGHT+IFxauew51Lpj9bh1gLOr32V11t46u4Rm9ESDtoJI8fC0EDJ+u3jT7dYLA/f7T6WW0nLmXlY2w==
X-Received: by 2002:a05:6a00:3d4b:b0:6ea:dfc1:b86 with SMTP id lp11-20020a056a003d4b00b006eadfc10b86mr13550309pfb.12.1714956220741;
        Sun, 05 May 2024 17:43:40 -0700 (PDT)
Received: from [192.168.1.15] (174-21-160-85.tukw.qwest.net. [174.21.160.85])
        by smtp.gmail.com with ESMTPSA id fc4-20020a056a002e0400b006f4718b76a5sm1676355pfb.13.2024.05.05.17.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 17:43:40 -0700 (PDT)
Message-ID: <beedcba6-53c6-4ceb-8d5f-dda93c0f5e41@davidwei.uk>
Date: Sun, 5 May 2024 17:43:39 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v2 5/9] bnxt: refactor
 bnxt_{alloc,free}_one_tpa_info()
Content-Language: en-GB
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Adrian Alvarado <adrian.alvarado@broadcom.com>,
 Mina Almasry <almasrymina@google.com>, Shailend Chand <shailend@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240502045410.3524155-1-dw@davidwei.uk>
 <20240502045410.3524155-6-dw@davidwei.uk>
 <20240504123035.GH3167983@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240504123035.GH3167983@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-05-04 05:30, Simon Horman wrote:
> On Wed, May 01, 2024 at 09:54:06PM -0700, David Wei wrote:
>> Refactor the allocation of each rx ring's tpa_info in
>> bnxt_alloc_tpa_info() out into a standalone function
>> __bnxt_alloc_one_tpa_info().
>>
>> In case of allocation failures during bnxt_alloc_tpa_info(), clean up
>> in-place.
>>
>> Change bnxt_free_tpa_info() to free a single rx ring passed in as a
>> parameter. This makes bnxt_free_rx_rings() more symmetrical.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
> 
> Hi David,
> 
> Some minor nits flagged by
> 
> ./scripts/checkpatch.pl --codespell --max-line-length=80 --strict

I didn't run through the usual checks because this is an RFC. I'll fix
it for the next series, thanks.

> 
>> ---
>>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 95 +++++++++++++++--------
>>  1 file changed, 62 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> 
> ...
> 
>> +static int __bnxt_alloc_one_tpa_info(struct bnxt *bp, struct bnxt_rx_ring_info *rxr)
>> +{
> 
> Please consider limiting Networking code to 80 columns wide where
> it can be trivially achieved.
> 
> In this case, perhaps:
> 
> static int __bnxt_alloc_one_tpa_info(struct bnxt *bp,
> 				     struct bnxt_rx_ring_info *rxr)
> 
>> +	struct rx_agg_cmp *agg;
>> +	int i, rc;
>> +
>> +	rxr->rx_tpa = kcalloc(bp->max_tpa, sizeof(struct bnxt_tpa_info),
>> +				GFP_KERNEL);
> 
> The indentation here is not quite right.
> 
> 	rxr->rx_tpa = kcalloc(bp->max_tpa, sizeof(struct bnxt_tpa_info),
> 			      GFP_KERNEL);
> 
>> +	if (!rxr->rx_tpa)
>> +		return -ENOMEM;
>> +
>> +	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
>> +		return 0;
>> +
>> +	for (i = 0; i < bp->max_tpa; i++) {
>> +		agg = kcalloc(MAX_SKB_FRAGS, sizeof(*agg), GFP_KERNEL);
>> +		if (!agg) {
>> +			rc = -ENOMEM;
>> +			goto err_free;
>>  		}
>> -		kfree(rxr->rx_tpa);
>> -		rxr->rx_tpa = NULL;
>> +		rxr->rx_tpa[i].agg_arr = agg;
>> +	}
>> +	rxr->rx_tpa_idx_map = kzalloc(sizeof(*rxr->rx_tpa_idx_map),
>> +					GFP_KERNEL);
>> +	if (!rxr->rx_tpa_idx_map) {
>> +		rc = -ENOMEM;
>> +		goto err_free;
>>  	}
>> +
>> +	return 0;
>> +
>> +err_free:
>> +	while(i--) {
> 
> Space before '(' here please.
> 
>> +		kfree(rxr->rx_tpa[i].agg_arr);
>> +		rxr->rx_tpa[i].agg_arr = NULL;
>> +	}
>> +	kfree(rxr->rx_tpa);
>> +	rxr->rx_tpa = NULL;
>> +
>> +	return rc;
>>  }
> 
> ...

