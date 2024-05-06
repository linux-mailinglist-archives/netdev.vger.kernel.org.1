Return-Path: <netdev+bounces-93575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B93568BC55A
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 03:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3089F1F21961
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 01:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126B440855;
	Mon,  6 May 2024 01:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="e6c7X1zK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B46405CC
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 01:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714958161; cv=none; b=orq9q9EeBsTkGlndOAOYpp/R6lWb8lJDR69Bn2kNum4bjI3RbJS2j1/1x38ih0MBi4c7PONxNn3hj66NJTCw/CBqQIId5zqxwWJ7o3nCpyj7WJ6dv9GA0LkX+5V2MwHYOR0NwPLSYnPxi2bQ+vddfClSbN6J7tNfFNDFtYQQrPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714958161; c=relaxed/simple;
	bh=Ix3GSVsGdq2yvXWC3vVGMEfVG6dIjoAD7BKNWRBDwuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T59WihBaVsboBwGd9rx1ck4SB8P/dxElNbX8yzEfu0pzpcPK4nAqOPxiKRMAf+TCp0MT0b+UwaPpwLjBU0eDqsZL0TwDPe0ufsnPT5YFndL9LqcMv5p0WiZHrqYSShZMevsvX4xxfmVjXtntLpqYQwWo8iWOteI/NiJKv4gWwM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=e6c7X1zK; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-349545c3eb8so973416f8f.2
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 18:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1714958157; x=1715562957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjeFuHcDMKV8BbQlixeqWL6hqMgIIDQVdkEoaUngMpI=;
        b=e6c7X1zKP5efggsPZoQynQPPEGFsRoSsIAWn+gtA8AJ+p4aTIfIIiIVyd09vJVz7b3
         4HA07Vmcrpl5kqUmIfj37CKi85YwSMOXPlb8UIykEdtsrMEBF9a63q/6V+voQZt1Axvq
         KaI3TMdSWjzebLfJtUe6Ly9hKnCRYpbiWzHbJnGx7RW4LOqVbn/aPBSpUjc/vM9+TACm
         jOPW6zmIMcBy4SpYf9epVMbdNS4YbkYzM7MSlcW6ZIZEvrZ3g0cITewur9vYfw1YJ5Ft
         CtqOzcXFDSo8nYp1w2ghTOnX5nUNU+eU7F/q7RdeLRZExRfZi+H30tYNGukTnH9rqcad
         lQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714958157; x=1715562957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjeFuHcDMKV8BbQlixeqWL6hqMgIIDQVdkEoaUngMpI=;
        b=erp3tTmW5JpszkkReu9KbxjmYK2mO/Y1HtPZrRLOg64vsdY3DQEpSx8dtY/nNVYrPb
         /aj2134Vf2lljDVu/OeVJiHNqG80PiuXdqUMdA8cfAgMbuR3DJNrCSmBat1dSKpT/qV+
         jlq4ebk4XndbJGXJEE0vwQTyNQ4GFJ4o9MCaMC2ReLU0zTzFDCzScYabbqajCpUrrFb0
         3yqeaA6tjMqef++yy+nZnEBkuNU0/0XL3qtOuw48twTGMsIBfqOhLmWTnGiHU1UpYDoo
         pu7YWFYepFe3Ay44yc0aFkjSpIoi+W8a26sJvKjUUriLrmMFYZsnbe84ffiFt2laXlzi
         N1Nw==
X-Gm-Message-State: AOJu0Yx2U6cJZo+OHPG92Y2Oss4T09d8Y9Rkai6FAk7DYDbS4Y/awR9t
	rXdoj0UOPZ1nUX6fsv6c1qyTJJ7SsYDPBjn2FPRPenjGHWoO1reEUXd1RJnNvnEFQka07J58Hq9
	R
X-Google-Smtp-Source: AGHT+IFQNBr03x8z3CnMkF1nS+2GlSXI+PX5krHNKelNzADEkHEiAONvAH7qCIIsR5Jd8VfWYHFhvg==
X-Received: by 2002:a05:6000:507:b0:34d:939c:d029 with SMTP id a7-20020a056000050700b0034d939cd029mr5201388wrf.47.1714958156730;
        Sun, 05 May 2024 18:15:56 -0700 (PDT)
Received: from serenity.homelan.mandelbit.com ([2001:67c:2fbc:0:fbf:f0c4:769e:3936])
        by smtp.gmail.com with ESMTPSA id n8-20020adffe08000000b0034df2d0bd71sm9363621wrr.12.2024.05.05.18.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 18:15:56 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Esben Haabendal <esben@geanix.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v3 19/24] ovpn: implement peer add/dump/delete via netlink
