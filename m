Return-Path: <netdev+bounces-128109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E11C9780D1
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169541F229D6
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 13:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD281DA30C;
	Fri, 13 Sep 2024 13:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aSIHIObi"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2074.outbound.protection.outlook.com [40.107.249.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625F01BA292;
	Fri, 13 Sep 2024 13:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233341; cv=fail; b=LeViQ+agPkfEnq9zA684VpEoHHyK2gU7jr4CofsGHjMCCJT4ZYLyYCiuv61l1yDTfbDWy8B09yC8L4IFtBA/QPf+USqWFAoKOA74e1vh7EyC3liHGFY+Blmzh/9Jom9tj/qs5eupiGb/3n2npq+d07DuD1gGkrMj6lp2O53OvqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233341; c=relaxed/simple;
	bh=M9eSlmroM1VIGFkw56hY7YlNkVm9rFkV2zpKQryD6o8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=uhTB6e38Kk01C6hRDNxmShXMl/202PqHhj7HK9ZPwmd7hjmjbZupEV5JfZUbtaZtujqtPNNjlyyWWyy7p3XiO8kSjH/4GuwfdCbkUkA8zDMUn7fg8xLjkb6SNA4wUi7grpXp4jBsRc1ZplHBbA4Vh92hMSJYRILBfijWdaK4nD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aSIHIObi; arc=fail smtp.client-ip=40.107.249.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6D6f9hWqM+bpSGP95FTsbs9Z1TjIqV8p7kM7YANqDnVq1ngyWvfRhxVm3k/0nvIH4+U0LNWu12GvEBLewqJ2S5eV3GZVQQp6JwjndDh5AmzZQhPouyCqNuhLSAQMxE8sTri9c18AQKxnFhNC6w9Qdw07fIglMsG7mjsttN4i/AeSHFCBEKA1+i71xy+VLju/UtHZ4eSyoXFk+2SA6rH+T8/pt/TbOFFX3Hox7urbRxYJyCb9G0CMLV0ZFrvljfmbvgtDgklJogM6ykWFZLZPFxyDWAmU29cQjsrZ2B2jk+qxyIGfwheDvgWN0/UN0tyuiCJBidKH3dW8MQfSB2jgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWFzHif5Y8Iy6DuwB1qv/q5RlgzRpYrVSzve9zcXGwc=;
 b=sujMCU7mSve8QCsrJ7y9t9Ia/5OMtXLoETT0bt2PFJ1VlxRs5eOI1oMWklC1Wpr65B0xZK0IHTk9P1UUyAotWWZYzYka5jraR6bTlqIAzL+XxrhoW7/EjDUWei+9lrdm8lKLjFJutCYk+scVbx2q2wTpqEw8J6C713ukMSHQRqpkGePGiJfIGqlFTSIFuR7Zog1vGn/srYgmIyRFJ2Hr7Akjk5D4A2n9DvNG9G2Cf35SuiwgRsj/mtKn68A7cexbsLpEMwGe1vt6KblUphA6KKbHc+S3rqZ5lXYpr0kRtp/JYE32KgUxo+pnGLHxjILhUtv/Ofxm4j8fsAgR1Pj0BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWFzHif5Y8Iy6DuwB1qv/q5RlgzRpYrVSzve9zcXGwc=;
 b=aSIHIObi84N5wQum8YD9uI1Kyl5LpCExuas4f/YvRxGL1jp3x+O5CGhKE20hbJ6YFw5yGr1LaUXo39Qsjp5DFELyQFaORx3xiKfSjPoCLiLILI7HM9yUlqxcQBfmcAF69HPRwIzMlWUhSPkojMsMVM34yt+MZh55o8N+R/eupx6EkEr9pb8w1+MlsAa6+FVQ0v7wPJVOa5eGL2STk3uRnUAYb91xQEFzYEWe6v2ecGMKHYgxYXKa6Wjg+gYuFJ9nInoJnnty2thRcIUe8P8d4T3aDB+RDeKsxT/GgKAS0bnAqfGIvnwQ7h7NRfPpL85QK4B6Ajmw/KFioSs+LZvuUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA4PR04MB7519.eurprd04.prod.outlook.com (2603:10a6:102:f3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Fri, 13 Sep
 2024 13:15:36 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7962.017; Fri, 13 Sep 2024
 13:15:36 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/4] Cascaded management xmit for SJA1105 DSA driver
