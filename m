Return-Path: <netdev+bounces-128626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF2197AA1D
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 03:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE5B28A01A
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 01:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CA24503C;
	Tue, 17 Sep 2024 01:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Sm536CjE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869F4C149
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 01:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726535292; cv=none; b=fumGje6jucKaDQ7qdUwTT/lHU/mbWwqzdMkIELO8Aupyjo2DDK3oiyRogEpnVj2Co9gGKh0h/g9pXqKu/oS04+GxMxQ9UiRt+A4NCBDKGc3ErX9cA1V9zkfuX2zr4vnmlOO8XPFjHsYVAiIClAcCaM22cGpFU5wRM+sAyfimt+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726535292; c=relaxed/simple;
	bh=hmuRAKm0rt/K2RpDQaRtMhk2WokALSwpBRGB+MSRq4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cni8x1Ro/FtfvLQ6BIIBjxCnKOL33qjTRxlSx0jThmjOljXS3wLC9A3vQVBu0LCy/r9asGvcYKI/O2NlnwX6O7WUmZVtG3AkfbipLpYwZARjXEPVCKIIeRY9wLEN9I20qEksE5bc4RUjwjD8wHdNY8XNVDdRTgfWEpXYlU5lslc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Sm536CjE; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374b25263a3so2570468f8f.0
        for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 18:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1726535288; x=1727140088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjbHPdKYCrXld6QubntDBigGo/a1L3VVPXna5Xi1Hqw=;
        b=Sm536CjEVPYapha7mitioRXHJFthC17AbRNoa8XbUIUtMB5Mp18u78oyippHOVkJBy
         2cP5HOU7c3BPra1pCkh8NzRXfr0LVtcCmiKd9RyCvK/6PpHMz9D9j6yTChXfm6ecDCt6
         bhjmqZqc4MtmXrz9qzv9hWoljQ+gb8d3AX3YPqbQ22yrOn1tecOFYL56qKsBh7oV7MLQ
         S8l1VTFJkGq3OJpkpIa8y7HrX//axGt9GiYhHSxamN4YcahcduNKaBhtTqyZCQdPBUkU
         VnzsZLueWwDaoFfajF6XjgLjsjkWaY3CArM69I4KVvDgmRAVEqQib+lNHiu/SD/hNWN7
         NYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726535288; x=1727140088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjbHPdKYCrXld6QubntDBigGo/a1L3VVPXna5Xi1Hqw=;
        b=akH4ubmdYL2nn7fakrWmjwxX101qFw4qGuGEn9O5dw6CV74OE4Rsg0tOBzN2e5z6TH
         yrLq4qoC3BvmxwvsnFJS6D8vK5hktKxQhJ5n3JxTd+hXC5VZWGqkm2i4VvtcufkSvFXt
         miiRe+XVL8hrmulxMdWFDa97OwBqTgCxaBlExUlUFEBjZ0ILDO47RC+TxKk9T3p6k0mn
         nxDEih4lhqw7j/Sgizg0bYjP3xqgr/qurXPXkK0tEp5m8g+G55tSF3NSA9EiMuBdKx3F
         W7Mu1wTNcEqviTPeTV+dReVA5lKjFUd/whgnvcvWJ0oRlSZwv3snFKiUnDZ7j9nmj3l5
         sN8g==
X-Gm-Message-State: AOJu0YzD4Xk9HG3UfFOHjByPv0liqSD1cbjAW2wgdW6n/QD7WuhGHRlC
	YJJB7TeoCzwXt88No2Xr+UUUoPWa8hUbIP0sajkDhY15q+3efKXoQg1newEE2eQ1ffI2XZYPAQE
	z
