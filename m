Return-Path: <netdev+bounces-297585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zRiFBPQ2KWrfSQMAu9opvQ
	(envelope-from <netdev+bounces-297585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:05:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 888806681AD
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:05:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=starfivetech.com (policy=quarantine);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297585-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297585-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA36730C09BC
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC7D3E2759;
	Wed, 10 Jun 2026 09:57:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2122.outbound.protection.partner.outlook.cn [139.219.17.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA003E2754;
	Wed, 10 Jun 2026 09:57:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781085466; cv=fail; b=UFi82lCC/NI446i6IHyo/fArgFsPi0twBesarhJbuVRKcAXWndZcaVLxWXAHg9SmPqPgCMVDFhnWLJQSnmwmpn4LsNjIBmsbHyvY8VBqFKXhNWcxZ4GtbBdDgL29/3SVEJy4Kp5WM9B5yP//L/XRRUpYA4BBpq9Ua9+0nVRDciI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781085466; c=relaxed/simple;
	bh=7A7KVgft2ue4eb9zKiDHikW+tlvjwHfl/XQsYG/ETi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dLRrMUQZDtIE/1HdmEKt3f5H1tsRAfx4CG5NpUjZquM7CvCnq2O+rkjqknDty9255MIHXTUh+b6hI7FmUl/fg1NhIK2iBNnN7F3ddvxadAEhnBUyB8CfMOZrgmnlYI1WtMcvw9M/ii2xycuBs9Y6HlQbtFLLoOrforJYoyP5xRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.122
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdcNdO5iiNm4OrOFjxv5MD2tCAwpDmELJMv3FXpMYaG9/U8AJcSWtXFsHqozDwTl155rkF7QgRXjIy79MbhYyim0d3QI16N5Cfur0CFfnaALSgqVVGDSd/wOnbFVVB6wrolTJOpzmTPnSX31fZyd1oEwVnlTCcFRlyGnHazOzKI7h+fNEyWxwPrDThrtyGzJ8mOuNVLLQRPA9P7Dq/DrFiDvhH6qCyd9ZI4lfKhjhXxUUli0/k1BaNgCT3XBNij8JPTQA6vQaFMlxLJdHfq0y14giYr9uGDrI2rm/A0bkL8iS9b7wfYvf8lwoN62fSizNIz7uwx44g741xHLmvikKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcEeQm5DdxCT9YGQcyHsXOsVRp1Z3YT5KA+ISTv0vl4=;
 b=Hj/YAxmos8PrAV4e5JRjMi0UnIuB9uv3Sx8zBlkFXkch5XbVuYlddHD9icqMssDuMcLyI0XFQbqyoZVWxY2yrvHgiNtgB5reEFPbQTZadvMNwfa2/RG6QhZ4s8mh6am+zk8krpgAZe819iwC0cRBPnDXTcQER8LnkbgDj2vtralHfYseyXX5RTpIYAoQJdIk7+JjbArJJHudz4nTJ/AAty6yIZe1c7gjND99Ngze5mVZt/vs0kv5dItFqyYDKxC+yBkhcso621TfwJx3m9HjvnqMQVJOoSd5e6LrMVbI7ztYb4ICiKtdIlqaVsBDot598PcjsgFrlVvdK4fUu59Y4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0512.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 07:24:32 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%3])
 with mapi id 15.21.0092.014; Wed, 10 Jun 2026 07:24:32 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v1 4/6] net: stmmac: Add NCSI VLAN setting
