Return-Path: <netdev+bounces-168463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 195F4A3F17D
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 11:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 178DB1690E0
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D7F204C39;
	Fri, 21 Feb 2025 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6gz5OvM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0501E5B78;
	Fri, 21 Feb 2025 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740132632; cv=none; b=JwEDVzM1fyJIQh6obt12ExyaXdw4GK0GKKQJPFxTkAeoVeGantWDvabuICITML5MuS+hMT6t9nOkAMlE3P9fXSVzXvnkikk0E1TwCD3OMmDZ4UKdTILWa2cWkJXkI5Lj/WzOaC01U+adP1R+6dUN3jsg69j/9XTOUmCFJjrRjfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740132632; c=relaxed/simple;
	bh=wlptftT9TNPT2Wcv9+geiPqs7J3eu1auQHoiSMtTSto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UMtHbuVL2Iom7vtoJZvhJY2lZf5+Vd1UsetIegVCPFrb1/Xak3fFNRBnS3v0h5cYi9IoM62GkymkA8fjo44za9DfsQ/eLz+749PSHIlDecqkK+HQlWriVuJEGIHY8DuxN7eJO0xHufGUXmefoTJTENSSKnkeL7+AVKNvX7EbKds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6gz5OvM; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5461cb12e39so1803201e87.2;
        Fri, 21 Feb 2025 02:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740132628; x=1740737428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zqPEUM8CWBkBnaiq8nBKteDjqMZo/rUNGmbvJpBUdaY=;
        b=G6gz5OvM8kSJN+WL52HHORFDynGE2/MU3Yt1Gybq5ExKLpPn1A6cISmdboIQIwDmdm
         JrTWAsGWvDaNPggUTJG2Q0zfPnBslUlN9AHw3Ofs5u+gP7GT/781NGbpLQzqJkoU+mEe
         9/u9TOEfODh4i8yeRqRtvQBRy3o9rEtq+RomVEw5l634/Zhu+ykp4HuNF1CCJ+wXbc5Z
         4VmY3kuAWng6VM5U92+iJDk9EfMQR1h/0YuI0Itf3IGpkSSKvx3NexgTbZopMYJR3H9j
         F8q/U8+2Q6GUKiEqBB+L941G9RVKrR5soN4pv4wEUxbklocrLqrz52eGNKpsDWmXZJgM
         86bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740132628; x=1740737428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zqPEUM8CWBkBnaiq8nBKteDjqMZo/rUNGmbvJpBUdaY=;
        b=JfIrhc94pbas8iUItAHUt9mfIAt8Xzp17ajjYf7rsL2gQwMeoPP56ZP7alVlQ8NV2h
         Gu44u8r0/WFZW5Apmt1xT6DvjkvxyRTbJCV2X+ukfkjs5rT/2EqKGCL0ldnZt5ucKZAl
         LoU7/XYnoKm8JkHYXweas0tQQCNm0cNFocFrsKCcJL/W2dWlbexhU+xYXbyMGnYfDFEp
         72pHauO1cFT7WbobGYGUEzDEB/JDVgEw60t2xEnYEx0t+jFguHGFWP+cBeD/bWheB/VP
         gA6raND/VBsIw3KSuGckvd2SaEsGXgeG4G21Tj2TBBq27uVt/GCleUcXeJC1XOleJaI5
         uFYw==
X-Forwarded-Encrypted: i=1; AJvYcCXI7LknxVcBSPvgI5+ui2vjqeC1Agw1ves05Linebc4zRu9HHBkKi23Vk+AFNogr79VHooGMck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+blMnELh0j7h4TKNKYmlWYkY0DFWclxVgOGoB/ZbZ9Hz4pNWq
	thb6HTX1ycXfDZTF5AbteTemHxiTrV8ug+lBNvJMzKNxhkXvzjv+eWQiNybY1Vw=
X-Gm-Gg: ASbGnctT7Xt5s5Z0OQ6x1YnrxK+BRn/rppSZm6fmv/ioYIthkPqsYGlxwzsc37yVO0R
	68+ZItSB4v897zMOYtemhRAMADhRjNXSWw474NrbJXNKWc/EoF5HD1E9aWb4tMFwbA+CM4hiV3w
	bTBoWKebo+kqVeCb+/DnU4LFWgxITKwifYSRxNv6OiKoBkxGAzdV7OmidEuber04Mu8v0Ew8rWD
	4K1QhIR4N+6gQvTvbDBigz1kwin2mGuR2Ut5vidvseIzTsk22vx6wiQyE4k0QwA8t3kH0HRD7uW
	00sWbltHOm7ba63J21URaHhjC1dMmivOM5Y543fkVoIhjOc=
