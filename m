Return-Path: <netdev+bounces-127861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1191976E60
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 18:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 974071F21294
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 16:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3426E13AA5D;
	Thu, 12 Sep 2024 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TNTWmrGZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011B42AE8E;
	Thu, 12 Sep 2024 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726157091; cv=fail; b=WZBdfcDw+9mrlPBugkMwrJMTwCu02r273dPv5i8GqljYKu7dzfYmcDnUiVgqCXbTDyfvKwFhJDUZETf7clznfLfXjTKmoufvgh3NbX0TW3Vq6/VACzp8w78KzvTU7Vq+jf83bXrzEscA0DTTZ4b7KCq2mXypwCj3+bxCiiw/fDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726157091; c=relaxed/simple;
	bh=9H1GoyJsodH8jK2QLyCFf+kZmvWDjSSnoQrXAmOlW2g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RoGmdjLEd4vKcP03fKggohRA+dzcAA2VZcsB9QuP3sH6s3+pAH3r+EsKKJ/sq2USkC1YC88AFysjqatJgX7YisHx9Dd/nhQC+MmEYhPT3wSqaHv/oTBYneKCs9jt2ivB/7qcYjN8uznN5B7BXu8UUgcOEQYfPZZ9CJDiur1g7Mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TNTWmrGZ; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iT1emN3DvTDGTRwYCmRMaRXrTQ4o6lAs4j0YGdYGvEu3N87U3TPUM6QzYOK8SdTozeGeVw3BJbt1aAY3riRlLaGqGHWTuKMjFXBZ/FRqOodHNiklyipS4PdrOJodAv6ULvD3jY1hoHda478/7GyKuXLhEs95pN2knNd3S2WPeqvWVKXPJ0RB23FFGosVyL65Y/M086UMoHeSLllvu9pP9ELCXeX2JJU78LiqlhjINgNg8Z1tHvgfW069t1eH8MSCcKKowhInQelm+YEq7/yX5kOu82W+gS7QJph5KJjK9e5wwoqHnBZy3PbaKkN1ip7iMtfGkoZLYe7RndLnWrnx2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ej7cR/lNY8NbVRI5Sj0VKVY/GNRTtlXz93lj9znsgaU=;
 b=Z6uZGb7lirkHEMxLJDHYMmRacKqhhPJ8EOtnQ/UMmYAATKE3p36H/+26h9ecpzvM1dSEbmGIOXmx9wu1DjZrp6VvRFCKGxw1HORJI2Jf0LsYJu7R024ON5D6CkQrC3tiJfDHIHPQLFCNApCylSPwyQ9FZMnUbRuPDCycTYzr2b6RHAyZekVpKW5ZSapr+Aomd3Ww/eR3E/5DUSGpfhxNIqRXcaA7RueA+b5yc5xV0vm8gkro3PS02um3zuRnxM9eHeMLm1pAXmkOjGh1yF7fbzeVH8xiC/ygqRQjGWJTfytHQ+oRFnPRKPUleeXUCq3q5rWsNxFkHfLlVTn+8EpIOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ej7cR/lNY8NbVRI5Sj0VKVY/GNRTtlXz93lj9znsgaU=;
 b=TNTWmrGZBEBKb+FIS022Kz9WaM7J5xJitgsy3P92r1yr3hBajI4eGutrC41RY6ZJKfgNieC4S4drqPGlxqibnZcnWNELl2VgkRkiMGosaDcP/Df2+Pvisr43WuR2Nglfohx1eqCpanR+JJzUBEcaqAG+pjUlFC7g4A4/2n4TYlkETu3eUfefNh6uJtXNDuK9aZetbnwot/VZWJa+3pnhjbEBrPPo3P8CShWlH0KF4WwpjHc+o/pJT+ZJiQni+GKP7HkbBAf5AAVU6nYpfrf3wKbz4SK86L5JjSgTw7+yLsKOjwwyfz85zfa5D5RkzfDaxwGXIj7WngyN4/jpw5SGfQ==
Received: from PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13)
 by LV2PR11MB6048.namprd11.prod.outlook.com (2603:10b6:408:178::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 12 Sep
 2024 16:04:31 +0000
Received: from PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739]) by PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739%3]) with mapi id 15.20.7918.024; Thu, 12 Sep 2024
 16:04:30 +0000
