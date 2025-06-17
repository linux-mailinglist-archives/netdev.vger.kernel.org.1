Return-Path: <netdev+bounces-198657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA45ADCF6D
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2861B17BF07
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D67B2E266E;
	Tue, 17 Jun 2025 14:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QEuTh2aK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325252EF655
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169397; cv=fail; b=DCp+5H5lbsy+qn+RqPBJ0BNqbAtFCprtyHh/XAYbLNKd5Sr6Gyf3z05ig+F4ihk1OUAmMT+uP2ELsgn/P+Do/YEuNQ6KStDFiCbq4ohdIqIOpltcsxRM7gkSH3hqzzxuJSApP5rrzNf48Rh2q4KVhJfKDkZaiaKeS3umd6VOSU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169397; c=relaxed/simple;
	bh=Z+e9J9KpP+jjFh1HQ4Scm27f7Leus/+C8eXapZSN9TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NwHEPFkkf9X7/uR7ydvZNbuyNSeQ6f13XbSVHbBTFWDnRVSRTIP7Xjygdm70Bg35mTXb5HICeOig5vouvQxTu39qEcxnCWPAuQnldI8HtpU0wEZ0j4T7xjSuQC5V+6CPSlUVoHypjVIJh5lLa8+N/v4xUoKRENvQ8yCHyZxGkYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QEuTh2aK; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbMd4ORmza8J2qN2Yu5DDXRVyI4eJijLwr+tZw2l6drrGzrk5o7ZSRra2QzuKtaYDU3RC7cL853SAzd++ZxFJVpQnJrLsi4L6iYVZA45hahxGbkAu7BvJbnWrs6pPIp07sYJ2vby+iCLeaCYnDJMj4jDoro690t+AzqLhO+R3vMVOjWiixAfKcK6VMf7EXXKSLqK+bSzW+UC03n0RrE89aXKZql5X9ruEiHiheMsvw0ez8p1FOJUGS7d3vVyp50DQP8yuM5QmOOAhSgQNK+chcqgRAcM98V0rY2dOlC0apTkBn+TUemgMWnOSSvCaqN00c4ov3GR023VmdRKh+Lfzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LG4tV4p/2qVrb3Hdy7Cdt9oZVCL6tx+0Wg6WsQRJ/V4=;
 b=f8a+TxenHslfOXQKqyt7G0zSEfOz/P8w3zUmuTl9Nt0UX7avgYooNjBydPJGP2K4/0mOgSDh1jgl4rEkrEOFABBvXuOHys87i2jBXyYt1APjNCYuW78jONXyHvSeLaKB4fAyBykNoVtUaQF6bZmuvBmGBGKgX9eaUUMOaVSw2LAAKf8UvXjQEglaYIj3X8HrAQqLGUOgpB9IaxFyNK6v5MiQCx3Y/J2srRKhGUN55oG+y/GdtX0NgmhhwXkS2uAHBS7UysEQJxRDE4PA8miportjxiKjjmXsSPBXTIIhMsG2/D4Mcpmt3/DwODv+5FQhl99gf5j7JbkQibKMQ9/7Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LG4tV4p/2qVrb3Hdy7Cdt9oZVCL6tx+0Wg6WsQRJ/V4=;
 b=QEuTh2aKSuYpppYiuZZG04XubZQSVdEF0YN1WxnxZcZ5opDA6AdqZvCjnPfIkn1ekDSfjJrYhUlzZOBGiDa2VXS/r914pGurCpNiDOm5KavzrTsECSdWDc+QlFNIgiHmgFUPVuEe7VOyh1VenYeEhdrG86eJl66wE/ubxephQcOmYK43I4fxWMmYYUdqn1SF0OGm9Cm6HU596M5TG3LL8QqGeiQn0jXHxnr07MPzmjNPqWVvi2SMh+7CubKGzubutdVO5lFRXhaw0KXLQhMEmgnkP8SoT6lFoCqFq4z7ZbvxdWNks2rF5cRU2SpCDyy6qGqljL4mKvlkfapLx22dzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA1PR12MB8079.namprd12.prod.outlook.com (2603:10b6:208:3fb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 14:09:51 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%7]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 14:09:51 +0000
Date: Tue, 17 Jun 2025 17:09:38 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, horms@kernel.org,
	donald.hunter@gmail.com, petrm@nvidia.com, razor@blackwall.org
Subject: Re: [PATCH net-next 1/2] neighbor: Add NTF_EXT_VALIDATED flag for
 externally validated entries
