Return-Path: <netdev+bounces-251898-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPYBHtzdcGnCaQAAu9opvQ
	(envelope-from <netdev+bounces-251898-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:08:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E84AB5827A
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B2499C65A0
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 13:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D07481FDE;
	Wed, 21 Jan 2026 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HfeUaDpU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668A036A038
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 13:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769002694; cv=none; b=ERSV7kiHylr2m47P59HjAMac7nl4ms/cX9FOC2l6d+K0yXmeiCafbK7qz9MTBqmRO84StpRiGBn5Nwu1XU4BtYjwnd0I4ujnzOdFWVw55ytZmYJm8UqUXPwR8+94kdoX5WmnRVCc2BpPTGENNbNOBv7IS7ryQ7b1bdsgzY9noIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769002694; c=relaxed/simple;
	bh=iR6XHmJFA879/yyIsPoScf2YIt0jLu7HWFtTK+winkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDAh7mLneGKza/Cm72LGkY5wBwG5eByDEVVEavZ1lYe6aqMh+yvogkNAuzBBK2nktZjVaqAocPw7BZi8F5b94xH49qU7PUw/Gd7P72tGSUh8BONMolte1gRWoLvkbMH5xS9cKRIdG74uNF8Xw5C4z3XT9oGtfHiDGIwR4Cez1gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HfeUaDpU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769002691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RVCIb6rbCzcctUz+w8XKQqVbZ4BIMGpGw5n1QrjosmA=;
	b=HfeUaDpUfIiIZ3NarpLTM+6MJKUcCTv53TPoCdvhzUbk/P+2FROw1egyqM6vG25dkU6A2I
	qgVSVn2P/41drO5l2zPDWzvUvfJ5LJr64uva/sAEO7sYeg1HO17PsD8pvaPQq1F8Lt64ZJ
	SHVay2Arm7uovM0gKcPk4dqOZt4fbDU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-GqaFi-aoPYapcbedFS0t9Q-1; Wed,
 21 Jan 2026 08:38:07 -0500
X-MC-Unique: GqaFi-aoPYapcbedFS0t9Q-1
X-Mimecast-MFC-AGG-ID: GqaFi-aoPYapcbedFS0t9Q_1769002686
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07B6C180047F;
	Wed, 21 Jan 2026 13:38:06 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.44.33.242])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7229730002D5;
	Wed, 21 Jan 2026 13:38:02 +0000 (UTC)
From: Felix Maurer <fmaurer@redhat.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jkarrenpalo@gmail.com,
	tglx@linutronix.de,
	mingo@kernel.org,
	allison.henderson@oracle.com,
	petrm@nvidia.com,
	antonio@openvpn.net,
	bigeasy@linutronix.de
