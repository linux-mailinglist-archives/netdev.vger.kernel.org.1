Return-Path: <netdev+bounces-299173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1CQrJD1YLmoYtwQAu9opvQ
	(envelope-from <netdev+bounces-299173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 09:29:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E820868090D
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 09:29:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=eUWu9Kea;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299173-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299173-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 720083025D12
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 07:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD383932F2;
	Sun, 14 Jun 2026 07:25:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C6D3939B4
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 07:25:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781421944; cv=none; b=HiJhlJUFgGumF3SbJCUm8wtr+akkfMXhXrnyLqEbrxD79cnD8Pjuc3Bbeq7Oq1Hh/Upf00e2SQxvrqpLXBR/EtjfaVOsYE/4oK/xCHax6kkps99plXcqPV9RVU/Cbatnmmu1cBqVYAEzwjAwIK+zK9aOx4mjJD6dhHPkrZNKEVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781421944; c=relaxed/simple;
	bh=MP2mayyVJwIb5OisvaNohzdk0gKHNsjuI085pUx1g+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvYCvZjV2cv09Uus+dHCqaJgNURSjUdqpxO5gzqJlb97Zsr9/QxR9xZsQRhhi6CLE57OyxwzwidGMDClrtp5/rJNvm+b4kAh7X7rt7n4axd0rHNxx/HkYGEzIYnmmlyPj3qAnPxFvpUHxtLnVIUdvjerYQ1cnLZEG0A249TPXBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eUWu9Kea; arc=none smtp.client-ip=209.85.214.227
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2c68190ade4so897475ad.0
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 00:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781421942; x=1782026742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eThK1kV6Eo4ZM9VJ7T8ZuKF0viyAbgkh3u4N71GtQ8M=;
        b=SJic7A1EVfkcUvk7jXJExFTM48SOaN4WCe1k6E+XqLRvY1pgyi2SnBaPRlmnvYpdBO
         LAo4owkiGjF4gy6SUFpvnKn27qvqZfg3k4FCVo2MLxMqDI5c40kB7j/3Uri9kvOAMByd
         EjzN+qAw6bjb2rcgm5jauyvR8Cnynh4A1DQC8XtEegccvomXfz49Hn+LvtDLVwXTMWku
         HqIZHyrGmjyd2Ak0W6R2XP0yClK6zilLPflNjzHB0aTKyQWaaasLBdAbKTv97GHe+brO
         2sZD46CJ3P57Q78cyeBI9jlAUbWjBJx68pFd/Uzky1h880U9WucpvPjnvWEeN2X/t193
         Vrig==
X-Gm-Message-State: AOJu0YxH45hoKu06pvuypQkDzV0EHW1m0j52Ji1aHRAj3j4UR+4eEr1N
	6E2/r04oA/pSr5TLnHjCT41QZiMRNAfQdzr9qXhxV6kpT2Mlnci0y7BEmGOIPwTdyeW0ur75ZH2
	1LJPsnhGY8jopPC92QZwq7SDQHoiinRz3/qkI6dW1U8UydSdbj5S/eiroq350L8uT6uMw1Tf3fL
	M0lJrUtOXS4jLT76NHbU15HVmJELUbGqIyeEvkcFT/xNntXekP3sVtvwqpzoz9tDPLbkAVxxVA9
	sJM+nao5k4=
X-Gm-Gg: Acq92OHsoVkFymGSVYrcZncsa3OclAZUj5H2wcBKdqWHoF0Q2iNrLgtcIA/btWR1Os1
	D+2LJFhgf+60VGXYU5Tnhzn7lyO3FFiwfJcaHnat+/8n96WD4IDUSF83XP+mJOpJTWbNVJ1QFHy
	DC6X4/1vu75Wwmd99AZVHqyeKkxtoTq2aTj9KnYgGY2dM8MuJHcx3PEvLLRMsgRaTRxU5g5wLCe
	G9lYu9CCJcswaBdemdaDk9FuCwlZ5Tzu3XmBJGg8twuOAPMm5rxEnA7BGgF8JbARh0jyjTxYlGe
	sxr/X8tDs/oYIo/Q4QCBXkkiYFMZqLGLWcUvJoi4loMNcnzKezSiAgclM/OM1snz8JuvFad3t2D
	46+6JB2PdWlGPP04LhPjPq5CJd/3IefxVvyuaGYm5OZf/W46w9yympCXhunYODbfYpLHVrKunM1
	kPSIVQhiy9/MrlxjGMtpCsjvPzMEQ2TatUz7qtXQgjDHmA5swwkXqlO7cx
X-Received: by 2002:a17:902:da8a:b0:2c0:a4c3:d7a with SMTP id d9443c01a7336-2c3fd9eb609mr79695855ad.26.1781421941883;
        Sun, 14 Jun 2026 00:25:41 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2c430586081sm5668495ad.20.2026.06.14.00.25.41
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jun 2026 00:25:41 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-304d2447962so2346706eec.0
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 00:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781421940; x=1782026740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eThK1kV6Eo4ZM9VJ7T8ZuKF0viyAbgkh3u4N71GtQ8M=;
        b=eUWu9KeaSbr5TgnDXbD5JVJHBi2qE1ZCwYdQOeFCs/dP12hVa4nonmvglyvnfjbk9k
         iq/rvGYKZ6MTVb2fmsIbTKOcuHXMd8S+Wj1C6hJyqA1aC6n4cBTDD8g5/tKHqPNy8gJR
         8SVG77XI/qXRSxTGzZOJSNbUWTmx+bIeC1dHA=
X-Received: by 2002:a05:7301:c003:b0:304:56fc:775 with SMTP id 5a478bee46e88-3081e615564mr3799078eec.21.1781421939705;
        Sun, 14 Jun 2026 00:25:39 -0700 (PDT)
X-Received: by 2002:a05:7301:c003:b0:304:56fc:775 with SMTP id 5a478bee46e88-3081e615564mr3799064eec.21.1781421938980;
        Sun, 14 Jun 2026 00:25:38 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea43bc7sm10043280eec.22.2026.06.14.00.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 00:25:37 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v3 15/15] bnxt_en: Add kTLS retransmission support
