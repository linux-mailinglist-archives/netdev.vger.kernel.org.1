Return-Path: <netdev+bounces-258374-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIVAEDL/jGn4wgAAu9opvQ
	(envelope-from <netdev+bounces-258374-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 23:14:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E8F1280B0
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 23:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39003303B4DF
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 22:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFD934D919;
	Wed, 11 Feb 2026 22:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RetaHdRc"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013049.outbound.protection.outlook.com [40.93.201.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B909322A3F;
	Wed, 11 Feb 2026 22:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770847945; cv=fail; b=XXjk2OjDL3MpVR5f8j9GMu7iZJdwiSOLw+AJJtudzuvuVDgCPr7pbKd+NTJpEGYOzA2ftMXSQirM1KODzBWztpJRIWzDokWxVrhIXdaWgFl9o4sA+LBK/9unB8MmeTBp7aIAAdgDhMIucUsxQ092V1Hdz5CxXvq+CJZ8us4DfVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770847945; c=relaxed/simple;
	bh=8CCmvZPp1hvlZwuj0NnwQWMc/8YqmfUWB8O5sHcSZnE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=IKPDVB/5LTTv2LQt4MMKo8/o7CnuX2tlIHvh42yGs/D9OM3dTtl8t+eXvJPzN+grm2HDbDTbsPuCdI97sXEoggnmXH9ympVi4kYDIT8XgsRtZ5h/36D98kkSrLUK23naUaYWwJAtVoFmp8jtiIwh7TolgnG2TAZgZtTIiBkqT0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RetaHdRc; arc=fail smtp.client-ip=40.93.201.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1hykDgkWj/htKTcskXrcXub61XNK4dbirhySoFKiL2Fx4kiHu+CJvq9oGBBs+CVSpPoOamapAxSHR9axwlvEUmIpyqdredQNIOy/zbdLxxSx/jLFId/mKXYImICFVHemoOY+MEbJEzOvVkyjGB2yus/TSrNWey+mPtPtThhXsR7EXcsKk1bH6P3woL4hGWQ4ZCoFixdoWTo8t3w+H2stYRMlj4pEAaZPmbhV440jNb9zEC8lPFEWu+HfXFZ026ndKU3BMJ0mTP9ecFM0Q40Jhpzmmd/9tyyAOu0XWIxZgCPLbhnAiu4xpvFBy4uyRS3W2AJcpDoRPbOohGf15P2Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cv5USmF+aelVs+G5LZm6PxCKznsqLpZkRqTXTZKA6jk=;
 b=Bh/31wBkWOzEvXUgoMpN3UzIYQjZPixxruB0V14ehiUbC2cN1OzIQ//9lvXvsujGRDm+qS8HOj+KBmk1Ee/yvJX2Ez4WZ0WaJa1mIxmZRIlsnbfmEOpXWRwNO0/SS5JKWG0HHUeMWPSPgietQYaV18QBU7sQtIpc1V7v4lSaC94XuwnspkSuvEGhhC1ZQKZ+rpT1+2xknXjKi01V1AOqn8wUJFtKNaE/F+LYnwi2aSX57Q7bJ5yMXK8iKdOZrdECnVBTM1BHiz4dpF1+9DLuK1v/9pxqwpnNR9JlIByK8eiuYC88D81RLItnCrziCIqnQlK9qGtloNtcDAHwIqq/lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cv5USmF+aelVs+G5LZm6PxCKznsqLpZkRqTXTZKA6jk=;
 b=RetaHdRcgFV4soj1GdpwA1ArZkoxgwqMJCfJwNSC/YQpja+S6VY53wnGwDNLkYo6VbbL/dAWwCKpK6Bz3/Gmvrrb2SUCs3DzJHldcOycTtxLgVkKRKe5+jazah9DuYxLQpkbXu2VkpCUAY6SA9In5N31GMKFQmy2Q4cb1EoyCYI=
Received: from MN0P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::29)
 by PH7PR12MB6835.namprd12.prod.outlook.com (2603:10b6:510:1b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 22:12:18 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:52a:cafe::7d) by MN0P221CA0018.outlook.office365.com
 (2603:10b6:208:52a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Wed,
 11 Feb 2026 22:12:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 22:12:17 +0000
Received: from [10.31.203.44] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Feb
 2026 16:12:16 -0600
Message-ID: <62e902d5-043c-42ce-b75c-f2b82511029a@amd.com>
Date: Wed, 11 Feb 2026 16:12:15 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v23 14/22] cxl: Define a driver interface for DPA
 allocation
