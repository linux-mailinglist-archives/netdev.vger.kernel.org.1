Return-Path: <netdev+bounces-304770-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u/pGBW9HSmqHAwEAu9opvQ
	(envelope-from <netdev+bounces-304770-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 14:00:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FDC709E46
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 14:00:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pqcCkLBA;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304770-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304770-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF4023018BCE
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 12:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9646237883E;
	Sun,  5 Jul 2026 12:00:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E2C37DAD6
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 12:00:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783252826; cv=none; b=WhIMAwByf/1TqK4AdajjMkrf/bWNtHJe9rcN3+vXORwuf9uWR7pnwbodh9BOnhTIhl3FPc8gth+5tQWhODl4h3dPKt3cH217YHrwo0xrKuwz+waRMtfuJPjleuuCByLKujtyMOTfKajOm8K/mICGwooE0P4hNDrWeWFYV/V4eSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783252826; c=relaxed/simple;
	bh=cu+bqe4Hx++hIcLMUsNciEEGVF2+wcj/55k2GRBV+Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G79ksS4ZciLXQk1T/UY6rRCr5lV5m4UwgVn9TlQ53XhPYxIdSrY5zC989rq6dkR0ZwknAph6lpFN6FJ3qZqjdsRr78TuOwpi4oxWf87CPgZz9nbim8lkp5Uzbsc4gCSAXnNBq1vgcGIWItEmNRrEdPW34IFxQkmTaV0rCQ12pOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pqcCkLBA; arc=none smtp.client-ip=209.85.216.51
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-385ea3ce80dso61105a91.2
        for <netdev@vger.kernel.org>; Sun, 05 Jul 2026 05:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783252825; x=1783857625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ls7kqreyGphH86458JSHsraoQgcF7cLHZtyEgEOry7U=;
        b=pqcCkLBAsCZC8Tnq68XbD6/vBATNs0AyD0Z9zpflpZgghLTObtyNxDP6D1WjHXNzTx
         Iu7L7OB49vHuwBrxLuUsT4KAXMwNVSP140jFuAZlk3wTnOTieUrtZZZWKAGUfysWllSZ
         /MqGL8SMyoH5cnfm2MwxW5xunCAaEGipbSZW0aSx5358cG8dbvnSqW2OirE8tFDwBLlg
         4qzLbghWRlnMmP0zJKZnpTh2N2qLAQmxCNXQUVzBcCdy0N0AmHBEWIWpnfCSPh4GTvuq
         BYSz4SCjFTM8ln3jjrXDhU7SeihYTm4anOFT5uVKSIyvbBkP0V7eIAvIsT+ojU5fR/LU
         Zw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783252825; x=1783857625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ls7kqreyGphH86458JSHsraoQgcF7cLHZtyEgEOry7U=;
        b=iLMxNCxCshxKV9xOygcXs1aoAMJysIl+0Gbo+tF9b3gqJKAoxsrXyOwn+6IbICNtUe
         jKPhroHq/KVCd2/JKF5YNecG2D7gM+GEgb9BzdN16RtzBYexDc0Mn5slqCFWYYKqjMj1
         JXojr3wxUDiPWM5RHmOQz98X5Ker0qvxASoAVG92vl6/RLIS/MzbEpu5UZJfYw9DmH1L
         pRNNvDQJyY5G2wp7NGxJI7vhMoU1cTlE0yKxIgWs2Zrl/GPlSJSDmsjFrdWzOEFdJEc2
         1yTop2dZ41x/6g51yH8qp6eTZAJhsjiUtyLtcCsjb3c2IJAw+t9mSDAdR/Pq4J+WOAmv
         wvww==
X-Forwarded-Encrypted: i=1; AHgh+RpBMG/ynHv6++Pzj5QSpqsziKYV1xVQucgoXgMxhjEgxGaUV2E61d+TIU3ijYRBUgV8dccN4GU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLE46QnvZHeXDpYO9YzMAaPAZiBQDTn8R0ccdAZbk2a9QIfuqy
	aLY4dD1TMCUDNq536ThpHFfiMj/Rr18CxBlC5+NrsD2s0LuUFhnbxr3K
X-Gm-Gg: AfdE7clten+ENlOEC04vxwVfO9LXqnTeVUi43ZQnIJUywQD+yN3y5UuZQcWymtqdSRu
	ncBj4cA46Y6KWjiX22c/tMJGkPd55p6lAVoC8rEErXzaMFnA8Uy+7rZDOmBuxl9T+VmD43DrjEk
	CtihjESwQcpd/eq0ZQVH4JYQapVn5S9B6bDlOgBDbu8aSAFUS58CxJ7Kdnj9ro0EtYyd9SowL6Z
	sqLZyPMN70eWY7Z5RWBChXOxDphKRfksjidJrVOY2RnCXgrKf21wOxFwNdV51xTZl4V9+ZFBi7F
	MdwQcCi6tmjdy1WU5ddCiTIdDl6xnACeQpt5Ynp0dHdaqysuZhBINxIxIjmMf8hUMayr921rH5C
	KI0jMEZhK1v6SK6alnK3tDAEdWhXc/R26N+HVqyZEG0DxIchhx4F2EFhxETPFipaLm0NjOO85Zz
	VD62NJ3O6jntvkB7rwG9rctXfBnt7cFzH1wwMNB8mc+m10dtBnQP8EtNPNmg==
X-Received: by 2002:a17:90b:184e:b0:37f:9cdf:f0ad with SMTP id 98e67ed59e1d1-3829f9e3ecamr6118708a91.28.1783252821911;
        Sun, 05 Jul 2026 05:00:21 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f3b252222sm23482072eec.23.2026.07.05.05.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 05:00:20 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hoang Huu Le <hoang.h.le@dektech.com.au>,
	Xiang Mei <xmei5@asu.edu>,
	linux-kernel@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net] tipc: fix NULL deref in tipc_named_node_up() on empty publication list
