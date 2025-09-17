Return-Path: <netdev+bounces-224202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C2BB8234C
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 00:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10FA82A84D2
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 22:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA41530F930;
	Wed, 17 Sep 2025 22:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWS5fyQx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4869C273810
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 22:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758149717; cv=none; b=t58noQoSSUDxUCaZ8xHt61Y18O8TJFkIrVKCgMtgMPm2jxDGFBagwIC+oFTnjlEvQoBk08puBq7MfPoGPh+Ssy/v4Fw8spXjWTvwSElVQ8GD+kenk/FfnRNMFPtMrZrNIS2n+pnZ4DsbllHSIm+QKQI9WeIv1mUrMaY24II7CKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758149717; c=relaxed/simple;
	bh=WTNdrTeER0WJaRclyj5OzZBh9204Z1ralvE7oTUt2x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/UiE1Vkh7xAyZlZS77Ni/oAx4lb0SFeoofIUM7RPVga6/sFjjoIIyQc2ROC89zs7wvkx8MDrMiM4Bf3BYXAcj+P+Djzh0KbLYkf/TS1IhKVOXkuShZ7l3F7Jd0jSkBd1hzY9HFQsCNPMlDoFTjX4O/z2s9CRZiR3wFXs8Zprfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWS5fyQx; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2445806df50so2864985ad.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758149715; x=1758754515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVw2gOE1ByhmTgXzMOgdyUwD8Ziv6injdIDrMi3HecQ=;
        b=YWS5fyQxiLPoTQMe0UJOghwK19eF/gjeiDQyMRXZv717eVw/llS4CnwSPyW1JPv1P2
         tApSy7z1Dfmn7YwJQ/KxzGyFjTGZ9YWI9oYBpNqWw8cBjj8aylpTCsCakuFO/TSRFgmn
         aa8SG4FgEVNqvFJQ0wX+AcZGUrb7AlH1fL5bl6FWgvV1ad4BLp7EWc/LXVgVifN0DpFh
         TUiXkJ/OQV6PQFLj9jyAF0pq2agpgozoYEQy1raRBGzPuLMV+osAoDnvtsfj2646Bzkr
         c42n7U5DuaLssELlT7490hgjp2MtVBxbLHSHMgSS1rz8c7kLFLfxNhkcxgQ5wRPmpqY4
         X8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758149715; x=1758754515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVw2gOE1ByhmTgXzMOgdyUwD8Ziv6injdIDrMi3HecQ=;
        b=A0urhQ2zoSf2KPXl+t2ad970F5uP+ADTDcSlHXA4GjUZrZt8sSZpgwUrgBnJdD5DRb
         6ImeTGi7yNBzeVitoDDYrbgu/8CKTF0+ITSWtBga1d4BVwTTxjxH7x40T92KyaRp84gb
         neLacUPUmAxCC6601nU5FZyxRvMzP7iHLZM+wmqRqsXykLBC2nb8iAyT3mCk3BT5f0MY
         rZKpWsAX5WbB6+XbYeHdQ5bQBLqE0WQT+sXtCtG3lFOibBLGDMbkzJrHP/4YvoMgFVcH
         x6iTgOSAFpAcSmeP0Rf/lo+HkwhsxWdUTkVG04XgKFOd8tG7X9AKHQjLiCim8KeLd4Rv
         nqjA==
X-Gm-Message-State: AOJu0YzgePugUUFJR+2ugtaQEC9wcGXiKcsNDoCHiUZOJVrRX4xXwwD9
	ifw+wM+lsti8VnvjDh9DqY80jVo+mf8phBW+EdvQuZAw2SjiOVeqQXOm
X-Gm-Gg: ASbGnctYXMBePoEfr9XJEtFU+fJnydk60FQUEnNNIUpSUg9x3p3i8kbJkBz+lbfTY8J
	nGJbb782+AE0tDqNRlrqzHTQ6W5bXzjQOtB/v3k+Vo8y6Z1hIJ/mO3epjMDjEibkRRDJUCHPOTw
	1jcIxwQJFv+HEuVkEEphTw2BzD0XF0DboGZh/Z17FreOejmTd3fjNff0ppXfapNceZ8eP0kgb2j
	oA/vpctBU4DwFmnVqQRG66ne+PWHpU+phaqSqy7yJjlKMeuAFZK5N6doYKuylK45C92HyDgdaWq
	GgrhmsF32SKn3eEhKyPTwdXqcLXC+0Le9X3w3uN9VY/V6ksGDaKtOPXO+Ma6ma8k0IH456JY6zC
	2moWYmEdwaF7dfsdfUijRnvd88BPMDwlp
X-Google-Smtp-Source: AGHT+IHc8fZk2MHpJEjrEov75SUzgIuaqNYdg4YfPUS1cSLMaEN72sj3O6nCrpgY9IzjPFwsxP3Yfg==
X-Received: by 2002:a17:902:d4c1:b0:266:702a:616b with SMTP id d9443c01a7336-2681228a5cbmr54505955ad.18.1758149715450;
        Wed, 17 Sep 2025 15:55:15 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff3fd7easm595211a12.30.2025.09.17.15.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 15:55:15 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	paul.chaignon@gmail.com,
	kuba@kernel.org,
	stfomichev@gmail.com,
	martin.lau@kernel.org,
	mohsin.bashr@gmail.com,
	noren@nvidia.com,
	dtatulea@nvidia.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maciej.fijalkowski@intel.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 1/6] bpf: Allow bpf_xdp_shrink_data to shrink a frag from head and tail
