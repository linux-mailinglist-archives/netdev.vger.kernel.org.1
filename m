Return-Path: <netdev+bounces-76719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B6186E9B3
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 20:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63191F2561B
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 19:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B603B298;
	Fri,  1 Mar 2024 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LU7Yqk6v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF64524B
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 19:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321869; cv=none; b=n64SPH1dZ1uI3fUHIb1wp3Dfnh4YkIl8cq28671u30rhHQPrk8xvnkw6mwXhkN0fL0GqSgtP6+7XAv87d+1MniCP7ANGJtgsFnrq72nd6b3dFtIVbvqQ8BCXTzucAygdYUFD5vSEZK1HvbZMZi0mzsU78GKWuXDPORb/CEt1m64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321869; c=relaxed/simple;
	bh=g0JCxee9y8WM7lngp+76yN71yjIdivhG2Hy+8BSkJ0A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r8cCt0Mn8DWeM9yJ/wx92q9S/QQWPzwy+euawzU/nQpOXwlaRF1vVKanueidnmDyNDE+G283v88AuS/6XgjqpQATZi7P1D/G1NocmCBS/XvhYLkJxjN7lgYfZtvkKYEvOg0qsvI6YEIST3heySuWiSu+ZeHmFY97MmELGPivTZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LU7Yqk6v; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60810219282so32832387b3.0
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 11:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709321866; x=1709926666; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jJv1doVck0+J8YGpv3pY19UKzWvtwbH+sfJgs2p1WbE=;
        b=LU7Yqk6vDngaJVJShSRLz3wIYVNVGAZcRoDSwXDKm//qmQIlpMJU746KgeEqnBgfgN
         GWFeEC98BPND0QeBC483xJ83wptt1l5DFWtv2PWFeR2S8b6kIBYeYgC2LVy8zq8Hv6xK
         5h8EKfglbepFvvl5hksXVtiGE8ZTD+5FfEQpjzHsunwcRojXNcmwj0jSLRxFF0JjQ+IE
         JpyAgof1DjE1bdhliiVjiPSc4PwMmskMBmDUigLp8OrI4Au5ovH+tGW7FmnAn4nKycz3
         jsEpizhjMUmQtyevkZgTsL4I5rXAbEqtKj4V0zE7C4OVCA1ksdV5DVgSrMiTCsWL4s2a
         zK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709321866; x=1709926666;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJv1doVck0+J8YGpv3pY19UKzWvtwbH+sfJgs2p1WbE=;
        b=vZaiBha5vGE7ERbLsbsWeG597fhR2kVKGfpYIbtC0nu+7c1zpbw0Ij7L0Maj8wHKj8
         vWowJ+zZzXO0FT1OyCydBYF1Ymgssw28aTLCcktcY+Xu3b+lbuGt3A9mhetnTxig2d97
         vqMWFXFOCFK72EuJT6dd6WdYTofFARCqIvYKymQg9cylyNhPNOI4EsT22b7eP/CnLABz
         XiAVX7Q2FU/ba9++xlWOe3me2IXUjiQs5o6G8lcveNwZKQm/qtt++HosEYasIPAkirTH
         7w43OG35ceN29mtc1+RlWXP98v595L+2kdiV0dJpRtfBWNKlDWaSNEXlYTWhFMX3kprE
         Gl7w==
X-Forwarded-Encrypted: i=1; AJvYcCWq0+BiFa2t3AZ96dQX7ky9lEkkPrajZH0SY7D8TbbDuqD+HpO57VN/w4rqmkJmA4s7hkhbx6z4ZjQGLW8Gir4QcC1iQfwc
X-Gm-Message-State: AOJu0YxeOlT/FYyG+If0fAf0fQVXVr5pdGKjydJX7oLtPkgqIdX3TgDj
	w+zPlM6QBUt8xUm17pnD+7x/mpZkNkB2s4ubND0v/bWD4ZDVylfVeSpMJotrpQsKFoqLkPq80Hk
	AELIzCn6a4A==
X-Google-Smtp-Source: AGHT+IH633MuVX95LTuyMRqu9eytKNS2a4qtN96qQac8Z5wkjDpsUv86VG5QivN0rVzyN2d2YOwfsEuFEZ2ylg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:7947:0:b0:609:359a:9313 with SMTP id
 u68-20020a817947000000b00609359a9313mr497605ywc.1.1709321866474; Fri, 01 Mar
 2024 11:37:46 -0800 (PST)
Date: Fri,  1 Mar 2024 19:37:37 +0000
In-Reply-To: <20240301193740.3436871-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301193740.3436871-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240301193740.3436871-2-edumazet@google.com>
Subject: [PATCH net-next 1/4] net: gro: rename skb_gro_header_hard()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Richard Gobert <richardbgobert@gmail.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

skb_gro_header_hard() is renamed to skb_gro_may_pull() to match
the convention used by common helpers like pskb_may_pull().

