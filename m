Return-Path: <netdev+bounces-245092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B12CC6B27
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 10:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD97E30985CB
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 09:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF00D346A1E;
	Wed, 17 Dec 2025 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eNdITb7x"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9223451A7;
	Wed, 17 Dec 2025 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765961498; cv=none; b=PcAF+VzPLYf5MsuygP8rMWF+0sVXbjfVGMWPIle7gi2cNIE/GIHo8c2qRrOxVnghz/SHbMxehrhXBSVRYAYrUeC/LYEONReHAGBLTCGjDtIrPsbEGoo8PwaBRxgl6RQQMve4pt1279PT5+tBm69zQmGCh6rrxc4GnPQjUUH2lPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765961498; c=relaxed/simple;
	bh=aieDkRSuoSXyyvduVb/jkiYPOWsazj30WNrkwaMaAZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OhwTu/y2iGlqdfFKxKyB1WAatbfVDDh5K6FNbq0QIcKOgFgBy19f5Eop5XvHuQOfZr3iEsE+ySLoTUYuvcWMnjMYkOB6JEGLyzrhbq/8sLBvfOeb2y0SeCU+E1YFF/Ua4a2prIkaMYuVgFwkrPBZKgJZEefDdrsW2WJ12rxVlgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eNdITb7x; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ZQ
	lX1HpzqMSwmehO1Ka31kcjI4o3mBYF5qwQit7KyWI=; b=eNdITb7xNrAmo+lMc5
	LvlsaPqWrt9hu9h5D/xJPkIzuZfKnL0Sg+jlj+yL6vuNro/rsYMvKyWfhaWoI87X
	q3GYETxQKjcDzrPYValDcD+rmCa8PO0iIsEZ+1ee0LNv2+tAVFBLEBjJnlTjTYPX
	yQ7oM7oS4u0ZvfP0xUZN4x98s=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wAXSZ7lbkJp2ZeZAw--.42656S12;
	Wed, 17 Dec 2025 16:50:50 +0800 (CST)
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
Subject: [PATCH 07/14] examples/vhost_user_rdma: Implement high-performance requester engine with advanced flow control
Date: Wed, 17 Dec 2025 16:49:55 +0800
Message-ID: <20251217085044.5432-9-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217085044.5432-1-15927021679@163.com>
References: <20251217085044.5432-1-15927021679@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXSZ7lbkJp2ZeZAw--.42656S12
X-Coremail-Antispam: 1Uf129KBjvAXoWDGryrKr4xur4xAr4xJF1xGrg_yoWxXr15Wo
	Z5ZayYqa40yw47ur4qka1kKFyIq34vgF45Ar4Fkrs2ganrJw4jgFn3KFZ7X3WUZr1fA3WU
	ur1xXw1Sgr47ZFnxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU2HUqUUUUU
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC0QrASWlCbuqccAAA3R

From: xiongweimin <xiongweimin@kylinos.cn>

This commit adds the core requester engine for RDMA operations:
1. Work Queue Element (WQE) processing state machine
2. Flow control with window-based congestion avoidance
3. MTU-aware packet segmentation
4. Error handling with automatic retry mechanisms
5. Atomic operation support and resource management

Key features:
- PSN-based flow control for reliable connections (RC)
- UD MTU handling with simulated success for oversize packets
- Work request state management (DONE, ERROR, RETRY)
- Packet construction and transmission pipeline
- Memory buffer (mbuf) accounting for congestion control
- Atomic reference counting for safe resource handling

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
Change-Id: Ib0873f3d56ff71ed9f51e47edfa972054145f226
---
 examples/vhost_user_rdma/meson.build         |   2 +
 examples/vhost_user_rdma/vhost_rdma.h        |   9 +
 examples/vhost_user_rdma/vhost_rdma_crc.c    | 163 ++++
 examples/vhost_user_rdma/vhost_rdma_opcode.c | 141 +++-
 examples/vhost_user_rdma/vhost_rdma_opcode.h | 335 ++++++--
 examples/vhost_user_rdma/vhost_rdma_pkt.c    | 221 +++++
 examples/vhost_user_rdma/vhost_rdma_pkt.h    |  31 +-
 examples/vhost_user_rdma/vhost_rdma_queue.c  | 826 ++++++++++++++++++-
 examples/vhost_user_rdma/vhost_rdma_queue.h  | 221 ++++-
 9 files changed, 1855 insertions(+), 94 deletions(-)
 create mode 100644 examples/vhost_user_rdma/vhost_rdma_crc.c
 create mode 100644 examples/vhost_user_rdma/vhost_rdma_pkt.c

diff --git a/examples/vhost_user_rdma/meson.build b/examples/vhost_user_rdma/meson.build
index a032a27767..2a0a6ffc15 100644
--- a/examples/vhost_user_rdma/meson.build
+++ b/examples/vhost_user_rdma/meson.build
@@ -43,5 +43,7 @@ sources = files(
     'vhost_rdma_ib.c',
     'vhost_rdma_queue.c',
     'vhost_rdma_opcode.c',
+    'vhost_rdma_pkt.c',
+    'vhost_rdma_crc.c',
 )
 
diff --git a/examples/vhost_user_rdma/vhost_rdma.h b/examples/vhost_user_rdma/vhost_rdma.h
index 980bb74beb..bf772283b8 100644
--- a/examples/vhost_user_rdma/vhost_rdma.h
+++ b/examples/vhost_user_rdma/vhost_rdma.h
@@ -72,6 +72,8 @@ extern "C" {
 #define VHOST_NET_RXQ 0
 #define VHOST_NET_TXQ 1
 
+#define ROCE_V2_UDP_DPORT 4791
+
 /* VIRTIO_F_EVENT_IDX is NOT supported now */
 #define VHOST_RDMA_FEATURE ((1ULL << VIRTIO_F_VERSION_1) |\
 	(1ULL << VIRTIO_RING_F_INDIRECT_DESC) | \
@@ -457,6 +459,13 @@ static inline enum vhost_rdma_network_type rdma_gid_attr_network_type(const stru
 		return VHOST_RDMA_NETWORK_IPV6;
 }
 
+static __rte_always_inline void
+vhost_rdma_counter_inc(struct vhost_rdma_device *dev,
+		       enum vhost_rdma_counters index)
+{
+	rte_atomic64_inc(&dev->stats_counters[index]);
+}
+
 int vhost_rdma_construct(struct vhost_rdma_device *dev, const char *path, int idx);
 void vhost_rdma_net_construct(struct vhost_user_queue *queues, int idx);
 void vs_vhost_rdma_net_setup(int vid);
diff --git a/examples/vhost_user_rdma/vhost_rdma_crc.c b/examples/vhost_user_rdma/vhost_rdma_crc.c
new file mode 100644
index 0000000000..7802bc61e1
--- /dev/null
+++ b/examples/vhost_user_rdma/vhost_rdma_crc.c
@@ -0,0 +1,163 @@
+/*
+ * Vhost-user RDMA device : Calculating the CRC of data packet
+ *
+ * Copyright (C) 2025 KylinSoft Inc. and/or its affiliates. All rights reserved.
+ *
+ * Author: Xiong Weimin <xiongweimin@kylinos.cn>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#include <stdint.h>
+
+#include <rte_mbuf.h>
+#include <rte_ip.h>
+#include <rte_udp.h>
+
+#include "vhost_rdma_opcode.h"
+#include "vhost_rdma_ib.h"
+#include "vhost_rdma_queue.h"
+#include "vhost_rdma.h"
+#include "vhost_rdma_pkt.h"
+
+const uint32_t crc_table[256] = {
+	0x00000000L, 0x77073096L, 0xee0e612cL, 0x990951baL, 0x076dc419L,
+	0x706af48fL, 0xe963a535L, 0x9e6495a3L, 0x0edb8832L, 0x79dcb8a4L,
+	0xe0d5e91eL, 0x97d2d988L, 0x09b64c2bL, 0x7eb17cbdL, 0xe7b82d07L,
+	0x90bf1d91L, 0x1db71064L, 0x6ab020f2L, 0xf3b97148L, 0x84be41deL,
+	0x1adad47dL, 0x6ddde4ebL, 0xf4d4b551L, 0x83d385c7L, 0x136c9856L,
+	0x646ba8c0L, 0xfd62f97aL, 0x8a65c9ecL, 0x14015c4fL, 0x63066cd9L,
+	0xfa0f3d63L, 0x8d080df5L, 0x3b6e20c8L, 0x4c69105eL, 0xd56041e4L,
+	0xa2677172L, 0x3c03e4d1L, 0x4b04d447L, 0xd20d85fdL, 0xa50ab56bL,
+	0x35b5a8faL, 0x42b2986cL, 0xdbbbc9d6L, 0xacbcf940L, 0x32d86ce3L,
+	0x45df5c75L, 0xdcd60dcfL, 0xabd13d59L, 0x26d930acL, 0x51de003aL,
+	0xc8d75180L, 0xbfd06116L, 0x21b4f4b5L, 0x56b3c423L, 0xcfba9599L,
+	0xb8bda50fL, 0x2802b89eL, 0x5f058808L, 0xc60cd9b2L, 0xb10be924L,
+	0x2f6f7c87L, 0x58684c11L, 0xc1611dabL, 0xb6662d3dL, 0x76dc4190L,
+	0x01db7106L, 0x98d220bcL, 0xefd5102aL, 0x71b18589L, 0x06b6b51fL,
+	0x9fbfe4a5L, 0xe8b8d433L, 0x7807c9a2L, 0x0f00f934L, 0x9609a88eL,
+	0xe10e9818L, 0x7f6a0dbbL, 0x086d3d2dL, 0x91646c97L, 0xe6635c01L,
+	0x6b6b51f4L, 0x1c6c6162L, 0x856530d8L, 0xf262004eL, 0x6c0695edL,
+	0x1b01a57bL, 0x8208f4c1L, 0xf50fc457L, 0x65b0d9c6L, 0x12b7e950L,
+	0x8bbeb8eaL, 0xfcb9887cL, 0x62dd1ddfL, 0x15da2d49L, 0x8cd37cf3L,
+	0xfbd44c65L, 0x4db26158L, 0x3ab551ceL, 0xa3bc0074L, 0xd4bb30e2L,
+	0x4adfa541L, 0x3dd895d7L, 0xa4d1c46dL, 0xd3d6f4fbL, 0x4369e96aL,
+	0x346ed9fcL, 0xad678846L, 0xda60b8d0L, 0x44042d73L, 0x33031de5L,
+	0xaa0a4c5fL, 0xdd0d7cc9L, 0x5005713cL, 0x270241aaL, 0xbe0b1010L,
+	0xc90c2086L, 0x5768b525L, 0x206f85b3L, 0xb966d409L, 0xce61e49fL,
+	0x5edef90eL, 0x29d9c998L, 0xb0d09822L, 0xc7d7a8b4L, 0x59b33d17L,
+	0x2eb40d81L, 0xb7bd5c3bL, 0xc0ba6cadL, 0xedb88320L, 0x9abfb3b6L,
+	0x03b6e20cL, 0x74b1d29aL, 0xead54739L, 0x9dd277afL, 0x04db2615L,
+	0x73dc1683L, 0xe3630b12L, 0x94643b84L, 0x0d6d6a3eL, 0x7a6a5aa8L,
+	0xe40ecf0bL, 0x9309ff9dL, 0x0a00ae27L, 0x7d079eb1L, 0xf00f9344L,
+	0x8708a3d2L, 0x1e01f268L, 0x6906c2feL, 0xf762575dL, 0x806567cbL,
+	0x196c3671L, 0x6e6b06e7L, 0xfed41b76L, 0x89d32be0L, 0x10da7a5aL,
+	0x67dd4accL, 0xf9b9df6fL, 0x8ebeeff9L, 0x17b7be43L, 0x60b08ed5L,
+	0xd6d6a3e8L, 0xa1d1937eL, 0x38d8c2c4L, 0x4fdff252L, 0xd1bb67f1L,
+	0xa6bc5767L, 0x3fb506ddL, 0x48b2364bL, 0xd80d2bdaL, 0xaf0a1b4cL,
+	0x36034af6L, 0x41047a60L, 0xdf60efc3L, 0xa867df55L, 0x316e8eefL,
+	0x4669be79L, 0xcb61b38cL, 0xbc66831aL, 0x256fd2a0L, 0x5268e236L,
+	0xcc0c7795L, 0xbb0b4703L, 0x220216b9L, 0x5505262fL, 0xc5ba3bbeL,
+	0xb2bd0b28L, 0x2bb45a92L, 0x5cb36a04L, 0xc2d7ffa7L, 0xb5d0cf31L,
+	0x2cd99e8bL, 0x5bdeae1dL, 0x9b64c2b0L, 0xec63f226L, 0x756aa39cL,
+	0x026d930aL, 0x9c0906a9L, 0xeb0e363fL, 0x72076785L, 0x05005713L,
+	0x95bf4a82L, 0xe2b87a14L, 0x7bb12baeL, 0x0cb61b38L, 0x92d28e9bL,
+	0xe5d5be0dL, 0x7cdcefb7L, 0x0bdbdf21L, 0x86d3d2d4L, 0xf1d4e242L,
+	0x68ddb3f8L, 0x1fda836eL, 0x81be16cdL, 0xf6b9265bL, 0x6fb077e1L,
+	0x18b74777L, 0x88085ae6L, 0xff0f6a70L, 0x66063bcaL, 0x11010b5cL,
+	0x8f659effL, 0xf862ae69L, 0x616bffd3L, 0x166ccf45L, 0xa00ae278L,
+	0xd70dd2eeL, 0x4e048354L, 0x3903b3c2L, 0xa7672661L, 0xd06016f7L,
+	0x4969474dL, 0x3e6e77dbL, 0xaed16a4aL, 0xd9d65adcL, 0x40df0b66L,
+	0x37d83bf0L, 0xa9bcae53L, 0xdebb9ec5L, 0x47b2cf7fL, 0x30b5ffe9L,
+	0xbdbdf21cL, 0xcabac28aL, 0x53b39330L, 0x24b4a3a6L, 0xbad03605L,
+	0xcdd70693L, 0x54de5729L, 0x23d967bfL, 0xb3667a2eL, 0xc4614ab8L,
+	0x5d681b02L, 0x2a6f2b94L, 0xb40bbe37L, 0xc30c8ea1L, 0x5a05df1bL,
+	0x2d02ef8dL
+};
+
+#define DO1(buf) crc = crc_table[((int)crc ^ (*buf++)) & 0xff] ^ (crc >> 8);
+#define DO2(buf) DO1(buf); DO1(buf);
+#define DO4(buf) DO2(buf); DO2(buf);
+#define DO8(buf) DO4(buf); DO4(buf);
+
+#define CSUM_MANGLED_0 0xffff
+
+uint32_t
+crc32(uint32_t crc, void* buf, uint32_t len)
+{
+	char* bufc = buf;
+	while (len >= 8)
+	{
+		DO8(bufc);
+		len -= 8;
+	}
+	if (len) do {
+		DO1(bufc);
+	} while (--len);
+	return crc;
+}
+
+uint32_t
+vhost_rdma_icrc_hdr(struct vhost_rdma_pkt_info *pkt, struct rte_mbuf *mbuf)
+{
+	unsigned int bth_offset = 0;
+	struct rte_ipv4_hdr *ip4h = NULL;
+	struct rte_ipv6_hdr *ip6h = NULL;
+	struct rte_udp_hdr *udph;
+	struct vhost_bth *bth;
+	int crc;
+	int length;
+	int hdr_size = sizeof(struct rte_udp_hdr) +
+		(mbuf->l3_type == VHOST_NETWORK_TYPE_IPV4 ?
+		sizeof(struct rte_ipv4_hdr) : sizeof(struct rte_ipv6_hdr));
+	/* pseudo header buffer size is calculate using ipv6 header size since
+	 * it is bigger than ipv4
+	 */
+	uint8_t pshdr[sizeof(struct rte_udp_hdr) +
+		sizeof(struct rte_ipv6_hdr) +
+		VHOST_BTH_BYTES];
+
+	/* This seed is the result of computing a CRC with a seed of
+	 * 0xfffffff and 8 bytes of 0xff representing a masked LRH.
+	 */
+	crc = 0xdebb20e3;
+
+	if (mbuf->l3_type == VHOST_NETWORK_TYPE_IPV4) { /* IPv4 */
+		rte_memcpy(pshdr, ip_hdr(pkt), hdr_size);
+		ip4h = (struct rte_ipv4_hdr *)pshdr;
+		udph = (struct rte_udp_hdr *)(ip4h + 1);
+
+		ip4h->time_to_live = 0xff;
+		ip4h->hdr_checksum = CSUM_MANGLED_0;
+		ip4h->type_of_service = 0xff;
+	} else {				/* IPv6 */
+		rte_memcpy(pshdr, ipv6_hdr(pkt), hdr_size);
+		ip6h = (struct rte_ipv6_hdr *)pshdr;
+		udph = (struct rte_udp_hdr *)(ip6h + 1);
+
+		// memset(ip6h->flow_lbl, 0xff, sizeof(ip6h->flow_lbl));
+		// ip6h->priority = 0xf;
+		ip6h->vtc_flow = rte_cpu_to_be_32(RTE_IPV6_HDR_FL_MASK | RTE_IPV6_HDR_TC_MASK);
+		ip6h->hop_limits = 0xff;
+	}
+	udph->dgram_cksum = CSUM_MANGLED_0;
+
+	bth_offset += hdr_size;
+
+	rte_memcpy(&pshdr[bth_offset], pkt->hdr, VHOST_BTH_BYTES);
+	bth = (struct vhost_bth *)&pshdr[bth_offset];
+
+	/* exclude bth.resv8a */
+	bth->qpn |= rte_cpu_to_be_32(~VHOST_RDMA_QPN_MASK);
+
+	length = hdr_size + VHOST_BTH_BYTES;
+	crc = crc32(crc, pshdr, length);
+
+	/* And finish to compute the CRC on the remainder of the headers. */
+	crc = crc32(crc, pkt->hdr + VHOST_BTH_BYTES,
+			vhost_rdma_opcode[pkt->opcode].length - VHOST_BTH_BYTES);
+	return crc;
+}
+
diff --git a/examples/vhost_user_rdma/vhost_rdma_opcode.c b/examples/vhost_user_rdma/vhost_rdma_opcode.c
index 4284a405f5..fbbed5b0e2 100644
--- a/examples/vhost_user_rdma/vhost_rdma_opcode.c
+++ b/examples/vhost_user_rdma/vhost_rdma_opcode.c
@@ -891,4 +891,143 @@ struct vhost_rdma_opcode_info vhost_rdma_opcode[VHOST_NUM_OPCODE] = {
 		}
 	},
 
