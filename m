Return-Path: <netdev+bounces-269604-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KN8UL/Y7vGl3uwIAu9opvQ
	(envelope-from <netdev+bounces-269604-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:09:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1512D0965
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 008BD304B28E
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C28D397E75;
	Thu, 19 Mar 2026 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Q3m9VfYY"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012020.outbound.protection.outlook.com [52.101.43.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6893815E9;
	Thu, 19 Mar 2026 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943105; cv=fail; b=eV5/FoPRfH3WMYeUJafGX4/vx6MNDtyQLK6stCXsIS9YzW4Ckn/mhsayhaTzA3EeHHXySrH77kfmkdgqFnltCYKfPtGEYstm92nQRWnG3HozaADFewaxefKCoK9N2IDf5h8lqwUJ7mGX8168nPaHuh45ETqjzjSc2exzwYnazj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943105; c=relaxed/simple;
	bh=VLsenZxLnVcdRmK4s1PB/cpHtZ3PUjVtjL/9WhxKudM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EvN8QxfAfaxVhJZ8IfqYSHz0iW6gb0ewXl/i7poM7dvfU+PTLeMUi+WIdP4+V0YPSCmP/+2YjQAV4OkTuvolVoc1sbCR4lC/9Oy52OHVoqIokfELz5SKIIZwVzN7jpbdGCBGyjHCsmr+E93TH6zeOfdnh4NHR85cblg+n4HhbVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Q3m9VfYY; arc=fail smtp.client-ip=52.101.43.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPce9mTtG4CnNzYFdJVZPps9pay9j4D2mzZ5IX3y34Fq2Qi7xqcifdpMlluGch07UkHbBUAbrL+krVAbyy/JlavISVJN2PrcbqMbDM9Ec7ydUBGpMhSCJCUSvLxPEaEjKVzcbMd+IeQ+UmDl6jfONCQCw5zAAwmxKdz13jsGoVnWeCznFkW14m3A5rpi+nyr+y1/DHwpO3DMpSoYVCr11I1n7t5YvR4IO9miIeKR4mtsRyWTqUqHLafRxEzfZYPpLJD79pG7QWeeYrHaqp2M4lAR4dUZHmDH3KwlAj983QMrhyQ2inXDCbcLvCu7fS2O48LR1NhAJ8n1Uw3J1hqdYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mqf7YkB52zMt2nbDstugVZMbpccqIvvjsISXO24hPqU=;
 b=O6B/9ak6ieDA6RaM4CJPht3TmkBBUSxYw4eiiiiDx5VecB/AALcnhuLBVhbvkQfT7Muey+YrQp8lHHnL402IRTDMGZ848zqT90ZrIEjFc/VHA+98YjjK4/kIVka4GY/PFIjb8JESaeZEZ1R+wcrkSsy9jCsGjSjB1aP5FgXlw/snVPsmllaCnojFUypXhUWLT3EZLu3KQOfSFfOK7OneXrJg+mJzxo/noZ9Pe2azFvrk4jB6/aPTBRWR6E5ztRZkkA2427M/o0soSu+VKFZiHg0n9XujkDcITbMeGY0260glcPTZ5c4Mkdn1A8G2VM/UeeGMX2+Eeik/lfQlqvN3Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mqf7YkB52zMt2nbDstugVZMbpccqIvvjsISXO24hPqU=;
 b=Q3m9VfYYdB/fL/1nhoBaqKVIx2ertuqQbwjxoNLaS3fj7A+CWsY09F5YvkmrIe/ohyEo7ewq8E3iH2q04eR7CCI36Nvhn5D0YO2Hb5DPnzq1knkjE6cYYJrmbjHJDp5ZHhrAMm48kEe2yof15kRvDGLoMoqy5R8HQu07j6Ttslc=
Received: from SJ0PR13CA0182.namprd13.prod.outlook.com (2603:10b6:a03:2c3::7)
 by SAWPR10MB997813.namprd10.prod.outlook.com (2603:10b6:806:4e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 17:58:21 +0000
Received: from CO1PEPF00012E64.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::d) by SJ0PR13CA0182.outlook.office365.com
 (2603:10b6:a03:2c3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.20 via Frontend Transport; Thu,
 19 Mar 2026 17:58:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF00012E64.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 17:58:20 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 12:58:20 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 12:58:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Mar 2026 12:58:19 -0500
Received: from [10.249.132.48] ([10.249.132.48])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62JHwEHd2956565;
	Thu, 19 Mar 2026 12:58:15 -0500
Message-ID: <517d5c73-5e84-47e9-9d1e-4991bd550a42@ti.com>
Date: Thu, 19 Mar 2026 23:28:14 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] arm64: dts: ti: k3-am642-evm: Add ICSSG0 overlay
 for dual EMAC support
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>,
	<danishanwar@ti.com>
References: <20260311053852.1034244-1-m-malladi@ti.com>
 <20260311053852.1034244-2-m-malladi@ti.com>
 <8598edfa-4201-47b4-8929-be80dcca4617@ti.com>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <8598edfa-4201-47b4-8929-be80dcca4617@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E64:EE_|SAWPR10MB997813:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e259962-6afd-4a77-2112-08de85e11b84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mtairyA/iKqEnquioRmRYxJhtCUm1NLV+hSOxmbljWC0Liro2vZSC7AyfTCwH2e0RrSbUN5QDTBHhMknr7LWq+jZ03FSOQMclEOZPKB7wHUOaAa9gERN2Za8olCRGoFXrUnj1cSEB8ZK2zZFwy5k2ZbWh7uzk4w4e1baG4zQL3E30+BLXczEa3tZ6i1196PAkR8OODzDXe3VBQg+fGgdPZoTIihqgvfaqkerXOlOY1n1ZBgvG9z/MB4UqguGMfh3WvqftxkhgvnUErLr/QM6P3Gqk/tS45nd8jvAtLRPrH912WiRMDgToXpaEPojtLcZqRBv9SGod1ABLeSFDqNLo4zntQkuNsYsk17yuxy4wwz+oyDGEPdB20cUk+eTookNgbBVYWcxTeB1+GFVVDoDonVUXHR0wbDRZmnl49+33pD7nIEbTtnYxeMlfZwBBOf9Mmkfawj1HxYtdoy8bkPAfWMdMJaKgIHpZ9+qtuD1aDauuCXTVQyhSVVIQCt5dwQWiHqtzeneW+atLaKX+mYhotNKbVkKYtU+QS2x0BXkD2sGkgql6sx45bHG8g0SmX8h8GeHgzqqdXa9ESzClXxtlHuIFcxRBBZ9plAWYceclwqTYItgDmXo6L8FQv43qkZq6qpt6MhYdrHTN81MrSbTmeyB06JQcso3Bsu04CoLY6oAbJTwz7BeZ+LVTdcWuX2K6rhorXCgL2iBsAm/3eFZdA62osbcGjyC+vrCR2lUpsI=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KEsgc8IcACByod9gRcXyeqfwCKgaTfLJ5nJ554OkNos97MMXGKY0StJxZ88YTZb9ic6egHEBOiTNy9FmoxXylI6945C9b0j06+mqFB8Z8ZnVFRBkSCy9HjAafe9GvT5x9QWBW7O5s9Jj6zlN2UT3El/ipmzRX+8RnJmY9755B9hoLpA5hnQUUQeJzqY5oo9JVAwgMdvrLO/93JEAmf3XLmHhyiUAG9pmedSUZ4ZtoizQnepqE1CFJvPzz9d/VleUsGepdWTPZ7UOr39OVyOYZ+gS9+RN35rd/FJ8F+AOUoEuvO+f0sypUFNWZSikjRqL7zGL0GWqRUJSS5yulCPNNgkrD8ZhENs8t2ITAYDiQDtapFZQu7h2rCp18bVErj3NRluIXyWEgj49Ie5Ch1s/z2k3uzKIQYsrvxjQvJlWkQBcG44NAwFwiBDSdYKEyCcq
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 17:58:20.7711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e259962-6afd-4a77-2112-08de85e11b84
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR10MB997813
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269604-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:dkim,ti.com:mid,ti.com:url];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 2E1512D0965
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Vignesh,

