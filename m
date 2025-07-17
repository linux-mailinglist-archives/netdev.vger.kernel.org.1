Return-Path: <netdev+bounces-207829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CB1B08B54
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 12:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A751A61F83
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 10:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFF029B23B;
	Thu, 17 Jul 2025 10:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ukp5hZHh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2D07262E
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749565; cv=fail; b=GP9KuXiLsorw1HtGCY7dj2m99TNHM5DGFM4EQwWlCOsEdS4o/l8MuDF+9V6C7DTBIraefAnrwz/Z6S6YnKrusuh9Ags+Pex0qr3hue0Dm0HSn2nWiGI1s6QX9fAnCwhij3O1eoryAV8MwCtBeYQxV+qV/Nk9pGlNYW1ElTENtCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749565; c=relaxed/simple;
	bh=NOxaiTvv5z4YD8ZRfvOqqy+f/pSEro5jDvBEWzyGAEA=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=HGMOKGJHXiiHy0Kg0TL+eO5swQtTA/CdxaWigb6h72edeTkBK/Y+a5b5ZSUAyp6vH1JVGKve4wu7O4nA1CA24NV/OAlJgzEsvF6IJBYjqgiXzqKihqV0euPqJKQ5XbVyoKfWVq8pH1F9XxRB3Gd70LmyDdAfAI2dGombNm/U0Jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ukp5hZHh; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jM2qn7GBrBqnsu29lXFee+FW34Gj2U+ABTBv6FKKADCf+UKTZCFMNWOKJ06lW+oyf27FzNvsPGb8Ev2hyKps73j8/+nthDZnyHY1m4hCs3obcfN6iKFuZPu6FLAuXeyLV2H5/FVEjma4zCc2mvov+w+V+eBJrLOjWP3VVk+Yf73B9Z5BwQ+7JH9eZC87uj1c1dsJgB6upQYcpKaByga50pcT+dIlHxtbj42A2meZQair1bAMZ4GCyjdGCl8f53TvTS0287eDwLbV5B3upD+c+zQcThtNqKSz+/NoqbN7MH+CEZ9Q8JvKPcz2GGAMrO8zGGlytEWxSQYyGHIfS3tx/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOxaiTvv5z4YD8ZRfvOqqy+f/pSEro5jDvBEWzyGAEA=;
 b=DQk261wHgiPUU0Snh+6pW4Swj6Qkqm1BXRVeUwVM0lkiXQ4namtZJ86Q11ScDCqeOsoUAljt33xcqt/RdpeBfymq+dIyEEN6M6nrnZV+kC5A9gDV5ufaO7g411VLrUXZkbO6DGZ70IhHs+7cO5tenUiBDa5KzVOZp1wxjTbHP+mS3GGR/hUNja4sLaQ8SJ8kBGEXwFbsqP3s6nwC9VZcv43WeHYecuNWibG+48nQYZDs9KfGxVR3Xp55JrIzzu0xaKApjTJgWzmeZIPOf1OAOcgKqt3AEIH4ZMWrUH4TpUE0ua7Amb6TFrLlA8KL/e8uHsVevz75LCtIsTM6/Zq6RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=fomichev.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOxaiTvv5z4YD8ZRfvOqqy+f/pSEro5jDvBEWzyGAEA=;
 b=Ukp5hZHhoYped+GDutetlD1/Fo+fCUesKMfTKJuDGHXo1LbposEvdp0M+RGdaY6KbYKOiGq5RC88s3MqbRkyQar9PTLo+K6OPxLcgyxyR0kElgY4/ieG/4YpW9BCDpn6nhYooyhpXYIwxfClqXf2lcWhVCzGLnutfhJz/7LGfrVcWxznUMuZ5xtVVTharo3CD61jWR2OuGuWfl78wwh5N2dB7wkoiukiH15wotk50Fxn11MvhkGMR7LSmdMxpyxl4MVsSgO7AlzYqIRTlCp635JsaQ7rY7DqfSoV+ms/2fBj9FAvdboTzUE+GpNEsLPP5UXBDyEDORPusm6A7IRfYA==
