Return-Path: <netdev+bounces-151365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED879EE69E
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 13:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2193282C5D
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 12:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857FD213223;
	Thu, 12 Dec 2024 12:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RQWbNaVw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0419212FBC;
	Thu, 12 Dec 2024 12:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734006358; cv=fail; b=SrQmMxRhOnbPOTU5DC6CIyJMs9MTu8WykZ3HQOJ0vpym3az2l2UOwgeFblvmxIUFdokg+vxARoOL9cLK2TGIbpVSWA/IhlJoDPXtgTAxYHhXxay2NhDXdC5dIquWKuV9vCU/u2w1S7497OUGpQOB4MgxAFKx0JUx9x3zfbxFtuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734006358; c=relaxed/simple;
	bh=c7IzWoFhFjPrSPpNpRT7CWoxio+fCbIuLbqiji8BE4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M5ESbEd2L3xN4B8Lgr/xVlcDSrgwJ6rzFTTp9wqGMTYkUgWIfvGYmq4BYCSHaYAxrnvuyzAeX1XrsHXzlMne1I9kttZvZJRfWt+FChd3f+efvbHRmw7RsA08ggvUA38SnTziJPvqXB+uU+1tDmfqcdy8pTd0R0n03W84Mf6+Jho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RQWbNaVw reason="signature verification failed"; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4M8rRMQ6JUwHG29y7ZUn59kSplEE9oZwgBHCVGE2NmqbuaVkDupB+PJbdR++LIaB0EcF/U9g3zP+vABueOFAorR9FxXDAve94zlByZldW/D9Y8vF9r81JRKJ0TfpznYST7UPMAxT6qxrchXWBB2tDuMqVM5MnBlt57I8FoMoeXyeYoozzCi2xjvxlXLyWMpKS5hxIk2cdm96SeN5zT4t0pHcEJVP8uw0cGluiqCqvqn2CdVO9k4R72it/z1ajTnW8E0gYNXC0JBYcUe6Hcmh05VgCWPHrhbSA414LZzaZV0z33gADKoWjHimjx8M9735syrTRt4rOtZoTB5qrZZmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nc9eeSUX+ry8w+PAVWydnasL/Zg2h0QqkCLAht+Cxv4=;
 b=e72agvjHTAxRezRnA1GnvYKdnLfyVu88vTwVcyrF3TeJg+J2dH+Kfx/inom0RfaayX2pxbFv35eyK/nWYPlOO0ntmbB8DXAtuXazxAnDm9KzGCgp8dtR6c1aVF5nfdSG3TvSaAh4CQOWE610KjO7gIWZqo8A0i1YSMUkNE+iQOMRtIXklBSfRaOZGy9o9ktVNa1nWfB+FMvnrjApTcW9FNXFI/sw2lzynTtw5+KMpLlkKGmcSR8paOrAAn0pJ2QV4q28oa2laV0JxZGJ3H5lckdQ6NiZ2smTkBE4yZrfvxETtT7VBVxRKpxpfEy3G5r81b9HOdWyZdFmDHX1d9W6aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nc9eeSUX+ry8w+PAVWydnasL/Zg2h0QqkCLAht+Cxv4=;
 b=RQWbNaVwHOV02VePz8Rd3+AbVLjcwkHAJcBqsxE0rzq/8qL3dEZ6azAyRUKPSj/HpKAS7twHdV/nbNdaAROG5yGPKv0iVBX/AGvDBzoEzOYVKd8VdqKX0YIMZaRNqjjaEI7yvZ6mcRvY8kLjw4tjSKy09cCXU5fy6dYGjbEx7kzSduGFr39pOPkRuWXIZRedRPOUDMrKm1HJoikldxNn1PQ8XdE34GoRO1j2QIs8r/pUL3pykFSmb0wFPg613/qV06FYFb2dAF3wP4LOTn6jeEoDJVnOCeLO+8mOvoLA002mv/ekw5VG0DBP40JWW7p4teHS3uv9xHJeCjl1WDO2Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SN7PR12MB6715.namprd12.prod.outlook.com (2603:10b6:806:271::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 12:25:52 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%4]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 12:25:52 +0000
Date: Thu, 12 Dec 2024 14:25:42 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Jonas Gorski <jonas.gorski@bisdn.de>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hans Schultz <schultz.hans@gmail.com>,
	"Hans J. Schultz" <netdev@kapio-technology.com>,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] net: bridge: handle ports in locked mode for ll
 learning
