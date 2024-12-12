Return-Path: <netdev+bounces-151450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6616A9EF5BE
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 18:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90201941EFD
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 17:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128E42210CD;
	Thu, 12 Dec 2024 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kdORbESy"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2067.outbound.protection.outlook.com [40.107.104.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4F81F2381
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 16:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022566; cv=fail; b=c6O/dvXmk6kaVQS47WrTNPoSGJCt2zURu3aSae6KmXrQmppQcQQhELa8rXqUFniZFtI1AjrJGfV2bwE6m3S8+ZHz+PnmqnD9U5YcbNsfgokZ2MWIL9vtUt8GMrhfgHFpWOV8GjTrtcB7VnvELHj7SkV7bK7dCySaAL1wUZrw9/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022566; c=relaxed/simple;
	bh=u/xvpwT1A9n+MjY25IE+Srx+A1xQRUbH87qCpiL/pjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=B8b/sPASj3U4oPSXsMQJXXlUCwbZKQRdYYH6q9b9yjg5FpxXdsQO3G7W2AfeyJPhP7H6keAO/Y+zfgkaqjSMK+pZYW39j1HhyWkXGoMKsO9MJ35mhaSB0jqGAXSf7ae/YKW6xj7go5PJrkrmjdMaV6jZGa8DsXnkCEQ7O0sGPH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kdORbESy; arc=fail smtp.client-ip=40.107.104.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HaAn5lCKJi4jhuu+WBf4f8+Qo7RbrfPhpC/npHPXPQg94YK/51+2aqcFVisaSihHxHcjb+TRY+ulEpeSel27eN5bIz0mgAzBxQ5gvmZ+sX0eAi0w8gtNOF4FKJKivW6h5UVNqu9oHWdeyN+m5pT054HkcjxX/ZpSzLPo+rikwFuHyQP22AeWGjzo/c1+QwTUSteVuwp47jv7WJObjaTSRJC9KCWz8NzhjmnW3JjpgfkPH25XpEc1sb/4BQUwYCNdB6XtP8gBNzIR1LfTh6bqdkqZKur/vfXPgUvH0vXpbzHO+hyOL4/6dbfTjNFvh6TwvcpFdDX7wR1tHvsOIqeGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fh/94+8z8Poh01O9Oyrc0qEoXVfQbhdZALa3znVZoIQ=;
 b=dzy3zL2gPLT21YGnmOhD5ngS0op8zeACx1a+CeXZuzjWwjk8vYjbNbOjvasSo26Uhb9Rpj7wrm7C0o/FzEvakf9KZwaAuHwjSxX1A2bcZNTRH/rl93FSYXCy9IESB0BEBD7Xn4QPtVAWTs4Z1uwqBpt0Lmc5gF41qD5gyARwKqw45pqEuUn3gQd2/hJMR7dTC+8McE3byEglJteK88zWalSNOLHR6GNLz4ifwKG3GcDGPd3NL/aspVuVxHOxnpVopMtLlXT3pObF+1m2lRh5xK/i47fO39fbNHnFRUw+wHbb/EtZlZn41ucnLRvaKfMb+kmHPQk75e31v/AYHDJC9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fh/94+8z8Poh01O9Oyrc0qEoXVfQbhdZALa3znVZoIQ=;
 b=kdORbESyV3FCQ7edMw4fkQAwkByEFp+69Utd4czEEjoAv8asUZc8C+QBSVTRVGYRGm21U9RiPvhYF2DKCPasf71TQeuDHIcL9EykalgHQx2/E90dVZIU073fwgfv1YNPN/fr0/7pif7p3jZLvHC38MA29KbT4o1nl+qnD06dSIXFgJvIXQqLDUBRCerD6BPePNpH64ih1JGdcocFJK8T75Hx59FbRk81+xzE2y0w+cBX8VgjXyAytpcLEhyNcap1Hk2ArE1x2zGkJutWhbdeLjqioi0jagNlUpcw+i4zUYIL7/sKSVRNf5A32NU5ZOLDXXBwNe94M+w6UP9W4IgACA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DBBPR04MB7612.eurprd04.prod.outlook.com (2603:10a6:10:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 16:55:59 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 16:55:59 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net] net: mscc: ocelot: fix incorrect IFH SRC_PORT field in ocelot_ifh_set_basic()
