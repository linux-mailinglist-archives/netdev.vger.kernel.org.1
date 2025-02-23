Return-Path: <netdev+bounces-168813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A616BA40E3E
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 12:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE13176A41
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 11:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C87202F90;
	Sun, 23 Feb 2025 11:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ODCyX5Wx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7643C1FCCF9
	for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 11:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740309682; cv=fail; b=o+58WsOXPsH+s39x5ClFn+P811TnuJYcaBzpdIfk7k72RAW4dmpWCjswEuiMsPezhS0pUS7oFvSQ+3zFh0veanq+ffaOZcQxvTj6T50Z5ZTd0m8wjpnV0Crzaqf/JGCmx+k+A+fkIJYOVgI9nB126TDnzAGxPFFb1tXWG49hDGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740309682; c=relaxed/simple;
	bh=Bj0QfwzdKqk4jj+x/YzzJZU7C2u1nmdSGDTlyO/PrYs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWZiptjqSUcb520gz2J4VQY2auZu60lfWxqjaskJ2SztPclm4IIaXJwznjMWFo07hsFCNlH6UWsjaIdOW84Na1HneJMkkbq+6BOddFxBIUg0fZHeZeFoqojGX2WkmUbA71uPwMvQCigeuBKrxqLu6q5NgzbzDppvrHGHoL6G4Os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ODCyX5Wx; arc=fail smtp.client-ip=40.107.95.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLKGvH2Q++xKe1fZUWis1kCyd6002GQZSDHZDucp0xpOf9rtFuMdehOJm4e/ADLtL7eJLCEbs7vK6WeqpEgno9T8gTQ4juBvBw+aJEVvKyOpxyqBZdAXpE6xpmtD+o6RiwP5KZElArJUPeXNPqJUknTWKwS+4FPvN2Rw94MoMEujFjf5rhz0JJqaEuxdzDWR22rxmGBBLCjUvsC3tMsrTghwLGQSjdBZ20niQBE98WiPEDzqa/bZS2O8wmSowbHFZDcCQQ2OLRMnVYJ9DwNup5wCXakxZIkkizzhol7bFTLxGGV8BYrXL/qwpakdTxEtZyf//tzLv7XVlfDXOGgvqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNI9mWkB0/BzD6g9K5FBHyu1sbZWHvhi09HqFPC3FG4=;
 b=IppIu+H2Y5z5XZSYSr1vIMdb3/c9oJQsH8a3ZLdGk+l25NiD6JAUvqy77bbWokLdEIt5RfY/JUm6jCmwvmANxBThWXERxC8Kd9KgaCid1L3Rvm6481SsT/MYtq/B8uTam6Np75e6wuyUfPJB9wsjriBViBjH2Myf0TSSELWGTK/FJzqQpEnsi3zQkZpB+qbA6m1g2j26TuvMK/GKufQ4Yg0qZ2VJ1qU3396qGR3Jf60PH52SLBQGXGKn3WnImXjOQcCoosGmmp46qkHmsLNYF+gPqDfdKlxBCwHYOGgsPGz2Xg2gu74LQ7m9kw3T/h6e6c7UdoqAqus5UuQk26OF9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNI9mWkB0/BzD6g9K5FBHyu1sbZWHvhi09HqFPC3FG4=;
 b=ODCyX5WxoeYnMDZe70Sopdlen4ChKaqmt+jbrKYeib9ugTA8SeuM/eDYebBvl+KgGbluyJyYbnMwXUu3PPPcVow5rO4fLN7e0x0IHTqKS2wMcgo5W+/uI3INA+IoSMq+lvULOl/yd98z64Ru+I5es0+3qEwPOXqwAO2HoIBbzgd3TOdypx4fMAKnYzSRI0vwC0DGHKtiqu/QFncQLFYSkRiHThYfdiMpAkJiwF00CrAexdb2kkJtRBcI1BrAKJcvOjQz7d7L4TC6cWwRF0T4TVRjJezYGGzgxSTqFENA9ajoLwXb2v7S6/e9srfdPPMbOVU8pFGjvwrKWKmj3Bf2Ng==
