Return-Path: <netdev+bounces-165302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A0EA31868
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 23:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A67167C1F
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 22:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CC0268C7B;
	Tue, 11 Feb 2025 22:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q96js63e"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FABB266F03
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 22:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739311967; cv=fail; b=J/stt5GGhVgrigxW+PmaZrazAk6rH7fsjZT+v9O/roTfxx7hUEByYA2knd56P+uA9wolMmtrxl0s8jn3Vv7uCqZxXSeRuNdjBhJ/9gpxGtYi8lSYSywqd0CZBzna+SnHAg2yFYzPJpzjuG1MkhXw706IN4CuYigPmaUlJpmWQYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739311967; c=relaxed/simple;
	bh=2D5Bo/J8DxKzHN7xLfpaJET6UVqmdlxuwKxX/mC2CNA=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=So1eTYp1A/o16aF7JsrCyKbizDrrg0Ev9J1ioml5RTJ//v5OXK0hCNalU4RHksl40f8eQBUBBcoYJVrIkO+lFanlgmzDSRBTeS1kqeKnTuBcE8E9x/qLe6+7u9zi7CjRhRApdfzygg7p1JEYI7F6mrqqJlth1XhiMHlLwU0NAMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q96js63e; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D56PbW3f5aJoyN2yFIsekLi+yh8hF3qJwx+VWrt/0BhpiPjSqhrDuWhir7K2ddsqlU/0/bBi+3IZSK5XFYrtqQ7XlQDJh+wnCo2RZT2gDy5IuFU7fVhvtRAWQ4IkdZe6C4TqyBBbyemS0wXf+n3kAX9dxem/YlfwBIuUHOGfG2ryfi/PPOOkoR08pnIPDFXUc0B790KUBan9hR5/9+fd1WNch9kmX8R3MGYSyTA7V+AVpyxwowd0JdsdrAz1mPv5Jr2aHVxfUiG/9/NMz5DFM2LsbldcauT/dHcuDCagG/3et5Wj+WuxX32C0C8YVtPV9K7JhztmZ64d39KikPB87A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjylDLmRF1HoMg9sLX06KNfQRK1HPZnuqs5iyJ3Hy+M=;
 b=PTk7MhQN8XLHrU82dGLEvT3CZ7UvSnjLUm8V+ieXW5O0YBDJrGCMJNjhw9ONMXw85ScEEVtlGntdgTgs8uelXWJOERQtoyyoRqJ7P3RuoZFGIRnEAt9kIKYuepiKXTSiXg5stQ2PuoFVA6ywZathXSuMHFy8dnPnqOi2NjMRgwD/tFE0vtVTDtx+ly1+e/5+tndj+Qokql6kcdrlfR1/LK+VJhb+juFY3WfLP1m3hQXWKCV0/7acW6IHmB2ol6Gp1EqAyNrb0m4B4K2re10gL4CYIBAGSEICiMST8SGNeKDYDdNIGpp2A/loHm94IwTGVyQYHokuJPsw4O2BSrDkfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjylDLmRF1HoMg9sLX06KNfQRK1HPZnuqs5iyJ3Hy+M=;
 b=q96js63epX6WGK24090omUebm0BS9VPQywUj+Cpz+SpFpyCYrpRwVYi13YXwIN0a+mEZt9OPCuUs1WFVX6Bg/30ken3P00L66GDkgIQsFvEfbG7cnz2CrZJQgCseGGc7r7l3DeY6Lq2bp273tDPTwI21ZaV0ySf42KUJwFgl3CiMcalIQxCZY5wequW+/koEiob/mwE4UfL9o1lGLyp413N0oSUDocZyLs6Bb0fMn58nSa6GNdsYKvY+e5Ujn4GCWLFDEBkx0VRODH/0VCU7EkgXD/HCKNZsmbLqqTDmwWIbbKC9quwuc11GPgH3dN5s0jVE3Y9ewq/RGa6LCbWmjw==
