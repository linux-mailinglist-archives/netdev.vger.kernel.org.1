Return-Path: <netdev+bounces-259403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NDRLPiklmlsiQIAu9opvQ
	(envelope-from <netdev+bounces-259403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 06:51:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB9515C33F
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 06:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63885302F3AB
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 05:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0032D0600;
	Thu, 19 Feb 2026 05:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rudZqSEH"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011029.outbound.protection.outlook.com [52.101.52.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB0714B950;
	Thu, 19 Feb 2026 05:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771480193; cv=fail; b=TK/M1vdPIDKIEEch+Ad7BkVyI9RXkJx5t9jw+UviQR5aMLoeTs92ytWZ3BKUQWaB+pm5v7ZRwj+UJs0tj3CqjUWvU3iyzTj2rQ375ooFsNvNF5wVpGA24zTAQE93Ws73PHM7AnpsPO26sQ4RPXDKDYYz+QrjNyyT5+t8Mgh5110=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771480193; c=relaxed/simple;
	bh=9woZQoPADxfDspHqHnhwc0PwfXZLUDaw9jJT0huvjFY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KCGgM8v5oZpbdibzp2zNKh8CPvVWvQzXunTTb+5yf5Gkw6CbnaEIS5l/FMAtcWGJRwHyeeI0z81be24uqE8+AE7AZeXAvKh5lMEFZbauFup2pt7VQp7y8dk5yaMleo1RiG3nTAOCsgqJObVhIuwNEvUEGGlVwNxyVnK7OmWxU/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rudZqSEH; arc=fail smtp.client-ip=52.101.52.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfNzoBOpEWiuvju8kTk2oezSMqiktyI+1gwtXsr4P1knOoXiBgqZ4m28h9b2TbQQ2pW3mAHRJAe5WkU70jCItTuS7yLSNJFSKOT2iRUny4/u2oeAtXXPi9XB5a4d0M6ynn6w4jCwc8d7xNCx1qIk6YvhnCtfKniyTzyncmwMVmkuVWXzEESYXQwl3pH02hR/YEJlrvrcbuS/leYpUZekU9S32sI4HVMYlYRA02n08/notXgDWZDJWVP1w2Pj7KCCAwkpKY0HobvDSzL3WPgBioFjliRQnhPEPr9QaM4Y/NpEJZp3W2pq4Fzr1/nggELVNl5f2fP+/FMigEHuMSNixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpDQv927ihy3gqWGHBSpfxIxsGp7kmBlUJE/ecICtqU=;
 b=Bn6O7PNVI1riF9Vp7whcecbXzq6oqpkos3fF/uwTtHrTaY9gUC/xYYfz/l7moq5HVQlWpkl+PUi4k1db9lDiG9nEkW5fjuG/vzBMdNo0AbSxHdICEDFv4mLsO8mUlUCpOGahcf0eHLmhRQwfgY4nBek4UT0WKnd/5I7OReUF7Zav7E7dYT6aw59drbjXXDWEoJTlpEvMy882L+GXHDVPECXWELhOx31JVRaY/UhUvjdy7CQu4v1orq9y/YUuFCw/AH/Rw9l+q/twrcDkOCpCk9c9Q0HaU+5tfuWL1Wfh9rryAVQTwgq1bBahtEELxBpLHhAa1fs71G/x8v3S3e4wWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpDQv927ihy3gqWGHBSpfxIxsGp7kmBlUJE/ecICtqU=;
 b=rudZqSEHXHXCybOvlkXsRH+/jLcIfNOZcpsGjtB8tNvTE4wuobJiJ2miuTHAnISx0DdNlVMTiHEWP8xGfg9T3snptK9Bi6W5xr2pnPCnMjgRMdaIfNO+LPkMzK7LA0+ksG+L7F/aU6lMdbNdHf1IlfMaE+ok2lQto7UEYmLARJk=
Received: from SJ0PR03CA0292.namprd03.prod.outlook.com (2603:10b6:a03:39e::27)
 by DM4PR12MB6232.namprd12.prod.outlook.com (2603:10b6:8:a5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.14; Thu, 19 Feb 2026 05:49:43 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::cc) by SJ0PR03CA0292.outlook.office365.com
 (2603:10b6:a03:39e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 05:49:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 05:49:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 18 Feb
 2026 23:49:40 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Feb
 2026 23:49:39 -0600
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Feb 2026 23:49:35 -0600
From: Srinivas Neeli <srinivas.neeli@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <michal.simek@amd.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<richardcochran@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>, <srinivas.neeli@amd.com>
Subject: [RFC PATCH 3/8] net: xilinx: tsn: Add TSN endpoint and MCDMA support
Date: Thu, 19 Feb 2026 11:19:06 +0530
Message-ID: <20260219054911.2017362-4-srinivas.neeli@amd.com>
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
Received-SPF: None (SATLEXMB04.amd.com: srinivas.neeli@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|DM4PR12MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: 584c4445-34f8-4351-c735-08de6f7aad20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cs5LfQz+TPG5bHJPC4Q8QpZYpoY8bnKhG+/IUhCAkiXD4V+k6nDFpJdgNGG1?=
 =?us-ascii?Q?URBNVC7Mpw/Y9p3mRDmYp25A2/UYe0pkx+t4JqVA0ZFg1FmNOQB1W9NMIvIC?=
 =?us-ascii?Q?QcRLhzbQs+jTETi3wVvY1DniU/oTHBiMskTxEoffrTbGJNVVsrFSi1McI0Wv?=
 =?us-ascii?Q?DF2sV4dNhnn6iaVds6d080HSOOHJDoCORB4BA+JO3Ec6a9WF9wu6g11L6qb0?=
 =?us-ascii?Q?b+EUg2aIkvtJOnsM9fpDB+l7Ay3tAOtvXgx934kP1zAjCKMF1Xe9mSzNYZfF?=
 =?us-ascii?Q?VrGVF0tQayL57hm5RVwbsJWobKa/PmMzIy4TAK4j3+QlkezZRNGAX/5Anvro?=
 =?us-ascii?Q?t/IyuFAJKTH2enWOU+Gb/NFaTY/isHIWxk0ZAyr56oYurUW2BmljCkl4FUWR?=
 =?us-ascii?Q?ck+cwY47vnq0isZgw2+quVTgsREvbmPOxY8IQTtj8g14e3Y3BS2opu35NzIE?=
 =?us-ascii?Q?t8Jxntizqrw1jU79Q8WnrIcQliG+gof7cmf8p+4ciyUJtv6eJBQbpYbTgNT5?=
 =?us-ascii?Q?W/milkyimSYEhRv3igpZ6cyGkHleN6QlGM9qJvgwyQoDEgKlxo6CSLbrTC17?=
 =?us-ascii?Q?ertAQz1DpkauXglOW9iUI6fKmNjtYmw114AA0gxU0NP5WBUWKu+hOcprAsLN?=
 =?us-ascii?Q?dD0D5SsTJ913sARMkKfIi4tN3SJvWfUy0SYXlj9tCEK4aGWR2YfW50OCSM/C?=
 =?us-ascii?Q?3CaMxHeX+6XP8cpp8x5LG9GwwFRoDtuSw0FS2XrI/y2IRA3M31qaEZplxZd+?=
 =?us-ascii?Q?9ILjhLUI3Pkfwk9ppIDs2a7cMGDlH9iz0gP/fWHLXClSGCLAiPABDZAercZX?=
 =?us-ascii?Q?itdyX7jk8erK0U/GhpwNQKXpWMDLn+cSVsElh8jmuj/hvRIetUEQI2PSly7y?=
 =?us-ascii?Q?Kh7J60LexwlN6HjKs8RYUI7pgUM2Ncjc5ViuGTvkeO/fXAG9LUECaR41iu6X?=
 =?us-ascii?Q?ZHhpK06bHG3aOq8Rt3/fncfVmGt5rUjJ7UyDmc31jvQxLOaokL8/MvUpIeYt?=
 =?us-ascii?Q?zt7i9Gc+yv1jfXbH3YSF5Ze1upWl171TbSxRxulgCtjwnwsv2APP+dmLRvBx?=
 =?us-ascii?Q?ch74dx/l5ZxvaL73751M7axAF7bMFOunfULE/Bt84luAXjq+DSBLu2NbxOMI?=
 =?us-ascii?Q?IBfJY5eaMGeiEhErY8ySj1VJPngdoy+kbI5laiejuzABiMCHZFZnctYK8QdI?=
 =?us-ascii?Q?Gdp+vmH9Lcv28ZFBWWjI6f4NsXuYRKcMsRsum90fBsn4Ci/xEFpG6ad/CIie?=
 =?us-ascii?Q?uvnk/XHNisSH44+Riu725NccB2BSGmUQvvzJlYUY0DMkiFbjW9qb4pJrT0Sy?=
 =?us-ascii?Q?nX+hbgmp7aTUSj8+UXiez2gY13k8jxu+kFz5bikHPJ1RyShau1UrUsnFa4Bh?=
 =?us-ascii?Q?83PjF5I6TKzxOzZoCFn7Hdi0KOZmUqKclaQ/69AzrgDu+E3I74I6lW3h+lUo?=
 =?us-ascii?Q?yNJiE3SFL6dFvR3PAovw2XVQjDUhiVad4F+eYnhsMaTU+oUxIwy815wzv6C2?=
 =?us-ascii?Q?n0xDjuLb9uhLxiRmlh11T8iM+IP+YjGE5kdT4r8EtzAD74Bly/8DyGPHNNNd?=
 =?us-ascii?Q?Cz1aNzLHamKbQrE0iqUdRPcHFH89K+lFzKxXVrl4oMeU16N2+f5ziaN9j6/l?=
 =?us-ascii?Q?kYS6Dya61ZLXqKcGzwoVhWLOyv3/PgCLAeb1klFGpuAA92dp4q65WKq3I6gp?=
 =?us-ascii?Q?pW9gC7KvLhgU3cnonK2Ev/EFEfQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Z93bXXJqfhKoSAiGm1a7QVQryiYq3ayBz9i2L8bGREtcJViDAQNCw7KZlhDPUzK3Hr/QS912uP+6SlWU+B/3EkeIOHIMm5hA5FddaTrLZ+lI1dY2k8et7GnqkNfOLVmmnEnt12JR9HRlE2Xd1jx2soytiN08A0W/T8aT9SfAuPVXIQQtBkiP7S6O+rNjuK87Gcwe8Trjd6zeKHFruL2UrHrJzF9DaDZSI9kx2lRGpCrmrKzDzvePsHg0AgjOhcG6+uTGEvV7aQcnVdoDhzTa1DNFv7nhYUe0rkmJkL64vZP+xhpKOdeciDXanGLVLwEPS3wTiXt//Jve7FBklmbqyQcgs957plvf6pq7iA0dwQIWPX0fWNOnSYlpF1cXdPAnR8L1m+y9ys2AygA586/vlSfmVbuduFmEIEbI7bH3N0Z+if2EkDdV1Oye4z/l0c3P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 05:49:41.3740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 584c4445-34f8-4351-c735-08de6f7aad20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6232
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,amd.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259403-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.neeli@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 0EB9515C33F
X-Rspamd-Action: no action

Add initial support for the TSN endpoint (EP) network interface, including
basic DMA datapath integration and net_device registration.

Introduces a new driver component that registers an "ep" net_device with
support for multiple TX/RX queues and ethtool statistics. It sets up DMA
rings, manages TX/RX submission and completion callbacks, and provides
helper APIs for accessing endpoint registers.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
 drivers/net/ethernet/xilinx/tsn/Makefile      |   2 +-
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h  | 113 ++++
 .../net/ethernet/xilinx/tsn/xilinx_tsn_ep.c   | 211 +++++++
 .../net/ethernet/xilinx/tsn/xilinx_tsn_main.c | 558 ++++++++++++++++++
 4 files changed, 883 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c

diff --git a/drivers/net/ethernet/xilinx/tsn/Makefile b/drivers/net/ethernet/xilinx/tsn/Makefile
index 420497f2d402..099526877948 100644
--- a/drivers/net/ethernet/xilinx/tsn/Makefile
+++ b/drivers/net/ethernet/xilinx/tsn/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_XILINX_TSN) :=xilinx_tsn.o
-xilinx_tsn-objs := xilinx_tsn_main.o
+xilinx_tsn-objs := xilinx_tsn_main.o xilinx_tsn_ep.o
diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h
index fe613f73044f..054f74b97a38 100644
--- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h
@@ -8,15 +8,29 @@
 #ifndef XILINX_TSN_H
 #define XILINX_TSN_H
 
+#include <linux/bitfield.h>
+#include <linux/circ_buf.h>
 #include <linux/clk.h>
+#include <linux/dma/xilinx_dma.h>
+#include <linux/dmaengine.h>
+#include <linux/etherdevice.h>
+#include <linux/ethtool.h>
+#include <linux/if_ether.h>
+#include <linux/if_vlan.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_dma.h>
+#include <linux/of_net.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
+#include <linux/u64_stats_sync.h>
+#include <net/netdev_queues.h>
 
 #define TSN_NUM_CLOCKS		6
 
@@ -25,6 +39,65 @@
 #define TSN_MAX_TX_QUEUE	8
 #define TSN_MIN_PRIORITIES	2
 #define TSN_MAX_PRIORITIES	8
+/* Descriptors defines for Tx and Rx DMA */
+#define TX_BD_NUM_DEFAULT	64
+#define RX_BD_NUM_DEFAULT	128
+
+#define TSN_MAX_FRAME_SIZE        (ETH_DATA_LEN + ETH_HLEN + ETH_FCS_LEN)
+#define TSN_MAX_VLAN_FRAME_SIZE   (ETH_DATA_LEN + VLAN_ETH_HLEN + ETH_FCS_LEN)
+
+/* TUSER Input Port ID field definitions (bits [5:4]) */
+#define TSN_TUSER_PORT_ID_MASK		GENMASK(5, 4)
+#define TSN_TUSER_PORT_EP		0x0  /* Endpoint Port */
+#define TSN_TUSER_PORT_MAC1		0x1  /* MAC-1 Port */
+#define TSN_TUSER_PORT_MAC2		0x2  /* MAC-2 Port */
+
+/*
+ * struct skbuf_dma_descriptor - skb for each dma descriptor
+ * @sgl: Pointer for sglist.
+ * @desc: Pointer to dma descriptor.
+ * @dma_address: dma address of sglist.
+ * @skb: Pointer to SKB transferred using DMA
+ * @sg_len: number of entries in the sglist.
+ */
+struct skbuf_dma_descriptor {
+	struct scatterlist sgl[MAX_SKB_FRAGS + 1];
+	struct dma_async_tx_descriptor *desc;
+	dma_addr_t dma_address;
+	struct sk_buff *skb;
+	int sg_len;
+};
+
+/**
+ * struct tsn_dma_chan - TSN DMA channel management structure
+ * @skb_ring: Ring buffer of SKB DMA descriptors
+ * @common: Pointer to common TSN private data
+ * @chan: DMA engine channel handle
+ * @ring_head: Head index of the ring buffer
+ * @ring_tail: Tail index of the ring buffer
+ * @is_tx: Flag indicating if this is a TX channel (true) or RX (false)
+ */
+struct tsn_dma_chan {
+	struct skbuf_dma_descriptor **skb_ring;
+	struct tsn_priv *common;
+	struct dma_chan *chan;
+	int ring_head;
+	int ring_tail;
+	bool is_tx;
+};
+
+/*
+ * struct tsn_endpoint - TSN endpoint configuration structure
+ * @ndev: Network device associated with the TSN endpoint
+ * @regs: Virtual address mapping of endpoint register space
+ * @common: Pointer to the main TSN private data structure
+ */
+struct tsn_endpoint {
+	struct net_device *ndev;
+	void __iomem *regs;
+	struct tsn_priv *common;
+};
+
 /**
  * struct tsn_priv - Main TSN private data structure
  * @pdev: Platform device handle
@@ -32,6 +105,7 @@
  * @res: Platform resource information
  * @regs_start: Start address (physical) of mapped region
  * @regs: ioremap()'d base pointer
+ * @ep: Pointer to TSN endpoint structure
  * @clks: Bulk clock data for all required clocks
  * @tx_lock: Spinlock protecting TX rings and related TX state
  * @rx_lock: Spinlock protecting RX rings and related RX state
@@ -40,6 +114,9 @@
  * @num_tx_queues: Number of TX DMA queues
  * @num_rx_queues: Number of RX DMA queues
  * @tx_dma_chan_map: Logical TX queue index to DMA channel number mapping.
+ * @max_frm_size: Maximum frame size supported
+ * @tx_chans: Array of TX DMA channels
+ * @rx_chans: Array of RX DMA channels
  */
 struct tsn_priv {
 	struct platform_device *pdev;
@@ -47,6 +124,7 @@ struct tsn_priv {
 	struct resource *res;
 	resource_size_t regs_start;
 	void __iomem *regs;
+	struct tsn_endpoint *ep;
 	struct clk_bulk_data clks[TSN_NUM_CLOCKS];
 	spinlock_t tx_lock;	/* Protects TX ring buffers */
 	spinlock_t rx_lock;	/* Protects RX ring buffers */
@@ -55,6 +133,41 @@ struct tsn_priv {
 	u32 num_tx_queues;
 	u32 num_rx_queues;
 	u32 tx_dma_chan_map[TSN_MAX_TX_QUEUE];
+	u32 max_frm_size;
+	struct tsn_dma_chan **tx_chans;
+	struct tsn_dma_chan **rx_chans;
 };
 
+/**
+ * tsn_ndo_set_mac_address - ndo_set_mac_address handler for TSN devices
+ * @ndev: Pointer to the net_device structure
+ * @p: Pointer to sockaddr structure containing MAC address
+ *
+ * This is the common implementation for net_device_ops.ndo_set_mac_address
+ * callback used by both EP and EMAC interfaces.
+ *
+ * Validates the provided MAC address and sets it only if valid.
+ *
+ * Return: 0 on success, -EADDRNOTAVAIL if address is invalid
+ */
+static inline int tsn_ndo_set_mac_address(struct net_device *ndev, void *p)
+{
+	struct sockaddr *addr = p;
+
+	/* Validate address before setting */
+	if (!addr || !is_valid_ether_addr(addr->sa_data)) {
+		netdev_err(ndev, "Invalid MAC address provided\n");
+		return -EADDRNOTAVAIL;
+	}
+
+	eth_hw_addr_set(ndev, addr->sa_data);
+
+	return 0;
+}
+
+netdev_tx_t tsn_start_xmit_dmaengine(struct tsn_priv *common,
+				     struct sk_buff *skb,
+				     struct net_device *ndev);
+int tsn_ep_init(struct platform_device *pdev);
+void tsn_ep_exit(struct platform_device *pdev);
 #endif /* XILINX_TSN_H */
diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
new file mode 100644
index 000000000000..33a388a67d3b
--- /dev/null
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "xilinx_tsn.h"
+
+#define DRIVER_NAME             "xilinx_tsn_ep"
+#define DRIVER_DESCRIPTION      "Xilinx TSN driver"
+#define DRIVER_VERSION          "1.0"
+
+/**
+ * ep_iow - Memory mapped TSN endpoint register write
+ * @ep: Pointer to TSN endpoint structure
+ * @off: Address offset from the base address of endpoint registers
+ * @val: Value to be written into the endpoint register
+ *
+ * This function writes the desired value into the corresponding TSN
+ * endpoint register.
+ */
+static inline void ep_iow(struct tsn_endpoint *ep, off_t off, u32 val)
+{
+	iowrite32(val, ep->regs + off);
+}
+
+/**
+ * ep_ior - Memory mapped TSN endpoint register read
+ * @ep: Pointer to TSN endpoint structure
+ * @off: Address offset from the base address of endpoint registers
+ *
+ * This function reads a value from the corresponding TSN endpoint
+ * register.
+ *
+ * Return: Value read from the endpoint register
+ */
+static inline u32 ep_ior(struct tsn_endpoint *ep, u32 off)
+{
+	return ioread32(ep->regs + off);
+}
+
+/**
+ * tsn_ep_get_drvinfo - Get driver information for ethtool
+ * @ndev: Pointer to the net_device structure
+ * @ed: Pointer to ethtool_drvinfo structure
+ *
+ * This function populates driver name and version information
+ * for ethtool driver information display.
+ */
+static void tsn_ep_get_drvinfo(struct net_device *ndev,
+			       struct ethtool_drvinfo *ed)
+{
+	strscpy(ed->driver, DRIVER_NAME, sizeof(ed->driver));
+	strscpy(ed->version, DRIVER_VERSION, sizeof(ed->version));
+}
+
+/**
+ * tsn_ep_start_xmit_dmaengine - Transmit packet using DMA engine
+ * @skb: Socket buffer containing packet data
+ * @ndev: Pointer to the net_device structure
+ *
+ * Return: NETDEV_TX_OK on success, NETDEV_TX_BUSY if ring is full
+ *
+ * This function handles packet transmission using DMA engine. It maps
+ * SKB to scatterlist, prepares DMA descriptor, and submits for transmission.
+ */
+static netdev_tx_t tsn_ep_start_xmit(struct sk_buff *skb,
+				     struct net_device *ndev)
+{
+	struct tsn_endpoint *ep = netdev_priv(ndev);
+
+	return tsn_start_xmit_dmaengine(ep->common, skb, ndev);
+}
+
+/**
+ * tsn_ep_open - Open TSN endpoint network interface
+ * @ndev: Pointer to the net_device structure
+ *
+ * Return: 0 on success, negative error code on failure
+ *
+ * This function opens the network interface by initializing DMA engine,
+ * setting maximum frame size, and starting all transmit queues.
+ */
+static int tsn_ep_open(struct net_device *ndev)
+{
+	netif_tx_start_all_queues(ndev);
+
+	return 0;
+}
+
+/**
+ * tsn_ep_stop - Stop TSN endpoint network interface
+ * @ndev: Pointer to the net_device structure
+ *
+ * Return: 0 on success
+ *
+ * This function stops the network interface by stopping all transmit
+ * queues and cleaning up DMA engine resources.
+ */
+static int tsn_ep_stop(struct net_device *ndev)
+{
+	netif_tx_stop_all_queues(ndev);
+	netdev_info(ndev, "TSN endpoint stopped\n");
+
+	return 0;
+}
+
+static const struct net_device_ops ep_netdev_ops = {
+	.ndo_open		= tsn_ep_open,
+	.ndo_stop		= tsn_ep_stop,
+	.ndo_start_xmit		= tsn_ep_start_xmit,
+	.ndo_set_mac_address	= tsn_ndo_set_mac_address,
+};
+
+static const struct ethtool_ops ep_ethtool_ops = {
+	.get_drvinfo	= tsn_ep_get_drvinfo,
+};
+
+/**
+ * tsn_ep_init - Initialize TSN endpoint subsystem
+ * @pdev: Platform device pointer
+ *
+ * Return: 0 on success, negative error code on failure
+ *
+ * This function initializes TSN endpoint by parsing device tree,
+ * allocating network device, configuring DMA channels, setting MAC
+ * address, and registering network interface.
+ */
+int tsn_ep_init(struct platform_device *pdev)
+{
+	struct tsn_priv *common = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	struct device_node *ep_node;
+	struct tsn_endpoint *ep;
+	struct net_device *ndev;
+	u8 mac_addr[ETH_ALEN];
+	struct resource res;
+	int ret;
+
+	ep_node = of_get_child_by_name(dev->of_node, "ep-mac");
+	if (!ep_node)
+		return dev_err_probe(dev, -ENODEV, "missing ep-mac node\n");
+
+	ret = of_address_to_resource(ep_node, 0, &res);
+	if (ret) {
+		of_node_put(ep_node);
+		return dev_err_probe(dev, ret, "failed to get ep resource\n");
+	}
+
+	ndev = alloc_netdev_mqs(sizeof(struct tsn_endpoint), "ep", NET_NAME_UNKNOWN,
+				ether_setup, common->num_tx_queues,
+				common->num_rx_queues);
+	if (!ndev) {
+		of_node_put(ep_node);
+		return dev_err_probe(dev, -ENOMEM, "failed to alloc net_device\n");
+	}
+
+	ndev->netdev_ops = &ep_netdev_ops;
+	ndev->ethtool_ops = &ep_ethtool_ops;
+	ndev->features = NETIF_F_SG;
+	ndev->min_mtu = ETH_ZLEN - ETH_HLEN;
+	ndev->max_mtu = ETH_DATA_LEN;
+	ep = netdev_priv(ndev);
+	memset(ep, 0, sizeof(*ep));
+	ep->ndev = ndev;
+	ep->regs = common->regs + res.start;
+	ep->common = common;
+	common->ep = ep;
+	SET_NETDEV_DEV(ndev, common->dev);
+
+	/* Retrieve the MAC address */
+	ret = of_get_mac_address(ep_node, mac_addr);
+	if (ret == 0 && is_valid_ether_addr(mac_addr))
+		eth_hw_addr_set(ndev, mac_addr);
+
+	of_node_put(ep_node);
+
+	ret = register_netdev(ndev);
+	if (ret) {
+		dev_err(common->dev, "Failed to register net device\n");
+		free_netdev(ndev);
+		common->ep = NULL;
+		return ret;
+	}
+
+	dev_info(common->dev, "TSN endpoint registered with %d TX queues and %d RX queues\n",
+		 common->num_tx_queues, common->num_rx_queues);
+
+	return 0;
+}
+
+/**
+ * tsn_ep_exit - Clean up TSN endpoint subsystem
+ * @pdev: Platform device pointer
+ *
+ * This function unregisters network device, frees network device
+ * memory, and cleans up TSN endpoint resources during driver removal.
+ */
+void tsn_ep_exit(struct platform_device *pdev)
+{
+	struct tsn_priv *common = platform_get_drvdata(pdev);
+	struct tsn_endpoint *ep;
+
+	if (!common || !common->ep)
+		return;
+
+	ep = common->ep;
+	if (ep->ndev) {
+		unregister_netdev(ep->ndev);
+		free_netdev(ep->ndev);
+		ep->ndev = NULL;
+	}
+	common->ep = NULL;
+}
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
index 2a7f5fbc5510..9e674f99d83f 100644
--- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
@@ -17,6 +17,317 @@ static const char * const tsn_clk_names[TSN_NUM_CLOCKS] = {
 	"s_axi",
 };
 
+static void tsn_dma_rx_cb(void *data, const struct dmaengine_result *result);
+
+/* Ring accessor helpers */
+static inline struct skbuf_dma_descriptor *tsn_get_rx_desc(struct tsn_dma_chan *xchan, int idx)
+{
+	return xchan->skb_ring[idx];
+}
+
+static inline struct skbuf_dma_descriptor *tsn_get_tx_desc(struct tsn_dma_chan *xchan, int idx)
+{
+	return xchan->skb_ring[idx];
+}
+
+static void tsn_rx_submit_desc(struct tsn_dma_chan *xchan)
+{
+	struct dma_async_tx_descriptor *dma_rx_desc = NULL;
+	struct tsn_priv *common = xchan->common;
+	struct skbuf_dma_descriptor *skbuf_dma;
+	struct sk_buff *skb;
+	dma_addr_t addr;
+
+	scoped_guard(spinlock_irq, &common->rx_lock) {
+		skbuf_dma = tsn_get_rx_desc(xchan, xchan->ring_head);
+		if (!skbuf_dma)
+			return;
+
+		xchan->ring_head = (xchan->ring_head + 1) & (RX_BD_NUM_DEFAULT - 1);
+	}
+
+	skb = dev_alloc_skb(common->max_frm_size);
+	if (!skb)
+		goto rx_submit_err_revert_head;
+
+	sg_init_table(skbuf_dma->sgl, 1);
+	addr = dma_map_single(common->dev, skb->data, common->max_frm_size,
+			      DMA_FROM_DEVICE);
+	if (unlikely(dma_mapping_error(common->dev, addr))) {
+		if (net_ratelimit())
+			dev_warn(common->dev, "DMA mapping error on RX submit\n");
+		goto rx_submit_err_free_skb;
+	}
+	sg_dma_address(skbuf_dma->sgl) = addr;
+	sg_dma_len(skbuf_dma->sgl) = common->max_frm_size;
+	dma_rx_desc = dmaengine_prep_slave_sg(xchan->chan, skbuf_dma->sgl,
+					      1, DMA_DEV_TO_MEM,
+					      DMA_PREP_INTERRUPT);
+	if (!dma_rx_desc)
+		goto rx_submit_err_unmap_skb;
+	skbuf_dma->skb = skb;
+	skbuf_dma->dma_address = sg_dma_address(skbuf_dma->sgl);
+	skbuf_dma->desc = dma_rx_desc;
+	dma_rx_desc->callback_param = xchan;
+	dma_rx_desc->callback_result = tsn_dma_rx_cb;
+	/* Ensure descriptor is fully written before submission */
+	wmb();
+	dmaengine_submit(dma_rx_desc);
+
+	return;
+
+rx_submit_err_unmap_skb:
+	dma_unmap_single(common->dev, addr, common->max_frm_size, DMA_FROM_DEVICE);
+rx_submit_err_free_skb:
+	dev_kfree_skb(skb);
+rx_submit_err_revert_head:
+	scoped_guard(spinlock_irq, &common->rx_lock) {
+		xchan->ring_head = (xchan->ring_head - 1) & (RX_BD_NUM_DEFAULT - 1);
+	}
+}
+
+/**
+ * tsn_classify_rx_packet - Classify received packet by TUSER metadata
+ * @common: TSN common structure
+ * @tuser: TUSER metadata word from DMA descriptor
+ *
+ * Extract Input Port ID from TUSER bits[5:4] and return corresponding netdev.
+ * Currently only EP is supported; MAC ports will return NULL until implemented.
+ *
+ * Return: net_device pointer on success, NULL if port not available
+ */
+static inline struct net_device *tsn_classify_rx_packet(struct tsn_priv *common, u32 tuser)
+{
+	u32 port_id;
+
+	/* Extract Input Port ID from TUSER bits[5:4] */
+	port_id = FIELD_GET(TSN_TUSER_PORT_ID_MASK, tuser);
+	switch (port_id) {
+	case TSN_TUSER_PORT_EP:
+		if (unlikely(!common->ep)) {
+			dev_err_once(common->dev, "EP not initialized - dropping packets\n");
+			return NULL;
+		}
+		return common->ep->ndev;
+
+	case TSN_TUSER_PORT_MAC1:
+	case TSN_TUSER_PORT_MAC2:
+		/* MAC ports not yet implemented */
+		if (net_ratelimit())
+			dev_warn(common->dev, "RX from MAC port %u not yet supported\n", port_id);
+		return NULL;
+
+	default:
+		/* Invalid port ID */
+		if (net_ratelimit())
+			dev_warn(common->dev, "Invalid TUSER port ID: %u\n", port_id);
+		return NULL;
+	}
+}
+
+/**
+ * tsn_dma_rx_cb - DMA engine callback for RX channel completion
+ * @data: Pointer to the skbuf_dma_descriptor structure
+ * @result: Error reporting through dmaengine_result
+ *
+ * This function is called by dmaengine driver for RX channel to notify
+ * that a packet is received. It processes the received packet, updates
+ * statistics, and submits a new RX descriptor.
+ */
+static void tsn_dma_rx_cb(void *data, const struct dmaengine_result *result)
+{
+	struct skbuf_dma_descriptor *skbuf_dma;
+	size_t meta_len, meta_max_len, rx_len;
+	struct tsn_dma_chan *xchan = data;
+	struct tsn_priv *common = xchan->common;
+	struct net_device *ndev;
+	struct sk_buff *skb;
+	u32 *metadata;
+	u32 tuser;
+
+	scoped_guard(spinlock_irq, &common->rx_lock) {
+		skbuf_dma = tsn_get_rx_desc(xchan, xchan->ring_tail);
+		xchan->ring_tail = (xchan->ring_tail + 1) & (RX_BD_NUM_DEFAULT - 1);
+		skb = skbuf_dma->skb;
+	}
+
+	dma_unmap_single(common->dev, skbuf_dma->dma_address,
+			 common->max_frm_size, DMA_FROM_DEVICE);
+	metadata = dmaengine_desc_get_metadata_ptr(skbuf_dma->desc,
+						   &meta_len,
+						   &meta_max_len);
+	if (IS_ERR_OR_NULL(metadata)) {
+		if (net_ratelimit())
+			dev_warn(common->dev, "Failed to get RX metadata pointer\n");
+		dev_kfree_skb_any(skb);
+		goto submit_new;
+	}
+
+	rx_len = metadata[0];
+	tuser = metadata[1];
+
+	if (rx_len > common->max_frm_size || rx_len < ETH_HLEN) {
+		if (net_ratelimit())
+			dev_warn(common->dev, "Invalid RX length %zu (max=%u, min=%u)\n",
+				 rx_len, common->max_frm_size, ETH_HLEN);
+		dev_kfree_skb_any(skb);
+		goto submit_new;
+	}
+
+	ndev = tsn_classify_rx_packet(common, tuser);
+	if (unlikely(!ndev)) {
+		if (net_ratelimit())
+			dev_warn(common->dev, "RX packet from unknown port");
+		ndev->stats.rx_dropped++;
+		dev_kfree_skb_any(skb);
+		goto submit_new;
+	}
+	skb_put(skb, rx_len);
+	skb->dev = ndev;
+	skb->protocol = eth_type_trans(skb, ndev);
+	skb->ip_summed = CHECKSUM_NONE;
+	__netif_rx(skb);
+
+	ndev->stats.rx_packets++;
+	ndev->stats.rx_bytes += rx_len;
+
+submit_new:
+	tsn_rx_submit_desc(xchan);
+	dma_async_issue_pending(xchan->chan);
+}
+
+/**
+ * tsn_dma_tx_cb - DMA engine callback for TX channel completion
+ * @data: Pointer to the tsn_dma_chan structure
+ * @result: Error reporting through dmaengine_result
+ *
+ * This function is called by dmaengine driver for TX channel to notify
+ * that transmission is complete. It updates statistics, unmaps DMA,
+ * frees SKB, and wakes the transmit queue.
+ */
+static void tsn_dma_tx_cb(void *data, const struct dmaengine_result *result)
+{
+	struct tsn_dma_chan *xchan = data;
+	struct tsn_priv *common = xchan->common;
+	struct skbuf_dma_descriptor *skbuf_dma;
+	struct netdev_queue *txq;
+	int len;
+	struct net_device *ndev;
+
+	scoped_guard(spinlock_irq, &common->tx_lock) {
+		skbuf_dma = tsn_get_tx_desc(xchan, xchan->ring_tail);
+		if (!skbuf_dma || !skbuf_dma->skb)
+			return;
+		ndev = skbuf_dma->skb->dev;
+		if (unlikely(!ndev)) {
+			/* Drop silently if SKB lost device association */
+			dev_consume_skb_any(skbuf_dma->skb);
+			xchan->ring_tail = (xchan->ring_tail + 1) & (TX_BD_NUM_DEFAULT - 1);
+			return;
+		}
+		txq = netdev_get_tx_queue(ndev,
+					  skb_get_queue_mapping(skbuf_dma->skb));
+		len = skbuf_dma->skb->len;
+		xchan->ring_tail = (xchan->ring_tail + 1) & (TX_BD_NUM_DEFAULT - 1);
+
+		ndev->stats.tx_packets++;
+		ndev->stats.tx_bytes += len;
+	}
+
+	dma_unmap_sg(common->dev, skbuf_dma->sgl, skbuf_dma->sg_len,
+		     DMA_TO_DEVICE);
+	dev_consume_skb_any(skbuf_dma->skb);
+	netif_txq_completed_wake(txq, 1, len,
+				 CIRC_SPACE(xchan->ring_head, xchan->ring_tail,
+					    TX_BD_NUM_DEFAULT), 2);
+}
+
+netdev_tx_t tsn_start_xmit_dmaengine(struct tsn_priv *common,
+				     struct sk_buff *skb,
+				     struct net_device *ndev)
+{
+	struct dma_async_tx_descriptor *dma_tx_desc = NULL;
+	struct skbuf_dma_descriptor *skbuf_dma;
+	int queue = skb_get_queue_mapping(skb);
+	struct tsn_dma_chan *xchan;
+	struct dma_device *dma_dev;
+	struct netdev_queue *txq;
+	int sg_len, ret;
+	u32 phys_chan;
+
+	if (unlikely(queue >= common->num_tx_queues)) {
+		if (net_ratelimit())
+			netdev_warn(ndev, "Invalid TX queue %d (max %u)\n",
+				    queue, common->num_tx_queues);
+		return NETDEV_TX_BUSY;
+	}
+
+	/* Map logical software TX queue index to physical DMA channel index */
+	phys_chan = common->tx_dma_chan_map[queue];
+	if (phys_chan == TSN_DMA_CH_INVALID) {
+		if (net_ratelimit())
+			netdev_warn(ndev, "Logical TX queue %d has invalid DMA mapping\n", queue);
+		return NETDEV_TX_BUSY;
+	}
+
+	xchan = common->tx_chans[phys_chan];
+	dma_dev = xchan->chan->device;
+
+	sg_len = skb_shinfo(skb)->nr_frags + 1;
+	txq = netdev_get_tx_queue(ndev, queue);
+
+	scoped_guard(spinlock_irq, &common->tx_lock) {
+		if (CIRC_SPACE(xchan->ring_head, xchan->ring_tail, TX_BD_NUM_DEFAULT) <= 1) {
+			netif_tx_stop_queue(txq);
+			if (net_ratelimit())
+				netdev_warn(ndev, "TSN TX ring full\n");
+			return NETDEV_TX_BUSY;
+		}
+
+		skbuf_dma = tsn_get_tx_desc(xchan, xchan->ring_head);
+		if (!skbuf_dma)
+			goto xmit_error_drop_skb;
+
+		xchan->ring_head = (xchan->ring_head + 1) & (TX_BD_NUM_DEFAULT - 1);
+	}
+
+	sg_init_table(skbuf_dma->sgl, sg_len);
+	ret = skb_to_sgvec(skb, skbuf_dma->sgl, 0, skb->len);
+	if (ret < 0)
+		goto xmit_error_drop_skb;
+
+	ret = dma_map_sg(common->dev, skbuf_dma->sgl, sg_len, DMA_TO_DEVICE);
+	if (!ret)
+		goto xmit_error_drop_skb;
+
+	dma_tx_desc = dma_dev->device_prep_slave_sg(xchan->chan, skbuf_dma->sgl,
+					    sg_len, DMA_MEM_TO_DEV,
+					    DMA_PREP_INTERRUPT, NULL);
+	if (!dma_tx_desc)
+		goto xmit_error_unmap_sg;
+
+	skbuf_dma->skb = skb;
+	skbuf_dma->sg_len = sg_len;
+	dma_tx_desc->callback_param = xchan;
+	dma_tx_desc->callback_result = tsn_dma_tx_cb;
+
+	netdev_tx_sent_queue(txq, skb->len);
+	if (CIRC_SPACE(xchan->ring_head, xchan->ring_tail, TX_BD_NUM_DEFAULT) < 2)
+		netif_tx_stop_queue(txq);
+	dmaengine_submit(dma_tx_desc);
+	dma_async_issue_pending(xchan->chan);
+
+	return NETDEV_TX_OK;
+
+xmit_error_unmap_sg:
+	dma_unmap_sg(common->dev, skbuf_dma->sgl, sg_len, DMA_TO_DEVICE);
+xmit_error_drop_skb:
+	dev_kfree_skb(skb);
+	ndev->stats.tx_dropped++;
+
+	return NETDEV_TX_OK;
+}
+
 /*
  * Helper to parse TX queue config subnode referenced by
  * xlnx,tsn-tx-config. This version enumerates child nodes in order and
@@ -147,6 +458,224 @@ static int tsn_parse_device_tree(struct platform_device *pdev)
 	return ret;
 }
 
+/**
+ * tsn_alloc_dma_chan - Allocate and initialize DMA channel
+ * @common: Pointer to TSN common structure
+ * @name: DMA channel name
+ * @is_tx: True for TX channel, false for RX channel
+ * @ring_size: Size of descriptor ring
+ *
+ * Return: Pointer to allocated TSN DMA channel, ERR_PTR on failure
+ *
+ * This function allocates DMA channel, creates descriptor ring, and
+ * initializes channel structure for packet transmission/reception.
+ */
+static struct tsn_dma_chan *tsn_alloc_dma_chan(struct tsn_priv *common,
+					       const char *name, bool is_tx,
+					       int ring_size)
+{
+	struct tsn_dma_chan *chan;
+	struct dma_chan *err_chan;
+	int i;
+
+	chan = kzalloc(sizeof(*chan), GFP_KERNEL);
+	if (!chan)
+		return ERR_PTR(-ENOMEM);
+
+	chan->chan = dma_request_chan(common->dev, name);
+	if (IS_ERR(chan->chan)) {
+		err_chan = chan->chan;
+		kfree(chan);
+		return ERR_CAST(err_chan);
+	}
+
+	chan->skb_ring = kcalloc(ring_size, sizeof(*chan->skb_ring), GFP_KERNEL);
+	if (!chan->skb_ring) {
+		err_chan = ERR_PTR(-ENOMEM);
+		dma_release_channel(chan->chan);
+		kfree(chan);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	for (i = 0; i < ring_size; i++) {
+		chan->skb_ring[i] = kzalloc(sizeof(*chan->skb_ring[i]),
+					    GFP_KERNEL);
+		if (!chan->skb_ring[i]) {
+			/* Free already allocated descriptors */
+			while (--i >= 0)
+				kfree(chan->skb_ring[i]);
+			kfree(chan->skb_ring);
+			dma_release_channel(chan->chan);
+			kfree(chan);
+			return ERR_PTR(-ENOMEM);
+		}
+	}
+
+	chan->ring_head = 0;
+	chan->ring_tail = 0;
+	chan->is_tx = is_tx;
+	chan->common = common;
+
+	return chan;
+}
+
+/**
+ * tsn_free_dma_chan - Free DMA channel and associated resources
+ * @chan: Pointer to TSN DMA channel structure
+ *
+ * This function releases DMA channel, frees descriptor ring memory,
+ * and cleans up all associated resources.
+ */
+static void tsn_free_dma_chan(struct tsn_dma_chan *chan)
+{
+	int i;
+
+	if (!chan)
+		return;
+
+	if (chan->skb_ring) {
+		for (i = 0; i < (chan->is_tx ? TX_BD_NUM_DEFAULT : RX_BD_NUM_DEFAULT); i++)
+			kfree(chan->skb_ring[i]);
+		kfree(chan->skb_ring);
+	}
+
+	if (chan->chan)
+		dma_release_channel(chan->chan);
+
+	kfree(chan);
+}
+
+/**
+ * tsn_exit_dmaengine - Clean up DMA engine resources
+ * @pdev: Platform device pointer
+ *
+ * This function releases all TX and RX DMA channels and frees
+ * associated memory during driver shutdown.
+ */
+static void tsn_exit_dmaengine(struct platform_device *pdev)
+{
+	struct tsn_priv *common = platform_get_drvdata(pdev);
+	int i;
+
+	/* Free TX channels */
+	if (common->tx_chans) {
+		for (i = 0; i < common->num_tx_queues; i++) {
+			if (common->tx_chans[i])
+				tsn_free_dma_chan(common->tx_chans[i]);
+		}
+		kfree(common->tx_chans);
+		common->tx_chans = NULL;
+	}
+
+	/* Free RX channels */
+	if (common->rx_chans) {
+		for (i = 0; i < common->num_rx_queues; i++) {
+			if (common->rx_chans[i])
+				tsn_free_dma_chan(common->rx_chans[i]);
+		}
+		kfree(common->rx_chans);
+		common->rx_chans = NULL;
+	}
+}
+
+/**
+ * tsn_init_dmaengine - Initialize DMA engine for TSN endpoint
+ * @pdev: Platform device pointer
+ *
+ * Return: 0 on success, negative error code on failure
+ *
+ * This function allocates TX/RX DMA channels, creates descriptor rings,
+ * and submits initial RX descriptors for packet reception.
+ */
+static int tsn_init_dmaengine(struct platform_device *pdev)
+{
+	struct tsn_priv *common = platform_get_drvdata(pdev);
+	int tx_ring_allocated = 0, rx_ring_allocated = 0;
+	int i, j, ret = 0;
+
+	common->tx_chans = kcalloc(common->num_tx_queues,
+				   sizeof(*common->tx_chans),
+				   GFP_KERNEL);
+	if (!common->tx_chans)
+		return -ENOMEM;
+
+	common->rx_chans = kcalloc(common->num_rx_queues,
+				   sizeof(*common->rx_chans),
+				   GFP_KERNEL);
+	if (!common->rx_chans) {
+		ret = -ENOMEM;
+		goto err_free_tx;
+	}
+
+	// Allocate TX channels
+	for (i = 0; i < common->num_tx_queues; i++) {
+		char name[16];
+
+		snprintf(name, sizeof(name), "tx_chan%d", i);
+		common->tx_chans[i] = tsn_alloc_dma_chan(common, name, true, TX_BD_NUM_DEFAULT);
+		if (IS_ERR(common->tx_chans[i])) {
+			ret = PTR_ERR(common->tx_chans[i]);
+			goto err_free_tx_chans;
+		}
+		tx_ring_allocated++;
+	}
+
+	// Allocate RX channels
+	for (i = 0; i < common->num_rx_queues; i++) {
+		char name[16];
+
+		snprintf(name, sizeof(name), "rx_chan%d", i);
+		common->rx_chans[i] = tsn_alloc_dma_chan(common, name, false, RX_BD_NUM_DEFAULT);
+		if (IS_ERR(common->rx_chans[i])) {
+			ret = PTR_ERR(common->rx_chans[i]);
+			goto err_free_rx_chans;
+		}
+		rx_ring_allocated++;
+	}
+
+	// Submit initial RX descriptors
+	for (i = 0; i < common->num_rx_queues; i++) {
+		for (j = 0; j < RX_BD_NUM_DEFAULT; j++)
+			tsn_rx_submit_desc(common->rx_chans[i]);
+		dma_async_issue_pending(common->rx_chans[i]->chan);
+	}
+
+	return 0;
+
+err_free_rx_chans:
+	while (--rx_ring_allocated >= 0)
+		tsn_free_dma_chan(common->rx_chans[rx_ring_allocated]);
+err_free_tx_chans:
+	while (--tx_ring_allocated >= 0)
+		tsn_free_dma_chan(common->tx_chans[tx_ring_allocated]);
+	kfree(common->rx_chans);
+err_free_tx:
+	kfree(common->tx_chans);
+	return ret;
+}
+
+static int tsn_reset_dma_controller(struct tsn_priv *common)
+{
+	struct xilinx_vdma_config cfg = { .reset = 1 };
+	struct dma_chan *tx_chan0;
+	int ret;
+
+	tx_chan0 = dma_request_chan(common->dev, "tx_chan0");
+	if (IS_ERR(tx_chan0))
+		return dev_err_probe(common->dev, PTR_ERR(tx_chan0),
+				     "Failed to request tx_chan0 for reset\n");
+
+	ret = xilinx_vdma_channel_set_config(tx_chan0, &cfg);
+	dma_release_channel(tx_chan0);
+
+	if (ret < 0)
+		return dev_err_probe(common->dev, ret,
+				"Failed to reset DMA controller\n");
+
+	dev_info(common->dev, "DMA controller reset successful\n");
+	return 0;
+}
+
 /**
  * tsn_ip_probe - Probe TSN IP core device
  * @pdev: Platform device pointer
@@ -183,7 +712,32 @@ static int tsn_ip_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	common->max_frm_size = TSN_MAX_VLAN_FRAME_SIZE;
+
+	/* Reset DMA controller BEFORE any channel allocation */
+	ret = tsn_reset_dma_controller(common);
+	if (ret)
+		goto free_clk;
+
+	/* Initialize DMA engine - allocate channels */
+	ret = tsn_init_dmaengine(pdev);
+	if (ret) {
+		dev_err(common->dev, "Failed to initialize DMA engine: %d\n", ret);
+		goto free_clk;
+	}
+
+	/* Initialize EP - now safe to register because DMA is ready */
+	ret = tsn_ep_init(pdev);
+	if (ret)
+		goto exit_dma;
+
 	return 0;
+
+exit_dma:
+	tsn_exit_dmaengine(pdev);
+free_clk:
+	clk_bulk_disable_unprepare(TSN_NUM_CLOCKS, common->clks);
+	return ret;
 }
 
 /**
@@ -194,6 +748,10 @@ static void tsn_ip_remove(struct platform_device *pdev)
 {
 	struct tsn_priv *common = platform_get_drvdata(pdev);
 
+	/* Tear down DMA channels and endpoint */
+	if (common->ep)
+		tsn_ep_exit(pdev);
+	tsn_exit_dmaengine(pdev);
 	clk_bulk_disable_unprepare(TSN_NUM_CLOCKS, common->clks);
 }
 
-- 
2.25.1


