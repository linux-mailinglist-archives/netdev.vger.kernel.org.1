Return-Path: <netdev+bounces-297336-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yhfrOdeTKGrpGQMAu9opvQ
	(envelope-from <netdev+bounces-297336-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:29:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 929D6664943
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:29:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=vwZotFxc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297336-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297336-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D70E306618A
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 22:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345673FE348;
	Tue,  9 Jun 2026 22:26:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010060.outbound.protection.outlook.com [52.101.85.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3DE30C629
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 22:26:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781043988; cv=fail; b=ofyPukb2UFm9LH74sF/e/onZFQdvxuVXqeuMlV1EQSw703erxdm4Ih5qZJWa39R31LGmv0qBqKX07OgQ6BDgQK8FDvKuPdHp+ZED8b6gx2M67Brz3UV9zSwYwZjunEegAsczP3v7gdjdYEFz7JWhrStxxSyHJkgsrY9VThoewFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781043988; c=relaxed/simple;
	bh=Qfvc1IlA7PqfkiLVrD9TmOKYD/j6ZdpPE5DWF1AUxYo=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d0fuvs46SMWyKYx7heGj0wd8i6SORuINGgY2MEtG7zAjJFp8790nFnJNTm4RrzSv6QOXtWWUL7iR9ha9467LEkXFTy/V4PVm3EjfrePMEQ2ndcMHA7x6falxPplRFWa/DrD53146ObSbfMpjoHE+w5YEGhxBzTafE/zgp/vlmBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vwZotFxc; arc=fail smtp.client-ip=52.101.85.60
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IsgDpoPjXgkYoCniri99C8XidlyoSIvHlF+GzA0RfYI3oVlm4pMFn8f6m8cEuBY90dQdPnoQlHO3V+HMA93cHm1G9lrFvN8/1xq3l2SRRTB/oWm/d/B1HkkNdeIGP3zqj4vYYYRcfteNGnFkIoR6KwrW8yZofQeEHBLxc5rQPDk73L1Iq7LLZNnfUAeSSJG3/XL2YNBRsKn1pdBSwC5Nr0G1SVvfB859AoRUAq5PNEnI0cGeRVPdxzgxz50YrtgboRuI12jbhNb1Xgx7MbSjOU+PR51oi43uTg5HX7lq/hpVyNaoXx8CCv/DR/mYNztK4NTlpq0cZMIlHinQ8jCrVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUq0glklxzYHQXuzBm72B0idtOz5FHG9fLpkm8MVpCg=;
 b=exiq3tM9shaCzzyhB36MTsF11YpyI0KYnC2IRpWYIUkqjyheAATDkzBerjqwhn2nOUq+2rdb0pR6vssk0SnYhxQcCjKg3Sn+jHp5vjjFRO71XPhF7tF1ItDrjyblmBCjOZFeLWMqD/PmS+k5pV5mzon6wvey4hzvjdnmdl6l8JUBGx7SCao0czzJncPrQC5tVvApyZ6uup8X0sXkdRm82qkh+QyE4/hZ3elWTXEqfBUjuNHozSnmZAboIbW/DUdHZZ0RNe1DjrpKHf1AFvxJl4YIkc51C9cIkg70VPCAzYMNiUeBxyby86o8m0Hay/dlhyYtZyGtv8AHhfNwudP8Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUq0glklxzYHQXuzBm72B0idtOz5FHG9fLpkm8MVpCg=;
 b=vwZotFxcVHco0qMUWCNewDrUFe644PcakKcYzcWE3XUpFlsjtDglWrQGx8AF5tkZFuvl3ZG17d0YsPpOvSyfMcT/ifO2i7ZA34Nnrwgd2Lc2/9ChudyXzPdKT8bx8+/IxRVRt+7Dr4Q83TsV6zBo8KS+oTKe7RnG7BTSTin1jbo=
Received: from DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) by
 SJ5PPF1C7838BF6.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 22:26:20 +0000
Received: from DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a]) by DS4PR12MB9708.namprd12.prod.outlook.com
 ([fe80::8570:d817:2f81:c62a%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 22:26:20 +0000
Message-ID: <a8d39c9d-1803-4084-80c1-0fe8ec49e14c@amd.com>
Date: Tue, 9 Jun 2026 15:26:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/5] ionic: Get "link_down_count" ext link
 stat from firmware
From: Eric Joyner <eric.joyner@amd.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, brett.creeley@amd.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
References: <20260512224421.25236-3-eric.joyner@amd.com>
 <20260515012747.1292575-1-kuba@kernel.org>
 <f2d17ae9-ec9f-46db-b46a-a2bb680c3460@amd.com>
 <20260609142640.261b7d87@kernel.org>
 <49231399-e8ca-4f68-99ab-729444567c7c@amd.com>
Content-Language: en-US
In-Reply-To: <49231399-e8ca-4f68-99ab-729444567c7c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:610:20::31) To DS4PR12MB9708.namprd12.prod.outlook.com
 (2603:10b6:8:278::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9708:EE_|SJ5PPF1C7838BF6:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a10c28-48d1-451b-89e4-08dec6762147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399002|376014|366016|6133799003|22082099003|18002099003|11063799006|5023799004|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	OJl7l6YeuY06NzIRZc6NlI4gUHHPD2n4LeHcf9EVY7X7tppJjmtq9Eb2l4DVKEFjynL294K+HRhnU0sRio76XC6Fxs7Xzlcs/Ht5CLicqd74iDefqSXDti6QnmZo6JLkYCoiq9ZdyPeFSAnLsFZNdE+3n9GK9nuxsQ8DpeD8JLwXorXIgqkys7NsrOnDGMZ5/nhfcYO1qGkb4hWiHkzKgQayrPq65H5FV9o5kJFX5ySLcK5vujHHek6tAmh4YKcFpG6hmYDvgY2MspdvIALBPTSeXGIhLRgXe1g2T/h6H1GqW3pMK/iyfgQAyu32S3OkAxLCLlDUGUX6KgCSWv6PgkQEVxYC2gvFDA/Lr2TL6SbbVRpvEnqNEMIsJ5dUHF9+U2UiwsgwR995iY0WuheFzpbMcnkl9xurxXrxn9K2ZA6McIA2cFk2h8QcyCY3Z1QrnUVcDS0YIgm6MmTFwD4UrifFtCQtLMkwNuYaW2ar2PiSJ6YjH1irEiYn9qXvIVrniL4BLIiEuL9Y8xK2syziWLGAcP/RRfBGMTCMt6YS9nBuNciSl0JA95Jv969MgpPNMGkOnNPQ6cwADeODeEqpm70d8SPc+EQTt6zJthC5sNmupUxXK92vT330tQBFrtoxuY9JuP6iNEYLTsXMeiNBvp/tAXaYafNoY8XlbC1seylim4yKeBYV1oLl1acn6GE3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB9708.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399002)(376014)(366016)(6133799003)(22082099003)(18002099003)(11063799006)(5023799004)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUU3Wk9jUk5RNUZWMStYcUpReXNkSWE5RDRmL3ZDaERmSlVhMVl0cGF4MkRj?=
 =?utf-8?B?VlgycjNhOW9qYnppbjh6dFVnSHdDRmJYN2lqWThXWVVEd0dpYU1TNlpEZDZD?=
 =?utf-8?B?ekxobkV0RlhjVlBFWGN4WldkM3BpQmoxdjJIc3pEY3VmWi8rWHVxc0pBZGZV?=
 =?utf-8?B?dllZamM4NjRQQ3doNzdJaGhQalFVbG1kYjk5WFRPaEFGQmVtMzRoS1JRMlZE?=
 =?utf-8?B?NTByYStLTVgwckUrRERGaGVITjQ3bjNLQ0Y5bmtyemhjbGlNbjFJb2J4ZEJn?=
 =?utf-8?B?K01iZU1lQ3FFWVJ5SFl3OTJwOW9yUUJzOWNQVzZSbFc2K25SNDR1UStPVFpQ?=
 =?utf-8?B?emZHcUovWVd6V0lKbFE3RXQwWm9VM2RjVm5POW1LNlBEbnB0QlpmWGVWazRV?=
 =?utf-8?B?ZjYyYUgvRkRGRjRmSlVsakttZmszR25JdWZiMUFHS3Z3S0kwdjVUVmlISW5w?=
 =?utf-8?B?djV4MFRTZk5yZUl0aEtwTTJZOFdoY3h2NVBtWDdNSjZoTEpFYS94MDBOV045?=
 =?utf-8?B?V01rU1kvajM2NUQ5ZjRVdmx4bW42NGM1L1dDYVRjVnBPeTlGMmoyZ3ViQTdW?=
 =?utf-8?B?Zk5pb0tuT0xIZ2h3QzVSNW5Fak1XOEh1Wk90alphUFYzZVNZMnN2eGpleTk2?=
 =?utf-8?B?S3FhUU9pQlhxNUV3Nzh5YXkyc2JWMGNOZDNQUks5dDlwbzNlNkRZWmNuUjE0?=
 =?utf-8?B?MGJXYi9RWUJ6Z04yY1JPTnpyRnZJR3ZiWXN1ZDc3UWhSbzI3cS84c3VPWEw5?=
 =?utf-8?B?Q1B2SUlQeUU5SDA4ZmVMcWpObm9UYnJVZTZJdjUvNTJpaVo3ZkdQWHpOYkRN?=
 =?utf-8?B?dGZ3OHJRVzh5UXc0QkhnM0hFUkVnbnFBclpDOWoxMFRlYnZ3eHU3S3NCNVlj?=
 =?utf-8?B?Q1RIWXMrbmpVUjAyN1RKSDMyZldodWhOVnRXTXRUYW1BZkk2blhacElvR3hC?=
 =?utf-8?B?T3R3VG4xTFRTVEpDRGkzNkp6V3gxaC9FS0JjRFlmVG1LWlA1aURrclhVVDJU?=
 =?utf-8?B?NmlpNHc2Nlg1VEpMbkNkb3kwVWp6aWZ6YjVtSkFkeFFHeU9QNWxPQXhjbkZn?=
 =?utf-8?B?U2ZxNmFDcndseGFFQjh2ZHN1NXR4MUxSUmxMckJvUVNEMXhidFoyTEJza1VM?=
 =?utf-8?B?VnlEQUFaVVVzZk9NT3M0ODg2bDdBRE1yZTR6ZU4xWGtpd2k5TkdVenAzaTJn?=
 =?utf-8?B?NW4xNDF4WE8rOXV2SkVoN3N1dWRVTHcwZ1U1L0c0ZzdLTFpWZ2VRVnhIM1JM?=
 =?utf-8?B?azNJbXNuTEZmaVp4RmVWZWxIdVI5OGlVZHVxeEIveEJiRk1kNnVxdi9hNUo3?=
 =?utf-8?B?ZDRjaXp3VjRTTXArRHI2RWI1Z3ZLNFcyWnluQmpDYUtXNERaZHdzRkpMd05s?=
 =?utf-8?B?UTRvQXloY3o3S0tOZFdhVFhjNG94dWx2YnVESGthRnU4R1VYYkpyNnZmODlU?=
 =?utf-8?B?UFl1UDJDVVc2S0hxcFR6dldiZnJ0MWZzZkRLZHhQclB5V2wxdzhsNUtKTVBa?=
 =?utf-8?B?WXpnRERBd3cwb1pIZXBBUVpZWVdTRWZDSVk1RlRKeTMySFdOWjVxRGpNTjhS?=
 =?utf-8?B?dzJiQ0xTOGlZenZaQXBBRi9zZStieGRHYWhHbFcrWEFlUzVqUEVrdEp1OGVR?=
 =?utf-8?B?emZWN1YzTWUwMDFxVXhTYjFYS1lGVUpLQTZiWWJxTnJ1RlJ4SFVoNmZxMmRr?=
 =?utf-8?B?TkNOWm9aSzhzZ0RqMG5oUjk2eEt5a1QxK1dmc1pTNmxwdTY5eWtIdktSeXBX?=
 =?utf-8?B?ZCtySFN4K09vbk9DT2lQN3NEYXdNWTRnUXlkdUlYdnBmTGdlRzJPYlFrRHhF?=
 =?utf-8?B?Q0lReVB5MnJ3YWtnTmhVTzc2Nm15dFR5WXZLeDF4WjVVRTAyUjhLYlBpbHBX?=
 =?utf-8?B?UytleUZiOTRSTGdxVGY5VmRyL2Q0UzJOOThQbUFSTlNHbHYrYjZnOHpJc0hi?=
 =?utf-8?B?N1l2MU1pUXRPWll3L016WDc1NjNNcU5VaWZmMVJ0aUlsamU2NHR2ZXlheTRk?=
 =?utf-8?B?MFUxaHFnaGVXRktXNGd0TFZXalFpR2V0RDI4SnR2OU1peDgxMnIwOXVhWEhB?=
 =?utf-8?B?VE5rejBWc1N4TUhOTDhNcHBoV1F0L1R6bHkzbXc0WnRHUElubTB3MWcyR2Na?=
 =?utf-8?B?TzQ2UXBhS0oydzBsZjNzS2dXTFZCZnZsdjUyTkRMYWViNWQ2cDFua1BHUHll?=
 =?utf-8?B?Z1pxbEZ6K0JuVlFCR3RNZ3M4bDZiOHhERWxiQ3pPN2xRenBNSUpOcFhyb0l5?=
 =?utf-8?B?ZVVLR2wzVnVtSnJNQ0N2c0Fpa0hZdEd1cmh0Q1dlRlE1aGM0TUpDdE5TVjNk?=
 =?utf-8?Q?IcsYUK9ZNaCgs7V+GC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a10c28-48d1-451b-89e4-08dec6762147
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 22:26:20.0998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qbaLuFcj4M7n4oGY2K9BQBuFfl7lCL8/SyBTyaY7M0roj2Un6jyvzATumDVbN4Fl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1C7838BF6
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297336-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eric.joyner@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:mid,amd.com:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 929D6664943

On 6/9/2026 3:18 PM, Eric Joyner wrote:
> On 6/9/2026 2:26 PM, Jakub Kicinski wrote:
>>> Is this a big enough issue to deal with? Is link really going to go down
>>> sixty-five thousand times while the driver is loaded? I guess we could have a
>>> running tally, but that seems like more effort than this is worth.
>>
>> Seems unlikely indeed, but drivers routinely deal with such wrapping.
>> It's like 5 lines of code, no?
>>
>>         u16 val = le16_to_cpu(...
>>
>>         if ((u16)stats->link_down_events > val)
>>                stats->link_down_events += BIT(16);
>>         stats->link_down_events &= 0xffff0000;
>>         stats->link_down_events |= val;
>>
>>
>> This is also not great, operationally. Monitoring systems may expect
>> counters to start from 0 after boot (IIUC you're saying that unless
>> the card goes thru a full reset we'll keep the value from previous
>> boot).
>>
> 
> Yep, that is what I've observed. I now wonder if the previous solution of having
> the driver calculate this statistic may have been an attempt to bypass these
> concerns.
> 
> Maybe I should go back to the original version, and have the firmware stat just
> be an extra entry in "ethtool -S" for additional info?
> 
> - Eric

Or, less lazily, I could actually also read the firmware value on driver load
and after a reset, and then have the driver use that as an offset when reporting
the count. And then also add the wrapping handling, too, so that we're not stuck
with just the 16-bit value.

The downside of having an offset in the driver though is that it won't count the
link down events that happen while the driver is not loaded, which could still
be useful information. So maybe I'd still want the raw firmware value being
reported somewhere.

- Eric

