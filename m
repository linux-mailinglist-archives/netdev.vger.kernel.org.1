Return-Path: <netdev+bounces-280003-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCVZEX/x5mlz2AEAu9opvQ
	(envelope-from <netdev+bounces-280003-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 05:39:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AB843619E
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 05:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A3B030166C3
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 03:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729392BE05E;
	Tue, 21 Apr 2026 03:39:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2124.outbound.protection.partner.outlook.cn [139.219.17.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB85040DFC7;
	Tue, 21 Apr 2026 03:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776742776; cv=fail; b=moMwgK+aKK34X/M40Fl22O7p8/XNwj/2/LJ8eKG56fxbNCwxDb6pxD1tvULe5DYzIXveuMCw6aORClQbcR+lCsg8vDCZZBzKKkW/3Ej8et1dE0JVNOX+jc9uGV6CabxT5i5dXDH8EX8/UMwj1N5Nclxw6pzwE5QCbkzc1dGjrHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776742776; c=relaxed/simple;
	bh=zOUnqj7sNh008GtR0eeUCFYMNtJwXTDc7p3yKEPthlo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IxkkNHB9zlXxWv5ZmjgFco8Ck8rIsTA0OgSMruK/68fLUvLMjLmncBRROpEtYBRLy9t35pHGO8OD6S0G2FI2r20Kat8Bm/EHTZOQyr0TH6P3RaBUsqAT9iMG+2tDQatFkczKkBNR72G2VLMVVvFhWAF/yw/2/62CC+Z20mJ3ZG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCVHK1piVdrZGRmkPq1yvempMiRbEHDhNhefVjV3c7eAMR2k51azmQ4La6vlB5Pnuip5jskv/8zBCHdXkJi/i18LowxxWbGkPB/oUlrQPkyNrLFjYLzlPiELmoxg0GxM26QbpUoQYXY/LGBDH2Xv9X9ArIQVvhV6X/+ionfpYyjtcmD7Nl6lWzuTjjzviBaimBipjLKeU60M06UvDBJXnuMvKmDXClS4/6O1nYqooJkUnfHyGb3lbe1vN2JB89Z64t/UXCFmgAPCUC2Re1uGTPtMiM96gcFeTNhbsNqw4xNvieQMETMX6PxOl7H5xzVtdEauraQ00K3CgoRXbO6apQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WE8hD0v8cpdiA3lRkI7I3BH6FpRMfZh/o1uCVL/ytOc=;
 b=hQFvtrIViQ1vyT4A8pJGeDbL8uau94BZdW/YnzAPw2Ll+f7eYDsIAMRwmKxRXgAJFsR53SJ1VupC1eJdZG1WixL8JadsMGAStxN7C1YjKLJ5dszsjkK+e7qkpoDTLRxka0XfRbLc7YZgqeuS3Oaag+W6ZMlG3s/1K1Gx2qNvGzraEFp7R2+xs9HyJwBkajMsVJ/FPMw1r3FZm9zmPyTX1z3i5TyRBkNhRa9MPd6YMdpLLRAd86tbf5H9tzdtHCXejODCISYxM4ai0AmLqProBkT171ZNRYSjz/yRCV8w2vO+n+AARLBDKPGkIl2RK6BTRHsm/uBeRcFm4OsnngGXuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0709.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 21 Apr
 2026 03:07:10 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::e2de:92aa:4c1c:a829]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::e2de:92aa:4c1c:a829%6])
 with mapi id 15.20.9769.046; Tue, 21 Apr 2026 03:07:10 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Rob Herring <robh@kernel.org>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Emil Renner
 Berthing <emil.renner.berthing@canonical.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [net-next v2 3/5] dt-bindings: net: starfive,jh7110-dwmac: Add
 JHB100 sgmii rx clk
Thread-Topic: [net-next v2 3/5] dt-bindings: net: starfive,jh7110-dwmac: Add
 JHB100 sgmii rx clk
Thread-Index: AQHczhREUfkE43jYcEK976bWXBVVt7Xn+hEAgADhqCA=
Date: Tue, 21 Apr 2026 03:07:10 +0000
Message-ID:
 <BJXPR01MB085573DCF307E33E43FD664AE62C2@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
References: <20260417024523.107786-1-minda.chen@starfivetech.com>
 <20260417024523.107786-4-minda.chen@starfivetech.com>
 <20260420133930.GA2322456-robh@kernel.org>
