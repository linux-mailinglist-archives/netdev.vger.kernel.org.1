Return-Path: <netdev+bounces-276719-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHA1JL3N1mnAIggAu9opvQ
	(envelope-from <netdev+bounces-276719-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 23:50:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABD43C431F
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 23:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A4E3303DD03
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 21:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971D539DBDF;
	Wed,  8 Apr 2026 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFJf1IlG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ABA37D116;
	Wed,  8 Apr 2026 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775685042; cv=none; b=TxSwLPXQn21dLy8LEBZB+h0jJXOkrAF8bYR87gaJIWtUOCzdK9Vgs61NfxWviQRWDDsBZj4BKa7Izw2mGbFKsKXT3nT7S0JPIbUQzfzloq1XHJjNz78xpzzmHSX5CKCZ6TNyS1Veecyh5cFbvoqLTOhhxWiID0TJUFCntPw4yWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775685042; c=relaxed/simple;
	bh=4pWzV1h3heWEGQcfHFsxq1YGy4rq8ktVBtFrlR54Y1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AtRVf6jd9E+dbS5+RYt6qpJAtjZVN38oURGDPcaVSFjyq4x63bVzZsrDEUHnnvbw6ZtFpu7nwkmRxNQNDw08r3GapRvkD4RIXJP13hvFxcf6U6v3MT+oPAmO8Da3WvnkA5mbVRUjaLr1PzGeZuPg/absR9xvpuASJKxqGC47zRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFJf1IlG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DB7AC2BCB0;
	Wed,  8 Apr 2026 21:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775685042;
	bh=4pWzV1h3heWEGQcfHFsxq1YGy4rq8ktVBtFrlR54Y1E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NFJf1IlGdUoDKrvasjXaOY7dMRnm2t1Z8Q3CHvqcPY0fnRD03ZNUNR3Bi3vsf4Ed+
	 Edt8IwMeF7vw1r2UgkjCfv9FnslKB8sZTTg/JkVgsL3/8zOUHBTFQSdXFTYcTkAznj
	 tlrdZjOvMboMawcce+thoVWq7TjmXIlT3K9thq1mswQ6zpKfeKlEdUxcRqcUlKgX9W
	 +YBahdqmxDaIueygIrzoD5By5JcQDLwoijYv8aX22T176M3f0BfeNcxEvgkXVKQFdB
	 cnCwsaZlkXr/nsDCGXRI8CDhQbq7YDYyS5iw3pqjDEy4ixIrJBYBWgnCYkeqzwA4d+
	 Y9MLqrD0dgUUQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA7C10FC451;
	Wed,  8 Apr 2026 21:50:42 +0000 (UTC)
From: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>
Date: Wed, 08 Apr 2026 23:50:04 +0200
Subject: [PATCH net-next 3/7] tcp: Ensure window_clamp is limited to
 representable window
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260408-tcp_rcv_exact_clamp_and_wnd-v1-3-76a6f212e153@gmail.com>
References: <20260408-tcp_rcv_exact_clamp_and_wnd-v1-0-76a6f212e153@gmail.com>
In-Reply-To: <20260408-tcp_rcv_exact_clamp_and_wnd-v1-0-76a6f212e153@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Simon Baatz <gmbnomis@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775685040; l=3305;
 i=gmbnomis@gmail.com; s=20260220; h=from:subject:message-id;
 bh=8RoSAA/YzN+3F5cJqgh/h47kr9+FGErmiW1Qt/v8bjw=;
 b=pkGclS7fY07/CNGhI7e+WKGswdZ1Rp+LPibce79xhOMdvLomiPLlqKMcMYZQrIsNdkUCCQA/r
 DnQh49vpQNxCkyMg1ZdjrqsFZh9In7cJ/db9yEOQWxmhTCJKYP8tEeN
X-Developer-Key: i=gmbnomis@gmail.com; a=ed25519;
 pk=T/JIz/6F5bf1uQJr69lmyi7czVG+F9TVZ/8x5z9Wtqw=
X-Endpoint-Received: by B4 Relay for gmbnomis@gmail.com/20260220 with
 auth_id=641
X-Original-From: Simon Baatz <gmbnomis@gmail.com>
Reply-To: gmbnomis@gmail.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276719-lists,netdev=lfdr.de,gmbnomis.gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[gmbnomis@gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2ABD43C431F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Simon Baatz <gmbnomis@gmail.com>

On connection initiation, window_clamp is limited to the maximum value
representable for the connection's window scale factor.

However, window_clamp may be changed later when:
- it needs to be adjusted due to scaling_ratio changes
- the receive buffer grows due to autotuning
- the TCP_WINDOW_CLAMP socket option is set

In all cases, window_clamp must not end up higher than the maximum
representable advertised window.

Thus, if the TCP connection state indicates that we can rely on
rx_opt.rcv_wscale, clamp the new window_clamp to the maximum window
for that scaling factor (including the "no window scaling" case where
rcv_wscale is zero).

This has visible consequences for calculations based on rcv_wnd. For
example, the logic in __tcp_ack_snd_check() uses the advance of the
right edge of the receive window to determine when to send an
immediate ACK. If rcv_wnd does not properly reflect the "on the wire"
advertised window (i.e. it is much higher than the maximum value
representable), this calculation will be wrong and ACKs may be delayed
when they should be sent immediately.

One concrete example is when the TCP receive buffer is much larger
than 64KB, but no window scaling is used. If window_clamp (and thus
rcv_wnd) are not limited to 65535, the "internal" window based on
rcv_wnd can extend far beyond the 16‑bit window actually advertised on
the wire.

After receiving a data segment, the right edge of the "on the wire"
window can be moved (as there is plenty of space in rcv_wnd) and an
immediate ACK should be sent. But, it won't do so if the calculation
based on rcv_wnd does not happen to change "internal" window right edge.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 net/ipv4/tcp.c       | 4 ++++
 net/ipv4/tcp_input.c | 6 ++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e57eaffc007a0..bd03c99f793ae 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3802,6 +3802,10 @@ int tcp_set_window_clamp(struct sock *sk, int val)
 	old_window_clamp = tp->window_clamp;
 	new_window_clamp = max_t(int, SOCK_MIN_RCVBUF / 2, val);
 
+	if ((1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT |
+			TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2))
+		new_window_clamp = min_t(u32, U16_MAX << tp->rx_opt.rcv_wscale, new_window_clamp);
+
 	if (new_window_clamp == old_window_clamp)
 		return 0;
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 505884dcb7a2b..6e9123c98152f 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -914,6 +914,7 @@ void tcp_rcvbuf_grow(struct sock *sk, u32 newval)
 	struct tcp_sock *tp = tcp_sk(sk);
 	u32 rcvwin, rcvbuf, cap, oldval;
 	u32 rtt_threshold, rtt_us;
+	u32 window_clamp;
 	u64 grow;
 
 	oldval = tp->rcvq_space.space;
@@ -949,8 +950,9 @@ void tcp_rcvbuf_grow(struct sock *sk, u32 newval)
 	if (rcvbuf > sk->sk_rcvbuf) {
 		WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
 		/* Make the window clamp follow along.  */
-		WRITE_ONCE(tp->window_clamp,
-			   tcp_win_from_space(sk, rcvbuf));
+		window_clamp = tcp_win_from_space(sk, rcvbuf);
+		window_clamp = min_t(u32, U16_MAX << tp->rx_opt.rcv_wscale, window_clamp);
+		WRITE_ONCE(tp->window_clamp, window_clamp);
 	}
 }
 /*

-- 
2.53.0



