Return-Path: <netdev+bounces-258372-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGX6HOH+jGn4wgAAu9opvQ
	(envelope-from <netdev+bounces-258372-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 23:12:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F03C8128097
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 23:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2F4230BA88E
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 22:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C6C34321F;
	Wed, 11 Feb 2026 22:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="21YLCvVT"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010020.outbound.protection.outlook.com [52.101.56.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833E5202F7C;
	Wed, 11 Feb 2026 22:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770847923; cv=fail; b=muTx7o+TPhH7ePGISM9RG01CvATGf/NGPkcWHpi3kQ+Dvi9vWvsuL8e6MX8OPuTivr+5HxbdtnRz05rZ5MFOoj9oipl4tq/xyPQwX43wvlAp58dOn83FTMDSwAPfevE69VWk+cJdxZuHwmrCCHc8R5jXxmeWCYfRMRdamcaHPIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770847923; c=relaxed/simple;
	bh=16ZvJEBEo/CS4H815FcnzKkNz59GH/u7nLHKcTQyyGc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=NWAPcRuavQQXb06Zgvla2ZAQCSPCHQpelLRscuTClpr1FinA4UrReM+WXDxJWC1QF8TDUOK4o0EHZ1ZlEF/jH+ftGLsKbFABfXfkvM4aVUkVQ5DmVkIDbqvO0qFP0OYXvCpsRA/QupJmzACWH3sLvP48cazukd6U7jGGgze4TrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=21YLCvVT; arc=fail smtp.client-ip=52.101.56.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmqSKCaKHS33SrllucBeP5NMozxHiErGKMvg5FPZQKEdhUqjovDn7RMK77Y8je81070K5dSoB36Oco+ZFVj1OpIMufepKvBLmCRFEBqARI3cNd739b2Fv1E9GTzGDLRpRrLNZjmucXmTlD5tl+SBu+5KvDPS89vUXJaN6yQFnQ966UTlvHfIpm/7mkXi1Vse4oVAxAvW3SgOOpUYtXFl1BO+otKCWLnQceWuVE5prB6qAv7WhGLdE4lFIo3J+EpW9hHIhcB3SL+9kdKYYILot0Kw44Qhmk5xmX9F4uBzqlee4mn+mSZ0/QzwJx6DGwjTjLsJQt5pPYxK3FiX1XYPdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRm0ocn9zqXa/ROEcbjzJ0rRmAR2+qpBiCcuGXa8+lA=;
 b=GUTUvikw06Y2d4lAdSJSQ1sEM7lxp3Vqi9+zvLUY5zndTP2qlMFtsUNvjUN1zred2cXUxF1pvtCEnCl1O+1LgBpm9f26wm0pxJLkpp/aoA1NnEAic5toWdlzs6REb/sCf3okXhtRfy2PCUsS/bDDLohKc3xgQfKUDLUfqSKkTIwVhy1GxoZF12BN95q3q4+hyRL3UP+YCWK/oNgymMSN1sMvrR+jYN+r69+son/Iz+OaytlTQzTwQG5wwCCWo2oNhOn8SjGXvbD7GuFI1gr7D6axne+5ofznyG5Wb3XfYmJU98PsFFf+hi/FoB2v8XADIpxGqt31ZBPeonFZyJdZaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRm0ocn9zqXa/ROEcbjzJ0rRmAR2+qpBiCcuGXa8+lA=;
 b=21YLCvVTv1eG1mBvDiaUDQ20x9xxyoE8tIZUD+CgD4GJ6SgnLgXLzcyIgmwBW49Spu4zyZ097KJQmu9iMfdRHhrhQtKSi9xhL406i7yWNjFgdKIg9ivpO06A4pM6L/+7/Yuzkpc1uC6Zo1n1rlFbMZpzwUacXSyMHxFHU8TphzI=
Received: from SJ0PR03CA0232.namprd03.prod.outlook.com (2603:10b6:a03:39f::27)
 by SN7PR12MB7129.namprd12.prod.outlook.com (2603:10b6:806:2a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Wed, 11 Feb
 2026 22:11:57 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::4d) by SJ0PR03CA0232.outlook.office365.com
 (2603:10b6:a03:39f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Wed,
 11 Feb 2026 22:11:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 22:11:57 +0000
Received: from [10.31.203.44] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Feb
 2026 16:11:55 -0600
Message-ID: <03ab7820-a6e0-4655-bae7-61d2d0b7dfd6@amd.com>
Date: Wed, 11 Feb 2026 16:11:55 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v23 08/22] cxl/hdm: Add support for getting region from
 committed decoder
To: <alejandro.lucero-palau@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-9-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20260201155438.2664640-9-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|SN7PR12MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 94b5b141-6494-4e54-924a-08de69ba925b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXord252N0lpUjlsdUNDYzJud1lUdEduTmovVDcvTlRCZW90ZkZBTGhEdzdq?=
 =?utf-8?B?aDZlOGszT3c5c3hUUUJTMDJNOEFhVTU0RUNPUmJZYlB0c3c5NHJLWjZIa0xP?=
 =?utf-8?B?SU5aT3J2ZzhYdEQ1Sms2NEkxeVBCT1FEVEpZOVpvOWVtYklzNU94NlNUQzBB?=
 =?utf-8?B?ZHNyb3Y0Y0x3d1lLbVBFeGlRZmJqYzZMWlllUVlXZWo0Z1RaZ3FHbnRWV2pL?=
 =?utf-8?B?TWl2NC91NTVWNGtLMWliU2g5K1NSSHBuUW81ZUJKSUtLTXFYRnVzN0kxak9u?=
 =?utf-8?B?U1NIVlFCV2ZYeWM5Nmtzb1drTE1jbmtJZ01YZXVvM0drM0xPWitPcE11bW10?=
 =?utf-8?B?d2NKRTdCa1FaNGRNUHpnQXZBdFRiOHgzbnlZeTVTeXhzVmtkL1FXNXNjMCs5?=
 =?utf-8?B?MTJYQlRseTI1Y1JucE1nTGhrUVdVYnpmMnVIWi9hWVgweVZEQnJtdkhMa2l3?=
 =?utf-8?B?ekV2eXdhMGpkZzhKNS82aVVVMlI1VXBJbUJvRU52MUpRZ1VhSzRyKy9ZTEdp?=
 =?utf-8?B?cGdycDZZZ3liUHJab3F3KytmckhnTU9wYU9BY3cydjhqYnJoQ04zT2x4OFpn?=
 =?utf-8?B?TVlFUlg1MStHR2VpK3lMdDlNb0FLK0ZySUxRUkV4bWk5Y0FzbXMvTDRBSkpq?=
 =?utf-8?B?WHhXM0ErWVA5bUY1Y1RrdHJ6Sm9RSTNGZlpTajRIV0V5cCs5SVJsRjljWVdp?=
 =?utf-8?B?YXJiR1BuVVZoVzBuelRDVjhMM0JDY241dGtkWjVJV2RXYmtrcnAvRitKa2pP?=
 =?utf-8?B?K05yanRUeGpiTjJraExKZ2xsa21Tcjh3OVlJVUtQSURHdmJ6dDEvYWlscXpR?=
 =?utf-8?B?d3JLQUpuTG1vZG13QmlPYTJmMUNoSXNXVFF5TlUyMS8zMkh0eHZudUpxRHJt?=
 =?utf-8?B?dU14YnpsWlJ3LzhTUDZwUjBkNFJ4dXpjeFoybUJVMU54OWN2WHFhc05pcmxM?=
 =?utf-8?B?L3FEcTlCUFRhWmlkb1hpZVphU0dlVm1OcFVDbnpGM0FuTnFvZWsvM0ZYY3lZ?=
 =?utf-8?B?SkZKVkVJeGRnZTB2S210RDBLNWN2QU5uVkJ5Y250eGcydk05WVpPcm5iYmZY?=
 =?utf-8?B?VndwVnMwbDJsNnBHY0pxQTNnemwyRGgxNytRZE53Wm01bE5udWpoUUJUcWQz?=
 =?utf-8?B?b1pzbkRYbWsrSW1neDhCNXRHd21WNHZZUGszazkxYzhCdGx5NHk3NWRMWFZu?=
 =?utf-8?B?b2RyWU1HbGpsRm9NU0VnZTRUTWFzQkQrelM3c28yRkU4bFJRckc4bnNROEFw?=
 =?utf-8?B?Mk85ajZqT0FKbHRrU0lUQ216eFlIdVZpVDBiS1luaG5LQ1VxcEQ4U0lEVXl0?=
 =?utf-8?B?SUprQkVPUXE2QmIraGpXS2FKVG84RzBKRENUZVJKWDB5amZjTnZPdVJRenhs?=
 =?utf-8?B?K2pSRXptTU1KeDVPbmJXWTZwRmh1ME1nY1lSU1ZUY2RFcVFtRktBMWtjU1pS?=
 =?utf-8?B?ekVhR3FPTWFDTUkzMlZkV21JdGZYV0JFTTdHQktqSVV4ZVQ5bU9XemVtN1Ns?=
 =?utf-8?B?NnBMOHc4SEZyd2dXWTlaRUFrRUw4d1Zic1pxT3VLQmxDN0U3REVHYVJFekZj?=
 =?utf-8?B?TnNVR1hHWEdqdGEyd0xJb1N3U2RUNmx1RzltUVVVYnZROG1VWXBoamZ4K1k1?=
 =?utf-8?B?WHpEVU1saVVVOVpMK3hLbDVGMW51VSs1MXZwbDFxaFBUU3d4UCs1ZW5oWTNv?=
 =?utf-8?B?WlhoaGhyeHJObXc0cHVUcDh6NXFFREdobCs1Q3VsMS9Hc3NkZG5sNE81eCsr?=
 =?utf-8?B?eEZXZjN3ZjA5OUsxR24rRldydXNlQjltMlN3R1dNd29WMTMvRWQ3Y3JkMUgz?=
 =?utf-8?B?Y3Vxd1ZPN3Jhd2tRZGhIWmFOR1NSeU5rdlRtOFdTZUV4ZUhHWS8vVjZpRWJk?=
 =?utf-8?B?RitWUGhxNVVaMm1SV0tOK3V6SmM4MDZYN0pmZHJNengzYlJPUlZ4b0NKdEZ2?=
 =?utf-8?B?dEpDNEJDSnhqWEpuaU90cGxPVGFDVkNQL2pCcHdjYjB1VEdNRk9YeGd4SGNF?=
 =?utf-8?B?Sml5UElZZjRESE1jRTI0ZVkxeXh2U0l2VWZtcHpVZFZDL2JvVXJPWGNOWmFD?=
 =?utf-8?B?S1RNVE5vTGdxOXhKL2FBT202eEt3YmxmcmduUU03U1RFWnJ2RjBoZFpONE93?=
 =?utf-8?B?ek4vYzZ5OFNyd3gydFJqOW9Qc1p2YUxpMDZkVXRzdzFKcFBMdjJlSC85RkJz?=
 =?utf-8?B?c0grZ3VIS09kSEFCZXo1Qno0VUM5TDZYZkx0QVB1MUtUNHdrNlhwWlUzelhJ?=
 =?utf-8?B?QWw3bDVySXpReTRsTEVWMHk4N0NBPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vlimBDqjDTYsjuzEEJlWTiW0YU5vtL3rCYgk7MijtQaxiAWgF1pCqNgrvJhUVkoCegIScDjRVx2e3J0tj/wlNlWwXz7TVcKgtS93A4WZXXLcr+g2uYGrWeJggJZ2RuNmgnDBn5IES9vkhbcTUSDR1OM71rkUj9/f6aZM3Te6AMrmUoYCEVLSWFR5WgjU7682L+dojznagmIMmANL3matOuM+30Og4yAyqJYyyE2rXSKkBvhVIfeJUdqOfnmggjdrykiODJPhFD0VAJ/nGlmNF7N3dWriPRtCslBuPOCKKfcfDnJ1MnxF+MCw34Xlb7ovvQTgzemFbxYVnKjNXq9m8Rscq9xi7KMjoIdzbmdDRGpj0llou6VYQPiTmz5AMGi2OCp3r4/n+fcZ89V1KlY+hYsyXjZ9aWcYgp5rB3+p9DhDqnEx3bfIVJXL3Hzah4Vz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 22:11:57.2164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b5b141-6494-4e54-924a-08de69ba925b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7129
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,amd.com:email];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin.cheatham@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258372-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+]
X-Rspamd-Queue-Id: F03C8128097
X-Rspamd-Action: no action

