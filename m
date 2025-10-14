Return-Path: <netdev+bounces-229129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 130DDBD8628
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF24B4F71AD
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEA62E7BB2;
	Tue, 14 Oct 2025 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="VnIP64g6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TV2Mqyqc"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2658A2E7F0A
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 09:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433493; cv=none; b=D1BMKs/vxKK1At5lJu7jemUhC6MRCSsUOvlvcguxUCtRgd/v2twqmSgrKXaTbDUEPDry6D74ZtasDobJcL2Y8GzzgNvT1xr3+6/Ng08jkuJzy83aES21VXC2quQvQO1KaxBWfpdd8BgDdjSsQt3AlgCGSf8feRR9Bc2+w75iuyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433493; c=relaxed/simple;
	bh=+FvizAmnbm+ogbACe9/+HgVx8c/TpLLeSdfTQ9HODxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2nf8GojXYzxKPr924R8fmwggzFxdXpGvEysGG7P4NW1tPpf2RJPJeJDGTB18dN8hXQxVMZFMTpIwpb8CCZH3CPGl9STsggNItGVbp2gJbe9HV93AG+Qn50qBpEgZuvVatwViAFRiW3wNAyc2J+j3DKWM/SLfjRoZcb8KpZmvAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=VnIP64g6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TV2Mqyqc; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 3E7C4EC01D7;
	Tue, 14 Oct 2025 05:18:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 14 Oct 2025 05:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1760433491; x=
	1760519891; bh=UeJon/mvZ3dm76MYuA+WMoDVZ1mRV/cM4mjm71yPYYw=; b=V
	nIP64g6jTmYK+ZqISo2PKy5Y4aXiZiVWWBw0HYcC1pxczD4B2YxGYNQF+BKX41wp
	m9KJ/w9q/XdS6wpLn2aXA3RFtCM4q50OUo93FIc/wCi9+5+vgqr13/mJFN9QKxOs
	uUtdmCH2iMdHH+oDhIAUSHX9TOz3LfY6/xV37j38TveuyUGyKH85aUTJQQvfI8g0
	359LEyWwdgujlGpDmizTEFqkoWID23jMucxOtSrcm2TaQmPr+L+eR8klIn8IbyqG
	S18DxReSI6HUVftJVePFN9pLT+FT9AEHLT7guNYU4yGhxJNVC2xBHHLVWg12nJaC
	EOcGhs5lr+B8lYP30TD5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760433491; x=1760519891; bh=U
	eJon/mvZ3dm76MYuA+WMoDVZ1mRV/cM4mjm71yPYYw=; b=TV2MqyqcQf5vnGvP0
	m5Thv0GqzXuiO3nhaLY3bkkvrRmlq3NwF4qeS19huIxqq7lFo4+6DmA8D0EG7zN2
	+3SHCAtsJY3YFlhi+hNXcUCSxzv2BWWxAY5AOds/6skgMDXPPAIKn+0RFTNuwDja
	SzOrJQAYTNLwp/r3t7gWq5Y4Z/TtFMf/6VbEr5y1VH2D9ZYPeSKKKkc+wA3UfGno
	fv7wJiTz4jO60lRtRuJxytY/PMysmefVcyibVhhmyzpIVbElrQvptlEfeeMR04wQ
	JujjOtsq6JMMHyTWPL/bBP0HRGgRe8kaMjBd9b2fPEvP8vkskNBBiBr+yleXKbNU
	73tTw==
X-ME-Sender: <xms:UxXuaGCclpLOmS7lBUv4SCsz_BNU96ZdhqW2M33LWgIeZRXaBqBnpA>
    <xme:UxXuaHa7Sz7vKtwYbtu7GCqSREKjLSpM6XdqHwPP6r4lIoOleTZ_l2Sg2_QJUdFQE
    YbNOEmWZnRNkXXTlnjkB9_UylZF6E8O-tkC6xxF7rQSz4k-TftPwbI>