Date: Thu, 12 Dec 2024 18:55:45 +0200
Message-ID: <20241212165546.879567-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0145.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::29) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DBBPR04MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 19314a8e-ff05-4053-41dd-08dd1acdda53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9qdHvaUU6xKsJlYBe84yezWEcTq59Su+fOUV2ufRW0j5qAvhBPaGToTYuO82?=
 =?us-ascii?Q?cP87dcHO3GxJBbcVQscXSn5gh96T1LATc4+aM6JxAoOnQ3XyYD5qDTxCaWRA?=
 =?us-ascii?Q?/zun4Ds4cTqgZHbvARMrpfVY2RgdD568d4j4lUIQEwRtL3eIe4X1QKLb0PZ/?=
 =?us-ascii?Q?9A0o4oNTGMevkI1SMz6jMcYaA4Ie4BZIcx5NtNYZgsHXd756C/gho47k1n7s?=
 =?us-ascii?Q?9mPAjTbICrbx6QkXECykncaa/7462nf55RIemifAZIRFKWa75gVnATJMY/I7?=
 =?us-ascii?Q?VLXIuRFny1DE62W5a6U9br5BtX+E4G560YJjoTmsDY610cpdXD31egXAMA0V?=
 =?us-ascii?Q?2r/DJTiLGqtork2+u8rH6cGSKRHRlbROnXT0bieRbqEoNKOS55f5A46YARJh?=
 =?us-ascii?Q?E/XUlWxcMmDrINrmsxHT5Dt80HCFoCdsQg5fpUpVHMTCidRgXb6XwXzx4wvo?=
 =?us-ascii?Q?0AfcNYxellgzJgRQPwrHtcV+bGVzMgxfwN1UJfXwUE4GrFhhChyoFOXL6n48?=
 =?us-ascii?Q?tXb/uXYUKqMCd4dFn5at3bvq25DwXYTqpkKfFU0UdCdtkCjwb5m/pJFV0INH?=
 =?us-ascii?Q?ERnGvaRZBYFDhJWZf/QKCRMUZ7ZutHS1QsE3z+sdRNRjRYjD6yZIJDX4vYOl?=
 =?us-ascii?Q?ndj/+tAv16ZBAk8WOaNuLKjyRGSYi/zvpvt61B9sjSihtNUxgCjpVvDvwM2h?=
 =?us-ascii?Q?VAz47hL7qzs7r4D6KFlfs6w062yP3a/ewclSG7C7kP3qNaUcAtdq+Vgf3Bra?=
 =?us-ascii?Q?TaS/xLm4zg8DIkPGDPv9WX1cCN49b5Hy2H+oDr8srWM8NRRbnrTDzPS1JbDo?=
 =?us-ascii?Q?T/Lwg4GW1Ip/aJvYaDVYzwZz0AZjzytFoRh3F0UsPyI6lWbFrqFLJnQ3aDgG?=
 =?us-ascii?Q?GnWuHCguSclj3OuNsm2a4cy+pIer0zZGL6tsl7hqYJfJJ1ohyXtsiCjNDxJs?=
 =?us-ascii?Q?qxuzjejk9E1BZs7zH3AUmT9A+JIthE+DhlQnS6qAGPHh1KUbzmbIfD0MeCCQ?=
 =?us-ascii?Q?UoVkD14qvrlNP0r0ypVQ1TCesOpoG8EFi2NLopRYoXb/wGQd9lxaU8jR6wG6?=
 =?us-ascii?Q?aIxq7LHgPzBJS5nbwdsr+aCIiOTVbwgJXIgrPa/WjeW0mPdpHgh4WoRdZBUw?=
 =?us-ascii?Q?I8mEe3+zoZPAmv/i0HQbxnrR776Co79v2//GrMagPMjUoXJoNpVjAdI+n4qR?=
 =?us-ascii?Q?YFBD5057O3J8RjGRs805W3zc0Smr0LppvI60kEEwuX3zJFL6JeSnq33bEHP8?=
 =?us-ascii?Q?fsXFJoNKUCTBLjTdMCgcVrRoROfb1Suxo3fIVvbmsUsJNFXzgE0nrwaDA1SZ?=
 =?us-ascii?Q?RSWZtn/x4/1Rej9hDpA3vMg08e3bIKKoCJT84A9nOxyL8/WEAA9XJcTnnrQt?=
 =?us-ascii?Q?7X/kdnS/iRuskUk6WxbnIBKXUDx+MuMmGJ/ZTgB+EFlBGEfq1g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+N0gYKhAUkHs/6YM0m9Fm9UfVDPtw6C1gZhSA5EY6cRurtGZ7PySLtdCsFt3?=
 =?us-ascii?Q?eHPkJpyKhqeUdcTfF+xy21l5JHgOuF4tJUau4P6bUsDiFIM2k1ol+GM/7+iM?=
 =?us-ascii?Q?4bUc8xwdrqNASKEfflXWErRZ2zo9kufUsXziptGRdOIVJ3p/eKWQuY+/XzbR?=
 =?us-ascii?Q?7zX/S+vT+qTMO7anBIfDEfiQpg0zmgkeNWHuxTl944J+2Tsb7xa4a984a5Xt?=
 =?us-ascii?Q?p99wL2eefMUMh/MbLd87XAQdSuVxK3FJNvHTx3DouTLTYTDETp7mRvw3aKjp?=
 =?us-ascii?Q?sYAbXCropfiLP1uHjLKQe8PfLhByEPg6BslxkZKywSRO0uycjmSQxP2KxuBy?=
 =?us-ascii?Q?uEVFrnF2nX/QSSDrkGbGiXoOQHVchn/jgCHfzzfzuEEIJ3t9DhFfPuhmwNMw?=
 =?us-ascii?Q?iJ1x9M+BKfKWiFVCt5nfabR3Ukwl0stO08tQPX38i2Ttfma50zzBBVpJMYm9?=
 =?us-ascii?Q?FQPnJs/2oLPhl1sfPN+YnQO26SX0hNfLvOI9bVo1B8zP5iKIkWbXR9JnDtXR?=
 =?us-ascii?Q?DKWCjXdcTFvS95X5VrLXvKpG91C1kVuDV3QSWmsorZXu+YKLAy7AuAm7qy+Q?=
 =?us-ascii?Q?APgEnGsiieoQ+uzz+Zj3bygZsVtiQs9KDucoELCgqV6688vVg8uXVr1INdKi?=
 =?us-ascii?Q?QLGbyTEICO0Mcgr8QFGWMXts8eYFwWUBYm9PigAFkRjqk0xTA6E8YEjiITOH?=
 =?us-ascii?Q?yriwblnmtTeGuxUhOLX6ZW9PWUvhU/uGGopl0JjmOsVZlG9IzouCztU0siuM?=
 =?us-ascii?Q?1YuVl4qtq26Jw5jadninMc0V58FRP3oeoGPnlhg95ujhmJiSA95puErWptnl?=
 =?us-ascii?Q?lMu2OuuEhUGgJM5gEn8QKs6NGEOGuZy7pTC2zCJ3k9ZG1XbxUZFlg7gtep0o?=
 =?us-ascii?Q?3XAzqyTxBEX8Np2caiRQQZXU50fz8aYH9dQBR+rvl4emkHEq8oLFUlqh0ueO?=
 =?us-ascii?Q?26YVRyvUNKqOf3RSsoYG+/Iij/bNOsbaeMFmRQCj2DsVuTSSKYxNGYlWYE/n?=
 =?us-ascii?Q?mvfgNtMGcMX6wukmnOBp11IyJuTPHct/81qvexpZnA73glziGV1/vjtSq8hP?=
 =?us-ascii?Q?4y33a3ywyOdyRwECkjcBHisKGqnmEaPSW/7K1vPpcaF+V3oj7VvUtxVufvmE?=
 =?us-ascii?Q?QsCQY8Dm2bZ3M0JfkJz8a2gaDGNPs0bX8737aS15zjd+tKNPZHa5cXpPb83F?=
 =?us-ascii?Q?gyj2XHrtXAn1PprN5oK0zUeJrhz6e/UwI9S2deYbyQBa1lWUMwH1snbiEOFk?=
 =?us-ascii?Q?s6gsmmSIEZY1Iz6hsdaHhPpQIlU6jHy0yiB+WmfI8zXT+Argc7ZjsMjTnaD2?=
 =?us-ascii?Q?Y6i/duOkE9v1/YrYuGfd6xOU0t8cJDXJBli6r+xLOs1L77E9Vp0AQjmzdgQS?=
 =?us-ascii?Q?2CQmk0LRVcXUaJgUwuvBykvHs4d3Z8xrVm0JtSxkrxyc+omh5Knyx4ICS/bS?=
 =?us-ascii?Q?OkrwXDCZigcfCnHXOcfKDA10vcdMdTpXEQN0iNS+ounRkNatvLItFAkTlYxi?=
 =?us-ascii?Q?1CshlLdv2+h7gN9RxD8MfammL2Ytu8FtqbW0TeliTXaePVfe+niubRk6a6sI?=
 =?us-ascii?Q?CucuSGIRzzON5dqY5wvLsUvkxwZXtHaE1+mOxTGhU7ER1DVtsuB/WdBjvTw6?=
 =?us-ascii?Q?2w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19314a8e-ff05-4053-41dd-08dd1acdda53
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 16:55:59.2345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wudp8rO38IZxtqcztaFTb99haxFOprWw5M2Z6YECOc/UmszoxnA3x/1+fACSK48mB1kQcHuPVm3Ph0IMqRwtoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7612

