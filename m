Return-Path: <netdev+bounces-160912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C6EA1C2AA
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 11:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F94A1887891
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 10:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7646C1DD9A6;
	Sat, 25 Jan 2025 10:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=enviteon.onmicrosoft.com header.i=@enviteon.onmicrosoft.com header.b="dhUSrRqy"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2119.outbound.protection.outlook.com [40.107.105.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9429D3C00;
	Sat, 25 Jan 2025 10:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737800183; cv=fail; b=uYivRoputV0q32e9K85UzKg6zbO2EAOzR/9fR+tPRWweyhEhSGroAAYVR3IxpX94TNbAFVYynVgAB+sRz+HnJjp3kXDLRnuMxvzfhGFeOegNAkErJQOdnG2KpSTiGJLXoQ3YD2U2p4V+172sicRKUKijjfq3AG8BXpmclDa/ook=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737800183; c=relaxed/simple;
	bh=XvL9HUiLEkaceZtbgZ38KigpWifOhT6tMiVOnpQXeLw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XpPD8SESKQrkgdrkoBcquMJV41j1dL1e0jJYBmzciCVhjsolb6xuYNIaVJ0ZZn4/LWA3Ejj8Z2cG2LiqKFskCPwGfrL3WTwhq5qPTntQN/c8AnwRHQZXL2XZgdZkqokI4Gm4X2HT8VoSagJzsOtF1otZDnfUEx9aYw1tGcbDdjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=on2.de; spf=pass smtp.mailfrom=on2.de; dkim=pass (1024-bit key) header.d=enviteon.onmicrosoft.com header.i=@enviteon.onmicrosoft.com header.b=dhUSrRqy; arc=fail smtp.client-ip=40.107.105.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=on2.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=on2.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cx/yKHyFoElmrDyojr61otzFTGXORDQhI992A4q5ul5WqzLbhpkqZU8YemLxTxgwM98Q5nL1PGq93XAxpO8hxLvJpYRqOC/iSbv253UTY147pDwUBiyiUUgty/1Xo4IH/ZWp9fHoXOvw0vq/nDwP4s/0p/H3zhFkoXHcshy9YtF+6Pekcs6kx8B3vfyzGl3+ZXPKbm3a+EUqoVpijfHIVlZyd3S9oohj3C71nW2g6pQsiyuEYIFPgJp1cQuD1RWFKGWmjyChPJZ5Bwlzx328l45Dikmyv45wGvGEh1JdM7w5PPFCjCtGF8y+0Tq8na5ctSXvRjjuUNTcDDA3O1qw9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvL9HUiLEkaceZtbgZ38KigpWifOhT6tMiVOnpQXeLw=;
 b=hi01Ap5EbPrD5LOXbQpN0NnHvrihhfk9zPRdph+Qcoco4qYhb9YTVoRK9rK8y2Zj4sZE7ukbpRMIw3NzV2Ml8E5QqrLLYCQ2+XQfZxRZJ6W8J46zVByobtAIrp135X4ZU7KcI2wbg4Nh1gr7Me1CQk0u7k3TLlsBxxD1YcRVJvOIHGMqW1pf1lzEYomjWFQK6sXKmLBlf+xDSaBkA28hgM/aKky83QxeB6Llophowo7OVkShwpoCS3uqhFFwPIZ59Mh75jXn2Lvck0a4baFanK93PnYBeDJI/h+nywTZcwyDSBIZwdsuAttKSCkfoYky+1wSWyZdZ3ZTV9Iwk+6tVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=on2.de; dmarc=pass action=none header.from=on2.de; dkim=pass
 header.d=on2.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=enviteon.onmicrosoft.com; s=selector2-enviteon-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvL9HUiLEkaceZtbgZ38KigpWifOhT6tMiVOnpQXeLw=;
 b=dhUSrRqyPwy9kqI1ujvIxuExKsSdmaORP6qsNr9autcX7rQ5yMDdlCTi14bVu64FtZz0CnZ5eh+0dd+JbyM31naeXPV1vrEkU0j0PT3M+IiD36NxEDX3tFhpw6QVGidCTodZfjiTykbwUaZESmcAm+XaBogrL3HZ4W7kWs4UmUE=
Received: from AS2PR10MB7502.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:592::14)
 by DB9PR10MB5665.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Sat, 25 Jan
 2025 10:16:14 +0000
