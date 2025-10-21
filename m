Return-Path: <netdev+bounces-231261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38275BF6B11
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 15:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C1FA502B1F
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 13:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF7C335093;
	Tue, 21 Oct 2025 13:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+D379Wb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACE5334C21
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052362; cv=none; b=CNbg1GsDRZdZdoBpFIUbie3eCuWxVL54HevOQfnMWCMn4M4zgZjqfbFV99IgWKbIGfvf/6jFXbim3U3np7pkYilNIC7aHfcyGQBYsB31M1vQTMTNV2PfEo+254MePxvCVFSoJ11PQHcFNau6lwvwsfe55v7OIE+ixtwTnd5nKjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052362; c=relaxed/simple;
	bh=ZtKe7rf8/Qt5t19CHQEgL3Mcx4Wc4i0VtmUGfdUJZgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ae+/mqw2QROZCEwWlst5cf/rfiG/kKimtk6fygzZ5CKPvd87XK3l9tkUJd+z1nOMn1EunFJwq+yuyhxVVQKtevcurCRRXkKC+0pkI73Gon5xClW18X+bEjxMXMUyMvwzBRhacufgsfHaurAmxqTf0zrlY9rDFVc5fjDACZqx3bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+D379Wb; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2907948c1d2so60000035ad.3
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 06:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761052360; x=1761657160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MSfMW+zmjrtLOUzwiM4d0ZjMjmVjcLFErbCjOZ3pck=;
        b=C+D379WbZPoCpwaEXxWzjM5mqxLkU5JV+BTfCMwysvNxc/Z/Pg0vniQ7MDoCjwcP6s
         Txb/L1nNt7QtM62mj8EcJjNIbJ7Gzg5AtfRi8Egxrm12heI0I+rfbaiuMbZrxM7sMsd6
         N5GhYXelN0N58wfGfKg+bqpoyERqDa2a1I6WmvHLTVIGYRmI2qg4lzJLRM5bI/ahAXSy
         5F8feN8HupFYnojdhBUFIOdXQeMrZw5ydeQgmN6xtfGwBCIeVZBAnRxbRKc5nv8Pgkmg
         630QeJDeLq4ZY77+8uO02vg7lEZdPuB/acl9kitor3FLVfQAr79ilWIM8wfUqw96/qy6
         8Skw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761052360; x=1761657160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8MSfMW+zmjrtLOUzwiM4d0ZjMjmVjcLFErbCjOZ3pck=;
        b=MnGz7YF1weG63Vtusekt1jcOykTQR8NmFtpctrq/D2rMN4PG5z8bxKMjdAM7BwWqtF
         TFqVdIo2LQBr3Qf8m+FskO5a3usP6IjJUWUSx93MEHDmrnv9r759WUh2r5SrXnDxFcW6
         ffJgfL/gpwjtje8Cf9FSwjSQ8EFYxSolyknqcCfBHlWQGdVwiCrGgZJ5jkGGjaCk418W
         joHMZWAZWUqGtPB1BHvHJ48oGpBURptOI173HNU1PiDl1/RR92RTSngMqV+6FGC8R61B
         /SUVo9jrulV5oOuECpnw++cuVKzdcTZm2n+d1JfenOWpCc04348+5NrWacfx1hMwpPWD
         1vFg==
X-Forwarded-Encrypted: i=1; AJvYcCUt8rWeuWdA+1QSmaX3RMp/hd0nHQu7EHLjgvrMczEYla1Q20E4D4+tmFq9bC/POyNOg7t0Iho=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXAAuxfv2Irm53jSEnvZ4naoBTLb/WuvNIfaf/hHwNPCOjQkJK
	qrXP0tszxDOKT+41uAzbwn8p4g2KYxOJ/zLQtGdx2sAzyRXBRF83TtD0
X-Gm-Gg: ASbGncv9gkR279a+Q6nisSQWh96YxjW9ZXIUKlae0T4Hre/xghr0Nu++/EKPPAPAdub
	5e2ky5Yi4Wj64y1L4VGmpK3FD80cRqr5F9qOUuJ7rCbZRmVcf327gGEl3t/nTEcZt2Q3algT7q/
	Qa+wjEJvabglFr6xRKvDCwlqt2gfxMM4AKg0JSAQCDRiC0TvNxjKW18QBqCoV/QtSokv1yPsrbe
	a6cUFJOinMnfzeHDb8sTSDyQxo5Nind1DCHcnCS7TGEilEvPhPDHeIdoxHjwjOtaeKNklpVabhX
	ScH6Cj7EAACuxqsJbrZ0GxSVjQSOh181IJJM/rY4V8yEmBo1nIlvyFQVM/FMuntbm+Ve8HgpImP
	ddaOQIpb0hy7lgjAK1MFEjhzWZjw+OrYYYl5Yp5XesFddkmNsz/3AQkvK1Hlz9onzRihVO2gGee
	eTypDB/Ju7L/L152OG06l3zJkxNZkROYGbUuLHWOc2SMyauz4fBOeVFaMmXQ==
