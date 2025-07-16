Return-Path: <netdev+bounces-207392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A042B06F99
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 09:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65519580DFB
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 07:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C9B2BD5B0;
	Wed, 16 Jul 2025 07:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RF2le/rf"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011054.outbound.protection.outlook.com [40.107.130.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EC229E106;
	Wed, 16 Jul 2025 07:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652306; cv=fail; b=SMRZJfzsyicJZzzwLkF8tt0+4Bw8mYUqUqVbqwY8DzeyedVBTYShKFnKrn+HBWlqgI3Tr73gz2rHa8djzhQIksnB5VT50vDbZNjJhcsPsFG0DZwS4NXQhgSaPoLeXBiwGzGUGr43TTJ1i12zCwRE2p/HZthKt2VwXBP3HMwFecA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652306; c=relaxed/simple;
	bh=VqGVb0Nq95oQKi7eU96BzFTqD1HdXVZM39g1MQ6Mvjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JxHvT+QEvyQuOBy5V45dG08K9NejWVd321ivtpYj/IKsjz+P8iM0UDzenj3msw4VH/u9WiT8E/6NvbxUvmOh96wSYShaPYa54uJa66wqdyeqNiDcS/+uY58IF8VOWlSXlogozlQKBYjOAjoLxaOa4zL8iEFeGwy0v6UyrTFXF8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RF2le/rf; arc=fail smtp.client-ip=40.107.130.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0cKaDtvijl7URWeSojhZSRolQaIaErvEUNwJZeJdgPtz4eFeXpNxgwuKE7TAMYAl9bXlPDuUzxzkyo67IZod15swSrEOrAM/RZaByZPUr/QHMMFQ3xnKxoRZj1bx+pSYk/ckXiyWw6Hky7YvXayJ9cxZboXz0pSJyk/YLv0b1riTviAVzW3uU3YI8YALU6dIxKhyHLMZKIcdmUR+qFvtXjL05U2cDqzZj2Os1riryehTAQk3TCO96Sud/AuKDRjUTmJnGIFAQ8gq4B+lZG+A/VZE0fvuOYKV0UK8dF/z3RpEvQ08r1rk3v1xpljOXewR+wXAjYt3pvTZo+fuR6kKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgl7rToPV80qBdMMITU/ctL2+BuXpGpYF6t9odlSOs8=;
 b=g/tZjUvCA9iq9gUXxyCYbRsdKWi3IKLeyUxKsyXioVNAMhXsvllir5OQTFH1zPS4ByT1TmkwBiYDnL3zOmOu3V5dfgpcHOBkWMj8/VicMiDSATYb3axXPnc8GkQRKqIBWnK/GLtuVGWCc51aUQ57+ncRZbKE3lsoo87TUF29f3Une63rUYkBs9CZhcbgBtDHg6ratXBDEHhPDnnC1cNKFHJiWWNtKsAmPFBoRToOPOiPCFZBT6c35ADgrcWCpv2QmsmDPhcnu71zJGCNCvbrQgPLVOGfgipi0ZoIt8ORnmA4SzWQkxXyZANV9HTXq4Qxn39MEc0bu2xuAqPrlKs9hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgl7rToPV80qBdMMITU/ctL2+BuXpGpYF6t9odlSOs8=;
 b=RF2le/rfJxSOhBobR/2tsYqKjBZZ4Y5/aDnaND5KEIb5ucWBqu5HP566VH2bA/KY0ZgwghQoxQaxODdu5DBNg1jf/f7EjhdV2+vx9gtBxXF7S5u5mhhTiEnSyQBz38xSRNfIMRsOlQtl/Gz2O825na0WWHpc/tVoP/hc+UlOR4nJlEqvkiYHO051Q52SfPTZh90bWXOT5twWr6/y0SUzfsQQD56c154nPsX92aS6r7gQga6CcYzsxmd6I74YMR6bZ2eMkneMw2GlwpcPow+PJWPzUHbeGRRe0CtVNXcv1U+rgAqsZhJA5v9/NLJftvkYiIKM97mAAdymS8Obno0YBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7708.eurprd04.prod.outlook.com (2603:10a6:10:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:51:41 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:51:41 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v2 net-next 06/14] ptp: netc: add external trigger stamp support
