Return-Path: <netdev+bounces-275396-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZniiFxs70WkxGwcAu9opvQ
	(envelope-from <netdev+bounces-275396-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 18:23:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D583E39BB67
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 18:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6468D30099BD
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 16:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42DD390201;
	Sat,  4 Apr 2026 16:23:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC1B2C11DF;
	Sat,  4 Apr 2026 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775319829; cv=none; b=XmN7afz+li62Jw3w12cihEbqBcjhoYi/a7bWB+eb/DOoZBTd6hKvyJU6q4WyM10jKwpNIWxRqUu8Nu+EYVQPbAK8INXtJTSXzb5HhvGIAwltMGWXmE5lh2kYl0VkfndcL/+P51RSjIdEjDDpg4DG2vZIMj0zXZw2l7G/mRd3u00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775319829; c=relaxed/simple;
	bh=aN/f3uYkVk0LJ895oV954fbCQzINY8es7IDD2UnpsKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KezrYN6JBa0obwK3N5INlh3pEDI0wPBS8x8w1Si3YQdxbYIdeAjmUc5YYK7RwN3sm1aLjWlYpI25t8vzt8YNuZfIJZ9sls001A3D8sS22qKVY02YybaPOJLEPwJf2YwFJ845mO0B2RfrxrKeyaoxqW6DVQ1y2K5GyMgU/N3BjMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowAC3LwD8OtFpcPulAA--.37028S2;
	Sun, 05 Apr 2026 00:23:25 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	yuantan098@gmail.com,
	bird@lzu.edu.cn,
	enjou1224z@gmail.com,
	wangjiexun2025@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH v3 1/1] Bluetooth: serialize accept_q access
Date: Sun,  5 Apr 2026 00:23:17 +0800
Message-ID: <20260404162324.2789862-1-n05ec@lzu.edu.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1774454568.git.wangjiexun2025@gmail.com>
References: <cover.1774454568.git.wangjiexun2025@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowAC3LwD8OtFpcPulAA--.37028S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw47Cry8uF48uFykAFy8uFg_yoWxCFyDpF
	yUCFZ8GFWkJw45uw13taykurWSyw1rWr43GayFvas5Ar9agFWrtF12yayjvr1YyrZ7CF4S
	yF4jgwnxCr4UCFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_JFC_Wr1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wrylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRMXdjDUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQUHCWnRM-0AHgAAsi
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275396-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[lzu.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[molgen.mpg.de,holtmann.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,lzu.edu.cn];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.974];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lzu.edu.cn:email,lzu.edu.cn:mid]
X-Rspamd-Queue-Id: D583E39BB67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiexun Wang <wangjiexun2025@gmail.com>

bt_sock_poll() walks the accept queue without synchronization, while
child teardown can unlink the same socket and drop its last reference.

Protect accept_q with a dedicated lock for queue updates and polling.
Also rework bt_accept_dequeue() to take temporary child references under
the queue lock before dropping it and locking the child socket.

Fixes: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 ("Linux-2.6.12-rc2")
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Tested-by: Ren Wei <enjou1224z@gmail.com>
Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
Changes in v3:
- move sk_acceptq_added()/sk_acceptq_removed() inside accept_q_lock
  critical sections to serialize sk_ack_backlog updates with accept_q
  operations

