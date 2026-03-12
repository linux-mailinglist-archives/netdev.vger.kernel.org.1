Return-Path: <netdev+bounces-267205-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKCCNCcgs2mpSQAAu9opvQ
	(envelope-from <netdev+bounces-267205-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 21:20:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0DF278D47
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 21:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 307DB302528C
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 20:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3F12BEFFD;
	Thu, 12 Mar 2026 20:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eYpZ5Daf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF4B1F9F70
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 20:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346714; cv=none; b=iciToDa5CpG1a0PCmLa5WoelQgQeVmQJP0igYnl1cXCf3CSz6kAJUK2CaUr4uuRxlfAmokfF1Sv9ZZ7wKoZ86a44AneW1D388W1AXcdeB2V+I8KksACKVyJ/QKzbKmX2dYEwFRiAo0qSCGAPhkOpvwBjRsmND6lvtC1KKybRono=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346714; c=relaxed/simple;
	bh=dlRXc3B4svmEacGqGwu6aB6Q0sq80QoDqAwnpEVdMo0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d35AVp6URILxglMCcXem8zV6PGMe8AUgnTc5KmTYAU8ssitkOt/3CLg+9DsdwwGbZzDIwQKGj/H4G4EeFBBfXgAWUxjxzJJvu/fkdIuy8YA64ELHun73+JODfawCm8uGupZT5PV+xFdw2IDHqdHA6icXyeCDRxftSutwNBd+usY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eYpZ5Daf; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-5093025ffecso103949811cf.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 13:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773346712; x=1773951512; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k1S96DBhPFnIY2QEFhFfSnKeO69hohtj9ztydHVkxSo=;
        b=eYpZ5DafQPmKdouyhswGaqxh/lTEZ8Tids6P2nJvyugOQ22Fq7gimCAU3PmoNBBAwC
         YQ/gZgXmH569b0G/rT3F5D82bkKGn2vPpTe9xc6dqSwzZhwThSXrOtbtlmcWFqJbOfGl
         m5phL0ZuA7BANhdBRhZyYC1knnvU+t9RWCoIjZw1Q24Sd1QEA+sorNaHo9RkvjzRmX9E
         X9YNTnXEK4OI4Lej9iTqm3IdaQAoWDKa6Gx95mo61o2zSZXnS5EtnXQNz2SePV7Jktdw
         Jt+ywPnvcGlQfYhU9dSrSBmRz2mDDipiw/lJ10mv0R7qTALdGS33/PzA6xzr3yKInidk
         r31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773346712; x=1773951512;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k1S96DBhPFnIY2QEFhFfSnKeO69hohtj9ztydHVkxSo=;
        b=sgpn18iokDQi0GkEFaZeFCPSxrxMcDxm/j2WO9FTjgOZf6rtHUQMoRWaC0eEiDnYwY
         47p5peEx/Cg2b+i/xrFd4c3tfbMgQu7YJYrepPgGN0XGtX4uZHU8pGoCQ5L0LUURGhDv
         5x3MWaV5oEdQZw2sPGAlvhjOwStLt+cVss/TbK+GCerav73Af5FmhK/j2Uzl9qrdyRPi
         tNtc73t8Y02NtelzMO0YsPzQ7azMREzYqVzRKh84d+yHj+nQm/UXBPoq7/NscoH9F5EV
         OfTMN3NQyK/ODIdCCK+VIuL/m30CCAz511Ko/VxFICAZl+qc5CAZjzirARlAyHxH6v0b
         2MMA==
X-Forwarded-Encrypted: i=1; AJvYcCUM6f8jgVVLeb05Hju+C7Sja7THANKhasWGhlIrK6JEozCS8FpNDs8cFkJQmPCyBMewIRuta/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3d6g7Ch74MZ1u70Z8aLBuRECyOW9Axq4AGJNmqN3dX9olD22+
	uIxsQ4FQGG8MBlsHydkTWYbffyxpca37VsqMkuvjh9v3LHV/LmYSBHaWLhhiaROICSJ4kuHbyQs
	awYkHLuqFM6HDzg==
X-Received: from qtxg14.prod.google.com ([2002:ac8:5d4e:0:b0:509:1511:2ece])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7f0a:0:b0:509:820:58d7 with SMTP id d75a77b69052e-50957df3fafmr11309021cf.52.1773346711976;
 Thu, 12 Mar 2026 13:18:31 -0700 (PDT)
Date: Thu, 12 Mar 2026 20:18:23 +0000
In-Reply-To: <20260312201824.203093-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260312201824.203093-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.880.g73c4285caa-goog
Message-ID: <20260312201824.203093-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] net: dropreason: add SKB_DROP_REASON_RECURSION_LIMIT
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267205-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D0DF278D47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ip[6]tunnel_xmit() can drop packets if a too deep recursion level
is detected.

Add SKB_DROP_REASON_RECURSION_LIMIT drop reason.

We will use this reason later in __dev_queue_xmit().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/dropreason-core.h | 3 +++
 include/net/ip6_tunnel.h      | 2 +-
 net/ipv4/ip_tunnel_core.c     | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 5c8c2eb3d2c5b038683b78952106e374cf3b68d1..de61dd5dbfd9dc7d91d22d79a510d42fb69eb60a 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -123,6 +123,7 @@
 	FN(PFMEMALLOC)	\
 	FN(PSP_INPUT)			\
 	FN(PSP_OUTPUT)			\
+	FN(RECURSION_LIMIT)		\
 	FNe(MAX)
 
 /**
@@ -582,6 +583,8 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_PSP_INPUT,
 	/** @SKB_DROP_REASON_PSP_OUTPUT: PSP output checks failed */
 	SKB_DROP_REASON_PSP_OUTPUT,
+	/** @SKB_DROP_REASON_RECURSION_LIMIT: Dead loop on virtual device. */
+	SKB_DROP_REASON_RECURSION_LIMIT,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/include/net/ip6_tunnel.h b/include/net/ip6_tunnel.h
index 359b595f1df93663b3e32c006d936427e8c8b20c..b99805ee2fd14bef6c7bc4daa6e8dfbc34984e4e 100644
--- a/include/net/ip6_tunnel.h
+++ b/include/net/ip6_tunnel.h
@@ -162,7 +162,7 @@ static inline void ip6tunnel_xmit(struct sock *sk, struct sk_buff *skb,
 					     dev->name);
 			DEV_STATS_INC(dev, tx_errors);
 		}
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_RECURSION_LIMIT);
 		return;
 	}
 
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index 5683c328990f49df2954af9d890b5f24150caeb2..f430d6f0463e7ab5761e98047a866d304a49abb2 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -65,7 +65,7 @@ void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
 			DEV_STATS_INC(dev, tx_errors);
 		}
 		ip_rt_put(rt);
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_RECURSION_LIMIT);
 		return;
 	}
 
-- 
2.53.0.880.g73c4285caa-goog


