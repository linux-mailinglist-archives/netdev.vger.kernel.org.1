Return-Path: <netdev+bounces-138268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E469ACBB5
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22212285040
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500F61C578C;
	Wed, 23 Oct 2024 13:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bi2jYCf9"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACB61C304A;
	Wed, 23 Oct 2024 13:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729691598; cv=fail; b=KHSkVotNidLF5q2ZKKdy2Fq7OfSLA7RXaTZVpflBlV8xefe0IbjI0zJuuepTUL3wdvNmLgevyHDQfSnt5q+FvxF4yzAKOave3SRLKV0NluScxCRhNVMOSXuNOdSUMeYGEvfqdzQgyu9j+BrZBtjpJFUjZ1TzpwQm3c0473BWZe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729691598; c=relaxed/simple;
	bh=J5nqIxJYCbjEiBLFDxqkgyhH2Xb70Yfh/m9zFeZCmec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fd0I8NaqWWDL7nbgJEa+1+QVDuoDc9KwSSQRH1uRbgES9nCgJzMDyOYZ4P0uJFM7CeXxgUcw5nOHTv8Jhdeu2Qky3EZg5YL7Du1CIsGBWX3LFL0dYFopXHZsgqDg8D3ZBcFD8q+F6pwCqLLkgbFIS4Pkip61ujhT1XuEnQpmggU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bi2jYCf9; arc=fail smtp.client-ip=40.107.22.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQRi+rV9oAa3HHvDmed5c4n4Hh94ZFAnVayeb/pIKmqjDUg724gzs/qZmmg7+tNVHSxUjB5FZdU3GN2fI1ilkCcwj8lKMaHRSDvAT+FSkD5VAFRr9LypE8olxYP2CDEMB1f09scQkJn9fAB8aecwnl9bPKcDHxziHob6IP0hDhkpOP35t56xo7HESmJ6mOgfoXEiQbRYxZOO4j7AuV96br9cJthXZNv16V/mrpuY6sCA4YCNtugSbc6KDKM/h29n7lrBsdq/whxLHe+eAbAE8h0QZZfDA9rz8j979Klf8wi64JCBj26lO5DrakHKOFbjGI2SpInVmxwycLW+rJabuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQTNKadeoYs6F3NyWhGH5i9TxE/78t/tgdfthC37ucA=;
 b=Ww8lHbB8PwLiGT2xG1sdI1D6Mi0O9YN1zDvX5+rA9YUE8jqiPkdPmQwwtM9KhUECupwMvINL4iJ3drG7L/wmpenUR+F6WKqn2lQMRxzpNBMMWDtofdZrDJu57uHTAhmWmVSV9pQEZJexGlef4faKItzgPxjLQGAzmVjnY12nfcg+z8ZLlCfeyOwmD1lvbYHsAjc729FQgfQeoKgI3Tya62CK/ebsYeb0ziN1Wg+wcroK0/s0wmZN2h/8VYDHLDqccavaL0yEBtVf0liuLHg0Pv3/O3v+ILd3tvNBq9Peqs9WFSZfNm7PO5vfu2RRSlaMjyy1VYpdfXuDX05wkI9P8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQTNKadeoYs6F3NyWhGH5i9TxE/78t/tgdfthC37ucA=;
 b=Bi2jYCf9l+36wP8Lz34r1Yq+LdyBqjC0Leb5yzb+D/pJ7+wLYs6c8xwLDDtNFepUkjR0MrgN4bwEOUWcvJZaXuuszv3T4lK2je8YP3qFvz3mFTfpXZeOL6gzcPhPveEX2MW9ngNb7vDnmLSIJk4nXQ/K2CbHx6xv1Dph/gcaH/AsFypWzQU2Fvh3vEO7zHFyu+p6VGGnmTvQxWPPkIRhJZyOKeGzIMibQvnYEF8I5jPLqQ3a9JNQErq/IqjDTEUeC6+tA8V0kwEqlzN3K7DhIPrfUvWJxlggVqxpCWVS2O7Ne32kwFlq8yRCy56yqWU10Ou4Tz9Hg49D5/SRx4/X+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS1PR04MB9683.eurprd04.prod.outlook.com (2603:10a6:20b:473::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 13:53:07 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 13:53:07 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vlad Buslov <vladbu@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 net-next 4/6] net: dsa: add more extack messages in dsa_user_add_cls_matchall_mirred()
