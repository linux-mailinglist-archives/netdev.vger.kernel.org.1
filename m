Return-Path: <netdev+bounces-224269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 136EDB834D3
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2A097A2A2A
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 07:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E7A2D9EF9;
	Thu, 18 Sep 2025 07:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XLOudGNC"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012044.outbound.protection.outlook.com [52.101.66.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E682E7F08
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 07:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758180129; cv=fail; b=gs/qY5tNVFkq400pkDUgZWGf8f1UJ7LT1AZHDGQK3Vdoq1c/SIfXAaz/tnoDNAOXdEyieBMVuu1FxPjt/+ECQ0CPeg6QalzTdL1l/5p/PF+hGq2xtVk18QeKmcPIDb1RdJG7sM8/zY5hc8aMHEKpuiSTpkH/fLGRbnO8Kcyyec4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758180129; c=relaxed/simple;
	bh=H8bS8FfCtYJ0F0PE5kiG6wOCS4XBPrkfYDAbyGLTZfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CQ8Yfbet+Au0DmMSzr4cgC75tFHgrsOODz8sQtlYx4k7TJ0K83hMq01k6RdZHJDlSEW3kQOz/eeH9LIp74tE7VpaZ3iUGdqJabv8saJWuGdSeeYlrc3qCOsZ3JMQvgdPE0xV2nLG9jtJXRs6PVYBpQ9d2KqAgMNJqH8KEmi8Eh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XLOudGNC; arc=fail smtp.client-ip=52.101.66.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f39jS82U0HQIFRiWB0jTve7DcRiYmzW0LL2UVkIYwpXP0t/vLPiFphjlL/0WR+UWDNXX+qhU0ctz4wh5hsPswZlX/1MXLjTESvwyAqB9qwi+mCmo4x7FZjrBXZcT72cw6omYtahXqxUFw0SIMnwuUEJ8yU1Ja7J6xWfEQpTGKyxiVh4MvktWWyWhhHIOp1xjvlTVfSiwlCfFKcZFghNfj4u04aN+FMCgEcf+w0vuDfpOMIKa0iZHizWLIcP5goDQL8htIqpxHxb3a41XKg158K94FEN9CZApcFc2Y16E0Y4BQLvB1EI0gccGGnPf1YeZA2FT5bN0jmkQTF2uHZzDxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHOdT/CSAllKkosXSEDBG3RDeos3gLnXNK53iX7eolw=;
 b=wI3VZOgQYho5QXJUdLx6TABZY+OwBCEn4ZhcH0ysNQQ+W00Gafle0qc4K/7jCluYgYJC0gJhCKN787jx5Fo3yx9PN0oa9ZuhU3ylyLs+vpEb8yJBm/aVP3JgkTYLmce2o5HYW5asGI4e8hkNjlEWXIE8aW2oxiTQ6980mIhwbiZCLpWtpJAlGOQdcXdnXakPS3U5pmSnlOJNIYNJMKL4NuF5g8SkA1RdXBhJMQH9wulff6fMC1i10h0Q9ocek8yqh0LXUj9HKXMhVhrDV0hZlurE/xOgR4RhyxV2LuEfNSpQfme+VdKZ2WdNRmhBfAGOgpVxB1u20iiAwK7yfK1UOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHOdT/CSAllKkosXSEDBG3RDeos3gLnXNK53iX7eolw=;
 b=XLOudGNCPctgO3XqRyxzfD1kn/7RvHdyxn9SG5Kt3J56RepbwfPMPrzLoYkzqeQoiGg85Yo18zSOrV1dYBKWfCxsG0r5AIgr6CQ29l4tUuKWSbQyRACNA2fmO3t4CPcdTGAr+hBZiJwELCoXPFK6lar5eB7ZEYD06JxBobzzyEzUIFE4+zoU3wFSDS/3PwEGQQhgj+pwOC1iMlBA3QVkYY25kOyd5eSdejVy28kVJ/U3qpJuIMzb+Josab4/ep757rFoQo4j13h/bpGY8Xt8OF904R+07B7HiSmItA9Czda8lepEg8KycIIzcSpQ51oXbHodbwdqtR96+/sg+m/boA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GVXPR04MB10045.eurprd04.prod.outlook.com (2603:10a6:150:11a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 07:22:01 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 07:22:01 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Daniel Golle <daniel@makrotopia.org>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net 2/2] net: dsa: lantiq_gswip: suppress -EINVAL errors for bridge FDB entries added to the CPU port
