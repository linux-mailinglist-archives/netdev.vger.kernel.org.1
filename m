Return-Path: <netdev+bounces-161933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0915AA24B5F
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 19:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85674188596B
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 18:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF871C5F1A;
	Sat,  1 Feb 2025 18:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cj+mfVaO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327561C54AA
	for <netdev@vger.kernel.org>; Sat,  1 Feb 2025 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738432997; cv=none; b=p6LRkKqVAMuzoIsAOiMNNMaHx+2hwJT/dBW1MGfRFMhGAbZ7F9S7TqcxkFogR/6ppt6g17KR/NcaPYTO7eRrUPvV8yBEfY34/fl5U/bM/qkL83TAyNchC8TL5++/3MJBC8orWWNJ6yh/tRUP/t/CkAHRERWDj+uJMo7uldgthk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738432997; c=relaxed/simple;
	bh=1vwQX7OolHDRpKuSGr5H48SdwSt19OoecWbx6KPiwos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NX5QRMtxvctiwTb3c//yT1HR0QPFPXwXSsaxAGda+VKbanY25gzKcgTOS3WBBwaCOya1HPVhMa8swSATQzLipKyKhnc8yc3cSA7qDJV+Td4mckRP8YSiDZWxOSDa22HJCoQEVR5NYelaPQynMez0SYfY+K+0jKdTSTqJ3wrsZRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cj+mfVaO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738432994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5nnoS5Zd/81zucTSESkRuRLq87b0TwhDEL7moXiy2vE=;
	b=Cj+mfVaOVMXJJzWCf6VZh36A7yp3McBo6LM6Eps60q2FJCxaIsO7XHiG5XU7ja00o57PLd
	OK9cntvwqJVHhFhCngGYPWkPPwRrZykj8eE7fwnzE47OQxsaLDo8ghj0cIwJdEx+U/N4W5
	ZIZMPPZ7w4uPK7+KSQYq/br/pT6iEoA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-PjPZ4apxNIKZW_j2qKTLYQ-1; Sat,
 01 Feb 2025 13:03:08 -0500
X-MC-Unique: PjPZ4apxNIKZW_j2qKTLYQ-1
X-Mimecast-MFC-AGG-ID: PjPZ4apxNIKZW_j2qKTLYQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D4C2180034D;
	Sat,  1 Feb 2025 18:03:07 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.41])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 77DDB19560A3;
	Sat,  1 Feb 2025 18:03:04 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Guillaume Nault <gnault@redhat.com>
Subject: [PATCH net] net: armonize tstats and dstats
Date: Sat,  1 Feb 2025 19:02:51 +0100
Message-ID: <2e1c444cf0f63ae472baff29862c4c869be17031.1738432804.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

After the blamed commits below, some UDP tunnel use dstats for
accounting. On the xmit path, all the UDP-base tunnels ends up
using iptunnel_xmit_stats() for stats accounting, and the latter
assumes the relevant (tunnel) network device uses tstats.

The end result is some 'funny' stat report for the mentioned UDP
tunnel, e.g. when no packet is actually dropped and a bunch of
packets are transmitted:

gnv2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue \
		state UNKNOWN mode DEFAULT group default qlen 1000
    link/ether ee:7d:09:87:90:ea brd ff:ff:ff:ff:ff:ff
    RX:  bytes packets errors dropped  missed   mcast
         14916      23      0      15       0       0
    TX:  bytes packets errors dropped carrier collsns
             0    1566      0       0       0       0

Address the issue ensuring the same binary layout for the overlapping
fields of dstats and tstats. While this solution is a bit hackish, is
smaller and with no performance pitfall compared to other alternatives
i.e. supporting both dstat and tstat in iptunnel_xmit_stats() or
reverting the blamed commit.

With time we should possibly move all the IP-based tunnel (and virtual
devices) to dstats.

Fixes: c77200c07491 ("bareudp: Handle stats using NETDEV_PCPU_STAT_DSTATS.")
Fixes: 6fa6de302246 ("geneve: Handle stats using NETDEV_PCPU_STAT_DSTATS.")
Fixes: be226352e8dc ("vxlan: Handle stats using NETDEV_PCPU_STAT_DSTATS.")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/linux/netdevice.h |  2 +-
 net/core/dev.c            | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 2a59034a5fa2..03bb584c62cf 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2904,9 +2904,9 @@ struct pcpu_sw_netstats {
 struct pcpu_dstats {
 	u64_stats_t		rx_packets;
 	u64_stats_t		rx_bytes;
-	u64_stats_t		rx_drops;
 	u64_stats_t		tx_packets;
 	u64_stats_t		tx_bytes;
+	u64_stats_t		rx_drops;
 	u64_stats_t		tx_drops;
 	struct u64_stats_sync	syncp;
 } __aligned(8 * sizeof(u64));
diff --git a/net/core/dev.c b/net/core/dev.c
index c0021cbd28fc..b91658e8aedb 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11286,6 +11286,20 @@ struct rtnl_link_stats64 *dev_get_stats(struct net_device *dev,
 	const struct net_device_ops *ops = dev->netdev_ops;
 	const struct net_device_core_stats __percpu *p;
 
+	/*
+	 * IPv{4,6} and udp tunnels share common stat helpers and use
+	 * different stat type (NETDEV_PCPU_STAT_TSTATS vs
+	 * NETDEV_PCPU_STAT_DSTATS). Ensure the accounting is consistent.
+	 */
+	BUILD_BUG_ON(offsetof(struct pcpu_sw_netstats, rx_bytes) !=
+		     offsetof(struct pcpu_dstats, rx_bytes));
+	BUILD_BUG_ON(offsetof(struct pcpu_sw_netstats, rx_packets) !=
+		     offsetof(struct pcpu_dstats, rx_packets));
+	BUILD_BUG_ON(offsetof(struct pcpu_sw_netstats, tx_bytes) !=
+		     offsetof(struct pcpu_dstats, tx_bytes));
+	BUILD_BUG_ON(offsetof(struct pcpu_sw_netstats, tx_packets) !=
+		     offsetof(struct pcpu_dstats, tx_packets));
+
 	if (ops->ndo_get_stats64) {
 		memset(storage, 0, sizeof(*storage));
 		ops->ndo_get_stats64(dev, storage);
-- 
2.48.1


