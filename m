Return-Path: <netdev+bounces-258364-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLVFOqj+jGn4wgAAu9opvQ
	(envelope-from <netdev+bounces-258364-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 23:11:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5173512804F
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 23:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E508B303102E
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 22:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C999A33032B;
	Wed, 11 Feb 2026 22:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UAz3CD0J"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012030.outbound.protection.outlook.com [52.101.48.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EE33043A2;
	Wed, 11 Feb 2026 22:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770847848; cv=fail; b=dLuCOifEHVIEDgaP1OH50cpDzAJhedcHsdz2PKozqyZ+QgGV/Ucgn3o4cYl0xpcN9kOfCHePqygEDrcQpieOHgY5LywEYa99Hfw7o5rY31Z09IKRvJTY9yl1fwCRMLs3yVu4b5RzWy8jYmTNrJw+Ksn2mD4WNpf0hL0dxjZmWw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770847848; c=relaxed/simple;
	bh=HArMugFUP3u7j+GNHRmG8C0hg3A2JKUvYG6/Jxe7fh4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=Mf3DSv/upAnJh+2QVwvQ2rX1eXIstXpzcWYQdq0f8cK69aCKt0JJ0VbkJoOo+CSFbJ6KC0m8xVNe+jTCtBbr2cPjl/go374r9hsSp6ImogwlkPuBLZ94e+xl5U0VgZcIsfexVp8Sy55Kc+1HEY4YegIC0vhPsb1CqSTX3vairfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UAz3CD0J; arc=fail smtp.client-ip=52.101.48.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxkz/LeqonTE6tOFkFva8P0OqfBNmj72bmvPsxvu/MSI+KsSujKgF+kci9Xyke/QX0O3cEamTUt0TYP5nEBy3pEqHN5xTMUirF2kyDmJuRLwUXhL36D/fqpiR5trdw6TpFCtUf3hXNyS5tyOo8jHpdv5Qa0sV0i91kPygpgt8YE4PQD3/R5gEACqA4m8AjXOMpfLApPFhHIM6kp/jM1RTAQ0QMVu9oAN8wHuQAvK/PAfXstfAwbn6+cbQHenKKAA2jgJMpMalXEWX48Q9qt9nsr2y8uQA9d9N6zxYa8SoS6TR/cUiBJ38LqZtNOJX355laylQNoCUepSCzcT4oVMAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bg+GeCT+OKIeGl4f33hAKV0RI0cOjIrvBgC5fcB+oyY=;
 b=uWLR7i6HoXuJXo5Kkq9D3QhP8XBbYxWk19MlwgV6D9EGA0A0Cgcb5NS3EkNxZWYy7mwZ6EJVATyKqS4GQs1aDsDubDiK4G6HoIkdfBCRCqAh5dCK4ktDWOsEviVc2g+I4SPt38AVdhgtMb/1ArCaMzT5udlrVav5/sAtvYb6HtlzodE+WV48cS8qmHmPZdVE/hV/tAGD4N+nF1CA1mkssadDQZ0/YsTNu6nEYWaUr2P5j0mzH3lrCx8jq/tHDJCQ+M/bJHT5hyCEebsF66OcqyqPHmI/k/I1yFKGN4ePdgMT6QFYfBwHyoQPEgNmvIOS8VHUAGHscGn2Y0/YGabCZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bg+GeCT+OKIeGl4f33hAKV0RI0cOjIrvBgC5fcB+oyY=;
 b=UAz3CD0JlKC7XnDmwxHUfeyQ/9AorB0JQEZpCyupyxUD2gpGcJAO/lDqZhM98Q3WRYDVo1X9A/tgyYYwvmhNHTwPYvmrbwhiJsB7XepnKN67beITJc0OiSbLvFBZd1Vw+4DRNp5/vhCizfQ5GU+ubZ9eJhSvAqu2YCvEZz7cMW4=
Received: from MW4PR03CA0228.namprd03.prod.outlook.com (2603:10b6:303:b9::23)
 by CY8PR12MB8362.namprd12.prod.outlook.com (2603:10b6:930:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 22:10:42 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:303:b9:cafe::a4) by MW4PR03CA0228.outlook.office365.com
 (2603:10b6:303:b9::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Wed,
 11 Feb 2026 22:10:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 22:10:40 +0000
Received: from [10.31.203.44] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Feb
 2026 16:10:39 -0600
Message-ID: <ea32b5ee-52f8-4d8c-9d82-903d21dc1335@amd.com>
Date: Wed, 11 Feb 2026 16:10:39 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v23 12/22] cxl: Define a driver interface for HPA free
 space enumeration
To: <alejandro.lucero-palau@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-13-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20260201155438.2664640-13-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|CY8PR12MB8362:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d0f4b8b-973c-417a-46b7-08de69ba64b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0FoSzhFMmgrTVFFQmQ1bVl6VTJjRDI1K0JXL1l3VlBqaThsYWhmdWJhcDE5?=
 =?utf-8?B?WVpoOGtPUDZJU2xSQWY0Y1lQT3FUOGExaDBnSGRjd1R2emxyMDMxejM2Nytv?=
 =?utf-8?B?UHBkeDZqNTYrQVIwaHk3N2dtUnBSbG84Nlh0bTRtaVNsUWFYYTI5b1ZweHNh?=
 =?utf-8?B?VTRZeU1naDN0T29nMW1QaG1GblpaOHZPRHNGczQrandGblFWcWVEOHYvTTVT?=
 =?utf-8?B?MjRzaENkN1h1Zk8xQTA5L240V0RBc291dVpDNVpwS0hwWHBwZk9wcURnY0lR?=
 =?utf-8?B?NzZHcFRpbUk2QVNZVWhQUmNGMkplTXNORDdnZG1wekp1WDV1UW5vYWRhMGlq?=
 =?utf-8?B?KzVzcHBNU25GKzNYN1pVWkVSdWJuMGhjc0hOSVFqSGxPYVlSNmhSQnFla1h4?=
 =?utf-8?B?cFFtY25WTTRvZUpGUmZBdmJXSmloU1hHeEZJeXc1MTl2SDJIT01uME04V0hk?=
 =?utf-8?B?NmxFSjRQelliZUZ5UjUrZVN6Z2tkVXBpRzdlZWRjSk1EVE5zUEp0ZDhHMWRm?=
 =?utf-8?B?VmJCeUJrUjdRVmQxWHJTVmZLWExOL3FJTy9jK0RtK0tDZXJWK2x4L0RMdGRl?=
 =?utf-8?B?ZGF3ZXNKeFgzdE04cnNSODFRengwSmZlc0c2UDZ1dWJjUUoyRXk5ZVlWdFlY?=
 =?utf-8?B?elh4TTNGVVhtNTNMWHZQSlF2R1dwVkpnQ0czNHdSQitjcHdSdHYweFdyVHZy?=
 =?utf-8?B?Uk5vcTNoZlhyeGFwaXVuQk1yMVpOVW1QYkdmYlZyRy9SL000ODdIem50T3FR?=
 =?utf-8?B?WXRZZHhWTEhBM0FFcGJLODIvSUZjdEhmc2wvcXZ3cjA2WU0zQzRzVGdOcmlq?=
 =?utf-8?B?VzhnYllMZmwrUkgxU1haQzdxWVpDaHJ6VEtjMnJvNmp4MU5WWHFoRUc3WWhS?=
 =?utf-8?B?VXR2NjJKays1L3FZKy9pb29DbVY3bmFuRTVSRklOWm9mc2RLVFBFdUw3bU9y?=
 =?utf-8?B?c3BxQTdtS1ZxZWwvNmRUc3JDTVRBbSs0S3NFcU1XNmpaeW1VYXZLeTF4S1lw?=
 =?utf-8?B?MHducFFrOGVCck5IVFBvYklUTytyVHVvSWpNZlZzWkNVcGdvR0VxakRzWXdF?=
 =?utf-8?B?RG8zL2FaNS9sRHFzWGhmRGJSWDA2T2JNcmJRUE5saVNSVmNzbEhmaHppUGIv?=
 =?utf-8?B?QmNCSkROcXREUmJDcjV0UXVFY1NJd1BnODBJR2taVU15Q0hhblc3dVhhK0Jr?=
 =?utf-8?B?TFhua3F3RWNTSmFaNEFGRlVMNTRvdWZqVHhmQjc0bFFPNlZhY08wZmRSdE5Z?=
 =?utf-8?B?b0ZPTERJVmY1NFZ4L2t4aFRKdnpDQmhKbE0yTkVZQzFiNHZpYVZYTmc4N3M1?=
 =?utf-8?B?V1pIVlQ3QWhUVlRjZUFUaHdTOWlkVmJSRmhiY1Jqa2hHYlE4bTZLL2pkYzEv?=
 =?utf-8?B?eHVKVzBjRlU1Mjlmb0RLVkFBc1RqT2VudFQ3eVVlYWszZTJHc1ZvYm1xR2dO?=
 =?utf-8?B?Szg2THpXN2NWQS9VL1pDMlEzMS9ENk5IWm5LKzFKOGZERDJ6Y2dsMGdFaGV3?=
 =?utf-8?B?a3FITjR0MmpKN1dpUEY5NzdRTyttM0ZJYXd0RC9ZM3VOVlVaNXpwV3pJSEVH?=
 =?utf-8?B?L1dqdXlZRy9jQnFIUDMxY2hrUTYvMGI3aXJhSXMxVE1xempNZUxvUFZnd0FM?=
 =?utf-8?B?OEhBU0p4TW5QWVlGOUVleENpNU4wbWNQeXdOT1JFRjdSbForZ1VXWGVVVnNx?=
 =?utf-8?B?VlU1SVM4TjJvMXdRNTJKWFVhV3UyU0dvd0ZYVFlOQ0EzMUN6Z3g3b0I2STFv?=
 =?utf-8?B?eStTR2hYd25rdGQ4dlN1alBOTlE0NEtFUG9WdXFXdlVNYWROdHF3aUIrR05n?=
 =?utf-8?B?MUgxV0ZHa3FBWlRONTQ3bFd1dGpEdTRJSURIa3R6c211emlOZHdWUDVJNnNR?=
 =?utf-8?B?NVF4Tk42L09iYXJPVkY3aEZtejErb3FJanlhMjNObmNBZ2lDUVZrYW5GSjBa?=
 =?utf-8?B?QVJaUlZiZXcxUDdZSnpaTUd3REpXN0JTV3ZxdUUrdWY4ckdxeEJqZkZ3SUFx?=
 =?utf-8?B?UkFLazBiNUpUd0JZc3lRTy9jeklKQSs2SkcxRjF5MEhFaWpqVkxnS2tuNXAy?=
 =?utf-8?B?YmpHQS9QSE1IckdzS21iUG1YWjZ3MmlON2huUW9QdlZ6ZFRlQkdkK1NVTFZS?=
 =?utf-8?B?a2xOOFVoL2JEMVBQVVdGV1dLN0JvZzZSaHVwSWtVV0NVc3pQejFWN0Fjbk0x?=
 =?utf-8?B?eUsyR2pOZVV5anBvTGdkY0JENlVUVCtWcmU4S1NFS25VU1lWTWdyWlRBeHFk?=
 =?utf-8?B?U25GNU9GNEZoaitkeHZya1hCY1J3PT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	X2MVV2NGB950JFHS1NJgHJNrcl9QQ3oYlfDYN/DmkWyRKTtSK5gsyMRduaDdV+bCWGaZ1g4bivLpEKIoqmm4WcD8eg1mSiKuDbfbsVcYzIe/4wqxPh58uBTUoFBdtrkRxNLS+7UldRYjGpNMM0h/ncxb+5cn3kYOpxOB9HAudf9M1YqNfYJmM1wXQGjr2Z19e9b3UFslPX/dlz9vnotTaophCkW5r+YxXcvAM3SderjB0JuW+BZV4fKTYNuPQxeCMCyofW/AQQdYrW1URPCn8eafVDSiye8fCj3lZyw6OpyAFo7GWwbFwJpTuCPh8YdpGTj7//HUQyJtw6UuCTIlR11D0+8oRoUReMFiYFgCrcYyQkPHSiayFIO4fperT3XZBc5og6InoTYZRZFBZFFFYnbImypzd7mHESxMzJeYkAe2G2lWSgZp2I1LaJAij38s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 22:10:40.6565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0f4b8b-973c-417a-46b7-08de69ba64b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8362
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin.cheatham@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,amd.com:mid,amd.com:dkim,amd.com:email];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258364-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+]
X-Rspamd-Queue-Id: 5173512804F
X-Rspamd-Action: no action

