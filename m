Return-Path: <netdev+bounces-213776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF71B26935
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 16:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BBA604FD4
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 14:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65EF21A42F;
	Thu, 14 Aug 2025 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9+UfYhe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D598121B184;
	Thu, 14 Aug 2025 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755180214; cv=none; b=kpfMBkjpxVOpCMzwy56AfobjgxaHUc11MDN7Q+gq2WcwLKTPePIktUlkpnX10hjmwUAV9owbEw4B7MtiDxv8NFp4GqZH8xnFQEw/InQofZRuzLgljnYov5KtBuSji+mhtJVg/VL0GG6cVgfRCPVyzBSNgytmEUvE0W3QzPwjfmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755180214; c=relaxed/simple;
	bh=kOHukOQ3cceJovBOgC2BME7cXTZifKxXU27NEWj1FsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qYNddYT/ox+bBPY6ABAwqEe4dt+aOyoi2mmsJGbag96603H/SPL6T2/QsRUttBmB5pSz/VM91WuxjOF1JAtx7l08A2Q6aOXTXg+6ya58vs9qouC9+ObooUYYvStxr/7e04cSwTjiVfxj8lQbKtMkHidma50zecfJ0I65f5oaYvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9+UfYhe; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b916fda762so988080f8f.0;
        Thu, 14 Aug 2025 07:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755180211; x=1755785011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLxnqIyefbhGWLAW2tSxC8TLmMmgpMfhOXMAxYGHn80=;
        b=H9+UfYhewQdVvULHEB3UrgY+Qc9BsOvAMKxjjFkRKvHPZWxYn2hGwz2ItBo7CW90Dw
         PDA3u25YKnSRf8mtj0BKxl3SapZ3VNqjRwyoR7aQbHynvINY0e6JBedcPS7i1mSbezVK
         dq49Z4SvfhbCbL0/S/b5BI8/EIJTf1G8YeiU64vqnCdpDGbfJhKFyApmpGtYTktcqTB+
         LPYEIoa2T6cmIpOl0xJHLVDAuOLQ1KoMnsjyp1qtqfnRRykcqyUw9X2Rk8hXsAdKRAS6
         VxS1bT46uqkzRpDEy76Qit+MtdTQZ3zKg8YTFoekSX7GazO3I996IsvJukoSBzUEmSiU
         sXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755180211; x=1755785011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLxnqIyefbhGWLAW2tSxC8TLmMmgpMfhOXMAxYGHn80=;
        b=YR0uaNBaEZDf44pIe0Kk3artdiboKF7CJSoBYUohuLtAE8JzehuETjJJZmT3I5tZpb
         Z8UqVVuG5/fPspWKGj9wj0zSb0GWZxENaVLd0ySGU34xNb2bMNhkdH8fMRpi0dmgFVJA
         mlvCQNCsAHBKYExLTu0rokB1REpCmNTSp5nsKtXhpSwTBLFd1D3e3j7odT/JlXW8HFS/
         Zqi+LjiobHb93iGKYezfrJ4bMjnnSTA6C87MLDl1SLEI2qH1YRZdpApq6BWlHEw6BQmb
         iJ4bA4LmWd+NR4RFvLMGlR1sDGHjqHIK8V5G1wwFQauAYafZUjJzra2R84OAIyFQ2HJ/
         F8Ew==
X-Forwarded-Encrypted: i=1; AJvYcCVj6qWZ1js8p8qVnpWynlVPQMXc/neAzR7EUBYOSD1M6tg0CaQc/Be+2gsP8xMUkWUOgafHbB2dRlgn2RE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjbJ+uBleYg82pRb4VC1fwh/JbR72cKb94ZtxCPTBENr3U21a1
	2KUR3anDG+VXr1ZqYHDKDW0mMBwPwnYX2y8Atd9SLvrPKRRdqveJKtc3Vv2Edg==
