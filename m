Return-Path: <netdev+bounces-254298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJzFFEQgemmv2wEAu9opvQ
	(envelope-from <netdev+bounces-254298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:42:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E81FEA2FE2
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28898303CD2A
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDF3363C45;
	Wed, 28 Jan 2026 14:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="LvFiIx6S"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013011.outbound.protection.outlook.com [40.107.159.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0257F286416;
	Wed, 28 Jan 2026 14:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769610912; cv=fail; b=CJIXwZSgoyJWDbxj3tQ6OznfRqnddn1FYQGh0eBBXoW92vAuQXy1l1gdDBefggv7ueQI0y9mPlsu1B70/Wpg2NZb2/jbrKODwE1xOQlUE0eWIDMd77AF2+nxDPi1TnJE17cwbU6fOrW5Gwhg/bT7Tffb37C722M2GNWcjaUNPKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769610912; c=relaxed/simple;
	bh=eujKce/sLO8vEScxSqiTbpDPb7VTheAN0hGsEibcrKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CDX4b4mbA92BRQ2SRAH12dE+ZgZhEKIoBWTy/fivEu4375spRVf+wX01wT2JjC2dyKhLHcB4m+yCdnfA+3RwOD9z8dYetYPpXbQBrLoSiIv497eAgwOxLByZSM+5vsnvEe6lmfWoGdBXVmN2wSZsDIuqrX1pNGadB/AT+CCz/xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=LvFiIx6S; arc=fail smtp.client-ip=40.107.159.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdVWDUx2BgOgZwrhE9Bp1kQ3m760WwSesCbHG1FCZYngdk6RwyhmmWi3Bj42oSA/Ox3QkfAgBpNvI3we/f3YvSCfa2uBXLPYilGs4LmuynL72CzjDwZLbpc6tIXdMk4DIvYzqx8E3SgIwrKND6WZbzI5EQqSERPLcOPj4ockPYdqYBf9brV1cEDQRfk/EWPK+5d5Q1HyXIOMPq+nrrtKN/Lu9YikFlxV81WzMr34J5BolA583rLSgAzrNjC4QFm1su3B5z/6nEM6sXFbamVsGl4ukJWziOPrbS8kbXBFUb1nCBJpkFs1KKEPJauISHNopWNE8Ddks0dLxZ+yKkntCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwuQpL810f4V2+YO0wvzXc1sBwIaQ+Ouqs2tZnqY/9k=;
 b=L0SgXaLBRMRIM4z5fLIphnFt/jdL7V0iiCPzmqIkckz3T9UXFr5U1VQvzLvAyOw4x0aKPUZetK8p5/E+NsQ6/m7Nm5fHFH9TilJhP/qdntome6QW2EeiDuME4EcRYGIZv/+sem7dyN6AhQ+8l0AbqndQLzuPRBqC4Q7VjJinOQqLS9r/kNPQkXU4qNoT5z9eeR+HSdu3aL5/ttLunSZmCKp5Sh+B+V62P64WyCXM9GfWdH32dCGP0y3mc+AsqXhKmN60gN9Am7dNLDINOh3yEi21mMnXyPMQ5Bmwv70pwBKHVB5KIA046NhhRq3ZNonOxelSQ7nr6VqJDpLhSJOaSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwuQpL810f4V2+YO0wvzXc1sBwIaQ+Ouqs2tZnqY/9k=;
 b=LvFiIx6Sn1/4HB6gEJjq9iU1BREugP2x4hmhN/A9IH3rsPpBz1rfg34GX29r6OJ42ilj0qpwIiUUPwt/STIcBrRQ0hvAn7w8Sn+fr4WLsiZbAOTdxxW1t8697uC5Gm64b3C0+Fc5SsWO7WH8AVQd9IgJiQagZnCYUDsHyA/adp8cotabv8tD5zmgcu2IWw9G4lHlPaMC25hLcZwomBKxE5Xqdnn124EjMDMdweyFk/yjYY5ljlIDOta1YE+SXkOhMLoGmYzCQmaSk2RUOMZylMsrp0SdxyUIJTH1/kEIi9/T92K8o/lAIW5dwJ6wfwZeIVllLGFkaUkj5xDxmI5p+w==
Received: from DUZPR01CA0250.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::6) by PAXPR07MB7742.eurprd07.prod.outlook.com
 (2603:10a6:102:15f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Wed, 28 Jan
 2026 14:35:04 +0000
Received: from DU6PEPF0000A7E3.eurprd02.prod.outlook.com
 (2603:10a6:10:4b5:cafe::e4) by DUZPR01CA0250.outlook.office365.com
 (2603:10a6:10:4b5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 14:35:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU6PEPF0000A7E3.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via
 Frontend Transport; Wed, 28 Jan 2026 14:35:04 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 71C8923708;
	Wed, 28 Jan 2026 16:35:02 +0200 (EET)
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
Subject: [PATCH v12 net-next 13/15] tcp: accecn: add tcpi_ecn_mode and tcpi_option2 in tcp_info
Date: Wed, 28 Jan 2026 15:34:33 +0100
Message-Id: <20260128143435.15708-14-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E3:EE_|PAXPR07MB7742:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a86b60e3-b77d-47e5-f401-08de5e7a6d01
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?aGrtZephS/R+eAU5tWjpYfkKuF/0pqFd28lKWC5S8pFpl14vzh1rlqIDO3Eg?=
 =?us-ascii?Q?FZNHIHRK7beV+dsRvjqxYFUJI6k0ohOMJ5xP9EbH0UObk7EaJvo9h7J5q8GO?=
 =?us-ascii?Q?tVIUwnuVQvM3EvvjDlguE6+iQ5wym7gcGHhZzp6qUEfxtdJZrcqKDWO4O+Cr?=
 =?us-ascii?Q?p1YxNlBdbfkk3fAObKDLickP08ClbouwMa1y29tAy1CQdwrSpi5KiX6m0Rqy?=
 =?us-ascii?Q?7flcQEodyEf6uRD825Vz9DCmk0yjE2t3MofAyHrCoNV74TQoAG0fwvekFvz1?=
 =?us-ascii?Q?yEKXSKybTBZPvKtREjHko4lohYeLiwlYmny592fJYcObjlfIQTxMSfIns3JP?=
 =?us-ascii?Q?oNlqWTB4iOOyEIFVeHnYc+WPIYKu/5WYMWSqrdj5w0Vskh5VcGk1/Vh41UxC?=
 =?us-ascii?Q?89MGRAJMbKM5mfamRtQctc7pdrgeViNl8bMUdLGLN8GWTyHf50mHRQvsLsIH?=
 =?us-ascii?Q?NzCxBWOPxj2pxrul5i4u+uscA+GRTEBMkYP5jY3oNK9LD4egPnL3XGjiVSh3?=
 =?us-ascii?Q?R32DjVujUjqsOXhj2zSJkrs3+7v1RURCk30YDvM7a3s5iSxTRdNaXEl+rx7R?=
 =?us-ascii?Q?dIM0yCXxqWDyPl23Q6lm3NYB5NUNK0N66y9azV6vk3xA9SXvxHdnCUE+UTL0?=
 =?us-ascii?Q?upRkUzAozDmR9vlEp48JUtINF3gON60VlpPNlotWdXA9xIWTo2gdnzwl9y1I?=
 =?us-ascii?Q?NOOzcQB4DX+DWcgwyhbfXkyoE3tgAvtZsWNgKTenhohqPqfykYDyREOYGOub?=
 =?us-ascii?Q?mA6oiXfmWoZdxFIKldkq9ODWicNLC6+P5zBtZ1bZdkqsQSxnypNQldrFNXS5?=
 =?us-ascii?Q?Bf7jauoS0lw/ZYFRyy+rCjme6yuf4oIAqyJHklmjNW1dcVXrRrc5pJOSII+u?=
 =?us-ascii?Q?xousmethQV3YIEG/VNFWtu20i7rx7ynJhnt5IcyXjP1/lq5RePzmdUK792AN?=
 =?us-ascii?Q?Zc7gRNEqCdEj6p/qk4zLUXSJ5AO+g97l8Bv25gv2Hcd0b30datm7/Dmp3sik?=
 =?us-ascii?Q?HX0AEdfs5hj2c203p12/W7qCVVGY6QWkyFkagyenVuYMH1dr9QUyrwXlh0Mi?=
 =?us-ascii?Q?7dx43vsSCqI3LZm2I+Xxq2VLKzFZ3++6YHeV0yTv+rIh6I2CwI27WCyC4XsI?=
 =?us-ascii?Q?i9zE9jM2fIXWncgzEOn6p8wgjevt2x4FyZg1yd04ekmhlkAD6GOJSuNiqLs/?=
 =?us-ascii?Q?iE0ODM2r0t9loDhRDo22WgVSs3X262vgGJ20bXpkACQ9aRBD074iji0Inxgq?=
 =?us-ascii?Q?rI6/y8mFKvmKx+Ia7bRTl9af5X7IdpGq0LzFdzlrD6TPhsiXr2TRFsbfTayp?=
 =?us-ascii?Q?a27QrSLaSDzrIQaJukM+ndO4jnOBhLvXIACzszsREc698Ing0PazaucMyxQs?=
 =?us-ascii?Q?K25Efrctnkbhnv1SaJobzRfnUzsy+2REU1Q2KiaGtQ9uTUn/e6/vIJhoTjip?=
 =?us-ascii?Q?O6JfNU5gIlCHOycfdZFNCPAIhVPgWP6HgwORn00v7O28X/+Mgw1qVXFfSQml?=
 =?us-ascii?Q?tuUjX8qse6KLOMdhUIoG0cq1XoRYrDxyXVCexLn2/J+8QGUxK7O7sry/cX0v?=
 =?us-ascii?Q?CUygLMSdnYbcMn6Bpkg23D3ftITkGHc5+GpjH+hNE7H+KbWSTiUhCPC4D5Sh?=
 =?us-ascii?Q?zGmrB7mvEo7GwLgkKYbK/7AvZfDImxx0w7tfwG7ox/4jkEj+vbwxXEWCt/33?=
 =?us-ascii?Q?tSAwirEFaQDSlFHgPtQVNEztii8=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 qF2U6s/C8ahlkHqKUHA2SY+yyzMUu3Mx/yCnIgQOktNeoW5ppPGrkf1qqYZZ+nxik5FUP/Ht5VbEbtGS2Oynl+jwny+axtFT1ONO7Ub/SF9g68M33fXc70Ga0wglpVAfhzCfTt+MMrzFtaPV9SDFpdg6cy/ZBKiqisjLBNZNf9pIhB+qSxMIjcrzr9N+h+W2Wis31D6Q1x4lh5K/WAAcArIRbeQ2PrEK2ZxI4L45N4i+L04xikUPe68vP+5NL6AtX6yr30V7gf80clePqAfaTckK6sEPh8NDOjzyOCfaoVc4HU2Li3HHVeo+M2mv39t96iHoT6A9p2sbiN091UcmyATmC+r/U8qNlyIR7N7tUkzB4VsHLhdPNnq+O5z5maF+O4h9/Jtqo0DFF6iqxi3i/8XX12Acyzfxn77MQmytn+/rbtXiUt8+Lpz1VxHu68T+
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:35:04.0178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a86b60e3-b77d-47e5-f401-08de5e7a6d01
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU6PEPF0000A7E3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB7742
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
	TAGGED_FROM(0.00)[bounces-254298-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: E81FEA2FE2
X-Rspamd-Action: no action

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Add 2-bit tcpi_ecn_mode feild within tcp_info to indicate which ECN
mode is negotiated: ECN_MODE_DISABLED, ECN_MODE_RFC3168, ECN_MODE_ACCECN,
or ECN_MODE_PENDING. This is done by utilizing available bits from
tcpi_accecn_opt_seen (reduced from 16 bits to 2 bits) and
tcpi_accecn_fail_mode (reduced from 16 bits to 4 bits).

Also, an extra 24-bit tcpi_options2 field is identified to represent
newer options and connection features, as all 8 bits of tcpi_options
field have been used.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Co-developed-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp_ecn.h    | 11 -----------
 include/uapi/linux/tcp.h | 26 +++++++++++++++++++++++---
 net/ipv4/tcp.c           |  8 ++++++++
 3 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index e01653bbf181..e9a933641636 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -67,12 +67,6 @@ static inline void tcp_ecn_withdraw_cwr(struct tcp_sock *tp)
 	tp->ecn_flags &= ~TCP_ECN_QUEUE_CWR;
 }
 
-/* tp->accecn_fail_mode */
-#define TCP_ACCECN_ACE_FAIL_SEND	BIT(0)
-#define TCP_ACCECN_ACE_FAIL_RECV	BIT(1)
-#define TCP_ACCECN_OPT_FAIL_SEND	BIT(2)
-#define TCP_ACCECN_OPT_FAIL_RECV	BIT(3)
-
 static inline bool tcp_accecn_ace_fail_send(const struct tcp_sock *tp)
 {
 	return tp->accecn_fail_mode & TCP_ACCECN_ACE_FAIL_SEND;
@@ -98,11 +92,6 @@ static inline void tcp_accecn_fail_mode_set(struct tcp_sock *tp, u8 mode)
 	tp->accecn_fail_mode |= mode;
 }
 
-#define TCP_ACCECN_OPT_NOT_SEEN		0x0
-#define TCP_ACCECN_OPT_EMPTY_SEEN	0x1
-#define TCP_ACCECN_OPT_COUNTER_SEEN	0x2
-#define TCP_ACCECN_OPT_FAIL_SEEN	0x3
-
 static inline u8 tcp_accecn_ace(const struct tcphdr *th)
 {
 	return (th->ae << 2) | (th->cwr << 1) | th->ece;
diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index dce3113787a7..03772dd4d399 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -226,6 +226,24 @@ enum tcp_ca_state {
 #define TCPF_CA_Loss	(1<<TCP_CA_Loss)
 };
 
+/* Values for tcpi_ecn_mode after negotiation */
+#define TCPI_ECN_MODE_DISABLED		0x0
+#define TCPI_ECN_MODE_RFC3168		0x1
+#define TCPI_ECN_MODE_ACCECN		0x2
+#define TCPI_ECN_MODE_PENDING		0x3
+
+/* Values for accecn_opt_seen */
+#define TCP_ACCECN_OPT_NOT_SEEN		0x0
+#define TCP_ACCECN_OPT_EMPTY_SEEN	0x1
+#define TCP_ACCECN_OPT_COUNTER_SEEN	0x2
+#define TCP_ACCECN_OPT_FAIL_SEEN	0x3
+
+/* Values for accecn_fail_mode */
+#define TCP_ACCECN_ACE_FAIL_SEND	BIT(0)
+#define TCP_ACCECN_ACE_FAIL_RECV	BIT(1)
+#define TCP_ACCECN_OPT_FAIL_SEND	BIT(2)
+#define TCP_ACCECN_OPT_FAIL_RECV	BIT(3)
+
 struct tcp_info {
 	__u8	tcpi_state;
 	__u8	tcpi_ca_state;
@@ -316,15 +334,17 @@ struct tcp_info {
 					 * in milliseconds, including any
 					 * unfinished recovery.
 					 */
-	__u32	tcpi_received_ce;    /* # of CE marks received */
+	__u32	tcpi_received_ce;    /* # of CE marked segments received */
 	__u32	tcpi_delivered_e1_bytes;  /* Accurate ECN byte counters */
 	__u32	tcpi_delivered_e0_bytes;
 	__u32	tcpi_delivered_ce_bytes;
 	__u32	tcpi_received_e1_bytes;
 	__u32	tcpi_received_e0_bytes;
 	__u32	tcpi_received_ce_bytes;
-	__u16	tcpi_accecn_fail_mode;
-	__u16	tcpi_accecn_opt_seen;
+	__u32	tcpi_ecn_mode:2,
+		tcpi_accecn_opt_seen:2,
+		tcpi_accecn_fail_mode:4,
+		tcpi_options2:24;
 };
 
 /* netlink attributes types for SCM_TIMESTAMPING_OPT_STATS */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a0569e89f580..d8405b419ce0 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4379,6 +4379,14 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
 	if (tp->rto_stamp)
 		info->tcpi_total_rto_time += tcp_clock_ms() - tp->rto_stamp;
 
+	if (tcp_ecn_disabled(tp))
+		info->tcpi_ecn_mode = TCPI_ECN_MODE_DISABLED;
+	else if (tcp_ecn_mode_rfc3168(tp))
+		info->tcpi_ecn_mode = TCPI_ECN_MODE_RFC3168;
+	else if (tcp_ecn_mode_accecn(tp))
+		info->tcpi_ecn_mode = TCPI_ECN_MODE_ACCECN;
+	else if (tcp_ecn_mode_pending(tp))
+		info->tcpi_ecn_mode = TCPI_ECN_MODE_PENDING;
 	info->tcpi_accecn_fail_mode = tp->accecn_fail_mode;
 	info->tcpi_accecn_opt_seen = tp->saw_accecn_opt;
 	info->tcpi_received_ce = tp->received_ce;
-- 
2.34.1


