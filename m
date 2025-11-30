Return-Path: <netdev+bounces-242807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27712C95014
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 14:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D4393A3AA1
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 13:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406F9280A5B;
	Sun, 30 Nov 2025 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WRtrL/i9"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010043.outbound.protection.outlook.com [52.101.84.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE1728469C
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 13:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764508671; cv=fail; b=FuL2PJ4KKf7PkSZ3G+cPqcy6eFoadvtv28SZOqJfqB6tNMVi4sgM/GcDilvYT3nOVyZykeHeAWYRSDauqd2nehBWWS2E08pw9XFh3xrbU353/cKEf/zLKnC+R13sfboPv9uhk3xmX3A8eql2qA0cSOP29HIdkZx96QKgfly+/nE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764508671; c=relaxed/simple;
	bh=sNfm3IU3S88bEnhFw/gfE7Os2pQDnodAYLzqni941ZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CPZr6lF+aWvMXyLre6P2zaet7kKwVit8zyL6TkJ9Y4MzpyglEeobEHNlZOUjBg4ggAJRo9mPigKhfT+q77+MbE+bicti5Ami2onSkXF6cb7VgTbw2YlRR6Mbtyq1TiiICBsyV9lzhmflnBQLvalOJzl0w/21gEIg/uL4cET1qA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WRtrL/i9; arc=fail smtp.client-ip=52.101.84.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8xTnAow281d8LVMmTlW3MYtWDYybTXq4nilsk4PeBVrEryju1ZpxzIaAI8AMn/+pF4NNGHDBzLyNeF4A2ug3aZcX92IK8delSwyNPhGZmU+7YvWYxlGcZ3wgdgryqGkrCO8afI54F0Gfa8oUr5jY+WWzF2XJ8uXUNiQOLrW0liowHVf8MMxT+QDzTG9qIbMY9DVBrlUStKDS+tI5SJsJmLFzX4iOUL+zh4Ee5hJYWsR+z3jq8qXC8JWGIPpuZHX2ad2BWa/U4R0tHKaObg/KNibSuqoq2361jCruj6Knzwckw9PE+2EaLTF0D+B+iqgT47RXivrxb6WW/QMIWiyyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rro5KaZhqECa29rSxRN/877SnaWEvzIjvsGXm2bHsVY=;
 b=MXxiKGdl4YUIRVglfUacsTwVWMHPPvU0n9ecEmdbMHKsIujMbI9IqF3MTteNgVRXbL/Vm5eXF74gUsI6zPAdVFQwV4S/ck6G9DFqoTB/RQ8lir0YqXU+ifS/9DSypRhP0weq5BQECrFRErnWMs/tBrpRUsiTVVacVyhEvvflPtC9lMK5R9eyDUFy3NDp+5lltOOaoAssztoisiEkBrnY9i2QeXac6V23nvanbsQkRKvp31lkAQFzUOmJJkxFNi7Qqa6qfcEH3r+LABTPeJWq/v18y0O6MLMFpTsY96OYyiVDhLrt97UrTLwEcGxJZbOfP7h0p7kKKfoqfsq5WDprdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rro5KaZhqECa29rSxRN/877SnaWEvzIjvsGXm2bHsVY=;
 b=WRtrL/i9XrUa9Mm1VoWZSoCsoUgFdrqRDmUwZ3VbAdAjlL8Fn9QTYJ83Z0pZkXFp5IgI840Ac5rVuGNzM980+BCZ6O/kJKqcuESWIxDVEPYpF84aJpQJAKIs84o6uLMCrhkP3kv/O8dzIJfngr2Nru/eslYVb0oYNgh45quVpmKhsTCJiUgLlnMX0lIHZzx6fuOuqIptMUVTRJhti08PJFBeXLReUUW9wF5PRNL5iF4YDks0S/useP4oofkekn8sJ+jitVe8RXjU0G8GZzmPZtmDxmuU43tLCJ/xvX4V81gxptdegrKmsQBaUMPgGZg+U1eZt0/PZSidCTP5KcgaVw==
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
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH net-next 12/15] net: dsa: mt7530: use simple HSR offload helpers
Date: Sun, 30 Nov 2025 15:16:54 +0200
Message-Id: <20251130131657.65080-13-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c5193a40-6b19-4294-4256-08de3012d5ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Iz0xtdfg/6zAW6kdYJxQXewSTkItyxeLBwapS8L7gJhS1fvn1NY0OfZoFAIQ?=
 =?us-ascii?Q?I3iIdpTyw+XsiacjPt6YIeiZgjF2KHwp1/beEr5/Wcv0+IpVnXaXA656h3cd?=
 =?us-ascii?Q?r3iL9W2yk5XkQtUDry7JpT4e67SG/4zlmdTC2hbxKwNncccPu/pgiKO9Eqj6?=
 =?us-ascii?Q?bwAyf6q+cmpzIDar5A47Rf9uGSZguyfp0e8WAF5Xj7J9SDoOk/ZeGeL2u6PL?=
 =?us-ascii?Q?AhQzm68x/rBGdXw4jIQiLOiVAdU/wrKAdA5njo/4TZcSoG0qscUlxxgj63Hi?=
 =?us-ascii?Q?EJW0V3dBzQy06F93NWgOdP4VUZdoO+jHGK61XmZnWOzxDgB7/uXIYDrcbyUL?=
 =?us-ascii?Q?YuGnx2Y4cZAAOUXcbyj7rT+JHw3LZQAKd+q5lCZ7PYr6BDn3LqVBluQToM5z?=
 =?us-ascii?Q?AAI4af9tZd3hPsxOFdEbUjeEmP8o8NC8bIKex01rGTZtKMAsA3LRmImWarL0?=
 =?us-ascii?Q?zZ9s902tstEooj1GWoJCqNTxpY2wjW0zLPhSFVheAvhcwhg4sPtdohrMJx9j?=
 =?us-ascii?Q?qCC9sYunqt+xeiCC8/PWtMP8th1DnY26oTdA4YPdH8BHqQayzuvOcANOjUAG?=
 =?us-ascii?Q?Iqz2ZNPM+fvxuufGKNDaNEGnmCcubyo/+shco6uQw0lbSJxz+dqJHQberV+J?=
 =?us-ascii?Q?J81WBlSPv8NctpEmdIlxl/KpH6aYdwpGeCoKfbnmNVaN7J+N0qstFqTKBgvg?=
 =?us-ascii?Q?wRJMPOjRi3LuA6CumssKcJycVFv3SEsTO0Jw+kcKvsBsZ/jum+b5tCVEP+1b?=
 =?us-ascii?Q?tPdDu5t12D+ovcSaVOKazoNvcFmefdttO68gbGxuYuxKyGP2we7c7JJsiOVV?=
 =?us-ascii?Q?7ybgMXdWRw9JZj5dWQnOK4i3P/gHNIK4dPJVT+l/RfJgQaAAqM0qcfGwxAj4?=
 =?us-ascii?Q?vrksxnKP+vPscKGwYp10iK+udVXClJtWB9bnOR3EiLt6fPBo2l8akaiffCcE?=
 =?us-ascii?Q?dxJ2QPruSraxXP6xQvmwmjxWaxyml2qklmuJQ/az3z/D8vN7X42VgUtatxXH?=
 =?us-ascii?Q?oArOA6QYDaoS4jKZujrp/OfAQndvnoxISPilSb0AZGKhhNz00D3Nln96AmCX?=
 =?us-ascii?Q?VKHsf4+nRnVWU2IbrJMOwZVbrTL4TNWRs/1vu1/IW3T8LMNcwEvB2YoPY+jn?=
 =?us-ascii?Q?/0//+OpwsXl8ccNgQw6e2rX66S5nqJb3JQymheo6RgijphIcHkR7+bqV7jUx?=
 =?us-ascii?Q?tjTsrGC9yRHpBB0GosYvg+mILH7KszneX6EYUF9aw0TRlCg5Go4e+gp9I8Vj?=
 =?us-ascii?Q?PwBhiV0X34yqp9tM3T2Qh/0Ah8Gp4CaCXecARNv5gsiEkgFT/DjNp3OUQpkl?=
 =?us-ascii?Q?5qZTHsU/Ek0ufNWBdWo/+Yqm3H9tzGOPMO3M2av/YymfzPJw+6pyR4P5EV9r?=
 =?us-ascii?Q?h7bt4E01p4Wytuh1SsU6+oZvYb5IwCBcsJ91F9CX7hvO619wniUnAgBLxc7e?=
 =?us-ascii?Q?+LtTTn1SDApB4oQ9DBFX2P4iv0EMgnTT2vOyOzv1bW5zzL4AOb7NaOF3Rvg9?=
 =?us-ascii?Q?f/TNgMOc6utxDJb5q+5kEJ5FAwDGzAPURUF8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?807NKB8r2Lg6mAhfeNjb7/WrME0xitK8R4gN1iCjGKl58a1M1BSlQIThufhz?=
 =?us-ascii?Q?kqloy5JW0BmRmHZtLdPtPT/WBnp3fhdydDrtuUBsUdR13lJBbXR/Maam0NLH?=
 =?us-ascii?Q?S1Q/Mw+nvArGiDJUm5mAx+FAafOSAkUpyzUEkSMb6c+HcZTntdU12xJr/Gk2?=
 =?us-ascii?Q?MpHe9PdSdLQNK0YOqa9u4g+yhwKwIYZ8o29QaWFz1sxdzGnk37sRC2zicGof?=
 =?us-ascii?Q?80WvbXhlLlxmwn/mvApFNNhX7Ub6wruWOaUYDY+vRPE6wehabE3ROYYT/V/+?=
 =?us-ascii?Q?2oQwUJzkUNtX+KVDWZjzOE74EKSSTs6qLVeT27Ur6nPjmUWN18w5Z0tsZCT7?=
 =?us-ascii?Q?9aFViUcMS463lUjxg1bc2N4Ye3H+2PrRumHlPXmXfv/FcbuMDEW8cV5YP4am?=
 =?us-ascii?Q?RQieusfwJg0/c4UZLm5VFIPLayR6r4xH3eFN5/IJo/0UcdLGKo0978MZ1VwW?=
 =?us-ascii?Q?Kqbmnum2uJUH9fZBVKfBZnd0qvTKU429sYHmYOc/i/wX7KlIAKFn2Zeg4ZZp?=
 =?us-ascii?Q?w/cxlO16BqAw1gnIBMM/fzfdrqduERtku6lSl3V+3drMlsyIwDW81Q3gfx8+?=
 =?us-ascii?Q?ctiavTBuyCF1KITsjYhLaz98YY6gsMlv/NV17QhC94zHZrp5z7KZuADX/xPa?=
 =?us-ascii?Q?YUfpF7h9LVIkaIUHh10emwqK4DbFnqfzLzQ5OzXktx1qTllCc/4OEqFrth8z?=
 =?us-ascii?Q?c02RSuZ7gJcWnzOf/OLRZuCn37aaPYVxdweTKnz3HBD1wEM4g3Hhw4T/n54x?=
 =?us-ascii?Q?wd4JUUYLYc6DhbsiGHNywk2PpLfKwWPWN8BH0GMwXS+Oy3nGNw5EtuQLhiKC?=
 =?us-ascii?Q?LIPygGvIdhUCRUc3Iz9NQg4HdCeWjh3qGQicUcBdoaLIbS4I2iQW6vwPiHMM?=
 =?us-ascii?Q?7bMRpRrdFtmq0lO4J0N4Zc+IycgbKea2kHBRHCh61MisKo52vnBAZYLCP5ke?=
 =?us-ascii?Q?uXh2Tb/z9LN9r8t40JNqa+jMfCHYMye3E8XDQVCkrkWyt33rYNVjs8PbNUVT?=
 =?us-ascii?Q?v0O8guK5PeCIZnzQiZJhIr1KPmTwB1gNfP/Z+OJ2EHk4RdDupYArbSHQYh0k?=
 =?us-ascii?Q?FDv3g7KZe02uCT6hvcwSo2Np3VXHWKbb46OCQuESFtBcx0EdKVhekyKo3Czu?=
 =?us-ascii?Q?FsCaO79kqI7yDC3FaIlggLYnU3/VO5hxYSlgJ23B5zlnKVzUQeW/TSy2yCTz?=
 =?us-ascii?Q?QZWXe/np/oYrprvc4kU8Ux9eAmq5stPgzrwcyU8cH7LfOcTJtiq99kqfYoxu?=
 =?us-ascii?Q?HQD4esbl0ZboP5Pi79dlNk+ndQ3atCxL+AXQzaUyMYpiB1XwvdJBY5ne3rSC?=
 =?us-ascii?Q?ZfmeqzEKqIjkcC0TkxIvTzOXddCd09O4LFTR4gboj/3gbYt0sVYDs1pV/hPT?=
 =?us-ascii?Q?I+VFT3DQpujkWAmx+M8rXqTW45kWFvB5+uguxnmFVsCEMkpvEu/uuevuYdP8?=
 =?us-ascii?Q?p1IXsCKArVU2A+ahhlhPYD82WKIW/q6PAMeh/SgGXI1RYpHkNi9fw7O/+/cu?=
 =?us-ascii?Q?PmIFrcM5EaluiMtf3daZUpAq8Uh56GvMZ39yAZ11HQKtdGFm/e4uqxqsSoTW?=
 =?us-ascii?Q?tS7CRro+V0/ssYS6zUvTuQof81mEDMrFfgryinz1PF377PND2uPbLgIgSOKg?=
 =?us-ascii?Q?yA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5193a40-6b19-4294-4256-08de3012d5ca
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 13:17:38.9025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZ1GTvN8Gs1w+/bPzXlPE2h+IXKqlGE/Nt1hvRlVxTqStGv/GwR72pWKCn6ymOnWKUr+paKSuZwXbV84tl0J4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12034

The "mtk" tagging protocol uses dsa_xmit_port_mask(), which means we can
offload HSR packet duplication on transmit. Enable that feature.

Cc: "Chester A. Unal" <chester.a.unal@arinc9.com>
Cc: Daniel Golle <daniel@makrotopia.org>
Cc: DENG Qingfang <dqfext@gmail.com>
Cc: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/mt7530.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 1acb57002014..b9423389c2ef 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -3290,6 +3290,8 @@ static const struct dsa_switch_ops mt7530_switch_ops = {
 	.set_mac_eee		= mt753x_set_mac_eee,
 	.conduit_state_change	= mt753x_conduit_state_change,
 	.port_setup_tc		= mt753x_setup_tc,
+	.port_hsr_join		= dsa_port_simple_hsr_join,
+	.port_hsr_leave		= dsa_port_simple_hsr_leave,
 };
 
 static const struct phylink_mac_ops mt753x_phylink_mac_ops = {
-- 
2.34.1


