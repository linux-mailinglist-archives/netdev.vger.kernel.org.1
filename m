Return-Path: <netdev+bounces-88456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2028A74BD
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 21:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C8F1F212DA
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 19:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D79132C23;
	Tue, 16 Apr 2024 19:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NsLARWL+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4D71384AB
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 19:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713295889; cv=fail; b=hdLXarEdk6dOSp/OcFkKoiPVX6ytz92ob5KiJu/4hrObAhGxZO2wC4NKhlkNLPeEdpgiogdJE98gATav9bPJ/mAwhwu8GjO3TBqPOyjEUo10PUyqqkVpYQC1qKOxGqFfHTmPB8whz9x1B1fTytYGit9zOHkAPjocgugV03021fY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713295889; c=relaxed/simple;
	bh=Ed+1DP3Dbmc+jR6YuNRT6vp48eezl4GxMp90b8lFe0A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TP7/07FUVGjpQZswsZMSh+/q6EZAwUtEUFJ43gS1euKaVra08wpjeUYWg0Nf/IkHSoYkAl7SVZBaLy9P7IfTSEncH89eQ6tKPB/tCk76EqvGS7cjD8TJEMQwCgAmArB/G1902eB2rIKlHtxbx4ysxiOr9ZVxXOoLDiysRbeNMos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NsLARWL+; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3Dc4LxoL5gnatoKePAgfegHSeforC9UEhomMxr1kYSb919uuB4RetXPjG6RVPJlDLPu0ZsvoJwxVo1YmaY7CPKaBFNnnbUyYK0qD3lNtQWUhlsmBnQ2Mo4TiZihBwILep30ZmBjrrOUGAMd4stiMCsw7UiWVkxnEdQqXCbltQwRGkyt9Uv0tub5BXOl2CuaVxpRkSyKqn1yLWjKduOdEt4V8z+0l8YBs+6WqtMX7/yRxVdUY+z/sgUKIxvvxyLGDZaMzXd0sgDtWdbO+hU3/ki/WJwAV0SRL6aJSJS66BjfL21q4K2tkDvbKI9tAbwQ052CGKCIMZyYLty0CFVo9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzZdQFt0EvVPrkyvl4F8hyflN3RXAGqj8oyCegikMM0=;
 b=jnVlxZmOitiq8O/WJWbPR3MJ8gy0GnqeF8kVf+luHxvUbNTePg1/5uNbfoI+tFM9Hzpve/hAlSdABwMeTZVGxQMsdq+K4HcOjBqlwK1mNDUb1LnH+XXLsGVwUrQNoZefxSuDUSBeT3Uq8x9tK6+DECbB829eHOGHjKzYsxRADpCZ9gUgod07mBz0pc3UcIjTP06p74le9FKdcueigKb+rubJglXJT9E8ZTda26nr4Rmjwh7P2ixr9aQjntgdGxq0YQb56grYD7Xk8QYPx4dYTc0Aff1ztoyqpL+6PwcbzqAnyXdDIzAjXY9M1lrieN3H4kNzSBeECrdoVZAsnDhEwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzZdQFt0EvVPrkyvl4F8hyflN3RXAGqj8oyCegikMM0=;
 b=NsLARWL+8hlihNLROkzqKSIz4UuXt9FGfg2LBxcb3kgha/NQ6oQoRaaljxPYgU0DoxmgIWycVmFJIJPbVe+usTvgi/3d+zwYSwXkk8vblOLmzcw+tVa0g9Lmyltl5glsHQIPmVRZGwm0oZu8bakmRwcJF7aD+5kMNCOTzI3cNjiHAcLBHGtugzVwak0ETy0xpdRGv6VwEE+IrsiqW06oQ7lCe+MeCqpbqrU8rUneiovUqqMF6FfRWvr2LUb31DtiDSok29N5fed4zXSDSrj7D7Se9iPZwNLyXk4mdycK/Lq//kmsQWJ4S7JpixhN5WciSJzOTHqrg9i7RB9RhNwo5A==
Received: from BL1P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::10)
 by CY8PR12MB7514.namprd12.prod.outlook.com (2603:10b6:930:92::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 19:31:24 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::a4) by BL1P222CA0005.outlook.office365.com
 (2603:10b6:208:2c7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.34 via Frontend
 Transport; Tue, 16 Apr 2024 19:31:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 19:31:23 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 16 Apr
 2024 12:30:51 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 16 Apr 2024 12:30:51 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 16 Apr 2024 12:30:50 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v4 4/6] virtio_net: Do DIM update for specified queue only
