Return-Path: <netdev+bounces-303113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uZb2NSqoQ2qNeQoAu9opvQ
	(envelope-from <netdev+bounces-303113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:27:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DC36E394F
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 13:27:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=EmreuaiF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303113-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303113-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F26F30559EF
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE2E3FBED2;
	Tue, 30 Jun 2026 11:18:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C0A3CC7CC
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 11:18:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818326; cv=none; b=KbY+V5gok1hLc41DPz7H+zpNXsfjOKHYJ/jbJJ//YIr2sGhbCF4T8WTsZVXwMqxzf5o31Ueknhrk+kNbPrfsMz1ujP8JjWo9LKFosuQMrf1VYHj3fdP1JiE5PaYV6m7oLXfBxxjUlRzKwRXm4NrVHnjgn2B7Ohaa0S4KLIuDBYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818326; c=relaxed/simple;
	bh=5FKkWeAh4C1QVYpgOc3MOZuJfofmBtFdEAbeZp+wyfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mr00feybWBGYUXfVOuuyLZ7gf/O7o5ZHYD7Rlndft54whKh/cEinREn6YqtzYuY8uB8WuwIdCt+Rr7xdgMK4MAPowkJOvxwLWGCYUhxWYicH8aHq3LeT+Gc2jqEEPy/fQdSpEIOLjWoiACbsVBjiOKfvMLJUltomtTpWDAnLUWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmreuaiF; arc=none smtp.client-ip=209.85.214.181
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ca06ad2d11so16926085ad.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 04:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782818324; x=1783423124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XRfkcUv7g40gglGVGhitqa+g0EVUFFRMfsu9citOfjs=;
        b=EmreuaiFGIHXSoQwSyemeXYMZhX8fDddzywD6AvyzPfOl05KBUzbK92X/gi6GryhqZ
         kWW/ppi/FmHqIHqdKA0TLm/ix6dRQz6cp34j7kRiP+pLTHy0DNbIBvLiTaEoG+UsuUYz
         4R9SQsfx31UM3aJ6bFmdwRH1bNj4kOMK2bddxahI5FFGVcaZyGMr+DzK0/MUZ0xMUOsX
         wiLuhAr29ypw6G6QWG+tnnjBy2ugfAqM6b+m0lyqBTZcWx0nn62yIUIAUFKtPS+DxO4T
         RoNuphAv6TSq+2nWhRl8/VvTNAdMHqO0RssQdctx54MeQsLwV0VFzsS2ihBJm2CY06CX
         wHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782818324; x=1783423124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRfkcUv7g40gglGVGhitqa+g0EVUFFRMfsu9citOfjs=;
        b=M12I4RLUfUXMU00C7Fsm+O9ndtXUkVE7Jw+l0LXTvbuhnytJRPfWJGOgIu1WBOOgoF
         5H/f2yuTxIOt+XKKhxE+SoVuWmdlK6SzGsy/r5CmF5R4Lwc/Z+u0VfBAnJuwmGwjTss6
         Jv1kUszvGG2iUkT5ZmcKLdTbxq3EIEoTRdqcJdMcwn2uavECXI3M9e7CssjqwVsG4HT9
         MQVEcOplmOw4fk8wOvBnqz+GNmXXTxw9fLrdDAbnZOe+BeJQ5PpqGfyIkzODVxVp7QOo
         ObOwhchvd/1QBqf5cuohdNnpncFgKG6bVoeCTQLtyzvZE0Cz7OV5o6WrxU6WVOVEl7ei
         qqlw==
X-Forwarded-Encrypted: i=1; AHgh+RqgeIuLZWb5OegvJbkCXOy4IjyMIZo0SLtl3bAfBbc8XFnJUHmWdV2Gw4wcQIDmF9yYjCvA/rY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzfXXD0UhznXILw78oRx/6cfLeM1gKNXy1L8GCvF8rREuqX4t3
	pw4RbCPGT7urawdtBtnAo9/kHwCVGpRf6oJOWgJh8mhHQEvNwDewfqxQ
X-Gm-Gg: AfdE7ck/oxXyXEnIeoZCC65kYarcPoUKtrIc5h/F+9dR7dhXQcE4nAMLnYvR25YZpZv
	JLg/hyrpQubA3L6YDO55Ih5DggYqES+xlemuLAZHz8YpDd2AO3PuknfIGbx6f5kL1p5MH8kcklS
	EdT4FifS6bfeenXjQQfn5K7pdy8r0xXnxQJgT1ABauiCGZra+0onMIT2e6FCanNUnYQ73PKxCdv
	QpkfsVEJTWW8Os2uvQN7VXetw0ylG4W3P5GFSBS1GMgjmCiVaLpWeDswer3c2+kiUN1wWSrKbgE
	tE1cZSu3xGmtg3nTJTzV1deDMjminwKpgWAcn9o/1+08BVOtLt2yoKIaPBAIH3sJcLodwWHKEyA
	WIxzRZGjfeNXve68iBCSTP/hVK6/NGhqbU5nvM+iJ4+iL6zEDYNBXDyAHeGqYreZI7CP/YiO2wr
	7+lmZsdXO6xWEku3xE5UiHQ/Y=
X-Received: by 2002:a17:903:3883:b0:2ca:52ce:6f74 with SMTP id d9443c01a7336-2ca5a5eb6f3mr833565ad.29.1782818323616;
        Tue, 30 Jun 2026 04:18:43 -0700 (PDT)
Received: from nbai25050028.. ([2403:8600:2090:6f:c162:d20a:68d9:13ea])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca37c7456bsm11688285ad.25.2026.06.30.04.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:18:43 -0700 (PDT)
From: Aniket Negi <aniket.negi03@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aniket Negi <aniket.negi03@gmail.com>
Subject: [PATCH] net: airoha: fix MIB stats collection to be lossless
Date: Tue, 30 Jun 2026 16:48:34 +0530
Message-ID: <20260630111834.233643-1-aniket.negi03@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-303113-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ansuelsmth@gmail.com,m:horms@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:aniket.negi03@gmail.com,m:andrew@lunn.ch,m:aniketnegi03@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[aniketnegi03@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lists.infradead.org,vger.kernel.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 48DC36E394F

The airoha_dev_get_hw_stats() function had two correctness issues in the
way it collects hardware MIB counters.

Bug 1: Read-clear race causes silent packet loss in statistics

airoha_update_hw_stats() read all MIB registers and then cleared them
via REG_FE_GDM_MIB_CLEAR. There is a time window between the last
register read and the hardware clear. Any packet that the hardware
counts during this window is lost: the register is incremented, then
cleared, without the increment ever being read by software. Under
sustained traffic this causes a permanent and growing undercount in all
reported statistics.

This is particularly misleading for tx_ok_pkts and tx_ok_bytes, which
routers and traffic monitors use to detect packet forwarding loss
between two points in a hardware-accelerated path (e.g., between two
netdevs in the QDMA/PPE fast-path). An inaccurate count makes it
impossible to reliably attribute drops in the forwarding pipeline
without capturing traffic at both ends independently.

Bug 2: 32-bit counter overflow causes stat corruption

Several MIB registers are only 32 bits wide: tx_drops, tx_broadcast,
tx_multicast, rx_drops, rx_broadcast, rx_multicast, rx_errors,
rx_crc_error, rx_over_errors, rx_fragment, rx_jabber, and the runt and
long buckets of the tx_len[]/rx_len[].

The original code relied on MIB_CLEAR to keep register values small
enough that a simple '+= val' per cycle did not lose data across a
wrap. Once clearing is removed (to fix Bug 1), raw '+= val' silently
corrupts the accumulated software counter on overflow.

Fix both issues together:

- 64-bit H+L register pairs (tx_ok_pkts, tx_ok_bytes, tx_len[1..5],
  rx_ok_pkts, rx_ok_bytes, rx_len[1..5]): read directly from hardware
  without clearing. Hardware accumulates the full running total; a
  single direct assignment per poll is correct and lossless.

- 32-bit registers (tx_drops, tx_broadcast, tx_multicast, rx_drops,
  rx_broadcast, rx_multicast, rx_errors, rx_crc_error, rx_over_errors,
  rx_fragment, rx_jabber, and the runt/long buckets in tx_len[0]/[6]
  and rx_len[0]/[6]): track the previous hardware value in a new
  hw_prev_stats sub-struct inside airoha_hw_stats and accumulate
  (u32)(curr - prev) into the 64-bit software counter. Unsigned
  subtraction handles wrap-around transparently:
  prev=0xFFFFFF00, curr=0x00000010 -> delta=(u32)(0x10-0xFFFFFF00)=0x110

Remove the REG_FE_GDM_MIB_CLEAR write from airoha_update_hw_stats()
entirely. Because the driver no longer clears hardware counters, the
read-clear race window is eliminated.

The hw_prev_stats fields are zero-initialised by the existing
devm_kzalloc() call in airoha_alloc_gdm_device().

Fixes: 8f4695fb67b2 ("net: airoha: better handle MIBs for GDM ports with multiple devs attached")
Signed-off-by: Aniket Negi <aniket.negi03@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 132 +++++++++++------------
 drivers/net/ethernet/airoha/airoha_eth.h |  22 ++++
 2 files changed, 86 insertions(+), 68 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 1caf6766f2c0..7ae4e294478e 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1696,133 +1696,133 @@ static void airoha_dev_get_hw_stats(struct airoha_gdm_dev *dev)
 
 	u64_stats_update_begin(&dev->stats.syncp);
 
-	/* TX */
+	/* TX - 64-bit H+L registers: hw accumulates the total, read directly. */
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_H(port->id));
-	dev->stats.tx_ok_pkts += ((u64)val << 32);
-	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_L(port->id));
-	dev->stats.tx_ok_pkts += val;
+	dev->stats.tx_ok_pkts = (u64)val << 32;
+	dev->stats.tx_ok_pkts += airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_L(port->id));
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE_CNT_H(port->id));
-	dev->stats.tx_ok_bytes += ((u64)val << 32);
-	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE_CNT_L(port->id));
-	dev->stats.tx_ok_bytes += val;
+	dev->stats.tx_ok_bytes = (u64)val << 32;
+	dev->stats.tx_ok_bytes += airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE_CNT_L(port->id));
 