X-Google-Smtp-Source: AGHT+IHhPNweO1wabVVKhC4V8yZ7wro/fBZN5HXZyIOv7CwY+uVFnmKxkr4+SXZV3kOy5ThjmEaSTg==
X-Received: by 2002:a17:902:f647:b0:24b:11c8:2d05 with SMTP id d9443c01a7336-290cb65c5b1mr183011415ad.45.1761052359953;
        Tue, 21 Oct 2025 06:12:39 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fd9ddsm109248175ad.89.2025.10.21.06.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:12:39 -0700 (PDT)
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
Subject: [PATCH net-next v3 5/9] xsk: rename nb_pkts to nb_descs in xsk_tx_peek_release_desc_batch
Date: Tue, 21 Oct 2025 21:12:05 +0800
Message-Id: <20251021131209.41491-6-kerneljasonxing@gmail.com>
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

Rename the last parameter to nb_descs for more accurate naming. Next
patch will add a real nb_pkts parameter to help copy mode count how
many pakcets are needed.

No functional change here.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index cf45c7545124..b057d10fcf6a 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -485,16 +485,16 @@ EXPORT_SYMBOL(xsk_tx_peek_desc);
 static u32 xsk_tx_peek_release_fallback(struct xsk_buff_pool *pool, u32 max_entries)
 {
 	struct xdp_desc *descs = pool->tx_descs;
-	u32 nb_pkts = 0;
+	u32 nb_descs = 0;
 
-	while (nb_pkts < max_entries && xsk_tx_peek_desc(pool, &descs[nb_pkts]))
-		nb_pkts++;
+	while (nb_descs < max_entries && xsk_tx_peek_desc(pool, &descs[nb_descs]))
+		nb_descs++;
 
 	xsk_tx_release(pool);
-	return nb_pkts;
+	return nb_descs;
 }
 
-u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 nb_pkts)
+u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 nb_descs)
 {
 	struct xdp_sock *xs;
 
@@ -502,16 +502,16 @@ u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 nb_pkts)
 	if (!list_is_singular(&pool->xsk_tx_list)) {
 		/* Fallback to the non-batched version */
 		rcu_read_unlock();
-		return xsk_tx_peek_release_fallback(pool, nb_pkts);
+		return xsk_tx_peek_release_fallback(pool, nb_descs);
 	}
 
 	xs = list_first_or_null_rcu(&pool->xsk_tx_list, struct xdp_sock, tx_list);
 	if (!xs) {
-		nb_pkts = 0;
+		nb_descs = 0;
 		goto out;
 	}
 
-	nb_pkts = xskq_cons_nb_entries(xs->tx, nb_pkts);
+	nb_descs = xskq_cons_nb_entries(xs->tx, nb_descs);
 
 	/* This is the backpressure mechanism for the Tx path. Try to
 	 * reserve space in the completion queue for all packets, but
@@ -519,23 +519,23 @@ u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 nb_pkts)
 	 * packets. This avoids having to implement any buffering in
 	 * the Tx path.
 	 */
-	nb_pkts = xskq_prod_nb_free(pool->cq, nb_pkts);
-	if (!nb_pkts)
+	nb_descs = xskq_prod_nb_free(pool->cq, nb_descs);
+	if (!nb_descs)
 		goto out;
 
-	nb_pkts = xskq_cons_read_desc_batch(xs->tx, pool, nb_pkts);
-	if (!nb_pkts) {
+	nb_descs = xskq_cons_read_desc_batch(xs->tx, pool, nb_descs);
+	if (!nb_descs) {
 		xs->tx->queue_empty_descs++;
 		goto out;
 	}
 
 	__xskq_cons_release(xs->tx);
-	xskq_prod_write_addr_batch(pool->cq, pool->tx_descs, nb_pkts);
+	xskq_prod_write_addr_batch(pool->cq, pool->tx_descs, nb_descs);
 	xs->sk.sk_write_space(&xs->sk);
 
 out:
 	rcu_read_unlock();
-	return nb_pkts;
+	return nb_descs;
 }
 EXPORT_SYMBOL(xsk_tx_peek_release_desc_batch);
 
-- 
2.41.3


