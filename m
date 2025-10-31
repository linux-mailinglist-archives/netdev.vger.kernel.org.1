Return-Path: <netdev+bounces-234683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DA6C261D4
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5595B565BCC
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 16:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48CF2EC081;
	Fri, 31 Oct 2025 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Kt4SZWvv"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D479229B2A;
	Fri, 31 Oct 2025 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926844; cv=none; b=cThX659EcfOlZGP1KcHjwHZ20gFEksH8lM3Gj7O9VOurJygoJLVdSS3k8+OL7DYMe3gwqI5CXrB3iSFiU6JGxOJ8UtJX5RDz+aemg2L/S4YDaRggjyValboB/b+3DBMTQp+Vcnv0JxnFD1P+W3wYxedSMx4qBHCDKILyGfEa068=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926844; c=relaxed/simple;
	bh=He5ET711S02oLtc1y7hWh0ZqphfBwv5k6IK3wRuetZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c6nZgW8sPWOrpm/0us0v2E/4/pUnWuQprJN/qqcYoejsxSkqDKyJmHu9RtLZoyh4RDBDbG+BRNWTKzQL/Na5oy8ArRtphlBthXwIchRQSGMEQRuLUFGFLdg1InQ9db9MDeW/IUDIFh4OV83JaQKJIAVsuyjefchHzQOB92TjrjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Kt4SZWvv; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1761926832;
	bh=He5ET711S02oLtc1y7hWh0ZqphfBwv5k6IK3wRuetZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kt4SZWvvTR8IVk5iQJA/Sepvl7iGP/yuj7ZNEkqKC5oSZo6wjfruvMxPCbWPIeroN
	 sdHP56ka6XqRt2j/plCoxImmvKpVVaor0i2Xi9+N3xQt8t9BkQbiCvcAnEu8LBqUe/
	 PNh9NmFU6MNLnXjCX/k3IJ1tddvWuLlNOPjq7kbUZScq9SOOmYwJ+6TqHlWNDyK9c3
	 GpQMBiqhNwKv8/IOZRTRM9UgkiLUvDkJrKWDNNt7JL8vEUBLNWPCOLprLbaxkpfnGq
	 4OxehtyMBxCErVSw8xpygv7jSiuK/08fbkhBwAguR+voVlN05sA6dMCD6wR9no5W3A
	 ng6pbYwINcE/w==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 3F23B6010F;
	Fri, 31 Oct 2025 16:07:12 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 42DB7202A39; Fri, 31 Oct 2025 16:05:42 +0000 (UTC)
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
Subject: [PATCH net-next v2 01/11] wireguard: netlink: validate nested arrays in policy
Date: Fri, 31 Oct 2025 16:05:27 +0000
Message-ID: <20251031160539.1701943-2-ast@fiberby.net>
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

Use NLA_POLICY_NESTED_ARRAY() to perform nested array validation
in the policy validation step.

The nested policy was already enforced through nla_parse_nested(),
however extack wasn't passed previously.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/wireguard/netlink.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
index 67f962eb8b46..e4416f23d427 100644
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


