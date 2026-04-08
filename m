Return-Path: <netdev+bounces-276717-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMpzOrfN1mnAIggAu9opvQ
	(envelope-from <netdev+bounces-276717-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 23:50:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 375B93C42FA
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 23:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88F04302A07D
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 21:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80153389E17;
	Wed,  8 Apr 2026 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHEQVnLy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5792F364924;
	Wed,  8 Apr 2026 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775685042; cv=none; b=svI6UuUTVyMh4tWzEF/0DaFnLyuCM6KeMA4crGSJ1Dv9ZxBIocrFE/TiKZyTjKv2HOGaB1aneKvRT5qWzMRAjNIzQ5pc7pFDtMZeRXTYw7iaf7UcMjGsj7LKB+1h2x125ZuW3w8AnXm+ECjdS+sQT5iSF+2XzxQYJML4iMzZHa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775685042; c=relaxed/simple;
	bh=wF7RtoJqCsp7VoLarCmy8QgMT99pPiY3eMv5KoPNKFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pWWHRrda1bumhKDkGrivLormhl1Fzc8bYwUt2VncGRDlOvXDwbZvqaqjDYqvEZocAIIRR3Gj9AtQPG0D7DwDq8qB7wSiaT/HMuj5Bb7XiyePASuks6XhEPjGekiHTiTHCRYBMJi3PKcFCa/nx4jvDT/yvOyx5w5cjDHeoXUB8wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHEQVnLy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1EE30C2BC9E;
	Wed,  8 Apr 2026 21:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775685042;
	bh=wF7RtoJqCsp7VoLarCmy8QgMT99pPiY3eMv5KoPNKFI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XHEQVnLyquFWsrFhVohD0Ne/8+CeYqCYyNUMIUlscn1StsmYOGS7cKIifC1vD/f14
	 PB7vpVZ7u/A+ZvyxBl3auBwUFitmIKc8OJyPqPmw9CZJ+YOniltblWeym5YcuZLE/r
	 nS0I8ttabXI9X3tuDImSYz455vXLRsP92oxZeQXvkcHcDmuOPAT5lfnqmKushF/He0
	 rhGxPVxfodOz8DxJjQSGA1bLgvZOB8y1aot4raRHt9JNj9cEy8f60gZdCFMZhusxw6
	 r2O5/eUW9AE1RYyNcE7i9kdCTcddQNowhQ0Hwb709rL4bLaSXFQiY9cF5dHl8J9Drh
	 upVTV6JFNOqHA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0771110FC44D;
	Wed,  8 Apr 2026 21:50:42 +0000 (UTC)
From: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>
Date: Wed, 08 Apr 2026 23:50:02 +0200
Subject: [PATCH net-next 1/7] tcp: keep rcv_wnd/rcv_ssthresh clamped by
 window_clamp if no scaling in use
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-tcp_rcv_exact_clamp_and_wnd-v1-1-76a6f212e153@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775685040; l=3731;
 i=gmbnomis@gmail.com; s=20260220; h=from:subject:message-id;
 bh=D5Yj7InMLE8s8H7wijn4PBjZo6pD1UsEIMIUKtUVqsI=;
 b=T0np/fm0cCfmsmopm+yAL64WwCWbKQ5xalMNOXDtqcWDarCXh4XgNcPAWLwjOAD74EK84mCTt
 4BzDrMH7MxVBdK2sxWjq/soVkXrNEeyj2l6EenIRU9XJHC6IzbNNpi5
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
	TAGGED_FROM(0.00)[bounces-276717-lists,netdev=lfdr.de,gmbnomis.gmail.com];
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
X-Rspamd-Queue-Id: 375B93C42FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Simon Baatz <gmbnomis@gmail.com>

When window scaling is not used, we already clamp window_clamp to
65535, but rcv_wnd/rcv_ssthresh can still remain larger than this.

Fix this by capping rcv_wnd to 65535 in the non-scaling paths of both
active and passive opens. Since the advertised window in SYN and
SYN/ACK segments is unscaled, this cannot shrink the window
advertised to the peer.

Also ensure that tcp_select_initial_window() always keeps rcv_wnd less
than or equal to the (scale-limited) window_clamp.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 net/ipv4/tcp_input.c     | 7 ++++++-
 net/ipv4/tcp_minisocks.c | 8 ++++++--
 net/ipv4/tcp_output.c    | 5 +++--
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 7171442c3ed7a..505884dcb7a2b 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6898,7 +6898,6 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		 */
 		WRITE_ONCE(tp->rcv_nxt, TCP_SKB_CB(skb)->seq + 1);
 		tp->rcv_wup = TCP_SKB_CB(skb)->seq + 1;
-		tp->rcv_mwnd_seq = tp->rcv_wup + tp->rcv_wnd;
 
 		/* RFC1323: The window in SYN & SYN/ACK segments is
 		 * never scaled.
@@ -6909,7 +6908,13 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 			tp->rx_opt.snd_wscale = tp->rx_opt.rcv_wscale = 0;
 			WRITE_ONCE(tp->window_clamp,
 				   min(tp->window_clamp, 65535U));
+			tp->rcv_ssthresh = min(tp->rcv_ssthresh, 65535U);
+			/* As the window in the SYN was not scaled,
+			 * we did not advertise more than 65535.
+			 */
+			tp->rcv_wnd = min(tp->rcv_wnd, 65535U);
 		}
