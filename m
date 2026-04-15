Return-Path: <netdev+bounces-278708-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGQeK2JM32mFRQAAu9opvQ
	(envelope-from <netdev+bounces-278708-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:29:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6713C401F98
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 10:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4E04304F209
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E513CF02D;
	Wed, 15 Apr 2026 08:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDOJRhdu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BED73A0E8E
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 08:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241675; cv=none; b=QXWuz8RAeWxqvmid9K56D8BmXU/R93te/UJ+xTrb7RBxEV9u+ywCUTT7fHT8hcMRdgxOBDkV5XTE2/wsj1vygfvCPTBKofr+yUvClvcGWxKeuxFkFk+DWt0FJM1r73bmnmlrvoUV/jiCHCTVKVeaBtvR7yECh59ZCqSA0MaLnAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241675; c=relaxed/simple;
	bh=XT1aDQ8E1jsPO/lJtAap49jcFvVVpTa13m0am3SqON0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SFWv/gHYOXuOqZFFP8AnK8SuNTU3+9GMtF+qjv43ZwKaUsILMpXdLPzfSLEIObWNzKKwDWXJ1SheD+gurF4tcJHFSxndiJW/d8Isf4Q981BQ7LSpHYx2vLXWs+6yUqec0JZdQgB6VDH1Jwsn5StBdQNsYicgELo7C6bX1hAJggA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDOJRhdu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b2429f98d0so41116905ad.2
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 01:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241673; x=1776846473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qm8KZlIM2w+S8TkBYrHwgqIY+7B0rxKP/eXM2R8Qlds=;
        b=aDOJRhduRVlVL+Q+L2CdEILQdGGCzXXlYeaZbk490b0hlbV/SphVGXoLkRkA/klY7l
         QyS3QFLyzy2f72Q79LFSAZ722fLzqQn46m/0wIckhyjn8hZvZ+MPbKv2GvnfuqVYlglo
         smN990DwD7n/EzmvXvZvjaDsG6894+l6WlXyKipuMH21BawsHMYLAT7rGu5t7L1aHgmL
         +1+1v1liy2MxkgE6x+RQmzE45rvylRPIvvIxh5jlJwd6cgwBdQeF1ebITnAO140qf2LW
         MEByrj3WM6bldkX6OPywdDkMLSpLSaa4QCcOJHr4UycLPHXUSbfwDhZ8xcOYKtNFFKYc
         3CYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241673; x=1776846473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qm8KZlIM2w+S8TkBYrHwgqIY+7B0rxKP/eXM2R8Qlds=;
        b=ea06oWu57fBiN1BRPK5XE7DjX38Jcy2apKp1k9BnyVpDCndaXRzORZt8TLzoubC2CA
         q5KO+X/oiHzw9e4KoRB+elDJKBLxLmyuiFobIpO6BeZc3NsuqU8wm6U/vrL9oU/vXMeU
         V/mF+NBubeBPiatI2jt0o8jz6f/M57rW/9zyiL/Mti4aF0Bm/RdPjCSjjJDxnejw9T/G
         pU2METRYh+zZuvnLLi208aiXzAhH6oH57IIb9gaRbjUa0n+U0qu17E0mJOn73tveOcvJ
         ve3Nzrb/mhzGsY/HZ96eFGyFCX77MWQtRzs2KD0igu1Gnyc6WpxQawvINVWQpnlgnLvO
         sFLQ==
X-Forwarded-Encrypted: i=1; AFNElJ+fUXhPLf9IH0ue+r4X9/opDRG2XJG4iktXXAmPzf0fNa4x8zd1GuA3s1drdxeNusFT2yn3Ioc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOgzbeUwk3GAWsn480X479VdP9n6+ci9Q1Jqzsc/P1Yct39pUN
	TNnNOy6tO40WiSh2g5FbVknz12zggnUHy8bHUXFMsvc60CDOAeBbJL1Q
X-Gm-Gg: AeBDietWKS6e4fZqQWwT+5EaYbJY87EVXcFnNrqhrz857tpPasyXVyvY/R4sfqgrzpt
	PKBXn3OpQU4B/eQqO0vxDogIupyi855DzdN9I8rkAeSzBajomF0r2ZKrtAkTKocBtcHbOQmNwqN
	ApVKLwDlhm+yeQadRW6HUvSMJnpC9rm498pLzMbz+OomORtNe4am41xMjelF7b6rjUG5v+sttk+
	agK/uXYcvDmIRGJJanu848axU+nJ0CT1r3TvXbra60whsdVWCjSEtvILS2o2LNVDGKV8b4H6Ftl
	bI12xTCdehExXE5Ok1ceUP25+0UrpIF0YQrl/g6SEFAYcz8Jg6of8ydeej3n6fgFQjnIQ+mK47r
	kxrNGR865QkRxvHz1wc7E4dMrxI+HTSyyeK2FNXMFRIVf+Jis9BuO4BvTf4Apf/FuyjQ/pw0ZeI
	ucASRO7hdu0TewGl+2B7qt0hLOFS/59MVR+FzRjJXXCAoSxqnVW+uzlrl44iRaFoCWMKq5GfZsA
	1GcLXAs
X-Received: by 2002:a17:902:b409:b0:2b0:62dd:3a93 with SMTP id d9443c01a7336-2b2d591d1fbmr152805355ad.7.1776241673435;
        Wed, 15 Apr 2026 01:27:53 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782a93c7sm12174215ad.62.2026.04.15.01.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:27:52 -0700 (PDT)
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
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH RFC net-next v4 08/14] xsk: rename nb_pkts to nb_descs in xsk_tx_peek_release_desc_batch
Date: Wed, 15 Apr 2026 16:26:48 +0800
Message-Id: <20260415082654.21026-9-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260415082654.21026-1-kerneljasonxing@gmail.com>
References: <20260415082654.21026-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278708-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6713C401F98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 7a6991bc19a8..6cd2e58e170c 100644
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


