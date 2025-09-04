Return-Path: <netdev+bounces-220144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4240DB4490C
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 00:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829781CC2387
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 22:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA582E3AE6;
	Thu,  4 Sep 2025 22:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="cMBpPhoM"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ECA2DE6FC;
	Thu,  4 Sep 2025 22:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757023410; cv=none; b=LTmzEukFwookbfN21/fWWIY6DJqHKUTBmR592K25Q5iHTNfIX8MnJYFm1nYRYu/1SmZQ60rW2q4DeuuaufHIQzWz3Jx9lohSZa9W3x/FtEx2aHV4VQFXV49r1S9aCkOeRDzehAeO2QMITIdUdTUMMeEsRHVNkGwRbjUQf290xF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757023410; c=relaxed/simple;
	bh=04RmY4dERnT2T8QvjCbEKW4QZvKlQz3IonhiKvd3MHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LaIQWL8K6IMOxyJ34r8tAg+KdzSsXRXf7ZofLFxJTUUq2m1DXg7JyuYL4jgkd7GbsM3LjY6y9oR8KXNnXSBL6d99gkiaEeGfth/KkuMeayXWDvUc1PqNcWOkeHZ5HQZQoVxf0BN+jgwiomMGQPak/qCpS2rWIyOUa77tg54CQTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=cMBpPhoM; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757023398;
	bh=04RmY4dERnT2T8QvjCbEKW4QZvKlQz3IonhiKvd3MHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cMBpPhoMmMrLIR9vCa1n8bJB+MKbrnRVkNp1CFGsyquH0uI3Ig0DjuFiCqm32v5JY
	 Aig9+6NjCETruljoyP1DiWl68gGZkKmxpp7GAnx3meN6PrFX01L1zG2yO1uJb5Et5m
	 r/x5lNw5CeY6RNFlJHVKOToFh4h90knOe/+aOHcuTUsQ4g0bjiewKK0MzOaUaVkSAd
	 PBYL88Uvkmo0sYLnXb1vYQw8VN+dMkRkwZSDfDzbi5PW+BZSAMAr1Npz/8ge/oIM62
	 GcMaV/ZSR/xxgqMW7FE2DbAJUiPzvq5gef9lxwHlNajGtUyO2VMKW7ptTtqQBzb/nT
	 XjVPato148qiw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 71C4F6013D;
	Thu,  4 Sep 2025 22:03:18 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 42E82202863; Thu, 04 Sep 2025 22:02:58 +0000 (UTC)
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
Subject: [RFC net-next 01/14] wireguard: netlink: use WG_KEY_LEN in policies
Date: Thu,  4 Sep 2025 22:02:35 +0000
Message-ID: <20250904220255.1006675-1-ast@fiberby.net>
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

When converting the netlink policies to YNL, then the constants
used in the policy has to be visible to user-space.

As NOISE_*_KEY_LEN isn't visible for userspace, then change to
use WG_KEY_LEN, as is also documented in the UAPI header:

$ grep WG_KEY_LEN include/uapi/linux/wireguard.h
 *    WGDEVICE_A_PRIVATE_KEY: NLA_EXACT_LEN, len WG_KEY_LEN
 *    WGDEVICE_A_PUBLIC_KEY: NLA_EXACT_LEN, len WG_KEY_LEN
 *            WGPEER_A_PUBLIC_KEY: NLA_EXACT_LEN, len WG_KEY_LEN
 *            WGPEER_A_PRESHARED_KEY: NLA_EXACT_LEN, len WG_KEY_LEN
 [...]

Add a couple of BUILD_BUG_ON() to ensure that they stay in sync.

No behavioural changes intended.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/wireguard/netlink.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
index 67f962eb8b46..086edd4bb33b 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -22,8 +22,8 @@ static struct genl_family genl_family;
 static const struct nla_policy device_policy[WGDEVICE_A_MAX + 1] = {
 	[WGDEVICE_A_IFINDEX]		= { .type = NLA_U32 },
 	[WGDEVICE_A_IFNAME]		= { .type = NLA_NUL_STRING, .len = IFNAMSIZ - 1 },
-	[WGDEVICE_A_PRIVATE_KEY]	= NLA_POLICY_EXACT_LEN(NOISE_PUBLIC_KEY_LEN),
-	[WGDEVICE_A_PUBLIC_KEY]		= NLA_POLICY_EXACT_LEN(NOISE_PUBLIC_KEY_LEN),
+	[WGDEVICE_A_PRIVATE_KEY]	= NLA_POLICY_EXACT_LEN(WG_KEY_LEN),
+	[WGDEVICE_A_PUBLIC_KEY]		= NLA_POLICY_EXACT_LEN(WG_KEY_LEN),
 	[WGDEVICE_A_FLAGS]		= NLA_POLICY_MASK(NLA_U32, __WGDEVICE_F_ALL),
 	[WGDEVICE_A_LISTEN_PORT]	= { .type = NLA_U16 },
 	[WGDEVICE_A_FWMARK]		= { .type = NLA_U32 },
@@ -31,8 +31,8 @@ static const struct nla_policy device_policy[WGDEVICE_A_MAX + 1] = {
 };
 
 static const struct nla_policy peer_policy[WGPEER_A_MAX + 1] = {
-	[WGPEER_A_PUBLIC_KEY]				= NLA_POLICY_EXACT_LEN(NOISE_PUBLIC_KEY_LEN),
-	[WGPEER_A_PRESHARED_KEY]			= NLA_POLICY_EXACT_LEN(NOISE_SYMMETRIC_KEY_LEN),
+	[WGPEER_A_PUBLIC_KEY]				= NLA_POLICY_EXACT_LEN(WG_KEY_LEN),
+	[WGPEER_A_PRESHARED_KEY]			= NLA_POLICY_EXACT_LEN(WG_KEY_LEN),
 	[WGPEER_A_FLAGS]				= NLA_POLICY_MASK(NLA_U32, __WGPEER_F_ALL),
 	[WGPEER_A_ENDPOINT]				= NLA_POLICY_MIN_LEN(sizeof(struct sockaddr)),
 	[WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL]	= { .type = NLA_U16 },
@@ -642,6 +642,9 @@ static struct genl_family genl_family __ro_after_init = {
 
 int __init wg_genetlink_init(void)
 {
+	BUILD_BUG_ON(WG_KEY_LEN != NOISE_PUBLIC_KEY_LEN);
+	BUILD_BUG_ON(WG_KEY_LEN != NOISE_SYMMETRIC_KEY_LEN);
+
 	return genl_register_family(&genl_family);
 }
 
-- 
2.51.0


