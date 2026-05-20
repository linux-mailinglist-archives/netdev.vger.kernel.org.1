Return-Path: <netdev+bounces-289783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IsuOl9YDWpuwQUAu9opvQ
	(envelope-from <netdev+bounces-289783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:44:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7B85884E0
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C854B3047EAD
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 06:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72905346E71;
	Wed, 20 May 2026 06:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fLqHTKId"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011070.outbound.protection.outlook.com [52.101.65.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B633469F6;
	Wed, 20 May 2026 06:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259344; cv=fail; b=Ka0pZ0bXqThPSFRnugsqEal8/xFntn+DRTSOTNnjAROppo2Sl8fbf26QNJtrWTDFOzGY0ALJKXVwcO+KUMs3L9ZKD88atGMRT02ah5rFW2+psuq7WPXIaQ3AofuzabYh9ZGhI1AfpDmxu8guMLnkJP03kmOlNA5E3KbJoU6GOJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259344; c=relaxed/simple;
	bh=iJ8xKL4NFfoO/Orzm2Q0Jk2wGmoB+Ky4soBomXdxBqY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u3D42v/l6KM+PCXUiowUlB+PJC9WDTyPhqNhruk3yfjGSAzkJwa06N/XQjo/ZEE0QGdB4A1wLumjrPrLaAaEc6DgREs/9sBdJgxqgu241wWaJKdPon8BAYLCdncRrpHvsBQHJwifFPcJTwYyeJ71SctgkRtkvoj/3ShASC8Jvvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fLqHTKId; arc=fail smtp.client-ip=52.101.65.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OcwMBRI6yPor+5yWzBC6b347k/GchsVRCM+T7yHgssV3aBIuhKQ3okUfofaDIUvZ/vj23r4Fugu537375u0FS0fRVqQxT+9QiGGHAG0ij18jy0RQzIs1uTJrZS23p/8xcpSnIsTKMRONIrJa7PsmorBV2K4/YjP/yG5/bfU5DdQOroy67D+SYPu6nx8yOoQL6G9bN9YIRL4no4gLO5TCG1xBDDQ7XASe0Fe5I59CadpQFqzoAtTABdQI418X0PajvF91HTcPH9D7gps4bK4sGUnXsGJNPHvSDX+XpNPcFtuGn+acDcbcDORYX2EdVXy2o7IkC79pvjIxmqZFJRFQwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yFm0BBztAIAy4lcNYSe3G4Bs+FN2/nw1n8cK/ubYrM=;
 b=C3QMGqoigJFNBg6Jx91I3Wb97axXMUt1o58Lw6PW1V23dx2rU9pYmQEgn+KZP7EZKKW+f0g30TdD33vZ503wXEvq4uPtEnFEP65SvQ1F31mi5CH6ayO0mGTtz06wR5UnLry6yFLbU7MP0v/Hq273yMnWx6k+bYz+p69pMIvvtMgGD4ZOZNd3PlCrBwO4do4K3Xg74c+QzOJvhqyYrLQYeyzDdqN/Y8qTvy+uDi73ZRwxwbrt8UxtUfJqqe9RotzLD3CV5BqwjFPkSJ8RPwvj6qKvJarjXPVTb2thg50/grPkS+j+LoJ2pGQhTH2J6fxIiXWXGi5aOg7BTmTKik17Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yFm0BBztAIAy4lcNYSe3G4Bs+FN2/nw1n8cK/ubYrM=;
 b=fLqHTKId5vJXoP4OoZVU08suZgDlJKQySMpeq1FsXA3nw8Qk4bQ5oJTNzxasyhKFZDXc5DpnRPk06JOJK3zdPu/FORnrASchN1ywaax6L8twdOXgP9K9c6HH58oV5QSHuh5foFxRi9o0kThfSsNWToinwWxz/kpmWpxFrOX9kqmVDUYWqnt65I/VnP/fZ/Vvgmt/km2szcTJnokgf962sPLQIQYNXvRQminUbTz9zVkjncuomFOhFo72xuIwahGZ2WEehT/vRSSWVnaG8iXZokwXezIfI0uUXwc59OiKTVr/LQjR38pL42PDRsi50IG/j5Xo8DsjIhG8mLJUgMUMaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by GV1PR04MB9104.eurprd04.prod.outlook.com (2603:10a6:150:23::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 06:42:19 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Wed, 20 May 2026
 06:42:19 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hramamurthy@google.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	catalin.horghidan@nxp.com
Subject: [PATCH v3 net 5/9] net: enetc: fix race condition in VF MAC address configuration
Date: Wed, 20 May 2026 14:44:17 +0800
Message-Id: <20260520064421.91569-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260520064421.91569-1-wei.fang@nxp.com>
References: <20260520064421.91569-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|GV1PR04MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e3d948-bec2-4bb7-013b-08deb63af068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|366016|22082099003|18002099003|56012099003|11063799006|3023799007|5023799004|38350700014;
X-Microsoft-Antispam-Message-Info:
	0bcqr2AchwqVVcdP86RqP4NPhL2l1iCkJKCLMa5xZg+ivFs0Ut9tZq0g74bk4yY9P//zwinKTDttafY7Un9NtVurSXGG/PJN9GGGHP4vI6fTYTndsyQmpmOgfZHY0MLd28Wuk4XturEJEETwwxwkhTXRrcNMiGEXEc0YMMPbFYkdpIFOH+XcEQuZIaXsLUfy5VFmau3tc1pFS+QupCRNeqlPNbYizW6vQ662HFTRmBtCRp9M5ZDvijHW75CXeXO3wrq3cqRLLIIk7qDT59vI7u6UXOrGbVRUJJNECJAGMbKpsP/Q1T+XKreIJnslsjNQdGD8akUyUYGQ0wbHPuJI/KE/0caYxfVaM20WX7YYF+IiRkFjdL/J4Wz9/zjKcvsJbcSj1LSW31QwJc2IN8/aSGBasSs4NtypIjQUT2GvbOlA/C44GhHWNYiwK2bytKiBxIGkt86Z+4mv6ew1Y/x30W6BlxguQE+hdySTruhI7RHkQTGmU2gGdlgjP9/WWKh1C6qnwsSxcP+rT3OHQNMsZFWy/o51Bz1XgyDu6d9PwR8y18i8gYV34sPrXV/VHnHHKK9EIZbOyapT+BLdIKp6i3E4UKUJjJSHBbj33l3+MEHtRc0rJeh/1F3lQaC0xngVRcuMeuhIvgseo1fE7Hk0Jl/3GhaBp4KuHZ7xqZXlGUOYcPST3R8aNbRt5xcCovRO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(11063799006)(3023799007)(5023799004)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j+lUVegKBGuOxT4/CIa4olnaVXUEeDDHrBepWeUcIoqLb09RqkbmyQ3Psjtu?=
 =?us-ascii?Q?noIRfu35+HzNzlgMq6ZugJeO/iC+FHP+w0XjFaZjwGg0SS/Gneo+Ogs0nH/f?=
 =?us-ascii?Q?CYEpKoEbH+w1nacFAQ2tX+0MgPu2BgsRyZKLpdB2AxWmjYHxDWMuhmKs1kaL?=
 =?us-ascii?Q?PIO1UKKDmW30yKGyPDWcWYPbc/L2p+iblzrjuNim2ZNM/joz9Wvj7ZgD6xyj?=
 =?us-ascii?Q?c+KdQPiUUQXIcyA6hcFtJWyGpgtWlqGe7uzJxwY6aSJoDc4k3+5dgrB+qGs2?=
 =?us-ascii?Q?P4ndUfpm5ttwotcOZw3w9iGGcrq2/ugQwhJuA/xyt3sza8CpbMR2BZixSElV?=
 =?us-ascii?Q?NpfXNjYhwdo/jApPzRgbulfdEAXnrk9dmPlzlHrDtX4Xrfsva137xjuNybK7?=
 =?us-ascii?Q?mrGzrRXnfQIps1LURkZgiriKK7d42LJb4IhjqE7HFFWGFumKp8QK4uTrUDrx?=
 =?us-ascii?Q?uSqB9rV4jRE1zbwXG3+V0arDYGWKGlU5MBlalJ1f5Kn5FJh4C3VQdRb+fqB0?=
 =?us-ascii?Q?fpivTegmyPLcVanyl31qVnMnmuKZoMYLMy/J02CSzibBjqA5OjZJPenvz9XD?=
 =?us-ascii?Q?XUbDtCmZsUaKGR82IUBgaFzb/eWQKAImuOxQKAogwoYDWvS8enH9dXco2ZWp?=
 =?us-ascii?Q?qWF+8L9u2zF4ULgYMrGZWzGXK2oEYsxRKirK2vXMHMRcEH58FDGyqmgdzT+A?=
 =?us-ascii?Q?yyHlQ9XrsSTeUrNOBOQQLYZzoNJ6ZCFtOzdvf56DUx+HLDmkjxYZ01pcbcFX?=
 =?us-ascii?Q?rdCNw6c6GnJDrdXfElWzg30JtWrWXYoh4MXG2ZfEzGxevTd486cyRatEbh5D?=
 =?us-ascii?Q?RL+LyPyNoYzr3BY5wS/0KPooOVQe9sfooO+Do11hxXt1EvkZY3WdJ9Sp6ql/?=
 =?us-ascii?Q?DpGJxAF6QYepKpo5THzlBmJctRZ4NoqTs7hukj/PONcIgrQfedO4PxO/DCwX?=
 =?us-ascii?Q?AGJ8HPSukDXHQuGl5y6vC/ff07L1j7VPVBCB+mPUHyCxh7fpn1OO96Dft1XW?=
 =?us-ascii?Q?4WHCnF4htWi0JfblPDyb2CrxftS3mtJXHcYlfNqXXvbwbSnrQ6hvCM9+8OLl?=
 =?us-ascii?Q?hIOcRX+V0pwvNb9zlytATUigULZMbTdC9Wm+1gfMkKczoZ2R4hpUXxT0UIMp?=
 =?us-ascii?Q?TEl7/NSOh/6ymb1ktMmdUF9vUFZrL1hQuziXXAyAWldr4sncBEDfPSXSd1an?=
 =?us-ascii?Q?rI0sXtHGdaDNMQzyAC8Ra4guThm0jsNTHttXgHQgIXHLMdMBEZ3B8/L4jk64?=
 =?us-ascii?Q?xqZfC8NoEicxeM9lAFC5/fCWoVO9fURQJSx6rbOrSr/X84Z2c3WHdhW60Le2?=
 =?us-ascii?Q?b3Sd1TtA78OPhJOr6r2BnpukbtIGhUpfz5B6/kc3l1CnM2ix7CXIGw3rFpKg?=
 =?us-ascii?Q?GUZurB0dNgXBRDOQ4lJ1uFmWRKNeawv0FH2oo6Pb9loi7oiI+Cya1cJwwY7E?=
 =?us-ascii?Q?7SVxpii3ppbDoTE6dSVQwTYasEt3DKAGiHU+MHRhvldeJ/50rjDCdfOovtqj?=
 =?us-ascii?Q?waS6daM338EEZ2Y3rNdfIhPa2K/VGL2BUbl+IptCHV25TU5XyOiEWjJLWofE?=
 =?us-ascii?Q?cWVUoyG8pQKJ9vDEyo0QqxSDqq2ivxAEBHwwlgLjAZEB36mBNlkzOLERaX3Q?=
 =?us-ascii?Q?6Ueo05Swj2CvYfp8Y9FBu7qGJpaYNmuy24skvy1OgNofwAM1x8SxSVQe/pqz?=
 =?us-ascii?Q?RF0a69a1cuNgoO5MsbbiUuhxTDjVnXkkkM4c9bIwNX5EYAF1rKdDW3zXk+K5?=
 =?us-ascii?Q?C5I2fTd9wQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e3d948-bec2-4bb7-013b-08deb63af068
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 06:42:19.2934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSva+jdfOgl9ncpqhLbBmdufwnadMeVE1XcNpv8s15y8XANolJN9h+U2yhKrVzLMh2lkyg99lAW9T9a7CEbgSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9104
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289783-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Queue-Id: 2E7B85884E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sashiko reported a potential race condition between the VF message
handler and administrative VF MAC configuration from the host [1].

The VF message handler (enetc_msg_pf_set_vf_primary_mac_addr) runs
asynchronously in a workqueue context and accesses vf_state->flags
without any locking. Concurrently, the host can administratively
change the VF MAC address via enetc_pf_set_vf_mac(), which executes
under RTNL lock and modifies both vf_state->flags and hardware
registers.

This creates two race windows:

1) TOCTOU race on vf_state->flags: The check of ENETC_VF_FLAG_PF_SET_MAC
   and subsequent MAC programming are not atomic, allowing the flag state
   to change between check and use.

2) Torn MAC address writes: Hardware MAC programming requires multiple
   non-atomic register writes (__raw_writel for lower 32 bits and
   __raw_writew for upper 16 bits). Concurrent updates from VF mailbox
   and PF admin paths can interleave these operations, resulting in a
   corrupted MAC address being programmed into the hardware.

