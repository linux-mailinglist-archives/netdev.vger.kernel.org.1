Return-Path: <netdev+bounces-259528-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCmBAXhIl2m2wQIAu9opvQ
	(envelope-from <netdev+bounces-259528-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:29:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13824161332
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 062B8300BC64
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 17:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC5334DB74;
	Thu, 19 Feb 2026 17:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w6DGI+CQ"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013040.outbound.protection.outlook.com [40.93.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9A2284898;
	Thu, 19 Feb 2026 17:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771522162; cv=fail; b=uz7CPVX2vjLKavrX1MYctGLq9x0D+QCNCGfxgubJnbwVtBEeuunrwqHRKqihk6ZdDC93ZMW4XYuY3LN/n+e3tbDdkbRPI6fdtEGANGcd7AKR/cL2GDCV7N0NfJWLPuWF1Jo9Insp4YEK4/AbaXmL+Lcf3c7Cc/B8yoUu+hIXEF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771522162; c=relaxed/simple;
	bh=0FlRSijC8JxuYh9jr1B93S1K62g/L4BuEhVu7NS7dlM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=M/etNCemnk1bu8Oew2ewLeV1zQFOb5fQ2t7pLZGa1VjvEVxhEEGXLhbcKREozDx+YXp1TtdGfmGuYjFwEUEzFX3VBfMo73Hg6xQ/W3WHXZlzhW3A9RSHBTzE+1034m9fNNcpJolymMnHNmkcLzQMs9lR2A7jUjF3tlDXNfNEMAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w6DGI+CQ; arc=fail smtp.client-ip=40.93.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbYREFDnkVPRQHwlQqEB8lKddCjsY069Tafg3x8sISw+0R0EwmhbLGI3kqSoF59fS6PiVZpDgvyH+K5v51zbZuWiJYKzrGYbIYwRAjKmzN8HH6Io8uWqmuWz058pA3xuoslpSPzKMMZ2sXiNif+muWe1Q6FrlfFllXy0OPC6Z1cuX6ZlT3UgniWobdBP6rAzahAX+XtxJf0aMRGxB3ethRmLUKIi6qeOlY2OWuuxJpgmVbA3bsc3LVhqFtMS8hiGYXeib9SmwRT/vCdY8nEZMGReGIax2EO8AZh82HH8T2ESGKMv4q3Kv3ObSpP85o5stbwmKJJfSaxwLuGwcCQyQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kawfu07bsqI97EPtrHBZenCTlkwVI+pUOxbytA/uTnY=;
 b=OtiQH5TMufbquVaV853+Br5VXb3IL8FdUzo8+PaIu+x0Ou51gQalNRdL4Fg8VCUOW38hG3S5XU7iRblVz8CExgxXHlVga2FsuF5c9yWwrSuBRdqZq9M3r7l2R/ZrwnZfJiO3TCspdazr6MRCdh95spuPFTAbrL/izWqCeMxYA2D7Gq+F3Wd/nTFJ7h5qGoFYojQrhDBNI7AfUaznGRyyPvfd03vKGzCr+cCUwcBf66LDEtg5ANA/vhcqXPsTCAENAq3tt3JbG9uYZpPRIT0r9ab6j+E7VdNQIKckKdCKCvsPO8fKZmOyGqFKzN9sjW1wSIKSLWXbyi40p4J4fxrE2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kawfu07bsqI97EPtrHBZenCTlkwVI+pUOxbytA/uTnY=;
 b=w6DGI+CQRIN9cZWJOx3IkEzFStR8d4+spMZMnGQckn+/efsTSp72xtTnYx5UDurjbUHfP+ZAVFnduh4oHeSxUdTQDUilFrH/OSjPbAgkrHGv3KoLy+p4Lo3HVdmWkyraG1Wk/Y441SUAU6dLQkuDsc3/6zhtusoXDlkSkCGa0zc=
Received: from SJ0PR13CA0189.namprd13.prod.outlook.com (2603:10b6:a03:2c3::14)
 by PH7PR12MB7116.namprd12.prod.outlook.com (2603:10b6:510:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Thu, 19 Feb
 2026 17:29:13 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::8e) by SJ0PR13CA0189.outlook.office365.com
 (2603:10b6:a03:2c3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 17:29:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 17:29:13 +0000
Received: from [10.31.194.67] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Feb
 2026 11:29:05 -0600
Message-ID: <80cbdf15-24d2-4b37-aafb-b26c22feb53a@amd.com>
Date: Thu, 19 Feb 2026 11:29:04 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v23 17/22] cxl/region: Factor out interleave ways setup
To: Alejandro Lucero Palau <alucerop@amd.com>,
	<alejandro.lucero-palau@amd.com>
CC: Zhi Wang <zhiw@nvidia.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-18-alejandro.lucero-palau@amd.com>
 <383d7089-d7ca-43ab-8284-694e60729770@amd.com>
 <62be78b6-1d5d-4b5f-aaf7-62996536c97d@amd.com>
Content-Language: en-US
In-Reply-To: <62be78b6-1d5d-4b5f-aaf7-62996536c97d@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|PH7PR12MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eb2c3aa-7ca8-4285-2780-08de6fdc6659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RytiK0JmUVBBQURhUktmWGlVZFQyTGI3TWdMUEZLSU5NRXZLNzB2bUdqdlhN?=
 =?utf-8?B?c1hyaHpKM3NyVThZWlNFeGtodUw2M0FCbzdOb1lpMkdRZkY0RUFpa1hPSUd1?=
 =?utf-8?B?OTdGZ29DZzVFYkJacldxdVBYRTV2Y1NGNytuZmFGSUVhSXpWcWNJUjZ6Wllu?=
 =?utf-8?B?NUN1ZVp6NEV0Si9Wd242M1l4TzJHWmVvc3BVYjNzK09nN0VDWEgrMEw4ZElB?=
 =?utf-8?B?TDl2U3JXNzQ5Nm1YdGd5amM1YlZYeEZPaWJSMWI4MitVS2NOY2laMjF1eHlr?=
 =?utf-8?B?N0NtRmlDRElqU2x3eWZmaFdkUzQ0NCsxNjNubzRuWDducXQyb1dUKzdDYys2?=
 =?utf-8?B?T1hoQ21qR1NOOEI1S01GSDltT3lSUW5IbzNVWk9VZkVvMWMrRmd2MUV0NE5J?=
 =?utf-8?B?VlQrODdFQk5vM0V0YU9jdmkxazRmNEYwNUxiRFRUVk1TM3NMcXhWTndWK2xa?=
 =?utf-8?B?Sm12NjA3N2hMTldYZ21sYUVhQzUrcHNjeG10S3llZWtiTkkxVFZZVytMVVc1?=
 =?utf-8?B?aDVHRXBHenR3WnA0aEt3WHU1SlZXR1V3NnRZS2M1KzA0dEhZbE1yeGl3SFhT?=
 =?utf-8?B?ZHBSbis2T3cvUjdvcS90ZXNYczh1YkJBZUI1OS9vRzBIWjNJdjJpakY3c3hx?=
 =?utf-8?B?OFZXS3ZxSFljdndya3lHMW5WdDl1NWM4WDdFVDNyQ2xrK3NWRUlJd3RaemNj?=
 =?utf-8?B?M3g3RTQ4WU1tNG0wTXlkRkdyZnFMNFREZWRhc0tOMVl1VENDRENVZlhHVnpC?=
 =?utf-8?B?ZlpGSDJmOHhJVG54MFhjc3RDNENJNlNtM2RwWkdZM2JnVDZLNnV4R213YWdU?=
 =?utf-8?B?ZVFiK3JaOWNsMVhhbkkxMUxQcG9GeC9FeE5Wai9UL04wdmxheUV0b0owSnU0?=
 =?utf-8?B?M3VZYk1kb1JYWUc2SkVNQWdkcTVhUXZnRFJsWGRvMkR3ZUlRVEtlMTNNVFJj?=
 =?utf-8?B?Q0ljUC9YWnZDdnBjWXkzbThXbWh3MUNGODNkd09YZkJxTzZuQnhDOWRDb0xh?=
 =?utf-8?B?SmNlWUlwVFBWRGhWY2tVZHBib2NUWmljdnFQbXBUK3ZvcmZFMFQ4aDhrVUtn?=
 =?utf-8?B?cWc5UFU3TFRGYlhsdm5aNVBybzZFdkdmV2dLWTl5WTlZazdsdEptM1BrbklW?=
 =?utf-8?B?Q0RudW9HK0VkblQ1WjdCZlU5MXlPd3cwK2pCZTNOeTJlRUp6WnBjckhXbkJl?=
 =?utf-8?B?S0FMTkdzL0F3VE5obVRtZzBFMVcrN0VTd29iOVdhZnZYK3hWTFhDOVdWdURG?=
 =?utf-8?B?cVA1c2NvWEFzY0hMYXl3c0ZLS1VCWCtPS0E1NnhRT1NqdWVyd041YXUvTTlw?=
 =?utf-8?B?UENIY0RwOUxhWHdobTByUXhOOUpoTU8vM2ZWbmNsZjk3cExPY284N1FBN0hv?=
 =?utf-8?B?cHNkUXkzKzRCc1MwU0NHbW51ejZJSmVrbnBKeG0zcUJJTUVmSWlYb2NVNzhO?=
 =?utf-8?B?dFNIVjN3RWExU0lGQVBrYTVyaWdEZ3IxQ1JpTmFkL0l4RHh2T0hPR2M5Q0ZC?=
 =?utf-8?B?OVczb1podzVCUHhVeDR3MzR2eEZmdS9tMkpIdTY0VUVEV3pDbVRCcVczOGZq?=
 =?utf-8?B?K0Y0RlRETlMydDJ3c2MrMXo0TW1tS1d0RXNxV3B2Z0l0VS9tdFp3K1Jnb013?=
 =?utf-8?B?NnlZbkVLWEpmYVd0OXRUZlJ4N1hZeGJNRXBDZVhWbCtTR2NxVkFqY1lkV0hX?=
 =?utf-8?B?bUp1eFBXdHJTWkxoaUZSKzgwRjhFcHc2cStYK0JzdnRYS0NhMXo0RklqVERU?=
 =?utf-8?B?SHJ6cnpWUUpyMUJSdkZ0TjNOY1BKdDlkbU52bWdiNUdPOXQ5enlCTU1WSG1D?=
 =?utf-8?B?bFhCRmtBalEvNjBKK0xyRlFzZHVuRmlVUysxUmFhTndZTnJ0T3lZdmRhVjhJ?=
 =?utf-8?B?V2J1NnY2Q1p5c3ZQb0pueUdBak1RWUM0RWJrcmVreC94TkdZYWx6VDFDaGQx?=
 =?utf-8?B?Z2p0SHpDT2xCSDFjMDU0SHJLVzJXdkZKcllvczBjNDNOcTArNU5UdU9qVlFl?=
 =?utf-8?B?VGlBaGkrVUFxdnZKYk4vb0xzTVVLaWVhZ3BZMlRvTm13R1dkMVFDbUd4c1pu?=
 =?utf-8?B?djl5enEyQlJmU3o4VXlZOFJsWndNTWRNTUxITmtWWEVkQUNTU09vQnd6YlJN?=
 =?utf-8?B?WUkvY2gxSmhCTE5YejNVZzBCc205Q0ZMUFB3T1dQZU5rUFJRQ0IzSE1HSUs4?=
 =?utf-8?B?Q0xPU2o5R1owOE1vb1RXUGJla1E3aFdOdktnMVl6ZlRjL09SOXJsSHF3Tmow?=
 =?utf-8?B?V2NOZDhHTGJ0QTM0d3ZkaSt5SDJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	unRKRlZU0qVkm4b/zqJH9gPnJgSOX/tX0xya2dr7cD114fmydrtg5OkYc5+qHjVbtRIjWF/h6Z19BKZdpw8350Toq9sdDbKeY9n3YeHTfPO/XlYtN9LG38TZgyNRsiChaHNKleavI81PvSW/XYDcxDgviLH4Dfywyhvgq1ulTMsjKrzdnk4HGYpGtr2FJB4zxPjWqQoDznXFWznJnAlYF7gqXXZvGdqFSg6+/eZQRWs3gvNgqdxhYZ/7qBzT7SfdsmZMPbJ7KUYMSPgBwXjVzqiRCvP6oAz5dfGuRHdZoYRFXQIp6nqXH5Q1+1eHHlGH2a+oSNkj1shHDkHQApL2KAI/m6/irrGfeYSMeWUqKUq9ngpbNON4sPTbYZz5coXZiA6DDdZocvRwgnNeXX8V0wjNh7F6lPjKuvqXP1JgyLCsE08pqYLlNkfIXY10pWnK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 17:29:13.2649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb2c3aa-7ca8-4285-2780-08de6fdc6659
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7116
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259528-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim,amd.com:email,nvidia.com:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin.cheatham@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 13824161332
X-Rspamd-Action: no action



On 2/19/2026 4:40 AM, Alejandro Lucero Palau wrote:
> 
> On 2/11/26 22:11, Cheatham, Benjamin wrote:
>> On 2/1/2026 9:54 AM, alejandro.lucero-palau@amd.com wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Region creation based on Type3 devices is triggered from user space
>>> allowing memory combination through interleaving.
>>>
>>> In preparation for kernel driven region creation, that is Type2 drivers
>>> triggering region creation backed with its advertised CXL memory, factor
>>> out a common helper from the user-sysfs region setup for interleave ways.
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>>> ---
>>>   drivers/cxl/core/region.c | 43 ++++++++++++++++++++++++---------------
>>>   1 file changed, 27 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>> index f53b2e9fd9e6..ece1d3df7cf1 100644
>>> --- a/drivers/cxl/core/region.c
>>> +++ b/drivers/cxl/core/region.c
>>> @@ -485,22 +485,14 @@ static ssize_t interleave_ways_show(struct device *dev,
>>>     static const struct attribute_group *get_cxl_region_target_group(void);
>>>   -static ssize_t interleave_ways_store(struct device *dev,
>>> -                     struct device_attribute *attr,
>>> -                     const char *buf, size_t len)
>>> +static int set_interleave_ways(struct cxl_region *cxlr, int val)
>> @val should probably stay an unsigned int. You pass an unsigned int in the sysfs function, and the
>> function was originally coded with that in mind (same with @save below).
> 
> Good catch. I wonder if I should just change the way the value is obtained, using kstrtoint instead  of kstrtouint, as those values are used for cxl_region_params fields defined as int. In other words, it seems doing that simpler than changing all the other places you mention and the structs involved. I can not see a reason for using unsigned int so I think I will follow that approach. Tell me if you think otherwise.
> 

If I had to guess unsigned int was used because a negative interleave granularity/ways makes no sense. I think your suggestion is fine though since no one
in their right mind would give anything but a (relatively) small and positive value for these.

Thanks,
Ben

> 
> Thank you
> 
> 
>> With that cleaned up:
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>>
>>>   {
>>> -    struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
>>> +    struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>>>       struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>>> -    struct cxl_region *cxlr = to_cxl_region(dev);
>>>       struct cxl_region_params *p = &cxlr->params;
>>> -    unsigned int val, save;
>>> -    int rc;
>>> +    int save, rc;
>>>       u8 iw;
>>>   -    rc = kstrtouint(buf, 0, &val);
>>> -    if (rc)
>>> -        return rc;
>>> -
>>>       rc = ways_to_eiw(val, &iw);
>>>       if (rc)
>>>           return rc;
>>> @@ -515,9 +507,7 @@ static ssize_t interleave_ways_store(struct device *dev,
>>>           return -EINVAL;
>>>       }
>>>   -    ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
>>> -    if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
>>> -        return rc;
>>> +    lockdep_assert_held_write(&cxl_rwsem.region);
>>>         if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
>>>           return -EBUSY;
>>> @@ -525,10 +515,31 @@ static ssize_t interleave_ways_store(struct device *dev,
>>>       save = p->interleave_ways;
>>>       p->interleave_ways = val;
>>>       rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
>>> -    if (rc) {
>>> +    if (rc)
>>>           p->interleave_ways = save;
>>> +
>>> +    return rc;
>>> +}
>>> +
>>> +static ssize_t interleave_ways_store(struct device *dev,
>>> +                     struct device_attribute *attr,
>>> +                     const char *buf, size_t len)
>>> +{
>>> +    struct cxl_region *cxlr = to_cxl_region(dev);
>>> +    unsigned int val;
>>> +    int rc;
>>> +
>>> +    rc = kstrtouint(buf, 0, &val);
>>> +    if (rc)
>>> +        return rc;
>>> +
>>> +    ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
>>> +    if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
>>> +        return rc;
>>> +
>>> +    rc = set_interleave_ways(cxlr, val);
>>> +    if (rc)
>>>           return rc;
>>> -    }
>>>         return len;
>>>   }


