Return-Path: <netdev+bounces-260523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ImkJMOlnWmvQwQAu9opvQ
	(envelope-from <netdev+bounces-260523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:21:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2461878BE
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 14:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A43A303A10D
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C289539C639;
	Tue, 24 Feb 2026 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m9oXuu9W"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012061.outbound.protection.outlook.com [40.107.200.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9360D39C634;
	Tue, 24 Feb 2026 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771938958; cv=fail; b=EDIGJRgS90QU4MF0z/wTsEmNp7ikhdasLpgKKDZchDjiqj2wEH+FDgM0EjYHh7Qh4q2E782fxPCyJ1jp3WoMW+BFub/lJwwXRumLzR4K/vre6PBWZa+q01q0VYQA4PtVuWVTtbR854KE8KOXDPzBLqUIZVOHHlYEhnKVN0pOOGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771938958; c=relaxed/simple;
	bh=v/beRU/0BYjF4uw/S9mnVk1imN/F3nbsRPc1w5hjUKA=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Pucte3SI3dh/kJGY44/glnfyg5hlR6KulGzz9kl0y8AkiVKZlyqR4+Labisb9Vu7hfL6fyvQJIqYjuifpWPoI2lZZLa83ZTY/D3Px/hOMO84QqZk6lDoki46CPJ2ybfJFoR5FHis/hPYD4SPeiW3RHLWxgixfbdfCXNS0LD/jxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m9oXuu9W; arc=fail smtp.client-ip=40.107.200.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mt/RQ5e9a+ZF4+ZhozIWXCK7xrP+Pzfye8lBDxuP177bIjNb2gUn9RN6EBwV69O3S8o3ppB6SZWDR7IbGOnWe3nTjaLtOTchD3l6LPQTPf6/N5wfZ0UjqCxb4QoolKA/YV1JATK1mCWXjZf0h7CvNC8cxyiBRyGRru6OsaKILUaXoNJ2oE8akZPhNkjCE2n6DJ1gODtgYcxI+JqjECyskKJiSTWWOSUlGZqoXHIv56qrg/96Xm4QAVNN/anjGTVd+yPRch4MoldaUsNg4v9/ewg5frTA/wb5KJTTpmW0DUWj6yy0LVnyL4foaJVbZfPSdVifBhZFS8yN5W6GyTWG6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMSaYfthfLzTltjbH7KeKdSmafJhZs0YJxyWMYcx39w=;
 b=EVrWoDwbPCBH4biMkdutObGkSnKgRP5iSzaJOAWY7OdS5R4lmBibp7QRzdgJPRqskgLGKM7Z6jPuPUTi6TL5oQikK3JyOyqPf5PvyXC5OI1wLIDktVi0oljScfsG4CdmZf9axZNBnZBzzOqYXBpzDvswWBExvHfTt3+LEM+kemn6V7o5Ge8bGvYK4fDe1AOvSTxK6QG5TAOYeiF52isY1Rzf5ONMlQnht/bXVHGGDCtNM1XU+fVc6A9tRcSdLzFlhaTxjplBCq7GzAcblTedRzBOO/7jVBVijIS7Hh1vu7ka6QZjkc98E8b7uwVfv2YCpdR3eBcxco1NNQx6e7YP/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMSaYfthfLzTltjbH7KeKdSmafJhZs0YJxyWMYcx39w=;
 b=m9oXuu9WK3LZQSP5oQCF2jISljb5Hk++wctJVdKKbzHEBeO4csU0KKOGVwp4BTTl4mqABwsP+LTKj0dnCwmEaGT7NgyvLWlUjQZykpcgiY18MEYxdhGGqFrykhGpvK/BEH4fXPPH75eh8v9cXO6FEYGPgOtQQ1JNPkuvGU43XF+KpNtQqI+kKKN/IVPlAAl/XWMDwXhomLVctNxp2h+YNWpFWNUSDsix+TFrkNuB4FcC4hzi62SaN2ZYbEfectErACVudtaiKie4kFjwYCJvxqrGnN6LOy6QZJxjxgzQIgNgHfnKnV4JhzzsM+BFDxXBYHzGthv3EbJEIjCt0i1bhg==
Received: from MW4PR04CA0260.namprd04.prod.outlook.com (2603:10b6:303:88::25)
 by DM4PR12MB7502.namprd12.prod.outlook.com (2603:10b6:8:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 13:15:53 +0000
Received: from CO1PEPF00012E62.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::4e) by MW4PR04CA0260.outlook.office365.com
 (2603:10b6:303:88::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 13:15:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E62.mail.protection.outlook.com (10.167.249.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 13:15:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 05:15:30 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 05:15:25 -0800
References: <20260223202633.4126087-1-kuba@kernel.org>
 <20260223202633.4126087-4-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shuah@kernel.org>, <petrm@nvidia.com>, <gal@nvidia.com>,
	<leitao@debian.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 3/3] selftests: net: py: add cmd info for
 ksft_wait failure
Date: Tue, 24 Feb 2026 14:05:04 +0100
In-Reply-To: <20260223202633.4126087-4-kuba@kernel.org>
Message-ID: <87bjhegu51.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E62:EE_|DM4PR12MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: 18d0f807-0f64-43d2-b6bc-08de73a6d63e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8Yrw1JXiQB0MzHXot3cFwh8TzOLui+rs533HjI0297fIdX1m1pUCJzw5flwd?=
 =?us-ascii?Q?tPZhc+4QisvUo+nbUe+AWD36EcKpx3Xx8ZzJ3pFALKjByiSsLUpGnpwUzGks?=
 =?us-ascii?Q?dJSA+LbVAPdHoQJ7+md6UwwTJXidu/hPoxZqBAlYBn8T0aIw9hRiNeC51yKT?=
 =?us-ascii?Q?dYOQRvv7OeDq1rp6fGDm13ueXTM8yORaEPNrQoJ7No26OI8p3HNXTNUVF62T?=
 =?us-ascii?Q?gJKZCQNxIp8zqlLS0yO/dejC3P3dK0TVpvDczqjWCQgcdpSkV3h3sGWV4Kel?=
 =?us-ascii?Q?qbRDXiu2YrH7l4+7JjCtJ3jTts6NxTe19WMlI9OWPZQzQf5r81MIJrnHNtnd?=
 =?us-ascii?Q?gt0iiTZUJswaM/koBE9YajoBPMidmPEm8pjzLXu6ZFIR/G7cC/VcLtemweS1?=
 =?us-ascii?Q?wdGHTkgSvvWfA3VbLcxDV15427ICTpMhR4/GaiqXgtZHk6QOUFMJ8fpJ/CsX?=
 =?us-ascii?Q?i4ppeUwBkw3E7xemT2I2OozI6+qCADszLpM9s5hNWEi9yhMv8Q4mdlfb0bWV?=
 =?us-ascii?Q?MtXkPx7u+wWxiuMttcjdl5EgZAqdsjMl0P2NdL3a1984LGGJs3QcoaDiKF3s?=
 =?us-ascii?Q?NZoE3OX7zUK0XW/URDTFhOroDRPMpDaCrBDWCYv9D2xJzEZEHMUVpuAvzKgg?=
 =?us-ascii?Q?c+Np/yR7F7VNCtv1svkIdKcAwF1Vq2EtbkC84fhIZ1xa6/dvrGEs3HUKFtkC?=
 =?us-ascii?Q?QsUyekwoHivZZRyGDMeu/ZEss5oKqtt3m1+aNBQ5ZI4Q3xoTxSSjLne2a7pt?=
 =?us-ascii?Q?A5aU/a1IYhO8965/0pVNiV+Y1HZJP+TNNUQWIgFu4e+Y5Be/luhYG9V9ZAIZ?=
 =?us-ascii?Q?qCzhmDXNBEiYvq/d2xpVg+kbWRfBo0igVwcLEK2xws4/sozZsSg8nI14ps0T?=
 =?us-ascii?Q?jjq4kjLDH5AkXgGA39qzPvz5UZ4yXSIsdJ9/OXepR/xisLTKJE9dULt+N+Sk?=
 =?us-ascii?Q?ASoN+XGqqWBIQIJqsiU7naLeR2OgbJzm/8DNAwClZGakwCPXyJoTPQdf+5Vz?=
 =?us-ascii?Q?YsRzUOLKl4DB7yS4VxfO8AxVVPLhiwo8trF3J/x+XgYU4ulj8zGGQ19pR2Fy?=
 =?us-ascii?Q?VQOWrAXUBJ58C4UgppXmt3LQ+4UgCLhcKiL0x3932ur9B+8uSQokmMo+P8K+?=
 =?us-ascii?Q?p4NioMyaSwA50T15Odjo4aM/PhZ0gPdqaxaT8ggA+J50ky7Uk/OS3w6rOu2e?=
 =?us-ascii?Q?QSw6yX+7TRx2jAOPzt6yWxFWKwtDv4m7HALsL9thDCoAS3q301sfMzMQjsB1?=
 =?us-ascii?Q?kx5XXXfWmtmauKiogY3DS2dSi/JQD6EgqJurwkMgo8qR/3zB2hPzd4WcKWso?=
 =?us-ascii?Q?inG46lfCyMU3XfRqRfqkzodAhAzL6GHQ86Ar3GJMS3e70TQ7mBSKVJjdkaG4?=
 =?us-ascii?Q?rAiZuPcmq3SOPrAthLfDxe/ilZQZxTYLKxcdGFm1zOfG6PY2CIIsDmdUGgbo?=
 =?us-ascii?Q?uOABrcOBz6fop1Sy3VVOzEmsxSJ560SmCAzUWiUe+HeW52Yna2P8hStoCs8z?=
 =?us-ascii?Q?RwV9FkuFEsHttx1AUcv5CaOcqvuphxsAYVRLd0S59xyNMiW+NCTz5sKblycw?=
 =?us-ascii?Q?7uxx4J3McotZHzehZkstt/8BkEBk/J0Nb8qqLQUUvuoaF9CuSvpThZ2TfEiV?=
 =?us-ascii?Q?TOnRDdD96jGkDXOWLKSLSjICNEKWP45Yu9E1uqUcPjNbxdkLHWTRgFj/qzsa?=
 =?us-ascii?Q?vHZVDQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yiSsmCrTz2tPNnHQbsOmpjuTZImpDSRhbXf2/SLb9G5pG69BK5JyZsvncvzOhp28ssrr6SIgE+K5EkAgbb3Kz3gq05o5DBXMlitBTPKHsAelalZgz5FEj9+v/4OinAB3zjaZmHzWYjA8TbxAXOctFs3KS46WhLka7dXX+Uv0xH4YoVDf6tAox7eukLp7TMawR95b1FILNnzqQY/19sShf4zK7Tpo/uIN+/5+IepW7ugrp2HpIB2Cp4dKSI1hHLL+QS0uUV5KwDW9TMkY4pA+IIRkkgj21oPQcZjs9026Jy1vRXOGKfALk2MrCZOzLKxF1/XQELRiaXWSnFAxfcIay+Mpife0Jsl5poR2AIbdWz2qi5kZtt67Nb7avihXag5/+kF03uqh4nAGdom2qqvge3eIIW57ChO3FVr7hFc5HAWcpvX5OWEJ/72dEhFqw9vk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 13:15:52.8374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d0f807-0f64-43d2-b6bc-08de73a6d63e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E62.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7502
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
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260523-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: CD2461878BE
X-Rspamd-Action: no action


Jakub Kicinski <kuba@kernel.org> writes:

> Gal recently complained:
>
>   When [ksft_wait failure] happens, the test fails with a cryptic
>   message:
>     # Exception| Exception: Did not receive ready message
>
> Let's try to include the stdout/stderr of the command we tried
> to start. E.g. for cmd("false", ksft_wait=True):
>
>     # Exception| lib.py.utils.CmdInitFailure: Did not receive ready message
>     # Exception| CMD: false
>     # Exception|   EXIT: 1
>
> We need to factor out _process_terminate() otherwise the exit
> path may try to write to already disconnected self.ksft_term_fd.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

