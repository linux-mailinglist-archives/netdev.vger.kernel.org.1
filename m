Return-Path: <netdev+bounces-110560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C851092D16D
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 14:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EBE41F2607E
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 12:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F7F191489;
	Wed, 10 Jul 2024 12:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="d64EYn10"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010060.outbound.protection.outlook.com [52.101.69.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783F8191477;
	Wed, 10 Jul 2024 12:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720613920; cv=fail; b=NcO8o8+W6u1jiWV0cmBUQN48y6CHQhYbncp5PFTSQOIQsDkCBaly2Ff4RtAwrb/ilNgC3Yz7QCvW29u9/Y/J1cV+yvIQ/nOIbXnjIdWUrKLFw0JIhliNuL4MNgDBSGT8tEwDelGq05tmOsInfA0kkos2UNHQYu3jlFkQBdD2ISU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720613920; c=relaxed/simple;
	bh=ExV+RpNswrPRGA+WKUeHwaTdph4ssiA39H91lNS1flw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YKnWHl0Jd/lmq+gNrt/mNxD3xJcaMS5tXYi10crk3+BjVSaJcQORU2hTPuwdIsOuVH1G/37yAThTdNfG/jrAjAltvCVobTl4gLZ9pbh42GGoJG1QhZVuHlUZWb16LwDnxfWVisg/bAoBD00fUdKfMP4SEbd8HEKTiX8G+oZSyhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=d64EYn10; arc=fail smtp.client-ip=52.101.69.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxrLIHKYAdPFdUVodUtSbvjz2+gXf8C8Ltt3wCtaSzTaJ1EYtaSDb6ayUqWJDvL2KdW3wWcgmCSlwMZTqZA9OECASd0omaRqrUiXopvtJzHpl3gnVJOEEA2ON4VFWQSQSbKHmoRZDqLk3pr8LLh18ZLbDxeOEFOxND84Lqz6aBhQ5ORNsFoxIn1u1uZmJ34lI4tSUi73yzJtwSQPN9gENL7m7EPkQC47V7JkzDTkVU2ZEOO6g2a3fQ7VLlyl1NH5x/Q+5B0E/fMT2WVRFC2OlHeh0Hz/txT0+Miozw/spjkqkZVJ5jzizyycHo34s9lG2MzJG81fmNsRGwLlpBnltw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AsbxyPe8r+M89vO7tRkT0ibxwgq2s2Bdvt+sLip8gs=;
 b=OIPPrVjFV9hdC8bRpd4SKG52g/R3n9a9Gmk+wFO6yuWKy0unDH9BaHhn478jI+VjbM6Fn92OCV9t6PxfsRXUxeCP/dv0UZQXV0kijscl93oQJwva866hI30WU3+QSBVnmNLBpccBRMShgDVGnoa3t9go+yKjV5riT+eoiWE4wj4ADGCvWgB7zmolL3EGaNDP6c0K8XGr5ByP1R02nRHlT0BK4uDADLGkKkw0qM79w1l7ZLei/94kQY+8p9BXUg+bbK34m0cXpP7uQb4jehDX4cnljLpztJOUWZum7J++bY4/WVcap+NDif5OPsHpgjEmxOthfEETlwE4mwoUPJcrbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AsbxyPe8r+M89vO7tRkT0ibxwgq2s2Bdvt+sLip8gs=;
 b=d64EYn10TIa4V2PXoqjpiDJQZ3/7F8wDU4OlqYNSA9LUwrTn32oX749vhg6IE9GXqbKqO73D67P5/Jxm8P6PbQiE8zUxgYuklVIbjOIHViuJjM/LcGD9+Bm4NDBsbpcIkStRZj72FIA+N0PulfiT3bJHKUyiJw8NfTmdOBgckSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB9789.eurprd04.prod.outlook.com (2603:10a6:10:4ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 12:18:33 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 12:18:33 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: sgarzare@redhat.com
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] test/vsock: add install target
Date: Wed, 10 Jul 2024 20:27:28 +0800
Message-Id: <20240710122728.45044-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::23) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB9789:EE_
X-MS-Office365-Filtering-Correlation-Id: 0236e507-3d38-40a7-d989-08dca0da6a9c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0QoXa0HgILMHc5wMd469KxjqhQ/Xf8VmatLKS+uT2divaRdE7xkXnxo99xpq?=
 =?us-ascii?Q?91str7D+UYy3FaM6iTG82i7VclAdbhxZYx+Pbjkx0gid+10nG46Bp1TVX3L/?=
 =?us-ascii?Q?OrIJ+pdji/ezNpcjmKIiKN2b4lcRcBKi85LSMIx1bKSGF0SlpbUEcaLPfuvN?=
 =?us-ascii?Q?cxb6In/jZiFCcPQSTyyDdYy/ZHBEYskgGrY7jLTzZUKRj+wyOPt8Y2wnvcTG?=
 =?us-ascii?Q?YBciQBJkX0xYNFAbOQkyEcvpjTljVxhJHxCLO0+z8aLR4wGeB3GscbfnvxiZ?=
 =?us-ascii?Q?gTmrNfG6gs01pbTUMDORTGxP7LIv5jk46WTquDrkUIhBvU/iXTAOoGU5KfuN?=
 =?us-ascii?Q?ue3K8xLl7nl5Ih4MdxgQCjxu2m3mUZcT5A4uMW4ABWDEoTOk5wqnuVdHyZXF?=
 =?us-ascii?Q?UeF3doQbz3N/4QI40iWWAfd8A4pBZ/NL0Uqj+sSL2XvEM9wUHUChS57ILe0f?=
 =?us-ascii?Q?lK3FLxG8ToqqBGWw+La4SOHUhQgm8Z9j5WxhSXxRxwY5FLVVmk66xF5vXO+I?=
 =?us-ascii?Q?tYcEK4GLsgH67HFvYrJioGIRpMhIF6ED2T6QCeduh3hNUNA+NShyQt0hAOdk?=
 =?us-ascii?Q?24a2VzkH28f8B23yJtzVjO4qCIxhDx1LvNzQcAGQP+TQWGjd0Gq3tuzB49e+?=
 =?us-ascii?Q?KC2Ny9Lje0wN9icw1GEf2eei7hZ4t6eQfF7ocfePVwFmRmObACiN92vz+b0E?=
 =?us-ascii?Q?B8FadsTe5IbavHqY1pmcyGXGQ/Fr6Q4DA1GvMACnWXOp6sNpqO/f2KV7AcDE?=
 =?us-ascii?Q?rrYMKdPgOqf9mOnmj7vRKevobiZQlDzLnk/kExFvcS+V0e+Fp7vP+sXd0p8I?=
 =?us-ascii?Q?gRyblTzrk2CZuBCJj5e5ob/IKw/CbZFvCvo6Fim5M0uE4vNvX/Ql0bJfiWLd?=
 =?us-ascii?Q?pb14gJUV7pz6QVRrGTwzduEWWV3jiz5ikeRozVJJt/l9Io4Zg8LjisFsUjCC?=
 =?us-ascii?Q?aQublgQBD50U/4lkt+zrAPxiSw0bWDaViRlFitIkYJd907JF2xEO52+Xc9fv?=
 =?us-ascii?Q?6cPAUI3ZaNw2NRdWDoXiFu7NL3Bco4a2mYxqtd9XZcBFBqi90HH2JpMVec7S?=
 =?us-ascii?Q?3RJlF5xG6S7nvGActfj+GjNiSbJe7sDpbojtqbYb/rDt9oY35DvQ1wtstPL9?=
 =?us-ascii?Q?4bcSa8vZieJNZVvOqwoYD/Uxjx6GKJwqRT8X7ezgsSd69pmEc93NqRKHV8ho?=
 =?us-ascii?Q?WicujWL4VOz4zqtJxftkyzvbliJ4ZBLcebW4u+uW3HXimfFrsKS5RKOXo95J?=
 =?us-ascii?Q?AxWLpTBCn6h4MIIhT4mT0+b+qc3Z8mVAoiAck/MYZXvm3ROT6ZwTUo+AgD9A?=
 =?us-ascii?Q?6x8+mZH5mN3pRCbwNT68SEcIf4cI9KdH/vhs46TiCwZfdZrd44HTBdYZKkCJ?=
 =?us-ascii?Q?Y7R73IIYYTf4z5eZvC0BljSXV7aQVscmxXEwahcwf7ZDhZoOsA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CRiKXdJQbEd0qc+75JG852E6sOZ5/mNmNVYW8h0W0RUNad42xCE8GTq2swvt?=
 =?us-ascii?Q?DgZM1BaGl+JoBlw/ifbxKhOVEAY+Sp+E7V4oNOdjBVebWI+1ezwj2ntrHMGU?=
 =?us-ascii?Q?4+0wRKse6KGDFcgbhWGyorS6DKmRSBD3CakyYH7T6qcVsWiddnM5ivCUYG2+?=
 =?us-ascii?Q?aXVDrAwILbTi9LFnt/jFRRPeOKXJ4GRf6c8nTXMmSBDaTBOVkagAoxvkEIwW?=
 =?us-ascii?Q?WiL9qsZBJ29Fh8q65aK7pUtXi2aU+FWIHsRYT4B6aluc/TKdLLQCZz3ho973?=
 =?us-ascii?Q?69sLyXzWSK3O2gR1oQD0TExjosYx25jl2FnBJyEMkg/H1IQ50pE/xKQXcl0k?=
 =?us-ascii?Q?vuCICsussevjPLIifwkqiEiasV753m6oGmuofb2iIZiFCaTqjXL3XKOHXToN?=
 =?us-ascii?Q?2cark0Z5103vNyxBMj2Q/f223bRk2VRwJmYMA3ehTWdPFLU1FH/MCtkOWn/I?=
 =?us-ascii?Q?jpWYgxqi1av2yTL9cUEzgNWkIGrrRBCMCCicUHI0FZm3Xwzi1Eg/CxC2hHos?=
 =?us-ascii?Q?bj5z4D8emGi9muoPHLsD/xS2xwQCXKafsC/omCoW7mw4a7JOy71Tcb1IflqV?=
 =?us-ascii?Q?ls5huoLBvS5/DLJHrcIQODFRxWLYNTnub6it1Ro0AWpLbv0cWPF8BDOe6nan?=
 =?us-ascii?Q?WlOtc+Lihbpyimqu85q5ur68sKLK61e4J+eXhog0zFFGVbwNhprxss2Eskxz?=
 =?us-ascii?Q?AelvB0HuODLZg7SANahFFNYiQ0tlrdfxcJOKpuE2DE1yRRdLD21jI/gD4A2r?=
 =?us-ascii?Q?PyL8+uS4P9DaCiBWHieMn9lCJb9DjTw3pjV8vP5u3M5ZvGG35SnPc3Ng7ezh?=
 =?us-ascii?Q?gXtDx6fB3XdYcFXk5ItqvbPZED4uFCpOMZ/7Sdc5iiDC9HAgyWLvdgumv+WT?=
 =?us-ascii?Q?4PusYJEV9QcLv8h/KooA/K7FNzGVmZUvFB7mzgRPUdbkJexPJiBmj/m57XhI?=
 =?us-ascii?Q?/2GlzSVhfKdseASTVClSIm8gSbpvLRVOP2x1y+f6TginkIGiaYY4SipAiP6I?=
 =?us-ascii?Q?nMz1Y0vimzEpJiASa4f06EPj0RmHOMX4kV1mrKntf/6dZwDkoM48wo+GVSo/?=
 =?us-ascii?Q?xM0ap4L2P7+97vIUisZpHOr+VWl2r0zUDGbScf+W7azt8uNrEOsFl70u6Ew7?=
 =?us-ascii?Q?PZ9NFXSYaQjf8F1+A/N3bZd2mse7IcBRSr1tg5aXGyi3jFhDWf5GBIwwzsFR?=
 =?us-ascii?Q?9EZ84bn2vdtLJUE5Z242BAlrlSEd4hSNhmtg1dZSU5uhyn7LOd6Mj10aK5Mn?=
 =?us-ascii?Q?8EsKtjMKb+2Gt9LeWaqeh7OB5Tzcux3Vu0fLA15c96aEfCYFhwDRwkMfIO6p?=
 =?us-ascii?Q?7qPLiD2tcTv1I1kxcwye6zCJBTqwuyJ1bDh3Cu+GSwNG7l/roI6h8mKnoDgR?=
 =?us-ascii?Q?hBP3QaEccJ8+H+Am6O1JHqgCWAQMZbhGmbLU8gyE1MnDsaAcS/fcSLlN5lbd?=
 =?us-ascii?Q?vI+t1Uhm4n4MmI5+HER/D7NpVunnGNUnYr3OHFFM1NYFslz+ZmkKQiY1Hk86?=
 =?us-ascii?Q?Al5kV9pH6qnuuY5MESCG2vzssdqVW6TIKpGMFI+aAEVP48QPS3S+99GIxEM2?=
 =?us-ascii?Q?cbWf3fBWzqREB4dWDz0o8uP4+QZb0UQtd0v/lFT8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0236e507-3d38-40a7-d989-08dca0da6a9c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 12:18:33.4740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6+nZ0NdUWY0Iq/trQ+dM0jzukZ/5Z6TtaK5vuA8a/mvYz9qVqb9/o/nMAvEOWwWcS42LXQX8q4b11xAkJZBrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9789

