Return-Path: <netdev+bounces-141290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4839BA5EA
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 15:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EAA6281800
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 14:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C657175D37;
	Sun,  3 Nov 2024 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ED1/bSz5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFAE170836
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730643810; cv=fail; b=IIPLymwfeVe8F0qgjMSwermjsu6lQ6Anr4tTlYy9mrHhd5gwBuVrQX+IWIQuCDR2H7RztnCXYUh8+nGupSrQHC3KF272fjDpK3eQszWe22dTS4V+WiM5ISheCe093320WSwZ5apFZki0ZzNU9xJA9JKSrs9iWdOy7iJ8Bj6qagY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730643810; c=relaxed/simple;
	bh=W+scV4VyZbrtzA7j8snoZFzWAQepAlyBmj1wCaHatIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u2btvwgdrT2i69ccLIWaQdYbhltoGWh1WkGl8NlaW5OQdpSLw1T9OvN+5KUfsDfMGIhdXSBLCwf6+r39KPOypfaDEOzTej7HyjyRrSEF2iBKusPi9YY3K9TbsXM4Bv/ImFPzAvvm8PxYA5LGIcgD/TW97eiaK0WwNMRYeE2uy00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ED1/bSz5; arc=fail smtp.client-ip=40.107.212.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1F91xdx5RBRsgusWPDl9iCz9sAtq0xqtztSj/J9Ui/1xwK7jDDmFWFciar9OSgo1w7vbVO94hmUm/2zOpF72dyuPMMCSyG2WNa5KN+t8SuubkPu9C4eJUQdVyvMO4yGeA4ngkMlYYCSwF8/Mm8/rfuhyaeO00d1BxAh3SfvSwR7P7JhorVadzWYKJGJUbtKkl6uOA0zPfXJdtAq3iOyp43plBfwavHrnmiuIPxj9IErua/h5L72m8vNN7xkdFLUpOnwQPQn4sKfaaatqus1kwWXoSKqUywk8yMJbhKqW4kuHsdCWBhfwSkGXwuqngLwparLPfSH5xtul3GGz/+M+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7ZvRNNp9QPA5QJhQOVSCBahWxzErKJ3QnP3lgo4JG8=;
 b=MqhndJbH3FKgWVE2a3AO0LNtq6SJnMKYANQOKr09uXsBbKlBFEstbXRIk5vkrWYa+sZUcBrMVNvXhKJzooSSXgHeWFKPBM5hW5huWZbc595R4MyioGh0PnprIhzTqrE1GnnoXKT9CxRh4Iqw3vt7wJX8s8UGLBSKn6+FzuINL6PFMV0jQec+M16lARQRUrNRKeacHbRjOTCZYvXcBZZcCBcImstaRNhVc5GSASa1NYQDObcI+MzxlYgQxB1tC9p1tMIwvnSqUht6CkJLxgjbjMkxD8T+tVPe8KW2fq/uyO+j6vKSy9jKs4t4OBHLhG4CJPUV0WzfhKrWXguYd45S/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7ZvRNNp9QPA5QJhQOVSCBahWxzErKJ3QnP3lgo4JG8=;
 b=ED1/bSz5zXQ0d5ONVa6CacE8JbeSMsFevXCjKwyTfpJIWt0tvThWfrP4kHjmLIqkpgov57ZSl9xfxakRj4kU4pN4FEXkebNrkps05LtVx8yh2D5Xd2mSjkbBw5zwDrnSYdR9djRCx69P7BDk6CLPyrBaQhLMIOAl66JmozOg1q9PBKF2kHyfsGSktS2sMLdG3mtvxRQIPMsCEPrn/Mv7lc1r0gulHAKCJWI1KMIDN+jo2U+lGPA+byGhzz2c5tS6Kio6ZkAWDyka4iA2A90DOhBcKMEc2UyHTmY785QsjuaJSQFe9+zVf7EWVjOnxFTyy9Du+jjfJ0JWN188sgFbHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by CH2PR12MB4263.namprd12.prod.outlook.com (2603:10b6:610:a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Sun, 3 Nov
 2024 14:23:22 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3a32:fdf9:cf10:e695]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3a32:fdf9:cf10:e695%4]) with mapi id 15.20.8093.027; Sun, 3 Nov 2024
 14:23:22 +0000
Date: Sun, 3 Nov 2024 16:23:01 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>
Subject: Re: [PATCH ipsec-next v2 1/4] xfrm: Convert xfrm_get_tos() to dscp_t.
Message-ID: <ZyeHRZztmAWlJJwt@shredder>
References: <cover.1730387416.git.gnault@redhat.com>
 <5b34d13b962afc226c4ad1246ef57e502c047fab.1730387416.git.gnault@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b34d13b962afc226c4ad1246ef57e502c047fab.1730387416.git.gnault@redhat.com>
