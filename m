Return-Path: <netdev+bounces-271564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OK69OB7ow2lvugQAu9opvQ
	(envelope-from <netdev+bounces-271564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 14:50:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F89326228
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 14:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 946E4307B1DA
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 13:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFEF264FBD;
	Wed, 25 Mar 2026 13:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bIGemVPy"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011015.outbound.protection.outlook.com [52.101.62.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD032BD5A8;
	Wed, 25 Mar 2026 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774446116; cv=fail; b=rpgyY9SkpIQnqnc251O0Blhtt847S4PAx/Ui2pMTIIef8jRk9fzDIEe1vhqn6tsr90Uv/7IZTlurKmhntqVS+dvrGC3XCpb1SGUjmba1LyMkQnfGjcQ4Mh5Z2roxRcRRnuvU7myqo9Bogs7upoo/nVfvIDDEVX2TmCTjab7CZds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774446116; c=relaxed/simple;
	bh=iMUg7JtwFWyXVzncdx0nzytetsXUo16hsgzGE2X/dQ8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MST1t3nN9pf1SofVSHubDinqy2ZCkXB50Q1iZWW6Et+Teg1JK9azpqvpNcBmR6tMJf5NyOgD/G6/8PTLLGS1XHcIR64rG3oOxnnYJKumCXCS2NFRmV6mGAi1QSRseJFe7i1qaJnRJTPvpH/dp7rm5/01F3WQ9HrHtXuA2Prcnas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bIGemVPy; arc=fail smtp.client-ip=52.101.62.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIyfAljAtyNh52nMoH1GWfMcVrbASmNRJKS8AGWGd+SSv8loWj4r/nsHO229T0cSv92o9QfCqYPd4GCXj5espSILUz1EJv8qEJH6Ttt8v20UeuRNirMbpffX+ZVOqdgX0i+DkQCt7/+aeBt9WuE7sEsRxt+URZXFx5ztssL6GvnaxRcBGayAiFB5zlOWhsaiNjmre4x2B7Sm791zKsgkEykWmaOSYm8IvJ0cwTRIxocu0cgQDa1B+9s7EDRRRPTE7PMYrgMzqzzc8FawCqwTFGiuxr+xbH0yMBZNOlnxEnIvt76A1TEtGMfGU5BRobWDnMZccoShtAsbcK6WYKvggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYbga98ZiTETqFdLGeijs+DqY3dCAyYo5vUQTwv0kK0=;
 b=tDBk5v/E0at3ua7zv4Gfz6KYLmgknXkFUqt8CTTdjgyMzLWDEqCoWVkHHKKcQTuGXw1sINpHur8+2xVrRz4TTAK5Ua9X3OlH8H0mDGJhybDEf9Q3p47zl39rWYgGLfrWx8qnjG+mUsWTLiVENU1YKpZ7z8HZGdW6QRz1yyuneSh/uJ6id0hdMnr+6qQSTACBafZqaHJRFwvZHU1x5MgYT9pF/EDKAYQ0dKRYw6nckcyqpFETbLroRjJxb/jvbaW0yPylPnG5w5g7Mexinh7Msy2d5upYjp14yYwPODyNpsyuskJxFBOTawQgTgipCWDJWFMyw6jQFcjPvS+CW3vnlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYbga98ZiTETqFdLGeijs+DqY3dCAyYo5vUQTwv0kK0=;
 b=bIGemVPyqqlyvrsgEb4tg4J3eibMoI5u6GlQjdKWiynfI9NgxVHk4PbzwensMKgEMNL/wNi7o/Vg9yu6kdbALwBEgTm6RCmrSLFa3rn3FI5amBJ1wTo2Sl+rop8f/VKHV+wQubIYnp5fQB05BPZc7GhmIbQUzvRDXJT21uKKwjATf2j3zfEQqjDfLzJCWXer1Chb3SaR3kb+mKjOojR6+Sn3zaBHFz2H/z2RGOyoDBE9z5OR5FlDdBKy/HZEit4/rvNhhd0ZAxthwVUabsF9rTqVWiEfGi8d5Yq0ajH4srCYbXM4eN4MozKVbSrnJHFByfhZRyyPaemolL2DlziT6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by MN6PR12MB8470.namprd12.prod.outlook.com (2603:10b6:208:46d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 13:41:52 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.20.9769.004; Wed, 25 Mar 2026
 13:41:52 +0000
Message-ID: <954da5a0-1e85-4b43-9b7d-c1f025d5d1c7@nvidia.com>
Date: Wed, 25 Mar 2026 13:41:47 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/3] dt-bindings: net: Fix Tegra234 MGBE PTP clock
From: Jon Hunter <jonathanh@nvidia.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 linux-tegra@vger.kernel.org
References: <20260324121631.771628-1-jonathanh@nvidia.com>
 <20260324121631.771628-3-jonathanh@nvidia.com>
 <177439307874.2078673.11304788250514370726.robh@kernel.org>
 <5e0a6a5a-dded-449d-8789-e2a5e0a169e8@nvidia.com>
Content-Language: en-US
In-Reply-To: <5e0a6a5a-dded-449d-8789-e2a5e0a169e8@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0189.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::33) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|MN6PR12MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: e005798b-d28c-4c2f-07a1-08de8a744580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	aQvmdEuM2uWItcHWWGd0A7wMzBi7DKYxgEL4mXg/oCv2Khnrdj5au4I3hvqgjybyJzj8SWIgHvFMa9VyQsJ1yChYfwXRD2Iet1iN+L/AkE3Pc+CLUsq+nREelzMBw4OLMhbKludj6v3OHHpQmZyeatiGb7cVmzOGtFZLcETNiC1OioRIQFwQuvluvRg+fIfavjBohVM0jGajYUo0L1ShgaIbHu9xxNHYH4vHmm5pqdFGmffSGLd5WW3+ty890RacqE7lTGAs1br3YHGzBVSaldPq3DPlq32UU+gP+++DDt2j1o+xkBkrGd2rUDHYemekWL44hNWWFZzHu0AW6PJuVUQJZWORBDvrEoUHRzt5nnIMiLlf377wfDDha450ziNOmnU2+SHPRK3hXIBncI4TleKwpk+63tNq/UMMnCVee5OGPrz7SIsWShJtHwPCimRtWagsDi9QEz2WpfPLMFHB3PxD1JHp1h+Pbn/uo+/ZB7DWpEIXWXIHey79uyPndiOr6JZIliyDi0cU2HFmcbpZrhPXn4TUFKiFGm2+UyEtorDGPZsh4ySM9DsFWO+6mdftVY/At4FoHzMUQsg/5vMh+De0Xl25b+85K7rUMbG4HFgccxj7YZZmpGUz8nM+juRMOZsutQ+WBqT9yYpaZ4Ez3TkzbbIY6Of1idLYFdtR0JqtcI4h/HQbRW6HOPsMPcHDt1xzeYLfKowT3j2+j6ZnWF45l+Z1+kcZg1uTMd72c00=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wno2aWFkd0d5ZEU3VnFHeGUvVWhEUUplcVN1eTQzay9NQ0doaFhvNFFYRFVY?=
 =?utf-8?B?SndsaXlrRTBTZHN6YjRNeGE5Qno4M3BhTUZsemtlWkhGVXZ1TUdob0x6MVhI?=
 =?utf-8?B?OEVmbUo3T09XeXFTVFNzWWJHMURCN01iWkh2OWg5Qm9taHF3aE4rUVNHcVBw?=
 =?utf-8?B?QWQ2WG5KSmJqRVF4U3RWU28rSmxML1RUdDVzalpneWRka0FGaDRmaUg1d2dy?=
 =?utf-8?B?NEROUFA1M1ZvVFgwbnZLb2Z1bE05RU50amZWSmNETE96UTBZdnpDc3NpS3F2?=
 =?utf-8?B?Nk1EcVc4bGRZMmF2NldsT1lmUFNFRmJvYWN1NUc0SzBzWGt5K3BIY0pIcXNW?=
 =?utf-8?B?bWsvdDVyMm5qWVRoUVRTRHowZnhlL0RxS2lTQW5UcVFaTnJnWHZYdHN4MzFx?=
 =?utf-8?B?anVIU2FEWkM2bTNoTkwzYmx2TEkxYndzRjRzWi9tMnE0NlZNVWNuUCtKMTha?=
 =?utf-8?B?aVM5cW54VHBhcWgvUWI2RjlmTVFpRmhuUnA4TzQvRXM0SzAvVXdLeEpTNHQr?=
 =?utf-8?B?Z3cvL1NMYlo3K0JBeC8vVUVhRXBERzVpeHE2MHFYSlh6WVF3ZUxFdHF2eFdw?=
 =?utf-8?B?N2VRTEJ6VUhMZy9Va29icHUxbzJYcXo1ZjZQSHZzaldxVko3dzNrSnNVVi9t?=
 =?utf-8?B?eHY3MTNKeUl4b0R3M0t1NmpoUlowWW01MWRzemRPckxyTzBsRVVlVy9aZXNj?=
 =?utf-8?B?dXZEQkF4UklOWTFSakNUQkFUNTJGb29adll5UmNrMFNnTmVsbzJId0JqL2Jn?=
 =?utf-8?B?VGxvYkd0MGV4bnJFSnBEamtMOHlrU1hQRm5kZEtkMHB5dlc2Uk9VVm56aVNE?=
 =?utf-8?B?cGtrUFdnZjFvZ3RjeVRPSDVxZmtUQzVXSlFiaGZFWTJ0VUpwb0U0VmZ0MWtD?=
 =?utf-8?B?b2N0a2F0QmRmSlBObVJRSHl4ZDM5U0wwYXBIV0hDMnptbmVJcXM2b0U2Skt4?=
 =?utf-8?B?d0NCYlpZSHg3bkRqL3NsamtlelpyVzE2Ti9vNFdsRkhwTzFOUHBzaVZocWFz?=
 =?utf-8?B?TVhzSmZaTG1SYzZndVFLNDZsbnFjQ2U4TTBsMmR1VkRORTMxdmUwVW5mMG52?=
 =?utf-8?B?UytodXUzYk1TalZUYjcxbW41QkEzOXduTTJBWUwwd0xJditHYXFoVSt2eXRz?=
 =?utf-8?B?REtXY0dWTHRVYjdzaFpmVVVPYzBwaE9Tb0QzTzBFUTNWamhHYVVvSHZDYlNC?=
 =?utf-8?B?QmtaRGxvamhIWGRyaUNySXo0dGR1QmdrcDVMdWZCM2xGSURnZ0I0S2tJeTdO?=
 =?utf-8?B?SnM0ZUVsa01MNll5RWVjeUwyTFZWRzN4WnVwWGVXK2NES0Mza3JsQU55ZmhO?=
 =?utf-8?B?UVFRTEQ3OW9zRlVZUDIyVDVBOXprMlcrNmdmNlFDSHVUVDBYQmd3dDJjSlNS?=
 =?utf-8?B?UEJBdFhjc3JBRjNPb21HZ1ZBTUZ5SzdqR2FYaVpIUmdnczlLN0xjeW0yenN6?=
 =?utf-8?B?RFFTY0s5UDlVd3AxZzBzT2U0QUtaZllyTHIwNUVMQ0gvb0hkN2Z1SkdDWWYr?=
 =?utf-8?B?K29ET0dCN0h3aVZ2azdnNnpMeVhLZmNIZEdzam5nMFd4OWcxTHY2NWs5WExN?=
 =?utf-8?B?ZkI2QlFlNUJmKzZ5Zkg0R0RRbUhHY3JESE1KMzBiS2c5S3NPZUhQRFRQUWx6?=
 =?utf-8?B?R0NRbmF6YW41TWFIRTdSdGdzbk9TMUovWDBzWkJGczBhMWpXcll4THdBcDBZ?=
 =?utf-8?B?RFl4L1k5Q1EvQm1iTEdWc0huNXRBQVk5V3lHSEFQUi9wbEpEclFJUFlMOTk4?=
 =?utf-8?B?WUNpTzRKaTR4ekhyekRIRWFEdzNEeElRV25nRk9QN2FaWTVxcTdyV0k2VzZj?=
 =?utf-8?B?dVYyR0xYM1Q3cUNhQ1BreFpISmFNcFI3MlVjQ05BblFyZDc3ck4zZnphdGox?=
 =?utf-8?B?M1FYSnQ4eDVQSWVUUzRnSFkyNlRhYTdTYUkzdFBaNWhUaWlLN3ZMdUxWNEVY?=
 =?utf-8?B?WE9hSy9FQ3pJRVA0Z3BsajJGKzJYSU9Pd1pqTWNLRHV1SGJMZXc1TDRZdUdW?=
 =?utf-8?B?K2F1T3FuS1lmSlN4cXFPVmFKUlAvYnFYckhZMlladkFPTlQ1Y1lQd2pHNjUy?=
 =?utf-8?B?c2xQckhEVFN1ait3NUFSWGIvRGpJY3REczhEQjNiM2NVUmhlckRMWGt3R0oy?=
 =?utf-8?B?NXc2SE5TOVU0YVJLOFlhYkJ3SWFRc0RzVGVtQWtLLzU1THZQdjF5N01uUkxP?=
 =?utf-8?B?RzhUcVRSVjkwZTZFQVdadW5Sb2lZSEc0R090QklzUlNkcGJQTE5HcUsxK1dh?=
 =?utf-8?B?Zm1LUnUyZExmemFoYXo2Z3BtcDY2blVYOFNmYjVRZEpVbmE0NlFoaGRVL21U?=
 =?utf-8?B?NW1kSTJZVEJZRDVlczdjZnpXWjFQeVJ2ZGdQSnF4dmNuZGQ2ZnJ2dEJZRWhn?=
 =?utf-8?Q?w+gB/EUL6rHtCpV2LzUCLRMzFxpPvvN8tjPW5Sqr/1fF7?=
