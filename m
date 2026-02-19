Return-Path: <netdev+bounces-259406-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wH1xD0GllmlsiQIAu9opvQ
	(envelope-from <netdev+bounces-259406-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 06:53:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4FF15C365
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 06:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2224C3080DDF
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 05:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD9B2D3EC7;
	Thu, 19 Feb 2026 05:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3kV/h7+O"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012006.outbound.protection.outlook.com [40.107.200.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2412E2D0607;
	Thu, 19 Feb 2026 05:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771480202; cv=fail; b=RYVRq9ylsEMnwC1o4t2rpkiYWI5P3E0sSCwxe0ykp3y9efTr6Hlja1joLhUiiMm3Ra2vSuhEqPoDJmHLvpQ5oqbQIXWkKzx3AAGFXIGDEvcLkNwl+gva7x7rgPkv6W9iAOtzPvsGko1lszRW146tLw7XTCthZ8GHvpZsGaaCxdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771480202; c=relaxed/simple;
	bh=JhLBQGPczV1pG8s9IgW2Gfc6aeRNcJecDNFkc1tZzWo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NOQK5d4NqKmOgrmkkTKsGmCSuIgG1NgHU1KNpRGNTFH/CsE+Qles6N9gMcKlxJPE94+R1NZhXfxxJKNHV/oApi2DPKa/HJWgN+TJhcKlLcO/4HuqNhd0UOWw8HV7oDDETkeqv4N3au8HoAfC6zHy5kzrtYeUa2FgAVqiS53zIGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3kV/h7+O; arc=fail smtp.client-ip=40.107.200.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RW7emJRdxVeBpTAJrStdBtWPDce2eCTW+Ch5l1BddTkLrfciCNJ4J1SnXJsWOGbnzBFN4FsH8iS6is5GKOfNLwxUz/B96/H44HdH/ycxH8nKxUF0nKpT5YVBb1D8QhMB5GR6H94+taCE+ycqlmLAuNX/SFlZB4LAPBgrlrjNRRb46YTje+3iJTbwK1kNkDY3wv5z0jGkqOcSe20DEmdvE4cn2c1DLk+KLitODL6GbUZ7Q4yXI/wn1yn4sWei47mt6plo71Qw4IdL6ozx8868Td7WhDN63b0ODL2ebZzTpeCMyVmAxB8s80edmnYh2d/T03G4d7QKiu+NtEtANeAGPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=px6XeTeIKgMpbqCdjDEg4gksVwvMEi6wtH5XzuKgRoc=;
 b=JVibVpBn3hrfd7TDXTghxc7u86qirLlq3nV15pw0sBik7a0JakYgBBRHHa+XT8tehlcfbzxQsCYRm03+AbKxDnCngjmwlWYtKE2cq7zoQUrgJvfLzMuzB8C8PYQwbS1a5wSDw5kFPSah1v0mQTgYVYg0pMFZYxaMuWM4TTJI3qmkNDzloh8k6rcfSOV+OJorSfBmCB0oH4EY168gOzpAp+phyOuDDGqwZzZQpCvsoZx7ecnWq8MVCsEBK6BZT61uPFxogAhpxyuHdqxAGZYg+o5qEdhDRRDKUGTGeu2klldIp4YAepmYW5maJACgL8+IfdV9vScC9HVSxPg55Uk8Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=px6XeTeIKgMpbqCdjDEg4gksVwvMEi6wtH5XzuKgRoc=;
 b=3kV/h7+O1bwmlnNBxn/wL8rsrv6dnYFITsrEFsrbbdNJlgFLnh5zaZkAi8aaoQ8vhzuDZIf4VQhClZ9rU1/YClQl4NkZeYH5f4wrqNflzCkyijG8LXfCyx1fUFl8IwoJHoRmyWxoY6DmUIt58LeRnE7ejOGyHa9KYEHx8ufMOMM=
Received: from SJ0PR13CA0110.namprd13.prod.outlook.com (2603:10b6:a03:2c5::25)
 by LV2PR12MB5944.namprd12.prod.outlook.com (2603:10b6:408:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Thu, 19 Feb
 2026 05:49:52 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::3c) by SJ0PR13CA0110.outlook.office365.com
 (2603:10b6:a03:2c5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 05:49:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 05:49:50 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Feb
 2026 23:49:49 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Feb
 2026 21:49:48 -0800
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Feb 2026 23:49:44 -0600
From: Srinivas Neeli <srinivas.neeli@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <michal.simek@amd.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>, <srinivas.neeli@amd.com>
Subject: [RFC PATCH 5/8] net: xilinx: tsn: Add TSN switch support with port state and frame filter control
Date: Thu, 19 Feb 2026 11:19:08 +0530
Message-ID: <20260219054911.2017362-6-srinivas.neeli@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|LV2PR12MB5944:EE_
X-MS-Office365-Filtering-Correlation-Id: 6921346b-bede-498b-94b5-08de6f7ab2d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8yRwTHU1lixQPDIqDblgJgJee+Rjt9MPcXbOktnwFtBQ+CD5f8THdvokIViG?=
 =?us-ascii?Q?bbjtGO0v/COHrMvpk3LS6gY/tWvqkFk/3sn9+VTR/amVjdZahGtMa2f6nHjS?=
 =?us-ascii?Q?EOKCt8ItLMRfou7FD5/bLiuqVHNfhtRw1coTSfetn+de4TI7gbAB7TzGfrhs?=
 =?us-ascii?Q?fA1Kcz/WLtTNkqUZwy+EAfy5ipH1FBuiqVKR/jKeudKUJsuGMch8xsTs3K1y?=
 =?us-ascii?Q?A4C/NKccX+OizuzVB9ugKyXffChK3Fr8sBpS3bOhRdun2zgXn/96sEwORg0u?=
 =?us-ascii?Q?2olZFDXbzrvB9SonyaXPMolHhDxDB4Grj1MQSxAUGQ2FXeTmA8ZUnFWLhHPF?=
 =?us-ascii?Q?xAKUtga2Nkp7d5cUPHzaGWlxxiHrIYwwk+INYm57sSXhZJyxp/lbc6ksZeUB?=
 =?us-ascii?Q?DVWbNElIO1myYl3u1QPgkvlhswc1XueLtpl1aWZLjUe1TSR1cQgrZGZniNvj?=
 =?us-ascii?Q?uy8dQ3cIprRnB1F7WXe+AkbhVtc/NM5xW7mnjxcZc3zt6pm6DRAFwBNNaOzu?=
 =?us-ascii?Q?b6OU6vdzH/wBYtnM8dmfoHiP4A76pgGskPVIAx6Di72JGMc0tA1JuR/vSJoT?=
 =?us-ascii?Q?TUaxlejPvoVUIVZTwO/qA9i/PipmtisXd28/jPJifKEEF0Xvu7Ztop5YhqPR?=
 =?us-ascii?Q?mLesvVCqHeWztoKylQMhZ/3gi61JtLE3n4CX9vSRdaJjVlhD5t0UXSeD2QeO?=
 =?us-ascii?Q?IGAllGgSUx8MUv+0avy1MYckuwRFsDxhy+8VAQgjRT5w/hqzZzxM/uA+b49g?=
 =?us-ascii?Q?Z+0PEXdSmSh1AFpXhJ9kY3e6ZIT4/bcKie75JUpnb9MxZWW3JK6s3k4iLF8h?=
 =?us-ascii?Q?5h2E/gnx9YWjy6JjCkgW/NPYa6f0c3pCy2RQdmof9uUlRoG5ACcHhUk+angI?=
 =?us-ascii?Q?7vfnp/PQ5/86n4V08yTfJbaDeltUrsbIFnbtObyATP5MVywsJAhWW4N3mJeB?=
 =?us-ascii?Q?Eibv5b+kkI8f6HThUAhX5Y8/cLiqzg6b1VIojO+F2vRsSrqGWrorj32AN1cJ?=
 =?us-ascii?Q?SmqPmBV9huxTs0L4BuI36iskoz12DfFBGfpiqnoKt3XB80oSbGIPvNErJ4Nd?=
 =?us-ascii?Q?UIDpghfqDozcvl9aXBxiqjs7qKrF0UMVWoH6Su0fbIm/Lixl0Y8y00VHOlLa?=
 =?us-ascii?Q?Cl9W9UQQvfC8WNxcgaSGyDvaRKzgSjdcCBwbMhCEMIvJtQupiW6h06ZS3vkI?=
 =?us-ascii?Q?brX++haOSqYcnMaRTjFv7yUh2f9Agpl598HFsJchJehX9Xyx3cT26fYBWrs3?=
 =?us-ascii?Q?iyOc62s3vEX+jhXCboIoKl3nF3M/CL36y+1uXGL+mhyzmjBzvLFWnBtgc5Z2?=
 =?us-ascii?Q?PX61LS+CGiNtaJ23+GD+MUtBf08llmSL3k/dX6kxgQXd3H8dN/jbST09HtUq?=
 =?us-ascii?Q?MFoe6HjJYZyc1r0g3NTlL4aXWhtNuFIWfrFiK8YKYBJ0t9uNXiRzBuJuEe4l?=
 =?us-ascii?Q?JdjzXnxQfM32gI+POEVuq5bOrKLUup7+xGWBfcf7uhYzD+5/mZJHmqDBGDFt?=
 =?us-ascii?Q?ZgHj99TRYmdJHDj52CIp12a20E3GuIOU4TvG2hZFcK1YxCqYIVrJgnhZBNPq?=
 =?us-ascii?Q?yR9L1XxFL7ZjsApdMbsD8ht4T0qDKPiiE4HjCE9aaIunmxqCme0KsbiAmY4q?=
 =?us-ascii?Q?J9xh2sjm72cKGI4SwC1Sy2Op/gCiVT0QQs+P6a94SOnqwSXtxxR4Fa2/5TmR?=
 =?us-ascii?Q?tzPljMTMdhj/1HeXnv25WKCONyU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xB/x+0XZECM3LsnrXLK5BZMz+gBsB1ScD0kejEdytefG3XCdPoHksgf8D7MWLsWKHGS51p4LK/nz+pVbWC5MpGYiYS+JvNd/VW0mV1DMFD58RhZjvvBKiWj9gleRvn5f+e4muy0EWwrwuwXM6/rVjUTrSbSpUhkHLrau2SKNkpY7sVrEMxs/n7QKL/ZBFet7qL+JnQIUFOFDxVQfDyuh3xHSDar6/MlA92xgmras3lOEfq9PNVTq7YRTWG8faCi+9K9aRMHeQueesFd5OxVRK8jhKqa24/hh2WGtLbx8lwW8v+Sn7u7GZ9WS+r2EHaNecAIG03NnCJm82doe6ahlVr8bqIHNlnA4ZZFht6SFuxtXqfzVAdcQgIJEiq9HD7Ook47p7rG3XGbfGLhUki36ce7TK9GfgYpCM8J9Doi3NSAS5zgcMLXNmCBquGxneWSP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 05:49:50.8821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6921346b-bede-498b-94b5-08de6f7ab2d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5944
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,amd.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259406-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.neeli@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,amd.com:email];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: CA4FF15C365
X-Rspamd-Action: no action

Add support for the TSN hardware switch block, introducing port state
management and frame filter configuration.

It provides initialization and cleanup routines, register access
helpers, and APIs for port state and frame filter configuration.

Enables basic activation and controlled management of TSN switch ports,
allowing traffic forwarding between endpoint and MAC interfaces through
the switch.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
 drivers/net/ethernet/xilinx/tsn/Makefile      |   2 +-
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h  |  16 +
 .../net/ethernet/xilinx/tsn/xilinx_tsn_main.c |   7 +
 .../ethernet/xilinx/tsn/xilinx_tsn_switch.c   | 546 ++++++++++++++++++
 4 files changed, 570 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_switch.c

diff --git a/drivers/net/ethernet/xilinx/tsn/Makefile b/drivers/net/ethernet/xilinx/tsn/Makefile
index 5eb6dde67061..fc1c0cda0843 100644
--- a/drivers/net/ethernet/xilinx/tsn/Makefile
+++ b/drivers/net/ethernet/xilinx/tsn/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_XILINX_TSN) :=xilinx_tsn.o
-xilinx_tsn-objs := xilinx_tsn_main.o xilinx_tsn_ep.o xilinx_tsn_emac.o xilinx_tsn_mdio.o
+xilinx_tsn-objs := xilinx_tsn_main.o xilinx_tsn_ep.o xilinx_tsn_emac.o xilinx_tsn_mdio.o xilinx_tsn_switch.o
diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h
index c8435c09ed2c..91d01313aada 100644
--- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h
@@ -138,6 +138,18 @@ struct tsn_emac {
 	int irq;
 };
 
