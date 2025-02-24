Return-Path: <netdev+bounces-169048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6B7A424BE
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 16:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B3E188ADD0
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 14:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D50816F0FE;
	Mon, 24 Feb 2025 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X2ekcBcP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C0B18A6BA
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408510; cv=fail; b=iznELDq211DiDfNyFRUKgZMkisy2t3u6+URs4pkop8z24f4UWZHXtbru9XnISZee0BpaB3aBQewvNvOkXG7dLOzI/4bIT4Y8ZTs9kaaux/769/9FbVw368o71rOyKgmWt0KJ08W1D1jqqDDVXLSv9nfVXWFJFJWe4wpiTFrl8Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408510; c=relaxed/simple;
	bh=HDFD2ZlX9itImgJm4N2KRqHNa5sqrTORSxZXYRM0/Uo=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=EULqZOxS7XwpxIV+Fnh2pj4CukZMpvWN3G0qSZHazdcltKG3MZm5XSL6Dqh/A/wq/stc9tU+jUmIGVVGbT2XCI0k02Z9iPrx/gq+K8KsDwrUJQITAuAegy89IDgRLKR00VepgAPql8SaV1iLf+UrSAFFRmyfv0dof4ny80nJ2mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X2ekcBcP; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZGgAeSHatOakXSPIoFybaiecGhzafrUhFziduyfh6tj9R/S51nakLMI2agaeuS3VK3QzNzvuTCNQ3r7oQOdYUNqPtebDYtguCJKYmOYhsPQVBqQ3dhjp+2e8L+Jl+T3cNl3ATihMyCH7cGsyxk9CVBwwGAd/VONFj+EfIRXSTtmTgb5xOdlEspK25t1vU2zQq03JAhWx9fMQKLnZowCXqbXVPdWPQ7p186Xfkrg9/utjb9K2qLBqC7eibgwKTraQyB5O2ZTNG8/jacQZvo6k53Fmeitm9uOr0gRZZkzwnsy197KHOrKWJWMe+79JM8J69wfcNyYDE/YS0gvQdADTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDFD2ZlX9itImgJm4N2KRqHNa5sqrTORSxZXYRM0/Uo=;
 b=KLicAtRQw2UrVtjMH3PvRutfp890/ADEE74wSnBmkwT2fAr9bfykmtlIBI5dxd5e8NAn2AhpIe/zTf6uThPSu2FQI5WEY9rwIhkCNdX8VJOKH9Jl6YGm23To4ztca7tVpuhoMqN2839ZpiPuEJcLkw8ftSZIuvkIQSD6afHV5FeANi9EET9xmVFHgYE/AAZQonIxBWtsyDtrLpALYJNWsqovITCijjCMceTQiMHsYxuS0DUHgKkVDJspfClaJumv+NFEA4RtoHzcxbUQ3LbShI+CYwi6FvpikvbBPAn1Y8Fw5Mjqj7UhymcnLjuH+OVhfjO8d6YbA7KyUcJSlNhdaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDFD2ZlX9itImgJm4N2KRqHNa5sqrTORSxZXYRM0/Uo=;
 b=X2ekcBcPGIbALETOrOqKEL/dgxYcIxuKQtPhmj7AB+oOt/wq1SquhB3eNw1y/P3c4TJosnff8iLLk1dyEj9SZQf/931y4CyNPY65yq1AmOUaRKoD0SISOWyKh3AzHXne0QzmsaXkGzP28/seUtNB3Oc4FOMhfvqbNyaFEAjgRNIe1VzOuE4ApNnqJE0HR4ZRWQmr+TCWdlZUSB4qDFBvHGuQ8U9QFHR2Aflqh/YPHTmIIbtwdVWU9gty2WWgZaqnNB37EQiCz3YCS8wJP7+l5zdK7dxK/nG8SlXcQ5erQ7+yYfjnZyAq5b8Vp+ZHgnjNqR6/4tpaUkAiRJESYAa1Ew==
