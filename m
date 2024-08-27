Return-Path: <netdev+bounces-122296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6069609A9
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3390F1C22CA9
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 12:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B011A4B6C;
	Tue, 27 Aug 2024 12:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="TM2tJbw3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2C51A3BDB
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724760423; cv=none; b=oNBiw7jNzkH/PCsuPizucYWLzEc5qsKgF7hapQT46nVKuUEVFurcaotUsEH88n9am6eXWZGP0y1C7ILBQ97oZz4vzOUgOvoBu9GQCpPlmCpaDft7UCeWk4rWv1iFC5JCeMRMQw8A0aU0llbDCrn3r/I4lUGSVTm5TwWUKKZqVTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724760423; c=relaxed/simple;
	bh=GVd5901+Y8cJm05fEM1F+vr05AkLC2Yp+UttMweslR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNRJ9bQ/J8P/AU1ku8VcDhsQsN7gl7nLQGuuJ5/X++MFHffRVBInhH333WsJPPNfnY2XKj/r42xZ+UnSdvy49igP+drusVYUi4Y6xtG7weBJ2glMpDR285lwCABfjoP+sC8bNY69AxMK3kNHa/MF1fZHZEvTh2XlXWZ+jYOrWkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=TM2tJbw3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso48484845e9.1
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 05:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1724760420; x=1725365220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wS/Vb+7bkAtT52jXLSu8h2Y9R8notWwAxdTTmMu4dBU=;
        b=TM2tJbw39u5WPuiwOYYeoAepgpY6X/GB5U3torxHDU5ZYuq2+wae29mR81CQfk24LC
         A1WDFQRH/hLAdm+OSlvRGl7V/5tBKzVg3wobIfW/6mCQRNuql4sLfjZHdA1LkgJkeGl+
         wK7iBeka44dpV9OtKOPhvLyQEGbZ5GxvViWIh/DbLqDBMsX6kHTBGtmBl6cZJRliQAbA
         dm+Plwd/cFPklmd1HpzovqGgcLhjQviAfYA6UB1s/QWXK3PzJohKlup1SRdmkMHt2rXs
         MKrdnOj6SJ3SJLFWw6pC5uCKb5g6N8Uw78qcMadIn6qdCZZQnVn5M/o2t2oDriawrTD0
         Xa2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724760420; x=1725365220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wS/Vb+7bkAtT52jXLSu8h2Y9R8notWwAxdTTmMu4dBU=;
        b=CwhX7rt5iu8c+N8OsNGBxFCF01f1WQ1fR9p8eXszJF3Y0e+LXKAfRdUJBpgbZFIsHF
         jk5MNnnUjXqat8WW9MnMFr14drM0xHn9aI5WBIKGyCks+XRhCt/v/S5v5GmUwm+fVEGI
         WBbVI0jodDXZqLLJ9jwuouZ2sYCcYwlAh095qlsPCHITEbxolZ5JpIgb0+RA36/jp7Rl
         aupUODOnpTn4Ov952r7mjsb+1fJaplPqy7q0Qnt07CLm8IhMNT9fl03/PxL6PK4PW+k5
         2HFD+8Cb9mi+obKaXHafFHdtXkd46K9Ii+oz2Cri/f7jtmct+zrkE7Q6ksRHbvOHOE8R
         FNDg==
X-Gm-Message-State: AOJu0Yx4UnvJ9XSn5A22JdaNHzks4pGstmzyBB8tRULVXBrx9FrgigoP
	PKEGI1q+fKKJONgbBqEHx8ucuaACc9VFujOhMjXxbbDorvigLZ6XNn9Ba768PpjbB8AceJvKxXh
	N
X-Google-Smtp-Source: AGHT+IGy9V7MZXXwO/7J4lmBVlmyYuMthi3SV+MEz6EqH/GcC6GxyGUpi4R7p/bR1nYkChQMIsvHrQ==
X-Received: by 2002:a05:600c:45d1:b0:429:e637:959e with SMTP id 5b1f17b1804b1-42b9add4764mr19259225e9.10.1724760419601;
        Tue, 27 Aug 2024 05:06:59 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:69a:caae:ca68:74ad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5158f14sm187273765e9.16.2024.08.27.05.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 05:06:59 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	ryazanov.s.a@gmail.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v6 20/25] ovpn: implement peer add/dump/delete via netlink
