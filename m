Return-Path: <netdev+bounces-117154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C4A94CE92
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 12:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 936C11C21336
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 10:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910321922EB;
	Fri,  9 Aug 2024 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fAQ4yKGm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6366B1922E9;
	Fri,  9 Aug 2024 10:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723199137; cv=fail; b=Gk/O3Ii4g7nyC7v//tIS3vFS7Tyclt2/p2HdOWlGJHWa7PF/9W/M1RIGvGpqwTkJcWWxecjjsa/PtoBR8CFNc4ow686VlYtbORtdKrt0Ydyz23Ns6zAxM1S2dEzvE/vhPSsa/TfdfK6GZyH3W2M8C/DieObtqFNRAOm9FZ9I6zQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723199137; c=relaxed/simple;
	bh=98s369Q5tcfFULNj2wykdKHrehq5bBhslAiq0dOGKrU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iv8UN/x+VK20YLPdR5t9CqHgm9W/4NATuI+xpiARHJzViDkEjsd4+fymyjGF7egqN++9YLF1WP9GmCAfFeDPU/dqm0DuTXjbuz8WPkGoz0jsSYnQfJ4wBUHZOeDLyGCvHXg5fXuK9lNcUyq1z1OhZtWqn/Hug3UEaAFqa7GTk8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fAQ4yKGm; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qt/TVzCnqF5UVdRBBruEq6v6Ibb74yXlUeDYh9KVa3ql6lwk1pYndfg5EZmSGwaq/BKk+UH+gSDjmKMvcRvLMDM7sQHy3dBfwP4ASdOUIxJNoMU9uIuRAtwOsBNbvXZ0Ef2yKwJMs/laUmbeBuKYRpSxa5UEaRH+2Um3vx36x/x6PQ+p5tGCVO425vObRtTI9JKC5PMcL03Wb2y0Lip8I/xHE533g9ierGOJ/wBJMiyu2uIyHk2AEvFfsC+HwxiJ2bh1IzVZ/vIGtpIgiRa0K8p8Tca9OBgBAkdO7BzDVNIz2LDId9AEPPJhH8eNXqYjDjTDCtVbjEnmmykIprhEFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75wzFhM6Ab2ZmF9wjEmXH6NOMRLQbueHqLR2ASJSlAg=;
 b=emoMvrgywyAGUeS2N116UMpHXh3LbynB1PEs2dQZD3uZ+hmSsP6hVjJsD0mUrzSyAAasHrNAmNUCCybuaQED+uJJzJEJOIYUs+zMY+90UD0ryC/+q13VrJqeAejPHj/gGgQjM8TTaDT2bWwsPlx2d0BNm/92CVYUkw+Xpv3SysiKtm6YTzyGQlTbebhbE8h34W/9HmIBDe34qNKPgtk8SErtFyGxlbmBofKeFJx7347YV8wr5GEekz1gGUepeRNW1Xl8g3e8RfUujCdkPVB0EeJn+YLHnL85i6N9gJ90IlcFe5Gj4ZVIDsgXf4zznhDpGVqOfk6Wb04h2gC+wnxe7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75wzFhM6Ab2ZmF9wjEmXH6NOMRLQbueHqLR2ASJSlAg=;
 b=fAQ4yKGm1KhHnNfxRrpacj83ccAEc+ZO6qA0O5X8Xjq/8GE7CJPb7ThCuzJ2RQZ4OghfIMwLoyWi3B0yq3o1FiJx1B821VYlZMfn+b8mkHNhlN+LI1vCRws4/FcLOEO2oYGCTvRHUbJ7u1AoacZCCwnfrpfPECAGp91ULodBx3BpY47UnZ8GXR0yJuXsVc2LfuRk/9Dghdkd0zYfACrksLdwPUK66F717DJIiUUsS33lpYgTcyOO3iLevqly28IsA9OH8BegnHLscfiwZWsNNkLMHOD5HvkTz5n0AlHIaCWMyby7hh1KoYe46bzo27KPon2DxA1BygdtGfn+Ej7CHg==
