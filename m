Return-Path: <netdev+bounces-262999-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMh0B2JLpmm1NgAAu9opvQ
	(envelope-from <netdev+bounces-262999-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 03:45:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B9E1E8289
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 03:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD33430364F9
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 02:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE04374E51;
	Tue,  3 Mar 2026 02:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="D8qAL9Ua"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C029375F93
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 02:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772505948; cv=none; b=P/PH3ve3phvX7CRmbedLXsbYJHJ1i5Hkn/KFRzI7Nx6CdGLXr+IpFgmXaWVv6KWpOXXU2/HXiD7Cg67mHUkY59uGc2DK1fzUzuptiVbTiZ3c9bRQmFxa65fWFizTO5Fl1xu4vpaXDduWpoE7t+RLMhTTSaHmrFP+1GGUY6VFazw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772505948; c=relaxed/simple;
	bh=N3ZN/577J6T3HfUZPetTc7LoqcDuy41jvH2ej5cM8aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tcl1i2GJB/2YawWRFRL80xOA4WF+HnIkChfrWo26Q/Oj+2lUy7GebQ4ac9Yq4fz8Wa5k4XM2qrpDg83fCnpAa/z+XCZIbjkWqcMxElhu2ElPavtktylMSvKsunUBmDFaE0F14Auv4UEKHTWoUTZT9H7+CXiOnBkeoD36/Z1d8tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=D8qAL9Ua; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-662f91bba0fso5028585eaf.0
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 18:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772505946; x=1773110746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gWuEUywlHiJAdc+KzkRLmXtzIjty9yNKhswxVvxm90=;
        b=D8qAL9UaSLcyWJzTeHdhCPq167JmApTGtFoAayPDqGtEyT9nvNQqZVVS7mQKhOa6JQ
         +CW6XXELqbYgsK1fP+Va+RvOx/hBE4ZGThqNOfs73BnK+5zpmpdA5/VVxZA3fOed9RsG
         LUhoJLFoadP6aeJOJ9tWAmeR8N8HB7LqOu46L1MExSFBOw74CZzQu8uUso3UiGCv21/0
         Z7nTfundpYVO9Z24j6rYzyLPtg7/3uFRIwIejqB00kk2D6RBad97ay4vPdg/LDoheXvY
         eDdVHxd3whBsLzIUCULq7zCaF6F9f4IRFUT5wC9A4Pm6XZbwmHDOBtX0UN5bak521mXO
         dx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772505946; x=1773110746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2gWuEUywlHiJAdc+KzkRLmXtzIjty9yNKhswxVvxm90=;
        b=ZrP2B4m1J838KMk0+5W7/e0aXqmVoRgPx0WJTlJ1oKfLjjHIGsCaJSnBGN/31drAlR
         AtmZi/jGm09NBoJilVpsUfUc67LBFzrvy5KYBC3gQ4oJfNcX5vg558uHs2qehl75BHUs
         q0xja1TngZk0pTRXyhI4LLeDw436c5VXcG+kHZmdSZVk28r/P7+qGncfQhuNdK4lkVlb
         r0ds2Og3jcF8EC/GnXxwPYzq/5khWMURyGmcmO6eFN6wUo9TeSwvHkOheV+oPKAmBdlY
         njKWn+l9PWMEb09F3BPfpkJWIkLRvUD5eO7n9UGTQkMQLBrgKxyO55uLhuHNX/kFP/dQ
         dxVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOjYv2WblthCB4a+7fm9N25xLKlXyVzfH5xSDKcSjvAwGSAp8W9wgYlCGC+qmw2KUDgCYf83g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUdVVn2qVAfcSIyDES2Ucue5LmRAYSvbODUajme1tcRz56RzHS
	UljjYmWqVX4/sbf5+FnsEPQVLuxWTMX9ttPOYca8NHNZQUC2WI6OK4tgiLWTNAkvvmY=
X-Gm-Gg: ATEYQzxc4475t6WLNlGXGQCBPKtJOyGh4J/QiZqMZi5XZtETyyeAjBIQQpgAtw3OCo1
	C6cTActvj20se0mNUAZyly3eNiI/dGd0EUfCaQ+A9i0Tsw6X9KfI3hlbmkH/As1QVuJMuuZ9Rmu
	x4OIRpB9Nsy0tY1O+Iprm1UdZ5xY/Mvaa8bDVHIAiG2rc7n6vA/ZJGrPT5dIQWKf0I//GE4TqJN
	MuX5HZAPHSp0bl7aD/uCJFPrzpMd5efx1ycs3SPXIfOQKrePOGULhTLkFd4SFJerZJ7R3imBGru
	aJ1JrWEswgu4j7cZ+EUoItawZ9IJqC+4D0v+zzx9tHVGYT0NBuSNmbDDxJQXdWHa2ctAhe6xtM6
	/dIJwo4nUdsThaBWQD/hsaXkCIaJRO6U1fpI+F+Vlid8vVgRe/ilvf/PQ7IRsw3EnLPMVxcYizA
	e8DOdXA2c=
X-Received: by 2002:a05:6820:2d4a:b0:67a:1d18:6f64 with SMTP id 006d021491bc7-67a1dac2a7emr452503eaf.34.1772505946199;
        Mon, 02 Mar 2026 18:45:46 -0800 (PST)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::a2:70])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2d84dacsm10205642eaf.9.2026.03.02.18.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 18:45:45 -0800 (PST)
