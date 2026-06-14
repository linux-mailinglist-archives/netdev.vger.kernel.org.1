Return-Path: <netdev+bounces-299136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jZJIGW8oLmroqAQAu9opvQ
	(envelope-from <netdev+bounces-299136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 06:05:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD93C680549
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 06:05:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Wu+NPUUI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299136-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299136-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C15F2305431B
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 04:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B98F2D12F3;
	Sun, 14 Jun 2026 04:01:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E73272816
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 04:01:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781409685; cv=none; b=DftP05PlNUUCxQN4YfqRGIuAUWaK+LZ6YgVWMdJ1az4X8exvlFS0LLsGWPebMT2llIPlaLOtj6TdIn7xwxQv/0t3tK33OE73tL5jM3RjnLMWnEpTCdzytZfKMES/57s+5EgrnbHaOfx1GNKLAw+3xf0XNyHofI5aUpK7cPwilIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781409685; c=relaxed/simple;
	bh=kB2qOi/yAHpfOsWCbelMdPq1dkousPiimwvD21oIm3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mz5jab2lJstW+6KNyunsPfS1K90TDLpEy3v2ZTQMPQdLC6ysKRgvkSJSqtggJCq/ANddMgQxDGuBr4KzPDo/1p4R1kOzUuZiJIvtb1KEaXvZvgH6Cno9m4ug+ygInq4oLek5sJFORRS29pi8Z2UqQ2oEutLBzLBcGEFxgQdf3x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wu+NPUUI; arc=none smtp.client-ip=209.85.215.174
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c85822059d8so1456240a12.1
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 21:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781409682; x=1782014482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dluNpCPRBDSOzKss3pUIDIAJmusvd9OAlTIMPgyePu4=;
        b=Wu+NPUUI2JCJMyauTmOnp7Eb1/swomOtrXcBFELzUt1P0zJ0c+o0IaZaFCWiH4i7Yv
         aDm81GLlCkntfDlGL/MPVnc9L1cBnOuOgMbRQFUp7zmz5jCyN1hoZ1sRbN+TPFL9C4Nc
         uEzd+JpPAj+qDg0/030AdRNtstUidDR7bDfc08jbpaZWsxZ2Kb50VesVUI6S0n8rU4t3
         3UhcQCIDBCr/NN9Ddn6ByCqT0fZvdd+AWOZn1CRV/mYsigc6nkx+SEDQNyQA+bwUXu6M
         dJdmy4flqILIrbmcyMVVZV2umi9rpwAG+X3M7vHufroqKcvuv/fsv6Nciy0O+8Jt+A1s
         xgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781409682; x=1782014482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dluNpCPRBDSOzKss3pUIDIAJmusvd9OAlTIMPgyePu4=;
        b=TSyJBMv7UTipTgm9BZjOfW/IgYOxlwxOMjKSOB1VLQT5+k+Cy4Tu161oNyn3MFl+8e
         0mzcpxIFWSp5/gt1EqDyKDmc4uNei1emXAGtx4By6oCoJT/eCMkujTBlZMO2S6oyoiu/
         SAMFzfQXvGlNhzARnKK9aiNnb2f4ZorJM3o3/sNbjbDRxgR7BehyAlwgQuA6+p27e4Cs
         6Nh7UUKF0AOti9PQbXEXUjXfGFx+Yu23HIowz9AL/wqHNQqS2vymF90N/KUpOMDJARl6
         4MAs0FAiinwtDkm+3hVOMSU3hw10BATHH0PifF0WJSZlkKQu2ucqN7WtZx3E3at4YFZq
         hO3w==
X-Gm-Message-State: AOJu0YzNxjRZePYu8y9cqj2MEJCNtuAVP1MGZM8HsCMzzTw+Z8zW+MEK
	gpp5ki83KYOhi+pAll/9Kcxadr0JEeHzVUKo5E8Yt1c71LeVNJTaktZ2yED4vNu2
X-Gm-Gg: Acq92OHWsyKLseIjdJpz/5b7FRyk45XFG4zTSBYgQGMb+1HDthY6eG+uk45d1tRnk5m
	zEDWoUuEq2cTw/7asQ86oan59H+o5VLvGvXpfHL1bng2SUabhSxlu60lQj3VMeEY4EMEFq6HgWC
	bfcsPeSYQNf6/2wtcQPnLxah4yYmFXtjsoXP+wyLNyg1hocMEPXRVWdtO/Gs2mZ7NnLoo5QbY4t
	7ogIVacGzgIYze5P8viQvEXxdN9iKQyyeVQJE0fClqE+/6Z2DvAQMEudtJcmZ/OdMVHS3YuH2RX
	h6PYs85L6TLzz9KIjVs4BbC4L5qSwqf0oDCvC1HZhMf8hlj2CLtugPhsgtB/+lpvF29OxU9uscB
	qyesohWdxLlS6WWzp2mDM4EOePLRk8Qk6bDkyhQEtRnMQTfMB9OBYqx6XMtbVFlV74sTsdHM17L
	RBHABD2Md6qN7NpTgX3YQ=
X-Received: by 2002:a05:6a21:a518:b0:3b3:be05:2b73 with SMTP id adf61e73a8af0-3b783c19128mr11049750637.18.1781409682284;
        Sat, 13 Jun 2026 21:01:22 -0700 (PDT)
Received: from mincom1 ([115.4.79.42])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8661a67603sm5676983a12.0.2026.06.13.21.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 21:01:21 -0700 (PDT)
From: Jihong Min <hurryman2212@gmail.com>
To: netdev@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Christian Marangi <ansuelsmth@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	linux-kernel@vger.kernel.org,
	Jihong Min <hurryman2212@gmail.com>
Subject: [RFC PATCH net-next 5/7] net: airoha: add QDMA support for SOE packets
Date: Sun, 14 Jun 2026 13:00:30 +0900
Message-ID: <20260614040032.1567994-6-hurryman2212@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260614040032.1567994-1-hurryman2212@gmail.com>
References: <20260614040032.1567994-1-hurryman2212@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299136-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[hurryman2212@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gondor.apana.org.au,secunet.com,vger.kernel.org,gmail.com,collabora.com,lists.infradead.org,nbd.name];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:herbert@gondor.apana.org.au,m:steffen.klassert@secunet.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:ansuelsmth@gmail.com,m:nbd@nbd.name,m:linux-kernel@vger.kernel.org,m:hurryman2212@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hurryman2212@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD93C680549

Add QDMA RX/TX plumbing for SOE packets, including the SOE RX ring,
coherent RX slots, SOE completion decoding, and the private QDMA submit
helper used by the SOE provider. Wire the Ethernet netdev feature and
lifetime hooks through the SOE stubs.

Signed-off-by: Jihong Min <hurryman2212@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 668 ++++++++++++++++++++---
 1 file changed, 591 insertions(+), 77 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 5f1a118875fb..42fd30c12ed7 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -6,6 +6,7 @@
 #include <linux/of.h>
 #include <linux/of_net.h>
 #include <linux/of_reserved_mem.h>
+#include <linux/moduleparam.h>
 #include <linux/platform_device.h>
 #include <linux/tcp.h>
 #include <linux/u64_stats_sync.h>
@@ -16,6 +17,67 @@
 
 #include "airoha_regs.h"
 #include "airoha_eth.h"
+#include "airoha_soe.h"
+
+/* QDMA1 uses a different RX IRQ bank layout than QDMA0 on EN7581. */
+#define AIROHA_QDMA_WAN_RX_IRQ0_BANK_PIN_MASK 0x0000839f
+#define AIROHA_QDMA_WAN_RX_IRQ1_BANK_PIN_MASK 0x7f800400
+#define AIROHA_QDMA_WAN_RX_IRQ2_BANK_PIN_MASK 0x00000000
+#define AIROHA_QDMA_WAN_RX_IRQ3_BANK_PIN_MASK 0x00000040
+
+static unsigned int airoha_qdma0_rx_irq_bank_mask[AIROHA_MAX_NUM_IRQ_BANKS] = {
+	RX_IRQ0_BANK_PIN_MASK,
+	RX_IRQ1_BANK_PIN_MASK,
+	RX_IRQ2_BANK_PIN_MASK,
+	RX_IRQ3_BANK_PIN_MASK,
+};
+
+static unsigned int airoha_qdma1_rx_irq_bank_mask[AIROHA_MAX_NUM_IRQ_BANKS] = {
+	AIROHA_QDMA_WAN_RX_IRQ0_BANK_PIN_MASK,
+	AIROHA_QDMA_WAN_RX_IRQ1_BANK_PIN_MASK,
+	AIROHA_QDMA_WAN_RX_IRQ2_BANK_PIN_MASK,
+	AIROHA_QDMA_WAN_RX_IRQ3_BANK_PIN_MASK,
+};
+
+#if IS_REACHABLE(CONFIG_NET_AIROHA_SOE)
+#define AIROHA_SOE_RX_RING 10
+#define AIROHA_SOE_RX_ALLOC_NDESC 2048
+#define AIROHA_SOE_RX_NDESC_DEFAULT 512
+#define AIROHA_SOE_RX_BUF_SIZE 4096
+#define AIROHA_SOE_RX_BUF_SIZE_MIN 128
+#define AIROHA_SOE_RX_BUF_SIZE_MAX 16384
+#define AIROHA_SOE_DECRYPT_FOE_REASON_MASK \
+	(BIT(PPE_CPU_REASON_UN_HIT) | BIT(PPE_CPU_REASON_HIT_UNBIND) | \
+	 BIT(PPE_CPU_REASON_HIT_UNBIND_RATE_REACHED))
+
+static int airoha_soe_rx_poll_desc_budget = AIROHA_SOE_RX_NDESC_DEFAULT;
+static int airoha_soe_rx_max_frame_descs = 128;
+static int airoha_soe_probe_rx_ndesc = AIROHA_SOE_RX_NDESC_DEFAULT;
+static int airoha_soe_probe_rx_buf_size = AIROHA_SOE_RX_BUF_SIZE;
+static bool airoha_soe_probe_rx_coherent = true;
+static int airoha_soe_probe_rx_scatter = 1;
+
+module_param_named(soe_rx_poll_desc_budget, airoha_soe_rx_poll_desc_budget, int,
+		   0600);
+MODULE_PARM_DESC(soe_rx_poll_desc_budget,
+		 "Maximum SOE RX descriptors consumed per poll");
+module_param_named(soe_rx_max_frame_descs, airoha_soe_rx_max_frame_descs, int,
+		   0600);
+MODULE_PARM_DESC(soe_rx_max_frame_descs,
+		 "Maximum descriptors per SOE RX frame before dropping the chain");
+module_param_named(soe_probe_rx_ndesc, airoha_soe_probe_rx_ndesc, int, 0600);
+MODULE_PARM_DESC(soe_probe_rx_ndesc, "SOE RX descriptor count");
+module_param_named(soe_probe_rx_buf_size, airoha_soe_probe_rx_buf_size, int,
+		   0600);
+MODULE_PARM_DESC(soe_probe_rx_buf_size, "SOE RX buffer size");
+module_param_named(soe_probe_rx_coherent, airoha_soe_probe_rx_coherent, bool,
+		   0600);
+MODULE_PARM_DESC(soe_probe_rx_coherent, "Use coherent SOE RX buffers");
+module_param_named(soe_probe_rx_scatter, airoha_soe_probe_rx_scatter, int,
+		   0600);
+MODULE_PARM_DESC(soe_probe_rx_scatter,
+		 "SOE RX scatter mode: 0 disabled, 1 enabled");
+#endif
 
 u32 airoha_rr(void __iomem *base, u32 offset)
 {
@@ -71,6 +133,100 @@ static void airoha_qdma_irq_disable(struct airoha_irq_bank *irq_bank,
 	airoha_qdma_set_irqmask(irq_bank, index, mask, 0);
 }
 
+static unsigned int *airoha_qdma_rx_irq_bank_masks(struct airoha_qdma *qdma)
+{
+	struct airoha_eth *eth = qdma->eth;
+	int id = qdma - &eth->qdma[0];
+
+	return id ? airoha_qdma1_rx_irq_bank_mask :
+		    airoha_qdma0_rx_irq_bank_mask;
+}
+
+static u32 airoha_qdma_rx_irq_bank_mask(struct airoha_qdma *qdma, int bank)
+{
+	unsigned int *masks = airoha_qdma_rx_irq_bank_masks(qdma);
+
+	if (bank < 0 || bank >= AIROHA_MAX_NUM_IRQ_BANKS)
+		return 0;
+
+	return READ_ONCE(masks[bank]);
+}
+
+#if IS_REACHABLE(CONFIG_NET_AIROHA_SOE)
+static u32 airoha_qdma_rx_irq_all_bank_mask(struct airoha_qdma *qdma)
+{
+	u32 mask = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(qdma->irq_banks); i++)
+		mask |= airoha_qdma_rx_irq_bank_mask(qdma, i);
+
+	return mask;
+}
+#endif
+
+static void airoha_qdma_apply_rx_irq_bank_masks(struct airoha_qdma *qdma)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(qdma->irq_banks); i++) {
+		struct airoha_irq_bank *irq_bank = &qdma->irq_banks[i];
+		u32 mask = airoha_qdma_rx_irq_bank_mask(qdma, i);
+
+		airoha_qdma_set_irqmask(irq_bank, QDMA_INT_REG_IDX0,
+					RX_COHERENT_LOW_INT_MASK,
+					INT_RX0_MASK(mask));
+		airoha_qdma_set_irqmask(irq_bank, QDMA_INT_REG_IDX1,
+					RX_NO_CPU_DSCP_LOW_INT_MASK |
+						RX_DONE_LOW_INT_MASK,
+					INT_RX1_MASK(mask));
+		airoha_qdma_set_irqmask(irq_bank, QDMA_INT_REG_IDX2,
+					RX_NO_CPU_DSCP_HIGH_INT_MASK |
+						RX_DONE_HIGH_INT_MASK,
+					INT_RX2_MASK(mask));
+		airoha_qdma_set_irqmask(irq_bank, QDMA_INT_REG_IDX3,
+					RX_COHERENT_HIGH_INT_MASK,
+					INT_RX3_MASK(mask));
+	}
+}
+
+static void airoha_qdma_set_rx_done_irq(struct airoha_qdma *qdma, int qid,
+					bool enable)
+{
+	int i, intr_reg;
+	u32 mask;
+
+	intr_reg = qid < RX_DONE_HIGH_OFFSET ? QDMA_INT_REG_IDX1 :
+					       QDMA_INT_REG_IDX2;
+	mask = BIT(qid % RX_DONE_HIGH_OFFSET);
+
+	for (i = 0; i < ARRAY_SIZE(qdma->irq_banks); i++) {
+		if (!(BIT(qid) & airoha_qdma_rx_irq_bank_mask(qdma, i)))
+			continue;
+
+		if (enable)
+			airoha_qdma_irq_enable(&qdma->irq_banks[i], intr_reg,
+					       mask);
+		else
+			airoha_qdma_irq_disable(&qdma->irq_banks[i], intr_reg,
+						mask);
+	}
+
+#if IS_REACHABLE(CONFIG_NET_AIROHA_SOE)
+	if (qid != AIROHA_SOE_RX_RING)
+		return;
+
+	if (BIT(qid) & airoha_qdma_rx_irq_all_bank_mask(qdma))
+		return;
+
+	/* SOE RX10 may not be covered by the shared bank mask; use bank 0. */
+	if (enable)
+		airoha_qdma_irq_enable(&qdma->irq_banks[0], intr_reg, mask);
+	else
+		airoha_qdma_irq_disable(&qdma->irq_banks[0], intr_reg, mask);
+#endif
+}
+
 static int airoha_set_macaddr(struct airoha_gdm_dev *dev, const u8 *addr)
 {
 	u8 ref_addr[ETH_ALEN] __aligned(2);
@@ -532,6 +688,11 @@ static int airoha_fe_init(struct airoha_eth *eth)
 	airoha_fe_wr(eth, REG_FE_CDM1_OQ_MAP2, BIT(4));
 	airoha_fe_wr(eth, REG_FE_CDM1_OQ_MAP3, BIT(28));
 
+	/* SOE/TDMA output depends on PSE shared-buffer flow control instead
+	 * of leaving port-local sharing disabled.
+	 */
+	airoha_fe_clear(eth, REG_PSE_FC_CFG, PSE_TDMA_SHARE_BUF_DIS_MASK);
+
 	airoha_fe_vip_setup(eth);
 	airoha_fe_pse_ports_init(eth);
 
@@ -597,20 +758,29 @@ static int airoha_qdma_fill_rx_queue(struct airoha_queue *q)
 		int offset;
 		u32 val;
 
-		page = page_pool_dev_alloc_frag(q->page_pool, &offset,
-						q->buf_size);
-		if (!page)
-			break;
+		if (q->rx_coherent) {
+			/* Coherent slots avoid page_pool recycling for SOE frames. */
+			offset = q->head * q->buf_size;
+			e->buf = q->rx_coherent_buf + offset;
+			e->dma_addr = q->rx_coherent_dma + offset;
+			e->dma_len = q->buf_size;
+		} else {
+			page = page_pool_dev_alloc_frag(q->page_pool, &offset,
+							q->buf_size);
+			if (!page)
+				break;
+
+			offset += AIROHA_RX_HEADROOM;
+			e->buf = page_address(page) + offset;
+			e->dma_addr = page_pool_get_dma_addr(page) + offset;
+			e->dma_len =
+				SKB_WITH_OVERHEAD(AIROHA_RX_LEN(q->buf_size));
+		}
 
 		q->head = (q->head + 1) % q->ndesc;
 		q->queued++;
 		nframes++;
 
-		offset += AIROHA_RX_HEADROOM;
-		e->buf = page_address(page) + offset;
-		e->dma_addr = page_pool_get_dma_addr(page) + offset;
-		e->dma_len = SKB_WITH_OVERHEAD(AIROHA_RX_LEN(q->buf_size));
-
 		val = FIELD_PREP(QDMA_DESC_LEN_MASK, e->dma_len);
 		WRITE_ONCE(desc->ctrl, cpu_to_le32(val));
 		WRITE_ONCE(desc->addr, cpu_to_le32(e->dma_addr));
@@ -652,92 +822,210 @@ airoha_qdma_get_gdm_dev(struct airoha_eth *eth, struct airoha_qdma_desc *desc)
 	return port->devs[d] ? port->devs[d] : ERR_PTR(-ENODEV);
 }
 
