Return-Path: <netdev+bounces-159711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9812AA168D5
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 10:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05435169F47
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 09:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8C71B414E;
	Mon, 20 Jan 2025 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F/e41w43"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5BA1B4151;
	Mon, 20 Jan 2025 09:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737363745; cv=fail; b=cvHUIYhZTNXgnkbpZJsIE8aVU4RU9r8/81RZOOHkznfTQLigIQAlMmxDDU86HBP9phc5mtuHp9adcHHqCgOWveRiJzlBovoPIsIEKB1M+NHH/lx5fbFMZ4CN7fNMSqsYGQoOb4ylan56t09C9Ow+wlOxrIbgJ9DAXncI96QvY4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737363745; c=relaxed/simple;
	bh=qUX7v47F1ggzI7KCeibQsCdtracMD6e9cukWiPipCnA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=szbZhyycV1/h5a0z3/5TALTNfQuJgJ2LVkDZH5Io4cST1tuRXKs2X+4fpIxQlnIeVCBUthoOFcirq2wRa+KDzZlgp4DmCGIyt6702DSmNi0khkg+0gNKg1rTkXdQD48SzZaOU1RMMrbYnUbGxBfuNTNQYp5zHWIyedfc27vBReM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F/e41w43; arc=fail smtp.client-ip=40.107.22.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PreQ0aPL3PTeROrkNKaWgWznJ1+5QYZmYlkCW8HZQsUyCtLtIPnWbss1rAUjj57Oq7FBKQeA1y748EQmXtxtTCzEkI2I/aQ6fCrSkplgrOnnrcyKFEwMhFxRGIO2oMb3WyKDAIVhF0H9YnXpKRfrS9prlatNc7IwVIzpf8RtAznNVj1CP2A+b+kTE4WRJ9k8FXpfr3oD46CpeeVD+toFxSgLO5ns6GCaPRjKC0/AGqiQTnlbVEN8s5DzSt4J7XcAZDoZTSFy+wyYLy5XvW9Msz4wgj/FU+zI7T8idqMviRhduO8PS031cZjszLLVSa00eksFC4e9h5kj7P0q42B9uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+tfUHDLfRyu3kZXVQJj64VuFpmDCjFQr3mmXLuhsTY=;
 b=tO43kmhDnjztudBqEHYoS27qrMTyE+0Jw9X57DH7uIFQ4TC9JEAXQbOU2HEvJ0bdwG4UnPuuTk2LNRIAomMX4VpM8R3W8kBzUelNpEaY4N5nocU0y0j7B4ud2pFBnJxbpwTFxw6LlL1F7uK9LBqCV85DZ0ZiAW4StU+lirguhtMC/SWVuBaXqYNLyaW+CN/l97S9w5WBwS+Ll+/UWH1Xt8Ar17Guma8lxbKIsyWU6Wq4vVsaiqam2VnsOyjyZ/kSdSNs3Oq2QaSz0wlQlvYKfiZo7rdTfcumb9KCMjCs4cVyvsrUjHKO6J1zc7A5BN9BC+mvH9mn7wbUZiZ0JXwD3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+tfUHDLfRyu3kZXVQJj64VuFpmDCjFQr3mmXLuhsTY=;
 b=F/e41w43Ib+2IM/2/YJKV81SNZaMt/4PyMKUpbCiS8zi6fU0L5dAg+y9t3fwV6URnjzVWTzi/vj9AHOaEcpMIqACtfsSOgm9J5ev81w2xCWgE4kcMWPhDCUrfXvYO76pLQfTihPMMM0ur4f69pFqddd62+RbxvqhMeMP8o87239th856RrLuyTXydE180wJcM87hj/vJW2Txaue+APFX3M3gT6X/9GyNtfijcMwpIUul5o2ICCCYtMLRf7QyAqVtfXeGQnQOjItasuJBdOCU5VXpQIypLeKAyc+rVIxsRXb+sRDu7EhcPa1bSGuRsjj5nOCSCoR7xu7GOfa3vTgLbw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10227.eurprd04.prod.outlook.com (2603:10a6:102:456::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Mon, 20 Jan
 2025 09:02:19 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 09:02:19 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 net] net: fec: implement TSO descriptor cleanup