From: Chris J Arges <carges@cloudflare.com>
To: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	joe@dama.to,
	kuba@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: kernel-team@cloudflare.com,
	Chris J Arges <carges@cloudflare.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v2 1/4] bnxt_en: use bnxt_xdp_buff for xdp context
Date: Mon,  2 Mar 2026 20:43:49 -0600
Message-ID: <20260303024510.644962-2-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303024510.644962-1-carges@cloudflare.com>
References: <20260213192449.1294830-1-carges@cloudflare.com>
 <20260303024510.644962-1-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B5B9E1E8289
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262999-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[broadcom.com,dama.to,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carges@cloudflare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

This adds bnxt_xdp_buff which embeds the xdp_buff struct and stores
pointers to hardware RX completion descriptors (rx_cmp and rx_cmp_ext)
along with the completion type.

Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 25 +++++++++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  7 ++++++
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c982aac714d1..ab73aad40593 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2118,7 +2118,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	bool xdp_active = false;
 	dma_addr_t dma_addr;
 	struct sk_buff *skb;
-	struct xdp_buff xdp;
+	struct bnxt_xdp_buff bnxt_xdp;
 	u32 flags, misc;
 	u32 cmpl_ts;
 	void *data;
@@ -2231,9 +2231,13 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	dma_addr = rx_buf->mapping;
 
 	if (bnxt_xdp_attached(bp, rxr)) {
-		bnxt_xdp_buff_init(bp, rxr, cons, data_ptr, len, &xdp);
+		bnxt_xdp.rxcmp = rxcmp;
+		bnxt_xdp.rxcmp1 = rxcmp1;
+		bnxt_xdp.cmp_type = cmp_type;
+
+		bnxt_xdp_buff_init(bp, rxr, cons, data_ptr, len, &bnxt_xdp.xdp);
 		if (agg_bufs) {
-			u32 frag_len = bnxt_rx_agg_netmems_xdp(bp, cpr, &xdp,
+			u32 frag_len = bnxt_rx_agg_netmems_xdp(bp, cpr, &bnxt_xdp.xdp,
 							       cp_cons,
 							       agg_bufs,
 							       false);
@@ -2245,12 +2249,12 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	}
 
 	if (xdp_active) {
-		if (bnxt_rx_xdp(bp, rxr, cons, &xdp, data, &data_ptr, &len, event)) {
+		if (bnxt_rx_xdp(bp, rxr, cons, &bnxt_xdp.xdp, data, &data_ptr, &len, event)) {
 			rc = 1;
 			goto next_rx;
 		}
-		if (xdp_buff_has_frags(&xdp)) {
-			sinfo = xdp_get_shared_info_from_buff(&xdp);
+		if (xdp_buff_has_frags(&bnxt_xdp.xdp)) {
+			sinfo = xdp_get_shared_info_from_buff(&bnxt_xdp.xdp);
 			agg_bufs = sinfo->nr_frags;
 		} else {
 			agg_bufs = 0;
@@ -2261,7 +2265,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 		if (!xdp_active)
 			skb = bnxt_copy_skb(bnapi, data_ptr, len, dma_addr);
 		else
-			skb = bnxt_copy_xdp(bnapi, &xdp, len, dma_addr);
+			skb = bnxt_copy_xdp(bnapi, &bnxt_xdp.xdp, len, dma_addr);
 		bnxt_reuse_rx_data(rxr, cons, data);
 		if (!skb) {
 			if (agg_bufs) {
@@ -2269,7 +2273,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 					bnxt_reuse_rx_agg_bufs(cpr, cp_cons, 0,
 							       agg_bufs, false);
 				else
-					bnxt_xdp_buff_frags_free(rxr, &xdp);
+					bnxt_xdp_buff_frags_free(rxr, &bnxt_xdp.xdp);
 			}
 			goto oom_next_rx;
 		}
@@ -2293,10 +2297,11 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 			if (!skb)
 				goto oom_next_rx;
 		} else {
-			skb = bnxt_xdp_build_skb(bp, skb, agg_bufs, rxr, &xdp);
+			skb = bnxt_xdp_build_skb(bp, skb, agg_bufs,
+						 rxr, &bnxt_xdp.xdp);
 			if (!skb) {
 				/* we should be able to free the old skb here */
-				bnxt_xdp_buff_frags_free(rxr, &xdp);
+				bnxt_xdp_buff_frags_free(rxr, &bnxt_xdp.xdp);
 				goto oom_next_rx;
 			}
 		}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
index 8933a0dec09a..8c66698bde11 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
@@ -12,6 +12,13 @@
 
 DECLARE_STATIC_KEY_FALSE(bnxt_xdp_locking_key);
 
+struct bnxt_xdp_buff {
+	struct xdp_buff xdp;
+	struct rx_cmp *rxcmp;
+	struct rx_cmp_ext *rxcmp1;
+	u8 cmp_type;
+};
+
 struct bnxt_sw_tx_bd *bnxt_xmit_bd(struct bnxt *bp,
 				   struct bnxt_tx_ring_info *txr,
 				   dma_addr_t mapping, u32 len,
-- 
2.43.0


