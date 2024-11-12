Return-Path: <netdev+bounces-144016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 102C49C520B
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 10:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C333928772A
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 09:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D228620FAB3;
	Tue, 12 Nov 2024 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bQxC3FUg"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9267420F5B6;
	Tue, 12 Nov 2024 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731403830; cv=fail; b=QfPayyH8NfqFueSQvQ0gAiEzqKjU5Pp9utE65/uVYV7TKOyz4Zi2PJIHXmMmlT6EW3KA1zWkbgw31fqMccmMox8PisWY4x4eh2Gg6CMND1sg23nIQiUzcVkZCma/rpPFmxqcFpi4Axl27UJ7sqbtK5UNVsKtbjYMdv9/BeBSARA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731403830; c=relaxed/simple;
	bh=NPCv6d60efLKVg7OgJQVm3h2/Jj3sv5Swm2WhxKGvEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pqukR+79bo8ZDY7q4GJq9G+IBSryIndKgnVap00q48Wgnq22OV8pyqYNlApiM6wtf8LkCTYicU7uWda/m3RUUF6I5C6nB5NWIs7TTzdvpWViD0nfT7z+4uqLUEFLzzX/ytAQX1hUYrZVciAwXhsndYhNo2a4gjRVO39DifR6+90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bQxC3FUg; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cIPe+AdYKoT75luaaanEll2ou/jdxgon4RApvipnkUlp+3E9O2K13t8dzA9Bb5PscjWCvzNFmqoAxYhWN4JGA5pC45rwXO1rzklFObuj3bBno3imH5UVpXaK2NnVVjOzDlChhWFS/nI435BdActD/8K/GZ6yrZm23tvQ/sJLfWs0yJBYVALZRw7bdjJjWw/K6cCsB5813yyqYQmU945RJZawcoq7Dd6XjZq0+1YKzGECYZ6+rseKyU5kCCdoD5k2Sa/mAEZjmXdIFyIwY5cuJHXbtrNEbo8kWE3RbLIcuk3lGFR5S9aumBIfm7oo8veKIwT9A5fHdDAlHTFhBf5y8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0xLRCqDknP/fkYZGGNbE9VAzIWrI/Fok2BQI5/EVFQ=;
 b=UsdRdyhtSmlxCvs/AU8E5qDnmyO/iSxhzunFy75WetAAkhxwGWZpSJarHrJK0YUYWWb29eYHBKBSZJFuvxyalO3vwDy7pw9YK08eTc5VyEr3MRWnKkHWbn9NA+y5SYAMrDKsiscap2QyaD3nD7nQSoAi1INZ53wFajLRG3ae8kgzYiRPfiRiBG3L/HYzdHfy9auThd09LIDXSP6UDnUttAKWxm2+wsiTX/zkXXUKqD2c8s5rvFERdlXuyhy0tj/fsxofPWXQMzjRmK4hf+wGd0BPNg5I+vUgMyfjNxlWK/mF2DVicI9Qmcqow4XhC6F5ih+TmTi/IQuUJZvUsrxtxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0xLRCqDknP/fkYZGGNbE9VAzIWrI/Fok2BQI5/EVFQ=;
 b=bQxC3FUgxLYG6CMgFV4bOQDDDG3IcVMB0CHpHa/Es5C3wishBlXAqILYG/3ImJCrgCHD0XGi5TBdILkZQnJEbR6EpRyxcCsh4JgarZMpky4wKBFOMP6fFMPY06tWg6yPizJAvZTn44Sn5BKmYHuAL32NIC0jjPsd0dvCTBJXlMxIpYQi9PjwM1/JqXXc45JwsvhGe34uAIokwokT8emD+xwluOu4yoo/usGj8vmtMajiDjkhdYJ8htmt3NqnxM69KVTAX5q1Ce3TnI0Dz7tqC5OWtOcdf6drgrjl63ffew7VwuE/5erW3Hu9CURI7rtiiAnSl/1+jzoCQyvbUut2aA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7892.eurprd04.prod.outlook.com (2603:10a6:20b:235::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 09:30:25 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 09:30:25 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	frank.li@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v3 net-next 2/5] net: enetc: add Tx checksum offload for i.MX95 ENETC
