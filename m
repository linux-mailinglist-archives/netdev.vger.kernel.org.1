Return-Path: <netdev+bounces-235983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B7CC37B14
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 21:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6971B3B9BB2
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 20:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B571234CFB9;
	Wed,  5 Nov 2025 20:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="bssxiGi2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD27234CFA8
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 20:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374003; cv=none; b=r5BM277VicgV4kRwNW3y2e4zI1xHXIiVev9euzbblrw3QX3DU7XG3+f544sOX17HGdH9oEsZFwd6BzaBAqagktZ4w6gyJu8F676zEUluxZGArQeoj4KyBLHhBvnU8AAHL/v7GkU5slxP0sHfNqdWDi4QdVXxRPZlg+eL6cLuDGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374003; c=relaxed/simple;
	bh=Upet9p7Umb0vqSABysuFrGIKwxYWkwAicwYLyrO3MZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LlXTILPPq1MURfaivysFxe066FPhWsJUs1CpFYWM6u6/dHMFEh1qGJjkKUdF9krMdRk+IBagS+9TLVWgord6G6k9kCwkcRHEUpxPPxlQqIdlZaYdp2j1xN2hSW9ecXgUzrGn9Rg6L5wkSr9b/AHKpF04ot27JpQwoT+W0gtIlO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=bssxiGi2; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6406f3dcc66so330870a12.3
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 12:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1762374000; x=1762978800; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X55o8uffTuoHdCM7ovllE5BsVFypUxba13AdZvH4Yg8=;
        b=bssxiGi2OkwG+1itQ9FHprpjjqoCdDWNKjzf16RxoEblVDo/IVrd2Rja008OVlGRqv
         uDOW0Zjtvac0qvqdbozR4pMtZKbbnG/IBJypl94YwxeuvFRhBigWwlBTmAFgpd08Ub3A
         bnxVB75XajersOHA8Gpe10EmjR5tZffWv5rOOzl90NAU0Bw9Mvtn/fjisC2/2jhmh4i3
         raRgWRlTW6NrzF3IPeKRDXBKyb5mpvivd0m54s0OaJMkCS3I5I25JQ2ysRDS9prjqH8c
         uWSMioPFbhw+rgEAG8PesNUFEmP5R5xP9wQanU+dAJkVb4aH4v1GFeX06bAAa4URkUVJ
         yyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762374000; x=1762978800;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X55o8uffTuoHdCM7ovllE5BsVFypUxba13AdZvH4Yg8=;
        b=T6QhsbMV18NTSUOCqQ6akGqUED6PozwjSU2aGbgWo+Ok9FuGsTpOFi1pklsxNXkudJ
         GGBRfks7GfMBZtTlu4J99hwhCwnlz9XtaLcwq85gGbZJHh+wVTrpS8F3wuq1aejUdERy
         viq/VM++qKuO0u7t4i2Hqv5ctsKOntLC+XduJ7auTTmordN3hsq6wKl7OLl3nNfaWBfj
         ClQjTqPaHoVGUwmVXkFZpmS9xoec9BdKG9YYaVy5HtzFWoxlOxIqj+V5TbwCiMePC51L
         rhB5lREZ7qDdiHr4QrGxH2xcWWr8y3t134xwDTLoiUHbu8tt8ZWvplohFvqbj8DDvAuz
         C8nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXooZYwtu7cpCSs5JGq0TI4/2s3QiFadgVjolWamACS93EWytvwGcdZxXEc3ZK25hTAgfNj12M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoQw6XCJzwSOZLOqqn56+tZrYBkyI/N7n0Xue8ED5wAII9+ljt
	jO0gNnS3Y4SOevg74xCmThQSurjPU34WZK0R1JtEG+t5VtlbryK6T+V9itoXhdxR0lo=
X-Gm-Gg: ASbGncs3V4s7N7Vp9Alqu7Engqj9/ULm1RCLslq2cuITlRLxxEGBMavspAGkh8kAMnF
	jGdxxuZCfwzKJRj8FGGmSrx/u0AWdxdSsYy6MvhFOU9aLeCSEjkdUssqFZgr7u4eGhXy+19NyQC
	UKwwOqrMKoj8pSppbiVKnZKVcF8toZsuzhlSxa3SuxU4oVRh7L4J+o+m1WPjCWMXy3br+qx11Dm
	IK7dUhTQim4MGvhrzjCc//50TQVNRPHnqJ1R1tITDAWr5TQ2HfKOvHxVJ6VUjlFijRedCtk8X8Y
	UFRlrGrq1wsYiGTqXyQohQglvsOal+Lyv/OWm9jtZHb6+Z8oWIBOgXDHK011KzSSDOKhloh4alW
	xB3tRoLbakuYNapEtMos8kdtnkf3y6xkTrq2poob++TCrQfhJoEt/H5ICNyX5NL/JuDpUAP+fMV
	Hc6fUekj6VcVtIy9eOMtpWW/KbWDU3+NaxkxcNlJkQ6Sv8cg==
X-Google-Smtp-Source: AGHT+IEeYrYl/OAh/p1kXCZz9B2usparRxxtEyJ5l71YSfRdwcIDc+ZFpw7Om2A4L5Q5XP5Kp+Movw==
X-Received: by 2002:a17:907:94c1:b0:b6d:6026:58da with SMTP id a640c23a62f3a-b72654e25b7mr469640466b.34.1762374000017;
        Wed, 05 Nov 2025 12:20:00 -0800 (PST)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b728937cc82sm45038766b.21.2025.11.05.12.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:19:59 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 05 Nov 2025 21:19:44 +0100
Subject: [PATCH bpf-next v4 07/16] bpf: Make bpf_skb_adjust_room
 metadata-safe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-skb-meta-rx-path-v4-7-5ceb08a9b37b@cloudflare.com>
References: <20251105-skb-meta-rx-path-v4-0-5ceb08a9b37b@cloudflare.com>
In-Reply-To: <20251105-skb-meta-rx-path-v4-0-5ceb08a9b37b@cloudflare.com>
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
index 96714eab9c91..370ddc61bc72 100644
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


