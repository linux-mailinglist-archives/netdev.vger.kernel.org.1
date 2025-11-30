Return-Path: <netdev+bounces-242796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E2BC94FEA
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 14:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9424B4E1383
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 13:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CBF202C48;
	Sun, 30 Nov 2025 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g4DF2XU0"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010044.outbound.protection.outlook.com [52.101.69.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3424E221F11
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 13:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764508659; cv=fail; b=BvNF+QA/fqtP7CkwV/odxMjD/SOu1kN0RaypDU+7GbBXvb2a5AzqCVQAAv2XMHtbZzrwGLlCvcB5c72SmbdbbDkXoaa0v4GqrXoS1e16UhUoRjgdlei6A1dedR+ZVStzeiYLzJRE5t6wNlTvrofzNsrZnEbB43pKuvpbLXdzM0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764508659; c=relaxed/simple;
	bh=e6nLIiJi8NRVwHc466pehar9T1xmOkM9Anbs6xpfqsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n0uWL15+qILPuvXn6T8N/FeFYYxGbLNtSN5a9f/iANSJ2rUf/fc04uIM1kiunJFMLpQFiu27q00bTFgqHpd8Cbk6FFzEC17oe33DW5bv6lXOlpAISABQTF01LZT91qUi2UrBK7gtgfWjLJT+zgQLmzZeicOz+MJVZk9dJ9bWegI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g4DF2XU0; arc=fail smtp.client-ip=52.101.69.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mcYqMAF6z7MjgqovN+j64Gq23QtHcpPCFHqqtuzIiZAlYWFovsuXDeTHwrOispTFC0Q/70WpPjIc++75tJN03zunM2wxRhh5CRse8CgRYHcvB3itF/2D6aw1vhCZi6JLmCTQyDYDKxJ74qcdW78cYeFvs2lBvQbaHkG4sUmV8q1z2RVvvSeyH4gkXL0fwti4fV0QTwxX1xyxMj3WSPDBjCgqV8KdTR8I6Krl2IMgzD9FAWmWNYS1vztE/M0QoK9yoARy0eyv3wNbg4R+bbRI++Xc7TSNlFSSD+hi7wLL4rh5zmrhlkvBuNt+Q4VZPmRswTZC0ju3ITEx5teMgRZs0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEdPS5QfJf9UNH8sLSHTce2sy5G/KzkSBVaTR6LE9WA=;
 b=yNFQFBxnw82kK5brEYRkDtY9y2CBP08sMKsnx7Tsb7guoAwEHjomixEiKUKk/Vqe1NOnZAEz4df7ft7zqIZJx8LrR7qmupQ9l5CTsV5Jfi8x51LLiLseRs0CylE6367CHTv7Ur9XJqjjfpkWwVDImfPGZNJ/doS+QwoDiuCmXTHgGwd2IM8D9W0exgQX+Q/RckSnzclEM4UEQnuFzZcnxuNaY1001xjFeBb2LSEVpCyleMu1mofh0hziwqFENZ5m7Hlc+FGx68Ugk6nh4ra8YEwc43lA1A8wZKTffs+scLKOTVo+2igKq37e5YPGNTc2hImrEpFsmV3DPfJI5h+f4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEdPS5QfJf9UNH8sLSHTce2sy5G/KzkSBVaTR6LE9WA=;
 b=g4DF2XU0f6gLqIFIT1mmooj0F/4I2Gm9VsW/EH05T3NRGO68oZOHohnZjg8b5MfBettZVDOkE8S5X1GDoRXJqvALJTfn5ahDmQa2heD9g42HEjxRS6i1NfelGWsT9yyxcjKeH+ZGoi+kKaV6om+ahHASq3cV2Fhc4wqCoKAXeIniKIAgH88grvtqokaesJq2hFOCLjzayL/HU0kqlLdejG2RyYSiWOCUV0BGjN+gT+L87CHtEUHYNIEJk+U6LqzfAjbSbz+w3wjrVF9wHTEGb/QSAcFAmA8w5IkueurcXDDFzUkfQ7fjD2TEGGZJSYk1SLKYwVLO5Sr2j8nhvUnRqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM0PR04MB12034.eurprd04.prod.outlook.com (2603:10a6:20b:743::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 13:17:31 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9366.012; Sun, 30 Nov 2025
 13:17:31 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH net-next 02/15] net: hsr: create an API to get hsr port type
