Return-Path: <netdev+bounces-251545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KN7LFDHYb2kKSwAAu9opvQ
	(envelope-from <netdev+bounces-251545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:32:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E38F54A748
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 08B7C82B981
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7826745105D;
	Tue, 20 Jan 2026 16:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="AYSrJO3A"
X-Original-To: netdev@vger.kernel.org
Received: from sonic302-21.consmr.mail.ne1.yahoo.com (sonic302-21.consmr.mail.ne1.yahoo.com [66.163.186.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9297F44CAC5
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926393; cv=none; b=C1nBrxFVElf4AFYGHiFZd010vmUTG3UJXHA2ZO3zdLJGJs+bRmmvYPJbGE/a0IsgQXmWbsjLt7Xys4kpKU9sMEeEk6dkwq4H9mYXLDmmO9kmlW41IfFsM+JsKc5IpkpYimUqsE8VpJMdQkPEGzAxsX3jklUKSu8XnscOl1QVBlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926393; c=relaxed/simple;
	bh=oqUrSL4lf3tYBFyaT/ify6X5U5o296WFynLQeU6ytBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwiR92gCZuomF/T8AfgjzTxM9nNsoMI+edRdUvcNJ5V97fCGcctpbc4VaLQhh2vhLbDSUWpuLHQ3z7Z44rcVjXN5ZA8PStUrBFm2UDvJbuTZlICtNU2h0Mv6ZXEd9YfUC9f9scFSEAgoNq9FM6DOiVj6skIPEvcJ0bXCpsylc8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=AYSrJO3A; arc=none smtp.client-ip=66.163.186.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768926390; bh=GJxqCb9d+Qv3aRQe8F/WJT/zj1IQzolQ6CI7JT0Afos=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=AYSrJO3ARBMsauk0vfYyI8ke3fU6vDTS83Tzva5kLBNbq4owRLIopySaW0V5UOYqEy1xUziK28Qw+A7vcNJ8XYxg6SNAEfu8utYTfNFkw3byo2njqgqEyydeldg+Fye37Yu6KZ0SqVeHbgqhdPzUOq0uU2ltB0xenklKjwSZBK24WV9zUWPWcZaOP8EucNoxyXlpnls08jm7cYHFttlHOkXCew/+ByYlpjUXMPTmjwpjjwTCpQjl45eOuNX+UNJiY0DmcRE2JXjqmLHbk2XoX6M1KAcIa3BVmE0Jy2J2ATTZaNiwTJx5UxhJYen7+nkdgQjNUDW0MqXmjAQ9YAveJQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768926390; bh=w8gXq8dnvwARZch55r420GCyHqzAn6pMOlgPRos0l21=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=SdqjM83o2/1oaUKaLK7xuwyaVbdOJYuIXrIxEdVHthkTSZ6ZdJfN6R2b0N1ifzmLIfbGD2tG6uGve/rh5Y5aBnuHJk+XuDz0aKCAQsRW8+5EjmW0CozHLGhfDIBunXmfDenzxFXvFDVMwoePgUwJgraE/iFYFaU8Oc/E5y+q274RfW+h+UH3nSEd/5v7mJhzBqoi0eCaEwk4SbnBu/IxdPmECaYH5NXMfyBxcplFDZc7vWv1CctqGcybdpu3MvMp2xf9LfNneSV6RTj8U3T7CUP4HXC+slYH6+Sg22Xrf0XLmabfqzRFAkX5AgZRuVzalFAG9UUnVFDNErFkMtb3pQ==
X-YMail-OSG: CGLB1I4VM1nt0Oi8k2M74gqew8_UEVYCJ4s8cDcygaQu38mde6HQNhWLjAdJFEW
 sO05pBu7Q6Q6531s1u92_plkDHzR7RNHFNLTovkP.2CgK1FJzn..TnqB28PWXTRnZ5_796JqGe4K
 uESp9rsO8Fwi1_Ytf0ltRX0KR1lotdBY8GntMxjfwNoHlTg0JPBxerhlfYJWHfeY5xZXu5YTsxq_
 UcttgpFAl8ypMbgCH8pahV4aA7tYxoHR69b76jpZXqwgy1ydbyxfkRddLgGGMdaPIoyTB3dKrOCS
 iDlquDEtkbpvBbwNw3kXa7iznvZymnwupagV5AWpjYf2cRb9_4M7Mx2s6h3YNhVgO5.dLMPv_mnv
 mJ9PLuyi4LXop0S795byR6ft6wOEq0gdHUG4Yayrv20BXhm2ZJF5mKpbjyQyJtRxj1c3isLfruCh
 LcfBzvJtVmJI.ts6jiXF6MriG4btA7GVGZJmZbjP97jmAoCqvFw6CI12FtLkhJegcdmgbhn2pm5V
 mDDoHnVcWdF1WgxFBrRmMvDVTJeKvgqez3bCWUQ8jfsNfHcEOZ269_LoanfFTXK2zlNYyC8qTT9n
 wU1OKvDZnzMTvCfBD1a3lqnhSoEdAZNgAPWO86Z.MJjSV5CEgtlFiKlHqkTgoXdX1Q2IfuHL2lMG
 fT7C0wA.TV1Jacvhv02SW8InejWHhUq_WVKwKlNz9KHUfcA2R8uPuUw8tzcxS5b_wFMrqwuTvl.4
 66S1Ol8VraaEaHIQBe0twCCGhamOI9TfQGB3T14R9_jKKkZBLJsU80F_ImvdeKcJ0xzdr1.yvcro
 mdg.T.7zjpJXIRKWufA3j.GWqTed32pGhsWrgwavw0uN.hJW4DHfEbwpM3ERUNEXxFxFpVt1tuw_
 KI_jMDJ8OAMsVuFC.516qwUGtD9smbRO2jXUvKJILZ7oygeO5lbSmAeKE9PKBtiwcRnugdKVzDTQ
 _XuhiJrSkBFmOyKYdzMcOgACNv2I6nxc4TcLTXE5VKW0KiFkPeIMJ_.bLVmoLnf5gOGegIwv2SBl
 IsWKf1NYju42JXRVsJofUwTI5MAHKrWmIuRlgmHxWkycQ3CkkCs6L9UbCYmwzLyCw4ICjW0VvwPc
 LSSDoEP0gsAfpRS1nCGwvfBZIwVC0mkjajmB8Y.XOceLmpO0nEF3cDI8twMjD8M98L3Okt6ujZBd
 _wxVwgZ0ED..9NWvp76091CEL0MS.ZfM9Eol8ppbiBxyIW4252aACBgdHYV6vlK4ifnlRed1GX6Z
 C9XwKuW_jLA5lKyzLyiiTE2MfLE4rFzLnDfrLe023tap5H0Q9jKa6KZlOtHGQkmqeOOC_K9dcbKG
 lXzsPmQOOBOykvuH2Qv6p_Zr8AMLO7qkasXouDKtdpesoSw8f_TJFB78fXV8g4gIwM.VmTIZdl0d
 5pHUBS2ny9TN.KZOdtTAnEPXNvA_Cws9RIXvORRa5xT2_8V0eqnyR6j3HGWT9VMAEx9xZrPyHPpx
 P5rEaOGU.kSwjWgVyQKgvfLqOoSUE_Vhyve7x7onGQ.2Bc01ua_RkYYdo3vVyzCY33C_gdnl5BUc
 XuDdlJsoGZaMgeOAP5a1Z5z1XDfqaxle6nWHOkcF039gIpGmfNCjmMTHqYQL2frsdRDiyimPReam
 B4yFQ747Ri35wWzw8vpxiNRUPW5O80om8ioR_rNC0jNOp6vHyB_MyRfVy5b0aNDUzZ9_fu.5ddDs
 6iVzzTbpJUs1dWYi9Ac_5ubCjdrK.Z4ancy1GKQNc68ym8LTGhd4fAPQHlRUz2BwYSNusJfuzATP
 jZ2cv.faxgRjM3lk5sddMsfFJMt0P1B.DbTVRwmn_sbyHujfly8GaEmh5oXf.4SB6zKgjpRW8iPF
 9UROdURTtSvjwCBxD9eifi.4QOcM6seJRjte7P0J6UBbfbV3qpjVArOTqJUoKmNcdSl1f3EAJSqp
 4xg9Oiuqvgo6BbzFtB_9GGBJWR_01mLK9nGrzPGtLQQ1GZz867YMk_NaUfhS_56V1mjHy4w1LS_t
 ybSq1BOCt3ogWGR3F2SYXaHxxfUhqmvfij5_fJEQC7.zkCXaLZ3zunysKnlAQQidLAgy1t48Glog
 EHQcsvlTbPkqSYDINKXwn_mkcIeH2EUC46bnmSeuTP7eQ7.FKzTkTR_haSyqgUlQem.uRbRx8Oiz
 8s.nHhEpPcYRUp5OsHBRx56HdmHm1pA.3Zzv86n9btwyoNcSx
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 2643ab38-ea2b-48fc-9ae9-a65ade8a4297
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Tue, 20 Jan 2026 16:26:30 +0000
Received: by hermes--production-ir2-6fcf857f6f-vw7gs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5c743ac7fc5feeb5bdbb197ea32f25e9;
          Tue, 20 Jan 2026 16:26:22 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v6 03/11] net: tunnel: convert udp_tunnel{6,}_xmit_skb to noref
Date: Tue, 20 Jan 2026 17:24:43 +0100
Message-ID: <20260120162451.23512-4-mmietus97@yahoo.com>
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
	TAGGED_FROM(0.00)[bounces-251545-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: E38F54A748
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

udp_tunnel{6,}_xmit_skb assume that a reference was taken on the dst
passed to them, and use that reference.

This forces callers to reference the dst, preventing noref optimizations.

Convert udp_tunnel{6,}_xmit_skb to be noref and drop the requirement
that a ref be taken on the dst.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 drivers/net/amt.c              | 3 +++
 drivers/net/bareudp.c          | 2 ++
 drivers/net/geneve.c           | 2 ++
 drivers/net/gtp.c              | 5 +++++
 drivers/net/ovpn/udp.c         | 2 ++
 drivers/net/vxlan/vxlan_core.c | 2 ++
 drivers/net/wireguard/socket.c | 2 ++
 net/ipv4/udp_tunnel_core.c     | 1 -
 net/ipv6/ip6_udp_tunnel.c      | 2 +-
 net/sctp/ipv6.c                | 1 +
 net/sctp/protocol.c            | 1 +
 net/tipc/udp_media.c           | 2 ++
 12 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 902c817a0dea..e9eeaa7b6fe7 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -1050,6 +1050,7 @@ static bool amt_send_membership_update(struct amt_dev *amt,
 			    false,
 			    false,
 			    0);
+	ip_rt_put(rt);
 	amt_update_gw_status(amt, AMT_STATUS_SENT_UPDATE, true);
 	return false;
 }
@@ -1108,6 +1109,7 @@ static void amt_send_multicast_data(struct amt_dev *amt,
 			    false,
 			    false,
 			    0);
+	ip_rt_put(rt);
 }
 
 static bool amt_send_membership_query(struct amt_dev *amt,
@@ -1167,6 +1169,7 @@ static bool amt_send_membership_query(struct amt_dev *amt,
 			    false,
 			    false,
 			    0);
+	ip_rt_put(rt);
 	amt_update_relay_status(tunnel, AMT_STATUS_SENT_QUERY, true);
 	return false;
 }
diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 0df3208783ad..92ee4a36f86f 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -364,6 +364,7 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			    !net_eq(bareudp->net, dev_net(bareudp->dev)),
 			    !test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags),
 			    0);
