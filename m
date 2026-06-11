Return-Path: <netdev+bounces-298249-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7HIXM+ntKmpIzgMAu9opvQ
	(envelope-from <netdev+bounces-298249-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:18:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F436673EA3
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:18:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=UMyUd8IM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298249-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298249-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 182BE30CB597
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759C6383313;
	Thu, 11 Jun 2026 17:15:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA072357CE6
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 17:15:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198126; cv=fail; b=Yv84pluQO2b+OL3tp1qak0Dkmyrj/4/DPmZuCreISrkI3j2pmrm1q64iCeftdWSQGK3BB5Vmbnwx/gfp3lfpwaqF9wsjKfPg26LmbQKM4qwr9IBvBGYXbc6V41a0f82fSKz94wgkngwadi+Ahsk+11opCFR1oFggtl9m6h3oyDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198126; c=relaxed/simple;
	bh=scjWrhDf/itzOmMohaEuYHUga5Hw47uDOTSH6CHTWmE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l4SgSVQL6Kaz03EI9HKnKkVou8BfZgPZiqdDh3dVKcvOFZyCbtc8MPed5jwpxJvvKKvNqO1QH81Nk+tosSbw/vcfMk6veTw1bJW9bVibyEtx8uFhaTxp9ekIQvUmhSmwUo0nbCFjkWVEhWwgabJyp5Ok49p5AN1/0bNX7G2Oc0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UMyUd8IM; arc=fail smtp.client-ip=40.107.208.15
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTmBQsYN0wZ3FFmyR0DuIzh5RNyomd9KWLp2eIdsHebPkbCeA4d2uE+p+umMu46lG7hIM2fTSgW6CKfhZRjhfBw8VZEXFF3Q8g/hvtrI8jng3VxcOjZA/wCBueVjBtVkPWQoDJ41va92h1m5fHeLxoCdSf/1V0hkM9/aO4DpXfHs1dHxbxmJ8123462ROY1sjyw/nhXiYxTSI9MtaD7t6JMnd2XpKgpMdnlPwnZH6CEXR1X3RSuK0MjouThmotLQpLnmm+rGCbJceJ45aXTCm3EE0zXZ4uRuAeimtRJkI/58/P1hxFTBFKGcwwGO8tBDUluIGePEV6JCqus12JDipg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KxIweuhHz1jq2UVyQ0UPMYmkDVzGC3P8tl4htIOrZY=;
 b=ZNmdTzcS1FypINl8ZyfJj1xbzMxpEmBUzpLzjrMqEGgvyRpicrVbz5E407uX/au16T1CWTeqy9bWpzdZpscV355bmyinHxEWluD6LeVah7lnr+M2aHFiwDHlR3h9b3gjFxvu4FayXzSivGsrJVu/sTcNvhrXLSaIkbGAtSHXqNHW/e1nUZtxA+CT0WhWDQhdFn4St0XTEzkgush5TQ2fglYzIOKr0PIvUHp+vCPpdsNlQkBv2gDflx2OICTucs76aj3ZwG3k/L5Xw3e3eECctrzJ4yhb9QExvxV7NdoP4QlbChTlMq+ZCu4hDqEx4Bism0aTG5dQl3UtlSGHNcuaJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KxIweuhHz1jq2UVyQ0UPMYmkDVzGC3P8tl4htIOrZY=;
 b=UMyUd8IMbK4pVtJwLuIny/pragkVMnZcc0VfmnLZmZYouQLRwVSQGkb7kYxAsZKXZrTLHQKCEHkFHXL6L4z5uKQ7aDj4l2iV3CLvTYNbZt7DFmnpTU14hI3xm60yHBujjcnRQE7hOpAtO6DGj+eGR2BoJdb7tv64MrVwEIRcWQc=
Received: from MN2PR12MB3485.namprd12.prod.outlook.com (2603:10b6:208:c9::22)
 by IA1PR12MB7496.namprd12.prod.outlook.com (2603:10b6:208:418::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 17:15:18 +0000
Received: from MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9]) by MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9%5]) with mapi id 15.21.0092.011; Thu, 11 Jun 2026
 17:15:18 +0000
Message-ID: <9e0a17e1-006d-473a-adff-ab76bf91d0ab@amd.com>
Date: Thu, 11 Jun 2026 10:15:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/6] pds_core: Add PLDM firmware update and
 host backed memory support
To: Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Cc: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Joyner <eric.joyner@amd.com>
References: <20260608223256.12357-1-nikhil.rao@amd.com>
 <75c74b95-097a-47c9-9a55-a4150394abf8@amd.com>
 <41d3815e-f060-4003-9974-42530addc641@intel.com>
