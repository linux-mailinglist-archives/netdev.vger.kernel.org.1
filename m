Return-Path: <netdev+bounces-128249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44967978B80
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 00:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9CB81F231C7
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 22:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039191494DC;
	Fri, 13 Sep 2024 22:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y4haEe3X"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010055.outbound.protection.outlook.com [52.101.69.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCEA7489
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 22:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726267745; cv=fail; b=ZqNbgKL1fW2bzkTlAqMQcrvcQQwZfe0aFynQfAi1dnN5uc2UsAYBZXhr9U72RTtH1p7EgAve0wYjUIA7ED/YT/kDdF7jYSHZ2TH+7euJs3MRdponEXR6eOicQ+SRVncszeMvwWrT8UyLpGzAHzSffMvMDIVE9/bGnf2qV8xjMvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726267745; c=relaxed/simple;
	bh=YM3mJYeOlJIsYufZvul3FC105Ajxctrrazj+bJBpI/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fsPTpAgebE4qSVtcRD978inHO5024p4ByvySowWPiiBZcLSPw3o+/J+S0+ZPLWTedLFGSrxX/29nebu1uBFX+sKwmSN9Nc9dAclwx9sbXXPPGd4JVRLKyxRlyujjHGi+9im2V0yJfgr61Sh49dQfFjscYauOeQ40GYlIligxc8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y4haEe3X; arc=fail smtp.client-ip=52.101.69.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDizceGx0Mls1NrK13NMT3oECPgogJta7Xh3+XIcfu93B6zx9ADYHRCLm9uC8JSmM4m+OjDa1E+bdSPLLMabWENe9gZ8DbLJ3+5IA0/e4NJwU5s1Mjrtaa2naVDWlHfZ0h4ttFBraV0Mj6XJV6Fx5EvLh7uvAdTx3mFWt+MICmt/DQtia1KXwVFCXoCYNn6XCd+wV7voBSogzWUEAFRXDeddQl63nHWhhF4sS5Pemtdm4M6yDSTgQaGTHi4Se5dLe1eZgLvOCsxJ+SJRJQwA8YK+NfnGCg+CXH43HjuY4ykPuEDmeFnLecYjL1APOiSv2IDoRrdZckJAkyEDqdVBjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMgAjZczwPqK3s4yX3V8Z8TilHn+QRz290OEGx24+RQ=;
 b=dFlfdb3LvgyjOBDs1UVsME1VZnInnmF5aQ9s99wnrvpU47c0BGAqrNj/9OS0goeqZGVVPh+5qS5bmnfLjX88b4FmZiirhlAzaQ/9NLvO5dh14tMdW98iOrATNfInqehkzZDgiM9vCi+45/OLyD6Dku250ec3BQUiXgueNy6Tpb0odpx3pMGSTnMIujejV0tAWAAPvFy2f4ZOX2/cBVr7l8HfxlZuwiFMGVkxm518nnND990sh1lyr/yoVoh5aPb29TO0Hpz5VAU8fw57Z8Mj0qIABe7gIXp/yoHnP4l98gVNZqMfUaKnGXzBx+siSUhJx1pJyokJ1X0E8Kvrb4O5dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMgAjZczwPqK3s4yX3V8Z8TilHn+QRz290OEGx24+RQ=;
 b=Y4haEe3Xgn5cwslImoEd0EWsiPDrtRlhZkVXKHrvtnv8JPforwsMB43G9bBIb8v/QRdBy8RD0aE93yETMxRKz//YywMq5fPI9L2c4/Pn/5lGMrEr+j6pa6FkMDhmlWcCGT1zZHwJbBpGOp7+m64D9+9HuiRZZnC73sAFvQYWh9dkJv1s2RhFKKkkL5Twi7PoDW6GxW0eQtpGHCD70t3YoDHjWJVB9sy/fT3WzOV3VVgpQionHjAj7UTUl7R3TN1hsJ7FiqJMjqmhcz8w0KbhjISOTIvpQ4lYSRNPTTwI8PF/ELqzTLlhl1ra1LvAXEgcipkIzqA85Cjde71XkNkkCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS8PR04MB8103.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 22:49:01 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7962.017; Fri, 13 Sep 2024
 22:49:01 +0000
Date: Sat, 14 Sep 2024 01:48:58 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Mogilappagari, Sudheer" <sudheer.mogilappagari@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Michal Kubecek <mkubecek@suse.cz>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH ethtool] netlink: rss: retrieve ring count using
 ETHTOOL_GRXRINGS ioctl
Message-ID: <20240913224858.foaciiwpxudljyxn@skbuf>
References: <20240913093828.2549217-1-vladimir.oltean@nxp.com>
 <IA1PR11MB6266964963DBC6242C5CC6DEE4652@IA1PR11MB6266.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR11MB6266964963DBC6242C5CC6DEE4652@IA1PR11MB6266.namprd11.prod.outlook.com>
