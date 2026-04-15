Return-Path: <netdev+bounces-278732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NUsEZNf32m5SAAAu9opvQ
	(envelope-from <netdev+bounces-278732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 11:51:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA500402E15
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 11:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0850306271F
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 09:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB13833D6E1;
	Wed, 15 Apr 2026 09:42:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2132.outbound.protection.partner.outlook.cn [139.219.17.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C716133F5A6;
	Wed, 15 Apr 2026 09:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246165; cv=fail; b=rOHInBuDwMfXKqQs01rZh4sMcVrUEx1w6H3CLPQforys/BG6wGN9rEEuMsoFTlLPDQs8mKhPaptWd0AuC9fdJ85RhTUFV6ewXForvSUYZNqgbkYYCM30b2zVxZOnu9N0k2nO7l5aS1NdlsVfwq2oftiizG6OQMfPOUgGZSE93Ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246165; c=relaxed/simple;
	bh=TqXKbqiEIWMSA1+Q2bHLGknW8AHp+Fq5L2cWuNWyAhY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cANCsEzTlhiwakiwmkYunLrwTkbXGrgilMqemtVSyzfMprSpGTAXnXUGQfJglcwxzv1wD2E1fM09Nmv2tP7vevOLMMs602sHwoDiCQEz3tCdwRrBcLmfXeum6E3EYD4Ap+ILiM63da4WleB54qRnMnXHxPTqHT8Up0m81+WbLNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpxWdGAI/0GnWIRxTKIqUOr3tUSdqIAzX4PZ9U6Ul8sXs0dQRHvP576UMimFk3LpZTGBmls49D6794wGOOkmrlBjOxnbYpUliAUZ6JiNUqWBzKAYKGfLzBUhmfGAj+6JtoFDDj7kTLx8iZdivIxcpOspuPopL6q22ILSeDd/FKNCY5T9yLBaggn0fkDyUt0ivOuYvJXdpMPsyX5tlkMx5M6K7zPY2V9PRGS/SxJKFYiLS7dcorm9qqea4qHgFHqv3Qi7J2MlGg/I/2xc1s7TLzhLXmSCvtWXlF0TAtAGiYRdhSsHPHE0Qw9xHzBh/VaSQqIjfKwXm+zJdqt6y6kbgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNnQdNZv+BbQn8xmmhojXzUhpJE70gYXDAb9tCPxQ0w=;
 b=R6n6gthKTLyhn7WMXLzBQWWoPE/P/dbIzNjCewoFQwFqKtoOp03/BKb3HtTuWQYdkJqSEyGkPjt81EjRw4NwM8IaYf8iqLdVFexJKfQrk5UD2GzCLuYFE1LtG+pHVI64nLyULhHbduPVT3MS8jrDOvUmS0e6DmVb0fIh0YThIB211zQdKfzX6q4FzBtzuhx1juivZBwCgVCjz/z6Bf70pUolebC1lVyUFSos2xYm+MK/8Y4JQIW9lxQeFQi74Xc3x3zNBGxiSVEhZTxIljNjSeCULQyEEvB0/u25sJfCmRMkDwU7TkEuczfai4HCy9eQI7LKc0O6vMLZ8XLt5FrKdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0583.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:16::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 09:27:05 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::e2de:92aa:4c1c:a829]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::e2de:92aa:4c1c:a829%6])
 with mapi id 15.20.9769.046; Wed, 15 Apr 2026 09:27:05 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Frank <Frank.Sae@motor-comm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v1 3/3] net: phy: motorcomm: Add YT8522 100M RMII PHY support
