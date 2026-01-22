Return-Path: <netdev+bounces-252508-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wK77COx4cmlSlQAAu9opvQ
	(envelope-from <netdev+bounces-252508-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:22:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B51A56CF7C
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1F75F3007527
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5093915B6;
	Thu, 22 Jan 2026 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3yr/Aw/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAA4387593
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 19:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769109735; cv=none; b=b0dcv4L+kKUt6Vw+8w0TKVal/hmddjFGsfWSvOEhl+Yxieux1ZgxgiXnhWstBe5Qv4bWrpYg5EUov0hGNTijDRZwc6KN4r639eGXoWG8hl8bBj3ZNuwhTK9zw9KkEkZ5UvFb9lv4r4gdh3wKbZPzImcXi1N/sRqZDzyfNuTctWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769109735; c=relaxed/simple;
	bh=G2RI0gUjMDLgJTIsoLmK/VyzNACOF1rFnek+IDbA4fU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/AeOcq7qUeUngHMsXNUjIvx6ExgjbLn/+MoAbmIuVTpguAJdSvvR3GFZPAqt/f41OnpO7ZQ59MmdLFRGoTKC14OM/sK6Z7ehpA8eWRumE25huGjHAYUxfxmZbWbcU9EDaIykKU8uXbfXo1vkFu0wYWbzQwX2fsMZixazfhUqF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3yr/Aw/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4801c1ad878so13489495e9.1
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 11:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769109726; x=1769714526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eDM2ISal79m1/vQTXchzwHRq3inV+iq7tvAZQnTgd4=;
        b=I3yr/Aw/+PxEBA23aoG+VUoUp8Zfrlv4PfRlNPJ8z/umLOxMuw5wn1tiTtXlh2zSLY
         Gg6rV4bYHxEHv+tZcA/jXrT4Nfp72u6jR2MnzYrSKdi1BO4B/F1PsIBd4qDXe7lwBSjW
         KFNxJngjQr8iqq+EUO2yQMhmkIDmjf75hrkbuhB8am911wyk44Bmq3YHX6J7tIXQPMWa
         rRg7uYuRWzir0LYCd3i9HXW1b7UG1OytvauQffjLMyRhaquJWvAE9OY2qUQCc/mQGEa3
         P8D8gByurz2fnD4wSvxG01RLGicB4LM9jTjK3IRz0N7kywNbXaIOkSR1h1fCMb3tPN4u
         talA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769109726; x=1769714526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3eDM2ISal79m1/vQTXchzwHRq3inV+iq7tvAZQnTgd4=;
        b=JmOSIYeHGQmyu/WG78WRJjYllccK/67g1HCAKlH00GW8KVWkiJIcV4H7mCtwWn+YYx
         u2UWNKDZRlfTSyUjagibGT3goa212wdLfGEZMd+IeHwRW76Scq5ZmGqG2P3DvukojgYV
         6Mv9eAy495c8g0t31RHvO0AJCdy50CqT7et+c7scOzPhuC56KQOrH3PJou12caCOQQDk
         QD/EsIaH/S4JMi4XULLRv6B1k3E+XApWkrVVu93LF7qXNLHO9f8/8FBIrEBfKWKUlvH/
         u+/HpHISyqgbHk3UlmFhYP+V1KGOncVIC1mEbQ7Gd2NuwAwz0QxWD5SvF2c+PZS+ORy5
         3SaA==
X-Gm-Message-State: AOJu0YwLb1rsllLmuuPxDg/I/yArSgBrhdv4DrLKcSkzakQNrXrJrP2Q
	4WDwBf0rDNcMhNUJcCa3p+IP5q33LIbOMvSV0RLwq86hknkWLkAohcE2ZzwkZBoL
X-Gm-Gg: AZuq6aJcqYj405lJ6vOqVc9QtDKFSulvqw+3I2aDn3u7f4I2deS1ojKR6wDtZjXJm/8
	7q8FWkD6K8e04Ln4ghcwDSDOYJYLtK0CdzKqyPBgjlqhFBk2/kg3NK0tW/E4nKmcgqp4JhQ6/i/
	cmyltenjoR7JzSVpw74X8BPEIcz3+s8NLNLp6i5yV+1xtrf5yPRjc9yXfeG6IPjJz/i+PnHw16u
	hTIglKI13vB8Ld7WdkD+7nm1lCqHVq72c2Jkdn8pLzJ3xVj5/wGPIaRz0tQrmWuKETLOi1Spppj
	CemR/5eigwtVyUwRxWoOil9QH1dOj8ux0IEQ1oZ+YKScdTwzuJ4Rsi1p7DcofeKMNs3GbHtzhBl
	lkiO2t68Psm/VPLXz4Ll7jbymSx0LTmNsR2G9KTR7tsmMaD30HBrJbxHqdqfW9peKMG+kPQOn5F
	HwEyTDiPIQmE8Gah5bs2A=
X-Received: by 2002:a05:600c:34c8:b0:480:3b4e:41ba with SMTP id 5b1f17b1804b1-4804c9b2129mr11493405e9.18.1769109725882;
        Thu, 22 Jan 2026 11:22:05 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:40::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d85cff5sm3053485e9.7.2026.01.22.11.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 11:22:05 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	alok.a.tiwari@oracle.com,
	andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	chuck.lever@oracle.com,
	davem@davemloft.net,
	donald.hunter@gmail.com,
	edumazet@google.com,
	gal@nvidia.com,
	horms@kernel.org,
	idosch@nvidia.com,
	jacob.e.keller@intel.com,
	kernel-team@meta.com,
	kory.maincent@bootlin.com,
	kuba@kernel.org,
	lee@trager.us,
	mohsin.bashr@gmail.com,
	o.rempel@pengutronix.de,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev
Subject: [PATCH net-next 2/3] eth: fbnic: Add protection against pause storm
Date: Thu, 22 Jan 2026 11:21:57 -0800
Message-ID: <20260122192158.428882-3-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260122192158.428882-1-mohsin.bashr@gmail.com>
References: <20260122192158.428882-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252508-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,oracle.com,lunn.ch,davemloft.net,gmail.com,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,pengutronix.de,redhat.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B51A56CF7C
X-Rspamd-Action: no action

Enable protection against TX pause storm. When detected, the device
tolerates the storm for 500ms before it stops sending pause frames.
Use service task to bring the device back to the normal operation,
preparing it for any subsequent episode of pause storm.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h | 10 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c |  2 +
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c | 62 +++++++++++++++++++--
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h | 15 +++++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c |  4 ++
 5 files changed, 89 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index 422265dc7abd..39eb7b94a310 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -230,6 +230,7 @@ enum {
 #define FBNIC_INTR_MSIX_CTRL_VECTOR_MASK	CSR_GENMASK(7, 0)
 #define FBNIC_INTR_MSIX_CTRL_ENABLE		CSR_BIT(31)
 enum {
+	FBNIC_INTR_MSIX_CTRL_RXB_IDX	= 7,
 	FBNIC_INTR_MSIX_CTRL_PCS_IDX	= 34,
 };
 
@@ -560,6 +561,11 @@ enum {
 #define FBNIC_RXB_DROP_THLD_CNT			8
 #define FBNIC_RXB_DROP_THLD_ON			CSR_GENMASK(12, 0)
 #define FBNIC_RXB_DROP_THLD_OFF			CSR_GENMASK(25, 13)
+#define FBNIC_RXB_PAUSE_STORM(n)	(0x08019 + (n)) /* 0x20064 + 4*n */
+#define FBNIC_RXB_PAUSE_STORM_CNT		4
+#define FBNIC_RXB_PAUSE_STORM_FORCE_NORMAL	CSR_BIT(20)
+#define FBNIC_RXB_PAUSE_STORM_THLD_TIME		CSR_GENMASK(19, 0)
+#define FBNIC_RXB_PAUSE_STORM_UNIT_WR	0x0801d		/* 0x20074 */
 #define FBNIC_RXB_ECN_THLD(n)		(0x0801e + (n)) /* 0x20078 + 4*n */
 #define FBNIC_RXB_ECN_THLD_CNT			8
 #define FBNIC_RXB_ECN_THLD_ON			CSR_GENMASK(12, 0)
@@ -596,6 +602,9 @@ enum {
 #define FBNIC_RXB_INTF_CREDIT_MASK2		CSR_GENMASK(11, 8)
 #define FBNIC_RXB_INTF_CREDIT_MASK3		CSR_GENMASK(15, 12)
 
+#define FBNIC_RXB_ERR_INTR_STS		0x08050		/* 0x20140 */
+#define FBNIC_RXB_ERR_INTR_STS_PS		CSR_GENMASK(15, 12)
+#define FBNIC_RXB_ERR_INTR_MASK		0x08052		/* 0x20148 */
 #define FBNIC_RXB_PAUSE_EVENT_CNT(n)	(0x08053 + (n))	/* 0x2014c + 4*n */
 #define FBNIC_RXB_DROP_FRMS_STS(n)	(0x08057 + (n))	/* 0x2015c + 4*n */
 #define FBNIC_RXB_DROP_BYTES_STS_L(n) \
@@ -636,6 +645,7 @@ enum {
 
 #define FBNIC_RXB_PBUF_FIFO_LEVEL(n)	(0x0811d + (n)) /* 0x20474 + 4*n */
 
+#define FBNIC_RXB_PAUSE_STORM_UNIT_RD	0x08125		/* 0x20494 */
 #define FBNIC_RXB_INTEGRITY_ERR(n)	(0x0812f + (n))	/* 0x204bc + 4*n */
 #define FBNIC_RXB_MAC_ERR(n)		(0x08133 + (n))	/* 0x204cc + 4*n */
 #define FBNIC_RXB_PARSER_ERR(n)		(0x08137 + (n))	/* 0x204dc + 4*n */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
index 02e8b0b257fe..1e6a8fd6f702 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_irq.c
@@ -170,6 +170,8 @@ int fbnic_mac_request_irq(struct fbnic_dev *fbd)
 	fbnic_wr32(fbd, FBNIC_INTR_MSIX_CTRL(FBNIC_INTR_MSIX_CTRL_PCS_IDX),
 		   FBNIC_PCS_MSIX_ENTRY | FBNIC_INTR_MSIX_CTRL_ENABLE);
 
+	fbnic_wr32(fbd, FBNIC_INTR_MSIX_CTRL(FBNIC_INTR_MSIX_CTRL_RXB_IDX), 0);
+
 	fbd->mac_msix_vector = vector;
 
 	return 0;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index 9d0e4b2cc9ac..9cdf21192f98 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -143,6 +143,7 @@ static void fbnic_mac_init_qm(struct fbnic_dev *fbd)
 #define FBNIC_DROP_EN_MASK	0x7d
 #define FBNIC_PAUSE_EN_MASK	0x14
 #define FBNIC_ECN_EN_MASK	0x10
+#define FBNIC_PS_EN_MASK	0x01
 
 struct fbnic_fifo_config {
 	unsigned int addr;
@@ -424,13 +425,17 @@ static void fbnic_mac_tx_pause_config(struct fbnic_dev *fbd, bool tx_pause)
 {
 	u32 rxb_pause_ctrl;
 
-	/* Enable generation of pause frames if enabled */
+	/* Enable generation of pause frames based on tx_pause setting */
 	rxb_pause_ctrl = rd32(fbd, FBNIC_RXB_PAUSE_DROP_CTRL);
-	rxb_pause_ctrl &= ~FBNIC_RXB_PAUSE_DROP_CTRL_PAUSE_ENABLE;
-	if (tx_pause)
+	rxb_pause_ctrl &= ~(FBNIC_RXB_PAUSE_DROP_CTRL_PAUSE_ENABLE |
+			    FBNIC_RXB_PAUSE_DROP_CTRL_PS_ENABLE);
+	if (tx_pause) {
 		rxb_pause_ctrl |=
 			FIELD_PREP(FBNIC_RXB_PAUSE_DROP_CTRL_PAUSE_ENABLE,
-				   FBNIC_PAUSE_EN_MASK);
+				   FBNIC_PAUSE_EN_MASK) |
+			FIELD_PREP(FBNIC_RXB_PAUSE_DROP_CTRL_PS_ENABLE,
+				   FBNIC_PS_EN_MASK);
+	}
 	wr32(fbd, FBNIC_RXB_PAUSE_DROP_CTRL, rxb_pause_ctrl);
 }
 
@@ -445,6 +450,33 @@ static int fbnic_mac_get_link_event(struct fbnic_dev *fbd)
 	       FBNIC_LINK_EVENT_UP : FBNIC_LINK_EVENT_NONE;
 }
 
+static void fbnic_mac_pause_storm_config(struct fbnic_dev *fbd, bool tx_pause)
+{
+	u32 reg;
+
+	wr32(fbd, FBNIC_RXB_PAUSE_STORM_UNIT_WR,
+	     FBNIC_RXB_PAUSE_STORM_CLK_DIV);
+
+	wr32(fbd, FBNIC_RXB_PAUSE_STORM(0),
+	     FIELD_PREP(FBNIC_RXB_PAUSE_STORM_THLD_TIME,
+			FBNIC_MAC_PAUSE_STORM_INTERVAL));
+
+	/* There is a possibility that in transition from tx_pause enable to
+	 * disable, the interrupt status was set and we did not clear it. To
+	 * handle this case, we will clear the interrupt status here.
+	 */
+	wr32(fbd, FBNIC_RXB_ERR_INTR_STS,
+	     FIELD_PREP(FBNIC_RXB_ERR_INTR_STS_PS, FBNIC_PS_EN_MASK));
+
+	/* Unmask the Network to Host PS interrupt if tx_pause is on */
+	reg = rd32(fbd, FBNIC_RXB_ERR_INTR_MASK);
+	reg |= FBNIC_RXB_ERR_INTR_STS_PS;
+	if (tx_pause)
+		reg &= ~FIELD_PREP(FBNIC_RXB_ERR_INTR_STS_PS,
+				   FBNIC_PS_EN_MASK);
+	wr32(fbd, FBNIC_RXB_ERR_INTR_MASK, reg);
+}
+
 static u32 __fbnic_mac_cmd_config_asic(struct fbnic_dev *fbd,
 				       bool tx_pause, bool rx_pause)
 {
@@ -658,6 +690,7 @@ static void fbnic_mac_link_up_asic(struct fbnic_dev *fbd,
 	u32 cmd_cfg, mac_ctrl;
 
 	fbnic_mac_tx_pause_config(fbd, tx_pause);
+	fbnic_mac_pause_storm_config(fbd, tx_pause);
 
 	cmd_cfg = __fbnic_mac_cmd_config_asic(fbd, tx_pause, rx_pause);
 	mac_ctrl = rd32(fbd, FBNIC_SIG_MAC_IN0);
@@ -918,3 +951,24 @@ int fbnic_mac_init(struct fbnic_dev *fbd)
 
 	return 0;
 }
+
+void fbnic_mac_rxb_pause_storm_handler(struct fbnic_dev *fbd)
+{
+	u32 rxb_err_sts = rd32(fbd, FBNIC_RXB_ERR_INTR_STS);
+
+	/* Check if pause storm interrupt for network was triggered */
+	if (rxb_err_sts & FBNIC_RXB_ERR_INTR_STS_PS) {
+		wr32(fbd, FBNIC_RXB_PAUSE_STORM(0),
+		     FIELD_PREP(FBNIC_RXB_PAUSE_STORM_THLD_TIME,
+				FBNIC_MAC_PAUSE_STORM_INTERVAL) |
+		     FBNIC_RXB_PAUSE_STORM_FORCE_NORMAL);
+		wrfl(fbd);
+		wr32(fbd, FBNIC_RXB_PAUSE_STORM(0),
+		     FIELD_PREP(FBNIC_RXB_PAUSE_STORM_THLD_TIME,
+				FBNIC_MAC_PAUSE_STORM_INTERVAL));
+
+		/* Write 1 to clear the interrupt status */
+		wr32(fbd, FBNIC_RXB_ERR_INTR_STS,
+		     FIELD_PREP(FBNIC_RXB_ERR_INTR_STS_PS, FBNIC_PS_EN_MASK));
+	}
+}
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
index f08fe8b7c497..812023a33d5c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
@@ -8,6 +8,20 @@
 
 struct fbnic_dev;
 
+/* The RXB clock runs at 600 MHZ in the ASIC and the PAUSE_STORM_UNIT_WR
+ * is 10us granularity, so set the clock to 6000 (0x1770)
+ */
+#define FBNIC_RXB_PAUSE_STORM_CLK_DIV	0x1770
+
+/* Configure the timer to 500msec which should be longer than any
+ * reasonable period of continuous pausing. The service task, which runs
+ * once per second, periodically resets the pause storm trigger.
+
+ * As a result on a functioning system we enforce a 50% duty cycle should
+ * continuous pause ever occur. A crashed system will not have the service
+ * task and therefore pause will remain disabled until reboot recovery.
+ */
+#define FBNIC_MAC_PAUSE_STORM_INTERVAL	50000
 #define FBNIC_MAX_JUMBO_FRAME_SIZE	9742
 
 /* States loosely based on section 136.8.11.7.5 of IEEE 802.3-2022 Ethernet
@@ -119,4 +133,5 @@ struct fbnic_mac {
 
 int fbnic_mac_init(struct fbnic_dev *fbd);
 void fbnic_mac_get_fw_settings(struct fbnic_dev *fbd, u8 *aui, u8 *fec);
+void fbnic_mac_rxb_pause_storm_handler(struct fbnic_dev *fbd);
 #endif /* _FBNIC_MAC_H_ */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 9240673c7533..a8c9dc2d0d6c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -216,6 +216,10 @@ static void fbnic_service_task(struct work_struct *work)
 
 	fbnic_get_hw_stats32(fbd);
 
+	if (!FIELD_GET(FBNIC_MAC_COMMAND_CONFIG_TX_PAUSE_DIS,
+		       rd32(fbd, FBNIC_MAC_COMMAND_CONFIG)))
+		fbnic_mac_rxb_pause_storm_handler(fbd);
+
 	fbnic_fw_check_heartbeat(fbd);
 
 	fbnic_health_check(fbd);
-- 
2.47.3


