Return-Path: <netdev+bounces-175242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F768A64857
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 10:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0E43A256B
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 09:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3938226D1F;
	Mon, 17 Mar 2025 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FbEdxN+T"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2069.outbound.protection.outlook.com [40.107.249.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB92227EA4;
	Mon, 17 Mar 2025 09:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742205331; cv=fail; b=grx+GS1eDGUlaAWAjyTumFiRF+bGzEilKGwe2j9TsKmoXvrkMDkSecx+xzwjjo0K+tiT9/LeXaHGXPBL0JAOcqIW1yAFuvzB0A35mX3++k5FRpPoArFWA+fObG6HqXxW3GeOL1IxmkWa0ZwRt+uzlN+FEIeWOlOJbLvcz/l5ySo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742205331; c=relaxed/simple;
	bh=qSOJw2XkcFQgjaQTsQzhupsS9m8PTUOfy7J/zEC8Lgg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UAIaj+FET0FI2mKt1Q2ebVqbbGNmWLTy0p9eDKLF19Bjt4vhjYEKorna5debQ9hCEhQZTue7f0/6ZQPtZ/+7EbeX8aCdxNhlgvrMoFpfV0zdOeYrc4doopwVL2lumwN5WNH13XSPfcG2M09Vt3ZX47wl07Q0NsYm/NIL1EJoe0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FbEdxN+T; arc=fail smtp.client-ip=40.107.249.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SL4kznU4RwSz0clZLWZq5SV7oKhdevzsAqPDgjP29760kZqVVeuWuYcCFGb1S/tpVOPr+eS5vi/am0oKykact0xhIIyacv5q3xsrtr7vfv+uwGmNW5WW+MjU9hpMeWgd1uIw9yw0XP3/AX+Xl7oLQIP1+EmeuAELQx59M5fvNfvL0Egekb/JiXdwt70brTHfsPZKKGRP/85u+YsPwhKLPeO5J7Lb/H+f5pNuMawla/urZrKupDpTtTtguhaSTMa5P+aRhg6XSMe2T33llBthwAojnBV5Oy5eixlulVhizmM/lw8YCV2gd/6ql9bMkNY9/qOdkIP4Dh1o7fmFUwZmTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2HMNd51ebCLuc/+lI+FA2F7wifTN78z+y0do2Gb1hE=;
 b=kKMSw4qbaSiNtVV0QEfPpbdvIaMDcMiT7uxJ5oim9dNx8o7mS1nYF6nin6JdXpb0Fs27a5pLt5aeooq4eQ/kYZxTewaU1+d//3pFaIsSwjEymZ1R6UNpXvsfXsaMHyiEixlPlzYy91IBhgTdwxcFv9I10lZ87Kf4ju7Gy9OMtQyLvHcPaiXwoNAQCBXN5G7ThrEC6d6e4XMvqWvd5M13x0cVZNSJcBOIv4fc2LkzD7u4hpjEub7kpd84WHJbGDjIdFX0EAwJCQeGeu9cetJ+aBXBqjHMwB6fejMrHSJBNeQSHDfn2ectCMuj7aMp8AvfTMkDTTWaLSaCi0jj4tFdkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2HMNd51ebCLuc/+lI+FA2F7wifTN78z+y0do2Gb1hE=;
 b=FbEdxN+TLfdDOr5z3hGJJl5DxTkq/I95bbpua6vOENM3BPpQqxQV9FxvMw8KXhuuX2YVvMrkgJzwxC8oHe4v58Et6hG2BCTyoYCFdayQDw2gkISxRLvlrMhmz9iSaMhTXavD0i+p6JCOw2ksIUf1Gx5Esk+J4Mv9AQPxvmDUplCBFOjzGfx21Ms1haP0CJuJgc8Ps16oZ41KyyebW+vf3n2CHlBISX31xrxcrnoQjSDLn/7jlarDk0ydYsktwMNJFj28MJQl/QyoJpgawf3r8Tos6jJaIYIUJXmq3xuOIXMuqpEH/I2QFvbBd1alm/6qP42TWoKR1lWRUCqBjBFndA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8880.eurprd04.prod.outlook.com (2603:10a6:102:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 09:55:26 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 09:55:26 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 net-next 01/14] net: enetc: add initial netc-lib driver
 to support NTMP
