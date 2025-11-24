Return-Path: <netdev+bounces-241216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A56F7C8191E
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66003AD23F
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 16:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0047F319867;
	Mon, 24 Nov 2025 16:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="TSiPbOA2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C733161AC
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 16:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001765; cv=none; b=gvLO2ri+rSKW5fU9wRnS2uqf1IgnGLdkCxdR+3MzPClLsIzkOynM1dlO0IMbncxed0cIbxIZ24I4rWD5PNXfUgspgcbwL19x8rlB6HGAcOo12CmgHwPB35Rk9rmfOlwld/j7Uxcl+3JHl/utop5qjW8ge5xG3mLErdtkCvZ8Sys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001765; c=relaxed/simple;
	bh=Wyp2c7afjxG5aRTuOcbLGQJv2HFkqYrJUx3yuysNroE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lmZ8O3lhjJlxbuPQPcyNbHPEDr7BYdmeL/B8ku/wKbAIo9Vj/xeU0ugWIK4AS4gYBZSFbQqnwfmNXarAAHGjT4CRwSWoUyM6r6TMdxyV1XGWYw7cj1BQJ6NMqNKD1Wq9a0EGLeRhF3UoeIzKkKEOj/KHmpo+Gpub1AJa6hDlluE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=TSiPbOA2; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6418738efa0so7006329a12.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 08:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1764001762; x=1764606562; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I2sSFInHlM/AK58dJylVSwye8HIxOazaFEZpX6BWWww=;
        b=TSiPbOA2D4pvC7IMekL4qmuBjPjVyKV/hZhUZhxZiVz7tAjwzqF/9uSHP0oB57Phmc
         DwfaVdu8NZGUHYe1L7DcQyxpHWB9RZI56CaAqgF554iEZC5pzfHtHn5rrnuqhI7hjGj/
         my5y17hrXhfrSWrxEAK/tkB2JuoDZp6Rne1CfBpg+0VB6WZBqCjzADU70hSFs7kaNcHg
         8w7ijnrbKKcJzfimSt5abQs5SD5aNx2Nznl8ul3kIPShMPKJmTFICsV20FdwNI12I9bQ
         dxbVx1pAMXo1/gPwoPK2oOw9SpyhLHy0Ays1WJr0ipEXBdeLY6ReaI7YtMg0m7CPEhjR
         WE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764001762; x=1764606562;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I2sSFInHlM/AK58dJylVSwye8HIxOazaFEZpX6BWWww=;
        b=CddcBLEoHOGKlvS4HVnXYBMYW/PThIhPIdRdfIM//S0yBw4wQGlr9buk3ytyTXU+5v
         RgQ+lxQXTFlCrGY/fdjqVlqrv5vJZArqBZvCjhFI+1VUoBzSoHHOjRftsKex4xUe9KqY
         y3oK9TxqVQgqR0QVlA9Qs/JtX+3askZu9Ck+zId/ZLSAN00KYxeNnmUZp/ALMSF8BNg2
         bvBcz9jBrp34/TmfRDm5VMrUmuWq0yl8IdzeL8WvXRejj3gRb1vatAJuzPpGL0t9M/1D
         Q1feIA4oc5w8AKcMIMg6y5Tq/3sqQ9fwR5daN4OUdjXHPsZKkkua8Ht8FKILFG0uoIAZ
         mZDw==
X-Gm-Message-State: AOJu0YwEOXenTgQKtOqJhABhFfbH9NB22akq5OiiEu7WSjXTsO0jMsqU
	wFdwZKh8yGyKDkYhLUvklu+Ln3ndFrIbFChr0kTHqanu8J3GJyg70+jsljMefEvgxB85qZcrj4G
	PnwI2
X-Gm-Gg: ASbGncs7+XiQGBv1Jg+mQmp8OF+Lg8ohoXM4NPonnTV2LJzXHSZVP32Wa5LrNdrcPHH
	wB9yx3E9TBzE8tL8dRWNEV5tmmZT/s4rbsV1IRr1fBROoIwLfuw1FxFCPimuWuGi6BMi11eUxMJ
	L9V8uL9OYT+Hf/yIM4ZSYrkqVZMceHA10tPdhh+Ocrd3Rm78VT7V8XyOsjMn2gMFfu9Tj8P8dpK
	MbyoQyodvdcVihLkoS9iX3BmpSHo/+tpoJyOvm5x5jpDy3NIDAtncO4Zc7xuUemjwsb9GWfMlbU
	UIIgwe/h3g2WPgYXCgPquELPFrXOpzHM5hmd442TXrX+G0o8CQRuEn46CwnAYHFWiSpdFkI9dwE
	q5zdlDzetJVA6dPZTObcgTDUVceFWsy4QCRQlnqjHyHl5r9KUtkmf5xGJWcjxvOwTff/lju730c
	JPzutY57NwwjSWoRMPfIKa9SIE4m/Z8LVR2UVZNb2e90+Vsjcitju05t088xlv3+vjlqk=
X-Google-Smtp-Source: AGHT+IE7ZcnenAoJ8luw8qF0IF2vkCOG/KRUrnzomrLYF/000Yko9RSYdTSLc3bTXcV0GQAy8lbDXw==
X-Received: by 2002:a05:6402:2787:b0:641:2a61:7da2 with SMTP id 4fb4d7f45d1cf-64555be1db0mr10896236a12.17.1764001762368;
        Mon, 24 Nov 2025 08:29:22 -0800 (PST)
