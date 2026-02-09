Return-Path: <netdev+bounces-257928-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8M3gASO2iWlLBAUAu9opvQ
	(envelope-from <netdev+bounces-257928-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 11:25:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BE510E228
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 11:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 103C43002B6E
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 10:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD74D366DA9;
	Mon,  9 Feb 2026 10:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gwfX3udZ"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013036.outbound.protection.outlook.com [40.107.201.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848E036681C;
	Mon,  9 Feb 2026 10:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770632736; cv=fail; b=BCPkZ2o8dInEF6LY9vc1F+r0cQzbWIdGTBrAokYG/VV2BUrV5gGQN5bRA8pe46yvIw1/QvDlijEZXiJzUwRcUdQ5mQcB7qSSA5NgeWD8Xacl6euNmWnDpmm8PgB2KSBgZ8YjkTmXgzBUeTP+jjYFONcVxJlIDZBjEoPtSTDrMS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770632736; c=relaxed/simple;
	bh=iqjaeJR2kffKzEMyp265UgzvUBIOiPJevzCMuBolOLE=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=XZ6pxApLG/ccf5GBaGyrsFv97NJ8Yk+NFnnG0Q7rdnnvdZW78NheCrP3atH5yLSL+ckTsGkrh8NaPYl8MEENASWwpxluy43tpoMuu+zbl3XdV0wJjnYzcPEVvgof8NjKGgvtLSrhe7bRWTDzdp7WdcJn6/sypPoTvmCLEYnZ7g0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gwfX3udZ; arc=fail smtp.client-ip=40.107.201.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWA1S32mN5bzszOl/jQQUBuEOCaAhy2R/IVEITZ1+9S45ZMqbE8Lf7qlvdm1KWaluwUSrq2kxskMVHUOkpqlasW47yegrHESRAx0F5/h91qZO/u209wechFBsL88NB8tAQujN5dJtpnu12yKS9avsbirvPqpjfr7G6/12Lh76sDcpqPUAQQUgKJhjQJwV6BvGs21ssor7giSZSqlQRr7/4QDy/YN8AdDcswFpdJMi/gUUjyCY/ks3H2y/ofV9EPFlUNJTU8oclQGLt77yV7jN17sKRFVXAoOkt+uiCSCZqjed9HSYfMAnN68jyqsrsGrZOfTKGIlKxH7/ZTbErseog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6xOSujh27V7dKH5T9vFzTX1FOKh23gzf+6M16vi61A=;
 b=Y7enZlo2BcZUDmciw2eh8pEGBDXjh0TQDEq+32j9vZI7D+70C88Wos05KoT0AuuAKVEI87i/2MPmtGt2+wVoKFnEiMCwHdpW4y8a/gEWkcBT/asBaK6ypDPbnoNNY8Au9VZmMmHB8d8VmCZQA9muYs9p9wRLqJp0+3ULC1Z/CqL8JOBADzrK7fb+jnykiGdMsGKvitSJM6KyEAfMr5wszZy435oGsZX2cSzFHEFZKBwMRYPevpxNdYOkegQfhffPeCGza7SokrX14C7Ry7zySjiqOGXNasaxtvHWJ3RHs2haUKQNq73+B4OQekC9JoIEEbhP5gT4RFQrpXaQ+bVaVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6xOSujh27V7dKH5T9vFzTX1FOKh23gzf+6M16vi61A=;
 b=gwfX3udZa97OguXsjrXW2PwNQmM66fl8CCOAq/jtbvGGHmCuDqeXlRDUeB9XjJwWe1cOPoNP30bieSvP8cccuE1ZDhtczPRo/pr40GYCKfbyiTZEwDvRBX0AIFs7AHKLxqNioBc/KgPqN73t2Pfa4xyoYErXci38eaAbWoagsn5xfeOQ9v1eUfrCFpt+DTxl/E9ZPWd5SEAIskR5ZHt4/8Sa50PapZyQmjbpDcrzsj2JP7XxAuOISJB2yb8GUV1SU/ajYWbmVsfGFQPUDn2t7CCoBiuyWF4gkF9gkx53qKnrUhdZ1azAiAybb/xKVabsl4a2N8eF0tYsbiEXgyhFeg==
Received: from CH5P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::7)
 by PH7PR12MB7937.namprd12.prod.outlook.com (2603:10b6:510:270::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Mon, 9 Feb
 2026 10:25:31 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::bb) by CH5P222CA0012.outlook.office365.com
 (2603:10b6:610:1ee::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Mon,
 9 Feb 2026 10:25:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 10:25:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 02:25:19 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 02:25:12 -0800
References: <20260207012151.3972723-1-kuba@kernel.org>
 <DM6PR12MB4516D06845B4A6D2691E46F4D865A@DM6PR12MB4516.namprd12.prod.outlook.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Danielle Ratson <danieller@nvidia.com>
CC: Jakub Kicinski <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"horms@kernel.org" <horms@kernel.org>, "shuah@kernel.org" <shuah@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Petr
 Machata" <petrm@nvidia.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: [PATCH net-next] selftests: drv-net: port_split: convert to
 ksft format and mark disruptive
Date: Mon, 9 Feb 2026 11:16:30 +0100
In-Reply-To: <DM6PR12MB4516D06845B4A6D2691E46F4D865A@DM6PR12MB4516.namprd12.prod.outlook.com>
Message-ID: <87jywmz01p.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|PH7PR12MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: 171ca0a4-3745-4a03-9955-08de67c58d9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DaWe6JOEHTBBqIaW/opbA2lJ9bcOCeFO7Xc3IDqwNZPQ3VVBcWGVWIzRMjt2?=
 =?us-ascii?Q?F4XQUB6aNCBXJyldx6XkEDEjk44DaJAScyQvMbMQzuB9jn3OkMa3mbZxQ50e?=
 =?us-ascii?Q?uU+ZbopSCHzjQsZB0hWF6OERruZD0pKoRwOz0Ei9SnQzw01W4r3qYVFV3JYY?=
 =?us-ascii?Q?r6bYrtGkS/7218i7SGa07FOdjqq3pIJF8/VL2rX/iDpVBfEQKCftp7HdYNmg?=
 =?us-ascii?Q?dj0lpilD8gzOrCIcEajAUYD9d4AIUsIl2Hc2RBCHpOkx5NLjnuXtQyRBeQnc?=
 =?us-ascii?Q?ywgu5kkYTodEhgaTkYihEyZuZanTeOz7MvMiLpCDoRRnpphRYeXR30rJvOPX?=
 =?us-ascii?Q?sPlcqfqLfM9wo3UU72V4qTX/mC1UU1xyNhpIqklu+ShqWMEJ3L6IVUDDEuvr?=
 =?us-ascii?Q?ixNe1we89xpsJc19l45gle0La0/lyeR53kyBdrWXG1cBJepNM+jgYGYBlacn?=
 =?us-ascii?Q?laAEXNtIS9/+HASD59m7eq5LByE1OLf7v4ftMxsaD1O9S+s0C2puMttT8tyn?=
 =?us-ascii?Q?JVf2gWnsxMRgsGlPKZoELsvNnZ1wnYuHAX7U05XZqtfq9Yf3uxGh4qM6nDfu?=
 =?us-ascii?Q?XFoIsVZb9tunfHHDtMIwiKsg7/T+vb42/q5fH+hT6rvhHTHpPX4UW6gunDm0?=
 =?us-ascii?Q?4FH2Xu+Z1jDT7EkJ6NknJSwabOa4oADi2htWdWDy33boeSMmmIowxR4Pbp/2?=
 =?us-ascii?Q?2o56O3kirB+Oa9B405/WupmufQWQ2xgspKlpd2FowVnGlqNQNWODgpjqQICE?=
 =?us-ascii?Q?yzJpUg7qL5NVg1ejO+wUarbiSL8IZzCWv4LTTQnKbU00mwzrHj2CQuYzwb3I?=
 =?us-ascii?Q?v+hlCsDJjPOE/dOdj7iPvYI9/3Tq9WMh0vt2cK8ytJStEIokEKc1UiFgDy8y?=
 =?us-ascii?Q?PMcw9QomfdZgu0L2BhyGwPLM0r34i5KJK18rskoYd6t6iZUHZy2xmY7qLXvk?=
 =?us-ascii?Q?MFRTwMaFTuAeyBjiCpKxKbOR5fZ+wFBhKMUv4ODMMyRxTb9ppqKt/VVJnq9W?=
 =?us-ascii?Q?KpD2GR4lcP1wPMkI2XydtsYjiePMklNo0exypi3EGPkhaZcYGJZR0RBsAAxy?=
 =?us-ascii?Q?xi8Mc48LsG489y61KbqPn4HuMv5BL99nCKF1WhQ1KPCYpbTTVh6Jl6ryFOvI?=
 =?us-ascii?Q?S2c29V2g7/G8NmGOWBNCCFJ9krCyM82lgmkiTvc9jLalqgsK9dhF5BQ8wqSV?=
 =?us-ascii?Q?TsCf0v8e89w0BObNX+MbZgYwVKOmmcQd7jwsKxXE15wwB3hcn9TfGA4Pf7Ov?=
 =?us-ascii?Q?d5uafUssK62adjVn33ETUhD68ba7XpfHzzmJUo18PV5cJUsfCUWNmdgzfCca?=
 =?us-ascii?Q?kV/nETNo6QXmaHfejSaPbCljCRMitp1q/olwhR8LuV2MsfW7xKDL5CUn2YCj?=
 =?us-ascii?Q?Nj85l0oUwYmIZBmRuFN0I/gLI+nUZ4SyEZFEMgWDFmYuaUV4d4RDJnMREaO2?=
 =?us-ascii?Q?x5O/MqWICc2hEaRM1OLBWBnWhI0JbM7KyTW1aerwsOr4U3yYLVVo5P5aP2FN?=
 =?us-ascii?Q?JjrRxiyl6XdjgkfPkxP1/yqdQS4pDUM+E0yzHmA6Dt2wYC9eGfR3XzEk9gT9?=
 =?us-ascii?Q?+eGW3+6vtYy9/YIapTueo3GwhoXWygr3yWItb1WuLOn/9YwiS5PloWTexD+P?=
 =?us-ascii?Q?D0UAj61FzfUWOPcKEYST7hT1ucQxLA7tnw/+Pqh/BfexAsyFff4X3ZaJxA9d?=
 =?us-ascii?Q?b/NXuA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dUde/Z0ektt5w79mKcodDCdFmhfBYj8cYSHFdBJsNIRwgBgOCy+1jPv5DciBgxeOI4VGVkkOctqJ6pNDbM7YJOnLGV0ahOyWsBUEyuSbJPqrNMJWepyj6iuJ4gdWk2hAzl0IjLsnnaGO+Ic8DO9xIjeEh9p50VS8icLwV4U7Nrkpgj0/dVM7Lo/IePWaQ5T0zaIsLcGiR+Mb7aIlj2Vg8EPyaZMat389nD9VpjorQs7LsZ1VaaBE5cT6cDd98j8aW514E0tsxw2hE/fGmbBLGv4xsJLtt0fhgtDNUNgnbxk6ia0BD12tLX6D53PSFpr2Zf/T0lXyoKiXGxe6JZBZPdXNjtkWns624ccFHknD3ncHJne6u9uIGWUt89US9VN+NQjObVUND2ZtwBPv/r8sSsIaXRGh5mUhX+MHK9w0xEhELklDAHAX2AyFY/pCiWVr
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 10:25:31.3590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 171ca0a4-3745-4a03-9955-08de67c58d9c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7937
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257928-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.973];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 60BE510E228
X-Rspamd-Action: no action


