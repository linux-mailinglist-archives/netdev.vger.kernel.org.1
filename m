Return-Path: <netdev+bounces-194454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE2DAC98C4
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 03:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E143B22CD
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 01:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BDE1BC41;
	Sat, 31 May 2025 01:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gHQRChX4"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011069.outbound.protection.outlook.com [52.101.70.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816A81CA81;
	Sat, 31 May 2025 01:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748654841; cv=fail; b=Q3G9kPeUVuiOVThYZWp3rFJpiGFCxQsa5RfjPS5ZB2sfd0wADuyazDz17LKrgMoJm9lI1r/WBOcw37VNJCA9a9pzQlFjGjM5WQogEu6u1KkXeXEPAH2XHU1/Nw7wJJKJw0DCACynVpO1Kz0s8V5lryjI2PmLS+Bfc8peZXpUz7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748654841; c=relaxed/simple;
	bh=lu2vuKTx/qD/Ts2msM+XMRHV6Kd6xWVIv9zdg4UDvYo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UgIQWrwZGbIp5oWyD+3/+LMLhchnr/OpkqeiaudIsmDNCwtW50Qb1agSODLhO7H603JcmBb9ufGy31mz+wLjfJ5JwYrkJP8j42kFui5muGM0HPbagKN8jGeRRr5A0tOLzHlfSgNB7Yipa2D3Uy8xjTmc2u+it5gMDCcuTQBzuQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gHQRChX4; arc=fail smtp.client-ip=52.101.70.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOFRBVlQui+thYEi4wabF6CceCnU50ooASnII1iG2gRDd0GL2vV/KG4o+Im5KPwu8LBWi7T/M+7cGzLqW8Reh2zpHuEyroROOpCRbllHhWR9xvAu6DZGPkR2PxR0j3tJ4KRVPijS1D/me5IzmTciR69T6MZaOsdvFgLbz+UgLNTBmeRr+AwFCEncyfYrmOa2vmIyMFMqw4jmYXzq99UfDrWnBDIE47mff1KplD1cshoxxT9I8gvcwAO0immuw+bKhIQes99okRZ1u7NYXtcm48qwUTmIOBfA9P5/VS+aqwb+65M0gmO8P966waHdbEz1D1GsNKRgYVJSVMmL9D72kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lu2vuKTx/qD/Ts2msM+XMRHV6Kd6xWVIv9zdg4UDvYo=;
 b=XwIt4aaTsbSOpDGS5uXDWyu43OtS0WLyDyqtMHhvSJSYoPy4xaDHSj3lVG1qZNecjt9T9bXib5BrSDEFusoN40WkKQGouSCvETCB6G+5TiBGMVB+2sa0FMQ9H5oPWiCEyXfl5VwZ+aKbKCTLUiRWObrbYz43axiDzuTggosO/W5Bl6ZrKWhe5Ii1UidrhMvEzwL8sIbli84+oa129tJIpkE8bphyoImxJV7aSyNZyEE+86AxYYtrP8oJ+xU0oFe4r2LufnOo402z9yr0JgM02iptJjzA0Aywxb07V67pigc5MKMNIYXTO8Zg/cuUy3wI2NX3tfXVarOU5KfXNcyQ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lu2vuKTx/qD/Ts2msM+XMRHV6Kd6xWVIv9zdg4UDvYo=;
 b=gHQRChX4sikbDuDZjQYIFdu9Zh7ETAhwtV6xGVXFlhL2RTmrTusuVm2vlZQuxUT/NR1s+OD34u89SY6bIBOtr7orn3++YJbxSmee7oR5569U9kx2EHOmhEKFUBeBLmQpWe9fe5kyWoxWzIx0LwGg0KQJRlIGPf+NODtldz+tClqnzVLor+jK5CSmUcYkMTNBDeGIfBjsmq/SLcKLT3//E5ji7MrSKvSFjm9TU0XaRXjkg0qpKM+hSkGvTNGwFb9l2N4rBOeUU2mx+cnUS+p2JAFbv63wb1rWKWS2B6PGy/lYZSFDS/8J8dfWsrhDgK8RR+1wj8+PqET5KIeq4OlQyA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8449.eurprd04.prod.outlook.com (2603:10a6:20b:407::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Sat, 31 May
 2025 01:27:16 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8769.031; Sat, 31 May 2025
 01:27:16 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net] net: enetc: fix wrong TPID registers and remove dead
 branch