Thread-Topic: [PATCH v4 net] net: fec: implement TSO descriptor cleanup
Thread-Index: AQHbaxjyZcWvX4RA/Eijw2izDQWggbMfXYWQ
Date: Mon, 20 Jan 2025 09:02:19 +0000
Message-ID:
 <PAXPR04MB85109FA299BE065AD05A01EE88E72@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250120085430.99318-1-dheeraj.linuxdev@gmail.com>
In-Reply-To: <20250120085430.99318-1-dheeraj.linuxdev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA1PR04MB10227:EE_
x-ms-office365-filtering-correlation-id: 93e3056c-8c04-4db2-2e3a-08dd39312514
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nSIsDqD/ac9k34BO8H/WYLEymxQAfbl4krxPd+/09HwBAbvIgM+nFIhewoeT?=
 =?us-ascii?Q?0TP1o3a1ZFqN/pLMu+/0rQ8J3DRf20hE0PFH4jwx7PKRAabQzVwlQ2ZP39NR?=
 =?us-ascii?Q?OLfYQ1osJuQP7hoz4lR6b+fGPbOJG12NYdj4aC53PcukrZljtW/zVvE261Ld?=
 =?us-ascii?Q?baZIZ94MZeqdO435ZmsuyiM0ctS83hlHGeTGtsypDAaLpc3KZu+IP6EMjNIT?=
 =?us-ascii?Q?vdYC1c/JcKdRq8LQVZCNcIKIM85QcgNXZEwZqyO1M2mmmg7l6Eh0TPuPcPBe?=
 =?us-ascii?Q?hbcRtdwTOC0RK0Va6R4Tz4T4S0s2M8iDo1TNxwBLXVNGwEggSXZmjzsdi5yR?=
 =?us-ascii?Q?UBT/n6TdSInnrcwx3MEbAgYMs1sNPHaqX7WHx1DVBti+Y2EPg54WnqU+41wl?=
 =?us-ascii?Q?sabZw4OiQYdCcFPufJ7UjHN4Cs2YQI2BfHC8tca5TFtJ7/Mde0ZSdki+dPML?=
 =?us-ascii?Q?Pa1AR1s2RCnvYJtwYRAr8Vs6nqmpstTO2ns0Dcyg1e2SQW2cOybZYqNN//R2?=
 =?us-ascii?Q?Db/dDRuLWz8jO79F3pYVggAkVa9ztL/WVQmUF7q9A9FO9nRziB8b4GpdY9rF?=
 =?us-ascii?Q?wUBjD5NCICLd33aooix9XFO+k0VhyGYbprqZY0pL+/DBMn7T1WUjqe9Nk/ke?=
 =?us-ascii?Q?sqM3MqeOF4BcKvGO9gogxCad/mRtIFqhbzfw4FJxMTRHAFCeAgyK5A+w8n12?=
 =?us-ascii?Q?j0dToSRhWqZmcz8Q7xUnECDu9v+LOmej5wT5nrGlnHYAcWvqo05fwxy/SMyr?=
 =?us-ascii?Q?ICKTf6SSY1ddV6CVpBhiKkXsagSogAHflPYBtyLQ6mIleMSx364uhJ+lqfDg?=
 =?us-ascii?Q?KSyxgPDJvnXmO/aNIxdqbDZXEROFkczd6Pj+/zVg+3ObSLTDwrg27DIw5WTr?=
 =?us-ascii?Q?8S9qU+tCVuUe2jERI/zrwp5SRdi1WTJDRGqVzrNl4GBNlAAtJEtMwG4w1+Yo?=
 =?us-ascii?Q?VYLWmCCRhPnWXVdoLpd6b8bc2dm+3LSa2si+NMvQN99FZArNZKb2oQcmLEzh?=
 =?us-ascii?Q?tGNPTTbM4jk2b+kDu+lsJwkuAclFtUCckToGUnGWIuVZebfO1zeHgaOL+X5y?=
 =?us-ascii?Q?zlG121oQoSWlNJXwCknDQt45tZ8wfDe+JtjG1SxlBbwCp8vrU/ajMu1LLKT1?=
 =?us-ascii?Q?rvcE7P7T2CX/rXBFprPSRPMJGlcHqHAUtgS5u8FJ3ulE5JSwoIVYNLrDcgwK?=
 =?us-ascii?Q?+9hnTVtXzdF+1N9L05UarcceS8QaSJZjFeVD/dI0BEMctm/Vm0pNEkg2KWXf?=
 =?us-ascii?Q?pkgn1E+2XFf2IQOViadD7k/zS/q28o+pe8eN5q03oOW3Zun0STF9wct49U0k?=
 =?us-ascii?Q?Y7bEbsfEmmjmP0+8dcCkXIAikSvIb7WCfpQLmfkdwm0yr57WAdKge1eY2Xdo?=
 =?us-ascii?Q?fyNQuuF+G2i/pdGoAbknmStPH3VLaF1LGe/SDAn0kNvvW74/nZ4mNu9qyrTr?=
 =?us-ascii?Q?/jB09cp7tHnOZKFjo1WVWR7NGjdrvM5i?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Atlfv70rxSV483f5359iP98M603jaVmSUU3CBw9gFruQLdp7f9u9n2qSqQce?=
 =?us-ascii?Q?NL+wru2jVxEjAM9XQfhT7t93KKpZnLQ9n8cGz6MfD1WZm3qElCgzc2zYavo4?=
 =?us-ascii?Q?+eUfLnV1/jG418z1tTDVBNESCtzJf3AA45+tDv92wOQfGGgAhpJDsi6FjSRE?=
 =?us-ascii?Q?gQvi8Mo8S8YwxI39dtncymXRmLtCrF+DR9sJ3J3KvXbfd2D1+EImvIn0gd0t?=
 =?us-ascii?Q?AjU2I3a+PrfzCKe4GMV583ZmIWQai7zczi8JYs+rV7eABmd9KuHzcz/PxWal?=
 =?us-ascii?Q?ToIV4N/eLOMcjfyBQd6m4BIVxshITAzSOd/uyz+tM9Vd1NBS/hsLsG0n0GyV?=
 =?us-ascii?Q?IA3+lod4pyDnT9ZO0d0uddPnYNzs9+VMgbobOOheyFtWDVywECFVx7MT2NT0?=
 =?us-ascii?Q?ZZIVb07Q67pPgeD6ZNXA9JG5uV064xXoc7CoN8RuEA09u9glhlj+vYYKyrkZ?=
 =?us-ascii?Q?CjWaZGxyhqNbHPGoHLqqTb1tEXaqTNdllFsG20BwNQqs/oIqVkZAoCkiDJ0m?=
 =?us-ascii?Q?uaSwN+eOgvRfRvZZkgTKUH3sZ8tqNB6QQ2OYpUxh4/H34e12+B7gPlucz1UQ?=
 =?us-ascii?Q?pC2iT4tEZyAAoJWIVlP3AA+Boz+yeigkLu87QjTFo/hU3UFKTqNkF2dl4IGY?=
 =?us-ascii?Q?NkKYriTQ+mYNQNt38SnR9gDzl1YkAesrybFw6hvMavFgCCUfvcthFQaEA4jW?=
 =?us-ascii?Q?DI9txwG2ucW2/+4KpjuUOFKR8lHV77tmr3p71EbeOoJXl4hZusO9LME3lkQ/?=
 =?us-ascii?Q?FBau4H1RYMYrH8qThQw6+z/mDxBa872sPFSU1OeNJ6Bgc62xTXH7HgWfI0rF?=
 =?us-ascii?Q?1FLyvOAAL1RyIMz0Oqmt/qxe0ho9OGu+5kThx9vZ7PyZMUpU7JiKqmnyMEBL?=
 =?us-ascii?Q?utEcfjhiHNBFh3O+uajl/cIEpiuUI5ORkqYtU01ibRozniFlpCLxnEo3ExJg?=
 =?us-ascii?Q?qh/X447GR8luqK0npwpheCzYf2pjvy5e/N2gKPMSWsC7usRPjcx0XyDuB31Y?=
 =?us-ascii?Q?0PKT20UepJhYdX0shr7A+RWl/qy/zj6/AkVd2Klcok1fj5ICh3OoZsOSyCLi?=
 =?us-ascii?Q?kPdPng4VYnyt4ZSdJLAg3yDzV6dE6VSa1bkOP3pv+TNU7Gmvc+GlMoKBBM0O?=
 =?us-ascii?Q?rbfKo8IKmR1zGiAiqv3qgJTNDohAVxgJ3waATz/thQa2C1CQ6tz4HWcaoexP?=
 =?us-ascii?Q?Tii7BuYGii8WmW4voGvzh7MczHI4T3V+wch+Htc6mHIPrwdvCEOIEEf1f6/9?=
 =?us-ascii?Q?tmXg+lIaRW13Zf7OwzSFE8ysQ/gAaijXiEGZsfhE3fdACdwvFlwDS786TcCc?=
 =?us-ascii?Q?aImAnqEjCj5FcZz4zUJutBs1QTEYqJlvHKhpIOGKFyWfA6VAm/RShzBqSNQ7?=
 =?us-ascii?Q?X4Ab3y88HApecOOa5FXVTVqH6FS7RZxCvwyJb4We5+z6uLhuYWYytrpyV6sY?=
 =?us-ascii?Q?dE4Hn27rbDdN+aG6xIwDZRq9VgfVWAm+ypQggtvWZ7w+QsOQJNamz6DunMLI?=
 =?us-ascii?Q?/Ou51w4zwiwGQBS6+RbpHppmSzfKwxvoLJ67QeLEhBqqXtv9swVGrUg4221I?=
 =?us-ascii?Q?Tu9jQYrTD/It8agE0No=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e3056c-8c04-4db2-2e3a-08dd39312514
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 09:02:19.4629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fYAYkh9gDoj+iu3OylDswHMbG5MENuXikK3m/K5jy/kVKzNyAv/hhHwNtkAZgnGlGq0L+Z3MP8WOYd4vZB5TaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10227