From: Peng Fan <peng.fan@nxp.com>

Add install target for vsock to make Yocto easy to install the images.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Use VSOCK_INSTALL_PATH, drop INSTALL_PATH

 tools/testing/vsock/Makefile | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
index a7f56a09ca9f..6e0b4e95e230 100644
--- a/tools/testing/vsock/Makefile
+++ b/tools/testing/vsock/Makefile
@@ -13,3 +13,16 @@ CFLAGS += -g -O2 -Werror -Wall -I. -I../../include -I../../../usr/include -Wno-p
 clean:
 	${RM} *.o *.d vsock_test vsock_diag_test vsock_perf vsock_uring_test
 -include *.d
+
+VSOCK_INSTALL_PATH ?=
+
+install: all
+ifdef VSOCK_INSTALL_PATH
+	mkdir -p $(VSOCK_INSTALL_PATH)
+	install -m 744 vsock_test $(VSOCK_INSTALL_PATH)
+	install -m 744 vsock_perf $(VSOCK_INSTALL_PATH)
+	install -m 744 vsock_diag_test $(VSOCK_INSTALL_PATH)
+	install -m 744 vsock_uring_test $(VSOCK_INSTALL_PATH)
+else
+	$(error Error: set VSOCK_INSTALL_PATH to use install)
+endif
-- 
2.37.1


