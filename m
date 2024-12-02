Return-Path: <netdev+bounces-148120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632B89E0661
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 16:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23FB728ABCD
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDA220966D;
	Mon,  2 Dec 2024 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="BGQerBWa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26320207A14
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 15:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152116; cv=none; b=FVQMso/NUEoEUn+b8wO0gZXTenpfknZ5lMpP69OcTjroSVzmgrqTagBoWeiS0MFoYJVKPMO7tCkR/rwZFvdQvHmuv1vU/06lmAVq/NMMZVGLbl8H+9qVgc2Hp8lyT4sW8ECaAC19RB588/6MQksvBYdGUvpsoc8UDPyM+EeC7tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152116; c=relaxed/simple;
	bh=s4/ZdT9zdOkVSSi9e3WzjwtVGY+a1rBt+0eChPO/3OE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eiuBrbmXRaSdW+okbp5OY+SpRCoii1z0SmqU6+03e9MYRarJrBNIN2whaDmx3cSVjCJBtAVR7/pKa0tSGlFbZTS5iRmM0iUUMPEUb7f1/ztIOdtRZWd5QK1eNIPt1BWTtM+xmRLmGJlA1ltW1ON39j+04NM2ta6RpFRYTiHWc+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=BGQerBWa; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385eed29d17so899497f8f.0
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 07:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733152112; x=1733756912; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3daJ53YHoVN7jrj6xC4iHVjMVlqLQppA0hCq5GaWo3g=;
        b=BGQerBWatDXOzP7Wv2/FQaRxtYh9onTr3lFQA0vbLPtHPmdHUcmFA0szdJeuVHGNhL
         1Qqygvz4rgGgLlDS9SZk2t6veNqez5mnnV03ksM8mcuGVkW3shJwzFz3BVlPvdoSFTSq
         joaiBJGpnh+QNzaI9borbl0ODtqZcg4aHOJpH6YDgaz2xnzzUJfkIT/yakEhmesaHFGl
         rSK4O0Quzetx8oJ3IPdSsPaD/TyN0Mx6SvaWFNjQxHVhNS90ZHlIhws8MoyzvSDuM4x+
         YmvnMkzImw8sndYuIjAF2ldzvcrA1NMfXmV6xZRMXM9u0GDfr3/7XmCFpj5q5f72oT/h
         Hm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733152112; x=1733756912;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3daJ53YHoVN7jrj6xC4iHVjMVlqLQppA0hCq5GaWo3g=;
        b=To4WCNGT9Ne2zX6t3tEcS6+wHbG/KB8+u18Ms4IYqZpkSV9QJQNXCp2jH3v0mcwdmZ
         wHrKQxZpj1XBogZBb/2pF3/bC3WLswJDVxR8RZXudJsF7YxvVkTaJMeZpSCd0FDaBSL7
         3ZA4C/f3kTB+xOtHP5xXxUpal+Yx8o/STAtHvq/HcGivgYi13jXwMJz+j2tHc+yWrNkV
         OO9oG7frcT3YxtyM4AdSLD8M77IurlGJkuoz8FK38xHsHKbtpvJTgLiFiey/rMPKo0fG
         9izfnOAhUdjnS4XK9FEZz4ySfGxhXSJp23vAbq5zj+i7LhvCtUcRxRlJRS4NybxrQGAS
         Im1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWaOrbqdmWKwMS5yyUYrw2gwzKwSju+H9/hGM0M4AlEhoSdHK881Vwi2IJnpuj4U2fKwF2nYfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3YUkzdrSHhZcbQCbiHMX+/dpjiPjVT2WLpLZiNTAID4Gmt938
	/STIKkQubvlyE7mt4dv0acCvt+r3jYlx7PJAbKk4yA+B0Mj6N9RKdrqizc5XLEU=