Date: Thu, 18 Sep 2025 10:21:42 +0300
Message-ID: <20250918072142.894692-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918072142.894692-1-vladimir.oltean@nxp.com>
References: <20250918072142.894692-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0022.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::35) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GVXPR04MB10045:EE_
X-MS-Office365-Filtering-Correlation-Id: c2950ae5-ffbc-4185-a458-08ddf6840e9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|52116014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0Zt2lgFkLrUPkXzPuZV1AJkIJ9BXzw1arwppjK2MggW81a/vOqDvHQRN1jNb?=
 =?us-ascii?Q?9j8c9rWdKDYYtcRBUCCL4zbpHjA/RwbbGRt+HYQ4Z31V2RWGZne/4eZ9nAB3?=
 =?us-ascii?Q?CiEhcPn3G0Kct+7mbGNVDYFY4lUcPCezD809UWIgGQG1BeokZSmp32HPK5zZ?=
 =?us-ascii?Q?d/5Qj9EwUnFisSAIWkVRAlPkSf4duKGeG5kDuyKrErNJMfndGN7okglKMfKA?=
 =?us-ascii?Q?kKSHzZf/Hkf4UHGNCCQOXlVPC3lAw3pIouDDA0b66VnWqS7Fxw/IhMmoh2jR?=
 =?us-ascii?Q?dlOHf2YDTR3RNU49ov4aM6ajN9TJp/kFXwKGGacdtlixRf9yoaU+ALVdI1ME?=
 =?us-ascii?Q?dg4LlSvz1549P6QmIaejRgQDf8LO0hR9HiUO34hj4N28/4ze8WiQuur9dfjl?=
 =?us-ascii?Q?KNWz7h38/kXWFjA7e0l2EoNktpUEY1ZGdznmcck7crS1WpeRmZj1LCpu5Sg0?=
 =?us-ascii?Q?+ScMbz1WVZHBoX6aA8LAhqQs3E4FtovHW+ocnRWaAzZOLMR8oCdK8OOWh/8u?=
 =?us-ascii?Q?6vcZXnHi5KCpDhdGChyG8XROA0Ut5o/ceVvCjf90kImZG5qLvKkrgisbdZKM?=
 =?us-ascii?Q?GN5ygcLljLJSfShruHOutiApvR32vNEO6yPMNN1TcgXFNKRIgXTDpJ56ewN/?=
 =?us-ascii?Q?/BaNxbYGdKAGcgVpHXuTRFlXcjnzFwr4hJ/r7ErApM7fdVwFzEarCc0MEeiy?=
 =?us-ascii?Q?IvDJMXqU9hLF27XNJbS/g+Zx8bx1fVxAnOaocJIBtu7fuyVYv76JiTR6mO4t?=
 =?us-ascii?Q?XnqZVVlWsDZm+jjiZZcAmFQOHt2n1KNLhE7o0tUC4kI3A/opSwhZ/tikHG7u?=
 =?us-ascii?Q?d6+Wubl7wHNu20aAHNMW9inCIu90UTqzSH1cYS6CMoNifl+MNtxDgqsoKDe7?=
 =?us-ascii?Q?lza6WdQSGhUkt5FettVg23T4kfMPbgMgj1KoCkKMJi0b9zO7O/GRk5DXPrzw?=
 =?us-ascii?Q?UYJeHUwxPml2fHKNpsWv6NZ51Dsl5VUL6FlsymbcTSwPS5nPUVz454b5YUv3?=
 =?us-ascii?Q?tW13+trI7Uhce8nFFUE5YJXWxmD/y4vJvbWQ6N2JXcYn7nb9wXQxikBxMydw?=
 =?us-ascii?Q?WRRbj4lyJpkNwH67BhKq4CseTUnE7u2IRIgpkFRcBnhyJm5A2vmr9YBKTD/y?=
 =?us-ascii?Q?PSr7TlVLgpkWS1IQ8jS9yuhMt2ywV8iN2sOiQNeqYfRqns0+dy4iSeThlD7O?=
 =?us-ascii?Q?lmEDQoTchdiRGNhm26vRORWaen7fNjqKY3JmPgbDJNXmYP3oHc7wyZ04+MZU?=
 =?us-ascii?Q?xJQRAmi9P2AiReWJLVcEZCg7oUUVNdZLlhHD7RO9XgTALhXJfuVweCPCUdUX?=
 =?us-ascii?Q?/LnPJxx2Gn6+UAuOlIQyksjupJvDNw05OWLkognJzkrzrXGALtcnAoNFfTHH?=
 =?us-ascii?Q?FfV2eCM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(52116014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KX8wkot7F6bj4QqQIKi53Mm8EVQWMseszullidnXEJfk/0gC+RtMkJftacq0?=
 =?us-ascii?Q?H+YS4il37IVKH60U65RhAMFNXicBTKoBmFr6DBhSoKHtrnsGREUSl81/lnmo?=
 =?us-ascii?Q?75GWRAANDebP1G/WyzdjEr53v1RM48RqSgD2gOoIn17YWf2ZuiPqhvYrSSdn?=
 =?us-ascii?Q?URJP2lY8HDjTU6mctWGMA5zRJhucLpa8C64mHg/YP2v+Pyq2y8m/w9TAbpq5?=
 =?us-ascii?Q?mjYHPJdMRxB6VzRAHC5rKi693Ju6jjF6upCpvEktRkIvcD7xShrnHnh/TI07?=
 =?us-ascii?Q?062LQBs3PIMTiaPDT2yRpefXNsUS0ZrLgfiy4OyyP/mxCV+35lF9hvjs5/Vz?=
 =?us-ascii?Q?KJDaLBqC8SFku99jNX0o+0iB9/LavkKG2mNWyQOOXWBEbkWXjE9PSfeUmd13?=
 =?us-ascii?Q?OkzXMPP64BucSQcA8W/OpYhqk/ILW1ZXrgJIi2K2urPmlLQR7P4mZGG/lptU?=
 =?us-ascii?Q?YgNCXI3Q8TSPVZ3A2AGVjlDYPItMCzBtLPmCz+sFHVceD2dUeugHF5avwi5r?=
 =?us-ascii?Q?d/yQpd3Qt9C5wB17rlnO+bsZlWe5PW01lfXkbtA59rwl2iqi4wHcIys1DFdk?=
 =?us-ascii?Q?uhtrE5HSgYRCr71HTnFlSFTUeeeDfnjlfQCpmCvTe8VnqXnWFFqI2t4IDfDf?=
 =?us-ascii?Q?3VyZuw19rVFiDag2m3YT1Ywq8ycdn9sKmgedAyMdeup4fBncxjqyDMeYLdnf?=
 =?us-ascii?Q?HkjQfTZxqoqnHq72Dk4oaYvtrY/yJSE3z4xl4K8iEjnhWPePTmPIxZulnvzy?=
 =?us-ascii?Q?KNj7knmd2DLCckADhnaQreFM/Up6yyWfXBdtyqm3pJEmLZjP70CXRJMD5dl+?=
 =?us-ascii?Q?wAyzdUbHnyqhkiK8xMSeQ2R5wZjPjlp3GfGDiZ4HaJVa+yRmqNUBEOZguzWk?=
 =?us-ascii?Q?/fKiq2XerGX4oHxtF35CxCk38Wb2ozvL+BioWyoMgO9ct8FCuDzz6Df8xCTE?=
 =?us-ascii?Q?qhwFCpGp4d507S057ORrsbNcABQLnoo3uw2DHBYXP6AdFF0i6zx+VSEtv2tZ?=
 =?us-ascii?Q?k9Q9U3OiRee29jqo4fCb4Nxk+eJeh5FrBnbaZepMKXQS6+YfnQ6JGuT8Z5IW?=
 =?us-ascii?Q?Mx2TUzRQJNvImWb3ISYUu+PwO9r2ajtxnfY/qiWusdeoJaIV3ijIeHWXsBlJ?=
 =?us-ascii?Q?eeXKdbWSfgsFjmdAlM+5n/0hsjwoUhDRLgoz5H+SGJaYDS0fjdWcmVk+/9xb?=
 =?us-ascii?Q?VuqiDyDHk3hidoCe1xN1cJbP79daV1DrdHqPS3IX6RWClkR67VF22h45w1kv?=
 =?us-ascii?Q?kOoy3KRoK3heIEMjHtjIqEls+uloWlOSUcbP9zq2fIZoGos4PC9cS/PqwvEB?=
 =?us-ascii?Q?W8b9wrQ6IhMiAPF4jCUellmf6bNkWPArq9Cbq9Z31pBsx0fVcGn4y/Bht48X?=
 =?us-ascii?Q?vR4m06fyGGB+G7LfwX1Kgk1aEp8EbGVwnKnbXOcR+9QItwaAfpaZwWo8u/fP?=
 =?us-ascii?Q?MidERSVtS5LDd1BIreftqcZELuY3vUp43Kp+LvFOpxG9V0fvBx0tVY52ePuX?=
 =?us-ascii?Q?APireHMztiTztYrNOf5aq2q+wrm03e02GnlVcb2+sUIwFZm3+l0HaBMEswWw?=
 =?us-ascii?Q?6AC9bzPKmbiaLMnlszBzKEs1FocqLWfEkRwJyF4myqaOC7ewXi0zTK+mbM7y?=
 =?us-ascii?Q?y9boSEGEx04i2U2CUtG2MnRNr+KMDO9ODCGPif/YLrCnKp95CQiG/6CW+vT/?=
 =?us-ascii?Q?33bwQw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2950ae5-ffbc-4185-a458-08ddf6840e9b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 07:21:59.9461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fYwoBXYZE1oXF9JFxE9/kVJzfDm4LYJleoB3fdtgpyS6Iq519LnSyIQfCrDBkQ4UEuoVBF+uLkjIPU6VI9IS0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10045

The blamed commit and others in that patch set started the trend
of reusing existing DSA driver API for a new purpose: calling
ds->ops->port_fdb_add() on the CPU port.

The lantiq_gswip driver was not prepared to handle that, as can be seen
from the many errors that Daniel presents in the logs:

[  174.050000] gswip 1e108000.switch: port 2 failed to add fa:aa:72:f4:8b:1e vid 1 to fdb: -22
[  174.060000] gswip 1e108000.switch lan2: entered promiscuous mode
[  174.070000] gswip 1e108000.switch: port 2 failed to add 00:01:02:03:04:02 vid 0 to fdb: -22
[  174.090000] gswip 1e108000.switch: port 2 failed to add 00:01:02:03:04:02 vid 1 to fdb: -22
[  174.090000] gswip 1e108000.switch: port 2 failed to delete fa:aa:72:f4:8b:1e vid 1 from fdb: -2

The errors are because gswip_port_fdb() wants to get a handle to the
bridge that originated these FDB events, to associate it with a FID.
Absolutely honourable purpose, however this only works for user ports.

To get the bridge that generated an FDB entry for the CPU port, one
would need to look at the db.bridge.dev argument. But this was
introduced in commit c26933639b54 ("net: dsa: request drivers to perform
FDB isolation"), first appeared in v5.18, and when the blamed commit was
introduced in v5.14, no such API existed.

So the core DSA feature was introduced way too soon for lantiq_gswip.
Not acting on these host FDB entries and suppressing any errors has no
other negative effect, and practically returns us to not supporting the
host filtering feature at all - peacefully, this time.

Fixes: 10fae4ac89ce ("net: dsa: include bridge addresses which are local in the host fdb list")
Reported-by: Daniel Golle <daniel@makrotopia.org>
Closes: https://lore.kernel.org/netdev/aJfNMLNoi1VOsPrN@pidgin.makrotopia.org/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/lantiq_gswip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index d416c072dd28..84dc6e517acf 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -1368,8 +1368,9 @@ static int gswip_port_fdb(struct dsa_switch *ds, int port,
 	int i;
 	int err;
 
+	/* Operation not supported on the CPU port, don't throw errors */
 	if (!bridge)
-		return -EINVAL;
+		return 0;
 
 	for (i = max_ports; i < ARRAY_SIZE(priv->vlans); i++) {
 		if (priv->vlans[i].bridge == bridge) {
-- 
2.43.0


