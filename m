Return-Path: <netdev+bounces-251551-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFxIO6nOb2mgMQAAu9opvQ
	(envelope-from <netdev+bounces-251551-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:51:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 676F149CCD
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F8B868D6F3
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD82322C65;
	Tue, 20 Jan 2026 16:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="XVsqPf5y"
X-Original-To: netdev@vger.kernel.org
Received: from sonic313-56.consmr.mail.ne1.yahoo.com (sonic313-56.consmr.mail.ne1.yahoo.com [66.163.185.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5104F2FB0B9
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 16:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926856; cv=none; b=pVxFD9G5gZVnrRD4I/Z6TEavN5SpCe0ejGhNyj1WQLGHbd8XXp5B/cz3HkhvYBs08DnwDLQa+cGfWqn1Xo+y38Cgr/d1vfR/wSncbOxkYSVVphTLaYcR+Iz1m7H48l/y0SGSCjEUQUhX50bv74gwTnnz94CwEyxn7gqZX8oh5IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926856; c=relaxed/simple;
	bh=OyOaWwBvHND5r3TfmA5EfR/0ZZhhdD9apaXkw0UcDzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9w9YHhKZ4fgqcChQzV7fEyeZsHPhIAvFEsRC+MwodyXDieAEmaxMzrVE8EGiPiVEUuWEcGzkNPf/CC8CApxHsxB310+hi3dr3OZxQ8PxkI1vtwOZF0+z0rC2Wj8hJnGHVBCasQirGBHvL0rJ4xOlbTyO4Z0PSPIwpIX/v+Vpyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=XVsqPf5y; arc=none smtp.client-ip=66.163.185.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768926854; bh=NWYeVvUmPkhrr6EVYaqNHPu/ef7X6jiiHaSE1eZ3j9I=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=XVsqPf5yrXmnvtW2YX2pzJvLARk5v2F/scXYsagRB018xcdCtG13t71vvBvSIj5noPvjzJNEeqJ15HT5vr+AYaiZXUg7H5IVdXP0g9VPZP4gOVh2y9WUHeMB+nvhJmxbPQnoHu/wiSQQHzSwlA9mHbO7xe5bHvhUTU/bmson/1oRUlk//i/ux0AHmTRbUqAiEfgoCFLlmuaRt2P+QX2Su4VqGOdxykHp2zqLxtsCxC1ryq6C8oSWFh26oV9DWDPO6txRoRn8ViTiyaflkGPbMEm/TP3jLvw6sth8Ecy0fSXfRnQ3qKICzPc/yyeV4M8CPE78N/rAiaLm8Oy8GN2F8A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768926854; bh=ELjhW1hW4TJISD+NSnemQwo3Ho24Yc+Ska6Xu9Oltty=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=SsVLVYh3RcHH6A5rWe927L2CXNcm/Ts4n+9TSJJDGQJHyH1pWHN7kx7EYlNRkU34FdJ7057OznAAvV39ME0ARPDqAxNGWuQToADLeTUOuYY3/CRSgAkc6JIfYcdwNs4ZZjfJAFk1/YBRbSAw1yw6rYihBB/ZZEAc7W1dgbjaU0ywIvTmvAACzqIKGjiezaV1DeuTQ+AcWsHEmOEOgR7k1nRAccsXTijtHB07DF5Zh3ICFhPkdfWvwbVZUN5ynFOBRagNKNDebJrBU8ObyOD+cvZ+W5Kchz1QSENrwQBAwz8V+1kxFVIaGXi5E27+a6M1TZrXtrBnwnK5gs1R9JT6ow==
X-YMail-OSG: 413JwU4VM1kIaO_MHgVKXuk9bahYeU6C3CT5uop1RNQlGZAMhFgjTdsfyo0qvn8
 VeU454rplSrtdFkqWFMqRyCzhbl1BjUjGEwALR9mw.ypSmsDJ1BZxiuzNSZ8etqCbURUJgPhoKsB
 zyHc1FT1zwf1Dtl7AWBXs2V5t5fziG3A2UEDRmoN3f7dolEPLtLXWHPiH3Y16YjrwezuTO02nP3H
 qp4KAwALMBqTPVlmr7ZdtR0AWBnubrWn27k5yjoQjHAMk3.MfXz_DJXTE00tHRr9tTf1B4IJTfrp
 uZv3R3U9WA06pyaE6p6q2_DU_DS1fJHKG9.GIzWithCNyAtablhntvoC_yKvJNLG0dGuDJ5MW58U
 hwujs3MVEqFTGWIHcSD2BK_8G3MGBTD_DbUPLZboaLI_aU3SCaJUlWMrNt.GTjjEvZDqr0aO4CBa
 Rou7NTc3xOvAuTk9ZPEuUN202WVebwmym.53JiGryVXnF5HGPgvP4_o9Q2Nvdx4CXxbaUxi8eUnN
 EgC3tCRs.3rUe.6gzVpQPuwEM3dIUK.kE5Ecr5t7R026x1c.2iYw.gj6JIQ22f8P10850NKoe_hE
 wn_aQ9pHUDZECwx_5WrXZbk42K3IRcjgD.xsY88yu.cZWvBkawmWIUq2kkc.YDE.4GKvgLXa7w0e
 rmClrTsEFOunNol2ExeNXhacA.U7Y6k3jz4.rMc0PHHpU8BsBjmIYFvDq_R7thOWlDEVQu2iNU0x
 sJzz.M2rheg5_nKerQ5cD59qqITKPaOZeKygnMWXqwAJvo6EkMQF4qEj2Kuib4ujT7hozOiiphQz
 bQFbahrdx0PvySNOGQRdVLgx3Y_9jpg9iAqiL8g0zJmh5DXUEIy94MAoSzrbCJTdtn.SPzw_pyNx
 rm5I24XY1m.hms7OgC0bvwaVYgUHqok5aZhMAEBkk7Zl5adhS7AI512HD05dLsviXtcel43oOIBO
 Y5SdThjA94Nx00dNU0sPPMKE3OM3o5ZL5b0TvIaZ6iRazpptnI712hfultiCnxKTk1YXMXCz1CIL
 3dp6fhY0HPajAm2xmtV5YmifYTyD.eT1p2i5oLs2Ec7WjDi5ab1Qk5GER89dwfdwu3NJGOtSQNuO
 Yqj6Derjv3TJ3o30slBApzWwLrSzaCpIEWEYts8X9rRSMF_sScF3CNXP7YTsAtos8aj5h7Vv4rr0
 4TKAaxS9ep5qwIIhRECZVE1kPTBWQ42.84Zq5wVIzJCX22hjzVhUozdj0cHnjGaB.HJ0eo0O0Imf
 6vijcHrvaxWSkHPD_Cg6az.k5UtC.s5OCeBz3bpo0foMOOHqVoKk2VJ9PV4xM7KE.nIy.tF0rlMf
 kdp5FizX1i1J6.aA7WVUp6jSDSFAXWtdikwuev3Tg8M5wy5NUZhbODu54FSdq1x1Sgnt55KBlzNH
 TL3Y0Fbywkk6BSoQvGdxEZ5JS5pS3DQWHOHkIn0WYY0MfrR0iXqrhH9F0qDSV_ag2r9rYryr1e5Y
 O52i68TlxeinXSx13er2ISOM3fhRQV0WO0C2xyq0OoBjZzggdSTv7IfNFBkT2_9ce_nmy_I4GeLK
 AZVQ98p9THOXQC7ZgI5kkXPy15fMWPukBJUuqWayRZwde2fKMEN5dlIQUpf.I55Hbc8.1PfGg1sX
 mC4fnDHydCsbymTEUJHwDpVlCDnvS9QIoI6xT9qko.vnH53CgKJrBQywOP0pB5c6WSg5dv.VYoxa
 XK1pO.hKBQ4Hj5553rVAQIORKCChYBg6j1OZhM.mZ9pN4XPAtAS0qfG7zpXhh4i7XkLCz6722C45
 0_Htf7rkconJ07TkgvbY1U5MQQZOXPqiYXRafNZxB7bJ8Sde3LWAJEomOW54E57mSEtiw52pvV6M
 SkDCUkqQGvCka6DZB3VZTk6WF2s4rFfcFzbYfnRRM6ptk25J3tbk7J4BVcVELYY4zxhM6qeXtAON
 UPm5fjnjWa7PHg210k22d_mmnjGvuquHls.Mj1Vji4lpodurFkOwisMgI9CFllOXkOWEFyHLL2Uh
 wutD8IuuoP8sjpFFyOHWCIvyIVdJW.a9fk19D1UBD2kCD3UVBffP0mMWRlQLT_6oGRJ6LGZy_WlW
 qX3POfLckObLMsgELTwBYwq9YBJRMEr27hYN2fbMke.eDpItG9D9ga_J9g35DMpaRG_6zzl_QJwd
 1AzGaTWpU.AGE1JS_eyyKbmnnjOS1D6h0c8FDXo8gn2ERcoa7Sdsw
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 19023c60-5bd2-4886-9527-b507e8028b39
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 20 Jan 2026 16:34:14 +0000
Received: by hermes--production-ir2-6fcf857f6f-qlcdw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f7e44a787d022ef3a77c635f4d49e855;
          Tue, 20 Jan 2026 16:34:09 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v6 11/11] net: tipc: convert tipc_udp_xmit to use a noref dst
Date: Tue, 20 Jan 2026 17:33:48 +0100
Message-ID: <20260120163348.24248-1-mmietus97@yahoo.com>
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
	TAGGED_FROM(0.00)[bounces-251551-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 676F149CCD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tipc_udp_xmit unnecessarily references the dst_entry from the
dst_cache when interacting with the cache.

Reduce this overhead by avoiding the redundant refcount increments.

This change is safe as both ipv4 and ip6 support noref xmit under RCU
which is already the case for tipc_udp_xmit.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 net/tipc/udp_media.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index ba4ff5b3354f..cc1ef043aaf0 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -175,7 +175,7 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 	int ttl, err;
 
 	local_bh_disable();
-	ndst = dst_cache_get(cache);
+	ndst = dst_cache_get_rcu(cache);
 	if (dst->proto == htons(ETH_P_IP)) {
 		struct rtable *rt = dst_rtable(ndst);
 
@@ -191,14 +191,13 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 				err = PTR_ERR(rt);
 				goto tx_error;
 			}
-			dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
+			dst_cache_steal_ip4(cache, &rt->dst, fl.saddr);
 		}
 
 		ttl = ip4_dst_hoplimit(&rt->dst);
 		udp_tunnel_xmit_skb(rt, ub->ubsock->sk, skb, src->ipv4.s_addr,
 				    dst->ipv4.s_addr, 0, ttl, 0, src->port,
 				    dst->port, false, true, 0);
-		ip_rt_put(rt);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else {
 		if (!ndst) {
@@ -215,13 +214,12 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 				err = PTR_ERR(ndst);
 				goto tx_error;
 			}
-			dst_cache_set_ip6(cache, ndst, &fl6.saddr);
+			dst_cache_steal_ip6(cache, ndst, &fl6.saddr);
 		}
 		ttl = ip6_dst_hoplimit(ndst);
 		udp_tunnel6_xmit_skb(ndst, ub->ubsock->sk, skb, NULL,
 				     &src->ipv6, &dst->ipv6, 0, ttl, 0,
 				     src->port, dst->port, false, 0);
-		dst_release(ndst);
 #endif
 	}
 	local_bh_enable();
-- 
2.51.0


