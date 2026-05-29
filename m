Return-Path: <netdev+bounces-293000-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLqJCfMvGWq9sQgAu9opvQ
	(envelope-from <netdev+bounces-293000-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 08:19:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ECC5FDD8A
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 08:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70BF7300DA4E
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 06:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D5B3A4F26;
	Fri, 29 May 2026 06:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="eeXcfsP4"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020113.outbound.protection.outlook.com [52.101.84.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A8C3203B6;
	Fri, 29 May 2026 06:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780035555; cv=fail; b=pNsHVeX6KBNbyKFoWuMrgMPQQvtXbCGGs/0q/5BQ+KOVqLUd/fCke+ncMtj7evRmhfvWIheAFOwcvuBNKRWRRZuJ9RKCAW3BGTfCXgCzSpYBmaGQ4b6d2OJNM4aNeuqbkMFciJJgwpMlX2S6dVnATZgkMg85rEdcZQ7qQjULwoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780035555; c=relaxed/simple;
	bh=CTHi4DuCZRXIBM2puyZJflrq0sEVOEhPPjE48+rhTko=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=qQpbwRcDiV1HFxWEj2XyKG9CDivTZjhjMfKeOU2PgUsG6ndNMq7Cqafs5USgL0vfHDFad0xqRnhaOjHj/km4ykYhXkEHgjk9pP4hYeDoUyp563pndwo/eFv1w1JFjaodgZCkwZieFVHXqf4WLcmp1Nmqwi7QwumEoThnSGSvKuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=eeXcfsP4; arc=fail smtp.client-ip=52.101.84.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4cmLDAy652EPHvqSv+Kc28hbKe4y2IE3pozml6qfMnoYhfqaMzyBCcKeu5Il3gCwt+ClHqvwWwsTmCGwUZ7Wz/zP4p0eKwbcslXgkubm8d1hUWgX6/yMJs+Oqxgi6/TbVrmneEYBRiigRT+gr0kmr8PSQY7BI5Czuh30dUQ6RORkzu54dfuVTCYjF74JFCMZBKx/uFGKsZLDaWenxX4OoYd/qOD0wzrllzU8X8dp/p1l71PYT954qqy0ZUXlt+CLbmcpCKn8QGSJgCgcE348n2EKosV7QmDrimCxiovEW6UtdIbb4rpq003VCT8P49Q1pYj914ua+UQj4XCwQb65w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVoglDxQZYYOhf3tBMmYQIReAOW7LMOzMeArXqLcs34=;
 b=y/UvGSGTCzVah1jAPVsw709EFdQYIi6my5a9s+a7kHxXyht1UtXRfGnLFIjoMJig7IWdIHrfJ2GjhmQVZDEm2cjGf/ojZUm3OKncUqHkXNaXbjvkWpQSRrEEjPU/w01tE9EsyoCICGQxZcGdvdwp4Qxgx+/E83vf/6XAAf5eHxYHgmMeAMkD912XG5MulG2lbw2QOLXNPSDwrRJVME3WJyr19BHzvZvvwwWDzwu1Rt/gxz4g0lgdbq26Goh/5k2OBmz3KzflprUjk9tddajVXzxZhDz/4CV6abaWuII3olL28qvkWBiwF85PR2K/7hkAlJNphbkxob3prG+ytVp9zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVoglDxQZYYOhf3tBMmYQIReAOW7LMOzMeArXqLcs34=;
 b=eeXcfsP4eN9j8oPQ5O0zcGj9Kgq4owZVj/LDA1eA20bg123t2TFHhDKDcD1J3O/8zpgC8gwOL0PuNBdnNqmpS4nDhIXILw/t31kLDmArhK72vkR0fHkXDheOcPH6iyzTV5uo+V5s2Jc7kd+GRmd4mZ2iCA4m3Dk+G6LA5MWUN+U0EgCoOXQsrcHKaVWvdJ1KnQdhvWFml0tHzA2UNLFopLwYueGSrSq1xrmCgTUFIG5pN/VJB3P/G+QqETMmVc1FTnm7auSSRzs1uwZXCnSNyPi/d0ZRz8/CSWsbUHZYZcVSCemqbzY99FwN9vqaIKnVyOzlmeT0s44dHUA3wg6u2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by VI1PR06MB8975.eurprd06.prod.outlook.com (2603:10a6:800:1e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 06:19:07 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69%7]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 06:19:07 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Fri, 29 May 2026 06:18:57 +0000
Subject: [PATCH v3] net: fec: fix pinctrl default state restore order on
 resume
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-b4-fec-resume-pinctrl-order-v3-1-6eda0f592fca@vaisala.com>
X-B4-Tracking: v=1; b=H4sIANAvGWoC/43Nyw6CMBCF4VchXTumDAXEle9hXJQyI024pcVGQ
 3h3CyvdGJf/WXxnEZ6cJS/OySIcBevtOMTIDokwrR7uBLaJLVBiIXMsoFbAZMCRf/QEkx3M7Do
 YXUMOuCFpmLGumUUUJkdsn7t+vcVurZ9H99rPQrqt/7khhRQYucIiw1yhugRtve700Yy92OSAn
 1r5W8OoYZXJqmB1KmX2ra3r+gaTCcg4FgEAAA==
X-Change-ID: 20260526-b4-fec-resume-pinctrl-order-fde0cff2bbff
To: Wei Fang <wei.fang@nxp.com>, Frank Li <frank.li@nxp.com>, 
 Shenwei Wang <shenwei.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Nimrod Andy <B38611@freescale.com>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780035546; l=2996;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=CTHi4DuCZRXIBM2puyZJflrq0sEVOEhPPjE48+rhTko=;
 b=0kQYnVXVyw7Y4c0UcKZeLhkEAXXKame1RMKcvzdmUDN4V84U7el5PniyqmoLIlpjBm1dyFs4V
 mDoYB39gaxJCzbvv5xUNcPgExtfhL33pnIadIcMf0xTdnIzQR5Tqid5
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GV2PEPF00023A09.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::211) To AS5PR06MB9040.eurprd06.prod.outlook.com
 (2603:10a6:20b:676::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR06MB9040:EE_|VI1PR06MB8975:EE_
X-MS-Office365-Filtering-Correlation-Id: fafe62b3-f296-446a-f39f-08debd4a30b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|376014|1800799024|18002099003|38350700014|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	5LWAaclo9aBzwdKMmSw/kbA7mpms5WbdgSRPK2qmccFDeSa9nIJyvbCJ+DQ6jtFUgNOuLqRg32yfpcp/SYCEx778+aBJXscmDjZrlKjN53UPu0SHpVpBn0OLhc79RW/1BCfs/w5vOCoreIDdAjqWKwWu5B6J+3HA6X99drNZU3GazlVvAeVQc+ju1BS46xgzUuJ+x3QWgKh34HTUo3S422kFfV5sVpEUF7I4JtBznprVikOym7Ck/0NMrnJDKvQdLBI1iNWvG9qEzh3cHuXfus1HS4tAB2W0Ld9MvjcHKDtNKhlcnxa9e25jHDnniXwKihREyfvfhHyKGUJ3bD8XLcWuB/b/LM+lXrPVvZxekQj3nkRXRT5IjfkgVTmW2POrrUWlMA+tb07Aub+18zkxTOLX/7diLXc+QVkyqGqtstpvVZ+SCBXUl+u2ayDoOeL4PTXh6viGc9SeZaN9Us9g1IaAgkEBqvF5TBiCQE0aO6iKT7Z2BYqwSe4st/XVcnZ8k8mhi+0TlZASlW6PPPXMm6HTsoCrDI60u36GESs2y8m46adMCdKaQsqaOKJ1u68A84fNCTXd5bUZlyudjdxD/HmsIiMY5h6hcK7WLhvubseM+BnRCe+WHmm4enZ9VLzxgNix6jCzQclZ3+KM8XghFXGrTrpKk24o61vJmyBT+FhZPcHfqQ0epIqO1zym1iPe7t4/zmu43oOn4YFkAU0Jf2k2MPwgCK0d0jg/cWuj4Y9Cli6nOtguUsXZMFHc2+fA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(1800799024)(18002099003)(38350700014)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlNCdkhraEQ1VUtIN2tsUWdsWWlrTzlOYjNkVmFxdjk3Q05BU3ZzeXhHRU5H?=
 =?utf-8?B?aktTMXgwaGxmM3RCS1pJV2hqWDV4LytONkpZQkhmVFNPNjBzRmQ3WkZYNzRh?=
 =?utf-8?B?dWpzeDQyY0oyejJxR1NEV2NQUkUwcHpqRUZWcmNvWWxkcm1xb0VENHNlcXNt?=
 =?utf-8?B?OUYzajhFSWZZdm5kVldJT3k4U3c5blVrenJhaHlkb1ptNVB3THA2YzgyRWFM?=
 =?utf-8?B?b1dWT285VXd0Skc3RFBwa3pMZkZvdDFuSEJzdk1JNEUrYitCWGJGbUpqTEJs?=
 =?utf-8?B?S3kwQm4wTWF3KzNXd0tJbGpxdTFKNXhTMFRhU1RKYVU5bXBqdEEyZE45eWI1?=
 =?utf-8?B?b1pZWU5iS1FsNlZuRGRSdTFjQVdmUVQ5SkpoTDNkS21FRTBVVzNaUE5NalJv?=
 =?utf-8?B?SUVKVDhxRDZ3WWFXSGdxcUlrMEJ0WXY4SlRzTnluVG83Z2M5aVQ4YjhXZ3pR?=
 =?utf-8?B?NjJzeERoalVLaiszRm1GbU91SlJzakdYNzYwOHQ3MlU5c1JVenBmdkVwRllS?=
 =?utf-8?B?UTNsUm0zWUFFVGN0VWpMQ2lwMnlUL0JDZG5zSjhFVjZEY0lyaXNkTmpPWGFV?=
 =?utf-8?B?WkMzRFpTMnVyWGNmU2VQTm1sMWx4ZFlpa0hrUDh2cWdRYkJ3bWJHbWkyMHNj?=
 =?utf-8?B?UUxQN245eGpEeDF0WCtXQzM0VmdPRmg2d0dLOW5NS05SVW9TbWdZRnBHMDE1?=
 =?utf-8?B?TS9aR052NTFEaXJPalBMNkx0NkhGWVJFT2syWEtwcDlRQ29nNjNWNkNXNXBv?=
 =?utf-8?B?dUR6dWJVUEFuN0xtZTJyMCtNV0kyZzY0anV3NmFOYXA2eTdseEgxVENCVk4v?=
 =?utf-8?B?WjdIckNDQ0o5S3laQ3hHTjRuZkFoZUhBTFdTVFBjdW5WZFg3c2JCQ0t5UDFs?=
 =?utf-8?B?VFF5MzdSNVR0NWpOL1RSMEYzQnFlWUlCQWFEWVBTQi94djZpeDF5bFQ3ZnIr?=
 =?utf-8?B?T1BYVTFhNVhIK0VOTkhnV3h2aGRUenBnUVVKSzVGRFY3OERmZ0dneXhrV0RS?=
 =?utf-8?B?QXlZQU5XNzF0Sy9RQnBqM1Y5UGxOVjhUd1NCMU12dGVrUndqc1NjbXZuT0Yz?=
 =?utf-8?B?R2o3U0I1TjQ1SWZEcUdiYTU1c1JoWjZBNHBQTEJNbVV6czRQZHF1VkNja05a?=
 =?utf-8?B?VjVLV1Z4enVUamNVYThlMzA3ZWM0RlJQWHBsZmpORmdwVEhPYjJhUFpZbWdz?=
 =?utf-8?B?S2V3K211OXBSSFVEdzNDVGdKeG5kU3JTS2cyR3ZMelpiVFdzbXIyd0VCSjlC?=
 =?utf-8?B?YTBkQ3I2Yzh1MllUZTFXNTM0VkJ3eGZJVFpBYmw4cEwwL0J5SGV1Rm1yeGRD?=
 =?utf-8?B?SVRFdkQ0cG9wQU9ldnk2S1NGWkYyK09XQmEwQ0Jzajl5ajY4clJseWwrc3Iv?=
 =?utf-8?B?bnBkOWtHTG1aZi8wQitHZFp3ZDNTdFd4VjJJVkNFL1Ird0l6UWFJM3ZHRFYy?=
 =?utf-8?B?VXMxYkE3bVRFZ0RNcWtZRFVsUVdPa2hkNHBFbkkxOXNDaTdNMGdDakFSWmNm?=
 =?utf-8?B?TGFCbnlVYWlRcTQ0NlVST2tRaXZLaWZsdFBPRHNFRDhtMjhmNDBvWTNCUG55?=
 =?utf-8?B?d2xyL290aXBseFZlRm8rOTcrNTJHcHZVS0tnMnh3d1YxU0pIdDNXN092K0RP?=
 =?utf-8?B?SzlTL0FOOXlDUE5JQTVuRnVPZWNsRDBtQmp5RmNjZGh0VCtXL1VtdUdKdTFV?=
 =?utf-8?B?dU9IRzladkJsRG9QYUdMTmxOMTFOaE9TdnRXUDNYb0JpdWRCUHo0aWF4UVJj?=
 =?utf-8?B?ajNLbWJiVU9kWnhTZTJvVi9nVm1NTlBtQi9FZGJ2a3VWRW5DaXpmWFhNTTFt?=
 =?utf-8?B?VFFadGNOWTI5WC9WUDE4YWZLY3UySHhZYmNITDhXZ2hrSGRyNUFTZ3VReC9w?=
 =?utf-8?B?ZVJYTFVEZzlxT0RNT3BwTkpLUFBQQ1dkT3hvaVA4MU1WNmVvdk9ZOGR6TDl4?=
 =?utf-8?B?bjRUeHNRdFFlYktPR2tlenJaTG5nZWx6Q3NWKzFLQTBJa3Rtb0xjVGplWGt1?=
 =?utf-8?B?ZHROa1QyOGJBazFlUkw2emE4YmhnNkY1QXhTL3BsNGVEay80aGQ4TlAvM2tl?=
 =?utf-8?B?YjFzTVlWWnRJV3hSZVRpci9QZ1dNYzBWOWc0TDhSNWxGNmlzNXVKblV6c2Jl?=
 =?utf-8?B?cnoybll6dDhZcGlRNEJJZHJQMzluRk4wNVNaQyt5MDFjTmZXNG5TY3pZYmI0?=
 =?utf-8?B?YTZZNWUzR1hOMEUyQlFzazZjL3M1NTA3cWs0T3ByWjRiQ3UwMDBWdFFTa1hT?=
 =?utf-8?B?d0J2eTlIMk80eHU0aG1POE1VOUROZ0NiZWlVUXZDZlN2T0dyQzVyNFllRmwy?=
 =?utf-8?B?N3FQbWxrM1BKNlNPbEt1dStna1hvcmZmenhpUW1MclR5cGcxQVRKZktWVFNw?=
 =?utf-8?Q?TRZw4T+Uz2ZyXxPw=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fafe62b3-f296-446a-f39f-08debd4a30b5
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 06:19:07.6467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UUxXcbfMCFUR2iJWgN9Bj4bMLiprtA6x4V7b6AK9x4amle6jCLbbnKofZGFAWBiTId/lnJOX0lNxQk3J1/kbrdHqD4ZFHBw4WJj+t26zoa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB8975
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[vaisala.com,reject];
	R_DKIM_ALLOW(-0.20)[vaisala.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-293000-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tapio.reijonen@vaisala.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[vaisala.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B5ECC5FDD8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In fec_resume(), fec_enet_clk_enable() is called before
pinctrl_pm_select_default_state() in the non-WoL path, inverting the
ordering used in fec_suspend() which correctly switches to the sleep
pinctrl state before disabling clocks.

For PHYs with the PHY_RST_AFTER_CLK_EN flag (e.g. TI DP83848 or
SMSC LAN87xx), fec_enet_clk_enable() triggers a hardware reset pulse
via the phy-reset GPIO. With the GPIO pin still in sleep pinctrl state
at that point, the GPIO write has no physical effect and the PHY never
receives the required reset after clock enable, leading to unreliable
link establishment after system resume.

Fix by restoring the default pinctrl state before enabling clocks,
making resume the proper mirror of suspend. The call is made
unconditionally: fec_suspend() only switches to the sleep pinctrl state
on the non-WoL path and leaves the pins in the default state when WoL
is enabled, so on a WoL resume the device is already in the default
state and pinctrl_pm_select_default_state() is a no-op.

Fixes: de40ed31b3c5 ("net: fec: add Wake-on-LAN support")
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
Changes in v3:
- Move pinctrl_pm_select_default_state() before fec_enet_clk_enable()
  unconditionally instead of duplicating the clk-enable call in both
  WoL branches; safe because fec_suspend() leaves the pins in the
  default state on the WoL path (per Wei Fang's review).
- Link to v2: https://lore.kernel.org/r/20260527-b4-fec-resume-pinctrl-order-v2-1-293096f48703@vaisala.com

Changes in v2:
- Remove a stray blank line between the Fixes: tag and Signed-off-by:
  in the commit message; no functional change (per Wei Fang's review).
- Link to v1: https://lore.kernel.org/r/20260526-b4-fec-resume-pinctrl-order-v1-1-f2f926325424@vaisala.com
---
 drivers/net/ethernet/freescale/fec_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index f89aa94ce0202d5f28f37362ce70e0943aa14025..6ebde65d7f1b8728a6c5d28f75cc0b0c4d983969 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -5594,6 +5594,7 @@ static int fec_resume(struct device *dev)
 		if (fep->rpm_active)
 			pm_runtime_force_resume(dev);
 
+		pinctrl_pm_select_default_state(&fep->pdev->dev);
 		ret = fec_enet_clk_enable(ndev, true);
 		if (ret) {
 			rtnl_unlock();
@@ -5610,8 +5611,6 @@ static int fec_resume(struct device *dev)
 			val &= ~(FEC_ECR_MAGICEN | FEC_ECR_SLEEP);
 			writel(val, fep->hwp + FEC_ECNTRL);
 			fep->wol_flag &= ~FEC_WOL_FLAG_SLEEP_ON;
-		} else {
-			pinctrl_pm_select_default_state(&fep->pdev->dev);
 		}
 		fec_restart(ndev);
 		netif_tx_lock_bh(ndev);

---
base-commit: 79bd2dded182b1d458b18e62684b7f82ffc682e5
change-id: 20260526-b4-fec-resume-pinctrl-order-fde0cff2bbff

Best regards,
-- 
Tapio Reijonen <tapio.reijonen@vaisala.com>


