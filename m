Return-Path: <netdev+bounces-190484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D818AB6FC8
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 17:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBCAB3B1E30
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63314283FDA;
	Wed, 14 May 2025 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LyvN5T3A"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28C0283FC9
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 15:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747235994; cv=fail; b=XXgvL3BXOCn/xSzMymOionAKhDZqAE9lNHspxVDyJMXm1Wea1ufZMevL+KGBWv41hkjf0GIViid+hqeV51jtX+3gmj063vSDB267HBFc1VUjEcViG96N/8z2zfyTYsTRvwE58NiJ3jvTm26B8CJhba+bDgtDSBeFWLiX8pv10Y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747235994; c=relaxed/simple;
	bh=LWOI1p5wIxAlsz/W6hx4YYbL1U+vTHbJDOZiRqaPR+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LLbu0xfLHCCfugrnfkRHSYbEfmdDzlF89tzcbyhdbMjDmHeBeRFxT/ELXoY2K6qII/4erJ137Q8QYSiVQON51pzkllNPBllyVTH4+wPLB1jSnnC6c6py5ghG/rRhAN4pmC5As4Rmwo6+7J60v6tojASG/3wdk8DZUrAPtL6gUJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LyvN5T3A; arc=fail smtp.client-ip=40.107.21.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C1CsEBOfYVq26ohWzsuE5cU4gfSrNEOo/o9h93qItwAnEPqHBYmJjb+/G+VQ/Zb979cJyU9KwiS9XLL3Aa/264QpcK82bceFLSXoLfOUgiY6FIMQ6cFu2NaEN8jou5HuF1mRxad37yQHfEL5sVxjdwO4pviSmvEwt3Jz0tFKmABYo2nSbq17i+GwNFvgllklUQaYSMB6/ogJw3Ha3ceba5papQOq/mcOZzTtjgOcDX0hkRbWFiDPWQ56hHFuzgI1+ljxqvSWeZgTH2lD9KMWytzoAemRJJL5H63b3lYCjbx8Is6ScYvlmchZmLE+l+tYCEahk5pZrkLGzC67g1CtFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfPx80rG/cp0c+Ga/p2hFv0SlV7PONH5LUHYYITtmsg=;
 b=AV4RdqQvVf6v0p9SDZPZa2tCbJyyf/SH66+usRdczWSiMAAxGxTFCfSvQErNG7nsAreSMD3ls1X0UhAEwqDqDazs4yqfU5DIilOHWEhJp5Hu4xggU8RTeKxXOz/ni1bCexWyuPgRzHGPEMGxWuTH2r6QWS8y1wTiAN9+JGTGEMii5p8nfAOHhzQJ40DT8ZgVgp3YhGqDhAD1YqwD7hBnUlhYQcLBWt5YOT6xJzzd8r/nNUGaGLxkz3i4DnZ3Jgj7pZbdk770kXJPCLG2pEhaM24jIHBK4jzcqD5iz4hp66OxEmc6NDgOXFBJWUUyxsN7N8S2c4/7zEuXZEWgLsQfWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfPx80rG/cp0c+Ga/p2hFv0SlV7PONH5LUHYYITtmsg=;
 b=LyvN5T3AWsQAoEYqCeFCh8TTcJZMP2gDhTHuyqUxmE8lpxX6UtP2RPLP7bxFH98MTD5lSe2kuAlXtI8X+EqQiLN+vNTv7S9yYqnX2QMdxcMzfkZWJrYtKMC/AlfBY1pIX9p1Q0DsO5wxjx5yRijYETcY4pBbAVPa5ScijrnRkOJIo6sV9Q1iUTsayAskmwylyqr+70tz1N8YSNGHEw5IvDms4nkz/MXGXNpMrdQJnIOyIL4EBnfxplcTDYmZP7lRPkIDwfXqiQ5Z5dtntp21ZhDA+xPUjAESmw8MnocSphOOs1rvt/idKNg1RRQ7Lc5oSY2WQbCkjJAf0s2ON/Hk6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VE1PR04MB7231.eurprd04.prod.outlook.com (2603:10a6:800:1a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 15:19:46 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 15:19:46 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Bryan Whitehead <bryan.whitehead@microchip.com>,
	Raju Lakkaraju <Raju.Lakkaraju@microchip.com>,
	Vishvambar Panth S <vishvambarpanth.s@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH net-next 2/2] net: lan743x: implement ndo_hwtstamp_get()