Thread-Topic: [PATCH v4 net-next 01/14] net: enetc: add initial netc-lib
 driver to support NTMP
Thread-Index:
 AQHbkkpJSjcnE6eIUE+0uP7QMRa23rNxR0QAgACVlrCAALozgIAABn+AgAR7qACAAAK24A==
Date: Mon, 17 Mar 2025 09:55:26 +0000
Message-ID:
 <PAXPR04MB85102185D0A4C30F0688AA5488DF2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250311053830.1516523-1-wei.fang@nxp.com>
 <20250311053830.1516523-2-wei.fang@nxp.com>
 <20250313163526.pqwp2wsfvio7avs6@skbuf>
 <PAXPR04MB8510327277CFEAC750FE49F888D22@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250314123715.fivq2cbczd4khxkk@skbuf>
 <PAXPR04MB851027E5F830F08F3395083888D22@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250317092808.jel2au3cgfwblaxk@skbuf>
In-Reply-To: <20250317092808.jel2au3cgfwblaxk@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAXPR04MB8880:EE_
x-ms-office365-filtering-correlation-id: c416d48d-85aa-4e44-dc9a-08dd6539d7cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?uqq4zlk0TXYxjWT3TlsLU1184dkZY+UEmPx9WvBoetY0O2PXXIRh0XScetAk?=
 =?us-ascii?Q?br8Zdz8tNVi7qbyeUdJUIHkeZPdog/bnI5gVJKoaM//3Ves+sOj4cYq2cTQN?=
 =?us-ascii?Q?zFwsf3kYRWZUGT+oHxCqOmruT2LqXUcSOOUsND1WLkh7ouefWS8fi3Jzc1lC?=
 =?us-ascii?Q?uXR7CJk6nOoT2n19sw6vTkO0YfWL3upU0wU6OzG810WoakYcy5zIQ7PhqaiB?=
 =?us-ascii?Q?WzNnhOd5lrVXvIkTHy2S02u3bwtaY6X6dROTtKyuw+dH8KNIv5J1aqLTslDr?=
 =?us-ascii?Q?MpTZNSvEOmme00wNf5LXwssgGkgHCcyE2tzCyJaJt+sgTy8d1h75NruYOBzb?=
 =?us-ascii?Q?b7ykIqBY6rjqKNJH7z2ZAr5QujtZ26MBro/2qT+g+zlRIoUDdT6gCavdulL4?=
 =?us-ascii?Q?giB2x32FJeOp5zGF2/d9bGWsQ+QTSIBhBYAsxiWJRiY4b8MV75xYVIW5CI/s?=
 =?us-ascii?Q?UH/tCWM6Vd8mC4a1kpUCRx5pNWQyX6kSKHZGjsY84J6zv/Np3s93hgm7nlCJ?=
 =?us-ascii?Q?KZcaT7+PbImkXiYZm88qLsn07++JQ4bze1EB5UZ2C6D6iBnbi9jiDQ7sh195?=
 =?us-ascii?Q?iYW13BSuPl06tJ1b2PpGIn4LQ7Lp+HHzihbRf/OdvXvoJElIld0zANNgCKfN?=
 =?us-ascii?Q?rbErq9dNiB93AAwZSlPCp0DWiDnI8UgWatR0wbcMtCa1UqSuABmYFU6Gcnv4?=
 =?us-ascii?Q?BBA3ONc4pzk508cDpGP+Ts/Gvzp7d9yUQ9Zli2+xhCsivs0Bm2VRuMsN333V?=
 =?us-ascii?Q?5a7v9mQ5PiOVrEnWXisdcAv91ODd2RuBBhdveKRpsoqaa7qIHrM5jtj4w1dE?=
 =?us-ascii?Q?WxWxyW5vP1RvlMZba2WZCzsa+0gDyrOfnp4/HWC2IaiG4I2g+dS4y8CMtZvm?=
 =?us-ascii?Q?uVoccaRtZvdLp5Kf+x0ClgmfAiyeinI1PJUTEujRf0+YXYB5bVmk66t2J0Nn?=
 =?us-ascii?Q?1l1db9uGF7CJV5f1lIYS0Jyw5DqqBojbC9I8mAViZODIWc0jWON7jBipmUJR?=
 =?us-ascii?Q?rRaJfY9KuJ3lHSOdb40tGCP5Pw/es+VDzoK9CJkYs3uhBnO7HdALbvgocSn5?=
 =?us-ascii?Q?JXwRM7fBMOthRU7/NacxsM8Kv/Ublex63t/SW3rlOUQUzv2p+xRqFrG4iqXs?=
 =?us-ascii?Q?g7xpZjCA7QqYmwd2CoXpVFDodXEUrMhDvihbRt4dBdDKNvff9RBwwT2aIk+P?=
 =?us-ascii?Q?fhGX0HlOdhFqosU3ddzyWU12z7Xls3YgoB0V3eCEydDoSpvt8D4WB7KkMskr?=
 =?us-ascii?Q?CZ4bQJfSjlBajhIcUG1tM729ESIxTxRwhgB0yPngKSU4oQmDgrx2j93KRt6M?=
 =?us-ascii?Q?v6xN3hyJpCn5gMbIl4SwNM8uqkpn54Y/IoeAKbCt1RBZ5wfkX7T0TH7SPGdt?=
 =?us-ascii?Q?Mv1kYagDoecvt2gi13CRiR/3LnwEi6WFvt5kHRingn+cePk5HL66rWanUtgV?=
 =?us-ascii?Q?kvfY2+YA5c10hBsv/fVbpC+8CM2LWwRI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DlKTG5FAc9EPTnMcMhOlsXG6YRJJCPaB4jrw+55aU6lObSjRLmJM+sO2MKRV?=
 =?us-ascii?Q?zk8YqGsdDPX/zNTV4sOy7UTi9e0gmSMyF7kR9q4qgx+B5mOgMp36cbj6PmZR?=
 =?us-ascii?Q?QHTU7cFQLoZ++5gsYAQD81Z07cH5v1w/tvW1f2ABvDh8/+owm501cglj7oG7?=
 =?us-ascii?Q?YzdIWy5GaMTyrf7dD6jcaM1eBPvL4AEDSaf4ZOnfS9sGGrLCZK10mqxMB2u8?=
 =?us-ascii?Q?Npt44bziO47EKozD6j4XVqlGAKDfVkeoAAvdZIYEGGq0O6UEZqoJwQBMgKsD?=
 =?us-ascii?Q?mlLPH5MWO7IyzQe1UAUvyUvErHBCa+o6PbfN0eYkxAAaS59sMKvt/1fY6sJw?=
 =?us-ascii?Q?nYrKmJvsSr4dxKfs6PB69nI4mhU9k4stmy5gK4Do6jD41pDJgL60pKdCk17l?=
 =?us-ascii?Q?T6WFyf8zyISUFkCwhWj4DArKw4pEUp/9bcaGeXO0gjnKigfhu2Lh0bYEIrxP?=
 =?us-ascii?Q?SUcls+c76wEE4QFkidIJntH/yJDkN+F4rJjjE7N45DtKJ/m7PPaY9nbzWbS/?=
 =?us-ascii?Q?N0jioiRPExiw2PykIwK9biuocARWHQ6hIKPqo1oZXiHF2P4aVzuSj3sKalPZ?=
 =?us-ascii?Q?U8XeCHiCzKSQE8dhKEHaHC1VPWwoWAwm+LzwTfHjYMOv5YjU9vz6b1q6WJNK?=
 =?us-ascii?Q?Q3JJqy51T2Xw2LtXsvBF2evklxB1shV3ye2eWX8Kg2GldeKjq+sSm3TqYuEQ?=
 =?us-ascii?Q?ulMJw46Q6lMy1OrGPKRPRiJ++422tIgQ8DqMM47j3NbOo36mqAroRvWa7IiV?=
 =?us-ascii?Q?r8fXGPsnlbwYCFXJndyLXR9odnOdlIG6byJBFbeGVT/uzTIDeraNrZWXeG3t?=
 =?us-ascii?Q?8/73ZPscqLbojpSrkBMu5sT/v1mpakNFSrlSoTwf4s7DaDWScBIrFYUokXlS?=
 =?us-ascii?Q?bmvBZo5hk3hbIMS0Gv5IMHOmZGjZgLBz381n/nrjtIsqAWPwzc2TJC7q/3fz?=
 =?us-ascii?Q?MWgpoO5Irxt5bGt4dKkySP6cq42UWNXKG6naOoTMMPliW/TxFxrN4NY4alxy?=
 =?us-ascii?Q?GJLum1vym420WaXqFFFYmvmaDMD1MKGCOrEKWjm16UY55QyvH5R4an1DGMGS?=
 =?us-ascii?Q?fWi8iFYNyn0rYJ77iq7pQDbiGEQSw3Dkgp9QH839b9ZRvF7WC85YR4afDzGp?=
 =?us-ascii?Q?GRNzN64spF/Q5CWTOtFLRSTm0ExGYr8RrUZ29Xx/ad++3kDzbuxd8o1eEQKL?=
 =?us-ascii?Q?XHbStTdK+RCOXinuoBrQOW9WGRDfgZnG3L6akJ1kqdl3QvXTslChOaAL1tDK?=
 =?us-ascii?Q?+NLgipuIQvNYSoO3iaB4TMY+uOjVtfkU2KMEcb2rWZLh5fXDy1AOVJfX8CnE?=
 =?us-ascii?Q?Nfj4f+DqMwXztQbLE6C7QIGXYNCQy3Vga7yiIgfUaD+cxy/pVWOjhIyT34aT?=
 =?us-ascii?Q?3sOXCv6CRZ2R6B/BG+tsmoQ6DkXRowDlE2JIumKW5Gfbr9Z3AnJhRZcRkhlp?=
 =?us-ascii?Q?//ZaRAQZAxy+b74r5f4DAKfXsNp30hHsHbIdrITJdHOqaFQb3l2EVtKdlsqr?=
 =?us-ascii?Q?l8GhuzSihpwIxGhQLUelNY+otZFYQSrz8feYJrR3NF+rvuWLvfGOVV8Qj9wd?=
 =?us-ascii?Q?/GT8Z41xImE+UQFjRHI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c416d48d-85aa-4e44-dc9a-08dd6539d7cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 09:55:26.4187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wYI/qkwu4PQ2xqZRC38F1kBqqIBKBJ53bKyExulo08LowCl/+GB8M3iEUGk/D2ng/x+U1Hx7PuUGHwZG+SQt9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8880

