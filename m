Return-Path: <netdev+bounces-232975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5366C0A966
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 15:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44A6418A0648
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 14:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5F6248F5E;
	Sun, 26 Oct 2025 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fPmkFDOI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8E12E8B91
	for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488330; cv=none; b=a0A1E5Dn490k1llJ1bDoggKnzRNgfsHu6+BIlGB4p5Eld34h+1G3+yvSpFKCczbBNpZhLAFCSFrOL6frOfvo4i9YWcz+qzxxk5jC0k0GNWOjjUao6jFC4UoQqOjO0lghZ71oyjS1jT+yvrVBPm7OLYspEKe5t3+0VedxLnfudyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488330; c=relaxed/simple;
	bh=NUm71Zd06KWl3P+QfPX44GSmHRrTuDkrZCYwhisbxYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tKrKM5UtnP9q2uVLOnSoI4RsE/+0iHUDcwgg7ZLnzBjgXXFaYEe+Gzkn+q4gTC+tr0gWkOWo+Kf6zQ0KPDvP7+bwSmkVycw8fwcvvNYC/kVCvO6hMREb/KnNJkHQIy88+qr0KIgY0pO/hp4cY3a617ovxj0NIUuLGzrkYGuZBl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fPmkFDOI; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-63c09ff13aeso6463326a12.0
        for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 07:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761488327; x=1762093127; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fGSfs1QWwD7Mhp32E/45KeY7GB3oXHAdzAqWdM10vmo=;
        b=fPmkFDOIJC06yyFfkNNuSMcQRxSGyR1qnvFthFZ4L+c+lgFOB0Dp2inoiasNymWh94
         adwvvGeeatr6XKVsNAqKL+VlVDQC0bRueW7gUW9PRB0yNU5Q69uO+EMpuewaBuSccQeR
         THurK73aaehXRAiJFw3GCbgnhsQr5+iXTAD4jNDYO/VPk6KfLGeeLcqkiJREp74ZEm7Y
         kse11I7Rg6Q3iYVRFxlsDH8BAKx7ESI2yu8bTJyAmOpEvVwrUTtd8gpgimPijF+CD7sz
         /jnUVN77v2DTMFcQbtvpJjgLp8xX486JVs+2E/afuNVerfBSK5DjvhRfKFaeDQXBzNtG
         B67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761488327; x=1762093127;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGSfs1QWwD7Mhp32E/45KeY7GB3oXHAdzAqWdM10vmo=;
        b=Q9lZah2iOuwW7g2YQ29rRCYtRySuFfglhzUYE1HB0BmKcYjBr7oMiEk4sbUpP00G8f
         ny94RiPTMkWPmUSVt3pBExsR2Vy+y72lO/sxdq+qt6aDfh2nU66RAqNod4RHLGm7hjwB
         o1EqcdJ91mEHJXMF2W0tDBoXZL0aoOyx+yGRgWdQIIk7zMDaBxWx+vHvjSF+Ll3BdRhz
         2ubyGq7ANCvNx3N4qSTS0v26PRWQRQmsvSxfvpOWjiWfN7WXuheZ72Senuci/QUD8qo5
         Mu+6h091jTd51A8bSZlQvD9Iz65JHu00lEeBCvX+LZJJ4t1XLJHdqT/ULZi0wfS+vyEz
         IWQA==
X-Forwarded-Encrypted: i=1; AJvYcCVhih8QqQeOZs5iE/uIolKd243+HKqN6HN/dd869rh0I7NYpNBSWY3kC8JqYW4wdHQXnoZvJZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc9Qg9vPtJTuqE46gL8Vl9KPD+bHzVsqvwPy39Hc6Jt6gS+zS5
	/z7SAhOGmhpVKdgNEPh5xcRz+gUKZW+R6Wiayu+Lm389NNTN/kRQY9WdLnEAfTaEMAA=
