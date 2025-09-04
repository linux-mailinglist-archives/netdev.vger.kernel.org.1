Return-Path: <netdev+bounces-220161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50612B44929
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 00:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17813188A8E4
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 22:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7812F99BE;
	Thu,  4 Sep 2025 22:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="pdA9hRop"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BCF2EBDD9;
	Thu,  4 Sep 2025 22:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757023416; cv=none; b=cKVd+xABaA/1WNWb4Ubm+HL9wcI7HQaCLC9Xl48ACeNH98WZ7W+AifG/IRHEhxUI2VYN3X3zJMy1zHdOjL5qt9Bj3Om4YWr5IcEGpuOm4pfLgkZWlTYx0IjJYyake8ye8U7l7o/pLIZV52G4/m4JWSMjP08T98bMpUEYXnqkuEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757023416; c=relaxed/simple;
	bh=CO/vHSTBdTAo/V5DNoVuti5MiqLKMG3c1AdHyp2ogNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LrVpfj60VFoa+rFQqUBn3hbUdDPuMfJfUJQ81NgHtxSIYDtp6s69+ufz0mY26d4VZPQagBOqtRv4UkI4lpwOH48o8gs1xBJBg6UwkUtVGh5HySfX1AtqqND+xQ6u0mSAu/XYhvsT5efdrhbXCrECMt8NQBKYYZlc7y9CoZd7V2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=pdA9hRop; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757023399;
	bh=CO/vHSTBdTAo/V5DNoVuti5MiqLKMG3c1AdHyp2ogNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pdA9hRopUBhN4otUAIQhIHglPx8eiFkCbH18XD6SfoVQ6M45e+XGflfRTxI9k+S/Q
	 CplL+4deR/eoPTryNZoP/mFcwShrsLQQ5U80CEhgz+s8qSpnqW3q7q8RIUfZ+qhWcl
	 QPs9BXFt55PMn2e4ssRLz1fVY3hjwRUYp7TwvygJuP+4OPgzn2gErh+YwK4ot3EXbD
	 ZGhbmLLbNqUZerPP9i+kNByPvkaV+hkNsWp7Vaulo4a1yGxmle6rE3WnYTyILFLAPl
	 81o52p5ES2NUE87ZpyaGrrxnPMZM3ZDf3eyge88UUKdQAAkK0NI2m6LnSyYbuyK4EK
	 e1jQyea+Sd9gQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 1D3E360589;
	Thu,  4 Sep 2025 22:03:19 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id AD997202B05; Thu, 04 Sep 2025 22:02:58 +0000 (UTC)
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
Subject: [RFC net-next 12/14] netlink: specs: wireguard: alternative to wireguard_params.h
Date: Thu,  4 Sep 2025 22:02:46 +0000
Message-ID: <20250904220255.1006675-12-ast@fiberby.net>
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

This is an alternative to the approach taken in patch 04,

Use magic constants in C as well, and thereby obfuscate
their origin.

If this is preferred then I will split and squash this
patch into the previous commits, so that it's done like
this in the original specification patch.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 Documentation/netlink/specs/wireguard.yaml | 36 +++-------------------
 drivers/net/wireguard/netlink_gen.c        | 11 +++----
 drivers/net/wireguard/netlink_gen.h        |  1 -
 include/uapi/linux/wireguard_params.h      | 18 -----------
 4 files changed, 9 insertions(+), 57 deletions(-)
 delete mode 100644 include/uapi/linux/wireguard_params.h

diff --git a/Documentation/netlink/specs/wireguard.yaml b/Documentation/netlink/specs/wireguard.yaml
index 37011c3f158b..bb44171d9ac5 100644
--- a/Documentation/netlink/specs/wireguard.yaml
+++ b/Documentation/netlink/specs/wireguard.yaml
@@ -21,34 +21,6 @@ definitions:
     name: key-len
     type: const
     value: 32
