Return-Path: <netdev+bounces-225423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244E2B93968
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 01:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCE9D2A0AEC
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 23:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E852FD7B1;
	Mon, 22 Sep 2025 23:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpDM9RQb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D3A2882BD
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 23:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758584042; cv=none; b=oWxGQtY96zaPAHN3auEMbqel9hJuYs12b6HhNqcxhvGk/QIt8mxMy1wOkKNC4946HunY81IG0cvZKRpcM1jNhEfmUZvyk9t8zLFQOrb8aEO+e5PzIPUK/FwmGFH0whz0R8jA0J56287ppAFHL/Xxi+04+jbyBnPJj6B/Vq2YrJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758584042; c=relaxed/simple;
	bh=QT1OxvFzYMzM6OcwsqTEVAKPvIGo14cYjHyx6pUnodg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNJWlbpsI/aT9+MthwxGzDV7e//eYxTvkSNOAbe72znMgNMEG7iUBEoIMHLN9U6NNS4oRW0K2enXKW9xA5bNTm4Po3pCeM3AzVKJeoSoyEu5nkaAMNqcVuE0dJpIba+69n7aO4X0mXBX9iQtDbl8BWyglUO9BuXIM6D57bnZiJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpDM9RQb; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3306d3ab2e4so3912769a91.3
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 16:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758584040; x=1759188840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBj+8VmMwExg8fdqUUrm8/QTD38AlKZkUFapbcBKrsI=;
        b=JpDM9RQbVdNdqiVfgow5+q2sHO9raXfPFqR1+muk2eoiH4qQcd/KTJR49sCYd4PRh6
         pvp/J2I0UVucg/1s3NNk0NLd9DrMdvFVkr36l6ybJaJLrQg5D/TAcx+wT37isJQV3TsE
         tUsOLNl5hluux0Ggt2KxomW+r3y550F02hjf3Lk5kN/++qSmA8VoHWo677Qz/fMK8OUh
         wN/gUlyQk17svedHhT5H7T5xvLdXCNoIMaCHCz4376nwBqKOy+wxb8DLgUljJ9EQyuRP
         rbV/5Na7UISjLsIyzXdyCCjzpt925JVQ9KzAgsN5YmKQm5CcK+8TrRRG0WqROY1KV0oe
         agSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758584040; x=1759188840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBj+8VmMwExg8fdqUUrm8/QTD38AlKZkUFapbcBKrsI=;
        b=M0Mfz7+owL5a/y6jcSMtWNgYfHmVnCPLDZE4eeLIAdTaZODIC5ttiQbnUMLVpXdiIX
         nqgAfOLti4JLafQhXWDBS1f6n/WY4hXEoiBHOb7uQI9b+71FjQMWBWvBQxbh5Y4asoKs
         ETA1vzUvS0PPUbRYEOBfLMa8juNLSFxxWTxgv+XL+Glw05APBaXOVSbtFoiQ4wy3ULDs
         1nogLw7LT5ii3pbig75gVtlThvDqGGNfLkA2ldvn9tmc/TklmmY+cTFBgH2h8sVEY+az
         525Oz8gKJLk0yWXV4cYV7qpy5goBSU5tC383HAZRB4qGY3cnW6jpUVv2p+56xc24Q5Y0
         lEig==
X-Gm-Message-State: AOJu0Yxj8UFDpPS7BUxbULlXNooFMtb1utR6lXmNNM2p/dcZW3qQFoEL
	qqa3JPsg+WfjbMXvvuMrorM4rkn8l/h0csl4lH0DCLxHPn4Ua9S1j/b5
