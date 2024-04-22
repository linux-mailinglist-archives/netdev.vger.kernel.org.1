Return-Path: <netdev+bounces-89911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 897E78AC2DE
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 04:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38FD7280D40
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 02:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D924C83;
	Mon, 22 Apr 2024 02:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="jHEujUS3"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C484C7D
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 02:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713754693; cv=none; b=OyAGN5OMEPRCM8NpaP41mkOCiMD95qVbew9t4AUnkM7ra4Hw8T/1w7Y+Q2rVg+4h2WwtO5qdGxhkDEWiavy+oib10HIBaRkXLtuiQg3QUcgRwJDhZ41IGqVCN6nrA6RZ2RfY/zGhjwi4G9o8c1EYBRjFsqGrhQIpT7YOF1mGRMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713754693; c=relaxed/simple;
	bh=7qV2bF5a65dyFGwX/AL1WVHguRShpDjN/Hs97K9WGsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W5KKKdkKV28carToqkPkKWKGIeTkNTyGtMHZVda0sE+sP5q5CppDHmM2yNpzEtzOwPio9nh3duBe2we1rQfFFbZYdasf85SWFu3StbRG+RuUmCkZOBi1xoTTeX1st9DC+/KU6pAMSVubkerlJr1JA8zZLj7WNgFvLKqsIhx/PCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=jHEujUS3; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 622192C0577;
	Mon, 22 Apr 2024 14:58:01 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1713754681;
	bh=jiiePYoXPgQWItcAHYElyxZiG+LxlGcAvcni6wjHyQ8=;
	h=From:To:Cc:Subject:Date:From;
	b=jHEujUS3hLcRcWdtO94/UHtRhwFm6DryZjRI1dX6dESd/XT+v6/oQq3UxjTZbINHP
	 l5RWO/4V0vXywl+3/Y9OEEidIO7k1Eg5em+ClIcns4JnFa+oDW5V1YwwgoH6X3Ta/W
	 giXBzcgzWxH4dHj/g8DCxssAiK0wwLtdfGAsuigYcN/sSQGP+evS4wlXR9Z6QGq1Iw
	 GwfwaQ+X2m+A09cxQoUSK/hcTjwB66JVPLFn/ijVE/HC6r+Uff60YhLi603jfXl4bq
	 AB0TenjbHrDFB5Na8OzDFODUns/nNcpeTqAazG2vbN+RpxLzAYOZeLHD+jRiZwCfbC
	 Uc1fnOH8By1Fg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6625d2380004>; Mon, 22 Apr 2024 14:58:00 +1200
Received: from pauld2-dl.ws.atlnz.lc (pauld-dl.ws.atlnz.lc [10.33.23.30])
	by pat.atlnz.lc (Postfix) with ESMTP id D414113EDDC;
	Mon, 22 Apr 2024 14:58:00 +1200 (NZST)
Received: by pauld2-dl.ws.atlnz.lc (Postfix, from userid 1684)
	id D09724025E; Mon, 22 Apr 2024 14:58:00 +1200 (NZST)
From: Paul Davey <paul.davey@alliedtelesis.co.nz>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org,
	Paul Davey <paul.davey@alliedtelesis.co.nz>
Subject: [PATCH net] xfrm: Preserve vlan tags for transport mode software GRO
Date: Mon, 22 Apr 2024 14:56:20 +1200
Message-ID: <20240422025711.145577-1-paul.davey@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=dY4j3mXe c=1 sm=1 tr=0 ts=6625d238 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=raytVjVEu-sA:10 a=VwQbUJbxAAAA:8 a=Bqy_Grlq6dl_WPm9lfgA:9 a=3ZKOabzyN94A:10 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

The software GRO path for esp transport mode uses skb_mac_header_rebuild
prior to re-injecting the packet via the xfrm_napi_dev.  This only
copies skb->mac_len bytes of header which may not be sufficient if the
packet contains 802.1Q tags or other VLAN tags.  Worse copying only the
initial header will leave a packet marked as being VLAN tagged but
without the corresponding tag leading to mangling when it is later
untagged.

The VLAN tags are important when receiving the decrypted esp transport
mode packet after GRO processing to ensure it is received on the correct
interface.

Therefore record the full mac header length in xfrm*_transport_input for
later use in correpsonding xfrm*_transport_finish to copy the entire mac
header when rebuilding the mac header for GRO.  The skb->data pointer is
left pointing skb->mac_header bytes after the start of the mac header as
is expected by the network stack and network and transport header
offsets reset to this location.

Signed-off-by: Paul Davey <paul.davey@alliedtelesis.co.nz>
---

I discovered that incomplete mac header rebuilding was the cause of an is=
sue I
noticed with l2tp tunnels with IPSec transport mode protection not workin=
g
properly when the tunnel was running over a VLAN. This issue was describe=
d in
the linked mailing list post.
   =20
