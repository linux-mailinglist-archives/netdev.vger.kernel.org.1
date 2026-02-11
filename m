Return-Path: <netdev+bounces-258368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACPeHKz+jGn4wgAAu9opvQ
	(envelope-from <netdev+bounces-258368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 23:11:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4C3128056
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 23:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D2B53038B85
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 22:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CFF32860E;
	Wed, 11 Feb 2026 22:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lykmlvec"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82F133032B;
	Wed, 11 Feb 2026 22:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770847901; cv=fail; b=Xh9m/qu5b33rutsCRo44TsXJOLW9vTkynVsz7+J1FWjonTJUtK4lhDXYGhoxtv0b4oKcSK6hWd6AQ4CqZFw8cszHjyHyEbe8QrEb5/alZrBbCSAYgaDLSsMOrrRUqu+3uJTA+ee1L8OOlkooj3Wyad1jAn3quwn3w1BQup42HiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770847901; c=relaxed/simple;
	bh=4VMdrTE9/HGzvlbA1SMBZt8cfkn5mxknUET/4ujC0SY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=GmrLxrLruPvPQuwZE9wA7GZRvx0cPmdxZFn8vsujpXYaJvY6AoIhSq/RQuyqHRnfcK6eCBHnppEh2YbpM3+1Zx5HQXpxLvwgJ7Kne5eTj2Y/nYzXeJ6KdoJ5DTJbwLXgcTnFlMTXz/WPPhZONr/8mN4PNP7AWnQiZWEqcZOqzJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lykmlvec; arc=fail smtp.client-ip=52.101.46.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNiyWFbOaRuGIht7NumYYpAJoXAD54Ea1dKYiQt3j4oRgHS+jzmV0Dr+C/8ZiPa75vcGjQ9sCuEsL1JSlKRDzrjb7ymG1O44x/YI+pLXWTboXx7+GXe3eMLeFhKu/UXLCmBeekmrBD2foAESSYUM6cO12GkV32EN6LDYnp4CFoc6LD4MGprmxxW8aBe1UnVpGlHrOfAUkW8gEDzYXdjgJxxX2+APUT6EYeta2bx8RhiL5rh22mANnBAQvhM/nhnI7XALBwYzWWLdUnYaFtyt/s8m9ze6KDRDnsdK2PWGKZjWmqT/NQCwP2Efn2cDof8UtQ/+QSDPc0TdzkicV+3mOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xp7HBVUtpnqKPfvzM+Ce3P2uxKJp/Le+PmF8L5VLRFg=;
 b=XeRLyjDYz3DPgwQbfFPJ1zPOk+Yh8Q9dZaHBgsZxVc+zxXdQFf7WG8/glJCd6QbUDwoNm/Yv6L9gZyRI4YdE1gRHU99WYMCQlncYIbeOmhpk3+NbOES6kgIqz4veiwhqZ9o/6dFdcvbmmw7GPdCautt1qKpN/CcBCw8PDuYDOTVTIp8SYtMT+fLyYWegiWV5kJBJtjdm//BpHQ6jPtgy0A1zkWoUMXlv66JhU9QfNKhlkrg7ogUy3JZ3Vh6YoEeTIgSKuMl9nzgaZpVGqUlGmKGQew6UGfrbOigRufpEyu2lrr27yewGpfWN4UxnJsA93B47BWfG1bC5PV8ZKhXHaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xp7HBVUtpnqKPfvzM+Ce3P2uxKJp/Le+PmF8L5VLRFg=;
 b=LykmlvecJRzlHBdxppNuYMq69w6BeDU7r53wo8gA3UMp5UYJy5kw7mImcT25c3od5ql0kxWaw/ki43Ke/FTYI6VbUw2YTzYVvjNM6m413B1rWpqC6hGlRhfEkMehIkMYQ7kErvl3d3sc6QAq91Q2mv9AOVkFj/Yk6PGae8LlQhI=
Received: from SJ0PR03CA0275.namprd03.prod.outlook.com (2603:10b6:a03:39e::10)
 by SN7PR12MB7106.namprd12.prod.outlook.com (2603:10b6:806:2a1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 22:11:29 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::70) by SJ0PR03CA0275.outlook.office365.com
 (2603:10b6:a03:39e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Wed,
 11 Feb 2026 22:11:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 22:11:29 +0000
Received: from [10.31.203.44] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Feb
 2026 16:11:27 -0600
Message-ID: <383d7089-d7ca-43ab-8284-694e60729770@amd.com>
Date: Wed, 11 Feb 2026 16:11:21 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v23 17/22] cxl/region: Factor out interleave ways setup
To: <alejandro.lucero-palau@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Alison Schofield
	<alison.schofield@intel.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-18-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20260201155438.2664640-18-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|SN7PR12MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: 16058034-a015-4b6e-0e57-08de69ba81a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0pyN3lVZjRzVE9zdnhpR1RuS0JLZ21hVktxQXJldEVtVnIrczJNWFdKYlhi?=
 =?utf-8?B?RnA4SHdKd0UwekNrMWFTY3VnSis0bGc4OTVSUmhQY08wSzV0OExEdTR6M21U?=
 =?utf-8?B?d1J0Y1FKeENEaUd5Q3ZvMzQ5anZuWVBXcVJRV2MxNTlFUmpuTTNoSFNOM0U2?=
 =?utf-8?B?b1lTOUMrbG93ZmxYMGVxbkZTQWNzOGFhSkFrZUVWczNpdWVwdlo4UmgvZ1lv?=
 =?utf-8?B?bzJNaldvYTlJV2dEaVJNMXdUVElHQWdqQmIyOXVuQ050b0lPVW9XTGJBbXBW?=
 =?utf-8?B?ZzF1bGY1SXJWR1FZZEVtUzl2TWxXMlFRS3I5azl3d3oxOVNUQXdReDFGdklC?=
 =?utf-8?B?bEp1dGhFSUZSdEN6eTc0b1dCTVhQTlNOWkJmU2RnVFp5L1l6Z2dxM0tKVlND?=
 =?utf-8?B?NlplaVdhdVBtNFVzeGQxMTE0SGxHb1FGYUZFN09rNEJIWEFyaStQaXdXMEND?=
 =?utf-8?B?bzJVOUlSUzZJQkhoRXVFVHhPVDU3L0dUM2gxOVcrbDUrMkFFbnJ5aTZ1QVUw?=
 =?utf-8?B?VDBIRFJ6UFhRaWMzdWNyZ3lvS3V4QnVvQ2E1NFNPQ3ZydmNiamhiaDA4SEc1?=
 =?utf-8?B?K3RrWFlnRDNsS3FhSDZnbHNJUGNhZklqZEZLanZwb2lGQ2xtM3AzbG9IRExm?=
 =?utf-8?B?QmVRait2Z0d2RWZoZm9lZFBQN0NBTVBmR1FXN3RFUGVnYm9EUjRiT01POXRo?=
 =?utf-8?B?VzArM1o3YXpWTVZvRjRoT2RydEIwOSt1amhOcnlSNWJOY0ZHbThOOHlFLzBn?=
 =?utf-8?B?eDZhZk1nWTJ0azVzK0RTUVRXWEZKNVNwbDlVcFQxVzVsbndCQWZPa0ZFeTVU?=
 =?utf-8?B?TE4rT3ZJY1BaUjJEQTQrcUQxaGd2aUhEa2loRVhoaGZjVGlTcWdTOEtqNThJ?=
 =?utf-8?B?RUc5YkFxSmpoS1NSdEIvKzFDRjlzQUs3NXRXNnAzSjVyZWtUWmRoZUZCM0Iw?=
 =?utf-8?B?V3lCTUZlNjdPb3poSXF2MWtXTkI1UzdWS3RwbWFKZy9QVWJZaVoxOVJuT3Ns?=
 =?utf-8?B?QXpUMklzb1pqVWovRUJPdmk5cWdhRzJKSXJkcG5YWlFPRHNPRFVjempFOTEr?=
 =?utf-8?B?dWpHc3dQemVQL2FNSnhyOVUwTmNleS9icm0zSiszZWdSRnNoaG4zS0dxenRQ?=
 =?utf-8?B?YWlVTTdZbnpMOGFwSlVIcEJlM2NWb0lOVXV1bmJXTWRTOGE3Z2RVUjZFY0hU?=
 =?utf-8?B?L0thWTJHMGpjbFJKd1B0YkxsbGhVaTlSL1hIa2ZVOExNSlJxZkY0eUFmMkti?=
 =?utf-8?B?MlpaQXQ1SktFajRXdWs2TGhOS0JwVWlteFZ1VFpjbjJFa0pMMTFHRDJBOGNF?=
 =?utf-8?B?U2ZkcGlPS1lUV2JldHRNWDVKb0FaV21QRG54aG0vS1ByWjRqUVQ3RUxuSXVD?=
 =?utf-8?B?ZWZodktEUU5sbWx2R1V0VmovNERXUlpYMWswbVFwRUFJY1BxRk80eE84VWlR?=
 =?utf-8?B?Z2JiTjVBeW5naE42bG52dzM2c2hmNUY3bEFJUTA4UWl5dzczQmp6N2gvamNP?=
 =?utf-8?B?N1diaytVZlgwNVQyT0NhR3d6T2o5NWZrcmt3L2VPOGh5YzNYN3g1anRHWnNF?=
 =?utf-8?B?SkprR1FPeEZodTN1N3YxcXJhQnhhTFU3bEZpMCtLNWp2SEF6VDdtQzE5UzEv?=
 =?utf-8?B?T2VCOGp5WmFVTVJmTXpsb3JEMGFEQnVoWTBDbGhJV2NVZ2V4M1NsTGNVbVN2?=
 =?utf-8?B?Wm04cXhlUDczYy8rNUkyTDVvS21OR2hGMkNVdnMrelM3TVdtNnhsc0NITFNN?=
 =?utf-8?B?NkVPRTUycjhvUk9xaVNtWGx6alBLbXNaSkNIMjdMOWpOU0l6cm1CbEZ6aUlS?=
 =?utf-8?B?c3JZVXZSanlYR24xWFA2bEtIajRBbXZlc1ZFWWVicHNOZWhGenhNRy9GUEI1?=
 =?utf-8?B?VlFZQmd1NDNndENvSnpXdEJOa1dQV09vSUdBTGhtSjBWMWVTOVJGeUdTLzky?=
 =?utf-8?B?YlR6d09uSm5TZnNNM2lQbXRUWWt1dXQ3djBuZUNBU1FtSk5oYXBINmlPSEJa?=
 =?utf-8?B?cmsxVmVHdklza2kzQlMrUU5JQmR5Q1NmUHRPM1hoNXh3OXRSUFFOT0l0Smd1?=
 =?utf-8?B?TGhFSWFkTkRUcEpmKzl5QVV1UlFCbEhVY2NSMjlPRGtBVlVLNnVPbW5qTGZF?=
 =?utf-8?B?Y3Q0TEFsRG5CNnZ5N3lYeU1UeEVsek9Dc2lUYUNQc1FUcFBQQkRKSUZSRURv?=
 =?utf-8?B?RVdVN2JDWVgwck05RXdvN1RhbWkvYzJMRlIwYW5lM3NBZytOLzFtc25xUlpo?=
 =?utf-8?B?cXU3c051dGVWcVJ0cVpMTitHWTZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nADEchfcTt/PdnfW70QrpZZ+QYIgGUDJzTBJ47CUI8NgnbKBLKjYXrKJvVmXLItVB0uW4QhtGJak9IwCLZcmeAPVAUZ2pDyFXD/H1Twewxrd1nUvxdCleLlijMY8M5/5vdPlJ1AHCfaALynwLQPd/gmf0gRVZA7T328auUjdbGTM/ZqCfxeVA4p0XgwV+SzGgaMFkuOoAwtOjZ/Hcq15IBpogUaVAffUgZHy9Wc54DcgrRuw4yd20ka13JrAlm+n2Ol/PsPSP0L+anhV0WSaeRUQKbem7/QKrCXMXy3sFLhbuWakQRbzf0CmJI93x06XZXocmSjEi1f9EQhPDMJOUikhjCqH3I+OZcYbQ4rzwu8KyKxX1hw4DMBE3Xq5iznZbDRUv5fQ4ISVDYcnWAuWdPF7skPuPiIvNvXjracWlzLbBxxJAIfjgZzCtzaLMeNT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 22:11:29.1426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16058034-a015-4b6e-0e57-08de69ba81a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7106
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin.cheatham@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,huawei.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim,amd.com:email,nvidia.com:email];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258368-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+]
X-Rspamd-Queue-Id: 8C4C3128056
X-Rspamd-Action: no action

