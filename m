Return-Path: <netdev+bounces-264950-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OnULANeq2mmcQEAu9opvQ
	(envelope-from <netdev+bounces-264950-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 00:06:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 614912287FF
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 00:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59EAE3049470
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 23:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EDB361DC3;
	Fri,  6 Mar 2026 23:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="cCR815hz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64666362142
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 23:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772838393; cv=none; b=bGUg8Hwpcm210hOzLfjhhuObePrCKi+8JyR75szBs2Qd0/Cy/vber2YnGu14qgHy8BcxIQcx9weDu6CwLjAF6Ch1r7ftEkOv3aVMhmmtlexuKvr54g0UePJJur0dlV4xkyeqyGYJfUMq6rlKWaeeegnnMBQM+NzbD/eBovwtskk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772838393; c=relaxed/simple;
	bh=N3ZN/577J6T3HfUZPetTc7LoqcDuy41jvH2ej5cM8aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BA0aOM4Xkuw+VnA69W7bUPe+GynlMvuVCDvQioG4uh5QSkKvvjUfYgYQFmrIW1i3y3SNPMh92DSYQ1/BKCxM0QYWD8NimM6qF2H1yZOfn9VVr+L3p8esM+O49E+l47w4dQAP3SLk/fk/MV52CFdSjtUpntoD+AuSNC8zpD8Cjx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=cCR815hz; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4648448e387so6332453b6e.1
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 15:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772838390; x=1773443190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gWuEUywlHiJAdc+KzkRLmXtzIjty9yNKhswxVvxm90=;
        b=cCR815hziuUMFUfWK4Stk/YI597xtSI9WzBjcFlJWuidKTHBHH+v/Ni7bj7DOyY/lN
         F5Qu30o5HyEMWS0Y4fOn8S0Oa8Aep2j/BowQFORSywS1wAcbFuunVsCIXwI9eIe9JFcH
         SfP+p+OZPFY8vrY3GGXTZw//4tNYfNdLB1eavGOj9tZqbkBdo9iyLk7Y64ZqWPTeRLrQ
         RTJv/8S0mr2vk8vbndvcZNo3Zcfx7uA6GxXYPedyJ+Rd7nwdbsjjbwt/rC83sibiR63A
         QlDlIfQQiw5XxLQw9SEZIdIq1ZzSGrsJ/k0rQGrLx4Ksi0SnePpSUjTLb6rpp5fW/CKe
         wpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772838390; x=1773443190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2gWuEUywlHiJAdc+KzkRLmXtzIjty9yNKhswxVvxm90=;
        b=rb01XpT3jfz0AwbWV4wZlmA3zwOtPlp29L2TFZV1uT64kJH3wPRcGg8CA08mbnYuly
         KiKgO9wFnFQCQkZnYhIMGtjt5gmYEjEVNzSAAVtX0IdktZYrrx8Sk+CCHtAoGF+0265U
         Wb0azeYO6GhRcwaGHUOKJ3JQy18Jp5pWxA4so55tb3Xc00ZMwCkCbM1kuyLZbx5B+qHQ
         KfzbVRvcDbBVyzXV+JBLyNtH5o26t9wf5KhVHoHmdxHfSi70s7Zlg/ftwHMCLnxmFK7j
         tQkscLGNucWMczK93sT2SY1M7v9hZCPSKVtJDwPOiFrRpEwWf5zTeTsYbJAuJc7z2t+L
         Ov/g==
X-Forwarded-Encrypted: i=1; AJvYcCUJtyev0y5+/ctXu5GBdHaWPZGvI9fgPeeLxAnvrMtopu1EmjwiKTSjUSrKms6NUn9OAWNBlJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyALiRgt+x0gIKvOAA+7WkSlXDf/9n2MQoE/L8DGCKFDE539NSj
	GTRbCSGhIFKiKpXhVnnrCNq6/SQCEcnBfwH/wJzeFHqtcWGGVVx9oforJBJYizeFH7Q=
X-Gm-Gg: ATEYQzzz/JtNqUXsKxtvIbaZ5OS3+K3nD2fEAtplyTu0hqHE05uYh70cWPNpwFbWSGc
	efoNCBH7X/1qi3dy+LWUe6PG6WjME0b80f/IbGu9bz3VmLcDxHGjHs0B683Cu0h2qlGJVhCl921
	VGOsjFn0i5BSnx0qbTR3QeB9z2QFH5GM+fm7OPf8Ypj9XdzbXKbtoJTPDdzqhXZwS2vckEls7G3
	+b/O2TziFG8z9zqUJ3PT7pafbfTuwbwuwb1lkp8jx9V5QR37fBOzfuTM+KR1mvW8qtFwv1n4d63
	8w3hEjnXXr2I4QV5uVgkYSkHEpm/iiMjl2soLojuoU8XrUL6DFUJV1job1p8k0Pe8rGnIRZxhEk
	KkXWwiOibYNoA/YTN3ysNdz4ElnFybPv1sKfMJYvH4+CzEdpFY10QbD4kCUF2tlOQ9k4tdmlVD8
	+E26x7VccS
X-Received: by 2002:a05:6808:1905:b0:45e:f91c:7b with SMTP id 5614622812f47-466dcb93248mr2047693b6e.54.1772838390287;
        Fri, 06 Mar 2026 15:06:30 -0800 (PST)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::3ce:23])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-466dfac17b3sm1532769b6e.14.2026.03.06.15.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 15:06:29 -0800 (PST)
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
Subject: [PATCH net-next v3 1/5] bnxt_en: use bnxt_xdp_buff for xdp context
Date: Fri,  6 Mar 2026 17:00:16 -0600
Message-ID: <20260306230600.1628196-2-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306230600.1628196-1-carges@cloudflare.com>
References: <20260306230600.1628196-1-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 614912287FF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264950-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid]
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


