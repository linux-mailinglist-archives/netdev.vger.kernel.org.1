Return-Path: <netdev+bounces-259529-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDQUBIdIl2m2wQIAu9opvQ
	(envelope-from <netdev+bounces-259529-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:29:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2AF161339
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF06A301386A
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 17:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC5834E755;
	Thu, 19 Feb 2026 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rOS4lvtA"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012038.outbound.protection.outlook.com [52.101.48.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE8134DB74;
	Thu, 19 Feb 2026 17:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771522173; cv=fail; b=tkHqXjI1EKsmIbXAtDXL0VdCA501pEfr4aL5e176qC+MvZZaiiMnQoXBcS9qgDZoE44XFXkJ0sT5837WQyV+ieF/3AZita6HkHa5kMtWfiRPHvp2Y/uIyXPYeyKLp76/3vni67rxSLKMjwfgZqU8LrtkQzTK47L9b4Kq7eURsEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771522173; c=relaxed/simple;
	bh=QJMpDPeQweoeVNYoSlLBwBK1w30KnxlXTHY4jxoeqOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Uc2ZnDQe1qQZSDnzT+M44T7awAvPD1m5FGLf8urI2nUQGzHM9hLs3DTkCeKB1CmTnIIMXkMDynaGij1+1NFS1rJGYAcLekE/OfWwSyLcT9ECYZq1G5mMLDj+db4pLr48F/KQFrkh+uSRcCFzTT9sCMm5cfB1gEaZHK7owSLzysI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rOS4lvtA; arc=fail smtp.client-ip=52.101.48.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TrdD2mUz6Zu7QctK1yX2blopOhRREGDYtoA2EK1LKd7o/Pd+4hdwh7PikLhpi+deM5sP06kJwqS0FBzS2JN9YG7o4HzIemLG4g62nox3UVvP6Jtqr8PFPzlqGvjWGy2Pw6vTZh1CZa40DuZLPZDwd8I3QTmy2zJXRp1g/CFaHLYD7MUxCzPY3YYloEdXaFBFTO6WxWxuvA29LmE4TWNhuF3pnpyiylL/9Fd4k57GUPL6wvA/w7V7gSk3qDWF0Lz/14hNHNbi2on0XWm+XB5raLPfMd0MbEZpPuMvLwP8hBG+oIsFG8C7IuZRJ8ix2RQTgb/ascSfYhOwJCb5kK5RKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7ORYj21d3ErELfTMfXygQJq6+55cnzsz7NSgXyUDWY=;
 b=Sdsa74nxXIG6BYPsy2iK5GhaGU4wTiHJZW76kC/A+2mao9hFoNTX1atF4SHAfI1tZOXKJ5rc7P9C5c7AvMXSZUWmhqIFC2pmz3O3i6W/bQ1snN/e3Xr0h46VmS75d4/+S3udbXl7TB84smB7b3k+nsB+dZUOcmRVa10mvYAwqfydXmwrnismtW6/gJ5BaUBprjEikfP0o3z5TXaiybWJvlAK0Ot/yRXBWrijn8cOhRWNK2/M0VpHhxt/9wXlXX4m7Q7HlgNuDmi0hfNhTQSh3dc7fuM87yDgX7WdK5w4/2eqWLoILyLmb/B83rhDBc3ThyOblvaMLtam0lMlQyilbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7ORYj21d3ErELfTMfXygQJq6+55cnzsz7NSgXyUDWY=;
 b=rOS4lvtA/5ns8jrlwBsDwbVhybFAruYpYpxC1EpJv/2wNWdo+FYCtshrdYi5YYf4+guEmQmWr+x7QCIrvWi98GsMkqrh0IIIJgr/IC1YmjQ2wjFHeepTmCIoZLtmefi7+jih/2AVRUPyQpuvuB4aF8CGk8liGX1GCApGuYyi1Eg=
Received: from SJ0PR13CA0210.namprd13.prod.outlook.com (2603:10b6:a03:2c3::35)
 by CY3PR12MB9704.namprd12.prod.outlook.com (2603:10b6:930:102::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 17:29:26 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::1f) by SJ0PR13CA0210.outlook.office365.com
 (2603:10b6:a03:2c3::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 17:29:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 17:29:25 +0000
Received: from [10.31.194.67] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Feb
 2026 11:29:09 -0600
Message-ID: <d2b4e4a6-52a6-44a2-aa07-8027d1b90c40@amd.com>
Date: Thu, 19 Feb 2026 11:29:09 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 12/22] cxl: Define a driver interface for HPA free
 space enumeration
To: Alejandro Lucero Palau <alucerop@amd.com>,
	<alejandro.lucero-palau@amd.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-13-alejandro.lucero-palau@amd.com>
 <ea32b5ee-52f8-4d8c-9d82-903d21dc1335@amd.com>
 <10e631df-6a2c-45ff-aa90-71d2ad073e76@amd.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <10e631df-6a2c-45ff-aa90-71d2ad073e76@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|CY3PR12MB9704:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ba0fe83-8ef0-4197-c15c-08de6fdc6dc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmZSMmI3YWR2YmFLUEFDaUhYRVBvR1FZaTdjMGZVZHhUR3JOZi82VWU2bXlT?=
 =?utf-8?B?Z0FZWnNRNjhlM2VnZW9YYThiVFQ2R0lubC9VbGpyckF4WWJ2MDU4SHYxQTFv?=
 =?utf-8?B?aE1YZzdBZGJobE12NDVxbExjd0kwWFMwTTJaei9KS0loK3FNUjRmMXBVdlNn?=
 =?utf-8?B?SnI1NFVCN3p3WVhGeWUwQ3ZCUzJQaG55WmZhTHA2eE9LZjJrSXU1ZGtXbUxO?=
 =?utf-8?B?ZCtRaU9pcm1nOEFMcFA4UGkxUFZMaVFHTWtlQmp1ZmtkNlFGUXJ0cVlmQTA3?=
 =?utf-8?B?b3FhTEl6bC83bjZjQTJ1V2dUdmVjdUF5aEc4L2VCamplYnhDVHZrdWk5enIv?=
 =?utf-8?B?NkxsaWtkcFNQL0x6cUVqd2d2My9HRkIzQ2s3QnhpQTlmM21RVytRaFM3bVBh?=
 =?utf-8?B?Vm05eC9ycUNEV0treXB5eERBT0tMVkNDeGt3eGljYy9IeGxqOVZrM29qTjdD?=
 =?utf-8?B?ZUJuWGlUcExtcCtvTHZHRllSRERlWnUvNFYzbjFrSHV1ZVhjWXpuakNDbFhw?=
 =?utf-8?B?aGo5c1pRU1lSa204NFFQNERTcmMxeStqV1JSRjRtaUdhRkxmOXFzSlExbmI0?=
 =?utf-8?B?NmFqL2Y5U2pROEwzdTI3M2xiTmVoTkR4eTFxMm4zWStmMVNnMldjakFtQXVm?=
 =?utf-8?B?QmVJNHlzb0lqYWs2eUxoWEpFTjIreEh5c2lVc3l0OVJuK2RJS21makZsRFpL?=
 =?utf-8?B?WDJVWVZXS0M5WFNzU0RaRnJMTThXL2kwUnpKRWRuUllXWjg3RGVSV1lxNjB2?=
 =?utf-8?B?ZkxhWktrSzdQTldySkFYVUtQZTRDRTlwOUN6enJNdjhUT2hXSHVtbVE5M25i?=
 =?utf-8?B?V2d6NGZTK0ZYWkM3Rk5nandBUngyMkkvWnYyUHUxckxjZDJWUGFYdXNRMXR3?=
 =?utf-8?B?WjdHQThBY1QvTHF5Tk4yTjcyY3JUU1RjcDdtU1Q3cmVnaHdmQVlLSmF0aEdJ?=
 =?utf-8?B?MHU1QWpPSWRzNFFxMHhVS083QWZMRHdaT2pKQjZVRWhkL3ZhU2xXV0xFdDlI?=
 =?utf-8?B?ejhVaGduRVVUZ2taUW5EUUY0RWVZZkpIYWwrZEtIZG9ycXl4VkZrSWp5WUsv?=
 =?utf-8?B?a1AzbzdmOHJ6d0IxYXZ1UGgxaGlwODBJeG1hVGplblJXeUF0aFlPT1JDMnhw?=
 =?utf-8?B?R1N2SHV6WE11SWd5aG9pWk84dUdabHpjVGxCYkJJVnZVQldzTGVvc2tNVlUx?=
 =?utf-8?B?b2ttMmhOeXVEWkdnT2xjUUY4VDZNbUlIcHVvZU01UGhaT3cySkttaUkrVDY2?=
 =?utf-8?B?Y3FYM2QvOFlVSjhpekIxVUNWVFZxanZQTHlyNExqY1J1RXNQVnloeTV3bHhZ?=
 =?utf-8?B?d1V2YXBteTV6UWlFdDN3RWsxeDczRE9jd3kxUjBhc25wcGsvVUxRNm9nQWZS?=
 =?utf-8?B?cE1pV1lwbHZUVWVXNWw4OGppVGFvYmVKcnEySGVMN21qSGJ3M2VoMGt3Wjli?=
 =?utf-8?B?TjJTdElESUdLVGVVVmJPYmVxeUt0ZVJmcThHa05SOFcyaU9QUVJCMU9tWFp0?=
 =?utf-8?B?LzFUeHNmczI3TUtJeTNkbENyZnNlZEdXZWg2NGhGY0xDVlQ0bm45cFZsTjJX?=
 =?utf-8?B?cHZXbXJ0U3IrcUpxcnF0NFB1V1hub1M3ek1XTXE3ZkJMbFlFdDYxWjRrREJH?=
 =?utf-8?B?L3IxM1lIUDI3YjJGampLZTZwZTBqaFJ3cGwvMXJSMWI1akVZa05xdGI0NU02?=
 =?utf-8?B?WUJmeWM0eHAwWFhQUVE0NE9mTm9yTW5sc1lzajB0eE9JbzFOaStuZm5OWXlp?=
 =?utf-8?B?cEY5dkZQdGJEZHZIN3VOOXg5eTdRMWdObmtTVjVSQVgrWGtvaE5ZYlIybkRs?=
 =?utf-8?B?aXE3RkU5NURwNWhVNVRhZDJGU3BuZ250dG96SmxTQUFvN2ptZVlVdmZ3QUhn?=
 =?utf-8?B?eUJPQk5FSEVDVVhiejBiTUcva3NBWUpIeDJzTndGZ3dzd3dib010MDVyelJE?=
 =?utf-8?B?bkNaSWdNSDYzVjhXd1lYM0YyY1c5RC9VeTRhQTgvOEl4SHIxcmtnYjduUE1F?=
 =?utf-8?B?WFZCQ0lraU5SYW8vaEN0V21yUTNpaFliSGNwazZSaUczc1UyTVkzckhvbi9N?=
 =?utf-8?B?N01uRHdUK2Q2NkNIa2crYStRVkxObmlISElSQ05OR0VEOGY4VDhXZEQyNkRH?=
 =?utf-8?B?dGRmZW9tRnZhUWZ3N2hnaDkybWdKV2thMHp1UXI0RHpranpkMG81cXN1Tkla?=
 =?utf-8?B?TkxDb3FHQnNWM25lMzhnZmVyZkZTRUR0TStVYkowVFZWNFFpWTdGNStZam9E?=
 =?utf-8?Q?QhcSjDGop72+VkuCVhEgzUZHBvzY593jzcF7RRhYJc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jascLZ9Tcj/wlIO2PxIAVIR775VkJtbH6Xtmgp/znTsibi6x0VdzJW9UkzV/hEbw6oX0uALTQ/lB1PfC8gRwPeh7fE2ov1CqtZnZb04EWSWTEgmDyv3sZUbn0FulgKqsSBUnUqzzojVO9FsIxyMaEOjKM0QVSI3IvM7Khck74FCWY5UZaTWwJI7kXIUbpQMvvtBa7Ro+rky1FoY2heZ/qxxqU/5AjGBzLTh+P0LMAph8Zu8mTCOPhMplUR0SI5JGPuXd/yvzIn/0u0YTkaAOlUlm4v/XNOvJteU+pxoD8SOaEof/aBrmbB8ynSQ+n+2q4h/EBtTvc/k9JDIVjolAJ+xshXKTdJYkc8Xbp5CXzCZ04IhmaIpLg0/WsgjcrvfBnj4qM9H465PA8jSv9g+0wVoXcDH8psnVL8iObwPehttsOZkAx6nr6p1AhOjEc5O1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 17:29:25.6902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba0fe83-8ef0-4197-c15c-08de6fdc6dc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9704
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259529-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim,amd.com:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin.cheatham@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7B2AF161339
X-Rspamd-Action: no action

On 2/19/2026 3:58 AM, Alejandro Lucero Palau wrote:
> 
> On 2/11/26 22:10, Cheatham, Benjamin wrote:
>> On 2/1/2026 9:54 AM, alejandro.lucero-palau@amd.com wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> CXL region creation involves allocating capacity from Device Physical
>>> Address (DPA) and assigning it to decode a given Host Physical Address
>>> (HPA). Before determining how much DPA to allocate the amount of available
>>> HPA must be determined. Also, not all HPA is created equal, some HPA
>>> targets RAM, some targets PMEM, some is prepared for device-memory flows
>>> like HDM-D and HDM-DB, and some is HDM-H (host-only).
>>>
>>> In order to support Type2 CXL devices, wrap all of those concerns into
>>> an API that retrieves a root decoder (platform CXL window) that fits the
>>> specified constraints and the capacity available for a new region.
>>>
>>> Add a complementary function for releasing the reference to such root
>>> decoder.
>>>
>>> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> ---
>>>   drivers/cxl/core/region.c | 164 ++++++++++++++++++++++++++++++++++++++
>>>   drivers/cxl/cxl.h         |   3 +
>>>   include/cxl/cxl.h         |   6 ++
>>>   3 files changed, 173 insertions(+)
>>>
>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>> index 954b8fcdbac6..bdefd088f5f1 100644
>>> --- a/drivers/cxl/core/region.c
>>> +++ b/drivers/cxl/core/region.c
>>> @@ -705,6 +705,170 @@ static int free_hpa(struct cxl_region *cxlr)
>>>       return 0;
>>>   }
>>>   +struct cxlrd_max_context {
>>> +    struct device * const *host_bridges;
>>> +    int interleave_ways;
>>> +    unsigned long flags;
>>> +    resource_size_t max_hpa;
>>> +    struct cxl_root_decoder *cxlrd;
>>> +};
>>> +
>>> +static int find_max_hpa(struct device *dev, void *data)
>>> +{
>>> +    struct cxlrd_max_context *ctx = data;
>>> +    struct cxl_switch_decoder *cxlsd;
>>> +    struct cxl_root_decoder *cxlrd;
>>> +    struct resource *res, *prev;
>>> +    struct cxl_decoder *cxld;
>>> +    resource_size_t free = 0;
>>> +    resource_size_t max;
>>> +    int found = 0;
>>> +
>>> +    if (!is_root_decoder(dev))
>>> +        return 0;
>>> +
>>> +    cxlrd = to_cxl_root_decoder(dev);
>>> +    cxlsd = &cxlrd->cxlsd;
>>> +    cxld = &cxlsd->cxld;
>>> +
>>> +    if ((cxld->flags & ctx->flags) != ctx->flags) {
>>> +        dev_dbg(dev, "flags not matching: %08lx vs %08lx\n",
>>> +            cxld->flags, ctx->flags);
>>> +        return 0;
>>> +    }
>>> +
>>> +    for (int i = 0; i < ctx->interleave_ways; i++) {
>>> +        for (int j = 0; j < ctx->interleave_ways; j++) {
>>> +            if (ctx->host_bridges[i] == cxlsd->target[j]->dport_dev) {
>>> +                found++;
>>> +                break;
>>> +            }
>>> +        }
>>> +    }
>> This may be over complicated. I'm not quite sure how it works (I'm just slow today I guess), but I understand
>> what the intention is based on the debug print below. My issue is that ctx->host_bridges is only set to 1 host
>> bridge (endpoint->host_bridge) in cxl_get_hpa_freespace(), which is the only caller of this function. At that
>> point, why have the outer loop at all? At that point, you could also simplify ctx->host_bridges to only
>> be a struct device * const.
>>
>> Maybe this gets called elsewhere later on in the series? I haven't looked at the rest yet. If I'm wrong, then
>> I'd probably add a comment saying what the cxlsd->target[] entries are supposed to be pointing at.
> 
> 
> Hi Ben,
> 
> 
> I do remember this one.
> 
> 
> Dan's original patches had this support for interleaving, then I removed it as the case for Type2 and interleaving is quite unlikely, at least right now and likely in the near future. But I was told why do not support it as it was trivial to do so. FWIW, If I think only about the use case coming with the patchset, I agree with you, but because those previous discussions, I think I have to leave it.
> 

