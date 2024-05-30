Return-Path: <netdev+bounces-99486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E2D8D508B
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 19:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0314928581E
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 17:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61354206E;
	Thu, 30 May 2024 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PXz0+jfn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1B0405F7
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717088866; cv=fail; b=dV4Ta3OOZPqMr8/HQ3OuOOLwURD9J0t80t4gq+EGCSd30btfmUCA9eukbMrWGA46jA7Iv1TkANIod1gFaw/G0G9uOrcfgLS4uxVoZmPAUriNuqLy/iDg1tCC7OSQpH4VVquBtrT6zjeHiwMf1CbB0M9FX/uM6GQPYxjHdQn3MOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717088866; c=relaxed/simple;
	bh=czPsZfDDmz5BKCrEp26DIFKVkUrgH2TREwwdqqDe9q0=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=mG/nLRjzsZmusOoTaGY9R8EqXkJf68dwe2mTPA7VKiMxDliqiAAF64WKCIRk3nwu5+rZlNejJ6a/NbCxqtT5F5wnSf9DraZ54++rqZJwP2RBoyriPmRHbk6cK2sFRc6lruXJJ3GCb2oPSwdE8W2YRfRkGcnW4wXRFsyeN6lEwMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PXz0+jfn; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXFFah5f7VHFzBqPPp0lsbt5wUezH8tnP8q2r9i/JgAL6acVZdTseL1nGFu3UaVMHDf+NAQOz7uhvoH0MD+tBt26rWHxKdlRw0cZVPh/P4Xh98fk8dSn//AZ0IZY01RUxYx0EbBoSkXWvhMUu+RtLDJ10Ib+v2hgAD3z0SQ1h2owlXmGDadZme17j09qkwUnwop8kbxCIxJEukfTiHHJ4YTPmUckSdq15d5C2DVw2hocmj0GgjQyltB/r/dgYP7ARAElqhy7T1NFJPxvF1rlN8G13qZQc5jTsWv7fXD1xC+pnsaIXmk4KsbKltWzLDdlEBfwksczxna6ESKu/KKIig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87zjghNxmjKMe20FvpDnLJKXf9AIGeY0LBxFB6TqnNg=;
 b=AgBXqNWPcu7JTQcVn6dGgHNVcWieuv6n7nH5WLk9zvES2MxXA38cyM2XOo3VaQ0YuXVZ425YgpzZj7JOx01CHFK6umyUNpe5q+Zx2ri5nCp1oVneuXQtVzWLZmQMPKVEuf+spR2nIP5QFbD0/kOtXFIRW6wWLRmQUscEQ1KtdQhyDiOQatZxrFZmLFVddioSH9smGfNDekzREPm/k6cPiAU61G4onleoYxYvzZ5FQbpq1XPB81RmKs/p9MMLynj7h/v0VcMmqvLBT1vMtuO0SJ7InFRCTXaNCZ5CrZZ04TASxe/LQWOpDM3woFb7iJ7knMTc8Lu2I5E6prnmDlB8bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87zjghNxmjKMe20FvpDnLJKXf9AIGeY0LBxFB6TqnNg=;
 b=PXz0+jfns3wsMesmL+YTeP8/2i1wvtyfyY/mcavg2bqmOr/IzdQtcN2e34/0zF2Ctfl+vE25V3Nl5RuIMWmb5ibY1KU0gXmmv4KD/ZuRQtTQfTshkandPRSJefIjOKCTEvtSgNuQewUeZwDsjsRVLCWgz3Rp+lHelKn/hiedxgxTBNfcn98zx/S8BypbivAnx+82EnndnLmIk3XNWLdRq7rff8uXFdAQkgaqQIO2k+G0WOQwrPZ5l/gOt0BwKf1q2r555gWcj4DGCaZaq/gdlcuLkVroCe+LESBoP0KmELP8+RC2TPR/DXIV+xPGzss+mpj+9myCk0DSNeODNucXig==
