Return-Path: <netdev+bounces-124243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 951C9968A82
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F812839C5
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4703B1CB527;
	Mon,  2 Sep 2024 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jeNZFa4k"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C3A1CB526;
	Mon,  2 Sep 2024 14:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725289187; cv=fail; b=poIqq9gzRgYwIzCZfT7fqKdLybzF7+4AUCgq+K5Fyur3r6b6U242N1FO6HiCVDMyrmzs7uOWz6G8pxUjofPrnhVyZXc1aeDvCnBVPc/j3k3WJCd1JxX+7kh1BBV4bIRo0L/JkdXlQYQGM0LF+HCaJ7vfmQHyV+3fErdaIZD1a6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725289187; c=relaxed/simple;
	bh=jd/FU8WBihQobYWCk/Gn6xy52hxh1wQkhcMpd77ddV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PiHmCZelTHPJ3GV6rHUc689Jlh48eKJuZOCZ6j20aKSDAan1e0V9Sdf+wFu2YkS0PVJdHjOfm027wCovJrZnyW2TNGxPEtVi8i6ZFOOf2D++FH9N1MTP3amMEira5GFp5rlKKbRnkQ43P65wrmTUIlXCNi521RzoWZ+vO3OA/6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jeNZFa4k; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRmKITNlWzYJHbBq7CxWv45bDrSfhuYig2WWFOlH4u+NNUk8gZdlBEozS+cDBwUAXqmFuRfl4ZCc0XzhucifZBWzeh9AZbecTnGsQFtY+wD7rK48KukCzdh6v1B33Buqr8zex7bjYyAei7jxYyuAojUhHaX+vngFWhIzx0qtjbw0Q+PA/uvjkjElXkRn1ZyEb5N26mjhq0YGIRu9TAoZtBcHrHtb11/kuso839VMYwSX4AJrE1Ll9pGJde+QpzM2+qnZlxULvp9YANbodSiTM/DoU+qn3rRCNxOaXPE5P1WZTmoGw/I0oi0LD0I4emUDFTNd5PU7wZx3pMIGkpgQwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjySzouTXC00hr771/QdQCK5dSpEbcxPTrR0nG4vnXE=;
 b=lbEqPRgfW6Jx7mo+WygxNMDUMJoxxFMsS9DZlrMEEA1PlcbiZBiEfRiCD+Q9fvSuf6tom88/zMYSJamRNMLQ53d1Hl1G2R9IhC+0F8DyGtFavrl4k9jYWagcdaBAGOkse4YE3uXV6MVpXbkLd3oGVRgvWPTZK5uaWIfpIT0wLg9rUEl75zPSeD0pcaHeMbnuye+cUIOEUlsuRHhnklhoE2KKgP7+w8WYzGanGlvGj5mj9z9WYd5FP2JsmqO1laPnxJl1tX1jXfEAtoOhiqA3+ywMQnV3CzI/wQvYNfT7fEVDnKiDy9HRJvGSsHSaO5j/qy8hNC/gr3yyjgm6fSODHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjySzouTXC00hr771/QdQCK5dSpEbcxPTrR0nG4vnXE=;
 b=jeNZFa4kb3RJf9JXorDoNa8EYyuI2NX76hlEm/BY4IR5Jx7Nq+JWZD0Z2+PfXcpM1pFeAbN6EBC4jgdJFv4P4YZEhz3kQ23bYCQy5Zr7EQxthvV6AsXdRt5oY3o6GkrSGpndmGIlHs0OZHHCDV+D8+E+zhSueqlOEVcF9IDWpda4n+dr7rIPIFS0MAcQOeSJpb0cHDMn40W5adLeANiMS3r4z0OuP0iQFecVvAfBAZV2JWD1RXu0DGRTBZO/BiEqc8NTdIHOFhpAKgCeJmJ/gt5Zl8dT55U02ZHWGtjSxY5CXB/NfCHRD/t+jVvfo6cuwiPku9gJqFcmffGH6TyrMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN6PR12MB2719.namprd12.prod.outlook.com (2603:10b6:805:6c::12)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 14:59:42 +0000
