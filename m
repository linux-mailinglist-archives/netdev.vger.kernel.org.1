Return-Path: <netdev+bounces-159117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84797A1471E
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 01:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3122188DF46
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 00:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0888E25A62E;
	Fri, 17 Jan 2025 00:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bVN0g2Pc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1D41FC3;
	Fri, 17 Jan 2025 00:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737075086; cv=fail; b=npnjKdsF9kN14cUZxyIirrRZsEI0IjgyRs8AscSod6vcoRYU78KIVwQOQ15zGkVqEGsXXCIzmp23AhCClhgSzB06f++HCYo0dvu49yafJgdILaGz4UsDd2qxD8ldDQhZHE8sMs3DMcDoa2lfQFBM4/8Ul6Zub3IfMzT3wAzU0z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737075086; c=relaxed/simple;
	bh=92bTr5zF0VgKwW2WthfNlGGia/nIoWjyJNiUwQLObKY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rqu1U3KlcYY1aiy+rwnrOCkFzTnYqtDKZb52HYmIC4W8hNq90ZoIOAChezh2lDGJgNV8QYWsEcnAnSo+7FSnCNicmZQixl1xanbmP3ZBInILqi8QyenloNl/3nzq2pjVkUsLAwL/i5vgutras4fbNlKXyV0+DjUdXlRjtn4X8z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bVN0g2Pc; arc=fail smtp.client-ip=40.107.92.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGaXsd87GnFcQvscmhqr01/QfXEvY7jsLzsRw+LvA0WzqyYKXddx707jVQCvL5anidgkgvUvLMtyeRNtWyEiLy1FEqqM1adam739q7+utCy6Nyw9AIKlw70lmd6pc/i7wjknCH0dvSonFrGf5iwLXC9Mz6wGCedgWdknAjfcT7Pp3hhXB4gPGWIm9Kk3PdY42JjGmT+wtI+dp2N5gqv8X/b6e1XcVQ5Ze+OdSuJM13f88RBqKsl6eUnVTzfYyB9SBRArZqpy/UldGqCAQbjRRNdiRqA+z2uGfALcseuDE+5o2/PEYu2gNfu/GtyjS5jjDLGLcuagmKwMElYCK6FIsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/GNUGUx6Sa/5DtLiv69iYDkqexedUuem3+ofn40Z7Y=;
 b=pmEkcj9bzw62Rf/DlrrFjK5m2x6PH34CgYZqpYTQ0sDZksrtIpiQClvIvub3mSNyHZTv3EM+plfWp6Xaw96hfmVaTCKlJrOv78zttml56xgV6+VHixijGm8xMTpsq9FiC2/YofrF7UCSKsVHiBqOfIO2rspLdnzo161LqVEVsNdLMOugm4vDusOjiIeJOJ2hXK7hnErGQVN0ctN1MEnLHEuQfDHOy5VxIRYCnLPh9rgMBCHb2ATdwdd+gQEpnII2YtSrw1TK54LKT8OA/yAUlgjk8+sMzyHGb2ujvguwMShK6Jsc4+E55vNiL91aXTzC/C9ryDuzpU3j6eHgv6xF8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/GNUGUx6Sa/5DtLiv69iYDkqexedUuem3+ofn40Z7Y=;
 b=bVN0g2PcRXzybR51rwhnrNvus8xRZA537Guy2HtQThnnA5ekoy/JnnZqW1BZdkh9KNW5MPQT1CU0gjap5oSLXp+9O6lJD4eokT2Z4j0SDvjZicdt1+Me2EWAdVv7V1Syt3skZkvyr9yV/FRYC5YDw0fKVVJEE9PhuBdL4yyV0SARiHh8zNXz0unyh2hTtZHrNwbDdM1ITJvBBLVykQveZ9XuRas26Vdc74uT1RgMmvettRD/pVhPw6mZU3XdCFNgfsUwHWN8FQIaYdG1gtESfM9ad3qEV0Ov2tWrwEB07SLltr8W9pmXtsNqvi6LoQinPI7DfNwRbU8LcoAaol4kEQ==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 SA2PR11MB5193.namprd11.prod.outlook.com (2603:10b6:806:fa::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.16; Fri, 17 Jan 2025 00:51:20 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%6]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 00:51:20 +0000
