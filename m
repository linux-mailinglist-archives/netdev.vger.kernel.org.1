Return-Path: <netdev+bounces-276662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPkvEhSP1mmJGQgAu9opvQ
	(envelope-from <netdev+bounces-276662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 19:23:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 262093BF710
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 19:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 260E83014FE6
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 17:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296483D1CB4;
	Wed,  8 Apr 2026 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDnXoG6s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6B73D47A5
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775668994; cv=none; b=UZsqiCL2OWX3LwstRZc5YSV7evCE0jEP+golMXdkqqMkKFqe/WzxMOV9+J0w3XxxTU3KYHyb+aeU9ZIQkaO4sXWymP02i+vf3yW8kSWyWO0Z0I0lSxx2egqJDkM+CxAZ7bxfHpFHHRhwwgzErT/rPTzrZmCF9XKwihDE7eB3LkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775668994; c=relaxed/simple;
	bh=tWeqvg5Qcqs811GG/KcpLYamIBa5u78Lc9G8YV4+SMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gt9A4Bpa6xYXPwONLJ/zzOUOTbJQQZsNIV4y1q3/A4KnQ1Sc1KH1qoTUuxyeebitlbW5SyYWa8EOGzIcYjcHjmyVYFlt6ux7zShqFh4acOPrJYSS5Qlz/+J3pX9vBiLKCienLnASC/pdSy9EVR2NsOKqvcEdb+4ntVi29szqhMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDnXoG6s; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so739765e9.2
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 10:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775668991; x=1776273791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jREm3HFme3aVGJIP/EKemib9zPX7Q4KblusWy7oLiOI=;
        b=MDnXoG6sQqaWch3kre5PaqbJYKnlAVCdYH5nb3iKptuP0oVlZyGLpV4zCtVzF8/JhU
         5w7XKyTHJrLzmbK9Kbg93nkPd0UZ8fPK7iy+AXFbhuSj1/csiC0LepP/r2rN/cCNXDQI
         sXVfDp7QQFptqHIC7yVI6hL1PhDo3Pc2jpDkA83mUtrms5tyMF2hyjNFppEEjWMG4Kes
         ZiT7YGoYxdKMsXgnQhgrC3qzVz8dSlfp4jp/R36eFOm30NJD/lWBcM3DSAmhXXXkNqzR
         YQpiNdrX2SuIgBzAAJExezMkD8AiN6U75J3P2EcuEK48QTr9iBwVm0xGt3Pr39KqC7kt
         oXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775668991; x=1776273791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jREm3HFme3aVGJIP/EKemib9zPX7Q4KblusWy7oLiOI=;
        b=ru0bY1uyQWfc+hnUXRXw/3aiWjvhrOmGTU2316iQK8glvfgytY9S1r167zlL/AIQwi
         AS5VnOaZpJCpjOXTKVQuB0cmjtB+MbdkKqDd7ePZlEdQoB9dXFs1GdYDPtvfKxEcEmjL
         ep5Dqmaa3IIuFxnkw9iTB8KKfB1R8Xl2GXs4Kp/tW7bVKhZXdx46B++Giy11zZEAcx+j
         PquPoiMDnRCr9xd7QXukHWPQSRSHcFRDqKFBgK0wHgTvxEa0qAYq3QXfU/4o8ACaix0A
         /RxTacQyHnjR+QnBDFCOM3Ru5SEgN7rLtU0HThv7ERiuSO647y4sT5kJT8G+wNkH4Jje
         5wQg==
X-Forwarded-Encrypted: i=1; AJvYcCW1PrX+CdhjSmJnxkS/SHbAvafEj+3UHUokQmtWh/Z8HE1S/Wo6NwIx/nQ3Bg2ZEXQXiD8kWpw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8/jg7Ow0hWwCtJboqloCoCaThHBTAr3tvajV3askeUURu8quN
	fpXfAdzKCw4WY1XOEkV1x1qsdsFRWEotrYGd1VtKU5R/JddRDbWUq0gl
X-Gm-Gg: AeBDieveN0qhItbs2I01oRNT7DBj3OTYwshAD9+IX30L2pwWtVGlygKalIJ2p1upwuQ
	JpG72JEKarmtlWn8foECUyPcVBPJx1bXsxLqDHhF5LlZVnlnySIRuhzaJTSO9Yn7kINDTRVFDhf
	Xwk64Q46A9/SzlurJ3xGz3peepjxJrM/f5NoJaI98lqeZq9PUaALJSm4iaH9ZKad3C9Zg8rJxSD
	alKhvM+SXiQGkDI3+AMqR4zf0IH/SQ5vSA2BjhKEJSjAOnwoIbMf3QkOZAnqIoWBoSeB4+nWCtK
	Hh8TiVFlDp3d8TEMWURxk4fKE+f+Us/DS/zevnPexvDfulqFiddXUoTEmb4fxRKCD9D6UAbU7qv
	ePcbIhdKKBEwU/ZmNexP41EBgyKK0/5lO/+Nsz/E94qmAZIlCqJctD4zBmWjrjgLRQ0Kb7Zc92i
	HkRxR4aqX38UEXHChTgnt1FMF1yRGJdBH/2OMIy8cTs2oH2eZXs7Q1KDU8EP0oP0Z17uW6WLOFr
	V2kQjs4or4/
X-Received: by 2002:a05:600c:3544:b0:485:303b:c50a with SMTP id 5b1f17b1804b1-488997352d3mr302107245e9.13.1775668990796;
        Wed, 08 Apr 2026 10:23:10 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cd1d647fsm7015175e9.14.2026.04.08.10.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 10:23:10 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: sdf@fomichev.me,
	kuniyu@google.com,
	skhawaja@google.com,
	liuhangbin@gmail.com,
	krikku@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] net: check qdisc_pkt_len_segs_init() return value on ingress
Date: Wed,  8 Apr 2026 18:23:07 +0100
Message-ID: <20260408172307.172736-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[fomichev.me,google.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-276662-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 262093BF710
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")
changed qdisc_pkt_len_segs_init() to return an skb drop reason when
it detects malicious GSO packets. The egress path in __dev_queue_xmit()
checks this return value and drops bad packets, but the ingress path in
sch_handle_ingress() ignores it.

This means malformed GSO packets entering via TC ingress are not dropped
and could be redirected to another interface or cause incorrect qdisc
accounting.

Check the return value and drop the packet when a bad GSO is detected.

Fixes: 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 net/core/dev.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 5a31f9d2128c..2b5f508fc479 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4459,7 +4459,7 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
 		   struct net_device *orig_dev, bool *another)
 {
 	struct bpf_mprog_entry *entry = rcu_dereference_bh(skb->dev->tcx_ingress);
-	enum skb_drop_reason drop_reason = SKB_DROP_REASON_TC_INGRESS;
+	enum skb_drop_reason drop_reason;
 	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	int sch_ret;
 
@@ -4472,7 +4472,15 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
 		*pt_prev = NULL;
 	}
 
-	qdisc_pkt_len_segs_init(skb);
+	drop_reason = qdisc_pkt_len_segs_init(skb);
+	if (unlikely(drop_reason)) {
+		kfree_skb_reason(skb, drop_reason);
+		*ret = NET_RX_DROP;
+		bpf_net_ctx_clear(bpf_net_ctx);
+		return NULL;
+	}
+
+	drop_reason = SKB_DROP_REASON_TC_INGRESS;
 	tcx_set_ingress(skb, true);
 
 	if (static_branch_unlikely(&tcx_needed_key)) {
-- 
2.53.0