Received: from BN1PR12CA0008.namprd12.prod.outlook.com (2603:10b6:408:e1::13)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 10:52:39 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::79) by BN1PR12CA0008.outlook.office365.com
 (2603:10b6:408:e1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Thu,
 17 Jul 2025 10:52:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 10:52:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Jul
 2025 03:52:20 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 17 Jul
 2025 03:52:14 -0700
References: <20250716205712.1787325-1-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shuah@kernel.org>, <petrm@nvidia.com>, <sdf@fomichev.me>
Subject: Re: [PATCH net-next] selftests: net: prevent Python from buffering
 the output
Date: Thu, 17 Jul 2025 12:51:07 +0200
In-Reply-To: <20250716205712.1787325-1-kuba@kernel.org>
Message-ID: <87v7nrcco6.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|BY5PR12MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: ca29dfac-42e0-4cee-0b8d-08ddc5200bb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2HDqMibnCG7mJuXTmmVnGnTEp1kUhw31+uCA6bUEWE0X6mwXh7hCwwVuTHK+?=
 =?us-ascii?Q?P7Ts0n7a3ahwTbJExu7bqoOxaGCA2hane1lbiQzZzQTpTvWhq4jRJvJYn6fj?=
 =?us-ascii?Q?9I/HiG6OtUDqP6mzhFSXid66Q46Rv1bPhLR1pAh6CfbuQNzXJ6g+ZnV4Es5N?=
 =?us-ascii?Q?W67mOYw3J2MX9uTAf3/5tQCQK7Nvkgk+ZFrpcrgppCoY1UMRuWrrgdhvczQ+?=
 =?us-ascii?Q?cb+iT+a+lrSZsta30jMlO0ayBIFhRlMpQyCjYktwMniJkQeHFbBZxdl9CARV?=
 =?us-ascii?Q?j2xjTm5hzyLselEsw2c2kM+Wu2u/B2oSpGu3JH4M4RDZA19/5s6wF5r1jXXi?=
 =?us-ascii?Q?jW9h4pzozTqguL70vAriQAlRLzCICuZkZ4tdoUOK3mnYQT8KOHT/QnFjj+xA?=
 =?us-ascii?Q?siE4AROY5V4lTsJc7hqGGhGDkLQziU7sBjU9kNFC1mJaoB2BT/ThCVjyO894?=
 =?us-ascii?Q?cPkz80UYv8Nusrism/Vg/zdI+xKhRi8N/DtCzOhXdfXheTnBJi59akOBfo4b?=
 =?us-ascii?Q?b4vKAbLC+AtMtHKBfAXfeJw4CPLJ6zGdZiNVj6FX7J/X2pYQuFOTU8jNoHi0?=
 =?us-ascii?Q?H9h/m0uxDx3TrQC2Pzg32jW3/eOQzLilxi+dhTXt2POjuJQx3aM1jBa9noqp?=
 =?us-ascii?Q?uWC+anRKan1t8VZRfmEQSRA57qUGYtguJN+kZSgp3kJuKogTBO/fPdx24uvo?=
 =?us-ascii?Q?MISOXMN0v/y/CU055GQemJBEsvZZYg/OedxwXegztjQGD0pPfvCEqdWo+WB7?=
 =?us-ascii?Q?CILbbJsxXfBIbinEnK1EkgYGzE7b/AvLCxiJqeCbVBYq00O+eMhzhLr1Xc6Z?=
 =?us-ascii?Q?bL8Quet50g8agdqvpdG/fJdkMVQsHVVC05EcPDHxyTJ8LscXOvelsswKPQ4h?=
 =?us-ascii?Q?CNpKQ5YOIKVFqb75GZJEdR+5dKnMU4+2+tpt1/o/CFbxiOfMVGyIv1LIBQ1w?=
 =?us-ascii?Q?gA1oV0xaODSATRUZ6aKaZhJSsyusv/0/mkNdlxU+rov8OmUBYBVcHTe3AlO9?=
 =?us-ascii?Q?tXLBbSkPJajUUJx7UpQILhNneLXWmBaC+8/CGWT7u4SLdpTKa+HDf1PC2E8g?=
 =?us-ascii?Q?c0IfdT1laZj0XO4e/y0VNE8gExW4t6ObwVnzNNBdErKjv9MMw7GOjHZeDcIA?=
 =?us-ascii?Q?aZlDE0zhd1n9xxpGFbAe8fLswhVOxMoBvy1AjLIkt++/UlRYcSM890O8PL1g?=
 =?us-ascii?Q?97dLyYOyeEC0ygMMu+b+b3b1bGVr7rApIjIRBZhc6AxY4VwJuNvHd9gfAZzc?=
 =?us-ascii?Q?y4xVqLImlvupleFTVhwgyMHVe8AijAanEMRbuQAf+dR4HRvSh8eCEfUTLYS+?=
 =?us-ascii?Q?qgA40Z5699ThWcunautI5jWRgaYzvZTheEKtC5kd7KWLUsFFTePj6bZqOXgD?=
 =?us-ascii?Q?90Xc2yXnc0mCBV1m5CTrgJb3aawhPZ6ddvrI5Bu72bdl7Kk5wbS0WjrTSBnP?=
 =?us-ascii?Q?6nmXFq/1Z9bDybWwSlfc805KqP11aL2pinVy1OYsRZdk5jWlhUvbA+8PFW0r?=
 =?us-ascii?Q?KH33MU4xpjw35R+RU+L2s2dfnOT3d+6jRJty?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 10:52:38.0743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca29dfac-42e0-4cee-0b8d-08ddc5200bb6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307


Jakub Kicinski <kuba@kernel.org> writes:

> Make sure Python doesn't buffer the output, otherwise for some
> tests we may see false positive timeouts in NIPA. NIPA thinks that
> a machine has hung if the test doesn't print anything for 3min.
> This is also nice to heave for running the tests manually,
> especially in vng.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

The flush keyword was introduced in 3.3, now out of support, so this
should be safe.

Reviewed-by: Petr Machata <petrm@nvidia.com>

