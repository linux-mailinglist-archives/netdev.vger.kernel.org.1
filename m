Return-Path: <netdev+bounces-272426-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALKJACo1xmnzHQUAu9opvQ
	(envelope-from <netdev+bounces-272426-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:43:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7008534092C
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CC9031C8786
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6EA3CE4BB;
	Fri, 27 Mar 2026 07:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2WpDUwjm"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011065.outbound.protection.outlook.com [40.93.194.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A942C3CAE92;
	Fri, 27 Mar 2026 07:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774596786; cv=fail; b=DEFYBxObpm81/WB6oYXoSqAWy8CfU1i0d/wL/lUso/GrDoNzjNOVirTQqs0LJIFQfZ41WSvknoKXedaQfKBrWVAU8/w3a0NWv7nOChf/GYaB0MjuqJka1jRwqe+7Iy4SpJRKhdMRxHrfoKP7VtONYz1E7sII/a2SQr2/h4URgsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774596786; c=relaxed/simple;
	bh=PR29UusheEhjgdMFXewc6vKEobvnl4U2zRUkQXcwAj0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XIZ7wfmWZ27yFEa5WuMQ3j9OsBnjywFsfdEuk+RbjSgq2cEasE/Hmh0xG1A7eYk/eFekJNlz0yLQt9MoZgD/lp2i122zIo1U3QdD/6PYZpiu0gJjETkiY3mbqRmUCMDxKU6nnEUJbJG9d4HAze65S/bNNpK/14dDQstJs7rKhNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2WpDUwjm; arc=fail smtp.client-ip=40.93.194.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXw2ILzz3iZ5iorojttMyWV2f8aTMpSS2Q66rzOmf4iw70vDsRNbsJRgyL2h6KTbdGqNCu9RMVVqe+ub8NWNHn8ISPcAqzR38lxkKwsW8MQdOhjzGa3PBB8UKSVt6SHCKNzF9v9rd310VDIXTJkzmuNL+D+9bCJIzbS4de5/cRtlJHVe7dF9OaaiXuU5WR8KMu8z+eFZ6YsvX3CcBMpUsgI+dJVwfa3dWcULa7ipeIDWaTEutvl0zoG1hHYTGVzDW6ELiHEz8mFI0xkLGhcJRTi3XhLGmC35u8QAQxB3hGD44n3rOrvOP1YaOJWWomLDNZuFM+mWv7zlssY9hs9WKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VC85UOnEP/F1UA3FXphBO2w0JLE6bCasqOG9OEr+Z1Y=;
 b=KmS2flu83A21hkcXi554fD5pKQS9PbcCYn6LNmLlfj0Lhd1ZzhVJAlXxA7oWkekEtYkEEj8nL2AmVA6PbhrGR5IaDqam1Szvio8Bh08y0k/odJTl6Suilq/31YH+fHUsi+joTNXN23g2gP1QtAnY/gnBnID0vTsDfWIhWKzU7w4OU75HXjAT79dGxpc2Ul/d2goqEvKS+t+2LXwf/v/6UWw0j/a7j/3qFKMuAgjo0YfrzfkvE8KQ3cb8nfZgT5F6V70/HfcUMcQDB7MUjPC1pGy0d9gv2Vni0FdzL5r1z8zvDQDGwog35fT3vfFsw3ndyA+X77/wYEXUqycUeZqFQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VC85UOnEP/F1UA3FXphBO2w0JLE6bCasqOG9OEr+Z1Y=;
 b=2WpDUwjmcVVdrFys4MAMfI4oyWCLA5D2GfNwD0gmHNBKmv5xx1AlitrXJzn/9k6rO9EO8Pzt1fEfvJJ5OBFtAxZkppUDSHqW0pXp8pBNMML0gaXlcPytnWJzpCMzIUgkwa2B4YO31PmfXz8sMjQkrQIvH+BtpBQsE53aHeSZNz4=
Received: from DM6PR06CA0046.namprd06.prod.outlook.com (2603:10b6:5:54::23) by
 DM4PR12MB7528.namprd12.prod.outlook.com (2603:10b6:8:110::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.10; Fri, 27 Mar 2026 07:32:56 +0000
Received: from DS2PEPF000061C3.namprd02.prod.outlook.com
 (2603:10b6:5:54:cafe::c9) by DM6PR06CA0046.outlook.office365.com
 (2603:10b6:5:54::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.23 via Frontend Transport; Fri,
 27 Mar 2026 07:32:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C3.mail.protection.outlook.com (10.167.23.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 07:32:55 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 02:32:54 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 27 Mar 2026 02:32:51 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Michal Simek <michal.simek@amd.com>, Sean Anderson
	<sean.anderson@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, "Ariane
 Keller" <ariane.keller@tik.ee.ethz.ch>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net V2 2/2] net: xilinx: axienet: Fix BQL accounting for multi-BD TX packets
Date: Fri, 27 Mar 2026 13:02:38 +0530
Message-ID: <20260327073238.134948-3-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20260327073238.134948-1-suraj.gupta2@amd.com>
References: <20260327073238.134948-1-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C3:EE_|DM4PR12MB7528:EE_
X-MS-Office365-Filtering-Correlation-Id: f7752993-cf1f-4d1b-b1ee-08de8bd31014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|7416014|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	wSTKA/ZjM2UaX7kyv86i7Ss1jH//TvDjTk6LcZZd0Q72OR8JbwJuJj7ZON9T/rAd4ZFIlINpr7zrvnzmdhQkj2/YGUzgV8qSeBwdGHKmW7huR5TE1vOw47cxp+JTXAXZCj9xHmXUGUC1Vgeq9kLVJnW6EvIxFoxICmZlZgwUH0R2SzumhowxfajoXzxrB7idsAffuyNSsAouQyx8/qYCm3eVANCVOd8v/BXHS2QAdKNSw3RxPu1cc2TFdTk9Ii/6YgkSDzPli/AfCBQWDvScBtCtWiYxhozs9SYlvH6pKg4Ai1/5s2wZ3lSOFgmIQY6mpxwyO+Oa5RqTYSx8pTAXEouccNSkE1WQp7kg6bacVvfMu1X1NXSWy0+xnLYvcz6m861YzVFs7t9rTk5y6j9aagpU+YTIGma9l9BbECAIKzkIAhStMYuY9JCRGvZI0rpefQ2HZG5FRJVBOUYdWZl+oXJ/o+wevWWWgcL3lzb1ydYvX9h/poSan9WqXu1S5OfzEvuAfB7yY43gkH0PSjZz0Q3hRRGxcDAp5LoeyKuqqcggoS4RzOWRnENtp6zWg+NIlXmj4mxnp9ka6/Fz0QFepvNjYS2guPzYtrhqwCgx6+w7dKGFYGxyRbuT/thADli9GuwBDJhsbGy/aVhHa3SHMSuDPVvdZibnRfWjcHMospvAsgr0HumWWEP9HWGgMEVRBOHGWnVoofFLfcDXPzeOwRi7O5CYcNx5nfNTyRq4TxUbv01nejkMAJ1FNdaswXif5DQHQ1Oct8zcSLWQfbHSnw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(7416014)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Oh2iELBvam6P8B9+WWIgaSwzXbwtGkb1TSaL6y3oILeqvRQiis+tRUi2iYIYLx1a7YLX7mG44SY3kfl/TDZXFYSzoXfUGpAQatex8XwBikQWbrXz87DIMN6RQzTtjbrosjaxQl7VC+4r8EbVaSvWiOL9Vydf7jRwk7IwlMRl0Ef664BLSwEsZylNy57/bLu7Ib7EI2oBmlRn8Ow4rsl0QbHukUh9uU7MjXS1Vt93Ft7klJ2ZWRJgBh0rtvXp+DepzQzMKjlYiockRE9IiNYqDBnIZZ2XYAO8fNLzBEqYW+BIMwHswfEJjAxx2+Pkk7cr4S4CCn+8XJ4TtEw5heGuq26xsEerbUbvnAwBZXwcMl7qQh8TsXXdOVtnMGEI6cxKLh8Aa4Zn6AQ1lgjOx2eXpxznvQMSYXlcEwbZxQGLIdy4zo7wtHPYkNGXAeSNtz2G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 07:32:55.6589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7752993-cf1f-4d1b-b1ee-08de8bd31014
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7528
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272426-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[suraj.gupta2@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:dkim,amd.com:email,amd.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 7008534092C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a TX packet spans multiple buffer descriptors (scatter-gather),
axienet_free_tx_chain sums the per-BD actual length from descriptor
status into a caller-provided accumulator. That sum is reset on each
NAPI poll. If the BDs for a single packet complete across different
polls, the earlier bytes are lost and never credited to BQL. This
causes BQL to think bytes are permanently in-flight, eventually
stalling the TX queue.

The SKB pointer is stored only on the last BD of a packet. When that
BD completes, use skb->len for the byte count instead of summing
per-BD status lengths. This matches netdev_sent_queue(), which debits
skb->len, and naturally survives across polls because no partial
packet contributes to the accumulator.

Fixes: c900e49d58eb ("net: xilinx: axienet: Implement BQL")
Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index b06e4c37ff61..263c4b67fd5a 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -770,8 +770,8 @@ static int axienet_device_reset(struct net_device *ndev)
  * @first_bd:	Index of first descriptor to clean up
  * @nr_bds:	Max number of descriptors to clean up
  * @force:	Whether to clean descriptors even if not complete
- * @sizep:	Pointer to a u32 filled with the total sum of all bytes
- *		in all cleaned-up descriptors. Ignored if NULL.
+ * @sizep:	Pointer to a u32 accumulating the total byte count of
+ *		completed packets (using skb->len). Ignored if NULL.
  * @budget:	NAPI budget (use 0 when not called from NAPI poll)
  *
  * Would either be called after a successful transmit operation, or after
@@ -805,6 +805,8 @@ static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
 				 DMA_TO_DEVICE);
 
 		if (cur_p->skb && (status & XAXIDMA_BD_STS_COMPLETE_MASK)) {
+			if (sizep)
+				*sizep += cur_p->skb->len;
 			napi_consume_skb(cur_p->skb, budget);
 			packets++;
 		}
@@ -818,9 +820,6 @@ static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
 		wmb();
 		cur_p->cntrl = 0;
 		cur_p->status = 0;
-
-		if (sizep)
-			*sizep += status & XAXIDMA_BD_STS_ACTUAL_LEN_MASK;
 	}
 
 	if (!force) {
-- 
2.49.1


