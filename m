Return-Path: <netdev+bounces-307540-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aPbmHlt1VmoK6AAAu9opvQ
	(envelope-from <netdev+bounces-307540-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:43:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D279D75794C
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:43:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=g2SiHA7E;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307540-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307540-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 287293164D2C
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 17:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2934156DC;
	Tue, 14 Jul 2026 17:41:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0EE412C02
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 17:41:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784050887; cv=none; b=hd6b5jBsimVYaqE1DbwNrAjkaktboAlGGXq5c3a+3NPzx1BZUBDAASsivH0QE05ugt/8cSzyUA0YKb8b/pTWFzMMiseEa14DM9a97CyCkqsWTPNjAt/MSKsZUO0RWeHuVc+o2vxs8lxWULS9RG9KHzzEapF6aiHdEHtOO9aE8jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784050887; c=relaxed/simple;
	bh=Ox4/W8NtFAMX+f40X+2E9Ck7CpfewVytyBCKoigiegA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kwk5GUMi3HaOwm0Z96tyltIeq3jOGsp5KH2E0UouqPx5nyx2TrH5fVNsv2aNbr7/rB00+zDA0hWTae81OR3r38421O94wxzWfjvNA0y+Ms0ExSpy834/85sVGGp5H7XZ32qdTisYy+Fy1rn6Au/ACT59ScINEcpkpYvQQUN0cnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2SiHA7E; arc=none smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2caced6038eso17853655ad.0
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 10:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784050883; x=1784655683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v+beJDAg7FygtSf3CwSH4de8wcnddt96Jva8qhSMu00=;
        b=g2SiHA7E9xDKUENAvAE3XoG+lK6jWwa1ad27j46rJ2LlORDaVEzHMtsFzW/2rVZiCk
         bYbz7WmFglee1V3sB8Tuouce7dz6nOR5O1hyqK3SWIwUNxX4qXLCHv6+Eaax/fffEY4t
         fIfZ5w6WRAeqxUxwCZC7+BSXdWDcbq1kXvGbX7mpiKitq8X/cnXgeIjBnFhPYKbNpjg8
         3HXJuY+udvq2EGbhj1i6RA9HiQnDycnqcO1DTIKIMDLqja5v3hoqusfzSux6jUygdwQh
         CmYoh7yHdgcbMhlfl2ZYMHoGcycTYevKYeouHdDmnpDUjvqkEq4jDajlCuDZ71wLCNT0
         QZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784050883; x=1784655683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v+beJDAg7FygtSf3CwSH4de8wcnddt96Jva8qhSMu00=;
        b=m24TdKt0oL0Pzx34Xb3b8FcG3mB5omzgOiYLWaLUBIlcctFL6iAxtFuC/BidLLgfsa
         2vaLK3dZNLkHARC/fRCk70Cy4ZTt6y3lVHxw36YBwW7l14hupVj7US5X03ew7ccSwUSU
         H7P88c77vNcSdeONdb3tm6dM5ZONYTOLPnfLv1Ga/7ZtqcEIlngre2NqrI3R3og3M21h
         NE0DKDDL//41qGU97svC0oaASY38agkSmbzMwXbuaqRegBequenZpd0XOUU4j6uMhFNz
         CyDY3WAdlzJteVjo0xpsgBol7qRrCLXOKtxk5Mg2qSH1nVx+UDRQPG5RjyhMMdVoIatL
         q6Ig==
X-Forwarded-Encrypted: i=1; AHgh+Rrkac4mrNkUuULNU+d1a6dhetJJacp/pS5RjYZKwQVg45bga1YjCJxOlb3BboPSl52oJ/rK6mY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt+zaDfVfYpjxW15BYf+2szsKczESy3gdXw02xRt5zJTN2/f/D
	gQhzGo5IRUXuu9Et6JCsIRItVUyV1aGKyhJSlgS9DeM5lswBmBabRQmA
X-Gm-Gg: AfdE7cnMKXNT16FyHkD7nL8XDvxOEt/ly3cVdomVUv5Tk60wrHGIHttItl/sVgURauQ
	oGkwuujQGhRv84oGOn8xPYHh1uaExvl4Lg0/o3HDgt+Z60n3FGZo+QBr8DY5cuw8MFfcZkg4gzD
	Qna+UABVHcnMqmffJ2R8br7ZGGR179H/MM/K0Yyu5FWt9QpQUWQbaJL02XDhZG8iMZ51SQQ4qVd
	dE/ydEzxJ6rAws2AQyrR5g66qDi/h71Dt0RiYpLGIzcb00Yy3g1YHI1ULWfvnTuMCEHB4GJlq+P
	AhpSLTdvcZfeNpqfDK+gRBRPFGo+v3NT0sjSRddm155Jmnzwuuoa/EH5CnYBefRYeQwfNbmTWS1
	ap5SemieagOrz8NNGk+VBhnUlFWcSomCZ+xhHlV09Q1cnnMZjBBwjENAq7kELEcUSSTIgdEVrJY
	Nn4+zJNMD9KJrxVfa/Jbe0SvGlBgHZObQ92bu4dX3nVmBydr/Okci88E7s+Q==
X-Received: by 2002:a17:903:110f:b0:2cc:92ae:b36 with SMTP id d9443c01a7336-2ce82970406mr171900695ad.24.1784050882693;
        Tue, 14 Jul 2026 10:41:22 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b87b92b27sm38055954c88.6.2026.07.14.10.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 10:41:21 -0700 (PDT)
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
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	linux-kernel@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v3 2/2] tipc: fix NULL deref in tipc_named_node_up() on empty publication list
Date: Tue, 14 Jul 2026 10:41:10 -0700
Message-ID: <20260714174110.1571033-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714174110.1571033-1-bestswngs@gmail.com>
References: <20260714174110.1571033-1-bestswngs@gmail.com>
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
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,dektech.com.au,asu.edu,est.tech,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-307540-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:hoang.h.le@dektech.com.au,m:xmei5@asu.edu,m:tung.quang.nguyen@est.tech,m:linux-kernel@vger.kernel.org,m:bestswngs@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D279D75794C

