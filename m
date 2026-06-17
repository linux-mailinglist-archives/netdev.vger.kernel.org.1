Return-Path: <netdev+bounces-300154-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RFXyFfyKMmod1wUAu9opvQ
	(envelope-from <netdev+bounces-300154-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:54:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B28699538
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:54:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="dW/gjtKp";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300154-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300154-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DF3A31CE92E
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639D43ED125;
	Wed, 17 Jun 2026 11:47:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012007.outbound.protection.outlook.com [52.101.43.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E97A3EEAE9
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 11:47:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781696874; cv=fail; b=C1DiDY5R4Up2958Z0a6GI8azvefohNq8Pp9Rw/UhWLbEXRHU5/HQNhRnec8VRk7fbw77RRPwFOd5/dKROWMElhotj690Z1/vY0utWJxKj/LAcK4p/uzcvLHQvFpFtW8tS4X1qjFcAi4s83yo6Q54/CAWQJZvoAI2E5olbj/nHOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781696874; c=relaxed/simple;
	bh=1ipswlaJ1euuDdWSaYxuSat9XlFhtqpzTtHycvtnyPg=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=JW17FTAJsuXu3zkLz/jJW+wrLLn2f8aQuvNo8KEGCVM9K/0GY/aTDRtZ9fcg6B8CMTfXRyWttfYE+576IOgjTEmMGsjsNwqbmYkv1cqUGsHdHpcvUjYVSbGqy52IYJXvIOnaxmv17VEi9U1RMfG1OM/2mHeoQ9MygEvou0wI7Sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dW/gjtKp; arc=fail smtp.client-ip=52.101.43.7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGeTK2cSvPaVaL5Wjb4lmNKSh50qrR2pOt13zARtWOJZtbpmY8rzwVil6pbbED4C1yIkP5Tbyfavmne70sCiY3XIkKqQtzoGxeXcy04iGxU5PA69MQ7z2zvAeq44t6EShL6rRt8hwPFr21io8V9+fGsV3yJQZExoAzJ9mIpVdXI8PZfknwnZDWgkB1usokc8KyIzKgvUe6hWE9CYwA5/UDFjuey0fV7KvAiLi12Qh4J/HeSn0HIhDlmhlqgfUo9qLrbea4UAhs5cF60cz/2/ObdtU0uHekiqYeJT72spyaXXSV1Umrm/dkg536zVmOSH43otU93wm8CXuae+4OfRzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ipswlaJ1euuDdWSaYxuSat9XlFhtqpzTtHycvtnyPg=;
 b=LOx08mHaoKYG/DRsD5oyiGj4nCwI4apQUPS9qgVXsk5hjvUVFqKUdVMhGv+YlwhSK4qvPeZ2sNtG1Dk3Eww1gi2g9K9g76z0/FpoTZY9J7h749LNZKuKEnRv5yNpRYak68KPtoXEAtv8MlpgfcLm6QbMcJ1wJ7xnCB9JpiO05lILc0wvCSbSPJp4kdVYEMWnt3rS37uUlggR/hjYhdlbbVNbZFjSiDjc3GkfaXu/Jv82iVZotUKCsqhUdKnOHUW7H7jmJFb4fv6BD4Ys783Y9uJ8MFkyjpIrMn0MYhpFwP7P7OlLxD4zsiiidyut74ZLa5v7yokey8HlqtEb9f8JwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=blackwall.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ipswlaJ1euuDdWSaYxuSat9XlFhtqpzTtHycvtnyPg=;
 b=dW/gjtKpV4M0G/H763O8AQLzaOa65AbyauYL4oobLRcVUTmChsDVpOONnA5wcD1CxzLre/ReBGiyFrZYh70ctEUGMBP8Q2aZ9dIaiE0Klud8xqz9REJ9HdhAWiqusJKcLippTEaF/D8MMZ1qoNxhtzjb59rlj/4AITKKlwoXKvdLm84vYjkG7IU+b2FbLJt88c0kjfPNK0DVgOWEcXxiSvdgPh2t09sq8/dve6cSGJAX8uAkPS8nArJuf73gfqxHfpkU2YA1I8flePK9cadxoLCxoFWjtbt3HG/yGKe0Y0+5i+rj5is4mLvBhzzAR8uIL1gqRKLeiZrcyKM/sX1HSA==
Received: from PH8P221CA0013.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::24)
 by PH7PR12MB6586.namprd12.prod.outlook.com (2603:10b6:510:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 11:47:48 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:510:2d8:cafe::55) by PH8P221CA0013.outlook.office365.com
 (2603:10b6:510:2d8::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.12 via Frontend Transport; Wed,
 17 Jun 2026 11:47:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 11:47:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 17 Jun
 2026 04:47:31 -0700
Received: from fedora (10.126.230.37) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 17 Jun
 2026 04:47:26 -0700
References: <20260617104323.1069457-1-idosch@nvidia.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <petrm@nvidia.com>,
	<horms@kernel.org>, <razor@blackwall.org>
Subject: Re: [PATCH net] selftests: vlan_bridge_binding: Fix flaky
 operational state check
Date: Wed, 17 Jun 2026 13:46:43 +0200
In-Reply-To: <20260617104323.1069457-1-idosch@nvidia.com>
Message-ID: <875x3hie2e.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|PH7PR12MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: 4de7c5ee-40ab-4914-1709-08decc66401f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|13003099007|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	ZL7JrBAlEGGyN96kpgx1Jc960bD15oV13FTa31/iheORIT7P1sZDFq5fddCbl6Q5bO/BJyo0mDOgevTchIk1luVH7aHFfgxWAKjxDG1ezn0aQke6vyLKDVkGYQCCNpjvEcdyijVe/gqbQj5cFTPaCvNGPRMCh44uh1pT5S1HGFN1tONbA0vByy9VX18mDG3Dpd1Vvz5gRiHhg9CgzIQU+rmjS+plPyrMHpC6L2NMmcs1EdUj1FPsF4xn8XxxQdjGZxpgZ3D4c9o31NQ/FLdpUflyhpXwXehLUug9KHXP4hqvd2lifApqizAeOp87GtLTwWPUouiasENzxKHDqX5aoH2/S1nfksYyQskO4+Up7luYd96rQTlUEWYBkbikeqS8h47Ltmwvg/p8L8bbih2Ny9Vdq9VkMKg3H56mvrH3vE57PzOOabAIyIDRUBwZ3rLfgpxP/9N0EkCQTf8YbARiLLzEpFH1zIAp3boZ4JvUM8LKuXVxJXFEKNdhhid8LsLDVG3YMJ7frrRS05/3dbrzbGOgo5kZ7F5nCopwmEN/MCJTulvrlEdxvL2FCqYxZkXnwd23wPAb4WLzRCZk5tv2Ax5wa1GjSmm2zJaQRyCEBLbefHsM8TyTODFEY5sXXS8qXEdRDiAke4d5/zFqOYtdYcqMrMkfTvbHEl2qoPd/6qZUr8zqfmxVxbQTzOZ6Bnk13CGRgu5zkRdMiMRG7QlARoICSNvLrLW+SlTg7iAPPB4=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(13003099007)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CsswfdoFKtlwTBYFTa0vEaVQFn0krHOMC8gGAgK0agrNWloTCIGeSA9MMswsqVo5Q7T6d7yT3yVrMw8jy+J/A8XxPDC+Xjg0gOfgzead53RsHYmI4dENW2slbuPzxgkCAqJq2jMOFb4qmScOlhiMyd4jxU8YvseiLw1/uFL6KNxI86bNdth+DxUPZLXJBBX3Hl8C5A8VzNBceUKZAQ9+/5uqJDaaIKT4r8NdsI8FGShdjKdu/yGRWFgJpWydoxSM91WpBPYsnwuHuC61xretVlIw0qkGEQi2hMwIMSw5WC/QcvDL32SfdeOrx/o9dODqt+WTRqfX7lB1GUMTdS/oYQhwZojeU1z15W+C8WPCnHr+wBFY+KfIbcEe1oW0t/zi+aVOHnjHwlbUwl0hTocco4wsOd+ULcwAVMvIxuN99g6kpGYvsmoWU5K484CxbdRo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 11:47:46.6214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de7c5ee-40ab-4914-1709-08decc66401f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6586
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-300154-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:petrm@nvidia.com,m:horms@kernel.org,m:razor@blackwall.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4B28699538


Ido Schimmel <idosch@nvidia.com> writes:

> check_operstate() busy waits for up to one second for the operational
> state to change to the expected state. This is not enough since carrier
> loss events can be delayed by the kernel for up to one second (see
> __linkwatch_run_queue()), leading to sporadic failures.
>
> Fix by increasing the busy wait period to two seconds.
>
> Fixes: dca12e9ab760 ("selftests: net: Add a VLAN bridge binding selftest")
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/netdev/20260616092733.3a31be4d@kernel.org/
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