Date: Sun,  5 Jul 2026 04:59:58 -0700
Message-ID: <20260705115958.1066751-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,dektech.com.au,asu.edu,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-304770-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:hoang.h.le@dektech.com.au,m:xmei5@asu.edu,m:linux-kernel@vger.kernel.org,m:bestswngs@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 68FDC709E46

named_distribute() builds the bulk messages for @pls into @list and then
dereferences the tail skb:

	hdr = buf_msg(skb_peek_tail(list));
	msg_set_last_bulk(hdr);

If @pls is empty no skb is enqueued, skb_peek_tail() returns NULL, and
msg_set_last_bulk() writes through buf_msg(NULL).

tipc_named_node_up() passes &nt->cluster_scope. With a node-id
configuration the TIPC_NODE_STATE name is published by tipc_net_finalize()
from a work item, which sets the node address before publishing the name.
The node accepts links once the address is set, so a link that comes up
before the publish runs named_distribute() on an empty cluster_scope:

 KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
 RIP: 0010:tipc_named_node_up (net/tipc/name_distr.c:196)
  tipc_named_node_up (net/tipc/name_distr.c:196 net/tipc/name_distr.c:221)
  tipc_node_write_unlock (net/tipc/node.c:428)
  tipc_rcv (net/tipc/node.c:2185)
  tipc_udp_recv (net/tipc/udp_media.c:392)
 Kernel panic - not syncing: Fatal exception in interrupt

TIPC genl ops use GENL_UNS_ADMIN_PERM, so an unprivileged user can reach
this from a user+net namespace.

Return early from named_distribute() when the list is empty, and skip
tipc_node_xmit() for an empty chain. The empty chain would otherwise hit
tipc_lxc_xmit() -> buf_msg(skb_peek(list)), the same zero-skb case fixed
for tipc_link_xmit() in commit b77413446408 ("tipc: fix NULL deref in
tipc_link_xmit()").

Fixes: cad2929dc432 ("tipc: update a binding service via broadcast")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/tipc/name_distr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
index ba4f4906e13b..c04fea4650a5 100644
--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -192,7 +192,10 @@ static void named_distribute(struct net *net, struct sk_buff_head *list,
 		skb_trim(skb, INT_H_SIZE + (msg_dsz - msg_rem));
 		__skb_queue_tail(list, skb);
 	}
-	hdr = buf_msg(skb_peek_tail(list));
+	skb = skb_peek_tail(list);
+	if (!skb)
+		return;
+	hdr = buf_msg(skb);
 	msg_set_last_bulk(hdr);
 	msg_set_named_seqno(hdr, seqno);
 }
@@ -219,7 +222,8 @@ void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
 
 	read_lock_bh(&nt->cluster_scope_lock);
 	named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);
-	tipc_node_xmit(net, &head, dnode, 0);
+	if (!skb_queue_empty(&head))
+		tipc_node_xmit(net, &head, dnode, 0);
 	read_unlock_bh(&nt->cluster_scope_lock);
 }
 
-- 
2.43.0


