Return-Path: <netdev+bounces-297783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rNYgKNGcKWqqagMAu9opvQ
	(envelope-from <netdev+bounces-297783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 19:20:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF7466BEEA
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 19:20:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=t+8bi+uc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297783-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297783-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 931E531B8870
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBFF34753B;
	Wed, 10 Jun 2026 17:15:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E156A1A0BD0
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 17:15:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111702; cv=none; b=WiYah7tu1ijSUfuoShbvaM3VWy1fek8RNdjT+CLGNrWgBQ3MzQaFP4bcnrf4LV4+mbrkRDH8hkSyGOjeud07aTSvdrSJyADP84Clpor2EB5r8/+1Fz9gi9vOAnoK+Amwo6fPnK1Z6D9GfKP1H3FaolsM/yPAk5PCKSi+nMVxJyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111702; c=relaxed/simple;
	bh=uGjN+qrQhO1xBmofVqHwfXTApm/dXGN/dMa94oo2C8Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IjIeNr3ZaYOLyVj7LDSkHRrzdy8iebA6EFyrIWh9TSsGGHnlQBsEKiqx35+1teCB0z3+k7yWsM5WEXUL3HcNJ5pdeiOT4OO0zK2ZIZIQGehsYVim4P2U7eu+wfuRmJvoJubx+NY+/Xt9I0HT5cCa4SVKzSUGcyNPMVcx04/mfpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t+8bi+uc; arc=none smtp.client-ip=209.85.222.202
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-915d33f7c28so668084285a.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 10:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781111700; x=1781716500; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LP7JeGO74FmNNcPZWHf7X5w3VRlbqkAA1Dn/5fda5kM=;
        b=t+8bi+ucjLKdKLCtaPLnBcQj4Rm4N//1oV08+RQ9pHidiuXE8qQcs7sB1vYkjsavoV
         jJ5qhXJki/fBugs2IgknajduuVAYwosdeM6poA9XBUuemeTowi1M2s4ndiS62/uz/0If
         fjip1iKVysR9sxdw5clxTQ0Bv7PIrb/3DZlG+m40P2xBvL0w+AlYVCYwd8bB47+l30a5
         VlfISRs+ZwYPDxu0PCktkyxBMCXvpvZFYMibEssaIFnm+avmfPP8uWhEqWZaz3CZ9v9U
         iZ+a8b2ESE5Zo+H+3jpf7eEwlVo3RHUWb4JXR6hvfvuiYj/fWxokxCGJQYh3I/5tlxr7
         a6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781111700; x=1781716500;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LP7JeGO74FmNNcPZWHf7X5w3VRlbqkAA1Dn/5fda5kM=;
        b=mWO49CPs++txEgr5fgGjh/G8ACb8EAQS9LpV9c9hPGNPBbJIgIwYowOlZ0I4CFtdMa
         sGxiKxFiEWU+/og8lvPGdDAfgR1HvMLnRia/UrMciWNVUHlCLDeZXRMrU8DMvp7amLYT
         ZW+sFn5f8IMcdt/RbuWkp6NtxcCunPQ1Is0qn/qMA1dLEmFtFoIiR5Yc/I2p8P6ENbvA
         ku6jTOgJpU/1mTZ0R0YGSX9LvbopPc/ePOJLYd+fj14OVtS9vBC1pAI41mfxc03jP+Vs
         YAf4JIomA347O8RVkZn4sNsL/9xKdrWckMDD3kVPXwItjKytFHbKIMZBFIseJdC0+Ua4
         tlFg==
X-Forwarded-Encrypted: i=1; AFNElJ+BG7ZPavRu1FRn2VYgJngICyEE1/9/lEmQIMJBRKZXdWa0nDAiWuZeKuxdahcy3Ju6EuoJRhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtUJeaJoNGtvn+udlUsjk7pJvxQHub1ALQ0mbzXRidDcib6qLA
	3xvgQi8dzV/VyKURgAOfC4v30YokEzfINBL1ODYmctHbgG+2pRTSCnb6Bh4t/wLexgLboITl4X0
	lft2rzp8imvMmsA==
X-Received: from qkle10.prod.google.com ([2002:a05:620a:12ca:b0:915:9acf:1f82])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:6287:b0:915:c4de:7ad8 with SMTP id af79cd13be357-915c4de84efmr2599048085a.38.1781111699468;
 Wed, 10 Jun 2026 10:14:59 -0700 (PDT)
Date: Wed, 10 Jun 2026 17:14:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610171458.1359630-1-edumazet@google.com>
Subject: [PATCH v2 net-next] ip6_tunnel: annotate data-races around
 t->err_count and t->err_time
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
	TAGGED_FROM(0.00)[bounces-297783-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: ECF7466BEEA

ip6_tnl_xmit() and ipip6_tunnel_xmit() run locklessly (dev->lltx == true).

ip6gre_err() and ipip6_err() also run locklessly.

We need to add READ_ONCE() and WRITE_ONCE() annotations
around t->err_count and t->err_time.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
v2: addressed sashiko's feedback (Jakub).

 net/ipv6/ip6_gre.c    |  8 ++++----
 net/ipv6/ip6_tunnel.c | 11 ++++++-----
 net/ipv6/sit.c        | 22 ++++++++++++----------
 3 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 365b4059eb20354c256c491a16db0e606e0a9790..a43382000619049df7a3127f5106ca12608b0344 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -445,11 +445,11 @@ static int ip6gre_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 		return 0;
 	}
 
-	if (time_before(jiffies, t->err_time + IP6TUNNEL_ERR_TIMEO))
-		t->err_count++;
+	if (time_before(jiffies, READ_ONCE(t->err_time) + IP6TUNNEL_ERR_TIMEO))
+		WRITE_ONCE(t->err_count, READ_ONCE(t->err_count) + 1);
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
index 201347b4e12742451de6d6036281d1abaff0dd84..9c4efc441711f89d3ef8093f4764a5b8083afb99 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -595,11 +595,11 @@ static int ipip6_err(struct sk_buff *skb, u32 info)
 	if (t->parms.iph.ttl == 0 && type == ICMP_TIME_EXCEEDED)
 		goto out;
 
-	if (time_before(jiffies, t->err_time + IPTUNNEL_ERR_TIMEO))
-		t->err_count++;
+	if (time_before(jiffies, READ_ONCE(t->err_time) + IPTUNNEL_ERR_TIMEO))
+		WRITE_ONCE(t->err_count, READ_ONCE(t->err_count) + 1);
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
2.54.0.1099.g489fc7bff1-goog


