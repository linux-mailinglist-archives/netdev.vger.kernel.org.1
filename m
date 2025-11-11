Return-Path: <netdev+bounces-237521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D3DC4CB50
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC9CD18845D1
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 09:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AAF2EBBAF;
	Tue, 11 Nov 2025 09:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IfcXmORO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A514D257831
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 09:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853872; cv=none; b=gSTM+BFb2nCs/GwDKExjpz0/5gZiL+zNYh8w8FwNUy/GLDZyIL19Wl/QIHG7235CQHt9N6P0niFmDlEz2diV2k+YEohY4CnfbKC8EKa4TnOL4q9CYIn8jUuFQRPJX0eUrzaJ1bwV/qu9KsAPEf3/yQOt6Tbhb3vT935YCMoXzjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853872; c=relaxed/simple;
	bh=PGux2NR0IFPNax8NKO7ZxluButf36cG766hdCir5ZDs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=coEUt9EyS9pr1Gg4ZFrs0URenbZozgpJ4U8o3FB4z/2szuG6JkkOI1u/cMg/H651ikakBtvkMDami16kVmwI30u2gPu8kpjqI50MTTiRBcp3oFwvAUSwq0Rb6Fo4sLUF+GznBtjuMTFHFjeZvXi9PD/7G8gE5VGmEwZkTY8Rs+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IfcXmORO; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8b259f0da04so360531385a.0
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 01:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762853869; x=1763458669; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iT/LuQJztWPY8htUJBN5PW7/w3kOnxLQY6YuXFmFCJY=;
        b=IfcXmORO1Ftp5JLQ0kcSDwb/jGJVCPMoRnOZwVdoK1/zjdEeGoTVWL896z1vnOwqU/
         kpWXsMXG0tcyJVpW1ZdvfhRcO58vMShNFTdHAdG6OtbDJiwLrHeCDhentMh5p6Nc3Hh6
         kGGS2W9BG5qYX5CTx5vZB4A3ogeVwF45LEBOMVsvu/gXAmo0/7sgNivJqN2DWBvuEDM5
         ggnhjzlbg60fjRR8CO+KDVF7d/u96MiIl6H2d/nJ2VngZexK69OsJ4zK4Oh0J1ft0qdr
         V5lHtluiHxSPdniOEdQi0RhlUOqTzKopDmZagcK/syVxSiP+D7Eq96qVBtf+ixvjX4rC
         aEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762853869; x=1763458669;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iT/LuQJztWPY8htUJBN5PW7/w3kOnxLQY6YuXFmFCJY=;
        b=uXIHQrLq6B8Se4bot3gq8FZrvE9mP5NbdQdpasjnn2JBuZeNJQ+5+nlvarMmx1KwtM
         whBciGIXan1LexNlcYowwsbosvilTnsveRQ4dg8xBDORCXbh1iBkhxHY9x4mVxI5l0Gh
         N958JaEwSmc2mgP3GVScPm/8MEOUzVxb2mXtDuw7AXVfaYHkczE9g4QkYsopclI10OzA
         l5HfWVMoTw1hrl5BHf6KzCgPQc2xKQsLzXrrEYeFDBgyAWMTzI4ACWyHtD0PXbpw9Nue
         Z3eXUTz0w09qbYpgDgxHjvSnmIO97eC4lXRmOZoxl1/ICecE8IUhmAx+3hVtb8WRR/6H
         32Yw==
X-Forwarded-Encrypted: i=1; AJvYcCU35GG6d1yAwyjxdO1NZI29e9kQ+iMZ5rPlwV0sS1lV8fOXvHs0MKxeAUNatMXQ7Kutgbrw2uI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz5iKeOYeO0AcUplnU2qx6doOQjoxx7vtcggIGeBwJLP6uPe69
	1QXyaQmnD6l13GzfewHSrSQmf3mZMG+gFaMPE1JNINMI7qokZiWlQnDUqqaYgySh/Qc4nVZk+r2
	fNEYVDkjzo7MVXA==
