Return-Path: <netdev+bounces-174355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70716A5E5B8
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 21:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72EDF3B4F98
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 20:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EAC1EF099;
	Wed, 12 Mar 2025 20:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="SfNvIvCQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB4D1F0992
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 20:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812877; cv=none; b=rp21Y4JW2VSe7QdxuVvA+wH3TAJ0WlVnrpuA2QoOCj+60JlWuGc8AAuUSmZ6H3MTWMynd8nDNoTGzIk267q66T+6OF0XC1ntqQa5cLUxIjxAyilvc2hq2KdbsIKXswY/F5/MOwVjFmwGfXnmmW1uS5EUFfSM44LLsuh4i9G8IXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812877; c=relaxed/simple;
	bh=Oq6mRfWvA3NyjLYTlnniU7dRPuZ6P2bw/5Wl1G0bVZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ARBftmh8pJtwFmKNzDyeF0mmcyaSVNmLUH2VQLtS03Rle2m8alESqh9Skzc7R8ELuJa89hFCnhVmRxTz3MI0ZDmiOChboWrndLpV14eEmlI/qqop41SWN/CchZVzzysceWyXPSqQyjVMrfwoPVlBkECWQ7CyWv5vC+fH7B0EWVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=SfNvIvCQ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39149bccb69so235780f8f.2
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 13:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741812872; x=1742417672; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G9RD+AwFSz4SlqDV1Rn4yXQ6dANyNMH1nj2Js2UTxpU=;
        b=SfNvIvCQtZFVc2pVYyfKnBHlq1uibo5Oz6FVUBg2/cbmDBkbYji0LLfR3ADRVWWwNk
         4QZ3kdRVvSCvW5BrSgij+RA1+PFtqP4tt4GHzFMfG3xUP8x9oMo628bkB4K24+9QG6oL
         nCkee1AbROSvyAhzuXFIsSEmWKeQfptyhpQwoZ148uBeIz6ZwUoLp3KeO2Qlzk+5hZfO
         xZz958Dr8HLnAARGAgQiP+yRN5RZRxs8ZthL7UCbsgClaufLn3g1F38IOLb8k/IC4Xm7
         ynwkJA+Flr0ROPSXqgroQGy/LpOD3KABjoLxhxp8ENY8JNlzmmLJuJ7kdxNG0J+z6CW+
         rYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741812872; x=1742417672;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9RD+AwFSz4SlqDV1Rn4yXQ6dANyNMH1nj2Js2UTxpU=;
        b=M+dR9h9PO+ttu0U/nnPV2jiCc0YrEO+CAQA9DWXUk0NxzyOO+hVqg299nirQys2ApJ
         BBEJUS3Q74G1qHhUEBEYXcNgzfAC/bY7vGyDZyy/cCQX0l3Vpiz8nkUsxXa8wnyNSV8H
         Pd+6yoD9utpCtDGqI78zHoIpN7a9INWcZu+M0ElikaDPQkpQuuVYEoORiFVNWZU9sTYR
         Z+qPiF+6L/KPJmmTM+fCZ0vQD825Hm4ZM15TcM8fy5OjlaGPmZBHzEliaA56sqH13Q49
         gcCE4DizsHpJPZeLjZVpswbUfX2CaTqMSNm95y0q0VXbNRybANQntBpxOYiBRmfVAltn
         Wqtw==
X-Gm-Message-State: AOJu0Yx6kfX1NxjNUvXzLSbuFSe1g+0Wh3s/gQZvusEgKmVCyRmJiViA
	T06/0oxnx/hay5U74XkTlstegrl+a2R4ndzx9vywwPKVfuxebgThxrrBZBQaQl8=
X-Gm-Gg: ASbGncsMIk5T88mf2rOdwo7DOd1peHNRTGd3wfEIQVB7Qe+qLxt2Us/+1zHdvkZrP62
	DrSxWT4danPLm0pdLk0unrm72Fow9a9Qz3yPYWaig3rG1dOMbqxU6m9Nnnb8higyYx0NXV+Ehgj
	R0MmbD0EKrOjCrzCfqByzzMyhV4IoZsJOn5YjcJR78TKC6crZwbEmfEjTJ+3n9/7qtORJZvviBN
	pFESv+6pjC3JICyhL0rMO39ZiaHCLZ8WLuLhr4DNg8gW7YH5Sv/DYuai7Uda862NcQs8hNdI5Dh
	+qBM2ghWW7FWEnpUFGM62THuXgvqY+HL8HdcYdE+qA==
