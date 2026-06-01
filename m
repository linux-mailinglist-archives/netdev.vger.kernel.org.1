Return-Path: <netdev+bounces-293785-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cC8NEoGVHWrOcQkAu9opvQ
	(envelope-from <netdev+bounces-293785-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 16:21:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 524D0620C50
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 16:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5DB8301ADB9
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 14:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C09A3AF65C;
	Mon,  1 Jun 2026 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nK56t7Sk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6BD3A4F5F;
	Mon,  1 Jun 2026 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322984; cv=none; b=dd9/x92TEFh2MFzXNhTC18G/wdWecru9lNuvsSAOZiPP0ZXLpXxH2C1BPU0GYv/6ZCukoyoeqesXwOuV0XCYjZ2pV0Hz7Q39suZD9aZaJ3FnQesktRSl9v+028ACJOgCvd9u6jmostLU4xOtkW0sGFjcUwQtoiQhbeiW4qygHsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322984; c=relaxed/simple;
	bh=W90CEjmqdQtLXvTPSjkHVPqTlrbDW3Cv3YeH8a/Bacc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JQH+egIkGC0hGHqaxZue19eEgNVFXaBJ1wr1rKNdR4zut5dR5tpYfxHo1Q/YPWPEitKiGdR1B+AND1jkr7lSXKlmQCnQneTuK3cDzCCvxtORadIFaFWFFn/Bss6Xf6hWywLKIxU6baJnO3hAI4s15C+lnq8xOi34EWobG/KM1kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nK56t7Sk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C641F00893;
	Mon,  1 Jun 2026 14:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322983;
	bh=7c7ZlcuLKmLLIJdwA+y6U1jFIP0Igo0wypw8E75Jj64=;
	h=From:To:Subject:Date;
	b=nK56t7SkjIjifpBudwRUYXyhhLCNYPxm0dnTcRT4/nDuBcA54yOeErKcK1Yu523GP
	 AW1MhU/WiECUyYqa4z+dCVCxfYm2XjLRZC8e+o8Zw0ueOrzgACMVyyavnIPclhrZwS
	 c0/xiSAD0o6P4eQCahJUIk6aGjulqVhlEuE/Tz6Xl0S92OpeASEetXT2WgrvwUzicS
	 4FRE2G/3D/nmOkjKDElE9dAZmf5xBGucckmkPln6sOywEUi4FYbPT64h0NYEUkrxFy
	 30Ea7bRow9DIP/L+vp/tndzSlIqdhhBD4P9jgYp65FxUiATwH4+7wGawEOhFyH1KZv
	 KPHEMwu8/AW0g==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	David Heidelberg <david+nfc@ixit.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Szymon Janc <szymon.janc@tieto.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] nfc: llcp: Fix race condition in accept_queue lifecycle
Date: Mon,  1 Jun 2026 14:09:30 +0000
Message-ID: <20260601140934.1040144-1-lee@kernel.org>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-293785-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,nfc];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 524D0620C50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfc_llcp_socket_release() walks the local sockets list and the listener
socket's accept_queue under bh_lock_sock().  However, bh_lock_sock()
does not provide mutual exclusion against process-context lock_sock()
held by nfc_llcp_accept_dequeue() during accept().  Since socket_release()
runs in process context (workqueue or kref cleanup), it never checks
sock_owned_by_user(), allowing both paths to manipulate the same child
socket concurrently.  This leads to a double sock_put() (Use-After-Free)
or a NULL pointer dereference of child->parent in nfc_llcp_accept_unlink().

Fix this by converting nfc_llcp_socket_release() to use lock_sock().
Since it is called with the local sockets write-lock held (which disables
preemption, preventing sleep), repeatedly pop the head socket from the
list under the write-lock using a new helper nfc_llcp_sock_list_pop(),
then safely acquire lock_sock() on it after dropping the list lock.
A sock_hold() is taken under the list lock to keep the socket alive
across the sleep and balanced with a sock_put() after release.

Additionally, add a check for a non-NULL parent in nfc_llcp_accept_unlink()
to ensure idempotency and prevent NULL pointer dereference if the unlink
races with dequeue.

Fixes: 50b78b2a6500 ("NFC: Fix sleeping in atomic when releasing socket")
Signed-off-by: Lee Jones <lee@kernel.org>
---
 net/nfc/llcp_core.c | 47 +++++++++++++++++++++++++--------------------
 net/nfc/llcp_sock.c | 13 +++++++------
 2 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index dc65c719f35f2..e51bd0d081b62 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -63,21 +63,33 @@ static void nfc_llcp_socket_purge(struct nfc_llcp_sock *sock)
 	}
 }
 
