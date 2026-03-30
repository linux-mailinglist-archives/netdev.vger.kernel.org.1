Return-Path: <netdev+bounces-273146-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFJMKstlymll8gUAu9opvQ
	(envelope-from <netdev+bounces-273146-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:00:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF5A35AB61
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 76E7C300E49A
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 11:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A8F3CA4A0;
	Mon, 30 Mar 2026 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fUVUALkz"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011010.outbound.protection.outlook.com [40.107.208.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43AF3CA48E;
	Mon, 30 Mar 2026 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774871900; cv=fail; b=VnyMNvaK84dfegDg31WynHPvBMbxuuL1tCXPCoX0BFtKQGIJW6eJ06sjQogAEh3xipOhr/1dFI73Oy4ZDoJL64cEAAx/yfbT4YAFeLO/8gtl0UgZ82VTWA4m9t5OPh6unDK2UYGAP58jxm1ysf73gJICF/8teO/2JFHbDwSCyAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774871900; c=relaxed/simple;
	bh=poyCU0gVenpJczlCNQ+LVtrZA+FvLP4d2cvB9n+Th/w=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=eXS3NODJhk41cBtaPbEpOgTVjCdp8pYhXYNkwjpPkcpmCLL3RjOlh6gmq+Hba6VNYNJvMAP+I75CVRqhRibnuosRIM7vGwwR0W4w8o2NCcRYDBPgSos6RFfqUkh0E3VQaYUMzmwXsnk2NrUXvPMHq6N/Af91UA3utI6GoGfr7jI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fUVUALkz; arc=fail smtp.client-ip=40.107.208.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eU5sQaf1KUWLlphXjrnktPP6OGNL1tZS8c0d9gCrC+CYLX9j63XN34AZdb5hGO2faX5vedyy6Y2+Nm4zupJWUSluxB2mM+C6VTSJ/dJ9uY8RNR7FewCUk7PCEghZ49t/hlxCW1/PW24xaAHHvsYYBxFIODoz9Rf6zbtLr5I46N9qzVE/toR1OCXqx+vCWJM/tfiOQP3uqLEYnTbQ4hTPkeMw8jQz9AWoKvomuUlttEJ+vHWw1tMR4EiuNgm5IheTjx97z6ahNeVopxZ9JQsvU6jToMqA6DxlBkamPRbG9+tMrbpmaCQkFqxGgPHdlPXYT9CWupm9//8cNidR1HW+AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poyCU0gVenpJczlCNQ+LVtrZA+FvLP4d2cvB9n+Th/w=;
 b=HBLCAwESDiuJqBGH03Z+lWdGl2RCA9cKZcMmHDVgUAtCGGSElU7jomWxpkmAiNBnKsbyuiMBjmHlA78aisTWjNmez3ibhiLRn7Lg2tlC79M15dMWxsoLFa3hlBZyPYVuhfyFjh0zqBtOdVoacdCzF/3ei92qB8pvnlC40nXal/TEalkkZF1pRyScHuwth4G8P+Fd0ylfot4k6yLuooD5bM3EBY5UAmCYACkU7Fq4JIw6yIMlr6xeZE8/lCNYI4vCOWg4GowqJsbNWB9+lnao4u0XPEqz3b7xqtKq0ZWY97eQHY1PL0OqoxJVhACTdupX0V+wUZDQuZePwgzeYQkmXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poyCU0gVenpJczlCNQ+LVtrZA+FvLP4d2cvB9n+Th/w=;
 b=fUVUALkzEUazBCQI/vmZJ9a59a1qZ6gsQr0+ISQaj1eT3Lt/Dtfx7ursB0oueQDS+cVPJz3/Maa9eRC6wkc9+3Iv/Jx4hMnxroHA2j7j2tH/uF8kvSpFkR/MQO1xkCVR4PmaP01yV8/a+Yz4qiiOsnkPZ84sf/Y6Y7N1Um0Je3ctM187FKvDM6SNwI+wQkPgQE9JJFCbqScOHDbvCobDlQaiDzLv4loKqqJp019BuGmIz4AZZEMjMbe+7TBK8qt4KDw3uimSwFPfMMZlmo2a60Q1kGNwP9iBekLapBJvrS/K0tn+V2qGkc8cc8hoKyHo4t7Ndeox59jkn2dZsFG1nw==
Received: from PH7P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::22)
 by CH2PR12MB4118.namprd12.prod.outlook.com (2603:10b6:610:a4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 11:58:14 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:510:32a:cafe::b2) by PH7P221CA0005.outlook.office365.com
 (2603:10b6:510:32a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 11:58:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 11:58:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 04:58:00 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 04:57:54 -0700
References: <20260326132828.805703-1-ioana.ciornei@nxp.com>
 <20260326132828.805703-5-ioana.ciornei@nxp.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>, <petrm@nvidia.com>,
	<willemb@google.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v4 04/10] selftests: net: update some helpers
 to use run_on
