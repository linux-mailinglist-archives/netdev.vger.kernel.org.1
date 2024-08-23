Return-Path: <netdev+bounces-121546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A694A95D97B
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 01:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3012F1F22BE4
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 23:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517D31C9EAF;
	Fri, 23 Aug 2024 23:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YZnZkeSY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1681C9446;
	Fri, 23 Aug 2024 23:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724454428; cv=fail; b=GE+Xw6PbzH3Kx13rNGNaqADpZZnxc1J2Dfg7Xb8rbH2kPjnhhHlBQhoiesulnAT75Qwp/ScJBkGB42/YVBdafae7prTnKlmKg18djc3tKTBnEgk0YD9c5ZKxKdMxj8hacBfHYORsg0iCtHLnYdV0gekP8S75F+7PEVddmfmrjn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724454428; c=relaxed/simple;
	bh=YVt8m+mG8abW0NJhHo/AKy6jvycw7m6zFjfjN5qBigo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Vz0CSLPICTTPSy/e19bS8i8ojafCtqKOzT688saV7FXU4qTsFhC1vh3NFYOE4Wl5vVLGzkJhTlRgZT2rqzu6QqDzDqFmlySvTPcaRZX9xVmsBkZrRi9dfahPpS9w+5/SncvA/MM2AyJX4OPuTaPG1Fbfq314hv1SmaJrGB6iPdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YZnZkeSY; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYfc647Laofh4KP6jOehTtm14raj+D8HUXO1r2ii+mSLkKKMZS4MmFSPx0Y+sxF9y0480BxzOSddmwCzchO5C+Nx/pKQfNZwG4feUOAkRs9icU4Msi/XaznrY9+drp9ZOL1CcEh34lS/1H9uUz9K1m1uxKKm/KRGBUQP/PNpCrpYeR4hcaaDdhKl1MMyZ2CGTVMADXunantCNjtzi3Y9anvM8mf1P4deXJaq0Fe/a2/4zxJ1OW5QrrzYWiRkw/GDlXr7/btYArQGr0cDfK9XXPym0zcxgvv7Dg7/Ce0Tc0/ZUMQPT21U5ZeB4WkV7XxDcNp3tegUcLU6r5ClW9yK9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAplUBOPdEkbh53qJZdstd13FK4KLB7RZqpVS/es3MM=;
 b=DYoWnS6BHVO8iP7pOsJWBRh5rJOlHdfhElXme0NcmMvTny2lemsMe3K6HketmjQ0c7E7jVyqeIdvmDxXZzqNIVqrTFbB6jT+8SKHa5qCQZplfL5KnP6Pnr30doM3Xc4UCRzSL4OGnQeh5FSTbsZM94zpqJLyEPI3OyBeN6+0bFuPufyB+hrTWzgazsq7sSikhVZsVsOvNwDJAcp9knqp+Ef+j96bQenVZCi1N/MIHo3/pTIsgaVz1fghlXCbHbqy63mOSx7EyySiXrCdqfMDa6x1W+vqN3qwrKCb204BrRf8AotUgVESKnzkTOYarNApPtMVg+veigDnURooUtv4+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAplUBOPdEkbh53qJZdstd13FK4KLB7RZqpVS/es3MM=;
 b=YZnZkeSYrYBYCkvccS7gowsjuPaq96wL++5cqFx8c8Xk35Qx8KmNSvUXfxtYZB7oWBLjTOX8hEsnv8jGyQTF3nZsNi49r7Y0bO1qgGDEE5i8+F4gE0GddH0eCX0LI17k1DlBoPvLwfJdyQz9RPhJfy3HPudyLkE5Kli1pPbPkCHUrOvcBbjgR9xc8JDbQ8+2qxVQaS47mFSJ/LroeqzB/Jyi4wde7jR8RI82g8512ITYCG7qyfpLoeNOa7H2W28ApRvCzWhkVnEGrrbmdfMiy7Mr0XgZEC9hzlsvKGl4RNAK5K+96x8yLI47zdez2zCgbMUWxnZXt5D88uYuruN/vw==
