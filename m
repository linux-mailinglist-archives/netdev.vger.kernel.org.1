Return-Path: <netdev+bounces-267096-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GL5JJkHOsmmPPwAAu9opvQ
	(envelope-from <netdev+bounces-267096-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:31:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAC0273623
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4EF931CEF17
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92D93537ED;
	Thu, 12 Mar 2026 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZT62Pytf"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010046.outbound.protection.outlook.com [52.101.69.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42431310655;
	Thu, 12 Mar 2026 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325393; cv=fail; b=q4GT22y/1eTbCww22NW4LTNDqh1c4KWpWuoJF5PGzSsKlBJeP5/yr2p51fIN5xW+qf4SDsDKmqm1ocnXzDW5On7SXDBy3vg2bBcUQQRMAs4bnn8HI4Bi/dsV/LvJv+naD4UGgX5njP4ExRjQTP+n37mqXon1fnle32oml+ezdvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325393; c=relaxed/simple;
	bh=a7lEruVMPNdsajeHg2vy/XK3tMNRomkWQaqImp17fMw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TVvf5G+9BkgVjcwAOU677EBivY9ymL8Oxx1zENhPzrinwIvgFUoLjGIrrVKitdCbV3UIN1p2s6mYD6sgV6pvJk8pnD/+SzbKJ6ttzf6XI3hfKwvIlSCDTZs0juEMafSXMvtpx64IDILcLw13HxDkIW0Ya9OMTUvNKZPi3/0Js58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZT62Pytf; arc=fail smtp.client-ip=52.101.69.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aiL4aq+nLpOUacbCBZOIZ/uoVOSkdsH1wIfn4FvN0aIiZMNOP4e82q8wE6cnZm6b5syaQkQjC135AM1PB/xCz4bL7qHI5SF+jTXVwzCfG7Qyy3YZee6udhlFoUD2itPs2icMFyRx2M6MkhQbz+yzLIZXs5N81dLXUmWuDR5f2E1C69yuSarINWdbH/QQa//ENfzT2P3T2cC7tWqjQtDN5qJ29KbTuRtIhdoIJHpnR2aGsVsAT9WXsF7aRJ4Qhpexx6NJ66fNm3wNVNuxWxj2pKja1bH8fBjfqazPeT2O8pgCt1Z9RfwOou3Ofbr8k110oirXEWzcwFArQrRiqCryjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXNWrGRLCV4RyNvpxLCMBuvugPEIcUGiAygdgtC45/E=;
 b=oLU4KLnLxr3Cyb2EmJBnwjIWNTKjQoXNFD/YNi/fAqeaKRtMSidz23UkBxwLnDiy9D7CPGXhdh3yg10KXV3FIHkqw48JWHtHaNZpOpk3/hdqnUTzjn00aFo2hDHMahHcwKOYm1mDJhPUrLfXf1AUtTuCkkTQyO8zfv4vQyYKNyuoPNcZXwPyueLYE8gXxK0CUgtkB5IZcVYSApx8lLIsC30HEtXrV+AwK0DFAQxLpjqXO0FJ2H+/QFQkTnI/VMwBU4zojgjhLYJaUCut/2JbkYmCC1q0yzJTi8Uf7IhOhra8pZinxaZg0aPfw+6/8rQnPlvoppwhlgbo1/IufuAxjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXNWrGRLCV4RyNvpxLCMBuvugPEIcUGiAygdgtC45/E=;
 b=ZT62Pytfuaj9Jdb/AyWYn4JDUNEsHBGOknKO0SYGWyJT7Hc1lYCRBFKVAeY48jBAz+0RKjO8xC2FF2ZnfxQYbsVkQH8d5zwb3l2GtD2qqFJP+suv7LfhgYS4S2a2EtIoECLv7uw6DW4RLjOhDbEqU9iQdkARUeXf0j2mrIIfI7IMkv2pwtHWXLxtgq1i2ZMHYre8PxVC3pp+G0ZIHFD6azOkEYJL/Osz8+jipUaWx3HKOs9j2QWUHbV0RUDDr04vyn0gf57Tj2U1wx3sx5O5TLWNXASl0czXrMKpyhFakKHAE7LQDRDA5qtq5/TwiIFdtQY56CNxffwSbDJDGWaFoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by GV4PR04MB11773.eurprd04.prod.outlook.com (2603:10a6:150:2d9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 14:23:04 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 14:23:05 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 0/3] net: dpaa2-mac: export standard statistics
Date: Thu, 12 Mar 2026 16:22:46 +0200
Message-Id: <20260312142249.297192-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0022.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::13) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|GV4PR04MB11773:EE_
X-MS-Office365-Filtering-Correlation-Id: ae3255ca-9afe-4d86-3725-08de8042e041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|19092799006|1800799024|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	wkipjssljsZgSGxxPi4/zcaUPPRWsc6jiU1YFBewQb0fLUt+po05HcQOwAOkzdNVGZU2NJoUDaTzECvPBSZeoesgihuZ4gTFGDdQEdxI76wHD5KYeeqizPvIi8uSkC3PHu2w5GjyiVIuuW5z/W+gZqXzPjl6qTqEzJnCBGNGhOJthcTVg1g6l+W8qkykQjHLQtSxHHECgdAX2JVKUfmcwKPAN5mFSy/RMngHZsyjSnFACFFoXk8kXbCSQc4edl+UCwka+G/ZXW51XtCl7o8wKYeAniMqXQ62oxpo8BOmwhc9NvD0Waq/5gPUBclXORoABcZ/vpdaOtOUJ3wqnvamE+HgibTZmSkBO+ISobvlfT/cmDaXW0dqRXd4ipcVS3iq1nyHiyy0FYbkVlAnYiQrKGaAo3gXHN0MjqX4G+RrIioT5TvBHM2yQDRlWowma/rc3psNaU+XuuQ0Yh5iMhf7nRe7nqMbp4OkpqfAbzjRmdNOcvDnygZHp6Z0WTPDiAX/G0kEHsQpfNrypkzigokE5k41+uCwKuRw9rweAdDlvxJXbL1lrwzPhKJ9hDs9odb1SHChRVbh01h5Q/wSrnOJjIH+NJ1lxcDWQLI/CM2dfx1nhmvPUqxxwYcrYrVld9cmYvszUOBjMyRHUp5xyVeNtenMi70xL3dh01p8MIjQTfE1OCUzDp2FbNyD6TPUOkVn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(19092799006)(1800799024)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?No6tea74dTbR3HzfR/ZiH3FZCdJJ4ZXUmvwabhID0ImxmZFZzKretCpgTU56?=
 =?us-ascii?Q?rBZ9kt2YU5EX7Uae/NoDkJp1HhY2Yj1iYRTgwCGwWHRCDI/hmKtnyevxsTXV?=
 =?us-ascii?Q?KwVKwq9dKjSBQmny4r9EOdLON0ay123oktdIkoDY5Y6IhZPE3533d67pUYSK?=
 =?us-ascii?Q?wAwWvEQPoT4qcTJRfkkMVPjzvLwJ3qMfp3/a9tgYeyKgCkpSBWmKSgJxRuiJ?=
 =?us-ascii?Q?sOjA6vktDQ8A/ZqdzWV4InmHRRG9fKJYj0kCtXQLWxaKdj3VRmvfBV0uzqbR?=
 =?us-ascii?Q?GsgOheWgL53HNj1imrz+nnhPbRp8iD48u0mS6/VnpDMzl8NAeZhA6mywRk2j?=
 =?us-ascii?Q?2ylXkva5HAw9DlZxGvXA5tgNWWu7egzGwXZMsIpJZQ2VJdhiq12OnTdJCi1r?=
 =?us-ascii?Q?jvEBRL5NlRVkqPAEqsmAshwTWsrT4ucUnHSbuhaBIzfX1qkrceaqSEBN66F6?=
 =?us-ascii?Q?nz96TyjQxlWadUXgu3vyT55lUXg3F9mvhBPYXWrsMCO6DBenpmPQkNPmZghZ?=
 =?us-ascii?Q?EQJhkrIeiTYjiKP8wxZB/f38B5x/EBAhJ/p/gP5jTGWt9vggDwTqe3J13d9H?=
 =?us-ascii?Q?KDi8dGWsFAmAirLkN8M81Nc3U/V+tLO9qr8e36xiIcah7mgNzcbcobYgpdBt?=
 =?us-ascii?Q?jpD/4Cy/RFCsN2poNQCjo39+7+ZjPgnv6yaSrcWuK7tqJoNQZUBD6Yikhgek?=
 =?us-ascii?Q?G/fqzyYgc+M89f3TVmFTVWN6CbMiTm4t3e1WWiuL3Y7egLRg83hm7e/CrufA?=
 =?us-ascii?Q?C1iaBPZGnrmM9QxHwQzjyt7JdrOnKPK3USh6yzu99BG+H0bjM7kk0E1/B7jF?=
 =?us-ascii?Q?+/3JRg7ekGlwljLttDzgwPjKjRCtr6WzWnuwvOv3cBLmmrUq8j48UDrrqPZp?=
 =?us-ascii?Q?QYQxCfggY7b0eeukijzHMb5sI2wfjQ7friVIMeJLfx9rOrij7HOSj6RZXcUV?=
 =?us-ascii?Q?g+1ZF8u5wkCv2D+gv1Th2dz7p7tTbNKzOtvC12dibOZQ0P5uK+F2nuqkVV3k?=
 =?us-ascii?Q?l5aOLCtGnRgIG0KCJ1zXiXgbeOs9Lg5xg4xyxHFbrKOq7EzsNFbmffc8ZbdB?=
 =?us-ascii?Q?CmR2r1VCCashqrYmgAl4eyP424OMlA0CM4YngPJBEuKi5+XDk1msSRxpXXsj?=
 =?us-ascii?Q?MAzdSGfTPW+LMN9eF3pyPgLR7MTg6m0qgdR4sdhQ/gm6irSshcShEI/2HEX5?=
 =?us-ascii?Q?B0pf/JtAeTOLqKtPz25jA0yrcAX4Z4uB9d1GlJ6puhMrdyJz8cPe0x0LhSS0?=
 =?us-ascii?Q?INpU2v80/5XV8HOYQZUJ6jNufO+VfQbmyfnITF3+YS5V3dgqzwlC0ShrdHlW?=
 =?us-ascii?Q?Q99cG96H20dbuY8uPVNjDsIVuE408hgunxtFJ2NG2PA5CS//K6cLTg+GJbKy?=
 =?us-ascii?Q?laZdCkLp7zfc6hH1PuP2tA3TmXEI20KxWZmtOOtlQimYze9/2Gv1OdHmcMka?=
 =?us-ascii?Q?5BgNyLk1zqGsyzunXqNg1VZKCT7O1H6TTv98BKria5YEo4y/TWCXgwAmwdiT?=
 =?us-ascii?Q?6QQ7OGXWnlt2BRjbKlLlK81yJ673UYtq1sG8PG/QlDEiR5NFsx0DVARUUc4h?=
 =?us-ascii?Q?euUTjZ6//udfL1A2q/TzFg+cC1PVQluACWr+ca08Lg68QbBtcES9fxzZ3AAt?=
 =?us-ascii?Q?nbnhet0N5b1DDLr/sWRX/CJ4MY4gfGeQ5LGQlwtsYMie8+oSrZrqsCbDu84v?=
 =?us-ascii?Q?O4zakN7Bg6oPtkHi418Kx2lhBfor2noQoamRJrB+k49zgamoaTnTbcfNQp3S?=
 =?us-ascii?Q?NfM0A8wiLw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3255ca-9afe-4d86-3725-08de8042e041
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 14:23:05.5870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DTtVyePGwxWjQoWiPEki7uk72xD6nUDBgqgnW6Av9/0FtGKQlcTDyglCpG/VIbFAGfy/0ACrNS3+Rno7qjRvJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11773
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267096-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ethtool_rmon.sh:url,ethtool_std_stats.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: 0EAC0273623
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch set adds support for standard ethtool statistics - rmon,
eth-ctrl, eth-mac and pause - to dpaa2-mac and its users dpaa2-eth and
dpaa2-switch.

