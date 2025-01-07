Return-Path: <netdev+bounces-155864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BDFA041B5
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 15:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9621676BC
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029EF1F8AE4;
	Tue,  7 Jan 2025 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="T3CXUnR0"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8460A1F8AC6;
	Tue,  7 Jan 2025 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258570; cv=none; b=ZMFZ9QmEAT8Xg3lmc49WoOVBofuTXGcsqi8WAmBhIEj4peCDkBIdpUh6uf9tT1tgAMjuw7JFVTP5pHwjAq1s2AZleEbHf7YasWUa0sYdseH4U2E0xSuE/VhqlPhY9r6URQDQPDUW5gnjaILbx9lIE0kQzDqEz6hZQbSmQS/4tfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258570; c=relaxed/simple;
	bh=TuwQwfEOb7ycKI9yxwZzNBwZncciizGCV0JH4nNnU2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lqoNf5GOaSw/ABhhZfWT5LhHpFmcnefg3QP3eqcVWHGk8bdUcMbEKIzho1z65YUQGeTF7oaZ3zoWSS/XKMMvLkvbCXdEqYd/PF1rhhvoKv1AkRY3Vx+W2Olw1QbXmD5nS7y0V8DUcVzmcZmhDZ5Za107mIJ3Q2xaCgOgwItSMTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=T3CXUnR0; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 507E1w6I016352;
	Tue, 7 Jan 2025 08:01:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1736258518;
	bh=2rOUVlJtZ8uljbYcwOtBufLmiKSlIWfZvWmApMuUFrM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=T3CXUnR0gYOTdLBETqJF9pSz61jcO3F0K7B9XT+gbyJ7bGVi+MWA7BpgBYJmwC6a6
	 oQcUUqnsgsXSu5B776R8QcSrmccqgG9bALfzl4I6C5nacV0V9BZbxFsB9gSN4Yl7bj
	 xcZkc3+jrUzezQHy39T5+6xSQuozYDUtIU4ZLXl0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 507E1wqk054341
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Jan 2025 08:01:58 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 Jan 2025 08:01:57 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 Jan 2025 08:01:57 -0600
Received: from [10.249.129.69] ([10.249.129.69])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 507E1oVJ078399;
	Tue, 7 Jan 2025 08:01:51 -0600
Message-ID: <5cc13a7f-b3f9-42d5-b9e2-7da5cb54af5b@ti.com>
Date: Tue, 7 Jan 2025 19:31:49 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] net: ti: icssg-prueth: Add Support for
 Multicast filtering with VLAN in HSR mode
To: Roger Quadros <rogerq@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
        Jeongjun Park <aha310510@gmail.com>,
        Alexander Lobakin
	<aleksander.lobakin@intel.com>,
        Lukasz Majewski <lukma@denx.de>, Meghana
 Malladi <m-malladi@ti.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman
	<horms@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>
References: <20250103092033.1533374-1-danishanwar@ti.com>
 <20250103092033.1533374-4-danishanwar@ti.com>
 <31bb8a3e-5a1c-4c94-8c33-c0dfd6d643fb@kernel.org>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <31bb8a3e-5a1c-4c94-8c33-c0dfd6d643fb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 1/7/2025 6:53 PM, Roger Quadros wrote:
> 
> 
> On 03/01/2025 11:20, MD Danish Anwar wrote:
>> Add multicast filtering support for VLAN interfaces in HSR offload mode
>> for ICSSG driver.
>>
>> The driver calls vlan_for_each() API on the hsr device's ndev to get the
>> list of available vlans for the hsr device. The driver then sync mc addr of
>> vlan interface with a locally mainatined list emac->vlan_mcast_list[vid]
>> using __hw_addr_sync_multiple() API.
>>
>> The driver then calls the sync / unsync callbacks.
>>
>> In the sync / unsync call back, driver checks if the vdev's real dev is
>> hsr device or not. If the real dev is hsr device, driver gets the per
>> port device using hsr_get_port_ndev() and then driver passes appropriate
>> vid to FDB helper functions.
>>
>> This commit makes below changes in the hsr files.
>> - Move enum hsr_port_type from net/hsr/hsr_main.h to include/linux/if_hsr.h
>>   so that the enum can be accessed by drivers using hsr.
>> - Create hsr_get_port_ndev() API that can be used to get the ndev
>>   pointer to the slave port from ndev pointer to the hsr net device.
>> - Export hsr_get_port_ndev() API so that the API can be accessed by
>>   drivers using hsr.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 83 +++++++++++++++-----
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |  2 +
>>  include/linux/if_hsr.h                       | 18 +++++
>>  net/hsr/hsr_device.c                         | 13 +++
>>  net/hsr/hsr_main.h                           |  9 ---
> 
> Should we be splitting hsr core changes into separate patch first,
> then followed by a patch with icssg driver changes?
> 

I wanted to make sure that the changes to hsr core are done with the
driver change so that any one looking at the commit can understand why
these changes are done.

If we split the changes and someone looks at the commit modifying hsr
core, they will not be able to understand why this is done. We will be
creating and exporting API hsr_get_port_ndev() but there will be no
caller for this.

>>  5 files changed, 97 insertions(+), 28 deletions(-)
> 

-- 
Thanks and Regards,
Md Danish Anwar