Received: from SN1PR12CA0114.namprd12.prod.outlook.com (2603:10b6:802:21::49)
 by CYYPR12MB8656.namprd12.prod.outlook.com (2603:10b6:930:c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Tue, 11 Feb
 2025 22:12:42 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:802:21:cafe::2c) by SN1PR12CA0114.outlook.office365.com
 (2603:10b6:802:21::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 22:12:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 22:12:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Feb
 2025 14:12:24 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 11 Feb
 2025 14:12:18 -0800
References: <cover.1738949252.git.petrm@nvidia.com>
 <6986ccd18ece80d1c1adb028972a2bca603b9c11.1738949252.git.petrm@nvidia.com>
 <a800d740-0c28-4982-913b-a74e2e427f25@redhat.com>
 <87seoksdjh.fsf@nvidia.com>
 <aa210895-61d0-468d-b902-93451983756b@redhat.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	<mlxsw@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Nikolay Aleksandrov
	<razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, Menglong Dong
	<menglong8.dong@gmail.com>, Guillaume Nault <gnault@redhat.com>
Subject: Re: [PATCH net-next 1/4] vxlan: Join / leave MC group after remote
 changes
Date: Tue, 11 Feb 2025 23:11:18 +0100
In-Reply-To: <aa210895-61d0-468d-b902-93451983756b@redhat.com>
Message-ID: <87o6z8rv0h.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|CYYPR12MB8656:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e1f19cb-9d23-43ba-b246-08dd4ae93432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?enw4631B8RoEqFU71MDw5X+sBw8e9LbkZVB1EDPk3ddW+4fwgyhYTTSi5M7R?=
 =?us-ascii?Q?TFaVWcXFwnAm9SSc4KPdSOuYD+B7ubDDrM+JjuV+0mADnNsicYzLrmh049hr?=
 =?us-ascii?Q?KJUaGIpTnkuZWSPJh9BjPx7+XvkKhQAQ3n7WeqO6GVD/YZWMMqTyHYWtpRhz?=
 =?us-ascii?Q?uTwkEE65Js9/Xv8UqBNw901/YzcrE3u853VUzKj8/w43KPs8YAo5aIns9QhK?=
 =?us-ascii?Q?bWuXNQ16J4H44eUn4pt3zvFceHvsU7sYR452dHASWT5h8CPh7uyJx53q+Cmy?=
 =?us-ascii?Q?fLtZMBNTPqxm1JITbfGIZZClQM5SQBpDrweO0UTUb5xVB/WSrck6TiAQlH1Y?=
 =?us-ascii?Q?8QI/+PqgTXU+sejZGfMxE3hzDhjIyZoOc1v6cZ77dfI1tHHJ4JKOcIfnFXLO?=
 =?us-ascii?Q?lNRHbgKVXrtBTnPpGmN86HW8+ngVqNOmU1qu6vLFyemXLhYu19QLFn5l9T9i?=
 =?us-ascii?Q?VUednkXyPh2YfjWFPFMOOT0OuNQT9xn2iC4NQOhjD/xieitggZeYOOfR0+KM?=
 =?us-ascii?Q?Tj+jzvkJxTs15n1kyz2l6DBEsR9lCmf6ULeaeGedcJaQOgNeHj1CzENjt/1t?=
 =?us-ascii?Q?Wv+FYvWg+za55R1D+i5Q5E6rB5smwJXPXDeBaeD6+NzmDDEIIu5ggVlgRM5y?=
 =?us-ascii?Q?dKS+zcp0dMa3zpSaPaZeWIu7HvaQRSowJ1JeW8NaeWtqgrQSA6DTW4S60C2d?=
 =?us-ascii?Q?ceT3UNNvVnV9WWUOX9EyZbo8+VX1DAhj1OJwhiWvB+gkH0iuCZYoYYhf5Mum?=
 =?us-ascii?Q?aUaq1wwWCOoCXiTiTqOUDx9DXPJtKwi7aBjlDwMKmbUCKmSZ2n/v4M/f+L3u?=
 =?us-ascii?Q?sMLG5PUHxtSo7a/iPHoBAywBh6jiviMom9pK8etu/84Iz0jnW0bMmVk+p4VL?=
 =?us-ascii?Q?KMhzrak9C66AmlxUR8shye680YGjE6m6GItXv8oMt0jslGnRH/m2da/7wLBv?=
 =?us-ascii?Q?9YoxiCUpYfTImt7FI7A4A/wCi8kY/LSfq2DCzmBVBXFEpTXH3wx9qZv1ShAW?=
 =?us-ascii?Q?zVilltVCae9FirCBUefUEwLEWizp/InlT5fKST/3Z+zBFsR44/yX2p9F6Jwe?=
 =?us-ascii?Q?+16jLQQK4jLCGlpUokh/y9xgylN616pp2siHPaqdIuRPwD51SrarRHKNKA+Y?=
 =?us-ascii?Q?9SgPtQXDQlO6WoqSB2Z5PM/9ygLg2gwjl7m69EwKUh3ixUkMlCCp8XppfGa7?=
 =?us-ascii?Q?KeQqJtUhX28lj8hWPr5zbUKENc2cHRCxMIfYvTCS23R7KQu0EyPgwua/QlOE?=
 =?us-ascii?Q?zba9oVqN2jPNB4UnTrb26cPSXYj0pSWir6CGnv/0G5VoD3qx3LhESrLcmM25?=
 =?us-ascii?Q?V4M2YvEOPO9xE6+IdW2YHN8Ce94gnJA+sFF7zEFRUJHp9IekEZUysBhsk/1v?=
 =?us-ascii?Q?nlBobkjQvfvaF4034AWhWeyA18+eof/aqeRTd0AspUnKbp9/f7Fw8E2OhdX1?=
 =?us-ascii?Q?82QxHBlxIXQuzMJylYicZAVLhTu7r+AOJ9RUIbOMCkJljiVuJLTIGIEEoPqh?=
 =?us-ascii?Q?8KyDCqORN5q4C18=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 22:12:41.8645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1f19cb-9d23-43ba-b246-08dd4ae93432
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8656


Paolo Abeni <pabeni@redhat.com> writes:

> On 2/11/25 3:56 PM, Petr Machata wrote:
>> Paolo Abeni <pabeni@redhat.com> writes:
>>> On 2/7/25 6:34 PM, Petr Machata wrote:
>>>> @@ -3899,6 +3904,11 @@ static void vxlan_config_apply(struct net_device *dev,
>>>>  			dev->mtu = conf->mtu;
>>>>  
>>>>  		vxlan->net = src_net;
>>>> +
>>>> +	} else if (vxlan->dev->flags & IFF_UP) {
>>>> +		if (vxlan_addr_multicast(&vxlan->default_dst.remote_ip) &&
>>>> +		    rem_changed)
>>>> +			vxlan_multicast_leave(vxlan);
>>>
>>> AFAICS vxlan_vni_update_group() is not completely ignore
>>> vxlan_multicast_{leave,join} errors. Instead is bailing out as soon as
>>> any error happens. For consistency's sake I think it would be better do
>>> the same here.
>>>
>>> Also I have the feeling that ending-up in an inconsistent status with no
>>> group joined would be less troublesome than the opposite.
>> 
>> This can already happen FWIW. If you currently want to change the remote
>> group address in a way that doesn't break things, you take the netdevice
>> down, then change it, then bring it back up. The leave during downing
>> can fail and will not be diagnosed. (Nor can it really be, you can't
>> veto downing.)
>
> I see.
>
>> I can add the bail-outs that you ask for, but I don't know that there is
>> a way to resolve these issues for real.
>
> The main point I made was about consistency: making the
> vxlan_config_apply() behavior as close as possible to
> vxlan_vni_update_group() as stated in the commit message.

No problem, I'll send a v2.

