Return-Path: <netdev+bounces-231443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE53BF949C
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D68C74EEA5B
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 23:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88CC2749D6;
	Tue, 21 Oct 2025 23:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bADi7B/p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B86E23E340
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 23:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090423; cv=none; b=liPx/ddZJaz9vU5YksPdBn0RIZZ79VUxRMOmrsxvtKARNyLvoHc+aiRlIZVQ34RuDu2IG3/9sZ/I5oaD1WFi0Q1kTHHdjLOr6J05wuBXwg91CgpI+c6imLgnxfmFq9lrNBELC/ldsW6376QfFTvZ+Bzex105zdrBqcd9rIvQjeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090423; c=relaxed/simple;
	bh=i/0blcvw30L2XmsZDP8JwezkIYQz0CtWUOjE1zydzXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u54hqmiVXwaalFjQXdwoEo2mck0lSKltPp1CcGDXznDBlSNcQgVZ2wWyY/g7WCWZOdEjJGbU0Lr/0I57i66f7y3iT6ItNzkvivPKFss24kuEkfLhVaYNhAAbCt4B9T4GWYvUGgh6jVQwCZZPz8qKPktGeFhWz2Z6j0SksN3qz3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bADi7B/p; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33255011eafso5823404a91.1
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 16:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090420; x=1761695220; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ux00ENqxNtzazJRP0kNIFZEFFfqT/sB9ciqM1XMIy8Y=;
        b=bADi7B/pZVDCE7VQv7lugnzQ18wRMEqm0V+SsIVNvoOsEejkuOFcmucO70NUMdlrRn
         nDgIfYNZFKZpatd2u9Ouia5gQcwNGRFmEg+bTsP+4w5feLim+Bj8M5wP1FHn6cjbhGqj
         IZeB8umpj4ftY9zphnMT5lDd5Dv8NP8ePlgItJgbl8NvdtI8GbT1A8PicdvliKK9dBkZ
         ZzJ33tn28IB63lB35dsp6/9vnTxSg3zAC8vCxCg8lfa0MlVsmXgR8pPI6Yw7Tcpegb/J
         VUs6rzSPXDRveYIJ2t8enX41n3ysSdp7tQMviUFFnrHbwM14mZCDSuzwgkvodgByLUvy
         vz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090420; x=1761695220;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ux00ENqxNtzazJRP0kNIFZEFFfqT/sB9ciqM1XMIy8Y=;
        b=DhrTOfJAZm6NTyV0lEbhGITvDdHRl/8SkjqaPJFrw0IHnFf7Ewm5+An7n6DI2U39Mh
         dAGzop0CaRC8D1xYe6LtBMpp5+f+qQI26ZD5xQMth0NpIjXsfRPSpcOj9IxBiLxRV8aP
         QFzaHqxHLiekG5ehHqMo7dnQzCsupHuZrnEWdQeNgBBfJpaobqDGmabhhltbFSOG7dvu
         3Y9PquGnK+TIDRt8gXmLDBF54WHl7zhU9eDGU0Al1pIBu2AYDuwPkoI31M+kFVMoDXxr
         vLmG7sSzIRoZDilmJsktoJJeR0YSig8gXLrrpnJ5f8aECAds+eDaqjqSLTqNg+Xjugxc
         LNig==
X-Forwarded-Encrypted: i=1; AJvYcCUhlLNu5caVdW5FCUWzNvGMkqUk+om3u+cQxj6ExkYqPWbeZn+pZRbFMK90RI7KmvIyExCC7kI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp4zOmUeRaa2rhURAHmsY+xKq28iLrTzTF0mei0Z6CRmkeigKC
	rpX2MI39hhYyIJfjntKYrwRujLo9Pjd17V00+PBk77mf03/wYogcXYrQ
