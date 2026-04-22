Return-Path: <netdev+bounces-280350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHWFEaCJ6Gk6LgIAu9opvQ
	(envelope-from <netdev+bounces-280350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 10:41:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAB444393E
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 10:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3BCC3022CA3
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 08:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6EF3C13EC;
	Wed, 22 Apr 2026 08:33:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2108.outbound.protection.partner.outlook.cn [139.219.17.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928563C061C;
	Wed, 22 Apr 2026 08:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776846806; cv=fail; b=rhBLNcoxWKtoJtKKyM1GR089Qm5ceJZxquSqBVzFJ636eqrf6Zac5cLTQvFuQoCsvGv4++t54ju36h1ZBlCd7kCzjN5He6CjLGrxcid+o+k7fmkGsdUZuwyOag8swWBJ7YSGpDxQ+Ao9XZYfzHc17Qm4kmIEqc35rjNwZXb89w4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776846806; c=relaxed/simple;
	bh=9Qgx6z3w7CYtbi8rTBH62zG+03eSOOR8Q7RloSIUuis=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UtLCWg02FqS6euGzGFmKBEhKr7q9RCh4syZzo5BiIaEEGaz0CyCZg/ZBQxBRrBubiQB30E25g15aS8KFqTVrQuQtwD1HamOneCMprgmM7aXGKuk2Dii7JIbjaz2S0+k0E9ys+3UsCPCxCtgx1/f9xknUT0v/6OeoXBg/Axhg3cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTusyf4rftZl8F8jOUtEEOyFyNvH9+7uLoabiq2DHPpP2MNzz2jVi2b2sYjlml+oCEKNyaLMiVxMpqMX61ndKB63eYiCJ/DODyUsBrUMVfE+2HbsT7LWdUHmwX00gFOybgDefRyEKBX9eAbgJEGlXTjc+eWx1L+LOEvcTte7hdAxSbPT6l4vlGgUK+CfzkvsjyLerFKTcK/a8qiwR7e3N/Gr569FbSs/J1f4qEEU9b86Muf/BaI0a3SLlWjZf5HVL1PSX/vYDZ6UvJb9g5QeuphCeeqlUZfb7oMZKQeQ4bdy570pLplrhcVMUvoVQ80RYa2GfkurTNVtTBhEK7SXiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIbji8m7a4OBvi6egajWsW4x32au8ZnsUNyinKCC094=;
 b=IlXApHxxJBGhXRhXAXA/BrUATQYhc+ZpudCJNH5pnCn/gYHiDbLu9VZmE8pTFbrtjoVt+9+f80c/zYlWw1zFuTGxDYLuRRTj0NmCvfeBdFGx14eQlN3JtIIJWrypKY4barw8seSQJLvwCa2Ry8UgTkGvKIBkjy28rYe3bL0a1HAQTu21jBup7x5I6iZsQaEDq+ky76SS87LW5OwRLE3sML8n4MOqqghHs45HigOkXKO8gRNEjWseEmG/9JTum9MaMfYJy+8TrKCykdCQZ6eBh7uXkcdayG9IbVdNZTbI+66QVMrH85JjeK4eKWd8BqBKVlZD+Q8G6ovWABEXL817NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SH0PR01MB0858.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::18) by SH0PR01MB0554.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 22 Apr
 2026 08:33:06 +0000
Received: from SH0PR01MB0858.CHNPR01.prod.partner.outlook.cn
 ([fe80::8f25:1579:34a0:8569]) by
 SH0PR01MB0858.CHNPR01.prod.partner.outlook.cn ([fe80::8f25:1579:34a0:8569%5])
 with mapi id 15.20.9769.046; Wed, 22 Apr 2026 08:33:06 +0000
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
Subject: [net-next v2 2/3] net: motorcomm: phy: set drive strength in 8531s RGMII case
Date: Wed, 22 Apr 2026 16:32:54 +0800
Message-Id: <20260422083255.29692-3-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260422083255.29692-1-minda.chen@starfivetech.com>
References: <20260422083255.29692-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0028.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::18) To SH0PR01MB0858.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SH0PR01MB0858:EE_|SH0PR01MB0554:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ddba7b4-700a-42ce-4f03-08dea049c724
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|18002099003|22082099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	PSvfstlTK7KxLdzlHUVfSJOBAv8/Kqxisk5oxyGjatprQbsJ/b/mKqzVT9BC2WYBNTNCCV/5SYYozkKsrLE2WNz2/zwCcRh1WYfeGWP5kgQsCQ9s4aTVzxnmPDmTUmV9SbOOIR2PmHe+Y6eWlDayPjzkc4uUinXOxwvlLVuuX9iKZQgdiq/xc3axYzIxO00sQzHZpzoqIULKm8XqJ80EK37LhQI1B/JVx6Lo9lDRO59qxygbmGbLQuFmHnbrl9ptHbeLGa8Y8x0YhAnQhapS6qr+wy82n/IIOnWptVh03hTxvyMqnPTV5kapVar8PbEhOkY9+LX14bbfp3fcn1yoWNu0D/T4QhT9VMuligOkp4/yovTbQ0FVY3L1YO4VFjtcEr31RIFMCYKmz0Fpn+/pdNarsgT5Yq9EJpAxNXnpVYk2wDQ++3m1cs5Nh1nPzcnvfpVlFhr39OcdL3+Nui3UHjA8hPAMsGttCfSs/Plc9eWITJVd832dCjjOmS/rBNY0wc1NQpGLICQAoOu9bbrisP28zochJTtqO8yGbFXoJ5JF+hXqk/OJETQ13y6xi7eKusXJv6CQhybiZoeM4QuAgQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0858.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(18002099003)(22082099003)(56012099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y6SxHUhYBZnsCOufaj5z2cw3iQjC1spbBG2mUluUJD9EspwKSXdY5w5RsOtO?=
 =?us-ascii?Q?zpi1yTw784Uf1It4YEmPr5Sm//HPBajpUqVQrbXLkFyEAj7cXQVr2e6DnHrG?=
 =?us-ascii?Q?182etSD8m7LgzoZOFPsynz7C5eZEqhsIHoYCzOdwC6xmK0JdwpyTDFOBw7PW?=
 =?us-ascii?Q?ayHdWx8XpV6cAIDaGvPsgVxcMcX/TBSAgdMvcj3KjHdRQoUEDWdYw5gG1Vbm?=
 =?us-ascii?Q?daTL1GPQGoqxRqIGuEVs9UJe2ZBUolkURCaId4pOtceam7peVDgKNssTjZdD?=
 =?us-ascii?Q?ZLQI2KnXQSoQLBIYNW2sqe8zexzu5bLmpIwG9j0LtNRX/EJ7bvzTuuC52hmg?=
 =?us-ascii?Q?b7CdrhKzYbDW7Ti+8Lab7RzJFJ6XvUcDnXoRYmG72EXYIY42Yr1QYBfKblEB?=
 =?us-ascii?Q?USqKIbwZO0VaJzo2ISniEfibPfM2i/mooG7B9+zRBrDyI9WQCE+yt62ccsjd?=
 =?us-ascii?Q?PCmlkbrJ73ePGi6R1sAuN535U8ySy+DQmbXM5ZoA2l5DsRhiWldJMVTTDNJf?=
 =?us-ascii?Q?Y+Wn2gI2eJjJpfzaOJh9JHAA2ke4Q018SA82chMAPe7EKcyv4qnw5A7CmxP7?=
 =?us-ascii?Q?2taZIjGh+r85EjtUjg+m4lPXz6jSNaJPX5cpqgknLh18TLr/5f5Y705fh+Wk?=
 =?us-ascii?Q?EtYgEhLX66ZNAuE9BzvMrjQ4pst20XozmbmwQfCDJRvAxL4bWsMJWMXM96Kh?=
 =?us-ascii?Q?vK96yMn4UKwuznRI1j7wLJpWp73GWK7414gJyUxVxpkLy9cQTVqlQlzPVEzh?=
 =?us-ascii?Q?FOmwH7Q3Ncr50tKWjJ2cNOAo/fD7/m0kpiIBbRBhc/dWqf9SnJFzA7mZzjFt?=
 =?us-ascii?Q?J1Bil7KkIR7jqr6t5GYherxPzSk9plkjxLzmkpbYggCok0V6rjbmUQzM/EvU?=
 =?us-ascii?Q?MS5eDlGCNsxoicVeXk3ex4H3rqcfQbkRY9SrkONo+QSfJVi4mFdLL4gHpHro?=
 =?us-ascii?Q?l5wqRyZwtmMjCSI8pHjtYp5chcfW2o7utaMKqjIncXU5SGXb+UkssbUajqqI?=
 =?us-ascii?Q?+Y3HmVjz/FX3Gk+8iqPTSHJN+z3r0p395hOXjOK59YVGRoq0R57lME3CvALK?=
 =?us-ascii?Q?iilr8CK0wAk14l15mcKBA61dNj4AjiND3u6GxgkXytOun10cfABJ4Wve+QRZ?=
 =?us-ascii?Q?Ap3LTZ6FSO01DJ6iafnXtkTLK0sJ25LCa/E/OM4EK+z73YISauWjoy02FMTP?=
 =?us-ascii?Q?UpJurGesIsGdf3JOSk5Qh2nMDztgPnn4UTK4J5Z+ClC0t4GKRFH4dIVMCXQw?=
 =?us-ascii?Q?pQNxACtsxyYqNko4i/eDisxxde6Kn4/UKovmwQnlgAV3PgKRruKctTkCfXre?=
 =?us-ascii?Q?vaQBL6XgsyS7QkbEkI1Bcp9P9JhCell+fE/7ueqQlvIJFbK0jhXw7mQD5QIC?=
 =?us-ascii?Q?+LnBAMEhwgq3qykGhpvRFLyT+uUaXJB89c6Sxvw47tQoQMBnCTNweSS61fub?=
 =?us-ascii?Q?qpzjPTFEovfQRpv0Q4iFowYoTKmrzU/xu5UYxYC7PyBV7UD+hFMr/O6AqXbK?=
 =?us-ascii?Q?Z4N58V+un5wVbVBL80njdLICR1Lqp0iJF3escHZPBcGGpxyXULCTa5O1TKZC?=
 =?us-ascii?Q?nwYl8aKOlqDVt9KZ+YcUvOgebswEMx/dYFUr/9rwyjNlCSawPp/lE2zZ9oWM?=
 =?us-ascii?Q?9baDfWOm6d0jiy1RB4EQ/nfSC0hQcW5DMx/LSxaMz/dgTB/opUMbVRHukByx?=
 =?us-ascii?Q?wmMghmZZkyA3HArMVPGOGlZvaMCBHBqaHcq7Zu+wywqIn1l7LPvObKkU42gb?=
 =?us-ascii?Q?o/U6WCeE9Uv2bN/DE8IMZ/tYVqGT1os=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ddba7b4-700a-42ce-4f03-08dea049c724
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0858.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 08:33:06.8968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D6C/IkZtiMrtXygnlekO97mwY34I9vgvP8lyGFCha1uTYCB6wLMvdbgnqRIB+L9GUddREtJWojUiKWJMrYIQ0EMfEznZygX/4ky0qtfg8Ek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0554
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	TAGGED_FROM(0.00)[bounces-280350-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[motor-comm.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:mid,starfivetech.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CFAB444393E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Set RXD and RX CLK pin drive strength while in 8531s RGMII
case.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/net/phy/motorcomm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index c66804537aa2..ebc24f51e626 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -1698,6 +1698,11 @@ static int yt8521_config_init(struct phy_device *phydev)
 		if (ret < 0)
 			goto err_restore_page;
 	}
+
+	if (phydev->drv->phy_id == PHY_ID_YT8531S &&
+	    phy_interface_is_rgmii(phydev))
+		ret = yt8531_set_ds(phydev);
+
 err_restore_page:
 	return phy_restore_page(phydev, old_page, ret);
 }
-- 
2.17.1


