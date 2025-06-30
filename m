Return-Path: <netdev+bounces-202410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2105FAEDC92
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422F616CBB3
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 12:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A5A289E23;
	Mon, 30 Jun 2025 12:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W0EH6wOU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31349289E10
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 12:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751285983; cv=none; b=Ro5xZXvOpHubFRtEgVQj0am8SSJINI9BxJtPbSceFOn/MubbGjDM8PkR7yYmMJY9gUvcaAf2+IgAellC/MVwSjPN107j0gYNyMAa0Szuc55QlV1+ci9gd1RK8YDUV9AKceeFD3eOKv23GR/bTBZL1PEouAOdiKaIQmMoHq6E1UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751285983; c=relaxed/simple;
	bh=+XGSgyB5Dsm61GKkbqJUowizPNyfrxabVb69dUuQWIM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NvCMR5v2R+7CgLR849plbTZb61mEcc+YsK5wv33ZDLvySZHtyLXteQ0T06wD5zM14eY8SO0snpqSpk/sbnkuTbBRBBjNKNA4wbs9l0bfn/bMaM3qM45ql0jTNlI5EvbsbT019AwRg+tTCjVjKBQIb9VwjvW4jIILBzMf2Wm7+SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W0EH6wOU; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4a589edc51aso64780431cf.0
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 05:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751285981; x=1751890781; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wnq69afiqBsCZuy9nb2NNOYqNiBo2SCOBoT1HIzwYsI=;
        b=W0EH6wOUpw5sakFfv/djthrNZDtSU1P/NblC7ARc18WAwi/EwQsUdqDYKAGlVU4Jz1
         iEqL/S0ggu6UaIpx8LQp4xDEt/g0Ti3BGwEAVFQ2Af1FTgX3sCx/Eo1jbGN80h2q7qJP
         ze7tivkOuiHA8q+98QITHoxEQJxdpC8XByv4DfTFX/k1J2f+Y5LrPViaciEGhTfpFTO6
         3+xcny+d5oP1ovDL+AQvUWU9zcMc/soXmdt5blqhENzoKkFzgnlTnViHPyPr0tp8VlvK
         BPb1/mHZWuERO3Xuj12lGbQGd0LkKUxcqZIZXDoJBMnsuIxgvHl/i3xxCbn5322UO6cf
         p7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751285981; x=1751890781;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wnq69afiqBsCZuy9nb2NNOYqNiBo2SCOBoT1HIzwYsI=;
        b=DrIKLiyqdr1EPzIjmScF+Tv8EvJdLF5H2rPowI3F3Ikq+ok8LfoYGT+2TwYlFNNn6i
         Ghzj8BbFaO3MxPgNf47VQ/t/IIysuXIZthAgSncHRgwNdssIayLyTBIvv7pkJGn8muTn
         x6KLDzuQ09yIWuZVZUDp1ilQSJ/FJjaIFIn4ayAyhkYmLxElIi4bCyTccp3MgAtU7YON
         ktusY1w5PVeXgZICmgdPtuGlta2N4t5D229YtLu05uJbGpjGs7bgppXq9V4CqoObowhP
         WV7H34c3HaLhqx4DzpWfJbd5ro4igfVnEoU4mk/CcMIq4R4LhMBc4YOhk4ueo6oQowv8
         DCAg==
X-Forwarded-Encrypted: i=1; AJvYcCWQhiq2bKEMMev3NQ7Dc+Q8X2KZ02c4Pr86sWK7+8HllS1VAlDR7JKpxsxxiv9sjBKMl5fmPyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YynHNjpQltIr6e/eerX0aitrkEquhYix8w4K7NnJJciQAr70bPM
	7LNyplZFJmcSC0cVgjF+yvM+u6P/OGZis7jIvj8Or5l3nHddg6WooRymGp0wIKwkRCmpnNZ6neN
	qLpfq2/t1gR6+GA==
X-Google-Smtp-Source: AGHT+IE12nFXq5YVxM1o2qFrtYZ9DLthMWfvUQCvT6r9oWG3AFUMWX+tQT1fEMt66U3TMGArlVy21p+x62wk+w==
X-Received: from qtbfb17.prod.google.com ([2002:a05:622a:4811:b0:48d:7c07:9ac2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:181b:b0:4a6:f416:48c8 with SMTP id d75a77b69052e-4a7fca50055mr210087391cf.23.1751285981103;
 Mon, 30 Jun 2025 05:19:41 -0700 (PDT)
Date: Mon, 30 Jun 2025 12:19:27 +0000
In-Reply-To: <20250630121934.3399505-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250630121934.3399505-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250630121934.3399505-4-edumazet@google.com>
Subject: [PATCH v2 net-next 03/10] net: dst: annotate data-races around dst->lastuse
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

(dst_entry)->lastuse is read and written locklessly,
add corresponding annotations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/dst.h    | 4 ++--
 net/core/rtnetlink.c | 4 +++-
 net/ipv6/route.c     | 3 ++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index 1efe1e5d51a904a0fe907687835b8e07f32afaec..bef2f41c7220437b3cb177ea8c85b81b3f89e8f8 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -240,9 +240,9 @@ static inline void dst_hold(struct dst_entry *dst)
 
 static inline void dst_use_noref(struct dst_entry *dst, unsigned long time)
 {
-	if (unlikely(time != dst->lastuse)) {
+	if (unlikely(time != READ_ONCE(dst->lastuse))) {
 		dst->__use++;
-		dst->lastuse = time;
+		WRITE_ONCE(dst->lastuse, time);
 	}
 }
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index c57692eb8da9d47c3b0943bf7b8d8b7f7d347836..a9555bfc372f5709a3b846343986dce1edf935be 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1026,9 +1026,11 @@ int rtnl_put_cacheinfo(struct sk_buff *skb, struct dst_entry *dst, u32 id,
 		.rta_error = error,
 		.rta_id =  id,
 	};
+	unsigned long delta;
 
 	if (dst) {
-		ci.rta_lastuse = jiffies_delta_to_clock_t(jiffies - dst->lastuse);
+		delta = jiffies - READ_ONCE(dst->lastuse);
+		ci.rta_lastuse = jiffies_delta_to_clock_t(delta);
 		ci.rta_used = dst->__use;
 		ci.rta_clntref = rcuref_read(&dst->__rcuref);
 	}
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 1014dcea1200cb4d4fc63f7b335fd2663c4844a3..375112a59492ea3654d180c504946d96ed1592cd 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2133,7 +2133,8 @@ static void rt6_age_examine_exception(struct rt6_exception_bucket *bucket,
 	 * expired, independently from their aging, as per RFC 8201 section 4
 	 */
 	if (!(rt->rt6i_flags & RTF_EXPIRES)) {
-		if (time_after_eq(now, rt->dst.lastuse + gc_args->timeout)) {
+		if (time_after_eq(now, READ_ONCE(rt->dst.lastuse) +
+				       gc_args->timeout)) {
 			pr_debug("aging clone %p\n", rt);
 			rt6_remove_exception(bucket, rt6_ex);
 			return;
-- 
2.50.0.727.gbf7dc18ff4-goog


