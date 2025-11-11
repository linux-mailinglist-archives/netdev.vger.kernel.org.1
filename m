Return-Path: <netdev+bounces-237518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87372C4CB11
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79881189ED25
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 09:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A855B2F657A;
	Tue, 11 Nov 2025 09:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mE0JS/4W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAFF2F2618
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 09:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853545; cv=none; b=qktaaw7Wvm9q36DGmpQ6yGCUy0rIlx12kyp0uY3WQMaJBIGh+fPKSErqaDrGkZpS1zKe31IHk1Cqh1aV+vGstoTeFKXobbWsvZlMPMp1oJtOhyjn9KISTIXfNVzT/wOi3ydhO0U4yJsgsQCxMyGGHcsFCJyEzjI90O57/js+Ws0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853545; c=relaxed/simple;
	bh=sPy45mdBUZMsR7SCnvPENVddGi8ejtkJtWYgiTrJx0I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BZ0mF39D7Jzd8uKeB8TzFJaTmDb4s3zb6HoscI1Ro5NWIZg80E6wGpR1suVD+RWnCXJUzAYEn/l1rjIA4Jl5rplBARFZoh0PjjxNA8n2CVsK5r83mLwO6ESsXN1cOAU5qvAip51gQ6km2DoRooe8lSMpJh9N/JGKIkY5ZE44bZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mE0JS/4W; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-88050708ac2so125784156d6.2
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 01:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762853543; x=1763458343; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4WDUv4B/I8B+jQPcUll3/gAqm4lorsqcQmhdXVo6pY=;
        b=mE0JS/4WaPwImry/wi7y/ArwrwHxuRDRXNJTd8X45S7q+x3ke1Gb5QWcLTdtKHygqa
         d0NwqAB0nDPNC7skAWyt4eLd90DQA/9/VSBe4clMoyUfeuIIt67x+RFeUAJdVm5MGUmP
         5oTyCxLb1kUzHjZfy3Ru9B/nTkHdIlkBsSOrPETGviuWAtSY2OyQUeV9pnyMDgkctQzg
         Rab1DyxHO1wdfar9VwHq/zHcXrMwrNlohK0zwHrHRzU38Lj1MGYYSwD3wmsGuoC9QUJG
         eIDl76wU1zE3WvATJBrbqI0YR9yirXG7/jHu5gDfKbAhx7Vkmqt68Q6Osn9xKVWbH4iU
         mfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762853543; x=1763458343;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4WDUv4B/I8B+jQPcUll3/gAqm4lorsqcQmhdXVo6pY=;
        b=q4Imq/3GpiSkB3T8h6AzyrmFPSwK5UhByU0bpdrrtafqX7+0HtF/mBE83XKvsupQ03
         BgevZTvKlZZZh4nkCGdjIyN4Q64LKjbhSdpLGRJtRYVxmKqFg+TQmbK3SeIY+fuHWDI5
         bLfQDlL4n1M8GBjARqbhd/c9CQy9ec9sg2NBBzf6V15bb8gSYXruQoANFdnCPIGV8/wJ
         UrC+MCZL9Ul9Y8fz3/Xi3BBFJCIEYcOKrc7xrV7DBU3aFaytvIVd+XVjkZ4LqGfKsqWj
         fz85dtJ5SXhuTvtAH21PSY3OV3Vn8S8m9o/31Z2prt3HQQxn/VST4GuG8iM9/WxVD45k
         Qgvg==
X-Forwarded-Encrypted: i=1; AJvYcCUqbgZ3IqGpDWXQi2G13V6HKB48XirZMxsLVKauDAOGb7GHB8eqG+wiLiBJ2B+F9iOBwfQrUmI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuc1vH4cjikvlBOJgVMgciekFrl7ppK1O9NBHXnxI09tcpPLzH
	edr++SyRKG1g1+B40Vt/vUQlGObTS2M6V4h3sLJS6+ahpX1BrblE/OhYavY9SIcrnGjSYCr4T06
	fVh2D4YsPKPsSnA==
X-Google-Smtp-Source: AGHT+IGiCdGiPe9p+h9ZNxaFETpFKWO5vbZrH/0VyuEk91SsnTvKqHDRunpr0agPjMoYx2mjmXN6MR0Hk4OPdA==
X-Received: from qvag9.prod.google.com ([2002:a0c:f089:0:b0:882:3f45:85bd])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:f03:b0:87d:e32:81c4 with SMTP id 6a1803df08f44-882386eb7b8mr163191916d6.48.1762853543066;
 Tue, 11 Nov 2025 01:32:23 -0800 (PST)
Date: Tue, 11 Nov 2025 09:32:01 +0000
In-Reply-To: <20251111093204.1432437-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111093204.1432437-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251111093204.1432437-13-edumazet@google.com>
Subject: [PATCH v2 net-next 12/14] net_sched: add tcf_kfree_skb_list() helper
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
2.52.0.rc1.455.g30608eb744-goog


