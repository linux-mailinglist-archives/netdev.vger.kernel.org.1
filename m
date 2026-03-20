Return-Path: <netdev+bounces-269896-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMIBLcswvWmI7QIAu9opvQ
	(envelope-from <netdev+bounces-269896-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:34:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 343002D9A5E
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EFE8306243C
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 11:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D73D3AA519;
	Fri, 20 Mar 2026 11:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fIWL64my"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011039.outbound.protection.outlook.com [52.101.57.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4ED3A872B;
	Fri, 20 Mar 2026 11:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774006265; cv=fail; b=V6Y1DvY604QtlLZlHbOpqomQTYys3wbJqo9oB6BnJ9l2qxcId7UMcjth/V7S+JPqz+t47DwMGJwk0UpMmqtQ19sc0wPCSziAZ+YFduL1aLx8fhxwwVBbJzKYsBZDPqjrwyXio6hKtnIKti7c7JcrH+Tw5U3c9i1TTseJ639ilEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774006265; c=relaxed/simple;
	bh=rgqzaAyWhXFwC9qi6ybtOixV76U8NPzi4S0HnnhIYds=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=r6LYse2B2ZE9Uxj/LXQJc9NbTxzbw6DH0FOfItlzFVck4dBxXmXQ0Sqjcd5vA7aKzlHi5LUQcjGHhNd0FFdvXRAbcyB7udr6ZGiNO36h6V9qQ/idg70UIAKUPTGC5q9Mnqn37cjAQ4P1TAcoBqP9cpuhd+ljjm0YMS37kRBBUy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fIWL64my; arc=fail smtp.client-ip=52.101.57.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rRMVXPtSmC5CLK+LYFuZ6EV6cqpKGIAl6WoyX6ai1rxjxhXwH5L5uSuSuQyAdxbzbb+zqBHdBI4+/J4Q9KMDHlT3w5WIc/tv1g53IR9wYlmKm+nxU/qi8NJLNQW6qRKEhFcvL10pv6RlR23M27BPkLA/9DZZT/MHeKRBlsMc66SUDOGItxy+Hkzoh6DWzt6GO+EXepFspAU6hvMBGQ+G7bKZtzhv4r8Mk1y1+OOQNP3bSv/vek5Sl0anBtKdWGkXSs+M9a7smTUiCaf6tUdehu8xhro9vmueeHVwHNxt/PwTd/M90n8M+sbukn01FEEe2lQDUK9e78OK5KRiq89exQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgqzaAyWhXFwC9qi6ybtOixV76U8NPzi4S0HnnhIYds=;
 b=iu7b3ZcH6YfrZsmyFwWXg/pzaWom5GQEc2lHpTSb8fBkP+26nwviSNYGZyj5BTRCbeXRY5dqze/KgVqLP2Ta0uu//XZQfp8knGaF0AiEKUpOaFGzm+yLI/uNMoyLTh5DLx5yThG3fSe9E4plIuBLUyga4DpY7SRBJV6UX0luCgfZO2+g59afuurA/oBlLTsRdJRFz09KK7sAm9yBMteiXpW/cuT25DLGEMN7nIyhp27ohXpxjGQ1hjLEeUEdQcrhYMqpOFcGxdUYrLgq4LEw1HLQ6ZXcCkgSls2FL9eAK2ZGx0uPFUlx3E6XSC65uyBXijlfglbJQF/ieL90RI8EdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgqzaAyWhXFwC9qi6ybtOixV76U8NPzi4S0HnnhIYds=;
 b=fIWL64mydFHKT+2wyoNyS7VVMqzfleroAYjdqw6GAY22VjF5fLtDcOOnUkp9BqT9Xf723yUpKi4sdu3RfFnGO2XLXXuWqQhXIJMQs7foHTefHsBcBwdzE87O7+szz9wIqRfASZTLNu45sUYt2W4//O/vi1psDg/YMR4wziUhh9m8ptLqXAf2ACjyWEpSnMcTdJ0ZAMSTXrE/o9wDNbIW78rWOmzydvUwO7VXv+sy6Wlx/2gO95Svtdyqn9Vmp10r+MmCM5KU3Me9p74MYKT+w6/vfW4NOF+eGjVBA9PSFHGIxxPYg0IMnyi+nidK15SHBtnvBmjTdYfyT5ovj45GmQ==
Received: from DS7PR03CA0227.namprd03.prod.outlook.com (2603:10b6:5:3ba::22)
 by LV3PR12MB9235.namprd12.prod.outlook.com (2603:10b6:408:1a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Fri, 20 Mar
 2026 11:30:53 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:5:3ba:cafe::ac) by DS7PR03CA0227.outlook.office365.com
 (2603:10b6:5:3ba::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.20 via Frontend Transport; Fri,
 20 Mar 2026 11:30:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 11:30:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 04:30:32 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 04:30:26 -0700
References: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
 <20260319160410.2515105-6-ioana.ciornei@nxp.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>, <petrm@nvidia.com>,
	<willemb@google.com>
Subject: Re: [PATCH net-next v3 5/9] selftests: drivers: hw: cleanup
 shellcheck warnings in the rmon test
Date: Fri, 20 Mar 2026 12:29:10 +0100
In-Reply-To: <20260319160410.2515105-6-ioana.ciornei@nxp.com>
Message-ID: <87h5qa91rn.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|LV3PR12MB9235:EE_
X-MS-Office365-Filtering-Correlation-Id: 24ce717a-9e97-414a-e17a-08de867424d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zn9CsWKaCEXSz3GBzNAtX0r3RuB9mFLmvl+aBGE4RhkRnHJvllwlsLKxAy4Yp88iZjI9h/qOw6e1KX6GqLsWSSFWjjXhiBQmQAH4emJu2VH8Oy04qpgi/lay65ANRJIGaYMt0NmAtDivHc9WT62qAZSLFgtq1BblvdqQxbqlAdQCYTNIBCa2gfpUMWl/kM8uiK1INlanNJpn8Fuopi6AjVfUIyApBXNlnDsqTS0BNsjy6m6Gk6s/TzWGdtvtg1DPR4uHwSbz4a2lfbQiGOAOZBAth/8esLsI9ExeNsYvB57YjCvkRc79UnVfNA+faiP1Bnwd8R86GY8GZIFrKQ0ktFms5lV2mUz3YpjD1VzojZyYVrgGgf6Z3vgB7frPmNKapdokIAP5rqwTWhnLIaH9vs40tc0HPe5gIdJv9oHVeqpACSLXl7E/s/gqVKRQbp4YKB/KzaFR/gE62DXi31srLU1XRtPjxtBLdTre1s2JGgwfL9inKC4i2EwG25lkjNTyNuy6Ne2dxdfeyKd+1jRLZ+Xzd/tz4342wlFIRjurKxqgR5iK/KCR++7Cdub3ntrOpNVQ5AiZzyao+4sDrKyi6ptcSsSjkUnjx+GTIeknd1JjX5y3k52dq5OisilHUWyN8KWVavMjNc0esTq0HMWK3ugSBYasj9WlErH4MzJul18udOw5zAr2FfGAV7AGG3O8QWNOjjfvvgWz9lbjIW6+lKfTXVvqfaXQvqdOzdEzU0PF7afJFnbkf0XbsiuK+N3bFNDQpLEzd/yJvqQngFPntQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Jybkp9BKhSmEF3RfNzxJYBUeWm1w5DfWZViH/5SEicDQON3lindfP1qalVqMWp3Imv24dR05WFIdK91eE/4xefsr7ZewFv1wWKthJRq0vF9GlJAIwws25IwyPkFwH5L+CZfsJZ9G3v7NYxkqbjpdbnfHrysNxtHxeThLKNuDLPH1awGGGcr+htj9d6wtnQ/edPg7PWnpnvimblMonntjyP92xy2EOvq9XNDVRjuaT/fIjasDO1u8bLPBtLKNYxZbtQsd5JlbsDpxG1OieWnCbN7z2zYok8ipr6xSE/COh7hSerWAvBaE4majtomohhKR4P6L58ZanDp3zJ7jqw/fXqEE2UMTicip0NacselGYjyqn0UKYO4bJJI+aFslNcRDX1lIZcVkhkNka2HzuKOKdv9tUancT+4W3wqzA9IQDEAdzX2bIpdjQiXlLg4SdtEO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 11:30:52.4127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ce717a-9e97-414a-e17a-08de867424d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9235
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269896-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.959];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 343002D9A5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Ioana Ciornei <ioana.ciornei@nxp.com> writes:

> If run on the ethtool_rmon.sh script, shellcheck generates a bunch of
> false positive errors. Suppress those checks that generate them.
>
> Also cleanup the remaining warnings by using double quoting around the
> used variables.
>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

