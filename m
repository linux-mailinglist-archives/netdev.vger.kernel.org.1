Return-Path: <netdev+bounces-133050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 969609945C4
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 12:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2605A1F24336
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 10:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1A21C3034;
	Tue,  8 Oct 2024 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nCKqZ/yk"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012008.outbound.protection.outlook.com [52.101.66.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52B618CC07;
	Tue,  8 Oct 2024 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728384433; cv=fail; b=HudayDHPkXSDERRBds5TMZSEQLuT6IgsIiZxPv5zMNejXsCfmnTI5UE9Gb7qVKL4J7/RIGs0UhlhgvLYvbMEz3Kodf/1dPLKrMWwrVvIDOGHtXHQs6MKqPlCTKEm1qGzsQBtzEqUoRB8BczWfDALpCFie2HbdiyUuuBUxGEiGYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728384433; c=relaxed/simple;
	bh=T/q3ddQK3mVBOCaIfWDeOqUk0EEGhMxmegbJItua4Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ribX1qBOi1m4IETna4fUi+VfU8I8Dn5CU6gd9QLfqhQZmKzLnPmHSBhzMexM+TNwdZK1yS9teZEdHC12q6HbVkxP6E685lMocCDwyZ7DilLwPutF9LJlrO1nHKiooOeDweDcKvFxhdf7h89zx3QYA2LZ3uWpCwKC4CoiRfl9KdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nCKqZ/yk; arc=fail smtp.client-ip=52.101.66.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNZokYyuWtSKu3NWpbjSWiwexQOXXuXke4lXkQuO7c8pHot5WzpWiUiaQZIF3q402VyRH6S0UEDmLhDDK7pCmofVAEWDsshOSPayHGj92Uce7B05DniHua3qZLVFrY7T7bjIkUnt4MDPoZNJr0LWLkuxqqBjfy4ATvM46GxwzJlLIyeZkhxScxCy07ygwHA6M4FBxt1P0q2gFS4omuA/JlyEPZsCz/wNROmMWFuQGzZIYvjTPhFH2eZkDDKOETNQaq1zA6pC8qRmYr9GQKek+FArUpmzpsmQLloyCIm+Lyn/tDoyZ3cMO2AxVtwzJGg/0CyhWuv3GjErg2dZXEtNIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TMqdxhwbFWmSfktcRRhsG8w+km3b6cP9D4MHcWfKHk=;
 b=Umo3XegXluRn18m922PwQjGNuUDUerJX4euhLqkx6SkhlE2uElqqKHgUzKIRnnUBQiaesfugIc+s9bMfWSYr0qy91Ep7C2pSb/ejLN8B/dekFhDJlTIMHsoFHqhSGlcrjX+3HY0ZCGu2BfL9FHbEYvPVdbXqXoLITLmZpEnxmZ/zXNFZ29XoREpFURgZErV2Ru341Uo2qvXKKY23fLAhEtDKa9Enc8+X/8HSjMFD75Giru+R7PRqNFgiv8a2/Wqal7md4CtrpPpzyXFN+RRbYwWUrtve1nA+q/p5BBc8ePzawob7VKUaJEcxsUdmp2uhUB+RQnB+mMGUrZWpxWNG+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TMqdxhwbFWmSfktcRRhsG8w+km3b6cP9D4MHcWfKHk=;
 b=nCKqZ/ykxA6HRSqFj2ve9rFj5BBquPKjA1SOkTEC3uFs2xy2WKt0bryrwNcF8Rg2437MlghotnY/5nOBugvIeom2CgYPXYsGnnhd3tSvNW5XunzLLmZ0OK2f4aksPVBe9bcBMMPiWFYue0QLD7zjIWs4sbudWMDtLexJY6KkZ0+eq2drSZiJ1a7KOTcwltAevw5xhdR8K+kNf0iU7Ag/8rSrZI1kNnsynsZYFgHjkF0ofStjoz0CfMcKg0fxmmhr6/CEa3CzUftEZJCOEzlTuWMBTi0+FSqIRJ4x4KLzgtp7g6kcKzN9fds9ReKZPej3bBqcN4bVA6rOzLdb0PxTMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS5PR04MB10044.eurprd04.prod.outlook.com (2603:10a6:20b:682::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 10:47:08 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8026.019; Tue, 8 Oct 2024
 10:47:08 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next] net: dsa: vsc73xx: remove ds->untag_bridge_pvid request
