Return-Path: <netdev+bounces-186401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3388CA9EEF7
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 13:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 493403A414D
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 11:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8000B256C64;
	Mon, 28 Apr 2025 11:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gEYKBEtZ"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010068.outbound.protection.outlook.com [52.101.69.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEC2EEC8;
	Mon, 28 Apr 2025 11:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745839494; cv=fail; b=aM6YgQXDzcpz+iOsmghMcqnVIqYR2GOVT4UbkMpmpYQoFTIRTRmwVCIbwyWnjNXIXh3kuKpmfuYlK2TFr2RCpq09LPUaK+2yANl5gTJ72w4FXIRh7aC0NBOPBg5jL8XULpka4HTvLAPdeYD7It1b5Mdd86zgm+jR3+/W3LxBAyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745839494; c=relaxed/simple;
	bh=QQMvkIJPryeEOhJln7Gx0Vul08r+Ln1bNTDoPtlzBFo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oRi5sw7VhnBvDxKbFnojnaZgzAQ0KscOU3qpkdWzhc+xJge9HochJt0UjDHMjdjUba9vIpKcaX2rek/tesIDVrpvk+qHTgeCmF8zmLxPH2ToYf0CNhRUZ05lJwmFX2yT0edrA52Uc2bn8uA64aQT8Sg17doJQKYc6DacWZZ6OHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gEYKBEtZ; arc=fail smtp.client-ip=52.101.69.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RW9mVjhEXzW5M6oXnlP/gX1slkgNqX+mg1mq8GzHsKGS2+rqqZFe0mVgtO7Hbnq4uayHsaYOBpofPHd2dtiEQ7lj8oh+4wfJVd+LLTStkfx8i0WCDbfpReyx7xErk7z0em2tXB5fpUpiJds34lS/80kicE3+dHlUQWXioBz1wDuiD4nf3lIkI4EKvlU4sVi/5CPVtV/oJmLyjckkisg+EMoT0sf1mkSEVAa+VS7bfG7+T65/VvdeXLo1Wjm6P7JgG7RXOwSWUCVIJe40qptsqnOYIeyNVQKfhpp7EEufWCAGOcyuloGJ7LJSeAuTvnn8aHfEUbB8pMFqbxnCEB0cUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gn8RSbBd9QJFkoc3K1xaNXWtv2HceDvJ/ONRWJfsFZQ=;
 b=RseCOIY8fkipa9HmZGLMDRq88uje7sAeu1Lo+M8z1MpXWv3WAjYRt7xIF7ZUQzOB80CwamxKFuHDO7zjttArdPSAkvPTLWPZpM1x9VMkmo9aJIqczeDQBYnsFvmRh5FcmrBvPEA3Poopa+qvFA5BXowbwWrgHFlpRVK2xNU76ctwzM5TbJOWDkPgDG33TJiS5qtuqbO5nnCMj6YvZIDT3AG6a9c50XVeLUVbax5as5RkP5YCi99HoT043Cal3OSs5v/Uz+aGIXp8CNIIq1BD7ipTh6a4Guv8pJYHRC48ZiMa0B1lskptxxmkMrUB7x23a8GejeX5UnQPs4DlcMYSVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gn8RSbBd9QJFkoc3K1xaNXWtv2HceDvJ/ONRWJfsFZQ=;
 b=gEYKBEtZjpeQi8MCHTYiTWJGO0Fqh68rbIWloQDsES3+nAWilj8SzPQhraWbRNyD2a3mIXkB15bn9UvrJ1n5p3pbzbzv4FtYltKi+n/KBPETKJSZG0hJwCfOMfZofKjsaqaE43bFjk2bjQC7xURY3hZB+pkFyOWV9khceGslRTUmWsOYeistP8p8KclyJkQ9ewBjpxyy5Cl0ARPfmJSuWNIGDywsJoSdUFFxdwhZrizP8OXitl5O+QdXNGr3IBJmPf68L5clR8I6SUi7ezSFrJBy6lptenCbGTrNj6b2XTru54MiI4MHFe3tBzsrxiMAgP14im9C/7mz3/rR8WlOIw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB9831.eurprd04.prod.outlook.com (2603:10a6:150:11c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 11:24:49 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.8678.025; Mon, 28 Apr 2025
 11:24:49 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "mattiasbarthel@gmail.com" <mattiasbarthel@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mattias
 Barthel <mattias.barthel@atlascopco.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net] fec: Workaround for ERR007885 on
 fec_enet_txq_submit_skb()
