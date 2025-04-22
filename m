Return-Path: <netdev+bounces-184634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEE7A96943
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 14:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57FCF17A40F
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 12:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BF827CB15;
	Tue, 22 Apr 2025 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kTXtkazV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C7A27CCCC
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 12:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324765; cv=fail; b=J7e9zhUg+pSD7OSvqk4FHwcqoQsHZ3T6Fq2ADR7oZouae6WeaU5oqKi66xecU7ijveALd0x/YjMU9nAs4DXGe41zXJDEL1V81ovpIvzGUbDevt/qpDVvOOsqdkECZYroHuCEZtygn3X0o7OuCYbyKqKLyxZPVdphTS5ZmbL6Ll4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324765; c=relaxed/simple;
	bh=8qkQSwc7hc7RDNK+CzI22j3tVav2d+I6WBXizUC2fOA=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=e6HCYnKD54fIfMXEs5IL9/8UFiLgbMFNVipDgjH5CEEurC6iVzJFnb6smOdmaSfRXckHIVHWBtv8oXHToeCSM6Wi6yRXHO9b0RkkJte5dygU06MAU8VB+J1iFUIrscVQ3glB3pnQq9k5jBfNOObijw6w7xlMB/df+q9//SWwYKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kTXtkazV; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mcke4P0EtjBylNMYygc9nznUPddC9m03tZPRrvViBloNr1qJivg2UULolmwI2P+KoYtW4DMDKPQzxuOb3Stq2oYDDIgni/pkYchhLuXfFV7sk+Mz9EY8e6fkYzBBGu24l7pbVyv8/9xr5vYf985IzeOM3FvG4q3LLIJVa+7pWg+ln/LtxgB4BYEALJeTEznSEMQhIxU4KA4wjqvwBqurPGd2ZtrK+kfDeSIRMfjdcOA18p98+ZNcUozwI47Xg/cA9XhzemITo2Q3NCtw8hqKJ3KJ2qC1IoKxZ0EqVDkN7rkFBPUCOTVTxqw2AmmQurVGrEou8Xc8gSr6Ab1Jv/AIYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qkQSwc7hc7RDNK+CzI22j3tVav2d+I6WBXizUC2fOA=;
 b=yygMsD/a5+VmHE0KdRCqPSD2L1IEebRzps4FqV5ZrPX6fXZ6VeCctYliOunJRvMVTbvxF1rrflZEbnnBqo+TUSpQDeKJaf8iZnKI5RaIZiuRr/nghgvlb+8Y4Boy1j9XRTrAvokRiyX/cJlupfrBhAS3JNqnNmqjhYZMEjWY+WP7N81Rj6F2ExubW7Co3grjqFGYCKkupuHmxfvowk20y0loOf0w7xB3KEgjoBbu0UiZMKle8TQpIAls7kSxA83q8FyQRtmpMtx1gIURB6Lf+INs34U0AVlHPwBNh1RXj721dbzNogOnGRYTqvlXuLTA31WEAhqcD6zrTW+6ps2AKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qkQSwc7hc7RDNK+CzI22j3tVav2d+I6WBXizUC2fOA=;
 b=kTXtkazV9BoftMpUnc0BZw9IdQ0RO6eNu2OeVz3ZQUhcrZdZJO2vAhZQ8l/Jn2ZQ7kyqUTJNyEghkW5/c0GNuw3wM5o3oujhF0YifvEgum2/s7zl6OBq8oF0OwRBpgwprTw3qH7CNPHLu+Lv0LbXH66wTQWRPFf4hchxtU0lbH/vIgW2c6KWrcodFcWcD+ooBywILK9l7lYA5dhawNYJmd7KqTDvlcwHMTuqccOCyj3gcmK/Feql3u+Jb80ZkNRncn5CmtVoMwZLVbmjPgjmAtSRCrAAX3ML8YdjWmSiNJL943WHcJibj7yUGyPb9MNIbGf3gBhUb6dTnjJMj9n6jA==
