Return-Path: <netdev+bounces-192455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9FBABFEED
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 23:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E971BC6416
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 21:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C66D2BD58E;
	Wed, 21 May 2025 21:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ii/df2M8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662EE2BCF7E
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 21:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747862846; cv=none; b=dAYEPN6CPzay4e3dLIvmFfaNDymnviyuc5kHCuTGHrqSqUX1imQxDvmWQIRP54VrR8vYeOttG47OvfDE/Bz1pETTwi5FWMQPmavxuV/KRaFRxIETKGAxQ7CIfJsruUR1XJ2X3cWmDhjbVk3gSxHCCqJiTL59w9nNUUOce/Et8mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747862846; c=relaxed/simple;
	bh=aA7uAltoFNCGWpHMWiIuT/GOdC9paI3Z11VYO4Y9x04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhUm5S5owqcCBLhgPYPbZZrX0ecrIfAUn6fLPvfU1SzS46IllMehwiPflTXCwObt0OXFnmCJImm/kllJu4AwDsoIzaBKE0WFbOyjVawbDhpc2ErhAcHRHaOuIIBTGGtR9NincRboJ6lTf8kY9OQymhqwoHrTmSKk9qRV+zbDUxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=ii/df2M8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DAEC4CEE4;
	Wed, 21 May 2025 21:27:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ii/df2M8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1747862844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V5iQtrfFrXx8yIlGkOD57Pv8EsvHmX1OeCv9sb58eyc=;
	b=ii/df2M8+75RNeUjimFM5NPeXHbGE20CkLTquYk5YJCFAcrSme5t80tTZ5sq772i2E9UYp
	kdx/22QTZAdiYt6v70DnENJ2mebFXfKKywDbVTjs+iIoZu2CgIGgwUbk2MQiAm5jTJZ7O3
	tiQ3G1bUQMsv8N+EC+nQNjClXHyH1B8=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2a0c9ab4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 May 2025 21:27:24 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next 3/5] wireguard: netlink: use NLA_POLICY_MASK where possible
Date: Wed, 21 May 2025 23:27:05 +0200
Message-ID: <20250521212707.1767879-4-Jason@zx2c4.com>
In-Reply-To: <20250521212707.1767879-1-Jason@zx2c4.com>
References: <20250521212707.1767879-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than manually validating flags against the various __ALL_*
constants, put this in the netlink policy description and have the upper
layer machinery check it for us.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/net/wireguard/netlink.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
index f7055180ba4a..bbb1a7fe1c57 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -24,7 +24,7 @@ static const struct nla_policy device_policy[WGDEVICE_A_MAX + 1] = {
 	[WGDEVICE_A_IFNAME]		= { .type = NLA_NUL_STRING, .len = IFNAMSIZ - 1 },
 	[WGDEVICE_A_PRIVATE_KEY]	= NLA_POLICY_EXACT_LEN(NOISE_PUBLIC_KEY_LEN),
 	[WGDEVICE_A_PUBLIC_KEY]		= NLA_POLICY_EXACT_LEN(NOISE_PUBLIC_KEY_LEN),
-	[WGDEVICE_A_FLAGS]		= { .type = NLA_U32 },
+	[WGDEVICE_A_FLAGS]		= NLA_POLICY_MASK(NLA_U32, __WGDEVICE_F_ALL),
 	[WGDEVICE_A_LISTEN_PORT]	= { .type = NLA_U16 },
 	[WGDEVICE_A_FWMARK]		= { .type = NLA_U32 },
 	[WGDEVICE_A_PEERS]		= { .type = NLA_NESTED }
@@ -33,7 +33,7 @@ static const struct nla_policy device_policy[WGDEVICE_A_MAX + 1] = {
 static const struct nla_policy peer_policy[WGPEER_A_MAX + 1] = {
 	[WGPEER_A_PUBLIC_KEY]				= NLA_POLICY_EXACT_LEN(NOISE_PUBLIC_KEY_LEN),
 	[WGPEER_A_PRESHARED_KEY]			= NLA_POLICY_EXACT_LEN(NOISE_SYMMETRIC_KEY_LEN),
-	[WGPEER_A_FLAGS]				= { .type = NLA_U32 },
+	[WGPEER_A_FLAGS]				= NLA_POLICY_MASK(NLA_U32, __WGPEER_F_ALL),
 	[WGPEER_A_ENDPOINT]				= NLA_POLICY_MIN_LEN(sizeof(struct sockaddr)),
 	[WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL]	= { .type = NLA_U16 },
 	[WGPEER_A_LAST_HANDSHAKE_TIME]			= NLA_POLICY_EXACT_LEN(sizeof(struct __kernel_timespec)),
@@ -373,9 +373,6 @@ static int set_peer(struct wg_device *wg, struct nlattr **attrs)
 
 	if (attrs[WGPEER_A_FLAGS])
 		flags = nla_get_u32(attrs[WGPEER_A_FLAGS]);
-	ret = -EOPNOTSUPP;
-	if (flags & ~__WGPEER_F_ALL)
-		goto out;
 
 	ret = -EPFNOSUPPORT;
 	if (attrs[WGPEER_A_PROTOCOL_VERSION]) {
@@ -506,9 +503,6 @@ static int wg_set_device(struct sk_buff *skb, struct genl_info *info)
 
 	if (info->attrs[WGDEVICE_A_FLAGS])
 		flags = nla_get_u32(info->attrs[WGDEVICE_A_FLAGS]);
-	ret = -EOPNOTSUPP;
-	if (flags & ~__WGDEVICE_F_ALL)
-		goto out;
 
 	if (info->attrs[WGDEVICE_A_LISTEN_PORT] || info->attrs[WGDEVICE_A_FWMARK]) {
 		struct net *net;
-- 
2.48.1


