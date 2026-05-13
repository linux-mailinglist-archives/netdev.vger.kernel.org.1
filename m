Return-Path: <netdev+bounces-287430-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDfdBssGBGoHCQIAu9opvQ
	(envelope-from <netdev+bounces-287430-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 07:06:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FAB52D722
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 07:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95F61305A5C4
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 05:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A159639AD34;
	Wed, 13 May 2026 05:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CtmcVaal"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C597439DBFE;
	Wed, 13 May 2026 05:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778648675; cv=fail; b=Vj3bcpG/qnpxdfNvlFnQeJe+0fJKwbN6oR+jCHpQ5TiO8jS4B02SCgzkZI0dhcHniNGQETi7syold0jUjqwYzoqtzMbQZgNSEZ3ukqkBgkPLfKHZTl4kazBYhBYblMdfRjpkNbKTBvjFZYA8i+u3L9NEPTSaaWCgW02TuIr4z8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778648675; c=relaxed/simple;
	bh=Dw6bs89LdT9J7hINQH+ddtA83ZE1fPPy6C2HENnPykc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lAfdC9DMOMrFR8DlRYmHTi4Ro6lrouBcrWPh3L05ll5mZBQXt1nLw3OyFe/Uv/oLxQ75NfUpDbNFqq3CbRSXs7rnFf3Tc9wZi8m3pQNell8Jel+NsR8UsxXvK8SDFRdLR9v3+25JPUEfK0tDF8OFGgiOQeDYBUkOA+Q438/NsYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CtmcVaal; arc=fail smtp.client-ip=52.101.46.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFdc4g/fbLYWCUfuK3FNHndiGT1vtmfOtUY9vcnwbcplfPnemJe03pJuDMhTViWDi2Y1qQuCb6/mOIajr6k+JNwbualt+dX/LGh+91epEsJ4bSg/kmO7Tr13ATPBCWFoUDBdSSKgCMtgwJUozPp74QwtoAUS0VZCfxPyqf4izIcgdW/Ueq3M0z6fQqxalL7X9mILrL/KRR6T5UhPNBy/Pb3D8i6ZhCS8z9gDK+d2PC6qURxgMzRiXWR1ESM70uUzDAIbghlxs55PIaFIfavHtF5TF2jLqwDTE4oFoBXN66SQCIJP8yn7wH7fdqHlmsM/55/Me1LUCGBKkjGUex38lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLVglwZ8WEiC7bxza7QUN8GR/D0E3mN3LbzE1sVHa9Y=;
 b=YnlNI+NvcaWv+PNkrda41E2xug/BaWyeKmNN3BeVQ5ugbTgk11e2CnQQwrVs7p2KwpSRnL/lB2EGrgTL3fjyk4wHrRIvSZSNOflQ2dv7bzmPmvBOzwhsoHWSmd/DNYT7RlLYjHHzmZyETOkxxj+Tx/qHbCck6gV1UtmFMbntivWIjB7RYfeI1CQwQqfXDdlmKg+hDnhahOoQxSy9GCEEnSqN+a66N6MPynoTD+XNA7J0d/jtTlpULxwgnbMi7eLOvkVUNZuJJsB8g+RWxFTIIsGh88NAVGv5ijjBq69pFem6/jX+kev0VlnVWlxi7PiOwvKhj7pFSUlZNKdSpHXfJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLVglwZ8WEiC7bxza7QUN8GR/D0E3mN3LbzE1sVHa9Y=;
 b=CtmcVaalpnhjBQjxtCPL15/+PY7/kP5IQsK7TxUbfXhvNDf2yLnZ3QtElBV1m0KAOW7aFt/ik+He+5x45kQbhkRYRqZ/e7w3aCSsRR+bmKUleEZGE+ECJ7NSSa81tSRhX0wojxE+x2GgHWqO1ULyLrGltGHsZ78cpfP7p8Do7T0KlszlMapCzwfEd8D6P6jTfeIr7XSxsZDqioUM95CZi5pgpcpFOHpkPqx1HhJWUH6sRXnw139gFkuy/iaMM6JY5hoC3TQVT2QvIXibVSINIB0XtYadETgNEDYb7YMD5S9hWwTx29uPfFJWWbIEZJz7z0w5y2kxB32bVJzCfvjk5A==
Received: from DSWPR11MB9715.namprd11.prod.outlook.com (2603:10b6:8:355::17)
 by SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 05:04:23 +0000
Received: from DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139]) by DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 05:04:23 +0000
From: <Thangaraj.S@microchip.com>
To: <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <Bryan.Whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v3 2/5] net: lan743x: read SFP straps from
 PCI11x1x device