Message-ID: <aFF3IkVNCPANpSM7@shredder>
References: <20250611141551.462569-1-idosch@nvidia.com>
 <20250611141551.462569-2-idosch@nvidia.com>
 <08c51b7a-0e6d-45b4-81a3-cb3062eb855d@iogearbox.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08c51b7a-0e6d-45b4-81a3-cb3062eb855d@iogearbox.net>
X-ClientProxiedBy: TL2P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::16) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA1PR12MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: 448380b8-d0f9-4d75-c8b7-08ddada8a01c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?opC5QBjyneMHM6Hd3UXAkWYTvxy1dMijDK8zVdo7AKMBAWYK3J06Cc3oJHIS?=
 =?us-ascii?Q?si07qilKmHj48MTvL09dUIlkf72fuBP/fQVRO0BirU5/QD8/q4p9TKIo+MKm?=
 =?us-ascii?Q?4x7YUb06mKv66RM859gdxtbK2rJ3Iz+fcniuPsiUlZEKMF+vD6B77oIcitN3?=
 =?us-ascii?Q?A2TDPTRLrAslAyG7AxyEXMfFxl7GKqr2+97I2XE4Ivyj12hJI6AlgVmwpr95?=
 =?us-ascii?Q?JQQtXqRm2xsHmnt3l7fDKspA/bkGNEqd0cqrhFXdvB7QyfPHI9oQiUwexPJH?=
 =?us-ascii?Q?geUGJqhjqhv+X3t84hLO1qtpOHWVRGzfKG51MCarAbgDjw7Ia7/f7xXmVlPJ?=
 =?us-ascii?Q?4xpQd71Z66SpCDsD/vVDx6QhPs0vVCZfAz/WOHm8y6aqF2galZQVgqgT1qL1?=
 =?us-ascii?Q?3HvXgbmkC4GcPrpxvjzykSNoiwqXF3afkcDYLWFUSbQrMXQQbkGopZOHJ10c?=
 =?us-ascii?Q?rBL2B5DNL9F3lq3eRKWgdOUGfk6+RHmqFVrSjzrQeKAv8EIWxQu76nIPw8KU?=
 =?us-ascii?Q?uuI4NR+D8hzpsVnlXGP9F7KO+UWTepSsUG2CZdQJatduoUyUBgFlRfuEFihl?=
 =?us-ascii?Q?2dnFbyAxySJ9iYsb35JMNFUdyJfl99+N7Vl94zIz5APv253m7pZSO6wPI41O?=
 =?us-ascii?Q?baR7/jmxCVn1d0TocU9l+XXRc/DytWDuMlPoVJQUb4vWNK1G2/JJB89GwZV9?=
 =?us-ascii?Q?7E12A0+ypWGQORhYOHYsiZmFD7GmMgWnmoYMVsjSoiORgy+UhfBDWQ4YXoM1?=
 =?us-ascii?Q?CGWEH8YLbPaMF2T/dR9ViuqdQiyp5Q47p6zqLTQaniz9yRUJuGw3vm7QuRdj?=
 =?us-ascii?Q?kMP03EKH5pnqv4ERXb3RS/poCmtUDpRnx8VPABgOh7bzr968uIYpePB/Pil8?=
 =?us-ascii?Q?G6QE1wMbvXn14PTYLY/ZOjZv7DA1QAlTrFVAtxXMPo1jjGyKJF7aG97dcGBZ?=
 =?us-ascii?Q?HXSqIMgOwvRiyPKrgYXjzO1ffCno2h8SLIo6VBHiCjfwNgaqNtEWvzbvATn8?=
 =?us-ascii?Q?uFuky2c1N23pnfhff6IdtCKSx/nLd/bXP5hsqUqIZQpaBzg1y1VDCr6859EB?=
 =?us-ascii?Q?gGPNrx6xqZN2KS9XUBYzxcT4HaorpmslTUfDLvd89Tj6vIx5QVoDYQETDwb2?=
 =?us-ascii?Q?7yRFwUMBs/1hKRZwMHifrLXnIbf6jJiKh+S8Sz3cqB2PjMBmPXZ1KsICdNEm?=
 =?us-ascii?Q?c22hL0JnksKmPP/01XJPcUB6XLJG0qutMQ32n9BTvuH2rGHAZcp9IL5wdBZs?=
 =?us-ascii?Q?kjNF8E1t0SFpFoBBO3AOm6SRUnRI6HlyTHYARkB4zoFnQifLoTLGUJo9p6nS?=
 =?us-ascii?Q?NGQKJJCEGLT/95ugXFVY2uF+Mss6L6qTyWYx2S5wbSN/UV5nA0b4FL2DDjFF?=
 =?us-ascii?Q?BAFCED85EglorSjeiP83OKjjGL1u2wgnKD44v5Zc7FfMsK2FzLqQOiKjDBBx?=
 =?us-ascii?Q?bI7jgsbK280=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+/AAI9lUoqeHd0ohQN/mlvhM+P7BIsuh2latEycJH6QVH1iOgmkMeIW/jhuQ?=
 =?us-ascii?Q?9YZ+8XD0P6mW4NuVcGO6TdSx93+NHkNpP0ay0xMJSf3tlOtkIxMeA2uS1v0A?=
 =?us-ascii?Q?o3Ja7BP5Ve9nvw4N7/jj4PJVrowBTYdqEsHVycpfswL5g6/62vBrCcedBvPN?=
 =?us-ascii?Q?krKVbQpNnHpJ6gpHCaJQHabemP6Y/3LeQ2WRdkhBCRZx930ui0pICToCUrkQ?=
 =?us-ascii?Q?SVh0zNNjjYOi2LJASnlVxPacw71naZzpHSx1iVJu3HEB9gMdxYSJNKtcUu02?=
 =?us-ascii?Q?4486mw2VsuAnuPRl1OSVCO1D1reSlutUrNpEiK6yXMIIeUt3b5IFvJ8sQ+wV?=
 =?us-ascii?Q?IzMk10IAPqEn64fk0CMm4NmfCMhY7soIkEbxAbv34KhThJB4imK9eqpEHbdP?=
 =?us-ascii?Q?b2EMmkBKmu/sD8+vp/1J4xNisNQipCBPJQ3QMPF0vK3WijiCaeXKgu+l5njc?=
 =?us-ascii?Q?N2PcHqlolLKpZZJkDrVwWKAvNMKNTEcQVDccVfWF5QF6t3BPJ+d5U4/u7sbJ?=
 =?us-ascii?Q?I5RTQv7hyhOWKCBHEmNThn5HTbvhTgBAV2MHNXvd/s9K8/oE5Kx8zaV367tq?=
 =?us-ascii?Q?e6mw7nhTHAmmpwgfv18AjdzDOKvC9lptYHUlcDHg/sfJGnViTVx1At26RQov?=
 =?us-ascii?Q?UOore8SFg4dZtcBZMFXIfr1Zu+rKUizNk0garOXs9SoXr+Nltryi7nf/6jMP?=
 =?us-ascii?Q?beJ8h0BqL5QqaLvY11miiPRpzXaFi+wtLLkjJ1ueYL7gawt49tehphHXrWvq?=
 =?us-ascii?Q?0fq5+HEOw2Bb0FHpDAZv1nINYB7MzZH0tNcPLmxPzl8KqmjFV8nKui9dRxlf?=
 =?us-ascii?Q?VidIRSK8giiT736Bkc+RMvA671VbiAwBTZudz9Fqx4xvoIzv7/8o/ht65W+t?=
 =?us-ascii?Q?eUBIWx4zXM7P5dHib0+K+k6WqsdykyhEnfnM5NcTQqf6erPT2l2wpGzKwpd6?=
 =?us-ascii?Q?Qvwd7gi2XBe02pIxFyDaWNzrfuSW5zMllmmajYXLpZm+ccyIV3kDobAZ8OZo?=
 =?us-ascii?Q?Apr7FHwIPsWaz0zcIDELsRBq+A1Cx+a3/V/FeyhL/4Uq1XleeiSm+fOfz/Ro?=
 =?us-ascii?Q?V1kDwmOegLUlcni8hRN58jBSzffPb+w7WgUTlLXlcP+7yAvXSFmNBGvI+BDl?=
 =?us-ascii?Q?g5YWAIZH9HSWl/WkgfD9GHUNxFrs73vUojnQX9wGmPLWA4FrwxXLkDSzZ88J?=
 =?us-ascii?Q?W9yfnNyRczYu6LIffyLHgHFAeX/zf/kEiFH/jzTE36e53MSFIr00Lxvf8SIE?=
 =?us-ascii?Q?AOOHqrc02imZG8Z71Dar3wvQHo9YfNEvEzcDMwBFxK80mzkb2fhTQ8phXuM8?=
 =?us-ascii?Q?qmd2GoVFql2wPTNgtgTjmS2umrguPykFFIPzRgt3CutedJOr3mthDYxMXtSU?=
 =?us-ascii?Q?6QwjIB/FDhLlIh/KcrbTr/ZEdUi7OAgj0tftIiR0SZPUhxk5FdZ25Ov5wyXs?=
 =?us-ascii?Q?XaAFnO7oNFP5Ir/krM8LRnymLjzYocrA6Olxr2lWIr6pPd36kI1c+e+A/lwe?=
 =?us-ascii?Q?lF52TzZ6M+lLoQ+c8pUSmGFwN2v6uE9d/ojwBgnB9WxS4uxks1h7p6H48+cX?=
 =?us-ascii?Q?uE90D4HHrfy7YJ0QLuQZ55cUUOEgojVpgSWsgHcu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 448380b8-d0f9-4d75-c8b7-08ddada8a01c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 14:09:51.0113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7XDOwE1x5FA0wsswXVPcPgpkjtYxN7ClGGZ8BaacT72yDAu2I5K5dfyP209ktvydjx/DINaVOdoer6Rri9dKOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8079

