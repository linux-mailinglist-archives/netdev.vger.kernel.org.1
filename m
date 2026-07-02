Return-Path: <netdev+bounces-304240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6u9WOyarRmo4bQsAu9opvQ
	(envelope-from <netdev+bounces-304240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 20:17:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FC16FBE86
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 20:17:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="M/NoKBB/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304240-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304240-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77D6A312BDFB
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 17:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE71A33A70E;
	Thu,  2 Jul 2026 17:18:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8B2339844
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 17:18:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012706; cv=none; b=cFmJj5oEP81uh1ruCCwFOksn6c4zpY6Jdw+RvBPx8/ruAb/q8JC9y2yfW4bg4MW491IKFLO6ZfErjOSsZ/4+GOzIMQ/wTMvNvosoWcfyDX5vgrozeNEglnOVQpKdE3ZvN8ykYqmw+tOkxnyxtWlEWNJd1pd1/VAPSWqO4rTtVGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012706; c=relaxed/simple;
	bh=DzwCRGEA6VQiG3ebXHH4nanbKq9eVqmPS2zLy6M/Cxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Llo7BvmvBfgsmev8pbu7/bAZcE7PguOqcqNl0Wc10ZG/bR6MhDbBbY5sEBeTYbe18HaXsNxSb8BrrbuYbGaAsnydRR4g63IB0Q0ifooJeTU49xK2SiZFcoeZOVjMeab0jjibSjQYSRYBUj5SS11Q0W14XVuU39uvB6cVmJajH9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/NoKBB/; arc=none smtp.client-ip=209.85.216.52
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-37d55e8d3e3so886152a91.0
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 10:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783012704; x=1783617504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cvf2E/Sr8Di3zZhp26Vg9AffyL9oTXOTZb/a9Ug0O+U=;
        b=M/NoKBB/1t5oTrz0hFdrzBZL2ApBAuHNdIgN13r9fZnOJdY/x86yxPUC4A8QVioGoh
         5j04o/ZDnvLBIt4P0JoM5RhanP6DCnTjWk/O2YJoKVmKAMfyd8CEpdlAS8hx7faLpivT
         cnc1Jb/H/KscZWGClyV4SyBW43pVuRQ7Gf8XrCzuZaGeQ6VvXm0w312oi7UOx5Z9FUD7
         V1bnEq7LBsLKjEnd5Efd6kWPhb2azARG5IsLILKIuXvDL0fgC6+D8pPy7M422Kiwe0C6
         aPpyvf8mFNVteaHNmZVsD7njOEp8QB+jPd0dWBI4wQX7L+wuLR5fnIeO4EDAJs0frNhf
         0uNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783012704; x=1783617504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cvf2E/Sr8Di3zZhp26Vg9AffyL9oTXOTZb/a9Ug0O+U=;
        b=Xm59p+nOLkke6Zazv3OQ7JWejSu8iZMpATeOqa84LSn0ByqVZvRLuCG3fa11bC0xQY
         MzyV4/kTEvlkQgAXUjj1QwC8/6sRvQm/sBvRxzu9Bbx1XYruN6AbtMIjNQAu4eoGaHcP
         gJyYEOrIzp+cncJASIjfpFKqGAQEibu9ddMa6maY0nwMsEymEmJrl6SrsegHj0jgMI2e
         F3/iLHx4Dc1B+1PlIuHdtTlKdw1WITZODO6eYpcr42Skl6mMWeuCAZWIMRwpoUrJIvTb
         4tknnYR1wow+70552+8GU1NinKo8jswonFGlgqkCqxv8KLoHb00dMJtPMEeAzkmK/SFp
         vE0g==
X-Forwarded-Encrypted: i=1; AHgh+Rr2C0T5GjXaJy9pio3hTjC/WQjGn5idd7Z1nQ5hY4M3PhpmwRBrIPE5rLIDMnxHE+vO+i1EB6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu9Ktk2v8KfhKpmMZE9kb6IJZCN9q339Morv3WfaLHeBT4rAYl
	C0kwkPOT8tlCm/ldOjqxNDXeW0Q0IZhVFb1ojDw+u03tuLxrRuIbaS2c
X-Gm-Gg: AfdE7ckybW+8u8K362893MVQUU2Nvrc6xqVVzDVnar1uvKE6Lsk8O53vvE9PtMT3QzY
	57luzuo14jDBE9Op0Jj2+9GV1bLFcJpN2dJYWEB8dWuYkS/JowTxoLB1OvmDeeBZ3rFrhlc0iwp
	BEGdtQ9rPM9tpyd6/CjIJu452e9oeiNMfQnXQmrLN/gUdGUM0KwHUXB56gQec1hFu2agApqTlPk
	WAjd2d051W3UTYOnY6pUuCjjO2IaJqrfnrxffLUBjRHPtIxjpN+sqFK/vcdSx1VSGYdVWyRr/8r
	gclXq4PjBbNfKxQg66UXueHCZMOKMDeD9yez26/03ogE1sJbDmJkhsKildRvQLUCNia7pFBK5hO
	gB4LbSbMm5lf4grVaUJta80X4ELsS3f/SXpoVHFfD99M4Vw7GEQ3GdT2mcgxVCrOTx+mfQPvET9
	FXO4DBO7sguz2SgGnWjhiRFg==
X-Received: by 2002:a17:90b:4c52:b0:37c:8df2:9f58 with SMTP id 98e67ed59e1d1-381120ee1c1mr800372a91.7.1783012704187;
        Thu, 02 Jul 2026 10:18:24 -0700 (PDT)
Received: from nbai25050028.. ([2403:8600:2090:6f:9ad:7de7:16fc:b59f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f1595e912sm8488217eec.31.2026.07.02.10.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 10:18:23 -0700 (PDT)
From: Aniket Negi <aniket.negi03@gmail.com>
To: lorenzo@kernel.org,
	netdev@vger.kernel.org
Cc: Aniket Negi <aniket.negi03@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3] net: airoha: fix MIB stats collection to be lossless
Date: Thu,  2 Jul 2026 22:48:13 +0530
Message-ID: <20260702171814.11165-1-aniket.negi03@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lists.infradead.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-304240-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:netdev@vger.kernel.org,m:aniket.negi03@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:aniketnegi03@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[aniketnegi03@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aniketnegi03@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04FC16FBE86

The current driver resets hardware MIB counters after every read via
REG_FE_GDM_MIB_CLEAR. This creates a race window: packets arriving
between the read and the clear are silently lost from statistics.

Fix this by removing the MIB clear and switching to a delta-based
software tracking approach:

- 64-bit H+L registers (tx/rx ok pkts, ok bytes, E64..L1023):
  read the absolute hardware total directly each poll.

- 32-bit registers (drops, bc, mc, errors, runt, long, ...):
  store the previous raw register value in mib_prev and accumulate
  (u32)(curr - prev) into a 64-bit software counter. Unsigned
  subtraction handles wrap-around transparently.

- tx_len[0]/rx_len[0] ({0,64} RMON bucket) combines RUNT_CNT
  (32-bit, delta-tracked via mib_prev.tx_runt) and E64_CNT
  (64-bit, absolute). A u64 accumulator tx_runt64 holds the
  running RUNT delta sum so that each poll sets:
    tx_len[0] = tx_runt64 + E64_abs
  without double-counting the E64 value.

Merge airoha_dev_get_hw_stats() into airoha_update_hw_stats(),
moving the port spin_lock inside so callers do not need a separate
wrapper.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Aniket Negi <aniket.negi03@gmail.com>
---

Changes in v3:
  - Link to V2: https://lore.kernel.org/20260701173941.314795-1-aniket.negi03@gmail.com/
  - Add Acked-by tag from Lorenzo
  - Rename from tx_runt_cnt to tx_runt, tx_long_cnt to tx_long,
    tx_runt_accum64 to tx_runt64
  - Rename from rx_runt_cnt to rx_runt, rx_long_cnt to rx_long,
    rx_runt_accum64 to rx_runt64
  - Condense the marked comments in V2, remove new line after comment

Changes in v2:
  - Store _CNT_L register reads in val before adding to stats, improving
    readability (suggested by Lorenzo Bianconi)
  - Fix double-counting bug in the RUNT+E64 combined bucket: previously
    "+=" for E64 re-added the full absolute counter each poll; now a
    dedicated tx_runt_accum64/rx_runt_accum64 accumulator holds the
    running RUNT delta, and tx_len[0] is assigned (not accumulated) each
    poll as runt_accum64 + E64_abs
  - Replace 7-element tx_len[]/rx_len[] shadow arrays in mib_prev with
    focused tx_runt_cnt/tx_long_cnt and rx_runt_cnt/rx_long_cnt fields;
    only RUNT and LONG are 32-bit and need wrap-around tracking
  - Rename inner struct hw_prev_stats to mib_prev; rename accumulator
    fields to tx_runt_accum64/rx_runt_accum64 for clarity
  - Fix comment alignment in mib_prev struct block
  - Rename airoha_dev_get_hw_stats() to airoha_update_hw_stats() and
    move the port spin_lock inside, removing the separate wrapper

 drivers/net/ethernet/airoha/airoha_eth.c | 107 ++++++++++++-----------
 drivers/net/ethernet/airoha/airoha_eth.h |  27 ++++++
 2 files changed, 84 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 59001fd4b6f7..e009266fd268 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1686,12 +1686,14 @@ static void airoha_qdma_stop_napi(struct airoha_qdma *qdma)
 	}
 }
 
-static void airoha_dev_get_hw_stats(struct airoha_gdm_dev *dev)
+static void airoha_update_hw_stats(struct airoha_gdm_dev *dev)
 {
 	struct airoha_gdm_port *port = dev->port;
 	struct airoha_eth *eth = dev->eth;
 	u32 val, i = 0;
 
+	spin_lock(&port->stats_lock);
+
 	/* Read relevant MIB for GDM with multiple port attached */
 	if (port->id == AIROHA_GDM3_IDX || port->id == AIROHA_GDM4_IDX)
 		airoha_fe_rmw(eth, REG_FE_GDM_MIB_CFG(port->id),
@@ -1701,152 +1703,157 @@ static void airoha_dev_get_hw_stats(struct airoha_gdm_dev *dev)
 
 	u64_stats_update_begin(&dev->stats.syncp);
 
-	/* TX */
+	/* TX - 64-bit H+L registers: hw accumulates the total, read directly. */
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_H(port->id));
-	dev->stats.tx_ok_pkts += ((u64)val << 32);
+	dev->stats.tx_ok_pkts = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_L(port->id));
 	dev->stats.tx_ok_pkts += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE_CNT_H(port->id));
