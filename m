Return-Path: <netdev+bounces-271583-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oyT/Bsfyw2mSvAQAu9opvQ
	(envelope-from <netdev+bounces-271583-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:35:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0CA326D8C
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 15:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 003EB3012C71
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 14:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9223CFF77;
	Wed, 25 Mar 2026 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JqCCjsKE"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011023.outbound.protection.outlook.com [52.101.62.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E2C3DEFE4;
	Wed, 25 Mar 2026 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774448788; cv=fail; b=jXntlTNCS2kzX21Jg1/VuQutKlbhjESiU8iaJaPKY8hGYmcCoDTxTINrkIGrjmiq5aBMfrSP/hEJRBYJEQleP1swh5uFLDc4NN4x0avEvfiZAdOcmAHyvBWfP8xljKfLg/qhqlQx5YsSO7gYCFWRFQq8rqwsle/lro4bj7ApK30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774448788; c=relaxed/simple;
	bh=Jyl5eUFjP0dTwzaGEzB7KZ9zQQAUKP1LSZ9CTxXZroA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A+p5uBK5gCR4zmxdGIJ1EgsYLaR8ZCY0iqJ8P92be0CjY5DYbGT+IGaFGFRX1QWpAgv8DudOYjIGyoJv9VvPSChRp9OmYQgVlx2gy/XGCV6q0nbf5+CR8P8Ib1Y9MJvUvCtDZ2lotfsFhQyYx9gmkC7DVauDIzyFHSsn05konr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JqCCjsKE; arc=fail smtp.client-ip=52.101.62.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITeIlhKT/DAHvOUN2HgMLfMuV0AJNR0K7hiZ0kH39O9rpkX99duo7rOfiO1BxwyeKK7XcEp/j6nPdEfsMXbVHgmLNOm1YL0ANQN5Tde2Ijo78WDZ3R1eVnusdS44kJP5NFLKUf/o8b/5yf8jqepnGMSptcxZIw6SBq9OfrcpFRWBVnhaqbzgTjFwqckvfbT4FzaIuFOFV2yfMhU2y6emCk6LSeehSeSm3+C+sM5DiK/iK8o+0wQ9oCp6sbH93KGG3+J2HHsEU48vNIa1/dPn7m0COErqLmhQcfewAKEaaJ5y6j5mDF30dwzwmAzMhZpdKADtNy7E4rMx5OUx+M81FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXmqqqaNn1hJW/lsrj8KsrDWEitfqDZ5TZ+LrnhmhAU=;
 b=oOhJ3Z6Heygda1+qbzyJ16KlHgJrwp2hxMNJ7AfqXq4qJvNlI3vqB0Y1gNq2XE/NJXC792QpR2kQYieJK4DmngaAE/RyhnXif+KeGzDlbDT1qh/JP/xDlczuHbuRqxZfhCCZGBEVPkdXb/wevCaNm9KdRJLeCq+qchg7LeOtTgulknnzF/a3ckvnEk0I6WCrfavId4fpsN9MI1MlOnVXU4lgyV417dqpaSMUtiEARKP0OgQ9ImV+/dIJdZGa3D4yj4gnkQ/QPdkP+gPteMAUonQeigWHR+CgbJp6BNrfP97qnbdLUCQZ2gNz04oluINpjwTwVS7cmo6H0VyNITmQog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXmqqqaNn1hJW/lsrj8KsrDWEitfqDZ5TZ+LrnhmhAU=;
 b=JqCCjsKEmMakQ+YnfPXAcy5eD/Lt7REND45C//KUfLwikjbGqXT/up3NHMNxIdOY93SXjqD8T+NwJQUzFJsLTdrOo4C9C97hA7/vQYCGos3IMkRY1lC3PdHUp5MDLSRDLtXBM5UV41Ok9M0fvXUrsuDCopg0F3+iQKIu3uBeIJiZxf1gLc41ZJ2bTfmV4AwXq3uWRWlvJSp9tYfZ8QSJDkaeaTIUyQUUsBRfhfW5rqvZZvuhcX7n4LxfELVf/zlOeYzRNSv9UlN6DM4f0sqPv80l/cYKjgJ/YqpmKweScrhVwh5X9mneJextVX3h5UjkBZ8BFAya4je6DtdP9OvU8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by MN2PR12MB4285.namprd12.prod.outlook.com (2603:10b6:208:1d7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 14:26:22 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.20.9769.004; Wed, 25 Mar 2026
 14:26:21 +0000
Message-ID: <188ef2a5-cd3d-4fde-943a-17d805d79ac1@nvidia.com>
Date: Wed, 25 Mar 2026 14:26:16 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/3] dt-bindings: net: Fix Tegra234 MGBE PTP clock
To: Krzysztof Kozlowski <krzk@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20260325135811.148480-1-jonathanh@nvidia.com>
 <20260325135811.148480-3-jonathanh@nvidia.com>
 <ded77d4e-7ec3-4f3c-863c-2c0ef490e494@kernel.org>
 <5a0d431e-785c-4aef-8282-2a921865bb9e@kernel.org>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <5a0d431e-785c-4aef-8282-2a921865bb9e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0456.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::36) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|MN2PR12MB4285:EE_
