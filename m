Return-Path: <netdev+bounces-195081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B43ACDD7C
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 14:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F8E67A3BB6
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 12:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A87F28DB78;
	Wed,  4 Jun 2025 12:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jwIb6/Zo"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012011.outbound.protection.outlook.com [52.101.66.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2F61E3772;
	Wed,  4 Jun 2025 12:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749038911; cv=fail; b=eQ7NpMNJ6ikFzldXTkzy79UUTmWb++1rU7EsFVs/VP/pHz9i4H3DX+TY3QKuPKfCG4YnfnprcQ5LAPvm5J2nhr1VO7yw1ui8GBFPNhMOZs8vEKtqajYbgeKHd2VDhv6/8D8/u5u2bj1fvGyZMEWydy+GDaffUICqRZXftf4WZgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749038911; c=relaxed/simple;
	bh=i/iuxuOmaoPEJHULOocaHuC0pIzW55L3OGkFbU44+5Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nZqcA8/rzwQU4WOZ9HMxyLEHpc8Ddj9mC0wfEnDTQsOj/bu2Lie1NlXwJxBc6Y2UNnVGml6+OzSaq/axZmBdtZK9qmqltE/NG7MHTlBbtu6gZi05+kBOTtAShFJFoNFV2g3K0q3ZC0r2rvk0wpncvaVSiE+QjMaPzlfDDYeq+Fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jwIb6/Zo; arc=fail smtp.client-ip=52.101.66.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VesxxYSyN2i3d1KQ7gfMThLV07FzPMoAKQAoU5cfRCerqxARJp2l7hSsHAP67NaQqUewxzCbDjwH3noJh//JYmQWVnRCLeN9RkAmwiuuPJGz9Q5WAbXka8RKwUOAlml3bKkLGv1G2KTyh2/fy/mq7y7afQb6fdnOgIU8nfPf4/+VKRwpgEnMKN/gaVX55BOI916VRG/J4NrP5dw0MqQMeNBF0Iq2/Ql8yVXJhRgC7DXweI2SvtAGdCdIvwmtbAkNr8UT84n23PI8T7XP2gJVDhfldSlcqd0Ncci9LCkJdepUA3Usp8U+6tktW+N3fGCYQkGyE7PY1BzP+gJthpXNjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/iuxuOmaoPEJHULOocaHuC0pIzW55L3OGkFbU44+5Y=;
 b=eJlten50TYgfSqsStgH3dwkUhdaSS1vJ/YUuvnMMv71Dxz6w6Dv+Drh9hqgkmj5gzfhee87syAeNWixJRXAcZqpeFQ3cFkPmZO3Mh5g0OSegxawdAemGhSo5pVb7eyO2T4tHAiybDCpJ6yCf/W5vJrME71Rvc7tTn7UGfjCSjBeLm2lAWNvtxVJbovvID3QSDSgMH8BapG3DeVJYPHz+FYCT3Yeud4zYwtyVqC3XRlR5+RPOR42f0RAtgC3nVJYX1mos4D/sgyGBO35IKRaqbDsKaIIO7KtQw5MRodhl9TOk3HmbRlPXPyvKXuPrfn+aLN4iMyhYmCcK0BZqOptYMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/iuxuOmaoPEJHULOocaHuC0pIzW55L3OGkFbU44+5Y=;
 b=jwIb6/Zo4yhzmQ2yqAUT+fVy6GY5pt6tVgSHLoA1HzKjyYbjWlDZv/weOR0bft+jyVuwQ8bmyvRcfP3uL0aeuncMKCRyKBMi3B4u7KL43SHSenOOskiNGQp2kpwaAnn2SVMUD29jnUVSDV28iI/lQOyiJy9zXg2OFGpQBtE5wjBU+yUHSy1cT6TTU8Z4S+S2qw34rvN7/Os5LTwvkjp0a7tqFVdS3m7Zq+bNjF1zlvxkDxaiTSHp73y7jJpMbKdFEk0prI+PAcF/EfOvIFwaiMFP0RmFtMiIO3txRpjmVzpue0M5xZV4vsj9CB4DW23BPvDsnViXcKTEc2AFToN9qA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBAPR04MB7414.eurprd04.prod.outlook.com (2603:10a6:10:1a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 4 Jun
 2025 12:08:26 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8813.018; Wed, 4 Jun 2025
 12:08:26 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Russell King <linux@armlinux.org.uk>
CC: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>, Florian Fainelli
	<f.fainelli@gmail.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"xiaolei.wang@windriver.com" <xiaolei.wang@windriver.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v2 net] net: phy: clear phydev->devlink when the link is
 deleted
