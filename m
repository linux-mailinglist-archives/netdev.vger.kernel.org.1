Return-Path: <netdev+bounces-139379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFFE9B1C5B
	for <lists+netdev@lfdr.de>; Sun, 27 Oct 2024 08:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A94BC1C20B0D
	for <lists+netdev@lfdr.de>; Sun, 27 Oct 2024 07:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B706B3A8CB;
	Sun, 27 Oct 2024 07:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c4vyg8K+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE9B2BAEF;
	Sun, 27 Oct 2024 07:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730014217; cv=fail; b=LYZQPi7EebXqMjOD9mF60TnSW7A/tog3OkQlcv6R+inIPu5a+/Dzonq90nzwComt3YGZK2y9uXvDzpjmiZRcoXG0vT6SiI1yUk+NLylNyWTY501//Y33cI1MQEVu2uaOhSFQ9QssilsPQxn1W1FXu6opU4pLLL11+Iw9eXE2YL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730014217; c=relaxed/simple;
	bh=Gf6N2Ussq1H2VWIMpmNbPtB2KxW1Hei4ttuorOsaY2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TWGQZL5l43sED1dkfeGoyk/ZmwVMbPjkMmxEUsSHk0Q3K8xUuVZyKO9hSkk39qt7W3xJCETif/2W8z2SQeMlM2+Pd6SFSBV+1k/RtaqKeOKYVgpO/aHfUcQqE/LhVsq7T5qGTV9lcMQYjJTlGxl+FHQxHJwErfnRyJNgt0e56u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c4vyg8K+; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9qzOUfjgwFWAZ6JzoPpU16KUl2Pa3hPmTYY5YNIOripJNN9V/qJtUIGdfOm3oHnrjwK5SgKC42ggMLgM/xIgswrLK79puKpFFkQJ/agAo4R91qmIVIq/a8NTCjN9RIYAf4D9i2FP96hhHaDm/HHaNFY8pAmtglt3GjSc914l9/NTktB9ypQhqiZyzy/esFdoDoZDC5/ZTz0QAvXRzQ11bozuFi9EdlQeojjG7WP72pCNp7Oujq6D0IqkBNrc8Wdvo6LthFXet3HwIj9CRtiDgoDbmOG1fAjVHGh2uEWOEA0BdI1SCi1QkcAHcHo36iy4ki0EtyqET033cJr932Ziw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ak6rSdbiehYtYQxmn5gGqu30ZxeQX2gCiyjmGpFtflo=;
 b=N7qcxeNqBM3o0AuZehkYWrJdw83g+xHOMab1dBpbEUwtt2htVO1ERVYZ9wyxpZb+NUEeOYEVdci1QQRrsIrxRJS6Z+Pcq4ARqd08VaAX/EIIet3i0VHKoJTp8k8d/LlNtE1tU9ommw8prWkB/9xtBVlgDdAA68ESTDacLrYZS+Cq0e4tXcKkgTBEsSAKmrEb+j8OEFN41hyJQY27RDSxbrAxcZNV4LIUwIKTMev5fJY2AfHOagx2KpF3busifaO7MOx02n/s4F7lkV5tCd6EhCAkufP0nimJhlVM+PQ1KKvKUopElHdw9Br74Lq4pSx+AA9IVYgFIsLg6+Do+vUE3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ak6rSdbiehYtYQxmn5gGqu30ZxeQX2gCiyjmGpFtflo=;
 b=c4vyg8K+yWmvTmgt8QqbMtS6WlNP0HzqMVYH8ueswtIlLOSA8lzK1d1hV0STsiTJbo0+S6n3aas+J1gqLDEMRlFr2xSLa68x3opVPvujhvh7W2fHAZkIkww9X/UcWXE8nWsylq4ZMxHGoP/cpHTJJ+onYGn+3dEBBb97IfFum26AFVddIONibq8mPmZo6lTNvnZxumRFbzlNj4AdXTDChJGE0aIA/LqyIOQuji+UK40oIFLEAGX5GO1paECdjWIwZFQ3TSdH2mkVq9hGDUAemT181sxH7PXUirqkZpFWLiJ0aAFnFg62LNXfwOIx1nO3NyvAyaxMbSwbMn9TUijFdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by MW6PR12MB7088.namprd12.prod.outlook.com (2603:10b6:303:238::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Sun, 27 Oct
 2024 07:29:55 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%3]) with mapi id 15.20.8093.018; Sun, 27 Oct 2024
 07:29:55 +0000