Received: from cloudflare.com (79.184.84.214.ipv4.supernova.orange.pl. [79.184.84.214])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-645363aca03sm13481816a12.3.2025.11.24.08.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 08:29:22 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 24 Nov 2025 17:28:46 +0100
Subject: [PATCH RFC bpf-next 10/15] net: Track skb metadata end separately
 from MAC offset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-10-8978f5054417@cloudflare.com>
References: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
In-Reply-To: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: b4 0.15-dev-07fe9

Currently skb metadata location is derived from the MAC header offset.
This breaks when L2 tunnel/tagging devices (VLAN, GRE, etc.) reset the MAC
offset after pulling the encapsulation header, making the metadata
inaccessible.

A naive fix would be to move metadata on every skb_pull() path. However, we
can avoid a memmove on L2 decapsulation if we can locate metadata
independently of the MAC offset.

Introduce a meta_end field in skb_shared_info to track where metadata ends,
decoupling it from mac_header. The new field takes 2 bytes out of the
existing 4 byte hole, with structure size unchanged if we reorder the
gso_type field.

Update skb_metadata_set() to record meta_end at the time of the call, and
adjust skb_data_move() and pskb_expand_head() to keep meta_end in sync with
head buffer layout.

Remove the now-unneeded metadata adjustment in skb_reorder_vlan_header().

Note that this breaks BPF skb metadata access through skb->data_meta when
there is a gap between meta_end and skb->data. Following BPF verifier
changes address this.

Also, we still need to relocate the metadata on encapsulation on forward
path. VLAN and QinQ have already been patched when fixing TC BPF helpers
[1], but other tagging/tunnel code still requires similar changes. This
will be done as a follow up.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/skbuff.h | 14 ++++++++++++--
 net/core/skbuff.c      | 10 ++--------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index ff90281ddf90..8868db976e1f 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -595,15 +595,16 @@ struct skb_shared_info {
 	__u8		meta_len;
 	__u8		nr_frags;
 	__u8		tx_flags;
+	u16		meta_end;
 	unsigned short	gso_size;
 	/* Warning: this field is not always filled in (UFO)! */
 	unsigned short	gso_segs;
+	unsigned int	gso_type;
 	struct sk_buff	*frag_list;
 	union {
 		struct skb_shared_hwtstamps hwtstamps;
 		struct xsk_tx_metadata_compl xsk_meta;
 	};
-	unsigned int	gso_type;
 	u32		tskey;
 
 	/*
@@ -4499,7 +4500,7 @@ static inline u8 skb_metadata_len(const struct sk_buff *skb)
 
 static inline void *skb_metadata_end(const struct sk_buff *skb)
 {
-	return skb_mac_header(skb);
+	return skb->head + skb_shinfo(skb)->meta_end;
 }
 
 static inline bool __skb_metadata_differs(const struct sk_buff *skb_a,
@@ -4554,8 +4555,16 @@ static inline bool skb_metadata_differs(const struct sk_buff *skb_a,
 	       true : __skb_metadata_differs(skb_a, skb_b, len_a);
 }
 
+/**
+ * skb_metadata_set - Record packet metadata length and location.
+ * @skb: packet carrying the metadata
+ * @meta_len: number of bytes of metadata preceding skb->data
+ *
+ * Must be called when skb->data already points past the metadata area.
+ */
 static inline void skb_metadata_set(struct sk_buff *skb, u8 meta_len)
 {
+	skb_shinfo(skb)->meta_end = skb_headroom(skb);
 	skb_shinfo(skb)->meta_len = meta_len;
 }
 
@@ -4601,6 +4610,7 @@ static inline void skb_data_move(struct sk_buff *skb, const int len,
 	}
 
 	memmove(meta + len, meta, meta_len + n);
+	skb_shinfo(skb)->meta_end += len;
 	return;
 
 no_metadata:
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4f4d7ab7057f..7142487644c3 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2306,6 +2306,7 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 #endif
 	skb->tail	      += off;
 	skb_headers_offset_update(skb, nhead);
+	skb_shinfo(skb)->meta_end += nhead;
 	skb->cloned   = 0;
 	skb->hdr_len  = 0;
 	skb->nohdr    = 0;
@@ -6219,8 +6220,7 @@ EXPORT_SYMBOL_GPL(skb_scrub_packet);
 
 static struct sk_buff *skb_reorder_vlan_header(struct sk_buff *skb)
 {
-	int mac_len, meta_len;
-	void *meta;
+	int mac_len;
 
 	if (skb_cow(skb, skb_headroom(skb)) < 0) {
 		kfree_skb(skb);
@@ -6233,12 +6233,6 @@ static struct sk_buff *skb_reorder_vlan_header(struct sk_buff *skb)
 			mac_len - VLAN_HLEN - ETH_TLEN);
 	}
 
-	meta_len = skb_metadata_len(skb);
-	if (meta_len) {
-		meta = skb_metadata_end(skb) - meta_len;
-		memmove(meta + VLAN_HLEN, meta, meta_len);
-	}
-
 	skb->mac_header += VLAN_HLEN;
 	return skb;
 }

-- 
2.43.0


