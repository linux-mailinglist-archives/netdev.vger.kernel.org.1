Return-Path: <netdev+bounces-200777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D49DAE6D27
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 18:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A433A39EA
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016E52E3B16;
	Tue, 24 Jun 2025 16:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Igy8dNiX"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013058.outbound.protection.outlook.com [40.107.159.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0292E339D;
	Tue, 24 Jun 2025 16:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750784377; cv=fail; b=FFfgQM3xK1kNNg7RmOr044qqAtpdRtrOakN1u9gBw0Aa3gUo2vp1+gBrkEBLsY+Oil7za+YVUPlNwcsYyyFobLu/NiDOEvDY/OVjC6Sbougye1z9db+qQRE8bA04C6+5CFCM2BD8XUP18muBdqGbfViRPIK2sygyupe3RWi4kO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750784377; c=relaxed/simple;
	bh=hs/auXDFcld6TrkW+H2np3dmzfE5mRYAu3poXVsIC7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nuE/FxZKPVWKPiEbER1U7gVIGQEKFK8bYrnQCkfTbdDmBmiA2NOwfT4T/tguIi7fMzxGLsHPjLJDwb5W7rbab0COH8Ez9jg6W4GlbRVuS6npemjQTtiYHIL7A9MC7mci4q/GcIH+nHtub+J19nEE1KFnlvOIUjleSCdGPVl+EcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Igy8dNiX; arc=fail smtp.client-ip=40.107.159.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rln0qSFLlFfn3opxG9qtB0Nnk0qYjIXB84LJNXXw5CD7e7NLSOf1RmbptUZ6Nf5r7iMHnr+/+XCLTJCF0liIxhyRCKHawKP+35159aCip4w6kteoHJFccEBMrx7+F73ZRc80QsIaVjDZ1BCWp1R5dW8yAhXecEdr4tBQa6WpAcvHI5d3LPKCc0k6BQc7LqyWnp2+ywqIxJJHXJHK9+g02sXxyNPS3KOwtKrcJ3jUrR9xSQw8+oKG70hvh2Qvy/jACg9zkALc72Ijw46dcxnZS1JC0kV4cVag3buxUE9n01Lfh7gyGWNEQ1ib/Y+pNq/j7cuOMQxCkmU2H8NY/U3NUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pD4ESNRu2tTJjAnIvWbzPPsmRItqW7V/JHhUioBd5c=;
 b=FLYyQKpuTdO3SXGg/FFt69x8KSPD0rKWWkbCMl61hbkqCiLMGX0LkWNtvt4uvb5ZkLt5/0JwtmMuBQdMa/P8LXDerq8Yc/DHhsvdI7krgQoZldb7OPJpRQmnT5MDsSLoxnqxdjA4UbrAI+oIGNumQ9n/4AXe5VMV3561scTIw7mQWf1i8GPu47HoL1BwgN/KUp1GbAVOhx2SalWQw0/mSJdHOgHJolL28hUa+3J8qHeEhdlukkSOTAGIWMMyBKvVTYT3/fGytt1K48s+U6tfNNkFBZDbUBO98xveSV92Rtw5sRLMFdT89Die21hcNeSBLtWTtmxgVO2/xgwSByPPAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pD4ESNRu2tTJjAnIvWbzPPsmRItqW7V/JHhUioBd5c=;
 b=Igy8dNiXGH2Tq9Ccj2N0lDhK7DKVXqfkpb8cJq15tqN4+j7zkshpQE/3tSyiYYJXAOTRZHv6liSPEbhoxxOLstSTh/Fbl+ZvIFdfz0l3b5/e6ZdqTgXnmHY7dm8TsqZ5L71mCsc292yNOpjZkbw4qGJW8+c8Pq3rMyr9zLTYmD5GQSOFtTFucKQuiWxHo2kAcEh5aPgg0brhByfpa7BHeWr63WL4gG9VozPZMFwCxyGUbiP1mbAWt1Itnau/Vh9ChEGFioQAxgPldIrcw6qf4qF7vUE86r5SRfcqnig7exfr68MFoIdOO4U0SdKgsYKcZeW0ts1DaXxEI1b0d5uAEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10710.eurprd04.prod.outlook.com (2603:10a6:800:260::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Tue, 24 Jun
 2025 16:59:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8880.015; Tue, 24 Jun 2025
 16:59:32 +0000
Date: Tue, 24 Jun 2025 12:59:24 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 net-next 2/3] net: enetc: separate 64-bit counters
 from enetc_port_counters
Message-ID: <aFrZbEafkQCEc0O/@lizhi-Precision-Tower-5810>
References: <20250624101548.2669522-1-wei.fang@nxp.com>
 <20250624101548.2669522-3-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624101548.2669522-3-wei.fang@nxp.com>
