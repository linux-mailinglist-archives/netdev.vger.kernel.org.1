Return-Path: <netdev+bounces-61559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE07A82442D
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6AE1F22949
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 14:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742F122EEE;
	Thu,  4 Jan 2024 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="ltoaVwVg"
X-Original-To: netdev@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7312823741
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=oOWSjNNhMqKPgkHjNpKWSb4kFtz4zvEd5fzvhUaVNEQ=; b=ltoaVwVgw9Aqob8TKJI3HbuUdp
	2VU35ZX2skE8J9mXD72YePO0TBDuP7hv1mNPu4F5cN+HE7pPXN5QGrfv8IvkrOY/HQDzG8pbxy+ka
	iz3MTwQrOdOhrOf27dMsBVkZJ9y0drN02GGWkUWeJe07OwzxfBaNXxGRPNfdjPfvxcrE=;
Received: from p4ff13178.dip0.t-ipconnect.de ([79.241.49.120] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1rLOel-0010lS-Jd
	for netdev@vger.kernel.org; Thu, 04 Jan 2024 15:25:11 +0100
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org
Subject: [PATCH net-next] net: bridge: do not send arp replies if src and target hw addr is the same
Date: Thu,  4 Jan 2024 15:25:01 +0100
Message-ID: <20240104142501.81092-1-nbd@nbd.name>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are broken devices in the wild that handle duplicate IP address
detection by sending out ARP requests for the IP that they received from a
DHCP server and refuse the address if they get a reply.
When proxyarp is enabled, they would go into a loop of requesting an address
and then NAKing it again.

Link: https://github.com/openwrt/openwrt/issues/14309
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/bridge/br_arp_nd_proxy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index c7869a286df4..3a2770938374 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -204,7 +204,10 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 			if ((p && (p->flags & BR_PROXYARP)) ||
 			    (f->dst && (f->dst->flags & BR_PROXYARP_WIFI)) ||
 			    br_is_neigh_suppress_enabled(f->dst, vid)) {
-				if (!vid)
+				replied = true;
+				if (!memcmp(n->ha, sha, dev->addr_len))
+					replied = false;
+				else if (!vid)
 					br_arp_send(br, p, skb->dev, sip, tip,
 						    sha, n->ha, sha, 0, 0);
 				else
@@ -212,7 +215,6 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 						    sha, n->ha, sha,
 						    skb->vlan_proto,
 						    skb_vlan_tag_get(skb));
-				replied = true;
 			}
 
 			/* If we have replied or as long as we know the
-- 
2.43.0


