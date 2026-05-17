Return-Path: <netdev+bounces-288700-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nEXyC417CWqFcAQAu9opvQ
	(envelope-from <netdev+bounces-288700-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 10:25:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1889155FF2B
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 10:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 18CEA30055D9
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 08:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2673368BF;
	Sun, 17 May 2026 08:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AagBaGxq"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011040.outbound.protection.outlook.com [52.101.62.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF2B3358BE
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 08:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779006342; cv=fail; b=Ko7URdC4mUJa/UoYNtC+3w4b3ybbdx8UQe8mGzqmBHjC07xcl3bHKm/0GjwtmFkz7INUjRrRdyQTWl//W+KwiehVgY4nh71vQDl8OyEhP1oYKqYLkMHhkADTNnxnFvaCzgRcJtdgE7FN/t68Q2+CUJcDlzbVis/wsKmVfUNv6FQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779006342; c=relaxed/simple;
	bh=tw8yrCpKybp/T8LhrpukqYvWav54o3BzEoqI+Ivkjf0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dsgkdzrAVmsDU28PEqkwylyCraBgW46BHmS6t6DMEnR+BREYGNzzd2rEAAc+fMuQ0JSYg/4n2fMEL2HiWvQemi7SxMmZ9L1R+D6TRKVGslh1lhL+0CY3qxKtWu6N2YgicX80eB2u35uDh8BNLViJC9WQE7K4pzrpeqVhMTP7u6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AagBaGxq; arc=fail smtp.client-ip=52.101.62.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dh7GycpN53GSQN6sYmKAyRqoJGTxGhJohsGBJH45k3rqyLmsRyZ3jVtBi4ykGYLxrRRWN0OOqaLTuduRCHYJwYqC8FcFvSM2g+wBpXM1iY4tQHVYtFnfdpsVu7FgYhohvh//LVs4VPXo2uAki7l+D/rG0EM3eF1ztRWAko/F/Y9a4/ihYnYJoy3nrW3vbysawWxEV6VF3avUAAxRc+KUjLI62+AJ8AEhLeA/crh4OqIlyohTUJOqS95d1mJj/qC1cyMRre40xUaVe2eMp2swiTtlW0pTPIWv2T9YCUTAOcJuCPcxDdPSqsaChU40p1hqgic3AUPG+A/AMm+SxNNw4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFR1zSq4fcc+rOVCDn5FVuSDBlKBAFySy2TI364bmno=;
 b=egnKtdYCccX0N+BoyIgq6hVXadYO5dmeGwU3eNuYLzjHFt3XJK4pOqIBsv47I299JQbemrsw/lBO1e0tTFnCuQSpyVy6kcx2+z6hKxzwPsVH0Xw54GMCIhWuCKpemNRl2WTq4YK5HeEDZckXxDuZQtj6dfGD/XFBruTQ2oxgJFFdDhRe+XK7EYyblKqU68IhsjYEZjWWiQswIcAF7eAvwDk8patSJL9Or8Wi4gXlUGK5UHpDxmhmH5jFPX27geRg0GT0TiB75w7/+gVFd42szYV49PCNdS2AiC5yUo3mXLq3yD5D+ozDQBTFc0M21Ro1F9EWz/75j/lpX01DCC9FdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFR1zSq4fcc+rOVCDn5FVuSDBlKBAFySy2TI364bmno=;
 b=AagBaGxq4ZdWiCzQi/PauLFRmuXI5DFjFlJuPtJn6tfOn4meSRO16LMeqLlBv8oWCnYdBunqqknoZ4u7Scl/VNURIFJw1RuVNjrRhui5EqkcmDu+8TlTi5RB0gK4jhqbEKwe/sBmm2OHqwHr0/jFesg1e1MK9QCODc7a25BMT7zEq4Is8pCBzlEuAmbvcgmqlBcGu6GMKj0innG82/s0/XJb6BrTSoD7VnL3zFFXupSo+5dJzooPxmAGT0By9aR7Uoy+OkukVgpHi7+o3VWCXeI7S1xTkbkHNLN9PVcH8VMAcbg3HIkdulBphxxtlHkciQs3eDtAVp5i4VUXeVKQyg==
Received: from BLAPR03CA0099.namprd03.prod.outlook.com (2603:10b6:208:32a::14)
 by BY5PR12MB4129.namprd12.prod.outlook.com (2603:10b6:a03:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Sun, 17 May
 2026 08:25:35 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:32a::4) by BLAPR03CA0099.outlook.office365.com
 (2603:10b6:208:32a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Sun,
 17 May 2026 08:25:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Sun, 17 May 2026 08:25:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 17 May
 2026 01:25:17 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 17 May 2026 01:25:14 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@kernel.org>, <stephen@networkplumber.org>, <razor@blackwall.org>,
	<petrm@nvidia.com>, <idosch@nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH iproute2-next 0/2] Add support for neigh_forward_grat
Date: Sun, 17 May 2026 11:24:59 +0300
Message-ID: <20260517082501.899009-1-danieller@nvidia.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|BY5PR12MB4129:EE_
X-MS-Office365-Filtering-Correlation-Id: a08573f6-6d03-4060-a028-08deb3edde42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|3023799003|11063799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tby9MgffhJKr9OH+cNPmG/o7wa7rowdCho6g/eyhpDU4/krHSjrUNA1EcaV8oV9bE+FRcVETq6gN+jBnQh+Pbl7puaKo2bflJI6T6sDvgjdOyS8R/3QFYTIyYfwCVxug8AkWIHZgWTWf2R2U20ABcu0Jabko8vnt1fEiUXDXHCsRaxPBaxuhfG49OobEUG+sZcZjEfYQFq7vKz49kBracUo85w8ZR56THNCYXgv99Cq8dYrnrjSvl2OVbBrNpmm3UM49jXcPmRH0B+j5EbgL7H8PMGsZc54ZH2uuejsCwRJFe4/W6x3qvt4eekYvlx9tofgahOiBSY6lwrvtGspMnc/YnFCUeY80+eQn10o/YrTt6os1feZegmOCBPXDiQKD34vrTd8EmhU1k97Es49Cb9+Sm1l39ru1K7Wj+3sQ/az9XXJqlqlAWyMI/EcvxgbXkCuQj18ScN6IPQM0kV3/li0ww9gV5fP7+R/dNs86iGdwbP93Jle6HDuVlrrshJBPI+ZtVLcpZvWLZnYodoNx3greMJmqtFLIXPr8Ai6PZGnQwgXReZQhNPUgqWPH1yyc+YWU6QTFpOhKVnaxghWRgq8Po2WdOIp4iUvTDOudDo8GokrmEu8XUZEhECenG9cEbeFxpjMRJGHrKVmUCAlTrfEEnRkLTO7UFleoQOymQEVHUh7njFUJOFkMnAGpulQFkpIxrQaU+2el5Pxce+ss7o5FnyGYhNQ2nbU7FydrmNA=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(3023799003)(11063799003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/4v3pAFFQGPpo8A7ItPXXeKouDCczlLEh88gMnu+C6IMagswEqPA4f87vh394ER6znins50vDjk5TKe5aJxvPbT1KvuEmnjb0ozdsF0auERo5WXr5ifBQp6ZxWIfNGbjp9mkuOpadwNerEdfll7GVLFR98w3kEx1dJLWTlK5SC9U+YImEl2IZntFRpH6adtYXEtWpBL3MGhhn7WQkZUooYGRewUm8jC73oUAjHcl62TaeabphtIQFPeGPuZRd73Nd+Hph97xAJIsasZPQpMt14aAvA9vUL2PGE/jpzhw4zdXDPr+uybEj5FtBmEb3Job1YXe/eybzOUV1rPaFmrqnXnLWANeEXJUyonISyqzHvGttAvc8tGYPCzcCZMD6hMQp/QLS3weIttvr60i7PZafqwhdsho7WZEwJn6TRJMnMS+bAOUb4q1T1XDfZHyEAXG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 08:25:34.8850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a08573f6-6d03-4060-a028-08deb3edde42
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4129
X-Rspamd-Queue-Id: 1889155FF2B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288700-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:mid];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

The existing neighbor suppression unconditionally suppresses gratuitous
ARP and unsolicited Neighbor Advertisements, which breaks legitimate use
cases like Multi-Homing and EVPN where these announcements need to
propagate across the VXLAN fabric.

This series adds a new neigh_forward_grat option that provides
independent control of gratuitous ARP and unsolicited NA forwarding.
When neigh_suppress is enabled and neigh_forward_grat is also enabled,
regular neighbor discovery is suppressed while gratuitous announcements
are forwarded.

Both port-level control (via IFLA_BRPORT_NEIGH_FORWARD_GRAT) and
per-VLAN control (via BRIDGE_VLANDB_ENTRY_NEIGH_FORWARD_GRAT) are
provided. The default value of OFF preserves existing behavior.

The new attributes use NLA_U8, although the kernel netlink guideline
recommends NLA_U32 as the minimum integer type on the grounds that
alignment makes smaller types equivalent on the wire. For a simple
on/off attribute there is no technical advantage to u32 over u8, and
keeping u8 preserves consistency with all surrounding bridge port
attributes and avoids introducing new helpers alongside the existing
infrastructure.

Patch #1: adds port-level support via ip link and bridge link commands.
Patch #2: adds per-VLAN support via bridge vlan command.

Danielle Ratson (2):
  iplink: bridge_slave: Add support for neigh_forward_grat
  bridge: vlan: Add support for neigh_forward_grat

 bridge/link.c            | 14 ++++++++++++++
 bridge/vlan.c            | 18 ++++++++++++++++++
 ip/iplink_bridge_slave.c | 10 ++++++++++
 man/man8/bridge.8        | 25 ++++++++++++++++++++++++-
 man/man8/ip-link.8.in    | 10 ++++++++++
 5 files changed, 76 insertions(+), 1 deletion(-)

-- 
2.51.0


