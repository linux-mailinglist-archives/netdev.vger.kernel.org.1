Return-Path: <netdev+bounces-106833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F759917D68
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 12:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D0831F23A6B
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 10:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825B3176247;
	Wed, 26 Jun 2024 10:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B8QTvucq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E9517B4EC
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 10:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719396710; cv=fail; b=TUc4UlLJZWPicnk3iC3gm9uGh51IK9dRvTFCIzA1rZlSMGMN9xzEQ4YYS9SQdkrsGx0nILTUABbocMfRJHkA6PCNlQyKOm1dWJeQOYWwaFF4JmXHALsThMYmXS+wDDEujOAejrDbssKzKTBa5k0E0TlmCjXf6WxPTggjHuLjfvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719396710; c=relaxed/simple;
	bh=koQyHhFJ+ZnJSXNh17i2aAkED2rDfe2kxCXNrfP31E0=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=YXJnfNtUkPxjy9h5/eZ2PZ2Yucj6YK/8iSfUXn/5n6Hnl+3K+PCxGNbDC9wTxoKcpW74s7LYeVgFYDFh9wtT5I79tO5xAzUrDRL+ynHCOMn9GodEqLyyTsUaiQpTe+2GZpPytj4Y0dA8mXtp3a9dYDHc81a2Zjr+EyINelSEXKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B8QTvucq; arc=fail smtp.client-ip=40.107.236.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTrdxruMYdmFhbpkhtui+nPwbMXvBhfT322cg+7tFdVGvGvqcFyUMPzDE5CLU8XwjNYMZ+G5ZzLyU47Z0E86YuLS19cX5yeZOH0/fVs20V+Tpd5V2+0PNqdlDF/s5AUm4yDQiKsAVqvoTLcxrK2JaKMHY0thYv3Oktx4lTcNggfMqxMqCjdLKkiTlr/j5AYeFA+8ylU29TFLDTrU/RJCP7qXrx9uma8fdX80gr+C6nzld8A+BEIaIbR/5bVgKWp0C3JZjGihV9XIqSiBSWJq23WQOMbqiG5sfx4VxsA5u6k8SvSIGgPsRXCRh+9c9jnkaKBWBh+JPMKpVPFegDhJvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koQyHhFJ+ZnJSXNh17i2aAkED2rDfe2kxCXNrfP31E0=;
 b=PWRNdRQKReKPPnFpvM2gl/ODIN/H0pzXaDwoK+SDAqkOoey8HRPJNIkf4E+l4nRdfeotITtBN5qL6aj2Ho/7k0wxruw8SqvTFc0gMx4lMfaPwoQdmyeu0FPYTu+nc+hWhOp2AKtc8nPTXJNa+5hK526swrc36/ngF1NylbRdcQ4Xw4tN9KhyTWamJyfi+DYPR8GlkRiGunZXM8R9Z7JRR8w1CUszPli5Ryq3X9IiwXaoMV2xmxgqDJtKgPfFak/5LHKzSIg9KjgpSTeueDL/5z3pAghhY1CEFZbxVF/Xv+8Bnx1T+/rGPN2vPCTtFdDOJg+lZbUqj1QOHstxmiOnPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=debian.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koQyHhFJ+ZnJSXNh17i2aAkED2rDfe2kxCXNrfP31E0=;
 b=B8QTvucqzZdIXqvyL8fcksiNnZM1HPi9Z2TUpBG7p1xjBPTWeJBguCX9Kk5p4lkC0f+vWDEmBpAPzxSWxGvXowiQNa6A8fbfmzbCDSfk7rmsNa3Eu4uZYyj5dh4WxktNjakGw31Wd/MzvhxPhV9yIdXxr9d8o63E7An/gGsRO/h4E8MCWn2PaiNswfp9zfx/5PwG1nt1b56VnHbZF7Dd6QdUvG2QQ2ZOM1RNpkROZag1imJ/z/6DedIcn7hXDNuG4XoGiP8j5xjLOdtO3/QuQys3V4mfz1n7dEwy78oyS4Qp9rXnmbNNHUF8bN/EGllboFh1WYS3JPV0JhXSc0DUPg==
