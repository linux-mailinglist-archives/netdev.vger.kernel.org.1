Return-Path: <netdev+bounces-143666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8D99C3902
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 08:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12643280EFA
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 07:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0A515CD55;
	Mon, 11 Nov 2024 07:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HuvvU+ir"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661D115B14B;
	Mon, 11 Nov 2024 07:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731309992; cv=fail; b=HRR+qsxN3ma1XfgOH7K0DMdvgnsqSt4aReXjbbYKwbH1Tv1BDr5lSaMn0fhLZ61YzOCk2nDAe0SyC4wRbTi6VQP/zlCXRVPNj0LEnfbJuzJxwOw/2sEf31t0NF3OC2uvEDhpGs1it7E13SPo1FDjJDVN5YVkfv2HK0bIfX/55V4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731309992; c=relaxed/simple;
	bh=QEN1CMj1JEmbIjOCVASTSUqjdfhtbtacaeoWVuMdiSw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EEVbh9Igz0tL+AhTE5BCj/ycfmt+xrwnENcNV22FrvFa0FE+shZ01xI9+zdqipHfPbXENnomfoGU67gn8Oq3ogb+/yiHytakdcQo3lKIQdmrMszxckfzuAhznPpmwLc0OXShqVKnFCPi0y3+FqGfppcIeM20dqYJnlsxjdK7TXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HuvvU+ir; arc=fail smtp.client-ip=40.107.22.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjF+R8N0TKsLOQVNVDKVWQxxuq9BrjVg0YnuccLur/k7uZLuL2ScVkdnFK6w3n6N+yyqNngjrYfa0R1p0gRcQ8XLjObocJqZPpEd5ocssEK5j18BPQqI3xo7fbuYuZofx0ycI49lKo9O9wiR2+1YfHaLKXC3zB4oakXHdaC9z1FN6PLBqAqtmCwnjisGSddo1g+NXLHWKBc0ruvus/P4oa9xr+k3cYsoA6dMHK2xB/CQskOFlz8YnCwpPdIk+K5a5wMYVB7wuhlrzHzRSRo89t0HvdGb0CCOJEZ1kqofebKCpevzCYkHLSbHOpsBXpXJBkFquNz/evYAy3ayFPVJ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N09GbFE+2/MU9oGFj5MwwZKY1Vh+PvM2fp2iovpunk4=;
 b=YhpYZNVklpR8GZi+tYiiIUMmfPLpbyXdIZ+4vc6EFIQnqTc8xkXA0f8DCG2g1g5aunlzrPCdsbT/FpEhTKck1XjvrlvrsKJehPUcDxUxSPyz/1ewUWgGv7VOTnQ86wjKj8QOmeAIPBJxi7YNgkNEaPDVzlII8J7mcvawTqBAGuPyG+MFHtxPoxL+RUuVjYJqTBjRwgmNgWLJCCx1IRLuL6yIhIL5pLTZPmM7lJ+dhZZHMHiMjI2WbxST8A3MKNGcWsldJipQRZaOVVzncouvneuCXXdxunLbebvbhXrxl1VFmTtqQU9Rbgv8AcmCGu7NgJ8J7l4lBqWddW9fCI/xbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N09GbFE+2/MU9oGFj5MwwZKY1Vh+PvM2fp2iovpunk4=;
 b=HuvvU+irxOWX8gG3he7OoybJVuY7sy3+E6jRDRdre57VNPt2tT/nteMz/QKusLS7rH+kDaRiAKlPI0ywd03fLCY0nxKpBJibZatcmIcF8pLxEcCTXHHdrWjf4l2bPfLinEcQ5FpG0L2agoz33pIKx0usQK5Wm9+gbaX4Oe2kZY+JiuystrNHj4r2ej1MdIJFthxVbXzkNIDQ/rPJcnwEgy77q8KyjaqQu71CJM9hHM2NxYeJr7j7X7AT0Q2KPI+W9YmtrCT24a837yj6tqvzQn2FO6/Phf6/5EfSJGX88Kzvsx1qCMnu1mei2bpkcHB9kRJTJb3YrReXhOa2Q4po3w==
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com (2603:10a6:20b:42c::17)
 by GVXPR04MB10022.eurprd04.prod.outlook.com (2603:10a6:150:11a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 07:26:26 +0000
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684]) by AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684%7]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 07:26:26 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, Frank Li
	<frank.li@nxp.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v2 net-next 2/5] net: enetc: add Tx checksum offload for
 i.MX95 ENETC