X-ClientProxiedBy: BYAPR02CA0064.namprd02.prod.outlook.com
 (2603:10b6:a03:54::41) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10710:EE_
X-MS-Office365-Filtering-Correlation-Id: a6645f3d-871f-4206-7135-08ddb3407d9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/KZ14UHHwBtqgIqMysKl9QBKglIloG2Ji6tsMd1VQUxmbrddHcGWl1oDCpQq?=
 =?us-ascii?Q?78Bzem3OawlKdzUIj2cdeiYWN7MZZvRlgsCZsxpstfwnJr3gvnWLWXfaTEX8?=
 =?us-ascii?Q?GgmRDJwcfz2sHIjdXSFhksWhfQ5qX4MG4jVjnecSypQSufWfWrHe4Uh2VswW?=
 =?us-ascii?Q?VZA+dEXmVTBa/RtBY3tcmfmxaaOEBNRi+X7fL5WiCuA5IzZN+q+1bpc/6Ea+?=
 =?us-ascii?Q?/2usAy1yqCu+eXMKqmUoAGlAQ/2ZSsmB8HmwJmbXH3PNL0FhDrgBuw6WwtbC?=
 =?us-ascii?Q?j6rc4n/QUjFtCbCrFDAqh6zi7wsV7HChdwOngVR9swKIcwb7dHttmRlcxymc?=
 =?us-ascii?Q?bHpWWivAYaVsdCjInt/iCNWRsrIRJSIe7N4uL5KQ70fFmWYSoEY5rI/SpHIF?=
 =?us-ascii?Q?ZXgO3L5/jJ0Xs1kSg9RaJqHoom8H0enSzC4tEZAiOArPf31iGBOAwvuZ28LB?=
 =?us-ascii?Q?Tfbz9kUyOH3KJimOqH5HF0v9XAHPYdIc4dqvYVNN5ttqCGXzLNj/blmyJMlB?=
 =?us-ascii?Q?Y+wtPWMcz+s4xl9VWF5mT3vfSF3fN8IAMtEHY1YsB2JBxNWdxdREhXgf9/g2?=
 =?us-ascii?Q?jfQ8GzJ9koD8uy/vVlAMYqo3uWbwi2kUxuN0U2NHigmhch9zTWUqhlvicA43?=
 =?us-ascii?Q?sIM94ER43iUQJcKMLF1c8xzYl4oAn/ngiHB7KTCEia9FiuIab5ftsrUhIILs?=
 =?us-ascii?Q?fs65kCQObwnE2XtZhMMuu4p3UPfIZKkzqZxEO0nvfYUAzvIQqlQMSmfSzD2j?=
 =?us-ascii?Q?hl6Z4Sk0EYaszhzo1jPsS/RH0CEIVBDSMX4aXfywWHz/cMnG3EhSDLgXcNkA?=
 =?us-ascii?Q?SgGRDBxKlHZh2j1Q5noNGUVwt1NkAdsiMbvRdCJ9oddnwXMkQt+xJUSB2I4A?=
 =?us-ascii?Q?aU377bll9b/Rc+ktwdSZQtbUtk4jydcp1YG9uJXpmm0NEr7G+6lWbFtsgrQ5?=
 =?us-ascii?Q?pxy8VkYXInMzHzimr6YZ1PpckQwfHzymf8rKFhw1ekQHHbjsr1jLUZPaYj+s?=
 =?us-ascii?Q?0ylWbVApWJNFFEaXEhg1NHEHa2Ws9gR//pbZ0PToypoH6ViWHLl2HgLWAc5C?=
 =?us-ascii?Q?sgeUWZ9Q0uwuB0leEZxkTtCkgLbGl7gGFAR8ZNyVmadKt7Lj4VhP8FYMOgDt?=
 =?us-ascii?Q?kT0PMAtjluqnXfi7dfxwfhnTBLaFNLtDQnLMTheFHg4s74kQMjI3ssV1gnRj?=
 =?us-ascii?Q?3dHIudOcBR3Z2FXFFF0heNNwPRtGz9QOQ9vtb2bhvXZMOIiE9JQXVjAg9mcL?=
 =?us-ascii?Q?/O84iXNDSX38GDr1C0TErpKUyNWspBfjgUY7tgzu42xfWlLwDl+Zn9X/14Bl?=
 =?us-ascii?Q?kMNCCs+13jMJwZMbSCBrEI76Az/LPCHkZ4aOLWAcBRm7l6hL8rydBRp8mXQ2?=
 =?us-ascii?Q?e2+bvTO1IKlUA/Hh93DqL4rTNAL8JKpeBx2Y0cqJrhwzzHZ6N2nZcf0g2nsJ?=
 =?us-ascii?Q?L12SlfV0oq0fiA2lJ4MDc5/CAEe0rmODDZpbkhgCXKdSdZ5yXVPJbA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?paJCst9UBUbLLWGKaKGP+tF3NX2sbtQ49SLeeUX8fYC8JS7Au0luNRIjMZJu?=
 =?us-ascii?Q?2L4cm5cMRHFa61Oai7RuDcCAKDbKaqp45lVJvRkC+TkqOVEXKMVNHPHhYeEx?=
 =?us-ascii?Q?JVe7DKdCUX9mzSK+kYU0mE8KUB38yC2aWWOD8bwJ9Irt75hgyqHcZKw3LHSt?=
 =?us-ascii?Q?lcV2kCx69zHpv/h29RU3SRD32nyCJ/qfsf/aWv7jHDL6C7kugUSp4ZnytfQy?=
 =?us-ascii?Q?IkX2F4MnKdbnCPPgQbQu24LsmL1Rr8PmNLo1YZ+vQeiRk9U6nABkEMLLLQiv?=
 =?us-ascii?Q?wr7AQZA2ZUwV3TV139VUvb90UKQHzgCwknx/MuGIQ96w8SF92905qQn2Mjco?=
 =?us-ascii?Q?dqeY+nrmPDolg/d+21u6SjMnw7JLs9bbl+0vcNR4SbP7MqwED4tAJqksV6Vq?=
 =?us-ascii?Q?0gbK/CpwZzE7Q3v1ZaJK/cU8R6kvFRVCOBQG3QVDbr4zYabrj0Xj7mrnmEUU?=
 =?us-ascii?Q?lVvQbhz0/Wr84INVQtp05CaO46l88a85kpLDdUBGPckm/0N1/4QA9XlRfrN5?=
 =?us-ascii?Q?AFFkCAzL8SEvDEcpBhTqnO0pvT2fr1LU4g0m57KOepeuKL33Gzo1P6ceOf8j?=
 =?us-ascii?Q?5v8cxV41y81/lIXYv2tUUE0Umlfq9lJXmZVF/wAOkwTINpV2/bLgcnTwiCcr?=
 =?us-ascii?Q?NSGttDusBQ/pqrj2uAECZakmgXrxizJSpYJ4NpISzVG2UlZYiYr9CmXtfzSZ?=
 =?us-ascii?Q?aboalwtXsLvd+0QkMk2lWZyPJW9KIN+sP382/wiLXdyGVb0odZGuHjBhV5iU?=
 =?us-ascii?Q?y/hNJYoYvtuI85HLmdC30P0YWtHwht2nVISsd65/+WmL66/aPCrSB3N4ACkb?=
 =?us-ascii?Q?77J804sZxwlCOJMPGJ+hzCra4GH2ORHvch+WdAwAuH4DrED+Shc1iIfNPFgk?=
 =?us-ascii?Q?sOVdyFg9NA/w4S/BMb2Mc45ZilcmiPRI1rgQQnWXQXwAjP06zO72yVTBoDQ7?=
 =?us-ascii?Q?QK+GjmyXQ8vBRs+K91S8yGVp2hGFNkFraMfa8pkwZ/LCQCFQaL3C7XCFn0+z?=
 =?us-ascii?Q?JhSFWK2TtFYKJDTlkKtKs8CrXADEULSaENF5WZ/TYxWYDfPRQPrQE78cIycw?=
 =?us-ascii?Q?+dQEHnA50aIdHcdLG3vnBZKnppBxkS8clBDx39hN3OKZuA92KioZpSPU+3ld?=
 =?us-ascii?Q?fiJA/NrJH6bCREGokLb8Sivs9oPo345fwetCqhJVRe6JHvolqh62Pvs4fB/U?=
 =?us-ascii?Q?rlqd2UAFCbQLhaTjOXFHLJrNE+DCrxSGGtWkbL+SFNbUGlz16aBP3lW98Wb4?=
 =?us-ascii?Q?F6TFjeA9dQbwORFVj9BWhZGpO3aikWNTFBOtTgsQy5u/h53cHcVKEKrsdx3c?=
 =?us-ascii?Q?lMssCjr4ICIeQzQxqZKowSFZ6EVO9RUS4MVDlZF6XUPoSnz6CfkNUV/INS7T?=
 =?us-ascii?Q?Ron079dzC5wAVfWRvQdXlJgIy7ZAe3mYifLwkMPBzE2yti+4cqcTcExUfDq+?=
 =?us-ascii?Q?YzsGn6Y7edF/YiW/kmCIMatn/WB3qCW2Fqo8IeX3GSwyfjOWjhBe6o2cYuS1?=
 =?us-ascii?Q?cSQQL/dGDgrjvt9F1NOdZRCklXqVCsjba8Je6pX054UKiIwxJ7858AbSaZM1?=
 =?us-ascii?Q?qk+cCCqcNI8tR0AfDjPUHHFhO5FbKXhxk7brA5KM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6645f3d-871f-4206-7135-08ddb3407d9b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 16:59:32.5148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0VFoj9Pa0kOgRVdkz/o1j/JfzW2wiyNvO40MzSyATztPwLMqoZJNkBS7cDkUHe6TtoZTYyS8YK28lbn3xQfBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10710

