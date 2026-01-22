Return-Path: <netdev+bounces-252397-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJtuK49McmnpfAAAu9opvQ
	(envelope-from <netdev+bounces-252397-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:13:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3589269B2A
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1AC597E2021
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF20366562;
	Thu, 22 Jan 2026 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A3NkojER"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EF134EF0F
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093886; cv=none; b=W7hSMixGOv/o80PVM2uZAF5fR572FLDsfSWRtumPZUvT6SfQ0nPnfnH7LJUcCon+BuoTZ7eRtZVAhlGl/tsDXz9FyJxl9G2YzU1QLugqfwh6bmsbFUIVgl51myox75zj/yNPJIOi4SqOVvpfBno2Jo5RNTsMH9KIB9lfdiZcjbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093886; c=relaxed/simple;
	bh=xuVeUKLpf2MHxWBf3voQe3cMHFi/V+jl9nrqFWH3mjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4djuF5b8i0SSZYHjMUGirn85oiNJQoBWH9wPZHp4fzPhZyVvyiB0dSJ3bqTHviW/+sY7zMIy7zuhtgAdhT2gX5buTABx2li++owQLbop1u8n/dCMCG/aHGFdBp9u7me+Gmhk/l5MRP8LLUOoBpgXrNxomqJ48HCIJuIKrtj+Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A3NkojER; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769093883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MvmOsr8mOHCRAb23zQJVYFukfRfeASoiOz43BqT8wSc=;
	b=A3NkojERb+ItPl/fOZLE7pY+3E3BrQwgCVRdByUye+psA7cfHa/5GhW5WsNwnO/XtMaLNo
	wrgGaSkEPIaN6bX/Of0v8zss0armO54recyA1CQn/x/aw8mWpHMdlrooKf6RHj2uNlWXpu
	A8y7PYxqje1+cFpgUHLkEPbabGdVDfM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-_FP4Ta35NTGAP5McNvVUow-1; Thu,
 22 Jan 2026 09:57:59 -0500
X-MC-Unique: _FP4Ta35NTGAP5McNvVUow-1
X-Mimecast-MFC-AGG-ID: _FP4Ta35NTGAP5McNvVUow_1769093878
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB5AF18005B2;
	Thu, 22 Jan 2026 14:57:57 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.45.225.113])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A4A361800998;
	Thu, 22 Jan 2026 14:57:53 +0000 (UTC)
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
Subject: [PATCH net-next v2 8/9] hsr: Update PRP duplicate discard KUnit test for new algorithm
Date: Thu, 22 Jan 2026 15:57:03 +0100
Message-ID: <e1e0065cd9ff84a970625d77300ba028392981c4.1769093335.git.fmaurer@redhat.com>
In-Reply-To: <cover.1769093335.git.fmaurer@redhat.com>
References: <cover.1769093335.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252397-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	DKIM_TRACE(0.00)[redhat.com:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 3589269B2A
X-Rspamd-Action: no action

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
index c9bd25e6a7cc..08f91f10a934 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -11,6 +11,7 @@
  * Same code handles filtering of duplicates for PRP as well.
  */
 
+#include <kunit/visibility.h>
 #include <linux/if_ether.h>
 #include <linux/etherdevice.h>
 #include <linux/slab.h>
@@ -294,8 +295,8 @@ static void hsr_forget_seq_block(struct hsr_node *node,
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
@@ -326,6 +327,7 @@ static struct hsr_seq_block *hsr_get_seq_block(struct hsr_node *node,
 
 	return block;
 }
+EXPORT_SYMBOL_IF_KUNIT(hsr_get_seq_block);
 
 /* Use the Supervision frame's info about an eventual macaddress_B for merging
  * nodes that has previously had their macaddress_B registered as a separate
@@ -621,10 +623,7 @@ int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
 
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


