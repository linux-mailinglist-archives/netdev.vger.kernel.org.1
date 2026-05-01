Return-Path: <netdev+bounces-283210-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0A+wGsTA9GkDEQIAu9opvQ
	(envelope-from <netdev+bounces-283210-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 17:03:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F315B4AD7C3
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 17:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13474300D601
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 15:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603023CA4AD;
	Fri,  1 May 2026 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hb0oOPwa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082693CAE60
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777647796; cv=none; b=e8G8VpHUGpNp0I2cX5jVopjCAelMQ0UC4gAt4XFQHYFfmbO4KzE80DDHu+ulP7KV7K+j/Rmbu8k0dPr5r3LQR+Bs0ssmDme8uZI9FHz2Y/NwY8OnBbzGM+fGz9+kIoSdhO2G4xma0r/6UP7WQx4044McTlf9gX7DhCy5arclSq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777647796; c=relaxed/simple;
	bh=Xj1qHrlavKRPo+s72/orvb8seid96VoKXE1IrloD2nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WijjgjB1AydEbDvMecLN9kD4u1v4JSMQCb0MKjcwZ5049iG/jDNE9y+5ONwjx6Dh6ChM0Qh+/sbN6VT8F/ADM9G33cncgIvzZadOeV9elf3KN7EgNJ95IEykHw0CsAAqlrzrBn/8EBV8k/fU/1rFzLrS+nkN4zxpi9zWBLsvOqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hb0oOPwa; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8296d553142so1378734b3a.3
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 08:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777647794; x=1778252594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwhPu/bxQrCX54xEbayaG+4GqRqCieagoOqy7sLCdrU=;
        b=Hb0oOPwag4PLUPhnk2uuZlpmGbwK+NBKPsDbvl+8lpb88L6DWFi18B0dXjC6nhPCwL
         wlDJPTEpDQ3L/sLiLp2nFGQQpK1UEp1LuZoKozkTL4p+r9lJi/5a7bGhnsWlgpn74I+5
         GOcjIN4jfOy3zan5tr03LJKL8J6rPAVTsb/DB3V7Ngs4tHSIPUDQRlK79j0dGYb+HUma
         pCYisuMSvHpaFnsczehiqgfqgy0dryKNRaB3Cb4ow4NYFUWD2VCscqQwLhmCRK6+68yX
         F2ugN6dTW0I1v+UOx9DBfJ9+BwS+fdVdcO74xA/hvXcZiEkKNlQWcEZOY5C9sBG5tmKU
         PGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777647794; x=1778252594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NwhPu/bxQrCX54xEbayaG+4GqRqCieagoOqy7sLCdrU=;
        b=Shtvz5Sq2koqVifQZ6ampkwdgDzWhnyMxZ8iyfydiaVqZaMuE2jvugocr8LKwLlQ1L
         4VbeYBtWaQ5UMmkNuGRM7rKQqwC0wEhYi/tFJru1XUiLtyQaKsWkpztYO1oGid9IKPve
         6/Xc+Lf5BDQIg3iJCfLtmpuYUe9pHs52NgSlZ38PNpkPYnzyNq36tqDVi3RDMGEHXfm8
         sQ9VTbGS6bFJozvWdPn3dhvButqlPdh/Ino9lMMpkCqtXZc87KPIPhFaA/vlKVf7AqJZ
         EK2vlDMAbhD3n5TE/UyAoQ9nn8SoGXf8zAowVL8ho2M+UOQ5bw6bn8c+RBMQKJJjTs7l
         QEJg==
X-Forwarded-Encrypted: i=1; AFNElJ9Qu1RF1JWXoWQ6YqKWAHtw26so1a41o9GtJrwx85OZEDWvcuo2UW2JSgbv/BK0n7TNYqCdpIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHTKflRq10mXFfgkYrTafoirt66fHSjFtIlzmHV/TpzaKd/k1D
	Q45TYG235qkSo5W6ydOycOy77h317jwcvfz+r1QvhmpxEFypbTs87ATN
X-Gm-Gg: AeBDievCVSeOdRQnT5H+sRJ/di6Iesv/wVau2RPP6SpKt6pSa3LZznbmRF7DMCvx5rB
	Pq1wdO5uArISgEFAaLd27AqzUK9vpPMGqrq3LnXX3RYu3TMv1phkaHXuqNMW6m9dpRqNyeEkiEL
	BIClvOooBZvM3eUnKucqVHef5lnffcO+gUXJGe2L4BOhmzTgLI4aocNjrBisWGgjE9ynecTWQ7+
	AOzQqS1wyWznrgiZFfHhGMG1M+7JRZTq4hj7efBNjnlxxJd+LKnyFhdwVFwt2W+H59JfLA+xkux
	itMr69guZXgQu71Jw10iO6G6dHI9L9T348tbVzaDTUTMx85VHTMGVSrEyj4975c0NSX0CNTk1Ub
	sg4iO2RM4QH1Uhqw7UWA8RpMHme0XqI0LwhrZeFoYrQBPQWBua6/6f5K4/xRxmUJDABo8WCD5SD
	JU9si82KPCKvwp4qTRiay74omYBof0oV6NaV2TlTiWI+WGMgFbeufd5LqnN+TRLZN1maWygq0Jd
	ShuGHEwQbplePU74mZYziWay5EG2sRTpsklXOo63qFZh8yCP3NC5jxollYN4ZRsmyNEXM7cPkl0
	jG2d0qFi+4edlpXiwNtWpAoOcAqT7Dk8E3ad9vILMbKVYhNm1b9KGby38X5X
X-Received: by 2002:a05:6a00:3cce:b0:82f:61bf:7eb8 with SMTP id d2e1a72fcca58-834fdb58b55mr7999450b3a.7.1777647794005;
        Fri, 01 May 2026 08:03:14 -0700 (PDT)
Received: from tobiichi3227-framework13-cachyos.misaka.net (36-236-241-206.dynamic-ip.hinet.net. [36.236.241.206])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b864c7sm3356061b3a.59.2026.05.01.08.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 08:03:13 -0700 (PDT)
From: Dao Zhong Ma <cz1346219@gmail.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	antonio@openvpn.net
Cc: sd@queasysnail.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Dao Zhong Ma <cz1346219@gmail.com>
Subject: [PATCH 1/1] ovpn: tcp - defer TX from softirq to workqueue
Date: Fri,  1 May 2026 22:54:25 +0800
Message-ID: <20260501145425.757147-2-cz1346219@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260501145425.757147-1-cz1346219@gmail.com>
References: <20260501145425.757147-1-cz1346219@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F315B4AD7C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[queasysnail.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283210-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cz1346219@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,openvpn.net:email]

ovpn_tcp_send_skb() holds sk->sk_lock.slock while performing the full TCP
send in softirq context. This can hold the spinlock for a long time
(large skb), blocking lock_sock() users. This can starve the RCU GP
kthread and trigger RCU stalls warnings and hung tasks.

Defer the TCP send operation to process context:
- In interrupt context, only enqueue the skb under the spinlock
  schedule tcp_tx_work.
- In process context, dequeue and flush the send queue under lock_sock()

This reduces the softirq critical section to a short duration, allowing
lock_sock() users to make progress and preventing RCU stalls.

Signed-off-by: Dao Zhong Ma <cz1346219@gmail.com>
---
 drivers/net/ovpn/tcp.c | 80 +++++++++++++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 65054cc84be5..d75ad0c22a30 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -6,6 +6,7 @@
  *  Author:	Antonio Quartulli <antonio@openvpn.net>
  */

+#include <linux/interrupt.h>
 #include <linux/skbuff.h>
 #include <net/hotdata.h>
 #include <net/inet_common.h>
@@ -312,6 +313,40 @@ static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
 	peer->tcp.tx_in_progress = false;
 }

