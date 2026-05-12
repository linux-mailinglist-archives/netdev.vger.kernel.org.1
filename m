Return-Path: <netdev+bounces-287097-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGk9JwQLA2pmzwEAu9opvQ
	(envelope-from <netdev+bounces-287097-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:12:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB67951F1DB
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1E503016285
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779F738E8BA;
	Tue, 12 May 2026 11:11:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2121.outbound.protection.partner.outlook.cn [139.219.17.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE0F3839A9;
	Tue, 12 May 2026 11:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778584293; cv=fail; b=XpjjJUkngYknF0blTaMTSfxePKF/sLJKi7GedFeXIpcCiz5gp7cy3XqeD9bCA+yX3+kGdHmF6ynLiMOBvYqxjKLvJom4bxXwAOO6lZO02d4B8wqjDVoRfcHCXBzUbBrBlRFWmJSddfvWxMmyjYniee6V0DVWFNRjDzxsTRpOeuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778584293; c=relaxed/simple;
	bh=bnXVSbF+Te1oEd6+37NvdwdRSkO6am2K9yAUt9y288U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GJNdqJMgKCvQMpu+Up8O1Z7WzQQ9MBzw999lkCBuKGKleYjxyt0vf6qbH0I7vbhyWB6iz/aGUqoatGtxouP/dkcnz+kmaS/cpTGzBLV9NjrblMckLiKWDViVVtTAVmQIENP/duQ6f8hEfAHAbVqM5pvmLkqNwGY4yyRdUxc9l50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNJzjyBX0EnGoR+cRh2QGdfQ51fxSfZOd8ulhc0W5IzdTO+O3KKL57VZyOfciEyGJQbf3Qt5dzzFCy3fws4l6nMwVjc78N0x5qI8M5SvFbPh+rlw7XevHh3K5N+wUms8/1YZq9arfoVmTuifp3vd/HcjiQv/7GEVIuQqAPoRkOF+4tss/kn1wwUaQ4J/W64dD2GN9r5qzSkrQohHusloI5QcJpfdGNVcTPqRE6qutNPKvstx7ZByckvIDk3D5a++a45lL2ehj/fCcexqBLSGK4T3oczArxt8gJGaUHdWossT9zTVvrHXbb2t6LeUMNOniW5gGmSQNDKNlY9r/ABgXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ee//60tFf8ednblAAXvkPp1hAr1Ljl6EcxgN6de7oF8=;
 b=i7sNlAB9Puzrjth4BSPXd0xYqMbT9F9uxHYci9P8tD/Cn3hOivRTMhPecGyIh69EtFryzF8ASh15K2LqJPLKoI3VM4s8UHPNGf64gwJ5KzeTo275QjFNXKjdLhBEVMTEz4Q3dGitDuuIM04PF7gsbn6imrxblV2Gjjm9oqcrjBlFVHN0DY8CQJiC7Y3FsRNLLoxEPWtyMyi6Fn+RtOGRMiOxRH0nqj8xWZNZNqb75nS/f3QJBwgsmPDxDeX+Y65WJADWICUYEhr9JOh+DiAaaqhOvpkdCe4MgGTl6gQfZF/w2fyxdOccw8DHforb3Hs76+o2MJ9ndSb0ppXO8TSRaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0520.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:15::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 11:11:20 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::e2de:92aa:4c1c:a829]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::e2de:92aa:4c1c:a829%6])
 with mapi id 15.20.9846.025; Tue, 12 May 2026 11:11:20 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor@kernel.org>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Emil Renner
 Berthing <emil.renner.berthing@canonical.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [net-next v3 3/5] dt-bindings: net: starfive,jh7110-dwmac: Add
 jhb100 sgmii rx clk
Thread-Topic: [net-next v3 3/5] dt-bindings: net: starfive,jh7110-dwmac: Add
 jhb100 sgmii rx clk
Thread-Index: AQHc3gWt3ozClCSBak6Fvt+67a5Pz7YC1dIAgAduQJA=
Date: Tue, 12 May 2026 11:11:20 +0000
Message-ID:
 <BJXPR01MB08559464A0F449365088B6ABE6392@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
References: <20260507094115.8355-1-minda.chen@starfivetech.com>
 <20260507094115.8355-4-minda.chen@starfivetech.com>
 <20260507-annotate-cleat-52614476a8f7@spud>
