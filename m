Return-Path: <netdev+bounces-196114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5E0AD38D8
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 15:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14054173291
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 13:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86BE246BCF;
	Tue, 10 Jun 2025 13:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gAHioYXc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252F4246BB7
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749561247; cv=fail; b=OiaiA5ph1IDmsLC1DLpn7Bv+QLpHhosHes0MWF6xWE3a4LcJ57n4HkYLc8N9OA8j0GflMaazI5KKtRJA+c1Mqmocx8MJcDPBXpw0sN69gQ92URc319ULLthunKVG7LDkbeE1pHNl61gOoMZ9xhzvAqN3FoHWPO9xkWcQTlb3LE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749561247; c=relaxed/simple;
	bh=9RKNKQaGqxPOgW7ir0BgmnY+zg/INxixbp6zfNFrKfo=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=BR0/hv7gG6fbBoeju4wn8x7srlsK/JPBQvDHj8k1CCEfTZw+l1Rje7BRwOTL3b1mZFtCa91GcZs/65XUD99c0geZ+haaJnbD++BUGx4Ci7mKmNic9gycee1U3O2SE0lVztr4sBVXr5YRPzSQ40fqb7syXF95zSK58vYb9RLbRlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gAHioYXc; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWcCIs/9QFcpT5lffmXHjmEZH/OKx0SECluqF/E+3vpi463ov6mo+xPeJM6oIYhUlTcESWq8A7fLNKD3KA6D0Syqd7bVOMPS2h8b7oTHl4N5gs10pp0mlTxoN+7N9sYZiQ685MAjxeRsZ5TmBPCfvRSncMilEMdopkR4p1VESq097F3JlNC9XJ4VOCO2/uAtmWTKTpM8a8q12qvMtyRzhX4WrG6i1zMFsX1JtJ6kYA5VZbTikEgTb7v/iQvpeedzr1OjrWlYWR6W/OcJR5Q6tY3sh8DdwGB2kEmM5vFEFFiYqzR1ByTJla3JMBDfWF+TVNXnT7yLhE4sLXnjssWsLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFVWmkdDR4oEhumeXfU0o8hOIgbxWZUOvMnS+chOoiM=;
 b=elorWXGwCfHYDnQ+p/tvgzNatod5boIteIzzuR3MmT6AKdAECz3T4uF/DsSQwrSA/cgQR8ZgXVhsOMlkkblGrL4L4D4CZgK+gn9dYFtazKFvd5JpENrdTLVIB2uoIqkcr8TU+uMC4PP1tFvFnXifJaV96+JtOEmbvvwwiQM+t7F0+CweNeMJEIw4leJFNcERrDRdFTuc6NDdQaP/Vc2P5DcMBHC0n3C6yf+Fl0N1mUeafkaH/CY4w/UdOINwlGnVraiRaO8xfccwTHLtPnOij/NLGZVylXwkDYsbcpCbKuuIfq5lGUv11tItpI+jAF0r3HpicNYv4M9F8pJKLbailQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=blackwall.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFVWmkdDR4oEhumeXfU0o8hOIgbxWZUOvMnS+chOoiM=;
 b=gAHioYXc4Nr2ftl3stBeUgR6YF4WjUp5Xqnx+wnDFUxRvUu9w1OH465iMbhHm0ZFczmK25vjmK4pyN9a+Q2HHYgGyfSHh3NvirWGcD2Bz5CRpYzWvG1jsPEsDK16ucRpyr7h0D/Fpy72yhXnIs1xwX4+aJNNXLr5kvoaCNElDpl+JOD0hkKHoQk7UMySdYzP7I8+PCP4IGZUylz16I2oMqSFkY/A5xt/qYm7ysc8E7+lFoPO7S5UmeYfGdxvqQP4sZ20r/0snorJARREcgeDDD3Ow/kNzJqLU5RmQG5wAjCwmP4JYkWDMg3f9kuAXibkAd43/rOcIoKv/4SqdJ20dA==
Received: from CH2PR20CA0003.namprd20.prod.outlook.com (2603:10b6:610:58::13)
 by LV8PR12MB9617.namprd12.prod.outlook.com (2603:10b6:408:2a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Tue, 10 Jun
 2025 13:14:03 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::6c) by CH2PR20CA0003.outlook.office365.com
 (2603:10b6:610:58::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.19 via Frontend Transport; Tue,
 10 Jun 2025 13:14:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 13:14:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 06:13:44 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 10 Jun
 2025 06:13:38 -0700
References: <cover.1749499963.git.petrm@nvidia.com>
 <20250610055856.5ca1558a@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "David
 Ahern" <dsahern@gmail.com>, <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
	<idosch@nvidia.com>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 00/14] ipmr, ip6mr: Allow MC-routing
 locally-generated MC packets
