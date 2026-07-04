Return-Path: <netdev+bounces-304729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xdrlM5diSWoe1AAAu9opvQ
	(envelope-from <netdev+bounces-304729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 21:44:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA34708490
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 21:44:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Hd8QQ4fH;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304729-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304729-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1387830219B0
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 19:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BF7322533;
	Sat,  4 Jul 2026 19:43:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A6D320CB1
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 19:43:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783194237; cv=none; b=T6f5tm5LioMJMJObAGod70G4Efql1e6r0M7/PfeZ+KREq4B7wpi+lYx69HlxXwCZk9niJOM71BxbrQW0zrJixcCgTGE/lzoMsPelJGkU/nRm8kI6T9qnTXvdjj+oV2dCJkXwV2dlMz9O0d1wvKGkCJo6nP3IK3vfqgyrExfc6OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783194237; c=relaxed/simple;
	bh=XuNhvv+FRnJ+A/TVo2ng0TTniWGpG+LVi0+dlIxrDnY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uxqCDcVx8IKuwX6peXqTjJujdkkxLGbbklmKyoICcTG03vIa8Usv3IvIYf/hV5TTUngGTW6caMeLjOFRmbU5fNmeSiMtghew8uE5DYVHj0eGshK2FMF+ODY9mV3JYjH0YTNVV4Kvn0e8eEPV5osZWhcjYNIeJ2Q9kYS2aYofPa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hd8QQ4fH; arc=none smtp.client-ip=209.85.219.73
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8e9b9f30d65so22447066d6.0
        for <netdev@vger.kernel.org>; Sat, 04 Jul 2026 12:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783194235; x=1783799035; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6kzwBMPL4MTPqDhSSan40irIO1ORJxBDsUzniUq2CeE=;
        b=Hd8QQ4fH5kESM1IZg8DEV5Ou+tpwTC7HA9DBms6zjPrU+Qp+eBMrtWc1pIyDr6U/Z7
         P/891YKHt8YmwTLhYuHRbDDsNUd9pRsCmaJL7Pp5utUaPVJ3ubgX2ZiopFV8CqwpgnpR
         kw2dwERKEeiUugGKgLFY+9kDz7+0lGrpzQd0sxJkMvHXbYVnjbMbwNbgRKbHVjfre/7F
         3KqfpnJQAPhPjpP8kxWORsebVvMdyWAvHQ1aaUE/hNc8Mf8cmyROaILpG2LFkGKeOBEW
         wgxEMBSmvy8oG8Qx3rDLF6i9QyPiu8CCZl5yZJJGqEkbYpG94dVtiMFtb9oi6rNaYxGX
         fyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783194235; x=1783799035;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6kzwBMPL4MTPqDhSSan40irIO1ORJxBDsUzniUq2CeE=;
        b=Ffs8mkj74ovrI4yghXlp3EaG1KYKnalTwMxmPnbD+Vk/PjxzpTtjsX24LMj1iu5V8h
         vHk4B0W5ZR1Xi7hWSYmiDhFx6NSa3Sqid4eOjGrFVmztO9EheayubqGf/ixcdKW5Yozs
         jNybcxBFF2kZILVGoz7OfPcYjbAt7wqkiOvDProioE0Foz7simAbUomUmZ5wBBGCjniN
         U/1va2miJZTVug+LhWNSfXgeCJGeUl3vX1ImajZQhpsl5yh8eb2tMLRSAIuZCqjPW9Mm
         qJG3jJmwRTjWxm/ivHYIUDi2AMvwLlpDEJFJ0E09WVFYaOujI5rjURVx6+FIb7pCPLCf
         T2GQ==
X-Forwarded-Encrypted: i=1; AHgh+RrjUq1O8io341Ff3ChRRWQYtbnPMG40WJtsR78yWdCANNFffhu3VTYTblxI3rVi5GI5NS+qgYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjgKTIR7+O4ipCw5h8KMwkJJcFKG1Yy6I9e51oVjl/DOvmtf7y
	SYRgh9s7bzLukdRY/DvsLZ9l23uCtyBLati4lri8tV4VMfw9qKEl1aENI4dP3GrihfClVT9A+WA
	5NGT6a+/Dh89QIA==
X-Received: from qvbon27.prod.google.com ([2002:a05:6214:449b:b0:8dc:9d4d:cd65])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:3014:b0:8be:1620:a95a with SMTP id 6a1803df08f44-8f74bb9a4f8mr69560686d6.27.1783194234890;
 Sat, 04 Jul 2026 12:43:54 -0700 (PDT)
Date: Sat,  4 Jul 2026 19:43:46 +0000
In-Reply-To: <20260704194346.4065071-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260704194346.4065071-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260704194346.4065071-4-edumazet@google.com>
Subject: [PATCH net 3/3] ipv4: igmp: Fix potential memory leak in igmp_mod_timer()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304729-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,nvidia.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5AA34708490

When a timer is deleted and not re-armed in igmp_mod_timer(), the code
currently decrements the reference counter of the multicast list entry
@im using refcount_dec(&im->refcnt).

However, igmp_mod_timer() can be called from the RCU reader path (e.g., in
igmp_heard_query() via for_each_pmc_rcu()). If the group im was
concurrently removed from the list by ip_mc_dec_group(), its reference count
might have already been decremented to 1.

In this case, timer_delete() succeeds, and refcount_dec() decrements
the refcount from 1 to 0. Since refcount_dec() does not free the object
when it hits 0 (unlike ip_ma_put()), the im structure is leaked.

Fix this by using ip_ma_put(im) instead of refcount_dec(&im->refcnt).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/igmp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index f5f9763895641bf86bfcf9fd7fd7b06012fa4ece..2170b33ba147ce4990e3ee71ba4868e8696b00cb 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -266,6 +266,8 @@ static void igmp_ifc_start_timer(struct in_device *in_dev, int delay)
 
 static void igmp_mod_timer(struct ip_mc_list *im, int max_delay)
 {
+	bool put = false;
+
 	spin_lock_bh(&im->lock);
 	im->unsolicit_count = 0;
 	if (timer_delete(&im->timer)) {
@@ -275,10 +277,13 @@ static void igmp_mod_timer(struct ip_mc_list *im, int max_delay)
 			spin_unlock_bh(&im->lock);
 			return;
 		}
-		refcount_dec(&im->refcnt);
+		put = true;
 	}
 	igmp_start_timer(im, max_delay);
 	spin_unlock_bh(&im->lock);
+
+	if (put)
+		ip_ma_put(im);
 }
 
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog


