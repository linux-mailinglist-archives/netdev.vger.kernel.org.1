Return-Path: <netdev+bounces-255529-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UODqL/iBfml7aAIAu9opvQ
	(envelope-from <netdev+bounces-255529-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:28:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E12EBC430E
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 490253018F81
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 22:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0921E38B99B;
	Sat, 31 Jan 2026 22:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ERtzTj/X"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013015.outbound.protection.outlook.com [40.107.159.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889C338B7CC;
	Sat, 31 Jan 2026 22:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769898368; cv=fail; b=ut4zFT8yjw/EV77i1RwG92tdkyMhMWBzve62rtjBYg3bCCskceDo2aigmmg0XmKF9XG6YkAMGlaFLTKiWgKSVMp+c7CMQgwjV2WQYLviZwLjooTw26tKfIYc+hLKm4nwV5fqdITSIFLaQf6KlisZoHY/+w/QdE9ZuqgjfAiEOjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769898368; c=relaxed/simple;
	bh=Asg5rC23oYI8fZ0ID/U4gZIpjK8owfYhDbHAKkxZluQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fQDDMvcmNvj2l7N494tVHSicd8/hMob52ObelKej/JFBgmGZ5PApgNq1Ylr9G7i23tHckpeq/gw0JQ4Zv9tAM4C+8uh2LDsb94opBNmSrMXv3wcSpkKptQt4PWKKu3+kfik5kvIkC/ljuzr8g6WoG18ymrem8oV0hUd/1kCnijY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ERtzTj/X; arc=fail smtp.client-ip=40.107.159.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5r6PSFiZZMuegyrvsPZ1yI8VsZ1ke+tFReyMcIk/uhIZzZWmHgp4wxO+R0qD1JtFon+oIAgHFMMSq25Xs8OEwuLnshCflC6oud30urFHgOVo6nZGe6z3JQdkcgbgSaO3R5L51S4jC4vfnML0oltqjQv0wTf2MY+d6eoKRWIvzYBwR2n4ousXbWzBHhmV5PI3AM6O0cSm68+8WQWGr+bdd5ixD8G4NcBhW67mGlLrbQICVe5peT0t8wePlw9fDKdUl4mc+1CLsVEio6An0a1yCYHky/976H19q6/XMGxHohhhSHaJSABc+YWzYufp4e9gpt729WLSC5Qh7OYE1YyeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6lCAkct3PKp/w+UY5D1UKhnw+4sxvJgWtoSoiJmW94=;
 b=eN9DFhRLSAzmlZFz7KaMRtpOxDHKIRUIXEDE/ZAmX6r9F0VSjXqm+7aOimyGAUt11MyG2DGFf762m3iekGWZInfsshEsqciGNONjwPanUrfURcqXNzmz1Jt2KtGgjzWsKIIjTj/ESaC0IdMgAIa/BmsxdF5xSdE7+/zmm6MBoOukIBMFR2Y7cZlhODyN/8rENw/hZ+cpq0VYCwKx0zPYKSX0Ln39B6kyjrMGuw9RcWTT1Mdv79WxLOG4ONrW/6DZ5Lq49y4DyK4VejWH3j3BSu4I7ivOLb7GduHsIsQL0HyBanqOfh7/B5oQocquKlA3mK1yfG8+3q2keI7+Mc/RSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6lCAkct3PKp/w+UY5D1UKhnw+4sxvJgWtoSoiJmW94=;
 b=ERtzTj/XgC2oFfTYHlh5g85TdynoxdeE07K2DI6RFy2bZ6GOtUiJs82UJuf8xENmCoeGRwHCyKWRGI01yv/9W4sWlzjNSb4HsOsHs7Jb3uh8NQ8j226Y3mc3aMa12egoZOksjxa721AXfCjzN0aqMuIpoA+Dee7YzKbyfNRleZSJaghx76iLbjtLiov5Y3ZETQifQBHYHANkhjKYuHJYR1yzhH4KNQ0TACWlFknVvhSaruyuMqwkUfTn9Hj2EoBruY3wzutWvnC66IlApoFQrZ3Agyq3XLaPyG8NEzEhWXesD30govoueFn3q96aOa7C16LP0HgMNVn3U+T4lpmXsw==
Received: from DUZPR01CA0267.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::10) by AM9PR07MB7684.eurprd07.prod.outlook.com
 (2603:10a6:20b:2c0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sat, 31 Jan
 2026 22:25:58 +0000
Received: from DB1PEPF0003922F.eurprd03.prod.outlook.com
 (2603:10a6:10:4b9:cafe::a7) by DUZPR01CA0267.outlook.office365.com
 (2603:10a6:10:4b9::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.15 via Frontend Transport; Sat,
 31 Jan 2026 22:25:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB1PEPF0003922F.mail.protection.outlook.com (10.167.8.102) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Sat, 31 Jan 2026 22:25:58 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id BFB2A2397E;
	Sun,  1 Feb 2026 00:25:56 +0200 (EET)
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
Subject: [PATCH v13 net-next 14/15] tcp: accecn: enable AccECN
Date: Sat, 31 Jan 2026 23:25:14 +0100
Message-Id: <20260131222515.8485-15-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF0003922F:EE_|AM9PR07MB7684:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2b519639-7b2c-4efc-931d-08de6117b52d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gj6LSaWgyza2iDkF1Uf052BEZJEZ1YDsB2MqHmvzIkiimUrv21IsGAnQwWaf?=
 =?us-ascii?Q?NO6iJ4e6iWSrL1BblKKEm3mWSBT+MwlkH1Lqg7B02BaoUZef8KT0x4PPkLZV?=
 =?us-ascii?Q?e1nw0k7lu7fpZMu3A4jyHh6XuUXiEaxDVMDRftPMelgspBSYSF1QdD/4XoPG?=
 =?us-ascii?Q?gMQizxCfBs7l5TA2SNZx/DjTBVtlcyB2sbJqpetlyvlilezOhDwHahvRs7cX?=
 =?us-ascii?Q?h4PkGQvzUzTMPP77gBUBa0Qqahnh4LvhHfLkFn3xPIdtAIm9+n2HMVGZAZCR?=
 =?us-ascii?Q?8BawpRXJf71PniqYOwlb5Zx9nCopsBvh29gIhdiQJChlBCYQBKAeuQjAqjo5?=
 =?us-ascii?Q?nE+w6q9VPKmN3MLVhiWGRqkjHQSbV6zFx8Km9uikA2AEzNtG4Ld2EAIpJluG?=
 =?us-ascii?Q?oQaUwdtyt80s+yb964ol3f3Fe/DeGkFPpybJxApJn8EB99MwN/itxqmYVnVP?=
 =?us-ascii?Q?I4WMs7uad11VZdrR6AZusURFsudUkhcT7XGPybn/mmuIHlvDGg1bM3pmGc0P?=
 =?us-ascii?Q?6MV14az8x/7kff/WN2jwmI92P/k39yFVmXDfPAH0Sb+RDJhc7RerXoybJbCu?=
 =?us-ascii?Q?jhX7tVCUbTLLsjTSjpQ5q+NbmN5Jf9jge7ffBwYG8VHQoZD6xmYpTw8Giisq?=
 =?us-ascii?Q?pFRBy6h1RgEQ36F7/3XKAdupdV0+8/1pyVZZTTcc2r+xtnhKQNWN7DsCmZWd?=
 =?us-ascii?Q?DJBkpG8fPwmJkVZhRspbpTsuMyQsYwe6UEcm5sSspjyLFgYda6eUCjg+DUi2?=
 =?us-ascii?Q?onC5htZ58jj619zX9pStqM/z7YqzMSIMU/eAAszggnhPkwuFtzeZWB4Ti53E?=
 =?us-ascii?Q?9nk0aYCFswqH1UKPrOzlicZW6U/4qYPwg6pyFL0NybG6wdJYgkYqkPu52hLe?=
 =?us-ascii?Q?Gqr16YFHjswV5hHxKuEzyR4fPmb+9s5iPSCAAoA1jRfTVeTU3jxgRhX1lpBo?=
 =?us-ascii?Q?U5Kg0ghb7CfKUt541eoRG4Phw1sobVfvVE4LqmQAytLHnj1AqewqtHgOrqu6?=
 =?us-ascii?Q?PfogjTABxjCb7wL490IUzoWjuOTqZzXDnkSsmkm9PILUElkVyiMBGKz/GsKp?=
 =?us-ascii?Q?9TuXdK65cUgilfVN0k+Z1iyTODHDnyxlCJoaBXHY5viaq4rPz/XUammf+MYW?=
 =?us-ascii?Q?/mSBJvCHfCTKHpoPodvfo126JE1R8YHTi/Ez9QfL+zOrtnwbTgg46Lh+QyOI?=
 =?us-ascii?Q?amn527p8DvrG2Jq1wT63e/gbcnIuapWAfsd+l8I0gPhfHisfw9+gi8XBbZqo?=
 =?us-ascii?Q?R15wOFRfU8JrNnF5+FerL6O0gDqXbpAEtE/bgZ5rZG+3kcQgAvegXD9ZdnK3?=
 =?us-ascii?Q?9E7UCAIOiZNk4GPl7DQDoI68qrfzZocaCFcWD4kZPHSKfG+5EByjbzh03rzL?=
 =?us-ascii?Q?YrHpdfnI0uSKyt8bOCUaPfiPyIGwKqlu603jsAzMneGn+cHawKp4bGglODRs?=
 =?us-ascii?Q?gNhDb4BGTZptHgxJgZpGWJ3rd3z/9qfV5aqSUcDfNXwJWmc7hJsvg+UNBRmi?=
 =?us-ascii?Q?hyGXH5pqPeanX2re1z0qkBmbIw3pYrFEEMJ2LkFmSJzeI7tyVaptkUG309/j?=
 =?us-ascii?Q?sagmSuklyzup54iZftfqguMm94Qf7VCMMMLpa/cqqfCK+CGB8u60b0DEaB+3?=
 =?us-ascii?Q?nCd5ijdoQL2LUgj/4f6gywhpFAOMuTaDc42nT/KWOlUf+mNB9YVW3sjyoFxw?=
 =?us-ascii?Q?PHJx25/MtvpEDhJwuohQZzpWPzI=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ub1FsWBkISc3nFTm2MApXY6ybKJTT3doI75havbC2BfMKutGIWB4gOLt6Zo9JGUhT+YMU6EpEotuM0IF9hr1XjphYQHhbj+e//ht3VzHW5B74LQAoYGcrPHpCQIn0A8TeTsog3q8zG/RJw027KxxSJQebN+FQGX/VE9r0pdZ36qKGMuASoMCbI5PbTrLjK4xuTNtQMpF7+rtq343Du71LplpIuuqO1sFzul4wwN+b7oiEHVWjxeMJYP6PTboisQm+oKKYQ8pFRmwcHNTvO45paGbHy4yjenHFs1ulHrlFEiIhT03g+Ah3ZhvZoz8Kyi24j18EZfM7RlLtnDBn+1nKkS4g0Bnsgk/NUyaSqL28pbiw5ECiwcOeT/0LVeR5NrdTdrv7WQ+cH4lTQcnxbJhh+7Z6yFo0AUdMHVsHENlc+XfVFjUoZAmXhKjtIkTDVdi
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 22:25:58.4193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b519639-7b2c-4efc-931d-08de6117b52d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF0003922F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7684
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255529-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,google.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,nokia-bell-labs.com:dkim,nokia-bell-labs.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E12EBC430E
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