Date: Sun, 14 Jun 2026 00:24:07 -0700
Message-ID: <20260614072407.2761092-16-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260614072407.2761092-1-michael.chan@broadcom.com>
References: <20260614072407.2761092-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-299173-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:pavan.chebbi@broadcom.com,m:andrew.gospodarek@broadcom.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E820868090D

If TCP retransmits a TLS packet that requires encryption by the NIC, the
TCP sequence number will go backwards and the hardware will require some
assistance from the driver.  The driver needs to retrieve the TLS record
that covers the byte sequence of the retransmitted packet.  If the
retransmitted packet does not include the tag, the hardware can simply
encrypt the packet using the informtaion in the TLS record.

The driver provides the TLS record information for the retransmitted
packet in the presync TX BD.  The presync TX BD introduced in the last
patch is treated very much like a TX push BD with inline data.  The only
exception is that no SKB will be stored for the presync TX BD.

Retransmission that includes the TLS tag will be handled in future
patches.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v3:
Unwind the TX ring properly if the TLS packet cannot be sent.

Improve the OOO TLS counters.

Fix endianness of the record sequence number.

Check valid return address from skb_frag_address_safe().

v2:
https://lore.kernel.org/netdev/20260512212105.3488258-16-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  14 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   4 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   4 +
 .../net/ethernet/broadcom/bnxt/bnxt_ktls.c    | 152 +++++++++++++++++-
 .../net/ethernet/broadcom/bnxt/bnxt_ktls.h    |   2 +
 5 files changed, 167 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index ce3175721be2..2e4d11977407 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -482,9 +482,9 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	unsigned int length, pad = 0;
 	u32 len, free_size, vlan_tag_flags, cfa_action, flags;
 	struct bnxt_ktls_offload_ctx_tx *kctx_tx = NULL;
+	u16 prod, start_prod, last_frag, txts_prod;
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
 	struct pci_dev *pdev = bp->pdev;
-	u16 prod, last_frag, txts_prod;
 	struct bnxt_tx_ring_info *txr;
 	struct bnxt_sw_tx_bd *tx_buf;
 	__le32 lflags = 0;
@@ -500,7 +500,6 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	txq = netdev_get_tx_queue(dev, i);
 	txr = &bp->tx_ring[bp->tx_ring_map[i]];
-	prod = txr->tx_prod;
 
 #if (MAX_SKB_FRAGS > TX_MAX_FRAGS)
 	if (skb_shinfo(skb)->nr_frags > TX_MAX_FRAGS) {
@@ -529,12 +528,14 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			return NETDEV_TX_BUSY;
 	}
 
