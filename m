Return-Path: <netdev+bounces-305933-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0qpVJBSKTmrwOwIAu9opvQ
	(envelope-from <netdev+bounces-305933-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:34:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5E5729408
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:34:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="X/l0A+Q2";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305933-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305933-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A08F300EF46
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 17:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625C5481AB5;
	Wed,  8 Jul 2026 17:33:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B492D12ED
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 17:33:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783532016; cv=none; b=ZWScjYatFMYqP9At4PBwgVUpCWhBtfTpDY+gpeBY1yVCmj1IEUUJjwuaX0nUD/1SxcoOGoftWZAM+cwLDHNVrxTHy3LPBwmWrZQbWKsWCUVpCbQLMV7Ua3ukF2JDP/qXtcLcBSG+CG/PrkX84NJUfHp8KaCY5cI93SQSkLaknlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783532016; c=relaxed/simple;
	bh=2TMhGFAcZdr+dnyC+i9/GTenfE85ePdYEmpPlVabXk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JekH/YzqABdbRNXwKBQHFwTN7soY3nVE1VBkEqWuAVUBP4yV9aFCHBNY7b++lhzG/4eqAcjrJ/C1Ajv1bY8Ai2xgREaOhlKaXg4HvbNSBNy0fgnsfTlk+232QjGsOkPxwXXfROKi6P/peP0D+rzgjpjXQvtxmcErOYW3FMX2DzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/l0A+Q2; arc=none smtp.client-ip=209.85.215.170
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c96b08cdd1cso618507a12.0
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 10:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783532014; x=1784136814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bc5YeSbJRmHy6yiZUOFHLCE8fvktQKlisrn95zQ65go=;
        b=X/l0A+Q2tODhJwqT/nXoBfB6QDugd1RViFDqMuNmRxTVhgy3s+FrWonIepJlH77qkE
         /siiceBHQFiamTIO0+s9BAGXN9sL40M/kMQ9Txw1BXJURpoTubgPPRrnVxNjsZ9rpGjN
         FCUj6MF82zOC6936To0Q2zwymfGJtTUHp+QNhwZpS0sFivawIE0QXxja1ENq4F34PQYb
         OZNKmsvHHiDaxAFMCUhXBsEpua0uXYjjk2LCKQpBqpHWMlrnSkkVZhRoBPaMYpicvDAB
         QhsMJdQv1PzSVgeyAg6KWflgGiYqxuXLnI88fIRUKRcVlm7m//bAmcJhZu0oxJ6FOvak
         LKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783532014; x=1784136814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bc5YeSbJRmHy6yiZUOFHLCE8fvktQKlisrn95zQ65go=;
        b=RcVQUgrdyLjRaFX5bhliuAtOe020tNcxEY9Z9h/inGER0UOlGFSgKt9kZQrXQwbOc+
         0lb9UgpLsPt3PbkbX0dX0i6rC0zNayojtjHlQITEVfR6XpdvixY98DEwaSXBCSMzWJRx
         GWysIiRPoy/rDloAwt+TKrwRUso6qNSwE4MFcIwn6g0PywN6DNSsII1mlQ2xMBzxv8cY
         +QtY52PcqxyOLOtS2MVdKALqANZLuCGIucxCuNA8hXA4Ut81Ic1SQbNnDZ39laHJnD9k
         xvnlUMbSvR2fH16+yGnDIY/zakbdF30qXAM2yDTQ7QvwVQj0Ea6ZFqBj/TryecKhoa4E
         asLQ==
X-Forwarded-Encrypted: i=1; AHgh+RqbOSa+mzl4uJtoJ0u7nk3TXjKXmxbWrKLTBqkxsh63NmWiNB1oaCPn1pJ/xR9UrjcpUVbBP18=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMo96pSKRQU+pGT3iPVBZq4Z+h1MgZNEd7nzr5LpxuusuHemDt
	++L3r0cTrK43MiHHPmegarr49RTqyYQVXuxB0Fe15Bws6Sk1BBskdWJM
X-Gm-Gg: AfdE7ckqI7J4JxKQvE0c53SMsksJ/LxRZt4BIrMy7IcdMW/htuhQG1Ipl5gZ2x38xW7
	jviqFT2UntBxRWJ8JYyVVrPV2zbtKBRYrvq0BJHr4OymYqBm13C8ry9U+n91ISeGKopBeV41D+f
	4ilLYQLmFzkNyY2QqNZTgl0+O2LcXWqrA2B8Ypsg3HEyyxXT+K9lfmel+ysOgn3IrEO9k92m3r1
	NAWJn+a0CapmK/7vWs2srFCc85IlbSIsL53+P2UCGQnGDgYPK5QUDScUokAbSE6ZDrxSdQDu6w8
	25L7hyjK/FLu2tccsVfwbEttW2hckGt8Iuv7sS1/kk/Vz+mB9HaDNFY0t2+JovpCbyKmRTwLxD6
	ULOsQXrqCI9p+TduSnovDDJ1Mg+I8hWvcJl6qm26r14vi7Wh2rJHUsMbHST6qqlZh/JEAXLukWi
	KRZCvyvPjg6JB5gvFmjF+TUVUWiZ/dhkmJdZ5DwKOyzp5gx5MbCzFJeaP4oA==
X-Received: by 2002:a05:6a20:d491:b0:3b4:81b4:9b79 with SMTP id adf61e73a8af0-3c0bd219f9dmr4323068637.40.1783532014366;
        Wed, 08 Jul 2026 10:33:34 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b65960d88sm19063773c88.6.2026.07.08.10.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 10:33:33 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Xiang Mei <xmei5@asu.edu>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net] tipc: fix NULL deref in tipc_lxc_xmit() on node up
