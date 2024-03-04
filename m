Return-Path: <netdev+bounces-77134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DB78704E1
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 369671C21DD5
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 15:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4268546B9A;
	Mon,  4 Mar 2024 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="KyF0dxIs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B023F9C0
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564950; cv=none; b=s7617eJEhw6Gq4Ud9FmOBDCeOID0OI/pKZ87p8EXqEDVHPEBlfSAWI+nt7mL+nqcAAaLqKqPwypR4eh/fN1sFwyvsuhxVbes6AU5XhbSlwmaWr2V1uy4iVvmzmz/RtUD4FR4kzsfZNLiwDA+V7V3qeA2vfZgOoSSIY3v3l+5OX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564950; c=relaxed/simple;
	bh=pYwz9P+e1CismdSnab/M6UpZhPURJb2a+IiEd3uHmww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMqm89DjBCkHU2DABL4yo76l7L8/17P5IHUlxyOpX4MdKmXWKlDtKY+8AY1/7STr7nfn28aEl1YuZVnV2+MNnFWeJT92DSlzkGaFCY5LBNrryBRPWFihx5FY/lllrau3hIT2zg1wx3b16lGwtFqOnK1N0lGh2wXtRriw8s/BIwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=KyF0dxIs; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a45606c8444so109281766b.3
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 07:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709564946; x=1710169746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3fD6N3dSFhcVOwIPW5T6EDadC/4lslk5JPnhJoiUPg=;
        b=KyF0dxIs3EQq5i3wlmIrVoPg7UUMmPRGmJ1bsB3jG0nQH3HATF8LWUNLfwvGCYPksH
         ap8GeEHtJyJkmS3F8yvNXOZEE6Jq0Q626WhJ06TD0lcMrSE/QL+EvWXLN85PVdQTKinL
         vsvHxtmgA8LHGM+WU1Z0NO+9UWj+N80lNKYGmvgcyLG03bkT+zxZPzrKNAK3kXZTGahh
         gDq34Fo/B5IEOAmBScELgOlZ7Lb/XfOpcTHpLD3ehk7t3/UFd07jnbX6r4UHb7NxChOb
         cwktnD3BOtsVjVCAfd0YKuOqL+1U/5ABY+0378VfOYbfzs7GUmW89IY+Tr9/svjMe/nZ
         Y2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709564946; x=1710169746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3fD6N3dSFhcVOwIPW5T6EDadC/4lslk5JPnhJoiUPg=;
        b=G/YNZyAP/6I7QoX4rcNKyJaCO+uxrIpBI5jvzxgWOxEzOrAEl/k8pH7PMXSWYrhYDj
         LiB9sZ9ebREG5BSMLJi20hWssN0V8/Sr555tUv/ry/8NSJN8edjHxe3Ou//gEjHaFjkq
         hwnhO07kQ+6tNqIp96bqfqZhMVnmC/M+/HNC0MeSl35cXDLqJR3faVHQPb1Joap3yt4W
         T96V/606yxb98CN/RXLKtSWoS6rq56PY6xd2KILh3vkEf+m8lBXGNEB7k+iBOtZD0YmS
         VNbFW739NomGbaNhXku6pbfeGmsQMigf0+SIKG5MQZOtXK2MU1ljF2x9TcbjWx6KOdcE
         aipg==
X-Gm-Message-State: AOJu0YwHMvjzcKo26t+NHH355mwKMFQsdOaj/+Y4xBYYZn4CF4gLirpC
	YAFGr477T1N5ZOa9Zl/kt7iHsaxXrvn5Uj5JdVCmiQ7QxTfE5eMVavqFuz2sAuTaX0YxB3yhmsL
	VCOc=
X-Google-Smtp-Source: AGHT+IF4GJp0z3neutqxRisgRD+Lg2zOXN+4I7WWI/+WPTQF+F4lWEcy9T2/ckEQeGN7Yelm3I254g==
X-Received: by 2002:a17:906:e2cc:b0:a44:dadc:654e with SMTP id gr12-20020a170906e2cc00b00a44dadc654emr4367947ejb.39.1709564946396;
        Mon, 04 Mar 2024 07:09:06 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:1d25:beac:2343:34ef])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b00a44d01aff81sm2904069ejb.97.2024.03.04.07.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:09:06 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v2 07/22] ovpn: introduce the ovpn_socket object
Date: Mon,  4 Mar 2024 16:08:58 +0100
Message-ID: <20240304150914.11444-8-antonio@openvpn.net>
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

This specific structure is used in the ovpn kernel module
to wrap and carry around a standard kernel socket.

ovpn takes ownership of passed sockets and therefore an ovpn
specific objects is attathced to them for status tracking
purposes.

