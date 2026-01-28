Return-Path: <netdev+bounces-254294-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cO4GO84femmv2wEAu9opvQ
	(envelope-from <netdev+bounces-254294-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:40:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CCDA2F70
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75E8A30BB5EC
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4277635B623;
	Wed, 28 Jan 2026 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="h7vH0Y1b"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011055.outbound.protection.outlook.com [52.101.65.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5249D35971A;
	Wed, 28 Jan 2026 14:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769610911; cv=fail; b=b7jL/K83Pw71CkB3D07SD2FNoyuwU+oIFuSDbijnDrX7T5Ul91Gg3pshBGf41Wp9xX7cf60Z31j7eRcgmhSQpDhJD6cjFoFNndkaZ78hdrCUR8srSCaCtyuEyHol2SgzIoruBO6y08BWz7L0ZdjWG/49vAlW2BUekLHN6xNd+Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769610911; c=relaxed/simple;
	bh=NOjgHNUrR2eTiioWi5DbDNX9/+lA1farWyPYGGCaByE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=en+p5UWZr0osCt8Ht1YXqOUkvWpZe78pAgeXHOm6Y/Pe309n8UNVWgA4cYpY6aeZwesA584Ra1lytKeXU+ZV9BYh6FKnt+cukSDUjpmItaMA3DRnrhedg941Zq2Tkw0Uovh8sPMiS1mlIcLg0v2e6c5hVBZFIoFHR8d6xRK0+Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=h7vH0Y1b; arc=fail smtp.client-ip=52.101.65.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVW4T6lH/S4PmOZz2MVmd/OPzbRgMWZ3wJGbev/R8Z+9WOM41n0R5vpyvKJfojA7z6WYtQ1E6nQxYrAXjBq/lfrXRAN3zAQ5cgUW9tdiASokYPzP3lqnmlChyXJQaEiMrTgav3pzIWioTx4ZJZo8rxzuUzbH3rgICWtsbsoSBCqADjZzdP/zBMCeo9mXgf9zJ35uIEN2BE6SX5v3yL2+b/kzBi6CGOy4N9zkWhrXzDsOrpSN7PqCYIM7PcU6JvCVB1gmLKxZZFUUKoEihOh5QXJFML/GwdP2eLa9PccXcudoPFCTxJVCeVe5P/RDAdY5HPV2Iw67g50UbEe2tcl0Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q90k8aAuiVl/K7KlBMwPy5+SxS2q7dMI2+RXkwhEjK8=;
 b=nyOVv0qleqRxHnYdrQc8zILyqYMj/59llzINhKRhowouuNdI+TE24qGP4jQ1lDTT1gi/r3uN3e83Aelj86ybZxQ3fuzDxsYXmvrWq562dTzJSAD19Mr2GnUchWn9p2vHEVZgf6yL1fFfEBTE5D/4bWX86ZgzW6CvFfe/ku2uk/oHe4ceafenEy7VFIambvGh8l/KCCHBGcYaxeIzyvibaxpb2hC5R3aRYSvBoatrU56bS6/hk5t4dAUMk7JT8V+XmKrIU4G3SLMPk2VNl2qpIlMoj6NwRfAW7as20ZU2lvHZxbXrBX1WDVzh2/K9OgWKd/rHXs4wR3EgtR6LlWU/Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q90k8aAuiVl/K7KlBMwPy5+SxS2q7dMI2+RXkwhEjK8=;
 b=h7vH0Y1bSKMzfdcQ5hU8TsssBmmQhszeu/TEtRm8dxvuo50F2HJaJVRexDyOZD/uOoTiqbOGUIT1JTonHgRtNwiOKwqyCgV6QQRUMolwSnrXeXaEhk2S86DwPNnKJ63VQwJ/BiEMwWXnxdjaF3hzPnfzW/7ByU2WCNoXXBYe+pOU2qDoahESt6vsy6+L/lV6KWN20eDEH1X1KSjkoqIyXfYFcEU3xNP2x6EtTNjIFjQjSgIgoRcon63ulKy2yNKUeh8MbZGvFT3cDnslp1xWe/bCUJWfTSbf9bUt8qq9TaOGwYmWwnSs8yuqEIOe/KjvLySo2yLmFQp8KRK1V6EYHQ==
Received: from CWLP265CA0494.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::13)
 by AS8PR07MB7670.eurprd07.prod.outlook.com (2603:10a6:20b:2a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Wed, 28 Jan
 2026 14:34:57 +0000
Received: from AM2PEPF0001C70F.eurprd05.prod.outlook.com
 (2603:10a6:400:18b:cafe::1a) by CWLP265CA0494.outlook.office365.com
 (2603:10a6:400:18b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Wed,
 28 Jan 2026 14:34:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM2PEPF0001C70F.mail.protection.outlook.com (10.167.16.203) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Wed, 28 Jan 2026 14:34:56 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 51540236BE;
	Wed, 28 Jan 2026 16:34:55 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	ast@fiberby.net,
	liuhangbin@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v12 net-next 09/15] tcp: accecn: retransmit SYN/ACK without AccECN option or non-AccECN SYN/ACK
Date: Wed, 28 Jan 2026 15:34:29 +0100
Message-Id: <20260128143435.15708-10-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128143435.15708-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260128143435.15708-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70F:EE_|AS8PR07MB7670:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: af2335e8-3986-4d25-83dc-08de5e7a68b4
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?WFRvaDGjm4S38aqFr6p6OH79QdoYOrEvfOluKKikkEhax5BP05l8H8IAxBfi?=
 =?us-ascii?Q?iUT4obMcldUtlBBi94j4tsESFLIO0Zm6YdR8/k3xvzm0ZPXuBFGs0AGoC8be?=
 =?us-ascii?Q?AoVGsYT+NpIdnDKQo3OUAq24qJhOj1pbKpPRsR0ucbln5CMZltdGBhwj27OH?=
 =?us-ascii?Q?wIUC9XhtBZ5KFeSzi2Val3OTP/IojMEYDre/gbamBJ99GQJj4CrqTSJOU8PL?=
 =?us-ascii?Q?nxDrZvqJWjY6NSCAo0qspelnjJW3KOUdO/OpK/IN9NjbKsKlpWNsNYb9R4ed?=
 =?us-ascii?Q?9I2csMrIE6eNp7VTjMb2X1dT6lzDQi7v4Wgj9QCriS6sGNgX3uP+3l6T+QOS?=
 =?us-ascii?Q?DeBEjPPwYd/5fgTXV6dSzYYazsb+VikGDMoykgY3aqpPR/Xrm4ban9HbyfX5?=
 =?us-ascii?Q?yTguexsrwIbnXC/t+CTW8rvhITs/95cY1X9tbC4mAW8+yXbsFXS9YNgXmpgt?=
 =?us-ascii?Q?u2Fh+qtl4ofASTk5Iiqo5Cz6vqLpHqG59GKLXH8vxDc8L9dfEa9P/uyUBI2y?=
 =?us-ascii?Q?x4Wq8O5bjNykAKpLyzK6ACza2A9kH8A7BO6eHQanj3TvFqcJWVzUxSVreBe6?=
 =?us-ascii?Q?YcwAKzhLAq5cb4nljUHrzYULFG+5zEKvF8XZrhz4ByjVmGUTzqBJWuuKalsV?=
 =?us-ascii?Q?s2B2VOeElqQpf80yz9ZMT5wokHbh5j+CmfWOMhQlS3piQfUubSE+phuVMhJC?=
 =?us-ascii?Q?iK13R94N9Y8Y9KpiJKBSVJFBfmfs7sxctTfhfYWVOPYWNR33yFao4dwsJVCL?=
 =?us-ascii?Q?XPmlrPdf7tN/4rmHQXejj1eIsvZWVBKVrNmw3gqqfihOJ6R5lRg819WilF24?=
 =?us-ascii?Q?QXZd1RyoATRuCSz4TKQ01TkHheMSCWDLcHKnxZG+HhSFyvJEnj/UVJuW7fwM?=
 =?us-ascii?Q?pjfgRSzhmFmDKQMap9i+LspfRM4ao1ZQ19WeM0k6igbZ8WuCskZsMK338PfZ?=
 =?us-ascii?Q?4V/1330QyHCMxodr/HHA1f2h7ufi4ktKV1FhxH/LuApS504kPhIWwIpMtfdr?=
 =?us-ascii?Q?anTecd3MWaWkHIQ4c2oRkrxWHRr/Dq+UrddLWS3Owz72x4hF10yhDkYn/izm?=
 =?us-ascii?Q?3WPhB4GwTgQiEU7hAYgMAY9AQPNaufVDoQf5kWoXk8+oWST5hI8tsZk4JfSa?=
 =?us-ascii?Q?Jbagj9BuKslxVBLt4X0BYCxUEhlsdOkH7PjtqQoB12ekLWsRg9yuswP7Lndy?=
 =?us-ascii?Q?P9K+S0AC7sgGspzL6IsoAQb18q3ckjWN6UnMpaJ2wJ8GVabhSI+r51PNUevd?=
 =?us-ascii?Q?kVlYEq2AF13eXt3TeQgD2LTx4cm5ANs0nxc+O/kC1Z2ru8jnNam4XR3tl5hW?=
 =?us-ascii?Q?CW+UkyRemio67gi0YmVyI/qlBFSNCPpn5pquPCVNfp6kM1rbB3g7f11Q464D?=
 =?us-ascii?Q?bBX8BQhOc98now5O4t+eXWJJQFCN8NJSOxhvD8B37tOQpTUd5m7mDUFqfd6h?=
 =?us-ascii?Q?WDOfgdOV1qVXhwmV6dqUaQOP73gZJtrdkVA8PzxBmwuuFeBgQvE9IZBDYk1t?=
 =?us-ascii?Q?mrDhK9TwqlihKpqHJss/fv62kviza6V5cq1DGt7eORCdj14GIgv7snZwxz6a?=
 =?us-ascii?Q?0wFcLEbpxw7lXrjPvdECbA4z+s6DcniNXoncFZwEM9kiT2m3fS3l/gh09YyR?=
 =?us-ascii?Q?8Eb2lKrKz7IN20i/XKZgftstKbt8EalbaOq9Ktfom0zTqJvwNABbfWxLDH0s?=
 =?us-ascii?Q?K4APtn8piXCDmdY5mOrT3+7ViDc=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 6lPfjGvtw6jUU04TrX2EfForsQVUHY8fh8p2yEKdcBELZUWYl1ZkRytw8NQgJFa7/gKwNg+eTi71Jfh9aM09egVM6R6gPKBYrzmgXA4pqGLRtwuvnpZ3AwMH/hFVNbMKNaYotJegR3jWtj+MSR8AoYwRxlebnTwK5KBgOyIdKbtwytQVtKw8YJctq4s/62LodDjOnDUAFk9Mhdro1HVBq+qlGOmkC8DoJIEvwTKXhsz6z6QgSRt0mg/WYfz5jzY9/GucB4QQwrRf4ZHTLYxUfAS4UtMN2X/Li7PLX+P/1xPgeUevWtszVcClrikjK8zZ9pNg3ai6NWZ4q3f45PqWkj7g+KBVWDPDnghgxfHiwZsxEbicWPqQY5we1Go4OWQlVvHyLLxRQLT0CXjJo/nVD9yq1yvLTHfHmKA/U/2bD2/7OL2iiFIPf/9dJpZQzmM6
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:34:56.7706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af2335e8-3986-4d25-83dc-08de5e7a68b4
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM2PEPF0001C70F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7670
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254294-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 95CCDA2F70
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

For Accurate ECN, the first SYN/ACK sent by the TCP server shall set
the ACE flag (Table 1 of RFC9768) and the AccECN option to complete the
capability negotiation. However, if the TCP server needs to retransmit
such a SYN/ACK (for example, because it did not receive an ACK
acknowledging its SYN/ACK, or received a second SYN requesting AccECN
support), the TCP server retransmits the SYN/ACK without the AccECN
option. This is because the SYN/ACK may be lost due to congestion, or a
middlebox may block the AccECN option. Furthermore, if this retransmission
also times out, to expedite connection establishment, the TCP server
should retransmit the SYN/ACK with (AE,CWR,ECE) = (0,0,0) and without the
AccECN option, while maintaining AccECN feedback mode.

This complies with Section 3.2.3.2.2 of the AccECN spec RFC9768.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v7:
- Update comments and use synack_type TCP_SYNACK_RETRANS and num_timeout.

v6:
- Use new synack_type TCP_SYNACK_RETRANS and num_retrans.
---
 include/net/tcp_ecn.h | 20 +++++++++++++++-----
 net/ipv4/tcp_output.c |  4 ++--
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index a709fb1756eb..796c613b5ef3 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -649,12 +649,22 @@ static inline void tcp_ecn_clear_syn(struct sock *sk, struct sk_buff *skb)
 }
 
 static inline void
-tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
+tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th,
+		    enum tcp_synack_type synack_type)
 {
-	if (tcp_rsk(req)->accecn_ok)
-		tcp_accecn_echo_syn_ect(th, tcp_rsk(req)->syn_ect_rcv);
-	else if (inet_rsk(req)->ecn_ok)
-		th->ece = 1;
+	/* Accurate ECN shall retransmit SYN/ACK with ACE=0 if the
+	 * previously retransmitted SYN/ACK also times out.
+	 */
+	if (!req->num_timeout || synack_type != TCP_SYNACK_RETRANS) {
+		if (tcp_rsk(req)->accecn_ok)
+			tcp_accecn_echo_syn_ect(th, tcp_rsk(req)->syn_ect_rcv);
+		else if (inet_rsk(req)->ecn_ok)
+			th->ece = 1;
+	} else if (tcp_rsk(req)->accecn_ok) {
+		th->ae  = 0;
+		th->cwr = 0;
+		th->ece = 0;
+	}
 }
 
 static inline bool tcp_accecn_option_beacon_check(const struct sock *sk)
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index a1596fe8dd9f..22728daed436 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1106,7 +1106,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 
 	if (treq->accecn_ok &&
 	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) &&
-	    req->num_timeout < 1 && remaining >= TCPOLEN_ACCECN_BASE) {
+	    synack_type != TCP_SYNACK_RETRANS && remaining >= TCPOLEN_ACCECN_BASE) {
 		opts->use_synack_ecn_bytes = 1;
 		remaining -= tcp_options_fit_accecn(opts, 0, remaining);
 	}
@@ -4012,7 +4012,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	memset(th, 0, sizeof(struct tcphdr));
 	th->syn = 1;
 	th->ack = 1;
-	tcp_ecn_make_synack(req, th);
+	tcp_ecn_make_synack(req, th, synack_type);
 	th->source = htons(ireq->ir_num);
 	th->dest = ireq->ir_rmt_port;
 	skb->mark = ireq->ir_mark;
-- 
2.34.1


