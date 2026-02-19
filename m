Return-Path: <netdev+bounces-259613-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPw/DCCjl2mh3wIAu9opvQ
	(envelope-from <netdev+bounces-259613-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 00:56:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA73163B68
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 00:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 019BD300E24B
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 23:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF3E32B9AC;
	Thu, 19 Feb 2026 23:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5NeB+ht"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D135B2F6927;
	Thu, 19 Feb 2026 23:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771545364; cv=none; b=S68EWEBlqvsSRzivVcBk0WX8MLv3PUO55DfypmvJR0mcbgYiclmLsJBpqivGdjPMjrk8JIM1uqUWUEo/32kJno2lZsmGcsbd62YiX0sv7pum3vyiT4yN53L10HA9C7sQsvF6CmCBkzOFZw1bgKAI8P3odfcKT/8yuS+3EJUFdbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771545364; c=relaxed/simple;
	bh=9OLW6SJ23eCW9lR/MOuXIWE81Fjz3wPQNt316IsaoNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D273nV8mLaZ5nsmRTQCEMwe9fw9GCrqt+IG4yQyRF33wDm061ZGUpT46UVXyu1ev5mGivuot8GnfF5Kggi+ur5BnL9YWRYbnBpBUDDKi5BzD0JfCQGwwWzj9MNS9tonPF02da+sMf6DE2+SZgRoghWOCSAZ63bY+rqy0W8VCaqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5NeB+ht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73E50C19423;
	Thu, 19 Feb 2026 23:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771545364;
	bh=9OLW6SJ23eCW9lR/MOuXIWE81Fjz3wPQNt316IsaoNM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=N5NeB+ht0nTeJlGbloaXEVCsX3V49ASY2W7K1XHaz92wNm3hQ/UWJ+guR3QcXhb3s
	 lDzbdxQ6TT34gPCbwN+eDNNvdw+4Bf2X7YEdMFPizs2GizGbWgMI3Jn8RWX484Z3B3
	 FlvH6ocfQvP/DGlxmW0zRp9yzpteVO2SKzSQz0Anm+KW/oCN4E0kLuO8uIt8YzC7Nf
	 aA2xIUK3ryWEeRGKTyTpGySgbhBQyIjUklBCGiqxhQFLX8mx9MzCP0jIu5yoCCdLxE
	 JNPiZSWfIWam29eaZL+BeilUeA1g6dqes7j1185Goabqca6AkA2tBisd6kwyzEE2Uj
	 RTzoY77XEWH7w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632E1C531F2;
	Thu, 19 Feb 2026 23:56:04 +0000 (UTC)
From: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>
Date: Fri, 20 Feb 2026 00:55:14 +0100
Subject: [PATCH RFC net-next 1/4] tcp: implement RFC 7323 window retraction
 receiver requirements
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-tcp_rfc7323_retract_wnd_rfc-v1-1-904942561479@gmail.com>
References: <20260220-tcp_rfc7323_retract_wnd_rfc-v1-0-904942561479@gmail.com>
In-Reply-To: <20260220-tcp_rfc7323_retract_wnd_rfc-v1-0-904942561479@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 David Ahern <dsahern@kernel.org>, Stefano Brivio <sbrivio@redhat.com>, 
 Jon Maloy <jmaloy@redhat.com>, Jason Xing <kerneljasonxing@gmail.com>, 
 mfreemon@cloudflare.com, Shuah Khan <shuah@kernel.org>
Cc: Christian Ebner <c.ebner@proxmox.com>, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Simon Baatz <gmbnomis@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771545363; l=10816;
 i=gmbnomis@gmail.com; s=20260220; h=from:subject:message-id;
 bh=EC/LH0/2ndtpXeRX4eu3ZcuY2T1dUcSNTwkSaqDjvwQ=;
 b=Ctda9E2y2D1I7SNA4sDKiOUbPglQAhcnwj8fPJ3a3Hbgzv2FDtsZKPyOvof5WPPWVK68KjkRY
 Zb1k8xVEq93Bo4E8jUjoFaHwN9TV1yMISOZ+pP0vGZYQxx+6wh2/61z
X-Developer-Key: i=gmbnomis@gmail.com; a=ed25519;
 pk=T/JIz/6F5bf1uQJr69lmyi7czVG+F9TVZ/8x5z9Wtqw=
X-Endpoint-Received: by B4 Relay for gmbnomis@gmail.com/20260220 with
 auth_id=641
X-Original-From: Simon Baatz <gmbnomis@gmail.com>
Reply-To: gmbnomis@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[google.com,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,cloudflare.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-259613-lists,netdev=lfdr.de,gmbnomis.gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[proxmox.com,vger.kernel.org,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[gmbnomis@gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9BA73163B68
X-Rspamd-Action: no action

From: Simon Baatz <gmbnomis@gmail.com>

By default, the Linux TCP implementation does not shrink the
advertised window (RFC 7323 calls this "window retraction") with the
following exceptions:

- When an incoming segment cannot be added due to the receive buffer
  running out of memory. Since commit 8c670bdfa58e ("tcp: correct
  handling of extreme memory squeeze") a zero window will be
  advertised in this case. It turns out that reaching the required
  "memory pressure" is very easy when window scaling is in use. In the
  simplest case, sending a sufficient number of segments smaller than
  the scale factor to a receiver that does not read data is enough.

  Since commit 1d2fbaad7cd8 ("tcp: stronger sk_rcvbuf checks") this
  happens much earlier than before, leading to regressions (the test
  suite of the Valkey project does not pass because of a TCP
  connection that is no longer bi-directional).

- Commit b650d953cd39 ("tcp: enforce receive buffer memory limits by
  allowing the tcp window to shrink") addressed the "eating memory"
  problem by introducing a sysctl knob that allows shrinking the
  window before running out of memory.

However, RFC 7323 does not only state that shrinking the window is
necessary in some cases, it also formulates requirements for TCP
implementations when doing so (Section 2.4).

This commit addresses the receiver-side requirements: After retracting
the window, the peer may have a snd_nxt that lies within a previously
advertised window but is now beyond the retracted window. This means
that all incoming segments (including pure ACKs) will be rejected
until the application happens to read enough data to let the peer's
snd_nxt be in window again (which may be never).

To comply with RFC 7323, the receiver MUST honor any segment that
would have been in window for any ACK sent by the receiver and, when
window scaling is in effect, SHOULD track the maximum window sequence
number it has advertised. This patch tracks that maximum window
sequence number throughout the connection and uses it in
tcp_sequence() when deciding whether a segment is acceptable.
Acceptability of data is not changed.

Fixes: 8c670bdfa58e ("tcp: correct handling of extreme memory squeeze")
Fixes: b650d953cd39 ("tcp: enforce receive buffer memory limits by allowing the tcp window to shrink")
Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 Documentation/networking/net_cachelines/tcp_sock.rst       |  1 +
 include/linux/tcp.h                                        |  1 +
 include/net/tcp.h                                          | 14 ++++++++++++++
 net/ipv4/tcp_fastopen.c                                    |  1 +
 net/ipv4/tcp_input.c                                       |  6 ++++--
 net/ipv4/tcp_minisocks.c                                   |  1 +
 net/ipv4/tcp_output.c                                      | 12 ++++++++++++
 .../selftests/net/packetdrill/tcp_rcv_big_endseq.pkt       |  2 +-
 8 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 563daea10d6c5c074f004cb1b8574f5392157abb..fecf61166a54ee2f64bcef5312c81dcc4aa9a124 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -121,6 +121,7 @@ u64                           delivered_mstamp        read_write
 u32                           rate_delivered                              read_mostly         tcp_rate_gen
 u32                           rate_interval_us                            read_mostly         rate_delivered,rate_app_limited
 u32                           rcv_wnd                 read_write          read_mostly         tcp_select_window,tcp_receive_window,tcp_fast_path_check
+u32                           rcv_mwnd_seq            read_write                              tcp_select_window
 u32                           write_seq               read_write                              tcp_rate_check_app_limited,tcp_write_queue_empty,tcp_skb_entail,forced_push,tcp_mark_push
 u32                           notsent_lowat           read_mostly                             tcp_stream_memory_free
 u32                           pushed_seq              read_write                              tcp_mark_push,forced_push
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index f72eef31fa23cc584f2f0cefacdc35cae43aa52d..5a943b12d4c050a980b4cf81635b9fa2f0036283 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -271,6 +271,7 @@ struct tcp_sock {
 	u32	lsndtime;	/* timestamp of last sent data packet (for restart window) */
 	u32	mdev_us;	/* medium deviation			*/
 	u32	rtt_seq;	/* sequence number to update rttvar	*/
+	u32	rcv_mwnd_seq; /* Maximum window sequence number (RFC 7323, section 2.4) */
 	u64	tcp_wstamp_ns;	/* departure time for next sent data packet */
 	u64	accecn_opt_tstamp;	/* Last AccECN option sent timestamp */
 	struct list_head tsorted_sent_queue; /* time-sorted sent but un-SACKed skbs */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 40e72b9cb85f08714d3f458c0bd1402a5fb1eb4e..e1944d504823d5f8754d85bfbbf3c9630d2190ac 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -912,6 +912,20 @@ static inline u32 tcp_receive_window(const struct tcp_sock *tp)
 	return (u32) win;
 }
 
+/* Compute the maximum receive window we ever advertised.
+ * Rcv_nxt can be after the window if our peer push more data
+ * than the offered window.
+ */
+static inline u32 tcp_max_receive_window(const struct tcp_sock *tp)
+{
+	s32 win = tp->rcv_mwnd_seq - tp->rcv_nxt;
+
+	if (win < 0)
+		win = 0;
+	return (u32) win;
+}
+
+
 /* Choose a new window, without checks for shrinking, and without
  * scaling applied to the result.  The caller does these things
  * if necessary.  This is a "raw" window selection.
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index b30090cff3cf7d925dc46694860abd3ca5516d70..f034ef6e3e7b54bf73c77fd2bf1d3090c75dbfc6 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -377,6 +377,7 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
 
 	tcp_rsk(req)->rcv_nxt = tp->rcv_nxt;
 	tp->rcv_wup = tp->rcv_nxt;
+	tp->rcv_mwnd_seq = tp->rcv_wup + tp->rcv_wnd;
 	/* tcp_conn_request() is sending the SYNACK,
 	 * and queues the child into listener accept queue.
 	 */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e7b41abb82aad33d8cab4fcfa989cc4771149b41..af9dd51256b01fd31d9e390d69dcb1d1700daf1b 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4865,8 +4865,8 @@ static enum skb_drop_reason tcp_sequence(const struct sock *sk,
 	if (before(end_seq, tp->rcv_wup))
 		return SKB_DROP_REASON_TCP_OLD_SEQUENCE;
 
-	if (after(end_seq, tp->rcv_nxt + tcp_receive_window(tp))) {
-		if (after(seq, tp->rcv_nxt + tcp_receive_window(tp)))
+	if (after(end_seq, tp->rcv_nxt + tcp_max_receive_window(tp))) {
+		if (after(seq, tp->rcv_nxt + tcp_max_receive_window(tp)))
 			return SKB_DROP_REASON_TCP_INVALID_SEQUENCE;
 
 		/* Only accept this packet if receive queue is empty. */
@@ -6959,6 +6959,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		 */
 		WRITE_ONCE(tp->rcv_nxt, TCP_SKB_CB(skb)->seq + 1);
 		tp->rcv_wup = TCP_SKB_CB(skb)->seq + 1;
+		tp->rcv_mwnd_seq = tp->rcv_wup + tp->rcv_wnd;
 
 		/* RFC1323: The window in SYN & SYN/ACK segments is
 		 * never scaled.
@@ -7071,6 +7072,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		WRITE_ONCE(tp->rcv_nxt, TCP_SKB_CB(skb)->seq + 1);
 		WRITE_ONCE(tp->copied_seq, tp->rcv_nxt);
 		tp->rcv_wup = TCP_SKB_CB(skb)->seq + 1;
+		tp->rcv_mwnd_seq = tp->rcv_wup + tp->rcv_wnd;
 
 		/* RFC1323: The window in SYN & SYN/ACK segments is
 		 * never scaled.
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index ec128865f5c029c971eb00cb9ee058b742efafd1..df95d8b6dce5c746e5e34545aa75a96080cc752d 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -604,6 +604,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	newtp->window_clamp = req->rsk_window_clamp;
 	newtp->rcv_ssthresh = req->rsk_rcv_wnd;
 	newtp->rcv_wnd = req->rsk_rcv_wnd;
+	newtp->rcv_mwnd_seq = newtp->rcv_wup + req->rsk_rcv_wnd;
 	newtp->rx_opt.wscale_ok = ireq->wscale_ok;
 	if (newtp->rx_opt.wscale_ok) {
 		newtp->rx_opt.snd_wscale = ireq->snd_wscale;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 326b58ff1118d02fc396753d56f210f9d3007c7f..50774443f6ae0ca83f360c7fc3239184a1523e1b 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -274,6 +274,15 @@ void tcp_select_initial_window(const struct sock *sk, int __space, __u32 mss,
 }
 EXPORT_IPV6_MOD(tcp_select_initial_window);
 
+/* Check if we need to update the maximum window sequence number */
+static inline void tcp_update_max_wnd_seq(struct tcp_sock *tp)
+{
+	u32 wre = tp->rcv_wup + tp->rcv_wnd;
+
+	if (after(wre, tp->rcv_mwnd_seq))
+		tp->rcv_mwnd_seq = wre;
+}
+
 /* Chose a new window to advertise, update state in tcp_sock for the
  * socket, and return result with RFC1323 scaling applied.  The return
  * value can be stuffed directly into th->window for an outgoing
@@ -293,6 +302,7 @@ static u16 tcp_select_window(struct sock *sk)
 		tp->pred_flags = 0;
 		tp->rcv_wnd = 0;
 		tp->rcv_wup = tp->rcv_nxt;
+		tcp_update_max_wnd_seq(tp);
 		return 0;
 	}
 
@@ -316,6 +326,7 @@ static u16 tcp_select_window(struct sock *sk)
 
 	tp->rcv_wnd = new_win;
 	tp->rcv_wup = tp->rcv_nxt;
+	tcp_update_max_wnd_seq(tp);
 
 	/* Make sure we do not exceed the maximum possible
 	 * scaled window.
@@ -4169,6 +4180,7 @@ static void tcp_connect_init(struct sock *sk)
 	else
 		tp->rcv_tstamp = tcp_jiffies32;
 	tp->rcv_wup = tp->rcv_nxt;
+	tp->rcv_mwnd_seq = tp->rcv_nxt + tp->rcv_wnd;
 	WRITE_ONCE(tp->copied_seq, tp->rcv_nxt);
 
 	inet_csk(sk)->icsk_rto = tcp_timeout_init(sk);
diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt
index 3848b419e68c3fc895ad736d06373fc32f3691c1..1a86ee5093696deb316c532ca8f7de2bbf5cd8ea 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt
@@ -36,7 +36,7 @@
 
   +0 read(4, ..., 100000) = 4000
 
-// If queue is empty, accept a packet even if its end_seq is above wup + rcv_wnd
+// If queue is empty, accept a packet even if its end_seq is above rcv_mwnd_seq
   +0 < P. 4001:54001(50000) ack 1 win 257
   +0 > .  1:1(0) ack 54001 win 0
 

-- 
2.52.0