Date: Tue, 12 Nov 2024 17:14:44 +0800
Message-Id: <20241112091447.1850899-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112091447.1850899-1-wei.fang@nxp.com>
References: <20241112091447.1850899-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM8PR04MB7892:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f0795b0-d578-4d8d-b8e1-08dd02fca334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P931na60nPk2OW+UwgrdtdYcbvruVujRw4YdjHVhx7Iw1EO4qePolM8KGnTE?=
 =?us-ascii?Q?F0dUvsl5YH5dcDNjUsF+RK7sQIX07bAkPhiQlz5M2BXxea9JyqHulF/GKN1i?=
 =?us-ascii?Q?R/tvekZSoUsNSrFxFUZHS/AbP3Bq4wiCh7qBBhDwa726gL0Sfuuy9Ka8uBtr?=
 =?us-ascii?Q?24M3Yq4g+mLuxiVSuCsMyR5lEyEHqRqWTQ2/0yrIlW5MIwXbwv5u8t53Y6KI?=
 =?us-ascii?Q?2Sfja9G5pQl7Rl1YjpZjgQf8ojjEkUN/IajveWqX13sZ7ZOKW84X88nt/3II?=
 =?us-ascii?Q?Q+79N2sy0p+Ww9D3BZPWpdRv6rWWa153SVXMKYD3n/WjjQPycCtJJ4PWfPxx?=
 =?us-ascii?Q?EOXEsQRys3XNQvRlG33CraxgZyaBqutmCm1XfFfCE6t588+65aeGSl+0cIVu?=
 =?us-ascii?Q?9w8hM+aykf2Ut9W1YF4AKqlInk6qFFQlxqhyacK0GID05klBnOY5bZNNoC4Z?=
 =?us-ascii?Q?Ko6+u5RTOzZNvfhzcPJchVSp8L7l2kDehxXHoScHdKmJMeF01otpCE1uXEDW?=
 =?us-ascii?Q?4lG8LO06dd6dmRUId3c20MQt6FVbnezh3LFt6KRmKu6mcUL60kAnInAmZDjH?=
 =?us-ascii?Q?NM2HtRixXP8JjgcRv+L2vDRWFN5SNSsZygmrfK/LSJEYvoVJX4yowFkSDtaJ?=
 =?us-ascii?Q?74KmNTQojGPcQyISEReav0nYP+rQLooBYaSaF+AaIG6tOlIw3wYTJixedSx7?=
 =?us-ascii?Q?rGbvDffh/J+9E1vTJLs6KKsuhVABdl2mUtdFHXbJv4MGu2WtL37Ad8XHpDn6?=
 =?us-ascii?Q?SlduAr5TiHVfGoYwBQLonTBJ7m7uZBI21t+eMIjuaddvsvKJd1iXz7NXktQF?=
 =?us-ascii?Q?Wpc5y3TZnQ20DnjvcKMfCDSo2zrhLrJfsFC4p2Rkja6/YglQp5+z82Un0uHG?=
 =?us-ascii?Q?XLuUbKTOdUN87ZUs536cwRR8l5DCDZefBoedGGLGSe9Wiw6hxwt0Hpwf4suu?=
 =?us-ascii?Q?B398+7BOAlVU/g8d5P6GWz0pgQkbj3wKXAKv9pR2iBPtjTZ2g5moXjyL08kN?=
 =?us-ascii?Q?YjQWDSX2U21727yeGPrcPXs5ACxiLX8gf30QSdJ5Xx4qHGM2wKheFWOwCZ8k?=
 =?us-ascii?Q?wG7gC3YLp3Gz7e34JbkqUCn8FsXs2xCP//43e6qlnJ9NviZ7+goelU/1bC6c?=
 =?us-ascii?Q?CyqdLCwHbOZvrbRS1Jwpq+sgpiEh0GetLIV5zJ/CpbSTaA6x2OTsmQjZPuUm?=
 =?us-ascii?Q?XmteQEPkwh9sxcM64DC4XnvZgCZUTBzIr3df+CI96/f9jEwwChuxbdHDDcRG?=
 =?us-ascii?Q?cl9ZaSfSJWlCOPyU7GdC8LV72YFHlyfAsOIlmsN36BMkesPD7ES+UVvLnLvJ?=
 =?us-ascii?Q?0lumjlmLmBuXtgCnM0ypotghzd/NWv3ey4Xp7hQde7Y0IM0fyk0oSnXhdruB?=
 =?us-ascii?Q?yo+MfMw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eqB76Kjgl3eHwmA0OhTKUPSz1XgRp0pZzQZ9hcYmyDMQW8FZSb+E7iuzbAPa?=
 =?us-ascii?Q?5bMJMSgEkkSs/N7Y/ZgaNlu9hn1XHrRB8F2SGgxGWdZYfK7Y/GVnBLKeV4Oc?=
 =?us-ascii?Q?VSv0XtO1W6BmUa+ReEsos1EmmOrDE/aB69vr3tmnKTw5eBxqI36x/62Z1CJ/?=
 =?us-ascii?Q?ClyDriwY+j4HIsDSaO0daW2Bcr8JxCiWZ3DBPIL1TVN+3grRoC2y8FKIjL5J?=
 =?us-ascii?Q?5xOvweTY00cPim1N3Lg3VhrzonoleaP18iu1T9s3XVXUZYAs9pfGAnG2RAJU?=
 =?us-ascii?Q?eWsyjBIbHMRy3ayAJTSVxIXfKGREUSe4+4AouOtXdBJzKvwFC5pyku0AhkE7?=
 =?us-ascii?Q?w9zDtbT0RcIPwccnrWx1PSck+PzHx5eO6+j7zrW6S1PDeMIsPHP0m05kBtJH?=
 =?us-ascii?Q?amp/iWQHkXrBcCrAxoUiVssrppceJNivqHKbtZVdco4eipW/zWC6z0QDyKm6?=
 =?us-ascii?Q?zF5EPX/0m2YQT8HRqc6X1HIs5OMtLWzCcyM7zWGYauSBQa1aQoon9AexYL4M?=
 =?us-ascii?Q?/UicQxm5yDBaf8UlU7d0M73NiMCE5uO/zUteAI9SCanYSUJDRdotVJ0mNCFy?=
 =?us-ascii?Q?L+OYw1wLaiaoErVn9uL8f5Sx/GGUO6oQ1b5VZBYCcy8dW4Qz0enpF0q+tZ8Z?=
 =?us-ascii?Q?9/oCkOXbwqpoL7EN0mKYhuxtgpDhrph0mA2aICsPUc5tGASg5HuLyizehqbK?=
 =?us-ascii?Q?fhdODrfq0/Lh0plOBqSNqp8zRwvjoJDgFnn9btXJUAoYV/QZBflbDnWhnFE2?=
 =?us-ascii?Q?+eiSpPAjxL0dm+ZSM4PFR6TYKQTkeGBfMBAfnXwNB0UBrrK/cl4a0BhGUbT8?=
 =?us-ascii?Q?AkiKg4BKwbhi7pifgkmZ7tD9lJOZOK9qUpijYD4WSI9765Qjbjfyt3jT41tv?=
 =?us-ascii?Q?svbi3i1a44le0z0KjQdRMesn4JNl24WPI0KP7gla0laOXfth/2AoJZPlyrN8?=
 =?us-ascii?Q?FvvHanQK3H5vvlyT/yJzUJPa6zkKRGqbWDnnPtJtWhbUaI3MymbV+Iy6uEsD?=
 =?us-ascii?Q?bk4JTN755Qngr4BiIO1f2/R+lbkd0riP93LDkZObjCm20rlnKysZApwm9MHT?=
 =?us-ascii?Q?D/zZ/UJyUvFXsyDU3KiUASEikwok8MR4YiiUm5mOEOLWf8w2cykgutB837t7?=
 =?us-ascii?Q?aFHM1YVta+4IRPfja/LXFmwUaAf0VpOOTzjHUdyffAPU//FDpEFzHmHHf9Sc?=
 =?us-ascii?Q?WY5alBlg2kIdJ7znRaiP7RSJwvTlgf5vK4/3OXB37Bqe7vCMb/kOLe3qu3UE?=
 =?us-ascii?Q?7vvsFhNJ6pIi3fKXp7eQaBmsxVIrY0gPTSXBQ90Eu/KhCX8UFCU7B9K1uWMY?=
 =?us-ascii?Q?3cv0hDKzgwZRzfJCsPDw4NezLG/n0uTMKDgWVHdOciFBGdTM68xCaYW5IXlt?=
 =?us-ascii?Q?jvkjThfI3kOshelvcWZ1hYCYbSmvDPMdXW6Z7OpSNHw5ErozEAWDxhaNvEZZ?=
 =?us-ascii?Q?fHMbcgyJ7lSPK34KqXJ1O3mXVTCk0ROyjeYhc4SOqf2bQGIo1oK59wnjcgen?=
 =?us-ascii?Q?Tcn7zro7GZfzE7BCvwj2absT0dVjJ7JAf96N9wU8ybUHRGIaQpo3ilGY9bvp?=
 =?us-ascii?Q?tJQMmeD92NPbwhbKFt5e97hoEYqorCOjN772icD5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0795b0-d578-4d8d-b8e1-08dd02fca334
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 09:30:25.1523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6HpAzPa3aQBo6PC4bkfSF/cefTJy0nya+HZUQgYNLYJGMjBpiV1GLXjsM/Vu0sThvig64k55g3Qta1qKItwF5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7892

