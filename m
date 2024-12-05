Return-Path: <netdev+bounces-149318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9BA9E51F2
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0394C284199
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B0A1DDA20;
	Thu,  5 Dec 2024 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ktV4CdnT"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D610A1DDA17
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 09:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733392354; cv=fail; b=eOZNeKSKsm/md6E8iJl5AsTJL7v8mgEzPwilhIw2vNIdtIlXEZvmAmdqfyYkieb5QvcsyoaY3c9bOG6dYlqZPZmG1pPjfblmyvJb3yhZJhXbTAGUxZWoR53HdCJWlgLF0OqhEQ5g67bLnQTdLbjY6cUXULB4isw/U8K5Gd6Ksv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733392354; c=relaxed/simple;
	bh=XspYTR+JcexYmauTat16aq9n4Lsrf0wSqq8lIqA/wTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dZCvFu643SB2UYlH1qSQ5ftItxWJ2B/ywnGSaXniR1zekR6BbWxEp6ursp8yfOZzgWcIGk37ITyIXLDSl8ddXgP2KgXZat8ukCMU9z9vrszaqvV0F6jBKvtnc/t16JMsrd7Pcjt0aVrfc66NUrpdf8LXQhvGHuHiE9JBqLWuC2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (0-bit key) header.d=nxp.com header.i=@nxp.com header.b=ktV4CdnT reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.20.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpDUPw15Kwmvg4zJkNPqxapHqD44uVpVtslxTiMPd72iXaHNJw+h3viQZCzEtNfV32qLsJLQHaAT3JkTeFbYt7wSlUgpb3/dAr7LVzL8y15JIpOsp4oQO65FrdwVRUHpmXxa7EDgUjIxI/bYcSy7wHZOPTBxjCzc9xHi5OX9Q5ub0R2SIMIlbfvsdL+RgvF/ePFl2/Act5c7uSjjQHUO9iPwEhRIFqLWaBh16KNYoRooqA/mbFjHyEeABr17XuNTC4opjAoHc99JKpwEB+Qm4xLx1gkl483BiZDeumx/M1J+nyImAH06E572ZQnveev6N70jvsOyVce9RIh2CDYdkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkdamAN1EI1/ZPP1ENSggLAye+drlIzpByC3UfYf7g0=;
 b=GsW8UkIOlq6mMqHCOxBSfEqsA6p1Miq2+/6XBNAvqKNOUW+KwgMIGimVKSIV6pBFAjuYYqpyc6YJXXUSO2/fx/7sPGd2l+zYrJQmNRqzdURMgMQ2k9jNloNRXJvL53CdhmWAJNkFlYxclapyQISSyyraNPFLruOWexegMfi961I3tZ584h5Pd+dDtoQ+eUV5FEcL5TkmmZUqMJB32YWAbFJpfZGT8jcMXUZpsxyvma6X9umbqu7xg5NIVXBggIIHEfKnIQzoPk6DAsdZbJNfnRUAIgB4JiI34l29gnAOg9Ay/aK5uWAya/X4YSx3haBjdzRPkcHWLSJVI3p+kqiDAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkdamAN1EI1/ZPP1ENSggLAye+drlIzpByC3UfYf7g0=;
 b=ktV4CdnTPMozeK/adIKUB9/unAD4zTLq1Uyu6tiNbFIXdnQXEvszXFzG+7wzSFZczDAag/9knA/fSG0onq/GlsmuosuL3kciZakmnBiCluIP2rcKTVmWf21PB0o42G7IB4u+OUKkM3FiGZSd33J5IjsR4/UGbNS1aUMnT8+Q/j41C1oDqIpy8oe8CBMr0jmgn1GaWPe1W17hYTRBmQ20Pt/1bMX1lG5NiKt3vnkznmTqnISKIL/kF53sfVms6kVb5L7gP8o06XOfjeOImqUK8aHuUv4yAnlGVJ+PAF2J7FIj4SgjI4sELYBIzZLya8VtswS70jOri7p/I5IJGzpnZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GVXPR04MB10235.eurprd04.prod.outlook.com (2603:10a6:150:1be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 09:52:28 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 09:52:28 +0000
Date: Thu, 5 Dec 2024 11:52:21 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v8 03/10] lib: packing: add pack_fields() and
 unpack_fields()