On 2/1/2026 9:54 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> A Type2 device configured by the BIOS can already have its HDM
> committed. Add a cxl_get_committed_decoder() function for cheking
> so after memdev creation. A CXL region should have been created
> during memdev initialization, therefore a Type2 driver can ask for
> such a region for working with the HPA. If the HDM is not committed,
> a Type2 driver will create the region after obtaining proper HPA
> and DPA space.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/hdm.c | 39 +++++++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h      |  3 +++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 6e516c69b2d2..a172ce4e9b19 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -686,6 +686,45 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>  	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>  }
>  
> +static int find_committed_endpoint_decoder(struct device *dev, const void *data)
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
> +	return cxled->cxld.id == port->hdm_end;

Is this the way you're supposed to check if a decoder is committed? The doc comment for @hdm_end in
struct cxl_port says it's just the last allocated decoder. If allocated decoders are always committed then
I'm fine with this, otherwise I think you'd want to a register read or something to find the commit state.
> +}
> +
> +struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
> +						       struct cxl_region **cxlr)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct device *cxled_dev;
> +
> +	if (!endpoint)
> +		return NULL;
> +
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	cxled_dev = device_find_child(&endpoint->dev, NULL,
> +				      find_committed_endpoint_decoder);
> +
> +	if (!cxled_dev)
> +		return NULL;
> +
> +	cxled = to_cxl_endpoint_decoder(cxled_dev);
> +	*cxlr = cxled->cxld.region;
> +
> +	put_device(cxled_dev);
> +	return cxled;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_committed_decoder, "CXL");
> +
>  static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>  {
>  	u16 eig;
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 6f8d365067af..928276dba952 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -249,4 +249,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
>  int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
>  struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
>  				       const struct cxl_memdev_attach *attach);
> +struct cxl_region;
> +struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
> +						       struct cxl_region **cxlr);
>  #endif /* __CXL_CXL_H__ */