On 2/1/2026 9:54 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> CXL region creation involves allocating capacity from Device Physical
> Address (DPA) and assigning it to decode a given Host Physical Address
> (HPA). Before determining how much DPA to allocate the amount of available
> HPA must be determined. Also, not all HPA is created equal, some HPA
> targets RAM, some targets PMEM, some is prepared for device-memory flows
> like HDM-D and HDM-DB, and some is HDM-H (host-only).
> 
> In order to support Type2 CXL devices, wrap all of those concerns into
> an API that retrieves a root decoder (platform CXL window) that fits the
> specified constraints and the capacity available for a new region.
> 
> Add a complementary function for releasing the reference to such root
> decoder.
> 
> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/region.c | 164 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |   3 +
>  include/cxl/cxl.h         |   6 ++
>  3 files changed, 173 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 954b8fcdbac6..bdefd088f5f1 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -705,6 +705,170 @@ static int free_hpa(struct cxl_region *cxlr)
>  	return 0;
>  }
>  
> +struct cxlrd_max_context {
> +	struct device * const *host_bridges;
> +	int interleave_ways;
> +	unsigned long flags;
> +	resource_size_t max_hpa;
> +	struct cxl_root_decoder *cxlrd;
> +};
> +
> +static int find_max_hpa(struct device *dev, void *data)
> +{
> +	struct cxlrd_max_context *ctx = data;
> +	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_root_decoder *cxlrd;
> +	struct resource *res, *prev;
> +	struct cxl_decoder *cxld;
> +	resource_size_t free = 0;
> +	resource_size_t max;
> +	int found = 0;
> +
> +	if (!is_root_decoder(dev))
> +		return 0;
> +
> +	cxlrd = to_cxl_root_decoder(dev);
> +	cxlsd = &cxlrd->cxlsd;
> +	cxld = &cxlsd->cxld;
> +
> +	if ((cxld->flags & ctx->flags) != ctx->flags) {
> +		dev_dbg(dev, "flags not matching: %08lx vs %08lx\n",
> +			cxld->flags, ctx->flags);
> +		return 0;
> +	}
> +
> +	for (int i = 0; i < ctx->interleave_ways; i++) {
> +		for (int j = 0; j < ctx->interleave_ways; j++) {
> +			if (ctx->host_bridges[i] == cxlsd->target[j]->dport_dev) {
> +				found++;
> +				break;
> +			}
> +		}
> +	}

This may be over complicated. I'm not quite sure how it works (I'm just slow today I guess), but I understand
what the intention is based on the debug print below. My issue is that ctx->host_bridges is only set to 1 host
bridge (endpoint->host_bridge) in cxl_get_hpa_freespace(), which is the only caller of this function. At that
point, why have the outer loop at all? At that point, you could also simplify ctx->host_bridges to only
be a struct device * const.

