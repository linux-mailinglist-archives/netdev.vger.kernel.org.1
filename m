Return-Path: <netdev+bounces-290513-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EBGKdcrD2q3HQYAu9opvQ
	(envelope-from <netdev+bounces-290513-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:59:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CDF5A8CF1
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C868C3089B77
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEF8383334;
	Thu, 21 May 2026 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ktw9x9gD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C145137AA83;
	Thu, 21 May 2026 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374850; cv=none; b=RUt6Ld+d5X0MR6P0WPhro7rtTzuNTOSRXfYdz9mWDwQKjjVKFofVZRjXHeXPJhHP1+fmfVq84R+D+CxaHf/frSjoYgKik6CV0SKj69V13Nqe8vcyOb2eDG+3M9ccN8y3jUYrhaeQZm8eQOgmQn1FgXbUOBBcb0FB9Na3r7Utoqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374850; c=relaxed/simple;
	bh=RMSy++T+n+ADdPvDQT2ZwjkX3SvSS2RKeaUWi0ixpqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rHhi3AY++NDoHTaRvi7UXJ56NEhcuv2fTqjG8X0LJorJ3AypNbwRo1hrNRxEEzahaSvnSBc72Q6oBPgEI0dlXXLPT/Pwq4uhsOXcmosaiMn5UsglQ1YthZQ4naEaAEEUSWLS5WhKKmPwWYhG7Gr5v7CqQyBDhxOxAnuExbocTVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ktw9x9gD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DAC1F00ADE;
	Thu, 21 May 2026 14:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374848;
	bh=3PAX9LpNs8aLmCbckkPaxLO0qgmKZE461iQecMNq/vc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ktw9x9gD9Mm/xHKLRa4n+wFmYqI1BvLqIXhdfavlqk6f6+LoVVfLwvP3xXy4+Ug6A
	 9dfZ3p3i+7Lfq83/UC0f9pJ1D2STprwvj+FCCF/O4DCwEmcK/gcwvPF3Xbwjok3GI/
	 NG0EO3BEwkUNV/o7uI2iM9jpnmXZvU4r5/ppm3sbcygGeqZey1Zr+RVQ4tR+U/rNIn
	 jVGFRx+Kgz9lA4CM3+zkpxGRFnUoQBK7CbdEifxzSe7X4F5ltW+pvbV64WS/PvdYQw
	 Q4GP6O7LR2kTd+66v9czS1sqUZeqhRmp8qiHmKKx1A7dyK7wX36BIyoU4VwaKjKXSr
	 QR22Q9KxnFWHw==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 21 May 2026 10:47:13 -0400
Subject: [PATCH net v2 7/7] net/handshake: Verify file-reference balance in
 submit paths
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-handshake-file-pin-v2-7-b9dadc472840@oracle.com>
References: <20260521-handshake-file-pin-v2-0-b9dadc472840@oracle.com>
In-Reply-To: <20260521-handshake-file-pin-v2-0-b9dadc472840@oracle.com>
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
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqDxr3ej67sVntZ41isnfSY+qOHrC6o/k8qDrgY
 ZQV4l2R2cWJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCag8a9wAKCRAzarMzb2Z/
 l4TWD/9C0EmRQsjiwP3zWyj+Ym9qdf3fSoODN3IzLXJJyOMcD2aidsuPn90zTXPyDg/sc7JuQqS
 eq6tGSlG6B3ukOQs7s5SBfLLCgNMGlyYXNVJA8LcMQC7oiMl2R3V/AEaY1I9+a4vb0qsDAyUFgm
 WVuez1/nBjBhadQtKqJyFf+MvYiVGjdBk4j2QzaNAsTFN2YTlxB5L6fLPH85BxD9ZVP1UvzhUZw
 Up6HghUx2bn+GrSWzxHv7E9vAo85IWPYvltodygpW/IBPv3t27SRNhptoQ9v4sWY87JI2rf02LA
 VxMJvWPWqHstotG6wisnShEdAVg26NEE3NfJWXtGOtBZ5qC0WlkJ4KAAfgUiROIiD44jZ1RQiPB
 kCSvdZCjHnCDzYY33oZjni4ct1ViCcc+hmRKzHlwH+RcZbulHv/L0W2FodAbIErzT7N97hG8ZX+
 nQzt6WgSquSWGDlv20jAA+K9pA7yATwAj/+7F6Me/AGp0wpGi3LhySLJCVmj/cjviKSk9QQ3OoI
 EPfko/pGKoYiOFdVuet5wNgz7rSy4WNKc4JwxUcnlmpvVBFiuictNDIwO+sF7lwVuiqzShmeVvv
 BX51Csg2/Lo9audocPNvswANNROPfsPCZ61XZLJIcxTxsBEegmQuQhoesD1ox1QQFyY/aGjLNAH
 rPRyW+Pk+vIvTiQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290513-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A8CDF5A8CF1
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