Date: Sun, 27 Oct 2024 09:29:44 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net-next 1/6] net: sched: propagate "skip_sw" flag to
 struct flow_cls_common_offload
Message-ID: <Zx3r6Al78WpARBe4@shredder.mtl.com>
References: <20241023135251.1752488-1-vladimir.oltean@nxp.com>
 <20241023135251.1752488-2-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023135251.1752488-2-vladimir.oltean@nxp.com>
X-ClientProxiedBy: LO4P123CA0500.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|MW6PR12MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: fc7ff9c9-711d-41cd-3038-08dcf6592745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hIB5j9Mzfjj/AmnoCkYRcnnQbFvMbSHuVb0rATvHK8aVarYpkOKAnIbw+OA/?=
 =?us-ascii?Q?J7HN595AvglRopnB7iQdhAwnQR58r+1yih8XY1hatUQA3X4t9yaiB+Vu7Q2d?=
 =?us-ascii?Q?z2IQKVBMZbxIYuJNDHWA9mH9iYPojhAFxXV22dJQ8u6bs16hK7Qui47NcztN?=
 =?us-ascii?Q?wJOePMz0gYfJFzVx95TiasTAZw6DKVNwKlhw7PQrPK5UeJhVl8pJq+3LPv0D?=
 =?us-ascii?Q?asFQaenbQuwlC14C/BUaLsCeNNl56qK7D6l1Z8quHdpBzSIx/qaU9DcP+zVJ?=
 =?us-ascii?Q?metef0MGmWXZrnjqZFn78YXPl5LvRGbGGZDAGpRcgfh8O0YyqsiOtwOLdrQV?=
 =?us-ascii?Q?E8hLDCtbnxir+ABqWzxgz6Q8y3UmmHBBCMcscewgC0ixJarfgZ+IVZntauc0?=
 =?us-ascii?Q?JeLnIezfJipIdeCkm8lgRGK6DeUP7Hi6UkmhPdS3H3hsiw3yTqowt9S3R3YX?=
 =?us-ascii?Q?D3hs66yJC9U+kSpOg5DsRQbIRYfWKw/PyMXimPtVHVIUhEidSseQJH0UeGZ/?=
 =?us-ascii?Q?/uE4VVaXKELoGstutCfNOyX3vJm378pQwEB/OoNqXCd41Uhq1e1wtyAoAAQg?=
 =?us-ascii?Q?LZmLoJ3Rpiq2P06E/7N8h4CxNfDDW7IXi1o2MsHBMQuWuFdRTLZBdEKyMRRJ?=
 =?us-ascii?Q?3bIxEwtAmT2cWTapAIWsCmhSiHYKh7Oi6MXiSTlJZDUIAFQxQPj9Yp4AL8+1?=
 =?us-ascii?Q?TNkrpCYxQUqM2IopHdKy/axJ1ngCf6VqmyjivLb1doywuj6gNp614LPSZNXw?=
 =?us-ascii?Q?P67okgg8NDFiziJ/Xonu0b36vuoklYpvP1IyVGO0n/dVtdogjqbMwnJ55MT9?=
 =?us-ascii?Q?TMiliu7TRXAqqmxN93u8H1LZeeRh0SOeq+KcndLc3cdpeauFvXmRhxn53o66?=
 =?us-ascii?Q?VcvPVVUqmNpc0di6+6gav+bNeSphQPozPYaDXrEY2koxi4BlPCGH2w1TjUkQ?=
 =?us-ascii?Q?CAAohDLShvjrz3nRqkq7MCptVX3T7Ty4C1y3FHhMv/cR6ANSf3hwKIhOQZJ0?=
 =?us-ascii?Q?iPq2y/gDe3Y7IOOkiY6WT/CR7lCN5v6NYVwcQn7fXTjCoRD5n87HZ2wKxXZs?=
 =?us-ascii?Q?x+avBQJVWcr8TUkxYNOq51j7nbCrLmJJjpy5XgHDR3ZmuVzZOIs6guU/pCoH?=
 =?us-ascii?Q?D1vYeNHtzTZ/28ZmkA4aZSuSjVt5P+1/2lWRO65QAZSyb1SDEbx6H0GHehjs?=
 =?us-ascii?Q?uthGlz1WucFWIEGd+M7NpgSsptiCeLfFMZ+nQPL9bA9iLQKelYi2prU4jVCb?=
 =?us-ascii?Q?SA5Bj4z3JF3aKf27Kh9psPkaWw3JETF0k5rtdSuDn/nSp8qsgE24p/pcDNy0?=
 =?us-ascii?Q?DrmDgUjgD6E28s0m9nt2mISs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jlJQg0CHVvZyOF4h+XEPls9zxs6VueGrXn7DNSAuO2ZIuo0Sz0j3c1B1NmB9?=
 =?us-ascii?Q?f7jbcwFHxKN459bnt90OvzTGOD9oQWu4Ut/1big31eKNC3G9gX6tvjwP8Vy+?=
 =?us-ascii?Q?ylt5a1CspGcCbf1FD9pHo39Xa18xr81VGIE1+v1kJ8hebXJF/CawseZWK5d/?=
 =?us-ascii?Q?NK42BPtFLQi0V/0NtM9cCdBwpeskls5kAHEHDq7r3s7of4X3+9/umtwq2wH2?=
 =?us-ascii?Q?xgKQk/NQXa7OV9Z8YTwfQb8rPQd887ftBCiKTx9WHYyLfTUCTC1OGsFQp0KF?=
 =?us-ascii?Q?A1tZfU9f2FufQCL9cyxSNFAedz3tvDxe/jhKO3SeTFnqapIfV9yYQ4y7h9gB?=
 =?us-ascii?Q?RSSBPACGCDmxDT2AB+GPZ3CPi0xJ7dsE3kl/kAPOY/akZAYqseOKCVH6oB9a?=
 =?us-ascii?Q?oSdQHXVMTRw+zfuxwNoJdSIzvLE2w4pSKY6LgnwY4fErkbDuDCPRkgnrqdV0?=
 =?us-ascii?Q?hAoUj+dKxlsIUcupa0GTtX4WWUW10OIOxMkbzD4pXHoc1ONqTHdOI+EhIqxC?=
 =?us-ascii?Q?6I7XtJailvZ7ken3k62czgkDGYybX4psWmSybBgL/6TM5z8wSrpxuS0jeNZn?=
 =?us-ascii?Q?OqGb6EOtJYHYiL7CxkyHGMaLxxF3R2v0MXMnfwtP3IfV0smhaqGyrrMZUQUd?=
 =?us-ascii?Q?Fj90TnogAaE5848NPWlmUcEVfEvw1wSrNKm+rnJoP0sYGfLE6MBPwlq2REGS?=
 =?us-ascii?Q?bS12ngoAiAyL/FzpC2pHYx9JT9eFVydTjdUd0qInCPcTwHN6cOsYOwK5c7r5?=
 =?us-ascii?Q?IdIjn7cdxs6udl2HxSz7HgKdpp2vd8XqwWK8tYfqmnLYN5/o+DNPPpqjAqya?=
 =?us-ascii?Q?5YRgh3UtfX1RxeTHWHK1VVXqb9gPG0Fbgnj3iEzsohdXBK67K6kTHf2NVq3V?=
 =?us-ascii?Q?I8N4a6GOEfpmXeriej4VZ0gUquUO4rcwSeL6CYgrPZ4zYqnhpNxkR8MCHSu5?=
 =?us-ascii?Q?M8VH9ceJY9tvzihfeLu65kwUO279Qm4Kqo51x5CQ3Ni7tr7X2tVbL1lmqB/D?=
 =?us-ascii?Q?5/4eZ0AZo3nJmKQwKjIWBBe632CFFc5QCVUGKkRddw+r0nKfyj7GgpZkvxQd?=
 =?us-ascii?Q?IlyF0PJooHda5atWPxjU5IJ6nJDM4utCz4wBPiuDrIdwTObf8UvrNoCWfMGH?=
 =?us-ascii?Q?+0Om5EYGwDgRbpVKvP93nxSZqovFgjZdKM5EI7IMYEtySEvov9H4iy5rr4Wk?=
 =?us-ascii?Q?/pYuz5/VwnxUGeztMd00aCX97/Pi+pmAXTBujgUyAToyH84VRQsqYeNR/UWN?=
 =?us-ascii?Q?rAF7cvNCgLhOwDhC6SJjpPRDNYvOMhJ5NfyNG4tzFwflcDfPCfyBh/im9+Pe?=
 =?us-ascii?Q?V4wV+t5nPXRJYH7SAIozq9NOf/92e8YteklrxbYZ4djmCUpE1IzWYR+G6GOr?=
 =?us-ascii?Q?oBXYRyVAiLBmnW3p7htFzRxlnRKCEFhVe7rb8NJ3lQoccwZDMoGYpjW4UVxQ?=
 =?us-ascii?Q?Mf9g5nTVCOg74DAmPiwltKCETSe+65krV9wSHqxmbTe2iuf9/XX0Ydg/JUUw?=
 =?us-ascii?Q?e+aPtLJ9/chqV5b7H99UrDccgx4vvq/3mcJDHuXNS2ZqonPVHG0VuCTJUJgJ?=
 =?us-ascii?Q?aMpkV29omSWWfvT2E5G/zpEWr80J3HECQ5A3P87t?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7ff9c9-711d-41cd-3038-08dcf6592745
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2024 07:29:55.2278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C32qU2n4ItBAR0d3tgVPeyRbBBl7imqbjppedBsZn6EZXIXKzjEapFv/Gja6L05XKMxWDJbIxZEy6TwByn9ajw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7088