+#if IS_REACHABLE(CONFIG_NET_AIROHA_SOE)
+static bool airoha_qdma_rx_is_soe(u32 msg0)
+{
+	u32 hop_flags = FIELD_GET(QDMA_ETH_RXMSG_HOP_FLAGS_MASK, msg0);
+
+	return hop_flags >= 3 && hop_flags <= 7;
+}
+#endif
+
 static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 {
-	enum dma_data_direction dir = page_pool_get_dma_dir(q->page_pool);
+	enum dma_data_direction dir;
 	struct airoha_qdma *qdma = q->qdma;
 	struct airoha_eth *eth = qdma->eth;
 	int qid = q - &qdma->q_rx[0];
+	int desc_budget = q->ndesc;
+	int desc_done = 0;
 	int done = 0;
 
-	while (done < budget) {
+	dir = q->rx_coherent ? DMA_FROM_DEVICE :
+			       page_pool_get_dma_dir(q->page_pool);
+
+#if IS_REACHABLE(CONFIG_NET_AIROHA_SOE)
+	if (airoha_soe_rx_poll_desc_budget > 0)
+		desc_budget = min(airoha_soe_rx_poll_desc_budget, q->ndesc);
+#endif
+
+	while (q->queued > 0 && done < budget && desc_done < desc_budget) {
 		struct airoha_queue_entry *e = &q->entry[q->tail];
 		struct airoha_qdma_desc *desc = &q->desc[q->tail];
-		u32 hash, reason, msg1, desc_ctrl;
-		struct airoha_gdm_dev *dev;
+		u32 hash, reason, msg0, msg1, msg2, desc_ctrl;
+#if IS_REACHABLE(CONFIG_NET_AIROHA_SOE)
+		/* Scattered SOE completions only tag the first descriptor. */
+		bool partial_soe = q->skb && !q->skb->dev;
+#endif
+		struct airoha_gdm_dev *dev = NULL;
+		struct net_device *rx_dev = NULL;
 		struct net_device *netdev;
+		bool soe_pkt = false;
 		int data_len, len;
-		struct page *page;
+		struct page *page = NULL;
 
 		desc_ctrl = le32_to_cpu(READ_ONCE(desc->ctrl));
 		if (!(desc_ctrl & QDMA_DESC_DONE_MASK))
 			break;
 
 		dma_rmb();
+		desc_done++;
 
 		q->tail = (q->tail + 1) % q->ndesc;
 		q->queued--;
 
-		dma_sync_single_for_cpu(eth->dev, e->dma_addr, e->dma_len,
-					dir);
+		if (!q->rx_coherent)
+			dma_sync_single_for_cpu(eth->dev, e->dma_addr,
+						e->dma_len, dir);
+
+		if (!q->rx_coherent)
+			page = virt_to_head_page(e->buf);
+
+		if (q->rx_drop_chain) {
+			if (!FIELD_GET(QDMA_DESC_MORE_MASK, desc_ctrl)) {
+				q->rx_drop_chain = false;
+				q->rx_frame_descs = 0;
+				done++;
+			}
+			if (!q->rx_coherent)
+				page_pool_put_full_page(q->page_pool, page,
+							true);
+			continue;
+		}
 
-		page = virt_to_head_page(e->buf);
 		len = FIELD_GET(QDMA_DESC_LEN_MASK, desc_ctrl);
-		data_len = q->skb ? AIROHA_RX_LEN(q->buf_size) : e->dma_len;
+		data_len = q->skb && !q->rx_coherent ?
+				   AIROHA_RX_LEN(q->buf_size) :
+				   e->dma_len;
 		if (!len || data_len < len)
 			goto free_frag;
 
-		dev = airoha_qdma_get_gdm_dev(eth, desc);
-		if (IS_ERR(dev))
-			goto free_frag;
+		msg0 = le32_to_cpu(READ_ONCE(desc->msg0));
+		msg1 = le32_to_cpu(READ_ONCE(desc->msg1));
+		msg2 = le32_to_cpu(READ_ONCE(desc->msg2));
+#if IS_REACHABLE(CONFIG_NET_AIROHA_SOE)
+		soe_pkt = partial_soe || airoha_qdma_rx_is_soe(msg0);
+#endif
+		if (!soe_pkt) {
+			dev = airoha_qdma_get_gdm_dev(eth, desc);
+			if (IS_ERR(dev))
+				goto free_frag;
+			netdev = netdev_from_priv(dev);
+			rx_dev = netdev;
+		}
 
-		netdev = netdev_from_priv(dev);
 		if (!q->skb) { /* first buffer */
-			q->skb = napi_build_skb(e->buf - AIROHA_RX_HEADROOM,
-						q->buf_size);
+			if (q->rx_coherent) {
+				q->skb = napi_alloc_skb(&q->napi, len);
+				if (q->skb)
+					skb_put_data(q->skb, e->buf, len);
+			} else {
+				void *buf = e->buf - AIROHA_RX_HEADROOM;
+
+				q->skb = napi_build_skb(buf, q->buf_size);
+			}
 			if (!q->skb)
 				goto free_frag;
 
-			skb_reserve(q->skb, AIROHA_RX_HEADROOM);
-			__skb_put(q->skb, len);
-			skb_mark_for_recycle(q->skb);
-			q->skb->dev = netdev;
-			q->skb->protocol = eth_type_trans(q->skb, netdev);
-			q->skb->ip_summed = CHECKSUM_UNNECESSARY;
+			q->rx_drop_chain = false;
+			q->rx_frame_descs = 1;
+			if (!q->rx_coherent) {
+				skb_reserve(q->skb, AIROHA_RX_HEADROOM);
+				__skb_put(q->skb, len);
+				skb_mark_for_recycle(q->skb);
+			}
+			q->skb->dev = soe_pkt ? NULL : netdev;
+			q->skb->ip_summed = soe_pkt ? CHECKSUM_NONE :
+						      CHECKSUM_UNNECESSARY;
 			skb_record_rx_queue(q->skb, qid);
+			if (soe_pkt) {
+				q->soe_rx_msg0 = msg0;
+				q->soe_rx_msg2 = msg2;
+			}
+			if (!soe_pkt)
+				q->skb->protocol = eth_type_trans(q->skb,
+								  netdev);
 		} else { /* scattered frame */
-			struct skb_shared_info *shinfo = skb_shinfo(q->skb);
-			int nr_frags = shinfo->nr_frags;
-
-			if (nr_frags >= ARRAY_SIZE(shinfo->frags))
+#if IS_REACHABLE(CONFIG_NET_AIROHA_SOE)
+			if (soe_pkt && airoha_soe_rx_max_frame_descs > 0 &&
+			    q->rx_frame_descs >=
+				    airoha_soe_rx_max_frame_descs) {
+				q->rx_drop_chain =
+					FIELD_GET(QDMA_DESC_MORE_MASK, desc_ctrl);
 				goto free_frag;
-
-			skb_add_rx_frag(q->skb, nr_frags, page,
-					e->buf - page_address(page), len,
-					q->buf_size);
+			}
+#endif
+			q->rx_frame_descs++;
+			if (q->rx_coherent) {
+				if (skb_tailroom(q->skb) < len) {
+					unsigned int needed;
+
+					needed = len - skb_tailroom(q->skb);
+					if (pskb_expand_head(q->skb, 0, needed,
+							     GFP_ATOMIC))
+						goto free_frag;
+				}
+				skb_put_data(q->skb, e->buf, len);
+			} else {
+				struct skb_shared_info *shinfo =
+					skb_shinfo(q->skb);
+				int nr_frags = shinfo->nr_frags;
+
+				if (nr_frags >= ARRAY_SIZE(shinfo->frags))
+					goto free_frag;
+
+				skb_add_rx_frag(q->skb, nr_frags, page,
+						e->buf - page_address(page),
+						len, q->buf_size);
+			}
 		}
 
 		if (FIELD_GET(QDMA_DESC_MORE_MASK, desc_ctrl))
 			continue;
 
+		q->rx_drop_chain = false;
+		q->rx_frame_descs = 0;
+#if IS_REACHABLE(CONFIG_NET_AIROHA_SOE)
+		if (soe_pkt) {
+			u32 hop_flags = FIELD_GET(QDMA_ETH_RXMSG_HOP_FLAGS_MASK,
+						  q->soe_rx_msg0);
+			u32 sa_index = FIELD_GET(QDMA_ETH_RXMSG_SW_UDF_MASK,
+						 q->soe_rx_msg2);
+
+			done++;
+			if (!airoha_soe_rx_skb(eth->soe, q->skb, sa_index,
+					       hop_flags))
+				dev_kfree_skb(q->skb);
+			q->skb = NULL;
+			continue;
+		}
+#endif
+
 		if (netdev_uses_dsa(netdev)) {
 			struct airoha_gdm_port *port = dev->port;
+			struct dsa_port *cpu_dp = netdev->dsa_ptr;
+			u32 sptag = FIELD_GET(QDMA_ETH_RXMSG_SPTAG, msg0);
 
 			/* PPE module requires untagged packets to work
 			 * properly and it provides DSA port index via the
 			 * DMA descriptor. Report DSA tag to the DSA stack
 			 * via skb dst info.
 			 */
-			u32 msg0 = le32_to_cpu(READ_ONCE(desc->msg0));
-			u32 sptag = FIELD_GET(QDMA_ETH_RXMSG_SPTAG, msg0);
-
 			if (sptag < ARRAY_SIZE(port->dsa_meta) &&
 			    port->dsa_meta[sptag])
 				skb_dst_set_noref(q->skb,
 						  &port->dsa_meta[sptag]->dst);
+
+			if (cpu_dp && cpu_dp->ds) {
+				struct dsa_port *dp =
+					dsa_to_port(cpu_dp->ds, sptag);
+
+				if (dp && dsa_port_is_user(dp) &&
+				    dp->cpu_dp == cpu_dp && dp->user)
+					rx_dev = dp->user;
+			}
 		}
 
-		msg1 = le32_to_cpu(READ_ONCE(desc->msg1));
 		hash = FIELD_GET(AIROHA_RXD4_FOE_ENTRY, msg1);
 		if (hash != AIROHA_RXD4_FOE_ENTRY)
 			skb_set_hash(q->skb, jhash_1word(hash, 0),
@@ -749,18 +1037,54 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 					     false);
 
 		done++;
+#if IS_REACHABLE(CONFIG_NET_AIROHA_SOE)
+		/* Native ESP/NAT-T packets enter through the normal RX path
+		 * first. If they match an inbound packet-offload SA, consume
+		 * the encrypted skb here and resubmit it to SOE before GRO
+		 * takes ownership of the packet. SOE decrypts the original
+		 * ESP/NAT-T packet; after GRO or the normal RX stack processes
+		 * the skb, it is no longer a suitable hardware decrypt
+		 * candidate. Keep the RX FOE hash/reason so the decrypt
+		 * completion can later bind the PPE flow after egress is known.
+		 */
+		if (hash != AIROHA_RXD4_FOE_ENTRY) {
+			bool foe_valid = false;
+
+			if (reason < 32)
+				foe_valid = AIROHA_SOE_DECRYPT_FOE_REASON_MASK &
+					    BIT(reason);
+			if (airoha_soe_rx_plain_skb(dev, q->skb, rx_dev, hash,
+						    reason, foe_valid)) {
+				q->skb = NULL;
+				continue;
+			}
+		} else if (airoha_soe_rx_plain_skb(dev, q->skb, rx_dev, hash,
+						   reason, false)) {
+			q->skb = NULL;
+			continue;
+		}
+#endif
 		napi_gro_receive(&q->napi, q->skb);
 		q->skb = NULL;
 		continue;
 free_frag:
+		q->rx_drop_chain = !!FIELD_GET(QDMA_DESC_MORE_MASK, desc_ctrl);
+		q->rx_frame_descs = 0;
+		done++;
 		if (q->skb) {
 			dev_kfree_skb(q->skb);
 			q->skb = NULL;
 		}
-		page_pool_put_full_page(q->page_pool, page, true);
+		if (!q->rx_coherent)
+			page_pool_put_full_page(q->page_pool, page, true);
 	}
 	airoha_qdma_fill_rx_queue(q);
 
+#if IS_REACHABLE(CONFIG_NET_AIROHA_SOE)
+	if (desc_done && !done)
+		return 1;
+#endif
+
 	return done;
 }
 
@@ -776,17 +1100,9 @@ static int airoha_qdma_rx_napi_poll(struct napi_struct *napi, int budget)
 
 	if (done < budget && napi_complete(napi)) {
 		struct airoha_qdma *qdma = q->qdma;
-		int i, qid = q - &qdma->q_rx[0];
-		int intr_reg = qid < RX_DONE_HIGH_OFFSET ? QDMA_INT_REG_IDX1
-							 : QDMA_INT_REG_IDX2;
-
-		for (i = 0; i < ARRAY_SIZE(qdma->irq_banks); i++) {
-			if (!(BIT(qid) & RX_IRQ_BANK_PIN_MASK(i)))
-				continue;
+		int qid = q - &qdma->q_rx[0];
 
-			airoha_qdma_irq_enable(&qdma->irq_banks[i], intr_reg,
-					       BIT(qid % RX_DONE_HIGH_OFFSET));
-		}
+		airoha_qdma_set_rx_done_irq(qdma, qid, true);
 	}
 
 	return done;
@@ -795,7 +1111,7 @@ static int airoha_qdma_rx_napi_poll(struct napi_struct *napi, int budget)
 static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 				     struct airoha_qdma *qdma, int ndesc)
 {
-	const struct page_pool_params pp_params = {
+	struct page_pool_params pp_params = {
 		.order = 0,
 		.pool_size = 256,
 		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
@@ -809,8 +1125,21 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 	int qid = q - &qdma->q_rx[0], thr;
 	dma_addr_t dma_addr;
 
+#if IS_REACHABLE(CONFIG_NET_AIROHA_SOE)
+	if (qid == AIROHA_SOE_RX_RING) {
+		ndesc = max(ndesc, AIROHA_SOE_RX_ALLOC_NDESC);
+		if (airoha_soe_probe_rx_ndesc > 0)
+			ndesc = clamp(airoha_soe_probe_rx_ndesc, 1,
+				      AIROHA_SOE_RX_ALLOC_NDESC);
+	}
+#endif
+
 	q->buf_size = PAGE_SIZE / 2;
 	q->qdma = qdma;
+#if IS_REACHABLE(CONFIG_NET_AIROHA_SOE)
+	if (qid == AIROHA_SOE_RX_RING)
+		q->rx_coherent = airoha_soe_probe_rx_coherent;
+#endif
 
 	q->entry = devm_kzalloc(eth->dev, ndesc * sizeof(*q->entry),
 				GFP_KERNEL);
@@ -821,19 +1150,45 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 				      &dma_addr, GFP_KERNEL);
 	if (!q->desc)
 		return -ENOMEM;
+	q->desc_dma = dma_addr;
 
-	q->page_pool = page_pool_create(&pp_params);
-	if (IS_ERR(q->page_pool)) {
-		int err = PTR_ERR(q->page_pool);
+	if (!q->rx_coherent) {
+		q->page_pool = page_pool_create(&pp_params);
+		if (IS_ERR(q->page_pool)) {
+			int err = PTR_ERR(q->page_pool);
 
-		q->page_pool = NULL;
-		return err;
+			q->page_pool = NULL;
+			return err;
+		}
+	}
+
+#if IS_REACHABLE(CONFIG_NET_AIROHA_SOE)
+	if (qid == AIROHA_SOE_RX_RING) {
+		size_t buf_size;
+		int max_buf_size;
+
+		q->rx_alloc_ndesc = ndesc;
+		max_buf_size = q->rx_coherent ? AIROHA_SOE_RX_BUF_SIZE_MAX :
+						AIROHA_SOE_RX_BUF_SIZE;
+		q->buf_size = clamp(airoha_soe_probe_rx_buf_size,
+				    AIROHA_SOE_RX_BUF_SIZE_MIN, max_buf_size);
+		if (q->rx_coherent) {
+			buf_size = q->buf_size * ndesc;
+			q->rx_coherent_buf =
+				dmam_alloc_coherent(eth->dev, buf_size,
+						    &q->rx_coherent_dma,
+						    GFP_KERNEL);
+			if (!q->rx_coherent_buf)
+				return -ENOMEM;
+			q->rx_coherent_buf_size = buf_size;
+		}
 	}
+#endif
 
 	q->ndesc = ndesc;
 	netif_napi_add(eth->napi_dev, &q->napi, airoha_qdma_rx_napi_poll);
 
-	airoha_qdma_wr(qdma, REG_RX_RING_BASE(qid), dma_addr);
+	airoha_qdma_wr(qdma, REG_RX_RING_BASE(qid), q->desc_dma);
 	airoha_qdma_rmw(qdma, REG_RX_RING_SIZE(qid),
 			RX_RING_SIZE_MASK,
 			FIELD_PREP(RX_RING_SIZE_MASK, ndesc));
@@ -843,7 +1198,14 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 			FIELD_PREP(RX_RING_THR_MASK, thr));
 	airoha_qdma_rmw(qdma, REG_RX_DMA_IDX(qid), RX_RING_DMA_IDX_MASK,
 			FIELD_PREP(RX_RING_DMA_IDX_MASK, q->head));
-	airoha_qdma_set(qdma, REG_RX_SCATTER_CFG(qid), RX_RING_SG_EN_MASK);
+#if IS_REACHABLE(CONFIG_NET_AIROHA_SOE)
+	if (qid == AIROHA_SOE_RX_RING && !airoha_soe_probe_rx_scatter)
+		airoha_qdma_clear(qdma, REG_RX_SCATTER_CFG(qid),
+				  RX_RING_SG_EN_MASK);
+	else
+#endif
+		airoha_qdma_set(qdma, REG_RX_SCATTER_CFG(qid),
+				RX_RING_SG_EN_MASK);
 
 	airoha_qdma_fill_rx_queue(q);
 
@@ -859,11 +1221,14 @@ static void airoha_qdma_cleanup_rx_queue(struct airoha_queue *q)
 	while (q->queued) {
 		struct airoha_queue_entry *e = &q->entry[q->tail];
 		struct airoha_qdma_desc *desc = &q->desc[q->tail];
-		struct page *page = virt_to_head_page(e->buf);
 
-		dma_sync_single_for_cpu(eth->dev, e->dma_addr, e->dma_len,
-					page_pool_get_dma_dir(q->page_pool));
-		page_pool_put_full_page(q->page_pool, page, false);
+		if (!q->rx_coherent) {
+			struct page *page = virt_to_head_page(e->buf);
+
+			dma_sync_single_for_cpu(eth->dev, e->dma_addr, e->dma_len,
+						page_pool_get_dma_dir(q->page_pool));
+			page_pool_put_full_page(q->page_pool, page, false);
+		}
 		/* Reset DMA descriptor */
 		WRITE_ONCE(desc->ctrl, 0);
 		WRITE_ONCE(desc->addr, 0);
@@ -1045,8 +1410,24 @@ static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 			airoha_qdma_rmw(qdma, REG_IRQ_CLEAR_LEN(id),
 					IRQ_CLEAR_LEN_MASK, 0x80);
 		airoha_qdma_rmw(qdma, REG_IRQ_CLEAR_LEN(id),
-				IRQ_CLEAR_LEN_MASK, (done & 0x7f));
+				IRQ_CLEAR_LEN_MASK,
+				(done & 0x7f));
+	}
+
+#if IS_REACHABLE(CONFIG_NET_AIROHA_SOE)
+	if (done && airoha_soe_has_pending_rx(eth->soe)) {
+		int i;
+
+		/* SOE decrypt completions can lag behind TX cleanup IRQs. */
+		for (i = 0; i < ARRAY_SIZE(eth->qdma); i++) {
+			struct airoha_queue *rxq =
+				&eth->qdma[i].q_rx[AIROHA_SOE_RX_RING];
+
+			if (rxq->ndesc)
+				napi_schedule(&rxq->napi);
+		}
 	}
+#endif
 
 	if (done < budget && napi_complete(napi))
 		airoha_qdma_irq_enable(&qdma->irq_banks[0], QDMA_INT_REG_IDX0,
@@ -1346,16 +1727,11 @@ static int airoha_qdma_hw_init(struct airoha_qdma *qdma)
 	for (i = 0; i < ARRAY_SIZE(qdma->irq_banks); i++) {
 		/* clear pending irqs */
 		airoha_qdma_wr(qdma, REG_INT_STATUS(i), 0xffffffff);
-		/* setup rx irqs */
-		airoha_qdma_irq_enable(&qdma->irq_banks[i], QDMA_INT_REG_IDX0,
-				       INT_RX0_MASK(RX_IRQ_BANK_PIN_MASK(i)));
-		airoha_qdma_irq_enable(&qdma->irq_banks[i], QDMA_INT_REG_IDX1,
-				       INT_RX1_MASK(RX_IRQ_BANK_PIN_MASK(i)));
-		airoha_qdma_irq_enable(&qdma->irq_banks[i], QDMA_INT_REG_IDX2,
-				       INT_RX2_MASK(RX_IRQ_BANK_PIN_MASK(i)));
-		airoha_qdma_irq_enable(&qdma->irq_banks[i], QDMA_INT_REG_IDX3,
-				       INT_RX3_MASK(RX_IRQ_BANK_PIN_MASK(i)));
 	}
+	airoha_qdma_apply_rx_irq_bank_masks(qdma);
+#if IS_REACHABLE(CONFIG_NET_AIROHA_SOE)
+	airoha_qdma_set_rx_done_irq(qdma, AIROHA_SOE_RX_RING, true);
+#endif
 	/* setup tx irqs */
 	airoha_qdma_irq_enable(&qdma->irq_banks[0], QDMA_INT_REG_IDX0,
 			       TX_COHERENT_LOW_INT_MASK | INT_TX_MASK);
@@ -2176,6 +2552,110 @@ int airoha_get_fe_port(struct airoha_gdm_dev *dev)
 	}
 }
 