Received: from CH2PR10CA0024.namprd10.prod.outlook.com (2603:10b6:610:4c::34)
 by DS0PR12MB7897.namprd12.prod.outlook.com (2603:10b6:8:146::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Fri, 9 Aug
 2024 10:25:22 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:610:4c:cafe::6c) by CH2PR10CA0024.outlook.office365.com
 (2603:10b6:610:4c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15 via Frontend
 Transport; Fri, 9 Aug 2024 10:25:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.2 via Frontend Transport; Fri, 9 Aug 2024 10:25:22 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 9 Aug 2024
 03:25:18 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 9 Aug 2024 03:25:17 -0700
Received: from localhost (10.127.8.11) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 9 Aug
 2024 03:25:14 -0700
Date: Fri, 9 Aug 2024 13:25:14 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: Dave Jiang <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>,
	<targupta@nvidia.com>
Subject: Re: [PATCH v2 04/15] cxl: add capabilities field to cxl_dev_state
Message-ID: <20240809132514.00003229.zhiw@nvidia.com>
In-Reply-To: <7dbcdb5d-3734-8e32-afdc-72d898126a0c@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-5-alejandro.lucero-palau@amd.com>
	<e3ea1b1a-8439-40c6-99bf-4151ecf4d04f@intel.com>
	<7dbcdb5d-3734-8e32-afdc-72d898126a0c@amd.com>
Organization: NVIDIA
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|DS0PR12MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ffa2959-8e98-4798-881a-08dcb85d936c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HztcADhob1uGiAyJrlx82+hZodWE+SbUB6fmmP5qpHuYvrfNVJLJ8PgUAwYc?=
 =?us-ascii?Q?Y2VxkkcwUkPWS710aifnlAFGNFtANH/HN/kw5zSI2bzqHxEfa3fott9Q0tkf?=
 =?us-ascii?Q?PTcH5pnWn63ozkeBJEGcRN8vcQTYu1N7LEzvmJnLZ5EZPms+gIMtNw+AhVaI?=
 =?us-ascii?Q?Y9mq5DXC2b8SZaHDpX6l5JKvkftRvkSw9g9czT9GQ8+PFORcajB/tFxDcK9Z?=
 =?us-ascii?Q?610cFVynteXzYFj/imZ7AHWOBzRrEkkF4saBs80kjL9mYPsnzaOTvcJyRYeb?=
 =?us-ascii?Q?SX0wpxnkRMmlnIoxh6DNwALMHMG5fWYH9rGjSNJyzOr3JGyxJg+I6wOXpES1?=
 =?us-ascii?Q?o2kjkVGmKXHT91YSWa6t+RXK85GarLW9OvzMwyBL8qV/TBQcCErzH3NCl0WL?=
 =?us-ascii?Q?E6ds7KcjKVuUYkeUBRCOjmfVMtuhjh1BhVIeG7Tj0WDtyTq11YpMNrrKWniH?=
 =?us-ascii?Q?He9MIQ0Yaev0hq5JaI9ZRxdO+66iEw7hgQAGwocdKkYQzcwQlYA2/6IlDCYF?=
 =?us-ascii?Q?6D0V2Sa69Z4VxBFRpQe6PwgjuE77fkQ+6ac2ruiraBqjkFcT/FWC7FgyHzAk?=
 =?us-ascii?Q?4+bwMwC3fe+1DctucR8Zw16qCl7Bl2HXSpJ6FdbWsIgb1z1oAPTwGyqSpJMJ?=
 =?us-ascii?Q?a9/Ahe+S0YQ9z3htLPRVhcLgmhQbW8XDprvKHkekAVcGblV0aRWKgqY/A151?=
 =?us-ascii?Q?lC/hG2L6ha9swz6HQskYBXAuylT0wIxs1dPEIoZBItnV813zFV47U7NoIZqZ?=
 =?us-ascii?Q?OjUsBEPYZoPiM1a4sMOzPUAPuqUiv6jguJfYFlGZvTyPcXn//QJdBcd/kftA?=
 =?us-ascii?Q?xtGDQpzA9CP/QAmZwdEySCS7kGPJN9fXIPVDWqhPhh9tGnFlJOdyd555RcXy?=
 =?us-ascii?Q?1gQ5IvaV5elBLsk849hw4aigdc/PUhrgyisA6bocyY+uOdxo9Qu29K41I1sp?=
 =?us-ascii?Q?bHNmdpe8hcgMcHk8Qq57jxki66MXYSAGO8isBCCiEetmIFzDPtCUYek1x+wx?=
 =?us-ascii?Q?xBtYU1aiuqbL0SaR/MMvzhel1Kid/XQwadhoQVXFTEk5oGyPu8MGDGxVRF0j?=
 =?us-ascii?Q?MaDGFO3QW6xTbemWtZ09eHVFbch7O9binhFzASlQyaShVBfOlbsQBcysAr16?=
 =?us-ascii?Q?T1VIhYpBEaar30BsVwSi/DwzueEvSwNU3nTwfbVJzP4ktISkrT9hF8rioeVA?=
 =?us-ascii?Q?oQcGiG5IM/ENljR2TN8aBtip+AFms2eqNBau6B/zrzv1+tOM2geMUO/wxSdc?=
 =?us-ascii?Q?1egaOQq6Tv4Uh4bJSyD08jZXkuIwrT9h7+Q/JZKTulsG2L6P/NRNzGpWoobL?=
 =?us-ascii?Q?cm9FqNVWrHZ+hk2zijAlvjk/60cEhLEk2s7snYrhU6AS79ARWTLpMYaPPGMa?=
 =?us-ascii?Q?/VR6MddYM5gIGX1mhMOnD1LmbViI08VMltQ8s/lTSGuzGQlz6K7iBXfn9OT6?=
 =?us-ascii?Q?WJy/iujVqtkknyfS4EmJMVm2pWXcgSXz?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 10:25:22.3194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ffa2959-8e98-4798-881a-08dcb85d936c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7897

On Tue, 23 Jul 2024 14:43:24 +0100
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> 
> On 7/19/24 20:01, Dave Jiang wrote:
> >
> >>   
> >> -static int cxl_probe_regs(struct cxl_register_map *map)
> >> +static int cxl_probe_regs(struct cxl_register_map *map, uint8_t
> >> caps) {
> >>   	struct cxl_component_reg_map *comp_map;
> >>   	struct cxl_device_reg_map *dev_map;
> >> @@ -437,11 +437,12 @@ static int cxl_probe_regs(struct
> >> cxl_register_map *map) case CXL_REGLOC_RBI_MEMDEV:
> >>   		dev_map = &map->device_map;
> >>   		cxl_probe_device_regs(host, base, dev_map);
> >> -		if (!dev_map->status.valid ||
> >> !dev_map->mbox.valid ||
> >> +		if (!dev_map->status.valid ||
> >> +		    ((caps & CXL_DRIVER_CAP_MBOX) &&
> >> !dev_map->mbox.valid) || !dev_map->memdev.valid) {
> >>   			dev_err(host, "registers not found:
> >> %s%s%s\n", !dev_map->status.valid ? "status " : "",
> >> -				!dev_map->mbox.valid ? "mbox " :
> >> "",
> >> +				((caps & CXL_DRIVER_CAP_MBOX) &&
> >> !dev_map->mbox.valid) ? "mbox " : "",
> > According to the r3.1 8.2.8.2.1, the device status registers and
> > the primary mailbox registers are both mandatory if regloc id=3
> > block is found. So if the type2 device does not implement a mailbox
> > then it shouldn't be calling cxl_pci_setup_regs(pdev,
> > CXL_REGLOC_RBI_MEMDEV, &map) to begin with from the driver init
> > right? If the type2 device defines a regblock with id=3 but without
> > a mailbox, then isn't that a spec violation?
> >
> > DJ
> 
> 
> Right. The code needs to support the possibility of a Type2 having a 
> mailbox, and if it is not supported, the rest of the dvsec regs 
> initialization needs to be performed. This is not what the code does 
> now, so I'll fix this.
> 
> 
> A wider explanation is, for the RFC I used a test driver based on
> QEMU emulating a Type2 which had a CXL Device Register Interface
> defined (03h) but not a CXL Device Capability with id 2 for the
> primary mailbox register, breaking the spec as you spotted.
> 
> 

Because SFC driver uses (the 8.2.8.5.1.1 Memory Device Status
Register) to determine if the memory media is ready or not (in PATCH 6).
That register should be in a regloc id=3 block.

According to the spec paste above, the device that has regloc block
id=3 needs to have device status and mailbox.

Curious, does the SFC device have to implement the mailbox in this case
for spec compliance?

Previously, I always think that "CXL Memory Device" == "CXL Type-3
device" in the CXL spec.

Now I am little bit confused if a type-2 device that supports cxl.mem
== "CXL Memory Device" mentioned in the spec.

If the answer == Y, then having regloc id ==3 and mailbox turn
mandatory for a type-2 device that support cxl.mem for the spec
compliance.

If the answer == N, then a type-2 device can use approaches other than
Memory Device Status Register to determine the readiness of the memory?

ZW

> Thanks.
> 
> 


