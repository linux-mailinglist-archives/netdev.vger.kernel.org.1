Return-Path: <netdev+bounces-38298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7C67BA1BC
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D01FB281745
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 14:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6F12AB34;
	Thu,  5 Oct 2023 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LeBpjp8U"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2F01BDE3
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 14:57:05 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63ED1FC0A
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 07:57:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlhvpOxzCEYEOx75S+K3cJV20ehW2prRx6fjI1RjZMZKfu66Z7nOdPIRV8PEzt7qDCULAWiuLhLdt7DoO4PxDBkpVctwTBZFqSIN7PkbyHuLx8zbn+O4EhFfuiAKYxm092YnkrTuMwNoifT16MSR/DtVau2uhHn5RiHP2KhxYjMRsKSZGGGcd3Dmr7/hiB3oo+7LGHC66b6XpsfWnUJ3FUL7X5BkH7qj788Ze7f22lsvRgdmhMuAmAiPGyn3eZmQu3YLCO8sAz1S932t8m00Uv9INXRt8Ryz/apL2xkw/ifM4LQdcc/WOUedNs7gPwM0urG+l4XueipA3IkRXim4Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEcallO0LmznshYDTjQpyPbeDVbIV10JspbYskIyv+o=;
 b=HuK/7GcKHjzQnmJO6INjWGIERrTl2wWKew25v/9dnUYrsobOEsnqRWpsV7MN/jYwwqeGyUvin9S9YiJ5s3wWiYJrvHqfiQpkTOPAnXlUo+pHr4o1HGuFz+8qCmfqdc8P5Rt0KAqOKMw8u0uXV74PCgd7/vn6qrDoq9NbPbNQu3Dfuvjwsn5LHmmXILiVrFnyAyWMkNmrfN4eROfgsJbGYb2UE3j/GQPGDKOF4Xy+NO0+sratMqJzZnBN6RjOYTiA4UYK2zyNhTZ/Tf1HqnWky+6a4tsWmX2oxyeo2LsRt+Ig8bywXi4rK5lWE5iWjyJ97DY0hS7vzWFKSSGhE4WjyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEcallO0LmznshYDTjQpyPbeDVbIV10JspbYskIyv+o=;
 b=LeBpjp8UYc/totTLLU8O49iAiga4kGQ56sJE3mFjqxvB58P/iG7QmbGpb8Y964KeCggGKbh9iqyKJfknthKT4z+jiQ5SOiV4jxrOW71YSZrnujERmt6tcD3YP7ylIJyI6DLnsXdwH/yqUtsEH/XlSwZCvSmFM6E0MDcVO/Zct/A=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AM7PR04MB7080.eurprd04.prod.outlook.com (2603:10a6:20b:11b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 14:56:58 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::6f63:8268:88c3:2ea]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::6f63:8268:88c3:2ea%7]) with mapi id 15.20.6838.029; Thu, 5 Oct 2023
 14:56:57 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Jose Abreu <joabreu@synopsys.com>, dl-linux-imx
	<linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Mario
 Ignacio Castaneda Lopez <mario.ignacio.castaneda.lopez@nxp.com>, Fabio
 Estevam <festevam@gmail.com>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [Linux-stm32] [PATCH net] net: stmmac: dwmac-imx:
 request high frequency mode
Thread-Topic: [EXT] Re: [Linux-stm32] [PATCH net] net: stmmac: dwmac-imx:
 request high frequency mode
Thread-Index: AQHZ9vys2tc8iCG010iuAxOfNybS27A6vDwAgACM6jA=
Date: Thu, 5 Oct 2023 14:56:57 +0000
Message-ID:
 <PAXPR04MB9185667DCAD7F6BDDA96210C89CAA@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20231004195442.414766-1-shenwei.wang@nxp.com>
 <7f3f0f83-8288-bea4-48a0-38786b18edc4@pengutronix.de>
