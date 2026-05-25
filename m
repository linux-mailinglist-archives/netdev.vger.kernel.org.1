Return-Path: <netdev+bounces-291383-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FTrBsh+FGp0NwcAu9opvQ
	(envelope-from <netdev+bounces-291383-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 18:54:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 608985CD14B
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 18:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB7433037478
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 16:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDF63F54A0;
	Mon, 25 May 2026 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7olFWCH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2470B3F5BF1;
	Mon, 25 May 2026 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779727900; cv=none; b=Bxm3+TjxeDs13Gmr5i8f3N9cPEladQbEFJx3vdn1Zpx5sv7NYJYvAL7NF8gdLJ9kbBUQjG+1dq1aaA4eZ0+CQeDXrqLLQKAtsuc2SeC/amD8MZMdW6tINowSGEKNX+pBILlE2WEL5b+RLVP15ji21UKJZi4Vb5HVTgvQKoSfbqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779727900; c=relaxed/simple;
	bh=RMSy++T+n+ADdPvDQT2ZwjkX3SvSS2RKeaUWi0ixpqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TVH7V7dVDAmkZlO+2ijXEg8mKmh6TPPHETKUksjDLxla4t3f37O+QVkN3jNMkqHiqvhKH1Vc3j4p1fM65jT4x4bMzBYiN8m8OuGnG/yVtGZ4kq4x6JsEMRwDsbmD0+o9BRLYgvPvhgwq5M+N0C94+vZRoCHCaQNjxzr2LY8Dls4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7olFWCH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4F91F00A3D;
	Mon, 25 May 2026 16:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779727899;
	bh=3PAX9LpNs8aLmCbckkPaxLO0qgmKZE461iQecMNq/vc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=I7olFWCHiANyqup4+4IcNRNdFu1nwD//nBmYomKNOLzfStXgi8gAqbMJyee6Kyn+5
	 1RlQ5HA5pp7qbmkFklQthw+CBFMYI8p/wrbvTnlMcLDBv1QxAOc8KrTr2d0eIDRvw7
	 DIX9nRpKG2ADTULyCWiNV2iHFqnozeBIcI+TuNWMflLXevZ0sPg1eJEIXNjjCAyKxZ
	 nLsK6QxwU5TJ+tYYReDdN7WHtJljqSDAA7fDc6fWn0Scx85mUG1fdMqziNm0IXjIpB
	 qUKRvN2B4cl1nGMi0VZEku2x/cY8oGLd5D+VP+KLFokVWv7t5Z5kqDTssnKxEDsMbx
	 ESNO5muyI+XRw==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 25 May 2026 12:51:21 -0400
Subject: [PATCH net v3 7/8] net/handshake: Verify file-reference balance in
 submit paths
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-handshake-file-pin-v3-7-66c616906ead@oracle.com>
References: <20260525-handshake-file-pin-v3-0-66c616906ead@oracle.com>
In-Reply-To: <20260525-handshake-file-pin-v3-0-66c616906ead@oracle.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>, 
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org, 
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, 
 Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=7067;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=nCAvZ2Oci4lXVc/4ZoCdnie10corqh91J3ksH3YwEd4=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqFH4Sn1gvqTc0rMAb1UPHRlD20Hggbg+cvd3+v
 fckRVzKcpiJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahR+EgAKCRAzarMzb2Z/
 lwk8EACp2qFS2pZwMtJ0SHG1JG8lL92NQLXxHiM2O5h0imlPnm1aTubfYYTuTzA8iE4Snq1+ctL
 ZyXkZtKYtyAoLzx+NR+w93/kAWMDJ/qdT2zK6nVqy3ZEiOsg189u8xuG/0pCy8mlEZNKC4Wc5kz
 oD8Sy/S6d1VtVYU/rnZbUgeqgfJliMjIX2DtYkigdD3OowmW2kft1XRXediflRnSMPmoX6EVqgB
 CeUxYrYimX73kR095vhEx/TR0h4W+MQcqiMp9P0Za7qCK9SeyySg1zOmotUh2m+EV7A4ByewoDA
 ONiKxK2E8nwyMU0Xl3LmckcsJ+RrB6Zc1jTyDelhfaCBhK7hNRFBBWdf/D7G7CDRQpBt8cYtPw1
 5wjPRdharNP6/DB1VpqgttqE8WHpHy7ovmwxdK3XilC8W6sshVMlGJdnigoZ31GJlllrf2VOTBA
 PSD6VZdgN6X8UHkKc2WLzZ64/a4xluOci4U63upzEARui4pPXhQ1I0vqN6qRrBnTxeNtCJIQ0if
 7zp0T8h3ntZ5YlkLZcefZzrkeaiXNr8tAI1YJRDCbVs4wdfHCqJzxKCrnI1AlClpD7sCiNaYr7T
 9NVKwqeh00ASV25RCkQAT8Vb3JVlbMm7RHxo4nxApCvWo1/A5NhTliyvwB+VFADzbIuhwY5QZiY
 xv62zsVKvj+UIPQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291383-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 608985CD14B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

The new file-reference contract on struct handshake_req is silently
breakable: a missing get_file() at submit or a missing fput() on an
error path leaves the file leaked but does not crash the test, so
the existing absence-of-crash checks pass either way.

Snapshot file_count(filp) before each handshake_req_submit() in
the submit-success, EAGAIN, EBUSY, and cancel tests, and assert
the expected balance after submit and again after cancel. The
already-completed cancel test also asserts the post-complete
balance, which pins down that handshake_complete() drops the
reference and that the subsequent cancel does not double-fput.
The destroy test gets the same treatment before __fput_sync(),
which double-checks that cancel's fput() ran and the only
remaining reference is the one sock_alloc_file() established.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 net/handshake/handshake-test.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/net/handshake/handshake-test.c b/net/handshake/handshake-test.c
index 9cc7a95f4120..3dd507470d5f 100644
--- a/net/handshake/handshake-test.c
+++ b/net/handshake/handshake-test.c
@@ -208,6 +208,7 @@ static void handshake_req_submit_test3(struct kunit *test)
 static void handshake_req_submit_test4(struct kunit *test)
 {
 	struct handshake_req *req, *result;
+	unsigned long fcount_before;
 	struct socket *sock;
 	struct file *filp;
 	int err;
@@ -224,8 +225,10 @@ static void handshake_req_submit_test4(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, sock->sk);
 	sock->file = filp;
 
+	fcount_before = file_count(filp);
 	err = handshake_req_submit(sock, req, GFP_KERNEL);
 	KUNIT_ASSERT_EQ(test, err, 0);
+	KUNIT_EXPECT_EQ(test, file_count(filp), fcount_before + 1);
 
 	/* Act */
 	result = handshake_req_hash_lookup(sock->sk);
@@ -235,11 +238,13 @@ static void handshake_req_submit_test4(struct kunit *test)
 	KUNIT_EXPECT_PTR_EQ(test, req, result);
 
 	handshake_req_cancel(sock->sk);
+	KUNIT_EXPECT_EQ(test, file_count(filp), fcount_before);
 	fput(filp);
 }
 
 static void handshake_req_submit_test5(struct kunit *test)
 {
+	unsigned long fcount_before;
 	struct handshake_req *req;
 	struct handshake_net *hn;
 	struct socket *sock;
@@ -265,12 +270,14 @@ static void handshake_req_submit_test5(struct kunit *test)
 
 	saved = hn->hn_pending;
 	hn->hn_pending = hn->hn_pending_max + 1;
+	fcount_before = file_count(filp);
 
 	/* Act */
 	err = handshake_req_submit(sock, req, GFP_KERNEL);
 
 	/* Assert */
 	KUNIT_EXPECT_EQ(test, err, -EAGAIN);
+	KUNIT_EXPECT_EQ(test, file_count(filp), fcount_before);
 
 	fput(filp);
 	hn->hn_pending = saved;
@@ -279,6 +286,7 @@ static void handshake_req_submit_test5(struct kunit *test)
 static void handshake_req_submit_test6(struct kunit *test)
 {
 	struct handshake_req *req1, *req2;
+	unsigned long fcount_before;
 	struct socket *sock;
 	struct file *filp;
 	int err;
@@ -296,21 +304,26 @@ static void handshake_req_submit_test6(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filp);
 	KUNIT_ASSERT_NOT_NULL(test, sock->sk);
 	sock->file = filp;
+	fcount_before = file_count(filp);
 
 	/* Act */
 	err = handshake_req_submit(sock, req1, GFP_KERNEL);
 	KUNIT_ASSERT_EQ(test, err, 0);
+	KUNIT_EXPECT_EQ(test, file_count(filp), fcount_before + 1);
 	err = handshake_req_submit(sock, req2, GFP_KERNEL);
 
 	/* Assert */
 	KUNIT_EXPECT_EQ(test, err, -EBUSY);
+	KUNIT_EXPECT_EQ(test, file_count(filp), fcount_before + 1);
 
 	handshake_req_cancel(sock->sk);
+	KUNIT_EXPECT_EQ(test, file_count(filp), fcount_before);
 	fput(filp);
 }
 
 static void handshake_req_cancel_test1(struct kunit *test)
 {
+	unsigned long fcount_before;
 	struct handshake_req *req;
 	struct socket *sock;
 	struct file *filp;
@@ -329,8 +342,10 @@ static void handshake_req_cancel_test1(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filp);
 	sock->file = filp;
 
+	fcount_before = file_count(filp);
 	err = handshake_req_submit(sock, req, GFP_KERNEL);
 	KUNIT_ASSERT_EQ(test, err, 0);
+	KUNIT_EXPECT_EQ(test, file_count(filp), fcount_before + 1);
 
 	/* NB: handshake_req hasn't been accepted */
 
@@ -339,12 +354,14 @@ static void handshake_req_cancel_test1(struct kunit *test)
 
 	/* Assert */
 	KUNIT_EXPECT_TRUE(test, result);
+	KUNIT_EXPECT_EQ(test, file_count(filp), fcount_before);
 
 	fput(filp);
 }
 
 static void handshake_req_cancel_test2(struct kunit *test)
 {
+	unsigned long fcount_before;
 	struct handshake_req *req, *next;
 	struct handshake_net *hn;
 	struct socket *sock;
@@ -365,8 +382,10 @@ static void handshake_req_cancel_test2(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filp);
 	sock->file = filp;
 
+	fcount_before = file_count(filp);
 	err = handshake_req_submit(sock, req, GFP_KERNEL);
 	KUNIT_ASSERT_EQ(test, err, 0);
+	KUNIT_EXPECT_EQ(test, file_count(filp), fcount_before + 1);
 
 	net = sock_net(sock->sk);
 	hn = handshake_pernet(net);
@@ -385,12 +404,14 @@ static void handshake_req_cancel_test2(struct kunit *test)
 
 	/* Assert */
 	KUNIT_EXPECT_TRUE(test, result);
+	KUNIT_EXPECT_EQ(test, file_count(filp), fcount_before);
 
 	fput(filp);
 }
 
 static void handshake_req_cancel_test3(struct kunit *test)
 {
+	unsigned long fcount_before;
 	struct handshake_req *req, *next;
 	struct handshake_net *hn;
 	struct socket *sock;
@@ -411,8 +432,10 @@ static void handshake_req_cancel_test3(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filp);
 	sock->file = filp;
 
+	fcount_before = file_count(filp);
 	err = handshake_req_submit(sock, req, GFP_KERNEL);
 	KUNIT_ASSERT_EQ(test, err, 0);
+	KUNIT_EXPECT_EQ(test, file_count(filp), fcount_before + 1);
 
 	net = sock_net(sock->sk);
 	hn = handshake_pernet(net);
@@ -428,12 +451,14 @@ static void handshake_req_cancel_test3(struct kunit *test)
 
 	/* Pretend to complete this request */
 	handshake_complete(next, -ETIMEDOUT, NULL);
+	KUNIT_EXPECT_EQ(test, file_count(filp), fcount_before);
 
 	/* Act */
 	result = handshake_req_cancel(sock->sk);
 
 	/* Assert */
 	KUNIT_EXPECT_FALSE(test, result);
+	KUNIT_EXPECT_EQ(test, file_count(filp), fcount_before);
 
 	fput(filp);
 }
@@ -454,6 +479,7 @@ static struct handshake_proto handshake_req_alloc_proto_destroy = {
 
 static void handshake_req_destroy_test1(struct kunit *test)
 {
+	unsigned long fcount_before;
 	struct handshake_req *req;
 	struct socket *sock;
 	struct file *filp;
@@ -473,10 +499,12 @@ static void handshake_req_destroy_test1(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filp);
 	sock->file = filp;
 
+	fcount_before = file_count(filp);
 	err = handshake_req_submit(sock, req, GFP_KERNEL);
 	KUNIT_ASSERT_EQ(test, err, 0);
 
 	handshake_req_cancel(sock->sk);
+	KUNIT_EXPECT_EQ(test, file_count(filp), fcount_before);
 
 	/* Act */
 	/* Ensure the close/release/put process has run to

-- 
2.54.0