Received: from BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11)
 by DM4PR11MB6526.namprd11.prod.outlook.com (2603:10b6:8:8d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 23 Aug
 2024 23:07:03 +0000
Received: from BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6]) by BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6%7]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 23:07:03 +0000
From: <Tristram.Ha@microchip.com>
To: <Woojung.Huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<olteanv@gmail.com>
CC: <pieter.van.trappen@cern.ch>, <o.rempel@pengutronix.de>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <marex@denx.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v5 1/2] dt-bindings: net: dsa: microchip: Add
 KSZ8895/KSZ8864 switch support
Thread-Topic: [PATCH net-next v5 1/2] dt-bindings: net: dsa: microchip: Add
 KSZ8895/KSZ8864 switch support
Thread-Index: Adr1sJPlE56Em8NJQP+azYHqTK4L8A==
Date: Fri, 23 Aug 2024 23:07:03 +0000
Message-ID:
 <BYAPR11MB355841E229A2CBB9907C673EEC882@BYAPR11MB3558.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3558:EE_|DM4PR11MB6526:EE_
x-ms-office365-filtering-correlation-id: bd500cc9-396b-4a85-1c94-08dcc3c84d63
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3558.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jZyxLj56IRT0XWJ0COT/ASm2YsDuDcrpS124tavOjOOlOC09mWzdGc1YvgWe?=
 =?us-ascii?Q?y600I6rLzjobOIWPRF1ZOdLoTn3crCoXiJkGn2tLg3SBktuonE2ApGjQtaoW?=
 =?us-ascii?Q?zdJzb8zFJsNVjH1WOIm0I1IcVMovJlSDpIC9HuKQ9jeVZGuXHSRAP0zZmkkm?=
 =?us-ascii?Q?Yh57OiSQzsfSAE3SA5MSzN8Ri2220+oj0qLoMwHHXQq1fGaeJnbVXrC3Vnph?=
 =?us-ascii?Q?rhcsBKiZQUyS6amuTdHSGwjiAK7gy4H5gg3zlhQ13n4uINNlcyIT285JsWxd?=
 =?us-ascii?Q?pxLt8a0877Qsz1qb1HUNVbgdF72VY+8u4to/XhEubFbYHLkZOJXiMuCPAA9w?=
 =?us-ascii?Q?+D4brpUiGExx6em02hUBuqrmG35DCxev19/3W0anQHQPFgdFuK/0C838DWYW?=
 =?us-ascii?Q?SpkEFmVDI50koHNamMkCi2qFUyRdrsGIBehuo4t86kepA/RqQL84rR9ge9CY?=
 =?us-ascii?Q?6LCdpVotLfy5qU0bt5RjNOumXm1pjzrDLTMxgkor76U6/yzWmsIgyAxNvnD1?=
 =?us-ascii?Q?SPU7neEqRMi58E54ynDFr9PDmRIj5liRwMJHawmfMnW3YipYDET3e+6C1ndD?=
 =?us-ascii?Q?g78HEReR4nfgSB+/SxY2KL3mn6WgFOnjUb4JPHwG9sbrGFPLY3FZwxBTOdUV?=
 =?us-ascii?Q?ZNRZ1zXhSvKvGUHwwEuY26eoiyWGEfKeXcdpfjmEEP9dU3I//9gBREyPaLQ/?=
 =?us-ascii?Q?qFWHgrx+Izzm825DkgAUXFYhziuC64wMElWoQEzdbqwz8RQ/FB5SuY9I5k25?=
 =?us-ascii?Q?xy2MqJBOjTK0khHe6bCJMbmMC1NenNz30Itxn2SPyKsvg6Izr3lJjTPiNQQe?=
 =?us-ascii?Q?RQMy/oVIcMvdE1xtrbbDxXMCCvj/4es5KWXzOPi1HfYT6vTzNoh1yUbHMwvk?=
 =?us-ascii?Q?d/4uuMY4wWbJ1iKJIaHBEpwghz0mdrbw9eM/GtNr107xZXdlur6a8KYF6vH+?=
 =?us-ascii?Q?C922wT3wrRhyRJnu/Q7dPYsMGmSHZe0AN8SU8HX02wz+WO3MlcRZY3o6G9G6?=
 =?us-ascii?Q?MoNHTkNSXzqbQoMsQZERTzX8s2pL+9xyAQC4+l81nYpbsyANkvx8cCLxndgs?=
 =?us-ascii?Q?FUbKEdcrsXn7IjUJ5TQG3yKrEtSacL8C/CmbQhfYDBH3Rqfr1GNz6tqxlXlk?=
 =?us-ascii?Q?FhOa3CSxMKsWk0TaesPat0B7fit+q8jcL2PpjjK30suOBd+McLkxoIpUNmbw?=
 =?us-ascii?Q?mpgAn8thTka4sI6poy4MqzcQAcQPhz3ar9BOIDDI44kDiEyNFadRWTZO6a7x?=
 =?us-ascii?Q?S3xXBrtUxVidbwbcXfI6glZ7hqu5PE2JeJsBUaUNXY+UJ8t7HSnsETtEyR0H?=
 =?us-ascii?Q?JunDV+G3gQSJzp80UE4u9yJ5ptYvB3vyFZm9jntVH6PtghITJ9OUf8Jv5M/3?=
 =?us-ascii?Q?USw0NRgQf+xMxtY2TIBfLd/s+gf8JKCvqE2WXB/7tMG8kpZ7mg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zfop7prxO/mX4/NSS8L8yvQTBSMN6Robu2iBN/6ON5dVnUw56IQBTl39Byz8?=
 =?us-ascii?Q?Ecpew7Bu2wQpcPPCAMN5AtpIgrjEXdGvFRES03376Zv3Vda4QzEFQX/itIjz?=
 =?us-ascii?Q?McyPFzdr/Cilhqy6uHduFeFTLARx0SsVwsc9llMe9a+cbMA1uEsr6UG/SEVV?=
 =?us-ascii?Q?cq9CumH7KiafLzf4lIyINVzkUdA3VafECTX0K6KG4AjoHBKsBQ8p/G33FKlw?=
 =?us-ascii?Q?tJnqRRBSBoZTIlhrKK5ohrQgiwl9d5xEEN6ig0nnp+8Ju9M5CP0scup2vf8i?=
 =?us-ascii?Q?xMoXV7iocUwbocuDLEDXESjtNmCNlEp9o4a4UE/xmw+6N7P3ev2lYhpQmcYr?=
 =?us-ascii?Q?kGjb0xa37rGNo+PnFBobnAwDvMRhI0zDiKnQTiv3PyU9i+Oehx36Mzx7JKAK?=
 =?us-ascii?Q?hgg6qoaIV9OKg7EAkccEEmK7AoRgp7Wc1JH1//nFfzkBRvD9lkgiELbPjXdH?=
 =?us-ascii?Q?e17IA7PLShCAmPMy0C9IuonIW6+bQiLuf/EufypnhUDclHNMr5OkfcFxuQFG?=
 =?us-ascii?Q?z7N3Q8hyWb2UpXACIMwvmrN1+zsVfOOGGhixVPLpsxF9vVKl6Zc5rp4T3YH0?=
 =?us-ascii?Q?PRSR62KzSB0O1tsuPopgVYYjKrWnvdjoQxj5rwnYD+FPGoBO9PEeIyyxBhpN?=
 =?us-ascii?Q?bDbNHFXh8KBLfg+ti3dezs0AzdZAh/ezfVo4wP1P8mLDaHqrN835hQmOBLXW?=
 =?us-ascii?Q?CKpNq8/hV8UFelUzgf1+3NDNvumc7BoNr73pZEsxlNRGlbbHNBimsmOBxaD/?=
 =?us-ascii?Q?mYCdBxoT/tYTaS7wn08BnWoEgY8WKmxeXwcWfJd1RCPqt60VlLbSukVzx1Lu?=
 =?us-ascii?Q?poZbApR4tTomjj52wFcZMBMPHmUyxSRgVc1TAV6s79HwDLWHRP36uPm6FxMg?=
 =?us-ascii?Q?T4KCqgsB+U/AFzCEwJHocnmPE5rCdoxXU5ViES74SANozCNwSRUfVrTZ30CE?=
 =?us-ascii?Q?IAa015vNPxnWT5+4tTg34O9D4MEpEV08ZeNnEVH/6X46Wso1Ocrs6u8lqKhu?=
 =?us-ascii?Q?u9uNHDtquHkSeCAK9dClluSWo3MF4j9kYUieMp68M2vnr14IPfydxhmmjVaJ?=
 =?us-ascii?Q?o8wVvIpQ4Thy6UdhW0JuNUPjphxBsapXl3bIB2PZJqApPX6w3MKH8kHB8S6d?=
 =?us-ascii?Q?eHJj+I9Mt4poUTf+Xwjq+sNuTamXRTKwpQ8xBpRNTKAzxmvd6nMxQ1UjyO1r?=
 =?us-ascii?Q?X2a7rKG9xk+HUTE7QSpzw0gChxJWIteUFQcpPZGZeYCqT3Da+S2RfZ5SFCMA?=
 =?us-ascii?Q?zoNFqMFFjdq2m+4QY5NvwL1QOUJkXiy1QXsJ7jEYWXMV/kcUZ2HsyIpujiGv?=
 =?us-ascii?Q?dJ1vyTC0dS+PkxL2cF+VIbA7FHw9Exs/ZJ1VApB18IcZ0gnx+MUwF46fL/3N?=
 =?us-ascii?Q?Owk/yhsyIsZ9GzQGKJO2uwaFFFD7IxWzYJq/80TMF8j2MztB4SdqDdAZhAJf?=
 =?us-ascii?Q?w8ByvK9blWKKeQuav60ceCvHLb6UmjMYMWMRfZ4/LjmNEuTh3y2A3myLQs+7?=
 =?us-ascii?Q?+odiraVPVAdcdWY56gqGwpQERyiz1FPG/6uig88xNBnhJU7KfPF6UobFcLQY?=
 =?us-ascii?Q?XT5jcOeXNB+R7Sz8HYAqFtQILd5ScoxWMZIfncOn?=
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
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3558.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd500cc9-396b-4a85-1c94-08dcc3c84d63
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 23:07:03.8375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bBWs7++G55MXjoJSi6DPENB42b+NLm7Znvf26aD5iXTvLbZ6xduIrQijBFO8SfCqes3Sz7mH5KOBtymZO42FoThbpleNBYMeHMU+KjeK+AE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6526

KSZ8895/KSZ8864 is a switch family developed before KSZ8795 and after
KSZ8863, so it shares some registers and functions in those switches.
KSZ8895 has 5 ports and so is more similar to KSZ8795.

KSZ8864 is a 4-port version of KSZ8895.  The first port is removed
while port 5 remains as a host port.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b=
/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index c589ebc2c7be..30c0c3e6f37a 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -22,7 +22,9 @@ properties:
       - microchip,ksz8794
       - microchip,ksz8795
       - microchip,ksz8863
+      - microchip,ksz8864  # 4-port version of KSZ8895 family switch
       - microchip,ksz8873
+      - microchip,ksz8895  # 5-port version of KSZ8895 family switch
       - microchip,ksz9477
       - microchip,ksz9897
       - microchip,ksz9896
--=20
2.34.1


