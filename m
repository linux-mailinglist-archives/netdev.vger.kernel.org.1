Return-Path: <netdev+bounces-149236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6199E4D7B
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 07:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BBFC167D46
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 06:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9248518D620;
	Thu,  5 Dec 2024 06:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jVDG1UFj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917FF23919B;
	Thu,  5 Dec 2024 06:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733378678; cv=fail; b=MsfoM6nGot2gNCzxRhqD8aIXFlZN6ltd668cAV3Ne5SkI/lPRLydwINNltCTTyc3ufyIA/hGIpNJ+x21IP2e4NMw/aoKwNpdPF0CdAHbqD1AZ0fW/irQWfPYbWSw4ZluUP7YjZucz5kquEk4ivqO8oJrGXXPnqhk9WQC1pLqS8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733378678; c=relaxed/simple;
	bh=lXdgujzz7WS1vPZS1s0kPSkZQIKMKTQmRtO+0NFPcVQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sa5vteAJ4vDxkmttgxYC3gkT8qa5fruTcl8VBcP42rwEKyYcL82nw7dZ/fZw+hdWmjff2DWURGJcR5OZRrR8MTOThPEjnsj6Sm16CVfuaoNh9h5hvxcR7Vomu8WTH2CLpubJmi/rW219Qle6MFTaLnljXq9doA76kQbqTiaw49k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jVDG1UFj; arc=fail smtp.client-ip=40.107.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yH25fM0vY+a/3OOenyLJIcfOXHMrfe3Ae4TxHNbuLg4eabELTcdZEYXW/njcvz0Ic0+KcNKqVfm71RuniXfqxGH3QqIHDUW6dwKfo6zHS6LB2jR4gizeECFNcAtDaluwZBUnEUckKMNybKoQmY+UihUH8745pZWbCpdYv0o63odJcBzzTr3nTYE2MqmRkCZmo+2gWt1ubXWWCaUqyiFiFkqKiqVEKiJSH1Awxx+9nifDP7+85mreVr99ixSNVL0gxTm9wkxUiRG5e5lV59W7BzJ5/XMhBXOt+kLQixt/igoDHsbK14/53YMyK1fZzv65cAVF0Ge8gClpsPEeqomQUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXq9e38E5JrPBiKhP1dQrH/JUiwSAWAXmMK7+sjMzHw=;
 b=K8RFYyPzxAl16kIJzejItH7aQMVhi4xRWXzZLQTv42f1kyIy+YSN5F0yVa7EDz8c46NhJ2BSpK5t6t7gTgqXru/33lKx2Op6CjCskTv6ghmqaurxBJVg26wb7YmjCmsAU/Kv1zRzH9rgUhRCZ9x6JrasFGe5z50Tj8kxa9fZzLsdP0idB73vOaH/lcRXub5s4YcxqG2Gt4xbAgNEVPB8iq7fmYQqfdy+UDSwqExQvPtFzumAzZaIlGfq6O0CEGobkvlsdvO2vAwY4yKlg6orRVWn948PmiAuNU/3pI6kOAYh2vKrP3SmacPDxEnutv1kEQC6l5lFD+fq+MNEscRhDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXq9e38E5JrPBiKhP1dQrH/JUiwSAWAXmMK7+sjMzHw=;
 b=jVDG1UFj1UeUO8jh+suzAMvAs199/2ts1d0FOQJoEh/hYDx2ku6qKe2e6knoEFuihc2RBiMudsk9d4y1rWkkeccRRNRPBcpv/py3qB4TLzIuFT+dCbi/molwc3VM2KfUT5MZ9TS//VdxgttYUsBEme1CnuHkSnvCcyBpEM27f/52oCETylDny1vIPJRucp1vqGjR5CCFDDwjpXFSyUP8zds6v/cbJOHq26Ges/t164/lXFbe2m3FEUq0juNIgkeiftq9psFUBTHqycTz15rTEh8TQb0yIxnv7jSSW4bgmF/GJcYPmBm31vVV2YqO4DnWo3lpnGi0jeiTOgPs4Q8cFg==
Received: from CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9)
 by CH3PR11MB8186.namprd11.prod.outlook.com (2603:10b6:610:15a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 06:04:30 +0000
Received: from CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708]) by CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708%4]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 06:04:29 +0000
From: <Divya.Koppera@microchip.com>
To: <andrew@lunn.ch>
CC: <Arun.Ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<richardcochran@gmail.com>, <vadim.fedorenko@linux.dev>
Subject: RE: [PATCH net-next v5 3/5] net: phy: Kconfig: Add ptp library
 support and 1588 optional flag in Microchip phys