X-Gm-Gg: ASbGncstBelBWwyxuBQrVl5XSkmWRDgTe/h16PclmRlqchWpHkZ1l4pslMiP+qPm1iN
	vxY0UNO+elmnfOyMsE5WtcrvMUM9ZWNV8PCfNHIg1e3Ffx4EGlWH+iK8Ruy2RG7iBK4A4wvpZZ9
	wGXeWlgQg+ZeuSyCVji961wuXDt3SHQqo6hCAXejrGrp+YUSu22lZF87/5kjOtlJcHQSWbNQPqv
	hWiUwtmZc7sC5GhuKwfXxbZCC44n1/Y6GW2i/tFpyXH0LUO0UjqaP0BSvUpD7csc4MjNUYYf2qw
	s9pxXP34cdnP0/ktX3935cnxRPdZ4eM/zIs5WzejTTEAV+yeHmahgGkpbR3/bvmYpNJ0OgTfcxv
	LfysHawdKwQnnu3pluc6pAo+YH8MGK4r4DWdMUsXIRU3dFNLczGKJkEgtP7vy3R0Ag9yRjlaU
X-Google-Smtp-Source: AGHT+IHeGId/ywDSD1+B3HjeV1Dv8DYhirb7ZJAGBaWWTqw55VcAYUuGBf/b9fQl2uNxLFwxdMYmNQ==
X-Received: by 2002:a17:903:2445:b0:25c:25f1:542d with SMTP id d9443c01a7336-290ca1219e1mr253823315ad.36.1761090419637;
        Tue, 21 Oct 2025 16:46:59 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fd9e8sm120714105ad.85.2025.10.21.16.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:46:59 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:44 -0700
Subject: [PATCH net-next v7 01/26] vsock: a per-net vsock NS mode state
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-1-0661b7b6f081@meta.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
In-Reply-To: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add the per-net vsock NS mode state. This only adds the structure for
holding the mode and some of the functions for setting/getting and
checking the mode, but does not integrate the functionality yet.

A "net_mode" field is added to vsock_sock to store the mode of the
namespace when the vsock_sock was created. In order to evaluate
namespace mode rules we need to know both a) which namespace the
endpoints are in, and b) what mode that namespace had when the endpoints
were created. This allows us to handle the changing of modes from global
to local *after* a socket has been created by remembering that the mode
was global when the socket was created. If we were to use the current
net's mode instead, then the lookup would fail and the socket would
break.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v7:
- clarify vsock_net_check_mode() comments
- change to `orig_net_mode == VSOCK_NET_MODE_GLOBAL && orig_net_mode == vsk->orig_net_mode`
- remove extraneous explanation of `orig_net_mode`
- rename `written` to `mode_locked`
- rename `vsock_hdr` to `sysctl_hdr`
- change `orig_net_mode` to `net_mode`
- make vsock_net_check_mode() more generic by taking just net pointers
  and modes, instead of a vsock_sock ptr, for reuse by transports
  (e.g., vhost_vsock)

Changes in v6:
- add orig_net_mode to store mode at creation time which will be used to
  avoid breakage when namespace changes mode during socket/VM lifespan

Changes in v5:
- use /proc/sys/net/vsock/ns_mode instead of /proc/net/vsock_ns_mode
- change from net->vsock.ns_mode to net->vsock.mode
- change vsock_net_set_mode() to vsock_net_write_mode()
- vsock_net_write_mode() returns bool for write success to avoid
  need to use vsock_net_mode_can_set()
- remove vsock_net_mode_can_set()
---
 MAINTAINERS                 |  1 +
 include/net/af_vsock.h      | 64 +++++++++++++++++++++++++++++++++++++++++++++
 include/net/net_namespace.h |  4 +++
 include/net/netns/vsock.h   | 20 ++++++++++++++
 4 files changed, 89 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4faa7719bf86..c58f9e38898a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27062,6 +27062,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/vhost/vsock.c
 F:	include/linux/virtio_vsock.h
+F:	include/net/netns/vsock.h
 F:	include/uapi/linux/virtio_vsock.h
 F:	net/vmw_vsock/virtio_transport.c
 F:	net/vmw_vsock/virtio_transport_common.c
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index d40e978126e3..a1053d3668cf 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -10,6 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/workqueue.h>
+#include <net/netns/vsock.h>
 #include <net/sock.h>
 #include <uapi/linux/vm_sockets.h>
 
