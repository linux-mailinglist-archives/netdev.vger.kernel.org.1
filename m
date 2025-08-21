Return-Path: <netdev+bounces-215693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE31B2FE70
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A92C624FA2
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B371A2FB602;
	Thu, 21 Aug 2025 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NRsgBwBD"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012037.outbound.protection.outlook.com [52.101.66.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199622D12EE;
	Thu, 21 Aug 2025 15:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789695; cv=fail; b=LFTCQPRwvwOjclQHDIfh63CTk8qv3kY9iy/Hd7h40ok8x0xcnVwNJmZKfTdHbHb73IvEO36ZHJXjvLwtRcDHYr52uz7maEAIg1SOZoA+ACFVF6QvmkapX985eXXz05AW5uEyCkWsVcmYrXdLUHxQ8VuxAuI99Wdla4rix7pNcrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789695; c=relaxed/simple;
	bh=WofHvXxHgNwL/nPSymcUGXrJjFK8LRzwUwJ2CN/bZE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ln2nxgEI/+EF00S7su2PADAU2l3UQE8+4epeUBXR7ItVor5odgWJOaHpLHsN1+pR/mHcZSHuoJKR2pgeWVwVMgMEZauhJMqrbjWvFYSogMqqJopV8gb0DUELvLJgFMpXUp59lFnpq1cuqheihIz7RdZcoZZqflF+PMhJkthUI98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NRsgBwBD; arc=fail smtp.client-ip=52.101.66.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XvOWM+EU8OEN16cl0Zh9xpCQtFCublJ1nCqSXAlGfGApIoY2DSnFCYgPZAkagJy5oTfzvFF2Rul5VMzRjccThasCI5TDjQDZlw+ZCGmhiFSPYn3Y4vbCa6QZMaE5DccHaFSnN3B4sm6WcVe3azV55hYNv0wr0JEBrRzjW+A/SBnDWQA3vrWPmr2XTljto2WhgSlHaoGzkJFuheLyYIp231vK7slaEXv5DSu5+d8XEYW5D2AqT3/aESshhBe6qHgrSkNFmaT9gFheMgKX5E7I4vQHfOMMfAUHUAvH9KiScUtlfh0sQTjEc3RZhPaG3CDHdHbnD3ydm0mQXAyToJLPPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2cTQCTbW+RuTt8xNgxd/lf1TviD5GMOshU5eFkZClY=;
 b=fZvmroMt46l7TLPbTTDlldqkMtBcLJds4WIAkM6ue57PJ2Bo+K/DFNNIZOOwzWQN5cQKxC4RoqCoOWgaI4iPHzidIj9etTrATBrcWW9Hkx7jDbfQEx8+xKLjUcsj1Itln24+OjqC4OrtEq8SK2pOicFyg1I1XiFT6WsgO6H0SCspBvg/e3Tl42xenuIRPeYAOwjUXO1Rc9rtV/rltkXMwzCkprWcgYOk5HoPyu0TvYw/f5TeclQ7ybo3kM5Uz3ebXNK3EAr1jgUiJi1tdh6iaXYtMKRahxQIhTsO8OCFd8RtXK/ofC95zicD1ICTYlgrvC833iCcA/x7jQ+fxKvtDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2cTQCTbW+RuTt8xNgxd/lf1TviD5GMOshU5eFkZClY=;
 b=NRsgBwBDLb4sMvjyey48pBMaOKMwbelNMIhnRDSDYwxwZeD3/6We5AQIXZtbkn8SWfCcaIlIdXsj9nAbCO+Qb7Zyt5Ruc2h8PJWm/GCe2+hZRa/n/GFJ2Vz0u9q0jLCeOl53pGRu0FRMhT1zycdS5/UGPcA75OWm0hzuiduaJ95GH/h1/gMyoNOQ6xPFQeUEplaPOFwJP2WaJxHVSf6KOHcU3ll+HchMrhT//xHbhV2FeNYySQBvGlW8Ru6acwErkNtY1tldHu/V7MCsFArcoAWMA9U4HoQW597DTUr72DWdfT0tFn2dLAvskoOwkkKjM0MO4sBQgih8P9rCiQlg0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10809.eurprd04.prod.outlook.com (2603:10a6:800:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.11; Thu, 21 Aug
 2025 15:21:24 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 15:21:24 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	linux-kernel@vger.kernel.org,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Robert Marko <robimarko@gmail.com>,
	=?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>,
	Sean Anderson <sean.anderson@seco.com>,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH net-next 09/15] net: phy: aquantia: merge and rename aqr105_read_status() and aqr107_read_status()
