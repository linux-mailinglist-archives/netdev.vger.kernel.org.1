Return-Path: <netdev+bounces-158176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48661A10CAB
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 17:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 855273A3389
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 16:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2521D516C;
	Tue, 14 Jan 2025 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KYJ6oY8M"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2065.outbound.protection.outlook.com [40.107.247.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F4C1B2180;
	Tue, 14 Jan 2025 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736873270; cv=fail; b=kqRwNY1Mc2wrj72ZjP9rDXfchyDhdBVBMYcMLpTR0bKr2XEJWB1jWW3boB3gIMIGUugcV9XUgXfkYfQ76g1W/l0u6860ZVHa71L0bBnoaDzkltka5DgKiJN2GxvqsaE0crPpqf3k0YFP49Jm76wO/yWLmJnTUxPhxWjU+A/7eeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736873270; c=relaxed/simple;
	bh=9ATifKY/tAmH83o0EUtlVDvnXXNKt4Uq/qjawXHTih0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hFM9Goi14jkJNRJBNd52qOkcrVFHhmMFO3Cx8F/4nDVZkZodnBS4TC+GM/cFHIQI3/dX5AijmiQkt59XdhP874lrr3qpbxgkw6S1XmDlX2ra3EwUsBL86yxth+VNTMilTiBzvenc5yP4W92cMAmJgRdwgqKl8MjZzX3pXwp8A8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KYJ6oY8M; arc=fail smtp.client-ip=40.107.247.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUb++dPCn9s0Nvsdeon7X+HcXLWlFRzC5qu9AwniVSJTupbKbCmPpf+Un+Tznl5LB+SM5rqe8XWPfwu/TGEhpfSveJgbFuo30KFGt/QBZ5Xf8tLaBnmvFXorOSoakDvKBMZ5TcvaBuWxpnt1NuKCHQeZ4Xvxt090Mv1lIRJAouoBKlxDblwrzHUxxYd0l+rAHZ3alijdAyBEkDe/RJYIdCI4nwhuYRnr06AQFG/7qwomMirVbgohL2gULvmh6+OQis66uAz7+oLY0sWOcOLE5DrWhis1YDa5Cm8Z8ZD03hvjeL/6tO5kPTo6+7mq16QDA5xm/GB1P77NUWJhZJHIQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAFDw/yjBwZN+1TiS0+ytoXf78smzHP0i2X8OhZxhaE=;
 b=Ru/trASFDhHDc3UWW5vNOe1AfBy3RH9/HKGwtyzHE+9pUE7JCTcXpn0vNoCPe1H45EpprBqQUKJVRske/83f8P1csAl2kbVYABMRDUQqwIXRcB7odwTehqI7xMyHp5aJd1S1f4jfNwY7gkSU8FfuE3kg/xnJ960DFqvFbOYHs4wPz+vFCfwYIyzllZL4E4+tGCyNPYLxBglDv+xqygQK8BLoY+TH1H7IcFwwM9y4zYQE12l+YIQC50ShhRhqtsEjTmZLJ0ELpThpnL1wTrRQDFm96I3R+Wa7HPyTrnZcGTvvP9hSoLD6n2YsxmaW0Q6tglYg2IbOzfh5LmBp0yWm1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAFDw/yjBwZN+1TiS0+ytoXf78smzHP0i2X8OhZxhaE=;
 b=KYJ6oY8M7HOavPih/3HFesRr8oHRpXIjYB8eCWFPIkz4n6G0UhkJq2EKEh53pCfaBuCYvTH6EAINOGj38rq0z4EW0O2YPcvcEkEmp8d6/VNs4jTzsteIabhKTikZqsq8PZ4gnpr9/sXRB56wtheH/25CUIszJcgnuHQUkaT2+30pR0CZyiB+ShEKBN0PeCGg33q0twHhjnvMlSZtmTIeTr3JdmWOV60J5fzUEiucrU07EabErYdU7oS41B9AyA0Rg+JXNerDNZIbssQnhvZbXrET5w6pQ7EZNIgxuH1fLCb1C3Jcr1Ap4zPl9ceXlHvuJexLk5tiphXSdIh0gFzYzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB9205.eurprd04.prod.outlook.com (2603:10a6:20b:44c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 16:47:44 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8356.010; Tue, 14 Jan 2025
 16:47:44 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Jose Abreu <Jose.Abreu@synopsys.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Voon Weifeng <weifeng.voon@intel.com>,
	Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] net: pcs: xpcs: actively unset DW_VR_MII_DIG_CTRL1_2G5_EN for 1G SGMII
