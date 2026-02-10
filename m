Return-Path: <netdev+bounces-258131-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aC2OHZ1pi2k1UQAAu9opvQ
	(envelope-from <netdev+bounces-258131-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 18:23:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BAA11DDED
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 18:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9635A30715D5
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 17:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E247638A709;
	Tue, 10 Feb 2026 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZafEBYqM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1CD38A70C;
	Tue, 10 Feb 2026 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770744132; cv=none; b=alcTy+Rlm+0qXFeuFbKgK/ZdrujsorRh3pgKRGsnMR7Zksz9Hmm/5NtykiwAr3yIRKrUKI8Q08wwb4yqjlJX124EHJgum09l3ynXasIpCT/Th8DLYB8MFTsuB+Qq6uG8SS7Kz7+UbInwOr3wa6hhB6XPWrFy2STn/q2CHE3QMRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770744132; c=relaxed/simple;
	bh=FxdfMw+g8bV/+mi1gEn6PcMcwLF8o84NpFvSpfO8nks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e9OZKlnM0qQy8XFx/q/zWRmU0uF9L5e8XPrU2BiGny2e8jGkouU01lg9gcBZIMqsx/CtsIJomUdTrUrbJc6xBIRMybPsHhuSoA7x97CP56FFvm6/+z/rzJg6A9KkhPP4D/T8XVjpWgmN1v6H8c8m/9L3nRkcVvdKjAml/Q5DYXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZafEBYqM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E99CC116C6;
	Tue, 10 Feb 2026 17:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770744132;
	bh=FxdfMw+g8bV/+mi1gEn6PcMcwLF8o84NpFvSpfO8nks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZafEBYqMK7jxSLHdT+g8Y37K7F9OMM1MbxPpT5vurL3t3cao8yYn02RV2i3l0x1Ml
	 lnXfdupBb8mkX+fqIn5Z2g5jxQlKzxa8NM5oZhZOFs/u9F8vH1wAQROymeqvGLxbFf
	 PLfEfLAXEk6L4hqPPtT8mSbNT+pDIEwYGCez/pAHr33EBTTiejr6+sM8KWd15G8b5v
	 TwtL6PpbFYMIufDBDPEKr2fpK9zKnc77KfrqTflFPJ7EYc+1PSTZoSKQheUkxbetrj
	 v1qpRlzcQCK3yp7xX1tiHrTXGvGd0MBz59fFoklxb2+mYeTseD4U+bVOTfQTulu4wJ
	 lrYVVjukt0mNA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 10 Feb 2026 18:21:49 +0100
Subject: [PATCH bpf-next 3/5] net: ice: Add xmo_rx_checksum callback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-bpf-xdp-meta-rxcksum-v1-3-e5d55caa0541@kernel.org>
References: <20260210-bpf-xdp-meta-rxcksum-v1-0-e5d55caa0541@kernel.org>
In-Reply-To: <20260210-bpf-xdp-meta-rxcksum-v1-0-e5d55caa0541@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 linux-kselftest@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258131-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 16BAA11DDED
X-Rspamd-Action: no action

Implement xmo_rx_checksum callback in ice driver to report RX checksum
result to the eBPF program bounded to the NIC.
Introduce ice_get_rx_csum utility routine in order to rx cksum codebase
available in ice_rx_csum().

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 114 +++++++++++++++++---------
 1 file changed, 74 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index 956da38d63b0032db238325dcff818bbd99478e9..508ef4b07a3b3a9816be760c08c81c3f569456a3 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -81,69 +81,45 @@ ice_rx_hash_to_skb(const struct ice_rx_ring *rx_ring,
 		libeth_rx_pt_set_hash(skb, hash, decoded);
 }
 
-/**
- * ice_rx_gcs - Set generic checksum in skb
- * @skb: skb currently being received and modified
- * @rx_desc: receive descriptor
- */
-static void ice_rx_gcs(struct sk_buff *skb,
-		       const union ice_32b_rx_flex_desc *rx_desc)
-{
-	const struct ice_32b_rx_flex_desc_nic *desc;
-	u16 csum;
-
-	desc = (struct ice_32b_rx_flex_desc_nic *)rx_desc;
-	skb->ip_summed = CHECKSUM_COMPLETE;
-	csum = (__force u16)desc->raw_csum;
-	skb->csum = csum_unfold((__force __sum16)swab16(csum));
-}
-
-/**
- * ice_rx_csum - Indicate in skb if checksum is good
- * @ring: the ring we care about
- * @skb: skb currently being received and modified
- * @rx_desc: the receive descriptor
- * @ptype: the packet type decoded by hardware
- *
- * skb->protocol must be set before this function is called
- */
 static void
-ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
-	    union ice_32b_rx_flex_desc *rx_desc, u16 ptype)
+ice_get_rx_csum(const union ice_32b_rx_flex_desc *rx_desc, u16 ptype,
+		struct ice_rx_ring *ring, enum xdp_checksum *ip_summed,
+		u32 *cksum_meta)
 {
-	struct libeth_rx_pt decoded;
+	struct libeth_rx_pt decoded = libie_rx_pt_parse(ptype);
 	u16 rx_status0, rx_status1;
 	bool ipv4, ipv6;
 
-	/* Start with CHECKSUM_NONE and by default csum_level = 0 */
-	skb->ip_summed = CHECKSUM_NONE;
-
-	decoded = libie_rx_pt_parse(ptype);
 	if (!libeth_rx_pt_has_checksum(ring->netdev, decoded))
-		return;
+		goto checksum_none;
 
 	rx_status0 = le16_to_cpu(rx_desc->wb.status_error0);
 	rx_status1 = le16_to_cpu(rx_desc->wb.status_error1);
-
 	if ((ring->flags & ICE_RX_FLAGS_RING_GCS) &&
 	    rx_desc->wb.rxdid == ICE_RXDID_FLEX_NIC &&
 	    (decoded.inner_prot == LIBETH_RX_PT_INNER_TCP ||
 	     decoded.inner_prot == LIBETH_RX_PT_INNER_UDP ||
 	     decoded.inner_prot == LIBETH_RX_PT_INNER_ICMP)) {
-		ice_rx_gcs(skb, rx_desc);
+		const struct ice_32b_rx_flex_desc_nic *desc;
+		u16 csum;
+
+		desc = (struct ice_32b_rx_flex_desc_nic *)rx_desc;
+		*ip_summed = XDP_CHECKSUM_COMPLETE;
+		csum = (__force u16)desc->raw_csum;
+		*cksum_meta = csum_unfold((__force __sum16)swab16(csum));
 		return;
 	}
 
 	/* check if HW has decoded the packet and checksum */
 	if (!(rx_status0 & BIT(ICE_RX_FLEX_DESC_STATUS0_L3L4P_S)))
-		return;
+		goto checksum_none;
 
 	ipv4 = libeth_rx_pt_get_ip_ver(decoded) == LIBETH_RX_PT_OUTER_IPV4;
 	ipv6 = libeth_rx_pt_get_ip_ver(decoded) == LIBETH_RX_PT_OUTER_IPV6;
 
 	if (ipv4 && (rx_status0 & (BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_EIPE_S)))) {
 		ring->vsi->back->hw_rx_eipe_error++;
-		return;
+		goto checksum_none;
 	}
 
 	if (ipv4 && (rx_status0 & (BIT(ICE_RX_FLEX_DESC_STATUS0_XSUM_IPE_S))))
