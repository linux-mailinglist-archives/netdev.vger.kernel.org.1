Return-Path: <netdev+bounces-269886-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBKQLzwtvWmI7QIAu9opvQ
	(envelope-from <netdev+bounces-269886-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:19:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 245082D96CD
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60509303A8ED
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 11:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A483D3A3E9D;
	Fri, 20 Mar 2026 11:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MfPRNA7a"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11513A1696;
	Fri, 20 Mar 2026 11:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774005365; cv=fail; b=KNo12w5/2UNUJmeUbAXOCgN9YKYvv5tZE8B8ySjbIU39g5U0ZjM8pwnYs0dRLtA0NfaXwU04A4wk1LXe5sh3XYm0/987nLwOk9kcM/ordo1nu40kS4exjW/L2Ic8IEskDnIs1CYEsG9sdFMs2k59FxibVKL3hI0Mf3IPJ1Ks2XE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774005365; c=relaxed/simple;
	bh=rUnEOea/zuLK6fs/3YzrUWoDG3Vvgzpj64QwPmt/WKE=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=rdj8ytHgXqhhWk12nhxD1vQqZO/cpAApLAOW47nvzeQFvNCq3NboaA1d/vxF1uiac98B7uIXdufeJURqXHpbLXIK449dIoCvpRXVJSfnKjYkAe1wf07ba5j886rkpmOgg1nn2hmzzOdTu/ztpcMbe6CCnB8W6WM53QSkYzsrmY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MfPRNA7a; arc=fail smtp.client-ip=40.107.208.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tg9Iz7raRjlksenemIEJdoYxHYdQzM85ILQIdooe+ZMB57nyChtqvNnLtcX5Z6r+VfJLV5zjVVlTmGATPWEAXhBgZgVIBW9K2zR8DtkxbZXKtKBZUId0FZ+6OLHvMheacVLP8pF1tYWfgOBz3ltrEDxc/20Zpcixvy4rVz71uHyLzg8DgatuS5hygTo8UcTFdExozIFmwX7cqX/a5DN5hCDZ8ypKZBkcb6C/uvXqY1juitT6oKjumcjuTq/pt81Zyod48HxabyFyV+qsAv1a03YqSLVmaPm7mtv0PiuX7r2LBeZhYPNmo8qHt5st9OHPUy+6hOLNGB3prmEydsSVQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUnEOea/zuLK6fs/3YzrUWoDG3Vvgzpj64QwPmt/WKE=;
 b=jab13eoTISpBIbIdpzGaxJyvXXK7Sj0AqigCujeZQATODZJ0KUQC58xgPLLkWcrtcxXfnN4NAFOA4NJlZbd6+PMulwxkwHDEWvxOYO/yOzzgBg8oWhYY5ruxWXRfVyXGoKWpLO095yx4VJvoiubH1JYM6w3FG+VOlbIW1+J4bmqkFVaWqgB9PwwsbRyh8XFAjUjdLgYfI2g6rnVLBK9/6R1rzAW7dJVH3ENQtfao/qazqLrzVkHtTD/QofRN9fFxxfVJgmFo0Z7M/h3TPbRp8p8CHhgE0ZYU3apRxxLfG4FQz1McEZy6CZf8JRhJN0KCg9Jo/l7hKjhyYg0TGUTpTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUnEOea/zuLK6fs/3YzrUWoDG3Vvgzpj64QwPmt/WKE=;
 b=MfPRNA7aW399S46+sSmFHm9F6R/Ze9gAxU+tRqp3zDH3QNcRZNMIlivWLqDoVnjGkrtQ9UEBPbNqoGd/QMN8zupSkziZdvxwqbvT/dGhNJRtgvYW9TZfTQCKhqHVyHCwGZfuMdvh3klbtkMIQFEIbt+tppr/m2TB+QnRyTwHywe7dz3mI3p3x0rjz60swI9Kn5QGMgfk50KzUn8lK4cn26IKatGwecNAPvlQUX8c3KcKglIQd8/EXo0RXuKRET8jVZtnfdleDNX1xqR44kv+YeCElxbO23UKKMUV63g3K9kBExuM/X5+x+H+KWbyN4wmbM1c67t9ThatUdRoYYbJ3w==
Received: from PH7PR13CA0023.namprd13.prod.outlook.com (2603:10b6:510:174::23)
 by CH1PPF4CBE7339A.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 20 Mar
 2026 11:15:58 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:510:174:cafe::12) by PH7PR13CA0023.outlook.office365.com
 (2603:10b6:510:174::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend Transport; Fri,
 20 Mar 2026 11:15:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 11:15:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 04:15:42 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 04:15:38 -0700
References: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
 <20260319160410.2515105-2-ioana.ciornei@nxp.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>, <petrm@nvidia.com>,
	<willemb@google.com>
Subject: Re: [PATCH net-next v3 1/9] selftests: forwarding: extend
 ethtool_std_stats_get with pause statistics
Date: Fri, 20 Mar 2026 12:15:21 +0100
In-Reply-To: <20260319160410.2515105-2-ioana.ciornei@nxp.com>
Message-ID: <87341uah0q.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|CH1PPF4CBE7339A:EE_
X-MS-Office365-Filtering-Correlation-Id: 137a9f4f-4ea9-4d3c-9c9e-08de86720ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	266XyrKxXYYaK+QtfVu+p+1iE9CbiD0XedbIX9lZkWihdAZb3S3X+Tiph4H/NdjXOvJElzvf6kRXtRJD5n5B6TplAxJP4j7DJecTb+/YWI6xhxIzxmUmFlTc/PMPELFrld1NPXN6TmBjQycJHjUhbsB6deCDKog6vDaL+nOsk4EUxjZGduyTpiGLWadwVWNxtkWOFxvH2eLfWv/LaTLr4JqnIgSxGcIcD8rnruWKPwohuiJNtilRHZcZQbX5kKxybKHPR2cefDaruqvTDk7t4MWX6dWb4hO+ARMyDU8ijQfs8rJ8vZZ58ebZHqNYaZPO/WVnUI3TInngijW6cLRaM4zuDyuvn+6zrYiqVAa/XNZclPYWh6XOvB2BKHnrz+0UcsvhRv/DkN96CWuY8PaeBFqFKKTL+1I77Bpl24SO1HNCd+hIxXv6yHaLdn2awKc8SyfTCINFwNShvXk1djingQdYaf6Ig3yOmfZb6VAhw3wP/ahHx3zxEzQt6+6TIVA3WYf9+hp8S6gUatNg1VNDsd7zBOYRd6VQHK8IAlbY7f+g6Pwt2t7LRiZUik6jDWspIk+6EZqY+K8kGLlmgSZBcjtw/4EpW5VHe3HzAQy93PCTRkhRa3yg/Cq08MNYlLI0QMpIQ0tkpm540kBo4HnI7wN/eiHDto4vRY2d+q34yxqifFi4mTFyQ8sLCGeFCsZpILP4wbuy1Ltll8VTJnc0pOJDVDwvcO/ocI7egWMOHj6EaIJTSUeyFlinH7Vy2D6pqeR/2+Rjo3jta3uZzguCuQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y6DhWnsltcICdwVGrCPJ/vVqPMM+zm9JsO9EFJi1Ywf4ecOBFFTSKIS+MgQVrzp3d9VmcuVzY2ZsLdlAxvPkNG1/srm/7gdDrTNiq8S/bddMKe5ge9eMHp5jbKXcRDir20nubVxT8WBQgrMCRlQzhc8+9NmETrLcAxI8uuD2maGKwWMrOpC1B5AXpjtW5EeJt5poSYYssTgxNSHx23zbayIMuBzyBb/cuOQf1Jdtc8w86zrsXPDI/TvOYtHbxkYKiTMI8lGioGgWu+02G/JZQ0wquhBieAbfhs/ZopZl0kMI2UOj5LaqEUeGRE3EM4+g096bjejqvQ3TWpvE+rk39HLGzukXicSGtAlanGQjUfoWyGoEHQ6Nr8vFVhQLtr2Ghp2QQVQhOn5Ji+10y6H22voDTrq+46ldHeuC5M/jzVNu1ioeFYU25RvYwRtmXzvd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 11:15:56.7246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 137a9f4f-4ea9-4d3c-9c9e-08de86720ef6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF4CBE7339A
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
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269886-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.973];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 245082D96CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Ioana Ciornei <ioana.ciornei@nxp.com> writes:

> Even though pause frame statistics are not exported through the same
> ethtool command, there is no point in adding another helper just for
> them. Extent the ethtool_std_stats_get() function so that we are able to
> interrogate using the same helper all the standard statistics.
>
> And since we are touching the else case, convert that as well to the jq
> --arg form in order to be easier to read.
>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

