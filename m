Return-Path: <netdev+bounces-161968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC37A24D81
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 11:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4418B1626F6
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 10:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E101D5141;
	Sun,  2 Feb 2025 10:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="w0XEm5nx"
X-Original-To: netdev@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010033.outbound.protection.outlook.com [52.101.228.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4E241C6E
	for <netdev@vger.kernel.org>; Sun,  2 Feb 2025 10:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738491250; cv=fail; b=eFdUZKNzRUrzgy33ccoPbivplycFs1v7KyWjpSmPT6Nb965OqZlrzwGTHVF0cAQzS1QAWqULkeTIrgt7uuN59PAZSuHu+jlu6VaI32ekgwyHj27n1ki7qOjQvnR/FNVAyCzkTmq6SH7mt8IHs/u4mIRec8997qgPTFYPj/+G894=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738491250; c=relaxed/simple;
	bh=tMUGCa8WaJCHx23gRbL9d5HVbMFpmVBXAvD6A4nHbAw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r/5jHfwqpVdzYYrcAqsk5z5HDpvRW+pTLDQQJazJxFcztCts2XJ9MtEXou5EoTZZAMy/rGnhRW1xAQXYFxftBuwLuUpMWHB7w3fGJMRzKLP8eulz5J4SLnezmx4jQKlNAm9PPrrM8QnuM0C5liORbD59RNOPf91TKYeXPNkrAUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=w0XEm5nx; arc=fail smtp.client-ip=52.101.228.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4xegiujENfiXGkHm6ngwbI5A3t+JnkCDdUv75r0jVuMSc519Ls2PecTBbMDE90jbBw0P3x17t0NaIImKXk9Q/8MMEwva0J9yWejuutZaJRJzif2N1nT9WZnOqVIfThAbTdA6bplYIappvj02gUrpMhkyLTD1ycPK5ESWswflLokOTb/CZW+s8PJ55nFHTdgip+PScF36p3dUzQg8xX0+oxSiZK040YCBviCfn0TOJ+yNYJO2NxL/fYP+CZOuRgfJyblWTCe+cR0LYqWS1N0hfGqexqaGOsiGRGKB7ZDcdqpPCfwhfMjRv07KgT70FwZ2yCqBTBxiBMQjFYF/iuqNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRjQdtvnU5OqDKby7LRF6cNiKgDAX/PuUu/bbuzzkOM=;
 b=yhNUkN4vbz/gE9A+8j262pRN06ifT/eMoR4bJAcHXZ9cnCfwnHuZ6EZj59EGHBod0VmRN01w9XSxGCfRQgxdkAk/4S4u7SJQR648A7/0LkGwa00g3qexwaudjabw6pc0hO4oeFlc8R1fU+wEmEaoG9qKwQ/tQ7SisugQYTVgfFBgcXbu7M0REQQHomPDeV+cYsebSvrnohQUUlwUIPN3ic6yVg1mpgSlfgukrGHJ3hSCQop6RHp0K8h1TMm0zPDxakLtCqYFfDZh7QBNU84Jgo+z2++TdolvIIx56SalHK6lf1mOK/hih2wbG7YvrZxYY6MYG5domQAI9yHLjvyGWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRjQdtvnU5OqDKby7LRF6cNiKgDAX/PuUu/bbuzzkOM=;
 b=w0XEm5nxrwItabav6hm//dFRJ7F2WGbcLnizDN36KqNZNqYFcJNvc7y74ROCKveHwQOI98G4e5OmckEWfJRFR9lgDxmL4tOVZTe4kqST2pV0DGFhhT7/OGXazWwfC5oEPa1xlYtYIO5PLgPyYyBC+fxprFPiNhrCwJWIUprDmP0=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB9540.jpnprd01.prod.outlook.com (2603:1096:400:19b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Sun, 2 Feb
 2025 10:14:03 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%2]) with mapi id 15.20.8398.021; Sun, 2 Feb 2025
 10:13:58 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	biju.das.au <biju.das.au@gmail.com>