+	/* TX - 32-bit registers: accumulate delta to handle wrap-around. */
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_DROP_CNT(port->id));
-	dev->stats.tx_drops += val;
+	dev->stats.tx_drops += (u32)(val - dev->stats.hw_prev_stats.tx_drops);
+	dev->stats.hw_prev_stats.tx_drops = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_BC_CNT(port->id));
-	dev->stats.tx_broadcast += val;
+	dev->stats.tx_broadcast += (u32)(val - dev->stats.hw_prev_stats.tx_broadcast);
+	dev->stats.hw_prev_stats.tx_broadcast = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_MC_CNT(port->id));
-	dev->stats.tx_multicast += val;
+	dev->stats.tx_multicast += (u32)(val - dev->stats.hw_prev_stats.tx_multicast);
+	dev->stats.hw_prev_stats.tx_multicast = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_RUNT_CNT(port->id));
-	dev->stats.tx_len[i] += val;
+	dev->stats.tx_len[i] += (u32)(val - dev->stats.hw_prev_stats.tx_len[i]);
+	dev->stats.hw_prev_stats.tx_len[i] = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT_H(port->id));
-	dev->stats.tx_len[i] += ((u64)val << 32);
-	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT_L(port->id));
-	dev->stats.tx_len[i++] += val;
+	dev->stats.tx_len[i] += (u64)val << 32;
+	dev->stats.tx_len[i++] += airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT_L(port->id));
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L64_CNT_H(port->id));
-	dev->stats.tx_len[i] += ((u64)val << 32);
-	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L64_CNT_L(port->id));
-	dev->stats.tx_len[i++] += val;
+	dev->stats.tx_len[i] = (u64)val << 32;
+	dev->stats.tx_len[i++] += airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L64_CNT_L(port->id));
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L127_CNT_H(port->id));
-	dev->stats.tx_len[i] += ((u64)val << 32);
-	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L127_CNT_L(port->id));
-	dev->stats.tx_len[i++] += val;
+	dev->stats.tx_len[i] = (u64)val << 32;
+	dev->stats.tx_len[i++] += airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L127_CNT_L(port->id));
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L255_CNT_H(port->id));
-	dev->stats.tx_len[i] += ((u64)val << 32);
-	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L255_CNT_L(port->id));
-	dev->stats.tx_len[i++] += val;
+	dev->stats.tx_len[i] = (u64)val << 32;
+	dev->stats.tx_len[i++] += airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L255_CNT_L(port->id));
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L511_CNT_H(port->id));
-	dev->stats.tx_len[i] += ((u64)val << 32);
-	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L511_CNT_L(port->id));
-	dev->stats.tx_len[i++] += val;
+	dev->stats.tx_len[i] = (u64)val << 32;
+	dev->stats.tx_len[i++] += airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L511_CNT_L(port->id));
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L1023_CNT_H(port->id));
-	dev->stats.tx_len[i] += ((u64)val << 32);
-	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L1023_CNT_L(port->id));
-	dev->stats.tx_len[i++] += val;
+	dev->stats.tx_len[i] = (u64)val << 32;
+	dev->stats.tx_len[i++] += airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L1023_CNT_L(port->id));
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_LONG_CNT(port->id));
-	dev->stats.tx_len[i++] += val;
+	dev->stats.tx_len[i] += (u32)(val - dev->stats.hw_prev_stats.tx_len[i]);
+	dev->stats.hw_prev_stats.tx_len[i++] = val;
 
 	/* RX */
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_PKT_CNT_H(port->id));
-	dev->stats.rx_ok_pkts += ((u64)val << 32);
-	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_PKT_CNT_L(port->id));
-	dev->stats.rx_ok_pkts += val;
+	dev->stats.rx_ok_pkts = (u64)val << 32;
+	dev->stats.rx_ok_pkts += airoha_fe_rr(eth, REG_FE_GDM_RX_OK_PKT_CNT_L(port->id));
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_BYTE_CNT_H(port->id));
-	dev->stats.rx_ok_bytes += ((u64)val << 32);
-	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_BYTE_CNT_L(port->id));
-	dev->stats.rx_ok_bytes += val;
+	dev->stats.rx_ok_bytes = (u64)val << 32;
+	dev->stats.rx_ok_bytes += airoha_fe_rr(eth, REG_FE_GDM_RX_OK_BYTE_CNT_L(port->id));
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_DROP_CNT(port->id));
-	dev->stats.rx_drops += val;
+	dev->stats.rx_drops += (u32)(val - dev->stats.hw_prev_stats.rx_drops);
+	dev->stats.hw_prev_stats.rx_drops = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_BC_CNT(port->id));
-	dev->stats.rx_broadcast += val;
+	dev->stats.rx_broadcast += (u32)(val - dev->stats.hw_prev_stats.rx_broadcast);
+	dev->stats.hw_prev_stats.rx_broadcast = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_MC_CNT(port->id));
-	dev->stats.rx_multicast += val;
+	dev->stats.rx_multicast += (u32)(val - dev->stats.hw_prev_stats.rx_multicast);
+	dev->stats.hw_prev_stats.rx_multicast = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ERROR_DROP_CNT(port->id));
-	dev->stats.rx_errors += val;
+	dev->stats.rx_errors += (u32)(val - dev->stats.hw_prev_stats.rx_errors);
+	dev->stats.hw_prev_stats.rx_errors = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_CRC_ERR_CNT(port->id));
-	dev->stats.rx_crc_error += val;
+	dev->stats.rx_crc_error += (u32)(val - dev->stats.hw_prev_stats.rx_crc_error);
+	dev->stats.hw_prev_stats.rx_crc_error = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OVERFLOW_DROP_CNT(port->id));
-	dev->stats.rx_over_errors += val;
+	dev->stats.rx_over_errors += (u32)(val - dev->stats.hw_prev_stats.rx_over_errors);
+	dev->stats.hw_prev_stats.rx_over_errors = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_FRAG_CNT(port->id));
-	dev->stats.rx_fragment += val;
+	dev->stats.rx_fragment += (u32)(val - dev->stats.hw_prev_stats.rx_fragment);
+	dev->stats.hw_prev_stats.rx_fragment = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_JABBER_CNT(port->id));
-	dev->stats.rx_jabber += val;
+	dev->stats.rx_jabber += (u32)(val - dev->stats.hw_prev_stats.rx_jabber);
+	dev->stats.hw_prev_stats.rx_jabber = val;
 
 	i = 0;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_RUNT_CNT(port->id));
