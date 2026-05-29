Return-Path: <netdev+bounces-292959-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YRhLKWEKGWpjpwgAu9opvQ
	(envelope-from <netdev+bounces-292959-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 05:39:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 275EB5FCCA6
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 05:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B40B3027944
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421CA311C2F;
	Fri, 29 May 2026 03:39:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2098.outbound.protection.partner.outlook.cn [139.219.17.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9AD2E739C;
	Fri, 29 May 2026 03:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780025947; cv=fail; b=RWKg0vtFynbcYJa3uU3tnzl8BWCtuNlHjapuzzMlJ/qg5IapuManifyHO/f6B2OEW6v2nwpx8GLEIv4AIVd9OOe4H4g+lOSsrw+aYf3f7ZdAJ/i9zyMbykkr0hg/bIiAC6mkKgEi5MI4wduWI4Qw/xpCEEROv90jqmAppmfJr+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780025947; c=relaxed/simple;
	bh=nMfa9m89MZMavRwsBN3gpjx0vpYcp+MPQZv/QtENsvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XR05V8a9O4kheb6qfn39wCLxhay1aBSPrdexvTQ03UWITzrz0Wz2EZFvFxC9RqiODexbPk88HGODnRToeiPDx1UkxF87D6GOJ5jmfPaW6aR9FhwGngt8gzOIoZ0cid0Zv0UxoVzd11qrHUeSQMPqcVskIO80qSuzqgW7xJuFqDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKvBWNf9e3g2dhkojlJIosDWWLTN5i8jYRpiIj91iEfKJvyH+7MYxX6VWfP1bR9ElmHioIGlB5Os9rT7v8Ycf6NjNGZNv+WKOS/fqa8MUS5O270YExoSbjU8FPXvMUiOiMtP7Xa2Kap5aW3NStnv36BGDE3Gann+LZTEfgQEVbThcGQB7yMRJUJH8aGmvSdTKSQZvxrhyblCFF6cVzsIyCgs7iHq5FVV/k4X51xjImVbneOlcFJXTNTCewWmm3bj0I9H7JCVXKi+XdWVOzKLj6746pL2jixF1g7EqlJBWDwnyeEv56Z44BUu5E0+fwo6k4YEfFR4CpDqF9pfCsg1OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oqiT8GR2qb0LVTQRB7i7Y2HY41KXitmcrffWHB3Y8M=;
 b=TkUFWIcEJt47sWfdd6E6R4hMWDzH8r+W0Y7lNfXMtJ+rY2POpGTuOJafxDYGOaGw7oOj7LwHTj5szXkdR1Q4xIxNLkm3IhozOozqJ0s7u7gcEsZxohdGomGkbbxCQWBxks2xqwuGe3EKdmMDjQktPAvQeCj5zJh3nP98TR4CtIrNo4wsIQIQrMQJppFmrs59srTjD+ydRy2TE9OBXi4dgAU8pZUIPUzkTP6drCtjUMY8dLyfR7LjTfCiKEDgHXASoboNFBuAPkXMmy/hzp05Hl3aWeBUUVcOx7K0jGuwCk5w1pgvDV/xFYuUNgRzeEOK9LZewyXMYL7eRtv6OEUjwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0862.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 02:05:40 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%3])
 with mapi id 15.20.9891.021; Fri, 29 May 2026 02:05:40 +0000
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
Subject: [net-next v5 2/3] net: motorcomm: phy: set drive strength in YT8531s RGMII
Date: Fri, 29 May 2026 10:05:29 +0800
Message-Id: <20260529020530.16856-3-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260529020530.16856-1-minda.chen@starfivetech.com>
References: <20260529020530.16856-1-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1ff41792-2fb2-46a7-e199-08debd26c830
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|52116014|376014|38350700014|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	jWMgsbgKz/0c8shq6S/BoMBz8Qu5WZ7bLMfvx8geMjSCXZe/ATE7BoagRDcFxsQnRce9PgaZjAz9nqcZohcxKdD16t7o2RJB76kJ0YSfr157Q8JLvqJd3/tfEwlPOxOVl46eKd2nPZ/N8x09PNwThQqQj36AAS+KmcfK1lmQbgXUyfQGHsT88zqAwiLntwINVF2NqFimlxkMYb3QmPfC+cuzeGvctYiJJMxuWy8kY8YA58AJ3b8PY6sUth1WY8IOHb/gSbSrzMUMVf1/oSmi9+wvXTgK3K1Q4nLRdZYtCYX4TUNqBe2oHtGHQcgVZejnzc2dDIJau7iplm3Lk6j9Tvfa5mEg7A18tEn+94lDMJ2H+LXp5Fw4uUV0AfdRlaCfkEWJmK1TFtiICfWjN8Fr+vCAe/m04uA+MYe6KSRXOToOwcqGuCJqyTMD+BlUIwO49uttPp/0IuaXgj1VMv8cnCB4cHSHwGXdZ6UCzfkR9CNnQhkQrTcvdwdy4H12slIekwb0ycDURmHsW7qt833EBDGX+csJrP9LMECaYahL+EeUu4CYZ2NefwbXV4gEHeFb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(52116014)(376014)(38350700014)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eqikAAntP/x7dxAA68kxtsO4BAGdMG432TMKjzlWDYrLjyyXewamSBfe/L/A?=
 =?us-ascii?Q?HDQGn8Fq7glp86q5T1h/YGzOJ3mfvntXSKJ2zjsvdW82p67uNvUZun6YkHey?=
 =?us-ascii?Q?/n7j1mwpeEkixHHW8DbWFNXvU4lY89t85whLx4TFMtB0gdcITt5bd6R+OqIB?=
 =?us-ascii?Q?3vYAFXQPxRxDA3Zcgr/6Smh24hPPqlXZf2fzWkvn+E0aiCtp5tdagrp1Z0OS?=
 =?us-ascii?Q?mbnbF2tIJqRvYhW3+TXrC+KFCFYmbsdc4xg6HYXbcbj77/m957tCLSx072bd?=
 =?us-ascii?Q?HwRtA9561FG3pq7B6jxXG4HjlexjSbcOs6g4Ucgg22AzTa6kUgACz6vI+t6z?=
 =?us-ascii?Q?rwxa74+nDQCtZSGJI00+UTqTp2riazR7OQLyY2gvgWAC4w+id67fEdxc6L61?=
 =?us-ascii?Q?gJv97ff1LQKuKPyFHWo9Kd1Temzo4W4PNT+KpnA4OaHSEBCqbeRa/y+kcami?=
 =?us-ascii?Q?MD5YGqyeGd3AE93JWunQQ22c5+O6WqNdwJo/9zrp8ijAAsEtJ7Fzh3hhH3BM?=
 =?us-ascii?Q?29QNp/RkppYGp8dttb0FfTNusABCjS20orkRT8ZEt137Es3sKiXTOB8ONplh?=
 =?us-ascii?Q?PH27kxcOjL63fhbFx+tP6vce3YihdngmYspZE1DOBqMZMB8ii/e4JUuHTcau?=
 =?us-ascii?Q?+kW/+dCCvoL3BLPHOgV9yQf+jXdZOTZshAmod27MxtRScOy6MJ0GbWbJvbqa?=
 =?us-ascii?Q?cgw1zvAA0QZAGp9eXryqcwWIctosFZtLAg3FmiXrGWwOGxm8lGQsC6CDJpec?=
 =?us-ascii?Q?k4+4PAkCn+BXRZyNYQ9mcAiDyBi8K0w3xBitvf5S1kLPu20u3TLlevzhsfRC?=
 =?us-ascii?Q?UYKoR+kXJ9xZX6Q64tW2kTIUUZRpJzGhIOen9RCSXeFUqK+V8M8bVMyWpyGH?=
 =?us-ascii?Q?JdgBFXAPMnzBfZ3On3iL9xYFc0RKQYSsKK+2ll1z+2R/pL+ntMYUKyeygyqH?=
 =?us-ascii?Q?uNx4nAJJa7khK38w8dtTmQpq6ptD4ypSNfPVdp1bYqcdZPz2A+vrjg/gwYEf?=
 =?us-ascii?Q?Emy7Cn276d9QXC6Nlx48y6+aUUnBRtkUv4GfAZYvGA6UyDHKg0Y8EV7m9NPA?=
 =?us-ascii?Q?WiOpFBgdtmmdlDPcmHTDRGY5Tn1CCpOqW5QvEZhLnScJn7e9oByvA3F4faVG?=
 =?us-ascii?Q?d1iOOPlcwPJes+fTHvZLN79ITPCf6pcRUTNpzsMjyPm+IcDiEFLBIUykhYr0?=
 =?us-ascii?Q?bGQGmCdF0c81Pj2/fUggI1fNQnZyAJJGa4qgivmwN76B/NJMkftPOsM++TV8?=
 =?us-ascii?Q?oG3otsrtJfWV87h81ezlNlq7bI2iRw4nGS6xtSFN8c6rygFR8xLwsb/cbHss?=
 =?us-ascii?Q?XJcgigsVLxR5DOKJl6U1YsPxNmtcnoxHa9FUmS2gr6or/TMENqDPdbW+M55I?=
 =?us-ascii?Q?TdbaEZH+GthqhHGmdi3H7PBhBLlyv6jnbs3XFK24w1Y4YXk4TqDrs7q/Fnjk?=
 =?us-ascii?Q?q1jaEPPvsF9uImC4p56j6nABaK9SqBAFb22HTbwRarwrRgCXz6Ea+RRbIhkJ?=
 =?us-ascii?Q?a5p7zZNFs4sJbWlHB/PUjkE3mMj7PoTWBOnRzxMZnDZvL71QWxI4q9JweXo1?=
 =?us-ascii?Q?PjDJ6SH9I5v59jeUFite7ShE3QhvBvQBlxz2sq9E0A8iebwzdvGLH5f79tZ4?=
 =?us-ascii?Q?xTWL9VC640QbrZfoYLmjTnqwK+N2O98kitoZRrDyHXvwAEiFnVT1+pzcORGa?=
 =?us-ascii?Q?EdigAYR2NcoLtVhaRYLDK6789xCBk16tqDbNXxCAGtLKhaP9YXd9uNo4uVUb?=
 =?us-ascii?Q?VFhmRoUCBJq9ukwzP9cQnFHp+n4z8/Y=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff41792-2fb2-46a7-e199-08debd26c830
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 02:05:39.9125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JGH1O8IziqO0BU2CoiMS7AkBHvN6rVOZpygBHw0x1FPYe6jrjMvVDLEbNOXQwFZ5kW0XzKq10TbhAJpK5vb8/gQTnsADkxJGwRR39Yz1m48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0862
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,meta];
	TAGGED_FROM(0.00)[bounces-292959-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[motor-comm.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.954];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 275EB5FCCA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Set RXD and RX CLK pin drive strength while in YT8531s connect
with RGMII. Need to check 8531s PHY ID because 8521 and 8531s
pin drive strength is different, 8521 can not call
yt8531_set_ds().

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/net/phy/motorcomm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 688679457ef9..dcba50007451 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -1697,6 +1697,11 @@ static int yt8521_config_init(struct phy_device *phydev)
 		if (ret < 0)
 			goto err_restore_page;
 	}
+
+	if (phy_interface_is_rgmii(phydev) &&
+	    phydev_id_compare(phydev, PHY_ID_YT8531S))
+		ret = yt8531_set_ds(phydev);
+
 err_restore_page:
 	return phy_restore_page(phydev, old_page, ret);
 }
-- 
2.17.1


