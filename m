Return-Path: <netdev+bounces-85451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB0689AC9E
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 20:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8091F21EF2
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 18:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8184C4AECA;
	Sat,  6 Apr 2024 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FWktOe4Q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25E21F16B
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 18:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712427679; cv=none; b=Ep1l92lXkmSxotyoL+KXgHcOEdce3ap5cGNsl9H2gx3TwEae9AjRlOQk93QZnL/JaMDh144GIGrsBRMONCQhf64QDYdFaIwVjGZb1nOXPLaZEpWYW75b4ZQfgXn3bPiW0rp9tUE4Lkxz2YQSKtU8taTrfYwMfpYgcY8NVYU/F6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712427679; c=relaxed/simple;
	bh=Tj1df7ODe9MrShhZrS5uDSSP/uzCgBG00pvVjJsoWuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hweJMU9uz20lqfRKNQMtAM50CksbJ3GcQl2opK5kEIVz6KFnn13zikSU5ywMgUv2GN2EpZSAp8IWQjIIVe9/2QseuXzxJiIxpwzhlLbvBWvWfJfeVUgAMJw31OIzxc2Nhq9/5s7iT0x7ywX3hfxOyihsvyVS7XojTNBqE76CZGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FWktOe4Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712427676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3/qCyXSoNEPtMxzmc8wVbCNb/0PEh8moP5D6mdXU9kM=;
	b=FWktOe4QWLPzQvkDBVxLqC9W0EiAo9Nub1uhmxuD9Cntmx2eh71bMNVttzkOwuRwCksXsn
	u2lKqsLkMLr+uNqD9MDlrcYm0p6HHdnOSfHny1yaTZG0oLwmD084N6XJptS95vfXkynsfF
	VSbcCLzRPBbXC5MspX9eiO6BLQmLJRA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-idSRqqpbMA2YMmNGsksspg-1; Sat,
 06 Apr 2024 14:21:11 -0400
X-MC-Unique: idSRqqpbMA2YMmNGsksspg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 086BA2800197;
	Sat,  6 Apr 2024 18:21:11 +0000 (UTC)
Received: from fenrir.redhat.com (unknown [10.22.8.7])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A0EC6430F61;
	Sat,  6 Apr 2024 18:21:09 +0000 (UTC)
From: jmaloy@redhat.com
To: netdev@vger.kernel.org,
	davem@davemloft.net
Cc: kuba@kernel.org,
	passt-dev@passt.top,
	jmaloy@redhat.com,
	sbrivio@redhat.com,
	lvivier@redhat.com,
	dgibson@redhat.com,
	eric.dumazet@gmail.com,
	edumazet@google.com
Subject: [net-next 2/2] tcp: correct handling of extreme menory squeeze
Date: Sat,  6 Apr 2024 14:21:07 -0400
Message-ID: <20240406182107.261472-3-jmaloy@redhat.com>
In-Reply-To: <20240406182107.261472-1-jmaloy@redhat.com>
References: <20240406182107.261472-1-jmaloy@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

From: Jon Maloy <jmaloy@redhat.com>

Testing of the previous commit ("tcp: add support for SO_PEEK_OFF")
in this series along with the pasta protocol splicer revealed a bug in
the way tcp handles window advertising during extreme memory squeeze
situations.

The excerpt of the below logging session shows what is happeing:

[5201<->54494]:     ==== Activating log @ tcp_select_window()/268 ====
[5201<->54494]:     (inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOMEM) --> TRUE
[5201<->54494]:   tcp_select_window(<-) tp->rcv_wup: 2812454294, tp->rcv_wnd: 5812224, tp->rcv_nxt 2818016354, returning 0
[5201<->54494]:   ADVERTISING WINDOW SIZE 0
[5201<->54494]: __tcp_transmit_skb(<-) tp->rcv_wup: 2812454294, tp->rcv_wnd: 5812224, tp->rcv_nxt 2818016354

