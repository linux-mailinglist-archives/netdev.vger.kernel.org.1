Return-Path: <netdev+bounces-233709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2937DC177DC
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10A974E06BE
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DCE1EF09B;
	Wed, 29 Oct 2025 00:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="amcqvgxw"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012009.outbound.protection.outlook.com [52.101.66.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2181EB9E3;
	Wed, 29 Oct 2025 00:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761696800; cv=fail; b=h1PY0b6MMo2ySytUqXPf+hkMR7JpY2MzyZno7EBEEy8bENTGxzq3o6QSWYi0Eze2ivg28R9Zn9XCOIHOQPgHi4nDU2K/BLMm961guyodFR9uHqds1kzX5okufYefNmwkYAYXpnZ+pW1LREw/HhkKJe3xCGnYElMtrXe/EJi48As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761696800; c=relaxed/simple;
	bh=OM1DGvNQjIKqqiQrrXStUkjdoqKKlbIKClqfqM8ZBnE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OYvlIBWG/ZKlwkZAOGu+NozfVXjut20XC/sXCBms1Dx3m5e2Fv9gQcMDZ23F5iNLnVJk1fFZG+rgru7Yza2Vn1P5K/mpg+Gd+CrPpnQHJmTR9rWBQCaBhSFY+dC/lm5gEnq5HY7UE2L6KgokZdUaRDwvoVigxt+FcUMbE1bRe08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=amcqvgxw; arc=fail smtp.client-ip=52.101.66.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/67IO+VPCkgNqL72hGk3kCO0ythxBreZ621HX385zDeAt2o0wWBRDTZzeq6jia5aXQmOXHAw7fHqw4GpAmeIQrclPzD0f43GLFd29pL5IWZ9Yx6EKAWF5fT+Voo99NpVTgK5hraOJ/0nb4q5tnlbsG8v/eMBZ/hHzhqhlvgKGqaNRNOIYQ2mxIgxQLINqwyiMRTPs5QMXbPQ9SY4yv40AkcXFDLM6IKs9hOhk1HZw15R55wGhFrMYxenirWT51z5kGlb9eQfSuxKUz1Nv98hFkDjAGImzgyM/kMSNgZmNV978jgydxjnvnSEj1bLFA53Y1YnP32J35BDOedq4sMeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OM1DGvNQjIKqqiQrrXStUkjdoqKKlbIKClqfqM8ZBnE=;
 b=LJM+0omBlxtu3runX+sUJCUoaa0U2LNGoFCI1G0NWqkacsl5E2B77PmtCRI5bpRZiDhQXTWwkN4fsrSLEkNkK4qHo+RQbStBK6HV+tYXpVaSw8zgX4jUvoez0IxLkXda6UOZ/awDT+G7iwcnLD2xvUFEIwsNgaLj1LOxhpG7A7JkhIogAvVJZkStuo//LImPcwOikqri8jgAwFmnmVInwC2I6hqHdrPsc0jqNPr8TYQkn8f39QVOBtCZCY4qWoiBnS43SSQqYR4Ec+o7n0jluYR/0AajZj/iy/aabxn1dHa+AbDlcWNLalPs1r81ZgL8OeUiOZWMR8b6F/THm2attg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OM1DGvNQjIKqqiQrrXStUkjdoqKKlbIKClqfqM8ZBnE=;
 b=amcqvgxwFzcxixIORIuzT8GRKMVf5GM4zWMGtm0jwoluxJMyp+I7/QHbyNyAfGIbsy9MsN4Ujs907+xytzbmF+f8AbySemU7zyEkbNYVQ3LcRsO2l7EA/rNAmQ7Bvz1slucIVc5xlMA+31eQ6hQOZuSqTxDVZFRfIsreH4OXyQUS1PXQeAH24sAgDJxjRNLmNCgpR+Qk2jUVpfAFSvGenrZF7tQtGACNeAyWim9QHxbQ0GIzXUrG0dBDYQHVsg5P0RSUcDF0yshs50pO0kQNHO+z/Y2DBbxvtdN3vVFgfd+Ipu7WrfVLN8aUli9g4kGKHxQLsEgTPligP18+PKFDPQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB9962.eurprd04.prod.outlook.com (2603:10a6:10:4c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 00:13:14 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 00:13:14 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Frank Li <frank.li@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 net-next 0/6] net: enetc: Add i.MX94 ENETC support
Thread-Topic: [PATCH v3 net-next 0/6] net: enetc: Add i.MX94 ENETC support
Thread-Index: AQHcRuZ0y9m5nB8EmkOfic9FRb60u7TYP5CAgAAC4oA=
Date: Wed, 29 Oct 2025 00:13:14 +0000
Message-ID:
 <PAXPR04MB8510AC62551ABD89E75EB97188FAA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251027014503.176237-1-wei.fang@nxp.com>
 <20251028165757.3b7c2f96@kernel.org>
In-Reply-To: <20251028165757.3b7c2f96@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DB9PR04MB9962:EE_
x-ms-office365-filtering-correlation-id: 2f09727f-a747-45fe-e225-08de167ff3ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZK3hSn3DHdyRaOh/FO/wWFVo4J4gqiKEtfIf5ozlrj4FS22AWWmm21lZ4XTQ?=
 =?us-ascii?Q?zZH69yItJIoWI3wrXHKGixatCIPZzaqMTk2iREj4n2a1b7YCZ6+jD8YwMoTz?=
 =?us-ascii?Q?7QMpBtDI7FE382WMTiHORw5KmJY7Y3C/db3eYqtUhgi4vpHy8AMKJE7TkIK3?=
 =?us-ascii?Q?38c1ySETMdN3t7jgE+YQJOrDRat7VmwCzEJmx7EcuHJgyUK9pWoqGmuf4X3U?=
 =?us-ascii?Q?J2brqKRZUt6TsP+Bl5zknFvuV0G1mEyXyF1S1VW6X6LL5Q9UHVWculei3U14?=
 =?us-ascii?Q?FjUvKGtcr062DdRRfz0L2TWFkcagCtKavLhKZHkl5vuSZa/qvfWAf0YK0N5E?=
 =?us-ascii?Q?f38VANIAZ1QmR3m7W7bxZ3b/Jg3HvC4FciaXHH9jJ1Xal4j7HZ1LGmP8epRN?=
 =?us-ascii?Q?BHgEGn0MjKWrPhP8vtKgEAOp9cZZWl44KRuxC10bcGJPAtAgYvQeLxnSxW5O?=
 =?us-ascii?Q?+0+9KOgJDa31c2/dYpl9I6Y4g2y/eevpUPMWjTHAw8uxxSQgS+OcvpETX68u?=
 =?us-ascii?Q?NofgNj9ef/KM4K66abWKDF8W1XWRivI7tGJ1CAbBttzissGotXDQmxJ8xB5G?=
 =?us-ascii?Q?A1JMqDqB5Xqk85S53mBeJ4ayI3tDmpqvoet8ildxVmjUzsgBsQ8UabWeEnPU?=
 =?us-ascii?Q?J/F1hLfoWUzd2XF0QcGcHwSvf5eOryXXoVfrUjpBPuMbKjEIamKies/P1la8?=
 =?us-ascii?Q?K3xAHK8+NfznHzbwiBLWG8J3v2i9FV/a7oAbzrEGCyoWfGRzvFZ/PcihrIlT?=
 =?us-ascii?Q?DDNufgYSTu/TreyTuYQewwNjCAGA9+AYoYaVMoUQE1EUeJJvZdolULPR9tRX?=
 =?us-ascii?Q?w/K7Cx4p455wmBnw+Kjx6stHvYkXFLAnK5/MBARrf9B1RNEZ9XvEEQCrLu7Q?=
 =?us-ascii?Q?b1slZlUVonUAFJ9s31ZR0LfIX1TfW/a+0d3LnIu3S7IrsKOsRzxlGW8Qf9LC?=
 =?us-ascii?Q?Z0VFyLNxQgpmyJBCjLBxrUnAe0ATy6ujCaF2WkIoHwaOFGGl0xgoqnjXGO5G?=
 =?us-ascii?Q?kCsE8tfcOe2M72GPSobQmIfuU9W+XuctyWIlqB4avo0Zh2bmnQAxw+YL3hp0?=
 =?us-ascii?Q?1RM9LTQpw2NNd6JchEBsny930KcciWvHCHOB597sG7uzabgOSx99JLSSCq5x?=
 =?us-ascii?Q?7cvsqUt64MKfLKRhkR3mfRpD1/X+gsHRGcd7gC7tK9JWXaZwuE5bjiALCXE/?=
 =?us-ascii?Q?ge0htSlCa2g+ph1IgDKdOou8Yqox8vc6bTmCGUUHGswjM9XvmHNrv1rw25c3?=
 =?us-ascii?Q?kAhD6ETclzJpDQO5dqHS1c8jgCAXLtyxOg4DsbvUZKdVdHIoYRhZsSHypP6R?=
 =?us-ascii?Q?f1U+xjUeGGD5yP18vLK4AZTCC2ROLWRS+dapWdgBBzCHPZDTezk2DqSc7ZfE?=
 =?us-ascii?Q?r01eLt26lTY5yYiNRIzkTF0j9dGBvCj9OykVoTSS9eDYkSKwjfTzHsXwy19m?=
 =?us-ascii?Q?2ZwQLovYH2gC4muZXfws4ty0QemTIl/1ZgvIGlrLy38eAKCftrTj3wd05xOS?=
 =?us-ascii?Q?Ti07S2uCiMgPPazXuUxRYIBsC6Ep2KBFRJ64?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+mgIq2VWxoRowFHQ4QBQ6ZcmFCtq0mqWhAa6HYxc3GubJzp/Z6OkMLSTT/BF?=
 =?us-ascii?Q?WmDFuY/4H9q9W/ISjZkbOLIZHhT9fwwYKT3McCLkv/D6fvLeFr7ofQi4q51i?=
 =?us-ascii?Q?Czyu6bLtxSz40Oj87BaMLNkS+bhAhPgqwxvBzVprwSbP2B51zUk/8d4VkbKh?=
 =?us-ascii?Q?gabT43kPJ07DDINvKQ3+ALkOF/SwDXQr5lLcznfo8Q/N6Jas5ZxPRa31SN2z?=
 =?us-ascii?Q?2HQ29fP+EcL/jeqvMTV/WDDJxYS8Nsx5nuQxIolfhoFvjM7IN1evnk8u1CSE?=
 =?us-ascii?Q?esBS9CEkKEaMy10oIRtOdIgOJIxsH1plfGSU55Y2BH1P11GjWpcxj0wEKf25?=
 =?us-ascii?Q?iI8f1MLBQ0dwU2YvccZ6ZezSzj8cvZKVBd2IiKDzk2o22nbIEsDsMiOpm43b?=
 =?us-ascii?Q?MNZSg3zp2fQ6vE0dhsSMDvanZfdgdT6de8BZL8+P9hiSfe0tnN8rIXseCtmx?=
 =?us-ascii?Q?M8OutVTQ4zTMBtZTOO7dL3Gl5DnKp1EtOeHyy4vdvNdNqGyO15lKA/sM1AJz?=
 =?us-ascii?Q?qEw0ZHBrWdU+kXKNGOoppqezT8baLw+hqQaAuz3r0UMrMDzyBN1u05bTZBzO?=
 =?us-ascii?Q?kjG9tsg9KrdsG3x05oOoPWAl9vMhEE5QDFIOZB811h4LcyfglNIjzlkEilnQ?=
 =?us-ascii?Q?U8/uIa4BlBXlaPg+EdO02YbnKgZUrL3dt+DIt54JmUiRXLbEy+Ej33kgjo98?=
 =?us-ascii?Q?9deh7lskeC3oZlR5OnhW7Axa+JlXodh66aWj94tdNSxpmICdYvFxguBzcBHK?=
 =?us-ascii?Q?+N0s13SDPxp5jFFLA6W0x+C3kWOGMMtNVvjEUb+7MN4w+f1o6s64oXed3LyE?=
 =?us-ascii?Q?wZg2jWGIK6N1Q/awmaTsKfNWqgXbwwKqzDGuxiTIV9oUhISJW3NRMAyj2poR?=
 =?us-ascii?Q?G0R6Ge6MteT37flVWAOCZxq9VlnSefPqTf/HZE9rejZcVJxIy4Qhh080g86J?=
 =?us-ascii?Q?ANhE5Kb9r/sVSEbK7x+gCcp/4OWwod5ijsgJkYZVtt18Sea2KQGHAr43KnN9?=
 =?us-ascii?Q?jr+8Nk/QS8GyPa3Sx/2OISAODBamksqIoQYCZBNxYr3NbmVx2xLpE5BwId2B?=
 =?us-ascii?Q?eKWcMxIo0egP2h5ojSQ8/TNv8fKH32+2MyoF3rzkOkPsfNAnvqGATdNGWawh?=
 =?us-ascii?Q?wB2G1p0oq/ikq75s9zIWJU72f4sHOpd/f4dw+CvTz5bD/ijkhwog3+zlEdKU?=
 =?us-ascii?Q?/mCrmXgfNyWmaH/Y9mLpwca4E+y8UQU6dqv7c8u6cZvzCci4FRTityCpI7zH?=
 =?us-ascii?Q?xX/45IXebmzzMAie7Nc4IuH8ExvnvGHMIDFm2StJ4e438HtjvWNovubKbmZF?=
 =?us-ascii?Q?86ta4ZWmlka50g55hHzbMia5cfa2IBNmUjPoLxhtWK4rHwAJLjnuCGZaaeY6?=
 =?us-ascii?Q?y2jW24uBCiz8KVzsKvxNxm2yYPs5TENCGAz6HyEQyOpZgrzulJDJFHYZUw6Y?=
 =?us-ascii?Q?vnTKkdP9BXdQ9FmsQn6e7uRdIHFgLHuk6xQ6EVW6nra93kR/ozElzmePmrID?=
 =?us-ascii?Q?jf2xzFlDq8na4d4je5YeMfvPON1hMQvhd+VdY7jnVOAnIe6EkkWdzPoRQnT4?=
 =?us-ascii?Q?aBjByN4NueRCnaX7F6E=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f09727f-a747-45fe-e225-08de167ff3ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 00:13:14.1962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pnkk4d2FN8k68tm6ZDMvk/1lOMbttK50OrQtBN1aqFfjzUu19jrMNSAlgiIrxETJ7HVyxxumIGOhdhFU9Oa+QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9962

> On Mon, 27 Oct 2025 09:44:57 +0800 Wei Fang wrote:
> > i.MX94 NETC has two kinds of ENETCs, one is the same as i.MX95, which
> > can be used as a standalone network port. The other one is an internal
> > ENETC, it connects to the CPU port of NETC switch through the pseudo
> > MAC. Also, i.MX94 have multiple PTP Timers, which is different from
> > i.MX95. Any PTP Timer can be bound to a specified standalone ENETC by
> > the IERB ETBCR registers. Currently, this patch only add ENETC support
> > and Timer support for i.MX94. The switch will be added by a separate
> > patch set.
>=20
> Is there a reason to add the imx94 code after imx95?

Actually, i.MX94 is the latest i.MX SoC, which is tapped out after
i.MX95 (about 1 year).


