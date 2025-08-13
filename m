Return-Path: <netdev+bounces-213383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BDEB24CFA
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 17:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24EB5A64C6
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB272F533F;
	Wed, 13 Aug 2025 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bObqesnx"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010031.outbound.protection.outlook.com [52.101.84.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795F92F0680;
	Wed, 13 Aug 2025 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755097833; cv=fail; b=jAO8/5dpXlJaqJ0O7Gd0BtP0ZOoNnnL3ntWyKQvuM5Dt6xWw5RI2luRxYpQ1WcLZ6KGvz/FdtHnem43ZuJ3fFOOMpjNZkbAI5pjY2gUkSZHsJR1t2kau2vDRsfn0zxXhYvab+WsKtWmzwRCdwzkEr0s4JlRHBA4Mpbju4jHtwnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755097833; c=relaxed/simple;
	bh=+pJRZGBaxWSnq0PNieuWrTc0b0aUeC0yJsZfkO0Vd/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SEfwo5KMEEKm24iYw1/SuF7MNB9pFdMqYmdjDpdyV0BKTOMgR1/Wb3axUJZoa8R8c6Key1tPz8p+01eH34YU7t25iQrfyLeyBAsavyUr33WDYG9WEJe7UdIwPctC2rWQW5xsTVLuBIadiiLb2AK9yTCak6F9S01WBFe8MWryljw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bObqesnx; arc=fail smtp.client-ip=52.101.84.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YlFKsIXeNfgXasnZQ5xzAeAxBPOZpuBXsJ3GwOtnGWUOSbkUOyQmcNfGGFu1QskfZjrkKM9sNMcxQss6nUnoclbN1084g9i/ALDiv9Sg+CjUQN6o8JcjFGazYptGrDIJQ00ylUoAD6XsmgWVKR7RMTEbzO9y1tJaOjaXS2Yvhb1Xv7slHari6a4/fqtOedJWfzx7wa4esUEdg9w06WovueoHbHwUIhWF1iwgBEtjvp9UPpDi5QcPjCmhzdCJS2pS+EER0ZIGqqDIlJjuTqSAbIgb901npr4mg4xmZZHjswU5y/b1ReDvhPifG3n7aKuJqXq8qGLcr8aKRlObQEruoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQD/Le9XyhuS8vuWHv+IAUhiFwt7R+6yilrH/KNTkFs=;
 b=DBKoohfRlqDlwazDsx+pfSU4bp9VVVnDfj+mBWb6MoyGQXeW6SJckyvtFY9JTdhDKJzbV8CjeYxkot8Go69OqfVQKc5XzPMRfqtGg8lfgI5uXsqsYrJtDFxWyQWtfS6iaLLSU1hCMA0Amps3leJ7TmoWo6+c+t001u6SjWN6tiuGN4acGGm4Cq49hzzORfuFmcBTLdJsf0+YjecKskzrvBaowGqWaQftX+57KFpWMHoozeKVarpYCsDA8Y4QstVOasSAJUknEuO8tECH7uau3PMdckSfGG8FppSur83Y5B5iVquzoouxTkkffA20+D8QUvScdt1plFPd3mrXSWazSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQD/Le9XyhuS8vuWHv+IAUhiFwt7R+6yilrH/KNTkFs=;
 b=bObqesnxG76j+WEBkUdYPlzd0rPs8+VvhgdK2e4RcyMbME9LA8Hh34MAykzAlCdNqfv7JsD8LOp8a+V1KwRQiTI+gCHgm5M8c6mh/u+YulVOl7DTmrKtZoOn7/e3GdfRUtFszbjGXYCUImPxbPT30yf2FKEJq6dtro7n9c14qgwRNJ+m3tLPxNUbPvta53qfgjgmBRdc7LSwEWqHDdeH2iymT4kNwzukf6UAwmAt8ZbcyWRk8LREk/LfsFHlu/g4wPdh8U0lPyFn4lYkUwNLrCKNVhBiSfD5cJ5N+6Mx69vJNAoa3PsCkQp3ltYMQFI+E9+g6Hb4zOc1dXW23h52DA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8276.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 15:10:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 15:10:28 +0000