Received: from SN6PR12MB2719.namprd12.prod.outlook.com
 ([fe80::1ab4:107a:ae30:2f95]) by SN6PR12MB2719.namprd12.prod.outlook.com
 ([fe80::1ab4:107a:ae30:2f95%7]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 14:59:41 +0000
Date: Mon, 2 Sep 2024 17:59:30 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jonas Gorski <jonas.gorski@bisdn.de>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Petr Machata <petrm@mellanox.com>,
	Ido Schimmel <idosch@mellanox.com>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bridge: allow users setting EXT_LEARN for user
 FDB entries
Message-ID: <ZtXS0lxzOSSq8AMb@shredder.mtl.com>
References: <20240830145356.102951-1-jonas.gorski@bisdn.de>
 <b0544c31-cf64-41c7-8118-a8b504a982d1@blackwall.org>
 <ZtRWACsOAnha75Ef@shredder.mtl.com>
 <003f02c3-33e0-4f02-8f24-82f7ed47db4c@blackwall.org>
 <CAJpXRYReCbrh0z3fmgKqycJHZ+Z8=+KnK+YpOrhD1UsmgfiSxg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJpXRYReCbrh0z3fmgKqycJHZ+Z8=+KnK+YpOrhD1UsmgfiSxg@mail.gmail.com>
X-ClientProxiedBy: FR0P281CA0235.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::20) To SN6PR12MB2719.namprd12.prod.outlook.com
 (2603:10b6:805:6c::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2719:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: a28ed50f-9d96-4812-7973-08dccb5fdfd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?16t/+sdQ6p+bakSAhgMmMIrg33bYbzEjSHv3U+14Aw3T2Zc1p8umw11gRdrM?=
 =?us-ascii?Q?WRBIbkFy73S9msVrKUzq244gvUJ+cvupT3vJrX2dvlBAX+RW3THdLitt9RqJ?=
 =?us-ascii?Q?hqC6F9mN9B/HBkQCy/c2k8TQIn8AXfZX8nDTUVaWBq7Oro4BtfYYpy4FZ/JP?=
 =?us-ascii?Q?/wVOPQbO4C+lcuLeGRC8El/JowlbFsPTetxngtDsXXlSV9FeRpBlaVwZjsZP?=
 =?us-ascii?Q?mXONMkdGeF0qcLaDpD6M98avzO+am52zHmOwTSbSQH6no8qV9SNWMeg+Y/6u?=
 =?us-ascii?Q?ydRMZmdxawtRRSS9QmCetktaL0AmbA9JEjNfGeqidDAACHcBaKKQ6VmLQNoO?=
 =?us-ascii?Q?R4Xa07L/xQ+9F/8SqmkfzhiOtshKdeOINHeyqTyOOlt4aNqAFQ8w5OlxOSqo?=
 =?us-ascii?Q?wFte+hO4N2PW3K4UO6lddrLwRqfb2ylGmckSnB6U7W8GPRll+ZkQaubUYr0B?=
 =?us-ascii?Q?isDvlDXCOTfQwPUsgVFnjxgzuheKwuAoCEj3i5diAlQ3kolT9x6AexJhQHPR?=
 =?us-ascii?Q?HC3iZwM8SusYGkn5S6g2MGKBHbHgJRbqSysfXMI8bs8n0EzHjtiiZvhEDJd9?=
 =?us-ascii?Q?e1Ra+baKjEgL3nVSWJlmKa83nThmICCI8GDwZZQNmsx44aWyS3vkesZqrnA7?=
 =?us-ascii?Q?hZGdp8Epfo7RYguBV2hWNIN0b+nNVzNzsgNfjRoHTG0irpzL8mRYBsaozJxk?=
 =?us-ascii?Q?iVPkDBoUC+aGA8qayKMgUqy5xwMUtnU3IaE8aBf1WCpVnkVWW/ujS3tyYJ0y?=
 =?us-ascii?Q?rsN5uQpfzZ3QvFMkib69MZ8NQesdDXVV1hk5DEo0hTk/azUsjUEYSujcKA+w?=
 =?us-ascii?Q?YYBgIG+Gy2XaaqpRaSoIepIx8El2Dzm3OX7OYbxaO3WKMxphyibfRW8Vuk7d?=
 =?us-ascii?Q?Urt9GeWnfinKwl95Iblg/qbKEywaXgq+2Arfrx7mVgX/95+C04v1+dfBFeIJ?=
 =?us-ascii?Q?MR3967rFK4ss7GJYZ0RpG5xocuckjaHAvC/PSvskhlXvhQvPgpzPDPZTXqQA?=
 =?us-ascii?Q?zS+ITfxx5POvAG6JYO3FGn8n/D6FTui0SR9YqTJmGrU1LI6JlBBf94dDGUmW?=
 =?us-ascii?Q?BSfzfVu7mih/kiOr8suIEW4PNB5qVsIjVrKLSubaaPaXtSF/rJZKkT25ax/e?=
 =?us-ascii?Q?4XWkWKbcFUOWfZxK6AVJC3CBMeCHuBhccekiBKRK0q09WAKobxHw9SYjMSo8?=
 =?us-ascii?Q?wUu8Rm511hDkm6Nlfh7LMin4lo4ZWPnE26IN09PPbLuyarm6itUXnQz1liP7?=
 =?us-ascii?Q?ETnd9D79ktzlneKi7DFG1A380YlB2ZWxw4BKH2a4dx9bd878xjMSykzb9OYk?=
 =?us-ascii?Q?xfIGx61/RUbuUalZP8vMCrNJNJXlzvUgdvvdrAd7fGu5hA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2719.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yh3r13hEr8PfkYVQ01mnd6Ky1AAPF2y91YUyTRWP8A4cwHKQ1kJXWiy5cg4b?=
 =?us-ascii?Q?vipFF9sWYjoSrlmOeoU+9TyZW1HcvCJ8f2iUcYxwaswW7Y+FsUJCCzs4ASeh?=
 =?us-ascii?Q?n5EZpqjQu9dE0ir2kO9bbSixcfMiS7X1r5VNdV6G8hstWY5nKc1EohyJBLue?=
 =?us-ascii?Q?zNq1hhjKRy6DbFa5OhfaMjdE9OGAR2tDIDnQYxuPWfEGdr1VKAKkXjd4txFA?=
 =?us-ascii?Q?nUbJOfYR0u2gD/82ZgjeP2+Y7XYcSWPNa+vlhG220ZpWY4TAiMtaMMkhJgOT?=
 =?us-ascii?Q?fldE2zFEzqzxpW4QE4DY5iiQBPhJ2YOfjTkQGSUz0SFKcsmYBd60vYcslC5b?=
 =?us-ascii?Q?A8shaw7NJn8iGQTXsBF4YphCthubXSyxH8HG5pcQGzrhU7gFupEmUQ5rBsup?=
 =?us-ascii?Q?fZOdAoUJ9oTpjAO/5yUpLixHTfA6SmUZe76I+Qyms0ddG5hRHbi/66RbnZDI?=
 =?us-ascii?Q?EwSDC+gQhf9KCFHXUP3OQX9FLP/VUVW0jF0p6QX5WZjJCXF/iycYvUbRvz+D?=
 =?us-ascii?Q?a1kWmkNi813ReRc3MrrlS4SV0y+3iIZ0LWHW3NnmkBz2m8mQiMDzOZuNT7jx?=
 =?us-ascii?Q?Vpf2cri7z+++ABk6rPBbcDIffzA90MoiB0Omc9WjxWo1J6rqQC+KyUH4IzJN?=
 =?us-ascii?Q?cXo1qfGv5eLATkem24ti83A3JhuNEGsLGxJJDZyWvR1hiFUlr/SVzRbh+tnw?=
 =?us-ascii?Q?uWvRIZpD56y0szkEgB6lLVlHej+IqblVfl4sJBHXV96gybmuag4oKLlVu+bB?=
 =?us-ascii?Q?oz4+z7iyRoBZMvREdyLvWDNQvSKnTTh2PumqjBlSFXJpGKVjILO5E5htZr8o?=
 =?us-ascii?Q?1IV4WaNZ0wJM3pNearzTmzwcvzJ/W2oj2gxixV6N2JFcSqi8kvA2ernUayxC?=
 =?us-ascii?Q?XcH+wKDlJM6T3RWrXRm1IEP0qaQTRVhh3QQXc8xB7hmIY2eYiZFKz+uXO3SS?=
 =?us-ascii?Q?9kT6xax2k/RmWfxOEiY8uX0z19RuDQFrrCER6/+FuAAW/0DwTZf68/TLTCYx?=
 =?us-ascii?Q?Vl2eyvrC8TPIYt1J7QTjGxdLnZm4n7VBBuFd08/wgxElzH0CjHfgvJuZmdfc?=
 =?us-ascii?Q?iDiMiOGeAG06ar37FHIs7f1OzD9ddr32Icq04E+GTjoEkr+BYnXEtXmhBb1D?=
 =?us-ascii?Q?0CFMbRprKlTTkIOgInbwcHcZjiV3bUTc6ThCFkwajcJan+4jnDjYnE9/DeTA?=
 =?us-ascii?Q?NZiWovy7kRxarH2VK3+xuotNrUSwVNfI37mQs0VtRautRA1Xm3nkyIoUOExA?=
 =?us-ascii?Q?Gaxw1yEkOTPaGErIkD307CjqbisPXrle2Q2Df8ZChebQUOOpCYfY+KwOM6Pt?=
 =?us-ascii?Q?6BwXWiVrtMSf3IervzybdptyiEq302o8uEvRqeEIjBB83QLOhcbUKsv2moJf?=
 =?us-ascii?Q?ejeR5bDACESEmKUFBjI2Bj6COmC6i0pxYLDnN8uA/WxtGL6JVOYub0ZbYHTK?=
 =?us-ascii?Q?GxR60lOaN1++wdUH16V081OhEU5myrCyfZiUP8K7e2YGuYNxbwbnkV1INy+D?=
 =?us-ascii?Q?M1bji8Ej7KIGEjo9/QwWp28yt8v2JJhuo3ODcR9akIIS7/H4O2YiqCJt194+?=
 =?us-ascii?Q?EQtR8mxp8cmK6owJxTmgSL2cXUXc7otWPLCQYVtK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a28ed50f-9d96-4812-7973-08dccb5fdfd1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2719.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 14:59:41.8331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sUbwgMwIT62F/5F7RShwAAHNvycFoqNPo0seMXbaeyDt8QsWMAsAVGwHqTElJdhwRQ6RKI6fTpiS2ocZsGNk0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954

On Mon, Sep 02, 2024 at 09:34:48AM +0200, Jonas Gorski wrote:
> Am So., 1. Sept. 2024 um 14:25 Uhr schrieb Nikolay Aleksandrov
> <razor@blackwall.org>:
> >
> > On 01/09/2024 14:54, Ido Schimmel wrote:
> > > On Sat, Aug 31, 2024 at 11:31:50AM +0300, Nikolay Aleksandrov wrote:
> > >> On 30/08/2024 17:53, Jonas Gorski wrote:
> > >>> When userspace wants to take over a fdb entry by setting it as
> > >>> EXTERN_LEARNED, we set both flags BR_FDB_ADDED_BY_EXT_LEARN and
> > >>> BR_FDB_ADDED_BY_USER in br_fdb_external_learn_add().
> > >>>
> > >>> If the bridge updates the entry later because its port changed, we clear
> > >>> the BR_FDB_ADDED_BY_EXT_LEARN flag, but leave the BR_FDB_ADDED_BY_USER
> > >>> flag set.
> > >>>
> > >>> If userspace then wants to take over the entry again,
> > >>> br_fdb_external_learn_add() sees that BR_FDB_ADDED_BY_USER and skips
> > >>> setting the BR_FDB_ADDED_BY_EXT_LEARN flags, thus silently ignores the
> > >>> update:
> > >>>
> > >>>    if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
> > >>>            /* Refresh entry */
> > >>>            fdb->used = jiffies;
> > >>>    } else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
> > >>>            /* Take over SW learned entry */
> > >>>            set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
> > >>>            modified = true;
> > >>>    }
> > >>>
> > >>> Fix this by relaxing the condition for setting BR_FDB_ADDED_BY_EXT_LEARN
> > >>> by also allowing it if swdev_notify is true, which it will only be for
> > >>> user initiated updates.
> > >>>
> > >>> Fixes: 710ae7287737 ("net: bridge: Mark FDB entries that were added by user as such")
> > >>> Signed-off-by: Jonas Gorski <jonas.gorski@bisdn.de>
> > >>> ---
> > >>>  net/bridge/br_fdb.c | 3 ++-
> > >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> > >>> index c77591e63841..c5d9ae13a6fb 100644
> > >>> --- a/net/bridge/br_fdb.c
> > >>> +++ b/net/bridge/br_fdb.c
> > >>> @@ -1472,7 +1472,8 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
> > >>>             if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
> > >>>                     /* Refresh entry */
> > >>>                     fdb->used = jiffies;
> > >>> -           } else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
> > >>> +           } else if (swdev_notify ||
> > >>> +                      !test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
> > >>>                     /* Take over SW learned entry */
> > >>>                     set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
> > >>>                     modified = true;
> > >>
> > >> This literally means if added_by_user || !added_by_user, so you can probably
> > >> rewrite that whole block to be more straight-forward with test_and_set_bit -
> > >> if it was already set then refresh, if it wasn't modified = true
> > >
> > > Hi Nik,
> > >
> > > You mean like this [1]?
> > > I deleted the comment about "SW learned entry" since "extern_learn" flag
> > > not being set does not necessarily mean the entry was learned by SW.
> > >
> > > [1]
> > > diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> > > index c77591e63841..ad7a42b505ef 100644
> > > --- a/net/bridge/br_fdb.c
> > > +++ b/net/bridge/br_fdb.c
> > > @@ -1469,12 +1469,10 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
> > >                         modified = true;
> > >                 }
> > >
> > > -               if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
> > > +               if (test_and_set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
> > >                         /* Refresh entry */
> > >                         fdb->used = jiffies;
> > > -               } else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
> > > -                       /* Take over SW learned entry */
> > > -                       set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
> > > +               } else {
> > >                         modified = true;
> > >                 }
> >
> > Yeah, that's exactly what I meant. Since the added_by_user condition becomes
> > redundant we can just drop it.
> 
> br_fdb_external_learn_add() is called from two places; once when
> userspace adds a EXT_LEARN flagged fdb entry (then swdev_nofity is
> set), and once when a switchdev driver reports it has learned an entry
> (then swdev_notify isn't).
> 
> AFAIU the previous condition was to prevent user fdb entries from
> being taken over by hardware / switchdev events, which this would now
> allow to happen. OTOH, the switchdev notifications are a statement of
> fact, and the kernel really has a say into whether the hardware should
> keep the entry learned, so not allowing entries to be marked as
> learned by hardware would also result in a disconnect between hardware
> and kernel.

The entries were already learned by the hardware and the kernel even
updated their destination in br_fdb_external_learn_add(), it is just
that it didn't set the EXT_LEARN flag on them, which seems like a
mistake.

> 
> My change was trying to accomodate for the former one, i.e. if the
> user bit is set, only the user may mark it as EXT_LEARN, but not any
> (switchdev) drivers.
> 
> I have no strong feelings about what I think is right, so if this is
> the wanted direction, I can send a V2 doing that.

I prefer v2 as it means that an entry that was learned by the hardware
will now be marked as such regardless if it was previously added by user
space or not

