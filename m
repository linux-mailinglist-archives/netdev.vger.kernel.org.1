Return-Path: <netdev+bounces-299092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WFDvJyHnLWrWmQQAu9opvQ
	(envelope-from <netdev+bounces-299092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 01:26:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 21264680090
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 01:26:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=bMEJzMcp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299092-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299092-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 690BF300460F
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 23:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B0639099C;
	Sat, 13 Jun 2026 23:26:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A61E2E7631;
	Sat, 13 Jun 2026 23:26:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781393182; cv=fail; b=pz7E6mWzUl9fho7fhCHt5ILhM1r0z41X1z/YSuw7hBgie/rUZR7ZLUeM8915LHBRGBT/HUE/e6s1ccvx4my2TgAYKiVA4BdWbEnRMyjCj7g86HIdc6SgsXwOk68XnWAMdCRl98Roq64WOi7mjA5edjh2itXxIsMOBHGpW77IT3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781393182; c=relaxed/simple;
	bh=vgb8fmqh7rbt9v0AMK68ddofqRroOgHVwyOAaVp9jqI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EyJggpAecaqMMqK+ftUmEJT/ykI2xAIjAUufUvvqrBl2qxRvHWJF5HvYxeaFE55syXxPkjgEuOKr5kXRnI49rnH0iPLFVtH1wdKVXA39Zkx47JcppXAO7tvIN5Z26QfYtMNQe5PTCiSMslH4JJE8ZHS92v1KPJuyFsZ2sx+b1Uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bMEJzMcp; arc=fail smtp.client-ip=52.101.46.70
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9E8BjaQgctQG7X+E/VBGjZPFnjWNL5bZvDSediQHgoHRKfRi9/Fx/jY1TkNjUNNcvd2UzqY2QzJ7xkzjWQtfOj/W2z/Pxhzr1lULXDLIWtfNiKXKMwZyb+TSMfbkNxrybO2IfaXit89aRY2027P66FFVxm1NQLqstOMj7pwG3p5zVZiHZmydlu1uoOfELJwI6qIWpPgwgzcZi+8zqmiOJj7ehA6lBWpSI761N2XvjdMI6myG1dTmZhWLch5DsU0fVTDA2DtdufsDCzOltd5TKirowDljDgfViW02pz4toIgvu+eCeRuHB85AH7e2ILG7bgVkrM0gxFqSmFov/n2pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efyoj/Zpn+/cj7HqhiiYnYnbzj0qPlzE3y3oIXOpF4w=;
 b=KuOMya/xq5a7VzrWtMEthakEWNkcc+9mNLb24UKkyGW9FaSyvDT8Kvxe62kRZR94TqgudTV8HoZfJwMgcqiVHZAu6iQMdUgiiytjYjjb5qO8acK8TbVq295yMJCTdgua4RPy01nlPd/V8aaQVqcewnO6tJcIVDf8c2pH5qD5+zRLOOSZ9CprUFFfRBj2KRZ+kMIvbjsQSGy6GbE0ENTQ/u0DwkS626kCUG2/doLCyFH2KrVBiVA+KzmCKI60oSh4fda5MsH8QXZBPVRlgE5zJVDoQ52Mzgqe+lfEuM1iV5O1DeSLSTL1MzhvaAbHz+tZduHkidBoO18SdyYlFFJmLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efyoj/Zpn+/cj7HqhiiYnYnbzj0qPlzE3y3oIXOpF4w=;
 b=bMEJzMcpoR2JkHjbyCb/ibPaS0Ti+WhXkW7nmkl6eyL0i+hXmxyPBRJktJYz1mXh49FVukuAp/QuiWCJ65rX7ZRJbkXCoGcUAMMKXh3Vaotn9GzxwmPOo6JKURtCVmsBPKfc7b7Me9KviBsfqDVKcRgy9+XqiB1cLrTjkWie7nY=
Received: from MN2PR12MB3485.namprd12.prod.outlook.com (2603:10b6:208:c9::22)
 by CY8PR12MB7242.namprd12.prod.outlook.com (2603:10b6:930:59::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Sat, 13 Jun
 2026 23:26:17 +0000
Received: from MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9]) by MN2PR12MB3485.namprd12.prod.outlook.com
 ([fe80::7ac:5acc:f8b7:65c9%5]) with mapi id 15.21.0092.017; Sat, 13 Jun 2026
 23:26:16 +0000
