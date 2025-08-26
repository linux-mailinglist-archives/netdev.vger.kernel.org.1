Return-Path: <netdev+bounces-216776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BD8B351C3
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 04:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C38A7244DC7
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 02:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0361A21B9C8;
	Tue, 26 Aug 2025 02:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FnDZv/um"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010048.outbound.protection.outlook.com [52.101.69.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1705D1F7580;
	Tue, 26 Aug 2025 02:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756175699; cv=fail; b=F2XMcyrgrrB2eP6pGZUNxjBjNHIeFNPm8efMwaQ9XppbLjbS8H52JXQf4vTrp1oHSl9HYC7Fn7XCAqfYulKF8DSoMbCR3ZIKMBKCdBMZrAyVpMkWk0kmvfgUCPpJ+TuWwdubIUQj1XO45yrcKif8DwSscKDHs3PmX+JNGguva0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756175699; c=relaxed/simple;
	bh=FT6n1EmvQdGNQWUufR+eyKaeGr8Q8rrWdmoV5L4Xrxw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PO17M9HNzsios/MRBHegdwlhvJMYJCicWTaij8U3EwAhZzr9+m3pSIoq+XgKR5FneNnYT5xmrbRxo2M5hZE5x/FxZa7GFjPQ+DpNmkIg0mIZJleWtjvq4QcqflvCq5+kPynGdG+2uPa638yE9Iq3eyYCPyZ0G/wAPMtgAartgHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FnDZv/um; arc=fail smtp.client-ip=52.101.69.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tePX9aNvDyGQF6VENHbxysLj7Tgy43DcPirSF7ZCiZYBjKbPbMrIxGZfK4ILv9l1m2DQY/7BJ7TBSBEatrTs+ejGK7NbHGk7VdQMm0dtOlPbXrVSh+xfFq+6+D3Pd2teACHfDMGCvkGSPbam23Ct4HdpH3mfa1HKBg3Myz2uMw4ODShD43o3LDCDta/llROOo5OA9GY5FcQIeIqfE/GuibtBT4mGaF5PCwB9zwAj+6FT24dA1Iqsqc8IVdspcA0WyDNjSt5r0E0blTH9YHA2BnssNmcGwj4emPiUFjaAttBLtduqGdEAHrrirhmexcMPF5cvmf6looqei2dWsm9lqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Str3ujkx1tqh9gXV/Y5HVW41JH62V1IVrWXblTY0A04=;
 b=xNQyUxlPz5X9J/lnbOwgDpEf3cBHAAtYbBcgDBIxIGW+DPkgmHSGd3+zkozq4HJ7z9EE1a379QYHMivzDgKWE//yMduZzK1Py5/8eg3Sp0pV6xfAmtRRwL+6938KnLZn0iWVoXSIUZuvDk6X/tmNv2LiDiq7LZpDomptqVCkeXcGJ2Xjxj1paWbhGq3NuYRSdJ89iR5C8S3/HxnLNGkShWnK8CwCk7nLdL450ScuwriYE6g4hqjAKF1MxPATZDUVNwDK68A4gQaC9W5VxHVOAvI1Ye94GsCA32tLUpbdUhacGNpOv8Gs3xQKv9I8RWVvRH4NlxKdHfHwkPhVSRFuUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Str3ujkx1tqh9gXV/Y5HVW41JH62V1IVrWXblTY0A04=;
 b=FnDZv/umn7mU5458cGHwGnol8hrG7rnxvfQENGnUKJucsjkKOIpBc2hZCDJxUPuVlFK7agtPwdwx+vab5Rcpcd1Qtx+4nsV+jqdENen7V9dT+s/oFYAgAJiOsPkjeA2X6H5pUFmWS1aYbPbXCQ6koY7ZhCbaEobcz6P4U/XIAzyZvTBrXY/kAUwnw7vE+6wVWD2IpoZFhcCB9d7c6W/E4O2k4AaaOQQgy1s6bD1waYZS/QIwa1GaNmLZxJDa8bI5AkcfAb9tsE25HrOch+UACEMTLcLupHakSxMj/XGMyomcS8vjK6Vmxxx469GWTzsgaR3f8PVSyGHvgelaIMshjQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB7713.eurprd04.prod.outlook.com (2603:10a6:20b:2d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Tue, 26 Aug
 2025 02:34:55 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Tue, 26 Aug 2025
 02:34:55 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Shenwei Wang <shenwei.wang@nxp.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>
Subject: RE: [PATCH v2 net-next 4/5] net: fec: add change_mtu to support
 dynamic buffer allocation
Thread-Topic: [PATCH v2 net-next 4/5] net: fec: add change_mtu to support
 dynamic buffer allocation
Thread-Index: AQHcEso1Ue9PAAZZWkmtSe1X7IJrlLRubSvAgAIniYCAAg2gwIAAsTQAgADqKtA=
Date: Tue, 26 Aug 2025 02:34:55 +0000
Message-ID:
 <PAXPR04MB8510E304CC51FB527B4971608839A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250821183336.1063783-1-shenwei.wang@nxp.com>
 <20250821183336.1063783-5-shenwei.wang@nxp.com>
 <PAXPR04MB85102101663ACE21F6D75562883DA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB91850A2E4ED6ED29D45BF27C893CA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <PAXPR04MB85107C52F0CB3A45943FBEF5883EA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB9185A682B7B3D37E157F4184893EA@PAXPR04MB9185.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB9185A682B7B3D37E157F4184893EA@PAXPR04MB9185.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM9PR04MB7713:EE_
x-ms-office365-filtering-correlation-id: 9c0b05a5-3a41-44ce-6950-08dde4492479
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xCU6Wq+y+DNDlN6EWowOvJY42nfLWreDcwrNhOQg1GnFupWeN+pB29lY1DSb?=
 =?us-ascii?Q?Nsddr/lHBB/3qrJZCUEp4Kofn28ryb36cc2KFHf5qq2Sk8LTuy5Gjck2vAa9?=
 =?us-ascii?Q?2BFAh52onoKw80yiTqwCAkAAy7rUz4KeSsfy89zcu/oRsv8dUDywmMfgdMI7?=
 =?us-ascii?Q?zImJIJ4xBbDFrq7G5s4/Dw1fbnespbRGqSNIU0A9VNh8lQ9573BXDSFczWzD?=
 =?us-ascii?Q?fDoV2Z8AgwBSUwFSycPoFqAERt2Mpo8CmjNwD1yVWzADmMZA8ExouXwF3ijZ?=
 =?us-ascii?Q?WAcKRa506lQJP+SBlfQs2V0hSdii78jv9r5LfZ+ed20/sTyuYK9IIsIj15Ih?=
 =?us-ascii?Q?lEkhwpSFlzUISgSPm97nG5VPeFESbDVQossQ84VOxRcrWQ+0hPb+2p1yFLDV?=
 =?us-ascii?Q?Qzo99XwQr0sCnbXy+OcgSHElFAhE3sFqw81W4gPC9Jr0gHYqF3cmaj8o7Ko2?=
 =?us-ascii?Q?zLwOxqwvnkytVCcReWEJGo6dxsIyHJW/HKItr6KCknDp8xog1HvyYa6lWBVC?=
 =?us-ascii?Q?d89lJYkzuhG9CHw4sin24o4dFfSG8v3WpxREhc8taeCkk9SshHYHbxfxiK0k?=
 =?us-ascii?Q?9hYbAJ4HKUG9zsESn9RXsrGoPAzezhJEYg5Pxwqbs0TKQogeHx9qA43UWyID?=
 =?us-ascii?Q?EC0rREM/sXqmtKxpMxniOJ8lGkr268570O3xpM+4hWLpvM+Jux72cD1II3eF?=
 =?us-ascii?Q?EwtvJTvJkQvQESdzjEPvot1JT8DQDoLkBGldKvCTRvUiUgCAPisgc/g7PODc?=
 =?us-ascii?Q?1ooId6OPHq5igkrfggpCWsbVcAZJNiHFzf62o7ttjK70cbw9/VEwfeaxh3NK?=
 =?us-ascii?Q?zBGISYJjpf+mhi5gGzhyk/L/sIPpOXye7JVMnYElGFaPtPVXPlXXVnNG82i2?=
 =?us-ascii?Q?U/EOclveYJ8TaP4eDhB+rBOEqPZ+xuhfpKVqb8L0yGPCtlG/Zvx/EIv1YIcf?=
 =?us-ascii?Q?xBiZqFZlyfQjtpJefCfLA1u+evKFDSP1QZjr9BLgH6U1geNUCBTZh6sHy6pZ?=
 =?us-ascii?Q?4/KolKyjF87V+i9nv3wqRz6fg/hdthbNTg9Tx/0kwFi9WjwcB//0v02sKarM?=
 =?us-ascii?Q?Xiq2H7KwJlXyjE+vKz1VSwEBT6TlGEa8jReUSzxwMIi8nnAhBL5ly8VvIuvw?=
 =?us-ascii?Q?DIWh4HqGY9dVhSLyedL0FKXLhn4vCzgLiqY10cgKuuQfQ7nZk/kxH1P1acj4?=
 =?us-ascii?Q?7byW/cRvIQ3PTnfqSAhGVuLWIMJyir3J1qa0IaBhQDiwOc13XQfNn7sm8dJ1?=
 =?us-ascii?Q?QDYzIM3L+u5etV0+FtAfhoBj54C+AIvvZWG/k7QQ7dajlkib/qYV4+NXfYOd?=
 =?us-ascii?Q?qGiMJ8gCy3sChjDQy1QSOAI8WUoSN2Oa20ccVV+SwCqEZQbrfIbybCj1cZT2?=
 =?us-ascii?Q?9R9Y+/JDpmiIm9Jh8++GAG/dmSXGzFciPEGreXctcGbxKdt1PCSwv32cm0BO?=
 =?us-ascii?Q?GbGnOPsiNy6KIrfFu9igEZdcuoC7qp/oJR003Hjj5mYV8uDqFUGhGA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aXaqnlELyrDfBbi8TMd5BUlCe+HFEXzqOx0GGuaQvmt/TB6N5EBhkFx02xre?=
 =?us-ascii?Q?nSoowQaoUPZowgyYRHf7Six+B6ECtJAy4e7RZPrgflWQHixbS4H+B4s8xB1M?=
 =?us-ascii?Q?e5Rd9RkNcv0m0HuzH2nqhGYsP8SJvYPsKmEo3yNjGRX5pfgID8KCXwPhRA5B?=
 =?us-ascii?Q?uErgCSasnOpqrEyNZTxxvqYJC45OSbqmucwLFr3VhMsmVSG7z+JuWbO+gm5R?=
 =?us-ascii?Q?nUfttimLo7XYycq0RObBxUeIRILtjaJUnHCK0ra/DApmbkI7vJQ8YlucTfzR?=
 =?us-ascii?Q?Pqa0h6rg2Qts+0gbQ6EadIExi3V/tmTaCFQyVy4uq182kavV4Zartb2yX2zP?=
 =?us-ascii?Q?rYru1aa7hD5eoTAjjf9pjGQ2G6D71pMoDhqLZR9ixs6yfADhJWD84GNiZhK+?=
 =?us-ascii?Q?L1dgd2oegWnh7gki3agHHBCa5hlVPMWoNoX8tJ+BHtYMlgfMj3WbgF9OdVje?=
 =?us-ascii?Q?47kn9aOPCRSCGay7MDcPkXLIfoU8YAh/udIvH/nVBRhoVuk1bEWKa7qkTcyu?=
 =?us-ascii?Q?uIEFKIvm0KfruSv4Fkc6zYtmV7kcaNbQgA49xtOJgNxL6j5ff0/jEyKkucGR?=
 =?us-ascii?Q?YpbtUOfI8C14ZXLvDywsYSURkBrMI7Pa05YGKz5QF7CWrHDwQN9cl8uJd4xW?=
 =?us-ascii?Q?jODYWVPXnfX+/H2uXT5HJXPuHOIDxuu16myaEx7NtgWhmd2af2DYJejxo3hD?=
 =?us-ascii?Q?crmVRY3DiOw1XRhjF1uKRNAEEVCjg/BCb9oLsEpItf9whJCqGHkVKlYMbfbc?=
 =?us-ascii?Q?BlH9iGWkxIbqDhoRBYX105mhm8uRYt1INmhkmYgsIYYn3B6vj2IzoVFwC5I5?=
 =?us-ascii?Q?z+spjhHAa3XaXVtNuMUDWW5o6B0nqnWIKNwkuUsoXqAM8en1iYl6pkr6Mulm?=
 =?us-ascii?Q?2A6FZS28gEouvfEhTHvJjg3BPVRO9DPOj5foJ/G4qx/kAykh8IISAnLQ/9Tc?=
 =?us-ascii?Q?rEJik/dF2AoY38Lj+oT7Yyoj76vofCgiGJP9IsGn3IJCdc/Cz6jELuWrp4P4?=
 =?us-ascii?Q?P7T30rd/kQbExus2/056ipxOl0f8vlzHXffoldwIwAfSF5hTXqxIf1aKW/zn?=
 =?us-ascii?Q?5LRBZSEdAYD0Xg8N9k4uueNsWRYBwlAsm5rIPZm79nnrFrAI2vnvBWBmolp/?=
 =?us-ascii?Q?ZjEpOZjgjAJWrV1G18nsxzgjsbYtGGkyJ1IOXUZwPeb54CwpcPPfwBFAMe7s?=
 =?us-ascii?Q?P3BEZYuYiymSCKexWnkACi4PctS6fQhyKLRsYR8F1wv78lmasIVtjCtzjDAz?=
 =?us-ascii?Q?WujCOZHyjdNzyQEj/BR0lIGS7vfIS07LxXXJqYk5JZOFz43rhSnxwcxENP/K?=
 =?us-ascii?Q?mx1VHfQ4Lok80FYpHdWcc8YCSCf5hAJejqchp3BPs9cYBA8WmB7fbUDaR4SV?=
 =?us-ascii?Q?ly+eMfjEO0mg0/8kAYIRJUWb3G8WpB7560LuLqsFUr4QVbHO1OrJRoL2YlzR?=
 =?us-ascii?Q?QTUFeU1D42aKLN4Lah7ibNkv3L2XozJMaFZOUAiSv8cFHcfgHqACe3Bw+xdZ?=
 =?us-ascii?Q?Mms91i7hapLHtagDAR27YVrZuozxPvUJbcj09jbR1V+BKlXEMj+WdmAz9qR8?=
 =?us-ascii?Q?dNf8sMKg2zDiyN+1+1g=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0b05a5-3a41-44ce-6950-08dde4492479
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 02:34:55.1627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: faSSRgOSpYHGWeLqgTnX+rQ8QjWb11tnYrdGKJGvLyMNFKet+Dyp8Z8POZelBpMjy/igVtInu+B4+MfdpVdu9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7713

> > > > > +static int fec_change_mtu(struct net_device *ndev, int new_mtu) =
{
> > > > > +	struct fec_enet_private *fep =3D netdev_priv(ndev);
> > > > > +	int order, done;
> > > > > +	bool running;
> > > > > +
> > > > > +	order =3D get_order(new_mtu + ETH_HLEN + ETH_FCS_LEN);
> > > > > +	if (fep->pagepool_order =3D=3D order) {
> > > > > +		WRITE_ONCE(ndev->mtu, new_mtu);
> > > > > +		return 0;
> > > > > +	}
> > > > > +
> > > > > +	fep->pagepool_order =3D order;
> > > > > +	fep->rx_frame_size =3D (PAGE_SIZE << order) -
> > > > FEC_ENET_XDP_HEADROOM
> > > > > +			     - SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > > > > +
> > > >
> > > > I think we need to add a check for rx_frame_size, as
> > > > FEC_R_CNTRL[MAX_FL]
> > > and
> > > > FEC_FTRL[TRUNC_FL] only have 14 bits.
> > >
> > > That would be redundant, since rx_frame_size cannot exceed
> > > max_buf_size which value would either be PKT_MAXBUF_SIZE or
> > > MAX_JUMBO_BUF_SIZE.
> > >
> >
> > Looked at the entire patch set, the rx_frame_size is set to
> FEC_FTRL[TRUNC_FL]
> > and FEC_R_CNTRL[MAX_FL], and both TRUNC_FL and MAX_FL are 14 bits, if
> the
> > value set exceeds the hardware capability, the driver should return an =
error.
> >
> > For example, the order is 3, so rx_frame_size is 0x7dc0, but MAX_FL wil=
l be
> set to
> > 0x3dc0, that is not correct.
>=20
> How can you get the order of 3? If the PAGE_SIZE is 4k, the order is no g=
reater
> than 2.
>=20

I got it, the length has been checked by dev_validate_mtu(), so we
do not need to check it again.