X-Google-Smtp-Source: AGHT+IGpa+tY+VAOPjNtVFtEYKLLZmdgWiBil1nW5GyBBPcFLuRtnQzR+Xq6zbt+1DhDVB6LV6rc/Q==
X-Received: by 2002:a5d:64e9:0:b0:374:c122:e8b8 with SMTP id ffacd0b85a97d-378d61d5314mr8645996f8f.11.1726535288438;
        Mon, 16 Sep 2024 18:08:08 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:dce8:dd6b:b9ca:6e92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e80eesm8272422f8f.30.2024.09.16.18.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 18:08:07 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	ryazanov.s.a@gmail.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v7 09/25] ovpn: introduce the ovpn_socket object
Date: Tue, 17 Sep 2024 03:07:18 +0200
Message-ID: <20240917010734.1905-10-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240917010734.1905-1-antonio@openvpn.net>
References: <20240917010734.1905-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This specific structure is used in the ovpn kernel module
to wrap and carry around a standard kernel socket.

ovpn takes ownership of passed sockets and therefore an ovpn
specific objects is attached to them for status tracking
purposes.

Initially only UDP support is introduced. TCP will come in a later
patch.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/Makefile |   2 +
 drivers/net/ovpn/socket.c | 120 ++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/socket.h |  48 +++++++++++++++
 drivers/net/ovpn/udp.c    |  72 +++++++++++++++++++++++
 drivers/net/ovpn/udp.h    |  17 ++++++
 5 files changed, 259 insertions(+)
 create mode 100644 drivers/net/ovpn/socket.c
 create mode 100644 drivers/net/ovpn/socket.h
 create mode 100644 drivers/net/ovpn/udp.c
 create mode 100644 drivers/net/ovpn/udp.h

diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
index ce13499b3e17..56bddc9bef83 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -13,3 +13,5 @@ ovpn-y += io.o
 ovpn-y += netlink.o
 ovpn-y += netlink-gen.o
 ovpn-y += peer.o