On 3/14/2026 6:01 PM, Vignesh Raghavendra wrote:
> Hi
> 
> [...]
> 
> On 11/03/26 11:08, Meghana Malladi wrote
>> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm-icssg0.dtso b/arch/arm64/boot/dts/ti/k3-am642-evm-icssg0.dtso
>> new file mode 100644
>> index 000000000000..f19acf1896c3
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm-icssg0.dtso
>> @@ -0,0 +1,168 @@
>> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
>> +/**
>> + * DT overlay for enabling ICSSG0 dual EMAC on AM642 EVM
>> + *
>> + * AM642 EVM Product link: https://www.ti.com/tool/TMDS64EVM
>> + * DP83TG720 daughter card link: https://www.ti.com/tool/DP83TG720-IND-SPE-EVM
>> + *
>> + * Copyright (C) 2020-2026 Texas Instruments Incorporated - https://www.ti.com/
>> + */
>> +
>> +/dts-v1/;
>> +/plugin/;
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include "k3-pinctrl.h"
>> +
>> +&{/} {
>> +	icssg0_eth: icssg0-eth {
>> +		compatible = "ti,am642-icssg-prueth";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pru_icssg0_rgmii1_pins_default>, <&pru_icssg0_rgmii2_pins_default>;
>> +		sram = <&oc_sram>;
>> +
>> +		dmas = <&main_pktdma 0xc100 0>, /* egress slice 0 */
>> +		       <&main_pktdma 0xc101 0>, /* egress slice 0 */
>> +		       <&main_pktdma 0xc102 0>, /* egress slice 0 */
>> +		       <&main_pktdma 0xc103 0>, /* egress slice 0 */
>> +		       <&main_pktdma 0xc104 0>, /* egress slice 1 */
>> +		       <&main_pktdma 0xc105 0>, /* egress slice 1 */
>> +		       <&main_pktdma 0xc106 0>, /* egress slice 1 */
>> +		       <&main_pktdma 0xc107 0>, /* egress slice 1 */
>> +		       <&main_pktdma 0x4100 0>, /* ingress slice 0 */
>> +		       <&main_pktdma 0x4101 0>; /* ingress slice 1 */
> 
> 
> Any particular reason to use ASEL = 0 unlike every other definition of
> main_pktdma that uses ASEL=15?

This wasn't intentional change. I used claude for making these changes, 
so missed this. Thanks for catching it, will fix it in next version.

> 
>> +		dma-names = "tx0-0", "tx0-1", "tx0-2", "tx0-3",
>> +			    "tx1-0", "tx1-1", "tx1-2", "tx1-3",
>> +			    "rx0", "rx1";
>> +
>> +		interrupt-parent = <&icssg0_intc>;
>> +		interrupts = <24 0 2>, <25 1 3>;
>> +		interrupt-names = "tx_ts0", "tx_ts1";
>> +
>> +		ti,prus = <&pru0_0>, <&rtu0_0>, <&tx_pru0_0>, <&pru0_1>, <&rtu0_1>, <&tx_pru0_1>;
>> +		firmware-name = "ti-pruss/am64x-sr2-pru0-prueth-fw.elf",
>> +				"ti-pruss/am64x-sr2-rtu0-prueth-fw.elf",
>> +				"ti-pruss/am64x-sr2-txpru0-prueth-fw.elf",
>> +				"ti-pruss/am64x-sr2-pru1-prueth-fw.elf",
>> +				"ti-pruss/am64x-sr2-rtu1-prueth-fw.elf",
>> +				"ti-pruss/am64x-sr2-txpru1-prueth-fw.elf";
>> +
>> +		ti,pruss-gp-mux-sel = <2>,	/* MII mode */
>> +				      <2>,
>> +				      <2>,
>> +				      <2>,	/* MII mode */
>> +				      <2>,
>> +				      <2>;
>> +
>> +		ti,mii-g-rt = <&icssg0_mii_g_rt>;
>> +		ti,mii-rt = <&icssg0_mii_rt>;
>> +		ti,iep = <&icssg0_iep0>,  <&icssg0_iep1>;
>> +		ti,pa-stats = <&icssg0_pa_stats>;
>> +
> 

-- 
Thanks,
Meghana Malladi


