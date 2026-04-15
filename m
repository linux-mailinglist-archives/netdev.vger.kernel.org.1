Return-Path: <netdev+bounces-278859-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHV3GBve32nXZgAAu9opvQ
	(envelope-from <netdev+bounces-278859-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 20:51:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 24131407347
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 20:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 989FC3030CB5
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 18:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AD936E48C;
	Wed, 15 Apr 2026 18:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nt5nA4Wx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0722023370F
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776279062; cv=none; b=nWEDH3j2UWN3EuQv5ThRhxz54GbLu3Y+ixWO8YU2h1oqaYzBTRGheNCXydTfjuOCxBshc+j8eq8QIBnrz92bY+0ijaQdu+Cb5YwWGDmseX8039Cy/+uqU7Vq3k1QMfcQy7UuWEwxd4figKdwYOWaW508f3tigu/xKXnsVv4Gqmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776279062; c=relaxed/simple;
	bh=GPQJkivEkwF0HUbahudHs4/b40DCkewhO8M1G0dxZGw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ul7nzKKPyKwrTFqh07Cw0GiqlETsqqRGV7QAO+BX3J91NORqUV7BryLb3UaE3+khq82LBIQk46PG3Yj1N1Tfcv0WdLkI4Wrr43lQ37izcgpVaEBvfTk+ATpsOWnUaeOntdp0YNZOM3JWXtHrUdqXIq4Jl5dZmN/tcvFdnQDThUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nt5nA4Wx; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48897fd88ebso72881335e9.2
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 11:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776279059; x=1776883859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pWPTdAO8MCBweTcbWU1oKhIQP/ALhI5YLbC4nFtxE20=;
        b=Nt5nA4WxDQKXAAgy3uArvipxboa3iWaAeBcJPXBCYk6OBSyyP5v4cuHcUDkMA2S8hG
         d8ZuwCmaB5oCtw3tQJURjphUrFABOT1ZlHZRx6y0dQIx17nXkD1sPHdjaoYJn70l99T0
         7IgURC6eY21/UUHmoSrR0jhovRxP+/UJO4K9+8nKj+JwOpcw/BVHlO+Sc7SD9yR+pst4
         bjky0TqUmnP6+oKKBBWjDGfh68sPks3Nm67PZPIABInIIhzndhnx+m0+yEjcVmd0pYRx
         J8kS2I2eA5CeiRFl+VJzwZ5Anlz4gt3hD9IuD7cp1NbzCTdwjwWAY3AxspztouORbd8L
         Lh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776279059; x=1776883859;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWPTdAO8MCBweTcbWU1oKhIQP/ALhI5YLbC4nFtxE20=;
        b=cd6hx3rywMCMGcqWlelkf3jb1huKgk3gOcSnMhZFVFOP66hdww2JxkdYqbQ49vRmMJ
         mNEx6SLXcnKalx81gULZWamyvAiEg8GPPfh84M/oy555721hUyxHipT9Vna9+ewXOBBO
         Jeil07zjRfAaMCOooEzVGxopqMVG2fUXPKZ3Umq9nn8+5+t1LE02mU1GCtwzxSWrXZK2
         iObl7DBJ/Yl/ihwRcs2rMt7He2z92avn+hS1LX6ekDwJr0X2w1vjxloOyYYufd045mlN
         X+FjAjYadKCGmsyOicMjgMb9Ud8tO7/KbKhbqR1BO2npz3/3ZMFt+IP878RaPhbyDfyk
         C95w==
X-Gm-Message-State: AOJu0YyYQ330UdjNH1k0dGtCgwnggr9XdVK0dTYlbG86TyhHPZgzysG+
	+FUjNar3WPOslErcz1C8dkl2aRREQJr9U+PRRNdBX/IAAJs9eF0LJuWvju7wj/Y2
X-Gm-Gg: AeBDieuikKlW5tF+PqxcIddETsEwuxKEIwFnGOywbqNmsWliuFli2xZ7r4Za5vWUAQe
	JuzhWjvwr/sNuSaDBlpEiYppmrjziPjScv+geC8TjLeZtaIemMRsKSiTHV1hYpLMJePqlzAfDSK
	3YglKTLs1/KjL4XN4q9Lp1Btu2Na+suwLKImaMTudnHYvYDtcIhwtbZjDFbSTV+4twHeSRew/qq
	DTKqzSEzNFfGbwdqvZkVg+BjE3GOcQOKdm4CfFNiCqqBoejHoXDGOzm3dEM0IMUtyilHAuWSwKi
	dxG8POEa7rr5ZMvFaYMGNo1Y/MRlArtQw0z48kBr0sCqRfBPcTPsDOjcIfT0wtfya2Ta+ruQdRJ
	qsLXDAU6OGk6R8diC5ndSP2vgI2DpwDg0ZJt1ZrC7+I1zp20bJsMV34EMOV9oIVgyCv49rsiord
	br3nysv7tsmXIpj/1qlybmM7iMOiJjMiDcGA14QP2waPBH0G+E4vpnHNCaW/kwJtCQIx/L23Jvj
	W4=
X-Received: by 2002:a05:6000:2386:b0:43d:77a8:3baf with SMTP id ffacd0b85a97d-43d77a83e04mr21924539f8f.32.1776279058798;
        Wed, 15 Apr 2026 11:50:58 -0700 (PDT)
Received: from dau-home-pc ([89.222.123.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5f06sm7543057f8f.17.2026.04.15.11.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:50:58 -0700 (PDT)
Date: Wed, 15 Apr 2026 21:50:55 +0300
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH net-next v2 1/2] udp: fix encapsulation packet resubmit
 in multicast deliver
Message-ID: <ad_eD6CjMOBSXQVm@dau-home-pc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad_dal164gVmImWl@dau-home-pc>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,google.com,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-278859-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[littlesmilingcloud@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 24131407347
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a UDP encapsulation socket (e.g., FOU) receives a multicast
packet, __udp4_lib_mcast_deliver() and __udp6_lib_mcast_deliver()
incorrectly call consume_skb() when udp_queue_rcv_skb() returns a
positive value. A positive return value from udp_queue_rcv_skb()
indicates that the encap_rcv handler (e.g., fou_udp_recv) has
consumed the UDP header and wants the packet to be resubmitted to
the IP protocol handler for further processing (e.g., as a GRE
packet).

The unicast path in udp_unicast_rcv_skb() handles this correctly by
returning -ret, which propagates up to ip_protocol_deliver_rcu() for
resubmission. The GSO path in udp_queue_rcv_skb() also handles this
correctly by calling ip_protocol_deliver_rcu() directly. However, the
multicast path destroys the packet via consume_skb() instead of
resubmitting it, causing silent packet loss.

This affects any UDP encapsulation (FOU, GUE) combined with multicast
destination addresses. In practice, it causes ~50% packet loss on
FOU/GRETAP tunnels configured with multicast remote addresses, with
the exact ratio depending on the early demux cache hit rate (packets
that hit early demux take the unicast path and are handled correctly).

Fix this by calling ip_protocol_deliver_rcu() (IPv4) or
ip6_protocol_deliver_rcu() (IPv6) instead of consume_skb() when the
return value is positive, matching the behavior of the GSO path.

Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
Assisted-by: Claude:claude-opus-4-6
---
 net/ipv4/udp.c | 13 +++++++++----
 net/ipv6/udp.c | 13 +++++++++----
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index e9e2ce9522ef..8c2d4367cba2 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2467,6 +2467,7 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 	struct udp_hslot *hslot;
 	struct sk_buff *nskb;
 	bool use_hash2;
+	int ret;
 
 	hash2_any = 0;
 	hash2 = 0;
@@ -2500,8 +2501,10 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 			__UDP_INC_STATS(net, UDP_MIB_INERRORS);
 			continue;
 		}
-		if (udp_queue_rcv_skb(sk, nskb) > 0)
-			consume_skb(nskb);
+		ret = udp_queue_rcv_skb(sk, nskb);
+		if (ret > 0)
+			ip_protocol_deliver_rcu(dev_net(nskb->dev), nskb,
+						ret);
 	}
 
 	/* Also lookup *:port if we are using hash2 and haven't done so yet. */
@@ -2511,8 +2514,10 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 	}
 
 	if (first) {
-		if (udp_queue_rcv_skb(first, skb) > 0)
-			consume_skb(skb);
+		ret = udp_queue_rcv_skb(first, skb);
+		if (ret > 0)
+			ip_protocol_deliver_rcu(dev_net(skb->dev), skb,
+						ret);
 	} else {
 		kfree_skb(skb);
 		__UDP_INC_STATS(net, UDP_MIB_IGNOREDMULTI);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 15e032194ecc..f74935d9f7d7 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -949,6 +949,7 @@ static int __udp6_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 	struct udp_hslot *hslot;
 	struct sk_buff *nskb;
 	bool use_hash2;
+	int ret;
 
 	hash2_any = 0;
 	hash2 = 0;
@@ -987,8 +988,10 @@ static int __udp6_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 			continue;
 		}
 
-		if (udpv6_queue_rcv_skb(sk, nskb) > 0)
-			consume_skb(nskb);
+		ret = udpv6_queue_rcv_skb(sk, nskb);
+		if (ret > 0)
+			ip6_protocol_deliver_rcu(dev_net(nskb->dev), nskb,
+						 ret, true);
 	}
 
 	/* Also lookup *:port if we are using hash2 and haven't done so yet. */
@@ -998,8 +1001,10 @@ static int __udp6_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 	}
 
 	if (first) {
-		if (udpv6_queue_rcv_skb(first, skb) > 0)
-			consume_skb(skb);
+		ret = udpv6_queue_rcv_skb(first, skb);
+		if (ret > 0)
+			ip6_protocol_deliver_rcu(dev_net(skb->dev), skb,
+						 ret, true);
 	} else {
 		kfree_skb(skb);
 		__UDP6_INC_STATS(net, UDP_MIB_IGNOREDMULTI);
-- 
2.47.3


