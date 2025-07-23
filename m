Return-Path: <netdev+bounces-209399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC40B0F7CC
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 18:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33DC9965AA0
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 16:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223401DF756;
	Wed, 23 Jul 2025 16:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oYKsflPP"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012008.outbound.protection.outlook.com [52.101.66.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8D04A28;
	Wed, 23 Jul 2025 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753286950; cv=fail; b=noUaWTQmrLvdIcE7OBspjupCg+QbpyYpWNKbLo4oY5CRi/4zeQ1qR9dIJE8uyu+tMFHUVJODXkNVSX9y7cpg+k6PhjtUqxbPesBJhm1UO2YJdHpVE7qaJ9mCDhixa+Z1Mc7Ioe1UGiDNgI45Nv8z0Ew5wq6cQJLxPp45jn0b/Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753286950; c=relaxed/simple;
	bh=xMEcyROyWRD2MKYCIdM3UZi+qFaFJPUeAlTl52AIb4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bUfVYWkjsARxLzF8Isb17gn8uK/ilCgHN3SNL0ZLKmiNOmiJVhcxdMD14dFB9jlrVvYW9okD76g+rZdIlXKQBcUOb1rNem8o7iDhjTfELV7dCTniRqGXyQXiW+caDQfMywJHBhFfwK8Y5SfcEwZElptKK1OmKJn9OooLeIFd+jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oYKsflPP; arc=fail smtp.client-ip=52.101.66.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWct8X5IkcD5Ls9zOzkLab7BbQMbgayxNNPDeyRo4Ns4Wr3ByPf0DUnbZpmM+ZIBFWcRc7C3ujHG8Td7QWo8M7mWH+maHUznFCEabbzAP0IGWksY6aEW7/t01E1AFraustMNmGsfVSopKIj1Vznf6DRl6oYkWfjCnKdN/lI+6K51YlaTkDg0HPnif0z34X6mx0YB1DXGW+fWLwGVkXL8t4xw2Aay0w8I5pXaUH6E1gaCOaIkd6ZHVS1BRKVfYXkYXAFQndZYDFKNg5T8EevLmzJ0uio6MI+wo3tpDzZxQLVmJD/18t2oL8FN2ngLrQULzbcbyJJjZ5jUwesHJ1PCFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5knbl/fjtFfEdnqxUCZ1RyCoSRdC2r8RJlb4Bgx2g0=;
 b=S0e9zNBsKzAGob9rGiCid3XH3qwNaz4ETc/HeEH3oK1Pk61JVtYO/NYm8i1MEKNkyk3S7hyAJ1L+pXMq8hHCrslhBxN8e/mmqvP0I3MnxnfPzcEH+DMZHewssclbXBLPJNzqYTh+7TscsuyhDD7VZxyMiATK3Iz6lvXZIfTD9kMPGFtlekSTHrWbss07DMHGFk1QG1E+w98+7oNScPUBFgvYsrVw/vvU2vQIAquLSJtJD+FCsCYYHBKgTGFSIGu1+t/uu8bmzc8tCUG496dNrXR6d80g9fdeXCMXsqS8rLoTKtXYWPjqWeIGeIS9ziqR8QEtZn2hfFNEMKlNyLOaJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5knbl/fjtFfEdnqxUCZ1RyCoSRdC2r8RJlb4Bgx2g0=;
 b=oYKsflPPq3YDfFL55YXQUroIoOU9+SoAj0tfIE/esiS9jZGYx05J5gK93Tm2m9HxiWqL4JEJkLWiHKWRGxw/AK/2sV3o+/p+IbFh7kIaVxLu1p+pvICn6mYztquA9kP6ssUdiE3p2/xbSb27pl008bM1JDX1EdzbLyk38yQGBtyWmS5tFTzUKyeNFVMIGvgyMU0QJ0ulLTicXaBWtDH3+v3JWKJJnAusqy02k6quaOK+nwf96PH4GM/wQIMSWbwupJMiksg0mqyyWpG9slF2nxIHY2jYzzXYdEcxiEot5wh1zeGjpCZU93DgGD45joZv3I0H00xL3GElYgocQjh4ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM0PR04MB7156.eurprd04.prod.outlook.com (2603:10a6:208:19b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 16:09:04 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 16:09:04 +0000
Date: Wed, 23 Jul 2025 19:09:00 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	richardcochran@gmail.com, claudiu.manoil@nxp.com,
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	vadim.fedorenko@linux.dev, Frank.Li@nxp.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com, fushi.peng@nxp.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: Re: [PATCH v2 net-next 03/14] ptp: netc: add NETC Timer PTP driver
 support
Message-ID: <20250723160900.x57uikenvbd7223c@skbuf>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-4-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716073111.367382-4-wei.fang@nxp.com>
X-ClientProxiedBy: VI1PR0902CA0053.eurprd09.prod.outlook.com
 (2603:10a6:802:1::42) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM0PR04MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c41d603-4e09-40ae-70c2-08ddca033e96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|19092799006|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iJGbaQl7LfJwKBeg2bQt4pMG1tPoZHxTvnXPhGDDEW4nnNrQrRalW/d1E8vC?=
 =?us-ascii?Q?O1oiPqJjoo1BVhjNN0tvGajKNAMZxregOfEhpSqpHz3nqBsEnYo+U6VgqKBJ?=
 =?us-ascii?Q?pVNzqwQwF7FtnRFs/kWhYd6HARfEsCBWZG0moqfgFKOBY1csnLcrSi2wXkXj?=
 =?us-ascii?Q?zxjZSBC6Zr0NMRENYc2X3mV2/UWC7CaCEUOE0neC0UWj8ym/1DO2WfpH6fPK?=
 =?us-ascii?Q?KbEAekWKkAediBNLAH3lblkDbt0qjmw+l8ike6r0xpLpjKl59w4ccGZ/5122?=
 =?us-ascii?Q?b3OD1lORk7zPm55DQASm1I53ZZa75MyXKQS1X75BZr90SrPyGqbXbVoPEJHg?=
 =?us-ascii?Q?eO10mP5D5C+uCHFt90EHCvdZ8kW2ZyAF363/5wbkjcchr4g+L8DaMXrj+mW1?=
 =?us-ascii?Q?09qI4EXUjsZTgGDeNfKfM5Vw+4sh2pYQNOWdAoeBip080q/fprDYNkJ6Iosi?=
 =?us-ascii?Q?RE7LSosI2VA/OtaO5f2a2//vemz2Lgd4a+InC8Ngl7kZkBliYNC7e8q0jcIB?=
 =?us-ascii?Q?Fr1PISNUQpiCaexhRtVG065n+KwyFndqWL88PZcXz1LpWculj+JE/heyjpIF?=
 =?us-ascii?Q?/TVgIFdlsgg7YtskRvDb5esyvBCwaI3GY277/UC1aJNPzMZpcgo/PqGP400Y?=
 =?us-ascii?Q?dJmPN1zE+lGl0UulmyJW7x9T4NTkZoPoTPwx2d/dbgHze0WPGKmI7L82HLxf?=
 =?us-ascii?Q?rZ0yD1VIXMGbIN2u/OTHPIENGM9mOjUpE1VDjh1fuuaInXbsEy/4vrC1GtZM?=
 =?us-ascii?Q?NKjrnul4UbxG+aUMXWSAaL6L+1z/PP2Fm9oIcIpqAeHVQjaaIUNttH6yZL1a?=
 =?us-ascii?Q?7ERWjva4SuzlcOULP1uZwJBQeTn0reoohMevC+riHLMnGE1hDCg8Aymv1I7I?=
 =?us-ascii?Q?FBBrkO1GCVf+6S3AHAzlqqMr3mVhOv9N0euU1hQWfb49XzoXgpBv38OZtVa1?=
 =?us-ascii?Q?c0R5t89a7prOPS9+hP8ZkBU20xX87LiMr0c/ANjcpIfNbbd/kYfZTERKPcqM?=
 =?us-ascii?Q?9kyVXxIoFfRBbYC6GLmhqVDthJwv31pzOdPKX1HaP7ovYAJEMPsutVIfrhGr?=
 =?us-ascii?Q?m3biSnPNf7FIxJjdqc6CWDrCzHK3FuiHRQJ871SPLHpNcMrd6/POhibi+SQm?=
 =?us-ascii?Q?OpD3uNWUxYFw4i50gsQJURTrDAJAPAJ7D5vplZHEhcrXDp6/pfC9C1SQ5Xt6?=
 =?us-ascii?Q?VM7qayoWMH4JuaalvxG9ktjMe225iddlstQw7z4VyYorfXTyCHvaAbhU6Grf?=
 =?us-ascii?Q?6ktLbmMAroSHQyXn7+BA3395rkxPgE83hjk2ntPFi11fLeL2nrwTMndgiMhP?=
 =?us-ascii?Q?91JudYvzYM5MLnnLiFoV8e0HXZO41LP3tDLHvBADzn8RY5x3eZ6HpH2zQ30O?=
 =?us-ascii?Q?/gCCBqyOA7e5TnsKI1HKlMPc2WDqi02L6bP9F9B9YrPd5/ByiitvWH6HPAJ4?=
 =?us-ascii?Q?e3aYDB3URt4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(19092799006)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9V/6iop8mLhQaJzurE6ePyJnndouOcZpNAxPZx1+nWcprq267j+lbolsVgdm?=
 =?us-ascii?Q?S/yGaajH3kFBoDHzZI4adttTQuCgD+7jO7UR46EpG2aATVt9I+l8sk2+9YSB?=
 =?us-ascii?Q?1ugjnMUGpSs2W+QgtMRGZWiTKIvqBGEG5fT7ifYvvS1bapVw/yuDkOgIbERa?=
 =?us-ascii?Q?jNv2Khptel1YRBexk8awg/iMjcJ1BCflusJh5cv69DU3K48Xuj0k4OJEzMuC?=
 =?us-ascii?Q?WP0GMDBwUd9+X5kxFAnHr9+hYwDaSy4FeMJeZ6SLpbhpr3b6gGOFMWHu1Dex?=
 =?us-ascii?Q?vaKiWD8RiiuJR8rX+uKO8toRNRVv6sVA5wK1vov1jTSBk0egZOe8fv5zdJNk?=
 =?us-ascii?Q?g5VolRZLR0Al5q1zec0E6HsfmGF1BsT7FyDECmq5VcAwoOZkeLFVk49HAN9N?=
 =?us-ascii?Q?IHzi+F/5ZJURhjk9v6dOe+x9NseY2bcFcqcfeKNDCWngWTNiQFH+cJerHM7D?=
 =?us-ascii?Q?NMCm/xKmsorGZVBe5igRLTlVvWJyB9Z8tINZAw0Yx7IZcLdhTxTDv/MK6P4B?=
 =?us-ascii?Q?PQ1ZG3FS5vLUE6rolJF9j3eBqLrRAwYjQOzidNbRF00neLqirzfF5FIJ1U5O?=
 =?us-ascii?Q?0nRgjbVeJhxdaEweUgS9rKfGQzUBvd/bpmt9fVFBQ/gRubTui8rQkKM4Jjum?=
 =?us-ascii?Q?YQJK07R9J2DNn1L4j8HGUS7HLYky9ImcedWvJX7EUf7UEWA4WwkEtDLBdubZ?=
 =?us-ascii?Q?3zJvKoFpgpx91Ru8VWZHi4YjJ6zSXIg4+fml6aBrJP4Wu1S0eE7eRPkPOuN4?=
 =?us-ascii?Q?TJ98IUjOc53iB5csW+s5bZns15+AldrRHphzMNoHXxYt4Zph/MymzVP6fUJq?=
 =?us-ascii?Q?y6NlR3/pFc9BPbMx+91dr1VOQiVCHja/ca1ebjmrA2wmZcZVwWd23jwY1txY?=
 =?us-ascii?Q?1w0xESrbspxKBLKgL4xyp3XmvSsQpygXtTlnKw79FGSAt3TwHNw82N7IXeK9?=
 =?us-ascii?Q?iO6CEUZVbJF+W7t7KkNQD+HWpLrKEFct8IjJAjz7fLua+w1I+oOG84fDYNju?=
 =?us-ascii?Q?+Mxd5jT4XSwP926nKfAF0R2PvBBX/Er6CxBeUh8u7prCyD35V46fk3fbSwpQ?=
 =?us-ascii?Q?D4aLQkJAhT62wptAAtUwAvKMUejtR2v6P8OcNkZsY2NlZtfp98SiO532RXGv?=
 =?us-ascii?Q?vC/DWwbdGa4vQjVyHGIxkW50F74/YA48ubPAm5/DmA3ew3R+I9+SDfroI6Hi?=
 =?us-ascii?Q?tdD1G8taxZDvl+PyWeJuPze2xPiZjeuKQ8Irb9SylQ656qIwvrE/8cnhG+Wp?=
 =?us-ascii?Q?KWDjw1M5dvycIQ7cIe0zlGmq0ZP8x0ZfjrrkJe0dl5ItpJiGSF5rq93rMvY+?=
 =?us-ascii?Q?BR7sybT+5BflOndC7zWkcelHDOkILb1hGc6Hb5BiSCmQTdHcOKdkVZKhnrR1?=
 =?us-ascii?Q?BUge0NonviSqAIsdblXc0G7BHAY7YoBH4BhBo2Yqyw4VX5tAFpqntmzIIeBc?=
 =?us-ascii?Q?ToujUh31Fowr94jaOFKio4344q5fr5Mu3/oHL+KZx5fUx6CIS0Y+IM++/lM+?=
 =?us-ascii?Q?95Nyg7/NQiJhxs2YRy4eB92eHfTn2IEBoaoXAGXYsoJSH9M29ri8pp4djzID?=
 =?us-ascii?Q?ESAZMaVqunwiwvlrU5Hu2dJUyHG958sRaDtnmRB+hydiwCHxPM3HqjKY8DVF?=
 =?us-ascii?Q?5eOoiUK63qT0gy7WCmT+gzB81i5PYwmlG+6hpPl7j+0Svu9Ln+3jUkva9lr9?=
 =?us-ascii?Q?mX0VfQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c41d603-4e09-40ae-70c2-08ddca033e96
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 16:09:04.2299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1nEgGfIv+RNlrPFjh4TciFC/SZwa4hkuL/MnMQcl2C2QYoU6lN2M8n9f0wjRRaKdGMtvEy+M2YN6/7bD90irQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7156

On Wed, Jul 16, 2025 at 03:31:00PM +0800, Wei Fang wrote:
> NETC Timer provides current time with nanosecond resolution, precise
> periodic pulse, pulse on timeout (alarm), and time capture on external
> pulse support. And it supports time synchronization as required for
> IEEE 1588 and IEEE 802.1AS-2020. The enetc v4 driver can implement PTP
> synchronization through the relevant interfaces provided by the driver.
> Note that the current driver does not support PEROUT, PPS and EXTTS yet,
> and support will be added one by one in subsequent patches.

Would you mind adding a paragraph justifying why you are introducing a
new driver, rather than extending the similar ptp_qoriq.c?

> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> 
> ---
> v2 changes:
> 1. Rename netc_timer_get_source_clk() to
>    netc_timer_get_reference_clk_source() and refactor it
> 2. Remove the scaled_ppm check in netc_timer_adjfine()
> 3. Add a comment in netc_timer_cur_time_read()
> 4. Add linux/bitfield.h to fix the build errors
> ---
>  drivers/ptp/Kconfig             |  11 +
>  drivers/ptp/Makefile            |   1 +
>  drivers/ptp/ptp_netc.c          | 568 ++++++++++++++++++++++++++++++++
>  include/linux/fsl/netc_global.h |  12 +-
>  4 files changed, 591 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/ptp/ptp_netc.c
> 
> diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
> index 204278eb215e..3e005b992aef 100644
> --- a/drivers/ptp/Kconfig
> +++ b/drivers/ptp/Kconfig
> @@ -252,4 +252,15 @@ config PTP_S390
>  	  driver provides the raw clock value without the delta to
>  	  userspace. That way userspace programs like chrony could steer
>  	  the kernel clock.
> +
> +config PTP_1588_CLOCK_NETC
> +	bool "NXP NETC Timer PTP Driver"
> +	depends on PTP_1588_CLOCK=y
> +	depends on PCI_MSI
> +	help
> +	  This driver adds support for using the NXP NETC Timer as a PTP
> +	  clock. This clock is used by ENETC MAC or NETC Switch for PTP
> +	  synchronization. It also supports periodic output signal (e.g.
> +	  PPS) and external trigger timestamping.
> +
>  endmenu
> diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
> index 25f846fe48c9..d48fe4009fa4 100644
> --- a/drivers/ptp/Makefile
> +++ b/drivers/ptp/Makefile
> @@ -23,3 +23,4 @@ obj-$(CONFIG_PTP_1588_CLOCK_VMW)	+= ptp_vmw.o
>  obj-$(CONFIG_PTP_1588_CLOCK_OCP)	+= ptp_ocp.o
>  obj-$(CONFIG_PTP_DFL_TOD)		+= ptp_dfl_tod.o
>  obj-$(CONFIG_PTP_S390)			+= ptp_s390.o
> +obj-$(CONFIG_PTP_1588_CLOCK_NETC)	+= ptp_netc.o
> diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
> new file mode 100644
> index 000000000000..82cb1e6a0fe9
> --- /dev/null
> +++ b/drivers/ptp/ptp_netc.c
> @@ -0,0 +1,568 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * NXP NETC Timer driver
> + * Copyright 2025 NXP
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/fsl/netc_global.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/ptp_clock_kernel.h>
> +
> +#define NETC_TMR_PCI_VENDOR		0x1131
> +#define NETC_TMR_PCI_DEVID		0xee02
> +
> +#define NETC_TMR_CTRL			0x0080
> +#define  TMR_CTRL_CK_SEL		GENMASK(1, 0)
> +#define  TMR_CTRL_TE			BIT(2)
> +#define  TMR_COMP_MODE			BIT(15)
> +#define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
> +#define  TMR_CTRL_FS			BIT(28)
> +#define  TMR_ALARM1P			BIT(31)
> +
> +#define NETC_TMR_TEVENT			0x0084
> +#define  TMR_TEVENT_ALM1EN		BIT(16)
> +#define  TMR_TEVENT_ALM2EN		BIT(17)
> +
> +#define NETC_TMR_TEMASK			0x0088
> +#define NETC_TMR_CNT_L			0x0098
> +#define NETC_TMR_CNT_H			0x009c
> +#define NETC_TMR_ADD			0x00a0
> +#define NETC_TMR_PRSC			0x00a8
> +#define NETC_TMR_OFF_L			0x00b0
> +#define NETC_TMR_OFF_H			0x00b4
> +
> +/* i = 0, 1, i indicates the index of TMR_ALARM */
> +#define NETC_TMR_ALARM_L(i)		(0x00b8 + (i) * 8)
> +#define NETC_TMR_ALARM_H(i)		(0x00bc + (i) * 8)
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
> +#define NETC_TMR_DEFAULT_ALARM		GENMASK_ULL(63, 0)
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
> +	struct clk *src_clk;
> +	struct ptp_clock *clock;
> +	struct ptp_clock_info caps;
> +	int phc_index;
> +	u32 clk_select;
> +	u32 clk_freq;
> +	u32 oclk_prsc;
> +	/* High 32-bit is integer part, low 32-bit is fractional part */
> +	u64 period;
> +
> +	int irq;
> +};
> +
> +#define netc_timer_rd(p, o)		netc_read((p)->base + (o))
> +#define netc_timer_wr(p, o, v)		netc_write((p)->base + (o), v)
> +#define ptp_to_netc_timer(ptp)		container_of((ptp), struct netc_timer, caps)
> +
> +static u64 netc_timer_cnt_read(struct netc_timer *priv)
> +{
> +	u32 tmr_cnt_l, tmr_cnt_h;
> +	u64 ns;
> +
> +	/* The user must read the TMR_CNC_L register first to get
> +	 * correct 64-bit TMR_CNT_H/L counter values.
> +	 */
> +	tmr_cnt_l = netc_timer_rd(priv, NETC_TMR_CNT_L);
> +	tmr_cnt_h = netc_timer_rd(priv, NETC_TMR_CNT_H);
> +	ns = (((u64)tmr_cnt_h) << 32) | tmr_cnt_l;
> +
> +	return ns;
> +}
> +
> +static void netc_timer_cnt_write(struct netc_timer *priv, u64 ns)
> +{
> +	u32 tmr_cnt_h = upper_32_bits(ns);
> +	u32 tmr_cnt_l = lower_32_bits(ns);
> +
> +	/* The user must write to TMR_CNT_L register first. */
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
> +	u64 tmr_cnt, tmr_off;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	tmr_off = netc_timer_offset_read(priv);
> +	if (delta < 0 && tmr_off < abs(delta)) {

You go to great lengths to avoid letting TMROFF become negative, but is
there any problem if you just let it do so, and delete the imprecise
"TMR_CNT += delta" code path altogether? An addition with the two's
complement of a number is the same as a subtraction.

Let's say delta=-10, and the current TMROFF value is 5.
Your condition deviates the adjustment through the imprecise method,
but if we write TMROFF = -5 = 0xffffffff_fffffffb, we should get the
correct result, no?

I thought about this a number of ways, and they all seem to be fine.
Like, the worst thing that can happen is a TMROFF value which became
negative by accident, due to too many netc_timer_adjtime() values with a
large (but positive) delta.

But even that should be fine, because an overflow on TMROFF is
indistinguishable from an overflow on TMR_CNT.

Anyway, _this_ is the time of logic which could really use a comment to
explain the intention behind it.

> +		delta += tmr_off;
> +		if (!tmr_off)
> +			netc_timer_offset_write(priv, 0);
> +
> +		tmr_cnt = netc_timer_cnt_read(priv);
> +		tmr_cnt += delta;
> +		netc_timer_cnt_write(priv, tmr_cnt);
> +	} else {
> +		tmr_off += delta;
> +		netc_timer_offset_write(priv, tmr_off);
> +	}
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
> +int netc_timer_get_phc_index(struct pci_dev *timer_pdev)
> +{
> +	struct netc_timer *priv;
> +
> +	if (!timer_pdev)
> +		return -ENODEV;
> +
> +	priv = pci_get_drvdata(timer_pdev);
> +	if (!priv)
> +		return -EINVAL;
> +
> +	return priv->phc_index;
> +}
> +EXPORT_SYMBOL_GPL(netc_timer_get_phc_index);
> +
> +static const struct ptp_clock_info netc_timer_ptp_caps = {
> +	.owner		= THIS_MODULE,
> +	.name		= "NETC Timer PTP clock",
> +	.max_adj	= 500000000,
> +	.n_alarm	= 2,

Is n_alarm functionally hooked with anything in the PTP core, other than
the "n_alarms" read-only sysfs? I didn't see anything.

> +	.n_pins		= 0,
> +	.adjfine	= netc_timer_adjfine,
> +	.adjtime	= netc_timer_adjtime,
> +	.gettimex64	= netc_timer_gettimex64,
> +	.settime64	= netc_timer_settime64,
> +};
> +
> +static void netc_timer_init(struct netc_timer *priv)
> +{
> +	u32 tmr_emask = TMR_TEVENT_ALM1EN | TMR_TEVENT_ALM2EN;
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
> +	tmr_ctrl = (priv->clk_select & TMR_CTRL_CK_SEL) | TMR_CTRL_TE;

Candidate for FIELD_PREP()?

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
> +	tmr_ctrl |= ((integral_period << 16) & TMR_CTRL_TCLK_PERIOD) |

Candidate for FIELD_PREP()?

> +		     TMR_COMP_MODE | TMR_CTRL_FS;
> +	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> +	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
> +	netc_timer_wr(priv, NETC_TMR_TEMASK, tmr_emask);
> +}
> +
> +static int netc_timer_pci_probe(struct pci_dev *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct netc_timer *priv;
> +	int err, len;
> +
> +	pcie_flr(pdev);
> +	err = pci_enable_device_mem(pdev);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to enable device\n");
> +
> +	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	if (err) {
> +		dev_err(dev, "dma_set_mask_and_coherent() failed, err:%pe\n",
> +			ERR_PTR(err));
> +		goto disable_dev;
> +	}
> +
> +	err = pci_request_mem_regions(pdev, KBUILD_MODNAME);
> +	if (err) {
> +		dev_err(dev, "pci_request_regions() failed, err:%pe\n",
> +			ERR_PTR(err));
> +		goto disable_dev;
> +	}
> +
> +	pci_set_master(pdev);
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv) {
> +		err = -ENOMEM;
> +		goto release_mem_regions;
> +	}
> +
> +	priv->pdev = pdev;
> +	len = pci_resource_len(pdev, NETC_TMR_REGS_BAR);
> +	priv->base = ioremap(pci_resource_start(pdev, NETC_TMR_REGS_BAR), len);
> +	if (!priv->base) {
> +		err = -ENXIO;
> +		dev_err(dev, "ioremap() failed\n");
> +		goto free_priv;
> +	}
> +
> +	pci_set_drvdata(pdev, priv);
> +
> +	return 0;
> +
> +free_priv:
> +	kfree(priv);
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
> +	kfree(priv);
> +	pci_release_mem_regions(pdev);
> +	pci_disable_device(pdev);
> +}
> +
> +static int netc_timer_get_reference_clk_source(struct netc_timer *priv)
> +{
> +	struct device *dev = &priv->pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	const char *clk_name = NULL;
> +	u64 ns = NSEC_PER_SEC;

Nitpick: It's strange to keep a constant in a variable.

> +
> +	/* Select NETC system clock as the reference clock by default */
> +	priv->clk_select = NETC_TMR_SYSTEM_CLK;
> +	priv->clk_freq = NETC_TMR_SYSCLK_333M;
> +	priv->period = div_u64(ns << 32, priv->clk_freq);

When reviewing, I found "NSEC_PER_SEC << 32" deeply confusing, since it
has no physical meaning, and I was left wondering "Why is priv->period
equal to 4294967296 ns divided by the clock frequency?".

It would be helpful if you added a comment explaining that in order to
store the period in the desired 32-bit fixed-point format, you can
multiply the numerator of the fraction by 2^32.

> +
> +	if (!np)
> +		return 0;
> +
> +	of_property_read_string(np, "clock-names", &clk_name);
> +	if (!clk_name)
> +		return 0;
> +
> +	/* Update the clock source of the reference clock if the clock
> +	 * name is specified in DTS node.
> +	 */
> +	if (!strcmp(clk_name, "system"))
> +		priv->clk_select = NETC_TMR_SYSTEM_CLK;
> +	else if (!strcmp(clk_name, "ccm_timer"))
> +		priv->clk_select = NETC_TMR_CCM_TIMER1;
> +	else if (!strcmp(clk_name, "ext_1588"))
> +		priv->clk_select = NETC_TMR_EXT_OSC;
> +	else
> +		return -EINVAL;
> +
> +	priv->src_clk = devm_clk_get(dev, clk_name);
> +	if (IS_ERR(priv->src_clk)) {
> +		dev_err(dev, "Failed to get reference clock source\n");

Can this return -EPROBE_DEFER? Should you use dev_err_probe() instead,
to suppress error messages in that case?

> +		return PTR_ERR(priv->src_clk);
> +	}
> +
> +	priv->clk_freq = clk_get_rate(priv->src_clk);
> +	priv->period = div_u64(ns << 32, priv->clk_freq);
> +
> +	return 0;
> +}
> +
> +static int netc_timer_parse_dt(struct netc_timer *priv)
> +{
> +	return netc_timer_get_reference_clk_source(priv);
> +}
> +
> +static irqreturn_t netc_timer_isr(int irq, void *data)
> +{
> +	struct netc_timer *priv = data;
> +	u32 tmr_event, tmr_emask;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&priv->lock, flags);

