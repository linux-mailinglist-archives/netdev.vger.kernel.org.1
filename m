Return-Path: <netdev+bounces-147274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8C69D8DEB
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 22:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FDDF28C966
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 21:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2ECC1C5799;
	Mon, 25 Nov 2024 21:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="AIQ0PAmd"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E001C7B62
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 21:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732569683; cv=none; b=IUg7QDt83K89okk2Y2CyDe1FZLiIESCNAgrByxi7XAPBZ0v1JJFLxihSTQC3Sahm39hQm+x9DQ5CxvMvg+P0DA6y5cmfF1tKc357vdH5oy1UL6vMOzC0wlHQop4dhUEI6RV/hPavhwuSefmiStLPvQLOyx/T1duAxCGjOPRHInc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732569683; c=relaxed/simple;
	bh=bzhEM8/865tyqN1e3zeR/py6wHGMQNG0xrMe5mBbW9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GIIETqBEIf04URRxA2PSWUwOpji9+EvQM1pRzoMKa8wn2n4pASeaDyEwwkZLGh17Y3Fis3IRb0V2+pPJt7BC2Vo5h1uFdfyntUJg1TFH3uPbLvPfRZJUcS5a21i4I31BQFIHCc474tJjUC78MxiBLXbA7ChYg4Ul0D4CBbkXNXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=AIQ0PAmd; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id AA75D100081;
	Mon, 25 Nov 2024 21:21:16 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id C505913C2B0;
	Mon, 25 Nov 2024 13:21:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com C505913C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1732569676;
	bh=bzhEM8/865tyqN1e3zeR/py6wHGMQNG0xrMe5mBbW9M=;
	h=From:To:Cc:Subject:Date:From;
	b=AIQ0PAmdh6AdqtvIgGR26OlrlMn5M3wrHY+BEdE8IBaudqdqY9dt+gq8IwLddiKzq
	 BHxQY/MX3jmSkQna/06mMOhcyuVUJ3Rovr4rcxDSsDLeVt6CCuZSM11ae7wsHQGmF/
	 FJWVWayEL93cmH4opnxRIdLR04Jcm33dWPcvSbrA=
From: greearb@candelatech.com
To: netdev@vger.kernel.org
Cc: Jason@zx2c4.com,
	wireguard@lists.zx2c4.com,
	dsahern@kernel.org,
	Ben Greear <greearb@candelatech.com>
Subject: [PATCH] net: wireguard: Allow binding to specific ifindex
Date: Mon, 25 Nov 2024 13:21:11 -0800
Message-ID: <20241125212111.1533982-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1732569677-UWMuRmxcx1dG
X-MDID-O:
 us5;ut7;1732569677;UWMuRmxcx1dG;<greearb@candelatech.com>;2cb6a4bd943e67fe8a6fabf2d7a930d0
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Ben Greear <greearb@candelatech.com>

Which allows us to bind to VRF.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---

NOTE:  Modified user-space to utilize this may be found here:
https://github.com/greearb/wireguard-tools-ct
Only the 'wg' part has been tested with this new feature as of today.

 drivers/net/wireguard/device.h  |  1 +
 drivers/net/wireguard/netlink.c | 12 +++++++++++-
 drivers/net/wireguard/socket.c  |  8 +++++++-
 include/uapi/linux/wireguard.h  |  3 +++
 4 files changed, 22 insertions(+), 2 deletions(-)

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
index 0414d7a6ce74..a7cb1c7c3112 100644
--- a/drivers/net/wireguard/socket.c
+++ b/drivers/net/wireguard/socket.c
@@ -25,7 +25,8 @@ static int send4(struct wg_device *wg, struct sk_buff *skb,
 		.daddr = endpoint->addr4.sin_addr.s_addr,
 		.fl4_dport = endpoint->addr4.sin_port,
 		.flowi4_mark = wg->fwmark,
-		.flowi4_proto = IPPROTO_UDP
+		.flowi4_proto = IPPROTO_UDP,
+		.flowi4_oif = wg->lowerdev,
 	};
 	struct rtable *rt = NULL;
 	struct sock *sock;
@@ -111,6 +112,9 @@ static int send6(struct wg_device *wg, struct sk_buff *skb,
 	struct sock *sock;
 	int ret = 0;
 
+	if (wg->lowerdev)
+		fl.flowi6_oif = wg->lowerdev,
+
 	skb_mark_not_on_list(skb);
 	skb->dev = wg->dev;
 	skb->mark = wg->fwmark;
@@ -360,6 +364,7 @@ int wg_socket_init(struct wg_device *wg, u16 port)
 		.family = AF_INET,
 		.local_ip.s_addr = htonl(INADDR_ANY),
 		.local_udp_port = htons(port),
+		.bind_ifindex = wg->lowerdev,
 		.use_udp_checksums = true
 	};
 #if IS_ENABLED(CONFIG_IPV6)
@@ -369,6 +374,7 @@ int wg_socket_init(struct wg_device *wg, u16 port)
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