To: <alejandro.lucero-palau@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-15-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20260201155438.2664640-15-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|PH7PR12MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: 0617e64a-ed5d-4061-7731-08de69ba9e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vk41SkswYkxjWld2VTlMU1RMQ2pwdmI0SDk5eXk5Zmlza2M2TGI4azcyL3I5?=
 =?utf-8?B?Y1dKWjJUVzRIYzI3V2xrME9VQTJNaEFpdjIvOFBoK0Y4R1Y4MzNvcjZ3Y25R?=
 =?utf-8?B?VUY4Ty9EMUdHRVBSMjZxVUY0TE5HUkpNN3RpZ1AyV0FnNS9EUm5NaWNwRkhU?=
 =?utf-8?B?b1g4OFNvOURjUmhVODBqNTRZd1djcHNLVHM1OGpyVW9CWXVjakg4TnB0bi9W?=
 =?utf-8?B?Z2hoaWxtTGIzWmN3QWd1V0g0N1RmVHBGSVlWbmNidXEwb1QzNmczNHhMTU1O?=
 =?utf-8?B?SVdzcjQyN1ZPWlRjVTM4RUxmeUNzT3JvY3RQMktjYkYzOC95STE5TUM5Zm5z?=
 =?utf-8?B?b1A1Wi9QNkhxYnNQdjZxZVdWSnNHaE43cmFuWm9iUmZ0WER0Mk5meEhLY0pw?=
 =?utf-8?B?bEZ3UW1zL0plUmFjTWhuRGFGck1HNjR2QnBEYm13OTFDYWRtbGtvSTVPNlJ5?=
 =?utf-8?B?R05heDY2Yjdwc1BHWHRTWVp6SjY4c3MreVFIR2Q3OVNtNytiaWEvTURTa2dI?=
 =?utf-8?B?bnZ5L2JxcFJ0dXMvQVNxQXIrOW1DMFdraVEzZWdFN2s2K2VNZm9ISG5GQ2la?=
 =?utf-8?B?ZWdPa3FmMzZPQkVWLzRjMGNGOU9UQnZUdUhBZ1ZwT1V2SWc0aDVtRmI2ZnRU?=
 =?utf-8?B?WldORTJsZGJ0VmdCSW1DenQ5a212UFdvdC9iY0x1V081Vk9LMFBXQ0k0a3dp?=
 =?utf-8?B?ZTBVek0zZytrYTRvcVpQQWxFNEtjdE5LU3VlZnJwSTI4UlZUdEcweDhlY1dE?=
 =?utf-8?B?QW1teEZBeDdzRHlrcmt4aGc1TXJ2NGRHR0dGbUpNRzFLUE94MkIyQ0thejIx?=
 =?utf-8?B?Z3VlYTRwMDdkbmp3bEQ4eXg3N3dJOUZ5OUpJU3QrWWhNWDdBb3BGeHZYN0g4?=
 =?utf-8?B?OVBtanU2WEc5QVpqa1M5NElmRkVnU093OHhsMHdFZ2p5QXlJaXdFclhGNlM3?=
 =?utf-8?B?L1dlVS9HUzJQcXdqcUdOdWYraUp5ZWFZQjRRVlhyOU54NS9TQkZ4UzUrU1dP?=
 =?utf-8?B?RWZvVlRsdUxleEZLZUxLU2lnREtzMUxIQTBmbGZ0eDBKY05veFplbUo4Mk9S?=
 =?utf-8?B?WXNadXpUOFdJVjhnd2tjdVN0dTlmdVdUODR4V1FUVTRYUFBkejFwOEExUnJN?=
 =?utf-8?B?RC84L0RxUTV3bHRjTWpNdFFiYmlNVG44VnlJZkVabmRRRW80M1FUblZRblAv?=
 =?utf-8?B?UkZJMzZVZ2RYaTdyVFc0S1gzc3JlSUlNOVpXV1lhVEhoTzRmOGVHREtrWWFj?=
 =?utf-8?B?cW1lcmpaL0pWeXU4NE5UdVJkOFVnTituM3YxOVZBakt1SEpYWk02NXF5K1BR?=
 =?utf-8?B?ZWVMeTlJUlMzYUdOOUlsY3V1VlRkalRKb3ZQUFhVZFZ4UnQvR0hHMEtOamJ6?=
 =?utf-8?B?ZXdES3RlWm4wQ08zTTJhYVF5Mm53ZGZXT0tkaHNtMzlRVk9aTDUrQzVXS3A0?=
 =?utf-8?B?cW5wV2diUmI4eUd2R0dPZ0pCV2pNalIzMmczQy8xNEhMcWhhVVZXNnV1Y3Ir?=
 =?utf-8?B?TlVyMHRhSlhQMGtzbWR1MGJLUzNjZWt5NG1sZCtoMVZKdWszMVB5VjFsKzVV?=
 =?utf-8?B?KzVXUWQ0b21OcXZ3UGwwN2lxZXN1dXhuOUlMQ3VWVkRoVVVxL3F4MGpyR3E2?=
 =?utf-8?B?Tm1iWkxpWE5hTGU0Qnc5V21namtjTGpMMlJOMkVYQVBzSE9Jc3BzeWZOWCtz?=
 =?utf-8?B?S3ozYzdYbEtyVi9iZEErTDI5VUptZVpRSGpOTFRvdkNDRTRQWjN0bUlNOHNy?=
 =?utf-8?B?STFzZG93aEc2bk9Gb0xTYUwyWjRCWHBlcUJvQVBHM3NPNWJFclZocjVkWEJS?=
 =?utf-8?B?aDVLRXpmaW5LOXVrNW5QajhyQVJGemNFUEZlZ3FWQlNXNnF0ZEJMVE9oRTFk?=
 =?utf-8?B?RGx2S3ZURjRUS1F0YkJ6M1pjWnB3ZFBHbUFFU1RXcU4xczFQVUt6NVdwbEky?=
 =?utf-8?B?bHN1Ti9SLy9Nc1JmZXVzaUJYQ0VFSEdLWnRLaU95Ni9rbkErcUpEN1dlRjNY?=
 =?utf-8?B?STQ2cnQzSy84aFFneEtwU3N4bXhlM3hQTjZScC9PZ0NUTXNQYm9BNzkzZzAx?=
 =?utf-8?B?YTVUOExrMjlhOEdnczJxUk5ZNjhBYU5HeW9pY25zNlFvc3p0d3o2eWpscms5?=
 =?utf-8?B?WVBUOU8yUmJEbWYxQVhkbndIK2xPY2FZaHNSaWdUUXRVYStvUVlPbC9IMnBL?=
 =?utf-8?B?ZlA0b2F2dDlybStxUFQwNUJGSHZ5WHNneTQwR25GMm1hdk9aRHB3Y1pLeHgx?=
 =?utf-8?B?ajVURG92ZXp1c1VlaVVUY2VEQ3ZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	toOwKdq/W8qqn7NwsRZmasyMvVN0rTfp5XB3x7KND53M4oX+F//qs7H+Yl0EVaatA3zhujAZiKgXcc4rpYr/PIM0EYiR6pmSSS0+DMnC6Ksi4uOP9YmCalLvEfad7qDaBLQug8h33ZD41XY8qIJxIwniQgo8rAdi6/b3pOunySmrzPsVwaqqh0RnPAny5QQzD+tj+s2zH9J3ww15JDZbcrrQWLsG3eiSt+wiUvybys3dYCXJ8oDb//qqyEY6VnvVmFD1YWNQYI2QKtodXzsqewiicoB7F7+LidNi5zEMnZ2alRr6wW/H6qD2Y1DRvibDAmQbc+LKgmQ3N2fHbkQNvOGz2PdK1uwfTRKeHYBhiMmGOMUsag54N8UtHVIt1stJPUOf6y4EXRdVmlc4kt6fvtUC0PnZ5xWjeO7TK+1WDLgDlaQPNfBxjaq9IP/u5ruS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 22:12:17.6315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0617e64a-ed5d-4061-7731-08de69ba9e79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6835
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin.cheatham@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,huawei.com:email];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258374-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+]
X-Rspamd-Queue-Id: B0E8F1280B0
X-Rspamd-Action: no action