+	start_prod = txr->tx_prod;
 	skb = bnxt_ktls_xmit(bp, txr, skb, &lflags, &kid, &kctx_tx);
 	if (unlikely(!skb)) {
 		dev_core_stats_tx_dropped_inc(dev);
 		return NETDEV_TX_OK;
 	}
 
+	prod = txr->tx_prod;
 	length = skb->len;
 	len = skb_headlen(skb);
 	last_frag = skb_shinfo(skb)->nr_frags;
@@ -817,9 +818,16 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			/* set SKB to err so PTP worker will clean up */
 			ptp->txts_req[txts_prod].tx_skb = ERR_PTR(-EIO);
 	}
+	txr->tx_buf_ring[RING_TX(bp, txr->tx_prod)].skb = NULL;
+	/* Unwind any kTLS presync BDs */
+	if (unlikely(txr->tx_prod != start_prod)) {
+		tx_buf = &txr->tx_buf_ring[RING_TX(bp, start_prod)];
+		tx_buf->is_push = 0;
+		tx_buf->inline_data_bds = 0;
+		WRITE_ONCE(txr->tx_prod, start_prod);
+	}
 	if (txr->kick_pending)
 		bnxt_txr_db_kick(bp, txr, txr->tx_prod);
-	txr->tx_buf_ring[RING_TX(bp, txr->tx_prod)].skb = NULL;
 	dev_core_stats_tx_dropped_inc(dev);
 	return NETDEV_TX_OK;
 }
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 500bb9171274..339f5bdf2f20 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1191,6 +1191,10 @@ struct bnxt_cmn_sw_stats {
 enum bnxt_ktls_data_counters {
 	BNXT_KTLS_TX_PKTS = 0,
 	BNXT_KTLS_TX_BYTES,
+	BNXT_KTLS_TX_OOO_PKTS,
+	BNXT_KTLS_TX_OOO_FALLBACK_NO_SYNC,
+	BNXT_KTLS_TX_OOO_FALLBACK_NO_SPACE,
+	BNXT_KTLS_TX_OOO_FALLBACK_NO_HDR,
 
 	BNXT_KTLS_MAX_DATA_COUNTERS,
 };
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 9b2bc38236d7..8d2ee1976e1a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -359,6 +359,10 @@ static const char *const bnxt_ring_drv_stats_arr[] = {
 static const char *const bnxt_ktls_data_stats[] = {
 	[BNXT_KTLS_TX_PKTS]		= "tx_tls_encrypted_packets",
 	[BNXT_KTLS_TX_BYTES]		= "tx_tls_encrypted_bytes",
+	[BNXT_KTLS_TX_OOO_PKTS]			= "tx_tls_ooo_packets",
+	[BNXT_KTLS_TX_OOO_FALLBACK_NO_SYNC]	= "tx_tls_ooo_fallback_no_sync",
+	[BNXT_KTLS_TX_OOO_FALLBACK_NO_SPACE]	= "tx_tls_ooo_fallback_no_space",
+	[BNXT_KTLS_TX_OOO_FALLBACK_NO_HDR]	= "tx_tls_ooo_fallback_no_hdr",
 };
 
 /* kTLS control plane counter strings indexed by enum bnxt_ktls_ctrl_counters */
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
index 298fb08e7b9b..4ed2d9d8e10c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
@@ -339,7 +339,8 @@ int bnxt_ktls_init(struct bnxt *bp)
 	return 0;
 }
 
-static void bnxt_ktls_inc_tx_stats(struct bnxt_tx_ring_info *txr, u32 bytes)
+static void bnxt_ktls_inc_tx_stats(struct bnxt_tx_ring_info *txr, u32 bytes,
+				   bool ooo)
 {
 	struct bnxt_tls_sw_stats *ring_stats = txr->tls_stats;
 
@@ -347,6 +348,128 @@ static void bnxt_ktls_inc_tx_stats(struct bnxt_tx_ring_info *txr, u32 bytes)
 		return;
 	ring_stats->counters[BNXT_KTLS_TX_PKTS]++;
 	ring_stats->counters[BNXT_KTLS_TX_BYTES] += bytes;
+	if (ooo)
+		ring_stats->counters[BNXT_KTLS_TX_OOO_PKTS]++;
+}
+
+static void bnxt_ktls_pre_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			       u32 kid, struct crypto_prefix_cmd *pre_cmd)
+{
+	struct bnxt_sw_tx_bd *tx_buf;
+	struct tx_bd_presync *psbd;
+	u32 bd_space, space;
+	u8 *pcmd;
+	u16 prod;
+
+	prod = txr->tx_prod;
+	tx_buf = &txr->tx_buf_ring[RING_TX(bp, prod)];
+
+	psbd = (void *)&txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
+	psbd->tx_bd_len_flags_type = CRYPTO_PRESYNC_BD_CMD;
+	psbd->tx_bd_kid = cpu_to_le32(BNXT_KID_HW(kid));
+	psbd->tx_bd_opaque =
+		SET_TX_OPAQUE(bp, txr, prod, CRYPTO_PREFIX_CMD_BDS + 1);
+
+	prod = NEXT_TX(prod);
+	pcmd = (void *)&txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
+	bd_space = TX_DESC_CNT - TX_IDX(prod);
+	space = bd_space * sizeof(struct tx_bd);
+	if (space >= CRYPTO_PREFIX_CMD_SIZE) {
+		memcpy(pcmd, pre_cmd, CRYPTO_PREFIX_CMD_SIZE);
+		prod += CRYPTO_PREFIX_CMD_BDS;
+	} else {
+		memcpy(pcmd, pre_cmd, space);
+		prod += bd_space;
+		pcmd = (void *)&txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
+		memcpy(pcmd, (u8 *)pre_cmd + space,
+		       CRYPTO_PREFIX_CMD_SIZE - space);
+		prod += CRYPTO_PREFIX_CMD_BDS - bd_space;
+	}
+	txr->tx_prod = prod;
+	tx_buf->is_push = 1;
+	/* Minus 1 since the header psbd is a single entry short BD */
+	tx_buf->inline_data_bds = CRYPTO_PREFIX_CMD_BDS - 1;
+}
+
+static int bnxt_ktls_tx_ooo(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			    struct sk_buff *skb, u32 payload_len, u32 seq,
+			    struct tls_context *tls_ctx)
+{
+	struct bnxt_tls_sw_stats *ring_stats = txr->tls_stats;
+	struct tls_offload_context_tx *tx_tls_ctx;
+	struct bnxt_ktls_offload_ctx_tx *kctx_tx;
+	u32 hdr_tcp_seq, end_seq, total_bds;
+	struct crypto_prefix_cmd pcmd = {};
+	struct tls_record_info *record;
+	unsigned long flags;
+	bool fwd = false;
+	__le64 le_rec_sn;
+	u64 rec_sn;
+	u8 *hdr;
+	int rc;
+
+	tx_tls_ctx = tls_offload_ctx_tx(tls_ctx);
+	kctx_tx = bnxt_get_ktls_ctx_tx(tls_ctx);
+	end_seq = seq + skb->len - skb_tcp_all_headers(skb);
+	if (unlikely(after(seq, kctx_tx->tcp_seq_no) ||
+		     after(end_seq, kctx_tx->tcp_seq_no))) {
+		fwd = true;
+		pcmd.flags = CRYPTO_PREFIX_CMD_FLAGS_UPDATE_IN_ORDER_VAR_LE;
+	}
+
+	spin_lock_irqsave(&tx_tls_ctx->lock, flags);
+	record = tls_get_record(tx_tls_ctx, seq, &rec_sn);
+	if (!record || !record->num_frags) {
+		rc = -EPROTO;
+		ring_stats->counters[BNXT_KTLS_TX_OOO_FALLBACK_NO_SYNC]++;
+		goto unlock_exit;
+	}
+	hdr_tcp_seq = tls_record_start_seq(record);
+	hdr = skb_frag_address_safe(&record->frags[0]);
+
+	total_bds = CRYPTO_PRESYNC_BDS + skb_shinfo(skb)->nr_frags + 2;
+	if (bnxt_tx_avail(bp, txr) < total_bds) {
+		rc = -ENOSPC;
+		ring_stats->counters[BNXT_KTLS_TX_OOO_FALLBACK_NO_SPACE]++;
+		goto unlock_exit;
+	}
+
+	if (before(record->end_seq - tls_ctx->prot_info.tag_size,
+		   seq + payload_len)) {
+		/* retransmission includes tag bytes */
+		rc = -EOPNOTSUPP;
+		goto unlock_exit;
+	}
+	pcmd.header_tcp_seq_num = cpu_to_le32(hdr_tcp_seq);
+	pcmd.start_tcp_seq_num = cpu_to_le32(seq);
+	pcmd.end_tcp_seq_num = cpu_to_le32(seq + payload_len - 1);
+	if (tls_ctx->prot_info.version == TLS_1_2_VERSION) {
+		u32 nonce_bytes = tls_ctx->prot_info.iv_size;
+		u32 retrans_off = seq - hdr_tcp_seq;
+
+		if (!hdr) {
+			rc = -ENOBUFS;
+			ring_stats->counters[BNXT_KTLS_TX_OOO_FALLBACK_NO_HDR]++;
+			goto unlock_exit;
+		}
+		if (retrans_off > 5 && retrans_off < 5 + nonce_bytes)
+			nonce_bytes = retrans_off - 5;
+		memcpy(pcmd.explicit_nonce, hdr + 5, nonce_bytes);
+	}
+	le_rec_sn = cpu_to_le64(rec_sn);
+	memcpy(&pcmd.record_seq_num[0], &le_rec_sn, sizeof(le_rec_sn));
+
+	rc = 0;
+	bnxt_ktls_pre_xmit(bp, txr, kctx_tx->kid, &pcmd);
+
+	if (fwd) {
+		kctx_tx->next_tcp_seq_no = end_seq;
+		kctx_tx->pending_fwd = 1;
+	}
+
+unlock_exit:
+	spin_unlock_irqrestore(&tx_tls_ctx->lock, flags);
+	return rc;
 }
 
 struct sk_buff *bnxt_ktls_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
