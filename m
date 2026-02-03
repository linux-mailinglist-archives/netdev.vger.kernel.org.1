Return-Path: <netdev+bounces-256331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEZYMqgNgmkKOwMAu9opvQ
	(envelope-from <netdev+bounces-256331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 16:00:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD87DAF58
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 16:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C0FC303E811
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 14:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1673AEF4F;
	Tue,  3 Feb 2026 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0YadThiQ"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013071.outbound.protection.outlook.com [40.93.196.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F578F513;
	Tue,  3 Feb 2026 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770130665; cv=fail; b=Ie82QFI4Kpko5lvfY/m9r8tKCvQO87gdTcM03GVuUGZ7CINNg8g61IkMD2V09GsWzFw75vublTmQkkkmxczm2GI3ags1xhZkMgmQUs1kyvfxBSy47tNCyCl7XXNdBTgOEQeUipMjGnNiFKPahfuD+GCJClVQzW06a8q8y4kt4P4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770130665; c=relaxed/simple;
	bh=j91uEVUNkZ45R+QmFib14sE7gapGNkBrnD+A4m7ceW8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k6WFHZiEIkVf+a+LCfmcfNwvXAmSmmluw1uamPLpqal0x/83zu0T2PzGIzanawtjjj/unqWdpX9miXh5mtM6OQ2iB7h5tELSs6vm1EQ28DC3x5sLCdD2SBHdSd3euKQ/5SD6zjMRtXUXZ5/n9MQ47IVVlHYcewOPncTrcbUHpj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0YadThiQ; arc=fail smtp.client-ip=40.93.196.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYoS328LdZzvG/Cj4I0pGfdLeUMkaY+LXHSS5hwAj7vH0IfakZeA81ZjKX74/OCzwKO0s3SU3B1U5bgPf+tWuBUUiF5vEzLNQnma8H5xCs76yvnK3mHFtfG8MqOampDWU8e3UclTm4rX8qYYyX9yrCEJyeCJm4gdLNF36Zz8cmDaIcRhqGBwrWiAnkImW/dkQD1EmBSc9Vi2VpPLokeb2jdflbRfKJEzp+6j/T9P3m/44H4O7ssSNqM08jNSMr8LqDZMx9Ze/v5EFn2CKlKrnSXCKJ08BeNZKaUpo7VD+gl1bJzqK0sgvtw0kWJ9ZiEFbh82B4Ch6TXh5BiqzKtD+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFceVHDBqu2LAgj8hCNnb9JIjDib/ULiD4PqXd4cy8Q=;
 b=aVyMb3AzrMLsC9SrigRQHqGf45Xrst2vGBWX5Bi8roR0NfUnGJZEIywPQT8OvU1NREpfEcIOu8SZcxTCQbjuBSBKpSdx5M2c997dl3PfVGHqZrGzLryc+FWTWdqfoAg/aSXBDOBXgAqv3vM9t/xeLjJkCK4DaGr7UFdRhfM978mORTQo+Be/Cn3d+37j21m5E4tdLVJBs3NngbZnofK9X4cxs5Sq9Qk+IS2KAH+QbSMXAgXU4l05maJkGlG8QjWd3oBkq3jeBUxcBQfnrY3xFxDL8/SFojluYFGwN1wu8VrwBDm3HkN0u2XiAwT7vz9sJcT0ywPNnTsM0kGyptzVGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFceVHDBqu2LAgj8hCNnb9JIjDib/ULiD4PqXd4cy8Q=;
 b=0YadThiQWnKzQsFkeTBMbB3bvSjPI8WQLTVUM9+Xeeh7sBbQE/WvkVGDrDDaa9qvBts20MvUdjb9YVQblGjRuahONZezQAmrWXaAo+5cxV97JgRIFWIjVBIGsV9anq3gmHYlGXukl4sS8wL/Mw6VpKVAeDEagDlxj5mxgsoVDJ8=
Received: from DM6PR08CA0025.namprd08.prod.outlook.com (2603:10b6:5:80::38) by
 LV5PR12MB9778.namprd12.prod.outlook.com (2603:10b6:408:300::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.16; Tue, 3 Feb 2026 14:57:38 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:5:80:cafe::82) by DM6PR08CA0025.outlook.office365.com
 (2603:10b6:5:80::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 14:57:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 14:57:38 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 08:57:30 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <horms@kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<linux-kernel@vger.kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net-next v2 3/4] amd-xgbe: add ARP offload ethtool self-test
Date: Tue, 3 Feb 2026 20:26:57 +0530
Message-ID: <20260203145658.2936778-4-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203145658.2936778-1-Raju.Rangoju@amd.com>
References: <20260203145658.2936778-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|LV5PR12MB9778:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f1823e3-5d50-4a3b-afbf-08de633492ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|18082099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mzxD57nLjTqhdYpggiGV9paWbUud8MYlQ66RuhnHqVcsYvpHOglq1mhqFUR1?=
 =?us-ascii?Q?cEE8ha4xvtV8MEbESwCVqNJJixNFs1G/ryg/5WsbSTtXWk1s5UcXv+dyVlEK?=
 =?us-ascii?Q?wwkDHnJZF6j63osvDGzpAcWXCdviveAc2DNN99NRz9P4TtKCF5fTvK0rAxC6?=
 =?us-ascii?Q?vuQK5KCJHeMrTpq6Zm+PGEB2oHyjb00b47TjJ1iQT+lpYwgfC671gonNhQp4?=
 =?us-ascii?Q?7GUhb9avoSQNNrQvtNcHXTQGXDbq+omJc/gnHf2YzGVxT5c9xrVaF4Y/eEUT?=
 =?us-ascii?Q?fPba8Azt++v1SZH0Yeym1rVLEbK6BBh7jvAIc/cEYiMVeajzw5cyOAekheQX?=
 =?us-ascii?Q?UBKvQ2J6BxnI6bNXt9CgyLA33lcApv7P9I3NpDK6zByqOfX6cfKMGOhT1mNo?=
 =?us-ascii?Q?jsoIG7t6WqSXtxHyXBWgjorxC7hyhraKJJgk5xpJnIlFzdQUQd0/sjGrCyDe?=
 =?us-ascii?Q?vW9FxK+sVyIKIQaGJJhzpu29ccMC0SqmRFOlxI7JBlHDemU8Gx91HMstPx5c?=
 =?us-ascii?Q?tRcezdEHatMFik1AryzSZznQGE3NgPDeclch0IuvY3RtcT1wECXjowJUJK/w?=
 =?us-ascii?Q?HYOd7GGrtbqpxK3J7Zox6ZNhatLbH35izODUziiSyOgPFSgFOKCWh+sOufUM?=
 =?us-ascii?Q?C7JtlJrMkC0lPu+ORhvyuPbbZm2lTzmIXqFaSJT4wz/97ElCVRClVz1sHfHj?=
 =?us-ascii?Q?hM1UjqtNuGkE4mWg2jjEeEhVoeAX1ilhmUbfkH+whWgFgjAH8zI1fcb8nsP0?=
 =?us-ascii?Q?t4772i6Ui2pfRWyDuI6nIpeAJ9LVleUlm+GgxaC659DBW+rBpHhnLxTk8k5D?=
 =?us-ascii?Q?jfeLs0lunGCNYriUGdNZ+7kylzjVYA2NlUMb8Wn+brOzC+TDUSnodGFtJYeA?=
 =?us-ascii?Q?kMoSYplrjV1zLAdqkK12LNhDmYiQ3MdbHbzGAzb9jJDBRJzzIH9TOMkgqbaG?=
 =?us-ascii?Q?BBCD7QAUTLFEdqUXyQl0eaml/FrJKhv9bPAb4IKGfj+VjYuwcqu6pIb8SNxG?=
 =?us-ascii?Q?bzX9wNysQdeQK+eLfLiOubMbvUR8r78r/EDMbqDXiU89MgXu8goHCeYd/l4i?=
 =?us-ascii?Q?zYzmPrjI/IFWej42D2A8y9bcRbAOFga0SMUS2m9fzYyhtwb5KjxzeJ1ARcqX?=
 =?us-ascii?Q?pWfC26ugRpBtsrd72c80RZMmnyQyIW9EkpbOFYkDnTdOdNK3nBA6AU8OaLv5?=
 =?us-ascii?Q?53IkbKjiY1iMm+iC0VAjwECEhZ5dyos/b94qkxsycwS8DKmDa2UWbw6jp+C1?=
 =?us-ascii?Q?TsFidDd1b1BshnN4yB4IlxUEIlHr7C/L/8KiWhpAojrVmCiTObUJVCZjERIR?=
 =?us-ascii?Q?8TuMIcOuyDhyY4Jmwqsqjhs9iq85jXm0Qx0ybCCYVo/dV4NrdhBAgs3b4wu7?=
 =?us-ascii?Q?Ql4h+W4J65FDnlK9sKn7E5pzJFsqN6QoNyZ0KccuSx/SDsysQ8dsmShs+D7M?=
 =?us-ascii?Q?Tmdm7SsLiViW7aQrks15aLNrAd8UnTRG7EUUjHHBnXbTAtbbOwFDHicKsZsx?=
 =?us-ascii?Q?21e2nMsIoZdC94qOfiFcL5MhlIMRfandNdPG5pSqUdToghwUdmQZA6jrRGLO?=
 =?us-ascii?Q?oq5vGpjlg+vWU5yD6PQzsNvtF6mk9nIukHYuYEaju1k9e1QqF7mn6XC49TgQ?=
 =?us-ascii?Q?+GGRfiRAwQlpwyquaH7UngGYSgsiUhCIeYh3U+ppJxrio0mlJAiDbboUkjv3?=
 =?us-ascii?Q?uatVsg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(18082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DEXmIPyXvB2T8FwobPkOSuttBbJzlXK8f/M64aclploXYeLADCPYlnWtGHjyMqpjoqYXOWWnoSTjPC5JkloyXcYS5smuLgNniFTOZaXGZ94Pse22PoqeTzYnqcJA2/hejzaIxcBx4CfORdRyKto530axHWOR9C3UgOdxK9TF0T1ktpsCO37XNJbO+RMKrmZke4RD44kdf6ECGxfskHWa35g+Mq29eTPSv/iPGtuQ4GNNC2zXHWhUWtpcmr2vG0fxj3nyu+v5YJO0elTemn3gZ6IR/BID/kg2TQT+hMPzaHfvMVq5FEAhAcNcrNxSWCxnLUi7j6UUFxcm/yOC9UhDnggmT3aiQrWPQbkzFSHUhgXLhgV5qT3OQNXUN7/qnl8dd9xX16rQkSQOe9HOY9ObuG/WjZJouxSFbYozRQQCE4bVKNwyP1byNEbJidLiVniU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 14:57:38.2534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1823e3-5d50-4a3b-afbf-08de633492ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9778
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256331-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7CD87DAF58
X-Rspamd-Action: no action

Add an ethtool self-test to verify the hardware ARP offload
functionality. The test validates that the MAC correctly responds
to ARP requests without CPU intervention.

Test procedure:
1. Check for aoe (ARP Offload Engine) hardware capability
2. Create an ARP request packet with test IP addresses
3. Enable ARP offload with the target IP address
4. Transmit the ARP request in PHY loopback mode
5. Verify that an ARP reply is received from the hardware
6. Clean up and restore configuration

The test requires the device to be in PHY loopback mode and runs as part
of offline ethtool self-test suite.

Usage:
  $ ethtool -t <interface>

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v1:
- Use link-local IPs (169.254.x.x) for ARP test to avoid interfering with                 real network configuration.
- Improved error handling and resource cleanup.

 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 121 +++++++++++++++++-
 1 file changed, 120 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
index 55e5e467facd..b57826a91361 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
@@ -29,6 +29,121 @@ struct xgbe_test {
 
 static u8 xgbe_test_id;
 
+/* Link-local test IPs to avoid interfering with real network config */
+#define XGBE_TEST_ARP_SRC_IP   htonl(0xa9fe0101) /* 169.254.1.1 */
+#define XGBE_TEST_ARP_DST_IP   htonl(0xa9fe0102) /* 169.254.1.2 */
+
+static int xgbe_test_arp_validate(struct sk_buff *skb,
+				  struct net_device *ndev,
+				  struct packet_type *pt,
+				  struct net_device *orig_ndev)
+{
+	struct net_test_priv *tdata = pt->af_packet_priv;
+	struct ethhdr *eth_hdr;
+	struct arphdr *ah;
+
+	skb = skb_unshare(skb, GFP_ATOMIC);
+	if (!skb)
+		goto out;
+
+	if (skb_linearize(skb))
+		goto out;
+
+	eth_hdr = (struct ethhdr *)skb_mac_header(skb);
+
+	/* Verify the reply is destined to our test source MAC */
+	if (!ether_addr_equal_unaligned(eth_hdr->h_dest, tdata->packet->src))
+		goto out;
+
+	/* Verify this is an ARP reply */
+	if (eth_hdr->h_proto != htons(ETH_P_ARP))
+		goto out;
+
+	ah = arp_hdr(skb);
+
+	/* Verify the ARP operation is a reply */
+	if (ah->ar_op != htons(ARPOP_REPLY))
+		goto out;
+
+	tdata->ok = true;
+	complete(&tdata->comp);
+out:
+	kfree_skb(skb);
+	return 0;
+}
+
+static int xgbe_test_arpoffload(struct xgbe_prv_data *pdata)
+{
+	unsigned char bcast[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
+	unsigned char src[ETH_ALEN] = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05 };
+	struct net_packet_attrs attr = {};
+	struct net_test_priv *tdata;
+	bool pt_added = false;
+	struct sk_buff *skb;
+	int ret;
+
+	/* Check if ARP offload is supported */
+	if (!pdata->hw_feat.aoe)
+		return -EOPNOTSUPP;
+
+	tdata = kzalloc(sizeof(*tdata), GFP_KERNEL);
+	if (!tdata)
+		return -ENOMEM;
+
+	tdata->ok = false;
+	init_completion(&tdata->comp);
+
+	attr.src = src;
+	tdata->packet = &attr;
+
+	/* Build ARP request: who-has DST tell SRC */
+	skb = arp_create(ARPOP_REQUEST, ETH_P_ARP, XGBE_TEST_ARP_DST_IP,
+			 pdata->netdev, XGBE_TEST_ARP_SRC_IP, NULL, src, bcast);
+	if (!skb) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	tdata->pt.type = htons(ETH_P_ARP);
+	tdata->pt.func = xgbe_test_arp_validate;
+	tdata->pt.dev = pdata->netdev;
+	tdata->pt.af_packet_priv = tdata;
+	dev_add_pack(&tdata->pt);
+	pt_added = true;
+
+	/* Enable ARP offload */
+	xgbe_enable_arp_offload(pdata, ntohl(XGBE_TEST_ARP_DST_IP));
+
+	/* Set device to promiscuous to receive the ARP reply */
+	ret = dev_set_promiscuity(pdata->netdev, 1);
+	if (ret) {
+		netdev_err(pdata->netdev, "Failed to set promiscuous mode\n");
+		kfree(skb);
+		goto out_disable;
+	}
+
+	ret = dev_direct_xmit(skb, 0);
+	skb = NULL;
+	if (ret)
+		goto disable_promisc;
+
+	/* Wait for ARP reply */
+	wait_for_completion_timeout(&tdata->comp, NET_LB_TIMEOUT);
+	ret = tdata->ok ? 0 : -ETIMEDOUT;
+	if (ret)
+		netdev_err(pdata->netdev, "ARP Offload test timed out: ret %d\n", ret);
+
+disable_promisc:
+	dev_set_promiscuity(pdata->netdev, -1);
+out_disable:
+	xgbe_disable_arp_offload(pdata);
+	if (pt_added)
+		dev_remove_pack(&tdata->pt);
+out_free:
+	kfree(tdata);
+	return ret;
+}
+
 static int xgbe_test_loopback_validate(struct sk_buff *skb,
 				       struct net_device *ndev,
 				       struct packet_type *pt,
@@ -251,7 +366,11 @@ static const struct xgbe_test xgbe_selftests[] = {
 		.name = "Jumbo Frame    ",
 		.lb = XGBE_LOOPBACK_PHY,
 		.fn = xgbe_test_jumbo,
-	},
+	}, {
+		.name = "ARP Offload    ",
+		.lb = XGBE_LOOPBACK_PHY,
+		.fn = xgbe_test_arpoffload,
+	}
 };
 
 void xgbe_selftest_run(struct net_device *dev,
-- 
2.34.1


