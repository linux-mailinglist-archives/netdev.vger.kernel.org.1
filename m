Return-Path: <netdev+bounces-242806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4D4C95011
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 14:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A37D3A4E43
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 13:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5E52848A4;
	Sun, 30 Nov 2025 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DvdCdsVA"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010044.outbound.protection.outlook.com [52.101.69.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F6B284662
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764508670; cv=fail; b=j5rymrD8POFTsz9Vv9cUoGV3kMXT5t1gTCF1HWZArh6FW2/GMuP3C3TWE99HptTXA1A6DplZHqzEcqxHO0MkUEDAeV5XxEu+lPwkgv1501DUdtKsvdi6vLtu91pz6jLJocb5avOTPud0WUiqAKsWN1IPW3f5m+Y3AUV3lQdPEdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764508670; c=relaxed/simple;
	bh=kqyDe0QYD5uAbk6zCPwZloi73c7MflcoIcpJG98f4Rk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kw3KsIq4fbu3WYLIyYJ3AIOr/Vk1uT5qcTvSeW4LFaaNqWVcIAoOhyUe7OF66IAqJv3zjk/j1JyduqZb7U6P90p1EN8YWOTaxkq6nba9e5ObfY6bXCwiWAf27XKdleyoEx68MQ7tFgEVZQXxbA0YDeOofmG/w9ezvD/G6un7lTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DvdCdsVA; arc=fail smtp.client-ip=52.101.69.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMV9d0fjIKs+8aCTXHZCw6N9s3Gp6YZmmoqfruRNoZCKLiMLi7Ir/6jfvmS+k9NCr99exEcT4OGxvjgg0SqUrigA23EVV222oLYThvMrbbBEJvwnkkUTVvH5DLmCVLU70RfSS220I9cvG3ld0nuuUc+/tsKj+zuCEcfiXw9q99yjFA0/r3bpy4i8xPzWIUycq/ZaJvisFJWrGTgLNTt/ndijeNR1b8rocMmZD1DWnZIfmdvYTBorXKK0dx0/ZOBzx5VHfXH/1EeNKgqPNeF9gCVNXLNm4eTIIuPwxQwWAtiuEZqA1MhFQ3Zokr6zm01axDmxF45OWaVGio1i5kEYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YePZclw3IvsNQ0k5mz0b20B7hNOLuVhO0kIJDy2adsY=;
 b=WHeL/3IaoeO+cohalc11CoQZbVGDDqAlrpppSzLjCIgydzCn4AGBwzxW4edZfz4RsjF2co1nekRccFJ65PwqCxCtVxWQKpI765O2cWnh2OkmPyKXOblSLq08JUbZSG6/uTsYBTqirRxkQ6FYSMu00n2lRSJQMy8CDCJZbx4jhvUmzqQqKSPrCbURR53zSNldQVWpYiR6lIpvBrW/WzapzoS+6O5d9dRps0NlW1D2tP7VhvX+Y/LDqjcDr4hST/Bfl+KdrJ1KGlCm1AdImJzeJqX5QKrTdVfVPIDrdTrn9UvJf2NYuAJtBmgrJG7ap9/fAnw0Y1EnLf355CfYk8R13w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YePZclw3IvsNQ0k5mz0b20B7hNOLuVhO0kIJDy2adsY=;
 b=DvdCdsVAc7pKEoyEAZQWGa3Q9QBGt3DzcuCPnK5Y5UpdzhD4ACVYQqj7pz29w/RRiv1fd/6co9w9Z+KJl2JuGBSjL3syNA3joIU5CJTEca9tFaqmCkOiw6YWmzeIArITMWRt9xvRGD/6I6WzRNGQ/OoQGAKzf07jqfasBXM+tGVUK3OHEQIluFTNN2NoWNP9dNq+vaT0NHepgjHjC6u5u/Y9Kt10RdPGlww/jA8zxBcH7mX3ro1oeVVr332RyFY3SrJoM8Kvf5ui90rBlipG4g2QQQFORZPo3KiKaEKRYdfxBqDAdbENdAioojy/hhFXb/LdiU6LkFc1pI7cxy3i1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM0PR04MB12034.eurprd04.prod.outlook.com (2603:10a6:20b:743::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 13:17:38 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9366.012; Sun, 30 Nov 2025
 13:17:38 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH net-next 11/15] net: dsa: hellcreek: use simple HSR offload helpers
