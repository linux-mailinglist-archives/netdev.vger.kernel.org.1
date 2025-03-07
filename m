Return-Path: <netdev+bounces-173007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 519FDA56D5C
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 17:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FAF6189472C
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 16:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983002376E0;
	Fri,  7 Mar 2025 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Afdv8ICT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C68121770E;
	Fri,  7 Mar 2025 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741364232; cv=none; b=lQdnYzGEMBw2TKGYzQWWGz6RO3uqSxBJTuSZwgr9ieFd/2lABAiQv4NUufZRA/QWr+mKkTPbDAaGDumi9m0L7SpQ4yaYpv5PX8nM3uXcyzMbsyWX+d30us+t8tnGY09GnSgQA68qjH+NEck10Uco0VT6CE3LUydH93TAfQWuWfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741364232; c=relaxed/simple;
	bh=hbnyvuWuqdGr5ygHxpvX7F24ksN3p0p3uUkgfdnkrjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kCABFpHQUchvhQG3QTSEKk9nVMRbA2P6XLFuE/34wYDuD5US3bnWgRsjbxsiT0hmB4cKDSUoIaX2txcyXxJiz4jUxWd2h7AJLNagWz+p8Gc2STMAzl6/AHnNhe8J98K9M2VjKqO5oSeew5wUToFi/cU4izUuuNPdynuAJllWvqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Afdv8ICT; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30b83290b7bso23137441fa.1;
        Fri, 07 Mar 2025 08:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741364228; x=1741969028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rZaNXG2sGxfm60Sk9mhhTQ9Kdjne1uye23ZjRrkOk2U=;
        b=Afdv8ICThBfxA5dNaSMGZ4o6QmzBN/R8zV2qM6Wx0mxD6pdGFejGHGT9XmcTvR3woS
         K3InsFCtVE5mu/TDAfg4mt0uoYCr8EGR3E2Mzm9XCpZLZp0VkZ+U40pSeS+oTyI03YGC
         tKPO/LdPUnXdQUIDVPDdJMP5RmMyX0360+46T69EW+ra9ee0oJi5cHFoZ3D6Tx7royeM
         EkxBQAaU6RazLGsnAv7mCn10+7bHezHy1R4AgfHvLavwXIzo2CZ6/0drks187IEt2A4i
         /5QXXOirZIgJWZDPRcwDXEjR/KXhsKmiJHqB3ywnb8LGnboa3rWy33fFk/VOT5oAO4kp
         3S3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741364228; x=1741969028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZaNXG2sGxfm60Sk9mhhTQ9Kdjne1uye23ZjRrkOk2U=;
        b=oTUfwSoyqsDLDjWZxwW5FWulwvV4lToPw3o5+9LyKQ6i778Nk4JzjUo6rQAUnjmbA0
         u9bJt+RHieQjQ4o7cnQQ4YYuq3idIpPE1q9g+nmvGC3eyVa8rxZAY8GwDtkFxTYYHaMP
         P81rIGhj60wu3X8S3Ea6KWFV9ZwAGQ4Unv+VxN5NQt5wxclotXtvWwQXQvgR3KERdGl/
         AZQIXdGtM5cCXTdX6UsgUw8Gfnqg/fxzw3vnvv/fkF3ifyk5juUFsH++TeSPFAjuBAVi
         U2fVzhbufD0o5i0aUcxRERxwabMttC+gjLGmQVu/RYVDMfMnwcGFjPRiF4Bl+h64JRbX
         lm4A==
X-Forwarded-Encrypted: i=1; AJvYcCWnspIrX2N+k02JwAbT/COVckUnBDhGpEWjhXC+9yAi/k7JRHpuJAaF/t5VQgPuUhy3vVvbQZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDey6+rCnJn2/2dyUOgqJ89dlgPZBgvET0jx1fM04HkTqzH0rO
	CMlde5y9QX+BJVfJbak6X6y1TsQAs5v9TMU1y1UVhUi4iTVcvFwt