+ovpn-y += socket.o
+ovpn-y += udp.o
diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
new file mode 100644
index 000000000000..090a3232ab0e
--- /dev/null
+++ b/drivers/net/ovpn/socket.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include <linux/net.h>
+#include <linux/netdevice.h>
+
+#include "ovpnstruct.h"
+#include "main.h"
+#include "io.h"
+#include "peer.h"
+#include "socket.h"
+#include "udp.h"
+
+static void ovpn_socket_detach(struct socket *sock)
+{
+	if (!sock)
+		return;
+
+	sockfd_put(sock);
+}
+
+/**
+ * ovpn_socket_release_kref - kref_put callback
+ * @kref: the kref object
+ */
+void ovpn_socket_release_kref(struct kref *kref)
+{
+	struct ovpn_socket *sock = container_of(kref, struct ovpn_socket,
+						refcount);
+
+	ovpn_socket_detach(sock->sock);
+	kfree_rcu(sock, rcu);
+}
+
+static bool ovpn_socket_hold(struct ovpn_socket *sock)
+{
+	return kref_get_unless_zero(&sock->refcount);
+}
+
+static struct ovpn_socket *ovpn_socket_get(struct socket *sock)
+{
+	struct ovpn_socket *ovpn_sock;
+
+	rcu_read_lock();
+	ovpn_sock = rcu_dereference_sk_user_data(sock->sk);
+	if (!ovpn_socket_hold(ovpn_sock)) {
+		pr_warn("%s: found ovpn_socket with ref = 0\n", __func__);
+		ovpn_sock = NULL;
+	}
+	rcu_read_unlock();
+
+	return ovpn_sock;
+}
+
+static int ovpn_socket_attach(struct socket *sock, struct ovpn_peer *peer)
+{
+	int ret = -EOPNOTSUPP;
+
+	if (!sock || !peer)
+		return -EINVAL;
+
+	if (sock->sk->sk_protocol == IPPROTO_UDP)
+		ret = ovpn_udp_socket_attach(sock, peer->ovpn);
+
+	return ret;
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
+	ret = ovpn_socket_attach(sock, peer);
+	if (ret < 0 && ret != -EALREADY)
+		return ERR_PTR(ret);
+
+	/* if this socket is already owned by this interface, just increase the
+	 * refcounter and use it as expected.
+	 *
+	 * Since UDP sockets can be used to talk to multiple remote endpoints,
+	 * openvpn normally instantiates only one socket and shares it among all
+	 * its peers. For this reason, when we find out that a socket is already
+	 * used for some other peer in *this* instance, we can happily increase
+	 * its refcounter and use it normally.
+	 */
+	if (ret == -EALREADY) {
+		/* caller is expected to increase the sock refcounter before
+		 * passing it to this function. For this reason we drop it if
+		 * not needed, like when this socket is already owned.
+		 */
+		ovpn_sock = ovpn_socket_get(sock);
+		sockfd_put(sock);
+		return ovpn_sock;
+	}
+
+	ovpn_sock = kzalloc(sizeof(*ovpn_sock), GFP_KERNEL);
+	if (!ovpn_sock)
+		return ERR_PTR(-ENOMEM);
+
+	ovpn_sock->ovpn = peer->ovpn;
+	ovpn_sock->sock = sock;
+	kref_init(&ovpn_sock->refcount);
+
+	rcu_assign_sk_user_data(sock->sk, ovpn_sock);
+
+	return ovpn_sock;
+}
diff --git a/drivers/net/ovpn/socket.h b/drivers/net/ovpn/socket.h
new file mode 100644
index 000000000000..5ad9c5073b08
--- /dev/null
+++ b/drivers/net/ovpn/socket.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
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
+struct ovpn_struct;
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
+	struct ovpn_struct *ovpn;
+	struct socket *sock;
+	struct kref refcount;
+	struct rcu_head rcu;
+};
+
+void ovpn_socket_release_kref(struct kref *kref);
+
+/**
+ * ovpn_socket_put - decrease reference counter
+ * @sock: the socket whose reference counter should be decreased
+ */
+static inline void ovpn_socket_put(struct ovpn_socket *sock)
+{
+	kref_put(&sock->refcount, ovpn_socket_release_kref);
+}
+
+struct ovpn_socket *ovpn_socket_new(struct socket *sock,
+				    struct ovpn_peer *peer);
+
+#endif /* _NET_OVPN_SOCK_H_ */
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
new file mode 100644
index 000000000000..c10474d252e1
--- /dev/null
+++ b/drivers/net/ovpn/udp.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2019-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include <linux/netdevice.h>
+#include <linux/socket.h>
+#include <net/udp.h>
+
+#include "ovpnstruct.h"
+#include "main.h"
+#include "socket.h"
+#include "udp.h"
+
+/**
+ * ovpn_udp_socket_attach - set udp-tunnel CBs on socket and link it to ovpn
+ * @sock: socket to configure
+ * @ovpn: the openvp instance to link
+ *
+ * After invoking this function, the sock will be controlled by ovpn so that
+ * any incoming packet may be processed by ovpn first.
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn)
+{
+	struct ovpn_socket *old_data;
+	int ret = 0;
+
+	/* sanity check */
+	if (sock->sk->sk_protocol != IPPROTO_UDP) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
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
+			   "%s: provided socket already owned by this interface\n",
+			   __func__);
+		ret = -EALREADY;
+	} else {
+		netdev_err(ovpn->dev,
+			   "%s: provided socket already taken by other user\n",
+			   __func__);
+		ret = -EBUSY;
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
diff --git a/drivers/net/ovpn/udp.h b/drivers/net/ovpn/udp.h
new file mode 100644
index 000000000000..f2507f8f2c71
--- /dev/null
+++ b/drivers/net/ovpn/udp.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2019-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_UDP_H_
+#define _NET_OVPN_UDP_H_
+
+struct ovpn_struct;
+struct socket;
+
+int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn);
+
+#endif /* _NET_OVPN_UDP_H_ */
-- 
2.44.2


