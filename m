Return-Path: <netdev+bounces-159464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A99EDA1591F
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 22:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A50A3A36A8
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 21:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E051AAA0D;
	Fri, 17 Jan 2025 21:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A/E6TdrQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843721AA1F1
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 21:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737150054; cv=none; b=aFDJfk/ATIA0OVO1qbrI9de6lsyCV4Hwh0Fne1MGC2lTtumoxOFC3RP3qbnRhvWtfTIu9NbdYubDIU2gbqbYydFW8MylxoWX9WRvN+pOG0ESG69cpfK+oWrmNhhXy4UyXIbgCrlzWuqpoA03fbbXSj4Y5CArrRrjfkSHu53O/g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737150054; c=relaxed/simple;
	bh=KbSuyfbIITYzUAGZqF5lo/NkFkYeBB68XIjm5QUptXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mmGzj+qIYFvepQq9Ndc+Cm2oXx6kQiXqz9/PIHud6RGLf3Yg6e4M46D8XtxRvgL7xe+xgypxgEVt3zzU9V2JuyEMyFbgkLralHMQFyLcOkEPBuhs9wA83hhuFG88m6/8AdGKeMqhcyYRW+UusdxQmbhoFH+bCo5LMA/f8nD2sCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A/E6TdrQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737150051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aq9MWQIX3mm2TtOspqMrqHd+ZJ2mtFutJbPOVlX++30=;
	b=A/E6TdrQuBxb+Y/7/70pagw58uLkHLWuv5kKMBZfCA7CYGVcA1J24/WoX95i6k/aQBAhSz
	mihQe2gwkLHpKso0w3zXL+K1ua+bJSjb08T94S6LF6Th7/BBAkh0Oa71O/UVgbQKChIR1j
	+paf548gcunWww7LJZlu/S6KjOYWsYk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-zPmk1L_IPOeG9PDa_y2COw-1; Fri,
 17 Jan 2025 16:40:47 -0500
X-MC-Unique: zPmk1L_IPOeG9PDa_y2COw-1
X-Mimecast-MFC-AGG-ID: zPmk1L_IPOeG9PDa_y2COw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29B841956056;
	Fri, 17 Jan 2025 21:40:46 +0000 (UTC)
Received: from jmaloy-thinkpadp16vgen1.rmtcaqc.csb (unknown [10.22.64.91])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2006C19560A3;
	Fri, 17 Jan 2025 21:40:42 +0000 (UTC)
From: jmaloy@redhat.com
To: netdev@vger.kernel.org,
	davem@davemloft.net
Cc: kuba@kernel.org,
	passt-dev@passt.top,
	jmaloy@redhat.com,
	sbrivio@redhat.com,
	lvivier@redhat.com,
	dgibson@redhat.com,
	imagedong@tencent.com,
	eric.dumazet@gmail.com,
	edumazet@google.com
Subject: [net,v2] tcp: correct handling of extreme memory squeeze
Date: Fri, 17 Jan 2025 16:40:35 -0500
Message-ID: <20250117214035.2414668-1-jmaloy@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Jon Maloy <jmaloy@redhat.com>

Testing with iperf3 using the "pasta" protocol splicer has revealed
a bug in the way tcp handles window advertising in extreme memory
squeeze situations.

Under memory pressure, a socket endpoint may temporarily advertise
a zero-sized window, but this is not stored as part of the socket data.
The reasoning behind this is that it is considered a temporary setting
which shouldn't influence any further calculations.

However, if we happen to stall at an unfortunate value of the current
window size, the algorithm selecting a new value will consistently fail
to advertise a non-zero window once we have freed up enough memory.
This means that this side's notion of the current window size is
different from the one last advertised to the peer, causing the latter
to not send any data to resolve the sitution.

The problem occurs on the iperf3 server side, and the socket in question
is a completely regular socket with the default settings for the
fedora40 kernel. We do not use SO_PEEK or SO_RCVBUF on the socket.

