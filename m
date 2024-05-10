Return-Path: <netdev+bounces-95580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E29A58C2B12
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 22:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89E21C21B43
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 20:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30964DA09;
	Fri, 10 May 2024 20:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IswBs96Z"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043C64DA13
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 20:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715372412; cv=fail; b=XnTp/md8bC4+oWelx8Rer6Y2abHvt+baalOlaSDJT4wZ/ixgbZfVZfyAlqVu09Hx3nq0v/HRAXaBm6am6tGzFFwIkAynBtg9erfiVLDmRwz7NMevbKxZt5cx1bj/CL5hzq46sH7nzPf+HmKkFlpDJ039tk9IEgWbRvySPzvalMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715372412; c=relaxed/simple;
	bh=XZyKxj8wyPtk4gZF7RgNKU6aBJi/k1Wk9G6+0DgT+QM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lntKsYP+85Sb+3in59svc5jJH5EDPpHIDj32wSRoBZn/6Ocnw870GwPAfK61g4no7r2FQ2SZvLhwPXDphayGntSr4X7lsCXHLSuJqQdu/n2ae7ArhdBR2uZptdBQzyjhaOppNxsqqBA7QZlCG5kxHDH8BgLsEqsminYTw0pmE2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IswBs96Z; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egR0+ddiM+FiGrnyjXKpXPZ8IwLdRibcVb9ff2UiAwSgRRvRta6F8Jn1XWj+XMmVHJQdPMtUGT6hElMGYh7gCDh2weiIbE8T1GA2geMabokW9EcWh0t2SBS7Vxn35NvdTG7yMyUDsR2AWygp87b15wmbsBZIaav2KFi4FCTdHN7CgU5BliI/TGJEdG2B0hIp2br8gi9dgdLE8sGG6RdOOwANgw16yqi+WNmSsSlzIzIlkmzypwZsTKZeNYaKEJZzvKNM2RMzB+APc1ELp3Gw9hlwvTySSTTTTEhcUcS0b+OVm8b0XHeVtQ0ENJ+O/ZcX5Z6b8ST0XR7dlxJYSy3mFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEgjrIZxDvrzHAtwJEwyYQ6KjX7VQQYcLtK12m5JJxM=;
 b=Bn5htB7yuV+6jbReif+DgTImvnncqqA9UaBI6trJ7PGRrHeW/+MVSJunjcEz5w0ONFensKpeBffEePEs6DSoymqJiz1h6yPIO9KbrbgWg60ki9uLBg7petJRwqpMDUF0Ffj8lJMMbDIBLVwJl85YFdvDYq01i2nsO/3Y37W6tr0ooOIk9Gf6T3ikXIQVVRw2o+djM0iTtzYyafP8oN+zpDtbRZ9T74ONEV0e4egVN+tpetjMg1nnSx+u3ZP+4CA5OZhy5MfrpqdgtK3wOKT7ZSul71DsYVzFdtR66n+wxSHjieWTto9/xpw5H9GBfsMaVa0OM1gHxLILYfklPkv+gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEgjrIZxDvrzHAtwJEwyYQ6KjX7VQQYcLtK12m5JJxM=;
 b=IswBs96Z+NTSmDMbL3Gt7J7z6mPT2vP4oY6skwPCWfVy+wUZJDhGQV+vZjEAXDXoah3QruSuetNhthODzrnBore2ITdgRmjYU2MKjsSO6iXFw4F51H2sSN6K0R8YhMcD8qce6Hx3DglJ64+4aFm7P2iLZkE7nyq9123lIvpt6w5nYuQT+OjwyVogTDI5iQu8YgScFQzYZLFyuvoXbMaFMumat2uT7Yxtk0jlFAxhGWGxVqPy7D1WvuPln+Nv7Kmxp1Ob/bKVfWZRcOBA+LeWGg9R2VsYIPPAOeo/2uV8wvSoAEPTy/V0jykOaDeRrD/+x8rRp4ceFRJkSXI4WtSEUQ==
Received: from CH2PR07CA0040.namprd07.prod.outlook.com (2603:10b6:610:5b::14)
 by CH2PR12MB4104.namprd12.prod.outlook.com (2603:10b6:610:a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.51; Fri, 10 May
 2024 20:20:07 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::ad) by CH2PR07CA0040.outlook.office365.com
 (2603:10b6:610:5b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Fri, 10 May 2024 20:20:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 10 May 2024 20:20:07 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 May
 2024 13:19:49 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 May
 2024 13:19:48 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 10 May
 2024 13:19:47 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v2 2/2] virtio_net: Add TX stopped and wake counters
