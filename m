Return-Path: <netdev+bounces-13071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B4573A162
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 15:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D7A0281987
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 13:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626DC1EA95;
	Thu, 22 Jun 2023 13:05:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526491E522
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 13:05:23 +0000 (UTC)
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917C619AB;
	Thu, 22 Jun 2023 06:05:21 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1qCJzn-00D3Ek-K2; Thu, 22 Jun 2023 14:05:08 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
	(envelope-from <ben@rainbowdash>)
	id 1qCJzo-002XrH-0t;
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
Subject: [PATCH 2/3] net: macb: add port constant to fix __be16 warnings
Date: Thu, 22 Jun 2023 14:05:06 +0100
Message-Id: <20230622130507.606713-3-ben.dooks@codethink.co.uk>
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

Add a constant MACB_PORT_MASK to use instead of 0xffff when checking against
ipv4 address port numbers. This allows the use of the __be16 constant and
silences the following sparse warnings:

drivers/net/ethernet/cadence/macb_main.c:3458:40: warning: restricted __be16 degrades to integer
drivers/net/ethernet/cadence/macb_main.c:3458:69: warning: restricted __be16 degrades to integer
drivers/net/ethernet/cadence/macb_main.c:3511:21: warning: restricted __be16 degrades to integer
drivers/net/ethernet/cadence/macb_main.c:3511:50: warning: restricted __be16 degrades to integer

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/net/ethernet/cadence/macb_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 538d4c7e023b..56e202b74bd7 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3419,6 +3419,7 @@ static int macb_get_ts_info(struct net_device *netdev,
 }
 
 #define MACB_IPV4_MASK htonl(0xFFFFFFFF)
+#define MACB_PORT_MASK htons(0xFFFF)
 
 static void gem_enable_flow_filters(struct macb *bp, bool enable)
 {
@@ -3457,7 +3458,7 @@ static void gem_enable_flow_filters(struct macb *bp, bool enable)
 		else
 			t2_scr = GEM_BFINS(CMPBEN, 0, t2_scr);
 
-		if (enable && ((tp4sp_m->psrc == 0xFFFF) || (tp4sp_m->pdst == 0xFFFF)))
+		if (enable && ((tp4sp_m->psrc == MACB_PORT_MASK) || (tp4sp_m->pdst == MACB_PORT_MASK)))
 			t2_scr = GEM_BFINS(CMPCEN, 1, t2_scr);
 		else
 			t2_scr = GEM_BFINS(CMPCEN, 0, t2_scr);
@@ -3510,7 +3511,7 @@ static void gem_prog_cmp_regs(struct macb *bp, struct ethtool_rx_flow_spec *fs)
 	}
 
 	/* ignore both port fields if masking set in both */
-	if ((tp4sp_m->psrc == 0xFFFF) || (tp4sp_m->pdst == 0xFFFF)) {
+	if ((tp4sp_m->psrc == MACB_PORT_MASK) || (tp4sp_m->pdst == MACB_PORT_MASK)) {
 		/* 3rd compare reg - source port, destination port */
 		w0 = 0;
 		w1 = 0;
@@ -3524,7 +3525,7 @@ static void gem_prog_cmp_regs(struct macb *bp, struct ethtool_rx_flow_spec *fs)
 			/* only one port definition */
 			w1 = GEM_BFINS(T2DISMSK, 0, w1); /* 16-bit compare */
 			w0 = GEM_BFINS(T2MASK, 0xFFFF, w0);
-			if (tp4sp_m->psrc == 0xFFFF) { /* src port */
+			if (tp4sp_m->psrc == MACB_PORT_MASK) { /* src port */
 				w0 = GEM_BFINS(T2CMP, tp4sp_v->psrc, w0);
 				w1 = GEM_BFINS(T2OFST, IPHDR_SRCPORT_OFFSET, w1);
 			} else { /* dst port */
-- 
2.40.1


