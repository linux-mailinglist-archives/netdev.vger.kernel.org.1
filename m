Return-Path: <netdev+bounces-172692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BCBA55B88
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66B4E178FFD
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE494C80;
	Fri,  7 Mar 2025 00:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/pByONJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC54C2581;
	Fri,  7 Mar 2025 00:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741306371; cv=none; b=Zjy6BiI9oTgZoq/U7cFYpSAmknscH4gIpPrp4bHiaxeioBATEujEC3f8KrZAQN9uYGIIXGhh3lRapLSnMDr2Aav2IMP4dzK4IuCvkz6hpeCxF6GgBCFVx8tv0l72MGbwN/ucW+Vt0t6acvYjMoc71m6z7ICO9+xwTzq18l8Rmbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741306371; c=relaxed/simple;
	bh=KwzqVNQ/LxOFE9lZkWbvcHponjUKYCapTArWFogQfNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A7wzJAt5SINZc5zyV3rcZwIHr222yZdm0arsm6jm2AfLr8zp22EGOboREqZuwC6JS3pniZo8M+jhsErWFFJGIbQZkoeZGALXgDXot2WIbYsKOSzdLbHx0pqxdFe1RVQTq9TvraB6nMZ2M4Rzj4F7KkH66GSWZ3Ohbf3VgmoA9e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/pByONJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 650AEC4CEE9;
	Fri,  7 Mar 2025 00:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741306371;
	bh=KwzqVNQ/LxOFE9lZkWbvcHponjUKYCapTArWFogQfNk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Z/pByONJA/0LRRiWF7FrMDtcUAbriUUVwq79Kp9QcOY9ZEnCefpnhI5EipG9HI1tk
	 q87NU1V1QWRONrNj/9M5Db6M7JDRwhiM/nYiZPKdH1GFN59pvPZaLgNXVRY+v3/aQ5
	 cjCxuzwhCFoiX4aoQltKn17m9H+useOJgc79qS0ktrMLIYfV9c4Alc4DAjxCgTSDVF
	 RHgEHcqV/vj4t3NLhw2rnF1gZzc4+bWZc2OtCIq4P9FpDQNbMqziU6VZwMPV2YAKW2
	 nj3cyVzNMTaPxo0SKbXC3XJYNtQvL2kScinCSUFRkiuwyQgp9iH+JJbKYnHlQDLxUF
	 ZPD36OHuLccSw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C268C282EC;
	Fri,  7 Mar 2025 00:12:51 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Thu, 06 Mar 2025 19:15:23 -0500
Subject: [PATCH net-next v3 2/8] enic: enic rq code reorg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-enic_cleanup_and_ext_cq-v3-2-92bc165344cf@cisco.com>
References: <20250306-enic_cleanup_and_ext_cq-v3-0-92bc165344cf@cisco.com>
In-Reply-To: <20250306-enic_cleanup_and_ext_cq-v3-0-92bc165344cf@cisco.com>
To: Christian Benvenuti <benve@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Satish Kharat <satishkh@cisco.com>, Nelson Escobar <neescoba@cisco.com>, 
 John Daley <johndale@cisco.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741306525; l=10123;
 i=satishkh@cisco.com; s=20250226; h=from:subject:message-id;
 bh=usLTTlOTavjszE6uI3ZNF/H1lQeYn6GzIK95AM6KJz0=;
 b=mr6mMDvkW9IRSJ9FYfVnCU0ydAizeSKfevqPPOLjm3KHENDD1DrApslExdyJHHkP3DvPDYMUK
 eXvkvTVxjDoA0eWbY3pnY4W2TZjAYR87EQsLGlZsHWvO9rIu9hlhSPk
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=lkxzORFYn5ejiy0kzcsfkpGoXZDcnHMc4n3YK7jJnJo=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/20250226 with
 auth_id=351
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com

From: Satish Kharat <satishkh@cisco.com>

Separates enic rx path from generic vnic api. Removes some
complexity of doign enic callbacks through vnic api in rx.
This is in preparation for enabling enic extended cq which
applies only to enic rx path.