From: <Ronnie.Kunin@microchip.com>
To: <andrew@lunn.ch>, <Raju.Lakkaraju@microchip.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <Bryan.Whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<maxime.chevallier@bootlin.com>, <rdunlap@infradead.org>,
	<Steen.Hegelund@microchip.com>, <Daniel.Machon@microchip.com>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next V2 4/5] net: lan743x: Implement phylink pcs
Thread-Topic: [PATCH net-next V2 4/5] net: lan743x: Implement phylink pcs
Thread-Index: AQHbBGX8VAfW8KWmWUiadZFQXqJr/rJS1qaAgADhgICAAI/DAIAAAwnw
Date: Thu, 12 Sep 2024 16:04:30 +0000
Message-ID:
 <PH8PR11MB79651A4A42D0492064F6541B95642@PH8PR11MB7965.namprd11.prod.outlook.com>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-5-Raju.Lakkaraju@microchip.com>
 <c6e36569-e3a8-4962-ac85-2fd7d35ab5d1@lunn.ch>
 <ZuKP6XcWTSk0SUn4@HYD-DK-UNGSW21.microchip.com>
 <cbc505ca-3df0-4139-87a1-db603f9f426a@lunn.ch>
In-Reply-To: <cbc505ca-3df0-4139-87a1-db603f9f426a@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7965:EE_|LV2PR11MB6048:EE_
x-ms-office365-filtering-correlation-id: 3695ccdb-a451-480a-e053-08dcd34495b9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xXNMKgryC+nXenyl/+VWyw9OjvZC9VVBheOOV/wCzq4UfohMih4/jNVyQI+P?=
 =?us-ascii?Q?Rl5shV2epQCiTjhKLnZKj+FKYJ4jzzHqRWsUxOe9bTBwSSDdaZ75nFi9EU1o?=
 =?us-ascii?Q?NChtFFkEFGrB87F7j1oYYsTM41dPmlPw6epaubuQ+EB2xQBQ5vTi4LbfKGpp?=
 =?us-ascii?Q?ZwHmqtdBdLb47rphbcKmUDJ4xNdnuSJ7CrwtAP1xR4Vuxprm/GpmqVyzfraU?=
 =?us-ascii?Q?U/t7A04TRXh2ulJxLdPzsCixkPEbJhtGKCRcihP0S9VEyKCHqj9RCdaeBXML?=
 =?us-ascii?Q?JTESD80AUHnS+qtAmNYBuuNRW+j3MqAlhpc3t4QLPGF1YRmPjKNbUeHbYSRP?=
 =?us-ascii?Q?4SXrh97GsAvbUHJ9DLHhpp57BMfd0ZeOrxn/YevWvXSZChso8MjNFXY2sQiK?=
 =?us-ascii?Q?KHHGwseZxrwj8UkqfT0RNeo90WUzcBP+wc6RBd2QJYbkDvcodmKgaD3ijMyS?=
 =?us-ascii?Q?a5sTodiwrmnS7Dt6o01OVv8x9qh0g/BZOKk8PFhl0vcNHZih94kaURBarJ8o?=
 =?us-ascii?Q?Q+HtsPI8OF/1GDCfMXxI5KzaI1lwD2M9ye66r0D8iqnbrV4RBT23YX+GlVFu?=
 =?us-ascii?Q?dnKZrshYq+nTaehNeQ/afJRxeXF3mcU7FH7792ymMHjRGZEk6CL4BZkeYBIr?=
 =?us-ascii?Q?AQg5+eSA2DNzCAvNVYdKrbpeei9Ydpl3Mu4t5Bv8fZ7p89iiInoJEfSZ3WRi?=
 =?us-ascii?Q?7z0Ta7nifcvS33R5jrBzKeF1CNO9kSWiGJVscTmPXsPqs8wiFgfGJj85gGB8?=
 =?us-ascii?Q?hLaBJTQOXKT1d0bmDpa9VaZnFAu3bCV5tX2pxsHCsaw99npNul1Ja5wKCHY2?=
 =?us-ascii?Q?p6FR7Fky8qr7EY3daSvboaSF7LPphJ/PJTRaTNU/YLmBDdRKtvV/zkQHcjTk?=
 =?us-ascii?Q?xefALILwt3+E715yoZPLm8ym/UdQvijuAaYDWvLiDRVHS4ZPUw2IQN4t6VS/?=
 =?us-ascii?Q?jcNaezC67VzsFWF7e5qrskO3oidL2uqsJlTe0DJTbPo+ZjtRqXO+JX5SpD3w?=
 =?us-ascii?Q?aNHS66TQotarCgTcF5Q+vhZGGER74G45PephSiEga6oVX+U2kdarWsHGY9PT?=
 =?us-ascii?Q?IUCdrEoBuZsD/ydLGc6MnrBn1tlr17I7msJa037JiK9i8zyZQe86xTk3afhe?=
 =?us-ascii?Q?TEp9g+o+4qCeENM1XWUXcXhNm0Z6TsgWaJ7w3hVG4t68p5j5jvAudoZGuetP?=
 =?us-ascii?Q?ljoPwXY31Kijk2o9PnoJ77WNQBGwQ+UBWXKgzLxnIzG9Uz+EX/mhItH1qD/Z?=
 =?us-ascii?Q?PP1ZMEd2O+QKiteOrt0lPz1eZDqRtxVOxnWQg/BiDEwHRQUqbkvldu+++tOm?=
 =?us-ascii?Q?ggLNBKr97+DjxdwkuHC650S3aT7TEhpJGj2+d7clyV9xySu/g8GyMNSjK7JQ?=
 =?us-ascii?Q?MuVDoEzwqCBqhV8/8z+5L48HporPwfSUQV78Z6ODUlHveq7tgw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mGCqsiXPiwJo5axEPLdGlL4v3VAXC7envL6Cd4Bi396SBBjW/F9quBt1mQGO?=
 =?us-ascii?Q?oF3c5XxzAMLW22xivTYTDrtPcttaOg9nCmrxJXziAW8cG2sm8Qpow7p3DRmA?=
 =?us-ascii?Q?CSCk7BBk0fuGcs4pm1qlPIV4Sr8rPnL8E5L6FFpNp+TovFznNnO4DkNGftKs?=
 =?us-ascii?Q?HL3ScklScXig2P/1Nw/Tc7SoczcG1ru7Wey4z2nkBWvnC3pXda6SXn2cA96K?=
 =?us-ascii?Q?ioh6Le1FyrQoOZ+KJjAmg0aWyp7xJ5odfaCahkXlREmRfLkSvKjUxsMd33+A?=
 =?us-ascii?Q?rDS7AVhMd7CeBbVedqZmttQ3Fc+eaj0qBGJbrtU/b7PPMb5tI3MkorsVfRBf?=
 =?us-ascii?Q?FUu8FsWG43GQreL3v+M+RWrfrAyRV+7K/yZDTaE7QVC0Y4btdB3ClF+9GgC3?=
 =?us-ascii?Q?hz7Nj56dy3wJUSUdgsaNXiqTI/+d3x5WFr+9QZdDu7hX2iBJQT+Aq+Fv2Qm8?=
 =?us-ascii?Q?GRDCZgF0A2BPngMrZ3zAZ4s1z8yvahJNVjl4EWosAsk9QWj4axwjThNR37BJ?=
 =?us-ascii?Q?YpI0GrsM0iaglEAWMYrpwL8I8tbYc2TXCcoBHtH/9INrZPnKpLvQeGr48wem?=
 =?us-ascii?Q?lohw/vUliODqykoqtcVuHTqzdtq1ZzWG/mec7SHWom1DqE3BIqHaBfYaNPWT?=
 =?us-ascii?Q?c0ut3mpdVXhgmbiD4uV331N1bgLpYM9r+EG+PtS1YCSoGvvS/DQMknzWe7WD?=
 =?us-ascii?Q?nvf6KS+izFdhACa+YyNA90+EvFWci0gr3rk0XtqhFxMVFHQUQs4SJyKHPP2G?=
 =?us-ascii?Q?hRWeIMbmtCu4+wpm3ouY/ZNYr5yf0m1NoHyUEX9FH45AI1Na65DaazClgU1o?=
 =?us-ascii?Q?+T0HLTsZAWQkxsxxQXKmWxWmuFyRGoGyPdUyIGoTgdMU+zUxizrbEbqHmeG8?=
 =?us-ascii?Q?S1vPBLbcGKTAy1/7ISvPgZMW+MAhgO3FgGP55ogdeKot8Ow/qXGiWVVdDXDU?=
 =?us-ascii?Q?ciBzwCYWkaREJXDr+say4uldCReSt2BbyTrhWMv+WdBwI9ybUwp7eosh+2jP?=
 =?us-ascii?Q?ghhuhS3StdvLaMrVHS/Pk7bDVm8kNidPiAmjWB5R09hYripRFTCFQfZe1Q97?=
 =?us-ascii?Q?tnQTyu7RWUNCYfxbhWxqfHlYo8CQH5ZkKhBj+R1iNSimyZ/rvQ6IsvvEyTEy?=
 =?us-ascii?Q?ZGazcEEPNpTTSMiJ5swu716o57qGbvq+VP86VPdZ/dFP/7lW4FUsAF5+/EVl?=
 =?us-ascii?Q?qP4ttvRJ3wSPHP+VWedhepdxgSjqKERlUZKHilhrniEIuqAoW8Ht8kptDRpI?=
 =?us-ascii?Q?kNJNerJEF7Y72e7RuKFMxIa/rotEzcMPGhRheC0wvaV9xiOChMBBLcX6Fm4V?=
 =?us-ascii?Q?YZGHa9z6vIFNT6iiqhjtXrGAMVQ26eKwr7LcBCfFvFPOUZnTbifpJZD1dYcb?=
 =?us-ascii?Q?L2F46REE5fbaxU9OxC8+o01KYg/GvkUV0d0JiIP4H6KlNHYaDH8L8mKKQjlG?=
 =?us-ascii?Q?2Dbef52XaI4s4J2tuCjPS69O/QS4Uqvdxn7ZshF5kMuoDKe/p4f3DbVNwRUW?=
 =?us-ascii?Q?0R3w+ItFNdKwcxXx7ckvKKmMy8HOUUK2xCEoEg+9I0mr6nFSCKiv116l7Tb7?=
 =?us-ascii?Q?X+d9ET7vd5hBgOK8kLG57CElGcEVq3tBsoGyGNZB?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3695ccdb-a451-480a-e053-08dcd34495b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 16:04:30.2912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vFG82VzZYrBVp2jG2AdjlXgRb7jrEt+JBM+jKRgwjLhCOXQkhQrpkdcX0daB3yON99ASElaWuoaNNOYQBGMnNW7TvmXlUtHYb1G+c7cCrYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6048



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Thursday, September 12, 2024 11:28 AM
> To: Raju Lakkaraju - I30499 <Raju.Lakkaraju@microchip.com>
> Cc: netdev@vger.kernel.org; davem@davemloft.net; edumazet@google.com; kub=
a@kernel.org;
> pabeni@redhat.com; Bryan Whitehead - C21958 <Bryan.Whitehead@microchip.co=
m>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>; linux@armlinux.org.uk; maxime.chevallier@=
bootlin.com;
> rdunlap@infradead.org; Steen Hegelund - M31857 <Steen.Hegelund@microchip.=
com>; Daniel Machon -
> M70577 <Daniel.Machon@microchip.com>; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH net-next V2 4/5] net: lan743x: Implement phylink pcs
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> > > Also, am i reading this correct. C22 transfers will go out a
> > > completely different bus to C45 transfers when there is an SFP?
> >
> > No. You are correct.
> > This LAN743x driver support following chips 1. LAN7430 - C22 only with
> > GMII/RGMII I/F 2. LAN7431 - C22 only with MII I/F
>=20
> Fine, simple, not a problem.
>=20
> > 3. PCI11010/PCI11414 - C45 with RGMII or SGMII/1000Base-X/2500Base-X
> >    If SFP enable, then XPCS's C45 PCS access
> >    If SGMII only enable, then SGMII (PCS) C45 access
>=20
> Physically, there are two MDIO busses? There is an external MDIO bus with=
 two pins along side the
> RGMII/SGMII pins? And internally, there is an MDIO bus to the PCS block?
>=20
> Some designs do have only one bus, the internal PCS uses address X on the=
 bus and you are simply not
> allowed to put an external device at that address.
>=20
> But from my reading of the code, you have two MDIO busses, so you need tw=
o Linux MDIO busses.
>=20
>         Andrew

Our PCI11x1x hardware has a single MDIO controller that gets used regardles=
s of whether the chip interface is set to RGMII or to SGMII/BASE-X.
When we are using an SFP, the MDIO lines from our controller are not used /=
 connected at all to the SFP.

Raju can probably explain this way better than me since the how all this in=
teraction in the linux mdio/sfp/xpcs frameworks work honestly goes over my =
head. From what he told me even when we are not using our mdio controller l=
ines, since there is indirect access to the PHY (the one inside of the SFP)=
 via the I2C controller (which btw does not share any hardware pins with th=
ose used by the MDIO controller), he had to change the PHY management funct=
ions for that indirect access to be used when SFP is selected.

Ronnie