X-Gm-Gg: ASbGncuWyf+K+ojlB3MasOmIfCz3iAh6TTz8g+1wRHn7GZMgwqTi7oDFRUgdVI04SuP
	Uzay7kgW8Po7VRGfJwx0bF3efWa30cCeQX0eS65xi76DWrDun2XcWHKMCRgKeRBTbPxqAmYTbW6
	8/DHgazlhuBd02PsrZbLAXJGlv9ax4IP0CQTe5lIex/UW07yFCeMzSXhGrhxHwkR1LrGAs7q7mC
	hOk2dv/9CH+MVSmT3EjU6PNVdUetlOewtfsHi3QWtSrW3YQfUVOD1RgrZkMGM1A8PLx+itDzrb6
	IZz56FhuVtEfh9FSWjA7aiRFINWuBBry8EDroZ5i2Y72T3JIc7MPcMWMA+plb0Flp1XvNOXSWlJ
	A5686dvBwXJjiOg==
X-Google-Smtp-Source: AGHT+IEeG1u70MWIN99s7lDb54fcmLQILv2BTIbWtuUQ2vqyR+1P6LuGkETyMKGFgriMkEsFYF3Myg==
X-Received: by 2002:a17:90b:1cc8:b0:327:83e1:5bf with SMTP id 98e67ed59e1d1-332a95b7a74mr616956a91.28.1758584039677;
        Mon, 22 Sep 2025 16:33:59 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:49::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f4d204aa7sm1467595b3a.44.2025.09.22.16.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 16:33:59 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 2/8] bpf: Allow bpf_xdp_shrink_data to shrink a frag from head and tail
Date: Mon, 22 Sep 2025 16:33:50 -0700
Message-ID: <20250922233356.3356453-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922233356.3356453-1-ameryhung@gmail.com>
References: <20250922233356.3356453-1-ameryhung@gmail.com>
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

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/net/xdp_sock_drv.h | 21 ++++++++++++++++---
 net/core/filter.c          | 41 ++++++++++++++++++++++----------------
 2 files changed, 42 insertions(+), 20 deletions(-)

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
index 5837534f4352..8cae575ad437 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4153,34 +4153,45 @@ static int bpf_xdp_frags_increase_tail(struct xdp_buff *xdp, int offset)
 	return 0;
 }
 
-static void bpf_xdp_shrink_data_zc(struct xdp_buff *xdp, int shrink,
-				   enum xdp_mem_type mem_type, bool release)
+static struct xdp_buff *bpf_xdp_shrink_data_zc(struct xdp_buff *xdp, int shrink,
+					       bool tail, bool release)
 {
-	struct xdp_buff *zc_frag = xsk_buff_get_tail(xdp);
+	struct xdp_buff *zc_frag = tail ? xsk_buff_get_tail(xdp) :
+					  xsk_buff_get_head(xdp);
 
 	if (release) {
-		xsk_buff_del_tail(zc_frag);
-		__xdp_return(0, mem_type, false, zc_frag);
+		xsk_buff_del_frag(zc_frag);
 	} else {
-		zc_frag->data_end -= shrink;
+		if (tail)
+			zc_frag->data_end -= shrink;
+		else
+			zc_frag->data += shrink;
 	}
+
+	return zc_frag;
 }
 
 static bool bpf_xdp_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
-				int shrink)
+				int shrink, bool tail)
 {
 	enum xdp_mem_type mem_type = xdp->rxq->mem.type;
 	bool release = skb_frag_size(frag) == shrink;
+	netmem_ref netmem = skb_frag_netmem(frag);
+	struct xdp_buff *zc_frag = NULL;
 
 	if (mem_type == MEM_TYPE_XSK_BUFF_POOL) {
-		bpf_xdp_shrink_data_zc(xdp, shrink, mem_type, release);
-		goto out;
+		netmem = 0;
+		zc_frag = bpf_xdp_shrink_data_zc(xdp, shrink, tail, release);
 	}
 
-	if (release)
-		__xdp_return(skb_frag_netmem(frag), mem_type, false, NULL);
+	if (release) {
+		__xdp_return(netmem, mem_type, false, zc_frag);
+	} else {
+		if (!tail)
+			skb_frag_off_add(frag, shrink);
+		skb_frag_size_sub(frag, shrink);
+	}
 
-out:
 	return release;
 }
 
@@ -4198,12 +4209,8 @@ static int bpf_xdp_frags_shrink_tail(struct xdp_buff *xdp, int offset)
 
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