Maybe this gets called elsewhere later on in the series? I haven't looked at the rest yet. If I'm wrong, then
I'd probably add a comment saying what the cxlsd->target[] entries are supposed to be pointing at.
> +
> +	if (found != ctx->interleave_ways) {
> +		dev_dbg(dev,
> +			"Not enough host bridges. Found %d for %d interleave ways requested\n",
> +			found, ctx->interleave_ways);
> +		return 0;
> +	}
> +
> +	/*
> +	 * Walk the root decoder resource range relying on cxl_rwsem.region to
> +	 * preclude sibling arrival/departure and find the largest free space
> +	 * gap.
> +	 */
> +	lockdep_assert_held_read(&cxl_rwsem.region);
> +	res = cxlrd->res->child;
> +
> +	/* With no resource child the whole parent resource is available */
> +	if (!res)
> +		max = resource_size(cxlrd->res);
> +	else
> +		max = 0;
> +
> +	for (prev = NULL; res; prev = res, res = res->sibling) {
> +		if (!prev && res->start == cxlrd->res->start &&
> +		    res->end == cxlrd->res->end) {
> +			max = resource_size(cxlrd->res);
> +			break;
> +		}
> +		/*
> +		 * Sanity check for preventing arithmetic problems below as a
> +		 * resource with size 0 could imply using the end field below
> +		 * when set to unsigned zero - 1 or all f in hex.
> +		 */
> +		if (prev && !resource_size(prev))
> +			continue;
> +
> +		if (!prev && res->start > cxlrd->res->start) {
> +			free = res->start - cxlrd->res->start;
> +			max = max(free, max);
> +		}
> +		if (prev && res->start > prev->end + 1) {
> +			free = res->start - prev->end + 1;
> +			max = max(free, max);
> +		}
> +	}
> +
> +	if (prev && prev->end + 1 < cxlrd->res->end + 1) {
> +		free = cxlrd->res->end + 1 - prev->end + 1;
> +		max = max(free, max);
> +	}
> +
> +	dev_dbg(cxlrd_dev(cxlrd), "found %pa bytes of free space\n", &max);
> +	if (max > ctx->max_hpa) {
> +		if (ctx->cxlrd)
> +			put_device(cxlrd_dev(ctx->cxlrd));
> +		get_device(cxlrd_dev(cxlrd));
> +		ctx->cxlrd = cxlrd;
> +		ctx->max_hpa = max;
> +	}
> +	return 0;
> +}
> +
> +/**
> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
> + * @cxlmd: the mem device requiring the HPA
> + * @interleave_ways: number of entries in @host_bridges
> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and Type2 device
> + * @max_avail_contig: output parameter of max contiguous bytes available in the
> + *		      returned decoder
> + *
> + * Returns a pointer to a struct cxl_root_decoder
> + *
> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
> + * in (@max_avail_contig))' is a point in time snapshot. If by the time the
> + * caller goes to use this decoder and its capacity is reduced then caller needs
> + * to loop and retry.
> + *
> + * The returned root decoder has an elevated reference count that needs to be
> + * put with cxl_put_root_decoder(cxlrd).
> + */
> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
> +					       int interleave_ways,
> +					       unsigned long flags,
> +					       resource_size_t *max_avail_contig)
> +{
> +	struct cxlrd_max_context ctx = {
> +		.flags = flags,
> +		.interleave_ways = interleave_ways,
> +	};
> +	struct cxl_port *root_port;
> +	struct cxl_port *endpoint;
> +
> +	endpoint = cxlmd->endpoint;
> +	if (!endpoint) {
> +		dev_dbg(&cxlmd->dev, "endpoint not linked to memdev\n");
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	ctx.host_bridges = &endpoint->host_bridge;

Mentioned earlier, interleave_ways is effectively hardcoded to 1 (unless I'm misunderstanding
something). I think what you want here is to go to the CXL root and pass in the children (i.e. host bridges)?
I'm not sure of what the fix is to get the intended behavior.

It may be worth getting rid of the interleave_ways portion of this function and
add it later when someone needs it. You could also explain it's hard coded to 1/unused
in the doc comment if you know of an immediate need for it.

> +
> +	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
> +	if (!root) {
> +		dev_dbg(&endpoint->dev, "endpoint is not related to a root port\n");
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	root_port = &root->port;
> +	scoped_guard(rwsem_read, &cxl_rwsem.region)
> +		device_for_each_child(&root_port->dev, &ctx, find_max_hpa);

Can just use a guard() here.

> +
> +	if (!ctx.cxlrd)
> +		return ERR_PTR(-ENOMEM);
> +
> +	*max_avail_contig = ctx.max_hpa;
> +	return ctx.cxlrd;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, "CXL");
> +
> +void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd)
> +{
> +	put_device(cxlrd_dev(cxlrd));
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_put_root_decoder, "CXL");
> +
>  static ssize_t size_store(struct device *dev, struct device_attribute *attr,
>  			  const char *buf, size_t len)
>  {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 944c5d1ccceb..c7d9b2c2908f 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -706,6 +706,9 @@ struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>  struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
>  struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
>  bool is_root_decoder(struct device *dev);
> +
> +#define cxlrd_dev(cxlrd) (&(cxlrd)->cxlsd.cxld.dev)
> +
>  bool is_switch_decoder(struct device *dev);
>  bool is_endpoint_decoder(struct device *dev);
>  struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 92880c26b2d5..834dc7e78934 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -255,4 +255,10 @@ struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
>  struct range;
>  int cxl_get_region_range(struct cxl_region *region, struct range *range);
>  void cxl_unregister_region(struct cxl_region *cxlr);
> +struct cxl_port;
> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
> +					       int interleave_ways,
> +					       unsigned long flags,
> +					       resource_size_t *max);
> +void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
>  #endif /* __CXL_CXL_H__ */