Message-ID: <a26f2446-71b9-4066-b533-3d2ed565e3b4@amd.com>
Date: Sat, 13 Jun 2026 16:26:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] pds_core: add host backed memory support for
 firmware
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-kernel@vger.kernel.org, Eric Joyner <eric.joyner@amd.com>,
 Vamsi Atluri <Vamsi.Atluri@amd.com>
References: <20260608223256.12357-1-nikhil.rao@amd.com>
 <20260608223256.12357-6-nikhil.rao@amd.com>
 <9166857f-880d-4324-9300-9cb1da600aed@redhat.com>
Content-Language: en-US
From: "Rao, Nikhil" <nikhirao@amd.com>
In-Reply-To: <9166857f-880d-4324-9300-9cb1da600aed@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0214.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::9) To MN2PR12MB3485.namprd12.prod.outlook.com
 (2603:10b6:208:c9::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3485:EE_|CY8PR12MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: c416a76f-066d-483a-3502-08dec9a32a49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	cYUdVSbHyhzxyhV7hq8D/iorew1eAm1wKAS4mO0kgM0FcMJYOSFZ9fUdGVLZL6NxOFxqBjBrDzlcwtkB673G6gD+H6mBGhviv3jRjXezd5Tad+tth1SnLdtGsytt8X+/pZ2BHdpwg8ydVUnf9jPSmztwXoMIEPJHdfEEaWCRgroF+sftwBe21kU13H2TkjWyTVY0b2wJp5OqNFIWlw6FOGqRwjRLfS3mAdn4i/B4elfmCVKIr33eqC12WcITcSAgXE5z3wYLbSF5uWfIvIfnmy+JpDjZCdD3M1UT154fD9gJ2BdABDfSTu8M8jogWJ9K7//k73Huxl0nwD6ap+dq/CJe1fV1aGi21iMxdLBfLJ35AEsoy7zsAmOdZf/pZASeRvE3mHFYQhjhmhYKm55DoZ4uoXSDzYPcNGjB2c6x7T5XlnfX2rYOMruxDpzFon/eaZ/z/8Pg/K785BUxe6q+GgvJnJE27JVzAx/MMWqfOksthFN5TbzfRKMQiO8veW7tx/gddEBdGTSiQEau4Gl1wD4Y5Dt9Gr3LBdXQ2d9qYS6GADjs0MWsko8e/NdIzb2Psk4Ir41SAc/JzCaNKQTjgI0Wdw6iFJu7E81B+K0j08Rd3CYmNChd4jJGgV+nSnKvTvxGAjFZyHetVNaAZLga1DuWkb1g0Yin9WHX4EWuqyx/TPJQNr2/3ytzqtwECc/S
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3485.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjRYL0ExclE4aFBTZjZhNXU5d3lEcWFMaG02THczcU1SR0FXMUNrOHl2RTNJ?=
 =?utf-8?B?TlZkbWNJTU1ZdGpQN2xUUzRjeWhoVk1JNTdkWVhrZDRBeTBEckcvMzY1aE5t?=
 =?utf-8?B?VDd0ZW1WeWFyZ0c2emw0ZHpEV3ZUQWJDd2Y3RE1vSDZHc0tJQTJVS2lyZHVj?=
 =?utf-8?B?VCtIUXdUa3JseHhOK2xsUFVsN0dCY3BRNXVoSmV1c2tOUHpEN3g0Sm9tYXpo?=
 =?utf-8?B?QXlzb2FtZDNscVVhTkZLSG9XZjFlYmhTNkRIREc4ZUdoazR5RDdSRG9Fczdr?=
 =?utf-8?B?NXVuQzhFa1U1dGhiaWpPTi8wY2xLd21QV29jVDJJbXRZTVUvOXlBQktDb1dG?=
 =?utf-8?B?djJ1WHIrNWlvdERLZHpZdE0yZXFzbys0RzREb0ZLeHR6NHZ2MWZhN054UmN2?=
 =?utf-8?B?UWNTMEMxWlJtaHZGcDVzWUxldFJxNDE3UWNZbjlqdkt6UTVXdFF0K1V0MDdr?=
 =?utf-8?B?QWZQRm5oMU82Vm1BTTdRMnFuZEZDVU5EcW5YcEo2aE42dXUrQzRVRnV6RG9V?=
 =?utf-8?B?UEZob0JJUkNJbmpEYXBEQnhqUUVOQVBkY2RzVnBjMFZrTm9LcVpCditGMVow?=
 =?utf-8?B?bnFzYTNOQm00NjdYMmRLVlpvdGdqUDJHM21tSGM5T1dWQlJOd25ydFEyQzNt?=
 =?utf-8?B?eUZ0S0RvOU95Ym00MTlTWVhyakgzVzgvNzU0VlMyM0lmUjg3NHo1aFR6SEx1?=
 =?utf-8?B?M1JYU1FBYm5XZkl5eHhtYW43R0ZzZmRCNDVFWVNYMzU2T3kxVmZpRnlUYWFD?=
 =?utf-8?B?bWFlajBTM3RIUXp5OHUwL3E1a2lQaHN6UUZEMXp6eDRCeTZpMjJwc3NMb0Qr?=
 =?utf-8?B?NW9jdEkvdFdneEh2SVJ1eEFtdElad2M5MWo5bkszOGhEY0lOT1hrODk0VGxC?=
 =?utf-8?B?dWQ2NnY2YWgwK1JXWHlicW5QZUExbmlMQS9pMHF5b0ZPdDd2K08yYmdUZTlU?=
 =?utf-8?B?UlFQelNSV2IxOVlPRTM3dEcxbUQ1SVQxWGVFR0tMdkdWbnVMcExWeEs4VjdF?=
 =?utf-8?B?eWlrVk8yOUJwMFprTUttdHVjb0sxcE1TeFRJT3JjR0ZSc0pFNWoreGJQQ3Q0?=
 =?utf-8?B?cnpUWmplQi9wRldCdDZVRW1NRmhqQnR1L3BiSS84T0x2WU84amQ2QXJuN1ox?=
 =?utf-8?B?bWJqbXBrYjJDZldWdTJKcVdVOEhQKzBzWmw5R3J2Vnk4Q0VFdmdieGwya1Vq?=
 =?utf-8?B?bWJRS0JiNlBMejJHL0lnUThmRFJQRFhRamc1c3pXWnQ1cXNFYWpMUmFBQWFR?=
 =?utf-8?B?L0VVbU03NGd0eExtNzFmUjV4LzRBWkVrRDArcEpMQVc1UTdieDZ4WVQwaCto?=
 =?utf-8?B?R25veUlQUlYrSjlBeWQzbDk5eG9iVVh3Sm9aNjQvalVaMnVGSnhiWGp3aWVO?=
 =?utf-8?B?WXhRK2ZwT29lVTdnb1NzaHFJWHA1SVovejc0T2djbTB5VHJOQU11cHpJK0lE?=
 =?utf-8?B?WmlTRUZ3WTBpNEF5MUo4a05SOVdjaVJDSTJGWXJUYkZEL2Fwd25aYTZsYWha?=
 =?utf-8?B?eWNDYUdFaVR4eWVsWWZXTkZSaEtnSnIwSkhoQlRwNGJEOGk1ZWJiYzRBMEox?=
 =?utf-8?B?d29KTFJoVkw1RFBzaDRrVkFWTlBlUnBLaGVxZEQ0TzNQR0J1ckVrNWJ6NlZy?=
 =?utf-8?B?eDBJZ1N3Vk1DVzVWRE9aYUQzVUpYOFQzL0JyeEpaTnRBRDdYWHlncGhOUUti?=
 =?utf-8?B?UUhHOHpTcm5KdnFweW52SGhqdDhac3Rtb2VWdmpCbFU5V01EQ3JZWmJML0pw?=
 =?utf-8?B?Tmx6VnNUc3RUa3hhaVl3Vk5mZDg4ZkRzR3M4MFZvUTkvNmxwSUhQVzhhNC9l?=
 =?utf-8?B?L0xROTBkNzBDUFVJRk9lelR0L0o2eUExWmtwOEl0c3dCRXRNU0JBTHBTbWhM?=
 =?utf-8?B?M1o4My9veXorckp5RUpTWUU4aU1WbTBzUTVSTHptbTZYZTdTVkpJcURTU3dW?=
 =?utf-8?B?NFNrK0hjSmRlSkhOYjMxbWJNZ21SWGNjZnVHM1U1UUlSUDlSNUVmQ3FzUjZM?=
 =?utf-8?B?YVloaG93NklHNlEyZGExMFUvU2VHUVlmaGpYQTRzVmV1Z045ZjJVMDh4WDZx?=
 =?utf-8?B?OUZUMHhyNDdUZ2hiSTJxOFJteGo4SFFiK3F3OW5RZXptbmVWdzkxanZ3YlJH?=
 =?utf-8?B?bjJUSW9YYS81d25KcnNpSVAva1RKRVVqS2cyUU9EQmRyYnB4Y1hpaFBCVHBK?=
 =?utf-8?B?Q3dzdWsraWxSQmN4WDlzUTUwTWx2V3dmbkRnNWZQREtLcHhnMXU0UXZWK2dC?=
 =?utf-8?B?eURuR2FLWWNDMHlHOU10Z0xYbk0vYzB3WXB5ZEZrWEpkbVBab3JRQnh1ZWkx?=
 =?utf-8?B?VXU1NDBwMmQyRVJEeDlSdnRhK1FGdnZsWi9tZkpuY0ZNU1p5QXhmQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c416a76f-066d-483a-3502-08dec9a32a49
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3485.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2026 23:26:16.5367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZ35jHB32wjCAgBXBOV3TmF4AihL1YW9q10LlzG9u9LoRh3fsTETL9E00ipn+w5R+aCJ2Vba3SUYOmqZLBsjbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7242
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299092-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[nikhirao@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:eric.joyner@amd.com,m:Vamsi.Atluri@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amd.com:dkim,amd.com:mid,amd.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21264680090


>> +void pdsc_host_mem_add(struct pdsc *pdsc)
>> +{
[..]
>> +
>> +     for (i = 0; i < count; i++) {
>> +             err = pdsc_host_mem_add_one(pdsc, i);
>> +             if (err)
>> +                     break;
> 
> When pdsc_host_mem_add_one() returns an error, pdsc->host_mem_reqs[i].pg
> will be zero. 

In pdsc_host_mem_add_one(),  If the MEM_ADD devcmd fails, pg is still 
valid (allocated and DMA-mapped). The counter (pdsc->num_host_mem_reqs) 
is incremented after both alloc_pages() and dma_map_page() succeed, with 
a comment explaining why: 


   /* Track this allocation so pdsc_host_mem_free() can clean it up */ 
 
 
 

   pdsc->num_host_mem_reqs++;


 > Errors are not propagate to the caller...

Partial allocation is acceptable; firmware works with whatever memory it 
gets. The initialized entries are tracked by num_host_mem_reqs and 
cleaned up correctly on shutdown. 
 


Will address - remove redundant memset, change to dev_warn. 
 


Thanks for the review,
Nikhil