X-Google-Smtp-Source: AGHT+IEzE0GT4Pgwn/XrN2QKz6KS1JRQ2f414fcNQUemLRRn34wwkXYf+0E58qw9d6bnzXryT3R1IA==
X-Received: by 2002:a05:6000:21c6:b0:390:de58:d7fe with SMTP id ffacd0b85a97d-3926c5a567bmr6341665f8f.51.1741812872162;
        Wed, 12 Mar 2025 13:54:32 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:a42b:bae6:6f7d:117f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c10437dsm22481393f8f.99.2025.03.12.13.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 13:54:31 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 12 Mar 2025 21:54:15 +0100
Subject: [PATCH net-next v23 06/23] ovpn: introduce the ovpn_socket object
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-ovpn-v23-6-76066bc0a30c@openvpn.net>
References: <20250312-b4-ovpn-v23-0-76066bc0a30c@openvpn.net>
In-Reply-To: <20250312-b4-ovpn-v23-0-76066bc0a30c@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>, 
 willemdebruijn.kernel@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=16344; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=Oq6mRfWvA3NyjLYTlnniU7dRPuZ6P2bw/5Wl1G0bVZo=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn0fR7r4dL7QjjT1XDo6H/nVicEQ3x/Mg4JTlL8
 hffPG9lTDeJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9H0ewAKCRALcOU6oDjV
 hyxuCACl1mOv3lUiG1bKjLhv78QrXcHIouoCh15jQWjFSf8j6/Tz00/PnQyTZemXPGxKt2jfz7n
 eUSpy7wJw8T7Eb/t/OfQmkhgge8FHhdCegkK94BrIBxB71swjRbfvfcxTYVQ2mIwYxp1PYmZKSn
 FrRholFh8sdKtGR+2VE99++lFaH9uLmLO6FMRWBviC59VUCs0KMuz+6IypSCNpjfrPa63S6R6xw
 B8e2PZbG9eXi5obg4B/2Zlo91olU1bnJ6v1qGIrVEKjWmiP/qNaRA/A4CJS4MolA/r8f3wvGcPa
 eQ5JRYlmsu3nyozHxK23ZUXe9dDt4VnWKcFwBmZkZ3c70jS7
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

This specific structure is used in the ovpn kernel module
to wrap and carry around a standard kernel socket.

ovpn takes ownership of passed sockets and therefore an ovpn
specific objects is attached to them for status tracking
purposes.

Initially only UDP support is introduced. TCP will come in a later
patch.

Cc: willemdebruijn.kernel@gmail.com
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/Makefile |   2 +
 drivers/net/ovpn/main.c   |   2 +-
 drivers/net/ovpn/peer.c   |  28 +++++--
 drivers/net/ovpn/peer.h   |   6 +-
 drivers/net/ovpn/socket.c | 208 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/socket.h |  38 +++++++++
 drivers/net/ovpn/udp.c    |  75 +++++++++++++++++
 drivers/net/ovpn/udp.h    |  19 +++++
 include/uapi/linux/udp.h  |   1 +
 9 files changed, 372 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
index 618328ae338861b9764b42485df71ebd0fc1fe90..164f2058ea8e6dc5b9287afb59758a268b2f8b56 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -13,3 +13,5 @@ ovpn-y += io.o
 ovpn-y += netlink.o
 ovpn-y += netlink-gen.o
 ovpn-y += peer.o
