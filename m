Return-Path: <netdev+bounces-139115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8EF9B0474
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 15:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4087B21AA9
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 13:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4721632F8;
	Fri, 25 Oct 2024 13:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ekinops.com header.i=@ekinops.com header.b="h9sv4XzH"
X-Original-To: netdev@vger.kernel.org
Received: from PAUP264CU001.outbound.protection.outlook.com (mail-francecentralazon11021079.outbound.protection.outlook.com [40.107.160.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB51A3A8D2
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 13:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.160.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864014; cv=fail; b=gdEwMKjalcj5HAWeOgOG4FAXRjAB+yCVIitU8NGSnuxcULWbqGX2Jsgix65tu/eGWPOa9KXs189OPcHu6UZTC8B755UXPxgPtQAYxrlfBPAcuABSO0zwLON2T6Kbug3oW+JKEFwD3nDQVO7HOG3uLx+8H/AjwiVGUo9M4UPMcE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864014; c=relaxed/simple;
	bh=OzJJG8dXRFIKPZyiy6gQ9v8bv4GUf/wd438Jkx8u0BQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=I14fv7Tjwbqo4QhvsoKhmJ0wb+Ps0JDmJowKtZTp1KUquS0zpD7dqTwQJALt/uY3BTZxnoxwfqKdmKGnHC427hSlkgAHCO6nuPjIMTW04RloNLw0V2xKKwC3StcRb80IzuaeOmTtceo8kqwfVmKq0UbyuU0fcyk2nkwHN0DOodc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ekinops.com; spf=pass smtp.mailfrom=ekinops.com; dkim=pass (1024-bit key) header.d=ekinops.com header.i=@ekinops.com header.b=h9sv4XzH; arc=fail smtp.client-ip=40.107.160.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ekinops.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ekinops.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZc8HweJr3yPW/5OvHjmKMQTRch6O9UcvEr4nt/Tw7OiNz+hWoEMxUGzF6G3m00YaIotIfkVRcEK+9xdcrYZBNU67Zqhb7LlJF+KHL3zDrQC8grvBMPlkHjY6FFxeRk8YKwi5+sVxxpVJcwg1RtcjpUOLixPOYrdX3SU2FxoCmUx6bi02UUzSHomdEdxBS/R7582S/QmtRD9nU5+bUNPwKNW+QRETZiOuvVP97EnwEyfG4Azy5v1VVBQ5taxpBN8YkR2GhZ+DuTQuCs8XJovt7bmvfDvb3vkM0QQ6dEqxMOBa2ej1i1ysevbxuS/Xmsh3MzZCmZu5a1gRag9C5+Bfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ko/PtOO4p06Rkg+7Ck5AXzSX2PRUauMGMpxcTsweqU=;
 b=dQ7qzD/PX4QsdBxArdfNM2GfHDDG6eGCO/5ELOERitUVB2vugZj+pY+YNqOHl9aIgmcqCrohBFpDJtUQEQPUQXjvYDU4BmHMg6NyohIOz9lfcR7+VE+uTVN1l8rrWAp64aghAbHmeai2naKQWDL6Sk/H7LZaY1EANwW1N4g0yzDbWN8uUh/YTb2PhbXbSprSP/O0FCYE8AtmM5m3bnMTueJQJNL/ibNcRjHt9OcYaZ3MIKZEhYfLUX7/X8+JM7rN1Dz7nZGBji0r29DSb3bAlkw6niGzX14eht+TPZtKpEetOeeDdGJZa5lQsl4L5V68yC1uF4dDSK3LElohayF0AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ekinops.com; dmarc=pass action=none header.from=ekinops.com;
 dkim=pass header.d=ekinops.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ekinops.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ko/PtOO4p06Rkg+7Ck5AXzSX2PRUauMGMpxcTsweqU=;
 b=h9sv4XzHgC4vWyl6e0rwnNlRUGOCvCsAy7B08461oQdf/BJWaDlVkOAp0A8ukTIWJVgvINp/80Lfgh2zie28JFrDbkGBlnshHlC+fMCjpfIlUy/cRg8hd7EJf7bviXPb/fH7wpXM9IEdCDnj7cmhZMjoqeXYeEHlXYCPWkTRO78=
Received: from MR1P264MB3681.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:29::22)
 by PR0P264MB1579.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:169::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 13:46:48 +0000
Received: from MR1P264MB3681.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1883:57f5:6df2:32af]) by MR1P264MB3681.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1883:57f5:6df2:32af%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 13:46:48 +0000
From: =?iso-8859-1?Q?Herv=E9_Gourmelon?= <herve.gourmelon@ekinops.com>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vivien Didelot <vivien.didelot@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH 1/1] net: dsa: fix tag_dsa.c for untagged VLANs
Thread-Topic: [PATCH 1/1] net: dsa: fix tag_dsa.c for untagged VLANs
Thread-Index: AQHbJuKS0axQvm9UnkuMCwF0pdBIEA==
Date: Fri, 25 Oct 2024 13:46:48 +0000
Message-ID:
 <MR1P264MB3681CCB3C20AD95E1B20C878F84F2@MR1P264MB3681.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ekinops.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MR1P264MB3681:EE_|PR0P264MB1579:EE_
