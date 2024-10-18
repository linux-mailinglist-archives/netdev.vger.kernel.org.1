Return-Path: <netdev+bounces-137053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D099A4248
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 17:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6489E1F24D99
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 15:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DDB200C8E;
	Fri, 18 Oct 2024 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kSeoUb49"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6C11F4281;
	Fri, 18 Oct 2024 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729265179; cv=fail; b=NfRoBFY0fabTkd4rqFYWQdptJHEI3UZ9Fxl30qiJAsZJsfc8IaWDv5e1fGY/wnhXVTxLEB8a7qFprvFO1NqPajp7vgI9xdNCV/450Is5+mEl8K74i17RklowjULSEV+vSIN+VJjcsYAeoD97yVz1zoqsSsj/A38BxjDInylXTlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729265179; c=relaxed/simple;
	bh=kCS/iwog329Ia4dieQLH7Bo/RHVAOjvQPKCO/ylH/BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cv5uHqJ/i0+p0FhEYZrBRY230KClav6kmPg9o31YQQw7qPrf9PS2wW8DsDUvxzTPF4VEK8PDlP41YnjWd9VRqEUo21DtS5vZArwXNmk7HqavcqYHsERq62l7W8mwsQTo0Bo2RD1IGbnqg7ZG1fFmGpBZLZOm1OrG+M28ytNQfFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kSeoUb49 reason="signature verification failed"; arc=fail smtp.client-ip=40.107.21.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOoQ3LYT0Y5UiMujwSvkGeoxliADVDq4p4C0ujQmM3zjIksFX4e98HFrQvtfGvaFven0UktlsnuOlsCK04/z11FlR+2CoULiCLsMQxNc2AI3UoU/eSCyEXyjPWsFWytW8u1PjLVITPPz8ohM0Kd7SeV49dJSvQWWNy6ZjQ5eRFEL3gyBHvSQ5LuSPhX80cZH6/Mo9aw+irVZqjHyXBptseIKvKLZQWz55Va/5ijsyePZXxI03F2t91dbIy9Nuy+8vpiacocY0ZQb/uhBh6kNHaX0o0lKS70itvXR7U+qyHZWtuUY+F5mEgEJ7EVhLHaaZptNSGI0XCc1SmfhT6X56g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AEYhrJYGYxM+a7rk+6Bc8BFsUQS8Zebbuk4s4qlAgQ=;
 b=U9BNgAewDKFbuOoAklw03IJrmLooy7/pby0AQlS/U2w10dcgWtwN1r59V2Rumy2QwKT+r7uJSQN65+qASPjLK6HBJgUY8SXegktE5Vw3d2upQiMQucGtfyEdzdJoxUPDwrHBRpz6dL2/GUNpdcvz/K1D3heKR1IYDmanpXcnxPOkapYD7zxJZAL81f4OoCA8Kvfat0wBxXZ/Cb0QtOia2eT7j+Q2oaPBru9jC+nYP3cZ/+SmaCNcjCC8r7uEEmuX6VJLtO1sk9RNgHGeIRY0Ur21RG3TIiCuShRIeCgETCC1ZFPnvqqKw8+Pv6psULgd1+0tRGUrwIeDsGnNQnUMSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AEYhrJYGYxM+a7rk+6Bc8BFsUQS8Zebbuk4s4qlAgQ=;
 b=kSeoUb49WCpYR2gF2GfPoeiv8y9i7nJTRiPLay5l2i583AoVk4qujyhbKJudAbua/Dvc0Q7OMTneVh9VwTXS1Gari0vilIeDGfb8lTvqke7v68e6Kc9zYpyZ8vHdLlfjW9wbvNtvRog568xBeKEn5+/qthzSn/K63aoJgKUd/4O3EC6TCrnACcwsztrUjZGfhXLn3Bc5Ufd8o0uKsF5pE5jFWaQgbKpapmlAxKWT4FAMgvh+bxGoDXtGGaxvAm8J4+IBJbvYjpeDsDsAD34AMvzanEB9kJEt0DLDf0CqDcuM8R0tzjrDedhY62XZX2XhmI3wGcH7NNp4FDyCjsMCdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10574.eurprd04.prod.outlook.com (2603:10a6:10:581::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 15:26:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 15:26:12 +0000
Date: Fri, 18 Oct 2024 11:26:04 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: RE: RE: [PATCH net-next 07/13] net: fec: fec_probe(): update
 quirk: bring IRQs in correct order
Message-ID: <ZxJ+DAn7fRE3Aiqm@lizhi-Precision-Tower-5810>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-7-de783bd15e6a@pengutronix.de>
 <PAXPR04MB85103D3E433F3FBE5DDFA15C88472@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241017-affable-impartial-rhino-a422ec-mkl@pengutronix.de>
 <PAXPR04MB8510149D0E8AC39E048941F988472@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241017-manipulative-dove-of-renovation-88d00b-mkl@pengutronix.de>
 <ZxEZR2lmIbX6+xX2@lizhi-Precision-Tower-5810>
 <20241017-rainbow-nifty-gazelle-9acee4-mkl@pengutronix.de>
 <ZxEtpRWsi+QiYsFh@lizhi-Precision-Tower-5810>
 <20241018-black-dormouse-of-exercise-f7fed0-mkl@pengutronix.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241018-black-dormouse-of-exercise-f7fed0-mkl@pengutronix.de>
X-ClientProxiedBy: BYAPR05CA0067.namprd05.prod.outlook.com
 (2603:10b6:a03:74::44) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10574:EE_
X-MS-Office365-Filtering-Correlation-Id: b09a630a-f081-417a-67a7-08dcef8932fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?bPh9sg+vUc3mPRTeCYr015axLbwmsAzfQZUYS2123suyHYs+zeUqLwEgIG?=
 =?iso-8859-1?Q?GFayQsNBnLY/LcknUppNrD/8W7NEfnGE2PeeNqGWLV92UG84e6dYzaxU8y?=
 =?iso-8859-1?Q?e1EBvasDZCRhpkeg50Ul13evd+j1ezHNDvmlaNV/JMezhufuHKd/jFz0JB?=
 =?iso-8859-1?Q?ogRVUvoFbpz0Auo7Ujk4p5gfJi5mi2FxUgRdLYtyhhiVd+n2qGbklDZgFm?=
 =?iso-8859-1?Q?23p/quGv6O87wemF7b0zfP1hB+I2iNPlSmSeK5KfTECh+02oQMTUquq1y2?=
 =?iso-8859-1?Q?PgDLbN2DrF3nOWGugu0CtppY+HZ5s0l/vCDMadsFkWzqY9xhnpd/CP5mTg?=
 =?iso-8859-1?Q?rLPNjcpA6soJvf7c75NgaD2pqHwrAU91Dqsr8OcmBaLeDPZgI4G6kuFdQ1?=
 =?iso-8859-1?Q?2ZzkIr2G2+uMFVIWGuny9bJisEOVU/VFTjK+8Bh9Q8ULp4zMdx3zyEkV5W?=
 =?iso-8859-1?Q?td+CNzfrprsr/+MYSgOq/wc48KRTaJ9Y52S+mq0MVb66/+KgzcXL8YLDu8?=
 =?iso-8859-1?Q?EtQu/QyPDhk0Gx5uG9T0f0vbD0sCFkYKd2+AqZKstYNdl6uxKBJjDo2fYH?=
 =?iso-8859-1?Q?TsiAVfLCqpJVhj8HDX4OEugneExIa2qMHT+H8qM4zWX0gCtd3+ZBkplYoN?=
 =?iso-8859-1?Q?hEu7I79ZPG4aQTZakOo3TFPXpSRNwFXogybEo8aZaUH3jSQCY3+MTUPA8C?=
 =?iso-8859-1?Q?SpmuqDk7Zva5IGg/3miIv11Phz5fPFfUycd+vxou71GBKarNEhdFbPV0CS?=
 =?iso-8859-1?Q?VS/pV8yBMalQ1OWwiYWBHxPOKPGM0zOWhihur05MlVVrGaOQ+sF+h+esBd?=
 =?iso-8859-1?Q?ePYABs/EldGd2PSNHdQODQVGSEu5lmTftLp2/O5/DRSeMI3kP2pb1NPHm2?=
 =?iso-8859-1?Q?btZf4QUj3wiSAkGiJ6Y/pbxfkEWBfsJiMQbG4efN6MArE409Q9C0s5IA9a?=
 =?iso-8859-1?Q?7WciK3P+Vvhutlb/4TgUk1se+gfvTsaKfWMnLwfCRmwgkp7JeCxjEXlJ0B?=
 =?iso-8859-1?Q?GRMQBD/pOXK1CATOtc4N4M4UEZ9C7ssaWu1iVsO7+sL3xKkSKial1Qo+oq?=
 =?iso-8859-1?Q?ni/dfoky70mUZOHN8M5FPlr7Iom3qP31LXnpRq6pxttbSDW7FppFYDFBws?=
 =?iso-8859-1?Q?dNzaM/dWEESIlk88LKgN1bDpPb2IsCxq4M6XBfvSWIhTllCCvhF98EZlbp?=
 =?iso-8859-1?Q?pNCmEsNDHpRfSBO5MeKzvvozZBuVS9HXvOPmkhioVUcrVkr3Ivg4Ju2bCF?=
 =?iso-8859-1?Q?ridTalApUZuTV2Lh7CYQr7qP78P2cWHWc5lJoG2NybE0WI9PtfgzLqJ7bh?=
 =?iso-8859-1?Q?rUxAxsDFfepI3yC4ZiYO/u8kA6boxiQaFzr7tDwITkopIyA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?qbkbh/qMsLEyMpnSPbQnOewUTOcr0FeRhT/IPesPFnUaWt0y98s9PmN7gS?=
 =?iso-8859-1?Q?wXGwYimsIuasayGGPJxfg1/7R3odSeWijfNilZjR5jBcs1tX+fuLrmuOiO?=
 =?iso-8859-1?Q?5qaCR7wduxwgon2NpjQoY/hXv1AIIpOh+j4wOsD5osc84C/BTV7EffI7sr?=
 =?iso-8859-1?Q?8c7uhl7L7o5Qvyp7/fMeilHUYi6Vx5MSUEjkJ9Mimc13OAxrxetzjaL7/D?=
 =?iso-8859-1?Q?gYkbYMZHgG609Fh4omaQf1AZl6zZL2ZrSV3oytBcRtv9jRIqzxec4mb7Xq?=
 =?iso-8859-1?Q?A7J2NaE/whFv/3Fspr70y7WFSTICmMfj1xWqhkb2LDrE1fZ3JEDqAWj+El?=
 =?iso-8859-1?Q?i7HwlZrfWmUVnM2TzORUqIiWDrn5abjtpt9n597Jx2VpLNv6xqnfljA81e?=
 =?iso-8859-1?Q?aGO31PTpaNM+SFcu3ACqWgdGmAgaVewFAGXN07bPracOKU2DDu/K8+m4QQ?=
 =?iso-8859-1?Q?G8ZEMygkbs7EZO6I5zxVJPlA/zK0mL8ZmTwG2QmD7kORFVYIuvwwHsNE7F?=
 =?iso-8859-1?Q?9ICVQGLX4zsf98U7tOfJ7KCPj/wIN+BiZT1mC8ySx87KQALS6gAyjtf05k?=
 =?iso-8859-1?Q?8F3CwWRTLmoj/NZJOspn45yIrGY/ipfjjYIGDL29LEqnO8tQchReIsIuXq?=
 =?iso-8859-1?Q?a8CSwRMh/AZSt89OeEMRX9YkUy9VJZ8icODqBOS2mAh7GhuJaBveKeeopo?=
 =?iso-8859-1?Q?cZDCAfFP6oEdkbERT3l44acJNSLYFNXdHCtx7ucZANPvMf5k9d7YBW59xS?=
 =?iso-8859-1?Q?R47ylwM51PnvYLVLWz9OnA+FVGVRdYe6YHq/LpeV326WDJg4msD0y01y9S?=
 =?iso-8859-1?Q?vDQHiVWohMYi6wiATFkaIE2MwE2uvmgXvZqpdqZK1/UVPhYwWE54Gary5/?=
 =?iso-8859-1?Q?5bxfZeZFe4tvNC08jmf+tOu9XyBvCszyZtWUcUSC2K1aAVdFrDHFfzRIR7?=
 =?iso-8859-1?Q?2r0T6zzVvOxDWoFq45D3XFzhFMqMB+4TxHTViFONa2wO9fbLfeemVvFeaB?=
 =?iso-8859-1?Q?zhmRGoCKwZ3e6v/sc+w/Ye6/mSxdvPqweiFUAKg69jK74DlzplEv9Yuy4L?=
 =?iso-8859-1?Q?XsE1jQkVh0vhl1J0payO2gtR+1/lMTdyZ5dglYytHpo6ZusRMBP7Mebyq7?=
 =?iso-8859-1?Q?6pO3E4HidGy/9wtpXytVWZDQwMjc6LnR1x5aFurFJ2dH714Bl0IZGXdA2U?=
 =?iso-8859-1?Q?Qej280QNuoXlMHtveVN0Sl64KwdZ3kK9GynjSCTbnnsah32Bh+8Cp/N46L?=
 =?iso-8859-1?Q?YC7/pUlD/qxwm5s51mxPfIdDuz6BRK+f1eCZ05RYGq7dzF1wJQFin4WW6H?=
 =?iso-8859-1?Q?XpAWmLXQN9wi6GDZb0MRiLT0Gs8gdkw6o517EpDo7aSCFOf5/Dl+YgqeY+?=
 =?iso-8859-1?Q?rruxOcwWa+NrwWdCnxgF7ZBTlxbGLi9A7tL2A/WRkEoqMplVK1b6QJ0b9V?=
 =?iso-8859-1?Q?NxUe/q7zPQN45BW4GHmgYWc3pXtuna6Xwed32A1EySokKPpCY1XLPocMGW?=
 =?iso-8859-1?Q?196JZcb6YzTgIQOrd4DT2hOU6va7k8uHYETBphRVpzZRptoOgP9meOyjkz?=
 =?iso-8859-1?Q?CVKp4VBvtNNjO2CjoUbFxHoEl47J4ELveH6pqusLJh6j4Puq7DSPHAyiLb?=
 =?iso-8859-1?Q?X5Yp9ojsv7Jrq7zFe8sWF2fYOHHje60CJ9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b09a630a-f081-417a-67a7-08dcef8932fb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 15:26:12.5983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFl0UrPgrcaDBPE3u6Qb9+FRkgpz2DKs1PHjX4HmHZ1NhHHcBvrL/MJG7uJPQmvaQDrl89d3J8gKT/H2fwb5lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10574

On Fri, Oct 18, 2024 at 11:16:46AM +0200, Marc Kleine-Budde wrote:
> On 17.10.2024 11:30:45, Frank Li wrote:
> > On Thu, Oct 17, 2024 at 04:21:33PM +0200, Marc Kleine-Budde wrote:
> > > On 17.10.2024 10:03:51, Frank Li wrote:
> > > > > > > Yes, that is IMHO the correct description of the IP core, but the
> > > > > > > i.MX8M/N/Q DTS have the wrong order of IRQs. And for compatibility
> > > > > > > reasons (fixed DTS with old driver) it's IMHO not possible to change the
> > > > > > > DTS.
> > > > > > >
> > > > > >
> > > > > > I don't think it is a correct behavior for old drivers to use new DTBs or new
> > > > > > drivers to use old DTBs. Maybe you are correct, Frank also asked the same
> > > > > > question, let's see how Frank responded.
> > > > >
> > > > > DTBs should be considered stable ABI.
> > > > >
> > > >
> > > > ABI defined at binding doc.
> > > >   interrupt-names:
> > > >     oneOf:
> > > >       - items:
> > > >           - const: int0
> > > >       - items:
> > > >           - const: int0
> > > >           - const: pps
> > > >       - items:
> > > >           - const: int0
> > > >           - const: int1
> > > >           - const: int2
> > > >       - items:
> > > >           - const: int0
> > > >           - const: int1
> > > >           - const: int2
> > > >           - const: pps
> > > >
> > > > DTB should align binding doc. There are not 'descriptions' at 'interrupt',
> > > > which should match 'interrupt-names'. So IMX8MP dts have not match ABI,
> > > > which defined by binding doc. So it is DTS implement wrong.
> > >
> > > I follow your conclusion. But keep in mind, fixing the DTB would break
> > > compatibility. The wrong DTS looks like this:
> > >
> > > - const: int1
> > > - const: int2
> > > - const: int0
> > > - const: pps
> > >
> > > Currently we have broken DTS on the i.MX8M* and the
> > > FEC_QUIRK_WAKEUP_FROM_INT2 that "fixes" this.
> > >
> > > This patch uses this quirk to correct the IRQ <-> queue assignment in
> > > the driver.
> >
> > This current code
> >
> > for (i = 0; i < irq_cnt; i++) {
> >                 snprintf(irq_name, sizeof(irq_name), "int%d", i);
> >                 irq = platform_get_irq_byname_optional(pdev, irq_name);
> > 		      ^^^^^^^^^^^^^^^^^^^^^
> >
> > You just need add interrupt-names at imx8mp dts and reorder it to pass
> > DTB check.
>
> ACK
>
> >
> >                 if (irq < 0)
> >                         irq = platform_get_irq(pdev, i);
> >                 if (irq < 0) {
> >                         ret = irq;
> >                         goto failed_irq;
> >                 }
> >                 ret = devm_request_irq(&pdev->dev, irq, fec_enet_interrupt,
> >                                        0, pdev->name, ndev);
> >                 if (ret)
> >                         goto failed_irq;
> >
> >                 fep->irq[i] = irq;
> >         }
> >
> > All irq handle by the same fec_enet_interrupt().  Change dts irq orders
> > doesn't broken compatiblity.
>
> I'm sorry, but this is not 100% correct. Changing the _order_ of IRQs
> does break compatibility. New DT (with changed IRQ order) with old
> driver breaks wakeup functionality.
>
> Have a look at b7cdc9658ac8 ("net: fec: add WoL support for i.MX8MQ"),
> but keep in mind the patch description is not 100% correct:
>
> | By default FEC driver treat irq[0] (i.e. int0 described in dt-binding)
> | as wakeup interrupt, but this situation changed on i.MX8M serials, SoC
> | integration guys mix wakeup interrupt signal into int2 interrupt line.
>                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> This statement is wrong. The SoC integration is correct, the DT is
> wrong.

We should fix wrong thing instead of continuing on the wrong path. No
much user use wakeup funcationlity. Actually you enable both int0 and int2
as wakeup source if try to keep compatility.

for example:
	fec->wake_irq = fep->irq[0];
	if (FEC_QUIRK_WAKEUP_FROM_INT2)
		fec->wake_irq2 = fep->irq[2];


...
	if (fep->wake_irq2 > 0) {
                                disable_irq(fep->wake_irq2);
                                enable_irq_wake(fep->wake_irq2);
                        }

I perfer fix dts and remove FEC_QUIRK_WAKEUP_FROM_INT2.


>
> | This patch introduces FEC_QUIRK_WAKEUP_FROM_INT2 to indicate int2 as
> | wakeup interrupt for i.MX8MQ.
>
> > "pre-equeue" irq is new features. You can enable this feature only
> > when "interrupt-names" exist in future.
>
> regards,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |



