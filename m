Return-Path: <netdev+bounces-251553-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNEcNQLJb2mgMQAAu9opvQ
	(envelope-from <netdev+bounces-251553-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:27:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A295496EF
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2640968E58F
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDE442E004;
	Tue, 20 Jan 2026 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="W02xH5L3"
X-Original-To: netdev@vger.kernel.org
Received: from sonic313-56.consmr.mail.ne1.yahoo.com (sonic313-56.consmr.mail.ne1.yahoo.com [66.163.185.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B7430FC0A
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926983; cv=none; b=AmYnQJviF9fiH7H/YeDw+QPBy6UQNhu10PCY/jb7kJk8yZg3wfqxndshKmgUicuuaQ8OvwkkFNsxt5tAfEi+dJZR9KUQ14yAVvnm7KnbUdGCw1WOWiBa0wGdcbIlXKLnyWaKYgT1gNRdEMZq+NIdvbnYtzs2fWfpUl6JJsKLGTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926983; c=relaxed/simple;
	bh=mmwF872WJ3HvCKY2GANe7XIMs9mVYxUCqmdxIzkhuqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fLkDFdF8yrtQ/G4ExWnLb3+oJwnV1s1IxQcTJUe1jcMd58Xdjg4pAEHOCIrkAjWJswubheAY6Iki+pJV8w2/igu+ew53hZVPJ3yn0BxU6Fcovhoe3W2sVHeqrVJ8q2KhoULGLDqDM9qKafozexRXWyv9Fmf+bfvlfJXfJkpoPl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=W02xH5L3; arc=none smtp.client-ip=66.163.185.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768926981; bh=NKVnuKCkWmXO6Dqj62wCTPcVHDNZNOLsjwA9yVeG1BQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=W02xH5L3PNP/2gc5MUYTxQJcqtMbu0uSj5SvILNxUZ3Ks8TCjO92jiV9JIbatVPMtoHe8uExW0hqoKRaj9aUhwKzpYLLiO8T+wVJyyJjC7fKGH8bMCwFMqK6Q6WBbR0cqL1F7XzAzqQHkrrSlNNzfm27YtPxYMT/SOCteTF8PtXwkiHhb6aEVYciKnYt9DogEynTAi3ILnfxxCFKJdABgW/BjDCMd8uiTi41RYhy/O7OLh8fsBFw8vY1wxfC7PDHha5diXATSnh/rpAIdY5tqPA1Fh7Ic5kZ0y92R4PXeT9nLhgj26Vimak2hotUej6zu4KMZkot+1tD7tlHNME1fg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768926981; bh=P2qh++fV+HSCtdQvKqHE/u+IrMxDG5Cxs4/NvQl5ZD0=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Nx23teZwszrI1u2p/58+06SXzdXwgy+yMT6A/dU16SWqSsK/10xfZuOGvcNTKP9qfbYtVUhIOULWUGPSInpqOizw91UYTsand0nkZkOJkpYG5yl8RdSJ6+uI7XY5R9lReC3dKWxHqTZOGnOpJDM80onvRP3uWhkmFYDmYoZYK7zXRUyGuePfW/ddP20kpUhEFAWPmyOYP+gA9nuB390GGeRHVyJgOxNLcT/9v9XWJ1J9ix1Gur6fqxETrNCBsM5wDu0HBBMwKhYMq/rKh+DA9tYwQ0eMzB4DlBjy6o8D0ikoveyC6ieT0wARy/ipvj6gjhkfG5NjJAAbOBQlewMYWw==
X-YMail-OSG: T4JumHIVM1nXiPqKuHPHd1xBxEO8AX8fEbJl__wK9N934zW2l36bLDJgbGwad8x
 M5MxavpT4Al1bpaR3AgIAY2.QmBEKOpLGF0i1RxLy8q5KZMSdNKikGKoo81anHPM7uSrA_UEz6Ex
 4pjXpxAFhcyE0fWhJcXYmri2B8.bdKEaIGwmjfyatJqiJ3n3uoEt.y.ujCi4nm.YOjyQXcFXjl9A
 XggH8U.NMWEfT1b.hzgJL65i8RsGW4T.vGnctoC1SHaGoj.jRMxWku4S2P.U_HpZ9ZTxtvn1igU2
 i.041paXwFoEazn4Q0iSugNaPgqt6.F2MhA9_Uu6n2Dk8za13ZAjVFZEYzydYCHRUhwWk0jhADGi
 .vA2Q.J85yKBOGxTHoOUH3MwWWTGOHzC2GO7idSnswxJqj5uOI.FtKPnv6I6sRSRsTnbB0.t_nSR
 eMYJ6FEia.ECj.tYVrCKbQDnBwK6RsQhCnU8ySyBI0jcNFgnX_N.5zc5l4nnBcNhA_nt9.yo0kp2
 T63c1kcN3bx2C6eqCiitbccN9rXr12nVeRitaulr_3g0NRYKkfe_rSfVeA1.JYhsI5_Q933BAt5x
 1lQ5aUbjSY7SmPaTqD2gm3h291s5fZhT_Hx54G7do3KrpdPOczdNiX_MMiGYUZ.ZkO5k9nL.DNWD
 .gjPhgTMuCcD.8RTUf0UIsZ0X2oxGU9YKG8EBkaUx20OWzSNLlifR5fm1tVpUG0YoDyaW4hlqFn.
 A0Vfk8WcARiKPVjSNnTv32VO3sftp6SvAOJLwcy5EsXov1QsnNqk1turicmot7CbMqSARP7RmkLu
 SsyNNAyWjn4uNKo1vQ4syy6WwC6LbXaJO7mffZe9dlfae1Ym68nLdWnMfLvRrQoqSBOPqQYix4LD
 k9gUmcn7W2WoPHrtXlKEhhtluBbExqNfsAxxy.7e9bGbsOFejGLhCKZVLodt3PRzlRfmno.yPQN7
 z1mih0NKJ_N_jD0iVoxb.8z1Zyo4biDcsyIPycksjgUzt_3oGrmRgtBqTi9F5eiOeuiWeHZ1UpYB
 iZW2ywOrqO92Jkcp9Uf7fbcKYRm5UPFV8XbAyP9_367WpaoQO2oeMUEzkiGtz7R1exZ0tG5JiVVF
 02h.NnvA8fvPlqfREDveaos2rRVGWbxjd7NbvTqGFvLBAd49he8CkiR23Y.IFPlvQhAoZeZIk9HH
 CK73spBD0QJJaIfdP6TbQkUPI7wcyXtqlQbZV6QgV_lXCG6bzxlsASy6rItL9mQ509LkWtjlHXGE
 71KxwdOlyv.uAqhrQ2mYcnBwQgNF.542jHJzlYa5fLK3IInp7PgwfzCYaz.5dgwxgYRJKbsvgQqS
 ZXNtDJPCBa1.aBqrIvraEZ8EtFyiQK6A1Y9tRBba9ejKIQuksttiPNaIfig6y8X7Nq8y2i2V6CVw
 N1qgdNeiwnivEuj9.aMUKhRSlpMUyHZ6NZp7QFm7cbdLFlhd4AKe_y4_I9EpU4_mXe7BEYJfoECR
 LEXjAs0z8tB4g2qhSuMQCktrIeb9H5iAgi2hC0xOYldMyryrH5wzI99ySR3yiZUzofZf_dSFHdnF
 1aLdigq4CbKuTep7O3bAVTA6srbMz1dU8kOVMMKOJXaTKcNQufocJH6IMXsOZorPwW4.Ft5OnxfJ
 BLtpMn1uRTk2epnSiWRW_vdwMR9i1PF05HAeAvI2QBEDWk4qWCln9Q_6K03bSt2h2ObbKZASdA7d
 yhL.9pAzpCX29jlqcOhiLA6CEk6tzgn_wpvIGIVmtAgpvkMhph5HKdIfgkPDp0tHzTjPkDxCYzrX
 KP758cuqRMgYuuE_1MzqfYalQp1.GxAt2AIDIpjkaVGlnxurDQPbzpcrshqDaNj_KoFjL2VQSScu
 y5GuzDeRTOANyNCWj6ttxkKWYdaMI06X7.lqLFlz.i2lTQM6DhWM6GHtQOalZCO.wdLTdC._g.u8
 9SdulkQEwIzDtHZLZeC0ku_ezJcScdx_2pA3hRVRskeUC6YEdBBF_QDfW4qV2ufAUf1MFlii8kB3
 DGW9otlX.uy.Xg_s0rgZVQDjJgR8_HdY9TCOKD17ZDA0elyfF6a.3U.zfVn5qT9M0IHZt8Oejh7c
 CDlLrhW4JowXygFP5._2uI1eIcPqJ.kAj0jLjF5TSVGirECd63a_fgfeFTukgqFAcPbDmXigBfcC
 wQIvLQaiGcz6D8RsxSxz._UkhWbrMRiozBVNUCTdrnZ5tH70-
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 882983eb-3f7c-4ef3-87c5-e64ad4086c7b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 20 Jan 2026 16:36:21 +0000
Received: by hermes--production-ir2-6fcf857f6f-vw7gs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5c743ac7fc5feeb5bdbb197ea32f25e9;
          Tue, 20 Jan 2026 16:26:07 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v6 02/11] net: tunnel: convert iptunnel_xmit to noref
Date: Tue, 20 Jan 2026 17:24:42 +0100
Message-ID: <20260120162451.23512-3-mmietus97@yahoo.com>
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
	TAGGED_FROM(0.00)[bounces-251553-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 4A295496EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

iptunnel_xmit assumes that a reference was taken on the dst passed to it,
and uses that reference.

This forces callers to reference the dst, preventing noref optimizations.

Convert iptunnel_xmit to be noref and drop the requirement that a ref be
taken on the dst.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 net/ipv4/ip_tunnel.c       | 2 ++
 net/ipv4/ip_tunnel_core.c  | 2 +-
 net/ipv4/udp_tunnel_core.c | 1 +
 net/ipv6/sit.c             | 1 +
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 50d0f5fe4e4c..2136a46bcdc5 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -655,6 +655,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, proto, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
+	ip_rt_put(rt);
 	return;
 tx_error:
 	DEV_STATS_INC(dev, tx_errors);
@@ -844,6 +845,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
+	ip_rt_put(rt);
 	return;
 
 #if IS_ENABLED(CONFIG_IPV6)
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index 2e61ac137128..70f0f123b0ba 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -61,7 +61,7 @@ void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
 	skb_scrub_packet(skb, xnet);
 
 	skb_clear_hash_if_not_l4(skb);
-	skb_dst_set(skb, &rt->dst);
+	skb_dst_set_noref(skb, &rt->dst);
 	memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
 	IPCB(skb)->flags = ipcb_flags;
 
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index b1f667c52cb2..a34066d91375 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -192,6 +192,7 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
 
 	iptunnel_xmit(sk, rt, skb, src, dst, IPPROTO_UDP, tos, ttl, df, xnet,
 		      ipcb_flags);
+	ip_rt_put(rt);
 }
 EXPORT_SYMBOL_GPL(udp_tunnel_xmit_skb);
 
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index cf37ad9686e6..a0d699082747 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1028,6 +1028,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)), 0);
+	ip_rt_put(rt);
 	return NETDEV_TX_OK;
 
 tx_error_icmp:
-- 
2.51.0