x-ms-office365-filtering-correlation-id: b0c7e4d4-0d20-48f7-9eec-08dcf4fb78e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?B6S24IkRqSKczbsiTQoXB5B0TJb28VtVdzoJt6DUaeecV6KouL99PcWqNh?=
 =?iso-8859-1?Q?G6QGHk9+CI75L1Q0L+V4wKViazFN5pCM/3hk16q48dcOI9Q4fWTm0152YZ?=
 =?iso-8859-1?Q?wWOnVCEBDXmOBhjDKok6hhExCTBU/AIxBUPGlAFHwqv9aBH8JyIPf5aMTs?=
 =?iso-8859-1?Q?djfa3VnKS7irlKZoOOvN8JhfeILewifIPVHxmNUX37M1edMVj5K8g5+8Os?=
 =?iso-8859-1?Q?/j89e0yksAxyx9p3FeTmQsSWT0saT2z6EfN8eCOSMhaWZz/kvjyA66X3vj?=
 =?iso-8859-1?Q?60CQ8kydvHup/jyg9515hy9eMdd0VXj6wjxZ/ywF5j5cLJxBo9rWTtjl35?=
 =?iso-8859-1?Q?1huvP8aLvtW+zvjXfMyE5hD0Gr7XqNb+N/k1li33LcRLgQmBib/2OzF3Lk?=
 =?iso-8859-1?Q?TLOSGJtE8j22WWa4m/DZHwSoVP9ZLJViXvgb5mlmEUTadhFoTJCCz5R8C+?=
 =?iso-8859-1?Q?j9GMcESjZRSDh4wiLZQx8c7CLW4fFK6v5t79nYI0IPJbOwd2U3mBQCbfl3?=
 =?iso-8859-1?Q?xxjfd7R99ufOPLmiKhD2mZ6n3P2D59QH6xUQR+VfOFHsALaNwY84KjAS0y?=
 =?iso-8859-1?Q?bu0A1MYJZZF7dQpf72huKWTyHs7X2KqDVeSFGYc11GFQXsdnZk5PHP2cpn?=
 =?iso-8859-1?Q?Fw434RtplDZRP3iKqMG7QHsKDuXfxtZtAPQuGo9+klg69p7z0NnKUQ/sXq?=
 =?iso-8859-1?Q?RTUxqo4OJ+g9ST4lG9CjSGCllOKAyulOKKgkj3AsCbFdtJHgGsC8L5Aq5m?=
 =?iso-8859-1?Q?al+jY0q6FI9+vOCzjAGQcxj+xl/h+JWr/X8xWbsIvM9kdI+cSgDu3JlRSU?=
 =?iso-8859-1?Q?wDvSU/0B/BKtVbwRUJcGOwVRGJ94EB6Yi0SIP+JhxK/UZ8LwZY1qdsZfcv?=
 =?iso-8859-1?Q?gawzhNe94XUKV+PZB/87FE2CuMa5wbhB7YN6Xy+xJF4DNo4XfgNaiCeTJC?=
 =?iso-8859-1?Q?sc34+E+p3B40EYJDgrbnsRIU6pIEUAho+OvbNR/6zyrAJMK9yufsOOrLR4?=
 =?iso-8859-1?Q?K09fw8j2SwFjksubmRHiuUCOKpFLbrOVh90AjV53ECZqM37Wc5dEcQe0QA?=
 =?iso-8859-1?Q?V+Q8BbVh33J/BW8ayAyqzQpIYgtDzSbCOdsh1JDO7S7q+6l/cPGXJbTgYy?=
 =?iso-8859-1?Q?4PiEnSFeLE8JmkQ36X53pWtxTUHBhTCazI/YY2mMSBpOTjAr8YUZGTfCGi?=
 =?iso-8859-1?Q?iUaFky/sQRU5vPw8xePFTsQlovN06a2hE3msrj/lbfYLfU5x3iUXryCmJa?=
 =?iso-8859-1?Q?6tSTUWCOZb+ZSKqECKSh+AediShhdkIWsT+3Udw7sYaFbCPCAhypNmQNDP?=
 =?iso-8859-1?Q?7ouYiQLhBEh+29/bihrXD3aWJX6j47nF6xm4RoM6Se0uYzMgObvyuvjSNE?=
 =?iso-8859-1?Q?yAdD/jA8P1zB99YaTJZbG9uTLgvZTLSfseTJIWa+ZVA/yzzT0vhNs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB3681.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3/ussBC6aDecSrxH/Tu8pj6LS4P0T/8ynzgenFeTDIg6ROgwMEqCwhbnym?=
 =?iso-8859-1?Q?lZYNGpM/zxFLsDbRHygfKu+3O5/fUqrGI4BFffnn8Do5XRR4tU08R4ndwp?=
 =?iso-8859-1?Q?gC+d40UiFOT7ShoF0UcTgerZEoGXzZcy43rUbQDiyKffwBX9V1Uv30K+TL?=
 =?iso-8859-1?Q?b1i73v3B8ofae+XhCIBRYC+EOBaZybC/wQZo8F2oB27JhMEV5wVIvkdfg+?=
 =?iso-8859-1?Q?cb26id+5XglhEGC+ykcRiY4t9D8sWE4Rk92gvGEI8ccieVSw9wz/U1TFqB?=
 =?iso-8859-1?Q?hSN3Wl1DKMR5bpurxCuGc8jaOdIvizyBukOtvv/cxPRMrFRQqB9MxmYo1e?=
 =?iso-8859-1?Q?RPSu6LbHN5y5+AguPej4KaXbzZdwlkMJKM8vDcbAYORPvBV5gb16H5vUpM?=
 =?iso-8859-1?Q?DzsaSf44HOtSBbH/glU2YjXfxHS8MEn5SfV7GPRq6BHh3080U/DAmRWSK+?=
 =?iso-8859-1?Q?xAFWQk/96lkEW17fNDro0znXZyEOi/T/B7S9csj12QhyTIIDIDyvXGNOQq?=
 =?iso-8859-1?Q?qFgsM0gcBtn99zwNKF7/SOAkNgEqMj8+KFQ3zWnPUg3O4errY8KMujLTNd?=
 =?iso-8859-1?Q?VqUdirM8egxr5I9l5hvDwx+ZaMhYpa0O2sw7baS+0ZQ8po6oGazuE90PFp?=
 =?iso-8859-1?Q?NBzppd/GLH/e75kdjZgP2RaH1qof0hTLAybfNwLW+vmCrDcTJ862C4QmMF?=
 =?iso-8859-1?Q?id3RmxO2RTJKMygUbFjGeCT40AfmHD4AMdQq6Tm83bksa8BXsnEiF34hrm?=
 =?iso-8859-1?Q?8FAueNEniCZhWWYiRl5Idq0zajzvQmISoEjiVjgJS1A8sFhfVXsVYtRX6S?=
 =?iso-8859-1?Q?x9VcLE/zMzap9Xy9+aTHgaC18sPtq1q9aGUV5eCnvKZBjapmS/MVxk4dku?=
 =?iso-8859-1?Q?vK3cA9MNggihkwuWEEUm8QWoulQ1ySmioD8uj8ugcL9KlnsmCVJNs8vhLt?=
 =?iso-8859-1?Q?YSNo0lKVFuHYPwiPP3Z8+8DhkJc69n09G6oxwrpq5Fw3dITVgTeF6lIu7u?=
 =?iso-8859-1?Q?BUrGNpyFfs256GsOQFsGb6w0keJmpEK0nU1GCf2tlpor6s7oYsfIBA3xSU?=
 =?iso-8859-1?Q?j+j6exGX0INieC13f8NdfPhFYATKpJktGZlaP8xzd8WXvJFWwkJzXI2gQ7?=
 =?iso-8859-1?Q?MG0fx9TZJDAaK++F++QUradfnI4fgcs95bJzBJ5hfK6wIzsj//53uquDJH?=
 =?iso-8859-1?Q?Da1c3pCKPxHv1U2h7q9/K+kWX7y+vMG3mQM6e8h+tRnhhMs2pa3rwaeffO?=
 =?iso-8859-1?Q?VaF/R2RWlX1Mj7O+Ibz62t1/BdZxpeCvBlKXZSOtBSshi+YM+4o3IBvV7a?=
 =?iso-8859-1?Q?bhRmDp6iNvC80N/FvkKdnvi5xGzEf+502mXnLK6zgPqeySv2TIukesZtw7?=
 =?iso-8859-1?Q?RVMqxyXsumZfBi4Q4sjuxYlCOmitFr510W848MW9iyjCPRPRoGyvrTYdgD?=
 =?iso-8859-1?Q?fvhwrqNJUFpuWS/Fo3XHvnUUJsyNFpTsROVqW5SxjqQvNfFZljakJGmbln?=
 =?iso-8859-1?Q?5bU77gCJqbjBxIlUZeNhBiPXr0NbW+lMSFfUpbRQMMRDmmDEiI4FCPiR7w?=
 =?iso-8859-1?Q?tNoia/6f4FNXjW1SRFs/asC7gjjAduaCz4bD9n1GlL634HaBuW7XMWQGLM?=
 =?iso-8859-1?Q?6Ce3ewVCGI6389Z0dB6tDwHtttcZVQ0u8r?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ekinops.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB3681.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c7e4d4-0d20-48f7-9eec-08dcf4fb78e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 13:46:48.1181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f57b78a6-c654-4771-a72f-837275f46179
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9r1AJgFcVVX5vrC906H/a7wfUO3xr/+sIWCz12Wna5dzvysEa8wNXMQnYSdFB0dVgqzIjMj3Kj1DyGO8zOA2VP61Xyel7Bvv7wwrQQuiI3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB1579

