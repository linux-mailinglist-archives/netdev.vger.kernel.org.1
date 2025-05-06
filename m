Return-Path: <netdev+bounces-188487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E44D9AAD0FA
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 00:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B381B66168
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 22:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44997218EBA;
	Tue,  6 May 2025 22:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IbSIw/36"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2056.outbound.protection.outlook.com [40.107.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461491DE3AC;
	Tue,  6 May 2025 22:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746570577; cv=fail; b=RkN17nUIqHIi0vzUTpHJhwNNLhPDxQouWSqhlyBebJDxb+ZlVmNHqusQacsQmkhbDArpyhdwbcIAceSdSiXYIp4U3z4H9eZOZYKEx31BYwKNE/NDW3sz3MFX2DP60VcxXqf83hwfn03rMupEUoeg1arHm4JQiEzWrgK2vJafW6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746570577; c=relaxed/simple;
	bh=dqTySYXuQa7fQ4VyQZrFVxMYufRXjEwMP26s2Qgy7vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gVC2Bmfs1ZuyKeH9QatfiDBWb3weVfTCtBKArgqnPysfAub2N22TDcyTmeIj7FJCaOIEFxmuP7jYH2XTMxQkEJWBrHivBFl64y9VjLABQu6bxNgJ/zomtI4JUdK4474+jZDER5rPW2OpwYkBegZoUWVoMd/lRBYr+5NSgo4uMpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IbSIw/36; arc=fail smtp.client-ip=40.107.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGRYUnf4O9PkTDh8EUpwNvhQJGYYVbNBASpwhZL8EcN4DQy21ujsMes867zapLEsHDJ2Ptlr5L/bQWrc+bwHuC1TfCzUvBxSjZRxZqusJYT6VDSPpgJ3uxIpmqydmyEuJkKQpcv8XArxowek99vSaJYxkhcwPNoPIXwebkMGIrV4GmHf6MBKRapFRPd46ZYrxBsC6mdday9ibZcBZI5tTSgL1I/LXaC4Yhk23QDkCtWjL3iQZ8hPa7LGO4u1CuNdIPsOnO7NhyvKyQyNhwsISeEUqojgYljA90iCDFeM4/bOaBa4UQAlqQpfSxhnrn78Hmp7GVuxSowEYG8+NSh60g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUGIwTQQ16mQyOVHaZ5AGqRPRjtITENGHLYhI0GjqT8=;
 b=EKvyn1xsUI7J1cmamuqYQtGFNoJCPeQKZhbawomyAiVpc9r+XrlwHDB+7dVSms/4xSLvFpi8QwYzesrOmT5Ewais5sbJqLbQHoit64kV9TpNZ5n4XDX7Iz3R/pRpy8iHFifyiOkSTCSgJhqaXFLX2mr9pLZNijUURSZRy4vMZ9XWqutZ138p+bGHUu0chkBzwl6c1RL320OI7tE2kpfVPBUfXepRCuoG/uIRWS91/H8IPkbkXOW48nrjBU71v0nLwPVXfqG/IR/sQdERnhFtUAZZX3M0KhbsLwOYTuL3v/3PaCLiOP6AimM+YF8+qKbZLwJSnZINKKOwIldzaheXHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUGIwTQQ16mQyOVHaZ5AGqRPRjtITENGHLYhI0GjqT8=;
 b=IbSIw/36zQj971RvksKtX22+x4JWJA9+SoNGQzWJ8R53GS/auQ9lsAO2N+TN8Ba697nIhdzduwt3r+msFad0IIpAu00suXNHNXw+heLF5y2X5iaMFDN79rL/YQjbKWzarRHJOO5XbaqXLZ5idBSn0ld73q2MaVtnT7u4zxaTba/SJvuf5IjIAN4UmkLQQXpTTPEjG0QetJUpLHHHcBNFlW/f3mtoEmKSbtOuaHBE7jysVClbvYlwrhBmvd4+JHiQHkGqzeurX/xsBW8smQE0ccD5pHMC8ODcZfh8Zi/g9bgUtfr1r6lcTe5df0DbR3qR+NFz2W3e9gMmrJ/CCBkgBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM9PR04MB8666.eurprd04.prod.outlook.com (2603:10a6:20b:43d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Tue, 6 May
 2025 22:29:32 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 22:29:31 +0000
Date: Wed, 7 May 2025 01:29:28 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, upstream@airoha.com,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Joyce Ooi <joyce.ooi@intel.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	UNGLinuxDriver@microchip.com, Wei Fang <wei.fang@nxp.com>,
	imx@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [net-next PATCH v3 05/11] net: pcs: lynx: Convert to an MDIO
 driver
Message-ID: <20250506222928.fozoqcxuf7roxur5@skbuf>
References: <20250506215841.54rnxy3wqtlywxgb@skbuf>
 <20250415193323.2794214-1-sean.anderson@linux.dev>
 <20250415193323.2794214-1-sean.anderson@linux.dev>
 <20250415193323.2794214-6-sean.anderson@linux.dev>
 <20250415193323.2794214-6-sean.anderson@linux.dev>
 <20250506215841.54rnxy3wqtlywxgb@skbuf>
 <50e809ea-62a4-413d-af63-7900929c3247@linux.dev>
 <50e809ea-62a4-413d-af63-7900929c3247@linux.dev>
 <20250506221834.uw5ijjeyinehdm3x@skbuf>
 <d66ac48c-8fe3-4782-9b36-8506bb1da779@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d66ac48c-8fe3-4782-9b36-8506bb1da779@linux.dev>
X-ClientProxiedBy: VI1PR09CA0153.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::37) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM9PR04MB8666:EE_
X-MS-Office365-Filtering-Correlation-Id: 74fb2eb2-ab59-4690-4285-08dd8ced78a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Skd1Ppy1bns/XC47hyXDBTaIjY2miTQA7eXHbn448zO9AwV8Sv0CyqHmspTk?=
 =?us-ascii?Q?VO2qP5lQww+4MvBGK1wIvSimI15nGrNSqdFXFVV1VMXgYHojJ1WDc8T5oIeJ?=
 =?us-ascii?Q?xhpXqQsgtGRwFW21njxpHSXSIU0CnNqGfK76QJuoRm5YYvow+r05cUNbDoJF?=
 =?us-ascii?Q?fCgwDrmTvuJvcEoYkMFY0cQJ+bftJA+4C0Ga8rqQ4GXbtwoKkz85MyV0eKfb?=
 =?us-ascii?Q?VKbE9/0kcHogALqAqQ6s4QE7nDnoMHnpp1f848TT67NxPRCZ348Y0US6dDvk?=
 =?us-ascii?Q?6Wl4ifIB7ue3LyWacaFEyYbLuhPNk0ayJHs/OkYeuyXZdvWilkfvsoRyHngR?=
 =?us-ascii?Q?aJKFsCT+DyrmSgKFHqH4Bp12Y6Pa07rWfWxiTooIkXu7oHVF0JyDuBglTKAm?=
 =?us-ascii?Q?6PfYN9zjNJI1h53Kaw+wS2OiptGRg2lYaqQ0DiuqlO0c1r9kYNe9b9uaZ02Q?=
 =?us-ascii?Q?gzqLWk48EdyPTCQ8mnE+xNNJs8zmC2JQ4u4DSOBfRKDCDGTnPig3uayiz2YW?=
 =?us-ascii?Q?0yQ5Yi40JH1egUXzP+YtemD/xLG5Iz/sbPG3kgwFypE9JN2gex7e6cqxq76L?=
 =?us-ascii?Q?fbrj4SopU2dBhoVG9yOr3Sl3fswT2Uh5MnwjglZGaequ39q5HWpXwL/6HBGG?=
 =?us-ascii?Q?oclAMfB+60PL8kW0+0qVl3qy4Brld063cKl6UowFuM0eppUT0Gx7vQT5PdBO?=
 =?us-ascii?Q?2tA/lwIEbZyIRWFN5W5RmuQGgrTDdKFddDudI5SsQN443mITrXa32LJyBjPC?=
 =?us-ascii?Q?wfvEHK8Z8kZhzd/cMOvXI6L5qliJCUVmRxRjC6YxgUbhVRAUWnu+JHMgMp2Q?=
 =?us-ascii?Q?Otlrd7sQaCZtjcsJO5O6lY2Sn1+hop0JU9ZrFG3ZIJ9YvUAhFv3lOmAD7iCR?=
 =?us-ascii?Q?UND860Ppk+T8W2E0X/tjx0H5YBqpLQJQ15uE+ZgcYnCpvjm5x913N7EE1Ism?=
 =?us-ascii?Q?Wb0Hm8NEF7/EZSI2EMyWTVtLzzpxhB0jCcOnBjY922k4E2gt69YRyi/u2gGM?=
 =?us-ascii?Q?Atq0BvTuNq7/QfzVMBS5s5y0PhUhgEITRn3D71SnJ4aTC1c80YHWPJ7xPt0d?=
 =?us-ascii?Q?sG7dn7yya18MJaUML11tF1+7FLnjbowHKT1V201s/obUfCLcUeQMlUu0KWtd?=
 =?us-ascii?Q?xKNOCiP/OyGvuIgNEi//XLwJs7JhfhaY+Sj8Y6B78nfoY/6ENyo5qaPTo/V+?=
 =?us-ascii?Q?KTjCx+UoVhhhelgEwYwupQjPfmFINHZwmAgU4EVEBLO9hNzackA6p2mcPQ6j?=
 =?us-ascii?Q?tJ2wBCX+1gcy/kFGheTB4UKQFG2okKNiQ4rcDyj5mor/8qA+LjMmuEdSECrZ?=
 =?us-ascii?Q?LMBUMBs4dSo+BBFe/QI2o65hDhnR4YA+iLbrbX1M+pCHhiL0IKfREKRW3rCa?=
 =?us-ascii?Q?he8sEWX6K36hjEaSblVeKLitAk81oxau0GcED5xX4mcwBn1+aZxHJBSc0fFc?=
 =?us-ascii?Q?uGcw2R72D00=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1+h5ihSHIhhJ2sgY/zphcXR01rE8M1ctojsIzh7MqqbW+3mjm2X0SORMj0ms?=
 =?us-ascii?Q?u3n9b0rD5NVnW9jO0N4GnSypac2yOOT5XosiIWlylbOoleijbRI53wUn8WhM?=
 =?us-ascii?Q?U1zzOvOh1WKdPIz/kgp4DolS/sEk35RYcn3jmR6u3Pis1YuCbDHtH5bf/xDl?=
 =?us-ascii?Q?BNpIHdboO2I6NeZAjwhXCnku9TO8QgT298aBwy7wkF507RQ03ClBkoCVX5iR?=
 =?us-ascii?Q?JYCg1hy4Lq+sco7cSnATs0D4j6UVg+9Hup3t47BZJzNuQbApRbmrat8eqbHt?=
 =?us-ascii?Q?YZa9w7RqdCnFcyMp0zlTUUsEFgCe5lw7gcSAOScozV6YZAuBe+SIxDg6V77R?=
 =?us-ascii?Q?4nu9T5A7yAjl8X60dj2KZdDkXnRlx9QzFx1z97QZiFQNs5X2maw2gyQi1oAK?=
 =?us-ascii?Q?HuzjrUSTumO0Rp0aYehrSeu7C44NTcN3ZSVS4vGXCIcSeArictphKnXNibnf?=
 =?us-ascii?Q?xZgDB7fANv/UoFBQ1ejbxxvrgR3gickAIi0O8DANFMS7vgHV1fkm/ToI+IgX?=
 =?us-ascii?Q?ErQykFEhhakdFzvL7imMmkKKC+fZoQm3wCJVa4t+NQbmuefL8yEqF8jwr8iT?=
 =?us-ascii?Q?cREuE78Sl5UkpCZo1FNh4Sc2oe0v9n8+t2MtWH6kKiFtXzxYngqd58xfLu43?=
 =?us-ascii?Q?dHhRmsKqP/eYKc7LKzSAd07kWT5vgzgAcc2j4ap6ISA8Ccn5/jXsIu18rdOG?=
 =?us-ascii?Q?VH/Q9TimCb4duiK+kNtEy1U/wj8+FvBwbRwRCzTv7MxKsKM0h21hMgeAiKQQ?=
 =?us-ascii?Q?Nloikzcp8yfAA32pWLcIvAnJCHe/MJ7pLFC2QWvCMmZbsEnFkpubQIAZbv2e?=
 =?us-ascii?Q?R0y6MdjB3gwipJQNlMi6LsF8Ytm9xhUhhLxIXId2ZiQMpW1DmEwb0jlrvE2v?=
 =?us-ascii?Q?aEvPAVKzbjtRTAm17u8Xh03qBkLlHPgCAqb+B+vxVmq3PsRLb3TSxU/p1W/P?=
 =?us-ascii?Q?u0Zl0WZIohY5nlfy77fZjXrhMSXelxQx/Q2UzqohGQ4KAPOSowJ7mqWlBFxC?=
 =?us-ascii?Q?sf4F6/OuM9R1pzY9cukXLIDmsbGdAwDjaeqZERq3Jjgmz1gwdXZuNIIiX0hv?=
 =?us-ascii?Q?mlCw70xL+M4NjwCao3c6Xa7+WYO/htlNPh6E0YxmBxbez4/iwq9DOyHK5fSF?=
 =?us-ascii?Q?4BQn2DbbYosvrfsBUs3f8DZKt4sdfiXo3KLzeK2vV8hhAIdg+PsGKbS1ugkP?=
 =?us-ascii?Q?9LMQuIXpAUfZDuuuZeETyBZVqWrBd1o36ze8nimqPOHX0HjXjZpoDaLi/w+Y?=
 =?us-ascii?Q?1BhCev+HYtB+N6hoCAf7luT53X9qVqFhPffa2pmf/7joUUR2VlCuyCtihxu/?=
 =?us-ascii?Q?cygE9NSK6v6mbQHTzInv2Vz17fOWjuN5md3Uj0ovDiIH4H2tOvL4MxakF0Gr?=
 =?us-ascii?Q?iIFCxpr8CYQ1xuh6b2cc5OjuTGF8fomhQXzRLlS7rQGgE26y2mDfyGm0XtFc?=
 =?us-ascii?Q?t23XpUQD/SEmK4uWP5QdLat1fQL/zoiMrhBJxLmMa21akxYPt9T/EtYlAsFf?=
 =?us-ascii?Q?WOeFkPjRMoPo8KR6dx8tHVExEdN+njwHDFU5utkeEXL1eiBsG7cdAtgfrWhL?=
 =?us-ascii?Q?a3FUMh94X121u9oa6TEHBPq3150tE6DKQ6DUGvpq0gwKd35wt83T+C/iBuuH?=
 =?us-ascii?Q?qw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74fb2eb2-ab59-4690-4285-08dd8ced78a3
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 22:29:31.8679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNs5ZP9DYznOHykesEBA0BKdIE0Ne1Jjkpblg78ArrvKcW6h03562prtUZUiZ82p97+VpVHD7v4aXXDPDTmgiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8666

