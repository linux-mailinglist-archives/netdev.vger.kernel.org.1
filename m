Return-Path: <netdev+bounces-225387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB596B93570
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F119C3B6D7F
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 21:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D002857D8;
	Mon, 22 Sep 2025 21:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vvxcRfIU"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011014.outbound.protection.outlook.com [40.107.208.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38E083A14;
	Mon, 22 Sep 2025 21:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575385; cv=fail; b=hO/mZk/GGGYUJIKWXvtFUyOwZM5rjseUsuBKO1dbVT9226iVAwsQtvR/2lhQ7icDpELNtk5Xc5Db+uW80rG5vJh+7PPFwotUlQCkn5udpJqC5lyQ301Hz4ZpeNC7YPbjaLqMUp/rLL/TMQgg1IBajHh+uoopZMSzBGNjc04BDk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575385; c=relaxed/simple;
	bh=Y/0IkvcmOTad4Rz3+TJsxHGXRkF3S/CKcb9yCj19FTc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=F5MtQ+7ESRTjlfeJvzbur6jisyTlBMnrXTjTyYuhd/Vjdd1s9zhPpIYXq4DrxloGv2JvfecNldXtipJGXEDD5K1KuflTvEupLwpOIzcUum8U8H3vzG5nkJ1U0u7hA7NzUAlQxkCxe84mkAGBeBklq3+651HTyoK1QRTTVlgEQRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vvxcRfIU; arc=fail smtp.client-ip=40.107.208.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJXqgyfGTgOeGE5+RH+fAXm02FdE1JgHW7tGBqXjjQoBYBCbif+sPh0KCffQm3VI9BpddMITEVfOFs+NMkAg2ewYK+9fuvU2SrQRE2t9aXEfbHjole7EIxn+vS8KpEOCYMBDB9Q1p7VcOT/59krn+4f/sYsjc/Wqxy6nYftIVw08XbpW87xp/I78Jv/jNYfdn7F5cg/bGj5YN3ds9+feFnJ51oDSzY1S27Ix8+ZoVv2HKLAQaD1B6IHZx/Vo30lC3DMIpP9N/pzNgjBy+hUl22AZIQ3k5XPDs0Hi/GUIkjP0eluEgFk7RLYYDi+4MCKlcTyOIl5kXyJsQcQQqfdFSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfiIRSuwWfZ61PQSTVajyIi27636GBYkI8/CCmajALk=;
 b=oIuHERwhMVH6NqOJjfv5cfDgdh9f29xgbAL0xF1Jy9FIaPjjoWONBdzbvv99joGJGxVCsrerr7HhJ6mtaETI4LDUyZCBngEHR2ln61wlzn+OQFzYqTe2ZqJ5W3Uk7jErxPqDQeIZOHNlXFVW+Iop9D4VPVkNaJ/V2GdizUBHvQaUiQb8dgsZGbF9mQPCMe0CR4mL/b23V8qchwYn8qTqhNOwXYcpKsmmseCJSgnimURWOaKJ6d6OURZFtIlkwPwgMEYjrJxUKTs0ePFvq2lgDxLaaTn/MCK3KjQqA4p4V4AJCmW+FEaf4eYhvDsuHBO66wJRl0l6lGXTX7clOb/w0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfiIRSuwWfZ61PQSTVajyIi27636GBYkI8/CCmajALk=;
 b=vvxcRfIUdQq2VM+b5rNYCBtzCLrdtdJQpjGAtQEsaTRP/HrFkBGFZw18VwuXifxXzvwg7t9YeeQ846dcdyiLflRhjBNr6JzqP1jqk+FOgyoCk89d/7yNFdKjF0aLA86JIlasi6GzlZ8eGq11yInFQ/Hkkztrfb2bwQfn31GB3xY=
