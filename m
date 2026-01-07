Return-Path: <netdev+bounces-247774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD68CFF3C6
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 18:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B77F534C0D95
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 16:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3272334D4FF;
	Wed,  7 Jan 2026 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IcKoetNa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6EF34D4F2
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796105; cv=none; b=TR99mcW0kkqo1aFDQFJuQZyG2E1/8+wy6ag0CqVRfeC/1z6x74e2f7Ghdta5MuXZcfqWZ05D7CM7Hq1w1syHuTCeyXnzMzWHFwfOkw6WbS4Ob8XiZMjmUN9ZmfNETgYz+SUoZ2jHUqFdygQxws18475FM0Y6w0pBYF3wR2PgHm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796105; c=relaxed/simple;
	bh=WT/cVrduuTUnevhi7OdGjx/0N6WuyL4V30i0R0DiyjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VCB3/vYnA928+/jlz3NsNlZoRkyEJn8i6MXgEUDFXVz1jsXRfYhIOERgSJQjBW0QapkV/KbSYHRJxTX61t28cP5Bn76l2zU03H1B7lygX02yVk5kL2Yodw1K5RZlERKQn1BMiz0+GztRMpNy3V8X6W7rGBP5PKh57P3y0c0aOHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IcKoetNa; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64b560e425eso2890200a12.1
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 06:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767796102; x=1768400902; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2l2Lii3KJnfBvilvcH77hhKV1TnL2JWP++fNz6VDxQ0=;
        b=IcKoetNaky/nhIb9E//kwN7nJ9iLB2oG2C3XEU5BjsWWhT6Rm3tPXEqbXGKlX6Vgnp
         EeDN1FLRb1ACsW039Ps19ijy91Xr31G3/KtraDR44tBWIQmaFtKeoZZv0D7xclyGm8ee
         IStMk9+l+NabihjlkcIWjKo/XWA872f4vanRcrDgGQA1/K3H9oRZOwOAGhe0dWUoMrrZ
         HTMpx/5t5rlhjsHRyn2m1IjwIkUIF6ZO+Rr1+Ii8stfInllSn7rpN53Ppfwo0D1G/E6P
         RbPY4qVX403FpWtYp/WKT9obNZlSGJoILr7QK+k/61zQr/dGdEODThoxH3utbVz45HJK
         zQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796102; x=1768400902;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2l2Lii3KJnfBvilvcH77hhKV1TnL2JWP++fNz6VDxQ0=;
        b=dHQ0Btqm0FODCyAc/SGLmUE3YWW15A1lbOGhj6IsfYHcPRjlmhytFwL93aAvyjNM6i
         Lgl99flULy0q604H8fW2A9UDuXyVaZZzmIIXp/RKhPo8EECVZaSfncppiSM7GB5DUIkI
         CO7YnUxdgJy983vHwlZ4CuBclLVUj5Gj9fsLXJK1wv9fs7GZ9xNAtJi+VrkmtMjdHGTP
         C8inaF9MZ9LD76ra1dMIoQ48NObdZUDOyhEhlGg5VBSs8GfWaS0eLlrz5r5mpJENs3/2
         sPtLdtPKA/A8bZF8lmpGVtmic9t0XxB1Rw1ZWxqa2NXn5RnJDPQY7VmUSzrxDw6Qffj2
         DSGQ==
X-Gm-Message-State: AOJu0YyovEW1v+gsbixH3Pb2ZdTYhtkSmItzoaNyvzA8g1RiIhoiyEpS
	K5hhHgtskQcfx2rN19UWhhN/Wq1npYAc6B3kVbg5z1VMZHzhuRkc0+BHqmid2t4omJM=
X-Gm-Gg: AY/fxX6hpn75nhHFDGnnNH3HZCXX74bJnTCHl1sUz0nzMN6CVFOimLnVn2Zyxfj/ez5
	FdQnLBMNfkn/yHEHQQ9HFBtUE8MZRALK/hARqq8sVipXqIFmsmzXcrvy3U7jXgUGUF4kMAIPB7D
	rcbOH6x5KF23TzkYWHMX4MPjpKPiPuZgUv8PDnNpifFoJo26lohykssB5LY4DX80i2Eo+O/O0aj
	wC8XXMRz3zlo4RMdo/DUH7rQlKgBZjOd09jYTYlFZzFZYcus2TvaYX/S1LmENXeiN77B7i+u9aU
	oVQ1HJ72ID3rgtYqSerGeVcRkKyaZIaiVcwmuBrMEWmdrHhEOKqG2NCcF5bYT3GjLHo7G0+tS8e
	vBZY9HLfiO047g1sp3u1rCrQe9wmFImv6/wjqccZYjUnO6D2VcecLyF8PyICJ79LxtA22gRzubs
	s5SMgnxwtNd2PCftcpcTs2CLJ7rFSpdkKbfxvwBoOSUrxirUmMGGYzRJ64CSk=
X-Google-Smtp-Source: AGHT+IHj0rIlSxaqyqY5C9Li83/93PvHz2qjb3WAVIT1cRA9Z2cp7g9RrODJ3vch9OxbPuTGNJa4pA==
X-Received: by 2002:a17:907:3e0c:b0:b7a:1bdd:3311 with SMTP id a640c23a62f3a-b8445460d5fmr269562166b.62.1767796101595;
        Wed, 07 Jan 2026 06:28:21 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a27c8f3sm524117666b.16.2026.01.07.06.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:28:21 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 07 Jan 2026 15:28:10 +0100
Subject: [PATCH bpf-next v3 10/17] net: Track skb metadata end separately
 from MAC offset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-10-0d461c5e4764@cloudflare.com>
References: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
In-Reply-To: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 kernel-team@cloudflare.com
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
index 86737076101d..6dd09f55a975 100644
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
index a00808f7be6a..afff023e70b1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2325,6 +2325,7 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 #endif
 	skb->tail	      += off;
 	skb_headers_offset_update(skb, nhead);
+	skb_shinfo(skb)->meta_end += nhead;
 	skb->cloned   = 0;
 	skb->hdr_len  = 0;
 	skb->nohdr    = 0;
@@ -6238,8 +6239,7 @@ EXPORT_SYMBOL_GPL(skb_scrub_packet);
 
 static struct sk_buff *skb_reorder_vlan_header(struct sk_buff *skb)
 {
-	int mac_len, meta_len;
-	void *meta;
+	int mac_len;
 
 	if (skb_cow(skb, skb_headroom(skb)) < 0) {
 		kfree_skb(skb);
@@ -6252,12 +6252,6 @@ static struct sk_buff *skb_reorder_vlan_header(struct sk_buff *skb)
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


