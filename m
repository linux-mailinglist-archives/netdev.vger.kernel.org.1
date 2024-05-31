Return-Path: <netdev+bounces-99668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3658D5C64
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 10:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C649DB2112D
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 08:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AF1770FE;
	Fri, 31 May 2024 08:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="DtgbQQtX"
X-Original-To: netdev@vger.kernel.org
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAC874057
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 08:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717143121; cv=none; b=rcIPefYq2tcL8LOxjrb76s6oUtnF/8WtmMFnbMyMn/m06RrY73kwCQEeh/AZ+ywqxY3UPgrYjcTsHQbhMqC76gqeKOr4+xz8OwCcUzN12bggIYtBmZDKhabikLFGvbx1KB4e55q21+NgJ6/FdJuliqFsmnKVCAzuRa51mrpnXzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717143121; c=relaxed/simple;
	bh=YAzk/Z21OffZ/0jQxK+37Gcwl/sCwNgTdKOAQBLXBXw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B4hQY0AwJCIUbRQ6fG9mnDENFKJMBrKuOQLvzR63w+QQO2WiSPnfYsKlIkYEMxYaUTL1587HpiBPrYgyMYmvXFcO3YVCmEgqi98DgTpN4+tp+JG76EU2vZmjwMC/UyqdgnEBPUeU3XDekhlf3orS8xw4V/GBv+YHXIot/pA4QXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=DtgbQQtX; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1717143118; x=1748679118;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YAzk/Z21OffZ/0jQxK+37Gcwl/sCwNgTdKOAQBLXBXw=;
  b=DtgbQQtXMlBk2mWpfuhWcDSTXuRjgAvrT4r7r+OSEnv4NDGXQNBIW5qd
   F1fcQXm+NZE4KcOF3tFOZTa7jo6EUyAlj8J82R1fnlHDHPEYWadRkNU8b
   JjBk8u0gatFKxqKPUXtF+LUg2YtNh9ZqZd6Mf/gq5S+hgYAQqbpMsXiXx
   b1oAI/UiAoYgHPfHk2HjhY+PIIv7OiCHmtr79bHeGpG0qF08GRnDpS8zz
   p0AqGhXZLfPzhchMwgJ+AkqjqLHV2bbG14qBSHrfvbO2WvOPyyGbhDtcG
   hTM67xABNCJOh2aUIJCFWEk4ueBupiE2HJul9Wtf1c9oqpT5tXXYH6Hqn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="148973649"
X-IronPort-AV: E=Sophos;i="6.08,203,1712588400"; 
   d="scan'208";a="148973649"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 17:11:49 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 16DB6D805A
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 17:11:48 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 4B4B915818
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 17:11:47 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 931892F4C2B
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 17:11:46 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.225.189])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 6BD901A000A;
	Fri, 31 May 2024 16:11:45 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: bridge@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH] net: bridge: Clean up one inconsistent indenting warn reported by smatch
Date: Fri, 31 May 2024 16:11:36 +0800
Message-Id: <20240531081136.582-1-chenhx.fnst@fujitsu.com>
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
X-TMASE-Result: 10-3.538300-10.000000
X-TMASE-MatchedRID: E96g+3imn7mSlJbFK+uaF2/6CCblACLhTfK5j0EZbyvAuQ0xDMaXkH4q
	tYI9sRE/L2EYbInFI5stE4KgUQ2xoJcFdomgH0lnFEUknJ/kEl5jFT88f69nG/oLR4+zsDTtjoc
	zmuoPCq2uFo2Cd8JyNxeqljGHCpsHTexG/klFQrnrVcsQVCm36v+3yk9jUTPbq8Inj9pPWMWgny
	0VDDErFuOQXG+3ze/ebpNNOGz5jTIVwbf5lERMgI/2RRfVn5u4Tcu6aRtCI3BUKpNI+7y1VHsDE
	gQ63iHZ
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

smatch complains:
net/bridge/br_netlink_tunnel.c:
   318 br_process_vlan_tunnel_info() warn: inconsistent indenting

Fix it with proper indenting.

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
 net/bridge/br_netlink_tunnel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_netlink_tunnel.c b/net/bridge/br_netlink_tunnel.c
index 17abf092f7ca..25ac3a5386ef 100644
--- a/net/bridge/br_netlink_tunnel.c
+++ b/net/bridge/br_netlink_tunnel.c
@@ -315,8 +315,9 @@ int br_process_vlan_tunnel_info(const struct net_bridge *br,
 
 			if (curr_change)
 				*changed = curr_change;
-			 __vlan_tunnel_handle_range(p, &v_start, &v_end, v,
-						    curr_change);
+
+			__vlan_tunnel_handle_range(p, &v_start, &v_end, v,
+						   curr_change);
 		}
 		if (v_start && v_end)
 			br_vlan_notify(br, p, v_start->vid, v_end->vid,
-- 
2.39.1