Received: from SN7PR18CA0009.namprd18.prod.outlook.com (2603:10b6:806:f3::17)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.33; Thu, 30 May
 2024 17:07:42 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:f3:cafe::dc) by SN7PR18CA0009.outlook.office365.com
 (2603:10b6:806:f3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22 via Frontend
 Transport; Thu, 30 May 2024 17:07:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 17:07:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 30 May
 2024 10:07:28 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 30 May
 2024 10:07:24 -0700
References: <20240529111844.13330-1-petrm@nvidia.com>
 <878d1248-a710-4b02-b9c7-70937328c939@blackwall.org>
User-agent: mu4e 1.8.11; emacs 29.3
From: Petr Machata <petrm@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>, David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH net-next 0/4] Allow configuration of multipath hash seed
Date: Thu, 30 May 2024 17:25:43 +0200
In-Reply-To: <878d1248-a710-4b02-b9c7-70937328c939@blackwall.org>
Message-ID: <878qzr9qk6.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: aff1554c-efec-46d8-a36e-08dc80cb0472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jBtE3Dq0bePJgnv/IBhvQ0WNEK8nhNRC3HCKz6JMy2xJlV4fnPivmzR05hjs?=
 =?us-ascii?Q?kY/1PCBIhd5kZL7dZfT46GPLZdt4jo/IAfJ/vM5itlYxeAsI5mQS6hCkEElH?=
 =?us-ascii?Q?VUqPqH01Yu0s975N6rP8+SR29Mw0SRGD0mT7X/tZrIzUDs0qZ2kZxrVlsW14?=
 =?us-ascii?Q?hvEPaTG8Plb2RMN78kbSrIG3W/1IOfKlzRJf4xJb6yU9hSD9usNVmlYpyLT0?=
 =?us-ascii?Q?WxNAopkP21GM2rw58uVHU89khf6bjuu1C7Fdb6IItQgJApKHNjSt+5s4uv7J?=
 =?us-ascii?Q?C0cB5+z0SblPt7aIeSvmoAva0gYqTGb2Mwfb5tQ+YFPxq4dWvxI7RJYtr6y7?=
 =?us-ascii?Q?YO0E2sB2xR9xFJVEUiVv2Shn9WAFzvHt2c0cYnEk+ebZHEWGib8bpwKie94W?=
 =?us-ascii?Q?TYmQi8ew4hFpS4/TluLyKgiFl+kVOX3d5uBBj+N+RK6iTO4KS7FPunACX+ws?=
 =?us-ascii?Q?GN9QYY6BQ/TKHVrQariwc8C7ImWNkI3icFtPPmNPhDBoqbwhptLFS7+RCQmz?=
 =?us-ascii?Q?uFTtQ7ecQn+oNtfiRzNUV68lpsVNhn4MjK3qBArlx3wY7HqwMpMd1R7eQcMW?=
 =?us-ascii?Q?JGHieS4YDXItdWac3fL4QTdUBrRStbiyoO33BmVLKBFS/MNErqkqgIWp/BEl?=
 =?us-ascii?Q?SpqzLM/72nSIIx+HnsmLiSKK0yru3KiMC5kL3e318gXCcNiets8YpIgfM00F?=
 =?us-ascii?Q?zMf7vdzsJj5IqseJpA8Q7+zSD4uqnsDKHJcd/i9sC7E5BtbI4w06YLtFy+88?=
 =?us-ascii?Q?KTMD+zT6qqqjOdXlFyU9PuS0B7P7gz6U7D1zO+R3WdhIHSNtCMHP/jZw+JJi?=
 =?us-ascii?Q?2G+9LnVS3yQ0dm7KCtYEuf6AF2VF2W7XShhe0gRuwtzuccQvcYYiJF9waHB+?=
 =?us-ascii?Q?YZuM4SawdMmHzUqHWYzFVcmgdZM4FG59B7OieGfBoLHgheVRlTaw4AgGWCaY?=
 =?us-ascii?Q?YYsPif2M+SxTN+F79j0ZwUiLFERRHG7sStY0ZcbBQcBqzF/A+pmCGcNW9otb?=
 =?us-ascii?Q?H0zDW82RZk4cAa/DSiUggw51WbD4mWxoclcmhX8HKg5R0O3fpGxcLRnpLNNV?=
 =?us-ascii?Q?GTMjWik9E9u7KPw5m8bpiAolTNLlN2OJVLq3tA3xDP63675OSuvgebMTbgV1?=
 =?us-ascii?Q?Q0vrUcLKhJwJivV+48fvGPz+S1Dg9Yl0gkixwUhWC5CkznRk6ax/cvQCCE+N?=
 =?us-ascii?Q?8oQtOtqHgKa8t+p+edV/XTzJBpQh71bkcFcxTxsc8KvkYrzW+c1JOwbPtgni?=
 =?us-ascii?Q?zdCTqdFHF2PWODKhLqvu62pNmTSMKnKN2U5nOHVOCSP37yiOQ/qTVvLlXlQx?=
 =?us-ascii?Q?Zo0PlO8V2hZKHf+GkxsUReP6szDYTfkzNT9m2DHlKnkixXMZIZGu4+4aBHaa?=
 =?us-ascii?Q?EGtytyuYhpDxdYsdxljgKAAVWVsF?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 17:07:41.9543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aff1554c-efec-46d8-a36e-08dc80cb0472
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881


