Return-Path: <netdev+bounces-240687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EABFC77EAF
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 09:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE61A34AF05
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 08:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8343C33BBCA;
	Fri, 21 Nov 2025 08:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hK0F4Dws"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D963B33B955
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713985; cv=none; b=GUcxoE5l0Rluflws9sFxPyQ1AusyoVe1OBBgJOQOAJd6Ktx9QUbyEnoqPvGopBwduu2ule+vH+qI54GwPwcYH2+R+WqMA5Ja/938WM7lPoIz6qK3eB3+ff11pmY89z31o2A7IV23DW4b5vwp6HParmZROuXTKhdKooBnENGdI6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713985; c=relaxed/simple;
	bh=4LOqyZiI9HQGvTsJttPDbmDgUYW7iZSsiFrydWYiPi0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ncmKAZ9OkNpzovOxf1JZ0daFRQUZyHqxYt6ASBGtcQAKBFDiT3dIaP5pk+icXvxnugVZGFYDVH5AA/46Qg1OdGwLJXDjOq4aTmNesuPEKLjCGE1EYp8jHxErSVBnQky1I0m1gu7f0IuVetRxdkXdQrPWsRmpeP7C5mCAX3tp4AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hK0F4Dws; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4ee25cd2da3so34837761cf.2
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 00:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763713983; x=1764318783; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HqNUy3vR8rtl9+mCGNYD0zh7SzXTO7m4jlaJp+sjzKI=;
        b=hK0F4DwsGONBk5SJTkXB9pClLKkLImfGnxG3F6piPvgIs/IVXITBXksWhEj0FfhL0c
         k3IKUCvVyIoiNSoaY+2OiUkTxrjsntdTu1xNpk1wEavlqXdDJszZam0qedblQirdV5L9
         KcvuqUlZQepvStZRM4aoNZYjHUu2wGAjyjw5bq9hoYKV+rDeF2Jrb7O/lAslMSkrQw+J
         gKQ3hmOzozEYUQ4FAQMAhWrmMlyfjRZdRDhnM5QPG/kPRLLdvo7RR9ZANX9y9GGZ2u/d
         V+i9U7Wn9g26o+u2KXt00voaQAYov82gSFQVUXz/uSOv+llRAXd5uDK+BuPYr9P8Q209
         gvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713983; x=1764318783;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HqNUy3vR8rtl9+mCGNYD0zh7SzXTO7m4jlaJp+sjzKI=;
        b=VJJahhN+xxwyd4pcLfxpxIc+5PbH2uSk7s5K/B9nTzbdkS3NRg46d93nB6S15elQJl
         iYFEuQPqzwraLhEtk1Kdh4VnxBBxiCmcTKInukfcIEP1bvcOUWGMXwzSN6iZkSfN2Eu+
         EX+L1Wj7tA+RSAuoh45GdYk7OKrTNhCT0+awbmN3QGL/8gGxlX+HEKnauqllCRbPr07R
         o+gIcykbY0bqIjV3lsYjEBDjOs3Rb01YiRy4s5xsjlquN2iA8cXB98YET1ZqfpekLwsT
         pqVQ0POyRjotjoa3Yc2gI4IcRrJwUf4VUSvjZsxVeKJ+cqkRIub/c2nNJQiHdu9923tT
         r5Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVOnOhikUbGWifyYWVNeKxzGBszOd35iY8FqML3/F/o2NuiDyLMeBexmk9WP2ih0UtpOvHHYUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVFQivheI6NrXjFTlkaFI6Gm1HPdAEe714Q90yEeadxFMurxiJ
	fZCdKdRV0WFQSF4BVHmFnB2HKZHOoknJUJOCe2IbtIZCW4zsiJ6qdZ/BuvzbXdRhYFqhJCWavy0
	8yVJ69owVKde3Vw==
X-Google-Smtp-Source: AGHT+IFMXdTP/KQaamMkQHVk6rvyyskEe+TqKSLVGrgEmxhtvR3xZWTYHoIawRwmGM3I4Mne8bfpD7Sk6XPaBQ==
X-Received: from qvbkf9.prod.google.com ([2002:a05:6214:5249:b0:882:4f73:45d6])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:3d2:b0:4ee:4a3a:bd1a with SMTP id d75a77b69052e-4ee58921821mr18306781cf.80.1763713982810;
 Fri, 21 Nov 2025 00:33:02 -0800 (PST)
Date: Fri, 21 Nov 2025 08:32:45 +0000
In-Reply-To: <20251121083256.674562-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251121083256.674562-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
Message-ID: <20251121083256.674562-4-edumazet@google.com>
Subject: [PATCH v3 net-next 03/14] net_sched: initialize qdisc_skb_cb(skb)->pkt_segs
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
2.52.0.460.gd25c4c69ec-goog