On 2/1/2026 9:54 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Region creation involves finding available DPA (device-physical-address)
> capacity to map into HPA (host-physical-address) space.
> 
> In order to support CXL Type2 devices, define an API, cxl_request_dpa(),
> that tries to allocate the DPA memory the driver requires to operate.The
> memory requested should not be bigger than the max available HPA obtained
> previously with cxl_get_hpa_freespace().
> 
> Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/hdm.c | 84 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h      |  1 +
>  include/cxl/cxl.h      |  5 +++
>  3 files changed, 90 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index a172ce4e9b19..d60a697f12cc 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -3,6 +3,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
> +#include <cxl/cxl.h>
>  
>  #include "cxlmem.h"
>  #include "core.h"
> @@ -546,6 +547,12 @@ bool cxl_resource_contains_addr(const struct resource *res, const resource_size_
>  	return resource_contains(res, &_addr);
>  }
>  
> +/**
> + * cxl_dpa_free - release DPA (Device Physical Address)
> + * @cxled: endpoint decoder linked to the DPA
> + *
> + * Returns 0 or error.
> + */
>  int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_port *port = cxled_to_port(cxled);
> @@ -572,6 +579,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>  	devm_cxl_dpa_release(cxled);
>  	return 0;
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, "CXL");
>  
>  int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
>  		     enum cxl_partition_mode mode)
> @@ -603,6 +611,82 @@ int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
>  	return 0;
>  }
>  
> +static int find_free_decoder(struct device *dev, const void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_port *port;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	port = cxled_to_port(cxled);
> +
> +	return cxled->cxld.id == (port->hdm_end + 1);
> +}
> +
> +static struct cxl_endpoint_decoder *
> +cxl_find_free_decoder(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct device *dev;
> +
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	dev = device_find_child(&endpoint->dev, NULL,
> +				find_free_decoder);
> +	if (!dev)
> +		return NULL;
> +
> +	return to_cxl_endpoint_decoder(dev);
> +}
> +
> +/**
> + * cxl_request_dpa - search and reserve DPA given input constraints
> + * @cxlmd: memdev with an endpoint port with available decoders
> + * @mode: CXL partition mode (ram vs pmem)
> + * @alloc: dpa size required
> + *
> + * Returns a pointer to a 'struct cxl_endpoint_decoder' on success or
> + * an errno encoded pointer on failure.
> + *
> + * Given that a region needs to allocate from limited HPA capacity it
> + * may be the case that a device has more mappable DPA capacity than
> + * available HPA. The expectation is that @alloc is a driver known
> + * value based on the device capacity but which could not be fully
> + * available due to HPA constraints.
> + *
> + * Returns a pinned cxl_decoder with at least @alloc bytes of capacity
> + * reserved, or an error pointer. The caller is also expected to own the
> + * lifetime of the memdev registration associated with the endpoint to
> + * pin the decoder registered as well.
> + */
> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
> +					     enum cxl_partition_mode mode,
> +					     resource_size_t alloc)
> +{
> +	int rc;
> +
> +	if (!IS_ALIGNED(alloc, SZ_256M))
> +		return ERR_PTR(-EINVAL);
> +
> +	struct cxl_endpoint_decoder *cxled __free(put_cxled) =
> +		cxl_find_free_decoder(cxlmd);
> +
> +	if (!cxled)
> +		return ERR_PTR(-ENODEV);
> +
> +	rc = cxl_dpa_set_part(cxled, mode);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	rc = cxl_dpa_alloc(cxled, alloc);
> +	if (rc)
> +		return ERR_PTR(rc);

Should cxl_dpa_set_part() be unwound here, or does it not matter? If it doesn't matter:
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> +
> +	return no_free_ptr(cxled);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, "CXL");
> +
>  static int __cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index d1b010e5e1d0..2b1f7d687a0e 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -667,6 +667,7 @@ struct cxl_root *find_cxl_root(struct cxl_port *port);
>  
>  DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_device(&_T->port.dev))
>  DEFINE_FREE(put_cxl_port, struct cxl_port *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
> +DEFINE_FREE(put_cxled, struct cxl_endpoint_decoder *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxld.dev))
>  DEFINE_FREE(put_cxl_root_decoder, struct cxl_root_decoder *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
>  DEFINE_FREE(put_cxl_region, struct cxl_region *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
>  
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 783ad570a6eb..4802371db00e 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -7,6 +7,7 @@
>  
>  #include <linux/node.h>
>  #include <linux/ioport.h>
> +#include <linux/range.h>
>  #include <cxl/mailbox.h>
>  
>  /**
> @@ -276,4 +277,8 @@ struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
>  					       unsigned long flags,
>  					       resource_size_t *max);
>  void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
> +					     enum cxl_partition_mode mode,
> +					     resource_size_t alloc);
> +int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>  #endif /* __CXL_CXL_H__ */