Received: from SJ0PR03CA0236.namprd03.prod.outlook.com (2603:10b6:a03:39f::31)
 by SJ1PR12MB6241.namprd12.prod.outlook.com (2603:10b6:a03:458::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 14:48:19 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::27) by SJ0PR03CA0236.outlook.office365.com
 (2603:10b6:a03:39f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Mon,
 24 Feb 2025 14:48:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Mon, 24 Feb 2025 14:48:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Feb
 2025 06:48:08 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Feb
 2025 06:48:05 -0800
References: <20250224065241.236141-1-idosch@nvidia.com>
 <20250224065241.236141-3-idosch@nvidia.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
CC: <netdev@vger.kernel.org>, <stephen@networkplumber.org>,
	<dsahern@gmail.com>, <gnault@redhat.com>, <petrm@nvidia.com>
Subject: Re: [PATCH iproute2-next 2/5] iprule: Move port parsing to a function
Date: Mon, 24 Feb 2025 15:47:58 +0100
In-Reply-To: <20250224065241.236141-3-idosch@nvidia.com>
Message-ID: <87bjurjt5p.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|SJ1PR12MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c9f3385-4a5c-48fd-0583-08dd54e2473a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ccKzxcdveIH5B7qfRKc8nEKiTZDkmGIfe0k/Hja9RbFCzw9szKFuwGv1oEtC?=
 =?us-ascii?Q?11cNr7IREezogikZE67lPAZXRHgN5j+ypWtkQ87IZ0D85/c3HCwIWX9nCm8f?=
 =?us-ascii?Q?VIdenHui1Tj4Z37vE0R8MqOZZ+CRLT/zYshuvHqwbwlDns15Rl5IMXI5iaOE?=
 =?us-ascii?Q?VeJhGXW16gzjetqNVuUOxzQx3DLw+cvmBW0FyIdhJ3c0GUibBRrZS0h6pgDM?=
 =?us-ascii?Q?lDMOVejA1Vk0bZx6/ffBEt5Dy11T94HcURzjHWydbcsY19cSHh9rt3w2esN3?=
 =?us-ascii?Q?a2OVJ94KVmoTp8FBaAwX/P2vKExLKP0RYMcprxYiP3nWYv90nBvEcbi7S1st?=
 =?us-ascii?Q?tp0zmPdj8fBILeNXl/ObcDClaVzWJE8x1dDu76YQUP6TMvZty1Sqs6ms5rVs?=
 =?us-ascii?Q?bKG6Y42tpHJILOvEnNfTXcrZn0JZHQg0MarO1o3TzOKg983m5+rkNCnZh/jG?=
 =?us-ascii?Q?rW2AXNxXcm+B3N67QlmARXId+kvxTXjDkWHzA2PiVvcUUfLfltVpLy1svpYs?=
 =?us-ascii?Q?L/vM9aQFygGsev1oOqrM94C0Xu9n5MPO4Am6h9iM4IV4fUZXWZYVfbbi81CB?=
 =?us-ascii?Q?u+bkxHLqn2Xp+gGYs3v3PkT5Yw1fLVlG7Q73YQsDmUdYtUws52a8i4Zqmq3P?=
 =?us-ascii?Q?PIsPepiSmWNuJ37+3D3HTJk1z4cH05l87fl/X+SUdMxwsXMPHyXjX4JOGSQm?=
 =?us-ascii?Q?f6pLQ+/O/UzbDGcU3RAn/ZJBhGGn3BT5q1v+AwHXzrDi5gvIWlOLIwSZLLnX?=
 =?us-ascii?Q?vVAoxGDvujL9KBpYKT3s05AIUgZ1z1KWku+XhEbvHIYLBHJgIGWT6V9kERNo?=
 =?us-ascii?Q?t8riad5c56n9c9YrNvJHRwJXhiJgTi3+PzP1+9rydvZGmZDfye3CpvmxXQJB?=
 =?us-ascii?Q?vYaKemXu+fSO7Ji3oULzDlcR0vJg5f5a5dy3XP0eA5EXUmbb7JZb399q1i82?=
 =?us-ascii?Q?Abpkwo/bC1/m1PMogPF4XZ/f1Vo2NI17ot5cdzJeTQUhDgPAYmP+dfOjVbMG?=
 =?us-ascii?Q?/Ey+bAuOW7P0ZHOCYAkMzdobZ6RFb6Z4+kwnEt18PdfuNAfVL1nQcaiY1S0q?=
 =?us-ascii?Q?rG1HFcU9dViHkUZesqJI0QHPeVHfwX9OO7CIcmXRuFFjxxbBVn3EaGswvjhe?=
 =?us-ascii?Q?kvqc77KfdUXM0rXyVKIufHP7giKCdW64DaFLn3epTHINSSD88uL9rVSevduF?=
 =?us-ascii?Q?92VbMAzYoDwWaEjV8kHkUDtAqC0B9yDpchKZZ53AHV6oXxinfuXvMEI74EtO?=
 =?us-ascii?Q?wQ1gA4k+aedom7TDM171EzSrgmcLnzBDpsvpZHPU0jQk+psHvgfN11AR8wqb?=
 =?us-ascii?Q?Nwk3dWjeiFUpmqe9ENjHxalabfg4UrFx5m0rcg2iWUHS9EgXNopvnsm2t6/u?=
 =?us-ascii?Q?MqG2htoS/FTMxrjZ5I5RV2SSxZIZG1lijWRSGptkgmnbo58oy6SAv8hIzZkU?=
 =?us-ascii?Q?sQDCHAJd2xuSozOd8fmbDhxnfznLs96EOijkAhSOwrNW4P5vE08qblxzvs+S?=
 =?us-ascii?Q?ycFboVq4AIZ/G5s=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 14:48:19.0180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9f3385-4a5c-48fd-0583-08dd54e2473a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6241


Ido Schimmel <idosch@nvidia.com> writes:

> In preparation for adding port mask support, move port parsing to a
> function.
>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

