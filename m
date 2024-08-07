Return-Path: <netdev+bounces-116500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D310694A943
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 16:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B78B287BC5
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 14:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3812A1BF;
	Wed,  7 Aug 2024 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iPOyI/65"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD013B674;
	Wed,  7 Aug 2024 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039352; cv=fail; b=V9Xd6etYeBy1TQ62rxcIISmlCb6X82hhzX7uML383lLxbCsky1ERng53EdLOhRsXCBfO5/22PdxmATK7UtZie5sJpn+fU+Eofm6GHy4HBSEHRttObL9cnJkHAKK1DEeHya6CBgJDXPYlOxNxA7g+nG8XpStEMVHa+pjtGT1Rosk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039352; c=relaxed/simple;
	bh=LA70jfegh+oWJ2TlnpHTHTtoDee2SYqBOnqMmkAmVa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fvcXMq4iqWbzokVYOtO/gY2aJkoWOeAu/rSR9BLw/+RPef0JLWUg1VGhEvPONyaKeTq3ftDlakrK+m/lBV+G8S9FbytzTXUvRy6QFwMz0hLJ9q+8Ty+frw+JjHcEAtnHG0oqc7qscrHGIKnW3+j6oJd9Ti7bwL/RiQyBYrPPO/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iPOyI/65 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.21.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ef7cK5yAYAEBTB8urkAGof9NcNea+oHIqmqDvqk2LNLb3wdmf1GcGzewwdyFTc4rhGfmDtZgY36gwiTXwHPtmDcJ66CbMwRPeSkiF0W2fI/CeDzmaetS772Te7bd1uhfmqAas31R9c2FFXAjyto355Jv7Ohaz/LnLbFxEsryEQmafA7kyjuu4Mtdk8/gRON1rMnAhiRDQV5j4w9vKLjipLdbHBCOdQ/AMt73MEQ5OyrPeZvsttTNEtWC4puuvFokAyJdSyle/2GR9JYDDkKqugquVKryiSOJUlIswkD7OKVEUyf4RpDcsnej+nwyByDjc1NZet14A69H9lGkOdtMiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1R5P6e2nWw49v4XVBK223Syfo4d5JFScR+RhXOzwRI=;
 b=R0lPOPfvr/q95ypzZJpGCaWx6yCzPkFeRX1OhgeEn8K4GdEBtL+VH6n9oDytOPHDx5IEXLxyJwZmKFpLh1pyvhPabIfQ08BlLaier5IS7duIeWcc2PgNLWof4iaXh0+Fcy2M09uQ1yI2NENpXM+KA6gETpeRSRt6Mmo4WmQEF4eYFxhlePDJoMPJwn6DKl/kHvjo4eCSuyyIHfJYzriXkCQcsvvXGQ+LzN2tHouSw3tRN7SigaxVTho1WcRvOcwtSTm4Q9Tk7/iXfKsRbf3520DOn/0wDfjPhaRGhhX4mnu9d8OjMoETt/Aakl8Y3EDZUDW28ymo5VNpkiKVqBfaoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1R5P6e2nWw49v4XVBK223Syfo4d5JFScR+RhXOzwRI=;
 b=iPOyI/655CE4jylZksh/IRxqUg9s7J7eP/ntNMEz9VVoxgvJnoy/UlWtELQ/cy6+9xzd20mKWkim8fqhsZm9s/dfnlJP8QDECB8/I9H+1AFLTwakGuSbUgVao8QpWMM5Klv5io/8OWU2AIAuzb0Q1R2gtXcUb0PQSD+kqfMsVzLj7rjbHkO2vrlccKbeRzf2mcM25vK9SOeGbWkiDDZo2a/sVb1YirbdeFt5GDSXtQel4z1OOJh9GeCsH0eS4JR5qXhgOAq/J61itD4xfCvxStSNcR40RLb3afzCqb5lU68uOimYUWg76nUEYUOCIZkQqkr9gRhDfyoki0aSx+fwuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7328.eurprd04.prod.outlook.com (2603:10a6:800:1a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 14:02:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 14:02:27 +0000
Date: Wed, 7 Aug 2024 10:02:17 -0400
From: Frank Li <Frank.li@nxp.com>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH resubmit net 2/2] net: fec: Remove duplicated code
Message-ID: <ZrN+affnZLC2CmEl@lizhi-Precision-Tower-5810>
References: <20240807082918.2558282-1-csokas.bence@prolan.hu>
 <20240807082918.2558282-2-csokas.bence@prolan.hu>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240807082918.2558282-2-csokas.bence@prolan.hu>
