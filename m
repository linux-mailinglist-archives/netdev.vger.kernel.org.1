Return-Path: <netdev+bounces-120326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CE5958F6A
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 23:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D12FB22072
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 21:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B0B1BE228;
	Tue, 20 Aug 2024 21:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b="TvBtIGba"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2061.outbound.protection.outlook.com [40.107.241.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3514449626;
	Tue, 20 Aug 2024 21:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724187985; cv=fail; b=idBMtqUFKw6TbFiLZiqn3FH+0WxpmZXbCoauFjjIdO59InAIk0GJ1uEUmvHRQGrMgYFSCG0Pe+JdCEyPBguzrx7ISgFMac8jpQmV/0QHA8LRE0hY5CHkIf6A2Ks512jIzFSWF8r1C7+b7zaNKEIxjFUjn5nbC1U8jHKO/7CiuMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724187985; c=relaxed/simple;
	bh=dq+/rOLB3TY//9OuYQ8DV2BBiCy+jU0I//hyKeBpGgg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cA9qHIMNeQvK+5LeixsBOBt4ntBPHylWLDP5x0zC+rDpdQk2xOL4W29HP6PjSqo61cY6AYLEOZyeqkBP+xYYBBlAnWOQprgMmbJJcTqXZmo4xGA0xoIuxp2eOIlKUw9cLayuPWrKr3MoaBxMrkGYvCM9bl4E8vlVkdR5r5IdFLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b=TvBtIGba; arc=fail smtp.client-ip=40.107.241.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxXSzhRYS99tgqTR8poJMWKFJRoPU05oHJv9kSPTWfAKedfyydL9OE2DuCEBE7q0m1x7/QWGc3msqfZPTbBRuo/bY32q/q5Vf2ajzKLd2Fqc9cv6ZtdrdyJ9Ol9kYvht9dIPZxnaWbPyavwT5wnck/UyyGiaXErdbg2F8/nK6iZPsm+rorX2WnqhTh2UqQHpR/bkbxXz3cmCrLYA6K7BwWnrZ8NztyQMfmUnudDKdl4nlHCgHpdXRmrmV8ObRtew9TLY7a8DoAsO4AvkKyeyzkTBaxGWF0z7k06mJNDneZDMg3uMzApXflsPUeYzoNkbjtM//8Sr2ZkXZN4BHzIEWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9mYKcauOHcJjwko2GKDYbpzLg/IPtblq6TJrczIXps=;
 b=IfqioRQl9U6tio6q98y/bfU6fXT7Q0aqmEM+YpoTcXU+FEaB0ktA6qRTnnNvDx/PnagLQ2DIHcv4VUMlgoqlF9hqIUv9CvHSTmCEOMZtnMdjW+9DS9RsmEt2C4CUMZJ2srSFuJW2g4nr+7iuGLgaDufb0yUipfmTdT3PYrWjaCf7586W1r8istmh2bHReDU409pA39m/kp3U+Qj0t1gD2jHgvs5xDGy+ygArt3SJnpW0GDG6jqfCbVAQ/CAJREBDsCw/3mxwxiibSiIzSgOtn/QavChch2SZEWiSxjjmIWOJlMbrsOponSHC5kmllz3DXNhACA6vXV5MaL2F563izg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9mYKcauOHcJjwko2GKDYbpzLg/IPtblq6TJrczIXps=;
 b=TvBtIGbaTAySjIn/TC2CuvEJQqK6QmdW+EB0rK+JJmJM90HthEemVLnc2Zn43es9lJouBtZFWd64tzuTKzjW8YA7p65xMOBysgqXZCgvKDMgfZg5kR71nprF5cwYoglq+AYRzCHrcrFBkpgSIJKEhzzuGHPLCyKpbHYIyfw3o+M=
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by AS8P189MB2071.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:508::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Tue, 20 Aug
 2024 21:06:19 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab%6]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 21:06:19 +0000
From: Kyle Swenson <kyle.swenson@est.tech>
To: Oleksij Rempel <o.rempel@pengutronix.de>
CC: "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "thomas.petazzoni@bootlin.com"
	<thomas.petazzoni@bootlin.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] net: pse-pd: tps23881: support reset-gpios
Thread-Topic: [PATCH net-next 2/2] net: pse-pd: tps23881: support reset-gpios
Thread-Index: AQHa8mpN+TA+JG1k4E2yihVubvKI7bIvrj8AgAD2gIA=
Date: Tue, 20 Aug 2024 21:06:19 +0000
Message-ID: <ZsUFLDaMdVPQQ98I@p620>
References: <20240819190151.93253-1-kyle.swenson@est.tech>
 <20240819190151.93253-3-kyle.swenson@est.tech>
 <ZsQ2fuqWkMYwq_kh@pengutronix.de>