Subject: RE: [PATCH] net: dsa: sja1105: Use of_get_available_child_by_name()
Thread-Topic: [PATCH] net: dsa: sja1105: Use of_get_available_child_by_name()
Thread-Index: AQHbdMlglQZ+D4oHqEqS3/vtP93Q5LMyx2IAgAEE/7A=
Date: Sun, 2 Feb 2025 10:13:58 +0000
Message-ID:
 <TY3PR01MB113464D39FC1809AC112ABD6D86EA2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250201164959.51643-1-biju.das.jz@bp.renesas.com>
 <5e4243f2-4186-4b97-b39f-3c3dad4a444b@lunn.ch>
In-Reply-To: <5e4243f2-4186-4b97-b39f-3c3dad4a444b@lunn.ch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB9540:EE_
x-ms-office365-filtering-correlation-id: b10ffcfe-e749-4119-38e1-08dd43724ef0
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zDKD1za1+PpKIhgeOobHUpvc95LnJDfnhSYJMIxG7rvqkwUZTjYgPSzE7W5b?=
 =?us-ascii?Q?kqUxyYxGPFDrkVym36BDe+VMeboLL8X7kVyD+OkEoKhTOOTnoWYmCDJJ5CW+?=
 =?us-ascii?Q?IxO/spFmw2sUE97kEaFQuM8K7kffI9k4qVxWqPvKzTmM8TREAxa3PsvZKK9F?=
 =?us-ascii?Q?sGi8CsJlDj9Vo3dMBCz8jxD7uSwECkXy7qkabmcWygLagy7PPa8bpZmKdbEB?=
 =?us-ascii?Q?fM56gBx/mUtmID20/Gj3KD99PNpRQ8KOFnqU9+nCR1E0jjtOlcA5MOIGdl6Z?=
 =?us-ascii?Q?K9zIoOyRMmhABJ+jBesorMAZE+Z7tc2vgKCwjyHsM5fe2pvTaambWCgdZ6JO?=
 =?us-ascii?Q?NGrc+FR13PdxKLqG7okXSW3rHpFUOlcoNP8ZGUAsGBO+9jaNvWtTho5G801x?=
 =?us-ascii?Q?yGqmpu3/rancSrZCVtqMtVejpo4tWqn60vJItPq9mUSPrsNHS1/AVCVsilBm?=
 =?us-ascii?Q?y8O7nl526v/IEumBC4kdYBYfnv1J3oEXwhHh88K2Yuhz8OWx1ZWp+tn0JTUi?=
 =?us-ascii?Q?RL4ZPiUFLv8mNJm/kKG5BY3JQnca1oWgypUcfgxiohMD05aFCsSavXKSFKuL?=
 =?us-ascii?Q?cB8SxJDIElXNEabEve9K2GpIGJw66NSGrRmmJFLCwOVTEltFY9vjey2Cwr3j?=
 =?us-ascii?Q?awszFWHIovvJGOaMGC6Wjb11sWFIgFg/kqfgxZW9EspxFlrowVUPoKaxiCVP?=
 =?us-ascii?Q?kgua3X1CngmIIFYQEpjVqP5gHHu5kZCswsNV+FBxUJLNMoyK9Qohpc7BJWay?=
 =?us-ascii?Q?XloKfpm7OTPPZGMNz9dUYrrcY4yYK/ayGon6nZaLu3KlzHaUBfeJhTBgIrfv?=
 =?us-ascii?Q?p/6xyxXigt+WT5c8E+GPTz6Kf9zx8UkK9rlSbVENy5KH3MHWIXkYIc0k0UDh?=
 =?us-ascii?Q?5f+Umx4St8qIhv+efHwIPQQBDw0zZxoBudy0x4puqGf6guSWmLsluCLglVo8?=
 =?us-ascii?Q?/6nJpSxIjYdfNQ61DOcLT4gyvvckd42yhKWTTazFpW2eFLbIRPVMcJZrgtsS?=
 =?us-ascii?Q?f74ASrdtjkADZNOYNjat4VOMq26esRU9pa1f5jsX9aWKu4BlSY/uWs8Lb3jr?=
 =?us-ascii?Q?24fikd9J6MBrZCFKEJ7szH4xWqO37mtgUbAiy/gn9Q/U9xjJ7Wg1iE12lmk6?=
 =?us-ascii?Q?eCQDLGI2ZNT566D5uAaH2GRZvxdIx5UxrKl+7AyzmMb7e53xLDMTdoq+K814?=
 =?us-ascii?Q?GrbiE6S1SgtdK/MDd35Uh1EjZ3fMd5Rh3JQMMN7H4QFZxVsvkTtVCM3xkdL3?=
 =?us-ascii?Q?8LyxLvFByghgGG3TtXDveUnW+ArhG2zsMgWEI1ldtyZrCykuUFGceS/uNOkO?=
 =?us-ascii?Q?HWDRHa/3a6fF+sVymLAHD8pF3hwt7bFB525wPcSaKSlySNYHenSv2vLIJ+nc?=
 =?us-ascii?Q?2+re0V4O9nFe8thrD22CnEe7a9SHiCtdQ9w1zPmf1latBCN1OMAmgUnLw8RY?=
 =?us-ascii?Q?cBNwQvrTqJIxZ3COVypSb+Onos46UJ+C?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IeCz3DTrOV6sg+MiXHr2wLXF2pEqNokMqYVUxAaouc+S0ILEIK+EtxpdKLh/?=
 =?us-ascii?Q?8VOKxJXCi1rpk7SGk4FbGXjRK6NyVtMklWIRnH8bLJRnkhFZi2twje6zGMEO?=
 =?us-ascii?Q?Kg4dwSzhR5jGKAVtdTV8YlJMryIXMcZygSF/KVdtqItGcx41QoKJpFKBuA8L?=
 =?us-ascii?Q?WrM4w/NkVxiC3oO0L62bBnEOTME56T5fGQF0voxXVOhOH76fCNmdssph95fy?=
 =?us-ascii?Q?60juK2BrgAEmSQy2tWj76Eu9t5mamSi3uYYj/HubiCYkBuSm4yjGM1+JQ6V+?=
 =?us-ascii?Q?sKeHpol4kcirIsV4oeR8QZyWUHkRWOECN2zkAV0OlPhqT1kptdGG8L4ZwUqm?=
 =?us-ascii?Q?7iH7kpJ7rhdSvZydpydAaO1FnX3d45K6WB67K7dXxPwRJLaV1zuFkF4O0knU?=
 =?us-ascii?Q?fJfxN8b+j/pFgvktiCduOVRTCc7OAIzdDjXaZSBYkbGAFuYqgUTJPMkOss0i?=
 =?us-ascii?Q?ZCMSQJdom1KepeUwoSlSRsTFhzBenRAyfipCwUWMFBb3PLQsBgftbeGo5dsy?=
 =?us-ascii?Q?ZPvk1kqvOB9CTF85QI9ICSAHh06aZy6yXvXro7ve5ozWl5XTukhT8z6GtaQx?=
 =?us-ascii?Q?X1oxnXGHNAiwNd7VeiEpiuPAV2/8bWqyHpuJz1zl70hsZcvHb+C2tA/+76So?=
 =?us-ascii?Q?oGMR61zyeQQ1wbw+cunGVS0Z18otNvbInAeuHyPif1rUDMalgcEIfpjMPvcr?=
 =?us-ascii?Q?xw/dvArNSoUKJOK483C/uO3mLfxS3mhG0MoFVIOHxRsz+Ioc42AOVV9DLk7n?=
 =?us-ascii?Q?se9RTcanP4WRP/N1h+lzREK4T6Tibq6NivlFudVV475ECNQw6yCzUDPvcweu?=
 =?us-ascii?Q?tHCsMA9RD70DIVFEAdCquWmGHJPpQUyBz8zJKJfccyEMTIApHTkzil/eNBLT?=
 =?us-ascii?Q?4IMdGS1XpaPmjeX3rxsHoZXUd6h1mZGeOll9J00Nz9LzGfcZsfxqO+SrOaUt?=
 =?us-ascii?Q?6Pz9JeARtgiuxceaLzIiFC5gSHtiFEhs9NlykczT0co9GOCo2LNnniVDiZD7?=
 =?us-ascii?Q?Lx7ji4WrNbQ8fPa5TtcFf6iQ852A3ElZv3bpLvieBFUzHBcqQGoEXPmLFxy2?=
 =?us-ascii?Q?ifcn6k5htYeZ8q3dtT+RT2Ji7J2MahF/KFTGwFBWrDQl/kCbrun3ft9xunxQ?=
 =?us-ascii?Q?sovK+hFfRjyib8f5rlYtPeUSubbylcq0SSeYkydea1ZNG4B7Kca1BH/FSZzx?=
 =?us-ascii?Q?h1P1P63xx0GyiI0rfXIkxQmVJnKuI/Hkx7rVf7dH0kbYWez+9Fe/pFDVmsbM?=
 =?us-ascii?Q?xFrr6PO7WUHWsjeJw3QBHT1wGsQ08i7JvpUnGeOLKlQmcjsZ0FazJXVHeuWl?=
 =?us-ascii?Q?Of3V7PCm7I1cxk95gvIRIWTXDO8mIf7MXuV12SaZ5TVFvHsZL3n6rPnmEBYE?=
 =?us-ascii?Q?nPXc732jEqSmupEfi6jr5Kc0DtSCKl45YJBFO6FFzeltsm07rmnBLRQL+TyR?=
 =?us-ascii?Q?XAIJ6/2SIN5rcROG8TnBx0Br4deWPM0SURyDID6CPPxrchKeT1MTkunbLIvV?=
 =?us-ascii?Q?YGfFDexaDqnqyZbapvTf6iUFl7WI7XzlXtu3eI1WCCA0Tdz6hPJUscgqiYgc?=
 =?us-ascii?Q?5oOprelr+5EoxaYpBsEMXzgCHe+5s3UJRh7yc3LfvpEOLjKOMawS0GxZthNk?=
 =?us-ascii?Q?GA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10ffcfe-e749-4119-38e1-08dd43724ef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2025 10:13:58.5919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vWptpYifgmr3vJQO0H0lEVzrJEQjxPA302bbW/jP/EYlC4EGYFpAt/qeQQV3DNqEog2EatjgE3xChd+cGclWxVHobzObazjGmWAChjAYrzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9540

