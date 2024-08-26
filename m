Return-Path: <netdev+bounces-122056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4B395FBE3
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 23:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0021C1C21E0F
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 21:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BE019B3C7;
	Mon, 26 Aug 2024 21:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="32n9QfQN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9419C7F7FC;
	Mon, 26 Aug 2024 21:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708589; cv=fail; b=uFIPZ25G/heDRheMaKgkYD1KCOROu2EUDje3NQKfk3y0RG33Y/d9SE3KoYKi+1XzslGuaNa87fsyHTo0kmKKiCE+9A3Yze3YN7Ii+qZfOxwA/4EgkoAxaXGeRXj0GAk31GUG9bomiF/EVc5kZHiuWj3loUS7u0fcrQJVtP/GOsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708589; c=relaxed/simple;
	bh=jlGN3eqf2abyFDSDg2YrYBBLZ7sODfHqwdDUfCHaeKE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DmU+AGzHh+Kz/gGX5i7xuU5WgTNFjS5OEwrV5N2PRBjLVcdK5OvNyZnPp4yC/8H99cRSX/dwNby9AZs/5fGTDwbCVxcBRb26rmmP3Vt80sLeaE+u815WoyZ9G/tuRhqi3CaN/l4TcZoPenoEoG7JJRn27O2jdntjwGCvs/OgT5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=32n9QfQN; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abWzAWf5YQMV9mnAAMu9zbUzwExMdzU0qkFJ58Op8pwivxyhMgv9WXbdwI+B+Vaqi1U3ooeT5Xegw3A+QG5eKuFdXvYE68MLU3ob6i13+KCGsv9u0/CEOQZXVzJGE37CR/2d859DWrOH5G/ohhesHk0YLo04tVNsg8EsTu2vMQ1rzSUqCy6JHYe5o7TiZYw6tKfqBjiWj/bMc8FyucdqsM9WBL0tP/TsiO8b2iWhpIE1jGBrVi+CNuVY84I/whk03BsKItM0OvOn/fKEiVF7UC41gWswWVWOEVoO6gT8vkHeRHNoXxNAJdzq3+ZlB1u4h10zhTu9FmaVeV3044eb6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fs8usUBk3xlrhpF0Qt3W4BydqKs610ikyIUzz5rM06s=;
 b=IeiOMKvF/UenTlL3Dk+NtYC4Nm9FyEz2zzjMSXbMeIvucrPle7UUnPTu7W/be1yZ2M5UxadiRFu9ioz8fwyhhFaVO4VBdplI5BEi8npLZ8S5jKXq0xE2cX6km80ncxX36+FLHQ0NWInm3PvE9L8ZbImIZ4r5lTJQF7/pL+pfpOxtNlaGsSfFdM42LmAYStPOhdWA1erxB/8LqiBfzLgJzxbjy81/heCRVcr70zGcDjkElwYWpgwUlqR1J3R8St1Q2bKyPc5PXwKBiKdB9JEt73wG75oVrmVCyIm8YjAFCpuMFme2rBCpMfXOJDYIhYfthdj30c5Q7UIXBn4VUTN9Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fs8usUBk3xlrhpF0Qt3W4BydqKs610ikyIUzz5rM06s=;
 b=32n9QfQNNPXF++UWygPMcn9CPxHRNq2OKvZlw4PozVvEYi0ER+rh7dkNPvgDn49YVTu1nksbV1gZBu4d7m/eahmK0YZ5GKfL9DIQfNvMIn4eppy9e2wZhrCbkxiwNRiNV5p4Qq3vB6z638HxuNMf/sE0kMw7RS5QwFDexNYiTkRDcYXCgffabFpv6HFmfrsIbfJ5wu7Fuo1lcJ1WwLpgFtvkidkYB45piC9YhMRAWGk1wgPYw1t91wwrBH2JIvIOYDjzgWErmJFhqjXygCeSW1HGxaY4VTcjn1Zu2+UtT28L+n5uAg7gpiZh2pwX8Jr9ydXN8luuHZHRHwHxsboT/A==