On 2/1/2026 9:54 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Region creation based on Type3 devices is triggered from user space
> allowing memory combination through interleaving.
> 
> In preparation for kernel driven region creation, that is Type2 drivers
> triggering region creation backed with its advertised CXL memory, factor
> out a common helper from the user-sysfs region setup for interleave ways.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/region.c | 43 ++++++++++++++++++++++++---------------
>  1 file changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f53b2e9fd9e6..ece1d3df7cf1 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -485,22 +485,14 @@ static ssize_t interleave_ways_show(struct device *dev,
>  
>  static const struct attribute_group *get_cxl_region_target_group(void);
>  
> -static ssize_t interleave_ways_store(struct device *dev,
> -				     struct device_attribute *attr,
> -				     const char *buf, size_t len)
> +static int set_interleave_ways(struct cxl_region *cxlr, int val)

@val should probably stay an unsigned int. You pass an unsigned int in the sysfs function, and the
function was originally coded with that in mind (same with @save below). With that cleaned up:
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

>  {
> -	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>  	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> -	struct cxl_region *cxlr = to_cxl_region(dev);
>  	struct cxl_region_params *p = &cxlr->params;
> -	unsigned int val, save;
> -	int rc;
> +	int save, rc;
>  	u8 iw;
>  
> -	rc = kstrtouint(buf, 0, &val);
> -	if (rc)
> -		return rc;
> -
>  	rc = ways_to_eiw(val, &iw);
>  	if (rc)
>  		return rc;
> @@ -515,9 +507,7 @@ static ssize_t interleave_ways_store(struct device *dev,
>  		return -EINVAL;
>  	}
>  
> -	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
> -	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
> -		return rc;
> +	lockdep_assert_held_write(&cxl_rwsem.region);
>  
>  	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
>  		return -EBUSY;
> @@ -525,10 +515,31 @@ static ssize_t interleave_ways_store(struct device *dev,
>  	save = p->interleave_ways;
>  	p->interleave_ways = val;
>  	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
> -	if (rc) {
> +	if (rc)
>  		p->interleave_ways = save;
> +
> +	return rc;
> +}
> +
> +static ssize_t interleave_ways_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t len)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	unsigned int val;
> +	int rc;
> +
> +	rc = kstrtouint(buf, 0, &val);
> +	if (rc)
> +		return rc;
> +
> +	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
> +	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
> +		return rc;
> +
> +	rc = set_interleave_ways(cxlr, val);
> +	if (rc)
>  		return rc;
> -	}
>  
>  	return len;
>  }