Thread-Topic: [PATCH v2 net] net: phy: clear phydev->devlink when the link is
 deleted
Thread-Index: AQHby8C/1AHS0HJUFE6a7bJae4mQobPgVKIAgBGjJoCAAG4doIAAUgsAgAA/5PA=
Date: Wed, 4 Jun 2025 12:08:26 +0000
Message-ID:
 <PAXPR04MB851003DFCAA705E17F7B7117886CA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250523083759.3741168-1-wei.fang@nxp.com>
 <8b947cec-f559-40b4-a0e0-7a506fd89341@gmail.com>
 <d696a426-40bb-4c1a-b42d-990fb690de5e@quicinc.com>
 <PAXPR04MB85107D8AB628CC9814C9B230886CA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <aD_-xLBCswtemwee@shell.armlinux.org.uk>
In-Reply-To: <aD_-xLBCswtemwee@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DBAPR04MB7414:EE_
x-ms-office365-filtering-correlation-id: 6f39651f-f820-41d3-cefd-08dda36082d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FWrHYXucZ+QQ9G41hLtOpRVPM2Tr8g8FO3YCZoWdIDxyJJsNKO5NGJIC1Q2C?=
 =?us-ascii?Q?HhLBXmhBiPJ22FnqzJUGXCmo9e0Iili+m5wg+IWsgnMI/fSRu086Qbe4zi27?=
 =?us-ascii?Q?x5f5BQ48dPo8tUN0Zcf4VDOMeKRXCLw3T53ivLShyhY3mdfOEujGqDablJuH?=
 =?us-ascii?Q?XI+Ai8Vl4rdzjNpTmKMk5pVbyh7Jj2QhcbqTDADot+O7xRi6NyPzSOKxKZNs?=
 =?us-ascii?Q?NicUyiCIQj0jJSwwtrV6/EoOWAQ9FUzCezdN2G9mm9RmBP7GMW84uHUH4VGK?=
 =?us-ascii?Q?kR9ff/qMSM2lkElITmxQtLUMm246gTshc1eUyzE8CdvrkQKJkhq9V0j0wlEY?=
 =?us-ascii?Q?zdnwE+LHb2QEy1QfL4nArKrLg8P57CkLWHUGdvNiHebJt7GGm/6t1W3LhdoI?=
 =?us-ascii?Q?LERaWoJVr93fkkXGQq0jpzB8Yq2Fc5OQVasv0ktKw1o+DrOVoWI5RTDMgd0k?=
 =?us-ascii?Q?kkfmfMmatWJ2o0+1BwsQtI9jKDomPduK8cd8R/yN2WfajBnK3cft7HeNvog6?=
 =?us-ascii?Q?lVFVkQlDFun7AxkOb1tgecbwKfGcCiVpLxAaj4qZGCI2StsiI8kRyhDkdkJn?=
 =?us-ascii?Q?7XnuLauzQQpGfwHQOZcywiTMYolUfloeW/P99dAay/GaEWFNkJGqqXqRuusK?=
 =?us-ascii?Q?JHzInabslRL5WlGCKrOw5pqKhzu0jTzcnKAJCpdVkN9nhaRpYDX+eD/NnBL2?=
 =?us-ascii?Q?spuKmCeq313ZFrgH9+3QtvUpNE5J+bLBADWRuvJDbD8UJ1qTLwAoTWy4Qh2+?=
 =?us-ascii?Q?577Ht+m1D2tEvIAZpkOUdBpMPy5vor6D/OlUR2nbzy8zpjRK7iJCa9+tg1G2?=
 =?us-ascii?Q?m94a/luQF2ZXDNAnWQya4lfVBGLuslhCQKgzH4FhMCoGYOdnvltKWpx6FnnZ?=
 =?us-ascii?Q?hk/jTp52PnoX2vP6BZT5jwl1zVi75MSQsz2jIPO38HjUvqm/okiCkp9Su6Dw?=
 =?us-ascii?Q?EWa9LUfEKVJtmAKpRdXaDwcJaXzh0jJoPx2pHvKa0nzYAQMqb4Gc3xYFoXT3?=
 =?us-ascii?Q?xujoGZTsOIzmq6UhiZeOcW79C9FZZ9BbeKZ4JPe9dg4sxt1f+QPybzwZisfL?=
 =?us-ascii?Q?Z6Ej/wf/W7/lUIwPRKV6Y7NEPsH1sxr3CHeI97T5EVfmilUfGf358c0tr+XA?=
 =?us-ascii?Q?7yCctaH5Oi1JFN5reX80+EJyWejgchZjZzqkNCNwKWRIe12Mn6mgEylZVr4W?=
 =?us-ascii?Q?XeDYRm+K6Hf0R3LHqhenh1gQAsWn5EdXIAMM9QQA5seNfznNimvXSbwVK32X?=
 =?us-ascii?Q?ll3FXwBQhWXsBlFNXCt5ragPqboinNnyiaMy6vX1G9xFI7QyqsoQMf2ROFuX?=
 =?us-ascii?Q?I/ru1ehNL3AII4PjgOnhR+7ek7peikKAgvPhpNyXrSkIMOsxqey1QZ6d668L?=
 =?us-ascii?Q?nqz11SykD30pZu5obpsv0Kurikzf++1CGxFMbhsPQYRVF9bmqIzN+9O/Cdg8?=
 =?us-ascii?Q?+uI1DZ+IbGM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4+b0swPnJSvij14Yad6Fz6cv2OR2bL438pgWXjuI6zEC4KPoT5WBdezkzg+W?=
 =?us-ascii?Q?B40Tas64Y1GkdZaHKndTC31dj0MwhPGBirBnOfJ6+GDO64T7rA5tu5pDMtT7?=
 =?us-ascii?Q?TaqNissGBF+IoQnEqXJFMSRBMasc/+HdUQCbOaLPqIGYWg8q7hu6eCmfTze3?=
 =?us-ascii?Q?n2M1oko4yszavjHDqlz4ykox2o+HFl21m3CIfyvS1CGvL3PLeWi/TJxbBPnm?=
 =?us-ascii?Q?VbbDQrYm+5CTA8oLRg5NMQQHcepJ1v0aRfIKdIiis5rFssiFzZ0CoVu3/QXc?=
 =?us-ascii?Q?ykHoiuoHNJWMow21awegY7KJsg9zPgHCu5re17xgrYpmE2i1DBoaPo/uW09S?=
 =?us-ascii?Q?AJfA9Tp7UrWypwUqSw+VJoOZxSXFNEWEIp8CzngfqOCw8fHqVvf6aUsV881I?=
 =?us-ascii?Q?Xcsr8cEngvaoP1nLI/clJWJFkcXf6z+zCwXafvQBeny5DCCkzqbKg09bjksP?=
 =?us-ascii?Q?ny7kiaSOjLAaYIYxXGVMlvnxgT0b8Ai7qkzq/n3fcD+4GuPin8FLfYZFFLyT?=
 =?us-ascii?Q?mp9rqKsW2us2PfN33nJ3K6hL/RuT1Mz6saeL0eHWfZYVFKS8uXOZg1XTrKbB?=
 =?us-ascii?Q?QdXkpx28HYTKSRIruYFAnmqTqas6jjZfkf8B9hhEpIggyIgUwO2UwJS3AAzr?=
 =?us-ascii?Q?0EUf4siiICa7/LiX5ITkldaOCC03kaSeed8+qfWVuaQqJdYzKLgxTZfkyTuu?=
 =?us-ascii?Q?NhzYxZMyRjXNEPuSvHaVATS8yLu4HZe62G6tKac98WdTPL6xBY6BajCLGzb7?=
 =?us-ascii?Q?FI9QWcaUrvTJ2oy6Wt03Dojd6KMDllb7q8FDSvIIBYFbT1d9qT69lgrJz4nx?=
 =?us-ascii?Q?gSEXHP1oPfmAoRZkHeW92/+0qs1qA/Jn/mLd1o6kswpMMCDW5rjYXmoHvmIp?=
 =?us-ascii?Q?JzXvHrb12/g50iz8BkSF5GN+GHnqQ0un/OvUGHnWpiImzTunY6Yq3YTEsQJt?=
 =?us-ascii?Q?WYweTpQhrMoMfs347D2Mm5NMtbBeeBP0rNbTlHY5fhB1VAWzpgiawvP5zuo8?=
 =?us-ascii?Q?EGqTnVC1kZqepRBTQwAL/skYSwx6KkWGeKBN1bk1F3JLGy2B6cR715lfa6vJ?=
 =?us-ascii?Q?o//y1o3eGsD0RODGPLY+x0QqiRlL6Mb+9fZe0Ct2EDx6f8piYuKiZqKZUHVa?=
 =?us-ascii?Q?Ngj8McTgO3lWqM9OTeqW6FuVycFna29gL+2NBa+6169rf8cI+9RS8gJKPDt+?=
 =?us-ascii?Q?DfQwm4+sb/c+/IzoFGlegy290c4pOcHqxwtCgl8b2gEgyXzWfW8zIpV9w+Eq?=
 =?us-ascii?Q?zywG1KBjA+H0rGAPMr1+gEJ7BsBQJ9+WMaB3CDH2T6pguyrC8TAUYzXOhEkl?=
 =?us-ascii?Q?3AQX9CHvW/goqGRnaxgJSF2U44Hf5eVcN/VZu3Fm6Z0XcoFxJpM6/n7QZX0e?=
 =?us-ascii?Q?EofXDgMQOIXIW/JlPBlid3tmyKer7R3BkSt1+TycqAZVUakN5ru6R+Ob6OUA?=
 =?us-ascii?Q?M/mGx1HXWxpLb3DEZugCpo/O+7XvXwyR/b0tiA5GqgMI26qDgu9giuChJ8Di?=
 =?us-ascii?Q?m0dN8PBtPNxgkRTHMQ4QBdP7LVyuDi0lVakmieC9un6JvbSjMwk8Nnk9NTKz?=
 =?us-ascii?Q?qrUWjVkQafJ29+Kkk5g=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f39651f-f820-41d3-cefd-08dda36082d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 12:08:26.3781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cr3XRPFtgtmXJMtxbmd4mVbD7F+qIROMknlk3bd6mDRGPoqPseSD9AKruPUouIdTt3T1mCHM8jWzROEoUs3cAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7414