Received: from BYAPR11MB3558.namprd11.prod.outlook.com (2603:10b6:a03:b3::11)
 by PH7PR11MB7449.namprd11.prod.outlook.com (2603:10b6:510:27a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Mon, 26 Aug
 2024 21:43:02 +0000
Received: from BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6]) by BYAPR11MB3558.namprd11.prod.outlook.com
 ([fe80::c03a:b12:f801:d3f6%7]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 21:43:02 +0000
From: <Tristram.Ha@microchip.com>
To: <Woojung.Huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<olteanv@gmail.com>
CC: <o.rempel@pengutronix.de>, <pieter.van.trappen@cern.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <marex@denx.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v6 0/2] net: dsa: microchip: Add KSZ8895/KSZ8864
 switch support
Thread-Topic: [PATCH net-next v6 0/2] net: dsa: microchip: Add KSZ8895/KSZ8864
 switch support
Thread-Index: AQHa+ABy9CsPos4bfEa9QpAdSmGNyg==
Date: Mon, 26 Aug 2024 21:43:02 +0000
Message-ID:
 <BYAPR11MB3558B8A089C88DFFFC09B067EC8B2@BYAPR11MB3558.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3558:EE_|PH7PR11MB7449:EE_
x-ms-office365-filtering-correlation-id: cad1fdb4-023c-4e09-5207-08dcc6180fd5
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3558.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?NEWLfExjKo+lHA1aK4+8c5yZitDLuKlZolVzwSrpVEc9mga56BOKdvhtoz?=
 =?iso-8859-1?Q?nAPtO4wNtoVFxRqWc0j8v+E99zlHAHfAV9G8EUfVvId3tv35El84wINqIw?=
 =?iso-8859-1?Q?9O9u2EoAT7//cwPs5OhD5cAwQp314zdNhkJ/DmfKUkN6l6KIZ6CvHYxWSp?=
 =?iso-8859-1?Q?jAJtbYKDD75ZXNrkLto1bx5j/h6x2eb0qDx2gqwCaQIrSEUmWpv4p6Oi0p?=
 =?iso-8859-1?Q?MhrWymooVGMtGITVnHVe/p1IbDPmJzsYbTKFqZRyLyt62JIh8Qxm+J+cqu?=
 =?iso-8859-1?Q?xAe5Fdw7NxU7xKaMnVLzSeq/K/PgbxAh7pIAfaWPwcvNdkY/NLcwNK1f68?=
 =?iso-8859-1?Q?hvR3e2x3B/SdfDqxrb37+uSCE/F/U063kqTZugIeOeCGL1XPAknykzdLk7?=
 =?iso-8859-1?Q?X8ciA9oNuDq+62xNYjH+BAFLtCbUB8VpI3GMAyKmyVjqK52akUcvQe+Nsh?=
 =?iso-8859-1?Q?R7zgHt6obywfyVLFngUrD/gYJyAMf3+RbIgEWyRFfC3l6J4eY8JsS25Bio?=
 =?iso-8859-1?Q?XaAy31i6uVeMuYWIMBS71nSruInXgy4WkKnyOZz2s/IWvX2870RvT7Ax+v?=
 =?iso-8859-1?Q?Zs9VNG9ZhIPcWue52K/CYAS1SguPXjqx1HRmwjQAxm2wviLPNPviJFEvWH?=
 =?iso-8859-1?Q?mDWddAA+QcEpv0oKWAtZ2X+aS9mWzxlu+UuRy09EO5STpwa5G4qCdLW17m?=
 =?iso-8859-1?Q?5rabZTVl6PNCzPzSlQwLqln2UoRoxqFvTGgFEJXFRAHCeaJFJr0oMA/HuW?=
 =?iso-8859-1?Q?WOfCv8IpM1sKsD/kBKKouqK/L+yOCX+iWV7iOo716GJaKiK4repkvNabao?=
 =?iso-8859-1?Q?bo/PJ/rY/8sZzlgF38E5Zgt3UDzmiOsmEzbc1jjVwt5VHzlFXDwxnX1cvB?=
 =?iso-8859-1?Q?sTXdbXJY0AcM2D9V571g2GW2Or1XZeGYR4Ht7Z1SpIlGYp067epuOfRD8F?=
 =?iso-8859-1?Q?ykd0sQ5FPlXJ55jvwPNPGIt7bztS2/BnEnVJbzFGqXVjq5iMYbDseLW2Gc?=
 =?iso-8859-1?Q?eltqAp9ewKvfh/Jex44QALVyqEITprELGuBos+rAiy++z1asziPEVS6IVW?=
 =?iso-8859-1?Q?81p5r6D5EKs0l18bg3P7tNPt4N37rMrLpRui4lykRmJjXyNpnit1MXpbqI?=
 =?iso-8859-1?Q?aTUJlyZfvqGLDcCDnXzN4Y08uFVVgL6qKj55j24mm4j2hr1Km1tfY0F6Mo?=
 =?iso-8859-1?Q?mNXuRj9t1WB80jwnLQVJ5isYHcuGnLfZPautSL1BasurchfWC4piygl9/3?=
 =?iso-8859-1?Q?WRo9WwHElRMn5906bp9ozMx9lF8Zu0HAjYqKo5uuprDqBvMxNSFvMdFvPM?=
 =?iso-8859-1?Q?NmVNNh+Y/hHTgmMqjvzARPWbSkGJ2SuNBh1pbGg0b8iXNbmROQh662XWsh?=
 =?iso-8859-1?Q?32GWYxuq+UnDiEmJ9PgkI85RLjyHWFbhVTb5yzxbRswKD6jqSK03fibonT?=
 =?iso-8859-1?Q?YjP4mTwolIy21V4J3FjUejCtpB3DK6fi8tLnUw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?5632AH2vzdCtRM+9mf7qL/hjX2YMqwLB3WK8gm1KXQ5VPu/eLuwV6AN8VR?=
 =?iso-8859-1?Q?6HTeevJ/6tKTNyx+fXIrp0j6RJwML5p6pal13BWgwbYiiwO3+nPlR/q0rP?=
 =?iso-8859-1?Q?8HQULh3ID7K6pBVKM6YpkP6IkSR3JSfVJeHpY7OwOhw504ICfNsDUtk6cC?=
 =?iso-8859-1?Q?+bJsQXSvPwUXuDFlOslJAGI3Bk3wfl/8bl+JBrUGjVoz0doCWhXeZqLCUg?=
 =?iso-8859-1?Q?iZIdgKJNDuOdfqleTuf1pSK8hVZrDgApjbNd11T3SwX8BtRGFH5wBlQiNu?=
 =?iso-8859-1?Q?qOCrVgnR1DA+MuG22mrVg9Xv8j5ZEh1aORzMH5eUdjPr6cQGUzCHoXA6PN?=
 =?iso-8859-1?Q?5Y7WSzw318+z8WX9F/IzScE2lpQbCFIyuAppzLMQnrW5/4M0u6WKVXxFDq?=
 =?iso-8859-1?Q?Jw/WZ50NVVUqZbIi65uv7gTLCmTj8RvR7HDmXBItgqkXggC22gvciQpp6z?=
 =?iso-8859-1?Q?YY3Pw8aqyhEwkeNsHpMJ86uw1yicIUFTrLh7j0To1xhWmP+cixZi7T0fSZ?=
 =?iso-8859-1?Q?x85sa1b9m7ZSv1w+Y0aSs37ZRlkrHDfCCMXNrDNH9sKq7zGUlGCtad4SA4?=
 =?iso-8859-1?Q?L2VXj7m257vmn/l/jdDce9ZC9QGyvuSCbCzEon/Ae3VJZ5Zj1QSJa9GpJA?=
 =?iso-8859-1?Q?6RTVYmT3PFIs/skti8lbDB7LijB1yiF1penQwsLvskJ8LCQUN/FCyp5/Q5?=
 =?iso-8859-1?Q?fVfMwqswfDMwCuCvh04BxJJLjKPG1+svtwS3rIudu5Wg0s1xG5pYw6reqi?=
 =?iso-8859-1?Q?BWlPbKY5C14RXYgFQ9wBcemKxDlcNAdIlJbn3azYeuoBUdn29Fea4u9Pyi?=
 =?iso-8859-1?Q?rIma/w548s9+DosMgS5a0hmvDCDcJNvTwKTW+KifZVJresivfd+Fg9wUp0?=
 =?iso-8859-1?Q?HGeDtIjZOEAgWQ5FZuS956cuFHWNfQL+L5JFnWXIbHnv5gB0TGs9/ev3Yp?=
 =?iso-8859-1?Q?jd4T4mB0ZXeY+5Mr8Fw4+z7T1S5g2m4/CElrJpi12aPlFPW0nj/N35ijE6?=
 =?iso-8859-1?Q?aOzwk3rWb//OhsT3c2QO6Papm+tCpQkY/HgAqsHe/g3TeqcSs8w2bhNusj?=
 =?iso-8859-1?Q?wo3fcBNjhQT6vyKDweQMH/KILCmLggPFBTgwEYDlwnICSI0//MVwez2Pub?=
 =?iso-8859-1?Q?6jdEtrIS8uZ6Cb8fNvh2kR8JBE6/vYpNi9KTaRXR8SpKB02IIDgX0c6733?=
 =?iso-8859-1?Q?SatK1plV0/zZm+jBjmpD/X70FhSJCUAuvKooziW4LFbzli5zJTcyvpzCPU?=
 =?iso-8859-1?Q?CYOs8Z3kijJnUxfxOMK+o9heitjoTHs23EX0N9iZ3r6PRLF/FQEuC+ao70?=
 =?iso-8859-1?Q?bna4YOd+lrZvveLm5IlaJiZ+3EomjNfL+LRAGIyECBQEWxx1ZMyd2K0OxE?=
 =?iso-8859-1?Q?FZhMuRpJP0fieLHrYCkTHyFNeFMCasA+Xkr5rS2M6N1C1aF2Tig+CUJODX?=
 =?iso-8859-1?Q?p2TH95RPvGvUzuAt5QC8gn812lP5jB7ErLJ60MMzMPBNYa/FCQ9ft/uzcC?=
 =?iso-8859-1?Q?Wl3rKnTVw7H4sWxCJ20fb97V4hqu5NfvJHHU62mAGxy2NyxdSYGVadzqmx?=
 =?iso-8859-1?Q?yI+6HIjEvJ8JF1nyNmvtSd/A5xkw4UMjxaQKtPKSvDIY76ZOfquUrjFw5M?=
 =?iso-8859-1?Q?0Ee6FCGG4UYDDYLxdFvQlIP6MV1kCEixkAaLVf9hazOxRWD8wHrHB/vdEK?=
 =?iso-8859-1?Q?mJVq4CujAtlI6vzJTL9zAdbo9u0otSzzwCUhn1cj?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cad1fdb4-023c-4e09-5207-08dcc6180fd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 21:43:02.6626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K/AGtY0ZQLz0C6okdVmxi5C7HRoWSfTp9JeHh0SnU7UQCr93ihMi0zaui0q8CWsbcuQX69TB/ybYmsIScJ5j57SW4RbvNuORphVsLOFsFPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7449