Co-developed-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Co-developed-by: John Daley <johndale@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_main.c |   6 +-
 drivers/net/ethernet/cisco/enic/enic_rq.c   | 119 ++++++++++++++++++++--------
 drivers/net/ethernet/cisco/enic/enic_rq.h   |   6 +-
 drivers/net/ethernet/cisco/enic/vnic_cq.h   |  14 ++++
 4 files changed, 106 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index f24fd29ea2071f88b3fa79e7768238a24384970e..080234ef4c2bb53c19e26601ca9bb38d26a738b7 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -1386,8 +1386,7 @@ static int enic_poll(struct napi_struct *napi, int budget)
 				       enic_wq_service, NULL);
 
 	if (budget > 0)
-		rq_work_done = vnic_cq_service(&enic->cq[cq_rq],
-			rq_work_to_do, enic_rq_service, NULL);
+		rq_work_done = enic_rq_cq_service(enic, cq_rq, rq_work_to_do);
 
 	/* Accumulate intr event credits for this polling
 	 * cycle.  An intr event is the completion of a
@@ -1516,8 +1515,7 @@ static int enic_poll_msix_rq(struct napi_struct *napi, int budget)
 	 */
 
 	if (budget > 0)
-		work_done = vnic_cq_service(&enic->cq[cq],
-			work_to_do, enic_rq_service, NULL);
+		work_done = enic_rq_cq_service(enic, cq, work_to_do);
 
 	/* Return intr event credits for this polling
 	 * cycle.  An intr event is the completion of a
diff --git a/drivers/net/ethernet/cisco/enic/enic_rq.c b/drivers/net/ethernet/cisco/enic/enic_rq.c
index 7360799326e8bd8ac8f102c3e3b3b4814f66b97f..842b273c2e2a59e81a7c1423449b023d646f5e81 100644
--- a/drivers/net/ethernet/cisco/enic/enic_rq.c
+++ b/drivers/net/ethernet/cisco/enic/enic_rq.c
@@ -21,14 +21,26 @@ static void enic_intr_update_pkt_size(struct vnic_rx_bytes_counter *pkt_size,
 		pkt_size->small_pkt_bytes_cnt += pkt_len;
 }
 
-int enic_rq_service(struct vnic_dev *vdev, struct cq_desc *cq_desc, u8 type,
-		    u16 q_number, u16 completed_index, void *opaque)
+static void enic_rq_cq_desc_dec(struct cq_enet_rq_desc *desc, u8 *type,
+				u8 *color, u16 *q_number, u16 *completed_index)
 {
-	struct enic *enic = vnic_dev_priv(vdev);
-
-	vnic_rq_service(&enic->rq[q_number].vrq, cq_desc, completed_index,
-			VNIC_RQ_RETURN_DESC, enic_rq_indicate_buf, opaque);
-	return 0;
+	/* type_color is the last field for all cq structs */
+	u8 type_color = desc->type_color;
+
+	/* Make sure color bit is read from desc *before* other fields
+	 * are read from desc.  Hardware guarantees color bit is last
+	 * bit (byte) written.  Adding the rmb() prevents the compiler
+	 * and/or CPU from reordering the reads which would potentially
+	 * result in reading stale values.
+	 */
+	rmb();
+
+	*q_number = le16_to_cpu(desc->q_number_rss_type_flags) &
+		CQ_DESC_Q_NUM_MASK;
+	*completed_index = le16_to_cpu(desc->completed_index_flags) &
+	CQ_DESC_COMP_NDX_MASK;
+	*color = (type_color >> CQ_DESC_COLOR_SHIFT) & CQ_DESC_COLOR_MASK;
+	*type = type_color & CQ_DESC_TYPE_MASK;
 }
 
 static void enic_rq_set_skb_flags(struct vnic_rq *vrq, u8 type, u32 rss_hash,
@@ -101,10 +113,9 @@ static void enic_rq_set_skb_flags(struct vnic_rq *vrq, u8 type, u32 rss_hash,
 	}
 }
 
