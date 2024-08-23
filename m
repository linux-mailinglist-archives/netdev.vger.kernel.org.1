Return-Path: <netdev+bounces-121545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C8795D979
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 01:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9D3D1F22BE4
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 23:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD56B1C8710;
	Fri, 23 Aug 2024 23:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XhI1g9s+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7B55FBBA;
	Fri, 23 Aug 2024 23:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724454424; cv=fail; b=bEFaNcUT9UDER8pO2lQWOs5hOAaINYUggjAzkc85aiMboFcz5oI9H0z43ezL2tDGTAlooS9sQFPu4Ou3BcQWZiBkHjnv216Bqhrq28AMgs8spNI72VkdRoHfv4H2IaOqOYnvSL58e2ukCZOt4wdL2p4cYjWAnS4PcrlAcAluIg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724454424; c=relaxed/simple;
	bh=iLPZd9rfJqKdlPUvCM/+Pd8FJkbogx2pmVb3uDt7w4U=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bE5kT+2tSRQfdRN4EAUVzjVVJLIL9Bay74exEuDCVzdWODPTBAHaVfnBJAKDfMEUKBmndgvFwoFx3Vz2R0FOPbkNNu9CLW9C4CmcMP/hUwqnjGl8/0FFtuisRmmIYT8eTuYpxAolkjl2PyB34dWCdU5USOrLaTtSA/G6ljF9I30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XhI1g9s+; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RrduIid3m1D0mEkz1T694pVV2FEwEWAHZNVCz1us3a6d63RTyqClkS3HXKu2mbKpJ3hHDbTpNYplpJqMg+DcsfSCpfPofiN6fD2/Hc8q2iwhZtO3QzoQmNMFvr9/EasSkQ0jJew0sqgE34jeVUmuTrROSIQwiiBe6r9C6aeDz2TLuUiVbaKkHaoqP8N005FiNJpWlgO6MykbwsVt6K7DNWW/ASEpuB0IDxQzIstbfg1JdVkVfgPfl6Hr0yR7r6egvEOTR5mKB4s5aeaujCYic2VDorwEMMInswgEEeEcFQ5v1sqhrQJylKGgielhrHS/cH+Joe+LP6IEMDwa5SZMWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GP9WM/Rr6ro+AJnwfXN9GuzTHxLJ1O2nwml2hVPKUb4=;
 b=xdX3lhiTZIHRYk3dxTHJg7wDsyx3xRe5Y/+jVzzzEba74dMFbpPxnDxv6gY3ERY39Hz+FInGA7qYbc6eT5O87ZbbgvCkGMsmw1jX+z4vsxxsfI96GyyNFrazVyj1hxX3CYFwBNoIg6LNr25sb5f/Priw+VKZ81ubgPvZmrtFDpifOtsK3oBt5QGqyl2rdJgvZITrtsLEJo1pdRnqAFmZi+d0X3FZ7/AOe8tm6aUeOrLdhykxDLerwRW3P/6vuFH/lk6iP7ofUMWj40VFaojdsI7JjKvwLdnH0QFx1WXs9wFkY8NPacDSJZxHhznlpQn0Zf9tAXdwVAO2XTEBEQGu9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GP9WM/Rr6ro+AJnwfXN9GuzTHxLJ1O2nwml2hVPKUb4=;
 b=XhI1g9s+/kGrB6v9+bX+uDSQTWUu1E5SBLdEzIqv+A2Ym0+v+0OGBnQLTxdT+GaarBl6ByPeGc+jt1Q3R412VFoeUOUdalsNZT+Toudn9S2I89RstM8qe1gLSr40TAj/YC5aU09V4Vu0GQTtyAw7LSIpl89twXUwlsP0qqlbgWjdlWvSxZc9cE0iWihnHrbXXSq4V2UlLQ6ZI67OoVbMUAedz6D2+1ze7zy2ZUrqXfLCxF0C5G4FA3iaVv0xBzWggC3crD6R2RQTK6L2rMVrHp3XSL/z3nj2yOOGldks9NxukiaH6psHoo9tjFiAib8uozkVslLlbWBgah5ovFGtdA==