X-Gm-Gg: ASbGnctRq0mrfUAL1vIYanJP3VwKAbgom5puAHhWbfw3zUu605cAd1o7MYz/eNq5qQQ
	Yl/T351vRBzsqKNVcKccexE2gt+yZaG1fk26D08CI8Skjn0Dfigt7bJ0conAsfNDCI7SSw9TX/V
	rFMjCu8euUur5aSFJXzGdwPAh6JynzLktTIJrID2BkmDgryS0ldOwd26KZJ7KlU6J8NGV1JXlYi
	BRbF+NNeYhMyvimSZQGOaVRxV2O1HkjOazvgxINuODTpmkXtCz+UmUJpvVXsBTMWj5kLEvw87OX
	Rvw2cD5E/O9bUT7JAj4nf8pi6SXD07D9i35t5SuZE25i3k8Z4AUdc63mkV5ZhSQ31Y8vfZfFPeH
	AGj5XCwb0XQO9OwcFtlDRSKYSNvSAYhveiFgjhFQ98ZttOIEHVQsKXGCVN82dqFxekFLghu6C6g
	Q2y18JyQTfhVI5CIGkzYG8d4w6uhK9OkpkPJSBKS2rbu/Ww/Jkb7jUg9FH
X-Google-Smtp-Source: AGHT+IFFI9U+/Suj+yHm3motfX0Z0XGy9zKAbiB0+/BAugyFmb1KJIT+GfugeSh4FBo8SVcINKX47w==
X-Received: by 2002:a05:6402:40c5:b0:63c:1e95:dd4c with SMTP id 4fb4d7f45d1cf-63c1f6cea34mr35300386a12.27.1761488327412;
        Sun, 26 Oct 2025 07:18:47 -0700 (PDT)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e86c6d7d3sm3526544a12.27.2025.10.26.07.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 07:18:46 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 26 Oct 2025 15:18:27 +0100
Subject: [PATCH bpf-next v3 07/16] bpf: Make bpf_skb_adjust_room
 metadata-safe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251026-skb-meta-rx-path-v3-7-37cceebb95d3@cloudflare.com>
References: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
In-Reply-To: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
To: bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

bpf_skb_adjust_room() may push or pull bytes from skb->data. In both cases,
skb metadata must be moved accordingly to stay accessible.

Replace existing memmove() calls, which only move payload, with a helper
that also handles metadata. Reserve enough space for metadata to fit after
skb_push.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/filter.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index a64272957601..80a7061102b5 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3260,11 +3260,11 @@ static void bpf_skb_change_protocol(struct sk_buff *skb, u16 proto)
 
 static int bpf_skb_generic_push(struct sk_buff *skb, u32 off, u32 len)
 {
-	/* Caller already did skb_cow() with len as headroom,
+	/* Caller already did skb_cow() with meta_len+len as headroom,
 	 * so no need to do it here.
 	 */
 	skb_push(skb, len);
-	memmove(skb->data, skb->data + len, off);
+	skb_postpush_data_move(skb, len, off);
 	memset(skb->data + off, 0, len);
 
 	/* No skb_postpush_rcsum(skb, skb->data + off, len)
@@ -3288,7 +3288,7 @@ static int bpf_skb_generic_pop(struct sk_buff *skb, u32 off, u32 len)
 	old_data = skb->data;
 	__skb_pull(skb, len);
 	skb_postpull_rcsum(skb, old_data + off, len);
-	memmove(skb->data, old_data, off);
+	skb_postpull_data_move(skb, len, off);
 
 	return 0;
 }
@@ -3496,6 +3496,7 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 	u8 inner_mac_len = flags >> BPF_ADJ_ROOM_ENCAP_L2_SHIFT;
 	bool encap = flags & BPF_F_ADJ_ROOM_ENCAP_L3_MASK;
 	u16 mac_len = 0, inner_net = 0, inner_trans = 0;
+	const u8 meta_len = skb_metadata_len(skb);
 	unsigned int gso_type = SKB_GSO_DODGY;
 	int ret;
 
@@ -3506,7 +3507,7 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 			return -ENOTSUPP;
 	}
 
-	ret = skb_cow_head(skb, len_diff);
+	ret = skb_cow_head(skb, meta_len + len_diff);
 	if (unlikely(ret < 0))
 		return ret;
 

-- 
2.43.0


