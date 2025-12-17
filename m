Return-Path: <netdev+bounces-245072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFFCCC6A47
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 09:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CDC1630178B7
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 08:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC5E33B6CE;
	Wed, 17 Dec 2025 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WH+8tc6/"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4034533A9C6;
	Wed, 17 Dec 2025 08:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765961108; cv=none; b=F5bVHwH7SldHWC9xESwDrkfkIisT74p0Ss0Gc0jHsA+pf0uv2nUGz61AVDfyZ70szOACwA6O5j+lO0L07bBg8jeo+d4TUzgS6sZqmM/iYgnEwKE0UfFTfg1QVOeUY0mfGOmr5x0iwM4Bh8TuocIi6nznL6ZOHE8WVjyTpZWuBak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765961108; c=relaxed/simple;
	bh=teKl12skUfQQro3PHPU2N2B6t59q3ign6XHwsZogJDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b39FCMCFds0dsZD48WAcuBhgRVJBotLoz5kIo6p1akNgamZ4bRKcT9MDPtdeXYYvFwHJW4/du6z4hbUiCubK1xeSUqgSEFAqua4tbrZ/T0d2YYgQ4EVBMFoYTIcFcvB2qsB5W9MeVhUwzX3pUjhqRUrYhQgTz+t4DLVW6DcTvkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WH+8tc6/; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=XW
	5wK1noLKWpZQP3WA1XwqbvHY8mX+e3T/od0cfU7Ko=; b=WH+8tc6/7o/HdN892y
	LYW39Zk5dLUQBZz769BSDrsMX16EZiSbXCv4wH/DatAb8ZFsY6bM7aFmtkoJDx3d
	7XX+UbyTDv3eXoC0Jwu0OG//n6zEkUDuABSg1wRUxRbuzp5HbYr+l0MftXhaRlt2
	R3d7kTGl7jH/jTKo2SfJYTf2A=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnwYJnbUJpSC+YAw--.48902S7;
	Wed, 17 Dec 2025 16:44:25 +0800 (CST)
From: Xiong Weimin <15927021679@163.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH 02/14] examples/vhost_user_rdma: implement device and port query commands
Date: Wed, 17 Dec 2025 16:43:28 +0800
Message-ID: <20251217084422.4875-4-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217084422.4875-1-15927021679@163.com>
References: <20251217084422.4875-1-15927021679@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnwYJnbUJpSC+YAw--.48902S7
X-Coremail-Antispam: 1Uf129KBjvJXoWxZry3GFW5KrW7Cw1rCry8Xwb_yoWrKw15pa
	4j93savr9rK3WxJwn3XwnF9F1FgrnYyrW7GFs7WFna93W5Jwn5Aay8C3W8KF17GFW2yFyx
	JF1jqF93GF1ay37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jq89_UUUUU=
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC8wlg6GlCbWkSRAAA3L

From: xiongweimin <xiongweimin@kylinos.cn>

Added RDMA control command handlers for:
- VHOST_RDMA_CTRL_ROCE_QUERY_DEVICE
- VHOST_RDMA_CTRL_ROCE_QUERY_PORT

Key features:
1. Device capability reporting:
   - Maximum MR size and page size capabilities
   - Queue Pair (QP) limits (max WR, SGE, CQE)
   - Resource limits (MR, PD, AH counts)
   - RDMA protocol capabilities

2. Port attribute reporting:
   - GID table length and port state
   - MTU settings (active, physical, maximum)
   - Link speed and width capabilities
   - Error counters and security attributes

3. Response validation:
   - CHK_IOVEC macro ensures response buffer safety
   - Fixed attribute values for standard RDMA v2 compliance
   - Structured response formats matching IB specification

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
Change-Id: I17ac65a0801ebf5e0b0d83a50877004a54840365
---
 examples/vhost_user_rdma/vhost_rdma_ib.c | 27 ++++++++++++
 examples/vhost_user_rdma/vhost_rdma_ib.h | 56 +++++++++++++++++++++++-
 2 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/examples/vhost_user_rdma/vhost_rdma_ib.c b/examples/vhost_user_rdma/vhost_rdma_ib.c
index 5535a8696b..edb6e3fea3 100644
--- a/examples/vhost_user_rdma/vhost_rdma_ib.c
+++ b/examples/vhost_user_rdma/vhost_rdma_ib.c
@@ -537,12 +537,39 @@ vhost_rdma_query_device(struct vhost_rdma_device *dev, CTRL_NO_CMD,
 	return 0;
 }
 
