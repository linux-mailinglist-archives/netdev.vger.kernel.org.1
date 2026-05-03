Return-Path: <netdev+bounces-283557-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id z3x3Jvr69mmcawIAu9opvQ
	(envelope-from <netdev+bounces-283557-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 09:36:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBA34B4BAD
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 09:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCD153006F23
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 07:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225963806D7;
	Sun,  3 May 2026 07:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nvyolhVN"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010028.outbound.protection.outlook.com [40.93.198.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6912165EA;
	Sun,  3 May 2026 07:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777793784; cv=fail; b=hn7NTWVFkahELZOu/qda6ohlahrTX96aPdz/ErQaTiMJGx6D9mfUntqFGiihPgpNxqgw+tNMsBJiPe0XmrbLOAzELnJ3cxu65H3UpN9SsAghfsPZuTg/I06oTtpyEM0tnn6yfOjFwwIUJaff92PRVK+yXhIF2Yaya2P8ma0YxZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777793784; c=relaxed/simple;
	bh=9qJ/Au30IaAibAQUjTx6j3TPjB6z2NmSXjgXHEspn8g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OQcd/mO1pdlRydaR2uQUdiFmWtYhYy3aBXUbEqYQOrSFJZ6H+5jnApQZwD881FhRbkuMQYEaa4OTX8Yr6slpCai7jb/iX+qCQ+1DP4yRnvi7zETOUWTAie1DIl3eApJTZn1fTmZEMu8l3HqfDotdyKEoAXeK2m0ywudxGOllqOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nvyolhVN; arc=fail smtp.client-ip=40.93.198.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UQeWneDPjbL5nOQmZd55EnZzcJsArNJiOVeheC7btsqJS1tg5M/m38YM7JRQo7FsjX1koPwTGsQ68vH6ZNx5vXwvfowwUq9cxlKETdN9Ry6BkW/nAsgXCa1yojsGQptoV2anxWza1b02/nrYikPuS1dp2vlNKTwtvrer3kO6ZCGE6rS/OLL7YZzwyHmYlwjga9iNQSmcEg85ffu+9gRQ4l0zaJE3f+wx2ldte1Lkc+qHnY5uTolWIS4413+uJzeyVxdtZeSZJf3LCepGvt5dMiigArAJakf0Ce74lWuOKCrtPEl3NFWJTbP1WCvFmHbaEZFwEW2skj8t+UGVP6aPeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hy0LjOvbmD8MG/X88wL57pQTVebKl1DdoZP4B6WAWJU=;
 b=qw1LUbdxLIONoUyDbffaSrIXIKXGFsypgCRdFtsjMIhd7i+lNDaSPWGhDtmtQGO4Nl6HHzpbCve1o9mU+ZmfCUK6da+3GYo3cw0QY/l1kLCcqM1Vc07Z0mEXr1HAFxzbqizoffAElVpp7AfC3di1bL9aoVszId7fMNoAjiqgvz7sQY2w4cX8B2EPSNAEjp1IFP3YvPEbGSszgi5JyXrGVHKzukxtHOytvp8NUUTL9IG/rZIX70/wv8h/boK6vxR0NYl43IkKptzxTXqJgc3qpEe2uIu5Zd6yiVtK3Dds9x2lgSk8YJfCKwL94IZt3sEfeEO4A0LgKmrxQcsHbVRzxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hy0LjOvbmD8MG/X88wL57pQTVebKl1DdoZP4B6WAWJU=;
 b=nvyolhVNXlwNmc756Fc6wbxI0uwCYNVrNvvVD2gxFhXwjtfqQEyjcYeGTlKPwIj7kMlzFGJ+9isG7gVXohIGJ853RtoHXByWcORpNej0S3eLVjNLjn4of68w1Fta/8IW+EdnVbV/Bv7yFi3X+PDV6k6+6kdkyFMAKX86qpmLkRUxObfSD25vXq6Y5GS3myBPLOMpxQG17FX1KdLz8eZiM+bLYH3kU4QJ5mIFGFB+yrrUoglfoqnBgVUFH7JI0biPPc5sXiCiHeKS5vEN5USJ7l/RsuTJTFMyBn4314mGidckpyrH9A8W1A+uoddEb6s4UwBvVpVyNETOCHSqrfR8Nw==
Received: from SJ0PR13CA0177.namprd13.prod.outlook.com (2603:10b6:a03:2c7::32)
 by DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Sun, 3 May
 2026 07:36:14 +0000
Received: from CO1PEPF00012E7D.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::db) by SJ0PR13CA0177.outlook.office365.com
 (2603:10b6:a03:2c7::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.11 via Frontend Transport; Sun,
 3 May 2026 07:36:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E7D.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Sun, 3 May 2026 07:36:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 3 May
 2026 00:35:58 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 3 May 2026 00:35:51 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <donald.hunter@gmail.com>, <kuba@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<razor@blackwall.org>, <idosch@nvidia.com>, <andrew+netdev@lunn.ch>,
	<shuah@kernel.org>, <ast@fiberby.net>, <liuhangbin@gmail.com>,
	<daniel@iogearbox.net>, <aroulin@nvidia.com>, <fmaurer@redhat.com>,
	<sdf.kernel@gmail.com>, <sd@queasysnail.net>, <kees@kernel.org>,
	<nickgarlis@gmail.com>, <amorenoz@redhat.com>, <alasdair@mcwilliam.dev>,
	<johannes.wiesboeck@aisec.fraunhofer.de>, <petrm@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <bridge@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net-next 0/6] bridge: Add selective forwarding of gratuitous neighbor announcements
