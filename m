Return-Path: <netdev+bounces-257053-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCl5DBlchGmn2gMAu9opvQ
	(envelope-from <netdev+bounces-257053-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:00:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA2EF031F
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C38D300B123
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 08:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16777362157;
	Thu,  5 Feb 2026 08:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fBoUnEFf"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011034.outbound.protection.outlook.com [52.101.65.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7BD1E520A;
	Thu,  5 Feb 2026 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281781; cv=fail; b=WuCP0nefhsnjsFPNy7fIBJpJt99YKbU75RUFPFBAdp0zo4/NUbyGyA8hU332+zn1EIL/qO4lnId/ivXQWLc6XHZ81BUoAZ5pNhGCCHyTMYrL8uNDuI0+msP5sMoiehEHShsiSbm5Qv0eruOFbhnYFHm5ZKvXyjMxXl0BIAbqv/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281781; c=relaxed/simple;
	bh=NE0McWyKk1/yGpUVYGNjHHKi4q7ZlOXC5A9ZplGumRU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bpWFygoKIR+OQ4+6hfd8wKpiS6Vdpl+BTOLcitjgPFfqrukgYTtdVapHGfd20UR8s0kNZcYeEUcrQEsa1XpCvgMaqfCzQ8uFJYPlzbBQOwn5BESy+R7zlh1qpdN6g6UstO/WrtzdMLygzhGhrDvDUKRKuYy4UwN46OQbxRNVgIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fBoUnEFf; arc=fail smtp.client-ip=52.101.65.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/nuQSVqco1MME2EML1+TX5qTYGBfGWdYjyBpR5mjT8KWEQhqlOKZaSKxl2E/r4FivRQpSNPUOWDEyZET/vl6vzSJftZrmSVQ052mpKJHcogb8nvG7xTy475I50kKXsj5WGjJ5syLrpwaksObYs4h+szMjthWUdvMtwDkf6QfArprQdTiUTOnMTWuMsZxh4S3Oz4iSBQ4ceM+VcX4GYrJxzpV4NkpBZFb1H7Y0TJZRw8Cgvd14lSw7SZtoQI5CfBBazAzqTufPvdy9Q+ncC+1dVKHUXOrHQb3wigCwbiMf+JaCa6mz/7VIqa3+p/HGTpv0nU7p9ynZ6rjrFMmwWUPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xN5ks9DizBViJkCMc72JDLdQlqoYaARhCi3xCwzvf/c=;
 b=YtXF3684o59+uoKlx82URxQuoJG5wKWIjrZfA4z3Z348tkkCIBrekOdMsLetfw9p4Z2hG74FfrrbMIiEUmhzpEaQwBY7hdowOBDvFxnURcnfUme0dgCE0Nm6h3glZLBhWsGJfSxvVsx0071aFtqP96N48HFqFjuBHZ1DwPJ4lpQDwb9bGuMtq1PHwJ7Iq67ERZI6O9ZB2VMvvijnUurbOuEZLZKEicYcTwyF3MX7oETowmL5eqDxjSj9nN+qvvESKCNOHDY/KZxXdWQ5Lwgl4WRhZ0lNiXa1tO2W1HEq0P/Mpa5pdhaUvt1BkKu4QbxrRQNf3eKQltf4HK3l4lT6ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xN5ks9DizBViJkCMc72JDLdQlqoYaARhCi3xCwzvf/c=;
 b=fBoUnEFfgeATbWf/VEDfZmjpDATjnspunqxGrtoOV9m92ZYcvh9RhxAkPUy62bXPH0JN5F+umJ0LWFYRXaPVaN+hBmhY/XSVCFP5WKsmdu1YOEVk8rMXZWJ8wzPRg/JqJUaax2u4U+uCL5kHeWvWQsoOMLx1xvSE66X3UGBiCgRJKQpbTQlwHhdRrVllwHujeZ7ZuNrPQDROw0UEwBAqFR1XqgZy+vYuogi+0zQkhvPAuDXC2U0E31Q5gn4K8/HUZnL67D3Wdax2JMgPurFDy+/ueRImlV3eY8m68IgEP33i6PfDtz+M9IDzx3h89bbk2tyXPaq3G97hKrcXTNVjNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10604.eurprd04.prod.outlook.com (2603:10a6:102:48e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 08:56:16 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 08:56:16 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	frank.li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v7 net-next 00/15] net: fec: improve XDP copy mode and add AF_XDP zero-copy support
Date: Thu,  5 Feb 2026 16:57:27 +0800
Message-Id: <20260205085742.2685134-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:4:188::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA1PR04MB10604:EE_
X-MS-Office365-Filtering-Correlation-Id: d0ea663e-ae9b-434b-4ee6-08de64946c11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e7j+wY/5QJ2rAeR8tNxKLoAb/oqP8bijZWFLILfvSZgtnUAeB6QyUXJJMMVt?=
 =?us-ascii?Q?lgBrPXBY1AeImSXvoT0bai2wzEMPAUhIkXAh+pEk0Oc69LsWK4uHnBl1pHxn?=
 =?us-ascii?Q?BaZhPCnjWnZ8xYswqnKMWPu4HiHDdLF0b2wds6YuncGjf9IYddvAksSlf9Y8?=
 =?us-ascii?Q?Sd9jW2iqkkT4FE56BFmi7qBHUWxK5AXphjptwY8DkhUXnLkBoUy1zl9HSzfL?=
 =?us-ascii?Q?qfqGOWW14LdyqH3DiOXq7yfhBU3pqh5das5liqbPd2IXFRx8CoSmrafoh66S?=
 =?us-ascii?Q?jKeLWN3BRmiu0xtnb+sz4TZBy4uBiiQ6WWRT4HHA+vg6rR4bGkK7kOSZhOQu?=
 =?us-ascii?Q?HuxATkSFciXB1hOx/ydICjz17weKx6MMF8xh+uf1GZkFTeP3Qinjujr2s+J/?=
 =?us-ascii?Q?X0S11K96BfORYUbNV4+gOTFidAfe8opcNwUaJLGQKl1rlYSv4w5OyVgdATWi?=
 =?us-ascii?Q?Xd5/MUKS8NAp1lcgaFK6602VduPNi7YwT3F0mLWeHKCrK7Oe/53dxxkdeyFo?=
 =?us-ascii?Q?W2h4k2u42jJr9qTf3YoGgfYeXOOmGlrvYPre7CA4/7miLUfhhHM68iiCmWtm?=
 =?us-ascii?Q?cDvTaheUFxvdz5SvwTkPsx4UlNG2wm+uewVHbDTT/L8zDnD/zHUviqGk1Vec?=
 =?us-ascii?Q?OyohdqjNSoXhfm+8JS4ESi5pjL0SRH4iz2DJvIVhurFoqVsd48pVYQzfcTBD?=
 =?us-ascii?Q?bdoKZI/Z/PWXS4x+7txfcA2REsL18e6oj0qshBApaO150ZCz2wC0S2bxTFmZ?=
 =?us-ascii?Q?Mk/d8HE6RWEJ7isTNV2+jamp86ShS+0n0MEBLBuR9BkcBB9eBnszyfrmeljb?=
 =?us-ascii?Q?0BKyg/EZGfLobibpOg6dj2VtYNXZp0bqEmp6xix84LPBr8aJGjy0wP7NJbao?=
 =?us-ascii?Q?jArz768K8P+2zS97e11MTD3BfaZA8ugqmkP1Og7RuxnYuk0Ij49LFJeT5vAk?=
 =?us-ascii?Q?u8NdDSJ8bicAOEdju1TavXpvfeoGmtgYbRBw6iSj1kjmRTz68hFB2buM3//W?=
 =?us-ascii?Q?lb0mFpAmNev23vjAOcbdfLm77fRF/aPzdwsPkEcoc11Eq+Haoe1GthOt6fp9?=
 =?us-ascii?Q?6VPjRaP6lh5eRmEPuA7QYMV2wYovlHSP5GDT/tWjxOM41234hubQ3P29Ilv5?=
 =?us-ascii?Q?4oIJVFo82etDmwo7qXaGET2QTAFndQY/N7lcu/Crm1se7LkzN3u3d8v8DUxz?=
 =?us-ascii?Q?qR4csGWEUlAX4csDqc1v8oZZyghM8hP76xjpxiKkb1HBIfBbK64ULEoSiBrN?=
 =?us-ascii?Q?m5EF7po0z9XrY5nkSv0ksxlWCyYOPRX3e/2uF0sjTMxB8nllpT+VQTpnNzSJ?=
 =?us-ascii?Q?fIjafQYCI09e/VH3lxWpMmiwg2kvWxuAaOI/B1YAFB8igNjiR8zcv3bUAV/A?=
 =?us-ascii?Q?KtbXdMcbdJfPlNqvEPNwr4jtRPNc9dGPFlsdGQxr4OZShhv78D2knSmxzGo2?=
 =?us-ascii?Q?HOuESS+oGZMNR5ch89M6zhyy2AHSoZS1qSqs+Lk0b7P5ClsMeT0ox5kVNVbt?=
 =?us-ascii?Q?NAnmGg+Ugjr9XY+jB0iTOLYJRGBRacs0mhgZ6cr7IGl4rkOIjHbcqcYDHON1?=
 =?us-ascii?Q?NmSyrHLU3DbXC0/Z3kqCA20JGSOEmag6Dc2NtA9YwIRwym+ZpsyWAKuQBuZW?=
 =?us-ascii?Q?pQf3KxNEYBL/Xt9EOn8OVl80HieelFVHWuLLV4VZMr7E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B60F72gOPEM/vRkTz7Ddmzi/8hDB+SNZRNKJ6i6096hJvN70hYg/CmsVZCD4?=
 =?us-ascii?Q?/vtCu5wuqKAwRRju92hA09XTpbF6Pjzl/KiAEKOTxDMo4ZgIph/Y9mXxBKgA?=
 =?us-ascii?Q?jxriLvaebyl/bLKnSsX8RamH/lBkGVJ983lnOwwpCX4i3VnjrT9rHFPwwVLQ?=
 =?us-ascii?Q?AT7rRgQ2Kob7iCTeEyN6Cc2i7baIfJjEY/3+UY1z4+KwQspZZQ0Dz86UJ/BC?=
 =?us-ascii?Q?CtZGb7+IUPH2G6i/G7lqwH3bV8CSLwMghW9sDxdbLDJg936OoHGfu9M5qd01?=
 =?us-ascii?Q?2EbrvrElVsB8adxAbubL7twe2aoPbhjRCfRmSS931+ERSnCqAykqBUelmJA2?=
 =?us-ascii?Q?vktOhP515tTHdl5rHnZSRquB3V5XWVfcz85U9NzdfVPZ7VOrlgGeHQPo1ZrW?=
 =?us-ascii?Q?bKQXioNdOhtZylwK7romYaKS40y2a6CyOXrcH5ZpfTxGhkEx7+l5ji4cG2C5?=
 =?us-ascii?Q?iBn51UADj4wtmsNEoFdzXTpmz7guGzDxiudzMi/uWpprkuUSkPNO+9fbrsCT?=
 =?us-ascii?Q?dfZCClbkkKTUaSJwPe7G4zJLWH+1mWy0OA5nNZX5N/qLrRkYHD6zwdSQ2EeD?=
 =?us-ascii?Q?RhTHTIGtKLGxySGWcAb5FC8dEOosJl2wPkpsJhsjjq9M+zJwA+BtHKkBr1gP?=
 =?us-ascii?Q?OChFXICVrecgvALRXAFInBiwl3CPMU5Att16f5ZQ3DhIqfXt3TXmG3PXBrqr?=
 =?us-ascii?Q?/IQUssmijyAct2nhYJXh+lG9ICal3ZFZ+7UGRhf9o84wAbaV6ZNax8evtzZh?=
 =?us-ascii?Q?6Dc7e4LOvP6NDzdLMlzQKcuVxCEJ+NR8qgSpd67aNpesg2pc8752cSHYN3Zf?=
 =?us-ascii?Q?aplqcDj9kdnX6m0jBb3SNUPHie8FVw5imlKlh2JE9kmkdAviiOBgIIb/3OxY?=
 =?us-ascii?Q?o7SwBmQrfY9ss1XzWgc5EIEyoqYH5X10Xi6/xMIdPAKJRa2d8eOkxkNuePLR?=
 =?us-ascii?Q?xaP4fwmlWBzAVeL4UHrp+wq0KvoOzCOWVzI+93EG7toQqxRBX63+LJEZR60R?=
 =?us-ascii?Q?jOwwKW2wdKwwUQpfdWo2kJHKdtyWc0lb3CtwGRcO11aWpE/5pTH/N1nOPTwf?=
 =?us-ascii?Q?JJMANjh7a9TZeUY4RvMfneSRzQxcBgXdDSmOOWSoRRPx32sUU/4B5h/tFa5+?=
 =?us-ascii?Q?lX4kVuLLwjoVu5WqeIHGwoXpe1pAqqHtPDVmJlxVOyDXLLmtkykpF72m1jLG?=
 =?us-ascii?Q?J3pjRJ1J3+laFDBAygyb96ZVpTrJrXa1bQ/LcHpsJDlSkqbZuUm55gVm+c3P?=
 =?us-ascii?Q?0s8jQyKVfWv5sGCUh7BhK7xZgJ3gTj9z4IDPD6oDa6X7vrLhpBx+N3R7K1UW?=
 =?us-ascii?Q?HN4ZQXMwVA+s8RSXiSQXXxUWNoN9aTzoDPGyh3K1KOyXTIyhwc9DYWHTOGle?=
 =?us-ascii?Q?WaE58aasFQwtUbt/uePTqqfqH0gu3kn5m1Qtecw9muMJxwvPpsGFI7spNkLJ?=
 =?us-ascii?Q?tn7vbpoyysBjivp7IPheX8PnMIre7fIgPHAsp3GN4fl8lOAmr33XoSBaV/TI?=
 =?us-ascii?Q?7hX3G+O4bNTl4iMS+2xZ1N0gdoh4wJT+5aZAdVaB/jEqKPQN5F89j2ky2Uho?=
 =?us-ascii?Q?7i5EtRGW+BbksETJcSzajgVStIBI9KNT7oby8GfyApCkpCnbRtz/jDIdprfn?=
 =?us-ascii?Q?Tgd9aCuQLfn50xpWffRcffMtlryWLlAuwAxbwokWW3WyfsYDkDrUIa5+rUom?=
 =?us-ascii?Q?BHSYA7Fd84tWcnut2Q4IQjw5n9po65LNW4k9NHg7PhXcSxfG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ea663e-ae9b-434b-4ee6-08de64946c11
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 08:56:16.6224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mfqgG2w9qXBpsXJL+fNLxXCs5lZsJUydYTHKwWzxkoX0JmSBxCMJ79r+yiPOEj7npVfr0XN7upiFzZwwNDO9bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10604
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	TAGGED_FROM(0.00)[bounces-257053-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8EA2EF031F
X-Rspamd-Action: no action

This patch set optimizes the XDP copy mode logic as follows.

1. Separate the processing of RX XDP frames from fec_enet_rx_queue(),
and adds a separate function fec_enet_rx_queue_xdp() for handling XDP
frames.

2. For TX XDP packets, using the batch sending method to avoid frequent
MMIO writes.

3. Use the switch statement to check the tx_buf type instead of the
if...else... statement, making the cleanup logic of TX BD ring cleared
and more efficient.

We compared the performance of XDP copy mode before and after applying
this patch set, and the results show that the performance has improved.

Before applying this patch set.
root@imx93evk:~# ./xdp-bench tx eth0
Summary                   396,868 rx/s                  0 err,drop/s
Summary                   396,024 rx/s                  0 err,drop/s

root@imx93evk:~# ./xdp-bench drop eth0
Summary                   684,781 rx/s                  0 err/s
Summary                   675,746 rx/s                  0 err/s

root@imx93evk:~# ./xdp-bench pass eth0
Summary                   208,552 rx/s                  0 err,drop/s
Summary                   208,654 rx/s                  0 err,drop/s

root@imx93evk:~# ./xdp-bench redirect eth0 eth0
eth0->eth0                311,210 rx/s                  0 err,drop/s      311,208 xmit/s
eth0->eth0                310,808 rx/s                  0 err,drop/s      310,809 xmit/s

After applying this patch set.
root@imx93evk:~# ./xdp-bench tx eth0
Summary                   425,778 rx/s                  0 err,drop/s
Summary                   426,042 rx/s                  0 err,drop/s

root@imx93evk:~# ./xdp-bench drop eth0
Summary                   698,351 rx/s                  0 err/s
Summary                   701,882 rx/s                  0 err/s

root@imx93evk:~# ./xdp-bench pass eth0
Summary                   210,348 rx/s                  0 err,drop/s
Summary                   210,016 rx/s                  0 err,drop/s

root@imx93evk:~# ./xdp-bench redirect eth0 eth0
eth0->eth0                354,407 rx/s                  0 err,drop/s      354,401 xmit/s
eth0->eth0                350,381 rx/s                  0 err,drop/s      350,389 xmit/s

This patch set also addes the AF_XDP zero-copy support, and we tested
the performance on i.MX93 platform with xdpsock tool. The following is
the performance comparison of copy mode and zero-copy mode. It can be
seen that the performance of zero-copy mode is better than that of copy
mode.

1. MAC swap L2 forwarding
1.1 Zero-copy mode
root@imx93evk:~# ./xdpsock -i eth0 -l -z
 sock0@eth0:0 l2fwd xdp-drv
                   pps            pkts           1.00
rx                 414715         415455
tx                 414715         415455

1.2 Copy mode
root@imx93evk:~# ./xdpsock -i eth0 -l -c
 sock0@eth0:0 l2fwd xdp-drv
                   pps            pkts           1.00
rx                 356396         356609
tx                 356396         356609

2. TX only
2.1 Zero-copy mode
root@imx93evk:~# ./xdpsock -i eth0 -t -s 64 -z
 sock0@eth0:0 txonly xdp-drv
                   pps            pkts           1.00
rx                 0              0
tx                 1119573        1126720

2.2 Copy mode
root@imx93evk:~# ./xdpsock -i eth0 -t -s 64 -c
sock0@eth0:0 txonly xdp-drv
                   pps            pkts           1.00
rx                 0              0
tx                 406864         407616

---
v7:
1. In fec_enet_rx_queue_xdp(), add trace_xdp_exception() for XDP_ABORTED
and invalid XDP actions. Also add it to fec_enet_rx_queue_xsk().
2. In fec_enet_xsk_tx_xmit(), add dma_wmb() before setting status to
BD_ENET_TX_READY.
3. Correct the typo in the commit message of patch 15.
v6 link: https://lore.kernel.org/imx/20260203052329.1085444-1-wei.fang@nxp.com/
v6:
1. Remove fec_xdp_drop() from XDP_PASS branch of fec_enet_rx_queue_xdp()
v5 link: https://lore.kernel.org/imx/20260129103447.1893129-1-wei.fang@nxp.com/
v5:
1. Update the commit message of patch 6 and 13.
2. Fix the potential memory leak issue in fec_enet_alloc_rxq_buffers(),
so free the buffers on failure.
3. Only initialize bdp->cbd_bufaddr in fec_alloc_rxq_buffers_pp() because
the other fileds of bdp will be initialized in fec_enet_bd_init(). And
move the initialization of ebdp to fec_enet_bd_init().
4. Refactor fec_alloc_rxq_buffers_zc().
5. Add a check to rxq->rx_buf[index].xdp in fec_enet_rx_queue_xsk(), for
example, for the xdpsock tx only use case, the RX buffers are all NULL.
6. Refactor fec_setup_xsk_pool(), so add some new helpers like
fec_enable_xsk_pool(), fec_disable_xsk_pool(), fec_alloc_new_rxq_xsk(),
fec_alloc_new_rxq_pp() and fec_xsk_restart_napi(). This refactoring
ensures that when fec_setup_xsk_pool() fails, it can revert to the
original rxq configuration.
v4 link: https://lore.kernel.org/netdev/20260123022143.4121797-1-wei.fang@nxp.com/
v4:
1. Remove the unneeded semicolon in fec_enet_bd_init()
v3 link: https://lore.kernel.org/imx/20260121033357.3261464-1-wei.fang@nxp.com/
v3:
1. Fix build warning due to missing break for the FEC_TXBUF_T_XSK_TX
branch in fec_enet_bd_init().
2. Add new patch 7, which is separated from patch 6
3. Collect Reviewed-by tags.
v2 link: https://lore.kernel.org/imx/20260116074027.1603841-1-wei.fang@nxp.com/
v2:
1. Improve the commit message
2. Remove the unused variable dma from fec_enet_rx_queue_xsk() to fix
the build warning
3. Remove fec_txq_trigger_xmit() from fec_enet_xsk_tx_xmit()
4. Separate some new patches, patch 4, 8, 13.
5. Collect Reviewed-by tags.
vl link: https://lore.kernel.org/imx/20260113032939.3705137-1-wei.fang@nxp.com/
---

Wei Fang (15):
  net: fec: add fec_txq_trigger_xmit() helper
  net: fec: add fec_rx_error_check() to check RX errors
  net: fec: add rx_shift to indicate the extra bytes padded in front of
    RX frame
  net: fec: add fec_build_skb() to build a skb
  net: fec: improve fec_enet_rx_queue()
  net: fec: add fec_enet_rx_queue_xdp() for XDP path
  net: fec: add tx_qid parameter to fec_enet_xdp_tx_xmit()
  net: fec: transmit XDP frames in bulk
  net: fec: remove unnecessary NULL pointer check when clearing TX BD
    ring
  net: fec: use switch statement to check the type of tx_buf
  net: fec: remove the size parameter from fec_enet_create_page_pool()
  net: fec: move xdp_rxq_info* APIs out of fec_enet_create_page_pool()
  net: fec: add fec_alloc_rxq_buffers_pp() to allocate buffers from page
    pool
  net: fec: improve fec_enet_tx_queue()
  net: fec: add AF_XDP zero-copy support

 drivers/net/ethernet/freescale/fec.h      |   14 +-
 drivers/net/ethernet/freescale/fec_main.c | 1647 ++++++++++++++++-----
 2 files changed, 1258 insertions(+), 403 deletions(-)

-- 
2.34.1