X-ME-Received: <xmr:UxXuaB5ohVgDxIULfxL5gzmI9OcEtL4DB0auQ7h8EiO_xXo6iyDGW-AFpiTT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddtudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghs
    hihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeiieeuieethedtfeehkefhhf
    egveeuhfetveeuleejieejieevhefghedugfehgfenucevlhhushhtvghrufhiiigvpedu
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvth
    dpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgusehquhgvrg
    hshihsnhgrihhlrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrghnnhhhsehgohhoghhlvgdrtghomhdprhgtphhtthhopehjohhhnh
    drfhgrshhtrggsvghnugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:UxXuaAZzoRFQBWiK2584gQk6_Wyqay-fYoR7lrxAebkK21cDKd4ObA>
    <xmx:UxXuaIgaswEEEZFJyqhRYX8iQECUB8INQeAm73ku3Rw3qi4nKzZ20g>
    <xmx:UxXuaJ_VdAzTozzkXYA52U_Q8MsLGO3BYLBMEEVfUyezO2LyV63LRw>
    <xmx:UxXuaLoWeWzTmtWctHx-pXNyzuYzj6Q_RVXrTN1Zjc-of5gqOMw1Pw>
    <xmx:UxXuaH17T13H1R2xhJ4JBIuSHAGRYijWuhpITM4KdV6XcH7kDzwNanY0>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 05:18:10 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	kuba@kernel.org,
	jannh@google.com,
	john.fastabend@gmail.com
Subject: [PATCH net 7/7] selftests: tls: add test for short splice due to full skmsg
Date: Tue, 14 Oct 2025 11:17:02 +0200
Message-ID: <1d129a15f526ea3602f3a2b368aa0b6f7e0d35d5.1760432043.git.sd@queasysnail.net>
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

We don't have a test triggering a partial splice caused by a full
skmsg. Add one, based on a program by Jann Horn.

Use MAX_FRAGS=48 to make sure the skmsg will be full for any allowed
value of CONFIG_MAX_SKB_FRAGS (17..45).

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 tools/testing/selftests/net/tls.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 77e4e30b46cc..5c6d8215021c 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -946,6 +946,37 @@ TEST_F(tls, peek_and_splice)
 	EXPECT_EQ(memcmp(mem_send, mem_recv, send_len), 0);
 }
 
+#define MAX_FRAGS 48
+TEST_F(tls, splice_short)
+{
+	struct iovec sendchar_iov;
+	char read_buf[0x10000];
+	char sendbuf[0x100];
+	char sendchar = 'S';
+	int pipefds[2];
+	int i;
+
+	sendchar_iov.iov_base = &sendchar;
+	sendchar_iov.iov_len = 1;
+
+	memset(sendbuf, 's', sizeof(sendbuf));
+
+	ASSERT_GE(pipe2(pipefds, O_NONBLOCK), 0);
+	ASSERT_GE(fcntl(pipefds[0], F_SETPIPE_SZ, (MAX_FRAGS + 1) * 0x1000), 0);
+
+	for (i = 0; i < MAX_FRAGS; i++)
+		ASSERT_GE(vmsplice(pipefds[1], &sendchar_iov, 1, 0), 0);
+
+	ASSERT_EQ(write(pipefds[1], sendbuf, sizeof(sendbuf)), sizeof(sendbuf));
+
+	EXPECT_EQ(splice(pipefds[0], NULL, self->fd, NULL, MAX_FRAGS + 0x1000, 0),
+		  MAX_FRAGS + sizeof(sendbuf));
+	EXPECT_EQ(recv(self->cfd, read_buf, sizeof(read_buf), 0), MAX_FRAGS + sizeof(sendbuf));
+	EXPECT_EQ(recv(self->cfd, read_buf, sizeof(read_buf), MSG_DONTWAIT), -1);
+	EXPECT_EQ(errno, EAGAIN);
+}
+#undef MAX_FRAGS
+
 TEST_F(tls, recvmsg_single)
 {
 	char const *test_str = "test_recvmsg_single";
-- 
2.51.0


