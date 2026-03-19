Return-Path: <netdev+bounces-269616-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oC7fFXNDvGmAwAIAu9opvQ
	(envelope-from <netdev+bounces-269616-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:41:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D10C82D12C9
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BBDC3109D34
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C1B3F0749;
	Thu, 19 Mar 2026 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAe82fXB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2753876CE
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773945671; cv=none; b=ksHKr1zOCLVoEn9wf9olHhPtoHAJvqiQt/NBGJWy1xo85kZ4topYpPu4G1ugnWynC7cdMLSoPmI8Q35otC4mTyO/xwsw6rVlQfRAByZdZno1WWYpHMtj9LU6rTBFbLpx0GfO45FUhhUD1byZbTriDsxBaka+f2Xdd85Eg60tLhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773945671; c=relaxed/simple;
	bh=Un+tjKghOnSOGQJqIv2n+A/mJ2xTSQ27PpNpWvuI/2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oB3GnZeGKaEq+uzvQxSqVvUH/EGPtKbrejkMZfyqkiki9Er76jt6HSeTPKTv//G9kBONLjAB53aagT84YJRQSjlwg/9nB1H7/kdPwdXyJfiBlrO9Bk2YeuGI3ClAEN5OPl1hjNyR2SXmqQwdfK2UaZKazwXaB1ilIgxsXRBR8M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAe82fXB; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d7422b4ff1so391008a34.3
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 11:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773945667; x=1774550467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLw+KspfNI17fHokU2DyOGE90apcIrKC40CCDarAeuo=;
        b=GAe82fXBPp4IO7bTdInpZQ/m8FT6DtbVlsAwaUjc/xxt2ctFYH1ghLshR5/ke+gqKY
         FNyJqkHOLBJDK/v6OfAY4MPSWt7uN92PVvGpcP6IzNQyE6RrpkRT83TGhQJtols6HkE6
         F1x7ipXgh/xQzPeDfbJAL02rQwyydLlgqz4OxAb/U/5EkiodRaoq4m3YqbxaS16czCYy
         assYte3AXuBPvyFJF6nXJi62RlnZgG+gsnIJTA41K/+g4TYMtOS9Psmj9Om2dlH9cSjl
         XOqTw+7BLa10T1d+knLtMHG4/XGvzwZrs/2fOhNL5099L/fLo2VOaPHImuU4pJOrHEJ8
         iqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773945667; x=1774550467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FLw+KspfNI17fHokU2DyOGE90apcIrKC40CCDarAeuo=;
        b=M3nMemngtwrpHq8ORV8bCqNFAxyP9aHtN6ywNnvyoCYMXlbW+SauptpDK0pHy9ukO5
         sjuUe4AYbwv07uCuWHL0aDZlzejBeWGGnnbUL4YGAC2n/91f+sMwlFN4BYPUXBndzE8x
         DPv4D53DPSyUauQBl5FXqwzov9jTimj/3kC7o5iHccAHjZNp+NLAqhMwwL2FDYA/BKK3
         jFgvOt/KW280raY+xO0XeiFJPnk2pHmmXKdw+PSVeU9Nt/Oh3KyXdlDYReS5GZzptxUK
         iR82OrDNa/dZp3hn3N+b6xBltrKLoDybwm+4Gw1hMfx0+6BcuJ4YSePnPop4aXo7UsYl
         Vg8g==
X-Forwarded-Encrypted: i=1; AJvYcCX4eFVdxen7EJVTuHW2cPZdTKDggagtg0TYFqyvdGqnfWWz2lpWSj9oM/sffk3avp+OBj5OYc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8I/T3Ozi8+XCod3ype8BrxqgnwVojOND3vC6xijK5APGmXG0c
	22ZYwGGyP04oyTEKsVjG7uU1e1cHZDYLIYezFmboV0Ps0O9dwNuuyMKZ
X-Gm-Gg: ATEYQzwkVZgJ4oZV5OjpNun1zRHkHfFsTXTdPHvq5tRB1ogjl0JR3oW+ie8cq2dv2qv
	xNVeSBC+wQhQkPYsgwzBjNjiZFeryCF7jr8Nxjnp5S8mW55YElPay7Zz46t4g2m9fvvz9naqthR
	V5r4a5Q8fdYdRZEJ0xg1IE5CYquZ9BVmXblCt7Xo1iK9aKBnj3hGJU3K49/7Tl7zhhKGBwKzUNF
	t49jXRazC6ZScfsF9Xtq6BGPkusEl0bfcOE4WzG4Q/sH+H7Ak78zkb1kYtNiV1LB439ppWOhwH6
	RCZCTXQizQzokhrt02I1JyS86ZjKer9vMmNdYz2IRgfJaNbd2D3Ip1fLgOc8dzaA06OWbAphJHr
	RUagPMU4frebyRU6oHl+DWqHVeONu8AD8P8+0LdNvgYBywufOBk9hi9DReeT+hg9ykueAjL0cMy
	6YBpcyLAzCunkuKyF0pCwI3I8i9McPlGYsAS2zbTLZ3ca6zO9752+XTMV1FOTP6NMCUGl4kSjAS
	lzi5JCFsO8=
X-Received: by 2002:a05:6830:651c:b0:7d7:d0d5:5bf6 with SMTP id 46e09a7af769-7d7eaf4f4femr168906a34.21.1773945667481;
        Thu, 19 Mar 2026 11:41:07 -0700 (PDT)
Received: from celestia.turtle.lan (static-23-234-115-121.cust.tzulo.com. [23.234.115.121])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eadcb757sm181486a34.15.2026.03.19.11.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 11:41:06 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
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
	Sam Edwards <CFSworks@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] net: stmmac: Prevent NULL deref when RX memory exhausted
