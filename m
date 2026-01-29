Return-Path: <netdev+bounces-254731-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uF6bETE5e2mGCQIAu9opvQ
	(envelope-from <netdev+bounces-254731-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:40:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4BEAEF30
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C512302259C
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F26838A29F;
	Thu, 29 Jan 2026 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FSO0XChf"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013034.outbound.protection.outlook.com [40.107.162.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1A3389DFC;
	Thu, 29 Jan 2026 10:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682968; cv=fail; b=k3UzjFb3pgMpjTxm44ssEF6JHXpOrBiyaK4iqRu2zazWczkpeuhWk1ax7da375MMU0NkZmQL6CK3jYD2H3oXs14CwccaDrWPsbyrPDZNgGQDaSIpTr4aNmvq3PsdUvcRGMZBV3ym8tzadT+mHEDyhQWQmvVeFJdbofl2cD9G4tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682968; c=relaxed/simple;
	bh=kolhAWkC4R13s0ZOjomYnpdBkDwtt0xBw4oxqtTiCGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rw2pbGrSmldwmiHs8aWyIRfwDNWvwz1H0MaPRKAGj7O5OeKZIkRm63FLDvJFPx8U39BJJcU0GpiH6WNrGDCZGp6VB8k1eLxFeNPtS9mTRzNLVaXyv6AhJKvwFp0mW2+uUWnbW/V0/kFYjCwBB3xEecP/H1LIB87E0IP+GILkmek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FSO0XChf; arc=fail smtp.client-ip=40.107.162.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNJt4KI3XW4MuGz8y3KyQxQf65dDe4DoZ9K4L6cS5hpBGb+SoypnUx4RHaMF90dIEdu4409/zvCAz+vrbsIGZmNoLx1jxZSSlRa5dUQBsxpD+61h1HyXc19eoExgxGjCEfqAyKM3WUc0q+PPTi/g4ViJZXAZWgxIyjJkq/dotQaLfqYRU2NuroMy3gtvhdwppDbIb6LSqyxwlQT9FAMtc5euNRl7Ddu2cYtnCY9x8xJSaPPp+UiEnCD9tysbIop+Xk45Py6tXV7CjfPthWScbefaTL42eqZJgWJN2WTNXF84FLZ5FqrGIOAl2gLMAUURZO2fl//WGt90MJKerLiqNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSq3r/zlZaiQcFmKX5hH0BjTGszV94lIymvAqXk+j8w=;
 b=pDxj4cJWXp/pmrBZHQtdc8ny77Vs8Zyj5woezKlXBdawz2xAguPYWuO4yFnj71FSK5LdyMuEcUzJJMHjoJOLPHXtnOIGY7ZDuluaoQu6W+ua5Tvs+O/a6/D3qp5lQS9h2hI1Q3RrfB9mCUe/dxLBWs0FkMQKKUE/IHyde6hOKGeyAQ8x1NTYKHa8wa1AQmPpYlklkHclPQCCgcY9QAXKr1mcTuG35bm5aHyfvOwpsHxPtgJgT1Evh3oRXJk32rRO/tWRyea8K+trj8iRCp3bOtfCpphlHeeIjFtlt5UknMJrBQFmnBt7D0YhHRUjTIubsNn+mNOZIW32s8//d6H9Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSq3r/zlZaiQcFmKX5hH0BjTGszV94lIymvAqXk+j8w=;
 b=FSO0XChfj7+ykUh+0UHyz5A8pMuCZl9L28zoXqP2VcZ2hsVZVybgN9NKuaT6PlG+SzApolOrWMZrr9kI4G11PVrVbNhLjclTqMkLTg0dtFrP54zqppwpUVYY43jvCuJ+UNASNMy7MwR5sVJfpjX/8sygQmD9su29o5yWgZpv0mVHtsa9vPGdqLo8GnI4pMWtYM8yDgcei36SHMrDs9+TjuhB2RcwYAa4Gn74dLFWKL8oCHmgHEH16sVrDKwuqZwoj9Qlsve5QdOXx8d1paJ2EMvoclZISmeFTPzMFpZzYlw8k8ZblQFPTlD0ZzKUEZJ9YbY+Lplmsd6kdPDn36JBAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10843.eurprd04.prod.outlook.com (2603:10a6:102:480::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 10:36:02 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 10:36:02 +0000
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
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH v5 net-next 12/15] net: fec: move xdp_rxq_info* APIs out of fec_enet_create_page_pool()
Date: Thu, 29 Jan 2026 18:34:44 +0800
Message-Id: <20260129103447.1893129-13-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260129103447.1893129-1-wei.fang@nxp.com>
References: <20260129103447.1893129-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:3:17::17) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA1PR04MB10843:EE_
X-MS-Office365-Filtering-Correlation-Id: 40fdd9ab-c42a-4f71-8f34-08de5f223301
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CVVmjZY4NmyFNTv1DlvkuMQWYcAorX8iACeWP87eY1U7B/MawPOfdV4+rsnP?=
 =?us-ascii?Q?EdqO5/3gz82WhPYq1l0bFw3gB1fM+KsMjMkIcNo3yzfyqK2B3jjUPD0RCBhq?=
 =?us-ascii?Q?gtmxC1DpQ2VQsnAW3K7ew8OqOi85kAc5EPi4gpOWeXD/yLrEqZ/y+umMyU9M?=
 =?us-ascii?Q?nZ78rgZ7WXiCZabYsXYBEzIdwsB85TY4G/MC+XxGQ3PWwRdu/xpeXcWZieh5?=
 =?us-ascii?Q?Jk2LyLSvUYu9BL+zgx5Hx6vHaJtNI+pnpxMgQFwlLHEpNG+Gw3SYZh/lCvvh?=
 =?us-ascii?Q?ivvzEaBy2WmRRmH7eA+Dt/K2TxTj/jOjcU4DnynzzEuH783FwOpltrd0+Wk6?=
 =?us-ascii?Q?SF2uDhnZM0Si006iCi4KCHRHl96iJiobrNpr8uiOlyV3S8gLKT0k8DKZu71X?=
 =?us-ascii?Q?6PRGrqw2cbZbnJgW7H/natG2L9SBYbHbXHz1VvmSoggKfH2exb1WVTVQ2FOO?=
 =?us-ascii?Q?oTHXIpu/minvQmw5+T9sNbmedpXlRNz5cAwfi0rWuKPWs3dbEJaJ+v0nCr8F?=
 =?us-ascii?Q?ebE7bFuJkDEbW+YblQ5Rz9ceaD8bIQFsBscIInd5CSbpJLzLXUEHX8UF3Noc?=
 =?us-ascii?Q?UL1NPrtE+nM/OHBR5Dzy7IgMiNr+bKYl3oVdNO+PerESbsbGO41zzNHCNj/G?=
 =?us-ascii?Q?gKJAAUYEyCBh7AboEOzocxrSLBKZurhIvTPxQEkMpmDjHcXQDmdz/JWnWjR7?=
 =?us-ascii?Q?bu3Buu/3/wiN9UzA/7Ec42U+D9rDU9H5kbi61vpxS3vR9SOCSqfu8+YDGEgc?=
 =?us-ascii?Q?dDNBVT+hQIydsb/fBZ2iw9kL9ONQUOxgKOCCpksBbYSHrrbWyiO3KnomIuk2?=
 =?us-ascii?Q?AazWahZJ4W2K4eC5wCre0HWKc5+N4fYP4boaUyAUIlwWao2Z9SplBb4Q8H/t?=
 =?us-ascii?Q?oTgjTMCouBv62IXumfpEqLkeIeQ02RW7/5uBv60vAGXM+o25h+JmMk9Y8ezB?=
 =?us-ascii?Q?RoPCtnv2k5CvN3dYOXp6RX4fhjJdIzXcoGVjAZnCrzIVusPcqS6t4NAJqWYY?=
 =?us-ascii?Q?AC1y4Re2O8wL6hxIPI87IoAKVklLbobZFYbuIFOYnDjXQiHHzdFB7S8gjZe1?=
 =?us-ascii?Q?4Crv8xSE3VSh3W2lUdhYdWSNlnbKICZWgAww6ghQlsmA5jpMzGIqkez2cBxO?=
 =?us-ascii?Q?yjMwFICjlFgY7ScQ75CO8kTZ55sleEhR1OXz2dx1esqauHOb59UaDTnDeZTU?=
 =?us-ascii?Q?w9oXJps3mUHIXG48e+FFTYVdA028UNFqkSrwo5UEYD0OOcW7LsWOMYGtwKKH?=
 =?us-ascii?Q?9zlEkHYaNDaNVCEasJxIWTb9OUTKdHQLqIvK0iAfYCorsK4zBSumOaD2ynxS?=
 =?us-ascii?Q?iIaAJzOnobdCzmYnOC2b7pESWfPmolu76UEWNoxFDvNpKm+R79ynMa/hfdyi?=
 =?us-ascii?Q?y5pgGCQSKQt2Rbx08NioRM2HnCizd3W7gg6RtJwu4nWo6fcex4A/WeIEvufI?=
 =?us-ascii?Q?wo+hJNXI8R2FVG6fecMBzG+EydylwKfOHaCy2P22LKnASzTjqHvkmkdS4ese?=
 =?us-ascii?Q?gkecC5rhOo1haXPKSs4ZusR4MFfXCPYLXvLRZeh4HPetJZXwDUtHHNXOMBe7?=
 =?us-ascii?Q?h9cKBZ4mjnOqmMEzT5ixcB7oOfKecG/UbZfWkf8SKsRbz8nb7IpJPgFvLt8Y?=
 =?us-ascii?Q?W81PCHIQPdXgcImk9PA19C2AHBx05j5IJ7+5q1pL03x1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v9TZJPzSM0xQ3WvjX1AOMhHFsPzlaijRhobEN1zsPTAWRtP6BCaSeLRZqNfM?=
 =?us-ascii?Q?w8Luy40Y9adhJ4mPKlbf/GRVMiLXBOeUk6qD585S7LucSO2g3N9J8omUJ+l6?=
 =?us-ascii?Q?yJ/mghsS0A+Yz8rOxWmUKe0XU9tzETF6XA5qFmANi0Yi8xFiC1xUwn8p8rW5?=
 =?us-ascii?Q?g4UHFGpGEYQpF5Cr7M0G6MgWB3//51wpxj+nh+2qBJRGjiPurQiETP3CiIxB?=
 =?us-ascii?Q?uNmlRp4jUYVAzm/kSZ/GUPOs+QyFhsgA4cu5QVYiQadNfso7BK2h+Fhy202X?=
 =?us-ascii?Q?nqQFDN0xPB5o9Kv1MrEzkdfClnYtfu3fP/is31KwM539ajix4t1WfEw5oe+m?=
 =?us-ascii?Q?S88abG1hLJE5y+awIkp3uypTMtq5204ItyUBsPXuPLV7rN471ihH9ES3wvr7?=
 =?us-ascii?Q?TfUQhaQ6h7fUmE+wrWwddTjpf1zaVUVbYsZ6LH/g1uE2ZDg2cQbQtXyyVckD?=
 =?us-ascii?Q?E1BDmV2o3geeMs9qytblysl/FoM4kNaXB/g89L2saWb0YS/c/9I5b3gNt2Cr?=
 =?us-ascii?Q?W44qtphzxEEn2fJ/pRGr5/xzF/UhFg4IbT5fSkRyKqs7w3oQqMbpPk4ge+DA?=
 =?us-ascii?Q?JGKyJ5NtVeaxYcMr+q0eRxA7ka+YrL8UAsbJbvh6j4GN0DxVRHzuecUYoLSU?=
 =?us-ascii?Q?6c1Wg8ZkmnvKQDxF2Xjk71r0UtnKAgOEdXzNJGER9TSZvPntesoY6vLLSSYe?=
 =?us-ascii?Q?hEhKKvKABzFQ+C8HSxfqWgRhnHyGL2lO6KQr9xBCP12Q+E2Pq1s7z8vQy1RL?=
 =?us-ascii?Q?Chi3enlbwyatbNVC+tdp2PR0JtQYQMLwqdR9DnpX2h1UG3O8ojtc532noNJr?=
 =?us-ascii?Q?yWPLU4rF+qiqLJUMjtiBZRIbr4QyeoHvGVFS2q2dP8pliIFyYnAkJvtJgv8H?=
 =?us-ascii?Q?ihiG5vn8eodfO6ai+aCT5IF9cmeTXnTmX4NS4rro2RPUgfXbB1t2q8jotEKB?=
 =?us-ascii?Q?uNf6KqHfZ6dfYSghAso1c4j33dgYwyQCoyHYHFN+N1+ynyIHvqIQSBZCDobq?=
 =?us-ascii?Q?/fGmnX9xZRIRfSxdHWxs3yxZFq3Jgt/VmV//w6QoGAlGGfBREzRf9VEChOKQ?=
 =?us-ascii?Q?KyAgeA9lGGzMDuLskRO9D4wQ8Nt2+yM5CA2YXEidrNMCO3xnp0wACfJD56MA?=
 =?us-ascii?Q?0Il2RtwbvtOyUuACxZ0YQTth5I97Og1cHI9gSaXA25/7bGV6IqdUO0D/9BTT?=
 =?us-ascii?Q?zoEey2dhAm/SJw5VVQevbG4YmdC4pQX5sf38Q4W6Wuy5F0UuW4IypnQhXq/i?=
 =?us-ascii?Q?e0m9edSzqksu0m+bj7NFNmQlpjsmVcb/wp1ii1XfyY6FsAVHcV1Rd9RitSVv?=
 =?us-ascii?Q?L3tXtxAExDj2ZVyu+PYV+5V0xBcHxT6vD9Dmxm7fr7hX7sRXop1dUiAGu4/T?=
 =?us-ascii?Q?g3PbVJz0yPad2eL+kkHa1/cJM2BZfJCp0Ivq1HEIeFNlEl/Ki52rD9QLKTmI?=
 =?us-ascii?Q?okt3lxHmuTrrQqdOGn/r3Qnid+R+zcI2aneZHnOXbFzT5m7AdrrsZVzjmnUF?=
 =?us-ascii?Q?SJrD0eVIgQsG/M1dzYoud9lxYN2Z9re5fnW/rMWcwMseNAWAA2tph1ASBbRs?=
 =?us-ascii?Q?gtQliTF0pecGdawM6zJGZOfveHzK7OuLqiEYTFgOGHo42JnACWaqJi+vWtNX?=
 =?us-ascii?Q?kq9gs3rbO5IUcdD72KVrAduPXoTxnYFE2N29Ze61HkuNV4Vwp5F02x+8Pjn6?=
 =?us-ascii?Q?cRS6c7WtngQfqIjzrYKF2RyNL9yG8C/Svzoz4qhhrcKr1IjFc9X8BmOQR/5+?=
 =?us-ascii?Q?lkrxPFqSXQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fdd9ab-c42a-4f71-8f34-08de5f223301
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:36:02.4810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YBuxiBAhpZUqk/5jBEhjHQV4yAC4FaugHgxE1coZT0+t5p1F3JDoxXfcjIzpSq5uyJbLy61V8v44YhzqfC1rww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10843
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254731-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,nxp.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE4BEAEF30
X-Rspamd-Action: no action

