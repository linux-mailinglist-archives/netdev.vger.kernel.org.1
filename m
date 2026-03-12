Return-Path: <netdev+bounces-267145-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8A0LFSfksmnyQgAAu9opvQ
	(envelope-from <netdev+bounces-267145-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:04:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 02204275270
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 073B330793C4
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6AD3750CF;
	Thu, 12 Mar 2026 15:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="CHTuYllv"
X-Original-To: netdev@vger.kernel.org
Received: from sonic309-20.consmr.mail.ne1.yahoo.com (sonic309-20.consmr.mail.ne1.yahoo.com [66.163.184.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FA4282F18
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331182; cv=none; b=FmgrUDMU4H6rlVTg7xA8Pu/ULOrGaqpvF5NQYz6in2kAicHZ6Z3R4yiIcuwYOpliyRRv0exzoKJ4tsAPxjMI42Jhj+poK0ialFdfWmSdkfw1LFqFoMnAhhSvjOQcn8X9FDkTZ25Fsltl4VUpvR0Lx5kP5XTr2SEPEKCDVRQZYrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331182; c=relaxed/simple;
	bh=P2yju0hzfsKPCK1bPMyeTuhfa10evLZn/+NZ/JOvwNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqO3UDiu6xxCjlUFuu5d0MDeXajEk/uanSN5es1xWGpXVRc6qm8A60nBBnrAWKXxEoZBkzE9FOp3cfmdAI/OV0mV22kgCkQB2WBfWKS7TYUsdXZS5HX9GibvcpmRPryPxaqK7NNICjHUwUSApJqYG4yRbZ7cmQL1fnZ656T3kvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=CHTuYllv; arc=none smtp.client-ip=66.163.184.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773331180; bh=lRjPWnYNpaKU10v/FUMzLjlztzVjbXcSy5B9+FHVOhQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=CHTuYllvHA8lCp+aFE3ksHpTtm6BmaXek4yYw1j387yyxw5pO00TqtbSfb3+hrGZ2gkXRuWPZmUVM6lM6HXFip5ACfW3URHeint2b8TLT3iBWjWLnD5MNXjkmobMWtedP6KattJycl18+bTlNkwbTyy0v69qcBWfEU5k6TS34u4sh2A5TV7PKHaSxsU9spx+aisGawyO4xEvE2NTPX1ryvm4nTykQn0+Kr9Oj/6sb2EiuyOr8JZJ3j61e5sqAX41nrseb0aNm9IbwTOI500Xxh+hUC/dEhOCrAnY/3zqPcafb2hrAt5AFJ124E95SrRBWxD9xdDgaftwmKDl0N1KCA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773331180; bh=37Fza9Nnm7tkM0NtH8ssYRHsr2/LqRHo3h6+TIdAkEM=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=nJFckG6oPE+xJYZwQJkefib6CZI8A64vE+1YiPBX5XptwL5f17dnahVkWnloSs5THp3Rv6ry/wcO0ShFMy5JAovL5UMaz1+rh2n3AVRL23GmRE49+Z2hgblSm42cnrNn/EloEm7DVqXziHaJl3TBgllQ6HJwOmIbUKqoi7PyGat8Fxsm/XHRDAPk0UnyOv2EA9TCKp0wZp+/N+EUvPIGGKiEYzF43VQLjExEc4Qa/8vtoMzTCuTkL3f5t/8WNJRNi+gCQ0x+WpPz03K6ULDRCSHF7EisDFBeFfBDcKgGvAjbgI4/2prHaBa+sd1sClFSdnJ0sPT+dX45PqtI6it3Xw==
X-YMail-OSG: aIL1CK4VM1np87Jt_HFUqr6w978qnssuE4qP.JentMH.Ze8sueALU88RkYsRYDO
 4iL80RODlixFNj07YwL4sI9qG3dQBH1Bh49Hoepk4e_MoZ1twB6PeeGh__NQhXMOPOEHzaBGeMQ5
 dg5qj_UFvXbLG2dd_4dQtLTgH_6TYQCCiXPSNkIZ8mnqY9eFKZ70SqKdQz1.kwnSQL8eXoxH54CY
 23ZlrfhDNUwxXXI8RqCOo2yY9QOPakbEYAkXM67d7SrRPBgK1wBqs6yuKcf2JU2Xf5BF7MuNigJR
 XzyoXNHvnsiqKZvGY2EtGGqMsTZo5t51sQP3G3wMvOwtvi3PgjP.ES0hDKZaWeRJLhBFzMs8hfON
 WthzVo5AonoX9KO0pkq3OxrkfHn8BM.ONzQ4lzpUPqng4pu8nzJoUr1jpHwkSsEBDax8kyZ3f635
 ciXI27CUb0xfxF_E5FjHXjQKGgh92PIQnnRhPEQwZGci6arUW07ZdE.LcM.cesaJfqpB7uf55X3P
 .32SQ4IizHsaIWv5D52AfHCzwr82Zd0dIcj7cW15QQcQyQv7Wo.okfO8eafexbAasDLdYkoQP2Ok
 Z8oEhA.t_8TOjQb5ydH75Wl4JGJX99jxZrXDYise1GB8Pjy8wERzoENyQJSQL0ysThvHDhIsUjMC
 e0e38mz1ofBKv0wukHGlN6C67DjW8M4XrAM.IHVzrDNDPPRUAUdjjTJg9m_iF_8_Bh4yATtCvwKf
 IFaOFGixN4yyXr6I6ICQFq_sSJnwIpZvXd_3bHhWHPnkgdRMlxDp18kedCXziYK1MaJz.Pr2K5iR
 ZTimcQvNcip7DvmEXX7Whvgx2qlFv0snH7d.PbSa_.cEmtLFbmmisKFbjkE8iLRWYuEfLYj3XgKv
 BUZ_k5x_7wQPjIFRTr0iouRe0Sqip3iPaQPwnTpydGe2ub0oVxMWs01eIUjIdb4QgM1NjvHLJku2
 VnVW60K5SR3NA18hldWnujqyNIbTDSCRWzmteO3w8zsY.fcgaboYatAFJtcekAaK9EFRZW6zZpbL
 n8busyGmaTgbqjZisU6K7BUxcJ6Hx1DfKIQnZ8nTs8OoQc8111uvT.inYongItn5pr3YHf80nX84
 SQck_mN0EZobcDRgcbV.vLjNIBhFFGwa2pRA2YXcb0YeWDa01dkFF_tKdZKEjo7KJm9pzuC6KILh
 RxR.Yf5VgxJredxi2OGS1dn.Zb1e.Q0OIrhnjmx_.FQdnJFDARMmqQSbkj5YSBhkEVPFtbaVfG8L
 OZ8NzxSlDQZZOqt6QPNnGD2OOCw5IYUpQhJ9IgRx9ZYPouGVhPkM5ayGkoaSv0qm04_U0fsInx6r
 qdhHavLMiyByCSIyrkS9UrYanADmi2qSmJE5McfBQEUX5j1Bb.JDzwHskFG2PdDsmsF_jrFMmLoV
 bBMELLGhD2HdTej5SWIvz8qIO8ricuLQWFZFjUIfXslknu5Prg_1UQWiDDZtCgxRFzjqVp4nuVr8
 84GEYHBI9fYSH7hfbEzUVigavm3GoiBSXuVm9yIuIjA3..eyiiauNMsVs6oGyTRoAY4J1M3NfMFe
 IwOdnt5j7pUK5wAKAK4t7GsWKL1LQnRp_KQ0Fqr2D1dI5LTx5BLlt1msGFA9mly.oVTPctMT3uqE
 1L.FVqsSYDO_QOrh1GdsakjJNkoKAuNZribyQ.re5RIeQWJZN.VOhkia2Z9VhkiCur9yTej2rxHH
 QvDv5hQo92llEbHOvCcYx2hvEGRLT131fSJpY6UveBqbx4809.WisQv_iPMQ_RqxF6mTuqmiKr1x
 BNftQANOsM.9tZ_on_zX30qsYXQvdOY0nGb3yU26HQ4jPnqyIAN.kHvZQe7QOzpOZsmlBmcvC3It
 Z3vCmGKy5aCXF1JGzRZ.QM_bngMiD0uhU2izO8rRVyNZlDQHGZ1.KtudsTyYkIG98vVMJeN4VeLB
 SM5D5xj6iTsQQFvqAZU851DECnPdRVMlwTN0dgvTd5nnMKqMNUcYlG71Mvuym3RrBHYfJ7MfvgZs
 kIC_NO7WBdVB_Frip2mj321NA_2R4P1Cr4oiNRCLnwOvF9s0b_m.xDSoRWaZfRAPOfBrFvOGeU_d
 7QvwBYJUx3hurBdu7HmC2_L150_.tMc98nmtpt0YnISSP0KqZBUz7r1mwoxHmyQqW1z.xBP5hvIj
 6zvuZFqgALmVEvlg71CAJicwOQreO3B4EZqbjApr0_M8G4FQ6xVzjQ088.w--
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: e943cbc7-b46d-488d-a38b-0bc50a510564
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 12 Mar 2026 15:59:40 +0000
Received: by hermes--production-ir2-bbcfb4457-pgdzr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 87d652406d88cc03e8e5278a11075b9d;
          Thu, 12 Mar 2026 15:59:36 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v8 08/11] net: tunnel: convert ip_tunnel_xmit to use a noref dst when possible
Date: Thu, 12 Mar 2026 16:56:54 +0100
Message-ID: <20260312155657.25676-9-mmietus97@yahoo.com>
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
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FREEMAIL_CC(0.00)[zx2c4.com,yahoo.com];
	TAGGED_FROM(0.00)[bounces-267145-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmietus97@yahoo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[yahoo.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 02204275270
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ip_tunnel_xmit unnecessarily references the dst_entry from the
dst_cache when interacting with the cache.

Reduce this overhead by avoiding the redundant refcount increments.

When using the cache, the found dst is either taken noref from the
cache or gets stolen into it. To reconcile both cache and the no cache
dst lookup flows to use a noref dst, we drop the found dst immediately
upon lookup in the no cache route lookup case.

This change is safe since ipv4 supports noref xmit under RCU which is
already the case for ip_tunnel_xmit.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 net/ipv4/ip_tunnel.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index d0e8fb7f040b..ec5d5bb74aae 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -769,11 +769,11 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	if (connected && md) {
 		use_cache = ip_tunnel_dst_cache_usable(skb, tun_info);
 		if (use_cache)
-			rt = dst_cache_get_ip4(&tun_info->dst_cache,
-					       &fl4.saddr);
+			rt = dst_cache_get_ip4_rcu(&tun_info->dst_cache,
+						   &fl4.saddr);
 	} else {
-		rt = connected ? dst_cache_get_ip4(&tunnel->dst_cache,
-						&fl4.saddr) : NULL;
+		rt = connected ? dst_cache_get_ip4_rcu(&tunnel->dst_cache,
+						       &fl4.saddr) : NULL;
 	}
 
 	if (!rt) {
@@ -784,15 +784,16 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 			goto tx_error;
 		}
 		if (use_cache)
-			dst_cache_set_ip4(&tun_info->dst_cache, &rt->dst,
-					  fl4.saddr);
+			dst_cache_steal_ip4(&tun_info->dst_cache, &rt->dst,
+					    fl4.saddr);
 		else if (!md && connected)
-			dst_cache_set_ip4(&tunnel->dst_cache, &rt->dst,
-					  fl4.saddr);
+			dst_cache_steal_ip4(&tunnel->dst_cache, &rt->dst,
+					    fl4.saddr);
+		else
+			ip_rt_put(rt);
 	}
 
 	if (rt->dst.dev == dev) {
-		ip_rt_put(rt);
 		DEV_STATS_INC(dev, collisions);
 		goto tx_error;
 	}
@@ -802,7 +803,6 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		df |= (inner_iph->frag_off & htons(IP_DF));
 
 	if (tnl_update_pmtu(dev, skb, rt, df, inner_iph, 0, 0, false)) {
-		ip_rt_put(rt);
 		goto tx_error;
 	}
 
@@ -833,7 +833,6 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 			+ rt->dst.header_len + ip_encap_hlen(&tunnel->encap);
 
 	if (skb_cow_head(skb, max_headroom)) {
-		ip_rt_put(rt);
 		DEV_STATS_INC(dev, tx_dropped);
 		kfree_skb(skb);
 		return;
@@ -843,7 +842,6 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
-	ip_rt_put(rt);
 	return;
 
 #if IS_ENABLED(CONFIG_IPV6)
-- 
2.51.0


