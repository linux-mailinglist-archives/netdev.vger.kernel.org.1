Return-Path: <netdev+bounces-140596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F729B71FF
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 02:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C51FEB23EE4
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 01:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAFE2AF03;
	Thu, 31 Oct 2024 01:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kerR4/Rl"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23EE46447;
	Thu, 31 Oct 2024 01:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730338402; cv=fail; b=r87EvF3uls/HENkstnJJEsAl31t8NbGY819YQB8pI30cvy0YeKd50yx4WwclNWc2MjqNrp6X5m9ikIi9Gb2qrOAlFsNXmVL+xKrxpJBElnh/Gruea8ChVQbq7dgcaG5hdHOKCJ0CSBlp7C68OaPaL3WzVv0Ep5iU0MkERTqgeUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730338402; c=relaxed/simple;
	bh=cpFtE70nnuiEOkhjOFC8NDl6PrNC1Dgw+pqjwnxdH8c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=okGQbjgibtIs5chWQfXz3WcDbmxkNkQFm8nYuuB9I+05lpgqLeWo2n1nkShVGNkLGSuroGHKWMhc+SEzOyhTU7+M26F6zKjzFckg7y5VE/Y9C9kD6vuDAxjqHIlk98/VrpbP2vS9LQk43fJgi0GTxRvB4afoEHe+4x8G4D8hsHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kerR4/Rl; arc=fail smtp.client-ip=40.107.21.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rliwtkLws1UDeJGG4lMoPSPvh6iVgQTF4l9+29FGlPGEXCBQzQYWMxsJ0e3vNqRM/OOVXxRFDIVnJ0Kiuki3t403+o2F+9XuPTlgp4387Yh9CWfP5FAXvSdrpK3XC33P7UUlWdKJi8BWRQzVpsRl3SW0bHAtRqE8xAAexn8tzEv8MJiZQgVtMKm7qePK/kIwSrB6zLpDZJE1rUF6qyN1igpB8Pn7DaJH7I5QJAyp77oTIukfQOaJ9tf08yH9Qj8HfIFHnpCVdKBKC1cYeq8VvTvd7FBOscYiRjG7RJ1xHpKqDP9glNRWBR6yrR5WoYTQNG4iRnhyArc6DcmlCjRavA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGigw60lW8w0jrm5AQYufn9l+cnlXSJDntblXEdqnfE=;
 b=srTxjxKmho/iCpPKJnylexlj86YL3hYDFonw+n8j+4HeoHlnxbmsZdz2LuiRdTtLwv0RiGOLYBcIbA5bnpwKdHJYfx3Jxh7YP3nhzdggmw4p2hMyCywiC+UfgxfnBcCOSqriHEYghkPLN5u2tZ8h/CkYhnOssY7hSN4ko3aj5frRtlrhcXniHj1FS/J9Gvi8fCJbLNyk22HFra6jrUlcOGuhhufJ2g//LZW8+Wi3WhDmRwVStmEHjEijpJqldOZ0cgTSPKdnJ6kn8ocmCygFEGZQwivudWpr/ZOjGlPu677yVMQ1b7uqe4FC4lwY1HpEW8wybYEi9eR2ULMY1+KegQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGigw60lW8w0jrm5AQYufn9l+cnlXSJDntblXEdqnfE=;
 b=kerR4/RloGB5lZWHwWhdbguD7snvnpnaa/Gwa8j72WiX3L90kKEqeSvU7lutlMwV6eUBlrW38+f0s6fLeYIbw5SxM/7bZ4QC94yrt3ERrQntQAbNJpEHc6sl6bbC2YsT7OAkJumK8NODVU5RmU6M1MhJZ0Fc9bC2yZ7DeEmzv2TeQ4/T+N+HnBUSbbysMZkpb1HGbex8exiTIGiiaay8mYbP/ZxrF5dMwTe7T3WqZ6O6sYUiJdVfYjEZi5K4sE2sI3ThSB9iSyCY/eBZaUUkr3cJ74ZSahWL8KtnyAsk2nlQkEa5Wdoifg1L2v5Sw/UzgSxOtML6GfHgmVRaRD2YxQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB9233.eurprd04.prod.outlook.com (2603:10a6:10:361::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Thu, 31 Oct
 2024 01:33:16 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 01:33:16 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net] net: enetc: prevent VF from configuring preemptiable
 TCs
Thread-Topic: [PATCH net] net: enetc: prevent VF from configuring preemptiable
 TCs
