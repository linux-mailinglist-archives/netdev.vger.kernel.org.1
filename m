Return-Path: <netdev+bounces-77146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D32868704EC
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88DB02885AE
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 15:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908E14D584;
	Mon,  4 Mar 2024 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="bP0N1fYS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1285C4D12D
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 15:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564967; cv=none; b=Cigwx3fB1QdD81V3MHY/qxJY7R0i2tuTg1OTDqOqZe3KwwosS339KAXWqjxCMW9GQQX9GO3yT0v5D124swr/0xxv+yqIVj/ak0TNGaVTpGxXbsfNiX/TdAuZDVoCPp9a/6ovwlb04UKdbXWFeF5kgiz/sYx5JXC5yf4VmQOgDrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564967; c=relaxed/simple;
	bh=5MgLaAkFXDC/0EMoMK9I6uHJLgyHow941rhl9qjaPHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1QocGRQS4RrbqHm3Rw+s2Fz70mJUkO/bfYRPbwT+Z8tMVYER0x9mhklHEK4LP5u5Vk/bsz0FIohaqWOoaVvR4eLIsyAXQSdnCQ9OkOijYZxAib1yHYmIPpy7s7/qSpIXWx7tqbib4J56un4MhN39u6FNladniCCtKE9zOTF2TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=bP0N1fYS; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51320ca689aso5390816e87.2
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 07:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709564962; x=1710169762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C15jX4858cgAiuS3Dp9IuxWxDTLUOmonSQQThBXnyoY=;
        b=bP0N1fYSvaTHi5RCCS1zEwMG+u1+Kkv4gEZ6OsFFEjneYwZRFnI1F1nCfLSJi/mG+L
         hGa2vhZ4+WRX3zksVA/JEqkioUNP2JNrHEcC+tjzc/jhkqz0cBU2fb5jAj9/Iy86thIc
         ABK0InPUjMvFIE/ISVnm2KF2KgJeckfqwjx6pifNLpSg1j3YsXTzMq75yyQ1cwgBoNoK
         jJpaavCIaYYsOrTFVy/zBLlscYL8Qzpbdeg2bkXy1duLUp6wsDIg3OkUSMUnSGvzhdyo
         HB6/1gvPKcAxrjavNeycgpCJHaysckb1je/1GS0PE0Ecq1/5iOHfsYRPyWuQTOGBSSZm
         5+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709564962; x=1710169762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C15jX4858cgAiuS3Dp9IuxWxDTLUOmonSQQThBXnyoY=;
        b=WicYUVK4ZzTpYkmkRyglebb8a2iRKEKn58epwQwgxzhpEKqxReI7debawNSFlAPkb6
         pDlVRAGE4Jg3eY+LcovRIaMWCdWQwxiR+qxlNlk+lI+IdxhzNuPDlDyuwfrAeMpB1LeV
         cyCmNO7m1clXiXtsb4jYNsrXg4GTKRlIZPOKDvoKiwiNmat5RLsYVo3852p2njtRmmwP
         CVBKQtN4GKUfiikQee1FaJIa012Oh4SyIWHeoQU99eoiaTAMFQWGsy7yEBNNC0itSS7l
         jeGF1NRlxPU/q2aaoXPsWUw8cxgoVjdPni8ibZuwvhLGL5W6cdOMQmHsRmDK9wvLIxqp
         dpAw==
X-Gm-Message-State: AOJu0Yw/EMXY2QmTPX1qE/0/akyW8IrMNx/8yNN1OUpY/B+6TOZbAqis
	DaVBhVuP6NO5KFJIB3pwpHY4ShY1wsByyzosOVstvUdSM5eKc+3YPRwjVa+1OaZj2TSf1HNcnex
	d
