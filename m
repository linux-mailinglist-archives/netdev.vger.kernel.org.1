Return-Path: <netdev+bounces-295642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0TVoOoxoImoDWwEAu9opvQ
	(envelope-from <netdev+bounces-295642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 08:11:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF6E6456AA
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 08:11:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295642-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295642-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=starfivetech.com (policy=quarantine);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BEE8F300F5ED
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 06:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9193F39F5;
	Fri,  5 Jun 2026 06:02:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2139.outbound.protection.partner.outlook.cn [139.219.17.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242F33B3C06;
	Fri,  5 Jun 2026 06:02:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780639366; cv=fail; b=d2+nvk9pV/047a5+JE8+O7MdEXwnnOi3BfDTSZVJ7yygwqSNDX9j5uf9D2rzglKTFCHhYguYD2kou3F27p6rnWVccKHIkR9x4IzUYUy7nWrsH0gx1vUuz3PSFfe7fm3/cQ77NO8+z2xsW5WPQvZeK+CU0grms0ylwXEBj2c7xzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780639366; c=relaxed/simple;
	bh=3329eNo3s13nuMkpqq1IhdY0a77mjYnJF2bKFRT1lF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c2dtvtu9ksvwUrTnWNrXc+fc2bD+KnotAL0KBVZks3nlMYvoaUHOs4yp9xFMFPYsEC5u+/rSLv16OXKU/tk3VvsBlEfJS/76RKJFVN5EJF1k+OfNIyFYdD0IoT0sntjSbk8/zZpgtHQ4Pfdnklr5o1wxXzc+3Rkjw3IoOPYUeXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.139
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWonjfexkdY64YRAo65aadM6ryQQIVSKRXtAah+5vdrNxQgZj5akIeL+L3Y6PGvvBenEnPAPaIm3//HcqFcmHsEI/pIdxKZAvLXzMYFwNf4C3cDsYFVxp1FC0heSCqoiuoZdTBWlro1Ztx3ZVQc1GqpFx4LN6sieW+73jC0ekZMVlp4rqPQ7VGdbVk1qCOAru3lTDXzoPpopjldAkwG2c5RQawXSFJ3Tpx0/EL25Yf9kRmqZcoOzvr5BnN3CoY19DNP3mrvOkfFM5QFRWbvGaziRfS6B3kNuwTE1QPX/U2rw1SHRHXrxMREQ7/GPjgPLbMFZumgFEM5e+ZEOfCVMBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KALmmW1o9tr5miSgZtpu1ZIrhPWpRU6gsN1Vz5XyRck=;
 b=JDIHzvyKLbShcBrwA7zcq/iomU9OW8OVurqgq8+NYIMXqZFc0hkJBBs7uvUpnJHUVjlexT7C8MFuDBu7ZyCpcUX96xNZ8JL4+v4Nb2ujCf6w0clLyYDF9gjT8Qsf5DHA0PMgWzZrM83pz4hDq9g2mEQaLlhIOeFpPHH6Mcdki1+wOdDBX8BtfcQJ6l3681/ZIACGGklJDeX4frf6rD5LpJu5Wb7xybWfmoDhbCQlXgd34+jEdfq1C5a49BXfC2GqduerrOCUN+MLzJEA0bfqlM5sYCQjaJmvJlnajHd9hLwHPiiBROGgeASaCZPV2P7ktsjEZr6LJe34hfwWldbwEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0542.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 06:02:20 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%3])
 with mapi id 15.20.9891.021; Fri, 5 Jun 2026 06:02:20 +0000
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
Subject: [net-next v6 2/3] net: motorcomm: phy: set drive strength in YT8531s RGMII
Date: Fri,  5 Jun 2026 14:02:11 +0800
Message-Id: <20260605060212.41895-3-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260605060212.41895-1-minda.chen@starfivetech.com>
References: <20260605060212.41895-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0026.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::21) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0542:EE_
X-MS-Office365-Filtering-Correlation-Id: ec27fad9-e5a7-40f8-6e36-08dec2c80177
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|52116014|38350700014|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vUJOl/D8GDEBWLFi8Da6zREaHNfjITiJ+RIYEPxOw9PtztNnhsKcTCkE45WxRy5uj8EcTpSNaIoGG9kDfi+IDTmX3XLNJfQzKdDOS9k4tra/iOO+Vv78MC630krjhjR7RS+wVpfyUObUUfXuGjr1gjRGi5zbGFuF+fam4TrxRtax2je1UYGuwR0MdylIZooDqlJ5da/Dl4ad9ZeywYwa6bfMtCedddR5d0yR0bBC5GX6rYX1S9AlOzAtUIQ6epFYOVEWjl8wNEieQsteG38T0SfxGNl7SxIJFdrJTF6IUokjAi7BXJvYv4E6poXqdGiBX4RHz7wqSWRH/OYZybdkOKnQsmgKRg7X95Dpqls7k7oaCkm1fFp/7+lHt3cmyFB8uMf8S8/cLOulqZM22g85Lf3PBNARSlAUGaSSDsqnuYg6kWtrbcHWOUUf2X5l4sTqHuYzoo26J6muMKbBV1QU+ioxjZJE4hcDpyKeRzwwxK/QE0K22N5Ficaz9WYasT4Q9Vuyz/SH11K493Qtu0Yaj5S72+ZCM6UHjWP4Rq5+6i0SPesuKtziX8hTIAYHJ3/q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(52116014)(38350700014)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uYLWaQEPnP4cgBHnL3fDIIgorYhkSxLDQzpBQ4bY525TVIQH6pxukNkXuU79?=
 =?us-ascii?Q?MkpJDY2KmxDf+r5lb9vnHZC9ITWV/ykGOUnI3eInOZsnn+l/tWTNa1bDefCX?=
 =?us-ascii?Q?SAC0vya+OTdVoaFS/Uu23zWly/LHN9ZhSajlA1KCjJCY8kxqI7hpymJHfq3F?=
 =?us-ascii?Q?7K5gfZTruFnS7BBWYfyxFs7HmVM/a+v/2SNwYbp/zbTi2AFNgJB5wZPbGn/i?=
 =?us-ascii?Q?37gcZLOI8AdUinHNsT/Aywp1GznTEIBqNQOAQOUGkuSamE3bXm13GE3OtKbM?=
 =?us-ascii?Q?EpO7K8Uo7puAAryKeJY+keMDmlfu5ZjkMNeQiVm06nG16okSD2f3g/+KCrV2?=
 =?us-ascii?Q?PrOOZiJ8XjIsr3GyJBWYUWVkz10yym6Bok4HwaRwfXJ2B2bGR4yba0oVRu9y?=
 =?us-ascii?Q?ITK1X5RRkrwOwW0M4v15jLAMEI2Zy2pim3TPsPLOfO8LmhiYjqykgA1BVMEh?=
 =?us-ascii?Q?eMY9xlx6LTgBvXA5ay4OGuY8iOXlNxiFPZm9hIYE26XDy2Nqn/ko/82J3vI0?=
 =?us-ascii?Q?ykb80VzUXV70WnZ1luKd6IiQVFoX/G4hMha0dlHX4T7sRnoxVmVoqTkuEu9E?=
 =?us-ascii?Q?rcvwcQNg/sVWSOr1efIzPllY07dW+sOD+h/NmWyzY3LAcvp8R6wBQCUVjcZS?=
 =?us-ascii?Q?jj5GpUQ89VK/bpc0Fwv9rbuc7sdjWv0dcFOAURzSkrd9thFuKZ9i7BVgjCXG?=
 =?us-ascii?Q?0qGf7xC+ibFrUL/nlrFyaA8wRtU5A4RDtcC1RzjxRN2uWFaN4ncWp3Yuosgj?=
 =?us-ascii?Q?DD38eR/k3jiFZLij0dqf6T3K/Stykoh5skd3GAjRPx/IdCKjTU+xVVH46145?=
 =?us-ascii?Q?kHjeDbdv+TJZ/kmLGitk1fWu06sT4cbz4shRGYyoVF9tTVnQp9TDd65DSLnO?=
 =?us-ascii?Q?TUIqByWOpt7HUQOrrRxVVVcT5T9zriq/BOkLqk/n1FELKOynmj08pLuYCU4R?=
 =?us-ascii?Q?gaFcieRbAReEGemNeb1A3eK42NOvAsaF081MNLifbviWE5vubYlqPv/FzsCH?=
 =?us-ascii?Q?D9pbO1HiUibyG2ZCgnCmQmlTsHAQUJHKJ+IRMlJQbQsPlxARpWXrua9K/RGx?=
 =?us-ascii?Q?pjDPpy1ZLngSDYNXGcmm+rXIEPGm2mzXB26Qa2h9M2c9elP59XyV6weEYACg?=
 =?us-ascii?Q?GynRXiQHmtHKVVuM4oCH0X8sERnlcgF/Zhm4t+iIAA50QjQ/2JukHFQ1BtqO?=
 =?us-ascii?Q?rFgMepZmx6XMjt/s3jgh6emwF2n+zrCGtCKRFnhOj7jdC0tQ96sU4E5Y03Gb?=
 =?us-ascii?Q?7GEfP1I6rssDQIEt4KZgGCuasuGle2a389TXLExlrkCC+SqFgzBH+jwO7+1n?=
 =?us-ascii?Q?4Gl+Rjfm25uR/SuTw/cZM0JJcC/4ECXoGZI33g/hyAQScna0wt7IjnQj+71m?=
 =?us-ascii?Q?JxtFQkVbh32V8dbEsJRkIvx6hymib1gISepxSjeQ4QrLIKmBgJb+sCgNrORt?=
 =?us-ascii?Q?zBNbfBSvgU8zkuA1XdE1zlGYpDa+8hu5W3ibolTvKLaXTdue95iRAJVsKUeV?=
 =?us-ascii?Q?svksusxlwSAypZ+vnDiAdL/r1qxa+bJuF5eyolKUrNe4bd+U45Iqd5VSoWCy?=
 =?us-ascii?Q?lONyI6Ch2Cg3DjUzVIHu24eANRC9zFy5kLN2HUZZ96WB4mrWNzGRQZdcwA0Q?=
 =?us-ascii?Q?FV7C50MN57uE+KXSn6om2fUjc8bNO+KYXZuvLqM8pToOCJvoXP5o+FUNQeLz?=
 =?us-ascii?Q?B6/iwKEv/bfFcNn+dplZzQbcYSpKiYfEc7aJFryOrmP7HOYXlSMP0hAJFoVD?=
 =?us-ascii?Q?1WtdlCrFlpw85ZPAduKH/lzVPLmlA1w=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec27fad9-e5a7-40f8-6e36-08dec2c80177
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 06:02:20.7894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: no2y8Z2QeVBKZC/Sg5a7bga495Nrt5ISEr1YVtQnFzrCGos1hzLZqkwGtua50XqOuYHFxf1SNbOtiQlP3E9nk/ioVQFeYTKXi7DlkifQz9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0542
X-Rspamd-Action: no action
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
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295642-lists,netdev=lfdr.de];
	GREYLIST(0.00)[pass,body];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.Sae@motor-comm.com,m:andrew+netdev@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:minda.chen@starfivetech.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[motor-comm.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,starfivetech.com:mid,starfivetech.com:from_mime,starfivetech.com:email,vger.kernel.org:from_smtp,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CEF6E6456AA

Set RXD and RX CLK pin drive strength while in YT8531s connect
with RGMII. Need to check 8531s PHY ID because 8521 and 8531s
pin drive strength is different, 8521 can not call
yt8531_set_ds().

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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