+/* Caller must hold sk->sk_lock.slock. */
+static bool ovpn_tcp_queue_skb(struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	if (skb_queue_len(&peer->tcp.out_queue) >=
+	    READ_ONCE(net_hotdata.max_backlog)) {
+		dev_dstats_tx_dropped(peer->ovpn->dev);
+		kfree_skb(skb);
+		return false;
+	}
+
+	__skb_queue_tail(&peer->tcp.out_queue, skb);
+	return true;
+}
+
+/* Caller must hold sk->sk_lock.slock and own the socket. */
+static void ovpn_tcp_tx_flush(struct ovpn_peer *peer, struct sock *sk)
+{
+	struct sk_buff *skb;
+
+	if (peer->tcp.out_msg.skb)
+		ovpn_tcp_send_sock(peer, sk);
+
+	while (!peer->tcp.out_msg.skb) {
+		skb = __skb_dequeue(&peer->tcp.out_queue);
+		if (!skb)
+			break;
+
+		peer->tcp.out_msg.skb = skb;
+		peer->tcp.out_msg.len = skb->len;
+		peer->tcp.out_msg.offset = 0;
+		ovpn_tcp_send_sock(peer, sk);
+	}
+}
+
 void ovpn_tcp_tx_work(struct work_struct *work)
 {
 	struct ovpn_socket *sock;
@@ -320,7 +355,7 @@ void ovpn_tcp_tx_work(struct work_struct *work)

 	lock_sock(sock->sk);
 	if (sock->peer)
-		ovpn_tcp_send_sock(sock->peer, sock->sk);
+		ovpn_tcp_tx_flush(sock->peer, sock->sk);
 	release_sock(sock->sk);
 }