On Wed, Oct 23, 2024 at 04:52:46PM +0300, Vladimir Oltean wrote:
> Background: switchdev ports offload the Linux bridge, and most of the
> packets they handle will never see the CPU. The ports between which
> there exists no hardware data path are considered 'foreign' to switchdev.
> These can either be normal physical NICs without switchdev offload, or
> incompatible switchdev ports, or virtual interfaces like veth/dummy/etc.
> 
> In some cases, an offloaded filter can only do half the work, and the
> rest must be handled by software. Redirecting/mirroring from the ingress
> of a switchdev port towards a foreign interface is one example of
> combined hardware/software data path. The most that the switchdev port
> can do is to extract the matching packets from its offloaded data path
> and send them to the CPU. From there on, the software filter runs
> (a second time, after the first run in hardware) on the packet and
> performs the mirred action.
> 
> It makes sense for switchdev drivers which allow this kind of "half
> offloading" to sense the "skip_sw" flag of the filter/action pair, and
> deny attempts from the user to install a filter that does not run in
> software, because that simply won't work.
> 
> In fact, a mirred action on a switchdev port towards a dummy interface
> appears to be a valid way of (selectively) monitoring offloaded traffic
> that flows through it. IFF_PROMISC was also discussed years ago, but
> (despite initial disagreement) there seems to be consensus that this
> flag should not affect the destination taken by packets, but merely
> whether or not the NIC discards packets with unknown MAC DA for local
> processing.
> 
> [1] https://lore.kernel.org/netdev/20190830092637.7f83d162@ceranb/
> [2] https://lore.kernel.org/netdev/20191002233750.13566-1-olteanv@gmail.com/
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Link: https://lore.kernel.org/netdev/ZxUo0Dc0M5Y6l9qF@shredder.mtl.com/
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

