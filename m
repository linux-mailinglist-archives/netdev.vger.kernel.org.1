Return-Path: <netdev+bounces-124038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4481496764D
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 13:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0E81F21897
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 11:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF6116B3B7;
	Sun,  1 Sep 2024 11:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qi5JYenb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CD61C36;
	Sun,  1 Sep 2024 11:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725191701; cv=fail; b=pbD4dTdz7X7q7RE5StIvF+Mip/Nj+1arDU1UqJi3ANLMDa/ujCi4sgOEAgZQ7YGrl6K5BUPkrpIlGZO670Y4Ie75RU67HuZ6s9wNHOF/A8Am32TDd46s16KpK0qwm2GrgzPYySZkVmsmNKXn9IJDN6EdAjZjDVReRmuWKXUeVjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725191701; c=relaxed/simple;
	bh=ZGM8/BWSFvxJB/aywcLItpmX8NWqNGXxpfmOYur7OzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o2QDMXwjbgNPj5HmZK0Tr2RmXSbeHtO5bzGj2kWNr0CXudsqyjWNTC0h7Pmen0JfmjbdTH04KxN2OuQcVpPWqH8CjVQkAHkJ8b/z+JkTn6LpObHQ+2bONa3RWrVX9jHc73hBgjZWv8wJROXY9GxyFyrc7zVYPS0FFqgLvw5+IJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qi5JYenb; arc=fail smtp.client-ip=40.107.100.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkHOvhqBPYCTg2O3Vu2bnTPdhtrgeiR/jM2mDniMaJv/rOBAgQSUgKwsnr5oRbBdWdin7Pnl+tbyJGlxHxxUIkjpdL6pw2RrFoVD+ajoxqIGzrEhncMbs1YSS+VC3erq+supVW2hU2wpdAoF3fE5wx/14Cn7tslFAiFAXjVLMIXQtSvaKO/KRHzobvbDszpZEeCVlLRXlXioCk9gDWRTxldLwcjCi8Us0vtxhfy1+bvObPUJMEjv9UznIoKHW7P1JxRol+Zz15PMn1okeKHbjnMpFhpUjBoDuGM2IJ9Jy7iBEDIBzNwPAzDkXlHLIKa9qdCa4n1dNtCAD0bhqB45fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qY2FvRq6dY+lNUnXvwvTKjCsOuljRU+nzfhLKnCDoA=;
 b=gkJvddxNYLlmphI9pslbEgFCXTTUa8o43nJcuPHTZXr51cw8o1AYoupPf1o+WxJJeLfWVa/MHgCPKL857zZ0I5x3E6frTJZ5NnQ4umu5IRPxnQ5ftLxSxs51H1rgRv9i50S7YZEvJAuPZKr9SbakzeqcdQyMbk2f1CmJR37IuxMRucGVjTJsp8P2nEfagaj2dwPlgfwUye4giS6K8cjvS9GZYZaX4DVfcXTiSEQYnB8rzmgY9YUp2Pt/1IJUO6NdiLtNNfC6QwbOX7Z4aMv/VKSL7Wo7FMmsh81N5LhnlxbLo467sQ+ZoysbqOlR3tsLVW6Lk0Gq3gok4GdJigmuBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qY2FvRq6dY+lNUnXvwvTKjCsOuljRU+nzfhLKnCDoA=;
 b=qi5JYenb+cillQCkSSu0L/z+RHEOimMK1z1whNXLjSQzKqWw09B/7E0ZZFbar/WfElid83Tf4gD01EYdlmhtZOO5MupLqDZhEwxuXovvsyHSA8vlh2CpDgTNTA0CjBHhQzcvt051r+CzNzavecN+WZSVXBxEH/NsbDdVpUvmeWkry+5Lmci87G10zToHuVT6ymWY+xr/3af5xSTesWHxgTsdJfh3oJ1VGZI/xBiYS2HkDzhImQV69IczCUlm/FoUUwTnpXUzZapZeCOnZ2Z57YvfUCWfUDIpm5K+pdutbVkApV6PywMp44njsUHKzZLwPCCeZUOyD4F6fRHebrnr9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN1PR12MB2574.namprd12.prod.outlook.com (2603:10b6:802:26::32)
 by DS0PR12MB7583.namprd12.prod.outlook.com (2603:10b6:8:13f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Sun, 1 Sep
 2024 11:54:53 +0000
Received: from SN1PR12MB2574.namprd12.prod.outlook.com
 ([fe80::4a2f:d03:c33b:448d]) by SN1PR12MB2574.namprd12.prod.outlook.com
 ([fe80::4a2f:d03:c33b:448d%3]) with mapi id 15.20.7918.019; Sun, 1 Sep 2024
 11:54:51 +0000
Date: Sun, 1 Sep 2024 14:54:40 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jonas Gorski <jonas.gorski@bisdn.de>, Roopa Prabhu <roopa@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Petr Machata <petrm@mellanox.com>,
	Ido Schimmel <idosch@mellanox.com>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bridge: allow users setting EXT_LEARN for user
 FDB entries
Message-ID: <ZtRWACsOAnha75Ef@shredder.mtl.com>
References: <20240830145356.102951-1-jonas.gorski@bisdn.de>
 <b0544c31-cf64-41c7-8118-a8b504a982d1@blackwall.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0544c31-cf64-41c7-8118-a8b504a982d1@blackwall.org>
X-ClientProxiedBy: LO2P265CA0061.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::25) To SN1PR12MB2574.namprd12.prod.outlook.com
 (2603:10b6:802:26::32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2574:EE_|DS0PR12MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: e4352cc6-1e60-48c9-e08f-08dcca7ce2e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J8ORkeoT4cV1/oxqn1RfgYWi2mdj2xJtOC2ps5Lzkf6nzGVKQPnn0Cbg7k/C?=
 =?us-ascii?Q?8FZtqAI6j6G9kBrng4poToI0JIBrLYP6taPH8VZjEsDoYqoAMhRZc4w2P6XH?=
 =?us-ascii?Q?+I7qFxiLU9g79qTVqSXGfhIRiHbeLaVXZPmPTJSHrYTkPOzCCbkGAR2UsWxU?=
 =?us-ascii?Q?wEGkdMDS0zIjux28KIaeCfuqwK2rHFsmeMcNSKjJkPkxT5KQYrUcPvpJd2Hp?=
 =?us-ascii?Q?Q9dY9lMmn+TLNYSiMdNg2RMcRXAEazHYhxw9wfnls2oH3w23CSIxqwjRBX+a?=
 =?us-ascii?Q?BCmugpkZ5q6d5tY0fm9vB9tfyTxuRjLiJb/eHmYf7o4vnvl+v/6Gob62WCRO?=
 =?us-ascii?Q?RVnErF7ah+4wSC97w5EpRnBJVO0hIVxKREt4SJnrJzgZ8BjDXCz+E7A+Zlr7?=
 =?us-ascii?Q?dK5W08gXiYzL8n4ZzPi77RmAgLkBhOn1PEMpYygMVZcZKiKH0Ze5KZHuK03o?=
 =?us-ascii?Q?nyO3bSmZl2IWNoB5utQmHRenBXHIkzmq57pO8u2Tg86KRHaDTd9e9p9YX1hO?=
 =?us-ascii?Q?2u2hPvaCqy1Y6/YcL2GPoXzYLeo4I+GMyStOawUo780xM/c0rgZATTRepqAW?=
 =?us-ascii?Q?KoYtS7qlaSHPkarsSjH7puyFCPjhnQ+v2Svm2me3t/VecKz0G5iCYzPfy0UF?=
 =?us-ascii?Q?azUecxakmOdf7CQwIA+REvUZcAnLCoXsgjdiAi+TtT8r65sAJvWtJklSjD3M?=
 =?us-ascii?Q?1wejx38Nrj0tcJUltwUMro+Ui2yc6V3GJzRHc337lgrzgoC3Xn03i4vCNera?=
 =?us-ascii?Q?OgcNrxlflY+jQRHUmY6VkeQL2QSNsu3lS8uNZSIG9aC71YcA7wTec3dgdZU5?=
 =?us-ascii?Q?pRALJ0xN/1QiP4VcOdF7bAYHzT5qBsTes0wU5a0iPJEbCDvWorQZY2dL1K6x?=
 =?us-ascii?Q?gHl3J6XpSC8zU7tBwIwd23cUWcg6yZIAgtsjKxkT+HJA5mXsVE85s8dBt892?=
 =?us-ascii?Q?qm9RJoyKWNbyXawrxpVvwSb7DbABj+xtGf4eglMT+b4CH/HjSWxAtglFQ5rY?=
 =?us-ascii?Q?fu6sXSzTG1qeB8iF8Bl4sj2r4FhWqT2UY/YTlXj/4Hzn/bPpC260ByPyON8h?=
 =?us-ascii?Q?9oFvM9wifFqaXD34aeLjzZUSNKBVwqQH81MokS8TEc9NZzV3/KLs4V9bUABQ?=
 =?us-ascii?Q?g28izYRHakqCFHTJalwJb9vJsbN/laS/K54KSFSra3LuOsQ8pzvGn820MHvG?=
 =?us-ascii?Q?n9Ra0eo+jNkwWvux4wMtEhaE3B9mgjGQANaj/MP3gALkyzch0uJeAGUBVY3d?=
 =?us-ascii?Q?tNG8PT38PbOB5xawDGD9ul2AM9aXjmbHVF21/xuFRQF7pXrjE7ZPuNbrwxHv?=
 =?us-ascii?Q?Xhn8IvtkP/zQaELt+N01puvJBIr94doTr1QwHIR/dayrPA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2574.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ARxqZPdS2xg/BLwrsI+lRC4XCm2A1rjXiXFXQB8zYB7H3N2w2ZDB92oisKLT?=
 =?us-ascii?Q?qcliCL4FpJejm25GirJM9RqnHF79AQeNZexZqhd1FOE4OkdEWgXNF7kmbT2Z?=
 =?us-ascii?Q?mO6vXa79e2gZdZKg2anhTLrm52v7H2kOOWgRPXnanxNCAdSkKfngsw3vXM8O?=
 =?us-ascii?Q?uNjh+Zwe1PYDHKDlUnDgOP8u4DbTe+4ofPOtkucTubfD3166UcMZvLvJ5Jml?=
 =?us-ascii?Q?Tfh60xzns2Dxfg1RPpThWGMXwK39aPXwtKzSdn9aLA8MoCK34uYR1ulVTBJ/?=
 =?us-ascii?Q?uYzPgxx4qeQNXlN0ALQ+u0EVxBZy+yivHOhpdnTZm62vAl/UINKXMW/L6XOx?=
 =?us-ascii?Q?8X0S+ZyDJfASddWu99dXMaNc2yQjuHMfmOGZZQ3pQy/bsZPIqkQ5ORfu8+dR?=
 =?us-ascii?Q?Jj310DrQ9UVZ2YfDcBvaWpsWGYJHpfsds3vifO02/SNmeqaqlMiL3o4HYWhq?=
 =?us-ascii?Q?v0Bju5hDGP70/k9okvyL7c0HJyGDqyfsW5TuKdFdnXqsgUwRUkvnI+aXQAsX?=
 =?us-ascii?Q?/knF/xLr8rofmfzsTJtzi88kLzB29SIk3XpqX1iOzOek0VbfJ2fCo4m07bLf?=
 =?us-ascii?Q?TMMDhUxhmJFqGVdpyMjgKXjJQZpRqjMNWu9/YSmQF499gzcnElSiz1HTZrNf?=
 =?us-ascii?Q?r0/Gh8sCrlDs2hYEy0AQ5HbZPOvudDumSFu4U8vZlUpXnnKqFr6ZsdOhlqXx?=
 =?us-ascii?Q?9yfXQ45Z6MPf3BuVYDFsTnufMh1mZGAf0pV8BK5A7iAMuqmkDX1UJ7TnKty5?=
 =?us-ascii?Q?alZksqOb6ap3/SIIdZDd7dOlKbUu/GDxweZoLzyT9EMCIwr7E/t7QVvDpTH6?=
 =?us-ascii?Q?JKYpwpH9hZR5LYl98G9exYiTPgR4LwSz1/7XlXY9x2tqsMyw7Lma7ByX/oTW?=
 =?us-ascii?Q?GO4n6KjFdjpwzrnQ4GIaNXmKPqPFCidqXIOkU1dd8MsiiP/Uk9s54Na3atV3?=
 =?us-ascii?Q?BHIMZxiF6UZHCcLKhcc7M3wbP5+zvr1aDrj1vYPumOfc/D9Y4VnodivSinC3?=
 =?us-ascii?Q?yaNqvM19IQVn5zwitx88owT8+jL0JGFjkM+hi2GaJuOZg2dBnHwWQcGsnUJO?=
 =?us-ascii?Q?8MEeP0GpQJd1EAIJS61bG4LtZwstqukxTC5+ZAK++CwqcIa/NUHJQbBzWOxZ?=
 =?us-ascii?Q?vSzjZTnx1xfMZT2y621Fuz/lMVXKs3z2yS5bxYMGHLg6qY6gd5TrIqrQtB+P?=
 =?us-ascii?Q?MlS/NyUtOB8cX9U5c/1pWsZ+qD/jmzELFewAUS+tmqqRDGrXyn+85PoyVotw?=
 =?us-ascii?Q?6gj3hO5V4gPwbLzma5CV1eM55lhswUZnybKfsVYbCp6KtRmKObC2oiING/lo?=
 =?us-ascii?Q?NBPrGM5t+e80bGqcINPTRlmZgFCK6RFcAFnR7/aabAn0CDowTIh/IQrDIY/e?=
 =?us-ascii?Q?fKPn5VS/LAw85YBjeOMR4kkcJPwAWdlSlGQGurYOvgFNsfDgXIF2RYHYOSHu?=
 =?us-ascii?Q?6PQYzXXNBPC0piuFdp+QYKHyLrQwmdkec1+PCKO5VYuWGNuZTmK7K/M+uiuB?=
 =?us-ascii?Q?QQ7UU0IxtLyuwylwUCm/7a2qkscDVOjED+bXBp7cNgoIjCBSMK+FIStN7rQC?=
 =?us-ascii?Q?IB+bCyso7Wn/jityb0X+dtH2EQlV3s+go5RIDUT1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4352cc6-1e60-48c9-e08f-08dcca7ce2e3
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2574.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 11:54:51.2419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3/TpuCeBQSv2G4yvlHxWzmG547l6FPBlP4nFeRoIpSeHDKBl1Uj3d4QS4K7TdKIrYxYnNiGH9XFTqKPL+uScg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7583

On Sat, Aug 31, 2024 at 11:31:50AM +0300, Nikolay Aleksandrov wrote:
> On 30/08/2024 17:53, Jonas Gorski wrote:
> > When userspace wants to take over a fdb entry by setting it as
> > EXTERN_LEARNED, we set both flags BR_FDB_ADDED_BY_EXT_LEARN and
> > BR_FDB_ADDED_BY_USER in br_fdb_external_learn_add().
> > 
> > If the bridge updates the entry later because its port changed, we clear
> > the BR_FDB_ADDED_BY_EXT_LEARN flag, but leave the BR_FDB_ADDED_BY_USER
> > flag set.
> > 
> > If userspace then wants to take over the entry again,
> > br_fdb_external_learn_add() sees that BR_FDB_ADDED_BY_USER and skips
> > setting the BR_FDB_ADDED_BY_EXT_LEARN flags, thus silently ignores the
> > update:
> > 
> >    if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
> >            /* Refresh entry */
> >            fdb->used = jiffies;
> >    } else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
> >            /* Take over SW learned entry */
> >            set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
> >            modified = true;
> >    }
> > 
> > Fix this by relaxing the condition for setting BR_FDB_ADDED_BY_EXT_LEARN
> > by also allowing it if swdev_notify is true, which it will only be for
> > user initiated updates.
> > 
> > Fixes: 710ae7287737 ("net: bridge: Mark FDB entries that were added by user as such")
> > Signed-off-by: Jonas Gorski <jonas.gorski@bisdn.de>
> > ---
> >  net/bridge/br_fdb.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> > index c77591e63841..c5d9ae13a6fb 100644
> > --- a/net/bridge/br_fdb.c
> > +++ b/net/bridge/br_fdb.c
> > @@ -1472,7 +1472,8 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
> >  		if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
> >  			/* Refresh entry */
> >  			fdb->used = jiffies;
> > -		} else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
> > +		} else if (swdev_notify ||
> > +			   !test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
> >  			/* Take over SW learned entry */
> >  			set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
> >  			modified = true;
> 
> This literally means if added_by_user || !added_by_user, so you can probably
> rewrite that whole block to be more straight-forward with test_and_set_bit -
> if it was already set then refresh, if it wasn't modified = true

Hi Nik,

You mean like this [1]?
I deleted the comment about "SW learned entry" since "extern_learn" flag
not being set does not necessarily mean the entry was learned by SW.

[1]
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index c77591e63841..ad7a42b505ef 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1469,12 +1469,10 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
                        modified = true;
                }
 
-               if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
+               if (test_and_set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
                        /* Refresh entry */
                        fdb->used = jiffies;
-               } else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
-                       /* Take over SW learned entry */
-                       set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
+               } else {
                        modified = true;
                }

