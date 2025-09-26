Return-Path: <netdev+bounces-226583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16481BA24E6
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 05:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C65E83AE0F3
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 03:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABBC18DF8D;
	Fri, 26 Sep 2025 03:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="APhXyEU5"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011050.outbound.protection.outlook.com [52.101.70.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC2111712
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 03:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758857650; cv=fail; b=ghsOG8t0pe4QkAyze81ScX0STPetQ08Hb+BLN8OhkBx0EyHkfBow2g1cJF5iO7I9PHsWiJAH2oUmMs00saT+q8zfFYBUIXIEsrUvuAOIMt5E271AKhjgIoJPBBN6O01u9+g7BWiS7wYPa+pBo32BdCZ47z72DJYchjMPia9BbiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758857650; c=relaxed/simple;
	bh=WFWbOew4guTGlqx8grvdHdIH3U9FKWLL4NJArMwXtWQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KUZ/Dz3tFReDodE4q96/b0gUaBgccV072k+49d8oFxoXw1DA8tbsTPpVGcvAUi/JQ3zm02NAaDvCBsCekm1l/eq/eSp5/VosWsrlbKxupzUK460TlgEDi6KolkeALHSvcSA1xX9WMGAZzdVUJdAdT58luNe3gSIy0koWA/mMYWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=APhXyEU5; arc=fail smtp.client-ip=52.101.70.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1qeTFGwVRRYiC/+8ot1r82hkqJ5UGFh84ufgdfjZwQ7wc1144vQvfMxzvxtOODRIJS073pjEsPL1MrZQ9W2CZ8b9dFcq+0psfior/46VvU0O4xiPT8Ed0gpr4SXWBJKVPvh7ecNn0VCTOunU/eL7Zjv3lpDluNbtMOB+kjpiJfa6m82oQKDTH66ud/CuT7sGgSU59w4HKNvv/gpKGd/xQBT0Wvh0ecGGmkb+QCG+3gNLuhUSF9nvlHY09hdBma7qZY0PclWp1+wyqVJVRngNocmBtVn2khd3i1tBXL4DvXFpssnQwZfvMwn18O9O9B3IrH0kPVG9bhhVcZD0olTSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MP7Cb4Hrrw/vfObeTVxIH4T3ECfGJsNbSkkaBn2Okkc=;
 b=Q+vxxihhOK3Jq3/OvmcD/L9BNYOXrnzyuCXvgFEVUml5k5XGQL4WL0kNMj6Nvwv3/fWn1lCvA9vueut3JqHZEoKY/GqGGGwMAuQUfCscYHm6PQwOZRqQbsAGeqnJXp+Qi0AxxRV6iV3lMWO3xCqL8LV2KVZYm7l7p4oc9eDgg69ONZ94C6CdPJUoI96KWFGg1jEBGfTx6EHhK6pzHzaWxlaPmydyeAlwNrrOL6xbcemFLVmN9ZtUnUacwcw6hMV572flYG7zxGy5SBnJ6mUACGIwOBKGnR+nhn41K41GoBwqQkHCSOCwaqqkCZbRhTMycE0DAARBjkhRuDxDe7y/EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MP7Cb4Hrrw/vfObeTVxIH4T3ECfGJsNbSkkaBn2Okkc=;
 b=APhXyEU5sQpdYAzIGWyeXYWEAHyS5nTcW/N7fQZFJSRZbw7GaAyIWq/WY5Qf70g+y/s48AsvhVwnaMbW6SlidhxSoVc/tI+utDg4oJmAPhNmfqbdm90rAaAnACbfIysBV7SiRYhRZ2fdJHD2s4bnR3HcHAHrrFU0t21QESIbGmDf9TAZmAMN2qAoCVRwuKYeViq89SnoFZBXpIVAsMAy0a9GV21BIYnNaFw+gWfvJ+ypH4X5sLQ+KY3ROViSxYKIbQwfvLEH7v5YrCYcQoJM5a1AeYsvFPQRv6aHjjoky5PJz4Zagtgjre6uJSQ7TGMoVX8yLIt6uT5W6lFq7NBoqg==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 AM0P189MB0657.EURP189.PROD.OUTLOOK.COM (2603:10a6:208:1a1::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.13; Fri, 26 Sep 2025 03:34:05 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::43a0:f7df:aa6d:8dc7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::43a0:f7df:aa6d:8dc7%4]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 03:34:05 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Dmitry Antipov <dmantipov@yandex.ru>
CC: Jon Maloy <jmaloy@redhat.com>, "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>
Subject: RE: [PATCH v3 net-next] tipc: adjust tipc_nodeid2string() to check
 the length of the result
Thread-Topic: [PATCH v3 net-next] tipc: adjust tipc_nodeid2string() to check
 the length of the result
Thread-Index: AQHcLjzx+V/0POurb0CQVwNDZEOklLSkzBJg
Date: Fri, 26 Sep 2025 03:34:04 +0000
Message-ID:
 <GV1P189MB1988AF3D7C3BC2F0F8DE2491C61EA@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20250925124707.GH836419@horms.kernel.org>
 <20250925165146.457412-1-dmantipov@yandex.ru>
In-Reply-To: <20250925165146.457412-1-dmantipov@yandex.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|AM0P189MB0657:EE_
x-ms-office365-filtering-correlation-id: 1709dffd-8a1d-4162-8e3f-08ddfcad8b23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sQz+VNMzk0kEZ7XsgN77XXT/dTX6vveWRBbsNKtY8sn36LsOAIew3AAV+Bm6?=
 =?us-ascii?Q?Qotp7ezR9GlR3JwQiOinMmIW+RJ19szpvn0xcXNVEi61BE0DnPRuZsOXLjNa?=
 =?us-ascii?Q?bV/g2UO+z4+XF/ZjHPswolWOm9kx7YVv0pwI+8riieHxZAQJVOfaGM3F9pKa?=
 =?us-ascii?Q?tzwba9CycYpZes05xmkNYuoa/SkFktocQ82d8cpOeFk+Mzva2IisjfRi9RA4?=
 =?us-ascii?Q?QHVCU3svMTGC85Pw4060SYy3+d4j3PIcusNlJhXU1iJfkx1fGN5PIKjcGE6Y?=
 =?us-ascii?Q?HJPnUpWloA3T7owtdGAPyK5J/4zr92VhOln7lkOJLczXjRhQqeuGJY1B/WSe?=
 =?us-ascii?Q?8Q6wyWjwuFsaorv51UnF2gPjB3dxj+aw7njKR5PzdW2DtpDVFAIrg4zvgeae?=
 =?us-ascii?Q?2MquDaRMJ/7W3Vw+RN9FH8UPv03mBs952uTR+v1O9AtoSmISw/5Aywp04CF6?=
 =?us-ascii?Q?N26yp/Bn22KVPgJ6PcEL1VeAifREJMnRmHXByFHYTCUtw2PYhRIspMzcFEBB?=
 =?us-ascii?Q?99ZYs8v1OBwYSqmVeUG8M+03Kr81UGvYcM8oxVbIHLHCc3ZVLvXa6GcNhthq?=
 =?us-ascii?Q?KHUqq2FOZR0AEmuat1w4TKTaNtnmnkZIuRASRFhN6/hdsaD1iBhy0R03+291?=
 =?us-ascii?Q?kA7STmE5TpscLgOTtlTegkr1FNHw3rvXATcczfY0bwrrI+6TbPhx+ydJlTIN?=
 =?us-ascii?Q?Zk8RcNHkBPuGKeB3Sz0m2tlnO69FO/eLRMZ4kI7raGPJEImR+L8tg7Rf4cTC?=
 =?us-ascii?Q?TjI7n7Jhfl7eMNsVKZ/61LxG/6oJLQMNaFfQ0E7pBTVJ9Drj1VOOpkvhWd1w?=
 =?us-ascii?Q?8WqFW+mSiYxNVC3GhadQuJJMnf0ZYJUVV2GBuO2dKFjhzmvk16Ye4S10eh7G?=
 =?us-ascii?Q?1CcMbm7GcO+2LOD4wJRa+8+Ua8QdJLKqNk60CUG0FMZrzMj1WKo4m45KRVO9?=
 =?us-ascii?Q?//7DCw6WOGfNuYw2qkQrIc86scMNd6GUayNO5Nr2PaRA6k/5RDzkJmMNLPW5?=
 =?us-ascii?Q?Ss9f/GQKdKb/18DIGB7HCHFT1Y7sWQ9Wzc8+z3gY8OhTD699++XfXR9G3xxs?=
 =?us-ascii?Q?ikcO9I3ENN0yNHHYjCuPcwRXrb60j7UudJBqU/y0H2qdDo3ZBVlTO76OnBIP?=
 =?us-ascii?Q?SGOwoqckVxI9EHeb286cF5M4XsGojQecd63lCceIoV+c49XwTQ5FRLfur4Ji?=
 =?us-ascii?Q?oLdZzWNkDggNRQUhpz8sXsjIr6s+UmmO5HkiWJHEjTDkLHNdjgKknFBJTKY3?=
 =?us-ascii?Q?zxoSvGXRUELblJi9w5uPkRTcNSlgskHpSzPwtTXV+QdMUKVt5iGZMAnC5Z/q?=
 =?us-ascii?Q?F+OeKt4CsYGNwcBHkO79wl7MEFWVnBCV1K+6F8YTb6sz7i40/V+fRb03reS7?=
 =?us-ascii?Q?KD6EFYBDVmxZF5QVTbbHMkGeLirBZ1fOYmC0VUAzEz8AvFtGQQsEG84EgP2N?=
 =?us-ascii?Q?b9hnrdvbJV7wUy3Lsb76LznGgv7kS/ni6T2WfnadlMUS+3P6u6CpPwmwIhAE?=
 =?us-ascii?Q?Qn6G97VcaBk3FW2/uzfQ+K4lwrnrSfnG3Llr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xigRb5UZdvXkpPA2cwe+s7CFT6bl+eBouXLLKUcMjWMDOBnYqNb5V1VFKMZ5?=
 =?us-ascii?Q?mqysNRf8jzadOPJ7MxGij1F2ytnawVQ86bvN3KmQqJxrFcetWP7DfKgLd1xr?=
 =?us-ascii?Q?9WgKRA7LFaT6BkxWP5CdApZtcNLTr1IdSO3mgnrOQ3lUsgJd/OuyBU7v2fs3?=
 =?us-ascii?Q?4S9yusDWedoRWcI9fSZFCGpg17mSyWhXldSkB4IdIZW96kYrGOk0gT4hnwlG?=
 =?us-ascii?Q?bIjYavg3p8utlfJDZDD/eXYkURZUXhz5A0tNUr1H6EJkkn8RNim26/938c5H?=
 =?us-ascii?Q?tYujk8wIJWRxB558wO/0FxQqRXjwjlO4O6EZ4rJdlbD4eJwn5FEE8HyATdIM?=
 =?us-ascii?Q?/+532DAY9sq8KPqGLF9sU69/QMYZGC9N2c8YXoU3BQeee9a/blWHQVGpYb4e?=
 =?us-ascii?Q?Tsgo5Cp43c9vIn5/OJ+QV0QrB+ivzk30XDjQP8WZJzREYTjv54TaXZkK+3eU?=
 =?us-ascii?Q?pXpFrgMK+4LjXx41mu2/mbTkj8wqYizBff7sEioiBOMSQy1rFq4hVUPsAOha?=
 =?us-ascii?Q?uEKwIsdHQwV3iRxeDK4YZGO3koV/0BlBnKuwwbjbovbNCvs8qIM0N0StORym?=
 =?us-ascii?Q?MXIPrfkgNBdQKFNHydVemeam27emNWpGCHEBE7PEXe+kxH1zMtQen/Bh3qvs?=
 =?us-ascii?Q?Cp39VQAhRfc6tBK2aKLWRAC3KyHoIQb4uuig1Hng9yM96ok3SkY9uvzZo0gv?=
 =?us-ascii?Q?LUJVkb8ZhTRF/4gMapTv+sax5yBw8r98vNmr2uR4jKUm6gPcbbYDDLiBRfki?=
 =?us-ascii?Q?USjDbuFYs85QkZNxUM0Nkeh4P8ClnxKJ5VLK/7Q00lWNwLB8aNUfxuRDB+VP?=
 =?us-ascii?Q?DMa6dWGz+uYlsEeYmmRC7gTpR9FbsQxyCR+3mx292kDVncDctXOM5CzRfFQQ?=
 =?us-ascii?Q?+aW7a/dbzmZh5/mH7rgl547lmS0ho54vck1f8rgNBU4iErNHLIGWHj+svGGr?=
 =?us-ascii?Q?hKV3DJ5t27/SbNAhy8iMR1zNuSGI6f8ZSCgpkH/k4CLktAQGqnSJN7DE/C3b?=
 =?us-ascii?Q?3xdvZVcYtJmvSGes13IybA5UFhs2/YkZPoMY8v61cRY36NUUCtNGTytbf+IZ?=
 =?us-ascii?Q?Zzh7bT4DhCOBiqktC72PwIpCG30PkHNHHf090qyuoaZ7zLzL6lpTjkGBt5bb?=
 =?us-ascii?Q?Oo3xcLd2wu80cp3yDM4JUnN+MvuonO/dzMX2QlR/FJ5/yFf5vjSLB4hIctWI?=
 =?us-ascii?Q?EaAMSlm6xUNkxXhofVCHZHBRv3dklDtbNOcjBpZwxy2pbcbOrBHvf+iirb1p?=
 =?us-ascii?Q?TK6e9gGPW2T83rs6Nab/dKbksWp3axxyV1qmB4TILPCtyL6otDicLgWHEjfM?=
 =?us-ascii?Q?icEKshK+pPuQmjD9PwpVL+AE7ajXrhvkpeFv8zJDcpnqaz4ZkgJaspzClvv9?=
 =?us-ascii?Q?J15SYPeCrjxTxjNpNZTkTDSoc1JKDr8p91nnAPRt6QS6zcTCaXFJDVL32bbx?=
 =?us-ascii?Q?WnpaYwi/tYKsmBFyd3ffR9PwkbYIHZexFX62rEgGmLZsVDpI1Ido8N15gvf0?=
 =?us-ascii?Q?dLsY3zNyN/xClR2ZvKCTT3Km9Gt349+sTdDtb0WonW7IptjKlExgb88jauYx?=
 =?us-ascii?Q?0GF/WoeeynX914l0momozYilsRwD/xXw8Gt9kySp?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1709dffd-8a1d-4162-8e3f-08ddfcad8b23
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 03:34:04.9859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i8ruiJrirrlekAP4PM9MVYPP625nnXVTC0A08cGmYkLdW1IFflF1jc2AGDoS1VaOyJQiGYLHgT/g/wSNSj7zR1pHjPZMX+2Aw0M4tAcbxZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P189MB0657

>Subject: [PATCH v3 net-next] tipc: adjust tipc_nodeid2string() to check th=
e
>length of the result
>
>Since the value returned by 'tipc_nodeid2string()' is not used, the functi=
on may
>be adjusted to check the length of the result against NODE_ID_LEN, which i=
s
>helpful to drop a few calls to 'strlen()' and simplify 'tipc_link_create()=
' and
>'tipc_link_bc_create()'. Compile tested only.
>
>Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
>---
>v3: convert to check against NODE_ID_LEN (Simon Horman)
>v2: adjusted to target net-next (Tung Quang Nguyen)
>---
> net/tipc/addr.c | 6 +++---
> net/tipc/addr.h | 2 +-
> net/tipc/link.c | 9 +++------
> 3 files changed, 7 insertions(+), 10 deletions(-)
>
>diff --git a/net/tipc/addr.c b/net/tipc/addr.c index
>fd0796269eed..90e47add376e 100644
>--- a/net/tipc/addr.c
>+++ b/net/tipc/addr.c
>@@ -79,7 +79,7 @@ void tipc_set_node_addr(struct net *net, u32 addr)
> 	pr_info("Node number set to %u\n", addr);  }
>
>-char *tipc_nodeid2string(char *str, u8 *id)
>+bool tipc_nodeid2string(char *str, u8 *id)
> {
> 	int i;
> 	u8 c;
>@@ -109,7 +109,7 @@ char *tipc_nodeid2string(char *str, u8 *id)
> 	if (i =3D=3D NODE_ID_LEN) {
> 		memcpy(str, id, NODE_ID_LEN);
> 		str[NODE_ID_LEN] =3D 0;
>-		return str;
>+		return false;
> 	}
>
> 	/* Translate to hex string */
>@@ -120,5 +120,5 @@ char *tipc_nodeid2string(char *str, u8 *id)
> 	for (i =3D NODE_ID_STR_LEN - 2; str[i] =3D=3D '0'; i--)
> 		str[i] =3D 0;
>
>-	return str;
>+	return i + 1 > NODE_ID_LEN;
No, you should not do this.
Firstly, this makes the function look vague. tipc_nodeid2string() converts =
node id to string and its return value if needed should be converted string=
 length as you did in V2 patch.
Secondly, this adds unnecessary overhead in case we use node id that is les=
s than 16 characters in length (For example, tipc_node_create() calls tipc_=
nodeid2string() without caring its return value).
So, just let callers of tipc_nodeid2string() decide what value they want to=
 compare to.
I think you can improve (in V4) by replacing 16 with NODE_ID_LEN to make it=
 more descriptive (in tipc_link_create() and tipc_link_bc_create()).

> }
>diff --git a/net/tipc/addr.h b/net/tipc/addr.h index 93f82398283d..5e4fc27=
fe329
>100644
>--- a/net/tipc/addr.h
>+++ b/net/tipc/addr.h
>@@ -130,6 +130,6 @@ static inline int in_own_node(struct net *net, u32 add=
r)
>bool tipc_in_scope(bool legacy_format, u32 domain, u32 addr);  void
>tipc_set_node_id(struct net *net, u8 *id);  void tipc_set_node_addr(struct=
 net
>*net, u32 addr); -char *tipc_nodeid2string(char *str, u8 *id);
>+bool tipc_nodeid2string(char *str, u8 *id);
>
> #endif
>diff --git a/net/tipc/link.c b/net/tipc/link.c index 3ee44d731700..93181b1=
d8898
>100644
>--- a/net/tipc/link.c
>+++ b/net/tipc/link.c
>@@ -495,11 +495,9 @@ bool tipc_link_create(struct net *net, char *if_name,
>int bearer_id,
>
> 	/* Set link name for unicast links only */
> 	if (peer_id) {
>-		tipc_nodeid2string(self_str, tipc_own_id(net));
>-		if (strlen(self_str) > 16)
>+		if (tipc_nodeid2string(self_str, tipc_own_id(net)))
> 			sprintf(self_str, "%x", self);
>-		tipc_nodeid2string(peer_str, peer_id);
>-		if (strlen(peer_str) > 16)
>+		if (tipc_nodeid2string(peer_str, peer_id))
> 			sprintf(peer_str, "%x", peer);
> 	}
> 	/* Peer i/f name will be completed by reset/activate message */ @@ -
>570,8 +568,7 @@ bool tipc_link_bc_create(struct net *net, u32 ownnode, u32
>peer, u8 *peer_id,
> 	if (peer_id) {
> 		char peer_str[NODE_ID_STR_LEN] =3D {0,};
>
>-		tipc_nodeid2string(peer_str, peer_id);
>-		if (strlen(peer_str) > 16)
>+		if (tipc_nodeid2string(peer_str, peer_id))
> 			sprintf(peer_str, "%x", peer);
> 		/* Broadcast receiver link name: "broadcast-link:<peer>" */
> 		snprintf(l->name, sizeof(l->name), "%s:%s", tipc_bclink_name,
>--
>2.51.0


