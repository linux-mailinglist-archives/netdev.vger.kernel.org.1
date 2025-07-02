Return-Path: <netdev+bounces-203505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AA1AF62F2
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 22:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47F416C271
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 20:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC7022A80D;
	Wed,  2 Jul 2025 20:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zr3GnOpJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790442F7D15;
	Wed,  2 Jul 2025 20:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751486537; cv=fail; b=ZNdgqWUTfMfUl96mjpuNb3hldwReqbs4Ebhc+Ma1EzL8fMubRNW/5U3t4cwqZLjVQer8okxvL2nT+GYG71F488nRExnF+jhHNfmkDZSGb2HIVV0dDo6rXxRa38TPk6yyt1duaCVqlWXwxZA9vjRqM+5Ep9VAIt3WQ9zSiHTQcLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751486537; c=relaxed/simple;
	bh=MAKw98h2s5JsTXtwDJpDR9F0CsX8MiGfkGSXBPDNiJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Uii/0aE3JnuwoTPgahCibeJwsm9jKee56rGoJ6wgagQPur1Kz/2EfI1ryc3lKux+QM4Ue+jo9PuErls8yC0BbYNYH2lA3I7F85N15SFC0uhjCeqhMeT0NH5/zj1UmapKtGGGjQfLVD7vzPUdeSkk8qx2t7k8uWK0LSrkwR2SIg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zr3GnOpJ; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWW3HdTCnLA/3ITZ5vOjkoTQgG3gI5tbwJelBMpILyX9woSEcxAPDMnokl68hc7FPBlRtZQLGaRyIITPdQVX5iJjKS2rGKhw5L+Nt8UmvLx+RrG7bGR43F7jfaBCUqex6HOHitJGmnScrWUC5QESokRoPdkhbNwTUFnLlvadf/i+OkUyfNw/EUFSBCsNz6pLQn1wsV3kp02HSZnMkdOnyJsCHBfT15h6LUF6GFvZveGifWDGES8iTJiKeSsbgSDIKBJP3chEdgaCywZPlG09ylmvQGM/X3f8MDELgIRIYpYhJCy2yhLYtUssNKy6OFx2M2v2432HUQFdC7ms/xb8Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGu5hDJVKabMEdPdq+jckPdh5JJF20OT4xSamYW3wz4=;
 b=AS1JOErqqmVT+8fl1N0VKEA0Qsz5b0IQFGXFr1eeo9MyTsem7HEt9OQL+cMWRB9fha9tZn2padK9fxdei8MjwgogXavA1ncjJE6Cyaymtc/IOjWsu+gBuX0vjH5xJ5v3w7EFbp4DfDT24M1QVhk1mbs8z1ZryKK+1E0aZ8Q9MCzGcdil6zICF+iXJha9s4Ryy9yYae2VCLkIa3sZmr5yp95zIGxQ/UGd3SUnReTew5FhpwsucQjyOmV0zjfZJM+8Ng43bLTDQPSNGYmi0Ov0Blf0L4b4EcDG6NTJP9nBMYNLx3cVCGAMy84aSXRRU09esuqP1fMBqmDoR3poZEGdmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGu5hDJVKabMEdPdq+jckPdh5JJF20OT4xSamYW3wz4=;
 b=Zr3GnOpJpuWx3kR5o4UBx6XgJbKHY193vyVPjGTbIQ+02QNMEmGyVk4G1ZAeUM69GJyrLX9cBKLaUH+Yzc8kUULE/+SwnYWy5XX6ICNF5BZY0YNRcCI3qigXayEtsXyZQJ7Q6vc5n9PG6HuJF9Tk9OAJBDl2cxK0XdJkgzF2QAHknGLqrMRvpa7mbqXOy+9o71FVDGaIkLHxiDmXhK+vuNvIz5V4G1+ujNd5i3qechwHzif2s6YaZA3dlI6AiCSBngT8+V3qX2uZQFjcr2eJf3rDocdFsIe/ZgcuH7NKQZ/8EwyK3EiySWm0+TgifZmUv6NZQTOAUiImZQva4/TbuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by PH7PR12MB7817.namprd12.prod.outlook.com (2603:10b6:510:279::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Wed, 2 Jul
 2025 20:02:10 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%5]) with mapi id 15.20.8835.027; Wed, 2 Jul 2025
 20:02:09 +0000
