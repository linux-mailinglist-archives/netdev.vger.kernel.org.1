Return-Path: <netdev+bounces-216240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 077E3B32B8D
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 21:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8DF75A86DB
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 19:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB992ECE9E;
	Sat, 23 Aug 2025 19:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ennRAsZ1"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010013.outbound.protection.outlook.com [52.101.84.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675372EA49E;
	Sat, 23 Aug 2025 19:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755975738; cv=fail; b=f/KxY3gkgg3CQIdhFKiZorl6c/7sSE1dseJCkeCQvaR8GJXf85eQgDG8Ha1pxLEq8PoSzLzJzhxqwjJpN14iz8HM+fJHTl8tOfKhaWxb1nVhns1j2MCw1VB97lW/HJvQ4PdehidRYrrgrJUYvEN1v30h5XGmNEplWSkskIN3TqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755975738; c=relaxed/simple;
	bh=PxSThnEyDvLOSTVZrWSJ7jf/qkfk51jC5+WEXnPyUWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bTD/LFMIxD3ccUe/YRRiBaVz1EjJOHC2CjoaX1HSK+/ytbOao88H562iDoAJ24F3RjaCd0TYoehHWWlcpBPbRLVWiKIIKBMO7QqSaJqw8A6cncF6K0XdEb+fWT9kIz0F4hyiksC08dusmRW+XMMl2OBlMkJnJhmnq7Nb8sy8g/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ennRAsZ1; arc=fail smtp.client-ip=52.101.84.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tC+pI+dOY0jsNTcccEIGfhwYXoXk05707pG1SwJTVT11trBv6tDNJD/Fp9J07HmeLoHTq217JfNvlLnvbhSgH/2FLuGWpqV30jcZPltOv0zm01JlhgLInNWUNSCWKxdp7zEgYeDochqreEu3F0pqolOoxsvrq69jwRYTzosJ22LePAoky6giyFMWonw/rGE9E4bGvARw7pYLwSSgqdJjQ9julJgJhljiWnl1bnb4Z/RdsIw1gx5WaoBHy0AOHjP7T/FN1JEe9vUX11axE8Q8q6qujNG99+mF1m+qh8ZfIwrC1O2wKM9Qxo46cGghHj6HUyeguFjBYgPQfrf5ASzJvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcKSGHXyWTugi2GB0Jl2d4pEevzdqGSNj6AJnrowU78=;
 b=Egxje+Oxa+laa25LDIlnxypGXYduW8sVQUZRmx5o0GrqJjNto/0iOR1RyFp/FwcK37OkgIf0Q+c2Q4Qqzx4m9rYuUAWSwUmmt5ySLZwVHKEQzjOjUx2ubi/y/WgpnyL/K2M8SDhocVA2cQlnbdC4sue4Qb56J0GCWfjdyDdfSuwB33CiHVUKJkjnZvZZ8TAgbPGBj8ISLHHKZG6ejsHGWXDi473ItqLayTUqjxE1L0ItWsWXiL/2/YHD7/Ox6XOG/YLWhkvvvlijjH4StSWeV64hGbumT5saqXNoQYJkoKY8fYhU6C1WyTC1mF6pnPLAx07BheqehGH14U8p2ZM67g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcKSGHXyWTugi2GB0Jl2d4pEevzdqGSNj6AJnrowU78=;
 b=ennRAsZ1KCzpq/6Lvga6vut7XRqREZFV4FMZqaW3Bwx7kn6x3DElRaUl6Lf3RMcOmeQuaHCnZV85tXoeUzgqfv18ILy6LkDC9o7dlp3m1DTF+DorcR2o+wRuucoKm5MQAMRnCCalTbJtXehw1eEQNpjmfnEc2Gy65IQaKKoPKp41EF3w1NhGAqIfGlJ/q6AX8+dLx9Se9o+xtGnVE3mFMk/UM6sY9hWCeUXeyvvCG+dqn8IyLtm35pNBjaE1Mh+O1/9HcDkk4QUiQW8pPLZ1B2wlRYaUQkUaLbk3CtyzyeVfEokD15qRmoRyGGIGezhlmjnimYAMj/mfCqff/SWLLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by GV1PR04MB10456.eurprd04.prod.outlook.com (2603:10a6:150:1cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Sat, 23 Aug
 2025 19:02:12 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9073.009; Sat, 23 Aug 2025
 19:02:12 +0000
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
Subject: [PATCH v3 net-next 5/5] net: fec: enable the Jumbo frame support for i.MX8QM
Date: Sat, 23 Aug 2025 14:01:10 -0500
Message-ID: <20250823190110.1186960-6-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250823190110.1186960-1-shenwei.wang@nxp.com>
References: <20250823190110.1186960-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0179.namprd03.prod.outlook.com
 (2603:10b6:a03:338::34) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|GV1PR04MB10456:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca83958-45e9-469f-e06b-08dde2779157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nG0JrX2x/DgkxGOgR/Flg3MvucSgb7EKbT9LNTPaqWtK5S7nzhk/xWrOe93n?=
 =?us-ascii?Q?aNgk7pKu24pwd2S2tKThX0R6P2AX5uT/JZPCV9MPFqbPXFN5Vk8Upf/G6agV?=
 =?us-ascii?Q?FH2MELgIoB5FrHSdgsN2BwMtQIHgH2RkMciFh7qrdtLXsMy0kOdMQVrIVpRa?=
 =?us-ascii?Q?w4dhExttY0ZHiZnPLFLxg85FvtgZnAi7iFaIUN/Ux34vitm6+VG82zp5GQlK?=
 =?us-ascii?Q?GUK83Xcxz51Yht+fdnRR7wpM0Fsh4utk3DAaEFBsbsYxeAbWy9FxM8MsFpW2?=
 =?us-ascii?Q?FuN6s7Ku5AdfyfplujK2aIL3F02rjdV/NYUXv30xIyChq1mOH3G4xX2oDrA4?=
 =?us-ascii?Q?4KvyLw93DdBj5JnIEZOLyGrb2B0/92ygyrI7hFFocPz0ywHRwzL9gSyuwqWU?=
 =?us-ascii?Q?6nXyakooMFfu+wt0v9bFaMt57H5LhpdhkGdH+RRq0+PxLNMUILVrLMEuZCac?=
 =?us-ascii?Q?W4b79I9RWhK1Gs5R7pOvmkY+AQK9wyMHqbwBZZOGL2Zplw7TGMW14M6zKPLP?=
 =?us-ascii?Q?jeBPy5ViBQBrfUS1VX9MWgUn0Z/XcAl1EqvG/d51piqOgvaZxCIOcmW2+xhZ?=
 =?us-ascii?Q?gC193WYJ83d9Ol70r2zZ5ZGsBpDNyBgYhZ0F96lFzQjtmUNO57qkceKbZTeb?=
 =?us-ascii?Q?7Iiz6bsLkOqcP4HaFs7zoTau2HHqQjL1FcCZ5PsT4yVLaV3zNgBFJfcYsgIm?=
 =?us-ascii?Q?FAaFuiVoDm8J2MCaqSa6NviIBH8Idybdggm+GQKXV679bOjJATtCuY/tfP1l?=
 =?us-ascii?Q?LR5PfNLD5Vi9VxYF1rE9NFolWsudKzesiUJR+w7kIr9LZVdPHZGKwCJwHl97?=
 =?us-ascii?Q?cUt1tbzOk7GIIircceFsVbRjzriQlbd9M/QuFM2QTw7s2WpqqSmGb/YN6rCP?=
 =?us-ascii?Q?Lx1L5Ce8G495ykjDfMrqeP/JWSU+stxG8Shu/WfgZUE0bj5ATg0zZfGpVhu7?=
 =?us-ascii?Q?GjHCTxDVS2+YwMmzTt9+rln4IZZogdycGZJEnvUY9sAej3yplfnhahluR85W?=
 =?us-ascii?Q?p5reAwE2vwC1W904LvikLII6xM2hg3eySMGucB4XJISfcCEeNF0WSTMVh2X1?=
 =?us-ascii?Q?qADjvbfz4kRdtFWS6p9wcg6lPNnrZV5BvqhXUVgE/LSb1v0fFIa6f4cooj4H?=
 =?us-ascii?Q?MUePKVaPDX8eukNrDqFTYlxuB11IZTkR6PNLX4VYXYbdTcZOQQugcDLQfVl3?=
 =?us-ascii?Q?JYkPJHlpcV1gIFv8Ri+eqWAefV3tVQqQ2S1xER0uzcPmD6vYPciDbtSK0N/w?=
 =?us-ascii?Q?T981iosg613en2nmL4mBDhd5RgX0V64VOP7lJcWkq9a1HBCggKFyGpnLkuS9?=
 =?us-ascii?Q?3S7oNkdaVVMHdu9xm0DTPTPW61Uj/6n2ndHCyNUpKzY/9+7vZCWL0w/FddmA?=
 =?us-ascii?Q?kUYt5L0xts8VuBnYIwLYFQesqOeiH1W56NPP4N/ZXbPCoxPbexvJqIN9NW7t?=
 =?us-ascii?Q?qx5pWQvxH7E00YfWDygYnKl8QZ4Upa9JK5xq5SjHjz+ZBX5dNTxF13Id/e5I?=
 =?us-ascii?Q?lF4dw07kngoF5cw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cMXl2E0ErPS9MjCjAbcjWeZg6FbpIMKK3RItGbfMUamzk4ZjnUNoYDe0QxJg?=
 =?us-ascii?Q?HnFGwQNcn4myW/HNfBKVb+DUfRd6Rhptjq23+SbbLUJhbySr6Dm4fpeI9pki?=
 =?us-ascii?Q?H5nXEwZ9XK6a3s7Sk7wTH15hkt0OwksY+HuudazMlUvwJdrPOsh1AqPaBPub?=
 =?us-ascii?Q?rO1mcE//8j5CvjtSuLZBL8i1kqfPz5ez1T+3W1nZ7ZM8n3Aa5TjRvEYxry6Y?=
 =?us-ascii?Q?/YUIw/sz40qHI6xX9xOzM0A6mjvnF1/TDG+iVdrX+qusQJCD5BfZjMG5mb0x?=
 =?us-ascii?Q?SVRQK2N7SXfcPfypTyOKwO6P5WtOy9GzdbIJbCh0Vm2e7Z0tbJNlZ3DlFuq+?=
 =?us-ascii?Q?clgzo2sIDX/iQeivFGTj8dbWIZuVEJXWa0nSyGRSWLNJW/+JcVkCn6nKinT8?=
 =?us-ascii?Q?XZYoXFLYHAzhILBavFoDYkvh2B3QWKIGzvJd6SHfzKtyW55g0sObb0TWhVTa?=
 =?us-ascii?Q?omwl/rFde4jpG/hfZyXVjKCTzIdPgKcmhN+Pb+n47hsul0nytNNrexgNoUpX?=
 =?us-ascii?Q?nvMpxCPl5EkRinCsoIcBLoguu41YVn1xncUO7L61455dNFeaNKUBYs4+Js7H?=
 =?us-ascii?Q?DZSX5KRW9JdtUlKOy2PbYXNul/7f017jfsgFrvrEBoB6JDIuYsug8jmvc9UO?=
 =?us-ascii?Q?6MjV5a+/5Jfz2+k2cLLLwa3weknmwUN/QtMCNWwCcc20P+/v6MA6m2/5kOyF?=
 =?us-ascii?Q?Et4zMIoZizxaVpPsllDr0+QgWFvY+HdU8+6zcXD1QHPhYT2LIqsrgcTO78mD?=
 =?us-ascii?Q?n16HGAhJ3OLVtuIaVM3jGLxbgaxOJXoephagC4cA6BSIWzeTq1nzQpWbhcsE?=
 =?us-ascii?Q?Wk8MrWfQlKPLQz2lkg5biozaVFYfac+ERbsSddbsKp0oyaGQ4cV3ChnGkHpy?=
 =?us-ascii?Q?8/OUinmrcaGSjmD23/q/e+M1Y2sZqlUQPmC5GaeqPIjirvgrYsN05ZxzVSfN?=
 =?us-ascii?Q?Z8PwOVirHnZPg+nCuiRDUPx7WMYLbNNfPrZM5M8fIbOjws8cqCvatZxf0Y0b?=
 =?us-ascii?Q?VtnVKLEvo3O/DO8GojBhdmMeoBN4W/bger7MCj5cK0jf0ELiykWsF9F/4qt0?=
 =?us-ascii?Q?wE8Ihho3Kj7mCt6CXNsOLmx3WijW4kbV+XTTZSQg0Jyi3tsoeME3M7lR6Upk?=
 =?us-ascii?Q?7wTwDRqSG9qh7wYwRHOM07RQF3s5yJlivF8dll1E0Y+oFKmqbWDSgNQutmIe?=
 =?us-ascii?Q?peS8fdDcdLtmWYPaPrQzRo0sq6SI5FJhgJKZK/SxQVcfdTKMm0IQRrnl9rvJ?=
 =?us-ascii?Q?UhESiXKv0sU7laWgCxOKZ9ZDAyTh35hfUWnbKnXMYIhrbQr2L0AqSJOpU+8W?=
 =?us-ascii?Q?IyWIBP/Uw9QtN5FQhzo1weqFpA2MCNTbGZ/MrZmFje+ccFol/9qoLt3XZk1j?=
 =?us-ascii?Q?cZdR7/y335fkrL4vxwFX01GnhjoLLLzQUyHdtOBN0fCnnz85oDmMlZH3CZrd?=
 =?us-ascii?Q?5gvl85jly6miaaNajJqIEY/eksxgYqN5MQMDDNdVLoeeSgq/xfE4O5FJmDnU?=
 =?us-ascii?Q?dPZtcXz0lVy7VIkSZFGaOnk0GoglhbZOS58nVwz5FvQ/N/1AQd/lAyJzlTf7?=
 =?us-ascii?Q?cVgt/vZWhw1FqyCE3/LdSkDg5kpoS1ZbiyCPinLQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca83958-45e9-469f-e06b-08dde2779157
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 19:02:12.6212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZxNjT970K2B1z7OmVTwEBEd5D8D9W1+Q83QCOAQtvq7dSTi/wJ2Ku8rfW6KnBoHkRWZIX8D/DYtHd0y0E3vtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10456

Certain i.MX SoCs, such as i.MX8QM and i.MX8QXP, feature enhanced
FEC hardware that supports Ethernet Jumbo frames with packet sizes
up to 16K bytes.

When Jumbo frames are enabled, the TX FIFO may not be large enough
to hold an entire frame. To accommodate this, the FIFO should be
configured to operate in cut-through mode, which allows transmission
to begin once the FIFO reaches a certain threshold.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      |  3 +++
 drivers/net/ethernet/freescale/fec_main.c | 23 +++++++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index f1032a11aa76..6802773c5f34 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -513,6 +513,9 @@ struct bufdesc_ex {
  */
 #define FEC_QUIRK_HAS_MDIO_C45		BIT(24)
 
+/* Jumbo Frame support */
+#define FEC_QUIRK_JUMBO_FRAME		BIT(25)
+
 struct bufdesc_prop {
 	int qid;
 	/* Address of Rx and Tx buffers */
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index aeeb2f81313c..d932417f4d4c 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -167,7 +167,8 @@ static const struct fec_devinfo fec_imx8qm_info = {
 		  FEC_QUIRK_ERR007885 | FEC_QUIRK_BUG_CAPTURE |
 		  FEC_QUIRK_HAS_RACC | FEC_QUIRK_HAS_COALESCE |
 		  FEC_QUIRK_CLEAR_SETUP_MII | FEC_QUIRK_HAS_MULTI_QUEUES |
-		  FEC_QUIRK_DELAYED_CLKS_SUPPORT | FEC_QUIRK_HAS_MDIO_C45,
+		  FEC_QUIRK_DELAYED_CLKS_SUPPORT | FEC_QUIRK_HAS_MDIO_C45 |
+		  FEC_QUIRK_JUMBO_FRAME,
 };
 
 static const struct fec_devinfo fec_s32v234_info = {
@@ -233,6 +234,7 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
  * 2048 byte skbufs are allocated. However, alignment requirements
  * varies between FEC variants. Worst case is 64, so round down by 64.
  */
+#define MAX_JUMBO_BUF_SIZE	(round_down(16384 - 64, 64))
 #define PKT_MAXBUF_SIZE		(round_down(2048 - 64, 64))
 #define PKT_MINBUF_SIZE		64
 
@@ -1278,8 +1280,16 @@ fec_restart(struct net_device *ndev)
 	if (fep->quirks & FEC_QUIRK_ENET_MAC) {
 		/* enable ENET endian swap */
 		ecntl |= FEC_ECR_BYTESWP;
-		/* enable ENET store and forward mode */
-		writel(FEC_TXWMRK_STRFWD, fep->hwp + FEC_X_WMRK);
+
+		/* When Jumbo Frame is enabled, the FIFO may not be large enough
+		 * to hold an entire frame. In this case, configure the interface
+		 * to operate in cut-through mode, triggered by the FIFO threshold.
+		 * Otherwise, enable the ENET store-and-forward mode.
+		 */
+		if (fep->quirks & FEC_QUIRK_JUMBO_FRAME)
+			writel(0xF, fep->hwp + FEC_X_WMRK);
+		else
+			writel(FEC_TXWMRK_STRFWD, fep->hwp + FEC_X_WMRK);
 	}
 
 	if (fep->bufdesc_ex)
@@ -4603,7 +4613,12 @@ fec_probe(struct platform_device *pdev)
 
 	fep->pagepool_order = 0;
 	fep->rx_frame_size = FEC_ENET_RX_FRSIZE;
-	fep->max_buf_size = PKT_MAXBUF_SIZE;
+
+	if (fep->quirks & FEC_QUIRK_JUMBO_FRAME)
+		fep->max_buf_size = MAX_JUMBO_BUF_SIZE;
+	else
+		fep->max_buf_size = PKT_MAXBUF_SIZE;
+
 	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
 
 	ret = register_netdev(ndev);
-- 
2.43.0


