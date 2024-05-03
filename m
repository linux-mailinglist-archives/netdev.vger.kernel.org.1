Return-Path: <netdev+bounces-93360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6118BB4CC
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 22:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEF0FB210AE
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 20:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BD51591E6;
	Fri,  3 May 2024 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gl9jiinD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904F7158D99
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 20:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714767914; cv=fail; b=EYPpj0PV5X1j+gWVUlYbfHv3v8xwFQ4Loo+QWz5D0YBJ+W7CJgEZj/+FYr1Er2SrV/CXeUfmNNhBijnTboBFvkuO4vIh/juRSphtGeV41LYE2R+ghaP6PMYCThnrrY2AzjqSCOi/tTu3I8W0LDugUMv4331mQKFZBnCwLGGA29c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714767914; c=relaxed/simple;
	bh=FR4DqlrFPSKTlk2ibZjIDDAigCDunNQxvbL2X7+5RnU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X4fCXbTO/gv1xbEQyq7QZ6qXL94Ji4ePbruq40WKiZm3jfk0Mr1B74GwryfNHqGdYNlzOh9OJ2p9u3JPz3/w/3QXFktcmrEqxvPE1YeAiQdw46F/kEesHRiRraBia4lOrAulZikFW/DDex9BQvfi6wL8ysT6vbBxKlzYry+OymU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gl9jiinD; arc=fail smtp.client-ip=40.107.102.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODFB5S9Aun40T2QxWaUcQv6Ovfj+Y0EQNVNopHpWb5rw3nim2r1h/aElJumnnBvTTAtAu2WrvSqi3slfaJtHElAtoZKqo7KO6NfVVhy0oj/vuCbF+Iz4Rl+Os8DZkNj/xOxvbl0J2dvIZPRg06LCX4ag3SCrBbKchp/yAojmQJKVuPWxkd08SKNhtkPmqYf65Lne+FjoL//LjPlV3BL2eBkY9FAS9Z4UZEv6gRywlwRqYnIXNVuCGHfEN++geUGjIOZNxyRHoNIqZEchk+Z1+yaEtFUoUorIzQh0bToCdB+Kk6Ng8jMj5dcYx1AV3QyBnFDkcbIYvLEnDPyOGVrqQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+LYEJS4WLRU7WRlBelprBuxLSx6dAQUkrnajZX5zuQ=;
 b=lrxvixRN2F6LTvToVOqGIwN6DG3jfj1t/DvmppLtF0FOJam9BwzPRK8W8E0l8CnxQBYqQscTAT2ORwJ37q5KMe5bwrA0F3cP791rgDezb4fmu2Uoo+ueTWkRCwLiI/TYUfo5QYqJNlEk1imLn1i6wzmS+V2wRHJw/JBb4yiVx4+k6cmop5XQR0m11S71dcbGY6LrZcFeskybZabXUTd99gYOD+rjL7EsmQIB9SAKv5adAnLp4kHtYfxv6qpRACiO6wJaTO3brqAEcu4XPP57LiohIpkTOahMU9iooW1Z3kxQuuGVONwsMTvKv6pz4oir1MTqxrtcHnioU6+YIIdaiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+LYEJS4WLRU7WRlBelprBuxLSx6dAQUkrnajZX5zuQ=;
 b=Gl9jiinDJZD/WvjGX9QHd2wXrCf3uPmBkUODR9+/1k65hCBHj807gzlzIwtvOC/8OE8QBGGAf9pj7/HthFrh8sXIBM7icSoD3S8fipL7oWD8oAgR5bgCnp6IZAYoauYO5X2yIusszskDlJRHMtv57YmGmyjRWnD5vICAr4niz3JRaYUQBmHe5XgvnYCGdIcACCzXqIstauOGI6B3Oo1ze5hm0TjXge2z5Y1D3P/I8H7h6sXNRAfMpX2HEy4spSZwpa5YLLMVlPRtingvtkLhQHVJpdv+lx+i9v1Unc8nnROskZpugqNBRuSAINAQg5qWKloPX57ivmIXJh/36el6og==
Received: from BY5PR03CA0011.namprd03.prod.outlook.com (2603:10b6:a03:1e0::21)
 by PH7PR12MB8426.namprd12.prod.outlook.com (2603:10b6:510:241::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Fri, 3 May
 2024 20:25:06 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::10) by BY5PR03CA0011.outlook.office365.com
 (2603:10b6:a03:1e0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.34 via Frontend
 Transport; Fri, 3 May 2024 20:25:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Fri, 3 May 2024 20:25:06 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 May 2024
 13:24:53 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 3 May 2024 13:24:53 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 3 May 2024 13:24:52 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v6 3/6] virtio_net: Add a lock for the command VQ.