Date: Wed, 14 May 2025 18:19:30 +0300
Message-ID: <20250514151931.1988047-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250514151931.1988047-1-vladimir.oltean@nxp.com>
References: <20250514151931.1988047-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0018.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::31) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VE1PR04MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: a754bf86-618d-4497-3a10-08dd92fac282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m4BA9LFCBoUDWVdPOrHDSSxQFmXASTa95p4/Ew37GCoAVFin52oTDheVmOwQ?=
 =?us-ascii?Q?nYlLktic6zynwyPKbYajuEWVl/ZxqI/e6TwVUg25gFggL8DcdQcZlHPBcIqF?=
 =?us-ascii?Q?1SzpL+mHALLDGLRNfA+IKBPYxlt9h63uyiwfSla9Ea5d9KaFqBjEK3/Lq5Q0?=
 =?us-ascii?Q?cSiJk+5RtdAly30hMu/NZ1ihluJNQ/4Z8BdmUGXG3Q7W0Drk+os8uABYxrY1?=
 =?us-ascii?Q?xeKblLxAg2LZEeBP+m0jrKatrqWN5zJcMXFRQ3J5G0WK8mBeq0iH9Zs6vpHJ?=
 =?us-ascii?Q?iXLNxLud4AWMQj9RCHxHoSyA0o7veXt5i4WyIf6piBk/SyaFlRuUedGN6UIu?=
 =?us-ascii?Q?Qp9m+gU31oBbWRiloUU7TJE0bYH0lxHaxmTZH4rG4zJBXPnXOEwziL+nt6VG?=
 =?us-ascii?Q?BuCI77L7+/0tEJDdn2QdlRK82PQRnOHdIsXiOddxpmzSnlK20VzzH7DR14Oz?=
 =?us-ascii?Q?rpDq1hZMJcu9rVynaz6kqqng/eaMx3TVZ5vN2CNyFeI2RVUwlPhgDRg5bJ4/?=
 =?us-ascii?Q?ID92abBelY8aby54/FCutXG7IYPy74QEIZI63Y2KE6AM2I5r/ke54zcX0HEb?=
 =?us-ascii?Q?pX24aUnUBbUWB1Ev/rXI3l6Ltypi772o2kSwu6HAImx6vEO0ULurffrDUosa?=
 =?us-ascii?Q?Hi6ngSouHU6uuXmC6yTMLf2V5InuCsVzlHfskqKIDf7C4LYQxzUq9/qBFgC1?=
 =?us-ascii?Q?dXKN9B2LgBzAjGADt8iKijPv06c4yNW9CJQtC9VlcoDHmELCdXO5vxrv0v0A?=
 =?us-ascii?Q?v3m0hj9ocu+QUTiGYDG/3ZLsEthTqqz3A/bqtjo9CMA3o+YQsxjo+x3aLxqd?=
 =?us-ascii?Q?2UcUq5EUkrUGLTfKNI0fpebr9bKjra73CZGRSyuLfyxjcF54MJEhE4b6hEsR?=
 =?us-ascii?Q?GXKcmK+6NjsSNhwcX2kLvmABSQzi/0dSgr3mXO9bu36n6u/1n4pXXiQX9xcx?=
 =?us-ascii?Q?FmBXxMIrwFkgrQub2d70QViMsbJoTyN4bCJV5rQTFKy5r6zB6Ou/UumnkaSf?=
 =?us-ascii?Q?w5GiQ1LmmERU6cC1/kQGFmvzOCvpfgpTQBVM6SAVPolPqnfiy5Ld1BAwdg/m?=
 =?us-ascii?Q?uNiczjL/9W5RuypGFRb3kp0kdJyGM0u0IXjXo8EtHa3uhAiewhlzvPVR35Wc?=
 =?us-ascii?Q?wjgQzcI87iXKKF+o7iRBmt/zvF08SDP1B4Vi20rmKqgYr8+rWdQaEkUyYWE3?=
 =?us-ascii?Q?sNSXdsXGlVJCmmC/DyiAMrgiPFuiUzhU6ncb1yZ/yCn5bxaJEZ83pUM3Wh2Z?=
 =?us-ascii?Q?gvak0reFaeCeyGbjhoSkle4e7hevSavvc3IQ8PPaInvZbnKxZlHbpJGcq9LP?=
 =?us-ascii?Q?WQ3KHOBwMSB0c1azCJ+P2JsecNaCZAEz4whVvQioN8/OaWDbu0r17R19eWUI?=
 =?us-ascii?Q?dQFSOKWpwKtzZnW3BTNjjB6mGMvyMSeJu1HSN6KKs/UjEnZuYf7s+baiJOn4?=
 =?us-ascii?Q?Hqh9DaQiYCP6ubj0xy/G0cQwgHNxlDldqBlmNxrE9Sg0enhhL4y+2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sm3TDpOQlhBnqHSqYAz4hi912Zg5CUWtYtNVSwGsJlSOzfzJR/NXg8MNh9rn?=
 =?us-ascii?Q?HfoHiqq1Ppm3PZ3uivPsiyVpaG3+FWi8BkWrPperMZUfMhghAtQom9lLx9m6?=
 =?us-ascii?Q?Z2kObEZSAyy4vOaXTgM9w6a2hAf+KzHePyUFtQ+x8dfUcoWFn+DdinXz8WYT?=
 =?us-ascii?Q?XtRt/ba2UcbWqhr7eBvoNDom6DHVm7uWmyK4bEKyTJRxQkZBHE54mcmLqPAR?=
 =?us-ascii?Q?05wm9yb1CPZSa31LoraAt3avMJQi++U3NwcscHd8xwMMf3zKlaxekd6oXRQE?=
 =?us-ascii?Q?hufwXfUA2Hntb39hXuSOIirFj6Mep+jBN2WyTSD1Gg2lNVWoN/cg3TPOi1QO?=
 =?us-ascii?Q?e01a9AEFzevlUiPNCfpj5N1KJfJsb7x/AjTxbrH2i+vTHEcFe/Xn6dp3GZij?=
 =?us-ascii?Q?NQxTffYUVH7IWS8mqk5oz7nVROGE3O2B6crGhmZ3x2Wdw2dU0RhazsDxvHuB?=
 =?us-ascii?Q?t5M/nIfzvyaOB+eoVLkN9dHYQYy2eQXninGExiB3NPinI9WS5/Q8Wpb1U/qm?=
 =?us-ascii?Q?uvRy1oYfS7BC98oMNpUfBwyrC01riW2kbXtAc73Nv6+wxaBOU9MAEvgBoALl?=
 =?us-ascii?Q?8pxYFYblI9Q6cG/6kVpu3OhkYO8IxvfWVC8yxW8H7yu2UBY2T9BTKjU1GYlQ?=
 =?us-ascii?Q?RC6tn8CQka2/QvRJMDnfzZkjmm4jYWSngDswq1STa+VMkDIJ3Axvsi0zO1N8?=
 =?us-ascii?Q?lAyRyeV1T4y0HnZs4b1U+M3jXdPAUMw3xVY8s28aGkCH8mzjuCJ/hb/kvwsX?=
 =?us-ascii?Q?nzK+RCIdJQFY9CEWaOBPELodpZ0pGambp0445aAJroHtd9VyoryZvry9DsPW?=
 =?us-ascii?Q?VJSoyqB9LKuSAAy3QUjbvu48LlT5PLOStfMXZsShyCRPlO22ptzaNRiB47Y9?=
 =?us-ascii?Q?plF96wvfizkbsrPpUXKczh2YqlixS6Vt1QWV8L4/7Ximkp5gWsmJLRJpL6UZ?=
 =?us-ascii?Q?ezPvg6WGOA3qOQhTsjNnA7jJXTrSMn6iQ0WBdzptlE42v3Gz6Y9kfs3e1p3I?=
 =?us-ascii?Q?C3dl6MPMlVril/+odugNzAY1TGZer/WVW7gYPqepxhcJlJc5Y0hGKZWqNATp?=
 =?us-ascii?Q?djVUBX2brmr/tEfv45u0Vgr3XxslyG77eL3gBj9BXr1P3YUkHf51Bq6IDRtG?=
 =?us-ascii?Q?VmW9JioKzGmaPhBDVwdteFH3Q+uNoZCiaRRIKB7ojQfFifgfaoo7IPlUnRxs?=
 =?us-ascii?Q?pVgNx5zZxqS9ICVOpFewutr35pgZ6xOrsPiZJT5uwdyZ3ATzuBljPztPuI+B?=
 =?us-ascii?Q?HAZlwWz0FDR4XtHQZluj9HikFU87mWB7du1Y1+WJrMBKE+EFbxkKmp5AXn0G?=
 =?us-ascii?Q?iM+bWYXqplJ/zKmFYR4e0LoX+j4gT6lOSSiPzdhgIoZ7oi5OQJnCJFAURL+v?=
 =?us-ascii?Q?nIDzPaJwAOrTuG83b7K4uTV+T4ruQvxjE8W+5Ruxl16Y1Xvu7nC4qX8QFPot?=
 =?us-ascii?Q?GiuplUGsK2/rhvkbm51FfjXFkBaNmpYxw42I2+kYcaYXLacTlnDNarBIG+9m?=
 =?us-ascii?Q?/E4JAGSv0vQuz7Cpl/J+eUbIZWcPzEcvY46O0oOPg5/4Uykz8ESsCO/MagRl?=
 =?us-ascii?Q?Zfs5+e0pYXepTwfL76ALw2VfiVHNDuvuPOw9b08qNK4j9yybPCv1PzsnXhyM?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a754bf86-618d-4497-3a10-08dd92fac282
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 15:19:46.2161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9QT6Ecip6DHXboylH38UbBr3oSTQNQCAv+bBDF7Lt0IBe7taACrxyRb5zi8wVeqBiqQ5jMUncCdvkCQ71//Wrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7231