From: <Tristram.Ha@microchip.com>
To: <olteanv@gmail.com>
CC: <Woojung.Huh@microchip.com>, <andrew@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Thread-Topic: [PATCH net-next v2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Thread-Index: AQHbZi6jUsb5OQZHf0qguVy2R8e1urMWcOoAgAOueKA=
Date: Fri, 17 Jan 2025 00:51:20 +0000
Message-ID:
 <DM3PR11MB87367ED6C8963A2FEB4C349BEC1B2@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20250114024704.36972-1-Tristram.Ha@microchip.com>
 <20250114160908.les2vsq42ivtrvqe@skbuf>
In-Reply-To: <20250114160908.les2vsq42ivtrvqe@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|SA2PR11MB5193:EE_
x-ms-office365-filtering-correlation-id: 163e23de-75de-40f9-b44f-08dd36910ede
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yW4LwVEMus/4+VjllGwIdoSWG4NfH1UqfjuEmwSJm/5C2wP+3VQgbHfyPN7v?=
 =?us-ascii?Q?UxnEmj5MoBEki+i8MRpSSzuzNISXVeq/CzPlXUMmfEdpSJBzWK60+sIxNpHv?=
 =?us-ascii?Q?PX/RUpFbtqLa1hsA7fhGcp1fPKosT35OLZ5ewukW3HUdlQffLObY3LsoG9p8?=
 =?us-ascii?Q?ONJAvS2Tjm261jLcFB8HEmz+Eh3MD7VoeLQ59oTcTUMegrqLPxhA6esU/pVy?=
 =?us-ascii?Q?fdHbrx4NUF9q03oZaOaFNcCked3MXszcHpOGf5c5UZw2+vylGaj5GiTilbbZ?=
 =?us-ascii?Q?WSDKbbd6PIrJlZ0q7xzZP/tqYLPsXc5q6iHae+4Q73UUMdkDIUBSYci3bZsV?=
 =?us-ascii?Q?bZB5MOs5ozstrWQQ7n9hVUz8WEVjFMTAURBYKSI+MH8b+q/7q6oeyn4bTSBN?=
 =?us-ascii?Q?vukLssyeJrM22/UpQAVUDPImVeShn9c/2SVFzLT0OtnImfvIa0g93eTMQlYB?=
 =?us-ascii?Q?yIHzq3EqqyGH39cvMs5opWWbez6MrOeoPsCzoTPQdPy2ONcWJ6MqVN77vjGX?=
 =?us-ascii?Q?Bq4qJgdSpNIy0VJNxcYu2zvXNQCYiibFvJQcivSIo25SDj/H0AI0LeAlJH+s?=
 =?us-ascii?Q?kwsbAQXWxYtwI4QYVI9yJLeIg4fMgfl8l+90oRNiA9KhupIL7+CHQ4WIViId?=
 =?us-ascii?Q?iHBwtrs0PRSCgE5LRvsU+dYpHAGTECQ4CGiMtnmTJhDWcPRxTeFV0YkqQT+9?=
 =?us-ascii?Q?hygun6DQCLzgYEYtuAQ/d1ZP8rnbwkWZLTLwjfcOo+9OuL/2lF+QE+3t+60e?=
 =?us-ascii?Q?f21Z/MCAkCodYq8tag5JYMp9k4ne9dY/TuT4WMoqfTtovb5A2JCx0BEk4hvj?=
 =?us-ascii?Q?Hcnu3020wizeW3LfcsrnazjBhNVurY7P1HIOyPvsbrLlFrFwnY1iDOpSSZLe?=
 =?us-ascii?Q?Uf2rFsRXewUkJthK9sEvoNmCVarVYenL0ym2Gh4IQFS0iYVnyTe60ReLIomE?=
 =?us-ascii?Q?ZlSjfJxqN73INZz8XtvkNYJPSca2lJx2bAO0EFo0HD3zbuGZGCtp7/sPUfJR?=
 =?us-ascii?Q?PYsHe+Nqx/nkUH14IJGswzwrMgdOq795lqtPcAPb34PymEUeXVQ90Fmut7wU?=
 =?us-ascii?Q?KWEbQq9snmPv/vEqIoQLpmtRu53CuCxCLudHGmnp3+5UtF/ghraQdWudwELs?=
 =?us-ascii?Q?jwgMAKzPduLAG393iMJQay+RfiVnqnFyIQwLJNwpVECQaa/ODa263PBuJdLZ?=
 =?us-ascii?Q?Uvn/VLP4UOcOyGz0StVage6GTP0kCzILngfaAvX3nwSsUPWbIHocOoQyh1yi?=
 =?us-ascii?Q?dd7x+9ZtCShnU67wRfxvq1nFrYArrzv+lrCpdRiV5+mpHUMeNbPAj8TjSHZg?=
 =?us-ascii?Q?+LpZDWwSu9Qey8Z8LrTQmgSDQITKDIerwxHd6UZ1N4gTKdBKPFC7RRNUDvGA?=
 =?us-ascii?Q?jy1VLQs17GXNeGuYfgvcpsJF08l0XQFUAC5OOFyqviTxAXUZjNbHzw0J4/Oo?=
 =?us-ascii?Q?OwDK+UwVazRTmqTW8R534bS3rlNsSVls?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NpOU66Ra3xrMle7Aq8LKmbYXQxSzMwRjcXp92zhux0jR2V8a2NHjreWQPoka?=
 =?us-ascii?Q?UmFYwZCH2XuiL6Lh6jyCEiS934ZDIaMaiQqtdRPpDkYgyvew6hE8ylX9l3LX?=
 =?us-ascii?Q?MUMH2jv7JXYxhvS2gWSQPmagkCykbGCY/zzKYTjXFSOjWfF74skuy1auUNOO?=
 =?us-ascii?Q?m+7b4HUXJXPl3kIRTvWqyUTOfqNxTH16zb6DfB+5woU2QbBTN1zDFzTmol+b?=
 =?us-ascii?Q?UNL4//UTC6bqVm+OdUdsm847ky31O03isRvCRYC/buUoL9hxizNhkO0w3ppb?=
 =?us-ascii?Q?VNIDhhNfWVw2vRDB90DNjEnB/SXHWJBDggBjk7i3UW4XMVtXVBziZ5iYT+q1?=
 =?us-ascii?Q?DXu9sPUlwLOV8WjS8aB+x2TbvJyu9lp2ZPws/mTUkcyh/NmvcEraPlbToaQC?=
 =?us-ascii?Q?Br8xuq3TORwrcpWU2ZKBV0Pve0nx9FPXb4cOmVPWeFYFwbpaYP/WkzSd8Kko?=
 =?us-ascii?Q?5zfNd51G2OSkyXh3RBC6NS0dDxQ6tzknWzxCyCfK3k4v6G+8A23Bu6ENFU8c?=
 =?us-ascii?Q?JEZJWsuzSqU1gXwRSbXAy0Q487wdzWyOGoA9y1daxfTz/pozA2dJpjnrk/Xm?=
 =?us-ascii?Q?GKemsKcwvIr9eGEseEp8sJlRC5EHuLuhStYGZb/3V4CzNR3A9oUgeUfnDbQk?=
 =?us-ascii?Q?pODwaZSZ6Ek/AcgV7Jty/piTrg6Lh/VyF+Ul0gfwU1E9A3Hg2pJnyo2JSYLS?=
 =?us-ascii?Q?HT4KRqvcpa8ZN028/k+Oaom0yq5TL/4klbS4bBir4PCfxJUTs1fx94YXKl3R?=
 =?us-ascii?Q?u/3HYvRoxk81MYHgv/h2M1XUOEA93julkgxnjyYkiY6fhdeo4V62rdSxtn30?=
 =?us-ascii?Q?j3r+l8gCHdKD5vB0Wp6W9CQzkSDhesjk22c1MIIx3kb6rlkawWa6h/ZSF4zA?=
 =?us-ascii?Q?J7nZEiriMPdgBcp2O4Ln+/z6cN0sNHxqj+7UdtPZyX/OaySFnz/9OKWzsbt9?=
 =?us-ascii?Q?c8yrROJLTitXJyvpp51dmoyQUMx3uYvIYpid5s4HX443yK7xwwhFzzfnC7rv?=
 =?us-ascii?Q?XPZMOKtWrdHFqr+uGa0tFup3tqWRpHBpPl4NUAaxyGeUu7IJHMjv8lIcmHe3?=
 =?us-ascii?Q?64QACJ4EzZ+10d03/khZPIqww4RVi6lSoDyMBaFwgyp0Frl6sJa4rnxTVp1J?=
 =?us-ascii?Q?kxaQyQqWfH8eGsdFnQgE3MWXGdVn9FIfbPYJwzW2118XyzcxWgX+aN61O5+j?=
 =?us-ascii?Q?vX0HNM+7SbAiqPZNZNzNtVU8qy2lCXz+lNuyoAd2mnw0LY/P/eYPjEUl2VAV?=
 =?us-ascii?Q?CnfxlfsekI2uoDZcIx21U2MBBVN1EygzWutq/UJ4PB+nZFLWvCYVYb0gSENp?=
 =?us-ascii?Q?ZUT2E7pucoatII/YNgH87g2fLAdLrxI5F2XxNjJf9/K9G20c5bqfy0n+q0V6?=
 =?us-ascii?Q?EIw5y8Aig7GdOLPtgSKplLw4lgLW19dqYgt0SO03DjD6DGSS1hMgR23YjNn3?=
 =?us-ascii?Q?41QXcbEQvGCV7oH8Cl1g2fddLD+j0Ym9m8Toi0dYqJCf8pUNuaLCSm1jmpb2?=
 =?us-ascii?Q?Y8a//PzaNEMEq260LXdoOAvH7FkiNBupkgFHDLwVIvYtXQbQBvFxRGGKq2di?=
 =?us-ascii?Q?TAHzO5INegi5fTMpPwhFWC0d50t4WQ7Sf8n+o8JP?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 163e23de-75de-40f9-b44f-08dd36910ede
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 00:51:20.3571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dD5RSt7T0xMhBYLyMorSMhTzi7+zLJak0FhOudD+AEUE7AuZuBAx7ae9Bp2FnZ9VcqRpM6qcbXBSRaIZo7vqc6Go5nom5B5FTnaRvLLT4u8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5193

> On Mon, Jan 13, 2025 at 06:47:04PM -0800, Tristram.Ha@microchip.com wrote=
:
> > From: Tristram Ha <tristram.ha@microchip.com>
> >
> > The SGMII module of KSZ9477 switch can be setup in 3 ways: direct conne=
ct
> > without using any SFP, SGMII mode with 10/100/1000Base-T SFP, and SerDe=
s
> > mode with 1000BaseX SFP, which can be fiber or copper.  Note some
> > 1000Base-T copper SFPs advertise themselves as SGMII but start in
> > 1000BaseX mode, and the PHY driver of the PHY inside will change it to
> > SGMII mode.
> >
> > The SGMII module can only support basic link status of the SFP, so the
> > port can be simulated as having a regular internal PHY when SFP cage
> > logic is not present.  The original KSZ9477 evaluation board operates i=
n
> > this way and so requires the simulation code.
>=20
> I don't follow what you are saing here. What is the basic link status of
> the SFP? It is expected of a SGMII PCS to be able to report:
> - the "link up" indication
> - the "autoneg complete" indication
> - for SGMII: the speed and duplex communicated by the PHY, if in-band
>   mode is selected and enabled
> - for 1000Base-X: the duplex and pause bits communicated by the link
>   partner, if in-band mode is selected and enabled.
>=20
> What, out of these, is missing? I'm mostly confused about the reference
> to the SFP here. The SGMII PCS shouldn't care whether the link goes
> through an SFP module or not. It just reports the above things. Higher
> layer code (the SFP bus driver) determines if the SFP module wants to
> use SGMII or 1000Base-X, based on its EEPROM contents.
>=20
> Essentially I don't understand the justification for simulating an
> internal phylib phy. Why would the SFP cage logic (I assume you mean
> CONFIG_SFP) be missing? If you have a phylink-based driver, you have to
> have that enabled if you have SFP cages on your board.

I explained that the KSZ9477 board that is used to verify DSA driver does
not have SFP cage hardware logic so that the EEPROM can be read through
I2C.  The SGMII hardware implementation is used on other boards that do
not use Linux so it is not always required to have that logic.

I do not know whether customers followed that example and setup the
hardware that way.

Anyway the PHY simulation code will be removed and the code will be kept
for internal use only if it is not desirable.

> > +     port_sgmii_r(dev, p, MDIO_MMD_VEND2, MII_BMSR, &status, 1);
> > +     port_sgmii_r(dev, p, MDIO_MMD_VEND2, MII_BMSR, &status, 1);
> > +     port_sgmii_r(dev, p, MDIO_MMD_VEND2, MMD_SR_MII_AUTO_NEG_STATUS,
> &data,
> > +                  1);
> > +
> > +     /* Typical register values with different SFPs.
> > +      * 10/100/1000: 1f0001 =3D 01ad  1f0005 =3D 4000  1f8002 =3D 0008
> > +      *              1f0001 =3D 01bd  1f0005 =3D d000  1f8002 =3D 001a
> > +      * 1000:        1f0001 =3D 018d  1f0005 =3D 0000  1f8002 =3D 0000
> > +      *              1f0001 =3D 01ad  1f0005 =3D 40a0  1f8002 =3D 0001
> > +      *              1f0001 =3D 01ad  1f0005 =3D 41a0  1f8002 =3D 0001
> > +      * fiber:       1f0001 =3D 0189  1f0005 =3D 0000  1f8002 =3D 0000
> > +      *              1f0001 =3D 01ad  1f0005 =3D 41a0  1f8002 =3D 0001
>=20
> Hmm, these registers look extremely similar to the DW XPCS.
> 1f8002 =3D> DW_VR_MII_AN_INTR_STS. Why don't you implement a virtual MDIO
> bus for accessing the XPCS registers at MDIO_MMD_VEND2 (0x1f_0000 +
> register address) and let drivers/net/pcs/pcs-xpcs.c handle the logic?
>=20
> It will be better for everybody to understand what is the special
> handling that your hardware integration needs, when it is relative to
> the common driver.
>=20
> You can look at sja1105 and its xpcs handling for an example of just this=
.

The XPCS driver available in the kernel does not work in KSZ9477 as the
SGMII hardware implementation is probably too old and so is not
compatible.  Link detection works but the SGMII port does not pass
traffic for some SFPs.  That is the reason that XPCS driver is not used.

> > +int ksz9477_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
> > +                    phy_interface_t interface,
> > +                    const unsigned long *advertising)
> > +{
> > +     struct ksz_pcs *priv =3D container_of(pcs, struct ksz_pcs, pcs);
> > +     struct ksz_device *dev =3D priv->dev;
> > +     struct ksz_port *p =3D &dev->ports[priv->port];
> > +
> > +     if (neg_mode =3D=3D PHYLINK_PCS_NEG_INBAND_ENABLED)
> > +             p->pcs_priv->using_sfp =3D 1;
>=20
> When neg_mode =3D=3D PHYLINK_PCS_NEG_INBAND_ENABLED, it does not mean tha=
t
> we are using an SFP. We can have an on-board SGMII PHY which requires
> PHYLINK_PCS_NEG_INBAND_ENABLED as well.
>=20
> Generally speaking, this implementation seems to depend on aspects which
> it really shouldn't be concern about.

It is just to confirm whether SFP cage code is used in the phylink
driver or not as the device tree can specify using managed sfp.

> > +
> > +     if (dev->info->sgmii_port =3D=3D port + 1) {
>=20
> Can you use a different representation for "doesn't have an SGMII port"
> than "dev->info->sgmii_port =3D=3D 0"? You can hide it behind a wrapper l=
ike
> ksz_port_is_sgmii(). It is confusing and error-prone to have comparisons
> against port + 1 everywhere, as well as to set 7 in the info structure
> when in reality its index is 6.

Will update that.
The SGMII port is specified in the device info block because it can be a
different port in a different chip like LAN9374.
=20
> > +static void ksz_parse_sgmii(struct ksz_device *dev, int port,
> > +                         struct device_node *dn)
> > +{
> > +     const char *managed;
> > +
> > +     if (dev->info->sgmii_port !=3D port + 1)
> > +             return;
> > +     /* SGMII port can be used without using SFP.
> > +      * The sfp declaration is returned as being a fixed link so need =
to
> > +      * check the managed string to know the port is not using sfp.
> > +      */
> > +     if (of_phy_is_fixed_link(dn) &&
> > +         of_property_read_string(dn, "managed", &managed))
> > +             dev->ports[port].interface =3D PHY_INTERFACE_MODE_INTERNA=
L;
> > +}
>=20
> There is way too much that seems unjustifiably complex at this stage,
> including this. I would like to see a v3 using xpcs + the remaining
> required delta for ksz9477, ideally with no internal PHY simulation.
> Then we can go from there.

This is used to accommodate direct mode as the SGMII port can be
connected directly with no SFP in between and so will never lose link.

> Also please make sure to keep linux@armlinux.org.uk in cc for future
> submissions of this feature.

Noted.


