Return-Path: <netdev+bounces-302644-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AWRhAQ90Qmo67gkAu9opvQ
	(envelope-from <netdev+bounces-302644-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 15:33:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3E16DB3FD
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 15:33:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=PwMnYTaX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302644-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302644-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9D6B3063CF0
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 13:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8FA40B6F6;
	Mon, 29 Jun 2026 13:20:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1122240B396;
	Mon, 29 Jun 2026 13:20:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782739214; cv=fail; b=jszpv7PVOAG1973cUX/gE7+DbxUswKnAsGD5yTCdF+SxlyRisT8Tj5gyK5Xxb5LsijODm72Ll12Erg4E8dLBgOp58Zgr/TVXXCP7t5tthGIP5dC5m6Yie5gplHqVFSjqfvKw+jPhbJWGZI654pM5sz3uP7zvhF5LNrToBlMqKnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782739214; c=relaxed/simple;
	bh=DLV3JzX9UJZyiMDnpO3GELl4Q6iOpXs4Ogpath2wiig=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XOOtETaEAdyukpOUbmoWUJCsMskuFrw7TMIQXuqPGJTSDh5C/I6fr1Zj/iyRVAcQSNeYz9952A5vYAlctkaDmHkuVJasdVxrH7CcvwewUkRlwI3V9lff2OucyZiq0HumEOJrUB6bgzsScXrP+jO0tGpd9jRrddUT4sf3YGvdMnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PwMnYTaX; arc=fail smtp.client-ip=40.107.208.15
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anIhbUTyhH8n3HnHuFtwZzrqsgfV4TeudHOwhHe+idBYQ82fSDgjpKQkqacRpS3VAV9sndc+aOjSLrOoz6yAEYicTIMk2ir7sYJOpA++LMNbE2kZluxCFh3a0VXCkxviHXbsuSb1RV1Hfg4Vf6CkPa4eseFD8PuDTRRRSd2e2mkQK+JkqxpRd3m55VLigLnvMArmPTbqoaFBW/6JhN/5xLkOS6F3OviSl3/mEQboj1vK/7Es0ilMuIDfD0onZTesHRo07qmIdWQMK2tuiV2QiRlfpoNl5hdmqlJADms08KGpG/rGujHDPsF2Ey5RKCQ5Wy9VVo4eLCBGyfP7hIkosw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCG3b3wdI8k1jerGSUp6nKeRq+GU5pmXN0n5e6b5e5A=;
 b=Krv0et91KqvEOJosqlH16pl2r8R2Sqrmm4XOtvdxLtU7hVcrZ6Io01kVLFeZH9PqMu/QqRSr/L2Ti/ccAEUriZSs7q0GaP/9wfq2YtL01chss1uWOWiG/ORmAY4ZLDC8goGohQAS2Ps8RR5U3Czmr6+K+6BE7+BuTgKt9p3eRv7YaVrDHhypAkKW3DDS0xfxJZVzpqNXWm0FkJSMCT+naTjH0ep3bCWLK14Qz29xaEMBFO6hD9VD7fXY0SiFzQCfw8qgDLJblYGFuyvvj2royHt9VumT/+Ep6OjMtnghJvYFRVpwlNGRplA2eBeEOItn37gzlGW4wHjdoM25Eo4ZPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCG3b3wdI8k1jerGSUp6nKeRq+GU5pmXN0n5e6b5e5A=;
 b=PwMnYTaX/wLTf6x9gCa7U9NXulrCI//oy1MNzodUEyQaQHI5X8KTvnNOi/2U/6vDPYca45M17HfM+ojrt8OmJxwoG0DfIyu34xuWUzH3+oBDnfIMSDNb6X6E92dx1BYspM81COCE5rgsTfQ8c4DhKsXkk7yRCGo5Q3eObG0cggs=
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 SAVPR12MB999119.namprd12.prod.outlook.com (2603:10b6:806:4e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 13:20:10 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 13:20:09 +0000
Message-ID: <bde77dd7-fa7b-4d28-9a7b-3f0ce6587bf4@amd.com>
Date: Mon, 29 Jun 2026 14:20:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v29 4/5] sfc: obtain and map cxl range using
 devm_cxl_probe_mem
To: Richard Cheng <icheng@nvidia.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@kernel.org, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Edward Cree <ecree.xilinx@gmail.com>
References: <20260622124010.2192888-1-alejandro.lucero-palau@amd.com>
 <20260622124010.2192888-5-alejandro.lucero-palau@amd.com>
 <aj32gUuoZuTUODry@MWDK4CY14F>
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <aj32gUuoZuTUODry@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0010.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::15) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|SAVPR12MB999119:EE_
X-MS-Office365-Filtering-Correlation-Id: 8316450c-bea4-40f3-6140-08ded5e124bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|6133799003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	YhColWN98ey4UOLOxOByOo9g8TFWol1eX/WEo0W9EVDw/fv9IjN98YFFoTs5AN0fpiVOiU5Yi4uJfINKH1WRlPZfkOJc8N5v6eklCZkYkSRSNxmF02LOtsALkRBzN69a3YXbb07TRC0tGCcZIWv0ojhXlXEI3CJuZ46xXsbDqMrQSLKscp+KXv8mc/loq+OOuXrvo1hHM+D2vs78Q66ptR46Ah0cHKffuSIooNLf90wd4ONVaUfNTkOIluIytR4kuAUqQt04n1aE1vHJk/nhRmcf/QzdeaXgcAoUK7UwAXKqrIjXMw+uMgINkpTKOZpiF89x/SFXsIHgyRYzOqqZbYSLUMqR6bE0x55AsrxIBAQ65TFt87DEBkdJUCrUnWywju1iu4tGl0FNGOTO/WipER9bSJDJSkRzp8xKwti4oZYA43SbkvOl4hnhv6mowDA60h6xQ6ImC05FlR1zAP2WHLdEXTawulMKsv4cdnQiWQ2EipIKgXD2BxFYiuCVRk+2GxxM2WZCXiGYsdR/AHpf8TirBplXEujmCoXM7hB+Yyb9FmaapooNSiMe5emhncOMK834cL07mvmXn9+M4JSCLfbZaEGkVdeoDVcDTIHsZCLrbGNZojHFOPEXfRg5zMfhIi3y9qkR4H3sTjuXeGBAbZuMWkd6hksbSO10NJ+Obek=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHZzQXdtdnBrdnlVL3FMcjVGdkt3M3JzeVQ2SmRuWCtsQTIwaUtJSTFUTEVI?=
 =?utf-8?B?L3Jmb1VLVlVPSWszTjB3VzFBd0Q2Y3NmMkY1RXhSK2ZnZStjeGlLa1lUT0Jr?=
 =?utf-8?B?b3hTQ0d5ZDdPOUtSMHUrNXozazYvcTBPYVBtS2QzSlhTbkM0N3BhZkhqRXVD?=
 =?utf-8?B?S2VwZCtvMmUwdVVCTUZFZDQxNnhUd2tqVFJkcEZ1ZjM1RFlNSUJWaGhUVHBk?=
 =?utf-8?B?dkV3TWkybS9qT3RMTFd0SHB4Mm9LL0N5cTBvVW95NEcyK051YTFKblNuYUMx?=
 =?utf-8?B?aWVKRDEraXUxOFRaa00wcjM2LzhMU1Z2SGUrRjloZi9zYnEwUHVmbElEamND?=
 =?utf-8?B?Vk40a29KOXZKSnR2QzNpTVltQlJieHo0QW13aWMrbGlIdFhJRVlHZ2pQOTFH?=
 =?utf-8?B?MHh1c3Mzd0pmL3RQU1VnQUFjYmhtd0xFYnJTZ2FJcEg4TW9nU3JsaDM0cDdB?=
 =?utf-8?B?aWNDRXBkZ1JPZXRiT0F2cmg2UU55WUZlQ3NtaUcrZkJBcWQ0Z0ZrLzNmbW5m?=
 =?utf-8?B?bnBYaW4veHNhQ1ovcEtMc3Y1Mi8rMVdIUlhCLzVYZkdGUkFySUp2R3ZPZjJL?=
 =?utf-8?B?cnlFS0VBalJIK24ySWZLZGVLVmxhY1RzRU44TDBNdjN0V3VWL2VqeisrOElO?=
 =?utf-8?B?THJyWW80ZU1vRFg5UDZSaStOaVl6dmxPMDI2RXN2Q3M2YzdoenErTkJFWVcy?=
 =?utf-8?B?U1hxelpEcm55UW9UNlVhM3hWVGZxVnFHOXkvSldQRnpnUG83WUtSWUVUamsw?=
 =?utf-8?B?enhLY0ZYQndRYmltM25XemZ4WUduWkk0YUNHeE1vSlpreUhZZ2EzUVhzemVj?=
 =?utf-8?B?U2tkakNJcjE2ZDQzSjN6cEdqWVRQQUxsalNmdjVsSy9SUy9GRVlhZkd2cGV1?=
 =?utf-8?B?bHdodXUycnBUVGR2QmVVY3hFenEvYTg4a0J6T2tzNk8rU3pCeG9vMWZVTThn?=
 =?utf-8?B?cjg2SzNzbTJzNEZ1ZzZjWkVRWHRreDJ2YWg5UitiVjFtRmNEeWQ5cEk0SHZD?=
 =?utf-8?B?NDZNNEN6T3YyL1V4dEFSS3VxcTFoSmR2R1VZdjRxV1lQQUFVLy9KeVhoYmJG?=
 =?utf-8?B?VEhJV3VrbHVJRERnOHgwWU0yM040RHgvRTVUcVZ4N3dmS0E5ZWhzQlhSb1Qz?=
 =?utf-8?B?ZGo2dThuYm9PaS95WnhldlJKdC91cmpsVE00bDYyVVZtMy94QnRKMzd1WW9C?=
 =?utf-8?B?Y2Jsd1RBU0YwODJNelYxUlBCbGQ2eUdvalBGZ0tUQkRFYVY4MG8yU3hwU1BR?=
 =?utf-8?B?dDlRaDRXaFNrWVVkc0UrbVNRamFmZEVWTnc2bE91U0ptRlVxTDhiZy9mRnJa?=
 =?utf-8?B?Rm80TEloUFlSYmpUT2FlTmdIL0l3R2N4VGx4Z2Z0bDlxZjNZL2RWbWV0L2Jl?=
 =?utf-8?B?dmZiNnVRb2tJeGZYNFpLeXkyTmRDYnpTZDczWGNqZWxoZGJYeHh2RHJhcXdJ?=
 =?utf-8?B?RG9jUVd1VzNUaDIzWjZrby8xMnNCN0pSaXNwampKNjh2MUozblM4YjBTSlFt?=
 =?utf-8?B?Nmdkdk8zblNoblIwb1I2eGwzZmF2cEFCZ2FCWnZmNHF4and4emt0dGVQeUZu?=
 =?utf-8?B?YmI5MW56aDBHTnJvRWg0RDJGOW5KUG5kNFRQMWZ3SEFQblhHVlpOT2Iwallo?=
 =?utf-8?B?Y0tZeEpiamF1ZlZ2ekorZWQxZUVOWHA2a3lnNEVrekFudHRhbDFORlVZTW9X?=
 =?utf-8?B?eXpxNVpBT0M5d24vUVFoZkdPTWxkUUYwTk5GazZPMVE4Ykd5ZklpdEs4dUZz?=
 =?utf-8?B?M2lSL3RwbE01cllCNUFzNmxtSVdEM2ZQL0R0YXkvdmpnQ3gzUWJNY2dZdzFT?=
 =?utf-8?B?OU5kbG5uZTJDNG93dUhROGhNYjJkZkFFQUF6Y0tmeUEwV1JWQjh6TGJTS3Fa?=
 =?utf-8?B?ZkI2RTEwb1N5c0R6ZWM4eE1OVU04aTFFd1dkQ0RZVGdiZkFkKzluWWtpeXNu?=
 =?utf-8?B?SjFCeGlUWVlIVGwydWlCQndXRndUWmtkaVV6cDdsT2VBSEtRbTRSZ0dVeExS?=
 =?utf-8?B?MkxwRERiaGZ1QVMycDFZWlAvYTZ3NlppOXFCSk5uTDZicUNEZlVpd1BLTG1P?=
 =?utf-8?B?OEtjY3VFcjJqRHBLdk8rYkwwOTc5SnJUOGlBQnhZS2MxREx3R002SUl5OHFT?=
 =?utf-8?B?TXdmY0t6OXBqYS9oZGtlazNUQkZiVmdsRVE5TWtQZXY1YlRqcXhlSDRGUXBh?=
 =?utf-8?B?RjJnWmxQQXVIa3NTaVk5STh2dThJY1VUZDBEdWpGYmhDMkpRY2lWRXpKSFZS?=
 =?utf-8?B?eGNhWm9ZQVpPajAwSzQzRGd0ME9LNDBOQ2UzWHNmbUJoeWo4S05GZUVuVldn?=
 =?utf-8?B?S2NQWE9aWFprRjNjRnlxV3N2SmsxYzJqTTl5RkF6R2lsUllUQnNIQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8316450c-bea4-40f3-6140-08ded5e124bc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 13:20:09.6863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNsBmMYC3WhKvWnNdSUFjJJtIalIy+wxcEpCDqdOLntxCNu3EfmGx9I4wNwXk6QNMHmmowd7cHAqzxDaFxjq1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999119
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302644-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:icheng@nvidia.com,m:alejandro.lucero-palau@amd.com,m:linux-cxl@vger.kernel.org,m:netdev@vger.kernel.org,m:dan.j.williams@kernel.org,m:edward.cree@amd.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:dave.jiang@intel.com,m:ecree.xilinx@gmail.com,m:ecreexilinx@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,amd.com,davemloft.net,redhat.com,google.com,intel.com,gmail.com];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alucerop@amd.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C3E16DB3FD


