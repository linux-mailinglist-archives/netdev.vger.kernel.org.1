Return-Path: <netdev+bounces-296997-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ife8DTvhJ2q13wIAu9opvQ
	(envelope-from <netdev+bounces-296997-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 11:47:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D87C65E84A
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 11:47:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=f5W07G7A;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296997-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296997-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE3FE312AEBC
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 09:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3053845DC;
	Tue,  9 Jun 2026 09:31:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A54F334C0D
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 09:31:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780997517; cv=none; b=gsCnGzFHOusCL1eUTdYHwX23rMHVYixKORpeYlp4NL7ZOC8ZkucaBB+irmM12ofTKm8llyP2Enhtr6dWh8reF6wjbMwAuKe0MVlEObEN2OqBv7sUnr5XXWfIvBbQGMxS1nLoTpow53hWSJtUD1en2wEHK66ZCKE6SMIVhGz/WiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780997517; c=relaxed/simple;
	bh=SLQLodR+5Wd37XEsxb4HEBgY/1Hxm3Kg41CRLQjB4DU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nvdmSvQopCft7jV8BDS+JrIj+puyHRSANsG0NxmkaS0uQCikaNQOAz+jSLlqAG3f7oztEWpZkZ1vAcMnhQ63sQcltkKTaRCZqTyO91ezLy4Q8EYKgHWztoEWGk3ExH9lHOm7JRvmVsrTYiudnlGlvUXNE1OMG12ZmoHu+kkiAnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f5W07G7A; arc=none smtp.client-ip=74.125.224.74
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-66034c1b31cso7837932d50.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 02:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780997515; x=1781602315; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4iU/5PQhlVc0d41VS5cvaR8Wn95XDRnhef0Pw8pBHeo=;
        b=f5W07G7A+MNVCK0J4lKEag3GXyc+i0cSQvk6yuZderdnIyU/WcqVNcmWgcVNdXOLPN
         35fviBZqevY8wTFrNwps3wjGLn9xl12EaALIT3F1q/ptD4fiRDMONBhpTmiFX/w7bIaS
         uuyAufqDD3Ao0PaGPSPvSohmeo821AEjzBKXO+l5bMaDwTBX1NR0BcdgtJUzjOPJpVoc
         UCg6HCR3ADPH0cOCgNXiMDWLtcxwWxE7P3BWHckRn70fd5mi1vD4O6uHE3Fp9kqhnJnX
         r7Twbdhmf6e79XdyafxiHsoj+2jWjPqRXwqYrcrqUKQwaqu8EvJ4BhUkMEUA6GQJdv8Y
         LL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780997515; x=1781602315;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4iU/5PQhlVc0d41VS5cvaR8Wn95XDRnhef0Pw8pBHeo=;
        b=O6452X4yH84JCTLBLqJ16HmHJnAS4RKz8d972eA0IGbb1K+2Gp3heDn6jAqLaz/q/c
         uhuppkwTbEpp7mknDI5RKPG863eq9p8oFAsNgux5iYNW916RvPVOYFl1dRdD7vfqOo+p
         K3CFUc88mClV5cIQebN4PfQfxlRqeNAtJ4sLjtlJOB6TVmnxYre5SOrk+lkkztDE9YMJ
         EcKfVuxNi7LCgcd5bp1RuHqi2aevoGWCnJ5xYqqeLI70c9NbOW1bWLpkyiUmpPhgbgQh
         8gjI4P1m8yd3DBztvSal+Kh0t6Rbvm6ptlKMco20y7ey9fBIAqGjGrzWa3GwcWXvtBv2
         PixQ==
X-Forwarded-Encrypted: i=1; AFNElJ8AHysPchErjygY8ILlWPYrM0BsVl3/ERO4ukWoib/xFT2ANXE9XoXiS6DwV0YznUWQZ0lxs68=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLUQ+BYxwgyRIpEpAj4/wtE4LOHmlor/cX7HcBdhoFUb1RtBOU
	H3K49o5mMaBB+Or0p85IkbBRS6ErWNJl8AdDkKeHdz/WxSEj8xBVANp1BsTiVcOzbhMhdliVWLv
	OYilu/RCVn7we1w==
X-Received: from yxjj11.prod.google.com ([2002:a05:690e:248b:b0:651:c20c:6ed3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a53:d005:0:b0:660:7702:62df with SMTP id 956f58d0204a3-66106f392e1mr14944614d50.31.1780997514771;
 Tue, 09 Jun 2026 02:31:54 -0700 (PDT)
Date: Tue,  9 Jun 2026 09:31:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260609093154.2733956-1-edumazet@google.com>
Subject: [PATCH net-next] ip6_tunnel: annotate data-races around t->err_count
 and t->err_time
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296997-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D87C65E84A

ip6_tnl_xmit() and ipip6_tunnel_xmit() run locklessly (dev->lltx == true).

ip6gre_err() and ipip6_err() also run locklessly.

We need to add READ_ONCE() and WRITE_ONCE() annotations
around t->err_count and t->err_time.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6_gre.c    |  8 ++++----
 net/ipv6/ip6_tunnel.c | 11 ++++++-----
 net/ipv6/sit.c        | 22 ++++++++++++----------
 3 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 365b4059eb20354c256c491a16db0e606e0a9790..9f767db800ba03f131c3315b8cf808daea50accc 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -445,11 +445,11 @@ static int ip6gre_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 		return 0;
 	}
 
-	if (time_before(jiffies, t->err_time + IP6TUNNEL_ERR_TIMEO))
-		t->err_count++;
+	if (time_before(jiffies, READ_ONCE(t->err_time) + IP6TUNNEL_ERR_TIMEO))
+		WRITE_ONCE(t->err_count, t->err_count + 1);
 	else
-		t->err_count = 1;
-	t->err_time = jiffies;
+		WRITE_ONCE(t->err_count, 1);
+	WRITE_ONCE(t->err_time, jiffies);
 
 	return 0;
 }
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 9d1037ac082f6aad36c152ffdbe0f30237b65fc3..3445f81d9957e0ddd3f23d8b550ef5772672dba6 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1104,7 +1104,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	struct ipv6_tel_txoption opt;
 	struct dst_entry *dst = NULL, *ndst = NULL;
 	struct net_device *tdev;
-	int mtu;
+	int err_count, mtu;
 	unsigned int eth_hlen = t->dev->type == ARPHRD_ETHER ? ETH_HLEN : 0;
 	unsigned int psh_hlen = sizeof(struct ipv6hdr) + t->encap_hlen;
 	unsigned int max_headroom = psh_hlen;
@@ -1214,14 +1214,15 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 		goto tx_err_dst_release;
 	}
 
