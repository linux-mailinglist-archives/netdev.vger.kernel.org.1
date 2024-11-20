Return-Path: <netdev+bounces-146369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C859D319C
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 02:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 382932837CD
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 01:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9866AD27;
	Wed, 20 Nov 2024 01:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="PCzkjtAh"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9735182BD
	for <netdev@vger.kernel.org>; Wed, 20 Nov 2024 01:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732064864; cv=none; b=AiQ6dH9wV85zhdc5Tst18wGlyVouBxvk/5H8x9+Vhz5jeCV8VVZvtNcPy1MpfsdCLsyPYBXGedVJbAmBHBfgw7bvB3/bbCro+PyHzhIlEJ9HRSPsj7ckrAqSoENU+ZKJgJ9cCdTtfoa46x5GyBwuaB3MTGqSS17L1K723+amRTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732064864; c=relaxed/simple;
	bh=wzAqo4SgxpRekPbyBUSyMAiZvMaOxt4z8SmppBZ8jaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gV9fDmSjdiesoK3foxKCFjVKoUujoosrGob+RyuboPZzJ6uKz3X8cm15fZmO5CTduYGUENEVwY+RcQ3IukGGCOR11SXgVsM0YDDMr353AJ+sm8xVPkj7/a3P4Nridt0MooOiC2D5e7v00rO2iBo/r5LZeXi1l8vS3YQc6FeTV4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=PCzkjtAh; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id F089034006A
	for <netdev@vger.kernel.org>; Wed, 20 Nov 2024 01:07:33 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 43FD313C2B0;
	Tue, 19 Nov 2024 17:07:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 43FD313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1732064853;
	bh=wzAqo4SgxpRekPbyBUSyMAiZvMaOxt4z8SmppBZ8jaQ=;
	h=From:To:Cc:Subject:Date:From;
	b=PCzkjtAhlfn6l+21wK68i7Tp1rM/r3E3iRyQy81pp9bP7AXQ0gzExwOgIlJAy3IxG
	 AblEW14g2wYrpKEPz3MVr/GXhX40JdIyy8gco+AEuoRG5PX/nX8G1rqx7xYZJxRDia
	 4MaQaYOEiXlFCHGE62i9efP3qY393AFVzCABZYNs=
From: greearb@candelatech.com
To: netdev@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [RFC] net: wireguard:  Allow binding to specific ifindex
Date: Tue, 19 Nov 2024 17:07:31 -0800
Message-ID: <20241120010731.3794059-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1732064854-uJmfWfR72rWZ
X-MDID-O:
 us5;at1;1732064854;uJmfWfR72rWZ;<greearb@candelatech.com>;0590461a9946a11a9d6965a08c2b2857
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Ben Greear <greearb@candelatech.com>

Which allows us to bind to VRF.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---

Not tested yet, hoping for early feedback while we set up
proper testbed for this.

 drivers/net/wireguard/device.h  |  1 +
 drivers/net/wireguard/netlink.c | 12 +++++++++++-
 drivers/net/wireguard/socket.c  |  2 ++
 include/uapi/linux/wireguard.h  |  3 +++
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireguard/device.h b/drivers/net/wireguard/device.h
index 43c7cebbf50b..9698d9203915 100644
--- a/drivers/net/wireguard/device.h
+++ b/drivers/net/wireguard/device.h
@@ -53,6 +53,7 @@ struct wg_device {
 	atomic_t handshake_queue_len;
 	unsigned int num_peers, device_update_gen;
 	u32 fwmark;
+	int lowerdev; /* ifindex of lower level device to bind UDP transport */
 	u16 incoming_port;
 };
 