> On Wed, Jun 04, 2025 at 06:00:54AM +0000, Wei Fang wrote:
> > I think this issue is also introduced by the commit bc66fa87d4fd
> > ("net: phy: Add link between phy dev and mac dev"). I suggested
> > to change the DL_FLAG_STATELESS flag to
> > DL_FLAG_AUTOREMOVE_SUPPLIER to solve this issue, so that
> > the consumer (MAC controller) driver will be automatically removed
> > when the link is removed. The changes are as follows.
>=20
> I suspect this still has problems. This is fine if the PHY device is
> going away and as you say device_del() is called.
>=20
> However, you need to consider the case where a MAC driver attaches the
> PHY during .ndo_open and releases it during .ndo_release. These will
> happen multiple times.

.ndo_release? Do you mean .ndo_stop?

>=20
> Each time the MAC driver attaches to the PHY via .ndo_open, we will
> call device_link_add(), but the device link will not be removed when
> .ndo_release is called.
>=20
> Either device_link_add() will fail, or we will eat memory each time
> the device is closed and re-opened.

Below is what I find in the kernel doc of device_link_add().
https://elixir.bootlin.com/linux/v6.15/source/drivers/base/core.c#L711

if a device link between the given @consumer and @supplier pair
exists already when this function is called for them, the existing link wil=
l
be returned regardless of its current type and status.

Therefore, it will not create new link each time the netdev is re-opened.

>=20
> If that is correct, then we're trading one problem for another.
>=20