In hardirq context (this is not threaded) you don't need irqsave/irqrestore.

> +
> +	tmr_event = netc_timer_rd(priv, NETC_TMR_TEVENT);
> +	tmr_emask = netc_timer_rd(priv, NETC_TMR_TEMASK);

The value of the NETC_TMR_TEMASK register is a runtime invariant, does
it make sense to cache it in the driver, to avoid a register read per
interrupt?

> +
> +	tmr_event &= tmr_emask;
> +	if (tmr_event & TMR_TEVENT_ALM1EN)
> +		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
> +
> +	if (tmr_event & TMR_TEVENT_ALM2EN)
> +		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 1);

Writing GENMASK_ULL(63, 0) has the effect of disabling the alarm, right?
What is the functional need to have this logic wired up at this stage?
Somebody needs to have armed the alarm in the first place, yet I see no
such code.

> +
> +	/* Clear interrupts status */
> +	netc_timer_wr(priv, NETC_TMR_TEVENT, tmr_event);
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return IRQ_HANDLED;
> +}
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
> +	if (err) {
> +		dev_err(dev, "Failed to parse DT node\n");
> +		goto timer_pci_remove;
> +	}
> +
> +	priv->caps = netc_timer_ptp_caps;
> +	priv->oclk_prsc = NETC_TMR_DEFAULT_PRSC;
> +	priv->phc_index = -1; /* initialize it as an invalid index */