+ovpn-y += socket.o
+ovpn-y += udp.o
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 3c72b80095a0ed8f2f2064fdfa556f750f1c7061..e58739d82da54001a346c38e5c5a882589eb3801 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -185,7 +185,7 @@ static int ovpn_netdev_notifier_call(struct notifier_block *nb,
 		ovpn->registered = false;
 
 		if (ovpn->mode == OVPN_MODE_P2P)
-			ovpn_peer_release_p2p(ovpn,
+			ovpn_peer_release_p2p(ovpn, NULL,
 					      OVPN_DEL_PEER_REASON_TEARDOWN);
 		break;
 	case NETDEV_POST_INIT:
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 338069c99248f42b0c4aeb44b2b9d3a35f8bebeb..0bb6c15171848acbc055829a3d2aefd26c5b810a 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -16,17 +16,20 @@
 #include "main.h"
 #include "netlink.h"
 #include "peer.h"
+#include "socket.h"
 
 static void unlock_ovpn(struct ovpn_priv *ovpn,
-			struct llist_head *release_list)
+			 struct llist_head *release_list)
 	__releases(&ovpn->lock)
 {
 	struct ovpn_peer *peer;
 
 	spin_unlock_bh(&ovpn->lock);
 
-	llist_for_each_entry(peer, release_list->first, release_entry)
+	llist_for_each_entry(peer, release_list->first, release_entry) {
+		ovpn_socket_release(peer);
 		ovpn_peer_put(peer);
+	}
 }
 
 /**
@@ -394,18 +397,33 @@ int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason)
 /**
  * ovpn_peer_release_p2p - release peer upon P2P device teardown
  * @ovpn: the instance being torn down
+ * @sk: if not NULL, release peer only if it's using this specific socket
  * @reason: the reason for releasing the peer
  */
-void ovpn_peer_release_p2p(struct ovpn_priv *ovpn,
+void ovpn_peer_release_p2p(struct ovpn_priv *ovpn, struct sock *sk,
 			   enum ovpn_del_peer_reason reason)
 {
+	struct ovpn_socket *ovpn_sock;
 	LLIST_HEAD(release_list);
 	struct ovpn_peer *peer;
 
 	spin_lock_bh(&ovpn->lock);
 	peer = rcu_dereference_protected(ovpn->peer,
 					 lockdep_is_held(&ovpn->lock));
-	if (peer)
-		ovpn_peer_remove(peer, reason, &release_list);
+	if (!peer) {
+		spin_unlock_bh(&ovpn->lock);
+		return;
+	}
+
+	if (sk) {
+		ovpn_sock = rcu_access_pointer(peer->sock);
+		if (!ovpn_sock || ovpn_sock->sock->sk != sk) {
+			spin_unlock_bh(&ovpn->lock);
+			ovpn_peer_put(peer);
+			return;
+		}
+	}
+
+	ovpn_peer_remove(peer, reason, &release_list);
 	unlock_ovpn(ovpn, &release_list);
 }
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index fd2e7625990a73f61bf5bb4c051929828d9996bd..29c9065cedccb156ec6ca6d9b692372e8fc89a2d 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -12,6 +12,8 @@
 
 #include <net/dst_cache.h>
 
+#include "socket.h"
+
 /**
  * struct ovpn_peer - the main remote peer object
  * @ovpn: main openvpn instance this peer belongs to
@@ -20,6 +22,7 @@
  * @vpn_addrs: IP addresses assigned over the tunnel
  * @vpn_addrs.ipv4: IPv4 assigned to peer on the tunnel
  * @vpn_addrs.ipv6: IPv6 assigned to peer on the tunnel
+ * @sock: the socket being used to talk to this peer
  * @dst_cache: cache for dst_entry used to send to peer
  * @bind: remote peer binding
  * @delete_reason: why peer was deleted (i.e. timeout, transport error, ..)
@@ -36,6 +39,7 @@ struct ovpn_peer {
 		struct in_addr ipv4;
 		struct in6_addr ipv6;
 	} vpn_addrs;
+	struct ovpn_socket __rcu *sock;
 	struct dst_cache dst_cache;
 	struct ovpn_bind __rcu *bind;
 	enum ovpn_del_peer_reason delete_reason;
@@ -70,7 +74,7 @@ static inline void ovpn_peer_put(struct ovpn_peer *peer)
 struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id);
 int ovpn_peer_add(struct ovpn_priv *ovpn, struct ovpn_peer *peer);
 int ovpn_peer_del(struct ovpn_peer *peer, enum ovpn_del_peer_reason reason);
-void ovpn_peer_release_p2p(struct ovpn_priv *ovpn,
+void ovpn_peer_release_p2p(struct ovpn_priv *ovpn, struct sock *sk,
 			   enum ovpn_del_peer_reason reason);
 
 struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_priv *ovpn,
diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
new file mode 100644
index 0000000000000000000000000000000000000000..0a1ba3f75aa7438502dec4c86dcef8637d5ebffa
--- /dev/null
+++ b/drivers/net/ovpn/socket.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2025 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include <linux/net.h>
+#include <linux/netdevice.h>
+#include <linux/udp.h>
+
+#include "ovpnpriv.h"
+#include "main.h"
+#include "io.h"
+#include "peer.h"
+#include "socket.h"
+#include "udp.h"
+
+static void ovpn_socket_release_kref(struct kref *kref)
+{
+	struct ovpn_socket *sock = container_of(kref, struct ovpn_socket,
+						refcount);
+
+	if (sock->sock->sk->sk_protocol == IPPROTO_UDP)
+		ovpn_udp_socket_detach(sock);
+
+	kfree_rcu(sock, rcu);
+}
+
+/**
+ * ovpn_socket_put - decrease reference counter
+ * @peer: peer whose socket reference counter should be decreased
+ * @sock: the RCU protected peer socket
+ *
+ * This function is only used internally. Users willing to release
+ * references to the ovpn_socket should use ovpn_socket_release()
+ */
+static void ovpn_socket_put(struct ovpn_peer *peer, struct ovpn_socket *sock)
+{
+	kref_put(&sock->refcount, ovpn_socket_release_kref);
+}
+
+/**
+ * ovpn_socket_release - release resources owned by socket user
+ * @peer: peer whose socket should be released
+ *
+ * This function should be invoked when the user is shutting
+ * down and wants to drop its link to the socket.
+ *
+ * In case of UDP, the detach routine will drop a reference to the
+ * ovpn netdev, pointed by the ovpn_socket.
+ *
+ * In case of TCP, releasing the socket will cause dropping
+ * the refcounter for the peer it is linked to, thus allowing the peer
+ * disappear as well.
+ *
+ * This function is expected to be invoked exactly once per peer
+ *
+ * NOTE: this function may sleep
+ */
+void ovpn_socket_release(struct ovpn_peer *peer)
+{
+	struct ovpn_socket *sock;
+
+	might_sleep();
+
+	/* release may be invoked after socket was detached */
+	rcu_read_lock();
+	sock = rcu_dereference_protected(peer->sock, true);
+	if (!sock) {
+		rcu_read_unlock();
+		return;
+	}
+	rcu_assign_pointer(peer->sock, NULL);
+	rcu_read_unlock();
+
+	/* sanity check: we should not end up here if the socket
+	 * was already closed
+	 */
+	if (!sock->sock->sk) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return;
+	}
+
+	/* Drop the reference while holding the sock lock to avoid
+	 * concurrent ovpn_socket_new call to mess up with a partially
+	 * detached socket.
+	 *
+	 * Holding the lock ensures that a socket with refcnt 0 is fully
+	 * detached before it can be picked by a concurrent reader.
+	 */
+	lock_sock(sock->sock->sk);
+	ovpn_socket_put(peer, sock);
+	release_sock(sock->sock->sk);
+
+	/* align all readers with sk_user_data being NULL */
+	synchronize_rcu();
+}
+
+static bool ovpn_socket_hold(struct ovpn_socket *sock)
+{
+	return kref_get_unless_zero(&sock->refcount);
+}
+
+static int ovpn_socket_attach(struct ovpn_socket *sock, struct ovpn_peer *peer)
+{
+	if (sock->sock->sk->sk_protocol == IPPROTO_UDP)
+		return ovpn_udp_socket_attach(sock, peer->ovpn);
+
+	return -EOPNOTSUPP;
+}
+
+/**
+ * ovpn_socket_new - create a new socket and initialize it
+ * @sock: the kernel socket to embed
+ * @peer: the peer reachable via this socket
+ *
+ * Return: an openvpn socket on success or a negative error code otherwise
+ */
+struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
+{
+	struct ovpn_socket *ovpn_sock;
+	int ret;
+
+	lock_sock(sock->sk);
+
+	/* a TCP socket can only be owned by a single peer, therefore there
+	 * can't be any other user
+	 */
+	if (sock->sk->sk_protocol == IPPROTO_TCP && sock->sk->sk_user_data) {
+		ovpn_sock = ERR_PTR(-EBUSY);
+		goto sock_release;
+	}
+
+	/* a UDP socket can be shared across multiple peers, but we must make
+	 * sure it is not owned by something else
+	 */
+	if (sock->sk->sk_protocol == IPPROTO_UDP) {
+		u8 type = READ_ONCE(udp_sk(sock->sk)->encap_type);
+
+		/* socket owned by other encapsulation module */
+		if (type && type != UDP_ENCAP_OVPNINUDP) {
+			ovpn_sock = ERR_PTR(-EBUSY);
+			goto sock_release;
+		}
+
+		rcu_read_lock();
+		ovpn_sock = rcu_dereference_sk_user_data(sock->sk);
+		if (ovpn_sock) {
+			/* socket owned by another ovpn instance, we can't use it */
+			if (ovpn_sock->ovpn != peer->ovpn) {
+				ovpn_sock = ERR_PTR(-EBUSY);
+				rcu_read_unlock();
+				goto sock_release;
+			}
+
+			/* this socket is already owned by this instance,
+			 * therefore we can increase the refcounter and
+			 * use it as expected
+			 */
+			if (WARN_ON(!ovpn_socket_hold(ovpn_sock))) {
+				/* this should never happen because setting
+				 * the refcnt to 0 and detaching the socket
+				 * is expected to be atomic
+				 */
+				ovpn_sock = ERR_PTR(-EAGAIN);
+				rcu_read_unlock();
+				goto sock_release;
+			}
+
+			/* caller is expected to increase the sock
+			 * refcounter before passing it to this
+			 * function. For this reason we drop it if
+			 * not needed, like when this socket is already
+			 * owned.
+			 */
+			rcu_read_unlock();
+			goto sock_release;
+		}
+		rcu_read_unlock();
+	}
+
+	/* socket is not owned: attach to this ovpn instance */
+
+	ovpn_sock = kzalloc(sizeof(*ovpn_sock), GFP_KERNEL);
+	if (!ovpn_sock) {
+		ovpn_sock = ERR_PTR(-ENOMEM);
+		goto sock_release;
+	}
+
+	ovpn_sock->ovpn = peer->ovpn;
+	ovpn_sock->sock = sock;
+	kref_init(&ovpn_sock->refcount);
+
+	ret = ovpn_socket_attach(ovpn_sock, peer);
+	if (ret < 0) {
+		kfree(ovpn_sock);
+		ovpn_sock = ERR_PTR(ret);
+		goto sock_release;
+	}
+
+	rcu_assign_sk_user_data(sock->sk, ovpn_sock);
+sock_release:
+	release_sock(sock->sk);
+	return ovpn_sock;
+}
diff --git a/drivers/net/ovpn/socket.h b/drivers/net/ovpn/socket.h
new file mode 100644
index 0000000000000000000000000000000000000000..ade8c94619d7b2f905b5284373dc73f590188399
--- /dev/null
+++ b/drivers/net/ovpn/socket.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2025 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_SOCK_H_
+#define _NET_OVPN_SOCK_H_
+
+#include <linux/net.h>
+#include <linux/kref.h>
+#include <net/sock.h>
+
+struct ovpn_priv;
+struct ovpn_peer;
+
+/**
+ * struct ovpn_socket - a kernel socket referenced in the ovpn code
+ * @ovpn: ovpn instance owning this socket (UDP only)
+ * @sock: the low level sock object
+ * @refcount: amount of contexts currently referencing this object
+ * @rcu: member used to schedule RCU destructor callback
+ */
+struct ovpn_socket {
+	struct ovpn_priv *ovpn;
+	struct socket *sock;
+	struct kref refcount;
+	struct rcu_head rcu;
+};
+
+struct ovpn_socket *ovpn_socket_new(struct socket *sock,
+				    struct ovpn_peer *peer);
+void ovpn_socket_release(struct ovpn_peer *peer);
+
+#endif /* _NET_OVPN_SOCK_H_ */
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
new file mode 100644
index 0000000000000000000000000000000000000000..91970e66a4340370a96c1fc42321f94574302143
--- /dev/null
+++ b/drivers/net/ovpn/udp.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2019-2025 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include <linux/netdevice.h>
+#include <linux/socket.h>
+#include <linux/udp.h>
+#include <net/udp.h>
+
+#include "ovpnpriv.h"
+#include "main.h"
+#include "socket.h"
+#include "udp.h"
+
+/**
+ * ovpn_udp_socket_attach - set udp-tunnel CBs on socket and link it to ovpn
+ * @ovpn_sock: socket to configure
+ * @ovpn: the openvp instance to link
+ *
+ * After invoking this function, the sock will be controlled by ovpn so that
+ * any incoming packet may be processed by ovpn first.
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
+			   struct ovpn_priv *ovpn)
+{
+	struct socket *sock = ovpn_sock->sock;
+	struct ovpn_socket *old_data;
+	int ret = 0;
+
+	/* make sure no pre-existing encapsulation handler exists */
+	rcu_read_lock();
+	old_data = rcu_dereference_sk_user_data(sock->sk);
+	if (!old_data) {
+		/* socket is currently unused - we can take it */
+		rcu_read_unlock();
+		return 0;
+	}
+
+	/* socket is in use. We need to understand if it's owned by this ovpn
+	 * instance or by something else.
+	 * In the former case, we can increase the refcounter and happily
+	 * use it, because the same UDP socket is expected to be shared among
+	 * different peers.
+	 *
+	 * Unlikely TCP, a single UDP socket can be used to talk to many remote
+	 * hosts and therefore openvpn instantiates one only for all its peers
+	 */
+	if ((READ_ONCE(udp_sk(sock->sk)->encap_type) == UDP_ENCAP_OVPNINUDP) &&
+	    old_data->ovpn == ovpn) {
+		netdev_dbg(ovpn->dev,
+			   "provided socket already owned by this interface\n");
+		ret = -EALREADY;
+	} else {
+		netdev_dbg(ovpn->dev,
+			   "provided socket already taken by other user\n");
+		ret = -EBUSY;
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
+/**
+ * ovpn_udp_socket_detach - clean udp-tunnel status for this socket
+ * @ovpn_sock: the socket to clean
+ */
+void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock)
+{
+}
diff --git a/drivers/net/ovpn/udp.h b/drivers/net/ovpn/udp.h
new file mode 100644
index 0000000000000000000000000000000000000000..1c8fb6fe402dc1cfdc10fddc9cf5b74d7d6887ce
--- /dev/null
+++ b/drivers/net/ovpn/udp.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2019-2025 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_UDP_H_
+#define _NET_OVPN_UDP_H_
+
+struct ovpn_priv;
+struct socket;
+
+int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
+			   struct ovpn_priv *ovpn);
+void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock);
+
+#endif /* _NET_OVPN_UDP_H_ */
diff --git a/include/uapi/linux/udp.h b/include/uapi/linux/udp.h
index d85d671deed3c78f6969189281b9083dcac000c6..edca3e430305a6bffc34e617421f1f3071582e69 100644
--- a/include/uapi/linux/udp.h
+++ b/include/uapi/linux/udp.h
@@ -43,5 +43,6 @@ struct udphdr {
 #define UDP_ENCAP_GTP1U		5 /* 3GPP TS 29.060 */
 #define UDP_ENCAP_RXRPC		6
 #define TCP_ENCAP_ESPINTCP	7 /* Yikes, this is really xfrm encap types. */
+#define UDP_ENCAP_OVPNINUDP	8 /* OpenVPN traffic */
 
 #endif /* _UAPI_LINUX_UDP_H */

-- 
2.48.1