Date: Wed, 10 Jun 2026 15:24:18 +0800
Message-Id: <20260610072420.64699-5-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260610072420.64699-1-minda.chen@starfivetech.com>
References: <20260610072420.64699-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::15) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0512:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea83b61-68bd-4287-89fc-08dec6c1510c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|52116014|22082099003|18002099003|38350700014|921020|56012099006;
X-Microsoft-Antispam-Message-Info:
 N2UYCamWLi8kfLNvctwz8tbHbavysmPtdg0bGatJb5/gvfKmju6y+r6Omm30DdLnDMOHTGXWyJ/BN+o0hKTum6I4TFt75inJwWsR1cnz4HwPP9NIY7VBXXk7b3xcVPSxqQt1EPC8dvyapwBY9gyZyz1RND5fbCcuTIm2OHPRVLN+XfREVIiNdvwjs4njZtFf0N/Aj9Bal3agk5hkBXu9dcZ3NGMkqQDUYd4zceSza1A2JuaVR6IjaO6fLyV6X3uf4OQfU6eDX25EuKTU1lDomiW1+Ya/d3yr9ig7znTtbugJzsbu9hZ/fyPiTYJevOWuHgNSTLjoIOE2PU70Gr5P0kJjsOuV9I2/VjV7nrEMCYE7vvNuHR4HXBFRH4YhslqJSdSmmRvXowjDZHypBvO+LH5ENi8yMmuqFEGhNQbv8k2cV7dwg7YZw22hSJUFQsE8/jeSYbU41EDTwBBhHjmt3Oa1tWs3oIRX6K+0C60kTJ1fEb++nRciAcyAd/Vn4s/OzvWd7a+S2Zejt69RfhqqATDjlyiVjLJmKyYx971vvt6otUeQxZwy1uzFnYGhyrLeV4C7abmlSoqX40y41MCM4w==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(52116014)(22082099003)(18002099003)(38350700014)(921020)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?NG9Jt8yWfgB6anf1e4/6pJbRxvY7EpvpUDjYTnaU+nQgTR5bD9PMUjWWeecJ?=
 =?us-ascii?Q?OyGVZ/+Vye8BSaucl0JgzXr095g1bnqeodlHiEZJ6sxegNIR3mWri6KOc4OB?=
 =?us-ascii?Q?ZM9ldswESPKo9qHSxAeTA1DW5x7KF1cNQc1/tysQPphRudNp2NWt43ZoI3vq?=
 =?us-ascii?Q?t8muQl9t4M5NDkkfK7qBuVj9wXQqJu3/k6wNNZBr0k4i4Pr0t5aBswt51w3i?=
 =?us-ascii?Q?HlhRMSVHc0Tg2zAei2zWNFixKmAorqz/Yt+d70LggwtD7Q0DBfpaXQIDKM5G?=
 =?us-ascii?Q?dxUUczJB9e4U5BTMnCSoN/SL1+K7HhSkSdASntvQrTXwqAqljEg/1TxHbQt7?=
 =?us-ascii?Q?VUQw/TokjqfZNe9H1fS9+Rl6C809QoIXJhbJ4lfF4qXDBV4vpTf3EbJRJesG?=
 =?us-ascii?Q?xRx7zEbTtis2gMKlJEDp38N/3PYMLmEFfXaDbtS4Cf1tDU9xbvFAdc8oJohE?=
 =?us-ascii?Q?O5shTb3ytN3bjamZ9thcUmVaXO77kckYcInJl1xH63PFHyOzYEQZU8EfFgZ1?=
 =?us-ascii?Q?NyawEFAoooCNGl+negCVM/2d+Kx2UUCQ/ojtfDLAq6ddHBNhepcZZGQRR2x5?=
 =?us-ascii?Q?etFyEi9/JnYz1AWzvCPsCrp4Fj6blstDsRuNI0onS2gNF//1gLMVJi82dy1m?=
 =?us-ascii?Q?Dkm2iJZFOIlOqaIxi29eYO8KkVmGqk5EPThRVON2vo5muWfHPYe6/D3nXvYw?=
 =?us-ascii?Q?hTCJnPyQ8drQ/fsEJ2BAjKI29s5GHSiDnC7z/KjbOS4yEF3HcLj3QbHLoWq7?=
 =?us-ascii?Q?9HurUEoqC0Sf5ufJpTpVFvjLk8+8qwZ4jbIGuE7YFSuPyNrL6H4kfmKOZ63K?=
 =?us-ascii?Q?s14tOzDayTv5X6VyMLDPQZ2joqqDVzRz9Coobw7PHR9QMzumxLVEjWVBTS8w?=
 =?us-ascii?Q?7xc9FdidMFABifPPJ2RSKhORlCUR1ohr7LEKPLlfyGLHnF7N8CQj7V4ZuemS?=
 =?us-ascii?Q?Z9xr4SM4VjpFUIi5M/56ZKerKy7WPuJQK/IyoF4qDwWWdpgEGMU1NjOTeVjW?=
 =?us-ascii?Q?c9B23OFYRMYB+IK0xIYMq3ttIdcJvm66N/TVqYXFSknrDwF90kHpobH9yT8Y?=
 =?us-ascii?Q?VzyN9UfCBl8ILaGjksFy0sKXgNxuWWRNGWZ5jBPJdLlGt4dk7okWgj0drMD0?=
 =?us-ascii?Q?MZoPhLepc6TFgdefoYDRCmM0LXYKqv04bzqdw241FDIj0Vw62vpaythV0Y5p?=
 =?us-ascii?Q?m+9eJC6YjbH18L3iCfUuYOn58D1SJSDrMYi1wV3XMjAcoznyjOFTMhIqAkzJ?=
 =?us-ascii?Q?Re0fgisB+aExD2gf3uS0aVTbWUzGw9onVaKD41vxIyQWUVzs5cSMsGpwndD1?=
 =?us-ascii?Q?p+8bGJd3ab74jY5CMMSVDy/5O5Xfd7om7//dJfk9Q9JE+/m7JfFkQuME2HJ0?=
 =?us-ascii?Q?+igFkgueyTto22jPFlIsxDSkAxMpcCZ8ilsGN4wVLvgxeBiKq1qV9JI7iv4p?=
 =?us-ascii?Q?rLp/AhABPeCOox38ISCR3pMpaU+Sxz5gO52nQ6xj6PSBSKEl5vwD7rRagx7I?=
 =?us-ascii?Q?Xhg1SZmgcyb1W7jN8RkNgjmYqxa7Arnkj8eUCKPOkqZiOhtBU4/GK6MvO5mI?=
 =?us-ascii?Q?ovNkZ0Kbd2R+KgyJBDJIy5hsYk9nIfD2odyw06DZB9pFQ02ZLxIXKNbEQ5xv?=
 =?us-ascii?Q?vK+RB+//cRzqtajGlsBIX3cSFZTHxpa1XGGxnGEpbL6modS30oGrcGeYJDzj?=
 =?us-ascii?Q?THgWRb86OzuPzGq4LLTS+IYT1Ofe3BWbjaCfmLAK6IG5FMWFfAlSSkqFDgy5?=
 =?us-ascii?Q?3GYtnFbv3KoxXJELMRXkbOzI83l5qgg=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea83b61-68bd-4287-89fc-08dec6c1510c
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 07:24:32.4963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfWjy8E6tY5496EKO53T9pTnlBBz88PYp4NZjoyq6AM4qjKDtwaihUP87mkr1hhZ+MmeU7QANZzZWJeuIvJfMl5hMfVtKmbCehECNgZBALE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0512
X-Rspamd-Action: no action
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,synopsys.com,gmail.com,armlinux.org.uk,st.com,foss.st.com,vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:joabreu@synopsys.com,m:mcoquelin.stm32@gmail.com,m:linux@armlinux.org.uk,m:peppe.cavallaro@st.com,m:alexandre.torgue@foss.st.com,m:robh+dt@kernel.org,m:krzk+dt@kernel.org,m:conor@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:devicetree@vger.kernel.org,m:minda.chen@starfivetech.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:robh@kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297585-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:email,starfivetech.com:mid,starfivetech.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 888806681AD

