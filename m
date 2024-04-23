Return-Path: <netdev+bounces-90353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF8B8ADD46
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 08:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609B41C211BF
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 06:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA97E219F6;
	Tue, 23 Apr 2024 06:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="rsPaUhVM"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F74F20DE7
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 06:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713852081; cv=none; b=rNm7szLkyFr2Di3Iu5lkqJGlje3Vl0a3fXR+CbPkVAD+NwFxVKHz1uDIPM+2NVHlvmvQaU2O3JAWvR8exEoZDbSdy4ELNA+sa4fpj9sS9Hqw7uqcWbAZ11kcLyg1vSkbBygePWSQpTu81r17Z9wCvU5yHlq1xHhzYCD48gsKgmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713852081; c=relaxed/simple;
	bh=ZJ0gjPP5kcUUZZKE0glYR4Rjcx8Kw+7WIyhISALvrtI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VrK7n4e1nqXlS2XpFMnXzYfBGKHijE5OxZ2ymuDOLIQoPNMZBX60zNK/Mhby4oA4DDwadLegTHLlvrHD+pfKnP0JFv2mbyzHX+Nyb3V4Z5ym+Bn0e8n/XTd2hoMKlepc+0NPi3oDwsR5qaug1IkLLIYAte6+eevoTTxvukTyFvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=rsPaUhVM; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 6F1342C01BD;
	Tue, 23 Apr 2024 18:01:10 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1713852070;
	bh=uXqBl1986cO2GR1p0bcQX0G7ffHD6xLwlmiWoayP1yU=;
	h=From:To:Cc:Subject:Date:From;
	b=rsPaUhVMypmz9dp8tWhJnXZjh3wlYzfHW15oulUZsKrEZBv3pEdL4IgD1jOB1WUty
	 fConS4BOAzILODGZtlWvxZ8m0dzZGRCWgoxFPfqIC5b2OUoX5WalkSOPxyNuL+W1ce
	 M7tmNoPVOzEEgXX6A/8X86dn/cRDt6fWrHrj6kSKC2Iepz3cIS224Zm8WPixaiIvPl
	 DxSRQj3bAgVME9dUep5njoOJ+W9dOzzIpEIYcUEAB6qRsTB1O5yZwjrfqPihtw1+pO
	 27Hmz5k/B4OCXYqv8puxisGozTVF4f7v9nKrRLZ4rJIdLM6wTXGcLXMhq8AEzpjHoE
	 Vh6VaiSSNseew==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B66274ea50000>; Tue, 23 Apr 2024 18:01:09 +1200
Received: from pauld2-dl.ws.atlnz.lc (pauld-dl.ws.atlnz.lc [10.33.23.30])
	by pat.atlnz.lc (Postfix) with ESMTP id EF18413ECD2;
	Tue, 23 Apr 2024 18:01:09 +1200 (NZST)
Received: by pauld2-dl.ws.atlnz.lc (Postfix, from userid 1684)
	id EB5284026C; Tue, 23 Apr 2024 18:01:09 +1200 (NZST)
From: Paul Davey <paul.davey@alliedtelesis.co.nz>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org,
	Paul Davey <paul.davey@alliedtelesis.co.nz>
Subject: [PATCH net v2] xfrm: Preserve vlan tags for transport mode software GRO
Date: Tue, 23 Apr 2024 18:00:24 +1200
Message-ID: <20240423060100.2680602-1-paul.davey@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=dY4j3mXe c=1 sm=1 tr=0 ts=66274ea5 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=raytVjVEu-sA:10 a=VwQbUJbxAAAA:8 a=mY0T97Cm7PKDa_y2pHcA:9 a=3ZKOabzyN94A:10 a=AjGcO6oz07-iQ99wixmX:22
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
later use in corresponding xfrm*_transport_finish to copy the entire mac
header when rebuilding the mac header for GRO.  The skb->data pointer is
left pointing skb->mac_header bytes after the start of the mac header as
is expected by the network stack and network and transport header
offsets reset to this location.

Fixes: 7785bba299a8 ("esp: Add a software GRO codepath")
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
   =20
changes in v2:
  orignal mac length moved to struct xfrm_offload
  fixes tag added

 include/linux/skbuff.h | 15 +++++++++++++++
 include/net/xfrm.h     |  3 +++
 net/ipv4/xfrm4_input.c |  6 +++++-
 net/ipv6/xfrm6_input.c |  6 +++++-
 net/xfrm/xfrm_input.c  |  8 ++++++++
 5 files changed, 36 insertions(+), 2 deletions(-)

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
index 57c743b7e4fe..cb4841a9fffd 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1049,6 +1049,9 @@ struct xfrm_offload {
 #define CRYPTO_INVALID_PACKET_SYNTAX		64
 #define CRYPTO_INVALID_PROTOCOL			128
=20
+	/* Used to keep whole l2 header for transport mode GRO */
+	__u32			orig_mac_len;
+
 	__u8			proto;
 	__u8			inner_ipproto;
 };
diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index dae35101d189..86382e08140e 100644
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
+		skb_mac_header_rebuild_full(skb, xo->orig_mac_len);
+		skb_reset_network_header(skb);
 		skb_reset_transport_header(skb);
 		return 0;
 	}
diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index a17d783dc7c0..c6b8e132e10a 100644
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
+		skb_mac_header_rebuild_full(skb, xo->orig_mac_len);
+		skb_reset_network_header(skb);
 		skb_reset_transport_header(skb);
 		return 0;
 	}
diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 161f535c8b94..3a2982a72a6b 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -389,11 +389,15 @@ static int xfrm_prepare_input(struct xfrm_state *x,=
 struct sk_buff *skb)
  */
 static int xfrm4_transport_input(struct xfrm_state *x, struct sk_buff *s=
kb)
 {
+	struct xfrm_offload *xo =3D xfrm_offload(skb);
 	int ihl =3D skb->data - skb_transport_header(skb);
=20
 	if (skb->transport_header !=3D skb->network_header) {
 		memmove(skb_transport_header(skb),
 			skb_network_header(skb), ihl);
+		if (xo)
+			xo->orig_mac_len =3D
+				skb_mac_header_was_set(skb) ? skb_mac_header_len(skb) : 0;
 		skb->network_header =3D skb->transport_header;
 	}
 	ip_hdr(skb)->tot_len =3D htons(skb->len + ihl);
@@ -404,11 +408,15 @@ static int xfrm4_transport_input(struct xfrm_state =
*x, struct sk_buff *skb)
 static int xfrm6_transport_input(struct xfrm_state *x, struct sk_buff *s=
kb)
 {
 #if IS_ENABLED(CONFIG_IPV6)
+	struct xfrm_offload *xo =3D xfrm_offload(skb);
 	int ihl =3D skb->data - skb_transport_header(skb);
=20
 	if (skb->transport_header !=3D skb->network_header) {
 		memmove(skb_transport_header(skb),
 			skb_network_header(skb), ihl);
+		if (xo)
+			xo->orig_mac_len =3D
+				skb_mac_header_was_set(skb) ? skb_mac_header_len(skb) : 0;
 		skb->network_header =3D skb->transport_header;
 	}
 	ipv6_hdr(skb)->payload_len =3D htons(skb->len + ihl -
--=20
2.43.2


