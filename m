Return-Path: <netdev+bounces-174013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C6CA5D061
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 21:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7519189F33B
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 20:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5C9262D2E;
	Tue, 11 Mar 2025 20:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XtajkNZn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762791E833F;
	Tue, 11 Mar 2025 20:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741723581; cv=fail; b=ZbUCEq7arQYa6LrW4oeQsiSGpeDIZi+zhQ9CHsqu4lDP4C7oDUz835yK/fGncgziYwNYtmcS72WSDWNqCnuyUIcCj1k97jxtdXotKBZ2Pn9TrUwiQdBc/D+vBp9xfx+bxsJZTjX6OXwVhk1LTMKQOu8QhtAJqM3tHkOcZq+H36Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741723581; c=relaxed/simple;
	bh=fGROHracf9RgVmSBwe4utJJM5ZnIjOGOVqhlL+VhJCM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=GLLF+fRsKk973JdKJI3NVYo5Cd/oc4Lbhf+OJE5MrfS9Q+pr/DyznZAkQJe4TCCYOdWYMgFJQmzRCoCkBRw9J0+/JZQBJ3tt3Q/OhFfxHL3F7ukCPdNsGrVoKwRWa4Azeuk6tlGj3oco7Pc10ZKjlAp1xkUaxfCkgLUx185S7fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XtajkNZn; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i75A/ZIC+mSeJ9bZV8ix0+WpM5nTWtNqiMD8VOrXU5HrGb6Q2ceEKNpWmCRgn9OA+MGNO74N5lncT2a1PCFCZGVFjdIXHgkSBjBAp5hRSy6E9Xjnyf596FM8DDoVzUyUMvajNgq4bps7R46ETy73i3oQawC6mnUR7xf0q1CvjlJIkbUH3jfAzD433ZO5gAeY2lxHrE+oPVzXOg2KfLVW9fdQEEpkeIpyIvSg1S68CUitt9q7+NRB/iqxbA+14Pd+xysTM4S9v7ndpL18wvyHVLFpPnOiEz85Qt33ZRQYNWP1SPrkj0tFpkMk2hwSD13/e0SdpFcMCa4sWQY/TdSixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRJD0y+DrCieFilx1LTg36zO/ctjqOH2UOVjiQS5RQM=;
 b=LsrPwdhJExMzRLnHXXzw6w7XRFGbfTXfPCK8lTxY669+MU979VoE9WmEZ8mATWgTZfVFSZCz5bFLrZbHYaHzbrvippmnDdnEidvxGVVLnQOMYUW7BlcwznUzlK23udaW3oQnb09cBSp6WIEXpywnJlm5AR1ixHp95KKDjtM/6UASPnSWCBTOzlmhsz54yRMRgu4JFLqd2+dlvtEFeNW6y3RmhJobRZz28BTPntabpiOA7w9WRPzW0szikylt+I5c8w/DrYtG7dKtuX9fGAEwj83+QXJbcUyYTq2682+1RWcLR5hHgMWDoyBguHqkFcmw/ULEYsy+l4exrsC/FaI2/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRJD0y+DrCieFilx1LTg36zO/ctjqOH2UOVjiQS5RQM=;
 b=XtajkNZnLxbcn43fKycExa6lR3I6SjKwQulHFRB2sxCc4qoneG+YdEAxwgaT79zZwx4H2c+PExIlZih8QvN/0o+zfom/5aZe1pAgjNfSe44Tv4/SYI47HYUdJM3fX/3bFdW58607anqGbkuLWZgZ5RnPgsSZj6h1afnfSD6E10c=
Received: from MN0P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::6)
 by BL4PR12MB9479.namprd12.prod.outlook.com (2603:10b6:208:58e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 20:06:16 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:52e:cafe::b0) by MN0P220CA0014.outlook.office365.com
 (2603:10b6:208:52e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.23 via Frontend Transport; Tue,
 11 Mar 2025 20:06:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 20:06:16 +0000
Received: from [10.236.184.9] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 15:06:14 -0500
Message-ID: <1104f4b5-460c-4681-817a-43512f1b03d8@amd.com>
Date: Tue, 11 Mar 2025 15:06:13 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v11 13/23] cxl: define a driver interface for DPA
 allocation
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, <benjamin.cheatham@amd.com>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
 <20250310210340.3234884-14-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20250310210340.3234884-14-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|BL4PR12MB9479:EE_