X-Google-Smtp-Source: AGHT+IFg9LsyJIMoN2YfjjRGbUE6sxYsTUEE8Kbr9x7XLbH/FoRiybCvVS6XnIW/x87x8wQhgboR5Q==
X-Received: by 2002:a19:f710:0:b0:512:e1e3:792f with SMTP id z16-20020a19f710000000b00512e1e3792fmr5987030lfe.3.1709564961833;
        Mon, 04 Mar 2024 07:09:21 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:1d25:beac:2343:34ef])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b00a44d01aff81sm2904069ejb.97.2024.03.04.07.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:09:21 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v2 18/22] ovpn: implement peer add/dump/delete via netlink
Date: Mon,  4 Mar 2024 16:09:09 +0100
Message-ID: <20240304150914.11444-19-antonio@openvpn.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304150914.11444-1-antonio@openvpn.net>
References: <20240304150914.11444-1-antonio@openvpn.net>
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
 drivers/net/ovpn/netlink.c | 474 +++++++++++++++++++++++++++++++++++++
 1 file changed, 474 insertions(+)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 02b41034f615..99ee9889241d 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -10,6 +10,7 @@
 #include "io.h"
 #include "netlink.h"
 #include "ovpnstruct.h"
+#include "peer.h"
 #include "packet.h"
 
 #include <uapi/linux/ovpn.h>
@@ -154,6 +155,463 @@ static void ovpn_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb
 		dev_put(ovpn->dev);
 }
 
