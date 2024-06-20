Return-Path: <netdev+bounces-105368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD21910D6E
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 18:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21C76B26F28
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 16:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599071B150D;
	Thu, 20 Jun 2024 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="qI5Ef4E7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1641B1509
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718901808; cv=none; b=kBdvSRPWNPk3hOEZPppcT+YPEm0/jiTwCCKTDl7ox4BL/juy0w8Oyc2xvyfJiWIjKepXjwkLQ2NSGEowKd0nMhre7aG9gEUjni31gAnCdDar+SmAumyVJQkJzTuT9dfIEKzI+VVAKKBseC6ophlyzFM215AKBw9KE/TJYIucDoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718901808; c=relaxed/simple;
	bh=w0O4MJAbcUJYRoLptbk3bfA6SyPgrDXAQHMZZDms4iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AKyBUxupdWkZZOpLCzuk30tfc9Dy47lMKwos45pLv0MnIjy8eHR5f4n14JWUMUaJ19rHi2vKPjeZX2W4NfIC5Lr56vnFdIWnqSnF9GxZogU/MLE0+GeA0iKBUa4jmnLBJ6tNHlK3D+dhawEby0DOKuNNb63UZY57mLl1yIyztmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=qI5Ef4E7; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7377C3FE26
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 16:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718901800;
	bh=Iv5yHHTF6kNz7NmO2DfLiCh76upALsMsvMH1lBE+Y4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=qI5Ef4E7Wm2Qn3TKTD2VhpxJ+0LRBHRMV7iwuXgAsYryI0VBoRPdSjLcPR1F76peZ
	 P9oN37AA5cbZ2yllPnUBLnq5t+0z6rUyPCm4SuXI+6IGwB4gvWwXpn+vzdoidganLF
	 QDqf3o5H2p3bk/II0W1sFzpdkc8268djXIKgK5FcC7VBgzkb7TaKKC/tK5jNrrAA5C
	 K5jwfNZQMLF2/NP56d8YVmntsK1KQ87BtzMS9eE03wT1GKQXwUwbwKlaGKgN5Rb7zc
	 oH1AMpGGnRjylcshPPnzKzOQ5u4WPDeEIZk9C2ldFRxJDeJDdG67V8qy7yKz/rQDwO
	 vayUdA5SOr5oQ==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-57c93227bbeso628807a12.3
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 09:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718901800; x=1719506600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iv5yHHTF6kNz7NmO2DfLiCh76upALsMsvMH1lBE+Y4A=;
        b=XKV+LprpUExzrlAGPcbb7J/ISq6kCqnhcO5ltfB4abvYUC5AVHNZa3LFRVlEF6r/s0
         66O0P9t4RpoZerplEX/ZipIJ6u35wRZWUhgvQDt+Tnyq2JN/3oEe7r/rtXzsCIzE0+Rj
         LqJIDQ3GyJpTDev/s3zy9ln/4V2v7qmyFmdSPG3y/2BZ7stkOFakypTQCc0gP+MpsOXx
         eDTCOCUQyPL00hp9om/HuNBVmzlVfxFmcNgJVPh7ep5YdusNj97ZJmpmyy0NY2/oJr0f
         enJbK14NTGNprbCk8LR5EHz2zPOL2du2UJt/T3/U/pRwxJpRRhXQU+WTkGh1F6QKajUl
         SHXg==
X-Gm-Message-State: AOJu0Yx1NCuD2XImBeNoB8Gct4tkDnVCS6GGx5/SkPSi43ck8la6VwC+
	QpTOgVTHyR+9p2VU79Jx9wWeeQ95UsY/TrK8qaAkqyrizaA7TikECsGx/BQkMQ8jTthI5EDRuxi
	7WkNqp8mzILFiQjvo/hkMOanhaM5LxNxSOVqyMUj8tMz/HSXvINXH0xPmArt/vVk7loTLsw==
X-Received: by 2002:a05:600c:45cf:b0:424:745d:f27f with SMTP id 5b1f17b1804b1-4247529ca74mr41175035e9.37.1718895587016;
        Thu, 20 Jun 2024 07:59:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+a5qhfriM35fdp5TpS87N2pOujvdZdJenKkoquwLscnAQp963+R3LOzJiWNi2fupXmQWwRg==
X-Received: by 2002:a05:600c:45cf:b0:424:745d:f27f with SMTP id 5b1f17b1804b1-4247529ca74mr41174845e9.37.1718895586620;
        Thu, 20 Jun 2024 07:59:46 -0700 (PDT)
