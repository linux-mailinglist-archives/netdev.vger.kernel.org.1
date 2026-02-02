Return-Path: <netdev+bounces-255911-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHMpNazEgGl3AgMAu9opvQ
	(envelope-from <netdev+bounces-255911-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 16:37:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74846CE52A
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 16:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1CB9E301AEE0
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 15:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0127637B400;
	Mon,  2 Feb 2026 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="20YJIzYn"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010061.outbound.protection.outlook.com [40.93.198.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1D3376473;
	Mon,  2 Feb 2026 15:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770046594; cv=fail; b=LdWMC1sAlKqEK68WzqmLzIfmiDDTRDmB25EqNMhAB8cVyM8Att4FpjZgyGWBOSEh3bjWY+rSJwequngUuqpYVQ/XXVbsDQYrVdebt9MlilkuEWV1CppR68xid0wbIbY/ys+qIGLBfJJeDWpeAxzqg7BIfhep/vmrRuQ+uiB7nOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770046594; c=relaxed/simple;
	bh=NS6qMoYPUBz0czti+ftdmNH4ua7NaUWbwHLjhvOOzeA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PTTAqWWL1BQrKkQnak/4LeB7o4/Q6uCF5UirbWSB1RnrGePToB4MPwcG54l+ok83GHLsZJdZgyL80RLTATPfTPEIaAz8Ndr0DlP7vxUe1bLhqno+Tpq49g0rTewXUWo6PXnvh0+/7FW72kUZ6ZvyuCsMfB6gJBouKPcrw5szzM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=20YJIzYn; arc=fail smtp.client-ip=40.93.198.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avauC/E0L9QmgUZ8FI2LEPx7N7N1z8PIvo5FVhWQuIc9HMetFH7kOZHkd8vyg52dEAIq+ll4zVY0mNUrtn6WxtVYHkABrgad2cTkNl1v0owkwnuUx+GNYXlqN00Vz3ZRcJzziKVttBBdfM4Vvh2iA6IZd/JAENlB5iJ2m95dRs+eXd+mirgoIElUPQ4eusKU+UgQxU0WIcaxgePl1Y/bc2RCOKYh+iV6i4EBfbRLeJgIgSwluodqmce2mtZPdoAikpTyBglHF2DinFj/4UtOXSF4FFXWADQVl054pgoGaPepI790YZ8q8elRHv4sC1Do2qEB1I9Cgs+PCfnx005I+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+FKkQ6eA9hPX76uv/+empPxjJdGb1uIDyQyPja2Bog=;
 b=AGwcjbtduZgJGmJsAekbXdDLdxCWc5FRDF4yO/u2YqONjVoz88vn13hOTGm9G7l92xjAYH8zI53LM4OG1ACRkNCCg8GU8Y3o6NLz0X39Gx8IK0YovBfIFPpQ+U5b9n6HHIEdxK39OvhTcpJklq36rzi8LMthR4/0cWBTqToODdrxA75ZGgA7l3LqlAm9B6snUrewxRy5D49CdN6uY/P601WiM1AKgWO4AqYuYtXCazyRR0pD8gWO4DdIOssSrkP1OKqJBqDhfr4oIdAt2gW2cgvaXLrDIzSy9XDbrIuBY0V9fcyU6kJVEJqmo+O1ejR+udYBoVP5kYOg8RxzFJHfXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+FKkQ6eA9hPX76uv/+empPxjJdGb1uIDyQyPja2Bog=;
 b=20YJIzYntHoGs7K8wSSA7mOIMe6+SGeM7JtozQJ9moq/UV5l2MYIA4F+E1QgQQtnndpXnvgAfyEJj7XlRu/9yWPe5f3KWvTZ7Y/tDDc0qi8pNMEnq0StG4FwK7TQzRZ1HYbmr+0B6B+BLtBcsOJigDYOkOevx4+TmWvxilMLXl8=
Received: from BN9PR03CA0096.namprd03.prod.outlook.com (2603:10b6:408:fd::11)
 by LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 15:36:29 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:fd:cafe::2d) by BN9PR03CA0096.outlook.office365.com
 (2603:10b6:408:fd::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.15 via Frontend Transport; Mon,
 2 Feb 2026 15:35:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 15:36:26 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Feb
 2026 09:36:24 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <horms@kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<linux-kernel@vger.kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH 3/3] net: amd-xgbe: add RSS ethtool self-test
Date: Mon, 2 Feb 2026 21:05:42 +0530
Message-ID: <20260202153542.1727429-4-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260202153542.1727429-1-Raju.Rangoju@amd.com>
References: <20260202153542.1727429-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|LV3PR12MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc9ae67-6351-4551-f9b5-08de6270d43c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QqSHtQsoAPpA9BhkgoTUAxJnFQ9S5bqZB5Qj1XMNERKcUYFMpVvscyu6rUlB?=
 =?us-ascii?Q?KjaTo4jOQnEA/78fGA6oNDDtxvw9CrbjI4UvoFZRVgx32CUSqF+oBb3ov0ln?=
 =?us-ascii?Q?txg2P6JtYQtCR3yWLnKz9Bk1JXzMSdHXqfGAWS6D4NN4h0OsgnEqGUKj+w3W?=
 =?us-ascii?Q?u/FxjQVeDWzNoc8hoIbXO1khGfD0h/dHcjMMsVOKrozTe6GUpPLQLtukvPCL?=
 =?us-ascii?Q?SfNlP2lj8H0xdQuCEmwD+0kLuMFDmA4R4rLFiQgpNu9PUsJqjJK7ZaLCCs6i?=
 =?us-ascii?Q?bBoKzZnqHiK+H/Nrx7eHb02R6eCDA5RpP6hqGcLV6l6KmoTvruY6iXh+VLrJ?=
 =?us-ascii?Q?eTHfSkxaJ5GKBkvY/Kg5Jhu89XQIlJKl9knW0Tsw4iC8rL6WmIFU13rn/Adh?=
 =?us-ascii?Q?dMRjMLx+fgx0/U0hhT0SXt1xzuI1jWI7+TeJdcWzCiTI1pFVMgE3A0LRPRqF?=
 =?us-ascii?Q?yfcLRTBfBtasaa8xufc4EZwjSFR3Gnh7jzm/oVWDA9gg3o4lKrYy/2uCTKhN?=
 =?us-ascii?Q?fYbf5aAa1oOX65jGOWP+Ac1FHIIG7T6swYJPpQ27sJJ8lTKBBbY1ZSi+1V6g?=
 =?us-ascii?Q?arebAyszYVgYilB7XmrAKU0kL7rqmIBb2MhsN683UPCUdxlyjdOsTcxc+7t+?=
 =?us-ascii?Q?Ba1fSCeapO+rnVO7yGU+UOytx7N3az1sh3AOe+7sDosTHALv8NOTqx10BIXh?=
 =?us-ascii?Q?gaLvST2ytQ/tU+P+TqxO0GG2t6rN0gYIV+v/9Qc38ZzEYSH6JTk0d373ldHC?=
 =?us-ascii?Q?03IH50Da6KZOpL79OerP8XHNeBDS1YHZlUchh7sZboFw26a+dDHu9PUCcmam?=
 =?us-ascii?Q?FusrLX0VtOIIJvq5EY/j7yI5pMZxW3VfkO0UuqI8+8t/OgvXqUqL8LUTmZ5j?=
 =?us-ascii?Q?qGYv1Ag8CTZY6tLmk1OdC22WTCDp8TWHaEVuf72jQg3VnV5DhPnbXSuAQZYL?=
 =?us-ascii?Q?gHix0M/xruZISbnhe+dcm49pLtQ4P15oqBtZ1RjUv8jtvyf840l81uzeY/tH?=
 =?us-ascii?Q?M++qf1+2huFwBl94QRNNSE76vIMl91xljyUEVu7FLJZW/GFGazo5idiqXghF?=
 =?us-ascii?Q?yimMmzHH1ZU4zRFICS7LfBs43p52vy4sx2Uuout1QScvCyfYw0fILVPO9RHu?=
 =?us-ascii?Q?oSZN/urz5qdhAJla4kl3dvS65m/tcuWrVVlW3xj5O5Iw0eZHR2OD17s8SYCr?=
 =?us-ascii?Q?LB1Pd3pPP9Fg3xKYlThQWwfkjPCmOh8Kb2DFw5tD4haFmWsfEEdVZWIpd2/G?=
 =?us-ascii?Q?2r4q18iMMxUuTEVe8GpzNFigwL5XqSbNp7iTCYc42xoK/raUdPgeMkubVYTM?=
 =?us-ascii?Q?5V2VQH0QqhkmgM/fPNWSUV4xq21ovVZA8t2nJlXb1Glopz0K7EGY4kx0C7Dy?=
 =?us-ascii?Q?kThb98SkxHPqzXJuvfZk5puZvWS+1Gix6Ga4BS+9ylJNlOf5iPvDuSj4yOiw?=
 =?us-ascii?Q?sEpLX9H6zaci0yQ4fnwSA1md5M4d+GPJbz4rwgjIyh6lqpbDjALJVMs2B3yc?=
 =?us-ascii?Q?n0HnH552EdrpCGwqW7teCwlV/GbnbE9zHJg/8e8uFr1PksmW2JeumBSoNPSs?=
 =?us-ascii?Q?0x3kYmEau5Jj5dgkkKWyZcsxknXPKz6Z6capuFb5TioauCXaU6jK7dZcEeHP?=
 =?us-ascii?Q?4F1FelQQR1LYGlXsg2YWdhdpqOJRSdqmKrxtl2qAfmvoDtYyDJR3itDZvSVd?=
 =?us-ascii?Q?e+pZWQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WTeqdhscydENLCH8eH2HPQTvEvQmKMNJFfxXZZ0VmEjVaFiMz7tDoJ5l2NlZ52RZ9jIOOo0cqA+5b+dWE5btwDhTjHWpwyqoON3NpL4UBI3C48rhnMM1wZ+43j2SFzPbtSsLrlRuxyfsPfITGfTD0QmGSLA9mDl2Mp0OLvEgLkn3RV7xOYIT6gc1ge8FerWnWwwBeO+QPs+JyAA3gXbEHKXxxHKJvf8E5dY15f0DnNDSrUpa4aMdUgRQKS+CLrEQKznhwOWboR7gMIeRPOa7F8cwGAW5ZHFKjkc051Acas8GQWyMYNKfVqmeB5VAmC9dFvzghY0dQg3/yonZq1mGiFCMIj1/pBrOd8VHMMNKdAKK9lxL0l5WIgp2Q6p/FJtsg5ivQETaOFHtelpmBEmY2cGZoXeSLTz4Ou4WQ5GdwTOjhuxmtV4YaHClB6J13lsz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 15:36:26.9419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc9ae67-6351-4551-f9b5-08de6270d43c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255911-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 74846CE52A
X-Rspamd-Action: no action

Add a Receive Side Scaling (RSS) self-test to the ethtool diagnostic
suite to verify that the hardware correctly computes hash values for
incoming packets.

The test validates RSS functionality by:
1. Checking for RSS hardware feature support (rss bit in MAC_HWF1R)
2. Sending a test packet with specific TCP/UDP ports to trigger
   hash computation
3. Verifying that the received packet has a non-zero hash value
   computed by the hardware

The test uses the existing loopback infrastructure and requires
PHY loopback mode. It uses specific port values (sport=0xabc,
dport=0xdef) to generate a deterministic hash that exercises
the RSS hash computation logic.

This test helps users verify that RSS is properly configured and
functioning, which is essential for multi-queue performance on
multi-core systems.

Usage:
  $ ethtool -t <interface>

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 32 +++++++++++++++++++
 include/net/selftests.h                       |  1 +
 2 files changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
index ae4825578c59..bd1c757bbc3f 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
@@ -100,8 +100,13 @@ static int xgbe_test_loopback_validate(struct sk_buff *skb,
 	if (tdata->packet->id != hdr->id)
 		goto out;
 
+	/* Validate RSS hash if expected */
+	if (tdata->packet->exp_hash && !skb->hash)
+		goto out;
+
 	tdata->ok = true;
 	complete(&tdata->comp);
+
 out:
 	kfree_skb(skb);
 	return 0;
@@ -154,6 +159,29 @@ static int __xgbe_test_loopback(struct xgbe_prv_data *pdata,
 	return ret;
 }
 
+static int xgbe_test_rss(struct xgbe_prv_data *pdata)
+{
+	struct net_packet_attrs attr = {};
+	int ret;
+
+	/* Check for RSS hardware support */
+	if (!pdata->hw_feat.rss)
+		return -EOPNOTSUPP;
+
+	attr.dst = pdata->netdev->dev_addr;
+	/*
+	 * Use specific port values to generate a hash.
+	 * The asymmetric port values ensure the hash computation
+	 * produces a non-zero result for test validation.
+	 */
+	attr.sport = 0xabc;
+	attr.dport = 0xdef;
+	attr.exp_hash = true;
+	ret = __xgbe_test_loopback(pdata, &attr);
+
+	return ret;
+}
+
 static int xgbe_test_arp_validate(struct sk_buff *skb,
 				  struct net_device *ndev,
 				  struct packet_type *pt,
@@ -368,6 +396,10 @@ static const struct xgbe_test xgbe_selftests[] = {
 		.name = "ARP Offload    ",
 		.lb = XGBE_LOOPBACK_PHY,
 		.fn = xgbe_test_arpoffload,
+	}, {
+		.name = "RSS Hash       ",
+		.lb = XGBE_LOOPBACK_PHY,
+		.fn = xgbe_test_rss,
 	},
 };
 
diff --git a/include/net/selftests.h b/include/net/selftests.h
index c36e07406ad4..18a9b4830dfc 100644
--- a/include/net/selftests.h
+++ b/include/net/selftests.h
@@ -19,6 +19,7 @@ struct net_packet_attrs {
 	u8 id;
 	u16 queue_mapping;
 	bool bad_csum;
+	u32 exp_hash;
 };
 
 struct net_test_priv {
-- 
2.34.1


