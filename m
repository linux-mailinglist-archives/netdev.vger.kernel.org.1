Return-Path: <netdev+bounces-267152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NGTEKPnsmljQwAAu9opvQ
	(envelope-from <netdev+bounces-267152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:19:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E36275752
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B65130635A5
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7153F7872;
	Thu, 12 Mar 2026 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tIJdMobY"
X-Original-To: netdev@vger.kernel.org
Received: from sonic313-56.consmr.mail.ne1.yahoo.com (sonic313-56.consmr.mail.ne1.yahoo.com [66.163.185.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B256F3EAC8C
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331743; cv=none; b=HomFK6SyAs++wxG1bJkzodcNFMLRgbKOPdkF5yrBlj2UcKrnfwuN+kHvhzi4T7xwOyXm7z+9V6RfBZ9W6F69jF0dCMB2NpATiAIH1PoxXv1l58qkoDnuUd0MFTfDpHX8no/Q3JBewhSRXLpe8PZgs60gnKwXAzNrPt4c3lXAtzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331743; c=relaxed/simple;
	bh=Mu3Rk8+MXl7mtovQC+JmV28aCiCbPwZDPXa62uywPZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMDi2F/vTwms+fa6LOkc3QM5U/zyyQgt6YR68svvRsA1wIPmH82NDNTemmkWlMg/9bI2Dmh0Tu3L7izdYrAeo6InoZsrC50duQSzBuohjX/DnjFlvp35S06dFyp/GaAAwNKV1wOGzp+XyHsAdTOxazJQAJINPmBuKm0InjNWJzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=tIJdMobY; arc=none smtp.client-ip=66.163.185.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773331740; bh=Dp7Oa6cKqpefFf22UXZPaJ4XtF7LuDQZAKLjG8BesSc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=tIJdMobYEC13DzrjlijZcAbbcFbvGXQhSnx6nH8B9ry4UAwWdrir0UpuasASfkZ5pDYnM9maMR84N1icXJyDf710ymw7G6SH7tMzpzCkj85ozw2Tukm/wiN04MycRq7KDrNMmJKN9KD80opiXC5BkIKXV0q/veHR+zVniv1Q5OF74Ztn4Sqfx9iFN/Xrb+2H8iIlIKUqMWYAWd/kYvXEKXbZl1nMwN2/gwWlWwVQ7eaeaIhAM905ovJidmLJPWrUNkALslwBT1NCyHJXnHQSqCF66NEuRgQZ0Ow6zttRIZIN8jNWYyLrYJjczCPIw6vUGzXELdlWghaqO1t2LO0S8A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773331740; bh=T5zaOWST/jdw2/dcUu2h1oEMr90dX8KowOp4pSSNT+m=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=KSfk5PdyG+8UcCkUh/GxPTresTplQyGNGWR/p3DeJiZWfs8Uy4tFMVO58BD5UJ2WKmteIAj1k5gJvaWKQH4D4VHotqIC2bdUrIFRazIxjWpzPeoqVLlqAWFo2rwa6L8e2T2O4ZN1Fkx4QtId7vJhWSXMfDh/vSVqIB1y8fX5EdZcIi1Sus0OCo0AKrZeE8zJ18BczTdeNrTONiz3TdbpPAt9gQ2BQFAJ7rWJWPJJrit07AMDzXZsEnoP3Ro4JnFWSJ7ZZC6+uFE8SU1Kkg2UNEMNRUcM2r8AZyHWL+RI80C/eCtrCVgcJ+Ka2d8CWe1d5fOde8h9n0LfzhaLngFBoQ==
X-YMail-OSG: hvfyh9MVM1l7CKYr.Xm_0RQToXy9inW0DqHtHo8cZp4.DEGCsqFIJ3vDYwy3BBa
 zGDjQygvMJaRU2rHJxLudriYyIKdwJe65egitGZsPyh.TeUko8DKeRUsCv63D5Rs8QUYyOORC2GR
 c5ajFWi05m6eLL7ByzfdL7PgVrdvW.YfxZXXzV72EBdw6TaioJOaBucczbJP9SCKur8Dr0FPnTTU
 U3mOmMzZz2e6stkhbn9YizO7vdTVXwMsyuK7l6uiIjIcgobRrHfWQPYrhHsyZCnywTGJUAEpEPXc
 0jJU_To5PwOIe0lPaScsQD08nskq1REf81TEDrfHfCJ9IThE9R_SE1m4ZQ0AJLjysVC1FupSgxEC
 dX4DF8K0dD38gdD0Cfna2qjAq8brxkmGW8pE7Su4JZfeNbDTWHj41kVburGvRW3LBdf9VRnOkOTB
 c6plRbWkwmTVzq_tYQY9yaFQUwSn7Iq0soeRmHltWWQnzvcbw7gDVKELVgEPG_mMoQejFsiU54lg
 TS5pKCkmUbSSNXjnWcHvZbTD4hqvY.NLE1Rm25zmvRwC2OLVi5WldfhTnn9m9Vg.2YnMzHapcdjz
 a6PzAjT_qXbP64L390w2Jg53utckBEqCz3FE5wPOKArUJdeQCye57IiIkJQnlyRacT1QpVbPcTHD
 rrwuBKROGkwk.9jM4ngl9GhCTDkwkG1GpVJ.ebz503mCwRibzZf1KmIMtjLKFUx83MDf82zW8tHO
 z3VjPVTzsKs7rgfsPjH_6AynONmwEHTOywNvG4bAUK6Yq1YFi2Q6_BL8EPtZy9UgiJ_zIOwWZnkB
 Z_RLfDOYdiujzmRCvE6YT0GRIHQqPkOWg_GYDMTH2JLlBhxRMt6GZeiQrGJfdMMxGWQAUpgWydCZ
 8O6z7SxchTuCKyTj1aQFnSdSCYsg5e5gXxuHxReUK7QFxv0paYHpZyXPK_OLc2HQKEWW_lVF0KpY
 JQKOmRRVMYeASOyQ.L4JhuBeCGnfmwCEsDdEJOFsMiov7Ycxs8D14Exe403vDQuvxiOQ6GRao1Sm
 AZaSvHA7kcUWqO4t4f.Klk0zFBAynCysln08s6U0maHTjQ7wOSN7DO6gzkKOHgfqdvT_pAoYfZ.x
 tTgUyAmuN9ieMEQnUVTO9Ha8bgFVAGrdTBu_M5K_0jZTpMXWrCKN9BZbKZUZbBhl7qxW48XDjCqa
 YM5iGNHR8i5jxWk5cJs43fV6hQCtc2JkwO6H4Bjp32xT_VXSNxdZYGyNxf8JUuKs4gHmUVY4mj4f
 UNcuhQPsYP2mA3fUDi7Ib9C6ZTcooxMj4KboAP64z69p3CTW6nEbcL9EAd1Z1cPvGHnfQgDyZhRZ
 NWJbk7N4wiRAmWEG7_xD.oZt1IkkoP0oWxLHiSwkuGyombbLGBkKupcqOgMISUnEIHaLHqt3pQGt
 hjhebfrExbZaXkqHzMLY2m.PgJDCweet7jc7OO2CCHSrE05Q6l2DDYh7QA3sWrfDpuijHCYQfl5k
 wcxiOhmd2Y36Kr3ztiZYnmOuQbRL9DTigzLHWodEQ.bXQdso9Bv9DA2ayPCZl8XEzhbdw649ZR_r
 47DFwYS_QenQLRw7kAXBYk2.3ztRb8w_qOZwGChDgR.ql9yXQ2jeK9nyZHdauQ5K4zpPlQrjc1zW
 cmRw8FadlS3cSfD3b16_du5otkn0IvDx6SM4B2k.RqLTDRrfFZFBckba0K28r5_GPwcPtw4oR0YI
 nNloHCt4EnfTq4yqeYlNcRSpCnULeUKiVU.aGlTZhyOZKoHjjtLQa21H2o7QGiU7.1n4XkFnmqAZ
 aj64CpzNWwQJaPDeHMykWAE4bx7iAbCWNrMTlNV0TOpmHoy_iRTB7Kdgh2sfeP3dp4kVqde83YWA
 x2hj3hf_GJTiU88H0ZhqfPbdY8UXlCpBud3gYLTE7AM9UIb3w_qK3yz4I7razlQIOC8cL7pW.3rZ
 1u.wpYwINrwykvDYGRhjD_.XSuprN28FOGJOrvshbFHIZH5icm.Y2phC9n4FZx7OVLBG4TsdW5Iy
 VgWhS7VmS3fUoJ1gvYGc07_YBwgGKufckh8hWc34ElWUO2rIuowjE4xtFVVjOjnHBxc.3DEceV88
 R40RpMhfI2.PhJR37rNkPBgl8rgu73FF58IBkQsPbIhTSdcgLgBXMEwhP4Iybe9y7LCuG8bGXchP
 1_DhqJBS1LDguhMPX7kmoBRyC2jFGRfeAYks_JRzpeeSlKM6LtiM3iRlnF3M-
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 808331e1-125b-4ba5-8fe3-b08af9a7c52a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 12 Mar 2026 16:09:00 +0000
Received: by hermes--production-ir2-bbcfb4457-pgdzr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 87d652406d88cc03e8e5278a11075b9d;
          Thu, 12 Mar 2026 15:58:47 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v8 05/11] net: ovpn: convert ovpn_udp{4,6}_output to use a noref dst
Date: Thu, 12 Mar 2026 16:56:51 +0100
Message-ID: <20260312155657.25676-6-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312155657.25676-1-mmietus97@yahoo.com>
References: <20260312155657.25676-1-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zx2c4.com,yahoo.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-267152-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmietus97@yahoo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 43E36275752
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 2e202bd2b73f..d2900a3e96ac 100644
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


