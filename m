Return-Path: <netdev+bounces-258282-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMZXI91/jGl9pwAAu9opvQ
	(envelope-from <netdev+bounces-258282-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 14:10:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5886E124A83
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 14:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A40B43004064
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 13:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC8A32D7C7;
	Wed, 11 Feb 2026 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MazdfcLo"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010048.outbound.protection.outlook.com [52.101.56.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DE2352938;
	Wed, 11 Feb 2026 13:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770815448; cv=fail; b=pipCGx3dteStAQZn3rlhN/wfzQ1YCKS7Jvs6tvQ+D/8FY9+oR20/AxLEcB7nBAcSez71bEZ7+E7cMwHrhKWdYOpgtpAPUHPlXADQaijA9bJ5JnxH7OwvDG4Kb3vG2C2F4a1jm1cLvGDZ4iFg7Waijsw/NaUj5PlYRtyci5WCQ/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770815448; c=relaxed/simple;
	bh=jhcVgRP+S/NPKaZlkgni+3XjE95pDHo+0+Y3r9C93WI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oI9IWmgiIHni1LbNDVhUqOsojxRTDX7o0LoixRr0HmDi6zjRk/b8wdqAxw6yYqQ5FZ+sIokApL2oqmaMH3HYFiPGbyVSfCfaGkcy/H9BpLijCqJkaweVn76boFBjkGPGUIhuxsbCKKNElpNJOmqRF+9wsqk38uzYw6ARAvI3XBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MazdfcLo; arc=fail smtp.client-ip=52.101.56.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTylXsWVkkd1pAJnEXRHY/kEzFs9mqD32e2IGEqCZmEGyRX/3S0wNZLXeLfRFtYNGrbMPsyNTHrnqZzh3rFwgM+L5WdC9eX0TBioxqPCwT2e0AMq6RRD2ARFY2jZicLh2ouzKQp7yYfYsr5+KvxCbsiPR1uG5mPamMBLmdO8BcVV3Maq3UsJupEChLyfzIyvU87Ve7jwoWM9FmeTX9di1rlaKfIoykHp4TzBlpgJWWHQA4mImNcY8vbjSOHiGq7mnDj4JxW7QBbCtiTRP+aXER4oAEojq4GeLp+hGw29YtPZXrzf8fCmohWs5VyVHpSkBkKve3eKtud4kV5fAONQtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pp1nyxjUE8lspxjByLmm9P9qbGwAKfR0jegPC2BJazk=;
 b=JfbH4o+8c9q50DWsjUu6BSN3Ioh6YKiAm82GNPnq+IRNDZoRkV+zb0nR27jkzQ6GpUPXhikQ8jBYa1gdWoFBMwgWZNEA2dobI3id7vy5+qukz6h4z27eAOKOy7+O1AjEU8/Ow42eGr8/PgaTG4LcUzbCKOeKDrQD0GFpnQ/wOnLfcKI5m9mbkuHKwf3mVfg146049fXbLItjWxp8JdU0TD//rZcTQtCiY1XAySs+VbO7W03M03hUZA1eW0iZBC7+QavU471W2q9l0R73qcp3YxckPiuBoGM7ZF6lkR1e3kdDep3me8Q1e1UQCN17qgYZTRKIj+YsZONjlsr0tHKYcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=redhat.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pp1nyxjUE8lspxjByLmm9P9qbGwAKfR0jegPC2BJazk=;
 b=MazdfcLoWyqAWPjIcz0KoAqdwCeSQj0EUWiQ0OoTRWGpGQHohfvUrMLzdDABPw9ugCVGr6H3wd5/F0OGZnOa7nk9kupJW6/uenTFFDu2YZETaNOjzu0sO9gjboDsg044Zswe1pazMPdvyDNDTc7X1Iyb1mGmW0lIJJ1hxlPBQRA=
Received: from MN2PR16CA0049.namprd16.prod.outlook.com (2603:10b6:208:234::18)
 by PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Wed, 11 Feb
 2026 13:10:42 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::2c) by MN2PR16CA0049.outlook.office365.com
 (2603:10b6:208:234::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Wed,
 11 Feb 2026 13:10:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 13:10:40 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 07:10:37 -0600
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 07:10:37 -0600
Received: from fllvem-mr07.itg.ti.com (10.64.41.89) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Feb 2026 07:10:37 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvem-mr07.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61BDAb512791083;
	Wed, 11 Feb 2026 07:10:37 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 61BDAaYr014720;
	Wed, 11 Feb 2026 07:10:37 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <linux@armlinux.org.uk>, <hkallweit1@gmail.com>,
	<andrew@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>,
	<danishanwar@ti.com>, <m-malladi@ti.com>
Subject: [PATCH net] net: phy: dp83869: Set auto mdix bit for forced 100Base-Tx mode
Date: Wed, 11 Feb 2026 18:40:32 +0530
Message-ID: <20260211131033.2525617-1-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|PH0PR10MB5777:EE_
X-MS-Office365-Filtering-Correlation-Id: fa80b505-1f90-4754-92d8-08de696ef4cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2NHhpt2iigdApg4JT3UYyFgHkHNVC0CgsymLQispLwPTC8mod6900PUr5zi/?=
 =?us-ascii?Q?6gaQDpIyB0M45Z7GgBY0SflLKhZW5f4WDiyOE+TE9jMll2X8QyCCKhlI6ifk?=
 =?us-ascii?Q?mGGSmTIVijVidIrKkqDih8InIGcfDQ6m69jPP7isUAaFYJEZ/SHrvVIDxrwT?=
 =?us-ascii?Q?91x0sUvkCK+XMcK9NZaEzSCLdCN2oIGweulv+aqFW+YK2yD0c+JLBDN+onon?=
 =?us-ascii?Q?BuLSvTOWuTY9CiAiV7JxZeZ1flUqNTpjIpDGD4gwtkxiY+qKIehXSEKUuwGD?=
 =?us-ascii?Q?tzCK2WB8Vju1XhKBLy8OOdG8CjJeE/W/A1UXQwPmbcIo4LiD7sQTwKtis/X+?=
 =?us-ascii?Q?ElP9alphOByHxFbvJ7cbllW4cGymQCSYSav0OLsZdH9U0t+RkuLkgYVllr6r?=
 =?us-ascii?Q?cLvLSJF2cAY1+M4DrrGY2wkgn9BpCjfvKE3rC30d7z6dFUnYCbDXVFaD/47R?=
 =?us-ascii?Q?MJNdmTjSCsPG4itNVkP2I3Rl6aokDTOUHrlfGDiRzphHob/mEOZRDUBn69Md?=
 =?us-ascii?Q?46xH1pqXCpcCOsb0RiXPwlx4GGlHe/zGqVM8sHADVgHpS5B5ZOx2gn6RMlWL?=
 =?us-ascii?Q?ED04tfFbDKzarsLZ5qjoGGL4XQp7B685c5ASLfQ3nNc4uAayk6sphmsLiwAa?=
 =?us-ascii?Q?EZIIWvJyORu6ft+nNj27lqLjT85BrgjQt+JOlTO4EMWyM5BTCmm+8IL4hEdz?=
 =?us-ascii?Q?StyCC10DgQff9gaLOBdVV5Y/IHA8XuBD6neF8gq8qlriWQ3x2iha5KUrKhUZ?=
 =?us-ascii?Q?aXFHxCT/OPFrlLQb/O0W8ukICI+zkY9MMfg83onj6Anje8ZC2H9Z8/ynJ6Jm?=
 =?us-ascii?Q?KZ3ku/v/cUCtoxQ/S92HP+2571Mig5ct3eNTS4O6J/wmysI0ROu1UnVEpYif?=
 =?us-ascii?Q?zh6deFZlnL7GZ9++yjKNUJHbRfhV6Sam/yQDxLpLNK4DHVdi9eQEpI9ZHlZp?=
 =?us-ascii?Q?54PcyyFNY05FswAoZAwMRSybWOzG4GfRADKvc3JmUlh6x2vpMTLUPC4itKGF?=
 =?us-ascii?Q?oTDet8rb+gBOUMiCcyrB0Xzbppohi0tI5zuClS7EbeX7KVywWZQaboMmN5Sn?=
 =?us-ascii?Q?CzwM0Dc0Uq9K8Eems0UO2G9uh3XDUZOC33pOBCOE5pl3iLFjzE5b8gM1mhV+?=
 =?us-ascii?Q?IhtMPbA23EW1hLsyw1i8m1vQmn88NI/NcUoPvcbQH7AOs1FqaiX6vsiKIU2V?=
 =?us-ascii?Q?l15AQTYHW2Fx982RRe4tbajIKgl7vQ6Wp6q1ghwLWc43OEU5rMHE4G8vWRo+?=
 =?us-ascii?Q?c0UcphHCvOGbndmsSIdzptXP3vtGb44ZMTlek32ovhkN2ffmcsi5UQrojJj4?=
 =?us-ascii?Q?xW8aQKFFe3UNJ7YDjUJ6wG8pS9uD+bryrPj6rDDJhsUV3UddBmRv4bvKScXD?=
 =?us-ascii?Q?JkNHGS6gllN2QnMMWTl4M5424f3jpxOpzavzRTmVqgx+MLNqkURn09WpZX+T?=
 =?us-ascii?Q?GZV9WNkk2iXqs86bI0N8v7JBgxqTD/PEd5jl8d8SUxYJ580IcxPp+UnCCX6S?=
 =?us-ascii?Q?BWMARCfzCjxPpnTBqp4R1y/IgmXXidHc85T5S1L+iOA2jlP41BvSEgHx2MJy?=
 =?us-ascii?Q?8sO1peelxJ9t6Q9kvI1i3LBpj6jQlMBtQIfVq8HQdnKDp1ufBgAUYXAZASFu?=
 =?us-ascii?Q?U9SMnPtl6fn8+OVFb+hoCu4=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HPnbORAXPcBx8gCLSHbvuPYbwTdgTK28AEwrSkdFwn27PWaN61RpaGEEc/Tno44j7f3Bi2ijpywD9+G5LxPVfcuzycI6DXeVoio5hRQuyKncy7+tYPy3sZBoxmqtHLQt85w5NrSVg+KDfFrKqB7bwhRSsV3sM6RiNfMtX1LSQJ1yB5V757RSHv04E2exL7MTGeXSVSDfyuhhc0xoQt9f34WeYhH9o+Tj8iiAiCGe3qeT0EDU/rirPulAp3tYFK2Z1nbJRU+9Vxvl6MEngtanguJMJrAdhkxe0F+JzoJXbtw6km6ZWLsnnvaNLIcPHSeQC6Wng2foT2McVPa3SN+f73o4WOqcpFWcPM4TuaAm2OTqFVpHhQ+kA8v570B3ekB0Jl081fpp4HDQHHHMoUxra5zhooDmHoJhZUV1WHYXifw8/P3VkVwWR/XZIFKia45D
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 13:10:40.6370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa80b505-1f90-4754-92d8-08de696ef4cb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5777
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258282-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,kernel.org,google.com,davemloft.net,armlinux.org.uk,gmail.com,lunn.ch];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ti.com:mid,ti.com:dkim,ti.com:url,ti.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 5886E124A83
X-Rspamd-Action: no action

