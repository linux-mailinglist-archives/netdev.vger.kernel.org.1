Return-Path: <netdev+bounces-259405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKOnI+GklmlsiQIAu9opvQ
	(envelope-from <netdev+bounces-259405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 06:51:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 072DA15C323
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 06:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD2EF3030EC6
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 05:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3AE2D0600;
	Thu, 19 Feb 2026 05:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="clD0mNSp"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011009.outbound.protection.outlook.com [52.101.52.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148B926A1AC;
	Thu, 19 Feb 2026 05:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771480201; cv=fail; b=EBYWEvwIvrnWA5YG1ybbMmJv2mLbc3TZDSGrKGUYe/BNMenNAAZkcmf6e0NvzVmGJEhKq4iee5phwJbcIIE8USUy0DkBlJv+EhFtH9SLHiSup0rcjgq/n8XmRipe+LFltnffTTT0X1FdEXgeyk0wgzFg7MeXpI5xzA9N2dRBxTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771480201; c=relaxed/simple;
	bh=0ca+DFkG9xEk4h/h01KQrzftSXyB9txj1cy88nXwnZw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QAKeCrY6zX9i1iDTJzeRZyDWOGfW1FdOOa62+IbiJcEO7sS899Q3rA9mPovucirUqw3RNnFZD9wRkgQn2cCKwvWIs9nXr5YggYtkK8/1z/1welaV1Y2NvsJpepWcbvozAukuQj+/DBq4rH0iDOTc2AeO4RVqJb4A7G0e6A8Ra2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=clD0mNSp; arc=fail smtp.client-ip=52.101.52.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ci5RuonTpyB472vDTrtAmMWa6uwoajnJrCnuvcsV7b3nzxHoIY7u7x4rc4xUp5x3+Nx/XcsgDFFoqGcb/pjKaWBvGGE3CXE3TQNZkyfIihWyMIJzal2lbvNB5MD6LN57u5qWEV0DvvskcIB3xgHAerl4N4KxGThzyomu0/U+PYVv9iZM8v39AFW0dXB5MwhK30qUu1kTWr2HOpcOboySkgSV6j9L9bX980IYBNwizd0Hc1CbU7x8Ox0gW/+alR+Iz3VKHHNy6fjX+K9P7KdzWBT+kbkdEP3tsOvB0XPz2TePevwDCjDUskFTh3+KzeW2zAoXVSssqnEolX11j4VvmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJY3k/Ef4ASP3nO3FS4f2r6DlEAH/9P0UjK3ui46QKI=;
 b=b3LFLRxsHJDbmq2RFluepmPe8YRckhfi4ZxKOCn1TjepuGOXuMIcHK1z6soWygX43VjV/Iawyf1015jpM7aRiZu0/ygNG9vALfutGGXC+YaszvGu9dCXweTWV+5HniEG76g2JM6ktaaOpW6iLG1R5rlypqA1qwoSwBsssFQ5iwxpHPWYWMZ48kli14ZIe7wYeth9nMblvKpTH0BwiIZWyWNzhVU+DFZaSl5u+92Bx8P2uQVUTvgchxHj7ZzKfVUH71ziHGwqgszTSrkilruR4Bl+0gv/pjjnbgrwuMqjkks7WwzDEPgCL5qFDzCiF2jLeTVuwNg64hg5LJJsFpqoeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJY3k/Ef4ASP3nO3FS4f2r6DlEAH/9P0UjK3ui46QKI=;
 b=clD0mNSp46rUgUD3GNng72f8MkQMRBUTAbjFyBF/DLFl0Nbr7ynnICty8vfWKKlAYfzkd2DhWCRlDNjeHk1BSRaQG/WbW96DgfZftM9dp1vsoWxzQ2kBR0MBLLL3LfzbL+xZF0+5ezvmL/Fws64G+NhWLEboHXT+OCIVLWzgfyk=
Received: from BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::13)
 by IA0PR12MB8255.namprd12.prod.outlook.com (2603:10b6:208:404::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Thu, 19 Feb
 2026 05:49:55 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::c9) by BY1P220CA0007.outlook.office365.com
 (2603:10b6:a03:59d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Thu,
 19 Feb 2026 05:49:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 05:49:55 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Feb
 2026 23:49:53 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Feb
 2026 21:49:52 -0800
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Feb 2026 23:49:48 -0600
From: Srinivas Neeli <srinivas.neeli@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <michal.simek@amd.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>, <srinivas.neeli@amd.com>
Subject: [RFC PATCH 6/8] dt-bindings: net: Add PTP interrupt support
Date: Thu, 19 Feb 2026 11:19:09 +0530
Message-ID: <20260219054911.2017362-7-srinivas.neeli@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|IA0PR12MB8255:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d2edf4b-f5b4-4e3d-c69a-08de6f7ab568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2cO4QVCsfrJaQhch2lXdF7+/EagM97OvyPD/xcr21EEIK+2/JCx9n3xa7tHE?=
 =?us-ascii?Q?sRWLCYnXbJ1B+splJE+SYieqDtsodJjkABYAXtrKG232uJm3yHT4uZtVPYOh?=
 =?us-ascii?Q?WcQLEcER5yIg66S10K021K0RYVJ+LGF1dgWriqtj6qVaPuGsIpC019iAtoiG?=
 =?us-ascii?Q?dSnzfa4W1MjtD9sGzE3a+p6tg1r+zlSQOYT+Bq1lQTO4k6XHrIvL/ELq1Ekv?=
 =?us-ascii?Q?nvzAgkQ6UONylEOOny5k9ul+nnynCQ0QHHCYIQzocy4D0N283CYKEFNXH21q?=
 =?us-ascii?Q?nEP1RyGhSycHSyGb7DpodzagNzNjSO4DzdwckGOa4XWwpgrn+BD3JFeH8oxp?=
 =?us-ascii?Q?TKYeTzsPgNrVbfoBrOpXVCHgL/24r2Gfmy0IRy6C+iNNpQ6LEhTrEEuILcNf?=
 =?us-ascii?Q?bwyStBtj1+z8q3E1RPMXV+ETAQvRihfS+gKhAS/XnDIKaJ/eMml89pRRBnRA?=
 =?us-ascii?Q?8KwPjScT6RTtd8RsnLYsuUcIdl7hRzvMDCEkdOX1dwYOlgiACPis9Yhd5YaS?=
 =?us-ascii?Q?H+hmnQ40ZkWXn4qZ+6bb1tkMZYE5PoeA3dCiqFq9tCxdVndhd9tVAemPZ+UW?=
 =?us-ascii?Q?s6CAo/geMWqveSLeBP1s4EGrqgKAvS2Jl1IGPC73hUw3GLKnkKlEvXq3DFJp?=
 =?us-ascii?Q?ZUfvj2SIXVOJJC8Im0+2qWiXyaMOPsCGMgEfm/RbR/5HnG++IG3HonEFRhEq?=
 =?us-ascii?Q?dtMt92CrpxD3kp/kPMHtrUStm3tz30PGI9kznH6ii8TvWYjkNDjdQihvP/Jt?=
 =?us-ascii?Q?H8dn/fxWJpyq3P0Z/+tcUcOOit5r3mcIJvd3pU2NDdM9oTvaot+7cRaF/xgC?=
 =?us-ascii?Q?0+Ve0nW3mJtWXMUNruqnVrkeYCndtzt1mbRYkkVuAHGiRl46suxZbCIZb4q/?=
 =?us-ascii?Q?0xsgN+FZjYjnBBvT/2vAsHhYkixRIEOJfPdBxPCcsxcNTbSz1PY4jNwHwkfr?=
 =?us-ascii?Q?G802lL6bmvipvmhr8BJi+rl8OUYgcN5pAR+N91IPXk0uvRWKdQwCueUUOoTK?=
 =?us-ascii?Q?quoIE9j+TgL5E75BaGsJvjxDSW8QKcalSHfIFlxu+5sL7zUagg1l2h/zR49r?=
 =?us-ascii?Q?cN7pw6FLKyXNwhqSp0rhV4EyBMv2lmD+HF8N+aJJmwWyKI0Y2hqIjCeVrbsC?=
 =?us-ascii?Q?TyfQ+kzkBbUSfip4URJexr7NbRcmVXXXJ9k0VzSLUA4s+ActwHvEBrJx13mA?=
 =?us-ascii?Q?rzZSbcoTGaCBXQ7omNxx8vLlCcnRzxRoq/LitjJohIZU8acJNiLHCVdQX3nV?=
 =?us-ascii?Q?YxBq3lO4X1ofgRpJkDTN97Q5iFmynTE3DVwDBrn87YmY1zK/L7lZBK/FqiGS?=
 =?us-ascii?Q?Q1CNxoWOhijb4aLu3EfSygb8zFZS5kAmjL6hVIXhWID7KBslASLNv4CP5NA2?=
 =?us-ascii?Q?BTfZREBDO1nFeXC6+lMHuxFJWGo1OAZKpS9iQfu9Bf4YMPohn3OsP6Ig+q99?=
 =?us-ascii?Q?Ln3Yn4V8p5XTk/Xi5ay5JXnwI7zZa726oOGLzZCvkSRjAc5O1P4wS1bSTH+E?=
 =?us-ascii?Q?r9Gab4lAyelnCPl+oTA2wpjkR08tE/msCuNBs5y9YvzEthS/vzWPaP3s5LgX?=
 =?us-ascii?Q?LmUgrJ2sti50ndu//iwAL8+fEwBdEJQL9r2SAiaHd9EYiZw6JEQHift+BhGY?=
 =?us-ascii?Q?DlmC2sA8jp7rDOmBmZ49rY/Cfo1RwnRR7MkXNTn7umvSNwxmU++c8fVY2vQa?=
 =?us-ascii?Q?ndYDXw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3FwqG3EKut1x8Bj/hFr5iIi3Qbh9Ndpo+gbe5+FFgymu3Yv4R5fFg4Y1ZR4A51YUhKDFuUd6TuK5yWXHsM0tvpjLWK+Q7jL2HXTWWg9UGUmLEjxcinQI5THLxq9G+1U3ZcJK9irsAtzSpR/VMo4hlOM8ZYafdxXfBrMfUwqukGACsSP/YWadBhrFNxB2pd3UVHZAAghk6PpMuEyaXd+Si1YLE5casd7uADPH/0AH8hdqv9k6d1VSDPcKQaIli1ILmQ1hu7Yad7nIF4wbRrx3ZiIyN3/I8jWeryrFe1vz0nujmxyDb6PmoRCO2PtaeFZ5GIpnyaNsHjADyYkdwMtrS6ratWrgA8L57uExTyExTm1B7ZgMsg7b2EsULTc5CsAcmUbGK7LBzIkig2+AWW2xxQiSc1sqiQr9H746PPjA4KJlrT4xvxJTTMXQy9i33ETc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 05:49:55.2169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2edf4b-f5b4-4e3d-c69a-08de6f7ab568
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8255
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259405-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,amd.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.neeli@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,amd.com:email,0.0.0.0:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DBL_PROHIBIT(0.00)[0.0.78.32:email];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 072DA15C323
X-Rspamd-Action: no action

Add device tree bindings for PTP (Precision Time Protocol) interrupt
configuration in Xilinx TSN Endpoint Ethernet MAC IP. The MAC instances
within the TSN IP have asymmetric PTP capabilities based on their
hardware configuration.

MAC 1 (xlnx,mac-id = 1) provides complete PTP hardware support including
a dedicated PTP timer, requiring four interrupt lines:
  - interrupt_ptp_rx: PTP receive packet interrupt
  - interrupt_ptp_tx: PTP transmit packet interrupt
  - mac_irq: General MAC interrupt
  - interrupt_ptp_timer: PTP hardware timer interrupt

MAC 2 (xlnx,mac-id = 2) supports PTP packet processing but lacks the
hardware timer block, requiring only three interrupt lines:
  - interrupt_ptp_rx: PTP receive packet interrupt
  - interrupt_ptp_tx: PTP transmit packet interrupt
  - mac_irq: General MAC interrupt

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
 .../net/xlnx,tsn-endpoint-ethernet-mac.yaml   | 79 ++++++++++++++++++-
 1 file changed, 77 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml b/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
index 0d61a911e1d1..b1b0f4a03d11 100644
--- a/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
+++ b/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
@@ -113,6 +113,34 @@ patternProperties:
       reg:
         maxItems: 1
 
+      xlnx,mac-id:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [1, 2]
+        description:
+          MAC instance identifier. MAC ID 1 supports PTP timer functionality,
+          while MAC ID 2 does not have PTP timer support.
+
+      interrupts:
+        minItems: 1
+        maxItems: 4
+        description:
+          Interrupt specifiers for MAC interrupts. MAC 1 (with PTP support)
+          requires 4 interrupts (ptp_rx, ptp_tx, mac_irq, ptp_timer).
+          MAC 2 (without PTP support) requires 3 interrupts (ptp_rx, ptp_tx, mac_irq).
+
+      interrupt-names:
+        minItems: 1
+        maxItems: 4
+        items:
+          enum:
+            - interrupt_ptp_rx
+            - interrupt_ptp_tx
+            - mac_irq
+            - interrupt_ptp_timer
+        description:
+          Names for the interrupts. MAC 1 includes "interrupt_ptp_timer" for
+          PTP hardware timer, which is not present in MAC 2.
+
       phy-mode:
         enum:
           - gmii
@@ -124,6 +152,44 @@ patternProperties:
 
       mdio:
         type: object
+
+    allOf:
+      - if:
+          properties:
+            xlnx,mac-id:
+              const: 1
+        then:
+          properties:
+            interrupts:
+              minItems: 4
+              maxItems: 4
+            interrupt-names:
+              items:
+                - const: interrupt_ptp_rx
+                - const: interrupt_ptp_tx
+                - const: mac_irq
+                - const: interrupt_ptp_timer
+          required:
+            - interrupts
+            - interrupt-names
+      - if:
+          properties:
+            xlnx,mac-id:
+              const: 2
+        then:
+          properties:
+            interrupts:
+              minItems: 3
+              maxItems: 3
+            interrupt-names:
+              items:
+                - const: interrupt_ptp_rx
+                - const: interrupt_ptp_tx
+                - const: mac_irq
+          required:
+            - interrupts
+            - interrupt-names
+
     additionalProperties: false
 
   "^ep-mac@":
@@ -225,9 +291,14 @@ examples:
                  xlnx,dma-channel-num = <0x0>;
             };
         };
-        // MAC 1 Node
+        // MAC 1 Node (with PTP timer support)
         mac1: ethernet-mac@0 {
             reg = <0x0 0x14000>;
+            xlnx,mac-id = <1>;
+            interrupt-parent = <&intc>;
+            interrupt-names = "interrupt_ptp_rx", "interrupt_ptp_tx",
+                              "mac_irq", "interrupt_ptp_timer";
+            interrupts = <0 2>, <2 2>, <4 2>, <6 2>;
             phy-mode = "rgmii-id";
             phy-handle = <&phy0>;
             mdio {
@@ -240,9 +311,13 @@ examples:
             };
         };
 
-        // MAC 2 Node
+        // MAC 2 Node (without PTP timer support)
         mac2: ethernet-mac@20000 {
             reg = <0x20000 0x14000>;
+            xlnx,mac-id = <2>;
+            interrupt-parent = <&intc>;
+            interrupt-names = "interrupt_ptp_rx", "interrupt_ptp_tx", "mac_irq";
+            interrupts = <1 2>, <3 2>, <5 2>;
             phy-mode = "rgmii-id";
             phy-handle = <&phy1>;
             mdio {
-- 
2.25.1


