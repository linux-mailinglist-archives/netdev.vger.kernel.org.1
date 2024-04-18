Return-Path: <netdev+bounces-89332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B35BC8AA0AD
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 19:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BEDDB25039
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 17:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1898916F8F3;
	Thu, 18 Apr 2024 17:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oij5gfnu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9FE11CA0
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 17:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713459773; cv=fail; b=cZOui4Kq8paz2Cz6/g5wWRjEGnrl/GFDtQQRqPAjXk+s4aXpw8obTfWWelf9SYcJZmRZ2Hs2icKOX1jRWLo0kbKCF/sUBQ+UBMNk/BSDZUXVK0r9oWEdIcB40+2JmIPsagYl47YH+XaRjyQSNSmw3YlFgi392vLvE5CfN6uj1TI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713459773; c=relaxed/simple;
	bh=2LkoGl4IiOIxtk+gcZjxkFUfRFSzLOQ8UdsHWjw1YQ0=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Bi4ptbb8dex3jUAY1BE4nPnZgPHXKgLDs6du71LO4pGWH/aeVeUSiBBYKX4zNxDyhRr4PIuvTdoJ2wQVt+H6230gP6eJtkKxGQcYOVsnHbj0AiYuuJmwwVXs9rvDRgRfqh3WyxoujacF6mqx9hEGyK1HiggB1o+j1RI3Xkq8gZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oij5gfnu; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjgVnJ4CCNI2HuSiDGagXJUj/Zln0HDbfYBu+5x3j9RDBXvfyh/+etP9IqXep6zH46C4lGnc9Nym0tLiQpABtcDbIR2KwKmMXn+voTmyF6j8w5ZSkpeBJySFAkjnh+R/MmOq2keKvmtTaKTX5lDca32fAcNqxWh5xlWR3ubXhsjANRxstJ+rDP6V8MwhNyJTtJ1rQbdGZQKQDmoinggA65sis7W/iZxyaP7euYmdq2BqFQwqIM9Ahi1rLuyR7eOlFzvVCJMFEwq4as81ziDJiKtaGlgoG0vjVyQZhshpT0oMkhGI6hBv4OCsJNiu0BBgLTv8f+dwbEab+cuaAc4Ovw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LkoGl4IiOIxtk+gcZjxkFUfRFSzLOQ8UdsHWjw1YQ0=;
 b=DMNxVgRVnKP38MU9VOM0bVTEylnMQojrKOju1q4OorlCdZyQaotzek5tiSCkrr8FlFvT8I/k/ehkP12GObERZm6P/r7w00lA1rbb0Zw5TkN/lPvNNsbqdlqFD4uFMa4eiIh2MdkAU7k+4b4XEgZegObdNdRqnDdZ/DJyWX8rZjtzb9Lk2TUVxLhh3O9opsoHOLh++KB1/lWZUfoVDh2j102m1yP0Ly1CVcbT1jTLcazrS4+lsEgAl4E7uP3mPFxNv5KqFX1fzvK1DeHZTcVQyZK9/ZNptvXLrckMiz3/7Odw4LG4yFaT/CYY11M5ESg6+6wTCBrRaxXA5q4onqjp5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LkoGl4IiOIxtk+gcZjxkFUfRFSzLOQ8UdsHWjw1YQ0=;
 b=oij5gfnuJfAI4YgqU70A78+q0dW91PpHiLdtGfItWI7KDgbIJCav8Z8GCGnmU7xZeksixzZoJaUflMhuWiCcIKHrxaIGOIEV0kTNYhfz4bo/yoX3NIK+BM5UVNwgbxeczKdbK5+fSjngXOC2qhAOH4TSVzowWrZdFQfRVfyIokKSPmu3XYuQYXYloW2xZlAWmyhUlK57K42vJK2u2okuG9Kof150XrUjBEy2+PggKvTpp8hQvE3eFWihTuu69pfp3Dwrb8r+Vgn/WLeUu3wClzhyUj21i0RH1PubQR2C2NpzXYt+Uc+Jib5GlNoXiaHAn/yvLb9+iUZGJXHZp1N3gQ==
