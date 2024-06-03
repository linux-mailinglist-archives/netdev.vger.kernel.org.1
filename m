Return-Path: <netdev+bounces-100035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E89738D7A04
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 04:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A056280FBF
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 02:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6234A08;
	Mon,  3 Jun 2024 02:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b="J4spjy/d"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2125.outbound.protection.outlook.com [40.107.243.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DE220ED
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 02:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717380144; cv=fail; b=GAAPuar8XZN+kZy2wiuKBClv8WnWbSrRbRm9kC50sd1fc7wvOBwvyQbCJaQaPDaWPZOkp6eNFujE1Z6XFI8UvRUcRUyiOAUr6vKUzACGPKkarC8b+YOCmv85/lZapDfl1fXrv71M1MBR6CmvOWRSs53XvakAvtrOozUm8RMTjpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717380144; c=relaxed/simple;
	bh=J6sIbxMFjKNCjKp0Yri9DSh2GLTMbxIfiaTaviChMMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cTuDOBqvRteSIaByNKffrrClnOPeQepyNUTY+/XRUtyLZEI8B0YXPuVvk5wHpIojyPjJSLSiECULkRzT1cwM0ytTucj/m0wq8C0jy5umwvvSf5rRBiMuVHMIY0nVwi1WfxtZYQV8xJ3YIjN2gDq2Qw1uj9iDngny7/ufNlJb4oQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com; spf=pass smtp.mailfrom=in-advantage.com; dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b=J4spjy/d; arc=fail smtp.client-ip=40.107.243.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in-advantage.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvdZEfkRpJws4fHt7wnPXLWcBBpVDK6Kz6t2Mj9xVhjjQWsX7PWXjO1bpCTb/NkmppLmvC8/NG682ytuRewdNDedaP55MIOA0oHbO3yMBbTpE+Pm7hEqv2ETloEQNxPyGtTxwkr7Q9iuMeYKJPrarX/vccQaDdcdSXFzHhGDEgc+WPTRCB+ZR6cMfjCXsm6X5vq/DKYDav7wpj+lBYdgbbLVogoZER0YkALEy4ri/IWAkddTzh8V1HRSE7GXUJN7ZjODLGkXQ6Q2tFFbKPpySgNQAZ+9xgZJnbQCB5IGWvtDQa/sZKXwHTo64zCCoONEyXB0XNdAOKTxN/vqnxjmxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0B+d6tqZOaxhhx/ydIYSq8S7fvOClU+Npnc3VFIhmM=;
 b=VIcub04K3XMROl+RxUx4N+GH6oSNzaequ7P7QUvldCZmc+4GlemYx2CchVidGscX/OZddNqz840zk9FwqpWtruYzTNINAtvHO7/CDPd2nvQppX/zB89ZpN1jI/LNCP7O1stY8uN337R+qFjSKSllp/g8hsQAGwDasvr+lfMQg2Ng0aQVi8fYcRdDQgxXyMDCGz3CXAug6G2sh4dGTK2EkuG+IpDP47Eh5QKn772y1wJr6ZAECJPfCsOnuE4hJ1mmCiP9ZW6/RYtHr3ivUSvHE1IZSiRbHGkgtpWvtcXUNowx59ocpCVAdHak/RQTfh01deIn4qlk8Er4ACJHZrbSLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0B+d6tqZOaxhhx/ydIYSq8S7fvOClU+Npnc3VFIhmM=;
 b=J4spjy/diFtD3znNPLeUa706REPDySpPDZgkF8dfwta185JiNNE9fI3nVqelUaiKc0xoWsBWb0aMLM8lePSuAmyEIcqOPyW5hbTCJ0iES49zUWuY8+HiHZlf+ynj+SqFVThgQiiO58LR5mXuHvDceVOm3lWs3VHsu8A4GVkeBvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12)
 by BN0PR10MB5031.namprd10.prod.outlook.com (2603:10b6:408:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Mon, 3 Jun
 2024 02:02:21 +0000
Received: from DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea]) by DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea%7]) with mapi id 15.20.7633.018; Mon, 3 Jun 2024
 02:02:21 +0000
