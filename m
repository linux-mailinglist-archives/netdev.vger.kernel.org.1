Return-Path: <netdev+bounces-107713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3759691C106
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 16:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6DA728271E
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 14:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A6C1BE87D;
	Fri, 28 Jun 2024 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cu+6tE9Q"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527051E522
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719585144; cv=fail; b=Iuiqzj344H0o+TEIcNjtmxSPmuUEb+PxQ+k+SqFjlemRulSMoJXL3kgUFjsKd4+mq1jDrnFZZEtAx6AQJbYa6rTMaZedI5tKuPKK5lYkToTYWMtorrEknvLMHCFoAnE+hqrS1DeffV1+m2UvsmhRQ9k/MYMCeXlvGC0+w5ioLrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719585144; c=relaxed/simple;
	bh=NK4BLbcHHWX5gy1kfBUgAGzgvQZV2lM4ewycEFBpNQw=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=cn3kf3UK0HFXAT67So8ZrpzL4VBNjDd+wIUgLLuS1znk2S5lkYTg6puYx8KkgRg4G1dcGTO1AYOwg+LZUpN9V2GA1pSavvT9ZVIp8EiAh85R7x0iAVHU21kAH3v7GmWQoNkEB8yfnX1IRLAykoDYlSl5Oes5Ne+M+krvxdCCoW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cu+6tE9Q; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tr1q6zcQW0SYnQYa0YNuERkMPqrcFCnnmDqjX+97Bvpreadsw14s5jvgBCVXgSb0AK5iu2O/FiHHANKLsuzSHhigcLibj4P+QJQtfUwvTMfrbUv9f22HBW+lEJwHC50nnqC+aE0IjOlciW8d6vmX2bDXYmqmn3EmtOUFmeDvAq5aG0Q9Aae779QeysgOjOrNBxHvYwNPDiTrtxdR0roaCElgA2lNztH3ObgACztdbPxaZQ1pvOCBVhCtlkNeCjXilUVXc6DqqeFS8ITcplnfCwEOnljlyn5ii5BfCxzkTnQUbrrtXRipLoG6ojmRrnATZNDm6FuJM4zANRh/OEGmSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2jo8BIRVTMtmScNt2nwGIfucoiz94qrDLrUaGa0NK8=;
 b=GCSXDjvJ2l1swy1FZA8aaXte5AsDRoKc0oNlxFJl9HtieHJtFE011opvR2riXcKBypZqc8kN60FUZMPOPxjMTQhXlBbge/vyvCcEPBrl2l50DPQIDFvxy6fdUISp1hMSr8b8EuWJ24iVfJ8h15rQ9FPQ3A0VoEIR6oT4Gt2PwGLBMo3VlfpJco7k8qnsz79EezYSbAe+okSQojtcswa4M4IAub/GF4M6m+DBfk+ozdhs2MjnyQ6JbFSS06krdlEKoDt7/Gff9iJC3U5wYAqkeycSph1jLgkuV4XAKroOMlePBCtvOlQDw26DCdngDcICz8EcTq9UM5+9hTHoH9+l1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2jo8BIRVTMtmScNt2nwGIfucoiz94qrDLrUaGa0NK8=;
 b=Cu+6tE9QH00WMJ2JO4ubXTxJ7MY4qqyu3W9dcgmJvPIPq/nU+PDKnr9Hn46C4eZy9YCdDPX88lflpNyCsN11/RpkEhgMR3TkOGpIyayrdagNip0HqlmEnEuWbga3oGY75Ex1Bkl9y6hl5h7okei/Bgqn5fEkbEFGsVnE/bcg1EWz0tSdsginXPh2UD71AIRuG20Upy92sf0kwKQ1711tYXYi1fLqc03XWtsZo7FCaow/HZAL6XJLVZnYdGDQ7cmN8SjvCin7YdS0gEOn9gQj2/eV+ylFALzMpafVlgSUIbz50llKVcyE0Pxe7YjRFPwevViy15EOCWYuYRnviKfA7Q==
Received: from BN9PR03CA0522.namprd03.prod.outlook.com (2603:10b6:408:131::17)
 by DM4PR12MB6470.namprd12.prod.outlook.com (2603:10b6:8:b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 14:32:18 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:408:131:cafe::90) by BN9PR03CA0522.outlook.office365.com
 (2603:10b6:408:131::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Fri, 28 Jun 2024 14:32:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Fri, 28 Jun 2024 14:32:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 28 Jun
 2024 07:31:48 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 28 Jun
 2024 07:31:44 -0700
References: <20240627185502.3069139-1-kuba@kernel.org>
 <20240627185502.3069139-3-kuba@kernel.org>
User-agent: mu4e 1.8.11; emacs 29.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <przemyslaw.kitszel@intel.com>, <petrm@nvidia.com>,
	<willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v2 2/3] selftests: drv-net: add ability to
 schedule cleanup with defer()