Date: Thu, 21 Aug 2025 18:20:16 +0300
Message-Id: <20250821152022.1065237-10-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821152022.1065237-1-vladimir.oltean@nxp.com>
References: <20250821152022.1065237-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0016.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::8) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI2PR04MB10809:EE_
X-MS-Office365-Filtering-Correlation-Id: bb6bae51-56e4-4777-4023-08dde0c6641d
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?fWNfywzRM4SlwYnzL6yt1H5VXMeZ7//eodCGkrm9PBPG2mBOdc3v6QQ7Nc6Z?=
 =?us-ascii?Q?uR/eSFgb5Ad4/NOq4nxU5Cce7JM8vzZNvNKEdYZynBz1GbT7WFE2mofLQaxv?=
 =?us-ascii?Q?s8WGAgK01gsFQMO7Wgt3YiLkADuj6Kuqo0mS3raFUlH/c9NifKliH6J7NE7V?=
 =?us-ascii?Q?SG/VZdmXZ+gZrfyddpZDzpTDk+9ZWhDfZCTVU9D6WsR/MUuCsFMYD0Fp+ho8?=
 =?us-ascii?Q?XxGDWUba8Gy+DW5YTRBgbPeehsqeuzV4T/82xyZqA6tzk6gHJ79/97sEyZ4H?=
 =?us-ascii?Q?33/vz3gI7CovAJFPq1MYAQzfm9qxj183J7g9IXkzitpgBj7X7aq/l0qgtdVP?=
 =?us-ascii?Q?IJfCj5CtffAcqqzOQo0uYkugp406OT0Mpa1OzTASGbGwFLBU1soskCLSn6V6?=
 =?us-ascii?Q?yueUBujqnGAnMWm2EcREvsvYiSPHno0EauE/0qN5vYoozjUf7yDMW1qq3qzg?=
 =?us-ascii?Q?tg3lezH0bw4x2kMPKp0+ucAfJINk0IBcNn6Ziw2659Wrs9F6J+sYpINPWCqb?=
 =?us-ascii?Q?9sqkXlPbAhc4fGRw7omGRuvQzgKchKhE8UHQrUGugIhDzsFXnBNwApGBItKe?=
 =?us-ascii?Q?95j7G4bVgKL8enyQZxzm+Jf22t0koB02KtzUTX1lNAr9t938KeOK3zXTWIQm?=
 =?us-ascii?Q?yyp4kdLQ6h54YfeOx8wxxya1wYhnTbMdhoIM+UL8IVRcqNhcGrafcVNgXxwV?=
 =?us-ascii?Q?Rllab4DrNpfyHuUQrBAX/+YEGUqiU1KhBxdLdMmv6BWcs4YNPYXVTzz7Flks?=
 =?us-ascii?Q?9C0izwcm2w7xoiRXL2c+6BWZSPvelYxA9A4G9RG9mhBq6KyOI12R+DQ64D36?=
 =?us-ascii?Q?yrCkhBAArHmHXO0BahGWUvRuj9chF0VfZ0gXwTCceBEnvQNLI2Vt2IRehqkl?=
 =?us-ascii?Q?d+mVCnDviQKlzJf3o4ejhB5XW6z+eJ3uUMG61pNDx62bSbvNbCMok5PkMKYo?=
 =?us-ascii?Q?I0RDdWHbUl2KQ5tVZIhIYiqfCWccBT+eEpaSPso/ig9r61lJiA12ArgPzBKr?=
 =?us-ascii?Q?ViOmXQTY+LEoZk19KkSro1wciQp9IxlQbYkcH0IUmBsyiT846BLCnlySsliP?=
 =?us-ascii?Q?sr/3W0UizCcF3NKeu41FNtBeeJpyPzYhz4oWkZLytE+r92Sea+lQ9I+p3f4a?=
 =?us-ascii?Q?+V9/CG82/ea6Vwk8n+qwPe8AUqBNFEg6y5A08tWMc9rStsM3NllFj28VvC7f?=
 =?us-ascii?Q?a2j3fliHxPWj+0/ftgplHxm2GIgX2cIn7K6+ZENy6fUySsvpDgRigtbzc0sy?=
 =?us-ascii?Q?mB6Ki2xoX2EubU/fy9kjtP6gp9J6usImmTcnKbaFPcHZaDFjeit5MLTDdz9J?=
 =?us-ascii?Q?2L8kYC10+tBuGU5dSTA+PSmdJjwykIIZ0UYiDyxjIm9s9+iIlxayFl/R4Pag?=
 =?us-ascii?Q?YW2Yq96z11kHXWlS9sO8Puc97jGpinvnPPHdkriVsooc1cyUGAt4M1HSOx4s?=
 =?us-ascii?Q?XRoYtoPyR+b6IbaagcTCf16ZMt/2JyLFPUzq0UzLDIPvm9bEaUmSZg=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?6HpvkYnjl880C6hUoC0VNmDO3nTD77XG07NsWz/S7f1UDrup27/CJS06NcO1?=
 =?us-ascii?Q?HpFnaCsN6ySvXzbvvt5sWomj6BJa7+SEeH+bTr7Tgsh+fs/0RK6LAwTR+45B?=
 =?us-ascii?Q?ldn1KAJ3ZriloQYR1JVFzVRKpqMCSypy2XvJREm/zzqPq88f8UUXnwqAi2xq?=
 =?us-ascii?Q?4wJpfDWVTesk0L7LMqiq/kls70CzIland8x+WlXo+dC1mQ7hnzlIN+GBnzZU?=
 =?us-ascii?Q?iZUc1dGH2BQJzjFYW/6sdV482Z8aw9EqErKeny//ftKkIswggxGXnhsT13KH?=
 =?us-ascii?Q?jYWR9OY2FME6iwT8+C8UPq5SL/xeHcJU7F1oEuTXZ58P+TY+24LuxVVDWTYN?=
 =?us-ascii?Q?/DgNVrpc6XdtW6IyBak0/Qhioz8X1bpFVn9rJC14vUlWAhxRMEDEtwEA5QrL?=
 =?us-ascii?Q?uftiySdoB1gwm2LmP3Hiq7iAGZLTn8sfu5MhGoq3hLlurR5W0tHKkj1qDXm0?=
 =?us-ascii?Q?c1nZLzyg5/nz1ij0Zmlo82hGMXTGTd/1YEIRj3+n7w0OhL0uehDhgajI4KE1?=
 =?us-ascii?Q?JmsUt/5DPyDFMumKHG36RzEImVGVHiP2lBW+46ho3KGAmuGPF2TD8skn0B7/?=
 =?us-ascii?Q?UKxAMMejIgPrkZ+h40cE2voA884L9zcdhOkWAF8cPCLyyuMmdbVLkLssIpL1?=
 =?us-ascii?Q?VlWeDpHZd+2WVe20GjfLLVSRuCTeDT4RdgIPeOY+EDIq+6uryrC+2xhs5Z1x?=
 =?us-ascii?Q?XhLYaiW+PC89gtkKydYfOH6q15lOsXdNl3V4T2xJz/I1aYIw0zNeYD3sSew9?=
 =?us-ascii?Q?mBVeucgE4DhBIVa2I3ax56cZktyo+rcMs+AdJ0hNiwvlyLBGJegn+TKNxHxn?=
 =?us-ascii?Q?1ytbdx+v5FlywAoNKU6B8nZr6E6Qyfd8LqKxiJ+54za1sSfmCeOPQzIQ4GK6?=
 =?us-ascii?Q?Ypoz/GHwXImk4KCxZqJWLraLcq2mV5gnAejO4QJ0CjbIDEtGBdrlcKQE/OgU?=
 =?us-ascii?Q?WU7ynl53tSbFzKRvqyu9CemtFCrWsWpTojMWIASf0C2/WeNEsGf1PkR88BqI?=
 =?us-ascii?Q?eDpxXhLeVtfn+2ie6owCZLwPnvdxLWZFik/Rqwfh9OXPiJOFd2dmrk7pFdXt?=
 =?us-ascii?Q?r5EcwK/hsAI/ziFk/5TLWXe08MFYj1QOKtRLFMc/lcp2ywmPxEaIUuB0oZUU?=
 =?us-ascii?Q?7oa4LpMQm/Kw6r0VWTOuH+Ec2O42Cj+yruk/MBXPCxNIE121j+HMp8q/r+Pt?=
 =?us-ascii?Q?LL20aXWaFXeWKHRdtav0YrfQ3eIx7qnJK1olrmNu3J0KmaheCWqPaceRSaF3?=
 =?us-ascii?Q?elH4LMuY4NN49VtanQINY9biEqFqiCb11R06xzDEnQyJK4ig1MfTFNaXYAfS?=
 =?us-ascii?Q?ew+j4YMj47rzrDGC5QauaF6cBRCeiQdYNNRQyRR23gmgV4RX0X8rNA61wyfW?=
 =?us-ascii?Q?5kPRV9plyst4/z/eWgjSOzh8EFgFppehP/PzSdRasHhurSxuQREqVIGN5Exg?=
 =?us-ascii?Q?i987MSUmsYQqgV8vAHNtvxVsT9T/MVCB3DsI5ajmiXjmU2VVJZoabs38zvrg?=
 =?us-ascii?Q?TY26Bb0RMqG1H761FDpV1VLWTGCVY3lex2j5+ScLkH0ttv3CtqgFnyulrzLv?=
 =?us-ascii?Q?mscM2d4BXkgMZaDiAXwR/0WaiC/UEXoz26mkSyyT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6bae51-56e4-4777-4023-08dde0c6641d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 15:21:24.5653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 666217R+5hiTo0Cr4Q/ffEwODi3s0P3w9dqNxkmy9Y0CRekZhcBjeTKi6vpXv+T5qUYg87GYZi993ex9tlkAHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10809

