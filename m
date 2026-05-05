Return-Path: <netdev+bounces-284402-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAcCDlnx+WmcFQMAu9opvQ
	(envelope-from <netdev+bounces-284402-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:32:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A854CE8E9
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 352E23059211
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 13:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE07429838;
	Tue,  5 May 2026 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Vpq9uLbh"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB9D343D63
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987423; cv=none; b=P7vHziN52x0df06CwANlXyAizMuOAnaccS/wHCn5jf8Ai1qFeyKoXgRsadx8n07VPZjXZJACO/tamx6xyUDI+4GLkKXSMVG9iYJmQZmhe2frC2/llNbTSyeOM5m6z2BsjWcpQmR0HfGYQI8xAyQbsTO5KToAy6y82eVL0ycHiSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987423; c=relaxed/simple;
	bh=nf5zPxGYnlzVD67cFEFW/cc3yfMtCRD8Vsfcy9fXOY0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atlzkqOC6slre6SjhEi5bbZrxgalZQTPaJXFLQei1UrjBcmU0uG3KYYLAiM7+zO+r9kX60g2thOdRDWIAJhkxlbZlAsnrIEnc+Fxu8OacRBjVJ0+khU82iD2pZvjpUHfxTSIttqmDIEmCrEsZrBc5FGSHnlHS2kJ6QdwVGhZhI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Vpq9uLbh; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id E27662067F;
	Tue,  5 May 2026 15:23:33 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MmyEzv5zvZdc; Tue,  5 May 2026 15:23:33 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id E3D1820663;
	Tue,  5 May 2026 15:23:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com E3D1820663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1777987412;
	bh=ayS9Aep8sc+bKZo796lC77mWyY9UbN0N12T5PI1Pl3g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=Vpq9uLbhJ09M0FH5xTDoCOEuL0x/ttzinj+WxekcVp5S3+70ML5XwpZJ7Q/j5tzC6
	 Hd+blzE8HKxbuNxgLwgYXQ8kwHoQLDDUdjsiArzNGod/jVX4tXsNVRK2skT4t3M2XH
	 gKn+yqFZgD5Xmm/YxZ7o/hwMve1/a8MZuYL9qtHVzcDP6PYJ+Icu5ZI/8wmH51mmvH
	 eokVI5amFeo9aiI7SWXAhXTEKx4+yHQFlhHurNORSZHVRifPZpB8uwk38OcSgul2wq
	 IdlHUGUh+obRsTaJhEIfnmFYMPUxiT4Hv3gSTJVvu6LfeAtA4AyeiHEIG1VEC6onlo
	 1hFU8iJ24zkpQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 15:23:32 +0200
Received: (nullmailer pid 1364092 invoked by uid 1000);
	Tue, 05 May 2026 13:23:30 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 5/8] xfrm: Don't clobber inner headers when already set
Date: Tue, 5 May 2026 15:23:01 +0200
Message-ID: <20260505132326.1362733-6-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505132326.1362733-1-steffen.klassert@secunet.com>
References: <20260505132326.1362733-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Queue-Id: 55A854CE8E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-284402-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,secunet.com:email,secunet.com:dkim,secunet.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]

From: Cosmin Ratiu <cratiu@nvidia.com>

On VXLAN over IPsec egress, xfrm{4,6}_transport_output() blindly
overwrite inner_transport_header (== the inner TCP header saved in VXLAN
iptunnel_handle_offloads() -> skb_reset_inner_headers()) with the
current transport_header (== the VXLAN outer UDP header set by
udp_tunnel_xmit_skb()).

This was a latent bug, harmless until commit [1] added a doff validation
check in qdisc_pkt_len_segs_init() for encapsulated GSO packets. With
the wrong inner_transport_header set by xfrm, qdisc_pkt_len_segs_init()
interprets inner_transport_header as a TCP header, reads doff=0 from the
upper byte of the VNI and drops the packet with DROP_REASON_SKB_BAD_GSO.

Besides the use in GSO to determine the header size of segmented
packets, inner_transport_header might be used by drivers to set up
inner checksum offloading by pointing the HW to the inner transport
header. A quick browse through available drivers shows that mlx5 uses
skb->csum_start specifically for this scenario, while others either
don't support VXLAN over IPsec crypto offload (ixgbe) or the HW is
capable of parsing the packets itself (nfp, Chelsio).

