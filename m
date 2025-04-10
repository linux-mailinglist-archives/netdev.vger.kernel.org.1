Return-Path: <netdev+bounces-181143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 410B0A83D5F
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 10:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C1607A79F3
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 08:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAC720C471;
	Thu, 10 Apr 2025 08:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i/THSIDT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCA420D505
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744274569; cv=fail; b=RVCi28G27E68TaNuwNSqT0UeaDW/xj+uUwIPe46UPZW0hKWxqICQr37YgOc0Yrht+ss/9RgCsPEcSAyiht031s+SjwzsEZd98Sc96TfvWa8cCiPysXmxgACwbg1dmotUfMY9AIsbtnaf4YbD6VSMbTSjBDYQTGClvCChtRZ50js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744274569; c=relaxed/simple;
	bh=6El8tI92njLAiespAmqsJ909u7ljGzSixH68SASGyeE=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=FBcLYG00O5QDO/kyouZyg2Ti6ywFov9NrTiHQnoE+bUpRFjhL+/SpXUGOI1u6yNKFwG7PvLVkqir50EqHqe4HmVEyJ8rSaiuCx3zU8p9uBA+9S3TvvGByouJP+V60CdoGy7dRlqxsgSY8YMuE5WD74eFgyaXyRXv3X/Oz3QR3gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i/THSIDT; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdCoRevia5/Y7TUcWWcDs4yOeiSi1Oc5grIcpUpkMm+PJLyBmRbsWUsyAPJsJeMQ+k4U3u7jLqHyelQO9nrD2GT1NXD3HqZM4ium70fP9j9bmVL2hFNiVQVPYOAw76u83k2FGG/2oN3lkjdjIOadGik3Nv0j3GTJ8dwMcs+LQCt7TqNSAB6B8QNmuM94U7S/mxGh2DtigDo40u1o8C2t6Hk40ZvZMA9c7ySHp7go0FMhIXvEYJGuQVSaFVqIjcQSxLNTrbkBrMRhGFXMqLGmLbKR+1HCTj+6Ug8AKkWY0JWM8SgThbakdUqqJOz7+7U9x8OkvVVwKBX7hYOieroUKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ego57gTFwn/K4BGCF2Q7ld4xpgQpl8svdSepRzAWLZg=;
 b=IYtxEMhQTe+pIopGZvc/O/z4xhagxVXEFuiIHpf+8oP7LwrnsxPBeIX2UCUpWsZgdAsLGsS3beDCkAju6StK6Hzhluxdxey8TanUiWy/MckuQp9D2eWoUTsGujHwxIWE6yxTfZ/BTnqAXZsDZ2hKDZY2QyjOZE7n92ylGwMNl4XUoXfOyztxwvSRgZhQjQ4tgXW1jijTTk8IliYHP9Kl7wxdScqsG3THmI8vW/JqSo2+bR8UHmiN4kLYhmMypZXg3YWo9BvXD2xdlBslndFl2ihT2lp9XgLFSkM8RKh/tOLQVmwVbTgmrSRRj4vbEAW5voPOo/0y78MtCfkVoUmVnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=broadcom.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ego57gTFwn/K4BGCF2Q7ld4xpgQpl8svdSepRzAWLZg=;
 b=i/THSIDTOf2CAcNj2G210lpblSK2Jpe+PYbQw/3g3gpBbgWBXGj3HaOV0OePt4HDnjmUl1suuu7xu0KIH1N7SZLr3q0yQOOp7EGt9ZY9VJUyfRsAIv/PQOTUhHtqEvAI4MOksz8O0afqrbPkvgIbq70gPzcNELO51l7+cQg4OGPIzN9/cdfi15u+mlsOZS2CQrHuKE8btOoZb7Bk7dArmjb72CecqOQGq2/dPrmot4y+zitLX2onN3UF01wq08Me0WIcDrNE5qMqK+RDRRqNKv/RDDz4mGpyQzH4uLRZEhC8Y7xOhaSqn2tVekQVm5wV/Omzxk2KH2t5UxD2notBCg==
Received: from CY8PR10CA0014.namprd10.prod.outlook.com (2603:10b6:930:4f::21)
 by CY5PR12MB6322.namprd12.prod.outlook.com (2603:10b6:930:21::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Thu, 10 Apr
 2025 08:42:44 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:4f:cafe::a9) by CY8PR10CA0014.outlook.office365.com
 (2603:10b6:930:4f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.24 via Frontend Transport; Thu,
 10 Apr 2025 08:42:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 08:42:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Apr
 2025 01:42:32 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 10 Apr
 2025 01:42:26 -0700
References: <20250409112440.365672-1-idosch@nvidia.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <horms@kernel.org>,
	<danieller@nvidia.com>, <petrm@nvidia.com>, <andrew@lunn.ch>,
	<damodharam.ammepalli@broadcom.com>, <michael.chan@broadcom.com>,
	<andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH net] ethtool: cmis_cdb: Fix incorrect read / write
 length extension