Thread-Topic: [PATCH v2 net-next 2/5] net: enetc: add Tx checksum offload for
 i.MX95 ENETC
Thread-Index: AQHbM96NucJF1ICp4UyDDMX2CMxvdrKxpl8g
Date: Mon, 11 Nov 2024 07:26:26 +0000
Message-ID:
 <AS8PR04MB8849F3B0EA663C281EA4EEE696582@AS8PR04MB8849.eurprd04.prod.outlook.com>
References: <20241111015216.1804534-1-wei.fang@nxp.com>
 <20241111015216.1804534-3-wei.fang@nxp.com>
In-Reply-To: <20241111015216.1804534-3-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8849:EE_|GVXPR04MB10022:EE_
x-ms-office365-filtering-correlation-id: 5e3e2a64-2b82-4390-eaac-08dd0222273c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mco4j4yIJkdys7lViI0uQMHt+uRP1g5dAT4pT7hjEJuL3iSoMa456RW0gCXa?=
 =?us-ascii?Q?i/E2LYa8si3+ecxAqZpTZF4tkMNZ0+qrmvgrpEWRG+XGBNnPIpNncTeMAaBG?=
 =?us-ascii?Q?dKG5vuiJUy3SjRbxNmqM3omcW6ihBLzCMsW/GuT8Cba1Z5XAt7r+43/XPZ5T?=
 =?us-ascii?Q?wk2JnhmvhYAkyfu7TSs5LgmrQ/pMwzNabA6cAavjFTt/rBgFguDqoGU0UV6V?=
 =?us-ascii?Q?AcZPi7inMx3VqvCUb5bZGXUHKy4M0P2KPaqROzVFcCTL8QKUbeqLJ+F5fyBS?=
 =?us-ascii?Q?M6eI6+8/a/WA26VKWna1RzKFq2/mNtbLZNCEEAhJiR5v/ZRPeh3DZr5xVtu7?=
 =?us-ascii?Q?TCrAko06tfilADwN5ff/xKipC1CPy2+i3sOq1tbGgjkeamVP1m8hk/vA/+Ag?=
 =?us-ascii?Q?WeL5sjbWc8QczQKL1Dai2jRWy56iNeNg1ipT9Uz0k3RFDvZ6z5PVBeAEyThM?=
 =?us-ascii?Q?yV4uhVADrPYFz7vR7snWfR9EHW9dZbizzJvnpZP7COFGKz68nFgLCg48OrnN?=
 =?us-ascii?Q?gCu/1v4uE7CD/chimYHYbfXIERaW0GJCccCW9g4zlj4/zMGU3qryz3iKzyBQ?=
 =?us-ascii?Q?jR9qhG92ssktXw6SyXJ8grlVchzNS2lafH1kV869UC+K5+R4WSXaKQCVwZM3?=
 =?us-ascii?Q?ljRTDMVmUr8Szz5QEy3fFGnCoDxPB5uxiU4VnTGwgtRjVKYa0dXMLiNiXz4h?=
 =?us-ascii?Q?dDy+9I8oZmzwH/V4CVzjuV6iMpLCAMBXxj0XF/vwnsLmtfcz2IWoTfQnsJn1?=
 =?us-ascii?Q?uposW6WcMFXoteu2fIfhFhOBunmrCLW+fNZHH26uXl7lFigZ+Rs9k4X6njtt?=
 =?us-ascii?Q?AncMZ69vlmOZe1LxAyMxFOFc1lZNwMqQxLeoQVeGnsaqNSKrk51XuVFEQoPR?=
 =?us-ascii?Q?DIwhOJTiCom0v2BoigP/2S1kbANk5kaJF98R/MXTB1jmldNnD57BYbmdNUae?=
 =?us-ascii?Q?s2EtXalATBASfUvdVnuNVRJX+4VPrgUyo2STGZnVE4k6PM4Rw5BGJnHe4DVB?=
 =?us-ascii?Q?L8iyC8X4rD7kQmackz/C9VBnkMcNMZY8HO03a/Ym2yyFGZZeu0sAtScwFCZJ?=
 =?us-ascii?Q?Y9CGiMKa+JXmecTaNkkoXzo3dUHx58HM6buhOahbgw7UHaAZ3i9mYnCMH8MS?=
 =?us-ascii?Q?ocGhpexywW4AKMVO9HC75Jvv5X9WSJ1L5OdJOGgSyLJlXjrugNJh5uhvi04h?=
 =?us-ascii?Q?OvJk8VWNo+6t0NjUYUdI1og4EEpxJ/Y721//yiX/Ph08RbuZfEirTArskoog?=
 =?us-ascii?Q?nYmB32h85AdB+im3YMp5byUE6htKmpLQktQJIxA5TqL/ComCIxhrlTj4N+Al?=
 =?us-ascii?Q?v4Rm78QLxolC/G6rphDpC/i2VY3xSfRYRPe3wiLazD9IgLRwk9Ym9Gf2QiFG?=
 =?us-ascii?Q?X6pfneo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8849.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pyqDuHWwL0U7wCX8nFxca+UJiOYK+sbv5WYmzAjKvKPNZrOAByhzjv7xT/Ct?=
 =?us-ascii?Q?gxbMPH3V09bgeR3hCDMGf4HzUK1PxPPnrgwtiaVkOvtIcKL5sKSTi9Bo2i1K?=
 =?us-ascii?Q?+uuIcqLMFM3gsX35Bk4GjBo7Eh07stI5k3vobCtidR+0THKuAf1z1X+S94a4?=
 =?us-ascii?Q?ho2TIYxnOFMMwXcvU77H1NhhS4VxjTGr+BXtdbDGZwXjsezY62OBEZFcRCzU?=
 =?us-ascii?Q?UXPVlpfh9wdWa4icWEbhBUccyjzuESvrSdgdyXPH7sdnPQ5S8B2O0YgghQGS?=
 =?us-ascii?Q?GnK5iuGJxVotZ++OELCeq2PBijp+zC5Zgki6J1e/pCEGeMxXA9djLMzo03M/?=
 =?us-ascii?Q?rPhRw5g+mLMA57AwFAWJGzUD0Q801jhTot90kwLPvn5tQyMmibpjOWpSBns4?=
 =?us-ascii?Q?26txPk8QVgKjQKS+SIQuVqYMjPEnDvCTr8JOBAiQNQyHW4m7c0th83pRbbp8?=
 =?us-ascii?Q?T4J3p4/kKmudLSNpaWbEHj8pjQFwXeMDnksFuDerpD/AddCEKLrRG4A231+A?=
 =?us-ascii?Q?nqPdJqrs7nh8cZohz+FSwfcUzmMfsHzQJhFILzulZwmynusPk2lM8UOsydNV?=
 =?us-ascii?Q?fzpZ4npllwvhXWyMr+TN3IQ4T0grcVObL7TOCZlQifHbnAtnhPT5SAyYR09P?=
 =?us-ascii?Q?DydE4j2z31HOAmLYnI1D4bjjd7TZDJv5CxpbXasaA+ByNoaDjrfgtEQyCdq4?=
 =?us-ascii?Q?O2Fe3LadXQOMkXisBLESxuaC9CBmC824EfS7GcVirDalQBy2/m7A3KHd8Pfb?=
 =?us-ascii?Q?NOTOOMxmiCTCSSKDTOXfe4kaNJXjUkVWjesfnvDO/lcuwoST14DrNNb5w09g?=
 =?us-ascii?Q?0BJmqebWuduy5sc4T9aLuObElU1C3tOhFCbbWm6NjlO+ZWE8076ijK9+MVs5?=
 =?us-ascii?Q?R1veYdc8cwtWGKoizQLTnSjAz1eK3p7pMJFLFGGZN/pNQ82VE3e3HlPSwF26?=
 =?us-ascii?Q?47M4EuNTCms9XN0U6ytW0aLuCoCzdCjjdeE8q5pc9BLVtLrwX3uGEEeBTLCG?=
 =?us-ascii?Q?jdHIRYbkY1ivYCzgFTTGDHTaS8SleUey0yOgm376VGAhESK9tZL4eWVYTnTc?=
 =?us-ascii?Q?4RSNROdJS7ZCD406E7RVXuuFPVzrCtFwiqi+v+mchvVXlmkJ7CJNigGbFohg?=
 =?us-ascii?Q?wCM9/XD0lT/aFjfIZMzlTa1Oj2mJpZ56fK4VqcvkQDIm4Fp6VMk+5yapq7pt?=
 =?us-ascii?Q?CsP2Hn6KejCyk9cc3wDvnm88kCYWdT8LzxoJa/mn8vIJn2K7SnbpVgWQABUk?=
 =?us-ascii?Q?TlkcbM1V8UhfjFkZ1QmPHoOx6V404L1EioTmHVx38Qi507HWx3rYvShbL2CH?=
 =?us-ascii?Q?doyKwyO+Pksa7upbqaUzEK8btOGrTyyelz7jdglCh79yZQvg3h1BbaGr4XYn?=
 =?us-ascii?Q?Ib/1vELw3gX7IjZd21ypZEBiC03DYcsSQrVj+FG2CgigzEHpijnO00hDtwaT?=
 =?us-ascii?Q?WCzpDHQmD+GDKH+8shmwpnElI52NUtET6IUY8NuwPK1YMi2IWDmWZZ1jWoJO?=
 =?us-ascii?Q?EXoLu+nZbiADueiTY5gQmGA3WhvE2L6++WLYGqajJF9fGcY7uSukvJ6B94L6?=
 =?us-ascii?Q?oeebeQApcAjIitN3QiznOtB5MUmu9EWylXK6Y197?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8849.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3e2a64-2b82-4390-eaac-08dd0222273c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 07:26:26.6890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Pi5n01TzSaP59ujiQoRZjBfxJv+cvdfx9gKL1Qflpj/wl50ExuZk1ddH05vOcfEK1LowcblwFco4MCwSgvVnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10022

