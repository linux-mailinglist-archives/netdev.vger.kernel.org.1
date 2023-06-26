Return-Path: <netdev+bounces-13910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DBF73DDBB
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 13:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0B381C2083A
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 11:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B11779F1;
	Mon, 26 Jun 2023 11:35:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBE32F34
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 11:35:20 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF85269A;
	Mon, 26 Jun 2023 04:35:04 -0700 (PDT)
From: Florian Kauer <florian.kauer@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1687779301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/lr3yIKV5fAO6P1uxCDLThWi2+XGH24iMml/rrOTEjA=;
	b=yNE5hLWIZsx3KBeSYvm5WTS3Htutyh2DeyItMLEpbDP8q0GrZO6R/WXrcvoUXL9p6hdAlo
	e6R4pmjJWaKjvL233HS8eEWVYrvk6fmKPZhJzjp9LObXnYrGGK3s3atheGkIKx1QXXgwDa
	1ZPMoalgmCTyUbQVqI2HN/6rGaIcMICx3FpzyTh4Vx123APY+CMkUG97NuMi8OsLhsobcw
	161GViXKfgGvW+Iblux2JXkKePzba9WqwpKN8X6oIFc2qD2c42kRCHcvaGd/OBefDVPHZI
	AwSJjMtcqA+jWWMgdzlK/l7HJbWWPe2YffcJGzUHPfOlWCKalh+y6E1cDwLIgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1687779301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/lr3yIKV5fAO6P1uxCDLThWi2+XGH24iMml/rrOTEjA=;
	b=RMzzaAPVzidc8n9yuCdJkO+h2kAprWob2yWDd7fLF8EQ4IXLkeWKO+Z8LqeRHSGyi+rXN6
	iAGGNEzgUNKHJEDA==
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vedang Patel <vedang.patel@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jithu Joseph <jithu.joseph@intel.com>,
	Andre Guedes <andre.guedes@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kurt@linutronix.de,
	florian.kauer@linutronix.de
Subject: [PATCH net] igc: Prevent garbled TX queue with XDP ZEROCOPY
Date: Mon, 26 Jun 2023 13:34:29 +0200
Message-Id: <20230626113429.24519-1-florian.kauer@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When the TX queue is used both by an application using
AF_XDP with ZEROCOPY as well as a second non-XDP application
generating high traffic, the queue pointers can get in
an invalid state. Most importantly, it can happen that
next_to_use points to an entry where next_to_watch != 0.

However, the implementation assumes at several places
that this is never the case, so if it does hold,
bad things happen. In particular, within the loop inside
of igc_clean_tx_irq(), next_to_clean can overtake next_to_use.
Finally, this prevents any further transmission via
this queue and it never gets unblocked or signaled.
Secondly, if the queue is in this garbled state,
the inner loop of igc_clean_tx_ring() will never terminate,
completely hogging a CPU core.

The reason is that igc_xdp_xmit_zc() reads next_to_use
before aquiring the lock, and writing it back
(potentially unmodified) later. If it got modified
before locking, the outdated next_to_use is written
pointing to an entry that was already used elsewhere
(and thus next_to_watch got written).

Fixes: 9acf59a752d4 ("igc: Enable TX via AF_XDP zero-copy")
Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Tested-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index eb4f0e562f60..2eff073ee771 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2791,7 +2791,7 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
 	struct netdev_queue *nq = txring_txq(ring);
 	union igc_adv_tx_desc *tx_desc = NULL;
 	int cpu = smp_processor_id();
-	u16 ntu = ring->next_to_use;
+	u16 ntu;
 	struct xdp_desc xdp_desc;
 	u16 budget;
 
@@ -2800,6 +2800,7 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
 
 	__netif_tx_lock(nq, cpu);
 
+	ntu = ring->next_to_use;
 	budget = igc_desc_unused(ring);
 
 	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget--) {
-- 
2.39.2


