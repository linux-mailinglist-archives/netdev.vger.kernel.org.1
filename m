Return-Path: <netdev+bounces-90339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D32428ADC81
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 05:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 878812826A1
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 03:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B7C20330;
	Tue, 23 Apr 2024 03:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IITsY6BJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25101CA81
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 03:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713844694; cv=fail; b=ldt1uynndwlgZzuMuKWhhxqEcTVq5Pgs/ErzZnned65hfa7JBwxQBXnBrmr1CEhDCuskMWNGN9YMZPZtmq9+ehO+8lRkQk815kVJUr8aYZUaIsWTlX8QQfNuBOVRXxmJcygb5Ocq8Vj1/GPutc+xhibuqGUQUpcPKP+EULxQWeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713844694; c=relaxed/simple;
	bh=lNIkd0Ef1CCCXqTOw0sqX8pStfaVl8mJanbXkRWCZXE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cN+0hiGyMz4jO8MQdXBqLczyMYv2Zww+VvSnbqZplOdZFd+LLfApQ2namq7ji3IzJNtnEZYXqG1MMFqxfN8SnQZBAq0K2m28k65KgmWVg7AUBdWGUO33r1mP0cZ3PrWLyVNGZTsyWwL6a2wYAtz5nOd48mHmumEYw9zlJL2fS68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IITsY6BJ; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8/3j4i7po48QZ9OnNoUEAl6kyKUn4bowFRAa9qlS/LX1gXZ4XEC7pjVexb7zUPdtetK/2zOpGtv25491rxyamyH9Avrt0f/c5dfhvgAPuibUrYImg8BrovnjG11iqyIsq7ht12HOUfqvBqmAjEAp5ou5dQMDqXZmQiyqygHBtCyzEfdWYbs61Fj3kdVrYEUid1vEs4eUQmu846c4ko1vTDs8JxZCpNT6c3vrccH56PWkU46eo55cHu/Sk7ex9VcfwGHPmGNzqmTndbFchbXJ+tGBca4JcPr4sgQLIggnx6ryQJJuGTw9lCTjGXgzyalE0+yMW5ZhAm3VPoP1BfkUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bALITkeA9lQpug1dEWBFUQao7EbIjmzFU97QKQyReLA=;
 b=jHeXnIQWoUTPGH/1S/X43FveP5sQsD7i8lxxDJvnDGJI3tZZaZO7jsksQtlfXsNswNvi4nPntwknuqqOlQKxWuCdwtTxjddAChpb3RgU4gm6HlgbxwfZpV65LJtq7LEeoFLL4yqKIX9mGPYb7C9CsINW3PTEa/3jY9OQeNsRLUF9Hos7eIoP6OZUgRPsU0sb621Q3pQJYxVxSvakAbxgDm4tkbkerHLuIrYqoU63dO2o4IqJLavobTDFs16kXfVBcvv3WCzBW5G/khkpPsqg6fPlB1tRmsyR+xYSLi1tO9UzYVv1cbzkK0R8tw22V5S0kEus41SQGxovS4eHm5AoqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bALITkeA9lQpug1dEWBFUQao7EbIjmzFU97QKQyReLA=;
 b=IITsY6BJKiX8E+nz9r4zFOKOQIUWAVwqwyquyOLXw3hA7qrX573lAOiOIs+3rmZ2W4ZANufysSsy8uUP/r/DmEusgx2HlNZ+J4WwkCG12ddDkJ1in9HDQB/ZmCpTpMjA8TvD7cJzZU2ITImjYoZpp2EamNDofutmjZkEr5JYos9KM89FCVCv7pvwxccOYegkrZc+yqWHF1rUHzDdr+hSLXGPSBWXmpkR1aCqcLgc6jonld31YVmhvRDZPggBfWdYaQKokyiQlWBo69F4vJiU5WAfolCME5cUfu0XkzSlpfcJUI7HJgQCS4hch5VV17is7xWzpKe2Tx7YqKhFSKF4tg==
Received: from MW4PR04CA0243.namprd04.prod.outlook.com (2603:10b6:303:88::8)
 by DS0PR12MB9347.namprd12.prod.outlook.com (2603:10b6:8:193::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 03:58:10 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:88:cafe::a8) by MW4PR04CA0243.outlook.office365.com
 (2603:10b6:303:88::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Tue, 23 Apr 2024 03:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.0 via Frontend Transport; Tue, 23 Apr 2024 03:58:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 20:57:57 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 20:57:57 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 22 Apr
 2024 20:57:56 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v5 3/6] virtio_net: Add a lock for the command VQ.
