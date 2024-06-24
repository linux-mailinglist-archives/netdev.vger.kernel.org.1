Return-Path: <netdev+bounces-106090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 953F99148BD
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151DB1F233E5
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 11:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393B113B2B8;
	Mon, 24 Jun 2024 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="axaIwgrM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D86913CFA8
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 11:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228616; cv=none; b=P3Mhhms3+csz6sW8/pBHo8C+XNFvowFQ+ON9GLuQqsbZYFR5UDJ23zpyAxhv7bQB9A6pWni1EjhaBTVkZvOAUQ3LFDyOR6Vxoe0WotfhHpuX3zUDaYZfR7v7aCEUdM1OwP04tr8JcublGeQ6qFuQf3X7H/yjka1wj2aHLJ4NKMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228616; c=relaxed/simple;
	bh=qYqT6SxmMGdUleJMKZZkNs/BPGhUizzIp9terqrygdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZCkjzKS7KB6xlxMZ/JiLayy/KAtgy/hOCqJUopsoPQXLblCWwz+0uQGOouyhKKvR03cleU8YmcZ3idNOid5/gq7gLGx2k4ncMCxJVnrHS1KIiE68ceMINjFoelBw5/nRTNFq6h8e8crrhRH74o30xbmjbwlbSMXqyWkO/8SQRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=axaIwgrM; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3632a6437d7so2425975f8f.0
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 04:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1719228611; x=1719833411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVR9ZF69rZ+eufAzXd1r40HORnaYjl1CoaJC6uup5sE=;
        b=axaIwgrMc0MnECarCJ+jPgsdXupk9/2VufF5tv6wFRGshA6HkXQkKnSUaIkxMyJkzk
         ys3IhgAbfZiFLcZ4EJs6arXCgW5F5//ISUUhobZZjEDUwo0vmmLBiHqWwbHLcZ9ZjbyF
         9r0DzqdovEmK2yF6ayllf6q+rIozCSkjDyB/OZF0WBKXrFbWWJKWZh+OfW64ig6dtOhD
         DC5QbG9p1ROqst7AlOipbmy+690nncFmAHOpwhrNMdSm78huWuv2f2zoh+UvjRA/A12w
         jgDsHP+fGhn6eIuEHOuVZyZhf01cmdkg0uK5x+u1B17YryvYnJj0vq2QwT/wSMWc3e6u
         1XjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228611; x=1719833411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVR9ZF69rZ+eufAzXd1r40HORnaYjl1CoaJC6uup5sE=;
        b=X60h32GMJylwQKhyrDPlWU3yOPKFr76x0kSspbXo1sFTxhD7jbXHPemw0V4vXdDNtJ
         LdMtV2TtbFZYW8phJQR3NKcDie89//mM5yU2+Euedi3O7OIZIBonCx8pU1IMRGwn5siN
         j8+hChNX4P7EBFdJnfN2e6L/wUZdNf9bzcWtdhMJ01TCVCqvI2lNvG2ah+YLUxrHiJnT
         u1kX5cbxcN+pELhjnFdG5+4RNrFNEElEzpMaI38XGRKDioqFDSMYpS4ENSwxHTloRUmO
         y8J2Xk42TJof6iZ0aD3EwM9phfH2ssE/q+yG9h+mzlWIczHzhEr4a3LBdHTxCk/Zd7U5
         bFnQ==
X-Gm-Message-State: AOJu0Yx8AjmhtjHRcQ5NZgChc4CZtGhxwbPUwn3flh7gKkRLN/ordkts
	6R5unvn8WOoHNCB2pyjFxjQRoroZbgi/myEhPp7DXCf67leeHn7DGHypzF3YSJ1PYsPM13huUQA
	J
X-Google-Smtp-Source: AGHT+IHlJi6IGnQFafkofFU+WJSdpfslSxubU5q1SpHm82nXYz8kisBtsOEq5eNOFoA/Fn+EiZKv5A==
X-Received: by 2002:adf:f68c:0:b0:362:23d5:3928 with SMTP id ffacd0b85a97d-366e3293282mr4295738f8f.17.1719228611364;
        Mon, 24 Jun 2024 04:30:11 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:2317:eae2:ae3c:f110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c7c79sm9794397f8f.96.2024.06.24.04.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:30:11 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ryazanov.s.a@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v4 20/25] ovpn: implement peer add/dump/delete via netlink
