Return-Path: <netdev+bounces-231500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD62ABF9A6E
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 03:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E90D4F11B9
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8D3207A22;
	Wed, 22 Oct 2025 01:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ABqynvoL"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013048.outbound.protection.outlook.com [52.101.83.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768D31F37D4;
	Wed, 22 Oct 2025 01:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761097914; cv=fail; b=Wh+NmlmSgQ9ki80bH0cEUj3mMJBvqiEOTW8PRnNWhkjFBe3+oChBUcu/mAMroA8jGm0wYgGcjMZZ8EdQ/p2FnkeylFFrtOgDx43wgwiiiMCI6HWh/KmOJIedtK+xrt+xBRQOGy8srFJNb0k9JhdBCPAcaJMjkOCa1k2CFWyOgVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761097914; c=relaxed/simple;
	bh=0YCFGhriCy1gwFpj+ZCb6FF4P1rx6zdi/Ky21HLQMis=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ofqBwMk9Ls5eAGV2tZewDJMc4eqhO5qqnACF2kxGaazUmVzV+qT92TrgQOVyzpB/i9CLpg27MZTGG0jBU1710hCg+VuD3pwhROX1w6vEnwDaw0lKBdrS5ajo2YY8tZENQIw4tcAi5CqC9ho0L75014JDBBvnh+f9zlkPyj3l5mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ABqynvoL; arc=fail smtp.client-ip=52.101.83.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0rLC1jcnKySbTrhGb37zqxlkhq5bcpOluJ1Ez8oez7iVCa1KkSCK4h5FkHvG4jpLyVN9s1E2UHEbkoBXY5xH6lKnVS/9ZM9khREi8r/d7zMdgtYXxElubDJp4CYjDX42FHs7GUMUGJJx/RRCTbCr766BmUPcyQNVVWCJo1b8PdxXzIA4Y87IfOOOcDjSoMFh5MZfQNGzcomi0zEA8qJe2tf6aXsN89pMRxu79NxDAMVJs+ZoLR0Zku/csQ7l5hNmGskXtPkJ38tip0r3uA7bMqAs3COqXoJb/Q5ZblwMUGTn941I20ZZMxcC40MvDkzNwgMURwPno5cJ58BftCk1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRJC20drh7CemIpN/elRPEcUgrtOBg6kFIUuZF1iCho=;
 b=kfP5m0m3vMxmJ/DFQKcOGhwlQEQ5fn1jxc5R2ln/iTNrMACT1dHgJu5LcqijhJ7V+2vNzrO6cj/JupTrGAGE/+9mlcCjwlXS+is6C9mlVtRhsbAeRsAz6GdfistG285VTyVyKvIHKBPa4/Hinw6Pv1RLzdC3beQM3G0f8zgZwUDbK5jvGEfuqQXcrm1K8CTBk+vBNu6cfhEX6YowXf8jcGxzV2VOwu68fuEL/XakeOadX1RDEcW1NfrdSBvESIltyazpOVbFc0Nkpm4vzwg9qe5J2JXq8P8BgIiNFC7vqhqQVKtMBWb3scpFV/STgn3SZK3KbpIFhQ7kE8egWRmJBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRJC20drh7CemIpN/elRPEcUgrtOBg6kFIUuZF1iCho=;
 b=ABqynvoL2Zn4T3ujcsmSqq+a9syZ5bw4UQgxSYNeEZ6bW6HGq9Z/7lYWWu/ZHTIydoz+WwHA019nZ2TFwHYHd35GcMY8QjMYqz2OR16lwqCdaYrEYNVAPDpiB4dvpFbbTBw/q+9kKUsexTeCKd8JFIvVOCHaxin7JwIUt20iaLeNZDTFJ64Lbd5t7dYUgjl3nWQ1/MLwPRgnOWCi6/hIcPCuqbGwHnGzC0Gv1IEbvZLtttc57RMaSOSubZxfGWzC+7UAnh7SFF1MyIdupvPDppbEMLc51EU526f4f3xLgbfr/Wirw6vsnlAhwg8g8nWHOmyIhWe7oGbI5rkrANkGdg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8646.eurprd04.prod.outlook.com (2603:10a6:10:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 01:51:49 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 01:51:49 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Frank
 Li <frank.li@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH net-next 3/8] dt-bindings: net: ethernet-controller:
 remove the enum values of speed
