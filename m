Return-Path: <netdev+bounces-145130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAA39CD53B
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 03:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7311F21F70
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 02:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD93136338;
	Fri, 15 Nov 2024 02:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JQJvYJqj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97BA3CF58;
	Fri, 15 Nov 2024 02:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731636016; cv=fail; b=nTIzmzpn/RgLCec2E3QUAGuuQH1YX1bPp9p3bxfUOinQ1C28uSb+ofYYRtVrZHs4Ty6QMF85U6D/cCJYr6UR318q0nuJdyyN6mvMqIlYJ+hJOIddktOmN7KT4wSJCwtDsiqe7lfiU8N+0Py8SBUMTK0HJ6eJlxHaqv3Jq7V112s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731636016; c=relaxed/simple;
	bh=qcAShuVOMD7oWfVk3mMSSakMXQRwfA50hMlKuG4f6N4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KjEGuG3oyswsL+JaQ2liOnQEar88GZU8F3EFgerlVmH6ddOIvYs3sMyysguc3kvu3l3ile0kPnOjh8k1WWYW89J8IRsfhFNHLuDvxlmfGZN3gGnbWryllCF3vFXpyFbu9glRJN05HCIOM0oWXEcLkLIW+rab7z2NPB9BAuexBeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JQJvYJqj; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WkSJP85x82DQCjko8SCCxxsmdWCzkf5blN5ot1BWIg0k0tKJw6ZWwPn0lieJ3n497YQ77SjzQK8mpaqltLiPNDMO74FnMrxW6P7nuPkPSIDCgA/raGFxs+i5yxSmpASzD00jUvXTnhI6ezhtaAD7iJfmCUa6wfEttYVGdtpR9mcsL+LP8HftWLMUtlbBVku3cVs+TxWRJU9dITtGdTcYt30EISXgv4ElExLDRTFfRG31wuhXI3SFbE0d+9mNgjg7ZGp0z2b1ceJmn02PFW10NRpbAxorPbGztkNeFjl5t5vToSrfmaipr9nLn4NjZOn7A+3FR67D2IaylvfxY84w+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8d8gvk0sa1cq72RlXmYo0hfB46UD85Ijk9jNvgFFd8=;
 b=cNbzDUIxCjfXna4wGe0GssJKkzzK0WSdVBl9ulY8Et6uzXHHcVS7X9K8i0yLFdmaWOhu+pESysAPthX/svfyE8nJma6VqWJ/k9TVUBAk+bmpEo4FlMcaQJ9Sco6gLhmh7Jl1trqWyIVjr4+ahqdVguMrYpvD/NCyCw6gKPyr38sk5CmKbnHmdTuVUoGlop7vhuzivSzWuX9ETk/LKeXRUBJILjgTbchl1nq6DqR1VSJolR2KOTx7qtxuqYDgkZ9vkEjO6yonVeDhjDuWWofYkuEprEKLtdt2nXqHLXg+16bvzIfwR+rv0MkzXdgDon7SK+mu9ztsQVb7M0tfBBuxvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8d8gvk0sa1cq72RlXmYo0hfB46UD85Ijk9jNvgFFd8=;
 b=JQJvYJqjLfXmJDwdAvBhIR+BjWJTVcE8hr8+xcO5guTXkQEl0R8LvQjriwJB7Sbj3NrwCke4Kau8BjVx0XCus3MZK4NZDb7+kK/tl42FqAfFdCB16lUtErDMfj0+zGphm+k8QZsajhONGfBlb73CJ7+4mz2hf6HxBu8xNOx1PVTmZpJkulcvvm9cnZtH2KLt7Dc1kEHs1PQD4ETFNk+wli/CxqrtNtVQBg06mcgoegbayaeC1xgEHTcRZCau1ShRMqS0bVohpYujjOLpXfHGWcCY5SHmGbB2WkdgAT0Ibx/QNI8wO7kAlqldT40xnmWZvOlNxy935Qq4Tx121zpBMg==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 SA2PR11MB4954.namprd11.prod.outlook.com (2603:10b6:806:11b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 02:00:12 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%6]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 02:00:11 +0000
From: <Tristram.Ha@microchip.com>
To: <andrew@lunn.ch>
CC: <Woojung.Huh@microchip.com>, <olteanv@gmail.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<marex@denx.de>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 2/2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Thread-Topic: [PATCH net-next 2/2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Thread-Index:
 AQHbMkqiYUyxAMrEtEGHh8l2mClPuLKvD0EAgAPmaUCAALlcAIAAy2zQgAGOUACAAZUvQA==
Date: Fri, 15 Nov 2024 02:00:11 +0000
Message-ID:
 <DM3PR11MB87366C1AC27378BA32D9CD9FEC242@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20241109015633.82638-1-Tristram.Ha@microchip.com>
 <20241109015633.82638-3-Tristram.Ha@microchip.com>
 <784a33e2-c877-4d0e-b3a5-7fe1a04c9217@lunn.ch>
 <DM3PR11MB87360F9E39097E535416838EEC592@DM3PR11MB8736.namprd11.prod.outlook.com>
 <700c326c-d154-4d21-b9d4-d8abf8f2bf33@lunn.ch>
 <DM3PR11MB873696176581059CF682F253EC5A2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <1fcb11da-e660-497b-a098-c00f94c737f5@lunn.ch>
In-Reply-To: <1fcb11da-e660-497b-a098-c00f94c737f5@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|SA2PR11MB4954:EE_
x-ms-office365-filtering-correlation-id: e3a908b9-8e60-4b9b-e461-08dd05193d6b
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GyAod/mxFQ577Y+qHTZGjlB32I2fvUIbOvnO8JTTrrZwF9xssvp50s6gMvuj?=
 =?us-ascii?Q?JCngg2zbjrcewvxD558MS85oNs+K3ZIhHwt5Yx5cPWIPsd8MVQwRaBn3/TwQ?=
 =?us-ascii?Q?W3XUzH6P9Ygw/caDOCIKRGChWp+RxqAqTqeJnl/axEkkbrV1v2rpa0S4IU6J?=
 =?us-ascii?Q?wrP6/Tub8deiIenord9nH+b3y93IgrQMLn60IzsUPCeYXaM20ztT3TzUmd7e?=
 =?us-ascii?Q?1PUUkGDHqQ/PXow61fIQrVHs/8IjUAeTqTy7tGxgQDhtEVhOOVpfTvpT1lJe?=
 =?us-ascii?Q?C8nu3MH7ef7AbPqKRswqPJULpvMGQW3TbEC2kbk2YdMAUbnm3n9yrzGx19mL?=
 =?us-ascii?Q?vlfHdUf3VqPk6j+sbhhejHrgurSwV0zmgMtC0jVzfdO+GarN3mP2Rsg/7cgD?=
 =?us-ascii?Q?ShsquhLSOpXf1rq2jg9n0YjjLSoN0ZaAL7BFsG01rIUs+XeIpKBKb0Gh730v?=
 =?us-ascii?Q?cdxpWuBqthL7APBexDLAuXi/6A9hwlr5cXoh/76la836NuBuqLW8MtgG52Qf?=
 =?us-ascii?Q?IvueJih0euh2HHU6fpRBLC1OrE4hcRtrtsNj1m3jtn5bdYkRRNQSnPIXVBOC?=
 =?us-ascii?Q?OvCydgNSkdQUpdjhy/KEJ4o2lsF5VrvsMRLL6MnC+r/bjmygI+O1rBcSrCWj?=
 =?us-ascii?Q?DkBUWVJU2+0Xcs6+dYXYMaLKRnqc80zKRrG6VWgCVNV325K4Uh6I2zssa/8f?=
 =?us-ascii?Q?pZq2hjWdRidGltq8e5vh1VlPRIA3nTbNEzKyAMHR1pUA/Ml5ChHgWj2kYAdn?=
 =?us-ascii?Q?nOFeLMIslK7BShOxTljWkdWiYlGu0OwB99DMB3+BEzdBmptLiFkN9Nr24EiP?=
 =?us-ascii?Q?aSBK9zZ/nZ3zVYrEtTO2oabfnxi5N+dQnKpfmJUfyoo8Ap4TXYHKfb1fM6Ka?=
 =?us-ascii?Q?1F2OBMlO3sqahx76qV26IUylE17ylr9utl3gxSef18Ec7WGQSD41s1VC6L0c?=
 =?us-ascii?Q?btgW4wKKmlPpFuI1gV912Eo6n/0JceaYnpsCKnmW8Q/hBenB5BVorZ0d67to?=
 =?us-ascii?Q?zd1UwndxWYW0FnjTDHcFClDfxj+2Mswd9ktYaBm5y8Yh4YlL2Km4PVJNA7Iz?=
 =?us-ascii?Q?cfj33MZ2ftY0XqkZE/AysqHwBU1SslSY6fZZ+nHfcWzENn3wSF7S7tazCAo0?=
 =?us-ascii?Q?CxVndi2aLDUjW6cINdhq8P/1l0iX0nSl87hv6WTi/VFELu7zCFrhwJf+4nRF?=
 =?us-ascii?Q?bbXRIKanJPH1G+AiXma2cms6iH2L02DcZ5JW3Wh82cbA10XAnmJzY5nwaRMd?=
 =?us-ascii?Q?7bmJ8FPzSl15fRroiX7x5zcaoh9XALeIa7PJhgD9h6oHWWtbj8RhlHZnIAbv?=
 =?us-ascii?Q?1IeWL2y1VTyY/XNyQkN5D6+Q1OhFFCJgn/MP8dnzaV4XO+g1uTxqiUWRvDHG?=
 =?us-ascii?Q?WitH0jU=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kgpVAZBM7Vi4ur+SrPI64q6I7lVAXw5VSkxWl1JZusvJ8Y/y/JYHuu1Vsi9p?=
 =?us-ascii?Q?xxPa1hRpxc5q08gAPbKXxcKBzSk9K6Bn600v8x3zPJjolZiuoh5QtDj9zqtI?=
 =?us-ascii?Q?s/fsG0a49rWzAmzqH7/IdYMSWARTkjA+XLz/Z7yS4I/extcbkGbf4SXXmM4r?=
 =?us-ascii?Q?v9/rv4XqVoKRrc9e5IwPX0Ti8va+MqE8q0YX/EP1Cy+imwbEXSvwZdIpeckE?=
 =?us-ascii?Q?BLvZVENAxfdx4eyqIuMYY4Irz1qWTVAGzrqfrY/Hj4aj7Qq+xiVNlNYL/bGd?=
 =?us-ascii?Q?DFtFVgU0SsvmSXlsVRCukfKgNoGocqppIPeiuJLimZ3jM0w5sBkqr/kzHso9?=
 =?us-ascii?Q?u4FQ2TWiupUxMU4v+Qe9ex+YZ5D70H3XgaPOG1tIn/TTpJdEKIYcNYN3+G7G?=
 =?us-ascii?Q?G3l9/CKSEz88TKWuFGqq9z9O9OK6SoizYgQwFQzWwC9X3G4KE7s+l3FZ+DUc?=
 =?us-ascii?Q?UkbeQ2i5VUW/0Wzpw40SR3q6lc88cT+FFdnPbdPcZmY4V3hSD9wHFjdvhgtU?=
 =?us-ascii?Q?SHm0vNBIj6/B1sg85t05LIVto7cxFmw1v7JxI6F6cFXb1N+41YNEl6C0Gsgv?=
 =?us-ascii?Q?mq/vi2Kkb7lfUdfbLjX7NcFKqeYl5CUk6Ul/j7OSaFSzbMi8TJ9znNivrfiN?=
 =?us-ascii?Q?HlZTffvfJ7SFEgUnx/YFm6xI/Bpp4Vin8LLT+lyd+qSEGhGTR9/4XXYG88s5?=
 =?us-ascii?Q?p3Gkx5syy4v6bXxTAuord4kCiX+1lvDcfsFu/6+5g4FHuYhPTMZjrdNanhm3?=
 =?us-ascii?Q?0S7OONB5WtU/wRiw86N40apC8F1d2ZyuAJvug26Wqc5xiaC5+aao0OJoNd5l?=
 =?us-ascii?Q?3bmMMj5u5vzSHEZQk6ieXee7DNpj4mYkU+R4rQWl2XNXe8+FPusuAKIB2nCD?=
 =?us-ascii?Q?gqCTTTEw1Gms2m2A4gAx/pqYxGdAhIhJC1KjII2VEbTHWYptnrxzS7Y6XNl3?=
 =?us-ascii?Q?qAdRgUgjmi+OnRtdA58Hrsmd1eLOM8tbGY6t+qdKea10SnR83OfOoJ/qgWY7?=
 =?us-ascii?Q?mXnV4mZ/6FaOLFoGya0iUu4FEECv98oU4uishqlvXRVPmfLBhrc8dIDxbfua?=
 =?us-ascii?Q?uOdqZ2kpZ3O7WCWBQnH8S740gMlhm5O463t7pMNucJ4DoNrGY2Y2Vkh21JBD?=
 =?us-ascii?Q?gdoOsZxK8OyTq++8pYFvru114JC0wMoMsOaU3+MIVv5gumzYACj8Za2twEow?=
 =?us-ascii?Q?oyize0Vt1MPsyLWj8V6V4om3rcOT246ptY1hON7vrMsxJzhpZel0ooUttG3d?=
 =?us-ascii?Q?MClb1n+Xi7GBJV+8qjFPGZYngV+QXL/Ylf4SoFk/DwhqYm1MlhjSm9DdbK4z?=
 =?us-ascii?Q?EhOz1ptD91ndnvfB3Wnb6w0YiPJsapyT0QGfeWBTzdtbHO+DpRt/AgspyZCQ?=
 =?us-ascii?Q?Y0v4ao5IE2slIAab5TBRTAf7hIewHiKruDfqTt64AhVyjsTXX46fIQajAlnJ?=
 =?us-ascii?Q?Z2zc3M6a9nTZAVetodSeGqek68FdbtyuWEN80n4T1A6vGwYxdQMRacXI6mYI?=
 =?us-ascii?Q?Ukgg5e+EZJg0nwptfLQitKA8yTg/cj5f63OZLfgQhF3RPydacJtQGvmHum2V?=
 =?us-ascii?Q?vu1KEaB/O0pFPLo4SxXcmdmD+mxsCgutchiAv97W?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a908b9-8e60-4b9b-e461-08dd05193d6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 02:00:11.9090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6bfZhPHLmWW00h+zlPhlybWRD8v+ko1K4n7Rm4GS3Q7bjszWUq7jX1ynE54VJfVwvJOFB+GQW1igGkN7+Bvft5A2JxIthxDjF/hWR3DgouM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4954

> > When the SFP EEPROM says it does not support 1000Base-T then the SFP bu=
s
> > code does not consider the SFP has a PHY and skips creating a MDIO bus
> > for it and phylink_sfp_config_optical() is called to create the phylink=
.
>=20
> There are many SFPs out there with broken EEPROM contents. Do the SFPs
> you have say they are not 1000Base-T but actually are? If so, they are
> broken, and need a quirk adding.
>=20
> Russell King keeps a database of SFP EEPROM contents. Send him the
> output of `ethtool -m eth42 raw on hex on`
>=20
> > Now back to the discussion of the different modes used by the SGMII
> > module.  I think a better term like SerDes can be used to help
> > understanding the operation, although I still cannot narrow down the
> > precise definitions from looking at the internet.  SGMII mode is
> > said to support 10/100/1000Mbit.  This is the default setting, so
> > plugging such SFP allows the port to communicate without any register
> > programming.  The other mode is SerDes, which is fixed at 1000Mbit.  Th=
is
> > is typically used by SFP using fiber optics.  This requires changing a
> > register to make the port works.  It seems those 1000Base-T SFPs all ru=
n
> > in SerDes mode, at least from all SFPs I tried.
>=20
> There is a comment in the code:
>=20
> /* Probe a SFP for a PHY device if the module supports copper - the PHY
>  * normally sits at I2C bus address 0x56, and may either be a clause 22
>  * or clause 45 PHY.
>  *
>  * Clause 22 copper SFP modules normally operate in Cisco SGMII mode with
>  * negotiation enabled, but some may be in 1000base-X - which is for the
>  * PHY driver to determine.
>=20
> So the default is SGMII for copper SFPs, but there are a few oddballs
> using 1000BaseX. The Marvell PHY driver should figure this out, and
> the phylink will tell you want mode to use.

Adding Marvell PHY driver fixes the main issue I raised.  But the PHY
support still shows only SGMII interface inside the PHY driver, and the
ethtool module-info command shows 1000BASE-T.  The only good brand-name
SFPs I have are all 10/100/1000 type.  I am going to get other brands to
see if they get better or always use SerDes mode.

That leaves the one situation where the SGMII port is connected directly
to a MAC or each other.  A customer once tried to do that and the SGMII
register write was changed to support that, but I do not know if that
project became a real product.  Microchip does have a board connecting
the SGMII ports of two chips together, but that does not run Linux, and
there is no special configuration to make the ports work.

As there is no SFP or PHY to tell phylink which interface to use I think
the only solution is to declare fixed-link or some other phy modes in the
device tree?

I currently use fixed-link to handle this situation.  There is another
new issue though.

The SGMII port in another chip can use 2.5G.  The driver uses fixed PHY
to get the MAC running.  But the fixed PHY driver can only support speed
up to 1000.  There is no issue to adding higher speeds to that driver, but
I think that is not advised?