Date: Fri, 10 May 2024 23:19:27 +0300
Message-ID: <20240510201927.1821109-3-danielj@nvidia.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240510201927.1821109-1-danielj@nvidia.com>
References: <20240510201927.1821109-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|CH2PR12MB4104:EE_
X-MS-Office365-Filtering-Correlation-Id: 842f8dc4-120f-4ca1-26d9-08dc712e9607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uGXZQ9IqWtLU1+n+A8mxSliHv5/aai5gTInGN6bExZL1mWvEf6g0j7DkpAjy?=
 =?us-ascii?Q?5YiFGywBer1Q3Lwg/JI14GafX0rV904Nm7F+jBLbYNrbuf4sD0fZnqO2OUMi?=
 =?us-ascii?Q?AGGkRXbVH6PC3YemZEaJXZ1MJNgzuYT7FNyVC2wl6zkUl6YFv6w24g+1l9ng?=
 =?us-ascii?Q?suMCDRopNh2C1J80J7nv6GOQUN2Oummx1oAHUz6PnKbcfI6MqaDKXhtMSHB5?=
 =?us-ascii?Q?wnBpn5LstoX341texbF6Lyfu0wmpNFU8ApV40DSfwwrmYpLUPP16LVQ5raWl?=
 =?us-ascii?Q?Qq3ldO3kODtVL9QD4Q73lGDQQIryLFfW/j3z+Q4VjxUv0VOrEDikqqqIhjVv?=
 =?us-ascii?Q?jgV/gUTZS/EY5Nmsc2y0jQf+etCIWSdO+56B9imlnh7pMybyiqKBfWfXE0wb?=
 =?us-ascii?Q?D0ikhOIAD7kxS9WNV1ZQNnTQNN49EHKG2VFpNIJ4ejOO6D3doRgqSXB39AaI?=
 =?us-ascii?Q?PVCtF5DZ9ejt7flcq6aqZJKJSod0f5ItTdS/lvzcBCvo2lOXttp9GVAdC3O/?=
 =?us-ascii?Q?2z1lwK4QPXxoWRVgYb4zs13kNA9ko6a3PnxDgPP66vEZPZM7BKvs1nqyCrgL?=
 =?us-ascii?Q?2ztmAQaEfMwdED+KZXz5VwsFKapDH7MxBRF9c0k6Lx9cs/dd6r5Etx75ZUAT?=
 =?us-ascii?Q?f5MprID7N5vBDHK/wom5aNrMpAADXs3Ec5cXEGLdDHxeK+vPK12brLj7uoAI?=
 =?us-ascii?Q?gUo+Db46Jac7mZ3R8SzvaWddJ3vw6YAW+XxxRWD8pkQy2CvVxXLbkL6q+jF2?=
 =?us-ascii?Q?OMnFdPulQlYa2pJ/8VTHMzK6VhC3PnNqU2iMpisIX09LdrcUC6jEUutuH4EN?=
 =?us-ascii?Q?LiaRsb6JBbHtZLb2z9ne7VQascDXSZK9QweEXuXKV62GwZvKVwiiKlXioPrJ?=
 =?us-ascii?Q?/J1dpz8R4lFHrDeJSe3tvlcUTaHwgnW6c9Te3YDGSMaG+Klbvsm+vLDNQEK9?=
 =?us-ascii?Q?e4UPvJEYFByJcIwxyCYhPSEnbaGwjlPt04FDSJ/uz9GzUN2+vMsPcy8/OglF?=
 =?us-ascii?Q?68GKlcaoFa7b/VBhOfTdQgUDJ/fZiWSTGfAR8vKLOK1ug5GwHV3J5HK2XKpS?=
 =?us-ascii?Q?cTMKp+2zIl4U1R/BT/Lzg93a3UXpST2vDZIewXOV79Cb1uU1D6NEzzSv6d9Z?=
 =?us-ascii?Q?YgXoOQwX0BqJY3UXcbUO/3OU9cct6Q/UuvWx1ipP1puRTZp7PYwVgXFH4Rw/?=
 =?us-ascii?Q?ZNUjpdBc1NK/QvTJuitunYmYWOgT+g/aLxYMfeNVfp+ylr10RuTxW3W60pLJ?=
 =?us-ascii?Q?En/a/F6eFsOUzYPn6DDziKpsvEowjlJqB0UL7PCPRj2xX+0I9BHWeB5BlwQB?=
 =?us-ascii?Q?07yjrv/dhxKaePwspi9oKMBjxKhpRINKLjsJjzsMTv4YsAyhvF6Cx5w26nuP?=
 =?us-ascii?Q?wHnRbOo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 20:20:07.7690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 842f8dc4-120f-4ca1-26d9-08dc712e9607
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4104

