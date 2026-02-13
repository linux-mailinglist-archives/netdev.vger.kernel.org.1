Return-Path: <netdev+bounces-258666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGX9EAh7j2mWRAEAu9opvQ
	(envelope-from <netdev+bounces-258666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 20:27:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A43E0139326
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 20:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85B3230E8473
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 19:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50CD324B38;
	Fri, 13 Feb 2026 19:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Vosu4kxF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC93127E049
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 19:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771010719; cv=none; b=PgMy6uZGi1JJDRqs99RrIMYwlQ7Rpo54Yes6WTvhpdIbbiKPvp1krDyh7rlFR0mInn5KnaEWWeD3LDvxZNJrx1FkLm+3EtYSfew73AEpKwomWlG32JmTSfSn+FmiQq5YQzrVUJKH4H0YHpxb0s2lfZ7iBVKucxSrcPm16RsZA2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771010719; c=relaxed/simple;
	bh=1AWsqbF6uQ5IO3/lEjud9uj1H4t9rPI6+yXkNMP+snY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTK1Nv/hiFImjNC/WRrLbywUCRn35bfm/IDCMv2Sq7yRtChHUCE2mzOw3EZfgwhEjWmTOZGmcY1S0AGF+SxCx1+vtuJX69pBvWwAn0zCgOfIUOHbFXtGgV5wPWAPMvldsG7/DUNFm2fnjUu2XJwmYKoN00zPpz1VQf6Bc3aDHFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Vosu4kxF; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d18d0e6d71so853911a34.1
        for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 11:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1771010714; x=1771615514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDx6aNjolaLjlY/tFPaDQVZ9LraL1BXHhtWRZ+My8mI=;
        b=Vosu4kxF1wB/ty5K265dJlS7H9OC7tKdaHCL+9ThK2jQVIJKmQwfMDsfAJ9oUmkeVT
         jmL5LJ0KuJhLeeZ0/ETWr1MUQWEhFTNKZRRz7hDe3Lovk76Gz7OfprhVdGB59mixHCRo
         kaH/0PnlPIWAgu6LApNCo8ZEKDU7Q8psCFKGYpgmqq+uV4VZ70sP9NDTENjcPwuJg6IB
         V2nOC49Xs1w2l4PoQsugPk0sVW4SicxkZEemryD/PWLghuLsjOSRLkgF2Q9C55oPLLRo
         fwAu0U9XRmhMFdcNRc1V7qJpSFEC6QcYLq6Q3QJinvqh5BUOOXXRfEUoX4Ojc2zh6Jzl
         6H3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771010714; x=1771615514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SDx6aNjolaLjlY/tFPaDQVZ9LraL1BXHhtWRZ+My8mI=;
        b=C5JM/5kELjG/kqvjdEufQVJ1y3NKwviJT0hVAId9MmMbwELRdaUwxUY0zjwLPQJ4rc
         W1xo0GxNMxVTpANOHVwA6raw9UHUmwYo5uWv8OWACM4+iUkAvDVt1lWcF3WVS54kQKPf
         U5aMTn2AuzEtljARVtxACw2UoNK5wlLe51Q83a8882cq74x4cxwUvG/mcW1zIiK/986/
         oMTLcHWlJPJCCMVuwTcCDkPHQqn2iHSAJcUYRq3P7qCV9TZ831kXqkVyst3LG378Ja+L
         N2VfYb+64WRLEcuHS/60In45rSsWPaJo1llleXGz+oVPMjZVZEDg93Cy+DZoPjIkT4k7
         dSdg==
X-Forwarded-Encrypted: i=1; AJvYcCVeLOTXn0lBpizXdzF5KWQ1VFXuoyPHSF6AMG0m6+F/1z2P69vvf11ujG0oDUCBcOwCDQv+bD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDLJZ0JfZrqQ85Zk8O+yVJ6397hUR2szmrLcWofUnWilTd3rxW
	iiKS0HsdKbrmb0RAXCQIzfxr/xTmfeCkAk4eNnLjwDkZKlmQXzhs6C4WzpjgbkhKtnE=
X-Gm-Gg: AZuq6aKpKS8RqsgTYLymJ53/cWqb9shyERy5UGCuZDut0rZaWlRwU4AMhExGgN0848v
	CmL1OMu4Gq7u1ccwgIWVYldWmowNZOq3vx5nVSWKHqBYk2xf+w9TbF+KnHBQATUxauDCXh9nId/
	ms6+KInmTfZOZHdHV8hmws242y/7N272LMD00OFTorU2XE8WrKBI6oArEfcmaUzDJkSGvp4WrHK
	kzhYW0MKPBi2Yk60486v9lXLDptWx9O17xNeBTngxbiX+SMQCoTYs2UYoM2ZLQYY/wewA9Pr/sn
	Tw3rRA0UOarXkArai/HHH/4EWDqWtD2SxE90daS+PJpVLx86lRBNhDOcvT/zgb8GPXJytLQfxtL
	jGtC6y+BD96oEF4Uns7F+Wavkz2bbtiGm4WZ6o1g/yqtIaZ28GR1wM7/lN5IvunL5MshNlzx5De
	mG2a2GTKrX
X-Received: by 2002:a05:6830:6686:b0:7c7:655c:7353 with SMTP id 46e09a7af769-7d4d0adabe0mr284901a34.12.1771010713650;
        Fri, 13 Feb 2026 11:25:13 -0800 (PST)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::499:50])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4a76f96b8sm6591407a34.21.2026.02.13.11.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 11:25:13 -0800 (PST)