Date: Wed, 16 Jul 2025 15:31:03 +0800
Message-Id: <20250716073111.367382-7-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716073111.367382-1-wei.fang@nxp.com>
References: <20250716073111.367382-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBBPR04MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: e38049a9-b0d3-4a35-6821-08ddc43d99b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mLFA9Z/DghMqhwfGuWKTl4A6sO3mfTvY4tLn0Tjx/hxx3kiQlDlbFdIXL6kw?=
 =?us-ascii?Q?Zki1cXM6ApfhVCM5gclWU/21uP+lyvxOqJvK84t8fw0tswx59O4Q5wc6MGps?=
 =?us-ascii?Q?zZQ0WXKuz6xqmDuzzxWvW76Q2gfq938LBh6oo5nfri+9Fya2tInSAc8agtxx?=
 =?us-ascii?Q?YVWJydqQPL4eQYtdy51m9PIPRGy3SV64zmNxfNOA9jY8EeTZ9X88H64S/Gb6?=
 =?us-ascii?Q?TGcA5o11kB2M8BSkfxeO6CQRX2PTT+YbXtkrMtWkZYYiDki8pZ1kFy17Tp2D?=
 =?us-ascii?Q?9RUeaGXjiR/MmoMFntrsl7Zw+l/agWXE5LiKIe/q/U+IzJBgQFGl1fIEkBeH?=
 =?us-ascii?Q?4A57lOQl1txtOz6RglXhUHjj0WcDRPuo8fMpLE8G5psOilnr2ga5sjur+W5K?=
 =?us-ascii?Q?3MwsAl+RqviBrigghF42u5y4YoQchUrPm2vx0fMjk8cxs+yHElz4Y+Ax4vD4?=
 =?us-ascii?Q?k+QWva/+HR14c+rB/jn1Xrkr+KZRMXveWptBhuqtxznX118Q7nzXNmrxs36T?=
 =?us-ascii?Q?rzgtj/Mn2WtEQC9x/jx8Rj2k+LrTQHzY72Hpsbq1jSO7u71NXqrqWuP/oPVZ?=
 =?us-ascii?Q?4TE4EzgIgTEm8bcWZTnIEgKRFYkL5UxbmpGJXDVGvJRe+GMhTFkFHhv0/AI6?=
 =?us-ascii?Q?EQ8o8cTvH2O+eLpc0v0+RLpwc2kqj6ukMZO6QP9YkEgy0tZyBpm0BKYATubF?=
 =?us-ascii?Q?eElQB1fKHHOecVjzbRoc20jqjRtO9W/9I9mBfh3plIpZhCadX6dIHfKDbeiv?=
 =?us-ascii?Q?pC6Fv9AsGIRUgKh3MXEWdyMwIZ0mt1t24UFtk9tlyY21AwAGzt4J3U+o0J8f?=
 =?us-ascii?Q?9+Dfy2BNbjFN0VEmC/+KB4qVgWi9/a60qkcarTx2EjeEmuaBgh5gEQSzYVJB?=
 =?us-ascii?Q?j6eg1WOb/VpD8YD0dLx/iruoLkG15jDWHB8EAIZaqmNpgN6j26evlROHQnK+?=
 =?us-ascii?Q?vZv1iMUJML36rbxD40ixcke4hlgBBbPiKn+7FOPXQMRqAL45d/gwuc+HmFau?=
 =?us-ascii?Q?IXu4jhMWG4Ki2pmy0xAAkdyO26xcX0Iv65ma+BPIOhZdqa+OUk6Qg5mbBIIn?=
 =?us-ascii?Q?MP24iZSmCFG1tqQlAKr/qlE4PjzAxSj3KUwWFZY/QCTfVCc64yYI51mAVztY?=
 =?us-ascii?Q?as6lx0INC/iwqfsIL+xgMgTc3yGCxa6H95Lyi+p5cEickRoxRFbatuGgjwgr?=
 =?us-ascii?Q?v9krUqFvqY2mCqIJgEh9NjuI2YQS1izXvs9nby5z+WCmSAuZy1FK1rRnqPxE?=
 =?us-ascii?Q?HaLHej1XWI0QLqxtMzw54diJ8gcC4j+KC8LUnv17gwW1+W8CbqKiik1JexJe?=
 =?us-ascii?Q?wYJV7A78a/G/ezUa+LElc05S25k4K1n4CDGu1ziQnVxhTcLxI0G5Eos/HfZ9?=
 =?us-ascii?Q?Z63Cjqpg1B3rZyNyNFzLBW5CGppbr5uLvUhyO5lRC17MER8vycvWEFTnMYH7?=
 =?us-ascii?Q?fDuBoK6ntbJ5UQTTPLfAiv0+usGPSDHSQK0P9sfbvZ84PSmNyREIcsZfen1y?=
 =?us-ascii?Q?vXB4CJReC02RZGk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZNAq3sLcpd8+zr2vVlUJJmPsYZ8uJTc/wJZLaS3x6Kdtpciw4kkChHjTjkMc?=
 =?us-ascii?Q?Ces7tjmBqkYaGLfXebd1b6jMBSTNubCjADvkWBQEZwq44h/W71Z/gfsrwUw6?=
 =?us-ascii?Q?wSpsw+Udw3bkBp+yWmMyLLn9QuU4Dm9/CA5TGSAAK8qool4G8zJo0XKx3h4G?=
 =?us-ascii?Q?Siv3GjID5mZkP/b0dVssUQBeXcqIleXqeTQfpqq+g8oD8JYf1+BfLRu/roKs?=
 =?us-ascii?Q?B2yTUwK1T9F6FrpDw+VhJYIh7imwWPu6J3dtZu2zMXyzhG+18nQ9EzMaa49V?=
 =?us-ascii?Q?uOD4lq+KrI80UV8rLAeOfA5UnP1YYqHarGCO5DDAGdHSkhjTBqKZ0+9Jdxz7?=
 =?us-ascii?Q?hQXmQ5vvQxGuBeJmpZ3N7ClHpg24CiG11/Lhsa7BD2M15h/ZulBGvYdXyZpw?=
 =?us-ascii?Q?11o1vJ+HPC4dfz3mxbCCEMBHwdEehoEP0bCPU11PLzLi4jpAXW4cma7rsPtg?=
 =?us-ascii?Q?0fw6odwLZRBNkeezVIHwRC8OXP72tNaHraPJZKwYQ6YEvECKkZa8LoEeX9By?=
 =?us-ascii?Q?otc1Xvvv1Jrl1NAcZkh3Z9PnhIHhV9HiNNDMdnRMAHnFAz82mmUr0LAOdIX8?=
 =?us-ascii?Q?pJJTHz+rER4EqtMSLSBckP9BKPkeZzwhckoziCJQ0u9jFiu8T/h5ZIX6ktM0?=
 =?us-ascii?Q?wqbIPoxondXpn0i5yAYjLeJb+hympzIb9d9JS4Fy4iFwfjx6+pXfLcIZbLRu?=
 =?us-ascii?Q?Gd8SGbkQwOD+3rU39TIxk0UEVf92bwge+NjbO4fP/TUNbhAcsVLsHAYwTKwn?=
 =?us-ascii?Q?giYVw9hTap9zmhVV17VaYzvuhY4J17W4Qz1X/w4vFBbOGDi5AsO2MbtQH3me?=
 =?us-ascii?Q?pA6MaHowvxU0+JVbONxOwAmYaYXW7TLEwPgHqjK3w1NRB0+kMVVALqgg9BE5?=
 =?us-ascii?Q?UuZY7iw0s3f5r64JMaUrDnUGOb30mXmCKxc+9nQL49xnsHMriOjwg5/i1nI8?=
 =?us-ascii?Q?N84b3Rh0dCJRcmMi8RmDitmVWybiZoBTxJxoo3a4hFvQ8ly3cKAlT4vabjD/?=
 =?us-ascii?Q?+ek5DBZDeAFfrfdHCT9STvg2C0YpldTOxL7mO5lnogPSaustL5bB5adaf7Yw?=
 =?us-ascii?Q?dx6JkQ03x8uqG+sw0V9niBdspluGEKrzIZn6thBuCWS9X+/s01QXP49FMoyH?=
 =?us-ascii?Q?tmzsiDEKYMro5Po/ii9SFW3W8TbNGBQ+oYX66mY2sh79J4RijHYuICMQS6mf?=
 =?us-ascii?Q?7JIBZX7xaMC4G7OONPHFSvBe5Y2ezYveyxP56G8f7I0fDqEIf9ntBfBPvQnD?=
 =?us-ascii?Q?cvhuSkgJ37UZQN+if7Gv88ib/O7o1sbLcqP6jpsIgBUWBma8iOFUFkAVn30Q?=
 =?us-ascii?Q?QGlqKn84Nb7fKDQt+qAw2hJT37CLUkZ+4Ca5bn6xIv1uh5DObXP5XXkgw03q?=
 =?us-ascii?Q?DPVqyiU8yR6YVQU8OBMKuIYnfCVedT65kIkjpvyjTb4jSgjBfpXQnGMpYw98?=
 =?us-ascii?Q?iPwkxf5oNd61NxnaTCj0Ofx0nuesgld7G+zNS63w0/FeyIlnunQQhfVDR+J1?=
 =?us-ascii?Q?N8MeCSacVH+cvMm9SioCTKfW8+xX2CunP8HQVlNAHhSZUQCw09Oj4ulV1fVq?=
 =?us-ascii?Q?wrABfIfBkb/TgiKEVaW/wzTPgVNG6qoG10fY0K9n?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e38049a9-b0d3-4a35-6821-08ddc43d99b5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:51:41.0646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ki95dq9Xd+8ZTvB1ixwTWtPhqC4El53y0Mj0nt17TH1fhyv2X1mIa0gibat0ahi7vdpT8hdx2c9HJ4tF55WeTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7708