Fix by introducing a per-VF mutex to serialize access to vf_state and
hardware MAC register updates. Both enetc_pf_set_vf_mac() and
enetc_msg_pf_set_vf_primary_mac_addr() now acquire this lock before
accessing vf_state->flags or programming the MAC address, ensuring
atomic read-modify-write sequences and preventing register write
interleaving.

Link: https://sashiko.dev/#/patchset/20260511080805.2052495-1-wei.fang%40nxp.com #1
Fixes: beb74ac878c8 ("enetc: Add vf to pf messaging support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_pf.c | 10 ++++++++++
 drivers/net/ethernet/freescale/enetc/enetc_pf.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 09c642040892..8e11a023d516 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -252,8 +252,12 @@ static int enetc_pf_set_vf_mac(struct net_device *ndev, int vf, u8 *mac)
 		return -EADDRNOTAVAIL;
 
 	vf_state = &pf->vf_state[vf];
+
+	mutex_lock(&vf_state->lock);
 	vf_state->flags |= ENETC_VF_FLAG_PF_SET_MAC;
 	enetc_pf_set_primary_mac_addr(&priv->si->hw, vf + 1, mac);
+	mutex_unlock(&vf_state->lock);
+
 	return 0;
 }
 
@@ -496,7 +500,9 @@ static u16 enetc_msg_pf_set_vf_primary_mac_addr(struct enetc_pf *pf,
 		return ENETC_MSG_CMD_STATUS_FAIL;
 	}
 
