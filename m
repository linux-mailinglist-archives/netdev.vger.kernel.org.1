Return-Path: <netdev+bounces-206962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 905C7B04E01
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 04:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50871AA4AAA
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 02:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C7A2D0C60;
	Tue, 15 Jul 2025 02:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="btC3buht"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012002.outbound.protection.outlook.com [52.101.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CB32C08BE;
	Tue, 15 Jul 2025 02:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752547960; cv=fail; b=DsbJT/o6hAf1FiEHajJRtNs+cpb1j6xPtC1ka/VZwRZxQb02WpbvqW87Gw8dcK6C7ZsWmeZ/CZazPzFYFmwnoUYMwlfb1PRzw6+/im7Mmabc/mYqC+/TThTo5fhyOhb7eHlwalG+j9jEAKfY8S6BJIJ+8/9GfrkHQcI3rpWkOlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752547960; c=relaxed/simple;
	bh=wMQMKA1MEWOhX9+XuSDDH06+0M1ZY/kFOq3wKSlAX/4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=teeFXft02ALBRicms0BpQZeSsxAdMtYJlLH+iJlMicDIw9JupxsfGXwcFNVIVzbJwCmNg5O8GPJV1Q1vRiw7+zS0oID0Iarer0YZ3uTxsrDdUBBFvUh5FjAD9mRFbZAjV9H4vaa7qEDmFRQcyxuiDytIFbA/ay9PEnH5QALYyPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=btC3buht; arc=fail smtp.client-ip=52.101.71.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mkYRHsIAmXtZpjbhDpH4WJurzD1TgT5LqUJvxPjbpw3CHU5l48DEQ1Zqju2xKp0CVC2nGF2cQBtqG2pWIVWaPNaz1cY5YWq0B6nd8g6EU4PL0qacaJrA83jBzp6/w+YHBSI46D2/JDrSfJcDyMZsqdExCCVwG0NuVq0oJWe0fkDSGYbOR+tDc5qLhDMCdakoOembcQ/eHcM4eglhvMaocTas0Fj2gtrlVFMZyjaghO/NXwnrqevrIlw4jwLs3uqXuAPA2QnyKBk0deMqv7HBAiNCwjtpey1awpZmg4wQq50u39jgGDRpdJu4uthx9i8J6hGbSpf0HW3UUhxQcoZ+/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ehb6NlibqJ/MMoOvWTWC9rF41eQgZUOhlCYIXreqbU8=;
 b=WN24RvhaBJpS+bq67PfjgkZtetQaHm0LFUv7fiikM25aWOQm0KyxTccdBcvoJPzWprxR/JeAkxezomuH18Tu0RzJ7PhF9vO3PUqKQazV2XZmCwl6lxXakGsu+IA7SnyunnhVIROUltlIcre2Veqom/u1h4fQ3LuhbTVsHCi+NliFsDdTlK2PxV+LfXrRn0zbomUZm8K/hEfxoCl4vxR9gocYv3dFSNUPlkZJckr7d2nEF2YtqUtuQ0lbaeZlfFG1ftgLwzp5/Cb3Ce+Jd2gRtEZLXYDNUmYkeLC3l4m/6FApu9MFwkMzRcNcpx8oWHEbxNpqhffFQczTBBgGQ3X+fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ehb6NlibqJ/MMoOvWTWC9rF41eQgZUOhlCYIXreqbU8=;
 b=btC3buhtuN1sV/mTLSn8hwuJ52ArEgiiB8q7oNGjsFcXQYbVpp8I2yMfl7RqnMigYWuE5OEXoNaCmRgk4Khb2enHYhNVKs55+ps4+Ae9q/vAVROQr9tuZWLxJ/bjktFicM2aBt3ixGu9w8VmTSVYj2+y2bWmZh8dcGewWYnvLhLGBioXwe6heX1POKYkcb3yTAmuOpuDFRENmrt+/jjennKrzsE0+A3D/UahoJxZvYRT0IUDyYRYRYex4fhoZTk6YG6RN0mOLBX6Xgl4frSh1gYOL+tUwAcLkpr5Qoom/9/ma2YM9zodsW1pd5hpm4mpXX3AprcWNNtGjdUSEUUuTA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB10545.eurprd04.prod.outlook.com (2603:10a6:800:270::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 02:52:34 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 02:52:33 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Krzysztof Kozlowski <krzk@kernel.org>, "F.S. Peng" <fushi.peng@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH net-next 01/12] dt-bindings: ptp: add bindings for NETC
 Timer
Thread-Topic: [PATCH net-next 01/12] dt-bindings: ptp: add bindings for NETC
 Timer
Thread-Index:
 AQHb8jPWk5neHXUn3Eeo02nqDOVTYbQxImMAgAATMMCAAAm6gIAAFX1wgAAGKwCAAAFaQIAADfuAgAACM8CAAAPoAIAAAqbQgAAP8QCAABcf0IAAD72AgADTHvA=
Date: Tue, 15 Jul 2025 02:52:33 +0000
Message-ID:
 <PAXPR04MB8510FFE0A5DA2F3A94E9CB7E8857A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <61e6c90d-3811-41c2-853d-d93d9db38f21@kernel.org>
 <PAXPR04MB85109EE6F29A1D80CF3F367A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <169e742f-778e-4d42-b301-c954ecec170a@kernel.org>
 <PAXPR04MB85107A7E7EB7141BC8F2518A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <836c9f0b-2b73-4b36-8105-db1ae59b799c@kernel.org>
 <PAXPR04MB8510CCEA719F8A6DADB8566A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250714103104.vyrkxke7cmknxvqj@skbuf>
 <PAXPR04MB85105A933CBD5BE38F08EB018854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250714113736.cegd3jh5tsb5rprf@skbuf>
 <PAXPR04MB851072E7E1C9F7D5E54440EC8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250714135641.uwe3jlcv7hcjyep2@skbuf>
In-Reply-To: <20250714135641.uwe3jlcv7hcjyep2@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI2PR04MB10545:EE_
x-ms-office365-filtering-correlation-id: 2f087046-6c22-4987-7640-08ddc34aa613
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Yc/FI0hEU2fROTbMuRh9wlmXlB3X1kRkHqVnj05eis4xtaWLfrLzxwBRYe5x?=
 =?us-ascii?Q?YHMgaTsZByaqveJn+2dHY3Mo5hnj6LZqd4bswpz0YSy3GUV4rHSbe74uy1KZ?=
 =?us-ascii?Q?q2UJJH1IihfWPiCpoURPZioRGUSXsU+xVLzZjwermv9Q60qzqUs9G9ihQ0ag?=
 =?us-ascii?Q?p8GgCLBZ6CofRDEQ2be7wa8CUa0x/vsQNA02/rMt47Q0Go9YjVi+HrHlYeLH?=
 =?us-ascii?Q?wexTxsYUGHWL/fFVyxZnafeFhdSruab4FEMKcVB6IRFoXzRWqEKe6pbamex/?=
 =?us-ascii?Q?qvVHatvLkUrroy/+7JnjXh0nrj2c+n8CO0jwIkbShaGRssG3nsdRn5uBuBhT?=
 =?us-ascii?Q?XSS1GZuxDaztz9K6KgQq6iXKRJDuP75YOg4ncDPvKduGdAlelay0l0vvNhIU?=
 =?us-ascii?Q?8LvFIq/w8o8Cjwxunyo/tDTapX11QDMXExTbfUEmupAsqV1EjN5l8vwhsi+3?=
 =?us-ascii?Q?W5jLNRW5hU0M4leacl16Q3RMw2XdjgXEeNbDXtPnAMz49zHYlk9cQnl4P/dv?=
 =?us-ascii?Q?eHDLDPYK5HWFyfYf9zDM6rqfP9x2B2ZyaAMDZFa5KEzzNEV30b2lKqC8xNWI?=
 =?us-ascii?Q?pKk3E3d5l/xGQi8O5qXMwEQigbO7QEGm6a/19zhTyyl1S/MnkahLDvL149Dt?=
 =?us-ascii?Q?R9QePox01Dt4wfhJN4pF8fjUi2F4NOpaR7AK+snQ+n+zC44Ak9SmYg6pwsft?=
 =?us-ascii?Q?fgIayc9xaNnBf27kIDbLAKAfi2Fryaj76GimQQ16pksrznEQVzMrZUv6v2xO?=
 =?us-ascii?Q?2sqidoJ3qKf7kOLgOMjAbm9dljCvOGsoePxps4TzDjBya7x0IIwTALtbWbPu?=
 =?us-ascii?Q?9QJh4mN7cjxDyNLObqmglwilaG9BeU+6c3bvJRA9QUIYvVXIg3rNcNtFSiG2?=
 =?us-ascii?Q?yNhvlNdkgw3GXkxgZPLeMm+Vk5stASQsRIvFeRmCbua3s94w8Zf3j/WgW+SK?=
 =?us-ascii?Q?Fz9uD3WNEpiTjV1R8yrSoyBj82Cpl+EsDG/8p+EEg+0iXAHx2tsUCc/lo4KE?=
 =?us-ascii?Q?ote7OWnBhSk1cHyt4Pl2DXx13VMsYuIHEhRnffdIrnoYzUMtxHlotOkvwGZG?=
 =?us-ascii?Q?w3SQkchH7vKKcRYCVCNjoUfwvD9kzgad5Lm0VBxRrLnEN8pIpPN4WVj88NVK?=
 =?us-ascii?Q?lhSZT5Zgte4vNokL9P6rKMbnUecawWaksiPB4WInyojfYkCvnxKC8WZetREK?=
 =?us-ascii?Q?CNuUYIW0u2HxadjfpmdeZSf2dqUN162lVno8OSHIG9HrCtLP5gyaYsgPo6S6?=
 =?us-ascii?Q?HtyMqfxRfRx2Fu+XGNMUnNDb8Io6JeK6LdXzKUDeDtWfhiBAxD3G2aY/acbR?=
 =?us-ascii?Q?9CUcW1bjtghX+0qQYf5RqkuG2pvwWH+s1Q4lpGJ5wp9n6V5HTgQpTAQF9ocy?=
 =?us-ascii?Q?Lj9pv+Ne6d8O7tppltvIiq/EKlMfMxFKjqbqK9rFnquUeGswMcai71CJ/Lbg?=
 =?us-ascii?Q?q1GyvH6jc81JnfzT/cbaTjSBIdGYRbCx38queHNOehjOJFpb1MF0rA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?70uI2aW56bNULwsiL/9E7S5R5E0IxxfCDAPCIx5O0K9+OXUP9bLxQDwGFJq3?=
 =?us-ascii?Q?bJmCVVvDa1r+dOSafAo81WMESkEqVL5mHW5nBNhnH8BaOsi1eVFWQweYF21k?=
 =?us-ascii?Q?OYdVUuz4Q/RdHxyy/a42k/5DRDYtc9LTwHGk9CFeKy4lMSO0fie6Gk4dhgyS?=
 =?us-ascii?Q?5zB1eysWWxkEHnGP10klCsZQZZalORhcNDYAFXVvQH7wPWSa9a6zBSUMVYtJ?=
 =?us-ascii?Q?duA/2ve/6aZJTttumjBoEzaa4T1AXQa0OQq7wHIBd3kX6DgqqagtExZiIrck?=
 =?us-ascii?Q?vrErdqLHjFBEHBB1VdkrPeDwEguXaUXWTXyZefWHV6aMe9J2YfZIYSwUtvSi?=
 =?us-ascii?Q?38DWmCcsPWgkY1Ehy6fkREYWqqIh19hFAeZThZAPyqAMR6H8sPr+EPLSQ/BB?=
 =?us-ascii?Q?z7EULRl45V10EnHGTWPH6uTetkGonbgdZ5ohPW7ex6cY6wjXJnlFQEaicvWk?=
 =?us-ascii?Q?htFnYikTI1a/34shnC3OuxcGJmDCAu/jvt/uAH68UOyqRRjBQOZlzOjSDLCJ?=
 =?us-ascii?Q?QrT60zwjSM3ixLvFInRCcrZIWwxtzygUvc+HqAnctPO0feGNid0GMGlY2rwJ?=
 =?us-ascii?Q?lUZu5MYRywBksJss2ERpSFI6tsAanZefjiW90m1nVnqSCAyQYM/c7LLfbBTJ?=
 =?us-ascii?Q?oM9qASNbSRnvrHEviqXyly86Bkx6SAQUFBSHseitEafPFdZCnIiowsUbq6Dj?=
 =?us-ascii?Q?4Xt10Wlj/IkpT8k6Ba7a/WChE9nJLmIyf8YFA5HudUkfgymy0pMBFufahEuk?=
 =?us-ascii?Q?6ZsoazhxZocgvFcuLMlS8SDsckzU91jZ/Bnfg/8hDv9wQR5IasWPT5p8T6tK?=
 =?us-ascii?Q?cCHrx0p3r7PQeDKYke//ZMl1IzeKjJ5XPDkvBUb/X5+o98aBbNP5WnTGkt0+?=
 =?us-ascii?Q?tzt3dI4C0+v0oQlXt2r7jwXWBozpveG+fM5HgdtukIXB0n3uyn1Dq3dK8N0y?=
 =?us-ascii?Q?Y044YA4oIFy1WKdhWZbgYthlzZNLDz9zpr0amVglh1G8YkyauB1uJ2wSZ92X?=
 =?us-ascii?Q?Q6OxKJ74w/ofMgsWpeGwztJJFRTWsyiUvYIoeHe/nDGwM8Gb+yGsl3d1nYt3?=
 =?us-ascii?Q?+SfkDIiZ3/irxDaKIbG7QN9l8aJ29jjW3cTMpKizJzwj/yaTrQnkuVWN9Ltl?=
 =?us-ascii?Q?lgMOyuDBi8LS1E6oelF6+kbLRZU6cZsUf5vKP2HUnYDCXApijyTCKSyYa6n6?=
 =?us-ascii?Q?H1dvbTmB/jD2RV0phKDGIl51kaqspRE1JeTzWPsXTdj08eiONa+Kf91O7+YF?=
 =?us-ascii?Q?/lbnF0ioKym5ZZMM9iapjEJgL/MjoXbCaoC9siQZ4YYQgY5TsNg+3vLvgmE1?=
 =?us-ascii?Q?RICrJEBOTY3/JOLNJ4sGEYfXAjuSXha9Zt86H6roVK2p6eiVrORdNp+xaUgk?=
 =?us-ascii?Q?TjdiCkTSpSVw/OSDNPUkVkAMJlugxTYCFvuiFxUGEZRCu05HtABPiYXsKR0H?=
 =?us-ascii?Q?N9BNEyVG3HQ6saTIjO8YEde1cXU48phj6+ln/ChiUaKDi08RH30u666/WNZ6?=
 =?us-ascii?Q?7Wcux0l2HfzjFX9+mqbBu1wQr3LBr7zL1h2jGCM7R9jWu0NKspdsj2pM27Rx?=
 =?us-ascii?Q?oV7lFRdESYn9TOJw8Qg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f087046-6c22-4987-7640-08ddc34aa613
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 02:52:33.7571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JFdkWvV6cUKj4x/NZSY7UgIg7FX/UcXj3jDqBAPI/TWF/D9AkO1HhRjQ2oArXVtyMFRhwS+qzkJxCu8+wjWmag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10545

> > I don't think these can meet customer's requirement, the PPS pin depend=
s
> > on the board design. If I understand correctly, these can only indicate
> > whether the specified pin index is in range, or whether the pin is alre=
ady
> > occupied by another PTP function.
> >
> > However, these pins are multiplexed with other devices, such as FLEXIO,
> > CAN, etc. If the board is designed to assign this pin to other devices,=
 then
> > this pin cannot output the PPS signal. For for this use case, we need t=
o
> > specify a PPS pin which can output PPS signal.
>=20
> Ok, apologies if I misunderstood the purpose of this device tree property
> as affecting the function of the NETC 1588 timer IP pins. You gave me
> this impression because I followed the code and I saw that "nxp,pps-chann=
el"
> is used to select in the PTP driver which FIPER block gets configured to
> emit PPS. And I commented that maybe you don't need "nxp,pps-channel" at =
all,
> because:
> - PTP_CLK_REQ_PPS doesn't do what you think it does
> - PTP_CLK_REQ_PEROUT does use the pin API to describe that one of the
>   1588 timer block's pins can be used for the periodic output function
>=20

Yes, you are right, PTP_CLK_REQ_PPS is input into the kernel PPS subsystem,
is not used to out PPS signal on external pins. I have found the kernel doc=
.
I thought PTP_CLK_REQ_PPS can be used to output PPS signal, but now it
seems that many people use it wrongly.

commit d04a53b1c48766665806eb75b73137734abdaa95
Author: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date:   Tue Nov 17 22:38:26 2020 +0100

ptp: document struct ptp_clock_request members

It's arguable most people interested in configuring a PPS signal
want it as external output, not as kernel input. PTP_CLK_REQ_PPS
is for input though. Add documentation to nudge readers into
the correct direction.

> You seem to imply that the "nxp,pps-channel" property affects the
> function of the SoC pads, which may be connected to the NETC 1588 timer
> block or to some other IP. Nothing in the code I saw suggested this
> would be the case, and I still don't see how this is the case - but
> anyway, my bad.
>=20
> In this case, echoing Krzysztof's comments: How come it isn't the system
> pinmux driver the one concerned with connecting the SoC pads to the NETC
> 1588 timer or to FlexIO, CAN etc? The pinmux driver controls the pads,
> the NETC timer controls its block's pins, regardless of how they are
> routed further.
>=20

pinmux can select which device to use this pin for, but this is the
configuration inside SoC. For the outside, depending on the design
of the board, for example, pin0 is connected to a CAN-related device,
then in fact this pin can only be used by CAN.

> (reductio ad absurdum) Among the other devices which are muxed to these
> SoC pads, why is the NETC 1588 timer responsible of controlling the
> muxing, and not FlexIO or CAN? Something is illogical.