But in all cases, it is more correct to let the inner_transport_header
point to the innermost header instead of overwriting it in xfrm.

So fix this by guarding all four inner header save sites in
xfrm_output.c (xfrm{4,6}_transport_output, xfrm{4,6}_tunnel_encap_add)
with a check for skb->inner_protocol. When inner_protocol is set, a
tunnel layer (VXLAN, Geneve, GRE, etc.) has already saved the correct
inner header offsets and they must not be overwritten. When
inner_protocol is zero, no prior tunnel encapsulation exists and xfrm
must save the inner headers itself. The tunnel mode checks are only
added for completion, since they aren't strictly required, as
xfrm_output() forces software GSO in tunnel mode before encap.

This makes the previously added test pass:
 # ./tools/testing/selftests/drivers/net/hw/ipsec_vxlan.py
 TAP version 13
 1..4
 ok 1 ipsec_vxlan.test_vxlan_ipsec_crypto_offload.outer_v4_inner_v4
 ok 2 ipsec_vxlan.test_vxlan_ipsec_crypto_offload.outer_v4_inner_v6
 ok 3 ipsec_vxlan.test_vxlan_ipsec_crypto_offload.outer_v6_inner_v4
 ok 4 ipsec_vxlan.test_vxlan_ipsec_crypto_offload.outer_v6_inner_v6
 # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0

[1] commit 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")
Fixes: f1bd7d659ef0 ("xfrm: Add encapsulation header offsets while SKB is not encrypted")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_output.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index a9652b422f51..cc35c2fcbbe0 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -66,7 +66,9 @@ static int xfrm4_transport_output(struct xfrm_state *x, struct sk_buff *skb)
 	struct iphdr *iph = ip_hdr(skb);
 	int ihl = iph->ihl * 4;
 
-	skb_set_inner_transport_header(skb, skb_transport_offset(skb));
+	if (!skb->inner_protocol)
+		skb_set_inner_transport_header(skb,
+					       skb_transport_offset(skb));
 
 	skb_set_network_header(skb, -x->props.header_len);
 	skb->mac_header = skb->network_header +
@@ -167,7 +169,9 @@ static int xfrm6_transport_output(struct xfrm_state *x, struct sk_buff *skb)
 	int hdr_len;
 
 	iph = ipv6_hdr(skb);
-	skb_set_inner_transport_header(skb, skb_transport_offset(skb));
+	if (!skb->inner_protocol)
+		skb_set_inner_transport_header(skb,
+					       skb_transport_offset(skb));
 
 	hdr_len = xfrm6_hdr_offset(x, skb, &prevhdr);
 	if (hdr_len < 0)
@@ -276,8 +280,10 @@ static int xfrm4_tunnel_encap_add(struct xfrm_state *x, struct sk_buff *skb)
 	struct iphdr *top_iph;
 	int flags;
 
-	skb_set_inner_network_header(skb, skb_network_offset(skb));
-	skb_set_inner_transport_header(skb, skb_transport_offset(skb));
+	if (!skb->inner_protocol) {
+		skb_set_inner_network_header(skb, skb_network_offset(skb));
+		skb_set_inner_transport_header(skb, skb_transport_offset(skb));
+	}
 
 	skb_set_network_header(skb, -x->props.header_len);
 	skb->mac_header = skb->network_header +
@@ -321,8 +327,10 @@ static int xfrm6_tunnel_encap_add(struct xfrm_state *x, struct sk_buff *skb)
 	struct ipv6hdr *top_iph;
 	int dsfield;
 
-	skb_set_inner_network_header(skb, skb_network_offset(skb));
-	skb_set_inner_transport_header(skb, skb_transport_offset(skb));
+	if (!skb->inner_protocol) {
+		skb_set_inner_network_header(skb, skb_network_offset(skb));
+		skb_set_inner_transport_header(skb, skb_transport_offset(skb));
+	}
 
 	skb_set_network_header(skb, -x->props.header_len);
 	skb->mac_header = skb->network_header +
-- 
2.43.0