Date: Sun, 2 Jun 2024 21:02:18 -0500
From: Colin Foster <colin.foster@in-advantage.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next 6/8] net: dsa: ocelot: use ds->num_tx_queues =
 OCELOT_NUM_TC for all models
Message-ID: <Zl0kKsbVcysan7Ig@colin-ia-desktop>
References: <20240530163333.2458884-1-vladimir.oltean@nxp.com>
 <20240530163333.2458884-7-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530163333.2458884-7-vladimir.oltean@nxp.com>
X-ClientProxiedBy: BL1P221CA0003.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::9) To DS0PR10MB6974.namprd10.prod.outlook.com
 (2603:10b6:8:148::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6974:EE_|BN0PR10MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: 575ec84c-03da-4cff-ade2-08dc83713482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6GPHD3Bj/E3RvRHhokm4pyet12I3fZ2mv6XPhgdDsD5FiTKDAQIOYp2qKuAm?=
 =?us-ascii?Q?RUoxIEUCAw/lxHTrKqShGssktLPAMV09n1KXrnHsQr00YItHxiEaq7Wz/ojf?=
 =?us-ascii?Q?llAm4JXEccuJWEVoKw5MeQzU+efEpBRpgpB0ugFdpvuRwKicC/0om56+E49D?=
 =?us-ascii?Q?brtvUYvRqdEKTMfndggxZqeo8g/8jH6XuSt1Luvi/FvO8SHpJ1jIT8ibgvUF?=
 =?us-ascii?Q?/ItLx+aZ0MPR1AXWW0Bi+e8UyjBjps4Ei+D3iWJipaDZ7xrh3LVJOiD6JTME?=
 =?us-ascii?Q?X4XOmmrg7Mf8/zC2DZNvlun6CvurOBHTN8nBD5dIOTx2dR4stj9iOfGxjxQk?=
 =?us-ascii?Q?5d3whf9w5tRtn4s++fRSXBr2j+/LO7JI4nVK1iItAOOYVfddzo3bljiYBhwW?=
 =?us-ascii?Q?z6CIKtINCnvGU3AkogbnUkqJkh36YoYnjFGxksKd+cmnTHz1WYXBoBTPC82T?=
 =?us-ascii?Q?+/59erRohvQABMXpTtk4TgELolJ380wmPXhZ7C7QXkA/cXf4IdwT8eq5zIGa?=
 =?us-ascii?Q?Hzc5OY+3AVj4nBX9d/X059+Qaxl9DanGvPlhSTTAfDQfubWs91aJrLM4t6fM?=
 =?us-ascii?Q?FPnXiIIQapsQ0Vt7cZqoWlvVGA0xvmT1RvomT7bNFzPQbo8+VPLJwMFyHpc0?=
 =?us-ascii?Q?LL0IkEXdpmrPXMViRNCJZYg9HpyqvMy//p4SxDk/pND2UZ+c6GWx2zMe44vv?=
 =?us-ascii?Q?yCpz1/c6IyDMF/6JiGAOiqoXDTCs5Ci+30BLYqfn5dJBrjrJM2u6lE9mw9Tz?=
 =?us-ascii?Q?+QXX2sqY771PMmEav3eRDzwP4QIDCpCbDVUenWwzjeSYDYTs8h65x0iE2c+R?=
 =?us-ascii?Q?mFuaLXnHg++r5CGF0GB9AJOb5XTwiTdC0960MZVzzjjY0MNI+001J94hvN+5?=
 =?us-ascii?Q?mhCaHlvKeLVR/w9L1586PxkPfjViBrY0zbfBpPh970tOt+rFp/tTL5G5tF34?=
 =?us-ascii?Q?sW0R2eEgZ4WoDiGk/lpuageNACvIaeLgOqt9ACL0pSueO8AxoaZJwc/h4q0o?=
 =?us-ascii?Q?lUs1lIHhOib4uUBKG1gTBq5E5xGdpiYPAUZL7uTLvC2qp4KirRmDngmlE9Bu?=
 =?us-ascii?Q?8ThxL3nrTBTKuGap465VThhcRE6JkgLdw7yO6HBgWzqplsuJ4Z17A9MLnPUH?=
 =?us-ascii?Q?3yOCxFtDsHulk9Ga5fSNiWkN7DD+rJkfB3ZfgJbbzJ4tJEnWLYoL7P8RKNgY?=
 =?us-ascii?Q?Z+iUuoheWlXQ6Lca9O+LpgGd0+TtDs1Fe1WRDA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6974.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NjSeFepGash19T8waLMhqLfq4JauKsDagWVa/G8X2PqIi4ypDLV2Ksso7GN1?=
 =?us-ascii?Q?/WusCWPwJjMM67opPA98ns8HaNkJsBvUVJ9oWIX4GARXdUCUVF/leYRLWd7r?=
 =?us-ascii?Q?U3EpijTh2rzy0f2J6JTbWZaakmoWUi1b5n5FfRPlr4/4dCImmaf4AbFf3AX3?=
 =?us-ascii?Q?RbONllF3UNQACy0osw4+BvCbpd1TPCclDUeQ1wQEs1XzLqhnDF14D5hXn/x6?=
 =?us-ascii?Q?gJcp2pOPQyjq68griMkgo+srLpSafg1f2Vutrg6aLemCZatKxrHngrCUI4O4?=
 =?us-ascii?Q?2TNzmSERrx8IthEwfUHkyqeFBIv6lCZp1pf8GD26dHpX6rXxKfZYi20zcIdl?=
 =?us-ascii?Q?Pez33MNMzG76eFqhvPoeut2Kh8KWPBdP0v7ziIHA9Ae23qjFArCnHiyKnK9E?=
 =?us-ascii?Q?a0W/y6Qc2A/BZlXBa/iXuzJFrYyICsbueYKX5euMAKm+FF/7Mi02Mi4wQtOy?=
 =?us-ascii?Q?too4uA3Je8QVLcuOC2dyaTCfpz8/ZeLoCE0iOGctjYasyuydv/kT9MfMPLz4?=
 =?us-ascii?Q?b83y4D33fv2Vh+A4Izs66/lRj6qzAXOQNIff5vaNYt0BkyO4Grc1TDQjRLWs?=
 =?us-ascii?Q?4cTRZkokHEhOS6tjLBvpxAs08wW8jzfCdBewCnlhGRDh8BJF+ciUT0j8Qj9j?=
 =?us-ascii?Q?g4khxIUK3wLYuTVEhYc8mysy24iD+lMWYbe7X+RIjxT3skRZDo3MLlYAh5Zy?=
 =?us-ascii?Q?lD/AngRlpKRP8O6ON3zg3JUjT705UK/2WnMiaJKYOF/s+d+7qQL4j96V3GcG?=
 =?us-ascii?Q?dOLKWYTiGz8jLVVUamwZWB0nuo53cr/VkU1Z5s0tnoai9A7ZSsWZ7Wxosxk2?=
 =?us-ascii?Q?ZR4RTlfQPxDDMhh8LZ86Zp7jD2TmDDr1lt9Zru1IH4KuvWBPftXFSOPYsGB1?=
 =?us-ascii?Q?pfVr0Px5VdyiYTCoGYTS/TRQNXG42mVfEm8Rme3+QgwWIGkN0wNYu/ptVIuY?=
 =?us-ascii?Q?5/hbJwHK5Tg6xDaBAsBhPAdoeTTnTeWPJNvEBl+5Ur08+ZCmReczJbj2ZAw0?=
 =?us-ascii?Q?kNYaqQAd9xScOpECCOVWEKojbb4vYjSnsuSnGwxb9HJImFF7m4hApQf9X0g5?=
 =?us-ascii?Q?JJKHKT+saCGEMPkiLPe96FCVMnfz/Gs9kVhEXS0Ecg7ripL0qmF8L9vOpfm3?=
 =?us-ascii?Q?qKy+C7VTL+Tn6NaPp70j6SAoGv4h4dX1tlsUjmcOHzoPg+CD4riGW2zfEK6I?=
 =?us-ascii?Q?FRV/jPyQNFtpTQv28gxB249ZeH0+tP2DUoWN9dSGIk1VKycdrHmvjU3E/+xo?=
 =?us-ascii?Q?UJhL6OVZMscnTUSICD3n2VbsK8yclKcztOI91/6pfq/TUPCgpzzs0aKtlERX?=
 =?us-ascii?Q?Ja+EevKomJNKkzZJHXANo/ADI5Oh6KTeijY/2N9bpQ6o02LekLvQ1T4v/I0G?=
 =?us-ascii?Q?EnZQdCsVjq9seusTC8gwebINJEFLFBDJXlgdXXMVKiOEusf4w2er7k4hEp0T?=
 =?us-ascii?Q?l+gpN1lYkC2s3ma8bhXUy+9L/kVYI1dQX0diC2csl5LTON3OfaNdh3yd3li5?=
 =?us-ascii?Q?gZfgumBtdijl1+EzoKkF+sk6r9Cj9xj6ACDWxYQlCHU/cMfSuNpBqVLUSul1?=
 =?us-ascii?Q?MdGKxZpXW3+tYVXyX6ijd/ZOmUngiZ/Mz65JbHOeLmRJSagMV1yYHYNuW2pB?=
 =?us-ascii?Q?sMJpjhLkXMpoxhlmUOIfyvs=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 575ec84c-03da-4cff-ade2-08dc83713482
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6974.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 02:02:21.6361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CGuWaWyT/E6kdFN9DFwdsV2rN8LJOfr62Bh4bLQn5KLTvL8h6bnX8TYfd9BFk7PWTxxEtKM++szKRwbdc5DTsZ48s5mNRFd0FndembmcM70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5031

On Thu, May 30, 2024 at 07:33:31PM +0300, Vladimir Oltean wrote:
> Russell King points out that seville_vsc9953 populates
> felix->info->num_tx_queues = 8, but this doesn't make it all the way
> into ds->num_tx_queues (which is how the user interface netdev queues
> get allocated) [1].
> 
> [1]: https://lore.kernel.org/all/20240415160150.yejcazpjqvn7vhxu@skbuf/
> 
> When num_tx_queues=0 for seville, this is implicitly converted to 1 by
> dsa_user_create(), and this is good enough for basic operation for a
> switch port. The tc qdisc offload layer works with netdev TX queues,
> so for QoS offload we need to pretend we have multiple TX queues. The
> VSC9953, like ocelot_ext, doesn't export QoS offload, so it doesn't
> really matter. But we can definitely set num_tx_queues=8 for all
> switches.
> 
> The felix->info->num_tx_queues construct itself seems unnecessary.
> It was introduced by commit de143c0e274b ("net: dsa: felix: Configure
> Time-Aware Scheduler via taprio offload") at a time when vsc9959
> (LS1028A) was the only switch supported by the driver.
> 
> 8 traffic classes, and 1 queue per traffic class, is a common
> architectural feature of all switches in the family. So they could
> all just set OCELOT_NUM_TC and be fine.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  drivers/net/dsa/ocelot/felix.h           | 1 -
>  drivers/net/dsa/ocelot/felix_vsc9959.c   | 4 ++--
>  drivers/net/dsa/ocelot/ocelot_ext.c      | 3 +--

Tested-by: Colin Foster <colin.foster@in-advantage.com>