diff --git a/drivers/net/wireguard/netlink.c b/drivers/net/wireguard/netlink.c
index f7055180ba4a..5de3d59a17b0 100644
--- a/drivers/net/wireguard/netlink.c
+++ b/drivers/net/wireguard/netlink.c
@@ -27,7 +27,8 @@ static const struct nla_policy device_policy[WGDEVICE_A_MAX + 1] = {
 	[WGDEVICE_A_FLAGS]		= { .type = NLA_U32 },
 	[WGDEVICE_A_LISTEN_PORT]	= { .type = NLA_U16 },
 	[WGDEVICE_A_FWMARK]		= { .type = NLA_U32 },
-	[WGDEVICE_A_PEERS]		= { .type = NLA_NESTED }
+	[WGDEVICE_A_PEERS]		= { .type = NLA_NESTED },
+	[WGDEVICE_A_LOWERDEV]		= { .type = NLA_U32 },
 };
 
 static const struct nla_policy peer_policy[WGPEER_A_MAX + 1] = {
@@ -232,6 +233,7 @@ static int wg_get_device_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		if (nla_put_u16(skb, WGDEVICE_A_LISTEN_PORT,
 				wg->incoming_port) ||
 		    nla_put_u32(skb, WGDEVICE_A_FWMARK, wg->fwmark) ||
+		    nla_put_u32(skb, WGDEVICE_A_LOWERDEV, wg->lowerdev) ||
 		    nla_put_u32(skb, WGDEVICE_A_IFINDEX, wg->dev->ifindex) ||
 		    nla_put_string(skb, WGDEVICE_A_IFNAME, wg->dev->name))
 			goto out;
@@ -530,6 +532,14 @@ static int wg_set_device(struct sk_buff *skb, struct genl_info *info)
 			wg_socket_clear_peer_endpoint_src(peer);
 	}
 
+	if (info->attrs[WGDEVICE_A_LOWERDEV]) {
+		struct wg_peer *peer;
+
+		wg->lowerdev = nla_get_u32(info->attrs[WGDEVICE_A_LOWERDEV]);
+		list_for_each_entry(peer, &wg->peer_list, peer_list)
+			wg_socket_clear_peer_endpoint_src(peer);
+	}
+
 	if (info->attrs[WGDEVICE_A_LISTEN_PORT]) {
 		ret = set_port(wg,
 			nla_get_u16(info->attrs[WGDEVICE_A_LISTEN_PORT]));
diff --git a/drivers/net/wireguard/socket.c b/drivers/net/wireguard/socket.c
index 0414d7a6ce74..f8d12e841de0 100644
--- a/drivers/net/wireguard/socket.c
+++ b/drivers/net/wireguard/socket.c
@@ -360,6 +360,7 @@ int wg_socket_init(struct wg_device *wg, u16 port)
 		.family = AF_INET,
 		.local_ip.s_addr = htonl(INADDR_ANY),
 		.local_udp_port = htons(port),
+		.bind_ifindex = wg->lowerdev,
 		.use_udp_checksums = true
 	};
 #if IS_ENABLED(CONFIG_IPV6)
@@ -369,6 +370,7 @@ int wg_socket_init(struct wg_device *wg, u16 port)
 		.local_ip6 = IN6ADDR_ANY_INIT,
 		.use_udp6_tx_checksums = true,
 		.use_udp6_rx_checksums = true,
+		.bind_ifindex = wg->lowerdev,
 		.ipv6_v6only = true
 	};
 #endif
diff --git a/include/uapi/linux/wireguard.h b/include/uapi/linux/wireguard.h
index ae88be14c947..f3784885389a 100644
--- a/include/uapi/linux/wireguard.h
+++ b/include/uapi/linux/wireguard.h
@@ -29,6 +29,7 @@
  *    WGDEVICE_A_PUBLIC_KEY: NLA_EXACT_LEN, len WG_KEY_LEN
  *    WGDEVICE_A_LISTEN_PORT: NLA_U16
  *    WGDEVICE_A_FWMARK: NLA_U32
+ *    WGDEVICE_A_LOWERDEV: NLA_U32
  *    WGDEVICE_A_PEERS: NLA_NESTED
  *        0: NLA_NESTED
  *            WGPEER_A_PUBLIC_KEY: NLA_EXACT_LEN, len WG_KEY_LEN
@@ -83,6 +84,7 @@
  *    WGDEVICE_A_PRIVATE_KEY: len WG_KEY_LEN, all zeros to remove
  *    WGDEVICE_A_LISTEN_PORT: NLA_U16, 0 to choose randomly
  *    WGDEVICE_A_FWMARK: NLA_U32, 0 to disable
+ *    WGDEVICE_A_LOWERDEV: NLA_U32, ifindex to bind lower transport, 0 to disable
  *    WGDEVICE_A_PEERS: NLA_NESTED
  *        0: NLA_NESTED
  *            WGPEER_A_PUBLIC_KEY: len WG_KEY_LEN
@@ -157,6 +159,7 @@ enum wgdevice_attribute {
 	WGDEVICE_A_LISTEN_PORT,
 	WGDEVICE_A_FWMARK,
 	WGDEVICE_A_PEERS,
+	WGDEVICE_A_LOWERDEV,
 	__WGDEVICE_A_LAST
 };
 #define WGDEVICE_A_MAX (__WGDEVICE_A_LAST - 1)
-- 
2.42.0


