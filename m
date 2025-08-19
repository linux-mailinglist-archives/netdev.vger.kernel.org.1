Return-Path: <netdev+bounces-214983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D2BB2C74D
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 16:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795253ACB45
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 14:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA07126F285;
	Tue, 19 Aug 2025 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fY/78+19"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217B222157F;
	Tue, 19 Aug 2025 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755614485; cv=fail; b=Oq4F1nUUAjctFK/pyivaL3CisIxjh0PgzzhI/hwFCVeh6GzX4MJX2NrZ3sLqHyIl1AKUI9+WswPHYOlpCX/kyLvz7jFAR5uATX8pvE5XejLqt9ULXpxo560z0Ujh3+05io3ZA6Cl7JkN5LgSqUAAtzJ3ag6YZArpsTIp8lIBi1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755614485; c=relaxed/simple;
	bh=mWf3Pi8uUXWfX6O8vIG2r3YY+N4RtZM0oOFUMpX9v7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fRP8oTIuLsLQ+ZBLJL2Fj0mUZOAK010015RZU1PZ+CoUkUefIYLdm1wL1tmdRANlu5OTLtDAXITwee5DnKF9WztVNRS6tHchs8a60BWdGiomcjPkBNTaz0uHVavMGp8Dxtqc/Vr2K1tf0BErzsVRv/rtkHakM44nIYnuwmmEXv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fY/78+19; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ubrTSxgVOkK+D8p5jNDX1VSeVUR8jKGfoh2ZLueBuPXwZsACvpQKsOcSuTynT/9xeVJesURp0Nh3djdgLo6p1+QwGdxljLwHKbMXMo1v9pbWF01PrUZJWS4DTOMHg3f36a8DUQLP9VXj6Y6dy6mUTNr5ZM5xUQxQ2LVh0aDYrvNU7vNgz1LAfXhP96X5viON9qgMCJDZNQ5+R4PJtJfsEHNS6a4dWV1n2yWiwWl9naOJ7zCCrrfhrvbyDQILJjRW8u/PwbePlP2DQcjZfpL/zIq7k9A/K9l+5yarv2zTwTj7d9KaKgj3en6v98sDwnT+yeGGQuMWSw4otKKVndPIew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YmPe7sBWNkArom0sDY9Q6LOLu/Q8JOWD9pqMsPzFhs=;
 b=qs+IdjNhuMzbOPLk/7zgbDmb8Ia6mjT0s4+oZHQB4An2ehRnRiDHoTyQQ2BwDY11wsX87K8ylNHo7GTc3Vi+EV1hEhlL4HkF0A07DvlZj+LbXNGM7pm0ZUtBgIFuAn1KwO86mJuTbUYqag8Xz9WGdPW0jsMbb9LWWFYxLYwS9LefJ/ZpEqxdE+CNAp1qIUEFO/0UrEsypDmSOqiMjtdkhaPNZuL3lI6/aPd0oYIAnhjG9r632g8+AZcZIhV2a22Ty3Uvk01tYKPwnQ6flxl4OjOZPp6UkKBitwj7EqemJ8ltLbOBm/UGp7tLUcps04rupwEWBh8VUKUTktzSOWAOTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YmPe7sBWNkArom0sDY9Q6LOLu/Q8JOWD9pqMsPzFhs=;
 b=fY/78+19mEM9wURtPzdalfLaNqYpi8+a0WdaG6XqPWmYon5MHqP5kbuXocTrXKu1jezt88wQGRntRbp/RNGsgC5K2W1iyYrYf1TaKpkgrwdAkGHLtSpGY3U9tGB4H8xuO4/4KlkBspsySGvqC96eMPPZYq5qUlUMAdOIzqV3lnW6xSTLZKw5tVH2MjXrBbAnBtO0rqNma0f27mWldxgEf3tzBYa3Jm0XjFoFwEIQB9kgpg+QDvv5f4l9qhyVTF8m3KWQIKnI/zAmph1IJnjl309xQ0B9cxCWlb5CTEobe0N/LgPafHMZ3Vdq3LYGcQKkf+z/730FD/dxhpZDlWRHqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by DM4PR12MB8569.namprd12.prod.outlook.com (2603:10b6:8:18a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Tue, 19 Aug
 2025 14:41:21 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 14:41:21 +0000
Date: Tue, 19 Aug 2025 14:41:08 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, almasrymina@google.com
Cc: almasrymina@google.com, asml.silence@gmail.com, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, cratiu@nvidia.com, 
	tariqt@nvidia.com, parav@nvidia.com, Christoph Hellwig <hch@infradead.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v3 1/7] queue_api: add support for fetching per
 queue DMA dev