aqr105_read_status() and aqr107_read_status() are very similar.
In fact, they are identical, save from a code snippet accessing a Gen2
feature (rate adaptation), placed at the end of aqr107_read_rate(), and
absent from aqr105_read_rate().

The code structure is:

aqr105_read_status()                        aqr107_read_status()
-> aqr105_read_rate()                       -> aqr107_read_rate()

After the recent change "net: phy: aquantia: use cached GLOBAL_CFG
registers in aqr107_read_rate()", it is absolutely trivial to
restructure the code as follows:

aqr_gen2_read_status()
-> aqr_gen1_read_status()
-> Gen2-specific stuff (read GLOBAL_CFG registers to set rate_matching)

Doing so reduces code duplication.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/aquantia/aquantia_main.c | 131 ++++-------------------
 1 file changed, 21 insertions(+), 110 deletions(-)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 4795987ef61b..e3a18fc1b52a 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -466,7 +466,7 @@ static int aqr105_config_aneg(struct phy_device *phydev)
 	return genphy_c45_check_and_restart_aneg(phydev, changed);
 }
 
-static int aqr105_read_rate(struct phy_device *phydev)
+static int aqr_gen1_read_rate(struct phy_device *phydev)
 {
 	int val;
 
@@ -505,7 +505,7 @@ static int aqr105_read_rate(struct phy_device *phydev)
 	return 0;
 }
 
