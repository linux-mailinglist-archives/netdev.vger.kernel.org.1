Return-Path: <netdev+bounces-191653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9B7ABC8D3
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 23:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26833188614E
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 21:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B89217F27;
	Mon, 19 May 2025 21:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="JgDNuB1z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81B720E021
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 21:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747688540; cv=none; b=YlVXmishVp2GbOTtd8JSSO/cgMijypumK3Pp9JEFK06rrFullodqtqGMegUHPchf3NLovmj724GJvpHnD7kuIKq0ihNBROPzGaGA8RVwPpvjOflGk859+9ShwwUPh6if8MhNQRW8cXwbRP+9vpv2p4BxHgXxT770EWn+nWkhvCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747688540; c=relaxed/simple;
	bh=L4sQm8a7RWTQNtJZM6CBinYgnu8Ug4pygZz5B0DMEgk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AmCYRFtvnF/UT5C2Llej0cmIYE7wJL1u1WBqDsVEgy+V4fshDRWXqQmvp8OURXja/5Nma3L+U+CkMyRKs3CL9TAuSlE7QczjJNgxqYVT5iK+j/aom2xz7dRLLscI8e1VcocAQKxeTKNzae+PoCplSGHK5MwsVgsl4fHMEgRgli0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=JgDNuB1z; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747688538; x=1779224538;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6m5V3t9bfQfZpApudZIWgau3wqaMpZKRgDlP0tRYyLU=;
  b=JgDNuB1zRgpIjdxrF5GSvXKHSqgHdXpdHjc+vMSZRwKCc323TWTlLP/6
   xzcIPrHPepghBJCzw2u8cE4H5Ue1NAxJ6wigzN6Zu6e0MiQexsID+UQS3
   2MEZK9fkWuDUJK02LvOJ+r5t7rKyQnOnlUl9sx6T3SjXZJwfPsTKztkvb
   4sKcvDBltibvdedKhbaGgzFMnx9Dzu2yGYZLeEZLQhWhtiqEbm0Is8EXh
   TaoTyMOx3Bo6KWykw5s0OxhASkhylfb7ph7iQqnuwUfn8g3odB/Yp9/o7
   2PzFSP/u3EUTnAIT8hlys8ygjyKFpqYm3GXSvnYm8PKPyNhkn4/9/z7c1
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,301,1739836800"; 
   d="scan'208";a="198577743"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 21:02:18 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:14172]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.53:2525] with esmtp (Farcaster)
 id 5555b15b-f05c-4e00-853d-86b31a155c2e; Mon, 19 May 2025 21:02:18 +0000 (UTC)
X-Farcaster-Flow-ID: 5555b15b-f05c-4e00-853d-86b31a155c2e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 19 May 2025 21:02:16 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.169.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 19 May 2025 21:02:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v5 net-next 9/9] selftest: af_unix: Test SO_PASSRIGHTS.
Date: Mon, 19 May 2025 13:58:00 -0700
Message-ID: <20250519205820.66184-10-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519205820.66184-1-kuniyu@amazon.com>
References: <20250519205820.66184-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

scm_rights.c has various patterns of tests to exercise GC.

Let's add cases where SO_PASSRIGHTS is disabled.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
v4: Removed errno juggling
---
 .../selftests/net/af_unix/scm_rights.c        | 80 ++++++++++++++++++-
 1 file changed, 78 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/af_unix/scm_rights.c b/tools/testing/selftests/net/af_unix/scm_rights.c
index d66336256580..8b015f16c03d 100644
--- a/tools/testing/selftests/net/af_unix/scm_rights.c
+++ b/tools/testing/selftests/net/af_unix/scm_rights.c
@@ -23,6 +23,7 @@ FIXTURE_VARIANT(scm_rights)
 	int type;
 	int flags;
 	bool test_listener;
+	bool disabled;
 };
 
 FIXTURE_VARIANT_ADD(scm_rights, dgram)
@@ -31,6 +32,16 @@ FIXTURE_VARIANT_ADD(scm_rights, dgram)
 	.type = SOCK_DGRAM,
 	.flags = 0,
 	.test_listener = false,
+	.disabled = false,
+};
+
+FIXTURE_VARIANT_ADD(scm_rights, dgram_disabled)
+{
+	.name = "UNIX ",
+	.type = SOCK_DGRAM,
+	.flags = 0,
+	.test_listener = false,
+	.disabled = true,
 };
 
 FIXTURE_VARIANT_ADD(scm_rights, stream)
@@ -39,6 +50,16 @@ FIXTURE_VARIANT_ADD(scm_rights, stream)
 	.type = SOCK_STREAM,
 	.flags = 0,
 	.test_listener = false,
+	.disabled = false,
+};
+
+FIXTURE_VARIANT_ADD(scm_rights, stream_disabled)
+{
+	.name = "UNIX-STREAM ",
+	.type = SOCK_STREAM,
+	.flags = 0,
+	.test_listener = false,
+	.disabled = true,
 };
 
 FIXTURE_VARIANT_ADD(scm_rights, stream_oob)