Date: Wed,  8 Jul 2026 10:30:54 -0700
Message-ID: <20260708173052.2973990-3-bestswngs@gmail.com>
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
	FREEMAIL_CC(0.00)[asu.edu,vger.kernel.org,lists.sourceforge.net,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-305933-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:xmei5@asu.edu,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:bestswngs@gmail.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD5E5729408

tipc_named_node_up() builds a bulk of this node's cluster-scope service
bindings for a peer that just came up and sends it with tipc_node_xmit().
When cluster_scope is empty the bulk is an empty skb chain, and both
consumers dereference the head unconditionally: named_distribute() reads
buf_msg(skb_peek_tail(list)) to tag the last message, and for a same-host
peer tipc_node_xmit() routes into tipc_lxc_xmit(), which reads
buf_msg(skb_peek(list)). skb_peek*() returns NULL on an empty chain, so
buf_msg(NULL) faults.

cluster_scope is legitimately empty during the window in
tipc_net_finalize() between setting the node address, after which peers
can link up and trigger tipc_named_node_up(), and tipc_nametbl_publish()
inserting the first self-binding. A peer linking in that window crashes
the node. It is reachable by an unprivileged user, who can gain
CAP_NET_ADMIN in a private net namespace and drive TIPC there.

 Oops: general protection fault, probably for non-canonical address
 KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
 RIP: 0010:tipc_lxc_xmit (net/tipc/node.c:1629 net/tipc/msg.h:202)
  tipc_node_xmit (net/tipc/node.c:1718)
  tipc_named_node_up (net/tipc/name_distr.c:222)
  tipc_node_write_unlock (net/tipc/node.c:428)
  tipc_rcv (net/tipc/node.c:2185)
  tipc_l2_rcv_msg (net/tipc/bearer.c:669)

Skip the distribution when cluster_scope is empty; an empty bulk carries
no bindings, so not sending it changes nothing.

Fixes: cad2929dc432 ("tipc: update a binding service via broadcast")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Cc: stable@vger.kernel.org
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/tipc/name_distr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
index ba4f4906e13b..495e46defddb 100644
--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -218,8 +218,10 @@ void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
 	spin_unlock_bh(&tn->nametbl_lock);
 
 	read_lock_bh(&nt->cluster_scope_lock);
-	named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);
-	tipc_node_xmit(net, &head, dnode, 0);
+	if (!list_empty(&nt->cluster_scope)) {
+		named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);
+		tipc_node_xmit(net, &head, dnode, 0);
+	}
 	read_unlock_bh(&nt->cluster_scope_lock);
 }
 
-- 
2.43.0


