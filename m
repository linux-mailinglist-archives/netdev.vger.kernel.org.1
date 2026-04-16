Return-Path: <netdev+bounces-279168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FYcCOtS4Wl5rwAAu9opvQ
	(envelope-from <netdev+bounces-279168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 23:21:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B34BF414E27
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 23:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD97630385B2
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 21:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78F73203B6;
	Thu, 16 Apr 2026 21:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d2B7XU4x"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011023.outbound.protection.outlook.com [52.101.52.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C636A3932F3
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 21:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776374501; cv=fail; b=EplEJ4GUlbjCN1hX5kQQ3u6w655/f6pmYekLlaJDGBr5MPnogip1Vtvezhdyy4t7iBXGW4A5F98Rcl5rKxHO3pvgopTrbvuZ1gR2VNY/ITJi5tCGivpY4DkrEfUVTkfpyu7z4kM9WCU6z6fufd2TJUOe/qr3Mtns/eIfoLKx4mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776374501; c=relaxed/simple;
	bh=4a3hmTQFyE36ckXbgjHFhXQFj5HGlVqg1oYMJIaQy10=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CGnZIBS4UDxE+di2OwtY/ci6pGYBVws4bP8WSAOrby8tilNfKYW8+Bfy4Q0qAerovBL0ZGA3eiYfbvJxDPJMijVND7CMnIEK90kXEdCD0Y39zDURJtQhh/TbiZpOABK58ojsGMcosX9cWOlij4qIKZ7fLC7UUvVezvB5MQN8OnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d2B7XU4x; arc=fail smtp.client-ip=52.101.52.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wzIUnIwBfu8Fv+rJ1jBoVt3Au/o3+1D8eDoFVHVuPCJsMRLcRA+OP1ko4n/jSkmOQUEvocEssQ/emnJGvDxHAQFDpAiodqc0ym08JxU89k7ai5LjF5T/i3LR6FheLQTofeaYFlCrRJeO8D9dsQV9TFhX0HpZdXlbA8D1BrWvYp8HZUIsaLhkpGDRbH7pZpRPbZixL35LxbueYOwoCW46K+92KoiRhCGwyJ2mCku5/E/YzMx0lgzNI/D0QxGEljfTacY2LBngH4tGjwUCptE+nFIwyiSq1yYFl6uqLSJAU9ZT32EXH6yjCY8fSwoAvsM78KYAZnugUBZ+eUywdk7tCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAkPZzo2PvOb/6st3VweKrMEVRA5KljFUuigz+Q+eDU=;
 b=ZtHxdTWr1ChLpnnKRK/nlB0KI3CdWenGaC5D0DeCVuy0TA5tNJxUfHbp7Y0/FwGBV74ExjRB7aceU57o4m3GMfk4TKFmHEpVUMjD08qX7IJ5WHzdbxeR54gEPtPgNABecz+04hvBHdk9a1fZzOsLSm2T/QzVbaoV/V7UfJFChVOa+cxDgArziVJ8Xsslpwk+EHHbqpRhefWUOuuYLzeolQ61V049EhnMV1qXOnhwLHEHmY3Br7Ct2CJT3uJukkMNfr1j0GuiaE4FsoMBnzBH2pwWvt80uKwv1lrwsqY5BfXkuQXYp15rgoi+klSY5j7j+8/7IQIfagdu4w0+t4TtLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAkPZzo2PvOb/6st3VweKrMEVRA5KljFUuigz+Q+eDU=;
 b=d2B7XU4xIjH3QWaTz5TwD7QymF26rNILbs9I1a0cmbMbxStmy3b47HCQzd1zgYwz8DRfzm1bRRFloMDSv01Mcw+xVS6gfhGSbtB23B3RqYLoqXeZcHam35pdZCjHUVzp/ttbHW7SLqNu8ZIL4sUwmyvd6xwMtW6tA29F5gzZbS8=
Received: from SA9PR03CA0021.namprd03.prod.outlook.com (2603:10b6:806:20::26)
 by DS0PR12MB6557.namprd12.prod.outlook.com (2603:10b6:8:d3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.25; Thu, 16 Apr 2026 21:21:33 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:20:cafe::8f) by SA9PR03CA0021.outlook.office365.com
 (2603:10b6:806:20::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Thu,
 16 Apr 2026 21:21:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 21:21:33 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Apr
 2026 16:21:31 -0500
From: Brett Creeley <brett.creeley@amd.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <brett.creeley@amd.com>
Subject: [PATCH net] virtio_net: sync rss_trailer.max_tx_vq on queue_pairs change via VQ_PAIRS_SET
Date: Thu, 16 Apr 2026 14:21:21 -0700
Message-ID: <20260416212121.29073-1-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|DS0PR12MB6557:EE_
X-MS-Office365-Filtering-Correlation-Id: 051f0f9b-259b-474d-9bef-08de9bfe2275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	amBF/PpnwnP3T9UjPibDOPlsxrQD+oCvUp+IFPQJWTI0DXxnXYkrNAkSJWZjaUPc0Fp5FJdTThhoLpbNFxN5N2qzUFyWua3XVvs7rdi3oGuMZSoK1Bn5irP5Z2ttBDYeuaTWPZHRAAuJ5GhCaU/DPi6mRsmnHG3puaFZ7+pmXu36dlstGwZDNVrx6mGRoifgI7TLbBpWxbS302cYD1XY1vsPZNTLOeNXq0l6Kbzq35Gqdyfjzx+SvL30FwQRm+CWCJGyLutreYkjm1ZZV7uzOX3qw7UO0LWFYHEby7Sviy5OUQE9HZ3VvxCmmlUa+3+uWL3gYIH1hAuYzHfTQ5y6mIE/4BSKKeZXIVSgowp2dm6g0xn5tiEGsa7p5VS/pEi5HeLu7U9KWLzn6AyA/MgOFmvG2/T8UVxDPUYzOk6xSfjCsvQ+QZwynz1yDetBhbfddjPZ/taz9Arc1NfN3YhrRMTFhjK1G9FesNeXCzhnUmqfzKXR1x+DZcGi8alqh39okmYO9re17FTr+WxXvvJybtijPer9wfZcJ1X0QWOj5WsWdbV6LILlIc3Fndkiv4Fl6Xm6v7zVXdjyX7OZ9IrBNpid+fgLpLCVgpaWYTFKjUBKgJC/7caV5UD/f3nMub7b1IN3shXI+gN5yP3ohVyiVVmUhgNSc8tUtlEV1NOah4+V9z12bvqqa1MoC1ZYUCvb7FTZMxlcnl8eI2o2eujBygL2tGKrJxsQsV+73mJbfXAVL6KoUxaIT3+nU+lSxheXQBhvEaQLzisGXrSooKde+Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mbPVJ3K0+t0zbLh8JMfXkStMDwa3l0eErsMhIW6vYLzsV4AShNGuhF4o+xW/VQE+M/dXF7sO3416ieq+1JDmreYXx4WoC5LPaNjZieea9kTtviSAvogibuj1tTY3Gd0nzI2Fgyxd42Mds9c3L8Fgcw5VQwZmLtFcZNaqdiJ7oC3sZtGqt8XCijWftX7/0BLyWofuQusbbmSehY+Zyzndn9hj3ju4hCd5t8SbgB1GWAsand1R/09OJ7XmuKYptC3i1t4CAwXZfpaEFQ+2CddFy0mB7RneuHGOBx6L4+1S14vbeKMytQiKFtlP7rHX1JLnHYa/C8TADHLTJwpO1R3OIYZ6YzTHWpGN0hWH3z86J0LiIBL4xphnsBuI9lMtwdJRXaKJOULBGt8gUUT7ZlZA8INYR0ynAICc9YhFkNmrhE+TwvVZ4Jmt6BgLItS5Xy6C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 21:21:33.4644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 051f0f9b-259b-474d-9bef-08de9bfe2275
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6557
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_FROM(0.00)[bounces-279168-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[brett.creeley@amd.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid]
X-Rspamd-Queue-Id: B34BF414E27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When netif_is_rxfh_configured() is true (i.e., the user has explicitly
configured the RSS indirection table), virtnet_set_queues() skips the
RSS update path and falls through to the VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET
command to change the number of queue pairs. However, it does not update
vi->rss_trailer.max_tx_vq to reflect the new queue_pairs value.

This causes a mismatch between vi->curr_queue_pairs and
vi->rss_trailer.max_tx_vq. Any subsequent RSS reconfiguration (e.g.,
via ethtool -X) calls virtnet_commit_rss_command(), which sends the
stale max_tx_vq to the device, silently reverting the queue count.

Reproduction:
1. User configured RSS
  ethtool -X eth0 equal 8
2. VQ_PAIRS_SET path; max_tx_vq stays 16
  ethtool -L eth0 combined 12
3. RSS commit uses max_tx_vq=16 instead of 12
  ethtool -X eth0 equal 4

Fix this by updating vi->rss_trailer.max_tx_vq after a successful
VQ_PAIRS_SET command when RSS is enabled, keeping it in sync with
curr_queue_pairs.

Fixes: 50bfcaedd78e ("virtio_net: Update rss when set queue")
Assisted-by: Claude: claude-opus-4.6
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/virtio_net.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index bfb566fecb92..f4adcfee7a80 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3759,6 +3759,12 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 			 queue_pairs);
 		return -EINVAL;
 	}
+
+	/* Keep max_tx_vq in sync so that a later RSS command does not
+	 * revert queue_pairs to a stale value.
+	 */
+	if (vi->has_rss)
+		vi->rss_trailer.max_tx_vq = cpu_to_le16(queue_pairs);
 succ:
 	vi->curr_queue_pairs = queue_pairs;
 	if (dev->flags & IFF_UP) {
-- 
2.43.0


