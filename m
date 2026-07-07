Return-Path: <netdev+bounces-305517-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vEXSA1IcTWoDvQEAu9opvQ
	(envelope-from <netdev+bounces-305517-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 17:33:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D3271D51A
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 17:33:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=rXoAmuEM;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305517-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305517-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1295300AEEF
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 15:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E45E42A79F;
	Tue,  7 Jul 2026 15:28:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C75E3E9C2F
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 15:28:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438092; cv=none; b=lqqYDe3nsO+0CWSDoaOhRKc44lfHvoOGEE3C6aZhIMgSAdCVOidHEiAIqH1eOTQgE7eGhtUX9+OkTswevFhOFHSWwoEZ0/7dHBCthcJS/Uegk/OJur6tOzcwv7pmUv9DhrHEyGo9HIGPb/z/LBs0RZkN0tBAqTZIFQ6QZMLbj1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438092; c=relaxed/simple;
	bh=eSxdKYYUXJWXnIb0XAJc2gthLMW2JuIbP53qkxxtKfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bIwzPBTEuuuRnRZUQV2YKB3H3cPJv8FgspTBpj9lVoGiWSmtEJVvAD9oI3hS4K70FDe3McVuWPEDVgQ3K3ESbhZ5PdD70qjhorPuog/paIsnCrp3dKF/uI2zm7lOIiiCZeeDxZevRxaKWGqS6SlpN3pkWkRkyTctvYijbGdvgaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rXoAmuEM; arc=none smtp.client-ip=209.85.215.174
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c8fee9f63d5so2419951a12.0
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 08:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783438089; x=1784042889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IDMoN0bEsmLd2wW0JNho3RIDJxtQ9qetIskk897+fdU=;
        b=rXoAmuEMlirLUkmKfJ2eMlj6dFM/9C/OdVTtfq7+U0ib+UvUrffdroX48Idm+zyLMn
         lGqJurCNraetU6fPnxqg0QLKmt3kWHrWP7YkydfbGKpEfO2knPhe9wpooNvWJ6uE3oi7
         ewgQdlBCNKeNLwnOB2kgZZnWDUe/6OSP2Fv2/oZGWi62xkxydhqV7Ed+eR8shCupCMKp
         RWy9tmhyEXr9R3Kf/vlgR5xgGvKwrIiHfyzQzNfRJ32EIgKVd/4QCeqeTPVAfJwkmMAK
         n1Za1DRWulOz2L5Jd01nmVddBXN2WZIXwmoZELYL06MOOg0mAbyMaNNuopnRypQ7OyWN
         Sqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783438089; x=1784042889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IDMoN0bEsmLd2wW0JNho3RIDJxtQ9qetIskk897+fdU=;
        b=p8kWeIGgM2Wu9XKRCKpa8GrNdnl9iqeIA5UEkLuO0K/QltvXMt++ozlW++SaRe5Y3m
         xo8HQIdqkkEYnPiysh7L4C0N8c7GtqquozwwcoD916XU29yMGzOt4K1+ygN9ZRL/EwYv
         S8Vv/7Zj5cYM/JyHqx89BOgUp0KJm/bYICgEF/DYrzJRX62j8Y4UzavqWbdU9NrXhquk
         IE3KOOD3kX0rKIig3Fc2vwoHigtNT5x40K5F6WyPmcLZcytvIsGA6e5bJuJcubZdP7lh
         OZb5CZCwVrTBk5+WXqxsq4pw8gRiWnib19VtBvHRUENsRtsJvf3B0el+Qye2+UWWT/rk
         xn9w==
X-Gm-Message-State: AOJu0YxPiVcjkbCk+je3Ep+pVIrhoCe3uZNBNne+vbtxFuAVBfaD/AQg
	bguP1hp3LTM5SOqDufTlzVkwglhJtYOLUEeqdsQC+riJR7BkSTIuf2VCvHFFVVQIYeRoig==
X-Gm-Gg: AfdE7cmE2rBBg7+ZFzutUHGC7DycO0l/qRcNpdWxVnjgHgTO1WtXZTe5Lt4Hdb7OJFI
	eyBw22Bg8QPb0Ear7e0p82mjrKVju1utpgNCkM8d2E93C5uwziOl3ydPrdepXKkRbvZt/U3uMyN
	EDyDr/UHunNucewwJLknoSo+8fjSwhdXOZjCYKKwDYb5TC9ONNzAm8VVBCB3OOWkfSs5Qev8haG
	cm+Y9BEliUPBYWuxWT+mWuDOtQQCQqXrX8AcWsgrWDNxjuOwbT0v3pDOc87z/pPTHfLF5CKXSN+
	2PfZ030Ds5Jn9W24iXH4WU6sWbKB59tV+Q7WolTL/AQI5s+tgihy3VuEUP/h+YazaZPiUuNMUHT
	jOq/QpM71JlJ2gFw6vF82lB7X1qqulHfUIVqNS+VSa6h3y8NFs6U2PTaAycM1y22rjYzYVWIo0I
	zYfGWdCAw69T9WWZDuYwgJFA==
X-Received: by 2002:a05:6a20:4327:b0:3bf:9cbd:9a39 with SMTP id adf61e73a8af0-3c08ece2d18mr6988091637.10.1783438089505;
        Tue, 07 Jul 2026 08:28:09 -0700 (PDT)
Received: from nbai25050028.. ([2403:8600:2090:6f:6cd2:7b5:da34:d79b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b6593c4ddsm10878316c88.1.2026.07.07.08.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:28:09 -0700 (PDT)
From: Aniket Negi <aniket.negi03@gmail.com>
To: netdev@vger.kernel.org,
	lorenzo@kernel.org
Cc: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	aniket.negi@airoha.com,
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
Subject: [PATCH net v5] net: airoha: fix MIB stats collection to be lossless
Date: Tue,  7 Jul 2026 20:56:39 +0530
Message-ID: <20260707152639.105628-1-aniket.negi03@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-305517-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:aniket.negi@airoha.com,m:aniket.negi03@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ansuelsmth@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:matthiasbgg@gmail.com,m:aniketnegi03@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[aniketnegi03@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,collabora.com,airoha.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lists.infradead.org,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72D3271D51A

REG_FE_GDM_MIB_CLEAR after every read creates a race window where
packets arriving between read and clear are lost from statistics.

Switch to a delta-based approach instead:

- 64-bit H+L registers (ok pkts/bytes, E64..L1023): read absolute
  hardware total directly into a local variable; clamp with max(new, old)
  to prevent torn-read regression when the counter carries between the
  two reads.

- 32-bit registers (drops, bc, mc, errors, runt, long): accumulate
  (u32)(curr - prev) into a 64-bit software counter; unsigned
  subtraction handles wrap-around transparently.

- tx/rx_len[0] ([0,64] bucket): combines RUNT_CNT (32-bit, delta via
  tx_runt/rx_runt) and E64_CNT (64-bit, absolute) into a single local
  accumulator; max(new, old) applied here too to guard against a torn
  read of E64 when the RUNT accumulator is unchanged between polls.

MIB counters are zeroed by the SCU FE reset (EN7581_FE_RST) asserted
in airoha_hw_init() at module load, so no explicit MIB clear is needed
in airoha_fe_init().

Merge airoha_dev_get_hw_stats() into airoha_update_hw_stats() and
move stats_lock inside. Plain spin_lock() is correct: the function
is only called from ndo_get_stats64() in process context. Each dev
refreshes only its own MIB counters; sibling devs on a shared GDM3/4
port are polled when their own netdev is queried.

Fixes: 8f4695fb67b2 ("net: airoha: better handle MIBs for GDM ports with multiple devs attached")
Signed-off-by: Aniket Negi <aniket.negi03@gmail.com>
---

Changes in v5:
- Link to V4: https://lore.kernel.org/20260706154730.36949-1-aniket.negi03@gmail.com
- Drop MIB clear loop from airoha_fe_init(): SCU FE reset (EN7581_FE_RST)
  resets MIB counters at module load, making the explicit clear redundant
- Rename local variable tmp -> data; drop prev variable; use + instead
  of | for H+L combination; inline max(data, dev->stats.x) per
  maintainer nits (Lorenzo Bianconi)
- Extend max() clamping to the hybrid tx/rx_len[0] (RUNT+E64) bucket to
  guard against E64 torn reads when the RUNT accumulator is stable
- Fix undefined behaviour: split i++ out of expressions that also read
  i as an array subscript in the same statement
- Retain REG_FE_GDM_MIB_CLEAR/FE_GDM_MIB_{RX,TX}_CLEAR_MASK definitions
  in airoha_regs.h as register documentation (per Lorenzo Bianconi)

Changes in v4:
- Add max(new, old) clamping for 64-bit H+L register pairs to ensure
  monotonically non-decreasing stats despite torn reads between H and L
- Use local variable for all 64-bit H+L computations to prevent lockless
  readers from seeing intermediate values during piecewise write
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
- Link to V1: https://lore.kernel.org/20260630111834.233643-1-aniket.negi03@gmail.com
- Store _CNT_L register reads in val before adding to stats
- Fix double-counting bug in the RUNT+E64 combined bucket
- Replace 7-element tx_len[]/rx_len[] shadow arrays with focused fields
- Rename inner struct hw_prev_stats to mib_prev
- Rename airoha_dev_get_hw_stats() to airoha_update_hw_stats() and
  move the port spin_lock inside, removing the separate wrapper
---
 drivers/net/ethernet/airoha/airoha_eth.c | 171 ++++++++++++++---------
 drivers/net/ethernet/airoha/airoha_eth.h |  27 ++++
 2 files changed, 132 insertions(+), 66 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 59001fd4b6f7..90aa8b0210bd 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1686,11 +1686,14 @@ static void airoha_qdma_stop_napi(struct airoha_qdma *qdma)
 	}
 }
 
-static void airoha_dev_get_hw_stats(struct airoha_gdm_dev *dev)
+static void airoha_update_hw_stats(struct airoha_gdm_dev *dev)
 {
 	struct airoha_gdm_port *port = dev->port;
 	struct airoha_eth *eth = dev->eth;
 	u32 val, i = 0;
+	u64 data;
+
+	spin_lock(&port->stats_lock);
 
 	/* Read relevant MIB for GDM with multiple port attached */
 	if (port->id == AIROHA_GDM3_IDX || port->id == AIROHA_GDM4_IDX)
@@ -1701,152 +1704,188 @@ static void airoha_dev_get_hw_stats(struct airoha_gdm_dev *dev)
 
 	u64_stats_update_begin(&dev->stats.syncp);
 
-	/* TX */
+	/* TX - 64-bit H+L registers: hw accumulates the total, read directly.
+	 * Use local variable to prevent readers from seeing intermediate values.
+	 * Clamp to prevent regression from torn reads between H and L.
+	 */
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_H(port->id));
-	dev->stats.tx_ok_pkts += ((u64)val << 32);
+	data = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_L(port->id));
-	dev->stats.tx_ok_pkts += val;
+	data += val;
+	dev->stats.tx_ok_pkts = max(data, dev->stats.tx_ok_pkts);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE_CNT_H(port->id));
-	dev->stats.tx_ok_bytes += ((u64)val << 32);
+	data = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE_CNT_L(port->id));
-	dev->stats.tx_ok_bytes += val;
+	data += val;
+	dev->stats.tx_ok_bytes = max(data, dev->stats.tx_ok_bytes);
 
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
+	data = dev->stats.mib_prev.tx_runt64;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT_H(port->id));
-	dev->stats.tx_len[i] += ((u64)val << 32);
+	data += (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT_L(port->id));
-	dev->stats.tx_len[i++] += val;
+	data += val;
+	dev->stats.tx_len[i] = max(data, dev->stats.tx_len[i]);
+	i++;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L64_CNT_H(port->id));
-	dev->stats.tx_len[i] += ((u64)val << 32);
+	data = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L64_CNT_L(port->id));
-	dev->stats.tx_len[i++] += val;
+	data += val;
+	dev->stats.tx_len[i] = max(data, dev->stats.tx_len[i]);
+	i++;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L127_CNT_H(port->id));
-	dev->stats.tx_len[i] += ((u64)val << 32);
+	data = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L127_CNT_L(port->id));
-	dev->stats.tx_len[i++] += val;
+	data += val;
+	dev->stats.tx_len[i] = max(data, dev->stats.tx_len[i]);
+	i++;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L255_CNT_H(port->id));
-	dev->stats.tx_len[i] += ((u64)val << 32);
+	data = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L255_CNT_L(port->id));
-	dev->stats.tx_len[i++] += val;
+	data += val;
+	dev->stats.tx_len[i] = max(data, dev->stats.tx_len[i]);
+	i++;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L511_CNT_H(port->id));
-	dev->stats.tx_len[i] += ((u64)val << 32);
+	data = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L511_CNT_L(port->id));
-	dev->stats.tx_len[i++] += val;
+	data += val;
+	dev->stats.tx_len[i] = max(data, dev->stats.tx_len[i]);
+	i++;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L1023_CNT_H(port->id));
-	dev->stats.tx_len[i] += ((u64)val << 32);
+	data = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L1023_CNT_L(port->id));
-	dev->stats.tx_len[i++] += val;
+	data += val;
+	dev->stats.tx_len[i] = max(data, dev->stats.tx_len[i]);
+	i++;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_LONG_CNT(port->id));
-	dev->stats.tx_len[i++] += val;
+	dev->stats.tx_len[i++] += (u32)(val - dev->stats.mib_prev.tx_long);
+	dev->stats.mib_prev.tx_long = val;
 
 	/* RX */
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_PKT_CNT_H(port->id));
-	dev->stats.rx_ok_pkts += ((u64)val << 32);
+	data = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_PKT_CNT_L(port->id));
-	dev->stats.rx_ok_pkts += val;
+	data += val;
+	dev->stats.rx_ok_pkts = max(data, dev->stats.rx_ok_pkts);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_BYTE_CNT_H(port->id));
-	dev->stats.rx_ok_bytes += ((u64)val << 32);
+	data = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_BYTE_CNT_L(port->id));
-	dev->stats.rx_ok_bytes += val;
+	data += val;
+	dev->stats.rx_ok_bytes = max(data, dev->stats.rx_ok_bytes);
 
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
+	data = dev->stats.mib_prev.rx_runt64;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT_H(port->id));
-	dev->stats.rx_len[i] += ((u64)val << 32);
+	data += (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT_L(port->id));
-	dev->stats.rx_len[i++] += val;
+	data += val;
+	dev->stats.rx_len[i] = max(data, dev->stats.rx_len[i]);
+	i++;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L64_CNT_H(port->id));
-	dev->stats.rx_len[i] += ((u64)val << 32);
+	data = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L64_CNT_L(port->id));
-	dev->stats.rx_len[i++] += val;
+	data += val;
+	dev->stats.rx_len[i] = max(data, dev->stats.rx_len[i]);
+	i++;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L127_CNT_H(port->id));
-	dev->stats.rx_len[i] += ((u64)val << 32);
+	data = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L127_CNT_L(port->id));
-	dev->stats.rx_len[i++] += val;
+	data += val;
+	dev->stats.rx_len[i] = max(data, dev->stats.rx_len[i]);
+	i++;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L255_CNT_H(port->id));
-	dev->stats.rx_len[i] += ((u64)val << 32);
+	data = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L255_CNT_L(port->id));
-	dev->stats.rx_len[i++] += val;
+	data += val;
+	dev->stats.rx_len[i] = max(data, dev->stats.rx_len[i]);
+	i++;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L511_CNT_H(port->id));
-	dev->stats.rx_len[i] += ((u64)val << 32);
+	data = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L511_CNT_L(port->id));
-	dev->stats.rx_len[i++] += val;
+	data += val;
+	dev->stats.rx_len[i] = max(data, dev->stats.rx_len[i]);
+	i++;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L1023_CNT_H(port->id));
-	dev->stats.rx_len[i] += ((u64)val << 32);
+	data = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L1023_CNT_L(port->id));
-	dev->stats.rx_len[i++] += val;
+	data += val;
+	dev->stats.rx_len[i] = max(data, dev->stats.rx_len[i]);
+	i++;
 
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

base-commit: 60444706aa17616efc03190d099ac347e28b3d0a
-- 
2.43.0


