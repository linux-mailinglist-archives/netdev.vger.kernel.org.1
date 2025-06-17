Return-Path: <netdev+bounces-198426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0A2ADC236
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 08:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2BD016142C
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 06:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF2E28B3F8;
	Tue, 17 Jun 2025 06:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="lf8Wbs9s"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012011.outbound.protection.outlook.com [52.101.71.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8EA1E521D;
	Tue, 17 Jun 2025 06:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750140764; cv=fail; b=FfGqDKran+ci3N0FFVUGY3ctgvF/r81bkpY6emX2tlfpb2dIXUcuhHt1hm+ENHWr0ya77DtU/SCqyMi2IDT3u9vY1+XxeZvcfPxqi/XeJ57Pxi/z0v4Eo/V+RoEGqcv6pOVmwXYqLdcheP2jjvMcMOBCHzZ6866fZMHWi6KByMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750140764; c=relaxed/simple;
	bh=f61K/muUHlZLmazaR9gFKPtxqkCTGePOvmJe3vT1Jzc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZYgDf4JntyNCqPw+sm7MLQ000yU4gXctJWCC7HCCpmqazUUH9H2u/VqVEMkHG8pyFIoTYjTc42QtXQzvPd/+CGi9gnvs/xeTd1osa3n36pXhx1iPLYZWOhsNTfhp+uqy3Q+tf2l4cZniH/tlB7Pt+4HvtRoh8HktSaH3F05ZbsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=lf8Wbs9s; arc=fail smtp.client-ip=52.101.71.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UAML/ApmCW/M/TNhjodp17HRydvPqLy1dsXcbgJz8FCh+HqFpS8lYRdJi+thMum5Dbrd/cJPCxDX9rxJeo5l7mTfsoeFRnA3P8yxP521RTkdS1jcFWd+1p7jsTCUZwWfPxcbooQy8GgEGqm2Lq2lpvOBraqGXC/7yif53+KU1tPnmrh7Cj30Zs2qF6hTFqgVz0qPexxKGmpEx8g/LPaIJFcfA7lTMY1332ZVUgHubrnijugHVIktDpOA1EOOH/gEgIcEoypLOAUinPSxfV+ITo+6Vw2DCwbsOyJFZsa48HFhvbYiAWVqpqLTVveMHCbSK7TEf431PCMlmnYKrBL69g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BN0/AS2lY8UlVB3WRtBh8BvhnyvQ4PF+g8nWNxP9Yws=;
 b=YJqqINL4+ExsPd0FnYLCaTEqaMCZ37eJ9MQ0MDXWX9IbrI3vW1XQyldToQncWERI5yppcn1Rh9x99oWxszHxWbWYN8xOeXbrBU9Fql4J6kgzZefjF+ZLmgCjllmzqcEysO3GcafttWIjjC1vFHeAjduacisQGzmd67NK1xtPdIrAzrnKjiiq3in8HyZ7WtkIsuGd+MLGRng7VrRzk+x6QquKUbnd6fZCMoHfBskJlb1GonB9Pr6gdVlI3RoKIMYocmZ9VbFM58UBwd71wMgT+eF8FnypHL3/Tt6gl59kyKNdnfDjdo2hdotgYQNvGwO2Bom3TA/qpuOC+2tXfh6pbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BN0/AS2lY8UlVB3WRtBh8BvhnyvQ4PF+g8nWNxP9Yws=;
 b=lf8Wbs9s1d0YYhqOivh/TjkvtaPad7xfnA4HTG2JWwjPpTiPk7n7mXouhEpvjbI5kuqrznP/1ZeelMrLt7enH3LIJjSLy3B4TwGzTCJln4IFumQ2rk/jY1tPJ8aRZuzFzntnlnxDQdDi1i4Y4I4mcIeKZYs3GldsXb+1JnJWUABDQlGFLV2DCpoMp0efsOmjG7l6FaphDx6TVttOKmXVYKbUIeIHVkVYdylrjTPGUgJHwryvG/RJ0OJAIfZALYXgs3BITcV2KSwK0GSy8SpFeNenUSKOcw8JBQsc6GNGrw2+f5iuz9J2oRznRiP82VqCIRG6Nbftr6ch9OjJZb6dIw==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 GV1P189MB2648.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:17b::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Tue, 17 Jun 2025 06:12:37 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::43a0:f7df:aa6d:8dc7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::43a0:f7df:aa6d:8dc7%4]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 06:12:36 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Haixia Qu <hxqu@hillstonenet.com>, Jon Maloy <jmaloy@redhat.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 net] tipc: fix null-ptr-deref when acquiring remote ip
 of ethernet bearer