Message-ID: <Z1rWRorUo7ivWJdO@shredder>
References: <20241210140654.108998-1-jonas.gorski@bisdn.de>
 <20241210143438.sw4bytcsk46cwqlf@skbuf>
 <CAJpXRYTGbrM1rK8WVkLERf5B_zdt20Zf+MB67O5M0BT0iJ+piw@mail.gmail.com>
 <20241210145524.nnj43m23qe5sbski@skbuf>
 <CAJpXRYS3Wbug0CADi_fnaLXdZng1LSicXRTxci3mwQjZmejsdQ@mail.gmail.com>
 <Z1lQblzlqCZ-3lHM@shredder>
 <CAJpXRYRsJB1JC+6F8TA-0pYPpqTja5xqmDZzSM06PSudxVVZ6A@mail.gmail.com>
 <Z1mmnIPjYCyBWYLG@shredder>
 <fb085904-e1c2-4bbf-b826-b6ba67d283b5@bisdn.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb085904-e1c2-4bbf-b826-b6ba67d283b5@bisdn.de>
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SN7PR12MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: 7da1be0d-2921-4fc5-d008-08dd1aa81e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?CGJQsrs6ZW8FXbGXKaCWpiX0tMMM/bn5j2HxUQ8wNwMgCpUU3jBKJ40lv7?=
 =?iso-8859-1?Q?NElmZnB8AwgZXTc7SKHXbJqeAUtOKvf+i28tuXIvNcIL7kHPaHZnbLAHGG?=
 =?iso-8859-1?Q?16GoWFHXtO6bZT59aSQYYa9xQ8+lk+o/zitDEfhFA5Hgx9XCtC9KGECX6w?=
 =?iso-8859-1?Q?rQpHgGgnXEu/VlclAWAMKwnkCbga5EJCsG2A9YDSx9rkJA04kEnkPeCeJS?=
 =?iso-8859-1?Q?HKkHFJnqV8FJFhdRzBM/Md0oXTFp43GRCbBHOAOpevXKDz8P2y6q/9yFx2?=
 =?iso-8859-1?Q?4UO972yjfoteR89pU23nN1L20VdiLgr/eOabKnr/ig9TtF5LSHSXo4gXpr?=
 =?iso-8859-1?Q?RmaKA43oBOsm3RgsK2CWmEcy1gjLlQvQNF5uKrkGVFJmpGMk3y7uyu008p?=
 =?iso-8859-1?Q?hhYsmDGW+SuiTnxQGtNnEXTa0QaQTuMjfuBo/hHeyvO0sQJlfQtglHoMnm?=
 =?iso-8859-1?Q?i+Pswxsc3I49ybICIEjxGrT67QZFrl13XtkEx7d1yYOQ72tQnolqoXzLJm?=
 =?iso-8859-1?Q?tQkAD9ybcMvWh+5B5G2tztvEFQ5mTcBeTCq2fDUFSCnDY43TkMQGvYnYTF?=
 =?iso-8859-1?Q?HJkzheoyKcFruw4tZy9IKPA14wkgxQ1qjgbyFdjxJqnSJ5uUih39KvXPt+?=
 =?iso-8859-1?Q?pA1PwUM/CQJB07jrlk0JuLltB6VTHykxo+FZRbsWjW8aGTY1xL9ixFlq2L?=
 =?iso-8859-1?Q?r+tM4swcyB//n8aSS5+d2PrvGYQg96Nie8Qu/ImitjvUrWEL34wmnpOpdi?=
 =?iso-8859-1?Q?v5Gnhmjj+5vBeitp72fOO6Cf4Y373KrQYw2l2ndHYJeLdypb1mlg1rDapF?=
 =?iso-8859-1?Q?fMGrPanuCPXyD/taK/12T7TUPy1grg+FaHmOGVCocAJjSlRTo2162YH+YD?=
 =?iso-8859-1?Q?oZRqOTHH4yHVRgVfUHXAzQ5OdFs8YmNIk/BfPmLqJsEiYKR2rvlpYjoHGo?=
 =?iso-8859-1?Q?zhuudPaP1k60HrWYHMfSy02ITcmO0u3iE370QL7OaYLF+QLCT+DQr1Cq1s?=
 =?iso-8859-1?Q?iZuXZB93n6mecieUD64/qnEMjfX6g0vCAIcnLUfb1E9Xc0eN446UKgTEsk?=
 =?iso-8859-1?Q?2nqlt/uWAMc7ErQW4Mq8DueG0lLHRhdDjmOPs61T4NAhv/usQor9EMUmEv?=
 =?iso-8859-1?Q?LcVi0X5+8dR3MW4B/Yx980yyzdfOVFDX0PC7zN2lijsWeCJof19uerpxvX?=
 =?iso-8859-1?Q?lbME3bXLRrdXatuqnRI91QPSHbG9tMZj5DDBZ6Q/1MN/pxNIYXnTF974Uw?=
 =?iso-8859-1?Q?SVjQ9d0slNiYiqfPHlgvn361IxnQEbeA42MKyGjM4d8lD9muZpbObUzXeF?=
 =?iso-8859-1?Q?E2mXclWe7Yo+5HyG1eKYjdb30hv1NtOOll4is6L5zcMA5dENU6v/hdYx34?=
 =?iso-8859-1?Q?ErozpWIniZcezAzVVjlA8WWNPxAyQA8A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?AN1RcK6zreCr/1Fb/+Cr8fLW+TdRfYbgk01xsnjXfCM5aYrxyTnR370yuP?=
 =?iso-8859-1?Q?FqBbZd/G6aYJB9J+sbf1gr1efTPWSQuGudOK9ukxqhFlZh+PnELjTAht8P?=
 =?iso-8859-1?Q?JYJmp3r8cnJTyOPzTN7yOIXQLVRA1CY1xFoYzvMK2KuIajoV8WAUbTXaH0?=
 =?iso-8859-1?Q?/jYXJUNiz8gLppfBjYQarvoVc5nyOWpmZAmBNoxXEJWlgg7ok627V4Yyvv?=
 =?iso-8859-1?Q?MNs2DDQGAJpYxaUggnVgTwJ/5AxX848SwBmHZdE/+2ldyPhhpn0Pkot8Ta?=
 =?iso-8859-1?Q?naUKBbsKS8M8i0/syVn5Wl6WhVvMtVYNGIw21yjjUCrIsWDJQjPXvOPNBG?=
 =?iso-8859-1?Q?NjEph8caW27rK4+cCQc5rt5R/iF9VunkvqSecFU+Fh4YJKoWQnhdtntDUk?=
 =?iso-8859-1?Q?9NQLIPKkq5ABNnXDjLqq8RfEZtYwodrdB5lclepBoypEIW/BfFToTD71Zl?=
 =?iso-8859-1?Q?S8mk2KJTWd/nxfFK4ostWnjWVev4JtRW+kAI/MghOyFsGv+CuvDLr7KthR?=
 =?iso-8859-1?Q?GtiisS7y5sLYMDWgvsZP/PPnV7MZ+km3lV3ZPP9eGgo/DvkMmMK0MvLwdu?=
 =?iso-8859-1?Q?1N1So4afwx4WQDxhyeRqWLVEk5CQ/4cxB5E3bkrU1puWFy32N6pHqcWEgq?=
 =?iso-8859-1?Q?ObJBxQD1FL2l5HSZwHwOhQUEe4TO7j72TGGS2UvMxFDBBRxuwIbG1jl46p?=
 =?iso-8859-1?Q?zmxeM0XNIguHm15SESI0G4FxX+6Wlz9YATj0loIpYUe82sP5yHqzZSb8L6?=
 =?iso-8859-1?Q?mssbAac81sPexeiwd3EmXC0IdznxrWwDx6QB7C0QKNnkdiIRL/pTCJO1/z?=
 =?iso-8859-1?Q?bvCSpGO5U2eatyB2XOiYhv/JWpX+831yWJ5X/k+fR/DGqN3F4cK01Hzfox?=
 =?iso-8859-1?Q?KLRFuAPpmNAxEYBD/oaigyx/55BiQSPYO/gAaPA89lk2ewUCQ4MwoS0XIg?=
 =?iso-8859-1?Q?wNIRbCmunf4zo0OVuFswgamJgMZTaI6fol+tJG8Qr/WJhrg6cq50kaU0ui?=
 =?iso-8859-1?Q?zpYw5BduU/KCswfE6HGkaoQl8RVwkrqPMxKK10HLRMWfggQaEYuHcJ62mP?=
 =?iso-8859-1?Q?A6Fh3ACpvBKKaHXEDgTHkgZLeM041ED9mrrQ+xCwiXPujeRc/HhrxqfQXo?=
 =?iso-8859-1?Q?f6U38x0ImUqKjbkqOtBS49QgYUv1oMFhCKkxSclxco4uNhuBSuFxb9E0Gr?=
 =?iso-8859-1?Q?PXwa389N6TWaenn4ysvpfuDkIWKVVBnJdC0CGEkaqfvKpACZor+4uPKG+o?=
 =?iso-8859-1?Q?vxKr0LsDb5pvSOqmp1XkgjoJM+RwGlYLTy8/E0QoZqn309mdhuUpLT9jde?=
 =?iso-8859-1?Q?xcsAxiZUk9Q55Spdx1XCNoifgK3H/N8lceg3tn2bgoyKTHVQ53wkk23HfF?=
 =?iso-8859-1?Q?L4R5t7mA7TF/8t5NjwycWAk0pJdRGMf7a6uk29zjBuyJV06yOkgA2Hdeo5?=
 =?iso-8859-1?Q?X+ZsV3O8CvulpL/pJxs5ChUX+racwVgahv8fw7tmag8PbMf/OmMxkKp4Ht?=
 =?iso-8859-1?Q?3YIPdIZqv6qYOvdnvxmP3ImDEPvWod1TbeJngNqZeTFTV17DXMFBXtoQaF?=
 =?iso-8859-1?Q?AIlKJBQSIT+FxaDCCwCA5NNaHazidCVT/5F2nseux34XhnZftPn6Emu2gt?=
 =?iso-8859-1?Q?isN/ETHvpKAVJ/kRTcZEuIx81jo650DXdP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da1be0d-2921-4fc5-d008-08dd1aa81e79
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 12:25:52.7468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27PkTg1KDIdZKtBn4OlxA40s7jF57hn5A53THAftacNbgp3U8VeZn9NcZe/tYSyadRL9/JvjBo2SXhWGRYBFDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6715