Date: Mon, 24 Jun 2024 13:31:17 +0200
Message-ID: <20240624113122.12732-21-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240624113122.12732-1-antonio@openvpn.net>
References: <20240624113122.12732-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change introduces the netlink command needed to add, delete and
retrieve/dump known peers. Userspace is expected to use these commands
to handle known peer lifecycles.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 487 ++++++++++++++++++++++++++++++++++++-
 drivers/net/ovpn/peer.c    |   8 +-
 drivers/net/ovpn/peer.h    |   4 +
 3 files changed, 490 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 28f2216214b0..8e2b303ac7ac 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -8,6 +8,7 @@
 
 #include <linux/netdevice.h>
 #include <linux/rtnetlink.h>
+#include <linux/types.h>
 #include <net/genetlink.h>
 
 #include <uapi/linux/ovpn.h>
@@ -17,6 +18,10 @@
 #include "io.h"
 #include "netlink.h"
 #include "netlink-gen.h"
+#include "bind.h"
+#include "packet.h"
+#include "peer.h"
+#include "socket.h"
 
 MODULE_ALIAS_GENL_FAMILY(OVPN_FAMILY_NAME);
 
@@ -29,7 +34,7 @@ MODULE_ALIAS_GENL_FAMILY(OVPN_FAMILY_NAME);
  * Return: the netdevice, if found, or an error otherwise
  */
 static struct net_device *