X-ClientProxiedBy: LO4P123CA0126.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::23) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|CH2PR12MB4263:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f92cc3b-9820-43fb-29f3-08dcfc131112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YpybO9qVue659kMke8dg/CL2qhDug3HWsE5sbrL1PcP07IRWjUrqy7yAob8n?=
 =?us-ascii?Q?iZ1cl0L3ioWWzx7z9af4C8xXWeqa+oY6Lgsuk/TJphM01F86y5WmTMgdZjiF?=
 =?us-ascii?Q?0DP9X/+DqiBQoKV32fhzN2TAZ825MQ7i50Mc7XcGtDZwZSU76sPey6wdepiH?=
 =?us-ascii?Q?/A9NuBR9coVbuVOQoIvXOdbn5YKQVYOdAQMCtymDUOAHtSUAWYu5uHlabY1M?=
 =?us-ascii?Q?n+plZT4hT4Aojp0iQEf2wpjzfejRHwJp7YxEia8nXdJsGyjKFhXFLuz0gKVy?=
 =?us-ascii?Q?4/ePu/IgiBuJ0tyKVjaUWlumhcE+drwOso7OsxcV44QLElFgMknu1Qa9gj1s?=
 =?us-ascii?Q?dhnEh25BV/5hRbdDHyuxYRZTifWHxWcfs+FG8p8zfowtE1+76YWL/lsUZ4dJ?=
 =?us-ascii?Q?nDt4p1Htta8pXtb7ixcpHD++qlXA5MlxzxT75GxyKaWwOMpx/YUbZlYzy8v5?=
 =?us-ascii?Q?Kw6joiLe32Ye0mOnknhEm7xw/jNUwrsxojKKYE5lxMEC0CpsNs46ZCUlqNiB?=
 =?us-ascii?Q?0tfggVKJF8kB7wf4L087pA4Ug2ap66dLScqJvG/P41QZXyG5XCYa/BUwZTrf?=
 =?us-ascii?Q?nKOnxWwEbw+0XH07hX5W+oxBagR8RGOeAw2taEkYajIjvge6c8nZTwjfHGGW?=
 =?us-ascii?Q?2PF9CZolXtisKUmbMYaPqBw7ryG4DIkIvldmHiIw2Pl5QW3qJFqxWyGcik0K?=
 =?us-ascii?Q?M0Jv3cT2umCSB0bEr+u4YtakbYFy3suWhNpTCwSMTOPuOIbisF6aGcAAhR5B?=
 =?us-ascii?Q?0Enskp7vb847guR3COWLHLp+3x1rbGXeXxs88lWR7d993rx1bIpvKOHNIZSa?=
 =?us-ascii?Q?Aw76A1SxpAquDV1lOy/OJNZTjKLxfOn29e9m8SqQzyDR1FWfYj33UMJXTNNz?=
 =?us-ascii?Q?Z/8oM/SUvk+mFzN7rdamcbGeEJ8QnSWXB7HD8u++4FgnSQYWd6OG2CconudQ?=
 =?us-ascii?Q?KDHZiS5d+X5VXiCz/pzRQkeD50Kf/jzxRGWO7yVXWONZLtkTgFE5crrMrCDm?=
 =?us-ascii?Q?AELaHmUbQqsz2INcgiFsBo/aVGsrxA+Fh2is8WR2WwqLFg8LJmELXFsfMaZL?=
 =?us-ascii?Q?5hARsBLU2nEeb6SKu5jt1y0Mshs/sCxpJjHNYimaYWgzMlNBMfld6QXGy15U?=
 =?us-ascii?Q?kLNAVumiysrCnMNZ8nFNk3O0QW5jODPttqsPd3nEQkc4ZBBvCxuyg67Ag243?=
 =?us-ascii?Q?Gh0CYNmi97RW3eWY5iDOoRf0LR/WTFyi222lMaGfKOL/UzP8nISw8KJ44cpV?=
 =?us-ascii?Q?2BHvcbimJrjUsUSjrv7GkicKP832X7tl5wYh5pb1kf/uaUBB1W8ml2eUUHPy?=
 =?us-ascii?Q?bfc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rIbYHGdwOtt8gpUSBlPOo4gexzUFPkhh+ugMuZn6dMEU3rwZs+GCR4yMjsWK?=
 =?us-ascii?Q?ZPr93UdhJNejbEHo8FkBn0LBM6/T8McfFnaPDuQxsYi1mDp4wd2qxZqSQ2Op?=
 =?us-ascii?Q?hmG9mTU65ewm0pfA8Ox2Bkpnp5U3doP1NUsAHfhgKF7GZKZ4Gmv17WOjgp+k?=
 =?us-ascii?Q?LNySVjCqVIOFG5LUW1M8eXCkNa3cWR2Ui3YVHf7F/dtu/Y9jSJiqEPzlCIAx?=
 =?us-ascii?Q?rFcuhcTAU4IbTrjCIUYvA0O26GlidYGTGolPmT49KWCSgwIxrIpKTBsT9nYc?=
 =?us-ascii?Q?5JMSQk9XSU96kzQ5IVZIL1lInRSgG8p5LcHBa2snvITmFEZgoUUMWbGcVviD?=
 =?us-ascii?Q?z6RGP6CRcxPLdTwkLjctwXWueFYk96SAq81oFF9wt65Oc/NiNHVsE5hYO86d?=
 =?us-ascii?Q?3LVWZxzEawvydx+I3RMwMs1qn/TlrytqYwmXWgZ9lBhmKR9VcXfyyz0OkkvH?=
 =?us-ascii?Q?RgJykX9oRw2BZAP4qWa4Nqu13wsoDsMyV18ZWIIVQOIjTxOByWls/a3xuGFW?=
 =?us-ascii?Q?Xo7eTq4Hd5BgHynl0bB06jtVPoc3irS9AnlXuWtxoGnhU4RHc+hxmtqMPmJU?=
 =?us-ascii?Q?QAxakIyQSsHS9jwo6WQE0M1Tiaw07dbzXfsUwPfWVvm9pODKUEFcFYK3hg1y?=
 =?us-ascii?Q?TvXxj7mr9BSL6N0j6EHh0PE2A7rJUkkXs1bJFDv3f8/+Sdj7lDG4wt24kyRk?=
 =?us-ascii?Q?3/Iki5ktLb5svCUCE1vdPtHTpEzF2/pFGmn6szjFIEX2Cf40zUJx4B16vUNb?=
 =?us-ascii?Q?QtB9osTOAiFvoSFIDMgwIV4r1uIPv5u7VqcuD36cImCjZZyqVoOYTQAGwvrd?=
 =?us-ascii?Q?iuKcfqj2ZNcW3soe8zSn3J7ezx5sV3eE5jrpTVtN2gcF4Glq5Yl0AetJ25RY?=
 =?us-ascii?Q?XjFmcuMXQn9Mkr+Xn7Gnw0MSX2+odCV6kYftXHtCN79L7Aya1gPp8cK6+mTN?=
 =?us-ascii?Q?+VfHRVgNRgJtn76QymYYyqxgzb4pFuvC+B0MoVQ0qRoVDhfPYGt0U5PHF2Va?=
 =?us-ascii?Q?aTf9nr0ftVLl4fRgXshiFXqbjbXY6zMOsDZoacOUUpsk4q3Y3REJ1h5m1nao?=
 =?us-ascii?Q?W+cvuIWfNg32cvfsfDvFiaQvVJzkwQW1JXQY3w1Qu2CDeVKfdDOtzpbtiGHJ?=
 =?us-ascii?Q?UsNJsudr+X9xmd8DmRW2tk54R2tlXiC3jfj6cTWi8fpJvR03DCBOmU2qG5r4?=
 =?us-ascii?Q?VyIzumcLdWnjVjzHTqxehFReEZ5Xm4CSQFGFJJNp5lEpQ2zCxPRmQllEydWF?=
 =?us-ascii?Q?bEC9URSgZCzIGTPRgE5sF3yjpbxiGv/DcRSDkm51r7tzxzDwb3kBK6k8uLMs?=
 =?us-ascii?Q?Ojp0mrMMEbsBGIaszYhHpB0mPAjeTr7JzMa4gZi5LQkRhmkPZjs1BSKXHt5N?=
 =?us-ascii?Q?CcD3sKJOCH2waoDYPWCHG98Q0lBl3EEKFGtAFDUgNAxKHzBRgVTDoS3bC+eE?=
 =?us-ascii?Q?tFSUIjBtb7mFheWZbSjVFjVUsuF/QVH3isX3FBlRqZhD8LJOO4JbIoL1gW63?=
 =?us-ascii?Q?r16cgdTP6Sb6hUkkBTy4Zhmea1kkSvfmym9sc46EkBlITx1PZTw1yTZIwjyL?=
 =?us-ascii?Q?XGU3gl7mmv7mj3H/IHrYxVEB4l9kVwbomSYVzhGk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f92cc3b-9820-43fb-29f3-08dcfc131112
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2024 14:23:21.9714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+kD0Yeb+wHw+ogQVOHRPRszo0HNRm/of/jH+IDuiujLXN3yxnpVGeZoCr/zGJ+nvgQ/ak6vidV0zM5kLDa/lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4263

On Thu, Oct 31, 2024 at 04:52:36PM +0100, Guillaume Nault wrote:
> Return a dscp_t variable to prepare for the future conversion of
> xfrm_bundle_create() to dscp_t.
> 
> While there, rename the function "xfrm_get_dscp", to align its name
> with the new return type.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