[5201<->54494]: tcp_recvmsg_locked(->)
[5201<->54494]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 2812454294, tp->rcv_wnd: 5812224, tp->rcv_nxt 2818016354
[5201<->54494]:     (win_now: 250164, new_win: 262144 >= (2 * win_now): 500328))? --> time_to_ack: 0
[5201<->54494]:     NOT calling tcp_send_ack()
[5201<->54494]:   __tcp_cleanup_rbuf(<-) tp->rcv_wup: 2812454294, tp->rcv_wnd: 5812224, tp->rcv_nxt 2818016354
[5201<->54494]: tcp_recvmsg_locked(<-) returning 131072 bytes, window now: 250164, qlen: 83

[...]

[5201<->54494]: tcp_recvmsg_locked(->)
[5201<->54494]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 2812454294, tp->rcv_wnd: 5812224, tp->rcv_nxt 2818016354
[5201<->54494]:     (win_now: 250164, new_win: 262144 >= (2 * win_now): 500328))? --> time_to_ack: 0
[5201<->54494]:     NOT calling tcp_send_ack()
[5201<->54494]:   __tcp_cleanup_rbuf(<-) tp->rcv_wup: 2812454294, tp->rcv_wnd: 5812224, tp->rcv_nxt 2818016354
[5201<->54494]: tcp_recvmsg_locked(<-) returning 131072 bytes, window now: 250164, qlen: 1

[5201<->54494]: tcp_recvmsg_locked(->)
[5201<->54494]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 2812454294, tp->rcv_wnd: 5812224, tp->rcv_nxt 2818016354
[5201<->54494]:     (win_now: 250164, new_win: 262144 >= (2 * win_now): 500328))? --> time_to_ack: 0
[5201<->54494]:     NOT calling tcp_send_ack()
[5201<->54494]:   __tcp_cleanup_rbuf(<-) tp->rcv_wup: 2812454294, tp->rcv_wnd: 5812224, tp->rcv_nxt 2818016354
[5201<->54494]: tcp_recvmsg_locked(<-) returning 57036 bytes, window now: 250164, qlen: 0

[5201<->54494]: tcp_recvmsg_locked(->)
[5201<->54494]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 2812454294, tp->rcv_wnd: 5812224, tp->rcv_nxt 2818016354
[5201<->54494]:     NOT calling tcp_send_ack()
[5201<->54494]:   __tcp_cleanup_rbuf(<-) tp->rcv_wup: 2812454294, tp->rcv_wnd: 5812224, tp->rcv_nxt 2818016354
[5201<->54494]: tcp_recvmsg_locked(<-) returning -11 bytes, window now: 250164, qlen: 0

We can see that although we are adverising a window size of zero,
tp->rcv_wnd is not updated accordingly. This leads to a discrepancy
between this side's and the peer's view of the current window size.
- The peer thinks the window is zero, and stops sending.
- This side ends up in a cycle where it repeatedly caclulates a new
  window size it finds too small to advertise.

Hence no messages are received, and no acknowledges are sent, and
the situation remains locked even after the last queued receive buffer
has been consumed.

We fix this by setting tp->rcv_wnd to 0 before we return from the
function tcp_select_window() in this particular case.
Further testing shows that the connection recovers neatly from the
squeeze situation, and traffic can continue indefinitely.

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Jon Maloy <jmaloy@redhat.com>
---
 net/ipv4/tcp_output.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 9282fafc0e61..57ead8f3c334 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -263,11 +263,15 @@ static u16 tcp_select_window(struct sock *sk)
 	u32 cur_win, new_win;
 
 	/* Make the window 0 if we failed to queue the data because we
-	 * are out of memory. The window is temporary, so we don't store
-	 * it on the socket.
+	 * are out of memory. The window needs to be stored in the socket
+	 * for the connection to recover.
 	 */
-	if (unlikely(inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOMEM))
-		return 0;
+	if (unlikely(inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOMEM)) {
+		new_win = 0;
+		tp->rcv_wnd = 0;
+		tp->rcv_wup = tp->rcv_nxt;
+		goto out;
+	}
 
 	cur_win = tcp_receive_window(tp);
 	new_win = __tcp_select_window(sk);
@@ -301,7 +305,7 @@ static u16 tcp_select_window(struct sock *sk)
 
 	/* RFC1323 scaling applied */
 	new_win >>= tp->rx_opt.rcv_wscale;
-
+out:
 	/* If we advertise zero window, disable fast path. */
 	if (new_win == 0) {
 		tp->pred_flags = 0;
-- 
2.42.0