X-Google-Smtp-Source: AGHT+IFXotGRr4Ed3Iif2CQhFwwRQO1qeDaqUR/d6EYywtlTjST6ICiLDxYPXCrCvpJECfG38tBZT2UzjSR9Ag==
X-Received: from qvbiu13.prod.google.com ([2002:ad4:5ccd:0:b0:882:2f2f:9fe])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2a4f:b0:882:4d5c:1f36 with SMTP id 6a1803df08f44-8824d5c220amr87317166d6.28.1762853529865;
 Tue, 11 Nov 2025 01:32:09 -0800 (PST)
Date: Tue, 11 Nov 2025 09:31:52 +0000
In-Reply-To: <20251111093204.1432437-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111093204.1432437-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251111093204.1432437-4-edumazet@google.com>
Subject: [PATCH v2 net-next 03/14] net_sched: initialize qdisc_skb_cb(skb)->pkt_segs
 in qdisc_pkt_len_init()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

qdisc_pkt_len_init() is currently initalizing qdisc_skb_cb(skb)->pkt_len.

Add qdisc_skb_cb(skb)->pkt_segs initialization and rename this function
to qdisc_pkt_len_segs_init().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c       | 15 +++++++++++----
 net/sched/sch_cake.c |  2 +-
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index dba9eef8bd83dda89b5edd870b47373722264f48..895c3e37e686f0f625bd5eec7079a43cbd33a7eb 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4069,17 +4069,23 @@ struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *d
 }
 EXPORT_SYMBOL_GPL(validate_xmit_skb_list);
 
-static void qdisc_pkt_len_init(struct sk_buff *skb)
+static void qdisc_pkt_len_segs_init(struct sk_buff *skb)
 {
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
+	u16 gso_segs;
 
 	qdisc_skb_cb(skb)->pkt_len = skb->len;
+	if (!shinfo->gso_size) {
+		qdisc_skb_cb(skb)->pkt_segs = 1;
+		return;
+	}
+
+	qdisc_skb_cb(skb)->pkt_segs = gso_segs = shinfo->gso_segs;
 
 	/* To get more precise estimation of bytes sent on wire,
 	 * we add to pkt_len the headers size of all segments
 	 */
-	if (shinfo->gso_size && skb_transport_header_was_set(skb)) {
-		u16 gso_segs = shinfo->gso_segs;
+	if (skb_transport_header_was_set(skb)) {
 		unsigned int hdr_len;
 
 		/* mac layer + network layer */
@@ -4113,6 +4119,7 @@ static void qdisc_pkt_len_init(struct sk_buff *skb)
 				return;
 			gso_segs = DIV_ROUND_UP(payload, shinfo->gso_size);
 			shinfo->gso_segs = gso_segs;
+			qdisc_skb_cb(skb)->pkt_segs = gso_segs;
 		}
 		qdisc_skb_cb(skb)->pkt_len += (gso_segs - 1) * hdr_len;
 	}
@@ -4738,7 +4745,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 
 	skb_update_prio(skb);
 
-	qdisc_pkt_len_init(skb);
+	qdisc_pkt_len_segs_init(skb);
 	tcx_set_ingress(skb, false);
 #ifdef CONFIG_NET_EGRESS
 	if (static_branch_unlikely(&egress_needed_key)) {
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 32bacfc314c260dccf94178d309ccb2be22d69e4..9213129f0de10bc67ce418f77c36fed2581f3781 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1406,7 +1406,7 @@ static u32 cake_overhead(struct cake_sched_data *q, const struct sk_buff *skb)
 	if (!shinfo->gso_size)
 		return cake_calc_overhead(q, len, off);
 
-	/* borrowed from qdisc_pkt_len_init() */
+	/* borrowed from qdisc_pkt_len_segs_init() */
 	if (!skb->encapsulation)
 		hdr_len = skb_transport_offset(skb);
 	else
-- 
2.52.0.rc1.455.g30608eb744-goog