Date: Wed, 13 Aug 2025 11:10:18 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"F.S. Peng" <fushi.peng@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v3 net-next 03/15] dt-bindings: net: add an example for
 ENETC v4
Message-ID: <aJyq2h+y+KBjqmsr@lizhi-Precision-Tower-5810>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-4-wei.fang@nxp.com>
 <aJtR4j9+w5fVsJL4@lizhi-Precision-Tower-5810>
 <PAXPR04MB8510925387F9F72A8E99AB82882AA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510925387F9F72A8E99AB82882AA@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: BYAPR05CA0094.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: 341aeaec-3dfb-473d-258f-08ddda7b89c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l363Uk11BcbbXnVWlbZWWbkD5mskYOUUVnc3XsSgp9j1+0aqZZv4W5atir3l?=
 =?us-ascii?Q?jFnScZb4mKq/XVQ3U+3JefxbsyoZoxwhgJ9wuc2T/S43R2K2Nq0Hp4Xv5q6/?=
 =?us-ascii?Q?Tkd80OoB5grDNBC+oA+3XbkOQpMjbk4C0wcE+14Zu8+cVO5dGlCaWzXOVMyQ?=
 =?us-ascii?Q?rP+09cFFf3sThes9GcDiwv5xD13/dPZNT40LZ6gtIZY+xcw+THJ2taPgRpFh?=
 =?us-ascii?Q?HEqoW+X2R7E3HAbNVdKUTDO2OZvPE95PfzD/fmVwAWoRiXRPIdkelT7RXTZG?=
 =?us-ascii?Q?AHa+QDgzMImBrQXMFAm/IEO74HcwPs1yUMIaiK+B3+FXtccCDd41sl/Jg8E5?=
 =?us-ascii?Q?vPfJ/0eMmUzTLZ1LcvVsWbmiU2GghdZfDaN40SX+7jS33DV1X7oIOXEzON70?=
 =?us-ascii?Q?ID4TT9gA/Wv+efa00sSH8L1sLcMZ3Aw2GfzN7YbFHl1Mj3PzYUu3fT16+Z0C?=
 =?us-ascii?Q?sJ3Gi3PkSBVTZ9nOXbbc1LO9xmwD40AQVngdMllp2xIRhhLEh1ORUaDDTC9a?=
 =?us-ascii?Q?4ZFjdTFigBU85G0uc122GO0Mb1Dc2ObuRJoWNhNl3ML6cJY5T1jqPO0iVa58?=
 =?us-ascii?Q?rNjsiLVPxsyfQlmRpqv+tSgQ7Ouq4twcXxMZmerkCGC1k5BH/Vlfn1anpJ+M?=
 =?us-ascii?Q?aFHclI3Dy2I6ONl7RPKXTW2jt8j2oHZ6GEhWxW+EH8tQIj2l41XVhFou9h5L?=
 =?us-ascii?Q?O7AoAl+Uf+ngoHVRB6qq92j64AV/Stob+nq3JsBZnVmbuoFUsOh1cebx3dst?=
 =?us-ascii?Q?ON5qOi+Mwd7Q1PJ+/jU5zHqibOYpkOysbGtrmfMJLavYykDCl8eC5v3T85S6?=
 =?us-ascii?Q?2/IdmWmYsuW7SV67PZx4rFMaMGjAZAmf/i63+UYeU+/Vm7auJ8RbTNDc60LB?=
 =?us-ascii?Q?Fiv2EFV3q/sOMZeh7/mxvc88ewbwujg9QKdflNfGOVWpPSEppzWCliTuNWRv?=
 =?us-ascii?Q?yZsZ2Xd3pnlE3A9VWBWjywCIM4es+lyqACWFdfTmvdHn+wfKzRL7zG1vRQmp?=
 =?us-ascii?Q?M/MlbQVYByOtPO3BdgrLOaf1EDlhPz6Bsuqq/rsyhF68VtJOsP3qkwzei198?=
 =?us-ascii?Q?eVa/oV0l4rG1Gg8xhLob8+T8OvLI+A/IJ6wp8/S28h03uJEV0XY4FtW/IpkH?=
 =?us-ascii?Q?Q/3AOvKHSi5StjZj8qwEEAn7/fQZ44WfFjCLTVMIYi0JEsBYPtA80oES3Oy/?=
 =?us-ascii?Q?f6p1o5n1YZ4yrh0IcFgdfs7yBVIozHlqrLe/VUzOT7ieRUZNartcoRiH4eOF?=
 =?us-ascii?Q?MgdvXVWuPg0TEC6SpuHLszZwhm7N3nWEaqx9SqrVJdckv1yWrgKDpAYo06GK?=
 =?us-ascii?Q?wGw2a4JNX6gr4FN153K5F+hdUYOTvU+cgyOBQwYBjo09WsBy1FnekH9CDOx8?=
 =?us-ascii?Q?1KZcm2/i/hbBHAlox8phWRJV5PqeW5sQnLGtlzqmrpmxD8N8dcJiqVERY96h?=
 =?us-ascii?Q?bUCnu+ysXplYHzEncPUA6thXxtYfkAXaJbPk28Lld5XFbLGXZVwRKA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cJBMh4fQlVRvMme+2bgNz0UMLe2fApPC/Kl+SRE9NXQNgSscdNyXmfyI4SXW?=
 =?us-ascii?Q?RiSJC+5/3C+Fidvyhivhr3K++hyh2q9H+QfCPXnenpdOIfjHaAay9rNfhm1a?=
 =?us-ascii?Q?UKuvcmVAR6fO81m3wbMB4xsioSN9p9YAoG9eEi3dZqkyM6OI+lLDD3CFPQCb?=
 =?us-ascii?Q?BLVYDK0ljsmK997aCcLXbIS2NahVW8jgKln8jsbchL74ssnX0wfwRYdlFEJ3?=
 =?us-ascii?Q?5V3C/gp68oNh9gqCHQFrCK8+Pu1ckjKbKmkjHU7p6jB34X7DqJPeUH1yhQvY?=
 =?us-ascii?Q?8Egcsww3DuhTtIWpiqaJn9Eke9kGwx0hnc2fC9cwf4f+prdA5Po+202P0g0V?=
 =?us-ascii?Q?uMws8q+NwdtpRQvSAFtcUNZRIHCENrTApOHIE9Wm5xiNi6vku6kfWhXiblQK?=
 =?us-ascii?Q?UjSbfs9W+VWQWzFGXOhMOEd+NUB1L+6ZlFhNyEU6/659N4uRv24/xbfWCJ9v?=
 =?us-ascii?Q?odGOG7OtFC47vDDXkGNAs++D3ChUlTO6CyzKJQ0N1M6EXkg4DsytdEUCsgoG?=
 =?us-ascii?Q?M/pqVJ8ylrxq4/WYf6uypWHNrAzFGkNlNmrkLVj0TvP7sioPdY+h/WpsDoyS?=
 =?us-ascii?Q?oaWYpXEPZCmVj1cf0xewsVFD6BQ4HpkHLZEDDNhY3DvUHhi7+6upEtZGa1/+?=
 =?us-ascii?Q?eFqMGo8bD9WEH/iU54n0w5bDGo3XS4DzY3yT1O98pLr7U8w4JskGMahV6Jue?=
 =?us-ascii?Q?Vo9gR7BQ0jt64hAYAplhF0qcGoAXsOQON6rdWe7o6VD6YBAeUmB2x8BWx7aj?=
 =?us-ascii?Q?11PHW87Ne4RpPQRS2bG7iPG8ULvN7/kDGEoo2gtryM82G5pb1aEOgtkabE4a?=
 =?us-ascii?Q?78XmPfrmD0U0k/id5atUeeAyoPZOUrUp7SPR1Q9xnAnr/IdX+SBDPWBSQFW7?=
 =?us-ascii?Q?g/oSoarKX8wci1oxY/ZqGMLwY7E+iDspzgK2ES75bye8h0vIr6YlKkpCbTmu?=
 =?us-ascii?Q?peQ/26D9yZAfuSJppd8PLfo7Kur8VBFSlkPPta9bdAMunb8zhiSGg72k0PlN?=
 =?us-ascii?Q?l5tYQdj3BoGY6XXYi63XtU+m3Q7lvzqP4yT92PsewkRcLuW0QwKBNyBvuAHK?=
 =?us-ascii?Q?mDzaRWyjDzyA0Q1ISL3baCqVx1TIa3pTIk2H/USPOFkW/4bKh4KM4mylrcVl?=
 =?us-ascii?Q?EHGSbA572rH5hBLeKuI53ykI7HHSD/zk+UcM5Z4oWz7Fp2Te1XZsIps3+Gsn?=
 =?us-ascii?Q?/eSKzA6MkeJEHVDQvAvvMsU5CejgUy+k8+vj1nt1/xDAp+o9aMIyq8ncdVuV?=
 =?us-ascii?Q?m39rPoaBvRTiXxTotk0xTB0mOK3G1k5055GgBhCNyyVnqQ53pfLDg5yx/hDm?=
 =?us-ascii?Q?r5zClp1z5l4CnrwPQF2C/L+TShrGPSlzBo9pHPbHi4p7RXRHT3I6t7gt9ESK?=
 =?us-ascii?Q?pqqpqBFqMpV+7RXdKp9sJl+CojRuAEWXvR4Yam0mJsAhbKa7JOXEg4f9fSaY?=
 =?us-ascii?Q?XKFbsMHNEbdpjitOMOZ8UvFdOkC10ez0u3GER9hjIou5f4Rm7afB/vJKnwpv?=
 =?us-ascii?Q?VUFk7trSE5jF0l2wYjSz7RpZ4iPHNmz3IalbXSjJF2nbMSHWeSKGdZdjPUOO?=
 =?us-ascii?Q?S3PeE6xFk6SyQzkqzwWiEgziU3nlda9f9NGMd1ef?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 341aeaec-3dfb-473d-258f-08ddda7b89c9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 15:10:28.5218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4iqV18TFSjYXm5DDNH+faAPQD8DAsBlDv27mbZziPB0L3VJcutHNh9gRxacAO6DZg7nhXrg18IFi+DRf/c/Egg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8276

