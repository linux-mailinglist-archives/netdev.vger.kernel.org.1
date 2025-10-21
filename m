Return-Path: <netdev+bounces-231262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9059FBF6B17
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 15:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A40955035F0
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 13:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6E7336ECD;
	Tue, 21 Oct 2025 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyk2OnHH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3C61096F
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052366; cv=none; b=thxuHIvOTTKSYgRCOtW0SL6FrZs6RxTotWFe3GloLfMOMboYKcvXAKpCjDjIehOmtfMrMKS4rPohWJyQ01Abs3TeFFklkDgFuJ8vWZUWPOlIzBH2m4i2MNQZLqCR3NpvSaSG6C8SsmaYkqxuc5fDG0FPc4wLZGNor2x9cOB9GVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052366; c=relaxed/simple;
	bh=et6B9jpYWtCzdXVd+olRhHB34fm5eTa7Z2yaMlv8P8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B/As9+roVqYKoeI+F/MSI+JTijziQCe3tBR5ZsO2Rmb6KfAERZEyBwCmlKHaIcx7Eow+DE+TP4lqli0X/BScMQL2gk9AMvpQbCkUWa+nNNPj7YT10Q6AEBPmyiXrykBXzaN3Bog6OAUTm+5LmROykHFqVJ3upnS+k2Lt8TdTs5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyk2OnHH; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b6a0a7f3a47so5183683a12.1
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 06:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761052364; x=1761657164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYks9YiGVI8btVCzGqfhMQ1rij+nkpQpVNndbIX1uww=;
        b=iyk2OnHH+5qbJVUaztqoDol/kSAempvvlxoHdlOCK6ru9u99cUVxJ3MYdZI0OUn7fl
         +7WFpBlUh4yN4qT5/rHmWvCjA0ImiCcIbt7COq2FJai1iRJNknmJi2lWzfeg6wMhpN+h
         aV6A8+SVBCPJHILTgkN69dZxuTbOH7ih4HlJ3/CIEIUVrE1lXQx81I5lcWSFhrRh8j2b
         fEaU2l3wQrmNf79wl2RqSnvoWH5JQ7IUE4foAcJ7trZT7syCZk5rdBozei44GAdKm5+4
         yNPYf+QyEPiZXvFWMf/H/dj9BJeCNSw1LQl+cdG20VcwOzTjHSuCs+YUFpTMjxtwYyw+
         rG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761052364; x=1761657164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYks9YiGVI8btVCzGqfhMQ1rij+nkpQpVNndbIX1uww=;
        b=CUyYB9dCwt9xoiDZHinVn4+DQX2gil8/jULDRw5YD4LKREUqT+VUKJo3uXy7WZ25cq
         xntLqZYQz5AxDtxu9ROTjq4/APOI3BSrWPmMSYqXyS72Ndf9spBH++NKW0qIB1booY/E
         y2z2NvcS4RtdZ7O3z9GfF8s6RMR70nTYLKNs79bwQ3aHn/SQNU3ZbdmrlBy3eTAJ59Qw
         pSlMNeaDl8SIbXhhie4MrBZzRL93VWlzTvarCHyfHDw9pT+pXjaZTCzo/EoUFadqsqYJ
         7bEurH69fk0Rhp6nQgkU5NDvalzcYSfUaQVpZ5SiPW0w9dQa5LrZzbXx1glp57SR9ZcW
         M5bA==
X-Forwarded-Encrypted: i=1; AJvYcCVqF0SLPsoQN/+IJi7QzDzfs+xaeGMe3yISLJcOqr3Pq3z6/kU/Ii89hSCApekJezmN77RfjhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBvNTfs4f48nFLymq5zKy/a7IMahbUJZPp9PXUqRZJu1KGZksS
	MZJJ/Vxv+NX5MGhG0Ctwn0R4lUDNJM9PiR23B3euMg1Fc6GMfp0y+zys