Date: Fri, 28 Jun 2024 16:31:25 +0200
In-Reply-To: <20240627185502.3069139-3-kuba@kernel.org>
Message-ID: <87msn587g7.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|DM4PR12MB6470:EE_
X-MS-Office365-Filtering-Correlation-Id: aab6efc5-64bd-43eb-30a1-08dc977f1ccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jCrUXOP1MwR2zqrAfJlD29xIq6fZ0hzo5SKc2ZrhE32b7upF9Yrg33sWDDXz?=
 =?us-ascii?Q?bHalifjw9KVp5iBguQhEEAmGnI/OyA760rF2iu2rEpjIWttlXPHLei2WSYdD?=
 =?us-ascii?Q?Xm7dRMJ/q1yJYv2qXATtn7g/BEZJqtGHZpeGRgnsMYuo1mH3+xXUHi3Crn+9?=
 =?us-ascii?Q?9MU0hEBpWB0HgfirZ9dlBf0FtiYuOKX4iHtvaHxmc3oUYWI7Y6oD+of68Rtg?=
 =?us-ascii?Q?Au/FzOlvP0yhb3yCxuHpMv3w9XnzafS6ZnZ8gURXpRiXjrVaMH0vnbq9qtFx?=
 =?us-ascii?Q?X8faF796JIeCfnkrOHLH1sqGQHpDWuVHNglYcBgumu+VzDJHKuHNlKTLLmIp?=
 =?us-ascii?Q?qJgCeHfhs7FsMkhLCLXxUO/dO5jXlO8eoxE0kdtBsIAX8ke0AHj33VuZoxPc?=
 =?us-ascii?Q?SN8g7frpnt0ni3tMpSxETrcI8Cd3nUhWLCWtJLWZIrUqj49zuFZ9Ahmmtioz?=
 =?us-ascii?Q?x6sO/8Wa9xgXD9Hlq6icSyNoGpNcAhuKJtLR9MZTsek8aNodwUDIIvQc6RXW?=
 =?us-ascii?Q?28t7v0cEE9uHDvfebCKuWYIgpZPWF7fJba5HcceR4t2H9M0vccG6tK2KMTP/?=
 =?us-ascii?Q?K4yI2LJI5YG90ZLWSEsO8zKJ4WBSU/LcNbsyGtqtmuhn7e2W79bzwv36+RPo?=
 =?us-ascii?Q?VXg6+7SJnpI41tasYofykuS8YcKBUO1+z9suFWd/PLK0KMla9P9ZjxByzqwd?=
 =?us-ascii?Q?Kve7WsZEbj74QgpZb1D3KFw35oE4O0QOx7dLCt4Xtw5AoUT6NZBnirRHOVm9?=
 =?us-ascii?Q?FZUuRqSlbSMdwIgbPGhPIKS2SNSMkdmuPWhRJaN1MyE4A8x6hihV8YdJ1G1N?=
 =?us-ascii?Q?Vklhbaud+kHUuF6TCNbj7hCNyB1EhHr7LdRQNr3h//+sE5BqK+pN27D31AMW?=
 =?us-ascii?Q?D15a+jbrswEkmtXTGRP41VWFaK/BgNX6/vTVEv88zNnUyD0o1Q9HkLNZozaU?=
 =?us-ascii?Q?qsyJb3s5/Bq3I2WpGu3/kal0eXH1xbpJ522elJzFa/ZSt3E/kQOhX5PF3C4Y?=
 =?us-ascii?Q?BI/vufBxT7g1ukPqvVMXHAI3tQa0IeoUsb5cRDMQUgQWFzuIq8hu1NqbwW1J?=
 =?us-ascii?Q?2fLM1ddKEHj0SMSxR7sx+2JtZHujeuVYanfSHWpd3sHgyWw1RYJROuqRHWcl?=
 =?us-ascii?Q?Fe+SqDAefnNlbkPH8uDbdFDxrGuydS1NobfA4HEyAyWNszkEulzDxCyO3EEt?=
 =?us-ascii?Q?T1BDx0zm0G7NtXm5FIswb3cFpeAuQoVrcsGMX0cGsWNahb/Cvg9Bjer04OG6?=
 =?us-ascii?Q?xto/VbQq0ESdUbwFbmNDekQHRN2diF5x+MIqf202jawIK4ULPq+K7prXZdpF?=
 =?us-ascii?Q?eE/ejWYJC5jCm8+DHgpO9rGIzy0L/XV4eqAOde3FOfsuv37Zs0QYxZriTVQJ?=
 =?us-ascii?Q?PLeVqR4Txs0YWupN0acjT0MapdxaEJQevdmANgn2LZhMuB/4sMVAhLCPZ01P?=
 =?us-ascii?Q?SnGQMrHOLqVgvqVJHI21pi+CUD/k7wq6?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 14:32:17.7208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aab6efc5-64bd-43eb-30a1-08dc977f1ccc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6470


Jakub Kicinski <kuba@kernel.org> writes:

> This implements what I was describing in [1]. When writing a test
> author can schedule cleanup / undo actions right after the creation
> completes, eg:
>
>   cmd("touch /tmp/file")
>   defer(cmd, "rm /tmp/file")
>
> defer() takes the function name as first argument, and the rest are
> arguments for that function. defer()red functions are called in
> inverse order after test exits. It's also possible to capture them
> and execute earlier (in which case they get automatically de-queued).
>
>   undo = defer(cmd, "rm /tmp/file")
>   # ... some unsafe code ...
>   undo.exec()
>
> As a nice safety all exceptions from defer()ed calls are captured,
> printed, and ignored (they do make the test fail, however).
> This addresses the common problem of exceptions in cleanup paths
> often being unhandled, leading to potential leaks.
>
> There is a global action queue, flushed by ksft_run(). We could support
> function level defers too, I guess, but there's no immediate need..
>
> Link: https://lore.kernel.org/all/877cedb2ki.fsf@nvidia.com/ # [1]
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

