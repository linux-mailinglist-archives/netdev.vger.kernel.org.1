Return-Path: <netdev+bounces-213159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0BAB23E01
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 03:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E855E1AA1C40
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 01:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1AD1B4257;
	Wed, 13 Aug 2025 01:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jm3GCI6b"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013060.outbound.protection.outlook.com [52.101.72.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D2D189F43;
	Wed, 13 Aug 2025 01:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755050347; cv=fail; b=isKn6esDR1K0d0XGtZcAjpLnZOvCqsKWPbWaBcNfeCf/oghzIfSAPV5WbcKUf6lBGrZxGQwTvuDc6CzwZDc6SwEUNaMX+gnZtuA9l9r2N5R7kAbTcustOAWW8REKBQAUpl3ByLvImpkTdCWKrCApcvQjQGrcxxd4eBiD7ZThuuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755050347; c=relaxed/simple;
	bh=H/4cDdKdqTup0+0e5vLe+KAGYRm9+uaL6ihapB8Kv9s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ulNmPI48X2f1YHVELwKWFWKi147392ZObzHnlpAmfmSckNTbbA1qLSOHO/SUotDeY/wgGHKIn8xyfJYEgf9unm9WEock4FPVK2n77QtE0mlqoN/exJ32EkS82z8AETt5JXthrZcMDkxuAVXdsPeI/B4M5TSKcVcfP/Qye3DkpLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jm3GCI6b; arc=fail smtp.client-ip=52.101.72.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOPGXn5p77gbjjwLl0HSVhuAVYJigaUETxgDzqj+G7o1LRCqdEN7TRDZHZTxi93YyB+nyO7HUrlOkq1IQti7hb5Hmq+APEGHEePEtS4lQAbUn7xNn1BC5vWux+HbQBLPUiaD4RL/R3HsHLoKh5UK/6oOqTZM8dze5Idj+ogmJqI+ZyU4zE8g5kGPUpVXJoxvXB2inb/fCgS679DpZLLQSbLIoiSZpTIWIVn/lucqMOnqD0hzHzrEv4JWAniC34mH36SHGTkhszNhU7JHl8AppaJKcC7KzZjGzWrzCzEGdYBAJ55JvnYHSpiELQa47HGNHom/rSN6lw45EccRXsVnyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPEu0mHxfrmZmGryvtvkVUciKMEjoaPKDTEXG5HdgGU=;
 b=OCqrmWuWXABhDxhYh/Ljfx5nJCg6TQ02p5x8HPjd1nv/Kb8bQIo/V+QAXsrwm0V1tPO5fmcGFgDmqdiCMUq2uPY6ll3v7FMjSlf6wKoFgHgMtUXWxrvvvTzhln7Fq0Szcu/iIhGVztc1NqM2vuIrp+e/D4bzcjB9PEmFly+hzX2riu1xgEmBEJXOf8Yqza6Bu69l1VkRtqWxt2FqZMJCiS6+BM6CX0utXsBfWUYjLLPvmA6ozwriSTjbgVnyWNE70AMaAJvfHgq9jvZVR21+K5wkOlN5qfo9h8V5T5oR+q1Jm+QR1nk/NMkbCM0Agmdhqqk/e2PVyFnZa6D6RWu8/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPEu0mHxfrmZmGryvtvkVUciKMEjoaPKDTEXG5HdgGU=;
 b=jm3GCI6b3/xJA32qN4vPxqMu8bh7BnnMgcBav8rptEdJPph1ZYkOASCVinHCENBJ3EtuD5WSmOoUarhxWIDQ7KscgajlO/GqKjV5+rG45gM0x0kRaMQYmR0vJ8/AOlkyMQydg8vc+iHgdJkOoKwiIAHiaD6LQSzUimKo9Z4JN9b9zdF3efl6Lcztad+CIA7Y7qcYYrmgV0+rlLeUpObwGiA3A/KxrrKoI7AQxRz4of7iElrWfA8Y0D9LljPoEliu+6JtavdQJEQkzbMyP0xJSzO7rFSFU0lfSghucHihaDGaLKHm7KdPjVkZVCaH181i33VEb+CXsPlrdozu6Ata+A==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM0PR04MB6914.eurprd04.prod.outlook.com (2603:10a6:208:189::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 01:59:02 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 01:59:01 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "F.S.
 Peng" <fushi.peng@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v3 net-next 05/15] ptp: netc: add PTP_CLK_REQ_PPS support
Thread-Topic: [PATCH v3 net-next 05/15] ptp: netc: add PTP_CLK_REQ_PPS support
Thread-Index: AQHcC3DsDacGBzi4GkeW8QCnEeawArRfH9SAgACx0RA=
Date: Wed, 13 Aug 2025 01:59:01 +0000
Message-ID:
 <PAXPR04MB85109D4D0866A0E03BF04611882AA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-6-wei.fang@nxp.com>
 <aJtZl3jgBD0hLyt0@lizhi-Precision-Tower-5810>
In-Reply-To: <aJtZl3jgBD0hLyt0@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM0PR04MB6914:EE_
x-ms-office365-filtering-correlation-id: 4494c373-7859-4247-dad4-08ddda0cf971
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jw2W+sq/Aoh1t0IPeqJuXcaIIjyZEKzEdZtQSfkwMcq0PHL0XrCxRyGa1+wM?=
 =?us-ascii?Q?su46fF44awFXWp8Rc+7IA3VdTuZX9neBKy8a7Pb+V7L0vj8jNT+HqgRTs+XQ?=
 =?us-ascii?Q?eLWrlPapXthFYkNsmi4tR9WJ4D3uOh22l1shBjEiiqaK5GQJNO23rbaoWaK/?=
 =?us-ascii?Q?dgXEHTzMlJDyaEuKFVVGSXB4hMar0ARlwAN6eNgJIQWxP+ttCz9X0Ze06v3i?=
 =?us-ascii?Q?Z5+1ZLmvZ60vP20bVmUiEaQd9VTjJ9WSAfB03Bawavl8giheR8XdPlkwguXS?=
 =?us-ascii?Q?2piOGQWECR+by5ZI6yyImuYapGBRoWID2f+HNkXgMNi5tdOak2EkhTo5W75d?=
 =?us-ascii?Q?mkvHTd+YKsPUEdir2jnRuoW0/U+b+fZUxeLweYZIARgoykFJofQSieug7yPT?=
 =?us-ascii?Q?+GipX2qqK46Plysi8jsThhl0Vj+1f/G7DNokdQ2jsLUKiCsDhYvnQzq0QSDK?=
 =?us-ascii?Q?MU9wX0+WSelrGCqmU0GOOIsC98mI85qIon12TAXQ4d6OWf9AD7thYd0/Pw03?=
 =?us-ascii?Q?ytuLWtT0MoMnQ1uESARNpxC+XekUD7llKeDqSN6qpJBd0injfAcvo5MFyuS8?=
 =?us-ascii?Q?3XGz7QQfqOGcGNSmwy6S6X7FUHP0f4uEUGHIoHY7hl5vn8DVZeZ9N0Ca6qRN?=
 =?us-ascii?Q?xQJeoOLVwbIxY3CIJbvf/aWrBzMcjv+hl3hoWpSdg9eD3hmIvzhZKbIfIbfy?=
 =?us-ascii?Q?yPjxz2id2WxmEJ9ov1QtPVV6nI7G83XYgXmWHQ7yCWQihWACWwTmQ9aDlyv4?=
 =?us-ascii?Q?SoSQckKNzdgq1hIAPkIgnNFFbF73cu3OHWIHw52tdn0wOAEd6XzAzZUKEhRU?=
 =?us-ascii?Q?TZXmiWo5anfg6+nxWYPXP8TwCeRgjmjNWoIHFrBQhAj6ruLAJfR7jsv33WX3?=
 =?us-ascii?Q?7f3zX8jp0ePHi5Z2IOgVCXg//Q/xTg4IGPfm6RIyN7p9bl61bNUhXZ0EY33p?=
 =?us-ascii?Q?5xoOTeBb9Cn89KpytK9csFK6Xm95OtuDBLP8j2S3GvuzxPusL5rd92qkJoal?=
 =?us-ascii?Q?8Mi0NUCmkaRT2vdXMZPMX9Gu2t9FGz4N6bH1LXyKl43zvSh19xD3/VPVIlwQ?=
 =?us-ascii?Q?wmmkYR5WhQVB0XzqyWJDgVEBaoy1YipBk1pZbbS1r0Lct8J1kaElf1gHtM8b?=
 =?us-ascii?Q?pA719tr8jSBGywtZZvP9yGVnmdmZuS84gvPldGn9XUetbBihl4RUaV7UlFec?=
 =?us-ascii?Q?iFScIY1U6NlrgacCeV9fKX7Z5MMV9bz4JGPga6sT3JdJHSbjpeeT0fauaRMS?=
 =?us-ascii?Q?SSbbwWD/sAzrmEmjbdUY08jxTVlUE3bcLefsLl6spp/h57Qn4yCGHGUMUXIJ?=
 =?us-ascii?Q?w9Mc7tvlmPkbXxWGZd+i+LkWLCbHon7QMsH5BlD6znmZCp8t2OKrK3DQZfZI?=
 =?us-ascii?Q?1Taw7VC1pgE79Nv1a2gseFwJ4SZN/c+MIC7hYT2viqXfL41MWfzXzFfXDkFw?=
 =?us-ascii?Q?ybQ4cYHDzMqHncmorRFbnKoCOM5FjXV/6Sg0X5zcnCSkfgpouMvGhY7zNjiG?=
 =?us-ascii?Q?srM6mPIuNYM+DQo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZajxH+lcYsBw7tU78mGcOPdHA+xnvPuaGXbpnyzEoDcf4GPxLWU3KnAMsTzl?=
 =?us-ascii?Q?8GMj5iufk9jBrR5EP+rY2Yp+AJsEQc/1qDn3OPP1vOLU3hwE+IbnIAfvBMHU?=
 =?us-ascii?Q?7WNM1TR6pTWfz+HqVYO+NzwmRsdKWHGQSv8+2IbI+F/dVZpoHbpS9IK57ORE?=
 =?us-ascii?Q?nj0sSctN2LIywcUpSLAqxp8jfKjc0TdvdciWhTtpZsSVUl41G/YTx/M43+zR?=
 =?us-ascii?Q?GlxOHlozgb8lBH4cOhz187M3afTsGJLBFFbt7bPJEKJFtIXErSVuVnLPreRt?=
 =?us-ascii?Q?p8yJDoVd3wtLJ0X0ggiAHmrN8T0dbbJ0Zo21GTiXsg7yn06PrPWMzAkuyS6O?=
 =?us-ascii?Q?kXcbb18syAOCP8e5ijonpsJE2mGeDls8m3FHLQHHXDrnocBnLMnMHd7mQxZ2?=
 =?us-ascii?Q?Mm9OxvepUMX3nAg3GMiQdTtG7p/ye9Tjcnn1yam2aXFhbk/AMIWPK0NP3EWQ?=
 =?us-ascii?Q?pmLPqhXBJZhkQQkEwSCfxw3Kj6k/g8JXZGNaq1dZ0zO3ngM1lp3HEugndgXV?=
 =?us-ascii?Q?B+pFO/Uodb7q6jWidCsr3PzEFKaTvONd2NQL43eCMWQaVB660+Z4CKmwvNQr?=
 =?us-ascii?Q?8qJHWmhZ45gKIxz4BNmwIGj6UsFTN4hSwaEpZi9ScOH2W5Nfcx3KQQopSbpe?=
 =?us-ascii?Q?R78qaUZN1NpSdsSIvt/lplKuCN9MtgBj6dgkp+5zdyYpDdYp3LD8XoW1VewP?=
 =?us-ascii?Q?aUS54RgKR+sUmrtmBEd0Mzqb7PbkgRYWXSU81ctWqcHQBv9cq+087GdqWY9N?=
 =?us-ascii?Q?z97Eb5ou8p1KQ9N/Shq7+MHilZSSy7lY3Hjlc+INGOy6F2YVmhgaZcwB8vjG?=
 =?us-ascii?Q?rGFMXqKFy7S3G6idWk3lQex/z+2yIaD2jyb/x+QPBp/w8MysMhSU6XXI/WW8?=
 =?us-ascii?Q?xWTK6Oaigcnm0SaJOPGUj5OPvS22zF6PaLW5j+RFWSBk0pUOeVP+oD0HzO05?=
 =?us-ascii?Q?VDgxWLqfUo9PBKms7skuuSdSj0O17KYCEgwR4wUZR3P5FbE4VIgdTL6q3F0Y?=
 =?us-ascii?Q?M9sl0XNk1U4h5H+RGKP2nwYPcFAfxN8/Tlizz3rdBVDqbvhdBsmsY1+aB7Cw?=
 =?us-ascii?Q?h6XskahhFWCkFq5tpbG+zoSXmGY56LXJIuC9GBTI3/SST9v/GcujiGH4NaXu?=
 =?us-ascii?Q?+nIiFnfdBf5chmNei7vqSJOMUDKfk68mLQvgnR2lJuh+dUTuPeRTtNus6ByA?=
 =?us-ascii?Q?B/2xBzcufdqGud7ZEs188MDcyI7UDd1vH8jrHijrrqwp5TylkL/GXClYVfo7?=
 =?us-ascii?Q?Gdpkg4+B5FFmem8APwXXFcEYDQQvo+quO+WKOktYVfzP8yT/lCeWRsp75zMa?=
 =?us-ascii?Q?3nPvvcgFrAm93oNFHih1X++PsLd8y0H02PpbCqUR5C6yReOT006qkS1pGxuF?=
 =?us-ascii?Q?/haMdUx7Ya/SrBbeHgjVZURBP8LhQOytZ+7htWKviSyk689bIn464WChuIss?=
 =?us-ascii?Q?Lp0wFlfvWzSHwAsMiwUosBLUNJaNCSixiar/jqvt9eZhMI9J5psR6dfEIvVu?=
 =?us-ascii?Q?3fzOwdj1W5sGZ45wvA0QJy27KBtqA5kuFW714PxGwf4Jd+ieA9tvDe+dOXC4?=
 =?us-ascii?Q?3E+yAIceyWmYXl44L14=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4494c373-7859-4247-dad4-08ddda0cf971
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 01:59:01.5529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KTj8G9Q3wpc+f2gkk202tV4rxZqoGKCB0Kvbn47HHKdxBk4jDQllBwJv+3wVcdv91TikwhgbR8bSMoFdfgpcgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6914

> On Tue, Aug 12, 2025 at 05:46:24PM +0800, Wei Fang wrote:
> > The NETC Timer is capable of generating a PPS interrupt to the host. To
> > support this feature, a 64-bit alarm time (which is a integral second
> > of PHC in the future) is set to TMR_ALARM, and the period is set to
> > TMR_FIPER. The alarm time is compared to the current time on each updat=
e,
> > then the alarm trigger is used as an indication to the TMR_FIPER starts
> > down counting. After the period has passed, the PPS event is generated.
> >
> > According to the NETC block guide, the Timer has three FIPERs, any of
> > which can be used to generate the PPS events, but in the current
> > implementation, we only need one of them to implement the PPS feature,
> > so FIPER 0 is used as the default PPS generator. Also, the Timer has
> > 2 ALARMs, currently, ALARM 0 is used as the default time comparator.
> >
> > However, if there is a time drift when PPS is enabled, the PPS event wi=
ll
> > not be generated at an integral second of PHC. The suggested steps from
> > IP team if time drift happens:
>=20
> according to patch, "drift" means timer adjust period?

No only adjust period, but also including adjust time.

> netc_timer_adjust_period()
>=20
> generally, netc_timer_adjust_period() happen 4 times every second, does
> disable/re-enable impact pps accurate?

PPS needs to be re-enabled only when the integer part of the period changes=
.
In this case, re-enabling PPS will result in a loss of PPS signal for 1 ~ 2=
 seconds.
In most cases, only the fractional part of the period is adjusted, so there=
 is no
need to re-enable PPS.

>=20
> >
> > 1. Disable FIPER before adjusting the hardware time
> > 2. Rearm ALARM after the time adjustment to make the next PPS event be
> > generated at an integral second of PHC.
> > 3. Re-enable FIPER.
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> >
> > ---
> > v2 changes:
> > 1. Refine the subject and the commit message
> > 2. Add a comment to netc_timer_enable_pps()
> > 3. Remove the "nxp,pps-channel" logic from the driver
> > v3 changes:
> > 1. Use "2 * NSEC_PER_SEC" to instead of "2000000000U"
> > 2. Improve the commit message
> > 3. Add alarm related logic and the irq handler
> > 4. Add tmr_emask to struct netc_timer to save the irq masks instead of
> >    reading TMR_EMASK register
> > 5. Remove pps_channel from struct netc_timer and remove
> >    NETC_TMR_DEFAULT_PPS_CHANNEL
> > ---
> >  drivers/ptp/ptp_netc.c | 260
> ++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 257 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
> > index cbe2a64d1ced..9026a967a5fe 100644
> > --- a/drivers/ptp/ptp_netc.c
> > +++ b/drivers/ptp/ptp_netc.c
> > @@ -20,7 +20,14 @@
> >  #define  TMR_CTRL_TE			BIT(2)
> >  #define  TMR_COMP_MODE			BIT(15)
> >  #define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
> > +#define  TMR_CTRL_FS			BIT(28)
> >
> > +#define NETC_TMR_TEVENT			0x0084
> > +#define  TMR_TEVNET_PPEN(i)		BIT(7 - (i))
> > +#define  TMR_TEVENT_PPEN_ALL		GENMASK(7, 5)
> > +#define  TMR_TEVENT_ALMEN(i)		BIT(16 + (i))
> > +
> > +#define NETC_TMR_TEMASK			0x0088
> >  #define NETC_TMR_CNT_L			0x0098
> >  #define NETC_TMR_CNT_H			0x009c
> >  #define NETC_TMR_ADD			0x00a0
> > @@ -28,9 +35,19 @@
> >  #define NETC_TMR_OFF_L			0x00b0
> >  #define NETC_TMR_OFF_H			0x00b4
> >
> > +/* i =3D 0, 1, i indicates the index of TMR_ALARM */
> > +#define NETC_TMR_ALARM_L(i)		(0x00b8 + (i) * 8)
> > +#define NETC_TMR_ALARM_H(i)		(0x00bc + (i) * 8)
> > +
> > +/* i =3D 0, 1, 2. i indicates the index of TMR_FIPER. */
> > +#define NETC_TMR_FIPER(i)		(0x00d0 + (i) * 4)
> > +
> >  #define NETC_TMR_FIPER_CTRL		0x00dc
> >  #define  FIPER_CTRL_DIS(i)		(BIT(7) << (i) * 8)
> >  #define  FIPER_CTRL_PG(i)		(BIT(6) << (i) * 8)
> > +#define  FIPER_CTRL_FS_ALARM(i)		(BIT(5) << (i) * 8)
> > +#define  FIPER_CTRL_PW(i)		(GENMASK(4, 0) << (i) * 8)
> > +#define  FIPER_CTRL_SET_PW(i, v)	(((v) & GENMASK(4, 0)) << 8 * (i))
> >
> >  #define NETC_TMR_CUR_TIME_L		0x00f0
> >  #define NETC_TMR_CUR_TIME_H		0x00f4
> > @@ -39,6 +56,9 @@
> >
> >  #define NETC_TMR_FIPER_NUM		3
> >  #define NETC_TMR_DEFAULT_PRSC		2
> > +#define NETC_TMR_DEFAULT_ALARM		GENMASK_ULL(63, 0)
> > +#define NETC_TMR_DEFAULT_FIPER		GENMASK(31, 0)
> > +#define NETC_TMR_FIPER_MAX_PW		GENMASK(4, 0)
> >
> >  /* 1588 timer reference clock source select */
> >  #define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from
> CCM */
> > @@ -60,6 +80,10 @@ struct netc_timer {
> >  	u32 oclk_prsc;
> >  	/* High 32-bit is integer part, low 32-bit is fractional part */
> >  	u64 period;
> > +
> > +	int irq;
> > +	u32 tmr_emask;
> > +	bool pps_enabled;
> >  };
> >
> >  #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
> > @@ -124,6 +148,155 @@ static u64 netc_timer_cur_time_read(struct
> netc_timer *priv)
> >  	return ns;
> >  }
> >
> > +static void netc_timer_alarm_write(struct netc_timer *priv,
> > +				   u64 alarm, int index)
> > +{
> > +	u32 alarm_h =3D upper_32_bits(alarm);
> > +	u32 alarm_l =3D lower_32_bits(alarm);
> > +
> > +	netc_timer_wr(priv, NETC_TMR_ALARM_L(index), alarm_l);
> > +	netc_timer_wr(priv, NETC_TMR_ALARM_H(index), alarm_h);
> > +}
> > +
> > +static u32 netc_timer_get_integral_period(struct netc_timer *priv)
> > +{
> > +	u32 tmr_ctrl, integral_period;
> > +
> > +	tmr_ctrl =3D netc_timer_rd(priv, NETC_TMR_CTRL);
> > +	integral_period =3D FIELD_GET(TMR_CTRL_TCLK_PERIOD, tmr_ctrl);
> > +
> > +	return integral_period;
> > +}
> > +
> > +static u32 netc_timer_calculate_fiper_pw(struct netc_timer *priv,
> > +					 u32 fiper)
> > +{
> > +	u64 divisor, pulse_width;
> > +
> > +	/* Set the FIPER pulse width to half FIPER interval by default.
> > +	 * pulse_width =3D (fiper / 2) / TMR_GCLK_period,
> > +	 * TMR_GCLK_period =3D NSEC_PER_SEC / TMR_GCLK_freq,
> > +	 * TMR_GCLK_freq =3D (clk_freq / oclk_prsc) Hz,
> > +	 * so pulse_width =3D fiper * clk_freq / (2 * NSEC_PER_SEC * oclk_prs=
c).
> > +	 */
> > +	divisor =3D mul_u32_u32(2 * NSEC_PER_SEC, priv->oclk_prsc);
> > +	pulse_width =3D div64_u64(mul_u32_u32(fiper, priv->clk_freq), divisor=
);
> > +
> > +	/* The FIPER_PW field only has 5 bits, need to update oclk_prsc */
> > +	if (pulse_width > NETC_TMR_FIPER_MAX_PW)
> > +		pulse_width =3D NETC_TMR_FIPER_MAX_PW;
> > +
> > +	return pulse_width;
> > +}
> > +
> > +static void netc_timer_set_pps_alarm(struct netc_timer *priv, int chan=
nel,
> > +				     u32 integral_period)
> > +{
> > +	u64 alarm;
> > +
> > +	/* Get the alarm value */
> > +	alarm =3D netc_timer_cur_time_read(priv) +  NSEC_PER_MSEC;
> > +	alarm =3D roundup_u64(alarm, NSEC_PER_SEC);
> > +	alarm =3D roundup_u64(alarm, integral_period);
> > +
> > +	netc_timer_alarm_write(priv, alarm, 0);
> > +}
> > +
> > +/* Note that users should not use this API to output PPS signal on
> > + * external pins, because PTP_CLK_REQ_PPS trigger internal PPS event
> > + * for input into kernel PPS subsystem. See:
> > + *
> https://lore.kernel.org/r/20201117213826.18235-1-a.fatoum@pengutronix.de
> > + */
> > +static int netc_timer_enable_pps(struct netc_timer *priv,
> > +				 struct ptp_clock_request *rq, int on)
> > +{
> > +	u32 fiper, fiper_ctrl;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&priv->lock, flags);
> > +
> > +	fiper_ctrl =3D netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> > +
> > +	if (on) {
> > +		u32 integral_period, fiper_pw;
> > +
> > +		if (priv->pps_enabled)
> > +			goto unlock_spinlock;
> > +
> > +		integral_period =3D netc_timer_get_integral_period(priv);
> > +		fiper =3D NSEC_PER_SEC - integral_period;
> > +		fiper_pw =3D netc_timer_calculate_fiper_pw(priv, fiper);
> > +		fiper_ctrl &=3D ~(FIPER_CTRL_DIS(0) | FIPER_CTRL_PW(0) |
> > +				FIPER_CTRL_FS_ALARM(0));
> > +		fiper_ctrl |=3D FIPER_CTRL_SET_PW(0, fiper_pw);
> > +		priv->tmr_emask |=3D TMR_TEVNET_PPEN(0) |
> TMR_TEVENT_ALMEN(0);
> > +		priv->pps_enabled =3D true;
> > +		netc_timer_set_pps_alarm(priv, 0, integral_period);
> > +	} else {
> > +		if (!priv->pps_enabled)
> > +			goto unlock_spinlock;
> > +
> > +		fiper =3D NETC_TMR_DEFAULT_FIPER;
> > +		priv->tmr_emask &=3D ~(TMR_TEVNET_PPEN(0) |
> > +				     TMR_TEVENT_ALMEN(0));
> > +		fiper_ctrl |=3D FIPER_CTRL_DIS(0);
> > +		priv->pps_enabled =3D false;
> > +		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
> > +	}
> > +
> > +	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
> > +	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
> > +	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> > +
> > +unlock_spinlock:
> > +	spin_unlock_irqrestore(&priv->lock, flags);
> > +
> > +	return 0;
> > +}
> > +
> > +static void netc_timer_disable_pps_fiper(struct netc_timer *priv)
> > +{
> > +	u32 fiper_ctrl;
> > +
> > +	if (!priv->pps_enabled)
> > +		return;
> > +
> > +	fiper_ctrl =3D netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> > +	fiper_ctrl |=3D FIPER_CTRL_DIS(0);
> > +	netc_timer_wr(priv, NETC_TMR_FIPER(0), NETC_TMR_DEFAULT_FIPER);
> > +	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> > +}
> > +
> > +static void netc_timer_enable_pps_fiper(struct netc_timer *priv)
> > +{
> > +	u32 fiper_ctrl, integral_period, fiper;
> > +
> > +	if (!priv->pps_enabled)
> > +		return;
> > +
> > +	integral_period =3D netc_timer_get_integral_period(priv);
> > +	fiper_ctrl =3D netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> > +	fiper_ctrl &=3D ~FIPER_CTRL_DIS(0);
> > +	fiper =3D NSEC_PER_SEC - integral_period;
> > +
> > +	netc_timer_set_pps_alarm(priv, 0, integral_period);
> > +	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
> > +	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> > +}
> > +
> > +static int netc_timer_enable(struct ptp_clock_info *ptp,
> > +			     struct ptp_clock_request *rq, int on)
> > +{
> > +	struct netc_timer *priv =3D ptp_to_netc_timer(ptp);
> > +
> > +	switch (rq->type) {
> > +	case PTP_CLK_REQ_PPS:
> > +		return netc_timer_enable_pps(priv, rq, on);
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +}
> > +
> >  static void netc_timer_adjust_period(struct netc_timer *priv, u64 peri=
od)
> >  {
> >  	u32 fractional_period =3D lower_32_bits(period);
> > @@ -136,8 +309,11 @@ static void netc_timer_adjust_period(struct
> netc_timer *priv, u64 period)
> >  	old_tmr_ctrl =3D netc_timer_rd(priv, NETC_TMR_CTRL);
> >  	tmr_ctrl =3D u32_replace_bits(old_tmr_ctrl, integral_period,
> >  				    TMR_CTRL_TCLK_PERIOD);
> > -	if (tmr_ctrl !=3D old_tmr_ctrl)
> > +	if (tmr_ctrl !=3D old_tmr_ctrl) {
> > +		netc_timer_disable_pps_fiper(priv);
> >  		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> > +		netc_timer_enable_pps_fiper(priv);
> > +	}
> >
> >  	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
> >
> > @@ -163,6 +339,8 @@ static int netc_timer_adjtime(struct ptp_clock_info
> *ptp, s64 delta)
> >
> >  	spin_lock_irqsave(&priv->lock, flags);
> >
> > +	netc_timer_disable_pps_fiper(priv);
> > +
> >  	/* Adjusting TMROFF instead of TMR_CNT is that the timer
> >  	 * counter keeps increasing during reading and writing
> >  	 * TMR_CNT, which will cause latency.
> > @@ -171,6 +349,8 @@ static int netc_timer_adjtime(struct ptp_clock_info
> *ptp, s64 delta)
> >  	tmr_off +=3D delta;
> >  	netc_timer_offset_write(priv, tmr_off);
> >
> > +	netc_timer_enable_pps_fiper(priv);
> > +
> >  	spin_unlock_irqrestore(&priv->lock, flags);
> >
> >  	return 0;
> > @@ -205,8 +385,12 @@ static int netc_timer_settime64(struct
> ptp_clock_info *ptp,
> >  	unsigned long flags;
> >
> >  	spin_lock_irqsave(&priv->lock, flags);
> > +
> > +	netc_timer_disable_pps_fiper(priv);
> >  	netc_timer_offset_write(priv, 0);
> >  	netc_timer_cnt_write(priv, ns);
> > +	netc_timer_enable_pps_fiper(priv);
> > +
> >  	spin_unlock_irqrestore(&priv->lock, flags);
> >
> >  	return 0;
> > @@ -232,10 +416,13 @@ static const struct ptp_clock_info
> netc_timer_ptp_caps =3D {
> >  	.name		=3D "NETC Timer PTP clock",
> >  	.max_adj	=3D 500000000,
> >  	.n_pins		=3D 0,
> > +	.n_alarm	=3D 2,
> > +	.pps		=3D 1,
> >  	.adjfine	=3D netc_timer_adjfine,
> >  	.adjtime	=3D netc_timer_adjtime,
> >  	.gettimex64	=3D netc_timer_gettimex64,
> >  	.settime64	=3D netc_timer_settime64,
> > +	.enable		=3D netc_timer_enable,
> >  };
> >
> >  static void netc_timer_init(struct netc_timer *priv)
> > @@ -252,7 +439,7 @@ static void netc_timer_init(struct netc_timer *priv=
)
> >  	 * domain are not accessible.
> >  	 */
> >  	tmr_ctrl =3D FIELD_PREP(TMR_CTRL_CK_SEL, priv->clk_select) |
> > -		   TMR_CTRL_TE;
> > +		   TMR_CTRL_TE | TMR_CTRL_FS;
> >  	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> >  	netc_timer_wr(priv, NETC_TMR_PRSC, priv->oclk_prsc);
> >
> > @@ -372,6 +559,66 @@ static int netc_timer_parse_dt(struct netc_timer
> *priv)
> >  	return netc_timer_get_reference_clk_source(priv);
> >  }
> >
> > +static irqreturn_t netc_timer_isr(int irq, void *data)
> > +{
> > +	struct netc_timer *priv =3D data;
> > +	struct ptp_clock_event event;
> > +	u32 tmr_event;
> > +
> > +	spin_lock(&priv->lock);
> > +
> > +	tmr_event =3D netc_timer_rd(priv, NETC_TMR_TEVENT);
> > +	tmr_event &=3D priv->tmr_emask;
> > +	/* Clear interrupts status */
> > +	netc_timer_wr(priv, NETC_TMR_TEVENT, tmr_event);
> > +
> > +	if (tmr_event & TMR_TEVENT_ALMEN(0))
> > +		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
> > +
> > +	if (tmr_event & TMR_TEVENT_PPEN_ALL) {
> > +		event.type =3D PTP_CLOCK_PPS;
> > +		ptp_clock_event(priv->clock, &event);
> > +	}
> > +
> > +	spin_unlock(&priv->lock);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int netc_timer_init_msix_irq(struct netc_timer *priv)
> > +{
> > +	struct pci_dev *pdev =3D priv->pdev;
> > +	char irq_name[64];
> > +	int err, n;
> > +
> > +	n =3D pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
> > +	if (n !=3D 1) {
> > +		err =3D (n < 0) ? n : -EPERM;
> > +		dev_err(&pdev->dev, "pci_alloc_irq_vectors() failed\n");
> > +		return err;
> > +	}
> > +
> > +	priv->irq =3D pci_irq_vector(pdev, 0);
> > +	snprintf(irq_name, sizeof(irq_name), "ptp-netc %s", pci_name(pdev));
> > +	err =3D request_irq(priv->irq, netc_timer_isr, 0, irq_name, priv);
> > +	if (err) {
> > +		dev_err(&pdev->dev, "request_irq() failed\n");
> > +		pci_free_irq_vectors(pdev);
> > +		return err;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void netc_timer_free_msix_irq(struct netc_timer *priv)
> > +{
> > +	struct pci_dev *pdev =3D priv->pdev;
> > +
> > +	disable_irq(priv->irq);
> > +	free_irq(priv->irq, priv);
> > +	pci_free_irq_vectors(pdev);
> > +}
> > +
> >  static int netc_timer_probe(struct pci_dev *pdev,
> >  			    const struct pci_device_id *id)
> >  {
> > @@ -395,17 +642,23 @@ static int netc_timer_probe(struct pci_dev *pdev,
> >  	priv->oclk_prsc =3D NETC_TMR_DEFAULT_PRSC;
> >  	spin_lock_init(&priv->lock);
> >
> > +	err =3D netc_timer_init_msix_irq(priv);
> > +	if (err)
> > +		goto timer_pci_remove;
> > +
> >  	netc_timer_init(priv);
> >  	priv->clock =3D ptp_clock_register(&priv->caps, dev);
> >  	if (IS_ERR(priv->clock)) {
> >  		err =3D PTR_ERR(priv->clock);
> > -		goto timer_pci_remove;
> > +		goto free_msix_irq;
> >  	}
> >
> >  	priv->phc_index =3D ptp_clock_index(priv->clock);
> >
> >  	return 0;
> >
> > +free_msix_irq:
> > +	netc_timer_free_msix_irq(priv);
> >  timer_pci_remove:
> >  	netc_timer_pci_remove(pdev);
> >
> > @@ -417,6 +670,7 @@ static void netc_timer_remove(struct pci_dev *pdev)
> >  	struct netc_timer *priv =3D pci_get_drvdata(pdev);
> >
> >  	ptp_clock_unregister(priv->clock);
> > +	netc_timer_free_msix_irq(priv);
> >  	netc_timer_pci_remove(pdev);
> >  }
> >
> > --
> > 2.34.1
> >

