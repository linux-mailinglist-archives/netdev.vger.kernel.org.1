Return-Path: <netdev+bounces-264947-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANeVOLpZq2mmcQEAu9opvQ
	(envelope-from <netdev+bounces-264947-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 23:48:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A552228628
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 23:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AF0A303100A
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 22:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CCA35F16A;
	Fri,  6 Mar 2026 22:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uX2ngq1z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BD03502BA
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 22:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772837303; cv=none; b=L9d6jm9n1vhJjTRlnXla/G3zRgMMiCFaVLrOMJit8M04NCXXWqFAXDCq83Qxew+0p05Y5DhN2594/mFpYtMXrpFDRe8f9fb8OAWViEi7O+C1sQY5mIyryN7ugBOU56jk2Y9zUlk9FMXqbrXCrn6Xh6WRkUScfSr65sgWtWWICCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772837303; c=relaxed/simple;
	bh=7G6+qnfUJNedkiph200Y9njZnfcgLo1U6unr0/UMiUo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VS/1JNo/mwEwjqZYrmaph/mx1iBgddJcrWC4R26gaI/KVOCEzpOjAJAsXiXLDrMQW3dJuPnCHVV/oLgQi5X0586iJVDacQhH28BMv+YtqpZ6nK1qLsVwxCKStyEu7bx3yEOb8PQUCTnLUOfKspU0jOIQcAx9pilOYUqniNuogmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uX2ngq1z; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae6961bff0so167412645ad.2
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 14:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772837302; x=1773442102; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ET1z2PhZ/vXx0rxDcMUa4k7I7QKL/rFCVqGRGN/V+18=;
        b=uX2ngq1zWbADKdFPik4f9Pz5UbExb6vZsITRdYL6E/uGUMfKTrJtBjMBdIZ1J7Wr5F
         B2UI6Aj8usUoEwE8LlZA00SZCw+VciWzCsT+s5wW0v+jUDDDUcRZtck9cXXs0VXBnVL4
         52YXN+eYY1TJl0XyohydBRZ51HtdIppvKXgKNHATV3LviZkeZXXD2u1uc3Wog9JbgjW5
         kboD7UZILBI0IYbCSVx/XG5X85M9cN6HOzFIlVWDPDry2Xj1501cPlIGHR1JLeS2f8n8
         dyhb/yzoRyZI4vzgfvMqKC86impeaV7qNdVckwcAFHGaPUBdD8g9eaOnDqWsvRPDOwx6
         TcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772837302; x=1773442102;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ET1z2PhZ/vXx0rxDcMUa4k7I7QKL/rFCVqGRGN/V+18=;
        b=V3Xgpx/gRzO+CHJV+8wm3qc8n8zFkHJSpkygLM/NclyZmOC+LzmClxDVmmF+HaZMj8
         BnsEiysERjUgtD03B435zVTwSks4JvVNg6CORDYC+e4qPZXnuFIFElmFU/ybRiKNJpfC
         JeNn1FaOUiPaObZek6K8+FjXW2y2k3Lj5bqAApriEBnspYm9SdIX2Uk5FTaJ3S64KibN
         JVIQi4WuScDwQM64FZxDN+yi2apP8CPe8+yL+g0X3VfORZH/NA3iq0Cfp92KcEPRu7Zf
         rjNaiz9xnL6lVYe/sdWavA306LVYKLv9c9i/zsMggL8OVsu25SazqpJZ/IstCUSr4vZz
         i4nw==
X-Gm-Message-State: AOJu0Ywy+xWD8dCxQiUv0JuyOuMiUaGoNH6V/R93zss8uYuXsSiPLwkU
	OVQjTM2SrHMSZld1NX7G7H2b2OIQjLY/SJLDCxYhi9FJPd66GtL7PRXsW6OPxphGoJVleEGbhYV
	wWlk+945PuCrMI21rE49Q+yMU+N23WMUdPExsocwHcDBedeRNpEGPRM/BUFdsKCTY0PQkDSsQBy
	tgIBMbRDUHyL2eiJTFuxinXYRWuE8ThNkHDm8jHvK0fPAp5T+2CWrZUyt+8qC+UcI=
X-Received: from plai10.prod.google.com ([2002:a17:902:c94a:b0:2ae:5031:c200])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2441:b0:2ae:4fdb:d596 with SMTP id d9443c01a7336-2ae82367db1mr39069735ad.11.1772837301327;
 Fri, 06 Mar 2026 14:48:21 -0800 (PST)
Date: Fri,  6 Mar 2026 22:48:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306224816.3391551-1-hramamurthy@google.com>
Subject: [PATCH net-next] gve: add support for UDP GSO for DQO format
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, maolson@google.com, pkaligineedi@google.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 8A552228628
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-264947-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.973];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Ankit Garg <nktgrg@google.com>

