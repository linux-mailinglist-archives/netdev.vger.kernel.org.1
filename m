Return-Path: <netdev+bounces-150088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2563B9E8E10
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 09:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE871886D10
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 08:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB2F21883A;
	Mon,  9 Dec 2024 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="HOsVj1md"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E524217F30
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 08:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734399; cv=none; b=QSxFMBwMXIFgUaFWsOIS6yqpG1+0+9G30+2j/nDUbR8HfRxJ7uVzjh7qoxG17qLmFRv2FEHGzUdXJ3dYmCjna1LQaNs5aDHoQOobly+Lc8aVmS6O6kNu95JyK9q/cx4sSVxy7kOOcPuGZ1U26F+OXbb7BdS2HJ12b57pasBv2SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734399; c=relaxed/simple;
	bh=neS/+0qWJqF8Z7Wgo3VzoX3OM8bNHfa0Vevx+f0f3Ls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sUXqtQ6gZAoimcsyAk0DY5X2uiyf2nyuM2G3Bqkz2lkjAWiwBeL6xlv/HhvqL3gDiQtxyXWDm9YfB+kYRtWpkg8xZwXZLeZ2V0MzYV1AGfkYpnmdoIgAyAjME0h/+sRLjoDyiF83K0SUlUJp/ZnqRKGr66e4f3QQ6Wa2dbOpbsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=HOsVj1md; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385d7f19f20so1777157f8f.1
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 00:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733734395; x=1734339195; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qGTX6bsSUfHp3feyAtZvFNRrvKLiQ67eLp8Tyq9Lxvg=;
        b=HOsVj1mdGfzmpfzr1EHfD9rU6nxmvJant9NwEAWc8kSdR39I4zWzuA37CEP+T/Lma+
         pXZWUPCuCXH2q31eXRrIx+n8zltLGV69Xfbh5ESr0nBkyWkLe4IXl1WLoi+TTA/I/HD2
         hnH3lzD8cG19ubheA9JvZ0dr1OlkTLt0TwriYElO9WXLdLzWwJdVt39Bfzq/pVlyq6nP
         qzydwMFP7tuhalQn0wku9vkQNOnbPoY8Rmzsa0XTfXYKRtcKZmNHUCsjnTKLiupmUR/v
         veJ3ZWu0xIDcRP66ubJB4Bmfx5cNe0X9PDFwJwSaQ8qttWJc9he8AGDq8tpUjAkRl8em
         WHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733734395; x=1734339195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGTX6bsSUfHp3feyAtZvFNRrvKLiQ67eLp8Tyq9Lxvg=;
        b=VVZtHVD4SCOZf4o3jWov/y1tubJbUQG/Hd8aH219PiOExQWMXgCshiy/g8u9eGmlTh
         4jzFdL5OXGcGHaGUHrBCtWxKkSNADj8aB/pKilR20r3Gy/lTbzhexpb6I1qcZR6bIBxf
         T0WV1DGcfRpPK/dXHKQG1eIpuQZKuvgdyfaPrRkKXGe91lm6UIW+0AKQjOmZ2gHAZHdo
         br+GQHIsGH/3xAvfaonpVoprI40KDwnhngttzu8yxis0iIwro6T1po3IM9VJqNQTtd3d
         SiO4EKOiqgFM+0244Cah4nk3wcoNYDUoWW3wj6rQINvPJVG9JKYDKv4tSL2qeiPw09Je
         SxpQ==
X-Gm-Message-State: AOJu0YzhnNbXongDAd8JXuYa+us/NlcB4Yzfc+5CYDKYDp38KjSKr3YJ
	QjQ9JFiDuCJKdGmbZUlR297hcIIyLVE18o0ANhYKjTT+OoUEtd2gqNK5dvrjz3c=
X-Gm-Gg: ASbGncvwoE+djVjefdCMFOkuNmo3Ad0yxTMbAhULM8PCXDU/qzeeVOPHV+Fjk7htJxO
	4uqbn89xHR+A4St5Q/Z7/7Ec2LXUpg9HQl0bbo18zHySs89/1KRwLsD3fyZ7Miv1y/bOCn3cCIj
	H8o+xywX6AOXjzwEkW+bRuFmTVbf1v5idQT7MIu/9HnoZ7hZe1bZeFWbhYW0QvHdY8JIV/oX/0x
	Dj+NlGuhyRZhQO25mD14lHPnCN3k8COU3hoZQ8gE3eUjh3S63Uet3eHFdMz
