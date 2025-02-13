Return-Path: <netdev+bounces-166121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A28F4A34A78
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 17:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D46A1892553
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB04202F72;
	Thu, 13 Feb 2025 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lxvrSLP0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E20155326
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464283; cv=fail; b=jr4ti1nMZQ1jZXV3bErXGC2wg9yNi1sCz+/wjjm2BU7+6Fg2QPvnGSwmpLZSyml5uFJL05Q8n+XCXv9Au8tV4f8isuhFPmbUWee+GJcGBQsslOcx6PO7hnwZFjtgCnj38q8a5NyWADZceQxn4UCVL0PHwZIuwe4T6Pq8uVntYnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464283; c=relaxed/simple;
	bh=Q3tusGrZCfQ/jiC+k8x4Q0uXHLarJIdFTJ1yQJmrmyg=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ASZ6KgLsLZez8wecKAJ1CRsPX/Wc/HEhC9AKbEhw1ak+Ivft5E5XF82ZoVkt94VGhYCfGmUzMdiDTjvjR8YLPxIyzRL5PM7jOxj2u97io3xBH5zQbZ4YrTahi4oK9ahERYPjtri2l1b05gISi8m9+fGa14t/M3RDmtwhg6YCNw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lxvrSLP0; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTyfoENzhTrRFRE5szYiLRhUseOy7ihzkD0FhvxIcU6SmeBZOwSsRIPaiO3KU/3MrQSklrNrM8WED35IirhtN82lZKdCU+LcbPknCzbBST5gOCto4GdPlAn7qirqfvUwmG/KdtgN6zKhlRgFqxgwZwYFeGMvnZL32hy7NdE3A06G2eTgtw6t1My5mjvj0xm5o9ANT5f32cNNvUckZLsaqNOIuzxU7iA3WwVPmbtW7T7V0Qf+ahIlw3pzeqO+Zl7Oz3iUnaYX2Ls0THqHOoxoS75djdBeSwajorpMNC2+HC9jDo2wu8jkmswiTL+JoN4hW2HXUMkH+my0EpgJYNbKGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9F3qmWkrU9Cx9wwi8EuAlVj1/dsgyEGHspgi2Uck/Uw=;
 b=y0RAEtPuByjXA5GWPKy3dFDbGet9RrE/sd2/nK58J0fyWymABh3z/Y9RNK67hqoEabPURwUYwLeGJh75bTzyPfC0YoOQVCKOfUB3z0HwhEaafFTm4Ct6Wt7f2cBdO2905JqETFr4oL/ekXrFWUP3rcQnRb1RVmUomCZ95iP/8MMuD9Z6lUnpM1mla5np3byNQQi34eO4atlIdPqOINOTSwUZO6poTOdAXb5IUlxouE9mU9oRFoZgFbMNLS8bo9m99TxGnkD0fIi10el9+qNV3j1l5tlmbzaOuAcEV1Iiw3ToLjWQBZJFtMsKdwQYKA+IQIwYD9qTPN0cpJVmdfmVxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9F3qmWkrU9Cx9wwi8EuAlVj1/dsgyEGHspgi2Uck/Uw=;
 b=lxvrSLP0Haq40YbpqCN8dWYA5g9mJhRk406sr3CyJD45nWcB0pj3KBEOcS5/cBMZKfamXBTqdRoAzPkKfU+4nqNmVcbSpib47tzs3A7pkQlzhGhu+54BEPML6VUjULc4jZP3r4Bo0aAy0H330yDROhCxxButvOHbjJHpzwZp/KuFJJOxKzH4EYVJsjzeMPUb25PX/tffTPUkq1EOVh/qCXeLI3bUOTS6HnqrvNyAql/nY02i7D0kKn4qKuTiMEnlYGRwsDu4Qfy89Fn78lbE4yi+pQQR6v7Fa+32qYi9F2atYpH30aqgVuS2VnylgOISgxIb0WrFL8UK40EIGxJ6JQ==