Permit programs such as "hwtstamp_ctl -i eth0" to retrieve the current
timestamping configuration of the NIC, rather than returning "Device
driver does not have support for non-destructive SIOCGHWTSTAMP."

The driver configures all channels with the same timestamping settings.
On TX, retrieve the settings of the first channel, those should be
representative for the entire NIC. On RX, save the filter settings in a
new adapter field.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c |  2 ++
 drivers/net/ethernet/microchip/lan743x_main.h |  1 +
 drivers/net/ethernet/microchip/lan743x_ptp.c  | 18 ++++++++++++++++++
 drivers/net/ethernet/microchip/lan743x_ptp.h  |  3 ++-
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index b01695bf4f55..880681085df2 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1729,6 +1729,7 @@ int lan743x_rx_set_tstamp_mode(struct lan743x_adapter *adapter,
 	default:
 			return -ERANGE;
 	}
+	adapter->rx_tstamp_filter = rx_filter;
 	return 0;
 }
 
@@ -3445,6 +3446,7 @@ static const struct net_device_ops lan743x_netdev_ops = {
 	.ndo_change_mtu		= lan743x_netdev_change_mtu,
 	.ndo_get_stats64	= lan743x_netdev_get_stats64,
 	.ndo_set_mac_address	= lan743x_netdev_set_mac_address,
+	.ndo_hwtstamp_get	= lan743x_ptp_hwtstamp_get,
 	.ndo_hwtstamp_set	= lan743x_ptp_hwtstamp_set,
 };
 
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index db5fc73e41cc..02a28b709163 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -1087,6 +1087,7 @@ struct lan743x_adapter {
 	phy_interface_t		phy_interface;
 	struct phylink		*phylink;
 	struct phylink_config	phylink_config;
+	int			rx_tstamp_filter;
 };
 
 #define LAN743X_COMPONENT_FLAG_RX(channel)  BIT(20 + (channel))
diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.c b/drivers/net/ethernet/microchip/lan743x_ptp.c
index 026d1660fd74..a3b48388b3fd 100644
--- a/drivers/net/ethernet/microchip/lan743x_ptp.c
+++ b/drivers/net/ethernet/microchip/lan743x_ptp.c
@@ -1736,6 +1736,24 @@ void lan743x_ptp_tx_timestamp_skb(struct lan743x_adapter *adapter,
 	lan743x_ptp_tx_ts_complete(adapter);
 }
 
+int lan743x_ptp_hwtstamp_get(struct net_device *netdev,
+			     struct kernel_hwtstamp_config *config)
+{
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
+	struct lan743x_tx *tx = &adapter->tx[0];
+
+	if (tx->ts_flags & TX_TS_FLAG_ONE_STEP_SYNC)
+		config->tx_type = HWTSTAMP_TX_ONESTEP_SYNC;
+	else if (tx->ts_flags & TX_TS_FLAG_TIMESTAMPING_ENABLED)
+		config->tx_type = HWTSTAMP_TX_ON;
+	else
+		config->tx_type = HWTSTAMP_TX_OFF;
+
+	config->rx_filter = adapter->rx_tstamp_filter;
+
+	return 0;
+}
+
 int lan743x_ptp_hwtstamp_set(struct net_device *netdev,
 			     struct kernel_hwtstamp_config *config,
 			     struct netlink_ext_ack *extack)
diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.h b/drivers/net/ethernet/microchip/lan743x_ptp.h
index 9581a7992ff6..e8d073bfa2ca 100644
--- a/drivers/net/ethernet/microchip/lan743x_ptp.h
+++ b/drivers/net/ethernet/microchip/lan743x_ptp.h
@@ -51,7 +51,8 @@ int lan743x_ptp_open(struct lan743x_adapter *adapter);
 void lan743x_ptp_close(struct lan743x_adapter *adapter);
 void lan743x_ptp_update_latency(struct lan743x_adapter *adapter,
 				u32 link_speed);
-
+int lan743x_ptp_hwtstamp_get(struct net_device *netdev,
+			     struct kernel_hwtstamp_config *config);
 int lan743x_ptp_hwtstamp_set(struct net_device *netdev,
 			     struct kernel_hwtstamp_config *config,
 			     struct netlink_ext_ack *extack);
-- 
2.43.0