In-Reply-To: <ZsQ2fuqWkMYwq_kh@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|AS8P189MB2071:EE_
x-ms-office365-filtering-correlation-id: 003881ae-570d-48bc-7be6-08dcc15befff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?adysQvw3VLyySZ+fuOthmdl00LEKRDB17/NbiAUjLma8zeZNsEnypm1nQNbY?=
 =?us-ascii?Q?/PBbi4KAIx6yR90bGqSTQ55BtNe3lmz4gfsphtC72WdSdOB4McYSFZK2u6Gs?=
 =?us-ascii?Q?2AaWOcgjhmMjApex22/u9MmY7ae3ljq+pYrhVDNak1DkUlwKGNPdtt058T0O?=
 =?us-ascii?Q?PbwOtSwHss9sZnl8YnkvY6i0vbHgzp4+G+nLbSI2ktjnK+i9RErKa2SLEsbG?=
 =?us-ascii?Q?Dhbdk81Rfxw5xJ4slyTacUEP1TV1Hr7L1PwvCfrCC+3dlSy4Ar4trrGXR2bg?=
 =?us-ascii?Q?aZA/NB801DmQG52olKAGT66r920XhEu+g2KpVpe9Z21Wo1NtKeDJsDislaHw?=
 =?us-ascii?Q?gDFGxmCaTvpPWs3rtlOIpwVGQfAuH/ZutxXXNrLRo2nxsMWDSIcV3iViCLzC?=
 =?us-ascii?Q?OBUkZohqQaq6c5S9euy6u/jYs2XPJpQn3+kkZctqdCfSSicf4Aj1LzfOYTFi?=
 =?us-ascii?Q?lEEUAmohPZaA2g70/9KX/Bvp+Aevap8nKq9htmHd4sBrc1HkX9tEl+g/7Q/X?=
 =?us-ascii?Q?gEx578J8lXhvNq9U6NslAgyMXk4kSVW+9oop0wDzfZrhlXvQ4lhxk+LMNva6?=
 =?us-ascii?Q?opRYyWFu5qvQKihf5Mo7D48F9vmgoXWKxknwLw+CJt0oZ0jVWRL98LqgsdUT?=
 =?us-ascii?Q?1Rb69A1us6zAXlNsjV2Y3VkwutGiQHkUsSLEqMXk1oAryLsfqgcw2JM2CWB7?=
 =?us-ascii?Q?4aaopWy89DZ6B8QPZ7Et9PFLZPn1OIUkwCQzG6FV9+U9ELCqMyN5ZX/kE2yS?=
 =?us-ascii?Q?dXN4S7S5GjzFdp+TU/L6SQJIEdAxo9/CTLaXvVQpANMB40oR4+i/UmRlhJan?=
 =?us-ascii?Q?eeSvdWz4hoHocg5vxa31oZRaBS9kcwyZ3IKJJiwFZLT5J1gNqqUWEWqcE5ei?=
 =?us-ascii?Q?Wv2pmpfG6Nis5QOIxb6/SeYgeM4RfDbEImZ0PdHEjQ9++igTA7oRRTYyL83S?=
 =?us-ascii?Q?KBfJExr8l3C1BVLN6Uewl847H5Xsx/nck/fLOLlkXLe7Dmw7Cw+8EVdhki1V?=
 =?us-ascii?Q?9bQtk66c7Zi6gE4XUP5H/+yNIIGCWGA6oFLMCc2Vhy2SkYvrV4RdD2WwlK3d?=
 =?us-ascii?Q?8+cd0o0TYRVd+iP60kTfIt7+kVsTvkCrxZN2sTkA4dlgufRNaP/EcobBxTcT?=
 =?us-ascii?Q?1vU1IEb/IV60200yGcscuU2j+EzkV8XShjTfs+H9/OFnHeNVYXy9xOIXwXq0?=
 =?us-ascii?Q?e9Z/kq8s4eCd9M4WXbSc+ra2v6Asv2pGc279+ifzybVJ3acoMRfYZWJhC21h?=
 =?us-ascii?Q?VG83JqDKyu8UaEdzURGjRqidiGmM6Y5nCace1OT7vVzaQGqQZW3VkRnpuscv?=
 =?us-ascii?Q?qBc6wllL3u62q9scxuE8G9JEKDSoD6ZJXKjabTfZeu88l/LjBOiW8RMxFydo?=
 =?us-ascii?Q?/e0cqeI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?L8k1aN4U17NarPheVkuis+QUIrOMOO2TwYh5pTosQN3lztjUTwY0YyytAOI4?=
 =?us-ascii?Q?OnkyYKWTgkuwUOL0waME1LmIEHQqZvFlcRhy7iBWvhlQIxpHksQ7Tij8QOJB?=
 =?us-ascii?Q?Gpm6SUIYoJ2KH+M9twjGfQjBOlLYrVRPjbTVpa2nkkNAe0DCyXtlVeVb9z2y?=
 =?us-ascii?Q?zC/S0KPYJTyZkf/8V5ZpBuNfzyeLHl7cYzFL4K5bKX8VVIWEfLjzPZpxb6Vm?=
 =?us-ascii?Q?2oxCkqWWq0NZrWVYbraJ8bzFW+Y7WyXR67z+X370vICCnTmF/Dla7OUvSdZY?=
 =?us-ascii?Q?Qw3ArzBiI0GLZwBgzd5sH8vj6DZ8+DG4p1re3DwRoD1IcBSi1lyXR3GL/C5Q?=
 =?us-ascii?Q?u1Jzn+2GYt80Ubsyn5RH6BqsXqSNKJPSKzus3IHSVfeeh2A7ugGOPx6FPgNI?=
 =?us-ascii?Q?a1kb00DpjjvPuaJM9Mxjr1u8pDarIwiMzpo7lViJkrfL0uq5ZDcdiFMHVvcd?=
 =?us-ascii?Q?23pmWXqVGwWDZdzOmY8M0+p2X1tqv/B8v5cyqjEgcQXkEt8Xign/o4ZfwBoa?=
 =?us-ascii?Q?5AcvOg3xpEW1fzwpmNGPeWrxyp6ze7tyUx+8SFnkIt2/u1QVbQFi98fO59Wz?=
 =?us-ascii?Q?fxMnVTj7uak5yu5R+N9VmZOAAxkpOT1C3gcZAP6vIdTwWta1TrVHqwhMUaKv?=
 =?us-ascii?Q?HE63i1k7sRNvm13lZ+c/A39K65wXou41E+8oRRJR/oxhr8j4l6ioaDqYbjuU?=
 =?us-ascii?Q?Qwyy3t5ZDVlmdRX0uvjVXnWEo7RVOeo1JR4wlCvUXaTVP+5Ydpdu2JHZkew7?=
 =?us-ascii?Q?AuLk9/0l/pnN+yTqHYlW+abS2Z2uBO1fyMVmngJ/AFj72bvHJGgwJqrYl7s/?=
 =?us-ascii?Q?eYBtR6t3zU+QSfgq0W0ed0fERox61KkVkJv/LRLMsLi/0QlkNDFCKroZLeZn?=
 =?us-ascii?Q?aPsfYlQRPqjCkfNS9Vj4ago1U160oUA2xZ8c/YjGaoFa0hcs/4RJFevU2YU6?=
 =?us-ascii?Q?HygWWJrdvXE47p2fJxdRPbrsDk9eJC6hJFKAD4fVrGRxTYCmv7iOf7SHIrCz?=
 =?us-ascii?Q?mCYx8tJXbDB7qQ82or3WWmqBrvJ/5JL1tGkwCf8PoJgipjenfq9jhbGUUec4?=
 =?us-ascii?Q?MSHFM2O036xc44jhgoy8yxRjkOgN13JOjYDLecyQJdK/T/K+QH02S99vneDY?=
 =?us-ascii?Q?S2AybBeo6guzgUMZ2Vm2yyfo3FFEBBjITsekouj6suGssM3uxN1vwUzrfUpu?=
 =?us-ascii?Q?nZ2MNCIOAav9DJUQrmD2TkKWwYA0j02yf8mZCJBC7ByTUvq7SJBZxXCZ5yQ4?=
 =?us-ascii?Q?WEChiH4bpFGVY2yVZwot4UhIgJy+p6RAuxvaLJaQpBLXOammEbVg5Blc3gKm?=
 =?us-ascii?Q?X4aCvN/HQLH8ZoqO/pJFhaF01HbXU7ao4yNWTNeQ31GLliXksxLzlJyE8yRp?=
 =?us-ascii?Q?naEUojhDmli3138r+LnAUMJBTpTnAL3XkHYI/1PwB47jq6ITwHJ1IAUFG2lP?=
 =?us-ascii?Q?EYWogkKRQAj/yB5BPI5A+EaDJ5IhIz7pxVlzk8KoAes5qz6CErWG137oDcxR?=
 =?us-ascii?Q?xBF7M/peulLDrYHehejcjMQMRJHSpZG8NNiMTK2vk8Fjvq+DYMCgmqekN2Kg?=
 =?us-ascii?Q?RgXd5TpNu7gl9NATurayp5XMUNZt3gJ0RXlBGTfLKUr6DmFXh1FHGOoDp6fJ?=
 =?us-ascii?Q?YA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E60D562AAC17FA4DBA6A5347D39D4924@EURP189.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 003881ae-570d-48bc-7be6-08dcc15befff
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 21:06:19.2349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x5fRGiOJHGoVuMYZbqU+73vL3pdY5GxXW8rGqqT5IXaKhOJajKeU65hnV49Flvq4tBg6krL7PZ5K6h4y+fTYYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB2071