On Tue, May 06, 2025 at 06:20:32PM -0400, Sean Anderson wrote:
> On 5/6/25 18:18, Vladimir Oltean wrote:
> > On Tue, May 06, 2025 at 06:03:35PM -0400, Sean Anderson wrote:
> >> On 5/6/25 17:58, Vladimir Oltean wrote:
> >> > Hello Sean,
> >> > 
> >> > On Tue, Apr 15, 2025 at 03:33:17PM -0400, Sean Anderson wrote:
> >> >> diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
> >> >> index 23b40e9eacbb..bacba1dd52e2 100644
> >> >> --- a/drivers/net/pcs/pcs-lynx.c
> >> >> +++ b/drivers/net/pcs/pcs-lynx.c
> >> >> @@ -1,11 +1,15 @@
> >> >> -// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> >> >> -/* Copyright 2020 NXP
> >> >> +// SPDX-License-Identifier: GPL-2.0+
> >> >> +/* Copyright (C) 2022 Sean Anderson <seanga2@gmail.com>
> >> >> + * Copyright 2020 NXP
> >> >>   * Lynx PCS MDIO helpers
> >> >>   */
> >> >>  
> >> >> -MODULE_DESCRIPTION("NXP Lynx PCS phylink library");
> >> >> -MODULE_LICENSE("Dual BSD/GPL");
> >> >> +MODULE_DESCRIPTION("NXP Lynx PCS phylink driver");
> >> >> +MODULE_LICENSE("GPL");
> >> > 
> >> > What's the idea with the license change for this code?
> >> 
> >> I would like to license my contributions under the GPL in order to
> >> ensure that they remain free software.
> >> 
> >> --Sean
> > 
> > But in the process, you are relicensing code which is not yours.
> > Do you have agreement from the copyright owners of this file that the
> > license can be changed?
> 
> I'm not relicensing anything. It's already (GPL OR BSD-3-Clause). I'm
> just choosing not to license my contributions under BSD-3-Clause.
> 
> --Sean

You will need to explain that better, because what I see is that the
"BSD-3-Clause" portion of the license has disappeared and that applies
file-wide, not just to your contribution.