Date: Sun, 30 Nov 2025 15:16:53 +0200
Message-Id: <20251130131657.65080-12-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251130131657.65080-1-vladimir.oltean@nxp.com>
References: <20251130131657.65080-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0128.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::21) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM0PR04MB12034:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b17048-0ed2-4356-7b76-08de3012d54c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qYys6H8OuqiflGPZ68EOjnp+3bBCN/8qq8Mg1n8i+pCGNz7azjNHYK0PJPry?=
 =?us-ascii?Q?hJzb8uai+CLZ8V8iBXhkiul8MmnAG5xBqIlHwmjsVeittDDK46NsMbjtF5UN?=
 =?us-ascii?Q?B9WTarXTOxnTW/Hg0RSrZsIN/ezjStiXV/P24tFvhb/dy/AOWaMI4is7zY8t?=
 =?us-ascii?Q?34TOlG1FAaY60oL2/2qV441Q8IDBycM7DlAz0K7obE5RolaISRQ9G5Gvrg2J?=
 =?us-ascii?Q?9s40HpHGbXveswV3qf8c8UZUh8aBRzA4YDZcLnCyk45yOyQkw4xMHs3rsN7/?=
 =?us-ascii?Q?beYqt61tHTiLln33rmWnRSQ3yIWgdSMLWAyAjzKZ9hc2r0Q5JRimQOE+odQM?=
 =?us-ascii?Q?fUtFe00Lnh1VtskvI4EQY2q8A8IXO1373Ipg5B2v8+c4U6gYv1Oy5qQ9vdeT?=
 =?us-ascii?Q?TJ9GBoqQNvtcalKDPl6zx2BilJdcqXntG0m+l47rW/LKzyjL0JWyuqOtFeRf?=
 =?us-ascii?Q?/oTc2eMk9yAqDk1a6TbeqxCbrOP2kFKF1f8gSFRHTADlDySNjLJmpcBVJYCG?=
 =?us-ascii?Q?YgPNCQL4pXgRxbe1XGNjrKjuaHDsXJcwUlbEmGmMmGZ/AMiPKJl95ZPcvwDR?=
 =?us-ascii?Q?56hM8yNTVFtBIqp5zOfvx/3dJXzebM7/yD0SgU+i/1stWz3F+/lrhektovBG?=
 =?us-ascii?Q?TW/9aEFjEWaTHNReTSdMdGoUzs4SyMfMtJ16Q8U4DGfPY1Y+p/QCGK69Mt7E?=
 =?us-ascii?Q?fh7jsh+eP7u80m9pNHmZn+ZBO2ROy++4pRPIMPYzlcD3wyd6Arv7q+WAPlt5?=
 =?us-ascii?Q?PCFdZaANMkR0CWLotJcgrSU/DtzrESbmqACN7396KNyfZbKTt55qfdIfsefl?=
 =?us-ascii?Q?s/06K6wuXtoqitBjn/oZXJfiuigxUV6dyxc0IqnJQCCWCqCCpOJ9bxGq9qPg?=
 =?us-ascii?Q?f293nLjYWN7B/+2DUz4jUjHP6CmwIQ7NGo743Qc4HxyynQb/4TNwIiHE6Et5?=
 =?us-ascii?Q?B64gy2jsuyZ2SPjpktB0QOAhDqPWxAlp+c8P2yQTXJajmqUe1BtUMRO+TVg8?=
 =?us-ascii?Q?LPJUhqQjU5d1AUofXQOxTjSY/xmiKtivvzLwFd+yrKFC26whzUq1+Hh/9+nK?=
 =?us-ascii?Q?dAY85xFJtl1jetEbdRFUnAn+pmB3tnHPfzT7Mj+kU1aRef82t9nuDmu6a7B7?=
 =?us-ascii?Q?tUgALubX1HWbKJtH9tlxe+CO1conMGaKzfmOetJ/EaejqJksA3FerUqhszRk?=
 =?us-ascii?Q?BnTwEKbFcJRyyUw+12nXi7EhvwjDFVptyE493Luoca9StPwLB1rywE8VeZFy?=
 =?us-ascii?Q?NAKimzT5GJkYtuSNO4lnhuvbbprE2OdJDDn+5uFq7xPeYVK+FZ7MHR1QJwNy?=
 =?us-ascii?Q?eHuLmCEmYwCvLNhis125bpL9+qto+gcbVTO8gLat0i/z70sGAh0KepZIQoCF?=
 =?us-ascii?Q?JhdO9sgv3B888KRABtnbo5JvXBjU1z1PXN4TpIWaWwfkq/o7a8Z5gl/Kh30Z?=
 =?us-ascii?Q?hAwlIf3xNmJen41/3bPuPsMSnnbmsaXsXjzGwWn5NcgYi/c9Yfa+6GiP1W81?=
 =?us-ascii?Q?rv5/uqHgD1D6wJqGgZrDKKJtNv8SZ47OAL5d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fqAaSaHcJCAf3TiNDI3Pbmep18G3/OZLyJ+4VnOQZQca3SP+rC9Lp0eNqmvE?=
 =?us-ascii?Q?LJmwdh0icPRMmRvgtF8GSLRvlDLl8M+cC5eIAaugjAJDKxBM24hlFknObTk+?=
 =?us-ascii?Q?tZxJ3LyQLc7JO6idQLvo9JOMPQcmgjazVCoxv/UGl1QUIiaHM5gfeiG219+Q?=
 =?us-ascii?Q?0Q9hJNWySxo0lHv41OnHcLIf+H+BPd+K3soj5hMQFPsVrxZulvbNKSuMjazP?=
 =?us-ascii?Q?Ew+mZWPCPylD80rB3vBCaOEQqN3LvjfSJqNobpfcWUWwRgLCh2KtePyguK9z?=
 =?us-ascii?Q?XmFI7faDS9yPnbPKche7B1pzUrOzvwrO1x2aVdlpH8aE0GoOmc5zrxCDG5r5?=
 =?us-ascii?Q?HTNOzGkMTKpClY+sYuKtDFeytC2Q2zkXBYvIegK0+GmKRHwSqeSbpGZtAtFq?=
 =?us-ascii?Q?TtOcOqB8/gcBU35FwynrjnqfY6I393bZVAKqyEAvzSCQMoPfc35ajr7beHYk?=
 =?us-ascii?Q?W5ZXx6wwuYv7H+JdSMuECY+sWn2D7GZyx6mSGA0rSKNPtgfHhahVrGJSY+2f?=
 =?us-ascii?Q?xJ5RNKl3sjXouVdbW20KgvAEtbnFcxA4J88BW3Gotzev+kSPQG13d7WoRlNP?=
 =?us-ascii?Q?bb07DccarTKmw2r45ghEmpuTCNdRbXebLJ9MfFcLI2UUGVD9VPtxVsZsVEsZ?=
 =?us-ascii?Q?A4GFl/ghcuhwE8unyzCdlW3Eq3+ABuMqXFnSzYA7S99XeeFsVd7BCbXRgU25?=
 =?us-ascii?Q?i7ggXjHM25ox9JzynCyZ2ZDGtSj78asm6Nn8I2SjmP7t8ErKlww+kzeN1f6k?=
 =?us-ascii?Q?2DP6JBJDJnvqV1upZPbtvQxhGLN2RBukrT+FOLxdHoY2Sv3LINdjQtRnVdl6?=
 =?us-ascii?Q?vEsLZQzjBipCTHEwmPBIJdvv6TqiUTryhu+/4foLRo+CdKabvcFV7WxA+qCJ?=
 =?us-ascii?Q?rjaSBLQVnGSlClslA2DBrZzPmsEYFwtBUXEupO9FJqDaEH44bdS3vlB/urcq?=
 =?us-ascii?Q?eCrxVPu89Ky0w3WFAL5Ds3IrP6bDQpy92ZgxjA6MB71Vxz9tGFoLKjMB5vf+?=
 =?us-ascii?Q?nOXee66r2GRzRU9ABOIg94wTfEDOv5SLGivtVxYijIoFI5WamivqWa89GzuM?=
 =?us-ascii?Q?NVSv7jBQ3VJvrBw/i3O1wIc/HfO/Kb3YRN85w6AVXZjHrenzPwNkpZcuh0Yl?=
 =?us-ascii?Q?ugIyS/uuliOCHB1LEjwE33BZVOQKaFSDJ31IZx4CBUYVzDYY111FFSy5b/N7?=
 =?us-ascii?Q?wVuuRCNNC8leMd4RY/eyLpQdaWixDaT+ZngxxgrORRHQtGjrgsraq6wYF7gh?=
 =?us-ascii?Q?dKteZtupBygc4XERs1/dCSHbcqNYU6Dg39S4lyWiZaARA9cB286VU5G8ZelE?=
 =?us-ascii?Q?nvrZxrlmFw9EC+4fXIg3qKOIPwp/FMZAZWXTqyr3d0aujs0itVcfQ8XtGsWP?=
 =?us-ascii?Q?ZcB0fHmgaJId2RQxBSHZWYIpE7CqHKqEIUJIFakROJGRZMEWjFTS5h93pc6V?=
 =?us-ascii?Q?76HL2tiJpIfRS1WjnWpxxzVE6MPhuvMXVCSZ3fEntOSzFgiZnANAdd9YcSz0?=
 =?us-ascii?Q?Q48gW5NRLktQFR4t3vSD7VwzVKA/O52jO/0AIsEoxwIISJVMUpAUoO/BoU0S?=
 =?us-ascii?Q?dJZ7bjWkOb+dM1QbqaQry8IS7K0eFPs51rvKNONbhYaaUmnrDcF6gd0t9b65?=
 =?us-ascii?Q?Qw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b17048-0ed2-4356-7b76-08de3012d54c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 13:17:38.1698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MupzYWHGc+4A+sokbHe5U0IWt0ivaMBXa8tfDW5T4P1494qqUK32D3wFanIrOHO2B+5OjwafBM6w7ybr+hmgFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12034

The "hellcreek" tagging protocol uses dsa_xmit_port_mask(), which means
we can offload HSR packet duplication on transmit. Enable that feature.

Cc: Kurt Kanzenbach <kurt@linutronix.de>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/hirschmann/hellcreek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/hirschmann/hellcreek.c b/drivers/net/dsa/hirschmann/hellcreek.c
index e0b4758ca583..dd5f263ab984 100644
--- a/drivers/net/dsa/hirschmann/hellcreek.c
+++ b/drivers/net/dsa/hirschmann/hellcreek.c
@@ -1926,6 +1926,8 @@ static const struct dsa_switch_ops hellcreek_ds_ops = {
 	.port_vlan_filtering   = hellcreek_vlan_filtering,
 	.setup		       = hellcreek_setup,
 	.teardown	       = hellcreek_teardown,
+	.port_hsr_join	       = dsa_port_simple_hsr_join,
+	.port_hsr_leave	       = dsa_port_simple_hsr_leave,
 };
 
 static int hellcreek_probe(struct platform_device *pdev)
-- 
2.34.1