@@ -47,6 +68,16 @@ FIXTURE_VARIANT_ADD(scm_rights, stream_oob)
 	.type = SOCK_STREAM,
 	.flags = MSG_OOB,
 	.test_listener = false,
+	.disabled = false,
+};
+
+FIXTURE_VARIANT_ADD(scm_rights, stream_oob_disabled)
+{
+	.name = "UNIX-STREAM ",
+	.type = SOCK_STREAM,
+	.flags = MSG_OOB,
+	.test_listener = false,
+	.disabled = true,
 };
 
 FIXTURE_VARIANT_ADD(scm_rights, stream_listener)
@@ -55,6 +86,16 @@ FIXTURE_VARIANT_ADD(scm_rights, stream_listener)
 	.type = SOCK_STREAM,
 	.flags = 0,
 	.test_listener = true,
+	.disabled = false,
+};
+
+FIXTURE_VARIANT_ADD(scm_rights, stream_listener_disabled)
+{
+	.name = "UNIX-STREAM ",
+	.type = SOCK_STREAM,
+	.flags = 0,
+	.test_listener = true,
+	.disabled = true,
 };
 
 FIXTURE_VARIANT_ADD(scm_rights, stream_listener_oob)
@@ -63,6 +104,16 @@ FIXTURE_VARIANT_ADD(scm_rights, stream_listener_oob)
 	.type = SOCK_STREAM,
 	.flags = MSG_OOB,
 	.test_listener = true,
+	.disabled = false,
+};
+
+FIXTURE_VARIANT_ADD(scm_rights, stream_listener_oob_disabled)
+{
+	.name = "UNIX-STREAM ",
+	.type = SOCK_STREAM,
+	.flags = MSG_OOB,
+	.test_listener = true,
+	.disabled = true,
 };
 
 static int count_sockets(struct __test_metadata *_metadata,
@@ -105,6 +156,9 @@ FIXTURE_SETUP(scm_rights)
 	ret = unshare(CLONE_NEWNET);
 	ASSERT_EQ(0, ret);
 
+	if (variant->disabled)
+		return;
+
 	ret = count_sockets(_metadata, variant);
 	ASSERT_EQ(0, ret);
 }
@@ -113,6 +167,9 @@ FIXTURE_TEARDOWN(scm_rights)
 {
 	int ret;
 
+	if (variant->disabled)
+		return;
+
 	sleep(1);
 
 	ret = count_sockets(_metadata, variant);
@@ -121,6 +178,7 @@ FIXTURE_TEARDOWN(scm_rights)
 
 static void create_listeners(struct __test_metadata *_metadata,
 			     FIXTURE_DATA(scm_rights) *self,
+			     const FIXTURE_VARIANT(scm_rights) *variant,
 			     int n)
 {
 	struct sockaddr_un addr = {
@@ -140,6 +198,12 @@ static void create_listeners(struct __test_metadata *_metadata,
 		ret = listen(self->fd[i], -1);
 		ASSERT_EQ(0, ret);
 
+		if (variant->disabled) {
+			ret = setsockopt(self->fd[i], SOL_SOCKET, SO_PASSRIGHTS,
+					 &(int){0}, sizeof(int));
+			ASSERT_EQ(0, ret);
+		}
+
 		addrlen = sizeof(addr);
 		ret = getsockname(self->fd[i], (struct sockaddr *)&addr, &addrlen);
 		ASSERT_EQ(0, ret);
@@ -164,6 +228,12 @@ static void create_socketpairs(struct __test_metadata *_metadata,
 	for (i = 0; i < n * 2; i += 2) {
 		ret = socketpair(AF_UNIX, variant->type, 0, self->fd + i);
 		ASSERT_EQ(0, ret);
+
+		if (variant->disabled) {
+			ret = setsockopt(self->fd[i], SOL_SOCKET, SO_PASSRIGHTS,
+					 &(int){0}, sizeof(int));
+			ASSERT_EQ(0, ret);
+		}
 	}
 }
 
@@ -175,7 +245,7 @@ static void __create_sockets(struct __test_metadata *_metadata,
 	ASSERT_LE(n * 2, sizeof(self->fd) / sizeof(self->fd[0]));
 
 	if (variant->test_listener)
-		create_listeners(_metadata, self, n);
+		create_listeners(_metadata, self, variant, n);
 	else
 		create_socketpairs(_metadata, self, variant, n);
 }
@@ -230,7 +300,13 @@ void __send_fd(struct __test_metadata *_metadata,
 	int ret;
 
 	ret = sendmsg(self->fd[receiver * 2 + 1], &msg, variant->flags);
-	ASSERT_EQ(MSGLEN, ret);
+
+	if (variant->disabled) {
+		ASSERT_EQ(-1, ret);
+		ASSERT_EQ(-EPERM, -errno);
+	} else {
+		ASSERT_EQ(MSGLEN, ret);
+	}
 }
 
 #define create_sockets(n)					\
-- 
2.49.0


