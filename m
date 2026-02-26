Return-Path: <netdev+bounces-261104-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANMPCZyYn2k9cwQAu9opvQ
	(envelope-from <netdev+bounces-261104-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 01:49:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0840419F94A
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 01:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2499D302D1AD
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 00:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47EB36EABE;
	Thu, 26 Feb 2026 00:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyONrMwu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8043B2FB084;
	Thu, 26 Feb 2026 00:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772066966; cv=none; b=uYySsrGLXm1DyVZWHqxlZ5l61/JL9rJpzlgMYilef+86U0Ucow031kVvHHtxoZ8G9kdQ0V7G0KtnCMa2vKykP+CbDeUSXPuqDZzuA3nlqzjey7T1hicVnBnTw39JfBK/gJxQNBcceuoT1HZVNbVdc6f7SB1/Lb+4bpgfB1MRtHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772066966; c=relaxed/simple;
	bh=QbmP0kfVx4ni8gBhdAx7ruGqnPyNKx3OkmGsJ2k4JQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sjc5oDEYK0uwa3Z4nzAIVoXldmsX1rSmjo9qI/HdWnA4gVntQD3pUEOmerMy9yaUzsqx87ZZ7vZSHzmGLEwGc71POaNQ/xY1r85Q/rzOlD8T8WnL16TCZf9v0ZOIcUOvy5wC+inSv5fPlYnobvKKvff2qM63VB88GxpsHuWvu1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyONrMwu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 461E1C19423;
	Thu, 26 Feb 2026 00:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772066966;
	bh=QbmP0kfVx4ni8gBhdAx7ruGqnPyNKx3OkmGsJ2k4JQw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZyONrMwuSb0C4O74lwzp5Imory2gvu5LHtn72h2U4W/oWpoeyK3FVrw4eAKDA4oBz
	 /B1Dc7HogLGw9RXnVb7nbGHFbX9ylYpM1yUyDSeIYkdSpOPouKoO8OvH/KdA0stVrD
	 S2Me8UgwS00Ox4e0S5eePHabjzyzGtFDSXCaGo1G11Vq9kJGbM1EGZiK6imKYDn4Xe
	 9a8FzzS/PL1fryioAVFwLo9ZCeCLvwmLFkE3LTrsdvNc9xJD2r6tK0+Mw+QDKqu5mi
	 kL6+1GzPy3SwnNc6ksvPA81ngr/B0rDqPSZaUPWix9pbFEgYEdSCMQ53671hC4T5/H
	 J7Jd6tTFow/iA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386F2FD4600;
	Thu, 26 Feb 2026 00:49:26 +0000 (UTC)
From: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>
Date: Thu, 26 Feb 2026 01:49:08 +0100
Subject: [PATCH RFC net-next v2 2/5] tcp: increase LINUX_MIB_BEYOND_WINDOW
 for SKB_DROP_REASON_TCP_OVERWINDOW
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-tcp_rfc7323_retract_wnd_rfc-v2-2-aa3f8f9cc639@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772066964; l=994;
 i=gmbnomis@gmail.com; s=20260220; h=from:subject:message-id;
 bh=93fRnxWZqbnzx4Mxdc8zEz40T5BbuQ5V9PbYF4g/mgk=;
 b=YUzvuvtU4ngaLSbzzTBtAqZv0HBJyEl8GgWKQ11NZIm8QNVuWZhqCk617T2fb1XOrx1VC/+tL
 Vgr6L7j1NoQBNOy+dLtIFoqU1H3+5jOB24pVhMRxaW1Owgpg2WGTlQs
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
	TAGGED_FROM(0.00)[bounces-261104-lists,netdev=lfdr.de,gmbnomis.gmail.com];
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
X-Rspamd-Queue-Id: 0840419F94A
X-Rspamd-Action: no action

From: Simon Baatz <gmbnomis@gmail.com>

Since commit 9ca48d616ed7 ("tcp: do not accept packets beyond
window"), the path leading to SKB_DROP_REASON_TCP_OVERWINDOW in
tcp_data_queue() is probably dead. However, it can be reached now when
tcp_max_receive_window() is larger than tcp_receive_window(). In that
case, increment LINUX_MIB_BEYOND_WINDOW as done in tcp_sequence().

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 net/ipv4/tcp_input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index af9dd51256b01fd31d9e390d69dcb1d1700daf1b..f0ee3a599755aff00a00236728b430c7883087ff 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5739,6 +5739,7 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 	if (!before(TCP_SKB_CB(skb)->seq,
 		    tp->rcv_nxt + tcp_receive_window(tp))) {
 		reason = SKB_DROP_REASON_TCP_OVERWINDOW;
+		NET_INC_STATS(sock_net(sk), LINUX_MIB_BEYOND_WINDOW);
 		goto out_of_window;
 	}
 

-- 
2.53.0