Add a tx queue stop and wake counters, they are useful for debugging.

$ ./tools/net/ynl/cli.py --spec netlink/specs/netdev.yaml \
--dump qstats-get --json '{"scope": "queue"}'
...
 {'ifindex': 13,
  'queue-id': 0,
  'queue-type': 'tx',
  'tx-bytes': 14756682850,
  'tx-packets': 226465,
  'tx-stop': 113208,
  'tx-wake': 113208},
 {'ifindex': 13,
  'queue-id': 1,
  'queue-type': 'tx',
  'tx-bytes': 18167675008,
  'tx-packets': 278660,
  'tx-stop': 8632,
  'tx-wake': 8632}]

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/virtio_net.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 218a446c4c27..df6121c38a1b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -95,6 +95,8 @@ struct virtnet_sq_stats {
 	u64_stats_t xdp_tx_drops;
 	u64_stats_t kicks;
 	u64_stats_t tx_timeouts;
+	u64_stats_t stop;
+	u64_stats_t wake;
 };
 
 struct virtnet_rq_stats {
@@ -145,6 +147,8 @@ static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
 static const struct virtnet_stat_desc virtnet_sq_stats_desc_qstat[] = {
 	VIRTNET_SQ_STAT_QSTAT("packets", packets),
 	VIRTNET_SQ_STAT_QSTAT("bytes",   bytes),
+	VIRTNET_SQ_STAT_QSTAT("stop",	 stop),
+	VIRTNET_SQ_STAT_QSTAT("wake",	 wake),
 };
 
 static const struct virtnet_stat_desc virtnet_rq_stats_desc_qstat[] = {
@@ -1014,6 +1018,9 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
 	 */
 	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
 		netif_stop_subqueue(dev, qnum);
+		u64_stats_update_begin(&sq->stats.syncp);
+		u64_stats_inc(&sq->stats.stop);
+		u64_stats_update_end(&sq->stats.syncp);
 		if (use_napi) {
 			if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
 				virtqueue_napi_schedule(&sq->napi, sq->vq);
@@ -1022,6 +1029,9 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
 			free_old_xmit(sq, false);
 			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
 				netif_start_subqueue(dev, qnum);
+				u64_stats_update_begin(&sq->stats.syncp);
+				u64_stats_inc(&sq->stats.wake);
+				u64_stats_update_end(&sq->stats.syncp);
 				virtqueue_disable_cb(sq->vq);
 			}
 		}
@@ -2322,8 +2332,14 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 			free_old_xmit(sq, true);
 		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
 
-		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
+		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
+			if (netif_tx_queue_stopped(txq)) {
+				u64_stats_update_begin(&sq->stats.syncp);
+				u64_stats_inc(&sq->stats.wake);
+				u64_stats_update_end(&sq->stats.syncp);
+			}
 			netif_tx_wake_queue(txq);
+		}
 
 		__netif_tx_unlock(txq);
 	}
@@ -2473,8 +2489,14 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	virtqueue_disable_cb(sq->vq);
 	free_old_xmit(sq, true);
 
-	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
+	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
+		if (netif_tx_queue_stopped(txq)) {
+			u64_stats_update_begin(&sq->stats.syncp);
+			u64_stats_inc(&sq->stats.wake);
+			u64_stats_update_end(&sq->stats.syncp);
+		}
 		netif_tx_wake_queue(txq);
+	}
 
 	opaque = virtqueue_enable_cb_prepare(sq->vq);
 
@@ -4790,6 +4812,8 @@ static void virtnet_get_base_stats(struct net_device *dev,
 
 	tx->bytes = 0;
 	tx->packets = 0;
+	tx->stop = 0;
+	tx->wake = 0;
 
 	if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_TX_BASIC) {
 		tx->hw_drops = 0;
-- 
2.45.0