Hello,=0A=
=0A=
Trying to set up an untagged VLAN bridge on a DSA architecture of =0A=
mv88e6xxx switches, I realized that whenever I tried to emit a =0A=
'From_CPU' or 'Forward' DSA packet, it would always egress with an =0A=
unwanted 802.1Q header on the bridge port.=0A=
Taking a closer look at the code, I saw that the Src_Tagged bit of the=0A=
DSA header (1st octet, bit 5) was always set to '1' due to the=0A=
following line:=0A=
=0A=
	dsa_header[0] =3D (cmd << 6) | 0x20 | tag_dev;=0A=
=0A=
which is wrong: Src_Tagged should be reset if we need the frame to=0A=
egress untagged from the bridge port.=0A=
So I added a few lines to check whether the port is a member of a VLAN=0A=
bridge, and whether the VLAN is set to egress untagged from the port,=0A=
before setting or resetting the Src_Tagged bit as needed.=0A=
=0A=
Signed-off-by: Herv=C3=A9 Gourmelon <herve.gourmelon@ekinops.com>=0A=
---=0A=
 net/dsa/tag_dsa.c | 19 +++++++++++++++++--=0A=
 1 file changed, 17 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/net/dsa/tag_dsa.c b/net/dsa/tag_dsa.c=0A=