-	if (t->err_count > 0) {
+	err_count = READ_ONCE(t->err_count);
+	if (err_count > 0) {
 		if (time_before(jiffies,
-				t->err_time + IP6TUNNEL_ERR_TIMEO)) {
-			t->err_count--;
+				READ_ONCE(t->err_time) + IP6TUNNEL_ERR_TIMEO)) {
+			WRITE_ONCE(t->err_count, err_count - 1);
 
 			dst_link_failure(skb);
 		} else {
-			t->err_count = 0;
+			WRITE_ONCE(t->err_count, 0);
 		}
 	}
 
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 201347b4e12742451de6d6036281d1abaff0dd84..f7a8d1d365e3c41edd9e10854c9009dfdd7e2aae 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -595,11 +595,11 @@ static int ipip6_err(struct sk_buff *skb, u32 info)
 	if (t->parms.iph.ttl == 0 && type == ICMP_TIME_EXCEEDED)
 		goto out;
 
-	if (time_before(jiffies, t->err_time + IPTUNNEL_ERR_TIMEO))
-		t->err_count++;
+	if (time_before(jiffies, READ_ONCE(t->err_time) + IPTUNNEL_ERR_TIMEO))
+		WRITE_ONCE(t->err_count, t->err_count + 1);
 	else
-		t->err_count = 1;
-	t->err_time = jiffies;
+		WRITE_ONCE(t->err_count, 1);
+	WRITE_ONCE(t->err_time, jiffies);
 out:
 	return err;
 }
@@ -909,8 +909,8 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 	struct net_device *tdev;	/* Device to other host */
 	unsigned int max_headroom;	/* The extra header space needed */
 	__be32 dst = tiph->daddr;
+	int err_count, mtu;
 	struct flowi4 fl4;
-	int    mtu;
 	u8 ttl;
 	u8 protocol = IPPROTO_IPV6;
 	int t_hlen = tunnel->hlen + sizeof(struct iphdr);
@@ -986,13 +986,15 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 		}
 	}
 
-	if (tunnel->err_count > 0) {
+	err_count = READ_ONCE(tunnel->err_count);
+	if (err_count > 0) {
 		if (time_before(jiffies,
-				tunnel->err_time + IPTUNNEL_ERR_TIMEO)) {
-			tunnel->err_count--;
+				READ_ONCE(tunnel->err_time) + IPTUNNEL_ERR_TIMEO)) {
+			WRITE_ONCE(tunnel->err_count, err_count - 1);
 			dst_link_failure(skb);
-		} else
-			tunnel->err_count = 0;
+		} else {
+			WRITE_ONCE(tunnel->err_count,  0);
+		}
 	}
 
 	/*
-- 
2.54.0.1064.gd145956f57-goog