Message-ID: <20241205095221.ivb3gnrhkfdyulxy@skbuf>
References: <20241203-packing-pack-fields-and-ice-implementation-v8-0-2ed68edfe583@intel.com>
 <20241203-packing-pack-fields-and-ice-implementation-v8-3-2ed68edfe583@intel.com>
 <20241204171215.hb5v74kebekwhca4@skbuf>
 <4c0cf560-e18f-4980-918e-8a322afd866e@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c0cf560-e18f-4980-918e-8a322afd866e@intel.com>
X-ClientProxiedBy: VE1PR08CA0023.eurprd08.prod.outlook.com
 (2603:10a6:803:104::36) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GVXPR04MB10235:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ef19fb7-5472-4dc3-4b51-08dd1512876a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GKWMmVrOtZZnbJ6ViepyMZOOari3/IsfNGGmSKkocHKdB1o8/1jTuWrPVEvz?=
 =?us-ascii?Q?QezEyjjPpPz9UBHy1Vn8N0irwSLEC6HGkYrP4oeNaMiSFGULwWOPcd4pitl4?=
 =?us-ascii?Q?u/rha4l1Wrv5lBNNuPjayQed8DRp+g40+9t75Gbo8ozg/NYv91OwgKtOYAEY?=
 =?us-ascii?Q?/Rxxs7i01KD4PIzkhhgT2BL2hyxYfD4/212fmfhLIgTIOo8hmgVy9/MjKfej?=
 =?us-ascii?Q?o/9xAOfAEhMcvP6LUaH+zuWW1TjYhooGBWsAVOeCvt/3J7VnbfXJ1LY9Fqfl?=
 =?us-ascii?Q?F2BPhgXXcIhyHhHBRHRUM95MP+4HSRHgstXDbEIw5+qQUpffYPVmZ7GnwbW2?=
 =?us-ascii?Q?1f+Ox2G252NTNFLrTAZfPSV6WlA7IhFfHXnMKaoy3w0x9XiZZZ3GHc7/FYWc?=
 =?us-ascii?Q?+kgNWJ60gFCwS6VLefAAz4vgO1X9ozxMs/LSytWABx14KCvngCRtejqdq/g8?=
 =?us-ascii?Q?U11vtsJTyASEdgqKLxHdSkLylfXYsj1sBHMGSxdt3gDhpxmBN0/GQqA/LdGv?=
 =?us-ascii?Q?kw66BOmraN5lM+CpaJmQFUr/QVJoHgKqiXkzKKiPJeA1imE0C9LUB/iPRDdI?=
 =?us-ascii?Q?NnfhB6UM72nkQVMk0g6XdshTOkditl1iHR2U8zT2qK4i2l/o2vBAw+n+NpOv?=
 =?us-ascii?Q?yXW2qpWmd8om5rNxa7ry1Jfec7b71mC5j+FBBAIFzJjvdcY7oz7gz/j4O7M1?=
 =?us-ascii?Q?Q37kSy1N7xkmpqoCoISqhry7kn12Oxfi/o+xAMWjfk1SguUCe8IwUOdEQYOl?=
 =?us-ascii?Q?IQf+ZuxQ+VGNEOhbT3BMWOLmYv7i18pgONSNHn9CrDV/6wGb53ns4WvCmBlw?=
 =?us-ascii?Q?QibEYCDlJFDKDkSxsdY2rssuzoR21ybj9r9AsnPzRt2kXHRvvweMtjQxL8y9?=
 =?us-ascii?Q?TBp++OVvaf6lzSM9iN9CPZVBhZz3BtqdzGQqIIZtRx+ajboyrTt+YtRk/k3K?=
 =?us-ascii?Q?UaSjnf8d0rviluqh4w0wU9emoU0gf2pD1Hn17t3ozo196u8NqJBG7QuSz5ZR?=
 =?us-ascii?Q?0M9RuoI/tqAc3CnRK+s6JhGNscyrXRpQv4oAp2eaQJVwvRncdEHnPwuroRM1?=
 =?us-ascii?Q?O8rUNSe3J23bfwSZCUSBX/lDOVwxPTvnaYspEK8IYMKXy6q3kDTs0cEjdhNT?=
 =?us-ascii?Q?4fv+p2D+2c2ABMCcvAcsEcXFu3LLkKe41X/DIf7prV1Ys7zCxAjYw+JDqJs4?=
 =?us-ascii?Q?sFPwhvPhQD8/yHR5EQHrgxa9LCiplIUeyhRgKnN41JVCwOLr/HdrcYKbIwVp?=
 =?us-ascii?Q?vE9LXryJ3JzLPskPGN6T83etbsLtlvcR+eqog9XeR7LUgtLNrfC8bnTp3zQX?=
 =?us-ascii?Q?7ibBLJ0TX/y7t3s6cEBKj4phnge4t1pbRSg3pOqungElog=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3TI6/8VoUOtVVuY/mnZDTm78UEGRlOXiAVKoBAbImRwh4OholIEqsyl+EYvB?=
 =?us-ascii?Q?iznAa7QCChPA2li5w0LXfChYJ/XHozwECr0DuyLZ1/evuY5Byk893CWrJLqL?=
 =?us-ascii?Q?PGKoUuoCFhUP8pbQYFmwWHQSRmu/q5ynSTxVcZg1bgFDOwgytyP+WjEpYL82?=
 =?us-ascii?Q?+LNCmFdQ87QIGlo2IUoBk01jKfTT7wfmiXmJlR9KaEtxKhEOTSfz4I0X9Pfp?=
 =?us-ascii?Q?Lml/Zy9OG6x6xrHM8nuM+Yd2Jzf38ar/wXTEPUW3ZZkhrDWWqsj4uKU0c+ie?=
 =?us-ascii?Q?DlM141mkGkiCt3OIqI3b7DkvolL7t85+p0JWVr6zar8B2acladWkYz6Wm4za?=
 =?us-ascii?Q?bMi13Sv8tj0k8P+vNkhVOzj5GNvUabx68ABNjAA50SgkRao2ZvJi9j213+3V?=
 =?us-ascii?Q?igpmc/9pCG0ohfJC/+0fe81dat0Xu60gdB4VDd+npt5StM0jaQACvqpBm0K8?=
 =?us-ascii?Q?hrAywMVk+6gsTjOIszaCi+EAer2bwg9380qwHS6cRpUVVVSw8UZ3Z9PPqXes?=
 =?us-ascii?Q?T48X+yHTwX4FVw4b1P0pQzg9Jn0rmwRi+JjMkV0wwwDm/FisJoZyhSJqG7SO?=
 =?us-ascii?Q?cYvOhmcSkXWVmDxE6fRXgP2G69t9jh63jn8sX5no6ovb5sG4mGwZXH4IStJy?=
 =?us-ascii?Q?+TVIuuB240k+CEG1PqFyUnD6TXxSGl9RU+PLjbPrlQYRICcydNIAMipHdN5j?=
 =?us-ascii?Q?wOe8ICBIpc/qLGDOxY9Ac+cGahcvXyRC8LM9RGEQPUr2naCaD56qeCxtCE0a?=
 =?us-ascii?Q?PyUOUKpqUQ5Y6QIEY6PKgLcWsYGobVv42HolQYWdDt3scu6bk8ePQ7decDdq?=
 =?us-ascii?Q?ZmP2ioJMT4SgYuTW1v8w2Y/7Vdlh55k6f/8+23oSP6qizqr170GQMerv7Ono?=
 =?us-ascii?Q?L5t4iggF+7JnNFLSHaBvulLTbYe7oqmQtvAbKLoe3xno5kUUYB0LC38xxHKa?=
 =?us-ascii?Q?a0yU3am6+NyWyCHU+7km8641fvkSFzuhROsa+ds6JO2hRClbN2Up1JEd8/jf?=
 =?us-ascii?Q?x6wItEj7tcCNcfe/z/GKNtL3TU+lvQm7L2+DeZfYqm56xwy9rQgvAXL0DJBr?=
 =?us-ascii?Q?+wQsjiETKIMrUyabZOXT5xDHOXhDpJn8knnfXt9AnHtcWN0smcXkmgWI9ZvY?=
 =?us-ascii?Q?K4FelE2vSb+5GN3pXTjtlaQGlx+ikRqTkOXmGcW/rbXqOIvw3me9irZcOxpk?=
 =?us-ascii?Q?3XYqBzcJ6CzKwIJo7SOpq9F16Qp8aeVX3FQHopvkJQcnIwGXyNGRzo6Y7EOi?=
 =?us-ascii?Q?2TNxKcH/gQvZVol9BVGKUhFPHZS47hY9nsDrpIOshlaBRK6rqVwK0LLsBoLh?=
 =?us-ascii?Q?tkN9tZjvekQZ1BZz2QjlG1zCcTrSfyaRH4IVBQbBUtoXWGo20nR/w/HqzOQU?=
 =?us-ascii?Q?ewzDaKf/uX3WGs9TPzLoAxqpT0tItJe+YVvdmnVcg5HbaxqMy0rm/pgnOOGa?=
 =?us-ascii?Q?rSeS+p/V2PNSz5vyqVxq9OxrLZWW+pR/sKgmuAQ0oiyYdk78E8nCQWy45KxF?=
 =?us-ascii?Q?C8yZL4y1F1Vn8rU8SDr71GNEVdY24/xfUJ3uL086VNwjeVbyuyj4u0LbipBl?=
 =?us-ascii?Q?wBGjDfCNCw9dR7IjLE4Qh9g2sbNZmfmo9c6u7ZqrIMkPWpM+Bbifg+SFWviY?=
 =?us-ascii?Q?Qg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef19fb7-5472-4dc3-4b51-08dd1512876a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 09:52:28.3361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Mb50rnd380wr9iHQsQEyXthZEwOlRNE4Hm5FNKNyXgZk6jyA/GoKvr8oetHldfmg+tQNp0ovuZHibnJ1VRT9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10235

On Thu, Dec 05, 2024 at 12:43:35AM +0100, Przemek Kitszel wrote:
> On 12/4/24 18:12, Vladimir Oltean wrote:
> > On Tue, Dec 03, 2024 at 03:53:49PM -0800, Jacob Keller wrote:
> 
> Amazing stuff :), I really like the fact that you both keep striving for
> the best result, even way past the point of cut off of most other ;)

It's all Jake. I openly admit I would have given up and not followed
through with the review feedback to go to modpost and back.
Additionally, the __builtin_choose_expr() breakthrough was all his.

Jake's determination, perseverence, discipline and level of skill are
something to aspire to. It's safe to say that without him, this set
would have gotten nowhere.

> prior to the change CHECK_PACKED_FIELD() was called on values smaller
> than MAX_PACKED_FIELD_SIZE, compare with [j] above, now you call it also
> for the MAX one
(...)
> 
> off by one error? see above

Yes, indeed, thank you for pointing this out. Jake also replied a few
minutes prior to your message.

> PS. incremental diff in a single patch is harder to apply, but easier to
> review, comment both in a single reply == great idea

I'm interpreting this as a positive comment :) I got mixed feedback
about posting diffs in reply to patches, it seems to confuse b4 when
applying.

