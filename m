Return-Path: <netdev+bounces-216533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B68B3453A
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 17:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 627B13B265C
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 15:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1CC2FC867;
	Mon, 25 Aug 2025 15:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="P3U26pkS"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013050.outbound.protection.outlook.com [52.101.83.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496292E0921;
	Mon, 25 Aug 2025 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756134411; cv=fail; b=F+AeCsWJN7lfs9L/341aTrC2mAWO+ckKvDv7IVzXBGTPFXHdpyl3Ob9OG+5kQxxxntckSbwQMXEA2I2WS6nI0mEEBNPbn41DIXJfPWzZCVoGIkzX7dAu9qyx6VDl+czo0VjEDQXugsEHBuSkSOh67DYuOkDEq65cpNYHqJMOk3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756134411; c=relaxed/simple;
	bh=txnzaTYScByfAXGQhsYvXyg0aWJxbbTFBhyUdtvjJcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EPWpi/pU/apnad2ZvFIssFZNv/fB6LyJyumU+3kAe8IWB3XnsKSUGa7PVVOlcNv/Kp01UTrVs4+euWFFNxynSUq1sutug2OAmNZZWxjHbasGiUYIcFTMIs4qJSSSe244Zq4dXoB8ziyuKPAl0nzsSAbdAD6EgfHp1fpuCOWji6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P3U26pkS; arc=fail smtp.client-ip=52.101.83.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=smXAiRQEqcoJNm3q510KNfcFdte0lzvbaZiFkGak/ELFYvU9b13W5Ec4gfubyma+nSdMD85TamMJ3k2OHVgPV18C8oJfm14SHSKUiQLajHiCApggrAd4SZ91hTgwghzPkBcWPmK0iXnCtgxJpgBvBngjM5HFjsCpPfisJ251k46/W0eMRQoHR7ZRxLxB6XDiW7J3scIecAGDiDziThub5IK/o0EST+plIio1s3+rBpelShmzP6jC/jynuRwStwESP8CpjDYCBb/GOUu7nDscwp2Dtrog6zms6Frln2S9LOqOjLylC3X6OoKq1nKNA3hkoXIyhmUJJ1olLIsl66CDMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jirwrUA3Ztkrb+iDWN8oyFRoA2SeITQ50DdR+gJCPik=;
 b=rhbe1NNqDsmygA276zE1FwmZM/D6lHD1Kq6JAz4EAX/FD9vKj9otCk2IV2J5sIn7oAXftNx/THHOg2YR1oNpiCX7sWgZgIMVdLk4AFyCDysurillq5uFfQYjsmYQ2lxKWFbGEST2ysJaCNmKau0ZhI5Fj0nmgmDY/5o/7O+e7YdK2o/x5K3WhMgDQt5rsILdePfoiRGmu0pdQcY9+vywv9MZiQROG8aQO4v4OSW/7Ka3anqIzNETd0c735YX+wyI4PxHw+m0tRaHd5pDSynmZ82+CXnu+NMGXgTrs/haqHHMDhXy0KvyOQuysBjz2z5okfIpdPmfsJCgn7EG8is9mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jirwrUA3Ztkrb+iDWN8oyFRoA2SeITQ50DdR+gJCPik=;
 b=P3U26pkSBGp/7X137W0wtgqEkPJW5yLt4tqySx1FSM2G93JR2vK4aMJ6xhdltCAI4OlxzIAgGS03aOK7nVqNZZ5p6ztiRDS81RyNhllWapUlb7g9Wq2e8wZ6+hW4BgaDln3bOlysjhtK7PFmps5Hm4LXQNqzi+Tq72HSwRfSG1IE9ayWk1trx1wq3LJ/bhSU7071StEzz6QpWpW0zORYgKPAk47NnixbFKeT/ngEE5iSJtekVoBhpNqHFrS/pgAhyvAx+8tXowBgnqpy+X1w44wRMRGZjUfSojrktCFILAnU9Ueqi67EDiTeDugtJ5NiCkch2LtBuztS4itk1yRG8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by FRWPR04MB11152.eurprd04.prod.outlook.com (2603:10a6:d10:172::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Mon, 25 Aug
 2025 15:06:46 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9073.009; Mon, 25 Aug 2025
 15:06:45 +0000
Date: Mon, 25 Aug 2025 11:06:34 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	richardcochran@gmail.com, claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
	fushi.peng@nxp.com, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v5 net-next 04/15] ptp: netc: add NETC V4 Timer PTP
 driver support
Message-ID: <aKx7+i9YQA4oweL7@lizhi-Precision-Tower-5810>
References: <20250825041532.1067315-1-wei.fang@nxp.com>
 <20250825041532.1067315-5-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825041532.1067315-5-wei.fang@nxp.com>
X-ClientProxiedBy: BY5PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::23) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|FRWPR04MB11152:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab81d24-4a85-4e25-5d3b-08dde3e901f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p5LPinbYVJpld2o6vdt/vC9oIkBPpUXiRSHac3ryTlIOV1R9ygY068wn8HMW?=
 =?us-ascii?Q?tsiDK+R63Dqxekyp0IXuYmejwFvMvR56luBWC4+IjPjulm7Y2JGnmIXVjG3d?=
 =?us-ascii?Q?t/fQZ7ogO4u2XdEtVqY0Xjmik1sOq+WIjOBkcMUFf+a7I0QkxSTIGwO5yJtU?=
 =?us-ascii?Q?dshgE0hJCIZp4rUuf381v/98/fcjXakuAK7Q3MRjkjXa84W68jpBe2eALkPX?=
 =?us-ascii?Q?fmgOsaxT78RA99XnTlT7jYevRPMAm0Srbz7HPIjOumcJgTIK9CpJtVIu5Y9w?=
 =?us-ascii?Q?YO5bOQFRCZRMr2obonEYY2TPHQOgjpCasiVoHamGA43SCPVeydY0nMJEMDT/?=
 =?us-ascii?Q?D2nQ9TzNfIvyF2eFtQEjc3wb0zfvCBQe31cFFGHX5LdH6b/FbvJpGdGiW6PG?=
 =?us-ascii?Q?ga5ptl3OaBeb0VVM9x+TBWqU/yJ6jnbRkHJJ3dEhtrmQa7JfKTctytv4nJjJ?=
 =?us-ascii?Q?G1dnoFtvVNVj7/2+q1IzrJqL05Np0MyleyEVmRVpPE7gWOODVQyjakim3Zgr?=
 =?us-ascii?Q?KMEO15jfeO3Se9wEHgfqega3dg2cPBsSdFH7Sgnht2mePAwnfe6DziJ0HsP/?=
 =?us-ascii?Q?rEaUnOqOwLLiDBbBxarghZEPK2QSNuytE94Dkd6sUjVoOI4umsJu7AEUcsj7?=
 =?us-ascii?Q?frjnEuw6kKJGSsZTiDOpxC+xeiRJ4Gs4RNPJwi2CjzbhFLDJL2rnDkL6HzMH?=
 =?us-ascii?Q?47b7lF6GWBKosA2+nTKdxDT3pP+dl0hSQCnqebsLsHsaUlSvOyOtX3z98cBd?=
 =?us-ascii?Q?xbuV6RWlvWxUksVhqX9SWtSv4lHXYtCeHDuGObGiHRW5zWU6FxnMajMo182M?=
 =?us-ascii?Q?jWf+wqooprpkup3BIVB5K57rZ8yCmc/VuUdGvKzd4m09dbJbDOK8pbGSXvCs?=
 =?us-ascii?Q?pCaP5s3Iong3KHggVBeeRWOrhm8MTw3OXW0Fk9FEWC0Yu+gkUs3+6S6Y38TL?=
 =?us-ascii?Q?qg2bZbLlhOeWMQ1jOyNbBXNeNwgyipf6shnXFiRzAF9kiDbVUOS51TYL1WIn?=
 =?us-ascii?Q?FYjNOj5Tv4X6cesAxDdtisnbN/pUstL9bCLhqor0GQhEwoTnc++0YQ1T3mHF?=
 =?us-ascii?Q?M7j4BwMJ4Y54vyOOBKA1XlSD0Ih4Zdo+AF0U1cz7Ed/mjaCi964WACw4M4Ov?=
 =?us-ascii?Q?61mYnQiC/HJ7J1/b5lJOgjDEfw3q1l7tRYxxAMaf1SfdSAxu9jwHGx42kkVU?=
 =?us-ascii?Q?BAhlH4QuI8HSjXwrrhsuRFY5dVCyNpwZYU2Qe24+2GdA9LMjxTwywfpiVQ7+?=
 =?us-ascii?Q?TBmSVnYSYCJecf/NrGIBmq4QawZmvoERBA8MOoolAqGUa+Y6HUwXghhWQKDY?=
 =?us-ascii?Q?WPdctYfKS1aLDd8NTNLdD/BAm16yCqikEPUo1ngcI5MkLGFHImVde4zmSJAu?=
 =?us-ascii?Q?z2ElUmsLetgCIkQevSdCU18dT6idvoF6pTCtIRHwBmSjxOpkmdbp4FZqnsFp?=
 =?us-ascii?Q?W26DEngEwlqJQHrhiWsZhLgdflDfIHEOQ1TB/o2MyCuyhLvPFm21EA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y7C04Mbwl6uxtkHz3dDsRHN0e0+c2FhsKBtTNvOGad35COm4VsWqecqpyScS?=
 =?us-ascii?Q?NuQ15fZG5GC2OC5kC5Y+7oBXHkVp/FH4hnxQjS9ayIzqFT2cmK2mPy+0GtGz?=
 =?us-ascii?Q?lss4yHVBtQYgUjsKETvlEPjxoHs0yLWgsFnL2UiKrxYgQ6Vk8pvO5pyV3z5A?=
 =?us-ascii?Q?PQckfahYikYkByIh6ndKmvibi0pwV0izGch0vzRhK0099H29Ap4FcyTiC+IG?=
 =?us-ascii?Q?FT9DhgPkD/Ott1hOi9ZZOQoN2U3UFYMf6FfQsHxfwUPeE7uKINYEPZ3nDPth?=
 =?us-ascii?Q?GwzgPUWXaVQpslhPDVI7G5fWTf2OKMvV7fkzz2L/+2aDtbobGVVBeJ+Y3jHg?=
 =?us-ascii?Q?MHCT22SSzt6kBz5s5RwtNIjcGT4g17vgyiSpKcdfrS7SKokFtDZTllpMGt1f?=
 =?us-ascii?Q?UtpjS4B2/59QP7JtxiBV4B9vU9nxV5MMRD+uCcxGDhmCQgqXCkUof7z4MIF6?=
 =?us-ascii?Q?EF5scvB10BT0vIYwB/bNOWlAbXhXz+AoqNQ3Bo0l/ULCGFi/hSi+RSi1TijQ?=
 =?us-ascii?Q?qRabIROJmbTtoNRo5/2snJp9dSKainxZdE+orOlq033nZBpw1HAhVBB6iLBW?=
 =?us-ascii?Q?ZrU9f+RP+1KQgofQwgB5F1yueSc2F9tKb6OiNUNtMiiVhTmAE4oPiMygS/Jh?=
 =?us-ascii?Q?WD44T7Rk8ihGZg7ys287tb/Fko4PIvG3fSuZd1dIxaiQX56YjuB0YBibsAV/?=
 =?us-ascii?Q?o544AJysyKi4gHqPXCt8Z98omvXOeuuS0M1K6ziOyB4x1+dGlzRbD/zkbfqd?=
 =?us-ascii?Q?8C8VE+TJEjq07CPmug6gX+skyqd+xPvkO4eMLgQ+C94ado9/Sizj4Wew8QuX?=
 =?us-ascii?Q?Fu+INXXdP9BcnYBKhPaIPclCe64jILcboO9qGAMAmtacMni8SnWSQteKNqUn?=
 =?us-ascii?Q?zo3w8QUHuF8kuCQiI838NrQ+8H6G8tr7dgdGFKY3lOEqD0SbWA5zRSomInzF?=
 =?us-ascii?Q?JGvLo2I55E8bq5tO+mZXuGrYHzWbIkMYiS5N25YmXS6rKwx9tZbgbMIQr8sS?=
 =?us-ascii?Q?4g9CJ/i55BaKYZSRAGEpj8XBimEv6o854uvN/mIuKmQobpxlRflS4IhNQFdc?=
 =?us-ascii?Q?YEaKhZ+ZbdVndqBksDiQCfuz4J1Gq2U4bDQiVCQNtWufrYVjetXRC5OwUkZG?=
 =?us-ascii?Q?Pd/r4XOnd02IwBtSi2fM+MAUEF6jpTboL5DG8fddKvKzWk6e/5Hdaz8kV9dj?=
 =?us-ascii?Q?61OH8zMS1xc1II20uCv+klBry385olUMifUzos8u86np3U7Oul8pgPVG8DbF?=
 =?us-ascii?Q?M3rVQIg8hTiXVHbMYsqI8zzuFOX0YJ9ZHOikTo1BQmzm+euEiLrbJLB4x22s?=
 =?us-ascii?Q?rPHnq18kHQKwTVZTc3wawCIq9e6sMjlpkj/CkIaB7OvirHXu2x9ozWOHOuSj?=
 =?us-ascii?Q?eRObP5N7DIIDDE7jGe1VQnLXbgYwHcXjPK9ZFmsXbzRxK2UcRzTFw3emg4dl?=
 =?us-ascii?Q?ogOwiQU3b327Mkfjpbq4XNJGSPP/1B5A/Y2z7Cdn3XbbnK1GbEqVCGYwFQQ9?=
 =?us-ascii?Q?vFxM3H/RvwPO7GucmjmpDuAgz63QIofUQYh1ttdZlsrUA8N/85pGUVkxO8Jn?=
 =?us-ascii?Q?FXMY1QAElp95gDr/Aec=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab81d24-4a85-4e25-5d3b-08dde3e901f2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 15:06:45.8944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Znzz3gLWJnARpz6x3jIV3Rf2/l2I3KPSdp4s0gq0gd2jLdfp+oHnSoPr2gulDkvUhOcYeI9YZ+41a9hJmu7Wmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11152

