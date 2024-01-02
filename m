Return-Path: <netdev+bounces-60805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF698218ED
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 10:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A05BEB20E65
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 09:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999236AA7;
	Tue,  2 Jan 2024 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nb3iBOSM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F91D268
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0y5F/82SJcDOhgJAY8AT5zTokSxvx790nbKcpzpmHKk/nPS+4iG5VcQBZuM3ObsSnjjxJ96f9ruVqyKQcwGLyOU8msEEOZq8DXo3Y94eRPlfCKmCsPBfbbRmLZR/UCodoiX9t9vfqzAKvHy59Te550pvEwGOukhXJdQHr1BQ4cuDIXTUA7/D7gndqD751mEyt7J0/Xef8WuKLw/imYRWfE1TQ5M7PSTc0Bpf7YsiqcOomC0l2UfwRLwfA8L4AdEXRQ2dBkNrcXLUHKn0ofHUtPTza2w0zpkrx99usfkW8tgILa2AhYGwms3RRryI+ol6pQDmeQMziT592a9eeFDQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weGqt6P05URj17SgMd5iwtET5GtBywtar0w1PudRvqM=;
 b=QWHriQB+ii5NQrpq05KD18qKEp7cPHFjxWHB/r3O8B7YtIX2ODmBn9QsOucO99j+7j9f0B0HQS1sjJQsHjVHl3hg8IaX/KSKwzaEsrR/fJKpVuHk5s0oFi9D9llSPqPHxBxDp4LyD27nSHmq1RQR7UGOJVpeJfRaN9r7XJiws962G9Jz1TXehE0Tr0+qkrDdUlRWNfTiesjziJsB0e3vl0t2zZNcB7HMKUGfOwUXwKZUpjsXD/6TFb8+MmJmiVUkKeUi76EnEqxJSQgsKhpQDigA+uNLlKk43FSDsxgVqe5O5Guv21rED4Z+XYu18ENp1kOKygQx8TfUtWQWg+dZvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weGqt6P05URj17SgMd5iwtET5GtBywtar0w1PudRvqM=;
 b=nb3iBOSMaF2IMgFlZh9ZdCp8sO8mgYRJV0B+z6OcAVAWqO8ltmcGs2FZlrUl8qIcIT6cAVgE2xPQwIj96+0gAAj2TUUM8cY6WwTZD4n6NQN8CZy9rmkN90+Eysh/9jjqF3MxqmDvaZ+LIYd6xLW3h1c2EL1okMPQfBmG+U2e7EG70KbL+4+rzEUf7URaNqqoZ6eh3jxUSWH6oRNfkJfiEj59/FDwPzGQYGwd7kwdvSk/ISN/TuRei4rxPyCFBg9N4T0H5ms9ee5Y4Zas7XuTuuPZcyrhuuRcgJw4kaA5aLLIUl2m+pcW2uA1zofgHXlOn0FpL7lwnCqYOOMq/K01sw==
Received: from CY5PR15CA0070.namprd15.prod.outlook.com (2603:10b6:930:18::6)
 by PH0PR12MB8032.namprd12.prod.outlook.com (2603:10b6:510:26f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 09:31:15 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:18:cafe::69) by CY5PR15CA0070.outlook.office365.com
 (2603:10b6:930:18::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25 via Frontend
 Transport; Tue, 2 Jan 2024 09:31:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 09:31:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Jan 2024
 01:31:02 -0800
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Jan 2024
 01:31:00 -0800
References: <20231211140732.11475-1-bpoirier@nvidia.com>
 <20231220201017.0edeb8ea@hermes.local>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Benjamin Poirier <bpoirier@nvidia.com>, <netdev@vger.kernel.org>, "Petr
 Machata" <petrm@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>
Subject: Re: [PATCH iproute2-next 00/20] bridge: vni: UI fixes
Date: Tue, 2 Jan 2024 10:19:27 +0100
In-Reply-To: <20231220201017.0edeb8ea@hermes.local>
Message-ID: <87wmss9j59.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|PH0PR12MB8032:EE_
X-MS-Office365-Filtering-Correlation-Id: a8cce122-f296-4ff2-6556-08dc0b759107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mAaW/3ouHHicvZNxpr2uX7Mnej7qeQ73pBxnxAhVNzIe8ECKGGO4+X05rm7OsOPIH3UJgbvEhkmSV4Rb3J/r18bVhBt9L55SYAHgcN5YKeoFBg0TPHeS9WFIEX4fMYkf8GKkmJdR4rQwZqCK9ncbkCkR9BStldgy+FSYRUTQ7OmU2mCFReBsIZP/QEvRpqKlO9ues5QUhCxBT17+RHM1cnvfOifkcFzsV/3C5CQOxGnYrXCQVcRUEwNT7nuD429TMo0tZVxTajb4kJiFaKn1X8knRk4e+O8GMX4+0S4PFKRdImabt/Vr2klQFr2XTxjPyJVs1plifHkWteH2qIZ2B86hgdE4Md0ef09QpHxxRcfGA1vEe9LGYXpdHiH2fMKR+nLO8BoBtfsQ69En7b5hS7iMKhrHCoNK4WdkRtkoUVfAuO15wY2+KTWgyIF7D2gkagQ6pWLnPQNAmZ9WpyynkMbpF8Y7QXO0HI7oLZT+4b9BdalViVcmc/iEsQO8dbR+U13cfJ6ji3GdL+Twz6e4fRfB5i7OiDfHRhv5zCow7v5mBYHaLWuLoGalI5gSH+2RmTxzzHwsdu1sqeuUI1i5HofvDrGwHoEK6BHen4xbnoPfTAix5ytzOaIoe+TAdQxyE0InvuHSEpy1lxeli4NRQqmm1IGofjcUxGwcYP0+zAPmMfPf1oPivjGfxsNGtQd69B1OGsunnkTw8HdomvUMxya85spQFNw4+PTOa3WW8pQ4n4eZZ4tcNMZjeLdocySD
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(82310400011)(186009)(1800799012)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(36756003)(83380400001)(478600001)(426003)(5660300002)(107886003)(4744005)(47076005)(41300700001)(82740400003)(40460700003)(6666004)(2906002)(4326008)(2616005)(40480700001)(7636003)(70586007)(70206006)(316002)(54906003)(6916009)(36860700001)(16526019)(8676002)(26005)(336012)(8936002)(86362001)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 09:31:15.0621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8cce122-f296-4ff2-6556-08dc0b759107
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8032


Stephen Hemminger <stephen@networkplumber.org> writes:

> consider consolidating some of the patches.
> Better to have 10 patches than 20.

The original that I reviewed internally was 7 patches. I asked Benjamin
to split some of it more, because it was tricky to figure out that all
the changes in an individual patch cancel out exactly right to deliver
what the commit message promised. But yeah, I bet there's a middle
ground.