+static int
+vhost_rdma_query_port(__rte_unused struct vhost_rdma_device *dev,
+					CTRL_NO_CMD,
+					struct iovec *out)
+{
+	struct vhost_rdma_ack_query_port *rsp;
+
+	CHK_IOVEC(rsp, out);
+
+	rsp->gid_tbl_len = VHOST_MAX_GID_TBL_LEN;
+	rsp->max_msg_sz = 0x800000;
+	rsp->active_mtu = VHOST_RDMA_IB_MTU_256;
+	rsp->phys_mtu = VHOST_RDMA_IB_MTU_256;
+	rsp->port_cap_flags = 65536UL;
+	rsp->bad_pkey_cntr = 0UL;
+	rsp->phys_state = VHOST_RDMA_IB_PORT_PHYS_STATE_POLLING;
+	rsp->pkey_tbl_len = 1UL;
+	rsp->qkey_viol_cntr = 0UL;
+	rsp->state = VHOST_RDMA_IB_PORT_DOWN;
+	rsp->active_speed = 1UL;
+	rsp->active_width = VHOST_RDMA_IB_WIDTH_1X;
+	rsp->max_mtu = VHOST_RDMA_IB_MTU_4096;
+
+	return 0;
+}
+
 /* Command handler table declaration */
 struct {
 	int (*handler)(struct vhost_rdma_device *dev, struct iovec *in, struct iovec *out);
 	const char *name;  /* Name of the command (for logging) */
 } cmd_tbl[] = {
 	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_QUERY_DEVICE, vhost_rdma_query_device),
+	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_QUERY_PORT, vhost_rdma_query_port),
 };
 
 /**
diff --git a/examples/vhost_user_rdma/vhost_rdma_ib.h b/examples/vhost_user_rdma/vhost_rdma_ib.h
index 4ac896d82e..664067b024 100644
--- a/examples/vhost_user_rdma/vhost_rdma_ib.h
+++ b/examples/vhost_user_rdma/vhost_rdma_ib.h
@@ -204,7 +204,44 @@ enum vhost_user_rdma_request {
 	VHOST_USER_SET_CONFIG = 25,
 	VHOST_USER_MAX
 };
-/** @} */
+
+enum vhost_rdma_ib_port_state {
+	VHOST_RDMA_IB_PORT_NOP		= 0,
+	VHOST_RDMA_IB_PORT_DOWN		= 1,
+	VHOST_RDMA_IB_PORT_INIT		= 2,
+	VHOST_RDMA_IB_PORT_ARMED		= 3,
+	VHOST_RDMA_IB_PORT_ACTIVE		= 4,
+	VHOST_RDMA_IB_PORT_ACTIVE_DEFER	= 5
+};
+
+enum vhost_rdma_ib_port_phys_state {
+	VHOST_RDMA_IB_PORT_PHYS_STATE_SLEEP = 1,
+	VHOST_RDMA_IB_PORT_PHYS_STATE_POLLING = 2,
+	VHOST_RDMA_IB_PORT_PHYS_STATE_DISABLED = 3,
+	VHOST_RDMA_IB_PORT_PHYS_STATE_PORT_CONFIGURATION_TRAINING = 4,
+	VHOST_RDMA_IB_PORT_PHYS_STATE_LINK_UP = 5,
+	VHOST_RDMA_IB_PORT_PHYS_STATE_LINK_ERROR_RECOVERY = 6,
+	VHOST_RDMA_IB_PORT_PHYS_STATE_PHY_TEST = 7,
+};
+
+enum ib_port_width {
+	VHOST_RDMA_IB_WIDTH_1X	= 1,
+	VHOST_RDMA_IB_WIDTH_2X	= 16,
+	VHOST_RDMA_IB_WIDTH_4X	= 2,
+	VHOST_RDMA_IB_WIDTH_8X	= 4,
+	VHOST_RDMA_IB_WIDTH_12X	= 8
+};
+
+enum ib_port_speed {
+	VHOST_RDMA_IB_SPEED_SDR	= 1,
+	VHOST_RDMA_IB_SPEED_DDR	= 2,
+	VHOST_RDMA_IB_SPEED_QDR	= 4,
+	VHOST_RDMA_IB_SPEED_FDR10 = 8,
+	VHOST_RDMA_IB_SPEED_FDR	= 16,
+	VHOST_RDMA_IB_SPEED_EDR	= 32,
+	VHOST_RDMA_IB_SPEED_HDR	= 64,
+	VHOST_RDMA_IB_SPEED_NDR	= 128,
+};
 
 /**
  * @brief QP capabilities structure
@@ -622,6 +659,23 @@ struct vhost_rdma_ctrl_hdr {
 	uint8_t cmd;
 };
 
+struct vhost_rdma_ack_query_port {
+	enum vhost_rdma_ib_port_state	state;
+	enum vhost_rdma_ib_mtu		    max_mtu;
+	enum vhost_rdma_ib_mtu		    active_mtu;
+	uint32_t			phys_mtu;
+	int			        gid_tbl_len;
+	uint32_t			port_cap_flags;
+	uint32_t			max_msg_sz;
+	uint32_t			bad_pkey_cntr;
+	uint32_t			qkey_viol_cntr;
+	uint16_t			pkey_tbl_len;
+	uint16_t			active_speed;
+	uint8_t			    active_width;
+	uint8_t			    phys_state;
+	uint32_t			reserved[32];	/* For future extensions */
+}__rte_packed;
+
 /**
  * @brief Convert IB MTU enum to byte size
  * @param mtu The MTU enum value
-- 
2.43.0