X-Google-Smtp-Source: AGHT+IGDzmW3tCzfM79GbDaPZOaMTQrHsZZ5RRB4SMX+nsVLifwjbxFOZsjY74xhpPsIToi/akxYCw==
X-Received: by 2002:a5d:47a8:0:b0:385:d7a7:ad60 with SMTP id ffacd0b85a97d-3862b34f675mr8913289f8f.3.1733734394661;
        Mon, 09 Dec 2024 00:53:14 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:c60f:6f50:7258:1f7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621fbbea8sm12439844f8f.97.2024.12.09.00.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 00:53:14 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 09 Dec 2024 09:53:22 +0100
Subject: [PATCH net-next v14 13/22] ovpn: implement peer lookup logic
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-b4-ovpn-v14-13-ea243cf16417@openvpn.net>
References: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
In-Reply-To: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11634; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=neS/+0qWJqF8Z7Wgo3VzoX3OM8bNHfa0Vevx+f0f3Ls=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnVrATi90N7pJqaUAZSCQrkk3iMGf0I+CMGuP3b
 dUu7oZGbXWJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1awEwAKCRALcOU6oDjV
 h2GeCACBm0SN+KdYRTgc3IA5wBNMWivwv1c7aV84bgq/QYETMkaDAgtDSRReAG99XujJoeetN6k
 1oqgX3qdGs/vTQGCNAvJqlqxPDaa4nmoqQnYPc/AloQ5jrxcfVVGeyAUlbYB/D66yV/k028Tw84
 QCjwv8aeqga3A3fEocJGsWzHugC9K3pW2usPXYlFE4OlLm7mZnBXZncJTyFyH1JS9UNcyxPSfa9
 8tfwa+0TXtOKrpIcbLAnpoWMcqcLBJfAPezvrc50S8KOAkwAZLjDKAOvRhSHWfbvzm5HWnTHnV0
 8JdguMfXDmMu6aVZLmYQYt3kQfa5uUWx0qQDzcKXvKrzwAoS
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

In a multi-peer scenario there are a number of situations when a
specific peer needs to be looked up.

We may want to lookup a peer by:
1. its ID
2. its VPN destination IP
3. its transport IP/port couple

For each of the above, there is a specific routing table referencing all
peers for fast look up.

Case 2. is a bit special in the sense that an outgoing packet may not be
sent to the peer VPN IP directly, but rather to a network behind it. For
this reason we first perform a nexthop lookup in the system routing
table and then we use the retrieved nexthop as peer search key.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.c | 301 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 291 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 9f213ccacfaf8170b9c23730498f156360774d7e..5e78c984ef302ae17ef8481bb10ac382e5d11e31 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -10,6 +10,7 @@
 #include <linux/skbuff.h>
 #include <linux/list.h>
 #include <linux/hashtable.h>
+#include <net/ip6_route.h>
 
 #include "ovpnstruct.h"
 #include "bind.h"
@@ -136,6 +137,121 @@ static int ovpn_peer_skb_to_sockaddr(struct sk_buff *skb,
 	return -1;
 }
 