Packets injected by the CPU should have a SRC_PORT field equal to the
CPU port module index in the Analyzer block (ocelot->num_phys_ports).

The blamed commit copied the ocelot_ifh_set_basic() call incorrectly
from ocelot_xmit_common() in net/dsa/tag_ocelot.c. Instead of calling
with "x", it calls with BIT_ULL(x), but the field is not a port mask,
but rather a single port index.

[ side note: this is the technical debt of code duplication :( ]

The error used to be silent and doesn't appear to have other
user-visible manifestations, but with new changes in the packing
library, it now fails loudly as follows:

------------[ cut here ]------------
Cannot store 0x40 inside bits 46-43 - will truncate
sja1105 spi2.0: xmit timed out
WARNING: CPU: 1 PID: 102 at lib/packing.c:98 __pack+0x90/0x198
sja1105 spi2.0: timed out polling for tstamp
CPU: 1 UID: 0 PID: 102 Comm: felix_xmit
Tainted: G        W        N 6.13.0-rc1-00372-gf706b85d972d-dirty #2605
Call trace:
 __pack+0x90/0x198 (P)
 __pack+0x90/0x198 (L)
 packing+0x78/0x98
 ocelot_ifh_set_basic+0x260/0x368
 ocelot_port_inject_frame+0xa8/0x250
 felix_port_deferred_xmit+0x14c/0x258
 kthread_worker_fn+0x134/0x350
 kthread+0x114/0x138

The code path pertains to the ocelot switchdev driver and to the felix
secondary DSA tag protocol, ocelot-8021q. Here seen with ocelot-8021q.

The messenger (packing) is not really to blame, so fix the original
commit instead.

Fixes: e1b9e80236c5 ("net: mscc: ocelot: fix QoS class for injected packets with "ocelot-8021q"")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
I only have one board which uses the ocelot-8021q DSA tagging protocol
by default, and I don't test that as often as the other LS1028A boards,
and when I did, it wasn't with Jake's series applied.

 drivers/net/ethernet/mscc/ocelot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 3d72aa7b1305..ef93df520887 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -1432,7 +1432,7 @@ void ocelot_ifh_set_basic(void *ifh, struct ocelot *ocelot, int port,
 
 	memset(ifh, 0, OCELOT_TAG_LEN);
 	ocelot_ifh_set_bypass(ifh, 1);
-	ocelot_ifh_set_src(ifh, BIT_ULL(ocelot->num_phys_ports));
+	ocelot_ifh_set_src(ifh, ocelot->num_phys_ports);
 	ocelot_ifh_set_dest(ifh, BIT_ULL(port));
 	ocelot_ifh_set_qos_class(ifh, qos_class);
 	ocelot_ifh_set_tag_type(ifh, tag_type);
-- 
2.43.0