@@ -65,6 +66,7 @@ struct vsock_sock {
 	u32 peer_shutdown;
 	bool sent_request;
 	bool ignore_connecting_rst;
+	enum vsock_net_mode net_mode;
 
 	/* Protected by lock_sock(sk) */
 	u64 buffer_size;
@@ -256,4 +258,66 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
 {
 	return t->msgzerocopy_allow && t->msgzerocopy_allow();
 }
+
+static inline enum vsock_net_mode vsock_net_mode(struct net *net)
+{
+	enum vsock_net_mode ret;
+
+	spin_lock_bh(&net->vsock.lock);
+	ret = net->vsock.mode;
+	spin_unlock_bh(&net->vsock.lock);
+	return ret;
+}
+
+static inline bool vsock_net_write_mode(struct net *net, u8 mode)
+{
+	bool ret;
+
+	spin_lock_bh(&net->vsock.lock);
+
+	if (net->vsock.mode_locked) {
+		ret = false;
+		goto skip;
+	}
+
+	net->vsock.mode = mode;
+	net->vsock.mode_locked = true;
+	ret = true;
+
+skip:
+	spin_unlock_bh(&net->vsock.lock);
+	return ret;
+}
+
+/* Return true if two namespaces and modes pass the mode rules. Otherwise,
+ * return false.
+ *
+ * ns0 and ns1 are the namespaces being checked.
+ * mode0 and mode1 are the vsock namespace modes of ns0 and ns1.
+ *
+ * Read more about modes in the comment header of net/vmw_vsock/af_vsock.c.
+ */
+static inline bool vsock_net_check_mode(struct net *ns0, enum vsock_net_mode mode0,
+					struct net *ns1, enum vsock_net_mode mode1)
+{
+	/* Any vsocks within the same network namespace are always reachable,
+	 * regardless of the mode.
+	 */
+	if (net_eq(ns0, ns1))
+		return true;
+
+	/*
+	 * If the network namespaces differ, vsocks are only reachable if both
+	 * were created in VSOCK_NET_MODE_GLOBAL mode.
+	 *
+	 * The vsock namespace mode is write-once, and the default is
+	 * VSOCK_NET_MODE_GLOBAL. Once set to VSOCK_NET_MODE_LOCAL, it cannot
+	 * revert to GLOBAL. It is not possible to have a case where a socket
+	 * was created in LOCAL mode, and then the mode switched to GLOBAL.
+	 *
+	 * As a result, we only need to check if the modes were global at
+	 * creation time.
+	 */
+	return mode0 == VSOCK_NET_MODE_GLOBAL && mode0 == mode1;
+}
 #endif /* __AF_VSOCK_H__ */
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index cb664f6e3558..66d3de1d935f 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -37,6 +37,7 @@
 #include <net/netns/smc.h>
 #include <net/netns/bpf.h>
 #include <net/netns/mctp.h>
+#include <net/netns/vsock.h>
 #include <net/net_trackers.h>
 #include <linux/ns_common.h>
 #include <linux/idr.h>
@@ -196,6 +197,9 @@ struct net {
 	/* Move to a better place when the config guard is removed. */
 	struct mutex		rtnl_mutex;
 #endif
+#if IS_ENABLED(CONFIG_VSOCKETS)
+	struct netns_vsock	vsock;
+#endif
 } __randomize_layout;
 
 #include <linux/seq_file_net.h>
diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
new file mode 100644
index 000000000000..c9a438ad52f2
--- /dev/null
+++ b/include/net/netns/vsock.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __NET_NET_NAMESPACE_VSOCK_H
+#define __NET_NET_NAMESPACE_VSOCK_H
+
+#include <linux/types.h>
+
+enum vsock_net_mode {
+	VSOCK_NET_MODE_GLOBAL,
+	VSOCK_NET_MODE_LOCAL,
+};
+
+struct netns_vsock {
+	struct ctl_table_header *sysctl_hdr;
+	spinlock_t lock;
+
+	/* protected by lock */
+	enum vsock_net_mode mode;
+	bool mode_locked;
+};
+#endif /* __NET_NET_NAMESPACE_VSOCK_H */

-- 
2.47.3


