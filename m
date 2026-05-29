Return-Path: <netdev+bounces-292948-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEP6A036GGqvpQgAu9opvQ
	(envelope-from <netdev+bounces-292948-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 04:30:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 802775FC64D
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 04:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E40F3028675
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 02:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA4D284662;
	Fri, 29 May 2026 02:22:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2097.outbound.protection.partner.outlook.cn [139.219.17.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857AD15B998;
	Fri, 29 May 2026 02:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780021325; cv=fail; b=na81KC2DfKlokolr3oT27OI1Q+H6nSEN1VhZCIII7n/EOqR5MoGCdUQCUmL06FYnCLpvPjoC94FTgozD3fbsaoRjmxmIvHtv1W5b3dIXDGTn+I41rYYJvk56/v+TlnxmDNaVtSt9wtGnHB00TDVjAcI7jzoKPpOTXrVsbzyaJgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780021325; c=relaxed/simple;
	bh=dsp5VdOcjNN2ezsiiAItx1k7tJLlZCQiZrcx/yN9zpA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lV5nMgdllf+pF2IG0hwOsfi3legsBFkDHkjAyHDUgYKGyh4Yds18Iso8RMnVWtIaeEhrR4yPpj6CQjW0yrY7bhmyMYHVYr8+oTPeqoeJQI1TZirLR7egTbTC1jVnocgyxiZBLuaUWOArgqBDH8hLV3l8S129UqAOILLpCd3Q4Xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBdGAEljRb/gb/9/W/m+R8I61Qk2ZvguljowFCm5vukCNcRThQ7fuW8xW4PazVoJ1Gwa9ifxhtqMjcBg+q6ZhDgUL2ultHu1lxpCTQpoN0UiQpWZ2nc9PKdeyoZwS/PvHqHDXTVKZAXUktnDhe6mPEF//5IpHhthDFbW0T4wie9sIn06pSCbbgDq9Zppuiy3tIn9y4pWcccXieNbVwEKwktZ7/08HCwCmr/9Z/i6EW1olBQ91q4/UsY8EnetL1NXcQ8Nb3zb6BURKl01181rWJzN3K/azkiSDE8yATLiwtNy7nYa2WGrh6zRJ7spori1UPTYNndg0WG0hYHX924cMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2j34+WJaL3O+8Z1pRcoXqIcirxwJgbAln/9pzJzF3mg=;
 b=hB+3LvDJnvvTpVpr113TAetsAjkaANcpWE4FSlM/fQ5FCByy+ljSw7LCtLpWgqHqgJK5UqLxZeQH7gt5btjyyMEKL1JiN8b2nfYCj6qLr4wXpck6mcV4vIKAOold+K/XHfEwDvvbrDDES01UHCoaEKiO4LmhpxAs6UzgJbyzeUj+Rk2jB/IrIvlPBUUGdsMLNATqN8WLtOpd0ZCRPGwxEAzVEqkyZgImKqwNU48yT5l5oTupDezNlzoH3Us/v3OR9AgDTcWx9krQCzjwiB3qQVvOcKNbN61hIvyBUAMd/5rQ6JyaA+E8/No3yzw5Fi6puz+kejZxMIBygy1cFJagAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0862.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 02:05:38 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%3])
 with mapi id 15.20.9891.021; Fri, 29 May 2026 02:05:38 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Frank <Frank.Sae@motor-comm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v5 0/3] Add motorcomm 8531s set ds func and 8522 driver