+#if IS_REACHABLE(CONFIG_NET_AIROHA_SOE)
+int airoha_qdma_xmit_skb(struct airoha_gdm_dev *dev, struct sk_buff *skb,
+			 u32 msg0, u32 msg1, u32 msg2)
+{
+	struct net_device *netdev = netdev_from_priv(dev);
+	struct airoha_qdma *qdma = dev->qdma;
+	u32 nr_frags, len;
+	struct airoha_queue_entry *e;
+	struct netdev_queue *txq;
+	struct airoha_queue *q;
+	LIST_HEAD(tx_list);
+	int i = 0, qid;
+	void *data;
+	u16 index;
+
+	qid = airoha_qdma_get_txq(qdma, skb_get_queue_mapping(skb));
+	q = &qdma->q_tx[qid];
+	if (WARN_ON_ONCE(!q->ndesc))
+		return -ENODEV;
+
+	spin_lock_bh(&q->lock);
+
+	txq = skb_get_tx_queue(netdev, skb);
+	nr_frags = 1 + skb_shinfo(skb)->nr_frags;
+	if (q->queued + nr_frags >= q->ndesc) {
+		netif_tx_stop_queue(txq);
+		q->txq_stopped = true;
+		spin_unlock_bh(&q->lock);
+		return -EBUSY;
+	}
+
+	len = skb_headlen(skb);
+	data = skb->data;
+
+	e = list_first_entry(&q->tx_list, struct airoha_queue_entry, list);
+	index = e - q->entry;
+
+	while (true) {
+		struct airoha_qdma_desc *desc = &q->desc[index];
+		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+		dma_addr_t addr;
+		u32 val;
+
+		addr = dma_map_single(netdev->dev.parent, data, len,
+				      DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(netdev->dev.parent, addr)))
+			goto error_unmap;
+
+		list_move_tail(&e->list, &tx_list);
+		e->skb = i == nr_frags - 1 ? skb : NULL;
+		e->dma_addr = addr;
+		e->dma_len = len;
+
+		e = list_first_entry(&q->tx_list, struct airoha_queue_entry,
+				     list);
+		index = e - q->entry;
+
+		val = FIELD_PREP(QDMA_DESC_LEN_MASK, len);
+		if (i < nr_frags - 1)
+			val |= FIELD_PREP(QDMA_DESC_MORE_MASK, 1);
+		WRITE_ONCE(desc->ctrl, cpu_to_le32(val));
+		WRITE_ONCE(desc->addr, cpu_to_le32(addr));
+		val = FIELD_PREP(QDMA_DESC_NEXT_ID_MASK, index);
+		WRITE_ONCE(desc->data, cpu_to_le32(val));
+		WRITE_ONCE(desc->msg0, cpu_to_le32(msg0));
+		WRITE_ONCE(desc->msg1, cpu_to_le32(msg1));
+		WRITE_ONCE(desc->msg2, cpu_to_le32(msg2));
+
+		if (++i == nr_frags)
+			break;
+
+		data = skb_frag_address(frag);
+		len = skb_frag_size(frag);
+	}
+	q->queued += i;
+
+	skb_tx_timestamp(skb);
+	netdev_tx_sent_queue(txq, skb->len);
+	if (q->ndesc - q->queued < q->free_thr) {
+		netif_tx_stop_queue(txq);
+		q->txq_stopped = true;
+	}
+
+	/* SOE submits do not run in the regular ndo_start_xmit batching path. */
+	airoha_qdma_rmw(qdma, REG_TX_CPU_IDX(qid), TX_RING_CPU_IDX_MASK,
+			FIELD_PREP(TX_RING_CPU_IDX_MASK, index));
+
+	spin_unlock_bh(&q->lock);
+
+	return 0;
+
+error_unmap:
+	list_for_each_entry(e, &tx_list, list) {
+		dma_unmap_single(netdev->dev.parent, e->dma_addr, e->dma_len,
+				 DMA_TO_DEVICE);
+		e->dma_addr = 0;
+	}
+	list_splice(&tx_list, &q->tx_list);
+	spin_unlock_bh(&q->lock);
+
+	return -ENOMEM;
+}
+#endif
+
 static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 				   struct net_device *netdev)
 {
@@ -2185,6 +2665,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	struct airoha_queue_entry *e;
 	struct netdev_queue *txq;
 	struct airoha_queue *q;
+	bool soe_decrypt_skb = false;
 	LIST_HEAD(tx_list);
 	int i = 0, qid;
 	void *data;
@@ -2223,6 +2704,11 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	       FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
 	       FIELD_PREP(QDMA_ETH_TXMSG_METER_MASK, 0x7f);
 
+#if IS_REACHABLE(CONFIG_NET_AIROHA_SOE)
+	if (dev->eth->ppe)
+		soe_decrypt_skb = airoha_ppe_soe_skb_marked(skb);
+#endif
+
 	q = &qdma->q_tx[qid];
 	if (WARN_ON_ONCE(!q->ndesc))
 		goto error;
@@ -2293,13 +2779,24 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 		q->txq_stopped = true;
 	}
 