On 6/26/26 04:52, Richard Cheng wrote:
> On Mon, Jun 22, 2026 at 01:40:09PM +0800, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use core API for safely obtain the CXL range linked to an HDM committed
>> by the BIOS. Map such a range for being used as the ctpio buffer.
>>
>> A potential user space action through sysfs unbinding or core cxl
>> modules remove will trigger sfc driver device detachment, with that case
>> not racing with this mapping as this is done during driver probe and
>> therefore protected with device lock against those user space actions.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>> ---
>>   drivers/net/ethernet/sfc/efx.c     |  2 ++
>>   drivers/net/ethernet/sfc/efx_cxl.c | 23 +++++++++++++++++++++++
>>   drivers/net/ethernet/sfc/efx_cxl.h |  3 +++
>>   3 files changed, 28 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
>> index 61cbb6cfc360..3806cd3dd7f4 100644
>> --- a/drivers/net/ethernet/sfc/efx.c
>> +++ b/drivers/net/ethernet/sfc/efx.c
>> @@ -984,6 +984,7 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
>>   	efx_fini_io(efx);
>>   
>>   	probe_data = container_of(efx, struct efx_probe_data, efx);
>> +	efx_cxl_exit(probe_data);
>>   
>>   	pci_dbg(efx->pci_dev, "shutdown successful\n");
>>   
>> @@ -1242,6 +1243,7 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
>>   	return 0;
>>   
>>    fail3:
>> +	efx_cxl_exit(probe_data);
>>   	efx_fini_io(efx);
>>    fail2:
>>   	efx_fini_struct(efx);
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 18b535b3ea40..3e7c950f83e9 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -18,6 +18,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   {
>>   	struct efx_nic *efx = &probe_data->efx;
>>   	struct pci_dev *pci_dev = efx->pci_dev;
>> +	struct range cxl_pio_range;
>>   	struct efx_cxl *cxl;
>>   	u16 dvsec;
>>   	int rc;
>> @@ -73,9 +74,31 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		return -ENODEV;
>>   	}
>>   
>> +	cxl->cxlmd = devm_cxl_probe_mem(&cxl->cxlds, &cxl_pio_range);
>> +	if (IS_ERR(cxl->cxlmd)) {
>> +		pci_err(pci_dev, "CXL accel memdev creation failed\n");
>> +		return PTR_ERR(cxl->cxlmd);
>> +	}
>> +
>> +	cxl->ctpio_cxl = ioremap_wc(cxl_pio_range.start,
>> +				    range_len(&cxl_pio_range));
> Hi Alejandro,
>
> A small question here,
> Is it possible that the FW would commit a region bigger than the range ?


