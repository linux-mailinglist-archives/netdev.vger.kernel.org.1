Return-Path: <netdev+bounces-61640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D45482475D
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 18:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C55D1F25635
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 17:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0662C1BE;
	Thu,  4 Jan 2024 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="il7Rsadc"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2074.outbound.protection.outlook.com [40.107.104.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B232511A
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/OnBMS1N9ujvQvWwyjSn2crdr27eA4sCD4wSvdpw5g8q1ZiefL79g+0SxYMr3CIzHM/79aDZKR4w9gGfLFhQnMxnYe3enyy+8coetbDM/q92hBt0e9CQlK4ngcfH4gsWxJUS9GZkh/szJVEb9qDoDIcNgS9LUF7+M8Wpuh9jHSPKe15tjkrVRPdo0AUUWYLdz0SWofyBZ0KmgsjFTBSmv13X4aP33IVJ3t5aGH3n+5wLcL1jPx5m0EaivFuO1ci+SBSC5GwNvPSDEqy4XqNQ9L1tnGEHvrYFw9PpRk5rhO9YwzTyR0fm2m+8Xh8NS4R2zzFRnDS/cSCpGw9XFcxCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+A4NNZyEDmjMF6E8pvw8ns2aS9LO5ITPJwmeBLzLFs=;
 b=CxUMBWOUC2LO1sAAqseRn0+rF6qkjHSqENzHQW21VIt4iXq1pqF6i9Lr673eQVvHd/BrEtUDBQGSGYs0xjzQYa8f42RzAX4dPb7HtNHwmc9uo971M9RSDTKFAIxkGKjzDileI56Uien64zOmWKN9d22Pne696aDaoqqDWu+c7v1eASnmZX0yp/AIlCSloESl/o6uenjTERTt5Njwc++5AemJKIP93ZpP60XfytIU9dVmO+jDEQRCiOSGpW38ccI53Km3BLXVFaxbuOawx6lFaysi0xU7CMzGDVkbJnlMMrhprQP4X287Ine9t480lX63fBNDzEb/RM1lChRitdOz4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+A4NNZyEDmjMF6E8pvw8ns2aS9LO5ITPJwmeBLzLFs=;
 b=il7RsadcTsxgCUqhik/tFwrZEgEqfzPJL5rHQJOIIkq6uJxRy+oQuAqBjbnXrmpEid2bXQ3E8yNvIe6lRYAPBSIvBLBUWP7F+r4YKWIcdlvD6A4S1alQrXGac2cGpR5wZMvfnAMokcbBlr6earnqQaHmbAEwz/IX7ZOZeYBEs4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by AM9PR04MB8668.eurprd04.prod.outlook.com (2603:10a6:20b:43f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 17:20:18 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976%3]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 17:20:17 +0000
Date: Thu, 4 Jan 2024 19:20:14 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Alvin =?utf-8?Q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Christian Marangi <ansuelsmth@gmail.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Subject: Re: [PATCH net-next 04/10] net: dsa: qca8k: put MDIO bus OF node on
 qca8k_mdio_register() failure
Message-ID: <20240104172014.pnbmvwjozul766pt@skbuf>
References: <20240104140037.374166-1-vladimir.oltean@nxp.com>
 <20240104140037.374166-5-vladimir.oltean@nxp.com>
 <qyl2w3ownx5q7363kqxib52j5htar4y6pkn7gen27rj45xr4on@pvy5agi6o2te>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qyl2w3ownx5q7363kqxib52j5htar4y6pkn7gen27rj45xr4on@pvy5agi6o2te>
X-ClientProxiedBy: VI1P190CA0012.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::25) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|AM9PR04MB8668:EE_
X-MS-Office365-Filtering-Correlation-Id: 006df441-a68c-4d22-df07-08dc0d496c03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TiTitm6fp1k+D5QYWeO2GwjJ4RcwppGH+EbUQgb+wlL+Z9Vt2xRAeAFbhVsrQ+DBb2m6M8LC6ewfq+7+BiRcmLoxijJezy4cEkwLoec8yeJVuv2QYNbBDlyFQ4wJjdJC+icWYOAqqu7VUIV4qxJvmj8CygZiQq9GI6cVC7znIuZLsAWusqZImND8AwwTVg4N89FtDxYJ0ygFGKyt+P5jbLeSHlJ7gCMcZWFpCU+gyIuvF+VqPq+qpiYxHYSEht3xtuSDt/D1Ccs/G7oLo5youLYEpomMb72E4wojci/wjhD6H8cdEMc/H1Rhi+HXFcb+GPZLRljdY55+Bhxt/JOVI34rA5xRkLkKXmX7rAUCCznRZ04RaSCw5Gbi6Be2pOZIs/NNbnN5JZ8oJlE3jnh1IFWFnkanSeyLYmTAUPBsVNYVuOE3i217UUdQssswzxeRMBWSYbCgVQyAnF0g9QFkTAlqAT3t0Ihaouoz6uSns8pYD598eI2Q0fyokRRVOvCWAP14kqYx5kdqJrPm2Vzk/5Wt/sUvAfW1e65gb15xTvITJPI932xk5D8Zt2W0hfCKNaU1E46uSX5hMbQuGBNUINXCi3J6M4VHTRptUPtY57o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(136003)(39860400002)(346002)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6506007)(6666004)(9686003)(6512007)(66899024)(478600001)(4326008)(54906003)(316002)(8676002)(8936002)(44832011)(5660300002)(7416002)(38100700002)(2906002)(86362001)(83380400001)(66946007)(26005)(6486002)(1076003)(66574015)(33716001)(66476007)(66556008)(41300700001)(6916009)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0llRXBabEZDdHdJeUt0TTBiM25NRVgvZEtjQUhneW9UQnhYUCtPcm9WYU1a?=
 =?utf-8?B?dmNrM1RUcG1VY2VGanR2VWVFb2F0VTJheEcxcXFoSzNHYU5yS2h2cVorREts?=
 =?utf-8?B?c09xR2k2Q1JjNkd0eHh3VFhtdW5iTTRiNk1mSE5jNzlGSHcxR21ERlphOEFO?=
 =?utf-8?B?dkRaQVpQR3h3UkVPRnFkazIreTAvaWVnOWpiQTJULzFMVysxSUo0OUFIM2Fl?=
 =?utf-8?B?M282VlgvL3VVaElvZDd4NDlrcFBBZDdpNmRjUnRjOFdJR2RVYzZOQVZuSXNo?=
 =?utf-8?B?ZW40eUJQcTI3ei9IbExIakZUOGlaYW95RDRRQXdtL2ZORWRnbUpMaGlaQ3d0?=
 =?utf-8?B?YnYzdGhhcjhlMWxERThaUUVvMFQ0eVY1cUhvQ2d3VFVCSEdCRnhiWFhPMjNG?=
 =?utf-8?B?ZjV2RnhxdjNScElicTlyR0lBaU1sVjNEcktWeEx1bVJYS0tibnppZkg1NVRX?=
 =?utf-8?B?dkR2WU4rb0hvb3FuYkd3UTVyTk5YSCsrYS91QVcyT21FN29kR1plK2dRUHVI?=
 =?utf-8?B?alFVWmlHa3NBU3V1aXluRFNyQ1ZZbG9qNjRLbm9FZm1vWnZpZ2NsUGlCZ215?=
 =?utf-8?B?RWQrc1NhV2s3bkhyakd2ck13M2xybGVvemFGSlJIRXBHOWZIMER0MGVxamhT?=
 =?utf-8?B?Z003TjBTZ1NKeW1jcXV6cWZhaVcyNVk2YnlUSmN5dEI0Nzh6RTltYituZm9W?=
 =?utf-8?B?OFRyNWRrZlNFQkFJTitUMS8zZ0tZcGw2SVlYaEFTSFAxUDRTUCsyejZwVzlW?=
 =?utf-8?B?Zmwvd2FyMXh2OEJFZU9mYmxDdFdzOUpPVURWQk1PNTNqSTMwMlpvQW9zK1U1?=
 =?utf-8?B?dTgzS25MYVI5NHBIZEJIanozMUsvL1dYZGRHTUlObkczdHdUaTRXWWdNVnZj?=
 =?utf-8?B?dVZYSXJsUzNPYWVydFNnYkFIVzNpZEo4VlhjdEhRZ1V5K2R1WW5Ja0cwaURG?=
 =?utf-8?B?VzByRHdyZ0RTUzBKN3lyWDNzYXRCamFIQTZXaGd1TlFpN2NOenJUcWdtdEpJ?=
 =?utf-8?B?WDFKNmQxb254b0hYVTkzNE5EVnN1NDA0WEVZdi85YWtRVU1wci8yY3hNZjFz?=
 =?utf-8?B?UDVZcmhlcXNxcTk0U01oZkpyQnEzRkI1R3FLMUdBTjNVdUlnbzl0ODMremE5?=
 =?utf-8?B?UTlMdjNFeFFpVTJVL3dBTjFjTDFOUk9vd3Y4QTdyMXhUcXptR2JsY0R5TStX?=
 =?utf-8?B?NCt3VUhnYVRITlBMNzlLcG5tZExXZ0tEb0xQeHZXZWNEeVo3OWpTdEQrWFh4?=
 =?utf-8?B?ejRGS3BJQzg5c2laNUxoV3N1MXI0eDAzNlduRFBaMnE3TjloUnZMTjU3elY1?=
 =?utf-8?B?SWl0a0FKL3Z4T1VJUU1ycDhSbDdYZmRDZ0U2TG9ieG80RFNpeU9USkM3U1ZB?=
 =?utf-8?B?cW4zVzJCdXRwNWEzcUU4QjJOaVFaRFdtYzRBdHhyd3FpZ0pKOUh1S3REQUM0?=
 =?utf-8?B?Rk82MUxnSmJkOHV1Vm91WlA0TUFBNFJZYnN3VVQ1a3RVRHhSMjRsbjFyb2tv?=
 =?utf-8?B?djE4TWtIRGs1Q0I0aEFsbXBTbGw5SXQ2U2dqM0xBUm9sS2RJbWVOeXZxN2hz?=
 =?utf-8?B?Rk51K29yVEpWaEtwcFBEYm1DNHJQUkdzS1AyWW9RMnhzYzNkQmNDWkNsLzZQ?=
 =?utf-8?B?eU1Cb2NzUk8xM09RVzRNd2pNa09sbXVCWGl3bm53aU5YY1czZ0xBV28zemlr?=
 =?utf-8?B?Ym9LUm5BdllYSE95WXJ0WkZvMm5lNmJpaTFJSlIyVXBKcVBCbmsrejhxNGJC?=
 =?utf-8?B?TDFna09CQ2F2TnNGaElEY2dFTlRPOXJrTWNYVHoybWpCNTNkb05mNGRoaldv?=
 =?utf-8?B?L0NRbU96OEY3UFdZUTd5NUlsYk95K1JzRnRHWnNpaTIzRjdmblh3c2N5eWdW?=
 =?utf-8?B?MjhvU0FQMFBLYTZaSzZjSmozYVZrd3pMVmhDYS8vWlpsSUNqaHlZenFBRXdU?=
 =?utf-8?B?L0VveThjbmNLTDhYUEhvSFkzK1pUK2VXRld2Q2wvUWprWUx2QTZxd1RlTjJY?=
 =?utf-8?B?VzRmMDJJdk9MdG56ajQ3ODVoOFJjOUxEMmtlaFl3MlkwMGVhaCszZk12SGFR?=
 =?utf-8?B?OGJTUDcvRno5ZHQ0cENGM0h0VmNrakRjbU95ZFJMVU9tekNocmd2OFhOUDFF?=
 =?utf-8?B?TmFHOEx4QmM0dlh0cDhHR05hSVY2SFg0TDBGdUg3elJhU2ZSYkpsditDdVFy?=
 =?utf-8?B?anc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 006df441-a68c-4d22-df07-08dc0d496c03
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 17:20:17.7004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTzTthBTjTalau76qkhQPyr6xRnDOF+f+tjBC2yhRrRvijNlaMsOTw6aEbLcubTQpDKxUqNHlnoV7EaqF7m9OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8668

On Thu, Jan 04, 2024 at 03:46:03PM +0000, Alvin Šipraga wrote:
> Reviewed-by: Alvin Šipraga <alsi@bang-olufsen.dk>

Thanks for the review, Alvin.

> > ---
> >  drivers/net/dsa/qca/qca8k-8xxx.c | 21 ++++++++++++++++-----
> >  1 file changed, 16 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> > index ec57d9d52072..5f47a290bd6e 100644
> > --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> > +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
> > @@ -949,10 +949,15 @@ qca8k_mdio_register(struct qca8k_priv *priv)
> >  	struct dsa_switch *ds = priv->ds;
> >  	struct device_node *mdio;
> >  	struct mii_bus *bus;
> > +	int err;
> 
> nit: besides qca8k_setup_mdio_bus(), the rest of the driver uses 'int ret'

Yeah, good point. It wasn't on my mind as one of the things to check.
If this is the only change that ends up being requested, I would prefer
dealing with it separately at once in both places, rather than resending
a series of 10 patches plus another one to also fix up qca8k_setup_mdio_bus().