-ovpn_get_dev_from_attrs(struct net *net, struct genl_info *info)
+ovpn_get_dev_from_attrs(struct net *net, const struct genl_info *info)
 {
 	struct net_device *dev;
 	int ifindex;
@@ -141,24 +146,496 @@ int ovpn_nl_del_iface_doit(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
+static u8 *ovpn_nl_attr_local_ip(struct genl_info *info,
+				 struct ovpn_struct *ovpn,
+				 struct nlattr **attrs, int sock_fam)
+{
+	size_t ip_len = nla_len(attrs[OVPN_A_PEER_LOCAL_IP]);
+	u8 *local_ip = nla_data(attrs[OVPN_A_PEER_LOCAL_IP]);
+	bool is_mapped;
+
+	if (ip_len == sizeof(struct in_addr)) {
+		if (sock_fam != AF_INET) {
+			NL_SET_ERR_MSG_MOD(info->extack,
+					   "mismatching AF between local IP (v4) and peer");
+			return ERR_PTR(-EINVAL);
+		}
+	} else if (ip_len == sizeof(struct in6_addr)) {
+		is_mapped = ipv6_addr_v4mapped((struct in6_addr *)local_ip);
+
+		if (sock_fam != AF_INET6 && !is_mapped) {
+			NL_SET_ERR_MSG_MOD(info->extack,
+					   "mismatching AF between local IP (v6) and peer");
+			return ERR_PTR(-EINVAL);
+		}
+
+		if (is_mapped)
+			/* this is an IPv6-mapped IPv4
+			 * address, therefore extract
+			 * the actual v4 address from
+			 * the last 4 bytes
+			 */
+			local_ip += 12;
+	} else {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "invalid local IP length: %zu", ip_len);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return local_ip;
+}
+
 int ovpn_nl_set_peer_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	bool keepalive_set = false, new_peer = false;
+	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
+	struct ovpn_struct *ovpn = info->user_ptr[0];
+	struct sockaddr_storage *ss = NULL;
+	u32 sockfd, id, interv, timeout;
+	struct socket *sock = NULL;
+	struct sockaddr_in mapped;
+	struct sockaddr_in6 *in6;
+	struct ovpn_peer *peer;
+	u8 *local_ip = NULL;
+	size_t sa_len;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_PEER))
+		return -EINVAL;
+
+	ret = nla_parse_nested(attrs, OVPN_A_PEER_MAX, info->attrs[OVPN_A_PEER],
+			       ovpn_peer_nl_policy, info->extack);
+	if (ret)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], attrs,
+			      OVPN_A_PEER_ID))
+		return -EINVAL;
+
+	id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
+	/* check if the peer exists first, otherwise create a new one */
+	peer = ovpn_peer_get_by_id(ovpn, id);
+	if (!peer) {
+		peer = ovpn_peer_new(ovpn, id);
+		new_peer = true;
+		if (IS_ERR(peer)) {
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "cannot create new peer object for peer %u (sockaddr=%pIScp): %ld",
+					       id, ss, PTR_ERR(peer));
+			return PTR_ERR(peer);
+		}
+	}
+
+	if (new_peer && NL_REQ_ATTR_CHECK(info->extack,
+					  info->attrs[OVPN_A_PEER], attrs,
+					  OVPN_A_PEER_SOCKET)) {
+		ret = -EINVAL;
+		goto peer_release;
+	}
+
+	if (new_peer && ovpn->mode == OVPN_MODE_MP &&
+	    !attrs[OVPN_A_PEER_VPN_IPV4] && !attrs[OVPN_A_PEER_VPN_IPV6]) {
+		NL_SET_ERR_MSG_MOD(info->extack,
+				   "a VPN IP is required when adding a peer in MP mode");
+		ret = -EINVAL;
+		goto peer_release;
+	}
+
+	if (attrs[OVPN_A_PEER_SOCKET]) {
+		/* lookup the fd in the kernel table and extract the socket
+		 * object
+		 */
+		sockfd = nla_get_u32(attrs[OVPN_A_PEER_SOCKET]);
+		/* sockfd_lookup() increases sock's refcounter */
+		sock = sockfd_lookup(sockfd, &ret);
+		if (!sock) {
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "cannot lookup peer socket (fd=%u): %d",
+					       sockfd, ret);
+			ret = -ENOTSOCK;
+			goto peer_release;
+		}
+
+		if (peer->sock)
+			ovpn_socket_put(peer->sock);
+
+		peer->sock = ovpn_socket_new(sock, peer);
+		if (IS_ERR(peer->sock)) {
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "cannot encapsulate socket: %ld",
+					       PTR_ERR(peer->sock));
+			sockfd_put(sock);
+			peer->sock = NULL;
+			ret = -ENOTSOCK;
+			goto peer_release;
+		}
+	}
+
+	/* Only when using UDP as transport protocol the remote endpoint
+	 * can be configured so that ovpn knows where to send packets
+	 * to.
+	 *
+	 * In case of TCP, the socket is connected to the peer and ovpn
+	 * will just send bytes over it, without the need to specify a
+	 * destination.
+	 */
+	if (peer->sock->sock->sk->sk_protocol == IPPROTO_UDP &&
+	    attrs[OVPN_A_PEER_SOCKADDR_REMOTE]) {
+		ss = nla_data(attrs[OVPN_A_PEER_SOCKADDR_REMOTE]);
+		sa_len = nla_len(attrs[OVPN_A_PEER_SOCKADDR_REMOTE]);
+		switch (sa_len) {
+		case sizeof(struct sockaddr_in):
+			if (ss->ss_family == AF_INET)
+				/* valid sockaddr */
+				break;
+
+			NL_SET_ERR_MSG_MOD(info->extack,
+					   "remote sockaddr_in has invalid family");
+			ret = -EINVAL;
+			goto peer_release;
+		case sizeof(struct sockaddr_in6):
+			if (ss->ss_family == AF_INET6)
+				/* valid sockaddr */
+				break;
+
+			NL_SET_ERR_MSG_MOD(info->extack,
+					   "remote sockaddr_in6 has invalid family");
+			ret = -EINVAL;
+			goto peer_release;
+		default:
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "invalid size for sockaddr: %zd",
+					       sa_len);
+			ret = -EINVAL;
+			goto peer_release;
+		}
+
+		/* if this is a v6-mapped-v4, convert the sockaddr
+		 * object from AF_INET6 to AF_INET before continue
+		 * processing
+		 */
+		if (ss->ss_family == AF_INET6) {
+			in6 = (struct sockaddr_in6 *)ss;
+
+			if (ipv6_addr_v4mapped(&in6->sin6_addr)) {
+				mapped.sin_family = AF_INET;
+				mapped.sin_addr.s_addr =
+					in6->sin6_addr.s6_addr32[3];
+				mapped.sin_port = in6->sin6_port;
+				ss = (struct sockaddr_storage *)&mapped;
+			}
+		}
+
+		if (attrs[OVPN_A_PEER_LOCAL_IP]) {
+			local_ip = ovpn_nl_attr_local_ip(info, ovpn,
+							 attrs,
+							 ss->ss_family);
+			if (IS_ERR(local_ip)) {
+				ret = PTR_ERR(local_ip);
+				NL_SET_ERR_MSG_FMT_MOD(info->extack,
+						       "cannot retrieve local IP: %d",
+						       ret);
+				goto peer_release;
+			}
+		}
+
+		/* set peer sockaddr */
+		ret = ovpn_peer_reset_sockaddr(peer, ss, local_ip);
+		if (ret < 0) {
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "cannot set peer sockaddr: %d",
+					       ret);
+			goto peer_release;
+		}
+	}
+
+	/* VPN IPs cannot be updated, because they are hashed */
+	if (new_peer && attrs[OVPN_A_PEER_VPN_IPV4])
+		peer->vpn_addrs.ipv4.s_addr =
+			nla_get_in_addr(attrs[OVPN_A_PEER_VPN_IPV4]);
+
+	/* VPN IPs cannot be updated, because they are hashed */
+	if (new_peer && attrs[OVPN_A_PEER_VPN_IPV6])
+		peer->vpn_addrs.ipv6 =
+			nla_get_in6_addr(attrs[OVPN_A_PEER_VPN_IPV6]);
+
+	/* when setting the keepalive, both parameters have to be configured */
+	if (attrs[OVPN_A_PEER_KEEPALIVE_INTERVAL] &&
+	    attrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT]) {
+		keepalive_set = true;
+		interv = nla_get_u32(attrs[OVPN_A_PEER_KEEPALIVE_INTERVAL]);
+		timeout = nla_get_u32(attrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT]);
+	}
+
+	if (keepalive_set)
+		ovpn_peer_keepalive_set(peer, interv, timeout);
+
+	netdev_dbg(ovpn->dev,
+		   "%s: %s peer with endpoint=%pIScp/%s id=%u VPN-IPv4=%pI4 VPN-IPv6=%pI6c\n",
+		   __func__, (new_peer ? "adding" : "modifying"), ss,
+		   peer->sock->sock->sk->sk_prot_creator->name, peer->id,
+		   &peer->vpn_addrs.ipv4.s_addr, &peer->vpn_addrs.ipv6);
+
+	if (new_peer) {
+		ret = ovpn_peer_add(ovpn, peer);
+		if (ret < 0) {
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "cannot add new peer (id=%u) to hashtable: %d\n",
+					       peer->id, ret);
+			goto peer_release;
+		}
+	} else {
+		ovpn_peer_put(peer);
+	}
+
+	return 0;
+
+peer_release:
+	if (new_peer) {
+		/* release right away because peer is not really used in any
+		 * context
+		 */
+		ovpn_peer_release(peer);
+		kfree(peer);
+	} else {
+		ovpn_peer_put(peer);
+	}
+
+	return ret;
+}
+
+static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
+			     const struct ovpn_peer *peer, u32 portid, u32 seq,
+			     int flags)
+{
+	const struct ovpn_bind *bind;
+	struct nlattr *attr;
+	void *hdr;
+
+	hdr = genlmsg_put(skb, portid, seq, &ovpn_nl_family, flags,
+			  OVPN_CMD_SET_PEER);
+	if (!hdr)
+		return -ENOBUFS;
+
+	attr = nla_nest_start(skb, OVPN_A_PEER);
+	if (!attr)
+		goto err;
+
+	if (nla_put_u32(skb, OVPN_A_PEER_ID, peer->id))
+		goto err;
+
+	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY))
+		if (nla_put_in_addr(skb, OVPN_A_PEER_VPN_IPV4,
+				    peer->vpn_addrs.ipv4.s_addr))
+			goto err;
+
+	if (!ipv6_addr_equal(&peer->vpn_addrs.ipv6, &in6addr_any))
+		if (nla_put_in6_addr(skb, OVPN_A_PEER_VPN_IPV6,
+				     &peer->vpn_addrs.ipv6))
+			goto err;
+
+	if (nla_put_u32(skb, OVPN_A_PEER_KEEPALIVE_INTERVAL,
+			peer->keepalive_interval) ||
+	    nla_put_u32(skb, OVPN_A_PEER_KEEPALIVE_TIMEOUT,
+			peer->keepalive_timeout))
+		goto err;
+
+	rcu_read_lock();
+	bind = rcu_dereference(peer->bind);
+	if (bind) {
+		if (bind->sa.in4.sin_family == AF_INET) {
+			if (nla_put(skb, OVPN_A_PEER_SOCKADDR_REMOTE,
+				    sizeof(bind->sa.in4), &bind->sa.in4) ||
+			    nla_put(skb, OVPN_A_PEER_LOCAL_IP,
+				    sizeof(bind->local.ipv4),
+				    &bind->local.ipv4))
+				goto err_unlock;
+		} else if (bind->sa.in4.sin_family == AF_INET6) {
+			if (nla_put(skb, OVPN_A_PEER_SOCKADDR_REMOTE,
+				    sizeof(bind->sa.in6), &bind->sa.in6) ||
+			    nla_put(skb, OVPN_A_PEER_LOCAL_IP,
+				    sizeof(bind->local.ipv6),
+				    &bind->local.ipv6))
+				goto err_unlock;
+		}
+	}
+	rcu_read_unlock();
+
+	if (nla_put_net16(skb, OVPN_A_PEER_LOCAL_PORT,
+			  inet_sk(peer->sock->sock->sk)->inet_sport) ||
+	    /* VPN RX stats */
+	    nla_put_uint(skb, OVPN_A_PEER_VPN_RX_BYTES,
+			 atomic64_read(&peer->vpn_stats.rx.bytes)) ||
+	    nla_put_uint(skb, OVPN_A_PEER_VPN_RX_PACKETS,
+			 atomic64_read(&peer->vpn_stats.rx.packets)) ||
+	    /* VPN TX stats */
+	    nla_put_uint(skb, OVPN_A_PEER_VPN_TX_BYTES,
+			 atomic64_read(&peer->vpn_stats.tx.bytes)) ||
+	    nla_put_uint(skb, OVPN_A_PEER_VPN_TX_PACKETS,
+			 atomic64_read(&peer->vpn_stats.tx.packets)) ||
+	    /* link RX stats */
+	    nla_put_uint(skb, OVPN_A_PEER_LINK_RX_BYTES,
+			 atomic64_read(&peer->link_stats.rx.bytes)) ||
+	    nla_put_uint(skb, OVPN_A_PEER_LINK_RX_PACKETS,
+			 atomic64_read(&peer->link_stats.rx.packets)) ||
+	    /* link TX stats */
+	    nla_put_uint(skb, OVPN_A_PEER_LINK_TX_BYTES,
+			 atomic64_read(&peer->link_stats.tx.bytes)) ||
+	    nla_put_uint(skb, OVPN_A_PEER_LINK_TX_PACKETS,
+			 atomic64_read(&peer->link_stats.tx.packets)))
+		goto err;
+
+	nla_nest_end(skb, attr);
+	genlmsg_end(skb, hdr);
+
+	return 0;
+err_unlock:
+	rcu_read_unlock();
+err:
+	genlmsg_cancel(skb, hdr);
+	return -EMSGSIZE;
 }
 
 int ovpn_nl_get_peer_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
