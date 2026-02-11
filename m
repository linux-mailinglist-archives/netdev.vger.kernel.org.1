Return-Path: <netdev+bounces-258371-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNY1A9H+jGn4wgAAu9opvQ
	(envelope-from <netdev+bounces-258371-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 23:12:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E49128081
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 23:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60D3030FED45
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 22:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F1E34AAE2;
	Wed, 11 Feb 2026 22:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AYQ1S+Jz"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013016.outbound.protection.outlook.com [40.93.196.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D206D34EF19;
	Wed, 11 Feb 2026 22:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770847920; cv=fail; b=t4xJHLoI/2M/IhGumxbjVo3nvUTUhtHtZeUdBm77zwlJ9hqP12POK8/TV19QSRvLa2JgsTYQCcIt9QzpQBAQhxa/P/j2/Lfl1RILvs3hYboAkDpQoc3KiDHYp9lZfIHADpThZLl93p4hN5QjM4ZPiKk7FMYSQEedz56F4sh4U7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770847920; c=relaxed/simple;
	bh=JJlb0cEKQfS8fv/EhVFIChhrCibfRv9Da62E6LudR+I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=JPkesxtjNjLNsen8/ZOR0i0H+thRHV4xb61Xye3UFFJpzZ8ZzHxK9So4dmMaviz9vCv5+4SMiZRJuI1RjBOmUE20ujYIu0QYSfxX0+F8AimRyhFatI55fo4DUfFJI7ij/RSYHk1qTYWxQp9xCYnvU8f/GpjAqobDjeJAtYInKJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AYQ1S+Jz; arc=fail smtp.client-ip=40.93.196.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCBiuKEVDNNev3JPU3p/2xrtxnZhI4B1Y3nHQMFJ9aH8gGh5sXm5qTpLW3Qj9dIG5PPkX/fFyI1y9/4RTxMkVKu2kH0HaBnQh0b3v+h8Y0Uk+5LpX2NG3cSnbIWAjSZFGMsKO7pvLWVMup7VcPqPkBu7x/0QlVkjYYkfcQGmSOGTwKmUXej3GDVlnd/6rd7rUE8lg0c8PAPfFl+ZRhAOus1lNsD6EDO2ilrvEboYRkozmYX0ZHpNJxjG0XGLAYPP2D+DVJ+kIhEHGXZAMLZp2OradHGNS6fyogEZ0IAP3qubGACCLDstRmBYzizl+9Iitteua1M21XT17Nh3AV23ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4TACfGLwJ8zXftan+wpqXfhVErOK+l7YNKK1dUQQ3w=;
 b=eOV6aG5WIdJb0roMJZILfCHkY6FGLun70Z6N8H2KAnXLxIWeaf7Ya11BR89TGGonOtWBGcCmZUoflyfv99tO9n5cpDuLm18tP+VNGMf2GVnYDbps6QEki4rz3lFyat0r5qm+f+R7Xg798RpPNetG83gbX6A+eZ2SJVh87NH59WjEhrrm87QkLnPNhA0I/AXb2burDcky1iZSUAzHyio+ddODuFwSsOMv0DcIbUiMhWBzIb/0JZZZnxSxHt2+lIwF8TYg1fvlP+3klhSmGkmOBefNsgxNW4TQ/tJWNvzhq904GdrmZPo0Yz2l6AEEXGBb8IqypR6dSt8P632o6v4oOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4TACfGLwJ8zXftan+wpqXfhVErOK+l7YNKK1dUQQ3w=;
 b=AYQ1S+JzhOv2SbxbeW5UDzuWVt4M9c8bKhSaku+iUcATR0n3YgSwrGdWqGc+WX14nttYgp0mnZvvS8Cxm73vNxONPjLJuTJLQ4WjBZywR4qX1zHVu88ncyEN0UcPSqv8L4juuX3f3AICyDDKkWoMUHaQ5v9MSho+7EtsFEK/dmU=
Received: from BY3PR05CA0048.namprd05.prod.outlook.com (2603:10b6:a03:39b::23)
 by SJ2PR12MB8884.namprd12.prod.outlook.com (2603:10b6:a03:547::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 22:11:51 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::f9) by BY3PR05CA0048.outlook.office365.com
 (2603:10b6:a03:39b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Wed,
 11 Feb 2026 22:11:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 22:11:51 +0000
Received: from [10.31.203.44] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Feb
 2026 16:11:50 -0600
Message-ID: <571b10d2-0b07-4121-8444-1f92a12c32a1@amd.com>
Date: Wed, 11 Feb 2026 16:11:50 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v23 01/22] cxl: Add type2 device basic support
To: <alejandro.lucero-palau@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-2-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20260201155438.2664640-2-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|SJ2PR12MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: 58f2044f-3b0d-4154-8ed4-08de69ba8f0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THl6M0c5NXhkQzhGdDVWQytuVmFsdElHWEJhakRzQUdMVVdXOExIWk5HSFZZ?=
 =?utf-8?B?RHA5TEdYTmxWL3BJcllJQkVJU0xwQ3BIdzZMREF4bWV2QVJwUFBERTJMMTJk?=
 =?utf-8?B?aUZERVdsSE9HQXJ5WnVlbFozRFRCOG42NDZwanExanlZM3dma0RlODVjU1ZP?=
 =?utf-8?B?U29rV2I4TksvbGxsM0pZT1ROSC9DbERIdDdELzlJVzFKNlZtNjZVcy9TTWFh?=
 =?utf-8?B?cmdXQ2JtSVRBZ3VRWW1Kd2xxaWJaOGluaEZ2S0tSd2tqeU4rR2FLa1pMZHZj?=
 =?utf-8?B?Rk1iNWtRbnRzd0FqRmtTaUdXaWxPOWZQdjNtM1RjZmZRdWt0TVZ4Vm1JQXBw?=
 =?utf-8?B?eE5Qei9Zd3A0L3drRUdFTWN4WVdic2FUUnFnQm5GZjMxOXFUSUFtVHZTSmVE?=
 =?utf-8?B?RXh6SG1aaFFtUTU0Um1PNFFsbEljKzFlaU50emR5RnhBblBmSDRKYVNXcjdp?=
 =?utf-8?B?Q29TNXA2NWdmaUJwRmVRUm9peVBjNEVGVGdyekZmQm5yUyt3N0krZmxCNlRW?=
 =?utf-8?B?ckJDajUyWGwwZ3dJa3A5aXkzeHY3bTRNbUFid0FIbEFoOXhXVGVKaGxSVEZz?=
 =?utf-8?B?eG9kb3F6RWNtb09JSzlmSngwT2VaOFJVVHdVd1ZRdG03N1RMUlFKcUR0cUFT?=
 =?utf-8?B?V2g0dmZDNDdieERWRHBQaVF3UXRVZ1ZxRVk4UnF0Vm0zOU9EUnhzWFpjc3lT?=
 =?utf-8?B?NDBFNmtDQVNkNy9FSlYveG5LclBNZlNvUFJ3ZjdCcFpZNXNaMmwwNzlDUGtw?=
 =?utf-8?B?WloxT0hRYkN6amJlVXJpK1pIOHE3QzVpSlpRN1VOdy9ua1Jza3JrZU5rcDFt?=
 =?utf-8?B?V0FpMnhjNVQ0N210N0tpYmt3Y2xaQ29XSmFMUjB2cURQa1BJazREZ0FkNDJU?=
 =?utf-8?B?bVhqMGswQ1pyYUthNm15aXE5R2U4OUo4OXZER2xkL3Z6RjNieFpMc0VaY3VF?=
 =?utf-8?B?RUI2QmU1VThIdUdtOVo2bytnSjBGYWU3Z0o2SEc1NU03dXVMV1NuRG03bkpS?=
 =?utf-8?B?S2dpRXQ0a3RWK3NnMU13OTF4Q0o5VTFvNTBFWDJRMUtiNGpWc0M4Ly9zWHNR?=
 =?utf-8?B?RXhlWUdLUGhBVjFlTG1xQjVadEpKcHgxZUtRYXYyTzdYRXFEejNmMzBtdmFv?=
 =?utf-8?B?Z2VOSGRTRkg1NHJJQnd0cXNzQ2lYaXdiT1E0RFFwMXR6Q1NwNjM5YjhDQ3Mz?=
 =?utf-8?B?SVpibStqTUwvQVNZdG5lSC9JcjJpZldCNjNYZmg2N3ZNeDFHWFhPd0NMU1pW?=
 =?utf-8?B?MTUzSm52THNSNFV0dWt0ZHVmSzdpWThDUThKOWhGMEZLUUpxNFBYT2ZoRWEz?=
 =?utf-8?B?bGVDWXRzandZa0tzV2wrUkdVdDJxY3ZUUFdWYThGeWFDMk9BNmRUdEdBSVl0?=
 =?utf-8?B?YzNSNUw2Uzd1R1crM2ZNQ0NmRHJFZzJhemJGU1JaN0luRy90Vk1rUGhKVTRY?=
 =?utf-8?B?ekxSazM1Z2JkaXZpNkRZQWUrVWtvSExDSENENk9ycE9RRUVNRkVIVG8rdkxz?=
 =?utf-8?B?L29rM0JQSkwvTllpYmtxeEowWlFXMkc1V0xzOXhpbHYydDQ3Z2swTEE5d1RN?=
 =?utf-8?B?RjRieEVnc29mRkwyeU1jTXMxcUtzS05CNGE4clBSbkJoU2ZSalVIbXdEUXpJ?=
 =?utf-8?B?Y2hyQzloUXV4VDFYL2Q0TkNweXphZmNTRC9rZ0xpc3dMd3Zrd2FSbTM2QXJX?=
 =?utf-8?B?T2dSczZTdlpLWEtsaDFSMm1meC85ZjNMbWt5THBYbmVqN3V5R1Y5WFNoWFQz?=
 =?utf-8?B?WHFEa3JNWkQxZHAwS3pFd2xqRGlrUzdZVUduVVpoSEdPVHh2NXphOCtxcmlR?=
 =?utf-8?B?Uk10Z2J5a3U5dHFaUnVmVStKWG5ZWUxCbmVjRGNlNjkrckVzSjFIYjhrV2Jh?=
 =?utf-8?B?Y0w3UHRqejFMTzRXb0pCb29JWWczMGxidGdhZ1k5N0NSaThhZUdpQTBncXIv?=
 =?utf-8?B?b0FWdk9vaDJCejI0SGprbFh0UHR2N3hLV2ZNOUFBbVpMRVZkcHliVXczdEl2?=
 =?utf-8?B?M3V0OXJ0bzZmMVNpZ0dRR2k0TkNiMUpvRDVlN2RwVlZNOFQySndtem4wTEZo?=
 =?utf-8?B?NFlrRmNSb01KMlVubU9lUXdTKzZOL2piZnNteDUxdnpkbkZOWk5jTjVNV2Yw?=
 =?utf-8?B?aTdCWFdaREVrZWJWL2lLZlorRlRMWmZvNEZ6cG5aZWxZejZLa3RGMU1raFhn?=
 =?utf-8?B?a1VNNWdJdUprZThFclVpK3BhUVl0ZGo0VmhzZHM4MHhXVmRaTEpuQ05UYUFv?=
 =?utf-8?B?NExNa0d3U3FSMHZzMWZCK1lrcVd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	P2WWcNoMMT98eiuNthS1l5vNXrdylReFUdGcP00jnEHqIkrBRIMhr3j+3NlHxJnWaVu7vmzL3FhDiMW+HGZr6d7LFnBM7AjGt+WgIa2Kj3Y0M6acxB/cLkpEC4e5aeCoxEzEtKtJy8uL9d81amXF635m8hsYM3IlgymOTdfK4DXGbjC88PqGCbNVLCsumerplfOdIalrDTl07cPFA2miOrvfdO3eSFQNvj2g9zBLW5uINQAylYZ8aC+VZl7FDfBlkwyJbRrmTxtuF3NBGICP1RkHL0/IeaHG4ozzoscbwFZiJTB/4j4WphIrPVZEbJNlIqISucbiQW2w3st7fR/1faW89SXBMfr9jsTABWRh4QOuJPWRuj+o8zPAcFoXxOXJsHmq5NklSBDNZ7ed3ApALAlTG8fjfL2zGs6sw4SrYOKZG371KIkTuTwVvvb8sskj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 22:11:51.7093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f2044f-3b0d-4154-8ed4-08de69ba8f0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8884
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin.cheatham@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,amd.com:mid,amd.com:dkim,amd.com:email];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258371-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+]
X-Rspamd-Queue-Id: 67E49128081
X-Rspamd-Action: no action