+	ip_rt_put(rt);
 	return 0;
 
 free_dst:
@@ -433,6 +434,7 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			     !test_bit(IP_TUNNEL_CSUM_BIT,
 				       info->key.tun_flags),
 			     0);
+	dst_release(dst);
 	return 0;
 
 free_dst:
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 77b0c3d52041..169a2b7d83e0 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -926,6 +926,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			    !net_eq(geneve->net, dev_net(geneve->dev)),
 			    !test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags),
 			    0);
+	ip_rt_put(rt);
 	return 0;
 }
 
@@ -1019,6 +1020,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			     !test_bit(IP_TUNNEL_CSUM_BIT,
 				       info->key.tun_flags),
 			     0);
+	dst_release(dst);
 	return 0;
 }
 #endif
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 4213c3b2d532..3cd1f16136a3 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -449,6 +449,7 @@ static int gtp0_send_echo_resp_ip(struct gtp_dev *gtp, struct sk_buff *skb)
 				    dev_net(gtp->dev)),
 			    false,
 			    0);
+	ip_rt_put(rt);
 
 	return 0;
 }
@@ -708,6 +709,7 @@ static int gtp1u_send_echo_resp(struct gtp_dev *gtp, struct sk_buff *skb)
 				    dev_net(gtp->dev)),
 			    false,
 			    0);
