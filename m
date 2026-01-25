Return-Path: <netdev+bounces-253232-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDLIDb2UdmnlSQEAu9opvQ
	(envelope-from <netdev+bounces-253232-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:10:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D6C82A18
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79EAD302262C
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5BD3090C9;
	Sun, 25 Jan 2026 22:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COW0xMGw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9641430DED5
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 22:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769378911; cv=none; b=IWLWQlhmJZZXXO0FTkECkoPWDQlzZ/d6o5xu6L9WTKueqKPw7rTp+ZmXfCuvDnTxjuIA6S7e6JHS5aXDAjVBSe5BgXuhWDA6z0BmFqnkLlKlBZQjkqMaoIZyfdFKF964wknOLIYYI/MIeIlnZZcsCRDwGPXZB7nGL7iJU+fCNJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769378911; c=relaxed/simple;
	bh=wTJ8qzQ8hWxnoJK1rQ3XfBHcjbpSs55zlCB+7x/zDzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ttPpDEoYkVW0yheEnQOHCiHfOqMnmzWy7Xz0B9W1gLvEGI6lBLrlGeZFWxLtTN/PiAa6G4tRna+66FXkKugz2gIZVrxQG2VDr9hxks/AzSElsj9h6DMNhc89gzPAlaetQr5tIKBZ+1xTLpCk+aEsfpL+5EQ2DjT1ITPa1K+qa4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COW0xMGw; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82318702afbso2708170b3a.1
        for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 14:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769378908; x=1769983708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpLzaZNrjlWsLrvFCVaRso+CbpWjXp9kenKiBrfGf7Q=;
        b=COW0xMGwo64xfxEuke/s9w0jRoHyljHKQdOi3w7AyMjcZyfJwDsfcqD4dRqzcTKNFR
         20/5jAzvTWeti3t4ltWywS3fpl34Kw+Q5tLhZaIo5uMlnoJcaj7VsMxk2ONDgziz1bju
         yEQNV4bSwGR/k+3ZMszDyUcQ3hJpiXy6x7v0cQwsAAJapDS7/xtyhrChSKtXLHpioMn2
         2GkoGAlQuEZHH9CYTGunoHSVQGya2jp6vOGzq0knhfw9PPQ/ppZwIVXMeylMTJFsEfHm
         Kig7yp/y/cUfWFJk/AQ1YJ8IVgoRShjDJ43zC6abAGdbOlN2YNtcixclBYw9XE6dSQN0
         9GVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769378908; x=1769983708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VpLzaZNrjlWsLrvFCVaRso+CbpWjXp9kenKiBrfGf7Q=;
        b=p6gkTHe2MnZgHvk/YLOdYRYqKbe1AOu96Tk/g9BEpCgthZumj8vAs4ZyhN4M5Hl21j
         hPIfmePEmny1uS8t7MMSjIQdjmhHaLw7nFAbOQQHQEijM218xYWYDhpN3P0z7kxLB4xK
         bitUe26UVehFBtvV/WWM4eIYh1rUn1s/nUukGpSiPtEsduyQ68gRD0IvosUFsIYNOXRa
         3dUcxvpDP9/gAh/ew921DfGvPm8vbRndOoeYlvdiB3pD8ntxR5VVyUFkKyaSzcLE6XHm
         720SgcEwkHdlrzVChFkzoJ+2fYOWbvmoHIAcOuGwTos4rMGeT5u0+6vsVpAoJPNX0p1x
         RD5g==
X-Gm-Message-State: AOJu0YxFyBOonyIqzMUuF5jQ9O08K+ja7QIhyegMhsKwbEqvTE8X6Ww6
	o6f0Vb82MTUHjesMxenm8Age02fZQdiupWaX74GBY75Ia5E3zTyotkkys/Dceg==
X-Gm-Gg: AZuq6aKD0kO5cY6iZkwret2fj38/B0/oDfvG8NhNjjNo7yUaNbalBHHwXiT5w0lxAT1
	KX9KA4RyEhufG6tqCwdPhtzNO/LYbluqKg8vxxmiBjcPUYA5bdVJW3qU6vtnSwBqcGMISroLu8K
	ujERrPUXXK1bhgKdK35jZW2N5EvQBqBjTnhxNehGpudVg1txVWktDI1Rqs8DKGQk/gIRi3/CLGg
	e5SfFnT9MTds4Pl6MIciGP+8XhS6lprHqpc43BPQSn5ydfPNAN6cL0yR9aDFKebbZKSAxuAw3uU
	dz9UUYAmw0CmdQ6b1dSG6Y5Hv42vD68dt14OFO2RBKVDvSFpAzjS5DLeVh4Xa3JLh0gLq0bqvpw
	GYUneoa9D4Qx7N17eXkauyCHWzJJtewrB/hT8wducwNNqgwYEz1yEqB+l4KljIjtLeHubsc5u64
	ApDG4qRRVcgsnK5zvpV+2Awf0BIeNCjQ8my80huGJE7+pbdQdJQQ==
X-Received: by 2002:a05:6a00:8087:b0:823:a81:fe85 with SMTP id d2e1a72fcca58-823412bb5c2mr2275538b3a.54.1769378907690;
        Sun, 25 Jan 2026 14:08:27 -0800 (PST)
Received: from d.home.mmyangfl.tk ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231873e60fsm7651286b3a.48.2026.01.25.14.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 14:08:27 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/2] net: airoha: Use u64_stats_t with u64_stats_sync properly
Date: Mon, 26 Jan 2026 06:07:50 +0800
Message-ID: <20260125220753.3984326-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125220753.3984326-1-mmyangfl@gmail.com>
References: <20260125220753.3984326-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253232-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,lists.infradead.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D1D6C82A18
X-Rspamd-Action: no action

