Return-Path: <netdev+bounces-305983-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HNHoFxW1TmoUSwIAu9opvQ
	(envelope-from <netdev+bounces-305983-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 22:37:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE4C72A426
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 22:37:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=verdict.gg header.s=sig1 header.b=QBmNOqK7;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305983-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305983-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA7BE304DFC6
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 20:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BF131CA4E;
	Wed,  8 Jul 2026 20:35:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from outbound.qs.icloud.com (qs-2004j-snip4-3.eps.apple.com [57.103.84.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41CC35E1B6
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 20:35:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783542913; cv=none; b=h/r7f96gWf92azk9CeS+ZyjOl4jJFR+Z01aJcZO3avvZf8GEb1Kcy57KbDkHODX/kz9KB/R8Z8KIPqJmHHnYXcb8XNkPWuOSfZPvcrofaVXcQHhs54RaPILbd8yZVEFGr41+52hInJZtLNNyBVC95EHOPef1uSvdBOr5tnxOIRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783542913; c=relaxed/simple;
	bh=tEC8DLNMKqipeVDrlO05Bwnu5qgfYWwskesSLfrM6tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=boFq86bnDEj3OkY4nrOdzks3To6gEMRKsI3gSSMvr7qAWRrR/TKbkCP1PWidN3OBgNUxJQAR4OlC1TBfq+gkAK36NReqbVCguAz+P8iTztM2lkqs7FPshcSDviwzjryconxU9NseYF69WVnTydt7tcIsSGJOP/kq/IdbZBU5FoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=QBmNOqK7; arc=none smtp.client-ip=57.103.84.96
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPS id 08BA130000C3;
	Wed, 08 Jul 2026 20:34:59 +0000 (UTC)
X-ICL-RepId: 019f4370-e4bf-78e7-b622-e53a71ef1a4d
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhICkMGWQJeCEABQwVdEhVdRVcIWwJAEVc4RQhFD1sTTVZUChcNVk1PHUEJXghGXl4fEx9UVgFDGRBWAVhWXQVNGlwYWQ8cAUpWWg5bBEcUFxtcABcbRgIEIwJfAEUCXglWATAXD1ZNTx1BCV4IRl5eHxMAXg8PTAtIAVsHXAJIC0gAWQZbHEQMSQFcGl8fFFwUWh9WBXIGXApXBFQfHBdeRhMZThtXTVoNQBlYBm0UVhVSBFk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1; t=1783542906; x=1786134906; bh=0R7rSSkqTacn4eRr91WictHmBFApYWPcIKUA6H01yVc=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=QBmNOqK74cCqJJ+DneB+4N35Z6fFqHMCJJEZFvNDdtTbwB3m6pNz9O/f9dRYnMI6D1NIPO97N5L9XT736RZ9U6+IaetbCsP2frluMAEIIw7FN2H+kNb49XA2scdP/e7iTUBEifj9oqe+63yk2pv9GgY3BffbTOZ25oZQhITONgoBdRzRc/0fDpJRc0g4iTYqCdDFrgvgVM5633uA2Y4//dZhp7jLTg2k10BHTlD1BlxxcbcSLDnoH8vAqwCeSewUTFChlllrKTEfyJvoLRc/u5+ZQIwr4lLPWuiCBZIITU1a0hxPsbNkTgCavxe/fgP7wIQ44pcFHRd3h2+kT1w86A==
mail-alias-created-date: 1621344842221
Received: from DelNac.mail.msk (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPSA id 305FF300111D;
	Wed, 08 Jul 2026 20:34:54 +0000 (UTC)
From: Vladimir Vdovin <deliran@verdict.gg>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kselftest@vger.kernel.org,
	Vladimir Vdovin <deliran@verdict.gg>
Subject: [PATCH bpf-next v4 3/6] net: ice: Add xmo_rx_checksum callback
Date: Wed,  8 Jul 2026 23:34:07 +0300
Message-ID: <20260708203410.45121-4-deliran@verdict.gg>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260708203410.45121-1-deliran@verdict.gg>
References: <20260708203410.45121-1-deliran@verdict.gg>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Xc3ckwcLp0BEyAc5tgHAQkM2JZVoURXZ
X-Proofpoint-GUID: Xc3ckwcLp0BEyAc5tgHAQkM2JZVoURXZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDIwMiBTYWx0ZWRfX+OzZU1/BCEx3
 ZtDTz+/OjgDLr7jGXvgEcQmnk71DE2qspxAHQkFh83nL/OeOYzmi0fd7Y2rUNWioBpem1lKQYrp
 kGZkhLYUF8K3AsSIDC7Uyrx6prUpVKk+VA9NX29qh7P50Vhbplm4yepa+pbEM6j3vVtmsGn+Q8k
 OVsiTDOe4RfkjkSncYGnCewvCG3u2UcUQfUdBFn1EGnK2Ptvg53fiiu41Nu8D0N8kl1Uc0eUOaA
 NbiqSFP75OxWeKj+qYpohiK7dyXmVVsPAQVGCWveWQbiVqwdtwjlFc8FPaX2SkJ7uBqH+9vA/eM
 UuU4pqVRNE/l68eWdeO
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[verdict.gg:s=sig1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305983-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:andrew+netdev@lunn.ch,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:aleksander.lobakin@intel.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:kpsingh@kernel.org,m:haoluo@google.com,m:jolsa@kernel.org,m:shuah@kernel.org,m:maciej.fijalkowski@intel.com,m:jakub@cloudflare.com,m:aleksandr.loktionov@intel.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:linux-kselftest@vger.kernel.org,m:deliran@verdict.gg,m:donaldhunter@gmail.com,m:johnfastabend@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DMARC_NA(0.00)[verdict.gg];
	FORGED_SENDER(0.00)[deliran@verdict.gg,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deliran@verdict.gg,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[verdict.gg:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,verdict.gg:from_mime,verdict.gg:email,verdict.gg:mid,verdict.gg:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EAE4C72A426

From: Lorenzo Bianconi <lorenzo@kernel.org>

Implement xmo_rx_checksum callback in ice driver to report RX checksum
result to the eBPF program bounded to the NIC.
Introduce ice_get_rx_csum utility routine in order to make the rx checksum
code reusable from ice_rx_csum()

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 123 ++++++++++++------
 1 file changed, 81 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index e695a664e53d..3aa82ff03d9e 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -78,69 +78,48 @@ ice_rx_hash_to_skb(const struct ice_rx_ring *rx_ring,
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
+		u32 *cksum, u8 *cksum_level)
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
+		__wsum wcsum;
+		u16 csum;
+
+		desc = (struct ice_32b_rx_flex_desc_nic *)rx_desc;
+		*ip_summed = XDP_CHECKSUM_COMPLETE;
+		csum = (__force u16)desc->raw_csum;
+		wcsum = csum_unfold((__force __sum16)swab16(csum));
+		*cksum = (__force u32)wcsum;
+		*cksum_level = 0;
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
@@ -164,14 +143,51 @@ ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
 	 * we need to bump the checksum level by 1 to reflect the fact that
 	 * we are indicating we validated the inner checksum.
 	 */
-	if (decoded.tunnel_type >= LIBETH_RX_PT_TUNNEL_IP_GRENAT)
-		skb->csum_level = 1;
-
-	skb->ip_summed = CHECKSUM_UNNECESSARY;
+	*cksum_level = decoded.tunnel_type >= LIBETH_RX_PT_TUNNEL_IP_GRENAT;
+	*ip_summed = XDP_CHECKSUM_UNNECESSARY;
+	*cksum = 0;
 	return;
 
 checksum_fail:
 	ring->vsi->back->hw_csum_rx_error++;
+checksum_none:
+	*ip_summed = XDP_CHECKSUM_NONE;
+	*cksum_level = 0;
+	*cksum = 0;
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
+	u8 cksum_level;
+	u32 cksum;
+
+	ice_get_rx_csum(rx_desc, ptype, ring, &ip_summed, &cksum,
+			&cksum_level);
+	switch (ip_summed) {
+	case XDP_CHECKSUM_UNNECESSARY:
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		skb->csum_level = cksum_level;
+		break;
+	case XDP_CHECKSUM_COMPLETE:
+		skb->ip_summed = CHECKSUM_COMPLETE;
+		skb->csum = (__force __wsum)cksum;
+		break;
+	default:
+		skb->ip_summed = CHECKSUM_NONE;
+		break;
+	}
 }
 
 /**
@@ -566,6 +582,28 @@ static int ice_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
 	return 0;
 }
 
+/**
+ * ice_xdp_rx_checksum - RX checksum XDP hint handler
+ * @ctx: XDP buff pointer
+ * @ip_summed: RX checksum result destination address
+ * @cksum: RX checksum value destination address
+ * @cksum_level: RX checksum level value destination address
+ */
+static int ice_xdp_rx_checksum(const struct xdp_md *ctx,
+			       enum xdp_checksum *ip_summed,
+			       u32 *cksum, u8 *cksum_level)
+{
+	const struct libeth_xdp_buff *xdp_ext = (void *)ctx;
+	const union ice_32b_rx_flex_desc *rx_desc = xdp_ext->desc;
+	struct ice_rx_ring *ring;
+
+	ring = libeth_xdp_buff_to_rq(xdp_ext, typeof(*ring), xdp_rxq);
+	ice_get_rx_csum(rx_desc, ice_get_ptype(rx_desc), ring, ip_summed,
+			cksum, cksum_level);
+
+	return 0;
+}
+
 /**
  * ice_xdp_rx_vlan_tag - VLAN tag XDP hint handler
  * @ctx: XDP buff pointer
@@ -598,4 +636,5 @@ const struct xdp_metadata_ops ice_xdp_md_ops = {
 	.xmo_rx_timestamp		= ice_xdp_rx_hw_ts,
 	.xmo_rx_hash			= ice_xdp_rx_hash,
 	.xmo_rx_vlan_tag		= ice_xdp_rx_vlan_tag,
+	.xmo_rx_checksum		= ice_xdp_rx_checksum,
 };
-- 
2.47.0


