Return-Path: <netdev+bounces-182582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEEFA89317
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 06:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312123AB022
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 04:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B704270EB1;
	Tue, 15 Apr 2025 04:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="2sXukdAX"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515DD268FF4
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 04:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744692671; cv=none; b=CaEI9pGiyQnUE7wEErP5Vo5gAA91P/zZIL5Lr/D/azLOYksivSU3wz2XU/DbxrrpuhlMRoaADzIbMpcRKjYfnq/7JrwHB5oJLNQKDLMktrZxOUqZatfXTEtZk+Di8rRAPg+jITl4TriAkXbdSF77vlM9Aw/8o3BVazHBPC2yu3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744692671; c=relaxed/simple;
	bh=lF4wedf/tO3+FiAk1cDHreGwpo2eMAlr+PRbKYAbK2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oFxsm/pSZu37U5co7cEiS7qHXMVHZnamgBdwmDW5tXprgVcsaFM6Vm/l+zJh+H1Y7dD8dJzu2mVuQjYKjwMsrXBsFPNIEkoOHcSmWbSbUVQmyQPPXtSH1/c1HTVwhl6JwD3ZitZDo6g6Ei9JK7DvjzR38tT5OSHxi6nAhHu6H14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=2sXukdAX; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id CE0792C019A;
	Tue, 15 Apr 2025 16:50:58 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1744692658;
	bh=qL8UjlswATP7KHP/ZH3JjtdhJXmlJDDtXfY3QwWPq0Y=;
	h=From:To:Cc:Subject:Date:From;
	b=2sXukdAXFfQzvxjX0t78vNHguVKjJfyY3YIsDiiCLY62sOBXfhr3XzcvWVYqghKV4
	 kkMvyfEl+6KCBkR/Y7TfQ/8j8zZ1Ti0W1QB/1aOCE3j9cGPL4+MnCcjH+r9KwCLXE+
	 0l+ifEOYYC3Ki57a+foSKCXnSl6y/BYSUr1pp4wXPARIXqnyGbR9zc/0umPuEF5D1h
	 a33CxA9ScidVsa3EZqLR0bjDV21FNL3L1OeMOJASjW93XBCAh2tR42XS9N3l7pican
	 Ct3Nhmh/7WzMb79TceH0dsEdweCbReUnHOgUYh96vtM3rf/EB/Ayf2rTEWL1s2YBu9
	 D3RQjxZ5hN+5A==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B67fde5b20000>; Tue, 15 Apr 2025 16:50:58 +1200
Received: from thomaswi-dl.ws.atlnz.lc (thomaswi-dl.ws.atlnz.lc [10.33.25.54])
	by pat.atlnz.lc (Postfix) with ESMTP id AA32C13EDA9;
	Tue, 15 Apr 2025 16:50:58 +1200 (NZST)
Received: by thomaswi-dl.ws.atlnz.lc (Postfix, from userid 1719)
	id A4A7C6400B8; Tue, 15 Apr 2025 16:50:58 +1200 (NZST)
From: Thomas Winter <Thomas.Winter@alliedtelesis.co.nz>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Thomas Winter <Thomas.Winter@alliedtelesis.co.nz>
Subject: [PATCH RFC net] net: Prevent sk_bound_dev_if causing packet to be rerouted back into tunnel
Date: Tue, 15 Apr 2025 16:50:51 +1200
Message-ID: <20250415045051.1913231-1-Thomas.Winter@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=W+WbVgWk c=1 sm=1 tr=0 ts=67fde5b2 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=i-4J7ZLqg6VoOgDM:21 a=XR8D0OoHHMoA:10 a=e7kU084qAJlaYKzS2iUA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

We have found a situation where packets going into an IPsec tunnel get
encapsulated twice. For example, an icmp socket using SO_BINDTODEVICE
of a tunnel and some mangle rules to implement policy based routing.
After the first ESP encapsulation and running through the mangle table
again, a difference in skb->mark causes ip_route_me_harder to be called
but skb->sk->sk_bound_dev_if is still the tunnel. This causes the ESP
packet to get routed back into the tunnel and get xfrm'd again using
the same SA. The double encapsulated is then routed correctly out the
physical interface.

With a xfrmi interface on the other side, it was dropping the packet
with LINUX_MIB_XFRMINTMPLMISMATCH. A ipvti interface would accept it.
However the transmitting side should not have been doing the double
ESP encapsulation in the first place.

A potential fix for this is to drop the reference to skb->sk using
skb_orphan before transmission. scrub_packet would do this but only
if the packet is traversing namespaces. This allows ip_route_me_harder
to select the correct route for the ESP packet without getting fooled
by a sk_bound_dev_if of itself and get forwarded out the physical
interface.

Signed-off-by: Thomas Winter <Thomas.Winter@alliedtelesis.co.nz>
---
 net/ipv4/ip_vti.c              | 1 +
 net/ipv6/ip6_vti.c             | 1 +
 net/xfrm/xfrm_interface_core.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index 159b4473290e..096e9b51816f 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -260,6 +260,7 @@ static netdev_tx_t vti_xmit(struct sk_buff *skb, stru=
ct net_device *dev,
 	skb_scrub_packet(skb, !net_eq(tunnel->net, dev_net(dev)));
 	skb_dst_set(skb, dst);
 	skb->dev =3D skb_dst(skb)->dev;
+	skb_orphan(skb);
=20
 	err =3D dst_output(tunnel->net, skb->sk, skb);
 	if (net_xmit_eval(err) =3D=3D 0)
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 09ec4b0ad7dc..d1d5bbaa3d6d 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -530,6 +530,7 @@ vti6_xmit(struct sk_buff *skb, struct net_device *dev=
, struct flowi *fl)
 	skb_scrub_packet(skb, !net_eq(t->net, dev_net(dev)));
 	skb_dst_set(skb, dst);
 	skb->dev =3D skb_dst(skb)->dev;
+	skb_orphan(skb);
=20
 	err =3D dst_output(t->net, skb->sk, skb);
 	if (net_xmit_eval(err) =3D=3D 0)
diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_cor=
e.c
index 622445f041d3..17b26409e6a0 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -504,6 +504,7 @@ xfrmi_xmit2(struct sk_buff *skb, struct net_device *d=
ev, struct flowi *fl)
 	xfrmi_scrub_packet(skb, !net_eq(xi->net, dev_net(dev)));
 	skb_dst_set(skb, dst);
 	skb->dev =3D tdev;
+	skb_orphan(skb);
=20
 	err =3D dst_output(xi->net, skb_to_full_sk(skb), skb);
 	if (net_xmit_eval(err) =3D=3D 0) {
--=20
2.49.0