From: "F.S. Peng" <fushi.peng@nxp.com>

The NETC Timer is capable of recording the timestamp on receipt of an
external pulse on a GPIO pin. It supports two such external triggers.
The recorded value is saved in a 16 entry FIFO accessed by
TMR_ETTSa_H/L. An interrupt can be generated when the trigger occurs,
when the FIFO reaches a threshold, and if the FIFO overflows.

Signed-off-by: F.S. Peng <fushi.peng@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/ptp/ptp_netc.c | 118 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 289cdd50ae3d..c2fc6351db5b 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -18,6 +18,8 @@
 #define NETC_TMR_CTRL			0x0080
 #define  TMR_CTRL_CK_SEL		GENMASK(1, 0)
 #define  TMR_CTRL_TE			BIT(2)
+#define  TMR_ETEP1			BIT(8)
+#define  TMR_ETEP2			BIT(9)
 #define  TMR_COMP_MODE			BIT(15)
 #define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
 #define  TMR_CTRL_FS			BIT(28)
@@ -28,12 +30,26 @@
 #define  TMR_TEVENT_PPEN_ALL		GENMASK(7, 5)
 #define  TMR_TEVENT_ALM1EN		BIT(16)
 #define  TMR_TEVENT_ALM2EN		BIT(17)
+#define  TMR_TEVENT_ETS1_THREN		BIT(20)
+#define  TMR_TEVENT_ETS2_THREN		BIT(21)
+#define  TMR_TEVENT_ETS1EN		BIT(24)
+#define  TMR_TEVENT_ETS2EN		BIT(25)
+#define  TMR_TEVENT_ETS1_OVEN		BIT(28)
+#define  TMR_TEVENT_ETS2_OVEN		BIT(29)
+#define  TMR_TEVENT_ETS1		(TMR_TEVENT_ETS1_THREN | \
+					 TMR_TEVENT_ETS1EN | TMR_TEVENT_ETS1_OVEN)
+#define  TMR_TEVENT_ETS2		(TMR_TEVENT_ETS2_THREN | \
+					 TMR_TEVENT_ETS2EN | TMR_TEVENT_ETS2_OVEN)
 
 #define NETC_TMR_TEMASK			0x0088