In addition to supporting Rx checksum offload, i.MX95 ENETC also supports
Tx checksum offload. The transmit checksum offload is implemented through
the Tx BD. To support Tx checksum offload, software needs to fill some
auxiliary information in Tx BD, such as IP version, IP header offset and
size, whether L4 is UDP or TCP, etc.

Same as Rx checksum offload, Tx checksum offload capability isn't defined
in register, so tx_csum bit is added to struct enetc_drvdata to indicate
whether the device supports Tx checksum offload.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2: refine enetc_tx_csum_offload_check().
v3:
1. refine enetc_tx_csum_offload_check() and enetc_skb_is_tcp() through
skb->csum_offset instead of touching skb->data.
2. add enetc_skb_is_ipv6() helper function
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 51 ++++++++++++++++---
 drivers/net/ethernet/freescale/enetc/enetc.h  |  2 +
 .../net/ethernet/freescale/enetc/enetc_hw.h   | 14 +++--
 .../freescale/enetc/enetc_pf_common.c         |  3 ++
 4 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 3137b6ee62d3..eeefd536d051 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -143,6 +143,27 @@ static int enetc_ptp_parse(struct sk_buff *skb, u8 *udp,
 	return 0;
 }
 
+static bool enetc_tx_csum_offload_check(struct sk_buff *skb)
+{
+	switch (skb->csum_offset) {
+	case offsetof(struct tcphdr, check):
+	case offsetof(struct udphdr, check):
+		return true;
+	default:
+		return false;
+	}
+}
+
+static inline bool enetc_skb_is_ipv6(struct sk_buff *skb)
+{
+	return vlan_get_protocol(skb) == htons(ETH_P_IPV6);
+}
+
+static inline bool enetc_skb_is_tcp(struct sk_buff *skb)
+{
+	return skb->csum_offset == offsetof(struct tcphdr, check);
+}
+
 static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