Date: Wed, 23 Oct 2024 16:52:49 +0300
Message-ID: <20241023135251.1752488-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023135251.1752488-1-vladimir.oltean@nxp.com>
References: <20241023135251.1752488-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0105.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::34) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS1PR04MB9683:EE_
X-MS-Office365-Filtering-Correlation-Id: f4638d73-ca06-4c10-5d35-08dcf36a0617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A5aof6VUiVhzorqZfrhIKzS0Dqabq86VfvP34HeS4n0uO42gBtnj0lRwiURw?=
 =?us-ascii?Q?euJiH82nLDCybv/fbywb6Z5PmQNe4MrYwd+Ke47H6T3W/RkCFWIiRYUdUqrY?=
 =?us-ascii?Q?D0sOkxk9bFFiEvjmqRE/rJRY5kJCaJ+FYh663bNybbpIJbj4YweqYtCouu5v?=
 =?us-ascii?Q?qIkRdBifalCzoqluPlxIEz534vSa0F9B4cSc2UOvIDxEenXi+LqVZfKULnhM?=
 =?us-ascii?Q?7HwLXAoGzDrHk8pXtPL1mcWh2/0QlpQnDLAEfA1D6Mbcf98/B5mYygzFldz9?=
 =?us-ascii?Q?ROU9I5V5Wyctr1A3h3lAI2dKgQ30MU+OEuEIZ22nZ7K4QRZ9w4ZiOndInCTB?=
 =?us-ascii?Q?Llg7bqWe3d0OD3ykXU9Oa+QnrI6vTctJ0J4Y/SYiKIY8qiNnM0rF8vYNQKEX?=
 =?us-ascii?Q?ZKTp3klbXcEho3XpZoP0IA1M60iK0UAG1EQJ9cVlFZKxJt81KylXtZG5V17w?=
 =?us-ascii?Q?G5wkyqVu3T7VLkexGy+6bkgdolWrSf+T2tnbSSSLF2jax2gfUDjZlV+IYpi2?=
 =?us-ascii?Q?ZACLRB9Q1wNJDtAIGNGcP7D/tIddadTphZ5oPODqtz/RfUkobTXpt/K5qEHq?=
 =?us-ascii?Q?FENwulKcn2ao+jeAG89JB59wuOR5KglIqmTbuyFBpB/tFFcCElHZElpPTjB/?=
 =?us-ascii?Q?VVI6bGVZCHadcNcHYp6nv0ZPZBSyO7/0sH9sBeWk0O9Ck251CmT5KPK9uWxq?=
 =?us-ascii?Q?QRQkKmusriQ59esrL3TRSCrMSO2m8RUNGaUOpOELBmltB8y1YZVxSSVwoyAM?=
 =?us-ascii?Q?ZwxPiuOHP9BAFNAI6ld8oKVr8g5CNAdi1nKCJm35OwUdduSunohyPBtZiuSW?=
 =?us-ascii?Q?yz+fUStbz90SbyAjI8Ereg5HjwTHQ9ymFWWZiWsIaUgvmkFXd5jtRqujakxz?=
 =?us-ascii?Q?bo/GhTz1jaGjh92T1BAwTwffOeCwJGrw+3QNNMnQ23vtLhPld8dw4l6OZ2dd?=
 =?us-ascii?Q?lY8G+x1OkyiTsDzMZcUrlnHlQOoBgCHYHY15ZVo3xV9lj6UQIbdiaNbCS2Ko?=
 =?us-ascii?Q?dpNiDa7QM4scFkvAq5Qoh58TECiRZTYi4Zp3p0sTEVj+RFiq/oSkI/BQU5tN?=
 =?us-ascii?Q?v5poSmYTFcIdovazRzFqPFlabg69MLMXmTbmubp6TF7IXCn1nAIEeks1qUiN?=
 =?us-ascii?Q?TOJLiHxCKCj/UjxdOMCh0Hyj6QTQjAG0YCKU97Q7IyU5k94K5m0kPuzAShOR?=
 =?us-ascii?Q?+EctteVijwfNN/IPMy0sXvC0Obtg1EpAFWVJuL6RZ+MFw+FKCoVSyIHMnf2z?=
 =?us-ascii?Q?dmwJtIZZMQ0zOQCp43Bx5VPW1kKrI/2jWx2Ia4ZovIoJLpevUVqyyQSz8qeT?=
 =?us-ascii?Q?zPjlbsalT6XIm8XZgXIvV5keZ54IE/aRJz9sFQycwbA4IOou+cssuejklL5G?=
 =?us-ascii?Q?ONHN6LA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?64S2PlVIKRXIG64UjwsDWHgETSOSu/t1MXZWcSuJRf2V/GkouFRTpO/nLCXl?=
 =?us-ascii?Q?TIkwbTvYD8Eeo5S0HmTFuw0VvJOvTeHqPwzbbO7LuXVwPBYhB7KVhSrORxcv?=
 =?us-ascii?Q?ld/RPHf86JQtXq+f9/7tvv/Ad19N/+wazsvjniWVP9pnEHlFKOOaAXep3b7x?=
 =?us-ascii?Q?M2OTaIoQ0HBBp2kMgcBNrQf2Of+jrfNFookFARMe/QtyfB7Z8nQD7KZiy+es?=
 =?us-ascii?Q?QGbMxN8cqDvg52Jx2skfmDh98xwHhQUsfoaz+eqRjjEhmtFMtIEV8wcgVNyd?=
 =?us-ascii?Q?EN0JcOIQJdcH6p+YVkC2uQp6UxNEg0jBgBG5BMyGPuKRFKrz8QAa1h0A+3re?=
 =?us-ascii?Q?FUrPTn92DchTP6UNyxNsgdlgQQnYbYsWmYE6Vk71is/Wuv1e+9rayIu7CqbX?=
 =?us-ascii?Q?50Jj+ti/j0QRkWTDRwiTJ5PIsrgSgJwxVpcSUFz04Ssio1MvL8StiYAHsZCZ?=
 =?us-ascii?Q?F4U3JnD3QQUmGL+GYpfJKS0hNLe2wslP1jT7RgpizxyQYEGQz5m/BNgwncV8?=
 =?us-ascii?Q?lF3JR5/EUN6ByveWbuCTiy+vIgKuvcfwsXz+VqnNP0HFcSrhj6e0OglO23wg?=
 =?us-ascii?Q?lewJy/mUGKD2AYpIO3y8Mvf4OICriLh8c67URqo2H+VVZqHQ/FfKu5csRibu?=
 =?us-ascii?Q?RRmzpE6zJWxAiniQx0lrPIwho39GtrrzXAuB4/XAkDmhadu/5HgbnD7rrEgT?=
 =?us-ascii?Q?2UO9nxDj0cuk2yk5W0si4X1GF91zpas0ciZKhLvmVm/r/waRhwhj/I2kX3Ra?=
 =?us-ascii?Q?acgWtheeXreNraiO2xMzNoTS+Ht2MohRudlticaOE1sRfc4BpGW/p+ClMxx7?=
 =?us-ascii?Q?Mj2n6l95idYAFvMB5ORm8K+PuWC6F7EowJiht/wSPS/3iMyCQMQZnJDoedrt?=
 =?us-ascii?Q?qCtFqqSoftl5FPyHrB0GA0FHMaGC/DR1SNJ8JtCN8E0xwoJdS92CT8BvdFtr?=
 =?us-ascii?Q?0YgFMMifCwAl48WTLCuMuX3O4nccV7WFjtHmM8EhnKVG2JKqdVmAC534YtHX?=
 =?us-ascii?Q?ysyJi/wN72Owb77OYdKyCmISFPmQCmuaVHFIZomSFIkfFYEn+/66rONsIIX/?=
 =?us-ascii?Q?lfco1Q/po1c+zUh8m1eK0c5KkMSNXHkKjMEhjT7PdmHpHboToioaTqovvh1z?=
 =?us-ascii?Q?s+8f7QQlbEmCyBNzcqYW1+zhj6hz8IUoa1RqjAT2CwUXmxFoySgqK0uU67I1?=
 =?us-ascii?Q?VydsnDtzRrc0ejuqZblt0y+DTK+MeqXg4KYseF4gj+hrCLyxv67t7iHkXfHr?=
 =?us-ascii?Q?+EIOSfalUNISZzq9g68PsWQvueWpC5UtobMlkixEhmmyEuP+moQYRx2NNHsl?=
 =?us-ascii?Q?tlW4jzjgws4kEEEKZVb5HCgUEZ1D2O3ulqFPxC2M/tZuYNo1oIY8ra3lD9T5?=
 =?us-ascii?Q?LcY1/tHHD3L625tiIXsdkMcY2SR61aqQmppy31wS7qIxdC4G/RxtjEcwM651?=
 =?us-ascii?Q?Xa9tKLq/Ly3pqc63V7Qvu9bf6Iw19/MXozaQywz2hOY+DvFrJn7Rn2RG+POz?=
 =?us-ascii?Q?tiucU9kMKj/Ddr4BC47asEvmPNgQAanmsInP7q6gberQSHrIICJvGvs4BWz2?=
 =?us-ascii?Q?Xo+oAyxLbwktM31SFCVFraSTl0C1ZGDsMRm0fTpPDMnh0c+Tkamv+wGyfX58?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4638d73-ca06-4c10-5d35-08dcf36a0617
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 13:53:07.5854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QBdOwFkJ9yZ0zkbLF1WBFDSHXjRJnOeu/ntfFolzAbagDlImVcHHhFDam350usKGMkXJd0y4xwgri1EVr/wy1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9683