-	if (netif_xmit_stopped(txq) || !netdev_xmit_more())
+	if (netif_xmit_stopped(txq) || !netdev_xmit_more() ||
+	    soe_decrypt_skb)
 		airoha_qdma_rmw(qdma, REG_TX_CPU_IDX(qid),
 				TX_RING_CPU_IDX_MASK,
 				FIELD_PREP(TX_RING_CPU_IDX_MASK, index));
 
 	spin_unlock_bh(&q->lock);
 
+	/* SOE decrypt flow binding needs the final egress netdev and QDMA
+	 * descriptor context. The SOE RX path marks only candidate packets; bind
+	 * only after the current plaintext packet has been queued and kicked so
+	 * the newly bound decrypt entry cannot race the CPU-transmitted packet.
+	 */
+#if IS_REACHABLE(CONFIG_NET_AIROHA_SOE)
+	if (soe_decrypt_skb)
+		airoha_ppe_soe_xmit_skb(&dev->eth->ppe->dev, skb, netdev);
+#endif
+
 	return NETDEV_TX_OK;
 
 error_unmap:
@@ -3096,6 +3593,12 @@ static int airoha_dev_tc_setup(struct net_device *dev,
 	}
 }
 
+static int airoha_dev_set_features(struct net_device *netdev,
+				   netdev_features_t features)
+{
+	return airoha_soe_set_features(netdev, features);
+}
+
 static const struct net_device_ops airoha_netdev_ops = {
 	.ndo_init		= airoha_dev_init,
 	.ndo_open		= airoha_dev_open,
@@ -3105,6 +3608,7 @@ static const struct net_device_ops airoha_netdev_ops = {
 	.ndo_start_xmit		= airoha_dev_xmit,
 	.ndo_get_stats64        = airoha_dev_get_stats64,
 	.ndo_set_mac_address	= airoha_dev_set_macaddr,
+	.ndo_set_features	= airoha_dev_set_features,
 	.ndo_setup_tc		= airoha_dev_tc_setup,
 };
 
@@ -3230,6 +3734,7 @@ static int airoha_alloc_gdm_device(struct airoha_eth *eth,
 	dev->eth = eth;
 	dev->nbq = nbq;
 	port->devs[index] = dev;
+	airoha_soe_build_netdev(netdev, airoha_qdma_xmit_skb);
 
 	return 0;
 }
@@ -3409,10 +3914,14 @@ static int airoha_probe(struct platform_device *pdev)
 	strscpy(eth->napi_dev->name, "qdma_eth", sizeof(eth->napi_dev->name));
 	platform_set_drvdata(pdev, eth);
 
-	err = airoha_hw_init(pdev, eth);
+	err = airoha_soe_init(eth);
 	if (err)
 		goto error_netdev_free;
 
+	err = airoha_hw_init(pdev, eth);
+	if (err)
+		goto error_soe_deinit;
+
 	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
 		airoha_qdma_start_napi(&eth->qdma[i]);
 
@@ -3457,11 +3966,14 @@ static int airoha_probe(struct platform_device *pdev)
 			netdev = netdev_from_priv(dev);
 			if (netdev->reg_state == NETREG_REGISTERED)
 				unregister_netdev(netdev);
+			airoha_soe_teardown_netdev(netdev);
 			of_node_put(netdev->dev.of_node);
 		}
 		airoha_metadata_dst_free(port);
 	}
 	airoha_hw_cleanup(eth);
+error_soe_deinit:
+	airoha_soe_deinit(eth);
 error_netdev_free:
 	free_netdev(eth->napi_dev);
 	platform_set_drvdata(pdev, NULL);
@@ -3492,12 +4004,14 @@ static void airoha_remove(struct platform_device *pdev)
 				continue;
 
 			netdev = netdev_from_priv(dev);
+			airoha_soe_teardown_netdev(netdev);
 			unregister_netdev(netdev);
 			of_node_put(netdev->dev.of_node);
 		}
 		airoha_metadata_dst_free(port);
 	}
 	airoha_hw_cleanup(eth);
+	airoha_soe_deinit(eth);
 
 	free_netdev(eth->napi_dev);
 	platform_set_drvdata(pdev, NULL);
-- 
2.53.0

