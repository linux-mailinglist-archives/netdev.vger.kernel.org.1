Return-Path: <netdev+bounces-136705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB4B9A2B3D
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D6F1F22288
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 17:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64961E0DEF;
	Thu, 17 Oct 2024 17:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="MjXcuti1"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2074.outbound.protection.outlook.com [40.107.249.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788711E0B7F;
	Thu, 17 Oct 2024 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729186938; cv=fail; b=tKm1a2ADtRxlD1f0klF7s7BRc47APup5dpX9RwYDdaTe9s1U8PHbOXMAzFAoVxkp72eBI70au0snEJSOaVb+rV+AA/vtp2N0mrjQQR9U3fM8GaUD7cZfhoIPqel2P5052/ATPxtL5T/lmwOTrt5Ies/AFP+KVrkUxt1bkfn+ohw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729186938; c=relaxed/simple;
	bh=iaXMrJ0vaF2emybVkxW//Ik8cBssajZPiz9MRv/G1zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WwVcczmpSVqEEe1PL/1O+0WLTPmyK+r93zwPolyBltFVMR0R73fNRAE6gIt/Kg1Mn2fPvxpIjmzYohLsrFHSi20sHMzyBsAVFstsgD0rw9CHwxNn5OhQT9qFLn5uQSB0s34NIcYyWuAkO1S4fZ+lxboMqgm0sGJciROzyB9xjyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=MjXcuti1; arc=fail smtp.client-ip=40.107.249.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBannn/5EDennmA8QSnKAi8nwqJKzD9F/NnBlisPUzcSCQEI8DI2EhgTUymhqGzeG0nrj3fjlxk/nXiKzqFEccSjEJ+ELaJaiv+S1YZGCNFa/5vaIgCdjMm2VjY2YY5CTEfX+aIIPSYT93PhwHcwWOAJ5i4sBoN7G18o0SFRqKDU3yTlx8vFUdue1vRMkAG3Hv/fGgsXaj2qLToGuO2204VkSfBJARHiXSbE97yZ2TZssVCfUcpHRYrOGnTQy7MSDKJi+UXXgtM5rFXXyJNfgSy21spSzsmmbERl3O041nXEQTdryqDjVypdzlg/CVZy2/I2GYYyd7RY6tUXEQH1KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ReSQj0l6DZ/BD4r3nkGqyXuyPDGJTmJHtKrO8kW7Hi4=;
 b=suagHEI805rfnShrABbRK27s7bhv8VgRO9r3Eze3ExZKUKauk2PsFMpEt2Xvgu3xsW3QLtQkugn9NoPWesa678olIs7FH59GByxUowGQN2Z2iclzvtMnTgS0IoN64xwUv1gzs5xKSt+7sRUYXbqa4nZw1kDiuOutKK9yOtDA50/mVHc/FmK8Dp33OgY443/9zbOgQb9RBxfVBp/Ua7ulRNWu0E8VRVUDA8aCboPCqp+uq/qZODNbCXJp4gkpnJTUdliqK+ntrB8pepkELmUjusFuNQ/RbZiO1bqTfw0uB3+q4eIq71m+jjtoDJ84c5fDppE+fazMsddHf4qchIHU8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReSQj0l6DZ/BD4r3nkGqyXuyPDGJTmJHtKrO8kW7Hi4=;
 b=MjXcuti1ibgX6z/9hCMfmTD0yc5P+JIG6Pj6O1O4xfclDkXzkiNmmSTCaAdEYz+OtuGLDEht7k/v3jYQwf7mE2nyLZozErICsTaHzFi6V7dd1iF+//c025U2ZEviSHZjdsbf34WWDFC0bijK3MIwsAHM1MrbRl4M4TvUt9L8pILH37lf+88oyzTgeqVAOWiFRkkBP2vZkczZm9sAIXxNBB5nLVeLYha5zRfsm5Nj2143fEjer568AooJGTTsI1vvvXNA4LjACCZpz0nWlMTtmYTjEyNpdSbluam8BAAp4FsqVutWfI6aWmTtKSgzoPY1sVLqesYtM4fgAIVwyyQjzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by GV2PR07MB9009.eurprd07.prod.outlook.com (2603:10a6:150:b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 17:42:01 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 17:42:01 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v6 06/10] ip6mr: Lock RCU before ip6mr_get_table() call in ip6mr_mfc_seq_start()
Date: Thu, 17 Oct 2024 19:37:48 +0200
Message-ID: <20241017174109.85717-7-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241017174109.85717-1-stefan.wiehler@nokia.com>
References: <20241017174109.85717-1-stefan.wiehler@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::20) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|GV2PR07MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: dbc3efb5-138a-4153-482f-08dceed2f707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3enHzkiBNbRhFMdgzsOEsMbZJQUtmbhGHwvhfG4Q+k5khty4fTzm/+lCA3/j?=
 =?us-ascii?Q?FA6oKxqQIIOE7IkVL9PpTmvFb5v+QYqAZqKqqIMxukVmGmEFF73HhfmSdejQ?=
 =?us-ascii?Q?FfmUkHc5oSbG4rYGtT4Al/j/CRVyAR/GGE6xFKhvi31snVLoQ4kzNT0zjCgD?=
 =?us-ascii?Q?2kCu2GEnbB14iL1+uHYmnL0L4P0bkAnmbWnailVzwTx+vMbNfge9EhLMODDJ?=
 =?us-ascii?Q?fzqrx+u84D/XtFk8cJVi5e/QA7GhXYiIXZ2WfDSOqKM7BchSXADr7kc4xEhl?=
 =?us-ascii?Q?VaHsoiI7WDwtQE5o4CyqaAMbq6clzrmdW/uP2/1QVhFi0yDWL43jIurrs6v/?=
 =?us-ascii?Q?b+cKPweqy2VJ553G5vYHccJPRN6IXpwCeeatZXUVIhQua/SHaULt0vBBBAh5?=
 =?us-ascii?Q?33jlSSkUNeBHgViPKJSePfE7oRbocB2o75Jqrwl3ZqljIHOpS3DkUaZKr04n?=
 =?us-ascii?Q?DyDf4fvF9W8njZfibZFTC8ROlgSo1EUW05ErB3AaqFavAoVZkuJCxHDCULyO?=
 =?us-ascii?Q?1wKKZ1RAlzctOaqNudHun8yKT0TTbvLpH15xQB41gc8M/J90nh5mnzRigrGv?=
 =?us-ascii?Q?D6WuV1ukHVcjeGyeZKuPupTpjGrHy8B/kvrmEf9uScT7V8uPdiKiaJ80Paaj?=
 =?us-ascii?Q?SnsvKVDchvlRdyBjaIvpyYhOLYkPH3vWQZLd4kzoKP4NZa1qSRHC8+XTAaxh?=
 =?us-ascii?Q?66kaYQ725e5yQrGlyPFr4MYj5XOO6tyr1FI1HMDwJk/PMMY0gQPSR54e3iYm?=
 =?us-ascii?Q?REIQHMKhl95y9Mr3pKE21mrjaR6m7+VUKgz+6QVLnRI66wxdSuzwL1LS6I+r?=
 =?us-ascii?Q?Uu/kTxfE5lzPl7ifeobmfgPLuR45W7jN99SZHmmfaEyhiguQo/q8P3iK5MbM?=
 =?us-ascii?Q?+s7k4tUwyi/7iowe1phBqNdK42Vj6rGqq3+ogXKCMsRsXZBNXmQXHD3wNT9a?=
 =?us-ascii?Q?oXb6FP1Z8mNW/UtCycMxxgoiq9j0Qk31hmn8LYXy0gdBs07UeDWwOTqCvI7P?=
 =?us-ascii?Q?VTH4TObcIvLqnfaA/Gyq8OeEjbKXmSDZA1kFG29Pvy4WNBWOHZAwjXulYzVo?=
 =?us-ascii?Q?q+ltZ6advSUPzvEjguoI8+pf+tFft01Gez2XWG8u+ymAZTxdxmK9Rt3aBFHz?=
 =?us-ascii?Q?hzxfBbXhEGPy7iai+E8SrE5ZtzGnBblMeRLx2KzE771ZeQEY8NyX0fN2gpq8?=
 =?us-ascii?Q?x0Ro4WEJIWutndue3wQdItbOSWUtLxHBfJIak0ej+gSMlVTQHppLwEFJguCl?=
 =?us-ascii?Q?apThuK/vj8b9LestHv2wYMdokCT9aT6DYFQadMF/Gcazge/WD79yopmBLYlT?=
 =?us-ascii?Q?tDY3PGsYBTzFqUzIPgLkf4Mj23RN3dAyUtAq3ggVkXAlqWtWigrgvpj/0qKE?=
 =?us-ascii?Q?c9gi2xo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kjAcMKmaw4dg76UfklTPaQVh/IkvGAVIrTz28qM+zmvq6tNUc1cdQ8SkWW1e?=
 =?us-ascii?Q?SEYFOmBpNjVsHX8eWdV0/zT8LSX1HGb4ugh/qAyQN4ujmu4LlrlS+Yrzt8/J?=
 =?us-ascii?Q?d7wnwz+uib9aykIaLz2bjAy+4hdffMJZElClugQQ3oVwJiK1xE+ZwhHJ5Xfn?=
 =?us-ascii?Q?TNahX5G/rsXUwzy+WU+fT3/egianGngvZj4Pf7KoV+4cUO5HHJcrRCS3+kAg?=
 =?us-ascii?Q?fY3HCjmC+AyCDhz0u7xhO6hmAFDAdGAo4YRCn1QfF98B/U1jqTEhFxFy29f4?=
 =?us-ascii?Q?MlHG/TI16wQEhg+VRVQ8i+dxhcwWcX+p/Q9yYZtwwWdvz3z2xvHvOxsPevzq?=
 =?us-ascii?Q?YgP0DlhLdZqWpsMgapugTsRaTK3rK9I0pJF4DlcwZ1Meev7oo5w7KAhu3ZEQ?=
 =?us-ascii?Q?0xKdY63EGdGUx4Rhj/yIsE4PHALjEL6CnpKjEUhcssr0/SsnE7WzLPBtWrF8?=
 =?us-ascii?Q?BsOiAytaPVKNNXEigHydPmHYFeh3MeQ5wqtaQdmZ+M5Xf6PLXCZvLnKIkWGq?=
 =?us-ascii?Q?keqKOx8qeZwB4ZGeod0UMxVVV1JqJZaKTsPB86NQnvXIzFMbjeCG8LJ1FUyW?=
 =?us-ascii?Q?gkVawUy54s2y4Xqb6m1TZbb9sMr2rXRMFhUpLZA5fSAUZlICSFYlWbJJEEsY?=
 =?us-ascii?Q?tVoCXuNolGFzweLVWU9E6sTQBXHcYsyURPf1bp8xROSf6TuQ41Arsck1ltr0?=
 =?us-ascii?Q?Ya+/LfivBhZOBnem3ydgEPP2zk7csgFOuuPgkC5TKa6JsZQRPpGHUZoJANfF?=
 =?us-ascii?Q?dL6SrOQXiJs/4RrC2weUYd9PyGKsL8jj/0jBX94FzI4bawWw3v4q1zXfMxVm?=
 =?us-ascii?Q?E5f2FuF/JvnFJBHARaxL2Hg8F4VyJc/rYK0uqhef/4q4Ll/jmnZwXEsYNvCn?=
 =?us-ascii?Q?7xdh01bknfOGEuoncXOVzGF18EkSzbjK09tfxxTxbE1zyboBklhfjdSqaTPk?=
 =?us-ascii?Q?9yDTgw+nLEKu1rHtl2eA8GtOau6pPgLIDdnTKWqKYpTiNXOqziz5aAYg+kUB?=
 =?us-ascii?Q?dBBGwodyMYgdnQ0acoY5EI9zI1XrzmHfpGX3WdkBd5zKbu4W3QtGyxO8qn/J?=
 =?us-ascii?Q?+t6PUnKGCdPHZpLFSLb/CyI9Jr/aW+/IA9SoxfKzJkRTfQ2OPsg9UwcVuOP/?=
 =?us-ascii?Q?AUTSoIVi+iv3rtM9UH79leZFju4jWAn7Caarwc6M8BQ9lw/B8oFdtugigPgm?=
 =?us-ascii?Q?1xW5h/i27sYtTCX12GSddtDvr2KmRlchUfvHd7BqaTz5kbLH2qE8hisPwKZS?=
 =?us-ascii?Q?PVf/gZ1tRXrLYY2+jZJjyfLVeeUmC0KBwxWRT4PDGUwUfUYboiR61oB8SWDc?=
 =?us-ascii?Q?X/43YhZSsUuQfEDlcX4AFDUzrbTpiGchE631ivE8lKEqGh84YU+L3kP34aqN?=
 =?us-ascii?Q?OaigDZL/BN839lbgmnwmRl3cCRu+zEsSrjaHsf3PjxI98ePePZHi5SMf/CsG?=
 =?us-ascii?Q?JBIoi2+e/BxbVgBtac1arH2BVQnLrkWhIADlnO67NcG4HH7ElhLkgUq0Jchw?=
 =?us-ascii?Q?7MFBZ43kxrz2j2xQ6kIi3Uxbv3zkYYLfBJyxv6sGL8ZJTLFr9yaZKcWDpLq2?=
 =?us-ascii?Q?/meZOn96JLsfwon5zCzSEnX/4fELqCHAXQN/R0BAvxqxF2iNDnLzP5Qc6C3W?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc3efb5-138a-4153-482f-08dceed2f707
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 17:41:43.5504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aBsosIXbds60+Mfy2PJcFasXR60GqjlgWVWpa1s/eVzgdCE8jSwE8prZy43yH7LFSiStN7wmVIRsONR/Pwh9ZqdKDGtvc9MFNfZ5Lob1ARo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB9009

