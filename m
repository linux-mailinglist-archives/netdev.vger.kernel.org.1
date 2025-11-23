Return-Path: <netdev+bounces-241069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD29FC7E7CF
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 22:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14BC64E0269
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 21:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB8822579E;
	Sun, 23 Nov 2025 21:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="VWDrtqYF"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F093B1A8F97;
	Sun, 23 Nov 2025 21:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763934273; cv=none; b=V/6JlUhnAq6NSe66YjrrChhkSuOZqmxxUCUJrO7yhbRkzHglRBLPOZkmW9JUC/wtp4kO7FShiJhywIhWHplb4AYDdnSqcDgbA/r8O1fB/wNBzo0uf8mrDNu2x8LmIo4sj6khLd3DyByevV/m9VsU2vpwNak7e5jm1r+U5RTFlDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763934273; c=relaxed/simple;
	bh=YnAqnVhefJQhHWyg4GDsHFfAzb/FVEajMMONO1WyS7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PEItizjdGNKeZAAp/kzGf4U6uqb/aoJD4YxK6LtmZQbvL4Y+ibOKWfkZK605JVhldy5D6mMuednnMq8e9tu4a2XSIAcOiMcboEeeaFjsgjQiMjCcmX534fOKLB+4mOF0IPBjkM8SzzX2CoDqWFLsvYkoczT5VINoky7G/qKieck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=VWDrtqYF; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vNHsf-001NcD-LY; Sun, 23 Nov 2025 22:44:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From;
	bh=V9XciyjlPqOIODNDKT7LjWupfpjUN2cRjyKec+JBlfM=; b=VWDrtqYFUqaINJQB8CERFZ+0oQ
	z/z/3QgZKEvH4nvQDP+0znA97SeCwshuFbgbxWouvEGXjFseVqH8BmcghuONbD8lf6MnO0sug34ka
	J/O7FBmrKXaJmFSglZW9rw4hT/uH9Jtm68h3s8uSzpIX+IICxSViEkwUjvZ7Ke2/fcuk6ZU5a6RVg
	pq/Lmk30HVlfnvcvQt1Y3SUJ7sOj8eeGZ7zUui2vbh8uLQqxjHTCjVZLKXrX3xHqq2yu8tw+GU2aA
	0C6KFlcLZ+ELxTrI2bk2YXwc6StRf94xgkpefDvyNzXH8Q0eDszHzN1f/xVaTc/mAsN0S7x6IWVmP
	VpZ1Fl4A==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vNHsf-0005lR-6m; Sun, 23 Nov 2025 22:44:25 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vNHsX-006w0W-Ew; Sun, 23 Nov 2025 22:44:17 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Sun, 23 Nov 2025 22:43:59 +0100
Subject: [PATCH net-next] vsock/test: Extend transport change
 null-ptr-deref test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-vsock_test-linger-lockdep-warn-v1-1-4b1edf9d8cdc@rbox.co>
X-B4-Tracking: v=1; b=H4sIAB6AI2kC/x2NUQqDMBAFryL73QUTGii9SiklTV7bpbLKJqgg3
 t3g57yBNxsVmKDQvdvIMEuRURu4S0fpF/ULltyYfO+Dc97xXMb0f1WUyoM0bzy0IWPiJZoyrim
 8bxkxoKd2Mhk+sp6BBykqK9ZKz30/AGGMtwt6AAAA
X-Change-ID: 20251121-vsock_test-linger-lockdep-warn-e4c5b8dea5e0
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.3

syzkaller reported a lockdep lock order inversion warning[1] due to
commit 687aa0c5581b ("vsock: Fix transport_* TOCTOU"). This was fixed in
commit f7c877e75352 ("vsock: fix lock inversion in
vsock_assign_transport()").

Redo syzkaller's repro by piggybacking on a somewhat related test
implemented in commit 3a764d93385c ("vsock/test: Add test for null ptr
deref when transport changes").

[1]: https://lore.kernel.org/netdev/68f6cdb0.a70a0220.205af.0039.GAE@google.com/

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/vsock_test.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index d4517386e551..9e1250790f33 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -2015,6 +2015,11 @@ static void test_stream_transport_change_client(const struct test_opts *opts)
 			exit(EXIT_FAILURE);
 		}
 
+		/* Although setting SO_LINGER does not affect the original test
+		 * for null-ptr-deref, it may trigger a lockdep warning.
+		 */
+		enable_so_linger(s, 1);
+
 		ret = connect(s, (struct sockaddr *)&sa, sizeof(sa));
 		/* The connect can fail due to signals coming from the thread,
 		 * or because the receiver connection queue is full.
@@ -2352,7 +2357,7 @@ static struct test_case test_cases[] = {
 		.run_server = test_stream_nolinger_server,
 	},
 	{
-		.name = "SOCK_STREAM transport change null-ptr-deref",
+		.name = "SOCK_STREAM transport change null-ptr-deref, lockdep warn",
 		.run_client = test_stream_transport_change_client,
 		.run_server = test_stream_transport_change_server,
 	},

---
base-commit: 73138ebe792b9af2954292cc5cfa780a5e796d97
change-id: 20251121-vsock_test-linger-lockdep-warn-e4c5b8dea5e0

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


