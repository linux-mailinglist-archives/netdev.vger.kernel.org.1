Return-Path: <netdev+bounces-240696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8A7C77EBB
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 09:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 015F829290
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 08:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7642F6934;
	Fri, 21 Nov 2025 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TUbelWqN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F512F25FB
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713997; cv=none; b=hCVEdtxOs6MsbTVYyNL0+wQOYj2TlueW/PjgdD3pCCGUnWAAJXyedz6zCiTjgBfV8dYFpF8ovuxCYA4gnvMCoVWeTT+8ENlc1eacHDzaYv+mh3LX2GZcieJdP5Tzr11zEHvB+Bib0ahIMRfDz5EDtmmiXiG/H7vjJKYObLE4j+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713997; c=relaxed/simple;
	bh=ZrRCyECsAbeJ8Uaa9gI1KhNE9SKqdtGoTrfBtuYPEU4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JY1QrV5v9vt1aBXJmgYdcm5pSNfPVSN39/OPKQ00Wz9C89q3n60EkPMTIKfnX7yn5iNg577jKo4pNVGSek9mh8ovrVf1O8I+FfjZSFnF/1CPfecuUnlmn5T05ATaKS49eBmMEgCiXD8Xa3pNvBp4+FUJ4pPK/q3LoSJ48w/QH2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TUbelWqN; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8805c2acd64so52621386d6.3
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 00:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763713994; x=1764318794; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=84EYn5/VHfv89sZ5ScfleKe7udFvYPBEU+seL7laxbI=;
        b=TUbelWqNbdjL7YNiKIHU07nctDFgVRDQWxUgEgLMT6ojt+PXMm5ttuGBhurn9hcndh
         UN/WCTlMwlfrTwC1uk73JGHVGHKrKi+UliKXYyqp721dLdnBU4k5EU262KhOKEXCeIBi
         6F4V7quIp0sdYmrDHloW37v+qcStmbS18uA1tIaTY8qtxdpWCaJuWNCtvDNH5zN8iMXD
         Maj6GTDndqQmEEiTGIuEjTVXfyaMZVU9in1f9OGYznJ5Aw5zYJTT1Gd1sCnlflytI4rt
         GimjA/3mYKCwK+iIKnoMHNxbnG8dwqMXep9+mFz17jA/P2NDw2I8Mkvc6/HS3h1sFtRd
         pCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713994; x=1764318794;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=84EYn5/VHfv89sZ5ScfleKe7udFvYPBEU+seL7laxbI=;
        b=H2c5WeA473LzKkD6gwZB2pz/lYvpfz+H4sbplXb+2AgUrCMf6VZklPrFi1kvIhlHGf
         X/sgEpIPqfwWBolpfOKmbuCi5PUxefc8576P1nSWqggCy4yjbl3aMRFXD0TBk2Mov8q2
         0DxJxi6WHsSPPkmZPRfJQ7Lb0/jOS7ykgSVeKKdgKx+KfFarF4NnVadG70X4E5EDMUaK
         MdL/zcXAv574zRRyTOJ6y1h1fD3vJKmMrg2m4eoSs+UEhPFy/KwMe0NK1rUUUgxl2IFB
         f9CeT28E76a3S9gJhALvPtEE8WSgQaoSBWSoR8d7g2sBONixtbQcaUiG+YPimTJ1Xl8I
         bDbg==
X-Forwarded-Encrypted: i=1; AJvYcCUPNE0XtflZCP6rSSg4bTg3HN6rhAI4kB3wK/HghuzvKVpxb4iIUVwnX15VOk/0KBP3cI76nOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtPzXdfzNLyAr/4DTHl5Ty/ZhRKBYRQwS141ini9fbM/cDIkka
	hdjNikD4igdfNLFBeUYIagfp5IcxVzQDY4QMGTZSfzKXvegRIxnlsxyk02qQKnYToWVxM8L8X9o
	EwS90pV60Ze9Cog==
X-Google-Smtp-Source: AGHT+IHLEP+KRdN2Hv9gfI9++ZnSY5FblxOT95yigPjRUuYMDPdmaBLiFQ6RZxKtvPP+K7WoOKNIuiiKXaSKVg==
X-Received: from qvbol7.prod.google.com ([2002:a05:6214:3d07:b0:882:4668:dfde])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:29ce:b0:882:401c:e374 with SMTP id 6a1803df08f44-8847c4c7c34mr20127386d6.18.1763713994378;
 Fri, 21 Nov 2025 00:33:14 -0800 (PST)
Date: Fri, 21 Nov 2025 08:32:54 +0000
In-Reply-To: <20251121083256.674562-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251121083256.674562-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
Message-ID: <20251121083256.674562-13-edumazet@google.com>
Subject: [PATCH v3 net-next 12/14] net_sched: add tcf_kfree_skb_list() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Using kfree_skb_list_reason() to free list of skbs from qdisc
operations seems wrong as each skb might have a different drop reason.

Cleanup __dev_xmit_skb() to call tcf_kfree_skb_list() once
in preparation of the following patch.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sch_generic.h | 11 +++++++++++
 net/core/dev.c            | 15 +++++----------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 79501499dafba56271b9ebd97a8f379ffdc83cac..b8092d0378a0cafa290123d17c1b0ba787cd0680 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -1105,6 +1105,17 @@ static inline void tcf_set_drop_reason(const struct sk_buff *skb,
 	tc_skb_cb(skb)->drop_reason = reason;
 }
 
+static inline void tcf_kfree_skb_list(struct sk_buff *skb)
+{
+	while (unlikely(skb)) {
+		struct sk_buff *next = skb->next;
+
+		prefetch(next);
+		kfree_skb_reason(skb, tcf_get_drop_reason(skb));
+		skb = next;
+	}
+}
+
 /* Instead of calling kfree_skb() while root qdisc lock is held,
  * queue the skb for future freeing at end of __dev_xmit_skb()
  */
diff --git a/net/core/dev.c b/net/core/dev.c
index 10042139dbb054b9a93dfb019477a80263feb029..e865cdb9b6966225072dc44a86610b9c7828bd8c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4162,7 +4162,7 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 				__qdisc_run(q);
 				qdisc_run_end(q);
 
-				goto no_lock_out;
+				goto free_skbs;
 			}
 
 			qdisc_bstats_cpu_update(q, skb);
@@ -4176,12 +4176,7 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 
 		rc = dev_qdisc_enqueue(skb, q, &to_free, txq);
 		qdisc_run(q);
-
-no_lock_out:
-		if (unlikely(to_free))
-			kfree_skb_list_reason(to_free,
-					      tcf_get_drop_reason(to_free));
-		return rc;
+		goto free_skbs;
 	}
 
 	/* Open code llist_add(&skb->ll_node, &q->defer_list) + queue limit.
@@ -4257,9 +4252,9 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 	}
 unlock:
 	spin_unlock(root_lock);
-	if (unlikely(to_free))
-		kfree_skb_list_reason(to_free,
-				      tcf_get_drop_reason(to_free));
+
+free_skbs:
+	tcf_kfree_skb_list(to_free);
 	return rc;
 }
 
-- 
2.52.0.460.gd25c4c69ec-goog