X-MS-Office365-Filtering-Correlation-Id: 961b91a2-2c94-41fe-41e9-08de8a7a7cc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sG+mlWnms3JScOJL4TO37L/oW0KqGe2Ttfp68rljTg4N2lGM5BU72ZQkzGZM/hKHfN+agcIdP2jhS5sB8ltH+QTharng3ahjwvz2FVvTKNUL6Kg19dXw6tc9KWEPeuK0ohXRceosq5M5e1OYkWeeTA/U69c0+Z/vHPIG6Lt/Hzrg+LnOtAKMKAJIz2euWnqmAhefw2w9sHkzjkzZAwpz8UkpBTmZb9OEbFlwWVhxKTI+ufrj1x9ESIsQlP2NCXkMF1t+VPwmnUdgc1nZDZgiiZ+2bC/MfqUAqbCkUvxuhgyeLFlosEfeiuY1XsMvawW15QlEKVaLEondNYMSV+RXa999WDfM5DYxxpDMP3Xd1LApA9x96x6YMM4fqzWlagP+BQwFg2jhkMy3Lw5SB2rgnB2+H5iwm8H2pWAgAtiIKuvVIHb2jxTkSiySO8/8ikvLfXl2kp9WSm4vTc8Tu4jpQzb4GzVG7DHk3R1UYUU2UYHSgkXrG5hLaoHSUyg0o6ZAH7RitymgZJWsJGaQuZ2h4Tkae6XGdhJTKnjhIjCGq7fENj7x5Y1GwNeV/evFJfmr3feB87CZW0JKFb8li0BFMmUUdcF/kSUtjF38Fcl4fH8DlFjddPpxwJaTsf1lKxJYHEwtgtMgFpirovMSGD+a/kCc+uMwE1zOaRUUJqRQ9FWwaQqT0GvAOZsDJUzYwlOfrodL9+hdswvqui9M/ksmmVoJOoU/7cy9lgoO3JpbZlzT9tjmmzdK8S4ive5rWqqwnAsTGEXnYZhQAGkd2WfuMg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVppMUd1T2Q0R2pJUCt6UXRnY2NqYlZnUktVVGtLT0JhS3BqM0xrektWQmRR?=
 =?utf-8?B?N04vWHRRNXZlOGhjcEZvSVFueU04TGtCcE52c0hyZm9NYmg2M28xVmtRSmUz?=
 =?utf-8?B?SVY2OWI4dHNRL2JQUU9mREc2eDJWaTI4WTl2NHNueCtKNTF4MHovWGZ5VzZv?=
 =?utf-8?B?MFpQK3owTGRWNkNFODY4MWVGUk9abS9mZ3VleXJoVmNva3dxNmc4MU95OEhL?=
 =?utf-8?B?eG5BZ3ZmbnR1anJYSFYxSjBZSTlzSWFTeXllRlZCdzd2dnQ5ZlNnNGppZkhk?=
 =?utf-8?B?M0dDOHFRUHZUd0lxbTlQanJwTWpING1DMFVXOTd6M2RDdlVQempXRld4Q3or?=
 =?utf-8?B?NWN6S2d1WUxaL2FLMkV1UVNKeTJ4R2drUXhHeEgycmpkY1VQaGFEOGVVYU4y?=
 =?utf-8?B?VlE4bE9YZ1V3bEpXcjZkQVpwakxkbEFTb1hFTmFhS1dYOHJybXM3WEdYWThR?=
 =?utf-8?B?RlJXU0lKbkw0Mld0dkZoMEU1MHBuM1dYZlVFK01CYUVUS2RTM0lHZmVydnU4?=
 =?utf-8?B?azN4YmRPZjl6NmxZOEtsaEhQS2p0U3JlOXNaQmJpQll1MzFqclpUeXQrZlJi?=
 =?utf-8?B?cHgyUlMwaVVqUWJUbFJtZE5OUUJYajN2LytSb3ByaWhqT05VbzJiV0JaeFVR?=
 =?utf-8?B?Q0hsZWZQMGxNTU0zMFM0NnUwcmlEMkZRYUxIcFA5d0dXU1E3dXlING1KdDk3?=
 =?utf-8?B?ZmFzcTlUc093QUFidXd1bElDMDlWdEw5OWRxRnJ1UjJhVnRRbUlQQXg5bXp6?=
 =?utf-8?B?RFZuRmFrK2RIY2Z4TWUvN3Fkemx4MEdsdFZURXZkNzlveXpjSjNKTmkweVhJ?=
 =?utf-8?B?Q2FITU1Zc282V2hEYkVmZU05RzhiZFRoZkNRTExuNlVhUVNBSlVSNVFQczRv?=
 =?utf-8?B?aWo5SFpRRjI0T2cyZHN0dVFCd3RWNk16djBNcVNveU9WbkN6bEN1cTNQcEZ5?=
 =?utf-8?B?eTFtcDVOK0FKOE5BdWxESENWQTlLYzA3SnVpMTZodnhPUG9RM3BVdnBCbG9h?=
 =?utf-8?B?NTlERUVoMEkxRjk2NGxaTWxZblhlM0Q2NjVMT3RyQzdMMzFYK0oxTDhxaEFv?=
 =?utf-8?B?OXJhMWZhaVpZSHVHek1kNTM3RjMydjdzNkJhUlFMM0NDM3FCMVdheDFWUUZ5?=
 =?utf-8?B?SUFzMHZNeDZNTUpGUGl1U0ZLNS9iYzMwMG8yU1Brd1pIMWVGbGNSV3pUNDlj?=
 =?utf-8?B?VHRCSjZtRGtnajZZa0Q2NDhMdUdwTGJReE5YMTJRLzBxaE9MZktubExtczNy?=
 =?utf-8?B?dzZhVGZuYXhWbTluU0wvYXpDdldpOW14NUJEV1pWemJSbTV3WXd0NHN6VWJn?=
 =?utf-8?B?YWJJNXkvVUUxaXphc1Z2VGVjeUM4N0VNejNrU0lGa2xNbktaT0p0dFNPUXdU?=
 =?utf-8?B?VklVTm8xbUY0L3lzMFgyOGNrRjA5QU1Pck11TE1BK3hqUmRiMlpWang3bVdy?=
 =?utf-8?B?bmpFQnp2ak1oUUdlSzJiY24xZldLRVprUGZPajk1di81Vkk4cTlaV1diNnFr?=
 =?utf-8?B?VkZxVk03cnZHWnE1WHVqWkVYU3c1YUxpbjMyWE5GOHlra3d6NGE2cEVET3pq?=
 =?utf-8?B?OFVTQ1lwQTBOYm1nck9PNnppSmlvQkhMbzJGSFM4UHlXVnpHQjdubVNXQTdJ?=
 =?utf-8?B?WU9EWU81OFVNM2t1K0VGanVaUmN6TlU0YUFqOS9ScTREcnN5bHJ1N2xXZUxr?=
 =?utf-8?B?cC9TNEgrbFhtZ28yUjg1M2ZHMlJuSEY1Zy9HUDVicllJR280NDZpdk1lcmw4?=
 =?utf-8?B?ZmlCVHRNSWxkWC95N2lWTFQ5ZHZBcTlJdGxVQ0xWaFlsL1FFK0VITmVVVS9Z?=
 =?utf-8?B?T1dBdkRLd3ZaUlA3cDVENjhGQ2lLSEF4SmtaZTN0T2dkT1RHaDNuUnhmWlFw?=
 =?utf-8?B?RXZWaU15dHVRWFhzek5GcC8wZURYQ1RGejk3L2QxV2IxenNNZUp3Mk15akJ4?=
 =?utf-8?B?TTE2dGdpUDlIeDFuU2hXci9EYVNIM24wdDZteStvTzJpd3N4cDJldUl3OVU2?=
 =?utf-8?B?RkU4ZUsxSXk2aSttQnpGTHhLL0o3NFQwSlh3SUM1NHdTNTdyRmorSG9PNTUx?=
 =?utf-8?B?L29ZZkZEQm1ncGM5UkRic0ZNbmF2ekUzMFJjTUJ0WnhNOUlJMzhoSVpoUXhK?=
 =?utf-8?B?V2p3bUxtZ2lMQU1ETW45N25BV0ZqU05WYTkvYmtlWWl3T3FDWDJWb2VqckJs?=
 =?utf-8?B?OVRsUDhieHFaLzc5ZzJFMU45NmdrdHpJNERySThpY0lVUEQxWmZnZ0E1Vmdr?=
 =?utf-8?B?Ui94eGtoc1NwaTByWDhaVlJqVU15S24yVWtRUUxtd1hrT3J3Q0ZzOEw5UlVo?=
 =?utf-8?B?RjRrazI2ZFpiYStkNXA1bGJ3Z0lHeTRRaGc0Q3dCOGIrMXdFYmkxL2JNZ3dP?=
 =?utf-8?Q?eH09fPbIZUYN3YiDQiWNSS4jGJv1GBZNN2EX2Bqkh9mZM?=
