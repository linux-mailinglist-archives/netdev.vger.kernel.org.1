Return-Path: <netdev+bounces-151087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 621FC9ECCD3
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 14:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61B76167F88
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 13:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D809522914A;
	Wed, 11 Dec 2024 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="ld0bCr/k"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F58D226186
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 13:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733922289; cv=fail; b=JUfR8MMxoIC0Zpf32B5sY2YUfNfZ4IAt2qxPn/JljizGNCshylPXgXqZjVjdTiOya5t4stO9S2vCmhkVdIIg8YLW5a0JEvISZgKUl6FJxLO8qy3KOPubBtNxMXTtYSaCa+RfBUeGKTItZuvPg58JU/c72SqhB5he8kuXqiI57V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733922289; c=relaxed/simple;
	bh=//0CVQc+R9U9Bo4Nez3RqO4u89We/Xk9P+rRNzEfRW8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CfYMYgtxEkY282Mvlw5DNibiGgVuujaZ66bY5YgeePOtXl5Ael4hncNGN9BOr/tVHy5g5wOsep8HN6SSmbC2cIbZpsEWQRtMtomE/zbpWTjLYEFZiAswiu2k7SiABzS6BTNObjmZp/WbEssMU4MOQEpR/86GCzoDv8bGaZT9Qt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=ld0bCr/k; arc=fail smtp.client-ip=40.107.21.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=voMosCCkyLiFYDDZTypnafR6+uJTjJYL/lJfCF4Qv2ru28qFIlGwJ8+DRm/N8sS8Ht29brPQOexYO/JdgzWEOfVGDIe6sPk2mkrLlLfHhS7fNPwluXIp9b//AMS+DiiJpxMN+neJSqZau9t6VD5prG3e9WBNUnakXMYAyuhxRgzfvqp359DRnAwBvedWR6MeCz+a8f94t4F3K5chQer0E2/Xoha8HMKKklLb+M0KxOascX9Xn//vJuzdkLlv8htSo5pbEu04O0PoYMWluj2q4Qpe4crwXBf/v45e3s6MOP4HeTfW5QjMsHzPhpOz6grz1Lefvu1d/6sCSKsBr4mxgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXU+LzkObK7XGONLjeXShC+uaDDFRIurscnvhWR1wG0=;
 b=yb4elkZ0V72pRk5XAScsh+RfNpp06SAqGozj032MAa6+qvs6ZF8BYhfrcxvv/SU9ECsnd0xsdKVt2GxPIOvxnd7Kd+Sl1+MFDffTH/HEaVsZuTMlrQQp1/FxpSaLo4ssc322tRUA2387XaMcS5bRkKt0jNFI/qB2wdf7T+y8adMqJpUsRdsJ+XHlga4InBflZz9DrRtCsPWduF2fdn0aFKAeHKbg00+/hyTUBqryaC2Xc2EEeYgTEHu4v1yJGx/NEi5NC1JG1iqjmYXLmUDkBBQfDwf72naIiXnzpJZCpqHkxcvNPZkdlIH6ldI4xpxuIRCXaYGRds8MDA2QAAdSvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=jo-so.de smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXU+LzkObK7XGONLjeXShC+uaDDFRIurscnvhWR1wG0=;
 b=ld0bCr/kQjqru2Qlj1TrPyjIsXhuY2h8sp+Iylz47rs/YSHo7qWb6Ywg7ZTi6DyrD2UXp90gDxCE/juQj7LsXRDDK91z5gKvptySAN37oODwbA3stErpPc+U6MpZaBsDfFZeo1JhR2XBZI1275VimazaZXRaEULz6owV3wiPkIU=