Received: from AS2PR10MB7502.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5cb8:ea20:b80c:7130]) by AS2PR10MB7502.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5cb8:ea20:b80c:7130%6]) with mapi id 15.20.8398.005; Sat, 25 Jan 2025
 10:16:14 +0000
From: Ulv Michel <ulv@on2.de>
To: Greg KH <gregkh@linuxfoundation.org>
CC: =?iso-8859-1?Q?Bj=F8rn_Mork?= <bjorn@mork.no>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: AW: [PATCH 1/2] net: usb: qmi_wwan: fix init for Wistron NeWeb M18QW
Thread-Topic: [PATCH 1/2] net: usb: qmi_wwan: fix init for Wistron NeWeb M18QW
Thread-Index: AQHbbwzb8voVQOMnWEmw/QFzDfG75bMnQ3SAgAABp7A=
Date: Sat, 25 Jan 2025 10:16:13 +0000
Message-ID:
 <AS2PR10MB750228C3257C097E0F00156189E22@AS2PR10MB7502.EURPRD10.PROD.OUTLOOK.COM>
References: <20250125093745.1132009-1-ulv@on2.de>
 <2025012501-pediatric-abide-b802@gregkh>
In-Reply-To: <2025012501-pediatric-abide-b802@gregkh>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=on2.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR10MB7502:EE_|DB9PR10MB5665:EE_
x-ms-office365-filtering-correlation-id: 2ce26cbf-e730-4be0-1341-08dd3d294c4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?+732n+OhuxP/Do+iCxyaGT7rvUZMbhosc/e/5wmRiO8W+gPS028z2nZy1Q?=
 =?iso-8859-1?Q?PTRpiWZ/De8vfYCqaL3ozhDFCk+qxv5fJGdnvsxw7Sxx67cXBqMEapl6jB?=
 =?iso-8859-1?Q?6hxrTsqeHcbTrk1AMfze4UA0i5G4rz2fBLwo9AYVYWBu3ysTvxy2yVKgMQ?=
 =?iso-8859-1?Q?Xj6+5S/aNzzqZ4294FJcK9TCK3pIK2ExlYJDidHMXogAEmTft6tzZVXUNj?=
 =?iso-8859-1?Q?VadPekBVDIVgWgPH8TfJoVvzTuJV6lqC6QgCInqaGCiN0mJHoESwaxw8NU?=
 =?iso-8859-1?Q?y0OBmmAini6jMv4ILGw+7ReZyc99uM4KBEufoSKKDsPSevg9kuRPKAjXNB?=
 =?iso-8859-1?Q?EQFsbRbrzazDBOLTGZqQ4x3M3CkWUoq6wwrqSj4GLrWMDn2myi3A7z2BzG?=
 =?iso-8859-1?Q?Gr2XdySvvkBt8jy/oitguDQobTHpOJxLORydnjqwxCoM8Bh1r9TNOrSsw2?=
 =?iso-8859-1?Q?zyKCfBv89NIWgTQXSOcsXBN9lW/L3izDHxKoDzF31hf3NXnmeAdF7yRfFW?=
 =?iso-8859-1?Q?a1XMjXFLAnEVx42hEMb+Y9jW5hNGjl7ZeW3gDtueD+SvwKaU2tWISrwLfV?=
 =?iso-8859-1?Q?ixfcKzGDluK40r0M0StsuS/LqKtpa7UaxSLwUt8rIVPAUFVcZDDCZ1Qu6/?=
 =?iso-8859-1?Q?bFlGT94JaZTyoGej4xdLW7iHjPpNptiYaSrKI7cMHdh3Yg5+9GyIf+o5Yr?=
 =?iso-8859-1?Q?6xHEmb+Sz6yiIbvM9HkPYXcNVS7vS7oaKCSZMoth4s29lM7dWXW5UpUbi+?=
 =?iso-8859-1?Q?C5O3xXmzZaIR+yoCVB/fKtymmMU4mBQ0tuhouzGA3qfD3nH2WDeFA84kMI?=
 =?iso-8859-1?Q?ucdfLbZQqzupzNIg4rEuhZJ4HCvLIJlaXDyyHNNAjgOAH+fvvcXuPDXLBl?=
 =?iso-8859-1?Q?F+rHhrRfEuZwbK/GbQqnr1G9GRoje7H5UMAj78LBh7DtAz3tSo9tf/NS5i?=
 =?iso-8859-1?Q?TzUGC+Agw8BTkXi+9eUirSzy1O23WhJ4qD4y33CS+4PGqU0hB87WkfA1/+?=
 =?iso-8859-1?Q?iwaHCQKDrumIlMZmVDKPr5OMwz7Xr7QFxeuQFB3jEXVO+oXXlVpBcBdxeO?=
 =?iso-8859-1?Q?obufECQxxJ7jjccMvvk16ouGwYifHNGImGgF80W5dKVCqTeVlqVuDAaO4J?=
 =?iso-8859-1?Q?IAU9C5vqY90WyVp7nGaOw4YrDjibfCaHw4IGdlFRXHlZDFKg4QUVXxW1oe?=
 =?iso-8859-1?Q?8pcCccHxENML84TEQZQm305mkCLDiyZTcRvgXfS6isRZxOI7m6qyW1yNZX?=
 =?iso-8859-1?Q?rH/PTMdBJwLlpNl1EHruuqn7HkBrtNxAePVDQrULivrLzVM1YdxxJuISDB?=
 =?iso-8859-1?Q?W9mnlERU81epaaTaT89H9uby9SgzIUkB4b+bxW8AHoasB3SOhvs8t6gtnE?=
 =?iso-8859-1?Q?Ew9KG/Q8BbMP52BzkdxwaDWd4xN39xnYrxFpINoLCid1ItCy3KTOkFJVw/?=
 =?iso-8859-1?Q?gOKXjuKhSmiVtc3g8XBHmiRdltd8ekVWslI65Kzhp/m/i6LLFF+ixvd3F1?=
 =?iso-8859-1?Q?QQ6lcjXHZADYG0y0vN4Ajy?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB7502.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?VfReJ1hWa3hvy0kxd+PVQFAx05sZHyzlRkANhpcKB4gyqs/4kEdq5vZQ44?=
 =?iso-8859-1?Q?sLDwE8Ykmzur4u1nJXecv81fVG5wZyL7yweOuxf12aeiDqnQFMp05uA15M?=
 =?iso-8859-1?Q?+F43MY4iQuWxcAyjLY61KsZ60OCFUZmEIER/aYbchpsvtsiLx3+Tn0f5De?=
 =?iso-8859-1?Q?UrIC28uxY+VINNvOoWZVcfYRgGEgsZmiOj87ZDYob8Z1Qvdi+aijeqaX6n?=
 =?iso-8859-1?Q?DigYleWSLLZOFwOZuRLO1pjtk7kkgDPA7JpSuLUbXndaDYcsO5DxTCXCWe?=
 =?iso-8859-1?Q?PQ1gHtpEEG4q/12M4zgUfEYZiz/J7vTqXSqCyUg3QEBdC2LEz1ykBZyxdu?=
 =?iso-8859-1?Q?he9v8BLjPTQgq5wTeviEIV1Dni2LQGPJfzGqk3Nll3I//G1vaMpra/2Aux?=
 =?iso-8859-1?Q?a8uG6XszZCkg52+EJQSGl5Y7HC8yqKaldfmnhp7r4NdwuHbmotqKfVeZ/k?=
 =?iso-8859-1?Q?Qzpc5ls3kL/p6YUB3oflBg2rdYfp+plTVFWG4vRouYUR03uAtRreF/1BVL?=
 =?iso-8859-1?Q?bgOgukkKBs9SXx5EVPp6KP2BjtwKElw83Vn0CxVz3HpPaLOiaY+k6YlGCG?=
 =?iso-8859-1?Q?kzLZh08GczHg8J8SMTHjHWh5QS/CXdHmwOM/HaSQjraWi0BVYGlyTF/I9y?=
 =?iso-8859-1?Q?E64lrVMVeIDUWpszZNE/bHCS6qXcn6DMz/nfOp4duHtbtR8mDFwFkKp+AS?=
 =?iso-8859-1?Q?7TwH9y7m9LVRbwpnMKnCcmLdsXW+PFsLQKc3syIMuM17RzNLTZ5QdDay6E?=
 =?iso-8859-1?Q?OzInYzXyOCpfy3VSaaae3+j0rCRtaLEZxWKsjw81phjkKkaMYGhAcp7y8n?=
 =?iso-8859-1?Q?lY1o/Evzg7vN/OeltRlihudgCai7IPWApsaM4Oi80E6f9LFzsclA1boAyQ?=
 =?iso-8859-1?Q?mIwV2AqXUSRjLg8sAlRjwYK04+8ShP0kzIvVjL2Z18+E9n2HG9hwFhKZ3R?=
 =?iso-8859-1?Q?+oZSNA+35Rjmytf5vgbmLY6tf7RMXOW6+zbFU1DgETXuSTJAm3rdNSvLQV?=
 =?iso-8859-1?Q?JUB62I6Z5WQMnFebwvthIjNnbOxUcdqCS/9VHdcFcoVWAo7FdtNynTUpH9?=
 =?iso-8859-1?Q?w3D3AWI3X8P0lgsVhHL+gsBh8vXKJ3Fed23W10490xYvKTgS5cBtaAEDzb?=
 =?iso-8859-1?Q?MsslCtXX98n1fU4YXbn6oa1fDbk48EzOTu0FGUP1ntAICPzWrO7fkvP97J?=
 =?iso-8859-1?Q?CEokDcp66upFkbalCvt+OAd9+PgKM80M1E79w4iZ4WRFInI2gRtOSsyxYD?=
 =?iso-8859-1?Q?iKUQcMOAY4DkTglVLwMLHK1O2H9uDt5TciRcuBiKuexlUTtdifMbe33NZv?=
 =?iso-8859-1?Q?u1+utDMoDNGgigG45iPA+IoDKqBnE4YDglIKoWOAmlwSAUu9JmDyaPv0D3?=
 =?iso-8859-1?Q?BkVJ4gzdtlL8GPuDK88Z9d8FrduHd2OXYRufKKaHjsbhoulsWodnJlIaaw?=
 =?iso-8859-1?Q?S8JzOaYmFE8FNT7Jk4XIavH31QL2tIDHV3Z5EpQiSdLNl5yvjHoOJ9Ovrl?=
 =?iso-8859-1?Q?/w0n96tJofSsQcSc6Xqep4nuvNwAk5i2CaMRTRYBZB2rrOGkP0I1dt411q?=
 =?iso-8859-1?Q?rtQe3KEix7kPZCnjgtbKg5O0kYCVGnvt+LAiHM2pGXA8U5FaAeVQiO+6NP?=
 =?iso-8859-1?Q?4Yyl4Gc9aeyq5wcDoSHE0d+fjydwjgT7BSsGjc2jw7ff+68y5H2mBqSxGB?=
 =?iso-8859-1?Q?hZr803OEuFgJ1h3b3d0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: on2.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB7502.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce26cbf-e730-4be0-1341-08dd3d294c4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2025 10:16:13.9222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9ed1a1d-8109-4b86-a3f1-493fe8342a3e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NpQrsJeusxvpmVP1HPpznrKV7lFqln7BmWCMXfoJkrFCbJNew7QTyT4RFD+dtheJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5665

Sorry Greg KH,

Sorry, there seems to be a misconfiguration on my build machine...
The full name is Ulv Michel.

Thanks,
Ulv

-----Urspr=FCngliche Nachricht-----
Von: Greg KH <gregkh@linuxfoundation.org>=20
Gesendet: Samstag, 25. Januar 2025 11:06
An: Ulv Michel <ulv@on2.de>
Cc: Bj=F8rn Mork <bjorn@mork.no>; Andrew Lunn <andrew+netdev@lunn.ch>; Davi=
d S . Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jak=
ub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; netdev@vger=
.kernel.org; linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org
Betreff: Re: [PATCH 1/2] net: usb: qmi_wwan: fix init for Wistron NeWeb M18=
QW

On Sat, Jan 25, 2025 at 10:37:45AM +0100, U Michel wrote:
> From: U M <ulv@on2.de>
>=20
> fixed the initialization of the Wistron NeWeb M18QW. Successfully=20
> tested on a ZyXEL LTE3302 containing this modem.
>=20
> Signed-off-by: U M <ulv@on2.de>

Sorry, but we need a bit more of a name here other than just 2 initials :(

thanks,

greg k-h