On 64bit arches, struct u64_stats_sync is empty and provides no help
against load/store tearing. Convert to u64_stats_t to ensure atomic
operations.

Signed-off-by: David Yang <mmyangfl@gmail.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 153 +++++++++++++----------
 drivers/net/ethernet/airoha/airoha_eth.h |  34 ++---
 2 files changed, 102 insertions(+), 85 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 62bcbbbe2a95..fe53aa93a003 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1466,137 +1466,154 @@ static void airoha_update_hw_stats(struct airoha_gdm_port *port)
 {
 	struct airoha_eth *eth = port->qdma->eth;
 	u32 val, i = 0;
+	u64 val64;
 
 	spin_lock(&port->stats.lock);
 	u64_stats_update_begin(&port->stats.syncp);
 
 	/* TX */
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_H(port->id));
-	port->stats.tx_ok_pkts += ((u64)val << 32);
+	val64 = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_L(port->id));
-	port->stats.tx_ok_pkts += val;
+	val64 += val;
+	u64_stats_add(&port->stats.tx_ok_pkts, val64);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE_CNT_H(port->id));
-	port->stats.tx_ok_bytes += ((u64)val << 32);
+	val64 = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE_CNT_L(port->id));
-	port->stats.tx_ok_bytes += val;
+	val64 += val;
+	u64_stats_add(&port->stats.tx_ok_bytes, val64);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_DROP_CNT(port->id));
-	port->stats.tx_drops += val;
+	u64_stats_add(&port->stats.tx_drops, val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_BC_CNT(port->id));
-	port->stats.tx_broadcast += val;
+	u64_stats_add(&port->stats.tx_broadcast, val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_MC_CNT(port->id));
-	port->stats.tx_multicast += val;
+	u64_stats_add(&port->stats.tx_multicast, val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_RUNT_CNT(port->id));
-	port->stats.tx_len[i] += val;
+	val64 = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT_H(port->id));
-	port->stats.tx_len[i] += ((u64)val << 32);
+	val64 += (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT_L(port->id));
-	port->stats.tx_len[i++] += val;
+	val64 += val;
+	u64_stats_add(&port->stats.tx_len[i++], val64);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L64_CNT_H(port->id));
-	port->stats.tx_len[i] += ((u64)val << 32);
+	val64 = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L64_CNT_L(port->id));
-	port->stats.tx_len[i++] += val;
+	val64 += val;
+	u64_stats_add(&port->stats.tx_len[i++], val64);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L127_CNT_H(port->id));
-	port->stats.tx_len[i] += ((u64)val << 32);
+	val64 = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L127_CNT_L(port->id));
-	port->stats.tx_len[i++] += val;
+	val64 += val;
+	u64_stats_add(&port->stats.tx_len[i++], val64);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L255_CNT_H(port->id));
-	port->stats.tx_len[i] += ((u64)val << 32);
+	val64 = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L255_CNT_L(port->id));
-	port->stats.tx_len[i++] += val;
+	val64 += val;
+	u64_stats_add(&port->stats.tx_len[i++], val64);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L511_CNT_H(port->id));
-	port->stats.tx_len[i] += ((u64)val << 32);
+	val64 = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L511_CNT_L(port->id));
-	port->stats.tx_len[i++] += val;
+	val64 += val;
+	u64_stats_add(&port->stats.tx_len[i++], val64);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L1023_CNT_H(port->id));
-	port->stats.tx_len[i] += ((u64)val << 32);
+	val64 = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_L1023_CNT_L(port->id));
-	port->stats.tx_len[i++] += val;
+	val64 += val;
+	u64_stats_add(&port->stats.tx_len[i++], val64);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_LONG_CNT(port->id));
-	port->stats.tx_len[i++] += val;
+	u64_stats_add(&port->stats.tx_len[i++], val);
 
 	/* RX */
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_PKT_CNT_H(port->id));
-	port->stats.rx_ok_pkts += ((u64)val << 32);
+	val64 = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_PKT_CNT_L(port->id));
-	port->stats.rx_ok_pkts += val;
+	val64 += val;
+	u64_stats_add(&port->stats.rx_ok_pkts, val64);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_BYTE_CNT_H(port->id));
-	port->stats.rx_ok_bytes += ((u64)val << 32);
+	val64 = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OK_BYTE_CNT_L(port->id));
-	port->stats.rx_ok_bytes += val;
+	val64 += val;
+	u64_stats_add(&port->stats.rx_ok_bytes, val64);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_DROP_CNT(port->id));
-	port->stats.rx_drops += val;
+	u64_stats_add(&port->stats.rx_drops, val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_BC_CNT(port->id));
-	port->stats.rx_broadcast += val;
+	u64_stats_add(&port->stats.rx_broadcast, val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_MC_CNT(port->id));
-	port->stats.rx_multicast += val;
+	u64_stats_add(&port->stats.rx_multicast, val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ERROR_DROP_CNT(port->id));
-	port->stats.rx_errors += val;
+	u64_stats_add(&port->stats.rx_errors, val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_CRC_ERR_CNT(port->id));
-	port->stats.rx_crc_error += val;
+	u64_stats_add(&port->stats.rx_crc_error, val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_OVERFLOW_DROP_CNT(port->id));
-	port->stats.rx_over_errors += val;
+	u64_stats_add(&port->stats.rx_over_errors, val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_FRAG_CNT(port->id));
-	port->stats.rx_fragment += val;
+	u64_stats_add(&port->stats.rx_fragment, val);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_JABBER_CNT(port->id));
-	port->stats.rx_jabber += val;
+	u64_stats_add(&port->stats.rx_jabber, val);
 
 	i = 0;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_RUNT_CNT(port->id));