Hi Richard,


Not really. We are using the minimum size for CXL mem, 256MB, and it is 
not configurable. If CXL is enabled by the sfc device firmware, this is 
the only possibility.

It could be a good sanity check though, but I prefer to keep v29 as it 
is now ... Dan Williams is happy enough with it, so I expect Dave to 
merge it soon ...


Maybe as a follow up path.


Thank you,

Alejandro


> The committed CXL region length is never validated against the PIO window size.
> The legacy patch sizes wc_mem_map_size to cover the VI-strided PIO offset, but
> here we ioremap whatever the BIOS comitted and assume it's EFX_CTPIO_BUFFER_SIZE.
>
> Maybe adding
> """
> if (range_len(&cxl_pio_range) < EFX_CTPIO_BUFFER_SIZE)
>      return -EINVAL;
> """
> Would be worthy ?
>
> Let me know what you think.
>
> Best regards,
> Richard Cheng
>
>> +	if (!cxl->ctpio_cxl) {
>> +		pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
>> +			&cxl_pio_range);
>> +		return -ENOMEM;
>> +	}
>> +
>>   	probe_data->cxl = cxl;
>>   
>>   	return 0;
>>   }
>>   
>> +void efx_cxl_exit(struct efx_probe_data *probe_data)
>> +{
>> +	if (!probe_data->cxl)
>> +		return;
>> +
>> +	iounmap(probe_data->cxl->ctpio_cxl);
>> +}
>> +
>>   MODULE_IMPORT_NS("CXL");
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
>> index 04e46278464d..3e2705cb063f 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.h
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.h
>> @@ -20,10 +20,13 @@ struct efx_probe_data;
>>   struct efx_cxl {
>>   	struct cxl_dev_state cxlds;
>>   	struct cxl_memdev *cxlmd;
>> +	void __iomem *ctpio_cxl;
>>   };
>>   
>>   int efx_cxl_init(struct efx_probe_data *probe_data);
>> +void efx_cxl_exit(struct efx_probe_data *probe_data);
>>   #else
>>   static inline int efx_cxl_init(struct efx_probe_data *probe_data) { return 0; }
>> +static inline void efx_cxl_exit(struct efx_probe_data *probe_data) {}
>>   #endif
>>   #endif
>> -- 
>> 2.34.1
>>
>>