@@ -357,6 +480,7 @@ struct sk_buff *bnxt_ktls_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 	struct bnxt_ktls_offload_ctx_tx *kctx_tx;
 	struct tls_context *tls_ctx;
 	u32 seq, payload_len;
+	int rc;
 
 	if (!IS_ENABLED(CONFIG_TLS_DEVICE) || !ktls ||
 	    !tls_is_skb_tx_device_offloaded(skb))
@@ -375,14 +499,25 @@ struct sk_buff *bnxt_ktls_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 		 */
 		kctx_tx->next_tcp_seq_no = seq + payload_len;
 		kctx_tx->pending_bytes = payload_len;
+		kctx_tx->pending_ooo = 0;
+		kctx_tx->pending_fwd = 1;
 		*kid = BNXT_KID_HW(kctx_tx->kid);
 		*kctx_tx_p = kctx_tx;
 		*lflags |= cpu_to_le32(TX_BD_FLAGS_CRYPTO_EN |
 				       BNXT_TX_KID_LO(*kid));
 	} else {
-		skb = tls_encrypt_skb(skb);
-		if (!skb)
-			return NULL;
+		kctx_tx->pending_fwd = 0;
+		rc = bnxt_ktls_tx_ooo(bp, txr, skb, payload_len, seq, tls_ctx);
+		if (rc)
+			return tls_encrypt_skb(skb);
+
+		kctx_tx->pending_bytes = payload_len;
+		kctx_tx->pending_ooo = 1;
+		*kid = BNXT_KID_HW(kctx_tx->kid);
+		*kctx_tx_p = kctx_tx;
+		*lflags |= cpu_to_le32(TX_BD_FLAGS_CRYPTO_EN |
+				       BNXT_TX_KID_LO(*kid));
+		return skb;
 	}
 	return skb;
 }
