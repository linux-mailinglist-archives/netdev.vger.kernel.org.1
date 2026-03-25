Return-Path: <netdev+bounces-271724-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEGADL1BxGlvxwQAu9opvQ
	(envelope-from <netdev+bounces-271724-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:12:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EC332BABC
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F06173050D7A
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 20:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC65366553;
	Wed, 25 Mar 2026 20:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CJsXrEPi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B71368961
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 20:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774469513; cv=none; b=LDFoVyYoHDF87mLMY8FY4Nk8pfsRN2vg4X+1AohJ+6ydz3TaeVmx4+hxpRAv1sp0Az93IMbzZVYkSa+ZI7Vnz/Q8VkxW4Us8zxF5gUsbY3POV7yfzGl3TVqr55dkFgYDVZqG48vdyfkb1ZayzUPoACGg4uaaNQXoLnaZ4bUxMPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774469513; c=relaxed/simple;
	bh=tE1y7Xf3gKLbeuPRxTJlE3b5uyBorC0b4mjSJ11WKYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USt7SQm0yHIS9k5ckNd9VdyjJrrNHWqfb7v14aGIXb+7TsFW87DuTyp1w/YhTZ8ZXYVyChstYeIy+Gled81GuigjYRg/M2qhNJD2XgjyzLuaMsK13ImHnt2F6JzdPl9EICNwgZ4N/i2U07AdqAyLcOCWdg1ppCt6Wsog6B8SB18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=CJsXrEPi; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4042fe53946so104947fac.3
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 13:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1774469511; x=1775074311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSfd7mFw0xsUikzIqT2q80GcNCSLpTJTf+iIVU2PLVI=;
        b=CJsXrEPiPLY4Hn+IgJE2SC/ybvWO1Wj7pTct1A4IQUVRyviGrMmys78dsotZSlcN4u
         y0e17u97Uc9l9pU05xihcYiaKtjoFud0J0Jp1VfNy/JXaG3VYEWvApQeKDtEIpgrj/1n
         EEhxJ+YqkkiTSQUSUmHR+BuS0W2rAy/YGoXv3mgEHVlSEpd7OHX4xcJ3zDS9TKRQEGgB
         pdSejnOfBiWbcsSjvbuOY3jXiqae5tlx1TFLhmjxi9TrwKkCGmxPP3moikT+j/dNeZSn
         oxuS4b3fUiIIeLeOGaE0O58NptOvAALymVPgITRBZMhmRZIZaLT7Ba3U8bzdLaEvUQzJ
         SIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774469511; x=1775074311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oSfd7mFw0xsUikzIqT2q80GcNCSLpTJTf+iIVU2PLVI=;
        b=n7zFf7SxH8UI8WzVWMhPzJOT6HkDICX3M37yQa0m8eNOAKYPv21VJBUgPwjX9au9R3
         gXKMYQ6+ugOjK/HE8NphOa+6S0ScZMeRLSC8SKD2+lLsjt1bmePpLsjGhy4YKtBs3l/J
         vYRCr2lyKR2YkhPsX7Mh7f6LnaxXxN8Ck/khRBbvUAUejrqb005teh9j/faBzTDF+FNd
         4jEattA1sWecJoX8HBnsV+uCDV5vO86XiyUQ3bwPPpCzD/ZMuAaVUQEl06ZD2Cp5twCB
         cmcgGedtShuI0rx0kylFXfapTD536UjOdE+EWdeX84NpmJZs97XzViZqr1MdJLPCpFdF
         lw9A==
X-Gm-Message-State: AOJu0Yz/x+0MBupTUWLFL/+VJQnFdsgKoYdZkoYftvbwihBDSjyCixzU
	Su3IRrpL5X3zL5g0RX48USkZ/OEa52uNA5Cvwm0yT9a71rw/Pxcj56RxLFVveV5kCD3nc9KpIoO
	WacTYUM3ndA==
X-Gm-Gg: ATEYQzxercffcEFBS9OHhz3A0IFEF+QayawOwWxzcyoZ1VUvYXXGtVtIj771ijtJcap
	pWhTQQcIgS4YvE6toeIvgZXdfpaKtVUelwOvEpQ5UVj+D2UEfab1Aait4RVY1mcRFGfCzaLX9y8
	1TEJa/p1JrWYOEcfIz0VQDBhq+dnt/ZIXfPf1w1I6SUKjdADuOh3uBxzn3PixaZnzOpo1oEdYmG
	orQp+r2IvJ4c6iOGSZpXkC4ilvzWc6j+wnrTBKjY9PZTQQyi+fR+drvoWNvno5cq2mb4ds9lTZh
	/F55y7IflDucBZzFbVkHDmDUOMx6zPlaYomo8kv7nDWioTfVVZXZkW3tW7tr3eshCfud1DDvVCV
	isWBHw83FC50371l7snAn98+ldWrN95VdlvyLnK1kLz/0ui749VpXfETgEnzAOfkKhLmRFF2Bki
	HO051Mzq5VCGsDW7KL9AtSxcE=
X-Received: by 2002:a05:6820:3092:b0:67d:e140:345f with SMTP id 006d021491bc7-67dff51b7c0mr2429038eaf.34.1774469510989;
        Wed, 25 Mar 2026 13:11:50 -0700 (PDT)
Received: from 20HS2G4.aus01.local ([2a09:bac6:bf21:2632::3ce:1a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67e0ab274c7sm549764eaf.13.2026.03.25.13.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 13:11:50 -0700 (PDT)
From: Chris J Arges <carges@cloudflare.com>
To: netdev@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	davem@davemloft.net,
	joe@dama.to,
	gospo@broadcom.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: andrew+netdev@lunn.ch,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-team@cloudflare.com,
	Chris J Arges <carges@cloudflare.com>
Subject: [PATCH net-next v5 1/6] bnxt_en: use bnxt_xdp_buff for xdp context
Date: Wed, 25 Mar 2026 15:09:47 -0500
Message-ID: <20260325201139.2501937-2-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325201139.2501937-1-carges@cloudflare.com>
References: <20260325201139.2501937-1-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,cloudflare.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271724-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carges@cloudflare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid]
X-Rspamd-Queue-Id: D0EC332BABC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This adds bnxt_xdp_buff which embeds the xdp_buff struct and stores
pointers to hardware RX completion descriptors (rx_cmp and rx_cmp_ext)
along with the completion type.

Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
v4: moved bnxt_xdp declaration to follow RCT style
v5: moved bnxt_xdp again to follow RCT, try better at 80-col wrapping
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 29 ++++++++++++-------
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  7 +++++
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 84eb53b4172b..e70fd04fe5f3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2112,13 +2112,13 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	u32 tmp_raw_cons = *raw_cons;
 	u16 cons, prod, cp_cons = RING_CMP(tmp_raw_cons);
 	struct skb_shared_info *sinfo;
+	struct bnxt_xdp_buff bnxt_xdp;
 	struct bnxt_sw_rx_bd *rx_buf;
 	unsigned int len;
 	u8 *data_ptr, agg_bufs, cmp_type;
 	bool xdp_active = false;
 	dma_addr_t dma_addr;
 	struct sk_buff *skb;
-	struct xdp_buff xdp;
 	u32 flags, misc;
 	u32 cmpl_ts;
 	void *data;
@@ -2231,9 +2231,14 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
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
+			u32 frag_len = bnxt_rx_agg_netmems_xdp(bp, cpr,
+							       &bnxt_xdp.xdp,
 							       cp_cons,
 							       agg_bufs,
 							       false);
@@ -2245,12 +2250,13 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	}
 
 	if (xdp_active) {
-		if (bnxt_rx_xdp(bp, rxr, cons, &xdp, data, &data_ptr, &len, event)) {
+		if (bnxt_rx_xdp(bp, rxr, cons, &bnxt_xdp.xdp, data, &data_ptr,
+				&len, event)) {
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
@@ -2261,7 +2267,8 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 		if (!xdp_active)
 			skb = bnxt_copy_skb(bnapi, data_ptr, len, dma_addr);
 		else
-			skb = bnxt_copy_xdp(bnapi, &xdp, len, dma_addr);
+			skb = bnxt_copy_xdp(bnapi, &bnxt_xdp.xdp, len,
+					    dma_addr);
 		bnxt_reuse_rx_data(rxr, cons, data);
 		if (!skb) {
 			if (agg_bufs) {
@@ -2269,7 +2276,8 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 					bnxt_reuse_rx_agg_bufs(cpr, cp_cons, 0,
 							       agg_bufs, false);
 				else
-					bnxt_xdp_buff_frags_free(rxr, &xdp);
+					bnxt_xdp_buff_frags_free(rxr,
+								 &bnxt_xdp.xdp);
 			}
 			goto oom_next_rx;
 		}
@@ -2293,10 +2301,11 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
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


