Return-Path: <netdev+bounces-177319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804B6A6EF76
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 12:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7E4172379
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 11:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D930B2566E8;
	Tue, 25 Mar 2025 11:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OUAcvDLx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E882561DB
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742901010; cv=fail; b=kmjLXsHt60TOEUSF4W0UbkhbI8EsEs0nUAtB2lVSoaknFdSJlYDWpUrdk/qFBYv/7+34tk4BGJMlMb0coUboFAe5gut1VETBuPA23dE+VLYhVXBdZ/wbr4dh2jOb9Hj855v/AiLS1TlHsc1WEGCxcnYmPY1r2YkFDLy/be5qerQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742901010; c=relaxed/simple;
	bh=GH0jbPIRo6PWZR+82kt/f5n6lO6htSBNOjOerEGqnWg=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Ieg8+J7OEsW7YhB8/g3UxQ65IZIY+c92/lY5Or70psuzY1eUw8W6LrhTBUDcKeydGNNHLLL69g369lCE8vFU3oUwGqU5UJOSI5jYSEs+UaAz/AteNfS8ASajiZYHDvpo5t9CiU84TjVlkw8HMVaLBxXEO9acYq+oRwI8HoP184A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OUAcvDLx; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nk8TkbS9i415MKzirJ3S93q17betFa/5uz0FVsMrHm2fPTkoip23795vTZHDTTpKcrNDjvEXHrE25JpVDnFmsK0UXJzjgFNUmis9yUoaE8WhxI2iBWF8O99k3GRBE8vLZHLh9u0eBpt7bAbqbYLF3aagfU32RROvHd5PVtpDXphYMVPg0z3A3u9LQOa2tWvLIWRenf60r4FJNBRyBJm4Z8PG2Xph2feV4rKL3vTHXWve0Izr7z6pkFh3EsK0Ty4oBbtzGtQD3mz7ryqAzVFXL2KUaIBhB4PAcedNRsdc6BttSQp7Peb1OoHUXb74uAhBrM79Kyul1xkuSF8/or/6ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRYdV44O/sUXdVWSo0pYxhl+cJX+YttMny8KCpSvo4w=;
 b=bpdBNUInYg2CEGxDmMwbgQyayXSWU2ddHTgNjQWt8ACZzmKiAJ6hpXrA/pcshp2GHqt6IFwlxMByye0XGwnzXExg5gMZdwZ0MlJXqHeSqkRG9c3ud2ZY4kMthO12X5R6SUhVfVgIJqmz6n93veg0WESBOxiXCQKg75loDPk/GASaQK0CUYChEI1JHePXvHNscesnDBfo4FkereEyRecT1gQbTlTGGNTFr3eQJPJahwIXfPaES6AzfFhLJMLEz0k22lsIVwp2AsKPfwy0C2pf6FH5/cvsHrp7EpIKziUlK6TZxB25ki0yWay+LbQ413QuGw8pYo0Aa4Iyo5yxnLTLlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRYdV44O/sUXdVWSo0pYxhl+cJX+YttMny8KCpSvo4w=;
 b=OUAcvDLxJbRy6DdxRUo9s/bj14kBZGtgjN3Jfq1+4CJGRxMfIFSmWTH9u7bjwRC/vLYATY5ZcqoFSDxg5tmWEnzLsDaM44zDCNx0lLfpQTWnMhuLAGsauXQhOBaD2xzB8s9Kb9jh6m1Yc8qHqlEMy9GDNaTKbID5tqCeD2CQuaa5eWF6ujRecXlX6jrigDW77tT02kE3AEe91IK01Ry/57+DgTBhwk+cEj9SxbZj/PvWIUq9RAA5lMhCuVwlB8/+ThqtIOtGTJoWJ/0P2ZSILamxBnE0s4Utyo/borBbDFgBkbpQEn+cD+I87m3V69jBWCXRLqKbRhDC3zyMXd5JgQ==
