Return-Path: <netdev+bounces-181496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797F0A852FE
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 07:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 673417B3CC9
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 05:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D11727CB1A;
	Fri, 11 Apr 2025 05:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="ogkWnPqm"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1734826F462;
	Fri, 11 Apr 2025 05:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744348936; cv=fail; b=BRMJp9IxKfYORaeZe1SzuM/1LEk1CTGUOZOIINTJEmixOAnvog9UsqELKL9BU0WauZEDKqtz9yioTIR7+fJMo+tuKird/blKdLsKcU6OoqShUR3Dj/XsGZWum7xY8PCbOX3b/RhWBv+AbzvId/KV97ZAUAU2aT86+p8KhcErpXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744348936; c=relaxed/simple;
	bh=EmF3IR7ck4jvI4RchOC6yxHv6xOKi5D/5Pg2/AATZho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LJ7uAjazpw/xPTMfQorDMzUICGpkixamPD4zawo4VCJ1E+jKIRrq/jH8sXTq84qTSPOnTOxvtkEKA9BkP23J/yoTgxHaT2SQ/ChdKm0108k6XrBLJc/FMHk9q5KQAFblR6/qqwQjBwamKQ/YqxbeZ9gXZRTYh8T+e3b8L4cVRrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=ogkWnPqm; arc=fail smtp.client-ip=40.107.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCp60YUAa0gUUk5epSNFxqaGCD9RH9w0j12n4V7/O/BTdIsnoXMZiWQ7jXUSW0Bp4Hp+WOtjpIfJG41PIuv8kWyp2wXzcrUvPVRw+QnVZWr2BTwTgbDLIKgHZNNA5wZ3C5tIk7act9FkDKHvJxAQCC7VBdpWozaqyA1hiA/SCx4izWUGzGJIMPox19Kxe3+8jbrPwJPNJag2CN+/CEjuvWt57XcmvftZY8+vEjsxKKSvs/ZXbIa+2SsD0QvC5pETfbdTOZ7jFd2ZlI4/h+31F/w+/uNLaZwzTumy494Y+lc+LHDpORh4Iudk8jQuc9+a/FauKWfgfwdQVRGpLOfIgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApftDEmEIdsi04Rbpc9dvSE3Gmvz//fXk1BCWB5NvIE=;
 b=qwXTf5aHR+kI6EPhRkbS5fTmAtiaQkTukTTf+rRjVyB4Ym4l+T86ZTBthJ9olFF46S7ogVe3qMwoA8XyF8PZk9sHawBIH5CQk/WyRNVozyOjtjKleyP/k/dLc4ZXp0UwVqrLBA2055RxWT3pAVTLROeIiRWji1brDaiNcgliQdWSyLo1qNFtSbWFuT1Ziqj5u+9NfHgUlnRaE+PiZUIesvD3DRYNrq2jZ1g1NShCvIDHU2aNB8nZ9pf0pKjEl+QcFxITrmvrHS28ELpH+dtiMC19zGptQD2+EMeu+HGxsPEt3s9052tb6wRk5Y+R6IDH0uPDbNbAntvo3xtNmsVeDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApftDEmEIdsi04Rbpc9dvSE3Gmvz//fXk1BCWB5NvIE=;
 b=ogkWnPqmwGbsWPWyxrOPCwFzUzbf0wT/GzKLEIi2vJmzWHgLXny8plwY2egPprLxt/As7VonjZCHyyinz8r5jQQ52sK70QhchCoRsY0BvGzqKIw8SJMyUFEz0OqKvsjN9cs/kRM+rbldNrHUjb+DF5RKSiRQNWast25fehLzKg8l5l3aO5n70VvWaYTiKewV78bcM1VrpeR6/k1eKsouaRspsTCzFSHHVS/TrDLUbLezcZbnXFVdor0AaBSu8tT2aJ+8DGTICe4E74e097AQ+rQCEufEffX6DNlqNb0AgrjJE54uJdDq6RiVlgR/LbqEcRBRcoENeKJth4E1uREz/g==