Received: from BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11)
 by DM4PR11MB6526.namprd11.prod.outlook.com (2603:10b6:8:8d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 23 Aug
 2024 23:06:59 +0000
Received: from BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6]) by BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6%7]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 23:06:58 +0000
From: <Tristram.Ha@microchip.com>
To: <Woojung.Huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<olteanv@gmail.com>
CC: <pieter.van.trappen@cern.ch>, <o.rempel@pengutronix.de>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <marex@denx.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v5 0/2] net: dsa: microchip: Add KSZ8895/KSZ8864
 switch support
Thread-Topic: [PATCH net-next v5 0/2] net: dsa: microchip: Add KSZ8895/KSZ8864
 switch support
Thread-Index: Adr1sFbrci1dpjpITEuFvTjetQWXJg==
Date: Fri, 23 Aug 2024 23:06:58 +0000
Message-ID:
 <BYAPR11MB35580EA278E5373206F5CBC8EC882@BYAPR11MB3558.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3558:EE_|DM4PR11MB6526:EE_
x-ms-office365-filtering-correlation-id: 4ee92c20-5f72-4754-1cfa-08dcc3c84a36
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3558.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2uPRaP7zhAH5WllSIXlq7hdOn7O7efdDxVVlWIy3W5do6Jlmkx8VLr+4WW20?=
 =?us-ascii?Q?pdfOGvll22OBhdJn9NRpCoRwUQWxy1YwTPb6XFsxbVu10yu6vMmCzM3OAQhH?=
 =?us-ascii?Q?oDz1r4K51K89tWXQOseJWoDnU5WbVdcOjcs1Nd5mpIx7EhPmwRRD7Nmef4/m?=
 =?us-ascii?Q?lP4t3kEBbAvGZea08eKmNQVNDtSt3FLB04FhIg/CjhYHFbQkRZy3BPbrke/L?=
 =?us-ascii?Q?qKEKAdTAXAGlSJWHJxJWatazAmdzdgiDyHKMCHP4SOipdLfQXj6qiSKCapJr?=
 =?us-ascii?Q?J7jWGpl2iY5uv8ZZC+ztWPLM/JDbw+pp24QFn8VVwgzIsKJO/NcPVz0/Ggrw?=
 =?us-ascii?Q?Km9V/cu38SKA4bw0gOMTDY7+8smRHYNu+lcYe6jjqmi/QatrkgJif7V+u/j9?=
 =?us-ascii?Q?cEC7ZiTQ5OdUKQvTqHUX6dpyr8SY1hjrSHnDsKyL/4Z5miVq2QgekOrkkRMr?=
 =?us-ascii?Q?pubP7HH3kv7EZ7pOizFuK9WEQnms6vn+SnIU+pcTKv75IEyyJntFr7p/B6d/?=
 =?us-ascii?Q?9h8Y5VBkRzhVKSVFCUE7/2lmgRpoP/nlQL6YXcTP8wGO5r/YWqv1TVIrCDQx?=
 =?us-ascii?Q?B50MDN9vNzueEQ4tS3I2MNDxtcE0rcQuY+BHHYQuPddr10iobyU3/iLYF3qu?=
 =?us-ascii?Q?G+hyh1YZdGgbZv16bQJG87AOAbRaoDS8ZXjgOqRDRrZLW0+a5k0VByWDa9ob?=
 =?us-ascii?Q?Ri0fMVQDkidNymmTIb6UykVccKhhLHPh5vBTBYHTAHh/6c5jUU8/aqGoVSiI?=
 =?us-ascii?Q?rOjcCkVv9ZOV46PWqkyaB6+lYUXgoaHQdeHbQ8WEtWqPOghWKx0Yq/K4n1Kj?=
 =?us-ascii?Q?hG+2ifGaG8+DAQkeQ2Rb6tHuknTsIecu8d9AQg86/MP7Dc7wRgZ/O9qRwpN/?=
 =?us-ascii?Q?Si3+b798jijoQ86/EnagzqI2JW6jezLQG3U/LOMfGBwq6VmnL/ByxlGIRYBE?=
 =?us-ascii?Q?9zOynlB1kFIkEvFDa/mbgu6QZtYkwKp2eTHHKdkfHGn8K3eA8a5wIf1UpRIo?=
 =?us-ascii?Q?XTLTm131Nlx1V+W98anQQVXUfY0ZkmyxOO/kkYGqAxP9g/ldrRLnJukPSWXc?=
 =?us-ascii?Q?vk0hdI/RnONF+yItQIOi3RW8Ekk2xr+8ah0OlKFgthwyvPTlj7t+Gw84S5rj?=
 =?us-ascii?Q?swm8dQ7hK/GgdPeSUCMkBoIL+FchbRTCAivgIqzxShDgEqr4QE+5Z0UIvdQy?=
 =?us-ascii?Q?tk0dxhcMLXiA3LCqheV5o2vc6Nm4WlI5aSoiq1R/AObHjJ/clQfyz/keQY8W?=
 =?us-ascii?Q?/NFN350sK4AX2CcS7383PW4SOs+whDkJZge9hBs3Oas69EMPdpKGAFq7VahP?=
 =?us-ascii?Q?wiN9QpJjuEE0H2o1H133RWUHIXixFOERqXmT4nk0GBGEbjn+YLxCrwCwcP9y?=
 =?us-ascii?Q?zysW+6EH6he6+agc+V2dgGbxhr1YcwUgPy7jkEBbkJiU1vN09w=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ajKKpK/MsYnHf2LbRnFu3B/2dtII1aOvkSztBFoSWTM80IgcB8Od8baiL5Q+?=
 =?us-ascii?Q?dTlrPqteA6vB0HD1sOnJx+09nPT0xGgwhA2TM9iQLOzvUBtRwK3wgVwIfYf9?=
 =?us-ascii?Q?nDzMyzIfnXifRgP9bJMRil2OHCBAAr6Zp2aWOD4GrHUYABlfWAAkdDmjM/XH?=
 =?us-ascii?Q?Q7ytf9kgl463YnszAS3taQm4UJmSjlW7EGoXXmeJqU6KrkxG9FET6cfETXtf?=
 =?us-ascii?Q?ptvuoVPVj2CjyYkQtc2ha8n3ZnJQwUe3h69Z40lL2ZLgeIoeKDb0EdRcNxfh?=
 =?us-ascii?Q?AaFmgneXNYKWeGQlPq/GQ4NL/24zdnh8BoNxejgCPtwKPEmBtU/O0UcHR7RJ?=
 =?us-ascii?Q?A0PM5RCQKyYm5E8521BR1vgHYkJZ4Ib1B5J89AxtQTNAX/FIANenZ5QdDJtr?=
 =?us-ascii?Q?9XOoefjg+MK11m3ztAlI2WeVzTdgB4Ns4H8D1oalXLfwxswfE5+SZImocLPK?=
 =?us-ascii?Q?lr+2Jw3qAfHdZGed5TxiYzN1Gueck8jPYbfU4QlxukBZ/zOWX2SXJiCsoAY3?=
 =?us-ascii?Q?kFuPACI86d1mAywsCybn1Fwrtoz4YUATcMOK6MgPgZ9QRkCOdqFkH9qnbNoX?=
 =?us-ascii?Q?klwzW8aFBPdiZxhz/xvhq7lKrcrReuEPLEvjoYm98pmAo+1TItzYoFyrVjE5?=
 =?us-ascii?Q?Lon73vOJCPKI89vTwwJFGBI+OQDDSV25h9xLaMMYw5pZdHnRzkBbPNEmXhHE?=
 =?us-ascii?Q?tBDvlhgTDpbKKmQ33AmNgZRWWo4TjGOj+UEhrOkwzny+g7ymKUbnrXvV4cGN?=
 =?us-ascii?Q?Yg9DOGNIPtRAlyLGY5wv9S3ApzNBHzAKCM/vXNGTawNrK+xp0VLxtT66F/Er?=
 =?us-ascii?Q?RE+7MS8ztWB/jFM2ic/k+5eRvfFrRDpPBEfuoatyb2dzY7HlJBLW5DPx0fSy?=
 =?us-ascii?Q?MwUZ2MIYBrOQhrDPEINW3qaRjrnJ1lpfIn5l7LXsscp9NBy6QoahUJkHpQAE?=
 =?us-ascii?Q?WAXsc8eU9kytek8T2yz4Jg2Coq31jL3gvZW9eqbFxwRAe+HTiwSVz8AkEU0/?=
 =?us-ascii?Q?VMJI97Uzy2S7vTjmzVXTNI39jfDjXsKz1DNQJo1pcXIP3e+Vmzl3E2Mup8x3?=
 =?us-ascii?Q?MV2sJDqdzveg4Bw+ogOSedEDr2YaN6w0gt8k5wHKXMVnPKKE8HLu5H41e5jB?=
 =?us-ascii?Q?MXp8F//zq1N8Q7hXVXesI/jdbdS51kW8bP/Y/iR1IrdgU1rBKxAx64oI9vgi?=
 =?us-ascii?Q?Vdo12CP4tnitaFaMUH78ag4K6YutRasVjgMBt4891ScwkXJ/agn6fYU/VJXJ?=
 =?us-ascii?Q?7C55O2Q4BmgIN9wc3f0N2xdIYjkQXH54VarbTeQvjzmx55WyurNZG1KXC4Au?=
 =?us-ascii?Q?sl18Al3tqHsHmXxZnIXU4Ap1XQJvNHI7hedxwRXDIIygB8VUsh/07KDh63M7?=
 =?us-ascii?Q?2Yq2Sxxvst/Uij02LIZGYcujwoCfxLUNFdsUdLO7UadmcthvowbKo6Z7IzYt?=
 =?us-ascii?Q?IACDCULnZ6S0c3EQB7BVyPOkpmJRocKH4wOnLAZU5Pa4ro060sq0B1p/S/ML?=
 =?us-ascii?Q?dJ2xSWWbN+ym89q+J8PRGfIpJP2lFyqqtyFgq+PYFEqQzlmtM6oVuwNKPd8J?=
 =?us-ascii?Q?ic0bDvQhOz0iXTNZG48Yr08tzbEtLvErukwLmXgj?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee92c20-5f72-4754-1cfa-08dcc3c84a36
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 23:06:58.5249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p06iyrzmw+FBzX4oJzk6MNY6QFjJ0clj0uSSU7LrQuQrmwnY8AuaiCT/zMPon0HWtHhKhtBCbPXS550MdgSn9oIf3kw/Iv+N+9uB1G9ZGv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6526

This series of patches is to add KSZ8895/KSZ8864 switch support to the
KSZ DSA driver.

v5
- Update with Pieter's suggestion
- Rebase with updated commit

v4
- Update with Paolo's suggestion
- Sort KSZ8864 and KSZ8895 behind KSZ8863

v3
- Correct microchip,ksz.yaml to pass yamllint check

v2
- Add maintainers for devicetree

Tristram Ha (2):
  dt-bindings: net: dsa: microchip: Add KSZ8895/KSZ8864 switch support
  net: dsa: microchip: Add KSZ8895/KSZ8864 switch support

 .../bindings/net/dsa/microchip,ksz.yaml       |   2 +
 drivers/net/dsa/microchip/ksz8795.c           |  16 ++-
 drivers/net/dsa/microchip/ksz_common.c        | 134 +++++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.h        |  25 +++-
 drivers/net/dsa/microchip/ksz_dcb.c           |   2 +-
 drivers/net/dsa/microchip/ksz_spi.c           |  15 +-
 include/linux/platform_data/microchip-ksz.h   |   2 +
 7 files changed, 180 insertions(+), 16 deletions(-)

--=20
2.34.1