-	port->stats.rx_len[i] += val;
+	val64 = val;
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT_H(port->id));
-	port->stats.rx_len[i] += ((u64)val << 32);
+	val64 += (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT_L(port->id));
-	port->stats.rx_len[i++] += val;
+	val64 += val;
+	u64_stats_add(&port->stats.rx_len[i++], val64);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L64_CNT_H(port->id));
-	port->stats.rx_len[i] += ((u64)val << 32);
+	val64 = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L64_CNT_L(port->id));
-	port->stats.rx_len[i++] += val;
+	val64 += val;
+	u64_stats_add(&port->stats.rx_len[i++], val64);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L127_CNT_H(port->id));
-	port->stats.rx_len[i] += ((u64)val << 32);
+	val64 = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L127_CNT_L(port->id));
-	port->stats.rx_len[i++] += val;
+	val64 += val;
+	u64_stats_add(&port->stats.rx_len[i++], val64);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L255_CNT_H(port->id));
-	port->stats.rx_len[i] += ((u64)val << 32);
+	val64 = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L255_CNT_L(port->id));
-	port->stats.rx_len[i++] += val;
+	val64 += val;
+	u64_stats_add(&port->stats.rx_len[i++], val64);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L511_CNT_H(port->id));
-	port->stats.rx_len[i] += ((u64)val << 32);
+	val64 = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L511_CNT_L(port->id));
-	port->stats.rx_len[i++] += val;
+	val64 += val;
+	u64_stats_add(&port->stats.rx_len[i++], val64);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L1023_CNT_H(port->id));
-	port->stats.rx_len[i] += ((u64)val << 32);
+	val64 = (u64)val << 32;
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_L1023_CNT_L(port->id));
-	port->stats.rx_len[i++] += val;
+	val64 += val;
+	u64_stats_add(&port->stats.rx_len[i++], val64);
 
 	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_LONG_CNT(port->id));
