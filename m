Return-Path: <netdev+bounces-121808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D7D95EC5A
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 10:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30D891F211E8
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 08:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B397313D61A;
	Mon, 26 Aug 2024 08:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I34TMLi0"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011031.outbound.protection.outlook.com [52.101.70.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B11144D27;
	Mon, 26 Aug 2024 08:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724662235; cv=fail; b=DppCYQttK6fD0MdM732mnaWTN99zumSFfBP6A/CD57sPZRS7K0ELgFYqVNELiMKm2EkJmBbAfpawkKPoIc25/pilXE4/Q9HcAmPhbkPJaIiKSiAczz6XQ0rK0mLL27OcpUkdorwi/Zfx8vsmrbljWDScrCd/YBeJIAEi+neai6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724662235; c=relaxed/simple;
	bh=dpJpI9jfustZQpGfGEsBIXZwwdIdCOsJDLbjcoMDbIY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c6MUS07mQIo77LP/cC+hmHyv8cpez1AkhApYRKKLtJuEfbgoziWCQoBsv1t8A46bMctrltfpC2lP97IEjjc2UDG/xynBfj6GsUhdK03rOzNgnfs44KwtwBUGv1l1+eElde6GcOrzVntvvorFrZSONQbH8Y+kzhF0pThLl4qw6h8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I34TMLi0; arc=fail smtp.client-ip=52.101.70.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWtjRdg81rlJ2Y3nelClmP70pgjoAbjbsvgp2I/9cuR1BCPaHEtF1eA3XDLz2GbiCqddg1KYTVs78ji5eSS6bibHJv3ZkA8FUqT+EhoA8iDxG3A2w8b36rwsTbO5D7NDI719/K2Nd4oJW8kbAkDurw8p1rn/ZxaeCrFlsg+ZYR6l5O1gITKYkqK+TQ0qHLYYdk6wQDdTq45zDJN3SEP3o+2UyRb7wq5/FB/FFVSHG48qKqNuAYZtmuchqT72p2yiBwTb56QuGReDmQlri0yF3JMEhk+WLVt7Z2Mkq2IJ7foGDzZP4fBfmD2N/SpJYbQYiNrmQwM6O0LRwviEAuTXNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqVQHY0N3wDlYWxFVF7kKvfAWSMh6AtJoCrI6Cko3To=;
 b=h4+k8XtQpWo7SAuC6pXzPgK2NEuU0f1+62llQkUOVQmq5nKMTcb89Z3Ctqv5fsPCfxAMyC/8FgfK9rA9l3H15MHNHnucaK+zRtuCEL3yW8eJKFbju6/zwf/XnW2p1GlsRrJvgFQEw4dJzbWo7iLTcO29a5emTzD8TjPXPNlarkefowACvs/m/HyMxaT203a+DJ79TWieV//MNh97iPNj89FjiEAU9inyoDJkcj4KZbmq8ZMz+ezQbsVT6TN7Phr0ucCZ28J9ebmoYPLBIH74a5THYe2TdvoVisU2sO8vi03Z+7zu6h7fqftxnZNHYU6Q4DF/Hb4IyhYI7PN04k2bBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqVQHY0N3wDlYWxFVF7kKvfAWSMh6AtJoCrI6Cko3To=;
 b=I34TMLi0s8Q+gtHszGVrD95GxLo4ONA417QGLFBgIHlYSxD3EsOIjTQgOQVwfwlqx2FQZHiK3Xw/sWUcJncl/cZZPiySy0ENr96x+wH9Kc0pwtmRhLVJWT0kiPkAp/TAM4LNQBbzRuU0DK2g0Nf4/I5EeD93YsFZNg2Qx44txMLJV0jPlRA2ADPivnwLXrGxS39Z/0Ct6i38k98uJ3hi6+nKAuquTp62Cz6IWJN4df+C+iV6C5hto9zEkhpXLAzA83iC99j4kPPk/mjp65pYPJW+s3X7QBttw9toT2YMLzALDIbLCBvMi7LmlSvExclJ48TJ1rGoyruKcWTEkP/Vcw==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PA4PR04MB8047.eurprd04.prod.outlook.com (2603:10a6:102:cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Mon, 26 Aug
 2024 08:50:30 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%6]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 08:50:30 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, "marcel@holtmann.org" <marcel@holtmann.org>,
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bsp-development.geo@leica-geosystems.com"
	<bsp-development.geo@leica-geosystems.com>,
	"customers.leicageo@pengutronix.de" <customers.leicageo@pengutronix.de>