-	dev->stats.tx_ok_bytes += ((u64)val << 32);
+	dev->stats.tx_ok_bytes = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE_CNT_L(port->id));
 	dev->stats.tx_ok_bytes += val;
 
+	/* TX - 32-bit registers: accumulate delta to handle wrap-around. */
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_DROP_CNT(port->id));
-	dev->stats.tx_drops += val;
+	dev->stats.tx_drops += (u32)(val - dev->stats.mib_prev.tx_drops);
+	dev->stats.mib_prev.tx_drops = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_BC_CNT(port->id));
-	dev->stats.tx_broadcast += val;
+	dev->stats.tx_broadcast += (u32)(val - dev->stats.mib_prev.tx_broadcast);
+	dev->stats.mib_prev.tx_broadcast = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_MC_CNT(port->id));
-	dev->stats.tx_multicast += val;
+	dev->stats.tx_multicast += (u32)(val - dev->stats.mib_prev.tx_multicast);
+	dev->stats.mib_prev.tx_multicast = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_RUNT_CNT(port->id));
-	dev->stats.tx_len[i] += val;
+	dev->stats.mib_prev.tx_runt64 +=
+		(u32)(val - dev->stats.mib_prev.tx_runt);
+	dev->stats.mib_prev.tx_runt = val;
 
