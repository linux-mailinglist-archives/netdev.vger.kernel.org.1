Return-Path: <netdev+bounces-251554-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMrECs23b2kBMQAAu9opvQ
	(envelope-from <netdev+bounces-251554-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:13:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7CC485C1
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 18:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FF5768E8E9
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC8143CEE4;
	Tue, 20 Jan 2026 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="OUHouG8T"
X-Original-To: netdev@vger.kernel.org
Received: from sonic309-21.consmr.mail.ne1.yahoo.com (sonic309-21.consmr.mail.ne1.yahoo.com [66.163.184.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3C943CEE9
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768927030; cv=none; b=YbopVR+6kNpivPqpALSmg18XrxkDn3ajO1xGcp0iG2nQjHpw3w+F6/LvG4a23luMWj4kJtAT/cOkcHRaNY3eBR6UtlLhMLZbn//QCovBh8Hyz5v0JDdp58tAgPY8+ZgNLmgL6N17mKaLvhS/4fgZ74LCBvbAXF8Kp6UeVnKV/u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768927030; c=relaxed/simple;
	bh=9BYa0z94Hmry28of+u/2XQStTBecbGfiYfOBNk/CBmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jf2zQizQbvJrvtAmqIugOXFa8PgHyOo+HUMPHZt6w9AatFuy6DFtaUh+mefjLHP1sOUIsHLeBAzZZ4uVYhI7ZYln1A8TunJLdVMPP9vN0lXzavclLw0zxkENxFXypW3sAGyYBXOBWvg6/eUMeLd0QHM+Bu5r+s7DQU3gjarWXzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=OUHouG8T; arc=none smtp.client-ip=66.163.184.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768927025; bh=zcyjbB29jfSRIhqzAHiuH6pP28JinZ5meGFHh8E0HGU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=OUHouG8Tz6W4MLW3w2UdnZJUoVDfFwTPtBp3kMHKve8C9BRSHaZPNG284jyaUMLfCjQzOU8pbCygyZ+jLbMMcDXLjF4QV18/oD6AHKK/oAv0mTv3rcObfhIu5CBL6dL2TLLbhmp7QfBnZn8r1fXzgae+cdLB63QIMfHwuqplNo/ydVWmnD4pF4axJHyAItauArhgFtno9ijT2mVlFiAgb0+QYm1fIr53w86XaZFk1q8miHmKI4Uf3CbRr7u5GkNI10fxG3ev2pihZGmcDZ72My5hKRYmKhnynTEmuecNEuI6RtXetogO8UvDhHt/ZSeNBEg+wS0Xmoaq2ftNcW/IQA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768927025; bh=0pWfULvnqzZMGMkl/GSprpzw803ZO9UHvB6s6xxpBCt=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=kZCii9C4GMj6WvEZhE2MrKrc/OPfqpX9WP23aol19Y5pnBW3F2qRoJNAykWhUEFIvKv4+YIiywTw2ZmSLZjoJ1cOOhzg7ai/b1KUiChH6KpeO/W/NQx8Pvo5xRWWNP+pSG+LgEQM6qV8viJEJoJwbN8nvkefe1jQtJeCljTFpb02vjiCQ0UJoFgzAEzpcvnCyPRwWkNSyqhScF8jp+T06L8KQm8dRZr6HrmoW6C7VOoMIORjEZkqfgLUgX0IILzsjKXV0vK8tLpfZygEvJwLcabbN9LEhAfiHLbG+VHvMo6hUXqY95KKE9YncfdzRk2MQ9PDYs3wx6VFl9PUP8esDw==
X-YMail-OSG: owQ66hcVM1l1t1j_q.wykmvnISqEe6RSI0Knvo1BQk8CNeUpo5y1VISuUbQMKq.
 mmqoyb7M4f77mu0qkxx6jo2VBVtVuoo4oKefTDZLqj1xEnw_ctiMKlhVrfTbYDJ8BymDB1Tg0KEx
 oOXFQw.to_006XVjk.yIITRAuXkjQ8epLQTKY3sL6FMsVOv3CMNZQgrHDohgvByyUClp5X5AFAqK
 GP490j3PnnTV0AJwHDtEFR9b40OdjiuRFMJKFQK9aAC3CQNpMiiY6iFCRO4IqX0Qa5tbOSNcpD7d
 pbvnOOovYSdLC3nqZrM.WVzSQweix7lvsakTzpdNmsP8jsVljeh3r528Y7yHDXC.IUZswjqOx1fF
 GXpnnkZo_kOuXLftiONc2PMEGJ4LphLboXRwglpBYyLuKNi0Ns84cYbO6bmrnRGT4y0nASfIJLC8
 0mGK.gblGbp6zRsAzHCtI7U_0etWbfe_DxKE1Nt5SmBJQaZyE_x0kytODiiRSBKQ6sAUGMf4Rr9_
 X64m9T0jisPN1HwC4gK6phmm5GVKoVeOZ72JeImDe8fyPG1IQg3ep6iZithI9oY4BwU.uZ5lSxZu
 Y0ZSa5FVxALVTsWi2lUWUj_7ppQEufvX_9anVTdp5ebiaN2n_0lV1WjzfaPybpMdEIKb_IrHB6lw
 3kRB9diysKTOFoRM94Pg.47ityPoDBXzsofg9IFFkEMTMvP_t7Sy4IUvrrBURY.0fc52zHNmFrRe
 _Yso77qWKo0DzPj3OnTThFAzBccdWIbLukrKOvMkJw9Q5o.Ckoo9FFHiIp.jvlGNYfQdchDRj0mI
 rJgAWFX6vnd2tr.H49V38kPGfEs85EMNCDMhNtiiAeNe3qsxZfxDsWQOrRue2IMxTivwpKPt8nUh
 cKjr_ct5OXd1i8AWNU6XvFAku4VnRdFmT4iCFx04ihKfAS_aGxsrI7tWyqqvYPPLqCUSI24ehCxF
 9P2CyMsYrwalMGog1Df_fCeTSB1PCFw_5Jo9rVnz09bShzeLz9F6DpTlBRSI73lp0dtAcvrwQhP0
 Q_VavYnLhYtG7LacDyDC7czxetfEEDRnvUkdJr3L85xJk5n.9V9p.KKO7jz61T6T9GMvqgOQoLQW
 xK6iPkJf0Bq6o2a9WCcJgf8eftCasIcsxUxlu2nLFY0Hs8yRLWHSUoLqBRFrcVgH7lcCMdp40NSp
 V83umbiUD7P1QmuHUd.HmqWq1Ogar7Yg2JwK6gU9CR8o_A8mIJ4SuseiGx6MLOKppdDzEwwo7s6b
 ZhIxcRvQGiYG_kDB3qUHQcszXiRP1vF0jcW1xPUWH8myIm7kVErLPSB9I94mIjTYJOyVsGaBp26K
 WKv4YSt_EWyzjANNc_dNInoJcqvaGeALelraWRpC8nqTefihxI4bb6tRK9g9uCOlKy4pXQ7ONAyo
 pdK3XVw0YjZOWjGC8gPZj86xWrHbCCGj5n6J6mDsUBl.V_v7wgsLBtWcAIPtpP4B7QEnHoV96.cT
 eIZLsqFBj88OCFLsBiT5BSdnoZMqjTS.PLs2pmpKVh2mugfVBucCOCiC_MSBsJ2ItP_gFFn.oq.5
 PqP4lUAZ9hEJ6cf2RohOlS99wD0Tdvr9ADgq8dg_ry1JNRjQBRGLsREq5OP38U1GFXmSek0IMFpF
 oWxe.kJyuh2IExQx5oQ27FmGK.GDedP_mUD1bw_WroRXiM8O4dy0OO97b1ZP5FsgSvfhr38mLRRx
 d7kFnjD6Ze5uUL_Mo9jq7y6oErNup9ybfyngKlz1ATrknKdxeJsFc6Z_XJVhIczNDfhjXTvyZd3k
 23wRa0lnytrGbW8cfVmTmI006PrLik5pQdWDE2XL_g5CqCOHqWNSvBWyktPOhwsOHCk1qv0GmVE0
 5LmGIzG5yoKnPgQzrQNy5YH0a15JBqGUbma0LVDneETsNY3Wjnmv2AH3OWy7DlV10TdxlYeEGhUI
 XsUnaxSApDjriyDOmmziA.VFEYff_L6tXQ__2xGv2VopsO9ZUgoRFP5PSMLFqMND5n72qwzy1wRA
 Buvdx66NHjfazUvavx5357XDrWnxEXK0Rcvs4Krzpyhf7C1Pzs466WgIEASb0pU1r9_EeOCXMq.i
 e7BqNRIT6OxDAPVxqm7eJLcSKAfyE9yzFzgpvD9qrOy_7qQAZm2mPvpq1bKb_Vvv6vXzV9VZPupd
 w3ij6.iIIsSwRGWm9XIWFOsm9Mfir3R7fI..oDuob63K4dA--
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 9759ebd9-77d7-41ef-b697-dfbf6a364b77
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 20 Jan 2026 16:37:05 +0000
Received: by hermes--production-ir2-6fcf857f6f-vw7gs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5c743ac7fc5feeb5bdbb197ea32f25e9;
          Tue, 20 Jan 2026 16:26:56 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v6 05/11] net: ovpn: convert ovpn_udp{4,6}_output to use a noref dst
Date: Tue, 20 Jan 2026 17:24:45 +0100
Message-ID: <20260120162451.23512-6-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120162451.23512-1-mmietus97@yahoo.com>
References: <20260120162451.23512-1-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-251554-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[zx2c4.com,yahoo.com];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[yahoo.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_POLICY_ALLOW(0.00)[yahoo.com,reject];
	FROM_NEQ_ENVFROM(0.00)[mmietus97@yahoo.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 8D7CC485C1
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