@@ -160,6 +181,27 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	dma_addr_t dma;
 	u8 flags = 0;
 
+	enetc_clear_tx_bd(&temp_bd);
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		/* Can not support TSD and checksum offload at the same time */
+		if (priv->active_offloads & ENETC_F_TXCSUM &&
+		    enetc_tx_csum_offload_check(skb) && !tx_ring->tsd_enable) {
+			temp_bd.l3_start = skb_network_offset(skb);
+			temp_bd.ipcs = enetc_skb_is_ipv6(skb) ? 0 : 1;
+			temp_bd.l3_hdr_size = skb_network_header_len(skb) / 4;
+			temp_bd.l3t = enetc_skb_is_ipv6(skb) ? 1 : 0;
+			temp_bd.l4t = enetc_skb_is_tcp(skb) ? ENETC_TXBD_L4T_TCP :
+							      ENETC_TXBD_L4T_UDP;
+			flags |= ENETC_TXBD_FLAGS_CSUM_LSO | ENETC_TXBD_FLAGS_L4CS;
+		} else {
+			if (skb_checksum_help(skb)) {
+				dev_err(tx_ring->dev, "skb_checksum_help() error\n");
+
+				return 0;
+			}
+		}
+	}
+
 	i = tx_ring->next_to_use;
 	txbd = ENETC_TXBD(*tx_ring, i);
 	prefetchw(txbd);