On Fri, Jun 13, 2025 at 10:23:26AM +0200, Daniel Borkmann wrote:
> Hi Ido,

Hi Daniel,

> On 6/11/25 4:15 PM, Ido Schimmel wrote:
> > In the above scheme, when the control plane (e.g., FRR) advertises a
> > neighbor entry with a proxy indication, it expects the corresponding
> > entry in the data plane (i.e., the kernel) to remain valid and not be
> > removed due to garbage collection. The control plane also expects the
> > kernel to notify it if the entry was learned locally (i.e., became
> > "reachable") so that it will remove the proxy indication from the EVPN
> > MAC/IP advertisement route. That is why these entries cannot be
> > programmed with dummy states such as "permanent" or "noarp".
> 
> Meaning, in contrast to "permanent" the initial user-provided lladdr
> can still be updated by the kernel if it learned that there was a
> migration, right?

Yes. In addition, user space will be notified when the kernel locally
learns the entry. FRR installs such entries as "stale" and a
notification will be emitted when they transition to "reachable".

> > Instead, add a new neighbor flag ("extern_valid") which indicates that
> > the entry was learned and determined to be valid externally and should
> > not be removed or invalidated by the kernel. The kernel can probe the
> > entry and notify user space when it becomes "reachable". However, if the
> > kernel does not receive a confirmation, have it return the entry to the
> > "stale" state instead of the "failed" state.
> > 
> > In other words, an entry marked with the "extern_valid" flag behaves
> > like any other dynamically learned entry other than the fact that the
> > kernel cannot remove or invalidate it.
> 
> How is the expected neigh_flush_dev() behavior? I presume in that case if
> the neigh entry is in use and was NUD_STALE then we go into NUD_NONE state
> right? (Asking as NUD_PERMANENT skips all that and whether that should be
> similar or not for NTF_EXT_VALIDATED?)

