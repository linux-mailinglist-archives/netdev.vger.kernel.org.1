Return-Path: <netdev+bounces-173023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB0DA56F04
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 18:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB3B1702B7
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 17:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9A723FC54;
	Fri,  7 Mar 2025 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="LCKywA+M"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013023.outbound.protection.outlook.com [40.107.162.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF502405FC
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 17:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741368537; cv=fail; b=Bhhhe9UWusmh1sA3ea8KiEoVbCFZeRKraLKxYu/1bC5Oc3cMHcTYW5MAT6svYX2p9KduHK6pQLeZoVd0RygcFdk+B+mx6vcbPBTrF2DPcZfmvoCCcRWGIqWxJsOBZn+qBg2a9WVtbQSTUhw+gVObTaUqGrD6qh5aM2CFl+nAwuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741368537; c=relaxed/simple;
	bh=6NwKGOPJ8asxsqOZA0hgsCIQXbsdyUNcBRhPazaM7Fg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=peTwwwNGsyVNMj0rChvEcIm4ymBCY5P/Wqog2IcsVVT8thqjCz69tUeCwMQUpZ/pB2l2nzM4bRAKtLBhzg+KVyqkanoVLmnggToX8dqiFt1tBOzKJkhBS+HjZTqHIOZFuwY0URaUkEKdJ1kL6WZFqIv4pR6/2/AX+kphT16M+Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=LCKywA+M; arc=fail smtp.client-ip=40.107.162.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmK+7qDrFwJL/LV9wRIfOmPsbVHjfMEVXIJ4uXl9P2Tq6sdODcIQoh19nS0lrxvgwZbq1ps3Lmp+JzNwLvSRIJb9EA2f36PjZbZdRaN7swcTymfBnPHbO+EVhBVoxdjTpPvVvLS7ekSe2/TEXIIAvUd+HQoY4nS9nzLe2pd9AZ2SX4NMpNKliaEpvTQ95BlAWT9dg/Z/yyvgeKGWdmcZDDpEaS4O7uK8rp0ndozH7yZYrqSh4X4NV/weXUzRpIW4q80j9600dQbdS9WL1hhY6P+5WPvVFIx9llsTVS0Yo0WoPQ83k1Jc87iPuhAOIILtalQqpS/phjBX8pWVCJ1WEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmxEfDSqhYSMcPij2RNNEIX0ObyhqtzoghHADLcJBEU=;
 b=fT+yMJQ52OxDR/NiNXOL2yI/nxGUpLv1LdYGxR7QWFl4N4/yT8xtin+6uJLrsEOAx+74z/X9uYcJyTPT5quStvKc5BY/Weero3Hpr7rOWJUz1wyLycZCtCrQMdLnp0NEl6jeWs1DzKhAbIWK4qmmfzcK/8dPssVhoy6dMQfsBqSPHrobFQeSs0camwE5/2zM89OSf7JYm35uuz6OZsKQhGHGDzq8jWfsnBYCLovUCRRMsWc0vTIj9os4qx6Q9/hpUakBRNauqX0QbmRWLfbo+a3UxtRLTWSKoe6UAshUSaP+EcCW24dMJ5f3qJT8/Pk2L297mPe5zBSqiZPG5ck6VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmxEfDSqhYSMcPij2RNNEIX0ObyhqtzoghHADLcJBEU=;
 b=LCKywA+M4xHKlOkbXHl/GxOwHVFWvRJJMTIH3oQ2+T3qjU8c1Z7FG1XmN+xL5YSRjw5TaxMhiUuZiuVJzpUiz4V+HPV20yl4rNGzt+LUPRr/vUqbTzIwawgTVgsE3uuOqCHy3UoZGTXlEJUbSEFLcxVsnR8KjetgL2UJIRZAwBaxDl38cOKfZgoZFbhq82Q19Ude4WWB+KuuDFSRgrGpxlJ9HYigBfPGjMmNgdz78P1Ptem8z6CICuj280agotjokQVxZxIqPG++BvdingtaqxcX/TEL8ptjksdzB7tkbjxOFgeiJMk5/9EB1jyRQs/6IaZDJUrjgynYKZNnvSqp5A==
Received: from DUZPR01CA0224.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::20) by PAXPR07MB8031.eurprd07.prod.outlook.com
 (2603:10a6:102:15e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 17:28:50 +0000
Received: from DB1PEPF000509EB.eurprd03.prod.outlook.com
 (2603:10a6:10:4b4:cafe::6b) by DUZPR01CA0224.outlook.office365.com
 (2603:10a6:10:4b4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.22 via Frontend Transport; Fri,
 7 Mar 2025 17:28:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.20)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 DB1PEPF000509EB.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.15
 via Frontend Transport; Fri, 7 Mar 2025 17:28:50 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id A71862342E;
	Fri,  7 Mar 2025 19:28:48 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org,
	dave.taht@gmail.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
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
Subject: [PATCH v7 net-next 2/3] selftests/tc-testing: Add selftests for qdisc DualPI2
Date: Fri,  7 Mar 2025 18:28:32 +0100
Message-Id: <20250307172833.97732-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307172833.97732-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250307172833.97732-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EB:EE_|PAXPR07MB8031:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f43f4047-66f5-42ef-dcb0-08dd5d9d8667
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?ceeUqoUkqyNv4lRWGhnTYe2+/4YcEp5eYzCdnmfaJHAbGt7I+vvNNi19hoYn?=
 =?us-ascii?Q?FDldVOSUGpH56H5k9nFDtUth+Swwx7q+Vk7nv/fXXYNraaWviUV9u8t8pJbD?=
 =?us-ascii?Q?qAotQci35QojrkdqBL65/nl0V1yuBjm8hnH540TkuPTZtyF5aowrOdjvH6i+?=
 =?us-ascii?Q?7wdDtTpu2IZqxFepr/b80y1Ni6/NoECxS0cchV5pZ/yuHmf+VDDitLrVOlHP?=
 =?us-ascii?Q?I26cJ1dC7Lb45ju32vciTok4eXTf+06AahY6fOwAne+GsaT3TxLyLAiyOL5x?=
 =?us-ascii?Q?Az8hIZi45qExhOYKiCBaWmYNBRi78sSjQ6Mo/iUrMXEeI2M+vA9b3lnKjDWs?=
 =?us-ascii?Q?SHXBtf81g0pyjpYwqjCY15jAIac+92ZTwrPu3kksoiRnPc6FbhHDod9pjAal?=
 =?us-ascii?Q?GZKP6BN9+cI5YS4zQWydnogSLlXbenHkLTRVyEq2QZYGBHd/o2cd2S9rwcIu?=
 =?us-ascii?Q?/ezb+ZFtALsuXcD8nPFxrKBmG9hIPkzlWGippDuw3cos5sDyNo5KujTUMnxe?=
 =?us-ascii?Q?2b7tLTztu3kP6HTMKL0mlf8dFQw6f7IdWrvuHSrOjzJPBXnkqcIy+pgXGrNF?=
 =?us-ascii?Q?Bo7xdWp6Er/F0kJs4Gh2MyOnEi2OYRCQbjq2V+9rbVrwbMPrQnCIPdzebHmk?=
 =?us-ascii?Q?74QMp6KWPhDVvoSFvJZZM1rrmMzEFF6DNWWl7xdkD2QmlAv7bLCak//f8VR3?=
 =?us-ascii?Q?mSUrrG4IsSZaV2XYkbDw5PfeTfajePEAJ3J8PNUaZxLOvwD0NkhsmZKeNI1r?=
 =?us-ascii?Q?Sc7th62ZA3BX0T5z2AqFaV5uWAX925NpyDmK8hOgHlFTRNyD11ghODMOEgSt?=
 =?us-ascii?Q?Fdli97LOZYX2sNdbgbAV58VXMnv9t9k//TZbWnsHrI9B+S6oLQa33aTdPP20?=
 =?us-ascii?Q?SwxqBzUCJ9zgG061hci1hWyJ2KlijvmQxR/dwjQD8NaetTu1wrNBlJEqmjRl?=
 =?us-ascii?Q?1385bAXetOH0f05FMoUGxc5ghQHxXDdkrmedWPRTrrtga8npPPF/uJcoFcIM?=
 =?us-ascii?Q?7cSTV2tUePHirtNwB6Zg5PuBXauKSz4vm2vOnI1Wl1Q166XsTIoWSJbz5zB9?=
 =?us-ascii?Q?YP4bM6zOYL7scd8EUrAFTEVTAb8P0Oh5jpRcC5NnRoFtXumSfXdQX9phQG0f?=
 =?us-ascii?Q?06l67QgyQ4G5gRvksN1YP3/DpH661F3ng3M680Ri/pCIsxl6/0HmcTpK+7j4?=
 =?us-ascii?Q?5Ev1x3IIaY5ygCLSRK/3kPIBA9GACs7K5YGNFCkAJ4QKnI5sieS3n3Qb7Zuf?=
 =?us-ascii?Q?U8QWbl8YBVPMzc8SXBErqiSayXv8s2wu7Kd/ASWx3GvZeOpXCnE30MwWofW4?=
 =?us-ascii?Q?DJC+P1+53G+9rmz1WDMc5W12vpI0qN9pADUbt5Dfem4xICa0t5aeHLg3d2f+?=
 =?us-ascii?Q?8K71w673fg1QDR7xpYc49lDR2fRTMu8b5Nkr12XKYivf0OaCvvhLIMEbFpU+?=
 =?us-ascii?Q?wVvWOGTyAzMrg41Ks+BG8pzpagPMiYo3O9dNM0hT8twHqLzVVdXMqSqt9WAB?=
 =?us-ascii?Q?DqOqoiH5okTpMhM=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 17:28:50.1587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f43f4047-66f5-42ef-dcb0-08dd5d9d8667
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509EB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB8031

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Update configuration and preload DualPI2 module for self-tests, and
add the folloiwng self-tests for DualPI2:

  Test a4c7: Create DualPI2 with default setting
  Test 2130: Create DualPI2 with typical_rtt and max_rtt
  Test 90c1: Create DualPI2 with max_rtt
  Test 7b3c: Create DualPI2 with any_ect option
  Test 49a3: Create DualPI2 with overflow option
  Test d0a1: Create DualPI2 with drop_enqueue option
  Test f051: Create DualPI2 with no_split_gso option

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 tools/testing/selftests/tc-testing/config     |   1 +
 .../tc-testing/tc-tests/qdiscs/dualpi2.json   | 149 ++++++++++++++++++
 tools/testing/selftests/tc-testing/tdc.sh     |   1 +
 3 files changed, 151 insertions(+)
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json

diff --git a/tools/testing/selftests/tc-testing/config b/tools/testing/selftests/tc-testing/config
index db176fe7d0c3..72b5f36f6731 100644
--- a/tools/testing/selftests/tc-testing/config
+++ b/tools/testing/selftests/tc-testing/config
@@ -30,6 +30,7 @@ CONFIG_NET_SCH_CBS=m
 CONFIG_NET_SCH_CHOKE=m
 CONFIG_NET_SCH_CODEL=m
 CONFIG_NET_SCH_DRR=m
+CONFIG_NET_SCH_DUALPI2=m
 CONFIG_NET_SCH_ETF=m
 CONFIG_NET_SCH_FQ=m
 CONFIG_NET_SCH_FQ_CODEL=m
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json
new file mode 100644
index 000000000000..1080074f2650
--- /dev/null
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json
@@ -0,0 +1,149 @@
+[
+    {
+        "id": "a4c7",
+        "name": "Create DualPI2 with default setting",
+        "category": [
+            "qdisc",
+            "dualpi2"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root dualpi2",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc dualpi2 1: root refcnt [0-9]+ limit 10000p.* l4s_ect.* drop_on_overload.* drop_dequeue.* split_gso.*",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "2130",
+        "name": "Create DualPI2 with typical_rtt and max_rtt",
+        "category": [
+            "qdisc",
+            "dualpi2"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root dualpi2 typical_rtt 20ms max_rtt 200ms",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc dualpi2 1: root refcnt [0-9]+ limit 10000p.* target 20ms tupdate 20ms alpha 0.042969 beta 1.496094",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "90c1",
+        "name": "Create DualPI2 with max_rtt",
+        "category": [
+            "qdisc",
+            "dualpi2"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root dualpi2 max_rtt 300ms",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc dualpi2 1: root refcnt [0-9]+ limit 10000p.* target 50ms tupdate 50ms alpha 0.050781 beta 0.996094",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "7b3c",
+        "name": "Create DualPI2 with any_ect option",
+        "category": [
+            "qdisc",
+            "dualpi2"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root dualpi2 any_ect",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc dualpi2 1: root refcnt [0-9]+ limit 10000p .* any_ect",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "49a3",
+        "name": "Create DualPI2 with overflow option",
+        "category": [
+            "qdisc",
+            "dualpi2"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root dualpi2 overflow",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc dualpi2 1: root refcnt [0-9]+ limit 10000p.* overflow",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "d0a1",
+        "name": "Create DualPI2 with drop_enqueue option",
+        "category": [
+            "qdisc",
+            "dualpi2"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root dualpi2 drop_enqueue",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc dualpi2 1: root refcnt [0-9]+ limit 10000p .* drop_enqueue",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "f051",
+        "name": "Create DualPI2 with no_split_gso option",
+        "category": [
+            "qdisc",
+            "dualpi2"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root dualpi2 no_split_gso",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc dualpi2 1: root refcnt [0-9]+ limit 10000p .* no_split_gso",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    }
+]
diff --git a/tools/testing/selftests/tc-testing/tdc.sh b/tools/testing/selftests/tc-testing/tdc.sh
index cddff1772e10..e64e8acb77ae 100755
--- a/tools/testing/selftests/tc-testing/tdc.sh
+++ b/tools/testing/selftests/tc-testing/tdc.sh
@@ -63,4 +63,5 @@ try_modprobe sch_hfsc
 try_modprobe sch_hhf
 try_modprobe sch_htb
 try_modprobe sch_teql
+try_modprobe sch_dualpi2
 ./tdc.py -J`nproc`
-- 
2.34.1