Nikolay Aleksandrov <razor@blackwall.org> writes:

> I think that using memory management for such simple task is an
> overkill. Would it be simpler to define 2 x 4 byte seed variables
> in netns_ipv4 (e.g. user_seed, mp_seed). One is set only by the
> user through the sysctl, which would also set mp_seed. Then you
> can use mp_seed in the fast-path to construct that siphash key.
> If the user_seed is set to 0 then you reset to some static init
> hash value that is generated on init_net's creation. The idea

Currently the flow dissector siphash key is initialized lazily so that
the pool of random bytes is full when the initialization is done:

    https://lore.kernel.org/all/20131023180527.GC2403@order.stressinduktion.org
    https://lore.kernel.org/all/20131023111219.GA31531@order.stressinduktion.org

I'm not sure how important that is -- the mailing does not really
discuss much in the way of rationale, and admits it's not critical. But
initializing the seed during net init would undo that. At the same time,
initializing it lazily would be a bit of a mess, as we would have to
possibly retroactively update mp_hash as well, which would be racy vs.
user_hash update unless locked. So dunno.

If you are OK with giving up on the siphash key "quality", I'm fine with
this.

Alternatively I can keep the dispatch in like it currently is. I.e.:

	if (user_seed) {
		sip_hash = construct(user_seed)
		return flow_hash_from_keys_seed(sip_hash)
	} else {
		return flow_hash_from_keys()
	}

I wanted to have the flow dispatcher hash init early as well, as it made
the code branch-free like you note below, but then Ido dug out that
there are $reasons for how it's currently done.

> is to avoid leaking that initial seed, to have the same seed
> for all netns (known behaviour), be able to recognize when a
> seed was set and if the user sets a seed then overwrite it for
> that ns, but to be able to reset it as well.
> Since 32 bits are enough I don't see why we should be using
> the flow hash seed, note that init_net's initialization already

No deep reason in using the dissector hash as far as I'm concerned.
I just didn't want to change things arbitrarily, so kept the current
behavior except where I needed it to change.

> uses get_random_bytes() for hashes. This seems like a simpler
> scheme that doesn't require memory management for a 32 bit seed.
> Also it has the benefit that it will remove the test when generating
> a hash because in the initial/non-user-set case we just have the
> initial seed in mp_seed which is used to generate the siphash key,
> i.e. we always use that internal seed for the hash, regardless if
> it was set by the user or it's the initial seed.
>
> That's just one suggestion, if you decide to use more memory you
> can keep the whole key in netns_ipv4 instead, the point is I don't
> think we need memory management for this value.

I kept the RCU stuff in because it makes it easy to precompute the
siphash key while allowing readers to access it lock-free. I could
inline it and guard with a seqlock instead, but that's a bit messier
code-wise. Or indeed construct in-situ, it's an atomic access plus like
four instructions or something like that.