Enable support for UDP GSO when using DQO format. Advertise the feature
flag during device initialization and enable offload by default.

Signed-off-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_adminq.c |  8 +++++---
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 33 ++++++++++++++++++++++++---------
 2 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 6ce8345e..f27b9501 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1127,10 +1127,12 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 
 	gve_set_default_rss_sizes(priv);
 
-	/* DQO supports HW-GRO. */
+	/* DQO supports HW-GRO and UDP_GSO */
 	if (gve_is_dqo(priv)) {
-		priv->dev->hw_features |= NETIF_F_GRO_HW;
-		priv->dev->features |= NETIF_F_GRO_HW;
+		u64 additional_features = NETIF_F_GRO_HW | NETIF_F_GSO_UDP_L4;
+
+		priv->dev->hw_features |= additional_features;
+		priv->dev->features |= additional_features;
 	}
 
 	priv->max_registered_pages =
diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index 28e85730..81d27a12 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -565,9 +565,11 @@ static void gve_tx_fill_pkt_desc_dqo(struct gve_tx_ring *tx, u32 *desc_idx,
  */
 static int gve_prep_tso(struct sk_buff *skb)
 {
+	struct skb_shared_info *shinfo = skb_shinfo(skb);
+	u32 paylen, l4_start;
 	struct tcphdr *tcp;
+	struct udphdr *udp;
 	int header_len;
-	u32 paylen;
 	int err;
 
 	/* Note: HW requires MSS (gso_size) to be <= 9728 and the total length
@@ -578,21 +580,34 @@ static int gve_prep_tso(struct sk_buff *skb)
 	 * - Kernel will not produce a TSO larger than 64k
 	 */
 
-	if (unlikely(skb_shinfo(skb)->gso_size < GVE_TX_MIN_TSO_MSS_DQO))
+	if (unlikely(shinfo->gso_size < GVE_TX_MIN_TSO_MSS_DQO))
 		return -1;
 
-	if (!(skb_shinfo(skb)->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)))
-		return -EINVAL;
-
 	/* Needed because we will modify header. */
 	err = skb_cow_head(skb, 0);
 	if (err < 0)
 		return err;
 
-	tcp = tcp_hdr(skb);
-	paylen = skb->len - skb_transport_offset(skb);
-	csum_replace_by_diff(&tcp->check, (__force __wsum)htonl(paylen));
-	header_len = skb_tcp_all_headers(skb);
+	l4_start = skb_transport_offset(skb);
+	paylen = skb->len - l4_start;
+
+	switch (shinfo->gso_type) {
+	case SKB_GSO_TCPV4:
+	case SKB_GSO_TCPV6:
+		tcp = tcp_hdr(skb);
+		csum_replace_by_diff(&tcp->check,
+				     (__force __wsum)htonl(paylen));
+		header_len = skb_tcp_all_headers(skb);
+		break;
+	case SKB_GSO_UDP_L4:
+		udp = udp_hdr(skb);
+		csum_replace_by_diff(&udp->check,
+				     (__force __wsum)htonl(paylen));
+		header_len = sizeof(struct udphdr) + l4_start;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	if (unlikely(header_len > GVE_TX_MAX_HDR_SIZE_DQO))
 		return -EINVAL;
-- 
2.53.0.473.g4a7958ca14-goog


