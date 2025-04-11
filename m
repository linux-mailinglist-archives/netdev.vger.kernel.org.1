Return-Path: <netdev+bounces-181528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45402A8558E
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 09:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EAAA467FEC
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 07:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C70927E1AF;
	Fri, 11 Apr 2025 07:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="YXgX4NXc"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2082.outbound.protection.outlook.com [40.107.105.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA721E835D;
	Fri, 11 Apr 2025 07:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744357067; cv=fail; b=CDJgYvYmtCrBAk+xlD4yGH5cHTzMUf2LeFfrx3S3Gbk/OELlCctv/VEo/DpoHYcICI013WEH5C6uTj0cK5w/EEY4PN1nAcr5f/lwDLOarVHzkBc4TBoWAjQ0wbLwkig3+vjIuGz7HedSwEawWxUqOAy6HhABsXYieMr8aPEy474=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744357067; c=relaxed/simple;
	bh=xQuyS+o50ulyY1KlRY7U2X2NefgnXBKA+J8PXv2ijIw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EcmMmUjTFiYAvoPXcrCqy5e89rm8PPBDvt6L2xUtZR1vKYTcgu0Ta8zMjC+suF1+PZLGSWFfiiwztwxGQf02MWbh1kg1eRCu0/d0rIlzzJg4hFXetzmLfsd3CX4wGmK9A5f251MCLPGVzi5TPWbSv33FoufjFsDNSyKuyG7r1g8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=YXgX4NXc; arc=fail smtp.client-ip=40.107.105.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7fz7wczs2egwkQWd1XCIM2Aqv0s/qI+jFLMjL4acuLhOUFU5fv26bMR+bieDoblu2Ksr4Lde7g1cBjUolTjALHHCmt/UP3mQ1sY8x2n9H4gbvHZyriA+hgc7mCY3rC8XpWsGhRNJwMuvUZBDcd25yOeAVXrJKohlIJhF9exi7dkNvlADWQ01vSdAA9VtCxcSGsvcON+iAFyVSVuwcslwfNDPySDL/wQ1RC8iBn/8U/A3pXWPqSAKSa1DpcUaOQXiCokcCBrEzV4TpBKI6w5wVZWAQHglrg1fVt3mCNFgqYdu3Pf8xcZB10h6Nq/zu5mBExVEcXTmKLw6knGW3E5ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPNVGsKH9+RYvku5oGypS4tsuJEYtMmwyW6IAAPr3yI=;
 b=ddjojRocL6I+EQIPn+oYTzLljPo5G554DgcQbKnEGrxtwO0L+yvWAgEMScc0vrwV+tEAseIU9ne2BDHaaFQ9hqaY3Sxtik1aintFfAOQsqkifPrM4hSDbjhFUXtwrokLGa7uW9KO/IEktdoBapvt3kVjbxmQcwmlT82PwwCQAYe2ORYVO3kwRlejCIbFl/yuW7sDln0ibe012U3yPFlng1OEV1eb+GUvsaJQ1r8tR0iQBSwz0TMkXNSPJdYmFkscD9y/e1ZJ8h/z/6syxYCHXGdeFugWTYkpXm8gi+xaulWmTiEgyQogmqTHAWkDyB7oyE9hQk2DyqC/z6AvllyF0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPNVGsKH9+RYvku5oGypS4tsuJEYtMmwyW6IAAPr3yI=;
 b=YXgX4NXcclTSuHy30HpJQSx5BbMQL2S6f/07zC+k6YxOPsrwdHNRgWcd2DSpNeucJRkQ5BdVJUGmv/cUbVeP7/xcolZxvAFP6Ppo4FHUslZwFByFt5TTAXOBZ05Yv/zFfAnE1J0DKNZrzuGM5BaLK2t+piuvWLJkz0O0jTVIpbtXzm6e64t0Ax8hViJQXQzyTr20CLIkMnnOOOtAmbsyZl/Km76oPEspA2j1nqMHgr1xvl5U7fd049931DWnk1NAtE2r4Bt4yOkIf6OOj2F5MOn0VWwFUTpB2e7SfBuHt+bjgOxTJNmOIhdq5nwjuAEPA/znqJR3QHurKdkPCpemxA==
Received: from PRAP189MB1897.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:290::22)
 by AM0P189MB0723.EURP189.PROD.OUTLOOK.COM (2603:10a6:208:192::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 07:37:41 +0000
Received: from PRAP189MB1897.EURP189.PROD.OUTLOOK.COM
 ([fe80::91d:6a2d:65d3:3da4]) by PRAP189MB1897.EURP189.PROD.OUTLOOK.COM
 ([fe80::91d:6a2d:65d3:3da4%4]) with mapi id 15.20.8632.021; Fri, 11 Apr 2025
 07:37:41 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>, "jmaloy@redhat.com"
	<jmaloy@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] Removing deprecated strncpy()
