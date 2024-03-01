Return-Path: <netdev+bounces-76721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05ED386E9B9
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 20:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89AB8B25EB1
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 19:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A8C3BBF6;
	Fri,  1 Mar 2024 19:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TUVqtQaB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC5E3BB36
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 19:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321872; cv=none; b=oa71RMwZeZyqrfEuGzXFLspmgbSHnQNMbLvJ88VbtvZ732tPLDurafLQPu9ATr8W3g85uG4Mega4mysu7aieofO+xgteXOmkoMUtXUy1w3ux3lAYZq7pHYtVa4M7+6HdByqBGsfGGJB9Wcbwqh0tDqYYNIe8EmrWBGQMMh+D6dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321872; c=relaxed/simple;
	bh=lPUuLJtPF0HWe9ep8AFHHFXsEpn2kyHFaQLDlJsyWKA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hft10SqZLeOQY4zxT1+yxAc/OTV0yhk1luWeeCZ21p+uxkTCVqb4Xm6eNQgClGCufDgmV5HsC8SsHS3HNjNtR+7JZyxa/2XN7IAMHlk4eYncmDv55Yx4VT7/DdOpNP0bBZLP01B8SZ+Ckr43Rh2nUKi8Q4J7ufLg5FCBp0mRtxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TUVqtQaB; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6093c69afafso36099497b3.2
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 11:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709321870; x=1709926670; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3mvTIxPSmJwpwbQbgaaXOh6A0fIjvDUqijmBzbNCxO4=;
        b=TUVqtQaByTcZZdGVYH4b3rh9HrtCLoNM6CWOorkjlrd/M9mJBMlfVFF6ALLGqER4Va
         WpqjlxcU79AlrJEXWIq3fl/kvL9z/47T9J27O9chqsf8X/bQJ10rH7GS0MfkbjcNBKVc
         peWD30/+zHPBf5EdBIpSVRS4sxlTcvAdf3KTuesSVKeTLWdKleilmDEzXvoFV3XQZxyF
         UxgFMn885pVjRRvoXPnORvFaIhjcM2HKwX7x2aMuZN159FNJZsvB+6E6tEwHC0ZrpDMS
         c/RUHaLYQUy+N9RqCydNAaYBlZ5mUADyuqjvqLCdZ1AyaQifx5gKIjZHeIUvzooeXk0t
         oAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709321870; x=1709926670;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3mvTIxPSmJwpwbQbgaaXOh6A0fIjvDUqijmBzbNCxO4=;
        b=pQfRw3B00QDy0r5iPseb0SPXZ7jxQjjYCtOhapgz79eFwojMPmNx5lxR1Od5/3Xl/i
         VAFwOw8TLfJkjflY3KEZ3yqIltMH2f35n+CQ8npPR1fv1ujVh1qpM2P8sDu2oApmNl69
         5saeV3UHeeY05DS2RNblJebJ+3bMjo0nd6BH5tvbF7RtgfZR+fQpyqhS5IBOLqDafdu8
         erZlUSsIBueprP4c01fNNX63FO3k8fofZ+VRBQk2ZjPW7dPGzpUWb73ivoYJpMw6cV2K
         M81khKwI+TpN4yt4qBJ28TF0fhKIQQqA/J+yeLl64GLkaCB14iO0czz5sWdSkdiEKZq9
         uTFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkv+oeAVfWXPGK3Jn2Bl4dXdTUha1q3loX8c9nykViMR0riuhe3gaVaeJW7uVPZTVxgdy5w5fN5g/GIPIE0GoenKFj07pN
X-Gm-Message-State: AOJu0YzPrke/lo2/RLqzb4H9uK15Vmj+HCMDfb0bSgDUBHJzkt9cuiFw
	uMh0TeqL7BbdJXIhDf1Wh6AFpyRish7LZ3u7Pj4yxxtOCi2wUfFoiVpUsrzzS1aYtagi95pSu9Y
	zcWWaz0ONQw==