Thread-Topic: [PATCH net-next 3/8] dt-bindings: net: ethernet-controller:
 remove the enum values of speed
Thread-Index: AQHcPomoAZKpQ3utakGUeUpPWOuw17TNG6kAgABSKcA=
Date: Wed, 22 Oct 2025 01:51:49 +0000
Message-ID:
 <PAXPR04MB8510DD93523FF4551BBE682988F3A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251016102020.3218579-1-wei.fang@nxp.com>
 <20251016102020.3218579-4-wei.fang@nxp.com>
 <20251021205044.GA776699-robh@kernel.org>
In-Reply-To: <20251021205044.GA776699-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU2PR04MB8646:EE_
x-ms-office365-filtering-correlation-id: c240c67f-23ef-40e6-9951-08de110d909d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?WIyAilRO7TqrBsaOmwIoEjbQb0D33rQb9NE8OSjslPBOSjs3nMBbBEALLQfX?=
 =?us-ascii?Q?n5+RRlO+4Ffh+4GV4r7taSmyU5woa6VIuwL8o/zpJLQ8LMSoreTAfiJQgWHg?=
 =?us-ascii?Q?D5/Ue7O7I7kxUtftJJDXE8d2TSu07S1nCFreaE/mnDlbEWayTN64Wc6yL7fP?=
 =?us-ascii?Q?tOdHIZtyAng6yzW5Z28jqq01DjCgNcs6vrdKdsmGRNLE1uzMHkF8mc2nPlwl?=
 =?us-ascii?Q?iLdx/fXUX8adCuh3uu5xrCxNNH/BqI8eiOcZvDWNumSuIReCG1aLoo7n58SP?=
 =?us-ascii?Q?DVICOXrMGmJQ32KP1n4nuLrCigzDoYgKX0y2gaK+1lF4TvCbGG37ZDn/eR1P?=
 =?us-ascii?Q?zFRKmZCMsp4SiLBgldgAQeHV9LaHVx0guoBHpUDQoW7gAcYFzT+tfJfAcW5a?=
 =?us-ascii?Q?1u5UFhnw1ucO43o3L7suSpJ8ajzOV2qtA8B59IZGlghbAUFtGp1SujxjORWC?=
 =?us-ascii?Q?l4rzGITkFdJSZennFQki2v1IkZ+61Z6gQ/qyiCLc4LPmCG5SItmXwSccn+tc?=
 =?us-ascii?Q?/HDGQ0eHp0s0Wkiqxzi2vywrYZDQTss+LAMxuMq2LcpehGzN/QFYzgX/T7yP?=
 =?us-ascii?Q?g/z3/pEkbnoBl0umP5WxwPKL/UfnLsiH/GYFWVZAAjjiIqd6GAMWY2IxPl9C?=
 =?us-ascii?Q?1mvA7E2LeenyOu6uow4xQ48qdTnffX0BK0maV24LOo7Qd9Kj/Vt8t5jntef4?=
 =?us-ascii?Q?4LdOoVTR+kMlUy860YdFa0UGMPq2TXQX/J/r6Kn3QEGkf3yljgfQARpt6zdF?=
 =?us-ascii?Q?Z1sZHM2MtmNLtwbLHRSXW+E/oHRjjGjFE7156SG+jn+WWJxJ8Fah4mtFwBrw?=
 =?us-ascii?Q?FvK5sbMM4wJeoWNHNW1O1CxH/mY2U7c0IT2GOqhgHhCAmLXpeNDKyKDy8wvC?=
 =?us-ascii?Q?UpJebywU/EArULONoUMha3NlHXeVPvK28rB4p9ed52v/YwJ7hdLU4HpSg5YK?=
 =?us-ascii?Q?c29Ko/AVD3boqCXY7WmpLLdX0qOAwYBT+j50fkDFkRMlbR8q6FGAb9d/o/S8?=
 =?us-ascii?Q?MLHAMp20JO/2exkBawAzltXdgYFVCCHCCbvha10FNq7BSrJVV1QYEJSCgQEb?=
 =?us-ascii?Q?qRGPAggr+xJ+0JyTllVp4bvXcn1dnT7dFHgnjF95PqCzM4qcpx9VcwrbOGcF?=
 =?us-ascii?Q?722Mhw1doDxz+rO3b+6nyrXbUSGVaRIfCgG1bIpttvVcX3efsH76NuVS7Ae5?=
 =?us-ascii?Q?nCU1w5IduW/LHr67Vf+kGUQr/MUaPelVEnNKgLHwPoioYqIjwggGS9yaOiXp?=
 =?us-ascii?Q?Gfb3Qy9eZvD9oa4lKnsy11Gq4XkQBoREcGFIkBv7QhXE40NHhhbl2nwjBcUs?=
 =?us-ascii?Q?cNbMi+qdxEIJKFBnZgPrkAjcr/hZKhxbGGHy+fg1fcr8a2AIW9IT/t3Crk4N?=
 =?us-ascii?Q?AxvGq2W03l8FBIFXz3PN7PZGohoQgdP3WYqZD+H64tYhLbc/nNkwfb/Fr9v0?=
 =?us-ascii?Q?BttTJ24rwcI7dbiYhI0ha3u9znLb/hjTT3v9Y0KcezrmQmJPEfg3xTbJfVdv?=
 =?us-ascii?Q?HmAOpyoXn4HR60YbmoP8eqtGPTduv6UWAczV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Z+jzEon1V7PnCAjbXD+Z9ZFbLZKGjqBWYRBm3Ifc9jQ4f6A2gPpqh+yc2KHP?=
 =?us-ascii?Q?E5c0JXOS7Q1f+ZWfBcQTb99trsdJtItYWFbpT3OSnjKMhGsCydPibxGdzx6y?=
 =?us-ascii?Q?SfTPFvcFhJ1OeFsCMfXxao8+jtrHvml+TWUGyUavLUvAXd3etLaOBTH8qTHS?=
 =?us-ascii?Q?wRvX4sxGR3/tXB/O1w79QItlbBkiOL97BlXShtHDWGzCA83R88qWVWmeAbAU?=
 =?us-ascii?Q?wCMIrZqZlIZefKchgF4/N8vCZZp7vg7ZHyskg1sOvbthbdAV4Jnrj0Ykb7oL?=
 =?us-ascii?Q?MFcRu10UhjCLh3Ci5iBxp/SPObbN7KNtVldNphM2X+9o1jnCfQMa+11I5ohX?=
 =?us-ascii?Q?Ppshr4DpFifEZN8ElfZEbNx2N00Av6idN/SZsWoYEYL2yhUBhPSwdd7Dnjg/?=
 =?us-ascii?Q?cr98AKKSQA8my6+0Cj7ITEGc6lEaz13qgHaZpsHlfUo9IORvPXhBVjEHRrZ+?=
 =?us-ascii?Q?uhZbmuM5FkKUppAKkPWaZhmKe14DtnD2RY9O+Qob/6PyFUsi2DaIm0Ojw+Hv?=
 =?us-ascii?Q?DFISXfs1nMLgtvt1WPaBOb9T7OHz4ClPKR3LvURhiShlAb6RNuwbAYOoj7GS?=
 =?us-ascii?Q?GGztbYiZgkA+IHPuURXT8b2HQCL/REDz0AMQFlO7FBBlCphwjU7D2OwNPY7c?=
 =?us-ascii?Q?dTb98DWd2JbJZ2asAGCtIYFWpDPWLD/4qBuGFh0gaHGgnDpkKjNkTN8DJHlY?=
 =?us-ascii?Q?GWcWojxKkGVBtbS6uqH06T8yHw85SnkWkZLeIu3ft+YwITPXaJcDZmluSjcf?=
 =?us-ascii?Q?TEImukxlk7Mur+Ffhg4Mgo0VxcPFHpKdDva4XU37c70Tlgi1oh26ao5V/gn6?=
 =?us-ascii?Q?op584kDQBjtE+3jmgB7beoSp36Q/VmqdqM+qa7mGyuaCYOhD7KtYiMPIafah?=
 =?us-ascii?Q?t+fA2R4hfyuQW2tPW6Wcq/bJNLdGHPh4H/slWXSk1K5mZBKrG0R6Y4u9s3c2?=
 =?us-ascii?Q?oDsmz8ExbuD79q1ru4cCSKiQBQx4bZu+P+J8XQwVKanfNI5/7lWtrmV24pxO?=
 =?us-ascii?Q?T58M3vSrWjS2SBXv+xVH+bXnbAZCHJvAvlVjD5gtGKfgeZaxbpu+KA7aCMrp?=
 =?us-ascii?Q?24vjq+prlBBtO+L9I0bUmaKDpHNGeFX9Ky41gyOkkXKfhhjWDC/PFEcxX3b/?=
 =?us-ascii?Q?yWtcP29r7ert/KHRFobxe3j3MzLkkcqx5pvfZuoU29T1LKgGAWvpfiMsPyB9?=
 =?us-ascii?Q?B58U7QQDgtfH4YSOhp1n5CaohOLGSs2CPYmlQBzH+2/ZBWUfHePzWJR/niXc?=
 =?us-ascii?Q?jWrJp5DF2n5LfBM/PBF0ztwgiWzqvAKFm1c/zCYNYm600SOgcU2bjOOD3u/a?=
 =?us-ascii?Q?zPIZ7Ts2J/MfFXYqs2wgdplt0N0gYfnUT7ABY8njfqUfs6O6QIOYlTe+Crey?=
 =?us-ascii?Q?XP1cQJanHnLuDS0a9Phy/5jKiEDl/a3NEHWKJR7TjUQXtTyX7Q+gYBnfkNic?=
 =?us-ascii?Q?IillBTVJZ+U6P0RUhL8Pdtw3f9ADa3raqNrl4j9hMM96rBp3DB12Kef75jRg?=
 =?us-ascii?Q?YyMEVSFpEolNaOAUKxgdJ0NraZPLfrrjcMwLkxSDfBXykVNYlEKgZEXGUV42?=
 =?us-ascii?Q?frf0IxClW4G3xLShKj0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c240c67f-23ef-40e6-9951-08de110d909d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 01:51:49.1078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jAk1AY27+vG3a55LRk4fi2MlqbnvQWfmuUKS3/+lkN0m0t4BRVh0BG3CG6omd8iLu0qmMiGZE74cCO81Xxmp4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8646