Thread-Index: AQHbKqbVP6taxDbDNEuEvy4Pi75TqLKfZ+OAgACrTbA=
Date: Thu, 31 Oct 2024 01:33:15 +0000
Message-ID:
 <PAXPR04MB8510F0A3B49E05554D5BD71188552@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241030082117.1172634-1-wei.fang@nxp.com>
 <20241030151547.5t5f55hxwd33qysw@skbuf>
In-Reply-To: <20241030151547.5t5f55hxwd33qysw@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DB9PR04MB9233:EE_
x-ms-office365-filtering-correlation-id: ed4c883a-7a8a-4fd9-342b-08dcf94bfe10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Pjhn6RHUqufzwF1gn6FAGGR5Z0gqBi3w/8PmQuXoQR8BRjnJt7ua+CTDOQmU?=
 =?us-ascii?Q?4sIOzYFBm4P82WUcNaLFCCRruipCFgPrrz1KCPWVrGousYco0E2DwfoQjBGP?=
 =?us-ascii?Q?ssCp+bzfAmY3GihEzY127WIwNmVmbWArlqzb8sCGZ1cVK8apOSHUqAIgd9EV?=
 =?us-ascii?Q?BlGvT6QLepY87FiFba9eKjm1i2c9UahYJ2nsb/flKGOTw6ty85Nz+4BA7Oc5?=
 =?us-ascii?Q?6UENEJoDS3AdvdlKHSM+UrYV2i5zKY1WPwxIwer7ggOhG2laLvHyJAs6stwD?=
 =?us-ascii?Q?rlpXDp9XG15ReLQawA7u894KolXVjx5zuXwd6Xki/cdapwvzQj1ycrBXYdK8?=
 =?us-ascii?Q?JCElsz5vssuG4JKboqvTvuttrlDmDQiQtVRiTJAnwxdGIA2CzHaLzs6hae5k?=
 =?us-ascii?Q?o/4PHkzWDyRib6ke1d1//HqnhhKCnYTRezzoDXxZEwiUjk/fzDX3y4efxH6O?=
 =?us-ascii?Q?z3cmM//pxrXsC3kxm2o9sP+2bPs/xFILFkZKGljdJcCtDI9NqSzeQIwWfe2N?=
 =?us-ascii?Q?bHzbxafOPs6V97B15W1xM8RMvwWLBR2DsZgY7OJltq20Cfe9CXkDeRH/Vqvz?=
 =?us-ascii?Q?ZSA59upaOElsp2hiyBv97wm2KjpGiZAgPqnVJs5xpqwKjGEY9QEaYQcXPp7G?=
 =?us-ascii?Q?dso/WycIRHdAE2SBSvERLmR4OZgGUNxOH3fZQ/8h1yoaS38VZHuIkNdK0F9s?=
 =?us-ascii?Q?IwFKJ1rFzigFU437jQ4N5GWcfCbQJxN0jCHwcmgS087n47w28WIn453zXFQ7?=
 =?us-ascii?Q?Lwy7qbJvlwFSt0k4Paz1qRyIZX1usVWTb9MLoy1KfBjWQ6s54uwMzf5FyQG6?=
 =?us-ascii?Q?Ou7rzZGQCtfhAYCk+VdYvsRn5nthSDVjR4TBMYWxVGGW4blXhgR0tn+mGuBc?=
 =?us-ascii?Q?X/GyeMipXp25+T5Rl2pBdFxZiOn2fxisTuKKK8g+nFu6v8HCYDAhxqyXaCKS?=
 =?us-ascii?Q?X7Zk0JN96xE4Q7xN8yn6TseMzKaSe8N8VRDJEDSaspVta0owssX9BDYGssmL?=
 =?us-ascii?Q?d/a8O7w/rymjYchBprVw1dZUPO8G+QUS5KOIuDG+UB+gSOGDaZxenvbPW6pq?=
 =?us-ascii?Q?IT8hy88ovLY9Mn7ybQdtCnEPd2dw4n8iubtm/fwqKp99aOIYrq+QeWR+4a/J?=
 =?us-ascii?Q?04DPj/JSYA0f7EQt9CP1apcmwTUOnk0CPnsRIp9Bfla/LXYvZDoq1Cp5HkEv?=
 =?us-ascii?Q?N+J9DUGxwJsvJoprFfEkPOhywzXO9iwREDw3/tQ/5OblobfMR6NCL3EGHIei?=
 =?us-ascii?Q?FEb+NycgYVXNPOg65mouNHfgIcBC8zfwT0TBSHTrW80mVNkAd1iWHfczZTc+?=
 =?us-ascii?Q?FdpyRBc5LzFL4241QfiI+O+SkyrI7WBjpW1ghooqNW8NABf/l5YG2K595VWj?=
 =?us-ascii?Q?Kdtwws8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XM4NeQKWvrTdhrtss/9naxQIf4HXg5rN76Sc5jM5V84EI9HldjpFlt+V8TR8?=
 =?us-ascii?Q?8qOvXH16rALCxpm569cPp/eM3X+d78GoIbHEYH8H7vqegIuoyh4cyALtXH2k?=
 =?us-ascii?Q?viemOYxLL2Iptqur1VoDDHdg+Iz8FIKdLvoBWClLPWaApgCd8Y4FbNmcEL6A?=
 =?us-ascii?Q?fTiDz1nQ78wqKOfybZJDnoLgz3sVyq7EbMTrP9emBO/fxW+oqoO9HkyLvkqE?=
 =?us-ascii?Q?Myb665T852PJlwPWqM+nrr3RscreEyXlGlEdErjbkW9+lZpWfW0L9ItmAAD6?=
 =?us-ascii?Q?hkoShtWFCQIsQVx+wfrUCBCzwMTXhhm4Xjsma9lCaFYuytsw4Fgr+/AVfZ9z?=
 =?us-ascii?Q?iyK3RKbeERPD5dS+oqm/Oms7P28R0UbSIg+6BXVVIA2FXLFdfFRCBNBo6Lpk?=
 =?us-ascii?Q?ydlNs3+PrWWBnd+bjOCO2mAIFYZk2QF5AbL+TpiDBqlyvqYSEY8awb4W0ox0?=
 =?us-ascii?Q?PxlP7u0cKSkvH4BfyEtRyVOCA3umxs7F0ClopcSTQV6d8JU/uxmElnVDBtYO?=
 =?us-ascii?Q?OxU5iONARUwMJ3nq6XXfoRqGrelp7AmljpmaTOER9IpscPpL7JuZQjZy4Al0?=
 =?us-ascii?Q?lcxq/r2llWPzVTe8/RQlCLJuHBcNWVJwkSSpfWVAa/7vXn5whdqj1yGGr0wx?=
 =?us-ascii?Q?5daMcX1mZOwlJsBwmsvyZo09bezHpPdi4jYBMZCihDSkVvYU0UjLslHmEDmm?=
 =?us-ascii?Q?y6s2inYjC81DYoLLI+5e2PX4OHOlrMaIRQAn3UszUTLqc0gX2SdxK2Xhg6o1?=
 =?us-ascii?Q?mz47C+6csp06FoYTbeAsIFzIdqg1HwPplqeXaOuKxxaWLQa+gqey1ejYOl22?=
 =?us-ascii?Q?v+sx0vk0GbRo2VuLm2WCCVE4si+Wt1K4VoMo9vrbhUWmHntxzyDjQO7rHwFk?=
 =?us-ascii?Q?Cr0zzI7RKpAEboOL9js+89JYDuyat2KvP3OpwkODfg1d3DBJVRUPSVcdPcRV?=
 =?us-ascii?Q?g61yJLtC068D6V1+gMB832c9t9PjSp5VG2Fw5EM3RFG6WHGkrBsbgU0c2QsA?=
 =?us-ascii?Q?uaQws+bbQOsTp1bjSBqJmXu942PyENT6Lgj+1YKc1DvBW2RzRfmzWPICX5xB?=
 =?us-ascii?Q?Sok6RG/RSV9/j5lkv7WCkv/lnz47nX55+1riOyGYpEOcoXjGClz4T4RkbtN3?=
 =?us-ascii?Q?nKsl1wQpHyLYir4WvnU0Vd5xb6Vth8sysyzWTI++Qj7dPJkye3IqKG9sMoOz?=
 =?us-ascii?Q?YqiyFpYXhGKxm9oxTmLKuvVqmcb6dKNOPilFbZO/r/5cdnroWMN/epdrHwqG?=
 =?us-ascii?Q?aCBimSdh2kYRuYZVtRQtp/9iyW/900/twrYCwkMoFLKq//JNkU1djIGTj9Vh?=
 =?us-ascii?Q?PC/GNb5xhGcPyFOsIbBC3JnBBqk0nqqD3g1ek8qbOyVScfPz2zYRsSRYXPbN?=
 =?us-ascii?Q?BtmnVkp+uKYnqUQ9ST01S/7PsyV7D4SAI2TcodLhr++lr+eODnZQYZY1eHJa?=
 =?us-ascii?Q?M1Vdralgc3v9s7P/lTU9aH7zn7+UthYas+5J4lGTnfOThAwuES3zmKZLm1RZ?=
 =?us-ascii?Q?hZnNmg26QUNImwUuO/lbDS8MULBdGJPSDcsWD0ByoZNVzmQMR2Xvroi7sY6q?=
 =?us-ascii?Q?C4EIvaBwjEtajuQFPCw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4c883a-7a8a-4fd9-342b-08dcf94bfe10
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 01:33:15.9701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oD4g54bA4dnfTbN83fIta4xikrIU1bc6rvd8ue6xlLaLnxjFYbhRWm8qRi1Zl+XeXwS2BPzQNHKCk7Wlfj1wBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9233