Add NCSI vlan setting while in NCSI cases,
The code process is like NCSI mode in faraday
ftgmac100.c.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b6af53783883..b8ce04d71d08 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6866,6 +6866,9 @@ static int stmmac_vlan_rx_add_vid(struct net_device *ndev, __be16 proto, u16 vid
 	bool is_double = false;
 	int ret;
 
+	if (priv->plat->use_ncsi)
+		return ncsi_vlan_rx_add_vid(ndev, proto, vid);
+
 	ret = pm_runtime_resume_and_get(priv->device);
 	if (ret < 0)
 		return ret;
@@ -6908,6 +6911,9 @@ static int stmmac_vlan_rx_kill_vid(struct net_device *ndev, __be16 proto, u16 vi
 	bool is_double = false;
 	int ret;
 
+	if (priv->plat->use_ncsi)
+		return ncsi_vlan_rx_kill_vid(ndev, proto, vid);
+
 	ret = pm_runtime_resume_and_get(priv->device);
 	if (ret < 0)
 		return ret;
@@ -7943,6 +7949,9 @@ static int __stmmac_dvr_probe(struct device *device,
 	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 			     NETDEV_XDP_ACT_XSK_ZEROCOPY;
 
+	if (priv->plat->use_ncsi)
+		ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_FILTER;
+
 	ret = stmmac_tc_init(priv, priv);
 	if (!ret) {
 		ndev->hw_features |= NETIF_F_HW_TC;
-- 
2.17.1