+/**
+ * ovpn_nexthop_from_skb4 - retrieve IPv4 nexthop for outgoing skb
+ * @skb: the outgoing packet
+ *
+ * Return: the IPv4 of the nexthop
+ */
+static __be32 ovpn_nexthop_from_skb4(struct sk_buff *skb)
+{
+	const struct rtable *rt = skb_rtable(skb);
+
+	if (rt && rt->rt_uses_gateway)
+		return rt->rt_gw4;
+
+	return ip_hdr(skb)->daddr;
+}
+
+/**
+ * ovpn_nexthop_from_skb6 - retrieve IPv6 nexthop for outgoing skb
+ * @skb: the outgoing packet
+ *
+ * Return: the IPv6 of the nexthop
+ */
+static struct in6_addr ovpn_nexthop_from_skb6(struct sk_buff *skb)
+{
+	const struct rt6_info *rt = skb_rt6_info(skb);
+
+	if (!rt || !(rt->rt6i_flags & RTF_GATEWAY))
+		return ipv6_hdr(skb)->daddr;
+
+	return rt->rt6i_gateway;
+}
+
+/* variable name __tbl2 needs to be different from __tbl1
+ * in the macro below to avoid confusing clang
+ */
+#define ovpn_get_hash_slot(_tbl, _key, _key_len) ({	\
+	typeof(_tbl) *__tbl2 = &(_tbl);			\
+	jhash(_key, _key_len, 0) % HASH_SIZE(*__tbl2);	\
+})
+
+#define ovpn_get_hash_head(_tbl, _key, _key_len) ({		\
+	typeof(_tbl) *__tbl1 = &(_tbl);				\
+	&(*__tbl1)[ovpn_get_hash_slot(*__tbl1, _key, _key_len)];\
+})
+
+/**
+ * ovpn_peer_get_by_vpn_addr4 - retrieve peer by its VPN IPv4 address
+ * @ovpn: the openvpn instance to search
+ * @addr: VPN IPv4 to use as search key
+ *
+ * Refcounter is not increased for the returned peer.
+ *
+ * Return: the peer if found or NULL otherwise
+ */
+static struct ovpn_peer *ovpn_peer_get_by_vpn_addr4(struct ovpn_priv *ovpn,
+						    __be32 addr)
+{
+	struct hlist_nulls_head *nhead;
+	struct hlist_nulls_node *ntmp;
+	struct ovpn_peer *tmp;
+	unsigned int slot;
+
+begin:
+	slot = ovpn_get_hash_slot(ovpn->peers->by_vpn_addr, &addr,
+				  sizeof(addr));
+	nhead = &ovpn->peers->by_vpn_addr[slot];
+
+	hlist_nulls_for_each_entry_rcu(tmp, ntmp, nhead, hash_entry_addr4)
+		if (addr == tmp->vpn_addrs.ipv4.s_addr)
+			return tmp;
+
+	/* item may have moved during lookup - check nulls and restart
+	 * if that's the case
+	 */
+	if (get_nulls_value(ntmp) != slot)
+		goto begin;
+
+	return NULL;
+}
+
+/**
+ * ovpn_peer_get_by_vpn_addr6 - retrieve peer by its VPN IPv6 address
+ * @ovpn: the openvpn instance to search
+ * @addr: VPN IPv6 to use as search key
+ *
+ * Refcounter is not increased for the returned peer.
+ *
+ * Return: the peer if found or NULL otherwise
+ */
+static struct ovpn_peer *ovpn_peer_get_by_vpn_addr6(struct ovpn_priv *ovpn,
+						    struct in6_addr *addr)
+{
+	struct hlist_nulls_head *nhead;
+	struct hlist_nulls_node *ntmp;
+	struct ovpn_peer *tmp;
+	unsigned int slot;
+
+begin:
+	slot = ovpn_get_hash_slot(ovpn->peers->by_vpn_addr, addr,
+				  sizeof(*addr));
+	nhead = &ovpn->peers->by_vpn_addr[slot];
+
+	hlist_nulls_for_each_entry_rcu(tmp, ntmp, nhead, hash_entry_addr6)
+		if (ipv6_addr_equal(addr, &tmp->vpn_addrs.ipv6))
+			return tmp;
+
+	/* item may have moved during lookup - check nulls and restart
+	 * if that's the case
+	 */
+	if (get_nulls_value(ntmp) != slot)
+		goto begin;
+
+	return NULL;
+}
+
 /**
  * ovpn_peer_transp_match - check if sockaddr and peer binding match
  * @peer: the peer to get the binding from
@@ -213,14 +329,43 @@ ovpn_peer_get_by_transp_addr_p2p(struct ovpn_priv *ovpn,
 struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_priv *ovpn,
 					       struct sk_buff *skb)
 {
-	struct ovpn_peer *peer = NULL;
+	struct ovpn_peer *tmp, *peer = NULL;
 	struct sockaddr_storage ss = { 0 };
+	struct hlist_nulls_head *nhead;
+	struct hlist_nulls_node *ntmp;
+	unsigned int slot;
+	size_t sa_len;
 
-	if (unlikely(!ovpn_peer_skb_to_sockaddr(skb, &ss)))
+	sa_len = ovpn_peer_skb_to_sockaddr(skb, &ss);
+	if (unlikely(sa_len < 0))
 		return NULL;
 
 	if (ovpn->mode == OVPN_MODE_P2P)
-		peer = ovpn_peer_get_by_transp_addr_p2p(ovpn, &ss);
+		return ovpn_peer_get_by_transp_addr_p2p(ovpn, &ss);
+
+	rcu_read_lock();
+begin:
+	slot = ovpn_get_hash_slot(ovpn->peers->by_transp_addr, &ss, sa_len);
+	nhead = &ovpn->peers->by_transp_addr[slot];
+
+	hlist_nulls_for_each_entry_rcu(tmp, ntmp, nhead,
+				       hash_entry_transp_addr) {
+		if (!ovpn_peer_transp_match(tmp, &ss))
+			continue;
+
+		if (!ovpn_peer_hold(tmp))
+			continue;
+
+		peer = tmp;
+		break;
+	}
+
+	/* item may have moved during lookup - check nulls and restart
+	 * if that's the case
+	 */
+	if (!peer && get_nulls_value(ntmp) != slot)
+		goto begin;
+	rcu_read_unlock();
 
 	return peer;
 }
