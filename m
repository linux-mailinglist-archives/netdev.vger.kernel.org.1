Return-Path: <netdev+bounces-301986-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6x/UKZw+PWpL0AgAu9opvQ
	(envelope-from <netdev+bounces-301986-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:43:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD876C6C58
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 16:43:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bynar.io header.s=google header.b=MXz0cxjF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301986-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301986-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bynar.io;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 57ECA3007205
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 14:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9C13E6396;
	Thu, 25 Jun 2026 14:38:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E4332470E
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 14:38:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782398324; cv=none; b=Oxdbk/PVkOC9Xbgua5LKyzmfv3BOF9dqrVkIhhGWf4Xmq2ibk0TJDabVT0kdCWvUt/H3sUJEiRIah11N/DKfbBuzOpErW7ExhQ2xlbdSLaIc9Rc7zg+EtR4LfLPv1m8oodCLOvDDz64ps452p7l8xIZQ0wQoPYaNO2ggds3X1ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782398324; c=relaxed/simple;
	bh=kupFyLYKcr2diQnDTbCsXEeLmkCvBNTpUv66NvQ0gBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XOJTTrVLKfDR7TAY2egDLAu9OvyhUGRKhp94RQG1mkyjhArP6xA46wTORaAxIoM159itmFWlH4zeh1nvzPkN+y15E6f4mDiCps03bxBlBFPfLhYbqrU6PtNwrDwg5OM31ExkV0awa1rRU4E6kVHnKIaZqs4rmDDEWGmQ5PeUemg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io; spf=pass smtp.mailfrom=bynar.io; dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b=MXz0cxjF; arc=none smtp.client-ip=209.85.218.43
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c0c41ff84a6so550286966b.1
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 07:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bynar.io; s=google; t=1782398320; x=1783003120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XY4ljmmJfRdzZN+EfM21UiZLHHqxIilAOQkRMOvqbIw=;
        b=MXz0cxjFXHc8hWgJiK/KpwFVFKPN20rD2Mgy3XH/H6JEjf5vSlCaKmlJEEmNBxx1Kd
         G0e41R+AxJvpdnaPcv5G92UPNoyNsWxs8J3Cqj+5qbHLcSXXDpuT7yABdnVyCrlj3SSn
         sYIM3KoBHkDv10yKs23JNo/0avk7SDC6G9lLACVwYbMDoC9dhUOmMV/cWoudVqGr2R0Z
         gTpPLVFLisg1WePbrTI+L8x+Tv66ergw94PnlPvSdV13wPdRpSEiHHEYm0MtJQCfBYY9
         tf4HflrEmBpN7XqroSdPaboPEC7wAh/YUY9VjOxKC6J6GLlWfiJNOZsTwvyl8+39X9a6
         2a/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782398320; x=1783003120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XY4ljmmJfRdzZN+EfM21UiZLHHqxIilAOQkRMOvqbIw=;
        b=lGMYD8tv6xjZQ2HL7YO8zWq2DCDDDDcs14Y8CEalrHzLb0TCCRuKu23CiEyDDj+U6b
         ch2Z16khjhxWdLafxOdrEmTVYTt7q9/Jccm7IbwrnbEFbSw6M0YKD7wLfSMOtLTPTD2H
         jTxd3gEqgybJd4zsNpKRyahnxLqZ7QAPGr4YOw0lQbIa3obhb6icjqDW8+1T8RH/0abu
         E4MiLED6vsBmOuysoea2MTU/rOTLcNU86gYqRjucwcCg4ejr8eAmutaEq51G8stnTMIS
         w8f4lt5HNqsPZjEgbg+PNBKUHXG+OXS2KWaqndhfpIJFDOBW7v1yuZreqqaA4vYZ8nzL
         MCSQ==
X-Forwarded-Encrypted: i=1; AHgh+RplJTWVtAP+bI8ZhUypmZECJ7/LCO7d1ics+QQH3vw0lhfaZjCskU1/d53VxIGhxUadj+WuuT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YziamIDKIzyYu8uqoVxt27pbmDHMlNqyPFcyad2Ui8+q8EVwvqb
	Nfz3GW2KtZvC4FQqqZMc1BWtAcjz0OKlNXB4xcSxPc5clKo7YDOCBbgQ3igwIEmrtMnU
X-Gm-Gg: AfdE7clxD55l6Hlaq6rOATFps0CcCpllA5FDDRGlUWP9e4wQUzjSXdIXrTJ8Zf3EMrP
	aheB8R3kTL18R3XzgI4LXBSxMOekMYqM+RVxBAnKgq+HjRsiDOEc5c+grS2NzPVHXgsSdWDjXFI
	Sbj3fwdgNGd0WOWPPYSwZRL/qXwVE2gowyGlwcfoDrYH5iYdEAR/iCShr09X/cPJlaTs66MAHD+
	L7jhjV/FaihW0pQlmzw/xS/AaOEF8jQA+xRQqB9wpuaHGCgG/MckTHI8krC1zG5cmLxI3SCSn7o
	Nhxj7qohO7Bel9bnEzQV7mZdw5AplIOsR3ABQGrD3b6hUttrF6xXSaNo6yjtKaSGtU+nsBzMy2j
	DprjWNnxOBQjHL1Aeq6PyiQXjq6RtS4TcjpKO5FDp6gN95H3/Ag+OyC0gFdH4XgwGAdLhwuWuGp
	Ug
X-Received: by 2002:a17:907:9715:b0:c12:17d3:31df with SMTP id a640c23a62f3a-c1217d334ecmr51157466b.7.1782398319793;
        Thu, 25 Jun 2026 07:38:39 -0700 (PDT)
Received: from localhost ([2a06:61c2:d427:0:b321:1c7a:b072:326e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbba6787sm214080166b.6.2026.06.25.07.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 07:38:39 -0700 (PDT)
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
Subject: [PATCH net v3] tipc: fix out-of-bounds read in broadcast Gap ACK blocks
Date: Thu, 25 Jun 2026 15:38:15 +0100
Message-ID: <20260625143815.1525412-1-sam@bynar.io>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[bynar.io:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301986-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,bynar.io:dkim,bynar.io:email,bynar.io:mid,bynar.io:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BDD876C6C58

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
v3, per review of v2 [2]:
 - reverse-xmas-tree order for the new 'glen' declaration in
   tipc_bcast_sync_rcv().
 - tipc_node_bc_sync_rcv() now checks the validity flag and returns
   immediately when the Gap ACK record is malformed, rather than relying on
   the (zero) return code to fall through.

v2, per review of v1 [1]:
 - v1 cleared 'ga' on an oversized Gap ACK record, which let the malformed
   STATE message be processed as a legacy (no Selective ACK) one rather than
   dropped.  v2 drops it instead, matching the unicast STATE path:
   tipc_bcast_sync_rcv() reports the bad record through a bool output
   parameter, propagated by tipc_node_bc_sync_rcv() to tipc_rcv(), which
   discards the skb.
 - v1 touched only net/tipc/bcast.c; v2 also touches net/tipc/{bcast.h,node.c}.

[1] https://lore.kernel.org/netdev/20260623135443.3662041-1-sam@bynar.io/
[2] https://lore.kernel.org/netdev/20260624135629.727262-1-sam@bynar.io/

For reference, an earlier thread proposed validating inside
tipc_get_gap_ack_blks():
  https://lore.kernel.org/netdev/1316452e465e9a96fce44ec15130a14f3872149f.1775809727.git.caoruide123@gmail.com/

 net/tipc/bcast.c | 22 ++++++++++++++--------
 net/tipc/bcast.h |  2 +-
 net/tipc/node.c  | 15 ++++++++++++---
 3 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/net/tipc/bcast.c b/net/tipc/bcast.c
index 76a1585d3f6b..10d1ec593084 100644
--- a/net/tipc/bcast.c
+++ b/net/tipc/bcast.c
@@ -497,12 +497,13 @@ void tipc_bcast_ack_rcv(struct net *net, struct tipc_link *l,
  */
 int tipc_bcast_sync_rcv(struct net *net, struct tipc_link *l,
 			struct tipc_msg *hdr,
-			struct sk_buff_head *retrq)
+			struct sk_buff_head *retrq, bool *valid)
 {
 	struct sk_buff_head *inputq = &tipc_bc_base(net)->inputq;
 	struct tipc_gap_ack_blks *ga;
 	struct sk_buff_head xmitq;
 	int rc = 0;
+	u16 glen;
 
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
index 97aa970a0d83..8e4ef2630ae4 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -1831,12 +1831,15 @@ static void tipc_node_mcast_rcv(struct tipc_node *n)
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
+	if (!*valid)
+		return;
 
 	if (rc & TIPC_LINK_DOWN_EVT) {
 		tipc_node_reset_links(n);
@@ -2140,12 +2143,18 @@ void tipc_rcv(struct net *net, struct sk_buff *skb, struct tipc_bearer *b)
 
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

base-commit: 02f144fbb4c86c360495d33debe307cb46a57f95
-- 
2.54.0