X-Gm-Gg: ASbGncvKfZMwwVFE1C5MJ+mQr+iHudE8R2ZZa0T0jOYcg4HdIkQYBxVYYYPBJqbZVob
	jt0n2WZUcOZ1MrxHuguuJu2hzdGnF4QXd/ZuZK5eFSoYSQPIDcS18Z2ZConzbT9gj73ix6q+xzW
	Ev0ZehAsz6iArvGbrzaFKYq7pU5NJVKVBe9fMzQHVHqVLOHaH4J1YyjLaofr5b5s5V5Luqo8nE0
	N5VFQXT8YxJGwubssQubxrIE/58JViyqeCtPu0LLuP7cLpsboS/a1vws56H3n6P9hB3okEHSFC0
	jTEizKCLID9FO1dyzRggJMze0cgVFphw5ycVJ/HsBz1XVAEh4b6Eov3Ud8rm3+bHYez5aLu9EH+
	r624r5CaKggsZrwBH6+vjctVDZ1eF1ZXqE1FPWihTyX3i27pmU6rr93tKn654xtsX3d7oq2ArEo
	LM27Jnc7z9n91ZiC4DfWDL4Q6eoi1YTdtoA05719zFcp/1U+uf4JD/ff/FLg==
X-Google-Smtp-Source: AGHT+IGooEV5+ooG0aaYa2pPQEXWWO6T0gE0QTgFSG0e71ronKcRxW+iMapccUAf07rZSXUj2t3S/A==
X-Received: by 2002:a17:903:1d1:b0:290:2a14:2ed5 with SMTP id d9443c01a7336-290c9c89fd2mr183379455ad.4.1761052364484;
        Tue, 21 Oct 2025 06:12:44 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fd9ddsm109248175ad.89.2025.10.21.06.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:12:44 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	joe@dama.to,
	willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 6/9] xsk: extend xskq_cons_read_desc_batch to count nb_pkts
Date: Tue, 21 Oct 2025 21:12:06 +0800
Message-Id: <20251021131209.41491-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251021131209.41491-1-kerneljasonxing@gmail.com>
References: <20251021131209.41491-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Add a new parameter nb_pkts to count how many packets are needed
practically by copy mode with the help of XDP_PKT_CONTD option.

Add descs to provide a way to pass xs->desc_cache to store the
descriptors for copy mode.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c       | 3 ++-
 net/xdp/xsk_queue.h | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index b057d10fcf6a..d30090a8420f 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -523,7 +523,8 @@ u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 nb_descs)
 	if (!nb_descs)
 		goto out;
 
-	nb_descs = xskq_cons_read_desc_batch(xs->tx, pool, nb_descs);
+	nb_descs = xskq_cons_read_desc_batch(xs->tx, pool, pool->tx_descs,
+					     nb_descs, NULL);
 	if (!nb_descs) {
 		xs->tx->queue_empty_descs++;
 		goto out;
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index f16f390370dc..9caa0cfe29de 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -235,10 +235,9 @@ static inline void parse_desc(struct xsk_queue *q, struct xsk_buff_pool *pool,
 
 static inline
 u32 xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_pool *pool,
-			      u32 max)
+			      struct xdp_desc *descs, u32 max, u32 *nb_pkts)
 {
 	u32 cached_cons = q->cached_cons, nb_entries = 0;
-	struct xdp_desc *descs = pool->tx_descs;
 	u32 total_descs = 0, nr_frags = 0;
 
 	/* track first entry, if stumble upon *any* invalid descriptor, rewind
@@ -258,6 +257,8 @@ u32 xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_pool *pool,
 		if (likely(!parsed.mb)) {
 			total_descs += (nr_frags + 1);
 			nr_frags = 0;
+			if (nb_pkts)
+				(*nb_pkts)++;
 		} else {
 			nr_frags++;
 			if (nr_frags == pool->xdp_zc_max_segs) {
-- 
2.41.3


