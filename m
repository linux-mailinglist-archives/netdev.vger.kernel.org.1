Return-Path: <netdev+bounces-142230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 137B59BDEFE
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 07:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB651F23C44
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 06:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17865191F9E;
	Wed,  6 Nov 2024 06:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jgCf8X+K"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF5617995E;
	Wed,  6 Nov 2024 06:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730875697; cv=none; b=P/6W5BnAMA2KVDFPBavrqWVv1GN1kpacxYD/EdRNvhRuDYePip7ZHtk4j/5AwatV0lzoCsz1G/oJE/COZ7iSIFP3SsLZcy+0DfU3geoOC/ENmc7j3O13itkSvdAsoECBdWq9yOATH0h8YIo57tXQOJxvSI2Vp4jz/7fyibrLp5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730875697; c=relaxed/simple;
	bh=4AlrWv5nTm8KmFK/RjSrqEmQrs/5JQspZ8iMgzP7uO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gt6PJ35u5lS00S1dHcoxJxQTQRAZp511bC3nmaxqyxvA4QX2MDM9lTy3SLtRc0inabYGsNmUSjI3KG9//6zUKcmBBYv1McvQONdUl+XDHyznqF7zhLGK+Y7AilSTsJFO6yZOct+OvHC1mWLv2ODXihY3tmXb6kRJ+eemZDmUJqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jgCf8X+K; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A66ljZA101137;
	Wed, 6 Nov 2024 00:47:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730875665;
	bh=fCQZXkAS/Gp8UlJvk930Ptx2GDYmSbYH65zsCKiP7/U=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=jgCf8X+KbnVPwoZYkCrJjbKjU7lomcVTTxf66Yr7vRmkCGENNVfycSCxXT1yUc+ST
	 NvZt+GCYgIMGxG47fxRCplj3xaMuZsiZiSPofc59ArWpEBr9pHVK3ESw+yvYAEJFBT
	 se28DcGXWZbxfaf/1gm1+9pTwptvKmDAaE7c+LLc=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A66ljlM023491
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 6 Nov 2024 00:47:45 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Nov 2024 00:47:45 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Nov 2024 00:47:45 -0600
Received: from [10.249.139.24] ([10.249.139.24])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A66lcBN008344;
	Wed, 6 Nov 2024 00:47:39 -0600
Message-ID: <8ccae9bb-8582-4c08-9dc3-f5608bb69aee@ti.com>
Date: Wed, 6 Nov 2024 12:17:38 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: ti: icssg-prueth: Fix 1 PPS sync
To: Andrew Lunn <andrew@lunn.ch>
CC: Jakub Kicinski <kuba@kernel.org>, <vigneshr@ti.com>, <horms@kernel.org>,
        <jan.kiszka@siemens.com>, <diogo.ivo@siemens.com>, <pabeni@redhat.com>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>,
        Vadim Fedorenko
	<vadim.fedorenko@linux.dev>
References: <20241028111051.1546143-1-m-malladi@ti.com>
 <20241031185905.610c982f@kernel.org>
 <7c3318f4-a2d4-4cbf-8a93-33c6a8afd6c4@ti.com>
 <20241104185031.0c843951@kernel.org>
 <e5c5c9ba-fca1-4fa3-a416-1fc972ebd258@ti.com>
 <6a230b28-9298-410b-b873-21000af4c0f3@lunn.ch>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <6a230b28-9298-410b-b873-21000af4c0f3@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 11/6/2024 2:30 AM, Andrew Lunn wrote:
>>> I think you need to write a custom one. Example:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/drivers/net/ethernet/meta/fbnic/fbnic_time.c#n40
>> Ok thank you. I will add custom function for this and update the patch.
> 
> Maybe look around and see if they could be reused by other drivers. If
> so, they should be put somewhere central.
> 
> 	Andrew
I have looked into it, and seems like wherever this is getting used it 
is written as a custom function for that driver. Seems like writing our 
own is inevitable.

- Meghana.