X-ClientProxiedBy: BYAPR06CA0070.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::47) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: 29a0cc19-2656-4d0b-e1d1-08dcb6e991c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?VRceCsKbmx7OftaJt9AHTB5fJv4QMs++L8xEx0yK5Cc5PLleF1ZLhsC6wi?=
 =?iso-8859-1?Q?WMCOsP2pwksjsEdNo8e2kxgB1CdyR11MWJzxk36aa+Xkd9DOa0foXDcGkH?=
 =?iso-8859-1?Q?qaEwKFLTV9CYVDaijf0HdVzql+VCRJdEVpKOwNR5XTUatx4wZNNyprJxR0?=
 =?iso-8859-1?Q?Gw8QMe9h97dz/sk+ZAMF9q5XXjdkRejCO1ye3AoiiqDbQG0C9OsItuQOuj?=
 =?iso-8859-1?Q?ipU/PRtHWsnXRbPctqdzOUVGicA6iYv2w7/4y6zhTHfKd+eHQ2NmRFL/7A?=
 =?iso-8859-1?Q?BoNORKet0vPJ+An6nrmW7dpT1vFQ1UNx0cXX7dVHt10ZuZvegLt8BgnwC1?=
 =?iso-8859-1?Q?kYMMoXyh/r4k+iI2D7uBOdBaqxVpAwP2X+kLB6XssrvUcqwUrevQObg1fs?=
 =?iso-8859-1?Q?zPmACGAYe/my9ChN3QkDqDHwdp3JZZ8DjBAkQ+UyPiVN5V34cah9TvvmYA?=
 =?iso-8859-1?Q?O6OGD27v56HMaOpex684B0ryDrQxG0G2VzloW2UEItgIkAVa74mFgE1h1W?=
 =?iso-8859-1?Q?bsYjV5ZcRTaNhf6EWRDo80Izy69a5W0zSjk0WTTsW7nyTppPtQtsaqdEV1?=
 =?iso-8859-1?Q?I5/kAAujssUIwmlkfYIY3iKluhQVCF6RxojxFdH1onbULjZM3FTCL3JKCW?=
 =?iso-8859-1?Q?nXcVJGUi2Ik80U+aC/BZlOgiJt2gbXdwhGAwVstcs9lWxvPFgsIFKpjLci?=
 =?iso-8859-1?Q?As6MIGKZGDfYfRZkrqu/DFXrSM8AHbYj0p99e5FfGmHyLgNjFUNxcOoO0w?=
 =?iso-8859-1?Q?ieqvqvPPLT1ithsTAhsZNLbYMuK8EKAgCDhpyWQr1uosguoXxVCvrqgIqm?=
 =?iso-8859-1?Q?4idjXbECVAhAvfVm27uJ7EvdybjU2g5yKQ6uOghhromp8BlOqC0XnmNFRN?=
 =?iso-8859-1?Q?R63BLbSeGez9Jppw2RSqb5AfMtDYUnDqVE94kLD2Q5QI4YY+i/AB5KDzuq?=
 =?iso-8859-1?Q?eSbeuwMc8vo48It91WLfyDY07b6yiju8ivo7gZPP3gCIpqGpWPCKGDWwI1?=
 =?iso-8859-1?Q?Vb/YZNJS9X1LJr277xi0OYKaqbgpB7B1MtcYie7Sa5oujtJ0hzAps7ymzA?=
 =?iso-8859-1?Q?bwmnCHniGV4Kq+IZ5oN9hiouNWLW/gTOMz8uRSdNFLxVps21WpvHXSj1uJ?=
 =?iso-8859-1?Q?MxFWvGUUAfczu31uMpgcp2DVSw7o3zxXF4pVPFlQwP3cUP0rwPssZ5MaXp?=
 =?iso-8859-1?Q?J1pkrVn0a9m03iyPff5QOvtz1Y1LSzTaJZeWwFEG79nA6N+R1VDab3BcdE?=
 =?iso-8859-1?Q?Z8auB+GbvLPzD6i6ZZz8bjnRSh8r1NDyje49PHF9G34Nh2sJthP3ezXLiV?=
 =?iso-8859-1?Q?6PGLQh2QT2zTgbyL5xcCvoYshwkYwEikDKZmp6asuM7aD8cY+Bmg4b5luL?=
 =?iso-8859-1?Q?7SQxyOXjAqMjhveCZAO+a5f0Bze8YkKlYbueZggv9vigpOihLCBSKEvDYk?=
 =?iso-8859-1?Q?M66NPehDNXZPj1mh0pqKLCCMuwj0A2xAiF76JQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?4JgxDnquCOMg0AEV6wRR9ZqFqUVdfqTGeIlhex8GrpRn2xrrrYFT1bqAX2?=
 =?iso-8859-1?Q?TgQsyLeXl+EwWBiAT8MpxOpJSQ02VfFMMpZe9TBqEG4of1/fyVrV06Zybn?=
 =?iso-8859-1?Q?H//eQnEi+4KfwpW2tVCAJEbr0jHe0c82xlf9k8Mjv+fHp+IO+g9mwOScFu?=
 =?iso-8859-1?Q?oNW0YOdf+h11+zag9348nI+37ee08v8ZlnMwzAw51RokbG0H+13/I3O+B2?=
 =?iso-8859-1?Q?gfz7ZuRy7IkJvYvRln8xzIfPtbENy/FcsB/0OqQ+YCaywcOQwMwm4eBFCI?=
 =?iso-8859-1?Q?tM2RR9td9gVojdyzrMxWxvx/zp/IV6QB/HCmVBGEqMS2SyE/vKaTKnnprz?=
 =?iso-8859-1?Q?qMs+cbQ58ajPdAoUUExyWRUnkjH4ZpFWD5jTrDNukN3r4iZ1oZM2zfnfpa?=
 =?iso-8859-1?Q?J8tEsuG5Hf8hbdxazhyxxVA2Rt0XCwShBy9cUetx4kAlDbM1gu4Uyk+ieH?=
 =?iso-8859-1?Q?2yPDIGHGROqdgJAycqMc1jkG5Zm2UswFbxVpqnoL6IcE+jj9z5oUuLexj8?=
 =?iso-8859-1?Q?I/p6tcrsXGXRlH3x19zPmReyZjqjDCffEaBzVPDYEawhwPRhiiR5zAgTSM?=
 =?iso-8859-1?Q?/qsi1iINa5GwpsTbBBayVUfBBUvx0XgtwMlub+43CnEsnDURvT2K4piFcr?=
 =?iso-8859-1?Q?mNT3N1AU4+uDCDrCsXd6wxe8UIjLvy+/P39J84uk/nYWE7V6XPaowrWagm?=
 =?iso-8859-1?Q?isBrEmc0iyKfsZJLAg/gQFuXz7y8Y+txLFI4XfqN2VrF+w8hRaytd2kSRr?=
 =?iso-8859-1?Q?tChWYHWxhonLKAdRMYBxMB1BNrj09Fpajx3UTis1gUjtqCDpRiTmIvBx36?=
 =?iso-8859-1?Q?ffLg1hauBdqcYx/xfes5cOd8z42985VCdfJv/CJjiEmSRMf9cA7RCEXCsL?=
 =?iso-8859-1?Q?1YQFe/eUH3RHR4CReO6wrhoYC7XoyZrAh8cFSnSmqpa9Ng3LTcTpfQZGdU?=
 =?iso-8859-1?Q?na7zxgPGsJ5M9Kdem0w7ez09mQdeVBxQhKUTCFzawCga48yV+87j9dxF59?=
 =?iso-8859-1?Q?h1gk3SMBTN5xeV5dn8QUuJDi+EVybOiTjZgmK67DP146Ligm/x3wvO6qCB?=
 =?iso-8859-1?Q?AgoR50QVYitgC7ej2/dz7L6+WnZWSrkjBI3XZ0Sy4eCAtCd9HQKq62bYJQ?=
 =?iso-8859-1?Q?1oWBkdtxBOA/TedlI3MvzxfUZ36tWYWvLJqBMbKeCWwkXSwaxggkwh74Jf?=
 =?iso-8859-1?Q?pdIl94XPA6uY+X0LeTcqLy7DTHG5eMwRXeJxyNoHf2Y37miKdj0fvaYZuy?=
 =?iso-8859-1?Q?77rpBjDabvYcgaFZo2eIhoKLLgvGLogk2ruOvkFCYfo3a2S1duGMxnoZbX?=
 =?iso-8859-1?Q?yZEPwlNP+IacItdy0XxdAYljLen0w0JKcbgh7+9J8uz1YsLDWHuxH3IIGa?=
 =?iso-8859-1?Q?V8ZBhe7MWDleY/nqdLTd3WjAgjVwNABaKucmZ9m+TkD1facv7cFmNGxKmY?=
 =?iso-8859-1?Q?FGzNnXGqIHoNY/X0kgLGbXHUSuxlW66xV8HQ/xtT1Wm8T40ebqb53PGfDw?=
 =?iso-8859-1?Q?5nHayfvRnMovUm/i2Ux0EWTzvRJMXM7Yt/i/351GNUI2fkmBlkPMITKxtQ?=
 =?iso-8859-1?Q?p5qZn7phLuoYvZG78FxJpb4LBfrXUJkzQfCfe6KlQVoQZD3p9kC4kyUEza?=
 =?iso-8859-1?Q?XLplNMJ0kn8ua4TiMx4WO3OljVkrlKmuhd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a0cc19-2656-4d0b-e1d1-08dcb6e991c4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 14:02:27.0006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ggTaFQeLJgRR47L2NYsNLxKosKhNHvsAIxWIdCsndEuVfHL7sj6uBSUQXDOid4FoQXbUcejCTyOoefbGXLcVOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7328