@@ -255,10 +400,27 @@ static struct ovpn_peer *ovpn_peer_get_by_id_p2p(struct ovpn_priv *ovpn,
  */
 struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_priv *ovpn, u32 peer_id)
 {
-	struct ovpn_peer *peer = NULL;
+	struct ovpn_peer *tmp, *peer = NULL;
+	struct hlist_head *head;
 
 	if (ovpn->mode == OVPN_MODE_P2P)
-		peer = ovpn_peer_get_by_id_p2p(ovpn, peer_id);
+		return ovpn_peer_get_by_id_p2p(ovpn, peer_id);
+
+	head = ovpn_get_hash_head(ovpn->peers->by_id, &peer_id,
+				  sizeof(peer_id));
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(tmp, head, hash_entry_id) {
+		if (tmp->id != peer_id)
+			continue;
+
+		if (!ovpn_peer_hold(tmp))
+			continue;
+
+		peer = tmp;
+		break;
+	}
+	rcu_read_unlock();
 
 	return peer;
 }
@@ -280,6 +442,8 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
 				       struct sk_buff *skb)
 {
 	struct ovpn_peer *peer = NULL;
+	struct in6_addr addr6;
+	__be32 addr4;
 
 	/* in P2P mode, no matter the destination, packets are always sent to
 	 * the single peer listening on the other side
@@ -290,11 +454,109 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_priv *ovpn,
 		if (unlikely(peer && !ovpn_peer_hold(peer)))
 			peer = NULL;
 		rcu_read_unlock();
+		return peer;
 	}
 
+	rcu_read_lock();
+	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		addr4 = ovpn_nexthop_from_skb4(skb);
+		peer = ovpn_peer_get_by_vpn_addr4(ovpn, addr4);
+		break;
+	case htons(ETH_P_IPV6):
+		addr6 = ovpn_nexthop_from_skb6(skb);
+		peer = ovpn_peer_get_by_vpn_addr6(ovpn, &addr6);
+		break;
+	}
+
+	if (unlikely(peer && !ovpn_peer_hold(peer)))
+		peer = NULL;
+	rcu_read_unlock();
+
 	return peer;
 }
 
+/**
+ * ovpn_nexthop_from_rt4 - look up the IPv4 nexthop for the given destination
+ * @ovpn: the private data representing the current VPN session
+ * @dest: the destination to be looked up
+ *
+ * Looks up in the IPv4 system routing table the IP of the nexthop to be used
+ * to reach the destination passed as argument. If no nexthop can be found, the
+ * destination itself is returned as it probably has to be used as nexthop.
+ *
+ * Return: the IP of the next hop if found or dest itself otherwise
+ */
+static __be32 ovpn_nexthop_from_rt4(struct ovpn_priv *ovpn, __be32 dest)
+{
+	struct rtable *rt;
+	struct flowi4 fl = {
+		.daddr = dest
+	};
+
+	rt = ip_route_output_flow(dev_net(ovpn->dev), &fl, NULL);
+	if (IS_ERR(rt)) {
+		net_dbg_ratelimited("%s: no route to host %pI4\n",
+				    netdev_name(ovpn->dev), &dest);
+		/* if we end up here this packet is probably going to be
+		 * thrown away later
+		 */
+		return dest;
+	}
+
+	if (!rt->rt_uses_gateway)
+		goto out;
+
+	dest = rt->rt_gw4;
+out:
+	ip_rt_put(rt);
+	return dest;
+}
+
+/**
+ * ovpn_nexthop_from_rt6 - look up the IPv6 nexthop for the given destination
+ * @ovpn: the private data representing the current VPN session
+ * @dest: the destination to be looked up
+ *
+ * Looks up in the IPv6 system routing table the IP of the nexthop to be used
+ * to reach the destination passed as argument. If no nexthop can be found, the
+ * destination itself is returned as it probably has to be used as nexthop.
+ *
+ * Return: the IP of the next hop if found or dest itself otherwise
+ */
+static struct in6_addr ovpn_nexthop_from_rt6(struct ovpn_priv *ovpn,
+					     struct in6_addr dest)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	struct dst_entry *entry;
+	struct rt6_info *rt;
+	struct flowi6 fl = {
+		.daddr = dest,
+	};
+
+	entry = ipv6_stub->ipv6_dst_lookup_flow(dev_net(ovpn->dev), NULL, &fl,
+						NULL);
+	if (IS_ERR(entry)) {
+		net_dbg_ratelimited("%s: no route to host %pI6c\n",
+				    netdev_name(ovpn->dev), &dest);
+		/* if we end up here this packet is probably going to be
+		 * thrown away later
+		 */
+		return dest;
+	}
+
+	rt = dst_rt6_info(entry);
+
+	if (!(rt->rt6i_flags & RTF_GATEWAY))
+		goto out;
+
+	dest = rt->rt6i_gateway;
+out:
+	dst_release((struct dst_entry *)rt);
+#endif
+	return dest;
+}
+
 /**
  * ovpn_peer_check_by_src - check that skb source is routed via peer
  * @ovpn: the openvpn instance to search
@@ -307,21 +569,40 @@ bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 			    struct ovpn_peer *peer)
 {
 	bool match = false;
+	struct in6_addr addr6;
+	__be32 addr4;
 
 	if (ovpn->mode == OVPN_MODE_P2P) {
 		/* in P2P mode, no matter the destination, packets are always
 		 * sent to the single peer listening on the other side
 		 */
