Return-Path: <netdev+bounces-242875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B54CFC95967
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 03:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8B54C342843
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 02:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564B11DF759;
	Mon,  1 Dec 2025 02:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Nzes/JEX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C501DF755
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 02:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764556153; cv=none; b=JlZtQqScomX/QFbZ0vxMeKmL1L9bYSEfUdgvmSU38BuPbmseVg7N49tvtje9D2v/ghP+lgWchd4OVxRDN4UahtT9HeHZc6/dNlLO1VGOglZM0xJmONRsQf9OP9mN5uJ7Y9DE96I01L+8a4OG/ZFt2Ejx6ItxDjOqvPcjREY5RBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764556153; c=relaxed/simple;
	bh=VXxLH8uSoy4ymfPDL5D6cWWk6hTU/3ckmnHrVkzSD9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e5947OZqd7nrWkJnVns0dJ0OmbRsaebRq774yTHh/tM6nJwTdT/qSdZpDz3oxD7Vnp092DEqednmLSNKXrZ2wdXHPO7qDtbtF+Zqe3FnyE/WAqt5LwfEW3D6flFCOsc77MIrwokHCsx5booscwSgejj2fsEYAg6AFBgLFM5u5zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Nzes/JEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC15C4CEFB;
	Mon,  1 Dec 2025 02:29:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Nzes/JEX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1764556151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dzHEicW2E3zPwXA93tnINYuL1R5hI+5SdgLrnKOw+Yw=;
	b=Nzes/JEXH7mkGlzVOVF6muZpegcZbQOesWCVACYjO4GbjLW/XkApif7QQffmhG5TUU2QHQ
	M6uLt2NO+eELlhXdNJXqzcrsCoTVnbACShxOXmisPpssIDbuLNOXRW7HvsZOZmSrSX/LHD
	H+9raDoSUoGH/7HpvuC+Mjs+rl5De2Q=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d6a2e67b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Dec 2025 02:29:11 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next 09/11] wireguard: uapi: generate header with ynl-gen
Date: Mon,  1 Dec 2025 03:28:47 +0100
Message-ID: <20251201022849.418666-10-Jason@zx2c4.com>
In-Reply-To: <20251201022849.418666-1-Jason@zx2c4.com>
References: <20251201022849.418666-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Use ynl-gen to generate the UAPI header for WireGuard.

The cosmetic changes in this patch confirms that the spec is aligned
with the implementation. By using the generated version, it ensures
that they stay in sync.

Changes in the generated header:
* Trivial header guard rename.
* Trivial white space changes.
* Trivial comment changes.
* Precompute bitflags in ynl-gen (see [1]).
* Drop __*_F_ALL constants (see [1]).

[1] https://lore.kernel.org/r/20251014123201.6ecfd146@kernel.org/

No behavioural changes intended.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/net/wireguard/netlink.c |  6 +++---
 include/uapi/linux/wireguard.h  | 38 ++++++++++++++++-----------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
index c2d0576e96f5..0ce0bda8c1ce 100644
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
index a2815f4f2910..a100b9715b08 100644
--- a/include/uapi/linux/wireguard.h
+++ b/include/uapi/linux/wireguard.h
@@ -1,32 +1,29 @@
-/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR MIT */
-/*
- * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
- */
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/wireguard.yaml */
+/* YNL-GEN uapi header */
+/* To regenerate run: tools/net/ynl/ynl-regen.sh */
 
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
@@ -39,6 +36,7 @@ enum wgdevice_attribute {
 	WGDEVICE_A_LISTEN_PORT,
 	WGDEVICE_A_FWMARK,
 	WGDEVICE_A_PEERS,
+
 	__WGDEVICE_A_LAST
 };
 #define WGDEVICE_A_MAX (__WGDEVICE_A_LAST - 1)
@@ -55,6 +53,7 @@ enum wgpeer_attribute {
 	WGPEER_A_TX_BYTES,
 	WGPEER_A_ALLOWEDIPS,
 	WGPEER_A_PROTOCOL_VERSION,
+
 	__WGPEER_A_LAST
 };
 #define WGPEER_A_MAX (__WGPEER_A_LAST - 1)
@@ -65,6 +64,7 @@ enum wgallowedip_attribute {
 	WGALLOWEDIP_A_IPADDR,
 	WGALLOWEDIP_A_CIDR_MASK,
 	WGALLOWEDIP_A_FLAGS,
+
 	__WGALLOWEDIP_A_LAST
 };
 #define WGALLOWEDIP_A_MAX (__WGALLOWEDIP_A_LAST - 1)
@@ -77,4 +77,4 @@ enum wg_cmd {
 };
 #define WG_CMD_MAX (__WG_CMD_MAX - 1)
 
-#endif /* _WG_UAPI_WIREGUARD_H */
+#endif /* _UAPI_LINUX_WIREGUARD_H */
-- 
2.52.0


