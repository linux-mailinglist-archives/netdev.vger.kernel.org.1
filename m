Return-Path: <netdev+bounces-141004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6569B90BB
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 12:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCE81B20EB4
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 11:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B26319C554;
	Fri,  1 Nov 2024 11:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bq8woxzq"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1D219925B;
	Fri,  1 Nov 2024 11:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730462130; cv=fail; b=nq0UyHK5CW6akx+Wtmt9ErvyKeij94lT0U21km6s9NkhJxjTDi6e211xysjiTVmwJcHauxRgIS0m0Vyqsx/axLQp9Ej4p4TRm3szzlofw1/+fuQsJ0/B8VMfNyTnP+tJhbDu7sGkhGr32W+RFOFWCib+O5wcsp9jDLDrU24Na0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730462130; c=relaxed/simple;
	bh=MmUjc60u6O/YPxGynUAsFKFDj2NStV7LMHF7Sw0HX1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e7RQ0EaJcGSrlLI6aCQqqNQJ0oey2AUnPCU1wtCafnmrqhL+yA3FrcIX9d29M14wlLAwwOYoYT+jpfbLWqWr36cDfIzM6uXafLwG9g7U/3h5xByVNoD77TXS8F6D/Q9+7I1hKIyoDCm5JWwAYHUevE4qejCnRutxq4obWN+hndc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bq8woxzq; arc=fail smtp.client-ip=40.107.21.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgESmPnJcqVv8as2hLdgqHxgcaESEc9JNcnDx8uQt5uSoo3YT4cgt+aItl1sqOA9NeiIuuenhUOZYFihhK5eBeVNmGX8vZUbBRQ5gvOBBsY9gy5QkIMPB0fxchi52MiGrWZ2R3mld5AjKEO66ppsMop/woa7c0Y2btP/9dIJ2AUz0uX6/fS67UWkB2JJeq1xko8HNWswYNFs7hxGHFpOG6tMAPKuC6/PGwkSx7SJYlwG3Z7q7H1y42ThCmC/0qnawucgXeJ0XWrXVqlmfXNUGUwfp/Nl6/PHjzGHIijcIMl4Q1SM9+pCfBAtdXR+7L/qCKktMI/cfmDdcZKNcJT02g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8MkEXQau2zdrGY2sf2W0xuQYGzelo5TGuPHo7FmsxQ=;
 b=dN5nxSQnyQWVBtQJ3ZVsAVEQwIIPBPu5wka1njz81Hncu69YcpYf/62p1RM9+33nNWwEtlI4Aohr880regbhkQLxdkpfXlXgVggKC/6SYGij5pGFdhGZDf7HymO5kTfQHHQdFGbqLcfOazLbgIJ3yHTD9NjEqXoyc1QPC8g7SdmjBotLIwwFUOyAlNb9U6a9yWpuanwPv/kesd61eROp5GuaWbISDdueNoW1UIqD6Jr8vaWAHjaP4dBNElmAe0I1H0c42WTLtH0l6hOVqLw5RLF6okUhVHraQwkzMBzXdTxI4vxiFb3PRG8hFIqB0rlzVe6MvmVLRgGEDrse9g/xeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8MkEXQau2zdrGY2sf2W0xuQYGzelo5TGuPHo7FmsxQ=;
 b=Bq8woxzqOdelEn2EgZCk4B52BZvZz7pKA/507NWQNIxzLFkfNErI8DdbA7mNrvRyvThhOIfTRilNcUjsp2PETqQUePcFkD5YurcdwdTQPNX6K74sjwlrsAml2d1mFtECiZDjV3Sv/kvO9rHiHYR9Q/Oo09DTv7M1HMxVLw0Z2sVvumMZR7h+jU/owGrkqVewL5yNU6nfTc4eH9vl948SS0h8Os4ziLVsrxcmPgLrhEy1eAvnjA6JM+k32ZtIlHfQA416L4whDJDdwJDDMhn60X1NkSymGYWUGITyBiJHt/tXAxemAch/NGQv8XnuP9hhxegSedju0g4X4X2ajMb0xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM7PR04MB6822.eurprd04.prod.outlook.com (2603:10a6:20b:108::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 11:55:22 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 11:55:22 +0000
Date: Fri, 1 Nov 2024 13:55:19 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH net] net: enetc: prevent VF from configuring preemptiable
 TCs