When using DP83869 in force 100Base-Tx mode, the PHY is required
to have robust Auto-MDIX feature enabled from register 1Eh.
Refer to 7.4.1.2 100BASE-TX section in the TRM [1] for more details.

[1]: https://www.ti.com/lit/ds/symlink/dp83869hm.pdf
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
 drivers/net/phy/dp83869.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index 1f381d7b13ff..70d759c45c6a 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -110,6 +110,7 @@
 
 /* CFG4 bits */
 #define DP83869_INT_OE	BIT(7)
+#define DP83869_CFG4_ENABLE_AUTO_MDIX_100FD	BIT(9)
 
 /* OP MODE */
 #define DP83869_OP_MODE_MII			BIT(5)
@@ -900,6 +901,23 @@ static int dp83869_phy_reset(struct phy_device *phydev)
 	return dp83869_config_init(phydev);
 }
 
+static void dp83869_link_change_notify(struct phy_device *phydev)
+{
+	int cfg4;
+
+	/* When using DP83869 in force 100Base-Tx mode, the PHY is required
+	 * to have robust Auto-MDIX feature enabled
+	 */
+	if (phydev->autoneg == AUTONEG_DISABLE &&
+	    phydev->speed == SPEED_100 &&
+	    phydev->duplex == DUPLEX_FULL) {
+		cfg4 = phy_read(phydev, DP83869_CFG4);
+		if (cfg4 >= 0) {
+			cfg4 |= DP83869_CFG4_ENABLE_AUTO_MDIX_100FD;
+			phy_write(phydev, DP83869_CFG4, cfg4);
+		}
+	}
+}
 
 #define DP83869_PHY_DRIVER(_id, _name)				\
 {								\
@@ -918,6 +936,7 @@ static int dp83869_phy_reset(struct phy_device *phydev)
 	.set_wol	= dp83869_set_wol,			\
 	.suspend	= genphy_suspend,			\
 	.resume		= genphy_resume,			\
+	.link_change_notify = dp83869_link_change_notify,	\
 }
 
 static struct phy_driver dp83869_driver[] = {

base-commit: e9a5073a98d940837cbb95e71eed1f28f48e7b30
-- 
2.43.0