Date: Mon, 30 Mar 2026 13:55:47 +0200
In-Reply-To: <20260326132828.805703-5-ioana.ciornei@nxp.com>
Message-ID: <87jyut4jib.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|CH2PR12MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 727b84de-6462-49a9-fcf6-08de8e539f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kbasqoZdOjDwb4u2AqFwmSNPki8ppJdSo6Eotd7WiFWBCZe0Q8TBS8AF4ZHuxZ+scAReJJoZ6abMeF5Trn7dclacg4AUoOvLbH/TEougamT88H1RLAHhAlstykoB/KLVVM/ZY2vSZHrpciFlktEVKPM2KnGMES2Aoyw1OT4RDSnsQpjKpuoklO4/+tW5T2zmcedLezeHj1hWBj2hTk6gwC/UzmNLtvG6hS7EvH9KB0FiVxBP84F1rsNa4YIMfGo8e9URwbCuxTLBx04+/G3ootI1gaqCYeIcNzNvC7/b+dcOkXjD3SLe98fyNw9+kLuKtb/uIAImcUo3mpfIs2hU6YoJTj4brmqRftplh5X0srLv9QDhsXcSHOY57yXRLFxmcg1if6/U1S9tSSD4TIN7AyGneK5bSxdcT1NZ64Qk+8sicj5qYJ2TBwOvFDcZy/xoyKHFxKJrZTD7zG5RbCetfmwBEqxu/fg/r8aqCRD+jXEYUV7VHVdk3WDVWuTRz1luNoVzkScEBcGGJ9RGJBl0rdqawXMGUPiBq/F75XoZej8a6uHBS9V/OHQ3Bx2uccFGRbEHA15a0kx+1TK/VM6yDzaGGHMS+jJ4kCuGAAqJadqGZRChvP2geTDQRaQm2ZksE6f0YMsL2/NTldZPqJxgR5NHdJ0iQ/Q9PAD8h9A+/73vUBKVjnRDJhcQIBmVbl02TP7+W1+Qn1/MWpVIaTuqxEmKR75uHeIL+lHWtIki4rnxRLmAd3q1R1BWoHEGNfkwsahzQNFFtdB8TjRcGqWVKg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	W+ssn055FTZh8l2q08KI+EI5QzNS5KxjtUPQH3Z0xlJYUzLmm2l0FF9o7gob1AFqQHBQshvsJUO//XV4J0zROvQDEYT23L9pUOECRnChlM9fCJ2ozhdOMac8T94y4mo7xK/9SlP1TFp3eKq+pJ8JnwJa/A6AISKzpbtoUxLhrcwYYfwnGHokipEcLKd9cTtOSHfI1Vmijb/HQALi9lNWWOgYzJxLj6SLvDyW9GfExENcK6uhroMeysqnxBc4bAGTJeB9MY2xETalGzI7ygY1R5C65MMFG7L2zhGAnrh+ITbWmPh0QVXjYf1BWIEUHVNW3Ij6jOkMzXz4du1GOnTQhVsAStaam7WNJq1SB6WGnY7vQr6OvTvE4cA5945CFLLvbWlOeXYhwqEtgxbSQIGN98UvlCu3WFhexunh9JJOCsDzpuk2TDcf7XbQi/4iTxLw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 11:58:14.0430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 727b84de-6462-49a9-fcf6-08de8e539f6f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4118
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273146-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nxp.com:email,ethtool_rmon.sh:url];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 9CF5A35AB61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Ioana Ciornei <ioana.ciornei@nxp.com> writes:

> Update some helpers so that they are capable to run commands on
> different targets than the local one. This patch makes the necesasy
> modification for those helpers / sections of code which are needed for
> the ethtool_rmon.sh test that will be converted in the next patches.
>
> For example, mac_addr_prepare() and mac_addr_restore() used when
> STABLE_MAC_ADDRS=yes need to ensure stable MAC addresses on interfaces
> located even in other namespaces. In order to do that, append the 'ip
> link' commands with a 'run_on $dev' tag.
>
> The same run_on is necessary also when verifying if all the interfaces
> listed in NETIFS are indeed available.
>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Looking good.

Reviewed-by: Petr Machata <petrm@nvidia.com>