Initially only UDP support is introduced. TCP will come in a later
patch.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/Makefile |  2 +
 drivers/net/ovpn/socket.c | 98 +++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/socket.h | 47 +++++++++++++++++++
 drivers/net/ovpn/udp.c    | 46 ++++++++++++++++++
 drivers/net/ovpn/udp.h    | 18 +++++++
 5 files changed, 211 insertions(+)
 create mode 100644 drivers/net/ovpn/socket.c
 create mode 100644 drivers/net/ovpn/socket.h
 create mode 100644 drivers/net/ovpn/udp.c
 create mode 100644 drivers/net/ovpn/udp.h

diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
index 1399b9d9c076..f768cd95b777 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -12,3 +12,5 @@ ovpn-y += main.o
 ovpn-y += io.o
 ovpn-y += netlink.o
 ovpn-y += peer.o
+ovpn-y += socket.o
+ovpn-y += udp.o
diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
new file mode 100644
index 000000000000..b7ccc4882d1e
--- /dev/null
+++ b/drivers/net/ovpn/socket.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include "main.h"
+#include "io.h"
+#include "peer.h"
+#include "socket.h"
+#include "udp.h"
+
+/* Finalize release of socket, called after RCU grace period */
+static void ovpn_socket_detach(struct socket *sock)
+{
+	if (!sock)
+		return;
+
+	sockfd_put(sock);
+}
+
+void ovpn_socket_release_kref(struct kref *kref)
+{
+	struct ovpn_socket *sock = container_of(kref, struct ovpn_socket, refcount);
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
+/* Finalize release of socket, called after RCU grace period */
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
+struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
+{
+	struct ovpn_socket *ovpn_sock;
+	int ret;
+
+	ret = ovpn_socket_attach(sock, peer);
+	if (ret < 0 && ret != -EALREADY)
+		return ERR_PTR(ret);
+
+	/* if this socket is already owned by this interface, just increase the refcounter */
+	if (ret == -EALREADY) {
+		/* caller is expected to increase the sock refcounter before passing it to this
+		 * function. For this reason we drop it if not needed, like when this socket is
+		 * already owned.
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
index 000000000000..92c50f795f7c
--- /dev/null
+++ b/drivers/net/ovpn/socket.h
@@ -0,0 +1,47 @@
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
+#include <linux/ptr_ring.h>
+#include <net/sock.h>
+
+
+struct ovpn_struct;
+struct ovpn_peer;
+
+/**
+ * struct ovpn_socket - a kernel socket referenced in the ovpn code
+ */
+struct ovpn_socket {
+	/* the VPN session object owning this socket (UDP only) */
+	struct ovpn_struct *ovpn;
+	/* the kernel socket */
+	struct socket *sock;
+	/* amount of contexts currently referencing this object */
+	struct kref refcount;
+	/* member used to schedule RCU destructor callback */
+	struct rcu_head rcu;
+};
+
+struct ovpn_struct *ovpn_from_udp_sock(struct sock *sk);
+
+void ovpn_socket_release_kref(struct kref *kref);
+
+static inline void ovpn_socket_put(struct ovpn_socket *sock)
+{
+	kref_put(&sock->refcount, ovpn_socket_release_kref);
+}
+
+struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer);
+
+#endif /* _NET_OVPN_SOCK_H_ */
diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
new file mode 100644
index 000000000000..8bfd0eece1d9
--- /dev/null
+++ b/drivers/net/ovpn/udp.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2019-2024 OpenVPN, Inc.
+ *
+ *  Author:	Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include "main.h"
+#include "ovpnstruct.h"
+#include "socket.h"
+#include "udp.h"
+
+#include <linux/socket.h>
+
+
+/* Set UDP encapsulation callbacks */
+int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn)
+{
+	struct ovpn_socket *old_data;
+
+	/* sanity check */
+	if (sock->sk->sk_protocol != IPPROTO_UDP) {
+		netdev_err(ovpn->dev, "%s: expected UDP socket\n", __func__);
+		return -EINVAL;
+	}
+
+	/* make sure no pre-existing encapsulation handler exists */
+	rcu_read_lock();
+	old_data = rcu_dereference_sk_user_data(sock->sk);
+	rcu_read_unlock();
+	if (old_data) {
+		if (old_data->ovpn == ovpn) {
+			netdev_dbg(ovpn->dev,
+				   "%s: provided socket already owned by this interface\n",
+				   __func__);
+			return -EALREADY;
+		}
+
+		netdev_err(ovpn->dev, "%s: provided socket already taken by other user\n",
+			   __func__);
+		return -EBUSY;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/ovpn/udp.h b/drivers/net/ovpn/udp.h
new file mode 100644
index 000000000000..9ba41bd539aa
--- /dev/null
+++ b/drivers/net/ovpn/udp.h
@@ -0,0 +1,18 @@
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
+#include <net/sock.h>
+
+struct ovpn_struct;
+
+int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn);
+
+#endif /* _NET_OVPN_UDP_H_ */
-- 
2.43.0


