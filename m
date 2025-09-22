Return-Path: <netdev+bounces-225239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAF8B90546
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 13:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB94D1899969
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 11:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360E4303A22;
	Mon, 22 Sep 2025 11:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Z4/WZgAl"
X-Original-To: netdev@vger.kernel.org
Received: from sonic312-23.consmr.mail.ne1.yahoo.com (sonic312-23.consmr.mail.ne1.yahoo.com [66.163.191.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81969219A79
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 11:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758539889; cv=none; b=PyfhNTHeYcfPy2Ud8YvYUuQyIj+J7r0WaUhst+1Y5LpWm6PsWjr0a6fo2EyVyIYChYxpWS2+Ke9XvtKxAa0yRIvZj3IYFh3zKRqttlHyTSE+6Kvpe/ZRNIscnmtiDnn2iR4MnDNkiHoDuctrn2th52A03LTgtngRk4hMr61JiAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758539889; c=relaxed/simple;
	bh=3+F0pvucr85573g0jY2FAOTgf2x6j7CNTU8atBdN6/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UaWwR9Mq39RHuiQxrtqsmQ/cgPZq/PrrIgLjT4cEGMlSHS8s2PEYH3aywBCtPmxiiZiE+G+UHlVcHOMWaJa3J0WX9mCL+6XHpADteAfZNSXscHxb0YsEFaAjvUke18o6l8i9KtszbW2VHoNv8Urr5pfv6qg8oPJL9qrUG9SwtxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Z4/WZgAl; arc=none smtp.client-ip=66.163.191.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1758539886; bh=JfrMVsjRzPVWbBC1MsCrURXDxbMuSWEYSeJAeOyrtZQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Z4/WZgAlInBnYl9BKdKWVGtcqOplB7k7mj7VRx6avWBaxlSai5aQyy8A9PclgbdryN0o7Ey4FsEDUQFJwmG5Y+gut61DxQSDBE6ok3J0cMf1rDRceZLkyZq3b9LF3kqgtfZV1qPKr26loEQG5GsUrfXQ8D9bwAbfo7HXan1cLPAQIWrHfJ08jgPfEaQBg6h3pht8JHs0nnv83F93W3Lx175RHA+DznIOw7gCTceUllAJRoo8LvXyKlmtoXYIvV0KCz8CIlhTbl3FHU8CcIcfBrxKhQbMeyZK/i+CheOfODjDeV9PH07hRuTB9XjX+1+oxmnfoCZ8VqgngAmW62IKkw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1758539886; bh=ESI03GZjoK2JR4yMTH2i+iRjpb/I7WKvtkzcQmf8iuJ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=QxOeYkXBpqjX6JQT3kofhdTrZlfm1bLTNYy36fQ+T7EUfJLGZRSXBbl7HhbCOGLP/Uk74vOuxvr79rL1NYs4kha0OFtonRIt1eYH0tzZ+03sJ17aXlhm9cvAhu7Hld3vQghnRCr27hyIYKQ4YryAKBwhq/BDY5xycQa2IrKtCnE+TxW2PbHB8VgH8dn5LV4CQ1yPsjyny3FaI+4SzbZaB5l7DfSmA32sVHRwXrNLKQvk7uHClMfPRrmFkdezREPKqdGCl2KoJ2iQsIzDg8+QqmH+YPgtumQMIF7ZENbZ9yb0eM8ABPiINwsfekxKwVfm2tBjUKIcxsdQC5Xb5sa6RA==
X-YMail-OSG: zEHXE4kVM1nFQa_bAq3kodU_7.yZV5hZ4q4gHNP628TKeVFEBuj3QYSYCP41zV_
 .S9Q49zPeDK2XfQMsuprEsHGXAaLqluG3mInvVrxy1WP0qIykti5ovJIIC1CqHpdAv7N5QXVkC2u
 GGVrfPbTnrSRIf.XxPhXraKwUkXX1zP8RCRgOuFCu2UQk5B421F6in8xhQNv9S_cOz2OUDCjQZaZ
 1M5ekQuuu2WLWiGc0rY.u8iuqnEWjJ83A5asuNd2kUncC6hrGec2EfztjtR9RXomAJQPBjjtGDEf
 kdLY6ok5hvXBjT6_hTwtQFGIrdSVfTBqtlkjv_f6gn5.jYde1VqI1WQDRvJiU32ZwkY0vWK15gY8
 4th_i3LSL60gFE.OFBHu.naU6kIvvrQx3gIf6avfegKdqykhu8ErxTKIwnHFrL4lOBGk_CXpVkWS
 Qqid3NzMTu9qv6thPni3_zFhN_C91Y1HjUK3SmQ8ZKhSnWOtXolVxL8KP1pAXXvkAUFhg1HTB2QE
 G_JlX6Zjy_E.ohxuwwO_5MG6tzCOmS3j8tnmkbGWJ5AcGnTWN77yxDEgGcQc0C5hIgCHr5tZ0Pl9
 rHtZG4CRqCpQPc7lhhoXj8ikIjzBfTnC4AS.3X2U6noNILqk9Vu.VqFg3sCz0DlTPFMla6AWruBO
 8DfXjYEJIAL3DSShNhLxBgd2KWyfZo4by.kJCEBPVFiCICG0MLgPI6i.7pgN9NQEKVTMDvjslW0l
 Ud1bhbh8BUpYdvuvQSWU2B1PbDl2AgOWsFftiMyCHQHTRzFoagSSSpc8NcIiDfz4BaD8Sy7kHB2d
 BKaiREPdSUiI8RUhwKChvNlAJyzonHhL4C4VRYZogU0EVL1rXIbCL4QuvshE3NAl7ENw.rOAWtp2
 2c6PQoTBFRV_NX3uxPYt1xPLaomYBZHEaww2TD91hrEfYrvUKCAiVb6BSIxhVmNc2PdpC8rPietW
 y8lG5lpIXbNcY8MVxtGZyE4k_uJPIMK6mvjP5m33suCpLeOptYiwVLo1Rvf0JPdMgejsrzqCOtHm
 RVnq898olwYobFRlF1RH1v8pay9IlvY8i9VJPq4575NWl9m3Nhw5QIpRk8RIgaC4i5uJoeEthd8P
 wIPmzb.d1RtmcE3sV0snHaq6HfQDHM_VQ4dX535pGR.w9R6IDgSqCmUyBCiYlTBYITdeivsaD8qs
 S0q1HRhcLUhh.WhM2wT.mZfdLoCDeOBL3XAc7XcdYOu2vEVvYHywJacyhD0Ig5S2NKTX5s_ijpII
 psoiZLOPik04tbRVY6B4e5z.XOUJt1CahRy0xn5QR2QQ_ll56Rc38U9vmuft.e2T6kYmMuI4W9GJ
 FflXOikoZCBi0yvXNMaJPiuK4VR6dTmUJwLU5zsqtMk30bnj90Wc2m0efX3IkUZ8CUnf4peXuxWN
 _xw20cZtkYn1kMjf99X6SWowXbw_RS6bQhQTk73axLwKUO.k4REDU89epVgrBZdOG4W1y8qjI4Jx
 qr82eTFjSK4.cTQCZ7qGM5aatvSw.Ij3STEBp6.Z5_8L9KCHnt4TM5liakCj3jRNkYnbkArPnZs1
 pwhn8LFoYc4c9ccELUmMCx8IFjcCzhUziXxdJ4wn_Gl3407UN.tu3RxFTzz6y29NQvEvRsWtKNSO
 bq5ieCbPtuEDf8Crvhw32jTS6b1He2EbTvOPF4eHT0nMPC3cZKLLpNOPwH18fQ20bGBr5tMQ5e1q
 rDnFxMJHwYvrCFNaVF53.7iYa2yfPPpVwhSxVqrh1Rq5TyFIQFxVKGivjkGy9sIQBm0A.psWHVEC
 i02YhXnTIE2yLhYy8yARBkOpuhhXDjTJPAzyprvcx0ifsUsEnzWjddh1Rl4g52_6Kbmgsms1u8Xn
 UDTjwn.WL6bhYWelEVnQe7CYhU5iUIXcWqvB9GronsYimE4M6GwCbb5ub8QxuPQGk4JtDdEjIOSv
 8iq.BE0E.DYKo1_ShTzE1ZB5iX6B9nWoBRw9CEbSjIW_Y7ZLkFZ_GLa.mUi5PE8R6muvYaNlxXV1
 eMqDkHqx7LpJ6WzXQBdoStrtHpvGy4FntoI4vcPas8vNZvOVOYO9CaGPSyaLXSwj_fYHBDmVBjKB
 0Vi1JMIum3gIkN8QadSBJ8TMeGS8DLLxSXFDQf9i838ef0rNCAJTVr4TsnS_vplruj8d8j8UqEc.
 QBo1q8IRG7JIN52otlXWTYI1YWYT3AywUtFz.gQ9aqUpa31ua8w--
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: c8c88a48-395a-4e8a-a1ed-b394fd7b7f43
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Mon, 22 Sep 2025 11:18:06 +0000
Received: by hermes--production-ir2-74585cff4f-4sjhz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ca5bfbd718d89396be3325d48d68935b;
          Mon, 22 Sep 2025 11:07:53 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	antonio@openvpn.net
Cc: openvpn-devel@lists.sourceforge.net,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v3 3/3] net: ovpn: use new noref xmit flow in ovpn_udp{4,6}_output
Date: Mon, 22 Sep 2025 13:06:22 +0200
Message-ID: <20250922110622.10368-4-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922110622.10368-1-mmietus97@yahoo.com>
References: <20250922110622.10368-1-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ovpn_udp{4,6}_output unnecessarily references the dst_entry from
the dst_cache.

Reduce this overhead by using the newly implemented
udp_tunnel{,6}_xmit_skb_noref function and dst_cache helpers.

These changes are safe as both ipv4 and ip6 support noref xmit under RCU
which is already the case for ovpn.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 drivers/net/ovpn/udp.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index d6a0f7a0b75d..917cd308a7f4 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -158,7 +158,7 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	int ret;
 
 	local_bh_disable();
-	rt = dst_cache_get_ip4(cache, &fl.saddr);
+	rt = dst_cache_get_ip4_rcu(cache, &fl.saddr);
 	if (rt)
 		goto transmit;
 
@@ -194,12 +194,12 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 				    ret);
 		goto err;
 	}
