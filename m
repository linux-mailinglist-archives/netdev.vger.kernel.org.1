Return-Path: <netdev+bounces-212979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E4DB22B76
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3321A21909
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D962ECE82;
	Tue, 12 Aug 2025 15:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WWCGMT8a"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013026.outbound.protection.outlook.com [52.101.72.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D418B27932D;
	Tue, 12 Aug 2025 15:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755011496; cv=fail; b=P8SW+0hgupr8e5gtD60NbFA7oOWwwUTqV8i1KEyBnWuwCWHzNJUhm0aVssvAcqVc2mOQY8iZWbcCPaVDTQjWUsFLa8vDR7ISi2NHMAMy//JJTjsMzZkNFOQFJMW4FYDfAyArdH/GmNAR7H6gstCxbRRsulfg16CsK5BIUNpsPOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755011496; c=relaxed/simple;
	bh=as7yOGfFxWioD4bdcaf+sUTKWRh+JUP6/H8o5chiisM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ee+2c1Z75aZ1l3oOF72s0gm1dVTzr7aCK/2ssgVEbcN9WbeoBR76kw2HUqqaDdAk0d4Hzxd8YsMZcuPe8qHjyrun3ri/Igc0qn1BBWiztQObDYb6JbTxblSXGTA1VlKPF1FvLrP6n997IMRZdrHS8Qx/OerW/Pd+t/0eYZKsN5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WWCGMT8a; arc=fail smtp.client-ip=52.101.72.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1LRnC7H3Gl1VM1Eu9hcYMFducbT5KwGDZ3JYuW/Ohlklj8uQtpvKGc9xN9O7W8+U2heRZDx7skB3IAX79C7W4G8BafTfseumCuZXiBWkbPVXQabGR3A7kvuNUCm2hUUmMscfRBAIQyHBh3xWv9DOlFwmCHepC/iXAUnNrPZQO+zXNrhpM8AzNlnAnebWEVxA6UpQS1JnSixJfd38iCc/mstxGOU5+tCOSJTiFRB7mcJkR6hjO0JFFW7RuA305oOJ0lVTVKdYdokpmrhh0kk0CTIZFsa/XcM9ZF259Mbk+pNIJ9OiUD4sUr009cU9cNwXwj5KExjkFTFBMMSrxhh+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3K8fQPE6BrpNOP8jqtJn80PmX77nM7LrhH9x9tw7ww=;
 b=GNcXG23CMqfNg493bvXYQLL0woDd2JjAa3yLsvtcNcqtL9MWkEK5gH9p1yuJr+z9hrZbDzjQs8H4i8trLRXpMV2mjoLF9cS1tKrYrdVP8PMdfUdbL0gkL4gmX/z1Zp2A0L7Wtaam7v6P4Vp2557l1+v0mwvfVKzvJYm/sT6LrGWKNsQb3k1yEy5jUTkd+lw7CDODKsQv48ZAESkzir1HkDewG5lrsJh4qyva8lIpmWRTGLHPVvcaIzCDKATMGS43keiVTMujZtznXnRVhCxX1+Bj1dNWHwmIlRtEWA5jwGojAU3YZsN4WxUQ8hYNcb0S8be1z9gYuRPXCOf8VtB3/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3K8fQPE6BrpNOP8jqtJn80PmX77nM7LrhH9x9tw7ww=;
 b=WWCGMT8aO/0cawInpy2wSn0WkqtjmDjHhhsmOvD57/4ImpBoooi3/VBjlj2N2Esnbwi+Gl+njMgtyeKQMYC3v596SeScFJXCzDDW3gBisJHXh41gmlXBfhpsgg5DuxNU2BYMBcGoCtUKRuHJMyS7vrx6RNa6ngLUBW3UbiwSC5fY7V1PR+6kyP6pPvD4BVKjBADrc51WT8Z/M/6+vgWCoSauZqosjswyWfjcYe2BbPJPJ1k7eYaDaDQ1bXtFq3JXacUG3laI1+PIQLSLGf+JXVXog5rBjPiJvTzmFppLoDYQQoVq06P9NsKxaMGZt5Kj3vti6i89wjBZZcA8jJTXCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10728.eurprd04.prod.outlook.com (2603:10a6:150:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 15:11:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9031.011; Tue, 12 Aug 2025
 15:11:28 +0000
Date: Tue, 12 Aug 2025 11:11:19 -0400
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
Subject: Re: [PATCH v3 net-next 05/15] ptp: netc: add PTP_CLK_REQ_PPS support
Message-ID: <aJtZl3jgBD0hLyt0@lizhi-Precision-Tower-5810>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-6-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812094634.489901-6-wei.fang@nxp.com>
X-ClientProxiedBy: PH7P223CA0022.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10728:EE_
X-MS-Office365-Filtering-Correlation-Id: e0549eb7-251c-4203-0548-08ddd9b28331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZstRWWd2Lt1d3YVS2dyGBPR2EpAxqBXqMRlpd+8LQ3IuLUraYfoKdNYlKY4I?=
 =?us-ascii?Q?zYTxfACtKF8LQOu758G+qSVGoM+rk9mwW+5hhYiXeEeaZz5jMhd/K4LPxwGp?=
 =?us-ascii?Q?gZMcuHau9uJ7NWAFsPa5XLNlkVfzoYLIVie0BIGV8sitOrTGF7HkZOBcImxQ?=
 =?us-ascii?Q?chvpdzEeQO/gsjeoGlg1vztpQHLUp+25oJHRgixH97LhDXMAjCVOh9tFwkEd?=
 =?us-ascii?Q?0NX1GIAXVG4yMFRAkHpdeZ7pFNGanz8ri35b5iAkFWgaBT+QCHPmk84C/aEq?=
 =?us-ascii?Q?020onEPmbVOhlgEUSrPMBuHTjCA3IwanJ18FNZGYPSCwW16ZDCm4V+qnNAnU?=
 =?us-ascii?Q?Wby7/N9TBCXao2A5Fb3neSN+spYBmkfLZrbud+RAXunYwcQfaZzfU/WrfRva?=
 =?us-ascii?Q?3GVBeVEw9dmbXkb1wnZVp1jL8DGnbqkYo1FRGb+W+0GHaCWxYavn3hv2xGmT?=
 =?us-ascii?Q?u5/kOFZ5i7KNVVOZSWD8TGgqhwXVNI0ye816Y092D+XHSV5AH2M+PRbGfxyg?=
 =?us-ascii?Q?6gJv390YxW0BiISkgGuapiSQ9TQBkox3DDKiGiHhZLsOmNsIz3UaTGFVPTLZ?=
 =?us-ascii?Q?uviWD9enEq8f6EV1qm6A70VAY3EDAmDdo5P/U+EhTTWN2/9x3OQwttQcp74/?=
 =?us-ascii?Q?Exfv24EvLX64IRmrQssjDJwJUOht+rnRhssPtNWvIhdROIjyCrOiPzF4/Jkb?=
 =?us-ascii?Q?Gy8NLyLFw0ej08ZNUJrRMwtN/qFeo7Q8TpkmOgf3/N0+E4+I9TNpXVudfO1T?=
 =?us-ascii?Q?OcI6fWCe4RadsZ+/O2wNb6G+2OMyvy3axXiZDDoT5RgXzMi1Xih7F9PIr9W4?=
 =?us-ascii?Q?8cXN8xesHfopAPV15wSgz4dT/DK8l38rfEq/mdQkREe2rZj+Nz0oBKF7HfzB?=
 =?us-ascii?Q?ncVpZZ/WZUR+kzICjLJGY+TnrDaB5zamIH91sLRJ14CTmyzVfd/mC0PXCv3y?=
 =?us-ascii?Q?XOuc+FiqQa8EwUx31HGtNEHKvfvkEoFGKUw10EORbqhy9qrtzMuG3XkuI+7W?=
 =?us-ascii?Q?ptpW5TjlPbAPVuiouT/w2I5T14zD8H8hbNSSLUDtB3pjI89gM+UBV6Iev8AB?=
 =?us-ascii?Q?ZEjk8ZEKbyJIBIMl0dsw4oz2cpIN/WKOSxePO4VFZXBs6aWXlijXUHcm9uvE?=
 =?us-ascii?Q?3coEjA0THlLHRPBMtPjs0bIWWifXxPIR4Gax0rEGo71ikxY6exr2mTAKH63L?=
 =?us-ascii?Q?eIx26o4pcuW5o/b1eOrJPqrUHxY9cHwi+tCXa/NI9L7I+0Pc4bEjcgpZzUt4?=
 =?us-ascii?Q?0y3pZ7GQqSwfqbYVlDKQeYEfVkiixM2IMHN3AmtC23XnVnu0Jp/0mlShmY6K?=
 =?us-ascii?Q?jwlzSxhNc6/oEy2NHviV+ZnmVPDSoMmBdchh7r/OtBDk2xkSzafG3LlRAQvl?=
 =?us-ascii?Q?OMzgqpP7t7jgGIknJ4hJaBF34ELvLvcF5RwibryzAW42dZnNRMBf8PD8pdFL?=
 =?us-ascii?Q?/M2o4vjP1zrCGIB+TeUBj6h8M9EsHQI3D9b24gRTsCiViBmm+NXA6epQzwYF?=
 =?us-ascii?Q?FIWqTnCgI8dFYcE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yX8DdKCKZd0NFdX4QqLDDKuEbLyHprBjBObddt5tlRzgpCUsvOFi7Co6MFvU?=
 =?us-ascii?Q?Dag+3D+cmEaukVJDU7yf+aFVEZK4ABzsE3a3tXyd4czzHn9mgRcfivSbZIp6?=
 =?us-ascii?Q?nKWJTcczlhkA77zO0AjDFOl3ilDL+9JLYRkKyO2qN3E8Tq89u2Xgvufp5iYO?=
 =?us-ascii?Q?nxJyNWOVImU0dsB11mNClsiyNq5FINF6weamnt02OhQlY8AtViL7a8/bCCJc?=
 =?us-ascii?Q?UkB3/wpowiqZ+Jf0VqOTJFvhrxcxg6OZFnPF7XF5k9gVeewRfhO/Jnf9PzqC?=
 =?us-ascii?Q?XtjioZeNlpCmrA92p/P7vgSC1zIVRv5cTUBi9WbJW1htZLMgKTZ2QtWEtVV/?=
 =?us-ascii?Q?JT1Lmwy+BSAXrZHypjX6TmDRD/pRXxs+4qA0kb6Yk4jWAgIs5h1xAdLVeQ4p?=
 =?us-ascii?Q?y/rd9ZMQHIftZ7SExakrvV8HsQIbEdLOgLqJPV4Du7WlWD6ZZpgH8h9ziOoL?=
 =?us-ascii?Q?0ochSNywx8Fb9g/pCawWF+RmQi/928oNGnsC0sLDmHp+/7A5bhO61yz0Fy9f?=
 =?us-ascii?Q?BPJCACijIlZCpisYcmiSd/7Zrsigp+ej9XqaIZtECgstIfMyWC1EBBJ5muF5?=
 =?us-ascii?Q?jILQW55k/iZGx2N16csOmYg5ujDVmcsQY82aeYBayRcCe/+Jgs6K8hywUt62?=
 =?us-ascii?Q?Nsk0RrOidYCzJbMJa4tDmbuICrG+7VNknLruw/kJ4xa6gneJ0TQYtLufaejc?=
 =?us-ascii?Q?5BuxGsBHMCauY4BCzbty+HB+2xd8wKcZptLujHwkO1YVL16egMo2n1OF1YOw?=
 =?us-ascii?Q?4xFkoBc+lFxTUlj798Qy1R/XuWwaKc7+SQLaeSGLGcWbaHh0NO51cIBVuq9L?=
 =?us-ascii?Q?+MxExG/+zIHQjk+YvZ72kw2xjZJO0XeFSBi5Oe1ojtjIuYVPQ1QXOrNHWTxs?=
 =?us-ascii?Q?sa/xPDussxgtjXK66FgWSmd94UuVyjb5x4eyU0MsYdMtV9I3kXhd9PRtxWIP?=
 =?us-ascii?Q?MZhYs9tl/0BaSAeE1Hv1eYSCboDEROo5Hd9zFodeWi688Nvz3Ku+ffkyw7XH?=
 =?us-ascii?Q?RDjY3M5dHjruhLD1HPq3T2MJf/jY5CCoV9ThO3VrcVkjdoPNW44hhcUcEGLi?=
 =?us-ascii?Q?Em4ozzFipQmRouSFyZdVOIyw66QMzkkGRktsHQR6P2YAl9twYDIempA6/gtK?=
 =?us-ascii?Q?BGVq+TFB5NRPThSDnPlds2WYoAHPYoKqPpvIEmVZHu9L7SWs64QPRzXRtVIp?=
 =?us-ascii?Q?GyxEy+heBCWq3w6secFL78psN2LNfu8mMfZhcL3OcUDdCWaHl9wS2jhvTyKs?=
 =?us-ascii?Q?4Xr5LI2wXmaIlheXyNhAZPzA0FmYI+YxpAycRoVEUuGulb9PqIaeDOD0PTOo?=
 =?us-ascii?Q?UoBxBCx5Rui6bTDszbsIQXdA7v5xPrvjZPxVWELZNTOIALX7oHKEusJqg/t3?=
 =?us-ascii?Q?iVHeeiwUFHeEfwfaPebO2XTkubttnb1Hxt8XzXTHlAFjs0BUy2Z181NpMq2z?=
 =?us-ascii?Q?wQud2YpAJtEbll2kLbT1Lq6JLnxGnLnM15cY3onYe68uIgGMMyB1kX01VW88?=
 =?us-ascii?Q?t0ZFWPpVZLOGf7m7TuNZjTwD6V6pI/VMMFJoHDM7+JAwwdfWl6Eh3CJpJpyw?=
 =?us-ascii?Q?DUQaCOHQ1vttujtNM+57SoHOwcEUllRQ9LVsPyar?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0549eb7-251c-4203-0548-08ddd9b28331
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 15:11:28.6387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wihle2CBsHiW/9EV6xV09lp9u6LTCm/VO+N80iPytC5c9lHttpmvC09I6G9BzpZP1/7H7xcXGpotoPcXPhGogA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10728

On Tue, Aug 12, 2025 at 05:46:24PM +0800, Wei Fang wrote:
> The NETC Timer is capable of generating a PPS interrupt to the host. To
> support this feature, a 64-bit alarm time (which is a integral second
> of PHC in the future) is set to TMR_ALARM, and the period is set to
> TMR_FIPER. The alarm time is compared to the current time on each update,
> then the alarm trigger is used as an indication to the TMR_FIPER starts
> down counting. After the period has passed, the PPS event is generated.
>
> According to the NETC block guide, the Timer has three FIPERs, any of
> which can be used to generate the PPS events, but in the current
> implementation, we only need one of them to implement the PPS feature,
> so FIPER 0 is used as the default PPS generator. Also, the Timer has
> 2 ALARMs, currently, ALARM 0 is used as the default time comparator.
>
> However, if there is a time drift when PPS is enabled, the PPS event will
> not be generated at an integral second of PHC. The suggested steps from
> IP team if time drift happens:

according to patch, "drift" means timer adjust period?
netc_timer_adjust_period()

generally, netc_timer_adjust_period() happen 4 times every second, does
disable/re-enable impact pps accurate?

Frank
>
> 1. Disable FIPER before adjusting the hardware time
> 2. Rearm ALARM after the time adjustment to make the next PPS event be
> generated at an integral second of PHC.
> 3. Re-enable FIPER.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
>
> ---
> v2 changes:
> 1. Refine the subject and the commit message
> 2. Add a comment to netc_timer_enable_pps()
> 3. Remove the "nxp,pps-channel" logic from the driver
> v3 changes:
> 1. Use "2 * NSEC_PER_SEC" to instead of "2000000000U"
> 2. Improve the commit message
> 3. Add alarm related logic and the irq handler
> 4. Add tmr_emask to struct netc_timer to save the irq masks instead of
>    reading TMR_EMASK register
> 5. Remove pps_channel from struct netc_timer and remove
>    NETC_TMR_DEFAULT_PPS_CHANNEL
> ---
>  drivers/ptp/ptp_netc.c | 260 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 257 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
> index cbe2a64d1ced..9026a967a5fe 100644
> --- a/drivers/ptp/ptp_netc.c
> +++ b/drivers/ptp/ptp_netc.c
> @@ -20,7 +20,14 @@
>  #define  TMR_CTRL_TE			BIT(2)
>  #define  TMR_COMP_MODE			BIT(15)
>  #define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
> +#define  TMR_CTRL_FS			BIT(28)
>
> +#define NETC_TMR_TEVENT			0x0084
> +#define  TMR_TEVNET_PPEN(i)		BIT(7 - (i))
> +#define  TMR_TEVENT_PPEN_ALL		GENMASK(7, 5)
> +#define  TMR_TEVENT_ALMEN(i)		BIT(16 + (i))
> +
> +#define NETC_TMR_TEMASK			0x0088
>  #define NETC_TMR_CNT_L			0x0098
>  #define NETC_TMR_CNT_H			0x009c
>  #define NETC_TMR_ADD			0x00a0
> @@ -28,9 +35,19 @@
>  #define NETC_TMR_OFF_L			0x00b0
>  #define NETC_TMR_OFF_H			0x00b4
>
> +/* i = 0, 1, i indicates the index of TMR_ALARM */
> +#define NETC_TMR_ALARM_L(i)		(0x00b8 + (i) * 8)
> +#define NETC_TMR_ALARM_H(i)		(0x00bc + (i) * 8)
> +
> +/* i = 0, 1, 2. i indicates the index of TMR_FIPER. */
> +#define NETC_TMR_FIPER(i)		(0x00d0 + (i) * 4)
> +
>  #define NETC_TMR_FIPER_CTRL		0x00dc
>  #define  FIPER_CTRL_DIS(i)		(BIT(7) << (i) * 8)
>  #define  FIPER_CTRL_PG(i)		(BIT(6) << (i) * 8)
> +#define  FIPER_CTRL_FS_ALARM(i)		(BIT(5) << (i) * 8)
> +#define  FIPER_CTRL_PW(i)		(GENMASK(4, 0) << (i) * 8)
> +#define  FIPER_CTRL_SET_PW(i, v)	(((v) & GENMASK(4, 0)) << 8 * (i))
>
>  #define NETC_TMR_CUR_TIME_L		0x00f0
>  #define NETC_TMR_CUR_TIME_H		0x00f4
> @@ -39,6 +56,9 @@
>
>  #define NETC_TMR_FIPER_NUM		3
>  #define NETC_TMR_DEFAULT_PRSC		2
> +#define NETC_TMR_DEFAULT_ALARM		GENMASK_ULL(63, 0)
> +#define NETC_TMR_DEFAULT_FIPER		GENMASK(31, 0)
> +#define NETC_TMR_FIPER_MAX_PW		GENMASK(4, 0)
>
>  /* 1588 timer reference clock source select */
>  #define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
> @@ -60,6 +80,10 @@ struct netc_timer {
>  	u32 oclk_prsc;
>  	/* High 32-bit is integer part, low 32-bit is fractional part */
>  	u64 period;
> +
> +	int irq;
> +	u32 tmr_emask;
> +	bool pps_enabled;
>  };
>
>  #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
> @@ -124,6 +148,155 @@ static u64 netc_timer_cur_time_read(struct netc_timer *priv)
>  	return ns;
>  }
>
> +static void netc_timer_alarm_write(struct netc_timer *priv,
> +				   u64 alarm, int index)
> +{
> +	u32 alarm_h = upper_32_bits(alarm);
> +	u32 alarm_l = lower_32_bits(alarm);
> +
> +	netc_timer_wr(priv, NETC_TMR_ALARM_L(index), alarm_l);
> +	netc_timer_wr(priv, NETC_TMR_ALARM_H(index), alarm_h);
> +}
> +
> +static u32 netc_timer_get_integral_period(struct netc_timer *priv)
> +{
> +	u32 tmr_ctrl, integral_period;
> +
> +	tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
> +	integral_period = FIELD_GET(TMR_CTRL_TCLK_PERIOD, tmr_ctrl);
> +
> +	return integral_period;
> +}
> +
> +static u32 netc_timer_calculate_fiper_pw(struct netc_timer *priv,
> +					 u32 fiper)
> +{
> +	u64 divisor, pulse_width;
> +
> +	/* Set the FIPER pulse width to half FIPER interval by default.
> +	 * pulse_width = (fiper / 2) / TMR_GCLK_period,
> +	 * TMR_GCLK_period = NSEC_PER_SEC / TMR_GCLK_freq,
> +	 * TMR_GCLK_freq = (clk_freq / oclk_prsc) Hz,
> +	 * so pulse_width = fiper * clk_freq / (2 * NSEC_PER_SEC * oclk_prsc).
> +	 */
> +	divisor = mul_u32_u32(2 * NSEC_PER_SEC, priv->oclk_prsc);
> +	pulse_width = div64_u64(mul_u32_u32(fiper, priv->clk_freq), divisor);
> +
> +	/* The FIPER_PW field only has 5 bits, need to update oclk_prsc */
> +	if (pulse_width > NETC_TMR_FIPER_MAX_PW)
> +		pulse_width = NETC_TMR_FIPER_MAX_PW;
> +
> +	return pulse_width;
> +}
> +
> +static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
> +				     u32 integral_period)
> +{
> +	u64 alarm;
> +
> +	/* Get the alarm value */
> +	alarm = netc_timer_cur_time_read(priv) +  NSEC_PER_MSEC;
> +	alarm = roundup_u64(alarm, NSEC_PER_SEC);
> +	alarm = roundup_u64(alarm, integral_period);
> +
> +	netc_timer_alarm_write(priv, alarm, 0);
> +}
> +
> +/* Note that users should not use this API to output PPS signal on
> + * external pins, because PTP_CLK_REQ_PPS trigger internal PPS event
> + * for input into kernel PPS subsystem. See:
> + * https://lore.kernel.org/r/20201117213826.18235-1-a.fatoum@pengutronix.de
> + */
> +static int netc_timer_enable_pps(struct netc_timer *priv,
> +				 struct ptp_clock_request *rq, int on)
> +{
> +	u32 fiper, fiper_ctrl;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> +
> +	if (on) {
> +		u32 integral_period, fiper_pw;
> +
> +		if (priv->pps_enabled)
> +			goto unlock_spinlock;
> +
> +		integral_period = netc_timer_get_integral_period(priv);
> +		fiper = NSEC_PER_SEC - integral_period;
> +		fiper_pw = netc_timer_calculate_fiper_pw(priv, fiper);
> +		fiper_ctrl &= ~(FIPER_CTRL_DIS(0) | FIPER_CTRL_PW(0) |
> +				FIPER_CTRL_FS_ALARM(0));
> +		fiper_ctrl |= FIPER_CTRL_SET_PW(0, fiper_pw);
> +		priv->tmr_emask |= TMR_TEVNET_PPEN(0) | TMR_TEVENT_ALMEN(0);
> +		priv->pps_enabled = true;
> +		netc_timer_set_pps_alarm(priv, 0, integral_period);
> +	} else {
> +		if (!priv->pps_enabled)
> +			goto unlock_spinlock;
> +
> +		fiper = NETC_TMR_DEFAULT_FIPER;
> +		priv->tmr_emask &= ~(TMR_TEVNET_PPEN(0) |
> +				     TMR_TEVENT_ALMEN(0));
> +		fiper_ctrl |= FIPER_CTRL_DIS(0);
> +		priv->pps_enabled = false;
> +		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
> +	}
> +
> +	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
> +	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
> +	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> +
> +unlock_spinlock:
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return 0;
> +}
> +
> +static void netc_timer_disable_pps_fiper(struct netc_timer *priv)
> +{
> +	u32 fiper_ctrl;
> +
> +	if (!priv->pps_enabled)
> +		return;
> +
> +	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> +	fiper_ctrl |= FIPER_CTRL_DIS(0);
> +	netc_timer_wr(priv, NETC_TMR_FIPER(0), NETC_TMR_DEFAULT_FIPER);
> +	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> +}
> +
> +static void netc_timer_enable_pps_fiper(struct netc_timer *priv)
> +{
> +	u32 fiper_ctrl, integral_period, fiper;
> +
> +	if (!priv->pps_enabled)
> +		return;
> +
> +	integral_period = netc_timer_get_integral_period(priv);
> +	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> +	fiper_ctrl &= ~FIPER_CTRL_DIS(0);
> +	fiper = NSEC_PER_SEC - integral_period;
> +
> +	netc_timer_set_pps_alarm(priv, 0, integral_period);
> +	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
> +	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> +}
> +
> +static int netc_timer_enable(struct ptp_clock_info *ptp,
> +			     struct ptp_clock_request *rq, int on)
> +{
> +	struct netc_timer *priv = ptp_to_netc_timer(ptp);
> +
> +	switch (rq->type) {
> +	case PTP_CLK_REQ_PPS:
> +		return netc_timer_enable_pps(priv, rq, on);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
>  static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
>  {
>  	u32 fractional_period = lower_32_bits(period);
> @@ -136,8 +309,11 @@ static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
>  	old_tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
>  	tmr_ctrl = u32_replace_bits(old_tmr_ctrl, integral_period,
>  				    TMR_CTRL_TCLK_PERIOD);
> -	if (tmr_ctrl != old_tmr_ctrl)
> +	if (tmr_ctrl != old_tmr_ctrl) {
> +		netc_timer_disable_pps_fiper(priv);
>  		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> +		netc_timer_enable_pps_fiper(priv);
> +	}
>
>  	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
>
> @@ -163,6 +339,8 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
>
>  	spin_lock_irqsave(&priv->lock, flags);
>
> +	netc_timer_disable_pps_fiper(priv);
> +
>  	/* Adjusting TMROFF instead of TMR_CNT is that the timer
>  	 * counter keeps increasing during reading and writing
>  	 * TMR_CNT, which will cause latency.
> @@ -171,6 +349,8 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
>  	tmr_off += delta;
>  	netc_timer_offset_write(priv, tmr_off);
>
> +	netc_timer_enable_pps_fiper(priv);
> +
>  	spin_unlock_irqrestore(&priv->lock, flags);
>
>  	return 0;
> @@ -205,8 +385,12 @@ static int netc_timer_settime64(struct ptp_clock_info *ptp,
>  	unsigned long flags;
>
>  	spin_lock_irqsave(&priv->lock, flags);
> +
> +	netc_timer_disable_pps_fiper(priv);
>  	netc_timer_offset_write(priv, 0);
>  	netc_timer_cnt_write(priv, ns);
> +	netc_timer_enable_pps_fiper(priv);
> +
>  	spin_unlock_irqrestore(&priv->lock, flags);
>
>  	return 0;
> @@ -232,10 +416,13 @@ static const struct ptp_clock_info netc_timer_ptp_caps = {
>  	.name		= "NETC Timer PTP clock",
>  	.max_adj	= 500000000,
>  	.n_pins		= 0,
> +	.n_alarm	= 2,
> +	.pps		= 1,
>  	.adjfine	= netc_timer_adjfine,
>  	.adjtime	= netc_timer_adjtime,
>  	.gettimex64	= netc_timer_gettimex64,
>  	.settime64	= netc_timer_settime64,
> +	.enable		= netc_timer_enable,
>  };
>
>  static void netc_timer_init(struct netc_timer *priv)
> @@ -252,7 +439,7 @@ static void netc_timer_init(struct netc_timer *priv)
>  	 * domain are not accessible.
>  	 */
>  	tmr_ctrl = FIELD_PREP(TMR_CTRL_CK_SEL, priv->clk_select) |
> -		   TMR_CTRL_TE;
> +		   TMR_CTRL_TE | TMR_CTRL_FS;
>  	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
>  	netc_timer_wr(priv, NETC_TMR_PRSC, priv->oclk_prsc);
>
> @@ -372,6 +559,66 @@ static int netc_timer_parse_dt(struct netc_timer *priv)
>  	return netc_timer_get_reference_clk_source(priv);
>  }
>
> +static irqreturn_t netc_timer_isr(int irq, void *data)
> +{
> +	struct netc_timer *priv = data;
> +	struct ptp_clock_event event;
> +	u32 tmr_event;
> +
> +	spin_lock(&priv->lock);
> +
> +	tmr_event = netc_timer_rd(priv, NETC_TMR_TEVENT);
> +	tmr_event &= priv->tmr_emask;
> +	/* Clear interrupts status */
> +	netc_timer_wr(priv, NETC_TMR_TEVENT, tmr_event);
> +
> +	if (tmr_event & TMR_TEVENT_ALMEN(0))
> +		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
> +
> +	if (tmr_event & TMR_TEVENT_PPEN_ALL) {
> +		event.type = PTP_CLOCK_PPS;
> +		ptp_clock_event(priv->clock, &event);
> +	}
> +
> +	spin_unlock(&priv->lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int netc_timer_init_msix_irq(struct netc_timer *priv)
> +{
> +	struct pci_dev *pdev = priv->pdev;
> +	char irq_name[64];
> +	int err, n;
> +
> +	n = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
> +	if (n != 1) {
> +		err = (n < 0) ? n : -EPERM;
> +		dev_err(&pdev->dev, "pci_alloc_irq_vectors() failed\n");
> +		return err;
> +	}
> +
> +	priv->irq = pci_irq_vector(pdev, 0);
> +	snprintf(irq_name, sizeof(irq_name), "ptp-netc %s", pci_name(pdev));
> +	err = request_irq(priv->irq, netc_timer_isr, 0, irq_name, priv);
> +	if (err) {
> +		dev_err(&pdev->dev, "request_irq() failed\n");
> +		pci_free_irq_vectors(pdev);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static void netc_timer_free_msix_irq(struct netc_timer *priv)
> +{
> +	struct pci_dev *pdev = priv->pdev;
> +
> +	disable_irq(priv->irq);
> +	free_irq(priv->irq, priv);
> +	pci_free_irq_vectors(pdev);
> +}
> +
>  static int netc_timer_probe(struct pci_dev *pdev,
>  			    const struct pci_device_id *id)
>  {
> @@ -395,17 +642,23 @@ static int netc_timer_probe(struct pci_dev *pdev,
>  	priv->oclk_prsc = NETC_TMR_DEFAULT_PRSC;
>  	spin_lock_init(&priv->lock);
>
> +	err = netc_timer_init_msix_irq(priv);
> +	if (err)
> +		goto timer_pci_remove;
> +
>  	netc_timer_init(priv);
>  	priv->clock = ptp_clock_register(&priv->caps, dev);
>  	if (IS_ERR(priv->clock)) {
>  		err = PTR_ERR(priv->clock);
> -		goto timer_pci_remove;
> +		goto free_msix_irq;
>  	}
>
>  	priv->phc_index = ptp_clock_index(priv->clock);
>
>  	return 0;
>
> +free_msix_irq:
> +	netc_timer_free_msix_irq(priv);
>  timer_pci_remove:
>  	netc_timer_pci_remove(pdev);
>
> @@ -417,6 +670,7 @@ static void netc_timer_remove(struct pci_dev *pdev)
>  	struct netc_timer *priv = pci_get_drvdata(pdev);
>
>  	ptp_clock_unregister(priv->clock);
> +	netc_timer_free_msix_irq(priv);
>  	netc_timer_pci_remove(pdev);
>  }
>
> --
> 2.34.1
>