Message-ID: <20241101115519.2a6ce6daqrzmhcfh@skbuf>
References: <20241030082117.1172634-1-wei.fang@nxp.com>
 <20241030151547.5t5f55hxwd33qysw@skbuf>
 <PAXPR04MB8510F0A3B49E05554D5BD71188552@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB85104B9FCD3D74743E9B261488552@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB85104B9FCD3D74743E9B261488552@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: VI1PR07CA0272.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::39) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM7PR04MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: 62691525-64dd-480c-8ad4-08dcfa6c10c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TdAK5LMZrv6qTGVir93o4Sv+V6uji49yxMWpl7LVBY3+BiJTp6IkQjLEeq3q?=
 =?us-ascii?Q?ZKCgsZshWxlAjxKQId3yQ73HjQsz7+QkMS4Er3kf5QWg/LuNEUzmRuZMTakk?=
 =?us-ascii?Q?trzqO52n9RUVG/pMbflAsSdBwl84TnlzuhPXCJOerXD5Z2ilPS4Kl/k8Gaup?=
 =?us-ascii?Q?+qXIHDsuLIFD64mbgx0WirtnYXyPBfrN5ggHdpZZthNJXZnCQ8FoDbEGx6t6?=
 =?us-ascii?Q?kfgyPNzk+5j+CnNBnBc1RDKioGgG5TlfhIs9a/EdywU/u13PGMH0OBxmWzBQ?=
 =?us-ascii?Q?1/kkqFpwHFClxJ90Vnw7ovSrHyqxNKxul5fLCKfSrPmQRHGh3C3oOatU9o+8?=
 =?us-ascii?Q?gphIJKtkVopRA3PeEB3hILVpL6Q10TbZ8wFnsVxGbfShCnwaJ0pRHIvamb/I?=
 =?us-ascii?Q?6mWwKa20k6NCGSze3oRo7BhmwxBCuZFAksYnG7HqUCkilq4prnCP37kMlIOW?=
 =?us-ascii?Q?EY1Btmjk7rREVp6a0ULfJx3Zo1Lnl5v3eYOHIDV3h27cTxjF73/rsnlrnkWC?=
 =?us-ascii?Q?SWHH/DnGc9nPSWXmYr2imfBy+73t7GVE9m2NFYdp7gDzS022rXnKY3YTljYe?=
 =?us-ascii?Q?JdgUFUFUyuOmQzCwOwRfhMRvXBhAIboZ7bA0Hh/J0/+lmU7g1MzIIHJXTNOg?=
 =?us-ascii?Q?oGKw1JsZsCAQOSv8EFtNyl7BD9tOSbNdbYeSMjioul6bJJl3YiuY7pguOnYW?=
 =?us-ascii?Q?g4m4RQ8RnuUu9rELjjaoM2MYfU/9OVR1DntJyTQCyqL7zUzMQoCMfLISx7bp?=
 =?us-ascii?Q?3/JQ1JIFbhVawMCQgKLSY7PUF5ztJEIHUNYfOZ6gpPUNy7u37QhGS6rv00JR?=
 =?us-ascii?Q?hYQvX5xHuFc1rUNxp/bAtB2U/1YEsv7v+rZYH8E+B5CYP1swAwPhiJonr7tq?=
 =?us-ascii?Q?e8ruy2ivg4IMVrgJInFJIgKM46LrhQENCEM69XKYYEW1zPti2Wy7h+6fDC+A?=
 =?us-ascii?Q?60EuzZwkZDFzMov1x4n6ooTiOBs1Lbk9U0HscThwNlzwag0xM1AEGawG4rYf?=
 =?us-ascii?Q?MH35fBTi9ODP/wmBIR1RNaWuG7oiSRYSSfKf3SVnqeFVOq+cRVQs80TMM/Sj?=
 =?us-ascii?Q?8t5J4oHvOhidCKD/ZavglIL26dXECBJtqNzyke9NPYJDf5ETfsUHeb7CPHIt?=
 =?us-ascii?Q?u0mvEx5kODLEjiiNWzWFtY+nwsyItJhzZXHMRsMZt4kn5TDzlvx1EPAPsyi8?=
 =?us-ascii?Q?05tLf+itK7WJcWVGBNs7NgkW4Ajy8+yEiUlPlt00NAbmwi9xESHDdwg8emlW?=
 =?us-ascii?Q?4Zhr1JsF82ca8D/2vhMhuAFzQXrowy2OIqkRlmMQrj/7PhOMuw/BVf/Oz5e+?=
 =?us-ascii?Q?UV3i0Zh+lCkliEgamMXxB7ow?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?02Jk4BC8utDa12BqDDsqpNzScNy5Q06zGRgyxTdxwnKW0pfMXG9oRbBYDKCs?=
 =?us-ascii?Q?S1/QYC83/+MdsukrIf/SKexkbdBNuGK1bc1+XxQSyaEl2SyNtuk284JrUPGG?=
 =?us-ascii?Q?9+q9yAaaX8v+dO8gc+B9SETx0vR9mYoIGCejKs8rTmZsZ+0/AU/tGjKa4fh0?=
 =?us-ascii?Q?RITkvIq+itVPk3x5UeH+7uAnsaHbdrQlnD5qwhKnp6xSiSlYLyZq3tx+xjyd?=
 =?us-ascii?Q?lQxEm9oBERjzmut7PBUI81oGiTPYJNiztJ5l1GpZQbZnGW226Yv53YCC/XyG?=
 =?us-ascii?Q?WtsA91qAOGO1hJ66GlDdG7ifgaB1HgqiafLKJq7lMRKpw3yC26+YVbsb2fzG?=
 =?us-ascii?Q?O0/zCD9rzUDc6EWbRwuN6E779JZYH7filneGN0ep+4sPA37IddoQXc+F0SrF?=
 =?us-ascii?Q?lnYKWlaALpD4vtBkoeVYd9i490aoAa2ujMBNyVDNESAeJImVPLjdhAR/sYJM?=
 =?us-ascii?Q?5wo5z0qmoUR1QpxaZ4b5444Q4YruO8b3rjIA5rel1VkPVhYJsRr1UDSe95qL?=
 =?us-ascii?Q?Ib3luHpJe7KUDUiV1cOB+CYCU87Ti+ldmqeac5o4QUd7U02a680zY+GXoKcl?=
 =?us-ascii?Q?FBqWN5DyX6sgnq3CQgPGEtP2ZzNh1aQWE0991Pkxv80bY2a7T5t79Eijx230?=
 =?us-ascii?Q?kpBTDVvP7oaD/1hb/Ynv+JY+3nfhWEesW6CZqv6o0WAoDEHlNfKZAzsfYhCr?=
 =?us-ascii?Q?LHAivBTy1t30uIbUZu6zzmYyVR2zpLIMUH9ASxqAmSm7qq2mYJtcynjuLTT7?=
 =?us-ascii?Q?Qsyo0J3pYVNFXUa2v00IYsSIji6ccz/eGcwSfWsn0ffLSt5eWqUVDY8w5hvy?=
 =?us-ascii?Q?2xAlTqbY6cUcsFNHEhj4UlHMaFpxEogsrM7fmVtEOY+8Gtwd8SSdTHFMGVI1?=
 =?us-ascii?Q?+SbEe6FObDvhpF3hj1Nr4uy3uCrpn8EM8ii0ClUZzKFeAb/+GBb+aY/tD9Vz?=
 =?us-ascii?Q?qsFS4Mr0qSwJm42xP7ADIAwsfQD6IvUsBzpIFqKjcvWv5I/20Nh7cQBYI5xe?=
 =?us-ascii?Q?ttTUwLdmuX7yd2ojHPvDTjETNwkaNu3BKF4qr7XIyH4yIXnAHpSTVX4smI3o?=
 =?us-ascii?Q?Vwqu66EwJlKEVYPodOu6r1DnSs8o8gS3KRcqASifJsIUGMWdC+mMKKxrvHuj?=
 =?us-ascii?Q?TdNn+gB2mJpZGnh2Wsz/1d4VK4zYTmeIFKpeiUzVF+SBO1qqW6wUaeGWx0pA?=
 =?us-ascii?Q?lDOi1ZwTbEcyXlcZ/EZaAEED0tSqLjQP4bMPcygdA/bj2xhzxaIysUHrSva2?=
 =?us-ascii?Q?SJNABTrce0KAYl1G2Dl5a8CoL4ojDKHIpdjucL/pJbPmcdNgj4TBPSKrVfgU?=
 =?us-ascii?Q?iQFSd26cBEMkRWM8O+bjxeZf/FyI0mvKl6YTCgbRZnfPi3koHmwwA8FatNU0?=
 =?us-ascii?Q?hWtmcefq3x/NGncvkddqsZUJf0cZxc0rIKi/egedFc1JSrL97V2n3kcwFqFw?=
 =?us-ascii?Q?BV+ovfdLIxaBwqWrjMstT20W1f+KObUNUD/q4Vp9mVzgq+CuPh9pIajGXJ5G?=
 =?us-ascii?Q?dVwxCoC6YjGzEBtAAjTo2k34EXTiahkgAV+EykHeqe/m9pgu6OrC5Q3zWBYY?=
 =?us-ascii?Q?QFkoB1MGsiqJ3s1CwrBBWRnKRlHqFl9+loXpvevsUI9nQfnzO5DQIBmEzgXp?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62691525-64dd-480c-8ad4-08dcfa6c10c5
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 11:55:22.6109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QE41nbv3Dc2hPi2ycs5cSyODZE+Chcyp0amlkacszFIfOXzj0Pcd+r3yHyOHyf+3/8cqsybFw1XgA6N6SGtTpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6822

On Thu, Oct 31, 2024 at 05:46:47AM +0200, Wei Fang wrote:
> > > Actually please do this instead:
> > >
> > > 	if (!(si->hw_features & ENETC_SI_F_QBU))
> > >
> 
> Actually, VFs of eno0 have ENETC_SI_F_QBU bit set. So we should use the
> following check instead.
> 
> if (!enetc_si_is_pf(si) || !(si->hw_features & ENETC_SI_F_QBU))
> 
> Or we only set ENETC_SI_F_QBU bit for PF in enetc_get_si_caps() if the PF
> supports 802.1 Qbu.

This one is weird. I don't know why the ENETC would push a capability in
the SI port capability register 0 for the VSI, if the VSI doesn't have
access to the port registers in the first place. Let me ask internally,
so we could figure out what's the best thing to do.