When IPV6_MROUTE_MULTIPLE_TABLES is enabled, multicast routing tables
must be read under RCU or RTNL lock.

In case ip6mr_mfc_seq_start() fails with an error (currently not
possible, as RT6_TABLE_DFLT always exists, ip6mr_get_table() cannot fail
in this case), ip6mr_mfc_seq_stop() would be called and release the RCU
lock.

Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
---
 net/ipv6/ip6mr.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 9bf42aafc7f0..90d0f09cdd4e 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -464,10 +464,12 @@ static const struct seq_operations ip6mr_vif_seq_ops = {
 };
 
 static void *ipmr_mfc_seq_start(struct seq_file *seq, loff_t *pos)
+	__acquires(RCU)
 {
 	struct net *net = seq_file_net(seq);
 	struct mr_table *mrt;
 
+	rcu_read_lock();
 	mrt = ip6mr_get_table(net, RT6_TABLE_DFLT);
 	if (!mrt)
 		return ERR_PTR(-ENOENT);
@@ -475,6 +477,12 @@ static void *ipmr_mfc_seq_start(struct seq_file *seq, loff_t *pos)
 	return mr_mfc_seq_start(seq, pos, mrt, &mfc_unres_lock);
 }
 
+static void ipmr_mfc_seq_stop(struct seq_file *seq, void *v)
+	__releases(RCU)
+{
+	rcu_read_unlock();
+}
+
 static int ipmr_mfc_seq_show(struct seq_file *seq, void *v)
 {
 	int n;
@@ -520,7 +528,7 @@ static int ipmr_mfc_seq_show(struct seq_file *seq, void *v)
 static const struct seq_operations ipmr_mfc_seq_ops = {
 	.start = ipmr_mfc_seq_start,
 	.next  = mr_mfc_seq_next,
-	.stop  = mr_mfc_seq_stop,
+	.stop  = ipmr_mfc_seq_stop,
 	.show  = ipmr_mfc_seq_show,
 };
 #endif
-- 
2.42.0


