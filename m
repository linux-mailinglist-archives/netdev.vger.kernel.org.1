Return-Path: <netdev+bounces-240971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C76C7CF4B
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 13:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4DB63A9DC8
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 12:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9178A2DA75B;
	Sat, 22 Nov 2025 12:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LeeH6Jam"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010058.outbound.protection.outlook.com [52.101.69.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5933D22FDE6
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 12:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763812975; cv=fail; b=d2189xwGnIzj04a//CgZIK7hiGwgaf2L5TcDs5hCdO48dj15JZY/PARN0DMxoYJ0gwZ96HZNtNrm6SB00pL0sZzX95f5ImomwoH4/hO/Vs17iJfqV2HqT/qrbnXcKH00/SDKOy883tscbgWjy/kxG2hscQlzL+MbVmP/rRxY4vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763812975; c=relaxed/simple;
	bh=2R9exCxp4K2avO7qDiIPbbcB16LJh8Hx/U5dNsOUto0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SYVNcAX1kf/taP6yorpgXxIPGblHnvjq5vRHVPz6WW6fsYOEqjZbEz/tLcRVZ1d6akYGRu6f8k9UaoKd76dOrObaLnRusmIe/NMR6qxeAkFdXHC7zT9pD7PftDqcXKKzQ+3D8rrYg7Gox3CyVi9Uu5ZllSejuWFI/BTbG+ihwsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LeeH6Jam; arc=fail smtp.client-ip=52.101.69.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4iJAEAnjwL5IO1gs4MByOUUWGZ6hZZBrBI50hyxNEsgPYLDcRZZNZ0PL+Y6WRFATh7woF9yX/Wdn8S4tqeaaTKutI+3l+YYVR3rKjHvdHDgwuSzFWqdbW4S4mK0H6tSim61ZnN6BUfRC4pj0SpbDIStGNUWGJjKZTqAidcD/EE7pIpEcdZVrqcwOei31D5yngp1GHRAW6w5Puc+itJqcdISEzORCNpv2bZ5jt2SJRUKb4v5v9sVBjmMPCzYBCdUvwBDyPDfFJefLOJUBkDZfdUhzYD+/rDXOSNcEOGTmpJy78h3PpRhr2JQv+wkh2x6tn5dQsHjFENE8EC1IDdsuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulV4mbGgymeaJCU834iIod+vToRbTGWP4MEjZCUyfmk=;
 b=yEAI7zMuxK4rlGXNbu2HCcOxlN+s0DF48+smKPGMIWcrmkhAq0DMHMfiswyIn3GY7K25AQWh61YokHpu8abghOMZnqyiqik9tQhEDnq+ERRAt6Z5FeoXAV5GvrLRs+fgz8u7jfHSzfPbfinKNlmT+Xvf/YKz/ueso+vjjPHsoCoixczkiMCrCEuAsyhNGipt+9fshHiuOJuYtBuXUFvmjpFwLgXlw4/ahMi1jFKy6h5TBQVuDxYUw/TGz2SY+hMMeWQsnwgkEKGswtwLWHmYnhcycm976ciiYU6bdz+mcZig+5ntW8uTtG+IiJQZACmeMzMNChoZwSkm/TTLD9ofJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulV4mbGgymeaJCU834iIod+vToRbTGWP4MEjZCUyfmk=;
 b=LeeH6JamncVCnGzXO4P3BxXKeQSM7EslQ/xyV6bEmUsSei9kNSEuVPtOsCT5ibV60oy2kMTIlSi6LSqIBmXsyjW7++MakCB6k2yYK7LEahCmIrfhk7Hl0DlVT8adJHG2ybmFwRCMw6LLlXgHylNKp8WVpTQUWAdotDKvUa7qnlNZ+asXDZ9LJn8aZL4DWbvaaRnwFgXwlHvKUu82VvsHfxrIyKSqLVC58/NAaxpp7Lwok5FYizdBR8Xdzj6eXmuX6gbJAVWYa4Rjl+kWFEF8VAFWRpowbLiOc3YZxZiVCvKWEx8pBXy4ZYaCEWbQqyV2WfXkcfIQAmZ29jOts7T9hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM8PR04MB7875.eurprd04.prod.outlook.com (2603:10a6:20b:236::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.15; Sat, 22 Nov
 2025 12:02:50 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9343.011; Sat, 22 Nov 2025
 12:02:50 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Madalin Bucur <madalin.bucur@nxp.com>,
	Sean Anderson <sean.anderson@seco.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Wilhelm <alexander.wilhelm@westermo.com>
Subject: [PATCH net-next] net: fman_memac: report structured ethtool counters
Date: Sat, 22 Nov 2025 13:59:31 +0200
Message-Id: <20251122115931.151719-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0042.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::20) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM8PR04MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: c2fd6fa0-1366-4dad-4a74-08de29bf0f13
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|10070799003|52116014|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?wc5tlfLZFkmR1lCtJ3Sf4fYpzcYeEASpsb1zo4e/WF4F5VYweB5g/gBKwkt6?=
 =?us-ascii?Q?L2qYTWN0NMS38mH8kXdIZl/sOY4s0MtETvpM0xs3yLDCvj49FAj4D1yupRnV?=
 =?us-ascii?Q?GU/ZDfO35QsaYn7IyDYf6tFb2hgqIj9B8UV6sFKVgpIsnWiYcvfb17RmuCDo?=
 =?us-ascii?Q?+K3CWrMUsmlNIVMZNfKaKYRpXJvbuLTO40x2XNOun5e02rPexQJwbRAV21Rs?=
 =?us-ascii?Q?erawsMUiU7kXzE+toaAHFSFnBL+KrAEeB2wNItOUB2vsx9QQfU2zVY6te8Oe?=
 =?us-ascii?Q?RY7gFTOoa6J5H5dMOj7pITV8Xsgtm7E0DIwCryhrfwp/YjMD8p99juTXnVsH?=
 =?us-ascii?Q?NwRKUXcqj66vjRrJAWZvxnVvukkbfaN6nqasPyWzIvoQVRvKV+eCltrmY/ch?=
 =?us-ascii?Q?03eoi9IoG5k2gH8SNHKto9Pf19sUgHYRNaUEISJnB+1QKgg4Atha+ypaY+Tw?=
 =?us-ascii?Q?uiYfcsRM9/lli7KBwULcPSNQnwugYugwAbs8BXCQmGF6j4F8LsylK2AOEBDE?=
 =?us-ascii?Q?UB1tFrAc70NAlLMTs8LDbnyMskkJYUXnDs5uArPDGBQSH/V3rKAw4kvQ+YPP?=
 =?us-ascii?Q?HiscwTlKPwKIq7kd9n6iuMDi2eQgAunC8QmNU9URBDMt+vF21thG3sF6rT4T?=
 =?us-ascii?Q?92D7BTUwQ9JWfjGu+NuYB+UN8KEvRpYG30SqaThHqIRsK/hsbS2Clu0oB2k5?=
 =?us-ascii?Q?EfpkiwmCEZy/WOXoXtoYNpbDu9oMk3SVtMh7IBxjkxXASZyNwWuFeBXjm+Cs?=
 =?us-ascii?Q?aSdlmNzgizjcMv38fCZeQtE4DbwbWyjQA5U32KXmzgo6uQfCJ8S9Hony8MtM?=
 =?us-ascii?Q?0L+BiuSpsOCnkk+vRhpFTJqHY4oVtTUh6NvCEQyQfKUyrul1FJTSdpuhhr+4?=
 =?us-ascii?Q?7Ylz7S26qhOVSzp98jfIQde5Zp3cPms37hD9bqFHgjDBrDzai/MZv+iV+o/+?=
 =?us-ascii?Q?68bJQXAHYJX4Eek+hgEcOStIcfEEB/57XSItC+f5wUbb7ZlfJew9nql3Z4Bp?=
 =?us-ascii?Q?mS4PPdY+54P525/q+N8cX2MadfqTFKIlucBawUnjmeqtmuh4CjJhxOGqtkjy?=
 =?us-ascii?Q?1OBBsMbIAv/+vFLllUDDceMK6ZClqqf5CIAA3oV2M9jJKkzQTowzxhkUzWPo?=
 =?us-ascii?Q?yHai7umS4oObfMJBBSw+QCaddKG0IlTCaop8SFqIQ4DGgSOrxdTtWD6MW/Cv?=
 =?us-ascii?Q?RnPECl4W94MO28pBkH3dYXk54awSsmH26u0Dg8Hna6GXsVA51tBLKZnl1hwn?=
 =?us-ascii?Q?LbGdtzBakfbjT9vEczYnta77pEd0d+I+jiyiY0Bxelh3AeVqaPQq2lx+Suql?=
 =?us-ascii?Q?hw5BNcjzPGp74Yd4bXlRu49szXXbIwkaKTSmeaE9lNdpdhKPAB7ZGo4o7NS+?=
 =?us-ascii?Q?tYq+R7ILQZRgO7yD/w59/v+pAKdKFgufNP2BszUMw/GIzUO5MnfQ4bFOYwzW?=
 =?us-ascii?Q?nMgM0Sm7Tr+/ZhoP9R0NVkflG02f2Xw0XpEvWP1jOs0QuxRbu9paqg=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(10070799003)(52116014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?GIxFV1m0Bcu8UTO0JHMI6kUbr5k2oDiKEVyi5NudhxLiwbm5WXi8yMoojB9U?=
 =?us-ascii?Q?xPuEprDxhdB24+RWOZgKY3CiwQdmOK0D2xGGfzGX8Ydqj6ZHmVUePdGNGE/W?=
 =?us-ascii?Q?QfO8RCa0y6FLY8sa76kRnAykPdnmapfZ1CILiVPgMkPy/WCNQcU0bOY1SRuh?=
 =?us-ascii?Q?WYdk5Pp4waekxrWaYXOpDlGyOGBjgLkBy6yhAqb9ggejGR04mOhOSfz5QiBU?=
 =?us-ascii?Q?fBy1jiPZQZE+fjE8IUMdC/T5Vs6z87D1k+JZSzd6Jgmh0nBlEcD5muIObOnr?=
 =?us-ascii?Q?pk+p0yqo8eKE7J0emkcVa43Bos8sb/7zgFn40O2bKw0HoE5tRuqUqtfkNL+l?=
 =?us-ascii?Q?ctf9BJhJWfeodQ1XxLdG2P+l1hMIBjaT8V860XCBUdR99GDnbkEE2Wbp6OA+?=
 =?us-ascii?Q?hIg0RQsKuKRaoeF8RSFViL3K1ghULJDdOHWBy5Ee6DQSh5fH/DVtvarrueOB?=
 =?us-ascii?Q?LWQlC/tbzHQdnG3dNqK1se5eXTBWElofKwQxd3gQ/wnzuwNOW57Q/kbTKVq3?=
 =?us-ascii?Q?YkPQqrCxTTer/KxCxuCrnnVwu6ZTZiH4a8uBOWyoIbp0vHyTH4ztwqPBGby3?=
 =?us-ascii?Q?hAgaHfAV2VI1r5Au0Dq9f6QrVjq9xKkWcIGnLosrXBKzCbG2lGdizFqS7CMc?=
 =?us-ascii?Q?wfvAAnKL5Jjpj44y2N+6pDZEX9Io0DLY1d2VDMsVhgXfpTCCTFsADX5vcdyp?=
 =?us-ascii?Q?JRs+2XbiDC4Fk59h2BHGnMuAA+cMrc83kDibvlQOJJ7aSJ5CGEvUgJXkOXcM?=
 =?us-ascii?Q?kqKSwtviUn2WzTL2awIFCHWRBULQTusYJH+xpXDJAtQvTVOPJHAr4SUUsXeH?=
 =?us-ascii?Q?05UR+7kzjRiS3Cuwth3zKnPqbFOmoOq7kCMSEyoHwMilXfjNcFh4tP2NrTSG?=
 =?us-ascii?Q?b25vmDy/CDjVNYbric8PT4gi+L6uE9htWzBQNUliR6imbxrn4V/XlZ3S977P?=
 =?us-ascii?Q?dbZg9V1lB9nFBPZPNX1chugVoFUGqLTM7asjm1hRWeKekCjoYUFXkxLYh+by?=
 =?us-ascii?Q?AEeVwVnT9j/M3zTWM4mGTQyNM5iEFu49kvZS4Ov45blrfYOm5Nx8zE7CNVoZ?=
 =?us-ascii?Q?7SJMPlYQscqQyiwixKJuNp3Gd2QyBrPRSMsswFJnPD0LT6yI1vQ7/hF5sPN1?=
 =?us-ascii?Q?xoDHcbeaJwCD/0Y+Bae8i7KKhEwDwYI+DkHLNIawnWSMqOncfib0oilvn6Gk?=
 =?us-ascii?Q?/lTLfrU6+JLsZ6Bif0MCx2TrgqSOuYe8TZ7s11VX2ga+AiaG5ridMcyTcFhi?=
 =?us-ascii?Q?yGdIALR1cNlgke/LAKJEUW5Qt+Porl8j7re0/xkE/cX9mlTuL5kskCZ9drR6?=
 =?us-ascii?Q?KrnAJIxr57PBRwEYbENAoV7TaNcNOELd6gAW9ciQEWENLBE7+cD33x1NkiqQ?=
 =?us-ascii?Q?t5VqVLKPrtHppcJrifss/yeg/IrIKHBHPrHbTLMO4xM2wkdwbxUdDsej7jPr?=
 =?us-ascii?Q?O0yxzl+METW6qIwVVf9QZanf18T/E3mLWkw6JscDvDNDIdIs242xgwwxxbTS?=
 =?us-ascii?Q?8oceJziJHXXPbJ/OK7XmvDQ336L+hxc/fJ1CdQTRKPNAaLHrITz/FK+qRtuM?=
 =?us-ascii?Q?UoyLjyoD4g2qhx03EVIAPrTUmVcz58QMne6KH74Y95lB63CJ75+PMJioaCoV?=
 =?us-ascii?Q?5XGF94g8jbxige6eT21c23w=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fd6fa0-1366-4dad-4a74-08de29bf0f13
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2025 12:02:50.3749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u1X+iZryiysAEoNKVWgPQ8CESUNVqh45z7QnGR7Ia0UDq08wGb+56+N9DefaCuENkF3T5ZPjROv5W/K/6WbzoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7875

The FMan driver has support for 2 MACs: mEMAC (newer, present on
Layerscape and PowerPC T series) and dTSEC/TGEC (older, present on
PowerPC P series). I only have handy access to the mEMAC, and this adds
support for MAC counters for those platforms.

MAC counters are necessary for any kind of low-level debugging, and
currently there is no mechanism to dump them.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Fished from the mailing lists:
https://lore.kernel.org/netdev/20250804160037.bqfb2cmwfay42zka@skbuf/

 .../ethernet/freescale/dpaa/dpaa_ethtool.c    | 45 ++++++++++
 .../net/ethernet/freescale/fman/fman_memac.c  | 87 +++++++++++++++++++
 drivers/net/ethernet/freescale/fman/mac.h     | 14 +++
 3 files changed, 146 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
index d09e456f14c0..ed3fa80af8c3 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
@@ -467,6 +467,47 @@ static int dpaa_set_coalesce(struct net_device *dev,
 	return res;
 }
 
+static void dpaa_get_pause_stats(struct net_device *net_dev,
+				 struct ethtool_pause_stats *s)
+{
+	struct dpaa_priv *priv = netdev_priv(net_dev);
+	struct mac_device *mac_dev = priv->mac_dev;
+
+	if (mac_dev->get_pause_stats)
+		mac_dev->get_pause_stats(mac_dev->fman_mac, s);
+}
+
+static void dpaa_get_rmon_stats(struct net_device *net_dev,
+				struct ethtool_rmon_stats *s,
+				const struct ethtool_rmon_hist_range **ranges)
+{
+	struct dpaa_priv *priv = netdev_priv(net_dev);
+	struct mac_device *mac_dev = priv->mac_dev;
+
+	if (mac_dev->get_rmon_stats)
+		mac_dev->get_rmon_stats(mac_dev->fman_mac, s, ranges);
+}
+
+static void dpaa_get_eth_ctrl_stats(struct net_device *net_dev,
+				    struct ethtool_eth_ctrl_stats *s)
+{
+	struct dpaa_priv *priv = netdev_priv(net_dev);
+	struct mac_device *mac_dev = priv->mac_dev;
+
+	if (mac_dev->get_eth_ctrl_stats)
+		mac_dev->get_eth_ctrl_stats(mac_dev->fman_mac, s);
+}
+
+static void dpaa_get_eth_mac_stats(struct net_device *net_dev,
+				   struct ethtool_eth_mac_stats *s)
+{
+	struct dpaa_priv *priv = netdev_priv(net_dev);
+	struct mac_device *mac_dev = priv->mac_dev;
+
+	if (mac_dev->get_eth_mac_stats)
+		mac_dev->get_eth_mac_stats(mac_dev->fman_mac, s);
+}
+
 const struct ethtool_ops dpaa_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS |
 				     ETHTOOL_COALESCE_RX_MAX_FRAMES,
@@ -487,4 +528,8 @@ const struct ethtool_ops dpaa_ethtool_ops = {
 	.get_ts_info = dpaa_get_ts_info,
 	.get_coalesce = dpaa_get_coalesce,
 	.set_coalesce = dpaa_set_coalesce,
+	.get_pause_stats = dpaa_get_pause_stats,
+	.get_rmon_stats = dpaa_get_rmon_stats,
+	.get_eth_ctrl_stats = dpaa_get_eth_ctrl_stats,
+	.get_eth_mac_stats = dpaa_get_eth_mac_stats,
 };
diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c b/drivers/net/ethernet/freescale/fman/fman_memac.c
index d32ffd6be7b1..c84f0336c94c 100644
--- a/drivers/net/ethernet/freescale/fman/fman_memac.c
+++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
@@ -900,6 +900,89 @@ static int memac_set_exception(struct fman_mac *memac,
 	return 0;
 }
 
+static u64 memac_read64(void __iomem *reg)
+{
+	u32 low, high, tmp;
+
+	do {
+		high = ioread32be(reg + 4);
+		low = ioread32be(reg);
+		tmp = ioread32be(reg + 4);
+	} while (high != tmp);
+
+	return ((u64)high << 32) | low;
+}
+
+static void memac_get_pause_stats(struct fman_mac *memac,
+				  struct ethtool_pause_stats *s)
+{
+	s->tx_pause_frames = memac_read64(&memac->regs->txpf_l);
+	s->rx_pause_frames = memac_read64(&memac->regs->rxpf_l);
+}
+
+static const struct ethtool_rmon_hist_range memac_rmon_ranges[] = {
+	{   64,   64 },
+	{   65,  127 },
+	{  128,  255 },
+	{  256,  511 },
+	{  512, 1023 },
+	{ 1024, 1518 },
+	{ 1519, 9600 },
+	{},
+};
+
+static void memac_get_rmon_stats(struct fman_mac *memac,
+				 struct ethtool_rmon_stats *s,
+				 const struct ethtool_rmon_hist_range **ranges)
+{
+	s->undersize_pkts = memac_read64(&memac->regs->rund_l);
+	s->oversize_pkts = memac_read64(&memac->regs->rovr_l);
+	s->fragments = memac_read64(&memac->regs->rfrg_l);
+	s->jabbers = memac_read64(&memac->regs->rjbr_l);
+
+	s->hist[0] = memac_read64(&memac->regs->r64_l);
+	s->hist[1] = memac_read64(&memac->regs->r127_l);
+	s->hist[2] = memac_read64(&memac->regs->r255_l);
+	s->hist[3] = memac_read64(&memac->regs->r511_l);
+	s->hist[4] = memac_read64(&memac->regs->r1023_l);
+	s->hist[5] = memac_read64(&memac->regs->r1518_l);
+	s->hist[6] = memac_read64(&memac->regs->r1519x_l);
+
+	s->hist_tx[0] = memac_read64(&memac->regs->t64_l);
+	s->hist_tx[1] = memac_read64(&memac->regs->t127_l);
+	s->hist_tx[2] = memac_read64(&memac->regs->t255_l);
+	s->hist_tx[3] = memac_read64(&memac->regs->t511_l);
+	s->hist_tx[4] = memac_read64(&memac->regs->t1023_l);
+	s->hist_tx[5] = memac_read64(&memac->regs->t1518_l);
+	s->hist_tx[6] = memac_read64(&memac->regs->t1519x_l);
+
+	*ranges = memac_rmon_ranges;
+}
+
+static void memac_get_eth_ctrl_stats(struct fman_mac *memac,
+				     struct ethtool_eth_ctrl_stats *s)
+{
+	s->MACControlFramesTransmitted = memac_read64(&memac->regs->tcnp_l);
+	s->MACControlFramesReceived = memac_read64(&memac->regs->rcnp_l);
+}
+
+static void memac_get_eth_mac_stats(struct fman_mac *memac,
+				    struct ethtool_eth_mac_stats *s)
+{
+	s->FramesTransmittedOK = memac_read64(&memac->regs->tfrm_l);
+	s->FramesReceivedOK = memac_read64(&memac->regs->rfrm_l);
+	s->FrameCheckSequenceErrors = memac_read64(&memac->regs->rfcs_l);
+	s->AlignmentErrors = memac_read64(&memac->regs->raln_l);
+	s->OctetsTransmittedOK = memac_read64(&memac->regs->teoct_l);
+	s->FramesLostDueToIntMACXmitError = memac_read64(&memac->regs->terr_l);
+	s->OctetsReceivedOK = memac_read64(&memac->regs->reoct_l);
+	s->FramesLostDueToIntMACRcvError = memac_read64(&memac->regs->rdrntp_l);
+	s->MulticastFramesXmittedOK = memac_read64(&memac->regs->tmca_l);
+	s->BroadcastFramesXmittedOK = memac_read64(&memac->regs->tbca_l);
+	s->MulticastFramesReceivedOK = memac_read64(&memac->regs->rmca_l);
+	s->BroadcastFramesReceivedOK = memac_read64(&memac->regs->rbca_l);
+}
+
 static int memac_init(struct fman_mac *memac)
 {
 	struct memac_cfg *memac_drv_param;
@@ -1092,6 +1175,10 @@ int memac_initialization(struct mac_device *mac_dev,
 	mac_dev->set_tstamp		= memac_set_tstamp;
 	mac_dev->enable			= memac_enable;
 	mac_dev->disable		= memac_disable;
+	mac_dev->get_pause_stats	= memac_get_pause_stats;
+	mac_dev->get_rmon_stats		= memac_get_rmon_stats;
+	mac_dev->get_eth_ctrl_stats	= memac_get_eth_ctrl_stats;
+	mac_dev->get_eth_mac_stats	= memac_get_eth_mac_stats;
 
 	mac_dev->fman_mac = memac_config(mac_dev, params);
 	if (!mac_dev->fman_mac)
diff --git a/drivers/net/ethernet/freescale/fman/mac.h b/drivers/net/ethernet/freescale/fman/mac.h
index 955ace338965..63c2c5b4f99e 100644
--- a/drivers/net/ethernet/freescale/fman/mac.h
+++ b/drivers/net/ethernet/freescale/fman/mac.h
@@ -16,6 +16,11 @@
 #include "fman.h"
 #include "fman_mac.h"
 
+struct ethtool_eth_ctrl_stats;
+struct ethtool_eth_mac_stats;
+struct ethtool_pause_stats;
+struct ethtool_rmon_stats;
+struct ethtool_rmon_hist_range;
 struct fman_mac;
 struct mac_priv_s;
 
@@ -46,6 +51,15 @@ struct mac_device {
 				 enet_addr_t *eth_addr);
 	int (*remove_hash_mac_addr)(struct fman_mac *mac_dev,
 				    enet_addr_t *eth_addr);
+	void (*get_pause_stats)(struct fman_mac *memac,
+				struct ethtool_pause_stats *s);
+	void (*get_rmon_stats)(struct fman_mac *memac,
+			       struct ethtool_rmon_stats *s,
+			       const struct ethtool_rmon_hist_range **ranges);
+	void (*get_eth_ctrl_stats)(struct fman_mac *memac,
+				   struct ethtool_eth_ctrl_stats *s);
+	void (*get_eth_mac_stats)(struct fman_mac *memac,
+				  struct ethtool_eth_mac_stats *s);
 
 	void (*update_speed)(struct mac_device *mac_dev, int speed);
 
-- 
2.34.1