Date: Tue, 10 Jun 2025 15:12:55 +0200
In-Reply-To: <20250610055856.5ca1558a@kernel.org>
Message-ID: <87wm9jeo3n.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|LV8PR12MB9617:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb85aad-3cc5-49bb-3b66-08dda820abba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J33/Ry77tlsF5d+AXTkymxdQe/e9b77YnjR5Nrgma77ZioHjMK+GvUnwpvfu?=
 =?us-ascii?Q?1cF67aG4vkQ+dksbhdSXPXBTlo6WKOiwJ+NpSKkgM1zZLnitYkMhG1ARTGW2?=
 =?us-ascii?Q?QVRKGyDYf8P3PAEzFcHTNoOoROf443jnL1WWxOReX19QKamn96Yjdz3ZK/lT?=
 =?us-ascii?Q?tMbCN4CG7FQKfcDp9wAoyZfEVxgJ39+Bsk7pLuA7VwGyYHWWBRtkGOdzxB+z?=
 =?us-ascii?Q?yanlkB6VLrIWQxD9c9zjw6gVyE3JCmHZeaY4LmW9nljtXvjpodG8n9HGgsZ+?=
 =?us-ascii?Q?WvxSg47A70p4oMB+FrNxq4om+gt9oaV4oPQ4OOWcM+23v4GScZPwB999gkF/?=
 =?us-ascii?Q?6+iMx6qr55db4O8riWqioTUgR886EyFNHHcZfyMYOHuwAZN3/Xk0d3+B4Zyf?=
 =?us-ascii?Q?2Ydm6HyNSs8lqfH87iChJWPRh8GkPoKnb3YDkpE0pqZvKjm5awD578TLT/5R?=
 =?us-ascii?Q?dsO7lQaJBAFM2Db3VbqDYo2ICiVrhWumceXFS2D+TzyXzG1l/eim7zExjrDp?=
 =?us-ascii?Q?2uvmxgVwAM9ujT+Fiqan/wjJy6sFe329Y3LSLItxXIQwVzVYXLsZJsNII0JR?=
 =?us-ascii?Q?JY38RfLVoUd+FYyE7ret6GiwtMRSJUykT33K9JjzBLikro6m/DX5r1j7Olbi?=
 =?us-ascii?Q?3DwoGvYzqodc2nnszZWOG/jpehuEzr52LpdMtG6404VnA5bMQsJGFslPB6Jl?=
 =?us-ascii?Q?RsPnMOJyuJ6zon6dvG/szyXUPB1D1ay/TDfYigZMHosclcHDjch2SnTZ//9Q?=
 =?us-ascii?Q?3O4ji5cPwA3kPUM5gablxdYIbZkQOxLOTOuOdcoVcZ5kFM9hi2oyX9Aw7yYR?=
 =?us-ascii?Q?TFgUr5kDsWojI8HzMycC01boSjevIFapeM5cc0Rqczscu21YBYng5HtCVwRk?=
 =?us-ascii?Q?hGb/speG98BzgEu0jWsJdQi7OvV0UEN7FCM7EIJDVb//NJyKdQf1Q06jQToo?=
 =?us-ascii?Q?L6ZfFRZIT1cDCOwGBlEgDEFF9hH/IPX+ZWfbEZSyDfe9zoRFwHwy3yd0BYPz?=
 =?us-ascii?Q?4mherXHHB6gsLAqJ6hNby/MiCRxWc+CcQRo9lNRfgdcYyipMy7SXRuog37Cx?=
 =?us-ascii?Q?EK73UxVkVMGBIpSb3Yi3ZGTqf94SLzDRZBpoDyk1Rzcqx/m0MuFHRtdXOKrw?=
 =?us-ascii?Q?HSOKQJZC+Mr+1Rp5h+D8YgDLdAz4kW+c9EaOUypxPHyF9WwBw2vevyr1CHTc?=
 =?us-ascii?Q?njFC7kcpu6FFynp60/60/BepdmEfVCk6RrpOQb+oHHTh+mvQZpNWCyAU9Z1f?=
 =?us-ascii?Q?Ifm798dpCR1KlufCWPZQ67EYOHD1LWyXPoDHJmGOPHpAZSzV5N2/6TdUupaU?=
 =?us-ascii?Q?6xk0mIAUoRRTGwC6UNf+juWts6I0HjNNRGqcQAKAurxXHz510vDWbpNdU0Ce?=
 =?us-ascii?Q?5ejXI+yDbT999ZSRBqavsygsuZJjFCvZQunUj4ZT4LQh57wI3ptRRBQBENcp?=
 =?us-ascii?Q?lNYFxMjPFj1hyQ/dcXkI0sA7D6wr2e03mYqXv0A/kgA138qoNrg32+JMJE+5?=
 =?us-ascii?Q?3w0eC/vzk4jar7hbJukVL0i6Go0GRlIZUc5O?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 13:14:02.8391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb85aad-3cc5-49bb-3b66-08dda820abba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9617


Jakub Kicinski <kuba@kernel.org> writes:

> On Mon, 9 Jun 2025 22:50:16 +0200 Petr Machata wrote:
>> Multicast routing is today handled in the input path. Locally generated MC
>> packets don't hit the IPMR code. Thus if a VXLAN remote address is
>> multicast, the driver needs to set an OIF during route lookup. In practice
>> that means that MC routing configuration needs to be kept in sync with the
>> VXLAN FDB and MDB. Ideally, the VXLAN packets would be routed by the MC
>> routing code instead.
>
> I think this leads to kmemleaks:
> [...]
> hit by netdevsim udp_tunnel_nic.sh

Thanks, I'll take a look.

> Also, do you have a branch with the iproute2 patches we could pull 
> in the CI?

My bad, didn't think of it:
https://github.com/pmachata/iproute2/commits/vxlan_mc_ul/