I am not certain if the tunnel encapsulation modes would require similar
adjustment though they do not seem to have an issue with packets passing.
I am also uncertain of how this sort of problem may interact with interfa=
ces
which are bridged.
   =20
Link: https://lore.kernel.org/r/ecf16770431c8b30782e3443085641eb685aa5f9.=
camel@alliedtelesis.co.nz/

 include/linux/skbuff.h | 15 +++++++++++++++
 include/net/xfrm.h     |  3 +++
 net/ipv4/xfrm4_input.c |  6 +++++-
 net/ipv6/xfrm6_input.c |  6 +++++-
 net/xfrm/xfrm_input.c  |  4 ++++
 5 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 9d24aec064e8..4ff48eda3f64 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3031,6 +3031,21 @@ static inline void skb_mac_header_rebuild(struct s=
k_buff *skb)
 	}
 }
=20
+/* Move the full mac header up to current network_header.
+ * Leaves skb->data pointing at offset skb->mac_len into the mac_header.
+ * Must be provided the complete mac header length.
+ */
+static inline void skb_mac_header_rebuild_full(struct sk_buff *skb, u32 =
full_mac_len)
+{
+	if (skb_mac_header_was_set(skb)) {
+		const unsigned char *old_mac =3D skb_mac_header(skb);
+
+		skb_set_mac_header(skb, -full_mac_len);
+		memmove(skb_mac_header(skb), old_mac, full_mac_len);
+		__skb_push(skb, full_mac_len - skb->mac_len);
+	}
+}
+
 static inline int skb_checksum_start_offset(const struct sk_buff *skb)
 {
 	return skb->csum_start - skb_headroom(skb);
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 57c743b7e4fe..0331cfecb28b 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -675,6 +675,9 @@ struct xfrm_mode_skb_cb {
=20
 	/* Used by IPv6 only, zero for IPv4. */
 	u8 flow_lbl[3];
+
+	/* Used to keep whole l2 header for transport mode GRO */
+	u32 orig_mac_len;
 };
=20
 #define XFRM_MODE_SKB_CB(__skb) ((struct xfrm_mode_skb_cb *)&((__skb)->c=
b[0]))
diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index dae35101d189..322f9dfee0c4 100644
--- a/net/ipv4/xfrm4_input.c
+++ b/net/ipv4/xfrm4_input.c
@@ -63,7 +63,11 @@ int xfrm4_transport_finish(struct sk_buff *skb, int as=
ync)
 	ip_send_check(iph);
=20
 	if (xo && (xo->flags & XFRM_GRO)) {
-		skb_mac_header_rebuild(skb);
+		/* The full l2 header needs to be preserved so that re-injecting the p=
acket at l2
+		 * works correctly in the presence of vlan tags.
+		 */
+		skb_mac_header_rebuild_full(skb, XFRM_MODE_SKB_CB(skb)->orig_mac_len);
+		skb_reset_network_header(skb);
 		skb_reset_transport_header(skb);
 		return 0;
 	}
diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index a17d783dc7c0..000981d4ca02 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -58,7 +58,11 @@ int xfrm6_transport_finish(struct sk_buff *skb, int as=
ync)
 	skb_postpush_rcsum(skb, skb_network_header(skb), nhlen);
=20
 	if (xo && (xo->flags & XFRM_GRO)) {
-		skb_mac_header_rebuild(skb);
+		/* The full l2 header needs to be preserved so that re-injecting the p=
acket at l2
+		 * works correctly in the presence of vlan tags.
+		 */
+		skb_mac_header_rebuild_full(skb, XFRM_MODE_SKB_CB(skb)->orig_mac_len);
+		skb_reset_network_header(skb);
 		skb_reset_transport_header(skb);
 		return 0;
 	}
diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 161f535c8b94..d06f1b3cd322 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -394,6 +394,8 @@ static int xfrm4_transport_input(struct xfrm_state *x=
, struct sk_buff *skb)
 	if (skb->transport_header !=3D skb->network_header) {
 		memmove(skb_transport_header(skb),
 			skb_network_header(skb), ihl);
+		XFRM_MODE_SKB_CB(skb)->orig_mac_len =3D
+			skb_mac_header_was_set(skb) ? skb_mac_header_len(skb) : 0;
 		skb->network_header =3D skb->transport_header;
 	}
 	ip_hdr(skb)->tot_len =3D htons(skb->len + ihl);
@@ -409,6 +411,8 @@ static int xfrm6_transport_input(struct xfrm_state *x=
, struct sk_buff *skb)
 	if (skb->transport_header !=3D skb->network_header) {
 		memmove(skb_transport_header(skb),
 			skb_network_header(skb), ihl);
+		XFRM_MODE_SKB_CB(skb)->orig_mac_len =3D
+			skb_mac_header_was_set(skb) ? skb_mac_header_len(skb) : 0;
 		skb->network_header =3D skb->transport_header;
 	}
 	ipv6_hdr(skb)->payload_len =3D htons(skb->len + ihl -
--=20
2.43.2