Date: Wed, 2 Jul 2025 20:01:48 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: almasrymina@google.com, asml.silence@gmail.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, tariqt@nvidia.com, cratiu@nvidia.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 1/4] net: Allow non parent devices to be used for
 ZC DMA
Message-ID: <c5pxc7ppuizhvgasy57llo2domksote5uvo54q65shch3sqmkm@bgcnojnxt4hh>
References: <20250702172433.1738947-1-dtatulea@nvidia.com>
 <20250702172433.1738947-2-dtatulea@nvidia.com>
 <20250702113208.5adafe79@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702113208.5adafe79@kernel.org>
X-ClientProxiedBy: TL2P290CA0022.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::6)
 To IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|PH7PR12MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ba3d543-95f3-464d-4d97-08ddb9a353f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z5z38uoNWX2OFX5tuncK/E4fSsX0keJX2BtIjckMks5XB6r4YPuqLfVDJrVR?=
 =?us-ascii?Q?QldD1e9T6Ciz83naHXegfedhk8+dUO70mrnSNC2GzS3qF8FwSErE6XywMUXz?=
 =?us-ascii?Q?VaEcgIOhLni44gkTvE6QQHLksZpCsm7V+TZ9nH3ZFLIsXWbV4zQthqfoJVei?=
 =?us-ascii?Q?YBlaWFsdQhtuRKORrBHDs6I+pKL2Rd7u86XznTJBuxp6YrIfXGimCLwG1UsD?=
 =?us-ascii?Q?ABg/pswTxs2H4G/7quDbE4u4gqYE4X47wGTOngLxFMQ8XV0IJFaK9AKryZTY?=
 =?us-ascii?Q?5i7yQGh/XdfrJeqWrangBmCVBqb/Zug5OX4CNwOfEAwRlQCg4fiq2l42yYDn?=
 =?us-ascii?Q?S+yD1i2aUukVNSNY5EsXKds1GSdt+mWySUAZc55aQOz9WUo+Aqs75Zfb8hBa?=
 =?us-ascii?Q?/xEW7Z9pY0gwoFyCOWiXQHYretRqGBRU95kPbdvrPn3yZqjr17im2BilsmTe?=
 =?us-ascii?Q?ntjLy8HFbxasQN8+GH8qHfFWhAX5Rtl07o/voIRUbjyb6gVv4+VD7G9IecOi?=
 =?us-ascii?Q?ELSoNj94FexLQaglF7X0LY8LyV7KSRJbQEfHDgnNECXO/wwPqWRBXY7ou57w?=
 =?us-ascii?Q?acukDSrEhJDfHbKx9silOk+NGH9s4JhZBJPr8hHGwKkNhkqZrRpcBb4hSc7C?=
 =?us-ascii?Q?0woUexLTgji/S9rlJx1nIu+D+1xZve1xICQKzaZXC2mva0Bjxfj7x/mddMyw?=
 =?us-ascii?Q?WEggcmfHfFsmoPQ/bCVv0nH+6JYCr5LdJlBJVufKe33utF3fPg2hBBc/suEr?=
 =?us-ascii?Q?rbiKnzXg16PAG6sh3h2KMwRBv0X/PN6p1gIpa4ebBK5FgusmHnLEakQRR00s?=
 =?us-ascii?Q?6f2zQomcPriQTu3PNhrsGQ7+rmXkLY28HgUxyBRBCx23PhskLDC57C2R5u79?=
 =?us-ascii?Q?rjVr+EUr04iAn2y8TUxhixuZSP/mtOltDe6+qjYBu1X6UOjJAAc5aWfJBDfH?=
 =?us-ascii?Q?PEjVmaXnVu3JEmZEUMkPdpgOsbntKepL98QLntOlehVdG9S2eNSHHMDOh1Tk?=
 =?us-ascii?Q?djr4Pn//hcyEUwaMAoidCt6WnD/CyrHbYakcZYNrDv4VlpRQgGOz19ppPVOa?=
 =?us-ascii?Q?LrhaJuaraVB7Zjiq7lF2NDjAlWIxDI5sme8zeYggro7xa2jpyqbAoOxZ7EY2?=
 =?us-ascii?Q?+VHu/VI+wUyfZ2QUjGwhGFQR597u5oebmHSFIvSeiSbD8poF+2HMCCi72GG3?=
 =?us-ascii?Q?q/7iAUCEh2ok0ckR5EifekMUgFzNrXV031J3QFYYWLCU4yIB7JjqtTNRFQb8?=
 =?us-ascii?Q?fFawrOi+pECydPiLMrZbJ5FBM2j2O9h/KKx0ewkx7Ww+jlSWFhcIW4uyhobw?=
 =?us-ascii?Q?TJwJtg7Qs6Cx8msqKXPchB4/5dSsBa6ZE/Gz7yMsFas26Q0SjllW31swBBVH?=
 =?us-ascii?Q?j7I+4znjy8Pi3zu0Y2ByxuTngcpnYwkbwqPrCMeq4YQ7Ccr7Puntts39kyIb?=
 =?us-ascii?Q?N6nAyjE2E0Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ED3sFxqdj3D0KEilpV5S0fx771Mati059t5Wy5GphKN9jTNi7q9EbhYXduBK?=
 =?us-ascii?Q?+dLQRFwpDxarc7GI0OR4Iw+SMIgAGXRJikxkMxjiuDia6xmFJI95yUSCdb6p?=
 =?us-ascii?Q?ubF2CVtP8qeoNNVEICXT2RagS+L+KuzPrJ7KcH2mB5of1q+FCiEEpbk56q15?=
 =?us-ascii?Q?wdDAnT35Tj0AZLUyYfOpcHtrLh8Rom/JGhjczyAoh5+jlbZs+D4irrDJO1JZ?=
 =?us-ascii?Q?Y1UhQNGQKM2NQFDWo/lkd0UqbQ5LPzb5nqaWQoNGE88PzMaTDislMwR80dA/?=
 =?us-ascii?Q?3VBPZL55wAHgcdu2j8MwSIOCwNQyPLfQucapxar+uluKSjDtTwr/So47cu7y?=
 =?us-ascii?Q?vwTlCfm5sUUiDc1VVe3gfyWTd7XbQxj9hTy+4OfY4XEIwhgh1EEWCQ1/QU/u?=
 =?us-ascii?Q?SWq36MlYRWrwtqgSnZKxkdtfVVHWnUWORVl4/yLPDHaJxjJqy3z59M/ZVvG0?=
 =?us-ascii?Q?Dyfc22koAPE9KN6tcD2PCeMvaBSkJuWOIvrofhuwgG+bdaa5Ir6KCSfd9t3M?=
 =?us-ascii?Q?1G9JTiNiv/1Rfr7LPdXe/1H4jo3AK+BCSBWDmjvnLoU9sXPHckKHR2gtEZ+X?=
 =?us-ascii?Q?gDrBdm2rSb8BMxfJOf+T3ceIhwaTj745yeBu1gXbE/PTT0X2zkrvwj7iVM2R?=
 =?us-ascii?Q?LW939ZsbZ6UzBJu+29pSg3SnRw/IRW8PYMP6qy87qGDGS5kso/O2V324tpzW?=
 =?us-ascii?Q?WC46aW0AncHwQEMl3IC63f3dwilIj8UIrg5ZPKW9tihPL0y980r3clMRVCP3?=
 =?us-ascii?Q?EIJuIc2qpsx0uoMNVELXgnzvCByOnrTzpx7nM/9LJz3YGOQ/PQTmDN9JJrrC?=
 =?us-ascii?Q?pzycP4BrG7sBJS1hQ4ywk37MsOeeF7qqnamoqKNvmtgdZnkdDnH0/CVFzvmh?=
 =?us-ascii?Q?sL2FV7bs90UBLitdJFYqxZONMd46Cj0SPJQ9PYk0jUxRu8qyWRh37SRLuhlN?=
 =?us-ascii?Q?/QCYd9uDRbLrsTMVpC/1jp5LdqiXNgFmTdQqk0Xp3EwWHKYRKJcSk3aBRECn?=
 =?us-ascii?Q?us3iY0FmN+wHDlWJNLRzKf66aLXVrcf5MQTk1Ezp2Kk8B18hZOc5bSlveOkQ?=
 =?us-ascii?Q?LOfwiFfHxgroV2+Krp6BXmxENnIZOz2WnsWIoXHnQl/McHZGnpWlwIhgog4h?=
 =?us-ascii?Q?XFF3fTwdRHb+pdMiDpP3WYsQJg40q6Ubkd+1rZ/q2nF5vdL6oItJi2CSSjM/?=
 =?us-ascii?Q?0vGKUE3m1vvv1YkJ7SRp6g+rTYxTUSCJQmcuPSzpkHACI5toIxGhX74LTpLh?=
 =?us-ascii?Q?gtaq79rCOn1Ja7yGqpTUanQAQI4Aa9Eqt4dYZ94LFbTC6z5JFm9DQcl2G1hy?=
 =?us-ascii?Q?UCofqIw4kJY7Uu9dojTovPIFx+CztiazBqrJkesSX5cCwnPlS2kJj8G+ky+v?=
 =?us-ascii?Q?p+RSroqG4sMC0ppcrw7Fa89okwXH80NR3KvtFTz4dNk9mvo+tsjGPXoDJnfF?=
 =?us-ascii?Q?DDqNVN+Xe3k8ammWM/SGoh+5iDG5ua4aPHFD94ewK1KWt74u5+1YjzzRjG3j?=
 =?us-ascii?Q?JrKhRHzoFK4sNsbtGnDiE83cihqrF2++gsKt1Oi8uGlmp251A7gUjfjSp5dK?=
 =?us-ascii?Q?lopc6Tpu4ruN0VgkdY4fDWfcrCzrevtmzTv/yr8G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba3d543-95f3-464d-4d97-08ddb9a353f6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 20:02:09.8366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HcRYTRF5eOzgnSbp9Kpc5zvtn0n6cpuGtQ57QqKIaK78/JoysHfgWP2k9MvqnY8ynXs7JkPq2ueAHw6ISWFc3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7817

On Wed, Jul 02, 2025 at 11:32:08AM -0700, Jakub Kicinski wrote:
> On Wed, 2 Jul 2025 20:24:23 +0300 Dragos Tatulea wrote:
> > For zerocopy (io_uring, devmem), there is an assumption that the
> > parent device can do DMA. However that is not always the case:
> > for example mlx5 SF devices have an auxiliary device as a parent.
> 
> Noob question -- I thought that the point of SFs was that you can pass
> them thru to a VM. How do they not have DMA support? Is it added on
> demand by the mediated driver or some such?
They do have DMA support. Maybe didn't state it properly in the commit
message. It is just that the the parent device
(sf_netdev->dev.parent.device) is not a DMA device. The grandparent
device is a DMA device though (PCI dev of parent PFs). But I wanted to
keep it generic. Maybe it doesn't need to be so generic?

Regarding SFs and VM passtrhough: my understanding is that SFs are more
for passing them to a container.

Thanks,
Dragos