Date: Fri, 13 Sep 2024 16:15:03 +0300
Message-Id: <20240913131507.2760966-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7b::12) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA4PR04MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 67cbc19e-388e-475d-5c32-08dcd3f627c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eSRw83BVn6TM2l9wRBpj4rI96rUNm7ost0p8IBCB0HakZxWMGX8cTrL2I5ZH?=
 =?us-ascii?Q?hug1Bu7r8IhSiUNlvrHQOpVP/g206RZCQFV8TC6Nc0lBKDaQrtzvEyDXsVNi?=
 =?us-ascii?Q?XmMj+qhSW4yXZWB/Y+2gYettwWt09B46B6aQRkf/mtsFbGuhQFl4/iMQ1mXk?=
 =?us-ascii?Q?t1pdN5bJkr1hgDTJOJ1Bi2f6AxOxGgm1H9Rq5a8PtJ+W6ORbF4WJrUHRskk2?=
 =?us-ascii?Q?In5A2Tjy1gukWqtl9XO5lako8GpXddfgBekX+7MuWCb7hb3f4/25g33l+21n?=
 =?us-ascii?Q?C0rxdFOnClcPGCKx9paq171vG3HDrl+bFDXRR/KlITyLii979a/1/t5ytLYL?=
 =?us-ascii?Q?a6CAzqLisI9b6NFuWI0WlPJ08O4MlxglwWDfCkf5j9KlA4b9wrzqqPLyvPm9?=
 =?us-ascii?Q?TOdu48hQf1CHvmR3g5RIfLv/FVvGWs6x5IW1B8ODnzl+IhvhPuS5SFMQ0w5N?=
 =?us-ascii?Q?E3CPqtAwBtksEMB3fkeMcmdhqKvPcBNTxGCWHOP26+BOlSkHKKS4UusD7Tp4?=
 =?us-ascii?Q?TOyK9iSQXMkrUQ0y8HyeNhvFIfntQIYKwL6MplC7tYVeIZDRz4vont1+hL07?=
 =?us-ascii?Q?naPZYEL3PudTM5KihUxD6KMb3tSDJnFlP57y/EHb728fqOXLw9nQIpiRF6EQ?=
 =?us-ascii?Q?i3PDywCrPSDeugnoiSvO6eUMKDqqUaBgZMew9wMGVoGAiSjVhmoZjRWfE4gG?=
 =?us-ascii?Q?lAKGrDjx0IqK7WWca4Qodf/xKVC9u0LQBz0sAhEm+Yc+E0HQDfviCeu/UBpP?=
 =?us-ascii?Q?6aUkifErfYZKijh3lW9Fcr/62PxjB0wW9yJBnXjXgbtng0sGC5zptTQsKgz6?=
 =?us-ascii?Q?JOAdLHNw40jL6XDjhLXdzhIO1LZA5VzF+7AhAgsW3RTYTQYtGowbh7/EG4oY?=
 =?us-ascii?Q?ALV0ioFIVlZXI7t4ZnbglPCLUWaRv5/htkl7V4NcYMHRbrbyoNO3x0vT2DGC?=
 =?us-ascii?Q?/IEV/V4m6s4G+MoaKLRs2YlArtsPC4fBQjM8FFQ8mc7sVJLEOKAhlw1HYWTm?=
 =?us-ascii?Q?+gkN1jWrI/htl5SfKw/aVOzOArmS6ULmHKdWOLasNOQZIg2PEN3qjcTngx4p?=
 =?us-ascii?Q?Di5q7z+AeklKGaTrbDwZsjmkjAqYOoSHlsfdbh2XsAIa26Xorx9EypkXi6oC?=
 =?us-ascii?Q?ZbDSKili+IwiLomyj8FGT0CBKoeIM5iDvRa0hFNynidh7zGuJzjjf/I5uKzb?=
 =?us-ascii?Q?YHlqf3yyXT1tF2TvolYsPC4oIBpE58HeI4FKKbGfqlB2hY8pm6pwo28WFcFs?=
 =?us-ascii?Q?vZWxcFx6RUzGk55anz3EMuGHHivgX5ssqk9jA0epFfcmr3pEAMsb7edPrxUA?=
 =?us-ascii?Q?KX8qEdTqa51OZ6nIxBihPbJuA2F6htyInBRilrYQ/NA6aj+Ffhkcbn9Ht/wF?=
 =?us-ascii?Q?hYDJnc/8RR7RPTRW6mB3bIX5q+atdXVwsdRCVHMuoq7beTnpQg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nRJ7F3YBCGeLDDdVXTJdHZrfVEJXhmspx7GEXGdJdoTSTwslqx686eCFMYZz?=
 =?us-ascii?Q?JizuQEio/D37DU2C2pDISqS2nPcnrJ81etTRMeS5E5yrVu/GMxjCGhoSfHGl?=
 =?us-ascii?Q?KVushzxkTPehIqRIbLhiGiZR4Pc0fOjJxsda66k7Vm+Q9QqHbk5q2oEfDJnK?=
 =?us-ascii?Q?dbRJVsKSIrOmg+v3vJzKU6/sILQC1TS+n3wP3O3AkDH79LtSlmmgorkMc1hp?=
 =?us-ascii?Q?5we2KLGBk3UlS6vBxFwZhpfiGrbqOIWDBIrUhGWDbd4pA/QQy/SOnMzFrpqQ?=
 =?us-ascii?Q?zziApgvwxlF3QXivimvdIain664MqzqEeR6B5o3lQ+a9u2d86M3hZLWIi9Dg?=
 =?us-ascii?Q?0O9LAC/mFa9rR7zrz3lskF6fAOTqYqZVBCKGpo2yxTKbo7hYuvOTxaEeMJqh?=
 =?us-ascii?Q?3YtANTCfwRwIxzS/sMigw4747n5IrtPotfiqa4yZbQF1CkJbH3dHeiTQ5F/t?=
 =?us-ascii?Q?uJfZNpiD+t5vhYJ8wm1QNCkOM+tZ2r58OXPJ83Q1cT4hMelTflTykNpwyfDe?=
 =?us-ascii?Q?vTfyHqG/Egoikj/f0J+Ld1r37IERm+rZ7m6NKHwpdjTKtJTuvIxMfG0WESoj?=
 =?us-ascii?Q?w64ORKdJWM6mpsEc9yop1/a7j2nmJyCoQPcqqwayf0vXnLR306aNo9efVLrq?=
 =?us-ascii?Q?OzMahLqYd0rRaF2Bt2ExFe7HVreFG1t2va/SG/yH1FekYPP2pcV7VwkqAxe3?=
 =?us-ascii?Q?xT5ExFNPGQNpk7VQzRpPXBW3bBhFcyJHm+F92/L5LhX+ij0L73BM/B59CJm2?=
 =?us-ascii?Q?O8Kds9fPq9W6PPAj3UIz6n3v2FC1oS78IRD0F5jK1bFLfohx7RWilT/D0TWy?=
 =?us-ascii?Q?WpqE+Qr6hZSzLLpEr3pESCEfQdRdRpb/1c3R82Pqs+TA3+cC9Tz8r5+/pEOR?=
 =?us-ascii?Q?VNd1XaHUs1fDM73MypIhqqn1t+jv880nouRX0DfXfLbXyJXmbvPhbWKh1eFD?=
 =?us-ascii?Q?3uiA3j+kU3WEBDXjIK1r8Gs2Y074ifH/6h7js5qpG//4gz8f3uW4PxP6f0OJ?=
 =?us-ascii?Q?weyGTyU6dBL7iETTuWlS6zL9S/jjsFT6+9rFD3YlDXcNeQmm6N8POo0RT76O?=
 =?us-ascii?Q?rXxzyGq99SiIHtaRHLNrrQhrv291V2eRwSoz1+0xefZocZN+ttJj2S9PQdGt?=
 =?us-ascii?Q?mHiGLtNZsa0mccsMi4aDhHSlJJoP3ofRNS4nNAfZE5eeZ2On1u0hYlNwl69V?=
 =?us-ascii?Q?RPv+CNQRh6sS5SDUs1g1hmJA1mcTqYpddok5KpuUmGz5VCY4lFXeASjKNUVy?=
 =?us-ascii?Q?lgXSZjghm73Bmoao5dU86e7+elrDqq+1/Hy6n+k3iwcBtPyVhH6KszUC5l7q?=
 =?us-ascii?Q?JWQAm4uO0pm82ZpGo85i344gkv2y0nHFE9XFLdZ4l+X3Lb7FkTy/qOr/Fpu7?=
 =?us-ascii?Q?5NldhKa9+n2OqnUeLo8+DHscyL1immjnT1ynxiFDDNck2CdLrguLigHowitv?=
 =?us-ascii?Q?hNudvCdYbaA8KR/nnfFJt8UaqxTvvwpppwqFEI1ow5YbmXZVg9R7+aqa92J7?=
 =?us-ascii?Q?BbRW9ZL629VXlzhpla0pc0h0NtkMD9L4QnwmHaDNoV258T3GXoiHbUWVkpWB?=
 =?us-ascii?Q?n6aE0nX0magpZz8rWh8me+sEos3aGAQchgtRtYl3DyVAvrdjd98xjXAhCGFe?=
 =?us-ascii?Q?bQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67cbc19e-388e-475d-5c32-08dcd3f627c3
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 13:15:36.4051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2M9ziRbS3XXlhtK40PExlz4yXeMI71tm/U5gMVAMrvW/fkCdbAyKfhZgbqK4M6a8q3TuEIVpsBIjI1U1u0chQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7519

