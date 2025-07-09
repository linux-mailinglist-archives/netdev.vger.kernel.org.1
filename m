Return-Path: <netdev+bounces-205228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B64BAFDD5D
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 04:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 030584E4CC7
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 02:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2001C861E;
	Wed,  9 Jul 2025 02:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="fUH5rBhd"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012027.outbound.protection.outlook.com [40.107.75.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3741CD1E1;
	Wed,  9 Jul 2025 02:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752027796; cv=fail; b=m7G8+E7UTK4TtEANHtz0kpTuyOAzlkEC1fzPRLGhMgrfHhGOMWUKJtjQkac2ncEGy1ktPlwzWx4KyKgoZ5C9r9YcbIbx8H2EZCBB/kg+L2EK+7kmZIsutYZt6zBeMr+///PYBneRBPrqR5zmDKhWPF+mohAWicUsC+AOPxq2HSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752027796; c=relaxed/simple;
	bh=ektBwy87tJbpb2J2q7St5sG6q3vWmLtc59a3W+l/obg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=orj9EX+wijcHQtRtcqP0HeU4cxofyVAk/UUwA7eGMcugogLa1fF9bXg1ZPe9sAXPb7SIltoUSudoynlwuh6ac8FHZTU3Vr42nqIEKw99PK8yAIpkH/kUaXMqY1rdvDv+ZV/60AXOA4FjmEDEyb+y8+lUZYetS3LzunvqTAW3GbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=fUH5rBhd; arc=fail smtp.client-ip=40.107.75.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mm/JcoCpFT8SxH0VA82dwtGiSrvkCVm6LlvdADiPvL+Q6R0EJeZbOnnCXqxL93lbwy3iiRSankQV7ic0OENFAbTqq70sS3Ty08uX5bKo3NUGt5AosHbl5lcrS3VQa7VomVT76otMv6AReWQplQRMGLv+ffQBzsW5SBJrDAxoALW0/Rb+de2gEJ9jfxXRhtjZyKz28/wnr8TvSovi7HTKW5Ach8iEGk4vO/xGBha/z9DfcRHoE2hlKI04q0FqMnLkey98ouGu/+DXIT2D5DHSGdFeIBjVIArP4ypvHSZ7NebTvcQgBqq6SOUgtru28Mu7GBJecJFXJUgtW8rysMVC0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xomhiyVdc0J45bEWALQfjozIsuqjZ2RJA9zbWozOEX0=;
 b=JXAMnYUlso/QFIvaTPEgGTJJITXZE3VqpbodFVcffxlTgqzn4ki6cdx7H9s7HnqlgqL+XQ8c9ovxUWIJBEWB+bqyKBh+6jSRSoeWwdyYyttF4ClfLOJnRBuz0b7QqH3sBKBsgrnJz2O04IJkfvR3JtlsUu50hxj5sf2Pu7l0xQcv4yHNQJh+XuNcVgjbZDdGilYSPzhvSpznmkAjfzUfq5nHbDpUuKZ2Zcj38MDl2ynTThfL9sGATJmKdyBnESZsH9cJ8zfEMXUxf+RYsdasQ4J/aOdJjOqNbSEIeb5xl3pbPBxebanHC2FUYrOrjr1hUHCy6i8DIXOJQe81EbHYcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xomhiyVdc0J45bEWALQfjozIsuqjZ2RJA9zbWozOEX0=;
 b=fUH5rBhdGLnqXfgf0WWtdORpY5uFgeqMav2nZQ7eS9PfEjK3NwSnPY57jTcTGpe3OQySxlIcfyMJ/0cpzUMRJKXmVBIHN1dW8RaROQmCsfU8905ejPEvV+RZhSMWBjdhLFEur+NCU3rcUDOEBG2sf277CnOpt2u7oYEPzqjmHS9UbOG+2uOnkBrJ5HnLp2RoO1P/kkNVLQ5IvWeaCMQPKdZnoPifWmxisBZfvW/uXT708k0g4VGopLwsZEJj0+CMmuqdWks+AVtkq3YGLZ0raStGV+nl39HjkEk8oMY2vnM3/10Hf1QY+5pGku42A45k5sbnQArVLPkRbSJXIZixiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEYPR06MB6156.apcprd06.prod.outlook.com (2603:1096:101:de::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.25; Wed, 9 Jul 2025 02:23:11 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8880.024; Wed, 9 Jul 2025
 02:23:11 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Potnuri Bharat Teja <bharat@chelsio.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:CXGB4 ETHERNET DRIVER (CXGB4)),
	linux-kernel@vger.kernel.org (open list)
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH 02/12] ethernet: cxgb4: Use min() to improve code
Date: Wed,  9 Jul 2025 10:21:30 +0800
Message-Id: <20250709022210.304030-3-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709022210.304030-1-rongqianfeng@vivo.com>
References: <20250709022210.304030-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEYPR06MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: a1d91cd8-bddc-42b6-c32f-08ddbe8f8d37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bVgm70f5XU+pc5IfY24VG2BH4D9PR8P/iE6sHCqWletmV59ARGSOCDez/Fzy?=
 =?us-ascii?Q?w82mVNisCIl4uA8PFf30TKsDPHPBeS3Qzen5XoCiuN0ouPGpDCXfdGbuPwnK?=
 =?us-ascii?Q?oUfn78TfXuijCeCm8FTAFSCwL0ujVaJtYHze8Mwv+pmdYPXSvalw5WwEMjxc?=
 =?us-ascii?Q?qAnYXySf6U7NiXJai3Xo5HzGqOaOQ6wFE9WNTHInSD05hhMbwkdnDyN3UYqF?=
 =?us-ascii?Q?Cw+5su3xx77ZtOY1+wvT7706o3+tvmDmFeSZtWIevqfJCh0YRHiV6rziN4Mu?=
 =?us-ascii?Q?Rcsw94ACh2HCFWjIykC0PZ27dNoci+RCkU2NZ3N7cGD1UEwiB9hqa9GYHWOF?=
 =?us-ascii?Q?KQWxAA0y6WvEk3o6lLgg6Om6rl3nIHrdL8kuEe0xIcvm9J0FGdPlRWfDsIsM?=
 =?us-ascii?Q?RcRTWCvnRPN19w5InnuJKVdHMTSnrY3YXOg6K5PAw5bioo+1j8nxaITB42i1?=
 =?us-ascii?Q?2aUEdQR4vpx2cC6DRzaJsnwX6ReDTy9KrMCxeq/0BDrWOrUQj766d1Nn9k8Z?=
 =?us-ascii?Q?U1H+XaXRgyFj8T9aBe9Zt4old6Lm/uRJqBqv6sQg8mP0aaxx7JLTaTvBi/r6?=
 =?us-ascii?Q?cvvoT9eEsX8mVEPKRHrgp5HLrAtNabRua5VO+DWYES35OqP9kEglsl3B0HcN?=
 =?us-ascii?Q?bntqw1rY0sMWmyepgyqj3OtmS5f0bSt3rztUP8eBOi+RIaUFgY3rPDnXZJSL?=
 =?us-ascii?Q?QxubE6vGj6gJaw11Y1LoHu0e8wXJ2pc3fUpW7tBJojglE489jrx0ACF4R3J6?=
 =?us-ascii?Q?Rt834VkLneIQ1YCXtdcu1eVUyHX9DNR5WeOMRAlSN6Gy+WUF0wsovp+bw9OL?=
 =?us-ascii?Q?UGAGfvvxnrwi+DTrByOlmCYyt2vPFw2KmZDfsd6jc9xZyNJMsKR3NDpSSBCA?=
 =?us-ascii?Q?FRNVYmyiD+HquvBi5h6ymjI+cEtF1QjFeh/8xVB1nfnz6wqa1RwlLXzF3f4M?=
 =?us-ascii?Q?c7k4PUrEEihbScveyDhqzkjCw9aenkMbp8kgiSlcUJNwLQDLH2KBYnLaQEnS?=
 =?us-ascii?Q?fDVQyqX3cHDGdj7ptKKQkIKK0FwjomfGNiNI+s3PN0OSi5++eBCQvh5ZBDy7?=
 =?us-ascii?Q?UVfydjYFeBE14jaCwhOVxdw84O4q679mbQlR+Wyr6BJBOwubFXsQCgJWq8P1?=
 =?us-ascii?Q?U5LzBsPJQ4xyNQ8Mq8Vy0Z0iDEX0y8Yods7fCrdKOV1RL/EsoWkucvonemAt?=
 =?us-ascii?Q?gVfXxy0piBm9zUgg52U+b+d4FcvJ4NQDD/hHAlsSd//ijlIHQ7yv1VpK6Np4?=
 =?us-ascii?Q?V7pD2D8FdNe03ccvfQG1zCUwnj2/0KmmvvzUA7Kx97HopQW+YKqFuT2O6dzm?=
 =?us-ascii?Q?P+7Mwh5+FXSeGnQt8CT0FSZUan4qOOD72UB4UbQq26WAEc2MbqpnnzF7Lbuf?=
 =?us-ascii?Q?4BKP0NaRbNhWh86s0VQ4oThWKHRGo4CCLtqb2gMKoOk1oa740I6fz9aBk8Tu?=
 =?us-ascii?Q?vELlCX/fMw5Map9uMKE807RqCaneztmf/q1C4d6FAmeMr8WI6ehWWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2yvuOUAQzgl4Gl38oPJoUq6El54cDl5PuZvY3gUo+MoDIiAsLnBlba0txr8i?=
 =?us-ascii?Q?lpIsm5Wx1VZaOcmv+SORwEduzwuW2m68gx8q6n64IieF5s6MsLxvFHZN6blF?=
 =?us-ascii?Q?VEk7u7pVo13gxVrInUS38hxIWs9WLRJKia9sTSxgRuJhW8TjAPmFXycBUjXa?=
 =?us-ascii?Q?Vuad4K2GE3dSuzJA2N4D9esRNRW6TfQHwsrZm7TuXhZD19YB+5z+dfa/1tov?=
 =?us-ascii?Q?CKc1U9oEHfOeB1dcq9o3xuvz+1e1gLFAhG4uz0KWybuF7b8OJ6leWLZRGUCk?=
 =?us-ascii?Q?+OzcJdJGuXfgt+bVcWHCXCLKQMBuyHq5kwfQufx/Z3q2S0jNyfIr9z1H6LnA?=
 =?us-ascii?Q?b3Qb4AWLAwC4PZy3zdHi1TD9k8Tc98BCBQUFKNcK+4o5P5U3IsROnOa4AeOI?=
 =?us-ascii?Q?mG0aIm0EiT3ontJy3kyyQbTP6WJyjG1hLnyEFcw7JLBNBqEn8zL19VMBo6Ro?=
 =?us-ascii?Q?yrz4E/dffX8mce7TMXObVBCVuILkKabOMR2M4aMfV4AHr2UWrdUhVwrUC6Zu?=
 =?us-ascii?Q?6X/JN4yIFPMlo8Ea4GnHkJu1SMYfDurl9p0s1jCy7jjlr2pZw+rG4Dd2nL8r?=
 =?us-ascii?Q?SOaYN7VWlfzbuXlMESutKxisuTJdAe1buvXkWhTWsvg1V0P4XuZrKBss63g3?=
 =?us-ascii?Q?VIp7aiNEbRWmiYSUhWRE0COs/+gjtINS8RAvpteqt3kEDQrTKXJyViPggePm?=
 =?us-ascii?Q?PYdNgJYIHnj6q/Uq911X2eDs+hL4k0srC2oKR3+jMVtuiqRG19kpOIk7lbph?=
 =?us-ascii?Q?POBYATgKlqutd0vtv+PMqKJnHI8u49I/Q26oIVBuYHm1Wl+QtxVdi8xXvbLw?=
 =?us-ascii?Q?f8QPrSagXMu1jhkJSNCoTO7p5kLEEdm6i6pGndSnFZ7eneOYxIVNsobnxPgv?=
 =?us-ascii?Q?d0ybgLnxUOpiffgi20EwcXrrgL7pO+Gu84iqB2wBBhkOG+btBNbxvFiAxbHF?=
 =?us-ascii?Q?OL6oKy7KB1n6+092xC1Nm8wHy6KNe7spYQzvGpZjj2Cdy0SwUOTIl9N6jkpH?=
 =?us-ascii?Q?rOQ4qTxwD6XFvkhYRhaToVavmNDP9l5fXvg4OpOvQglVlSPK4ghtM34Yqzt8?=
 =?us-ascii?Q?DOPlNGCUxiSOdM3pi3G/01ALHfvhIw9SoizHivLDx+U479ohrDa/fCFJLPs9?=
 =?us-ascii?Q?jyX4vj8qXKKBr3cFYTkPRuAR1DJ0AFMOA3eW7CeFJ25q1L1DD4ojiT4rOMsp?=
 =?us-ascii?Q?hbghm41oqySA1ZWXGcaBAVrCq9uNdqeiP8HDVSTm/FTYEnqMDHJWjlgY7eF7?=
 =?us-ascii?Q?tggQeOYtpxRWOTyA980BKgBd1L/yZq9kf5Te/01oBGZxf4g9Lz1o92TVhIZa?=
 =?us-ascii?Q?rC0GyLv0xGLQb1p7pTYjmBMMz6A8WZWE4V6Ew8OtzWcKYV6A+Gq21eX9njoG?=
 =?us-ascii?Q?Sa8h1R65cWPHKPx9qYEx0uD0qpbYWeuqPOThGiGOpS59+y7aCzb16DH1XIFU?=
 =?us-ascii?Q?+xu+hhEUUclj2j0r5/JE4kT1psIYYIMAIoGk0qs+Rsu05qKmYT0Xozo4NY8S?=
 =?us-ascii?Q?zX7SR+vnNcVRnmRi24EIIC74YyCNJZDywnTWefcEqUaqd7dBlMnt30KSYFBM?=
 =?us-ascii?Q?pJOsaMfKWthop8A5arv7lkaxpAIj0N3kZlJHa/OQ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d91cd8-bddc-42b6-c32f-08ddbe8f8d37
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 02:23:11.7147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2TRkvqzDPgKgYi0NLiheyE4U5rGDMyDy1zjOdbzw2NZl9f6nQXc6bRiogl3Emg9QD6+p5lHplVjI6TIggXFFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6156

Use min() to reduce the code and improve its readability.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
index 175bf9b13058..c9546863bebe 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -10192,10 +10192,7 @@ int t4_load_cfg(struct adapter *adap, const u8 *cfg_data, unsigned int size)
 
 	/* this will write to the flash up to SF_PAGE_SIZE at a time */
 	for (i = 0; i < size; i += SF_PAGE_SIZE) {
-		if ((size - i) <  SF_PAGE_SIZE)
-			n = size - i;
-		else
-			n = SF_PAGE_SIZE;
+		n = min(size - i, SF_PAGE_SIZE);
 		ret = t4_write_flash(adap, addr, n, cfg_data, true);
 		if (ret)
 			goto out;
-- 
2.34.1