+	struct ovpn_struct *ovpn = info->user_ptr[0];
+	struct ovpn_peer *peer;
+	struct sk_buff *msg;
+	u32 peer_id;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_PEER))
+		return -EINVAL;
+
+	ret = nla_parse_nested(attrs, OVPN_A_PEER_MAX, info->attrs[OVPN_A_PEER],
+			       ovpn_peer_nl_policy, info->extack);
+	if (ret)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], attrs,
+			      OVPN_A_PEER_ID))
+		return -EINVAL;
+
+	peer_id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
+	peer = ovpn_peer_get_by_id(ovpn, peer_id);
+	if (!peer) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "cannot find peer with id %u", peer_id);
+		return -ENOENT;
+	}
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	ret = ovpn_nl_send_peer(msg, info, peer, info->snd_portid,
+				info->snd_seq, 0);
+	if (ret < 0) {
+		nlmsg_free(msg);
+		goto err;
+	}
+
+	ret = genlmsg_reply(msg, info);
+err:
+	ovpn_peer_put(peer);
+	return ret;
 }
 
 int ovpn_nl_get_peer_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 {
-	return -EOPNOTSUPP;
+	const struct genl_info *info = genl_info_dump(cb);
+	struct ovpn_struct *ovpn;
+	struct ovpn_peer *peer;
+	struct net_device *dev;
+	int bkt, last_idx = cb->args[1], dumped = 0;
+
+	dev = ovpn_get_dev_from_attrs(sock_net(cb->skb->sk), info);
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	ovpn = netdev_priv(dev);
+
+	if (ovpn->mode == OVPN_MODE_P2P) {
+		/* if we already dumped a peer it means we are done */
+		if (last_idx)
+			goto out;
+
+		rcu_read_lock();
+		peer = rcu_dereference(ovpn->peer);
+		if (peer) {
+			if (ovpn_nl_send_peer(skb, info, peer,
+					      NETLINK_CB(cb->skb).portid,
+					      cb->nlh->nlmsg_seq,
+					      NLM_F_MULTI) == 0)
+				dumped++;
+		}
+		rcu_read_unlock();
+	} else {
+		rcu_read_lock();
+		hash_for_each_rcu(ovpn->peers->by_id, bkt, peer,
+				  hash_entry_id) {
+			/* skip already dumped peers that were dumped by
+			 * previous invocations
+			 */
+			if (last_idx > 0) {
+				last_idx--;
+				continue;
+			}
+
+			if (ovpn_nl_send_peer(skb, info, peer,
+					      NETLINK_CB(cb->skb).portid,
+					      cb->nlh->nlmsg_seq,
+					      NLM_F_MULTI) < 0)
+				break;
+
+			/* count peers being dumped during this invocation */
+			dumped++;
+		}
+		rcu_read_unlock();
+	}
+
+out:
+	netdev_put(dev, NULL);
+
+	/* sum up peers dumped in this message, so that at the next invocation
+	 * we can continue from where we left
+	 */
+	cb->args[1] += dumped;
+	return skb->len;
 }
 
 int ovpn_nl_del_peer_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -EOPNOTSUPP;
