Return-Path: <netdev+bounces-305130-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ToS/H4/VS2pmbAEAu9opvQ
	(envelope-from <netdev+bounces-305130-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:19:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E60713231
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:19:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Gjd1CX6t;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305130-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305130-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05A1E4492DC
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 15:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD55433BBD;
	Mon,  6 Jul 2026 15:47:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F6D433BA9
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 15:47:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352864; cv=none; b=CIqdK47yZmLff/cxBcS4ts3h0FZ2ncqWor2bbVbRWhbZ+60bmeHutHT2j3TTMi/PgxqeFK5U8hwcQrOUzw1+G9/OOrNNNQ2wHkx1qSGo4554LhAFRSrYTR+X28Y2GC5Mrao1l3Wz52fXsR4/EFwdcrFrlEOjUuZUCYdglXVvbTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352864; c=relaxed/simple;
	bh=oH0sTbwQ663Xmcy6rHuGes8/N20E+A67dWFhW+fOMQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DSMv5xfUfSWVmiCPQcbGvL1fFH9uEvXUgyqia4mm5ffuXkNBf4yupNigRBj9smYFouo6tX93aQiwCLEfKJLUXlNfOAFmBbOb4WTGhAXgAEjguAgWUgf4X1knx6gm9L9r9U3WuIyzi/suQQBqhjhx1hTCrldCX6FvIc1bh3/1mfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gjd1CX6t; arc=none smtp.client-ip=209.85.215.175
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c9c80265bd7so1826913a12.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 08:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783352861; x=1783957661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bxo/RBici1KHmWo5VMuoBPKotHXzJ2Oo7XpCXsYzf3Q=;
        b=Gjd1CX6tMMkTpmuxL1CULRuOyPlYivJP3l21fXrKvWwaSi3pLv3h7f1q/cdwx9+qUh
         l9qh+7/oLBGvUsQMUlkzU3EACegXWuOorU7ORObxPjF4CcpWpvRCln5QgLpMf4reRanb
         XSPbMvWNX+Eww8q9enO0mkizDPyk5tT9NFdQdzBIfV87Av1dpjnwS3dqdLeDAt6CJQB/
         oXQxr3yqWPbPgNpbYhfInhpIC6D2TsZq4iAIdxzWKv4WxRum+0THhlIsv627kgFBC+TR
         ZdKfNHViR1eZEP036/ESvI3yPNq7SReiPRXgL/ziWdqTz7p+JITGpDbdzxWiEpBE/5Nk
         L2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352861; x=1783957661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bxo/RBici1KHmWo5VMuoBPKotHXzJ2Oo7XpCXsYzf3Q=;
        b=GupMUJ6YZEWOmKQ28kuR2aVXZRpwwyiOxvYd2Y5hsMLkV3eyhC2bQ6EnHmYLz/vdhe
         hGvmQyfN60SP7uvhFs+EMmZx3NueCqKQ0Y1b7LLGftMCzAlakvb38jh+4o7yqMtr0MFP
         kD4uip7ftKHp9c4vY5MDNvmJCMB9bem6qiMc3zP6Y437uN0yxmVypmeLgsatvmKHynqD
         zPGWy6d72yInbd1ypMRlSLrG0govaNC913rwLIIZfz8KT1y3KBKYyCKfyk/oO7OVQbd6
         gBWA9OLNgisWzwItbAv3Y2X+FSg2gelEiKiEtyB4Rjd21SNspNp/BDVnyAsD/8mx+oI7
         9gEw==
X-Gm-Message-State: AOJu0YyBYYK0QmOJJcDS2b3IcJyHyOeS2QcGSVHyrjju4UNaUyX3HlBB
	tSrYV7RwarU2hEUr8tcM/jrWOhdlVgRUO2fQjgvuj7K/vYcY+bBUxOpe6x4K73VCexxJwA==
X-Gm-Gg: AfdE7cn2K7Vrpyo89uA1iFF8awLBg6GfmWuHJrBmdl7+89NTJAxOIfymTdg1lUZKx0a
	mKA8LS2E1sYqFajoLmbnr3Mvp93HBPu1oK99TyygI0ASTwbx8F6gUWqqJ5NVVdSdyy2GSO4GjS7
	IL0BA7oVaeIvwTli5XFTm43TFmTtbj1HbnZ7h41nFmjXI9FUHbj9843CEZA8M2Ils4dvN72fkBP
	P+JeaeGNkMeSl1Rz4R19yNZVPCbecf+q43mpn5ikxJNcy5OpYM51VglG2SEbA3DXf4tTYyTbtRC
	D4BXlzpmiOin3Uc48PQpkUiHlNzlczEyI+2OS2rQ1YN01xR9lKJrm2hmtSvoWXLFZ0zGWqn6Qqb
	j8tulpxZGVBuIbFzjpjR0+YTqDEG832970pc9Ybj8HbHNs4tyJNDg0jvc1KYQ1Nh4JtWvEXBWXC
	rP86B2ttKznpyXIugqW8blRAg=
X-Received: by 2002:a05:6a21:7a43:b0:3bf:a0e5:999a with SMTP id adf61e73a8af0-3c08ef5aa6fmr1432511637.48.1783352861289;
        Mon, 06 Jul 2026 08:47:41 -0700 (PDT)
Received: from nbai25050028.. ([2403:8600:2090:6f:1840:f07b:ed1c:fca2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7fa65asm56885602c88.6.2026.07.06.08.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 08:47:40 -0700 (PDT)
From: Aniket Negi <aniket.negi03@gmail.com>
To: netdev@vger.kernel.org,
	lorenzo@kernel.org
Cc: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	aniket.negi@airoha.com,
	kuldeep.malik@airoha.com,
	Aniket Negi <aniket.negi03@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4] net: airoha: fix MIB stats collection to be lossless
Date: Mon,  6 Jul 2026 21:17:30 +0530
Message-ID: <20260706154730.36949-1-aniket.negi03@gmail.com>
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
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-305130-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:aniket.negi@airoha.com,m:kuldeep.malik@airoha.com,m:aniket.negi03@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ansuelsmth@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:matthiasbgg@gmail.com,m:aniketnegi03@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[aniketnegi03@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,collabora.com,airoha.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lists.infradead.org,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aniketnegi03@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D6E60713231

REG_FE_GDM_MIB_CLEAR after every read creates a race window where
packets arriving between read and clear are lost from statistics.

Switch to a delta-based approach instead:

- 64-bit H+L registers (ok pkts/bytes, E64..L1023): read absolute
  hardware total directly; use a local variable and max(new, old)
  clamping to prevent intermediate visibility and torn-read regression.

- 32-bit registers (drops, bc, mc, errors, runt, long): accumulate
  (u32)(curr - prev) into a 64-bit software counter; unsigned
  subtraction handles wrap-around transparently.

- tx/rx_len[0] ([0,64] bucket): combines RUNT_CNT (32-bit, delta via
  tx_runt/rx_runt) and E64_CNT (64-bit, absolute) into a single
  assignment using a local accumulator to avoid double-counting.

Clear MIB counters once in airoha_fe_init() to establish a clean
baseline, preventing spurious stats from pre-driver activity (kexec,
driver rebind, warm reboot).

Merge airoha_dev_get_hw_stats() into airoha_update_hw_stats() and
move stats_lock inside. Plain spin_lock() is correct: the function
is only called from ndo_get_stats64() in process context. Each dev
refreshes only its own MIB counters; sibling devs on a shared GDM3/4
port are polled when their own netdev is queried.

Fixes: 8f4695fb67b2 ("net: airoha: better handle MIBs for GDM ports with multiple devs attached")
Signed-off-by: Aniket Negi <aniket.negi03@gmail.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v4:
- Add max(new, old) clamping for 64-bit H+L register pairs to ensure
  monotonically non-decreasing stats despite torn reads between H and L
- Use local variable (tmp) for all 64-bit H+L computations to prevent
  lockless readers from seeing intermediate values during piecewise write
- Add one-shot MIB counter clear in airoha_fe_init() to establish a
  clean baseline (kexec, driver rebind, warm reboot)
- Document sibling dev polling design in commit message

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

 drivers/net/ethernet/airoha/airoha_eth.c | 183 +++++++++++++++--------
 drivers/net/ethernet/airoha/airoha_eth.h |  27 ++++
 2 files changed, 144 insertions(+), 66 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 59001fd4b6f7..2d032cc6dfca 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -493,6 +493,8 @@ static void airoha_fe_crsn_qsel_init(struct airoha_eth *eth)
 
 static int airoha_fe_init(struct airoha_eth *eth)
 {
+	int i;
+
 	airoha_fe_maccr_init(eth);
 
 	/* PSE IQ reserve */
@@ -586,6 +588,14 @@ static int airoha_fe_init(struct airoha_eth *eth)
 	/* enable 1:N vlan action, init vlan table */
 	airoha_fe_set(eth, REG_MC_VLAN_EN, MC_VLAN_EN_MASK);
 
+	/* Clear MIB counters to establish clean baseline for delta tracking.
+	 * This prevents spurious statistics from pre-driver activity (e.g.,
+	 * kexec, driver rebind, warm reboot) on first poll.
+	 */
+	for (i = AIROHA_GDM1_IDX; i <= AIROHA_GDM4_IDX; i++)
+		airoha_fe_set(eth, REG_FE_GDM_MIB_CLEAR(i),
+			      FE_GDM_MIB_RX_CLEAR_MASK | FE_GDM_MIB_TX_CLEAR_MASK);
+
 	return airoha_fe_mc_vlan_clear(eth);
 }
 
@@ -1686,11 +1696,14 @@ static void airoha_qdma_stop_napi(struct airoha_qdma *qdma)
 	}
 }
 
-static void airoha_dev_get_hw_stats(struct airoha_gdm_dev *dev)
+static void airoha_update_hw_stats(struct airoha_gdm_dev *dev)
 {
 	struct airoha_gdm_port *port = dev->port;
 	struct airoha_eth *eth = dev->eth;
 	u32 val, i = 0;
+	u64 tmp, prev;
+
+	spin_lock(&port->stats_lock);
 
 	/* Read relevant MIB for GDM with multiple port attached */
 	if (port->id == AIROHA_GDM3_IDX || port->id == AIROHA_GDM4_IDX)
@@ -1701,152 +1714,190 @@ static void airoha_dev_get_hw_stats(struct airoha_gdm_dev *dev)
 
 	u64_stats_update_begin(&dev->stats.syncp);
 
-	/* TX */
+	/* TX - 64-bit H+L registers: hw accumulates the total, read directly.
+	 * Use local variable to prevent readers from seeing intermediate values.
+	 * Clamp to prevent regression from torn reads between H and L.
+	 */
+	prev = dev->stats.tx_ok_pkts;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_H(port->id));
-	dev->stats.tx_ok_pkts += ((u64)val << 32);
+	tmp = ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_L(port->id));
-	dev->stats.tx_ok_pkts += val;
+	tmp |= val;
+	dev->stats.tx_ok_pkts = max(tmp, prev);
 