-	dev->stats.rx_len[i] += val;
+	dev->stats.rx_len[i] += (u32)(val - dev->stats.hw_prev_stats.rx_len[i]);
+	dev->stats.hw_prev_stats.rx_len[i] = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT_H(port->id));
-	dev->stats.rx_len[i] += ((u64)val << 32);
-	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT_L(port->id));
-	dev->stats.rx_len[i++] += val;
+	dev->stats.rx_len[i] += (u64)val << 32;
+	dev->stats.rx_len[i++] += airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT_L(port->id));
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L64_CNT_H(port->id));
-	dev->stats.rx_len[i] += ((u64)val << 32);
-	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L64_CNT_L(port->id));
-	dev->stats.rx_len[i++] += val;
+	dev->stats.rx_len[i] = (u64)val << 32;
+	dev->stats.rx_len[i++] += airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L64_CNT_L(port->id));
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L127_CNT_H(port->id));
-	dev->stats.rx_len[i] += ((u64)val << 32);
-	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L127_CNT_L(port->id));
-	dev->stats.rx_len[i++] += val;
+	dev->stats.rx_len[i] = (u64)val << 32;
+	dev->stats.rx_len[i++] += airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L127_CNT_L(port->id));
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L255_CNT_H(port->id));
-	dev->stats.rx_len[i] += ((u64)val << 32);
-	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L255_CNT_L(port->id));
-	dev->stats.rx_len[i++] += val;
+	dev->stats.rx_len[i] = (u64)val << 32;
+	dev->stats.rx_len[i++] += airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L255_CNT_L(port->id));
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L511_CNT_H(port->id));
-	dev->stats.rx_len[i] += ((u64)val << 32);
-	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L511_CNT_L(port->id));
-	dev->stats.rx_len[i++] += val;
+	dev->stats.rx_len[i] = (u64)val << 32;
+	dev->stats.rx_len[i++] += airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L511_CNT_L(port->id));
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L1023_CNT_H(port->id));
-	dev->stats.rx_len[i] += ((u64)val << 32);
-	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L1023_CNT_L(port->id));
-	dev->stats.rx_len[i++] += val;
+	dev->stats.rx_len[i] = (u64)val << 32;
+	dev->stats.rx_len[i++] += airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L1023_CNT_L(port->id));
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_LONG_CNT(port->id));
-	dev->stats.rx_len[i++] += val;
+	dev->stats.rx_len[i] += (u32)(val - dev->stats.hw_prev_stats.rx_len[i]);
+	dev->stats.hw_prev_stats.rx_len[i++] = val;
 
 	u64_stats_update_end(&dev->stats.syncp);
 }