@@ -168,13 +144,46 @@ ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
 	 * we are indicating we validated the inner checksum.
 	 */
 	if (decoded.tunnel_type >= LIBETH_RX_PT_TUNNEL_IP_GRENAT)
-		skb->csum_level = 1;
+		*cksum_meta = 1;
 
-	skb->ip_summed = CHECKSUM_UNNECESSARY;
+	*ip_summed = XDP_CHECKSUM_UNNECESSARY;
 	return;
 
 checksum_fail:
 	ring->vsi->back->hw_csum_rx_error++;
+checksum_none:
+	*ip_summed = XDP_CHECKSUM_NONE;
+	*cksum_meta = 0;
+}
+
+/**
+ * ice_rx_csum - Indicate in skb if checksum is good
+ * @ring: the ring we care about
+ * @skb: skb currently being received and modified
+ * @rx_desc: the receive descriptor
+ * @ptype: the packet type decoded by hardware
+ *
+ * skb->protocol must be set before this function is called
+ */
+static void
+ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
+	    union ice_32b_rx_flex_desc *rx_desc, u16 ptype)
+{
+	enum xdp_checksum ip_summed;
+	u32 cksum_meta;
+
+	ice_get_rx_csum(rx_desc, ptype, ring, &ip_summed, &cksum_meta);
+	switch (ip_summed) {
+	case XDP_CHECKSUM_UNNECESSARY:
+		skb->csum_level = cksum_meta;
+		break;
+	case XDP_CHECKSUM_COMPLETE:
+		skb->csum = cksum_meta;
+		break;
+	default:
+		break;
+	}
+	skb->ip_summed = ip_summed;
 }
 
 /**
@@ -569,6 +578,30 @@ static int ice_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
 	return 0;
 }
 
+/**
+ * ice_xdp_rx_checksum - RX checksum XDP hint handler
+ * @ctx: XDP buff pointer
+ * @ip_summed: RX checksum result destination address
+ * @cksum_meta: XDP RX checksum metadata destination address
+ *
+ * Copy RX checksum result (if available) and its metadata to the
+ * destination address.
+ */
+static int ice_xdp_rx_checksum(const struct xdp_md *ctx,
+			       enum xdp_checksum *ip_summed,
+			       u32 *cksum_meta)
+{
+	const struct libeth_xdp_buff *xdp_ext = (void *)ctx;
+	const union ice_32b_rx_flex_desc *rx_desc = xdp_ext->desc;
+	struct ice_rx_ring *ring;
+
+	ring = libeth_xdp_buff_to_rq(xdp_ext, typeof(*ring), xdp_rxq);
+	ice_get_rx_csum(rx_desc, ice_get_ptype(rx_desc), ring, ip_summed,
+			cksum_meta);
+
+	return 0;
+}
+
 /**
  * ice_xdp_rx_vlan_tag - VLAN tag XDP hint handler
  * @ctx: XDP buff pointer
@@ -601,4 +634,5 @@ const struct xdp_metadata_ops ice_xdp_md_ops = {
 	.xmo_rx_timestamp		= ice_xdp_rx_hw_ts,
 	.xmo_rx_hash			= ice_xdp_rx_hash,
 	.xmo_rx_vlan_tag		= ice_xdp_rx_vlan_tag,
+	.xmo_rx_checksum		= ice_xdp_rx_checksum,
 };

-- 
2.53.0