X-Google-Smtp-Source: AGHT+IFTGRCtCryddXyQLyypDgKtxmrlFtruuFq8ezc0f1owzy2Sl8SNaJCVsLrd3FGNLyFbWg7Ujw==
X-Received: by 2002:a05:6512:3e0d:b0:545:25c6:d6f5 with SMTP id 2adb3069b0e04-54838f5c9ebmr829809e87.53.1740132627734;
        Fri, 21 Feb 2025 02:10:27 -0800 (PST)
Received: from FI-L-7486715.nmea.abb.com ([147.161.186.94])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3092bc01c45sm21255401fa.1.2025.02.21.02.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 02:10:27 -0800 (PST)
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
Subject: [PATCH net-next v2 1/2] net: hsr: Fix PRP duplicate detection
Date: Fri, 21 Feb 2025 12:10:22 +0200
Message-ID: <20250221101023.91915-1-jkarrenpalo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jaakko Karrenpalo <jaakko.karrenpalo@fi.abb.com>

Add PRP specific function for handling duplicate
packets. This is needed because of potential
L2 802.1p prioritization done by network switches.

Signed-off-by: Jaakko Karrenpalo <jaakko.karrenpalo@fi.abb.com>
Signed-off-by: Jaakko Karrenpalo <jkarrenpalo@gmail.com>
---
 net/hsr/hsr_device.c   |  2 +
 net/hsr/hsr_forward.c  |  4 +-
 net/hsr/hsr_framereg.c | 93 ++++++++++++++++++++++++++++++++++++++++--
 net/hsr/hsr_framereg.h |  8 +++-
 net/hsr/hsr_main.h     |  2 +
 5 files changed, 102 insertions(+), 7 deletions(-)

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
index a4bacf198555..aebeced10ad8 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -536,8 +536,8 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
 		 * Also for SAN, this shouldn't be done.
 		 */
 		if (!frame->is_from_san &&
-		    hsr_register_frame_out(port, frame->node_src,
-					   frame->sequence_nr))
+			hsr->proto_ops->register_frame_out &&
+		    hsr->proto_ops->register_frame_out(port, frame))
 			continue;
 
 		if (frame->is_supervision && port->type == HSR_PT_MASTER &&
diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 73bc6f659812..98898f05df6a 100644
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
@@ -499,6 +505,87 @@ int hsr_register_frame_out(struct hsr_port *port, struct hsr_node *node,
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
+	u16 sequence_nr;
+
+	/* out-going frames are always in order
+	 *and can be checked the same way as for HSR
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
+	rcv_port = frame->port_rcv->type;
+	other_port =
+		rcv_port == HSR_PT_SLAVE_A ? HSR_PT_SLAVE_B : HSR_PT_SLAVE_A;
+
+	spin_lock_bh(&node->seq_out_lock);
+	if (time_is_before_jiffies(node->time_out[port->type] +
+	    msecs_to_jiffies(HSR_ENTRY_FORGET_TIME)) ||
+	    (node->seq_start[rcv_port] == node->seq_expected[rcv_port] &&
+	    node->seq_start[other_port] == node->seq_expected[other_port])) {
+		/* the node hasn't been sending for a while
+		 * or both drop windows are empty, forward the frame
+		 */
+		node->seq_start[rcv_port] = sequence_nr;
+	} else if (seq_nr_before(sequence_nr, node->seq_expected[other_port]) &&
+	    seq_nr_before_or_eq(node->seq_start[other_port], sequence_nr)) {
+		/* drop the frame, update the drop window for the other port
+		 * and reset our drop window
+		 */
+		node->seq_start[other_port] = sequence_nr + 1;
+		node->seq_expected[rcv_port] = sequence_nr + 1;
+		node->seq_start[rcv_port] = node->seq_expected[rcv_port];
+		spin_unlock_bh(&node->seq_out_lock);
+		return 1;
+	}
+
+	/* update the drop window for the port where this frame was received
+	 * and clear the drop window for the other port
+	 */
+	node->seq_start[other_port] = node->seq_expected[other_port];
+	node->seq_expected[rcv_port] = sequence_nr + 1;
+	if ((u16)(node->seq_expected[rcv_port] - node->seq_start[rcv_port])
+	    > PRP_DROP_WINDOW_LEN)
+		node->seq_start[rcv_port] =
+			node->seq_expected[rcv_port] - PRP_DROP_WINDOW_LEN;
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


