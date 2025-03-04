Return-Path: <netdev+bounces-171577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BF5A4DB27
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 11:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B4381760A2
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 10:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C150C1FECAA;
	Tue,  4 Mar 2025 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcEYvKgp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922441FDE2B;
	Tue,  4 Mar 2025 10:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084842; cv=none; b=ZJMOW3AIsy5+jO05dVPk5ZmlLjnrK+NL35TNwhKFwbWg3hkPSVClfpjRwCOEDAnQ2IcAEsoUHM9fDNFq2G8QEGcUkQ7EzkJrf4U6WPSRlHdi8aaDw5bN2xxTbYxXMd0I7dqRPLdONxFSHr1/s1yrq+5EZyjHzvrPX8qJGtX4viw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084842; c=relaxed/simple;
	bh=hbnyvuWuqdGr5ygHxpvX7F24ksN3p0p3uUkgfdnkrjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eqfmh1IiESUzJn6b12WwAa0lPgPI+H5kNASK0SKZj1K1H9cywK+0MsKuU2XlTeuvniQfphhGdr7GR2ZbIUMWBgotHE9gDxA7UaJlWDoy8p3cBm7ahu7Y5hsct3+b62gX/YO04/ZqbZBLyfKIqgKz1Ypt+Qwl7jZXZTGlXsKhgRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcEYvKgp; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-549681574e0so2141611e87.2;
        Tue, 04 Mar 2025 02:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741084839; x=1741689639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rZaNXG2sGxfm60Sk9mhhTQ9Kdjne1uye23ZjRrkOk2U=;
        b=PcEYvKgpuQqU9xDwmTmdybZ0//0+r2BnIkew4fUrgwQsjY4GX3WU3krqYJ8Iql4hHk
         2wpVsbBmtbBuJUXi/O7kXV8lMNF/Kgo2k1cOMuC1UNdBxnH/xE75rR/poPTM2IZN57iG
         rrTG58VYBgNZqxJl4XJ6kRYmUhlgeEcMdx7Knvy1cpaE6s7+i8kgAZ5ZCObXH3bXGpfh
         Tc0LKR1Bz1PhOgkuYb/9QbL3QWpASSci0g1viv5sBvcgshCQj++rzH/ac7LshQS1u1lC
         VoDKF8RnWhLRLZTtkjmMXV1lp4NhlRBkxjaPP09pfOLCVwEWgSAdg7MTP2nIHV33YJB4
         Ugeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741084839; x=1741689639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZaNXG2sGxfm60Sk9mhhTQ9Kdjne1uye23ZjRrkOk2U=;
        b=LRqGSxrW/zJ+SPWWcfcDgkqjB95P1F3PwWkVsjGewsqCGkyTlBS6djoO/AP5JPI4kR
         LLop7ahyOt48ng6CVlr494F/px/LtLyiYt+sXExfst4W3WHMlcEgk6LFl6zkJ2H61Lwf
         yPTP6R9XYr436gLm4ec4f/A6CnOnxXzx/LMRjsNNRoqANeQH8m6ULEmsFoXv/W85H7QW
         nlpi3bGwUbG3DQn+viX7Xyqqw6OzX1JQisW+I4mKn5KVWNW3nI9IatuxCffaoY+bzlgR
         eyErOrm0SlHaeSAH1fH4qWE5NO8mJ0beTjVEluc1bgRhcwAKnCuZ68BcDox0/vb8W2+o
         CFQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/BzThOX8u/vlIiw2ngtN/aw/DZ1Y20fy1Jazg9cBAg5r5E0z2Y69E+JdLzX7usND/kfBY2y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSxZItFgIPJjApdMXARD2ww5SsHf1tSex+W55XQokjhpdCQiOe
	c742p7eUPj3lLuQOv3BxKVWBv4mZsiOIdvpgoAbqyzvUvN6zak2+sE9fpZ6Y
X-Gm-Gg: ASbGncsvqwVVLwNBu/l53AczOuU9T6XmisIG3tZmc8NiJgIdIawXnDRdZBBlriVjyAV
	EEgq6Udc/WhWYzPeDT5clY3/9HHXy3tQyDxzy59v8YwHJBI0PeJ+3x3H9P5FFkelljzDG+t/H11
	QwNp1DN0aRQ54g5uWneW1kJl2lecG0cvRic3rubhVY+9u09//+BiC+n4gFEWYKLR8bPEUshsOb2
	Hzk4G+m5IdP0scio73G0GkVhBaIQRKQ+ysLFqsF8M7HPbjovMHoLEzR4qlZAXs02D7C8NiBxbqc
	XrrVA6mJEDEUcjbpgBHJc6d/FMih7i4//K5DcZFsGTZU0AvacqRz6T63I6InSpMuojk=
X-Google-Smtp-Source: AGHT+IHODiRGEdT5dgFMN5VMRCIPTbxX3KSz3Zd4LuhfEUA5xaINBUfIQrhwW5VFH4t2tEelZjg43A==
X-Received: by 2002:a05:6512:3d19:b0:548:794f:f9dd with SMTP id 2adb3069b0e04-5494c111896mr5570400e87.10.1741084838237;
        Tue, 04 Mar 2025 02:40:38 -0800 (PST)
Received: from FI-L-7486715.nmea.abb.com ([147.161.186.106])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5495f4c36d1sm798824e87.52.2025.03.04.02.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 02:40:37 -0800 (PST)
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
Subject: [PATCH net-next v4 1/2] net: hsr: Fix PRP duplicate detection
Date: Tue,  4 Mar 2025 12:40:29 +0200
Message-ID: <20250304104030.69395-1-jkarrenpalo@gmail.com>
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


