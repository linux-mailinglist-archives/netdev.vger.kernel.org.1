Return-Path: <netdev+bounces-301665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wuo5Ai3iO2rreggAu9opvQ
	(envelope-from <netdev+bounces-301665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 15:57:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8DE6BEE18
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 15:57:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bynar.io header.s=google header.b=XtvFVpO0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301665-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301665-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bynar.io;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85DD93028C2F
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 13:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172C53B8409;
	Wed, 24 Jun 2026 13:56:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4DD3624C2
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 13:56:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782309419; cv=none; b=Ke38bxVKxCcKlK5n4ctp8TxKmzrZUgwmXT8v8OUm4rDyJ3ChhX/yrc5+hiexo+fpdXDgp/L8gCTpvifVhtGETyanpum1shOPlwPjBCzbM+Uh23UWJz6tWfkTKGDzNh/548B+NZdOsFvOgv2cFIWHFa7MTrpR4A1FBNzI9L7UDr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782309419; c=relaxed/simple;
	bh=XyPA09EsfnnBTiPxZeuSKRTW2G1xE6GNAnIbgWP8cjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fW1J/6tdMkQS7vft8UNeJlvLDL+Lh7u/2EG6hhPJ3RRhK56eY5497zoQqE83MxmiC+qqJ4dkbhzBy4CKbLi7j40m/cFUSuZkyHDgDrRlwG0auGrSSh3tnT+NTrzyliDkFBWIehbGEq2BzW3yRa0wZkWzKDGxhuJv8LucEDmQMAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io; spf=pass smtp.mailfrom=bynar.io; dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b=XtvFVpO0; arc=none smtp.client-ip=209.85.208.50
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-68852b58d87so38583a12.3
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 06:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bynar.io; s=google; t=1782309414; x=1782914214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lm01Y/DJLrHEEgweXFUzCh3ZAl1l/CJchkZn/ZcRYCg=;
        b=XtvFVpO0C7EIdZ+4M/m7F7ni7BRAB5XYFbs8xszxb5aok4MsD3dFglEipBqHc9CLye
         CkB+lT6IdyTfxmsmP4v8ew0qbNiXHA3wi8cjiUY2vDepnmxpTOhyF5tx99wurNU9Hfdu
         cRan/DYsOtrjFoUsk+DAV3/JYmEP/QN3NlnH/kHe8jD4s+NZ7Jz590DLu9yMpoGPzytc
         aO1D4xGj6unE0g/9mp3eU7z7R93RwpP+spv9hNO4MBfT4oc28N5QlxANJ7GM3TWN4WTb
         eeFXOn8vu3y0EVb0ItuyUum+VRGcV/8/2xgovqPIdBaMNo5aGK+IZIqC5ahmSq8o87pk
         RCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782309414; x=1782914214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lm01Y/DJLrHEEgweXFUzCh3ZAl1l/CJchkZn/ZcRYCg=;
        b=drjYJ+50xWpeIc1UO1TMhmf90psn1O2mQbJikYIEOxGeX3RjFOdVnCZBOSIE2BAQYf
         eCG2NNzohZyKn9ffSSl55nwMEW3E7TV3gPPv6jwZ3bXCxA7IqPF32LOjYqxo2F/ZWwe7
         mofuIK1ws2PzAeXggrqnbRbVS7dzQiViXqh9mrr+VgSPW+gB4V9bbaJA6fR59nJzyh9l
         59Or3HTUf8GLPXbClcmtxE0iE/An/ojP/Vya5MSJBoWUo5AOMWDCIhIS8iK6XxvigDG7
         P9iphZzYZtOWP9M9GICUYWbJbv0zgwE4HRclaxLa71Vmvckhi0roJyxNLDKB7sNZLvB1
         iTcQ==
X-Forwarded-Encrypted: i=1; AFNElJ8m2+o1B08Z4YukvGXDQb+Oclw//uxSn+jYjwhIVP22iNHtQTXppElveXdpT4tnWTdR8Puo1nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqsOE1sgxwi9vpoOI9ET9EDJjRNO3etyPzKxOr883jha5spVLo
	4DCLlGtZNvxVQJ2FldX9IA3e9JM4CBjw7rD50e+1IGW1PPsB1wMqBVd/l5+8f5uBV8ob
X-Gm-Gg: AfdE7ck/kEeLvjKzVEQcsoekxpGLeDN+CIUqeyg9LnP8ua43GXIY4i0j6BCZCF3JeEu
	INrS8SRmnlFgfwpsD3Cc/t3ePt/7tM9DY3FDR700puCkQX/C5L+mvJtd+IW8Bzv8gRmrTwweNQ2
	05ZdJt9cw37FZLyuWC+lgSP6amJXRILYCk3PGdqKON/g0GTijprkUp++vq8uGQJqJiV/SArESt0
	TvFezsSfvm8e5T6WW46NsifBtpHpB3FMDiuJjFF/AZgPdNAYh0LMLW+iA3akI+nE9yhOtM+AAlG
	2PevWxlvRGsC7dnIUs7MUZLIN/MaK1f3J3ihDgMN2t2FF5XKFfJipJt2dCac165qyImYW+22RH4
	qwPUcMHSk7mT0DXSos7kXWF5qV6W/DRqX06r4KdPzYkfNQtTiLZe0TRD6ki4aK+UKDSw3RCLdx5
	SexKC9KY8WdsA=
X-Received: by 2002:a17:907:6b07:b0:c11:3fc9:ef65 with SMTP id a640c23a62f3a-c119e764e4cmr187614566b.36.1782309414141;
        Wed, 24 Jun 2026 06:56:54 -0700 (PDT)
Received: from localhost ([2a06:61c2:d427:0:b321:1c7a:b072:326e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c60ac9e77sm656316066b.37.2026.06.24.06.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 06:56:53 -0700 (PDT)
From: Samuel Page <sam@bynar.io>
To: Jon Maloy <jmaloy@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Samuel Page <sam@bynar.io>
Subject: [PATCH net v2] tipc: fix out-of-bounds read in broadcast Gap ACK blocks
Date: Wed, 24 Jun 2026 14:56:29 +0100
Message-ID: <20260624135629.727262-1-sam@bynar.io>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bynar.io,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bynar.io:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301665-lists,netdev=lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[sam@bynar.io,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:tung.quang.nguyen@est.tech,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:sam@bynar.io,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam@bynar.io,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[bynar.io:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bynar.io:dkim,bynar.io:email,bynar.io:mid,bynar.io:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C8DE6BEE18

A broadcast PROTOCOL/STATE_MSG can carry a Gap ACK blocks record in its
data area. tipc_get_gap_ack_blks() only verifies that the record's len
field is self-consistent with its ugack_cnt/bgack_cnt counts
(sz == struct_size(p, gacks, ugack_cnt + bgack_cnt)); it does not check
that the record actually fits in the message data area, msg_data_sz().

The unicast caller tipc_link_proto_rcv() bounds it ("if (glen > dlen)
break;"), but the broadcast caller tipc_bcast_sync_rcv() discards the
returned size, so tipc_link_advance_transmq() copies the record off the
receive skb with an attacker-controlled count:

	this_ga = kmemdup(ga, struct_size(ga, gacks, ga->bgack_cnt),
			  GFP_ATOMIC);

A TIPC neighbour that negotiated TIPC_GAP_ACK_BLOCK triggers it with one
ordinary broadcast STATE_MSG (msg_bc_ack_invalid() clear), sized so its
data area is short, carrying a Gap ACK record with len = 0x400,
bgack_cnt = 0xff and ugack_cnt = 0. len then equals
struct_size(p, gacks, 255), so the consistency check passes and ga is
non-NULL; kmemdup() reads struct_size(ga, gacks, 255) = 1024 bytes out
of the much smaller skb:

  BUG: KASAN: slab-out-of-bounds in kmemdup_noprof+0x48/0x60
  Read of size 1024 at addr ffff0000c7030d38 by task poc864/69
  Call trace:
   kmemdup_noprof+0x48/0x60
   tipc_link_advance_transmq+0x86c/0xb80
   tipc_link_bc_ack_rcv+0x19c/0x1e0
   tipc_bcast_sync_rcv+0x1c4/0x2c4
   tipc_rcv+0x85c/0x1340
   tipc_l2_rcv_msg+0xac/0x104
  The buggy address belongs to the object at ffff0000c7030d00
   which belongs to the cache skbuff_small_head of size 704
  The buggy address is located 56 bytes inside of
   allocated 704-byte region [ffff0000c7030d00, ffff0000c7030fc0)

The copied-out bytes are subsequently consumed as gap/ack values, but
the read is already out of bounds at the kmemdup() regardless of how
they are used.

The unicast STATE path drops such a message: "if (glen > dlen) break;"
skips the rest of STATE_MSG handling and the skb is freed. Make the
broadcast path drop it too. tipc_bcast_sync_rcv() now bounds the record
against msg_data_sz() and, when it does not fit, reports it back through
tipc_node_bc_sync_rcv() to tipc_rcv() so the skb is discarded rather than
processed. ga is not cleared on this path: ga == NULL already means
"legacy peer without Selective ACK", a distinct legitimate state.

Fixes: d7626b5acff9 ("tipc: introduce Gap ACK blocks for broadcast link")
Cc: stable@vger.kernel.org
Assisted-by: Bynario AI
Signed-off-by: Samuel Page <sam@bynar.io>
---
v2, per review of v1 [1]:
 - v1 cleared 'ga' on an oversized Gap ACK record, which let the malformed
   STATE message be processed as a legacy (no Selective ACK) one rather than
   dropped.  v2 drops it instead, matching the unicast STATE path:
   tipc_bcast_sync_rcv() reports the bad record through a bool output
   parameter, propagated by tipc_node_bc_sync_rcv() to tipc_rcv(), which
   discards the skb.
 - v1 touched only net/tipc/bcast.c; v2 also touches net/tipc/{bcast.h,node.c}.

[1] https://lore.kernel.org/netdev/20260623134137.3641275-1-sam@bynar.io/

For reference, an earlier thread proposed validating inside
tipc_get_gap_ack_blks():
  https://lore.kernel.org/netdev/1316452e465e9a96fce44ec15130a14f3872149f.1775809727.git.caoruide123@gmail.com/

 net/tipc/bcast.c | 22 ++++++++++++++--------
 net/tipc/bcast.h |  2 +-
 net/tipc/node.c  | 13 ++++++++++---
 3 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/net/tipc/bcast.c b/net/tipc/bcast.c
index 76a1585d3f6b..08637c3c9db0 100644
--- a/net/tipc/bcast.c
+++ b/net/tipc/bcast.c
@@ -497,11 +497,12 @@ void tipc_bcast_ack_rcv(struct net *net, struct tipc_link *l,
  */
 int tipc_bcast_sync_rcv(struct net *net, struct tipc_link *l,
 			struct tipc_msg *hdr,
-			struct sk_buff_head *retrq)
+			struct sk_buff_head *retrq, bool *valid)
 {
 	struct sk_buff_head *inputq = &tipc_bc_base(net)->inputq;
 	struct tipc_gap_ack_blks *ga;
 	struct sk_buff_head xmitq;
+	u16 glen;
 	int rc = 0;
 
 	__skb_queue_head_init(&xmitq);
@@ -510,13 +511,18 @@ int tipc_bcast_sync_rcv(struct net *net, struct tipc_link *l,
 	if (msg_type(hdr) != STATE_MSG) {
 		tipc_link_bc_init_rcv(l, hdr);
 	} else if (!msg_bc_ack_invalid(hdr)) {
-		tipc_get_gap_ack_blks(&ga, l, hdr, false);
-		if (!sysctl_tipc_bc_retruni)
-			retrq = &xmitq;
-		rc = tipc_link_bc_ack_rcv(l, msg_bcast_ack(hdr),
-					  msg_bc_gap(hdr), ga, &xmitq,
-					  retrq);
-		rc |= tipc_link_bc_sync_rcv(l, hdr, &xmitq);
+		glen = tipc_get_gap_ack_blks(&ga, l, hdr, false);
+		if (glen > msg_data_sz(hdr)) {
+			/* Malformed Gap ACK blocks; caller drops the msg */
+			*valid = false;
+		} else {
+			if (!sysctl_tipc_bc_retruni)
+				retrq = &xmitq;
+			rc = tipc_link_bc_ack_rcv(l, msg_bcast_ack(hdr),
+						  msg_bc_gap(hdr), ga, &xmitq,
+						  retrq);
+			rc |= tipc_link_bc_sync_rcv(l, hdr, &xmitq);
+		}
 	}
 	tipc_bcast_unlock(net);
 
diff --git a/net/tipc/bcast.h b/net/tipc/bcast.h
index 2d9352dc7b0e..55d17b5413e1 100644
--- a/net/tipc/bcast.h
+++ b/net/tipc/bcast.h
@@ -97,7 +97,7 @@ void tipc_bcast_ack_rcv(struct net *net, struct tipc_link *l,
 			struct tipc_msg *hdr);
 int tipc_bcast_sync_rcv(struct net *net, struct tipc_link *l,
 			struct tipc_msg *hdr,
-			struct sk_buff_head *retrq);
+			struct sk_buff_head *retrq, bool *valid);
 int tipc_nl_add_bc_link(struct net *net, struct tipc_nl_msg *msg,
 			struct tipc_link *bcl);
 int tipc_nl_bc_link_set(struct net *net, struct nlattr *attrs[]);
diff --git a/net/tipc/node.c b/net/tipc/node.c
index 97aa970a0d83..2887f94ee28f 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -1831,12 +1831,13 @@ static void tipc_node_mcast_rcv(struct tipc_node *n)
 }
 
 static void tipc_node_bc_sync_rcv(struct tipc_node *n, struct tipc_msg *hdr,
-				  int bearer_id, struct sk_buff_head *xmitq)
+				  int bearer_id, struct sk_buff_head *xmitq,
+				  bool *valid)
 {
 	struct tipc_link *ucl;
 	int rc;
 
-	rc = tipc_bcast_sync_rcv(n->net, n->bc_entry.link, hdr, xmitq);
+	rc = tipc_bcast_sync_rcv(n->net, n->bc_entry.link, hdr, xmitq, valid);
 
 	if (rc & TIPC_LINK_DOWN_EVT) {
 		tipc_node_reset_links(n);
@@ -2140,12 +2141,18 @@ void tipc_rcv(struct net *net, struct sk_buff *skb, struct tipc_bearer *b)
 
 	/* Ensure broadcast reception is in synch with peer's send state */
 	if (unlikely(usr == LINK_PROTOCOL)) {
+		bool valid = true;
+
 		if (unlikely(skb_linearize(skb))) {
 			tipc_node_put(n);
 			goto discard;
 		}
 		hdr = buf_msg(skb);
-		tipc_node_bc_sync_rcv(n, hdr, bearer_id, &xmitq);
+		tipc_node_bc_sync_rcv(n, hdr, bearer_id, &xmitq, &valid);
+		if (!valid) {
+			tipc_node_put(n);
+			goto discard;
+		}
 	} else if (unlikely(tipc_link_acked(n->bc_entry.link) != bc_ack)) {
 		tipc_bcast_ack_rcv(net, n->bc_entry.link, hdr);
 	}

base-commit: a986fde914d88af47eb78fd29c5d1af7952c3500
-- 
2.54.0