Date: Wed, 15 Apr 2026 17:26:54 +0800
Message-Id: <20260415092654.64907-4-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260415092654.64907-1-minda.chen@starfivetech.com>
References: <20260415092654.64907-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0007.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::19) To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0583:EE_
X-MS-Office365-Filtering-Correlation-Id: f25c74df-1302-4f2b-ea2f-08de9ad128a1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 1mD5/Ht2KhdquRZp0SeuuTRut7i+bTz1YGTrG+4uR5tCOmMiyvSVkyVB2T7ry9I6EX3xUWEQQWpRX3ZnoGx8sflYIh/98CF3Fu7BlADWSxFOQi1uFVPVyVQGBAUS1L1INbn0KkAqK+WW+II3pgH9IgyNRbfZ/nd7Jnki1DqlO5+HtUNpUFNNuW6xPFGNt8XPWunCtvQV35GG8of9bJMvMTqEOuXYeQrq6EvyBq4VsOCLKqhPWz2QjsUvxNZ6u9VQVwOFcvWL4kjPP4ywoaqIWdEkc0QL6u5KzX9Dz6eZtv83Sh3gv4prbymryTPSY1MbrJ/nhWTzsHqinhu6BLA9GDWI8evAfBWL5ivPtxeQEb7lg7PpHAw3zNVyLFP17a9OlVG4eaiaUK+hgXXS+CEVzO5bd1Zfh0KrUWrEbH8aD49bWohE3p/eO1cpbD+Q5TqjNjc7mxoYE2wuXjbDzwLy9jgmfYht5T5FHjYI1+4pS7EIFAz60xcoHz+Umccs7m6ijFZILKw7whlLjIbfHiY5zIh4tLQMXnpXHrCzmOjsk8KJ6sqrJBKR79CbVQrhZfXfUicWNk2f3HnXa5OMIwJkqw==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?c3gbAcqo0DLHdEXg+sxzRDnlK0G9Yc1vKYGMLfwU2Lj4BuZ2anEUB9MWfzIr?=
 =?us-ascii?Q?eHM9upUB0c5uMRbMg7NrOzsFDlw5bObRaccdtky3bwPUIVHuN1KOE5BXYmxs?=
 =?us-ascii?Q?y7oLS8Dp3GGp1mZfYFGndktvqZliCzefe9AGUkbdX7lMj09PXT0gZ9CmfG8E?=
 =?us-ascii?Q?7CJMiaDai5OayCHPZbjfFGnmYv57wFHEtvj4UbAYIzp6WJEV05aXAUHjwbz5?=
 =?us-ascii?Q?t/m/NZPhAYPuPxiis7d1UXU5XJqtQ4VPZyjLbwIMLNSttOrTXiYofax4F6X+?=
 =?us-ascii?Q?Xq3JpJTx+FVcPeIIsvpkUEV1YhG1AvLMmuT0OGdVi85vxXoJ/UzfEBsrC1Em?=
 =?us-ascii?Q?uh0J2QWcsqVzFyo8zE6AaMxoN8H2pXr++dUlIq6CHXc3zE5BCzp1Pn9zlagG?=
 =?us-ascii?Q?CDxdRgnFAlVY57ooxY6YG41gjmWQWpYKA8jqPkae9SQq3Q8sTIbNN3oUXR70?=
 =?us-ascii?Q?31VQ13T4uLezO0DNavqNIe9g9iqSQfJKPEHall4/tNwdFlR/rkbvsoCi1W5u?=
 =?us-ascii?Q?oUBxBqcDWGL9i8OmFFbYxjwc34b4CE4Yc4IZI0sWunwvE+kFrP601lWFynnY?=
 =?us-ascii?Q?QU+Oef00/fjrgBgqb+iqELrEEaKYBureJ9/AXuu9cAxcVykZy7O0Qp/76BwJ?=
 =?us-ascii?Q?gjA+7GUd+QFfXJ9QH3xrYA8IJzknI86r1kBcn3NZeAMwewmbNEn77USOB8Es?=
 =?us-ascii?Q?GmXJ3mN23vw1PNTutHaDJ5sGMMxrvKxgICtJlk9LggaqpSjpdqytxgCMgAZE?=
 =?us-ascii?Q?2I3meTNjBiil0Sj3JNOrJmNnfEa9WUvMnokX3RwkuPvGwWG2Tkxk0ChFd0oo?=
 =?us-ascii?Q?6KoviVXNsFhTp4+U+wkyd19Qi11F9eYjU9it1A48GUcj3+dlZVr5O9TXjVkF?=
 =?us-ascii?Q?HBN2eZ/7Oz/IR/lQ/TIX9miyn311yJZKRYwf1mDcueHR8Ha/bo4qfg8bIHTj?=
 =?us-ascii?Q?3RJmf8Kx0MrF2orIdTlTjc4a9n6bamOs7c+JFJN3EEU/logIPPTtJwBWxUte?=
 =?us-ascii?Q?h6qW+DLqGNjMEZ1TZurW3K1xhO/4+PX0W2bOsj0X8fI1Aj36wJnGSD2GlSOn?=
 =?us-ascii?Q?ONxSc0AiweX6T+2rBc6zJ2YUImj3hdKbiCA2AIvxehuf6Z55cLyMsXohHOzn?=
 =?us-ascii?Q?JVDFLAffM/rM/v35P9o9vxibbf235KAm+1cvLPDLQQtS/w0GWPxvh0yq4Kx7?=
 =?us-ascii?Q?yg7FkAeyTR4uwU//5lVELwDwjnDxkqJ/UMjOW5HCTV06n056FgejEXSBykdE?=
 =?us-ascii?Q?NoYRnCwJWHnkG9ET059rVC03j7nUyH3USadOhG7Wz00sKidWt/eJugPFIYkl?=
 =?us-ascii?Q?BhGVVAnswJYfwEqSjDhz9G3OBwJ3WMQjAmLZKyIcxoqLFva1s57MVnZSVRks?=
 =?us-ascii?Q?skPIPVdjiJzK2l1F7UXGVFP8ZrxDPwimEaWymWsOvMz69YMkI7/QQiuDMOFP?=
 =?us-ascii?Q?inxYuojAcp6YZlcKr5PYRUWRKdtfcDpCNBGciMezpE/hLaXyRvQyt/no+hf1?=
 =?us-ascii?Q?L3AP+/IPJLpMZcE9xTqC6NoH50yuh2lK4rqaYSVMpjbw/Dkhxu4kzBgkSDZK?=
 =?us-ascii?Q?plRtl/pJ1ylQ4w9KZQw5n+QhbBg3qWf5g27zAj4FJc95DfEAjUVCAXJw+0oY?=
 =?us-ascii?Q?tm6Bc0ouj4/FE8cxsqtvctOQgkFwQkKpo3+JlB7lOJHI/Owm/YVrjFFkHiEz?=
 =?us-ascii?Q?aB/jWolCkQ86/i8lem3wVtjFtFb5/vi9UpdXM6PgBCrX08Ixp+zEwp+dL54b?=
 =?us-ascii?Q?9RhfMpR6slQnlop7EYP+palJGd+pwC8=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f25c74df-1302-4f2b-ea2f-08de9ad128a1
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 09:27:05.4928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U6sn1Ehrxk/l/1AT/uakQz+1mqGi23iCCb+gZKgZWCz0wQfbDA3cf8/i9iGMxt+Anc8vYejG+fe7fRXENKeArp3Tq07Nt6C70s3N8sw7edU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0583
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	TAGGED_FROM(0.00)[bounces-278732-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[motor-comm.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.877];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,starfivetech.com:mid,starfivetech.com:email,motor-comm.com:email]
X-Rspamd-Queue-Id: DA500402E15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add YT8522 100M RMII ethernet PHY base driver support, including
PHY ID and base config init function.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/net/phy/motorcomm.c | 49 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index f3129419f7c9..86396424b042 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Motorcomm 8511/8521/8531/8531S/8821 PHY driver.
+ * Motorcomm 8511/8521/8522/8531/8531S/8821 PHY driver.
  *
  * Author: Peter Geis <pgwipeout@gmail.com>
  * Author: Frank <Frank.Sae@motor-comm.com>
