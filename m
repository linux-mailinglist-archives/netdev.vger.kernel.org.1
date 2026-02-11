Return-Path: <netdev+bounces-258363-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDt/NnH+jGn4wgAAu9opvQ
	(envelope-from <netdev+bounces-258363-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 23:10:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20158128015
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 23:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5EAF73037345
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 22:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB0032E137;
	Wed, 11 Feb 2026 22:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NdKAYlIN"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012064.outbound.protection.outlook.com [52.101.48.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B37632860E;
	Wed, 11 Feb 2026 22:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770847842; cv=fail; b=WZVQL/Te/KBA9JBLunQgsw7+pV0RlvxQiPJOI/xlNkK3F22bpJuq8et4E/2M/OKjNzrye58/W6fUsy+2/SzDHIeWIWnfPcTb0h2TdZCotqhPYyPaWhf8xiDZuenCNLRihtPOm2ryU1HfVLl2wJx3i7jeHiP1AZyy3tn5Zg7hE7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770847842; c=relaxed/simple;
	bh=tZj0y1FXCssP8wF9TyT6ZAkLE1IXbHi24w3nEWTXtN4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=t+7+bMNvFFMrGSyBT2h3hWBIs6NZg/GsGxlsN45JiAkmlfgpr1zpfCxqx0OcvjAQyrfQdEOp1s2mePcRF6nOPBde6UyGZpRaIBCi73+nI5553d3KmubMvj3PdWbz5670EWrSy0AVmm6Q0uqXnPOoGyM4jHnKMvn63ZAY/R5Cl2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NdKAYlIN; arc=fail smtp.client-ip=52.101.48.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfE1hMWbEHlNVgqbiAbeSW1PWZ3kCTPI7AAmK/YwOaKkaEdGkI0N/m/bpnv1L/OlB8+f0FNeME7yOLDGkGt9Pvmed8sU/7WWQpuQFfA/J4BlbZJI/vR5P57v9JTiywaFAqXgurJm8IwdeqTzmBFyKuVrVEBqyZQfjSIw+DuCmljRbQ6fSzS8yysiydsJMlgBz+RpaX3iN1mFxf+/ulJHo94hOlGFL7ZteSAYai63vGVnqlCFgpURc3PZR8mS0DZN6Pn0tl4aqBA1tI/eBm5ZGVLc2SzGYAdkf1vmlxYry85gJ+cLSeq/99JDz45kZRN/CWsyMdwA5XWFDu3V2N4ytw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YnuuA/Gzr+YhD2hsndzHXkv6UY3epHYMkD4XD6G14g=;
 b=GlKq7sNsZbHL8yS5UpeBygyWudHqbtQI2feCQcrE+73HEvbVjdIuX8ohEnt285nmv2YL3soT4VFT1y0MvDGM+5tggG4SB3Cb8hfXSIAo3JVJ1wwdGFos1g6sF/DIK2NMAU0J96erncZqrkX9p67Eajx+Q5VSrbmyd68S3WEycwfyKTpNgCridKynABvE+1WnpWY/8CzROcXoxLe9Zay0zCx4QV7allTwP2dixqhbhDauCerdR+K+7JBjniFGIANblUeuvXI/uYTL3SUTzuiPk7ThGHW852fTAhpAiOuI/6ppK8wK3s7IVl+T0i+xaTprzNZwGks6edVtDVHTVkloqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YnuuA/Gzr+YhD2hsndzHXkv6UY3epHYMkD4XD6G14g=;
 b=NdKAYlIN9O/qHkJMGj+hjGF8IqP5CQTFEmYbbUvUfXcvtf/4f6BdRrCLHa0AxMd9lmJnUDjRLYrs6AS9xxYtlK1CKFGgkukJQLBHUvn6eC+tj5jqbz2xwe8n1riALuMVBx8xjT0g7iF8t+XiFZE/gQr8X+DpXjf6cE330CUlp4A=
Received: from SJ0PR03CA0261.namprd03.prod.outlook.com (2603:10b6:a03:3a0::26)
 by DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 22:10:37 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::43) by SJ0PR03CA0261.outlook.office365.com
 (2603:10b6:a03:3a0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Wed,
 11 Feb 2026 22:10:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 22:10:35 +0000
Received: from [10.31.203.44] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Feb
 2026 16:10:34 -0600
Message-ID: <76556d1b-646c-477c-a315-33c3bb3cd981@amd.com>
Date: Wed, 11 Feb 2026 16:10:28 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v23 20/22] cxl: Avoid dax creation for accelerators
To: <alejandro.lucero-palau@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Davidlohr Bueso <daves@stgolabs.net>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-21-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20260201155438.2664640-21-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|DS7PR12MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: 553423ad-35c4-485a-4b71-08de69ba619a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2dIRk9EWXZ0SGFTSDNscXVyZGl3Sm40bEhXSDZSZFpJSFFhRmJmd3dNNVYw?=
 =?utf-8?B?TGw5dXBPa25oY3NXRVVXUWpaNHUvWmlYMko5UTZIZHdIb3dQK0t4TnRxVU0v?=
 =?utf-8?B?cmdTT1hpMmxxRFZqOFJTR21qUjVRTU1lWGlHMjZDOWwyeGNVMVBCcFRZTkto?=
 =?utf-8?B?OHF4MzZ4SFVZMnFBNkhFSnJTSlFiUmJ4dkVzcFdyTGt2amFSVmpyb0dNU2dT?=
 =?utf-8?B?REhaZko2QzNXOCtQNUp6UlpEVWROaklBQVRSU0p0NE0yMmtXN0J5MTRpb3Ja?=
 =?utf-8?B?Z3I0dUpsRmF1dWEvRkg5bFJGNlo0WTdZdGFXYzM4d3dPV1hyejJNNnRaRVJ6?=
 =?utf-8?B?M3k5QjYyYVQrTThFU2k2OEJMM0Ridld6bjBMVlBiZlpaYUJheDgrNjVLWlRl?=
 =?utf-8?B?RHpITEZhVFU3bUUxTkpwNlFhT0x5RGFCaXJac3dYMlRNdzBTUWpuQ2ZFbThW?=
 =?utf-8?B?dGRFNmhvN0hOT1htQ0FwU21EOHNyN1hIaW1SM3ZkbVl5cm01emMwb1RRN1pW?=
 =?utf-8?B?UW84WVE5Nk9haGt3Q3BFYlkzWmRFQTA1V2I3T0Nod2xMTHp4bVY5cXNIb0NH?=
 =?utf-8?B?UzFEVnRDVEFLUUkvRUM5eDhjS3lmMFJwU3hHZCtSNytwdzFHMngvaGJhcHc3?=
 =?utf-8?B?RVlqVWhIVWxhenJtSUFFZ292d2FSTXF3K1p5TmJoT2VLcE5McHlTLytSYjZE?=
 =?utf-8?B?SlpvYUNCd0d2REMzN2dnYlc3Q3MzbTNXRGY2eVRnbktib2RrZDY2d1BjU2hz?=
 =?utf-8?B?dVpDd0RKVGJaV3FNdTdaK2dEdUlBMXNOZUxGT0FsMTAza0RLU0RaNWkwbGlE?=
 =?utf-8?B?Y2JHNGNLV3A0TVdnaWZNbm82MHRqcW1QQWIrZmYyZFNCcXl5YUh6ZnNKaGda?=
 =?utf-8?B?OFUwR0l2QnNYR2owc0FVc1JFbHlyQmR5dnZDM1JMb2JWSm1DNGtCZjBZM2hE?=
 =?utf-8?B?MXhLUzcvVDlnVjlQSTVHYkh1Q3J3bGNwNGlaaXFoMkNOQ0ZCRzFYeEdlRTNE?=
 =?utf-8?B?UzNWMWJUM2JNY2tySkd2cjNpWVI5OFFVVE1COTM1NHM1Q2hFdnl1WnNzZHhz?=
 =?utf-8?B?by9JSXJIZzJENzBoeDZ2eWhFdXZEeGs5QkVkQnZyNEVlWjUyK3JWRzVXNC9I?=
 =?utf-8?B?SzRoRTUyLzNoL2R6ZE16SVp2b0s1MHh6cjRXQzhUVTY4dWVXQysyTndlY0oz?=
 =?utf-8?B?N2ZMWTdyeldHdjR6dnZMeEJBWHRxMWVrYzEwN3A3UjJ5TE5SR0xjME9RTDA1?=
 =?utf-8?B?NlRkeGpQbzh4T2hNOFNpK2VHdG5tV29HTC9BVzllajRXNS9YZnZhcHFzdlRQ?=
 =?utf-8?B?T3dIMjU5NWZlZWlzbGlwYXFtc3R4Um93aUhJS1BPL3FOa1JoVUV5OUhDdi9m?=
 =?utf-8?B?dzNVelZTNVF2MC93WkxKMTh2ekpTZHRQbVY0bXNHUkdaNEd4b054dy9IRU1S?=
 =?utf-8?B?RGlTUVI4QnhqSlQwZUFaZ1lzZXc0WFp0WFoxOWFsajRPV3NwRkk5MDFXNWdV?=
 =?utf-8?B?T3kxTENLWjFjRm5RUStIb3Rja3Z5ZTNtOXRyUlVYcUF1dlJTcEM4c0toMUVs?=
 =?utf-8?B?VkdhNkNqTjNDVHM1ZjZJL0srcW1JZEs2M3FQSEV5a0Vjc1ptZjhIQUdlZk9S?=
 =?utf-8?B?ZDhKODZZSUJhUk1QaG5rUTl6akpOQmdsNEF2MjZBdnJaNzRrY3BhekROVGh1?=
 =?utf-8?B?RHN6cDhtd3MvdzdUOFUxUjB2RFRGQlI5OHVHVmRRMlRic0pETnRTdnJVbnN6?=
 =?utf-8?B?dThaV0E3b3IxaXZ0V2kyNDR6aURjUFYzenMrS085aGJDZzhzQlVqeDAvL1k4?=
 =?utf-8?B?Y01xSWVxdkVMVTlGSjRUM211SDlxcndEeGNIaHJuSWFtUXdLdFJVYVNrcENk?=
 =?utf-8?B?YnR5VEVjYnRKQ3UxdUY1SzcyZVUxUVE1T2tmRTdoaHhpM2JSL2NleXQvelcr?=
 =?utf-8?B?emFFZWtuY053ZU4rSVZySzJWczMzWDdvaG9WTEZYek1uWk84R1VIcXZCeVVi?=
 =?utf-8?B?dFNoZWJ2d29qUHJzOWV5dStsaWQ4YWdLTHZ3ZGF1QXpZM0VuMGlTazczaEU1?=
 =?utf-8?B?cVdiaHJBVWRaUEpNVkNtbXQ1b05WdGtISjI5QUFDVDBKUFoybHVId240MUNa?=
 =?utf-8?B?V09wWFR2RGlqemVYcU43QzMrODdxL3lET1pwMGZKY2dXdG56dUk0YXdCcW04?=
 =?utf-8?B?dnNJNjROY2tCQnVEWGYrZjBnMUdVOEFld0tkMzNGK1pVOVpneXBjZUU3cVVP?=
 =?utf-8?B?QWpJa2xjL2RMQnBMN0RJcDNQVmF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jsR6u93FGngLVl/oqom2U2K4AUZA/6Mr7EvAGKON7ukheZQ4BNitv8zzGd84jOrDOKQcrzNgpZxtrNl5rlf5G0qn061Ye49zvngbZcTSvVZB3nv2/fPU0WqLVFQxWu38wyXIGzYWHyJ03FPHHU3uVuSM8CFCYQ5L3a3R8v7jNLh3y+pVU9TiVBEkXoZHMnJxqAso4zlRYfJMBQd6H7uja72i7AjqtCN/c7D+czOlECsyGeq37pqUCOkw/Jd7R/8TTJM8GZNvWuhgZgjsSS1V+s3nLp7zZf6MyjXMOIEUr+GnmajPjKPotXPp2acoCu1A74NCBwMp3pPfVaHEeNor/QssUw2mYBAM+tXwB4eqL9GjcqqnAda5wJTqRx3JcmxrEHPRYT6ambj2No+YVdVbgMrL/NScLxMGRRmGqQZizkTDzkKsC01CKarFrIbYn2t5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 22:10:35.4219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 553423ad-35c4-485a-4b71-08de69ba619a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin.cheatham@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:email,intel.com:email,amd.com:mid,amd.com:dkim,amd.com:email];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258363-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+]
X-Rspamd-Queue-Id: 20158128015
X-Rspamd-Action: no action

On 2/1/2026 9:54 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> By definition a type2 cxl device will use the host managed memory for
> specific functionality, therefore it should not be available to other
> uses.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Davidlohr Bueso <daves@stgolabs.net>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> ---
>  drivers/cxl/core/region.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 293e63dfef22..12df717cc881 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -4441,6 +4441,13 @@ static int cxl_region_probe(struct device *dev)
>  	if (rc)
>  		return rc;
>  
> +	/*
> +	 * HDM-D[B] (device-memory) regions have accelerator specific usage.
> +	 * Skip device-dax registration.
> +	 */
> +	if (cxlr->type == CXL_DECODER_DEVMEM)
> +		return 0;

Minor nit: Should probably move this to be the first thing in the function. It would save
having to acquire a lock in cxl_region_can_probe() above. Keep my reviewed-by either way,
it's really just a minor optimization.
> +
>  	/*
>  	 * From this point on any path that changes the region's state away from
>  	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.


