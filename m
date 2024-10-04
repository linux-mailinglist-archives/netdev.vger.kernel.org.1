Return-Path: <netdev+bounces-131877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E48398FCDD
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 06:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 488ED283B14
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 04:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A9A4963C;
	Fri,  4 Oct 2024 04:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qWIOmHqI"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F1F9475;
	Fri,  4 Oct 2024 04:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728017738; cv=none; b=runTMNRWsdnJYV4Br97DuBrrIv083pYy6q9a0bpYpVMbiWhagx+KL/AEaWUYv86Q52H2Xz8p2ARIt72LpLiMABDVJOzSUxwWDdeWiLGEN8U/4tlpoDMV4f2CPn3M9b1yKZtCHeuJsJJKmo3eKBYnTMEjrf6Evj1X5kFvZRU1jBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728017738; c=relaxed/simple;
	bh=L7Q+mf6JwQ/AmjPQNKn3MG5bhhrV5QRdvkQIx8gQxR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QJzkAwQm9EHhtACakawPr8ZE78gLXaRZxAXj5FQ+G/DiEDPQ9FZjaqWwO/p3H9lfIrEXb2bMgqHM2N1HsBNeV7ltLufZePCZv+gtRns6BFCL7s1hY7Au5uyO9zI/zOsE7DWzN+F8vwIIT+4W9FE/tTJKaAxFXoj9hHOeod9tPNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qWIOmHqI; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4944tBJH053214;
	Thu, 3 Oct 2024 23:55:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728017712;
	bh=mk2XnGhyxjzW1kvZsCKYtwP9v+8FF4LBDGigBPr3R+U=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=qWIOmHqI9Mb7s2y2H80644C7xpQmXYDGkbxclfZWRbXQzAAl084AT5WHE/bC2x6fk
	 9HwCFntr+/E9onpvdkklulUdr95+Gma90k5ycjl/wtFlJFrbC9W21U5uzOZ8OQWGfv
	 lLxBvLU1Zu/gfn/aVIopQswkOUW8uF0SWh8ggLB4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4944tBaF023474
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 3 Oct 2024 23:55:11 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Oct 2024 23:55:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Oct 2024 23:55:11 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4944t5HT125485;
	Thu, 3 Oct 2024 23:55:06 -0500
Message-ID: <4f1f0d20-6411-49c8-9891-f7843a504e9c@ti.com>
Date: Fri, 4 Oct 2024 10:25:05 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix race condition for VLAN
 table access
To: Jakub Kicinski <kuba@kernel.org>
CC: <robh@kernel.org>, <jan.kiszka@siemens.com>, <dan.carpenter@linaro.org>,
        <diogo.ivo@siemens.com>, <andrew@lunn.ch>, <pabeni@redhat.com>,
        <edumazet@google.com>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>
References: <20241003105940.533921-1-danishanwar@ti.com>
 <20241003174142.384e51ad@kernel.org>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20241003174142.384e51ad@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 04/10/24 6:11 am, Jakub Kicinski wrote:
> On Thu, 3 Oct 2024 16:29:40 +0530 MD Danish Anwar wrote:
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> index bba6da2e6bd8..9a33e9ed2976 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> @@ -296,6 +296,7 @@ struct prueth {
>>  	bool is_switchmode_supported;
>>  	unsigned char switch_id[MAX_PHYS_ITEM_ID_LEN];
>>  	int default_vlan;
>> +	spinlock_t vtbl_lock; /* Lock for vtbl in shared memory */
> 
> This needs to be kdoc, otherwise:
> 
> drivers/net/ethernet/ti/icssg/icssg_prueth.h:301: warning: Function parameter or struct member 'vtbl_lock' not described in 'prueth'

Hi Jakub,

Removing the documentation from here and keeping it in kdoc results in
below checkpatch,

CHECK: spinlock_t definition without comment
#69: FILE: drivers/net/ethernet/ti/icssg/icssg_prueth.h:300:
+	spinlock_t vtbl_lock;


What should be done here? Should I,

1. Move the documentation to kdoc - This is will result in checkpatch
2. Keep the documentation in kdoc as well as inline - This will result
in no warnings but duplicate documentation which I don't think is good.

I was not sure which one takes more precedence check patch or kdoc, thus
put it inline thinking fixing checkpatch might have more weightage.

Let me know what should be done here.

-- 
Thanks and Regards,
Danish

