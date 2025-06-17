Return-Path: <netdev+bounces-198424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11F9ADC1F0
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 07:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96CFC161F62
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 05:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED36215F6C;
	Tue, 17 Jun 2025 05:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hillstonenet.com header.i=@hillstonenet.com header.b="Vbo8TecS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m21468.qiye.163.com (mail-m21468.qiye.163.com [117.135.214.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA6E3C01;
	Tue, 17 Jun 2025 05:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750139864; cv=none; b=RXtlq2NerAWG4XYBkkqFqJ5jt2tbDVYUjEFFMmVBJP4vfsju6J0rp4iLQGM9VCNih5t0+CiLwq+wlr8gdy+Eq++Y7lMH4mS1+sXryl+E8gecyewVe7gJzYgChCUhVODmpvjiyc+Y8co5hykOYEfgAmrOSuGcVDUEtQBV6boaYBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750139864; c=relaxed/simple;
	bh=cH7uEc+o+GNDoYHU6R/Q75XFkTN1WFvZxjN/8EZRu1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T0c7B5BtZKrWDtRaXZoW6VWazx+sN1LjGTJMq6qNIw68QFRN1FmnA7C0Y+2G7nNX6JBCqwZUnVLoDPPR0V3x8PARGDIkEArB/3+msXaODLHQyG2+nqf+z7KjwGaPEM/yQhzE/6+aCIhAMaAdCNWAHxLu14XVO/9Mdec0wcNRwsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hillstonenet.com; spf=pass smtp.mailfrom=hillstonenet.com; dkim=pass (1024-bit key) header.d=hillstonenet.com header.i=@hillstonenet.com header.b=Vbo8TecS; arc=none smtp.client-ip=117.135.214.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hillstonenet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hillstonenet.com
Received: from localhost.localdomain (unknown [123.123.73.125])
	by smtp.qiye.163.com (Hmail) with ESMTP id 18ea241cd;
	Tue, 17 Jun 2025 13:57:29 +0800 (GMT+08:00)
From: Haixia Qu <hxqu@hillstonenet.com>
To: Jon Maloy <jmaloy@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Haixia Qu <hxqu@hillstonenet.com>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 net] tipc: fix null-ptr-deref when acquiring remote ip of ethernet bearer
Date: Tue, 17 Jun 2025 05:56:24 +0000
Message-ID: <20250617055624.2680-1-hxqu@hillstonenet.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGEJIVhlDQkJPSElMSEkfS1YVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSUhVSklIVUxIVUpJTllXWRYaDxIVHRRZQVlPS0hVSktISk5MTlVKS0
	tVSkJLS1kG
X-HM-Tid: 0a977c76c96803a8kunme8d0af4014995cb
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6N0k6PRw*QzE5AjkMFxkzEiwT
	LggwCjNVSlVKTE5LSkhCQ05LSE5CVTMWGhIXVRMDCg47ExIXFwgPFBUeFR4PVRgUFkVZV1kSC1lB
	WUpJSFVKSUhVTEhVSklOWVdZCAFZQUlOTEM3Bg++
DKIM-Signature:a=rsa-sha256;
	b=Vbo8TecS6d6OvR5CbRuEvSPIp2mHfTDL1BvlolKF6K9X8tDjH67g8tAMBT0xbmTg6Kp6SHjvMTtejoyqUEqEqvn6IUboYuFD+4ueNTL84PfJNuer+qElN+KKVAaH2t/t4I6qic7FoKZozFrwLUkqonggRUVGkhkxSQpvSSm0ibg=; c=relaxed/relaxed; s=default; d=hillstonenet.com; v=1;
	bh=JMF0aAROw+9+kAyVzUFm6TfojGxyJA29t9heYE5wWFo=;
	h=date:mime-version:subject:message-id:from;

The reproduction steps:
1. create a tun interface
2. enable l2 bearer
3. TIPC_NL_UDP_GET_REMOTEIP with media name set to tun

tipc: Started in network mode
tipc: Node identity 8af312d38a21, cluster identity 4711
tipc: Enabled bearer <eth:syz_tun>, priority 1
Oops: general protection fault
KASAN: null-ptr-deref in range
CPU: 1 UID: 1000 PID: 559 Comm: poc Not tainted 6.16.0-rc1+ #117 PREEMPT
Hardware name: QEMU Ubuntu 24.04 PC
RIP: 0010:tipc_udp_nl_dump_remoteip+0x4a4/0x8f0

the ub was in fact a struct dev.

when bid != 0 && skip_cnt != 0, bearer_list[bid] may be NULL or
other media when other thread changes it.

fix this by checking media_id.

Fixes: 832629ca5c313 ("tipc: add UDP remoteip dump to netlink API")
Signed-off-by: Haixia Qu <hxqu@hillstonenet.com>
---
v4:
  - make commit message more descriptive
v3: https://patchwork.kernel.org/project/netdevbpf/patch/20250616042901.12978-1-hxqu@hillstonenet.com/
  - add Fixes tag in commit message
  - add target tree net
---
 net/tipc/udp_media.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 108a4cc2e001..258d6aa4f21a 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -489,7 +489,7 @@ int tipc_udp_nl_dump_remoteip(struct sk_buff *skb, struct netlink_callback *cb)
 
 		rtnl_lock();
 		b = tipc_bearer_find(net, bname);
-		if (!b) {
+		if (!b || b->bcast_addr.media_id != TIPC_MEDIA_TYPE_UDP) {
 			rtnl_unlock();
 			return -EINVAL;
 		}
@@ -500,7 +500,7 @@ int tipc_udp_nl_dump_remoteip(struct sk_buff *skb, struct netlink_callback *cb)
 
 		rtnl_lock();
 		b = rtnl_dereference(tn->bearer_list[bid]);
-		if (!b) {
+		if (!b || b->bcast_addr.media_id != TIPC_MEDIA_TYPE_UDP) {
 			rtnl_unlock();
 			return -EINVAL;
 		}
-- 
2.43.0