On Mon, Aug 25, 2025 at 12:15:21PM +0800, Wei Fang wrote:
> NETC V4 Timer provides current time with nanosecond resolution, precise
> periodic pulse, pulse on timeout (alarm), and time capture on external
> pulse support. And it supports time synchronization as required for
> IEEE 1588 and IEEE 802.1AS-2020.
>
> Inside NETC, ENETC can capture the timestamp of the sent/received packet
> through the PHC provided by the Timer and record it on the Tx/Rx BD. And
> through the relevant PHC interfaces provided by the driver, the enetc V4
> driver can support PTP time synchronization.
>
> In addition, NETC V4 Timer is similar to the QorIQ 1588 timer, but it is
> not exactly the same. The current ptp-qoriq driver is not compatible with
> NETC V4 Timer, most of the code cannot be reused, see below reasons.
>
> 1. The architecture of ptp-qoriq driver makes the register offset fixed,
> however, the offsets of all the high registers and low registers of V4
> are swapped, and V4 also adds some new registers. so extending ptp-qoriq
> to make it compatible with V4 Timer is tantamount to completely rewriting
> ptp-qoriq driver.
>
> 2. The usage of some functions is somewhat different from QorIQ timer,
> such as the setting of TCLK_PERIOD and TMR_ADD, the logic of configuring
> PPS, etc., so making the driver compatible with V4 Timer will undoubtedly
> increase the complexity of the code and reduce readability.
>
> 3. QorIQ is an expired brand. It is difficult for us to verify whether
> it works stably on the QorIQ platforms if we refactor the driver, and
> this will make maintenance difficult, so refactoring the driver obviously
> does not bring any benefits.
>
> Therefore, add this new driver for NETC V4 Timer. Note that the missing
> features like PEROUT, PPS and EXTTS will be added in subsequent patches.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> ---
> v5 changes:
> 1. Remove the changes of netc_global.h and add "linux/pci.h" to
>    ptp_netc.c
> 2. Modify the clock names in timer_clk_src due to we have renamed them
>    in the binding doc
> 3. Add a description of the same behavior for other H/L registers in the
>    comment of netc_timer_cnt_write().
> v4 changes:
> 1. Remove NETC_TMR_PCI_DEVID
> 2. Fix build warning: "NSEC_PER_SEC << 32" --> "(u64)NSEC_PER_SEC << 32"
> 3. Remove netc_timer_get_phc_index()
> 4. Remove phc_index from struct netc_timer
> 5. Change PTP_NETC_V4_TIMER from bool to tristate
> 6. Move devm_kzalloc() at the begining of netc_timer_pci_probe()
> 7. Remove the err log when netc_timer_parse_dt() returns error, instead,
>    add the err log to netc_timer_get_reference_clk_source()
> v3 changes:
> 1. Refactor netc_timer_adjtime() and remove netc_timer_cnt_read()
> 2. Remove the check of dma_set_mask_and_coherent()
> 3. Use devm_kzalloc() and pci_ioremap_bar()
> 4. Move alarm related logic including irq handler to the next patch
> 5. Improve the commit message
> 6. Refactor netc_timer_get_reference_clk_source() and remove
>    clk_prepare_enable()
> 7. Use FIELD_PREP() helper
> 8. Rename PTP_1588_CLOCK_NETC to PTP_NETC_V4_TIMER and improve the
>    help text.
> 9. Refine netc_timer_adjtime(), change tmr_off to s64 type as we
>    confirmed TMR_OFF is a signed register.
> v2 changes:
> 1. Rename netc_timer_get_source_clk() to
>    netc_timer_get_reference_clk_source() and refactor it
> 2. Remove the scaled_ppm check in netc_timer_adjfine()
> 3. Add a comment in netc_timer_cur_time_read()
> 4. Add linux/bitfield.h to fix the build errors
> ---
>  drivers/ptp/Kconfig    |  11 ++
>  drivers/ptp/Makefile   |   1 +
>  drivers/ptp/ptp_netc.c | 418 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 430 insertions(+)
>  create mode 100644 drivers/ptp/ptp_netc.c
>
> diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
> index 204278eb215e..9256bf2e8ad4 100644
> --- a/drivers/ptp/Kconfig
> +++ b/drivers/ptp/Kconfig
> @@ -252,4 +252,15 @@ config PTP_S390
>  	  driver provides the raw clock value without the delta to
>  	  userspace. That way userspace programs like chrony could steer
>  	  the kernel clock.
> +
> +config PTP_NETC_V4_TIMER
> +	tristate "NXP NETC V4 Timer PTP Driver"
> +	depends on PTP_1588_CLOCK
> +	depends on PCI_MSI
> +	help
> +	  This driver adds support for using the NXP NETC V4 Timer as a PTP
> +	  clock, the clock is used by ENETC V4 or NETC V4 Switch for PTP time
> +	  synchronization. It also supports periodic output signal (e.g. PPS)
> +	  and external trigger timestamping.
> +
>  endmenu
> diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
> index 25f846fe48c9..8985d723d29c 100644
> --- a/drivers/ptp/Makefile
> +++ b/drivers/ptp/Makefile
> @@ -23,3 +23,4 @@ obj-$(CONFIG_PTP_1588_CLOCK_VMW)	+= ptp_vmw.o
>  obj-$(CONFIG_PTP_1588_CLOCK_OCP)	+= ptp_ocp.o
>  obj-$(CONFIG_PTP_DFL_TOD)		+= ptp_dfl_tod.o
>  obj-$(CONFIG_PTP_S390)			+= ptp_s390.o
> +obj-$(CONFIG_PTP_NETC_V4_TIMER)		+= ptp_netc.o
> diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
> new file mode 100644
> index 000000000000..5f0aece7417b
> --- /dev/null
> +++ b/drivers/ptp/ptp_netc.c
> @@ -0,0 +1,418 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * NXP NETC V4 Timer driver
> + * Copyright 2025 NXP
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/fsl/netc_global.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/pci.h>
> +#include <linux/ptp_clock_kernel.h>
> +
> +#define NETC_TMR_PCI_VENDOR_NXP		0x1131
> +
> +#define NETC_TMR_CTRL			0x0080
> +#define  TMR_CTRL_CK_SEL		GENMASK(1, 0)
> +#define  TMR_CTRL_TE			BIT(2)
> +#define  TMR_COMP_MODE			BIT(15)
> +#define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
> +
> +#define NETC_TMR_CNT_L			0x0098
> +#define NETC_TMR_CNT_H			0x009c
> +#define NETC_TMR_ADD			0x00a0
> +#define NETC_TMR_PRSC			0x00a8
> +#define NETC_TMR_OFF_L			0x00b0
> +#define NETC_TMR_OFF_H			0x00b4
> +
> +#define NETC_TMR_FIPER_CTRL		0x00dc
> +#define  FIPER_CTRL_DIS(i)		(BIT(7) << (i) * 8)
> +#define  FIPER_CTRL_PG(i)		(BIT(6) << (i) * 8)
> +
> +#define NETC_TMR_CUR_TIME_L		0x00f0
> +#define NETC_TMR_CUR_TIME_H		0x00f4
> +
> +#define NETC_TMR_REGS_BAR		0
> +
> +#define NETC_TMR_FIPER_NUM		3
> +#define NETC_TMR_DEFAULT_PRSC		2
> +
> +/* 1588 timer reference clock source select */
> +#define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
> +#define NETC_TMR_SYSTEM_CLK		1 /* enet_clk_root/2, from CCM */
> +#define NETC_TMR_EXT_OSC		2 /* tmr_1588_clk, from IO pins */
> +
> +#define NETC_TMR_SYSCLK_333M		333333333U
> +
> +struct netc_timer {
> +	void __iomem *base;
> +	struct pci_dev *pdev;
> +	spinlock_t lock; /* Prevent concurrent access to registers */
> +
> +	struct ptp_clock *clock;
> +	struct ptp_clock_info caps;
> +	u32 clk_select;
> +	u32 clk_freq;
> +	u32 oclk_prsc;
> +	/* High 32-bit is integer part, low 32-bit is fractional part */
> +	u64 period;
> +};
> +
> +#define netc_timer_rd(p, o)		netc_read((p)->base + (o))
> +#define netc_timer_wr(p, o, v)		netc_write((p)->base + (o), v)
> +#define ptp_to_netc_timer(ptp)		container_of((ptp), struct netc_timer, caps)
> +
> +static const char *const timer_clk_src[] = {
> +	"ccm",
> +	"ext"
> +};
> +
> +static void netc_timer_cnt_write(struct netc_timer *priv, u64 ns)
> +{
> +	u32 tmr_cnt_h = upper_32_bits(ns);
> +	u32 tmr_cnt_l = lower_32_bits(ns);
> +
> +	/* Writes to the TMR_CNT_L register copies the written value
> +	 * into the shadow TMR_CNT_L register. Writes to the TMR_CNT_H
> +	 * register copies the values written into the shadow TMR_CNT_H
> +	 * register. Contents of the shadow registers are copied into
> +	 * the TMR_CNT_L and TMR_CNT_H registers following a write into
> +	 * the TMR_CNT_H register. So the user must writes to TMR_CNT_L
> +	 * register first. Other H/L registers should have the same
> +	 * behavior.
> +	 */
> +	netc_timer_wr(priv, NETC_TMR_CNT_L, tmr_cnt_l);
> +	netc_timer_wr(priv, NETC_TMR_CNT_H, tmr_cnt_h);
> +}
> +
> +static u64 netc_timer_offset_read(struct netc_timer *priv)
> +{
> +	u32 tmr_off_l, tmr_off_h;
> +	u64 offset;
> +
> +	tmr_off_l = netc_timer_rd(priv, NETC_TMR_OFF_L);
> +	tmr_off_h = netc_timer_rd(priv, NETC_TMR_OFF_H);
> +	offset = (((u64)tmr_off_h) << 32) | tmr_off_l;
> +
> +	return offset;
> +}
> +
> +static void netc_timer_offset_write(struct netc_timer *priv, u64 offset)
> +{
> +	u32 tmr_off_h = upper_32_bits(offset);
> +	u32 tmr_off_l = lower_32_bits(offset);
> +
> +	netc_timer_wr(priv, NETC_TMR_OFF_L, tmr_off_l);
> +	netc_timer_wr(priv, NETC_TMR_OFF_H, tmr_off_h);
> +}
> +
> +static u64 netc_timer_cur_time_read(struct netc_timer *priv)
> +{
> +	u32 time_h, time_l;
> +	u64 ns;
> +
> +	/* The user should read NETC_TMR_CUR_TIME_L first to
> +	 * get correct current time.
> +	 */
> +	time_l = netc_timer_rd(priv, NETC_TMR_CUR_TIME_L);
> +	time_h = netc_timer_rd(priv, NETC_TMR_CUR_TIME_H);
> +	ns = (u64)time_h << 32 | time_l;
> +
> +	return ns;
> +}
> +
> +static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
> +{
> +	u32 fractional_period = lower_32_bits(period);
> +	u32 integral_period = upper_32_bits(period);
> +	u32 tmr_ctrl, old_tmr_ctrl;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	old_tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
> +	tmr_ctrl = u32_replace_bits(old_tmr_ctrl, integral_period,
> +				    TMR_CTRL_TCLK_PERIOD);
> +	if (tmr_ctrl != old_tmr_ctrl)
> +		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> +
> +	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +}
> +
> +static int netc_timer_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
> +{
> +	struct netc_timer *priv = ptp_to_netc_timer(ptp);
> +	u64 new_period;
> +
> +	new_period = adjust_by_scaled_ppm(priv->period, scaled_ppm);
> +	netc_timer_adjust_period(priv, new_period);
> +
> +	return 0;
> +}
> +
> +static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
> +{
> +	struct netc_timer *priv = ptp_to_netc_timer(ptp);
> +	unsigned long flags;
> +	s64 tmr_off;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	/* Adjusting TMROFF instead of TMR_CNT is that the timer
> +	 * counter keeps increasing during reading and writing
> +	 * TMR_CNT, which will cause latency.
> +	 */
> +	tmr_off = netc_timer_offset_read(priv);
> +	tmr_off += delta;
> +	netc_timer_offset_write(priv, tmr_off);
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int netc_timer_gettimex64(struct ptp_clock_info *ptp,
> +				 struct timespec64 *ts,
> +				 struct ptp_system_timestamp *sts)
> +{
> +	struct netc_timer *priv = ptp_to_netc_timer(ptp);
> +	unsigned long flags;
> +	u64 ns;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	ptp_read_system_prets(sts);
> +	ns = netc_timer_cur_time_read(priv);
> +	ptp_read_system_postts(sts);
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	*ts = ns_to_timespec64(ns);
> +
> +	return 0;
> +}
> +
> +static int netc_timer_settime64(struct ptp_clock_info *ptp,
> +				const struct timespec64 *ts)
> +{
> +	struct netc_timer *priv = ptp_to_netc_timer(ptp);
> +	u64 ns = timespec64_to_ns(ts);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	netc_timer_offset_write(priv, 0);
> +	netc_timer_cnt_write(priv, ns);
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return 0;
> +}
> +
> +static const struct ptp_clock_info netc_timer_ptp_caps = {
> +	.owner		= THIS_MODULE,
> +	.name		= "NETC Timer PTP clock",
> +	.max_adj	= 500000000,
> +	.n_pins		= 0,
> +	.adjfine	= netc_timer_adjfine,
> +	.adjtime	= netc_timer_adjtime,
> +	.gettimex64	= netc_timer_gettimex64,
> +	.settime64	= netc_timer_settime64,
> +};
> +
> +static void netc_timer_init(struct netc_timer *priv)
> +{
> +	u32 fractional_period = lower_32_bits(priv->period);
> +	u32 integral_period = upper_32_bits(priv->period);
> +	u32 tmr_ctrl, fiper_ctrl;
> +	struct timespec64 now;
> +	u64 ns;
> +	int i;
> +
> +	/* Software must enable timer first and the clock selected must be
> +	 * active, otherwise, the registers which are in the timer clock
> +	 * domain are not accessible.
> +	 */
> +	tmr_ctrl = FIELD_PREP(TMR_CTRL_CK_SEL, priv->clk_select) |
> +		   TMR_CTRL_TE;
> +	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> +	netc_timer_wr(priv, NETC_TMR_PRSC, priv->oclk_prsc);
> +
> +	/* Disable FIPER by default */
> +	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> +	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
> +		fiper_ctrl |= FIPER_CTRL_DIS(i);
> +		fiper_ctrl &= ~FIPER_CTRL_PG(i);
> +	}
> +	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> +
> +	ktime_get_real_ts64(&now);
> +	ns = timespec64_to_ns(&now);
> +	netc_timer_cnt_write(priv, ns);
> +
> +	/* Allow atomic writes to TCLK_PERIOD and TMR_ADD, An update to
> +	 * TCLK_PERIOD does not take effect until TMR_ADD is written.
> +	 */
> +	tmr_ctrl |= FIELD_PREP(TMR_CTRL_TCLK_PERIOD, integral_period) |
> +		    TMR_COMP_MODE;
> +	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> +	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
> +}
> +
> +static int netc_timer_pci_probe(struct pci_dev *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct netc_timer *priv;
> +	int err;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	pcie_flr(pdev);
> +	err = pci_enable_device_mem(pdev);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to enable device\n");
> +
> +	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	err = pci_request_mem_regions(pdev, KBUILD_MODNAME);
> +	if (err) {
> +		dev_err(dev, "pci_request_regions() failed, err:%pe\n",
> +			ERR_PTR(err));
> +		goto disable_dev;
> +	}
> +
> +	pci_set_master(pdev);
> +
> +	priv->pdev = pdev;
> +	priv->base = pci_ioremap_bar(pdev, NETC_TMR_REGS_BAR);
> +	if (!priv->base) {
> +		err = -ENOMEM;
> +		goto release_mem_regions;
> +	}
> +
> +	pci_set_drvdata(pdev, priv);
> +
> +	return 0;
> +
> +release_mem_regions:
> +	pci_release_mem_regions(pdev);
> +disable_dev:
> +	pci_disable_device(pdev);
> +
> +	return err;
> +}
> +
> +static void netc_timer_pci_remove(struct pci_dev *pdev)
> +{
> +	struct netc_timer *priv = pci_get_drvdata(pdev);
> +
> +	iounmap(priv->base);
> +	pci_release_mem_regions(pdev);
> +	pci_disable_device(pdev);
> +}
> +
> +static int netc_timer_get_reference_clk_source(struct netc_timer *priv)
> +{
> +	struct device *dev = &priv->pdev->dev;
> +	struct clk *clk;
> +	int i;
> +
> +	/* Select NETC system clock as the reference clock by default */
> +	priv->clk_select = NETC_TMR_SYSTEM_CLK;
> +	priv->clk_freq = NETC_TMR_SYSCLK_333M;
> +
> +	/* Update the clock source of the reference clock if the clock
> +	 * is specified in DT node.
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(timer_clk_src); i++) {
> +		clk = devm_clk_get_optional_enabled(dev, timer_clk_src[i]);
> +		if (IS_ERR(clk))
> +			return dev_err_probe(dev, PTR_ERR(clk),
> +					     "Failed to enable clock\n");
> +
> +		if (clk) {
> +			priv->clk_freq = clk_get_rate(clk);
> +			priv->clk_select = i ? NETC_TMR_EXT_OSC :
> +					       NETC_TMR_CCM_TIMER1;
> +			break;
> +		}
> +	}
> +
> +	/* The period is a 64-bit number, the high 32-bit is the integer
> +	 * part of the period, the low 32-bit is the fractional part of
> +	 * the period. In order to get the desired 32-bit fixed-point
> +	 * format, multiply the numerator of the fraction by 2^32.
> +	 */
> +	priv->period = div_u64((u64)NSEC_PER_SEC << 32, priv->clk_freq);
> +
> +	return 0;
> +}
> +
> +static int netc_timer_parse_dt(struct netc_timer *priv)
> +{
> +	return netc_timer_get_reference_clk_source(priv);
> +}
> +
> +static int netc_timer_probe(struct pci_dev *pdev,
> +			    const struct pci_device_id *id)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct netc_timer *priv;
> +	int err;
> +
> +	err = netc_timer_pci_probe(pdev);
> +	if (err)
> +		return err;
> +
> +	priv = pci_get_drvdata(pdev);
> +	err = netc_timer_parse_dt(priv);
> +	if (err)
> +		goto timer_pci_remove;
> +
> +	priv->caps = netc_timer_ptp_caps;
> +	priv->oclk_prsc = NETC_TMR_DEFAULT_PRSC;
> +	spin_lock_init(&priv->lock);
> +
> +	netc_timer_init(priv);
> +	priv->clock = ptp_clock_register(&priv->caps, dev);
> +	if (IS_ERR(priv->clock)) {
> +		err = PTR_ERR(priv->clock);
> +		goto timer_pci_remove;
> +	}
> +
> +	return 0;
> +
> +timer_pci_remove:
> +	netc_timer_pci_remove(pdev);
> +
> +	return err;
> +}
> +
> +static void netc_timer_remove(struct pci_dev *pdev)
> +{
> +	struct netc_timer *priv = pci_get_drvdata(pdev);
> +
> +	ptp_clock_unregister(priv->clock);
> +	netc_timer_pci_remove(pdev);
> +}
> +
> +static const struct pci_device_id netc_timer_id_table[] = {
> +	{ PCI_DEVICE(NETC_TMR_PCI_VENDOR_NXP, 0xee02) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(pci, netc_timer_id_table);
> +
> +static struct pci_driver netc_timer_driver = {
> +	.name = KBUILD_MODNAME,
> +	.id_table = netc_timer_id_table,
> +	.probe = netc_timer_probe,
> +	.remove = netc_timer_remove,
> +};
> +module_pci_driver(netc_timer_driver);
> +
> +MODULE_DESCRIPTION("NXP NETC Timer PTP Driver");
> +MODULE_LICENSE("Dual BSD/GPL");
> --
> 2.34.1
>

