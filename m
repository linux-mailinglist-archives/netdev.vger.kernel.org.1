Return-Path: <netdev+bounces-225392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0AAB93594
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA82442A16
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 21:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18C525A33A;
	Mon, 22 Sep 2025 21:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x4libFSA"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229A0244660;
	Mon, 22 Sep 2025 21:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575431; cv=fail; b=mT9ShH7vQlmJDbr4wlo7kCoNWe3GLcLlxsr8r4033rdvH4fU3gXpeP2Un3SqsNlhqZhG1x8pHS0dVc0WPAKlHv/KQyKb9NQVhWaU2m+/ePUd6s9FsZyoJBMyXoisKJpSki6vqk8SLk3X+pyAA1Bve6lo0GWiAXHneaAsGNB4JkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575431; c=relaxed/simple;
	bh=Q8dj+M4wdzHrhLmcbzldXtkIxWG9qsbGLNvine96Ozc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=iKkP2tQxXmrLjDDalr3SSl3/b9kZC200hvQQzIhYBURAFCHJYpiCasopsEZ4FPL9vb14N08mr/bSaM8clerMng7q6ZpAsnvQkJGFlfXFnRq+aDKew7S53uFXfqsYW4sMDPRMnUO/0IMMYRKi3rdvDGdtenHEhczCYMybign0MdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x4libFSA; arc=fail smtp.client-ip=52.101.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iwWdDQ3fDMDClZ29Gvi8DUAyZIbHgGWpqjiBZDXk3Dt/cU+uL/45Fm5OR8okO8EePoOYCwaLvbydXoYmNyAoS9o8RflGO43zybkobkC8yTRoe3C4ohtwlgA/dqwnMJqhUbD+Ef1WUqybHPUTyzCFyR/tPIU1T9L/CqHmsZcriMy2hk5engCprgbOrE9z/RjYfgayqJpI1HjVrFwwFCjXuOgBho3Qaf5KJ9gz9+UyReZp0Eosy8v5pWCprQ/ObbZaul4E4PCzJV3MF8nkpQsM6mqBklrxDudIQL7+gVHg9owLERyGFWagxQjC9sHQ+Qboiiu3d4ugYmk705BU9DHLWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3U26PYxUzYVgG8/h4x3GHKJsnAqwTdk0RzjEwY8bO2E=;
 b=QjSYq+EoXao9OjHQIoF9fXq4KbALkg6ykIu+Uc6nTxFLtAmpNWpLv+D4BzqKjDG1rEIkEC81i58/tLO7zmV6QifCKSYJYSkfHXJRztadbOrrOFCVWIgUSkSrSYzQtVfanludwMVjTiaccgB752vxBBZMM0mjI0JcnmgntAlguoXE58oKML8t4CdbZrBz94IHwU03/Zh5eUjvYVjCRJJbPF5tP/Zp5f6eY5YczImT23GyW3bExx/Ab1p8fGeLdy2lb/HcC5nmWioQ0wUFHPgXFzTM9b76xJe7fv5fw1Uw1kgRRfJGVq5/k9Srag3nL25W2bxh+mNuJgOPSoEdM94YXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3U26PYxUzYVgG8/h4x3GHKJsnAqwTdk0RzjEwY8bO2E=;
 b=x4libFSAAItWiT/ptOLySsrETyPjf3IySqETOm43Zj8MR1PjxvsQWrXMUYuzSUitfGSxC0y5Szck+D+4nPBGf+rOx5szR/91+Y0TUpCCSJnwR4Z6RsI7BkzSQNHKvO0O23Ns9mujvww2KD/lRn2J2rpiIf2XzLfzTEl+zR1wY64=
Received: from DSZP220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::6) by
 DS7PR12MB8291.namprd12.prod.outlook.com (2603:10b6:8:e6::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.19; Mon, 22 Sep 2025 21:10:27 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:280:cafe::63) by DSZP220CA0002.outlook.office365.com
 (2603:10b6:5:280::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 21:10:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 21:10:27 +0000
Received: from [172.31.131.67] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 22 Sep
 2025 14:10:26 -0700
Message-ID: <3d4bc1f2-1763-426f-a881-911be1d5128e@amd.com>
Date: Mon, 22 Sep 2025 16:10:25 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v18 00/20] Type2 device basic support
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|DS7PR12MB8291:EE_
X-MS-Office365-Filtering-Correlation-Id: 689904fb-6dae-447e-5770-08ddfa1c746e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUkrRlRxRkNJQ0dRUFlmbjBMaVRlVERncmpTdEF0NXZNbG1GMHdHK0oyZXFV?=
 =?utf-8?B?L2o2b2tyNXVQQkhodjYrdWRGdkk0bHgyVzRvaDBVZjRPc1h6QWV5NFJPbjNU?=
 =?utf-8?B?Sjc0Z2U5dEREa0tyVVhMYzU4Z2ovMGJKd1kydXJSVHFVeVdYUG9LRmVmeXlq?=
 =?utf-8?B?Tmc5N3Bqay8yZzV3SlJKdkg4dCtnUnhGZEtWWmVyVVpIUXBhbDM5RURFaUt0?=
 =?utf-8?B?cXJqQlF6Y0UyWkw2VDBTM1M2aFlDeHBQcDJ5V3E3cXBsd0YraGxSTFZoYWp0?=
 =?utf-8?B?MjFmN3pTTTFkVjJaS25xWjRsQS8ydUVCM1dRWTM4R1FFT0RoTVJJMXkyTDF4?=
 =?utf-8?B?ZlFiYkVpb2JYMXBpZk16SVlXaTNkbTkyOWRHeFdCbmJWbUw1Mlk1aWtXNFF2?=
 =?utf-8?B?dXllTzhueExPZWh4c3ZSaCtmMk44dXV4anp6eHAwQVdEcjVQUVdOenpiNkR4?=
 =?utf-8?B?OURUUjB5clpsa2dzNkRUS3RZVXB4WVVNSWlPVlZwbS91M2NZRlpOMmN4c2gv?=
 =?utf-8?B?aVNEb1gvcWVhNnU4RGQ5c2FmRWlET1daZytIVTkrSVFVeFB1VWNGQUg2L2Jp?=
 =?utf-8?B?Y0h5UkFqcjlTdm9pZGxFVFlEa3JIcEdscEJjWTYzaWR4Q3NCR0s3aUVaalFz?=
 =?utf-8?B?VU85UDFCd1NIMGxXVXg0OEFFdHRtcHAzaVJjYmhJa2w1T1FOeUlTMVFYVFR6?=
 =?utf-8?B?c1RNTHFneTBaYXRRc1VjL3Z4RWNSYkk1MXFMblJKUTRRT1BkL0FybUpGYXpW?=
 =?utf-8?B?RW1HVVhMTlJzZ3lqRCtBTXk2NFFLZkZGTVhmY3JWT1ltOVNyL2F0NW5OcTFH?=
 =?utf-8?B?NXYra1hQMmNMUnBKRXAwcTBBSUgzbmdtM0oxaU1ySTRGZkptR3p0UUZHVm9o?=
 =?utf-8?B?STZhZEZXQ2RDMVlCNDFETGhMTmt5UHNZd245YWR5VGFGK3EwN3VyeTJtREhj?=
 =?utf-8?B?dW5ncWpJejNuZTVyYkpGWGJXYnRwMTdoTm5xY0ZFNjZ6OUxHSUVFSU4rUkFl?=
 =?utf-8?B?VFo5NlJyM05GYmZyRmtZaGhjNHllaXhva2NabXVORHBUQStVSzZQaE1VNW92?=
 =?utf-8?B?L1M5Rnl5VHcweStIbzltTWhkQ1pITFVDdjZ6N3k4bVhNU2lQdjdJTmFGb0lK?=
 =?utf-8?B?YXRLOVV1bzM0c244dFJ3NmZIalJRcHlaUmgxMDg0WVg4YXlJYW10QzBaazdv?=
 =?utf-8?B?a0hBb0sxOXBZcEgyZE9KcFMxVitLMGE2TU13R2Z3dVBvMmh0eEVDdW8xUFNy?=
 =?utf-8?B?NmUrbHoyRHdsZ0xhYmpWdUFMNllTUEl1b0tnVi9wM2pOQjBrNlkvdXN2M3VW?=
 =?utf-8?B?S2x2YjlsRit4eHY4ZkprREZwcUpKQzVVYWtVclhQc0srcHVIcjltNERERkRu?=
 =?utf-8?B?ay81WFN0WHQ1MnkwcmJuVmgwMitIQlBvYWptNmlneDlDU1NGWTFHNHQ5ZWpH?=
 =?utf-8?B?MDRzU1VCOTlYd1VRd1oyMWp6dkJoWjlMT1BmRE9OTWNuMElFVlAwRmRST1hV?=
 =?utf-8?B?UTVyWDZ1a1lFVWpxZ2FsVE5tSW9vZ3NEMy92d2N0enVXWS9wUmY0VmxaWVdm?=
 =?utf-8?B?MUlKM3NwbStTT2FBRHIvWnd5YWFoZzFQdGpHNFhPZnpON2FMWnJKMkhoaERn?=
 =?utf-8?B?YlAvQkxzSTZKK2l3b3lzSmNKRU9EM2piUXJmWkY5QWdNWGxjeHFZaDZzb1lo?=
 =?utf-8?B?UlJzbHFWTVRPZlg3b1UzOUhIVnRDMEt0ZWUzYkI4OUhvOFlTcUJMeFNZbnY3?=
 =?utf-8?B?dWJzTFVwS0FkRi9acHlhK1VYUFU2bHJSaDIyR0lad3ZvR3BESlBPaUtvSWZM?=
 =?utf-8?B?NFVSa2ZUZ3JrWjZXY3llS01oNys1Y0JxVXBIZDUvQmdYV1UwZmp2OXduSUo5?=
 =?utf-8?B?WWtYSXkxWHhZOTl0ZytvRUxxTmJINVpXUWp4cU03dmkycWFGdjM5ZGRxQkQ3?=
 =?utf-8?B?N2p6TThmMXI1RjJzZ3kxVTBFWXBjb1Nyd0lRWHhZTDZKZ0s3L280UEsxc3ha?=
 =?utf-8?B?eXVKbUx5cStNVnFxOGhScEZFR3BBM1hUUXR2aUpseDlNUG5KellkUmVTNHRT?=
 =?utf-8?Q?IlLa9l?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 21:10:27.5081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 689904fb-6dae-447e-5770-08ddfa1c746e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8291