Received: from MW4PR04CA0380.namprd04.prod.outlook.com (2603:10b6:303:81::25)
 by IA0PR12MB9009.namprd12.prod.outlook.com (2603:10b6:208:48f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 11:10:06 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:303:81:cafe::e6) by MW4PR04CA0380.outlook.office365.com
 (2603:10b6:303:81::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 11:10:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 11:10:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Mar
 2025 04:09:54 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Mar
 2025 04:09:49 -0700
References: <aee7724405df4516494d687a5cb1835aeb309bd3.1742841907.git.pablmart@redhat.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Pablo Martin Medrano <pablmart@redhat.com>
CC: <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Petr Machata <petrm@nvidia.com>, Filippo Storniolo
	<fstornio@redhat.com>
Subject: Re: [PATCH net v4] selftests/net: big_tcp: return xfail on slow
 machines
Date: Tue, 25 Mar 2025 12:09:18 +0100
In-Reply-To: <aee7724405df4516494d687a5cb1835aeb309bd3.1742841907.git.pablmart@redhat.com>
Message-ID: <87o6xp5ptz.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|IA0PR12MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: d95033e3-d0e1-47f4-75a2-08dd6b8d98ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?euUOjiD+OKrYqS0lB0niJAGGi8asiKB9gT4PkW77aJIjpNpTVOkYeLR46Rky?=
 =?us-ascii?Q?oJpjehFRXJv1M2j95sXaHRrPT0KXVZjO9zFNL5ghEEr4dNDp4jRtwOnKobSN?=
 =?us-ascii?Q?z/3oijl1VVrDkkvJNYzOnpHWC9FsObL4RFXViHMDJ7hIX3f7usabBGEqOP1U?=
 =?us-ascii?Q?jUM9qjNVB1bFCiNTB18rla7fslSW+GO3KLSvnfGcKyPAi0zpjuKudQMq/x8H?=
 =?us-ascii?Q?suI9/W4QKKqeMOtnCTwhOdS+Y425CJMuaTWf28v8GtowU7fBgFPtSycsyMjO?=
 =?us-ascii?Q?cr7wbp9fnySEQfW6sk/QRZz7N/5Xf6WnA0u3GcpIloJJLxlQmVtfN/gerOCN?=
 =?us-ascii?Q?b348Te2OUSYperyub2gWK7sYz+eeKzUEFEafU5cnGn3K/RWPotILf6s9YxXR?=
 =?us-ascii?Q?YOChdVY97ULh32wkgPOsUNpIb8CWxOCUVYuWcdYeZRKyxyREs+zZ1/C8UWGb?=
 =?us-ascii?Q?M8fhHLRw9qbqaOb3oB1r3Px2qju7yPxPg7/YdtXag56z8Nua4YlLj9shdRG3?=
 =?us-ascii?Q?bw6FUeCO+7T0lGB2+lQtzv7caW6tX/tmJ0mWrz4Tcqqy3J5SHzEHsAg3vZ0h?=
 =?us-ascii?Q?0nKKjlMTArUBhW+TVNlyemqvFddtyI2tHZLc17h5RIok617GEEuo7hqm5Cw+?=
 =?us-ascii?Q?LniR6Ke47MMa00rHp35Skpg+uVM8CVObOmtTSaqFnbyw7yL5ucP1yvV+gTFr?=
 =?us-ascii?Q?8aClgIKmJZvHXfcedq6633f88zT9nkLu93GnSmBSUHPKZN6S7d59BKw1N6Y7?=
 =?us-ascii?Q?v2F4eFTpC+4YsDX6/o4/MW9OLeoqeADgsP4I1Oh/7vMHOoBNIXShCl+H2Tki?=
 =?us-ascii?Q?m7b0GhauHM49qTi2o2Sk/RSt0PbFKch2QmextbbezQctIlijwDBSYGANA48I?=
 =?us-ascii?Q?4rNhXYSIqpKqVHfRTB3RGPXVlQmauvROOANNfRavaE8T77rH9MPZ30SS7rxR?=
 =?us-ascii?Q?Zi9yvBj+ViTa6vv0f4Oj3pqOu+b0x/z0DEm6p4QaXwUgCYmhB1tVXGeqcCdb?=
 =?us-ascii?Q?wF79o6BU3qlALlCu/SKhfQkNLhFqwmRyj4wtob5kdFor/EvaCYhymzKAxc6t?=
 =?us-ascii?Q?0vqfNvAQZKvDwRVKXhDiyN0qfucwAeMqysEUOwxPJMGYqN/Dn0JBEajtn8O0?=
 =?us-ascii?Q?UCwMci8MC9adGlYrYLYy/La98MuvKcSVpmCn0/2h6GUfoQ3I9ACt4mq8g95S?=
 =?us-ascii?Q?r7QpytZchsSGjEoM02/yvzbWAJBfZPwyw0IzaeShGgNgvI5C2URDoMpxj0mE?=
 =?us-ascii?Q?0I6b0WgOd2LKySM+NmnnSGsTHDRRXoGc7ZM0iY5MnJPV6Gou9k8y0uqr4W8t?=
 =?us-ascii?Q?HjyDt0+aqpsDMN88uwOQPaaI7RTnH2+h7rrfzlZIbJ8lQtnueA8EtuwvIepY?=
 =?us-ascii?Q?fE5q+96k5EcQPPHP9GDTTTE69A4Owft5PqfHuEtvwJe34sSh9Lb8aJyyEb+N?=
 =?us-ascii?Q?135vc2Iy881YcdPvzTq7qgvW7/GqysuQNb7VvnssoUwkes2vFp3M0wgQ/5Q7?=
 =?us-ascii?Q?OXM+gY1FzZrmJ88=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 11:10:05.6269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d95033e3-d0e1-47f4-75a2-08dd6b8d98ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9009


Pablo Martin Medrano <pablmart@redhat.com> writes:

> After debugging the following output for big_tcp.sh on a board:
>
> CLI GSO | GW GRO | GW GSO | SER GRO
> on        on       on       on      : [PASS]
> on        off      on       off     : [PASS]
> off       on       on       on      : [FAIL_on_link1]
> on        on       off      on      : [FAIL_on_link1]
>
> Davide Caratti found that by default the test duration 1s is too short
> in slow systems to reach the correct cwd size necessary for tcp/ip to
> generate at least one packet bigger than 65536 (matching the iptables
> match on length rule the test evaluates)
>
> This skips (with xfail) the aforementioned failing combinations when
> KSFT_MACHINE_SLOW is set. For that the test has been modified to use
> facilities from net/lib.sh.
>
> The new output for the test will look like this (example with a forced
> XFAIL)
>
> Testing for BIG TCP:
>       CLI GSO | GW GRO | GW GSO | SER GRO
> TEST: on        on       on       on                    [ OK ]
> TEST: on        off      on       off                   [ OK ]
> TEST: off       on       on       on                    [XFAIL]
>
> Fixes: a19747c3b9bf ("selftests: net: let big_tcp test cope with slow env")
> Suggested-by: Davide Caratti <dcaratti@redhat.com>
> Suggested-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Pablo Martin Medrano <pablmart@redhat.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

