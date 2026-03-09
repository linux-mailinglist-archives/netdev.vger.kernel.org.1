Return-Path: <netdev+bounces-265398-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iK7KHCB/rmlfFQIAu9opvQ
	(envelope-from <netdev+bounces-265398-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 09:04:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0DE235423
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 09:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6E953023A72
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 08:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4B236BCCE;
	Mon,  9 Mar 2026 08:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vhjxp+Tz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1755363C63;
	Mon,  9 Mar 2026 08:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773043426; cv=none; b=D1e4HZK3n59WHZ9f2qHn52ODD+NRu2Gj1rA0MlsKgQiUehWt5eh17+/4RR1VB8H7WejJf48qY/IT9Oo0J+r0X+yqoZj4d7b+KVB6pi0L1O+ClO4X8NqW3Cn8+upxOnb9L2w1a8uCK9B5L491ye8NepIeGQF0nAAzddNAZ09Bh44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773043426; c=relaxed/simple;
	bh=U6eOZs3iNxBCZqrgik+0s/86JK4oBEk09rxPxv6C1jc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O1OI1Md9Nz9xlujJ+bagvEJpng3jUleXB5jFT9BcG+lwmER4vX4bOmwAj5hEPvuVqYdKWeM1SdPvYvGxzRSck7O3/j1n1+w3srrpbtugiAbxiZ6ZWQg/z3SJ/D430d09v5Hs1jkj9ryxDNVXg93td2eG5pthSFzyj0IavX0629I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vhjxp+Tz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6EB55C2BC87;
	Mon,  9 Mar 2026 08:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773043426;
	bh=U6eOZs3iNxBCZqrgik+0s/86JK4oBEk09rxPxv6C1jc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Vhjxp+TzGcrl9Uu+gCftb9lUUbQwVQq3qygNlH4kUhLqY827Ph0rKVqKGnjPfgfqH
	 NQLCgWuLPGkZOB1Cz6aIa3a29sRLeUX3Xmo/4j8sb31WL4vSN87TkcxOhkg6T8ptB0
	 8IQNtKBjZqADri0bWm8qgqfFWMjbXMeej1e8yThK7JMCLbHLkN1wwM1VWbXJGEUzf2
	 jZASe+9elgTFryZ3gc6a3vLm8KmoJuQOn/Ne3AuuXcpWOu1aXLSNhrWGxs65Vk0+BO
	 PTT0wDcJzNLQflk399xUD4I+RsqxjBHbCD9s6G0zBRb0CU+IG832svcsdP5sqmxSlV
	 p0bKeHKK+GhXQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D591EF36FB;
	Mon,  9 Mar 2026 08:03:46 +0000 (UTC)
From: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>
Date: Mon, 09 Mar 2026 09:02:27 +0100
Subject: [PATCH net-next v3 2/6] mptcp: keep rcv_mwnd_seq in sync with
 subflow rcv_wnd
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-2-4c7f96b1ec69@gmail.com>
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
In-Reply-To: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 David Ahern <dsahern@kernel.org>, Jon Maloy <jmaloy@redhat.com>, 
 Jason Xing <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com, 
 Shuah Khan <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 mptcp@lists.linux.dev, Simon Baatz <gmbnomis@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773043425; l=1316;
 i=gmbnomis@gmail.com; s=20260220; h=from:subject:message-id;
 bh=ChftbPgxBgowAH5jlThlLmD2ZcIdQ5MNv0dOVMZk0bc=;
 b=ebwxj9jswhY7N+FX93x/tqn0TUOf6ljdixhMtvB9X8ZTBTSLzUET9CMuG0w7U6djoehuAO9z1
 K6f847zwt1VANVMgE8WgLKsGJzlx1Qb2yKGdLXsQZf0vswy9hFLWe/W
X-Developer-Key: i=gmbnomis@gmail.com; a=ed25519;
 pk=T/JIz/6F5bf1uQJr69lmyi7czVG+F9TVZ/8x5z9Wtqw=
X-Endpoint-Received: by B4 Relay for gmbnomis@gmail.com/20260220 with
 auth_id=641
X-Original-From: Simon Baatz <gmbnomis@gmail.com>
Reply-To: gmbnomis@gmail.com
X-Rspamd-Queue-Id: ED0DE235423
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
	TAGGED_FROM(0.00)[bounces-265398-lists,netdev=lfdr.de,gmbnomis.gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.969];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[gmbnomis@gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Simon Baatz <gmbnomis@gmail.com>

MPTCP shares a receive window across subflows and applies it at the
subflow level by adjusting each subflow's rcv_wnd when needed.  With
the new TCP tracking of the maximum advertised window sequence,
rcv_mwnd_seq must stay consistent with these subflow-level rcv_wnd
adjustments.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 net/mptcp/options.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 43df4293f58bfbd8a8df6bf24b9f15e0f9e238f6..8a1c5698983cff3082d68290626dd8f1e044527f 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1076,6 +1076,7 @@ static void rwin_update(struct mptcp_sock *msk, struct sock *ssk,
 	 * resync.
 	 */
 	tp->rcv_wnd += mptcp_rcv_wnd - subflow->rcv_wnd_sent;
+	tcp_update_max_rcv_wnd_seq(tp);
 	subflow->rcv_wnd_sent = mptcp_rcv_wnd;
 }
 
@@ -1338,8 +1339,9 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 		 */
 		rcv_wnd_new = rcv_wnd_old;
 		win = rcv_wnd_old - ack_seq;
-		tp->rcv_wnd = min_t(u64, win, U32_MAX);
-		new_win = tp->rcv_wnd;
+		new_win = min_t(u64, win, U32_MAX);
+		tp->rcv_wnd = new_win;
+		tcp_update_max_rcv_wnd_seq(tp);
 
 		/* Make sure we do not exceed the maximum possible
 		 * scaled window.

-- 
2.53.0



