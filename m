Return-Path: <netdev+bounces-130702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 307EB98B3BA
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 07:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 547961C226DE
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 05:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5061BBBD8;
	Tue,  1 Oct 2024 05:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KpdOzYfx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493381A4F2B;
	Tue,  1 Oct 2024 05:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727761096; cv=fail; b=gLLTedz9LnUkZtY8OCPrwl1RNcIH9myaHoUcAtPHALbqXH9pxxvxtJUHw0yTdbLq37yn9Udf9K5XWlK+T17KpZAEMOTfjEH/jXHEqgERTP8ebDJ0SxKEQVOrYKFblhlbk5kl3dYrkeIBUzwP651OVppQXLbvkBytES0gndcEp0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727761096; c=relaxed/simple;
	bh=wm7pckKBkYvmnrnClM/3J9LIP1zgNFUDS+G6qn0lQk4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d1I5qtdSIItgOfezdu18bqac4cizaOoRDNEgoHB6rtv/ENBLUe5sjaFn7NwjV1bCZLAm29oAD0/uaMuE4pnp4IWRvEyapIcx3MpEL4g3ezDzDyeVB/xeJXaWAY2v76h1mvb5AIXwpduTYZ8nP59SW26KSzZz9elMtgsgj5e8Dk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KpdOzYfx; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMHTX2NNo0s52YWlMH9eubBB8wYpH0Vxk3IqjupvQ5sMRwfP7MHaRQPtsMgSQAYj7ApsOJhsGD6FYRHIzgs2ltp6HwMLSBRNxBk88KOxl0Nm5C3ej1rMNoh2hZxnSjpGmPEQvqicyXv3KoXLQ6oW1nHVm8vRAxe75sCHWT62/aFUwaiyiRT5Lqp8+nZNoLPQ1c6qzYBF8lq/+8U62ZTFO+6aey157FtC5WdwoR34uiY4pAGEqEDKPcAosECJ5tx3R8Xv2VVmuA1O5O9P407fkmY9mHYkO+28ghZB8osinvF6SrrI3W1zHKwfqJTDc+K3zuGgBs/TQR4CVuzbUt+t4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wm7pckKBkYvmnrnClM/3J9LIP1zgNFUDS+G6qn0lQk4=;
 b=OurqZrmQBaLBcwONTK/ypNXTbSswk3dBdSATvLZmVl49jfXZsoFx1QYhNiDnnF4G0bL97sKurAVqq9wwcYKDgxFdVORFkl92ZrlXpO1wSxh4v8lGYdOXrD4paBaezmVQEjwoXP275/5WMgSI2+2Nb7xEXOaKy5kI85/4NHjRfA1Q4hP11S8OodPs8Jr2kM50AYf8i4g4B3wJ8TdjVvNF0RXeg9FTd1EQ7nXYN7LsUtE6joz9hPDdya01eVuCBitJ1TQYkPrue5mDqgneXLmJGFqEWV9sCh1RqYyfnOg1hU/t1E2CAtSYGw90UsDFO1Mmqh80R9Gj/UsPv12yAJeiag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wm7pckKBkYvmnrnClM/3J9LIP1zgNFUDS+G6qn0lQk4=;
 b=KpdOzYfxVgnjJ7ibMcK2ClHN9ORpcaH94kKlamYwI0pcIZxevP3EZiN/v2W30Zj3cuPWkd+TR9XWjfB/xnTpNpGboH05dyPygyTzMAlWpoXMLLfR4BzxlXcOU1LlGKsbK8Z5QNJ6M8owTGTgaAxOeeRJH7vppZICHjPcsQH7FsI6zNQlStND4zbexNhGv8VKJ8WA8a33nTxiYaNEdscz/dm7UCUo9d6tnF5CHANgtFBHCpGpLeNZyxhCUm5bJx5pDQKpxk26uytrVmOtlWvm+uc70FfK24AOobqpiJJupNSHI2dgfAOxaZysbju8vuqllw9zC/ksWqLscVdsIpxpMQ==