Thread-Topic: [PATCH v4 net] tipc: fix null-ptr-deref when acquiring remote ip
 of ethernet bearer
Thread-Index: AQHb30zDpaG4ac1yNUmZHqMFo4aV7rQG3piA
Date: Tue, 17 Jun 2025 06:12:36 +0000
Message-ID:
 <GV1P189MB19882E69E2C71A79B6A7EB58C673A@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20250617055624.2680-1-hxqu@hillstonenet.com>
In-Reply-To: <20250617055624.2680-1-hxqu@hillstonenet.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|GV1P189MB2648:EE_
x-ms-office365-filtering-correlation-id: 58faf9a7-aba1-4b3d-7705-08ddad65f4bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sj5ffn3iyv4K7f+GdY6AD2oyj/7U54y7V3M5vsyyxCSVJArmeJRVH62poExL?=
 =?us-ascii?Q?Hl48eCkPTz2D8/N7//KRQfQUBWEagdhd1YSBUJ+CZ9thCreAvbBmsu53166Z?=
 =?us-ascii?Q?KbYf2dnRXC1w+FkIF+vC9GowOf3Kfc2zRg7xsL1il253tGnJHAABJ1gxuOx5?=
 =?us-ascii?Q?+yzW512275XiDvGjNtUllsfqW+/nLCjYUAMw7Ndb/h+O7TloDOrL8evNp6up?=
 =?us-ascii?Q?sNms9Crc7eY2qYqCY6hX/ulG/WE9DhOCsLmz5xyKLRaMNRjt+xgFyJ+4U857?=
 =?us-ascii?Q?LS8UXeUIpVkedAHN4fQrLMUSxZnv2BnJl/UNxrzHLYeUjH5ykVGQ3Jz3gGQP?=
 =?us-ascii?Q?tquKMwmFiM0c9GmbvbmUBvBW+kICNqYzovrJTF/3TgrWqsu/FJFAsF52onca?=
 =?us-ascii?Q?cNC6dBg8yhsP4fYcba8drtTI6IygtUVU1NQn27dp9mj9nceHqd7NjECN9/GQ?=
 =?us-ascii?Q?GcEEy2vpGVAm9cDJdllZcayiWdjmM+Fp6/64h+lOoUxWvkS6xV0DbuM2Xdku?=
 =?us-ascii?Q?0WR/GsK+sNJmIg5OTy58i0qsaAtt13/aZOupHJfel3n7wPhMLLLmjvJSlBta?=
 =?us-ascii?Q?lfHlEsFDXi3dvsvVZbFyIVgGump2BgLwLx6YNmvXHfvR0sOt16IRJgvH0DTM?=
 =?us-ascii?Q?zyU+XxUZj4yC3+yCGvqfig1XFV8JlttuHEarTbrKtZz5nUF80Co0h6FQ5k1y?=
 =?us-ascii?Q?ZU70pe7OKwXWJ0dLKAYTnFSKpn4ZHlOtJcwCuJyHjE5kIrS3eJaw+hHPBZPy?=
 =?us-ascii?Q?CEaucNOj5jYtABIsTO6uw5/Isf/R+NqFEfAKNJLjOiArQ+/tq4xB1wbM6ucf?=
 =?us-ascii?Q?2j5RHISsrzYRQL3XnagCOhswsXLLewhRv6ozVS5AmPwcEVsO4AR7D1N4Bx7Q?=
 =?us-ascii?Q?FmmrEJWKOj2pdBnkPzaK8XQsdhDTX78Q5UuefdiT6vsq9wHRojqQ6Hydw0hg?=
 =?us-ascii?Q?iKw4BGd3hse2YgCfGzYVAPGmdEJerB9z85sjlFwIN2IyhF8TM/pZtUvdayug?=
 =?us-ascii?Q?JJ7WDI5scLjvOBif4daMLnR9zPxQFeIWizNVcTih86/q4Bks6u5GS+RTccnL?=
 =?us-ascii?Q?4io2cOQpHPQm2QMbXQpkXsMw7StOuymt0q0OxWb57Pu6GvU1q7nNZZLyFph/?=
 =?us-ascii?Q?6x+SSuvNx1RXLtdb9zRI4vmk/FQ0Az1pOI6KY7EYCdLLqvjxU3T1yMS56ODl?=
 =?us-ascii?Q?udyjvr0L/PXtpFuMPrUR6QAi9Y7TCWes2JTzwysHmyzsVgsdF4putuM38LB/?=
 =?us-ascii?Q?fCK01bGeQzoSjfOfrXJkpV3v1bkb+sAFkMeQKHHCThxNzGNMtZlauTUV6ZUu?=
 =?us-ascii?Q?EzMmyHYrBw1W/ePiiODKm72Igqhm7wKzFJDjkAV5YhVz+wxfLuHxdSgdvePO?=
 =?us-ascii?Q?H/mftSPDW05tRkkoDtMMsR59ih+bNoaNUttsCtGNnlibRfatU4+fm44T3cxY?=
 =?us-ascii?Q?aExZXeZNCu4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Jx77HQI/8j5TR8+vMyOlQpjfXfkCKijCMN/xk8u6kOrYuWT669whQ8DYz164?=
 =?us-ascii?Q?GOn5TgYVvVxR7epJt8kMv2ZenzjPrhCAGTnMdwFh08yC3C9houfyp6Dy3kX+?=
 =?us-ascii?Q?7xARhH6LxOcwplYppw2ACA0UAO6n48LgfijdPL+d2vrH5d3HShzV5BumSshk?=
 =?us-ascii?Q?U0cEvrqJSm/xA8JL5gmGAC7GeD1ctQv3le/N0lujyGAXCheljwi/D9VXAhha?=
 =?us-ascii?Q?0gBugcTW3+BZE4vkPPxu17E6cGEbWfAgmXHUL0zC6ETmO2imZx7C+vM471B6?=
 =?us-ascii?Q?KtWuShneEsJmbLSAZJdgfQQI7SlPiFeRgDQBL7ZoDvQuqGSB3eVV1hnf6EI6?=
 =?us-ascii?Q?wfnrp8+sV0d30TtFuDBtrjf2houN2p0d9fcOn5ORK5m1DLmRU7+1f54NMvxU?=
 =?us-ascii?Q?DvhGCybtoaQTWTNNNq38h0vEFMLkLK+eLeFM0MtF8M/CjU+27vJ1xWuG3Y98?=
 =?us-ascii?Q?ljDE1jLW7QZcdC8qgAn6xx8tlpg+BoCeKxlxItyhyUydqDLZqAlOCkSemYLT?=
 =?us-ascii?Q?QShNjLdoUiHyvq+h+0tidRlfgmCs+IIODT6+DUbnBlIHLLlLrMhGpiLWffV2?=
 =?us-ascii?Q?Gsum7qHpzXceJiDdVQHKP79GjR8EpHZGmJ0xYgoDUudNu0ZBMuSSsO0rPhiy?=
 =?us-ascii?Q?rxb8qcGAi68YDOw0nrGG+si3CyOT6FmnovrKMSakqiaOBDB/3wVSXKfXBX/M?=
 =?us-ascii?Q?Lzr8/R6AGtJ+GnQ2SYv0jIF1WZyouuqeEDKoXZ04kS+JB13kVgZriWVG63r2?=
 =?us-ascii?Q?V9Qhwv59VlvyHKrLvFT5bSlSrHNmEq13yofA5FKqclnOpb8Ujp9B8AbqFOtj?=
 =?us-ascii?Q?HyNei/YtcZY1UI9MVrFFTHRycAiqub0x/IFloG2SMjOkreRO5/F1Q3k6gDgl?=
 =?us-ascii?Q?LXweMG5F/4JctczV9Tnp+kgFus+efdjdKbPmY2mA40xQaBvD5U6aYS+PXghZ?=
 =?us-ascii?Q?eiYPB8bbupUXqpVDeltpZxOSTxqeYvnD6KvOQS81wep//sWiLqK3BW/6Rbsn?=
 =?us-ascii?Q?eeCg4FH0dqgNnLdyVr7TzOoK6mbijABVpKuFUfQM0LdQkHXPVCTMzpYPYzsb?=
 =?us-ascii?Q?Rrhv3p946qNIp+imIiZECOanTnTrobjsdAaMmwyUH0pPGCGL26RVDYjXPHxa?=
 =?us-ascii?Q?kW3ErnOhq15ruWLFNHsiH3ZQTMrd+KF+fiALmnQJbCi9cnPDl9oi6xQMGJyA?=
 =?us-ascii?Q?lcD98+FdrzigCd7kA1U79izB4KBGkTbkSvOgGtRcCwEjMt1Ayg49FFlfeK1d?=
 =?us-ascii?Q?LBd3UYCS7VJt8GB1D+bXHRRLkvU1xO9bnjk9HuRBBNdFdKIUrKGe/xFP5XpA?=
 =?us-ascii?Q?KUOj5dfQmpatcSHlWMp2NBseItr/yHhNPyFOJUReDpMqsHtqSACwWLa5UDYh?=
 =?us-ascii?Q?j1cpzQ/vIFtYxyXCRJqKKCTU3W5MjY2Yeh2LvYRXPOdHdBcuVTFo1dlYky2A?=
 =?us-ascii?Q?8I5XT6EuVw1B/h49+qeMgva93E1r0cisOEOlRRQdIfaFsFvd9TzisNvJtPjM?=
 =?us-ascii?Q?6kf4pEyA/xOS1QMk/EW8PhYmUpSHU13dzkQA729U/AtFwiVrBj5Z+8TNGa20?=
 =?us-ascii?Q?nPfTmM7Vc31VNsfreQtI5djtpGlepq6D4wJ+gPA5?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 58faf9a7-aba1-4b3d-7705-08ddad65f4bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 06:12:36.5537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zYMGOwjeQoZmA8+DqWd90SBe5raOX1QqnSFc19uE4S7oTUoOFwyjIfGJK1y8GQqegxzk+CMo+htMsj7gQfIEszYSKw2CzE1pcl/uzqkmncM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P189MB2648