This means the condition is inverted:

	if (skb_gro_header_hard(skb, hlen))
		slow_path();

becomes:

	if (!skb_gro_may_pull(skb, hlen))
		slow_path();

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/geneve.c   | 2 +-
 include/net/gro.h      | 7 ++++---
 net/core/gro.c         | 2 +-
 net/ipv4/fou_core.c    | 2 +-
 net/ipv4/gre_offload.c | 2 +-
 net/ipv4/tcp_offload.c | 2 +-
 6 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 6f3f9b446b1d202f6c71a20ce48088691e9120bf..e25e0a31126c1527f5b4f61c83d99f0d9481e58f 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -508,7 +508,7 @@ static struct sk_buff *geneve_gro_receive(struct sock *sk,
 	gh_len = geneve_hlen(gh);
 
 	hlen = off_gnv + gh_len;
-	if (skb_gro_header_hard(skb, hlen)) {
+	if (!skb_gro_may_pull(skb, hlen)) {
 		gh = skb_gro_header_slow(skb, hlen, off_gnv);
 		if (unlikely(!gh))
 			goto out;
diff --git a/include/net/gro.h b/include/net/gro.h
index b435f0ddbf64f7bf740b7e479a1b28bcdef122c6..ffc2c96d263b0399a81465d903a6181271b4a3f7 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -145,9 +145,10 @@ static inline void *skb_gro_header_fast(struct sk_buff *skb,
 	return NAPI_GRO_CB(skb)->frag0 + offset;
 }
 
-static inline int skb_gro_header_hard(struct sk_buff *skb, unsigned int hlen)
+static inline bool skb_gro_may_pull(const struct sk_buff *skb,
+				    unsigned int hlen)
 {
-	return NAPI_GRO_CB(skb)->frag0_len < hlen;
+	return hlen <= NAPI_GRO_CB(skb)->frag0_len;
 }
 
 static inline void skb_gro_frag0_invalidate(struct sk_buff *skb)
@@ -172,7 +173,7 @@ static inline void *skb_gro_header(struct sk_buff *skb,
 	void *ptr;
 
 	ptr = skb_gro_header_fast(skb, offset);
-	if (skb_gro_header_hard(skb, hlen))
+	if (!skb_gro_may_pull(skb, hlen))
 		ptr = skb_gro_header_slow(skb, hlen, offset);
 	return ptr;
 }
diff --git a/net/core/gro.c b/net/core/gro.c
index 0759277dc14ee65d0a5376d48694cc1cccaee959..927ccf68149093d6dfd66a622a7db5215a483876 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -700,7 +700,7 @@ static struct sk_buff *napi_frags_skb(struct napi_struct *napi)
 	skb_reset_mac_header(skb);
 	skb_gro_reset_offset(skb, hlen);
 
-	if (unlikely(skb_gro_header_hard(skb, hlen))) {
+	if (unlikely(!skb_gro_may_pull(skb, hlen))) {
 		eth = skb_gro_header_slow(skb, hlen, 0);
 		if (unlikely(!eth)) {
 			net_warn_ratelimited("%s: dropping impossible skb from %s\n",
diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index 0c41076e31edadd16f8e55ebc50f84db262a2f0d..a8494f796dca336ca4b30fdbc2f91f3a7e6631fb 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -351,7 +351,7 @@ static struct sk_buff *gue_gro_receive(struct sock *sk,
 	optlen = guehdr->hlen << 2;
 	len += optlen;
 
-	if (skb_gro_header_hard(skb, len)) {
+	if (!skb_gro_may_pull(skb, len)) {
 		guehdr = skb_gro_header_slow(skb, len, off);
 		if (unlikely(!guehdr))
 			goto out;
diff --git a/net/ipv4/gre_offload.c b/net/ipv4/gre_offload.c
index 311e70bfce407a2cadaa33fbef9a3976375711f4..5028c72d494abdbf890b3270a4849b2f5c3834a3 100644
--- a/net/ipv4/gre_offload.c
+++ b/net/ipv4/gre_offload.c
@@ -174,7 +174,7 @@ static struct sk_buff *gre_gro_receive(struct list_head *head,
 		grehlen += GRE_HEADER_SECTION;
 
 	hlen = off + grehlen;
-	if (skb_gro_header_hard(skb, hlen)) {
+	if (!skb_gro_may_pull(skb, hlen)) {
 		greh = skb_gro_header_slow(skb, hlen, off);
 		if (unlikely(!greh))
 			goto out;
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 8311c38267b55ba97e59924c3c1c5b59f133fdcd..875456efc92ddd546e13232dd775aaaf1093ce4f 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -204,7 +204,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
 		goto out;
 
 	hlen = off + thlen;
-	if (skb_gro_header_hard(skb, hlen)) {
+	if (!skb_gro_may_pull(skb, hlen)) {
 		th = skb_gro_header_slow(skb, hlen, off);
 		if (unlikely(!th))
 			goto out;
-- 
2.44.0.278.ge034bb2e1d-goog


