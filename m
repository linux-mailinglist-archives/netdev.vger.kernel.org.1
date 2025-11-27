Return-Path: <netdev+bounces-242261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD9CC8E32D
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2243B0AC5
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 12:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D2032E155;
	Thu, 27 Nov 2025 12:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZnA8cq+S"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011004.outbound.protection.outlook.com [40.107.130.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C483B32E73C
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 12:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764245380; cv=fail; b=BKcJ/cho4PFAz0wihp4AG3B2htX66eLhpjgXz+PTZ2p94+aMwqq2wZdU999bHXoJlPQro8KBzwdGMfGfDdVn6auoUlbQwBDMqO3GBZsoSxLVFv7T5Ye+adPEQEcNox3N1SE2VdTGW12MKR6hKwHyS1vG9AlWUVqUUaFm5nBQK8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764245380; c=relaxed/simple;
	bh=St6U6vQXjFK0VnfkuQR7WC0JK7J6X7qmc+mk6GTHNiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YlIV+PJNBbz4Hhx9WZ0ETFxvwMarRYVTBkmhVMxJiwZfdLXjXSwuh4z4yKaLHBd/x6zMBCmHOsg/6T149LrXQaMaUOqGZKgxhl+UsYXUT3iAP7o1lg47BU6GGRUXmPXmZ8x41TDyzlO/lJ+Jf8x/yzPeyFHwzWOPSL5QnxQv804=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZnA8cq+S; arc=fail smtp.client-ip=40.107.130.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YabxCtNkuubiPuTVNmY8qiGjGKhSER3gn1H33CblcxImKwn8PfwiUzL/d878rmN8WtmvoJlQ9wJil/DM/1L48VCgS++kYp1la/38HhpZx+ilM2acXYHFiXT6USnZZz21B9htVbEDn7nwrlXT9C3NHZNCbsDAXg5gZR57E6fy05CYefev0rNx9nZ7V9Fu3N9j7Bq+WKq+IhXsHGdB1lV/NCLArfYdSdwnULu1cx4nXqnCV3eYxzAozZJ4EtPAY0vD0VV95NObJumHFZ8l8q5xyqb/+SnOfnPzYhcXtVLIBhl2NwznZEVOX+QwErU9NxamCuvFZUPsigtqyIAGB8A9Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCBpVPRIUJUB1H5GbS1e/MjcKuUhYSsHL5st6wQkH/c=;
 b=gsAakA6djrFa4D5AV+AO0mvArpoA/ZHWNALyfVxdEGNU1Gv08otM4lZQVM0YUqIBZbDGT/xsUCSbfP5Q7Y1WGHLVKmOcNH5fhyT8Btzn6Qei3eNXWZqLLSnn86lddnGh011Dy+X5Odd4WKsOH0b34myg1PfbSn/jH3f9piKURmv/sAXYd3wABOs474n7h0ryugpyuxwY3cGmlJ/9EUUMLRAaYdTz2gkfzBa8T2KbnvFFwvw6nMSe5cZttYTTg6lUQTKKZKmDP4OhNUz/rQn1Da0qrmUrjj8rts+5Lj+3nIRzlW4Nr67ya3+tro5tn/76GdCzLgewtSIulzWSu8ZGsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCBpVPRIUJUB1H5GbS1e/MjcKuUhYSsHL5st6wQkH/c=;
 b=ZnA8cq+SIYPpW9p65e5an7OvYcJXAbpp8OYg6/dPke3h+7ozjeQZopw7sVC3gFJ9GceHYOAVM/hjkDK9VUjVhgr3CcNO99bVsAXpb6PgHcP8u37SzgnWjDpB4FtFSkgKBvrPDSHxWK5JuwkiK6MvKAedvSxdd0ON9B3hpgmuUK4jo0ierG0g+x5ezP2ViMJDHn7sZ4TvMbgSt0NPyuo6PxZLCCxKaHKv1XIxc7tvJ022056yA3+GBAb2VZY1eQK5M2qitRMRqOQCJNFaruWeII86RDxgCt7N87iQRNaD09kPYy3F6rNYZG68zZnx5LX0XZIXpOjvi24GmVZGvfCfBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI0PR04MB11844.eurprd04.prod.outlook.com (2603:10a6:800:2eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Thu, 27 Nov
 2025 12:09:30 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 12:09:30 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 08/15] net: dsa: tag_ocelot: use the dsa_xmit_port_mask() helper