-static int aqr105_read_status(struct phy_device *phydev)
+static int aqr_gen1_read_status(struct phy_device *phydev)
 {
 	int ret;
 	int val;
@@ -563,46 +563,17 @@ static int aqr105_read_status(struct phy_device *phydev)
 	}
 
 	/* Read rate from vendor register */
-	return aqr105_read_rate(phydev);
+	return aqr_gen1_read_rate(phydev);
 }
 
-static int aqr107_read_rate(struct phy_device *phydev)
+static int aqr_gen2_read_status(struct phy_device *phydev)
 {
 	struct aqr107_priv *priv = phydev->priv;
-	int i, val;
-
-	val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_TX_VEND_STATUS1);
-	if (val < 0)
-		return val;
-
-	if (val & MDIO_AN_TX_VEND_STATUS1_FULL_DUPLEX)
-		phydev->duplex = DUPLEX_FULL;
-	else
-		phydev->duplex = DUPLEX_HALF;
+	int i, ret;
 
-	switch (FIELD_GET(MDIO_AN_TX_VEND_STATUS1_RATE_MASK, val)) {
-	case MDIO_AN_TX_VEND_STATUS1_10BASET:
-		phydev->speed = SPEED_10;
-		break;
-	case MDIO_AN_TX_VEND_STATUS1_100BASETX:
-		phydev->speed = SPEED_100;
-		break;
-	case MDIO_AN_TX_VEND_STATUS1_1000BASET:
-		phydev->speed = SPEED_1000;
-		break;
-	case MDIO_AN_TX_VEND_STATUS1_2500BASET:
-		phydev->speed = SPEED_2500;
-		break;
-	case MDIO_AN_TX_VEND_STATUS1_5000BASET:
-		phydev->speed = SPEED_5000;
-		break;
-	case MDIO_AN_TX_VEND_STATUS1_10GBASET:
-		phydev->speed = SPEED_10000;
-		break;
-	default:
-		phydev->speed = SPEED_UNKNOWN;
-		return 0;
-	}
+	ret = aqr_gen1_read_status(phydev);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < AQR_NUM_GLOBAL_CFG; i++) {
 		struct aqr_global_syscfg *syscfg = &priv->global_cfg[i];
@@ -620,66 +591,6 @@ static int aqr107_read_rate(struct phy_device *phydev)
 	return 0;
 }
 