Thread-Topic: [PATCH net-next] Removing deprecated strncpy()
Thread-Index: AQHbqqg2fKRPQg2KPEqrm5rJStmyB7OeEwbA
Date: Fri, 11 Apr 2025 07:37:40 +0000
Message-ID:
 <PRAP189MB1897052C5306AC237EE5154CC6B62@PRAP189MB1897.EURP189.PROD.OUTLOOK.COM>
References: <20250411060754.11955-1-kevinpaul468@gmail.com>
In-Reply-To: <20250411060754.11955-1-kevinpaul468@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PRAP189MB1897:EE_|AM0P189MB0723:EE_
x-ms-office365-filtering-correlation-id: 357cbc78-4a88-4a25-79d0-08dd78cbbd88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2GVVr+DYYWEZCczJYuf5lWsJoFM4DosIra/QgFqB0usMc75dwyGBQXlL4tUA?=
 =?us-ascii?Q?G7n/BkT/m2FC9OSz65NOgb4e33dV242ckpasDMu29Yi4Em/wSn9jVJY+3bjq?=
 =?us-ascii?Q?pkXiLYOgoTwsv4WfsmU8pYPvOospfWYYXyR/m3xUMusc0bstm4dMAxQCX0rl?=
 =?us-ascii?Q?coZ6+B2ql/0e7Mq8CDD7EeexRatDPqzJmpmgSg17LWbRc5+x4AKGZu59fuQS?=
 =?us-ascii?Q?YO/FwXWW32wFAMdzdWsjVyGFSLs0leOx+HbRnsdP0SvwgZcEYPgehx/wytX6?=
 =?us-ascii?Q?bxf5YUDDK8J1ozFV1MpaBmkDUX3yITsZA9Fxqhhn1ElleQleSuzpLcqMv493?=
 =?us-ascii?Q?cV2ZT6KCnt8o70L41G2hCFxKyLSsj0Tr05ixwU0vwhNuUWWyeHff2jjl+F3E?=
 =?us-ascii?Q?GlbwJGumot2CT8wnT/MN7Ux3dmd8tDMna32THCRaT+dl+7JKY/N+lfifEeCM?=
 =?us-ascii?Q?irEcmMyIS+LAIjKl0Kca9LjFml1zGQasRNrAcyMyoeX5TPIxQ5dECsLhGfB2?=
 =?us-ascii?Q?Vq7xaSDz6sUM3LIVMdlgtYigZY9rOt4Wi4fMPBf3aYn17O2bcO+5ZBqk3PV2?=
 =?us-ascii?Q?3rQyG7XhlBz5XqaWy47JIQn+rjS327dEJs6ooaYgHDuAfnVFBjHglVK6KWTF?=
 =?us-ascii?Q?FusluByurUH24ZISm10ss6TAbp55XMfe+E16Hn2ffFFMQRlIpMOpS6Ljy++y?=
 =?us-ascii?Q?ZKRFVXq3qktPG++T4N4fA0C3eBkh9voBdiU3Fxtkv195YrfgHHXsadojalU+?=
 =?us-ascii?Q?nv90EmXTUnQ4SZjKIQE0qhdOPPIze0WYNM1rLg/Wxywo3QL+hYsfZSTbPS18?=
 =?us-ascii?Q?urLkJCwuEZkNgg0Z1zedOUM2biUcM7hv3/OXWVHT21kErvu+D0Lm2gNbWKKe?=
 =?us-ascii?Q?st9EI5pVV9o3SWY2CtSyH8ZCrrZRWD6YJ85BYEfZt2wDfoSxkgNiPa7b0NeU?=
 =?us-ascii?Q?aRJeiVIX6emwUih1+xghWZ3NxjEyPJi6D4zgqCglGDW/cztU1rtnqYX9IJH9?=
 =?us-ascii?Q?i0XxY8bHkq7ciQR+jINodTbPxBBdtm5G1cknO1Bwaed8F0FOul32vEtV3VR3?=
 =?us-ascii?Q?MUjcMr78/suP+DGmyQs5Nr0WOpBJ2eFEDy2pMLYKagT6TsdP9VnbINs0uzyc?=
 =?us-ascii?Q?1A/QGOfjbUYnrPsrBvpu/UYHNjSeMutkkb4cw5aEaOfwFNWRKa519S44PjRt?=
 =?us-ascii?Q?izI8B4HITX3zOKrvVeta3om5jnR4j4mkVMi8i9VZX5kg5cplomK6J5OPtxcl?=
 =?us-ascii?Q?RFPCmwJmojxb+p5v8KLat8ehtc69yAbB2+q1RcsjoUgmhLGI8twTwne4OhqZ?=
 =?us-ascii?Q?mGowNY5s7dd+cDRAPkfXAnt14acsR2sq6ECu/fUeiQ06Q3dwM3eWmISXSbb6?=
 =?us-ascii?Q?MJT4O9j4jqkrmVJUi7hvP/2Ef7KWZyiIDQwZ6ecLnRi5Q3cAmyN5s/a2veLJ?=
 =?us-ascii?Q?QMz5v2p6MvopyVofEagsoINCqpk9wljmgeDe+32DYyIXIoh6lscwZR3eFLr5?=
 =?us-ascii?Q?j8XpC7ur8HFTR3U=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRAP189MB1897.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LH/aiLLG3H8TAsGV77vW7IhDbBwkLy4WQ/EbzoJCLRo0eQAzNMsND93Wiz0a?=
 =?us-ascii?Q?Ffe5Aqlrcx87xWqliCcm0+o1a5Ffcs1loR8ynHY4JSiAjaSVEL4HbCShR2vy?=
 =?us-ascii?Q?gP1e6tr+XZiH+lm4zUmU4QaGZ3/Q5Sf/DHukhxFZdXBu24XAWsJ+ibBygl0L?=
 =?us-ascii?Q?QKnl96mzbNB5KN3XYCunJUv6PcIR6K5lSALRj8ozXarNUasvZHVcnykArZ75?=
 =?us-ascii?Q?axgdJ8uM0mwL/baw5HK7FJxGfOYqOmJ21pTSl6iVm67665mehotOpX1xGCV8?=
 =?us-ascii?Q?QHR4FnZ3OHBX+f1kGHDihGTWHUD/kxK1luO+zrllgnnY4bMlatl4kv0j3w4X?=
 =?us-ascii?Q?EUJGrMWZPOCPdYF2oE9lb+qsjwotQy6y+9LW8Wy096df+3CvLVcC2anYWmwL?=
 =?us-ascii?Q?mtPynbrNENOX6GNB7cPLHt/k4KrDzfdXLTnN6/K5rRnGEAb+r7kKDK5dxGk/?=
 =?us-ascii?Q?OwQaUG87TBk0ZByTwr8SWyAiLWzBo1+hicHWNvVI131AQKM+mdIb5iELiVoB?=
 =?us-ascii?Q?ijY99ZqfFowiXJ1SeFaJKITU7QHbbIXwUoXeamCGVLYeiGcHLi5oeIM6nIeJ?=
 =?us-ascii?Q?4l2H6de8pkdhnB3n/i3RSRSlwAH59u3t0QKg9N4V24FgTe8XNFmYVkQ4xCUx?=
 =?us-ascii?Q?+DUshzZFPQDu6mgW0XUSWwuSpQHk6b38avZVXErjQeJEuo2HYvDZVoxx4U05?=
 =?us-ascii?Q?gNfnfdd7owHCg2T+rvKxOezy9/ZTugc/xybZm9d2k92RLVtExfZBoZICBbSe?=
 =?us-ascii?Q?q7PsKGOg4KZd/H2PtmLwXmiL1KkdAwiHuZNugPJR7IJ2JTDdEXFh+OJCFJs6?=
 =?us-ascii?Q?BxGqmTac/fneXNK9KoIl0axXWINUdN0t3SUjtumYu42fbFsS9X4vxTBDuL6S?=
 =?us-ascii?Q?ulIloR/3b+U9bgRsOLQgq0fBq5HW6TeYZiPfquftxw3kPwz8veqSebz8f8Fl?=
 =?us-ascii?Q?+DlRSEjrbQv7pK5P+Y17QaYfXRJVm5RZOH9ct4DlUX3XVHVQ0hE2F2XBnakK?=
 =?us-ascii?Q?ZpoXrJZ+GRACb9A6Ve/g1FfE/Hd3wRteOI5fz4k+Cgc/o+amC124zPzObuF9?=
 =?us-ascii?Q?Q13cfmt4vqlye5Sv1AODOA6iP3vatFgf0fVly2YAJj81goc5U0fBmhULuvG8?=
 =?us-ascii?Q?AbIW7JS+T0Zbyr9PEDLDqOOA0Zifyuie2gtuKU6Oft2lEZm1uIRpI7ePfS0T?=
 =?us-ascii?Q?Bdh5mpv283CN1Wiz6M+i6TlJZOKRvtwqXbSS7VgM1jnf06Uq+C4zRvHlzBh9?=
 =?us-ascii?Q?X1ZLSQdchK8gU5XWS6V5hJAF2Cta14BBHyr0HebisEq5f8W0fWTUcCzqyp59?=
 =?us-ascii?Q?SquwnfxKG960/nPALrm9Pbdcf5pg8tuHrc25Aqoi3yBYCHC3Z07mAc9/Kf6x?=
 =?us-ascii?Q?1nZVoM9X/VS5tR4dD/0M0HAt+yJf/DPZdIt0MbXcrryug35m/eh2FC5RXD6s?=
 =?us-ascii?Q?uM5HWjTJC5sbkSwSgwtHRzlRuV0VYUafIBMPnYMEREfIFr7z8iGyR7fkFw5C?=
 =?us-ascii?Q?FI4iYpWuagXltb1vdUnTTSnNxjLsf+E/ARyx9XoWzMjX9UTNosF0MUZyDMXN?=
 =?us-ascii?Q?Ctpa+ObaResaiT+BMTDHnd+hOOW6zZAJtFhjZBI4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PRAP189MB1897.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 357cbc78-4a88-4a25-79d0-08dd78cbbd88
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 07:37:40.9520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mlX0RtsKZ0Ml6/wMKIMrM4h3pu8cqTmhPu0Mlipe+IlymkGl4I0RKRrTEo8VzKQSKPv1PZjwCbxZb2sh6hA/peYKRMdsdFavV0YzsYNve2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P189MB0723

