Return-Path: <netdev+bounces-183242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A18CDA8B71B
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F7C74448B1
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41AF239591;
	Wed, 16 Apr 2025 10:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b="jx1YSpEe"
X-Original-To: netdev@vger.kernel.org
Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazon11020139.outbound.protection.outlook.com [52.101.169.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EF6235345;
	Wed, 16 Apr 2025 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.169.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744800442; cv=fail; b=TzrP++cYfxwG6nuFhwMjDz8wcRfu6L2CpdgdCJxdXskd9hzGpetNNffGFwG6qb+bgqMTR7Xs470SqLuGSObWCNVH+CzaKdZjX3TEZyl+qasHUWPkBI+S/Gza8W6Rn+aIZM12I87DhiDyxlzeQNfTcRysu2/tpokrP5+sfPBZBWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744800442; c=relaxed/simple;
	bh=4xiPMB54SDTdqdqTvgt+00W1pw03lBUgCaevgQIT9Ws=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tt9PvBjPMrtJmM8bGizs139aUi5556EvM0DQ0Dchp1aYvEW6Gx8jDCPDoH+3mpQn74S5BBZfWAjg6gX4ScIwwU1sE0f12ZOd9CdKQP45g9NAA7ctlZzlvPFAftsRkliuhdbnbA4kY4Nq+ZpTs9zAQ/vywDRLb3DhXP9Qrz5+sNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com; spf=pass smtp.mailfrom=adtran.com; dkim=pass (1024-bit key) header.d=adtran.com header.i=@adtran.com header.b=jx1YSpEe; arc=fail smtp.client-ip=52.101.169.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=adtran.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adtran.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VEMfRlIWOwn8qyOcRy0q3Ln2r3Uxzm42JNdYYcLx6uWQpFPj7fCEqkQivxlGW5chF6o1c2JzRfJZ0B+5TZbwUls9dt2kMEkEoZ44MOMWePtBcsa07q8YY2EzsVz4dS/RuR2DG8fSvKBiPvhTchUf6voBGmwtD4WAtxleFG6d2A4fUGQbBHnRbA8xz6sOXcmsnUjdoOvp2F8bFF8LNmzVs9cJyngxU8zp8/0M/2tDRax1/zs4mRd11KounjhTOqcLdXg5tANa+JKZ+70I7YccOlA0sPLXPTlT35kIHb/4Lej1aHOyu5Ug4HyYdUTYFfWbSz+OtKBZg6Yp5zsR0jWotQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtKjkapr06EkF+wokJTqjpf8AyKqu60Hz71hBqIKzrY=;
 b=eqYhHl6TufsLTR5I6bc/8cegBQAgcvpOTQjsyytRdJh8WqLLYqzkOdMP0PBofnTxU/gIWkQdnTPDLrkEZAQAj3+5Y6UDVjuOTpAVBruDPcF/s6D2r77+1+U7f9uDI+xl5cJXM9+TuS0nqLdI8MWRDjC9T+CWEamcJVS1sQCGv86uMFxtjm4b1EYtp5Hc94P0W9qMgDYe7gkEHwbiVg+OCDr6N8PYjRggPgLGiUJOdvwbHVUSh42DK75Ahk6wNWKyc8pcSt/i9XbStOBPf86kaBOjKKZJudV5kMdszXm+mN+kEnZJk/9nC2U1jxx6EZs6z3c0Tmj4uxwVOxP36J2ukg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=adtran.com; dmarc=pass action=none header.from=adtran.com;
 dkim=pass header.d=adtran.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adtran.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtKjkapr06EkF+wokJTqjpf8AyKqu60Hz71hBqIKzrY=;
 b=jx1YSpEeU3tc/xiABJWDd/o5Di9j0BVotbHab5qJmNxGJx9CCGyRmJ4KYfqpYgC8llduD7nFZEkOa1H/hXboNeWfzUosCNiKeErWI/j9sBiR+LHE+EWr7Ch/h/SSa+a33vS79gUsoF/LuPbKTLh8ZtpRO1oeQConeTGNAIVUq8E=
Received: from FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:43::5) by
 FR4P281MB4404.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:122::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.22; Wed, 16 Apr 2025 10:47:12 +0000