Danielle Ratson <danieller@nvidia.com> writes:

> From: Jakub Kicinski <kuba@kernel.org>
>>
>> The devlink port split test is included in the HW tests, but it does not obey our
>> KSFT_DISRUPTIVE marking.
>> If someone tries to run driver tests over SSH on a device that supports port
>> splitting the outcome will be loss of connectivity.
>> 
>> Convert the test to conform to our "driver test environment".
>> Mark it as disruptive.
>
> Few comments:
>
> 1. Before the change we simply ran the test without extra info, like that:
> $ ./devlink_port_split.py
>
> Now the new infrastructure requires to run with:
> $ NETIF=swp1 ./devlink_port_split.py
>
> While swp1 is an example for some interface in the machine using to indicate the real target device.
>
> Otherwise, the test fails- if no NETIF is configured, the framework
> defaults to netdevsim (SW mode), and since the test sets
> 'nsim_test=False', it emits an error.
>
> So the new change, breaks the way the test was running by now.
>
> However, I managed to work around that by adding a configuration file
> to the selftests dir:
>
> $ cat drivers/net/hw/net.config
> NETIF=swp1

I see three devlink port_split users: mlxsw, nfp, and ice. mlxsw is us,
and I think we can work around the change using the config file. nfp is
you, Jakub, and I suppose you didn't hit the problem to begin with.

That leaves Intel (CC'd) and I'm not sure if they are running the test
in regression (or at all) and whether they would have an issue with the
change.

As far as I'm concerned the change is not hard to adapt to, and it makes
things regular, which is good.

