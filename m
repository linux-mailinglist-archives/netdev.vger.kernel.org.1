Return-Path: <netdev+bounces-234688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B07FDC262AF
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2118D46567F
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 16:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF5C32143F;
	Fri, 31 Oct 2025 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="UVso4s8T"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D1A2FBDEA;
	Fri, 31 Oct 2025 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926848; cv=none; b=uTEIF57Mic9pPPcY7huf5bt9WgFcE0iXPAUeNDgtBOLle7tT5iIln9X4bnWie7/+RqXqpTAC7l4yUc1ItcR1VmoSCI37twz29ZQ07uUH+KQmN+AFFiYo5D+n91h0jNHJ1vpWQUyVRwJWgU/4OP568xSwKK7nT2mygJsV0UiCoe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926848; c=relaxed/simple;
	bh=xY7lHq4ALfv0HJXzy0ZxMdbYjvTe3T0JRD2cTLBa4FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NIWScUI6emzfs/3FFUp4IaOlwxXVGHkPLYQ8kLaGVpiewgNUHLbbDc7oxZYJSdYKGAU29Zam5RTIaeyaKKPtFOgbr0nJYRmCytx0tbpRb+ftULSZACWLHd4cZdR+GH21ezO1iKGu5snu7CKhzCuT5aqnioFiqQZzZ514vTueZlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=UVso4s8T; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1761926832;
	bh=xY7lHq4ALfv0HJXzy0ZxMdbYjvTe3T0JRD2cTLBa4FI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UVso4s8TZXsGDbfy5IWZUgdOozEQF9pcbRLozQo96fJteSWEBPfXlDRUgtgkQB9bb
	 DeXffgcvpF2pHrzGkAQj1HkKIUM5mtKxi8eLdfmwgRNYlsTMF9LboCzxEfQ1B0RbUh
	 dQcmEYjxd1szhV5wXHwogrY1eSE7fn5jTDC3ZJw5PzjJSQsfW1H8Ada0xn4MQPSKLo
	 Yqe0Y3unWEIjNSkeHHdkg3M6hYvScJjCdfgP7w9u03OOeQ5n0+8vCqDtmmY5o2MjZ3
	 q+2/xDr3+fM7DYpszK+L8e4T4dl8m8Vehw8AeY76i9uip2xGfXCQTd/q677kgy8+Gt
	 sdwqRaWR8Fv4Q==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 454D260113;
	Fri, 31 Oct 2025 16:07:12 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 7B858205025; Fri, 31 Oct 2025 16:05:45 +0000 (UTC)
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
Subject: [PATCH net-next v2 07/11] uapi: wireguard: generate header with ynl-gen
Date: Fri, 31 Oct 2025 16:05:33 +0000
Message-ID: <20251031160539.1701943-8-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031160539.1701943-1-ast@fiberby.net>
References: <20251031160539.1701943-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use ynl-gen to generate the UAPI header for wireguard.

The cosmetic changes in this patch, confirms that the spec is aligned
with the implementation, and ensures that it stays in sync.

Changes in generated header:
* Trivial include guard rename.
* Trivial white space changes.
* Trivial comment changes.
* Precompute bitflags in ynl-gen (see [1]).
* Drop __*_F_ALL constants (see [1]).

[1] https://lore.kernel.org/r/20251014123201.6ecfd146@kernel.org/

No behavioural changes intended.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/wireguard/netlink.c |  6 +++---
 include/uapi/linux/wireguard.h  | 37 ++++++++++++++++-----------------
 2 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