Received: from MN2PR11CA0022.namprd11.prod.outlook.com (2603:10b6:208:23b::27)
 by LV8PR12MB9182.namprd12.prod.outlook.com (2603:10b6:408:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.53; Thu, 18 Apr
 2024 17:02:49 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:23b:cafe::46) by MN2PR11CA0022.outlook.office365.com
 (2603:10b6:208:23b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.29 via Frontend
 Transport; Thu, 18 Apr 2024 17:02:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 17:02:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 10:02:11 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 10:02:05 -0700
References: <20240418160830.3751846-1-jiri@resnulli.us>
 <20240418160830.3751846-7-jiri@resnulli.us>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <parav@nvidia.com>,
	<mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<shuah@kernel.org>, <petrm@nvidia.com>, <liuhangbin@gmail.com>,
	<vladimir.oltean@nxp.com>, <bpoirier@nvidia.com>, <idosch@nvidia.com>,
	<virtualization@lists.linux.dev>
Subject: Re: [patch net-next v4 6/6] selftests: virtio_net: add initial tests
Date: Thu, 18 Apr 2024 19:01:08 +0200
In-Reply-To: <20240418160830.3751846-7-jiri@resnulli.us>
Message-ID: <878r1abo52.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|LV8PR12MB9182:EE_
X-MS-Office365-Filtering-Correlation-Id: 99d87672-5d99-4af8-4d50-08dc5fc96073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xwZjvE6w5MxwQY7/Y86GqJL8e9NDLACEjJ8bR1hAXR4GJmSZncelVh3RfS/RRnmrPNpxDrTwtICT/LQ0MpbLb94RfRp4+Y4Zai9ttHnDudfnmCNSIB524QGIC/zYI9EPibEDleF3NTTaKuyYtTy9+0BJArGn1J2Eq+IYK9+U87p6mC7endrqDUC1FqzOy1lWBKyGcBwE1ReFv6c6blzAel8h185SBaXGQhEhBrA1bSh3sZZEr+Xdg8cd3Qtn5w8XrU5p/DUPYqGR4dwb0DKLkTf6n1OB2l87x6THG2u3eVOTN3HCO0YLKlgpXlAMIWWW8MdHzFS7N3mdHg8npftYpQ1svHz7dqokCG7e9V3fYmkhqgb46GmI97jQhJ3uWLLp8kmsVg8MV5uZPAvdE+mECOwLKyjNgkC3PLUStv4/FiZlTCuvkY1dEqkgc8UoYeF2enN5wSvFK76E/LrnjAVsETzPKY/Y2wjLQIEMFSy4amKMyKW/6YbJ6ZXlq4RdsPzmc3YyE9PMUxoPLTdAQcGkeTbInUa0DuC09wqmIsBCeAp9MefiVYawcp39Ha7Ss6Wy3QHDk7+EEmJZLrJZeZ4Nk/BOatodpSM9YFMShKC0k+BIh6DBUdhJ4Q/i+MOzjY9/bMiBs8N0t/jozSrKgu+f0TX6TLCSBVCi7ZPXdUE9H0mMSkUWsQuKh5mTbFMKwO1AUO0hHYjTkGBA0LOksAZcB4rRkCROOiWOhPZht1g8/d7BML1mZ+087j80JqX7zhYj
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 17:02:48.8970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d87672-5d99-4af8-4d50-08dc5fc96073
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9182


Jiri Pirko <jiri@resnulli.us> writes:

> From: Jiri Pirko <jiri@nvidia.com>
>
> Introduce initial tests for virtio_net driver. Focus on feature testing
> leveraging previously introduced debugfs feature filtering
> infrastructure. Add very basic ping and F_MAC feature tests.
>
> To run this, do:
> $ make -C tools/testing/selftests/ TARGETS=drivers/net/virtio_net/ run_tests
>
> Run it on a system with 2 virtio_net devices connected back-to-back
> on the hypervisor.
>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

