Return-Path: <netdev+bounces-229128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B2CBD8625
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A21D4E9328
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75662E36E3;
	Tue, 14 Oct 2025 09:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="L6m8QbMT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l9mG36Q9"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B332E7BB2
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433491; cv=none; b=QZizt4nY/vEizZRXIxuOF/hNYmwb3U9Ieo52n1p/15YuqOQdDya+O5gAp7Sx2Z7GbX7N2auR/30iB7f3MPoI6VQrJ21hWWgDwiGr7sG34GoA/HZ/2g6PF3VInLdhToOI7U+xKELL6p3P2Cyo9D03QtlMDQl0XgtVEBzrVVLtSz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433491; c=relaxed/simple;
	bh=cX2wy/ZP07PLUxrW97fpRZtjiHPnuamca4QYOlc9HPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=THaS8AYa5uABXwVuXhF4du8Vo75PDTPn0p9lfJnDQsrQDIwmj1XFoBY4aw5aItpvbetbDGkHHcqaHkO8VSlZqrgcHaGVtz+9XfVbo5j0FTvdyjymB1O/Ccqrr20VgN7mJNTkeq6rmx2gUSrILCJGgMWNCyi+qZVzDqdfBHyq9OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=L6m8QbMT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l9mG36Q9; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4F1E814001DF;
	Tue, 14 Oct 2025 05:18:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 14 Oct 2025 05:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760433489; x=
	1760519889; bh=KuTkDSN7Q6Iva0v9gLidfff1CZokPJvWN4m6u2Vjy4o=; b=L
	6m8QbMTW26u+UjN3S2GUq8YA9yh2Obdt4/JGPDCgnOGrI7LLE40guQxtfRO3lg8q
	guu1XysLrznpHKqL1HUJUbJcSK7palODIUjODb535li22n0ZvPGdp0JAgR87rqc4
	G8e8oHZKkxHi70XdJzLhGKr5oiRORMMzqHhf5dQHm4cejfIyMQQVvCBHGoRhKAWR
	ahaCQNqnkMGqH6FiXs2ZdvEkxrZ9WLKGCSYz2qNFiQeGC5OrONXd2wm7Q1CiF4Us
	W7cdNAH5jrEZ4ghonlqJ4BxYIxRc7G9pxJ4L93In7qw09Ul5hmy5ZiN+FGDwsfT6
	phU5j7s88wlHHBr7V2BRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760433489; x=1760519889; bh=K
	uTkDSN7Q6Iva0v9gLidfff1CZokPJvWN4m6u2Vjy4o=; b=l9mG36Q9fEBryG8xP
	vdK715OAokwdHNQNgmykGDGayjlk5ikhVtqHf0t74H4cPqgdNm4XGADGGb6Z84cl
	pav2eSfjSznV21iljqEwuU7EKQW4Mw0ZcGPcXs5p56/176Hd2iD8UcKV16jRISvE
	lEA1ukkqsbuOpIFMrFuBjo7ClPnY5fS4xG2qP04dr+Bt4l7knJkJGzIRCCGIPqfs
	utS48uJPn3Wr/Q8w2H0Ai4o49ANGGI2f2yotDQbKWzyV2/7E10TZnR6A89GNkIsB
	CyvRb8eL6ttRBHFLXcTISO4F3kb0kg1+pAl4pSVbBv3JACcHie5lK7OiscxcYbuT
	mS4SQ==
X-ME-Sender: <xms:URXuaHBeI-EbKN93kQwxxPuBPK5_AihwWi7GjQqL2mfYNT1rp9tORA>
    <xme:URXuaEa8VO1pSF6xjEoaHYFGA1md6YtiPZIVvMXqp85nWSdDhiaLbUhm6ZKEsmJEh
    YrU9tfW988ZJtGFiZF2AwCVBYQEWzw9X2YgLIjrYzQj-410LB2NvwQ>
X-ME-Received: <xmr:URXuaK6g1RU6mxa9P9cYVwzsTMPE2ku_fbyImeQVjdKuHQncMP-WA80MzNDu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddtudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghs
    hihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeiieeuieethedtfeehkefhhf
    egveeuhfetveeuleejieejieevhefghedugfehgfenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvth
    dpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgusehquhgvrg
    hshihsnhgrihhlrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrghnnhhhsehgohhoghhlvgdrtghomhdprhgtphhtthhopehjohhhnh
    drfhgrshhtrggsvghnugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:URXuaFboWsSW9bpNarR_yPXnteQdN1olU5DhxqM80fVqC6bpmWV5HA>
    <xmx:URXuaJjtzz9Xxiz8g4obe37cYwPdsr5iZIHkWeOijg1oMQQBLL04zg>
    <xmx:URXuaG8TG9c0Gz52qs_ncQ21UCNLpYO87ZB17PHRmxGCUp211V4JsA>
    <xmx:URXuaEpIimwmlZw4NkO-OQcwJs0Unlm-qixD4KQA1uCkPHD5QA8NsQ>
    <xmx:URXuaM0C3oVdhD6sSirInBaArsMW21jbQ7rO-jH5mcpwSrRsUP_kCdJF>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 05:18:08 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	kuba@kernel.org,
	jannh@google.com,
	john.fastabend@gmail.com
Subject: [PATCH net 6/7] selftests: net: tls: add tests for cmsg vs MSG_MORE
Date: Tue, 14 Oct 2025 11:17:01 +0200
Message-ID: <b34feeadefe8a997f068d5ed5617afd0072df3c0.1760432043.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760432043.git.sd@queasysnail.net>
References: <cover.1760432043.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't have a test to check that MSG_MORE won't let us merge records
of different types across sendmsg calls.

Add new tests that check:
 - MSG_MORE is only allowed for DATA records
 - a pending DATA record gets closed and pushed before a non-DATA
   record is processed

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 tools/testing/selftests/net/tls.c | 34 +++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index e788b84551ca..77e4e30b46cc 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -564,6 +564,40 @@ TEST_F(tls, msg_more)
 	EXPECT_EQ(memcmp(buf, test_str, send_len), 0);
 }
 
+TEST_F(tls, cmsg_msg_more)
+{
+	char *test_str =  "test_read";
+	char record_type = 100;
+	int send_len = 10;
+
+	/* we don't allow MSG_MORE with non-DATA records */
+	EXPECT_EQ(tls_send_cmsg(self->fd, record_type, test_str, send_len,
+				MSG_MORE), -1);
+	EXPECT_EQ(errno, EINVAL);
+}
+
+TEST_F(tls, msg_more_then_cmsg)
+{
+	char *test_str = "test_read";
+	char record_type = 100;
+	int send_len = 10;
+	char buf[10 * 2];
+	int ret;
+
+	EXPECT_EQ(send(self->fd, test_str, send_len, MSG_MORE), send_len);
+	EXPECT_EQ(recv(self->cfd, buf, send_len, MSG_DONTWAIT), -1);
+
+	ret = tls_send_cmsg(self->fd, record_type, test_str, send_len, 0);
+	EXPECT_EQ(ret, send_len);
+
+	/* initial DATA record didn't get merged with the non-DATA record */
+	EXPECT_EQ(recv(self->cfd, buf, send_len * 2, 0), send_len);
+
+	EXPECT_EQ(tls_recv_cmsg(_metadata, self->cfd, record_type,
+				buf, sizeof(buf), MSG_WAITALL),
+		  send_len);
+}
+
 TEST_F(tls, msg_more_unsent)
 {
 	char const *test_str = "test_read";
-- 
2.51.0