The first patch extends the firmware APIs related to MAC counters and
adds dpmac_get_statistics() which can be used to retrieve multiple counter
values through a single firmware call.

This new API is put in use in the second patch by gathering all
previously exported ethtool statistics through a single MC firmware
call. In this patch we are also adding the setup and cleanup
infrastructure which will be also used for the standard ethtool
counters.

The third patch adds the actual suppord for rmon, eth-ctrl, eth-mac and
pause statistics in dpaa2-mac and its users.

The support was validated against the ethtool_rmon.sh and
ethtool_std_stats.sh scripts from the following patch set:
https://lore.kernel.org/all/20260312141740.295353-1-ioana.ciornei@nxp.com/T/#t

Changes in v2:
- 2/3: fix fallback usecase by using dpaa2_mac_ethtool_stats[i].id
- 2/3: use the __le32/__le64 types for cnt_idx, cnt_values etc

Ioana Ciornei (3):
  net: dpaa2-mac: extend APIs related to statistics
  net: dpaa2-mac: retrieve MAC statistics in one firmware command
  net: dpaa2-mac: export standard statistics

 .../ethernet/freescale/dpaa2/dpaa2-ethtool.c  |  59 ++-
 .../net/ethernet/freescale/dpaa2/dpaa2-mac.c  | 383 ++++++++++++++++--
 .../net/ethernet/freescale/dpaa2/dpaa2-mac.h  |  23 +-
 .../freescale/dpaa2/dpaa2-switch-ethtool.c    |  45 +-
 .../net/ethernet/freescale/dpaa2/dpmac-cmd.h  |  11 +-
 drivers/net/ethernet/freescale/dpaa2/dpmac.c  |  30 +-
 drivers/net/ethernet/freescale/dpaa2/dpmac.h  |  86 +++-
 7 files changed, 594 insertions(+), 43 deletions(-)

-- 
2.25.1