On Wed, Aug 13, 2025 at 01:38:55AM +0000, Wei Fang wrote:
> > On Tue, Aug 12, 2025 at 05:46:22PM +0800, Wei Fang wrote:
> > > Add a DT node example for ENETC v4 device.
> >
> > Not sure why need add examples here? Any big difference with existed
> > example?
> >
>
> For enetc v4, we have added clocks, and it also supports ptp-timer
> property, these are different from enetc v1, so I think it is better to
> add an example for v4.

If there are not big change, needn't duplicate one example at yaml file,
the content should be in dts file already. Pass DTB_CHECK should be okay.

Frank
>
> >
> > >
> > > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > >
> > > ---
> > > v2 changes:
> > > new patch
> > > v3 changes:
> > > 1. Rename the subject
> > > 2. Remove nxp,netc-timer property and use ptp-timer in the example
> > > ---
> > >  .../devicetree/bindings/net/fsl,enetc.yaml        | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > > b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > > index ca70f0050171..a545b54c9e5d 100644
> > > --- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > > +++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > > @@ -86,3 +86,18 @@ examples:
> > >              };
> > >          };
> > >      };
> > > +  - |
> > > +    pcie {
> > > +      #address-cells = <3>;
> > > +      #size-cells = <2>;
> > > +
> > > +      ethernet@0,0 {
> > > +          compatible = "pci1131,e101";
> > > +          reg = <0x000000 0 0 0 0>;
> > > +          clocks = <&scmi_clk 102>;
> > > +          clock-names = "ref";
> > > +          phy-handle = <&ethphy0>;
> > > +          phy-mode = "rgmii-id";
> > > +          ptp-timer = <&netc_timer>;
> > > +      };
> > > +    };
> > > --
> > > 2.34.1
> > >

