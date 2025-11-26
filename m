Return-Path: <netdev+bounces-241971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A49C8B37A
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 18:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8214835999D
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 17:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19D030E0F2;
	Wed, 26 Nov 2025 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="vXQc6vBD"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EB52F6176;
	Wed, 26 Nov 2025 17:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764178597; cv=none; b=jX380wd7PBG1pQQyTHw+Eoeg1HgIrz9YwHKuccJ+ogFENVdRc+UARKRJXGNdisxShN5OZNd7VDXciTpsVVQKTqdqWR3lsBHaklpc1hR/PMw5b+7SqItO80uKmWqqzeWKwOO5fHIu/voBLCxHUtxutFec/oGQOIxEautvZC0nUM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764178597; c=relaxed/simple;
	bh=SaV6BBxIJUjAqywZ751BYca02xEI+1BIJYJbX/fknmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EqNsM2ielzWqRLcKu1pVz9K3z/BXi7Tkw7hIhuhJPPTpIJvVPx08WYGovqxkAWQ9wJ4zspCuU/Xv+gXiIaEARwZUyEta6Jr1FRIwNe+lQhFbW6NX6Lj4wQC6iCMzVggKs3suhPrDDtsT/V4yryBRTivBOhQ0ZrVWQdsGejaCXRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=vXQc6vBD; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1764178585;
	bh=SaV6BBxIJUjAqywZ751BYca02xEI+1BIJYJbX/fknmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vXQc6vBD07bHLs7l4jt6QzlH7Wp4UVyZlivLHJNiuFoUItT75EwNcArXblYL6o4jL
	 X/c0zeIhl9IoeVGleBU0QBKHxQiPhwYOYduyeGciMt30s1usfm9p/Ewi4gbpYmRfdv
	 azlnW1k00ILEfVQjpAW/h/qPZylH83cZt3kLOYU24iQpmmOQDxxm8tWH7ha9PpA++8
	 4t32bvr6XurfAvLsNblh2RocHXko5uPPDpQD+KMSGi4KT2o1oPGamoGBs3kQUkwjAJ
	 CI2k60gmjx2k/4tfnitRz5L9k76zdLzpkH6v7cZl7+J913ZjdmcXmdFIQDAu5TImBm
	 Our7j2XYnqnvw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 561E260104;
	Wed, 26 Nov 2025 17:36:24 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 0B27B20221A; Wed, 26 Nov 2025 17:35:50 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jordan Rife <jordan@jrife.io>
Subject: [PATCH wireguard v4 02/10] wireguard: netlink: use WG_KEY_LEN in policies
Date: Wed, 26 Nov 2025 17:35:34 +0000
Message-ID: <20251126173546.57681-3-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126173546.57681-1-ast@fiberby.net>
References: <20251126173546.57681-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When converting the netlink policies to YNL, the constants used
in the policy have to be visible to userspace.

As NOISE_*_KEY_LEN isn't visible to userspace, change the policy
to use WG_KEY_LEN, as also documented in the UAPI header:

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
index 97723f9c7998f..682678d24a9f6 100644
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
@@ -643,6 +643,9 @@ static struct genl_family genl_family __ro_after_init = {
 
 int __init wg_genetlink_init(void)
 {
+	BUILD_BUG_ON(WG_KEY_LEN != NOISE_PUBLIC_KEY_LEN);
+	BUILD_BUG_ON(WG_KEY_LEN != NOISE_SYMMETRIC_KEY_LEN);
+
 	return genl_register_family(&genl_family);
 }
 
-- 
2.51.0