-static int aqr107_read_status(struct phy_device *phydev)
-{
-	int val, ret;
-
-	ret = aqr_read_status(phydev);
-	if (ret)
-		return ret;
-
-	if (!phydev->link || phydev->autoneg == AUTONEG_DISABLE)
-		return 0;
-
-	/* The status register is not immediately correct on line side link up.
-	 * Poll periodically until it reflects the correct ON state.
-	 * Only return fail for read error, timeout defaults to OFF state.
-	 */
-	ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_PHYXS,
-					MDIO_PHYXS_VEND_IF_STATUS, val,
-					(FIELD_GET(MDIO_PHYXS_VEND_IF_STATUS_TYPE_MASK, val) !=
-					MDIO_PHYXS_VEND_IF_STATUS_TYPE_OFF),
-					AQR107_OP_IN_PROG_SLEEP,
-					AQR107_OP_IN_PROG_TIMEOUT, false);
-	if (ret && ret != -ETIMEDOUT)
-		return ret;
-
-	switch (FIELD_GET(MDIO_PHYXS_VEND_IF_STATUS_TYPE_MASK, val)) {
-	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_KR:
-		phydev->interface = PHY_INTERFACE_MODE_10GKR;
-		break;
-	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_KX:
-		phydev->interface = PHY_INTERFACE_MODE_1000BASEKX;
-		break;
-	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_XFI:
-		phydev->interface = PHY_INTERFACE_MODE_10GBASER;
-		break;
-	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_USXGMII:
-		phydev->interface = PHY_INTERFACE_MODE_USXGMII;
-		break;
-	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_XAUI:
-		phydev->interface = PHY_INTERFACE_MODE_XAUI;
-		break;
-	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_SGMII:
-		phydev->interface = PHY_INTERFACE_MODE_SGMII;
-		break;
-	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_RXAUI:
-		phydev->interface = PHY_INTERFACE_MODE_RXAUI;
-		break;
-	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_OCSGMII:
-		phydev->interface = PHY_INTERFACE_MODE_2500BASEX;
-		break;
-	case MDIO_PHYXS_VEND_IF_STATUS_TYPE_OFF:
-	default:
-		phydev->link = false;
-		phydev->interface = PHY_INTERFACE_MODE_NA;
-		break;
-	}
-
-	/* Read possibly downshifted rate from vendor register */
-	return aqr107_read_rate(phydev);
-}
-
 static int aqr107_get_downshift(struct phy_device *phydev, u8 *data)
 {
 	int val, cnt, enable;
@@ -1180,7 +1091,7 @@ static struct phy_driver aqr_driver[] = {
 	.config_aneg    = aqr105_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
-	.read_status	= aqr105_read_status,
+	.read_status	= aqr_gen1_read_status,
 	.suspend	= aqr_gen1_suspend,
 	.resume		= aqr_gen1_resume,
 },
@@ -1201,7 +1112,7 @@ static struct phy_driver aqr_driver[] = {
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
-	.read_status	= aqr107_read_status,
+	.read_status	= aqr_gen2_read_status,
 	.get_tunable    = aqr107_get_tunable,
 	.set_tunable    = aqr107_set_tunable,
 	.suspend	= aqr_gen1_suspend,
@@ -1225,7 +1136,7 @@ static struct phy_driver aqr_driver[] = {
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
-	.read_status	= aqr107_read_status,
+	.read_status	= aqr_gen2_read_status,
 	.get_tunable    = aqr107_get_tunable,
 	.set_tunable    = aqr107_set_tunable,
 	.suspend	= aqr_gen1_suspend,
@@ -1250,7 +1161,7 @@ static struct phy_driver aqr_driver[] = {
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
-	.read_status	= aqr107_read_status,
+	.read_status	= aqr_gen2_read_status,
 	.get_tunable    = aqr107_get_tunable,
 	.set_tunable    = aqr107_set_tunable,
 	.suspend	= aqr_gen1_suspend,
@@ -1275,7 +1186,7 @@ static struct phy_driver aqr_driver[] = {
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
-	.read_status	= aqr107_read_status,
+	.read_status	= aqr_gen2_read_status,
 	.get_tunable    = aqr107_get_tunable,
 	.set_tunable    = aqr107_set_tunable,
 	.suspend	= aqr_gen1_suspend,
@@ -1310,7 +1221,7 @@ static struct phy_driver aqr_driver[] = {
 	.set_tunable    = aqr107_set_tunable,
 	.suspend	= aqr_gen1_suspend,
 	.resume		= aqr_gen1_resume,
-	.read_status	= aqr107_read_status,
+	.read_status	= aqr_gen2_read_status,
 	.get_rate_matching = aqr_gen2_get_rate_matching,
 	.get_sset_count = aqr107_get_sset_count,
 	.get_strings	= aqr107_get_strings,
@@ -1333,7 +1244,7 @@ static struct phy_driver aqr_driver[] = {
 	.set_tunable    = aqr107_set_tunable,
 	.suspend	= aqr_gen1_suspend,
 	.resume		= aqr_gen1_resume,
-	.read_status	= aqr107_read_status,
+	.read_status	= aqr_gen2_read_status,
 	.get_rate_matching = aqr_gen2_get_rate_matching,
 	.get_sset_count = aqr107_get_sset_count,
 	.get_strings	= aqr107_get_strings,
@@ -1351,7 +1262,7 @@ static struct phy_driver aqr_driver[] = {
 	.set_tunable    = aqr107_set_tunable,
 	.suspend	= aqr_gen1_suspend,
 	.resume		= aqr_gen1_resume,
-	.read_status	= aqr107_read_status,
+	.read_status	= aqr_gen2_read_status,
 	.get_rate_matching = aqr_gen2_get_rate_matching,
 	.get_sset_count = aqr107_get_sset_count,
 	.get_strings	= aqr107_get_strings,
@@ -1367,7 +1278,7 @@ static struct phy_driver aqr_driver[] = {
 	.config_aneg    = aqr_config_aneg,
 	.config_intr    = aqr_config_intr,
 	.handle_interrupt       = aqr_handle_interrupt,
-	.read_status    = aqr107_read_status,
+	.read_status    = aqr_gen2_read_status,
 	.get_tunable    = aqr107_get_tunable,
 	.set_tunable    = aqr107_set_tunable,
 	.suspend        = aqr_gen1_suspend,
@@ -1391,7 +1302,7 @@ static struct phy_driver aqr_driver[] = {
 	.config_aneg    = aqr_config_aneg,
 	.config_intr    = aqr_config_intr,
 	.handle_interrupt       = aqr_handle_interrupt,
-	.read_status    = aqr107_read_status,
+	.read_status    = aqr_gen2_read_status,
 	.get_tunable    = aqr107_get_tunable,
 	.set_tunable    = aqr107_set_tunable,
 	.suspend        = aqr_gen1_suspend,
@@ -1415,7 +1326,7 @@ static struct phy_driver aqr_driver[] = {
 	.config_aneg    = aqr_config_aneg,
 	.config_intr    = aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
-	.read_status    = aqr107_read_status,
+	.read_status    = aqr_gen2_read_status,
 	.get_tunable    = aqr107_get_tunable,
 	.set_tunable    = aqr107_set_tunable,
 	.suspend        = aqr_gen1_suspend,
@@ -1440,7 +1351,7 @@ static struct phy_driver aqr_driver[] = {
 	.config_aneg    = aqr_config_aneg,
 	.config_intr    = aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
-	.read_status    = aqr107_read_status,
+	.read_status    = aqr_gen2_read_status,
 	.get_tunable    = aqr107_get_tunable,
 	.set_tunable    = aqr107_set_tunable,
 	.suspend        = aqr_gen1_suspend,
@@ -1465,7 +1376,7 @@ static struct phy_driver aqr_driver[] = {
 	.config_aneg    = aqr_config_aneg,
 	.config_intr	= aqr_config_intr,
 	.handle_interrupt = aqr_handle_interrupt,
-	.read_status	= aqr107_read_status,
+	.read_status	= aqr_gen2_read_status,
 	.get_tunable    = aqr107_get_tunable,
 	.set_tunable    = aqr107_set_tunable,
 	.suspend	= aqr_gen1_suspend,
-- 
2.34.1


