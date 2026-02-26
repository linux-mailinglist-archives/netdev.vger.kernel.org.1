Return-Path: <netdev+bounces-261103-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGMqOJqYn2k9cwQAu9opvQ
	(envelope-from <netdev+bounces-261103-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 01:49:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 890AA19F935
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 01:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 01AFA302A3AE
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 00:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FF136EAA9;
	Thu, 26 Feb 2026 00:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpAQGlLn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651D21F12E9;
	Thu, 26 Feb 2026 00:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772066966; cv=none; b=ASevISZrBQs0EA6NFsQ6NOQzvVbNzsLHuDZoxRRSFDHlkRg35oPi7KFLQUHpr9xH67h5Bs6YuW6ocgTMdVJAqocK/5EREuyDNM5xJEHJTfOW0B7VyGNOfcRcPAsV/QG/354hXwgNvhM2KkkeQyhp4H/nbvmn1UC4PVieZAEirp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772066966; c=relaxed/simple;
	bh=8m7uRlrXEDmuadjPLt3NSBGHH5dQ+esdpAE2KuvNT5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ABharKfuC6wHbIMXugBen819hb3Kf36NQkEe/zQ+3+IYLbA6TnJIbnXr+xZANCHQaTIpItjtXTw9Um61Nntu81FeoC/NbxNNyWmICy90Wi8Dfe1/6DGf6YPt5AeTec+mItz2olzb8oGZyte6YYX45YVP21EfbuxevHNQMsa2CIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpAQGlLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36B3CC19425;
	Thu, 26 Feb 2026 00:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772066966;
	bh=8m7uRlrXEDmuadjPLt3NSBGHH5dQ+esdpAE2KuvNT5g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XpAQGlLnhnPBzfxqBh2mvB0S7oo/2zS6rfrOgt6BRhdDwmHKNSp+CsLekV8evhLeY
	 u2qNcO5eQaAuptCG00Spz/bvGDPuFaoSqZfa5FivQw9u644YPzOFq3UXB9PNz2jpfs
	 X7Knr+R40GxNEMjb2D7GJjVGluhd2x/ovsrntPyevEoD8kaeEwfW2rRGAxGGRtOCus
	 KtTKq5JsqrnWcuLHA1oHbCAx6/qcQd1dOZUeNb/MI8exR27tKodekmp7fg3xqjQxsd
	 kc8whopNypOTQyBBJXKz8G1fK+HQbX3CVaxLvtXXoWEdfiaTFyf6qWZFNQNNOi0iYg
	 0EwgbPE80Yf/A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ECAFD45FE;
	Thu, 26 Feb 2026 00:49:26 +0000 (UTC)
From: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>
Date: Thu, 26 Feb 2026 01:49:07 +0100
Subject: [PATCH RFC net-next v2 1/5] tcp: implement RFC 7323 window
 retraction receiver requirements
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-tcp_rfc7323_retract_wnd_rfc-v2-1-aa3f8f9cc639@gmail.com>
References: <20260226-tcp_rfc7323_retract_wnd_rfc-v2-0-aa3f8f9cc639@gmail.com>
In-Reply-To: <20260226-tcp_rfc7323_retract_wnd_rfc-v2-0-aa3f8f9cc639@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 David Ahern <dsahern@kernel.org>, Stefano Brivio <sbrivio@redhat.com>, 
 Jon Maloy <jmaloy@redhat.com>, Jason Xing <kerneljasonxing@gmail.com>, 
 mfreemon@cloudflare.com, Shuah Khan <shuah@kernel.org>, 
 Stefano Brivio <sbrivio@redhat.com>
Cc: Christian Ebner <c.ebner@proxmox.com>, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Simon Baatz <gmbnomis@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772066964; l=11321;
 i=gmbnomis@gmail.com; s=20260220; h=from:subject:message-id;
 bh=4XZ8Pr+xaKfMht4eFNKhU8kxZLbyq5G7MUR6m7XvNg4=;
 b=NyPbIZ75EReTVliP2OPZxVV0KJFBCAjJzy5bGfb/5l+mx+EkLTxJft/KkDRV4GpO4ubhQp6VC
 Ns8L/q1QeeFDhk1GiTImHF9l6m1MgpO0HUyR/KyPsquV78n90Uf6I0U
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[google.com,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,cloudflare.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-261103-lists,netdev=lfdr.de,gmbnomis.gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	HAS_REPLYTO(0.00)[gmbnomis@gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 890AA19F935
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

The logic for handling received data in tcp_data_queue() is already
sufficient and does not need to be updated.

Fixes: 8c670bdfa58e ("tcp: correct handling of extreme memory squeeze")
Fixes: b650d953cd39 ("tcp: enforce receive buffer memory limits by allowing the tcp window to shrink")
Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 Documentation/networking/net_cachelines/tcp_sock.rst        |  1 +
 include/linux/tcp.h                                         |  3 +++
 include/net/tcp.h                                           | 13 +++++++++++++
 net/ipv4/tcp.c                                              |  1 +
 net/ipv4/tcp_fastopen.c                                     |  1 +
 net/ipv4/tcp_input.c                                        |  6 ++++--
 net/ipv4/tcp_minisocks.c                                    |  1 +
 net/ipv4/tcp_output.c                                       | 12 ++++++++++++
 .../selftests/net/packetdrill/tcp_rcv_big_endseq.pkt        |  2 +-
 9 files changed, 37 insertions(+), 3 deletions(-)

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
index f72eef31fa23cc584f2f0cefacdc35cae43aa52d..73aa2e0ccd1d7a6314a00c27950b019b62a3851c 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -316,6 +316,9 @@ struct tcp_sock {
 					*/
 	u32	app_limited;	/* limited until "delivered" reaches this val */
 	u32	rcv_wnd;	/* Current receiver window		*/
+	u32	rcv_mwnd_seq;	/* Maximum window sequence number (RFC 7323,
+				 * section 2.4, receiver requirements)
+				 */
 	u32	rcv_tstamp;	/* timestamp of last received ACK (for keepalives) */
 /*
  *      Options received (usually on last packet, some only on SYN packets).
diff --git a/include/net/tcp.h b/include/net/tcp.h
index eb8bf63fdafc3243469f293fd06aef0ce086c5a4..658552133d12edd9cef2aa97460a3e5bf129d74e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -914,6 +914,19 @@ static inline u32 tcp_receive_window(const struct tcp_sock *tp)
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
 /* Choose a new window, without checks for shrinking, and without
  * scaling applied to the result.  The caller does these things
  * if necessary.  This is a "raw" window selection.
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 6ce03a9adb4a97f554bd6b6cf887f4ad9dbfe5c3..6fcde6494a4f400731556be119ae21cbfd86bb27 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3578,6 +3578,7 @@ static int tcp_repair_set_window(struct tcp_sock *tp, sockptr_t optbuf, int len)
 
 	tp->rcv_wnd	= opt.rcv_wnd;
 	tp->rcv_wup	= opt.rcv_wup;
+	tp->rcv_mwnd_seq = opt.rcv_wup + opt.rcv_wnd;
 
 	return 0;
 }
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index df803f088f454cf157e0efbba8e2ff3f6d205530..4566e2289ad3d85171a9994032ba7f7366545286 100644
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
index d9c5a43bd2818c17d79d8433ac5dd2bdd199b812..35e115b7a9db3da906c0fc3ef7d318d9d946f52a 100644
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
2.53.0



