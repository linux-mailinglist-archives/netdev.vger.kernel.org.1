Return-Path: <netdev+bounces-273881-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOUqBH+dzGkDUgYAu9opvQ
	(envelope-from <netdev+bounces-273881-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 06:22:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAE0374A1F
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 06:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F55330579C6
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 04:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E0933F8C1;
	Wed,  1 Apr 2026 04:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVrHqiAx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B596378D68
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 04:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775017182; cv=none; b=cfjLt6Q/g6V12mwpooQof991nbHT2yEjghKspR2gJnEGQaLM8cg10DWWCWGQgs6oGAu2MN+ceSyckCVjeSjBTRuuZXxM/74voXoNv9N5TkpszLJjfRByDE5LF8QOBXzsSQV1vETbBQk/Qw6y7E4hUqBWj4PBAgth+6dqTCUaCQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775017182; c=relaxed/simple;
	bh=bQF1B63XcSzzW4Me2ZXYMgmme68wMnnLs+ouzSS6L0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dogx83Aj/3N8O6TSp+my2j5DIp+iMrQRxmj8gD3B+9cMuqmV0MI1qdmE0DKBB/nkmWJ31xDRYUntf3AlG7HrbN7gybQBNKAB0OgoUc3hJt685Ttc1ChI/97J5NXUB+weIs7bqbVLc7KaG3GmH+1DurJYM3NwQRi3NX/30dOIsEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVrHqiAx; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d86eb7c854so3418051a34.3
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 21:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775017180; x=1775621980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSD4qx/2JYM1VePcNlk14SPwVbO4qzamhYtHorOqJMs=;
        b=OVrHqiAxAkZKmdHA96j+FdaxWtp1x7oZ6BKNQTpBAyEKTYS137yxFTALfghB+kxEAH
         H+eeLuIatOurk2VcLSV++NiX29yc9wgXnyGUb/VH9w9MKn0D+MgcS9AvA1ns1o0yKKQH
         PP8ItPWMtnQpKJ+eMZhPorqzmgtEP7R9OVsR+ud7KlG+DvUNgSyt6UbzeAqRGA+CYwdf
         tRjskykQ5A8j/Q+SJHKiuCww9oc02alh7scPaAwZuJKJ48lerOkmMmvwFYxfkiVjOFg+
         67TQLAQ2w73XvGxThfc4s1JKSKhZkWed/n0JHi04G3YVLmeiY8Ckn/x/dRu3hjbuHz49
         vX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775017180; x=1775621980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DSD4qx/2JYM1VePcNlk14SPwVbO4qzamhYtHorOqJMs=;
        b=d5YiniKuePonYnzuv8rDOVZ6b9yrtuAg8J9Bpi3VaVINEz8pk+9crC74LqL6tig1Sg
         DtL5mdCkrW3sE+X80/9/XPYxdSgJ7eAYsNXmwX2n9h7rEXtWhqf/isV05fIvOqFxI6qn
         sWaY5+hOpoDm3GysmtW0O2RXDmFGg8N81i1BwstOMwSZ7bMWTdwMZTnRjI3reTK4F26y
         YAha9kf2NmppAZGNyE+SdYy+SMk11syy4F7ol2fSqbabYEQlcSrb+2NAjtM5CPkGbR32
         9vBF8rtT1P1kcS0t2UcIHRK77pfC6TJqSLPb//Dn2GMjXlrZ46JiyVq74Ro3I36OiUO8
         H3IA==
X-Forwarded-Encrypted: i=1; AJvYcCVczE4oVMlFvnuP8z39YYmfZBgaLD0rwASaENOJe2v1H22YjauvcJcaBEq/VBKIAgp1d4OeaAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn86WE11lgroY2MpX9UnMYTnu/i4UZNJMLfc9sgjeU6b0aqScG
	UGv1RaQLCBGvFyrIx5hupFAcnn8ky31uLOrTx5Fyvj1uGCFWYicuM7ga
X-Gm-Gg: ATEYQzx/lqZOtTAfXcACjq7y81IHJ+4spi4zjGE8yOQL854ED6Lvd9c5f8PBe9olvg7
	5EwbGRmhn6av/qmFB08XGJvWlY4O/oqb6aE3qw/S1wMVCPeOIePUsTa5dai37pJZTgVX/+fTsiL
	xF9ribMF9oQF5FtTS7k3ZKrtKMEg8jNpucKlyXu3W2EybIF0Gy0GV+05Uy70qTIw6vSSXuuOOWu
	O7Y4z42dh6Q3HDDbdkXitNPeZLTi4A5lH5ZDiM5QmVIi+sjJGR36o4CKF1U8P2z9t5NSIFLhGmR
	zZinYzpoCoOZ4tXfZIRviajKs027JyQYTM3Tbi+ZPwlpC1MMh7fszE//6WWapDCDdFhUhai/54W
	4ac1764I8mQlhe3uqIULmf83eKhhXsXN7Ca3d2GBVPCNg7l9aYJ4IfOvZPDchIxn7fbX+SyqBLA
	859t1UnagNBtJ0eik4fc/8S7oJLBkBVfxwbRrR9zDPL+UscJxba6NfioCsjBA=
X-Received: by 2002:a05:6830:452a:b0:7d7:db95:eee9 with SMTP id 46e09a7af769-7db994cf1b0mr1337728a34.30.1775017180356;
        Tue, 31 Mar 2026 21:19:40 -0700 (PDT)
Received: from localhost (static-23-234-115-121.cust.tzulo.com. [23.234.115.121])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7da0a384631sm9647188a34.7.2026.03.31.21.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 21:19:39 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Serge Semin <fancer.lancer@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v4 1/2] net: stmmac: Prevent NULL deref when RX memory exhausted
Date: Tue, 31 Mar 2026 21:19:28 -0700
Message-ID: <20260401041929.12392-2-CFSworks@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260401041929.12392-1-CFSworks@gmail.com>
References: <20260401041929.12392-1-CFSworks@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273881-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,renesas.com,nxp.com,tkos.co.il,st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3DAE0374A1F
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
index 13d3cac056be..fc11f75f7dc0 100644
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