> On Thu, Oct 16, 2025 at 06:20:14PM +0800, Wei Fang wrote:
> > Some fixed-link devices have uncommon link speeds. For example, the CPU
> > port of NXP NETC switch is connected to an ENETC (Ethernet Controller),
> > they are fully integrated into the NETC IP and connected through the
> > 'pseudo link'. The link speed varies depending on the NETC version. For
> > example, the speed of NETC v4.3 is 2680 Mbps, other versions may be 8
> > Gbps or 12.5 Gbps or other speeds. There is no need and pointless to ad=
d
> > these values to ethernet-controller.yaml. Therefore, remove these enum
> > values so that when performing dtbs_check, no warnings are reported for
> > the uncommon values.
>=20
> Every binding that used this was relying on these constraints. So you've
> got to move them into the individual bindings. I'd leave a minimum and
> maximum here.

I realized that if we change to an uncommon speed, the phylink driver also
needs to be modified appropriately, otherwise the driver will report a warn=
ing,
although the warning does not affect usage. Modifying phylink driver is not=
 the
purpose of this patch set, and I don't have a good idea at the moment, so I=
 will
remove this patch. Thanks.

>=20
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.=
yaml
> b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> > index 1bafd687dcb1..7fa02d58c208 100644
> > --- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> > +++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> > @@ -177,7 +177,6 @@ properties:
> >              description:
> >                Link speed.
> >              $ref: /schemas/types.yaml#/definitions/uint32
> > -            enum: [10, 100, 1000, 2500, 5000, 10000]
> >
> >            full-duplex:
> >              $ref: /schemas/types.yaml#/definitions/flag
> > --
> > 2.34.1
> >