>Subject: [PATCH v4 net] tipc: fix null-ptr-deref when acquiring remote ip =
of
>ethernet bearer
>
>The reproduction steps:
>1. create a tun interface
>2. enable l2 bearer
>3. TIPC_NL_UDP_GET_REMOTEIP with media name set to tun
>
>tipc: Started in network mode
>tipc: Node identity 8af312d38a21, cluster identity 4711
>tipc: Enabled bearer <eth:syz_tun>, priority 1
>Oops: general protection fault
>KASAN: null-ptr-deref in range
>CPU: 1 UID: 1000 PID: 559 Comm: poc Not tainted 6.16.0-rc1+ #117 PREEMPT
>Hardware name: QEMU Ubuntu 24.04 PC
>RIP: 0010:tipc_udp_nl_dump_remoteip+0x4a4/0x8f0
>
>the ub was in fact a struct dev.
>
>when bid !=3D 0 && skip_cnt !=3D 0, bearer_list[bid] may be NULL or other =
media
>when other thread changes it.
>
>fix this by checking media_id.
>
>Fixes: 832629ca5c313 ("tipc: add UDP remoteip dump to netlink API")
>Signed-off-by: Haixia Qu <hxqu@hillstonenet.com>
>---
>v4:
>  - make commit message more descriptive
>v3:
>https://patchwork.kernel.org/project/netdevbpf/patch/20250616042901.12978
>-1-hxqu@hillstonenet.com/
>  - add Fixes tag in commit message
>  - add target tree net
>---
> net/tipc/udp_media.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c index
>108a4cc2e001..258d6aa4f21a 100644
>--- a/net/tipc/udp_media.c
>+++ b/net/tipc/udp_media.c
>@@ -489,7 +489,7 @@ int tipc_udp_nl_dump_remoteip(struct sk_buff *skb,
>struct netlink_callback *cb)
>
> 		rtnl_lock();
> 		b =3D tipc_bearer_find(net, bname);
>-		if (!b) {
>+		if (!b || b->bcast_addr.media_id !=3D TIPC_MEDIA_TYPE_UDP) {
> 			rtnl_unlock();
> 			return -EINVAL;
> 		}
>@@ -500,7 +500,7 @@ int tipc_udp_nl_dump_remoteip(struct sk_buff *skb,
>struct netlink_callback *cb)
>
> 		rtnl_lock();
> 		b =3D rtnl_dereference(tn->bearer_list[bid]);
>-		if (!b) {
>+		if (!b || b->bcast_addr.media_id !=3D TIPC_MEDIA_TYPE_UDP) {
> 			rtnl_unlock();
> 			return -EINVAL;
> 		}
>--
>2.43.0
>
Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>