Do not leave -EOPNOTSUPP errors without an explanation. It is confusing
for the user to figure out what is wrong otherwise.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v3: none

 net/dsa/user.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index c398a4479b36..2fead3a4fa84 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1377,11 +1377,17 @@ dsa_user_add_cls_matchall_mirred(struct net_device *dev,
 	struct dsa_port *to_dp;
 	int err;
 
-	if (cls->common.protocol != htons(ETH_P_ALL))
+	if (cls->common.protocol != htons(ETH_P_ALL)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Can only offload \"protocol all\" matchall filter");
 		return -EOPNOTSUPP;
+	}
 
-	if (!ds->ops->port_mirror_add)
+	if (!ds->ops->port_mirror_add) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Switch does not support mirroring operation");
 		return -EOPNOTSUPP;
+	}
 
 	if (!flow_action_basic_hw_stats_check(&cls->rule->action, extack))
 		return -EOPNOTSUPP;
@@ -1488,9 +1494,13 @@ static int dsa_user_add_cls_matchall(struct net_device *dev,
 				     bool ingress)
 {
 	const struct flow_action *action = &cls->rule->action;
+	struct netlink_ext_ack *extack = cls->common.extack;
 
-	if (!flow_offload_has_one_action(action))
+	if (!flow_offload_has_one_action(action)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot offload matchall filter with more than one action");
 		return -EOPNOTSUPP;
+	}
 
 	switch (action->entries[0].id) {
 	case FLOW_ACTION_MIRRED:
@@ -1498,6 +1508,7 @@ static int dsa_user_add_cls_matchall(struct net_device *dev,
 	case FLOW_ACTION_POLICE:
 		return dsa_user_add_cls_matchall_police(dev, cls, ingress);
 	default:
+		NL_SET_ERR_MSG_MOD(extack, "Unknown action");
 		break;
 	}
 
-- 
2.43.0