> 802.1Q spells 'preemptible' using 'i', 802.3 spells it using 'a', you
> decided to spell it using both :)
>=20

My bad, I'll fix the typo

> FWIW, the kernel uses 'preemptible' because 802.1Q is the authoritative
> standard for this feature, 802.3 just references it.
>=20
> On Wed, Oct 30, 2024 at 04:21:17PM +0800, Wei Fang wrote:
> > Both ENETC PF and VF drivers share enetc_setup_tc_mqprio() to configure
> > MQPRIO. And enetc_setup_tc_mqprio() calls
> enetc_change_preemptible_tcs()
> > to configure preemptible TCs. However, only PF is able to configure
> > preemptible TCs. Because only PF has related registers, while VF does n=
ot
> > have these registers. So for VF, its hw->port pointer is NULL. Therefor=
e,
> > VF will access an invalid pointer when accessing a non-existent registe=
r,
> > which will cause a call trace issue. The call trace log is shown below.
> >
> > root@ls1028ardb:~# tc qdisc add dev eno0vf0 parent root handle 100: \
> > mqprio num_tc 4 map 0 0 1 1 2 2 3 3 queues 1@0 1@1 1@2 1@3 hw 1
> > [  187.290775] Unable to handle kernel paging request at virtual addres=
s
> 0000000000001f00
> > [  187.298760] Mem abort info:
> > [  187.301607]   ESR =3D 0x0000000096000004
> > [  187.305373]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > [  187.310714]   SET =3D 0, FnV =3D 0
> > [  187.313778]   EA =3D 0, S1PTW =3D 0
> > [  187.316923]   FSC =3D 0x04: level 0 translation fault
> > [  187.321818] Data abort info:
> > [  187.324701]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
> > [  187.330207]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> > [  187.335278]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> > [  187.340610] user pgtable: 4k pages, 48-bit VAs,
> pgdp=3D0000002084b71000
> > [  187.347076] [0000000000001f00] pgd=3D0000000000000000,
> p4d=3D0000000000000000
> > [  187.353900] Internal error: Oops: 0000000096000004 [#1] PREEMPT
> SMP
> > [  187.360188] Modules linked in: xt_conntrack xt_addrtype cfg80211 rfk=
ill
> snd_soc_hdmi_codec fsl_jr_uio caam_jr caamkeyblob_desc caamhash_desc
> caamalg_descp
> > [  187.406320] CPU: 0 PID: 1117 Comm: tc Not tainted
> 6.6.52-gfbb48d8e2ddb #1
> > [  187.413131] Hardware name: LS1028A RDB Board (DT)
> > [  187.417846] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS
> BTYPE=3D--)
> > [  187.424831] pc : enetc_mm_commit_preemptible_tcs+0x1c4/0x400
> > [  187.430518] lr : enetc_mm_commit_preemptible_tcs+0x30c/0x400
> > [  187.436195] sp : ffff800084a4b400
> > [  187.439515] x29: ffff800084a4b400 x28: 0000000000000004 x27:
> ffff6a58c5229808
> > [  187.446679] x26: 0000000080000203 x25: ffff800085218600 x24:
> 0000000000000004
> > [  187.453842] x23: ffff6a58c42e4a00 x22: ffff6a58c5229808 x21:
> ffff6a58c42e4980
> > [  187.461004] x20: ffff6a58c5229800 x19: 0000000000001f00 x18:
> 0000000000000001
> > [  187.468167] x17: 0000000000000000 x16: 0000000000000000 x15:
> 0000000000000000
> > [  187.475328] x14: 00000000000003f8 x13: 0000000000000400 x12:
> 0000000000065feb
> > [  187.482491] x11: 0000000000000000 x10: ffff6a593f6f9918 x9 :
> 0000000000000000
> > [  187.489653] x8 : ffff800084a4b668 x7 : 0000000000000003 x6 :
> 0000000000000001
> > [  187.496815] x5 : 0000000000001f00 x4 : 0000000000000000 x3 :
> 0000000000000000
> > [  187.503977] x2 : 0000000000000000 x1 : 0000000000000200 x0 :
> ffffd2fbd8497460
> > [  187.511140] Call trace:
> > [  187.513588]  enetc_mm_commit_preemptible_tcs+0x1c4/0x400
> > [  187.518918]  enetc_setup_tc_mqprio+0x180/0x214
> > [  187.523374]  enetc_vf_setup_tc+0x1c/0x30
> > [  187.527306]  mqprio_enable_offload+0x144/0x178
> > [  187.531766]  mqprio_init+0x3ec/0x668
> > [  187.535351]  qdisc_create+0x15c/0x488
> > [  187.539023]  tc_modify_qdisc+0x398/0x73c
> > [  187.542958]  rtnetlink_rcv_msg+0x128/0x378
> > [  187.547064]  netlink_rcv_skb+0x60/0x130
> > [  187.550910]  rtnetlink_rcv+0x18/0x24
> > [  187.554492]  netlink_unicast+0x300/0x36c
> > [  187.558425]  netlink_sendmsg+0x1a8/0x420
> > [  187.562358]  ____sys_sendmsg+0x214/0x26c
> > [  187.566292]  ___sys_sendmsg+0xb0/0x108
> > [  187.570050]  __sys_sendmsg+0x88/0xe8
> > [  187.573634]  __arm64_sys_sendmsg+0x24/0x30
> > [  187.577742]  invoke_syscall+0x48/0x114
> > [  187.581503]  el0_svc_common.constprop.0+0x40/0xe0
> > [  187.586222]  do_el0_svc+0x1c/0x28
> > [  187.589544]  el0_svc+0x40/0xe4
> > [  187.592607]  el0t_64_sync_handler+0x120/0x12c
> > [  187.596976]  el0t_64_sync+0x190/0x194
> > [  187.600648] Code: d65f03c0 d283e005 8b050273 14000050
> (b9400273)
> > [  187.606759] ---[ end trace 0000000000000000 ]---
>=20
> Please be more succint with the stack trace. Nobody cares about more
> than this:

