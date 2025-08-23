Return-Path: <netdev+bounces-216235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390D0B32B84
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 21:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0A817A4D69
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 19:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA4E1DE8A0;
	Sat, 23 Aug 2025 19:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TNibGEjM"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011012.outbound.protection.outlook.com [40.107.130.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC12B11185;
	Sat, 23 Aug 2025 19:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755975713; cv=fail; b=SNerPoxBGd/x2Ui1MRbRtE0LT2t6HZUqwQOL64Q3JdzZo9gflrO/lfUcEes70XsH492yvTncUy03LEduQ1OoOUWbjoNtEjYb6LituVOG3ae+GNAcovbM1y16xQv90EqbKc1veEEUOGCko0QHqpeKhxCJJgxFZKAXNG40wR4FObE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755975713; c=relaxed/simple;
	bh=1SZHme3hB+DStt0HfidHCBbweFFEOMR3dcV3mQHDy1M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Q1dWvDvTAZAW01fCLKa2tL7RlE/xFcS1V9X6Lq/IU24UWERCPogObhH7Dl1D/yLWSHaEqCi7KCdPGG12lLicImXYkUZfm3QBdS/YmoMyztM9g3lyok+2aIgXXTa+/+NEyCAYxGNAOE/QQ8fDS1cmREYeB5X1ZkJjyy1nI5qa2pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TNibGEjM; arc=fail smtp.client-ip=40.107.130.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMHIXbQLYjC4vL03TPY0J3XinIcWPr0JzvkSZ9qPW1c9ERIxF+YkcCxkW2Ph3JXyXrBYLX8GYJItN7X5dnnImx2Hv2KP4xgE1/N/sg8oJrDL+agJnrnojN+pAIc2BpKzN/3UI37O7QVqLDFjZcVettVkrBqS3qb6ijibFgWmXhLHJyBafp5Id7C0bRdT1w2yH/Bk499U27AciLtDHlRzIgIsgQk0BQw1gIYpXYqoRgcvTEAzt4TqeRitnDHcvlIymhnCw9Lrcb54FBdkx8+33WCGd0If5kGoUbfAzv4JU5lppnsvGsGWkoB0HY2u6s0vWdQ5n4h/+7WMkDKVdQb8CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0R9bSMwoILJ3yYaEagTZHKU+5/nTWhe9jwdEX0mos8=;
 b=gQLpZMFGSQZQ+9SI08ayRGHDHLMTbClRCSy11C8ouAHh1nZ9yZXKcP1Rz2SI2Ibr+BLlFmj8WH800obifVDNt6jhWKex0cSjFiCCyjef2mXD/yZel4RBnxnlD/xw/j7LbyKajmbj0t+b+XD9TBQKicjdnCAcFVE2n0uxqNVRvFMXsO8Od2ZOgX9OT/414V4wPv/tc23vmya4IOam6wgWFQiEC0uToVV4Qf1gOAZilMOryNL3q5VND573tdt/xg88NPrP8bkYPmN/Eed1sW58PjBCWnMfTm5h6Hp85VmiZz6sScBhU3EWpeeOIEWI4/2qADlb8+A8l+TDP3jwP7CcHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0R9bSMwoILJ3yYaEagTZHKU+5/nTWhe9jwdEX0mos8=;
 b=TNibGEjM2cM7zlGWEUcYFrED1ZZBqwBuUeSVUTWB2vQkEdXbka7yiLxmOkX7Y0yKx7zstYBt6Np6U3EP8kxkLtSDN+bYMw4q9fXDR5zzTn3VdzX5wW576tWm1AlTBPkHtPMVDkyDR+jpOvk0gcxvAvSJLCceABYAVmjkbdQ9dmoR2hFTz3qWkXQJJoghusvrqTJyEqWSvqOh9kv1dV7G84P0cFGd1u5bREoi6H+e0e30TlCPMzpTXakwVkh6ge61T1QsGhaSuo6izF0DfAvdbrfnixYFCxxnpWvPWIcfsfSIlHyzB3Fsigqkq6vlTK1bE5DyV53ZAHfL9HaFLmAk5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by PAXPR04MB8301.eurprd04.prod.outlook.com (2603:10a6:102:1c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Sat, 23 Aug
 2025 19:01:47 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9073.009; Sat, 23 Aug 2025
 19:01:47 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-imx@nxp.com
Subject: [PATCH v3 net-next 0/5] net: fec: add the Jumbo frame support
Date: Sat, 23 Aug 2025 14:01:05 -0500
Message-ID: <20250823190110.1186960-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0001.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::15) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|PAXPR04MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: d96e5650-7d4e-4829-4700-08dde2778241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DVgnvXNnwaMikhj8GT8T+MMDJT0LHfE+n6SjsTx8lq2bfAYaJOlvRGjr+Vax?=
 =?us-ascii?Q?mGqbtwOlnRLBqDNwZV9foEhr5TvVGPC0CyUsH+LHDthZs5JZADTJaMTFY7LD?=
 =?us-ascii?Q?kgRS2RxDqEFuKWLkBdBm1ofZU58u7Zn7s+w49ZFB0RakbFREVksJPR5xfEsy?=
 =?us-ascii?Q?40aodV/mWJ69bgDzmB+tGBPutRSNyoVrODkxkfcKzuz29iBadUc0xs9uE1qc?=
 =?us-ascii?Q?I9evRaPeT2Vfzb5AmivDc9lHo5g+RIRcdNN1xzHtwgyAJUDEUuJWHiRVpUus?=
 =?us-ascii?Q?AS0wlP6VgNOel3HApzaYTkx/P6IYkaXdrj8/IYrFxoP3tzLaoSn+BDaFERt9?=
 =?us-ascii?Q?T1uTCuxo0nhIKt/m4vdh+DS6C+kcm97WPfvqFjrqhmWJZGy0igtbNw/xatvf?=
 =?us-ascii?Q?swfmHIX4Cu4E7Afth683GqvKz8nL9estCGOJIEGQg0VI7qAPePKoIwlhXJBR?=
 =?us-ascii?Q?tphIs2Gyy+9NwcrpjJyGrEzJf61hP9H/xRBd/LKB3sSHy9FdJ0CP/hupZkSG?=
 =?us-ascii?Q?NWJzKsOrcf/t9uCm4CShh+C5abSTK47WoBz11+2L73+g+YFNJl3T2Qa9WNTB?=
 =?us-ascii?Q?ZCC4fltxXNaYeLiJ+dyCVwrydLC2HMY1WLtvnCOZs8OLbhdtntkVLDXuQUts?=
 =?us-ascii?Q?8omRBFlWBLVl8fsTLpnncPNd2qToqXjepG9fMwFKGN64uUfM7BhYeyI6gOg+?=
 =?us-ascii?Q?meSLur199/BVPeWVibw2IvLadhS6bH95076uW9/vYZB8v1RsS0mnqo3CSPjO?=
 =?us-ascii?Q?xcQeC54StMIKO59N3YWOmKF+LA9tdEAF8PRSy1s5Kw5B6HXExSWjmadZaIHD?=
 =?us-ascii?Q?YotPfViLzL4GnJaAJuu3U5Ldt+U2ufaivE6qpWzLaiTPBR+a2vF03eIEgnJZ?=
 =?us-ascii?Q?W/SdUfrbnD6BYMpO8WH8au3xgJ0QGpvecojbvYtqwTB/L/QS6S+ivPtZAmZh?=
 =?us-ascii?Q?KURNoF+h2YUbdqCq+IC6mLzY6169UwW1TEUeY0K4TbwrIj9cAMuHHH+8pn+c?=
 =?us-ascii?Q?gEqO/ldFqek8Khv3w6R06Qt9SHbfKMo2tm0Bn7WbX2LGOi0a8dsTHa5We21T?=
 =?us-ascii?Q?vTVduk+Eg/fygx0/+iF6MoyXTrgYldcH+sfU/3wilZ1WH4mC3BaUqomqIQ4P?=
 =?us-ascii?Q?rdN14TCSrFGXFrRLqbKew5vYgM8zIVdH6I0PG/V4hy9uuB8UDn7z+fRkaoWw?=
 =?us-ascii?Q?6m7HuqnNKv3x0bWXILeAaROKx69jGqBw8FxMr1g3kTZpxa4iMvWVSDb8nJJd?=
 =?us-ascii?Q?1lrazRtOnoSZ2m5O5RQ7Ng41oQxvalV1oe7w9Q5lMq2nxt3VADyK2WzCH1aJ?=
 =?us-ascii?Q?Imzo8j7vYlM+3etSVjXXw6j+q4WF7TMUbI7Wt2X7A3dQCJZaZTK4DrOQwvvo?=
 =?us-ascii?Q?EfF8wdHB5L/QyDQ/r1UOlIaKqD5co5onVNaYph20r70NSxfg1dP/s9sZgBPT?=
 =?us-ascii?Q?FFDc8dnuHq4nbEjHwrF2O+7gjjEsitdMDMOD7XShlKlEAR/UeBjhWvqOGoLQ?=
 =?us-ascii?Q?klPHGSAkyNntAqk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QjHtgMu2hsTYgbpXx32p2m0bZ4N1RE1zXgsqDGfw1o0kxCMnVpZjXBo9kZj7?=
 =?us-ascii?Q?RN9+No3a1t9/B0g9UyTrgZmH+ahyjZ77J6QtnAvWLY4qlknqDOH0LUMZ1f+m?=
 =?us-ascii?Q?bVfkBH65IYXoq1xuaWh8031gPoJof5sjBqMXTIpTmkteRX6JgMuJuvvOeAlu?=
 =?us-ascii?Q?tKyx6iVCw7+G8gusbYtQuqt0aEjc9dihH8Tfn5SE5JiysHTg2G7Vlj7AH1hx?=
 =?us-ascii?Q?rfYwQkxX7n+/auhIH7aUySAEQ9Lr782gOfB2kxExgSvz8SKJ0Z7j3lSoMcG5?=
 =?us-ascii?Q?QCGSCjFXhe44j2YDVTxv6MMX7icxKRP8jbNGurXD7VUImEO4mWfi+g/cRSgz?=
 =?us-ascii?Q?mhNAqKYjklm/CQ61HQeuPC1hNi/JC0tCDbH8ysm7DifY3bO3E1sLT1K7T0Ln?=
 =?us-ascii?Q?UcR+ubN9sPt9WLFKJaKO+LaOFZL4vwpL/xVxHh0+J0ve1JvkzRM0UHarUPyU?=
 =?us-ascii?Q?ip5Z8DWcCAR0BT2IKr76l1fuOQXSc6W+/v7YQENpXqmeV87+MCT6bXiWE2G7?=
 =?us-ascii?Q?Rh8+bYos5p7/A8Mt8BDikRBWf1o8Nvxf6rHKcwHQK2XhJeL3EjCOYCQ6ecJq?=
 =?us-ascii?Q?D13yO3XZgtDmA/XxYXyw44/gaX/2F0UlSIQHpLH832Yel1pZ44hZ96k+gDCS?=
 =?us-ascii?Q?q1sXbaobHp6B0vqKXbdW9REdVJ+gdTtvvBUZg4vuOz5rIVi/SUWLWrEvtLdW?=
 =?us-ascii?Q?dHF+YzMRk10pLXqmcViNtMM3GqlhK9QsJw5phmLerdXfMQym8AO2vnDiFxpu?=
 =?us-ascii?Q?iz1b/aFMaeuje233OCWWESADn3GtdhZvK/U9fQn6X7S+ekeWBLor3HRkDGtR?=
 =?us-ascii?Q?o/1sIx56MdrwKPq+Ulq1B6tH10PXU6DXqBzkR2z15171msE79pJAf9kuh3LK?=
 =?us-ascii?Q?WQBbR9W4o0sdQvKSHxHztTu1tO3qn4XSCHGW4qG1gsfzP52++NbMz4bGFz4o?=
 =?us-ascii?Q?s4B4fB72xGV94Dx8zT87EcaEbOmfWEXbFp/Z08puGweIEraFleRZXLG9T/s2?=
 =?us-ascii?Q?s6Cx7z7bVLgNqxqUXeie/YUBqJksb/ABWP3vj5QnK2Cj9f5IyaNtK6aQa46P?=
 =?us-ascii?Q?wKrlu3ct96hQOV2C3pvWOUyVR4vTL0ufI6VOeNp1myjoyIy/wpQ5j+cekg3I?=
 =?us-ascii?Q?ly7H1BcGk9Wbmj2Hr0nA3zGj6p8sVAxBgl+zVVGFKPAphrvJ5LFzYmFkEVM5?=
 =?us-ascii?Q?6y8kLUUrgHvjACCQDozmsE4eUMHfZmnjoAMhlWGzqPR/09h5qTEcjNzL4tiA?=
 =?us-ascii?Q?NIstmy3zjFIDthk093mlP9204PnuQ//8beF5/+FgMluZiuoTUbInltRDVE6y?=
 =?us-ascii?Q?w4RbQuB0Zb4E8uXB/M2mOPWVZyLj32WlCsYIRKQDofFHuRqh9xq+juHfH0rl?=
 =?us-ascii?Q?vYxf/unSjPxm0tZ3xLzt4XWKXiyBY7vHTC+nwIcNLi5tw3rigEENH8wyB1/A?=
 =?us-ascii?Q?7HoFPnysR/VvfFm0PEuqx0P9KvVL9uZ2jPicu+HfcxMXP3NMfufBmsJMrryd?=
 =?us-ascii?Q?Dulu1D5u2wEBvtT26vAiNbFaRNWiUrth5lni/Y5aJXUQI2qFOnNAXpXckfgD?=
 =?us-ascii?Q?fragoAFMC/gxnagq9x0Ce0Z4BcLJ7+NdXb3Xtf7i?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d96e5650-7d4e-4829-4700-08dde2778241
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 19:01:47.4674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6EfZ48/Wuhe6czz5nfOOkv2j/+JqDdNb6qVxU+PQ60Ty+q7iQvH/SvCkmicdTeE1EWMfOhZaJp7Yp6OBMc0f6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8301

Changes in v3:
 - modify the OPT_FRAME_SIZE definition and drop the condition logic
 - address the review comments from Wei Fang

Changes in v2:
 - split the v1 patch per Andrew's feedback.

Shenwei Wang (5):
  net: fec: use a member variable for maximum buffer size
  net: fec: add pagepool_order to support variable page size
  net: fec: add rx_frame_size to support configurable RX length
  net: fec: add change_mtu to support dynamic buffer allocation
  net: fec: enable the Jumbo frame support for i.MX8QM

 drivers/net/ethernet/freescale/fec.h      |  6 ++
 drivers/net/ethernet/freescale/fec_main.c | 82 ++++++++++++++++++++---
 2 files changed, 77 insertions(+), 11 deletions(-)

--
2.43.0