In-Reply-To: <7f3f0f83-8288-bea4-48a0-38786b18edc4@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|AM7PR04MB7080:EE_
x-ms-office365-filtering-correlation-id: afff9940-bab4-42e7-3dac-08dbc5b35284
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 oWVdg+xGwUEQNCE5kMQoUgFjRWCpSBoc6xjPYUltd5vtfvC0Z/hZnxkW+0c2nTDif+laKeTDCv40FfqTM6tEfzZdcEEUL+3ZMmXSqDh+q3mmefT0rz5t7h9bOUUw2tNDUpeJE3FZfb+8tZdyzlrJkDnfMezPv97qXg8TZyU+AaBEISneCksCAfYpXlDPOhzxctkDI2R1zVph0Qb500KNgy+X7GFVIGPWTxvRuYQxUxeM0lC/F6CdM0jd8CqDK8j5Szyl8UKInKkTjD+Lib6sjJhik1kGuNejnibzL38xr+28wVSn9JcaVtgFb4Wa61dgBcFVNJ7dZGGg9gQOjOMvhL+EuT2S08CHKaWcqan7AnTrGC9aueT6bo8KS5nhpB/lEesOZF0Rvpc2mfHFks+pxCIRfFt7jlWBumLIBio0oSgwbChVxvQkkpVSsnYqmHxdSrNfiIuoquc/xHtRE3K0YvmFXewkV5yw6HRaDjBUXzH3VLZzrlwBqc1mMGAhlrc1oqwScTfhpDqxYMHBS+p8ZHzW8AcC46qwAvydYY3Deh2kOtmv2U9/COA9NDAbugZFbgyuvFtK92YSYUkNt+1C07fRfIEDGiUMCSNkj9+OBqo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(55016003)(9686003)(7696005)(55236004)(45080400002)(6506007)(53546011)(966005)(478600001)(26005)(38100700002)(38070700005)(86362001)(122000001)(7416002)(316002)(83380400001)(71200400001)(2906002)(33656002)(41300700001)(76116006)(8676002)(8936002)(4326008)(66946007)(66476007)(66446008)(66556008)(64756008)(54906003)(110136005)(5660300002)(52536014)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DPm6SxCHUcnZbWymwNoJRtFCPou2o/8koFwFdFBKuIRSqzKFk9wfcOHx8YNF?=
 =?us-ascii?Q?i5dn5wClLXnlLy2lKPKwwia6XCAt1If4aACRJfs0e+tOF0F30Xdos9ZUUKyq?=
 =?us-ascii?Q?Ne3KNdbJrq1spW+yH5KQ0Pz7KDtTyM5A9WjAtCxgMuCgi2+DNc3vC7GtNF2X?=
 =?us-ascii?Q?2XqIpZEX0ZqYmgdFrrX9KYjGaknnqXadUJxXFgXK2ko/o5A18o+C2bK/IAJn?=
 =?us-ascii?Q?dgDBmpswTsmuWm2hK1JZYrOUyjOl+JyMjjBh8k+zSIEui96GWwBEsiXyix2a?=
 =?us-ascii?Q?vG5pf5ogM+ehd9zwfP/cZXNvcYBLx7Ydlajb16qD6NC+rKZiJNAKPX7tkNZA?=
 =?us-ascii?Q?ntCmA5QEajPjxAolClzT6CdJOJUbX2h6RhUcq0BbQ7gveyhnEcTk/aTOHauz?=
 =?us-ascii?Q?alPttjFuAVvN8ZjCdIJNyGR3MwWMvyKmIQsnFeFCYKTZq7mCVBD0iPYuoyeq?=
 =?us-ascii?Q?a50LEvbWk/Ai8W+wTjLw3bnxIU5w3tEtZkT+lRMxgUXWOX1UKqrs7YMnPtKp?=
 =?us-ascii?Q?4Fd+JOO8TJH9P6I87u9uW/NUv0ENi/s42nahjI34y3Noy50kOFVybAQ2nhTb?=
 =?us-ascii?Q?tiMmfBuBeeRiYRFUEAFW3Ep9Gw8U1guyixfG16Sh3Ym1/5U19EDmAzNCDWWY?=
 =?us-ascii?Q?QTfXIhsOHWrmutYIEFq9Ret2N53ixMUXbLpib/P5MPUnI1Xpqa59snuWoUsG?=
 =?us-ascii?Q?YOjLDofqecCIzAM8K+EWFQQ5RBpcmfC3IyMaR5la62xlvPNZkvVVbksnVImb?=
 =?us-ascii?Q?E4XAT69mLAFjyT3xVryr1s3XMpM3vAaCYoaF7CFAgFpTjBaxozqEEQUVppBE?=
 =?us-ascii?Q?L+7alyaF9001mrULsOcF09q5pe9oMMDpXcawS3xG5MAq/FYe4LkjCfQCku8O?=
 =?us-ascii?Q?jp6GOmVW7txpj/8svvSfbaZpKWsypleZMoh7Kdzpgw3KQ3yliohLJ/O1ld/j?=
 =?us-ascii?Q?iIWuC4fqDKrP79qSlRbxCkKamJ18khHnZ8Q1NPRTAJJSOHOzktvyt2W/Aj8i?=
 =?us-ascii?Q?MoxLtbEJ/10go/69l0ZaJR9vhKB4i8Dq9Ezwb23k58xL/nByatjCIimiImEy?=
 =?us-ascii?Q?hPm9fO91bCRCQwl06yCdJyQGDqXr/tK5ZEN5IQpUXnAXhaZUlMDtY0G01HVy?=
 =?us-ascii?Q?23LJuNFqCPwD33/lxxvprMgXRDAMevkAOO7WVX55NcE3gHn+AiMEac39/rJJ?=
 =?us-ascii?Q?e51rp+oKN4CCjSgnyWmVeRP//IscoZOnpE5hBiXzR1kqQo25q0vx4yLxoVOQ?=
 =?us-ascii?Q?LJQJH7asu1iRK1VSrZShF8UFpKLfSu3IWAY4hhMH3Sgapwpps3SWWYU1TVrQ?=
 =?us-ascii?Q?E7I7LskNqFfh9VQxpD2G3Kl5vOtmtoFqkH9Bg6xn35on35Cys28rV9S8Q76N?=
 =?us-ascii?Q?XDDnaIQMs5415Ssd2GQkOiTgATkZnAq6MiR7q/xg0SDEvuRpUgwuPZXeR3+X?=
 =?us-ascii?Q?T5PVfriiep3mX38SSdXpgSr7OQ+38Xp9ub6ZnOmKiwfxeWpQy7DjNAo8SvT7?=
 =?us-ascii?Q?0Qh48Gzx+jjmkDEHR0xcfG1azq1Ak6eEtbBtRYwO5w7mojBd4Aq1oa3AzN4s?=
 =?us-ascii?Q?YPBeKD5GKOSj1EzwOvgHz0I/zOx6iZE64ygi3V6P?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afff9940-bab4-42e7-3dac-08dbc5b35284
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 14:56:57.6537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G4eGfZtzgDiwGLEI+co7XCDWpNt8w+mLahV9foSQxEZpMAroj/B4PsrUjVGQJC2hhQ+bcn6i6ixKcwQGmnBNSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7080
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Ahmad Fatoum <a.fatoum@pengutronix.de>
> Sent: Thursday, October 5, 2023 1:28 AM
> To: Shenwei Wang <shenwei.wang@nxp.com>; David S. Miller
> >                       clk_disable_unprepare(dwmac->clk_mem);
> >                       return ret;
> >               }
> > +             request_bus_freq(BUS_FREQ_HIGH);
>
> I don't find request_bus_freq in linux-next (next-20231005). AFAIK, it wa=
s only
> ever suggested as RFC and never went beyond that as a reimplmeentation on
> top of devfreq was requested instead of the i.MX-specific API used in the=
 vendor
> fork.
>
> Did you observe this performance pregression with mainline?

My apologies. I did not realize I was working on a wrong working tree. The =
busfreq-imx
driver hasn't yet gotten upstreamed.

Please ignore this patch.

Regards,
Shenwei

>
> Cheers,
> Ahmad
>
>
> >       } else {
> > +             release_bus_freq(BUS_FREQ_HIGH);
> >               clk_disable_unprepare(dwmac->clk_tx);
> >               clk_disable_unprepare(dwmac->clk_mem);
> >       }
>
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       |
> http://www.pen/
> gutronix.de%2F&data=3D05%7C01%7Cshenwei.wang%40nxp.com%7Cbab522390
> 5f542a0cabb08dbc56c406d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C
> 0%7C638320840957133285%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%
> 7C&sdata=3DkxhSaLbYLmFqYkbN%2BXg1lHfwRbRgWrSNy35BMpcMnSk%3D&reser
> ved=3D0  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|