Extract fec_xdp_rxq_info_reg() from fec_enet_create_page_pool() and move
it out of fec_enet_create_page_pool(), so that it can be reused in the
subsequent patches to support XDP zero copy mode.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 58 ++++++++++++++++-------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index bbea6252b43c..193af5e2666e 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -489,23 +489,7 @@ fec_enet_create_page_pool(struct fec_enet_private *fep,
 		return err;
 	}
 
-	err = xdp_rxq_info_reg(&rxq->xdp_rxq, fep->netdev, rxq->id, 0);
-	if (err < 0)
-		goto err_free_pp;
-
-	err = xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq, MEM_TYPE_PAGE_POOL,
-					 rxq->page_pool);
-	if (err)
-		goto err_unregister_rxq;
-
 	return 0;
-
-err_unregister_rxq:
-	xdp_rxq_info_unreg(&rxq->xdp_rxq);
-err_free_pp:
-	page_pool_destroy(rxq->page_pool);
-	rxq->page_pool = NULL;
-	return err;
 }
 
 static void fec_txq_trigger_xmit(struct fec_enet_private *fep,
@@ -3420,6 +3404,38 @@ static const struct ethtool_ops fec_enet_ethtool_ops = {
 	.self_test		= net_selftest,
 };
 
+static int fec_xdp_rxq_info_reg(struct fec_enet_private *fep,
+				struct fec_enet_priv_rx_q *rxq)
+{
+	struct net_device *ndev = fep->netdev;
+	int err;
+
+	err = xdp_rxq_info_reg(&rxq->xdp_rxq, ndev, rxq->id, 0);
+	if (err) {
+		netdev_err(ndev, "Failed to register xdp rxq info\n");
+		return err;
+	}
+
+	err = xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq, MEM_TYPE_PAGE_POOL,
+					 rxq->page_pool);
+	if (err) {
+		netdev_err(ndev, "Failed to register XDP mem model\n");
+		xdp_rxq_info_unreg(&rxq->xdp_rxq);
+
+		return err;
+	}
+
+	return 0;
+}
+
+static void fec_xdp_rxq_info_unreg(struct fec_enet_priv_rx_q *rxq)
+{
+	if (xdp_rxq_info_is_reg(&rxq->xdp_rxq)) {
+		xdp_rxq_info_unreg_mem_model(&rxq->xdp_rxq);
+		xdp_rxq_info_unreg(&rxq->xdp_rxq);
+	}
+}
+
 static void fec_enet_free_buffers(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
@@ -3431,6 +3447,9 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 
 	for (q = 0; q < fep->num_rx_queues; q++) {
 		rxq = fep->rx_queue[q];
+
+		fec_xdp_rxq_info_unreg(rxq);
+
 		for (i = 0; i < rxq->bd.ring_size; i++)
 			page_pool_put_full_page(rxq->page_pool, rxq->rx_buf[i],
 						false);
@@ -3438,8 +3457,6 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 		for (i = 0; i < XDP_STATS_TOTAL; i++)
 			rxq->stats[i] = 0;
 
-		if (xdp_rxq_info_is_reg(&rxq->xdp_rxq))
-			xdp_rxq_info_unreg(&rxq->xdp_rxq);
 		page_pool_destroy(rxq->page_pool);
 		rxq->page_pool = NULL;
 	}
@@ -3594,6 +3611,11 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 	/* Set the last buffer to wrap. */
 	bdp = fec_enet_get_prevdesc(bdp, &rxq->bd);
 	bdp->cbd_sc |= cpu_to_fec16(BD_ENET_RX_WRAP);
+
+	err = fec_xdp_rxq_info_reg(fep, rxq);
+	if (err)
+		goto err_alloc;
+
 	return 0;
 
  err_alloc:
-- 
2.34.1