Received: from PH0PR07CA0033.namprd07.prod.outlook.com (2603:10b6:510:e::8) by
 DS0PR12MB6487.namprd12.prod.outlook.com (2603:10b6:8:c4::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.30; Wed, 26 Jun 2024 10:11:45 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:510:e:cafe::db) by PH0PR07CA0033.outlook.office365.com
 (2603:10b6:510:e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.24 via Frontend
 Transport; Wed, 26 Jun 2024 10:11:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 10:11:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:11:29 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:11:23 -0700
References: <20240626012456.2326192-1-kuba@kernel.org>
 <20240626012456.2326192-4-kuba@kernel.org>
User-agent: mu4e 1.8.11; emacs 29.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <willemdebruijn.kernel@gmail.com>,
	<ecree.xilinx@gmail.com>, <dw@davidwei.uk>, <przemyslaw.kitszel@intel.com>,
	<michael.chan@broadcom.com>, <andrew.gospodarek@broadcom.com>,
	<leitao@debian.org>, <petrm@nvidia.com>
Subject: Re: [PATCH net-next v3 3/4] selftests: drv-net: add ability to wait
 for at least N packets to load gen
Date: Wed, 26 Jun 2024 12:11:11 +0200
In-Reply-To: <20240626012456.2326192-4-kuba@kernel.org>
Message-ID: <87h6dg9fp4.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|DS0PR12MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: c978aeb2-2001-4988-4d2b-08dc95c861fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|36860700011|376012|7416012|1800799022|82310400024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5q05j906ePhZZXSo/ljKcgnFwpIXYDMcCk71GtKfzOdn880bYF9cTJFRZpQg?=
 =?us-ascii?Q?/87GUMaJwlw+O043A5CKP7xcL2sl0WcENCcfRtDWtsWSZ3xaezez5jsHCRnT?=
 =?us-ascii?Q?Sh/noav9mpt0UguBB+ChFtHYrVIkii9zUPZxLt4zIJiyxpeMAWEsYYfRwBrM?=
 =?us-ascii?Q?a47ndhelKjidTOmCUsoTO9qxRmwCopVlAOPdt0sG+KsQI4kqlH7MBTsrXHDh?=
 =?us-ascii?Q?WIPQiNzhi62wQcfxzWipkMGdSEDBqf+h5ATrDFR4QfkXi6cwpv02An1YFQw5?=
 =?us-ascii?Q?fXkQQVJ1SSR/EfhhIuqrLl3JyYYUTxG+bahxNWZbCp5KQAhUumu5o16jYwqL?=
 =?us-ascii?Q?iH/eHaCs0GC/shLGwWIPupqvX7yYP89Ek9/2nxUBZaC6N96kd+aSQxF+K3fm?=
 =?us-ascii?Q?l+RSW5aooFT5hZm3CTRJiKtDxHaTPeoZkZtIo7K2K4ECdxrEq384b49eSE4l?=
 =?us-ascii?Q?DKMEz0xza3eFk55tpXt1WJ+xVgVYB/G+GI4Gx3T9QylMCMSulc2iOsRrSx4E?=
 =?us-ascii?Q?plQeMD/5o0NL+kFIheHM5oFH5hGrOtx3NMjxHGXSXi+sRjhQ+AIkcjZmB0tt?=
 =?us-ascii?Q?S6RhbMsAZAkJrwtGyKb2j5lVJeUfSbDQMMxzQKLy+YWmcrRVYTL+UHCA0Ui0?=
 =?us-ascii?Q?1RadE1xBOB3lBJB1U/fR/acfoM34nOu2zt/IRcSZsoeuN69P+3EIwqk+5eLG?=
 =?us-ascii?Q?W0lkcn3mH0Mg4cEc/OGiaJ1xlkSeJJCR+ld/Hy+AC0GYccv3Ot1Dkyg4EB4S?=
 =?us-ascii?Q?Ukqn8AeASt7XC2iUW5ZUlq7ByLxyKOAdSRG3Q9oawYI/2AJRc+N5SkR1ry0N?=
 =?us-ascii?Q?b6ulC4/haFgAaWHpOTvUvictzgL79cQ2ltc70VGgXzEn2YdYt3W42rjJBnI9?=
 =?us-ascii?Q?e6b5/vw9e4/1exd5HSqQJomRNUTMENPCWLBUDFZ1evv7ggBaR1M9N6+PYjAu?=
 =?us-ascii?Q?N48XYL20VGQzv+Gc/qnUJDuMUwVw7aCnQvxhJJp71mZeOzzbu58yPO+wFFQH?=
 =?us-ascii?Q?DT6uRAxSUkf0f2bMWvLUPbbKu7OT7o1RrOd9KkKeMT4N7uDWUyomE5sd539K?=
 =?us-ascii?Q?iD51bMgQt7joSaJ+zIKky6Qi9Ctip9Ybwh8/PgBq+G71tfqVkMoY0J+KZp22?=
 =?us-ascii?Q?JdnhodkSofN2qhrZm/SA2hb5qaGkhbxfunu4s+QRzS8cChKAfzO5EQCqdwYB?=
 =?us-ascii?Q?QKZjHIpu0TNedzYq1Tme9RMiEgyviR2EfxeRxDvuSzA0lzN4oxMPlSdmLWXj?=
 =?us-ascii?Q?2Cjf0KP7iLeMA50gHpmnUmkACYAvN/Q+ulOvfpMTb6LpSTyB2wsx4IeapYYk?=
 =?us-ascii?Q?DHv24bOO4cjrG+Zd+CPC2QEQ1TlWi00viWW+RyzwJ3E88Drb/84qB0zy7rpi?=
 =?us-ascii?Q?G73bylNlFLxY3bHH5+wBv0cwR6sfT0J5MMqV80XRVtSCQy7Evw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230038)(36860700011)(376012)(7416012)(1800799022)(82310400024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:11:44.8752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c978aeb2-2001-4988-4d2b-08dc95c861fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6487


Jakub Kicinski <kuba@kernel.org> writes:

> Teach the load generator how to wait for at least given number
> of packets to be received. This will be useful for filtering
> where we'll want to send a non-trivial number of packets and
> make sure they landed in right queues.
>
> Reviewed-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