+/*
+ * struct tsn_switch - TSN switch configuration structure
+ * @dev: Device pointer for this switch instance
+ * @regs: Virtual address mapping of switch register space
+ * @irq: Interrupt number for switch events
+ */
+struct tsn_switch {
+	struct device *dev;
+	void __iomem *regs;
+	int irq;
+};
+
 /*
  * struct skbuf_dma_descriptor - skb for each dma descriptor
  * @sgl: Pointer for sglist.
@@ -193,6 +205,7 @@ struct tsn_endpoint {
  * @regs: ioremap()'d base pointer
  * @ep: Pointer to TSN endpoint structure
  * @emacs: Array of EMAC instances (up to 2)
+ * @sw: Pointer to TSN switch structure
  * @clks: Bulk clock data for all required clocks
  * @tx_lock: Spinlock protecting TX rings and related TX state
  * @rx_lock: Spinlock protecting RX rings and related RX state
@@ -214,6 +227,7 @@ struct tsn_priv {
 	void __iomem *regs;
 	struct tsn_endpoint *ep;
 	struct tsn_emac *emacs[TSN_MAX_EMAC_NO];
+	struct tsn_switch *sw;
 	struct clk_bulk_data clks[TSN_NUM_CLOCKS];
 	spinlock_t tx_lock;	/* Protects TX ring buffers */
 	spinlock_t rx_lock;	/* Protects RX ring buffers */
