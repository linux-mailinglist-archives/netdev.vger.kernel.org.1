Return-Path: <netdev+bounces-98397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6C28D13E3
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 07:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7831F23F2B
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 05:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2CB4CB4B;
	Tue, 28 May 2024 05:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JTEx46+Z"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1886A4CB2B;
	Tue, 28 May 2024 05:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716874170; cv=none; b=K7MgQ+uEl2A9IX0vDstQRS+X6R6ZRGnWPQ6BaSbGCgfLLuau4pat6t19YU30siruorSO6VsK6ZIoFr5UCfAoN8hwHSUdKGnQdrL/FrXPDzB3UpKHpN7olr30e+2GhoJ5uv/VaMe0w3EHHs31n2pw9OAsb4IICbVKHTm6Gr9Ltjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716874170; c=relaxed/simple;
	bh=XFd0stmfvih21xWWcU4aTX2RVyZ1rCmh9kUw8IaXCU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IkBSahhw/cndFk8rrWqWzqsCJlehLsbOmZudQtG+8jRfggkg2GXwE9ezFIAlUhdQU5dGWuZqhI1QSlqvZ/sCE/z1TVeAYnQN7N9pGfvmapFrnTAS9uBPMBMIS1DZq/mG0AE7fNWg+5/zPo+NDUzZ6YnKga4+5OR6xUEixrjr0rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JTEx46+Z; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44S5SiMX080021;
	Tue, 28 May 2024 00:28:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716874124;
	bh=Au+V2jHmMZS62BTdB/hRuB16oG3domx+bjJTJ69vBIk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=JTEx46+ZULOZHGGJ5blYxkdyCxjO4aEs3hO+5MFDw4uRuFCOFEZ2h5H36f4gLm52K
	 IqmMhU4N1kSsZRZ0YW9lp16HALh+6ZCSSuSFnqmUAX2gjxrvJ7kQJEIpwcE/EP8ayY
	 SIMqg9pVeBmd1x4TXpZus4UPiC/FQ+PcI0pB/5UI=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44S5SiGN018043
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 28 May 2024 00:28:44 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 00:28:43 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 00:28:43 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44S5Sa7o030705;
	Tue, 28 May 2024 00:28:37 -0500
Message-ID: <a8af43e2-09e9-46ac-86f0-baa48d810fa4@ti.com>
Date: Tue, 28 May 2024 10:58:35 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/3] net: ti: icssg-prueth: Add support for
 ICSSG switch firmware
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: Dan Carpenter <dan.carpenter@linaro.org>,
        Jan Kiszka
	<jan.kiszka@siemens.com>, Simon Horman <horms@kernel.org>,
        Vladimir Oltean
	<vladimir.oltean@nxp.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Diogo Ivo <diogo.ivo@siemens.com>,
        Roger Quadros <rogerq@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>
References: <20240527052738.152821-1-danishanwar@ti.com>
 <20240527052738.152821-4-danishanwar@ti.com>
 <4f5a6d1b-e209-45b1-acec-ce84ca1c856f@lunn.ch>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <4f5a6d1b-e209-45b1-acec-ce84ca1c856f@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 28/05/24 3:44 am, Andrew Lunn wrote:
> On Mon, May 27, 2024 at 10:57:38AM +0530, MD Danish Anwar wrote:
>> Add support for ICSSG switch firmware using existing Dual EMAC driver
>> with switchdev.
>>
>> Limitations:
>> VLAN offloading is limited to 0-256 IDs.
>> MDB/FDB static entries are limited to 511 entries and different FDBs can
>> hash to same bucket and thus may not completely offloaded
>>
>> Example assuming ETH1 and ETH2 as ICSSG2 interfaces:
>>
>> Switch to ICSSG Switch mode:
>>  ip link add name br0 type bridge
>>  ip link set dev eth1 master br0
>>  ip link set dev eth2 master br0
>>  ip link set dev br0 up
>>  bridge vlan add dev br0 vid 1 pvid untagged self
>>
>> Going back to Dual EMAC mode:
>>
>>  ip link set dev br0 down
>>  ip link set dev eth1 nomaster
>>  ip link set dev eth2 nomaster
>>  ip link del name br0 type bridge
>>
>> By default, Dual EMAC firmware is loaded, and can be changed to switch
>> mode by above steps
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>  static int prueth_emac_buffer_setup(struct prueth_emac *emac)
>>  {
>>  	struct icssg_buffer_pool_cfg __iomem *bpool_cfg;
>> @@ -321,25 +401,63 @@ static void icssg_init_emac_mode(struct prueth *prueth)
>>  	/* When the device is configured as a bridge and it is being brought
>>  	 * back to the emac mode, the host mac address has to be set as 0.
>>  	 */
>> +	u32 addr = prueth->shram.pa + EMAC_ICSSG_SWITCH_DEFAULT_VLAN_TABLE_OFFSET;
>> +	int i;
>>  	u8 mac[ETH_ALEN] = { 0 };
> 
> nitpick: Reverse Christmas tree
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks for the review. I will change this to "Reverse Christmas tree"
and send next revision.

> 
>     Andrew

-- 
Thanks and Regards,
Danish