A better use of the comment space would be to explain why, not just to
add obvious and unhelpful subtitles to the code.

When is the priv->phc_index value of -1 preserved (not overwritten with
the ptp_clock_index() result)? It seems to be when the driver fails to
probe.

But in that case, doesn't device_unbind_cleanup() call "dev_set_drvdata(dev, NULL);",
to prevent what would otherwise be a use-after-free?

> +	spin_lock_init(&priv->lock);
> +
> +	err = clk_prepare_enable(priv->src_clk);
> +	if (err) {
> +		dev_err(dev, "Failed to enable timer source clock\n");
> +		goto timer_pci_remove;
> +	}
> +
> +	err = netc_timer_init_msix_irq(priv);
> +	if (err)
> +		goto disable_clk;
> +
> +	netc_timer_init(priv);
> +	priv->clock = ptp_clock_register(&priv->caps, dev);
> +	if (IS_ERR(priv->clock)) {
> +		err = PTR_ERR(priv->clock);
> +		goto free_msix_irq;
> +	}
> +
> +	priv->phc_index = ptp_clock_index(priv->clock);
> +
> +	return 0;
> +
> +free_msix_irq:
> +	netc_timer_free_msix_irq(priv);
> +disable_clk:
> +	clk_disable_unprepare(priv->src_clk);
> +timer_pci_remove:
> +	netc_timer_pci_remove(pdev);
> +
> +	return err;
> +}