Received: from FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8232:294d:6d45:7192]) by FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8232:294d:6d45:7192%5]) with mapi id 15.20.8655.022; Wed, 16 Apr 2025
 10:47:12 +0000
From: Piotr Kubik <piotr.kubik@adtran.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Kory Maincent
	<kory.maincent@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Add Si3474 PSE controller driver
Thread-Topic: [PATCH 0/2] Add Si3474 PSE controller driver
Thread-Index: AQHbrrvjSWutWTTyyUq4wzGUDmBh1g==
Date: Wed, 16 Apr 2025 10:47:12 +0000
Message-ID: <a92be603-7ad4-4dd3-b083-548658a4448a@adtran.com>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_efd483ac-a851-46ce-a312-07532d9c36b0_Enabled=True;MSIP_Label_efd483ac-a851-46ce-a312-07532d9c36b0_SiteId=423946e4-28c0-4deb-904c-a4a4b174fb3f;MSIP_Label_efd483ac-a851-46ce-a312-07532d9c36b0_SetDate=2025-04-16T10:47:11.820Z;MSIP_Label_efd483ac-a851-46ce-a312-07532d9c36b0_Name=General
 Business;MSIP_Label_efd483ac-a851-46ce-a312-07532d9c36b0_ContentBits=0;MSIP_Label_efd483ac-a851-46ce-a312-07532d9c36b0_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=adtran.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FRYP281MB2224:EE_|FR4P281MB4404:EE_