Date: Tue, 14 Jan 2025 18:47:21 +0200
Message-Id: <20250114164721.2879380-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250114164721.2879380-1-vladimir.oltean@nxp.com>
References: <20250114164721.2879380-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0024.eurprd07.prod.outlook.com
 (2603:10a6:205:1::37) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: dd11c351-30d6-4a9f-2cd7-08dd34bb2b4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bX0qqBcO1agvumef52QdsxCWmFR6Y6ZY3k/wR0BEUY109DBI/p6LG1/lobzU?=
 =?us-ascii?Q?gkBw1iV4HfDNGRncmvYcsdYwZpfvcXGZVDMIed8jrWVXCGpDkPQSZVm00XiH?=
 =?us-ascii?Q?0nIi3ffxtX0DR8VXR7JCvZ7Acvj7/z8C/AVyr/Z8FeQTnFdnlfVqtx0KSm9U?=
 =?us-ascii?Q?hGgKMkywVj/EcBK5dKZh/PaHI13bh31ch4u4/Tj6npd9ijk+hDKLIeeld9gZ?=
 =?us-ascii?Q?M4NJsAPfOa2mKSnDlts50YyzEqAGJfr5At3AsM90IvcYzOer0c4KTqEuOfPE?=
 =?us-ascii?Q?dbFCOupQs5hDRP2VWrSbC2FG6evTewHAQQADeQoxf199ANVcwA507z1x7K9/?=
 =?us-ascii?Q?TW+fEl+Cswz2QDAN4R4k2dVJ1bqIje9Vc1F9c3u685xlMxrmhHvdR860Rewu?=
 =?us-ascii?Q?rjHgUohn6zoPSa9kP+rzQyxFW7PwMerBe4j0aJONxo28Vt5LhILEhzIatGBc?=
 =?us-ascii?Q?5jAMMwBvRMCV5atDiojB/r5uE27zTvAIhF+4G2pI0a5Vc2vogf00nmyVm8kl?=
 =?us-ascii?Q?9GR2IrqLqy8huq9b0XdJBvUr0Zqo7/ZQgx346ZnCOvBs7jEHKQKNv07b0dHb?=
 =?us-ascii?Q?dkRHnC4wUr3XGVi7Tvzguq0Ki9GQQh9ncXCVE04o9RsoIPuI/QJXVsiWQVCk?=
 =?us-ascii?Q?g0zeFDO2eWLqf7VRyokX3w7ROPG1ZCFBm6dKAl7VWeHCzux5SjKnsUg/9s9L?=
 =?us-ascii?Q?jw5T4Wslf/gmqR1FMFHlvEQ4pWLtR2Dm2A6Lp39YqkloM9SrFFp7aqOTTnBx?=
 =?us-ascii?Q?MQY88LmfZupsBbbRjZKMB0ypdKKmxDXBf056VBgtzkfg2WSMdmNIMALBGmT4?=
 =?us-ascii?Q?1fVvFv8gf4CspTMQeiOikcOiduH3hX6bFNUGKVBuicAWZ6impcg+D3YfE4uZ?=
 =?us-ascii?Q?m5K0+57YuFgmY/2OvEgjQfQ5Pxp5upN7rfD1Fy/bUhm0bVjRolBWJst1mTdR?=
 =?us-ascii?Q?Kw2f9CbtOdCzqf4BZEGMrwsyO0b52zf13lrtXi91tEt6Vln8hnnwdWJl40cE?=
 =?us-ascii?Q?4lMaFhM7Be9JLQtKlqkCKdhD2TkcJZ9Q9YFr3E8HywCeB0HByLHqxilhtU9j?=
 =?us-ascii?Q?Oi0I9ZB60v5bohYWflcQkUTHxRJ7ffiUmW0efXjT8pS/C+p1CnFmPM5rYtvn?=
 =?us-ascii?Q?jTkqnnHWwl1R1DmjcVcOt7vYi2i1pzdwcB833F9E8lrR0CrQXdvMTQXcCyh0?=
 =?us-ascii?Q?RR018sZJxYy5VwcXi4wQkzWf2xTO1rIykJZSF3E1N5WpQTcQHnfCunr4FwO4?=
 =?us-ascii?Q?e/Mnv7ZThM0G/ZAyL1G03JOaz2DlhPrNryzkSd8ouvTdb92nO5g2AOsXZPWS?=
 =?us-ascii?Q?8w74LPf2X+hgUXVvUt8kL7MFYqaXQjoTMaVcS+tpz/AzNrVFQ8FUwNove9Y2?=
 =?us-ascii?Q?tFjZuxzXeGgBNHeqkkaWKqMCjlvyIlpc0eK6UKK0ncvQ1TCavleS2ctYsB1X?=
 =?us-ascii?Q?OPFqGMt5nJaoKb7h9q92jgefJRo78PLM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WX+sd0n1ERVtVmx9CPKxEFHKRq6MJ5BN1Dg2TjVu08vP2JE8+UjtQENgxRAA?=
 =?us-ascii?Q?x8Fnax5f4w4EE0bQ2L8pN3IT+76w9YNFdOWeSQXsQe62VUSSN5IKaFCauu4l?=
 =?us-ascii?Q?qILptgDWqjuTH/iHS41aecd5vtdTJ8CRvaQmYhmmAyVjkxJ/m5jBO/EyXVmg?=
 =?us-ascii?Q?bbF+nqzYjiz4zMWQcHgclCY5HI6+L8h87lR+fuQ4GwsbwIdn5/Cb2++mufv/?=
 =?us-ascii?Q?tY+9dzd1x/y9tzLXi+0AoZTJsOsslRYjRVNFyTueDc/tFL7pNoU0KGjKNCSW?=
 =?us-ascii?Q?KSpBGvH9TpYtqWv+AabumyrNd5gu4cSRw0ksLMNpw5KpoH7v591kdl2ul5lp?=
 =?us-ascii?Q?eCXEqN5Pivb8h+mFlyEssKD4CRoTmw0MoZxS4Jx5dVcGFEg8CUIxGkK9gjRh?=
 =?us-ascii?Q?Hs8flh1ERZRd3t4UaLIOTHCKqv72eiMlfMWyuyYpS++JscRLuqnnSlvv6MGr?=
 =?us-ascii?Q?gktw99HweCwWDvEmGHaFZ+ItIPAZpSVfOWE/5ClD5xBbM2+b3eSmrif4HPW3?=
 =?us-ascii?Q?mnYmkopiff84PAGszbSSVb6wKkkVxdD6WiHsI6C8E0pK14FTVKx6DsjbNjwI?=
 =?us-ascii?Q?2ckPfYQhSE13bw+Xq5X5aR2QYmwfPv8zSvs4RXC8iImcp2RlmAg+QG0kjr2L?=
 =?us-ascii?Q?sZevEEzLwiVAaqK2d+IzpzK30Y0Bc15CjfH99B/vWUedWI918qWehNxEQIRp?=
 =?us-ascii?Q?Fg74/f+2hG8rFjgSGvfA1qbveXEgxLYdNqUmSDJHVxh5Iou1kceB+9gwGnit?=
 =?us-ascii?Q?2mgo2iGO3hL3N8geKMI4OSl6oDl+gmBH1oGTYuuI5e/mlH+763mZyHZEQspZ?=
 =?us-ascii?Q?21iBB5b4r0KWg+ToeO04gLVS70qtSCU9F++dAQbSgTOaegypHrld9xKRCJBy?=
 =?us-ascii?Q?vRzmwzpxpwkXkHPWAQBvLoPsSNpWA5PMYOAT/q5vj/CSUVU1UBBZWm23xbM5?=
 =?us-ascii?Q?wkJ+LPhFtLIwoGsR0Y+Gt3LMbHIfOZXZ3eBN/dEMd4KKhzFaVF+LDwrctfPI?=
 =?us-ascii?Q?H5LDMGlyha6qSSyHgylDgKPe68nHlbZkusqoTjnF4+h2zgZOtEVhe6SRatZr?=
 =?us-ascii?Q?OQjyZUaKyigmoRxQ3cX+s4IWeS4tZ094TtztCPziRWQWqYP4Kv8PkqBbhlzL?=
 =?us-ascii?Q?HlhQvUtWnL9PkDe1f88AkjQLxLECc22LxoCDyAA60/QWClrO/Rtbk66s4ICG?=
 =?us-ascii?Q?i4mrKc+2KJa7cyHHgqa9Jw2n+26QVy3z1iTJrmmccgFF8iMOO2cmHe37T7PD?=
 =?us-ascii?Q?6NkL+idfZwQmUE+/Pcn0n8uE8WLxqK+OJDxvVbd+1iPdoxWlZGuYeH2ahGQF?=
 =?us-ascii?Q?BGsktDoquz88ToepI0ZCPheqXn8rBxWfDGXpBXmHzpqpoXBqWNUP2kvI3u8C?=
 =?us-ascii?Q?s/3PAwb5EHjb+NtGybyo0vTeeMOdHAZvh7W7mc7CtJHdDsTAn9ktEnQrZsNL?=
 =?us-ascii?Q?pYI2P62O4/jG+6wyWuwxNIjJEaiWmqtHOeNpwfOGt8QgfB78ZgXkVWnHNmth?=
 =?us-ascii?Q?jo3oISJcdKV85Fyd3txiTCFILjAoiq6uMd5RNpYh8KGRuawnyCR+E59TYWZH?=
 =?us-ascii?Q?2trUNTX7hJm7kFlnaMJJK72ePeaMoJBDWZckaRBr0Un6DjaKbpxtapzuniku?=
 =?us-ascii?Q?og=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd11c351-30d6-4a9f-2cd7-08dd34bb2b4e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 16:47:44.8047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHit+06l3GYCH7nB/qMFZGInSyELJFNSU8YgVKKbaTeQ+6e5IeruGDSdP538fNijTIFSV0fWsdhLJBGuzSyfhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9205

xpcs_config_2500basex() sets DW_VR_MII_DIG_CTRL1_2G5_EN, but
xpcs_config_aneg_c37_sgmii() never unsets it. So, on a protocol change
from 2500base-x to sgmii, the DW_VR_MII_DIG_CTRL1_2G5_EN bit will remain
set.

Fixes: f27abde3042a ("net: pcs: add 2500BASEX support for Intel mGbE controller")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/pcs/pcs-xpcs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 3de0a25a1eca..2e2cc6153fdb 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -729,7 +729,8 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
 		return ret;
 
 	val = 0;
-	mask = DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW;
+	mask = DW_VR_MII_DIG_CTRL1_2G5_EN | DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW;
+
 	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
 		val = DW_VR_MII_DIG_CTRL1_MAC_AUTO_SW;
 
-- 
2.34.1


