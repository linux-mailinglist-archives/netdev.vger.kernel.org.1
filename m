Return-Path: <netdev+bounces-259401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iO6iE3uklmlsiQIAu9opvQ
	(envelope-from <netdev+bounces-259401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 06:49:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E4D15C2E2
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 06:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2043430241B5
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 05:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3A72C234E;
	Thu, 19 Feb 2026 05:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="exttTClC"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010064.outbound.protection.outlook.com [52.101.201.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4154A2D0C79;
	Thu, 19 Feb 2026 05:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771480179; cv=fail; b=tvwkcn+wxH9/clr6wlR9kMBW2UI7JltCYYbchqmRgnpQlZkPcuEEN2xSMlMbdjuZYAdm5sMBN0nV3JWz/gwHrNaWG/g2q02/IKhoMQva8V5gyylMEh6kP0uLTTcJX2RLQRJTCheYLJhRjSCgB/gw8FT/7XOJLBZcMu5Wuh1MZ1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771480179; c=relaxed/simple;
	bh=sFyUrViBJZu4PD5sE4LK1ZeXwOdA1kLZyWD1m6eI/kM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pFSN5JhE0s6cfsTkYOnRJ5vNFgJN4P2RicoF4FfgJ8IKjdrXAuaE3SANTgCH/ghliGrVC2vUfZHMDl3LvVeM9Pb4TypoScvePcApcfa0L5Nc0/ZBsqGqVEOqDt0C5t4uhmm+26l0GQfdJSgrQ83L0uHqcFcyCvwgVsiYbdnlpAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=exttTClC; arc=fail smtp.client-ip=52.101.201.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWwLJGIiOaZOQeFVCJ79UBmOI73WNnQhAV8zPx9yfCoA+tKBAOInNSPeWonVh+Lry53iMdRHUj1kalE0SSXyn09qmLY50xYdQjuP1Qvyx5pOeV19c61uJOR1tpsOhaiMxWk36709wfNJEKBnKB8oL32Q5wfDI72e02bM/JQydMPAUlrccWZHQ/2htGHRm+VeRNHG1Z3ksUStiR8Z3jGKK0ORtaaX2UAB9y8B/lQqVCZXRucBOfGnKk2kC0eagnCtt4j/ojQVBBOSyuLuQAtkG03DZlswIJ5rbW0T7iRitwg+PscHNP0YWbOSkCYu2uLMAezKT4XKZvP39MT8vx2R/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1JhVxiINl4/OgvY1Prv82mvqv91E1g15ShpcUrgXwI=;
 b=ObM6OaxEcqny9og5vVM8Z0MpEoIJFPp2to18dlNbXRXrqE6wtupXCga2bU7CmYPtSLS2OtqY7tXsi8lDTIdn5jJ3FcS5Mh5jjGMbV0IaWmjzXCi0nbNfzOpBcf4BylBd/fx9txdMSSH7LM42zoeCxZmm3w6zGy/MVwGPyF5Ka5As6FT46AXnSkROSm4K0FZ9fmcWL3qpBnnZn6mBle1RfdilkVtJh5tGESNV60zgXrlx9RBiRx/pY8Njx1+Q6UYIdUw+lzItvu3NiY/UJY4B3bccNzC8MKNY9kUQTnvQ3Evx5UbmQBHiX4eGkKlT+WEddyFtSCmS1JaDmmbyKIGaiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1JhVxiINl4/OgvY1Prv82mvqv91E1g15ShpcUrgXwI=;
 b=exttTClC+MXHY+ie0ybmkXlWd6Dgp4PceBBjuFNpbInL4BYaqrli2kcWdLhkvaDhTs2AzxdvJzOsb59ry1HsYKkBBinbAf7naHNlgVtFLB4TjjfB5bd9x/BHt0lNAa0xeo010/6Vw/O+3APlVdBR3NaDGZpLfjB1sQ2IzNKjwmg=
Received: from CH5PR03CA0004.namprd03.prod.outlook.com (2603:10b6:610:1f1::6)
 by LV2PR12MB5893.namprd12.prod.outlook.com (2603:10b6:408:175::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 05:49:32 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::ae) by CH5PR03CA0004.outlook.office365.com
 (2603:10b6:610:1f1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 05:49:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 05:49:31 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Feb
 2026 23:49:30 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Feb
 2026 23:49:29 -0600
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Feb 2026 23:49:25 -0600
From: Srinivas Neeli <srinivas.neeli@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <michal.simek@amd.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>, <srinivas.neeli@amd.com>
Subject: [RFC PATCH 1/8] dt-bindings: net: Add TSN Endpoint Ethernet MAC support
Date: Thu, 19 Feb 2026 11:19:04 +0530
Message-ID: <20260219054911.2017362-2-srinivas.neeli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260219054911.2017362-1-srinivas.neeli@amd.com>
References: <20260219054911.2017362-1-srinivas.neeli@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|LV2PR12MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df2a0ff-6ce1-4fe9-61eb-08de6f7aa72e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|7416014|1800799024|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XaO6xdPra7err53QLpwlcW+ZvixD8jjSw0ro7UnrJ7Pabm7qN/LMPnPzN3h8?=
 =?us-ascii?Q?kFKbBGEvBZ4U6S2DfOsQvmUdyeN+j3kPuTM4dZlQmVjvDLTNTdSPNWusnuUD?=
 =?us-ascii?Q?qeC8uA+XxRs2C41ybEB5payWgu7DyjWFup6zSYqVI4Ifo//TQpypQ9aZk2bm?=
 =?us-ascii?Q?iI0ZiNTW1S/Xhb1djxABlz1jLHwwGBpv85vF2jtp+2iyqPRzJnFgDNOdEceH?=
 =?us-ascii?Q?WdhyH8oPRKojCLmm5XXjkBppkTL3UE8x6A+MiKkfP9bMald6rGxvmALikMy/?=
 =?us-ascii?Q?+DXC/4ye0/mUhj3iE4MqCXTxbDw3mNEYcn0V/7tV0qK4zcI1+wzH5hEX0POI?=
 =?us-ascii?Q?dRgEU8t/R8Gbu2IfZXYGmAu02kgNHSziL35te2RXQHyuu6xGdn47TgjZa5nF?=
 =?us-ascii?Q?z5qa7y5mZWw9USInhCz70Ax3KKI++usTB7E21XtUhoaTlxIVs4bkTo+uL+cD?=
 =?us-ascii?Q?JoBMn1/XtExrOfBx0GEmil5J2YfIBv52RgWC0LMUNG/nojfokYXeR3qiwOxD?=
 =?us-ascii?Q?e2ALvfE7wkvCnpUORlaXeQky7iwWK7DQTqSScMqrgFnASO6SxO+6CPs13ETw?=
 =?us-ascii?Q?QPcjLyqjLM9OraJ6mhM/K6UkzPexV2sDNRcneuSy+U8NJH1y3ARP6fAix1s0?=
 =?us-ascii?Q?06MwBUeWvAMgQ8aR5FtcP+aDq4D46JsZ/NAe4tldvBeNgkaCtDUHxuWecprJ?=
 =?us-ascii?Q?iVBrlefeUlYV/9Yd0CCF0YPhwbrmmM13K9GkdKOa04j5fWwjqcLetWyleou1?=
 =?us-ascii?Q?/F8dGJ161WH2J75FQBwM2j0C9zZmoZrI2tf1qdz3AfJJtO7hFIQZuC1wRU6Y?=
 =?us-ascii?Q?CNkNzVS5OXKvraq7Wc4OAMYyXN9vh2+RiMAMBMR6/45khauG1nmc9FT3a+NJ?=
 =?us-ascii?Q?r+uaioiL4IHU3qp6euXrWfGZWg0BlIzCuiqfbd694io2ib9AkDkb8nCQJhsM?=
 =?us-ascii?Q?accj0MN8geLII+xPgnrjcZvo/YmjCq5qCn34Ktyr1UecMv36qOtVX2zdWdCD?=
 =?us-ascii?Q?jTQ84PaiDWivx++agDdpbezvw66r4/BKcOpZVJGjP1XpvrhNFUYAYW3VO4gm?=
 =?us-ascii?Q?TR5HtLvMEMhfcP1z+aC0VgZEB28ttc+S55R4n2+whecwJf+6yAf8CLPDTI/m?=
 =?us-ascii?Q?Tk/FLmq2527vGFSO4/KOcRFjyPcxYbGXE7DulTFxg+DcElNd2vRxW1h66WA3?=
 =?us-ascii?Q?GfxVRmDv0aN4/rIskMYhCGTOShoGLBwym7xlEEYwKhzPYVvLpfmTMp1itTET?=
 =?us-ascii?Q?tymI3bAsHkBvEzHczYLInh0zKuHrGpcC+00JbXRnTBNDHkatGauwXppxx7+i?=
 =?us-ascii?Q?+rIdPI5H5E7s+L52AfYiu9yhEcjf0ayc/KNHYUXlF4D9n2+aflrP27pHSK4r?=
 =?us-ascii?Q?4UHkKDKD3oPpXXDP6L8ArMDPWxZ0uW7CCEiISp6GjmnyDIKo88S63tijTOHe?=
 =?us-ascii?Q?CxeFDSFaqUvQpfXItMMRNTRBgNLJmgJjzP3mQjaASOnix/FR8rDMthfgbFEE?=
 =?us-ascii?Q?+GmSDQLotb1GA6pBAXzNNQ1jeqpZ0rUhuB5fHWuAXpfDAH0KPoDQ8SGgrBgs?=
 =?us-ascii?Q?pLg/ZQ5uYxPc8r+yLGxSSSO+D8rcASgWuIvkNwM3eXHxJ4GD3R4rwzvMjGKh?=
 =?us-ascii?Q?aEkWIFz+0bkzoQXPMw6APdPwuYrIFv37R+dpqT1RR8jdCmD/wdGleKzvU94S?=
 =?us-ascii?Q?XYbiWDzLzddQWIiRTifbXD63cVY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(7416014)(1800799024)(921020)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BHjiPN+vOJxuegQdGGRL3VkajaJKLQXWkoP0pI1BIWKCV+5PDpv5VC1X0ngvQyr8NcVjeGm0Tj2vVaJXV6TghpIN/w4yBZOe0XuoKIwFIXDVoEYtmWVmdAgcxERG1qSR+ezVojYd1E2wka3R1J5zFgZrDwJOZl8iaydw+7RR9G+VC0KJLrEdYVoZs1FcumfjK/Smq2gr6lEGL1ZYmq2sNr9S3KQ23JoYHUGsr203hA3ZDrFTKlIR65XziQ0tZ2xntuQqnSgREvl+7kfEcoS3Hk5zRmo9QcfjR15UqntKpqXj5U9NFsx0qbux7w4EIdBLQHopiyVp6/xqvB3dK0cbnY9cCCtfdxhikWXCSe5sK/0jztmzOEcBvV/8VDRW44YMEnj7sVjtkMXsmoBochj85XXkjln28tQUY1Sg2ZF0sRZjF52lQgR2l0+lveUI5vCY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 05:49:31.3921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df2a0ff-6ce1-4fe9-61eb-08de6f7aa72e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5893
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,amd.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259401-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.neeli@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B3E4D15C2E2
X-Rspamd-Action: no action

TSN Endpoint Ethernet MAC implements IEEE 802.1 Time-Sensitive Networking
(TSN) standards, providing deterministic, low-latency Ethernet
communication. It can operate in two configurations, either as
Endpoint-only or Bridged Endpoint mode. The Bridged Endpoint configuration
integrates a three-port switch, with two ports connected to the external
network and one port connected to an internal endpoint.

The IP supports GMII and RGMII interfaces for connection to external PHY
devices, enabling full-duplex operation at 100 Mb/s and 1 Gb/s.

Add devicetree binding documentation for the TSN Endpoint Ethernet MAC IP,
including support for multiple Ethernet MACs, a TSN switch, and an
endpoint block.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
NOTE:
The xlnx,tsn-endpoint-ethernet-mac-3.0 corresponds to the TSN Endpoint Ethernet MAC IP version. 
The IP Product Guide is currently under review and will be published on
the AMD/Xilinx documentation portal (similar to other IP TRMs).
---
 .../net/xlnx,tsn-endpoint-ethernet-mac.yaml   | 287 ++++++++++++++++++
 1 file changed, 287 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml

diff --git a/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml b/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
new file mode 100644
index 000000000000..0d61a911e1d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
@@ -0,0 +1,287 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/xlnx,tsn-endpoint-ethernet-mac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx TSN Endpoint Ethernet MAC
+
+description:
+  TSN Endpoint Ethernet MAC IP implements IEEE 802.1 Time-Sensitive Networking (TSN)
+  standards and provides low-latency network connectivity in either Endpoint-only or
+  Bridged Endpoint configurations. In the Bridged Endpoint mode, the IP integrates a
+  three-port switch, with two ports connected to the external network and one port
+  connected to an internal endpoint.It also supports GMII/RGMII interfaces for
+  connection to an external PHY, enabling full-duplex operation at 100 Mb/s and
+  1 Gb/s speeds.
+
+maintainers:
+  - Neeli Srinivas <srinivas.neeli@amd.com>
+
+properties:
+  compatible:
+    enum:
+      - xlnx,tsn-endpoint-ethernet-mac-3.0
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 6
+
+  clock-names:
+    items:
+      - const: gtx
+      - const: gtx90
+      - const: host_rxfifo
+      - const: host_txfifo
+      - const: ref
+      - const: s_axi
+
+  dmas:
+    minItems: 2
+    maxItems: 32
+
+  dma-names:
+    items:
+      pattern: "^[tr]x_chan([0-9]|1[0-5])$"
+    description:
+      Should be "tx_chan0", "tx_chan1" ... "tx_chan15" for DMA Tx channel
+      Should be "rx_chan0", "rx_chan1" ... "rx_chan15" for DMA Rx channel
+    minItems: 2
+    maxItems: 32
+
+  ranges: true
+
+  xlnx,num-priorities:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 2
+    maximum: 8
+    description:
+      Number of traffic classes (priorities) configured in the IP.
+      This is an IP configuration parameter that determines the number of
+      priority queues available for QoS scheduling. Traffic classes map to
+      IEEE 802.1Q priority levels (0-7).
+
+  xlnx,tsn-tx-config:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Multiple TX Queue parameters. Phandle to a node that implements
+      the tx-queues-config.
+
+  tx-queues-config:
+    type: object
+    description:
+      TX queue configuration node that maps IP priority queues to
+      DMA TX channels. The TSN IP supports multiple priority queues for QoS
+      scheduling, and each queue can be connected to a specific DMA channel.
+      This mapping defines which DMA TX channel is used to transmit packets
+      for each priority queue. For example, queue0 with xlnx,dma-channel-num
+      set to 5 means priority queue 0 uses tx_chan5 for data transfer.
+
+    patternProperties:
+      "^queue[0-7]$":
+        description:
+          Each subnode represents a priority queue. The xlnx,dma-channel-num
+          property specifies which DMA TX channel (tx_chan0 to tx_chan15)
+          is connected to this queue for transmitting packets.
+        type: object
+        properties:
+          xlnx,dma-channel-num:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description:
+              DMA TX channel number connected to this priority queue.
+            minimum: 0
+            maximum: 15
+
+        additionalProperties: false
+    additionalProperties: false
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+patternProperties:
+  "^ethernet-mac@":
+    type: object
+    $ref: /schemas/net/ethernet-controller.yaml#
+    required:
+      - reg
+      - phy-mode
+    properties:
+      reg:
+        maxItems: 1
+
+      phy-mode:
+        enum:
+          - gmii
+          - rgmii
+          - rgmii-id
+
+      phy-handle:
+        $ref: /schemas/types.yaml#/definitions/phandle
+
+      mdio:
+        type: object
+    additionalProperties: false
+
+  "^ep-mac@":
+    type: object
+    $ref: /schemas/net/ethernet-controller.yaml#
+    properties:
+      reg:
+        maxItems: 1
+
+    additionalProperties: false
+
+  "^switch@":
+    type: object
+    $ref: /schemas/net/ethernet-switch.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        maxItems: 1
+
+      ethernet-ports:
+        type: object
+        unevaluatedProperties: false
+
+        properties:
+          '#address-cells':
+            const: 1
+          '#size-cells':
+            const: 0
+
+        patternProperties:
+          "^port@[0-2]$":
+            type: object
+            $ref: ethernet-switch-port.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              reg:
+                maximum: 2
+              ethernet:
+                description: Phandle to associated MAC or endpoint node
+                $ref: /schemas/types.yaml#/definitions/phandle
+            required:
+              - reg
+              - ethernet
+        required:
+          - "#address-cells"
+          - "#size-cells"
+    required:
+      - reg
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - dmas
+  - dma-names
+  - xlnx,num-priorities
+  - ranges
+
+examples:
+  - |
+    tsn_ip: tsn@80040000 {
+        compatible = "xlnx,tsn-endpoint-ethernet-mac-3.0";
+        reg = <0x80040000 0x40000>;
+        clocks = <&misc_clk_2>, <&misc_clk_2>, <&misc_clk_1>, <&misc_clk_1>, <&misc_clk_3>, <&misc_clk_0>;
+        clock-names = "gtx", "gtx90", "host_rxfifo", "host_txfifo", "ref", "s_axi";
+        dmas = <&axi_mcdma_0 0>, <&axi_mcdma_0 1>, <&axi_mcdma_0 2>, <&axi_mcdma_0 3>,
+               <&axi_mcdma_0 4>, <&axi_mcdma_0 5>, <&axi_mcdma_0 6>, <&axi_mcdma_0 7>,
+               <&axi_mcdma_0 16>, <&axi_mcdma_0 17>, <&axi_mcdma_0 18>, <&axi_mcdma_0 19>,
+               <&axi_mcdma_0 20>, <&axi_mcdma_0 21>, <&axi_mcdma_0 22>, <&axi_mcdma_0 23>;
+        dma-names = "tx_chan0","tx_chan1","tx_chan2","tx_chan3","tx_chan4","tx_chan5","tx_chan6",
+                    "tx_chan7","rx_chan0","rx_chan1","rx_chan2","rx_chan3","rx_chan4","rx_chan5",
+                    "rx_chan6","rx_chan7";
+        xlnx,num-priorities = <8>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x80040000 0x40000>;
+        xlnx,tsn-tx-config = <&tsn_tx_config>;
+        tsn_tx_config: tx-queues-config {
+            queue0 {
+                xlnx,dma-channel-num = <0x5>;
+            };
+            queue1 {
+                 xlnx,dma-channel-num = <0x4>;
+            };
+            queue2 {
+                 xlnx,dma-channel-num = <0x3>;
+            };
+            queue3 {
+                 xlnx,dma-channel-num = <0x2>;
+            };
+            queue4 {
+                 xlnx,dma-channel-num = <0x1>;
+            };
+            queue5 {
+                 xlnx,dma-channel-num = <0x0>;
+            };
+        };
+        // MAC 1 Node
+        mac1: ethernet-mac@0 {
+            reg = <0x0 0x14000>;
+            phy-mode = "rgmii-id";
+            phy-handle = <&phy0>;
+            mdio {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            phy0: ethernet-phy@0 {
+                device_type = "ethernet-phy";
+                reg = <0>;
+            };
+            };
+        };
+
+        // MAC 2 Node
+        mac2: ethernet-mac@20000 {
+            reg = <0x20000 0x14000>;
+            phy-mode = "rgmii-id";
+            phy-handle = <&phy1>;
+            mdio {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            phy1: ethernet-phy@1 {
+                device_type = "ethernet-phy";
+                reg = <1>;
+            };
+            };
+        };
+
+        // Endpoint Node
+        ep_mac: ep-mac@16000 {
+            reg = <0x16000 0xa000>;
+        };
+
+        // Switch Node
+        tsn_switch: switch@38000 {
+            reg = <0x38000 0x8000>;
+
+            ethernet-ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    ethernet = <&ep_mac>;
+                };
+
+                port@1 {
+                    reg = <1>;
+                    ethernet = <&mac1>;
+                };
+
+                port@2 {
+                    reg = <2>;
+                    ethernet = <&mac2>;
+                };
+            };
+        };
+    };
-- 
2.25.1


