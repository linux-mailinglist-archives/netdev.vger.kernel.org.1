Return-Path: <netdev+bounces-302948-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8/KcNQFEQ2oOWQoAu9opvQ
	(envelope-from <netdev+bounces-302948-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:20:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C74D6E03AC
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:20:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ruMhfC7v;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302948-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302948-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 160563079C99
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 04:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104C53E0241;
	Tue, 30 Jun 2026 04:16:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781903E3DA4
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 04:16:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793010; cv=none; b=YVTHX9n6W0wa5U4AzvmT4coDt9h/M0T4PncrwaXtltuM44TUR/6nTfA5NX6IeMQEDY1DoZXHoomh563ybIS2YLfqd5IiJTFvPw6No2qM0Qax0JXQX1jaZnvVuHnDGFgy+eQlxhRzWdwhbOJVp2w+d50SPYEaTby1TjxMx6BB7P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793010; c=relaxed/simple;
	bh=uoKUqYS0ssuGLvwNhzL6pi1M/QyiJCZR73nzfkhjd2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOcx3XugmFWxTEqoIUQYwf3FB4CvwVHSFFsWG9GXv1kSCBTez6l+EXQnJboVY5LJNh0+FgjMKZnYWFSndX0lIaZBoqFs5u5fjlTGNjwk2rTIDAzije6H68SZhyC9LNF5FlYNEt5MQnb7zJvTVXaQhcrpf1n23dMvuSvZ6ClIels=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ruMhfC7v; arc=none smtp.client-ip=209.85.215.169
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c8ff15af279so2244353a12.3
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 21:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782793008; x=1783397808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAxctKlAdWvMs4hdFqXMo41z8gALZkF1RO/WFZvwep8=;
        b=ruMhfC7vAbb7GxmpXAaazJhDp8tIurmZk8QmhwwR/MfaIpw1+9lHJIQYWYyROuiK5l
         vRdPGKPFz1m9zgj5M08mzcH1W5PwecbcrN3J0QKPrDeD+jlh/PNJ6PUNCtovzCdmGD+Q
         e0Y8/ARjBQvSxy+H+0l+NdedluDfHXVtGQzULll1N1/t4l4EAvZToz15WTpjkpsAr/pu
         CR5fisNWl4UHo8pUSUdfJjYRhiS04brnz35YIkWzeIVeN5RZZ2YP4MpH9Nda0mr8YIyu
         sCNJuWaWo6270trA01nszYrJcGqan40gkPB/UNzbKrK6KVqU0OS5EXOznJxv9ga2yu9J
         /3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782793008; x=1783397808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aAxctKlAdWvMs4hdFqXMo41z8gALZkF1RO/WFZvwep8=;
        b=CblOcEDx9hyA/x8kdupMyeKrojwIMpQQ9JRKv/4qavykV18W/OesnNPsbMzRjq2bNX
         545gDuUpOYZk4ESere7GK48JajDhvGS57hIHsLNjqr+7qNo45JPeK4RixexHSXdNrsVx
         T7JdQiEcgyfVQA19/moQ2DC6aMcgIjZRND7BKnoHZq/Q58zTZj17JCarTlkP09zQvyOh
         A0AZ3IZIKccdtdf3sxd/6o/vgqlgFuuzQEJqS4ImoDYOy6oJMuN65YKIfzIQcCGf/j06
         mp/IgMyGjzD4s0iDX6LQHMAIRwDiJj62hszRf4ILPwAHvfE1o3BUC/qlshSiLM7wdN7R
         XtZQ==
X-Gm-Message-State: AOJu0Ywa4tWcpkapkAwpPr8q4/jEgRU8nIVZMxOOHABofN7hllbkXufQ
	edVztQjWENn5uevWc3idVwNrdt9C3YIWOMU1Y4Lkg/TCDPo87XD7MO+qd8VaCoi6
X-Gm-Gg: AfdE7cnJdIfefKqvcdajSB0C1ed62FkmpsZxK62kBehvsCKpeFYVN9FeIpGg1/YYQQZ
	k6ak5S7k7Iwk6k3YwKp/ihavXiFkx3VQeoFpoY8bPYLB9WSuZQKFMLjtORjv00dCD47n7pHroNW
	mLqrBUKYWS4ImWdJDfqW3W6AkirKkU3MNUNgjCJW+uOZ3CdFEtLuCmZuGlABNGgXF2TYkyir2aB
	OnNHNU1SQK8JCXgSFfE3k+RFY5lgFQbESV1/bj6lA9gPNM2lefpkX4R89XG0ZgS938DB9xUkeek
	zf+4RuyCU7p+slMKykbsaRnfDUiNCNwMpmzYLC4B7AdD60qDkCfXcD34yAQIR4jdRMz0F3welWx
	JL0xFSdvbQvvNbF/cuPJFlCgyUO7qHMcDxe4kIpaD0RfhQkrQfH/I9We/CRGz8ez6zIj0cdz3/6
	foYGDNKvLe+TplNQEPsFKqzkJZDPZWnkFpPhi6qhkyeHBU8j6UfCnBqD2WY2wC9g0x7F8HwQ1eS
	yOVXvB1rg==
X-Received: by 2002:a05:6a21:618e:b0:3ba:dd07:9a07 with SMTP id adf61e73a8af0-3bfc52693a6mr1797960637.34.1782793007514;
        Mon, 29 Jun 2026 21:16:47 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9bbf95a3e7sm702659a12.19.2026.06.29.21.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 21:16:46 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 08/10] net: emac: replace #ifdef CONFIG_PPC_DCR_NATIVE with IS_ENABLED()