Date: Thu, 19 Mar 2026 11:40:30 -0700
Message-ID: <20260319184031.8596-2-CFSworks@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260319184031.8596-1-CFSworks@gmail.com>
References: <20260319184031.8596-1-CFSworks@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,bootlin.com,renesas.com,nxp.com,tkos.co.il,gmail.com,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-269616-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,kernel];
	NEURAL_HAM(-0.00)[-0.680];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D10C82D12C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The CPU receives frames from the MAC through conventional DMA: the CPU
allocates buffers for the MAC, then the MAC fills them and returns
ownership to the CPU. For each hardware RX queue, the CPU and MAC
coordinate through a shared ring array of DMA descriptors: one
descriptor per DMA buffer. Each descriptor includes the buffer's
physical address and a status flag ("OWN") indicating which side owns
the buffer: OWN=0 for CPU, OWN=1 for MAC. The CPU is only allowed to set
the flag and the MAC is only allowed to clear it, and both must move
through the ring in sequence: thus the ring is used for both
"submissions" and "completions."

In the stmmac driver, stmmac_rx() bookmarks its position in the ring
with the `cur_rx` index. The main receive loop in that function checks
for rx_descs[cur_rx].own=0, gives the corresponding buffer to the
network stack (NULLing the pointer), and increments `cur_rx` modulo the
ring size. After the loop exits, stmmac_rx_refill(), which bookmarks its
position with `dirty_rx`, allocates fresh buffers and rearms the
descriptors (setting OWN=1). If it fails any allocation, it simply stops
early (leaving OWN=0) and will retry where it left off when next called.

This means descriptors have a three-stage lifecycle (terms my own):
- `empty` (OWN=1, buffer valid)
- `full` (OWN=0, buffer valid and populated)
- `dirty` (OWN=0, buffer NULL)

But because stmmac_rx() only checks OWN, it confuses `full`/`dirty`. In
the past (see 'Fixes:'), there was a bug where the loop could cycle
`cur_rx` all the way back to the first descriptor it dirtied, resulting
in a NULL dereference when mistaken for `full`. The aforementioned
commit resolved that *specific* failure by capping the loop's iteration
limit at `dma_rx_size - 1`, but this is only a partial fix: if the
previous stmmac_rx_refill() didn't complete, then there are leftover
`dirty` descriptors that the loop might encounter without needing to
cycle fully around. The current code therefore panics (see 'Closes:')
when stmmac_rx_refill() is memory-starved long enough for `cur_rx` to
catch up to `dirty_rx`.

Fix this by further tightening the clamp from `dma_rx_size - 1` to
`dma_rx_size - stmmac_rx_dirty() - 1`, subtracting any remnant dirty
entries and limiting the loop so that `cur_rx` cannot catch back up to
`dirty_rx`. This carries no risk of arithmetic underflow: since the
maximum possible return value of stmmac_rx_dirty() is `dma_rx_size - 1`,
the worst the clamp can do is prevent the loop from running at all.

Fixes: b6cb4541853c7 ("net: stmmac: avoid rx queue overrun")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221010
Cc: stable@vger.kernel.org
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 6827c99bde8c..f98b070073c0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5609,7 +5609,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 	dma_dir = page_pool_get_dma_dir(rx_q->page_pool);
 	bufsz = DIV_ROUND_UP(priv->dma_conf.dma_buf_sz, PAGE_SIZE) * PAGE_SIZE;
-	limit = min(priv->dma_conf.dma_rx_size - 1, (unsigned int)limit);
+	limit = min(priv->dma_conf.dma_rx_size - stmmac_rx_dirty(priv, queue) - 1,
+		    (unsigned int)limit);
 
 	if (netif_msg_rx_status(priv)) {
 		void *rx_head;
-- 
2.52.0