@@ -14,6 +14,7 @@
 
 #define PHY_ID_YT8511		0x0000010a
 #define PHY_ID_YT8521		0x0000011a
+#define PHY_ID_YT8522		0x4f51e928
 #define PHY_ID_YT8531		0x4f51e91b
 #define PHY_ID_YT8531S		0x4f51e91a
 #define PHY_ID_YT8821		0x4f51ea19
@@ -227,6 +228,13 @@
 #define YT8521_LED_100_ON_EN			BIT(5)
 #define YT8521_LED_10_ON_EN			BIT(4)
 
+#define YT8522_EXTREG_SLEEP_CONTROL		0x2027
+#define YT8522_EN_SLEEP_SW			15
+
+#define YT8522_EXTENDED_COMBO_CTRL		0x4000
+#define YT8522_RXDV_SEL				BIT(4)
+#define YT8522_RMII_EN				BIT(1)
+
 #define YTPHY_MISC_CONFIG_REG			0xA006
 #define YTPHY_MCR_FIBER_SPEED_MASK		BIT(0)
 #define YTPHY_MCR_FIBER_1000BX			(0x1 << 0)
@@ -1857,6 +1865,36 @@ static int yt8531_config_init(struct phy_device *phydev)
 	return 0;
 }
 
+static int yt8522_config_init(struct phy_device *phydev)
+{
+	struct device_node *node = phydev->mdio.dev.of_node;
+	int ret, val;
+
+	val = ytphy_read_ext_with_lock(phydev, YT8522_EXTENDED_COMBO_CTRL);
+	if (val < 0)
+		return val;
+
+	if (val & YT8522_RMII_EN) {
+		val |= YT8522_RXDV_SEL;
+		ret = ytphy_write_ext_with_lock(phydev,
+						YT8522_EXTENDED_COMBO_CTRL,
+						val);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (of_property_read_bool(node, "motorcomm,auto-sleep-disabled")) {
+		/* disable auto sleep */
+		ret = ytphy_modify_ext_with_lock(phydev,
+						 YT8522_EXTREG_SLEEP_CONTROL,
+						 YT8522_EN_SLEEP_SW, 0);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 /**
  * yt8531_link_change_notify() - Adjust the tx clock direction according to
  * the current speed and dts config.
@@ -3066,6 +3104,14 @@ static struct phy_driver motorcomm_phy_drvs[] = {
 		.led_hw_control_set = yt8521_led_hw_control_set,
 		.led_hw_control_get = yt8521_led_hw_control_get,
 	},
+	{
+		PHY_ID_MATCH_EXACT(PHY_ID_YT8522),
+		.name		= "YT8522 100 Megabit Ethernet",
+		.config_aneg	= genphy_config_aneg,
+		.config_init	= yt8522_config_init,
+		.suspend	= genphy_suspend,
+		.resume		= genphy_resume,
+	},
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_YT8531),
 		.name		= "YT8531 Gigabit Ethernet",
@@ -3126,6 +3172,7 @@ MODULE_LICENSE("GPL");
 static const struct mdio_device_id __maybe_unused motorcomm_tbl[] = {
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8511) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8521) },
+	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8522) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8531) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8531S) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_YT8821) },
-- 
2.17.1


