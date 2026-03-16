Return-Path: <netdev+bounces-268012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNnPJ65nt2mQQwEAu9opvQ
	(envelope-from <netdev+bounces-268012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 03:15:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BDC293DBC
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 03:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BE8B3061774
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 02:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0482330B520;
	Mon, 16 Mar 2026 02:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxYr+wfZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCB530ACF1
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 02:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773627035; cv=none; b=JDuD2yUXSXLcSk3MYYigsetUGMlQnoasobHDpXcIljelGD1/HPkFQ7e3oitmHxkTpOZlu8Gz3q9JJi1wSO/o9ro8aJHS3EgDReJBycHgpATrG3k6PMBLOHUd4HB+qlWdwU0uk5xLNzKWa+p3wpHM9eqPS2HDATlZUcjHWHa5E4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773627035; c=relaxed/simple;
	bh=LXy9mgSk9KFtLnI78bQHx+dwMcHJQ3vb3A/OuiACBE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUJXn41+GkN4BhuFLhOkO2w4+8gnl+/+6QKB8jn4nVF3oMY9CpCnHO3W1gfxj7WZzDJsk5VFN+XSAV4r55X1kQ+LYm8YI2A3pV43Fq6BMtu+NkkbRymJWm3Go0Na1a+rRiOP820C/SUAiPwLA4aABiEKdVp4DXfwMMNCYNegZpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxYr+wfZ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c73967cf77aso1605590a12.3
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 19:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773627034; x=1774231834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cK4DSgf4/rvokOqdV9NzEntXk8odHo4nT46mIGyGv8=;
        b=LxYr+wfZAbDNee7BG1gvD2vI1PiYYgz8CRCNH7FrL7a9T6mgwLljcEgLbCjA85w0mL
         KKU7Lx7YHN5PqEiThCRNWC1vyodOLT1rR5XWe+01nwPbN0lLosX6TGedREr7H70MNMoP
         RyDVp/91HjyvJhhhxy2QYmlTjqRn1eEGjlxDioEl4YIUnd96CZNsupZOB6cEb8JQ54hP
         gBAFWdNj+eh6Oz1EKHqpsMpscBXHDVbQuRND6S9YskvtXtCNlOG6H2FgpYqH8YCIglfU
         i2fsj9Usb9RAqrkC+70gKLo1eObBn75pkUKndqhnvOwp8xgsICqXrr+EgGSNlgn/koAP
         5zIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773627034; x=1774231834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5cK4DSgf4/rvokOqdV9NzEntXk8odHo4nT46mIGyGv8=;
        b=rBVRx+TdARV3q7EMnztTtA+Ys51xBcZpg2jdwNz0HEPFcbTb13xWaVn0xKYGcZS2w9
         uUbbleJc5EJCmzlCjuJS3JUI0D8jQJYthTSq4wbl+slu0K7n2oqrUvUe2+ETLDfGz+o9
         2CfYjEVZe1TIdcXPv/LEgMz997NUDWE3G2jtv9UIkO/99MaDBjzHX+sgyCcans/HMTFV
         quA2ja2ufezXgUyRt105f0P/zusRO0Mulf6ctNAmHsYdWadWH+M2iY8FXlIwdR8rmvQq
         SZsyAuKLIYYzxn2AfkWHl6l8PMoiCI7ufMzns4EYfgDUz0T+tsT6Aa2hWZQ5Ly5Prtiw
         Bo2w==
X-Forwarded-Encrypted: i=1; AJvYcCUJMwv3xMwjsYy53E4XpyXMSr/1ENnErMc9xK5bonWyZdXFad9zynuIEGJJ2jWXAEOpY/g7zpY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys7JAh8Hf13UpF76zxpICW8/F4ff6sAWQQ6i/rCot3Uw6Po+dx
	tjAsZa7usHyuFInniOLuQb6Yw7TWP/MVvEmt6qX0u6lVhZvbizq3QXi2
X-Gm-Gg: ATEYQzyDeyVUfj0+vMbsEmuOEX3FFJPX2WHWI/r4AWyyK4sWgukE6YrFVML68AIe4zl
	96Vw9g30KaneJtiRs4WQrH/XmcCpaKuzLyFgNI7ehV5OeNyxzkQS2AHdd2Kf/Fl2pp++1yNb/xM
	wlp3JbVBAOYF95zeTxEn4gO2hjY0Tn5U4V0SKy/P10I4WdGBu5JOp0tYQkL9BpaIbhZg8AoMflp
	R1IHJy9dcQBrz8LAnIjKcDAInwOjo1KEONIuIS4KY/asZxaGRphgXlTkgom+1ZcrxHIwGlZESPN
	E3ws5MLq3gk35juKDQm2Wk35tyfbop1oHRxo+b5KZziTesBIQrH4u7+QhsnL4Dq1Y0MjWUkTjxI
	fvopN44D7/1ekuH/Pd0nzye6UiVfCAZ+SouFcLSNtfdyPgQ9EXyFZwLAKPJYgVn6c9oOwioRjiL
	niBH4Ta+quv9jMDhVIWod87IuUQP5TbNFkRxnxZqZs8+ZNUJhMXU6BXoCl4DC5QDYc
X-Received: by 2002:a17:90b:4ccf:b0:336:b60f:3936 with SMTP id 98e67ed59e1d1-35a21ebca88mr9426301a91.12.1773627033840;
        Sun, 15 Mar 2026 19:10:33 -0700 (PDT)
Received: from luna.turtle.lan (static-23-234-93-211.cust.tzulo.com. [23.234.93.211])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02ffdfb7sm17705805a91.14.2026.03.15.19.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 19:10:33 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Serge Semin <fancer.lancer@gmail.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 3/3] net: stmmac: Remove stmmac_rx()'s `limit`, check desc validity instead
Date: Sun, 15 Mar 2026 19:10:09 -0700
Message-ID: <20260316021009.262358-4-CFSworks@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260316021009.262358-1-CFSworks@gmail.com>
References: <20260316021009.262358-1-CFSworks@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,bootlin.com,renesas.com,nxp.com,tkos.co.il,gmail.com,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-268012-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07BDC293DBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A previous patch ("net: stmmac: Fix NULL deref when RX encounters a
dirty descriptor") fixed a bug where the receive loop may advance to a
still-dirty descriptor (i.e. one with OWN=0 but its buffer(s)
removed+NULLed), causing a panic. That fix worked by tightening the
loop's iteration limit so that it must stop short of the last non-dirty
descriptor in the ring.

This works, and is minimal enough for stable, but isn't an overall clean
approach: it deliberately ignores a (potentially-ready) descriptor, and
is avoiding the real issue -- that both "dirty" and "ready" descriptors
are OWN=0, and the loop doesn't understand the ambiguity.

Thus, strengthen the loop by explicitly checking whether the page(s) are
allocated for each descriptor, disambiguating "ready" pages from "dirty"
ones. Next, because `cur_rx` is now allowed to advance to a dirty
page, also remove the clamp from the beginning of stmmac_rx(). Finally,
resolve the "head == tail ring buffer ambiguity" problem this creates in
stmmac_rx_dirty() by explicitly checking if `cur_rx` is missing its
buffer(s).

Note that this changes the valid range of stmmac_rx_dirty()'s return
value from `0 <= x < dma_rx_size` to `0 <= x <= dma_rx_size`.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c    | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index d18ee145f5ca..9074668db8be 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -375,8 +375,11 @@ static inline u32 stmmac_rx_dirty(struct stmmac_priv *priv, u32 queue)
 {
 	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
 	u32 dirty;
+	struct stmmac_rx_buffer *buf = &rx_q->buf_pool[rx_q->cur_rx];
 
-	if (rx_q->dirty_rx <= rx_q->cur_rx)
+	if (!buf->page || (priv->sph_active && !buf->sec_page))
+		dirty = priv->dma_conf.dma_rx_size;
+	else if (rx_q->dirty_rx <= rx_q->cur_rx)
 		dirty = rx_q->cur_rx - rx_q->dirty_rx;
 	else
 		dirty = priv->dma_conf.dma_rx_size - rx_q->dirty_rx + rx_q->cur_rx;
@@ -5593,7 +5596,6 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
  */
 static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 {
-	int budget = limit;
 	u32 rx_errors = 0, rx_dropped = 0, rx_bytes = 0, rx_packets = 0;
 	struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[queue];
 	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
@@ -5610,8 +5612,6 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 	dma_dir = page_pool_get_dma_dir(rx_q->page_pool);
 	bufsz = DIV_ROUND_UP(priv->dma_conf.dma_buf_sz, PAGE_SIZE) * PAGE_SIZE;
-	limit = min(priv->dma_conf.dma_rx_size - stmmac_rx_dirty(priv, queue) - 1,
-		    (unsigned int)limit);
 
 	if (netif_msg_rx_status(priv)) {
 		void *rx_head;
@@ -5656,6 +5656,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		entry = next_entry;
 		buf = &rx_q->buf_pool[entry];
 
+		/* don't eat our own tail */
+		if (unlikely(!buf->page || (priv->sph_active && !buf->sec_page)))
+			break;
+
 		if (priv->extend_desc)
 			p = (struct dma_desc *)(rx_q->dma_erx + entry);
 		else
@@ -5874,8 +5878,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 	/* If the RX queue is completely dirty, we can't expect a future
 	 * interrupt; tell NAPI to keep polling.
 	 */
-	if (unlikely(stmmac_rx_dirty(priv, queue) == priv->dma_conf.dma_rx_size - 1))
-		return budget;
+	if (unlikely(stmmac_rx_dirty(priv, queue) == priv->dma_conf.dma_rx_size))
+		return limit;
 
 	return count;
 }
-- 
2.52.0