> On Fri, Mar 14, 2025 at 03:48:21PM +0200, Wei Fang wrote:
> > > I mean, I was just suggesting to group the macros with the macros, an=
d
> > > the struct fields with the struct fields. Mixing them together looks =
a
> > > bit messy to me. Even worse in the definition of "union netc_cbd" whi=
ch
> > > IMO needs to be reconsidered a bit (a hint given below).
> >
> > I think this is a matter of personal preference. I was inspired by some
> > of Intel's structure definitions. I think this method allows me to quic=
kly
> > understand what fields the member consists of and what bits each field
> > occupies.
> (...)
> > Thanks, but we have added fully NTMP support in downstream, it's a grea=
t
> > challenge for me to convert it to the 'packing' method. I don't think I=
 have
> > too much time to do this conversion. And I also need some time to figur=
e
> > out how to use it and whether it is worth doing so.
>=20
> Ok, I'm not forcing you to use pack_fields(), but given the fact that
> bit field overlap is now something that has to be manually checked, and
> a bug of this kind already exists in this set, you will have to wait for
> me, or other reviewers, to go through the bit field definitions from the
> entire set.
>=20
> > > And I agree with you, I also don't want ntmp_private.h to be exposed =
to
> > > the NTMP API consumers, and I wasn't suggesting that. I just want the
> > > NTMP API to spare consumer drivers of the gory details, like for exam=
ple
> > > the buffer layout of a MAC filtering entry, reserved fields, things l=
ike
> > > that. What I was saying is to keep the buffer layout private to
> > > ntmp_private.h, and expose a more abstract data structure to API
> > > consumers.
> >
> > Sorry, I don't fully understand, for example, if we place the definitio=
n
> > of "struct maft_keye_data" in ntmp_private.h, how does the debugfs
> > get the information from "struct maft_keye_data"? Add a helper function
> > in the NTMP driver and export it to enetc driver? And how does
> > enetc4_pf_add_si_mac_exact_filter() to set the mac address to "struct
> > maft_keye_data", add another helper? If so, I think it is more complica=
ted.
>=20
> Well, my complaint, which has to do with style and personal preference,
> is that exposing packed data structures to NTMP API clients puts an
> unnecessary burden on them. For example, NTMP users have to call
> cpu_to_le16()
> to populate data.cfge.si_bitmap. A bug in the packed layout will
> potentially have to be fixed in multiple places. The two options for a
> more high-level NTMP API that I see are:
> - You expose pointers to the packed data structures, but API functions
>   provide getters and setters, and the exact buffer layout is only known
>   to the NTMP layer.
> - The API functions expose "unpacked" data structures, which are more
>   abstract and don't contain reserved fields and are in CPU native
>   endianness, and the NTMP layer packs them to buffers, either using
>   pack_fields() or manually.
>=20