index 682678d24a9f..f9bed135000f 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -26,7 +26,7 @@ static const struct nla_policy device_policy[WGDEVICE_A_MAX + 1] = {
 	[WGDEVICE_A_IFNAME]		= { .type = NLA_NUL_STRING, .len = IFNAMSIZ - 1 },
 	[WGDEVICE_A_PRIVATE_KEY]	= NLA_POLICY_EXACT_LEN(WG_KEY_LEN),
 	[WGDEVICE_A_PUBLIC_KEY]		= NLA_POLICY_EXACT_LEN(WG_KEY_LEN),
-	[WGDEVICE_A_FLAGS]		= NLA_POLICY_MASK(NLA_U32, __WGDEVICE_F_ALL),
+	[WGDEVICE_A_FLAGS]		= NLA_POLICY_MASK(NLA_U32, 0x1),
 	[WGDEVICE_A_LISTEN_PORT]	= { .type = NLA_U16 },
 	[WGDEVICE_A_FWMARK]		= { .type = NLA_U32 },
 	[WGDEVICE_A_PEERS]		= NLA_POLICY_NESTED_ARRAY(peer_policy),
@@ -35,7 +35,7 @@ static const struct nla_policy device_policy[WGDEVICE_A_MAX + 1] = {
 static const struct nla_policy peer_policy[WGPEER_A_MAX + 1] = {
 	[WGPEER_A_PUBLIC_KEY]				= NLA_POLICY_EXACT_LEN(WG_KEY_LEN),
 	[WGPEER_A_PRESHARED_KEY]			= NLA_POLICY_EXACT_LEN(WG_KEY_LEN),
-	[WGPEER_A_FLAGS]				= NLA_POLICY_MASK(NLA_U32, __WGPEER_F_ALL),
+	[WGPEER_A_FLAGS]				= NLA_POLICY_MASK(NLA_U32, 0x7),
 	[WGPEER_A_ENDPOINT]				= NLA_POLICY_MIN_LEN(sizeof(struct sockaddr)),
 	[WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL]	= { .type = NLA_U16 },
 	[WGPEER_A_LAST_HANDSHAKE_TIME]			= NLA_POLICY_EXACT_LEN(sizeof(struct __kernel_timespec)),
@@ -49,7 +49,7 @@ static const struct nla_policy allowedip_policy[WGALLOWEDIP_A_MAX + 1] = {
 	[WGALLOWEDIP_A_FAMILY]		= { .type = NLA_U16 },
 	[WGALLOWEDIP_A_IPADDR]		= NLA_POLICY_MIN_LEN(sizeof(struct in_addr)),
 	[WGALLOWEDIP_A_CIDR_MASK]	= { .type = NLA_U8 },
-	[WGALLOWEDIP_A_FLAGS]		= NLA_POLICY_MASK(NLA_U32, __WGALLOWEDIP_F_ALL),
+	[WGALLOWEDIP_A_FLAGS]		= NLA_POLICY_MASK(NLA_U32, 0x1),
 };
 
 static struct wg_device *lookup_interface(struct nlattr **attrs,
diff --git a/include/uapi/linux/wireguard.h b/include/uapi/linux/wireguard.h
index a2815f4f2910..dc3924d0c552 100644
--- a/include/uapi/linux/wireguard.h
+++ b/include/uapi/linux/wireguard.h
@@ -1,32 +1,28 @@
-/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR MIT */
-/*
- * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
- */
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/wireguard.yaml */
+/* YNL-GEN uapi header */
 
-#ifndef _WG_UAPI_WIREGUARD_H
-#define _WG_UAPI_WIREGUARD_H
+#ifndef _UAPI_LINUX_WIREGUARD_H
+#define _UAPI_LINUX_WIREGUARD_H
 
-#define WG_GENL_NAME "wireguard"
-#define WG_GENL_VERSION 1
+#define WG_GENL_NAME	"wireguard"
+#define WG_GENL_VERSION	1
 
-#define WG_KEY_LEN 32
+#define WG_KEY_LEN	32
 
 enum wgdevice_flag {
-	WGDEVICE_F_REPLACE_PEERS = 1U << 0,
-	__WGDEVICE_F_ALL = WGDEVICE_F_REPLACE_PEERS
+	WGDEVICE_F_REPLACE_PEERS = 1,
 };
 
 enum wgpeer_flag {
-	WGPEER_F_REMOVE_ME = 1U << 0,
-	WGPEER_F_REPLACE_ALLOWEDIPS = 1U << 1,
-	WGPEER_F_UPDATE_ONLY = 1U << 2,
-	__WGPEER_F_ALL = WGPEER_F_REMOVE_ME | WGPEER_F_REPLACE_ALLOWEDIPS |
-			 WGPEER_F_UPDATE_ONLY
+	WGPEER_F_REMOVE_ME = 1,
+	WGPEER_F_REPLACE_ALLOWEDIPS = 2,
+	WGPEER_F_UPDATE_ONLY = 4,
 };
 
 enum wgallowedip_flag {
-	WGALLOWEDIP_F_REMOVE_ME = 1U << 0,
-	__WGALLOWEDIP_F_ALL = WGALLOWEDIP_F_REMOVE_ME
+	WGALLOWEDIP_F_REMOVE_ME = 1,
 };
 
 enum wgdevice_attribute {
@@ -39,6 +35,7 @@ enum wgdevice_attribute {
 	WGDEVICE_A_LISTEN_PORT,
 	WGDEVICE_A_FWMARK,
 	WGDEVICE_A_PEERS,
+
 	__WGDEVICE_A_LAST
 };
 #define WGDEVICE_A_MAX (__WGDEVICE_A_LAST - 1)
@@ -55,6 +52,7 @@ enum wgpeer_attribute {
 	WGPEER_A_TX_BYTES,
 	WGPEER_A_ALLOWEDIPS,
 	WGPEER_A_PROTOCOL_VERSION,
+
 	__WGPEER_A_LAST
 };
 #define WGPEER_A_MAX (__WGPEER_A_LAST - 1)
@@ -65,6 +63,7 @@ enum wgallowedip_attribute {
 	WGALLOWEDIP_A_IPADDR,
 	WGALLOWEDIP_A_CIDR_MASK,
 	WGALLOWEDIP_A_FLAGS,
+
 	__WGALLOWEDIP_A_LAST
 };
 #define WGALLOWEDIP_A_MAX (__WGALLOWEDIP_A_LAST - 1)
@@ -77,4 +76,4 @@ enum wg_cmd {
 };
 #define WG_CMD_MAX (__WG_CMD_MAX - 1)
 
-#endif /* _WG_UAPI_WIREGUARD_H */
+#endif /* _UAPI_LINUX_WIREGUARD_H */
-- 
2.51.0