Currently, unlike "permanent" entries, such entries will be flushed when
the interface loses its carrier. Given the description of "[...] behaves
like any other dynamically learned entry other than the fact that the
kernel cannot remove or invalidate it" I think it makes sense to not
flush such entries when the carrier goes down.

Like "permanent" entries, such entries will be flushed when the
interface is put administratively down or when its MAC changes, both of
which are user initiated actions.

IOW, I will squash the following diff and add test cases.

 static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
-                           bool skip_perm)
+                           bool skip_perm_ext_valid)
 {
        struct hlist_head *dev_head;
        struct hlist_node *tmp;
@@ -378,7 +388,9 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
        dev_head = neigh_get_dev_table(dev, tbl->family);
 
        hlist_for_each_entry_safe(n, tmp, dev_head, dev_list) {
-               if (skip_perm && n->nud_state & NUD_PERMANENT)
+               if (skip_perm_ext_valid &&
+                   (n->nud_state & NUD_PERMANENT ||
+                    n->flags & NTF_EXT_VALIDATED))
                        continue;
 
                hlist_del_rcu(&n->hash);
@@ -419,10 +431,10 @@ void neigh_changeaddr(struct neigh_table *tbl, struct net_device *dev)
 EXPORT_SYMBOL(neigh_changeaddr);
 
 static int __neigh_ifdown(struct neigh_table *tbl, struct net_device *dev,
-                         bool skip_perm)
+                         bool skip_perm_ext_valid)
 {
        write_lock_bh(&tbl->lock);
-       neigh_flush_dev(tbl, dev, skip_perm);
+       neigh_flush_dev(tbl, dev, skip_perm_ext_valid);
        pneigh_ifdown_and_unlock(tbl, dev);
        pneigh_queue_purge(&tbl->proxy_queue, dev ? dev_net(dev) : NULL,
                           tbl->family);