Date: Thu, 10 Apr 2025 10:41:40 +0200
In-Reply-To: <20250409112440.365672-1-idosch@nvidia.com>
Message-ID: <874iywxv9u.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|CY5PR12MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: 77de0de8-d91b-4fbc-0d76-08dd780ba9b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7ftRK40dk0sM8rLRAo6fu/4DyA6AAGiyACmoVLhov6nkyVKZ4tHPZybZi92T?=
 =?us-ascii?Q?DJ4KVxMYtm8ATjBx5cwd0vPBXaPFkjQTDDc5yfaEZ+Ex8wkeGu3gFmo+ZDP8?=
 =?us-ascii?Q?Ua1tFjNvTy9yPjCJTjX/p7gj8RhJlM3sYf4wz2HfJ9OV7gmeI3zwe5hHsLF6?=
 =?us-ascii?Q?V2tX/WXe4Xkbg+bjZOYz4RQY6/ZW+Y2z/WDU7cdrKVjA9+2tq5WLnWpmsRRo?=
 =?us-ascii?Q?bh20GsRP46iFYszeVZcYlMDjMZGeeNbiiY3SLZ0TfFdH0674ATP7LujIpCXc?=
 =?us-ascii?Q?6/Ry3z2Me+HrrI3tEa9s5496y4zaNq+XBcSMmNr2bEydinBF1A+RY+MJ/6qA?=
 =?us-ascii?Q?DUFuID+SxR5beB7JC+JVlyCry1sJWX64jNbuE/qwySEB6TLJoIEDXPdFp/Oo?=
 =?us-ascii?Q?UufCjRRTmx5IwL+aCiLgQ/cSkHVlIHJPf6QXobPHLVrAS1oJKKWVQ7ZWJtwc?=
 =?us-ascii?Q?ZptvnjSog46/u9fYOrrsR+vULOnd4WNQOKJPGrps8vsWYfBy9R5Fz5D9YJi8?=
 =?us-ascii?Q?VBcRb90b2PktLo6uKRlY9PTVQ+JcjljVd7C0mOyTq6qHSpRHbhesgDMfK14m?=
 =?us-ascii?Q?fSEzzAqb76saOmEVCPrhpTkiPUzHHr7veDT0tjX6OlzKgL9BsoCLAiHidh4N?=
 =?us-ascii?Q?PR0p6IUuoJOWIXwYrE+Iea/8QY81WGOpzmqDbQHfOYpm3qeaJS+PEIrrGg+3?=
 =?us-ascii?Q?U+Mcyur0O9+K9bLkWpVFGjvu9cvEIjeGIR7Tp1r2I7zUlo3M8ZL840DHyGLM?=
 =?us-ascii?Q?pw9/YEfTsjYcdq4emwVhWedZXJ7kAB7ffzWYgsjOJ8K043D9/NZzv0gcGv4j?=
 =?us-ascii?Q?k4rX8culATHwtpHj0X5xZw+s/rHrSXgm1jX8EXi9Uc8TsmQUTpeQ/WueTmQm?=
 =?us-ascii?Q?Q0V4TFNt8is57081AGjIBqCulEZcedAkNvuEASSYDm6HCbxtMM3NSOxDWi2L?=
 =?us-ascii?Q?XaQ7q7ZHQi2zdN2iF6AZu1iMyOhfHMB8GbgtPs0rTrBlK+BRRXS9oyCUkHMG?=
 =?us-ascii?Q?FLDg9l1irgBTvI6LvIIQZFkrpexIUqudhSMrthPWGPWeAnnuZHL7HtxgLHNW?=
 =?us-ascii?Q?8aOShNzEv7Hsy0V5GYBghBuTb+Ie+odIaOq1QAoGu/5zldQ4GbW4KhwSsrEK?=
 =?us-ascii?Q?fM9d5zq8YtaGFe28Ed6vJCEN/3Q56mAadmUhyNBhZAK2BPz3IGke9W3vA1Zs?=
 =?us-ascii?Q?mxWqY2UWJjuXJ9mGmBXOfOOgqGlhXr+YV1z3Z6rC5TOLuUqQj8R/4l0RGVOg?=
 =?us-ascii?Q?PolOxScljOha1VLaEEGYcoiizx+cdRTsoQmiuu7I7rJPPsNt7+SfxFhCQBsZ?=
 =?us-ascii?Q?yMJa4nZCk0OuwSUVahXuf4wyS0Ydkxg1bUkogs6UT2j5mpqjVJKUa4AabXYZ?=
 =?us-ascii?Q?fGf4a+zzcULETO3aMKQgNMgoSgw66MGIBvB/Tqhb4iHE+QW9LLNrvBZQVMwm?=
 =?us-ascii?Q?splkhgN8VSJpDCWzaPHnzkZ8LwrbV3dBVuhEcKzbfscPttfiU2gxWinUG/NB?=
 =?us-ascii?Q?/Ethc05QW7bXCIfFr3Ri/JdEPbMvYJK3tqzABVVpO30dmZirQPxPa3+ZwQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 08:42:44.3147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77de0de8-d91b-4fbc-0d76-08dd780ba9b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6322


Ido Schimmel <idosch@nvidia.com> writes:

> The 'read_write_len_ext' field in 'struct ethtool_cmis_cdb_cmd_args'
> stores the maximum number of bytes that can be read from or written to
> the Local Payload (LPL) page in a single multi-byte access.
>
> Cited commit started overwriting this field with the maximum number of
> bytes that can be read from or written to the Extended Payload (LPL)
> pages in a single multi-byte access. Transceiver modules that support
> auto paging can advertise a number larger than 255 which is problematic
> as 'read_write_len_ext' is a 'u8', resulting in the number getting
> truncated and firmware flashing failing [1].
>
> Fix by ignoring the maximum EPL access size as the kernel does not
> currently support auto paging (even if the transceiver module does) and
> will not try to read / write more than 128 bytes at once.
>
> [1]
> Transceiver module firmware flashing started for device enp177s0np0
> Transceiver module firmware flashing in progress for device enp177s0np0
> Progress: 0%
> Transceiver module firmware flashing encountered an error for device enp177s0np0
> Status message: Write FW block EPL command failed, LPL length is longer
> 	than CDB read write length extension allows.
>
> Fixes: 9a3b0d078bd8 ("net: ethtool: Add support for writing firmware blocks using EPL payload")
> Reported-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
> Closes: https://lore.kernel.org/netdev/20250402183123.321036-3-michael.chan@broadcom.com/
> Tested-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

