Return-Path: <netdev+bounces-99685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 694F78D5D40
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 10:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2580828B07E
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 08:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0184E156677;
	Fri, 31 May 2024 08:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="IrQzKMml"
X-Original-To: netdev@vger.kernel.org
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D7515665B
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717145673; cv=none; b=WO/up0IKB++xZhKqTLLsJkp1flO0IKPmNMWL+MDerc9bXVbGotmwYo0hTKabU8qwXhfS69HnjxRNbEt7gJ9EzReXpfAxY2Ne5462WtHAeGDUfp7FVxl008rHiVKKpfGJdjsHwXuOohN7l1LJOyTO4B8mq+5DCoslR0DbYf4cNHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717145673; c=relaxed/simple;
	bh=ocCtK7TxO3KuKC0j7zTbWsXMjjRO80aBpoP7m9MXrQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZqgFpmB7Yo1EwMr2JnWWWaBgXISpQI9bSgQ5d/+yvpUvcUInlVwJ84OHrZ0FHYjyuqL0RHj6DF33TQqycFVutKWhnqV2B8g5yNA7rn0CnsQyRR4AlsOId050zR7F6itsBVSHOz/QZ78+hSFI0Th4GyBv05B4D0woO/+oU9YhgTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=IrQzKMml; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1717145672; x=1748681672;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ocCtK7TxO3KuKC0j7zTbWsXMjjRO80aBpoP7m9MXrQ0=;
  b=IrQzKMmlNCYP9px0aKMKkiE4JwE/7YdSPJXOEHbeKQY1bCY++gi/qb2z
   15cmHJJNDg2R14Ji64Praq/txnqlOhircCSlCeDxT6kxLf8+GD92PpaZO
   kRz1s6//9oI8AWZp7JYITUj9xZyiwppK1AGRk9wiz8VQBzWQkgjZ34VnV
   UH/s82CfytVkO9Kzf6o77p12aXG2naz2RcCnqG6do+1cdu8NjPrrh7T8J
   44oYtgpHyDVpJ66AmWJ6cOTTGv/7aBmPG6/WQ7F5ZMEmHgYqFzOPMXC9X
   NJ+Uc0xQ3AmJWJBQjhu8HMRG06FB+GCMOoEQtZNEkCj+Dntjjps2DCjHB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="140067277"
X-IronPort-AV: E=Sophos;i="6.08,203,1712588400"; 
   d="scan'208";a="140067277"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 17:54:29 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 13BD4D4F5F
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 17:54:27 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 54091D5601
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 17:54:26 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id DA8432030C8A7
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 17:54:25 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.225.189])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 3ACF81A000A;
	Fri, 31 May 2024 16:54:25 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: bridge@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: bridge: fix an inconsistent indentation
Date: Fri, 31 May 2024 16:54:02 +0800
Message-Id: <20240531085402.1838-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28420.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28420.006
X-TMASE-Result: 10-3.235300-10.000000
X-TMASE-MatchedRID: MIzou+McLCqSlJbFK+uaF2/6CCblACLhTfK5j0EZbyufHrjLA9DhZiTC
	VwyY5KnUIvrftAIhWmLy9zcRSkKatTOfD6L6toKjtPtBQlRa0ix9LQinZ4QefOYQ3zcXToXr+gt
	Hj7OwNO2OhzOa6g8KrYT+gRlsVJu0A1JMyXUvJPVRIvRZ3/3s6z2Nnjucv3QSc5ARF/jGx9CNd4
	2xNa0qYY3AqGMtRT4gzOoGrutJjQAmXg5tYQqr4RXBt/mUREyAj/ZFF9Wfm7hNy7ppG0IjcFQqk
	0j7vLVUewMSBDreIdk=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Smatch complains:
net/bridge/br_netlink_tunnel.c:
   318 br_process_vlan_tunnel_info() warn: inconsistent indenting

Fix it with a proper indenting

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
v2:
    add net-next tag
    modify subject

 net/bridge/br_netlink_tunnel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_netlink_tunnel.c b/net/bridge/br_netlink_tunnel.c
index 17abf092f7ca..71a12da30004 100644
--- a/net/bridge/br_netlink_tunnel.c
+++ b/net/bridge/br_netlink_tunnel.c
@@ -315,8 +315,8 @@ int br_process_vlan_tunnel_info(const struct net_bridge *br,
 
 			if (curr_change)
 				*changed = curr_change;
-			 __vlan_tunnel_handle_range(p, &v_start, &v_end, v,
-						    curr_change);
+			__vlan_tunnel_handle_range(p, &v_start, &v_end, v,
+						   curr_change);
 		}
 		if (v_start && v_end)
 			br_vlan_notify(br, p, v_start->vid, v_end->vid,
-- 
2.39.1