Content-Language: en-US
From: "Rao, Nikhil" <nikhirao@amd.com>
In-Reply-To: <41d3815e-f060-4003-9974-42530addc641@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::27) To MN2PR12MB3485.namprd12.prod.outlook.com
 (2603:10b6:208:c9::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3485:EE_|IA1PR12MB7496:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f9b1c77-e404-4b9f-8de6-08dec7dd02e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	Ee2zaVQq4jIDhghzEmpaAnEsjz5yZKle47xppIPQBQVvtsYfwgjf379fcHdx6WKi7SUvHPd5Og5nesBUkKGcaTks8Fw/OBftPTtKIUivx2uOi/wcknWrMFYBWOiIhBctyqIF94AJ+ejCDWtFf5yHb2luoLWaF1vrwnyZLPyNsxpZyvMhGdjRMbBwxPtkUbo6dht5rJPKDgoZ75lNXJH4Fasx2uLHpZBrA8xVK586f8Q0c2FApTgoExLM8gfLekNohojVQUpadCQ5jv99123F1/DMY7BlcFIXcN/QHsd0BifKdzmogc5GkQvVNjhVCd/sSTSHgYNqgnpDQxNjqgw6IhY411f6bxdwSFk0vaTg8HI9JNsvPg49nsqJRxl9iZ+iyCmoTSzUTiNJKUxMrf386mimYLHDahWGqVzLM5V+iU9uTvOwB2s7rMr4umJbsTvNzOde6SrC6lhe9f9lKwyx+N2E6a7flSPog2MWqe4fDyQ2XBQM2+7zi9lgAL9aEeBdVnC32Sx9owXnjBskLA+3XViUgwKefXQpLOwvIuzAIemxnmeYzAwfnXHNoSuZjoBOjzDYV3beRmY+SzBmI49+UT09I0B1qIU9h5oBRSTt6BP3684KyNCFjDeAuN+q+j1zXqqi1alvP8qAv2v1CpJhHuQqNru4UMAIv7TeXPK6ahmNTqo+mIWdYP1ZsA66tr2M
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3485.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZCtKYndPaXJRV1BLbXFOVXVUMWk2UCtaTGJJemVLdGhORWU2OHk4L3hkSEZt?=
 =?utf-8?B?ZWFXOCtzdmIwOXhyVmY2ZVZiYzlnTlJHb2VEekpldytYSUhad2tKV1A2TS9t?=
 =?utf-8?B?b3BYMnJwOERueTlQV1NiS2E3UEFhajVET3FwWG9Qa0dVbkozdHJCUmlRejlH?=
 =?utf-8?B?MkplUXFNaTAxUXh3a2g1MDFvdko0cUN2NHY5K1l4aCtyelIvTm9Ec1c1a3d0?=
 =?utf-8?B?N1NCeEZXNmlZTkF6QVlUWUJqZm1QVUwwb2YwUXJXNEY0UjRTRTRpaTVDRkdY?=
 =?utf-8?B?VU9qZ3VMRlVWUTk5c3pWbGFQenBZQVVyVXR5M2ZCNGkvb0h4YW02eXRNVlE1?=
 =?utf-8?B?TWh5QUw5ZTUyZllsZytzbjlCbVdSYW9VQTRCekEvTnJoc1ZEK0doL1ZTMDZH?=
 =?utf-8?B?L25HaFNLZkRIallib21EUllVZHljaWZ5dTh2SlhaZnVkQ2FURDJTOHhpNkpl?=
 =?utf-8?B?N25tYTFVUXJSNHcrNnVFRGlqMjQxQjdUZVlGdklvQ3ZQcXlieU0yaC9Fa2cr?=
 =?utf-8?B?SWNYS2wwdm1SWEcvNEVHeno0cWZmQi9rSmhWWDRENGpyQzRrQWZ6UjRaaUNQ?=
 =?utf-8?B?ODhqaGowalNBanI2OTgwYXNPOUM2RUJMQXlsemd6VmZRa1VJa09STlJoNnc4?=
 =?utf-8?B?ZkkwaVBkY1JkSUJ0UmovTUNDSE9LcGwxdGxtZkxGWnB3cmZvNEZJM2tiZEFP?=
 =?utf-8?B?L1gzekJBVXFBZm53VitCN1RueVJPaThsSGk0aHlGK2VId0ttdm9mblRFcEhk?=
 =?utf-8?B?WjBHODgzREV1WkVvbTRVR1F2R2NhMUJnTThWSHl5NVdFTmFoRnIxYVNHTTRw?=
 =?utf-8?B?TkFLZDVZdXBURWdJaS8wNEJSaWVtQ3c0ZEZDR0trWHBOTzlkazF4Z0JndnhH?=
 =?utf-8?B?UDVHZERVaXh6dnovaXdPWDBQVUw2WW8rVTZtQXRCTjJ2Smh6VUxsVnpTV3M4?=
 =?utf-8?B?MUZJOVNFb0JZQUEwbEpCSVFrcitmVDZ0K1hyQXlTQUJMNjBXdjRsTmJtTXFB?=
 =?utf-8?B?ZlBUMnA4TkhISkJvVVJPNUlDMmxwRUpTZ1M1SjJVUnRnNVpoUW0vMER4UUlB?=
 =?utf-8?B?K3ZPeFRKZkV5RUFEU1dmK3JEWVp4bFJmRHZpVjhvT3VNWkQ0YmFwUmZ2TFFF?=
 =?utf-8?B?dXBlUlZUVEl2V1Q5NExzSVJCWHJvcjVCK0ZTd2RyTG12QjJqV3ZOR0l3SytY?=
 =?utf-8?B?VVZ0amRCTHQ1elhVNzY5eFk1NjZEakYvUEE2ZGV3WWd1eHN0ZXRPRXJxVVRr?=
 =?utf-8?B?NFpFMXdVU3VuNGpGSlhWdEtxUE15SGk1K1daa0o5TFNUWk90Wk1sSGxSS1RP?=
 =?utf-8?B?Ri9IYWcyUTczK3RGL1ZNaEJlZmFKb0xiblAzMEVGOTJlZmN2Ympqb0hDVjcz?=
 =?utf-8?B?ekhGWjJ3WFEzRlJDdm11bldmV0pwdFBiQ1BQdW5LVUxMZGpXcUkyYW42cVQz?=
 =?utf-8?B?UDZxcllPVmhOelJ3c3V3WWtyMFB1Nk13Y205cVRCN2ZTVGZnclNnWWxrZlls?=
 =?utf-8?B?ZXBNSVU5WFhaOE5qcUxDN2tIOWhQRnVBZUFrbFAxSHRkYndSVDJqTjZJMElU?=
 =?utf-8?B?RWZCdzZTZTFtbi94QTJ3Uk9iUTNTYWxCK2phU1p2WGhvdnhra1B3ZTAxSVI2?=
 =?utf-8?B?SUpkbTViN2F2L3M2WGI0T2txN2JCZHRyd3RtcU9MbE1DYm0wUDc2UW9OSktX?=
 =?utf-8?B?OGw0dWQxUm1DTEhCRi9qTHQ0T3ZlQkdwNnNvMStPV3A5V09mVXMwa0szWVlD?=
 =?utf-8?B?MjBXOWNSSng0a0JtK2kwZk9rUVowT24ra0cyL0x2a0dneEQ4UXVrOUdZRVM1?=
 =?utf-8?B?L1UxbmNycU1JVTBTV090Z3NMTUVSZUNMUm5nRGNUbFN1REFwU3Y3WVVIYk1H?=
 =?utf-8?B?OFRDVnlQdktFNGQ4cUdsUnRIVzd1Tmt0elpoVUtXMGUyc0k5SVphVXJHMW1E?=
 =?utf-8?B?amV5MlBEQmR2OUx3OEpXYmJxdXF3dlUrVy81L2hIdEVtbVl5MUZFVHU0KzVV?=
 =?utf-8?B?TWJ6MHBBQWpBYXVscWtpS01DZkc5a25Tc3Irblk3UDdsVW5Yb2FrZEZGQUVY?=
 =?utf-8?B?dVNUN1NxcE93Sjg3aU5pM01CYkhVQWRmOVN0bytpWmlVWFZVYWcrVVpSM0ZS?=
 =?utf-8?B?QVUyUkkyS3N5UlM2RzBFazY3dHlzdGF3d0dTYklndnRrbWkrTlhlNU9WWk5p?=
 =?utf-8?B?a1V5eU82MmFJZms5Ym9hbTM0akljOHpnbEkvTno4OGEvUkcxYXhNVHlJTUwv?=
 =?utf-8?B?ZGNaekFiM29zaytwZUdwNDVZZkZhcjFJTHpOTDZSM2k4WGRLd2VuQVQwWU4v?=
 =?utf-8?B?bzBTZnJ1RUl3cEh1UStqNWp1MUQ0aW5zRlNVekxrU0FTc2E5OTVGdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9b1c77-e404-4b9f-8de6-08dec7dd02e9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3485.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 17:15:18.6887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OD5pwqnoQD8f+jFLdLJEpIkhX5I/a+3K17py8XKgIoLk4Qt5vyYpu7m72/zuhVtvIarFHEILCowWyYEb+em6PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7496
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298249-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[nikhirao@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jacob.e.keller@intel.com,m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:eric.joyner@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhirao@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amd.com:dkim,amd.com:mid,amd.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F436673EA3



On 6/11/2026 8:56 AM, Jacob Keller wrote:
> On 6/10/2026 6:14 PM, Rao, Nikhil wrote:
>>> extack never propagated through PLDM update path
>>
>> Valid observation. The PLDM update path returns errno but doesn't
>> populate extack with detailed messages. Usability improvement, not a
>> functional bug.
>>
> 
> If this requires updates to the pldmfw core, I'm happy to review and
> accept improvements there.

Thanks, but this is a driver issue the PLDM callbacks don't call 
NL_SET_ERR_MSG_MOD(). I will send a follow-up.

>>> Vendor-specific component names
>>
>> Compliant with devlink-info.rst. Driver-specific component names are
>> allowed when documented. These are documented in
>> Documentation/networking/devlink/pds_core.rst.
>>
> 
> The preference is to use generic names when possible/feasible. I think
> at least some of your name choices could align with the generic ones.
> 
> Could you explain why fw.mainfw was selected and fw.mgmt was deemed not
> suitable?

This component handles both control and data path, so fw.mgmt didn't 
feel right since devlink-info.rst explicitly excludes data path from 
that definition. We went with fw.mainfw to indicate it's the primary 
firmware component

Nikhil

