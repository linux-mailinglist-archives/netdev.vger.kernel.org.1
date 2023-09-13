Return-Path: <netdev+bounces-33435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA41079DF60
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 07:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004A1281E9A
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 05:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DAB1549A;
	Wed, 13 Sep 2023 05:26:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4E61548E
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 05:26:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4477172A
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 22:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694582812; x=1726118812;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SwaB4yCgiUQ8ReRsK0zE6DU85oEym7sghLCN8y5GU1g=;
  b=hJ7qOgpjg8AsfoI0ZTYe+c/7Vrzkt897EvczqtEq0ggE+z6icgyOTPmO
   k0Khf4lV+1Xfjarp1o6p5IYBpWc30wbaYUGK7AvljK9XZyyEw1Hxwq26J
   wAXXL9yJzCIBScje53rpwTklsydycmIVy7HR7Ztb3bfOYxbsvrUkoXYNV
   PjZAYyTR6IofRDiCaD38AxIMa4WlE5Q3Zr7sGVZRlXVWqvJXTFlJkUtom
   wQxnlt6ZG1AGiKBUcDLTRcZLwSTQGnT+cxCFiTu26bIf/YP28jIgnn0/P
   pMKGCZB/UOaetQBk33rmImHYFyjoM0BW2GBwsCRsoLYo2RTjhYbwnEjvY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="464936441"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="464936441"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 22:26:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="693728092"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="693728092"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 12 Sep 2023 22:26:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id D45541E5; Wed, 13 Sep 2023 08:26:47 +0300 (EEST)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alex Balcanquall <alex@alexbal.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH v2] net: thunderbolt: Fix TCPv6 GSO checksum calculation
Date: Wed, 13 Sep 2023 08:26:47 +0300
Message-Id: <20230913052647.407420-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alex reported that running ssh over IPv6 does not work with
Thunderbolt/USB4 networking driver. The reason for that is that driver
should call skb_is_gso() before calling skb_is_gso_v6(), and it should
not return false after calculates the checksum successfully. This probably
was a copy paste error from the original driver where it was done properly.

Reported-by: Alex Balcanquall <alex@alexbal.com>
Fixes: e69b6c02b4c3 ("net: Add support for networking over Thunderbolt cable")
Cc: stable@vger.kernel.org
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Previous version of the patch:

https://lore.kernel.org/netdev/20230911095039.3611113-1-mika.westerberg@linux.intel.com/

Changes from v1:

  * Drop UDP v6 GSO checksum
  * Add Fixes tag

 drivers/net/thunderbolt/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index 0c1e8970ee58..0a53ec293d04 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -1049,12 +1049,11 @@ static bool tbnet_xmit_csum_and_map(struct tbnet *net, struct sk_buff *skb,
 		*tucso = ~csum_tcpudp_magic(ip_hdr(skb)->saddr,
 					    ip_hdr(skb)->daddr, 0,
 					    ip_hdr(skb)->protocol, 0);
-	} else if (skb_is_gso_v6(skb)) {
+	} else if (skb_is_gso(skb) && skb_is_gso_v6(skb)) {
 		tucso = dest + ((void *)&(tcp_hdr(skb)->check) - data);
 		*tucso = ~csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
 					  &ipv6_hdr(skb)->daddr, 0,
 					  IPPROTO_TCP, 0);
-		return false;
 	} else if (protocol == htons(ETH_P_IPV6)) {
 		tucso = dest + skb_checksum_start_offset(skb) + skb->csum_offset;
 		*tucso = ~csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
-- 
2.40.1