On 9/18/2025 4:17 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> First of all, the patchset should be applied on the described base
> commit then applying Terry's v11 about CXL error handling plus last four
> pathces from Dan's for-6.18/cxl-probe-order branch.
> 
> Secondly, this is another try being aware it will not be the last since
> there are main aspects to agree on. The most important thing is to decide
> how to solve the problem of type2 stability under CXL core events. Let me
> start then defining that problem listing the events or situations pointed
> out but, I think, not clearly defined and therefore creating confusion, at
> least to me.
> 
> We have different situations to be aware of:
> 
> 
> 1) CXL topology not there or nor properly configured yet.
> 
> 2) accelerator relying on pcie instead of CXL.io
> 
> 3) potential removal of cxl_mem, cxl_acpi or cxl_port
> 
> 4) cxl initialization failing due to dynamic modules dependencies
> 
> 5) CXL errors
> 
> 
> Dan's patches from the cxl-probe-order branch will hopefully fix the last
> situation. I have tested this and it works as expected: type2 driver
> initialization can not start because module dependencies. This solves
> #4.
> 
> Using Terry's patchset, specifically pcie_is_cxl function, solves #2.
> 
> Regarding #5, I think Terry's patchset introduces the proper handling for 
> this, or at least some initial work which will surely require adjustments,
> and of course Type2 using it, which is not covered in v18 and I prefer
> to add in a followup work.
> 
> About #3, the only way to be protected is partially during initialization 
> with cxl_acquire (patch 8), and afer initialization with a callback to the
> driver when cxl objects are removed (callback given when creating cxl
> region at patch 16, used by sfc driver in patch 18). Initially, cxl_acquire
> was implemented with other goal (next point) but as it can give
> protection during initialization, I kept it. About the callback, Dan
> does not like it, and Jonathan not keen of it. I think we agreed the
> right solution is those modules should not be allowed to be removed if
> there are dependencies, and it requires work in the cxl core for 
> support that as a follow-up work. Therefore, or someone gives another
> idea about how to handle this now, temporarily, without that proper
> solution, or I should delay this full patchset until that is done.
> 
> Then we have #1 which I admit is the most confusing (at least to me).
> If we can not solve the problem of the proper initialization based on the
> probe() calls for those cxl devices to work with, then an explanation
> about this case is needed and, I guess, to document it.
> 
> AFAIK, the BIOS will perform a good bunch of CXL initialization (BTW, I 
> think we should discuss this as well at some point for having same 
> expectations about what and how things are done, and also when) then the 
> kernel CXL initialization will perform its own bunch based on what the 
> BIOS is given. 

I would assume that anything that is addressed in Documentation/driver-api/cxl/ is fair
game for assumptions. I only read the original docs when Gregory (?) posted them on the list,
but it does cover some BIOS expectation IIRC.

As for the other stuff, I don't think I understand the problems well enough to comment :/.

Thanks,
Ben

