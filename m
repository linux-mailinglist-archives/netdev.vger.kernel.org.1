Return-Path: <netdev+bounces-253735-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFFELRxpeGkopwEAu9opvQ
	(envelope-from <netdev+bounces-253735-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:28:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0E790BB7
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4441303433B
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B116329E4B;
	Tue, 27 Jan 2026 07:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Di/aNy3B"
X-Original-To: netdev@vger.kernel.org
Received: from sonic301-30.consmr.mail.ne1.yahoo.com (sonic301-30.consmr.mail.ne1.yahoo.com [66.163.184.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8549A326D4D
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 07:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769498898; cv=none; b=XtDIGZw/rxqUbcc2rqEyVwAA73O6thM6NGPwsyBiQUaTWkrjdcsypsLs6MurnT+m2nXMznK+TuBEXwYZzPPpZWngu1qZD0qCVydedc5OYDYDD3t/EqAzDIPi+TuIS9o3uwh3cWpgE16NoNCGx/Et3pB7MyivVKspEXZG+4ABVwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769498898; c=relaxed/simple;
	bh=9BYa0z94Hmry28of+u/2XQStTBecbGfiYfOBNk/CBmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWGrOeHXyY/wl8x94FiL+l6ryUngXHzlce8skQsKmM0ST98MOFd8TzdowdNCBnatrXoTtfKeJbalFjEx44wkiZQgy0/GmSdw1O+tq8sg2WD8FTPJg8jCanSsblkqEtlGkiV5NHmfVKv3Nop9VT73oxqQWWD/8hEff8j+GQJM2pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Di/aNy3B; arc=none smtp.client-ip=66.163.184.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1769498895; bh=zcyjbB29jfSRIhqzAHiuH6pP28JinZ5meGFHh8E0HGU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Di/aNy3BdcjQiZaR6CaBXayYY7hk7W3EB/gLMxVRWsTPnOz/oTlfLttFbSFBrjCZSodiCAxpXzWtpgQEic9o3pAUjqeZMaTGqp4GYY3OBQ6VB3w7oU9A9Ug1gRC8CFSc/kHxUFQBW6EJZayBuP5Wo6REW90lLpJZrvTJr4LbFKZK4lOhTIEEkRODsBzqxJovSBXmX0z3H4K8vU+xm7Q++GQ+efE0iqdE3i5C3//52ZPRl1d+H2owVbfTq8ZiQWiGnGLvBOKWn82D3jM+8iDIl8w4cjjd0y/2pCE0SRiA2B3I0uhBIdtQuXIwURqABBae2Ze6W/5ofBMB1psRPJxSgA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1769498895; bh=BK/Ga11WgtsUWgmmlyNQ8DUSkGoHfybsvTN5hCu34QA=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Zc2jOnyxrLp/IrhtMvMFfa0PgQZvaiJNiNFGsEC24uphzlPEEKH1Ls6Gv3crBZqK1/jLMDWu2VZSA573ovbJLQAYfFgj0HRxcWgJQXY3Vo17hc+VWa3+yHi7QXwB+2dGlRD2zPOE/93g1o729iLdxDlAkIVY2IMvcD2v+zcjJ6gTOgrGAfG5k9l/63m2eXpzR1jhnJx3SYyYkg917+xJ399FHH6OnjIxq6N8jsaNy11V9K/cVhoO2xx6Vw/d4TMaNBFANj1i5ZUBe669olhWB93BADHUIWf21PN2yYO1MQAnqZo8/3X9PmRnQNrD1ri/o3GDcuGAwIOT+mF+mBLF+w==
X-YMail-OSG: 6wE9KQ8VM1nHR7B9bnDOyxUQhhRH_NtvF0e2o3jC16woQjowlWjfA6SaNF4bmEU
 Lrjz78WXHhYLeQdZ7tcUncsk.7eyURqe.sHWZGiO4ajJtZQTDtcHGGGouToQWV3StGEAn7mTzYX.
 bSMJJZ4dnv3evDhiqkZriYQSn2yMtV5q7ra4ZVx.vFgq9vIkbofJ5OzSHDL2d3My3iJJE8kg0KTH
 KlkKzsWw6kF7OWoEwkBTYw6O8cqrKNBw.WIm9GT7.5.xCAeR.A327dAVxur7rsJdMMdtKGN9BNXR
 iXkg_iPXSa4IAO2JBsyK6E4cbpLsQ92YTjwwvWmB_MOLYbrk0mDen8IJMFVx0V1nGXEtM9o9ekuW
 WZ7_Z7ZR5rGsR9CIq_BU1GbI3IiMSTMIn64QCq69KHqLxperfURbzwO9s1jP.dXRD2tGzxageEpl
 5TtOUcCsOqu0w6kDrRTh.2GSUUSHL.6Kx2DRJpvzXGpqS9CM6mDxsYcKGd4bCtF.E1izC0Dwabj9
 xgvmr5lRuCbHd3V0M19.j9v7_tDknHBwmwwFUavoOhVjKKSKslpVzoD9ovocDtR1sYk2GxOGfm82
 DURbH8o_2IhfEKLzNaHqqikUXu5gJPjXfBJKTgvevKLVH_4aatxfs3kwCy4Gsgd95gJ5fc0mGcds
 OOA911rMBMDuK5B.uo7KzGwpZpagyot1cyGLCn_GKdi5SEsgo6uPLsl4hTDB8d0czT32Tux5ypNB
 6woHM5WbgN06cu0YzhmhXl2wyI7wH399r1bJ3xUKXPgpscGnyMzmgUbylZGW3f4.TVqO0AYP90PH
 NwrfAly8qMfgvi2S7JTkRu21xwzbUoQ2OYT1pRwkWeewL3stX6qZwmSqrTmuLV_pf_1BOqMy9.rL
 RkhOvD2yxhzTcOj_r_2m0BM9GcrEPZELU9iXBSOortc.bCSPbFMk59XjqleSMuuCowE_G6xuphXa
 SqJB.48OYyihfcAdq4QvP1NgczzbIcOgYIghRIYioOO9eg5wkURmeuvsIqBxoxhos_LL0fr7V6uq
 ZoVVObDZF7V6fU4qirFZ.Va.ni3VLPbQDZVYDOfMtMdqjmPokXRjn3vBkv6VCrqSUzhML4k8IP8q
 3RnB97uo0GOR1CbxnuyL7AvH50gnAmTW6iar1SJJWheQRw5Z49Gi07kw.GtjqiehX3f6FcblgC7Z
 Fj3udgJrc42mJXWJayYwrWGndt09Z2tTkN3Ydjt3O6iJY4mpPSXbNKG9PCa1l5vu2G7d8S1BzFU6
 QXoznGGBLQxnY0ESNiUAPDE76VOA2Q3kXsG1Z7ovkP1K5qYHAt_R8mG7srOJPWGc3ogu7UcupCz9
 UYwzrZ88Op3xpUeS4CEsflRPZlvRNA3Tnxrs9zLyCvRLZGbrPK6I0y3t_UPRyYlALk77zZqNz9td
 SDuGW6ORK3gZr6ybe6RLDo6AvHxslmoOGztep.gUkSdJCHqeWLbO9vtMmgfkX5Fu1gmNaImwHkCO
 Jn8VQjXUnlMwd5EQnGbArVgf30SqeiV3eKvRIC7hbSxcFKrO2rxEnAhrPm79j48qcLSU4IlBbsbW
 shv6yFVnhb9dNZibWNZ8UhV0ybdjQKbkSZKL5qdY3AjCEkYZkJiIaT8INt5eJP5g4Sam0EEv9V.Z
 CK_26H61zD_KhVKDU.U0iZ7cbORr.FRuuGQV3D26y9SzLCyQ6G22QX2gBC3HfTGWwhiggLmOpNOH
 cvx_Ile5vKLuhTXt5DNpVigqdAoun8EAc3BeJlmWVdzv3vUPcefGicK2rvwRBsGEtb25_wZJgyWv
 __5TBlVTe3FdWhfFT99n0.z.YPjArssWndi4xQ9qb0e5gepZUl0RVTNqtt_kGkGNlH7D7SmxGdcd
 OiMTlk_K2O74aeD23brxT4G32ityU5QpaThw2Ey9fRYbnX_eFvIurOIxtgrZnFHcryV09bxAjftv
 ho90QvwISQ07QYoxnt9Zijc6P3rEoWQyXYxU86ztHcWQvpc.h9f8BPCfo50E.cI0t2hF2AL.TLAr
 lJpgT8pW0oHv0iNczYo2SZAMvPQo8mvS.pt9ReLu_Lv6uIZrPm3XmOs9.cTMFlzQk6oSzFilvZe3
 GNMtO.oCG.RfYZDZDFxgs3ngTNMJngG5WNIKxLrAI5f5fRmfq1OuYsBoxaPCNX8fvIW57oamISRk
 _Uropvm9Ie8v3mgwclXGYddv4ZbHWVyV7NEg.FJoy
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 691cb394-4722-4d79-a72a-89da4189e546
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Jan 2026 07:28:15 +0000
Received: by hermes--production-ir2-6fcf857f6f-gch58 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 84771875e54e61ed0bb89230515c8a5a;
          Tue, 27 Jan 2026 07:07:55 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v7 05/11] net: ovpn: convert ovpn_udp{4,6}_output to use a noref dst
Date: Tue, 27 Jan 2026 08:04:46 +0100
Message-ID: <20260127070452.6581-6-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127070452.6581-1-mmietus97@yahoo.com>
References: <20260127070452.6581-1-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FREEMAIL_CC(0.00)[zx2c4.com,yahoo.com];
	TAGGED_FROM(0.00)[bounces-253735-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmietus97@yahoo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[yahoo.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D0E790BB7
X-Rspamd-Action: no action

ovpn_udp{4,6}_output unnecessarily reference the dst_entry from the
dst_cache when interacting with the cache.

Reduce this overhead by avoiding the redundant refcount increments.

These changes are safe as both ipv4 and ip6 support noref xmit under RCU
which is already the case for ovpn.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 drivers/net/ovpn/udp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index c82ba71b6aff..31827a2ab6ec 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -158,7 +158,7 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	int ret;
 
 	local_bh_disable();
-	rt = dst_cache_get_ip4(cache, &fl.saddr);
+	rt = dst_cache_get_ip4_rcu(cache, &fl.saddr);
 	if (rt)
 		goto transmit;
 
@@ -194,13 +194,12 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 				    ret);
 		goto err;
 	}
-	dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
+	dst_cache_steal_ip4(cache, &rt->dst, fl.saddr);
 
 transmit:
 	udp_tunnel_xmit_skb(rt, sk, skb, fl.saddr, fl.daddr, 0,
 			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
 			    fl.fl4_dport, false, sk->sk_no_check_tx, 0);
-	ip_rt_put(rt);
 	ret = 0;
 err:
 	local_bh_enable();
@@ -236,7 +235,7 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	};
 
 	local_bh_disable();
-	dst = dst_cache_get_ip6(cache, &fl.saddr);
+	dst = dst_cache_get_ip6_rcu(cache, &fl.saddr);
 	if (dst)
 		goto transmit;
 
@@ -260,7 +259,7 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 				    &bind->remote.in6, ret);
 		goto err;
 	}
-	dst_cache_set_ip6(cache, dst, &fl.saddr);
+	dst_cache_steal_ip6(cache, dst, &fl.saddr);
 
 transmit:
 	/* user IPv6 packets may be larger than the transport interface
@@ -276,7 +275,6 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	udp_tunnel6_xmit_skb(dst, sk, skb, skb->dev, &fl.saddr, &fl.daddr, 0,
 			     ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
 			     fl.fl6_dport, udp_get_no_check6_tx(sk), 0);
-	dst_release(dst);
 	ret = 0;
 err:
 	local_bh_enable();
-- 
2.51.0