-  -
-    name-prefix: --wg-
-    name: inaddr-sz
-    type: const
-    doc: Equivalent of ``sizeof(struct in_addr)``.
-    header: linux/wireguard_params.h
-    value: 4
-  -
-    name-prefix: --wg-
-    name: sockaddr-sz
-    type: const
-    doc: Equivalent of ``sizeof(struct sockaddr)``.
-    header: linux/wireguard_params.h
-    value: 16
-  -
-    name-prefix: --wg-
-    name: timespec-sz
-    type: const
-    doc: Equivalent of ``sizeof(struct __kernel_timespec)``.
-    header: linux/wireguard_params.h
-    value: 16
-  -
-    name-prefix: --wg-
-    name: ifnamlen
-    type: const
-    doc: Equivalent of ``IFNAMSIZ - 1``.
-    header: linux/wireguard_params.h
-    value: 15
   -
     name: --kernel-timespec
     type: struct
@@ -103,7 +75,7 @@ attribute-sets:
         name: ifname
         type: string
         checks:
-          max-len: --wg-ifnamlen
+          max-len: 15
       -
         name: private-key
         type: binary
@@ -179,7 +151,7 @@ attribute-sets:
         doc: struct sockaddr_in or struct sockaddr_in6
         type: binary
         checks:
-          min-len: --wg-sockaddr-sz
+          min-len: 16
       -
         name: persistent-keepalive-interval
         type: u16
@@ -189,7 +161,7 @@ attribute-sets:
         type: binary
         struct: --kernel-timespec
         checks:
-          exact-len: --wg-timespec-sz
+          exact-len: 16
       -
         name: rx-bytes
         type: u64
@@ -226,7 +198,7 @@ attribute-sets:
         doc: struct in_addr or struct in6_add
         display-hint: ipv4-or-v6
         checks:
-          min-len: --wg-inaddr-sz
+          min-len: 4
       -
         name: cidr-mask
         type: u8
diff --git a/drivers/net/wireguard/netlink_gen.c b/drivers/net/wireguard/netlink_gen.c
index 75f5b4b297a9..f95fa133778f 100644
--- a/drivers/net/wireguard/netlink_gen.c
+++ b/drivers/net/wireguard/netlink_gen.c
@@ -9,13 +9,12 @@
 #include "netlink_gen.h"
 
 #include <uapi/linux/wireguard.h>
-#include <linux/wireguard_params.h>
 #include <linux/time_types.h>
 
 /* Common nested types */
 const struct nla_policy wireguard_wgallowedip_nl_policy[WGALLOWEDIP_A_FLAGS + 1] = {
 	[WGALLOWEDIP_A_FAMILY] = { .type = NLA_U16, },
-	[WGALLOWEDIP_A_IPADDR] = NLA_POLICY_MIN_LEN(__WG_INADDR_SZ),
+	[WGALLOWEDIP_A_IPADDR] = NLA_POLICY_MIN_LEN(4),
 	[WGALLOWEDIP_A_CIDR_MASK] = { .type = NLA_U8, },
 	[WGALLOWEDIP_A_FLAGS] = NLA_POLICY_MASK(NLA_U32, 0x1),
 };