On Thu, Dec 12, 2024 at 10:50:10AM +0100, Jonas Gorski wrote:
> The original patch (just disabling LL learning if port is locked) has
> the same issue as mine, it will indirectly break switchdev offloading
> for case 2 when not using MAB (the kernel feature).
> 
> Once we disable creating dynamic entries in the kernel, userspace needs
> to create them,

But the whole point of the "locked" feature is to defer the installation
of FDB entries to user space so that the control plane will be able to
decide which hosts can communicate through the bridge. Having the kernel
auto-populate the FDB based on incoming packets defeats this purpose,
which is why the man page mentions the "no_linklocal_learn" option and
why I think there is a very low risk of regressions from the original
patch.

> and userspace dynamic entries have the user bit set, which makes them
> get ignored by switchdev.

The second use case never worked correctly in the offload case. It is
not a regression.

> 
> Ofc enabling MAB and then unlocking the locked entries hosts that
> successfully authenticated should still work for 2, as long as the host
> sent something other than link local traffic to create a (locked)
> dynamic entry AFAIU.
> 
> FWIW, my proposed change/fix would be:
> 
> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
> index ceaa5a89b947..41b69ea300bf 100644
> --- a/net/bridge/br_input.c
> +++ b/net/bridge/br_input.c
> @@ -238,7 +238,8 @@ static void __br_handle_local_finish(struct sk_buff *skb)
>  	    nbp_state_should_learn(p) &&
>  	    !br_opt_get(p->br, BROPT_NO_LL_LEARN) &&
>  	    br_should_learn(p, skb, &vid))
> -		br_fdb_update(p->br, p, eth_hdr(skb)->h_source, vid, 0);
> +		br_fdb_update(p->br, p, eth_hdr(skb)->h_source, vid,
> +			      p->flags & BR_PORT_MAB ? BIT(BR_FDB_LOCKED) : 0);

IIUC, this will potentially roam FDB entries to unauthorized ports,
unlike the implementation in br_handle_frame_finish(). I documented it
in commit a35ec8e38cdd ("bridge: Add MAC Authentication Bypass (MAB)
support") in "1. Roaming".

>  }
>  
>  /* note: already called with rcu_read_lock */
> 
> which just makes sure that when MAB is enabled, link local learned
> entries are also locked. This relies on br_fdb_update() ignoring most
> flags for existing entries, not sure if this is a good idea though.
> 
> 
> Best Regards,
> Jonas
> 
> -- 
> BISDN GmbH
> Körnerstraße 7-10
> 10785 Berlin
> Germany
> 
> 
> Phone: 
> +49-30-6108-1-6100
> 
> 
> Managing Directors: 
> Dr.-Ing. Hagen Woesner, Andreas 
> Köpsel
> 
> 
> Commercial register: 
> Amtsgericht Berlin-Charlottenburg HRB 141569 
> B
> VAT ID No: DE283257294
> 

