Return-Path: <netdev+bounces-291097-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IM07BKmaEWpSoAYAu9opvQ
	(envelope-from <netdev+bounces-291097-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 14:16:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ABD5BED8D
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 14:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7B0F30276AE
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 12:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9419C33E35B;
	Sat, 23 May 2026 12:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqFuQuuy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D601E3876DE
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 12:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779538546; cv=none; b=i7r95aE9jT8bPlrsCqTuFSRZzGrczJFKAdaEFC+cgU0LlGk/VNfJVRRlGdtReca73D7MCIDFCI9dR4GCZ5V7Ok5ckqHLOTz0jAA/mWI+/1PvTkC5wRWaY+Nus/hg3orA3ORgUf/2d3xLSJkW55h056nfKk3mrw+6ZcLQ7ErAf/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779538546; c=relaxed/simple;
	bh=8l4tyC4y5/Ak0oYZbkuWnFYCquWoCgn8Deh8zHDa4TM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0VdrLEiNPHvs9YTbk30sv5i003/7xDONZarCaTqFOpWHYGf8EcwNdmG77XRX6K2293nrPi8RdNdIVi3Y8hTNy7yLTxwMKWLpIfodOxQedgXylnyUyFy9OSLxX/LCHHWJ1LuxFa/T3BDMOByx6wHxmAigrdHxDr8So0hqxy/Yk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqFuQuuy; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba1e9d3687so54630425ad.3
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 05:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779538544; x=1780143344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptBan/oDFwIr7VXZlN8TdNfSiKDV9ouul3U9bPm2km8=;
        b=NqFuQuuyrFcUeHomeDO7Hu7KciKYD0AtdvZe5Fq1EApZxDErm6dOjtTJpdQaALo+qn
         INy/62H2MX0W9Vz2YkYQVAmNjYSZBT3JtCEDGnT1UWoKuwzPoNl3LPjDJ0LQQXwpN0z0
         m8CXesgDEjaCGeQIjPoOHNedW/w92IAsMHVfjcoSVdwRPb6te8P16e3FxKqtz/crX8zR
         w2mxQXLCCSmpgwqM8Ub3vUNz0rgYSqzmPj7i+kR79vn6LmNjqIm+RT5MeKW5Uj7oFDeU
         F0MRQSZebF4NqTm2IVL8F7Ii6a9VVE71qneF+H2nq1e+S/JbmuCkWsqZRhy3+TS0RTUq
         Wvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779538544; x=1780143344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ptBan/oDFwIr7VXZlN8TdNfSiKDV9ouul3U9bPm2km8=;
        b=tVe1QBo1SwNx9DJrs0IQ3wz6vqgbhEPONoLZ58B9n2hxfzOxGswfy2q+Y/GBT4Z3UV
         tUl9Kk+pt2XOQCa0S0rYVJLv8/KVCcppol+lpTR/rIap5Rdh4R+QgMDRBRQ4MMXe97Kp
         hvHdixbEG72J+A6Ktzvc+VuvflicBcPyboeuQg4qNSgV4U1F3yG/Y90vAkL7etvBp3WJ
         mCu15emoAx3h3nXZ0goAEaCPsSobAuhqMX+GedUE5Gq9i8DmWJ/ZsDn+3Aiwrm/rzhPf
         +VWTLfvU/M9JbrcYm6D0R7z5KqKTrwuTpBo1o7oqm7T1gE59y6n+cW8yN6Zl/Me5JD+1
         /AjQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Q+5IQ80/qHzrSwqfHrUBenxjvt/EoG+q+Fv2QKBQZ/i5tshLzzKhJsrJz4BzE7XSQUqTx3mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxCI7UKZ5+hS7Pg/j2NgYpZvuVa87IMNubPGveNE8ZO2mnfDZF
	LLHL5vl+ugJViyaya/jM33G3cZN2kF3sFVGWyn7zXNojm+Rc/dRFqea2
X-Gm-Gg: Acq92OFl9f7hchqgLoHxDYVR2OztG9UsGc/diePaVu3oySDlGo/ER3JTdecBAhkTlQg
	vz2um1yxBTre2I3Xtzk31vk2h1gTxwul1EpaSQdWYqOKo/ZhobNPuKMKRULqx8kXueDmp6xVvu7
	JPwe4edLSk4gpw9JEkn0yuiNN5g9vdJhPAz3qL4rc836xygDk80rgG9cQxflWxVA8KubN9jU4FX
	p6c0U12Dy9giHHedIP//2HELtpuAmPEfMGmnkRNu6bQpK80yOIWdjANRonUC22m0dM92IXu/jKN
	6czhCIwlm/51/XqgAhK6OzR8XIAUzdY8gJGjYOtedew8bupQRXNRDarAxIJpTg/ODsN7yimh54T
	NURxhFXzZFxfX2qW+Ge2oEEKHmd/FfAyaosQJt38SJntKrG25Gq+8+YztozBKjBMpHeoC+B5FPs
	cHCsmWEiEfFEHclelNj3g5/cXQ80W5uxCmee0=
X-Received: by 2002:a17:903:3d10:b0:2bc:6784:5260 with SMTP id d9443c01a7336-2beb06eb0e4mr90794065ad.37.1779538543856;
        Sat, 23 May 2026 05:15:43 -0700 (PDT)
Received: from mincom1 ([125.149.177.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56ce4easm41746305ad.30.2026.05.23.05.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 05:15:43 -0700 (PDT)
From: Jihong Min <hurryman2212@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Antoine Tenart <atenart@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>
Cc: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	Jihong Min <hurryman2212@gmail.com>
Subject: [PATCH 1/3] xfrm: extend ESP offload infrastructure for packet engines
Date: Sat, 23 May 2026 21:15:20 +0900
Message-ID: <20260523121522.3023992-2-hurryman2212@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523121522.3023992-1-hurryman2212@gmail.com>
References: <20260523121522.3023992-1-hurryman2212@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-291097-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,gondor.apana.org.au,davemloft.net,lunn.ch,google.com,redhat.com,secunet.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hurryman2212@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 47ABD5BED8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some ESP offload engines operate on whole ESP packets rather than the
generic software trailer layout. They can generate outbound ESP padding,
next-header and ICV bytes in hardware, and inbound decapsulation can
return an already-trimmed packet with the recovered next-header value.

Add a netdev offload callback for drivers to opt into hardware-generated
ESP TX trailers, carry the reserved ESP TX tail length in xfrm_offload,
and let ESP input skip software trailer removal when hardware has already
done it.

This keeps the default ESP offload behavior unchanged for existing devices
while providing the infrastructure needed by packet-mode ESP engines.

Assisted-by: Codex:gpt-5.5
Signed-off-by: Jihong Min <hurryman2212@gmail.com>
---
 include/linux/netdevice.h |  3 +++
 include/net/xfrm.h        |  8 +++++++-
 net/ipv4/esp4.c           |  6 +++++-
 net/ipv4/esp4_offload.c   | 29 ++++++++++++++++++++++++++++-
 net/ipv6/esp6.c           |  6 +++++-
 net/ipv6/esp6_offload.c   | 29 ++++++++++++++++++++++++++++-
 6 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0e1e581efc5a..b6ff04c3df78 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1043,6 +1043,9 @@ struct xfrmdev_ops {
 				      struct xfrm_state *x);
 	bool	(*xdo_dev_offload_ok) (struct sk_buff *skb,
 				       struct xfrm_state *x);
+	/* Return true when the device generates the ESP trailer/ICV itself. */
+	bool	(*xdo_dev_esp_tx_hw_trailer)(struct sk_buff *skb,
+					     struct xfrm_state *x);
 	void	(*xdo_dev_state_advance_esn) (struct xfrm_state *x);
 	void	(*xdo_dev_state_update_stats) (struct xfrm_state *x);
 	int	(*xdo_dev_policy_add) (struct xfrm_policy *x, struct netlink_ext_ack *extack);
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 10d3edde6b2f..160069901e0a 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1141,7 +1141,7 @@ struct xfrm_offload {
 #define	CRYPTO_FALLBACK		8
 #define	XFRM_GSO_SEGMENT	16
 #define	XFRM_GRO		32
-/* 64 is free */
+#define	XFRM_ESP_NO_TRAILER	64
 #define	XFRM_DEV_RESUME		128
 #define	XFRM_XMIT		256
 
@@ -1158,6 +1158,12 @@ struct xfrm_offload {
 	/* Used to keep whole l2 header for transport mode GRO */
 	__u16			orig_mac_len;
 
+	/*
+	 * ESP packet engines can reserve tailroom in the generic ESP path and
+	 * generate padding, next-header and ICV bytes during device TX.
+	 */
+	__u16			esp_tx_tailen;
+
 	__u8			proto;
 	__u8			inner_ipproto;
 };
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 6a5febbdbee4..f21c8f2e60f7 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -720,7 +720,11 @@ int esp_input_done2(struct sk_buff *skb, int err)
 	if (unlikely(err))
 		goto out;
 
-	err = esp_remove_trailer(skb);
+	/* Hardware ESP decapsulation can already remove pad/trailer/ICV. */
+	if (xo && (xo->flags & XFRM_ESP_NO_TRAILER))
+		err = xo->proto;
+	else
+		err = esp_remove_trailer(skb);
 	if (unlikely(err < 0))
 		goto out;
 
diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index abd77162f5e7..f00fff98b69f 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -270,8 +270,10 @@ static int esp_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features_
 	struct xfrm_offload *xo;
 	struct ip_esp_hdr *esph;
 	struct crypto_aead *aead;
+	struct sk_buff *trailer;
 	struct esp_info esp;
 	bool hw_offload = true;
+	bool hw_trailer = false;
 	__u32 seq;
 	int encap_type = 0;
 
@@ -281,6 +283,7 @@ static int esp_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features_
 
 	if (!xo)
 		return -EINVAL;
+	xo->esp_tx_tailen = 0;
 
 	if ((!(features & NETIF_F_HW_ESP) &&
 	     !(skb->dev->gso_partial_features & NETIF_F_HW_ESP)) ||
@@ -303,13 +306,37 @@ static int esp_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features_
 	esp.clen = ALIGN(skb->len + 2 + esp.tfclen, blksize);
 	esp.plen = esp.clen - skb->len - esp.tfclen;
 	esp.tailen = esp.tfclen + esp.plen + alen;
+	if (esp.tailen > U16_MAX)
+		return -EINVAL;
 
 	esp.esph = ip_esp_hdr(skb);
 
 	if (x->encap)
 		encap_type = x->encap->encap_type;
 
-	if (!hw_offload || !skb_is_gso(skb) || (hw_offload && encap_type == UDP_ENCAP_ESPINUDP)) {
+	if (hw_offload && !skb_is_gso(skb) && !encap_type && x->xso.dev &&
+	    x->xso.dev->xfrmdev_ops &&
+	    x->xso.dev->xfrmdev_ops->xdo_dev_esp_tx_hw_trailer)
+		hw_trailer =
+			x->xso.dev->xfrmdev_ops->xdo_dev_esp_tx_hw_trailer(skb, x);
+
+	if (hw_trailer) {
+		int esph_offset;
+
+		/*
+		 * The device packet engine will write ESP padding, next-header
+		 * and ICV bytes. Keep skb->len unchanged here, but make sure the
+		 * later DMA writer owns enough linear tailroom.
+		 */
+		esph_offset = (unsigned char *)esp.esph - skb_transport_header(skb);
+		esp.nfrags = skb_cow_data(skb, esp.tailen, &trailer);
+		if (esp.nfrags < 0)
+			return esp.nfrags;
+		esp.esph = (struct ip_esp_hdr *)(skb_transport_header(skb) +
+						 esph_offset);
+		xo->esp_tx_tailen = esp.tailen;
+	} else if (!hw_offload || !skb_is_gso(skb) ||
+		   (hw_offload && encap_type == UDP_ENCAP_ESPINUDP)) {
 		esp.nfrags = esp_output_head(x, skb, &esp);
 		if (esp.nfrags < 0)
 			return esp.nfrags;
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 9c06c5a1419d..730588f8eaba 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -751,7 +751,11 @@ int esp6_input_done2(struct sk_buff *skb, int err)
 	if (unlikely(err))
 		goto out;
 
-	err = esp_remove_trailer(skb);
+	/* Hardware ESP decapsulation can already remove pad/trailer/ICV. */
+	if (xo && (xo->flags & XFRM_ESP_NO_TRAILER))
+		err = xo->proto;
+	else
+		err = esp_remove_trailer(skb);
 	if (unlikely(err < 0))
 		goto out;
 
diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
index 22895521a57d..d124493da40b 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -308,8 +308,10 @@ static int esp6_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features
 	int blksize;
 	struct xfrm_offload *xo;
 	struct crypto_aead *aead;
+	struct sk_buff *trailer;
 	struct esp_info esp;
 	bool hw_offload = true;
+	bool hw_trailer = false;
 	__u32 seq;
 
 	esp.inplace = true;
@@ -318,6 +320,7 @@ static int esp6_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features
 
 	if (!xo)
 		return -EINVAL;
+	xo->esp_tx_tailen = 0;
 
 	if (!(features & NETIF_F_HW_ESP) || x->xso.dev != skb->dev) {
 		xo->flags |= CRYPTO_FALLBACK;
@@ -338,8 +341,32 @@ static int esp6_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features
 	esp.clen = ALIGN(skb->len + 2 + esp.tfclen, blksize);
 	esp.plen = esp.clen - skb->len - esp.tfclen;
 	esp.tailen = esp.tfclen + esp.plen + alen;
+	if (esp.tailen > U16_MAX)
+		return -EINVAL;
 
-	if (!hw_offload || !skb_is_gso(skb)) {
+	if (hw_offload && !skb_is_gso(skb) && !x->encap && x->xso.dev &&
+	    x->xso.dev->xfrmdev_ops &&
+	    x->xso.dev->xfrmdev_ops->xdo_dev_esp_tx_hw_trailer)
+		hw_trailer =
+			x->xso.dev->xfrmdev_ops->xdo_dev_esp_tx_hw_trailer(skb, x);
+
+	if (hw_trailer) {
+		int esph_offset;
+
+		/*
+		 * The device packet engine will write ESP padding, next-header
+		 * and ICV bytes. Keep skb->len unchanged here, but make sure the
+		 * later DMA writer owns enough linear tailroom.
+		 */
+		esp.esph = ip_esp_hdr(skb);
+		esph_offset = (unsigned char *)esp.esph - skb_transport_header(skb);
+		esp.nfrags = skb_cow_data(skb, esp.tailen, &trailer);
+		if (esp.nfrags < 0)
+			return esp.nfrags;
+		esp.esph = (struct ip_esp_hdr *)(skb_transport_header(skb) +
+						 esph_offset);
+		xo->esp_tx_tailen = esp.tailen;
+	} else if (!hw_offload || !skb_is_gso(skb)) {
 		esp.nfrags = esp6_output_head(x, skb, &esp);
 		if (esp.nfrags < 0)
 			return esp.nfrags;
-- 
2.53.0