> Implement cleanup of descriptors in the TSO error path of
> fec_enet_txq_submit_tso(). The cleanup
>=20
> - Unmaps DMA buffers for data descriptors skipping TSO header
> - Clears all buffer descriptors
> - Handles extended descriptors by clearing cbd_esc when enabled
>=20
> Fixes: 79f339125ea3 ("net: fec: Add software TSO support")
> Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
> ---
> Changelog:
> v4
> 	- Add a blank line before return
> v3
>         - Update DMA unmapping logic to skip all TSO headers
>         - Use proper endianness conversion for DMA unmapping
> v2
>         - Add DMA unmapping for data descriptors
>         - Handle extended descriptor (bufdesc_ex) cleanup
>         - Move variable declarations to function scope
> drivers/net/ethernet/freescale/fec_main.c | 31 ++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> index 68725506a095..f7c4ce8e9a26 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -840,6 +840,8 @@ static int fec_enet_txq_submit_tso(struct
> fec_enet_priv_tx_q *txq,
>  	struct fec_enet_private *fep =3D netdev_priv(ndev);
>  	int hdr_len, total_len, data_left;
>  	struct bufdesc *bdp =3D txq->bd.cur;
> +	struct bufdesc *tmp_bdp;
> +	struct bufdesc_ex *ebdp;
>  	struct tso_t tso;
>  	unsigned int index =3D 0;
>  	int ret;
> @@ -913,7 +915,34 @@ static int fec_enet_txq_submit_tso(struct
> fec_enet_priv_tx_q *txq,
>  	return 0;
>=20
>  err_release:
> -	/* TODO: Release all used data descriptors for TSO */
> +	/* Release all used data descriptors for TSO */
> +	tmp_bdp =3D txq->bd.cur;
> +
> +	while (tmp_bdp !=3D bdp) {
> +		/* Unmap data buffers */
> +		if (tmp_bdp->cbd_bufaddr &&
> +		    !IS_TSO_HEADER(txq, fec32_to_cpu(tmp_bdp->cbd_bufaddr)))
> +			dma_unmap_single(&fep->pdev->dev,
> +					 fec32_to_cpu(tmp_bdp->cbd_bufaddr),
> +					 fec16_to_cpu(tmp_bdp->cbd_datlen),
> +					 DMA_TO_DEVICE);
> +
> +		/* Clear standard buffer descriptor fields */
> +		tmp_bdp->cbd_sc =3D 0;
> +		tmp_bdp->cbd_datlen =3D 0;
> +		tmp_bdp->cbd_bufaddr =3D 0;
> +
> +		/* Handle extended descriptor if enabled */
> +		if (fep->bufdesc_ex) {
> +			ebdp =3D (struct bufdesc_ex *)tmp_bdp;
> +			ebdp->cbd_esc =3D 0;
> +		}
> +
> +		tmp_bdp =3D fec_enet_get_nextdesc(tmp_bdp, &txq->bd);
> +	}
> +
> +	dev_kfree_skb_any(skb);
> +
>  	return ret;
>  }
>=20
> --
> 2.34.1

Thanks for fixing this issue.

Reviewed-by: Wei Fang <wei.fang@nxp.com>