Hi Oleksij,

On Tue, Aug 20, 2024 at 08:23:58AM +0200, Oleksij Rempel wrote:
> Hi Kyle,
>=20
> thank you for you patch.
Thanks for the review!
>=20
> On Mon, Aug 19, 2024 at 07:02:14PM +0000, Kyle Swenson wrote:
> > The TPS23880/1 has an active-low reset pin that some boards connect to
> > the SoC to control when the TPS23880 is pulled out of reset.
> >=20
> > Add support for this via a reset-gpios property in the DTS.
> >=20
> > Signed-off-by: Kyle Swenson <kyle.swenson@est.tech>
> > ---
> >  drivers/net/pse-pd/tps23881.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps2388=
1.c
> > index 2ea75686a319..837e1a2119ee 100644
> > --- a/drivers/net/pse-pd/tps23881.c
> > +++ b/drivers/net/pse-pd/tps23881.c
> > @@ -6,16 +6,16 @@
> >   */
> > =20
> >  #include <linux/bitfield.h>
> >  #include <linux/delay.h>
> >  #include <linux/firmware.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/i2c.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pse-pd/pse.h>
> > -
>=20
> No need to remove space here.

Sorry about this, somehow I missed this gratuitous diff

>=20
> >  #define TPS23881_MAX_CHANS 8
> > =20
> >  #define TPS23881_REG_PW_STATUS	0x10
> >  #define TPS23881_REG_OP_MODE	0x12
> >  #define TPS23881_OP_MODE_SEMIAUTO	0xaaaa
> > @@ -735,10 +735,11 @@ static int tps23881_flash_sram_fw(struct i2c_clie=
nt *client)
> > =20
> >  static int tps23881_i2c_probe(struct i2c_client *client)
> >  {
> >  	struct device *dev =3D &client->dev;
> >  	struct tps23881_priv *priv;
> > +	struct gpio_desc *reset;
> >  	int ret;
> >  	u8 val;
> > =20
> >  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> >  		dev_err(dev, "i2c check functionality failed\n");
> > @@ -747,10 +748,20 @@ static int tps23881_i2c_probe(struct i2c_client *=
client)
> > =20
> >  	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> >  	if (!priv)
> >  		return -ENOMEM;
> > =20
> > +	reset =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> > +	if (IS_ERR(reset))
> > +		return dev_err_probe(&client->dev, PTR_ERR(reset), "Failed to get re=
set GPIO\n");
> > +
> > +	if (reset) {
> > +		usleep_range(1000, 10000);
> > +		gpiod_set_value_cansleep(reset, 0); /* De-assert reset */
> > +		usleep_range(1000, 10000);
>=20
> According to the datasheet, page 13:
> https://www.ti.com/lit/ds/symlink/tps23880.pdf
>=20
> Minimal reset time is 5 microseconds and the delay after power on reset s=
hould
> be at least 20 milliseconds. Both sleep values should be corrected.

Sounds reasonable, I'll change the first delay to be closer to the 5us
minimum reset time.  I need to review the docs around delays to pick the
correct one for this case.

For the 2nd delay, I (now) see the 20ms you're referring to in the datashee=
t.

I was looking at the SRAM programming document
(https://www.ti.com/lit/pdf/SLVAE1) and it indicates we should delay the
SRAM and parity programming by at least 50ms after initial power on.

Should we guarantee we meet that 50ms requirement with the 2nd delay or
would you prefer I just meet the 20ms requirement in the datasheet?

>=20
> Regards,
> Oleksij
> --=20
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  =
|
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|

Thanks again for the review!

Cheers,
Kyle=