+	mutex_lock(&vf_state->lock);
 	if (vf_state->flags & ENETC_VF_FLAG_PF_SET_MAC) {
+		mutex_unlock(&vf_state->lock);
 		dev_err_ratelimited(dev,
 				    "VF%d attempted to override PF set MAC\n",
 				    vf_id);
@@ -504,6 +510,7 @@ static u16 enetc_msg_pf_set_vf_primary_mac_addr(struct enetc_pf *pf,
 	}
 
 	enetc_pf_set_primary_mac_addr(&pf->si->hw, vf_id + 1, addr);
+	mutex_unlock(&vf_state->lock);
 
 	return ENETC_MSG_CMD_STATUS_OK;
 }
@@ -989,6 +996,9 @@ static int enetc_pf_probe(struct pci_dev *pdev,
 			err = -ENOMEM;
 			goto err_alloc_vf_state;
 		}
+
+		for (int i = 0; i < pf->total_vfs; i++)
+			mutex_init(&pf->vf_state[i].lock);
 	}
 
 	err = enetc_setup_mac_addresses(node, pf);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index ae407e9e9ee7..35d484858c7b 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -14,6 +14,7 @@ enum enetc_vf_flags {
 };
 
 struct enetc_vf_state {
+	struct mutex lock; /* Prevent concurrent access */
 	enum enetc_vf_flags flags;
 };
 
-- 
2.34.1


