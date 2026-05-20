Return-Path: <netdev+bounces-289870-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPAKM1OKDWpKywUAu9opvQ
	(envelope-from <netdev+bounces-289870-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:17:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0F558B998
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C731630504FB
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 10:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBE53D6CDC;
	Wed, 20 May 2026 10:13:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2106.outbound.protection.partner.outlook.cn [139.219.146.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56C03D4107;
	Wed, 20 May 2026 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779272014; cv=fail; b=pGGowQcPE1ZO/YspzEvcFO9jyi+PmWiQ1QLJKzoZvr5LHeEI7O84qUpHUwwyMFNGhm4lrT0Bpx5CE5KSZJwznabjN3fMYa3fZHXXM8EWXjJl/+lkrGc0QLHqfG8RSncJOY8o9CXHjGD90zoDfOH3cexFQh/UeSDglItObtWs65w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779272014; c=relaxed/simple;
	bh=hp3EbwKyP7E93XAKXmGhp7fqVq5zprOn6uHyM/g8q3E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=P7PfREK/cvVDeeC3NkmvDgfWCmx9Yc8OWjmvkW9Egek+BENPV+f0WQN6wZe0pEXzGhJkEF4SMqa/lEsaDVO+ZTMXYE6s1PQ+3OCJinXxikPfCXXe7FGsILTjxeT7wP7rwBr3znLWMBsLXjohf/GYfD2X6uUkm6A/u9JuPa+3h3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wsto0pqDSBw8URnAycmcFMA5TZHpUunlnJ3TpfRUDugN1DLhAV2e5ypVfH0H9f6TgXcZnPgIH6TwN80lsvzm0irtYW/797FG9rtxvfE/ofYnb+NpM56GI5cxfKE+WsgZjk1SMVR5aumLm4j9fnmnUJlv6BUuimPUjwTO4+MY6AEquqaej2ELYcTk1pQaJjm065SiYMwlBdmU8HjoS1beKiqxKxzbdrAZStmbZdZffPUTZ298sebk/w0q/k1fK+gMOcVqWIIctQfVMHynHSraw5o4bXEVFYf4r5++nyQXOtNzxhKVumNpvCEjASr6jYYSE6H3o+JBMqCzrz1nKfVbJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6B9EZ2p2OeXcmn5+W6LEgKiz7Lkwg38k7LGg/5UUaA=;
 b=L21DZEKjEb8iNf0O8SsK3qHTFSBD2KDCh2DPE31QtNSP/lTDukwWa2WZ3Gu5vWEiZ9BMdrEdD+GKzlUH5cWJPy1Q9bvz/edhKzq12RNoEgrf9pj8ZcGSddZw2Ce2s0d/wsZ8SFkthQXtdvd9SCR5M1mwkVq28QuDyvXb/KYz+Zz2RfpGcn0mpC5H1O0o4q5G7JTRqbAZmOj8lYaSSWsCyxbRlFRDSR108gZznjiImsoOYcKkFlY7V+2I9nX8P3LiPqjbiZuSW/lwwd9TtnUvlhzY8pP7leFIjwnhlBrkr9POJOrAlNSPPwibmJ3frc8sW5eL1C7m0soEXB01A3i/GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0637.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Wed, 20 May
 2026 10:13:19 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%3])
 with mapi id 15.20.9891.021; Wed, 20 May 2026 10:13:19 +0000
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
Subject: [net-next v4 0/3] Add motorcomm 8531s set ds func and 8522 driver
Date: Wed, 20 May 2026 18:13:07 +0800
Message-Id: <20260520101310.128969-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::22) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0637:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f4a3295-eb3d-4aaf-e699-08deb6586a4c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	u0+A+qSbCZ4BVjo2chTwDRXPpkd478i7tWEF1tAFSj2wiJ2eanWj3GrsBmoA1ohpfC+vpeGVneuPn5scnRETQHtrb50SPCo0erR2r5AtcGsQm5V6PdOZYbqVCITLegjjfVUImeHNGfW3BhvKVvGvphPcAOitStprTq4NkRyHudUytAxSNiy9dUkxakOQ58LhpQynoQb1NQwXkdXozSVAtLZmKH6Lx+A6PvISQuyGk0z6400SkCzNxs8KTzgVV21Ilb4csUOc2giPL0q8RgHpz6HwV/ZZUL+TJLQE34uKHYr+Cr9WviEUOc2vbBqAyX+sct6LsO3zpInjEOCJ5ccWpQRhZ7yYYysWK0ufE/gkXxLI9S6sOJX8ty3/60JiMGZJ4xQR9VUd3MFOZxgNLOr/UxjAD79FiIWih2XX9RS/WCAWuCIkT/L+CRQ9hT+n9h7HSDWwSuY+lcj3tiWwyeSLNWZD6K9lpWHVKcaZ/TKg9OX8MGhZHrI34xnczdm2sUrvXf1z2Ed7RUbxw3cUovZA/M7y1TTsn1SRJQhYz/01ILYYNd9LNURLNSvSBs8+pdGn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R7haXJQ7zoWn5hoZGS41pXOpwy1mR+HPekA0uEtuh7GlSwXQNdJm0yO/wTm5?=
 =?us-ascii?Q?5aN60/Yp4QeKCoKCXeJGYRgMxJIcMvEOwST+KIAZcyZPqigx53ZFYiuiU5VF?=
 =?us-ascii?Q?Wa/ZCwBdc1V30t8mb/0Je9lxcfxgKBH6tlurhKWM4y6ruYoNoNj9xGrq5VXr?=
 =?us-ascii?Q?H3AF7li1RwMwbxgd7xbsIjL7ChImQgwcf28drJ0A8vJE2Wa553fs3rJ7n1Ae?=
 =?us-ascii?Q?b7xEmOUa1SlH5v2VDtZLLMswdsh8Lx+sjH39NLUmx7SYDPCL4dFBRbE8Ve3B?=
 =?us-ascii?Q?qqML9Fdo0ADR5MXuziJtg8Pm4Tn5nTn9YiT7FW5SaTQ+bOK4TLWvkmavs8Y6?=
 =?us-ascii?Q?MglrJ/gO9BQb5cVXJ3eWLc09bhhU5tSWQMUcygeS3JL7gE0zBeqWQYo8n0zN?=
 =?us-ascii?Q?dMowCY/oDaJ7Ur4wpJRiLHxy2szuBiijm3TyXBrNKnAX9H8gmSx9tdgg2KxF?=
 =?us-ascii?Q?YVolDYuhjvM10JAmqc7pixSHw2gxznlxtSFrpRYt+4U2LczY1FW/a5CiRAvr?=
 =?us-ascii?Q?DxenrZULDsUDkn4r1uwMInNsz8FTm4teZhZ7//xJBjP6O/4FkvCWUz982NB7?=
 =?us-ascii?Q?490IRo43ypaH2ms5Z36jE5ErriNziZ0TmokXE7gACJsV3OmQYGWSQZJ6oIeD?=
 =?us-ascii?Q?8ONL+q01FFVMvtn+zrlgQJQEdNMcCmz1BGj59PatGM4/xAANvDlFHVabYXuM?=
 =?us-ascii?Q?sw2fdQZXL91k78X/GMDGe/M6YQnb4Hp9tht5Vmj8pYX7DuXs/XqjJRsZeNa/?=
 =?us-ascii?Q?fKrqjIZJcg48e2FXbJQjUaxskHftPEWgUHlfG9m63lptC6AgyIfuOQHggJO1?=
 =?us-ascii?Q?XP7Ov/KER/3Mx15qS8oasdIY8K8ZPNoI6XYuATJOp9Ck3zuMU9f5uNi6jbDZ?=
 =?us-ascii?Q?ym03lWH9+MnDUJnQoaMxOxDLvnga3xj37Q0tSE1SVljaiOIsmgd3aSG7DOCe?=
 =?us-ascii?Q?yI1TRVHZfuZuKMf3Hh/SHz2gZPnKdR7vEWuZQ1vcbhRFhcsp/xEYWFr5tv47?=
 =?us-ascii?Q?ztKhjLX6Rx0Qvo+dokn9wuxXWjBCK+xswEiNdSk9dsEVzwiuobh0E2OlWhBI?=
 =?us-ascii?Q?VgVbJstBSkMYfn1mcKyge2cKlzxKpGqeJDRrz5ojUzzqrfD8XNyK1AlZagvR?=
 =?us-ascii?Q?0UzwZbACsIABKmfDCTBaOKnw3+QCFtwxRiyEkIyLsgDHkLzPSdkBzNULBQDl?=
 =?us-ascii?Q?vFJFs+DXelc45FX8MWO7K9Bh6/qMQccKS6+Lmisbbmw4dDu6UyzKVK7evmr9?=
 =?us-ascii?Q?RhKqLn05mrs7jWagP6Uq+svYXdCCjJ1sb6u3kQee1QUyfIE3Ibbl2t9f9gDa?=
 =?us-ascii?Q?K7imhkeHLWdVJYlZq8+mQiDhtvavRMD25JmT2OCwTLr38ZWpKaC2RqDOOMia?=
 =?us-ascii?Q?ITHaw/2KHfrEzolAcQW5/K2tDF5FNWZyqEECqEWrb7bqcwiMTkIxG93FFNQo?=
 =?us-ascii?Q?plu2ngG/0iaZUC3xZdsSwK1NgmPBrnqgEjxFHeSSzYVmtmZ7P8086GzZft6L?=
 =?us-ascii?Q?KTPJ5G0vFd4dlXEssE+5Ug08umD1PMefbPJPbnfpSnGDmEMm5WQz7G4GbqiA?=
 =?us-ascii?Q?OwXWRmjNnC24d1Z2V2Qk1tR2odApVX07CL88AqzQlmVO7A6XATBbdJPty9yn?=
 =?us-ascii?Q?k7JbOmctQWTgDWIQihnVJPl3MZuHpYKHSdb4NTZyUd3nQA2HqxCr0UwPn4UN?=
 =?us-ascii?Q?qfx3UGk7ZizBZ2ZG8x9zdLJxEC9A1fF+BiQDjTrOjZQ2MtZ30EjN/Ju+7Vdp?=
 =?us-ascii?Q?gvJH5sQA6ahre1GUSaaNUyTwoK+wq8o=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4a3295-eb3d-4aaf-e699-08deb6586a4c
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 10:13:19.1443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZ8IULje4D36B7lkJn0lwralLFcGfgX5FuS1yLA/yRlLxvqbguh9kZgweoXaggpjIsh3B/SFzNO+/e3DI/pDjO95yYf/EBETJ/uq6Un0sGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0637
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,meta];
	TAGGED_FROM(0.00)[bounces-289870-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[motor-comm.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CC0F558B998
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

The change list:
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


base-commit: bf53bf33206137c2337bd8aacf0ef4c348b97a36
-- 
2.17.1


