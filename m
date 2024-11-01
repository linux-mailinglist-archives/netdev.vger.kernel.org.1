Return-Path: <netdev+bounces-140997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 850569B9061
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 12:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA1E4B21E13
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 11:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6406719925B;
	Fri,  1 Nov 2024 11:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="adZ1/W5+"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2042.outbound.protection.outlook.com [40.107.241.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADCC194C89;
	Fri,  1 Nov 2024 11:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730461176; cv=fail; b=jseo5Q3gPubOjo7FtgnucS73paMAPIkUw2u/GuxVgZIA5HmVPiRkpYq0DZJ7xqHWDG0eiyAk5zUZ84bN4wjAYxRuxGwziUlHmnAyYJJ+DKViIU+TeQlXmrM+Qvq9aiWfrXZ//mvMLphxT5zu8E9NdGjeky7KSo+QfswXpk1z4Fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730461176; c=relaxed/simple;
	bh=lbpiujINvuzTmtxV46BA+ZWUgZr6EmLiAa46wWoR6/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iG9R81o9QjUWBI9fEc3l1+j2UolBg0zrE6MnwF5kuw6wFvvzVQYwMpmoO5tiRvYzhiOdlZJlEv2+JctyOVT8gWiQ1Uvj+A1Yw3R+yZmeAAdpKKVYC1X0yAiCDLeOzGBCMeGkxVl3vJX9jrCetVeJzm4jqUOVx/Rc467pRm6lzes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=adZ1/W5+; arc=fail smtp.client-ip=40.107.241.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGseMp73708a2gYKHE/bntYF4fgAMei8+FVxxDXVrgfNg6/ANhQsbbwjSdHuaZCTfdFLXxH26MF3R3dmMzPx5rpt6X+/+tqM2O59YeiDcsNDMhDNog4bcgM5N9spVEuu0RX1cn7PVwhiP3bFZUTMyBd/WALC+vfh4AjgJbDH378PCJbb8FvXE8kWVA8e3dWsjPzdDh+14vxUgqsBmU1u17lpdWoGqmRQVBvfBaTaYMmHCubgOfqoQF9ht/sde804QhBu+5Pn6Zr9dP3QV51rzt80ePSrERBBN4iop1FTBNOhuR3V3HUrbiIR+SXM5mPGZCDvzvco9+xmUxYCAiA2dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sR6LCq3jIt4aZ+dpxlJcaqwkbNTvmDkuaDptwWSSm9s=;
 b=nA2DcX3CwWf9y3q61kfIFgYjSy3BKFGQuAadqBjoyUP42dYDX3b95UXMMeR0zTP6YaYdfsotFp51RQ+uAzNfuXTrqp51wJvgdvz0Ep1GKUdoI9Qzw11JKLBS0SSFd00ORFhzSU6YklFTgGMWW/WcXSFxfcveXd0GFT9y22RH/AMR15IgCjiRQCBOiIe8UOtZ6nkucjvomlHMtA5g8+VHjD9uQb/BK2MMD23zTBpKsgcBLrvYz8V6dQDz2nlO2IpiJ15R31Cc1zDbBpdYGjxrzGVZe+JW5iSd6mAS/srGTflfmMC9+z+Sx3Fv/WcMeQ3PwVS6F1p1juYzki1E1UOU/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sR6LCq3jIt4aZ+dpxlJcaqwkbNTvmDkuaDptwWSSm9s=;
 b=adZ1/W5+Ni9asrwsoLYg5Snwxp1vtw5Ok6Dnssv2SAVl3+N9vK8AuoCfaN/4b3zaaOVeAjF+aUoZ7vugzuTk4dKW4ujfE8SXCZooshNME5nr1HsxkRsYOVKmeUzTnfh9xf2ce6c62ukPq9WQC5slvf/fYokxAVE63fHgPwiJo5ZDMXORV/c1w2YQ0nWjXUzgQ9zqp1476zJ9ysRWdnFju9wfS3qvdNUSGMNSPhKGHbwn8hHQEK3Y/FlcL6sX8vpTBF9DY8P69GeJAYYvE+RToFSBk3hrDF9ByjVYhRXHNks2CHxd/lYtdq1waIc3Cs0mLJaA5N9BoV/miJdrxLsK4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA2PR04MB10121.eurprd04.prod.outlook.com (2603:10a6:102:408::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 11:39:30 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 11:39:30 +0000
Date: Fri, 1 Nov 2024 13:39:27 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, claudiu.manoil@nxp.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH net 2/2] net: enetc: prevent PF from configuring MAC
 address for an enabled VF
Message-ID: <20241101113927.qwrocneytjlvittf@skbuf>
References: <20241031060247.1290941-1-wei.fang@nxp.com>
 <20241031060247.1290941-1-wei.fang@nxp.com>
 <20241031060247.1290941-3-wei.fang@nxp.com>
 <20241031060247.1290941-3-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031060247.1290941-3-wei.fang@nxp.com>
 <20241031060247.1290941-3-wei.fang@nxp.com>
X-ClientProxiedBy: VI1PR06CA0201.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::22) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA2PR04MB10121:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ecee7a4-a1fc-49f1-e784-08dcfa69d96b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9XoMxybVzrZW4YBSNdG4gZIJALrlTxABpvE/v8+BkQRfQ7boNGzj4vrLvaB5?=
 =?us-ascii?Q?FBTCdyR4UGPnz7X+6lC0wxeBOvru1//nEhJjMJH4/QYzhmQA7+kDRAPSjwCz?=
 =?us-ascii?Q?l/H7aKKNCPPXDQWkXGYWCIwbFARLjhZWdzcuy5hzkR8BlTxu54lrvzvgYWr0?=
 =?us-ascii?Q?20fPVXOri3lTWLvshHzBgYCBFXgKYvyOVSjYosTwb8+7fMayiDdWW2/yVRm3?=
 =?us-ascii?Q?yjgfeJ6EBkog10Edi84en+qgLwzyR2OOMMcj+5YMAxwOsmIQCNw36JTEDi0R?=
 =?us-ascii?Q?XH33ZXaIaDS/FI5OzkfrEYDyCWhoUrqfzdnSE8iGaWcZJbcRVj361PaRe4xB?=
 =?us-ascii?Q?COgZK3jYmRVN2G9P1xxl502n7Dtqnrdz4mLDW3ev2dH0fWZoQjRo45qTkTWk?=
 =?us-ascii?Q?3Dl7/p0MUP7mk1dwLAhyJzGTQyZTLpw8v38lFCQNgl/qoOBY8RZX6MwOoLrT?=
 =?us-ascii?Q?dOIRKuEsMR0lc7cd22vXS8UTSx+kwBfNp3CfIGOfc0an4sh2Sm/uARM8hQzL?=
 =?us-ascii?Q?iw8W9+bd01UrUsMwUl3lDaUq2oZhTKOVB682H7GdvOquTjaS1XDLI8zSRlhJ?=
 =?us-ascii?Q?KJuWUrEUaVkqtbGXegpvglpLIdwUJJPm+bqcLS4bsH97L4MzHuh0sKoXhccd?=
 =?us-ascii?Q?B9svTv+z3sJeWNenOpkS1hmvXq0O9uk0/8wrs4NklVcpvxmCcSwE9mHEVtWj?=
 =?us-ascii?Q?nDFqtP7Mq8ttrtGP7xldwPqfr1LG5JdYiUXuIaaDbymf+vtTxy5MPWLAIP8Q?=
 =?us-ascii?Q?h9/5jDBcNXvmtd/sxlEAobEHJx9+kl1amdCe6Fm+MwHXLI34tc3P98NjemiV?=
 =?us-ascii?Q?Qaiznv8X5TFECjs1GkTcEuy1gZHm2cocJsVmSdPNngKUPoA1j2J3KoX3Nwtg?=
 =?us-ascii?Q?zrEUGCpoWa4cOFCatkqv7jOiHLT0F5hOVSA8GV9aBDHgdeM4e+faKH+0pAX4?=
 =?us-ascii?Q?EnDUsPwZK7ZCQCulCnVTP5crBUXVDSdtv+1ft5UOd9EZMZswfGTkljEpdjUi?=
 =?us-ascii?Q?nIDbCskUqNZz1DOXNyeu+FHfOc/Aa2YfjAUOf52HuFVLmJCSpvRBWJqN0aXb?=
 =?us-ascii?Q?kV/A3G+CAR1wwyqmuucb4YooLBf/tP3kX9isbdsH9EEjI1nS/838TJ8iwUGr?=
 =?us-ascii?Q?jmmoRMLOFNydT9LHZ+oASlPUORmxTnd07ycA8oEbllGaIuGrXVX8NOEbcJBL?=
 =?us-ascii?Q?9cbQgqPGVpl1l2J3tPruwbj296XAfVuuaWzBvvnwAW75ksJ/9hIQ7zYiQMA4?=
 =?us-ascii?Q?Hw8HQ5Dqc9puX/WGCIh2g0wHhH0N1DOJrp5gfMIvfn18UTtmkA9uwJpqXrjn?=
 =?us-ascii?Q?UA8qqgIpNWHLugpL7iFqKixX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Eph2xe9Ocf6mL9DrDoh+RrkcXADhm54/lTogFPV2+sunXOqQf3smdSK/lqmL?=
 =?us-ascii?Q?Cvr5pB7Ny6tYIrYy0iHvvjlh7B2fDcM8aSd1tr1dTTpCDtJHZulyZi1AGh4i?=
 =?us-ascii?Q?1kW1sn4Oa/iIVx+g0Ijo/Lup5CR33n8E/e5Ull05YJzq8Vjz7VyPqTBEM6Pm?=
 =?us-ascii?Q?nti0lGDT2iTgNsE/yeaRRDMU7+bN2hMtQdzKwff6fjdhhjaoctz91vyy3ges?=
 =?us-ascii?Q?CY5N2EEALE4IKnTfLGtE9kLGY/jC69ocNQq1xso/yh+flXfD5XPY+ICAjpJ7?=
 =?us-ascii?Q?xcNf5HMq8F2IzYKGTm4J9j/VKvCc1PYnhPiRFtM2aUJCJ/DaDBzUhCmz67lY?=
 =?us-ascii?Q?v89TKC5WrYYdBF3+pNCQz+/lslkeHD9zcyh+PqoMnAt2+WZmUV2AAZGMUMwq?=
 =?us-ascii?Q?SwbyZ9bqTiINg0a0fW4PSxMRS9Mvwg4mYIgmrTWkKam+r3/ccwhaPUsPQfxI?=
 =?us-ascii?Q?60mugwMUYbLHNDZIqrZ/qDu2wBnHnsZB3PDPX+JepYKpvXzaq5+gF1f1xWfu?=
 =?us-ascii?Q?XlkSXthwDdxkgllJBifAYQMdd7qpwjdJvaw0XKNJFCxhDNXtSEdeCfl7Hq/A?=
 =?us-ascii?Q?NYZAZtFLzUJK18bQNqPLbljQR/yKSHUj0u4U85s6kAKmRhpYRMTysOFuZ46k?=
 =?us-ascii?Q?KtTiX7sQ/50crTV2aPwLhR2lrQEnu9eip06jEjiGvSmvH5/B5kLgh+jiU0mb?=
 =?us-ascii?Q?H9YoZPXmi7gPv2QHLNuKfQnVO8X7mY/4/wiUk/2FVp/KPBbbZ58FiHMf9ECD?=
 =?us-ascii?Q?rOPzQ0yeZ9az219X6WGNulbQ1p0CvGFy9cokh9k1alG/El/CA8c9KSC9ah/y?=
 =?us-ascii?Q?tuVSP9yQ5ED7hAuIDNcaPvYLTXG0t4EkOV82jLj4zhmkA0VoCCvOpEkFa7Kn?=
 =?us-ascii?Q?ICjRtYkQwTU4/F/1+dxRaPHslRHHoBmhzIagpZYEMB+Z3w6z9qPqf5SHz8aM?=
 =?us-ascii?Q?zivcAsqqGNx/Huv8oTkcimiNhKHFwidUhgdSXxS9emkZbJSfzTdb4afm+Uyt?=
 =?us-ascii?Q?VczEdNi5+KY0+4ZXFWTy77ZexhXVOyZpTTCZhH2olB5vGtuDYboS0cHP7tqI?=
 =?us-ascii?Q?OiYp8xxiSM0F9JgVJ8GC25QPxaLori0bDaFSKXiPvpuFrT4hlCoAyeedTfAA?=
 =?us-ascii?Q?IYTNXLt2rSg/XtrgUSpg2pqD05QI19U0+OjHtSV1HVFWg580ikpOHEEW991x?=
 =?us-ascii?Q?1KYFNT/wrQh+yK466DZbhXfBpbDGCzc2obDAN4w8YxkxzG1bGPVOIDYHjh9i?=
 =?us-ascii?Q?223ZOeFDxM4ljuFVVmVO7O8gdwhiFdtoFFjd6IR567/ETjdQf0zWExnCVTGL?=
 =?us-ascii?Q?A8vkppJvs3cPZEWw1lqrZKz328jQMX8i2f3qd/Q1zrOl5jABJaljAeHJ0Yz6?=
 =?us-ascii?Q?U+v6dovyyiR/g2+H/5ttiz+M9f4QpCKFJ//A5Exn39aAhf8HvCrPYXWT8/DE?=
 =?us-ascii?Q?aRJIfnuHM6cVHsHK5BTvef6D8FBbkf6lh6YWrljY1QLQZ6eC57HQFTMx9xvv?=
 =?us-ascii?Q?iQ7exbZEKxQhw2RYuABz8RfjvMVNgtUPqK94hTsM5Az4v9lA7bYzOEjYsOlV?=
 =?us-ascii?Q?QD1SQa/8Fa9dDHYN63FEXfc4DpCZ/yCdKnY+i/ovexrKSKzkeACkD08CVgzH?=
 =?us-ascii?Q?1g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ecee7a4-a1fc-49f1-e784-08dcfa69d96b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 11:39:30.7281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oknt2JwVczvreIsdma7isr8GPnL1XAqlrfjBFWdiuNWfnV5UWtg+4dpNa5BIbOtobrWJXynwW2240vtW2wFO8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10121

On Thu, Oct 31, 2024 at 02:02:47PM +0800, Wei Fang wrote:
> If PF changes the MAC address of VF after VF is enabled, VF cannot sense
> the change of its own MAC address, and the MAC address in VF's net_device
> is still the original MAC address, which will cause the VF's network to
> not work properly. Therefore, we should restrict PF to configure VF's MAC
> address only when VF is disabled.
> 
> Of course, another solution is to notify VF of this event when PF changes
> VF's MAC address, but the PSI-to-VSI messaging is not implemented in the
> current PF and VF drivers, so this solution is not suitable at present,
> If PSI-to-VSI messaging is supported in the future, we can remove the
> current restriction to enhance the PF's ability to configure the VF's MAC
> address.
> 
> Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>