Message-ID: <gessx5kiukxckwkjqmtrf7j52i42zzme2th4zmvleppnklt2dq@wif23q6f6cog>
References: <20250815110401.2254214-2-dtatulea@nvidia.com>
 <20250815110401.2254214-3-dtatulea@nvidia.com>
 <20250815101627.3c0bc59d@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815101627.3c0bc59d@kernel.org>
X-ClientProxiedBy: TL2P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::20) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|DM4PR12MB8569:EE_
X-MS-Office365-Filtering-Correlation-Id: 8284f71c-b0c5-4a22-36d2-08dddf2e768f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eTZM7qQUVGZ8ob8zq+AgHE+c2dUKRYL3qKOJud/1smEE5bA/Nnyji3EZt5p5?=
 =?us-ascii?Q?ERR+gB9kUxkf/Ey88eMch2+M66lJlFHmvQaSKlCHFbirN5he7LeyEhQ1KpZo?=
 =?us-ascii?Q?qPR7kh8meqjGvP6c72W1kvhzbLNDzxu5Ct5xi82EgJtuLAOqFQcxUEifZ1ZI?=
 =?us-ascii?Q?UFeh1dOh5fQGrb3/1Dizrh85C/GF50K2mjX6nmdDg2Ff3zZBtuWJNTGLNCJ1?=
 =?us-ascii?Q?3af9jDQiotePI9vfhCWSQ+XdHakyjY4tCAmZJmvesolTq2jWfE9peVHiJnBO?=
 =?us-ascii?Q?PKcN2ZsXeT2nY6jSZGCANgPGolxZx07UZCfelFwwdFM+xDqKVL6w+NhwRtby?=
 =?us-ascii?Q?bjP5SzJLUeblQGnHjbpS6tq9Av2OoG0O0djko6dkIQHFmoljAavz26ixfRLJ?=
 =?us-ascii?Q?YDFjyySgS8M01HOI9LB1Isq5iC7zCHeEt+VBz9OWkNwWXbHPxxlUkNWoOCzK?=
 =?us-ascii?Q?IKuPVgQVXawmUz+s7yt3BHUw5L79ChcYFR1GDsKIVJx8sTSNRHeKKNsQh/s0?=
 =?us-ascii?Q?e+mFyrOHhDSqcnasNucwOTnASmFdoYOEsPsqyp6S5PJoWhnkB5erjZIggvOz?=
 =?us-ascii?Q?HoS4+O0FSJgYrf/C2FBVHfK8m9ylI4sFZSP9MblPXdGjm6S/toGUbCrkEh0l?=
 =?us-ascii?Q?0yoOYp6bosyMvJrrywZTtXggp+TgHKYJsrCkl4XPW94JNGaLHIEBPsePFAbj?=
 =?us-ascii?Q?huz6Sna2bRC1skhHAphUdU2lM+PHl/JPoXnH3/j+4xNySgbbroQtXyK20xFc?=
 =?us-ascii?Q?ZbA2KjUDycfKExs0c6ikWJFh3sOa5KQLrgir313SbcxaxJbERzWTQm7orF+8?=
 =?us-ascii?Q?vbXL6qjqblwfkCy24iPDN+Pl1LewVeW1jwpt9jlDQpZfF8+8vVmF4JlNYTKl?=
 =?us-ascii?Q?BZEKPriAXZmbO2B1oOXXAfijXXePDZgWkidtlq9di3ew4LUwuknZluEOth/r?=
 =?us-ascii?Q?GriR8gl0xPZ5lruTlwWvfYhJCJMVXSTDaXswJ7WkobQ2AHOQ0m6tw0bMBm66?=
 =?us-ascii?Q?TKmd1+Jq9Os4vCJEUylOi5/r7Hf9GL/3AZk1BeaW09AXh9XVoCxPM4DlzUUK?=
 =?us-ascii?Q?hoX3gSoLEsHl3/7GoeWvrYMUFKyL1CwSeORgHVSDdTP6xVH7XJCVbLnbZfWb?=
 =?us-ascii?Q?cszx1GYmrrZ6FdEwIEBy+/MNzJCuRXZEOvOJ7QTagnrqwUB+AAlACGws473s?=
 =?us-ascii?Q?pcCAJ71pTK85XxLDEazSqHemNLdceM2CRLzrez6Fz49BRWDsVXyqJIC/rI3q?=
 =?us-ascii?Q?jBMwCZeWhOuZYn8FV6g67ybpp/BHoLx7/Mo1qBwCqBi5Pnz5hqmgEPK62H2/?=
 =?us-ascii?Q?auvYDMmiqgdEjgWexq6FXc/OFZXw/5MwWixBewwMI53dCzFMZLOohogtzOjT?=
 =?us-ascii?Q?COxLR97jq5qoXUbuWzOXefRVY/7BZvE+yLyPRFl4iMHfs3aIFvcSLt/FZjlV?=
 =?us-ascii?Q?gOY6TlYy0mw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aVdBClOaObaKM7J30VrUFllvq/PdOxKQORebAr6d9OXzf4EmyQZ9hFBgpZC4?=
 =?us-ascii?Q?CP5vB6tsk3H+/gBra6yf6R7c+Sdjed5Wr9/rVp8kd4LtvWYyVwrUCrY9RfB8?=
 =?us-ascii?Q?9kZ5C4Grxa9FN9HT+ZMKQ35ZUFIo5NptyEogza2mlO1fglIMzfTre3WBHgTY?=
 =?us-ascii?Q?t68A1eZQQQ/HWIbca/Yv6nak4bhCpoQSx8BkBEs2nSQFFFk6XcvDhXR3J/Yw?=
 =?us-ascii?Q?WQmh0sLqV4QssZNx4f8SR5Uy39dDKY9BzSUBHbvlCy1/cde6w9L8tVbIqHvg?=
 =?us-ascii?Q?SpRsCWaj42nAnjEkOAZRvK5E7xkT9gF8l43L0HfANpV/bhURYF7t+oJ+XM9/?=
 =?us-ascii?Q?lHxJ1ZO6J+V+9ki4ekGzYHNeXfzmFbWLpXG10GHd8lIpOBw6DYp9VfZrbmQL?=
 =?us-ascii?Q?D15+4o41/xweCwVMso4pRXMIa2aND4ZIj4mvmALUYQrS5oNEziTvPdeMBcA+?=
 =?us-ascii?Q?dnQkkJhE/J/qdeenw3igOdQIRSdw32rEeVTIL98g1UReuEH0jZmdbvv+uGTQ?=
 =?us-ascii?Q?pQwmJlcHRSqNY87bXqs6x6XYZX+AOTqYuuzzQBbGubdg1+qUVQ4MUIT8pYRf?=
 =?us-ascii?Q?frTEZgVgzwI8NUjzUnyWFF33pgV0cbZveaQdpiZar01BvnTZjQTCBXb0j+Zs?=
 =?us-ascii?Q?2DYyMF9CG1fX7Q9l9M85ijahNEFPJGCTn6yhovOJbjzoV41JGddsXj3hhvwA?=
 =?us-ascii?Q?bVvwgV2qFyX7RYqHMnzQquKpX9GRGbRt1WoQifE0CcLtBcQNBOH6C9nFj8B5?=
 =?us-ascii?Q?dXXpq2CkuuSYMSS2UjK6Y2gpgm9Ez0MMbua3s+bXhbse0JZvb4ZYsmyklJA3?=
 =?us-ascii?Q?jyI4bm43hM0MpfdEcYw1KHJX8Rgk/V59+hhEM2f08/LBKJBihINjI7mxQV8b?=
 =?us-ascii?Q?rGUqb3RCQs82BusKAT44l5hfVK0EUcgjomox2Milr6e+0MVyzDeJ/9zx2vkj?=
 =?us-ascii?Q?04Y1j3zenN3ojymcKLkLbpOz7wC+eVghFU7lxo2B3gk4PWfHLK1pyP5iTwFG?=
 =?us-ascii?Q?VuFQNk7XMcPK16SsRI2xsMDmdxkqL+ZCiyTy6hvV01X6Tf17YPl1RiaZcAy4?=
 =?us-ascii?Q?Zkdthu4T508uk5wG/1xokb3JQbrwBaebkckaCTu+/yP5Tssgw9itusefM6iJ?=
 =?us-ascii?Q?QDQg8KK65b2Usj8rd1Uj8zew1HtbEeeqZJJ/oQ/VR9wkqTLlmAWLBqJP2HNm?=
 =?us-ascii?Q?5VOB1PUFqf1Ve55hWIHz7TfNKqn+5heSTBxgNLx89MYSGL8Ljkwuuy7JHnFc?=
 =?us-ascii?Q?yIuuv1GA4X/K9wyCbWDhyBbPSbi+PjgzcG80Bc66HlgbQicgP9qAGC+U8ER/?=
 =?us-ascii?Q?3Hp7mJqLHkpKlhfsc7V5Y1wHL9yD5vW+AEs5h4/r/LgcfLJ3/2jmocd7dYpc?=
 =?us-ascii?Q?xG+1DD1Ot23PWpoog1x381j6AaCI9HmLEhFD/Ibq4eRGyPectu+JVR/kx+I/?=
 =?us-ascii?Q?tS8onPl1GX4brxwCwG8U+co/jWO5Efy0UVSF/lRUjiN8DVTrtEYYvGrRGsOA?=
 =?us-ascii?Q?MvloA9iZ0cUbg7YWDjqAhED4fOpSBH4nPsO4jMn9+oHaJ+UIf97TrxW9dCCp?=
 =?us-ascii?Q?FVtuZa+Q1GZA0KxAYgvGRVYvPTfPVE79tZCq13pg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8284f71c-b0c5-4a22-36d2-08dddf2e768f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 14:41:20.9114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9JsyXLgTWC1tJFUUZlXFSGJdo/EC9Cv9WeTltTVTcGj/Go9Xwg2fy8Afzu+0Rpx57qeQq3gc0tabRne2UN10A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8569

On Fri, Aug 15, 2025 at 10:16:27AM -0700, Jakub Kicinski wrote:
> On Fri, 15 Aug 2025 14:03:42 +0300 Dragos Tatulea wrote:
> > +static inline struct device *
> > +netdev_queue_get_dma_dev(struct net_device *dev, int idx)
> > +{
> > +	const struct netdev_queue_mgmt_ops *queue_ops = dev->queue_mgmt_ops;
> > +	struct device *dma_dev;
> > +
> > +	if (queue_ops && queue_ops->ndo_queue_get_dma_dev)
> > +		dma_dev = queue_ops->ndo_queue_get_dma_dev(dev, idx);
> > +	else
> > +		dma_dev = dev->dev.parent;
> > +
> > +	return dma_dev && dma_dev->dma_mask ? dma_dev : NULL;
> > +}
> 
> This really does not have to live in the header file.
Alright, but where? It somewhat fits in the existing net/core/dev.c or
net/core/netdev_rx_queue.c. But neither is great.

Maybe it is time to create a net/core/netdev_queues.c?

Thanks,
Dragos