+#define NETC_TMR_STAT			0x0094
+#define  TMR_STAT_ETS1_VLD		BIT(24)
+#define  TMR_STAT_ETS2_VLD		BIT(25)
 #define NETC_TMR_CNT_L			0x0098
 #define NETC_TMR_CNT_H			0x009c
 #define NETC_TMR_ADD			0x00a0
 #define NETC_TMR_PRSC			0x00a8
+#define NETC_TMR_ECTRL			0x00ac
 #define NETC_TMR_OFF_L			0x00b0
 #define NETC_TMR_OFF_H			0x00b4
 
@@ -51,6 +67,10 @@
 #define  FIPER_CTRL_PW(i)		(GENMASK(4, 0) << (i) * 8)
 #define  FIPER_CTRL_SET_PW(i, v)	(((v) & GENMASK(4, 0)) << 8 * (i))
 
+#define NETC_TMR_ETTS1_L		0x00e0
+#define NETC_TMR_ETTS1_H		0x00e4
+#define NETC_TMR_ETTS2_L		0x00e8
+#define NETC_TMR_ETTS2_H		0x00ec
 #define NETC_TMR_CUR_TIME_L		0x00f0
 #define NETC_TMR_CUR_TIME_H		0x00f4
 
@@ -67,6 +87,7 @@
 #define NETC_TMR_DEFAULT_FIPER		GENMASK(31, 0)
 #define NETC_TMR_FIPER_MAX_PW		GENMASK(4, 0)
 #define NETC_TMR_ALARM_NUM		2
+#define NETC_TMR_DEFAULT_ETTF_THR	7
 
 /* 1588 timer reference clock source select */
 #define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
@@ -450,6 +471,91 @@ static int net_timer_enable_perout(struct netc_timer *priv,
 	return err;
 }
 