index 2a2c4fb61a65..14b4d8c3dc8a 100644=0A=
--- a/net/dsa/tag_dsa.c=0A=
+++ b/net/dsa/tag_dsa.c=0A=
@@ -163,6 +163,21 @@ static struct sk_buff *dsa_xmit_ll(struct sk_buff *skb=
, struct net_device *dev,=0A=
 	 */=0A=
 	if (skb->protocol =3D=3D htons(ETH_P_8021Q) &&=0A=
 	    (!br_dev || br_vlan_enabled(br_dev))) {=0A=
+		struct bridge_vlan_info br_info;=0A=
+		u16 vid =3D 0;=0A=
+		u16 src_tagged =3D 1;=0A=
+		u8 *vid_ptr;=0A=
+		int err =3D 0;=0A=
+=0A=
+		/* Read VID from VLAN 802.1Q tag */=0A=
+		vid_ptr =3D dsa_etype_header_pos_tx(skb);=0A=
+		vid =3D ((vid_ptr[2] & 0x0F) << 8 | vid_ptr[3]);=0A=
+		/* Get VLAN info for vid on net_device *dev (dsa slave) */=0A=
+		err =3D br_vlan_get_info_rcu(dev, vid, &br_info);=0A=
+		if (err =3D=3D 0 && (br_info.flags & BRIDGE_VLAN_INFO_UNTAGGED)) {=0A=
+			src_tagged =3D 0;=0A=
+		}=0A=
+=0A=
 		if (extra) {=0A=
 			skb_push(skb, extra);=0A=
 			dsa_alloc_etype_header(skb, extra);=0A=
@@ -170,11 +185,11 @@ static struct sk_buff *dsa_xmit_ll(struct sk_buff *sk=
b, struct net_device *dev,=0A=
 =0A=
 		/* Construct tagged DSA tag from 802.1Q tag. */=0A=
 		dsa_header =3D dsa_etype_header_pos_tx(skb) + extra;=0A=
-		dsa_header[0] =3D (cmd << 6) | 0x20 | tag_dev;=0A=
+		dsa_header[0] =3D (cmd << 6) | (src_tagged << 5) | tag_dev;=0A=
 		dsa_header[1] =3D tag_port << 3;=0A=
 =0A=
 		/* Move CFI field from byte 2 to byte 1. */=0A=
-		if (dsa_header[2] & 0x10) {=0A=
+		if (src_tagged =3D=3D 1 && dsa_header[2] & 0x10) {=0A=
 			dsa_header[1] |=3D 0x01;=0A=
 			dsa_header[2] &=3D ~0x10;=0A=
 		}=0A=
-- =0A=
2.34.1=0A=
=0A=
=0A=
=0A=