This patch set adds support for simple daisy chain topologies in the
sja1105 DSA driver:

 +------------+
 |    eth0    |
 |  (conduit) |
 +------------+
       |
       | Switch #1
 +------------+
 |    cpu     |--- user
 |            |--- user
 |    dsa     |--- user
 +------------+
       |
       | Switch #2
 +------------+
 |    dsa     |--- user
 |            |--- user
 |            |--- user
 |            |--- user
 +------------+

Previously we did support multi-switch trees, but not the simple kind.

What is special here is that sending PTP/STP packets out through
switch #2's user ports requires the programming of management routes in
switch #1 as well. Patch 4/4 does that. It requires some extra infra in
the DSA core, handled by patch 3/4. The extra infra requires documenting
an assumption in the dt-bindings: patch 2/4. And patch 1/4 is fixing a
bug I noticed while reviewing the code, but which is pretty hard to
meaningfully trigger, so I am not considering it a 'stable' candidate.

I do not actually have a board with a switch topology as described
above. This patch set was confirmed working by customers on their
boards. I have just regression-tested it on simple, single-switch trees.

Vladimir Oltean (4):
  net: dsa: free routing table on probe failure
  dt-bindings: net: dsa: the adjacent DSA port must appear first in
    "link" property
  net: dsa: populate dp->link_dp for cascade ports
  net: dsa: sja1105: implement management routes for cascaded switches

 .../devicetree/bindings/net/dsa/dsa-port.yaml |   9 +-
 drivers/net/dsa/sja1105/sja1105.h             |  43 ++-
 drivers/net/dsa/sja1105/sja1105_main.c        | 253 ++++++++++++++++--
 include/net/dsa.h                             |   9 +-
 net/dsa/dsa.c                                 |  43 ++-
 5 files changed, 307 insertions(+), 50 deletions(-)

-- 
2.34.1