Received: from DU7P194CA0007.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::30)
 by AS8PR07MB8072.eurprd07.prod.outlook.com (2603:10a6:20b:35b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 13:04:38 +0000
Received: from DB1PEPF000509FE.eurprd03.prod.outlook.com
 (2603:10a6:10:553:cafe::18) by DU7P194CA0007.outlook.office365.com
 (2603:10a6:10:553::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Wed,
 11 Dec 2024 13:04:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF000509FE.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 13:04:38 +0000
Received: from n9w6sw14.localnet (10.30.4.231) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Wed, 11 Dec
 2024 14:04:37 +0100
From: Christian Eggers <ceggers@arri.de>
To: =?ISO-8859-1?Q?J=F6rg?= Sommer <joerg@jo-so.de>
CC: Andrew Lunn <andrew@lunn.ch>, <netdev@vger.kernel.org>
Subject: Re: KSZ8795 not detected at start to boot from NFS
Date: Wed, 11 Dec 2024 14:04:37 +0100
Message-ID: <2675613.fDdHjke4Dd@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <cxe42bethnzs7f46xxyvj6ok6ve7itssdxyh2vuftnfws4aa3z@2o4njdkw3r5i>
References: <ojegz5rmcjavsi7rnpkhunyu2mgikibugaffvj24vomvan3jqx@5v6fyz32wqoz>
 <5708326.ZASKD2KPVS@n9w6sw14>
 <cxe42bethnzs7f46xxyvj6ok6ve7itssdxyh2vuftnfws4aa3z@2o4njdkw3r5i>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FE:EE_|AS8PR07MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd49a5e-a168-4381-83c5-08dd19e45e4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVpzcUtKK3Y1S3BLTjVaOGxtM0lKNGpwUmptRksvblNJcjZVT04vREx1N3ZC?=
 =?utf-8?B?NGNlby8xZEtlek8rUGJlRER4aUxBcXFkWnVjOWFkY0k0YW9rVXRsOEIwR3JC?=
 =?utf-8?B?YWIzRXppN2paRUJVWjBnNGU5M0lPZ0pFKzhRQi94dXg1VFFJckdnZlNiN2lS?=
 =?utf-8?B?czFJWldyaHpSdk9Zb1NrTmVNQkkwM2hiVTltenI5UEJuMnVDYUg0UGd2d0NQ?=
 =?utf-8?B?c2F3NUVtV0hEMHVwSkZhWU9EZkxBWkprM0oycG9FRDVmMmMySEhqQTVodGxU?=
 =?utf-8?B?cmRaZ3ZBY3FRVnczQngrcVB2NDhkeWZVeHdQSGVxZTZzQXd4VTJDeTBQbzEz?=
 =?utf-8?B?OHJSNUx2aElZcmVzUmdTZkwyOVE4RXZEZWx6bU1qT2dIVEhJNld3WHNtV3F0?=
 =?utf-8?B?ZW5XTVRxY2dHWVRWU2JjcVNzNFFsV0N5MEd0clcwNWNac1licDlvaG0yeDFH?=
 =?utf-8?B?Zm5OS3p0SHRCTkk0bnZ1elB1N1c5YkVpSUd5QzZQRENyTm9TNEFwK0tGSDZt?=
 =?utf-8?B?ZFd6RU5GaHBNTWRHVHczRzVzN0ZJamExSUFtM3B6eGpDMkZwZGIyVXprQ0pE?=
 =?utf-8?B?V1lBdVZmUkJ1SDNCRkdGY2R4bTBCSUp1bzBNVlV6eGxURXJBUXZvRnNURDF0?=
 =?utf-8?B?TVA2VGwvb1NPdmo1TjZSSTVPTFBia2o1WjgrOXQyamRRUTlkQWZvMEVPT05w?=
 =?utf-8?B?N3B6anBHY3c3ZUpRRFBRcFNvdS9ISkphWkFlSjlHZlJMSkkvaXBQVlJmWnZP?=
 =?utf-8?B?TjF0VUY1U0hWZFQ0aGFOakFQbTk2b0VXcG14UitpeW1kT3Y5SWxaVnQyWDZs?=
 =?utf-8?B?SEhwNlJTTkNpV3psUEtaZ09IWnFJeGlJMVVkKzRST3l1M1hibGp6cmxSNXBW?=
 =?utf-8?B?QlVLRmZCcWVKeXFCb2FienhwS3liN0d1aU5YYXVIanUzZjFDam1iS3RpZWkv?=
 =?utf-8?B?bUR6K1U4TFZXcUhmUkt0UmtSUFYvWVE0SzVaV21jVll2WW5pRWxzS2tvSHUr?=
 =?utf-8?B?UnBWSkNLcWM0QnVKYTBJUHRSdDltQU5CSXZLRHJNelZwMFdoU3VMOWtlRkNl?=
 =?utf-8?B?NzhscHJyQkpIc1VqdC9ISXBiRlFzNURHS0JMTmxKOGVIbTZYSGc5em5hdHJz?=
 =?utf-8?B?SjYzZVA0US9YL0lWZXlCQzZBMjhSemlKc20rRjJ0YUppbyt0aEVUYUFxNDBH?=
 =?utf-8?B?RG53UnVXUlFyNXJDdWg2aGw5MEtUNVYvQWxnNFlCNDB4bUhNS29BTzFOWi84?=
 =?utf-8?B?dGlWcEJUUHhYWVJKVll5VWJaVDVGOFJqUGlzV1ZpVUJYaG51eTg5YVMvKytk?=
 =?utf-8?B?OE93c0hPWEtXNERDdWRsMkF0Z255Mm1FOFA5VG5SYUQyTXl1R2RtblIyMFE3?=
 =?utf-8?B?eEI3Q1RsVHRteXZFbXF2blYxbTRHaGZCQ1dzNW83U1QxSndDdWNERTIvbDhs?=
 =?utf-8?B?TnFnWjR6R0JmVVZ4RXBVOHIrdklQUmhqR3NTOUR5R2x3YmtJNVkzRFB3WkJN?=
 =?utf-8?B?dE1EN1BGMVM0Zm5uL0ZDbUMrVGFGcmZaelpEWTErYzYxcER3RDVLRi90bzcy?=
 =?utf-8?B?Wno2bnZXd05FWjBjRWNod250ZSt5WTVCYWV0WDhQZUI1bG5pMmppbnFJQWd6?=
 =?utf-8?B?cXZjemJ5aklqaDVLemtBWkNuSGNFODJRWHpaZnRTdWFZbE00Kzl3R2FENmlm?=
 =?utf-8?B?QzhNUmp4MEtqbWNpMnVPWFkxai93M0JSMWlYZmN1L1dUTFhDUkM3QmUybVVa?=
 =?utf-8?B?RThtYmR0K1kycDVrM3cvY3dhbWlQTElpVWNLUWZoRzdVMCtyZ1E2QVRWbFdy?=
 =?utf-8?B?c1NUSXNzaktSTUVqaElnbElPbi9WV2VhRytuYTN3VmpZVEVHYkdNRWlrYXA1?=
 =?utf-8?B?bHNzVUJvdkFkMFVZbnZnY3pMS25vcXJuMll4UEJjcVJUZnZzWW1YV2NuVjJB?=
 =?utf-8?Q?Cz1cNUzVMvE=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 13:04:38.0695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd49a5e-a168-4381-83c5-08dd19e45e4c
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509FE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8072

Hi J=C3=B6rg,

On Wednesday, 11 December 2024, 13:23:38 CET, J=C3=B6rg Sommer wrote:
> Christian Eggers schrieb am Mi 11. Dez, 11:18 (+0100):

> I think for 8795 these are optional. At me, it works with 0 and 3.
Hmm, I understood that setting SPI mode to 3 (by my patch) is the
root of your problem? If you revert my patch and set spi-cpol + spi-cpha
in you device tree, the result should be more or less the same.

If you think that your problem is related to the reset timing, feel
free to increase the sleep time after asserting/deasserting the reset
line. Beside the hardware reset there's usually also a software reset.
But this type of reset normally doesn't affect consecutive register
accesses.

> I'm not an expert. So, please, double check this: the spec [1] says on
> page 53, table 4-3, register 11, bit 0 =E2=80=9CTrigger on the rising edg=
e of SPI
> clock (for higher speed SPI)=E2=80=9D. According to [2] the rising edge i=
s cpol=3D0
> and mode 0. So, =E2=80=9Chigher speed SPI=E2=80=9D (I think this is the 2=
5MHz) should use
> mode 0.
>
> [1] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/Produc=
tDocuments/DataSheets/KSZ8795CLX-Data-Sheet-DS00002112.pdf
> [2] https://electronics.stackexchange.com/a/455564

I hate SPI because of its poorly written specifications! When I read the
corresponding sections of the KSZ9563 DS [3], I come to the conclusion that
the register bit you mentioned above affects the SPI *output* signal=20
(SPIQ a.k.a MISO). This would also make more sense, as you usually
cannot change the behavior of the SPI input lines.

[3] https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ9563R-Data-Sheet-DS=
00002419D.pdf

Page 68, on the bottom:
> *SPI Data Out Edge Select*
> 0 =3D SDO data is clocked by the falling edge of SCL
> 1 =3D SDO data is clocked by the rising edge of SCL

So the bit 0 is intended to adjust the phase of the SPIQ/SDO/MOSI output
signal, in order to avoid that this signal is switched at the same clock ed=
ge
where your uC samples the MISO input.

Also for the KSZ8795CLX there seems to be a mismatch regarding the SPI clock
polarity in the datasheet. Page 28 (functional description) implies CPOL=3D1
whilst page 123 (timing diagram) shows CPOL=3D0. I would trust the latter
in this case.

>=20
>=20
> > On Thursday, 19 November 2020 07:48:01 -0600, Rob Hering wrote:
> > > On Wed, Nov 18, 2020 at 09:30:02PM +0100, Christian Eggers wrote:
> > ...
> > > > +        ksz9477: switch@0 {
> > > > +            compatible =3D "microchip,ksz9477";
> > > > +            reg =3D <0>;
> > > > +            reset-gpios =3D <&gpio5 0 GPIO_ACTIVE_LOW>;
> > > > +
> > > > +            spi-max-frequency =3D <44000000>;
> > > > +            spi-cpha;
> > > > +            spi-cpol;
> > >=20
> > > Are these 2 optional or required? Being optional is rare as most
> > > devices support 1 mode, but not unheard of. In general, you shouldn't
> > > need them as the driver should know how to configure the mode if the =
h/w
> > > is fixed.
> > ...
> >=20
> > It seems that I considered the h/w as "fixed". The pre-existing device =
tree
> > bindings and the diagrams on page 53 suggested that SPI mode 3 is the o=
nly
> > valid option. Particularly the idle state of the "SCL" signal is high h=
ere:
> >=20
> > https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ9563R-Data-Sheet-DS=
00002419D.pdf
> >=20
> > But the text description on page 52 says something different:
> > > SCL is expected to stay low when SPI operation is idle.=20
> >=20
> > Especially the timing diagrams on page 206 look more like SPI mode 0.
> >=20
> > So it is possible that my patch was wrong (due to inconsistent descript=
ion
> > on the data sheet / pre existing device tree binding). As I already men=
tioned,
> > I did this only due to the DT conversion, I actually don't use SPI on s=
uch
> > devices myself.
> >=20
> > N.B. Which KSZ device do you actually use (I didn't find this in you pr=
evious
> > mails)?
>=20
> I'm using KSZ8795.

I should better read the subject line ...

Summary:
=2D The timing diagrams of KSZ8795CLX and KSZ9563 implies that SPI mode 0 i=
s correct
=2D The functional descriptions in the datasheets look more like SPI mode 3=
, but this
  is not authoritative.
=2D Maybe that the KSZ devices can work with both modes.


regards,
Christian




