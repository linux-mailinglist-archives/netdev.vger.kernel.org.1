Return-Path: <netdev+bounces-223823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98716B7CECE
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EBE01B274C0
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 00:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238CB1C7013;
	Wed, 17 Sep 2025 00:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZE4Xv2K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B101C4A0A
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 00:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758068907; cv=none; b=cKej1QmO7SQr5YkeWev5M0gnUg5Fj/e1g12r4u61uVZRc7HON+InOCQLvTpX4BbyilPYYhB5ruoQ4WqzBDkllXyhZL8THrueA6KR3sgaQlBSfPo9MWR/J82shxaI0p0nJdaTCdgVaaxVPyon6Yo7UZyRMKb0NqR96KJeSTtyNxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758068907; c=relaxed/simple;
	bh=ckV537HOKN+hfxC+f++NTwcm9JJZ35azQb1FUInmSU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFrMPLfbJX4emwRNUgIrExSC5D83VpCb5A/8bnO+STS3Kxr0dsSYg+KKRu7aBSyTBopvZn4JZ3CNJdWgtt3iR4lZ+vfPk8C5noGyqZsJ7K16PO88m1JSZgKJZ7Sbwj0IFVA00AO10IeO98DwMqEYLxF4xjzrxh3ohuBmWJm/BgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZE4Xv2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D749C4CEFC;
	Wed, 17 Sep 2025 00:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758068906;
	bh=ckV537HOKN+hfxC+f++NTwcm9JJZ35azQb1FUInmSU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OZE4Xv2K9Mm1wLmeTi3zCMSxKnjHJQD41qGuwT320IVcJmrN9wsFjD0Z3r2fkWQn6
	 YKHoBrMx9gmAg9XQ7EQNHeiDT6dafNvn7cri9n9FR/mDKLQOrhQv9xKXjRcao3TJnn
	 luTeTmR3aQscVFb4OK4l0wZgrblFe9/uOY7z2YjHdO7KSEckjD/Kwr22oMqwJJZN2/
	 yWTRvj5dhgm/EDKjaty5K6MnlTEpIxow6aXV0tiwtexskyb2q/sNuaVOg3CqJeo6FH
	 3cnqxtyRvQ1mp5YJFDmyTkRogZGJpKMgYskS0ya+lPUEeS5HswflwYGnJW7kPgfBqf
	 0R0ss2vddsnJg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net 2/2] selftests: tls: test skb copy under mem pressure and OOB
Date: Tue, 16 Sep 2025 17:28:14 -0700
Message-ID: <20250917002814.1743558-2-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917002814.1743558-1-kuba@kernel.org>
References: <20250917002814.1743558-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test which triggers mem pressure via OOB writes.

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/tls.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index cd67b0ae75a7..e788b84551ca 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -2775,6 +2775,22 @@ TEST_F(tls_err, poll_partial_rec_async)
 	}
 }
 
+/* Use OOB+large send to trigger copy mode due to memory pressure.
+ * OOB causes a short read.
+ */
+TEST_F(tls_err, oob_pressure)
+{
+	char buf[1<<16];
+	int i;
+
+	memrnd(buf, sizeof(buf));
+
+	EXPECT_EQ(send(self->fd2, buf, 5, MSG_OOB), 5);
+	EXPECT_EQ(send(self->fd2, buf, sizeof(buf), 0), sizeof(buf));
+	for (i = 0; i < 64; i++)
+		EXPECT_EQ(send(self->fd2, buf, 5, MSG_OOB), 5);
+}
+
 TEST(non_established) {
 	struct tls12_crypto_info_aes_gcm_256 tls12;
 	struct sockaddr_in addr;
-- 
2.51.0


