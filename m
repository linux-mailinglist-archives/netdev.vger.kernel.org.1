Return-Path: <netdev+bounces-270166-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHvHNmYavmlNGgMAu9opvQ
	(envelope-from <netdev+bounces-270166-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 05:11:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 871D22E3304
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 05:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 992EF3034B1D
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 04:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98FF2FF65B;
	Sat, 21 Mar 2026 04:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXmAb+TE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C0D29BDAA
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 04:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774066273; cv=none; b=K7w3eepfvPJVPybNXU/WLtFez0PGOsQIbevFlatXfVdhzhEy7gGvdEokTG8j0t8o7tNYu66ZORLX2BC4lQBMs/Tf5QMeOatvC5IEJY+jT1La8BBrb3SsgsQcRi+/9HjuLj+MlRyWHnUcnUykbbAbLXT0EzAZl4iIXCrkWx8bgT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774066273; c=relaxed/simple;
	bh=rjzo2867c487CWOYVxoBrzz6JtXC0qJwdimP7OFGG88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=htF9Z/WI1QMfKrx6xfRAyhTkdL3HxWWqlSsDVqu/3oRbtCcY/rU2rNB4aS4Cnx7hoqDlANka5RDiLxIFjsAqyFJV4tnFLpB1O3yKSGPVfuV6QEINfBIaCt30uAi2qen/mNmUsjrUHAMSyxwZ/rdzAuQIhNlyH/JYocWWT0jOS+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXmAb+TE; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cfbfdabf3fso236757185a.3
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 21:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774066271; x=1774671071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EX8CRYSQw9iZwcIonxrKihxlucz8CDeL8AI9FyZdcRY=;
        b=lXmAb+TEDskmvaZ2YfY0tofJMeXnG9xB4Rj7HuxKFPkskZXWsA5iG+ho5B8BLkrz7s
         Gl5C3uOqOQXFp3MoBAjcVOgY/cxdLQeup/X4kR3alwCcmNaOBnnYCM07jKuRoyEtABuR
         DmVlWDcM5xoTnPYJe+pbjAqsIUlK2NCG5iL+xH4CuzcPtBMl9m3wV2nvHMFJmNcC/zRt
         CsUj1Df8I+HHtlJjPyGwvGm+RJKwNP3STkbl4L8/29Yry5sX3oJfOYpBJxu8mSOWGJlR
         5t9zMYgyC59fzDWcASIp8r0afTZBDybOho620V6O2NW8h2CmF9kSOZkXqLUfpMpejSoV
         74eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774066271; x=1774671071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EX8CRYSQw9iZwcIonxrKihxlucz8CDeL8AI9FyZdcRY=;
        b=jxYtYEFuNFtKPuOBNqj1BofeYGozCOWE1LvNTzIdAsBaRkvk4DkVhOGSN75bUDpB11
         coZFq79Xvc7+ySLwvn0EU+QG0haR2ckflXbbclfs/K0lFY5j6sLFlsbSVvphFg75UmPD
         2uFUGzg/O0+kRiCGx9K457yPIig31ZXzGZ19ReBRzH517YjxxwBC4izdkUv4+Y6byVPe
         wkGMVPFBHW5PJbkqwSEchX0BOPacfM0lg23zlLuxKRQQaEQWecMQS0H7U4U7ffboDYCe
         9577dOOShermhU0v3l5Dlvg/7J3wrvZQKI5koEwDiPtiBOryWuLW7ZREk/HZVekNzdlM
         mw5g==
X-Gm-Message-State: AOJu0Yw2B5pi4eyGIGgKhMfQ9hE/ag7EAMk2cEhvJpB21iO4nI2h27R1
	yuT0qUhlaA2LchfuNSb83+y1NOAW9ksTDutrqJGpxDt5Y4BXlRPyyipNU+OymZXv
X-Gm-Gg: ATEYQzxhMtyRJbkZ5hchA5DkqbxqimVOUA+HpE+qhHco6WpiwwBf/7/YQTeoThziO4x
	YywWgQ/+YxEABlTltlQOu3wsr5Jh4ZEdNKdCswQsE/oCpiPMK+TKkL9ss5JQN84e3yKvwAzBaov
	GuzeXBh2VFPjq/J9AaWll6BMsL9GRNQ9gvckvvWz7i9TBBz8EXhZvEi8dXw+ByMeg4GbtLRtgQx
	Fn5N8w64f99K6fKt2wPUXQzgdNtKiaBX8toI11OHXuwZGNBdKppAIWYxLSdgtyPj6Gw7Gn2DUkK
	KcwPnwLO/otj7lvt4bokCb/Wnv5j0g0wz+o8kwgLWKJ6iJYByCIUYnj4mapJnYGT0F5z2LHAcvf
	6smjNELBJgZ4J3Q0yri0UIsMRYZEbw9X/tjluNAd7jggQKIhatHquz8TaU8/GTpz6GVjtmhsV4i
	ijO7WS5gLbetZRteupYXK3s+FBDeO04TdlR7UqEDI61Lf30efeLPXd8hqAEm1mByX9cR405EmOE
	H4/
X-Received: by 2002:a05:620a:1a04:b0:8c6:b14e:655d with SMTP id af79cd13be357-8cfc809f26emr789956885a.74.1774066270733;
        Fri, 20 Mar 2026 21:11:10 -0700 (PDT)
Received: from CS-396-Lab-Machine.. (c-24-12-10-127.hsd1.il.comcast.net. [24.12.10.127])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9088df1sm309269185a.25.2026.03.20.21.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 21:11:09 -0700 (PDT)
From: Tyllis Xu <livelycarpet87@gmail.com>
X-Google-Original-From: Tyllis Xu <LivelyCarpet87@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	peppe.cavallaro@st.com,
	rayagond@vayavyalabs.com,
	stable@vger.kernel.org,
	danisjiang@gmail.com,
	ychen@northwestern.edu,
	Tyllis Xu <LivelyCarpet87@gmail.com>
Subject: [PATCH] net: stmmac: fix integer underflow in chain mode jumbo_frm
Date: Fri, 20 Mar 2026 23:10:58 -0500
Message-ID: <20260321041058.901149-1-LivelyCarpet87@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,bootlin.com,st.com,vayavyalabs.com,gmail.com,northwestern.edu];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-270166-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[livelycarpet87@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 871D22E3304
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The jumbo_frm() chain-mode implementation unconditionally computes

    len = nopaged_len - bmax;

where nopaged_len = skb_headlen(skb) (linear bytes only) and bmax is
BUF_SIZE_8KiB or BUF_SIZE_2KiB.  However, the caller stmmac_xmit()
decides to invoke jumbo_frm() based on skb->len (total length including
page fragments):

    is_jumbo = stmmac_is_jumbo_frm(priv, skb->len, enh_desc);

When a packet has a small linear portion (nopaged_len <= bmax) but a
large total length due to page fragments (skb->len > bmax), the
subtraction wraps as an unsigned integer, producing a huge len value
(~0xFFFFxxxx).  This causes the while (len != 0) loop to execute
hundreds of thousands of iterations, passing skb->data + bmax * i
pointers far beyond the skb buffer to dma_map_single().  On IOMMU-less
SoCs (the typical deployment for stmmac), this maps arbitrary kernel
memory to the DMA engine, constituting a kernel memory disclosure and
potential memory corruption from hardware.

The ring-mode counterpart already guards against this with:

    if (nopaged_len > BUF_SIZE_8KiB) { ... use len ... }
    else { ... map nopaged_len directly ... }

Apply the same pattern to chain mode: guard the chunked-DMA path with
if (nopaged_len > bmax), and add an else branch that maps the entire
linear portion as a single descriptor when it fits within bmax.  The
fragment loop in stmmac_xmit() handles page fragments afterward.

Fixes: 286a83721720 ("stmmac: add CHAINED descriptor mode support (V4)")
Cc: stable@vger.kernel.org
Signed-off-by: Tyllis Xu <LivelyCarpet87@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/chain_mode.c | 71 ++++++++++++++---------
 1 file changed, 44 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
index bf351bbec57f..c8980482dea2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
@@ -31,52 +31,65 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
 	else
 		bmax = BUF_SIZE_2KiB;

-	len = nopaged_len - bmax;
-
-	des2 = dma_map_single(priv->device, skb->data,
-			      bmax, DMA_TO_DEVICE);
-	desc->des2 = cpu_to_le32(des2);
-	if (dma_mapping_error(priv->device, des2))
-		return -1;
-	tx_q->tx_skbuff_dma[entry].buf = des2;
-	tx_q->tx_skbuff_dma[entry].len = bmax;
-	/* do not close the descriptor and do not set own bit */
-	stmmac_prepare_tx_desc(priv, desc, 1, bmax, csum, STMMAC_CHAIN_MODE,
-			0, false, skb->len);
-
-	while (len != 0) {
-		tx_q->tx_skbuff[entry] = NULL;
-		entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
-		desc = tx_q->dma_tx + entry;
-
-		if (len > bmax) {
-			des2 = dma_map_single(priv->device,
-					      (skb->data + bmax * i),
-					      bmax, DMA_TO_DEVICE);
-			desc->des2 = cpu_to_le32(des2);
-			if (dma_mapping_error(priv->device, des2))
-				return -1;
-			tx_q->tx_skbuff_dma[entry].buf = des2;
-			tx_q->tx_skbuff_dma[entry].len = bmax;
-			stmmac_prepare_tx_desc(priv, desc, 0, bmax, csum,
-					STMMAC_CHAIN_MODE, 1, false, skb->len);
-			len -= bmax;
-			i++;
-		} else {
-			des2 = dma_map_single(priv->device,
-					      (skb->data + bmax * i), len,
-					      DMA_TO_DEVICE);
-			desc->des2 = cpu_to_le32(des2);
-			if (dma_mapping_error(priv->device, des2))
-				return -1;
-			tx_q->tx_skbuff_dma[entry].buf = des2;
-			tx_q->tx_skbuff_dma[entry].len = len;
-			/* last descriptor can be set now */
-			stmmac_prepare_tx_desc(priv, desc, 0, len, csum,
-					STMMAC_CHAIN_MODE, 1, true, skb->len);
-			len = 0;
+	if (nopaged_len > bmax) {
+		len = nopaged_len - bmax;
+
+		des2 = dma_map_single(priv->device, skb->data,
+				      bmax, DMA_TO_DEVICE);
+		desc->des2 = cpu_to_le32(des2);
+		if (dma_mapping_error(priv->device, des2))
+			return -1;
+		tx_q->tx_skbuff_dma[entry].buf = des2;
+		tx_q->tx_skbuff_dma[entry].len = bmax;
+		/* do not close the descriptor and do not set own bit */
+		stmmac_prepare_tx_desc(priv, desc, 1, bmax, csum, STMMAC_CHAIN_MODE,
+				0, false, skb->len);
+
+		while (len != 0) {
+			tx_q->tx_skbuff[entry] = NULL;
+			entry = STMMAC_GET_ENTRY(entry, priv->dma_conf.dma_tx_size);
+			desc = tx_q->dma_tx + entry;
+
+			if (len > bmax) {
+				des2 = dma_map_single(priv->device,
+						      (skb->data + bmax * i),
+						      bmax, DMA_TO_DEVICE);
+				desc->des2 = cpu_to_le32(des2);
+				if (dma_mapping_error(priv->device, des2))
+					return -1;
+				tx_q->tx_skbuff_dma[entry].buf = des2;
+				tx_q->tx_skbuff_dma[entry].len = bmax;
+				stmmac_prepare_tx_desc(priv, desc, 0, bmax, csum,
+						STMMAC_CHAIN_MODE, 1, false, skb->len);
+				len -= bmax;
+				i++;
+			} else {
+				des2 = dma_map_single(priv->device,
+						      (skb->data + bmax * i), len,
+						      DMA_TO_DEVICE);
+				desc->des2 = cpu_to_le32(des2);
+				if (dma_mapping_error(priv->device, des2))
+					return -1;
+				tx_q->tx_skbuff_dma[entry].buf = des2;
+				tx_q->tx_skbuff_dma[entry].len = len;
+				/* last descriptor can be set now */
+				stmmac_prepare_tx_desc(priv, desc, 0, len, csum,
+						STMMAC_CHAIN_MODE, 1, true, skb->len);
+				len = 0;
+			}
 		}
-	}
+	} else {
+		des2 = dma_map_single(priv->device, skb->data,
+				      nopaged_len, DMA_TO_DEVICE);
+		desc->des2 = cpu_to_le32(des2);
+		if (dma_mapping_error(priv->device, des2))
+			return -1;
+		tx_q->tx_skbuff_dma[entry].buf = des2;
+		tx_q->tx_skbuff_dma[entry].len = nopaged_len;
+		stmmac_prepare_tx_desc(priv, desc, 1, nopaged_len, csum,
+				STMMAC_CHAIN_MODE, 0, !skb_is_nonlinear(skb),
+				skb->len);
+	}

 	tx_q->cur_tx = entry;

--
2.39.5

