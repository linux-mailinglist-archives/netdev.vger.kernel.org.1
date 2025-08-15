Return-Path: <netdev+bounces-213924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF49CB27570
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 04:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39EF43B6E07
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 02:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A47E292B54;
	Fri, 15 Aug 2025 02:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Uu9tbpU9"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011034.outbound.protection.outlook.com [40.107.130.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F8A274B41;
	Fri, 15 Aug 2025 02:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755223519; cv=fail; b=V9uFwAuHiuDhMyWtFy2d/U4elHN2s432m7v0HpiVpegGAQucEp1ZfU9gcAASJQraqsYga3laCs4wUS1hKeSSfjHzdaX0r5z2iNUjD2XT/8mkGYerHGWmrnqS3oW9yim1CL6zIAiftaL8cUuaeNbY/CjQ7uHX/3WM+xxe0e09B2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755223519; c=relaxed/simple;
	bh=M4mOOCPndl2c55xdMPNbjbjJojBgtdcaNPHUfZu/1SY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F0aRdp78vkaszTSos8gntKWhg1LTFtniraVnqJgthe9sy55+0DxHDjiezXZmc9NXn5Sj+T908D7k3P8L0rdnHmUpiI4Flb8oOWIdGJNoS+0c0uvt13InO1W1GNqBPMu4403CgluUEvaYMsRc8P3GOH9n7rtc37jE3IUxkCfMqHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Uu9tbpU9; arc=fail smtp.client-ip=40.107.130.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0ffWpZihP5/2FRGz4oy0oWTsSQrmIRflKxSLncD9OYb6Pm+WhDstXxS4ghlfLqKDk/HxIOhqD6HdMbT84PkxyxC6tP+l88gyDcUnE3C1glvs4p36tYzWTjXYEUjV6/jk6rMVu+uqXzt6qpC57psau+TTqCzX8KNCXGrqQtQlxdaYmYkTm4tFodAyEycW7Nr7AseuZfN4EY6fZ720Fl+0RVbdEw+Z3Y4lNijBTuyGxyxerfN7M+NEtJBGSsR5u3f9x+drRn9Cv3YZKUazKGpvJlNKfB2FYKFyCJPcOKdn4MBRKFKJW9SCdQ0zv+u7fCWTqCJblHXM2psK1v62PzLKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAtf2+AKP6b3V+8/MBVKvRrStXKu+odSQteQs8jndp8=;
 b=TUvpiLwjdzhJjT+9U7xsZO0eH5jhYl9089pYgCdrYhlR3bvquITQQkg/S7bKCxQQ0khuBdjXj+22UefvlMdhcQ3u5TSzWmlCFfJP86YeIBQGhwGoEwK3Vh+WFIXneydH0ZD9QA74r+Rzp2+8DuCnH5KcReBQV/xiWL01LDKrtSysWicxUBlo60Z2iaPSCB2saFtl/zuTIi32C8PDmC4QO1Eog+XAZ0KfvrHuNRlFxklrxGRZwYA0bzupHUb7rhuso1GAYLLWWr8trbAheevMDJWP45DuTCkI1J/QfBlaqd6AAhBybRP05htqvbWj4yCLLZcOLWvUezSrc4g7r/4qXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAtf2+AKP6b3V+8/MBVKvRrStXKu+odSQteQs8jndp8=;
 b=Uu9tbpU927SDHqV6MLz9QIPM6oj+DrEhCMq/gxbFJqgxqEO9crZqX9WOl1FuGlhtQR7rVMz586a4wZ1aVz8f16ei/OYMmZibp5O3MLwtJZHRufLSutc+ONaQ0sHASaytey/OYO2iGLyVbeQ1vbooxlCe5X4EeyA8LX39d0k9rndVtAx6bLbOM8mnQO/kbANOKvvxuhOMcxxKm8os8DUd2GH1naxZZ6A4Xaq4ht8SBEMGWl9eGh7XN7oxkiXIZBF+F9qUy+tkDlU/In+gfvh0hRKRd9whpSt6KWZnxIy8FCJAU+2xKrjBXT5Vm67DIWYkIwyPcXei8Pc9RcfLZ0E6Rw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8535.eurprd04.prod.outlook.com (2603:10a6:10:2d6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 02:05:12 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Fri, 15 Aug 2025
 02:05:12 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, Frank Li
	<frank.li@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "F.S. Peng" <fushi.peng@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>
Subject: RE: [PATCH v3 net-next 01/15] dt-bindings: ptp: add NETC Timer PTP
 clock
Thread-Topic: [PATCH v3 net-next 01/15] dt-bindings: ptp: add NETC Timer PTP
 clock
Thread-Index: AQHcC3DcRrsjBmycsEKPdLCqjefu2LRh0wgAgABSgOA=
Date: Fri, 15 Aug 2025 02:05:12 +0000
Message-ID:
 <PAXPR04MB8510249523464C218B5530108834A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-2-wei.fang@nxp.com>
 <20250814-hospitable-hyrax-of-health-21eef3@kuoka>
In-Reply-To: <20250814-hospitable-hyrax-of-health-21eef3@kuoka>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU2PR04MB8535:EE_
x-ms-office365-filtering-correlation-id: d6fd2080-37ff-4241-a104-08dddba02b3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UweRG/gvCl4PNBAwvzWxhZG08Cu1LJKDj2A5J9bgTxeFdYI+bEV3G5lIcXbb?=
 =?us-ascii?Q?xjIqi3vGT9EMA/DbVc4+yxdiGT2P6sbSJP5n3NeBFsh18TieQy4cnSSGzHTi?=
 =?us-ascii?Q?sXfvlEjstiC/ojo2Qp9p9lXuM3wIpyewG5ODsGhyVoW0hbzK+LYSech6gEHo?=
 =?us-ascii?Q?WXK+Iyvg0C7W7C/LdXJANhncb47Er82U2dPQqDf2MBFbSJ7TgcpkB+pMAmVv?=
 =?us-ascii?Q?EmAhalFeatwXoo2E9mOPHijDZdFDbnjrM3r0lbHxmVrYp6ck1cEDWfCxaJvz?=
 =?us-ascii?Q?94jQNvlDa0QTXyGbp8yeo9FWSkZL1MUGw7NeTF3HlmNmzBV3foGpInnZQQKh?=
 =?us-ascii?Q?FmGQ4Qopxl4fnzXbX57fBYkf4QcHWgSfgJ65v+dbvWW+xE6hPbydjL5ZgkwZ?=
 =?us-ascii?Q?L/keNWqn3YIlYcHKOegjN8CQn6FWscveh/Yx/BeZFZAcOnZXDULs+Gexah8x?=
 =?us-ascii?Q?BOEO6BWyeRi5R+y06byRvIz+kvHLGoBZlQt6W9IFlc3Sigdkk8bWPyq4QgKW?=
 =?us-ascii?Q?ylKIeX+hxbOXjSIaLMJqnRU8WWLvpGJACD0lu3Q3SUonXKYSTStIM8WT1G6y?=
 =?us-ascii?Q?zqcJNwHYvnC+Rm3Yr3aftO0YDKgflVLqpQQthG0DVMFuPni3xE7bC5B5Yc/m?=
 =?us-ascii?Q?RDajUjTvT/+GFEm1Fdsd/0qZtk1LyfSXogqLt6A2QzJ1KRqgdi9iaQ1H6tld?=
 =?us-ascii?Q?FzTokRZLrY2UQ9CkFqqgqL5DkGNyU/0vDwK7rGceiFzpxsEqpZbudrfDYFEd?=
 =?us-ascii?Q?aWAc/ftc8PElJdWZ+o8snTIVPsHht3VPonXoiI9hU6TgYypCHdzrzFHLrK66?=
 =?us-ascii?Q?lyEXvdyxEmOhc25eATKu6wrquTdRNJGdS2/oqVuZ22UIYEEY4YIwXYowpuXl?=
 =?us-ascii?Q?cDAL1OGs66wI/G/7Rqmxw2tKGKex7br4e44+NYvFZZ6gfVHUvNM3w6tR03Sa?=
 =?us-ascii?Q?Zx6gH8u5Iybk7az84ZeKHSqeLaO6RxH64mwD6T1vvvFsOBWSH68tZtPrfLAJ?=
 =?us-ascii?Q?t5HYzEKwhaqvKhFnuTXN0SDLoe5GlXdd7k9IJW5UIZG34OSyzwbRABF2KMPv?=
 =?us-ascii?Q?A9vzC7ScTXcBj7BR2GKOpX353vxd46+zlOaZb+IJjHEvQEUNCjKz4YKyogbo?=
 =?us-ascii?Q?iHlZOuksDFLVuFGDgjni88thj8F//MQlyzZYMWtSQ5b9PEPzk1CyoYRGj33/?=
 =?us-ascii?Q?Z01NwzFoL9NAPeurnObJUoyVVLG3UGyA6//9FH+sy1JqzLa3IYW0GpnC5v3M?=
 =?us-ascii?Q?2nQBSjoTdHAh2UfEYQA3RDsYsykUqgEYmjNxoyfUgU3g7O4Pvjd/nUKk5OPc?=
 =?us-ascii?Q?e1ht5dEQ7lVIyvQ5R/c8qb80vOwoltTzuFU6MKsekiFXl4TBODw1vnoqnvk/?=
 =?us-ascii?Q?TtszQFIpbWpYu3d/xKpm0oveusLge193Qji2Fq9pVSZNKnrUitmwSI5TppUm?=
 =?us-ascii?Q?TdGIiCujF/vcAc89mA03SYvjkOtkj2ThiibkXietgm1MdPzmBBGa+rYQO3nh?=
 =?us-ascii?Q?2DYnSHF2j8V8BQ4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BfmNb/TgYMLqPsPlhuTxjqZUMvcm95o/jKU6vSIUmsVMO8oaCjLOQoHozv6d?=
 =?us-ascii?Q?CoviAQxBHrVmRpVQliOwF8qGYdwpSgWSkLg2E5aq3mfDdzkPbVOzB5NlilAz?=
 =?us-ascii?Q?ISGAdcqDLPyPHfvIV0zkth5zl0VOQ8G0SVAJGc2eRR1lSdemuDKwb9ijZ/QX?=
 =?us-ascii?Q?H5q77qUTNqxvC1vFmu0ccl4FgGmCJJezBfOM1TbLDTsIhXcWdG+ovgpCc4+s?=
 =?us-ascii?Q?ecwgODIadpiNoGJR2wRrmnSJvSAGkwI0gdNzOBLpCN/bWj1D3gl5vQT09+8Z?=
 =?us-ascii?Q?RC5V6yNZukJFAQLOLUvOIU5TlnPOOO9Gn1dlrIK7clUgrqn/z3Jn7cSyvyZj?=
 =?us-ascii?Q?gKFM0Wb0gs4LvSMQnAKbylMk0W8hyRlvZJMlmeZHv77iMDJrka1yujJHSoGD?=
 =?us-ascii?Q?4jFjOYFBOMbzQvvBBRs13rmZ4vz4K5Wqg+LDPbiRGRgzOGFK66nqNcFIYLza?=
 =?us-ascii?Q?mXAfZW38ClJzSSGFwKttnJAg+TPzoOa03IY3FxRt7dcdqvMvP1q9I/t71nFq?=
 =?us-ascii?Q?muJu/Mv1jE5qPowVRTGIRipn+h5ZJPqjecjaa21/shaVpYhzVWGHXhkwvWpy?=
 =?us-ascii?Q?0tci+za3J25VHn3UiO3epQ+IVxKQMzhahATlNcn/uPCvC0iOAEKoRwagsTRC?=
 =?us-ascii?Q?kba/QCDm2b5egGMiloqHdALCHmCjpcqcIvC0PI/8SX3hJlsm3aqtLNG3k3qR?=
 =?us-ascii?Q?mguT/I1sYZUWKCcIKKk7ikOxXMIms8fBAI5mc6l4aCOniSBsAt5NVBrB2yaw?=
 =?us-ascii?Q?lL/nTeRiqgjOBe2LF9xXAOJ/4PRgX67uE8ijjowk/uJFHUMgDzU57ylYRNCU?=
 =?us-ascii?Q?zWXrM7N5dHZORubWFJuGxLXDmOw5I2Ez3Vk6nKv4atVejMXuFVBYZGR9I698?=
 =?us-ascii?Q?73QiLQkBh5SP/0YzS9EsgEiEI3MhyeAivQOuq79G6UPFw4bqaUTLI89rSQrP?=
 =?us-ascii?Q?9yyCuZ1dENrVMR6Tyj4ncmSpJZ++aO6NpTi2RHzavQw67szp/7GXs4nqbD25?=
 =?us-ascii?Q?BQg9WgLylbnzfw2dAYrQpikqW/JdxnynrZA/r+e+GuMXnC4wr629NKc4IKTw?=
 =?us-ascii?Q?7IjHwdkhIZ1Mtu7GY0jspWTSG2U1/0TqkQbJSn/ldft7FCzzziKF8VZSCWlk?=
 =?us-ascii?Q?ydJcUqXZuN27G1aj5/8Ydg8aEnBqw5E7gTF0O/sW35JFWzQjXqimeOxLGbjh?=
 =?us-ascii?Q?I4QAiqVlPFiE3LUGHM/3VKOea6MCyZX9X6Q8b8QDW76T7tZqbaWkivs42P/U?=
 =?us-ascii?Q?Iqjs5+cr70NyNPndF5JWfIIkOBQcj9fXCvyS0VwS5sy4m57w9qm2g9uwEqI9?=
 =?us-ascii?Q?gekiUEZi27XBPi07Cx9HwjtJyj+PbnsnmzEOQlb05Z3QgE84sazuUEHhUBmE?=
 =?us-ascii?Q?2MG8OhVE3Y/+R3GyO7ifou3A9BNrpi2A2JubiSV/xwNyC5x7linN0XVXRinw?=
 =?us-ascii?Q?8Hu1IqUDIKIihIcgt5JIcmhbqoBbyqaNjwbCPQfD2fi9LOlH+50ogcZLCepm?=
 =?us-ascii?Q?FwYGq4yqGJHGZLT6wnEl407FnRQVLOHeI6iGW4R61glS4RyAHHdHIt/0Vx64?=
 =?us-ascii?Q?IxK+kRYjfRD6OAK2RHQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d6fd2080-37ff-4241-a104-08dddba02b3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2025 02:05:12.2961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8A8ADOISmTdPpW/plpht9V+oC4XNsq976oVCvayEhKBTgDY2IcjZiSQ54bjUWY+5/Ra2zY4dR+nYVDSy9LqMVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8535

> > +title: NXP NETC V4 Timer PTP clock
> > +
> > +description:
> > +  NETC V4 Timer provides current time with nanosecond resolution, prec=
ise
> > +  periodic pulse, pulse on timeout (alarm), and time capture on extern=
al
> > +  pulse support. And it supports time synchronization as required for
> > +  IEEE 1588 and IEEE 802.1AS-2020.
> > +
> > +maintainers:
> > +  - Wei Fang <wei.fang@nxp.com>
> > +  - Clark Wang <xiaoning.wang@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - pci1131,ee02
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +    description:
> > +      The reference clock of NETC Timer, if not present, indicates tha=
t
> > +      the system clock of NETC IP is selected as the reference clock.
> > +
> > +  clock-names:
> > +    description:
> > +      The "ccm_timer" means the reference clock comes from CCM of SoC.
> > +      The "ext_1588" means the reference clock comes from external IO
> > +      pins.
> > +    enum:
> > +      - ccm_timer
>=20
> You should name here how the input pin is called, not the source. Pin is
> "ref"?
>=20
> > +      - ext_1588
>=20
> This should be just "ext"? We probably talked about this, but this feels
> like you describe one input in different ways.

The NETC Timer has 3 reference clock sources, "ccm_timer" and "ext_1588"
are two of them, but the clock mux is inside the IP, so we want to set this
mux to select the desired clock source by parsing the clock name. This
method is the same as https://lore.kernel.org/imx/20250403103346.3064895-2-=
ciprianmarian.costea@oss.nxp.com/

>=20
> You will get the same questions in the future, if commit msg does not
> reflect previous talks.

Okay, I will add more information to the description or the commit message

>=20
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/pci-device.yaml
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    pcie {
> > +        #address-cells =3D <3>;
> > +        #size-cells =3D <2>;
> > +
> > +        ethernet@18,0 {
>=20
> That's rather timer or ptp-timer or your binding is incorrect. Please
> describe COMPLETE device in your binding.
>=20
> > +            compatible =3D "pci1131,ee02";
> > +            reg =3D <0x00c000 0 0 0 0>;
>=20
> Best regards,
> Krzysztof