Date: Mon,  6 May 2024 03:16:32 +0200
Message-ID: <20240506011637.27272-20-antonio@openvpn.net>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240506011637.27272-1-antonio@openvpn.net>
References: <20240506011637.27272-1-antonio@openvpn.net>
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
 drivers/net/ovpn/netlink.c | 511 ++++++++++++++++++++++++++++++++++++-
 drivers/net/ovpn/peer.c    |   6 +-
 drivers/net/ovpn/peer.h    |  12 +
 3 files changed, 522 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 66f5c6fbe8e4..914b04631ae8 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -17,6 +17,10 @@
 #include "io.h"
 #include "netlink.h"
 #include "netlink-gen.h"
+#include "bind.h"
+#include "packet.h"
+#include "peer.h"
+#include "socket.h"
 
 MODULE_ALIAS_GENL_FAMILY(OVPN_FAMILY_NAME);
 
@@ -137,24 +141,523 @@ int ovpn_nl_del_iface_doit(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
+static u8 *ovpn_nl_attr_local_ip(struct ovpn_struct *ovpn,
+				 struct nlattr **attrs, int sock_fam)
+{
+	size_t ip_len = nla_len(attrs[OVPN_A_PEER_LOCAL_IP]);
+	u8 *local_ip = nla_data(attrs[OVPN_A_PEER_LOCAL_IP]);
+	bool is_mapped;
+
+	if (ip_len == sizeof(struct in_addr)) {
+		if (sock_fam != AF_INET) {
+			netdev_dbg(ovpn->dev,
+				   "%s: the specified local IP is IPv4, but the peer endpoint is not\n",
+				   __func__);
+			return ERR_PTR(-EINVAL);
+		}
+	} else if (ip_len == sizeof(struct in6_addr)) {
+		is_mapped = ipv6_addr_v4mapped((struct in6_addr *)local_ip);
+
+		if (sock_fam != AF_INET6 && !is_mapped) {
+			netdev_dbg(ovpn->dev,
+				   "%s: the specified local IP is IPv6, but the peer endpoint is not\n",
+				   __func__);
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
+		netdev_dbg(ovpn->dev, "%s: invalid length %zu for local IP\n",
+			   __func__, ip_len);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return local_ip;
+}
+
 int ovpn_nl_set_peer_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -ENOTSUPP;
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
+	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_PEER)) {
+		netdev_err(ovpn->dev, "%s: missing peer object\n", __func__);
+		return -EINVAL;
+	}
+
+	ret = nla_parse_nested(attrs, OVPN_A_PEER_MAX, info->attrs[OVPN_A_PEER],
+			       ovpn_peer_nl_policy, info->extack);
+	if (ret) {
+		netdev_err(ovpn->dev, "%s: can't parse peer object\n",
+			   __func__);
+		return ret;
+	}
+
+	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], attrs,
+			      OVPN_A_PEER_ID)) {
+		netdev_err(ovpn->dev, "%s: peer ID missing\n", __func__);
+		return -EINVAL;
+	}
+
+	id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
+	/* check if the peer exists first, otherwise create a new one */
+	peer = ovpn_peer_get_by_id(ovpn, id);
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
+	if (new_peer && NL_REQ_ATTR_CHECK(info->extack,
+					  info->attrs[OVPN_A_PEER], attrs,
+					  OVPN_A_PEER_SOCKET)) {
+		netdev_err(ovpn->dev, "%s: socket missing for new peer\n",
+			   __func__);
+		ret = -EINVAL;
+		goto peer_release;
+	}
+
+	if (new_peer && ovpn->mode == OVPN_MODE_MP &&
+	    !attrs[OVPN_A_PEER_VPN_IPV4] && !attrs[OVPN_A_PEER_VPN_IPV6]) {
+		netdev_err(ovpn->dev,
+			   "%s: a VPN IP is required when adding a peer in MP mode\n",
+			   __func__);
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
+			netdev_err(ovpn->dev,
+				   "%s: cannot lookup peer socket (fd=%u): %d\n",
+				   __func__, sockfd, ret);
+			ret = -ENOTSOCK;
+			goto peer_release;
+		}
+
+		/* Only when using UDP as transport protocol the remote endpoint
+		 * can be configured so that ovpn knows where to send packets
+		 * to.
+		 *
+		 * In case of TCP, the socket is connected to the peer and ovpn
+		 * will just send bytes over it, without the need to specify a
+		 * destination.
+		 */
+		if (sock->sk->sk_protocol == IPPROTO_UDP &&
+		    attrs[OVPN_A_PEER_SOCKADDR_REMOTE]) {
+			ss = nla_data(attrs[OVPN_A_PEER_SOCKADDR_REMOTE]);
+			sa_len = nla_len(attrs[OVPN_A_PEER_SOCKADDR_REMOTE]);
+			switch (sa_len) {
+			case sizeof(struct sockaddr_in):
+				if (ss->ss_family == AF_INET)
+					/* valid sockaddr */
+					break;
+
+				netdev_err(ovpn->dev,
+					   "%s: remote sockaddr_in has invalid family\n",
+					   __func__);
+				ret = -EINVAL;
+				goto peer_release;
+			case sizeof(struct sockaddr_in6):
+				if (ss->ss_family == AF_INET6)
+					/* valid sockaddr */
+					break;
+
+				netdev_err(ovpn->dev,
+					   "%s: remote sockaddr_in6 has invalid family\n",
+					   __func__);
+				ret = -EINVAL;
+				goto peer_release;
+			default:
+				netdev_err(ovpn->dev,
+					   "%s: invalid size for sockaddr\n",
+					   __func__);
+				ret = -EINVAL;
+				goto peer_release;
+			}
+
+			/* if this is a v6-mapped-v4, convert the sockaddr
+			 * object from AF_INET6 to AF_INET before continue
+			 * processing
+			 */
+			if (ss->ss_family == AF_INET6) {
+				in6 = (struct sockaddr_in6 *)ss;
+
+				if (ipv6_addr_v4mapped(&in6->sin6_addr)) {
+					mapped.sin_family = AF_INET;
+					mapped.sin_addr.s_addr =
+						in6->sin6_addr.s6_addr32[3];
+					mapped.sin_port = in6->sin6_port;
+					ss = (struct sockaddr_storage *)&mapped;
+				}
+			}
+
+			if (attrs[OVPN_A_PEER_LOCAL_IP]) {
+				local_ip = ovpn_nl_attr_local_ip(ovpn, attrs,
+								 ss->ss_family);
+				if (IS_ERR(local_ip)) {
+					ret = PTR_ERR(local_ip);
+					netdev_err(ovpn->dev,
+						   "%s: cannot retrieve local IP: %d\n",
+						   __func__, ret);
+					goto peer_release;
+				}
+			}
+
+			/* set peer sockaddr */
+			ret = ovpn_peer_reset_sockaddr(peer, ss, local_ip);
+			if (ret < 0) {
+				netdev_err(ovpn->dev,
+					   "%s: cannot set peer sockaddr: %d\n",
+					   __func__, ret);
+				goto peer_release;
+			}
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
+			netdev_err(ovpn->dev,
+				   "%s: cannot encapsulate socket: %d\n",
+				   __func__, ret);
+			goto peer_release;
+		}
+	}
+
+	/* VPN IPs cannot be updated, because they are hashed */
+	if (new_peer && attrs[OVPN_A_PEER_VPN_IPV4]) {
+		if (nla_len(attrs[OVPN_A_PEER_VPN_IPV4]) !=
+		    sizeof(struct in_addr)) {
+			netdev_err(ovpn->dev, "%s: invalid IPv4\n", __func__);
+			ret = -EINVAL;
+			goto peer_release;
+		}
+
+		peer->vpn_addrs.ipv4.s_addr =
+			nla_get_be32(attrs[OVPN_A_PEER_VPN_IPV4]);
+	}
+
+	/* VPN IPs cannot be updated, because they are hashed */
+	if (new_peer && attrs[OVPN_A_PEER_VPN_IPV6]) {
+		if (nla_len(attrs[OVPN_A_PEER_VPN_IPV6]) !=
+		    sizeof(struct in6_addr)) {
+			netdev_err(ovpn->dev, "%s: invalid IPv6\n", __func__);
+			ret = -EINVAL;
+			goto peer_release;
+		}
+
+		memcpy(&peer->vpn_addrs.ipv6,
+		       nla_data(attrs[OVPN_A_PEER_VPN_IPV6]),
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
+		netdev_err(ovpn->dev,
+			   "%s: cannot add new peer (id=%u) to hashtable: %d\n",
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
+}
+
+static int ovpn_nl_send_peer(struct sk_buff *skb, const struct ovpn_peer *peer,
+			     u32 portid, u32 seq, int flags)
+{
+	const struct ovpn_bind *bind;
+	struct nlattr *attr;
+	void *hdr;
+
+	hdr = genlmsg_put(skb, portid, seq, &ovpn_nl_family, flags,
+			  OVPN_CMD_SET_PEER);
+	if (!hdr) {
+		netdev_dbg(peer->ovpn->dev,
+			   "%s: cannot create message header\n", __func__);
+		return -EMSGSIZE;
+	}
+
+	attr = nla_nest_start(skb, OVPN_A_PEER);
+	if (!attr) {
+		netdev_dbg(peer->ovpn->dev, "%s: cannot create submessage\n",
+			   __func__);
+		goto err;
+	}
+
+	if (nla_put_u32(skb, OVPN_A_PEER_ID, peer->id))
+		goto err;
+
+	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY))
+		if (nla_put(skb, OVPN_A_PEER_VPN_IPV4,
+			    sizeof(peer->vpn_addrs.ipv4),
+			    &peer->vpn_addrs.ipv4))
+			goto err;
+
+	if (memcmp(&peer->vpn_addrs.ipv6, &in6addr_any,
+		   sizeof(peer->vpn_addrs.ipv6)))
+		if (nla_put(skb, OVPN_A_PEER_VPN_IPV6,
+			    sizeof(peer->vpn_addrs.ipv6),
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
+	    nla_put_u64_64bit(skb, OVPN_A_PEER_VPN_RX_BYTES,
+			      atomic64_read(&peer->vpn_stats.rx.bytes),
+			      OVPN_A_PAD) ||
+	    nla_put_u32(skb, OVPN_A_PEER_VPN_RX_PACKETS,
+			atomic_read(&peer->vpn_stats.rx.packets)) ||
+	    /* VPN TX stats */
+	    nla_put_u64_64bit(skb, OVPN_A_PEER_VPN_TX_BYTES,
+			      atomic64_read(&peer->vpn_stats.tx.bytes),
+			      OVPN_A_PAD) ||
+	    nla_put_u32(skb, OVPN_A_PEER_VPN_TX_PACKETS,
+			atomic_read(&peer->vpn_stats.tx.packets)) ||
+	    /* link RX stats */
+	    nla_put_u64_64bit(skb, OVPN_A_PEER_LINK_RX_BYTES,
+			      atomic64_read(&peer->link_stats.rx.bytes),
+			      OVPN_A_PAD) ||
+	    nla_put_u32(skb, OVPN_A_PEER_LINK_RX_PACKETS,
+			atomic_read(&peer->link_stats.rx.packets)) ||
+	    /* link TX stats */
+	    nla_put_u64_64bit(skb, OVPN_A_PEER_LINK_TX_BYTES,
+			      atomic64_read(&peer->link_stats.tx.bytes),
+			      OVPN_A_PAD) ||
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
 }
 
 int ovpn_nl_get_peer_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -ENOTSUPP;
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
 }
 
 int ovpn_nl_get_peer_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 {
-	return -ENOTSUPP;
+	const struct genl_info *info = genl_info_dump(cb);
+	struct nlattr **attrs = info->attrs;
+	struct ovpn_struct *ovpn;
+	struct ovpn_peer *peer;
+	struct net_device *dev;
+	int ret, bkt, last_idx = cb->args[1], dumped = 0;
+
+	dev = ovpn_get_dev_from_attrs(sock_net(cb->skb->sk), attrs);
+	if (IS_ERR(dev)) {
+		ret = PTR_ERR(dev);
+		pr_err("ovpn: cannot retrieve device in %s: %d\n", __func__,
+		       ret);
+		return ret;
+	}
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
+			if (ovpn_nl_send_peer(skb, peer,
+					      NETLINK_CB(cb->skb).portid,
+					      cb->nlh->nlmsg_seq,
+					      NLM_F_MULTI) == 0)
+				dumped++;
+		}
+		rcu_read_unlock();
+	} else {
+		rcu_read_lock();
+		hash_for_each_rcu(ovpn->peers.by_id, bkt, peer, hash_entry_id) {
+			/* skip already dumped peers that were dumped by
+			 * previous invocations
+			 */
+			if (last_idx > 0) {
+				last_idx--;
+				continue;
+			}
+
+			if (ovpn_nl_send_peer(skb, peer,
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
+	dev_put(dev);
+
+	/* sum up peers dumped in this message, so that at the next invocation
+	 * we can continue from where we left
+	 */
+	cb->args[1] += dumped;
+	return skb->len;
 }
 
 int ovpn_nl_del_peer_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	return -ENOTSUPP;
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
index e1eee1bb1ad2..07daa359b3a2 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -151,9 +151,9 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
 	return ERR_PTR(ret);
 }
 
-static int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
-				    const struct sockaddr_storage *ss,
-				    const u8 *local_ip)
+int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
+			     const struct sockaddr_storage *ss,
+			     const u8 *local_ip)
 {
 	struct ovpn_bind *bind;
 	size_t ip_len;
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 5ea35ccc2824..f7784615c63f 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -288,4 +288,16 @@ void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
  */
 void ovpn_peer_float(struct ovpn_peer *peer, struct sk_buff *skb);
 
+/**
+ * ovpn_peer_reset_sockaddr - recreate binding for peer
+ * @peer: peer to recreate the binding for
+ * @ss: sockaddr to use as remote endpoint for the binding
+ * @local_ip: local IP for the binding
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
+			     const struct sockaddr_storage *ss,
+			     const u8 *local_ip);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */
-- 
2.43.2


