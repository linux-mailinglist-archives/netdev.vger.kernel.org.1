Return-Path: <netdev+bounces-256714-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFZTFH1Rg2mJlQMAu9opvQ
	(envelope-from <netdev+bounces-256714-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 15:02:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E67AFE6CA0
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 15:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C165A301ADF9
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 14:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC6127B34D;
	Wed,  4 Feb 2026 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="D1IO/N4R"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013031.outbound.protection.outlook.com [40.107.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0DE27B32B;
	Wed,  4 Feb 2026 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770213687; cv=fail; b=DP6DLGkxU9QzzP38pk76AAsbjvoQsYzFn3xn4gMHjVxVBcxIML//nlAxILAi4uT3bnCttTwGalwve+6TdOsc12j4FtJGBRXOQTzTjZdqXPxqHcseSEbVwcXDA6x8wTkXUBwxoTfQMy+R9HuHmEN4WezA6SbPKb+n3QkTdCvpCac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770213687; c=relaxed/simple;
	bh=zPLCJ8uewrr5XdPqT3l3YZyqpwt19TqPWYlbFgbAeuA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FbTF3k2ZBNH0Vgfudc2IZGHbL6Z+O674Yma+ot7g4MkrLOCODyBFSi50eBdqmhIG/iIFw85vrB9OVKf4EY9Ygy7mve8JcHxG7fTLH+Ak4xW2sC4Q4xbwu9IKJiFgzTWir6o6jKCnxhd8kSUYtdFs4btvdWu4luMKEG9qnZoU03Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=D1IO/N4R; arc=fail smtp.client-ip=40.107.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFxkjwzF94JkPH78SdNHaDjSBPH7U9FuH7TddcMcd5/6fc3m3BZksrIC17xQBtV5/Q6BiTH8fwqlvJ8u81+QCzYGnWAf6vFV7XmYN5Ro0VsjUTi9Rf59SpEDVj0eYIPLyD6atKfSrIOjZJnuCvpBX3tdUBssHlCU0rDXLhkB2PtexGd3YN4EjlHsq4FvU6dLKCv8B9R5bGYpzQj2hcuGbVEAjSa4oz0jkvihuzrm9w+fRfeAxfuv2dItNWQBFVCQuVhdjNQC4Db7lZQiWrn8w7sW6d1gRIkLpYIcQatrkz0f1qz5u79pb08DuGIixZrWIh6OIam/ZBiQLov3J1/XuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZPYw7N9Hy0J/fd5Zt5rw7gCVVPcmwYG/a54pb972PI=;
 b=BxcF9A+28F0CtC2HpzqfV0XM5r8TMBcYEEb7b7Vi5TPt68hIB3vzxqWwtFnMdbr0y+XqoGBB6qgAfAIb8wUg7jMGurvTlCIYL5B4uVayGgS0op4yaUIzfK24J1aNZalbMY+MR0a8N/+iim2IQCqO15Tl7OHC+QCJ209iD74Q6JYWN19xUUu/Kbs6BzTsXXyvWWeTxQoug4H0k1ISwM6FEYHC24fBDvSaxxcle7npJX3HGPEHloKf7G33rnKXfqRzuOROpyPJQ3qQEin0urcayjR20d12MwCRtFYrSqnL+0bvaiB4BuT2zBcpquTDk/bsfvpOFRLxerCYb1NbN3aBqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=linux.dev smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZPYw7N9Hy0J/fd5Zt5rw7gCVVPcmwYG/a54pb972PI=;
 b=D1IO/N4REWMO0IV34bGAIqEUNe2TG6zlziVEaMCMred0RKm3IED73iJFLxHv8IdyKgcDY1h2Q3S4iix5POPxrA5pvTnFZ2Hx07W6x2Z+FIgoU1t9q6eKbjcrGRo/IYueG+PpNB82OVLuN85I6dK27hWiEqG7sin56+i5WOf+r5k=
Received: from BYAPR02CA0026.namprd02.prod.outlook.com (2603:10b6:a02:ee::39)
 by CY8PR10MB6513.namprd10.prod.outlook.com (2603:10b6:930:5f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 14:01:22 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::4b) by BYAPR02CA0026.outlook.office365.com
 (2603:10b6:a02:ee::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Wed,
 4 Feb 2026 14:01:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 14:01:20 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 08:00:52 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 08:00:52 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 4 Feb 2026 08:00:52 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 614E0qsT1657308;
	Wed, 4 Feb 2026 08:00:52 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 614E0oGY002180;
	Wed, 4 Feb 2026 08:00:51 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <vadim.fedorenko@linux.dev>, <jacob.e.keller@intel.com>,
	<horms@kernel.org>, <parvathi@couthit.com>, <afd@ti.com>, <m-malladi@ti.com>,
	<vladimir.oltean@nxp.com>, <rogerq@kernel.org>, <danishanwar@ti.com>,
	<pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
Subject: [PATCH net-next v2 1/2] net: ti: icssg-prueth: Add Frame Preemption MAC Merge support
Date: Wed, 4 Feb 2026 19:30:43 +0530
Message-ID: <20260204140044.4086725-2-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204140044.4086725-1-m-malladi@ti.com>
References: <20260204140044.4086725-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|CY8PR10MB6513:EE_
X-MS-Office365-Filtering-Correlation-Id: 48eda0c5-dd6b-44de-e2b4-08de63f5dfd3
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|7053199007|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XDYqG5Oh1HNcfLDte3lQCm3X6CVIe4zoB1uX9x2k9rUVLAzj9mpvX1kWbIj3?=
 =?us-ascii?Q?gZtwzcZIUxg+7fCoB+X4dQEeN+ZJRyP+lyeJuk/cnsA38lVPrLN2FvPPXFUD?=
 =?us-ascii?Q?kCfpV4HFsIVspkPpXrQsRz6gvfqCDS42vOXHxKicUtgLZmfQqsLoLJmjAyfu?=
 =?us-ascii?Q?tyDJuiKEf0FZeg6zHazteXphAzM93now68tueKKexid4la7eSjhauqnRwgsH?=
 =?us-ascii?Q?i+qVXgbvSwpFtcVPcA1zFBZ52Yvwuuh91TYwUk2NW+QhZd7t4an09Crl/Car?=
 =?us-ascii?Q?ArWb4GRWqLGCIIayQgW/2L34fk20rBwMoSMJdQHqJBV4zqcpEWWjx2vUC4Vv?=
 =?us-ascii?Q?UyJORyIy5Xd1Ec1TA7Ibb+Z/xrFhKcaLfJf4Fo7iKyRQlMatBYxJwjNoGavK?=
 =?us-ascii?Q?etCTV3TI9oE0GEM6gmLdycUyFoZABwoXCHwv7xCDRLEcNglmV2Evy+kCSsQl?=
 =?us-ascii?Q?QQlBwEu4zFubal38+Okxgo50mhmiH5KWxqUfWTzDXhLNp8hsAbhtogs6OCbv?=
 =?us-ascii?Q?nHsAAnL1HLBwb+GPjWife6EWh+sZO534TEmGoZN5YCKz5OF7Eo5wGc56sbQx?=
 =?us-ascii?Q?FLAbnY4gqxdx1+pZiX7rE7FA9D6p4rg+dAr5ofDZaxxgb0mX5U+UOKo0u+co?=
 =?us-ascii?Q?fW4pNhf/FrEicyKrYYIu4mmF3PxToxiJDB3X35F+dIQwHSYpAQRbdbhaPfb0?=
 =?us-ascii?Q?+rjfiBuyRpV9bIE03RrQlJ7pJDTbX0iZUrCc4svvMToHGmB8i2kRi3Ya3tuo?=
 =?us-ascii?Q?mEm5UR1IF8RMauvhAG5aw+WbkWGYfaaxORnQiKtX+yZXSighYi7bvOXHKEOa?=
 =?us-ascii?Q?dqM2BFzT94Iv61HLNEvDj/gBFFr/yf7hgeBsQt4Li1QkaZbrRkGHITezdLXF?=
 =?us-ascii?Q?4QCn3cY1me/86xOSbdHLoqdPO93F7xN7YurEtnlht3ZC0a9uxiGZrRaSnK1P?=
 =?us-ascii?Q?2mOeslyX9jHQS1wEjplQfc5uHM3dm3P39z2q4nsSJzLF+Lhk9hx2ISIz3V/m?=
 =?us-ascii?Q?ZHFJAqEuN9wdGN7Bs+UU3zsxr2VGOb5d79FapNhUPeoxJRysWlL/MM2J4TBG?=
 =?us-ascii?Q?hr2iwNZZYfLCtcLM5Zqi1Lz2jUxx/GbClzVhcYlzXtuPl6Y4+dUcEM2gLuZG?=
 =?us-ascii?Q?GtzeeLYvJ/hiVJ/GO91wtDlKyVMnNZuS/rc9b76VnkPxs5g7K92KSVp/mVSN?=
 =?us-ascii?Q?9I+zU1D/KbaCU3lrqG4F3dFNXkA3ldwmyjy8o/OpzS1Mfnsldj/cCHuFyl8o?=
 =?us-ascii?Q?vz/09wRXwqFgtpO0yabHk1XRkR8LOzmepzyzV2COVPHpcMq8Dx9tVmWVOhcP?=
 =?us-ascii?Q?wt1LUMAJrjc4b8wLzDIgAfs+rE+7ojZG9I8VAzYp9bTXRWfvCv9fIsubaRrI?=
 =?us-ascii?Q?dKjfnu6s4Q6uTuh/rCsV8YIhAOwseJ7THebzcRH44EUz/JIV1AsZaxnd3Ged?=
 =?us-ascii?Q?N7qvRX93ptANUxFb6nZ18YwiLjafMcPK+tfATdeYvxZeGe52nM/KhNaNOFPX?=
 =?us-ascii?Q?IqctW23xZ9VF87mjhKDdocaD2KLzzbeQpoA7Q+ZYhigFy0A5sEajGXSu8DOy?=
 =?us-ascii?Q?/wjhC4NPss+rF+uupuAQG2OoTOR1u3y2n/+2osKRkuTrOFaZ+wIzQCVIF9aP?=
 =?us-ascii?Q?8+D9Ty2RdRF7OIUABUrMpAA=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(7053199007)(921020)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Z0JzEaZZRAK3w7NmFpUcZVLVEI32n6zcvv5PNrUs16LvtdUcb318JdHWUFAbPlFxjxZ+88BdBbtP6jd0XjCte4vz9ZTE1ytb+sKE7yHIgJn/xcZlrHtBkIcj2Bz+M5+gV+5w3ZLcS1NJF7L2f9P6YxcP4Pzy+QHk2nD/5p0ukDjKvWJyMxTOiSKeiU5q+4Tol8IdhxXm2+4iqnJIsipzRh/QtqYll+CDX85AQbMrZre0VCm16MdMhgYzaGN/IW7Stq4ef0U/gXSj2kxco7LEIAjD8JKtiX+W5A07iv2D1NazJM6TNyKN3aIputzxubc2Pqx3Brzk/WHA8E6wbbK4lUeXpCLgyfvRd9vcMYb3ffUE1OWxeS6ZlReZVQkHw3CauPn6fdcupaxg3ilrxYnGqbJaMNx2yM9bJSNi3bV1Hn3vYdalx/rUwcXREy9I5eBi
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 14:01:20.5224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48eda0c5-dd6b-44de-e2b4-08de63f5dfd3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6513
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256714-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:dkim,ti.com:email,ti.com:url,ti.com:mid,nxp.com:email,linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: E67AFE6CA0
X-Rspamd-Action: no action

From: MD Danish Anwar <danishanwar@ti.com>

This patch introduces qos support for the icssg driver. This
includes adding support to configure mqprio qdisc and IET FPE.
By default all the queues are marked as express which can be
overwritten by the mqprio tc mask passed by tc qdisc.

icssg_config_ietfpe() work thread takes care of configuring
IET FPE in the firmware and triggering the verify state machine
based on the MAC Merge sublayer parameters set by the ethtool.
The firmware handles the cleanup after successful mac verification.
And in case the remote peer fails to respond to verify command
before the timeout (5secs), then FPE is disabled by firmware.

During link up/down, verify state machine gets triggered again
based on the state of fpe_enabled and fpe_active.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---

v2-v1:
- Move icssg_qos_link_up/down() to if-statement right above as suggested by
Vadim Fedorenko <vadim.fedorenko@linux.dev>
- Fix p_mqprio dereference without initialization as flagged by Simon Horman <horms@kernel.org>
- Following changes as suggested by Vladimir Oltean <vladimir.oltean@nxp.com>:
* Provide more detailed commit message
* Fix the ordering of the functions to avoid forward declarations
* Fix the bug w.r.t scheduling work: fpe_config_task without initialising it
* Fix the logic for icssg_iet_set_preempt_mask() - configure the queues based on user requests only.
* Remove prueth_mqprio_validate() as this duplicates what "caps->validate_queue_counts = true" does.
* Remove clearing PRE_EMPTION_ENABLE_TX on failure which is irrelevant - ACTIVE status never transitions to true.
* Fix handling of these flags: iet->configured<->iet->fpe_enabled and iet->fpe_enabled<->iet->fpe_active
* Schedule asynchronous work without waiting for any timeout
* Remove cancel_fpe_config argument from prueth_qos_iet structure - no reader
* Remove mentioning "priv flags" in the comments for prueth_qos_iet struct

 drivers/net/ethernet/ti/Makefile             |   2 +-
 drivers/net/ethernet/ti/icssg/icssg_config.h |   9 -
 drivers/net/ethernet/ti/icssg/icssg_prueth.c |   5 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |   2 +
 drivers/net/ethernet/ti/icssg/icssg_qos.c    | 216 +++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_qos.h    |  58 +++++
 6 files changed, 282 insertions(+), 10 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h

diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index 93c0a4d0e33a..2f588663fdf0 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -35,7 +35,7 @@ ti-am65-cpsw-nuss-$(CONFIG_TI_K3_AM65_CPSW_SWITCHDEV) += am65-cpsw-switchdev.o
 obj-$(CONFIG_TI_K3_AM65_CPTS) += am65-cpts.o
 
 obj-$(CONFIG_TI_ICSSG_PRUETH) += icssg-prueth.o icssg.o
-icssg-prueth-y := icssg/icssg_prueth.o icssg/icssg_switchdev.o
+icssg-prueth-y := icssg/icssg_prueth.o icssg/icssg_switchdev.o icssg/icssg_qos.o
 
 obj-$(CONFIG_TI_ICSSG_PRUETH_SR1) += icssg-prueth-sr1.o icssg.o
 icssg-prueth-sr1-y := icssg/icssg_prueth_sr1.o
diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
index 60d69744ffae..1ac202f855ed 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
@@ -323,13 +323,4 @@ struct prueth_fdb_slot {
 	u8 fid;
 	u8 fid_c2;
 } __packed;
-
-enum icssg_ietfpe_verify_states {
-	ICSSG_IETFPE_STATE_UNKNOWN = 0,
-	ICSSG_IETFPE_STATE_INITIAL,
-	ICSSG_IETFPE_STATE_VERIFYING,
-	ICSSG_IETFPE_STATE_SUCCEEDED,
-	ICSSG_IETFPE_STATE_FAILED,
-	ICSSG_IETFPE_STATE_DISABLED
-};
 #endif /* __NET_TI_ICSSG_CONFIG_H */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index f65041662173..1e4bc5fd636e 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -374,9 +374,11 @@ static void emac_adjust_link(struct net_device *ndev)
 			spin_unlock_irqrestore(&emac->lock, flags);
 			icssg_config_set_speed(emac);
 			icssg_set_port_state(emac, ICSSG_EMAC_PORT_FORWARD);
+			icssg_qos_link_up(ndev);
 
 		} else {
 			icssg_set_port_state(emac, ICSSG_EMAC_PORT_DISABLE);
+			icssg_qos_link_down(ndev);
 		}
 	}
 
@@ -967,6 +969,8 @@ static int emac_ndo_open(struct net_device *ndev)
 	if (ret)
 		goto destroy_rxq;
 
+	icssg_qos_init(ndev);
+
 	/* start PHY */
 	phy_start(ndev->phydev);
 
@@ -1421,6 +1425,7 @@ static const struct net_device_ops emac_netdev_ops = {
 	.ndo_hwtstamp_get = icssg_ndo_get_ts_config,
 	.ndo_hwtstamp_set = icssg_ndo_set_ts_config,
 	.ndo_xsk_wakeup = prueth_xsk_wakeup,
+	.ndo_setup_tc = icssg_qos_ndo_setup_tc,
 };
 
 static int prueth_netdev_init(struct prueth *prueth,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 10eadd356650..7a586038adf8 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -44,6 +44,7 @@
 #include "icssg_config.h"
 #include "icss_iep.h"
 #include "icssg_switch_map.h"
+#include "icssg_qos.h"
 
 #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
 #define PRUETH_MIN_PKT_SIZE     (VLAN_ETH_ZLEN)
@@ -255,6 +256,7 @@ struct prueth_emac {
 	struct bpf_prog *xdp_prog;
 	struct xdp_attachment_info xdpi;
 	int xsk_qid;
+	struct prueth_qos qos;
 };
 
 /* The buf includes headroom compatible with both skb and xdpf */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c b/drivers/net/ethernet/ti/icssg/icssg_qos.c
new file mode 100644
index 000000000000..8d17b28357f8
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_qos.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Texas Instruments ICSSG PRUETH QoS submodule
+ * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#include "icssg_prueth.h"
+#include "icssg_switch_map.h"
+
+static void icssg_iet_set_preempt_mask(struct prueth_emac *emac, u8 preemptible_tcs)
+{
+	void __iomem *config = emac->dram.va + ICSSG_CONFIG_OFFSET;
+	struct prueth_qos_mqprio *p_mqprio = &emac->qos.mqprio;
+	struct tc_mqprio_qopt *qopt = &p_mqprio->mqprio.qopt;
+	int prempt_mask = 0, i;
+	u8 tc;
+
+	/* Configure the queues based on the preemptible tc map set by the user */
+	for (tc = 0; tc < p_mqprio->mqprio.qopt.num_tc; tc++) {
+		/* check if the tc is preemptive or not */
+		if (preemptible_tcs & BIT(tc)) {
+			for (i = qopt->offset[tc]; i < qopt->offset[tc] + qopt->count[tc]; i++) {
+				/* Set all the queues in this tc as preemptive queues */
+				writeb(BIT(4), config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
+				prempt_mask &= ~BIT(i);
+			}
+		} else {
+			/* Set all the queues in this tc as express queues */
+			for (i = qopt->offset[tc]; i < qopt->offset[tc] + qopt->count[tc]; i++) {
+				writeb(0, config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
+				prempt_mask |= BIT(i);
+			}
+		}
+		writeb(prempt_mask, config + EXPRESS_PRE_EMPTIVE_Q_MASK);
+		netdev_set_tc_queue(emac->ndev, tc, qopt->count[tc], qopt->offset[tc]);
+	}
+}
+
+static void icssg_config_ietfpe(struct work_struct *work)
+{
+	struct prueth_qos_iet *iet =
+		container_of(work, struct prueth_qos_iet, fpe_config_task);
+	void __iomem *config = iet->emac->dram.va + ICSSG_CONFIG_OFFSET;
+	struct prueth_qos_mqprio *p_mqprio =  &iet->emac->qos.mqprio;
+	bool enable = !!atomic_read(&iet->enable_fpe_config);
+	int ret;
+	u8 val;
+
+	if (!netif_running(iet->emac->ndev))
+		return;
+
+	/* Update FPE Tx enable bit (PRE_EMPTION_ACTIVE_TX) if
+	 * fpe_enabled is set to enable MM in Tx direction
+	 */
+	writeb(enable ? 1 : 0, config + PRE_EMPTION_ENABLE_TX);
+
+	/* If FPE is to be enabled, first configure MAC Verify state
+	 * machine in firmware as firmware kicks the Verify process
+	 * as soon as ICSSG_EMAC_PORT_PREMPT_TX_ENABLE command is
+	 * received.
+	 */
+	if (enable && iet->mac_verify_configure) {
+		writeb(1, config + PRE_EMPTION_ENABLE_VERIFY);
+		writew(iet->tx_min_frag_size, config + PRE_EMPTION_ADD_FRAG_SIZE_LOCAL);
+		writel(iet->verify_time_ms, config + PRE_EMPTION_VERIFY_TIME);
+	}
+
+	/* Send command to enable FPE Tx side. Rx is always enabled */
+	ret = icssg_set_port_state(iet->emac,
+				   enable ? ICSSG_EMAC_PORT_PREMPT_TX_ENABLE :
+					    ICSSG_EMAC_PORT_PREMPT_TX_DISABLE);
+	if (ret) {
+		netdev_err(iet->emac->ndev, "TX preempt %s command failed\n",
+			   str_enable_disable(enable));
+		writeb(0, config + PRE_EMPTION_ENABLE_VERIFY);
+		iet->verify_status = ICSSG_IETFPE_STATE_DISABLED;
+		return;
+	}
+
+	if (enable && iet->mac_verify_configure) {
+		ret = readb_poll_timeout(config + PRE_EMPTION_VERIFY_STATUS, iet->verify_status,
+					 (iet->verify_status == ICSSG_IETFPE_STATE_SUCCEEDED),
+					 USEC_PER_MSEC, 5 * USEC_PER_SEC);
+		if (ret) {
+			iet->verify_status = ICSSG_IETFPE_STATE_FAILED;
+			netdev_err(iet->emac->ndev,
+				   "timeout for MAC Verify: status %x\n",
+				   iet->verify_status);
+			return;
+		}
+	} else if (enable) {
+		/* Give f/w some time to update PRE_EMPTION_ACTIVE_TX state */
+		usleep_range(100, 200);
+	}
+
+	if (enable) {
+		val = readb(config + PRE_EMPTION_ACTIVE_TX);
+		if (val != 1) {
+			netdev_err(iet->emac->ndev,
+				   "F/w fails to activate IET/FPE\n");
+			return;
+		}
+		iet->fpe_active = true;
+	} else {
+		iet->fpe_active = false;
+	}
+
+	netdev_info(iet->emac->ndev, "IET FPE %s successfully\n",
+		    str_enable_disable(iet->fpe_active));
+	icssg_iet_set_preempt_mask(iet->emac, p_mqprio->preemptible_tcs);
+}
+
+void icssg_qos_init(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+
+	/* Init work queue for IET MAC verify process */
+	iet->emac = emac;
+	INIT_WORK(&iet->fpe_config_task, icssg_config_ietfpe);
+}
+
+static int emac_tc_query_caps(struct net_device *ndev, void *type_data)
+{
+	struct tc_query_caps_base *base = type_data;
+
+	switch (base->type) {
+	case TC_SETUP_QDISC_MQPRIO: {
+		struct tc_mqprio_caps *caps = base->caps;
+
+		caps->validate_queue_counts = true;
+		return 0;
+	}
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int emac_tc_setup_mqprio(struct net_device *ndev, void *type_data)
+{
+	struct tc_mqprio_qopt_offload *mqprio = type_data;
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
+	struct prueth_qos_mqprio *p_mqprio;
+	u8 num_tc = mqprio->qopt.num_tc;
+	int tc, offset, count;
+
+	p_mqprio = &emac->qos.mqprio;
+
+	if (!num_tc) {
+		netdev_reset_tc(ndev);
+		p_mqprio->preemptible_tcs = 0;
+		goto reset_tcs;
+	}
+
+	memcpy(&p_mqprio->mqprio, mqprio, sizeof(*mqprio));
+	p_mqprio->preemptible_tcs = mqprio->preemptible_tcs;
+	netdev_set_num_tc(ndev, mqprio->qopt.num_tc);
+
+	for (tc = 0; tc < num_tc; tc++) {
+		count = qopt->count[tc];
+		offset = qopt->offset[tc];
+		netdev_set_tc_queue(ndev, tc, count, offset);
+	}
+
+reset_tcs:
+	icssg_iet_set_preempt_mask(emac, p_mqprio->preemptible_tcs);
+
+	return 0;
+}
+
+int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
+			   void *type_data)
+{
+	switch (type) {
+	case TC_QUERY_CAPS:
+		return emac_tc_query_caps(ndev, type_data);
+	case TC_SETUP_QDISC_MQPRIO:
+		return emac_tc_setup_mqprio(ndev, type_data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+EXPORT_SYMBOL_GPL(icssg_qos_ndo_setup_tc);
+
+void icssg_qos_link_up(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+
+	/* Enable FPE if not active but fpe_enabled is true
+	 * and disable FPE if active but fpe_enabled is false
+	 */
+	if (!iet->fpe_active && iet->fpe_enabled) {
+		/* Schedule IET FPE IET FPE enable */
+		atomic_set(&iet->enable_fpe_config, 1);
+	} else if (iet->fpe_active && !iet->fpe_enabled) {
+		/* Schedule IET FPE IET FPE disable */
+		atomic_set(&iet->enable_fpe_config, 0);
+	} else {
+		return;
+	}
+	schedule_work(&iet->fpe_config_task);
+}
+
+void icssg_qos_link_down(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+
+	/* disable FPE if active during link down */
+	if (iet->fpe_active) {
+		/* Schedule IET FPE IET FPE disable */
+		atomic_set(&iet->enable_fpe_config, 0);
+		schedule_work(&iet->fpe_config_task);
+	}
+}
diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.h b/drivers/net/ethernet/ti/icssg/icssg_qos.h
new file mode 100644
index 000000000000..8aa79b68ad54
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_qos.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#ifndef __NET_TI_ICSSG_QOS_H
+#define __NET_TI_ICSSG_QOS_H
+
+#include <linux/atomic.h>
+#include <linux/netdevice.h>
+#include <net/pkt_sched.h>
+
+enum icssg_ietfpe_verify_states {
+	ICSSG_IETFPE_STATE_UNKNOWN = 0,
+	ICSSG_IETFPE_STATE_INITIAL,
+	ICSSG_IETFPE_STATE_VERIFYING,
+	ICSSG_IETFPE_STATE_SUCCEEDED,
+	ICSSG_IETFPE_STATE_FAILED,
+	ICSSG_IETFPE_STATE_DISABLED
+};
+
+struct prueth_qos_mqprio {
+	struct tc_mqprio_qopt_offload mqprio;
+	u8 preemptible_tcs;
+};
+
+struct prueth_qos_iet {
+	struct work_struct fpe_config_task;
+	struct prueth_emac *emac;
+	atomic_t enable_fpe_config;
+	/* Set when IET frame preemption is enabled via ethtool */
+	bool fpe_enabled;
+	/* Set when the IET MAC Verify state machine is enabled
+	 * via ethtool
+	 */
+	bool mac_verify_configure;
+	/* Min TX fragment size, set via ethtool */
+	u32 tx_min_frag_size;
+	/* wait time between verification attempts in ms (according to clause
+	 * 30.14.1.6 aMACMergeVerifyTime), set via ethtool
+	 */
+	u32 verify_time_ms;
+	/* Set if IET FPE is active */
+	bool fpe_active;
+	/* State of verification state machine */
+	enum icssg_ietfpe_verify_states verify_status;
+};
+
+struct prueth_qos {
+	struct prueth_qos_iet iet;
+	struct prueth_qos_mqprio mqprio;
+};
+
+void icssg_qos_init(struct net_device *ndev);
+void icssg_qos_link_up(struct net_device *ndev);
+void icssg_qos_link_down(struct net_device *ndev);
+int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
+			   void *type_data);
+#endif /* __NET_TI_ICSSG_QOS_H */
-- 
2.43.0