Date: Sun, 3 May 2026 10:35:26 +0300
Message-ID: <20260503073532.2138165-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7D:EE_|DM6PR12MB4465:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f3a7e9a-43c6-4b05-528c-08dea8e6a791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	qAvOQpS2HJNAtNS650qAg2+/wpyhf/FSGcTY3T9zQ7Bct8vGasFCSfs+b/5ZTTJjXLPemzvdVFFmBCMjLbS8AnLolPSRYcqqIODP4IjN34lWSXeknmC00b6g+eKXfNxVCyTQW9EpVdqwuDRvWepQZwq59LKG/EYSKxYvZAOUa+3/Tc7ata5x8SNWnu2mdkHRz5EgwRZYPkwVHAE6oCWZ5GjQtnB/utaPXZZ0BnxU/tVnDWmCLL0hMvW/PDRir7spHOSRwkVPdl+bp5M+AQMirOzCIutwuDxj0ybbTz2/b5G8QFgOVDmlXuUyrG6rJ6SCMGqqIbxrWvnARbwnuHjoQ3TE9RxmEKRObHWJ4Il/4nCtkXsaRbZdffQ9Yez3LXiiyGpwZzAKVzB4+igcoAZZ8Iw0fVHmUgbCTvjpO5Ie/DXa9zex+Kd1utR6eBxMSExU7VTCBJVKKCe1W9XJ09va+OB3ajRiWiJwGMK3TZ5QB5pyAtOPBP17TB3Pcwpt6jQCyIKBuTw+iChxeuVlu9e8eoKlDOagpl5pdJc7/GCMNJk79YdEwQGe264nDuWiTC153mTS5hSf6vPYCC4X09VfNUrTVlhEXvEw1L2N74kOmc01fkq6lOfxx8viDVR7S6DpGTVdWafrRcbAoZ/RrXHposUfgiulLtqK8Y+gBJjyOIoxeoxOxFSV3BySRrNmQ5FzClWlT1wF4Uzv0c1zlN0ijVqd+P34rPfERCIPMiv6wy8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	N6IFiloX5teDqGioHfx4tuykF21k3BE99/dR2DARgnKa2iSgdp9Mw08u2Ylwj2hhf8fzGuvPKRr8nQmWZAPKlicn2tWGXa7a32fk7mG6oYdFP+WR2R/znDgLe/kJFNEhKhyhvLN8XdeiE6s3072J+dtvv+3R8sMufYXWNZMn4Xb/wU4y7AIxmdK7mRIEhLXsDkkuhaXNlk32YFH0CZhwv/kU4g7VK8EjItOvQaobamfsmX1RAjCK2kkp6rRKKofZgEF8lOhPTEWvgWwMYTRRoGvCGSYYqj7Dr+tJY6JxDgLwHCoVekOvmd/iZJX/yWDdpaL4UOpLgSZ4r6kHg/VN9MyV88SiLjP4DNLFqJY4W77nVeOGvSGrxYb7SeEohUVZ5UzNA7huMoZ2dOzcFvr8pp40wLdc+I7alVQeiKJedX3DP7yS9GbLyVqXRfauy1Xk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 07:36:13.9500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3a7e9a-43c6-4b05-528c-08dea8e6a791
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E7D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4465
X-Rspamd-Queue-Id: EEBA34B4BAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,blackwall.org,nvidia.com,lunn.ch,fiberby.net,iogearbox.net,queasysnail.net,mcwilliam.dev,aisec.fraunhofer.de,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-283557-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]