Thread-Topic: [PATCH net-next v5 3/5] net: phy: Kconfig: Add ptp library
 support and 1588 optional flag in Microchip phys
Thread-Index: AQHbRWDdzNo+Cnt01kOqIfdpKniGbLLVUBQAgADphTCAAAeQAIAA4dWw
Date: Thu, 5 Dec 2024 06:04:29 +0000
Message-ID:
 <CO1PR11MB4771EDCFF242B8D8E5A0A1E0E2302@CO1PR11MB4771.namprd11.prod.outlook.com>
References: <20241203085248.14575-1-divya.koppera@microchip.com>
 <20241203085248.14575-4-divya.koppera@microchip.com>
 <67b0c8ac-5079-478c-9495-d255f063a828@lunn.ch>
 <CO1PR11MB47710AF4F801CB2EF586D453E2372@CO1PR11MB4771.namprd11.prod.outlook.com>
 <ee883c7a-f8af-4de6-b7d3-90e883af7dec@lunn.ch>
In-Reply-To: <ee883c7a-f8af-4de6-b7d3-90e883af7dec@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4771:EE_|CH3PR11MB8186:EE_
x-ms-office365-filtering-correlation-id: 5f075e63-9e15-4da3-cbcf-08dd14f2ae40
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?49XKsyuw+cZkx+5B1jO2WbfC9Ed87z3gxg01/COQvxBb8+S+J4FbuFmHGgsu?=
 =?us-ascii?Q?Mkb6P9wHXMN6/i+ttKXKUxT1gDvUo3B/x+1zLVZuFrBbxSgduyAzJVw18LE5?=
 =?us-ascii?Q?XdZU+MnL8tEcfgGuc+9VWBs/9PyKjkccRBqOymyYL98OW4UcF1s8ZzlmNgG+?=
 =?us-ascii?Q?IWRE+nO9ueFPnW9ZuAUvcAFXc2fodFxKqqb8EAfNj+isF+kNVtZqj/Ith/nf?=
 =?us-ascii?Q?KMXN5CVFam5EzSNDuHfLfZJhbB6x03GAv+fP2NUpbOaI+hgf3x7Rf5hYtR3k?=
 =?us-ascii?Q?0XITRFNhCRaO7EBULXVE20ONHacBq1kl1ccStXyZWunnEDRBwJatm7p0QQML?=
 =?us-ascii?Q?8y/Ofv+AJVlT4PCbruMWCAUaT461FousW+XLTcLEbc3EdIvPizk2puLIfOym?=
 =?us-ascii?Q?grGEySMQ5T9G1L/cIMpJGofqsU3kGD5Q2In04cAvg7fVWiLkoe4q9i0EUWsu?=
 =?us-ascii?Q?u++bl9dwanBu7FEgz2vWS/70TXEmgvE4PlrDKS/gUiEjcGi5SXDI/YYHejqs?=
 =?us-ascii?Q?xFr5oZ76CJ5bCzja4LBrCzBBPaHmMrssNL8LtAzjQUsbdo26+EXXLaQTY51U?=
 =?us-ascii?Q?Ksp/pysNTKHNfPySu9mBcv3nAG3eEg2F2MKyuNJ978+ryQW6Cjiw3yMOwPRz?=
 =?us-ascii?Q?ia8thNnefkjOk/HICwhZYNbeYimxnHyeCyqws9hyLFzetypfpL3p45xqAZFP?=
 =?us-ascii?Q?Bj5wYLiX86Smzw8GeZsfGRBS2O8Iw1Abkww+JF7eEJPtgskDDUofghZzS5lI?=
 =?us-ascii?Q?fRF23XFJKQ8uomAjgcntE2PKC6snSTKpfwm722CAoE1SkbAvbgv/3OenKEBC?=
 =?us-ascii?Q?i5j8uzXWScVIngU3GyUr7FCbnnY8Gqhu/TfH5RDp7minQgXJwIT55GWosae9?=
 =?us-ascii?Q?Z+XmyIvUP7trJ+rqDBcxmpEDV61Q3X9aN3Culr0RGeNh1G7N8M9aTwiTbw/S?=
 =?us-ascii?Q?X+exY608HBM/CT9Q4ina4VCvjJ5HMRHBZn5SJk91Grk2oLRabpndxwoOdfWN?=
 =?us-ascii?Q?HGL3Qv71+V1e2BI2g7PCR6KKLcPhRctzlUPZqDvFx1DCY4hX6xPtK5FdZLa3?=
 =?us-ascii?Q?uLXj0rlW6f7+tfvLCm4qWIEO3sMIdJ4sWv18iFsaJY6L1e8UANMPfB+l3+0G?=
 =?us-ascii?Q?iFGNe2riho9rPJYCw9v7HbKiutFmb2dIZrSdl+mjSYzPc+ViBznBtR9llx/+?=
 =?us-ascii?Q?a6OHIECZQm+3d25/NgHxdmDZtKL7CWTy9QS7TS5kvd1jtqkwm6tzPnYMt6Lx?=
 =?us-ascii?Q?hRCfxRs54/kq9nTISOyQK+61D0fyqdwZ9UkF/m7L7E55J+Qij6877iEFthNw?=
 =?us-ascii?Q?u+4yIqXR15JduYiPOEG7rDRt1SsawkXgg0GHM42TUoEp4dh5fgDTU5B1MNIP?=
 =?us-ascii?Q?Bqhd4k1uCfW5CJom/1sON7Sl4H0x2h0+bUgpgZYmb6ALdUmlHQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3ubq+NhPKfbjmdFT2WW6aZolgLM8I3H4wirSRmnOIh1L9vLQ30v6bYjUXhp+?=
 =?us-ascii?Q?5ctZRWHcEpzoXSFe/AW5lPQGO8semQgUiQ3eMLe7N/kNK0mpwQg6NYAjIRTU?=
 =?us-ascii?Q?fIoRStMu7wLPl2MuELxdMHBVKXv4Kq2uSHHobOV/KvEdNo03vzdBjnZJX7qP?=
 =?us-ascii?Q?YOvNq8rfb0pqW+tJwguN2kK7W7iqgXBs7fDGiGAGHZOpUT5gyb/CB1224rSc?=
 =?us-ascii?Q?ytB02RSSpAktB3AygWWq77smzSw+tOw9RfX7SV7MjVkn3toxYGEZJpLFhD0g?=
 =?us-ascii?Q?561Wn7JEznCUr8Ruzr8QDIV8qfNx1z0G5Be3qszBFXdL3OHoFICzvbkD5H1X?=
 =?us-ascii?Q?GdOh62GOD+aOALQ1Kn/cOYU2pzNuP19hyym6wy5ir6c2yeWChu5fY+JpbqOs?=
 =?us-ascii?Q?ng4mhH5WnPJwEv1+bwAa1rGb6bbiuAjJjME2g207n4W3/tBbwbPWrArv3zoJ?=
 =?us-ascii?Q?TFc7MnF50HUtpFRie5FSn3NSPoQSRh2UK7gobGTlnBkxaFTsMt3J3CCfuFLR?=
 =?us-ascii?Q?lPIyMjluQRnFp+RpY91HwzyF4WZC5bar8L2L7r4dQyhFXoCoeGhAj8W0MZ4R?=
 =?us-ascii?Q?c5+oRf6NjT7TZa3Y4UHAyjQZnKOmyW7l0KpQ1aUCxLyfXfjSSuIF+dpcX8gQ?=
 =?us-ascii?Q?qLmhB3cnM5MZPPLI2GVvfOHnUBTKPAsTfmPFQs6zX4mq7UK/6LrilH/ARBsn?=
 =?us-ascii?Q?3pwLiJ1hyClewicdCT9aZ19L0Z1ZsIlUjFN022ksHCHl288jcDwaHiVeo/tI?=
 =?us-ascii?Q?OcJ+nSY9Kt9McZW9QLNhT+E0OB7SeIbE2ChaPuk2WPzW9U2MvSVa89MKlZnh?=
 =?us-ascii?Q?WCdZwOSWcoxeewClWcvYBdNIr7uC1PcjVkyQNMYzemekpT0hPOaY56oKFBtA?=
 =?us-ascii?Q?L/uLG2z8cccANqovhiIs4wOg0DQ591fb1PzjivY8Oeg/lXdWSCUa81A5UVZj?=
 =?us-ascii?Q?8GYVQtroF0ms6npAW0iMylOzavEZyB/V4YQMr4yEeo0P1+AlmXq00SanueLl?=
 =?us-ascii?Q?7js85a863W8m0tXWXyv4sovVA4jfp6ppqeWkW2z4F111ispLXiMl6HIOsfB2?=
 =?us-ascii?Q?5o6s02xgSqZduKT1+vbu6q91os8Sdphx2rrObA2bmbPlQX0LuYbufZ9XowR1?=
 =?us-ascii?Q?RuqeewVQvH9ogM7i0WmrbVaoQEV52VoAWk2OmGNKWn0rMknixW25M2U2CsAv?=
 =?us-ascii?Q?NK024z3W5r1gzReP/w7h4ty5LQJeeKlBiVJGmcapJ+098v6fyLe/gtessSGq?=
 =?us-ascii?Q?USq61Z39RblOcgBfqdLK8Tg4dMRSebOflhWhxOA9vXhWRa9yHpRS9fhdOTdA?=
 =?us-ascii?Q?FUoZf8BztSMO+GsNL20g7lLCh7pHLJ2zNHHw1zM4nKx6ytO+nMD2CGh8Jt1x?=
 =?us-ascii?Q?1WamFF8l9Pgo9Jdu6ztz2arSD36Wyj13F35NRc52sKya0jBgjBdvPSp91VLL?=
 =?us-ascii?Q?HCC3tECoX7F+70JpcJf0JT8j7hDXoWgfFC0kWjh546BFB6RbVuyFeiHXc1qR?=
 =?us-ascii?Q?qFUsD4y1qjk8F+n4jJ5uDaf4gwClN3Z2YH1E7J4K/9Aqtt/GtlhwaxVW0E6e?=
 =?us-ascii?Q?JwEn8Ks4aVLFNs/GTteLWq4L0ng3mI4sbtG3JWTZpIEJAK/DSutfAlDto8DG?=
 =?us-ascii?Q?ag=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f075e63-9e15-4da3-cbcf-08dd14f2ae40
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 06:04:29.4070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t3xhfFwhbVDhZ3Cjbhfrjx2HaQjuXnO3g2z9vAg5+Gw0c3ABSlQ+AvOQQ16a61JDF18c4Ynjjo/8H/PsuR+1KH3ZiN/A9RScD1+q5hJxIqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8186

