Return-Path: <netdev+bounces-127010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9AE9739E1
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 16:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F0D1F2684E
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 14:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C337183094;
	Tue, 10 Sep 2024 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jNoQDvtA"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6933C2AE69
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725978643; cv=none; b=brcLYDoorM2/76z29xfaIADp4yRkKRf3E0yiKd/S6mxZqAh9OmDInQ/jCKvTit6DDberrhSflRuO8AvhKDUGeneRWo5/SCG4Cy+r6n65Gca9tNnIhlfddSCfsq4GA9a3bGQxiee7sN6DJ36fX+LMCu2HXLeO5yZ88Meo7S5PNlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725978643; c=relaxed/simple;
	bh=e9ExoWwqjNSPX1h/uO5L1h9vgCw4rHs96wE7S2Hv8nQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJrdj0HQupTwfQRE8uJUeQqZLexUBYDz2deSscOFPyweTyLrqZk4KVFg2qFZ46pmHD5DxQ/PWlgfXeDoo+8BWZGc6XKLCTEw2XBvftQUY57oOv2yIQzqNk2WjtMLOEPKR2w/n56th+ZJkLhLe10F31vufgE+i/8gRb3Jm7BkIvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jNoQDvtA; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7bd2dbef-643a-4258-af1c-b68bff980b22@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725978639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FNAcMMQvErS3/HJiJVrNMz8DQTCwPMR3vMspJu0zDsA=;
	b=jNoQDvtAANjmAIDum+RAkv0SB54IPDOkc/nJ8hwH4eK8dPbhC/pwpb4WBVwHriCkdv3mSe
	nhkQ4SI/ehrgc21C/GOv8tnOc5jT1fswJpSEuQrqH57QDNXRjP/qV7CqTgxWJTjPb2j6lf
	czAFEsj3tjyQRzx5Fj/2ayGBWZShE94=
Date: Tue, 10 Sep 2024 10:30:35 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH net-next v2 0/6] net: xilinx: axienet: Enable adaptive
 IRQ coalescing with DIM
To: "Nelson, Shannon" <shannon.nelson@amd.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Michal Simek
 <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
 Heng Qi <hengqi@linux.alibaba.com>
References: <20240909235208.1331065-1-sean.anderson@linux.dev>
 <d56ff939-cbcb-4455-b589-3a87b0ec57a4@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <d56ff939-cbcb-4455-b589-3a87b0ec57a4@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 9/9/24 21:34, Nelson, Shannon wrote:
> On 9/9/2024 4:52 PM, Sean Anderson wrote:
>>
>> To improve performance without sacrificing latency under low load,
>> enable DIM. While I appreciate not having to write the library myself, I
>> do think there are many unusual aspects to DIM, as detailed in the last
>> patch.
>>
>> This series depends on [1-2] and is therefore marked RFC. This series is
>> otherwise ready to merge.
>>
>> [1] https://lore.kernel.org/netdev/20240909230908.1319982-1-sean.anderson@linux.dev/
>> [2] https://lore.kernel.org/netdev/20240909231904.1322387-1-sean.anderson@linux.dev/
>>
>> Changes in v2:
>> - Add some symbolic constants for IRQ delay timer
>> - Report an error for bad coalesce settings
>> - Don't use spin_lock_irqsave when we know the context
>> - Split the CR calculation refactor from runtime coalesce settings
>>    adjustment support for easier review.
>> - Have axienet_update_coalesce_rx/tx take the cr value/mask instead of
>>    calculating it with axienet_calc_cr. This will make it easier to add
>>    partial updates in the next few commits.
>> - Get coalesce parameters from driver state
>> - Don't take the RTNL in axienet_rx_dim_work to avoid deadlock. Instead,
>>    calculate a partial cr update that axienet_update_coalesce_rx can
>>    perform under a spin lock.
>> - Use READ/WRITE_ONCE when accessing/modifying rx_irqs
>>
>> Sean Anderson (6):
>>    net: xilinx: axienet: Add some symbolic constants for IRQ delay timer
>>    net: xilinx: axienet: Report an error for bad coalesce settings
>>    net: xilinx: axienet: Combine CR calculation
>>    net: xilinx: axienet: Support adjusting coalesce settings while
>>      running
>>    net: xilinx: axienet: Get coalesce parameters from driver state
>>    net: xilinx: axienet: Enable adaptive IRQ coalescing with DIM
>>
>>   drivers/net/ethernet/xilinx/Kconfig           |   1 +
>>   drivers/net/ethernet/xilinx/xilinx_axienet.h  |  31 +-
>>   .../net/ethernet/xilinx/xilinx_axienet_main.c | 320 ++++++++++++++----
>>   3 files changed, 273 insertions(+), 79 deletions(-)
>>
>> -- 
>> 2.35.1.1320.gc452695387.dirty
>>
>>
> 
> Except for a couple of comment nits pointed out in 3/6 and 6/6, this set seems reasonable.
> 
> Reviewed by: Shannon Nelson <shannon.nelson@amd.com>
> 
> 

Thanks. I'll address these for v3.

--Sean

