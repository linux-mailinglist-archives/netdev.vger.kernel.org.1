Return-Path: <netdev+bounces-110310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B2492BD21
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 16:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47EF11F254A1
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 14:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C85F19E7FF;
	Tue,  9 Jul 2024 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RbSKZK9f"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEC719CCE1
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535803; cv=none; b=siTqKUexHHFjLdcBDiSBqg1Fdtqy0EjYQj7h18l8pyGjR3CZuzbAuwE7EJNMIA8m60cFrq9LOZX/Oo05C416GSJYtZdK2vw3BtvCGPfY+33P4kKblOXUuFqVQfhUl2FZKXdXL91nF2TiT5epGlbOqbBjTi/3T8Nh2/+CIbsf6Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535803; c=relaxed/simple;
	bh=WQjwBERS7lelFQl0uZm8b6KivHuPwkMHqfeCg52LURM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YnibIakIoeuYuPuUg4TCTRLOF04Bxhrp6Hc2yVgZbUKqmkPdn0oEPaszD4B4GKD17RBqYXOX3V3RhNOTsQHxJhJ//LvSkOxy5J9y694hAovFaSSfi/1Qj+zAKBoHOjnVyCR9uNpxgdwuCew/K2g1MuHLlkYVc3Ah2Z0u4lW4Zok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RbSKZK9f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720535800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VY5cv6sxNT2DPOy4FzjQps6pTC8NBCeP5vVD1fSftYw=;
	b=RbSKZK9fKErWOyXNOIq8ovisDM3Vg5nKls2YE6+lGWXVAyrCxHJdbfWYa3ff6W6almiZz6
	wV6PhsVNExG9JcvM8BjsI+2BogTPFr0rzG/R6at+0SFAs/uRttekrkB4ZUzMjxdIBQhIJN
	/1kyKtpwvz5jW3aJDUanWhBarBIKpG4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-Ds3wKxscNjm22ayOBAO9AA-1; Tue, 09 Jul 2024 10:36:39 -0400
X-MC-Unique: Ds3wKxscNjm22ayOBAO9AA-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-6c8f99fef10so4569290a12.3
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 07:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720535798; x=1721140598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VY5cv6sxNT2DPOy4FzjQps6pTC8NBCeP5vVD1fSftYw=;
        b=Z4iRDmLOrjJFv1cF7UBfNLRT1Jh4F1/6OUuWQKwufa53xS0G6SUKgMkbqPWeMzntBL
         8tgl4A/reocQZhVmsTgWise3wKDCLgCTDQIG4ZbzlngSCRGe2YQoD/hNYXG7VF+FkY6n
         IkN3iu7+ZJvVt9pNPkKe6pJzQ1BKQFI/eOZggFkXy+6nAgtpEEK58LESuoRl0INWOXYk
         xu3lrzm81HjOu3ixb8fHy23VgE04vM++4lTOFz01FiqwRHloAH+6zj8crvRkH5Puqn8u
         AOA+iRQA/I1GC1TjY+B1XcdtKepQE1rhJxWqZwTe6Y8JpzCEGEt1TOwO2nw7gfFi1UME
         iVEA==
X-Gm-Message-State: AOJu0YwTPY1EUyA4S9l/gFEo3dOhYF1DrkP+Nl06aT+SIuA2s2+4GzMF
	otNuFMXn4ZB20Zugmt+wgjY1PY8mbFrItdF/aIFL4gt9kxKoCFg16Mt8Gt5BAVKC6ZlEOXIJ8Y6
	C/H2LJLx8ilg7kUWQKQrHuOfbmjL6BiKCayZuLeO1l/WPRnHHf8VMlA==
X-Received: by 2002:a05:6a20:12c9:b0:1c0:bd6c:aaa0 with SMTP id adf61e73a8af0-1c29822cf04mr2855572637.28.1720535798209;
        Tue, 09 Jul 2024 07:36:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdNuMmNKEdIA7G57C1sSolv8a1HSGdR8PtE6IeisaSLdShvUO/MYQMkLuFezIlqGMF4DHpQw==
X-Received: by 2002:a05:6a20:12c9:b0:1c0:bd6c:aaa0 with SMTP id adf61e73a8af0-1c29822cf04mr2855540637.28.1720535797850;
        Tue, 09 Jul 2024 07:36:37 -0700 (PDT)