+		tp->rcv_mwnd_seq = tp->rcv_wup + tp->rcv_wnd;
 
 		if (tp->rx_opt.saw_tstamp) {
 			tp->rx_opt.tstamp_ok	   = 1;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 199f0b579e89c..6496fe3b9e139 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -600,9 +600,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	newtp->rx_opt.tstamp_ok = ireq->tstamp_ok;
 	newtp->rx_opt.sack_ok = ireq->sack_ok;
 	newtp->window_clamp = req->rsk_window_clamp;
-	newtp->rcv_ssthresh = req->rsk_rcv_wnd;
 	newtp->rcv_wnd = req->rsk_rcv_wnd;
-	newtp->rcv_mwnd_seq = newtp->rcv_wup + req->rsk_rcv_wnd;
 	newtp->rx_opt.wscale_ok = ireq->wscale_ok;
 	if (newtp->rx_opt.wscale_ok) {
 		newtp->rx_opt.snd_wscale = ireq->snd_wscale;
@@ -610,7 +608,13 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	} else {
 		newtp->rx_opt.snd_wscale = newtp->rx_opt.rcv_wscale = 0;
 		newtp->window_clamp = min(newtp->window_clamp, 65535U);
+		/* As the window in the SYN/ACK was not scaled,
+		 * we did not advertise more than 65535.
+		 */
+		newtp->rcv_wnd = min(newtp->rcv_wnd, 65535U);
 	}
+	newtp->rcv_ssthresh = newtp->rcv_wnd;
+	newtp->rcv_mwnd_seq = newtp->rcv_wup + newtp->rcv_wnd;
 	newtp->snd_wnd = ntohs(tcp_hdr(skb)->window) << newtp->rx_opt.snd_wscale;
 	newtp->max_window = newtp->snd_wnd;
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 8e99687526a64..bf7a12872acb3 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -269,8 +269,9 @@ void tcp_select_initial_window(const struct sock *sk, int __space, __u32 mss,
 				      0, TCP_MAX_WSCALE);
 	}
 	/* Set the clamp no higher than max representable value */
-	WRITE_ONCE(*__window_clamp,
-		   min_t(__u32, U16_MAX << (*rcv_wscale), window_clamp));
+	window_clamp = min_t(u32, U16_MAX << (*rcv_wscale), window_clamp);
+	WRITE_ONCE(*__window_clamp, window_clamp);
+	*rcv_wnd = min(*rcv_wnd, window_clamp);
 }
 
 /* Chose a new window to advertise, update state in tcp_sock for the

-- 
2.53.0