named_distribute() ends by stamping the last_bulk flag on the tail skb via
buf_msg(skb_peek_tail(list)). When the publication list is empty no skb is
enqueued, skb_peek_tail() returns NULL, and buf_msg(NULL) is dereferenced.

tipc_named_node_up() runs this on &nt->cluster_scope. With a node-id
configuration cluster_scope is populated only later by tipc_net_finalize(),
so a peer link that comes up first reaches named_distribute() with an empty
list. It is reachable by an unprivileged user (TIPC genl ops use
GENL_UNS_ADMIN_PERM) over a UDP bearer in a user+net namespace:

 KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
 RIP: 0010:tipc_named_node_up (net/tipc/name_distr.c:196)
  tipc_named_node_up (net/tipc/name_distr.c:196 net/tipc/name_distr.c:221)
  tipc_node_write_unlock (net/tipc/node.c:428)
  tipc_rcv (net/tipc/node.c:2185)
  tipc_udp_recv (net/tipc/udp_media.c:392)
 Kernel panic - not syncing: Fatal exception in interrupt

The peer holds back this node's later name updates until it sees a bulk
with the last_bulk flag, so simply skipping the empty bulk would stall it.
Emit an item-less bulk when the list is empty, and break out of the build
loop on allocation failure instead of returning, so the last_bulk flag is
applied to the last queued skb.

Fixes: cad2929dc432 ("tipc: update a binding service via broadcast")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/tipc/name_distr.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
index ba4f4906e13b..dbcfa965de34 100644
--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -165,7 +165,7 @@ static void named_distribute(struct net *net, struct sk_buff_head *list,
 						dnode);
 			if (!skb) {
 				pr_warn("Bulk publication failure\n");
-				return;
+				break;
 			}
 			hdr = buf_msg(skb);
 			msg_set_bc_ack_invalid(hdr, true);
@@ -192,6 +192,20 @@ static void named_distribute(struct net *net, struct sk_buff_head *list,
 		skb_trim(skb, INT_H_SIZE + (msg_dsz - msg_rem));
 		__skb_queue_tail(list, skb);
 	}
+
+	if (skb_queue_empty(list)) {
+		skb = named_prepare_buf(net, PUBLICATION, 0, dnode);
+		if (!skb) {
+			pr_warn("Bulk publication failure\n");
+			return;
+		}
+		hdr = buf_msg(skb);
+		msg_set_bc_ack_invalid(hdr, true);
+		msg_set_bulk(hdr);
+		msg_set_non_legacy(hdr);
+		__skb_queue_tail(list, skb);
+	}
+
 	hdr = buf_msg(skb_peek_tail(list));
 	msg_set_last_bulk(hdr);
 	msg_set_named_seqno(hdr, seqno);
-- 
2.43.0