Subject: [PATCH net-next 8/9] hsr: Update PRP duplicate discard KUnit test for new algorithm
Date: Wed, 21 Jan 2026 14:37:35 +0100
Message-ID: <df57cc66c54d5be097b78ce367a51551bcf69cd8.1769001553.git.fmaurer@redhat.com>
In-Reply-To: <cover.1769001553.git.fmaurer@redhat.com>
References: <cover.1769001553.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251898-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	DKIM_TRACE(0.00)[redhat.com:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: E84AB5827A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

With the new duplicate discard algorithm from the earlier patches, the
KUnit test for the algorithm needs to be updated. The updates are done in a
way to match the original intends pretty closely. Currently, there is much
knowledge about the actual algorithm baked into the tests (especially the
expectations) which may need some redesign in the future.

Signed-off-by: Felix Maurer <fmaurer@redhat.com>
---
 net/hsr/hsr_framereg.c         |  11 ++-
 net/hsr/hsr_framereg.h         |   4 +
 net/hsr/prp_dup_discard_test.c | 154 +++++++++++++++------------------
 3 files changed, 80 insertions(+), 89 deletions(-)

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index a8cb94faf139..207a51c8d039 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -11,6 +11,7 @@
  * Same code handles filtering of duplicates for PRP as well.
  */
 
+#include <kunit/visibility.h>
 #include <linux/if_ether.h>
 #include <linux/etherdevice.h>
 #include <linux/slab.h>
@@ -293,8 +294,8 @@ static void hsr_forget_seq_block(struct hsr_node *node,
  * expire after time (in low traffic situations) or when they are replaced in
  * the backing fixed size buffer (in high traffic situations).
  */
-static struct hsr_seq_block *hsr_get_seq_block(struct hsr_node *node,
-					       u16 block_idx)
+VISIBLE_IF_KUNIT struct hsr_seq_block *hsr_get_seq_block(struct hsr_node *node,
+							 u16 block_idx)
 {
 	struct hsr_seq_block *block, *res;
 	size_t block_sz;
@@ -325,6 +326,7 @@ static struct hsr_seq_block *hsr_get_seq_block(struct hsr_node *node,
 
 	return block;
 }
+EXPORT_SYMBOL_IF_KUNIT(hsr_get_seq_block);
 
 /* Use the Supervision frame's info about an eventual macaddress_B for merging
  * nodes that has previously had their macaddress_B registered as a separate
@@ -618,10 +620,7 @@ int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
 
 	return hsr_check_duplicate(frame, 0);
 }
-
-#if IS_MODULE(CONFIG_PRP_DUP_DISCARD_KUNIT_TEST)
-EXPORT_SYMBOL(prp_register_frame_out);
-#endif
+EXPORT_SYMBOL_IF_KUNIT(prp_register_frame_out);
 
 static struct hsr_port *get_late_port(struct hsr_priv *hsr,
 				      struct hsr_node *node)
diff --git a/net/hsr/hsr_framereg.h b/net/hsr/hsr_framereg.h
index 1e297268d1d4..93fc7ae49306 100644
--- a/net/hsr/hsr_framereg.h
+++ b/net/hsr/hsr_framereg.h
@@ -74,6 +74,10 @@ bool hsr_is_node_in_db(struct list_head *node_db,
 
 int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame);
 
+#if IS_ENABLED(CONFIG_KUNIT)
+struct hsr_seq_block *hsr_get_seq_block(struct hsr_node *node, u16 block_idx);
+#endif
+
 #define HSR_SEQ_BLOCK_SHIFT 7 /* 128 bits */
 #define HSR_SEQ_BLOCK_SIZE (1 << HSR_SEQ_BLOCK_SHIFT)
 #define HSR_SEQ_BLOCK_MASK (HSR_SEQ_BLOCK_SIZE - 1)
diff --git a/net/hsr/prp_dup_discard_test.c b/net/hsr/prp_dup_discard_test.c
index e86b7b633ae8..a7a5beb52d62 100644
--- a/net/hsr/prp_dup_discard_test.c
+++ b/net/hsr/prp_dup_discard_test.c
@@ -4,6 +4,8 @@
 #include "hsr_main.h"
 #include "hsr_framereg.h"
 
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
 struct prp_test_data {
 	struct hsr_port port;
 	struct hsr_port port_rcv;
@@ -13,37 +15,53 @@ struct prp_test_data {
 
 static struct prp_test_data *build_prp_test_data(struct kunit *test)
 {
+	size_t block_sz;
+
 	struct prp_test_data *data = kunit_kzalloc(test,
 		sizeof(struct prp_test_data), GFP_USER);
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, data);
 
+	data->node.seq_port_cnt = 1;
+	block_sz = hsr_seq_block_size(&data->node);
+	data->node.block_buf = kunit_kcalloc(test, HSR_MAX_SEQ_BLOCKS, block_sz,
+					     GFP_ATOMIC);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, data);
+	xa_init(&data->node.seq_blocks);
+
 	data->frame.node_src = &data->node;
 	data->frame.port_rcv = &data->port_rcv;
 	data->port_rcv.type = HSR_PT_SLAVE_A;
-	data->node.seq_start[HSR_PT_SLAVE_A] = 1;
-	data->node.seq_expected[HSR_PT_SLAVE_A] = 1;
-	data->node.seq_start[HSR_PT_SLAVE_B] = 1;
-	data->node.seq_expected[HSR_PT_SLAVE_B] = 1;
-	data->node.seq_out[HSR_PT_MASTER] = 0;
-	data->node.time_out[HSR_PT_MASTER] = jiffies;
 	data->port.type = HSR_PT_MASTER;
 
 	return data;
 }
 
-static void check_prp_counters(struct kunit *test,
-			       struct prp_test_data *data,
-			       u16 seq_start_a, u16 seq_expected_a,
-			       u16 seq_start_b, u16 seq_expected_b)
+static void check_prp_frame_seen(struct kunit *test, struct prp_test_data *data,
+				 u16 sequence_nr)
+{
+	u16 block_idx, seq_bit;
+	struct hsr_seq_block *block;
+
+	block_idx = sequence_nr >> HSR_SEQ_BLOCK_SHIFT;
+	block = xa_load(&data->node.seq_blocks, block_idx);
+	KUNIT_EXPECT_NOT_NULL(test, block);
+
+	seq_bit = sequence_nr & HSR_SEQ_BLOCK_MASK;
+	KUNIT_EXPECT_TRUE(test, test_bit(seq_bit, block->seq_nrs[0]));
+}
+
+static void check_prp_frame_unseen(struct kunit *test,
+				   struct prp_test_data *data, u16 sequence_nr)
 {
-	KUNIT_EXPECT_EQ(test, data->node.seq_start[HSR_PT_SLAVE_A],
-			seq_start_a);
-	KUNIT_EXPECT_EQ(test, data->node.seq_start[HSR_PT_SLAVE_B],
-			seq_start_b);
-	KUNIT_EXPECT_EQ(test, data->node.seq_expected[HSR_PT_SLAVE_A],
-			seq_expected_a);
-	KUNIT_EXPECT_EQ(test, data->node.seq_expected[HSR_PT_SLAVE_B],
-			seq_expected_b);
+	u16 block_idx, seq_bit;
+	struct hsr_seq_block *block;
+
+	block_idx = sequence_nr >> HSR_SEQ_BLOCK_SHIFT;
+	block = hsr_get_seq_block(&data->node, block_idx);
+	KUNIT_EXPECT_NOT_NULL(test, block);
+
+	seq_bit = sequence_nr & HSR_SEQ_BLOCK_MASK;
+	KUNIT_EXPECT_FALSE(test, test_bit(seq_bit, block->seq_nrs[0]));
 }
 
 static void prp_dup_discard_forward(struct kunit *test)
@@ -54,52 +72,48 @@ static void prp_dup_discard_forward(struct kunit *test)
 	data->frame.sequence_nr = 2;
 	KUNIT_EXPECT_EQ(test, 0,
 			prp_register_frame_out(&data->port, &data->frame));
-	KUNIT_EXPECT_EQ(test, data->frame.sequence_nr,
-			data->node.seq_out[HSR_PT_MASTER]);
-	KUNIT_EXPECT_EQ(test, jiffies, data->node.time_out[HSR_PT_MASTER]);
-	check_prp_counters(test, data, data->frame.sequence_nr,
-			   data->frame.sequence_nr + 1, 1, 1);
+	check_prp_frame_seen(test, data, data->frame.sequence_nr);
 }
 
-static void prp_dup_discard_inside_dropwindow(struct kunit *test)
+static void prp_dup_discard_drop_duplicate(struct kunit *test)
 {
-	/* Normal situation, other LAN ahead by one. Frame is dropped */
 	struct prp_test_data *data = build_prp_test_data(test);
-	unsigned long time = jiffies - 10;
 
-	data->frame.sequence_nr = 1;
-	data->node.seq_expected[HSR_PT_SLAVE_B] = 3;
-	data->node.seq_out[HSR_PT_MASTER] = 2;
-	data->node.time_out[HSR_PT_MASTER] = time;
+	data->frame.sequence_nr = 2;
+	KUNIT_EXPECT_EQ(test, 0,
+			prp_register_frame_out(&data->port, &data->frame));
+	check_prp_frame_seen(test, data, data->frame.sequence_nr);
 
 	KUNIT_EXPECT_EQ(test, 1,
 			prp_register_frame_out(&data->port, &data->frame));
-	KUNIT_EXPECT_EQ(test, 2, data->node.seq_out[HSR_PT_MASTER]);
-	KUNIT_EXPECT_EQ(test, time, data->node.time_out[HSR_PT_MASTER]);
-	check_prp_counters(test, data, 2, 2, 2, 3);
+	check_prp_frame_seen(test, data, data->frame.sequence_nr);
 }
 
-static void prp_dup_discard_node_timeout(struct kunit *test)
+static void prp_dup_discard_entry_timeout(struct kunit *test)
 {
 	/* Timeout situation, node hasn't sent anything for a while */
 	struct prp_test_data *data = build_prp_test_data(test);
+	struct hsr_seq_block *block;
+	u16 block_idx;
 
 	data->frame.sequence_nr = 7;
-	data->node.seq_start[HSR_PT_SLAVE_A] = 1234;
-	data->node.seq_expected[HSR_PT_SLAVE_A] = 1235;
-	data->node.seq_start[HSR_PT_SLAVE_B] = 1234;
-	data->node.seq_expected[HSR_PT_SLAVE_B] = 1234;
-	data->node.seq_out[HSR_PT_MASTER] = 1234;
-	data->node.time_out[HSR_PT_MASTER] =
-		jiffies - msecs_to_jiffies(HSR_ENTRY_FORGET_TIME) - 1;
+	KUNIT_EXPECT_EQ(test, 0,
+			prp_register_frame_out(&data->port, &data->frame));
+	check_prp_frame_seen(test, data, data->frame.sequence_nr);
+
+	data->frame.sequence_nr = 11;
+	KUNIT_EXPECT_EQ(test, 0,
+			prp_register_frame_out(&data->port, &data->frame));
+	check_prp_frame_seen(test, data, data->frame.sequence_nr);
+
+	block_idx = data->frame.sequence_nr >> HSR_SEQ_BLOCK_SHIFT;
+	block = hsr_get_seq_block(&data->node, block_idx);
+	block->time = jiffies - msecs_to_jiffies(HSR_ENTRY_FORGET_TIME) - 1;
 
 	KUNIT_EXPECT_EQ(test, 0,
 			prp_register_frame_out(&data->port, &data->frame));
-	KUNIT_EXPECT_EQ(test, data->frame.sequence_nr,
-			data->node.seq_out[HSR_PT_MASTER]);
-	KUNIT_EXPECT_EQ(test, jiffies, data->node.time_out[HSR_PT_MASTER]);
-	check_prp_counters(test, data, data->frame.sequence_nr,
-			   data->frame.sequence_nr + 1, 1234, 1234);
+	check_prp_frame_seen(test, data, data->frame.sequence_nr);
+	check_prp_frame_unseen(test, data, 7);
 }
 
 static void prp_dup_discard_out_of_sequence(struct kunit *test)
@@ -107,50 +121,36 @@ static void prp_dup_discard_out_of_sequence(struct kunit *test)
 	/* One frame is received out of sequence on both LANs */
 	struct prp_test_data *data = build_prp_test_data(test);
 
-	data->node.seq_start[HSR_PT_SLAVE_A] = 10;
-	data->node.seq_expected[HSR_PT_SLAVE_A] = 10;
-	data->node.seq_start[HSR_PT_SLAVE_B] = 10;
-	data->node.seq_expected[HSR_PT_SLAVE_B] = 10;
-	data->node.seq_out[HSR_PT_MASTER] = 9;
+	/* initial frame, should be accepted */
+	data->frame.sequence_nr = 9;
+	KUNIT_EXPECT_EQ(test, 0,
+			prp_register_frame_out(&data->port, &data->frame));
+	check_prp_frame_seen(test, data, data->frame.sequence_nr);
 
 	/* 1st old frame, should be accepted */
 	data->frame.sequence_nr = 8;
 	KUNIT_EXPECT_EQ(test, 0,
 			prp_register_frame_out(&data->port, &data->frame));
-	KUNIT_EXPECT_EQ(test, data->frame.sequence_nr,
-			data->node.seq_out[HSR_PT_MASTER]);
-	check_prp_counters(test, data, data->frame.sequence_nr,
-			   data->frame.sequence_nr + 1, 10, 10);
+	check_prp_frame_seen(test, data, data->frame.sequence_nr);
 
 	/* 2nd frame should be dropped */
 	data->frame.sequence_nr = 8;
 	data->port_rcv.type = HSR_PT_SLAVE_B;
 	KUNIT_EXPECT_EQ(test, 1,
 			prp_register_frame_out(&data->port, &data->frame));
-	check_prp_counters(test, data, data->frame.sequence_nr + 1,
-			   data->frame.sequence_nr + 1,
-			   data->frame.sequence_nr + 1,
-			   data->frame.sequence_nr + 1);
 
 	/* Next frame, this is forwarded */
 	data->frame.sequence_nr = 10;
 	data->port_rcv.type = HSR_PT_SLAVE_A;
 	KUNIT_EXPECT_EQ(test, 0,
 			prp_register_frame_out(&data->port, &data->frame));
-	KUNIT_EXPECT_EQ(test, data->frame.sequence_nr,
-			data->node.seq_out[HSR_PT_MASTER]);
-	check_prp_counters(test, data, data->frame.sequence_nr,
-			   data->frame.sequence_nr + 1, 9, 9);
+	check_prp_frame_seen(test, data, data->frame.sequence_nr);
 
 	/* and next one is dropped */
 	data->frame.sequence_nr = 10;
 	data->port_rcv.type = HSR_PT_SLAVE_B;
 	KUNIT_EXPECT_EQ(test, 1,
 			prp_register_frame_out(&data->port, &data->frame));
-	check_prp_counters(test, data, data->frame.sequence_nr + 1,
-			   data->frame.sequence_nr + 1,
-			   data->frame.sequence_nr + 1,
-			   data->frame.sequence_nr + 1);
 }
 
 static void prp_dup_discard_lan_b_late(struct kunit *test)
@@ -158,43 +158,31 @@ static void prp_dup_discard_lan_b_late(struct kunit *test)
 	/* LAN B is behind */
 	struct prp_test_data *data = build_prp_test_data(test);
 
-	data->node.seq_start[HSR_PT_SLAVE_A] = 9;
-	data->node.seq_expected[HSR_PT_SLAVE_A] = 9;
-	data->node.seq_start[HSR_PT_SLAVE_B] = 9;
-	data->node.seq_expected[HSR_PT_SLAVE_B] = 9;
-	data->node.seq_out[HSR_PT_MASTER] = 8;
-
 	data->frame.sequence_nr = 9;
 	KUNIT_EXPECT_EQ(test, 0,
 			prp_register_frame_out(&data->port, &data->frame));
-	KUNIT_EXPECT_EQ(test, data->frame.sequence_nr,
-			data->node.seq_out[HSR_PT_MASTER]);
-	check_prp_counters(test, data, 9, 10, 9, 9);
+	check_prp_frame_seen(test, data, data->frame.sequence_nr);
 
 	data->frame.sequence_nr = 10;
 	KUNIT_EXPECT_EQ(test, 0,
 			prp_register_frame_out(&data->port, &data->frame));
-	KUNIT_EXPECT_EQ(test, data->frame.sequence_nr,
-			data->node.seq_out[HSR_PT_MASTER]);
-	check_prp_counters(test, data, 9, 11, 9, 9);
+	check_prp_frame_seen(test, data, data->frame.sequence_nr);
 
 	data->frame.sequence_nr = 9;
 	data->port_rcv.type = HSR_PT_SLAVE_B;
 	KUNIT_EXPECT_EQ(test, 1,
 			prp_register_frame_out(&data->port, &data->frame));
-	check_prp_counters(test, data, 10, 11, 10, 10);
 
 	data->frame.sequence_nr = 10;
 	data->port_rcv.type = HSR_PT_SLAVE_B;
 	KUNIT_EXPECT_EQ(test, 1,
 			prp_register_frame_out(&data->port, &data->frame));
-	check_prp_counters(test, data,  11, 11, 11, 11);
 }
 
 static struct kunit_case prp_dup_discard_test_cases[] = {
 	KUNIT_CASE(prp_dup_discard_forward),
-	KUNIT_CASE(prp_dup_discard_inside_dropwindow),
-	KUNIT_CASE(prp_dup_discard_node_timeout),
+	KUNIT_CASE(prp_dup_discard_drop_duplicate),
+	KUNIT_CASE(prp_dup_discard_entry_timeout),
 	KUNIT_CASE(prp_dup_discard_out_of_sequence),
 	KUNIT_CASE(prp_dup_discard_lan_b_late),
 	{}
-- 
2.52.0