@@ -1839,10 +1839,6 @@ static void airoha_update_hw_stats(struct airoha_gdm_dev *dev)
 			airoha_dev_get_hw_stats(port->devs[i]);
 	}
 
-	/* Reset MIB counters */
-	airoha_fe_set(dev->eth, REG_FE_GDM_MIB_CLEAR(port->id),
-		      FE_GDM_MIB_RX_CLEAR_MASK | FE_GDM_MIB_TX_CLEAR_MASK);
-
 	spin_unlock(&port->stats_lock);
 }
 
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 2765244d937c..af12ad6eac17 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -244,6 +244,28 @@ struct airoha_hw_stats {
 	u64 rx_fragment;
 	u64 rx_jabber;
 	u64 rx_len[7];
+
+	struct {
+	/* Previous HW register values for 32-bit counter delta tracking.
+	 * Storing the last seen value and accumulating (u32)(curr - prev)
+	 * in 64-bit software counter & handles wrap-around transparently
+	 * via unsigned arithmetic. These fields are never reported to
+	 * userspace.
+	 */
+		u32 tx_drops;
+		u32 tx_broadcast;
+		u32 tx_multicast;
+		u32 tx_len[7];
+		u32 rx_drops;
+		u32 rx_broadcast;
+		u32 rx_multicast;
+		u32 rx_errors;
+		u32 rx_crc_error;
+		u32 rx_over_errors;
+		u32 rx_fragment;
+		u32 rx_jabber;
+		u32 rx_len[7];
+	} hw_prev_stats;
 };
 
 enum {
-- 
2.43.0


