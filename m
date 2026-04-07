Return-Path: <netdev+bounces-275905-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id R5rqB6zD1GmmxAcAu9opvQ
	(envelope-from <netdev+bounces-275905-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 10:43:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2923AB789
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 10:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC78930048C4
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 08:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A393939DD;
	Tue,  7 Apr 2026 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nEruKG7v"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C152E54B6
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 08:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775551401; cv=none; b=SDNJguFmwZ3Uge6wIJ/IHM7SbYtSX67cQnXGUzT9fYPkspJioH91ZgWlH3sVbDqG2iuQ3ASm89UB5axSuBaXigkpGzfwUo0Egymx2YY9hkL3PCZWExjLsbetbkY/xcT8Fa/MJsa0hF3zDPUbbt4s4qjXAlX51Oa3ZIXdmPYe4EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775551401; c=relaxed/simple;
	bh=ur0/Cy5HeDdbCGQ6Nkwa4Fr/T4FfeEjaIVd1seb4g5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FW/TLLYDZQ/ayKWIyeEqa9lRr3s6AESN8Z7vp767SISwTfc8I/8EhWo6cbUhekW3NgPlNgyTglth+VWofNuFBiFuVyv03kRNHe20dEegL3QLFYQGnT8iSqxDMsTQcLe1IqX5DbQooqw2blTqc3lUmNRxkIFLHgkfqfQX8fcTU9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nEruKG7v; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775551397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YG8WTR8zxy5E+D0qbi2BRlO966r8JsfuPWhpPgXocW8=;
	b=nEruKG7vrHQWioNn8ylJSKf+LzTsIY9Q1Dl/fbK76yeWQxLig0qWyPrO+Sn4huwsqnJyn0
	N1oXS7O6vOn/D33HOJWy6By7hrdlmfD7WB++oOW0fL+kr6x7bdpxhLDslwX9jIp0oYk9QN
	RZwz9epqeJoJ7idEzM5p8VPCeZtGWrE=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: initialize sk_rx_queue_mapping in sk_clone()
Date: Tue,  7 Apr 2026 16:42:18 +0800
Message-ID: <20260407084219.95718-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275905-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 6C2923AB789
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sk_clone() initializes sk_tx_queue_mapping via sk_tx_queue_clear()
but does not initialize sk_rx_queue_mapping. Since this field is in
the sk_dontcopy region, it is neither copied from the parent socket
by sock_copy() nor zeroed by sk_prot_alloc() (called without
__GFP_ZERO from sk_clone).

Commit 03cfda4fa6ea ("tcp: fix another uninit-value
(sk_rx_queue_mapping)") attempted to fix this by introducing
sk_mark_napi_id_set() with force_set=true in tcp_child_process().
However, sk_mark_napi_id_set() -> sk_rx_queue_set() only writes
when skb_rx_queue_recorded(skb) is true. If the 3-way handshake
ACK arrives through a device that does not record rx_queue (e.g.
loopback or veth), sk_rx_queue_mapping remains uninitialized.

When a subsequent data packet arrives with a recorded rx_queue,
sk_mark_napi_id() -> sk_rx_queue_update() reads the uninitialized
field for comparison (force_set=false path), triggering KMSAN.

This was reproduced by establishing a TCP connection over loopback
(which does not call skb_record_rx_queue), then attaching a BPF TC
program on lo ingress to set skb->queue_mapping on data packets:

BUG: KMSAN: uninit-value in tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1875)
 tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1875)
 tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2287)
 ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207)
 ip_local_deliver_finish (net/ipv4/ip_input.c:242)
 ip_local_deliver (net/ipv4/ip_input.c:262)
 ip_rcv (net/ipv4/ip_input.c:573)
 __netif_receive_skb (net/core/dev.c:6294)
 process_backlog (net/core/dev.c:6646)
 __napi_poll (net/core/dev.c:7710)
 net_rx_action (net/core/dev.c:7929)
 handle_softirqs (kernel/softirq.c:623)
 do_softirq (kernel/softirq.c:523)
 __local_bh_enable_ip (kernel/softirq.c:?)
 __dev_queue_xmit (net/core/dev.c:?)
 ip_finish_output2 (net/ipv4/ip_output.c:237)
 ip_output (net/ipv4/ip_output.c:438)
 __ip_queue_xmit (net/ipv4/ip_output.c:534)
 __tcp_transmit_skb (net/ipv4/tcp_output.c:1693)
 tcp_write_xmit (net/ipv4/tcp_output.c:3064)
 tcp_sendmsg_locked (net/ipv4/tcp.c:?)
 tcp_sendmsg (net/ipv4/tcp.c:1465)
 inet_sendmsg (net/ipv4/af_inet.c:865)
 sock_write_iter (net/socket.c:1195)
 vfs_write (fs/read_write.c:688)
 ...
Uninit was created at:
 kmem_cache_alloc_noprof (mm/slub.c:4873)
 sk_prot_alloc (net/core/sock.c:2239)
 sk_alloc (net/core/sock.c:2301)
 inet_create (net/ipv4/af_inet.c:334)
 __sock_create (net/socket.c:1605)
 __sys_socket (net/socket.c:1747)

Fix this at the root by adding sk_rx_queue_clear() alongside
sk_tx_queue_clear() in sk_clone().

Fixes: 342159ee394d ("net: avoid dirtying sk->sk_rx_queue_mapping")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/core/sock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/sock.c b/net/core/sock.c
index 5976100a9d55..a12c5eca88f2 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2583,6 +2583,7 @@ struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
 
 	sk_set_socket(newsk, NULL);
 	sk_tx_queue_clear(newsk);
+	sk_rx_queue_clear(newsk);
 	RCU_INIT_POINTER(newsk->sk_wq, NULL);
 
 	if (newsk->sk_prot->sockets_allocated)
-- 
2.43.0