Received: from PRAP189MB1897.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:290::22)
 by AM7P189MB0645.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 05:22:10 +0000
Received: from PRAP189MB1897.EURP189.PROD.OUTLOOK.COM
 ([fe80::91d:6a2d:65d3:3da4]) by PRAP189MB1897.EURP189.PROD.OUTLOOK.COM
 ([fe80::91d:6a2d:65d3:3da4%4]) with mapi id 15.20.8632.021; Fri, 11 Apr 2025
 05:22:10 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>, "jmaloy@redhat.com"
	<jmaloy@redhat.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Removing deprecated strncpy()
Thread-Topic: [PATCH] Removing deprecated strncpy()
Thread-Index: AQHbqp/X03pKk/HX2Eqf07yCO2AvhbOd6/MA
Date: Fri, 11 Apr 2025 05:22:10 +0000
Message-ID:
 <PRAP189MB1897827A01B6C6827EEE1CB3C6B62@PRAP189MB1897.EURP189.PROD.OUTLOOK.COM>
References: <20250411050613.10550-1-kevinpaul468@gmail.com>
In-Reply-To: <20250411050613.10550-1-kevinpaul468@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PRAP189MB1897:EE_|AM7P189MB0645:EE_
x-ms-office365-filtering-correlation-id: 1526f772-e090-41db-66db-08dd78b8cf3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?lsW3XZ4SiW9Wiw7rV4HuigT55QW+Bh8AY1n+v4Jw5Sy3QcZIc8ZA7GfIUTE/?=
 =?us-ascii?Q?Z7GaI7iEDyNvMPMXpVG9W4GBbqCmK2uWbA3/AU8kVC2r/+NAcIGKdOE7mDZF?=
 =?us-ascii?Q?Mf1h8Hqo+RcodNJUOh7M5bGuIUAQLtotDEp18pf5vvHb4oORj0YFqXtNVRQi?=
 =?us-ascii?Q?aFkRUVoBcx9v0fi0NHgjjfYDgkTgNMFczKlsUxfYcAHKtwM0qO5BOoya2tI+?=
 =?us-ascii?Q?DC0yzfpLFu3KW7YnoTRZow/G2RVBGNBKzQq1+dKOfylDDYpLzkcHh9HaRa+C?=
 =?us-ascii?Q?gOe7i3vGNXjaeMN3GCvPpdnyx7UyeESfyPkBRkBIAwnPGDdAnPGJXEdHGxTX?=
 =?us-ascii?Q?ZHmfTHhPAZaT7pS+3g91w0Du1a0GWcqKbJ1C4jF3UkadtdEyIXi72mYPvPLG?=
 =?us-ascii?Q?oPe2whlEj8Q2LR2FxD3d9SOMcu0pTsIHePhUvRRFVsvVKnDzG3V4xhEyFrbX?=
 =?us-ascii?Q?nAK4sE9XkvmXF+sz+ZxiGs0no1Ffjop/He7ruqBkqLEUTPAp40bk58Yf8f4C?=
 =?us-ascii?Q?HCacb1MNkFJoKsjciJmBX07CsQ9y3moRFtXGPWUMusNHf0xwiI6CTJRibh0I?=
 =?us-ascii?Q?JPL2GO2fBufEwtBiV5PD4sOQ32pIWgJ3Bcknd1KYmToJWh0xVUXwZxDM7Hcs?=
 =?us-ascii?Q?SRxo3owQ87WKuXVKwgphOTYSm1+TWn4AsRx5nlZT55IlTMDcPuPvtewPWwlR?=
 =?us-ascii?Q?Szh5DWM11Z9hxiP4zcDMOi51mdrCWyFsDWOBn1eDxkNVU2J3AYIJ+uqBCZcF?=
 =?us-ascii?Q?6js+8VjKP3wt4aBGAck5VUnFtbZxH/Zyw25gULpo3tezIFiAm/3er47fympd?=
 =?us-ascii?Q?logMcB3kHX7IlVF5XggnQJ3ycA9qigP3Jl1n65Hsp43MDW5G+/vElvpsStGA?=
 =?us-ascii?Q?1sCJQ53eHqfpYiG5muANepyhIV0CwVDZWZ8+5NSnLvBCkkMe3vShju6vweh4?=
 =?us-ascii?Q?2RNHtPrmP0webqvLZd4N35xYD7SzCZQuNV8OEOtKA5Xa/6FhbTumFLar8mR+?=
 =?us-ascii?Q?yHTFQpUrkyhwmPYqi/XvUc8bM4sLmhI3qfAKSOPrcOcv8G+Qk7LdGuZfZ86r?=
 =?us-ascii?Q?D3OFcivC+ilpvLMab9L1nHGWLKGqR3pFncAHdLMyPTYBeVzZOfr3eNi9l+O9?=
 =?us-ascii?Q?n2gMFbxDoHY3OARGx2RkYgUHFn65Pafxop853JJHK8mN1gW0abPyIWyUS+YN?=
 =?us-ascii?Q?RdXYAHv9Ncmbj9nefxaHG17hjCf97nW5WtyefBBeg/NnvkHFrETuovj5YY3t?=
 =?us-ascii?Q?DfTnR6mC62WBUMbakIGe/uhGVBXMhRbHTDApiekUmfsFxflcu+U1yNXtGgxS?=
 =?us-ascii?Q?O0rcTWOGCBwXMi8c0Kl/c4vpoCzhmnaq3GpiNhCH3ff3AT7WP0/vfeyqTyhj?=
 =?us-ascii?Q?PiekTjBbDRvboLE5wmBeqfRJ9L8F0CdyfZvzEX4sGR4Hx+K2kGqq1bJafQn9?=
 =?us-ascii?Q?lUk9XwyqoR9PcTvuLCEx4LI5R39N+1uTVnUaBvx3Gooc1CBAsjyW5w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRAP189MB1897.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Dq8GPmpr0QU2OpSFS5xcUBuo7RM7IV1Fa0kyuwNQDkKVAia2XooBXRgAxrwq?=
 =?us-ascii?Q?cD468p1qumyAii7zX4A//2kX3FxUUYN295xWib/rycUVSKawWLVxEk7o8qpt?=
 =?us-ascii?Q?1A2WK9EUNIPUzS53nrYiRw4Mptu4J08gfUr2Fp0Sx/gVEw2tkZ53jBaadOEH?=
 =?us-ascii?Q?Mr+oLx9pjgM1jzhQmrM9CDZ3vTZZ7yepHuiWM7Lu3gHZxaQB9G3mxxirdvXp?=
 =?us-ascii?Q?EeGEXYej4nPFgGCCLfVRdqEPNLXCVJHfSe8UrZxXKSqwyyK5CxAoe5I1UlUE?=
 =?us-ascii?Q?Oam+NKIjLh9WsRPd0wIrsZn8kYih+OlA17co2uYvbCiAH0oFJyygkAbwTQxh?=
 =?us-ascii?Q?6KVluBrOuYb37UTD852rQ3JYrC7+8kTada3Stx1AbRJa9xhtj1T3XVPb45nM?=
 =?us-ascii?Q?s6UTt+Idt0y2xM6eX0XJDgYboiBdZGZKo40TSmeLzTrYPkV49ubxwGNbyVSK?=
 =?us-ascii?Q?6i3g9zCuW75eLc4aRYIP38vXKm+23qO4bfJixP6UgFJ5XNWSEXQujavofWYj?=
 =?us-ascii?Q?hVG+EjtDuwPhhxU+lKO8Tb+cnbQakCVSs/wzLSahVlGaftc2T9nZ26Yh3VP1?=
 =?us-ascii?Q?LtzSRZktrtf9vlUJ/2LcstkgQwWb5uW/wwb9pDQ8UZxxdOKo6N7sfUP+DH95?=
 =?us-ascii?Q?xi7DBPivMqfc+IQAn3M3WsMVn/3UKp0Cn/JMRbgfXJoMWYy1ibvv1mtYKrW+?=
 =?us-ascii?Q?oXXMR+XyljUT17JXA/xjLOfJIm/iUWkWxtkuLBhl4w1FSyXolypxFFkXvgtn?=
 =?us-ascii?Q?/wFfZhruNlgmi5XHq2eqkOhzTDxK8bhNVx1sfHyArQHNKDkAb+x/bnuiyDXx?=
 =?us-ascii?Q?93te/pFmT4R/56l0IOrz6LQaRqIzGQRebp4B1Qdsc/rcQl3vc1i9EeevTP8i?=
 =?us-ascii?Q?pB8Rn+9StaIyDBP1hUMwHF+YPRc8YfGJcq1eVprpM/ItbYbtIfz2doT2Jdvk?=
 =?us-ascii?Q?xbbHzJviViknhPdp3wwuZWsrdNibvp+jMvDyzyvenTD8rRHFSUmweBwcmMWm?=
 =?us-ascii?Q?iWDQIVYXxGmGEGqaBGMX9hxsLmNnCabJEJdiBbCu680QfFfJXkZEdz8mZJwx?=
 =?us-ascii?Q?TKZlx1aOyIlGp0W6efDb9I0ZBA/p4mYi6K3L0chGLZ+eBEErEYk3UsxXBPJE?=
 =?us-ascii?Q?taVH818G6gCXAIlKdmU3/X7+QrL0El35GeFTipvtUyFt2t+YHltjN3Q8K76f?=
 =?us-ascii?Q?FuAjuOen+dwNheCkygzhml4eeEyZ3W4jtVfO2I4N/5pL1O4zV8Sg8wuZOZrM?=
 =?us-ascii?Q?rsPo4fBqvzpsi9OZm1mPDQ8/mZMhAEmGUdUnzJDShTUa/Wbimj4p57uBMUU5?=
 =?us-ascii?Q?UKIorO+Mmn7tKEcSPFiwidjHIh0qswEgiDWA4wS5BkNVPeSmeT4v2/gsnJsT?=
 =?us-ascii?Q?X6lN4Ii/RLOBqa2UU1ElRlSiEZauUOTIC8jc2m8GTCjhUGR+G4z2FSAOkqLM?=
 =?us-ascii?Q?ELsGloE8Mt4GS3xU9sx2ZE45/N9/BDoJNGy6B6nO1PkIkJ3LQSAF7zt+w0aZ?=
 =?us-ascii?Q?rgkOPBHmycP+S4O1OCjAhgqF5UPRv9IabTOWffqKV0ufowz6PLr/F0/TNI3E?=
 =?us-ascii?Q?fQw5FyiWv8Lt1815dHEPqp51WWH/CGp7E1vkOjn/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1526f772-e090-41db-66db-08dd78b8cf3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 05:22:10.2210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hNoUr2ZPEwbT46929LOBpCbT3Qjfkvgl7WyJ5vy5bNZPymH9Ln2EjjDq+nr5rd5hh7v22v+osCtKZEuR40aefLqGam+kWABV0QKVxUUgW0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P189MB0645

>This patch suggests the replacement of strncpy with strscpy as per
>Documentation/process/deprecated.
>The strncpy() fails to guarntee NULL termination, The function adds zero p=
ads
>which isn't really convenient for short strings as it may cause performce =
issues
>
>strscpy() is a preffered replacement because it overcomes the limitations =
of
>strncpy mentioned above
>
Please read my comment for your previous patch:
- Add "net-next" to your email subject like this: [PATCH net-next]
- Fix many typos in your changelog:  guarntee -> guarantee, performce --> p=
erformance, preffered --> preferred
>Compile Tested
>
>Signed-off-by: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
>---
> net/tipc/node.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/tipc/node.c b/net/tipc/node.c index
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
please merge this change into your previous patch. We do not need a separat=
e patch for the same purpose.

