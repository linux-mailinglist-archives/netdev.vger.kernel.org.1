Return-Path: <netdev+bounces-288862-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNDQKsWyCmpx5wQAu9opvQ
	(envelope-from <netdev+bounces-288862-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 08:33:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27174566B9B
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 08:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1630302C37F
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 06:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6C83DB63C;
	Mon, 18 May 2026 06:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jGBKBJfg"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010001.outbound.protection.outlook.com [52.101.193.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E103E2779
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 06:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779085399; cv=fail; b=A0l3NRq9ozvUyfsOlPYku16UCXQStUGbYGImpLbVh2BSUW1oUoRQI5KiM9j1XDO9nU0a3BIu8FeqiK+rCpgZxl9LhSdFsu1NeZLtuEeHXXY1LxjCvVuy7ELOFutv6OyQ8VHKBIggv+4G9HF0XcZId65cxxTdiTF76LmOu+gkJeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779085399; c=relaxed/simple;
	bh=LexrSsNeSjMx09JjageeZrNfIRXvuwCdeQLxRGWfAXo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ecRkxK1sKeJlrpkmz6vS9DAs9OTZc84+H8b3DbwBw6o5huFObp8Erg1F5KtoZS5d12jfRovIpzpUfdlyfJJoWHDnus45O88Z+TuB4hFtBCIlyhi6X2hnqM4byPk2r7EhPZyIon5K50S/ie1dJypfYrR6HC+2HxP0dN3CPAcSBTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jGBKBJfg; arc=fail smtp.client-ip=52.101.193.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAExBM14LzoxW0hV9b39PdFdLgL9I5cLGF4OUEKrs2luTyFCYdxqvhgPIAI5Cl1LYcrTulhBnNpzWMvy9x6lv5UkBHJzFoGjG52zzSc7bMeLmanl7wAUwWiFf8IvfeUczX9MBROssPaFJrfCgcHLUPaFv5qDeKfni2wsjatL/wfkc3mtY1Ng0tmfwS9YZTugJ8j5oqxQaAfO+Tceiw3uoESv9+ZLt6mc7zM80bWieGfpkPofi0OVL9fXsMSIPMoSjsxDB2NyHdExI6S2qfr6p0apws61KZitituRk4Jr7XDWRZhJZU7yMPnbSCzuK0vyYGu/5/34pPGa21RQKCHYGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29yKFUxgMIxkcqS44sFpnxH/O5pJxcXPqneBXQkoX1s=;
 b=V2rWbUSC2q1+84Y4Q40qT13t2Shx+2CP4BbKraA6X6Fn93PW1whyknkntdn9WK/qKy230tmwnQDLs/zk8oCTFrm8uVyB3UDFlnPgfoG7qRFQ7K8mbmtRoP0A0yZA3r5TWHBxcK8YhuUpUh1qu5sCVX81tqXpibVAHDzImQ/mQ9vxTIPXgO5XAaK7ATgGLuG4EDCxX6zZnWU1tEWv7wi/IPnaO4KubsJJHqKD4uG3EdnaAxKql404pm/h4yw8ioET3v/CpNT3PGupImSM2i7JYiJb2imxFlk8eMf9XVgGpyRqlBNp+FG4tN7bZG5W2CVSrGEVBxxu9uYW1/U5kP9+Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29yKFUxgMIxkcqS44sFpnxH/O5pJxcXPqneBXQkoX1s=;
 b=jGBKBJfgKvjCL8hG5MtCOIRInRlK9oIjDCFQ3GN+GhzMRYH+KM3MBluBzNvi2tr5aBiHWs4oD+OYdjoURgTrpBF2R9/5fYcFGCCz4alp+ar3qsf7pQDlyREyTN1u+bPzmWmJeKZbY+OqlxeDYi4QncNtexEAPnQKUrTb+wzTx/ogNi5Uzo2ve9uCU528V/40TTwYsGT3onCJgwE2is94iCvJiBxH1sFSgmAHZD11tkgg8CiQYEhE3rdKu7oQjG4HUgTaCwRZf1a73tPvfhLtJ4VZgtVaj0fO0MveG38IZAxe1HOZEgVW+++QMqE+s9cPD/knLVAnWD/7phm4NxllOQ==
Received: from PH8PR05CA0007.namprd05.prod.outlook.com (2603:10b6:510:2cc::18)
 by CYXPR12MB9441.namprd12.prod.outlook.com (2603:10b6:930:dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 06:23:11 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::3e) by PH8PR05CA0007.outlook.office365.com
 (2603:10b6:510:2cc::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.13 via Frontend Transport; Mon, 18
 May 2026 06:23:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 06:23:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 17 May
 2026 23:22:55 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 17 May
 2026 23:22:54 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 17
 May 2026 23:22:52 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Gal Pressman <gal@nvidia.com>, "Willem de
 Bruijn" <willemb@google.com>, Dragos Tatulea <dtatulea@nvidia.com>, "Alice
 Mikityanska" <alice@isovalent.com>
Subject: [PATCH net v2 0/2] udp: gso: Fix __udp_gso_segment() after GSO_PARTIAL UDP length change
Date: Mon, 18 May 2026 09:22:48 +0300
Message-ID: <20260518062250.3019914-1-gal@nvidia.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|CYXPR12MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f1eee71-b495-4ae5-f180-08deb4a5ee6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|18002099003|13003099007|11063799003;
X-Microsoft-Antispam-Message-Info:
	zb9cR8wKfdeirM4EsFZeEMKslwdQzXPemQHgTirLiHWbrF2tGhQzlFTosv/Jy82WZaffYBMVumg/FYp3tOmWqhifHxqubil0S0CF92SiWKMvvsq9N7gONaegOpi8vWx0+HmjeJw6V4cuf4/H80Ix2Z5y82tc/SsQFfHGoaStihG0zWX/vhE58VGoblpTJoZMnm8y1ooHAEkwQzDgWyJMi2ociRG9GCLCLg9PfiHm5EmjNNbKqVW4/I/BrEKKWk0guxB/alSlitxPvVgty7tpz/BMa23JDtgGhqCSY25D2ZUG8uh0juZC4cf2hULvax74FMXzKB4Nx9rqvgMLHckw4aeXgR7+mcD20NBOrWOtg5Z9l2Pf2eO+jFPD2MfUCvWBloEy7qmTS8Ch6SfHLdPdfc2jPPvmGl320H3zUwPRhlFeJQGACd31daed6BXILckIZu/SUf554dO3Ha9lwYzY4ORHgSXr+G52pR96fHQ0l2RcJYOVhvfr6PmuxSBo/+HAF6VrezZ8ypV0d3tSNB+nq3Q9QM/BhA6TNWHsRKcQevg+WvDJpdhbWeP+O8yi4d786fH6hm0NQ9BBL4Rtl56REr6bCk81h+QglpjdGHFne8z/4DSTQN76eaaFQJDirfvg0oZTRc+dM0YP5NRafckm3SSQGLjOwKOpf5kMZdwr/hxTuTMhIanyeZcLKufGaCS5ozxDydWBDhnNjq4f4897Cfb2pxOnXt9YJpBViu9oEvE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(18002099003)(13003099007)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0w5A4tTu7wuaITSnVkenWdJGmbmECJDXjD6LZqHSalHpiQYJCdaLlD0ogHcN3RefCeAOMqFA8CbqqPNwCb8noLxkxHmr/jpcvfkF+z/Hq5xl2xneWMwLmTg538ZL0dcjdbDwyD211l63bp+0lr7Ugs0XPZvHdH6AMjl+CWE9OS4GHhvkEB6JcF7Or3tmihxFOwyiKFvXyswdlYVp9/uZT7C9VajkE3GgcjnpKVMHfrJg0TQ/Sm7fs79f9a4dY8z5dHqIfSsmZYkxwNc1HucV6ckqG6jr0jfa2r8Os3dJc0ZuomoabgY3ySCeF/dv0FzzV1VVMH+jnBtNphT3AqqVDch1uuuByh3Qgd96YiMxmqI4OGwDV1r7rx83Fc43O4ra9mvWYg5GYcMs+BHw6LRa1ZVryoPreTVFXlXrsl7wlzdPW6gi6xJu2BgDTIR3FZDM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 06:23:09.4844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1eee71-b495-4ae5-f180-08deb4a5ee6e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9441
X-Rspamd-Queue-Id: 27174566B9B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288862-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

This series fixes two issues introduced by commit b10b446ce7ad ("udp:
gso: Use single MSS length in UDP header for GSO_PARTIAL"), which
switched __udp_gso_segment() to write the single MSS length into the UDP
header for GSO_PARTIAL skbs.

Patch 1 (from Alice) fixes the UDP checksum adjustment in
__udp_gso_segment().
The patch adjusts the checksum by the correct delta, and since msslen
and newlen become equivalent before the loop, drops one of the two
variables to simplify the code.

Patch 2 handles the case where the last segment of a GSO_PARTIAL skb is
itself a GSO skb. This happens when the original packet size is an exact
multiple of MSS, so the post-loop segment is not a remainder skb but a
full GSO chunk and must also carry the single MSS length in its UDP
header.

Changelog -
v1->v2: Took patch #1 from Alice.
	https://lore.kernel.org/all/20260513074349.2152146-1-gal@nvidia.com/
	https://lore.kernel.org/all/20260512165648.386518-3-alice.kernel@fastmail.im/

Alice Mikityanska (1):
  udp: gso: Fix handling checksum in __udp_gso_segment

Gal Pressman (1):
  udp: Fix UDP length on last GSO_PARTIAL segment

 net/ipv4/udp_offload.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

-- 
2.52.0


