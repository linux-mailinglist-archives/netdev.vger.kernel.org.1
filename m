Return-Path: <netdev+bounces-143630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC95A9C3660
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 03:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B9C8281248
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 02:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119A213CFBD;
	Mon, 11 Nov 2024 02:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Nx36gzf4"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A333413B59E;
	Mon, 11 Nov 2024 02:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731290893; cv=fail; b=tG7uTA4eF20dUmoyWz6fbmHc4LKONvPyIuNtxkaX0rKaffAKslKL1ydq02OGJ5iLfzIKgWXnvOb9nhs4/CS0xuaYYPiVTm2mbb4dAlgEEySiaBG6G+eItXnxddDRG4IXp0K2sVL7/WT+I2QlniPHdDWm/Wbs+b5EoqriKtCEBXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731290893; c=relaxed/simple;
	bh=UYQs2SH7ZE4tYfAgwzU674wtDS+pwu5c4cUfYUeQBwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rBpeJ9VtzkubeByug0CAKEuv+crd8glr+tPlwkgncG2qjSzp2OptI1XIns8HcSfRIsvpCG/bMpfaG7mOx2W6wEOunox1/WfMM+rkkNcASII2A2WvBtLi6Pzcs7keFYjoGfs9oDCL6k4FJa7bJJAROVR78/FKG/RprbE8k/82BmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Nx36gzf4; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOPs6/G85ZTBIB/jG1XDSjmxuYoBoP7uuoNtqS+ZQ03QFqzdzzZYc5i5NL3jHjfYbaUNQhPyLTFY7ChtdjvhvFqUwgPw98rU+OvfUtdy0V+hlabBi03+2tm9IarcdPaYCIbs2cPx+yFc1mgCLODlINbcCpVzhhDldCVOj1aI6pbTCP0PcJtrBBmnHvmMDCcBfwE6K1SKmu053A7Yp/JKeYE49xpxPpubfVPtIdfhlo/gE084TRC4RN9n0LzBfrzAE4bc3VeTu3FXo6xCt8XxC4He8FscR5VXKkPLgk1IGpVD+WyXILeeoctjp0FkfgbYlrg7ef2SWKTXnVDEe/9qWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daspW7rj84aaocJqIZn+sdRfxymek3Lxlhpezo5wj10=;
 b=A22NiMNc4SCXa/K0Cn38LKyDHco/ivOR4bGAUK+YYoCAnFtwfKQZnmNyZfFLKNVFZkcw2/ot9PB/wFsv7htTe1MUzQDLKdi+7AEGExYfPiOnVZY4z6VMJDX4EKdvQ6qdfow5oympgQSvZkXPVPaaAe97cVu3Hu4AHwIvRosx0iuNCztb32NXR0nJ1dfa4BGG77wegmJJ7lUOVs3stenHCXqd5VLrjRmxgrsAutBthIJ225qJmLvqJYg/adAcGkso19P0BDrUJvibi2Z0Tj+hhexxn8hOhUdyl7aETXbvji8Nhu9Pi9J+whuZ+fFYwqKa1AuMhO+ug2OB2e1xBNmR7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daspW7rj84aaocJqIZn+sdRfxymek3Lxlhpezo5wj10=;
 b=Nx36gzf4guwj83Bbc6g+P08Ly6nF/ln+p/zzgGAXUJ6zEnqasEGiyMr8A63g5031gOVXe2ohVIBFHoEgp2jIFOvc9jPVn3Bw92gsJP/EM557ZODiO7w0Sn27i9V7HjzzqkEQkeUywW4bl9f+6/ftdWI5NYgDA4PrJWrrEypM4O2FniVoZY63BKRdpvcvCbq17Ku3foVcjuhH5SUiiXwKxhShe5OuMdAeVaWK48gyM0a0LEYyOQO3yesyq2CVTDgAzHWZ32QaDPN8Gwyyy7jlk3T02eAMioUboMHnGkA0Y/HdIfI6vZHACxQBkCB8Ne+XU59q0IyL2QfHPwKIJCQfmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7745.eurprd04.prod.outlook.com (2603:10a6:20b:234::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 02:08:07 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 02:08:07 +0000
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
Subject: [PATCH v2 net-next 2/5] net: enetc: add Tx checksum offload for i.MX95 ENETC
Date: Mon, 11 Nov 2024 09:52:13 +0800
Message-Id: <20241111015216.1804534-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111015216.1804534-1-wei.fang@nxp.com>
References: <20241111015216.1804534-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM8PR04MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f85bf19-f7f5-41ac-1cff-08dd01f5aec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KjwqpEVqHIdTU4sAMhRFA7yPd+OOEi1FROepHIpM0nk/4CSiPCaA3NymmjuJ?=
 =?us-ascii?Q?9+EDvR6IjmugvbJ2FB6NzTewuKue1QFUJx+W5/bXVj8QtjPN/zcXJ/moIni1?=
 =?us-ascii?Q?k4wC1WEOLMX/B3+/r/JHYC1hYF4OkTchAPz/tIDhzXXSfgPl4WnNZxZq0N0e?=
 =?us-ascii?Q?5xso73Mlu6JgLQ6iu/CBsB3DP9TLfWEu/p9lbzuDG+n0FJS5LC+/aWW7TV+g?=
 =?us-ascii?Q?B5dmYpH56ubwigKe0ubdFyMslyHJKrWlsh5vvgrSRg6bsA40b19Yrzmk+vB9?=
 =?us-ascii?Q?Xa9avVab65oJipQBo34JgVysa0zZUvhVKydiYzGZt4d7jb7MnECU25Hmuhd9?=
 =?us-ascii?Q?FtP7NlTXnuUIxiK75PRDA3hkvebpqG9MhGEm0S8kYgwkUa6ye2u7BtADWCVw?=
 =?us-ascii?Q?dpfX6EF3FP/mv4Nd6zp6GcLkNb+k3A5NB8H7eXYkpVsGCEiOsRbEF8t72cTe?=
 =?us-ascii?Q?lTbq+VvvYBCiN6lwYuLHTI00b940ouidn8Romub+CfFTVfP38H9ug8y9qBPe?=
 =?us-ascii?Q?na8zo1o3qIDZ9cr18SoiJipGY3uxtZxteUqrkA2vXmoRcXFh8EmBfJB+5zfd?=
 =?us-ascii?Q?2JwtrFmsqHuIsk5Z60byxMdPv+OYWFw54c9YHlP9bQWstE8F7bfrLfAbXqiT?=
 =?us-ascii?Q?b07iMywu3xJEJTRqW82hk+l/L1YmPS0dL5Kikfva4wEJN20rj6Sa2lAYoc8S?=
 =?us-ascii?Q?2olL5f7TNSXgqMwQ8O/Vx9PmYw7cle3NLe59T/aE2yvajmvK3pmjqdOmnNM3?=
 =?us-ascii?Q?0j7vgYiIFRrIbOZr+MngJum9hfKxpWwHNUs0VIjk7WUt3k6snK6PxI77n2AU?=
 =?us-ascii?Q?rBW5sXBzVDebK7Bcl4KkRnC0tIE2XOlHEAk7Ie/q+c0sDUdDW+YLPaVBzJ6Z?=
 =?us-ascii?Q?ykttybaIKplHfq/zH0YuHKintX1dNr86NHK2oHzu3hMExaQtlzB4ErvbiCrf?=
 =?us-ascii?Q?QizEob7i8yklgXFZvoMByvAZTCTnSFJ6yJ0TrvJpKvUXaqPTF/xUZvRYx6rg?=
 =?us-ascii?Q?hI52D3/Lfe/nZekDRSw8/gsLx05HDr6jRoJgaulm3oBck8vozw732dmDkzgm?=
 =?us-ascii?Q?jtLuH8l8QEdLM7iCtrLf5ns6YGvA8BxltqUgHNqp51n9YKwDUzM013KC/MXj?=
 =?us-ascii?Q?hLt4cTmxTWIbUQ/hdx7AAtlmknBVt2/bi/qedM44G9Fu04PQ/O/Swpr57GuR?=
 =?us-ascii?Q?K5pdbM727emVpLrEoslNLhk4f0xH/akBtjgZ2+OAXjmzLSj31VnehG778deE?=
 =?us-ascii?Q?wRbnS4wmmTyN3csJQ1UyNQjUDkSqG9zur76lUFHiSt45qXNo80VF05HmTv2p?=
 =?us-ascii?Q?v6t9m9K7s32hBkJaQ/EyGquVrKuZDFVJplUuFIWNVApg1epDPzdayxOnQZQP?=
 =?us-ascii?Q?RnFLDwU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eDbVL66UHfzyWmQeki/nfe/rwWhUahcd8X+i3eZ+7NYvFp2J+/4VFm35rSgA?=
 =?us-ascii?Q?MEJLY2peYGaGC82EpZ9iWsVmfAFbh7rwrTNoTeTqBu7icqH2ZZyI3KER6lla?=
 =?us-ascii?Q?ZYCyDGQiTKtwmL54fg+znVhfWQ3DvE991p6cVt1Q75ajk9vkH98l0NSCZ/6u?=
 =?us-ascii?Q?LaPeKcwVTe8K1m1O5aLrwHr893LxZqWDC+pmRrV6xNhM+r9wggn0eIv1Tbk3?=
 =?us-ascii?Q?eMT75Mt7TQJvNpsqhRIN2goIA1Nrqsv7CZbAWE/tkoCPg9Nl2JLXyVgno557?=
 =?us-ascii?Q?Wo7Xw/Y+JrLDcmAS94403xq31S17kR3xvjQ6zY5L4Ee15KfuhinyJiTqMgHA?=
 =?us-ascii?Q?zjA265WoXVYR2fwTW0uuxKovPwMNdnnXbLkdWWGG2wXm+xcAomg8FZ1NMR8f?=
 =?us-ascii?Q?2kPR2zHUB6i1aEibQnyeq3LfntI09ZQeZ/+NbQhP7fk+nwMwcY7EglV7G+N9?=
 =?us-ascii?Q?C2h33yUhAKvECbV3qywJwdvEER/jO30qvDybTxfcd8ZTpW9n4SY2D6S9EorX?=
 =?us-ascii?Q?4Idc0EeRqbSazs7/lxRRqEtS/ReakSmnEUOc+Vzd2Tie70Y4XKKsvzaRRKyb?=
 =?us-ascii?Q?/c/EXbIX71Et4qsoRA+ez+0arY0JsOheR4lJlLVbyRWHL2gJZbdWfPjNoMRo?=
 =?us-ascii?Q?DmOGNhk6yaizP7w+Po0Kvx8lHofL34ik8TBkzvIDHWAdVxbnLa+rKpviwBxP?=
 =?us-ascii?Q?wKwqfsP36iANxOjxCU3soB4HHKkOlRMnPGnbOp4EkHYSDFPvLxQFsx0QKGrw?=
 =?us-ascii?Q?jL9h5vdzhzlU9ibka6kaMHUzYpnyZE6MIGj1Y1gphJ39s+E90abiGVQ8kqZq?=
 =?us-ascii?Q?znFA7yqMt7Mdy9BMsAWUg1SoQ5RjEQXjaK+7/fndNG8ABNLGEzob3Y23KTKA?=
 =?us-ascii?Q?4ps6qu7w6Jh4LoepobskF1TlbqguhjY/7ydrSHkayHhFhG+xmqHP1wim8MCG?=
 =?us-ascii?Q?GZHok+nsoU+UzGv0pfVWgr0nlyigdvD9R83k4JMU1t4YKdWOdjPbeHGoZd0n?=
 =?us-ascii?Q?imx4ttWcOs5GN6AMI9drkDR8LZIeQyoCjVH2EgbiGoOwQKqjicBtM2tbYd+s?=
 =?us-ascii?Q?jGa4PaQMV/WC98D9ZnKYj+r1baZihAn6eNL2h7ZE1VIWHbuJFn+29MHId2HL?=
 =?us-ascii?Q?3xvH8iSwPSvkXVX1Kd5jUTfm6IQ0jwAReflqCisqSoth3IxVeIIjr4qKpirG?=
 =?us-ascii?Q?I5/prNlbsCZHtFWhKnFNnCRuNHeXbRwAZDGXy4gZUSbuUbjUvrg8MrdHHauZ?=
 =?us-ascii?Q?Z4flqNjC8ketPqsVityl5PKSab6HfXbvwL1agJx4yVad4npUFTp8PcBZss/s?=
 =?us-ascii?Q?MTqqCX/LfN3r71LHNDK9yslfnS6iGN6Q/WzoBXU4aKTltqzRDOVens4A5Eld?=
 =?us-ascii?Q?J6VwnNHtJV0nhXZ1SvQiOaz4lrZzcb3l5kVL4T0Ey3+xCVHUt2oWHJiZ3X37?=
 =?us-ascii?Q?WWguClTt4jde94rcjYt1iKfJpgAqDD6LTcXQ/dfgeEka8OUuO0xP7oOo2qIQ?=
 =?us-ascii?Q?H5KBsKRLf7zF2cYaXFGW72kx5aTx2a5PEHbAHgICc597jOPAfALXIFNsCHMN?=
 =?us-ascii?Q?wpvTMgMoGpOanQmM2FECXuDE0YjMTXVSdgQ/sRak?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f85bf19-f7f5-41ac-1cff-08dd01f5aec4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 02:08:06.9944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qta3PH1N/QdPshZ3PojX/KBhcyCZbKIfYTmxSVB4lMNxMULK0d6tpbgRbV3xeXDpPA0haPxJc8o3q5q3P/TDWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7745

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
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 53 ++++++++++++++++---
 drivers/net/ethernet/freescale/enetc/enetc.h  |  2 +
 .../net/ethernet/freescale/enetc/enetc_hw.h   | 14 +++--
 .../freescale/enetc/enetc_pf_common.c         |  3 ++
 4 files changed, 62 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 3137b6ee62d3..502194317a96 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -143,6 +143,27 @@ static int enetc_ptp_parse(struct sk_buff *skb, u8 *udp,
 	return 0;
 }
 
+static bool enetc_tx_csum_offload_check(struct sk_buff *skb)
+{
+	if (ip_hdr(skb)->version == 4)
+		return ip_hdr(skb)->protocol == IPPROTO_TCP ||
+		       ip_hdr(skb)->protocol == IPPROTO_UDP;
+
+	if (ip_hdr(skb)->version == 6)
+		return ipv6_hdr(skb)->nexthdr == NEXTHDR_TCP ||
+		       ipv6_hdr(skb)->nexthdr == NEXTHDR_UDP;
+
+	return false;
+}
+
+static bool enetc_skb_is_tcp(struct sk_buff *skb)
+{
+	if (ip_hdr(skb)->version == 4)
+		return ip_hdr(skb)->protocol == IPPROTO_TCP;
+	else
+		return ipv6_hdr(skb)->nexthdr == NEXTHDR_TCP;
+}
+
 static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
@@ -160,6 +181,29 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	dma_addr_t dma;
 	u8 flags = 0;
 
+	enetc_clear_tx_bd(&temp_bd);
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		/* Can not support TSD and checksum offload at the same time */
+		if (priv->active_offloads & ENETC_F_TXCSUM &&
+		    enetc_tx_csum_offload_check(skb) && !tx_ring->tsd_enable) {
+			bool is_ipv6 = ip_hdr(skb)->version == 6;
+			bool is_tcp = enetc_skb_is_tcp(skb);
+
+			temp_bd.l3_start = skb_network_offset(skb);
+			temp_bd.ipcs = is_ipv6 ? 0 : 1;
+			temp_bd.l3_hdr_size = skb_network_header_len(skb) / 4;
+			temp_bd.l3t = is_ipv6 ? 1 : 0;
+			temp_bd.l4t = is_tcp ? ENETC_TXBD_L4T_TCP : ENETC_TXBD_L4T_UDP;
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
@@ -170,7 +214,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 
 	temp_bd.addr = cpu_to_le64(dma);
 	temp_bd.buf_len = cpu_to_le16(len);
-	temp_bd.lstatus = 0;
 
 	tx_swbd = &tx_ring->tx_swbd[i];
 	tx_swbd->dma = dma;
@@ -591,7 +634,7 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_bdr *tx_ring;
-	int count, err;
+	int count;
 
 	/* Queue one-step Sync packet if already locked */
 	if (skb->cb[0] & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
@@ -624,11 +667,6 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
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
@@ -3287,6 +3325,7 @@ static const struct enetc_drvdata enetc4_pf_data = {
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