From: Tristram Ha <tristram.ha@microchip.com>=0A=
=0A=
This series of patches is to add KSZ8895/KSZ8864 switch support to the=0A=
KSZ DSA driver.=0A=
=0A=
v6=0A=
- Add reviews of Pieter and Oleksij=0A=
=0A=
v5=0A=
- Update with Pieter's suggestion=0A=
- Rebase with updated commit=0A=
=0A=
v4=0A=
- Update with Paolo's suggestion=0A=
- Sort KSZ8864 and KSZ8895 behind KSZ8863=0A=
=0A=
v3=0A=
- Correct microchip,ksz.yaml to pass yamllint check=0A=
=0A=
v2=0A=
- Add maintainers for devicetree=0A=
=0A=
Tristram Ha (2):=0A=
  dt-bindings: net: dsa: microchip: Add KSZ8895/KSZ8864 switch support=0A=
  net: dsa: microchip: Add KSZ8895/KSZ8864 switch support=0A=
=0A=
 .../bindings/net/dsa/microchip,ksz.yaml       |   2 +=0A=
 drivers/net/dsa/microchip/ksz8795.c           |  16 ++-=0A=
 drivers/net/dsa/microchip/ksz_common.c        | 134 +++++++++++++++++-=0A=
 drivers/net/dsa/microchip/ksz_common.h        |  25 +++-=0A=
 drivers/net/dsa/microchip/ksz_dcb.c           |   2 +-=0A=
 drivers/net/dsa/microchip/ksz_spi.c           |  15 +-=0A=
 include/linux/platform_data/microchip-ksz.h   |   2 +=0A=
 7 files changed, 180 insertions(+), 16 deletions(-)=0A=
=0A=
-- =0A=
2.34.1=0A=