Received: from CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9)
 by DM6PR11MB4628.namprd11.prod.outlook.com (2603:10b6:5:28f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 05:38:11 +0000
Received: from CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708]) by CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708%2]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 05:38:11 +0000
From: <Divya.Koppera@microchip.com>
To: <kalesh-anakkur.purayil@broadcom.com>
CC: <Arun.Ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] net: phy: microchip_t1: Interrupt support for
 lan887x
Thread-Topic: [PATCH net-next] net: phy: microchip_t1: Interrupt support for
 lan887x
Thread-Index: AQHbE01nB5y9tkf9zECXlzvwEYnrpLJwgi0AgADfKsA=
Date: Tue, 1 Oct 2024 05:38:11 +0000
Message-ID:
 <CO1PR11MB47715C189FEF1E07FD3466BCE2772@CO1PR11MB4771.namprd11.prod.outlook.com>
References: <20240930153423.16893-1-divya.koppera@microchip.com>
 <CAH-L+nMy5k7fvypd_7SczKs=5ZkpOZb2B3RwTz4sCHmrjdX7+A@mail.gmail.com>
In-Reply-To:
 <CAH-L+nMy5k7fvypd_7SczKs=5ZkpOZb2B3RwTz4sCHmrjdX7+A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: kalesh-anakkur.purayil@broadcom.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4771:EE_|DM6PR11MB4628:EE_