@@ -345,32 +380,38 @@ static void ovpn_tcp_send_sock_skb(struct ovpn_peer *peer, struct sock *sk,
 void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct sock *sk,
 		       struct sk_buff *skb)
 {
+	struct ovpn_socket *sock;
 	u16 len = skb->len;
+	bool queued;

 	*(__be16 *)__skb_push(skb, sizeof(u16)) = htons(len);

-	spin_lock_nested(&sk->sk_lock.slock, OVPN_TCP_DEPTH_NESTING);
-	if (sock_owned_by_user(sk)) {
-		if (skb_queue_len(&peer->tcp.out_queue) >=
-		    READ_ONCE(net_hotdata.max_backlog)) {
-			dev_dstats_tx_dropped(peer->ovpn->dev);
-			kfree_skb(skb);
-			goto unlock;
-		}
-		__skb_queue_tail(&peer->tcp.out_queue, skb);
-	} else {
-		ovpn_tcp_send_sock_skb(peer, sk, skb);
+	if (unlikely(in_interrupt())) {
+		spin_lock_nested(&sk->sk_lock.slock, OVPN_TCP_DEPTH_NESTING);
+		queued = ovpn_tcp_queue_skb(peer, skb);
+		spin_unlock(&sk->sk_lock.slock);
+		if (!queued)
+			return;
+
+		rcu_read_lock();
+		sock = rcu_dereference_sk_user_data(sk);
+		if (sock)
+			schedule_work(&sock->tcp_tx_work);
+		rcu_read_unlock();
+		return;
 	}
-unlock:
-	spin_unlock(&sk->sk_lock.slock);
+
+	lock_sock_nested(sk, OVPN_TCP_DEPTH_NESTING);
+	queued = ovpn_tcp_queue_skb(peer, skb);
+	if (queued)
+		ovpn_tcp_tx_flush(peer, sk);
+	release_sock(sk);
 }

 static void ovpn_tcp_release(struct sock *sk)
 {
-	struct sk_buff_head queue;
 	struct ovpn_socket *sock;
 	struct ovpn_peer *peer;
-	struct sk_buff *skb;

 	rcu_read_lock();
 	sock = rcu_dereference_sk_user_data(sk);
@@ -390,11 +431,7 @@ static void ovpn_tcp_release(struct sock *sk)
 	}
 	rcu_read_unlock();

-	__skb_queue_head_init(&queue);
-	skb_queue_splice_init(&peer->tcp.out_queue, &queue);
-
-	while ((skb = __skb_dequeue(&queue)))
-		ovpn_tcp_send_sock_skb(peer, sk, skb);
+	ovpn_tcp_tx_flush(peer, sk);

 	peer->tcp.sk_cb.prot->release_cb(sk);
 	ovpn_peer_put(peer);
@@ -653,3 +690,4 @@ void __init ovpn_tcp_init(void)
 			      &inet6_stream_ops);
 #endif
 }
+
--
2.54.0