The existing neighbor suppression unconditionally suppresses gratuitous
ARPs and unsolicited Neighbor Advertisements, which prevents fast
mobility of hosts between VTEPs.

This series adds a new neigh_forward_grat option that provides
independent control of gratuitous ARP and unsolicited NA forwarding.
When neigh_suppress is enabled but neigh_forward_grat is enabled,
regular neighbor discovery is suppressed while gratuitous announcements
are forwarded.

The implementation marks gratuitous ARPs and unsolicited NAs in
BR_INPUT_SKB_CB during input processing, then checks the per-output-port
neigh_forward_grat setting during flooding. This allows gratuitous
announcements from any input port to be selectively forwarded based on
each output port's individual configuration.

Both port-level control (via IFLA_BRPORT_NEIGH_FORWARD_GRAT) and
per-VLAN control (via BRIDGE_VLANDB_ENTRY_NEIGH_FORWARD_GRAT) are
provided. The default value of OFF preserves existing behavior.

This behavior is in accordance with RFC 9161 (Section 3.6), which
recommends that VTEPs forward gratuitous ARP and unsolicited NA messages
to avoid traffic disruption during host mobility events.

The new attributes use NLA_U8, although the kernel netlink guideline
recommends NLA_U32 as the minimum integer type on the grounds that
alignment makes smaller types equivalent on the wire. For a simple
on/off attribute there is no technical advantage to u32 over u8, and
keeping u8 preserves consistency with all surrounding bridge port
attributes and avoids introducing new helpers alongside the existing
infrastructure.

Patchset overview:
Patch #1: adds uapi headers.
Patches #2-#3: support selective forwarding of gratuitous ARP.
Patches #4-#5: add netlink handling.
Patch #6: adds tests.

Please see iproute related patches in the last 3 commits of:
https://github.com/daniellerts/iproute2

Danielle Ratson (6):
  bridge: uapi: Add neigh_forward_grat netlink attributes
  bridge: Add internal flags for neigh_forward_grat
  bridge: Add selective forwarding of gratuitous neighbor announcements
  bridge: Add port-level netlink handling for neigh_forward_grat
  bridge: Add per-VLAN netlink handling for neigh_forward_grat
  selftests: net: Add tests for neigh_forward_grat option

 Documentation/netlink/specs/rt-link.yaml      |   3 +
 include/linux/if_bridge.h                     |   1 +
 include/uapi/linux/if_bridge.h                |   1 +
 include/uapi/linux/if_link.h                  |  17 +
 net/bridge/br_arp_nd_proxy.c                  |  22 ++
 net/bridge/br_forward.c                       |  15 +-
 net/bridge/br_netlink.c                       |   8 +-
 net/bridge/br_private.h                       |   3 +
 net/bridge/br_vlan.c                          |   1 +
 net/bridge/br_vlan_options.c                  |  24 +-
 net/core/rtnetlink.c                          |   2 +-
 .../net/test_bridge_neigh_suppress.sh         | 298 +++++++++++++++++-
 12 files changed, 385 insertions(+), 10 deletions(-)

-- 
2.51.0