Received: from MW4PR04CA0278.namprd04.prod.outlook.com (2603:10b6:303:89::13)
 by PH0PR12MB7094.namprd12.prod.outlook.com (2603:10b6:510:21d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Tue, 22 Apr
 2025 12:25:58 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:303:89:cafe::d) by MW4PR04CA0278.outlook.office365.com
 (2603:10b6:303:89::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Tue,
 22 Apr 2025 12:25:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 22 Apr 2025 12:25:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Apr
 2025 05:25:40 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 22 Apr
 2025 05:25:34 -0700
References: <cover.1744896433.git.petrm@nvidia.com>
 <36976a87816f7228ca25d7481512ebe2556d892c.1744896433.git.petrm@nvidia.com>
 <8af190ea-5b12-4393-95ac-2bc5cf682c65@blackwall.org>
 <8F591F22-50C7-429E-AF42-BDFBE35FD10B@nvidia.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Yong Wang <yongwang@nvidia.com>
CC: Nikolay Aleksandrov <razor@blackwall.org>, Petr Machata
	<petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Ido Schimmel
	<idosch@nvidia.com>, "bridge@lists.linux.dev" <bridge@lists.linux.dev>, "Andy
 Roulin" <aroulin@nvidia.com>, mlxsw <mlxsw@nvidia.com>, Nikhil Dhar
	<ndhar@nvidia.com>
Subject: Re: [PATCH net-next 1/3] net: bridge: mcast: re-implement
 br_multicast_{enable, disable}_port functions
Date: Tue, 22 Apr 2025 14:20:22 +0200
In-Reply-To: <8F591F22-50C7-429E-AF42-BDFBE35FD10B@nvidia.com>
Message-ID: <87zfg8l6x1.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|PH0PR12MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: f4e79d29-e522-4e48-c796-08dd8198d5f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IVnVncDfzFOTn4L0Pa2QQfYODSoMjgFp5TpCIAva+HTp/m8Zs/hbFukL8j/v?=
 =?us-ascii?Q?Ysj5dfITKh3goTNgOROIcWf9MXIjanrGpUbe9+6JTmtHkiXYbhCDG4cNLwyQ?=
 =?us-ascii?Q?iaG3GkJLBMfBhshJFm/v2XtAF7J6/KRIwNuz+trGsAbzt8Vr1OuHeBHCNC2x?=
 =?us-ascii?Q?KrEZyOAAs1Yb8m0UcAt4oizdaTLK1lU0QPd0tWNDmBS3GPLscW3mONDruO9n?=
 =?us-ascii?Q?LvNxCdI/qG2CfIEM16gTmJ8G+laYkwZ8urQpn5GMQ/fwMCyYD3dBISMWEGmP?=
 =?us-ascii?Q?ObWvvymPYs9/0eNEhm4USOftcHNVBpYNcMJDNc209ir6Ui0vWPpbioaE+C6q?=
 =?us-ascii?Q?YdPx2ygUm0oIww1IHWE5lNNU1EV5OSk8+1vEOZS0YZiEGQtg8GO2EAiP7bkO?=
 =?us-ascii?Q?gtEFPEn5kV4H6xGf/Brn5ZOPF36xQvuSIoW3/nxDjzYQbx+GzeITRA7xgPIn?=
 =?us-ascii?Q?jahXo5jS+BZefF65oWzl0ukD6U761cnBe8qkve7GsW6C5ysky4vvcoq8JZC+?=
 =?us-ascii?Q?6BN4lVXeeNfgfpAor2zj/oRmvkuKYc9yEpg+28OJ+GKZHD8Cbr5qKCb3+3a8?=
 =?us-ascii?Q?ePQT21f5nT2MdlZAJ43//WpyBazwG234xJe92pe5mvxKxm1QnPl7qNXyCYUx?=
 =?us-ascii?Q?umOLPll9OeDQoto4L/sXa1B+96tn8kOFrfPWXhBuiIpfZo4mLKSD8FNyzutJ?=
 =?us-ascii?Q?HN4EWAOakM0eMj59ZmGdTjGLeNCli0ocihGlPr5pDea5n7Gb+p98nLPmfRui?=
 =?us-ascii?Q?Gh34UF7ktn2YkdJyWb5H/x4cUhECFF6QlU3xVX4COqCV9wX4uQX2G7E0Mbaz?=
 =?us-ascii?Q?WYDloyCvkGi1wf2YbBfG3HJtFgnTsHtXSyZ/68SuALIfWEPrjKnNFxUa/xM/?=
 =?us-ascii?Q?3NLl/gBKR5Mlwf2fPLwYOFyYGlHfwd4S8ia/619HinG/x/iwcLRqB5/hrtx7?=
 =?us-ascii?Q?HPBjRmgJafx/rgQdoJtKCWy6dTY68tHMPB9hWcq32xbBat5cMHDXAy6wt5Jy?=
 =?us-ascii?Q?vaZSuvG+hO+1yXGCmbJFmh8Y4Mk+efuNO8Uos2kCswu+S36WR6HihG04A77Q?=
 =?us-ascii?Q?CVZ0l0gUX0JfIkD4QwV+gJ6cJSpJuFd7+EfQ704uxWJ5Evdt/1rUkKBMfa8V?=
 =?us-ascii?Q?SwDVa5iNo8GDwebM1a3ZRpehERAP82DPUA51x3yMwijtCZXEA1fB/RW/uXV1?=
 =?us-ascii?Q?udmJry90v437IXbXZxZ0oKz0PrgNusABKEt4o9+a1mFz0mmUv5FWlyDtOqC/?=
 =?us-ascii?Q?W2IqYQp5o46gmB/Q/RALx+3ho7Zcyfyc5RwuXKiMgTbeMAfrWWyxNB63TsOT?=
 =?us-ascii?Q?r46SawQ3L6PjaQO1EATvaIyjcXeh2+75DoCWx48Wwp5jB4ewNpx5bkbDSPUr?=
 =?us-ascii?Q?5y3DLsOF1SdoPeukf0JS1ZpbtsNe5sY3vhLKYVuXZr1dYplyfmp+tzlzNXVN?=
 =?us-ascii?Q?Q2rO02YrmU6L7mjm8yG5gBA4smxQ8ZaUTAzd5DE3R2UNSijDhgj8qLsQx5w1?=
 =?us-ascii?Q?MVR1b9L3D0cA0R6kljngGxWxq8n8bLDQ4x7c?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 12:25:58.0010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e79d29-e522-4e48-c796-08dd8198d5f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7094


Yong Wang <yongwang@nvidia.com> writes:

> On 4/18/25, 11:38 PM, "Nikolay Aleksandrov" <razor@blackwall.org > wrote:
>
>> I feel like I've seen a similar patch before. Are you sure this is not v2? :)
>> Anyway looks good to me. Thanks!
>
> Yes, this should be V2. Petr is helping upstreaming this patch. Thanks
> for your acknowledgement.

Indeed, there were two RFCs and a v1 back in December. My bad, I forgot
all about it.