Thread-Topic: [PATCH net] fec: Workaround for ERR007885 on
 fec_enet_txq_submit_skb()
Thread-Index: AQHbuC4luE/3sWfqf0Gwu5ESQD0x0LO47vEA
Date: Mon, 28 Apr 2025 11:24:49 +0000
Message-ID:
 <PAXPR04MB8510E6D58457D057445BD66488812@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250428111018.3048176-1-mattiasbarthel@gmail.com>
In-Reply-To: <20250428111018.3048176-1-mattiasbarthel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GVXPR04MB9831:EE_
x-ms-office365-filtering-correlation-id: d3712a11-5dc9-436b-3971-08dd864749b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AgBqIg9njws4RwWKLgxBPDPpgYXMfFB73wgp2bJNGSJheQHtcj8PbQWOGYK8?=
 =?us-ascii?Q?cIPwMtn+YI1DPekvquApH/TWnWyOY2uFdc+tqrNH+RH1PAe5FQuDo4Kxbk6W?=
 =?us-ascii?Q?gx4bUAjeTlmT7s/4ZLyZQBW8AlWLu7rQkVSZcgWk5NnS8ybcgPznM/qOIUaN?=
 =?us-ascii?Q?Sned7I9UA+G3qTY2fnW55/Fpj/zLmVQK4oq/lcHzHccKtAxFZ4497dgxdaiN?=
 =?us-ascii?Q?mi3aa1z13oMlXX23v6t2zYzdOHsJd7zwugCH+7rZ3es9WxaP6TwVg1G9POW0?=
 =?us-ascii?Q?usPqUU+4p6CLi5iLkXv46ZKHwJDjdSf1VWlzUqIWgv4GMPkiDzg7AmSL9RFb?=
 =?us-ascii?Q?GNhqrqji8pqFH0rjP5mq5lv39fKILmktqPxnlZCwwOPM6yz468D0vDuGRRV0?=
 =?us-ascii?Q?/imEwE6ITTCS6qLskKk9SWb7UR+If71P4JHHek/08kpFLpEPUUQ4Ukxy+fXo?=
 =?us-ascii?Q?dt9rXtyeU2TPmxceDzq01dB5XpXqPugoorOTbvYEHpyeIqR1h3gSD9h31wOo?=
 =?us-ascii?Q?oVy+2In+GpalgonRrouERFevweNdL16WoHjd43O1qZ1s/+4Z4tFrSb/CF+VE?=
 =?us-ascii?Q?5OWa8JXd7DsX4isvvsFsLjHfQoaxQNqagSF18v7wtmp9DW17EKUjUwBPdQYm?=
 =?us-ascii?Q?7gyGhEcn+7xIPA7Eeg0iGEdft5GijzEe7EEz8m28E4eiJuzlCSaYdOZW9Fvg?=
 =?us-ascii?Q?gKe8LNgYCQnLH1WGxRrLGwl0/S61TFQbDEP1yxZNKw4a+XBrf1sIj3Y2LQdM?=
 =?us-ascii?Q?+GKPb9zxDVZc5DTbJz8eID7ghZ+bioreEY0p1j0TWvsf5mvrZjTXRpGOSAy1?=
 =?us-ascii?Q?8bQ9PdLumljl4v/zIUqZVgOpFh7I6ZqT5aJ7TCG8eNTi40nw38ztAv3Ekrih?=
 =?us-ascii?Q?W61dcWE3W4dtvqvmB/+zqIZbMN3W1TKJUkG1YGwAPTiRPVp+FrWd9gW8fjCh?=
 =?us-ascii?Q?eBZfmqtMLcXM7qRjx08StoJcm8kH2Nwnxp0iH+eoTH85Q/Vi1d7AffqjN/QT?=
 =?us-ascii?Q?RXgwQ0zGy/cO5KX5iUWeyNHbYwOhC3xUQQqcdunznLYQ1DteSPXuYl0J79hB?=
 =?us-ascii?Q?QicqtKorPQokA8W17Ld7Mv2CfwEmbWEKOcbeMNT2bVjI5KcfBA1fxeI+chX+?=
 =?us-ascii?Q?Qdvem6hPP8NxdH5BfCvnNcvZ3G/CfPdXk1g1D9oObsGmOzFuhP4aoEnAM2I0?=
 =?us-ascii?Q?ae2t9w4eNriAz7MQ9MVAHvVEjsxJGZIflJtMSxDZ888jMwM5TFRatwrz8cyu?=
 =?us-ascii?Q?UsRQ4purkRDgiNk5YrKz5rmpTeFTq4axL+CdZhsfh0tQY4zi8YfO7NAbiMni?=
 =?us-ascii?Q?vEBXLqUnCHhi2NL4R5lslhh/ekMbrFQeOYIguXWbFlh7jOO34uLFbf4Gmvs7?=
 =?us-ascii?Q?Zh8RkN2KZUcHCabJiG46PI24cB5q80u57AjkH1PcPsZft+Tjr7ADv2/Ya389?=
 =?us-ascii?Q?5/GeTre7gGm2hYStjILbMwJFNBDd1EHcBHkvXjSKdzTQnzDbzxkPUw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Y6oBx/aICyNjLAovZReusdG+Im0E0Fep/pkjdh7RYuvpqsERLvi++HCDG+lR?=
 =?us-ascii?Q?xGjVyL6jBgR+29YmS1ZLecPiltoK3d5O1XTz6xwvbQ4p+Rza/WpZDNvqH2fr?=
 =?us-ascii?Q?xGvokk1tzZJ+88hnZLGG4Ke3/3fY7S65QfwijGPNrI2hopcmfBGLGWM4Kepl?=
 =?us-ascii?Q?zqJDRNNg0s0WVvVN1NxAiv/RqWwxTkHc0OJv3v9Wjhwad73VBH8CRe4dJBTl?=
 =?us-ascii?Q?gOe5hMTinViGD5gmOfbv13BsQDgOtAS1IUeeMtzApQN+gAssthIGJJ94YiEE?=
 =?us-ascii?Q?BJ0EGr/pWuJ0uObUaFvt2jQimV2vo+HqAzkmaQnkpGUdOltb1VeJvfT4JJ5S?=
 =?us-ascii?Q?O3bXQ5s4Ate7C3hv8vEkgJWtTyMGC42l0H8RIDq5qjhDbBVjvhvps1joG5fy?=
 =?us-ascii?Q?63phjYrbVjAzm+IVNy8e/eGKY/JSYaQy8wV6aDv/vvfqKorBonfqGikPRCZz?=
 =?us-ascii?Q?6k2VuK6H/JKZ281NXusQZ0cjfD5cEagu1e3HGHV2MR4Dg8xuPjVSwMuKgS33?=
 =?us-ascii?Q?0Cw8Tf8kmFPGCSISrxk/71YDkna/CqqNLm7SlCsoLS/QEqUW/+wcGK2xXK2k?=
 =?us-ascii?Q?QbIn4lXc0P2lYEVDT024z24MrkUdjn3z+d0L6ZcnuqjzUohPGE8ffNp69HBO?=
 =?us-ascii?Q?TYkl/iqJt2R0cNXx/UnPIXDqHwFIb/UpPk3+FAPA5R4vPPxRUqfme7egAp8Z?=
 =?us-ascii?Q?PWcgso2FXvT9toXXV20HaXHha/7b3umQ0WGpi+n6LW9zNsQ/tqEdOHlDP1u5?=
 =?us-ascii?Q?3cQKUDW9pBXxz9GwAPiypqU9ZFXu9xPnu7yc9qAPcpk2iFBRQWq/8gQTNefl?=
 =?us-ascii?Q?AbozH9BaXfiE+JcMaevLeTZc2+D4JN5ayYAE8Nvk7CwEKtmh8wLCJTqf0uFl?=
 =?us-ascii?Q?Kc/runKlslvoHYVVRE88ROUO88ztREuscGo3PlQXYgakCJ1RqnNfi8UACp8D?=
 =?us-ascii?Q?lknH5/xKuwaA1UCVF8P3U6riqylgXmgmyOl+67AKEqU+9A32MBHKKV9hlHJo?=
 =?us-ascii?Q?fheJgRgd0tt8fhqdNyBCbWj+hhYr/kAbon+jgBkQ2PvBAM1pgIb4irpwtr5A?=
 =?us-ascii?Q?Pis7+9+zP2ocZH4a05tyubuHCbeCj631+lR5A9+1UoKkSpxtc5uIPLdvmpCu?=
 =?us-ascii?Q?G8EHYs1SZJZGcFJLx8MGMCDe8831nbIY19kQ10VJzNYpLa32/Q9dwxiOTiXN?=
 =?us-ascii?Q?J4v9LWCcODEl9ObCYX1+cnAB5DMITVlymenCSPKnnm0PbVLE3OsQ8n27vhOm?=
 =?us-ascii?Q?FXSPeYPZqrotHcY5zTfYROqFDcswganUE6bZegFTEtqFpLTV2/gLKazgrbYV?=
 =?us-ascii?Q?YLfHmLdMdwKLbO5jON/WpoTn92YnGuVP4HuM71nJJXYZjRdS+wTbFIA/L4qB?=
 =?us-ascii?Q?SHkzLy98oxJGU0wRDRmfqxj+5v+HvvZ5qDEWDBj+1UBZF66pQhDUiMHL2m+X?=
 =?us-ascii?Q?wI44oHMWDPF+CGKPisng3pdmh11uXkg9dxi1ojUP2X6v5xE1x07JyisqvPLJ?=
 =?us-ascii?Q?tuLK67XuCEz+sMuioqgDeED51BLuPF4ftQR2hdelkzbInqT8xThfGlYEFQTn?=
 =?us-ascii?Q?ENih3IjpOYJNyaYOATc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d3712a11-5dc9-436b-3971-08dd864749b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 11:24:49.3195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1HbwMXaLtQds/bUUcydfjLbx/3KdlKf2ZXIjM1LfxSCyk2MURQolUfpOt6Z6wPDCOkdqIhrr0ouupD/MPUIZRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9831