Date: Wed, 17 Sep 2025 15:55:08 -0700
Message-ID: <20250917225513.3388199-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250917225513.3388199-1-ameryhung@gmail.com>
References: <20250917225513.3388199-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move skb_frag_t adjustment into bpf_xdp_shrink_data() and extend its
functionality to be able to shrink an xdp fragment from both head and
tail. In a later patch, bpf_xdp_pull_data() will reuse it to shrink an
xdp fragment from head.

Additionally, in bpf_xdp_frags_shrink_tail(), breaking the loop when
bpf_xdp_shrink_data() returns false (i.e., not releasing the current
fragment) is not necessary as the loop condition, offset > 0, has the
same effect. Remove the else branch to simplify the code.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/net/xdp_sock_drv.h | 21 ++++++++++++++++++---
 net/core/filter.c          | 28 +++++++++++++++++-----------
 2 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 513c8e9704f6..4f2d3268a676 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -160,13 +160,23 @@ static inline struct xdp_buff *xsk_buff_get_frag(const struct xdp_buff *first)
 	return ret;
 }
 
-static inline void xsk_buff_del_tail(struct xdp_buff *tail)
+static inline void xsk_buff_del_frag(struct xdp_buff *xdp)
 {
-	struct xdp_buff_xsk *xskb = container_of(tail, struct xdp_buff_xsk, xdp);
+	struct xdp_buff_xsk *xskb = container_of(xdp, struct xdp_buff_xsk, xdp);
 
 	list_del(&xskb->list_node);
 }
 
+static inline struct xdp_buff *xsk_buff_get_head(struct xdp_buff *first)
+{
+	struct xdp_buff_xsk *xskb = container_of(first, struct xdp_buff_xsk, xdp);
+	struct xdp_buff_xsk *frag;
+
+	frag = list_first_entry(&xskb->pool->xskb_list, struct xdp_buff_xsk,
+				list_node);
+	return &frag->xdp;
+}
+
 static inline struct xdp_buff *xsk_buff_get_tail(struct xdp_buff *first)
 {
 	struct xdp_buff_xsk *xskb = container_of(first, struct xdp_buff_xsk, xdp);
@@ -389,8 +399,13 @@ static inline struct xdp_buff *xsk_buff_get_frag(const struct xdp_buff *first)
 	return NULL;
 }
 
-static inline void xsk_buff_del_tail(struct xdp_buff *tail)
+static inline void xsk_buff_del_frag(struct xdp_buff *xdp)
+{
+}
+
+static inline struct xdp_buff *xsk_buff_get_head(struct xdp_buff *first)
 {
+	return NULL;
 }
 
 static inline struct xdp_buff *xsk_buff_get_tail(struct xdp_buff *first)
diff --git a/net/core/filter.c b/net/core/filter.c
index 63f3baee2daf..0b82cb348ce0 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4153,27 +4153,31 @@ static int bpf_xdp_frags_increase_tail(struct xdp_buff *xdp, int offset)
 	return 0;
 }
 
-static void bpf_xdp_shrink_data_zc(struct xdp_buff *xdp, int shrink,
+static void bpf_xdp_shrink_data_zc(struct xdp_buff *xdp, int shrink, bool tail,
 				   enum xdp_mem_type mem_type, bool release)
 {
-	struct xdp_buff *zc_frag = xsk_buff_get_tail(xdp);
+	struct xdp_buff *zc_frag = tail ? xsk_buff_get_tail(xdp) :
+					  xsk_buff_get_head(xdp);
 
 	if (release) {
-		xsk_buff_del_tail(zc_frag);
+		xsk_buff_del_frag(zc_frag);
 		__xdp_return(0, mem_type, false, zc_frag);
 	} else {
-		zc_frag->data_end -= shrink;
+		if (tail)
+			zc_frag->data_end -= shrink;
+		else
+			zc_frag->data += shrink;
 	}
 }
 
 static bool bpf_xdp_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
-				int shrink)
+				int shrink, bool tail)
 {
 	enum xdp_mem_type mem_type = xdp->rxq->mem.type;
 	bool release = skb_frag_size(frag) == shrink;
 
 	if (mem_type == MEM_TYPE_XSK_BUFF_POOL) {
-		bpf_xdp_shrink_data_zc(xdp, shrink, mem_type, release);
+		bpf_xdp_shrink_data_zc(xdp, shrink, tail, mem_type, release);
 		goto out;
 	}
 
@@ -4181,6 +4185,12 @@ static bool bpf_xdp_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
 		__xdp_return(skb_frag_netmem(frag), mem_type, false, NULL);
 
 out:
+	if (!release) {
+		if (!tail)
+			skb_frag_off_add(frag, shrink);
+		skb_frag_size_sub(frag, shrink);
+	}
+
 	return release;
 }
 
@@ -4198,12 +4208,8 @@ static int bpf_xdp_frags_shrink_tail(struct xdp_buff *xdp, int offset)
 
 		len_free += shrink;
 		offset -= shrink;
-		if (bpf_xdp_shrink_data(xdp, frag, shrink)) {
+		if (bpf_xdp_shrink_data(xdp, frag, shrink, true))
 			n_frags_free++;
-		} else {
-			skb_frag_size_sub(frag, shrink);
-			break;
-		}
 	}
 	sinfo->nr_frags -= n_frags_free;
 	sinfo->xdp_frags_size -= len_free;
-- 
2.47.3


