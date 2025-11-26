Return-Path: <netdev+bounces-241968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39332C8B371
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 18:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC43F3A6261
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 17:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80B13090FB;
	Wed, 26 Nov 2025 17:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Jspc79MS"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD074219A81;
	Wed, 26 Nov 2025 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764178596; cv=none; b=ePS4hVlvizrfXwcenK0Wo0MTtqHZsX+qR80AUf2JLzbIhKW8+kV1aazIsl+7GZRZj64jzrRk2E71HMB6aINwqGovSlzzh9DQsBG8W6bf0JrqP8lt5TuEMx3dALyOoOqYIgEMk8JuBMa+5bfF97PaYjlwzD+zHXhFWuyww35+78s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764178596; c=relaxed/simple;
	bh=nwU6U0G5mFVcepPTOD04SnQVVqzdXO0qsNCZo14VYXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+9SF9/doW2jPcS0Nv8NTD3w2ek3xfvtGMvRhqug/7mcCvDutnK3WBAtpETkt9dTto8/Yee980+OEw2kQp8O03nMq67MOQofDf1Z0I+GYi712+p0B/9DNSv0PwY8lAEe0DM2gafIG4uaFC66VgrPk0p5Rc+H4K5b36dL2HeKjxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Jspc79MS; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1764178585;
	bh=nwU6U0G5mFVcepPTOD04SnQVVqzdXO0qsNCZo14VYXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jspc79MStzMUv/56FaHkwfTDjkyBBSeOvGGCTXdPTXmPRHu8Uzk4UENwyz+LSZJ1U
	 diHJJmF0Tg/pO8ZiWz2dR5EMZONIBFabEVuSdPd+T7r0TSNVMchxEoiKo8HMKvQog3
	 p89rKTSDq7yApZYyltIynQyqyeYZ0UA2WLOkngFFlO34eOm6jkrGsVsSpZyP1asdnl
	 O49dWsFyqpE1P4VvXJfAjzn9B3hyAtT8JB8iY0C4mYR2qR2W9NT8a+gS8BxlKQqSER
	 ebcJBe1f/Up3uIxRV/jWrUqkMw0Gke0CAY9bjxT7HnviKeO3x0ySF35HGX9OwU31eG
	 4gBvGrm1NfOIA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 58BD960107;
	Wed, 26 Nov 2025 17:36:25 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 8AF5220219A; Wed, 26 Nov 2025 17:35:49 +0000 (UTC)
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
Subject: [PATCH wireguard v4 01/10] wireguard: netlink: validate nested arrays in policy
Date: Wed, 26 Nov 2025 17:35:33 +0000
Message-ID: <20251126173546.57681-2-ast@fiberby.net>
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

Use NLA_POLICY_NESTED_ARRAY() to perform nested array validation
in the policy validation step.

The nested policy was already enforced through nla_parse_nested(),
however extack wasn't passed previously, so no fancy error messages.

With the nested attributes being validated directly in the policy, the
policy argument can be set to NULL in the calls to nla_parse_nested().

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/wireguard/netlink.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
index 8adeec6f94404..97723f9c7998f 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -18,6 +18,8 @@
 #include <crypto/utils.h>
 
 static struct genl_family genl_family;
+static const struct nla_policy peer_policy[WGPEER_A_MAX + 1];
+static const struct nla_policy allowedip_policy[WGALLOWEDIP_A_MAX + 1];
 
 static const struct nla_policy device_policy[WGDEVICE_A_MAX + 1] = {
 	[WGDEVICE_A_IFINDEX]		= { .type = NLA_U32 },
@@ -27,7 +29,7 @@ static const struct nla_policy device_policy[WGDEVICE_A_MAX + 1] = {
 	[WGDEVICE_A_FLAGS]		= NLA_POLICY_MASK(NLA_U32, __WGDEVICE_F_ALL),
 	[WGDEVICE_A_LISTEN_PORT]	= { .type = NLA_U16 },
 	[WGDEVICE_A_FWMARK]		= { .type = NLA_U32 },
-	[WGDEVICE_A_PEERS]		= { .type = NLA_NESTED }
+	[WGDEVICE_A_PEERS]		= NLA_POLICY_NESTED_ARRAY(peer_policy),
 };
 
 static const struct nla_policy peer_policy[WGPEER_A_MAX + 1] = {
@@ -39,7 +41,7 @@ static const struct nla_policy peer_policy[WGPEER_A_MAX + 1] = {
 	[WGPEER_A_LAST_HANDSHAKE_TIME]			= NLA_POLICY_EXACT_LEN(sizeof(struct __kernel_timespec)),
 	[WGPEER_A_RX_BYTES]				= { .type = NLA_U64 },
 	[WGPEER_A_TX_BYTES]				= { .type = NLA_U64 },
-	[WGPEER_A_ALLOWEDIPS]				= { .type = NLA_NESTED },
+	[WGPEER_A_ALLOWEDIPS]				= NLA_POLICY_NESTED_ARRAY(allowedip_policy),
 	[WGPEER_A_PROTOCOL_VERSION]			= { .type = NLA_U32 }
 };
 
@@ -467,7 +469,7 @@ static int set_peer(struct wg_device *wg, struct nlattr **attrs)
 
 		nla_for_each_nested(attr, attrs[WGPEER_A_ALLOWEDIPS], rem) {
 			ret = nla_parse_nested(allowedip, WGALLOWEDIP_A_MAX,
-					       attr, allowedip_policy, NULL);
+					       attr, NULL, NULL);
 			if (ret < 0)
 				goto out;
 			ret = set_allowedip(peer, allowedip);
@@ -593,7 +595,7 @@ static int wg_set_device(struct sk_buff *skb, struct genl_info *info)
 
 		nla_for_each_nested(attr, info->attrs[WGDEVICE_A_PEERS], rem) {
 			ret = nla_parse_nested(peer, WGPEER_A_MAX, attr,
-					       peer_policy, NULL);
+					       NULL, NULL);
 			if (ret < 0)
 				goto out;
 			ret = set_peer(wg, peer);
-- 
2.51.0