Date: Tue,  8 Oct 2024 13:46:57 +0300
Message-ID: <20241008104657.3549151-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0032.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::21) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS5PR04MB10044:EE_
X-MS-Office365-Filtering-Correlation-Id: b3fc4acb-9463-499e-c611-08dce7868e4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tr0IiMXMGidhmaNnozkh0BkzTzAbH2mA9WZlozuFS09b2syVYnF7UmC69+8N?=
 =?us-ascii?Q?EDGhOr0QojYODjTOtMc0lKk/Qyvbn4PjllbHIscCBL2xODa5FBqm+AYfIMlm?=
 =?us-ascii?Q?dvOxV0JxZHM9lmX/luS7AEezGTa8HSCJsTxiL0wgfds1iytG6NqG3DrxScOh?=
 =?us-ascii?Q?vMfiKWuEgRFw9DoRkjsxEGZS9nVqWi2sG0I7yJdD1g98DiRrr7BWxw2LAQwK?=
 =?us-ascii?Q?m7PwhTKStdyXWNp4Lxv3Sfq02gVClccGiiPhSI8k0mINDEVGEGwZGelrsxb0?=
 =?us-ascii?Q?zE/Y76TVk09ilpAL7pEsm4Uj9cl6HZzEoNc4z2VjklS/rMBQTz5De20IzJ8Z?=
 =?us-ascii?Q?BUqHXU0QFT7NgRjko+qQ9cSIhKrLJUZSBrNeXgIoWCq+VM65pE+HFspwBtnw?=
 =?us-ascii?Q?SV4rPnpgKcLMYGNQpEuIeqKmX15/NiHqUrPDeK2gCu4wyEOx5bEDd8io+/17?=
 =?us-ascii?Q?NNbdaJRQ3ty+q+4XpodRswoDs56ebNuxAmvUJ5NKc3LNq6EBGs7fiQNDSjJP?=
 =?us-ascii?Q?rzl7fhHyLU2CAuLxqiL6rBDfz8jAi/dDjsjw5gd2ibyYxE0S3r3jS7XaKKWg?=
 =?us-ascii?Q?7nvR3vphH8TRuz7BmsG5QNr5vgq6KId/P9m+AHJYtbsDn/AQtlGv7n4uyXU6?=
 =?us-ascii?Q?WkGJVWCWUfSOLj6TjMEhUvoQYOnEt4WY5Uju72MPnIL7oxzG+yiVPTxvFevG?=
 =?us-ascii?Q?S1uh2cxmrppQW/x4W9EjM5ZLTI7GYEzAYnAnGVHsz1tP0jZzEb1gy9rbGdMf?=
 =?us-ascii?Q?C8FMiWe/qINcrmEbrdmi2WPm89KHkm9fD3PbERBxOh/gVJLnN78FQH941Lcc?=
 =?us-ascii?Q?l81teiF64gGY52xnept3+ZqLHX5GWlHagv6jYF2bthVJXJvzG4F+JSpeNax4?=
 =?us-ascii?Q?HrF64aTV406N8dw6dtoTzw7q/ZS4WqIefNWRW3QolS0bOv0rZOIkt8sNThM5?=
 =?us-ascii?Q?kX9nIlHsqmyiSfLjKMfR7BKy6IGPTa7xGFbQjp+cHk8EShSLVV/EfXeI7w8d?=
 =?us-ascii?Q?qxDcw6njJKbP6tGxmPjklZJzGRwMhAXoUC75nlQenGt2DKfdqp1YmC/pVxGh?=
 =?us-ascii?Q?tZLvjNY0aXeptdP39VV8ezLSIZc6VqGIWR0EXxjWvcTY2SZDN7MjHF1MBrD/?=
 =?us-ascii?Q?A+MCKqmBoYL36jFhumUNT5vIHUh4OZ9bNPxfjfpmSPElvll3touD14W4kzVe?=
 =?us-ascii?Q?UwbKNXxiswCvCfGSnwHuNrpLtHbKCpmkIEbWfMOOlGX/8SAZMti3PdT0zdEP?=
 =?us-ascii?Q?1/fWU+xFXeTaVJNCCNqG0vUU6vpwTGDIPcmu+4hvSGa4O2siEq1EWmTtqgBz?=
 =?us-ascii?Q?DHNbS13bfWjMyLod4wRTgABM0Y0eQbBUST9xl3eg3JL4FQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZDoKAxjn56vUuo4wL8uMA0BfIaMmi0uDENnXuOUpCWEkidocP3vlyNo81urt?=
 =?us-ascii?Q?+H8pQYrODKoUh0h5nvFzBE7qIGZqSqcY2nn3yphGVoWz4SGJyUxfZSX19qWR?=
 =?us-ascii?Q?thFzi/jiJgINf6QuSOArpQEToyAnVWR8WJuP9tvD8txot2ZWPqsL+itLrdTp?=
 =?us-ascii?Q?3THNuDqA4/9b9EEguiOlJ0iVfT5yrWHphnrcYEtry/tlIF7Ug7XsLrroeooP?=
 =?us-ascii?Q?Hco5TlKJW/ph6/RvMnzeC2W/nx9LctEGoxKSk89dtzISfJ035eUwS1duby4d?=
 =?us-ascii?Q?w9k5SE1ziA1BFDX4OYtNxUTXxAcnfLPw9FL5VF/GPiZiL6YmMEvEH4Mf6CZ8?=
 =?us-ascii?Q?PdbozENstccORzr2dD50TQriIVKg0L/MWJOLw+KyqBcjWmqkmrqxb0oR+t68?=
 =?us-ascii?Q?TnJVcAk7TYdmWjggDTIIYHQoIvlAwA4nhOBQbIFn8A9Hg4ROe1676rATwtQi?=
 =?us-ascii?Q?BBmEYurVsOkaAxIHomFOylCFj8Bcgg4XZKSfkMhVeoGpQhIcPe58dszn9fyL?=
 =?us-ascii?Q?jhRWmqCWRit9gBga+T+FknRrmO0CsIPwdFlBsj0qJv1LEB6GhPcgof3cZoUV?=
 =?us-ascii?Q?TiQN34jLZSoRfjvGBi8AlT+oJljANz2JneYctXEvHUIgZyzWBitsdSy3QffA?=
 =?us-ascii?Q?998aSQGtF5J+t4fAD9zmxo/E8qvGHtuN3YD27KIxRFRzdyFnfyKbY0q7X880?=
 =?us-ascii?Q?QERyoAd1iyfdFkSwQ7nGxMBNnCOzZipRM8Yf5653vLxr4ts9anTTk/yJiXrz?=
 =?us-ascii?Q?GpA0Q2hm4/byOCB/bwPe/UhsVvIIwfj3QCNxxntc/wJHFbTesWtVXnype87a?=
 =?us-ascii?Q?Fax1huKSx/yVeKS4JmZ4G17qZzhUKDl1SRyOVbvdTFcvB9Xy+wSX3dEDqvjI?=
 =?us-ascii?Q?8tOb8nPqubFC3PhbgYWRtzxyRYMzurFS5G64EAcXpMkl2iTWYnOXp7Vp+cOJ?=
 =?us-ascii?Q?y9cotv/v5GuJYgYdzY/5zTTIJN5jJRVUw1ABYAklc+7Do4BZygliYFw6dP8S?=
 =?us-ascii?Q?LqlHGI47tPoR1lp7mWx5debaW3HtsF7AJd72Cv5a+PdRc+Ul8pxruUwKnmAz?=
 =?us-ascii?Q?GMy8oGsm8WVh5sZ2So3mEUMlDUv274DKIVcYTFVbiTbNYY7YRF1TPR6Jb24u?=
 =?us-ascii?Q?mluoD8gK5lEobLxTP/b/Wh38dPnxtBHnb2TsOGpSgoyuQisgULDfKH2WwI9m?=
 =?us-ascii?Q?VHlwREuDEHuLvsCMN887hXs8LCCn97TgDP/tx7sbpuXVeIOSSFoqJmu2eTvh?=
 =?us-ascii?Q?paDWwhQaMOQsBXdA5aNhGWnl4ykdFp4ZSxv4lbrVm4nqzgS5OqDIBFdCj9as?=
 =?us-ascii?Q?gih4y4iN3n4Ejf4BIStA2r4Bwuylnahx57bn1uyz1viO/FuXG27QJH2gXVD4?=
 =?us-ascii?Q?XJM1hU1OZdFgVZ4PZD6PzPueDXtX5sErJiAiZdX+DObDZiY0TkZfXvYsX7TQ?=
 =?us-ascii?Q?nIYJ9bzlGgw/8OH1EC/Ha0gNl8n6lDwd6IkQ6hbjMBktIiNyQ6h0ishh24EL?=
 =?us-ascii?Q?aHG3eLA+j1AwfXOhrZgr80Dzkdhapp8pfSBsVEWR6SFMbByNcNtcsP0QwPs0?=
 =?us-ascii?Q?wvsfYnFNYB7EWhvc9gXOKq5sJR6SzxzFtRO3XQcS59zEz6maj3+S1x5eS214?=
 =?us-ascii?Q?xA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3fc4acb-9463-499e-c611-08dce7868e4e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 10:47:08.1074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZcJPzQ8hGrQBFNml9+Ivu25NNeWduUknji6i8v9TIcQ+b1OIw2UCn2+E89ppGrMR6JcmqpISNhAC091wjKnJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10044

Similar to the situation described for sja1105 in commit 1f9fc48fd302
("net: dsa: sja1105: fix reception from VLAN-unaware bridges") from the
'net' tree, the vsc73xx driver uses tag_8021q.

The ds->untag_bridge_pvid option strips VLANs from packets received on
VLAN-unaware bridge ports. But those VLANs should already be stripped by
tag_vsc73xx_8021q.c as part of vsc73xx_rcv(). It is even plausible that
the same bug that existed for sja1105 also exists for vsc73xx:
dsa_software_untag_vlan_unaware_bridge() tries to untag a VLAN that
doesn't exist, corrupting the packet.

Only compile tested, as I don't have access to the hardware.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index e4b98fd51643..f18aa321053d 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -851,7 +851,6 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 
 	dev_info(vsc->dev, "set up the switch\n");
 
-	ds->untag_bridge_pvid = true;
 	ds->max_num_bridges = DSA_TAG_8021Q_MAX_NUM_BRIDGES;
 	ds->fdb_isolation = true;
 
-- 
2.43.0