-	port->stats.rx_len[i++] += val;
+	u64_stats_add(&port->stats.rx_len[i++], val);
 
 	/* reset mib counters */
 	airoha_fe_set(eth, REG_FE_GDM_MIB_CLEAR(port->id),
@@ -1795,16 +1812,16 @@ static void airoha_dev_get_stats64(struct net_device *dev,
 	airoha_update_hw_stats(port);
 	do {
 		start = u64_stats_fetch_begin(&port->stats.syncp);
-		storage->rx_packets = port->stats.rx_ok_pkts;
-		storage->tx_packets = port->stats.tx_ok_pkts;
-		storage->rx_bytes = port->stats.rx_ok_bytes;
-		storage->tx_bytes = port->stats.tx_ok_bytes;
-		storage->multicast = port->stats.rx_multicast;
-		storage->rx_errors = port->stats.rx_errors;
-		storage->rx_dropped = port->stats.rx_drops;
-		storage->tx_dropped = port->stats.tx_drops;
-		storage->rx_crc_errors = port->stats.rx_crc_error;
-		storage->rx_over_errors = port->stats.rx_over_errors;
+		storage->rx_packets = u64_stats_read(&port->stats.rx_ok_pkts);
+		storage->tx_packets = u64_stats_read(&port->stats.tx_ok_pkts);
+		storage->rx_bytes = u64_stats_read(&port->stats.rx_ok_bytes);
+		storage->tx_bytes = u64_stats_read(&port->stats.tx_ok_bytes);
+		storage->multicast = u64_stats_read(&port->stats.rx_multicast);
+		storage->rx_errors = u64_stats_read(&port->stats.rx_errors);
+		storage->rx_dropped = u64_stats_read(&port->stats.rx_drops);
+		storage->tx_dropped = u64_stats_read(&port->stats.tx_drops);
+		storage->rx_crc_errors = u64_stats_read(&port->stats.rx_crc_error);
+		storage->rx_over_errors = u64_stats_read(&port->stats.rx_over_errors);
 	} while (u64_stats_fetch_retry(&port->stats.syncp, start));
 }
 
@@ -2057,13 +2074,13 @@ static void airoha_ethtool_get_mac_stats(struct net_device *dev,
 	airoha_update_hw_stats(port);
 	do {
 		start = u64_stats_fetch_begin(&port->stats.syncp);
-		stats->FramesTransmittedOK = port->stats.tx_ok_pkts;
-		stats->OctetsTransmittedOK = port->stats.tx_ok_bytes;
-		stats->MulticastFramesXmittedOK = port->stats.tx_multicast;
-		stats->BroadcastFramesXmittedOK = port->stats.tx_broadcast;
-		stats->FramesReceivedOK = port->stats.rx_ok_pkts;
-		stats->OctetsReceivedOK = port->stats.rx_ok_bytes;
-		stats->BroadcastFramesReceivedOK = port->stats.rx_broadcast;
+		stats->FramesTransmittedOK = u64_stats_read(&port->stats.tx_ok_pkts);
+		stats->OctetsTransmittedOK = u64_stats_read(&port->stats.tx_ok_bytes);
+		stats->MulticastFramesXmittedOK = u64_stats_read(&port->stats.tx_multicast);
+		stats->BroadcastFramesXmittedOK = u64_stats_read(&port->stats.tx_broadcast);
+		stats->FramesReceivedOK = u64_stats_read(&port->stats.rx_ok_pkts);
+		stats->OctetsReceivedOK = u64_stats_read(&port->stats.rx_ok_bytes);
+		stats->BroadcastFramesReceivedOK = u64_stats_read(&port->stats.rx_broadcast);
 	} while (u64_stats_fetch_retry(&port->stats.syncp, start));
 }
 
@@ -2098,12 +2115,12 @@ airoha_ethtool_get_rmon_stats(struct net_device *dev,
 		int i;
 
 		start = u64_stats_fetch_begin(&port->stats.syncp);
-		stats->fragments = hw_stats->rx_fragment;
-		stats->jabbers = hw_stats->rx_jabber;
+		stats->fragments = u64_stats_read(&hw_stats->rx_fragment);
+		stats->jabbers = u64_stats_read(&hw_stats->rx_jabber);
 		for (i = 0; i < ARRAY_SIZE(airoha_ethtool_rmon_ranges) - 1;
 		     i++) {
-			stats->hist[i] = hw_stats->rx_len[i];
-			stats->hist_tx[i] = hw_stats->tx_len[i];
+			stats->hist[i] = u64_stats_read(&hw_stats->rx_len[i]);
+			stats->hist_tx[i] = u64_stats_read(&hw_stats->tx_len[i]);
 		}
 	} while (u64_stats_fetch_retry(&port->stats.syncp, start));
 }
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 20e602d61e61..b2e9bd849f8b 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -215,24 +215,24 @@ struct airoha_hw_stats {
 	struct u64_stats_sync syncp;
 
 	/* get_stats64 */
-	u64 rx_ok_pkts;
-	u64 tx_ok_pkts;
-	u64 rx_ok_bytes;
-	u64 tx_ok_bytes;
-	u64 rx_multicast;
-	u64 rx_errors;
-	u64 rx_drops;
-	u64 tx_drops;
-	u64 rx_crc_error;
-	u64 rx_over_errors;
+	u64_stats_t rx_ok_pkts;
+	u64_stats_t tx_ok_pkts;
+	u64_stats_t rx_ok_bytes;
+	u64_stats_t tx_ok_bytes;
+	u64_stats_t rx_multicast;
+	u64_stats_t rx_errors;
+	u64_stats_t rx_drops;
+	u64_stats_t tx_drops;
+	u64_stats_t rx_crc_error;
+	u64_stats_t rx_over_errors;
 	/* ethtool stats */
-	u64 tx_broadcast;
-	u64 tx_multicast;
-	u64 tx_len[7];
-	u64 rx_broadcast;
-	u64 rx_fragment;
-	u64 rx_jabber;
-	u64 rx_len[7];
+	u64_stats_t tx_broadcast;
+	u64_stats_t tx_multicast;
+	u64_stats_t tx_len[7];
+	u64_stats_t rx_broadcast;
+	u64_stats_t rx_fragment;
+	u64_stats_t rx_jabber;
+	u64_stats_t rx_len[7];
 };
 
 enum {
-- 
2.51.0