Date: Sun, 30 Nov 2025 15:16:44 +0200
Message-Id: <20251130131657.65080-3-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: cf9222b9-1455-4476-74bc-08de3012d15d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?serag1ecVRDmnSQpFu12BF40BTYWXulFmM5d8Or9+faEUPCOJip3Y9utmPs2?=
 =?us-ascii?Q?VrMViveA9if7HlP4O25nDfHylSAa2gMsMrtyQJBadN141oERNO4b47phdTza?=
 =?us-ascii?Q?vra+KFed630o8zyZW1IyPg0OGey3xW6b5yj9daTX8Q667LBmvDXJHn9Do1QZ?=
 =?us-ascii?Q?/B3gwXrArHoLRXkkcqxQ6hPCIkqKUTwtzPE+frWfyxePykJNoNNJMteKhKjz?=
 =?us-ascii?Q?qvFf0RJ1fVgLLXpNpziW6Q6hpoX1odo0dy4Ht44BUxupGvIUxPqGUBfR1u4n?=
 =?us-ascii?Q?cRQYdpsnwi+8l1AXvAOlAvgplgSdd03iXerzvwed81lE/kudpf9H8QTe6/R/?=
 =?us-ascii?Q?SvRntZY0Vybw3zlBGEqLf9bFfumy2WN6jD5sXLnwB9TobNhRSrZvn2FP6rsv?=
 =?us-ascii?Q?1zUbnHmTZ27H1hyWlb4/hxboL0S1M2AhkY5fb7qpJNi6IWa+cfj8zZ0jSPLz?=
 =?us-ascii?Q?A+bBwoc95QqElLWJGJ6v/yyXehL7zCz1GHEjmtibSWFiHVTRHlBz65CsjEqn?=
 =?us-ascii?Q?mrToOBKoENBWu5Dwr+c/rIJ0RzoIXW51enFs/cDHJCofXj9WjKjeXCBlTGp/?=
 =?us-ascii?Q?+9OzirrHDpsZI5Td7Pt+S3kj+YHAPMCA8ktX28Cs0JBlcZ/FzWUe129/6UT5?=
 =?us-ascii?Q?EanX8vGZVHAW4AhaSIlSMwwb9LRo1k9q2XoirBS5SDkgU39qh+Z3vT80JA3J?=
 =?us-ascii?Q?AyzUImYFgcyTRAps1ftNOM/0P2FsorEOXh1RP2ux3hPEI1ylv0zRry2nStrv?=
 =?us-ascii?Q?xEFspZyUW2Yv9Vp9dbPgpXXIPvaT1eHjJOyntXDCk9t3G78MrJRG4j5g1pQZ?=
 =?us-ascii?Q?vMzjoZNRJLZxdratTCqfdDX0RsTHOIJCS79b3FAVcbsMDA6ovMsuVaPjdPsZ?=
 =?us-ascii?Q?yx1r+Ftu+wbjdfzdUWBWK3YwRgZX1KGQqN6fg9iCQL136oqxh4xO4czquXe0?=
 =?us-ascii?Q?TnxLqWZZKfzNEW86c7DSV4vMbT8quENeQMw0mbfXchHCX4U7PhEOlFzVxyl9?=
 =?us-ascii?Q?9qlWuBJFC6+Mx9nmjo0Be4ScNP7ugWv3QnQqluXrz7lRm879POpC52no5qLX?=
 =?us-ascii?Q?NbrX/W9GHCxjEsx3t7UxJnq2SpD0Nq/QPy+8H9EZaKcIXLfSUDinZyTuudbL?=
 =?us-ascii?Q?20a3/8y/AsIygzKaG38h5hnHOmbp0krR1XTta8zDNSVtcVSDAv2DL61DQZtn?=
 =?us-ascii?Q?ExsJKi5K0jZSiOmxdd5qcn5eU842scsUCOuMpGUWYbORfeUrWiVCa6Ic2IYg?=
 =?us-ascii?Q?2vKhH3OrMdOjXsgPkvo4tMp6LINFHgRYaXMXE2VgZqbMA3d1pgxsywlRX2qW?=
 =?us-ascii?Q?Qpi6xkvS3xrtiRJXHQvmSKewbLXal40RkI3yF51wi+kA/xoEUVelVDpRAwpZ?=
 =?us-ascii?Q?pJfSbr8Mib7yaHXIzvMME+8/r16vQc+E1Xj2ZnSYuL0PQyzVZycUasA1Kez7?=
 =?us-ascii?Q?F+XWE8mTf3mEjg0V7pn0qH+AMqMqag+TdDgQAzp5Wy7R5VA1yHYjrEGoSp2m?=
 =?us-ascii?Q?NdEqx54YBxvgJdpFGNYu1bFjRGl2iNSn5xL7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U90ppSfxXu9WW50uHxRoQDXQzOgJf6EP971gm5XvbcTrv2otXo9pi56KcT49?=
 =?us-ascii?Q?wFYs+2c279sac8PIQMAqT+risliktPsuvWwYPkz7HKVT6JR8wfbmjzNEXaX8?=
 =?us-ascii?Q?hdSK/oj+qNBNT7fp91eaVTXaZJcL7c1wtZ9BeME6Zy7x9Kt8mHEc4Jfy+1oa?=
 =?us-ascii?Q?WGkRFU8CgZSR2Wn29jxPPX7Qr8po9vuZCFOwCuSW6q/xMJyXlkur9YqubKMo?=
 =?us-ascii?Q?XEvdy1jhPMcRBSrSsRlCSc5EFZK6Sc7RZiTYLbJCqMTJxqhA6AZXz7024S6J?=
 =?us-ascii?Q?9flC9ZnqH+886dr23Qei6B91FZwB4/pu2LdX7UyF4IjIJ27qjHX1v3r4fsZS?=
 =?us-ascii?Q?ypF/ZabWMgZIfIBT9uPysH7E+FvzTUvRXqwiIn/Xhhd+KAap+lB2mrvx1pCn?=
 =?us-ascii?Q?G7ePtm82OGePrNcpxbWJuL5Nt3lJADj98/qXrg8fTROgPkySl6u7d+1jMdNK?=
 =?us-ascii?Q?X35cO+3NjBTuyOznn9L7VN6spFqXVxY3tsBQrvTHkFH4TWOz7OnPM53XVeQR?=
 =?us-ascii?Q?4XlOdiJnIDSHtYOAw32cMtKnSvGHc2echDGTii37FpBjcMnTRV43Pp80UmIn?=
 =?us-ascii?Q?9Q7NvTQwSAtekbMiJypPVjoiw7voiT79t1chQQ0Z6FXI7Kx1FkO1Z4BltUCJ?=
 =?us-ascii?Q?BwDTXWWE3k2eEHPiGVJat7unMpmntlGDHSUt0c5XD8Bt3nCn2yFHIWEVj4fb?=
 =?us-ascii?Q?wM9sexKzJJ9xTBo3VyIo9Ouhd0iRjU+4czMXFdP6WeNBRy9RmaH/A2dYAypM?=
 =?us-ascii?Q?fOCCV7IPuAl2PtlephlSDrCptjjx26YbX8TTwC3ALetWdEg1shw3mKaNAIQG?=
 =?us-ascii?Q?JpNqD7cM7BlG06mVM9Nzv8DhHs39KYdBlWcHJxJrc/Yv/hEPk9MNTkfjSN01?=
 =?us-ascii?Q?jMgivcxyjLGoq1O/f+VAte4LI5p9+GzEnD7XLxtVjR58HlVIHn248A/axc7p?=
 =?us-ascii?Q?IFolwPCMd+YtmCNjH9WLjr6tRXhq9vNyj0d89KcmoEvWx/SBjWfLV9cvbgpJ?=
 =?us-ascii?Q?PStHteAbl0tpd0WIzIDFqReW3UT/IlrtCn7UCDd2ziHvUxTfa4asNM+Ll0pY?=
 =?us-ascii?Q?b2VFaKuL3nIjSAD3dXNlezd9Yn7tRWWsS+amDKlwJlS8H2PIMAjg7VRHvTII?=
 =?us-ascii?Q?8oSMC+ulZiApemoDjBrtuNwOrPAdOFn605eJPJworNKSMAMGbduTNsd2o8cb?=
 =?us-ascii?Q?MuK+VE1doqRaOr1gl2TwVijB7mN5NkUeSlVoHUe/T4izuSlGWPK/cWt6xldt?=
 =?us-ascii?Q?XmLs/PDPrXej9zEESyLp3rEqZJoD54BXNctv4RMrGAyaf7/MMGfPS+FYUtx8?=
 =?us-ascii?Q?rqwQYAncRSC4GykEZiwVcBAG6BK5hHi/om4RMkJEYJJc3/V7+rg5vW/NWK0i?=
 =?us-ascii?Q?UOxlFgNeYaf8dnyL/TgQq716XdlB+/AUIUjLiz4OrbCSUZOf5bRRtPntgzc3?=
 =?us-ascii?Q?PgLgAxvIfJhedsfvoGDK+NZ1Tj0PnNIgTfJZ2jfA19/9QSvvcm34x0xzYNfS?=
 =?us-ascii?Q?qmKEJmW7c619DJZdRvRC/UQSqbcqaFATXHuJwGaARRpiL3PdVlw+z+QHOMWm?=
 =?us-ascii?Q?tXTcteWlOdYESf5kcU3/CW3Y6m6RVg9dhlAxByhF31p1pP4I6FnnSyyBXhqk?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9222b9-1455-4476-74bc-08de3012d15d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 13:17:31.5335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JemaC0EIiiUCnaBL9EPw7n7BkVzeEF+L7Cl28RSDR63cIECtVCKLAu0Ue7OjjGoB3bcwjqmzaXqi5LD2o5Lxyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12034