Date: Mon, 29 Jun 2026 21:16:32 -0700
Message-ID: <20260630041634.284127-9-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630041634.284127-1-rosenp@gmail.com>
References: <20260630041634.284127-1-rosenp@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302948-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C74D6E03AC

Convert compile-time #ifdef blocks to IS_ENABLED() conditionals
for better compile coverage and more idiomatic kernel code.
Affected functions: emac_rx_clk_tx, emac_rx_clk_default,
emac_reset, emac_init_phy in core.c, and mal_txeob/mal_rxeob
in mal.c.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 41 ++++++++++++----------------
 drivers/net/ethernet/ibm/emac/mal.c  | 14 ++++------
 2 files changed, 23 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index aed1ad21e2ea..dba3cdfea340 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -139,20 +139,18 @@ static inline void emac_report_timeout_error(struct emac_instance *dev,
  */
 static inline void emac_rx_clk_tx(struct emac_instance *dev)
 {
-#ifdef CONFIG_PPC_DCR_NATIVE
-	if (emac_has_feature(dev, EMAC_FTR_440EP_PHY_CLK_FIX))
+	if (IS_ENABLED(CONFIG_PPC_DCR_NATIVE) &&
+	    emac_has_feature(dev, EMAC_FTR_440EP_PHY_CLK_FIX))
 		dcri_clrset(SDR0, SDR0_MFR,
 			    0, SDR0_MFR_ECS >> dev->cell_index);
-#endif
 }
 
 static inline void emac_rx_clk_default(struct emac_instance *dev)
 {
-#ifdef CONFIG_PPC_DCR_NATIVE
-	if (emac_has_feature(dev, EMAC_FTR_440EP_PHY_CLK_FIX))
+	if (IS_ENABLED(CONFIG_PPC_DCR_NATIVE) &&
+	    emac_has_feature(dev, EMAC_FTR_440EP_PHY_CLK_FIX))
 		dcri_clrset(SDR0, SDR0_MFR,
 			    SDR0_MFR_ECS >> dev->cell_index, 0);
-#endif
 }
 
 /* PHY polling intervals */
@@ -339,7 +337,7 @@ static int emac_reset(struct emac_instance *dev)
 {
 	struct emac_regs __iomem *p = dev->emacp;
 	int n = 20;
-	bool __maybe_unused try_internal_clock = false;
+	bool try_internal_clock = false;
 
 	DBG(dev, "reset" NL);
 
@@ -351,8 +349,6 @@ static int emac_reset(struct emac_instance *dev)
 		emac_tx_disable(dev);
 	}
 
-#ifdef CONFIG_PPC_DCR_NATIVE
-do_retry:
 	/*
 	 * PPC460EX/GT Embedded Processor Advanced User's Manual
 	 * section 28.10.1 Mode Register 0 (EMACx_MR0) states:
@@ -370,7 +366,9 @@ static int emac_reset(struct emac_instance *dev)
 	 * driver will temporarily switch to the internal clock, after
 	 * the first reset fails.
 	 */
-	if (emac_has_feature(dev, EMAC_FTR_460EX_PHY_CLK_FIX)) {
+retry:
+	if (IS_ENABLED(CONFIG_PPC_DCR_NATIVE) &&
+	    emac_has_feature(dev, EMAC_FTR_460EX_PHY_CLK_FIX)) {
 		if (try_internal_clock || (dev->phy_address == 0xffffffff &&
 					   dev->phy_map == 0xffffffff)) {
 			/* No PHY: select internal loop clock before reset */
@@ -382,19 +380,18 @@ static int emac_reset(struct emac_instance *dev)
 				    SDR0_ETH_CFG_ECS << dev->cell_index, 0);
 		}
 	}
-#endif
 
 	out_be32(&p->mr0, EMAC_MR0_SRST);
 	while ((in_be32(&p->mr0) & EMAC_MR0_SRST) && n)
 		--n;
 
-#ifdef CONFIG_PPC_DCR_NATIVE
-	if (emac_has_feature(dev, EMAC_FTR_460EX_PHY_CLK_FIX)) {
+	if (IS_ENABLED(CONFIG_PPC_DCR_NATIVE) &&
+	    emac_has_feature(dev, EMAC_FTR_460EX_PHY_CLK_FIX)) {
 		if (!n && !try_internal_clock) {
 			/* first attempt has timed out. */
 			n = 20;
 			try_internal_clock = true;
-			goto do_retry;
+			goto retry;
 		}
 
 		if (try_internal_clock || (dev->phy_address == 0xffffffff &&
@@ -404,7 +401,6 @@ static int emac_reset(struct emac_instance *dev)
 				    SDR0_ETH_CFG_ECS << dev->cell_index, 0);
 		}
 	}
-#endif
 
 	if (n) {
 		dev->reset_failed = 0;
@@ -2754,18 +2750,16 @@ static int emac_init_phy(struct emac_instance *dev)
 	dev->phy.mdio_write = emac_mdio_write;
 
 	/* Enable internal clock source */
-#ifdef CONFIG_PPC_DCR_NATIVE
-	if (emac_has_feature(dev, EMAC_FTR_440GX_PHY_CLK_FIX))
+	if (IS_ENABLED(CONFIG_PPC_DCR_NATIVE) &&
+	    emac_has_feature(dev, EMAC_FTR_440GX_PHY_CLK_FIX))
 		dcri_clrset(SDR0, SDR0_MFR, 0, SDR0_MFR_ECS);
-#endif
 	/* PHY clock workaround */
 	emac_rx_clk_tx(dev);
 
 	/* Enable internal clock source on 440GX*/
-#ifdef CONFIG_PPC_DCR_NATIVE
-	if (emac_has_feature(dev, EMAC_FTR_440GX_PHY_CLK_FIX))
+	if (IS_ENABLED(CONFIG_PPC_DCR_NATIVE) &&
+	    emac_has_feature(dev, EMAC_FTR_440GX_PHY_CLK_FIX))
 		dcri_clrset(SDR0, SDR0_MFR, 0, SDR0_MFR_ECS);
-#endif
 	/* Configure EMAC with defaults so we can at least use MDIO
 	 * This is needed mostly for 440GX
 	 */
@@ -2825,10 +2819,9 @@ static int emac_init_phy(struct emac_instance *dev)
 		}
 
 	/* Enable external clock source */
-#ifdef CONFIG_PPC_DCR_NATIVE
-	if (emac_has_feature(dev, EMAC_FTR_440GX_PHY_CLK_FIX))
+	if (IS_ENABLED(CONFIG_PPC_DCR_NATIVE) &&
+	    emac_has_feature(dev, EMAC_FTR_440GX_PHY_CLK_FIX))
 		dcri_clrset(SDR0, SDR0_MFR, SDR0_MFR_ECS, 0);
-#endif
 	mutex_unlock(&emac_phy_map_lock);
 	if (i == 0x20) {
 		printk(KERN_WARNING "%pOF: can't find PHY!\n", np);
diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index d12a376f69fd..2adfd9d9bdb1 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -282,11 +282,10 @@ static irqreturn_t mal_txeob(int irq, void *dev_instance)
 	mal_schedule_poll(mal);
 	set_mal_dcrn(mal, MAL_TXEOBISR, r);
 
-#ifdef CONFIG_PPC_DCR_NATIVE
-	if (mal_has_feature(mal, MAL_FTR_CLEAR_ICINTSTAT))
+	if (IS_ENABLED(CONFIG_PPC_DCR_NATIVE) &&
+	    mal_has_feature(mal, MAL_FTR_CLEAR_ICINTSTAT))
 		mtdcri(SDR0, DCRN_SDR_ICINTSTAT,
-				(mfdcri(SDR0, DCRN_SDR_ICINTSTAT) | ICINTSTAT_ICTX));
-#endif
+			(mfdcri(SDR0, DCRN_SDR_ICINTSTAT) | ICINTSTAT_ICTX));
 
 	return IRQ_HANDLED;
 }
@@ -302,11 +301,10 @@ static irqreturn_t mal_rxeob(int irq, void *dev_instance)
 	mal_schedule_poll(mal);
 	set_mal_dcrn(mal, MAL_RXEOBISR, r);
 
-#ifdef CONFIG_PPC_DCR_NATIVE
-	if (mal_has_feature(mal, MAL_FTR_CLEAR_ICINTSTAT))
+	if (IS_ENABLED(CONFIG_PPC_DCR_NATIVE) &&
+	    mal_has_feature(mal, MAL_FTR_CLEAR_ICINTSTAT))
 		mtdcri(SDR0, DCRN_SDR_ICINTSTAT,
-				(mfdcri(SDR0, DCRN_SDR_ICINTSTAT) | ICINTSTAT_ICRX));
-#endif
+			(mfdcri(SDR0, DCRN_SDR_ICINTSTAT) | ICINTSTAT_ICRX));
 
 	return IRQ_HANDLED;
 }
-- 
2.54.0