X-Gm-Gg: ASbGncviHGSduW0FI3L4ZmmkJmKQ/BzTWx50Z2VKSvwVOlIefN1dSmt6xkZCyXcfzTW
	1n+RhfS76Mvm7qwrP1mPbJFtnnp/h/ulpFDA1q4wpBlcuYxCX7aQbsMeQePFXT3qVjOOdAZsBCd
	Fsi90FWT5+x1DNzLZyIOaF4MRDetTvPqBnsqjrXah+RP7oGc/4J69OVKjNYbieEHShMVUiVQ1Sa
	dGMiJGe2Ld80Vd/pp4+T5novxhAYwuCKdIeYJBBLkjBpCAMzHjc4beublBT
X-Google-Smtp-Source: AGHT+IEhKROhUN0wfgdS73vJ3uswtm21WXaoM04qgso+ZMHHE0VVnC/mFKbobALKNYDkWQCQYs2jMQ==
X-Received: by 2002:a05:6000:79e:b0:385:e429:e591 with SMTP id ffacd0b85a97d-385e429e6cfmr6626252f8f.23.1733152110576;
        Mon, 02 Dec 2024 07:08:30 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:5d0b:f507:fa8:3b2e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e8a47032sm6570395f8f.51.2024.12.02.07.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:08:30 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 02 Dec 2024 16:07:24 +0100
Subject: [PATCH net-next v12 06/22] ovpn: introduce the ovpn_socket object
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-b4-ovpn-v12-6-239ff733bf97@openvpn.net>
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
In-Reply-To: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9367; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=s4/ZdT9zdOkVSSi9e3WzjwtVGY+a1rBt+0eChPO/3OE=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnTc1mnKn/3pk7y3wJc5jvvvZVrMIi4u2latKvV
 ZR3ixZownGJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ03NZgAKCRALcOU6oDjV
 h2JsB/0asCCjSSHfsjMZ9mPTVL7u6bxNUqaRwz+4NcgYa6syHf7mJhw2L+4SncGoHSdh6ookqfC
 a+DO7q+bDK0g/3RyT/oz9gx6tZGrYFd94to6t9/Cyllzh9TwWqxNa4mmC6pTvUrzJMUXwrHAvHB
 qVmRzOHNx4ElSiehFAHHpGLXAFjEwI9vIUs0tUsY+1DXR7leS7XTBFBoE5M88nf9bD90GDRBtIV
 KeflkiKfc9rYIHcA6GdHY0NI+QVcZuJQeUJBCOeCizssWmFbr98wI13yUh+qzUjky2zftVPCfAX
 86U03ykSehRvgIotzm7UTufcxg9pCyy9CEn9WjEqjnYizdMk
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

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
 drivers/net/ovpn/socket.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/socket.h |  48 +++++++++++++++++++
 drivers/net/ovpn/udp.c    |  65 +++++++++++++++++++++++++
 drivers/net/ovpn/udp.h    |  17 +++++++
 include/uapi/linux/udp.h  |   1 +
 6 files changed, 252 insertions(+)

diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
index ce13499b3e1775a7f2a9ce16c6cb0aa088f93685..56bddc9bef83e0befde6af3c3565bb91731d7b22 100644
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
index 0000000000000000000000000000000000000000..0abac02e13fb4ef1e212dacae075d5b58e872d34
--- /dev/null
+++ b/drivers/net/ovpn/socket.c
@@ -0,0 +1,119 @@
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
+#include <linux/udp.h>
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
+	if (WARN_ON(!ovpn_socket_hold(ovpn_sock)))
+		ovpn_sock = NULL;
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
index 0000000000000000000000000000000000000000..904814d2b9e9f2b0773bf942372bcbe904ef5474
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
index 0000000000000000000000000000000000000000..c00e07f148d72ff737e732028fd73f82a507fb57
--- /dev/null
+++ b/drivers/net/ovpn/udp.c
@@ -0,0 +1,65 @@
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
+#include <linux/udp.h>
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
+int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_priv *ovpn)
+{
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
diff --git a/drivers/net/ovpn/udp.h b/drivers/net/ovpn/udp.h
new file mode 100644
index 0000000000000000000000000000000000000000..3c48a06f15eed624aec0a2a7b871f0e7f3004137
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
+struct ovpn_priv;
+struct socket;
+
+int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_priv *ovpn);
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
2.45.2