On Tue, Jun 24, 2025 at 06:15:47PM +0800, Wei Fang wrote:
> Some counters in enetc_port_counters are 32-bit registers, and some are
> 64-bit registers. But in the current driver, they are all read through
> enetc_port_rd(), which can only read a 32-bit value. Therefore, separate
> 64-bit counters (enetc_pm_counters) from enetc_port_counters and use
> enetc_port_rd64() to read the 64-bit statistics.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  .../net/ethernet/freescale/enetc/enetc_ethtool.c  | 15 ++++++++++++++-
>  drivers/net/ethernet/freescale/enetc/enetc_hw.h   |  1 +
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> index 2e5cef646741..2c9aa94c8e3d 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> @@ -142,7 +142,7 @@ static const struct {
>  static const struct {
>  	int reg;
>  	char name[ETH_GSTRING_LEN] __nonstring;
> -} enetc_port_counters[] = {
> +} enetc_pm_counters[] = {
>  	{ ENETC_PM_REOCT(0),	"MAC rx ethernet octets" },
>  	{ ENETC_PM_RALN(0),	"MAC rx alignment errors" },
>  	{ ENETC_PM_RXPF(0),	"MAC rx valid pause frames" },
> @@ -194,6 +194,12 @@ static const struct {
>  	{ ENETC_PM_TSCOL(0),	"MAC tx single collisions" },
>  	{ ENETC_PM_TLCOL(0),	"MAC tx late collisions" },
>  	{ ENETC_PM_TECOL(0),	"MAC tx excessive collisions" },
> +};
> +
> +static const struct {
> +	int reg;
> +	char name[ETH_GSTRING_LEN] __nonstring;
> +} enetc_port_counters[] = {
>  	{ ENETC_UFDMF,		"SI MAC nomatch u-cast discards" },
>  	{ ENETC_MFDMF,		"SI MAC nomatch m-cast discards" },
>  	{ ENETC_PBFDSIR,	"SI MAC nomatch b-cast discards" },
> @@ -240,6 +246,7 @@ static int enetc_get_sset_count(struct net_device *ndev, int sset)
>  		return len;
>
>  	len += ARRAY_SIZE(enetc_port_counters);
> +	len += ARRAY_SIZE(enetc_pm_counters);
>
>  	return len;
>  }
> @@ -266,6 +273,9 @@ static void enetc_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
>  		for (i = 0; i < ARRAY_SIZE(enetc_port_counters); i++)
>  			ethtool_cpy(&data, enetc_port_counters[i].name);
>
> +		for (i = 0; i < ARRAY_SIZE(enetc_pm_counters); i++)
> +			ethtool_cpy(&data, enetc_pm_counters[i].name);
> +
>  		break;
>  	}
>  }
> @@ -302,6 +312,9 @@ static void enetc_get_ethtool_stats(struct net_device *ndev,
>
>  	for (i = 0; i < ARRAY_SIZE(enetc_port_counters); i++)
>  		data[o++] = enetc_port_rd(hw, enetc_port_counters[i].reg);
> +
> +	for (i = 0; i < ARRAY_SIZE(enetc_pm_counters); i++)
> +		data[o++] = enetc_port_rd64(hw, enetc_pm_counters[i].reg);
>  }
>
>  static void enetc_pause_stats(struct enetc_hw *hw, int mac,
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> index cb26f185f52f..d4bbb07199c5 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> @@ -536,6 +536,7 @@ static inline u64 _enetc_rd_reg64_wa(void __iomem *reg)
>  /* port register accessors - PF only */
>  #define enetc_port_rd(hw, off)		enetc_rd_reg((hw)->port + (off))
>  #define enetc_port_wr(hw, off, val)	enetc_wr_reg((hw)->port + (off), val)
> +#define enetc_port_rd64(hw, off)	_enetc_rd_reg64_wa((hw)->port + (off))
>  #define enetc_port_rd_mdio(hw, off)	_enetc_rd_mdio_reg_wa((hw)->port + (off))
>  #define enetc_port_wr_mdio(hw, off, val)	_enetc_wr_mdio_reg_wa(\
>  							(hw)->port + (off), val)
> --
> 2.34.1
>