+	ip_rt_put(rt);
 	return 0;
 }
 
@@ -1308,6 +1310,7 @@ static netdev_tx_t gtp_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 				    !net_eq(sock_net(pktinfo.pctx->sk),
 					    dev_net(dev)),
 				    false, 0);
+		ip_rt_put(pktinfo.rt);
 		break;
 	case AF_INET6:
 #if IS_ENABLED(CONFIG_IPV6)
@@ -1318,6 +1321,7 @@ static netdev_tx_t gtp_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 				     0,
 				     pktinfo.gtph_port, pktinfo.gtph_port,
 				     false, 0);
+		dst_release(&pktinfo.rt6->dst);
 #else
 		goto tx_err;
 #endif
@@ -2409,6 +2413,7 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 			    !net_eq(sock_net(sk),
 				    dev_net(gtp->dev)),
 			    false, 0);
+	ip_rt_put(rt);
 	return 0;
 }
 
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index d6a0f7a0b75d..c82ba71b6aff 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -200,6 +200,7 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	udp_tunnel_xmit_skb(rt, sk, skb, fl.saddr, fl.daddr, 0,
 			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
 			    fl.fl4_dport, false, sk->sk_no_check_tx, 0);
+	ip_rt_put(rt);
 	ret = 0;
 err:
 	local_bh_enable();