X-ClientProxiedBy: VI1PR08CA0227.eurprd08.prod.outlook.com
 (2603:10a6:802:15::36) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS8PR04MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: 82b5584b-a097-407d-836a-08dcd4464291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FMY4112+JGWvR4skCpnhKk/MfQGZdQptwCIPWLQEwVPd1pjmpq3FUcbm8FNV?=
 =?us-ascii?Q?TdRY7eBPC5VqAh2PiAiD/wjyMHKYVkkXUJ8qnrpPzyXhpcn42vBCGJLyER1u?=
 =?us-ascii?Q?i3StfH8NweV2UtLsnoNaKUQG9wi9r6xB2wDOEDXD4jqyNjPELA1VsetMofa0?=
 =?us-ascii?Q?92Tha4K8FSNmXdG9Rz4Us+ma2XwNNGLsHffG4o/qVGfmxZ/lRmLRXCXZ559M?=
 =?us-ascii?Q?t2jLabt4EKvRSzgsG2+INSwkscVsteoYSjOcttirUhXmjNhT3CvzyXo6ka1j?=
 =?us-ascii?Q?x9XhxKRB+wCq7IeKjMVtdGUsENPmnUZS6up1osG9LdLkMdNeDD6EyhZUbV2V?=
 =?us-ascii?Q?d0O5lNYXgkf5ed0VkHsSII6DBogX8DX9zi5hpaEUClmhoPOsDRH73T7q88Ci?=
 =?us-ascii?Q?+8Bq//jiDb6xmiFSmCtrkGo8CNnM1KhGbw8meqlxPMMYToUaGVzGkNNiffvB?=
 =?us-ascii?Q?VeUaeY0aFUnJqnj40dDnv9Z8haDU93aU1lHUfaCi1HXTKgLT5MnUWlGwFUjM?=
 =?us-ascii?Q?n8M8iS6dcnFr81nW1kYO4phifu4Z37iRNsg2ZAONDmflqDUJQkE4uOzyk/8b?=
 =?us-ascii?Q?9N0rgnRPme6lrH1gj/UIlSSf5GY/UGf9QoCtVcC151FbK6cOI3N/aa8SlQF4?=
 =?us-ascii?Q?Jx3OZzJWej/IqeMvQxxAkoj4RdTxKpmXO/dL2TDbUVIZrr6jkWyuso5JqLNz?=
 =?us-ascii?Q?vd91tUS9WfPajkckBfcsws8gRZCezcLrXQPv/78bWqle/BRX6YQBhrbWMjcH?=
 =?us-ascii?Q?ULSiLA5tmcDDgxHLuhRzsqnYoiF3g/WOCoS0eCgXH48PXVXcHDHwycXQcPEM?=
 =?us-ascii?Q?vsjvY29zGn12GQPowRh7KUpSAcrFiFdI/pJ7dazsaPKJds2hqwrOFEKcIKPy?=
 =?us-ascii?Q?q4/PCLGAy/UYLvprdC6xxIXr/zeE68t9zAPWXluhXmpbS9m8v+ZCeGGWOv+C?=
 =?us-ascii?Q?/KuJoEwO8vPX3wh0WleJ5iXbw7bGQAXqpmR9J6VpXy5eUJW+aIs4ShW5EROp?=
 =?us-ascii?Q?aUuBZqi+Cu5ynApTSe00UOpAviQ1weoXZfCM7nWyFf1MRrBx3sfOi+cQOI9/?=
 =?us-ascii?Q?oxtaSOM5DWBVrbkLwAtiDkl/1IwALsTWdD68Vg5x12Ebkbb1YXms5KMdzbtC?=
 =?us-ascii?Q?Og78BvXO/SEF4L1i8x5y/4kcqCtwbRxR2BqnSLPNeEP5QnblN0G2qmhg01xC?=
 =?us-ascii?Q?ymfHMnCm8guu8hxBhJEL5IBTVQIzIkTSIFdrwSkGmT3GpU+wr2EuKKyQR2l5?=
 =?us-ascii?Q?deofAW2V+2FZV3F4RDmQ1bnR1Pb+CHHGgMW3OvzzRkClcXqAhGX+7FObhHNQ?=
 =?us-ascii?Q?mtOY59HT1pYgyKCed6nl/jxTw2lYfDgqOjBP2LOYNhCVXA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1zVHzVjJJh497a3BaHr2/ztc3jgXgAz4yARboKL5L47PWAssBj5bcBYNO91e?=
 =?us-ascii?Q?6Ltfg5WI9bqFbp5st7PEGUYC5/dbkdZkueono/tnppx0FYZ/J8k/RaVCt0zs?=
 =?us-ascii?Q?khreOSp6vXHsbkWoGuL9l6+cT59IxjpGNXgwsvWRf01h96qbP7o8RhEjFuGP?=
 =?us-ascii?Q?3cjUrrULCdtfB2V+JuCVeRy5sLA4QOtjLcCT0bK74ves6VUUPLhgJ6av8s6x?=
 =?us-ascii?Q?lMaX/T0pUPZ5yw6b13oT+4vtYxj4tCpdtDwlhhTrvGYZdOZk1ga9yo9hx4TN?=
 =?us-ascii?Q?39EsRQX0dj9IaJqHY5J1xYpXG28gEjhbmJu5rAcZGP59IMDvabv/SvcWcrYP?=
 =?us-ascii?Q?b9qGX2s+JH83Sg2fb22CjTSgxEOyYdQmUhYq9Aj54NYm3c2Vai1b4sdJIHTm?=
 =?us-ascii?Q?H7Ny0qQIQtSKfg9dx88cDqKh2+33bBVkmDZgDiHe/Jl7nKOBC1FnQooEwOTC?=
 =?us-ascii?Q?exu811e7qqSRBpV9tPRFkRwy7XrcBZInT/151VqwSxDIrqFNWRpFhQfDpXaV?=
 =?us-ascii?Q?vaIgkdCDHXcqD6bxvqsDTk727jUMsznJwwfIG2UbcFie0Pbq7w58DEDVGd8a?=
 =?us-ascii?Q?83mK2oQUufJoUN9dfR+MF19d1CxNvqhSVqLLnghUKHF5P9nIWbiW6fVMyd3Z?=
 =?us-ascii?Q?VMXpHicaUg4e/e2WGF+ByaNA4QO7C2WXfamrQyBdOSgHpPNzcNgekSfdGxq8?=
 =?us-ascii?Q?jn/gMrlsrwtOj+Wkz8VdxD3+3H6obAQ+zvSKRlFWwewwmTI2tmwWcDvfdCsy?=
 =?us-ascii?Q?6+qP25RK8UdJY0CIvvktA+kdbQbCykTCj8MPIkKb5cKoBAuvMtq3RpoAVle+?=
 =?us-ascii?Q?9rhUrv4BfDyHPvKA3sBpeni/8mX1POQsXmDjLSK6BvJOSsd1dmFo+I0C9CmA?=
 =?us-ascii?Q?2MIj4mWCFog6ZQWgHyd5CDFGM1SvxkPEV8/bbdhtX3p88fVritYqbE70zfd6?=
 =?us-ascii?Q?o+Ooxxy33SW5b1RrumhthRbMjwzcrcschgh63zbyO5oN6HQxA3Zi5L6RfuqK?=
 =?us-ascii?Q?VLUYqt51EsfcMW/z335sxbuUjBf2cur5yWXcF3a2nr/o96YB0qtfruF+a8l2?=
 =?us-ascii?Q?i/kF/Ry1V/diNqRdCeXVNnEixU0VAHxeHpHa4fFrsbFyZSkbIALghF1PY3Dg?=
 =?us-ascii?Q?Rwc3sdLotia4dVifFnM6BksBYQ0jt2823pAJU5tY6q5DRgK/lU98Ygr7KdZ9?=
 =?us-ascii?Q?LiOTgjc6ycBTnnN+h810Ki5Id+ryxUgxVAYbToc3MPfKTO5SioNLBOg3GM/U?=
 =?us-ascii?Q?cDwgX0GeQ/1N9m14dMkudkmvE09sm1u9C3K8r6WlmdVOabvSKcfZ1hW7m0cc?=
 =?us-ascii?Q?K3lywIiIVO8yqb7Na5mmhpTn4LLHgOQUCOlu6wuxEq2gftrh2dFiQgdd7nIP?=
 =?us-ascii?Q?QVvJqfhv0Mbdehij/Q7hTN9uKZ9D3e+JO9EZnHlTDiqHEDZ8tbU+2fgFkz/M?=
 =?us-ascii?Q?cI8BRWKhYPwSD35QrTxXKvyM3vgz0m3C9bXWa14d8KHTpbvQdLtZrGf5D3vR?=
 =?us-ascii?Q?J4Ru0Lapt7qV6eJNuNeAaSHP7RfXrlwywSuoFzuAePEsS45UX464EM/LZ+XE?=
 =?us-ascii?Q?Yvgc1aj/M8OJqpEg6mCg4hA3TgRbPP2gltWMalOi5HJTpgXIXRegOxmT3h2z?=
 =?us-ascii?Q?zQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b5584b-a097-407d-836a-08dcd4464291
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 22:49:01.1145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ZoIkPWQA9zHv9QF0zyezfpJwKgQf7VJ01VrZkt0xrbU2bB/Qkdn0KO3eUEx4U0lx98qOXZvrV+S5xU9xJC3sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8103

Hi Sudheer,

On Fri, Sep 13, 2024 at 10:43:19PM +0000, Mogilappagari, Sudheer wrote:
> Hi Vladimir, my understanding is ioctls are not used
> in ethtool netlink path. Can we use ETHTOOL_MSG_RINGS_GET 
> (tb[ETHTOOL_A_RINGS_RX] member) instead ? 

You mean this?

  ``ETHTOOL_A_RINGS_RX``                u32     size of RX ring