Subject: [PATCH next 2/2] Bluetooth: btnxpuart: support multiple init
 baudrates
Thread-Topic: [PATCH next 2/2] Bluetooth: btnxpuart: support multiple init
 baudrates
Thread-Index: AQHa95UBYei46L4Eak6mXCjcQnt2CA==
Date: Mon, 26 Aug 2024 08:50:30 +0000
Message-ID:
 <AS4PR04MB969273C25C97907BF890533BE78B2@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20240823124239.2263107-1-catalin.popescu@leica-geosystems.com>
 <20240823124239.2263107-2-catalin.popescu@leica-geosystems.com>
In-Reply-To: <20240823124239.2263107-2-catalin.popescu@leica-geosystems.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|PA4PR04MB8047:EE_
x-ms-office365-filtering-correlation-id: 901a711f-8c93-4b85-efd6-08dcc5ac2390
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nIQqC2W4ltc4h0X6CzzFlW3B66dO39BzNtYV9KVr2xSPKm3NYTBuVv9AVW52?=
 =?us-ascii?Q?pKDQ0aSIF+frm/3InvXJplDcjhQSm1AulNRGkYnKIvzmTnqtSAYc0lelded6?=
 =?us-ascii?Q?HXPE1GFLmQrLIWZ82MB/llBJD/R+Dt25yQRrohBLUiNUlM4DA+rsU0m1Bzt/?=
 =?us-ascii?Q?mkB4eZJ4PR4+LPJD17Oczfn7gVXHAcBRLPsqfXJcpKUUN2D/R5R3nmbGuYCp?=
 =?us-ascii?Q?K0EFJIuw2fOS64hCt4MzzUE9Ial/4JAsFnuJF3rrO4AnQoqAwOBI4vp8D0f7?=
 =?us-ascii?Q?wxokOHMhRV9xgjTm9WD/D9ti5jlIemMY6f64mSLQPAwOpXqvOOAVbkuD9cGz?=
 =?us-ascii?Q?kiVXpvl+d4GDRTuDDdCoid6yHHC5l2bi9+JerkWfZksbPbeXA7ua/tV26BO5?=
 =?us-ascii?Q?duTBj937xvF4rhwlyKoSp3srojEXSVyZaGUIAa0+WZhxM2zTqvBxASNfqkFy?=
 =?us-ascii?Q?gNJFj5jqi4xulGcs1VZ/NersgiDIav1Hpk/GhzItFG3zvCoRQiQKZYPDcC/4?=
 =?us-ascii?Q?vF/KenyA2ntVtTSwgzSY8d72A8JVKR6DW26czSpBZaLd514in7wPEJLyl/1F?=
 =?us-ascii?Q?ak//uxYevr4nZKsN53pOypOzr3rbvSl0wsLBJUy8WWFweam4l49E8VQYNlK6?=
 =?us-ascii?Q?LoZayC4vY+YuC7gvDG5VqiCYnVTWXvFz8GEWvWNfQ6Kq68ts5tKIdj0zfGeR?=
 =?us-ascii?Q?kwDFEJakcv81R+UHsNkXojW6kLpy+Zi0ns0SSOOGR3BcW0BZ8JNlcRfRUSdc?=
 =?us-ascii?Q?bqW5OH2Aa8hgl0RJjiHaEFhgo8qKI8U5k0VSm+5vxast7mJxpCST4OU4UP0t?=
 =?us-ascii?Q?rpdKUgOnGTS8HzpkNc4ZvUHpJqiiigfyi7xm3McpcPB1Tkz2o8CXxjt7BYkE?=
 =?us-ascii?Q?zE5USGkC2SpQarK+yuqUTE4NQ3x3I0V2Xj9MlV+phUXe6ByYGlXrOEIngukI?=
 =?us-ascii?Q?pg2BDYTba/rdgeEpF7MKoeuPDpApiPynUlE8ZGl3gKoKLsROrjzLLU1IIcvz?=
 =?us-ascii?Q?yCchlgUNBd+mfoZ8pQVOeXkcOBp5BWl4d7dTHx99GQhcRcwXeRrdE51UlF35?=
 =?us-ascii?Q?5XQcRY2WdoCYLuh9FhGCE05d+7otxZZtJf1xE4wy5qCJtxwsNspjeuitUyWD?=
 =?us-ascii?Q?dEQ8sYmkOvF7lK4dIkKjdVvEYoL38JAiAL/yhcyXPsqvWiWmLShFrMnzh85t?=
 =?us-ascii?Q?5KFx+VwXuwhj1fVPBHPq11hMgo98rmx1DjSv7C/aqsDyM1iRLG2xFLw9ILXy?=
 =?us-ascii?Q?ZlyrG7+2pyzoVMgm9TS7l5ylGV7NvMPXPNJw9DKKhIEbwLhfGsSHNqw9d6pv?=
 =?us-ascii?Q?ujcmT4Zu6I7VyB4tGYzTY6rk2ib1p4AOIr5Op7bM0PKEBiXwFiTKw/ePqNS9?=
 =?us-ascii?Q?E49NIrPPfr8NzlwoPo0jXc0tdO3bGc/bEafHnc+m8FwaGvNSgFV/87OmdOOp?=
 =?us-ascii?Q?KyiAj1ANoIQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Zga1b0YnwD5MKXyqDu+KOXICY9F+tgEVYrQrRzV35QJtDAcC16c54pn8/sch?=
 =?us-ascii?Q?mttQNQl8txOG/hjy81IAGydJ6TiIqLRUL1uYWwS4ZPMDoabnMiKFqXoSjBPV?=
 =?us-ascii?Q?JaHDXV73BVmGRDxUosPDs10fdwAkT9Mes7zv+4jLriGp3tJ3ZKQAHTycZVqV?=
 =?us-ascii?Q?9lZbY2u31jEgQEKJHKHCxJEYJzrgHCiYj4YIWnTfkz7Vbal1uL+G+MszfHm5?=
 =?us-ascii?Q?dqD4IzbnM5ywlEyLr8GPf+29VHWRe75zVOJ4dQvxxM+ALXY6Y1IwH3MBwbs+?=
 =?us-ascii?Q?0pdBLtuOxBrOl8goNCn5K/6Iy94EOIMEHdkF2ejscSLcmIkgodRcZaQUpwGc?=
 =?us-ascii?Q?XXPYXuIEBaw4+saUONwQqT8VeIt/XX0nMti4IUob0guYc41bAo8rbwP/Ffkr?=
 =?us-ascii?Q?zXZmz/8DzczNvFDqPRd6G5F2SFm8vg8IgeXVGle1GmEyY3/8LOA2mwCCuOKU?=
 =?us-ascii?Q?mj7mifojW7kKhJa+q6JNoRi0EwY2YVLS2XdLpqMc8NgfZKLd3Sx/IlRjIuLE?=
 =?us-ascii?Q?bjcYPHZDNi8LLwaBLRoqGM0SOJVCUN3mde3PnQ9pW5ETBbzr4FNpxnzHDgIz?=
 =?us-ascii?Q?KipqPZaB+NKTKyzcMl58zqZttaIeLRW5y9OjM2xbdyLX085b9tJvABErKY6W?=
 =?us-ascii?Q?+9zNIH2RsOJTXwoFQwGHPk4J9q9jSob6sd2nGoyB9WHe1UqVMbQ2ldGKAWlG?=
 =?us-ascii?Q?bplMZvaj2phcJW5cqSyDqZTT4RobXC3G1vvRJ+B0E29b9I9ZuYl6m8EA1Q6A?=
 =?us-ascii?Q?ZluVa60Ts/w4l4LjFe9qQGe/Z+PSCj0ewI676x6yV/eGX++oewOM1PYbEPDM?=
 =?us-ascii?Q?0yxOTvkX7BGHHyG4Hq7EBW1IY8+IdxZXwQJd7bPmKTAAn/9nG7aoTp1yw+30?=
 =?us-ascii?Q?UPnIfs+Z/+IOhHajaRGgE1s5Xuz+1HYV6Z4Z6HPwmFL1WIkdPH4AX8SIyc9W?=
 =?us-ascii?Q?xo2Bllk0IE9PTuyB5mkrie07Nuv40zMTotQz7PtfRRoYfA5FiBoJQTu2fqLv?=
 =?us-ascii?Q?J0GKdge3g2UACXiS3SHETu77kBWNikPLi7ribTiJtYybZe3HUVrqm4+xpBLf?=
 =?us-ascii?Q?SFJ7mLUCRIn+2AupT5xo4MBOBBVfUjbN3bJkGTxWcpoL0Qb5gtTHiEstUZGG?=
 =?us-ascii?Q?7Q9g166ZwDwHXgPCcOq9F//JP6thVhb+wsO05+Tu2peu900TY9lNRuZgf/4E?=
 =?us-ascii?Q?TdOvpzaNm/mkVaRTTGCopkBqLJa2CM4JYXeZbxgkKQ9dLd69u+UIt3u5+vC0?=
 =?us-ascii?Q?j2fGAvrZV7jyuF5fXEWK/215iK41DLWGxB8C2vhVI5ZKsWW/9eZuay1z78tp?=
 =?us-ascii?Q?A4Spmzw1j2WTWfibILdQH1LBNaHY011HRdNYf/WBHDErj8WNQQQ0g859+XWS?=
 =?us-ascii?Q?JnzfSF8MsoFg7xretVMK/SfdWbH/vBHOj4wiialpEaodwqnhykyOJ0LomUTj?=
 =?us-ascii?Q?tetqhnIkAc+35H2r0Ul5MP4c4e0uPtE8GTeLztCPFezA10rtWa2tSbT4R5YQ?=
 =?us-ascii?Q?GvxO65+BmFzF5XgAizReAuVTZWAXUup3KeepwUdCV5eSkwE0eFLMPtFB6bie?=
 =?us-ascii?Q?J0j5RrnDs82yMV3qbAV8nuiPqFfolNkxV88I4plr?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901a711f-8c93-4b85-efd6-08dcc5ac2390
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 08:50:30.1252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5RSI+qf8IdlsMfIX698lhwoBHY6Rybgck+uKO6BBuFhWaKlw8cZlZp5Tv71TmD0EaxPemtye35C7D/lZRYEtLqxdDZbgzInKsIlEHAAnKKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8047