In-Reply-To: <20260420133930.GA2322456-robh@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJXPR01MB0855:EE_|BJXPR01MB0709:EE_
x-ms-office365-filtering-correlation-id: 824641ae-e0d2-4fe6-3620-08de9f53141e
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 ZvIQyixAQuvUMpWIFK3g+0swfc0DmcZRuLrWF9TyFcw/GAOJrzf159QiKOUo/0Z/SXyPwcQly0UZxjq1ewL+4L5Z7fbif0IpZ+joSPoi6Y/8c7MAuG48pi2V4OLhZXwLlGmdH9xQ+G/y+rR68HIxzKCxkUJCxL3FaoD+T5HvVUYHembHiLdQdMuvs8mi35ZI5Pbr3woxknLWoZGm5udwJpDkvZwQ4FVGqPG8icJNE8JxGkFKp5Qh3cQPIjxgRnZka3eurrbN5bHpI3U7LewyYTUdt15Bm0U15mIOy0tvpD20l9GCIiqfgene3i77afJDcjtSbK63K8TQ/KfKLgbZfAkGm54iNYLjAoRdYEtvPsEU5vvTT6TaO00H1uexreXjC3xc51c6Q2MulPXsarqa6QvHiC0Cvk3HJnbMiIV6k/0heZaa90AfXRuDXKNH9WqqCTJe7+TsGnlKrsjkRh7jmr9PwFC9Tkbvuzfz2K5kK9YDMMyyf9J3hKUILgYUsq6iW834O+41nWFbqUhF434UmOubI5zcJPeYmHZd4IeLbZKR6yVmoRakPfQf85xm/29vKrHyxW1oSrnwHTlFE1jSs7KWjSCO27bhmuX5SzozPFo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gLlOSds13ZKCxw50CUut/NNiynMUvDVH7QGjMXrHeFypAXQkq+Kh+58xbSbq?=
 =?us-ascii?Q?fvbFBnNmN8dvchs4pnOUHGv8pxLOJVOStZ/VWE7QkGElyxYPSeM+umkI0hbP?=
 =?us-ascii?Q?XWo99IO2ziDfMMTVq+mlNYzvd7bE/rqhBzg0a5pd5PmK2sMde5gmm6khzvmi?=
 =?us-ascii?Q?ykIAy2wROYjTVpffhUtNtZ//Q14LxtFsGFgHPsj1MKdANNpHHHNER2L3xShS?=
 =?us-ascii?Q?IaZTV3Nlotkxr2IMCmjxQobSghauVlEAOD8/Q8cYyRJ1FjmB9WRithwBARah?=
 =?us-ascii?Q?pJq2+pjG4B5PwnIVCxjB9lw5T+rKnl3WNWhiAQoPRzAx9nIwlxHOjastf9Fd?=
 =?us-ascii?Q?BVWjqyhn6nEM07Jj4rUhWusSZAt2GbSvaPiovGoR2d7s8sE04dtU/nutshYS?=
 =?us-ascii?Q?B8IHue1d0jt0hXpzAfwugLe98pyBllRQbw88S+MLeIpiTM4FatqozA6WAl6m?=
 =?us-ascii?Q?ys+Yy7Pm17yV1Q5Vu6gJl8jopr38dYNp67YMR2GqcCvpkc4P9WgLi3IBXY4b?=
 =?us-ascii?Q?mx/PBCg6YiiY8fBhna5ZBw02jPPVix2Vem1TF++84HZ+VsINcE4XrWN6V255?=
 =?us-ascii?Q?TVscafqambVIIxsJ/A3Xy0epGxb+PYyntGpmDJ7iYVDuuIHydT28zsCcE39E?=
 =?us-ascii?Q?y2w81hEx4hm9y4VKbGdPorzu0gJ0zQ6l65+nW+siyQAirjP8MRG5lX+9Z6bK?=
 =?us-ascii?Q?9j4RCorjhBIQFVLNCHfIQGQggS5E1/mOpufPcdgDheesMiI66u5Yl1iTawOv?=
 =?us-ascii?Q?Tw+t7d2MOs+u/okN3jbaGQBWV3m4rupVlQPubxs7SL3+RMhbOIL3hl7nfHJu?=
 =?us-ascii?Q?BnGeIepl/tCa4R0mQusF8yZ7SKFZQJ+APYaUFSOu7VdSmSkwor8CYyimIMl6?=
 =?us-ascii?Q?GJcM064IB2+KvneN2OF1Ukj3wBSOAQWywRfrfMjZ2RNtLg6gsCnfA2TqikHm?=
 =?us-ascii?Q?U/9gNQwmtnXAHBTXbAGXXYvLMWZJCojNbj927PjtthopzfkPxR+SpkII/oqJ?=
 =?us-ascii?Q?G87Bby7yf2ANgR0Cax3miira+dypAJDLGtjh2WJWntsIZb9Umey8ZTS1vHTA?=
 =?us-ascii?Q?7snqnkG/aoejXUeuozziz06AC95IBhxWmMAZ+UYBBXKY0BhrPz0EMmpxSQIq?=
 =?us-ascii?Q?QZdNvii3lmP4KkrxuAfCZZnLacn46dNOV0af/nc072YeUMO8CNju8QHZDX5w?=
 =?us-ascii?Q?047hkf2o3pOINPoTAfw32oZPL0dp4wrFapUrGJpBa3fB7RUnqTG8YiHonldn?=
 =?us-ascii?Q?ZY7WHohcHk+LuSu+HWW/NFM1SBwmnPSezup0/OrYV/0iguMaRauHLILjOhFD?=
 =?us-ascii?Q?GDqaSjkkZL+yNZhXYX/nKfUj26M84DXXM5I/2L2fOapngcC6IcPDiwtdi0e3?=
 =?us-ascii?Q?huc/jxRzRLVTbS2JAKvsVoY/DPI/R6xIAMZt6a1WLjyU9WH27oP8JM4YR9/z?=
 =?us-ascii?Q?JXkIPx71s7J+uNSUXd70p56+2diDlD+9oFI1TV63nBPxIJyGJntMvIG2D7+x?=
 =?us-ascii?Q?sBGTl6Z1Ua3rLmZt67P9OxYZDADQfaPN9Wl3gBgoKgset46zvh1AAyWmmToa?=
 =?us-ascii?Q?agdtXP0WWp1mnTA7PiJ8vSAilTy9Epvyc6+LIwf2hBRF3i/uzidkMDDP9wao?=
 =?us-ascii?Q?oLXMzEvhRGrK0R+TMq4gDfKmrjqbK0TTHPdybLEqmQgehnL8XoYIpZ9YnmhL?=
 =?us-ascii?Q?vuKsfo0juC/zSuTZEqlkAq/yBF7DEfId48cDGF5dACmWem4VHYAkEM8sQh0T?=
 =?us-ascii?Q?FrQIO+vG5Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 824641ae-e0d2-4fe6-3620-08de9f53141e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 03:07:10.1284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HvMMOIQYgdZtvpkuer72U/Js8w3IV6G/YHW12nb82avUdlzpuPu0NFMbj5p7FuUP7RxDQk51/FnRtzQS38jV56LNTMuI2dk3vxpWf+ALBf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0709