On 2/1/2026 9:54 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Differentiate CXL memory expanders (type 3) from CXL device accelerators
> (type 2) with a new function for initializing cxl_dev_state and a macro
> for helping accel drivers to embed cxl_dev_state inside a private
> struct.
> 
> Move structs to include/cxl as the size of the accel driver private
> struct embedding cxl_dev_state needs to know the size of this struct.
> 
> Use same new initialization with the type3 pci driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> ---
>  drivers/cxl/core/mbox.c      |  12 +-
>  drivers/cxl/core/memdev.c    |  32 +++++
>  drivers/cxl/cxl.h            |  97 +--------------
>  drivers/cxl/cxlmem.h         |  86 +------------
>  drivers/cxl/pci.c            |  14 +--
>  include/cxl/cxl.h            | 226 +++++++++++++++++++++++++++++++++++
>  tools/testing/cxl/test/mem.c |   3 +-
>  7 files changed, 274 insertions(+), 196 deletions(-)
>  create mode 100644 include/cxl/cxl.h
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index fa6dd0c94656..bee84d0101d1 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1514,23 +1514,21 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
>  
> -struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
> +						 u16 dvsec)
>  {
>  	struct cxl_memdev_state *mds;
>  	int rc;
>  
> -	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
> +	mds = devm_cxl_dev_state_create(dev, CXL_DEVTYPE_CLASSMEM, serial,
> +					dvsec, struct cxl_memdev_state, cxlds,
> +					true);
>  	if (!mds) {
>  		dev_err(dev, "No memory available\n");
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
>  	mutex_init(&mds->event.log_lock);
> -	mds->cxlds.dev = dev;
> -	mds->cxlds.reg_map.host = dev;
> -	mds->cxlds.cxl_mbox.host = dev;
> -	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
> -	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
>  
>  	rc = devm_cxl_register_mce_notifier(dev, &mds->mce_notifier);
>  	if (rc == -EOPNOTSUPP)
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index af3d0cc65138..22d156f25305 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -656,6 +656,38 @@ static void detach_memdev(struct work_struct *work)
>  
>  static struct lock_class_key cxl_memdev_key;
>  
> +static void cxl_dev_state_init(struct cxl_dev_state *cxlds, struct device *dev,
> +			       enum cxl_devtype type, u64 serial, u16 dvsec,
> +			       bool has_mbox)
> +{
> +	*cxlds = (struct cxl_dev_state) {
> +		.dev = dev,
> +		.type = type,
> +		.serial = serial,
> +		.cxl_dvsec = dvsec,
> +		.reg_map.host = dev,
> +		.reg_map.resource = CXL_RESOURCE_NONE,
> +	};
> +
> +	if (has_mbox)
> +		cxlds->cxl_mbox.host = dev;
> +}
> +
> +struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
> +						 enum cxl_devtype type,
> +						 u64 serial, u16 dvsec,
> +						 size_t size, bool has_mbox)
> +{
> +	struct cxl_dev_state *cxlds = devm_kzalloc(dev, size, GFP_KERNEL);
> +
> +	if (!cxlds)
> +		return NULL;
> +
> +	cxl_dev_state_init(cxlds, dev, type, serial, dvsec, has_mbox);

Nit: Having a second function to do the init seems overkill here, especially since cxl_dev_state_init() isn't called outside this
function. I'd fold it into this function instead, but I'm fine with it either way (especially if you were told otherwise before).

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> +	return cxlds;
> +}
> +EXPORT_SYMBOL_NS_GPL(_devm_cxl_dev_state_create, "CXL");
> +
>  static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  					   const struct file_operations *fops,
>  					   const struct cxl_memdev_attach *attach)
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index e1d47062e1d3..3eaa353e430b 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -12,6 +12,7 @@
>  #include <linux/node.h>
>  #include <linux/io.h>
>  #include <linux/range.h>
> +#include <cxl/cxl.h>
>  
>  extern const struct nvdimm_security_ops *cxl_security_ops;
>  
> @@ -201,97 +202,6 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define   CXLDEV_MBOX_BG_CMD_COMMAND_VENDOR_MASK GENMASK_ULL(63, 48)
>  #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
>  
> -/*
> - * Using struct_group() allows for per register-block-type helper routines,
> - * without requiring block-type agnostic code to include the prefix.
> - */
> -struct cxl_regs {
> -	/*
> -	 * Common set of CXL Component register block base pointers
> -	 * @hdm_decoder: CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure
> -	 * @ras: CXL 2.0 8.2.5.9 CXL RAS Capability Structure
> -	 */
> -	struct_group_tagged(cxl_component_regs, component,
> -		void __iomem *hdm_decoder;
> -		void __iomem *ras;
> -	);
> -	/*
> -	 * Common set of CXL Device register block base pointers
> -	 * @status: CXL 2.0 8.2.8.3 Device Status Registers
> -	 * @mbox: CXL 2.0 8.2.8.4 Mailbox Registers
> -	 * @memdev: CXL 2.0 8.2.8.5 Memory Device Registers
> -	 */
> -	struct_group_tagged(cxl_device_regs, device_regs,
> -		void __iomem *status, *mbox, *memdev;
> -	);
> -
> -	struct_group_tagged(cxl_pmu_regs, pmu_regs,
> -		void __iomem *pmu;
> -	);
> -
> -	/*
> -	 * RCH downstream port specific RAS register
> -	 * @aer: CXL 3.0 8.2.1.1 RCH Downstream Port RCRB
> -	 */
> -	struct_group_tagged(cxl_rch_regs, rch_regs,
> -		void __iomem *dport_aer;
> -	);
> -
> -	/*
> -	 * RCD upstream port specific PCIe cap register
> -	 * @pcie_cap: CXL 3.0 8.2.1.2 RCD Upstream Port RCRB
> -	 */
> -	struct_group_tagged(cxl_rcd_regs, rcd_regs,
> -		void __iomem *rcd_pcie_cap;
> -	);
> -};
> -
> -struct cxl_reg_map {
> -	bool valid;
> -	int id;
> -	unsigned long offset;
> -	unsigned long size;
> -};
> -
> -struct cxl_component_reg_map {
> -	struct cxl_reg_map hdm_decoder;
> -	struct cxl_reg_map ras;
> -};
> -
> -struct cxl_device_reg_map {
> -	struct cxl_reg_map status;
> -	struct cxl_reg_map mbox;
> -	struct cxl_reg_map memdev;
> -};
> -
> -struct cxl_pmu_reg_map {
> -	struct cxl_reg_map pmu;
> -};
> -
> -/**
> - * struct cxl_register_map - DVSEC harvested register block mapping parameters
> - * @host: device for devm operations and logging
> - * @base: virtual base of the register-block-BAR + @block_offset
> - * @resource: physical resource base of the register block
> - * @max_size: maximum mapping size to perform register search
> - * @reg_type: see enum cxl_regloc_type
> - * @component_map: cxl_reg_map for component registers
> - * @device_map: cxl_reg_maps for device registers
> - * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
> - */
> -struct cxl_register_map {
> -	struct device *host;
> -	void __iomem *base;
> -	resource_size_t resource;
> -	resource_size_t max_size;
> -	u8 reg_type;
> -	union {
> -		struct cxl_component_reg_map component_map;
> -		struct cxl_device_reg_map device_map;
> -		struct cxl_pmu_reg_map pmu_map;
> -	};
> -};
> -
>  void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  			      struct cxl_component_reg_map *map);
>  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
> @@ -497,11 +407,6 @@ struct cxl_region_params {
>  	resource_size_t cache_size;
>  };
>  
> -enum cxl_partition_mode {
> -	CXL_PARTMODE_RAM,
> -	CXL_PARTMODE_PMEM,
> -};
> -
>  /*
>   * Indicate whether this region has been assembled by autodetection or
>   * userspace assembly. Prevent endpoint decoders outside of automatic
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ef202b34e5ea..281546de426e 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -113,8 +113,6 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  			 resource_size_t base, resource_size_t len,
>  			 resource_size_t skipped);
>  
> -#define CXL_NR_PARTITIONS_MAX 2
> -
>  struct cxl_dpa_info {
>  	u64 size;
>  	struct cxl_dpa_part_info {
> @@ -373,87 +371,6 @@ struct cxl_security_state {
>  	struct kernfs_node *sanitize_node;
>  };
>  
> -/*
> - * enum cxl_devtype - delineate type-2 from a generic type-3 device
> - * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device implementing HDM-D or
> - *			 HDM-DB, no requirement that this device implements a
> - *			 mailbox, or other memory-device-standard manageability
> - *			 flows.
> - * @CXL_DEVTYPE_CLASSMEM - Common class definition of a CXL Type-3 device with
> - *			   HDM-H and class-mandatory memory device registers
> - */
> -enum cxl_devtype {
> -	CXL_DEVTYPE_DEVMEM,
> -	CXL_DEVTYPE_CLASSMEM,
> -};
> -
> -/**
> - * struct cxl_dpa_perf - DPA performance property entry
> - * @dpa_range: range for DPA address
> - * @coord: QoS performance data (i.e. latency, bandwidth)
> - * @cdat_coord: raw QoS performance data from CDAT
> - * @qos_class: QoS Class cookies
> - */
> -struct cxl_dpa_perf {
> -	struct range dpa_range;
> -	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
> -	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
> -	int qos_class;
> -};
> -
> -/**
> - * struct cxl_dpa_partition - DPA partition descriptor
> - * @res: shortcut to the partition in the DPA resource tree (cxlds->dpa_res)
> - * @perf: performance attributes of the partition from CDAT
> - * @mode: operation mode for the DPA capacity, e.g. ram, pmem, dynamic...
> - */
> -struct cxl_dpa_partition {
> -	struct resource res;
> -	struct cxl_dpa_perf perf;
> -	enum cxl_partition_mode mode;
> -};
> -
> -/**
> - * struct cxl_dev_state - The driver device state
> - *
> - * cxl_dev_state represents the CXL driver/device state.  It provides an
> - * interface to mailbox commands as well as some cached data about the device.
> - * Currently only memory devices are represented.
> - *
> - * @dev: The device associated with this CXL state
> - * @cxlmd: The device representing the CXL.mem capabilities of @dev
> - * @reg_map: component and ras register mapping parameters
> - * @regs: Parsed register blocks
> - * @cxl_dvsec: Offset to the PCIe device DVSEC
> - * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
> - * @media_ready: Indicate whether the device media is usable
> - * @dpa_res: Overall DPA resource tree for the device
> - * @part: DPA partition array
> - * @nr_partitions: Number of DPA partitions
> - * @serial: PCIe Device Serial Number
> - * @type: Generic Memory Class device or Vendor Specific Memory device
> - * @cxl_mbox: CXL mailbox context
> - * @cxlfs: CXL features context
> - */
> -struct cxl_dev_state {
> -	struct device *dev;
> -	struct cxl_memdev *cxlmd;
> -	struct cxl_register_map reg_map;
> -	struct cxl_regs regs;
> -	int cxl_dvsec;
> -	bool rcd;
> -	bool media_ready;
> -	struct resource dpa_res;
> -	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
> -	unsigned int nr_partitions;
> -	u64 serial;
> -	enum cxl_devtype type;
> -	struct cxl_mailbox cxl_mbox;
> -#ifdef CONFIG_CXL_FEATURES
> -	struct cxl_features_state *cxlfs;
> -#endif
> -};
> -
>  static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
>  {
>  	/*
> @@ -858,7 +775,8 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds);
>  int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>  int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
>  int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
> -struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev);
> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
> +						 u16 dvsec);
>  void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  				unsigned long *cmds);
>  void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 1cf232220873..24179cc702bf 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -911,25 +911,25 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	int rc, pmu_count;
>  	unsigned int i;
>  	bool irq_avail;
> +	u16 dvsec;
>  
>  	rc = pcim_enable_device(pdev);
>  	if (rc)
>  		return rc;
>  	pci_set_master(pdev);
>  
> -	mds = cxl_memdev_state_create(&pdev->dev);
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		pci_warn(pdev, "Device DVSEC not present, skip CXL.mem init\n");
> +
> +	mds = cxl_memdev_state_create(&pdev->dev, pci_get_dsn(pdev), dvsec);
>  	if (IS_ERR(mds))
>  		return PTR_ERR(mds);
>  	cxlds = &mds->cxlds;
>  	pci_set_drvdata(pdev, cxlds);
>  
>  	cxlds->rcd = is_cxl_restricted(pdev);
> -	cxlds->serial = pci_get_dsn(pdev);
> -	cxlds->cxl_dvsec = pci_find_dvsec_capability(
> -		pdev, PCI_VENDOR_ID_CXL, PCI_DVSEC_CXL_DEVICE);
> -	if (!cxlds->cxl_dvsec)
> -		dev_warn(&pdev->dev,
> -			 "Device DVSEC not present, skip CXL.mem init\n");
>  
>  	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>  	if (rc)
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> new file mode 100644
> index 000000000000..13d448686189
> --- /dev/null
> +++ b/include/cxl/cxl.h
> @@ -0,0 +1,226 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2020 Intel Corporation. */
> +/* Copyright(c) 2025 Advanced Micro Devices, Inc. */
> +
> +#ifndef __CXL_CXL_H__
> +#define __CXL_CXL_H__
> +
> +#include <linux/node.h>
> +#include <linux/ioport.h>
> +#include <cxl/mailbox.h>
> +
> +/**
> + * enum cxl_devtype - delineate type-2 from a generic type-3 device
> + * @CXL_DEVTYPE_DEVMEM: Vendor specific CXL Type-2 device implementing HDM-D or
> + *			 HDM-DB, no requirement that this device implements a
> + *			 mailbox, or other memory-device-standard manageability
> + *			 flows.
> + * @CXL_DEVTYPE_CLASSMEM: Common class definition of a CXL Type-3 device with
> + *			   HDM-H and class-mandatory memory device registers
> + */
> +enum cxl_devtype {
> +	CXL_DEVTYPE_DEVMEM,
> +	CXL_DEVTYPE_CLASSMEM,
> +};
> +
> +struct device;
> +
> +/*
> + * Using struct_group() allows for per register-block-type helper routines,
> + * without requiring block-type agnostic code to include the prefix.
> + */
> +struct cxl_regs {
> +	/*
> +	 * Common set of CXL Component register block base pointers
> +	 * @hdm_decoder: CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure
> +	 * @ras: CXL 2.0 8.2.5.9 CXL RAS Capability Structure
> +	 */
> +	struct_group_tagged(cxl_component_regs, component,
> +		void __iomem *hdm_decoder;
> +		void __iomem *ras;
> +	);
> +	/*
> +	 * Common set of CXL Device register block base pointers
> +	 * @status: CXL 2.0 8.2.8.3 Device Status Registers
> +	 * @mbox: CXL 2.0 8.2.8.4 Mailbox Registers
> +	 * @memdev: CXL 2.0 8.2.8.5 Memory Device Registers
> +	 */
> +	struct_group_tagged(cxl_device_regs, device_regs,
> +		void __iomem *status, *mbox, *memdev;
> +	);
> +
> +	struct_group_tagged(cxl_pmu_regs, pmu_regs,
> +		void __iomem *pmu;
> +	);
> +
> +	/*
> +	 * RCH downstream port specific RAS register
> +	 * @aer: CXL 3.0 8.2.1.1 RCH Downstream Port RCRB
> +	 */
> +	struct_group_tagged(cxl_rch_regs, rch_regs,
> +		void __iomem *dport_aer;
> +	);
> +
> +	/*
> +	 * RCD upstream port specific PCIe cap register
> +	 * @pcie_cap: CXL 3.0 8.2.1.2 RCD Upstream Port RCRB
> +	 */
> +	struct_group_tagged(cxl_rcd_regs, rcd_regs,
> +		void __iomem *rcd_pcie_cap;
> +	);
> +};
> +
> +struct cxl_reg_map {
> +	bool valid;
> +	int id;
> +	unsigned long offset;
> +	unsigned long size;
> +};
> +
> +struct cxl_component_reg_map {
> +	struct cxl_reg_map hdm_decoder;
> +	struct cxl_reg_map ras;
> +};
> +
> +struct cxl_device_reg_map {
> +	struct cxl_reg_map status;
> +	struct cxl_reg_map mbox;
> +	struct cxl_reg_map memdev;
> +};
> +
> +struct cxl_pmu_reg_map {
> +	struct cxl_reg_map pmu;
> +};
> +
> +/**
> + * struct cxl_register_map - DVSEC harvested register block mapping parameters
> + * @host: device for devm operations and logging
> + * @base: virtual base of the register-block-BAR + @block_offset
> + * @resource: physical resource base of the register block
> + * @max_size: maximum mapping size to perform register search
> + * @reg_type: see enum cxl_regloc_type
> + * @component_map: cxl_reg_map for component registers
> + * @device_map: cxl_reg_maps for device registers
> + * @pmu_map: cxl_reg_maps for CXL Performance Monitoring Units
> + */
> +struct cxl_register_map {
> +	struct device *host;
> +	void __iomem *base;
> +	resource_size_t resource;
> +	resource_size_t max_size;
> +	u8 reg_type;
> +	union {
> +		struct cxl_component_reg_map component_map;
> +		struct cxl_device_reg_map device_map;
> +		struct cxl_pmu_reg_map pmu_map;
> +	};
> +};
> +
> +/**
> + * struct cxl_dpa_perf - DPA performance property entry
> + * @dpa_range: range for DPA address
> + * @coord: QoS performance data (i.e. latency, bandwidth)
> + * @cdat_coord: raw QoS performance data from CDAT
> + * @qos_class: QoS Class cookies
> + */
> +struct cxl_dpa_perf {
> +	struct range dpa_range;
> +	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
> +	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
> +	int qos_class;
> +};
> +
> +enum cxl_partition_mode {
> +	CXL_PARTMODE_RAM,
> +	CXL_PARTMODE_PMEM,
> +};
> +
> +/**
> + * struct cxl_dpa_partition - DPA partition descriptor
> + * @res: shortcut to the partition in the DPA resource tree (cxlds->dpa_res)
> + * @perf: performance attributes of the partition from CDAT
> + * @mode: operation mode for the DPA capacity, e.g. ram, pmem, dynamic...
> + */
> +struct cxl_dpa_partition {
> +	struct resource res;
> +	struct cxl_dpa_perf perf;
> +	enum cxl_partition_mode mode;
> +};
> +
> +#define CXL_NR_PARTITIONS_MAX 2
> +
> +/**
> + * struct cxl_dev_state - The driver device state
> + *
> + * cxl_dev_state represents the CXL driver/device state.  It provides an
> + * interface to mailbox commands as well as some cached data about the device.
> + * Currently only memory devices are represented.
> + *
> + * @dev: The device associated with this CXL state
> + * @cxlmd: The device representing the CXL.mem capabilities of @dev
> + * @reg_map: component and ras register mapping parameters
> + * @regs: Parsed register blocks
> + * @cxl_dvsec: Offset to the PCIe device DVSEC
> + * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
> + * @media_ready: Indicate whether the device media is usable
> + * @dpa_res: Overall DPA resource tree for the device
> + * @part: DPA partition array
> + * @nr_partitions: Number of DPA partitions
> + * @serial: PCIe Device Serial Number
> + * @type: Generic Memory Class device or Vendor Specific Memory device
> + * @cxl_mbox: CXL mailbox context
> + * @cxlfs: CXL features context
> + */
> +struct cxl_dev_state {
> +	/* public for Type2 drivers */
> +	struct device *dev;
> +	struct cxl_memdev *cxlmd;
> +
> +	/* private for Type2 drivers */
> +	struct cxl_register_map reg_map;
> +	struct cxl_regs regs;
> +	int cxl_dvsec;
> +	bool rcd;
> +	bool media_ready;
> +	struct resource dpa_res;
> +	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
> +	unsigned int nr_partitions;
> +	u64 serial;
> +	enum cxl_devtype type;
> +	struct cxl_mailbox cxl_mbox;
> +#ifdef CONFIG_CXL_FEATURES
> +	struct cxl_features_state *cxlfs;
> +#endif
> +};
> +
> +struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
> +						 enum cxl_devtype type,
> +						 u64 serial, u16 dvsec,
> +						 size_t size, bool has_mbox);
> +
> +/**
> + * cxl_dev_state_create - safely create and cast a cxl dev state embedded in a
> + * driver specific struct.
> + *
> + * @parent: device behind the request
> + * @type: CXL device type
> + * @serial: device identification
> + * @dvsec: dvsec capability offset
> + * @drv_struct: driver struct embedding a cxl_dev_state struct
> + * @member: drv_struct member as cxl_dev_state
> + * @mbox: true if mailbox supported
> + *
> + * Returns a pointer to the drv_struct allocated and embedding a cxl_dev_state
> + * struct initialized.
> + *
> + * Introduced for Type2 driver support.
> + */
> +#define devm_cxl_dev_state_create(parent, type, serial, dvsec, drv_struct, member, mbox)	\
> +	({										\
> +		static_assert(__same_type(struct cxl_dev_state,				\
> +			      ((drv_struct *)NULL)->member));				\
> +		static_assert(offsetof(drv_struct, member) == 0);			\
> +		(drv_struct *)_devm_cxl_dev_state_create(parent, type, serial, dvsec,	\
> +						      sizeof(drv_struct), mbox);	\
> +	})
> +#endif /* __CXL_CXL_H__ */
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index cb87e8c0e63c..79f42f4474d4 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -1716,7 +1716,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	if (rc)
>  		return rc;
>  
> -	mds = cxl_memdev_state_create(dev);
> +	mds = cxl_memdev_state_create(dev, pdev->id + 1, 0);
>  	if (IS_ERR(mds))
>  		return PTR_ERR(mds);
>  
> @@ -1732,7 +1732,6 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	mds->event.buf = (struct cxl_get_event_payload *) mdata->event_buf;
>  	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mockmem_sanitize_work);
>  
> -	cxlds->serial = pdev->id + 1;
>  	if (is_rcd(pdev))
>  		cxlds->rcd = true;
>  