-static void cq_enet_rq_desc_dec(struct cq_enet_rq_desc *desc, u8 *type,
-				u8 *color, u16 *q_number, u16 *completed_index,
-				u8 *ingress_port, u8 *fcoe, u8 *eop, u8 *sop,
-				u8 *rss_type, u8 *csum_not_calc, u32 *rss_hash,
+static void cq_enet_rq_desc_dec(struct cq_enet_rq_desc *desc, u8 *ingress_port,
+				u8 *fcoe, u8 *eop, u8 *sop, u8 *rss_type,
+				u8 *csum_not_calc, u32 *rss_hash,
 				u16 *bytes_written, u8 *packet_error,
 				u8 *vlan_stripped, u16 *vlan_tci,
 				u16 *checksum, u8 *fcoe_sof,
@@ -117,9 +128,6 @@ static void cq_enet_rq_desc_dec(struct cq_enet_rq_desc *desc, u8 *type,
 	u16 q_number_rss_type_flags;
 	u16 bytes_written_flags;
 
-	cq_desc_dec((struct cq_desc *)desc, type,
-		    color, q_number, completed_index);
-
 	completed_index_flags = le16_to_cpu(desc->completed_index_flags);
 	q_number_rss_type_flags =
 		le16_to_cpu(desc->q_number_rss_type_flags);
@@ -249,37 +257,33 @@ void enic_free_rq_buf(struct vnic_rq *rq, struct vnic_rq_buf *buf)
 	buf->os_buf = NULL;
 }
 
-void enic_rq_indicate_buf(struct vnic_rq *rq, struct cq_desc *cq_desc,
-			  struct vnic_rq_buf *buf, int skipped, void *opaque)
+static void enic_rq_indicate_buf(struct enic *enic, struct vnic_rq *rq,
+				 struct vnic_rq_buf *buf,
+				 struct cq_enet_rq_desc *cq_desc, u8 type,
+				 u16 q_number, u16 completed_index)
 {
-	struct enic *enic = vnic_dev_priv(rq->vdev);
 	struct sk_buff *skb;
 	struct vnic_cq *cq = &enic->cq[enic_cq_rq(enic, rq->index)];
 	struct enic_rq_stats *rqstats = &enic->rq[rq->index].stats;
 	struct napi_struct *napi;
 
-	u8 type, color, eop, sop, ingress_port, vlan_stripped;
+	u8 eop, sop, ingress_port, vlan_stripped;
 	u8 fcoe, fcoe_sof, fcoe_fc_crc_ok, fcoe_enc_error, fcoe_eof;
 	u8 tcp_udp_csum_ok, udp, tcp, ipv4_csum_ok;
 	u8 ipv6, ipv4, ipv4_fragment, fcs_ok, rss_type, csum_not_calc;
 	u8 packet_error;
-	u16 q_number, completed_index, bytes_written, vlan_tci, checksum;
+	u16 bytes_written, vlan_tci, checksum;
 	u32 rss_hash;
 
 	rqstats->packets++;
-	if (skipped) {
-		rqstats->desc_skip++;
-		return;
-	}
 
-	cq_enet_rq_desc_dec((struct cq_enet_rq_desc *)cq_desc, &type, &color,
-			    &q_number, &completed_index, &ingress_port, &fcoe,
-			    &eop, &sop, &rss_type, &csum_not_calc, &rss_hash,
-			    &bytes_written, &packet_error, &vlan_stripped,
-			    &vlan_tci, &checksum, &fcoe_sof, &fcoe_fc_crc_ok,
-			    &fcoe_enc_error, &fcoe_eof, &tcp_udp_csum_ok, &udp,
-			    &tcp, &ipv4_csum_ok, &ipv6, &ipv4, &ipv4_fragment,
-			    &fcs_ok);
+	cq_enet_rq_desc_dec(cq_desc, &ingress_port,
+			    &fcoe, &eop, &sop, &rss_type, &csum_not_calc,
+			    &rss_hash, &bytes_written, &packet_error,
+			    &vlan_stripped, &vlan_tci, &checksum, &fcoe_sof,
+			    &fcoe_fc_crc_ok, &fcoe_enc_error, &fcoe_eof,
+			    &tcp_udp_csum_ok, &udp, &tcp, &ipv4_csum_ok, &ipv6,
+			    &ipv4, &ipv4_fragment, &fcs_ok);
 
 	if (enic_rq_pkt_error(rq, packet_error, fcs_ok, bytes_written))
 		return;
@@ -324,3 +328,56 @@ void enic_rq_indicate_buf(struct vnic_rq *rq, struct cq_desc *cq_desc,
 		rqstats->pkt_truncated++;
 	}
 }
+
+static void enic_rq_service(struct enic *enic, struct cq_enet_rq_desc *cq_desc,
+			    u8 type, u16 q_number, u16 completed_index)
+{
+	struct enic_rq_stats *rqstats = &enic->rq[q_number].stats;
+	struct vnic_rq *vrq = &enic->rq[q_number].vrq;
+	struct vnic_rq_buf *vrq_buf = vrq->to_clean;
+	int skipped;
+
+	while (1) {
+		skipped = (vrq_buf->index != completed_index);
+		if (!skipped)
+			enic_rq_indicate_buf(enic, vrq, vrq_buf, cq_desc, type,
+					     q_number, completed_index);
+		else
+			rqstats->desc_skip++;
+
+		vrq->ring.desc_avail++;
+		vrq->to_clean = vrq_buf->next;
+		vrq_buf = vrq_buf->next;
+		if (!skipped)
+			break;
+	}
+}
+
+unsigned int enic_rq_cq_service(struct enic *enic, unsigned int cq_index,
+				unsigned int work_to_do)
+{
+	struct vnic_cq *cq = &enic->cq[cq_index];
+	struct cq_enet_rq_desc *cq_desc;
+	u16 q_number, completed_index;
+	unsigned int work_done = 0;
+	u8 type, color;
+
+	cq_desc = (struct cq_enet_rq_desc *)vnic_cq_to_clean(cq);
+
+	enic_rq_cq_desc_dec(cq_desc,  &type, &color, &q_number,
+			    &completed_index);
+
+	while (color != cq->last_color) {
+		enic_rq_service(enic, cq_desc, type, q_number, completed_index);
+		vnic_cq_inc_to_clean(cq);
+
+		if (++work_done >= work_to_do)
+			break;
+
+		cq_desc = (struct cq_enet_rq_desc *)vnic_cq_to_clean(cq);
+		enic_rq_cq_desc_dec(cq_desc, &type, &color, &q_number,
+				    &completed_index);
+	}
+
+	return work_done;
+}
diff --git a/drivers/net/ethernet/cisco/enic/enic_rq.h b/drivers/net/ethernet/cisco/enic/enic_rq.h
index a75d07562686af0a1ad618803f5f70a77fbc1eec..98476a7297afbba83aa0f4281bf9314ea3fd9f27 100644
--- a/drivers/net/ethernet/cisco/enic/enic_rq.h
+++ b/drivers/net/ethernet/cisco/enic/enic_rq.h
@@ -2,9 +2,7 @@
  * Copyright 2024 Cisco Systems, Inc.  All rights reserved.
  */
 
-int enic_rq_service(struct vnic_dev *vdev, struct cq_desc *cq_desc, u8 type,
-		    u16 q_number, u16 completed_index, void *opaque);
-void enic_rq_indicate_buf(struct vnic_rq *rq, struct cq_desc *cq_desc,
-			  struct vnic_rq_buf *buf, int skipped, void *opaque);
+unsigned int enic_rq_cq_service(struct enic *enic, unsigned int cq_index,
+				unsigned int work_to_do);
 int enic_rq_alloc_buf(struct vnic_rq *rq);
 void enic_free_rq_buf(struct vnic_rq *rq, struct vnic_rq_buf *buf);
diff --git a/drivers/net/ethernet/cisco/enic/vnic_cq.h b/drivers/net/ethernet/cisco/enic/vnic_cq.h
index eed5bf59e5d2c87bf240a96638cc4f58cd17c79c..21d97c01f9424fde3d3c1d9b6cb4b7ef6de144b1 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_cq.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_cq.h
@@ -97,6 +97,20 @@ static inline unsigned int vnic_cq_service(struct vnic_cq *cq,
 	return work_done;
 }
 
+static inline void *vnic_cq_to_clean(struct vnic_cq *cq)
+{
+	return ((u8 *)cq->ring.descs + cq->ring.desc_size * cq->to_clean);
+}
+
+static inline void vnic_cq_inc_to_clean(struct vnic_cq *cq)
+{
+	cq->to_clean++;
+	if (cq->to_clean == cq->ring.desc_count) {
+		cq->to_clean = 0;
+		cq->last_color = cq->last_color ? 0 : 1;
+	}
+}
+
 void vnic_cq_free(struct vnic_cq *cq);
 int vnic_cq_alloc(struct vnic_dev *vdev, struct vnic_cq *cq, unsigned int index,
 	unsigned int desc_count, unsigned int desc_size);

-- 
2.48.1