Hi Wei,

> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Monday, November 11, 2024 3:52 AM
[...]
> Subject: [PATCH v2 net-next 2/5] net: enetc: add Tx checksum offload for
> i.MX95 ENETC
>=20
> In addition to supporting Rx checksum offload, i.MX95 ENETC also supports
> Tx checksum offload. The transmit checksum offload is implemented through
> the Tx BD. To support Tx checksum offload, software needs to fill some
> auxiliary information in Tx BD, such as IP version, IP header offset and
> size, whether L4 is UDP or TCP, etc.
>=20
> Same as Rx checksum offload, Tx checksum offload capability isn't defined
> in register, so tx_csum bit is added to struct enetc_drvdata to indicate
> whether the device supports Tx checksum offload.
>=20
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> v2: refine enetc_tx_csum_offload_check().
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c  | 53 ++++++++++++++++---
>  drivers/net/ethernet/freescale/enetc/enetc.h  |  2 +
>  .../net/ethernet/freescale/enetc/enetc_hw.h   | 14 +++--
>  .../freescale/enetc/enetc_pf_common.c         |  3 ++
>  4 files changed, 62 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 3137b6ee62d3..502194317a96 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -143,6 +143,27 @@ static int enetc_ptp_parse(struct sk_buff *skb, u8
> *udp,
>  	return 0;
>  }
>=20
> +static bool enetc_tx_csum_offload_check(struct sk_buff *skb)
> +{
> +	if (ip_hdr(skb)->version =3D=3D 4)

I would avoid using ip_hdr(), or any form of touching packed data and try
extract this kind of info directly from the skb metadata instead, see also =
comment below.

i.e., why not:
if (skb->protocol =3D=3D htons(ETH_P_IPV6)) ..  etc. ?
or
switch (skb->csum_offset) {
case offsetof(struct tcphdr, check):
[...]
case offsetof(struct udphdr, check):
[...]

> +		return ip_hdr(skb)->protocol =3D=3D IPPROTO_TCP ||
> +		       ip_hdr(skb)->protocol =3D=3D IPPROTO_UDP;
> +
> +	if (ip_hdr(skb)->version =3D=3D 6)
> +		return ipv6_hdr(skb)->nexthdr =3D=3D NEXTHDR_TCP ||
> +		       ipv6_hdr(skb)->nexthdr =3D=3D NEXTHDR_UDP;
> +
> +	return false;
> +}
> +
> +static bool enetc_skb_is_tcp(struct sk_buff *skb)
> +{

There is a more efficient way of checking if L4 is TCP, without touching
packet data, i.e. through the 'csum_offset' skb field:
return skb->csum_offset =3D=3D offsetof(struct tcphdr, check);

Pls. have a look at these optimizations, I would expect visible improvement=
s
in throughput. Thanks.

> +	if (ip_hdr(skb)->version =3D=3D 4)
> +		return ip_hdr(skb)->protocol =3D=3D IPPROTO_TCP;
> +	else
> +		return ipv6_hdr(skb)->nexthdr =3D=3D NEXTHDR_TCP;
> +}
> +