Hello Catalin,

Thank you for your patch. I have some comments below.

>=20
> We need to support simultaneously different versions of the same chip tha=
t
> are using different baudrates (example: engineering and production sample=
s).
> This happens typically when OTP has been modified and new primary
> baudrate is being used. As there's no other way to detect the correct
> baudrate, we need the driver to go through the list of configured baudrat=
es
> and try each one out until it finds the matching one.
By design, it is expected for customer to know the OTP setting in the chip =
from respective module vendor documentation and mention the value in device=
 tree property fw-init-baudrate.
Please check with your module vendor to synchronize the OTP settings in eng=
ineering and production chips.
Feel free to create a ticket in our customer support portal (https://www.nx=
p.com/support/support:SUPPORTHOME) for any queries.

> @@ static int nxp_setup(struct hci_dev *hdev)
>                 clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
>         }
>=20
> -       serdev_device_set_baudrate(nxpdev->serdev, nxpdev-
> >fw_init_baudrate);
> -       nxpdev->current_baudrate =3D nxpdev->fw_init_baudrate;
> +       for (i =3D 0; i < ARRAY_SIZE(nxpdev->fw_init_baudrate); i++) {
> +               serdev_device_set_baudrate(nxpdev->serdev, nxpdev-
> >fw_init_baudrate[i]);
> +               nxpdev->current_baudrate =3D nxpdev->fw_init_baudrate[i];
> +
> +               if (nxpdev->current_baudrate !=3D HCI_NXP_SEC_BAUDRATE) {
> +                       nxpdev->new_baudrate =3D HCI_NXP_SEC_BAUDRATE;
> +                       err =3D nxp_set_baudrate_cmd(hdev, NULL);
> +                       if (err)
> +                               continue;
> +               }
>=20
> -       if (nxpdev->current_baudrate !=3D HCI_NXP_SEC_BAUDRATE) {
> -               nxpdev->new_baudrate =3D HCI_NXP_SEC_BAUDRATE;
> -               hci_cmd_sync_queue(hdev, nxp_set_baudrate_cmd, NULL, NULL=
);
> +               nxpdev->fw_primary_baudrate =3D nxpdev->fw_init_baudrate[=
i];
> +               bt_dev_dbg(hdev, "Using primary baudrate %d", nxpdev-
> >fw_primary_baudrate);
> +               break;
>         }
Looping through a fw-init-baudrate array and finding correct baudrate throu=
gh trial-and-error method would increase initialization time by 2 seconds f=
or each failed iteration. (command timeout)
This will affect other customers who are critical about the time it takes f=
or hci interface to be up after device bootup.

Thanks,
Neeraj