@@ -170,7 +212,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 
 	temp_bd.addr = cpu_to_le64(dma);
 	temp_bd.buf_len = cpu_to_le16(len);
-	temp_bd.lstatus = 0;
 
 	tx_swbd = &tx_ring->tx_swbd[i];
 	tx_swbd->dma = dma;
@@ -591,7 +632,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_bdr *tx_ring;
-	int count, err;
+	int count;
 
 	/* Queue one-step Sync packet if already locked */
 	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
@@ -624,11 +665,6 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 			return NETDEV_TX_BUSY;
 		}
 
-		if (skb->ip_summed == CHECKSUM_PARTIAL) {
-			err = skb_checksum_help(skb);
-			if (err)
-				goto drop_packet_err;
-		}
 		enetc_lock_mdio();
 		count = enetc_map_tx_buffs(tx_ring, skb);
 		enetc_unlock_mdio();
@@ -3287,6 +3323,7 @@ static const struct enetc_drvdata enetc4_pf_data = {
 	.sysclk_freq = ENETC_CLK_333M,
 	.pmac_offset = ENETC4_PMAC_OFFSET,
 	.rx_csum = 1,
+	.tx_csum = 1,
 	.eth_ops = &enetc4_pf_ethtool_ops,
 };
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 5b65f79e05be..ee11ff97e9ed 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -235,6 +235,7 @@ enum enetc_errata {
 struct enetc_drvdata {
 	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
 	u8 rx_csum:1;
+	u8 tx_csum:1;
 	u64 sysclk_freq;
 	const struct ethtool_ops *eth_ops;
 };
@@ -343,6 +344,7 @@ enum enetc_active_offloads {
 	ENETC_F_QCI			= BIT(10),
 	ENETC_F_QBU			= BIT(11),
 	ENETC_F_RXCSUM			= BIT(12),
+	ENETC_F_TXCSUM			= BIT(13),
 };
 
 enum enetc_flags_bit {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 4b8fd1879005..590b1412fadf 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -558,7 +558,12 @@ union enetc_tx_bd {
 		__le16 frm_len;
 		union {
 			struct {
-				u8 reserved[3];
+				u8 l3_start:7;
+				u8 ipcs:1;
+				u8 l3_hdr_size:7;
+				u8 l3t:1;
+				u8 resv:5;
+				u8 l4t:3;
 				u8 flags;
 			}; /* default layout */
 			__le32 txstart;
@@ -582,10 +587,10 @@ union enetc_tx_bd {
 };
 
 enum enetc_txbd_flags {
-	ENETC_TXBD_FLAGS_RES0 = BIT(0), /* reserved */
+	ENETC_TXBD_FLAGS_L4CS = BIT(0), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_TSE = BIT(1),
 	ENETC_TXBD_FLAGS_W = BIT(2),
-	ENETC_TXBD_FLAGS_RES3 = BIT(3), /* reserved */
+	ENETC_TXBD_FLAGS_CSUM_LSO = BIT(3), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_TXSTART = BIT(4),
 	ENETC_TXBD_FLAGS_EX = BIT(6),
 	ENETC_TXBD_FLAGS_F = BIT(7)
@@ -594,6 +599,9 @@ enum enetc_txbd_flags {
 #define ENETC_TXBD_TXSTART_MASK GENMASK(24, 0)
 #define ENETC_TXBD_FLAGS_OFFSET 24
 
+#define ENETC_TXBD_L4T_UDP	BIT(0)
+#define ENETC_TXBD_L4T_TCP	BIT(1)
+
 static inline __le32 enetc_txbd_set_tx_start(u64 tx_start, u8 flags)
 {
 	u32 temp;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 91e79582a541..3a8a5b6d8c26 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -122,6 +122,9 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	if (si->drvdata->rx_csum)
 		priv->active_offloads |= ENETC_F_RXCSUM;
 
+	if (si->drvdata->tx_csum)
+		priv->active_offloads |= ENETC_F_TXCSUM;
+
 	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
 	if (!is_enetc_rev1(si)) {
 		ndev->hw_features &= ~(NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK);
-- 
2.34.1