X-MS-Exchange-AntiSpam-MessageData-1: 1L5ehhJVMi/O5A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e005798b-d28c-4c2f-07a1-08de8a744580
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 13:41:52.2545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 48zKuqKzFoErW2BTEZjDEch34mpUbnF4bfQh5H3lciyn93wBZng/CZDmX78U3xdMpF9hr+kafTCihSNax4aV+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8470
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271564-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,gmail.com,davemloft.net,vger.kernel.org,lunn.ch];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.103.194.128:email,Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,devicetree.org:url,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: D1F89326228
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 25/03/2026 06:18, Jon Hunter wrote:
> 
> On 24/03/2026 22:57, Rob Herring (Arm) wrote:
>>
>> On Tue, 24 Mar 2026 12:16:30 +0000, Jon Hunter wrote:
>>> The PTP clock for the Tegra234 MGBE device is incorrectly named
>>> 'ptp-ref' and should be 'ptp_ref'. This is causing the following
>>> warning to be observed on Tegra234 platforms that use this device:
>>>
>>>   ERR KERN tegra-mgbe 6800000.ethernet eth0: Invalid PTP clock rate
>>>   WARNING KERN tegra-mgbe 6800000.ethernet eth0: PTP init failed
>>>
>>> Although this constitutes an ABI breakage in the binding for this
>>> device, PTP support has clearly never worked and so fix this now
>>> so we can correct the device-tree for this device. Note that the
>>> MGBE driver still supports the legacy 'ptp-ref' clock name and so
>>> older/existing device-trees will still work, but given that this
>>> is not the correct name, there is no point to advertise this in the
>>> binding.
>>>
>>> Fixes: 189c2e5c7669 ("dt-bindings: net: Add Tegra234 MGBE")
>>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>>> ---
>>>   Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.yaml | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>
>> My bot found errors running 'make dt_binding_check' on your patch:
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/ 
>> bindings/net/nvidia,tegra234-mgbe.example.dtb: ethernet@6800000 
>> (nvidia,tegra234-mgbe): clock-names:3: 'ptp_ref' was expected
>>     from schema $id: http://devicetree.org/schemas/net/ 
>> nvidia,tegra234-mgbe.yaml
> 
> Yes this is expected until patch 3/3 is applied.

Well apparently somehow I managed to miss the example. I will fix that now.

Jon

-- 
nvpublic