Received: from [192.168.1.126] ([213.204.117.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0c54d9sm29503065e9.28.2024.06.20.07.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 07:59:46 -0700 (PDT)
Message-ID: <1fee07fd-3beb-4201-9575-5ad630386e2f@canonical.com>
Date: Thu, 20 Jun 2024 17:59:42 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] bnx2x: Fix multiple UBSAN
 array-index-out-of-bounds
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
References: <20240612154449.173663-1-ghadi.rahme@canonical.com>
 <20240613074857.66597de9@kernel.org>
Content-Language: en-US
From: Ghadi Rahme <ghadi.rahme@canonical.com>
In-Reply-To: <20240613074857.66597de9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 13/06/2024 17:48, Jakub Kicinski wrote:
> On Wed, 12 Jun 2024 18:44:49 +0300 Ghadi Elie Rahme wrote:
>> Fix UBSAN warnings that occur when using a system with 32 physical
>> cpu cores or more, or when the user defines a number of Ethernet
>> queues greater than or equal to FP_SB_MAX_E1x using the num_queues
>> module parameter.
>>
>> The value of the maximum number of Ethernet queues should be limited
>> to FP_SB_MAX_E1x in case FCOE is disabled or to [FP_SB_MAX_E1x-1] if
>> enabled to avoid out of bounds reads and writes.
> You're just describing what the code does, not providing extra
> context...

Apologies for the lack of explanation.

Currently there is a read/write out of bounds that occurs on the array
"struct stats_query_entry query" present inside the "bnx2x_fw_stats_req"
struct in "drivers/net/ethernet/broadcom/bnx2x/bnx2x.h".
Looking at the definition of the "struct stats_query_entry query" array:

struct stats_query_entry query[FP_SB_MAX_E1x+
         BNX2X_FIRST_QUEUE_QUERY_IDX];

FP_SB_MAX_E1x is defined as the maximum number of fast path interrupts and
has a value of 16, while BNX2X_FIRST_QUEUE_QUERY_IDX has a value of 3
meaning the array has a total size of 19.
Since accesses to "struct stats_query_entry query" are offset-ted by
BNX2X_FIRST_QUEUE_QUERY_IDX, that means that the total number of Ethernet
queues should not exceed FP_SB_MAX_E1x (16). However one of these queues
is reserved for FCOE and thus the number of Ethernet queues should be set
to [FP_SB_MAX_E1x -1] (15) if FCOE is enabled or [FP_SB_MAX_E1x] (16) if
it is not.

This is also described in a comment in the source code in
drivers/net/ethernet/broadcom/bnx2x/bnx2x.h just above the Macro definition
of FP_SB_MAX_E1x. Below is the part of this explanation that it important
for this patch

/*
  * The total number of L2 queues, MSIX vectors and HW contexts (CIDs) is
  * control by the number of fast-path status blocks supported by the
  * device (HW/FW). Each fast-path status block (FP-SB) aka non-default
  * status block represents an independent interrupts context that can
  * serve a regular L2 networking queue. However special L2 queues such
  * as the FCoE queue do not require a FP-SB and other components like
  * the CNIC may consume FP-SB reducing the number of possible L2 queues
  *
  * If the maximum number of FP-SB available is X then:
  * a. If CNIC is supported it consumes 1 FP-SB thus the max number of
  *    regular L2 queues is Y=X-1
  * b. In MF mode the actual number of L2 queues is Y= (X-1/MF_factor)
  * c. If the FCoE L2 queue is supported the actual number of L2 queues
  *    is Y+1
  * d. The number of irqs (MSIX vectors) is either Y+1 (one extra for
  *    slow-path interrupts) or Y+2 if CNIC is supported (one additional
  *    FP interrupt context for the CNIC).
  * e. The number of HW context (CID count) is always X or X+1 if FCoE
  *    L2 queue is supported. The cid for the FCoE L2 queue is always X.
  */

Looking at the commits when the E2 support was added, it was originally
using the E1x parameters [f2e0899f0f27 (bnx2x: Add 57712 support)]. Where
FP_SB_MAX_E2 was set to 16 the same as E1x. Since I do not have access to
the datasheets of these devices I had to guess based on the previous work
done on the driver what would be the safest way to fix this array overflow.
Thus I decided to go with how things were done before, which is to limit
the E2 to using the same number of queues as E1x. This patch accomplishes
that.

However I also had another solution which made more sense to me but I had
no way to tell if it would be safe. The other solution was to increase the
size of the stats_query_entry query array to be large enough to fit the
number of queues supported by E2. This would mean that the new definition
would look like the following:

struct stats_query_entry query[FP_SB_MAX_E2+
         BNX2X_FIRST_QUEUE_QUERY_IDX];

I have tested this approach and it worked fine so I am more comfortable now
changing the patch an sending in a v3 undoing the changes in v2 and simply
increasing the array size. I believe now that using FP_SB_MAX_E1x instead
of FP_SB_MAX_E2 to define the array size might have been an oversight when
updating the driver to take full advantage of the E2 after it was just
limiting itself to the capabilities of an E1x.

>
>> Fixes: 7d0445d66a76 ("bnx2x: clamp num_queues to prevent passing a negative value")
> Sure this is not more recent, netif_get_num_default_rss_queues()
> used to always return 8.
The value of the number of queues can be defined by the kernel or the
user, which is why I used the commit that I did for the Fixes tag
because it is the job of the clamp to make sure both these values are
in check. Setting the Fixes tag to when netif_get_num_default_rss_queues()
was changed ignores the fact that the user value can be out of bounds.
>> Signed-off-by: Ghadi Elie Rahme <ghadi.rahme@canonical.com>
>> Cc: stable@vger.kernel.org
>>   drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
>> index a8e07e51418f..c895dd680cf8 100644
>> --- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
>> +++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
>> @@ -66,7 +66,12 @@ static int bnx2x_calc_num_queues(struct bnx2x *bp)
>>   	if (is_kdump_kernel())
>>   		nq = 1;
>>   
>> -	nq = clamp(nq, 1, BNX2X_MAX_QUEUES(bp));
>> +	int max_nq = FP_SB_MAX_E1x - 1;
> please don't mix declarations and code
>
>> +	if (NO_FCOE(bp))
>> +		max_nq = FP_SB_MAX_E1x;
> you really need to explain somewhere why you're hardcoding E1x
> constants while at a glance the driver also supports E2.
> Also why is BNX2X_MAX_QUEUES() higher than the number of queues?
> Isn't that the bug?
The reason I did not patch BNX2X_MAX_QUEUES() is because the macro is
working as expected by returning the actual number of queues that can be
handled by a NIC using an E2/E1x chip. It was the driver that was not able
to handle the maximum an E2 NIC can take.