@@ -24,9 +23,9 @@ const struct nla_policy wireguard_wgpeer_nl_policy[WGPEER_A_PROTOCOL_VERSION + 1
 	[WGPEER_A_PUBLIC_KEY] = NLA_POLICY_EXACT_LEN(WG_KEY_LEN),
 	[WGPEER_A_PRESHARED_KEY] = NLA_POLICY_EXACT_LEN(WG_KEY_LEN),
 	[WGPEER_A_FLAGS] = NLA_POLICY_MASK(NLA_U32, 0x7),
-	[WGPEER_A_ENDPOINT] = NLA_POLICY_MIN_LEN(__WG_SOCKADDR_SZ),
+	[WGPEER_A_ENDPOINT] = NLA_POLICY_MIN_LEN(16),
 	[WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL] = { .type = NLA_U16, },
-	[WGPEER_A_LAST_HANDSHAKE_TIME] = NLA_POLICY_EXACT_LEN(__WG_TIMESPEC_SZ),
+	[WGPEER_A_LAST_HANDSHAKE_TIME] = NLA_POLICY_EXACT_LEN(16),
 	[WGPEER_A_RX_BYTES] = { .type = NLA_U64, },
 	[WGPEER_A_TX_BYTES] = { .type = NLA_U64, },
 	[WGPEER_A_ALLOWEDIPS] = NLA_POLICY_NESTED_ARRAY(wireguard_wgallowedip_nl_policy),
@@ -36,7 +35,7 @@ const struct nla_policy wireguard_wgpeer_nl_policy[WGPEER_A_PROTOCOL_VERSION + 1
 /* WG_CMD_GET_DEVICE - dump */
 static const struct nla_policy wireguard_get_device_nl_policy[WGDEVICE_A_PEERS + 1] = {
 	[WGDEVICE_A_IFINDEX] = { .type = NLA_U32, },
-	[WGDEVICE_A_IFNAME] = { .type = NLA_NUL_STRING, .len = __WG_IFNAMLEN, },
+	[WGDEVICE_A_IFNAME] = { .type = NLA_NUL_STRING, .len = 15, },
 	[WGDEVICE_A_PRIVATE_KEY] = NLA_POLICY_EXACT_LEN(WG_KEY_LEN),
 	[WGDEVICE_A_PUBLIC_KEY] = NLA_POLICY_EXACT_LEN(WG_KEY_LEN),
 	[WGDEVICE_A_FLAGS] = NLA_POLICY_MASK(NLA_U32, 0x1),
@@ -48,7 +47,7 @@ static const struct nla_policy wireguard_get_device_nl_policy[WGDEVICE_A_PEERS +
 /* WG_CMD_SET_DEVICE - do */
 static const struct nla_policy wireguard_set_device_nl_policy[WGDEVICE_A_PEERS + 1] = {
 	[WGDEVICE_A_IFINDEX] = { .type = NLA_U32, },
-	[WGDEVICE_A_IFNAME] = { .type = NLA_NUL_STRING, .len = __WG_IFNAMLEN, },
+	[WGDEVICE_A_IFNAME] = { .type = NLA_NUL_STRING, .len = 15, },
 	[WGDEVICE_A_PRIVATE_KEY] = NLA_POLICY_EXACT_LEN(WG_KEY_LEN),
 	[WGDEVICE_A_PUBLIC_KEY] = NLA_POLICY_EXACT_LEN(WG_KEY_LEN),
 	[WGDEVICE_A_FLAGS] = NLA_POLICY_MASK(NLA_U32, 0x1),
diff --git a/drivers/net/wireguard/netlink_gen.h b/drivers/net/wireguard/netlink_gen.h
index a067ab0d61b6..e635b1f5f0df 100644
--- a/drivers/net/wireguard/netlink_gen.h
+++ b/drivers/net/wireguard/netlink_gen.h
@@ -10,7 +10,6 @@
 #include <net/genetlink.h>
 
 #include <uapi/linux/wireguard.h>
-#include <linux/wireguard_params.h>
 #include <linux/time_types.h>
 
 /* Common nested types */
diff --git a/include/uapi/linux/wireguard_params.h b/include/uapi/linux/wireguard_params.h
deleted file mode 100644
index c218e4b8042f..000000000000
--- a/include/uapi/linux/wireguard_params.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
-
-#ifndef _UAPI_LINUX_WIREGUARD_PARAMS_H
-#define _UAPI_LINUX_WIREGUARD_PARAMS_H
-
-#include <linux/time_types.h>
-#include <linux/if.h>
-#include <linux/in.h>
-
-/* These definitions are currently needed for definitions which can't
- * be expressed directly in Documentation/netlink/specs/wireguard.yaml
- */
-#define __WG_INADDR_SZ (sizeof(struct in_addr))
-#define __WG_SOCKADDR_SZ (sizeof(struct sockaddr))
-#define __WG_TIMESPEC_SZ (sizeof(struct __kernel_timespec))
-#define __WG_IFNAMLEN (IFNAMSIZ - 1)
-
-#endif /* _UAPI_LINUX_WIREGUARD_PARAMS_H */
-- 
2.51.0