X-Spamd-Result: default: False [3.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org,st-md-mailman.stormreply.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-280003-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn:mid]
X-Rspamd-Queue-Id: 06AB843619E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr




>=20
> On Fri, Apr 17, 2026 at 10:45:21AM +0800, Minda Chen wrote:
> > JHB100 SGMII interface tx/rx mac clock is split and require to set
> > clock rate in 10M/100M/1000M speed. So dts need to add a new rx clock
> > in code, dts and dt binding doc.
> >
> > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> > ---
> >  .../bindings/net/starfive,jh7110-dwmac.yaml   | 42 ++++++++++++++++---
> >  1 file changed, 36 insertions(+), 6 deletions(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> > b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> > index edc246a71ce3..3802cdbf1848 100644
> > --- a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> > @@ -39,20 +39,26 @@ properties:
> >      maxItems: 1
> >
> >    clocks:
> > +    minItems: 5
> >      items:
> >        - description: GMAC main clock
> >        - description: GMAC AHB clock
> >        - description: PTP clock
> >        - description: TX clock
> >        - description: GTX clock
> > +      - description: SGMII RX clock
> >
> >    clock-names:
> > -    items:
> > -      - const: stmmaceth
> > -      - const: pclk
> > -      - const: ptp_ref
> > -      - const: tx
> > -      - const: gtx
> > +    minItems: 5
> > +    maxItems: 6
> > +    contains:
> > +      enum:
> > +       - stmmaceth
> > +       - pclk
> > +       - ptp_ref
> > +       - tx
> > +       - gtx
> > +       - sgmii_rx
>=20
> No, this allows any of the above strings plus any other random strings.
>=20
> Rob

Got it. Thanks. In JHB100 I will using "oneOf" 5 clocks or 6 clocks. 7100/7=
100 are const clock names