X-MS-Office365-Filtering-Correlation-Id: ca0d263a-5c29-446b-6dad-08dd60d82e78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUx6T2dlRVFIVUdscXFwVGdKa1JhRS93MFludmowMGVxN1lBWlExdEtXN0ls?=
 =?utf-8?B?MS90dUt6MVAwQ1d6d0kzSjZROGRuc3ZIRUJsWUlvNDhBcmVFa2FhYXR4clNo?=
 =?utf-8?B?R0NaZWF0T21RZzdHVHZ1Q2xVd0V3Sit3UkRLdlNoSVRaL0h0YWZlS1RZZW5a?=
 =?utf-8?B?QlcveWc2TlFCcm9UWTM5T0RicDJuYndrU2NGOW5yRXlVZGlHL3VlRHBHZVEv?=
 =?utf-8?B?T3AzTFlqVStheUJUdnlJZGw3d0xwN3p2a1NTNGgvYW1JSU5JZXpON0dXLytW?=
 =?utf-8?B?N1dHSEpvMGtaclNyRDNBcUUvR2YwRmY3MUQ3eG1wZVNyQTRmcFVOZTIrNG5W?=
 =?utf-8?B?OFhDbnhPYlFEalRRTy9XU2VieWtxYklhWEprNUsvM250YURUdVhuc3Q0S3hw?=
 =?utf-8?B?L0NaR3ovSzZES0QwUzJhRGcyd1RwZVNKSmpRZ2RORTJrQTd3RG5UTjFyaWxL?=
 =?utf-8?B?Wk5mb2V4TjlaVndGeGhXSlFEeVdMeXVQTUFyRmY1VzlzRFB4TDM0MGwyRmhW?=
 =?utf-8?B?dHdYWWdHN3pSczdhVXhFWldmY2dWZUQ3Uk9aRDJZdk9UUzhEa3hrclJncngw?=
 =?utf-8?B?eEJTQUZibXowNTNscm5tVkZNUXg4NC9HdzJLZUtNQWpkNXIyS1ZTMVplNUkz?=
 =?utf-8?B?bUJhM2dIUFRlZ3RpSDhsU1d0dFUwVzZpVFNacTRNVElDY3RKZVl1ajNnRWtV?=
 =?utf-8?B?NHVDRFVNSUFaTm5OSHZwTmlzS3Q4VFJQaUhVeDBWTWNhdmxYQkVaL1llM01m?=
 =?utf-8?B?Szc0Vm44K05Cc0xpdndWekJTRkFIN21TczhXaVJ2WnUvRTd4V1JlMW9jY2Jl?=
 =?utf-8?B?YUtHb3dVSFZMd2g4czM4WFg3djFUNTNPQmN1dDRpQ3hlODAwc04zQTZ5S0d2?=
 =?utf-8?B?QXVoaG1DR042am82aVBUdXJDdWdCRlNnY09PRGlZa05pQUo5YU1pVkVveUNu?=
 =?utf-8?B?UExDaVgxMmtURExSWnNxLzdLNUdBdElmVjdwbkVZOTVnWXZoUlNuUkZIS0hE?=
 =?utf-8?B?Rmh4WFVoMkpEM1pHdkhPa016WllGdkNtVWUyVWlHdEdpa2tqWmt0MkF5dVBq?=
 =?utf-8?B?VWdPaVpid2pCcUZ2Z21xbnhIVklzTEFJajJmYlBzZ0dvcFh5NU5XeGhzS1Rm?=
 =?utf-8?B?bW5waGtqU3lNWG1uaU55dkh1bm1QdjZrMGZrTGpHZmhzQVJzQ0JoYUFmd2FR?=
 =?utf-8?B?ZDZ0MzlPbFNieHhTNUE2Sm9YVUFJUXhEbFN3ZkdKdk9NckVrQ3FNRFUyVzVv?=
 =?utf-8?B?VXp1dHZCUUorZHlCdTNCR1VidFF6SjUvWmpSSHpxb0wxQ0xZK2pwZkF1Q0Rp?=
 =?utf-8?B?aWx0TUJnRFhmb0E4R3F0d1VKWXFDM1NHVGVPNmxtVnRmVy9KM3NXUHozNVUr?=
 =?utf-8?B?RXNKVHduMVdQTTZ6M21vNWIxOWdMNExHVmYrL0h4TW11akQ3OFYyejJMVXV1?=
 =?utf-8?B?SWYvejdRaTRSU3pTUFBUam50THlHNmo0UkI2bjNRVXVoNGhPVENwOVdHL1BD?=
 =?utf-8?B?YWs1OThIMVdGdjM0ZVpFOS9rTTJ1cVI0NDAraGdESlBHTy9DOFpEanYrUUc4?=
 =?utf-8?B?UlFPRjhyTnpNdjZiYytnRkFwN1AzVFl5cjZvTjdkQ2FEU3YwSnMwZlhkV0Fl?=
 =?utf-8?B?dG0wWWd2YkRGMkFrZk9USmMzM2drMW5zMkpHbS82VXpPL1hXVndYbk51MFl5?=
 =?utf-8?B?RnFxS0ZlaW1DQ2hMQmIrSFY5dU13Yy9OUlIwbnEyRkR2UFZPQlY3T0RVMmE3?=
 =?utf-8?B?TTZTMmlrZTkwbG81Y3FpUHNCanRkdkhqV01GSnFuOXpBUFVHZlhMcDZlVmhF?=
 =?utf-8?B?WmxId0xMVGROcGs2SkxJQWsvbU5EbjNsU0tlaTczc3kzRlN6QVR3RUhvVmF2?=
 =?utf-8?B?V3lwOFptRDN5MHlMeDdnTGRubzVhN2RCaTZ5MTNHcHhJY3hSM1dlS0xObEc5?=
 =?utf-8?B?dk4xbnBiL0RHMFc2VWFvT0VOckUzNUpud3dBbTJ3cHgxdDk1UzhNS1RaR3Z0?=
 =?utf-8?Q?b6CDiWNX4fQ9G4w/Ywd8MXF9AVqerw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 20:06:16.4856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0d263a-5c29-446b-6dad-08dd60d82e78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9479

On 3/10/25 4:03 PM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Region creation involves finding available DPA (device-physical-address)
> capacity to map into HPA (host-physical-address) space. Define an API,
> cxl_request_dpa(), that tries to allocate the DPA memory the driver
> requires to operate. The memory requested should not be bigger than the
> max available HPA obtained previously with cxl_get_hpa_freespace.
> 
> Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

