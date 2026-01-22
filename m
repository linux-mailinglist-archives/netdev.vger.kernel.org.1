Return-Path: <netdev+bounces-252509-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gP5bKvF4cmlSlQAAu9opvQ
	(envelope-from <netdev+bounces-252509-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:22:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 874756CF83
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 65CA330090BF
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642DC3876DD;
	Thu, 22 Jan 2026 19:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETSSXDQm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEC731D750
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 19:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769109740; cv=none; b=RKVpOslYEP2t8Qp+bGHNEYJXaELMT8UcP0CydcRP7I8siL5nSawYxDlXA08MwNekWX3SOJ/OOi/mazNjAXh4zAlwRxB9wmId/d+tkyl1QiQoKHPbCrSXs3wPwle2FxTrmD6TtCsUam3eaXDu2xsI2JyN2cX7SNIylvL/ufEAFYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769109740; c=relaxed/simple;
	bh=wh2hfmSBVIk5bVhrCL3lt/QdK8PI9KqD5JH8sD3GlCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udHjoYirpneVluxkWP0j9DSL0O7QvDvpZMoSieimOeLTy5eI+7GJzZZ9kAuWhM4RgIegOHB35jJid/XoYol0ZD6kocGkYP1fKPm9UPn+WbaKtXeeTbooR65SIQ6ufMQc2ua4uQbTX8hIleWZnFP0yb4rQpckeNSWNnokJodjT00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETSSXDQm; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so13757715e9.3
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 11:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769109728; x=1769714528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBMFeq/3WGaXDHQwYjy0vkCwllcaRFT6SwAmaIGYkOk=;
        b=ETSSXDQm/E9ssDh7jZKIQSYdQhTN+nYANcv894DFg27wUO7d0AchEz3MyNwAUbUk0y
         elkcx5KZfcan3omi0biNhxLNHgqUzCmHzUxU74IlpuVbCnVTGfKIttF1rEM1nSgOavd5
         JGywZ7hy4KQR9JVtjVCr7IsOT2u+6yt7kVPv8P/tr6SyLn6ciaXjclqA0epNFz2XLRDM
         7IyzO0iDXdJm6ktbEgAJrMnUN85hNA/eLarOMbbkrfedBbdpoRkN4qSw9n3Z55gTbhW1
         l1vGU2BBJJ7qIxdGDSH79awFUwWp+DfUgezf83QzrWvjfPMvDGA2uOWlJYruZpcfc5hj
         3qJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769109728; x=1769714528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PBMFeq/3WGaXDHQwYjy0vkCwllcaRFT6SwAmaIGYkOk=;
        b=ONv6/SMVhCHQORg5H+aUQgsDVt51nqGbSAkhj+2nO4PJMeAH3m1W498Xv0LGeT1pwu
         3kFnu7k5FwbHQKn78dcWUEuiGanmEG3A9MArD8mJW4+2FUlwM3C8I0drKE1nhLxfhdig
         riuHSnV2uxcjj133uQiQrCm7CGZG63QdEbKSx65xwUIyNa7hFDN4XzYMnwRW4roDaxBZ
         Uh1//40InaQG1bWQqpKPAI7u6x5VdNMU2hS9WTHOk7j5/0Fi7fZyCCB/FLJ+jmRqg9WS
         F2hQuBKRCBh02hqiTYb3SAilXayVZuc7SoZErq8G9blNt4E9YE2wvr6jpWJAnpnfu77V
         fswg==
X-Gm-Message-State: AOJu0YwfFq4EB9RwUWINpiA87IFVnAy87R1UqrN1y7L+H1BK2cgPvKYY
	w6Z7O6LNwb/Dc/1UTkKQmjB+EZGu7PARzk22+RiThNNiZSKeD1ifgyorrEMbQlHC
X-Gm-Gg: AZuq6aKsB51FZWtMP7nvLLjpZISqCboehpe03LLPkaY+vg6hjJI6P7lti/6JIP/cYsF
	583a51wywt9SoxrlYmwuSFmmSFOfrKwV3IWLt38pDj9uiwCfti/v1gPRPQR2ocmHcfea+Q//czZ
	Pvp+WNzoJbCg4qJveWxlaJgvPo17eLM/x66R2dHrEN/FnPLNKuK6kSUnGm12OKEdixBMs6DmeXQ
	TAoDxpa6q9XjwsCt5R6wkm8A5wlRRAzsARGE6pmSC3+zYQWyiOXRF6hmh+8RQSNFdRfmkkqer1L
	7izJKYTrLI9UzFMmVa2ExlZjoJ00d3OXTOxSeh2vCsxV/tu2/OZD+3TTvdQuB4GXzPnlRk7jljK
	X1DrHHVsGQIOQl+sEWaWCK/vhtwVKFlaAGcBsZAiEm3m63/r73Es8mLb8pGGYWxNOfQcMpyWQr6
	0a5wc52fRL
X-Received: by 2002:a05:600c:3b20:b0:477:63b5:7148 with SMTP id 5b1f17b1804b1-4804c94c3f3mr10782145e9.6.1769109728298;
        Thu, 22 Jan 2026 11:22:08 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:5f::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f745c5sm856943f8f.32.2026.01.22.11.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 11:22:07 -0800 (PST)
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
Subject: [PATCH net-next 3/3] eth: fbnic: Fetch TX pause storm stats
Date: Thu, 22 Jan 2026 11:21:58 -0800
Message-ID: <20260122192158.428882-4-mohsin.bashr@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-252509-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 874756CF83
X-Rspamd-Action: no action

With pause storm protection in place, track the occurrence of pause
storm events. Since there is a one-to-one mapping between pause storm
interrupts and events, use the interrupt count to track this metric.

./ethtool -I -a eth0
Pause parameters for eth0:
Autonegotiate:	off
RX:		off
TX:		on
Statistics:
  tx_pause_frames: 759657
  rx_pause_frames: 0
  tx_pause_storm_events: 219

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h      |  1 +
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c  |  3 +++
 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h |  1 +
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c      | 15 +++++++++++++++
 4 files changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index 39eb7b94a310..53c04293083c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -627,6 +627,7 @@ enum {
 	FBNIC_RXB_ENQUEUE_INDICES	= 4
 };
 
+#define FBNIC_RXB_INTR_PS_COUNT(n)	(0x080e9 + (n))	/* 0x203a4 + 4*n */
 #define FBNIC_RXB_DRBO_FRM_CNT_SRC(n)	(0x080f9 + (n))	/* 0x203e4 + 4*n */
 #define FBNIC_RXB_DRBO_BYTE_CNT_SRC_L(n) \
 					(0x080fd + (n))	/* 0x203f4 + 4*n */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 61b8005a0db5..ad7bf876a044 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -1707,6 +1707,7 @@ fbnic_get_pause_stats(struct net_device *netdev,
 	struct fbnic_net *fbn = netdev_priv(netdev);
 	struct fbnic_mac_stats *mac_stats;
 	struct fbnic_dev *fbd = fbn->fbd;
+	u64 tx_ps_events;
 
 	mac_stats = &fbd->hw_stats.mac;
 
@@ -1714,6 +1715,8 @@ fbnic_get_pause_stats(struct net_device *netdev,
 
 	pause_stats->tx_pause_frames = mac_stats->pause.tx_pause_frames.value;
 	pause_stats->rx_pause_frames = mac_stats->pause.rx_pause_frames.value;
+	tx_ps_events = mac_stats->pause.tx_pause_storm_events.value;
+	pause_stats->tx_pause_storm_events = tx_ps_events;
 }
 
 static void
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
index aa3f429a9aed..caea4be46762 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
@@ -54,6 +54,7 @@ struct fbnic_rmon_stats {
 struct fbnic_pause_stats {
 	struct fbnic_stat_counter tx_pause_frames;
 	struct fbnic_stat_counter rx_pause_frames;
+	struct fbnic_stat_counter tx_pause_storm_events;
 };
 
 struct fbnic_eth_mac_stats {
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index 9cdf21192f98..97ae7086d7bd 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -418,6 +418,18 @@ static void __fbnic_mac_stat_rd64(struct fbnic_dev *fbd, bool reset, u32 reg,
 	stat->reported = true;
 }
 
+static void fbnic_mac_stat_rd32(struct fbnic_dev *fbd, bool reset, u32 reg,
+				struct fbnic_stat_counter *stat)
+{
+	u32 new_reg_value;
+
+	new_reg_value = rd32(fbd, reg);
+	if (!reset)
+		stat->value += new_reg_value - stat->u.old_reg_value_32;
+	stat->u.old_reg_value_32 = new_reg_value;
+	stat->reported = true;
+}
+
 #define fbnic_mac_stat_rd64(fbd, reset, __stat, __CSR) \
 	__fbnic_mac_stat_rd64(fbd, reset, FBNIC_##__CSR##_L, &(__stat))
 
@@ -792,6 +804,9 @@ fbnic_mac_get_pause_stats(struct fbnic_dev *fbd, bool reset,
 			    MAC_STAT_TX_XOFF_STB);
 	fbnic_mac_stat_rd64(fbd, reset, pause_stats->rx_pause_frames,
 			    MAC_STAT_RX_XOFF_STB);
+	fbnic_mac_stat_rd32(fbd, reset,
+			    FBNIC_RXB_INTR_PS_COUNT(FBNIC_RXB_INTF_NET),
+			    &pause_stats->tx_pause_storm_events);
 }
 
 static void
-- 
2.47.3