From: Chris J Arges <carges@cloudflare.com>
To: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	hawk@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: kernel-team@cloudflare.com,
	jbrandeburg@cloudflare.com,
	Chris J Arges <carges@cloudflare.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 1/2] bnxt_en: use bnxt_xdp_buff for xdp context
Date: Fri, 13 Feb 2026 13:24:27 -0600
Message-ID: <20260213192449.1294830-2-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260213192449.1294830-1-carges@cloudflare.com>
References: <20260213192449.1294830-1-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258666-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[broadcom.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carges@cloudflare.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A43E0139326
X-Rspamd-Action: no action

This adds bnxt_xdp_buff which embeds the xdp_buff struct and stores
pointers to hardware RX completion descriptors (rx_cmp and rx_cmp_ext)
along with the completion type.

Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 24 +++++++++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  7 ++++++
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8419d1eb4035..4c5e50bad783 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2115,7 +2115,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	bool xdp_active = false;
 	dma_addr_t dma_addr;
 	struct sk_buff *skb;
-	struct xdp_buff xdp;
+	struct bnxt_xdp_buff bnxt_xdp;
 	u32 flags, misc;
 	u32 cmpl_ts;
 	void *data;
@@ -2228,9 +2228,13 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
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
@@ -2242,12 +2246,12 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
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
@@ -2258,7 +2262,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 		if (!xdp_active)
 			skb = bnxt_copy_skb(bnapi, data_ptr, len, dma_addr);
 		else
-			skb = bnxt_copy_xdp(bnapi, &xdp, len, dma_addr);
+			skb = bnxt_copy_xdp(bnapi, &bnxt_xdp.xdp, len, dma_addr);
 		bnxt_reuse_rx_data(rxr, cons, data);
 		if (!skb) {
 			if (agg_bufs) {
@@ -2266,7 +2270,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 					bnxt_reuse_rx_agg_bufs(cpr, cp_cons, 0,
 							       agg_bufs, false);
 				else
-					bnxt_xdp_buff_frags_free(rxr, &xdp);
+					bnxt_xdp_buff_frags_free(rxr, &bnxt_xdp.xdp);
 			}
 			goto oom_next_rx;
 		}
@@ -2291,10 +2295,10 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 				goto oom_next_rx;
 		} else {
 			skb = bnxt_xdp_build_skb(bp, skb, agg_bufs,
-						 rxr->page_pool, &xdp);
+						 rxr->page_pool, &bnxt_xdp.xdp);
 			if (!skb) {
 				/* we should be able to free the old skb here */
-				bnxt_xdp_buff_frags_free(rxr, &xdp);
+				bnxt_xdp_buff_frags_free(rxr, &bnxt_xdp.xdp);
 				goto oom_next_rx;
 			}
 		}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
index 220285e190fc..5f60b848fcc4 100644
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


