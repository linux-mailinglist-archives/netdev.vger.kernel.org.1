Return-Path: <netdev+bounces-240044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AFBC6FA54
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E18B0349823
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 15:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3E33624C1;
	Wed, 19 Nov 2025 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fiIAaCvz"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010062.outbound.protection.outlook.com [52.101.84.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F8220DD75;
	Wed, 19 Nov 2025 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763565610; cv=fail; b=hlPWNn2C5GMxY0JjqeXvOPZ/HISWjROdd1o+4dVOM/rmJ6+YP1wI9S2C/k3StiL1Ksa3r3pBiLyla1k7EJv6QTILFbRIoLEyW1bNjKJDpIUxIwGau+HRQI5Y4hmTWE3U49I6hf0+qs6oA4g8ZRNvmFvhxNamqIfwc1QsgzJeY5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763565610; c=relaxed/simple;
	bh=wt3zJpyj/Y3W4zR06uPbwGT0+ryPg1rhrHhgANqaIik=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VIsJ+EKXLVaWJQncvAYuGlpVOwOAVHU4eoy2T4+IDpOmW3W/ShYN+CWykIKvm1DDnL23vAbdZaD+Rog6SdWimmnZxWsGigCeb9ALsrD+xSB4+h20FYrrUVW1vepWJzO42gZr5UQcNQ2LR1+TfSaNfEKnPE7IsnKZaTp0tgbuCr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fiIAaCvz; arc=fail smtp.client-ip=52.101.84.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9nDRHKUPzh9GawoFLocoCqdQth+eCQX6I5ExG8iNhvsPV3VTbrlusWhJ9Ju7XktkStfrzi32pm4UDUDcN7EeRxX3jff5m/AvDqLwvMoKsUR4qkim97hKJ4/fN4JYOoao+OdAphreWQt7zI4vazZMI8SZRRj5VUTNrSlIRV2O/KcU6CdBjng8lDzTqK4YNFGtDZsOyueF/yVRZeshHtT5PIiuQxVBL2e+HW0r6ZBs3wN/6lj/EfBkht4IDe+A9iUmF0WUae4AAhzpvQLJbUrh4w1UVEF4TEyyg44HBQpL9Fz/MTpX0z+sU7DaoBGTcEWxV57utMPsXdJLgsX8eRLRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wt3zJpyj/Y3W4zR06uPbwGT0+ryPg1rhrHhgANqaIik=;
 b=HoKPKyTpgTPxWc3ngCWe9gAAhO/y5B9gRL22RGDD5n3w+HswjRz8iN0xOXINWlKPW3pP9t91Be86EIktiekRIWHWB60WoyMalRqEpDyBcW4b6yYZDUSBnttNMKAKo3xguQN0g4J7jVjPxsjU17It/knhVFU73Rr6awQH0rYzPs9WoTZbPq68T6Zi11UvikdXNTKU5vxHEWjpu2WmTb8Decw4SAa1iQGCwdz8DTiGXN8caAEG4D+Ok84SdXYkT7OFwJu9JOGQf/wLZBevmBe3cGe89DSb7CBbwbMue2/+6No3Ikou6oG6xtvu56J1BC0NA+coJNAt5hcCVF87HMyGgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wt3zJpyj/Y3W4zR06uPbwGT0+ryPg1rhrHhgANqaIik=;
 b=fiIAaCvzINTOLCndZMv4kdLyk4s+PfBgfrq0IH6dkW+rs6I0H6Wq4Q1X8bi1jhgsi2IxA5Mbvjem06tyeQ7JkNe0rNpBT6U7s3Au7DipO0W490IwHENgseB5Imt6hfPiyNNnWIriQ3KlWf6r6f0xoi46zL5TlWUapEZ4VNs8xvelbRKVkBtWZZpAM650xxiQVPx+Zo9j3HPDfW3vFVD5aaMiykw7o4LMrqVSgmNfshRKEXlcHSoyMerBVSFIOU57d8mfMygvbQP5WjaxhmxzoIUm0SBXdPNAh7vX38ajrktCD0LynSdryEEH8nYBFfWmdR0g4WnECZq0XnaVKznTRw==
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 (2603:10a6:150:2cd::13) by GV4PR04MB11425.eurprd04.prod.outlook.com
 (2603:10a6:150:299::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Wed, 19 Nov
 2025 15:19:56 +0000
Received: from GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490]) by GV2PR04MB11740.eurprd04.prod.outlook.com
 ([fe80::ca5f:7e1c:a67a:a490%5]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 15:19:55 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: Aziz Sellami <aziz.sellami@nxp.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 net-next 3/3] net: enetc: update the base address of
 port MDIO registers for ENETC v4
