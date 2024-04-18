Return-Path: <netdev+bounces-89064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CCC8A9541
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 10:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52CA71C20F2C
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 08:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BE3158845;
	Thu, 18 Apr 2024 08:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U2NF+o7f"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436C1156F54
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713429934; cv=fail; b=bpJECwIYFC7RDt8CUIvI2/4yMKEm00Nrn38zIEHpdq+cfQff6BFIVlyOpuzG3GxVs7NBfhx0fuUpOZy3OqBbKGrKGUzOf1uenkdIkADdkI4x8TUTch/ogNXTrAfdZTb6X5w+gu55cHXaO6tfPgfds/pbJJoM2hjdCeLRhGGjB9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713429934; c=relaxed/simple;
	bh=Oh8SNC1Zxq79ZIIIJubX0kFxMZx5RV/fPuAEPHIxyBI=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=F747KjY+l4pUUbWwOowOnP5MKEwmF6NSXCxNcppluAU0jcsnCNVmTFw8zxbJepsr7a5yKpzOC4zzm5V7C6qbKF1YPaNXvzcYkSI0cFI0czw4UBw1X3TQoUB4jyTq5ti7DYQV5ODjIO2qKFlvuTV4WSLvnP8cfiN5efn2rEo9HQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U2NF+o7f; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBJZBfIN5FAL9bJ4PrQgcsgsbwnR10hG8ZsAqwUcUMQLJc4UvQ2PoTOy1uydTGj7EEAjvPJmeiiJ2PR2506L8rn+MsdKf6/zUe1CNcdNQAQLAa0Jn6ia5QqFgeOafdjdw9sIWgOnDAWE40BZRPxm3PQ3w192eXckTBQPI4WCELxqlooado/Y90UG6yYQ7Nx98knqrsux8EDxpj5ucNTmyfiqR/AyvpCXaeCJvcrabnsia0hLydWo6tGxnIL+VtQDhBlPgW3ZAAanGck4e8mDbhtKJScCHAKMQppmNYc9TZLz0MfHTmUp6FNKm+4W6YSyTWyst0lSLZS1FB0TWMMA8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oh8SNC1Zxq79ZIIIJubX0kFxMZx5RV/fPuAEPHIxyBI=;
 b=nu19PVMQzN64DT4qWW0B686T5qrJj4Z3f9bAoqNd4Kg8pqwq6Oj3StnI4jM+GzfoTs1o/mrUPqJb/H9OALSCKgt3VmWqknUB4Ehvyhev3N6E7e6UO6Gu2Vpu1OdQ9N5AShIoESfO5ysDuhqubNwdWYNyfmk5b06X2p5oL3bQKRQdGiw3bVsMJgIDWdb1gPKiFKe3sILbJNaBos8mcEhUH4qXswKUtBJxtqFSOOM1ldhG2eGayCRTPJjQ4Hm/BW01gD9JijoB6skCc+Wl3yltF0yDXBzYbfqpJ8Ed8EetmH/ghwvZ5JkS+tlqCdNDT0qQC1gx6lw82Anu+SU0VyghOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oh8SNC1Zxq79ZIIIJubX0kFxMZx5RV/fPuAEPHIxyBI=;
 b=U2NF+o7f4/1aLPz0y0lkQ/oLyBQHY17XevriRaks0rB8J5kAQXZF1x8q1cypGHNLy/OcriMZ0jU1CdI6G2vMpzsvsXGZHjxGRrvAUQ8wShRT3CEIcp949orseYrtugdqe8M6xjRLEouGIQtS9m6GiqLTd6x7FANYs80aArAECxPxg8uPVTzMT40zm6aC1C+8BoGc81/ZDmCQOlh6gI+mZav2jhsaDBefAGB7P44qi1TEPjNOm16Gn05lJePd+FQYLSztuYdF2086G8NsG79iZn4aXrXskWsaAN1FFl/TNxcLfiwVdm/DfatsyY1x55IiDJiFxPd1SpKQj5yRQejKJg==