Changes in v2:
- add Tested-by: Ren Wei <enjou1224z@gmail.com>
- resend to the public Bluetooth/netdev lists

 include/net/bluetooth/bluetooth.h |  1 +
 net/bluetooth/af_bluetooth.c      | 87 +++++++++++++++++++++++--------
 2 files changed, 66 insertions(+), 22 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 69eed69f7f26..3faea66b1979 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -398,6 +398,7 @@ void baswap(bdaddr_t *dst, const bdaddr_t *src);
 struct bt_sock {
 	struct sock sk;
 	struct list_head accept_q;
+	spinlock_t accept_q_lock; /* protects accept_q */
 	struct sock *parent;
 	unsigned long flags;
 	void (*skb_msg_name)(struct sk_buff *, void *, int *);
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 2b94e2077203..fa14b9a915eb 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -154,6 +154,7 @@ struct sock *bt_sock_alloc(struct net *net, struct socket *sock,
 
 	sock_init_data(sock, sk);
 	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
+	spin_lock_init(&bt_sk(sk)->accept_q_lock);
 
 	sock_reset_flag(sk, SOCK_ZAPPED);
 
@@ -214,6 +215,7 @@ void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
 {
 	const struct cred *old_cred;
 	struct pid *old_pid;
+	struct bt_sock *par = bt_sk(parent);
 
 	BT_DBG("parent %p, sk %p", parent, sk);
 
@@ -224,9 +226,13 @@ void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
 	else
 		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
 
-	list_add_tail(&bt_sk(sk)->accept_q, &bt_sk(parent)->accept_q);
 	bt_sk(sk)->parent = parent;
 
+	spin_lock_bh(&par->accept_q_lock);
+	list_add_tail(&bt_sk(sk)->accept_q, &par->accept_q);
+	sk_acceptq_added(parent);
+	spin_unlock_bh(&par->accept_q_lock);
+
 	/* Copy credentials from parent since for incoming connections the
 	 * socket is allocated by the kernel.
 	 */
@@ -244,8 +250,6 @@ void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
 		bh_unlock_sock(sk);
 	else
 		release_sock(sk);
-
-	sk_acceptq_added(parent);
 }
 EXPORT_SYMBOL(bt_accept_enqueue);
 
@@ -254,45 +258,72 @@ EXPORT_SYMBOL(bt_accept_enqueue);
  */
 void bt_accept_unlink(struct sock *sk)
 {
+	struct sock *parent = bt_sk(sk)->parent;
+
 	BT_DBG("sk %p state %d", sk, sk->sk_state);
 
+	spin_lock_bh(&bt_sk(parent)->accept_q_lock);
 	list_del_init(&bt_sk(sk)->accept_q);
-	sk_acceptq_removed(bt_sk(sk)->parent);
+	sk_acceptq_removed(parent);
+	spin_unlock_bh(&bt_sk(parent)->accept_q_lock);
 	bt_sk(sk)->parent = NULL;
 	sock_put(sk);
 }
 EXPORT_SYMBOL(bt_accept_unlink);
 
+static struct sock *bt_accept_get(struct sock *parent, struct sock *sk)
+{
+	struct bt_sock *bt = bt_sk(parent);
+	struct sock *next = NULL;
+
+	/* accept_q is modified from child teardown paths too, so take a
+	 * temporary reference before dropping the queue lock.
+	 */
+	spin_lock_bh(&bt->accept_q_lock);
+
+	if (sk) {
+		if (bt_sk(sk)->parent != parent)
+			goto out;
+
+		if (!list_is_last(&bt_sk(sk)->accept_q, &bt->accept_q)) {
+			next = &list_next_entry(bt_sk(sk), accept_q)->sk;
+			sock_hold(next);
+		}
+	} else if (!list_empty(&bt->accept_q)) {
+		next = &list_first_entry(&bt->accept_q,
+					 struct bt_sock, accept_q)->sk;
+		sock_hold(next);
+	}
+
+out:
+	spin_unlock_bh(&bt->accept_q_lock);
+	return next;
+}
+
 struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
 {
-	struct bt_sock *s, *n;
-	struct sock *sk;
+	struct sock *sk, *next;
 
 	BT_DBG("parent %p", parent);
 
 restart:
-	list_for_each_entry_safe(s, n, &bt_sk(parent)->accept_q, accept_q) {
-		sk = (struct sock *)s;
-
+	for (sk = bt_accept_get(parent, NULL); sk; sk = next) {
 		/* Prevent early freeing of sk due to unlink and sock_kill */
-		sock_hold(sk);
 		lock_sock(sk);
 
 		/* Check sk has not already been unlinked via
 		 * bt_accept_unlink() due to serialisation caused by sk locking
 		 */
-		if (!bt_sk(sk)->parent) {
+		if (bt_sk(sk)->parent != parent) {
 			BT_DBG("sk %p, already unlinked", sk);
 			release_sock(sk);
 			sock_put(sk);
 
-			/* Restart the loop as sk is no longer in the list
-			 * and also avoid a potential infinite loop because
-			 * list_for_each_entry_safe() is not thread safe.
-			 */
 			goto restart;
 		}
 
+		next = bt_accept_get(parent, sk);
+
 		/* sk is safely in the parent list so reduce reference count */
 		sock_put(sk);
 
@@ -310,6 +341,8 @@ struct sock *bt_accept_dequeue(struct sock *parent, struct socket *newsock)
 				sock_graft(sk, newsock);
 
 			release_sock(sk);
+			if (next)
+				sock_put(next);
 			return sk;
 		}
 
@@ -518,18 +551,28 @@ EXPORT_SYMBOL(bt_sock_stream_recvmsg);
 
 static inline __poll_t bt_accept_poll(struct sock *parent)
 {
-	struct bt_sock *s, *n;
+	struct bt_sock *bt = bt_sk(parent);
+	struct bt_sock *s;
 	struct sock *sk;
+	__poll_t mask = 0;
+
+	spin_lock_bh(&bt->accept_q_lock);
+	list_for_each_entry(s, &bt->accept_q, accept_q) {
+		int state;
 
-	list_for_each_entry_safe(s, n, &bt_sk(parent)->accept_q, accept_q) {
 		sk = (struct sock *)s;
-		if (sk->sk_state == BT_CONNECTED ||
-		    (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags) &&
-		     sk->sk_state == BT_CONNECT2))
-			return EPOLLIN | EPOLLRDNORM;
+		state = READ_ONCE(sk->sk_state);
+
+		if (state == BT_CONNECTED ||
+		    (test_bit(BT_SK_DEFER_SETUP, &bt->flags) &&
+		     state == BT_CONNECT2)) {
+			mask = EPOLLIN | EPOLLRDNORM;
+			break;
+		}
 	}
+	spin_unlock_bh(&bt->accept_q_lock);
 
-	return 0;
+	return mask;
 }
 
 __poll_t bt_sock_poll(struct file *file, struct socket *sock,
-- 
2.34.1