On Wed, Aug 07, 2024 at 10:29:19AM +0200, Csókás, Bence wrote:
> `fec_ptp_pps_perout()` reimplements logic already
> in `fec_ptp_read()`. Replace with function call.
>
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/net/ethernet/freescale/fec_ptp.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
> index fdbf61069a05..91b0804142e4 100644
> --- a/drivers/net/ethernet/freescale/fec_ptp.c
> +++ b/drivers/net/ethernet/freescale/fec_ptp.c
> @@ -213,13 +213,7 @@ static int fec_ptp_pps_perout(struct fec_enet_private *fep)
>  	timecounter_read(&fep->tc);
>
>  	/* Get the current ptp hardware time counter */
> -	temp_val = readl(fep->hwp + FEC_ATIME_CTRL);
> -	temp_val |= FEC_T_CTRL_CAPTURE;
> -	writel(temp_val, fep->hwp + FEC_ATIME_CTRL);
> -	if (fep->quirks & FEC_QUIRK_BUG_CAPTURE)
> -		udelay(1);
> -
> -	ptp_hc = readl(fep->hwp + FEC_ATIME);
> +	ptp_hc = fec_ptp_read(&fep->cc);
>
>  	/* Convert the ptp local counter to 1588 timestamp */
>  	curr_time = timecounter_cyc2time(&fep->tc, ptp_hc);
> --
> 2.34.1
>
>

