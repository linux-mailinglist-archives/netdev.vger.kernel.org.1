Return-Path: <netdev+bounces-52011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112327FCE19
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 05:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9504282473
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 04:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C13463AD;
	Wed, 29 Nov 2023 04:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BRK/IWje"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFDB1BC6;
	Tue, 28 Nov 2023 20:54:24 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASIdtw6021070;
	Tue, 28 Nov 2023 20:53:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=EEQhMICjy4DZQbWamyerRADQ92GAIF8ZCdHo2SGhyrw=;
 b=BRK/IWjeEynwFLUt/UU/qCfCr3ATctIjRm2vDpqf2lv44VHzI47yhFE8nUDLSKL8pkr3
 cjSjnukJTz+pP8diLhuBVcFsyk3u0V2iSksP9c5dadgR5EXmGTuIxHe1OO1/7JGYBWsG
 GN992H5BsQD0p7sOw/Q9wL+jzVld7PBVPYOrSRDNEFstzfDn56c55tcSkg/dGLbL/e62
 K/xL0WI9pu+8diGQ2uXqi7jwqPVRqqSGen3CcxcAQOOi7o9iVXhcFwlUWHxczIEe57J1
 cQ6l3UVNEKjJmLncxz2emriIXJrZ1YE1B2iGf9zFjgCqR68oaOODrmkko/SYABInyp6n XA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3unn869x1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 20:53:54 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 28 Nov
 2023 20:53:53 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 28 Nov 2023 20:53:53 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id 979BD3F7043;
	Tue, 28 Nov 2023 20:53:52 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
        <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
        <kuba@kernel.org>, <davem@davemloft.net>, <wizhao@redhat.com>,
        <konguyen@redhat.com>, Shinas Rasheed <srasheed@marvell.com>,
        "Veerasenareddy
 Burru" <vburru@marvell.com>,
        Sathesh Edara <sedara@marvell.com>,
        Eric Dumazet
	<edumazet@google.com>
Subject: [PATCH net-next v2 1/2] octeon_ep: implement device unload control net API
Date: Tue, 28 Nov 2023 20:53:47 -0800
Message-ID: <20231129045348.2538843-2-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231129045348.2538843-1-srasheed@marvell.com>
References: <20231129045348.2538843-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: M-DZoJauUIHW_8J3ww9emqAv7cpJNnld
X-Proofpoint-GUID: M-DZoJauUIHW_8J3ww9emqAv7cpJNnld
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_01,2023-11-27_01,2023-05-22_02

Device unload control net function should inform firmware
of driver unload to let it take necessary actions to cleanup.

Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V2:
  - Changed dev_info print to dev_dbg in device_remove API

V1: https://lore.kernel.org/all/20231127162135.2529363-2-srasheed@marvell.com/

 .../ethernet/marvell/octeon_ep/octep_ctrl_net.c  | 16 +++++++++++++++-
 .../ethernet/marvell/octeon_ep/octep_ctrl_net.h  | 11 +++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
index 5fa596c674da..4c39e2fabe0a 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.c
@@ -26,7 +26,7 @@ static atomic_t ctrl_net_msg_id;
 
 /* Control plane version in which OCTEP_CTRL_NET_H2F_CMD was added */
 static const u32 octep_ctrl_net_h2f_cmd_versions[OCTEP_CTRL_NET_H2F_CMD_MAX] = {
-	[OCTEP_CTRL_NET_H2F_CMD_INVALID ... OCTEP_CTRL_NET_H2F_CMD_GET_INFO] =
+	[OCTEP_CTRL_NET_H2F_CMD_INVALID ... OCTEP_CTRL_NET_H2F_CMD_DEV_REMOVE] =
 	 OCTEP_CP_VERSION(1, 0, 0)
 };
 
@@ -393,10 +393,24 @@ int octep_ctrl_net_get_info(struct octep_device *oct, int vfid,
 	return 0;
 }
 
+int octep_ctrl_net_dev_remove(struct octep_device *oct, int vfid)
+{
+	struct octep_ctrl_net_wait_data d = {};
+	struct octep_ctrl_net_h2f_req *req;
+
+	req = &d.data.req;
+	dev_dbg(&oct->pdev->dev, "Sending dev_unload msg to fw\n");
+	init_send_req(&d.msg, req, sizeof(int), vfid);
+	req->hdr.s.cmd = OCTEP_CTRL_NET_H2F_CMD_DEV_REMOVE;
+
+	return octep_send_mbox_req(oct, &d, false);
+}
 int octep_ctrl_net_uninit(struct octep_device *oct)
 {
 	struct octep_ctrl_net_wait_data *pos, *n;
 
+	octep_ctrl_net_dev_remove(oct, OCTEP_CTRL_NET_INVALID_VFID);
+
 	list_for_each_entry_safe(pos, n, &oct->ctrl_req_wait_list, list)
 		pos->done = 1;
 
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h
index a2463b460ad9..0de4de2ceb8f 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ctrl_net.h
@@ -42,6 +42,7 @@ enum octep_ctrl_net_h2f_cmd {
 	OCTEP_CTRL_NET_H2F_CMD_RX_STATE,
 	OCTEP_CTRL_NET_H2F_CMD_LINK_INFO,
 	OCTEP_CTRL_NET_H2F_CMD_GET_INFO,
+	OCTEP_CTRL_NET_H2F_CMD_DEV_REMOVE,
 	OCTEP_CTRL_NET_H2F_CMD_MAX
 };
 
@@ -370,6 +371,16 @@ void octep_ctrl_net_recv_fw_messages(struct octep_device *oct);
 int octep_ctrl_net_get_info(struct octep_device *oct, int vfid,
 			    struct octep_fw_info *info);
 
+/**
+ * octep_ctrl_net_dev_remove() - Indicate to firmware that a device unload has happened.
+ *
+ * @oct: non-null pointer to struct octep_device.
+ * @vfid: Index of virtual function.
+ *
+ * return value: 0 on success, -errno on failure.
+ */
+int octep_ctrl_net_dev_remove(struct octep_device *oct, int vfid);
+
 /**
  * octep_ctrl_net_uninit() - Uninitialize data for ctrl net.
  *
-- 
2.25.1