x-ms-office365-filtering-correlation-id: 1da9700e-8711-4f5e-9120-08dd7cd40b46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?7CN/1dJ66OEwgiYbodhaBGV+y3DkqvZgfUYYKuppzMXMdxlrbMC0wfN2lR?=
 =?iso-8859-2?Q?eqtlRkg+tiar/1rtXZ9WUAbD9B4evpzlQlYejxigrNsVYTJbxTqvborrbq?=
 =?iso-8859-2?Q?pBdTBCkVBKzO91gwzrnGUo/gB2L89ZzlvOXav5GufHbVY6R8cvJ8g33bvK?=
 =?iso-8859-2?Q?1cO+sOc2fvZzWDLXXx2nR/cWJZNhtVBQJm7PHgJnP/qYDpHqSyq16eC6sX?=
 =?iso-8859-2?Q?gH2WRjYRo6bdvMqlGPXYUTlZqFve5ummTva5ty9VtU250EngqViUN4jP2n?=
 =?iso-8859-2?Q?joiIcFpKNNIOCN/7xd2h6vea8ScFn16FCmdAuVFQOO5k0+OqKwm8nX6uyS?=
 =?iso-8859-2?Q?EGrW2VLGvHoTO5c5afLiCSXYT5iBmpsZUPmpGqTsp8fUJuuYX8h3K4N8c7?=
 =?iso-8859-2?Q?+CG474r4ZcL0zHSiVxnr55CUmoGrGfJYDeXXchCharxArg7vd1XGwZxUO8?=
 =?iso-8859-2?Q?mLwNrH+qutzyKFkfAeHtPT67EJSjV32mj0yfnCW7VmtLdCIptswqbKyG7p?=
 =?iso-8859-2?Q?TuBosoFEv11uz4Eurk4LnfpwQ4TrEzbqC1Wy4AlSwrOiNGoPSWVLJrAO8b?=
 =?iso-8859-2?Q?cXKQd74cOdAc1ysncMGYLAMMdGtX8kOj204a7xDqNtM7aUycrMnU4e87mP?=
 =?iso-8859-2?Q?BAVpVL9fboRSUHAdE9Ylvm8pGc1bZ2UwHKoXzk1p48/UpQsXIK8treuMNo?=
 =?iso-8859-2?Q?87fZK+EMpyX2fcVdNTCiX099AAHBH/buvgsYleWRHbISHVYN+i3ZrtwEzq?=
 =?iso-8859-2?Q?Umn/UKm/l42wVPYWKVZ2ubKLFzehFbTrAGEl7xRwpea9OQL+q2ynOgbWO4?=
 =?iso-8859-2?Q?KFck2aKJ8UAs9suTePolE7AspDTWgnMf/TNVXouHltcPswGluGalxazXgH?=
 =?iso-8859-2?Q?NU7AdlLHzZwHsccBb4s3IZ54qFklf06fiqvpOAqFvYz+lyUkWDx71aR8K9?=
 =?iso-8859-2?Q?n906FDdA9dRGc3qxxZHiYoGIRgJoXsh+GMd1JN3/FR+LzdzCEbZhpiVc3D?=
 =?iso-8859-2?Q?99yXWZwjO3/kfG/wth8vKbfffyApf00LmOOmvqYhkAWzAyAXhJIr7BUxxb?=
 =?iso-8859-2?Q?Dy8EYxEzNgG6CqeEbZNS2ch06RyNXwjyd2WM807q5McDunCTZPk4H6PSh7?=
 =?iso-8859-2?Q?b6Kwy1tiE9ocY4Ml4THs0rGU+2xxsx0djVVonbSCtAm9Kk8KCu4lJB9FzX?=
 =?iso-8859-2?Q?cDmpFqgTuJQNePov+fIlMBDgolwJfzq5qXmlHzZ9u5BJ29k98ZpdSVIl5V?=
 =?iso-8859-2?Q?17hDdF4dzK06UrelrKQApLa0Tgf+RKsPTHKTaf0uPYJROYr3TIuHRz5//x?=
 =?iso-8859-2?Q?ptI13b09ZLuYS3uXaKRtamMCgaz0DJ8ZkHK7vHvlfhnWvMVdpLq8DnRNiA?=
 =?iso-8859-2?Q?eC6MMagj8e8ESvy1sNy2eeOBuQ4vKy2/p413y6ufb+cPytHnaY4OBZeo7C?=
 =?iso-8859-2?Q?UX3kIgsUq1VsYsNy/njBPgIMprcSR2GkyoA7VNHAgjbzUwLLvBI2axJo79?=
 =?iso-8859-2?Q?88Y6ocWhPLPj+QADcDY+eC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?Vx7vZtlLfGH5wA9akOxAB7JOkEozpIO+tlJo8nmYdfYjRSdKDjE+488N5Z?=
 =?iso-8859-2?Q?GFUBXEdPFeoW0trFa+IU0bbWDuFvpLZaLFatjPmtK9TQ7Ci/ocd6lfSopS?=
 =?iso-8859-2?Q?1DmKe0ImBkYD8LXzgGCgQp2AEx+O1vHetm5URJItWe+dHmsU0ClL3ue56O?=
 =?iso-8859-2?Q?3k25pL+iNOcm69sA7aWAKT00WwQWvYGUxKxSqSJeQhuUZ/CaEw3nTZy39l?=
 =?iso-8859-2?Q?FokR7yMUNVBhg1nRty86TRzC/gA0JfPmFuWoBMIBf/dh7QzMPUxtEXUf1t?=
 =?iso-8859-2?Q?8Eudnht0agbYbiYX2IeFXi00iOJXRRbgc+rsVUzj77M6yL19fnpa/USbY8?=
 =?iso-8859-2?Q?GgFBbFLCAzgc6JEDlGGH4+YsptePYnRWLnKd6XyInmGLNeG4AyqDGxKpYN?=
 =?iso-8859-2?Q?L/rkGmlz4N9tjwT/qsWPUxDSLmLdSG2Iw1mcEFu+xc9Ay4Ev/JRk2S5USG?=
 =?iso-8859-2?Q?2PBDv03UpIl9E1RZ5DlCcpNzHX3X+dIg8Rs1yuLwCmNoEf8t3IWw2cUYzG?=
 =?iso-8859-2?Q?bjZG/8gky3cuNzA9k5blKde4M4k1zd1FsjX6SaesspKtOvYpzclGjfFFef?=
 =?iso-8859-2?Q?hE93mAKQp9CkA5PWuSm7Yw0yI3W2HqEWvhe7iZv2TXlsiM2rItje4lVV3U?=
 =?iso-8859-2?Q?ZjQuwoc8ALq+P1YQ8oXPYir+n0Yn/pCOA9gIB97LfM/nL1MT+ZQ+LLqn0N?=
 =?iso-8859-2?Q?KWEYPRJPAqZWD/1OjzzE8OAeRi9hY3eCL8r+zRqZydbeMaHz7eQWN0tL1s?=
 =?iso-8859-2?Q?sYQnQHTt+i4D+pEpUOkycEBO0uSPqyrHEsJ9idp8Q4hhgnhmHHHca1XFs1?=
 =?iso-8859-2?Q?bEb4khIdVpUd0TAgKgFBjFV6lPiFx5vgAQPzsT6rMQn5cLAoNfJ2FG2CET?=
 =?iso-8859-2?Q?FL4vhSb1VlGQRWj747EovNIZvxcdTBDRlDSgcc8rfEfGNRBaWxtq1DjMat?=
 =?iso-8859-2?Q?16DoNK2O77HIISi/JEC1YowHpbvnQCPUMPvMSb2M2B8w+poU7KAjzF2n1F?=
 =?iso-8859-2?Q?Hwud5/Js1F8PCyYfG7l7ME/wc66cvI8y/A2gEboH9aDwMiemloiy47YZOE?=
 =?iso-8859-2?Q?fCpZkz7p/IKhVi5GYZMgKr0xLUaUquSQDbJuT9wX9ZXvarlH2u0pMM5k9h?=
 =?iso-8859-2?Q?+CTsNOj8Xb73k/Eh2qaRqw1TihkBbuths8bvMUgaDRp9/LAi5IBTwUh9w2?=
 =?iso-8859-2?Q?QanvGx7H+vRZ6X2Vh19hOqU37K22HBk/AFc9TT/85NGTLJjj9cN0wYbX1X?=
 =?iso-8859-2?Q?qLbLC4/UewAm1w7IbRMZbXw3Uyy8A9bmFxR/Q+2j+38yX09Q+igUH6j5TB?=
 =?iso-8859-2?Q?ZMMewircwsJ0GP4rKkYTPplxzYt2nwBH/Uoz3Bnhe4Mn7aHBrkxSiGgtAg?=
 =?iso-8859-2?Q?HlHTVF/mu498TjjXvBfx79rsEfjgJuI6I+xDUQdTohm0D9/VJJOey15vn8?=
 =?iso-8859-2?Q?1Ha0mvzIM77Oe9CQJNXE3i0LcUobBAVdubHc8Q0l396Ekc6viKfMoAbvz+?=
 =?iso-8859-2?Q?nM0zbIcQxW65Rovt9VzjgiMVXoNVAhKilwiB2Nobxjsb6JyHOUEuegMmhb?=
 =?iso-8859-2?Q?DoTqivhj7W8LnCFgp22o7tWPthzb2crFymuHRp+nbqW0UA1KRIS9pxiCj2?=
 =?iso-8859-2?Q?024ExmmIKn2MIIy/2aT9fLWIUz/uysowPj?=
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <FD735B146DC5814E83BC7ED77581DC92@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: adtran.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRYP281MB2224.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da9700e-8711-4f5e-9120-08dd7cd40b46
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 10:47:12.0457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 423946e4-28c0-4deb-904c-a4a4b174fb3f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Iiw4lrWnx8UIV9kTeDTPiTxCrgFvqXHP2WKUOXAm06CxgPl8rtxbPjbT+xPfz5H8IwFcqiti6FUA7ooEFYqrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB4404

From: Piotr Kubik <piotr.kubik@adtran.com>

These patch series provide support for Skyworks Si3474 I2C Power
Sourcing Equipment controller.

Based on the TPS23881 driver code.

Supported features of Si3474:
- get port status,
- get port power,
- get port voltage,
- enable/disable port power


Signed-off-by: Piotr Kubik <piotr.kubik@adtran.com>
---
Piotr Kubik (2):
  net: pse-pd: Add Si3474 PSE controller driver
  dt-bindings: net: pse-pd: Add bindings for Si3474 PSE controller

 .../bindings/net/pse-pd/skyworks,si3474.yaml  | 154 ++++++
 drivers/net/pse-pd/Kconfig                    |  10 +
 drivers/net/pse-pd/Makefile                   |   1 +
 drivers/net/pse-pd/si3474.c                   | 477 ++++++++++++++++++
 4 files changed, 642 insertions(+)
 create mode 100644
Documentation/devicetree/bindings/net/pse-pd/skyworks,si3474.yaml
 create mode 100644 drivers/net/pse-pd/si3474.c

--
2.43.0

Piotr Kubik

piotr.kubik@adtran.com
www.adtran.com

General Business