X-Gm-Gg: ASbGncsDv5NXUlgi6Db1Xeu5s3Zu+2VX5i7zACTZJl47J/7pFE9RNAA1ctnDmRgGndR
	6nrDeRUUmlKShcgYJAo6JceKBOKmG7IrgcObmt/riLIOkXO9nJQ33D000cQeOatoNAk74zpXHWU
	eP44pIXfJHz3rCIwMdJrqWNAEsXFBjVuYKJNqR+rYkCTFr7EGhigQKpJ8AGiShkIEgKDeu8oBzH
	z2zxB85RXjlhHoWLxjW4S6PLmY8ovjG8vbwdVYinWIylYo/0i0KvTYYQjWJIY1/8y8PGNuCSt0g
	s/drAH+SSWM4f94EVINcizpFyPRcMGfRtJmEVDBoYWEFQzKxW3TiXLWRMVyTSKmIbUov1GSX1AS
	RFvJ0FWTAPBpOy4KbUbUo7Ye9rOrNtDM=
X-Google-Smtp-Source: AGHT+IEQqnxg3Y1E0Mfyh2Xt357oFkFI+IHK226NowFV2XYynnUjGHyKopSG04Mkl82E8GKhZLSvGA==
X-Received: by 2002:a05:6000:22c6:b0:3b8:d740:a16a with SMTP id ffacd0b85a97d-3ba508ec53emr2531131f8f.16.1755180210867;
        Thu, 14 Aug 2025 07:03:30 -0700 (PDT)
Received: from oscar-xps.. ([79.127.164.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6c2e95sm22483085e9.6.2025.08.14.07.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 07:03:30 -0700 (PDT)
From: Oscar Maes <oscmaes92@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Oscar Maes <oscmaes92@gmail.com>
Subject: [PATCH net-next v2 1/2] net: ipv4: allow directed broadcast routes to use dst hint
Date: Thu, 14 Aug 2025 16:03:08 +0200
Message-Id: <20250814140309.3742-2-oscmaes92@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250814140309.3742-1-oscmaes92@gmail.com>
References: <20250814140309.3742-1-oscmaes92@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, ip_extract_route_hint uses RTN_BROADCAST to decide
whether to use the route dst hint mechanism.

This check is too strict, as it prevents directed broadcast
routes from using the hint, resulting in poor performance
during bursts of directed broadcast traffic.

Fix this in ip_extract_route_hint and modify ip_route_use_hint
to preserve the intended behaviour.

Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
---
 net/ipv4/ip_input.c | 11 +++++++----
 net/ipv4/route.c    |  2 +-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index fc323994b1fa..57bf6e23b342 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -587,9 +587,13 @@ static void ip_sublist_rcv_finish(struct list_head *head)
 }
 
 static struct sk_buff *ip_extract_route_hint(const struct net *net,
-					     struct sk_buff *skb, int rt_type)
+					     struct sk_buff *skb)
 {
-	if (fib4_has_custom_rules(net) || rt_type == RTN_BROADCAST ||
+	const struct iphdr *iph = ip_hdr(skb);
+
+	if (fib4_has_custom_rules(net) ||
+	    ipv4_is_lbcast(iph->daddr) ||
+	    (iph->daddr == 0 && iph->saddr == 0) ||
 	    IPCB(skb)->flags & IPSKB_MULTIPATH)
 		return NULL;
 
@@ -618,8 +622,7 @@ static void ip_list_rcv_finish(struct net *net, struct list_head *head)
 
 		dst = skb_dst(skb);
 		if (curr_dst != dst) {
-			hint = ip_extract_route_hint(net, skb,
-						     dst_rtable(dst)->rt_type);
+			hint = ip_extract_route_hint(net, skb);
 
 			/* dispatch old sublist */
 			if (!list_empty(&sublist))
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index f639a2ae881a..1f212b2ce4c6 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2210,7 +2210,7 @@ ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		goto martian_source;
 	}
 
-	if (rt->rt_type != RTN_LOCAL)
+	if (!(rt->rt_flags & RTCF_LOCAL))
 		goto skip_validate_source;
 
 	reason = fib_validate_source_reason(skb, saddr, daddr, dscp, 0, dev,
-- 
2.39.5