Thread-Topic: [PATCH v3 net-next 3/3] net: enetc: update the base address of
 port MDIO registers for ENETC v4
Thread-Index: AQHcWUIfcG/AAR+5SUOvC7U/oxYhW7T6HKqg
Date: Wed, 19 Nov 2025 15:19:55 +0000
Message-ID:
 <GV2PR04MB117402140ABAB3F2428C8120B96D7A@GV2PR04MB11740.eurprd04.prod.outlook.com>
References: <20251119102557.1041881-1-wei.fang@nxp.com>
 <20251119102557.1041881-4-wei.fang@nxp.com>
In-Reply-To: <20251119102557.1041881-4-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11740:EE_|GV4PR04MB11425:EE_
x-ms-office365-filtering-correlation-id: b6cdae18-0211-4329-887d-08de277f1885
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RrdBqCEQR1Uiuguiezsg+nUF+wssjGfJItAKBGYJ4QakoJKSPzA4QYZKNlep?=
 =?us-ascii?Q?LgQ+9hI/FaOReiPOqC1vYaNtK3MtVmkav6yalTwP/pAcrvXkVuPnBy9iSeyX?=
 =?us-ascii?Q?MaJXdxD4f2R4FHKme1YcfnJXDB3Y4Odf3HtxJw/vtcXfNSjUj8P7Zty65++9?=
 =?us-ascii?Q?fPlVB1QKrCRP3cDclb5NiYudt77ijxYmAnM3ET9Y2fBQ3TK7laHQBmLYY1L1?=
 =?us-ascii?Q?l/0JrV8OPqvkg+HionvGdqIeWJcvWymZRSG2bc/wZ1WfyajbHy8wJa3wT80O?=
 =?us-ascii?Q?Mo9Uph5ht89Bf3liK3waw5d2chbEghKBUhrZUNocV+j6xoWz4j9O5txX4yO3?=
 =?us-ascii?Q?TnQDGxPKV7dHMlkQVwbdfdqAoF5lppjGLguSutD4Eb3zXxxROGHeonzIqUy8?=
 =?us-ascii?Q?DpzzTjdn7zVch4QLpakBFmxoYntFfvy0eOSV9mfe6Nb+72hh2ku6FSP+axjS?=
 =?us-ascii?Q?wxCRjSHqiAln9mG/y2jRo2kz72Kayj1pIrvtZizBcLu9MRZ7mNJQjH55GjCu?=
 =?us-ascii?Q?2MoZN7Bs7RgJ6SScC3JN3wE08KEtJhjixEy3FOIfG2tjhlqhYniE/TZ/HiMc?=
 =?us-ascii?Q?NXxX8K5Jx9PO+vqdxNi0HLOaz6F/3hoUFUPiTNdk6qvBfsO5iebjnLHR+JPT?=
 =?us-ascii?Q?AhaN9qCorNsRDx/EYwVZ6pi9zEiAvhwPhR/5c7arAVAAPZ/9tsF2iE5NgdjV?=
 =?us-ascii?Q?tTs+fxkj/YReAn5cC0iz2CJtEPvMwldJ8ol2Kqq/SanCiQA/+WyvdTsD5xiR?=
 =?us-ascii?Q?5HV113t3bZm2cO4jTZTghbBXIzeFRGyFO1A6/zLpE5hknISWGGpGU0S/Qju/?=
 =?us-ascii?Q?Cdj5FCc1NXtUDT35YmdZ/TXaSTw8nuHNu8XN5wiyUEBRLZjUhzCrjJIshuIE?=
 =?us-ascii?Q?1dve93/2kGPruZIb4QqNRrF+NxZEVAsqG2aTsObPz8hJUyi2cpOc2OqcxOuY?=
 =?us-ascii?Q?f8HRjlJlu3Zv9LZ2Pa7VU0xF7OdYlVis8G3ROlsf3L+mpF4YlKmPTSyMmxOt?=
 =?us-ascii?Q?zAqe+LAryDlZtytEuOmREIGyud7CdkQAsau8jqbRgMa8swpJHl7Z1UWvj6tp?=
 =?us-ascii?Q?bOgUA1H3u1935IAZPhbm0lRKoQJqtg+85A3Rdw5I8vwsfcRGAz2n1TW76dKD?=
 =?us-ascii?Q?qVIFLAtGO24nLLs+8EdkI7kqNAghWdyB3sS6OO6d07te1h/snpLUCxdoNsGK?=
 =?us-ascii?Q?SLVdncRvXXOf7RC/iVUHYoMgYlY/IVTkAlxN+FOZaqZctwTifexh0Zl36PBr?=
 =?us-ascii?Q?ClEqJmigItBUmH3hGNkDUY3tWt9impVqeq8/Q8GPwxSaCT8qQ8dfmG4DPY56?=
 =?us-ascii?Q?tBJJFYPBDf/3Xach95K6HnaKCPzAcmohOk8uIGBFMSroV9TXpc+OszTBacii?=
 =?us-ascii?Q?MTviQQKa1+JUt+fxQk8L0iYm1357XtE1Vz7vuvYkBZ+7y1HnvSsNNO+xVo1g?=
 =?us-ascii?Q?yKEKpGKmL6orZA5svZpzzrBu9zZnZpZ2TjiXYoxDInsifQXUWELYAds8R81K?=
 =?us-ascii?Q?itpFYi9b3hiQMRcBGrnaqp/5XJyFYzi/+3oO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11740.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qtRLTW+mb169zBe7AQtXIfWbkC15VAv/+sz2FaSVbhfRLtD8CQIhfkeyRgfj?=
 =?us-ascii?Q?tCwKhTUAAkWEng4FjZDlPjKevf/JBmt6xXOlRYJZQafVppBlM3lCdZPPT/P2?=
 =?us-ascii?Q?FS3Dw1NLtqgi9weTu+cTsaTq5caxjADVrdvgFD3Gpy6iTGx6AFi0+MSH0VDk?=
 =?us-ascii?Q?OUsQogM4bML7WHNGjobbZPjG4T+WNPHQ2YD7xNdUtF7xm4lb1l+2gfW/rkUm?=
 =?us-ascii?Q?BPmx28hEge4ULHcCJ5KWApZcsZGrS2F4wOwkW1s7/6vg8rPJDjq9P8Y+G2Qt?=
 =?us-ascii?Q?WTGPa2/kFxKNsvF935lI99bFOEKaf8UJWh6LFqw7tJbmQ3qH2PNFJ9RSG8yF?=
 =?us-ascii?Q?e0JlGlqMUeOdAp2cYZiTiGLm6LU1INE/pQff7nW5WaST+xWDLdW+bskFLAf8?=
 =?us-ascii?Q?eIS7FGWVLjniM0cibaHsfUL4sf8edrVivcP7WdOHs+wb6o85dD6yAbeaGjQ5?=
 =?us-ascii?Q?uHWP3GGv7a1qFI5LE4wrIP2jKMhfXG2RqOHeQ8KkfGs2k18jMfNelgl/LOEy?=
 =?us-ascii?Q?+auxQh2LdXa0ZLEcl4hcYTpEJq+bnBOd8cT9lksRqvy25eHIpmsdvJHVjIEx?=
 =?us-ascii?Q?aiLLKhaMz5fV0vzdNWPLuSETCookfm8ecmqCC1RHudI1A90WsXvqhJ+uB78L?=
 =?us-ascii?Q?bAn8lUIm71W5ualHerPO8VZXsb5fy2jSyxpjVjbYIlnTgQ2do/Dv7RU2z10J?=
 =?us-ascii?Q?7t8Adx3PzZhRndgILR5mydYLL4Xrx68i3aAMvoT8cM9GN1OLyqbfi9vT23BA?=
 =?us-ascii?Q?7R91tD33+uoICiMT47Ck98i7a8PTZoOofhcWI4640fM80XVNaV1TcEa4nNws?=
 =?us-ascii?Q?5j6Xc14J0G8Cqtu5j047/FNPPyQP9+v8m5DFnxEk4wLE2LauOmV6laThFbI5?=
 =?us-ascii?Q?RHonpZyLHTiWWduy2FZ3eUaKmbNj7RFbrhoajNrvhSenwtNd2mLf4p/Xoyx4?=
 =?us-ascii?Q?6r+BL+x8Tu5zuRS079l/fBgInFfQnhq7nCtkNMdmMB52VKpTioz0d+uXoayP?=
 =?us-ascii?Q?qTktJQoDbgh7iBERl/kfE3ScWKk2LoE6u+Fnu0LIewRhT7mPZi5AkhQhHGpK?=
 =?us-ascii?Q?7q0FyPtEqwYyKeQa1gQNygaMj7WALHlB6rgDIqwyDzXzmJcOTZiricL2aCUB?=
 =?us-ascii?Q?B4WqzKW2XUnCwu79BUD3OT3YBuFjY3p6rWRhFMVWNWd6UNcmWjpGM+SIKet8?=
 =?us-ascii?Q?2iQHcNt1fGzrYm4DaT+TYv+a+IZ7lYgoGx8H6YsR4ui/ZvJrQynXuVnguv3S?=
 =?us-ascii?Q?nWvDWcp4vUqBusybhgEggm/WuWn73LrDVxs/segY8XXOZaV2RGOT7Fu/qAeo?=
 =?us-ascii?Q?/lF4VydGKhwDhJRAhrnFMmc0UdS//fYSePD+fv5ILqOv+Pw5Peb8TekYf7+g?=
 =?us-ascii?Q?SkrsOhhAexE6Fhl8nYImopfwfuyXGxAQeYzZI/vyXX/e/lRNNeOGW8O5wwDF?=
 =?us-ascii?Q?QLIM/8H+hvc9tgkm6pK6l7D2sKF0WsBvLEZYsoESpLlN3ckdXFQa+9GxqgUw?=
 =?us-ascii?Q?J8afk9DgDdu4/V8M/GNu1jQaL0oy+CrfJ3LsaZ/ZmPAlQhlMfDxcr+q183w2?=
 =?us-ascii?Q?UaObdF/Kn0Fp6pZbLeO1tu/WrYm+LCBsDximX64t?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11740.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6cdae18-0211-4329-887d-08de277f1885
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 15:19:55.8799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a0/IqxtLpfPJs+ija49pGpNbDWxgAofnqBo8pANP9lUViU97Y3IW6wJdt7btCOmOKgmmv9WJ+9orgaS6jHAaFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11425

> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Wednesday, November 19, 2025 12:26 PM
[...]
> Subject: [PATCH v3 net-next 3/3] net: enetc: update the base address of p=
ort
> MDIO registers for ENETC v4
>=20
> Each ENETC has a set of external MDIO registers to access its external
> PHY based on its port EMDIO bus, these registers are used for MDIO bus
> access, such as setting the PHY address, PHY register address and value,
> read or write operations, C22 or C45 format, etc. The base address of
> this set of registers has been modified in ENETC v4 and is different
> from that in ENETC v1. So the base address needs to be updated so that
> ENETC v4 can use port MDIO to manage its own external PHY.
>=20
> Additionally, if ENETC has the PCS layer, it also has a set of internal
> MDIO registers for managing its on-die PHY (PCS/Serdes). The base address
> of this set of registers is also different from that of ENETC v1, so the
> base address also needs to be updated so that ENETC v4 can support the
> management of on-die PHY through the internal MDIO bus.
>=20
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