x-ms-office365-filtering-correlation-id: f168ce38-51cf-49cf-a83f-08dce1db3cd6
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KJEYuwdp/PFXcnb79SEs+lzUu3ewZBpbFNmIVJYs+cvREt33+qRPtneBTzZx?=
 =?us-ascii?Q?dkm2WGrtHjuhXU+i8BCwQPxUuVVam1rvQr+yQ1cNjKEqA6WOKONlELquLin9?=
 =?us-ascii?Q?0y8DpW60Z/Ug/wNnqeSJFXMCnxB7Crk2oSjQNd352Pyv2IAFJWE2wDmzaAPw?=
 =?us-ascii?Q?e9+n354Ya0zzvrbTmkT8QPZwEnwgA44tLkQOSEOnz5TqPVuM1nDakWAeEZUM?=
 =?us-ascii?Q?NTE1w1jxoGlHsou9AzhObguutz6H/0z/z/Sgpg7jvY7Lm2bp2lWelff5PMSP?=
 =?us-ascii?Q?7ig/CPTgKF2KH/T86DkLwpce+SWZMSTd8vngHVoF/mPmwQDx718k1+Jtjttk?=
 =?us-ascii?Q?dvsRj+6BdpnLDGUL/io4CCfcEN+a7xMmqoZg7DlGIZT2fbd0wRbnHZ4sEt7B?=
 =?us-ascii?Q?M7+8m+tXtyO1YanUGdyc5UKaQ1awiSggYcdNFHIzX1B0nAdnK6iod2zJDhZZ?=
 =?us-ascii?Q?8+XmXrdXkgh63/+SQsm8TtXl9rLxqzq4H0QMRTgMS1M3einkDLd8/hmCfTC/?=
 =?us-ascii?Q?QjuDj7Uv072IIlETSUDl5iRPmYnTSFddef9voxRAGLhMp5jFn07EMraKuUSy?=
 =?us-ascii?Q?jLB8beX/4y+zHUv1gFooGH6BiR/2/UN/4clhpnHNcP5giCb9t/d6iCv7C0Jp?=
 =?us-ascii?Q?PvaoTOS5tIY6r9kvawoSc8jHACaC/l8j3xFoBw7lhmxzoSjKsIpOspDMR41u?=
 =?us-ascii?Q?0haLX/+NxbedJ2f+Uu0PTAUrqt8CfCgYi90DtGj8CyxkKScS6jh+u19mFvE5?=
 =?us-ascii?Q?dXzo4BqKRdXSjXG1zWqrWiEvVbWpFlYS7WsjYAeMmpIOOO2sy8+mshAczBEA?=
 =?us-ascii?Q?hTJrG9ERNYSxlncgvTrEBHSO8j5EQlL8vRzZn6wYk1Gd++90gm4pFibICNqW?=
 =?us-ascii?Q?UD+yDFv8a1cySVAcPWB3PIzQCTQpvBUU/ufstBMWqwRwGWghE3IU45xMnlgt?=
 =?us-ascii?Q?DM5kvANRTKU/3OEAb9CtmskPwsKmTHoJFs7I3tiqAiMYqy6b76NHH+tosTod?=
 =?us-ascii?Q?j2gH7m4Re1qwm7UtDQQ1rcMEu25F3gPFaiFheiPJ7w7uQwJaAcFuS7cOb+cA?=
 =?us-ascii?Q?fg+3LZYeZTE0L2k8HmtCPlWdwWLt0mo0C9qz1sHoSCx8JHbxh9NSaQUy/RGe?=
 =?us-ascii?Q?IWcmkABlLcPy4GqA1FrpxwNewpSLk300rFxrivJnaLySiVWWXdARPrFH6dtL?=
 =?us-ascii?Q?mkRVkCDyfAmGCvvKbEKZuvkv6az/JUPLps12xvg2VlR5t2Q5UZQAAg04o1FI?=
 =?us-ascii?Q?Fh+43Wie8/uKXGZgE9DT+BLcK8JQXDZGtCfxXQEFLZT+dOoQ22nWtIYbI8eB?=
 =?us-ascii?Q?RG2kbqYx+855yeyE2ylbHzrPghjcT94vtKFu1xinNMh5Y8pdMXInpGpQnGHU?=
 =?us-ascii?Q?jZ4YGgIqN5hsGsojGPjluWMNjkLFecsKG52Vx5vQbTMqbYdMJQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7iR8wnVT5yZ67vp1OX7dWJvYr3mQt3os0pMbBOsOq2Ad6LrROaMehAAyNltl?=
 =?us-ascii?Q?mXErSaZfnEvXLzQ062pSgvjQ5Iu4399mToIaOcL0IyWcfV8SkmL2gJP6qLVd?=
 =?us-ascii?Q?ON0nfZmgZB/4nsO7tTvxANJ1mxwLVGVeH+6G5eql1/lkUhw7ichdq8KdpXHz?=
 =?us-ascii?Q?Jx/HQCul2YSx5UtY9h5R39hLBc9TJl17uMgZZudroRpjHVWzdZS3B8ddfVYn?=
 =?us-ascii?Q?rV0DlksUkd3eS2bEHkvAPw+D5v0LhvDT6Xjou7aOCl3cG5em1KHQZFysx5r+?=
 =?us-ascii?Q?yGJuLz937F2qtAHHBKmjkWtB31OzRS2U9zjBekRTGTecDy9Ni8s31EpGiVQw?=
 =?us-ascii?Q?biUlfRJV5TCmkEgjUkXRvcPvUjMFkZ5VXxgVHRTu95B3dirUeiFBPj6D+hSm?=
 =?us-ascii?Q?YjDIO8Ww8vVPqvSYQ7p9mD+HSBvrJfGHgQfnl58Qp1TPNSQh0lhu88/0Gv43?=
 =?us-ascii?Q?IWkLXjRmklLggDBx1R946QvClp54kFOAtDCVuOIchtfWq4XxxjrSegNklzKF?=
 =?us-ascii?Q?FRYbWg025MDu7XBdhcP2iwS7s/dZfyXDWPh8B80MzNL1RQpJrE+TVsUP3qcr?=
 =?us-ascii?Q?AAZ4bmy8KJZ0TBKTynj+G142RFA3El3KNEqvo0pPfTvKtBJEKaslbSNumVnA?=
 =?us-ascii?Q?Dpnxjjw1WI/zsuSQm6bNPErdqt/SNCw7cKm8oPuK5s5xyUzTH624/SLoozF+?=
 =?us-ascii?Q?xwAOu+dfkibde89x7/okbK2FES1GwosTEpWp4fOzzkLwwoausTdBeBEGvA6D?=
 =?us-ascii?Q?ydwcULFlfq67Y+XIdMTpb42+TVjIMOQJreyNzUCASX9D50heda5hhvS7B2uc?=
 =?us-ascii?Q?yTwz38/opUbzM2L3gqgw31VGvMb+JsUOHkSupr+0KTH2wkkgDOw5I+AhjRP+?=
 =?us-ascii?Q?MiNEPR0NrihTVGNH9iz33mDQytergSVp0h+A8TsKAqZzF++bxYYpRPZQdpgg?=
 =?us-ascii?Q?KgzykE5MFuShqXIo77Y3I5ywgnILnnbc8UDLJsk7Z6/tk6zL9ZPreew86Ep5?=
 =?us-ascii?Q?E55cTMzzXK2uA/2vGKccUnUoCvAFqWA0i8AQugwwmN0fJ6u3sfg0tll6XdPv?=
 =?us-ascii?Q?Lu3FtojPkJoDH1omhxKt4JBq48k1zSHPLfWWwriqLZSngTzUdxt0O5oZJ/p2?=
 =?us-ascii?Q?zRKaIxmsltTQ/EalIz/SRyFFTtxdAqPm8MPg4yP3coNrkOYpiiKulJDS7Wpw?=
 =?us-ascii?Q?lpTdbe4UFvn5BL4Sg5UuyyyMG/04LEnZIP7VcT6e5ipwVoAmwkmsCVKUYsmj?=
 =?us-ascii?Q?reW5gPBZwieSW8RCwJBoNfvazmfdO0KoyEZDbDBHdyK7xChXkwvlBaaEs2Ko?=
 =?us-ascii?Q?yMIqk44JtVZAzfl3QWwExplPdwIdvXFXfCtP1v5ZxsELbEHdI+GBoT/R8DGg?=
 =?us-ascii?Q?KkXjSCt8Pec4wqsb+z4OqSBTHPjgBIr7KeJi8k6HViQIw+23WGUs3g+MNam2?=
 =?us-ascii?Q?DsknSMclXtc7QJrJCxR2Q08fPudSAcx1YnerErlhd8RnIU4WomCm+oYcPHMT?=
 =?us-ascii?Q?vDJZByrjk10oakRzNmLm2aesVDziD4FGu+h1wOnJmK1EuKoO14fLBxfXb91C?=
 =?us-ascii?Q?WOjz1s7NVLYLXSdCu5cnA0ahjFSVDFBj/L/EGVqcATtgr6uncs+1iII6/Op7?=
 =?us-ascii?Q?qA=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f168ce38-51cf-49cf-a83f-08dce1db3cd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 05:38:11.4316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uExCH1jQ2aNTG02teUWpNQdhFquReCpe1T7c3vQOhhvOz0T0qiaJ8ZIcy1ziZ3M6RF3zDEOadIgjNp0lZmsMHcJxdAItIc5BJPalvcrt1VE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4628

Hi @Kalesh Anakkur Purayil,

Thanks for the review comments, I will apply it in next revision.

/Divya

> -----Original Message-----
> From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
> Sent: Monday, September 30, 2024 9:49 PM
> To: Divya Koppera - I30481 <Divya.Koppera@microchip.com>
> Cc: Arun Ramadoss - I17769 <Arun.Ramadoss@microchip.com>;
> UNGLinuxDriver <UNGLinuxDriver@microchip.com>; andrew@lunn.ch;
> hkallweit1@gmail.com; linux@armlinux.org.uk; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH net-next] net: phy: microchip_t1: Interrupt support f=
or
> lan887x
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe

