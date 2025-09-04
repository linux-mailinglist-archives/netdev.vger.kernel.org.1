Return-Path: <netdev+bounces-220160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6E2B44925
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 00:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE3D1CC31FC
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 22:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8212F6173;
	Thu,  4 Sep 2025 22:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="gDt2Xqdm"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87E12D9795;
	Thu,  4 Sep 2025 22:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757023416; cv=none; b=INhb2Wm6qbBI+4DMBVnWgQ2T1XqtrLd59XRxlSdHozTITsUYG0dKUYfox7gvLB8Ernbs+kdvLJcn6+NbPbq+q6PPWF0WRM3JGU2Ov79H6WR9eW78HTeNivH4F+OC9xU1PPLIsRjjDJGKldae3N8MVL3RSXnekSrbrTEshvjBpFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757023416; c=relaxed/simple;
	bh=lIP0W9G+FPRpTNak5uCbuw1zfGwr7KCy9+w0vxsXf1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tOw4y9WRsSpc9uK2OF69v8vV5ueUauf4hmsbgiHK5sXnu31M68403TlPdoTVvQS/whSHPENIWcHY69rRi/QJQDq5EtPJwieB8SzZatrdZVS9/qdV+GmUheYGsjo1tkFZpa46QGuUm7vWaXQTyBTc/sUzwxaSIjwHodiuRTXrJF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=gDt2Xqdm; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757023399;
	bh=lIP0W9G+FPRpTNak5uCbuw1zfGwr7KCy9+w0vxsXf1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gDt2XqdmHvuXHiqkJGbfDO5PilePBac06GFLeNlsdwxFGC+aDqvcNz42O01t0BHmg
	 QhEizFSse1wAw5utQfNDf54Ti9deWWvnjHL+s/RDvtdTjrAcJITkQ4/DBMZWo0YCsY
	 Iv2GPxZAk716AzY//NScucYiMjjWuc+gxXt4M7wMJ3DYUQ6dcI29yNWEAXxTuEkmBO
	 Oc9XSo0F5tADCsjdeWvrbRPZN4a1vuRA8GIzKzM+zbUpG9Ee2tRqEZZ6yRBeZ0dU9I
	 Ns3j0Zwiy04P4Wx4YVltt2AT2FWwgD0ik32ysJ7jGTbelsf1RFmT1w/XEed3KEP3Xa
	 hp7f6cABdUChw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 1D21360588;
	Thu,  4 Sep 2025 22:03:19 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 5FAF720291B; Thu, 04 Sep 2025 22:02:58 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next 04/14] netlink: specs: wireguard: add remaining checks
Date: Thu,  4 Sep 2025 22:02:38 +0000
Message-ID: <20250904220255.1006675-4-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250904-wg-ynl-rfc@fiberby.net>
References: <20250904-wg-ynl-rfc@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch adds the remaining checks from the existing
policy code, and thereby completes the wireguard spec.

These are added separately in this RFC mainly to showcase
two difference approaches to convert them.

They require a sizeof() operations or arithmetics, both of
which can't be expressed in YNL currently.

In order to keep the C code 1:1, then in this patch they are
added as an additional UAPI header wireguard_params.h,
defining them so that ynl-gen can reference them as constants.

This approach could also allow a selftest to validate that
the value of the constant in the YNL spec, is the same as the
value in the header file.

In patch 12 in this series, this patch is reverted, and replaced
with magic numbers in the YNL checks, as an alternative.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 Documentation/netlink/specs/wireguard.yaml | 36 ++++++++++++++++++++++
 MAINTAINERS                                |  1 +
 include/uapi/linux/wireguard_params.h      | 18 +++++++++++
 3 files changed, 55 insertions(+)
 create mode 100644 include/uapi/linux/wireguard_params.h

diff --git a/Documentation/netlink/specs/wireguard.yaml b/Documentation/netlink/specs/wireguard.yaml
index c6db3bbf0985..37011c3f158b 100644
--- a/Documentation/netlink/specs/wireguard.yaml
+++ b/Documentation/netlink/specs/wireguard.yaml
@@ -21,6 +21,34 @@ definitions:
     name: key-len
     type: const
     value: 32
+  -
+    name-prefix: --wg-
+    name: inaddr-sz
+    type: const
+    doc: Equivalent of ``sizeof(struct in_addr)``.
+    header: linux/wireguard_params.h
+    value: 4
+  -
+    name-prefix: --wg-
+    name: sockaddr-sz
+    type: const
+    doc: Equivalent of ``sizeof(struct sockaddr)``.
+    header: linux/wireguard_params.h
+    value: 16
+  -
+    name-prefix: --wg-
+    name: timespec-sz
+    type: const
+    doc: Equivalent of ``sizeof(struct __kernel_timespec)``.
+    header: linux/wireguard_params.h
+    value: 16
+  -
+    name-prefix: --wg-
+    name: ifnamlen
+    type: const
+    doc: Equivalent of ``IFNAMSIZ - 1``.
+    header: linux/wireguard_params.h
+    value: 15
   -
     name: --kernel-timespec
     type: struct
@@ -74,6 +102,8 @@ attribute-sets:
       -
         name: ifname
         type: string
+        checks:
+          max-len: --wg-ifnamlen
       -
         name: private-key
         type: binary
@@ -148,6 +178,8 @@ attribute-sets:
         name: endpoint
         doc: struct sockaddr_in or struct sockaddr_in6
         type: binary
+        checks:
+          min-len: --wg-sockaddr-sz
       -
         name: persistent-keepalive-interval
         type: u16
@@ -156,6 +188,8 @@ attribute-sets:
         name: last-handshake-time
         type: binary
         struct: --kernel-timespec
+        checks:
+          exact-len: --wg-timespec-sz
       -
         name: rx-bytes
         type: u64
@@ -191,6 +225,8 @@ attribute-sets:
         type: binary
         doc: struct in_addr or struct in6_add
         display-hint: ipv4-or-v6
+        checks:
+          min-len: --wg-inaddr-sz
       -
         name: cidr-mask
         type: u8
diff --git a/MAINTAINERS b/MAINTAINERS
index 1540aa22d152..e8360e4b55c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27170,6 +27170,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/netlink/specs/wireguard.yaml
 F:	drivers/net/wireguard/
+F:	include/uapi/linux/wireguard_params.h
 F:	tools/testing/selftests/wireguard/
 
 WISTRON LAPTOP BUTTON DRIVER
diff --git a/include/uapi/linux/wireguard_params.h b/include/uapi/linux/wireguard_params.h
new file mode 100644
index 000000000000..c218e4b8042f
--- /dev/null
+++ b/include/uapi/linux/wireguard_params.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+
+#ifndef _UAPI_LINUX_WIREGUARD_PARAMS_H
+#define _UAPI_LINUX_WIREGUARD_PARAMS_H
+
+#include <linux/time_types.h>
+#include <linux/if.h>
+#include <linux/in.h>
+
+/* These definitions are currently needed for definitions which can't
+ * be expressed directly in Documentation/netlink/specs/wireguard.yaml
+ */
+#define __WG_INADDR_SZ (sizeof(struct in_addr))
+#define __WG_SOCKADDR_SZ (sizeof(struct sockaddr))
+#define __WG_TIMESPEC_SZ (sizeof(struct __kernel_timespec))
+#define __WG_IFNAMLEN (IFNAMSIZ - 1)
+
+#endif /* _UAPI_LINUX_WIREGUARD_PARAMS_H */
-- 
2.51.0