From: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>

Since the introduction of HSR_PT_INTERLINK in commit 5055cccfc2d1 ("net:
hsr: Provide RedBox support (HSR-SAN)"), we see that different port
types require different settings for hardware offload, which was not the
case before when we only had HSR_PT_SLAVE_A and HSR_PT_SLAVE_B. But
there is currently no way to know which port is which type, so create
the hsr_get_port_type() API function and export it.

When hsr_get_port_type() is called from the device driver, the port can
must be found in the HSR port list. An important use case is for this
function to work from offloading drivers' NETDEV_CHANGEUPPER handler,
which is triggered by hsr_portdev_setup() -> netdev_master_upper_dev_link().
Therefore, we need to move the addition of the hsr_port to the HSR port
list prior to calling hsr_portdev_setup(). This makes the error
restoration path also more similar to hsr_del_port(), where
kfree_rcu(port) is already used.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Lukasz Majewski <lukma@denx.de>
Signed-off-by: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 include/linux/if_hsr.h |  9 +++++++++
 net/hsr/hsr_device.c   | 20 ++++++++++++++++++++
 net/hsr/hsr_slave.c    |  7 ++++---
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/include/linux/if_hsr.h b/include/linux/if_hsr.h
index d7941fd88032..f4cf2dd36d19 100644
--- a/include/linux/if_hsr.h
+++ b/include/linux/if_hsr.h
@@ -43,6 +43,8 @@ extern bool is_hsr_master(struct net_device *dev);
 extern int hsr_get_version(struct net_device *dev, enum hsr_version *ver);
 struct net_device *hsr_get_port_ndev(struct net_device *ndev,
 				     enum hsr_port_type pt);
+int hsr_get_port_type(struct net_device *hsr_dev, struct net_device *dev,
+		      enum hsr_port_type *type);
 #else
 static inline bool is_hsr_master(struct net_device *dev)
 {
@@ -59,6 +61,13 @@ static inline struct net_device *hsr_get_port_ndev(struct net_device *ndev,
 {
 	return ERR_PTR(-EINVAL);
 }
+
+static inline int hsr_get_port_type(struct net_device *hsr_dev,
+				    struct net_device *dev,
+				    enum hsr_port_type *type)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_HSR */
 
 #endif /*_LINUX_IF_HSR_H_*/
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 492cbc78ab75..d1bfc49b5f01 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -690,6 +690,26 @@ struct net_device *hsr_get_port_ndev(struct net_device *ndev,
 }
 EXPORT_SYMBOL(hsr_get_port_ndev);
 
+int hsr_get_port_type(struct net_device *hsr_dev, struct net_device *dev,
+		      enum hsr_port_type *type)
+{
+	struct hsr_priv *hsr = netdev_priv(hsr_dev);
+	struct hsr_port *port;
+
+	rcu_read_lock();
+	hsr_for_each_port(hsr, port) {
+		if (port->dev == dev) {
+			*type = port->type;
+			rcu_read_unlock();
+			return 0;
+		}
+	}
+	rcu_read_unlock();
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(hsr_get_port_type);
+
 /* Default multicast address for HSR Supervision frames */
 static const unsigned char def_multicast_addr[ETH_ALEN] __aligned(2) = {
 	0x01, 0x15, 0x4e, 0x00, 0x01, 0x00
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index 8177ac6c2d26..afe06ba00ea4 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -207,14 +207,14 @@ int hsr_add_port(struct hsr_priv *hsr, struct net_device *dev,
 	port->type = type;
 	ether_addr_copy(port->original_macaddress, dev->dev_addr);
 
+	list_add_tail_rcu(&port->port_list, &hsr->ports);
+
 	if (type != HSR_PT_MASTER) {
 		res = hsr_portdev_setup(hsr, dev, port, extack);
 		if (res)
 			goto fail_dev_setup;
 	}
 
-	list_add_tail_rcu(&port->port_list, &hsr->ports);
-
 	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
 	netdev_update_features(master->dev);
 	dev_set_mtu(master->dev, hsr_get_max_mtu(hsr));
@@ -222,7 +222,8 @@ int hsr_add_port(struct hsr_priv *hsr, struct net_device *dev,
 	return 0;
 
 fail_dev_setup:
-	kfree(port);
+	list_del_rcu(&port->port_list);
+	kfree_rcu(port, rcu);
 	return res;
 }
 
-- 
2.34.1