Received: from SA0PR11CA0053.namprd11.prod.outlook.com (2603:10b6:806:d0::28)
 by CH3PR12MB8902.namprd12.prod.outlook.com (2603:10b6:610:17d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Sun, 23 Feb
 2025 11:21:14 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:d0:cafe::46) by SA0PR11CA0053.outlook.office365.com
 (2603:10b6:806:d0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Sun,
 23 Feb 2025 11:21:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Sun, 23 Feb 2025 11:21:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 23 Feb
 2025 03:21:07 -0800
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 23 Feb
 2025 03:21:06 -0800
Date: Sun, 23 Feb 2025 13:21:02 +0200
From: Leon Romanovsky <leonro@nvidia.com>
To: Chiachang Wang <chiachangwang@google.com>
CC: <netdev@vger.kernel.org>, <stanleyjhu@google.com>,
	<steffen.klassert@secunet.com>, <yumike@google.com>
Subject: Re: [PATCH ipsec v2 1/1] xfrm: Migrate offload configuration
Message-ID: <20250223112102.GY53094@unreal>
References: <20250122120941.2634198-2-chiachangwang@google.com>
 <20250220073515.3177296-1-chiachangwang@google.com>
 <20250220073515.3177296-2-chiachangwang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250220073515.3177296-2-chiachangwang@google.com>
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|CH3PR12MB8902:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f814190-6678-410a-5610-08dd53fc2ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eI67MBCb4AoYNlmQ4w8i53rnZ70DOLR1LnKvjyIyp3rG0USmHfZgH1Hcu4wT?=
 =?us-ascii?Q?8OlSaoKrKUSqJKbguSKrk88WQRoRAy9rdyzytiP3JldlgzJG8aq0aX2o3c6s?=
 =?us-ascii?Q?OxE2ygBfJjIxHHpxfjIoiUtH5hSmdKOcVdpAvn4RqaThm+9sR7XtrxuEbGaq?=
 =?us-ascii?Q?vEsbgGmi7YqSnVyUvANeRtnfG3W7XvQoePbMIlIL2a8aOIB02ZaoC+WxQNPA?=
 =?us-ascii?Q?8Jvt6ogIDaZDhH/ykNGceNuNRtrmfwg4UBZ7Ed4D+O7c/z+8Weae3bk38Bbu?=
 =?us-ascii?Q?buZGjZIBBw8lmAEsnKAmpUq9a3c9K8/qlIicMZgwLvcsr81DEmxClieS4eTb?=
 =?us-ascii?Q?G8zBglZhVdU0TFPGl1yaaJWYDFTQiZUp1UuetmiQtRyOHo8of7jB2AnWJ5QH?=
 =?us-ascii?Q?oprttbwAVVRb9Ubcv6flz7Nlwc7i+c4H/i3h7uGOX75KE3ShblOfGlPolmIu?=
 =?us-ascii?Q?hJYNTFxLNtwrAQ+irbO3y6mDz/eeR8DSNc1eQ4R78zQQd4xDqlowE8DfEOf0?=
 =?us-ascii?Q?uACnnSYF+xXLY/4Pbix0m1sbLTqNUXt06VQ6altdnTM4I4e+ZzDe9pt/+U8f?=
 =?us-ascii?Q?9m8iPPmCdUK6TDEXJPC7kNd3Ku45kAyBpawtWy5UYCtL8ISxtqjUiLsFnBgx?=
 =?us-ascii?Q?lr9pnuWDxqXC36BBZD32AjmlJSelLDCa2EOfLid3saszbVviiMQjhTDTyBvJ?=
 =?us-ascii?Q?FRsexfALv5bhV98A/+xvZKOCxdpJ2WxB2QD5kfvHm5gzS1Zd44sI+fIpZLzI?=
 =?us-ascii?Q?3yahbbL5lc7r7JZqegC/KLgQ3WSdP/9RvId2hnKMCXHFmCn39mBYjwMih2M9?=
 =?us-ascii?Q?bJMOsYjC3guRJuZ3N7jYuYBsmtIrZaMZqy+ce7qw8uySTvlNtJCfbPf+4aEV?=
 =?us-ascii?Q?g2yYisIsEZtF4NJgb734SXUQiZ9WJwSZCLTnOPod+iSaK7PcgN2V0z+GD/TF?=
 =?us-ascii?Q?oIkre6Kq2mupvoZLxb64yrwkZD7odOTHxw7WhE/Hhx8YJOU6Hvg4LFuVLCue?=
 =?us-ascii?Q?jpFdBLGroEv985L6B/tvZoCZhK+gy0TuMTPsPTfS1DgZGBGecyAo2yXuJxQ9?=
 =?us-ascii?Q?Jnp9Ru70hy6TVmb5KUq0Mb97h1cdaPoLLU5HZmkyYTQAaUrhS6iKBmV/M/4U?=
 =?us-ascii?Q?18dfzUTzgSuO6fHpzSbm7ZuQS+0GU+C/GwOq6S5Go5co4CKbNIjBNPHOZ3cS?=
 =?us-ascii?Q?Tz1CPQIJ+VO6H/kZ2dV67ZwWTyJZIKMFSQ6wbUXrPNN5sawQ3q83o3Z/y1Cl?=
 =?us-ascii?Q?gLNO3+clJ+VcMG1+s8Y7zc7AYj3UoJrrCMOYoVVNXDRqpOp5grNJScIYTZum?=
 =?us-ascii?Q?VU284uZ2xcjVAn3iQsmYyCltySNt9tjdt+DvIVSX+edIY3AvuZoOsc5IPNXE?=
 =?us-ascii?Q?LZOyreoY1abUoeuc9LOTxa+sAmvws/1nZMYOytu+l0LAvT4msS8/35q+540E?=
 =?us-ascii?Q?jPQar+d8i24Ksawb/7AD8uMz1C2ohC5HQlVtzMZQAv0xfivbm1OOE+PUxSkS?=
 =?us-ascii?Q?nMdkLUVzKRYIekk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2025 11:21:13.9030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f814190-6678-410a-5610-08dd53fc2ee5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8902

On Thu, Feb 20, 2025 at 07:35:15AM +0000, Chiachang Wang wrote:
> Add hardware offload configuration to XFRM_MSG_MIGRATE
> using an option netlink attribute XFRMA_OFFLOAD_DEV.
> 
> In the existing xfrm_state_migrate(), the xfrm_init_state()
> is called assuming no hardware offload by default. Even the
> original xfrm_state is configured with offload, the setting will
> be reset. If the device is configured with hardware offload,
> it's reasonable to allow the device to maintain its hardware
> offload mode. But the device will end up with offload disabled
> after receiving a migration event when the device migrates the
> connection from one netdev to another one.
> 
> The devices that support migration may work with different
> underlying networks, such as mobile devices. The hardware setting
> should be forwarded to the different netdev based on the
> migration configuration. This change provides the capability
> for user space to migrate from one netdev to another.
> 
> Test: Tested with kernel test in the Android tree located
>       in https://android.googlesource.com/kernel/tests/
>       The xfrm_tunnel_test.py under the tests folder in
>       particular.
> 
> v1 -> v2:
> - Address review feedback to correct the logic in the
>   xfrm_state_migrate in the migration offload configuration
>   change.
> - Revise the commit message for "xfrm: Migrate offload configuration"

Please, put changelogs after --- marking, fix kbuild error and resend
the patch as standalone one and not as reply-to previous version.

Thanks