Received: from ryzen.. ([240d:1a:c0d:9f00:ca7f:54ff:fe01:979d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438c5d82sm1892427b3a.45.2024.07.09.07.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 07:36:37 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: jmaloy@redhat.com,
	ying.xue@windriver.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH net-next] tipc: Consolidate redundant functions
Date: Tue,  9 Jul 2024 23:36:32 +0900
Message-ID: <20240709143632.352656-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

link_is_up() and tipc_link_is_up() have the same functionality.
Consolidate these functions.

Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/tipc/link.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index 0716eb5c8a31..5c2088a469ce 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -241,13 +241,6 @@ enum {
 	LINK_SYNCHING        = 0xc  << 24
 };
 
-/* Link FSM state checking routines
- */
-static int link_is_up(struct tipc_link *l)
-{
-	return l->state & (LINK_ESTABLISHED | LINK_SYNCHING);
-}
-
 static int tipc_link_proto_rcv(struct tipc_link *l, struct sk_buff *skb,
 			       struct sk_buff_head *xmitq);
 static void tipc_link_build_proto_msg(struct tipc_link *l, int mtyp, bool probe,
@@ -274,7 +267,7 @@ static void tipc_link_update_cwin(struct tipc_link *l, int released,
  */
 bool tipc_link_is_up(struct tipc_link *l)
 {
-	return link_is_up(l);
+	return l->state & (LINK_ESTABLISHED | LINK_SYNCHING);
 }
 
 bool tipc_link_peer_is_down(struct tipc_link *l)
@@ -1790,7 +1783,7 @@ int tipc_link_rcv(struct tipc_link *l, struct sk_buff *skb,
 		rcv_nxt = l->rcv_nxt;
 		win_lim = rcv_nxt + TIPC_MAX_LINK_WIN;
 
-		if (unlikely(!link_is_up(l))) {
+		if (unlikely(!tipc_link_is_up(l))) {
 			if (l->state == LINK_ESTABLISHING)
 				rc = TIPC_LINK_UP_EVT;
 			kfree_skb(skb);
@@ -1848,7 +1841,7 @@ static void tipc_link_build_proto_msg(struct tipc_link *l, int mtyp, bool probe,
 	struct tipc_link *bcl = l->bc_rcvlink;
 	struct tipc_msg *hdr;
 	struct sk_buff *skb;
-	bool node_up = link_is_up(bcl);
+	bool node_up = tipc_link_is_up(bcl);
 	u16 glen = 0, bc_rcvgap = 0;
 	int dlen = 0;
 	void *data;
@@ -2163,7 +2156,7 @@ bool tipc_link_validate_msg(struct tipc_link *l, struct tipc_msg *hdr)
 		if (session != curr_session)
 			return false;
 		/* Extra sanity check */
-		if (!link_is_up(l) && msg_ack(hdr))
+		if (!tipc_link_is_up(l) && msg_ack(hdr))
 			return false;
 		if (!(l->peer_caps & TIPC_LINK_PROTO_SEQNO))
 			return true;
@@ -2261,7 +2254,7 @@ static int tipc_link_proto_rcv(struct tipc_link *l, struct sk_buff *skb,
 		}
 
 		/* ACTIVATE_MSG serves as PEER_RESET if link is already down */
-		if (mtyp == RESET_MSG || !link_is_up(l))
+		if (mtyp == RESET_MSG || !tipc_link_is_up(l))
 			rc = tipc_link_fsm_evt(l, LINK_PEER_RESET_EVT);
 
 		/* ACTIVATE_MSG takes up link if it was already locally reset */
@@ -2300,7 +2293,7 @@ static int tipc_link_proto_rcv(struct tipc_link *l, struct sk_buff *skb,
 		if (msg_probe(hdr))
 			l->stats.recv_probes++;
 
-		if (!link_is_up(l)) {
+		if (!tipc_link_is_up(l)) {
 			if (l->state == LINK_ESTABLISHING)
 				rc = TIPC_LINK_UP_EVT;
 			break;
@@ -2387,7 +2380,7 @@ void tipc_link_bc_init_rcv(struct tipc_link *l, struct tipc_msg *hdr)
 	int mtyp = msg_type(hdr);
 	u16 peers_snd_nxt = msg_bc_snd_nxt(hdr);
 
-	if (link_is_up(l))
+	if (tipc_link_is_up(l))
 		return;
 
 	if (msg_user(hdr) == BCAST_PROTOCOL) {
@@ -2415,7 +2408,7 @@ int tipc_link_bc_sync_rcv(struct tipc_link *l, struct tipc_msg *hdr,
 	u16 peers_snd_nxt = msg_bc_snd_nxt(hdr);
 	int rc = 0;
 
-	if (!link_is_up(l))
+	if (!tipc_link_is_up(l))
 		return rc;
 
 	if (!msg_peer_node_is_up(hdr))
@@ -2475,7 +2468,7 @@ int tipc_link_bc_ack_rcv(struct tipc_link *r, u16 acked, u16 gap,
 	bool unused = false;
 	int rc = 0;
 
-	if (!link_is_up(r) || !r->bc_peer_is_up)
+	if (!tipc_link_is_up(r) || !r->bc_peer_is_up)
 		return 0;
 
 	if (gap) {
@@ -2873,7 +2866,7 @@ void tipc_link_set_tolerance(struct tipc_link *l, u32 tol,
 	l->tolerance = tol;
 	if (l->bc_rcvlink)
 		l->bc_rcvlink->tolerance = tol;
-	if (link_is_up(l))
+	if (tipc_link_is_up(l))
 		tipc_link_build_proto_msg(l, STATE_MSG, 0, 0, 0, tol, 0, xmitq);
 }
 
-- 
2.45.2


