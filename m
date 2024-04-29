Return-Path: <netdev+bounces-92103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1203B8B570C
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 13:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBA82286B82
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 11:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26B94B5DA;
	Mon, 29 Apr 2024 11:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grpleg.onmicrosoft.com header.i=@grpleg.onmicrosoft.com header.b="Ab3TRkrB"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2105.outbound.protection.outlook.com [40.107.21.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB0B482C7
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 11:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714391196; cv=fail; b=mTko2haRSDGeD2VvsE0XyFJoHjP5LEZ4mpaC/0jCOw6/pOr4LdmnMmmRcq0/vRIXZO5O2cRoEXm8jOKcVsiRaZBNb3/r0mYR4Ff/9xTJPR7pQQQQ1ClG40k6VE53EuatucPIK/PGS02UheyJicwWypvJp+os3ckbIG3dd0W3yPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714391196; c=relaxed/simple;
	bh=nEOrvbNAyA2qGCX5aQxCkbyMRZE4tTS91PTS8O1yoa4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FWtsYfOEF/dA3wmouvCc3akZH9fr5mXd6s29HHP5eBjjMTKax1BqcG1oSIBVIavMo7yZ2AYXN8DCXTh6QmUcnlGDxdMI9scVh2JhrNpG8II2BCzTijvu6EgTCIat/e6LUH7P+CyupMPQ3NO/Fc0Qniv7eu9Oo3VXG6lmngU1xjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raritan.com; spf=pass smtp.mailfrom=raritan.com; dkim=pass (1024-bit key) header.d=grpleg.onmicrosoft.com header.i=@grpleg.onmicrosoft.com header.b=Ab3TRkrB; arc=fail smtp.client-ip=40.107.21.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raritan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raritan.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgZwXah3ijFKzcpMm+ZqUphtZX3q+Wr7n/+EAmFNwoIrWEGla1fCMW5DEVloR2XLYFRU/i3mG7txp0N36PRUBdKb3IrpRYIgj5b8MIaiwckdzJ7kD6c0GlI2n1+qXEF/ZcWL7uexFzE0vcUgSjF5AlRvos5D6+99Y+04THVBQeMze+uy/xvJnp5Dy2E0h8so0iFh7llLp/ODIi6Cqq80ff8YsR60tma2XAghwyo8lmks9k2VK5rNzLD0mUwVBx3CeCAo/mGw5u9N+sW49SIaijXX50x37mSxmNYishLpBr6eP4JR77T06Gb77Z2C120qbJ1mfeIhnLDEH3iY/60dbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/tPsRmMP7M0B0GO2F8at7l90qrDjALKKdZw8pDnMNA=;
 b=BovoADMwsOkThpJlMXsxNsrDVjBEKHjp8FUGj1RiA0J3wSDGLo6+2zUTUTrQhVsvUsxfv47xj6kq12GS1JeXcq1jwAVlXh3t6Fw3XY1JCczOPPLZdoVdDBUZhpzY0J5LmmxcNJYAmLJ1OwKBUZR/wv/pIsfrY6bhq2GhAo/p/8vSwdvjyf8H/rl9LQ6vcXwYq4dQVD7di9h118rvbqdPTyosMOyFwaOn4M2JnitmtFpRzxzDLkrSKbuRXVr5uxRBqU2EGJ8smqOXe0G+qFEiftQ+K3NwgZjKIC5eKJBWSsdL+QKhYc7/lrNqrqvcgrAkAaspO2skbAgxX3dmpNJEnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=raritan.com; dmarc=pass action=none header.from=raritan.com;
 dkim=pass header.d=raritan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grpleg.onmicrosoft.com; s=selector1-grpleg-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/tPsRmMP7M0B0GO2F8at7l90qrDjALKKdZw8pDnMNA=;
 b=Ab3TRkrBLezX9q6J1XAxLtEeZEX3deyJz1yEXtLLhCAU90qL/JTh+ZnPWPrgZNiQ8OvFFcqbbXsId0uG1aey6aITVBcqMZ8JpJo9eFBEIGjWwLlFOQKvngxUDxb3dD5wXPpYCd/tfiEgyZkeNgTGaa7DDEczFQz2HOzAwsn/En4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=raritan.com;
Received: from AM8PR06MB7012.eurprd06.prod.outlook.com (2603:10a6:20b:1c6::15)
 by DBAPR06MB6680.eurprd06.prod.outlook.com (2603:10a6:10:18d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Mon, 29 Apr
 2024 11:46:31 +0000
Received: from AM8PR06MB7012.eurprd06.prod.outlook.com
 ([fe80::9832:b8f4:ea0c:2d36]) by AM8PR06MB7012.eurprd06.prod.outlook.com
 ([fe80::9832:b8f4:ea0c:2d36%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 11:46:30 +0000
Message-ID: <fa332bfc-68fb-4eea-a70a-8ac9c0d3c990@raritan.com>
Date: Mon, 29 Apr 2024 13:46:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: ks8851: Handle softirqs at the end of IRQ thread
 to fix hang
To: Marek Vasut <marex@denx.de>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Mark Brown <broonie@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
References: <20240331142353.93792-1-marex@denx.de>
 <20240331142353.93792-2-marex@denx.de>
Content-Language: en-US
From: Ronald Wahl <ronald.wahl@raritan.com>
In-Reply-To: <20240331142353.93792-2-marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0317.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::10) To AM8PR06MB7012.eurprd06.prod.outlook.com
 (2603:10a6:20b:1c6::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR06MB7012:EE_|DBAPR06MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: b4b115cf-e96a-4a36-9c75-08dc68420309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWd6RkJkVGZNZTY1NEhDaTRycTUrRDBteEtaZGNINDBob0pjR0M3S2NPMnkv?=
 =?utf-8?B?NEF2NWZsQjBuMlVmeWlGZmVnaFJCVWZhb3dZODB4cFVleVA4anBqRG8rZ1lE?=
 =?utf-8?B?Z1l3UGhCSndsUVFROUEvYjJqVjFHQzBFUlBWNmJVM3NzZFhxVGNtbllhOE5Y?=
 =?utf-8?B?dWVlVFpDYmVwelJ0SWxjSmRpQjM3b3ZkbHkxM0I2L0hSS1pBVjllSXA1R2Fn?=
 =?utf-8?B?eXpVanpaTm5memZoRE1Idkh5cDgyd2pHZUxpQlQ5ZFVXYmRiTy9uZkpmRk9a?=
 =?utf-8?B?bU1hZVMxU091b1U0a3RtYVN3d2prS3ZjaC90c2VWUU43R0NkNmVnM0FTWmZp?=
 =?utf-8?B?YVoxUDBwSG5adHp3UnhoUW1jZzFLWHZUZUhYbHAwNGRxR1ZUL0FHS3pDTkZz?=
 =?utf-8?B?bUsrK05ETzJrNmhreGJKUTJIaE5YMWgyTFk1VTlvV2ttTXhYbHljczBSeTEw?=
 =?utf-8?B?dHVYMGRJWUZUN1BBRmM0QmJhbUhLTHFEMkltMHVkRzZBbzFCekNCcmNkVGda?=
 =?utf-8?B?MlMyRFBSTUhhWXR5czMrQUpzaHhnLzV4Z0o4SExpRm1jcXg2RTZOLzljamo3?=
 =?utf-8?B?V3JqemVpQk5NdE5EU0c4eFdWb1JiUmhqOS96UzcwWnlTV1RHZlExQlJ5K2RD?=
 =?utf-8?B?SXpUbEFaZ3J0aERzQktZcG9oMDlZaW4wRWdUTVhnLy9mTlcwTjUzZFU5cGd4?=
 =?utf-8?B?K21IZTNDanNsVEdNQjRGVEpEQkQvbGxpOVZWTmFyVk51dWYyQ1RSWE55dVd4?=
 =?utf-8?B?SGdjZlM5bVBEdXIvWEtBOGFTdVpPbXJPWmhsaUxHdTJYM0RXOGxWQ3d5emZz?=
 =?utf-8?B?dVUxUFIzTUMwczdHTVRKUDFXM0xhRlZqcUdGKzU1UlFyQTBMc0F0WVN5SkxL?=
 =?utf-8?B?YjJRRXltWS9RRUZwV0pPR2RtZ2hYMVZkTHJKZWtQdFY4ZHFOcW43R1ZlZkNH?=
 =?utf-8?B?cDNSelBkd0lEZnVOOTNlTDRsMERJR25kV29mdzBUSmhITzc0QzB2K29LcTlz?=
 =?utf-8?B?clZKdlZscisyandYVUdubERuOFN1djNUL3lOTzU2OVkxWlVybU9wZithWHp4?=
 =?utf-8?B?anVueVNLQ0U3SjZEODk5OFVaczFoeVBRYURESHY4aDJoRDkzZ2RNdDRmMmFM?=
 =?utf-8?B?L1J1aFQvNVNVUU1XYnpndVR1ZWROTFU0VDErTm1ZZlh0T1liZEptUW9OdCtl?=
 =?utf-8?B?OS9JWVU0aElYWUNxZm9Kc2w1YmxvemFMZXZLTHRybHRucTVsb0szZkQra2ZS?=
 =?utf-8?B?M3B1bTNpTDEzY1BIZGYxcnlEc1pUMkVkSXV2dm5PQlBDbkdWTDFqVFd2OWM0?=
 =?utf-8?B?K1pKSG9SMlg2RkRSQmFQNGJHTkxOdU1qYnVydTBUMFpQdWRITldMNG9kMWdt?=
 =?utf-8?B?Tmp4eVZRSVVmRmVkVkNHS3FpSjBiMU96L0FuWTBzTDZnWmYyamhhbTQ4bzdq?=
 =?utf-8?B?NzY3SCswQ3I0aWx6QmRBa3lzek1HRXdHRm5VU2pLeU40cXEvVWtTZkVHamdB?=
 =?utf-8?B?dmlXVmtTMVEvNVZwZEN3bWwzMG5tY2pveng5c2JaT1oyL1o5M0FmTHM0N2NW?=
 =?utf-8?B?K25ZRjMwSVVoZTlLdlhsRE9rM3U1czlXRGxmZUtVdGF3NUtEQWd3dG9Scjhj?=
 =?utf-8?B?VEN5bEYyUm5Cdy9nd3F0dEE2RDNQSHBzWDJwZ2Vic1FuTHllY3FHL1l5ak9k?=
 =?utf-8?B?bFptb2NqaWdYTkdUNGZEVFVOb2pjN1k2VGZYKy9XSEo1U08yRmk4R3B3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR06MB7012.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUtMWHAzMS9ubndHbTMrZjNIbmp5ZC9uU3NkdUtrcmp3T2tJaDlBVjhVWlk5?=
 =?utf-8?B?bDlHNHVmOEkvY21XcHVlWFpWRXNtbTR3QklTanVPM0JZTnl4dVZZYkd2Z1FP?=
 =?utf-8?B?ZTdqTWcxUUVGWVhFcDVzWW5adlBwbTlaTFJCbTA2SjVnZXpDM3F1M1BkVUN1?=
 =?utf-8?B?SE16L2REZjVOckk2NVJLaitQc0hkUEZqT0dFSkVuZGhyZ2ZmdmdSRzBzTjBL?=
 =?utf-8?B?emhZckVuMlJXZVVUNk5FQ3VMUzI3aFg2QVc1L0l3NVk0S3pXM0hoMndQWVk4?=
 =?utf-8?B?WGtTbmllcGFGbzFsdVVvSFlPdUEzcVlNcVlUZ3ZRMlZ0Tm5IQXFwaEhVdkVl?=
 =?utf-8?B?bFBVT1FqWDdFVWRJOGhLZHpQQ2xHdEdWM05JSm9nSE5sQXFhTFgwZjVjYTZV?=
 =?utf-8?B?ajFqRU9MQlc0WnFNZjZyWE9sWFJ3eTU1Rm5kNEVZUGpLUzQ2QThzbVNEV0NN?=
 =?utf-8?B?emcxa01HWmxyZlJ4R1I1MERVa0VSTWxPQ3NoWWRLTXkyMURYNkxJTEVxdDNE?=
 =?utf-8?B?TVlva1lLd1M0MWpKbXFxdU5GVWcxTkkza044Q1QrUHRobHRrSWFQQm50YmFN?=
 =?utf-8?B?dnUxdlpONEcyK1RLS2pSZnJnWUx6UUw2VW1nRjRDWXhzQ3M1bkkyUHM4aVZY?=
 =?utf-8?B?UmNEVFZpOXZIdE8yV3Nod2xHcnZNTVk1UjE4RmR3K3dVdDRLM1p4UDdiTTgz?=
 =?utf-8?B?LzlLdkVFUFBYU0I2YTFLNWV1c3BjdW1PUis4MEpkZDMzNHVmZG5TQ2s2UWhz?=
 =?utf-8?B?Sy9ORThEWkZZSTZzNDRDZkxucUZTN2tjUDFTL1JrQ1BWR2R4dU1KMnorTTdW?=
 =?utf-8?B?eSt0OWRmQUJRTlNSejVzUC9iS1dnUmszVG1iaU12WUJwZ214b3FMWUtsZldv?=
 =?utf-8?B?aXBRcm1qMnJpMlM5Q2pvMTdHeXVRZFRMb0FYL1hCTFBEVHNXczgxdTlXVHpa?=
 =?utf-8?B?MlZnbk56c2RjTTJEbFJ4aGZYQUpiaDRZTm1qdml4RW1FSlhMV3ZKRnpLOXc0?=
 =?utf-8?B?d0w0MDlTeVJmRkFTdlRPZlQzeVJJejNOWFNzNU9mZHExSStDRS82TkFjeEVK?=
 =?utf-8?B?cERFNHFNU2p5NENtdnBLVHBkNUY1V3dzWjNqRjU1cjlwWjcrQzR4YUtKV3F6?=
 =?utf-8?B?TXVndW1UdU0wT0wvc2puQTlqZmJnaTZNY05xajNiOUJ4dFpidkhLWU1iRzl5?=
 =?utf-8?B?VmlyZ0RpRTY3REUyWmtBeSthWmplMVdqbmZnandoeElvVzNEVWVjTzVrOFJn?=
 =?utf-8?B?YUZlUXgycmpzMWg5YTZrOGh3a29wYWhrUjZuWk15a3p2K2REZkNNZDFEd1VY?=
 =?utf-8?B?dHE3M2FBb2M3Uyt0ZTB0QjBJekVvTXRFN3NlNThWcHlNWkhJelA1UmdtV1g1?=
 =?utf-8?B?bmpvK0xzanFQTE91WkxDRzIvc2x0TjBPL2t1akZRTUhPMlpIeXJhMnF4V3g0?=
 =?utf-8?B?ckZvdGdJM2ZTWFd6SGttWGFqUEVIY214anJWODBCL1REclRDOVM3QWo2cVRn?=
 =?utf-8?B?UDhVWEZQUFBKY1h5K0FYNlhhZU1yMW5DakY4QVU0SUdLOUZXdlRQeGZtYmRQ?=
 =?utf-8?B?OGVNb3AzZll6TVdKNjBUeVYyNWg4U3VQUVlpSmd5czRIbVpjaHQ1YTNGMGpE?=
 =?utf-8?B?bVdVbkxVVjRHR3hvWmNtRndtemFrb3Z6YURXSnhLR1lmR1o4dXcxUUx4VUlz?=
 =?utf-8?B?V295VDFXS2RBOVkvYU8rcExIWUpud0JDRmhHTUs0ZGFWdjVhSEdWRnVEKzVN?=
 =?utf-8?B?OFd3ZjljckFodVY4OUREUjBwRXFXTFVKY2IrOWt0NnJza291cVZBODNBMEFJ?=
 =?utf-8?B?dmFDTTFVRWFRNG1zUHByelhUS1gxL0JobTNGU3RDaUlhQUFnMnBiSzVERmty?=
 =?utf-8?B?dkhQWDk3VnlPc0lwbHUvdWtPSmVSbjM1YldBQnlobXVCUzQwZC9xTEg1R3hZ?=
 =?utf-8?B?S2pQOVhtUkc0NzRHNGxWbWFKK3dZNDZzMDZtUVdQQVp0UktSRGJ3OXpOWGJ6?=
 =?utf-8?B?UW5zSXJuS1VRaDJUY3BTWXNBdExrMkJCSms0VG43VVBUMDZxb2puRkQyYStQ?=
 =?utf-8?B?em9hSFRuUjB1S2xnZ3ZaNFFhNGY0VHF6RHV1MzNTUUhTZGo5RkhxNHgzUnps?=
 =?utf-8?B?SWU2Zktid1dTanFRblJwcThqNDcvb20yY1V3YWRlL2l4NlN2eTJqTGZWeit0?=
 =?utf-8?B?U0E9PQ==?=
X-OriginatorOrg: raritan.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b115cf-e96a-4a36-9c75-08dc68420309
X-MS-Exchange-CrossTenant-AuthSource: AM8PR06MB7012.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 11:46:30.8760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 199686b5-bef4-4960-8786-7a6b1888fee3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ulNbNOAzls6uaTbIQvpZOJLN2ok6VXFPxubS5/9PWHiQfUmKQI1W7gtW1NLfyyALpM/zAP3B7F0mbuozpcVskA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR06MB6680

Hi,

for the spi version of the chip this change now leads to

[   23.793000] BUG: sleeping function called from invalid context at kernel=
/locking/mutex.c:283
[   23.801915] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 857, =
name: irq/52-eth-link
[   23.810895] preempt_count: 200, expected: 0
[   23.815288] CPU: 0 PID: 857 Comm: irq/52-eth-link Not tainted 6.6.28-sam=
a5 #1
[   23.822790] Hardware name: Atmel SAMA5
[   23.826717]  unwind_backtrace from show_stack+0xb/0xc
[   23.831992]  show_stack from dump_stack_lvl+0x19/0x1e
[   23.837433]  dump_stack_lvl from __might_resched+0xb7/0xec
[   23.843122]  __might_resched from mutex_lock+0xf/0x2c
[   23.848540]  mutex_lock from ks8851_irq+0x1f/0x164
[   23.853525]  ks8851_irq from irq_thread_fn+0xf/0x28
[   23.858776]  irq_thread_fn from irq_thread+0x93/0x130
[   23.864037]  irq_thread from kthread+0x7f/0x90
[   23.868699]  kthread from ret_from_fork+0x11/0x1c

Actually the spi driver variant does not suffer from the issue as it has
different locking so we probably should do the
local_bh_disable/local_bh_enable only for the "par" version. What do you th=
ink?

- ron

On 31.03.24 16:21, Marek Vasut wrote:
> [You don't often get email from marex@denx.de. Learn why this is importan=
t at https://aka.ms/LearnAboutSenderIdentification ]
>
> The ks8851_irq() thread may call ks8851_rx_pkts() in case there are
> any packets in the MAC FIFO, which calls netif_rx(). This netif_rx()
> implementation is guarded by local_bh_disable() and local_bh_enable().
> The local_bh_enable() may call do_softirq() to run softirqs in case
> any are pending. One of the softirqs is net_rx_action, which ultimately
> reaches the driver .start_xmit callback. If that happens, the system
> hangs. The entire call chain is below:
>
> ks8851_start_xmit_par from netdev_start_xmit
> netdev_start_xmit from dev_hard_start_xmit
> dev_hard_start_xmit from sch_direct_xmit
> sch_direct_xmit from __dev_queue_xmit
> __dev_queue_xmit from __neigh_update
> __neigh_update from neigh_update
> neigh_update from arp_process.constprop.0
> arp_process.constprop.0 from __netif_receive_skb_one_core
> __netif_receive_skb_one_core from process_backlog
> process_backlog from __napi_poll.constprop.0
> __napi_poll.constprop.0 from net_rx_action
> net_rx_action from __do_softirq
> __do_softirq from call_with_stack
> call_with_stack from do_softirq
> do_softirq from __local_bh_enable_ip
> __local_bh_enable_ip from netif_rx
> netif_rx from ks8851_irq
> ks8851_irq from irq_thread_fn
> irq_thread_fn from irq_thread
> irq_thread from kthread
> kthread from ret_from_fork
>
> The hang happens because ks8851_irq() first locks a spinlock in
> ks8851_par.c ks8851_lock_par() spin_lock_irqsave(&ksp->lock, ...)
> and with that spinlock locked, calls netif_rx(). Once the execution
> reaches ks8851_start_xmit_par(), it calls ks8851_lock_par() again
> which attempts to claim the already locked spinlock again, and the
> hang happens.
>
> Move the do_softirq() call outside of the spinlock protected section
> of ks8851_irq() by disabling BHs around the entire spinlock protected
> section of ks8851_irq() handler. Place local_bh_enable() outside of
> the spinlock protected section, so that it can trigger do_softirq()
> without the ks8851_par.c ks8851_lock_par() spinlock being held, and
> safely call ks8851_start_xmit_par() without attempting to lock the
> already locked spinlock.
>
> Since ks8851_irq() is protected by local_bh_disable()/local_bh_enable()
> now, replace netif_rx() with __netif_rx() which is not duplicating the
> local_bh_disable()/local_bh_enable() calls.
>
> Fixes: 797047f875b5 ("net: ks8851: Implement Parallel bus operations")
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig@pengutronix.de>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Ronald Wahl <ronald.wahl@raritan.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: netdev@vger.kernel.org
> ---
>   drivers/net/ethernet/micrel/ks8851_common.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/et=
hernet/micrel/ks8851_common.c
> index 896d43bb8883d..b6b727e651f3d 100644
> --- a/drivers/net/ethernet/micrel/ks8851_common.c
> +++ b/drivers/net/ethernet/micrel/ks8851_common.c
> @@ -299,7 +299,7 @@ static void ks8851_rx_pkts(struct ks8851_net *ks)
>                                          ks8851_dbg_dumpkkt(ks, rxpkt);
>
>                                  skb->protocol =3D eth_type_trans(skb, ks=
->netdev);
> -                               netif_rx(skb);
> +                               __netif_rx(skb);
>
>                                  ks->netdev->stats.rx_packets++;
>                                  ks->netdev->stats.rx_bytes +=3D rxlen;
> @@ -325,11 +325,15 @@ static void ks8851_rx_pkts(struct ks8851_net *ks)
>    */
>   static irqreturn_t ks8851_irq(int irq, void *_ks)
>   {
> +       bool need_bh_off =3D !(hardirq_count() | softirq_count());
>          struct ks8851_net *ks =3D _ks;
>          unsigned handled =3D 0;
>          unsigned long flags;
>          unsigned int status;
>
> +       if (need_bh_off)
> +               local_bh_disable();
> +
>          ks8851_lock(ks, &flags);
>
>          status =3D ks8851_rdreg16(ks, KS_ISR);
> @@ -406,6 +410,9 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
>          if (status & IRQ_LCI)
>                  mii_check_link(&ks->mii);
>
> +       if (need_bh_off)
> +               local_bh_enable();
> +
>          return IRQ_HANDLED;
>   }
>
> --
> 2.43.0
>


________________________________

Ce message, ainsi que tous les fichiers joints =C3=A0 ce message, peuvent c=
ontenir des informations sensibles et/ ou confidentielles ne devant pas =C3=
=AAtre divulgu=C3=A9es. Si vous n'=C3=AAtes pas le destinataire de ce messa=
ge (ou que vous recevez ce message par erreur), nous vous remercions de le =
notifier imm=C3=A9diatement =C3=A0 son exp=C3=A9diteur, et de d=C3=A9truire=
 ce message. Toute copie, divulgation, modification, utilisation ou diffusi=
on, non autoris=C3=A9e, directe ou indirecte, de tout ou partie de ce messa=
ge, est strictement interdite.


This e-mail, and any document attached hereby, may contain confidential and=
/or privileged information. If you are not the intended recipient (or have =
received this e-mail in error) please notify the sender immediately and des=
troy this e-mail. Any unauthorized, direct or indirect, copying, disclosure=
, distribution or other use of the material or parts thereof is strictly fo=
rbidden.