+	/* tx_len[0]: RUNT (32-bit, delta) + E64 (64-bit, absolute). */
+	dev->stats.tx_len[i] = dev->stats.mib_prev.tx_runt64;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT_H(port->id));
-	dev->stats.tx_len[i] += ((u64)val << 32);
+	dev->stats.tx_len[i] += (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT_L(port->id));
 	dev->stats.tx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L64_CNT_H(port->id));
-	dev->stats.tx_len[i] += ((u64)val << 32);
+	dev->stats.tx_len[i] = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L64_CNT_L(port->id));
 	dev->stats.tx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L127_CNT_H(port->id));
-	dev->stats.tx_len[i] += ((u64)val << 32);
+	dev->stats.tx_len[i] = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L127_CNT_L(port->id));
 	dev->stats.tx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L255_CNT_H(port->id));
-	dev->stats.tx_len[i] += ((u64)val << 32);
+	dev->stats.tx_len[i] = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L255_CNT_L(port->id));
 	dev->stats.tx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L511_CNT_H(port->id));
-	dev->stats.tx_len[i] += ((u64)val << 32);
+	dev->stats.tx_len[i] = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L511_CNT_L(port->id));
 	dev->stats.tx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L1023_CNT_H(port->id));
-	dev->stats.tx_len[i] += ((u64)val << 32);
+	dev->stats.tx_len[i] = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L1023_CNT_L(port->id));
 	dev->stats.tx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_LONG_CNT(port->id));