+	prev = dev->stats.tx_ok_bytes;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE_CNT_H(port->id));
-	dev->stats.tx_ok_bytes += ((u64)val << 32);
+	tmp = ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE_CNT_L(port->id));
-	dev->stats.tx_ok_bytes += val;
+	tmp |= val;
+	dev->stats.tx_ok_bytes = max(tmp, prev);
 
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
+	tmp = dev->stats.mib_prev.tx_runt64;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT_H(port->id));
-	dev->stats.tx_len[i] += ((u64)val << 32);
+	tmp += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT_L(port->id));
-	dev->stats.tx_len[i++] += val;
+	tmp += val;
+	dev->stats.tx_len[i++] = tmp;
 
+	prev = dev->stats.tx_len[i];
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L64_CNT_H(port->id));
-	dev->stats.tx_len[i] += ((u64)val << 32);
+	tmp = ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L64_CNT_L(port->id));
-	dev->stats.tx_len[i++] += val;
+	tmp |= val;
+	dev->stats.tx_len[i++] = max(tmp, prev);
 
+	prev = dev->stats.tx_len[i];
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L127_CNT_H(port->id));
-	dev->stats.tx_len[i] += ((u64)val << 32);
+	tmp = ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L127_CNT_L(port->id));
-	dev->stats.tx_len[i++] += val;
+	tmp |= val;
+	dev->stats.tx_len[i++] = max(tmp, prev);
 