In-Reply-To: <20260507-annotate-cleat-52614476a8f7@spud>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJXPR01MB0855:EE_|BJXPR01MB0520:EE_
x-ms-office365-filtering-correlation-id: 5d939640-c1b8-4cfa-da39-08deb0173203
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|18002099003|22082099003|38070700021|56012099003;
x-microsoft-antispam-message-info:
 6NxCqawD0ImnhfdngX4CUbdqScmNzo+VWhtWDGBWgYtBmbAMQEmohkW48qfzc5Cq08ZLZ78CygzYO+GXWtNbZTOsmRHnUIqpPKE05/B2CMIoXaEIjlu+tbVhlNcfyrzr/6tK8ZpglgkrL5nQMNfmMtP6s68qSw3dHfyudnWvRm732EmGkEHJjKJLbAZjyxrdjyei6kPUHZ6L5PHR/ZhTtPCva9sgrbgYTOUZLoLFUZmODXFK7T3619aqNUB5gVbe8DZ77DbKEQ3Ccg1kvHdwCWquPSpnQWanl+jcOU+jwRPJjBOV7pJ5h4gIXPGb8RNTRJOzVqqAXZ5FuwToZGAK9SenB8uqI/QMVj57KgSAYrlpuMNvbY8Wdjvcfq6CJXHai4629sqzc2n7zJy3xcr0tIv9M778wJqM1RmioN5uSEQ1fDQPdiRtbApnX4/2+sT6427Go5o8NFPQBjhUDW6jyj18X7eOBdF5SzhQ0TvVcsuOBCXkuKlsgLDVO37Zkt3SVx1fk6oJ/yXoQVTRb+LJmNt2HOh20lb/VNU/i0cgAKUtoKYq2aGoF7TJoN/wA49K
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18002099003)(22082099003)(38070700021)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BN6vstMs3xxdsmGBmnh82cw6mZXu9lenFkQYQMhatngp/nWEZBf2iJ4wHu6I?=
 =?us-ascii?Q?r2dIk1Df66R1eAtQg/8iGR2bdraFizsf+jCmEBhnVi+44ObGLV1dFRjNaHsv?=
 =?us-ascii?Q?4s2JCsRZEcBk4zx3FjvW/KDwQhQPLJjhPvxdTWHEYqwYWcDaBMxRZ3MgsuHc?=
 =?us-ascii?Q?5riZl3eFGo2OFfnsXCz9hPQohEjHlcIibJgETfi2+rodqsAXp9w0mVynRC6r?=
 =?us-ascii?Q?bO1yCRX/38AL2OCR/VWO6s0gIYgYcn+IM9PmiYtZo+gzpA352npRLNWGl4UQ?=
 =?us-ascii?Q?jXBG0MQ2Ul/lBNJQuYYKChXvv1z/qM/fA+nMRQn+hKRrGYSmliCcizBMqqLx?=
 =?us-ascii?Q?nTWpq/s0CWW56ro/6EXkM+P1iyjAKnKh++q70gdQ0vRBarLEshqDYpBziR9m?=
 =?us-ascii?Q?s5eaif8SBRbUOqWP0Qqgj8qWYoxtnxJzWvCWwPTHpgIOv9juPfK0ydclBN27?=
 =?us-ascii?Q?ztv0B3W4vQLsXV3dUDz6ZLoSAiAgz5nt4fd69VUsXU6d5YXk9dp4x+iabV7A?=
 =?us-ascii?Q?8v7QEGQL/CyfiEeIPNaQT9/xBTuFp2WSgQgAeLUgtNv4ecyhqjaCJu2lMyP2?=
 =?us-ascii?Q?OEFAzHbAPTS0WAooCsrraLJ4qc1sKTRAeELlrX5bVMVhZC3ALFmouhkbdsYl?=
 =?us-ascii?Q?872Dr8WW+B4ZkvLJjiEZkLglj8UcDin6eEqZLBOD/ngPq1Z5qN8PctozC2Ax?=
 =?us-ascii?Q?Pz10IVb6TO3kPBU9/GOci4BDcwLhQ/W9txy2RfeoABAdCO97vZxchMyLJZk3?=
 =?us-ascii?Q?lHgfXUPj8uGEMwNxJJvh2lQ8b/7wWuEVkRV+mT9U6SWW1ylDe6LyZfAIgUtK?=
 =?us-ascii?Q?myH/6kIyjJH17pcX8kxhP3RZ5qy6ByAnrV1DcuwR6YIld/NkgETpx+pg0FHC?=
 =?us-ascii?Q?IYE2//9R+DDGsnV+D4WQWV/rm/p2EYoMnEPDBcf3C4DQVMVGZcdZoGqf2o11?=
 =?us-ascii?Q?u3CgJ2RCtXTX55PRg8y23MgKdOiOASbKNSVnN9xzaXTiHmyGYSsiCNFj4KNj?=
 =?us-ascii?Q?Nk1pxE8nuCPrB1qPCtpFz6+FKpDNsArhWd98F/h4igKSFifYmJornK5Ahauk?=
 =?us-ascii?Q?5c7VVRoErpKic0FvwzfmNjB8sBShu23nCpMcoibKjdinE4cPAQNK4kiHUZa4?=
 =?us-ascii?Q?jl26h5xsPfZck4Nglh7OnwvNDsxNeBodUJINkFESnJq49YQ4w4akcLq5a7cW?=
 =?us-ascii?Q?XfqLFK5ZYILS+WLrXz+9racYgF0GEexH+JCJHDa9a7lV77dKSlJuADP5cV0T?=
 =?us-ascii?Q?8l5OuYdbjHeecRXmNQJNMNF83s29gCewFaW3MzH0QjG1ZjlGsvgP8gZeRcZK?=
 =?us-ascii?Q?pT7nDuY6asSGplOWnwFns26uCIqviTwob60xl81jjw74xYV/Sv+5QXbD5UUQ?=
 =?us-ascii?Q?OcLcy/0u5pBqcFEX0FuCLFHkvmcvWCbMZ1YmTukKSL9+wo6vWJcb+xmMMZfG?=
 =?us-ascii?Q?KITvHd9FPDJdlYBR4/y1K/GaBjAMZRQ34B7z926HwQj394PmsK4eWvXJ7ulR?=
 =?us-ascii?Q?WihtA0objGp3A6F11G4KciH3AI4unH/DOMAE4gCa5xAFMUnO1m6yTxoQW8Ay?=
 =?us-ascii?Q?aAdHr18Dwhcg12i8N/is5c1hFr/vK5U0HtXng5YHhUy6/inMcpdz5leHpxl/?=
 =?us-ascii?Q?4zD2udW3Mw75GV0y5XitrkH8wm83lC/uVMwmwKn1fKG1vr95ySm1HWi85QzF?=
 =?us-ascii?Q?QEc/rNc+N5RYpqfG3bHcWGKFcv+uXgs9Hdl4q0Nrecjf+p8A8Kx2KpqPwQ2/?=
 =?us-ascii?Q?n2So3artnw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d939640-c1b8-4cfa-da39-08deb0173203
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 11:11:20.2659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JvQQSexej98ACdepHANJLZVpyV1xmogx56NwJwysXVFFngj2YSacUEbSUHUIC+Yt3hsSFCDsDv56GBChMCONFPUbai3WhmRRaZWTx+XDyyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0520
X-Rspamd-Queue-Id: DB67951F1DB
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-287097-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.909];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn:mid]
X-Rspamd-Action: no action



>=20
> > +
> > +        clock-names:
> > +          oneOf:
> > +            - items:
> > +                - const: stmmaceth
> > +                - const: pclk
> > +                - const: ptp_ref
> > +                - const: tx
> > +                - const: gtx
> > +            - items:
> > +                - const: stmmaceth
> > +                - const: pclk
> > +                - const: ptp_ref
> > +                - const: tx
> > +                - const: gtx
> > +                - const: sgmii_rx
>=20
> Can't you just leave this list outside the conditional section, and add t=
he extra
> item to the end? The only difference appears to be the sgmii_rx clock, an=
d it's at
> the end.
>=20
> I'm also not really convinced that this flexibility is required, unless t=
here are
> some controllers on the platform that do not support sgmii.
>=20
> pw-bot: changes-requested
>=20
> Cheers,
> Conor.
>=20

Thanks. Yes, can do it more simple . I think change the clocks-names in pro=
perties like this is Okay.

   clock-names:
+    minItems: 5
     items:
       - const: stmmaceth
       - const: pclk
       - const: ptp_ref
       - const: tx
       - const: gtx
+      - enum:
+          - sgmii_rx

=20
> >        if:
> >          properties:
> >            compatible:
> > --
> > 2.17.1
> >

