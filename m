Return-Path: <netdev+bounces-89327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA048AA09F
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 19:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2500B247B6
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 17:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF026172BBA;
	Thu, 18 Apr 2024 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RNK7oP7b"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B16171E77
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713459612; cv=fail; b=FsQCoLyIE56SjsJHAQeXuDvriaBvbf3ZaPy+kdLvH9C3D/MqqsYuh2jkWTu23jym/8YCXf+5bqPy8Z6ksuJWX39IDr0Cf3LCZnCH4HHbuvVj9ut8kauzGM/hugHOKiDd5+3jiTS04ma0eE4Eeh3IeLZ8N6tcYXESD0X0ohfDVSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713459612; c=relaxed/simple;
	bh=uWTJcJ8+UA6rTlPYoKZZzzKB486LExDIIottsNwdwOQ=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=e7gVJx0ZovtDu9L63zBsyY+fheqODv1NoBqsSQlkJauzv/aOLzIbAcliSgrduRWDLhQUYfvDOTO+ioGzsEearpdyQjBGlaSk5RFtlkeWcvPSr3K5YhqROHj0+/Aw203cXu+B8TWUMVYxsE7qqXUMF/+gkNx3GiBrxQhQy6ssr/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RNK7oP7b; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1mao5u5BU6VGCK3TfHMS2QBE3N2yLhlVlyS1MKsTXP47BV8jp+T8SRv88BWs/Mad0x/u3vMpQQHyvV5GA/K12aIrpfJQy0ZL8LpCLgpY3/d9jzIPyhCBis5yigpDKoZpK5roSnBvRwXrcEo+Z4ZAoZuNCbSQgGo0II2NKSaFDJdaYcyotkm0KC+YP637bk/nJYZYJr70mvkY17EKVihBGwgY0MldLPBudHZ1i4kW6zJ2qJshrU4zPZkcBs/7quwhKd9levuub1+ck23oupxxovSBsccGxcxdlBeIi5B3ARiAzOavlNrKDl8Zmqs78YjT25wVDMklTcaanob2I2LRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWTJcJ8+UA6rTlPYoKZZzzKB486LExDIIottsNwdwOQ=;
 b=oeBXw42zOo4Gu9e9T5q0ogP4kWHmNIRR5NQtW0u7UT8BQ6p+yeJvPrt0jeeUdaoSR1l3qCxiYelZqHJEr18SW/l/u7nPAUccpd7LjSUd0dUZE3k2E7uf6YoUbn3DwY6OtEsA9hFQUkPB6HqI3RbNxM/S2CgV783MgrT6bAljpn/ZlLHojN70mS0vYmG43vDGZf8vBxl3OYHyRcXZq+JSLvt9GGsK/9YW79O1K4EqbOGNHH8D+o5MWVrcNm8maD3zvxruabEQUbjbyo4rKgwA8F61udCvFAYn4xfQpw1jsGHB26S5/vz+Y/cQsDcVVxeJhAqECMPZNh2NpObWrUDowg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWTJcJ8+UA6rTlPYoKZZzzKB486LExDIIottsNwdwOQ=;
 b=RNK7oP7bkczE3/pVn2kCPBQTjeH/luhtxOaQWxkSZsZSdliHJFztbSP7+vURxdEgEsfF6yy7Fhz1rNNzsF9F9OIJAwqtIHl4tdWz/2MN95w+v2bYDDs1N873rCxK4Zw1nqCychHk+wwxB83KLPDq0ZF3+Lo2Oxiez/9R0AxbQphOggRPILgHkJkeF/XDolWutlAdvvuiSI+TQNjK7I1y38JFRSKabzHpqGiDvMUbKLEfX57Jbkh2KhWUaVU9E+KiE0EJ2amSSSPzSrK4q/NoMTjLB9wPL60Ziir91qIeab4GHrDkagbGIPf8111pQAdz2OFFylcU9dMuIkn5r1wOCQ==
Received: from PH8PR20CA0022.namprd20.prod.outlook.com (2603:10b6:510:23c::22)
 by DS7PR12MB6142.namprd12.prod.outlook.com (2603:10b6:8:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Thu, 18 Apr
 2024 17:00:04 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::b) by PH8PR20CA0022.outlook.office365.com
 (2603:10b6:510:23c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.28 via Frontend
 Transport; Thu, 18 Apr 2024 17:00:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 17:00:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 09:59:48 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 09:59:42 -0700
References: <20240418160830.3751846-1-jiri@resnulli.us>
 <20240418160830.3751846-6-jiri@resnulli.us>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <parav@nvidia.com>,
	<mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<shuah@kernel.org>, <petrm@nvidia.com>, <liuhangbin@gmail.com>,
	<vladimir.oltean@nxp.com>, <bpoirier@nvidia.com>, <idosch@nvidia.com>,
	<virtualization@lists.linux.dev>
Subject: Re: [patch net-next v4 5/6] selftests: forwarding: add
 wait_for_dev() helper
Date: Thu, 18 Apr 2024 18:59:16 +0200
In-Reply-To: <20240418160830.3751846-6-jiri@resnulli.us>
Message-ID: <87cyqmbo91.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|DS7PR12MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: d955a8e0-bc0e-4fb9-2ad8-08dc5fc8fdce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KcUg7DtgKertsPvMNTjXgELCJgUHYd5LjqLrpydyyKf6HvDNzWq19ZO7H2Dlx/q4fsdKYS5+O6363EuY7tqmSU2jvj9s8uGSC5EQG9PNxpUx2uKuZEEzL4tVencd4HUf4YZaKhMXTSBZ5xFIgFpcH0iUcoAZuvhi+lHO1SQG+Vk0VVkrebIfCKxes45OYgDdmCtW3wbSZq2I2s0N9TJoEKKJllVTJNy8K4MTdg2B+l8WFgYw/Xui1Pu19dXsyanqtDV28mY5LMWARaHuUC9Xj8VleNS9PLvykZ6oHnSD3fXm3L5LGmyvXrXUpAH+4WAiQh9YhZNSPM42vDD97tpZxyA6xNNZg+tI+p7/Jg14E09pyrbxd7I1ZMhoHJaqIX4vPu+AeGi8XHefiTbf+fVRspkwg4l7xRNo3l5lJAn8ATIMjdJ1MRi8BBfHxSI1IPYf3mOTR1X0C9UX2t14aXiZi+EHI4eu19JgnLj2R8U8mkYSoG38WssHzgsFlqKEgumOU+RjYuxu1ixGb1PvXkKSiroHa5Ku153hGDn0MsLZeTwS0cBoq4dqS1Xrg5pevgXUi34rPudThcdN//cS+jGcqBwVLR3CMltCs5JFSZCBo78waO4Aji925J6zTBcnNr9eUtqWpOL00Cp3mtE4607FicbUCxiBdHfD2fQSwWPO5DBZbqmV7WFeA62TYSo1PwcqVCD57jqlMGVSfhVcpVnXeCDPIYKDr2VRP9vN/ZfqF8nm56nUZoCA8p99pdEOVYps
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 17:00:03.4606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d955a8e0-bc0e-4fb9-2ad8-08dc5fc8fdce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6142


Jiri Pirko <jiri@resnulli.us> writes:

> From: Jiri Pirko <jiri@nvidia.com>
>
> The existing setup_wait*() helper family check the status of the
> interface to be up. Introduce wait_for_dev() to wait for the netdevice
> to appear, for example after test script does manual device bind.
>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