Date: Fri, 3 May 2024 23:24:42 +0300
Message-ID: <20240503202445.1415560-4-danielj@nvidia.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240503202445.1415560-1-danielj@nvidia.com>
References: <20240503202445.1415560-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|PH7PR12MB8426:EE_
X-MS-Office365-Filtering-Correlation-Id: ea638019-28d1-41c1-23ee-08dc6baf1ef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YpABm6eMhORnRlUqT24nUfELacXOvYF2GxmhzvL5iTCjE48FFESH/manGhGD?=
 =?us-ascii?Q?uCt5lXGM1p0Rf89iH4fA11yMf77EJNKf8WWTPqESYP5A4c2WS/3j+ocREKR9?=
 =?us-ascii?Q?Z17wO/7p54VatX7UcLIa9uq/nXx4j2nsWrNZAFNSUhXIxorGmrCY/+9RIS3c?=
 =?us-ascii?Q?kYGEKGDGqdlQ8Dnu6i2klxtDAiocBUchtpqPyJdcoUu8CRKlqjwZjomGrbpj?=
 =?us-ascii?Q?pKryp5B2T+rJNdTtKdF82U9WpINlZshIKPCvA7xnz7Ismn3wgPNOFSjjf4jj?=
 =?us-ascii?Q?z6N6VtJnviwxSGK2hZ+tkeHyjl4wHrmQRwy2AhWb/7HBNfc2wRQlSeYa3CNZ?=
 =?us-ascii?Q?xFPvHi7qLrOm6aRFywpI7UvFavDgzOFjFTcijMs+l+YeYck51CSaghiiP9gd?=
 =?us-ascii?Q?cIRhkBRH5ekzft3wQEe4llxPv2jre3RU9TNyzP5NZOrr75GosCatMiLVTMbU?=
 =?us-ascii?Q?2PAbDe5xDczoecDfp7/5IDF95quoH9vzizD2zYc8m5sq6Emo6EZJWh0/WrXh?=
 =?us-ascii?Q?VVTplVnMNxfxUlzesBNUePOSpIhsA/X8PkxpO481PW+why/KexfvCfnEt9bC?=
 =?us-ascii?Q?8DEMFSIKYBHcjLLCU/kFWTePnlXnksN7Mm0hw6Nsb3sdic/TkLnqz7fpaED5?=
 =?us-ascii?Q?CYMFkKro8Db/296zhxNYgU618UcH4cbEta3B12Gy5OvCOnf3Vit9LdKHChSB?=
 =?us-ascii?Q?Pjd1SLsMMqHgqPEW3/vMzdWmEJ87GS8dfzsTv/pMU+cyZR9saxK9/MI+pNBl?=
 =?us-ascii?Q?rag7OiY/KfFjTztQ6acC/Gojnmt7zrBuHEWbJbjiNIshu3R+JqNa5htm40tK?=
 =?us-ascii?Q?Gv6qwSpFlyHNW9rJHE9CSs+63PfUqbvEsbZXi9bzx/BCy9LukWev1F8TKdfp?=
 =?us-ascii?Q?DRvpHwsiA7puVqISlpF/Wyh0T6fEC+h7uA79I0bXUcOW8XUVBV3iyPQAEo6n?=
 =?us-ascii?Q?pbJBQG50vn+pPZQdj1XQhXXwott94+KbTLwbARVktctiaa/Zwsf7I3FL4vpF?=
 =?us-ascii?Q?pre3HtDItr3GkUdhoKcixq65asG/wzPE6IAm8DgvJq0fQLaf3HVkeIUTOSSj?=
 =?us-ascii?Q?HmQHKQSVWL38w1LTcaDG3Km9MC7ZDCk5In5ZoALrowFJT8H8HN0j+F9LLihC?=
 =?us-ascii?Q?85WDo9tqBYB8b+RqJNOtsxqXsy6cmWBLF1gigDTR4gyU5vx+NkSoH3Cd60ys?=
 =?us-ascii?Q?7/stZWoWQ7nm6j7yYACYF4S1FNMOCDbCCEYfYrXikB9mxizMVq5aC4YNL3iU?=
 =?us-ascii?Q?3zlhYOeQ2Td+L7Sohapxs7usL2aB/9eP+sXRf/cs/1LD3wYkLuz7RiFRA1SQ?=
 =?us-ascii?Q?uYY9XO1cr/dSbmWMezDvP4A4AZ6Z9Xpity54H2BrFG1d7Yn5TPaDgxWS592V?=
 =?us-ascii?Q?it+lBhq7ZLRZwKGR8H2zdnr30ho0?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 20:25:06.1595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea638019-28d1-41c1-23ee-08dc6baf1ef4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8426

The command VQ will no longer be protected by the RTNL lock. Use a
mutex to protect the control buffer header and the VQ.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/virtio_net.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 451879d570a8..d7bad74a395f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -411,6 +411,9 @@ struct virtnet_info {
 	/* Has control virtqueue */
 	bool has_cvq;
 
+	/* Lock to protect the control VQ */
+	struct mutex cvq_lock;
+
 	/* Host can handle any s/g split between our header and packet data */
 	bool any_header_sg;
 
@@ -2675,6 +2678,7 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
 	/* Caller should know better */
 	BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
 
+	mutex_lock(&vi->cvq_lock);
 	vi->ctrl->status = ~0;
 	vi->ctrl->hdr.class = class;
 	vi->ctrl->hdr.cmd = cmd;
@@ -2697,11 +2701,12 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
 	if (ret < 0) {
 		dev_warn(&vi->vdev->dev,
 			 "Failed to add sgs for command vq: %d\n.", ret);
+		mutex_unlock(&vi->cvq_lock);
 		return false;
 	}
 
 	if (unlikely(!virtqueue_kick(vi->cvq)))
-		return vi->ctrl->status == VIRTIO_NET_OK;
+		goto unlock;
 
 	/* Spin for a response, the kick causes an ioport write, trapping
 	 * into the hypervisor, so the request should be handled immediately.
@@ -2712,6 +2717,8 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
 		cpu_relax();
 	}
 
+unlock:
+	mutex_unlock(&vi->cvq_lock);
 	return vi->ctrl->status == VIRTIO_NET_OK;
 }
 
@@ -5736,6 +5743,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ))
 		vi->has_cvq = true;
 
+	mutex_init(&vi->cvq_lock);
+
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MTU)) {
 		mtu = virtio_cread16(vdev,
 				     offsetof(struct virtio_net_config,
-- 
2.44.0