-	dev->stats.tx_len[i++] += val;
+	dev->stats.tx_len[i++] += (u32)(val - dev->stats.mib_prev.tx_long);
+	dev->stats.mib_prev.tx_long = val;
 
 	/* RX */
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_PKT_CNT_H(port->id));
-	dev->stats.rx_ok_pkts += ((u64)val << 32);
+	dev->stats.rx_ok_pkts = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_PKT_CNT_L(port->id));
 	dev->stats.rx_ok_pkts += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_BYTE_CNT_H(port->id));
-	dev->stats.rx_ok_bytes += ((u64)val << 32);
+	dev->stats.rx_ok_bytes = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_BYTE_CNT_L(port->id));
 	dev->stats.rx_ok_bytes += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_DROP_CNT(port->id));
-	dev->stats.rx_drops += val;
+	dev->stats.rx_drops += (u32)(val - dev->stats.mib_prev.rx_drops);
+	dev->stats.mib_prev.rx_drops = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_BC_CNT(port->id));
-	dev->stats.rx_broadcast += val;
+	dev->stats.rx_broadcast += (u32)(val - dev->stats.mib_prev.rx_broadcast);
+	dev->stats.mib_prev.rx_broadcast = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_MC_CNT(port->id));
-	dev->stats.rx_multicast += val;
+	dev->stats.rx_multicast += (u32)(val - dev->stats.mib_prev.rx_multicast);
+	dev->stats.mib_prev.rx_multicast = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ERROR_DROP_CNT(port->id));
-	dev->stats.rx_errors += val;
+	dev->stats.rx_errors += (u32)(val - dev->stats.mib_prev.rx_errors);
+	dev->stats.mib_prev.rx_errors = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_CRC_ERR_CNT(port->id));
-	dev->stats.rx_crc_error += val;
+	dev->stats.rx_crc_error += (u32)(val - dev->stats.mib_prev.rx_crc_error);
+	dev->stats.mib_prev.rx_crc_error = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OVERFLOW_DROP_CNT(port->id));
-	dev->stats.rx_over_errors += val;
+	dev->stats.rx_over_errors += (u32)(val - dev->stats.mib_prev.rx_over_errors);
+	dev->stats.mib_prev.rx_over_errors = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_FRAG_CNT(port->id));
-	dev->stats.rx_fragment += val;
+	dev->stats.rx_fragment += (u32)(val - dev->stats.mib_prev.rx_fragment);
+	dev->stats.mib_prev.rx_fragment = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_JABBER_CNT(port->id));
-	dev->stats.rx_jabber += val;
+	dev->stats.rx_jabber += (u32)(val - dev->stats.mib_prev.rx_jabber);
+	dev->stats.mib_prev.rx_jabber = val;
 
 	i = 0;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_RUNT_CNT(port->id));