Received: from SA1P222CA0065.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::16)
 by MN0PR12MB6055.namprd12.prod.outlook.com (2603:10b6:208:3cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 08:45:27 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:2c1:cafe::b7) by SA1P222CA0065.outlook.office365.com
 (2603:10b6:806:2c1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.34 via Frontend
 Transport; Thu, 18 Apr 2024 08:45:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 08:45:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 01:45:14 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 01:45:03 -0700
References: <20240417164554.3651321-1-jiri@resnulli.us>
 <20240417164554.3651321-4-jiri@resnulli.us> <87bk67cbuc.fsf@nvidia.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
CC: Jiri Pirko <jiri@resnulli.us>, <netdev@vger.kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <parav@nvidia.com>, <mst@redhat.com>,
	<jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>, <shuah@kernel.org>,
	<liuhangbin@gmail.com>, <vladimir.oltean@nxp.com>, <bpoirier@nvidia.com>,
	<idosch@nvidia.com>, <virtualization@lists.linux.dev>
Subject: Re: [patch net-next v3 3/6] selftests: forwarding: add ability to
 assemble NETIFS array by driver name
Date: Thu, 18 Apr 2024 10:43:44 +0200
In-Reply-To: <87bk67cbuc.fsf@nvidia.com>
Message-ID: <87y19bawl2.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|MN0PR12MB6055:EE_
X-MS-Office365-Filtering-Correlation-Id: e503d001-43c2-43b8-512d-08dc5f83e583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5Hund3Dbm8DsKAOEE/mS/6eRrgIpfKwZdz/hI2hJNVL0QV49FivcZ2j3RE4t9kLdsH0E/FKS8qRQKPvlA6EzM4iaCr3SmrW8/nb4Kfa3VyF04rwopFf6CMSQ8ka35MHAucv7HeCX+AakxI3limQc7OI82ZCUrjbOHf3dGknCtU/AHI2tA0MQer7DyJgObbX6rV5ShfQtH/AIuBAG1CY1dq2dmZR2acosnOiHZH1BNblAHJBtgMaDVE/yRLIYDyOzOhvrGK8q26XeFrMrhDYaN+hZfIV3d95iTzcUX3RRq5h8h5N5Jnklfck6Nre0LZPb5fat9ghluhJ61rNgC2vf8G9r40FMn3c8Gzh5QGMRVANM/krjF2OUN4YPGiXNLMf458wkXD05ynnOUZNHXsltUrcUChtJ5sTdyYn0e8JBdH2/t4YCd5wPHSHcX+OJlxKqh0u0sZaeOk5VWzPJmCplDu33184KgML+aUEPCjPYGMGM1TtrdS3Bzw1k0TgysIFlZ44VCj80kJK+oRTq/U7t8PE7aYYlFNwJ3LDNI5NGAea3Zgn3WqFN1wBHbU0KdwiEA24n/5BEBAUltFEx98s5ybLKqXdNgxQHZRKufLXgHnOA+LD/NUcW15wywqIZ9xkFAO7cTVeWCLl3gTsFJ7+O42MHzmzA0GbTvqaJneuyXtth10YcfAQPjL0NP8qDxVYNNI7JnEJfKfVKRuUCTVo+k2kwan9EXloyGKGYh87K+bXD+SSB6BM1A2UjrEY+PrnR
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 08:45:27.4148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e503d001-43c2-43b8-512d-08dc5f83e583
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6055


Petr Machata <petrm@nvidia.com> writes:

> Jiri Pirko <jiri@resnulli.us> writes:
>
>> +# Whether to find netdevice according to the specified driver.
>> +: "${NETIF_FIND_DRIVER:=}"
>
> This would be better placed up there in the Topology description
> section. Together with NETIFS and NETIF_NO_CABLE, as it concerns
> specification of which interfaces to use.

Oh never mind, it's not something a user should configure, but rather a
test API.