Thread-Topic: [PATCH net-next v3 2/5] net: lan743x: read SFP straps from
 PCI11x1x device
Thread-Index: AQHc3qqwBzbu6zIHH0u0D6F1IWYCY7YJqy0AgAG6uFA=
Date: Wed, 13 May 2026 05:04:23 +0000
Message-ID:
 <DSWPR11MB97150F2087E6C59D88297C98EC062@DSWPR11MB9715.namprd11.prod.outlook.com>
References: <20260508052150.11852-3-thangaraj.s@microchip.com>
 <20260512020842.838975-1-kuba@kernel.org>
In-Reply-To: <20260512020842.838975-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DSWPR11MB9715:EE_|SJ2PR11MB8587:EE_
x-ms-office365-filtering-correlation-id: 0ba68fea-1f35-4ac3-d01c-08deb0ad1927
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|38070700021|56012099003|11063799003;
x-microsoft-antispam-message-info:
 90TLr/CWdBQg5GAKlKN51KC6HIM9u1kXzPMFHyIIuEU9VfseEI7F4aytzG4P4ZO7JpKEtv0tqiwl4iY0l+0G2J2i1Fifd0WoJxIv1UzflC1P6wE8CNCRAdIH8uwj67C/2w5Z3CH0huZ8rhzdx0TsZ3eFbMEgO0PKtAqCYBm1sEG5skvOpf8HQAvm+nHCqU9ehDJ8z3y25aejEUAMook8aNH0wjKeyhj+XatmhPgP9EC+D2LewUvlaE7BUMiyDw3ZgWOe4jOdYkkPM+80/lbUOgykEdpn9vu5JbgemFgrtpJvtIvlHTifNQZPQRGQHOZ0eQZr1Ea3acd1j3c5ZDr0IyHJDH1KMJabMcrF0QTbeTWfqo3H7vP0Nj9+WgmdIQSL6TQIZY63LFWLHk9GUv4HiEM6YH0BgUbFt27rhl/x9cCL3NwOanVrn7M2dM8qInUgfEA2Qh+WKvt5qOuvgeGyCEso3x1laRf12TmQuOrJXNPu474Kv7eO3SGLikpB9uK0PngYQ0Bz79edxQc20K+6xvsCeyNzwFSMSiWZERv2N8dLd1yZNE5XYcuh5s9jwP/9ZbAFzdPxcgikFPfkjN6CwN4NPiJzTGy5iHtb2uZeNaZmaBYaZ2FymcUkB/qlyqWqCOqH28rJWCBa+nS9YvKKmee8xR1Jj/BDZ4TTLm1UcfjTF0NKnG5ZR0BCDiziAqXfSfG/KUw3XWPxXyET03ATGxRf+QQ/d08yfznxSc0GCopGOctibAvQb0wHqzQitp8S
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSWPR11MB9715.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(56012099003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UJD97Ow9TmZqGGHwT5/UOaa8WT7HLxhCtvimItd9YMTcNJzeBPFOXt9etpTD?=
 =?us-ascii?Q?Nsr9XxgNgLhLDoD8m4Bp/avCO/O3E5YWisleRC/OGVF4m7TCP3dq0DOJ+8DO?=
 =?us-ascii?Q?YjS/Xp2OFMxquughOmZL/gdPsC20wd0JeKYlcvm93pzQK0qmhF9QRsR3T/2c?=
 =?us-ascii?Q?5Iga4hKMeMA50MozXJpxDlNg25mBg6GkN5tbKfSslI7iUDlmfMUcqRohvtbq?=
 =?us-ascii?Q?cnCqWivkX6aIGUHnNZBnExgBpcCt/XM50tvDxVI6BZPqw+ZGXiZVqyz9tR1r?=
 =?us-ascii?Q?F2V2H0vXy8M8HOrUFAOfmP4Mz2EUmX8/er1u6irGjVFIF3eLNfTqAKe0iFsG?=
 =?us-ascii?Q?Y8S/X2Mkth8wFdZlLYwOC4QmPqtMJQ8K4o6SZXQjTKYVxbxWgAkcfjeYOlX6?=
 =?us-ascii?Q?UnBeOimP3GktxNxyzdyemT+yRDzWf95ColRfvaIVejnoKoKsLXyzPqehitc5?=
 =?us-ascii?Q?3wGhvgKe++5kSqY13N3Wmfkk/6rBXdLtQnSwnvFFHA3YEU+ZdioUu0r5HKsc?=
 =?us-ascii?Q?Qx7rC6MTgda6abAPr7Pj2Zr/zIl844gETch84Q+1FVrfqzZVrWifjdB4SzQN?=
 =?us-ascii?Q?iB9c7RSzpnznYVGbi3+zSczbIT+2fm9NRYHQkDgexsuza8ND7AYz5DcPN+Zo?=
 =?us-ascii?Q?jFlP7HTWNURtOHkj5jOiDzkwpOkFsq1dVqWQvNHPIIyqMDg4SfMm5ICxey8H?=
 =?us-ascii?Q?xN+6bL2TiwqBFVusT1MCprfXIKRU5+7VZaASHrzqlIOYjhNhn/lMP6b245/p?=
 =?us-ascii?Q?hmJzw3mSetTOdfts4Pk6lQbGgkHzjICWMgGWCezKjHM1PgrlfUTlNw1edDs1?=
 =?us-ascii?Q?GQI9mCDLHtX3BwyLNWglo5a7XKmLDsYaqm8lVuxCTtOIkGl71St8Fjq8mAXM?=
 =?us-ascii?Q?PRRGjfjc4rSsnr2smKinPBvElKyC1wo4LY4frsiV55AxE5+HUvBdAf4U38oy?=
 =?us-ascii?Q?3Vlw0XYdx7/wWioJlt8/wEbK2ACuOmQtenUx26j3z4bvbM25TAqQEjeWdqhH?=
 =?us-ascii?Q?UxXHPb59ft3XQGW+OkwQz1sG3r1+heioou5Cf/usu478Hg1N8QVroVvaTjff?=
 =?us-ascii?Q?dodrwPNhHPjs/SqT2ccEWTTfLS32mvQsGUfTiKYL+ec1p50Exn6i8bFvQMGR?=
 =?us-ascii?Q?WLFjVRH/tqG2sbMxCG0/HnMd/0OJur+KNUYKt2+4hAtQl7NsyZFfU0NfOSqp?=
 =?us-ascii?Q?SB1Wz0tP48Qv+yJmjL6B2jaemInUVqjEeMvnVuWpb/l6tmmUoSElgH+V9j+c?=
 =?us-ascii?Q?Io+QZgIFSokGLdUkLJVIwxmDx8W5W5+t5yFK54g2ps/lhV67LjR+mJealggH?=
 =?us-ascii?Q?gySqaDonnkEigxVJaZi0UkOjyKJK/4eNv3satp54A12nYZIGR6vQnK2kdNKP?=
 =?us-ascii?Q?5NyCHSfQPmwnjN474myzg305Mo2h58t2VdrZvVByCKqyHEpz2739NtFNsttg?=
 =?us-ascii?Q?60ngFg61fo6O/EHkePs0AJ6fp3v580IZcYpVTyZ+ZVTsGeRMRZUYzUX39uMe?=
 =?us-ascii?Q?D0T1odkVI9ut2oUyLyEpR9ifOq4grHk7MiqYNJeS4rJdyCE5gcZRyVE9wi1v?=
 =?us-ascii?Q?mrvtoQ8jgtWIYHZYCjfpJPsIQ3kgiai7vOMTs3y9z5rA1XKP3E2l9eGjEoKv?=
 =?us-ascii?Q?iKv0tmpUNFtwcwLgCyBPyEKyUAnVgamQ1pdKWk1wff47m252n/ee3g+Zplvs?=
 =?us-ascii?Q?1J1kR0XwEkfdUAUml/CPlSl/1PYXcpVlH721rrhK0Dy9l+nluq6f6Wtdmduv?=
 =?us-ascii?Q?nREp11n4MA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DSWPR11MB9715.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba68fea-1f35-4ac3-d01c-08deb0ad1927
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2026 05:04:23.0648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsh7sg0Jl9vT+u/WAozltqv+BGsYv4/N2htX9lP8KPt5ekte/0j0/e6br9RVq47Ug64by6/o26k6kSFQU+BTaD9cDAjtKoCoCHnnf+jktKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8587
X-Rspamd-Queue-Id: 75FAB52D722
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[Thangaraj.S@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	TAGGED_FROM(0.00)[bounces-287430-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:email,microchip.com:dkim,armlinux.org.uk:email,DSWPR11MB9715.namprd11.prod.outlook.com:mid,davemloft.net:email]
X-Rspamd-Action: no action

Hi Jakub,
Thanks for the review comments.

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, May 12, 2026 7:39 AM
> To: Thangaraj Samynathan - I53494 <Thangaraj.S@microchip.com>
> Cc: Jakub Kicinski <kuba@kernel.org>; netdev@vger.kernel.org;
> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> pabeni@redhat.com; Bryan Whitehead - C21958
> <Bryan.Whitehead@microchip.com>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>; linux@armlinux.org.uk; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH net-next v3 2/5] net: lan743x: read SFP straps from
> PCI11x1x device
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> This is an AI-generated review of your patch. The human sending this emai=
l
> has considered the AI review valid, or at least plausible.
> ---
> net: lan743x: read SFP straps from PCI11x1x device
>=20
> This commit reads SFP enable bits from the PCI11x1x strap registers and
> stores the result in a new adapter->is_sfp_support_en flag, with a valida=
tion
> message when SFP support appears to be requested without SGMII.
>=20
> > diff --git a/drivers/net/ethernet/microchip/lan743x_main.c
> > b/drivers/net/ethernet/microchip/lan743x_main.c
> > index fad4a246e06e..867310dbe9ba 100644
> > --- a/drivers/net/ethernet/microchip/lan743x_main.c
> > +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> > @@ -62,6 +62,12 @@ static void pci11x1x_strap_get_status(struct
> lan743x_adapter *adapter)
> >                       adapter->is_pcs_en =3D true;
> >               else
> >                       adapter->is_pcs_en =3D false;
> > +
> > +             if ((strap & STRAP_SFP_USE_EN_) && (strap & STRAP_SFP_EN_=
))
> > +                     adapter->is_sfp_support_en =3D true;
> > +             else
> > +                     adapter->is_sfp_support_en =3D false;
> > +
>=20
> [Low]
> Is there a reason STRAP_SFP_USE_EN_ and STRAP_SFP_EN_ are only
> evaluated inside the branch gated by (strap & STRAP_READ_USE_SGMII_EN_)
> (or the A0 workaround)?
>=20
> If a board is strapped with STRAP_SFP_USE_EN_=3D1 but
> STRAP_READ_USE_SGMII_EN_=3D0, the SFP straps are silently ignored,
> is_sfp_support_en keeps its default of false, and no diagnostic is emitte=
d.
>=20
> The two "use strap" gate bits look independent (one for SGMII, one for SF=
P);
> nesting the SFP decode inside the SGMII decode appears to conflate them.
> The "SFP_EN without SGMII_EN" validation block below will also never fire=
 in
> this configuration because is_sfp_support_en is forced to false.

[Thangaraj Samynathan]  The nesting is intentional. On PCI11x1x, SFP operat=
ion requires the PCS/SGMII interface to be active - SFP cannot function
 without it. The STRAP_SFP_USE_EN_/STRAP_SFP_EN_ bits are therefore only me=
aningful when STRAP_READ_USE_SGMII_EN_ is set (or the A0
 workaround applies). If SGMII is not strapped on, is_sfp_support_en being =
false is the correct outcome regardless of the SFP strap
 values, since the hardware cannot support SFP in that configuration. The v=
alidation message for "SFP_EN without SGMII_EN" covers
 the case where both SGMII and SFP bits are present in the strap register b=
ut contradict each other.

>=20
> >       } else {
> >               fpga_rev =3D lan743x_csr_read(adapter, FPGA_REV);
> >               if (fpga_rev) {
> > @@ -73,8 +79,17 @@ static void pci11x1x_strap_get_status(struct
> lan743x_adapter *adapter)
> >                       adapter->is_pcs_en =3D false;
> >               }
> >       }
>=20
> [Low]
> In the else (FPGA/non-strap) branch, adapter->is_sfp_support_en is never
> assigned, while adapter->is_pcs_en is written in every sub-branch.  The c=
ode
> relies on the one-time initialization of is_sfp_support_en =3D false in
> lan743x_pcidev_probe().
>=20
> Today pci11x1x_strap_get_status() is only called once from
> lan743x_hardware_init() during probe, so the current behavior is well def=
ined.
> Would it be worth setting adapter->is_sfp_support_en =3D false in this el=
se
> branch as well to mirror is_pcs_en and keep the function idempotent if it=
 is