+static void netc_timer_handle_etts_event(struct netc_timer *priv, int index,
+					 bool update_event)
+{
+	u32 regoff_l, regoff_h, etts_l, etts_h, ets_vld;
+	struct ptp_clock_event event;
+
+	switch (index) {
+	case 0:
+		ets_vld = TMR_STAT_ETS1_VLD;
+		regoff_l = NETC_TMR_ETTS1_L;
+		regoff_h = NETC_TMR_ETTS1_H;
+		break;
+	case 1:
+		ets_vld = TMR_STAT_ETS2_VLD;
+		regoff_l = NETC_TMR_ETTS2_L;
+		regoff_h = NETC_TMR_ETTS2_H;
+		break;
+	default:
+		return;
+	}
+
+	if (!(netc_timer_rd(priv, NETC_TMR_STAT) & ets_vld))
+		return;
+
+	do {
+		etts_l = netc_timer_rd(priv, regoff_l);
+		etts_h = netc_timer_rd(priv, regoff_h);
+	} while (netc_timer_rd(priv, NETC_TMR_STAT) & ets_vld);
+
+	if (update_event) {
+		event.type = PTP_CLOCK_EXTTS;
+		event.index = index;
+		event.timestamp = (u64)etts_h << 32;
+		event.timestamp |= etts_l;
+		ptp_clock_event(priv->clock, &event);
+	}
+}
+
+static int netc_timer_enable_extts(struct netc_timer *priv,
+				   struct ptp_clock_request *rq, int on)
+{
+	u32 ets_emask, tmr_emask, tmr_ctrl, ettp_bit;
+	unsigned long flags;
+
+	/* Reject requests to enable time stamping on both edges */
+	if ((rq->extts.flags & PTP_EXTTS_EDGES) == PTP_EXTTS_EDGES)
+		return -EOPNOTSUPP;
+
+	switch (rq->extts.index) {
+	case 0:
+		ettp_bit = TMR_ETEP1;
+		ets_emask = TMR_TEVENT_ETS1;
+		break;
+	case 1:
+		ettp_bit = TMR_ETEP2;
+		ets_emask = TMR_TEVENT_ETS2;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	netc_timer_handle_etts_event(priv, rq->extts.index, false);
+	tmr_emask = netc_timer_rd(priv, NETC_TMR_TEMASK);
+	if (on) {
+		tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
+		if (rq->extts.flags & PTP_FALLING_EDGE)
+			tmr_ctrl |= ettp_bit;
+		else
+			tmr_ctrl &= ~ettp_bit;
+
+		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+		tmr_emask |= ets_emask;
+	} else {
+		tmr_emask &= ~ets_emask;
+	}
+
+	netc_timer_wr(priv, NETC_TMR_TEMASK, tmr_emask);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
 static void netc_timer_disable_fiper(struct netc_timer *priv)
 {
 	u32 fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
@@ -505,6 +611,8 @@ static int netc_timer_enable(struct ptp_clock_info *ptp,
 		return netc_timer_enable_pps(priv, rq, on);
 	case PTP_CLK_REQ_PEROUT:
 		return net_timer_enable_perout(priv, rq, on);
+	case PTP_CLK_REQ_EXTTS:
+		return netc_timer_enable_extts(priv, rq, on);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -638,6 +746,9 @@ static const struct ptp_clock_info netc_timer_ptp_caps = {
 	.n_pins		= 0,
 	.pps		= 1,
 	.n_per_out	= 3,
+	.n_ext_ts	= 2,
+	.supported_extts_flags = PTP_RISING_EDGE | PTP_FALLING_EDGE |
+				 PTP_STRICT_FLAGS,
 	.adjfine	= netc_timer_adjfine,
 	.adjtime	= netc_timer_adjtime,
 	.gettimex64	= netc_timer_gettimex64,
@@ -670,6 +781,7 @@ static void netc_timer_init(struct netc_timer *priv)
 		fiper_ctrl &= ~FIPER_CTRL_PG(i);
 	}
 	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+	netc_timer_wr(priv, NETC_TMR_ECTRL, NETC_TMR_DEFAULT_ETTF_THR);
 
 	ktime_get_real_ts64(&now);
 	ns = timespec64_to_ns(&now);
@@ -822,6 +934,12 @@ static irqreturn_t netc_timer_isr(int irq, void *data)
 		ptp_clock_event(priv->clock, &event);
 	}
 
+	if (tmr_event & TMR_TEVENT_ETS1)
+		netc_timer_handle_etts_event(priv, 0, true);
+
+	if (tmr_event & TMR_TEVENT_ETS2)
+		netc_timer_handle_etts_event(priv, 1, true);
+
 	/* Clear interrupts status */
 	netc_timer_wr(priv, NETC_TMR_TEVENT, tmr_event);
 
-- 
2.34.1