> From: Mattias Barthel <mattias.barthel@atlascopco.com>
>=20
> Activate workaround also in fec_enet_txq_submit_skb() for when TSO is not
> enbabled.

Each line of the commit message should not exceed 75 characters

>=20
> Errata: ERR007885
> Symptoms: NETDEV WATCHDOG: eth0 (fec): transmit queue 0 timed out
>=20
> reference commit 37d6017b84f7 ("net: fec: Workaround for imx6sx enet tx h=
ang
> when enable three queues"),
>=20

Please add a Fixes tag before Signed-off-by tag, I think the Fixes tag
should be:

Fixes: 53bb20d1faba ("net: fec: add variable reg_desc_active to speed thing=
s up ")

> Signed-off-by: Mattias Barthel <mattias.barthel@atlascopco.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> index a86cfebedaa8..17e9bddb9ddd 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -714,7 +714,12 @@ static int fec_enet_txq_submit_skb(struct
> fec_enet_priv_tx_q *txq,
>         txq->bd.cur =3D bdp;
>=20
>         /* Trigger transmission start */
> -       writel(0, txq->bd.reg_desc_active);
> +       if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
> +           !readl(txq->bd.reg_desc_active) ||
> +           !readl(txq->bd.reg_desc_active) ||
> +           !readl(txq->bd.reg_desc_active) ||
> +           !readl(txq->bd.reg_desc_active))
> +               writel(0, txq->bd.reg_desc_active);
>=20
>         return 0;
>  }
> --
> 2.43.0