-};
\ No newline at end of file
+};
+
+static int
+next_opcode_rc(struct vhost_rdma_qp *qp, uint32_t opcode, int fits)
+{
+	switch (opcode) {
+	case VHOST_RDMA_IB_WR_RDMA_WRITE:
+		if (qp->req.opcode == IB_OPCODE_RC_RDMA_WRITE_FIRST ||
+		    qp->req.opcode == IB_OPCODE_RC_RDMA_WRITE_MIDDLE)
+			return fits ?
+				IB_OPCODE_RC_RDMA_WRITE_LAST :
+				IB_OPCODE_RC_RDMA_WRITE_MIDDLE;
+		else
+			return fits ?
+				IB_OPCODE_RC_RDMA_WRITE_ONLY :
+				IB_OPCODE_RC_RDMA_WRITE_FIRST;
+
+	case VHOST_RDMA_IB_WR_RDMA_WRITE_WITH_IMM:
+		if (qp->req.opcode == IB_OPCODE_RC_RDMA_WRITE_FIRST ||
+		    qp->req.opcode == IB_OPCODE_RC_RDMA_WRITE_MIDDLE)
+			return fits ?
+				IB_OPCODE_RC_RDMA_WRITE_LAST_WITH_IMMEDIATE :
+				IB_OPCODE_RC_RDMA_WRITE_MIDDLE;
+		else
+			return fits ?
+				IB_OPCODE_RC_RDMA_WRITE_ONLY_WITH_IMMEDIATE :
+				IB_OPCODE_RC_RDMA_WRITE_FIRST;
+
+	case VHOST_RDMA_IB_WR_SEND:
+		if (qp->req.opcode == IB_OPCODE_RC_SEND_FIRST ||
+		    qp->req.opcode == IB_OPCODE_RC_SEND_MIDDLE)
+			return fits ?
+				IB_OPCODE_RC_SEND_LAST :
+				IB_OPCODE_RC_SEND_MIDDLE;
+		else
+			return fits ?
+				IB_OPCODE_RC_SEND_ONLY :
+				IB_OPCODE_RC_SEND_FIRST;
+
+	case VHOST_RDMA_IB_WR_SEND_WITH_IMM:
+		if (qp->req.opcode == IB_OPCODE_RC_SEND_FIRST ||
+		    qp->req.opcode == IB_OPCODE_RC_SEND_MIDDLE)
+			return fits ?
+				IB_OPCODE_RC_SEND_LAST_WITH_IMMEDIATE :
+				IB_OPCODE_RC_SEND_MIDDLE;
+		else
+			return fits ?
+				IB_OPCODE_RC_SEND_ONLY_WITH_IMMEDIATE :
+				IB_OPCODE_RC_SEND_FIRST;
+
+	case VHOST_RDMA_IB_WR_RDMA_READ:
+		return IB_OPCODE_RC_RDMA_READ_REQUEST;
+	}
+
+	return -EINVAL;
+}
+
+static int
+next_opcode_uc(struct vhost_rdma_qp *qp, uint32_t opcode, int fits)
+{
+	switch (opcode) {
+	case VHOST_RDMA_IB_WR_RDMA_WRITE:
+		if (qp->req.opcode == IB_OPCODE_UC_RDMA_WRITE_FIRST ||
+		    qp->req.opcode == IB_OPCODE_UC_RDMA_WRITE_MIDDLE)
+			return fits ?
+				IB_OPCODE_UC_RDMA_WRITE_LAST :
+				IB_OPCODE_UC_RDMA_WRITE_MIDDLE;
+		else
+			return fits ?
+				IB_OPCODE_UC_RDMA_WRITE_ONLY :
+				IB_OPCODE_UC_RDMA_WRITE_FIRST;
+
+	case VHOST_RDMA_IB_WR_RDMA_WRITE_WITH_IMM:
+		if (qp->req.opcode == IB_OPCODE_UC_RDMA_WRITE_FIRST ||
+		    qp->req.opcode == IB_OPCODE_UC_RDMA_WRITE_MIDDLE)
+			return fits ?
+				IB_OPCODE_UC_RDMA_WRITE_LAST_WITH_IMMEDIATE :
+				IB_OPCODE_UC_RDMA_WRITE_MIDDLE;
+		else
+			return fits ?
+				IB_OPCODE_UC_RDMA_WRITE_ONLY_WITH_IMMEDIATE :
+				IB_OPCODE_UC_RDMA_WRITE_FIRST;
+
+	case VHOST_RDMA_IB_WR_SEND:
+		if (qp->req.opcode == IB_OPCODE_UC_SEND_FIRST ||
+		    qp->req.opcode == IB_OPCODE_UC_SEND_MIDDLE)
+			return fits ?
+				IB_OPCODE_UC_SEND_LAST :
+				IB_OPCODE_UC_SEND_MIDDLE;
+		else
+			return fits ?
+				IB_OPCODE_UC_SEND_ONLY :
+				IB_OPCODE_UC_SEND_FIRST;
+
+	case VHOST_RDMA_IB_WR_SEND_WITH_IMM:
+		if (qp->req.opcode == IB_OPCODE_UC_SEND_FIRST ||
+		    qp->req.opcode == IB_OPCODE_UC_SEND_MIDDLE)
+			return fits ?
+				IB_OPCODE_UC_SEND_LAST_WITH_IMMEDIATE :
+				IB_OPCODE_UC_SEND_MIDDLE;
+		else
+			return fits ?
+				IB_OPCODE_UC_SEND_ONLY_WITH_IMMEDIATE :
+				IB_OPCODE_UC_SEND_FIRST;
+	}
+
+	return -EINVAL;
+}
+
+int vhost_rdma_next_opcode(struct vhost_rdma_qp *qp,
+						struct vhost_rdma_send_wqe *wqe,
+						uint32_t opcode)
+{
+	int fits = (wqe->dma.resid <= qp->mtu);
+
+	switch (qp->type) {
+	case VHOST_RDMA_IB_QPT_RC:
+		return next_opcode_rc(qp, opcode, fits);
+
+	case VHOST_RDMA_IB_QPT_UC:
+		return next_opcode_uc(qp, opcode, fits);
+
+	case VHOST_RDMA_IB_QPT_SMI:
+	case VHOST_RDMA_IB_QPT_UD:
+	case VHOST_RDMA_IB_QPT_GSI:
+		switch (opcode) {
+		case VHOST_RDMA_IB_WR_SEND:
+			return IB_OPCODE_UD_SEND_ONLY;
+
+		case VHOST_RDMA_IB_WR_SEND_WITH_IMM:
+			return IB_OPCODE_UD_SEND_ONLY_WITH_IMMEDIATE;
+		}
+		break;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
\ No newline at end of file
diff --git a/examples/vhost_user_rdma/vhost_rdma_opcode.h b/examples/vhost_user_rdma/vhost_rdma_opcode.h
index b8f48bcdf5..6c3660f36b 100644
--- a/examples/vhost_user_rdma/vhost_rdma_opcode.h
+++ b/examples/vhost_user_rdma/vhost_rdma_opcode.h
@@ -24,6 +24,7 @@
 #include <rte_interrupts.h>
 
 #include "vhost_rdma_ib.h"
+#include "vhost_rdma_pkt.h"
 
 /** Maximum number of QP types supported for WR mask dispatching */
 #define WR_MAX_QPT                  8
@@ -38,6 +39,92 @@
 /* Invalid opcode marker */
 #define OPCODE_NONE                 (-1)
 
+#define VHOST_RDMA_SE_MASK		(0x80)
+#define VHOST_RDMA_MIG_MASK		(0x40)
+#define VHOST_RDMA_PAD_MASK		(0x30)
+#define VHOST_RDMA_TVER_MASK		(0x0f)
+#define VHOST_RDMA_FECN_MASK		(0x80000000)
+#define VHOST_RDMA_BECN_MASK		(0x40000000)
+#define VHOST_RDMA_RESV6A_MASK		(0x3f000000)
+#define VHOST_RDMA_QPN_MASK		(0x00ffffff)
+#define VHOST_RDMA_ACK_MASK		(0x80000000)
+#define VHOST_RDMA_RESV7_MASK		(0x7f000000)
+#define VHOST_RDMA_PSN_MASK		(0x00ffffff)
+
+/**
+ * @defgroup hdr_types Header Types (for offset tracking)
+ * @{
+ */
+enum vhost_rdma_hdr_type {
+    VHOST_RDMA_LRH,           /**< Link Layer Header (InfiniBand only) */
+    VHOST_RDMA_GRH,           /**< Global Route Header (IPv6-style GIDs) */
+    VHOST_RDMA_BTH,           /**< Base Transport Header */
+    VHOST_RDMA_RETH,          /**< RDMA Extended Transport Header */
+    VHOST_RDMA_AETH,          /**< Acknowledge/Error Header */
+    VHOST_RDMA_ATMETH,        /**< Atomic Operation Request Header */
+    VHOST_RDMA_ATMACK,        /**< Atomic Operation Response Header */
+    VHOST_RDMA_IETH,          /**< Immediate Data + Error Code Header */
+    VHOST_RDMA_RDETH,         /**< Reliable Datagram Extended Transport Header */
+    VHOST_RDMA_DETH,          /**< Datagram Endpoint Identifier Header */
+    VHOST_RDMA_IMMDT,         /**< Immediate Data Header */
+    VHOST_RDMA_PAYLOAD,       /**< Payload section */
+    NUM_HDR_TYPES             /**< Number of known header types */
+};
+
+/**
+ * @defgroup hdr_masks Header Presence and Semantic Flags
+ * @{
+ */
+enum vhost_rdma_hdr_mask {
+    VHOST_LRH_MASK            = BIT(VHOST_RDMA_LRH),
+    VHOST_GRH_MASK            = BIT(VHOST_RDMA_GRH),
+    VHOST_BTH_MASK            = BIT(VHOST_RDMA_BTH),
+    VHOST_IMMDT_MASK          = BIT(VHOST_RDMA_IMMDT),
+    VHOST_RETH_MASK           = BIT(VHOST_RDMA_RETH),
+    VHOST_AETH_MASK           = BIT(VHOST_RDMA_AETH),
+    VHOST_ATMETH_MASK         = BIT(VHOST_RDMA_ATMETH),
+    VHOST_ATMACK_MASK         = BIT(VHOST_RDMA_ATMACK),
+    VHOST_IETH_MASK           = BIT(VHOST_RDMA_IETH),
+    VHOST_RDETH_MASK          = BIT(VHOST_RDMA_RDETH),
+    VHOST_DETH_MASK           = BIT(VHOST_RDMA_DETH),
+    VHOST_PAYLOAD_MASK        = BIT(VHOST_RDMA_PAYLOAD),
+
+    /* Semantic packet type flags */
+    VHOST_REQ_MASK            = BIT(NUM_HDR_TYPES + 0),  /**< Request packet */
+    VHOST_ACK_MASK            = BIT(NUM_HDR_TYPES + 1),  /**< ACK/NACK packet */
+    VHOST_SEND_MASK           = BIT(NUM_HDR_TYPES + 2),  /**< Send operation */
+    VHOST_WRITE_MASK          = BIT(NUM_HDR_TYPES + 3),  /**< RDMA Write */
+    VHOST_READ_MASK           = BIT(NUM_HDR_TYPES + 4),  /**< RDMA Read */
+    VHOST_ATOMIC_MASK         = BIT(NUM_HDR_TYPES + 5),  /**< Atomic operation */
+
+    /* Packet fragmentation flags */
+    VHOST_RWR_MASK            = BIT(NUM_HDR_TYPES + 6),  /**< RDMA with Immediate + Invalidate */
+    VHOST_COMP_MASK           = BIT(NUM_HDR_TYPES + 7),  /**< Completion required */
+
+    VHOST_START_MASK          = BIT(NUM_HDR_TYPES + 8),  /**< First fragment */
+    VHOST_MIDDLE_MASK         = BIT(NUM_HDR_TYPES + 9),  /**< Middle fragment */
+    VHOST_END_MASK            = BIT(NUM_HDR_TYPES + 10), /**< Last fragment */
+
+    VHOST_LOOPBACK_MASK       = BIT(NUM_HDR_TYPES + 12), /**< Loopback within host */
+
+    /* Composite masks */
+    VHOST_READ_OR_ATOMIC      = (VHOST_READ_MASK | VHOST_ATOMIC_MASK),
+    VHOST_WRITE_OR_SEND       = (VHOST_WRITE_MASK | VHOST_SEND_MASK),
+};
+
+/**
+ * @brief Per-opcode metadata for parsing and validation
+ */
+struct vhost_rdma_opcode_info {
+    const char *name;                             /**< Opcode name (e.g., "RC SEND_FIRST") */
+    int length;                                   /**< Fixed payload length (if any) */
+    int offset[NUM_HDR_TYPES];                    /**< Offset of each header within packet */
+    enum vhost_rdma_hdr_mask mask;                /**< Header presence and semantic flags */
+};
+
+/* Global opcode info table (indexed by IB opcode byte) */
+extern struct vhost_rdma_opcode_info vhost_rdma_opcode[VHOST_NUM_OPCODE];
+
 struct vhost_bth {
 	uint8_t			opcode;
 	uint8_t			flags;
@@ -46,21 +133,192 @@ struct vhost_bth {
 	rte_be32_t		apsn;
 };
 
+static inline uint8_t __bth_pad(void *arg)
+{
+	struct vhost_bth *bth = arg;
+
+	return (VHOST_RDMA_PAD_MASK & bth->flags) >> 4;
+}
+
+static inline uint8_t bth_pad(struct vhost_rdma_pkt_info *pkt)
+{
+	return __bth_pad(pkt->hdr);
+}
+
 struct vhost_deth {
 	rte_be32_t			qkey;
 	rte_be32_t			sqp;
 };
 
+#define GSI_QKEY		(0x80010000)
+#define DETH_SQP_MASK		(0x00ffffff)
+
+static inline uint32_t __deth_qkey(void *arg)
+{
+	struct vhost_deth *deth = arg;
+
+	return rte_be_to_cpu_32(deth->qkey);
+}
+
+static inline void __deth_set_qkey(void *arg, uint32_t qkey)
+{
+	struct vhost_deth *deth = arg;
+
+	deth->qkey = rte_cpu_to_be_32(qkey);
+}
+
+static inline uint32_t __deth_sqp(void *arg)
+{
+	struct vhost_deth *deth = arg;
+
+	return DETH_SQP_MASK & rte_be_to_cpu_32(deth->sqp);
+}
+
+static inline void __deth_set_sqp(void *arg, uint32_t sqp)
+{
+	struct vhost_deth *deth = arg;
+
+	deth->sqp = rte_cpu_to_be_32(DETH_SQP_MASK & sqp);
+}
+
+static inline uint32_t deth_qkey(struct vhost_rdma_pkt_info *pkt)
+{
+	return __deth_qkey(pkt->hdr +
+		vhost_rdma_opcode[pkt->opcode].offset[VHOST_RDMA_DETH]);
+}
+
+static inline void deth_set_qkey(struct vhost_rdma_pkt_info *pkt, uint32_t qkey)
+{
+	__deth_set_qkey(pkt->hdr +
+		vhost_rdma_opcode[pkt->opcode].offset[VHOST_RDMA_DETH], qkey);
+}
+
+static inline uint32_t deth_sqp(struct vhost_rdma_pkt_info *pkt)
+{
+	return __deth_sqp(pkt->hdr +
+		vhost_rdma_opcode[pkt->opcode].offset[VHOST_RDMA_DETH]);
+}
+
+static inline void deth_set_sqp(struct vhost_rdma_pkt_info *pkt, uint32_t sqp)
+{
+	__deth_set_sqp(pkt->hdr +
+		vhost_rdma_opcode[pkt->opcode].offset[VHOST_RDMA_DETH], sqp);
+}
+
 struct vhost_immdt {
 	rte_be32_t			imm;
 };
 
+static inline rte_be32_t __immdt_imm(void *arg)
+{
+	struct vhost_immdt *immdt = arg;
+
+	return immdt->imm;
+}
+
+static inline void __immdt_set_imm(void *arg, rte_be32_t imm)
+{
+	struct vhost_immdt *immdt = arg;
+
+	immdt->imm = imm;
+}
+
+static inline rte_be32_t immdt_imm(struct vhost_rdma_pkt_info *pkt)
+{
+	return __immdt_imm(pkt->hdr +
+		vhost_rdma_opcode[pkt->opcode].offset[VHOST_RDMA_IMMDT]);
+}
+
+static inline void immdt_set_imm(struct vhost_rdma_pkt_info *pkt, rte_be32_t imm)
+{
+	__immdt_set_imm(pkt->hdr +
+		vhost_rdma_opcode[pkt->opcode].offset[VHOST_RDMA_IMMDT], imm);
+}
+
 struct vhost_reth {
 	rte_be64_t			va;
 	rte_be32_t			rkey;
 	rte_be32_t			len;
 };
 
+static inline uint64_t __reth_va(void *arg)
+{
+	struct vhost_reth *reth = arg;
+
+	return rte_be_to_cpu_64(reth->va);
+}
+
+static inline void __reth_set_va(void *arg, uint64_t va)
+{
+	struct vhost_reth *reth = arg;
+
+	reth->va = rte_cpu_to_be_64(va);
+}
+
+static inline uint32_t __reth_rkey(void *arg)
+{
+	struct vhost_reth *reth = arg;
+
+	return rte_be_to_cpu_32(reth->rkey);
+}
+
+static inline void __reth_set_rkey(void *arg, uint32_t rkey)
+{
+	struct vhost_reth *reth = arg;
+
+	reth->rkey = rte_cpu_to_be_32(rkey);
+}
+
+static inline uint32_t __reth_len(void *arg)
+{
+	struct vhost_reth *reth = arg;
+
+	return rte_be_to_cpu_32(reth->len);
+}
+
+static inline void __reth_set_len(void *arg, uint32_t len)
+{
+	struct vhost_reth *reth = arg;
+
+	reth->len = rte_cpu_to_be_32(len);
+}
+
+static inline uint64_t reth_va(struct vhost_rdma_pkt_info *pkt)
+{
+	return __reth_va(pkt->hdr +
+		vhost_rdma_opcode[pkt->opcode].offset[VHOST_RDMA_RETH]);
+}
+
+static inline void reth_set_va(struct vhost_rdma_pkt_info *pkt, uint64_t va)
+{
+	__reth_set_va(pkt->hdr +
+		vhost_rdma_opcode[pkt->opcode].offset[VHOST_RDMA_RETH], va);
+}
+
+static inline uint32_t reth_rkey(struct vhost_rdma_pkt_info *pkt)
+{
+	return __reth_rkey(pkt->hdr +
+		vhost_rdma_opcode[pkt->opcode].offset[VHOST_RDMA_RETH]);
+}
+
+static inline void reth_set_rkey(struct vhost_rdma_pkt_info *pkt, uint32_t rkey)
+{
+	__reth_set_rkey(pkt->hdr +
+		vhost_rdma_opcode[pkt->opcode].offset[VHOST_RDMA_RETH], rkey);
+}
+
+static inline uint32_t reth_len(struct vhost_rdma_pkt_info *pkt)
+{
+	return __reth_len(pkt->hdr +
+		vhost_rdma_opcode[pkt->opcode].offset[VHOST_RDMA_RETH]);
+}
+
+static inline void reth_set_len(struct vhost_rdma_pkt_info *pkt, uint32_t len)
+{
+	__reth_set_len(pkt->hdr +
+		vhost_rdma_opcode[pkt->opcode].offset[VHOST_RDMA_RETH], len);
+}
+
 struct vhost_aeth {
 	rte_be32_t			smsn;
 };
@@ -252,79 +510,8 @@ static inline unsigned int wr_opcode_mask(int opcode, struct vhost_rdma_qp *qp)
 	return vhost_rdma_wr_opcode_info[opcode].mask[qp->type];
 }
 
-/**
- * @defgroup hdr_types Header Types (for offset tracking)
- * @{
- */
-enum vhost_rdma_hdr_type {
-    VHOST_RDMA_LRH,           /**< Link Layer Header (InfiniBand only) */
-    VHOST_RDMA_GRH,           /**< Global Route Header (IPv6-style GIDs) */
-    VHOST_RDMA_BTH,           /**< Base Transport Header */
-    VHOST_RDMA_RETH,          /**< RDMA Extended Transport Header */
-    VHOST_RDMA_AETH,          /**< Acknowledge/Error Header */
-    VHOST_RDMA_ATMETH,        /**< Atomic Operation Request Header */
-    VHOST_RDMA_ATMACK,        /**< Atomic Operation Response Header */
-    VHOST_RDMA_IETH,          /**< Immediate Data + Error Code Header */
-    VHOST_RDMA_RDETH,         /**< Reliable Datagram Extended Transport Header */
-    VHOST_RDMA_DETH,          /**< Datagram Endpoint Identifier Header */
-    VHOST_RDMA_IMMDT,         /**< Immediate Data Header */
-    VHOST_RDMA_PAYLOAD,       /**< Payload section */
-    NUM_HDR_TYPES             /**< Number of known header types */
-};
-
-/**
- * @defgroup hdr_masks Header Presence and Semantic Flags
- * @{
- */
-enum vhost_rdma_hdr_mask {
-    VHOST_LRH_MASK            = BIT(VHOST_RDMA_LRH),
-    VHOST_GRH_MASK            = BIT(VHOST_RDMA_GRH),
-    VHOST_BTH_MASK            = BIT(VHOST_RDMA_BTH),
-    VHOST_IMMDT_MASK          = BIT(VHOST_RDMA_IMMDT),
-    VHOST_RETH_MASK           = BIT(VHOST_RDMA_RETH),
-    VHOST_AETH_MASK           = BIT(VHOST_RDMA_AETH),
-    VHOST_ATMETH_MASK         = BIT(VHOST_RDMA_ATMETH),
-    VHOST_ATMACK_MASK         = BIT(VHOST_RDMA_ATMACK),
-    VHOST_IETH_MASK           = BIT(VHOST_RDMA_IETH),
-    VHOST_RDETH_MASK          = BIT(VHOST_RDMA_RDETH),
-    VHOST_DETH_MASK           = BIT(VHOST_RDMA_DETH),
-    VHOST_PAYLOAD_MASK        = BIT(VHOST_RDMA_PAYLOAD),
-
-    /* Semantic packet type flags */
-    VHOST_REQ_MASK            = BIT(NUM_HDR_TYPES + 0),  /**< Request packet */
-    VHOST_ACK_MASK            = BIT(NUM_HDR_TYPES + 1),  /**< ACK/NACK packet */
-    VHOST_SEND_MASK           = BIT(NUM_HDR_TYPES + 2),  /**< Send operation */
-    VHOST_WRITE_MASK          = BIT(NUM_HDR_TYPES + 3),  /**< RDMA Write */
-    VHOST_READ_MASK           = BIT(NUM_HDR_TYPES + 4),  /**< RDMA Read */
-    VHOST_ATOMIC_MASK         = BIT(NUM_HDR_TYPES + 5),  /**< Atomic operation */
-
-    /* Packet fragmentation flags */
-    VHOST_RWR_MASK            = BIT(NUM_HDR_TYPES + 6),  /**< RDMA with Immediate + Invalidate */
-    VHOST_COMP_MASK           = BIT(NUM_HDR_TYPES + 7),  /**< Completion required */
-
-    VHOST_START_MASK          = BIT(NUM_HDR_TYPES + 8),  /**< First fragment */
-    VHOST_MIDDLE_MASK         = BIT(NUM_HDR_TYPES + 9),  /**< Middle fragment */
-    VHOST_END_MASK            = BIT(NUM_HDR_TYPES + 10), /**< Last fragment */
-
-    VHOST_LOOPBACK_MASK       = BIT(NUM_HDR_TYPES + 12), /**< Loopback within host */
-
-    /* Composite masks */
-    VHOST_READ_OR_ATOMIC      = (VHOST_READ_MASK | VHOST_ATOMIC_MASK),
-    VHOST_WRITE_OR_SEND       = (VHOST_WRITE_MASK | VHOST_SEND_MASK),
-};
-/** @} */
-
-/**
- * @brief Per-opcode metadata for parsing and validation
- */
-struct vhost_rdma_opcode_info {
-    const char *name;                             /**< Opcode name (e.g., "RC SEND_FIRST") */
-    int length;                                   /**< Fixed payload length (if any) */
-    int offset[NUM_HDR_TYPES];                    /**< Offset of each header within packet */
-    enum vhost_rdma_hdr_mask mask;                /**< Header presence and semantic flags */
-};
-
-/* Global opcode info table (indexed by IB opcode byte) */
-extern struct vhost_rdma_opcode_info vhost_rdma_opcode[VHOST_NUM_OPCODE];
+int vhost_rdma_next_opcode(struct vhost_rdma_qp *qp, 
+					       struct vhost_rdma_send_wqe *wqe,
+		       		       uint32_t opcode);
 
 #endif
\ No newline at end of file
diff --git a/examples/vhost_user_rdma/vhost_rdma_pkt.c b/examples/vhost_user_rdma/vhost_rdma_pkt.c
new file mode 100644
index 0000000000..27f7dd0647
--- /dev/null
+++ b/examples/vhost_user_rdma/vhost_rdma_pkt.c
@@ -0,0 +1,221 @@
+/*
+ * Vhost-user RDMA device : handling ipv4 or ipv6 hdr and data 
+ *
+ * Copyright (C) 2025 KylinSoft Inc. and/or its affiliates. All rights reserved.
+ *
+ * Author: Xiong Weimin <xiongweimin@kylinos.cn>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#include <rte_mbuf.h>
+#include <rte_ether.h>
+#include <rte_ip.h>
+#include <rte_udp.h>
+
+#include "vhost_rdma_pkt.h"
+#include "vhost_rdma.h"
+#include "vhost_rdma_opcode.h"
+#include "vhost_rdma_queue.h"
+
+static __rte_always_inline
+void default_gid_to_mac(struct vhost_rdma_device *dev, char *mac) 
+{
+	struct vhost_rdma_gid *gid = &dev->gid_tbl[0];
+
+	mac[0] = gid->gid[8];
+	mac[1] = gid->gid[9];
+	mac[2] = gid->gid[10];
+	mac[3] = gid->gid[13];
+	mac[4] = gid->gid[14];
+	mac[5] = gid->gid[15];
+}
+
+static void prepare_udp_hdr(struct rte_mbuf *m, 
+                            rte_be16_t src_port,
+				            rte_be16_t dst_port)
+{
+	struct rte_udp_hdr *udph;
+
+	udph = (struct rte_udp_hdr *)rte_pktmbuf_prepend(m, sizeof(*udph));
+
+	udph->dst_port = dst_port;
+	udph->src_port = src_port;
+	udph->dgram_len = rte_cpu_to_be_16(m->data_len);
+	udph->dgram_cksum = 0;
+}
+
+static void prepare_ipv4_hdr(struct rte_mbuf *m, 
+                             rte_be32_t saddr,
+	                         rte_be32_t daddr, 
+                             uint8_t proto, 
+                             uint8_t tos, 
+                             uint8_t ttl, 
+                             rte_be16_t df)
+{
+	struct rte_ipv4_hdr *iph;
+
+	iph = (struct rte_ipv4_hdr *)rte_pktmbuf_prepend(m, sizeof(*iph));
+
+	iph->version_ihl		=	RTE_IPV4_VHL_DEF;
+	iph->total_length		=	rte_cpu_to_be_16(m->data_len);
+	iph->fragment_offset	=	df;
+	iph->next_proto_id		=	proto;
+	iph->type_of_service	=	tos;
+	iph->dst_addr			=	daddr;
+	iph->src_addr			=	saddr;
+	iph->time_to_live		=	ttl;
+}
+
+static inline void ip6_flow_hdr(struct rte_ipv6_hdr *hdr, unsigned int tclass,
+				rte_be32_t flowlabel)
+{
+	*(rte_be32_t *)hdr = rte_cpu_to_be_32(0x60000000 | (tclass << 20))|flowlabel;
+}
+
+static void
+prepare_ipv6_hdr(struct rte_mbuf *m, 
+                 struct in6_addr *saddr,
+		         struct in6_addr *daddr, 
+                 uint8_t proto, 
+                 uint8_t prio, 
+                 uint8_t ttl)
+{
+	struct rte_ipv6_hdr *ip6h;
+
+	ip6h = (struct rte_ipv6_hdr *)rte_pktmbuf_prepend(m, sizeof(*ip6h));
+
+	ip6_flow_hdr(ip6h, prio, rte_cpu_to_be_32(0));
+	ip6h->proto     = proto;
+	ip6h->hop_limits   = ttl;
+	rte_memcpy(ip6h->dst_addr, daddr, sizeof(*daddr));
+	rte_memcpy(ip6h->src_addr, saddr, sizeof(*daddr));
+	ip6h->payload_len = rte_cpu_to_be_16(m->data_len - sizeof(*ip6h));
+}
+
+static int
+prepare4(struct vhost_rdma_pkt_info *pkt, struct rte_mbuf *m)
+{
+	struct vhost_rdma_qp *qp = pkt->qp;
+	struct vhost_rdma_av *av = vhost_rdma_get_av(pkt);
+	struct in_addr *saddr = &av->sgid_addr._sockaddr_in.sin_addr;
+	struct in_addr *daddr = &av->dgid_addr._sockaddr_in.sin_addr;
+	rte_be16_t df = rte_cpu_to_be_16(RTE_IPV4_HDR_DF_FLAG);
+
+	prepare_udp_hdr(m, rte_cpu_to_be_16(qp->src_port),
+			        rte_cpu_to_be_16(ROCE_V2_UDP_DPORT));
+
+	// FIXME: check addr
+	prepare_ipv4_hdr(m, saddr->s_addr, daddr->s_addr, IPPROTO_UDP,
+			         av->grh.traffic_class, av->grh.hop_limit, df);
+
+	return 0;
+}
+
+static int
+prepare6(struct vhost_rdma_pkt_info *pkt, struct rte_mbuf *m)
+{
+	struct vhost_rdma_qp *qp = pkt->qp;
+	struct vhost_rdma_av *av = vhost_rdma_get_av(pkt);
+	struct in6_addr *saddr = &av->sgid_addr._sockaddr_in6.sin6_addr;
+	struct in6_addr *daddr = &av->dgid_addr._sockaddr_in6.sin6_addr;
+
+	prepare_udp_hdr(m, rte_cpu_to_be_16(qp->src_port),
+			rte_cpu_to_be_16(ROCE_V2_UDP_DPORT));
+
+	prepare_ipv6_hdr(m, saddr, daddr, IPPROTO_UDP,
+			 av->grh.traffic_class,
+			 av->grh.hop_limit);
+
+	return 0;
+}
+
+int
+vhost_rdma_prepare(struct vhost_rdma_pkt_info *pkt, 
+                   struct rte_mbuf *m,
+				   uint32_t *crc)
+{
+	int err = 0;
+	char dev_mac[6];
+
+	if (m->l3_type == VHOST_NETWORK_TYPE_IPV4)
+		err = prepare4(pkt, m);
+	else if (m->l3_type == VHOST_NETWORK_TYPE_IPV6)
+		err = prepare6(pkt, m);
+
+	*crc = vhost_rdma_icrc_hdr(pkt, m);
+
+	default_gid_to_mac(pkt->dev, dev_mac);
+
+	if (memcmp(dev_mac, vhost_rdma_get_av(pkt)->dmac, 6) == 0) {
+		pkt->mask |= VHOST_LOOPBACK_MASK;
+	}
+
+	return err;
+}
+
+static int
+ip_out(struct vhost_rdma_pkt_info *pkt, struct rte_mbuf* mbuf, uint16_t type)
+{
+	struct rte_ether_hdr *ether;
+
+	ether = (struct rte_ether_hdr *)rte_pktmbuf_prepend(mbuf, sizeof(*ether));
+
+	ether->ether_type = rte_cpu_to_be_16(type);
+	default_gid_to_mac(pkt->dev, (char*)&ether->src_addr.addr_bytes[0]);
+	rte_memcpy(&ether->dst_addr.addr_bytes[0], vhost_rdma_get_av(pkt)->dmac, 6);
+
+	// IP checksum offload
+	mbuf->ol_flags = RTE_MBUF_F_TX_IP_CKSUM;
+	if (type == RTE_ETHER_TYPE_IPV4) {
+		mbuf->ol_flags |= RTE_MBUF_F_TX_IPV4;
+		mbuf->l3_len = sizeof(struct rte_ipv4_hdr);
+	} else {
+		mbuf->ol_flags |= RTE_MBUF_F_TX_IPV6;
+		mbuf->l3_len = sizeof(struct rte_ipv6_hdr);
+	}
+	mbuf->l4_len = sizeof(struct rte_udp_hdr);
+	mbuf->l2_len = sizeof(struct rte_ether_hdr);
+
+	rte_ring_enqueue(pkt->dev->tx_ring, mbuf);
+
+	return 0;    
+}
+
+int vhost_rdma_send(struct vhost_rdma_pkt_info *pkt, 
+                    struct rte_mbuf *mbuf)
+{
+	int err;
+	int mbuf_out;
+	struct vhost_rdma_qp *qp = pkt->qp;
+
+	vhost_rdma_add_ref(qp);
+	rte_atomic32_inc(&pkt->qp->mbuf_out);
+
+	if (mbuf->l3_type == VHOST_NETWORK_TYPE_IPV4) {
+		err = ip_out(pkt, mbuf, RTE_ETHER_TYPE_IPV4);
+	} else if (mbuf->l3_type == VHOST_NETWORK_TYPE_IPV6) {
+		err = ip_out(pkt, mbuf, RTE_ETHER_TYPE_IPV6);
+	} else {
+		RDMA_LOG_ERR("Unknown layer 3 protocol: %u\n", mbuf->l3_type);
+		vhost_rdma_drop_ref(qp, qp->dev, qp);
+		rte_pktmbuf_free(mbuf);
+		return -EINVAL;
+	} 
+
+	mbuf_out = rte_atomic32_sub_return(&pkt->qp->mbuf_out, 1);
+	if (unlikely(pkt->qp->need_req_mbuf &&
+			mbuf_out < VHOST_INFLIGHT_SKBS_PER_QP_LOW))
+		vhost_rdma_run_task(&pkt->qp->req.task, 1);
+
+	vhost_rdma_drop_ref(qp, qp->dev, qp);
+
+	if (unlikely(err)) {
+		RDMA_LOG_ERR("ip out failed");
+		return -EAGAIN;
+	}
+
+	return 0;                   
+}
diff --git a/examples/vhost_user_rdma/vhost_rdma_pkt.h b/examples/vhost_user_rdma/vhost_rdma_pkt.h
index e6a605f574..f012edd8ec 100644
--- a/examples/vhost_user_rdma/vhost_rdma_pkt.h
+++ b/examples/vhost_user_rdma/vhost_rdma_pkt.h
@@ -22,9 +22,13 @@
 #include <stdint.h>
 #include <stddef.h>
 
+#include <netinet/in.h>
 #include <rte_byteorder.h>
 #include <rte_mbuf.h> /* For struct rte_mbuf if needed later */
 
+#include "vhost_rdma.h"
+#include "vhost_rdma_ib.h"
+
 /* Forward declarations */
 struct vhost_rdma_dev;
 struct vhost_rdma_qp;
@@ -34,16 +38,23 @@ struct vhost_rdma_send_wqe;
 #define BIT(x) (1U << (x))	/**< Generate bitmask from bit index */
 #endif
 
+#define ip_hdr(p) ((struct rte_ipv4_hdr*) \
+	(RTE_PTR_SUB(p->hdr, \
+		sizeof(struct rte_udp_hdr) + sizeof(struct rte_ipv4_hdr))))
+#define ipv6_hdr(p) ((struct rte_ipv6_hdr*) \
+	(RTE_PTR_SUB(p->hdr, \
+		sizeof(struct rte_udp_hdr) + sizeof(struct rte_ipv6_hdr))))
+
 /**
- * @defgroup constants Constants & Limits
- * @{
- */
+* @defgroup constants Constants & Limits
+* @{
+*/
 
 /**
- * @brief Runtime packet context used during processing
- */
+* @brief Runtime packet context used during processing
+*/
 struct vhost_rdma_pkt_info {
-	struct vhost_rdma_dev		*dev;			/**< Owning device */
+	struct vhost_rdma_device	*dev;			/**< Owning device */
 	struct vhost_rdma_qp		*qp;			/**< Associated QP */
 	struct vhost_rdma_send_wqe	*wqe;			/**< Corresponding send WQE (if applicable) */
 	uint8_t						*hdr;			/**< Pointer to BTH (Base Transport Header) */
@@ -55,4 +66,12 @@ struct vhost_rdma_pkt_info {
 	uint8_t						opcode;			/**< BTH opcode field */
 };
 
+int vhost_rdma_prepare(struct vhost_rdma_pkt_info *pkt,
+					struct rte_mbuf *m,
+					uint32_t *crc);
+
+uint32_t vhost_rdma_icrc_hdr(struct vhost_rdma_pkt_info *pkt, struct rte_mbuf *mbuf);
+
+uint32_t crc32(uint32_t crc, void* buf, uint32_t len);
+
 #endif /* __VHOST_RDMA_PKT_H__ */
\ No newline at end of file
diff --git a/examples/vhost_user_rdma/vhost_rdma_queue.c b/examples/vhost_user_rdma/vhost_rdma_queue.c
index abce651fa5..7d0c45592c 100644
--- a/examples/vhost_user_rdma/vhost_rdma_queue.c
+++ b/examples/vhost_user_rdma/vhost_rdma_queue.c
@@ -13,6 +13,11 @@
 #include <rte_interrupts.h>
 #include <rte_malloc.h>
 #include <rte_vhost.h>
+#include <rte_mbuf.h>
+#include <rte_ether.h>
+#include <rte_ip.h>
+#include <rte_udp.h>
+#include <rte_timer.h>
 
 #include "vhost_rdma_queue.h"
 #include "vhost_rdma_pkt.h"
@@ -560,12 +565,829 @@ vhost_rdma_queue_cleanup(struct vhost_rdma_qp *qp, struct vhost_rdma_queue *queu
 	queue->data = NULL;
 }
 
-int vhost_rdma_requester(void *arg)
+int
+vhost_rdma_advance_dma_data(struct vhost_rdma_dma_info *dma, unsigned int length)
 {
-	//TODO: handle request
+	struct vhost_rdma_sge *sge = &dma->sge[dma->cur_sge];
+	uint32_t offset = dma->sge_offset;
+	int resid = dma->resid;
+
+	while (length) {
+		unsigned int bytes;
+
+		if (offset >= sge->length) {
+			sge++;
+			dma->cur_sge++;
+			offset = 0;
+			if (dma->cur_sge >= dma->num_sge)
+				return -ENOSPC;
+		}
+
+		bytes = length;
+
+		if (bytes > sge->length - offset)
+			bytes = sge->length - offset;
+
+		offset	+= bytes;
+		resid	-= bytes;
+		length	-= bytes;
+	}
+
+	dma->sge_offset = offset;
+	dma->resid	= resid;
+
 	return 0;
 }
 
+static __rte_always_inline void
+vhost_rdma_retry_first_write_send(struct vhost_rdma_qp *qp,
+					  			  struct vhost_rdma_send_wqe *wqe,
+					  			  unsigned int mask, int npsn)
+{
+	int i;
+
+	for (i = 0; i < npsn; i++) {
+		int to_send = (wqe->dma.resid > qp->mtu) ?
+				qp->mtu : wqe->dma.resid;
+
+		qp->req.opcode = vhost_rdma_next_opcode(qp, 
+												wqe,
+					     					    wqe->wr->opcode);
+
+		if (wqe->wr->send_flags & VHOST_RDMA_IB_SEND_INLINE) {
+			wqe->dma.resid -= to_send;
+			wqe->dma.sge_offset += to_send;
+		} else {
+			vhost_rdma_advance_dma_data(&wqe->dma, to_send);
+		}
+		if (mask & WR_WRITE_MASK)
+			wqe->iova += qp->mtu;
+	}
+}
+
+static void vhost_rdma_req_retry(struct vhost_rdma_qp *qp)
+{
+	struct vhost_rdma_send_wqe *wqe;
+	struct vhost_rdma_queue *q = &qp->sq.queue;
+	unsigned int cons;
+	unsigned int prod;
+	unsigned int wqe_index;
+	unsigned int mask;
+	int npsn;
+	int first = 1;
+
+	cons = q->consumer_index;
+	prod = q->producer_index;
+
+	qp->req.wqe_index	= cons;
+	qp->req.psn		= qp->comp.psn;
+	qp->req.opcode		= -1;
+
+	for (wqe_index = cons; wqe_index != prod; wqe_index++) {
+		wqe = addr_from_index(&qp->sq.queue, wqe_index);
+		mask = wr_opcode_mask(wqe->wr->opcode, qp);
+
+		if (wqe->state == WQE_STATE_POSTED)
+			break;
+
+		if (wqe->state == WQE_STATE_DONE)
+			continue;
+
+		wqe->iova = (mask & WR_READ_OR_WRITE_MASK) ? 
+					 wqe->wr->rdma.remote_addr : 0;
+
+		if (!first || (mask & WR_READ_MASK) == 0) {
+			wqe->dma.resid = wqe->dma.length;
+			wqe->dma.cur_sge = 0;
+			wqe->dma.sge_offset = 0;
+		}
+
+		if (first) {
+			first = 0;
+
+			if (mask & WR_WRITE_OR_SEND_MASK) {
+				npsn = (qp->comp.psn - wqe->first_psn) & VHOST_RDMA_PSN_MASK;
+				vhost_rdma_retry_first_write_send(qp, wqe, mask, npsn);
+			}
+
+			if (mask & WR_READ_MASK) {
+				npsn = (wqe->dma.length - wqe->dma.resid) / qp->mtu;
+				wqe->iova += npsn * qp->mtu;
+			}			
+		}
+		wqe->state = WQE_STATE_POSTED;
+	}
+}
+
+static struct vhost_rdma_send_wqe* vhost_rdma_req_next_wqe(struct vhost_rdma_qp *qp)
+{
+	struct vhost_rdma_send_wqe *wqe;
+	struct vhost_rdma_queue *q = &qp->sq.queue;
+	unsigned int index = qp->req.wqe_index;
+	unsigned int cons;
+	unsigned int prod;
+
+	wqe = queue_head(q);
+	cons = q->consumer_index;
+	prod = q->producer_index;
+
+	if (unlikely(qp->req.state == QP_STATE_DRAIN)) {
+		rte_spinlock_lock(&qp->state_lock);
+		do {
+			if (qp->req.state != QP_STATE_DRAIN) {
+				/* comp just finished */
+				rte_spinlock_unlock(&qp->state_lock);
+				break;
+			}
+
+			if (wqe && ((index != cons) ||
+				(wqe->state != WQE_STATE_POSTED))) {
+				/* comp not done yet */
+				rte_spinlock_unlock(&qp->state_lock);
+				break;
+			}
+
+			qp->req.state = QP_STATE_DRAINED;
+			rte_spinlock_unlock(&qp->state_lock);
+		} while (0);
+	}
+	
+	if (index == prod)
+		return NULL;
+
+	wqe = addr_from_index(q, index);
+
+	if (unlikely((qp->req.state == QP_STATE_DRAIN ||
+		      	  qp->req.state == QP_STATE_DRAINED) &&
+		     	  (wqe->state   != WQE_STATE_PROCESSING)))
+		return NULL;
+
+	if (unlikely((wqe->wr->send_flags & VHOST_RDMA_IB_SEND_FENCE) &&
+						     (index != cons))) {
+		qp->req.wait_fence = 1;
+		return NULL;
+	}
+
+	wqe->mask = wr_opcode_mask(wqe->wr->opcode, qp);
+	return wqe;
+}
+
+struct vhost_rdma_av *vhost_rdma_get_av(struct vhost_rdma_pkt_info *pkt)
+{
+	if (!pkt || !pkt->qp)
+		return NULL;
+
+	if (pkt->qp->type == VHOST_RDMA_IB_QPT_RC ||
+	    pkt->qp->type == VHOST_RDMA_IB_QPT_UC)
+		return &pkt->qp->av;
+
+	return (pkt->wqe) ? &pkt->wqe->av : NULL;
+}
+
+struct rte_mbuf *vhost_rdma_init_packet(struct vhost_rdma_device *dev,
+									    struct vhost_rdma_av *av, 
+										int paylen, 
+										struct vhost_rdma_pkt_info *pkt)
+{
+	const struct vhost_rdma_gid *attr;	
+	unsigned int hdr_len;
+	struct rte_mbuf *mbuf = NULL;
+	const int port_num = 1;
+	uint16_t data_room;
+
+	attr = &dev->gid_tbl[av->grh.sgid_index];
+
+	if (attr->type == VHOST_RDMA_GID_TYPE_ILLIGAL)
+		return NULL;
+
+	if (av->network_type == VHOST_NETWORK_TYPE_IPV4)
+		hdr_len = ETH_HLEN + sizeof(struct rte_udp_hdr) +
+			sizeof(struct rte_ipv4_hdr);
+	else
+		hdr_len = ETH_HLEN + sizeof(struct rte_udp_hdr) +
+			sizeof(struct rte_ipv6_hdr);
+
+	hdr_len += sizeof(struct rte_ether_hdr);
+
+	mbuf = rte_pktmbuf_alloc(dev->mbuf_pool);
+
+	if (unlikely(mbuf == NULL)) {
+		goto out;
+	}
+
+	if (unlikely(hdr_len > rte_pktmbuf_headroom(mbuf))) {
+		RDMA_LOG_ERR("no enough head room %u > %u", hdr_len, rte_pktmbuf_headroom(mbuf));
+		rte_pktmbuf_free(mbuf);
+		return NULL;
+	}
+
+	data_room = mbuf->buf_len - rte_pktmbuf_headroom(mbuf);
+	if (unlikely(paylen > data_room)) {
+		RDMA_LOG_ERR("no enough data room %u > %u", paylen, data_room);
+		rte_pktmbuf_free(mbuf);
+		return NULL;
+	}
+
+	if (av->network_type == VHOST_NETWORK_TYPE_IPV4)
+		mbuf->l3_type = VHOST_NETWORK_TYPE_IPV4;
+	else
+		mbuf->l3_type = VHOST_NETWORK_TYPE_IPV6;
+
+	pkt->dev	= dev;
+	pkt->port_num	= port_num;
+	pkt->hdr	= (uint8_t *)rte_pktmbuf_adj(mbuf, 0);
+	pkt->mask	|= VHOST_GRH_MASK;
+
+	rte_pktmbuf_data_len(mbuf) = paylen;
+
+out:
+	return mbuf;						
+}
+
+
+static struct rte_mbuf* vhost_rdma_init_req_packet(struct vhost_rdma_qp *qp, 
+												   struct vhost_rdma_send_wqe *wqe,
+												   int opcode, 
+											       int payload, 
+												   struct vhost_rdma_pkt_info *pkt)
+{
+	struct vhost_rdma_device *dev = qp->dev;
+	struct rte_mbuf *mbuf;
+	struct vhost_rdma_sq_req *wr = wqe->wr;
+	struct vhost_rdma_av *av;
+	int pad = (-payload) & 0x3;
+	int paylen;
+	int solicited;
+	uint16_t pkey;
+	uint32_t qp_num;
+	int ack_req;
+
+	/* length from start of bth to end of icrc */
+	paylen = vhost_rdma_opcode[opcode].length + payload + pad + VHOST_ICRC_SIZE;
+
+	/* pkt->hdr, rxe, port_num and mask are initialized in ifc
+	 * layer
+	 */
+	pkt->opcode	= opcode;
+	pkt->qp		= qp;
+	pkt->psn	= qp->req.psn;
+	pkt->mask	= vhost_rdma_opcode[opcode].mask;
+	pkt->paylen	= paylen;
+	pkt->wqe	= wqe;
+
+	/* init mbuf */
+	av = vhost_rdma_get_av(pkt);
+	mbuf = vhost_rdma_init_packet(dev, av, paylen, pkt);
+	if (unlikely(!mbuf))
+		return NULL;
+
+	/* init bth */
+	solicited = (wr->send_flags & VHOST_RDMA_IB_SEND_SOLICITED) &&
+			(pkt->mask & VHOST_END_MASK) &&
+			((pkt->mask & (VHOST_SEND_MASK)) ||
+			(pkt->mask & (VHOST_WRITE_MASK | VHOST_IMMDT_MASK)) ==
+			(VHOST_WRITE_MASK | VHOST_IMMDT_MASK));
+
+	pkey = IB_DEFAULT_PKEY_FULL;
+
+	qp_num = (pkt->mask & VHOST_DETH_MASK) ? wr->ud.remote_qpn :
+					 						 qp->attr.dest_qp_num;
+
+	ack_req = ((pkt->mask & VHOST_END_MASK) ||
+		(qp->req.noack_pkts++ > VHOST_MAX_PKT_PER_ACK));
+	if (ack_req)
+		qp->req.noack_pkts = 0;
+
+	bth_init(pkt, pkt->opcode, solicited, 0, 
+			 pad, pkey, qp_num,
+		 	 ack_req, pkt->psn);
+
+	/* init optional headers */
+	if (pkt->mask & VHOST_RETH_MASK) {
+		reth_set_rkey(pkt, wr->rdma.rkey);
+		reth_set_va(pkt, wqe->iova);
+		reth_set_len(pkt, wqe->dma.resid);
+	}
+
+	if (pkt->mask & VHOST_IMMDT_MASK)
+		immdt_set_imm(pkt, wr->imm_data);
+	if (pkt->mask & VHOST_DETH_MASK) {
+		if (qp->qpn == 1)
+			deth_set_qkey(pkt, GSI_QKEY);
+		else
+			deth_set_qkey(pkt, wr->ud.remote_qkey);
+		deth_set_sqp(pkt, qp->qpn);
+	}
+
+	return mbuf;								
+}
+
+struct vhost_rdma_mr* lookup_mr(struct vhost_rdma_pd *pd, 
+								int access,
+		  						uint32_t key, 
+								enum vhost_rdma_mr_lookup_type type)
+{
+	struct vhost_rdma_mr *mr;
+	int index = key >> 8;
+
+	mr = vhost_rdma_pool_get(&pd->dev->mr_pool, index);
+	if (!mr)
+		return NULL;
+	vhost_rdma_add_ref(mr);
+
+	if (unlikely((type == VHOST_LOOKUP_LOCAL && mr->lkey != key) ||
+		     (type == VHOST_LOOKUP_REMOTE && mr->rkey != key) ||
+		     mr->pd != pd || (access && !(access & mr->access)) ||
+		     mr->state != VHOST_MR_STATE_VALID)) {
+		vhost_rdma_drop_ref(mr, pd->dev, mr);
+		mr = NULL;
+	}
+
+	return mr;
+}
+
+int
+mr_check_range(struct vhost_rdma_mr *mr, uint64_t iova, size_t length)
+{
+	switch (mr->type) {
+	case VHOST_MR_TYPE_DMA:
+		return 0;
+
+	case VHOST_MR_TYPE_MR:
+		if (iova < mr->iova || length > mr->length ||
+		    iova > mr->iova + mr->length - length)
+			return -EFAULT;
+		return 0;
+
+	default:
+		return -EFAULT;
+	}
+}
+
+static __rte_always_inline uint64_t
+lookup_iova(struct vhost_rdma_mr *mr, uint64_t iova)
+{
+	size_t offset, index;
+
+	index = (iova - mr->iova) / USER_MMAP_TARGET_PAGE_SIZE;
+	offset = (iova - mr->iova) & ~USER_MMAP_PAGE_MASK;
+
+	return mr->pages[index] + offset;
+}
+
+int
+vhost_rdma_mr_copy(struct rte_vhost_memory *mem, 
+				   struct vhost_rdma_mr *mr,
+				   uint64_t iova, 
+				   void *addr, 
+				   uint64_t length,
+				   enum vhost_rdma_mr_copy_dir dir,
+		           uint32_t *crcp)
+{
+	int err;
+	uint64_t bytes;
+	uint8_t *va;
+	uint32_t crc = crcp ? (*crcp) : 0;
+
+	if (length == 0)
+		return 0;
+
+	if (mr->type == VHOST_MR_TYPE_DMA) {
+		uint8_t *src, *dest;
+		// for dma addr, need to translate
+		iova = gpa_to_vva(mem, iova, &length);
+
+		src = (dir == VHOST_RDMA_TO_MR_OBJ) ? addr : ((void *)(uintptr_t)iova);
+
+		dest = (dir == VHOST_RDMA_TO_MR_OBJ) ? ((void *)(uintptr_t)iova) : addr;
+
+		rte_memcpy(dest, src, length);
+
+		if (crcp)
+			*crcp = crc32(*crcp, dest, length);
+
+		return 0;
+	}
+
+	err = mr_check_range(mr, iova, length);
+	if (err) {
+		err = -EFAULT;
+		goto err1;
+	}
+
+	while (length > 0) {
+		uint8_t *src, *dest;
+
+		va = (uint8_t *)lookup_iova(mr, iova);
+		src = (dir == VHOST_RDMA_TO_MR_OBJ) ? addr : va;
+		dest = (dir == VHOST_RDMA_TO_MR_OBJ) ? va : addr;
+
+		bytes = USER_MMAP_TARGET_PAGE_SIZE - ((uint64_t)va & ~ USER_MMAP_PAGE_MASK);
+
+		if (bytes > length)
+			bytes = length;
+
+		RDMA_LOG_DEBUG_DP("copy %p <- %p %lu", dest, src, bytes);
+		rte_memcpy(dest, src, bytes);
+
+		if (crcp)
+			crc = crc32(crc, dest, bytes);
+
+		length -= bytes;
+		addr += bytes;
+		iova += bytes;
+	}
+
+	if (crcp)
+		*crcp = crc;
+
+	return 0;
+
+err1:
+	return err;
+}
+
+int
+copy_data(struct vhost_rdma_pd *pd, int access,
+	  struct vhost_rdma_dma_info *dma, void *addr,
+	  int length, enum vhost_rdma_mr_copy_dir dir, uint32_t *crcp)
+{
+	uint32_t bytes;
+	struct vhost_rdma_sge *sge = &dma->sge[dma->cur_sge];
+	uint32_t offset = dma->sge_offset;
+	int resid = dma->resid;
+	struct vhost_rdma_mr *mr = NULL;
+	uint64_t iova;
+	int err;
+
+	if (length == 0)
+		return 0;
+
+	if (length > resid) {
+		err = -EINVAL;
+		goto err2;
+	}
+
+	RDMA_LOG_DEBUG("sge %llx %u offset %u %d", sge->addr, sge->length, offset, length);
+	if (sge->length && (offset < sge->length)) {
+		mr = lookup_mr(pd, access, sge->lkey, VHOST_LOOKUP_LOCAL);
+		if (!mr) {
+			err = -EINVAL;
+			goto err1;
+		}
+	}
+
+	while (length > 0) {
+		bytes = length;
+
+		if (offset >= sge->length) {
+			if (mr) {
+				vhost_rdma_drop_ref(mr, pd->dev, mr);
+				mr = NULL;
+			}
+			sge++;
+			dma->cur_sge++;
+			offset = 0;
+
+			if (dma->cur_sge >= dma->num_sge) {
+				err = -ENOSPC;
+				goto err2;
+			}
+
+			if (sge->length) {
+				mr = lookup_mr(pd, access, sge->lkey, VHOST_LOOKUP_LOCAL);
+				if (!mr) {
+					err = -EINVAL;
+					goto err1;
+				}
+			} else {
+				continue;
+			}
+		}
+
+		if (bytes > sge->length - offset)
+			bytes = sge->length - offset;
+
+		if (bytes > 0) {
+			iova = sge->addr + offset;
+
+			err = vhost_rdma_mr_copy(pd->dev->mem, mr, iova, addr, bytes, dir, crcp);
+			if (err)
+				goto err2;
+
+			offset	+= bytes;
+			resid	-= bytes;
+			length	-= bytes;
+			addr	+= bytes;
+		}
+	}
+
+	dma->sge_offset = offset;
+	dma->resid	= resid;
+
+	if (mr)
+		vhost_rdma_drop_ref(mr, pd->dev, mr);
+
+	return 0;
+
+err2:
+	if (mr)
+		vhost_rdma_drop_ref(mr, pd->dev, mr);
+err1:
+	return err;
+}
+
+static int
+vhost_rdma_finish_packet(struct vhost_rdma_qp *qp, 
+						 struct vhost_rdma_send_wqe *wqe,
+						 struct vhost_rdma_pkt_info *pkt, 
+						 struct rte_mbuf *skb, int paylen)
+{
+	uint32_t crc = 0;
+	uint32_t *p;
+	int err;
+
+	err = vhost_rdma_prepare(pkt, skb, &crc);
+	if (err)
+		return err;
+
+	if (pkt->mask & VHOST_WRITE_OR_SEND) {
+		if (wqe->wr->send_flags & VHOST_RDMA_IB_SEND_INLINE) {
+			uint8_t *tmp = &wqe->dma.inline_data[wqe->dma.sge_offset];
+
+			crc = crc32(crc, tmp, paylen);
+			memcpy(payload_addr(pkt), tmp, paylen);
+
+			wqe->dma.resid -= paylen;
+			wqe->dma.sge_offset += paylen;					
+		}else{
+			err = copy_data(qp->pd, 0, &wqe->dma,
+					payload_addr(pkt), paylen,
+					VHOST_RDMA_TO_MR_OBJ,
+					&crc);
+			if (err)
+				return err;			
+		}
+		if (bth_pad(pkt)) {
+			uint8_t *pad = payload_addr(pkt) + paylen;
+
+			memset(pad, 0, bth_pad(pkt));
+			crc = crc32(crc, pad, bth_pad(pkt));
+		}			
+	}
+	p = payload_addr(pkt) + paylen + bth_pad(pkt);
+
+	*p = ~crc;
+
+	return 0;		
+}
+
+static void
+save_state(struct vhost_rdma_send_wqe *wqe, 
+		   struct vhost_rdma_qp *qp,
+		   struct vhost_rdma_send_wqe *rollback_wqe, 
+		   uint32_t *rollback_psn)
+{
+	rollback_wqe->state     = wqe->state;
+	rollback_wqe->first_psn = wqe->first_psn;
+	rollback_wqe->last_psn  = wqe->last_psn;
+	*rollback_psn		= qp->req.psn;
+}
+
+static void
+rollback_state(struct vhost_rdma_send_wqe *wqe, 
+			   struct vhost_rdma_qp *qp,
+			   struct vhost_rdma_send_wqe *rollback_wqe, 
+			   uint32_t rollback_psn)
+{
+	wqe->state     = rollback_wqe->state;
+	wqe->first_psn = rollback_wqe->first_psn;
+	wqe->last_psn  = rollback_wqe->last_psn;
+	qp->req.psn    = rollback_psn;
+}
+
+void
+retransmit_timer(__rte_unused struct rte_timer *timer, void* arg)
+{
+	struct vhost_rdma_qp *qp = arg;
+
+	if (qp->valid) {
+		qp->comp.timeout = 1;
+		vhost_rdma_run_task(&qp->comp.task, 1);
+	}
+}
+
+static void
+update_state(struct vhost_rdma_qp *qp, struct vhost_rdma_pkt_info *pkt)
+{
+	qp->req.opcode = pkt->opcode;
+
+	if (pkt->mask & VHOST_END_MASK)
+		qp->req.wqe_index += 1;
+
+	qp->need_req_mbuf = 0;
+
+	if (qp->qp_timeout_ticks && !rte_timer_pending(&qp->retrans_timer))
+		rte_timer_reset(&qp->retrans_timer, qp->qp_timeout_ticks, SINGLE,
+						rte_lcore_id(), retransmit_timer, qp);
+}
+
+static __rte_always_inline void
+update_wqe_state(struct vhost_rdma_qp *qp, 
+				 struct vhost_rdma_send_wqe *wqe,
+				 struct vhost_rdma_pkt_info *pkt)
+{
+	if (pkt->mask & VHOST_END_MASK) {
+		if (qp->type == VHOST_RDMA_IB_QPT_RC)
+			wqe->state = WQE_STATE_PENDING;
+	} else {
+		wqe->state = WQE_STATE_PROCESSING;
+	}
+}
+
+static __rte_always_inline void
+update_wqe_psn(struct vhost_rdma_qp *qp, struct vhost_rdma_send_wqe *wqe,
+				struct vhost_rdma_pkt_info *pkt, int payload)
+{
+	/* number of packets left to send including current one */
+	int num_pkt = (wqe->dma.resid + payload + qp->mtu - 1) / qp->mtu;
+
+	/* handle zero length packet case */
+	if (num_pkt == 0)
+		num_pkt = 1;
+
+	if (pkt->mask & VHOST_START_MASK) {
+		wqe->first_psn = qp->req.psn;
+		wqe->last_psn = (qp->req.psn + num_pkt - 1) & VHOST_RDMA_PSN_MASK;
+	}
+
+	if (pkt->mask & VHOST_READ_MASK)
+		qp->req.psn = (wqe->first_psn + num_pkt) & VHOST_RDMA_PSN_MASK;
+	else
+		qp->req.psn = (qp->req.psn + 1) & VHOST_RDMA_PSN_MASK;
+}
+
+int vhost_rdma_requester(void *arg)
+{
+	struct vhost_rdma_qp *qp = (struct vhost_rdma_qp *)arg;
+	struct vhost_rdma_pkt_info pkt;
+	struct rte_mbuf *mbuf;
+	struct vhost_rdma_send_wqe *wqe;
+	enum vhost_rdma_hdr_mask mask;
+	struct vhost_rdma_send_wqe rollback_wqe;
+	struct vhost_rdma_queue *q = &qp->sq.queue;
+	uint32_t rollback_psn;
+	int payload;
+	int mtu;
+	int opcode;
+	int ret;
+
+	vhost_rdma_add_ref(qp);
+
+next_wqe:
+	if (unlikely(!qp->valid || qp->req.state == QP_STATE_ERROR))
+		goto exit;
+
+	if (unlikely(qp->req.state == QP_STATE_RESET)) {
+		qp->req.wqe_index = q->consumer_index;
+		qp->req.opcode = -1;
+		qp->req.need_rd_atomic = 0;
+		qp->req.wait_psn = 0;
+		qp->req.need_retry = 0;
+		goto exit;
+	}
+
+	if (unlikely(qp->req.need_retry)) {
+		vhost_rdma_req_retry(qp);
+		qp->req.need_retry = 0;
+	}
+
+	wqe = vhost_rdma_req_next_wqe(qp);
+	if (unlikely(!wqe))
+		goto exit;
+
+	assert(!(wqe->mask & WR_LOCAL_OP_MASK));
+
+	if (unlikely(qp->type == VHOST_RDMA_IB_QPT_RC &&
+		psn_compare(qp->req.psn, (qp->comp.psn + VHOST_MAX_UNACKED_PSNS)) > 0)) {
+		qp->req.wait_psn = 1;
+		goto exit;
+	}
+
+	if (unlikely(rte_atomic32_read(&qp->mbuf_out) >
+		         VHOST_INFLIGHT_SKBS_PER_QP_HIGH)) {
+		qp->need_req_mbuf = 1;
+		goto exit;
+	}
+
+	assert(!(wqe->mask & WR_LOCAL_OP_MASK));
+
+	if (unlikely(qp->type == VHOST_RDMA_IB_QPT_RC &&
+		psn_compare(qp->req.psn, (qp->comp.psn +
+				VHOST_MAX_UNACKED_PSNS)) > 0)) {
+		qp->req.wait_psn = 1;
+		goto exit;
+	}
+
+	/* Limit the number of inflight SKBs per QP */
+	if (unlikely(rte_atomic32_read(&qp->mbuf_out) >
+			 VHOST_INFLIGHT_SKBS_PER_QP_HIGH)) {
+		qp->need_req_mbuf = 1;
+		goto exit;
+	}
+
+	opcode = vhost_rdma_next_opcode(qp, wqe, wqe->wr->opcode);
+	if (unlikely(opcode < 0)) {
+		wqe->status = VHOST_RDMA_IB_WC_LOC_QP_OP_ERR;
+		goto exit;
+	}
+
+	mask = vhost_rdma_opcode[opcode].mask;
+	if (unlikely(mask & VHOST_READ_OR_ATOMIC)) {
+		if (check_init_depth(qp, wqe))
+			goto exit;
+	}					
+
+	mtu = get_mtu(qp);
+	payload = (mask & VHOST_WRITE_OR_SEND) ? wqe->dma.resid : 0;
+
+	if (payload > mtu) {
+		if (qp->type == VHOST_RDMA_IB_QPT_UD) {
+			/* C10-93.1.1: If the total sum of all the buffer lengths specified for a
+			 * UD message exceeds the MTU of the port as returned by QueryHCA, the CI
+			 * shall not emit any packets for this message. Further, the CI shall not
+			 * generate an error due to this condition.
+			 */
+
+			/* fake a successful UD send */
+			wqe->first_psn = qp->req.psn;
+			wqe->last_psn = qp->req.psn;
+			qp->req.psn = (qp->req.psn + 1) & VHOST_RDMA_PSN_MASK;
+			qp->req.opcode = IB_OPCODE_UD_SEND_ONLY;
+			qp->req.wqe_index += 1;
+			wqe->state = WQE_STATE_DONE;
+			wqe->status =VHOST_RDMA_IB_WC_SUCCESS;
+			__vhost_rdma_do_task(&qp->comp.task);
+			vhost_rdma_drop_ref(qp, qp->dev, qp);
+			return 0;
+		}
+		payload = mtu;		
+	}
+
+	mbuf = vhost_rdma_init_req_packet(qp, wqe, opcode, payload, &pkt);
+	if (unlikely(!mbuf)) {
+		RDMA_LOG_ERR_DP("qp#%d Failed allocating mbuf", qp->qpn);
+		wqe->status = VHOST_RDMA_IB_WC_LOC_QP_OP_ERR;
+		goto err;
+	}
+
+	ret = vhost_rdma_finish_packet(qp, wqe, &pkt, mbuf, payload);
+	if (unlikely(ret)) {
+		RDMA_LOG_DEBUG("qp#%d Error during finish packet", qp->qpn);
+		if (ret == -EFAULT)
+			wqe->status = VHOST_RDMA_IB_WC_LOC_PROT_ERR;
+		else
+			wqe->status = VHOST_RDMA_IB_WC_LOC_QP_OP_ERR;
+		rte_pktmbuf_free(mbuf);
+		goto err;
+	}		
+	/*
+	 * To prevent a race on wqe access between requester and completer,
+	 * wqe members state and psn need to be set before calling
+	 * rxe_xmit_packet().
+	 * Otherwise, completer might initiate an unjustified retry flow.
+	 */
+	save_state(wqe, qp, &rollback_wqe, &rollback_psn);
+	update_wqe_state(qp, wqe, &pkt);
+	update_wqe_psn(qp, wqe, &pkt, payload);
+	ret = vhost_rdma_xmit_packet(qp, &pkt, mbuf);
+	if (ret) {
+		qp->need_req_mbuf = 1;
+
+		rollback_state(wqe, qp, &rollback_wqe, rollback_psn);
+
+		if (ret == -EAGAIN) {
+			vhost_rdma_run_task(&qp->req.task, 1);
+			goto exit;
+		}
+
+		wqe->status = VHOST_RDMA_IB_WC_LOC_QP_OP_ERR;
+		goto err;
+	}
+
+	update_state(qp, &pkt);
+
+	goto next_wqe;
+
+err:
+	wqe->state = WQE_STATE_ERROR;
+	__vhost_rdma_do_task(&qp->comp.task);
+
+exit:
+	vhost_rdma_drop_ref(qp, qp->dev, qp);
+	return -EAGAIN;
+}
+
 int vhost_rdma_completer(void* arg)
 {
 	//TODO: handle complete
diff --git a/examples/vhost_user_rdma/vhost_rdma_queue.h b/examples/vhost_user_rdma/vhost_rdma_queue.h
index 260eea51f8..fb5a90235f 100644
--- a/examples/vhost_user_rdma/vhost_rdma_queue.h
+++ b/examples/vhost_user_rdma/vhost_rdma_queue.h
@@ -19,6 +19,10 @@
 #include <linux/types.h>
 
 #include "vhost_rdma_ib.h"
+#include "vhost_rdma_pkt.h"
+#include "vhost_rdma_opcode.h"
+#include "vhost_rdma.h"
+#include "vhost_rdma_log.h"
 
 #define QP_OPCODE_INVAILD (-1)
 
@@ -36,17 +40,15 @@ struct vhost_rdma_bth {
 #define VHOST_RDMA_TVER		(0)
 #define VHOST_RDMA_DEF_PKEY		(0xffff)
 
-#define VHOST_RDMA_SE_MASK		(0x80)
-#define VHOST_RDMA_MIG_MASK		(0x40)
-#define VHOST_RDMA_PAD_MASK		(0x30)
-#define VHOST_RDMA_TVER_MASK		(0x0f)
-#define VHOST_RDMA_FECN_MASK		(0x80000000)
-#define VHOST_RDMA_BECN_MASK		(0x40000000)
-#define VHOST_RDMA_RESV6A_MASK		(0x3f000000)
-#define VHOST_RDMA_QPN_MASK		(0x00ffffff)
-#define VHOST_RDMA_ACK_MASK		(0x80000000)
-#define VHOST_RDMA_RESV7_MASK		(0x7f000000)
-#define VHOST_RDMA_PSN_MASK		(0x00ffffff)
+#define VHOST_MAX_UNACKED_PSNS 128
+#define VHOST_INFLIGHT_SKBS_PER_QP_HIGH 64
+#define VHOST_INFLIGHT_SKBS_PER_QP_LOW 16
+#define VHOST_MAX_PKT_PER_ACK 64
+
+#define VHOST_ICRC_SIZE		(4)
+#define VHOST_MAX_HDR_LENGTH	(80)
+
+#define IB_DEFAULT_PKEY_FULL	0xFFFF
 
 /**
  * @brief Operation codes for Work Completions (WC)
@@ -94,6 +96,16 @@ enum {
 	TASK_STATE_ARMED = 2,
 };
 
+enum vhost_rdma_mr_copy_dir {
+	VHOST_RDMA_TO_MR_OBJ,
+	VHOST_RDMA_FROM_MR_OBJ,
+};
+
+enum vhost_rdma_mr_lookup_type {
+	VHOST_LOOKUP_LOCAL,
+	VHOST_LOOKUP_REMOTE,
+};
+
 /**
  * @brief Send Queue Work Request (WR) structure from userspace
  *
@@ -208,10 +220,129 @@ vhost_rdma_queue_get_data(struct vhost_rdma_queue *queue, size_t idx)
 	return queue->data + queue->elem_size * idx;
 }
 
+static __rte_always_inline void*
+addr_from_index(struct vhost_rdma_queue *q, unsigned int index)
+{
+	uint16_t cons;
+	uint16_t desc_idx;
+
+	cons = index & (q->num_elems - 1);
+	desc_idx = q->vq->vring.avail->ring[cons];
+
+	return vhost_rdma_queue_get_data(q, desc_idx);
+}
+
+static __rte_always_inline bool queue_empty(struct vhost_rdma_queue *q)
+{
+	uint16_t prod;
+	uint16_t cons;
+
+	prod = q->producer_index;
+	cons = q->consumer_index;
+
+	return prod == cons;
+}
+
+static __rte_always_inline void*
+consumer_addr(struct vhost_rdma_queue *q)
+{
+	uint16_t cons;
+	uint16_t desc_idx;
+
+	cons = q->consumer_index & (q->num_elems - 1);
+	desc_idx = q->vq->vring.avail->ring[cons];
+
+	return vhost_rdma_queue_get_data(q, desc_idx);
+}
+
+static __rte_always_inline void*
+queue_head(struct vhost_rdma_queue *q)
+{
+	return queue_empty(q) ? NULL : consumer_addr(q);
+}
+
+static inline int psn_compare(uint32_t psn_a, uint32_t psn_b)
+{
+	int32_t diff;
+
+	diff = (psn_a - psn_b) << 8;
+	return diff;
+}
+
+static __rte_always_inline int
+check_init_depth(struct vhost_rdma_qp *qp, struct vhost_rdma_send_wqe *wqe)
+{
+	int depth;
+
+	if (wqe->has_rd_atomic)
+		return 0;
+
+	qp->req.need_rd_atomic = 1;
+	depth = rte_atomic32_sub_return(&qp->req.rd_atomic, 1);
+
+	if (depth >= 0) {
+		qp->req.need_rd_atomic = 0;
+		wqe->has_rd_atomic = 1;
+		return 0;
+	}
+
+	rte_atomic32_inc(&qp->req.rd_atomic);
+	return -EAGAIN;
+}
+
+static __rte_always_inline int
+get_mtu(struct vhost_rdma_qp *qp)
+{
+	struct vhost_rdma_device *dev = qp->dev;
+
+	if (qp->type == VHOST_RDMA_IB_QPT_RC || qp->type == VHOST_RDMA_IB_QPT_UC)
+		return qp->mtu;
+
+	return dev->mtu_cap;
+}
+
+static inline void bth_init(struct vhost_rdma_pkt_info *pkt, uint8_t opcode, int se,
+			    			int mig, int pad, uint16_t pkey, uint32_t qpn, int ack_req,
+			    			uint32_t psn)
+{
+	struct vhost_bth *bth = (struct vhost_bth *)(pkt->hdr);
+
+	bth->opcode = opcode;
+	bth->flags = (pad << 4) & VHOST_RDMA_PAD_MASK;
+	if (se)
+		bth->flags |= VHOST_RDMA_SE_MASK;
+	if (mig)
+		bth->flags |= VHOST_RDMA_MIG_MASK;
+	bth->pkey = rte_cpu_to_be_16(pkey);
+	bth->qpn = rte_cpu_to_be_32(qpn & VHOST_RDMA_QPN_MASK);
+	psn &= VHOST_RDMA_PSN_MASK;
+	if (ack_req)
+		psn |= VHOST_RDMA_ACK_MASK;
+	bth->apsn = rte_cpu_to_be_32(psn);
+}
+
+static inline size_t header_size(struct vhost_rdma_pkt_info *pkt)
+{
+	return vhost_rdma_opcode[pkt->opcode].length;
+}
+
+static inline void *payload_addr(struct vhost_rdma_pkt_info *pkt)
+{
+	return pkt->hdr + vhost_rdma_opcode[pkt->opcode].offset[VHOST_RDMA_PAYLOAD];
+}
+
+static inline size_t payload_size(struct vhost_rdma_pkt_info *pkt)
+{
+	return pkt->paylen - vhost_rdma_opcode[pkt->opcode].offset[VHOST_RDMA_PAYLOAD]
+		   - bth_pad(pkt) - VHOST_ICRC_SIZE;
+}
+
 /*
  * Function declarations
  */
 
+int vhost_rdma_advance_dma_data(struct vhost_rdma_dma_info *dma, unsigned int length);
+
 /**
  * @brief Initialize an internal Send WQE from a user WR
  *
@@ -335,4 +466,72 @@ void vhost_rdma_qp_destroy(struct vhost_rdma_qp *qp);
 int vhost_rdma_av_chk_attr(struct vhost_rdma_device *dev,
 						struct vhost_rdma_ah_attr *attr);
 
+struct vhost_rdma_av *vhost_rdma_get_av(struct vhost_rdma_pkt_info *pkt);
+struct rte_mbuf* vhost_rdma_init_packet(struct vhost_rdma_device *dev,
+									    struct vhost_rdma_av *av, 
+										int paylen, 
+										struct vhost_rdma_pkt_info *pkt);
+
+int vhost_rdma_send(struct vhost_rdma_pkt_info *pkt, struct rte_mbuf *mbuf);										
+
+int copy_data(struct vhost_rdma_pd *pd, int access,
+			  struct vhost_rdma_dma_info *dma, 
+			  void *addr, int length,
+			  enum vhost_rdma_mr_copy_dir dir, uint32_t *crcp);
+
+struct vhost_rdma_mr* lookup_mr(struct vhost_rdma_pd *pd, 
+								int access,
+							 	uint32_t key,
+								enum vhost_rdma_mr_lookup_type type);
+
+int mr_check_range(struct vhost_rdma_mr *mr, 
+				   uint64_t iova, 
+				   size_t length);
+
+int vhost_rdma_mr_copy(struct rte_vhost_memory *mem, 
+				   	   struct vhost_rdma_mr *mr,
+				       uint64_t iova, 
+				       void *addr, 
+				       uint64_t length,
+				       enum vhost_rdma_mr_copy_dir dir,
+				       uint32_t *crcp);
+
+void retransmit_timer(__rte_unused struct rte_timer *timer, void* arg);
+
+static __rte_always_inline int
+vhost_rdma_xmit_packet(struct vhost_rdma_qp *qp,
+					struct vhost_rdma_pkt_info *pkt, struct rte_mbuf *m)
+{
+	int err;
+	int is_request = pkt->mask & VHOST_REQ_MASK;
+	struct vhost_rdma_device *dev = qp->dev;
+
+	if ((is_request && (qp->req.state != QP_STATE_READY)) ||
+	    (!is_request && (qp->resp.state != QP_STATE_READY))) {
+		RDMA_LOG_ERR("Packet dropped. QP is not in ready state\n");
+		goto drop;
+	}
+
+	err = vhost_rdma_send(pkt, m);
+	if (err) {
+		vhost_rdma_counter_inc(dev, VHOST_RDMA_CNT_SEND_ERR);
+		return err;
+	}
+
+	if ((qp->type != VHOST_RDMA_IB_QPT_RC) &&
+	    (pkt->mask & VHOST_END_MASK)) {
+		pkt->wqe->state = WQE_STATE_DONE;
+		vhost_rdma_run_task(&qp->comp.task, 1);
+	}
+
+	vhost_rdma_counter_inc(dev, VHOST_RDMA_CNT_SENT_PKTS);
+	goto done;
+
+drop:
+	rte_pktmbuf_free(m);
+	err = 0;
+done:
+	return err;
+}										  										
+
 #endif /* VHOST_RDMA_QUEUE_H_ */
\ No newline at end of file
-- 
2.43.0