Actually I did this is the original version, I mean in downstream kernel 6.=
6
tree. I add a "ntmp_mfe" in ntmp.h like below

struct ntmp_mfe {
	u8 mac[ETH_ALEN];
	u16 si_bitmap;
};

And the conversion was done by the NTMP driver. But then I found that this =
was
very troublesome. We get data from kernel "struct A,B,C", then the enetc dr=
iver
converts them to "struct D", and finally the ntmp driver converts it to "st=
ruct E".
So I thought why don't we convert "struct A,B,C" to "struct E" from the beg=
inning?
After all, these data structures are only used by enetc and netc switch dri=
vers, so
in kernel 6.12, I changed it to the current way.

> Claudiu, what do you think? I can withdraw the request to hide packed
> MAFT (and other) struct definitions from include/linux/fsl/ntmp.h if you
> think they're fine there.
>=20
> > > Thank you for posting the downstream layout of struct ntmp_priv which=
 I
> > > was already aware of. What I was saying is that the word "private" me=
ans
> > > an aspect of the implementation which is hidden from other code layer=
s.
> > > There's nothing "private" here if the NTMP layer has access to the
> > > definition of this structure. I was asking whether you agree that it'=
s
> > > more adequate to name this structure "ntmp_client", since it represen=
ts
> > > the data associated with a consumer of the NTMP API - a NETC SI or (i=
n
> > > the future) the switch. Or some other name. But the word "private" se=
ems
> > > misused.
> >
> > Okay, it seems to make you feel confused, let me rename it later, how a=
bout
> > "ntmp_user"?
>=20
> "ntmp_user" works for me better than "ntmp_priv", thanks. Are you also
> going to make the API functions from include/linux/fsl/ntmp.h take
> "struct ntmp_user *" as first argument, rather than "struct netc_cbdrs *"=
?

I think we do not need to keep "struct netc_cbdrs", it can be integrated in=
to
"struct ntmp_user".


