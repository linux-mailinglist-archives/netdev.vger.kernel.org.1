Return-Path: <netdev+bounces-235944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9B8C37583
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 19:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107BA3BD109
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 18:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF5133CE8D;
	Wed,  5 Nov 2025 18:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="pRPVYGk3"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16623148A7;
	Wed,  5 Nov 2025 18:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367586; cv=none; b=t2P/a76M5JRhdRxrJqTOvDYFGETavYfUqIfkTFn0Zl97p2/nDl7+jW3y9n6VDbD+2gjdJeoarZwTWvlAp+0WEcDtg1BgN6qB7ZANFj0ecbPDudB9T1bH50czBv81bnpjMfrnHI9xLthqlxrAQZ3lRmHeV+0RduOlRXwU7o8jy08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367586; c=relaxed/simple;
	bh=V1qpp0ij75kE1ods7p/ksE4mY2gQykj4G8kFXbDQACs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJ/NiO8oB8FeqERTDZPxvWGxaZxXaC53q7kN1Ee2lcYER0VLJa96McJPVjDeOhC9bLliKsn9B9k/oS2t9/eWfKiqW41/CljIA/XGvd9odcPosphd30n7KqjvQdr/aVmPWaw76CyXsthC/1JDpVlT17+pAh4rUG+WO5eWZc9xrIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=pRPVYGk3; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1762367571;
	bh=V1qpp0ij75kE1ods7p/ksE4mY2gQykj4G8kFXbDQACs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pRPVYGk3mjM00Wv4+0TgHbL8U+STKrYUw+dB884kcjD79IlpUQ52IzTYbKexFexil
	 Ip8nyjq/g+bmYpO7xvio+EZRa2YfNSG9gV6U4sG87m4qs0YeKGjLODDzktkLXm0a6p
	 MqujphqKWD8g/4mZWSI4PAODYWp1Wb6UgEWGZlZAsAmTQ5nYWB+ToagCBqwYpFjHVz
	 4e3GoYUNZp08d04sFdNHEqBxWdn/9DU2JeHzkxjQcbMQGcl43AIpqMXWs/tRu9z49N
	 16rSSGyZeoJah7r00Z6cl/NAUJLIZIpYsSJOibV6GIb6UVpBxfxcbOs8GQ6nbTahqL
	 UV7FdOWU4HUZA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id EBB9760109;
	Wed,  5 Nov 2025 18:32:50 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 239852050B6; Wed, 05 Nov 2025 18:32:25 +0000 (UTC)
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
	linux-kernel@vger.kernel.org,
	Jordan Rife <jordan@jrife.io>
Subject: [PATCH net-next v3 02/11] wireguard: netlink: use WG_KEY_LEN in policies
Date: Wed,  5 Nov 2025 18:32:11 +0000
Message-ID: <20251105183223.89913-3-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105183223.89913-1-ast@fiberby.net>
References: <20251105183223.89913-1-ast@fiberby.net>
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

As NOISE_*_KEY_LEN isn't visible for userspace, then change the
policy to use WG_KEY_LEN, as is also documented in the UAPI header:

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
index e4416f23d427..db57a74d379b 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -24,8 +24,8 @@ static const struct nla_policy allowedip_policy[WGALLOWEDIP_A_MAX + 1];
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
@@ -33,8 +33,8 @@ static const struct nla_policy device_policy[WGDEVICE_A_MAX + 1] = {
 };
 
 static const struct nla_policy peer_policy[WGPEER_A_MAX + 1] = {
-	[WGPEER_A_PUBLIC_KEY]				= NLA_POLICY_EXACT_LEN(NOISE_PUBLIC_KEY_LEN),
-	[WGPEER_A_PRESHARED_KEY]			= NLA_POLICY_EXACT_LEN(NOISE_SYMMETRIC_KEY_LEN),
+	[WGPEER_A_PUBLIC_KEY]				= NLA_POLICY_EXACT_LEN(WG_KEY_LEN),
+	[WGPEER_A_PRESHARED_KEY]			= NLA_POLICY_EXACT_LEN(WG_KEY_LEN),
 	[WGPEER_A_FLAGS]				= NLA_POLICY_MASK(NLA_U32, __WGPEER_F_ALL),
 	[WGPEER_A_ENDPOINT]				= NLA_POLICY_MIN_LEN(sizeof(struct sockaddr)),
 	[WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL]	= { .type = NLA_U16 },
@@ -644,6 +644,9 @@ static struct genl_family genl_family __ro_after_init = {
 
 int __init wg_genetlink_init(void)
 {
+	BUILD_BUG_ON(WG_KEY_LEN != NOISE_PUBLIC_KEY_LEN);
+	BUILD_BUG_ON(WG_KEY_LEN != NOISE_SYMMETRIC_KEY_LEN);
+
 	return genl_register_family(&genl_family);
 }
 
-- 
2.51.0


