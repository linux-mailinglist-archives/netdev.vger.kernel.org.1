Return-Path: <netdev+bounces-32789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FE779A702
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 11:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D80BA1C20A04
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 09:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D24C139;
	Mon, 11 Sep 2023 09:50:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE91DC131
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 09:50:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE82E44
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 02:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694425852; x=1725961852;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aeffaYIurTUmMJRqaKyoTRyPRno8JH6s95RpemK9j/s=;
  b=dZ4w29Ho3oyltb4v2K0heINP0S8qA+d6QhZjXrqzk+RGJo47pQXtrPnp
   o4SoFVeVUaqXKNwFNXsVEyPoAND5/p8hz8tHFkOXzyB6MkI4WgkZtMWjP
   bi7/D0jv2wG1wJGMeYsFDHcc2UovWWRxTuh6pLc3Rkq/izM5TGmU9hZYD
   bdJOwfdFe1JnuYbppcKu9RKwwZDTLlGLwQQ6xYc+x36gwxhjlWt0IlHI4
   Mj3HrANGc+8G5Izw8xHGVUGb78QuEJFuc54KVIm5yx+UBeO4aaw3M8iOz
   jrZ+sdJ714eQ7+GMthzS5xTxStwfCW8+anG8WSaX7jMU5A88oThxOVQuP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="377957108"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="377957108"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 02:50:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="693032162"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="693032162"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 11 Sep 2023 02:50:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 30BF3988; Mon, 11 Sep 2023 12:50:39 +0300 (EEST)
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
Subject: [PATCH] net: thunderbolt: Fix TCP/UDPv6 GSO checksum calculation
Date: Mon, 11 Sep 2023 12:50:39 +0300
Message-Id: <20230911095039.3611113-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Alex reported that running ssh over IPv6 does not work with
Thunderbolt/USB4 networking driver. The reason for that is that driver
should call skb_is_gso() before calling skb_is_gso_v6(), and it should
not return false after calculates the checksum successfully. This probably
was a copy paste error from the original driver where it was done
properly.

While there add checksum calculation for UDPv6 GSO packets as well.

Cc: stable@vger.kernel.org
Reported-by: Alex Balcanquall <alex@alexbal.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/net/thunderbolt/main.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index 0c1e8970ee58..ba50a554478f 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -1049,12 +1049,21 @@ static bool tbnet_xmit_csum_and_map(struct tbnet *net, struct sk_buff *skb,
 		*tucso = ~csum_tcpudp_magic(ip_hdr(skb)->saddr,
 					    ip_hdr(skb)->daddr, 0,
 					    ip_hdr(skb)->protocol, 0);
-	} else if (skb_is_gso_v6(skb)) {
-		tucso = dest + ((void *)&(tcp_hdr(skb)->check) - data);
-		*tucso = ~csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
-					  &ipv6_hdr(skb)->daddr, 0,
-					  IPPROTO_TCP, 0);
-		return false;
+	} else if (skb_is_gso(skb)) {
+		if (skb_is_gso_v6(skb)) {
+			tucso = dest + ((void *)&(tcp_hdr(skb)->check) - data);
+			*tucso = ~csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
+						  &ipv6_hdr(skb)->daddr, 0,
+						  IPPROTO_TCP, 0);
+		} else if (protocol == htons(ETH_P_IPV6) &&
+			   (skb_shinfo(skb)->gso_type & SKB_GSO_UDP)) {
+			tucso = dest + ((void *)&(udp_hdr(skb)->check) - data);
+			*tucso = ~csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
+						  &ipv6_hdr(skb)->daddr, 0,
+						  IPPROTO_UDP, 0);
+		} else {
+			return false;
+		}
 	} else if (protocol == htons(ETH_P_IPV6)) {
 		tucso = dest + skb_checksum_start_offset(skb) + skb->csum_offset;
 		*tucso = ~csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
-- 
2.40.1