Date: Thu, 27 Nov 2025 14:08:55 +0200
Message-ID: <20251127120902.292555-9-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251127120902.292555-1-vladimir.oltean@nxp.com>
References: <20251127120902.292555-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0056.eurprd03.prod.outlook.com
 (2603:10a6:803:118::45) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI0PR04MB11844:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dfe42d5-188b-49d3-0f75-08de2dadcfc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|10070799003|19092799006|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q6brhyBoi2UVlXkqhnJGxGQ/lARyAjnjN1Zphlv+k//VdwuMeUnJT6wUb8QM?=
 =?us-ascii?Q?gfsx6fUxKPM/rIrT5Cj7prmm9XrVtVeMe51+1d3auCWIrDTyjwEZOvu20TfN?=
 =?us-ascii?Q?xkcxpWUpGJ4jLDWd4OZYIqXgTBqP4l1wG8z+qizESIjWKBScEZeAj8mndyxw?=
 =?us-ascii?Q?4Xio6ggAV7ujgfvpkUXBou73s2EKhflJ/0FBfcul7zJAYhk1+X4/DevC3AXL?=
 =?us-ascii?Q?j6fAMufwdTt6nEgCoOm9eq32YEzSuX2liAiUji2QbHo/EkgD8pqVk6Xa8mDE?=
 =?us-ascii?Q?/AArCZGD/64Q3uVDq6mH9FdM5czqKndwf55BCRIxF+KiOfSblN4iuAHXeFn6?=
 =?us-ascii?Q?vEIsr6TpL+/uqSgzQ3D3d7Mh3GY4v8tLUcwYXsDCaFjiWcBMx/5EqSD4B4pa?=
 =?us-ascii?Q?cvybrbgPA9RCyebTEU+RponlOFye754HnuIDI5QZ670cpITqrxnFyrvGiCaF?=
 =?us-ascii?Q?94UaWJXV11HL8wMpauoul6GveGuq+PVPFrjdqRKOZ9C8iXHe4+i3yFgsoHtq?=
 =?us-ascii?Q?mlj7nfj/5H+Nae/+naLLIDzYwGFVzVo9Au4uPQFB1leIoPuqWywKEVkjYl3C?=
 =?us-ascii?Q?2lk3zeyX/Fqqn4WQp3ar88g2wq+hYW0+DvC29xqEXEwB0x2kwygLaUrb7fMm?=
 =?us-ascii?Q?tlr5gcO0LgyrIdxt83YrKjjleKPIOjSQHhy4E8A3b5ysBw9sRNrd9cehCVHB?=
 =?us-ascii?Q?p6aMo9R17Ht7YktRfuBYonk21E/utB5aLFvZ+GX6cqA+Pm9bhcmqMTcOEjQe?=
 =?us-ascii?Q?sj9KS6xTgW9k1fan4ZAIGjDtsTdpbuHKSfSMi8xxvmYXugFrTTpOyy+KeDeT?=
 =?us-ascii?Q?nD9Ro9H0HdlEWqi1CXO20liPu+ucnF5+RVGkfFP0P/4hGMNqaEdenq9a1x+L?=
 =?us-ascii?Q?AWGEJTOikoHsDAQTGi8IuFjHILBzz2+QDWXc+AirUdpw0m3NwmlPiKW02vit?=
 =?us-ascii?Q?Qj90MC/WzOeW/6PjmdYRo4BexJWRv0BzZBHSi3qHUN/dkAlmapNITrebrO5a?=
 =?us-ascii?Q?GwCmdg8xguuDkw9KGIqRelXAmiavAFHeHbW7ynIwAfPgbtd2kHV829GF0GM1?=
 =?us-ascii?Q?uB7w64K7pYW/Og4L8t4SBva6QnAyN9pExlbYoHIXN8KaAbcTgVR7HNArZ+WP?=
 =?us-ascii?Q?MHND0MwnuncoFUybgayD4lA6fNMbv1BpbAE9QdpMaKldH8psQuwAq3pyNsZX?=
 =?us-ascii?Q?CY/D58fcrOLzNWYWm1yJptCfqxkgao6+0i4jFzKu7vEod4IurcMz6/B0zk2g?=
 =?us-ascii?Q?5g+i8XHzrcvL8YqJBcLZk9az16HV0wZgxBS1lU/38PKBvbux98pWAxv+DJtv?=
 =?us-ascii?Q?xL3p2SOjrBLzJDxl/5wSgVUVGHttMQmG0sr1rId3aKtFT6oq1Xp+7oh7PUKG?=
 =?us-ascii?Q?Wv1226OapA2kDUKNL2Wd5i/mUSgoM6CQh4MwvPtmgBIMsZtXU5LCYh6I3CNx?=
 =?us-ascii?Q?3uaPD4bR2RALr2YKw8cMMb+/lKxv5AVZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(10070799003)(19092799006)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1xz+Q5eAjBnZ+gUPN9ANu3f03i0KW/vjSRrBpqgGvKwj0Y0k9YDzqdZfwsDE?=
 =?us-ascii?Q?/wcC1CZjKeRV7wngBC9++KGSTBub3DLZ8DxAaVzBpBnw89lmOSuE0HsOuCh+?=
 =?us-ascii?Q?5nqpRJvsXD5CsZPCMGL3dRdcouUEbuGuq12i2w8ieAz7ABqNaagtTxN70TUJ?=
 =?us-ascii?Q?CnhGZBtRkiThqQXyBatRjphrzbDw5wxtJSMrHwZr+xZFv8xxPLmobsfR9qkJ?=
 =?us-ascii?Q?+kZj2D/qqs78D8PiG6OTFalhoxBTPUx+cSbT1VvZVZux+DXflLXRcKARb5dv?=
 =?us-ascii?Q?VdSej1WN0OpKqwWFACEnFQ5K+Q6R+kee3xXmVLF1d5tJJl7Fo143I/g0w5EF?=
 =?us-ascii?Q?pkwNsPedXaJpoCXu+Hc/oTtyBCbVpiR+0VUXNsSfL2uYd/x68lS/J2nvCfU4?=
 =?us-ascii?Q?uu+dI8deW2BC+HoNDGbiRPe+qLUuuks+TPWqKkztHf/ZKEf1A+9+0CngnTTY?=
 =?us-ascii?Q?AeE7cHNb4pRkXEpUT8pHmxOHOT66E82wjsWE41d9aYwYnlInfd0yFIKzqrNK?=
 =?us-ascii?Q?F0FXrheloDojGBIJ+tCc+rLFpvcG0HCoQZ76SD51mrzI8q+sgH0llP/UMZFy?=
 =?us-ascii?Q?k/4vJYpv1YGpmiiwte8F5hi9Co6CQz3gaipYq0qN3Msi2+zwjYultke4w3Rq?=
 =?us-ascii?Q?CKLsNsKF1DfdfFbYZ1QnpQUpfZneVnhur8WEzZ4aIZPllfwdrm7vteMEtM/7?=
 =?us-ascii?Q?Hdo4etC6jckf3q0yw7BuFnN0+fJa1CJPgrtD2ndKuQrabGlnpapZJSHFdMcm?=
 =?us-ascii?Q?dU/97UZ2Aq7lQIYFf7tq0CYZscFo5j4lY9NT+20+5sElZjybeBE98neffNR4?=
 =?us-ascii?Q?SMBiGx5c9dxSxxJ5ZYecbCb/unFG6lgy0lCQtpbE182z0N1DyQOyoA6c3T9N?=
 =?us-ascii?Q?9S/atfJ3EN6MgWai202CMMOuzXW4QocIG5jdrVk73jVF3EEqRZxsCLxFmQ85?=
 =?us-ascii?Q?gjGOJbi4AZkww2yKNpcdcjdii3NClgXbCaOzN+KV4LtmyCWSLxHOzl3X0TzX?=
 =?us-ascii?Q?XZ23+5NYelTF2Lj2hPNJhVlyBwv9LjRxstb7QGmUer+pbYLrg0Y0dxkRfDBu?=
 =?us-ascii?Q?cbVeLc7CMvUxeGdr30fPhqnUh5C6y1gwHNCwV4p5PqolOZCsnjdMYFXUDg2b?=
 =?us-ascii?Q?6mOCFwpowmsWdlcRonsErPAjzEZBPniafwt3W1yClODnrfaTAXuQVRkjAakB?=
 =?us-ascii?Q?gLGjWi7kiHuMu89psAGX9FOGL7InlWkbfCpgRyJe0+mF+1X1UME/AHW+VtJ+?=
 =?us-ascii?Q?YmQ+nkHnz1b6t64CuWoOYJmXGiO1tNBMpsZUdBT20mAAG2q6XocB2OGrL/TH?=
 =?us-ascii?Q?CWFDsk+YBbikMP3bbCBpkfxdmDpag5oZS334dThdhSBl2WL3YKraIGXEctwo?=
 =?us-ascii?Q?CU0LCrwLGUGslQXxykSozMVFlBTLJt+u22k1afhgnVIcnBYsv0b5XVSlHlV6?=
 =?us-ascii?Q?9n9uCu/u0bnZDVYqAEDBqH3YKWTEaFZQ0u/r+sSPQXZe1vsqI6Wy1Voq+MPw?=
 =?us-ascii?Q?iyLRMZzmLGXnjRU5xXGUdDXfnkrH+jui21CBTwt8870lUhdbEO6sinxw75lb?=
 =?us-ascii?Q?y03bfxvPLBL+84hlAvwub/4PU7u8u3rLJuXvUPM/vzq2Mr6kiYwe9HmiQffv?=
 =?us-ascii?Q?rgk208Z+gDXzQ3Bc8LvR6YJmUUdulgLGbZewCFXNrKR9d9W5F4fB4aCIj5MX?=
 =?us-ascii?Q?zfzoHg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dfe42d5-188b-49d3-0f75-08de2dadcfc4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 12:09:27.3794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R4sfDqv/gRajYULQfBC9kt2+bbWJ/qFFpBFYJBlas0GPl5ZFIxOF4pMZ/nHDPj3EzihVgwQnWGLZAkYsQgi0Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11844