@@ -392,8 +527,13 @@ void bnxt_ktls_xmit_commit(struct bnxt_tx_ring_info *txr,
 {
 	if (!kctx_tx)
 		return;
-	kctx_tx->tcp_seq_no = kctx_tx->next_tcp_seq_no;
-	bnxt_ktls_inc_tx_stats(txr, kctx_tx->pending_bytes);
+	if (kctx_tx->pending_fwd)
+		kctx_tx->tcp_seq_no = kctx_tx->next_tcp_seq_no;
+	bnxt_ktls_inc_tx_stats(txr, kctx_tx->pending_bytes,
+			       kctx_tx->pending_ooo);
+	kctx_tx->pending_bytes = 0;
+	kctx_tx->pending_fwd = 0;
+	kctx_tx->pending_ooo = 0;
 }
 
 int bnxt_ktls_alloc_tx_ring_stats(struct bnxt *bp, struct bnxt_tx_ring_info *txr)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h
index 1c935e0d413d..40b94bbf5a38 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h
@@ -43,6 +43,8 @@ struct bnxt_ktls_offload_ctx_tx {
 	u32		next_tcp_seq_no;/* staged tcp seq no */
 	u32		kid;
 	u32		pending_bytes;	/* staged payload bytes */
+	u32		pending_fwd:1;
+	u32		pending_ooo:1;
 };
 
 struct bnxt_ktls_tx_driver_state {
-- 
2.51.0