>Subject: [PATCH net-next] Removing deprecated strncpy()
>
>This patch suggests the replacement of strncpy with strscpy as per
>Documentation/process/deprecated.
>The strncpy() fails to guarantee NULL termination, The function adds zero =
pads
>which isn't really convenient for short strings as it may cause performanc=
e
>issues.
>
>strscpy() is a preferred replacement because it overcomes the limitations =
of
>strncpy mentioned above.
>
>Compile Tested
>
>Signed-off-by: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
>---
> net/tipc/link.c | 2 +-
> net/tipc/node.c | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/net/tipc/link.c b/net/tipc/link.c index 18be6ff4c3db..3ee44d7=
31700
>100644
>--- a/net/tipc/link.c
>+++ b/net/tipc/link.c
>@@ -2228,7 +2228,7 @@ static int tipc_link_proto_rcv(struct tipc_link *l, =
struct
>sk_buff *skb,
> 			break;
> 		if (msg_data_sz(hdr) < TIPC_MAX_IF_NAME)
> 			break;
>-		strncpy(if_name, data, TIPC_MAX_IF_NAME);
>+		strscpy(if_name, data, TIPC_MAX_IF_NAME);
>
> 		/* Update own tolerance if peer indicates a non-zero value */
> 		if (tipc_in_range(peers_tol, TIPC_MIN_LINK_TOL,
>TIPC_MAX_LINK_TOL)) { diff --git a/net/tipc/node.c b/net/tipc/node.c index
>ccf5e427f43e..cb43f2016a70 100644
>--- a/net/tipc/node.c
>+++ b/net/tipc/node.c
>@@ -1581,7 +1581,7 @@ int tipc_node_get_linkname(struct net *net, u32
>bearer_id, u32 addr,
> 	tipc_node_read_lock(node);
> 	link =3D node->links[bearer_id].link;
> 	if (link) {
>-		strncpy(linkname, tipc_link_name(link), len);
>+		strscpy(linkname, tipc_link_name(link), len);
> 		err =3D 0;
> 	}
> 	tipc_node_read_unlock(node);
>--
>2.39.5
Reviewed-and-tested-by: Tung Nguyen <tung.quang.nguyen@est.tech>