+	prev = dev->stats.tx_len[i];
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L255_CNT_H(port->id));
-	dev->stats.tx_len[i] += ((u64)val << 32);
+	tmp = ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L255_CNT_L(port->id));
-	dev->stats.tx_len[i++] += val;
+	tmp |= val;
+	dev->stats.tx_len[i++] = max(tmp, prev);
 
+	prev = dev->stats.tx_len[i];
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L511_CNT_H(port->id));
-	dev->stats.tx_len[i] += ((u64)val << 32);
+	tmp = ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L511_CNT_L(port->id));
-	dev->stats.tx_len[i++] += val;
+	tmp |= val;
+	dev->stats.tx_len[i++] = max(tmp, prev);
 
+	prev = dev->stats.tx_len[i];
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L1023_CNT_H(port->id));
-	dev->stats.tx_len[i] += ((u64)val << 32);
+	tmp = ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L1023_CNT_L(port->id));
-	dev->stats.tx_len[i++] += val;
+	tmp |= val;
+	dev->stats.tx_len[i++] = max(tmp, prev);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_LONG_CNT(port->id));
-	dev->stats.tx_len[i++] += val;
+	dev->stats.tx_len[i++] += (u32)(val - dev->stats.mib_prev.tx_long);
+	dev->stats.mib_prev.tx_long = val;
 
 	/* RX */