-	dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
+	dst_cache_steal_ip4(cache, &rt->dst, fl.saddr);
 
 transmit:
-	udp_tunnel_xmit_skb(rt, sk, skb, fl.saddr, fl.daddr, 0,
-			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
-			    fl.fl4_dport, false, sk->sk_no_check_tx, 0);
+	udp_tunnel_xmit_skb_noref(rt, sk, skb, fl.saddr, fl.daddr, 0,
+				  ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
+				  fl.fl4_dport, false, sk->sk_no_check_tx, 0);
 	ret = 0;
 err:
 	local_bh_enable();
@@ -235,7 +235,7 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	};
 
 	local_bh_disable();
-	dst = dst_cache_get_ip6(cache, &fl.saddr);
+	dst = dst_cache_get_ip6_rcu(cache, &fl.saddr);
 	if (dst)
 		goto transmit;
 
@@ -259,7 +259,7 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 				    &bind->remote.in6, ret);
 		goto err;
 	}
-	dst_cache_set_ip6(cache, dst, &fl.saddr);
+	dst_cache_steal_ip6(cache, dst, &fl.saddr);
 
 transmit:
 	/* user IPv6 packets may be larger than the transport interface
@@ -269,12 +269,12 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	 * fragment packets if needed.
 	 *
 	 * NOTE: this is not needed for IPv4 because we pass df=0 to
-	 * udp_tunnel_xmit_skb()
+	 * udp_tunnel_xmit_skb_noref()
 	 */
 	skb->ignore_df = 1;
-	udp_tunnel6_xmit_skb(dst, sk, skb, skb->dev, &fl.saddr, &fl.daddr, 0,
-			     ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
-			     fl.fl6_dport, udp_get_no_check6_tx(sk), 0);
+	udp_tunnel6_xmit_skb_noref(dst, sk, skb, skb->dev, &fl.saddr, &fl.daddr, 0,
+				   ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
+				   fl.fl6_dport, udp_get_no_check6_tx(sk), 0);
 	ret = 0;
 err:
 	local_bh_enable();
-- 
2.51.0