-		match = (peer == rcu_access_pointer(ovpn->peer));
+		return peer == rcu_access_pointer(ovpn->peer);
+	}
+
+	/* This function performs a reverse path check, therefore we now
+	 * lookup the nexthop we would use if we wanted to route a packet
+	 * to the source IP. If the nexthop matches the sender we know the
+	 * latter is valid and we allow the packet to come in
+	 */
+
+	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		addr4 = ovpn_nexthop_from_rt4(ovpn, ip_hdr(skb)->saddr);
+		rcu_read_lock();
+		match = (peer == ovpn_peer_get_by_vpn_addr4(ovpn, addr4));
+		rcu_read_unlock();
+		break;
+	case htons(ETH_P_IPV6):
+		addr6 = ovpn_nexthop_from_rt6(ovpn, ipv6_hdr(skb)->saddr);
+		rcu_read_lock();
+		match = (peer == ovpn_peer_get_by_vpn_addr6(ovpn, &addr6));
+		rcu_read_unlock();
+		break;
 	}
 
 	return match;
 }
 
-#define ovpn_get_hash_head(_tbl, _key, _key_len) ({		\
-	typeof(_tbl) *__tbl = &(_tbl);				\
-	(&(*__tbl)[jhash(_key, _key_len, 0) % HASH_SIZE(*__tbl)]); }) \
-
 /**
  * ovpn_peer_add_mp - add peer to related tables in a MP instance
  * @ovpn: the instance to add the peer to

-- 
2.45.2