Received: from SN6PR08CA0021.namprd08.prod.outlook.com (2603:10b6:805:66::34)
 by CY8PR12MB7538.namprd12.prod.outlook.com (2603:10b6:930:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 16:31:06 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:805:66:cafe::6b) by SN6PR08CA0021.outlook.office365.com
 (2603:10b6:805:66::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Thu,
 13 Feb 2025 16:31:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 16:31:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 08:30:41 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 13 Feb
 2025 08:30:36 -0800
References: <20250213003454.1333711-1-kuba@kernel.org>
 <20250213003454.1333711-2-kuba@kernel.org> <87o6z5di4m.fsf@nvidia.com>
 <20250213075554.08a1406e@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Petr Machata <petrm@nvidia.com>, <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <willemb@google.com>,
	<shuah@kernel.org>
Subject: Re: [PATCH net-next 1/3] selftests: drv-net: resolve remote
 interface name
Date: Thu, 13 Feb 2025 17:23:07 +0100
In-Reply-To: <20250213075554.08a1406e@kernel.org>
Message-ID: <87frkhdcyf.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|CY8PR12MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: cae7f232-7711-49b9-75e6-08dd4c4bd0a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zMt205KnUIFG4vMZEGXpLO7i+/295ic/KLvVgCZ4izh5UNBv74bTMm9Uznzn?=
 =?us-ascii?Q?5pjySRrSJlPUJY0NFhMfb11y6LKyEJx7vvBkZmkrNULqT7DmgWPdAyDlMwK6?=
 =?us-ascii?Q?co+GsgQzKkvtD9oDXjdxgTU3GtEiJrt8NKhPz2WqwQjfpjIJ97NGFQuR2CIJ?=
 =?us-ascii?Q?lzr0KHHqEw7rWOcZTTbr37LXX7PebcSsUH1iicyPCES5sM5TYla05McKxtvL?=
 =?us-ascii?Q?hLpCoi8XI9YaF1Rpi6aW8msnNgACCSOtBXhAKTcesL0aNXB+6oyGU+aH2F6v?=
 =?us-ascii?Q?lMZRvC7NZlVx5BT83ipK60FsnZaiVyfnRIf0f0Hg7h0zSQtRisYgyKeuAjor?=
 =?us-ascii?Q?q26SMTSAaMgUqtwwlGGq3Fd3hpsUEUEL9OtV3t9UdJueWgSn6NEclW1nj0WF?=
 =?us-ascii?Q?SccD5UGNJGXUVbzJGFf4ZXVaVzqosaTEiU4BDIxswoiwHhJlOEFYALmA6rRS?=
 =?us-ascii?Q?4OSYBthscT9aMLWZbDIiIwXzTK9079yogJw/UmjUBOxpTnnrImlqM4bokzBM?=
 =?us-ascii?Q?bp9gg1x+0sz2mXOY90PGQZoD1nKbHUjrNZdUQaynnhhwt9T99qmgroeF04k+?=
 =?us-ascii?Q?jbyd/1yfJqS+P+a7aWIdCk7UR/RcZOfmZBM2K/z8MYtQgUPGuFN+uk9rxxYG?=
 =?us-ascii?Q?vFE+sVC6y0MsoWY82GV6QnaxUwE1hikDLC8n0PCsSbllLVAXDDB9++tBIUjx?=
 =?us-ascii?Q?F8zv/g1r/cduGtVFUAFyO55cldiyVTJUxpD7pRSepqdnvHV39nyLcdFHGcrj?=
 =?us-ascii?Q?qG03QHhoNTqJhI3r0PUAxZeQM3DqAKhgfZHPPxg8Hbn0pOzTcL1f2z32DW+1?=
 =?us-ascii?Q?esfS7CCOJMOgJ6q6IkgKK2h3USxdHAUw6Sa/WAkdfCw7jGdtwHkiQsSEJVCK?=
 =?us-ascii?Q?bS5XGN4pKgegpvzVLKZtlgBmpKmj+FUbVHK2hYNa7GN8WKPzwdy+w/lb1J0l?=
 =?us-ascii?Q?OX0xnKeGvu/G79hlQdXmqRXexerWPMQRm3wYVdRd3pJOXwUHOKfrTGdkUtp9?=
 =?us-ascii?Q?ysrYknVzj7gY+uFjSMFFTrmY/xyBZ/6ueL5Is1rzNcgm+ksZUwbr6ZG5pmiK?=
 =?us-ascii?Q?DUcnZa9UhtrCow337MLd0p1qAvmOwz6N8hW77gMWHw0ugyEjcWta2XG6awZ6?=
 =?us-ascii?Q?bBE/VnV5sA44ezw+AJzBVzHr7JzZvUtlhsPVx6b37s7K/TwSdvdG/ZxYxW2t?=
 =?us-ascii?Q?ErWF1vh5p1/wFuPIDnEsSvZuzBS/co1jdPWJ0zPbpNoWAtKFmtUnyoB34nnX?=
 =?us-ascii?Q?xxyy0udn2Aul4xC/g+jLwqDSFCUEcDXJ9uEwMLr7ls1NB7HLU9NK/kpo8OfD?=
 =?us-ascii?Q?HbF3j8pWndpK9WWcYv/e0ZKAE2s6ELrHL3OEeiLEO+WYqH4YFteWwFeeu9Qx?=
 =?us-ascii?Q?v9uuu2gbA04oTdeLqfHP3xvkAnw+qK3nzxeSQUJaz5GJ3sdp03fJ/xv3ecYG?=
 =?us-ascii?Q?B2lHXq9r5llY2ZW41zh3QT0kfbLHPZjefEUtflb3HFYsTJSlbDmnKxPcJhDH?=
 =?us-ascii?Q?TPmLymMcZamNmoU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 16:31:06.1638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cae7f232-7711-49b9-75e6-08dd4c4bd0a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7538


Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 13 Feb 2025 15:31:57 +0100 Petr Machata wrote:
>> > +    def resolve_remote_ifc(self):
>> > +        v4 = v6 = None
>> > +        if self.remote_v4:
>> > +            v4 = ip("addr show to " + self.remote_v4, json=True, host=self.remote)
>> > +        if self.remote_v6:
>> > +            v6 = ip("addr show to " + self.remote_v6, json=True, host=self.remote)
>> > +        if v4 and v6 and v4[0]["ifname"] != v6[0]["ifname"]:
>> > +            raise Exception("Can't resolve remote interface name, v4 and v6 don't match")
>> > +        return v6[0]["ifname"] if v6 else v4[0]["ifname"]  
>> 
>> Is existence of more than one interface with the same IP address a
>> concern? I guess such configuration is broken and wouldn't come up in a
>> selftest, but consider throwing in an "len(v4) == len(v6) == 1" for
>> robustness sake. 
>
> Will do!
>
>> I guess it could in fact replace the "v4 and v6" bit.
>
> Hm, I think that bit has to stay, we only record one interface.
> So if v4 and v6 given to the test are on different interfaces
> there could be some confusion. Not that we currently validate
> the same thing for the local machine..

Yeah, I misread the code actually. The goal is, if we have results for
both IPv4 and IPv6, do some extra validation. So the "v4 and v6" part
has to stay. (Plus I forgot that both start out as None, so you can't
just len() them willy nilly anyway.)

I think it should be this or thereabouts?

        if v4 and v6 and (not(len(v4) == len(v6) == 1) or
                          v4[0]["ifname"] != v6[0]["ifname"]):
            raise Exception("Can't resolve remote interface name, v4 and v6 don't match")