+static struct sock *nfc_llcp_sock_list_pop(struct llcp_sock_list *l)
+{
+	struct sock *sk;
+
+	write_lock(&l->lock);
+	sk = sk_head(&l->head);
+	if (sk) {
+		sock_hold(sk);
+		sk_del_node_init(sk);
+	}
+	write_unlock(&l->lock);
+
+	return sk;
+}
+
 static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
 				    int err)
 {
 	struct sock *sk;
-	struct hlist_node *tmp;
 	struct nfc_llcp_sock *llcp_sock;
 
 	skb_queue_purge(&local->tx_queue);
 
-	write_lock(&local->sockets.lock);
-
-	sk_for_each_safe(sk, tmp, &local->sockets.head) {
+	while ((sk = nfc_llcp_sock_list_pop(&local->sockets))) {
 		llcp_sock = nfc_llcp_sock(sk);
 
-		bh_lock_sock(sk);
+		lock_sock(sk);
 
 		nfc_llcp_socket_purge(llcp_sock);
 
@@ -92,7 +104,8 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
 						 &llcp_sock->accept_queue,
 						 accept_queue) {
 				accept_sk = &lsk->sk;
-				bh_lock_sock(accept_sk);
+				lock_sock_nested(accept_sk,
+						 SINGLE_DEPTH_NESTING);
 
 				nfc_llcp_accept_unlink(accept_sk);
 
@@ -101,7 +114,7 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
 				accept_sk->sk_state = LLCP_CLOSED;
 				accept_sk->sk_state_change(sk);
 
-				bh_unlock_sock(accept_sk);
+				release_sock(accept_sk);
 			}
 		}
 
@@ -110,23 +123,18 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
 		sk->sk_state = LLCP_CLOSED;
 		sk->sk_state_change(sk);
 
-		bh_unlock_sock(sk);
-
-		sk_del_node_init(sk);
+		release_sock(sk);
+		sock_put(sk);
 	}
 
-	write_unlock(&local->sockets.lock);
-
 	/* If we still have a device, we keep the RAW sockets alive */
 	if (device == true)
 		return;
 
-	write_lock(&local->raw_sockets.lock);
-
-	sk_for_each_safe(sk, tmp, &local->raw_sockets.head) {
+	while ((sk = nfc_llcp_sock_list_pop(&local->raw_sockets))) {
 		llcp_sock = nfc_llcp_sock(sk);
 
-		bh_lock_sock(sk);
+		lock_sock(sk);
 
 		nfc_llcp_socket_purge(llcp_sock);
 
@@ -135,12 +143,9 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
 		sk->sk_state = LLCP_CLOSED;
 		sk->sk_state_change(sk);
 
-		bh_unlock_sock(sk);
-
-		sk_del_node_init(sk);
+		release_sock(sk);
+		sock_put(sk);
 	}
-
-	write_unlock(&local->raw_sockets.lock);
 }
 
 static struct nfc_llcp_local *nfc_llcp_local_get(struct nfc_llcp_local *local)
diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index feab29fc62f44..3d30f0233b986 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -384,11 +384,12 @@ void nfc_llcp_accept_unlink(struct sock *sk)
 
 	pr_debug("state %d\n", sk->sk_state);
 
-	list_del_init(&llcp_sock->accept_queue);
-	sk_acceptq_removed(llcp_sock->parent);
-	llcp_sock->parent = NULL;
-
-	sock_put(sk);
+	if (llcp_sock->parent) {
+		list_del_init(&llcp_sock->accept_queue);
+		sk_acceptq_removed(llcp_sock->parent);
+		llcp_sock->parent = NULL;
+		sock_put(sk);
+	}
 }
 
 void nfc_llcp_accept_enqueue(struct sock *parent, struct sock *sk)
@@ -622,7 +623,7 @@ static int llcp_sock_release(struct socket *sock)
 		list_for_each_entry_safe(lsk, n, &llcp_sock->accept_queue,
 					 accept_queue) {
 			accept_sk = &lsk->sk;
-			lock_sock(accept_sk);
+			lock_sock_nested(accept_sk, SINGLE_DEPTH_NESTING);
 
 			nfc_llcp_send_disconnect(lsk);
 			nfc_llcp_accept_unlink(accept_sk);
-- 
2.54.0.823.g6e5bcc1fc9-goog