The following excerpt of a logging session, with own comments added,
shows more in detail what is happening:

//              tcp_v4_rcv(->)
//                tcp_rcv_established(->)
[5201<->39222]:     ==== Activating log @ net/ipv4/tcp_input.c/tcp_data_queue()/5257 ====
[5201<->39222]:     tcp_data_queue(->)
[5201<->39222]:        DROPPING skb [265600160..265665640], reason: SKB_DROP_REASON_PROTO_MEM
                       [rcv_nxt 265600160, rcv_wnd 262144, snt_ack 265469200, win_now 131184]
                       [copied_seq 259909392->260034360 (124968), unread 5565800, qlen 85, ofoq 0]
[5201<->39222]:     tcp_data_queue(<-) OFO queue: gap: 65480, len: 0
[5201<->39222]:     __tcp_transmit_skb(->)
[5201<->39222]:       tcp_select_window(->) tp->rcv_wup: 265469200, tp->rcv_wnd: 262144, tp->rcv_nxt 265600160
[5201<->39222]:         (inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOMEM) --> TRUE
[5201<->39222]:       tcp_select_window(<-) tp->rcv_wup: 265469200, tp->rcv_wnd: 262144, tp->rcv_nxt 265600160, returning 0
[5201<->39222]:       ADVERTISING WIN 0, ACK_SEQ: 265600160
[5201<->39222]:     __tcp_transmit_skb(<-) tp->rcv_wup: 265469200, tp->rcv_wnd: 262144, tp->rcv_nxt 265600160
[5201<->39222]:   tcp_rcv_established(<-)
[5201<->39222]: tcp_v4_rcv(<-)

// Receive queue is at 85 buffers and we are out of memory.
// We drop the incoming buffer, although it is in sequence, and decide
// to send an advertisement with a window of zero.
// We don't update tp->rcv_wnd and tp->rcv_wup accordingly, which means
// we unconditionally shrink the window.

[5201<->39222]: tcp_recvmsg_locked(->)
[5201<->39222]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 265469200, tp->rcv_wnd: 262144, tp->rcv_nxt 265600160
[5201<->39222]:     [new_win = 0, win_now = 131184, 2 * win_now = 262368]
[5201<->39222]:     [new_win >= (2 * win_now) ? --> time_to_ack = 0]
[5201<->39222]:     NOT calling tcp_send_ack()
[5201<->39222]:   __tcp_cleanup_rbuf(<-) tp->rcv_wup: 265469200, tp->rcv_wnd: 262144, tp->rcv_nxt 265600160
[5201<->39222]: tcp_recvmsg_locked(<-) returning 6104 bytes.
                [rcv_nxt 265600160, rcv_wnd 262144, snt_ack 265469200, win_now 131184]
                [copied_seq 260040464->260040464 (0), unread 5559696, qlen 85, ofoq 0]

// After each read, the algorithm for calculating the new receive
// window in __tcp_cleanup_rbuf() finds it is too small to advertise
// or to update tp->rcv_wnd.
// Meanwhile, the peer thinks the window is zero, and will not send
// any more data to trigger an update from the interrupt mode side.

[5201<->39222]: tcp_recvmsg_locked(->)
[5201<->39222]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 265469200, tp->rcv_wnd: 262144, tp->rcv_nxt 265600160
[5201<->39222]:     [new_win = 262144, win_now = 131184, 2 * win_now = 262368]
[5201<->39222]:     [new_win >= (2 * win_now) ? --> time_to_ack = 0]
[5201<->39222]:     NOT calling tcp_send_ack()
[5201<->39222]:   __tcp_cleanup_rbuf(<-) tp->rcv_wup: 265469200, tp->rcv_wnd: 262144, tp->rcv_nxt 265600160
[5201<->39222]: tcp_recvmsg_locked(<-) returning 131072 bytes.
                [rcv_nxt 265600160, rcv_wnd 262144, snt_ack 265469200, win_now 131184]
                [copied_seq 260099840->260171536 (71696), unread 5428624, qlen 83, ofoq 0]