> ever called from a reset, resume, or error-recovery path later?

[Thangaraj Samynathan]  The else branch handles the FPGA path where SFP sup=
port
is not available. Since SFP is only supported on silicon with valid strap c=
onfiguration,
is_sfp_support_en is correctly left at its probe-time default of false for =
this path.
No assignment is needed here.

>=20
> > +
> > +     if (adapter->is_pci11x1x && !adapter->is_pcs_en &&
> > +         adapter->is_sfp_support_en) {
> > +             netif_err(adapter, drv, adapter->netdev,
> > +                       "Invalid EEPROM configuration: SFP_EN strap spe=
cified
> without SGMII_EN strap\n");
> > +     }
>=20
> [Medium]
> The commit message describes this as:
>=20
>     Add a validation check to ensure PCS is enabled when SFP support
>     is requested, as SFP operation requires the PCS interface.
>=20
> Does this block actually enforce that invariant?  It logs the invalid com=
bination
> but leaves adapter->is_sfp_support_en set to true and does not propagate =
an
> error out of pci11x1x_strap_get_status() or lan743x_hardware_init().
>=20
> Later patches in the same series (for example "net: lan743x: Add PCS/XPCS
> support for SFP on PCI11x1x") gate lan743x_pcs_mdiobus_init() and the
> swnodes/SFP platform-device registration on is_sfp_support_en alone,
> without an is_pcs_en check.  With a misconfigured EEPROM the driver would
> then attempt PCS/XPCS MDIO operations on hardware whose PCS is disabled.
>=20
> Would it be preferable to either force adapter->is_sfp_support_en =3D fal=
se
> when the invalid combination is detected, or return an error from
> pci11x1x_strap_get_status() so lan743x_hardware_init() can fail probe?
>=20
[Thangaraj Samynathan - I53494]  The check is intentionally a warning=20
the misconfiguration is an EEPROM issue outside the driver's control, and t=
he Ethernet
controller remains functional without SFP. Failing probe entirely over an S=
FP strap
misconfiguration would make the NIC unusable unnecessarily. However, you ar=
e right
that leaving is_sfp_support_en =3D true after the warning is unsafe. We wil=
l force
adapter->is_sfp_support_en =3D false when the invalid combination is detect=
ed, ensuring
all subsequent SFP/PCS/XPCS paths are safely skipped.
> > +
> >       netif_dbg(adapter, drv, adapter->netdev,
> >                 "PCS I/F %s\n",
> > str_enable_disable(adapter->is_pcs_en));
> > +     netif_dbg(adapter, drv, adapter->netdev,
> > +               "SFP support %s\n",
> > + str_enable_disable(adapter->is_sfp_support_en));
> >  }
>=20
> [Low]
> The commit message says:
>=20
>     Refactor debug logging to use the str_enable_disable() helper for
>     consistency with modern kernel standards.
>=20
> Is this description accurate?  The existing "PCS I/F %s" netif_dbg() alre=
ady
> uses str_enable_disable() prior to this patch (it was introduced by the e=
arlier
> "net: lan743x: rename is_sgmii_en to is_pcs_en" commit).
>=20
> This patch only adds a new netif_dbg() for is_sfp_support_en using the sa=
me
> helper; no existing debug line is refactored.  Could the bullet be reword=
ed to
> reflect that a new debug line was added rather than an existing one
> refactored?
>=20

[Thangaraj Samynathan - I53494] Agreed. Will fix in next revision.

> > diff --git a/drivers/net/ethernet/microchip/lan743x_main.h
> > b/drivers/net/ethernet/microchip/lan743x_main.h
> > index f0fa0580b04e..26c30dc2e55c 100644
> > --- a/drivers/net/ethernet/microchip/lan743x_main.h
> > +++ b/drivers/net/ethernet/microchip/lan743x_main.h
> > @@ -37,6 +37,8 @@
> >
> >  #define STRAP_READ                   (0x0C)
> >  #define STRAP_READ_USE_SGMII_EN_     BIT(22)
> > +#define STRAP_SFP_USE_EN_              BIT(31)
> > +#define STRAP_SFP_EN_                  BIT(15)
> >  #define STRAP_READ_SGMII_EN_         BIT(6)
>=20
> [Low]
> The two new STRAP_SFP_*_ macros use spaces for alignment while every
> surrounding STRAP_* definition uses tabs.  Was this intentional, or shoul=
d they
> be tab-aligned to match the rest of the file (and avoid a checkpatch warn=
ing)?

[Thangaraj Samynathan] Agreed. Will be fixed in next revision.

>=20
> >  #define STRAP_READ_SGMII_REFCLK_     BIT(5)
> >  #define STRAP_READ_SGMII_2_5G_               BIT(4)
> > @@ -1081,6 +1083,7 @@ struct lan743x_adapter {
> >       u8                      max_tx_channels;
> >       u8                      used_tx_channels;
> >       u8                      max_vector_count;
> > +     bool                    is_sfp_support_en;
>=20
> [Low]
> Same question here: the new is_sfp_support_en field uses spaces for
> alignment while the surrounding struct members use tabs.  Should this be =
tab-
> aligned for consistency with the rest of struct lan743x_adapter?

 [Thangaraj Samynathan] Agreed. Will be fixed in next revision.

>=20
> >
> >  #define LAN743X_ADAPTER_FLAG_OTP             BIT(0)
> >       u32                     flags;
> --
> pw-bot: cr