Date: Tue, 16 Apr 2024 22:30:37 +0300
Message-ID: <20240416193039.272997-5-danielj@nvidia.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240416193039.272997-1-danielj@nvidia.com>
References: <20240416193039.272997-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|CY8PR12MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: 003a0626-581e-4031-3c07-08dc5e4bcd35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UW9pVkBxtOa5CSsW+bJsJVtKIxTxlaF5KGwgx5WC0hxDarN1pIpIPnAkoorLaOifATJAuPtX50WTvD/dd2h1x2jtzs3In6YXSv+84n+HQqgdqsF8q0p2yK1Vy28VXuUF35OqDXBUZ1N6VOecu9aX+S2WPDz9iGUYoJ0tLuTHgv8CxvlFJV94RlrwEGgpXQb/lNNFXBybtZjI1mLCJJn5bIeky/AHicQF333QCNEdNz5bHRW3Y1Of7dhgx8a50c8ZX/KsMJImVxnD6tZz9HScyzmRiZ6p90OXj1Qr33ZVA9tkfqq2gLg2ufvVH9N9PO5BJXRdM12U0zqEsnk2mZRJRSOp4LmOlk080yOAsKj17qPfQPaCKQkLxeZ6p/i/WSPzNBUT442KhXWrjFxDoCHDNeKB3rGNzONHyUNYJz99w+xpuMhe4jLN05jDFsgkTvt/FxcZO3A+mWB7butsTbvPnPM84HYG/aw8xzpqmaO8XiVgxdqs0MnYPAPX7Gct+cU/q02vJqZ0GotOLnfhaHqg/e7yAqiWp2I9UoRk61U7equ7T0BZJMlLxIpsWSP6s78ISAa8ARs02DyHDwvMW7bkpf1EeKVYLh919Q4BlqPc4qHH6ragqnty8LWh4V8NOxf7q3IN09ifn0EvWU/m87S1Up3WDbs9Gt8RNcZTDTtk3LyqyK9waHAo8fgbfnuxnTuEIejcdOzgKB/F85SjCSppaHBX7Yt3NlDfiE6XlcrdOEqIL8l2cH8vLvSJ2E+tKXO1
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 19:31:23.6112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 003a0626-581e-4031-3c07-08dc5e4bcd35
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7514

Since we no longer have to hold the RTNL lock here just do updates for
the specified queue.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
---
 drivers/net/virtio_net.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d02f83a919a7..b3aa4d2a15e9 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3596,38 +3596,28 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 	struct virtnet_info *vi = rq->vq->vdev->priv;
 	struct net_device *dev = vi->dev;
 	struct dim_cq_moder update_moder;
-	int i, qnum, err;
+	int qnum, err;
 
 	if (!rtnl_trylock())
 		return;
 
-	/* Each rxq's work is queued by "net_dim()->schedule_work()"
-	 * in response to NAPI traffic changes. Note that dim->profile_ix
-	 * for each rxq is updated prior to the queuing action.
-	 * So we only need to traverse and update profiles for all rxqs
-	 * in the work which is holding rtnl_lock.
-	 */
-	for (i = 0; i < vi->curr_queue_pairs; i++) {
-		rq = &vi->rq[i];
-		dim = &rq->dim;
-		qnum = rq - vi->rq;
+	qnum = rq - vi->rq;
 
-		if (!rq->dim_enabled)
-			continue;
+	if (!rq->dim_enabled)
+		goto out;
 
-		update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
-		if (update_moder.usec != rq->intr_coal.max_usecs ||
-		    update_moder.pkts != rq->intr_coal.max_packets) {
-			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
-							       update_moder.usec,
-							       update_moder.pkts);
-			if (err)
-				pr_debug("%s: Failed to send dim parameters on rxq%d\n",
-					 dev->name, qnum);
-			dim->state = DIM_START_MEASURE;
-		}
+	update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
+	if (update_moder.usec != rq->intr_coal.max_usecs ||
+	    update_moder.pkts != rq->intr_coal.max_packets) {
+		err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
+						       update_moder.usec,
+						       update_moder.pkts);
+		if (err)
+			pr_debug("%s: Failed to send dim parameters on rxq%d\n",
+				 dev->name, qnum);
+		dim->state = DIM_START_MEASURE;
 	}
-
+out:
 	rtnl_unlock();
 }
 
-- 
2.34.1