// The above pattern repeats again and again, since nothing changes
// between the reads.

[...]

[5201<->39222]: tcp_recvmsg_locked(->)
[5201<->39222]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 265469200, tp->rcv_wnd: 262144, tp->rcv_nxt 265600160
[5201<->39222]:     [new_win = 262144, win_now = 131184, 2 * win_now = 262368]
[5201<->39222]:     [new_win >= (2 * win_now) ? --> time_to_ack = 0]
[5201<->39222]:     NOT calling tcp_send_ack()
[5201<->39222]:   __tcp_cleanup_rbuf(<-) tp->rcv_wup: 265469200, tp->rcv_wnd: 262144, tp->rcv_nxt 265600160
[5201<->39222]: tcp_recvmsg_locked(<-) returning 131072 bytes.
                [rcv_nxt 265600160, rcv_wnd 262144, snt_ack 265469200, win_now 131184]
                [copied_seq 265469200->265545488 (76288), unread 54672, qlen 1, ofoq 0]

[5201<->39222]: tcp_recvmsg_locked(->)
[5201<->39222]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 265469200, tp->rcv_wnd: 262144, tp->rcv_nxt 265600160
[5201<->39222]:     [new_win = 262144, win_now = 131184, 2 * win_now = 262368]
[5201<->39222]:     [new_win >= (2 * win_now) ? --> time_to_ack = 0]
[5201<->39222]:     NOT calling tcp_send_ack()
[5201<->39222]:   __tcp_cleanup_rbuf(<-) tp->rcv_wup: 265469200, tp->rcv_wnd: 262144, tp->rcv_nxt 265600160
[5201<->39222]: tcp_recvmsg_locked(<-) returning 54672 bytes.
                [rcv_nxt 265600160, rcv_wnd 262144, snt_ack 265469200, win_now 131184]
                [copied_seq 265600160->265600160 (0), unread 0, qlen 0, ofoq 0]

// The receive queue is empty, but no new advertisement has been sent.
// The peer still thinks the receive window is zero, and sends nothing.
// We have ended up in a deadlock situation.

Furthermore, we have observed that in these situations this side may
send out an updated 'th->ack_seq´ which is not stored in tp->rcv_wup
as it should be. Backing ack_seq seems to be harmless, but is of
course still wrong from a protocol viewpoint.

We fix this by setting tp->rcv_wnd and tp->rcv_wup even when a packet
has been dropped because of memory exhaustion and we have to advertize
a zero window.

Further testing shows that the connection recovers neatly from the
squeeze situation, and traffic can continue indefinitely.

Fixes: e2142825c120 ("net: tcp: send zero-window ACK when no memory")
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Jon Maloy <jmaloy@redhat.com>
---
v1: -Posted on Apr 6, 2024
v2: -Improved commit log to clarify how we end up in this situation.
    -After feedback from Eric Dumazet, removed references to use of
     SO_PEEK and SO_PEEK_OFF which may lead to a misunderstanding
     about how this situation occurs. Those flags are used at the
     peer side's incoming connection, and not on this one.
---
 net/ipv4/tcp_output.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 0e5b9a654254..ba295f798e5e 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -265,11 +265,13 @@ static u16 tcp_select_window(struct sock *sk)
 	u32 cur_win, new_win;
 
 	/* Make the window 0 if we failed to queue the data because we
-	 * are out of memory. The window is temporary, so we don't store
-	 * it on the socket.
+	 * are out of memory.
 	 */
-	if (unlikely(inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOMEM))
+	if (unlikely(inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOMEM)) {
+		tp->rcv_wnd = 0;
+		tp->rcv_wup = tp->rcv_nxt;
 		return 0;
+	}
 
 	cur_win = tcp_receive_window(tp);
 	new_win = __tcp_select_window(sk);
-- 
2.48.0