@@ -275,6 +276,7 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	udp_tunnel6_xmit_skb(dst, sk, skb, skb->dev, &fl.saddr, &fl.daddr, 0,
 			     ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
 			     fl.fl6_dport, udp_get_no_check6_tx(sk), 0);
+	dst_release(dst);
 	ret = 0;
 err:
 	local_bh_enable();
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index e957aa12a8a4..09ddf0586176 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2538,6 +2538,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 				    pkey->u.ipv4.dst, tos, ttl, df,
 				    src_port, dst_port, xnet, !udp_sum,
 				    ipcb_flags);
+		ip_rt_put(rt);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else {
 		struct vxlan_sock *sock6;
@@ -2613,6 +2614,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 				     &saddr, &pkey->u.ipv6.dst, tos, ttl,
 				     pkey->label, src_port, dst_port, !udp_sum,
 				     ip6cb_flags);
+		dst_release(ndst);
 #endif
 	}
 	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX, pkt_len);
diff --git a/drivers/net/wireguard/socket.c b/drivers/net/wireguard/socket.c
index 253488f8c00f..ee7d9c675909 100644
--- a/drivers/net/wireguard/socket.c
+++ b/drivers/net/wireguard/socket.c
@@ -85,6 +85,7 @@ static int send4(struct wg_device *wg, struct sk_buff *skb,
 	udp_tunnel_xmit_skb(rt, sock, skb, fl.saddr, fl.daddr, ds,
 			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
 			    fl.fl4_dport, false, false, 0);
+	ip_rt_put(rt);
 	goto out;
 
 err:
@@ -152,6 +153,7 @@ static int send6(struct wg_device *wg, struct sk_buff *skb,
 	udp_tunnel6_xmit_skb(dst, sock, skb, skb->dev, &fl.saddr, &fl.daddr, ds,
 			     ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
 			     fl.fl6_dport, false, 0);
+	dst_release(dst);
 	goto out;
 
 err:
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index a34066d91375..b1f667c52cb2 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -192,7 +192,6 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
 
 	iptunnel_xmit(sk, rt, skb, src, dst, IPPROTO_UDP, tos, ttl, df, xnet,
 		      ipcb_flags);
-	ip_rt_put(rt);
 }
 EXPORT_SYMBOL_GPL(udp_tunnel_xmit_skb);
 
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index cef3e0210744..d58815db8182 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -95,7 +95,7 @@ void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 
 	uh->len = htons(skb->len);
 
-	skb_dst_set(skb, dst);
+	skb_dst_set_noref(skb, dst);
 
 	udp6_set_csum(nocheck, skb, saddr, daddr, skb->len);
 
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index 531cb0690007..38fd1cf3148f 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -264,6 +264,7 @@ static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	udp_tunnel6_xmit_skb(dst, sk, skb, NULL, &fl6->saddr, &fl6->daddr,
 			     tclass, ip6_dst_hoplimit(dst), label,
 			     sctp_sk(sk)->udp_port, t->encap_port, false, 0);
+	dst_release(dst);
 	return 0;
 }
 
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 2c3398f75d76..ff18ed0a65ff 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1074,6 +1074,7 @@ static inline int sctp_v4_xmit(struct sk_buff *skb, struct sctp_transport *t)
 			    fl4->daddr, dscp, ip4_dst_hoplimit(dst), df,
 			    sctp_sk(sk)->udp_port, t->encap_port, false, false,
 			    0);
+	dst_release(dst);
 	return 0;
 }
 
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index b85ab0fb3b8c..ba4ff5b3354f 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -198,6 +198,7 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 		udp_tunnel_xmit_skb(rt, ub->ubsock->sk, skb, src->ipv4.s_addr,
 				    dst->ipv4.s_addr, 0, ttl, 0, src->port,
 				    dst->port, false, true, 0);
+		ip_rt_put(rt);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else {
 		if (!ndst) {
@@ -220,6 +221,7 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 		udp_tunnel6_xmit_skb(ndst, ub->ubsock->sk, skb, NULL,
 				     &src->ipv6, &dst->ipv6, 0, ttl, 0,
 				     src->port, dst->port, false, 0);
+		dst_release(ndst);
 #endif
 	}
 	local_bh_enable();
-- 
2.51.0