I'm fine with that, but I would at least do the fix with the decoder position in 19/22 and make a note that the
interleave_ways parameter in cxl_get_hpa_freespace() below is currently unused (unless I'm misunderstanding
the endpoint->host_bridge member).

That way, the support is mostly there and just requires a small, previously noted, addition to enable. If you're
fine with that then feel free to add my Reviewed-by after implementing in v24.

Thanks,
Ben

> 
> Thank you
> 
> 
>>> +
>>> +    if (found != ctx->interleave_ways) {
>>> +        dev_dbg(dev,
>>> +            "Not enough host bridges. Found %d for %d interleave ways requested\n",
>>> +            found, ctx->interleave_ways);
>>> +        return 0;
>>> +    }
>>> +
>>> +    /*
>>> +     * Walk the root decoder resource range relying on cxl_rwsem.region to
>>> +     * preclude sibling arrival/departure and find the largest free space
>>> +     * gap.
>>> +     */
>>> +    lockdep_assert_held_read(&cxl_rwsem.region);
>>> +    res = cxlrd->res->child;
>>> +
>>> +    /* With no resource child the whole parent resource is available */
>>> +    if (!res)
>>> +        max = resource_size(cxlrd->res);
>>> +    else
>>> +        max = 0;
>>> +
>>> +    for (prev = NULL; res; prev = res, res = res->sibling) {
>>> +        if (!prev && res->start == cxlrd->res->start &&
>>> +            res->end == cxlrd->res->end) {
>>> +            max = resource_size(cxlrd->res);
>>> +            break;
>>> +        }
>>> +        /*
>>> +         * Sanity check for preventing arithmetic problems below as a
>>> +         * resource with size 0 could imply using the end field below
>>> +         * when set to unsigned zero - 1 or all f in hex.
>>> +         */
>>> +        if (prev && !resource_size(prev))
>>> +            continue;
>>> +
>>> +        if (!prev && res->start > cxlrd->res->start) {
>>> +            free = res->start - cxlrd->res->start;
>>> +            max = max(free, max);
>>> +        }
>>> +        if (prev && res->start > prev->end + 1) {
>>> +            free = res->start - prev->end + 1;
>>> +            max = max(free, max);
>>> +        }
>>> +    }
>>> +
>>> +    if (prev && prev->end + 1 < cxlrd->res->end + 1) {
>>> +        free = cxlrd->res->end + 1 - prev->end + 1;
>>> +        max = max(free, max);
>>> +    }
>>> +
>>> +    dev_dbg(cxlrd_dev(cxlrd), "found %pa bytes of free space\n", &max);
>>> +    if (max > ctx->max_hpa) {
>>> +        if (ctx->cxlrd)
>>> +            put_device(cxlrd_dev(ctx->cxlrd));
>>> +        get_device(cxlrd_dev(cxlrd));
>>> +        ctx->cxlrd = cxlrd;
>>> +        ctx->max_hpa = max;
>>> +    }
>>> +    return 0;
>>> +}
>>> +
>>> +/**
>>> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
>>> + * @cxlmd: the mem device requiring the HPA
>>> + * @interleave_ways: number of entries in @host_bridges
>>> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and Type2 device
>>> + * @max_avail_contig: output parameter of max contiguous bytes available in the
>>> + *              returned decoder
>>> + *
>>> + * Returns a pointer to a struct cxl_root_decoder
>>> + *
>>> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
>>> + * in (@max_avail_contig))' is a point in time snapshot. If by the time the
>>> + * caller goes to use this decoder and its capacity is reduced then caller needs
>>> + * to loop and retry.
>>> + *
>>> + * The returned root decoder has an elevated reference count that needs to be
>>> + * put with cxl_put_root_decoder(cxlrd).
>>> + */
>>> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
>>> +                           int interleave_ways,
>>> +                           unsigned long flags,
>>> +                           resource_size_t *max_avail_contig)
>>> +{
>>> +    struct cxlrd_max_context ctx = {
>>> +        .flags = flags,
>>> +        .interleave_ways = interleave_ways,
>>> +    };
>>> +    struct cxl_port *root_port;
>>> +    struct cxl_port *endpoint;
>>> +
>>> +    endpoint = cxlmd->endpoint;
>>> +    if (!endpoint) {
>>> +        dev_dbg(&cxlmd->dev, "endpoint not linked to memdev\n");
>>> +        return ERR_PTR(-ENXIO);
>>> +    }
>>> +
>>> +    ctx.host_bridges = &endpoint->host_bridge;
>> Mentioned earlier, interleave_ways is effectively hardcoded to 1 (unless I'm misunderstanding
>> something). I think what you want here is to go to the CXL root and pass in the children (i.e. host bridges)?
>> I'm not sure of what the fix is to get the intended behavior.
>>
>> It may be worth getting rid of the interleave_ways portion of this function and
>> add it later when someone needs it. You could also explain it's hard coded to 1/unused
>> in the doc comment if you know of an immediate need for it.
>>
>>> +
>>> +    struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
>>> +    if (!root) {
>>> +        dev_dbg(&endpoint->dev, "endpoint is not related to a root port\n");
>>> +        return ERR_PTR(-ENXIO);
>>> +    }
>>> +
>>> +    root_port = &root->port;
>>> +    scoped_guard(rwsem_read, &cxl_rwsem.region)
>>> +        device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
>> Can just use a guard() here.
>>
>>> +
>>> +    if (!ctx.cxlrd)
>>> +        return ERR_PTR(-ENOMEM);
>>> +
>>> +    *max_avail_contig = ctx.max_hpa;
>>> +    return ctx.cxlrd;
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, "CXL");
>>> +
>>> +void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd)
>>> +{
>>> +    put_device(cxlrd_dev(cxlrd));
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_put_root_decoder, "CXL");
>>> +
>>>   static ssize_t size_store(struct device *dev, struct device_attribute *attr,
>>>                 const char *buf, size_t len)
>>>   {
>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>> index 944c5d1ccceb..c7d9b2c2908f 100644
>>> --- a/drivers/cxl/cxl.h
>>> +++ b/drivers/cxl/cxl.h
>>> @@ -706,6 +706,9 @@ struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>>>   struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
>>>   struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
>>>   bool is_root_decoder(struct device *dev);
>>> +
>>> +#define cxlrd_dev(cxlrd) (&(cxlrd)->cxlsd.cxld.dev)
>>> +
>>>   bool is_switch_decoder(struct device *dev);
>>>   bool is_endpoint_decoder(struct device *dev);
>>>   struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
>>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>>> index 92880c26b2d5..834dc7e78934 100644
>>> --- a/include/cxl/cxl.h
>>> +++ b/include/cxl/cxl.h
>>> @@ -255,4 +255,10 @@ struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
>>>   struct range;
>>>   int cxl_get_region_range(struct cxl_region *region, struct range *range);
>>>   void cxl_unregister_region(struct cxl_region *cxlr);
>>> +struct cxl_port;
>>> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
>>> +                           int interleave_ways,
>>> +                           unsigned long flags,
>>> +                           resource_size_t *max);
>>> +void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
>>>   #endif /* __CXL_CXL_H__ */