Thread-Topic: [PATCH net] net: enetc: fix wrong TPID registers and remove dead
 branch
Thread-Index: AQHb0UQJkvk3Nmb+7069SinjV+RcY7PrZIEAgACNsoA=
Date: Sat, 31 May 2025 01:27:15 +0000
Message-ID:
 <PAXPR04MB8510044810B2C0973978B6248860A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250530090012.3989060-1-wei.fang@nxp.com>
 <20250530165434.xzdroce3i2mmwxcf@skbuf>
In-Reply-To: <20250530165434.xzdroce3i2mmwxcf@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB8449:EE_
x-ms-office365-filtering-correlation-id: b9351551-90ab-494a-cb40-08dd9fe2471a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CBrijKSJUMl/0UrQeLCgT3/LVBs+OFqcasR03J6LbcOzvUeGggVQm9bMyMVh?=
 =?us-ascii?Q?BiCH6maOZ+Oen8rbXlTCwoOiq0Ojv42S/4ljN41sU3sDKWOhb7J8WCzMs+oI?=
 =?us-ascii?Q?PDivp8njWepUzYc/zQODaBPIYcosekcz6bHJf+LUUE9F2oFqLao5ofoLnEjc?=
 =?us-ascii?Q?wvxeiAKOa/AE549FzqRWEsDJpMyXdWi/DVmiTobRAtrkPurYhC9dvJfLWgme?=
 =?us-ascii?Q?Vdr1rbZ8TAfiH+GXq3JgJK+sq17O0uwM+iW0i7DiPPb8ptkDazvCJcxeZgMa?=
 =?us-ascii?Q?a9jZe6LDoXRa2RsM8mdmQVHlDyvnhRS5IxmhYN29Ic33sDxwWiA+ofs8u3mc?=
 =?us-ascii?Q?To9bubbPdN/HORlfPLP+LHEmu9CfNaznd+SFU6FdqnVyD6a6q1iHceiTwEJ1?=
 =?us-ascii?Q?2yB7nPhXrBdT32JiQ6HnGxZk1ulccx7DX9mR5NU+pvll3x11s5l1tgiXNpzR?=
 =?us-ascii?Q?B214x1A5PHfC4y9ZUcqqDJe6TrfOhvAmcXDL510tHdA5Q5DjneB2t7UmDxsi?=
 =?us-ascii?Q?qPrzaj2p7ICFBySxs9kf6zJfomDRKn1/i0DGN8JWeDbl+wc0Et5Ldb3GZoLy?=
 =?us-ascii?Q?EtMU+sSKc7nGVv8NX2IQNJRnyD+WGLt+ByoXILpdwmJqDzmqLdBZX9GnOd4c?=
 =?us-ascii?Q?Ua/6wU7jnwsW1WBYXy3E1lJCfuS0rnJyvDAMlPJL8gBuVyoseJR7yZxyRgKv?=
 =?us-ascii?Q?pYXKE+NBt4kInGM3/kqCOiwTaaCp40S/HcBiLeksUdN9L3wG4Pbtzd+wUzFR?=
 =?us-ascii?Q?kf3wTHfHX1nKfjvsBt6kI3WDu8gGib45bxWLG9GRCGMYk1LOsh5FVgs209Kn?=
 =?us-ascii?Q?5/yNE7bLsHHpOVzlakygznA6pkoxBGvx5/iJ6M/A9Kto7ChrMQTjsYR8js8B?=
 =?us-ascii?Q?cYCIdgcHo+aJvlj1CkXv76o3hO6cx2SDApiVjaFTMZ1mpQY87a021jPHPWr3?=
 =?us-ascii?Q?5hAazKZ3wgsnQ2jd+nUlW+h6u+640hkob7PQ8f2mlfsZCAmkV+Fs8SwOYub1?=
 =?us-ascii?Q?V9M39362hhrnHYzQkftfqz6dsX76MFJc6J5bydxFvEyZb3wZZFJeBkpyD3yU?=
 =?us-ascii?Q?/DTEe7VGwIs9WCHGAVKGlaC8tdqodrqSQvRX/3OuHsSHVXJ46fEvhzniy8ar?=
 =?us-ascii?Q?6t9g2MwVxP4EpPJVBMZwKX4j1lo7FZGBRDp6UrscAkD+oyOlSkPOu0LFlmqB?=
 =?us-ascii?Q?KHSW/xv7naWvWDysX1vW4slkXxUpY5TDRz3mMffDOOCwHOfe7yxtO8O4RpFf?=
 =?us-ascii?Q?jjuVzyTOaCp8Wl6AlyUm2Il73G4+4I0Zu/KXH4nimrCK1pXD2Zezfbzgcnrb?=
 =?us-ascii?Q?cWqRB41NrTkE/dRc6Q/euZVJrerUmOD/YbOWZR2Cht4bqhzdISRMQbZkKh7X?=
 =?us-ascii?Q?i7YFIJRqS48R1KvCALWF2ggquNtGyu9TUAv2TerTn8CpTVxEXrE9MT9KaOep?=
 =?us-ascii?Q?io0LHydQ6ls7ASbH8gPwaHxtZuMgOcgwLdL0+ziNshHWvrNv77POEf3wICJ4?=
 =?us-ascii?Q?47jx9vjvt/i/WHU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?A/UCchFZqmfFgbp0Q2SZCP6J4iKiGxbOT57z7/AcjB0PaDV8wCDCE3X/G7HF?=
 =?us-ascii?Q?Zt15wzevQNGkoY4khp5RCHbi37uRWjNKidt2cBe9z//jkcsy6JGeG0OFnX99?=
 =?us-ascii?Q?74nt0lRn7qHRZhV6PBiBsCNeXfWA0VPj1OsBfV9oa1tJg6urh2cBCU/a96m/?=
 =?us-ascii?Q?LPCUZgNpp/PleiaXxX+7BIilQAAm+KbYhkMNrPF8mChTTiW5gtO/DOPjNvro?=
 =?us-ascii?Q?dI0VB9kSY46gUuVJu3+ike5TQhoDRCuc8vzXHOfYn3uIUyt0PUkaYb3sqTsa?=
 =?us-ascii?Q?1R8v73Jw3CcHJdUzuNxRqD8uWc0nhuxsXwgUfFtCxpgHV/3HEsNvGxGQyuIC?=
 =?us-ascii?Q?yqcaIlWkd8jxxesA7n1ddEzT2St7zV8/vyj0Tg7Loh0lq3pH+tMVK1RaUbgG?=
 =?us-ascii?Q?J0Hs9koiglAe1iknbAN6hlvqAJTE8NqZFoAdfEP1hcXSIq7+tnRCW0/kXXhW?=
 =?us-ascii?Q?HuwyXliKReNQ6q5pFzitYnrTQbhMYLXPGx964iwPai/lBwaio0RHtWuGMIdn?=
 =?us-ascii?Q?wls2RleJAXVC6gxVVaVsqPPvIVMOgGdYDgBzeiKy53ENZFt3/4SVoiUjidHB?=
 =?us-ascii?Q?saVHyJk26MfFq+S5d/szHt4Rx5CdMnVXj0xT24slFHkCktVNKHqzRsYwN+zp?=
 =?us-ascii?Q?0KbsmlAIulzVpRw01/vsOen1ZqkgNyZ1WNA+kQB+kg8IzYCF1rK/9+i3+YVq?=
 =?us-ascii?Q?BlAGADw+tSb+UMhM9fmQjOwFt0RAltUhckjlWYEs9kzaxy2oHBaRB3ILhGx6?=
 =?us-ascii?Q?+l2MZx8UVnyar2sjdzPPnlOzBErqVk0TcDuRvPUT3xWvOpllVqJ7JttdML8V?=
 =?us-ascii?Q?Q57r9U8SSacs/7Uc95d2Lu1yq0dLBSI3fCxO20TIeNJ3QYY6cvpwuHi+qxcH?=
 =?us-ascii?Q?l+rDzxEf+CBvWe5qD3ZT/kgrTRXO21s78YJvPcmqXMVYYz7joPmTmvzv1wno?=
 =?us-ascii?Q?v1YalAqrkVGDGIXWL2vnsjfCK9W+hG6ZXkj5DE5P8G4OmT7eoVesGTPYRsMv?=
 =?us-ascii?Q?WWKrHFLnrZFDlw/3Cauz5GCgn066Q5Ko/rBQxnpciwogqrdoUvHLBfdDbUk7?=
 =?us-ascii?Q?3K8Q0oyUWIActHoPgEi5MHCwNzX33l0XrptdS6rG7fHIGUGyXxwQK+yskbFQ?=
 =?us-ascii?Q?RHZOHFWRTRXEMYgopd1SHpjM3UJe8/aIarsqLh7anHP8wvXrSFFbchdGp+Lb?=
 =?us-ascii?Q?14YNUjsv0lxIQr4/02R/fBmO0rWfIe7iyUA7hqOeRHFrDSpxLXPIhuMDtleQ?=
 =?us-ascii?Q?fU35enE6GKEXVpC3UKFJgdqmysdDwvgL1q9cKxH0G0KChFUOgePeb0GwPWPA?=
 =?us-ascii?Q?7xuwettmjHt2MiERps5pUD4DEXlW7aooP4lkB5WbnTcqdrAMyFcqc+RnS25Z?=
 =?us-ascii?Q?rc0tNNj9R2u2KjVcyzk6b2V8Z3K6DYnpTtJry4yXg2qBtHz3tL7zJp5SsR4l?=
 =?us-ascii?Q?uXnMiaNvd0Og+4XwzVi+GjFen7R8dnyF0/BFxUtmjJyEhzvE0LiiI5Y/34/5?=
 =?us-ascii?Q?mr1ce1TWlJKmFwhFVaKYWoaD/NWs6iL20jKkBlkgGzPvQYo0fsab4dnKl4Cg?=
 =?us-ascii?Q?F1KbhXk7GxYgu3IRJ74=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b9351551-90ab-494a-cb40-08dd9fe2471a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2025 01:27:16.0632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ifJ2syVtqGMyEG202HQ4dlA2A2YVof125AVnAYEkvFqcFQYDuZ9h1QBJNXs/Lecse3sR3xK2nFo1pij0+kvt6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8449

> > In addition, since ENETC_RXBD_FLAG_TPID is defined as GENMASK(1, 0),
> > the possible values are only 0, 1, 2, 3, so the default branch will
> > never be true, so remove the default branch.
> >
> > Fixes: 827b6fd04651 ("net: enetc: fix incorrect TPID when receiving 802=
.1ad
> tagged packets")
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
>=20
> I see what the patch is trying to do, but how did you test/reproduce this=
?
> The CVLANR1/CVLANR2 registers are by default zero, and the driver
> doesn't write them, so I guess custom TPID values are never recognized
> in net-next. In such situations, I believe fixing a bug that has no
> consequences should also be considered net-next material (and net-next
> is currently closed until June 8th).
>=20

This issue cannot be reproduced because, as you said, the current
driver does not support custom TPID, so the issue will not be triggered
in actual use. However, from the perspective of code and combined
with hardware, this is problematic.

I agree with you, because it does not fix the issue in actual use, this
patch can also be submitted to the net-next tree as an optimization.