The "ocelot" and "seville" tagging protocols populate a bit mask for the
TX ports, so we can use dsa_xmit_port_mask() to centralize the decision
of how to set that field.

This protocol used BIT_ULL() rather than simple BIT() to silence Smatch,
as explained in commit 1f778d500df3 ("net: mscc: ocelot: avoid type
promotion when calling ocelot_ifh_set_dest"). I would expect that this
tool no longer complains now, when the BIT(dp->index) is hidden inside
the dsa_xmit_port_mask() function, the return value of which is promoted
to u64.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/tag_ocelot.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/dsa/tag_ocelot.c b/net/dsa/tag_ocelot.c
index bf6608fc6be7..3405def79c2d 100644
--- a/net/dsa/tag_ocelot.c
+++ b/net/dsa/tag_ocelot.c
@@ -46,11 +46,10 @@ static void ocelot_xmit_common(struct sk_buff *skb, struct net_device *netdev,
 static struct sk_buff *ocelot_xmit(struct sk_buff *skb,
 				   struct net_device *netdev)
 {
-	struct dsa_port *dp = dsa_user_to_port(netdev);
 	void *injection;
 
 	ocelot_xmit_common(skb, netdev, cpu_to_be32(0x8880000a), &injection);
-	ocelot_ifh_set_dest(injection, BIT_ULL(dp->index));
+	ocelot_ifh_set_dest(injection, dsa_xmit_port_mask(skb, netdev));
 
 	return skb;
 }
@@ -58,11 +57,10 @@ static struct sk_buff *ocelot_xmit(struct sk_buff *skb,
 static struct sk_buff *seville_xmit(struct sk_buff *skb,
 				    struct net_device *netdev)
 {
-	struct dsa_port *dp = dsa_user_to_port(netdev);
 	void *injection;
 
 	ocelot_xmit_common(skb, netdev, cpu_to_be32(0x88800005), &injection);
-	seville_ifh_set_dest(injection, BIT_ULL(dp->index));
+	seville_ifh_set_dest(injection, dsa_xmit_port_mask(skb, netdev));
 
 	return skb;
 }
-- 
2.43.0


