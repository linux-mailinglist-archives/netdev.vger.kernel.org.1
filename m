Return-Path: <netdev+bounces-13072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B21E673A16B
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 15:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27121C21115
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 13:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651531ED35;
	Thu, 22 Jun 2023 13:05:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B7C1E522
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 13:05:25 +0000 (UTC)
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BEF10F8;
	Thu, 22 Jun 2023 06:05:23 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1qCJzn-00D3El-Lw; Thu, 22 Jun 2023 14:05:08 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
	(envelope-from <ben@rainbowdash>)
	id 1qCJzo-002XrN-0x;
	Thu, 22 Jun 2023 14:05:08 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: netdev@vger.kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net
Cc: linux-kernel@vger.kernel.org,
	claudiu.beznea@microchip.com,
	nicolas.ferre@microchip.com,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 3/3] net: macb: fix __be32 warnings in debug code
Date: Thu, 22 Jun 2023 14:05:07 +0100
Message-Id: <20230622130507.606713-4-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622130507.606713-1-ben.dooks@codethink.co.uk>
References: <20230622130507.606713-1-ben.dooks@codethink.co.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The netdev_dbg() calls in gem_add_flow_filter() and gem_del_flow_filter()
call ntohl() on the ipv4 addresses, which will put them into the host order
but not the right type (returns a __be32, not an u32 as would be expected).

Chaning the htonl() to nthol() should still do the right conversion, return
the correct u32 type and  should not change any functional to remove the
following sparse warnings:

drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: incorrect type in argument 1 (different base types)
drivers/net/ethernet/cadence/macb_main.c:3568:9:    expected unsigned int [usertype] val
drivers/net/ethernet/cadence/macb_main.c:3568:9:    got restricted __be32 [usertype] ip4src
drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: cast from restricted __be32
drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: cast from restricted __be32
drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: cast from restricted __be32
drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: cast from restricted __be32
drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: incorrect type in argument 1 (different base types)
drivers/net/ethernet/cadence/macb_main.c:3568:9:    expected unsigned int [usertype] val
drivers/net/ethernet/cadence/macb_main.c:3568:9:    got restricted __be32 [usertype] ip4dst
drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: cast from restricted __be32
drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: cast from restricted __be32
drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: cast from restricted __be32
drivers/net/ethernet/cadence/macb_main.c:3568:9: warning: cast from restricted __be32
d
drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: incorrect type in argument 1 (different base types)
drivers/net/ethernet/cadence/macb_main.c:3622:25:    expected unsigned int [usertype] val
drivers/net/ethernet/cadence/macb_main.c:3622:25:    got restricted __be32 [usertype] ip4src
drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: cast from restricted __be32
drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: cast from restricted __be32
drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: cast from restricted __be32
drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: cast from restricted __be32
drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: incorrect type in argument 1 (different base types)
drivers/net/ethernet/cadence/macb_main.c:3622:25:    expected unsigned int [usertype] val
drivers/net/ethernet/cadence/macb_main.c:3622:25:    got restricted __be32 [usertype] ip4dst
drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: cast from restricted __be32
drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: cast from restricted __be32
drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: cast from restricted __be32
drivers/net/ethernet/cadence/macb_main.c:3622:25: warning: cast from restricted __be32

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/net/ethernet/cadence/macb_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 56e202b74bd7..59a90c2b307f 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3568,8 +3568,8 @@ static int gem_add_flow_filter(struct net_device *netdev,
 	netdev_dbg(netdev,
 			"Adding flow filter entry,type=%u,queue=%u,loc=%u,src=%08X,dst=%08X,ps=%u,pd=%u\n",
 			fs->flow_type, (int)fs->ring_cookie, fs->location,
-			htonl(fs->h_u.tcp_ip4_spec.ip4src),
-			htonl(fs->h_u.tcp_ip4_spec.ip4dst),
+			ntohl(fs->h_u.tcp_ip4_spec.ip4src),
+			ntohl(fs->h_u.tcp_ip4_spec.ip4dst),
 			be16_to_cpu(fs->h_u.tcp_ip4_spec.psrc),
 			be16_to_cpu(fs->h_u.tcp_ip4_spec.pdst));
 
@@ -3622,8 +3622,8 @@ static int gem_del_flow_filter(struct net_device *netdev,
 			netdev_dbg(netdev,
 					"Deleting flow filter entry,type=%u,queue=%u,loc=%u,src=%08X,dst=%08X,ps=%u,pd=%u\n",
 					fs->flow_type, (int)fs->ring_cookie, fs->location,
-					htonl(fs->h_u.tcp_ip4_spec.ip4src),
-					htonl(fs->h_u.tcp_ip4_spec.ip4dst),
+					ntohl(fs->h_u.tcp_ip4_spec.ip4src),
+					ntohl(fs->h_u.tcp_ip4_spec.ip4dst),
 					be16_to_cpu(fs->h_u.tcp_ip4_spec.psrc),
 					be16_to_cpu(fs->h_u.tcp_ip4_spec.pdst));
 
-- 
2.40.1