X-MS-Exchange-AntiSpam-MessageData-1: CwsHXRltt8Cz6w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 961b91a2-2c94-41fe-41e9-08de8a7a7cc0
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 14:26:21.7787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRUlZjUxpT9ZqcCB6YJMmjXUnAu192sjtldY3hqyVyeSImdM7hIdqDepGl4pupW7MYjzYO2Q6dPoihxC5kzUng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4285
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271583-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F0CA326D8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 25/03/2026 14:09, Krzysztof Kozlowski wrote:
> On 25/03/2026 15:07, Krzysztof Kozlowski wrote:
>> On 25/03/2026 14:58, Jon Hunter wrote:
>>> The PTP clock for the Tegra234 MGBE device is incorrectly named
>>> 'ptp-ref' and should be 'ptp_ref'. This is causing the following
>>> warning to be observed on Tegra234 platforms that use this device:
> 
>                             ^^^^^^^^^^^^^ Tegra234 (see further)
>>>
>>>   ERR KERN tegra-mgbe 6800000.ethernet eth0: Invalid PTP clock rate
>>>   WARNING KERN tegra-mgbe 6800000.ethernet eth0: PTP init failed
>>>
>>> Although this constitutes an ABI breakage in the binding for this
>>> device, PTP support has clearly never worked and so fix this now
>>> so we can correct the device-tree for this device. Note that the
>>
>> I don't understand that explanation.
>>
>> Driver dwmac-tegra.c: ptp-ref
>> Binding: ptp-ref
>> DTS: ptp-ref
>>
>> but you say that nothing was working correctly?
>>
>> Judging by these three - driver+binding+dts - obvious fix is no fix
>> because everything was fine, so please clarify the exact problem.
> 
> Correction - I missed in grep - there are ptp_ref users: tegra186 and
> tegra194, but how tegra234 could not work if it has correctly in DTS
> ptp-ref?

The problem lies in 
drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c which uses the 
name 'ptp_ref' which does not match 'ptp-ref'. This is where the warning 
is coming from. So basic ethernet does work, but stmmac_platform.c 
driver is complaining that the PTP clock is not found.

Yes Tegra186 and Tegra194 are not impacted by this, only Tegra234.

Jon

-- 
nvpublic


