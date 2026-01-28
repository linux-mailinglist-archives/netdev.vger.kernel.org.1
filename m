Return-Path: <netdev+bounces-254299-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGJUFokfemmv2wEAu9opvQ
	(envelope-from <netdev+bounces-254299-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:39:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC848A2EDD
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B27903073184
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD373361652;
	Wed, 28 Jan 2026 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="gf7n2H1U"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013001.outbound.protection.outlook.com [52.101.83.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B1935772A;
	Wed, 28 Jan 2026 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769610915; cv=fail; b=bQAxtdXXY0J06OrWjLVQ64DQdcvypk90Ryr24DtSocFfLaFdBQwy++zHEPd2U1B4sd4H1NkywOZ2YL7CtMyYfzUfF4MWm2WX7TWu/cBNTtLpkT5bJTnm5LT7aW5x2+Kuz2GCpXoFdiLvTEODvoBCtAzlxAzK/u5BADUBQMd9Nng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769610915; c=relaxed/simple;
	bh=Asg5rC23oYI8fZ0ID/U4gZIpjK8owfYhDbHAKkxZluQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tflJyQivvxIbLQcA6LrHtow7mjCy1PHafdz9Iy7tlJEY6rBn+zDFzRuhOnh1+aiGgX+a4Pfk91pmazdveEzf8GO4FZWTSQ8VDifM3+NqAHh/EWNf0b4sklx5D1xWSyiYpYfLYQjknTSKpC8n20EbkdBU+OmbO3DXS+udfT4bR7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=gf7n2H1U; arc=fail smtp.client-ip=52.101.83.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJqtzOyc5WsSDv7bnQxxHg3ATcW6tUTHkBpUoiPLTFalsToO8D2ta2wagRAVc94jZOGDbhuI1yTX3K6GdzbU9VHgJuDaks4EzsHm+BdMXXgjjvjs333mfo3uN5C+WzA1mXZVf8yx3Wj4T7PF5ThQT3bbmXSnR6rVM3zI+AM5rkUwS/Re+ohUJfnrNBEd3K1ry3rQwDVam8M5e6kCE8XM4eEIETL+2BJzTMpKK1R2dA6gezoVnXPS4vauWQewR4f3xNksyLyM+F3K8E3yZhu1ERPLNyyptTB8anmp2YUbtESqrh5SdHeO5HfkwHH+/lpRS4iiKHIKdri8XkcFrbnwnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6lCAkct3PKp/w+UY5D1UKhnw+4sxvJgWtoSoiJmW94=;
 b=OUpGvUQiqPOvaNkuqRFxJlOC9ZfNNXdbZBrff/Mearhj0D5Ly63Xzwsy4oDNsdt7PNpUst5PBgkF9bZH6r2NYG5hDci8Qz1Gc3nPAqB648hIZGoIJkM0k9TCFT3gr4lwD99HlPpKgwcf1uWHHCAJGW3NvLPTydF0RCXo5Bcd2H5XkK02APvsoP7wZViuHVpSX9sJHCcq/k8BtAAljSJD3L3qrOwO1HMus1ZkfBi5pXlv7CMXniccPFo548Wr58XugYKimz2hIqpGW0oKXCEQtUuYAJeFjAHAe5xLCCYDlHmQBS+gT+M65aSG16oXOEVOObO0pF8cqg/2lXx0lMZukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6lCAkct3PKp/w+UY5D1UKhnw+4sxvJgWtoSoiJmW94=;
 b=gf7n2H1UYCjTtwAQW8tFiGbgZbroS8FNzZK141e2xA6jbUC450VEZu+5EnRo7ExJu3M9m2TJ1Fbc5a1qaMkJhqrZm5yTCEim0fDFp2L+4gWiqK6P2i11T81c2gywJIPpVcvtyVOWoNtl09SDmv+lfXQ+pKWiwU3/vqjbP3bjfhCeiCq/mDxUtDGpR8/D2zmSBg0zxhrcI3Q2lkMLyYoK6NYQvK1pLcxOVczBo3QqnTRrv/tJdFPkzAy7v7UWGLE8h2wu1KpvBHFnzCO5uPrePIMCH0+xK7waC+rENZfYkyY8aKIx0Lb9nCf+0IQQ53yUiv7lWebOgYRpyUOT32ulkQ==
Received: from DU7P194CA0001.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::16)
 by GV1PR07MB9022.eurprd07.prod.outlook.com (2603:10a6:150:85::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 14:35:06 +0000
Received: from DU6PEPF0000B61B.eurprd02.prod.outlook.com
 (2603:10a6:10:553:cafe::c8) by DU7P194CA0001.outlook.office365.com
 (2603:10a6:10:553::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Wed,
 28 Jan 2026 14:35:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU6PEPF0000B61B.mail.protection.outlook.com (10.167.8.132) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Wed, 28 Jan 2026 14:35:05 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 3EDBD23688;
	Wed, 28 Jan 2026 16:35:04 +0200 (EET)
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
Subject: [PATCH v12 net-next 14/15] tcp: accecn: enable AccECN
Date: Wed, 28 Jan 2026 15:34:34 +0100
Message-Id: <20260128143435.15708-15-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61B:EE_|GV1PR07MB9022:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2399aed3-e0e8-4733-a6c8-08de5e7a6e2e
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?QT4daisBImtdwtJ7DOytYePmYP3b4uV3kUI/1KHiF09gb+Zo/XM8W+sxg+pV?=
 =?us-ascii?Q?b5yq1CTYq17hZKY4ciqAYerZPG60uROBVk9QhjN+2RpCjK6UCJ9kACUhXGKg?=
 =?us-ascii?Q?By901iNR01tAORqizTosVPHcNC0arOqNGQZYZwXGhvK6DbprV+6YT1IEs0IN?=
 =?us-ascii?Q?Y/OUzQeHGVMaBIFJGioLDVcY0OfaTHe/423e5DsD50i/Zn1V31lK8haWrNmj?=
 =?us-ascii?Q?aJbhYLRQ80eqUK6m0FCVI43vT2tEpPD6wwWnZc4bbg7IFbF3SnX9R+/CPCoe?=
 =?us-ascii?Q?0aXcUc4q1LNesbtZN0cUGJOOLt6JXVkFQTeovQdurqXV3YM04i4jD04U7YBA?=
 =?us-ascii?Q?wRH8P6A/OLYOI6T7QBntzgwTpSXuJCWCRptIjblIEExWtOhiJADQQ1wfJpfB?=
 =?us-ascii?Q?TlOB9oG5+Jb3ytHws3rIS3XIG+jitg1rX58FvvL/AuBEAxDZxGcRPu9cg86A?=
 =?us-ascii?Q?Y7OUHWDzdyCfCQwKwUmFV7ntrYnb9C3zyTim7cndU+MExRFXb2yz2bp8lQFZ?=
 =?us-ascii?Q?X8pITV/s29b1pqFKhAysMjbU+ExI/1tCV7IfjjmpJhXqOtYAPFACNY2M7z9i?=
 =?us-ascii?Q?ltJYo28Y5ee5yHp4jVjyaeWQAiHuO+wjf/7LbqVX3obLWwx8VG6XmB/fou6z?=
 =?us-ascii?Q?nCHIPp3OP2B/uwl/QAsOECuKcS+9crKCotRfcag+iNVAa8AFl+mly4kwgx2Z?=
 =?us-ascii?Q?rHCBCmGDNXpBoGNyw7ZK6oG+OE99fTqP8ianKe83COkMNi5wJFa5JYCh2fUu?=
 =?us-ascii?Q?tcdUV9A8DUg09ixnDaBFDgi8UxYJ+PBMfGgXT+4IU9soV+yffxH+i0eDGXSi?=
 =?us-ascii?Q?JAPoeYNrIkZv/x/ChEmSPbyDVO4SQSXoGr81J/yUbO6MvW6jjGRuSCQNwZO/?=
 =?us-ascii?Q?6xjFpdAcKS+vaKe2Mywj5KLqPUBaj0QES+rKNYkGYfBR8iX6RJy16uqmOIoS?=
 =?us-ascii?Q?UmC3YLD7GfalGNz+B1YLmErAHX2TnJv9IdGrGnxoTp9WdBOBsA9N2oF2VylW?=
 =?us-ascii?Q?/Q3viTZIlqPKU3iOPhbLz/5vkn15t7Y3HuofIdNaj6LXVK7qlVTB56F8wW2P?=
 =?us-ascii?Q?HZ5A+IZb7wIrX2Qo/bskJ4UGqTB3NamGsB5vXqjHQpeco0NUihZTSmy3WUOq?=
 =?us-ascii?Q?04pabXs0hGzZuVLkai69ttRCA81KzRtK+Sksmb/P0M0qsWNj5ee8Gnnxxu9J?=
 =?us-ascii?Q?kk09svyR4pos8Mw+RRlErR+u7bVoOCb5NFl0Ge7ezoFPK26oHKq4MlZKC505?=
 =?us-ascii?Q?0AF6UbJ+Mzh/75LtUVOkXJ1bEs8E1vfdAozFOEqF1t5GQYR04UCofcO6ebI9?=
 =?us-ascii?Q?APRaW3dtYG0R4rWuhGEA8dNURvsgh3afVHB1bOHlM+qar4cwfv7mBPDpvXt0?=
 =?us-ascii?Q?S9V0gZxpK54mqwWW0r6ZPPrDLfFbcgYXxe5aBKFIxdzHgAisbfxuYwbEUjgI?=
 =?us-ascii?Q?cBpgtzfWUvBa/IkTTH4gR7P++8i0SK54IsLoog7t9hXUdeRSEK2UoXd7/lYh?=
 =?us-ascii?Q?LLB723a635bVtsV9xSQlcH4dj7JCpVzGO5VzdZn/v8+GMYGHNYxWbtHH6043?=
 =?us-ascii?Q?EBy6yNKwzWEccZ4BGBH5bCFbeAsgqsM/7DdUrZtlEXKkcrwFiYMdGx+NVYTr?=
 =?us-ascii?Q?mjTFanTMOj5MZ44CloH5HE+klWRBp2dTrB3ZTITOMk0tkBRDg1o808QlfwlX?=
 =?us-ascii?Q?8rCxjYFZrpbI5Hpc5aPbk++QcdM=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 u9YKmU08nGNHzVeO6u7V4QA8QLpEkq3aBaTSKBJBM9umz/v5XJd3qBbtXi7f5ZZ+GbDP/DhRaR02f+J0EC0pC5Kg0nz2e6C+fS9xnQ6QTPGEoE+Sjub4f5ncGm1KJlvpK9iEjSgnwlV+mza0VQmx7me5sMzdxWiZULNNVOZUfKxBUj/rO3YBUu9kUiFF5fElrihRsGInwI6/2pFfczzfMREtHmVYTowvZLVeMiNTjbsoYCxdDtj2xEa9+NsLNqrKN6rbXUoq6l1zHeF2UbiOfUFt8JyFsydnh4zuAZcPeVCANJrS+ikAqy0NZwr2qgVj98jL35ClfB04IJUW/DpHTPbXLfYPwwQNI7ae+zGYjSamnMOh7Zv7JHqLjGHIbFxtIgkay0tAaf3FLyEpRP4N3GY7i3mVY3PE8W2BfTg4Hh1LVrgqQ5IczrnyRbx4Td6Y
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:35:05.9670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2399aed3-e0e8-4733-a6c8-08de5e7a6e2e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU6PEPF0000B61B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR07MB9022
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254299-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EC848A2EDD
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Enable Accurate ECN negotiation and request for incoming and
outgoing connection by setting sysctl_tcp_ecn:

+==============+===========================================+
|              |  Highest ECN variant (Accurate ECN, ECN,  |
|   tcp_ecn    |  or no ECN) to be negotiated & requested  |
|              +---------------------+---------------------+
|              | Incoming connection | Outgoing connection |
+==============+=====================+=====================+
|      0       |        No ECN       |        No ECN       |
|      1       |         ECN         |         ECN         |
|      2       |         ECN         |        No ECN       |
+--------------+---------------------+---------------------+
|      3       |     Accurate ECN    |     Accurate ECN    |
|      4       |     Accurate ECN    |         ECN         |
|      5       |     Accurate ECN    |        No ECN       |
+==============+=====================+=====================+

Refer Documentation/networking/ip-sysctl.rst for more details.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/sysctl_net_ipv4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 385b5b986d23..643763bc2142 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -47,7 +47,7 @@ static unsigned int udp_child_hash_entries_max = UDP_HTABLE_SIZE_MAX;
 static int tcp_plb_max_rounds = 31;
 static int tcp_plb_max_cong_thresh = 256;
 static unsigned int tcp_tw_reuse_delay_max = TCP_PAWS_MSL * MSEC_PER_SEC;
-static int tcp_ecn_mode_max = 2;
+static int tcp_ecn_mode_max = 5;
 static u32 icmp_errors_extension_mask_all =
 	GENMASK_U8(ICMP_ERR_EXT_COUNT - 1, 0);
 
-- 
2.34.1