Hi Andrew,

Thanks for the feedback.

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: 01 February 2025 18:38
> Subject: Re: [PATCH] net: dsa: sja1105: Use of_get_available_child_by_nam=
e()
>=20
> On Sat, Feb 01, 2025 at 04:49:57PM +0000, Biju Das wrote:
> > Use the helper of_get_available_child_by_name() to simplify
> > sja1105_mdiobus_register().
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > This patch is only compile tested and depend upon[1] [1]
> > https://lore.kernel.org/all/20250201093126.7322-1-biju.das.jz@bp.renes
> > as.com/
> > ---
> >  drivers/net/dsa/sja1105/sja1105_mdio.c | 15 ++++-----------
> >  1 file changed, 4 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/net/dsa/sja1105/sja1105_mdio.c
> > b/drivers/net/dsa/sja1105/sja1105_mdio.c
> > index 84b7169f2974..d73bf5c9525b 100644
> > --- a/drivers/net/dsa/sja1105/sja1105_mdio.c
> > +++ b/drivers/net/dsa/sja1105/sja1105_mdio.c
> > @@ -461,24 +461,21 @@ int sja1105_mdiobus_register(struct dsa_switch *d=
s)
> >  	struct sja1105_private *priv =3D ds->priv;
> >  	const struct sja1105_regs *regs =3D priv->info->regs;
> >  	struct device_node *switch_node =3D ds->dev->of_node;
> > -	struct device_node *mdio_node;
> > +	struct device_node *mdio_node _free(device_node) =3D
> > +		of_get_available_child_by_name(switch_node, "mdios");
>=20
> There is a dislike within netdev for this magical _free() thing, made wor=
se by it not actually calling
> kfree() as the name would suggest. Pleased explicitly put the node.

Thanks. I was not aware of this. I will send next version with readable cod=
e once
dependency patch hits on net-next.

Cheers,
Biju