+	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
+	struct ovpn_struct *ovpn = info->user_ptr[0];
+	struct ovpn_peer *peer;
+	u32 peer_id;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_PEER))
+		return -EINVAL;
+
+	ret = nla_parse_nested(attrs, OVPN_A_PEER_MAX, info->attrs[OVPN_A_PEER],
+			       ovpn_peer_nl_policy, info->extack);
+	if (ret)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], attrs,
+			      OVPN_A_PEER_ID))
+		return -EINVAL;
+
+	peer_id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
+
+	peer = ovpn_peer_get_by_id(ovpn, peer_id);
+	if (!peer)
+		return -ENOENT;
+
+	netdev_dbg(ovpn->dev, "%s: peer id=%u\n", __func__, peer->id);
+	ret = ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_USERSPACE);
+	ovpn_peer_put(peer);
+
+	return ret;
 }
 
 int ovpn_nl_set_key_doit(struct sk_buff *skb, struct genl_info *info)
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index c07d148c52b4..2105bcc981fa 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -134,9 +134,9 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
  *
  * Return: 0 on success or a negative error code otherwise
  */
-static int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
-				    const struct sockaddr_storage *ss,
-				    const u8 *local_ip)
+int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
+			     const struct sockaddr_storage *ss,
+			     const u8 *local_ip)
 {
 	struct ovpn_bind *bind;
 	size_t ip_len;
@@ -251,7 +251,7 @@ static void ovpn_peer_timer_delete_all(struct ovpn_peer *peer)
  * ovpn_peer_release - release peer private members
  * @peer: the peer to release
  */
-static void ovpn_peer_release(struct ovpn_peer *peer)
+void ovpn_peer_release(struct ovpn_peer *peer)
 {
 	if (peer->sock)
 		ovpn_socket_put(peer->sock);
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 691cf20bd870..8d24a8fdd03e 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -127,6 +127,7 @@ static inline bool ovpn_peer_hold(struct ovpn_peer *peer)
 	return kref_get_unless_zero(&peer->refcount);
 }
 
+void ovpn_peer_release(struct ovpn_peer *peer);
 void ovpn_peer_release_kref(struct kref *kref);
 
 /**
@@ -193,5 +194,8 @@ void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
 				     struct sk_buff *skb);
 
 void ovpn_peer_float(struct ovpn_peer *peer, struct sk_buff *skb);
+int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
+			     const struct sockaddr_storage *ss,
+			     const u8 *local_ip);
 
 #endif /* _NET_OVPN_OVPNPEER_H_ */
-- 
2.44.2