Received: from DS7P220CA0066.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::17) by
 MW5PR12MB5622.namprd12.prod.outlook.com (2603:10b6:303:198::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 21:09:39 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:8:224:cafe::ff) by DS7P220CA0066.outlook.office365.com
 (2603:10b6:8:224::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Mon,
 22 Sep 2025 21:09:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 21:09:39 +0000
Received: from [172.31.131.67] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 22 Sep
 2025 14:09:37 -0700
Message-ID: <a23579ac-3b93-4116-b575-0dc5f1175365@amd.com>
Date: Mon, 22 Sep 2025 16:09:36 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v18 12/20] sfc: get endpoint decoder
To: <alejandro.lucero-palau@amd.com>
CC: Martin Habets <habetsm.xilinx@gmail.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-13-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20250918091746.2034285-13-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|MW5PR12MB5622:EE_
X-MS-Office365-Filtering-Correlation-Id: 17367955-4e26-4afc-2fed-08ddfa1c57a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QitrRERONDhzczlrbmowaHNxcWFJNWFxM1RFbDRobHBXSlZKZnBvYlpYUnc0?=
 =?utf-8?B?WHFmMGRTQVRxdUlTQVQ1NEtmWG5BQWRjemc1TVZKakJzcDRmZ2ZiZm5IM1h6?=
 =?utf-8?B?QkI4OG8rck1neWE3WTFuTDV4MUxMUGQxdSthU0NuU1VpOVp3aG44MHlzaTN5?=
 =?utf-8?B?dXhTZXdXTFZhM0JabnF5cXQxRFpWN0lEZHM5SkxPMHdwMy8vTjRNOTZ1L2tB?=
 =?utf-8?B?b0FpQmUwV0pnUDFXNlNmTGVESkxsN2pWbUlqaTVFZTl5ekV0SnRTRHpQa3dp?=
 =?utf-8?B?UXVIQm1aRjdRY1g0bW9vRzBnV1lXMmQzV1NEbEJVU0hSbUN4Vmp1R1VoNU1q?=
 =?utf-8?B?SDJiMWdad1V2dDJHVm9mR0s1Rzk0eGlDOTU3YjdhUmxTaUkwM05BK216cFg0?=
 =?utf-8?B?eFJJc2JRN3JwdTJUa0VhVmYxU1RLOEF5ZWZiaERrOUtvOE5BR29GV1p2Rm8r?=
 =?utf-8?B?M1dTUkMydVFyUHp4TkxjUk1STVlFMElGdlJTNG44bEkxdHFGbXR1UWZXbUd4?=
 =?utf-8?B?VzFkRmo0d01sd05HaWpJQWJ6QXlHYW53elJiRnNSU3ExbUhveTZhM1BzNG15?=
 =?utf-8?B?bnJneFV2MVpxaTBmQ2VhOE95VEh5N09yeCtGSzFDZkRXM0F0akdXcHpjMDdq?=
 =?utf-8?B?Q0pOU0NzRTBsSkhBZ1A4Mk5qZUJuVWQyc0FsbXNUZk9MUGVGSjRCWGRqL3po?=
 =?utf-8?B?UytkUGNUSUtZbEhQTjd0cC91YkhDTEpUdzczNVcwaXQwVWIwUzQwaFMvay9Y?=
 =?utf-8?B?QlI1bHNCMDFzT25vVnlKYUdRQ1BTN0ZYR3ptQWhsYjdNWkZTWHNuMWVhRmFz?=
 =?utf-8?B?WWlQZUdUd1lUY1lFNW5QVUwrZjB4b3ZMZ1hJdzB0T0JKN091dTRmR1c3dkpJ?=
 =?utf-8?B?MzVjZ1NZcXNLMklBaWs4MjJ2QzlXR25IWGI3aklGZHNFSWUrb012MmlhREZ6?=
 =?utf-8?B?R2tPZlBNdTZ2Nk5POGdpUXl0MUo3ZUtLT05JZGRTVjFTSEpKZzV6R09VMXU1?=
 =?utf-8?B?RjYvRGhqcDJlUE85UUZGLzBqbUdDT1lwVzJWK2hJUGh3QkM0amFsL2tSai9m?=
 =?utf-8?B?ZTNKL3BSRDJscmozRzBnMHhkaERwZE5NcFk5QWxjTXJYaEtGamx0TFk3L3VK?=
 =?utf-8?B?UFppa25OcWVUZ29mOThoL0tOd2RDQythQVJxZXJXNHI4OTFEeGZYYVFEeldK?=
 =?utf-8?B?cUV6MG5DRTlRTHpmN1lRSVlaNVdZd2Q2ajBGNVpyQS9idVZCVWlWSkh6enF5?=
 =?utf-8?B?UDNMQWx6MTZzOXJ1VkIydk1lVGxrdTVJTHBuV1d1N0tteE5FUmpkQU1rT1NJ?=
 =?utf-8?B?Mmt3NjF2Y1p0MHJBYUgrdUhaK3VaNWltbEZmOTdERHBDR285ejdraTlPUTdL?=
 =?utf-8?B?cXlsV09Oa3dCeE84MWdaM1dKYzhMWnB3S0I3bXJJbUNNcFZsYmdKblN2ZldC?=
 =?utf-8?B?cWZmckNKSFphZ1J5YTUrYU5FTXFmV3VRd3d4RlpJRWRzUmIrMDFhTU1GWnpu?=
 =?utf-8?B?VGxoalJCaXI5bFNYL2l4RERtRmdJSnpZK1F0WlNjZnAwNENTR2MzMVpwTXF6?=
 =?utf-8?B?U0N6SUtaWmtFZHpiUS9JQ2hNUE02RE1nSGgxMUladnpudXQ1KzJQeGFGQXMr?=
 =?utf-8?B?VE54Q05LQ2tmM202UWRKVnhFMm93aWNwZWlOSGU2ZVYxVkEwS003cUVzV2FR?=
 =?utf-8?B?VFV2RUw1Z0tPemxsZzM0SW1nWk1PNTArV0dKc0REYURySUJPNjlPYXVXaERM?=
 =?utf-8?B?dWJua24rM29LV0hIYWphYi9WVmxmMzdQc0FCVmJTZ0JZa3VDMVZpMHN3Snhp?=
 =?utf-8?B?MHRhTXNMdTlodCt3a25RQXdkai9ubW9ucEoycmMvcVB2RGdVSEtaSmt2bzVN?=
 =?utf-8?B?eXlVMnd0U3RuQWJpcXJjdWVJSlFSVVpuNHRtdjNJaGtRQ1R6ODdBR3J3UUt4?=
 =?utf-8?B?ZDd4ZWdrc3hYNDVhSG5iV0NrYjdLMlByU0ZLdkwyOEJwbFVoblRUVEhBQU5Z?=
 =?utf-8?B?SlhmeUYyTnNCaUhtMStHMkdhcU1JUTNUbWticmhmWElveFhzeEdmMVlrTnFk?=
 =?utf-8?Q?eOouO5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 21:09:39.2462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17367955-4e26-4afc-2fed-08ddfa1c57a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5622

On 9/18/2025 4:17 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl api for getting DPA (Device Physical Address) to use through an
> endpoint decoder.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

With Jonathan's change:
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

