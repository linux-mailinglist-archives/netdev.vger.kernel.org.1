Return-Path: <netdev+bounces-253728-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBFiBfZkeGnTpgEAu9opvQ
	(envelope-from <netdev+bounces-253728-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:10:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E286909E1
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77D8230465DC
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40A532BF47;
	Tue, 27 Jan 2026 07:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DMT4vEAs"
X-Original-To: netdev@vger.kernel.org
Received: from sonic307-56.consmr.mail.ne1.yahoo.com (sonic307-56.consmr.mail.ne1.yahoo.com [66.163.190.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854FB25CC6C
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 07:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769497772; cv=none; b=E1JToU9gee4iCg7R+d2RGYhG/rfKqQ79w7lrF3ycr4MUPS/FQS5jz9hx9YP0mYdqKqWmIzp+n/+hN58Y2FXkBb3RgM2EvWnWcPnAOozhYJQfaeiWYxqUKivaXASNeumQSEnwBv8qzCm0M8566yp9k6BVVfWQIVFDYzU1tSt4HyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769497772; c=relaxed/simple;
	bh=OyOaWwBvHND5r3TfmA5EfR/0ZZhhdD9apaXkw0UcDzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEWF36d0h2Ef+AggjkS5giU4v94sZylMoeBDvlk46YNbxE9Apnh7HCLKeOIK994NijN6Zkewv8PA9kqiE/2ZSFCgUQS1IQoR87YEOKxqz8/koolYKwk1FEWdRsNYy5aQ1Av/9G9CLTuSdttYyJKs3QDqDOWDe/38kpj57sswUhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=DMT4vEAs; arc=none smtp.client-ip=66.163.190.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1769497770; bh=NWYeVvUmPkhrr6EVYaqNHPu/ef7X6jiiHaSE1eZ3j9I=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=DMT4vEAsea2/c2543wsBfOzH9PjzTLgmXOsQl2d3jJvGFjD6XHEhY6saHlWxWPRHBbrB7bSaSn3TKbvj7Jx202b5hkl7j8DjQSJhe6ibwhXQrRo3pyfyDV36pPJPRS2uYCkaA2+x08IFkS5vzvYQ4JYii222vqIvKy2fVdpWgubRi2jGVOy5L6hD9BxmXGMDSn/GJS8nNi5bkFFEfw4IuavFeBf57aqs+BD4OsKOJCmn1im3qQEV5ihjZoaYf6o4odwOc/oVe+q/YWqielDpSeYEgWEH7sA75nVGSlQMQt/5hjCmSLjXfepNBrImBu4G5kK8MacjcdpdvsIpUmo0/g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1769497770; bh=wO24JOpzVi0yWp4J+rtd+GXfDp5U+sv2hsTG1OFKkkX=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=aNlvpzxm5CmYmcl1CaRDhjmGTUPfnB0aHKlphZpnGGEGr0+WlyFjaWEJhwwSwUnDlmfqtdlkiw3bXXWuv8uyW6KumWOetG/2fymUixmusCVhf5Mw02eHjccI40EbOqrT09dPYu3zF6LhJQ0ChD/LdAabUqGU473+ipATxZ+O7iXGnR5wbIef0pEZSmGZfTzZi5omIyNLiGuhRKh/ImQ7/tPY+bzapDx0EEcgSr1hUVR55An8Zid0f/tzsU7+KZJYREiEVwZjs2JWsgzOHpe645d+ABv55x2m9leSDRrTyyo0pBJnpHro40cD5I7eGXt+7EaO9dhy3iN7IDXJyvz8tQ==
X-YMail-OSG: QZfnS54VM1mgSGy7yQ4GIP02o9I94bwkzoGeuEPAbh6Yfge2EjfvchkVX3tPyKY
 VjW7Ij7FThCcBvKc1mRACPBoy6LpS3W8p_0j6dHpr.mzM_MJVY7gITdAeHNx_AOwBnegzpm3cmmm
 owAN2h.eTAgxwcLh9wN7PSS85Iw_d3zMRMdLdN7H5dJs_2McEnVB7ToVpDrl.p8AxWYGX32GfGwG
 EQKRKglQaaAMVmS_0e_CqcP.IyLxpuEIZYU5TeCJ3zn4E3pTI5sqJVMz9bWWWdpZMTfyDwH592BU
 AehGJsU.DOc9ksZ65BzQOZUY.1LmxzQS7FAejsGK_Tl5MRap94QyTPva91TD9p7CV858b7uPHjeB
 v.HNMEf6SgZSZM3ix47u.UJ9CMFKRTJ3_FQ57XDrNX5zeiT_mqnCzTjzcsdAxbjEidWK0XaCFD4F
 4UT_tBdsAODf98PuKoHCZ.xzQ1pkVLQDqROU5xU6rB0suQzQjoYXywAAOiQ_BDsDDs6CzywQ5fF.
 UxudbCjRBHwEnk69COxm9ytKIeS5sgIwL8uEjXb.m7VyazO4v4Hu134PaAznnc0WEw_nMwgKVNN1
 lL_CL3DghovUpy1BigwUsWAK_o3FjC8yOrgfdeYKZ2hL4BIwAr2oTafFaEKaRyFwWwSUpQWMXYqr
 Q.qTgS4pPgdqnnp4JHMh212OfZfaYJa00YOWucrDd1g0RyBfnf8nPncIY2wAjGM._MmbT37TxS9L
 8VPhnWwOdB4LyVfj2msC3ahn545h5x67txUy7jUVy6inmpaQsRhYL1dSMwe6DgQJ9P2q1WV18A6q
 7O_OoB5cwP9ixrNASJiac32vF6qe45QWt4TzmFknW18c22GkJV1TCGxEqJFi7ot_LENL.r6EEFa1
 1gFDCJFNdU_bn.shZ_FkCuUixAmaGwPi0spGFsHwHf9A.5GgXVP.hS3PEDOvDqt7Z6UsTqGExXVv
 VoMev5DooCZZmCluslMa18sa3bvqRhl09Hlu2Z3D5PZSPfgCyAsf97XLVs5O0UNcW3s5PQ.KDX1n
 Am_cLhq0up5hKe_f3xYiKbq7EvK4wMPZpmoR1tx1a2nuG9o87XpofIhbk1F.WZXzqnbXGjEZxSej
 .ay.BNw3Of2qSFJTGfOy_MbaEvVwG8CfQrBoV_WEPXx2X2bzMChOf54_4NcPPSdtOy6C31rA7Viq
 SmTRhf0yfC.A.v3pBhNNB52R8wbdNOqtesFPOnaF109BLb50uOHBJA8otw0AjMWsxNBoZDD8zh0.
 9TFUHW9JD7qRqKgST5td0yiKYgyfZNNRVBa15WyEq3ikH1tRVy8vzDfNcWEouhg0C8hAqfofHWRp
 hr37C5S1XbdwkMS6gOXOuWRHlk1i3wsdHaZgD9DcNSI2ALTn1zi0dwHDZlaKTiycSiUP6Plsgyof
 rGWGQYYSQ6TS7Y93p2xrWb.3e1ZzNr6TXhF.SR5B2rGBBtNkMDUbJebr47oOogc3w0lLy6dd1JBe
 JpOYvnYqupmWc9GrRsULaGfrzX9fHdOTNiLkcXvkI01lkl.lcWB9RMoTqHBXXo1SsmG0nqrGrF.F
 8Kr3SC0pcOVeFZcja9qzQuvb_vrxyNf0w1_Rb34UclcV8N1mXnSeUcgIGOD7GkHhP6d9FhJ2T59.
 PWWKOHWP4RCGUbWHQNvu9EGuL7nKpL_zIFMVJuDBol8Ke7Nezeb4jIIGhY8h_u6CCkEicQBjRdUT
 rqKK6O1XA6CTTsjeM1ASa9g1lRmI41WblR.VBFV2yoVaycqWqJa5zyKfgpQlgk1Ui.7c3xvPlFTm
 YX1mBl3yjn_PbJ90uHezTgZSrBZHgqEKHuYuklERBJsQT1qWnmQx25eqkP0h2K9YVnkl7W58GawL
 hpNsrp7zTrKbptorcgO_hlAwM9z6uebLmj3RiydlF.cgeTAHmdwodg9Hw2c0gS7vCxMnmDTS6.tu
 OozZLe_Z_C38aHnYDZLwoZBfqBfvyfpPd2rJnTPta__jvVwQ4cNXCMENnhrglf1LatlCxsQhWsMY
 yYt3FYElBBM6R8mEuIq7Vkke5v4gfvQk3uuVgJ2lxBPFImZqGD3beqEDsJcxFOdZ3drrEN6duyZ9
 gy28TdbSmanUKkAk4Cx.aWmB4Ipr2TC7Hp10GZGvw8_25cxFWpTPMde.my2C0IwHXSe3tooQFcZ1
 BhYmfRZO.54u8MGZsxgo3F6jZydfS_zCK.3uiISapH945C44-
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 21d8091d-7a2c-4aaa-9141-8e46ca7a1c00
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Jan 2026 07:09:30 +0000
Received: by hermes--production-ir2-6fcf857f6f-gch58 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 84771875e54e61ed0bb89230515c8a5a;
          Tue, 27 Jan 2026 07:09:28 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v7 11/11] net: tipc: convert tipc_udp_xmit to use a noref dst
Date: Tue, 27 Jan 2026 08:04:52 +0100
Message-ID: <20260127070452.6581-12-mmietus97@yahoo.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FREEMAIL_CC(0.00)[zx2c4.com,yahoo.com];
	TAGGED_FROM(0.00)[bounces-253728-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8E286909E1
X-Rspamd-Action: no action

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