Date: Tue, 27 Aug 2024 14:08:00 +0200
Message-ID: <20240827120805.13681-21-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240827120805.13681-1-antonio@openvpn.net>
References: <20240827120805.13681-1-antonio@openvpn.net>
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
 drivers/net/ovpn/netlink.c | 519 ++++++++++++++++++++++++++++++++++++-
 drivers/net/ovpn/peer.c    |  11 +-
 drivers/net/ovpn/peer.h    |   4 +
 3 files changed, 525 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index daa2f1ec46dc..9c9ad1e4cb9a 100644
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
 
@@ -147,24 +152,530 @@ int ovpn_nl_del_iface_doit(struct sk_buff *skb, struct genl_info *info)
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
+	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
+	struct ovpn_struct *ovpn = info->user_ptr[0];
+	struct sockaddr_storage *ss = NULL;
+	u32 sockfd, id, interv, timeout;
+	struct socket *sock = NULL;
+	struct sockaddr_in mapped;
+	struct sockaddr_in6 *in6;
+	struct ovpn_peer *peer;
+	bool new_peer = false;
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
+		if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER],
+				      attrs, OVPN_A_PEER_SOCKET))
+			return -EINVAL;
+
+		if (ovpn->mode == OVPN_MODE_MP &&
+		    !attrs[OVPN_A_PEER_VPN_IPV4] &&
+		    !attrs[OVPN_A_PEER_VPN_IPV6]) {
+			NL_SET_ERR_MSG_MOD(info->extack,
+					   "a VPN IP is required when adding a peer in MP mode");
+			return -EINVAL;
+		}
+
+		peer = ovpn_peer_new(ovpn, id);
+		new_peer = true;
+		if (IS_ERR(peer)) {
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "cannot create new peer object for peer %u: %ld",
+					       id, PTR_ERR(peer));
+			return PTR_ERR(peer);
+		}
+	}
+
+	/* VPN IPs cannot be updated, because they are hashed */
+	if (!new_peer && (attrs[OVPN_A_PEER_VPN_IPV4] ||
+			  attrs[OVPN_A_PEER_VPN_IPV6])) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "VPN IPs cannot be updated");
+		ret = -EINVAL;
+		goto peer_release;
+	}
+
+	/* VPN IPs are needed only in MP mode for selecting the right peer */
+	if (ovpn->mode == OVPN_MODE_P2P && (attrs[OVPN_A_PEER_VPN_IPV4] ||
+					    attrs[OVPN_A_PEER_VPN_IPV6])) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "VPN IP unexpected in P2P mode");
+		ret = -EINVAL;
+		goto peer_release;
+	}
+
+	if ((attrs[OVPN_A_PEER_KEEPALIVE_INTERVAL] &&
+	     !attrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT]) ||
+	    (!attrs[OVPN_A_PEER_KEEPALIVE_INTERVAL] &&
+	     attrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT])) {
+		NL_SET_ERR_MSG_FMT_MOD(info->extack,
+				       "keepalive interval and timeout are required together");
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
+		/* Only when using UDP as transport protocol the remote endpoint
+		 * can be configured so that ovpn knows where to send packets
+		 * to.
+		 *
+		 * In case of TCP, the socket is connected to the peer and ovpn
+		 * will just send bytes over it, without the need to specify a
+		 * destination.
+		 */
+		if (sock->sk->sk_protocol != IPPROTO_UDP &&
+		    attrs[OVPN_A_PEER_SOCKADDR_REMOTE]) {
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "unexpected sockaddr remote for non UDP socket");
+			sockfd_put(sock);
+			ret = -EINVAL;
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
+	if (attrs[OVPN_A_PEER_SOCKADDR_REMOTE]) {
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
+				goto peer_release;
+			}
+		}
+
+		spin_lock_bh(&peer->lock);
+		/* set peer sockaddr */
+		ret = ovpn_peer_reset_sockaddr(peer, ss, local_ip);
+		if (ret < 0) {
+			NL_SET_ERR_MSG_FMT_MOD(info->extack,
+					       "cannot set peer sockaddr: %d",
+					       ret);
+			spin_unlock_bh(&peer->lock);
+			goto peer_release;
+		}
+		spin_unlock_bh(&peer->lock);
+	}
+
+	/* VPN IPs cannot be updated, because they are hashed */
+	if (attrs[OVPN_A_PEER_VPN_IPV4])
+		peer->vpn_addrs.ipv4.s_addr =
+			nla_get_in_addr(attrs[OVPN_A_PEER_VPN_IPV4]);
+
+	/* VPN IPs cannot be updated, because they are hashed */
+	if (attrs[OVPN_A_PEER_VPN_IPV6])
+		peer->vpn_addrs.ipv6 =
+			nla_get_in6_addr(attrs[OVPN_A_PEER_VPN_IPV6]);
+
+	/* when setting the keepalive, both parameters have to be configured */
+	if (attrs[OVPN_A_PEER_KEEPALIVE_INTERVAL] &&
+	    attrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT]) {
+		interv = nla_get_u32(attrs[OVPN_A_PEER_KEEPALIVE_INTERVAL]);
+		timeout = nla_get_u32(attrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT]);
+		ovpn_peer_keepalive_set(peer, interv, timeout);
+	}
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
+		if (bind->remote.in4.sin_family == AF_INET) {
+			if (nla_put(skb, OVPN_A_PEER_SOCKADDR_REMOTE,
+				    sizeof(bind->remote.in4),
+				    &bind->remote.in4) ||
+			    nla_put(skb, OVPN_A_PEER_LOCAL_IP,
+				    sizeof(bind->local.ipv4),
+				    &bind->local.ipv4))
+				goto err_unlock;
+		} else if (bind->remote.in4.sin_family == AF_INET6) {
+			if (nla_put(skb, OVPN_A_PEER_SOCKADDR_REMOTE,
+				    sizeof(bind->remote.in6),
+				    &bind->remote.in6) ||
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
+	if (!msg) {
+		ret = -ENOMEM;
+		goto err;
+	}
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
index 452fb9e521e4..c460a71dcc29 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -102,9 +102,9 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
  *
  * Return: 0 on success or a negative error code otherwise
  */
-static int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
-				    const struct sockaddr_storage *ss,
-				    const u8 *local_ip)
+int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
+			     const struct sockaddr_storage *ss,
+			     const u8 *local_ip)
 	__must_hold(&peer->lock)
 {
 	struct ovpn_bind *bind;
@@ -215,7 +215,7 @@ void ovpn_peer_float(struct ovpn_peer *peer, struct sk_buff *skb)
  * ovpn_peer_release - release peer private members
  * @peer: the peer to release
  */
-static void ovpn_peer_release(struct ovpn_peer *peer)
+void ovpn_peer_release(struct ovpn_peer *peer)
 {
 	if (peer->sock)
 		ovpn_socket_put(peer->sock);
@@ -226,6 +226,8 @@ static void ovpn_peer_release(struct ovpn_peer *peer)
 	spin_unlock_bh(&peer->lock);
 
 	dst_cache_destroy(&peer->dst_cache);
+
+	netdev_put(peer->ovpn->dev, &peer->ovpn->dev_tracker);
 }
 
 /**
@@ -237,7 +239,6 @@ void ovpn_peer_release_kref(struct kref *kref)
 	struct ovpn_peer *peer = container_of(kref, struct ovpn_peer, refcount);
 
 	ovpn_peer_release(peer);
-	netdev_put(peer->ovpn->dev, &peer->ovpn->dev_tracker);
 	kfree_rcu(peer, rcu);
 }
 
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 187e7d840705..b572664ea783 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -131,6 +131,7 @@ static inline bool ovpn_peer_hold(struct ovpn_peer *peer)
 	return kref_get_unless_zero(&peer->refcount);
 }
 
+void ovpn_peer_release(struct ovpn_peer *peer);
 void ovpn_peer_release_kref(struct kref *kref);
 
 /**
@@ -163,5 +164,8 @@ void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
 				     struct sk_buff *skb);
 
 void ovpn_peer_float(struct ovpn_peer *peer, struct sk_buff *skb);
+int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
+			     const struct sockaddr_storage *ss,
+			     const u8 *local_ip);
 
 #endif /* _NET_OVPN_OVPNPEER_H_ */
-- 
2.44.2


