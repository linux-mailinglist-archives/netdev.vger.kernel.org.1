Return-Path: <netdev+bounces-179377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A19B0A7C30B
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 20:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3A4E17A088
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 18:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364B421507F;
	Fri,  4 Apr 2025 18:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxPXmsYf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1275F20B1E6
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 18:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743789820; cv=none; b=XmSLWBaoLRjE59YPL7hsxWaLT46Ys6Kyvsh1VXjffhp1TlhYsLZfpRkBlAMvkbxHkKtzQB4S9c5urPUPwqbg7tbQiMcAOpxd4IpCgEq1NpmuDNau4U+O3rXAiVaCEI1Zz66aJNDr5E3JlZkJdpl1vyfW5mmRqueWe5+hUcXZSuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743789820; c=relaxed/simple;
	bh=wwAureJpjqzJmcpkfkDLddhXNM3W12blEwp0TIkkFVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KqFaaRln4QjpZTc8aP4cV8vXPXTWKLTOxKXVB9g93a+CGvYCJjIqcrBFHlrVLJ4ZXphVp0M2ydWclEQdKsrOAl6LPM+RdJChv7gbDo9O0+ed9XUMpMVZNFEVJij+P3OJqi0ATYteXqgyasq9Bg31lbHBIS3HF1pE3AtRTFezuhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxPXmsYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5690AC4CEEA;
	Fri,  4 Apr 2025 18:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743789819;
	bh=wwAureJpjqzJmcpkfkDLddhXNM3W12blEwp0TIkkFVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CxPXmsYfwUmEkDBf2KWBCelUPL3MY9o1JuTxUGZqbB5v0kDiLbWjCE0CMiYf4vlhh
	 u9HYTrFYWxBK0LNEjKAmcs7MsLcBIbgpgefweFfvSYJIPS7BLMB3Ak3KfcJtbY647a
	 IlPI7qA7QPM7TQlI0fIJcaPkbYCbP+6kBhNfxqxhrwFDE9KbPJdcbex67SnXLnv7dk
	 xL+QyyVBl47v30hOFyrdZfT/1ClzgmijeoilQirKP5SzyhuHBLZau8ZDkiCUuOD8sX
	 gyXi+jKf3bV04ubOjf8EQwwkxTkLuuwy4mM1DIiCZ7jnc1ow12CXttyJRS6D2aZwhs
	 Wez9xX/3kuvPA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	sd@queasysnail.net,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 2/2] selftests: tls: check that disconnect does nothing
Date: Fri,  4 Apr 2025 11:03:34 -0700
Message-ID: <20250404180334.3224206-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250404180334.3224206-1-kuba@kernel.org>
References: <20250404180334.3224206-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"Inspired" by syzbot test, pre-queue some data, disconnect()
and try to receive(). This used to trigger a warning in TLS's strp.
Now we expect the disconnect() to have almost no effect.

Link: https://lore.kernel.org/67e6be74.050a0220.2f068f.007e.GAE@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/tls.c | 36 +++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 9a85f93c33d8..5ded3b3a7538 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1753,6 +1753,42 @@ TEST_F(tls_basic, rekey_tx)
 	EXPECT_EQ(memcmp(buf, test_str, send_len), 0);
 }
 
+TEST_F(tls_basic, disconnect)
+{
+	char const *test_str = "test_message";
+	int send_len = strlen(test_str) + 1;
+	struct tls_crypto_info_keys key;
+	struct sockaddr_in addr;
+	char buf[20];
+	int ret;
+
+	if (self->notls)
+		return;
+
+	tls_crypto_info_init(TLS_1_3_VERSION, TLS_CIPHER_AES_GCM_128,
+			     &key, 0);
+
+	ret = setsockopt(self->fd, SOL_TLS, TLS_TX, &key, key.len);
+	ASSERT_EQ(ret, 0);
+
+	/* Pre-queue the data so that setsockopt parses it but doesn't
+	 * dequeue it from the TCP socket. recvmsg would dequeue.
+	 */
+	EXPECT_EQ(send(self->fd, test_str, send_len, 0), send_len);
+
+	ret = setsockopt(self->cfd, SOL_TLS, TLS_RX, &key, key.len);
+	ASSERT_EQ(ret, 0);
+
+	addr.sin_family = AF_UNSPEC;
+	addr.sin_addr.s_addr = htonl(INADDR_ANY);
+	addr.sin_port = 0;
+	ret = connect(self->cfd, &addr, sizeof(addr));
+	EXPECT_EQ(ret, -1);
+	EXPECT_EQ(errno, EOPNOTSUPP);
+
+	EXPECT_EQ(recv(self->cfd, buf, send_len, 0), send_len);
+}
+
 TEST_F(tls, rekey)
 {
 	char const *test_str_1 = "test_message_before_rekey";
-- 
2.49.0


