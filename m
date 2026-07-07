Return-Path: <netdev+bounces-305317-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qLLEMdOzTGquoQEAu9opvQ
	(envelope-from <netdev+bounces-305317-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:07:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A975718E73
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:07:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=iKxXnh7n;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305317-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305317-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87BC23018C24
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 08:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B54829E117;
	Tue,  7 Jul 2026 08:03:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012062.outbound.protection.outlook.com [52.101.48.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D2E279907;
	Tue,  7 Jul 2026 08:03:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783411433; cv=fail; b=o0iPjJg/8Jkr4qEzh5Ogd5i1wokmGPRXRc6tB16t+LeitpyhChy3nLAgrRXLBjT1Ol+t4wZas1ahrRSFDU2Sp7wf3AzLLIFFWBAuJ3p4CWwotVOx7/swzJL/lLw7V8zlgvvrgE/mwOLPTP7tB4Zfc9fGotJABeRcJUZQeNc4fs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783411433; c=relaxed/simple;
	bh=2ddChfKdSEwghfio/4sqgHyj/FZGz2LRYtLfb6/fqhw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s8ul/awIXoTg56XFpFzB7vJLmGfJ3ow6ZH3x9P3qBRXXt45V5qDgqF9a3woyH1t+3rsh1X+j73CjavSLm8P06VBirjYN4VvNWRDcOoWOEvghc314urktAX5IoB2BbnW342L8twlAfTugEN4+jP5adxMmevMW47izI0UVUyznobg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iKxXnh7n; arc=fail smtp.client-ip=52.101.48.62
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=busck44Cx++mbTQxrQYqVEikpQHauQnvxlwPBiRRP8d7SA9GWGs46LrWEKB5ZsKkENK7wrcM/tP7GVV8DGPvRk2TKecSMszfwIjRk/4ALYEsDIo6RoCv0v4ungMOfeLa9iiKZ71JAoLs72w54L3rzAargmTYKyZ6x4ddGPi0nrEmrVTp1VkIgMFT+rqU8afv77jYiTQ0fqkSrmXesKD0jSBqQqu4jo8oRKJKfHzgCXtc+QFISQ/5NZPxGRvAXf/v2y1oGPNUiFdpFhW8VX4QRPLxVJa6Dt4QvZTBzziFhT7zqTClWbjaEgHycFiJJuOFvYf3cfQXyRjyblUxZEnuTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IyhYqp8cpRlPqbZcoDOa7ghHFwxJjJ5yMHrwriIvpX4=;
 b=Ku4XIQcQEU00Fg5DQBdt1h/glGWNncPLFMMrTLA/5RS8gkLssdU/TFr0OPWSQqtoHHGn6/A0yStZFpEHeTD/yAUL1i5qlRJ7RnRVHgpEbtDeRWt20a/yzfYVoAKJvr+OlcLmlCB7/7GKZsr+3OS6fBFeKMo+w1OBb2vMaUgazLOzl/Uaa7KRa2pXsmnR0QnRa/Bhy12bx+Byxx0cabeYYJPGyx5Swwed9n4ci/kL3PYMs2amJ49+U+kWUbmXwDo5Yrs3UxYEmgBTSZ2AAiw1k3Kd7upfGQyuTJ4zdeBADXE+HqKgmbhjbz8TcnBb5WsSIblGFhfu3sH4JLE3dorfyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IyhYqp8cpRlPqbZcoDOa7ghHFwxJjJ5yMHrwriIvpX4=;
 b=iKxXnh7nDhwRJg318xQGjhQiewwP56XZpfxIXjXl2UreC9HEa37xVhps7pC0pnYuh+ApFR8932fEWhW/a2cz4MJvMsy+wZENZwfSvfPGvHM0V/wFjT3csF+zszs8qlHZt7c///B/1AMjLNQyYswNGrpxom32Uiz6nW5I4Kh2OJXZ3Ndr6bwH+qh/QKmTGAmI3Tn6anAdWTVUMdtyvUQ77e1qQZiJ+mOr0mztGsFn+KUviBNUUg3HNpb5pcUDhNkvEx+wF//TXgaun0N0CBiTWqZGnBiWzVWBpM+QIOvOuNyFzb9pM2wLqXyq+2Wzs41HvrtcIdAXx1UPaJZsH0znMA==
Received: from SN7PR04CA0033.namprd04.prod.outlook.com (2603:10b6:806:120::8)
 by DS0PR12MB8200.namprd12.prod.outlook.com (2603:10b6:8:f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 08:03:45 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:120:cafe::59) by SN7PR04CA0033.outlook.office365.com
 (2603:10b6:806:120::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Tue, 7
 Jul 2026 08:03:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 08:03:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 01:03:23 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 7 Jul 2026 01:03:19 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <donald.hunter@gmail.com>, <kuba@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<razor@blackwall.org>, <petrm@nvidia.com>, <nikolay@nvidia.com>,
	<idosch@nvidia.com>, <bridge@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net] netlink: specs: rt-link: convert bridge port flag attributes to u8
Date: Tue, 7 Jul 2026 11:03:04 +0300
Message-ID: <a57cdfcfc4a6dcb92106c25b4dde5059fde2bd44.1783236731.git.danieller@nvidia.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|DS0PR12MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: c4c2b442-e6db-445d-fb60-08dedbfe449e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|7416014|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	7u590OuwMV4Q2r+6cBNGbhfNPXSSUu+Z40iQAPNWCQwUkMQSEa72VvDZ9j/ggIH6rnsTte/XZ8cVJBuljEnoxTmsp/2vp+zx1IdJDsChLIGenZFM9jOEnjORqMCXgPyZcTWeE9BGKnz6Ydno0LMGkjUFARTyM0EcLxtYjP1QgsbyWMhK70mikoduf2QS2FOgI+3Lthy44u4CucoTPFFYb+L6UldumNGKzaLXmhIL3RFTxcNq+Ewj+WFMRnd4za/bd7RW2qi103R90ZK3O+X2u+VDXIf9jEOuM962nAXqvp03qecxF4QtVJx+LKq9vot3BH8+8UVTgFCLSI+0F/BIWyUfGii9mtwaOGV1P+oZ+O5yw0fMm9w2Ta3BQt18PFalKVQ96k+Z4nyRv4PI0iRVPbISmjPQ7s9+JDAbuB1S3U2h2750VsnWkkQkfET0duiLOyABdxJcRVMYoBYe01oOvBdOzwRce6VezeM5kpQKgKk+YueE/vCWaMC5peKoWvBvnTevQoH5C7hEIsHylgN2DRf9DFsAmBh9wkErCN7MQ/6k/AyO/Wp9PzX0XUmZo3irbkAJ7Dge4LQhapTFl6LbTNXmAIivlMPp+BGBbQnJqKGiX7cIW9JkGbJ8UDX4G/Rv0hgQtGoCXSWkeS4dWZTZOQuJvHKQy03hJFqXstMw1SOvoq6XO4jpATBcD7i2o1mO9wg/UMQ4A5yEjikt4AGGrg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(7416014)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9+vPXqIJPjMbKpcHcmJEysOz/uk5CISJqtVxqHypbIC2BeWkjZdrsz2qtABnXyX+6VGN6+EsmbWL/rgIwJSzK+IrQaeakxLXHUFHvH6ZpgubwtPBjTUi+o7Y8ljY+HpnKE96MwTiXclVwM3lVx6rcit4/wvcjUG0SwSITNe6l40SYqBpOaAJv+1MDDPFQvSLt/hQOKjJ3HGXg2SRns+l0a3pxcU/Lw237rYWGe3O+OyoN/FqZ6YyAre81iPFgbjGyvfXwVhRJXExrI36D/BRGL9MRyq7Haj2bSN6bAvzb86Qq6ueKsvDc1CXaM31IC64sOQbKhA6T/8APeVXP2c1VBKLsrHLg2uaVzJHsGb94qZJ8DiKKnCzZYLxR+axPws0+o9pl+JUj2RNs88kh5OgAgF03CPmjcVfulN6jSV+iR5nF4kU5s7zk202rorY/x+V
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:03:45.1075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c2b442-e6db-445d-fb60-08dedbfe449e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8200
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:razor@blackwall.org,m:petrm@nvidia.com,m:nikolay@nvidia.com,m:idosch@nvidia.com,m:bridge@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:danieller@nvidia.com,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305317-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,blackwall.org,nvidia.com,lists.linux.dev,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A975718E73

A number of IFLA_BRPORT_* attributes are documented in the rt-link spec
as having the "flag" type, i.e. a payload-less NLA_FLAG attribute whose
meaning is presence-only. This does not match the kernel, which emits
these attributes with nla_put_u8() and validates them as NLA_U8 in
br_port_policy[]. The values are not mere presence flags but carry a u8
payload (0/1).

Convert these bridge port attributes from "flag" to "u8" so the spec
reflects the actual wire format.

Fixes: 077b6022d24b ("doc/netlink/specs: Add sub-message type to rt_link family")
Assisted-by: Claude:claude-opus-4-8
Reviewed-by: Petr Machata <petrm@nvidia.com>
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 Documentation/netlink/specs/rt-link.yaml | 40 ++++++++++++------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index 892979da098e..68c26a70bb64 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -1585,31 +1585,31 @@ attribute-sets:
         type: u32
       -
         name: mode
-        type: flag
+        type: u8
       -
         name: guard
-        type: flag
+        type: u8
       -
         name: protect
-        type: flag
+        type: u8
       -
         name: fast-leave
-        type: flag
+        type: u8
       -
         name: learning
-        type: flag
+        type: u8
       -
         name: unicast-flood
-        type: flag
+        type: u8
       -
         name: proxyarp
-        type: flag
+        type: u8
       -
         name: learning-sync
-        type: flag
+        type: u8
       -
         name: proxyarp-wifi
-        type: flag
+        type: u8
       -
         name: root-id
         type: binary
@@ -1656,34 +1656,34 @@ attribute-sets:
         type: pad
       -
         name: mcast-flood
-        type: flag
+        type: u8
       -
         name: mcast-to-ucast
-        type: flag
+        type: u8
       -
         name: vlan-tunnel
-        type: flag
+        type: u8
       -
         name: bcast-flood
-        type: flag
+        type: u8
       -
         name: group-fwd-mask
         type: u16
       -
         name: neigh-suppress
-        type: flag
+        type: u8
       -
         name: isolated
-        type: flag
+        type: u8
       -
         name: backup-port
         type: u32
       -
         name: mrp-ring-open
-        type: flag
+        type: u8
       -
         name: mrp-in-open
-        type: flag
+        type: u8
       -
         name: mcast-eht-hosts-limit
         type: u32
@@ -1692,10 +1692,10 @@ attribute-sets:
         type: u32
       -
         name: locked
-        type: flag
+        type: u8
       -
         name: mab
-        type: flag
+        type: u8
       -
         name: mcast-n-groups
         type: u32
@@ -1704,7 +1704,7 @@ attribute-sets:
         type: u32
       -
         name: neigh-vlan-suppress
-        type: flag
+        type: u8
       -
         name: backup-nhid
         type: u32
-- 
2.54.0