@@ -294,4 +308,6 @@ int tsn_emac_init(struct platform_device *pdev);
 void tsn_emac_exit(struct platform_device *pdev);
 int tsn_mdio_setup(struct tsn_emac *emac, struct device_node *mac_np);
 void tsn_mdio_teardown(struct tsn_emac *emac);
+int tsn_switch_init(struct platform_device *pdev);
+void tsn_switch_exit(struct platform_device *pdev);
 #endif /* XILINX_TSN_H */
diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
index 7cb07e330f57..82c73fbcd83c 100644
--- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
@@ -739,8 +739,14 @@ static int tsn_ip_probe(struct platform_device *pdev)
 	if (ret)
 		goto exit_ep;
 
+	ret = tsn_switch_init(pdev);
+	if (ret)
+		goto exit_emac;
+
 	return 0;
 
+exit_emac:
+	tsn_emac_exit(pdev);
 exit_ep:
 	tsn_ep_exit(pdev);
 exit_dma:
@@ -758,6 +764,7 @@ static void tsn_ip_remove(struct platform_device *pdev)
 {
 	struct tsn_priv *common = platform_get_drvdata(pdev);
 
+	tsn_switch_exit(pdev);
 	tsn_emac_exit(pdev);
 	/* Tear down DMA channels and endpoint */
 	if (common->ep)
diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_switch.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_switch.c
new file mode 100644
index 000000000000..89fbc5bcc16f
--- /dev/null
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_switch.c
@@ -0,0 +1,546 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "xilinx_tsn.h"
+
+#define TSN_SW_MAX_PORTS		3
+#define TSN_PORT_STATE_CTRL_OFFSET	0x0004c
+#define TSN_SW_MAC_LSB_OFFSET		0x0000c
+#define TSN_SW_MAC_MSB_OFFSET		0x00010
+
+#define TSN_SW_MAC_MSB_FF_MASK_SHIFT	16
+
+/* EP Port (Port 0) control bits */
+#define EP_PORT_STATUS_CHG_BIT		BIT(0)
+#define EP_PORT_STATUS_SHIFT		1
+#define EP_PORT_STATUS_MASK		GENMASK(3, 1)
+
+/* MAC1 Port (Port 1) control bits */
+#define MAC1_PORT_STATUS_CHG_BIT	BIT(8)
+#define MAC1_PORT_STATUS_SHIFT		9
+#define MAC1_PORT_STATUS_MASK		GENMASK(11, 9)
+
+/* MAC2 Port (Port 2) control bits */
+#define MAC2_PORT_STATUS_CHG_BIT	BIT(16)
+#define MAC2_PORT_STATUS_SHIFT		17
+#define MAC2_PORT_STATUS_MASK		GENMASK(19, 17)
+
+#define DELAY_OF_ONE_MILLISEC		1000
+#define DELAY_OF_FIVE_MILLISEC		(5 * DELAY_OF_ONE_MILLISEC)
+
+/**
+ * enum tsn_port_state - TSN switch port STP states
+ * @TSN_PORT_STATE_DISABLED: Port disabled, no traffic forwarding
+ * @TSN_PORT_STATE_BLOCKING: Port blocking frames
+ * @TSN_PORT_STATE_LISTENING: Port listening for BPDU frames
+ * @TSN_PORT_STATE_LEARNING: Port learning MAC addresses
+ * @TSN_PORT_STATE_FORWARDING: Port forwarding frames normally
+ */
+enum tsn_port_state {
+	TSN_PORT_STATE_DISABLED = 0,
+	TSN_PORT_STATE_BLOCKING,
+	TSN_PORT_STATE_LISTENING,
+	TSN_PORT_STATE_LEARNING,
+	TSN_PORT_STATE_FORWARDING,
+};
+
+/**
+ * sw_iow - Memory mapped TSN switch register write
+ * @sw: Pointer to TSN switch structure
+ * @off: Address offset from the base address of switch registers
+ * @val: Value to be written into the switch register
+ *
+ * This function writes the desired value into the corresponding TSN
+ * switch register.
+ */
+static inline void sw_iow(struct tsn_switch *sw, off_t off, u32 val)
+{
+	iowrite32(val, sw->regs + off);
+}
+
+/**
+ * sw_ior - Memory mapped TSN switch register read
+ * @sw: Pointer to TSN switch structure
+ * @off: Address offset from the base address of switch registers
+ *
+ * This function reads a value from the corresponding TSN switch
+ * register.
+ *
+ * Return: Value read from the switch register
+ */
+static inline u32 sw_ior(struct tsn_switch *sw, u32 off)
+{
+	return ioread32(sw->regs + off);
+}
+
+/**
+ * enum switch_port - TSN switch port identifiers
+ * @PORT_EP: Endpoint port (port 1)
+ * @PORT_MAC1: MAC1 port (port 2)
+ * @PORT_MAC2: MAC2 port (port 3)
+ */
+enum switch_port {
+	PORT_EP = 1,
+	PORT_MAC1 = 2,
+	PORT_MAC2 = 3,
+};
+
+/**
+ * struct port_status - Port configuration structure
+ * @port_num: Port number identifier
+ * @port_status: STP state for the port
+ */
+struct port_status {
+	u8 port_num;
+	u8 port_status;
+};
+
+/**
+ * tsn_sw_set_port_mac - Set MAC address for a specific TSN port
+ * @common: TSN common private structure
+ * @ndev: Network device to update
+ * @base_mac: Base MAC address (first 44 bits)
+ * @port_id: Port identifier (0x01 for EP, 0x02 for EMAC0, 0x03 for EMAC1)
+ * @port_name: Human-readable port name for logging
+ *
+ * Helper function to assign a MAC address to a port with the specified
+ * port ID in the lower 4 bits while preserving the upper 44 bits from
+ * the base MAC address.
+ */
+static void tsn_sw_set_port_mac(struct tsn_priv *common,
+				struct net_device *ndev,
+				const u8 *base_mac, u8 port_id,
+				const char *port_name)
+{
+	u8 new_mac[ETH_ALEN];
+
+	memcpy(new_mac, base_mac, ETH_ALEN);
+	new_mac[5] = (base_mac[5] & 0xF0) | (port_id & 0x0F);
+
+	eth_hw_addr_set(ndev, new_mac);
+	dev_info(common->dev, "%s MAC: %pM\n", port_name, ndev->dev_addr);
+}
+
+/**
+ * tsn_sw_generate_consistent_macs - Generate consistent MAC addresses for all ports
+ * @common: TSN common private structure
+ * @base_mac: Base MAC address to use (first 44 bits preserved)
+ *
+ * Generates MAC addresses for EP, EMAC0, EMAC1 based on a common prefix.
+ * The last 4 bits are set to 0x1, 0x2, 0x3 respectively to distinguish ports.
+ *
+ * Example output:
+ *   Base:  32:77:6a:ed:7a:35
+ *   EP:    32:77:6a:ed:7a:31
+ *   EMAC0: 32:77:6a:ed:7a:32
+ *   EMAC1: 32:77:6a:ed:7a:33
+ */
+static void tsn_sw_generate_consistent_macs(struct tsn_priv *common,
+					    const u8 *base_mac)
+{
+	struct net_device *emac0_ndev = (common->num_emacs >= 1 && common->emacs[0]) ?
+					 common->emacs[0]->ndev : NULL;
+	struct net_device *emac1_ndev = (common->num_emacs >= 2 && common->emacs[1]) ?
+					 common->emacs[1]->ndev : NULL;
+	struct net_device *ep_ndev = common->ep ? common->ep->ndev : NULL;
+
+	if (ep_ndev)
+		tsn_sw_set_port_mac(common, ep_ndev, base_mac, 0x01, "EP");
+
+	if (emac0_ndev)
+		tsn_sw_set_port_mac(common, emac0_ndev, base_mac, 0x02, "EMAC0");
+
+	if (emac1_ndev)
+		tsn_sw_set_port_mac(common, emac1_ndev, base_mac, 0x03, "EMAC1");
+}
+
+/**
+ * tsn_sw_is_mac_invalid - Check if MAC address is invalid or zero
+ * @addr: MAC address to validate
+ *
+ * Return: true if MAC is invalid/zero, false if valid
+ */
+static inline bool tsn_sw_is_mac_invalid(const u8 *addr)
+{
+	return !is_valid_ether_addr(addr) || is_zero_ether_addr(addr);
+}
+
+/**
+ * tsn_sw_check_mac_consistency - Validate MAC prefix consistency
+ * @common: TSN common private structure
+ * @ep_ndev: EP network device
+ * @emac0_ndev: EMAC0 network device
+ * @emac1_ndev: EMAC1 network device
+ * @mac_mask: Mask for comparing first 44 bits
+ *
+ * Checks if all active ports have matching 44-bit MAC prefixes.
+ *
+ * Return: true if mismatch found, false if all consistent
+ */
+static bool tsn_sw_check_mac_consistency(struct tsn_priv *common,
+					 struct net_device *ep_ndev,
+					 struct net_device *emac0_ndev,
+					 struct net_device *emac1_ndev,
+					 const u8 *mac_mask)
+{
+	bool mismatch = false;
+
+	/* Check EP vs EMAC0 */
+	if (ep_ndev && emac0_ndev &&
+	    !ether_addr_equal_masked(ep_ndev->dev_addr,
+				     emac0_ndev->dev_addr, mac_mask)) {
+		dev_warn(common->dev,
+			 "MAC prefix mismatch: EP (%pM) vs EMAC0 (%pM)\n",
+			 ep_ndev->dev_addr, emac0_ndev->dev_addr);
+		mismatch = true;
+	}
+
+	/* Check EP vs EMAC1 */
+	if (ep_ndev && emac1_ndev &&
+	    !ether_addr_equal_masked(ep_ndev->dev_addr,
+				     emac1_ndev->dev_addr, mac_mask)) {
+		dev_warn(common->dev,
+			 "MAC prefix mismatch: EP (%pM) vs EMAC1 (%pM)\n",
+			 ep_ndev->dev_addr, emac1_ndev->dev_addr);
+		mismatch = true;
+	}
+
+	/* Check EMAC0 vs EMAC1 */
+	if (emac0_ndev && emac1_ndev &&
+	    !ether_addr_equal_masked(emac0_ndev->dev_addr,
+				     emac1_ndev->dev_addr, mac_mask)) {
+		dev_warn(common->dev,
+			 "MAC prefix mismatch: EMAC0 (%pM) vs EMAC1 (%pM)\n",
+			 emac0_ndev->dev_addr, emac1_ndev->dev_addr);
+		mismatch = true;
+	}
+
+	return mismatch;
+}
+
+/**
+ * tsn_sw_select_base_mac - Select best available MAC as base
+ * @common: TSN common private structure
+ * @ep_ndev: EP network device
+ * @emac0_ndev: EMAC0 network device
+ * @emac1_ndev: EMAC1 network device
+ * @base_mac: Output buffer for selected base MAC
+ *
+ * Selects the best available MAC address to use as base for generating
+ * consistent MACs. Priority: EP > EMAC0 > EMAC1 > Random.
+ */
+static void tsn_sw_select_base_mac(struct tsn_priv *common,
+				   struct net_device *ep_ndev,
+				   struct net_device *emac0_ndev,
+				   struct net_device *emac1_ndev,
+				   u8 *base_mac)
+{
+	/* Try EP first */
+	if (ep_ndev && !tsn_sw_is_mac_invalid(ep_ndev->dev_addr)) {
+		ether_addr_copy(base_mac, ep_ndev->dev_addr);
+		dev_info(common->dev, "Using EP MAC as base: %pM\n", base_mac);
+		return;
+	}
+
+	/* Try EMAC0 */
+	if (emac0_ndev && !tsn_sw_is_mac_invalid(emac0_ndev->dev_addr)) {
+		ether_addr_copy(base_mac, emac0_ndev->dev_addr);
+		dev_info(common->dev, "Using EMAC0 MAC as base: %pM\n", base_mac);
+		return;
+	}
+
+	/* Try EMAC1 */
+	if (emac1_ndev && !tsn_sw_is_mac_invalid(emac1_ndev->dev_addr)) {
+		ether_addr_copy(base_mac, emac1_ndev->dev_addr);
+		dev_info(common->dev, "Using EMAC1 MAC as base: %pM\n", base_mac);
+		return;
+	}
+
+	/* Generate random locally administered MAC */
+	eth_random_addr(base_mac);
+	base_mac[0] = (base_mac[0] & 0xFE) | 0x02;  /* Set local bit, clear multicast */
+	dev_info(common->dev, "Generated random MAC base: %pM\n", base_mac);
+}
+
+/**
+ * tsn_sw_frame_filter_config - Configure frame filtering and validate MAC addresses
+ * @common: TSN common private structure
+ *
+ * This function validates that all TSN ports (EP, EMAC0, EMAC1) share the same
+ * 44-bit MAC address prefix. If any mismatch is detected, it generates a new
+ * consistent set of MAC addresses with:
+ *   - Same 44-bit prefix (OUI + 12 bits)
+ *   - Last 4 bits set to 0x1, 0x2, 0x3 for EP, EMAC0, EMAC1 respectively
+ *
+ * This ensures proper frame forwarding in the TSN switch where all ports must
+ * appear to belong to the same logical bridge.
+ *
+ * The function uses ether_addr_equal_masked() with mask FF:FF:FF:FF:FF:F0
+ * to compare only the first 44 bits of MAC addresses.
+ */
+static void tsn_sw_frame_filter_config(struct tsn_priv *common)
+{
+	struct net_device *emac0_ndev = (common->num_emacs >= 1 && common->emacs[0]) ?
+					 common->emacs[0]->ndev : NULL;
+	struct net_device *emac1_ndev = (common->num_emacs >= 2 && common->emacs[1]) ?
+					 common->emacs[1]->ndev : NULL;
+	static const u8 mac_mask[ETH_ALEN] = {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xF0};
+	struct net_device *ep_ndev = common->ep ? common->ep->ndev : NULL;
+	struct tsn_switch *sw = common->sw;
+	bool need_new_macs = false;
+	bool mac_mismatch = false;
+	u8 base_mac[ETH_ALEN];
+	u32 mac_lsb, mac_msb;
+	int active_ports;
+
+	dev_info(common->dev, "Validating TSN switch MAC address consistency\n");
+
+	/* Count active ports */
+	active_ports = !!ep_ndev + !!emac0_ndev + !!emac1_ndev;
+	if (active_ports < 2) {
+		dev_info(common->dev, "Less than 2 ports active, skipping MAC validation\n");
+		return;
+	}
+
+	/* Check for invalid/zero MAC addresses */
+	if (ep_ndev && tsn_sw_is_mac_invalid(ep_ndev->dev_addr)) {
+		dev_info(common->dev, "EP has invalid/zero MAC: %pM\n",
+			 ep_ndev->dev_addr);
+		need_new_macs = true;
+	}
+
+	if (emac0_ndev && tsn_sw_is_mac_invalid(emac0_ndev->dev_addr)) {
+		dev_info(common->dev, "EMAC0 has invalid/zero MAC: %pM\n",
+			 emac0_ndev->dev_addr);
+		need_new_macs = true;
+	}
+
+	if (emac1_ndev && tsn_sw_is_mac_invalid(emac1_ndev->dev_addr)) {
+		dev_info(common->dev, "EMAC1 has invalid/zero MAC: %pM\n",
+			 emac1_ndev->dev_addr);
+		need_new_macs = true;
+	}
+
+	/* If all MACs are valid, check consistency */
+	if (!need_new_macs)
+		mac_mismatch = tsn_sw_check_mac_consistency(common, ep_ndev,
+							    emac0_ndev, emac1_ndev,
+							    mac_mask);
+
+	/* Generate consistent MACs if needed */
+	if (need_new_macs || mac_mismatch) {
+		dev_info(common->dev, "Generating consistent MAC addresses\n");
+
+		tsn_sw_select_base_mac(common, ep_ndev, emac0_ndev,
+				       emac1_ndev, base_mac);
+
+		tsn_sw_generate_consistent_macs(common, base_mac);
+
+		dev_info(common->dev, "MAC address synchronization completed\n");
+	} else {
+		dev_info(common->dev, "All MAC addresses have consistent 44-bit prefix\n");
+	}
+
+	/* Program switch frame filter registers.
+	 * Use EMAC0 MAC address as the base for the switch filter.
+	 * Network port MAC addresses must differ in last LSB nibble only.
+	 * This is a hardware pre-requisite - we program the MAC per port basis.
+	 */
+
+	ether_addr_copy(base_mac, emac0_ndev->dev_addr);
+
+	/* Program lower 32 bits (bytes 2-5) into TSN_MAC_LSB register */
+	mac_lsb = ((u32)base_mac[2] << 24) | ((u32)base_mac[3] << 16) |
+		  ((u32)base_mac[4] << 8)  | ((u32)base_mac[5]);
+	sw_iow(sw, TSN_SW_MAC_LSB_OFFSET, mac_lsb);
+
+	/* Program upper 16 bits (bytes 0-1) and 4-bit filter mask (0xF)
+	 * into TSN_MAC_MSB register
+	 */
+	mac_msb = (0xF << TSN_SW_MAC_MSB_FF_MASK_SHIFT) |
+		  ((u32)base_mac[0] << 8) | ((u32)base_mac[1]);
+	sw_iow(sw, TSN_SW_MAC_MSB_OFFSET, mac_msb);
+
+	dev_info(common->dev, "Switch frame filter programmed with MAC: %pM (LSB=0x%08x, MSB=0x%08x)\n",
+		 base_mac, mac_lsb, mac_msb);
+}
+
+/**
+ * tsn_switch_set_state - Set hardware port state for a TSN switch
+ * @sw: Pointer to TSN switch structure
+ * @port: Pointer to port status structure containing port number and desired state
+ *
+ * This function programs the desired state of a TSN switch port by writing
+ * to the port state control register. It supports all switch ports
+ * (endpoint, MAC1, MAC2) and updates the corresponding port state bits.
+ * After writing, it waits for the hardware to acknowledge the state change.
+ *
+ * Return: 0 on success, -ETIMEDOUT if the hardware does not acknowledge
+ *         the change within the timeout period.
+ */
+static int tsn_switch_set_state(struct tsn_switch *sw,
+				struct port_status *port)
+{
+	u32 en_port_sts_chg_bit = 1;
+	u32 u_value, reg, err;
+
+	u_value = sw_ior(sw, TSN_PORT_STATE_CTRL_OFFSET);
+	switch (port->port_num) {
+	case PORT_EP:
+		if (!(u_value & EP_PORT_STATUS_CHG_BIT)) {
+			u_value &= ~EP_PORT_STATUS_MASK;
+			u_value |= FIELD_PREP(EP_PORT_STATUS_MASK, port->port_status);
+			en_port_sts_chg_bit = EP_PORT_STATUS_CHG_BIT;
+		}
+		break;
+	case PORT_MAC1:
+		if (!(u_value & MAC1_PORT_STATUS_CHG_BIT)) {
+			u_value &= ~MAC1_PORT_STATUS_MASK;
+			u_value |= FIELD_PREP(MAC1_PORT_STATUS_MASK, port->port_status);
+			en_port_sts_chg_bit = MAC1_PORT_STATUS_CHG_BIT;
+		}
+		break;
+	case PORT_MAC2:
+		if (!(u_value & MAC2_PORT_STATUS_CHG_BIT)) {
+			u_value &= ~MAC2_PORT_STATUS_MASK;
+			u_value |= FIELD_PREP(MAC2_PORT_STATUS_MASK, port->port_status);
+			en_port_sts_chg_bit = MAC2_PORT_STATUS_CHG_BIT;
+		}
+		break;
+	}
+
+	u_value |= en_port_sts_chg_bit;
+	sw_iow(sw, TSN_PORT_STATE_CTRL_OFFSET, u_value);
+
+	/* wait for write to complete */
+	err = readl_poll_timeout(sw->regs + TSN_PORT_STATE_CTRL_OFFSET, reg,
+				 (!(reg & en_port_sts_chg_bit)), 10,
+				 DELAY_OF_FIVE_MILLISEC);
+	if (err) {
+		pr_err("CAM write timed out\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+/**
+ * tsn_sw_configure_forwarding - Initialize switch forwarding behavior
+ * @sw: TSN switch instance pointer
+ *
+ * Establishes basic packet forwarding configuration across all switch
+ * ports by setting each port to the forwarding state. This enables
+ * traffic flow between endpoint and MAC interfaces through the switch
+ * fabric.
+ */
+static void tsn_sw_configure_forwarding(struct tsn_switch *sw)
+{
+	struct port_status port;
+	int ret;
+
+	pr_info("Configuring TSN switch for basic forwarding\n");
+
+	/* Configure PORT_EP to forwarding state */
+	port.port_num = PORT_EP;
+	port.port_status = TSN_PORT_STATE_FORWARDING;
+	ret = tsn_switch_set_state(sw, &port);
+	if (ret)
+		pr_err("Failed to set PORT_EP state: %d\n", ret);
+	else
+		pr_info("PORT_EP configured for forwarding\n");
+
+	/* Configure PORT_MAC1 to forwarding state */
+	port.port_num = PORT_MAC1;
+	port.port_status = TSN_PORT_STATE_FORWARDING;
+	ret = tsn_switch_set_state(sw, &port);
+	if (ret)
+		pr_err("Failed to set PORT_MAC1 state: %d\n", ret);
+	else
+		pr_info("PORT_MAC1 configured for forwarding\n");
+
+	/* Configure PORT_MAC2 to forwarding state */
+	port.port_num = PORT_MAC2;
+	port.port_status = TSN_PORT_STATE_FORWARDING;
+	ret = tsn_switch_set_state(sw, &port);
+	if (ret)
+		pr_err("Failed to set PORT_MAC2 state: %d\n", ret);
+	else
+		pr_info("PORT_MAC2 configured for forwarding\n");
+
+	pr_info("TSN switch forwarding configuration completed\n");
+}
+
+/**
+ * tsn_switch_init - Initialize TSN switching subsystem
+ * @pdev: Platform device for the TSN controller
+ *
+ * Sets up the TSN switch component by parsing device tree configuration,
+ * mapping register regions, allocating switch data structures, and
+ * configuring initial forwarding behavior for all ports.
+ *
+ * Return: 0 on successful initialization, negative error code otherwise
+ */
+int tsn_switch_init(struct platform_device *pdev)
+{
+	struct tsn_priv *common = platform_get_drvdata(pdev);
+	struct device_node *switch_node;
+	struct device *dev = &pdev->dev;
+	struct tsn_switch *sw;
+	struct resource res;
+	u32 ret;
+
+	switch_node = of_get_child_by_name(dev->of_node, "switch");
+	if (!switch_node)
+		return dev_err_probe(dev, -ENODEV, "missing switch node\n");
+
+	ret = of_address_to_resource(switch_node, 0, &res);
+	if (ret) {
+		of_node_put(switch_node);
+		return dev_err_probe(dev, ret, "failed to get switch resource\n");
+	}
+
+	sw = devm_kzalloc(&pdev->dev, sizeof(*sw), GFP_KERNEL);
+	if (!sw)
+		return -ENOMEM;
+
+	sw->dev = &pdev->dev;
+	sw->regs = common->regs + res.start;
+	common->sw = sw;
+
+	/* Configure default forwarding */
+	tsn_sw_configure_forwarding(sw);
+
+	tsn_sw_frame_filter_config(common);
+
+	return 0;
+}
+
+/**
+ * tsn_switch_exit - Cleanup TSN switching subsystem
+ * @pdev: Platform device for the TSN controller
+ *
+ * Performs shutdown sequence for the TSN switch by disabling all port
+ * forwarding states and cleaning up allocated resources. This ensures
+ * proper isolation of switch ports during driver removal.
+ */
+void tsn_switch_exit(struct platform_device *pdev)
+{
+	struct tsn_priv *common = platform_get_drvdata(pdev);
+	struct tsn_switch *sw = common->sw;
+	struct port_status port;
+
+	if (!sw)
+		return;
+
+	port.port_status = TSN_PORT_STATE_DISABLED;
+
+	port.port_num = PORT_EP;
+	tsn_switch_set_state(sw, &port);
+
+	port.port_num = PORT_MAC1;
+	tsn_switch_set_state(sw, &port);
+
+	port.port_num = PORT_MAC2;
+	tsn_switch_set_state(sw, &port);
+
+	pr_info("TSN switch exited and all ports set to disabled\n");
+}
-- 
2.25.1