+static int ovpn_nl_set_peer(struct sk_buff *skb, struct genl_info *info)
+{
+	bool keepalive_set = false, new_peer = false;
+	struct nlattr *attrs[NUM_OVPN_A_PEER];
+	struct ovpn_struct *ovpn = info->user_ptr[0];
+	struct sockaddr_storage *ss = NULL;
+	u32 sockfd, id, interv, timeout;
+	struct socket *sock = NULL;
+	struct sockaddr_in mapped;
+	struct sockaddr_in6 *in6;
+	struct ovpn_peer *peer;
+	size_t sa_len, ip_len;
+	u8 *local_ip = NULL;
+	int ret;
+
+	if (!info->attrs[OVPN_A_PEER])
+		return -EINVAL;
+
+	ret = nla_parse_nested(attrs, NUM_OVPN_A_PEER - 1, info->attrs[OVPN_A_PEER], NULL,
+			       info->extack);
+	if (ret)
+		return ret;
+
+	if (!attrs[OVPN_A_PEER_ID]) {
+		netdev_err(ovpn->dev, "%s: peer ID missing\n", __func__);
+		return -EINVAL;
+	}
+
+	id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
+	/* check if the peer exists first, otherwise create a new one */
+	peer = ovpn_peer_lookup_id(ovpn, id);
+	if (!peer) {
+		peer = ovpn_peer_new(ovpn, id);
+		new_peer = true;
+		if (IS_ERR(peer)) {
+			netdev_err(ovpn->dev, "%s: cannot create new peer object for peer %u (sockaddr=%pIScp): %ld\n",
+				   __func__, id, ss, PTR_ERR(peer));
+			return PTR_ERR(peer);
+		}
+	}
+
+	if (new_peer && !attrs[OVPN_A_PEER_SOCKET]) {
+		netdev_err(ovpn->dev, "%s: peer socket missing\n", __func__);
+		ret = -EINVAL;
+		goto peer_release;
+	}
+
+	if (new_peer && ovpn->mode == OVPN_MODE_MP && !attrs[OVPN_A_PEER_VPN_IPV4] &&
+	    !attrs[OVPN_A_PEER_VPN_IPV6]) {
+		netdev_err(ovpn->dev, "%s: a VPN IP is required when adding a peer in MP mode\n",
+			   __func__);
+		ret = -EINVAL;
+		goto peer_release;
+	}
+
+	if (attrs[OVPN_A_PEER_SOCKET]) {
+		/* lookup the fd in the kernel table and extract the socket object */
+		sockfd = nla_get_u32(attrs[OVPN_A_PEER_SOCKET]);
+		/* sockfd_lookup() increases sock's refcounter */
+		sock = sockfd_lookup(sockfd, &ret);
+		if (!sock) {
+			netdev_dbg(ovpn->dev, "%s: cannot lookup peer socket (fd=%u): %d\n",
+				   __func__, sockfd, ret);
+			ret = -ENOTSOCK;
+			goto peer_release;
+		}
+
+		/* Only when using UDP as transport protocol the remote endpoint can be configured
+		 * so that ovpn knows where to send packets to.
+		 *
+		 * In case of TCP, the socket is connected to the peer and ovpn will just send bytes
+		 * over it, without the need to specify a destination.
+		 */
+		if (sock->sk->sk_protocol == IPPROTO_UDP && attrs[OVPN_A_PEER_SOCKADDR_REMOTE]) {
+			ss = nla_data(attrs[OVPN_A_PEER_SOCKADDR_REMOTE]);
+			sa_len = nla_len(attrs[OVPN_A_PEER_SOCKADDR_REMOTE]);
+			switch (sa_len) {
+			case sizeof(struct sockaddr_in):
+				if (ss->ss_family == AF_INET)
+					/* valid sockaddr */
+					break;
+
+				netdev_err(ovpn->dev, "%s: remote sockaddr_in has invalid family\n",
+					   __func__);
+				ret = -EINVAL;
+				goto peer_release;
+			case sizeof(struct sockaddr_in6):
+				if (ss->ss_family == AF_INET6)
+					/* valid sockaddr */
+					break;
+
+				netdev_err(ovpn->dev, "%s: remote sockaddr_in6 has invalid family\n",
+					   __func__);
+				ret = -EINVAL;
+				goto peer_release;
+			default:
+				netdev_err(ovpn->dev, "%s: invalid size for sockaddr\n", __func__);
+				ret = -EINVAL;
+				goto peer_release;
+			}
+
+			if (ss->ss_family == AF_INET6) {
+				in6 = (struct sockaddr_in6 *)ss;
+
+				if (ipv6_addr_type(&in6->sin6_addr) & IPV6_ADDR_MAPPED) {
+					mapped.sin_family = AF_INET;
+					mapped.sin_addr.s_addr = in6->sin6_addr.s6_addr32[3];
+					mapped.sin_port = in6->sin6_port;
+					ss = (struct sockaddr_storage *)&mapped;
+				}
+			}
+
+			/* When using UDP we may be talking over socket bound to 0.0.0.0/::.
+			 * In this case, if the host has multiple IPs, we need to make sure
+			 * that outgoing traffic has as source IP the same address that the
+			 * peer is using to reach us.
+			 *
+			 * Since early control packets were all forwarded to userspace, we
+			 * need the latter to tell us what IP has to be used.
+			 */
+			if (attrs[OVPN_A_PEER_LOCAL_IP]) {
+				ip_len = nla_len(attrs[OVPN_A_PEER_LOCAL_IP]);
+				local_ip = nla_data(attrs[OVPN_A_PEER_LOCAL_IP]);
+
+				if (ip_len == sizeof(struct in_addr)) {
+					if (ss->ss_family != AF_INET) {
+						netdev_dbg(ovpn->dev,
+							   "%s: the specified local IP is IPv4, but the peer endpoint is not\n",
+							   __func__);
+						ret = -EINVAL;
+						goto peer_release;
+					}
+				} else if (ip_len == sizeof(struct in6_addr)) {
+					bool is_mapped = ipv6_addr_type((struct in6_addr *)local_ip) &
+						IPV6_ADDR_MAPPED;
+
+					if (ss->ss_family != AF_INET6 && !is_mapped) {
+						netdev_dbg(ovpn->dev,
+							   "%s: the specified local IP is IPv6, but the peer endpoint is not\n",
+							   __func__);
+						ret = -EINVAL;
+						goto peer_release;
+					}
+
+					if (is_mapped)
+						/* this is an IPv6-mapped IPv4 address, therefore extract
+						 * the actual v4 address from the last 4 bytes
+						 */
+						local_ip += 12;
+				} else {
+					netdev_dbg(ovpn->dev,
+						   "%s: invalid length %zu for local IP\n", __func__,
+						   ip_len);
+					ret = -EINVAL;
+					goto peer_release;
+				}
+			}
+
+			/* set peer sockaddr */
+			ret = ovpn_peer_reset_sockaddr(peer, ss, local_ip);
+			if (ret < 0)
+				goto peer_release;
+		}
+
+		if (peer->sock)
+			ovpn_socket_put(peer->sock);
+
+		peer->sock = ovpn_socket_new(sock, peer);
+		if (IS_ERR(peer->sock)) {
+			sockfd_put(sock);
+			peer->sock = NULL;
+			ret = -ENOTSOCK;
+			goto peer_release;
+		}
+	}
+
+	/* VPN IPs cannot be updated, because they are hashed */
+	if (new_peer && attrs[OVPN_A_PEER_VPN_IPV4]) {
+		if (nla_len(attrs[OVPN_A_PEER_VPN_IPV4]) != sizeof(struct in_addr)) {
+			ret = -EINVAL;
+			goto peer_release;
+		}
+
+		peer->vpn_addrs.ipv4.s_addr = nla_get_be32(attrs[OVPN_A_PEER_VPN_IPV4]);
+	}
+
+	/* VPN IPs cannot be updated, because they are hashed */
+	if (new_peer && attrs[OVPN_A_PEER_VPN_IPV6]) {
+		if (nla_len(attrs[OVPN_A_PEER_VPN_IPV6]) != sizeof(struct in6_addr)) {
+			ret = -EINVAL;
+			goto peer_release;
+		}
+
+		memcpy(&peer->vpn_addrs.ipv6, nla_data(attrs[OVPN_A_PEER_VPN_IPV6]),
+		       sizeof(struct in6_addr));
+	}
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
+		   "%s: adding peer with endpoint=%pIScp/%s id=%u VPN-IPv4=%pI4 VPN-IPv6=%pI6c\n",
+		   __func__, ss, sock->sk->sk_prot_creator->name, peer->id,
+		   &peer->vpn_addrs.ipv4.s_addr, &peer->vpn_addrs.ipv6);
+
+	ret = ovpn_peer_add(ovpn, peer);
+	if (ret < 0) {
+		netdev_err(ovpn->dev, "%s: cannot add new peer (id=%u) to hashtable: %d\n",
+			   __func__, peer->id, ret);
+		goto peer_release;
+	}
+
+	return 0;
+
+peer_release:
+	/* release right away because peer is not really used in any context */
+	ovpn_peer_release(peer);
+	return ret;
+
+}
+
+static int ovpn_nl_send_peer(struct sk_buff *skb, const struct ovpn_peer *peer, u32 portid,
+			     u32 seq, int flags)
+{
+	const struct ovpn_bind *bind;
+	struct nlattr *attr;
+	void *hdr;
+
+	hdr = genlmsg_put(skb, portid, seq, &ovpn_nl_family, flags, OVPN_CMD_SET_PEER);
+	if (!hdr) {
+		netdev_dbg(peer->ovpn->dev, "%s: cannot create message header\n", __func__);
+		return -EMSGSIZE;
+	}
+
+	attr = nla_nest_start(skb, OVPN_A_PEER);
+	if (!attr) {
+		netdev_dbg(peer->ovpn->dev, "%s: cannot create submessage\n", __func__);
+		goto err;
+	}
+
+	if (nla_put_u32(skb, OVPN_A_PEER_ID, peer->id))
+		goto err;
+
+	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY))
+		if (nla_put(skb, OVPN_A_PEER_VPN_IPV4, sizeof(peer->vpn_addrs.ipv4),
+			    &peer->vpn_addrs.ipv4))
+			goto err;
+
+	if (memcmp(&peer->vpn_addrs.ipv6, &in6addr_any, sizeof(peer->vpn_addrs.ipv6)))
+		if (nla_put(skb, OVPN_A_PEER_VPN_IPV6, sizeof(peer->vpn_addrs.ipv6),
+			    &peer->vpn_addrs.ipv6))
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
+				    sizeof(bind->local.ipv4), &bind->local.ipv4))
+				goto err_unlock;
+		} else if (bind->sa.in4.sin_family == AF_INET6) {
+			if (nla_put(skb, OVPN_A_PEER_SOCKADDR_REMOTE,
+				    sizeof(bind->sa.in6), &bind->sa.in6) ||
+			    nla_put(skb, OVPN_A_PEER_LOCAL_IP,
+				    sizeof(bind->local.ipv6), &bind->local.ipv6))
+				goto err_unlock;
+		}
+	}
+	rcu_read_unlock();
+
+	if (nla_put_net16(skb, OVPN_A_PEER_LOCAL_PORT,
+			  inet_sk(peer->sock->sock->sk)->inet_sport) ||
+	    /* VPN RX stats */
+	    nla_put_u64_64bit(skb, OVPN_A_PEER_VPN_RX_BYTES,
+			      atomic64_read(&peer->vpn_stats.rx.bytes),
+			      OVPN_A_PEER_UNSPEC) ||
+	    nla_put_u32(skb, OVPN_A_PEER_VPN_RX_PACKETS,
+			atomic_read(&peer->vpn_stats.rx.packets)) ||
+	    /* VPN TX stats */
+	    nla_put_u64_64bit(skb, OVPN_A_PEER_VPN_TX_BYTES,
+			      atomic64_read(&peer->vpn_stats.tx.bytes),
+			      OVPN_A_PEER_UNSPEC) ||
+	    nla_put_u32(skb, OVPN_A_PEER_VPN_TX_PACKETS,
+			atomic_read(&peer->vpn_stats.tx.packets)) ||
+	    /* link RX stats */
+	    nla_put_u64_64bit(skb, OVPN_A_PEER_LINK_RX_BYTES,
+			      atomic64_read(&peer->link_stats.rx.bytes),
+			      OVPN_A_PEER_UNSPEC) ||
+	    nla_put_u32(skb, OVPN_A_PEER_LINK_RX_PACKETS,
+			atomic_read(&peer->link_stats.rx.packets)) ||
+	    /* link TX stats */
+	    nla_put_u64_64bit(skb, OVPN_A_PEER_LINK_TX_BYTES,
+			      atomic64_read(&peer->link_stats.tx.bytes),
+			      OVPN_A_PEER_UNSPEC) ||
+	    nla_put_u32(skb, OVPN_A_PEER_LINK_TX_PACKETS,
+			atomic_read(&peer->link_stats.tx.packets)))
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
+}
+
+static int ovpn_nl_get_peer(struct sk_buff *skb, struct genl_info *info)
+{
+	struct nlattr *attrs[NUM_OVPN_A_PEER];
+	struct ovpn_struct *ovpn = info->user_ptr[0];
+	struct ovpn_peer *peer;
+	struct sk_buff *msg;
+	u32 peer_id;
+	int ret;
+
+	if (!info->attrs[OVPN_A_PEER])
+		return -EINVAL;
+
+	ret = nla_parse_nested(attrs, NUM_OVPN_A_PEER - 1, info->attrs[OVPN_A_PEER], NULL,
+			       info->extack);
+	if (ret)
+		return ret;
+
+	if (!attrs[OVPN_A_PEER_ID])
+		return -EINVAL;
+
+	peer_id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
+	peer = ovpn_peer_lookup_id(ovpn, peer_id);
+	if (!peer)
+		return -ENOENT;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	ret = ovpn_nl_send_peer(msg, peer, info->snd_portid, info->snd_seq, 0);
+	if (ret < 0) {
+		nlmsg_free(msg);
+		goto err;
+	}
+
+	ret = genlmsg_reply(msg, info);
+err:
+	ovpn_peer_put(peer);
+	return ret;
+}
+
+static int ovpn_nl_dump_peers(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	struct net *netns = sock_net(cb->skb->sk);
+	struct nlattr **attrbuf;
+	struct ovpn_struct *ovpn;
+	struct net_device *dev;
+	int ret, bkt, last_idx = cb->args[1], dumped = 0;
+	struct ovpn_peer *peer;
+
+	attrbuf = kcalloc(NUM_OVPN_A, sizeof(*attrbuf), GFP_KERNEL);
+	if (!attrbuf)
+		return -ENOMEM;
+
+	ret = nlmsg_parse_deprecated(cb->nlh, GENL_HDRLEN, attrbuf, NUM_OVPN_A,
+				     ovpn_nl_policy, NULL);
+	if (ret < 0) {
+		pr_err("ovpn: cannot parse incoming request in %s: %d\n", __func__, ret);
+		goto err;
+	}
+
+	dev = ovpn_get_dev_from_attrs(netns, attrbuf);
+	if (IS_ERR(dev)) {
+		ret = PTR_ERR(dev);
+		pr_err("ovpn: cannot retrieve device in %s: %d\n", __func__, ret);
+		goto err;
+	}
+
+	ovpn = netdev_priv(dev);
+
+	rcu_read_lock();
+	hash_for_each_rcu(ovpn->peers.by_id, bkt, peer, hash_entry_id) {
+		/* skip already dumped peers that were dumped by previous invocations */
+		if (last_idx > 0) {
+			last_idx--;
+			continue;
+		}
+
+		if (ovpn_nl_send_peer(skb, peer, NETLINK_CB(cb->skb).portid,
+				      cb->nlh->nlmsg_seq, NLM_F_MULTI) < 0)
+			break;
+
+		/* count peers being dumped during this invocation */
+		dumped++;
+	}
+	rcu_read_unlock();
+
+	dev_put(dev);
+
+	/* sum up peers dumped in this message, so that at the next invocation
+	 * we can continue from where we left
+	 */
+	cb->args[1] += dumped;
+	ret = skb->len;
+err:
+	kfree(attrbuf);
+	return ret;
+}
+
+static int ovpn_nl_del_peer(struct sk_buff *skb, struct genl_info *info)
+{
+	struct nlattr *attrs[NUM_OVPN_A_PEER];
+	struct ovpn_struct *ovpn = info->user_ptr[0];
+	struct ovpn_peer *peer;
+	u32 peer_id;
+	int ret;
+
+	if (!info->attrs[OVPN_A_PEER])
+		return -EINVAL;
+
+	ret = nla_parse_nested(attrs, NUM_OVPN_A_PEER - 1, info->attrs[OVPN_A_PEER], NULL,
+			       info->extack);
+	if (ret)
+		return ret;
+
+	if (!attrs[OVPN_A_PEER_ID])
+		return -EINVAL;
+
+	peer_id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
+
+	peer = ovpn_peer_lookup_id(ovpn, peer_id);
+	if (!peer)
+		return -ENOENT;
+
+	netdev_dbg(ovpn->dev, "%s: peer id=%u\n", __func__, peer->id);
+	ret = ovpn_peer_del(peer, OVPN_DEL_PEER_REASON_USERSPACE);
+	ovpn_peer_put(peer);
+
+	return ret;
+}
+
+
 static int ovpn_nl_new_iface(struct sk_buff *skb, struct genl_info *info)
 {
 	enum ovpn_mode mode = OVPN_MODE_P2P;
@@ -205,6 +663,22 @@ static const struct genl_small_ops ovpn_nl_ops[] = {
 		.flags = GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 		.doit = ovpn_nl_del_iface,
 	},
+	{
+		.cmd = OVPN_CMD_SET_PEER,
+		.flags = GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+		.doit = ovpn_nl_set_peer,
+	},
+	{
+		.cmd = OVPN_CMD_DEL_PEER,
+		.flags = GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+		.doit = ovpn_nl_del_peer,
+	},
+	{
+		.cmd = OVPN_CMD_GET_PEER,
+		.flags = GENL_ADMIN_PERM | GENL_CMD_CAP_DO | GENL_CMD_CAP_DUMP,
+		.doit = ovpn_nl_get_peer,
+		.dumpit = ovpn_nl_dump_peers,
+	},
 };
 
 static struct genl_family ovpn_nl_family __ro_after_init = {
-- 
2.43.0