Hi Andrew,

Thanks for your comments.

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Wednesday, December 4, 2024 9:33 PM
> To: Divya Koppera - I30481 <Divya.Koppera@microchip.com>
> Cc: Arun Ramadoss - I17769 <Arun.Ramadoss@microchip.com>;
> UNGLinuxDriver <UNGLinuxDriver@microchip.com>; hkallweit1@gmail.com;
> linux@armlinux.org.uk; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; richardcochran@gmail.com;
> vadim.fedorenko@linux.dev
> Subject: Re: [PATCH net-next v5 3/5] net: phy: Kconfig: Add ptp library s=
upport
> and 1588 optional flag in Microchip phys
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> > > How many different PTP implementations does Microchip have?
> > >
> > > I see mscc_ptp.c, lan743x_ptp.c, lan966x_ptp.c and sparx5_ptp.c.
> > > Plus this one.
> > >
> >
> > These are MAC specific PTP. The library that we implemented is for PHYs=
.
>=20
> And the difference is? Marvell has one PTP implementation they use in the
> PHYs and MACs in Ethernet switches. The basic core is the same, with
> different wrappers around it.
>=20

MAC and PHY uses different PTP IPs. Also register space is different for di=
fferent PTP IP implementations.
This Microchip PTP Phy library may not be relevant for other implementation=
s.
As I mentioned earlier all future Microchip Phys will use the same IP hence=
 Microchip PTP library will be reused.

> > > Does Microchip keep reinventing the wheel? Or can this library be
> > > used in place of any of these?
> >
>=20
> > As there are no register similarities between these implementations,
> > we cannot use this library for the above mentioned MAC PTPs.
>=20
> >
> > >And how many more ptp implementations will  microchip have in the
> > >future? Maybe MICROCHIP_PHYPTP is too generic,  maybe you should
> > >leave space for the next PTP implementation?
>=20
> > Microchip plan is to use this PTP IP in future PHYs. Hence this phy
> > library will be reused in future PHYs.
>=20
> And future MACs?

Future MACs may use different PTP IP.

>=20
> And has Microchip finial decided not to keep reinventing the wheel, and t=
here
> will never be a new PHY implementation? I ask, because what would its
> KCONFIG symbol be?
>=20

For all future Microchip PHYs PTP IP will be same, hence the implementation=
 and kconfig symbol is under MICROCHIP_PHYPTP to keep it more generic.

>         Andrew

Thanks,
Divya