X-Gm-Gg: ASbGncujukxyux4z3z9AHGnuUVn4/n6VAKqHcGNkUbWtsTMmhSdLGcVyfj1zjb/XZzL
	Wfs8PNthz//RsWU7CExIAfv7gVIUHBqxZpfU6Ccg7vr898hoAc60V/9shw55O/zSKLK6Yg6Kbjv
	us0CjjHXO5yB8eIlGj95r9Wn1W/3ViitdYOZDPosw+VzQV5Z9KScxSqB99hwCGoVRet/pGk43vf
	W/HLHgeZcg7ijKDRHc2JF5EZlU8IY4DF+KL6LUcWL/jstSSMbjUlEgkCKq9kAwHDf+gSnjs5F9B
	ty4RAMvkZYj8Rz40JXZ8XOg1QRrHrv/pRthtunnaUsu44nIsbJ1P5laL9T7Qxf5VP4A=
X-Google-Smtp-Source: AGHT+IFwfp8fYt6Uuq3OLG3jtqyMmF8MtcotuF9IhKrlg+E57qF+N58dl70gVb0peT2lek1GFPU8Nw==
X-Received: by 2002:a2e:bc1d:0:b0:30b:fc3b:417f with SMTP id 38308e7fff4ca-30bfc3b439amr7149511fa.10.1741364228194;
        Fri, 07 Mar 2025 08:17:08 -0800 (PST)
Received: from FI-L-7486715.nmea.abb.com ([147.161.186.106])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30be98d0b35sm5739831fa.16.2025.03.07.08.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 08:17:07 -0800 (PST)
From: Jaakko Karrenpalo <jkarrenpalo@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Lukasz Majewski <lukma@denx.de>,
	MD Danish Anwar <danishanwar@ti.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Jaakko Karrenpalo <jaakko.karrenpalo@fi.abb.com>,
	Jaakko Karrenpalo <jkarrenpalo@gmail.com>
Subject: [PATCH net-next v5 1/2] net: hsr: Fix PRP duplicate detection
Date: Fri,  7 Mar 2025 18:16:59 +0200
Message-ID: <20250307161700.1045-1-jkarrenpalo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add PRP specific function for handling duplicate
packets. This is needed because of potential
L2 802.1p prioritization done by network switches.

The L2 prioritization can re-order the PRP packets
from a node causing the existing implementation to
discard the frame(s) that have been received 'late'
because the sequence number is before the previous
received packet. This can happen if the node is
sending multiple frames back-to-back with different
priority.

Signed-off-by: Jaakko Karrenpalo <jkarrenpalo@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
Changes in v3:
- Fixed indentation
- Renamed local variables
Changes in v4:
- Fix indentation issues missed in previous version