-	dev->stats.rx_len[i] += val;
+	dev->stats.mib_prev.rx_runt64 +=
+		(u32)(val - dev->stats.mib_prev.rx_runt);
+	dev->stats.mib_prev.rx_runt = val;
 
+	/* rx_len[0]: RUNT (32-bit, delta) + E64 (64-bit, absolute). */
+	dev->stats.rx_len[i] = dev->stats.mib_prev.rx_runt64;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT_H(port->id));
-	dev->stats.rx_len[i] += ((u64)val << 32);
+	dev->stats.rx_len[i] += (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT_L(port->id));
 	dev->stats.rx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L64_CNT_H(port->id));
-	dev->stats.rx_len[i] += ((u64)val << 32);
+	dev->stats.rx_len[i] = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L64_CNT_L(port->id));
 	dev->stats.rx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L127_CNT_H(port->id));
-	dev->stats.rx_len[i] += ((u64)val << 32);
+	dev->stats.rx_len[i] = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L127_CNT_L(port->id));
 	dev->stats.rx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L255_CNT_H(port->id));
-	dev->stats.rx_len[i] += ((u64)val << 32);
+	dev->stats.rx_len[i] = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L255_CNT_L(port->id));
 	dev->stats.rx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L511_CNT_H(port->id));
-	dev->stats.rx_len[i] += ((u64)val << 32);
+	dev->stats.rx_len[i] = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L511_CNT_L(port->id));
 	dev->stats.rx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L1023_CNT_H(port->id));
-	dev->stats.rx_len[i] += ((u64)val << 32);
+	dev->stats.rx_len[i] = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L1023_CNT_L(port->id));
 	dev->stats.rx_len[i++] += val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_LONG_CNT(port->id));
-	dev->stats.rx_len[i++] += val;
+	dev->stats.rx_len[i] += (u32)(val - dev->stats.mib_prev.rx_long);
+	dev->stats.mib_prev.rx_long = val;
 
 	u64_stats_update_end(&dev->stats.syncp);
-}
-
-static void airoha_update_hw_stats(struct airoha_gdm_dev *dev)
-{
-	struct airoha_gdm_port *port = dev->port;
-	int i;
-
-	spin_lock(&port->stats_lock);
-
-	for (i = 0; i < ARRAY_SIZE(port->devs); i++) {
-		if (port->devs[i])
-			airoha_dev_get_hw_stats(port->devs[i]);
-	}
-
-	/* Reset MIB counters */
-	airoha_fe_set(dev->eth, REG_FE_GDM_MIB_CLEAR(port->id),
-		      FE_GDM_MIB_RX_CLEAR_MASK | FE_GDM_MIB_TX_CLEAR_MASK);
 
 	spin_unlock(&port->stats_lock);
 }
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index f6d01a8e8da1..dae9cfa6cc06 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -245,6 +245,33 @@ struct airoha_hw_stats {
 	u64 rx_fragment;
 	u64 rx_jabber;
 	u64 rx_len[7];
+
+	struct {
+		/* Previous HW register values for 32-bit counter delta
+		 * tracking. Storing the last seen value and accumulating
+		 * (u32)(curr - prev) into the 64-bit software counter
+		 * handles wrap-around transparently via unsigned arithmetic.
+		 * tx_runt64/rx_runt64 hold the running sum of runt deltas.
+		 * These fields are never reported to userspace.
+		 */
+		u32 tx_drops;
+		u32 tx_broadcast;
+		u32 tx_multicast;
+		u32 tx_runt;
+		u32 tx_long;
+		u64 tx_runt64;
+		u32 rx_drops;
+		u32 rx_broadcast;
+		u32 rx_multicast;
+		u32 rx_errors;
+		u32 rx_crc_error;
+		u32 rx_over_errors;
+		u32 rx_fragment;
+		u32 rx_jabber;
+		u32 rx_runt;
+		u32 rx_long;
+		u64 rx_runt64;
+	} mib_prev;
 };
 
 enum {

base-commit: a225f8c20712713406ae47024b8df42deacddd4a
-- 
2.43.0