Date: Tue, 23 Apr 2024 06:57:43 +0300
Message-ID: <20240423035746.699466-4-danielj@nvidia.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240423035746.699466-1-danielj@nvidia.com>
References: <20240423035746.699466-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|DS0PR12MB9347:EE_
X-MS-Office365-Filtering-Correlation-Id: 0671bda8-97e5-469f-8064-08dc6349975d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I5lS0r4VKVBy+sQn1dp3n0wAQRxks4IYf6/A7WQrf2lBTkonXdhQxbh3+QZG?=
 =?us-ascii?Q?nLcUb/uZFNQlXWoFgXlP/7bNVWqmLndgPKVsNvD/rNWaDWvLBaoTmC1Q1yhj?=
 =?us-ascii?Q?6O74PuYW94CvaXIoRyQd5y0aiyGkEyT6tAp3ZAMqjYvtKqVfr0xKm+6CHJPQ?=
 =?us-ascii?Q?wvC3fG5AG3B6laROucmJn1Pgt8tMKX/M4zOmevtmJ279yNmUVI4aR6qd48Wt?=
 =?us-ascii?Q?KeEhN7Fnx1heTBdzsT4ardybtsgqqZnCSSDdbWdoXDWgCT5BmhhQZOP9MjSK?=
 =?us-ascii?Q?7M8nNR3zOkghBvaBwuD7jkFnhQiNrkIY/LAE2uMuAtGCxP2f5msh6L3y7Qua?=
 =?us-ascii?Q?6vYgxZrTdy46P/scy+jQV49XnZ4sJoOQGDi21sd92bJqKqPOrxXsgWZRHgjF?=
 =?us-ascii?Q?Wv4JMdsRujXacy8TvhgQ1XErX7AunzSmXR3yiL7B1Qh2be7j/m+PDCZ/3yZD?=
 =?us-ascii?Q?GXnvMs1CDZHwZoqFCXMlZFP8mm+CxSXXzvWbHyemA4QIkkvEY1GREkRSDmEJ?=
 =?us-ascii?Q?sXJuzQQKycWZuyzvBLR7Xof3yXxaNHz5V0ut6zv40AscdZyGmMCNyUKQfFWY?=
 =?us-ascii?Q?JnV0WBnmeexpofEFtdQ8y8boIB/DLgCy2mb8YlLFjbNLAiT1+gkG9hRN0NR+?=
 =?us-ascii?Q?uip/zbp4d4YLUi7bmyvUPLJcjXw81Y13NkBHTN8eRPQ7WE4f9CFjAvakdJTB?=
 =?us-ascii?Q?KmWSwGgEBcjNM6wfVYuKq1hgJZjMk590b2a0Sp8VEdDEWeUYLr2zFhY+pVCm?=
 =?us-ascii?Q?+B7NwFbVZgKzVcrbCis9kB9tglKszUuyXRPhBOKk/cTwBFsQY+RH5aAolQrD?=
 =?us-ascii?Q?rhLB4yW14XVMLJBMG9cFcPMXEBsKeXvR3x7Q7hmnCUBl+WpVyvOftoukMuTj?=
 =?us-ascii?Q?e2HEnsDzO+4kn+rIV/jO/hPAobcMXuMaQaSyv6sJQVBlOO1OUgFNyxLGEUrj?=
 =?us-ascii?Q?p0BapEaMkaLrqU/E//vXLxTxNPT2RsI78rXmO1NGskJtZb2o3A0k69iBR/Y7?=
 =?us-ascii?Q?LxIjFyjbs/kuZX/T98O61QXkoy9my/ZTJnnaVU2gni4YALC2Z7SKvCW4OBAv?=
 =?us-ascii?Q?DIxSO9Qun5P5zgBXNNh7lTY3MhLr7Eh7jX2EH+qQeViYDUiQGytU6//U8r+j?=
 =?us-ascii?Q?K2zoBp6H1Sik8AuqKizM6egFzG/+6baZYaz789iPZPqqNh7GgYGF+2CSdGUr?=
 =?us-ascii?Q?rvtcmZJc0fTGqWLYkNVJWAIXGX5bxHHmSLDl9rgM/pTtXOGYhwglcJXInc+S?=
 =?us-ascii?Q?sqaLj5UiMpLBdHEHFVvEDXCPXnC4UFr5UcQiFr7SpL9Bdy5fLgYmRjg7dvLN?=
 =?us-ascii?Q?RtjF90Uo/y7Eft3M438j/+I3JpgYWEv6UkcjWdM4eFeOMSmq2izrxBJqEiEm?=
 =?us-ascii?Q?K1JhvKNbjezdwzHduRloYyyMK0tZ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 03:58:10.1298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0671bda8-97e5-469f-8064-08dc6349975d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9347

The command VQ will no longer be protected by the RTNL lock. Use a
mutex to protect the control buffer header and the VQ.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/virtio_net.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0ee192b45e1e..d752c8ac5cd3 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -282,6 +282,7 @@ struct virtnet_info {
 
 	/* Has control virtqueue */
 	bool has_cvq;
+	struct mutex cvq_lock;
 
 	/* Host can handle any s/g split between our header and packet data */
 	bool any_header_sg;
@@ -2529,6 +2530,7 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 	/* Caller should know better */
 	BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
 
+	mutex_lock(&vi->cvq_lock);
 	vi->ctrl->status = ~0;
 	vi->ctrl->hdr.class = class;
 	vi->ctrl->hdr.cmd = cmd;
@@ -2548,11 +2550,14 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 	if (ret < 0) {
 		dev_warn(&vi->vdev->dev,
 			 "Failed to add sgs for command vq: %d\n.", ret);
+		mutex_unlock(&vi->cvq_lock);
 		return false;
 	}
 
-	if (unlikely(!virtqueue_kick(vi->cvq)))
+	if (unlikely(!virtqueue_kick(vi->cvq))) {
+		mutex_unlock(&vi->cvq_lock);
 		return vi->ctrl->status == VIRTIO_NET_OK;
+	}
 
 	/* Spin for a response, the kick causes an ioport write, trapping
 	 * into the hypervisor, so the request should be handled immediately.
@@ -2563,6 +2568,7 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 		cpu_relax();
 	}
 
+	mutex_unlock(&vi->cvq_lock);
 	return vi->ctrl->status == VIRTIO_NET_OK;
 }
 
@@ -4818,8 +4824,10 @@ static int virtnet_probe(struct virtio_device *vdev)
 	    virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
 		vi->any_header_sg = true;
 
-	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ))
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ)) {
 		vi->has_cvq = true;
+		mutex_init(&vi->cvq_lock);
+	}
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MTU)) {
 		mtu = virtio_cread16(vdev,
-- 
2.34.1