Thanks to Paolo and Simon for reviewing!

 net/hsr/hsr_device.c   |  2 +
 net/hsr/hsr_forward.c  |  4 +-
 net/hsr/hsr_framereg.c | 95 ++++++++++++++++++++++++++++++++++++++++--
 net/hsr/hsr_framereg.h |  8 +++-
 net/hsr/hsr_main.h     |  2 +
 5 files changed, 104 insertions(+), 7 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index b6fb18469439..2c43776b7c4f 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -616,6 +616,7 @@ static struct hsr_proto_ops hsr_ops = {
 	.drop_frame = hsr_drop_frame,
 	.fill_frame_info = hsr_fill_frame_info,
 	.invalid_dan_ingress_frame = hsr_invalid_dan_ingress_frame,
+	.register_frame_out = hsr_register_frame_out,
 };
 
 static struct hsr_proto_ops prp_ops = {
@@ -626,6 +627,7 @@ static struct hsr_proto_ops prp_ops = {
 	.fill_frame_info = prp_fill_frame_info,
 	.handle_san_frame = prp_handle_san_frame,
 	.update_san_info = prp_update_san_info,
+	.register_frame_out = prp_register_frame_out,
 };
 
 void hsr_dev_setup(struct net_device *dev)
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index a4bacf198555..c67c0d35921d 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -536,8 +536,8 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
 		 * Also for SAN, this shouldn't be done.
 		 */
 		if (!frame->is_from_san &&
-		    hsr_register_frame_out(port, frame->node_src,
-					   frame->sequence_nr))
+		    hsr->proto_ops->register_frame_out &&
+		    hsr->proto_ops->register_frame_out(port, frame))
 			continue;
 
 		if (frame->is_supervision && port->type == HSR_PT_MASTER &&
diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 73bc6f659812..85991fab7db5 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -35,6 +35,7 @@ static bool seq_nr_after(u16 a, u16 b)
 
 #define seq_nr_before(a, b)		seq_nr_after((b), (a))
 #define seq_nr_before_or_eq(a, b)	(!seq_nr_after((a), (b)))
+#define PRP_DROP_WINDOW_LEN 32768
 
 bool hsr_addr_is_redbox(struct hsr_priv *hsr, unsigned char *addr)
 {
@@ -176,8 +177,11 @@ static struct hsr_node *hsr_add_node(struct hsr_priv *hsr,
 		new_node->time_in[i] = now;
 		new_node->time_out[i] = now;
 	}
-	for (i = 0; i < HSR_PT_PORTS; i++)
+	for (i = 0; i < HSR_PT_PORTS; i++) {
 		new_node->seq_out[i] = seq_out;
+		new_node->seq_expected[i] = seq_out + 1;
+		new_node->seq_start[i] = seq_out + 1;
+	}
 
 	if (san && hsr->proto_ops->handle_san_frame)
 		hsr->proto_ops->handle_san_frame(san, rx_port, new_node);
@@ -482,9 +486,11 @@ void hsr_register_frame_in(struct hsr_node *node, struct hsr_port *port,
  *	 0 otherwise, or
  *	 negative error code on error
  */
-int hsr_register_frame_out(struct hsr_port *port, struct hsr_node *node,
-			   u16 sequence_nr)
+int hsr_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
 {
+	struct hsr_node *node = frame->node_src;
+	u16 sequence_nr = frame->sequence_nr;
+
 	spin_lock_bh(&node->seq_out_lock);
 	if (seq_nr_before_or_eq(sequence_nr, node->seq_out[port->type]) &&
 	    time_is_after_jiffies(node->time_out[port->type] +
@@ -499,6 +505,89 @@ int hsr_register_frame_out(struct hsr_port *port, struct hsr_node *node,
 	return 0;
 }
 
+/* Adaptation of the PRP duplicate discard algorithm described in wireshark
+ * wiki (https://wiki.wireshark.org/PRP)
+ *
+ * A drop window is maintained for both LANs with start sequence set to the
+ * first sequence accepted on the LAN that has not been seen on the other LAN,
+ * and expected sequence set to the latest received sequence number plus one.
+ *
+ * When a frame is received on either LAN it is compared against the received
+ * frames on the other LAN. If it is outside the drop window of the other LAN
+ * the frame is accepted and the drop window is updated.
+ * The drop window for the other LAN is reset.
+ *
+ * 'port' is the outgoing interface
+ * 'frame' is the frame to be sent
+ *
+ * Return:
+ *	 1 if frame can be shown to have been sent recently on this interface,
+ *	 0 otherwise
+ */
+int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
+{
+	enum hsr_port_type other_port;
+	enum hsr_port_type rcv_port;
+	struct hsr_node *node;
+	u16 sequence_diff;
+	u16 sequence_exp;
+	u16 sequence_nr;
+
+	/* out-going frames are always in order
+	 * and can be checked the same way as for HSR
+	 */
+	if (frame->port_rcv->type == HSR_PT_MASTER)
+		return hsr_register_frame_out(port, frame);
+
+	/* for PRP we should only forward frames from the slave ports
+	 * to the master port
+	 */
+	if (port->type != HSR_PT_MASTER)
+		return 1;
+
+	node = frame->node_src;
+	sequence_nr = frame->sequence_nr;
+	sequence_exp = sequence_nr + 1;
+	rcv_port = frame->port_rcv->type;
+	other_port = rcv_port == HSR_PT_SLAVE_A ? HSR_PT_SLAVE_B :
+				 HSR_PT_SLAVE_A;
+
+	spin_lock_bh(&node->seq_out_lock);
+	if (time_is_before_jiffies(node->time_out[port->type] +
+	    msecs_to_jiffies(HSR_ENTRY_FORGET_TIME)) ||
+	    (node->seq_start[rcv_port] == node->seq_expected[rcv_port] &&
+	     node->seq_start[other_port] == node->seq_expected[other_port])) {
+		/* the node hasn't been sending for a while
+		 * or both drop windows are empty, forward the frame
+		 */
+		node->seq_start[rcv_port] = sequence_nr;
+	} else if (seq_nr_before(sequence_nr, node->seq_expected[other_port]) &&
+		   seq_nr_before_or_eq(node->seq_start[other_port], sequence_nr)) {
+		/* drop the frame, update the drop window for the other port
+		 * and reset our drop window
+		 */
+		node->seq_start[other_port] = sequence_exp;
+		node->seq_expected[rcv_port] = sequence_exp;
+		node->seq_start[rcv_port] = node->seq_expected[rcv_port];
+		spin_unlock_bh(&node->seq_out_lock);
+		return 1;
+	}
+
+	/* update the drop window for the port where this frame was received
+	 * and clear the drop window for the other port
+	 */
+	node->seq_start[other_port] = node->seq_expected[other_port];
+	node->seq_expected[rcv_port] = sequence_exp;
+	sequence_diff = sequence_exp - node->seq_start[rcv_port];
+	if (sequence_diff > PRP_DROP_WINDOW_LEN)
+		node->seq_start[rcv_port] = sequence_exp - PRP_DROP_WINDOW_LEN;
+
+	node->time_out[port->type] = jiffies;
+	node->seq_out[port->type] = sequence_nr;
+	spin_unlock_bh(&node->seq_out_lock);
+	return 0;
+}
+
 static struct hsr_port *get_late_port(struct hsr_priv *hsr,
 				      struct hsr_node *node)
 {
diff --git a/net/hsr/hsr_framereg.h b/net/hsr/hsr_framereg.h
index 993fa950d814..b04948659d84 100644
--- a/net/hsr/hsr_framereg.h
+++ b/net/hsr/hsr_framereg.h
@@ -44,8 +44,7 @@ void hsr_addr_subst_dest(struct hsr_node *node_src, struct sk_buff *skb,
 
 void hsr_register_frame_in(struct hsr_node *node, struct hsr_port *port,
 			   u16 sequence_nr);
-int hsr_register_frame_out(struct hsr_port *port, struct hsr_node *node,
-			   u16 sequence_nr);
+int hsr_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame);
 
 void hsr_prune_nodes(struct timer_list *t);
 void hsr_prune_proxy_nodes(struct timer_list *t);
@@ -73,6 +72,8 @@ void prp_update_san_info(struct hsr_node *node, bool is_sup);
 bool hsr_is_node_in_db(struct list_head *node_db,
 		       const unsigned char addr[ETH_ALEN]);
 
+int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame);
+
 struct hsr_node {
 	struct list_head	mac_list;
 	/* Protect R/W access to seq_out */
@@ -89,6 +90,9 @@ struct hsr_node {
 	bool			san_b;
 	u16			seq_out[HSR_PT_PORTS];
 	bool			removed;
+	/* PRP specific duplicate handling */
+	u16			seq_expected[HSR_PT_PORTS];
+	u16			seq_start[HSR_PT_PORTS];
 	struct rcu_head		rcu_head;
 };
 
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 7561845b8bf6..1bc47b17a296 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -175,6 +175,8 @@ struct hsr_proto_ops {
 			       struct hsr_frame_info *frame);
 	bool (*invalid_dan_ingress_frame)(__be16 protocol);
 	void (*update_san_info)(struct hsr_node *node, bool is_sup);
+	int (*register_frame_out)(struct hsr_port *port,
+				  struct hsr_frame_info *frame);
 };
 
 struct hsr_self_node {
-- 
2.43.0