Date: Fri, 29 May 2026 10:05:27 +0800
Message-Id: <20260529020530.16856-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0017.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::6) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0862:EE_
X-MS-Office365-Filtering-Correlation-Id: 259d6761-9609-4084-d0f7-08debd26c756
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|52116014|376014|38350700014|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ZIxFehEuwNgHxAcWDUtMzIz/z/nS2v9nUO+6A8XirpwhivlC6EBGfmdeRlczFeA0yVysYsSXHTg8xaexmzQpltc4GwJa/mZ/bUBe8YyjaypCnqs5F2h+sQYNf2atCIFoKqlTsSSRB+0c/8DOqgJj6bwU1wEsnL3T/LfO/o9+AH51/p9M7CU9TbeLhdl5k4DM0hV1A6V0FLO4/OgNVDwAhLt2Uaa0Z/tG/cXBj79F1ylsdS01/7cd2jYKUh0Mjb8HmHMhwJo1FycCbN4tqLP0xdBdYGmV2xjwV8D28mz88tM8AjXLr/hCH+KPRXvfg6/20HmefGTB4oXRVhXQqE3YIFrVjQSFzng1SOsmXqNVouX7Ro/U88k1lgmoIBIybFFClgJ1/jlEoKWd3FmrCbGmJzeU60M6FpnsjCoRjIl25dKAfQ1IMfECBKxJswJPbxRntP445DJ+rkLo5zY+0Jtber3buLC3bYoE/OT5R2lCwbWw/Uw0kEBFOb2vwos40D8IofYNflwiCd3k84pjBEMc6hqMjFv5B65E2axSW1X1RdXMN8XFeXEuQtURTCcXrcVE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(52116014)(376014)(38350700014)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E/SaNY7RvGfRDKk0JFvaZI3dN3cfpcRAiGAPGlxtFtmFhLpxvE/zCGO3ZcBg?=
 =?us-ascii?Q?fGuxHOlBIEBAgNTjOgAlT8WE3scDiOVWNPk/8D1LBDAum7uubtDdAdHzn6Ih?=
 =?us-ascii?Q?sKNkpm5qVDcwvJwHLZb3QPwbD4qOrp4PEyXgJ8cjY1KF++Ne8LC3WYf6xoqw?=
 =?us-ascii?Q?67elq0IG9ppBqOTgPLojR/PmoPZ/ejJJB7ZQlIQsMenGrXTgX0qoKzgTD6gs?=
 =?us-ascii?Q?oDI0vtXvx5hLcOvD+5z0ArZae8Y5Jyepm/7X5ykaNU1yiGJ8oY1t+qoWkR5s?=
 =?us-ascii?Q?uOFFhQKPwFhnRVPgGOSU/DyteKgDvkIujVw/c9MYjhhJC2ndpH5Jj/rpLJsP?=
 =?us-ascii?Q?SLlz8LAwEE84CYNnUWxR2DNCf3zjSD4HZMrSFXwKeZtK6l2ugUq/0+8JCCIu?=
 =?us-ascii?Q?SW9Om1siSLdL+npl6hMTrKgwXOaI4CtvlcCC1d3erKsVAD+1nedVBIditduY?=
 =?us-ascii?Q?p+p1B44NFwjSghgqE3W89YUZzyPql+82xP2sQDk3Q4hO7bxcjPfFJz1Hwees?=
 =?us-ascii?Q?vtUAtCLSCCxdMezSTp/RNeUw1e9Pb59zt7W1+9QlkbBvs7KnCV2Nys/ob/Nt?=
 =?us-ascii?Q?4UBCOuNrvQTqlrh3egH33zkcH4GqP/W7n/Q8F0ObYl+rCZwbWzRH++EUaWFz?=
 =?us-ascii?Q?9j7lloVtk9dL9+xgpDu3ITFnnnZaL9BtUsaAbXyNV4AQBwymTz3qgRlvqtrJ?=
 =?us-ascii?Q?RZXpAz+CaxNVj6Gg1fYhmI2SPlXRwgv6/6ILjhHLEX3njGaldnBR3gFjgXar?=
 =?us-ascii?Q?HkcMQjHu1PYCPn7fJVdafrNKJ3OC8iwGSz7lwpnB8YLJj30dNNyFrhJRhBxM?=
 =?us-ascii?Q?VKRSRF9dvA7bvMCzUU+ZY8m0Ks3iMWXihx4lnxnqMkq8yPLfYfinEMgze7OZ?=
 =?us-ascii?Q?gGeTlOeK/OuxwXpb+PYAm1dFdGYPCKktZBVFLsKDA9QGVTcEAnGGK53HskNb?=
 =?us-ascii?Q?EnZOJCw2M9+siUwrLQyEbF/la62XCnoxJeQHPHZsRJVhmxiAi2PdDYRtq02j?=
 =?us-ascii?Q?QcSrI78JQXzshtxX+jFYFb1dZjr/MVHvsRSesNB5qT3lxZHLORHcx5cqPvCL?=
 =?us-ascii?Q?He7bYno8XR9IPX5xVHzIYY9c/9KV2dKU3yiK2scAW49vUmwy1EuBExQmZUTH?=
 =?us-ascii?Q?dpXE+iVNlQfhdq1P73ygj60FaSQ/IjKIP69De9n/Q67xQnNAEsoglK454QCQ?=
 =?us-ascii?Q?AH7PSKwaUf5/u2Q+qjSV+HZZiPgC/wnXfJBIeePa2CQzSRl1rdpB34qmC2hZ?=
 =?us-ascii?Q?qvJhCQZypz+828jMBjlJTjf1rq9Fj6gX2nIm5WYwp7kZG4UENrJ/mYRzS4iq?=
 =?us-ascii?Q?BnKTJr10QbRQRSbtO8M+oFxkxl1C1EopukVhFm9HaxL+xdO8Z5WTZX3b/Uld?=
 =?us-ascii?Q?ZI5Az44HiiEFQUehI+fHf/tVwYQRKZdYGRaq6a56wK3dh8aJo8+MuFHTN2Nm?=
 =?us-ascii?Q?kQNP2Reon1L7/CA8RRwej43SFbdhAdWLIhKxwk8X+VumnHLWVu3fKliruYcu?=
 =?us-ascii?Q?QqoQuxc3loI2H5uwY23ccEhs4mMhVB+eI+ck3ppxm8bQDHlzrvI65/4+vIcl?=
 =?us-ascii?Q?nRyMYcFhHkvfkip6hvgiVyW+GAZwxW5tGXHTbzBBui+Fvz2EllAOdF2fCwDW?=
 =?us-ascii?Q?Mva0xYghRJiW2RqLzEQaXLRhI5lIWrNsYVPR2SsJP4dI+Ce9vCMoxKv31M8A?=
 =?us-ascii?Q?EQ19mkXymJypj+W+DYQ723BJL3TaO9/6OnGLwwC6+A+DsthYjetHhggHhMMz?=
 =?us-ascii?Q?OJ/8VJ9+H2xAUKg68iQmGV/ljlp1IdU=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 259d6761-9609-4084-d0f7-08debd26c756
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 02:05:38.5436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAUXS2JCmsLUZsz39z3oNl6EYQlxQ88zXEnmMQtqvz4jK/o+BdVGutB6kUGJ3UnnlIurXIBugao/I9+G0dc6+QF0mdoxgmSYSchXLRzU5PE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0862
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	TAGGED_FROM(0.00)[bounces-292948-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[motor-comm.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.939];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 802775FC64D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch is for Starfive JHB100 EVB board. JHB100  contain
1 RGMII/RMII and 1 RMII synopsys GMAC cores. In the EVB board, RGMII
interface connect with YT8531s Ethernet PHY. RMII interface connect
with YT8522 ethernet PHY. So patch 1-2 is for RGMII interface
patch 3 is RMII is for RMII interface.

JHB100 is a Starfive new RISC-V SoC for datacenter BMC (BaseBoard
Managent Controller). Similar with Aspeed 27x0.

The JHB100 minimal system upstream is in progress:
https://patchwork.kernel.org/project/linux-riscv/cover/20260508053632.818548-1-changhuang.liang@starfivetech.com/

The patch base net-next (base commit list below)

previous commit
v1: https://patchwork.kernel.org/project/netdevbpf/cover/20260415092654.64907-1-minda.chen@starfivetech.com/
v2:https://patchwork.kernel.org/project/netdevbpf/cover/20260422083255.29692-1-minda.chen@starfivetech.com/
v3:
https://patchwork.kernel.org/project/netdevbpf/cover/20260508094522.3952-1-minda.chen@starfivetech.com/
v4:https://patchwork.kernel.org/project/netdevbpf/cover/20260520101310.128969-1-minda.chen@starfivetech.com/

The change list:
v5:
1. patch1 and patch3 add review tag
2. patch2 using phydev_id_compare()
v4:
1. Add review tag
2. patch 2 check interface first and Add the reason of checking
PHY ID in commit message.
v3:
1. change some commit message.
v2:
1. patch1 move mdio lock out from  yt8531_set_ds().
2. patch2 changed to phy_interface_is_rgmii().

Minda Chen (3):
  net: phy: motorcomm: move mdio lock out from yt8531_set_ds()
  net: motorcomm: phy: set drive strength in YT8531s RGMII
  net: phy: motorcomm: Add YT8522 100M RMII PHY support


 drivers/net/phy/motorcomm.c | 77 ++++++++++++++++++++++++++++++++-----
 1 file changed, 67 insertions(+), 10 deletions(-)


base-commit: 8415598365503ced2e3d019491b0a2756c85c494
-- 
2.17.1