Okay, thanks

>=20
> Unable to handle kernel paging request at virtual address 0000000000001f0=
0
> Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> Hardware name: LS1028A RDB Board (DT)
> pc : enetc_mm_commit_preemptible_tcs+0x1c4/0x400
> lr : enetc_mm_commit_preemptible_tcs+0x30c/0x400
> Call trace:
>  enetc_mm_commit_preemptible_tcs+0x1c4/0x400
>  enetc_setup_tc_mqprio+0x180/0x214
>  enetc_vf_setup_tc+0x1c/0x30
>  mqprio_enable_offload+0x144/0x178
>  mqprio_init+0x3ec/0x668
>  qdisc_create+0x15c/0x488
>  tc_modify_qdisc+0x398/0x73c
>  rtnetlink_rcv_msg+0x128/0x378
>  netlink_rcv_skb+0x60/0x130
>=20
> >
> > Fixes: 827145392a4a ("net: enetc: only commit preemptible TCs to
> hardware when MM TX is active")
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
> >  drivers/net/ethernet/freescale/enetc/enetc.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> b/drivers/net/ethernet/freescale/enetc/enetc.c
> > index c09370eab319..c9f7b7b4445f 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > @@ -28,6 +28,9 @@ EXPORT_SYMBOL_GPL(enetc_port_mac_wr);
> >  static void enetc_change_preemptible_tcs(struct enetc_ndev_priv *priv,
> >  					 u8 preemptible_tcs)
> >  {
> > +	if (!enetc_si_is_pf(priv->si))
> > +		return;
> > +
>=20
> Actually please do this instead:
>=20
> 	if (!(si->hw_features & ENETC_SI_F_QBU))
>=20
> We also shouldn't do anything here for those PFs which do not support fra=
me
> preemption (eno1, eno3 on LS1028A). It won't crash like it does for VFs,
> but we should still avoid accessing registers which aren't implemented.
> The ethtool mm ops are protected using this test, but I didn't realize
> that tc has its own separate entry point which needs it too.
>=20

Yeah, I agree with you, I will use your solution, thanks.

> >  	priv->preemptible_tcs =3D preemptible_tcs;
> >  	enetc_mm_commit_preemptible_tcs(priv);
> >  }
> > --
> > 2.34.1
> >