+	prev = dev->stats.rx_ok_pkts;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_PKT_CNT_H(port->id));
-	dev->stats.rx_ok_pkts += ((u64)val << 32);
+	tmp = ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_PKT_CNT_L(port->id));
-	dev->stats.rx_ok_pkts += val;
+	tmp |= val;
+	dev->stats.rx_ok_pkts = max(tmp, prev);
 
+	prev = dev->stats.rx_ok_bytes;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_BYTE_CNT_H(port->id));
-	dev->stats.rx_ok_bytes += ((u64)val << 32);
+	tmp = ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_BYTE_CNT_L(port->id));
-	dev->stats.rx_ok_bytes += val;
+	tmp |= val;
+	dev->stats.rx_ok_bytes = max(tmp, prev);
 
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
+	tmp = dev->stats.mib_prev.rx_runt64;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT_H(port->id));
-	dev->stats.rx_len[i] += ((u64)val << 32);
+	tmp += ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT_L(port->id));
-	dev->stats.rx_len[i++] += val;
+	tmp += val;
+	dev->stats.rx_len[i++] = tmp;
 
+	prev = dev->stats.rx_len[i];
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L64_CNT_H(port->id));
-	dev->stats.rx_len[i] += ((u64)val << 32);
+	tmp = ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L64_CNT_L(port->id));
-	dev->stats.rx_len[i++] += val;
+	tmp |= val;
+	dev->stats.rx_len[i++] = max(tmp, prev);
 
+	prev = dev->stats.rx_len[i];
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L127_CNT_H(port->id));
-	dev->stats.rx_len[i] += ((u64)val << 32);
+	tmp = ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L127_CNT_L(port->id));
-	dev->stats.rx_len[i++] += val;
+	tmp |= val;
+	dev->stats.rx_len[i++] = max(tmp, prev);
 
+	prev = dev->stats.rx_len[i];
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L255_CNT_H(port->id));
-	dev->stats.rx_len[i] += ((u64)val << 32);
+	tmp = ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L255_CNT_L(port->id));
-	dev->stats.rx_len[i++] += val;
+	tmp |= val;
+	dev->stats.rx_len[i++] = max(tmp, prev);
 
+	prev = dev->stats.rx_len[i];
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L511_CNT_H(port->id));
-	dev->stats.rx_len[i] += ((u64)val << 32);
+	tmp = ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L511_CNT_L(port->id));
-	dev->stats.rx_len[i++] += val;
+	tmp |= val;
+	dev->stats.rx_len[i++] = max(tmp, prev);
 
+	prev = dev->stats.rx_len[i];
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L1023_CNT_H(port->id));
-	dev->stats.rx_len[i] += ((u64)val << 32);
+	tmp = ((u64)val << 32);
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L1023_CNT_L(port->id));
-	dev->stats.rx_len[i++] += val;
+	tmp |= val;
+	dev->stats.rx_len[i++] = max(tmp, prev);
 
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
index f6d01a8e8da1..fe934f9ffe8a 100644
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