X-Google-Smtp-Source: AGHT+IGazckLk3Pwl6V9VPt6Ezu5m7Q9dWV4f8lkbH+BldGM2dI0dNz2Usjfw9fVbq4xk21+ZEdgPflAfaHkmg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:57d8:0:b0:609:51a3:b409 with SMTP id
 l207-20020a8157d8000000b0060951a3b409mr476379ywb.0.1709321869792; Fri, 01 Mar
 2024 11:37:49 -0800 (PST)
Date: Fri,  1 Mar 2024 19:37:39 +0000
In-Reply-To: <20240301193740.3436871-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301193740.3436871-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240301193740.3436871-4-edumazet@google.com>
Subject: [PATCH net-next 3/4] net: gro: enable fast path for more cases
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Richard Gobert <richardbgobert@gmail.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently the so-called GRO fast path is only enabled for
napi_frags_skb() callers.

After the prior patch, we no longer have to clear frag0 whenever
we pulled bytes to skb->head.

We therefore can initialize frag0 to skb->data so that GRO
fast path can be used in the following additional cases:

- Drivers using header split (populating skb->data with headers,
  and having payload in one or more page fragments).

- Drivers not using any page frag (entire packet is in skb->data)

Add a likely() in skb_gro_may_pull() to help the compiler
to generate better code if possible.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/gro.h |  2 +-
 net/core/gro.c    | 23 ++++++++++++++++-------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index 3c3666e46b3055caa619f2da0b6b8b20192a03b4..2b58671a65492bf3f9dabf1e7a2d985cee007e11 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -148,7 +148,7 @@ static inline void *skb_gro_header_fast(const struct sk_buff *skb,
 static inline bool skb_gro_may_pull(const struct sk_buff *skb,
 				    unsigned int hlen)
 {
-	return hlen <= NAPI_GRO_CB(skb)->frag0_len;
+	return likely(hlen <= NAPI_GRO_CB(skb)->frag0_len);
 }
 
 static inline void *skb_gro_header_slow(struct sk_buff *skb, unsigned int hlen,
diff --git a/net/core/gro.c b/net/core/gro.c
index 927ccf68149093d6dfd66a622a7db5215a483876..6a0edbd826a17573b51c5f71e20ff0c09364fc21 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -369,15 +369,21 @@ static void gro_list_prepare(const struct list_head *head,
 
 static inline void skb_gro_reset_offset(struct sk_buff *skb, u32 nhoff)
 {
-	const struct skb_shared_info *pinfo = skb_shinfo(skb);
-	const skb_frag_t *frag0 = &pinfo->frags[0];
+	const struct skb_shared_info *pinfo;
+	const skb_frag_t *frag0;
+	unsigned int headlen;
 
 	NAPI_GRO_CB(skb)->data_offset = 0;
-	NAPI_GRO_CB(skb)->frag0 = NULL;
-	NAPI_GRO_CB(skb)->frag0_len = 0;
+	headlen = skb_headlen(skb);
+	NAPI_GRO_CB(skb)->frag0 = skb->data;
+	NAPI_GRO_CB(skb)->frag0_len = headlen;
+	if (headlen)
+		return;
+
+	pinfo = skb_shinfo(skb);
+	frag0 = &pinfo->frags[0];
 
-	if (!skb_headlen(skb) && pinfo->nr_frags &&
-	    !PageHighMem(skb_frag_page(frag0)) &&
+	if (pinfo->nr_frags && !PageHighMem(skb_frag_page(frag0)) &&
 	    (!NET_IP_ALIGN || !((skb_frag_off(frag0) + nhoff) & 3))) {
 		NAPI_GRO_CB(skb)->frag0 = skb_frag_address(frag0);
 		NAPI_GRO_CB(skb)->frag0_len = min_t(unsigned int,
@@ -710,7 +716,10 @@ static struct sk_buff *napi_frags_skb(struct napi_struct *napi)
 		}
 	} else {
 		eth = (const struct ethhdr *)skb->data;
-		gro_pull_from_frag0(skb, hlen);
+
+		if (NAPI_GRO_CB(skb)->frag0 != skb->data)
+			gro_pull_from_frag0(skb, hlen);
+
 		NAPI_GRO_CB(skb)->frag0 += hlen;
 		NAPI_GRO_CB(skb)->frag0_len -= hlen;
 	}
-- 
2.44.0.278.ge034bb2e1d-goog


