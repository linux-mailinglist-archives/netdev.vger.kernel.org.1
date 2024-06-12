Return-Path: <netdev+bounces-102823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 338EE904F34
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 11:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A58BD1F25CE7
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 09:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3121216D9DD;
	Wed, 12 Jun 2024 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RK7Px/5z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5ZviqxXM"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5722D16DEB2
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 09:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718184300; cv=none; b=riBBlcSMOpZ82tktd4HoaL0pfjfUuPCej7+f0cIVOcsPZeBV2ITOWW0LatCvEXdpMcJ4lHueqwjfYHFLXlNRyrO+gR3jTqYp/VIZJ2PuvH+4p4bhovldq76QcjFLhyshG3R9/jOmwqBpGepUVooQwQ0oHZRk0XQvRbv6xRiaiZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718184300; c=relaxed/simple;
	bh=FGEm2thiLlo0TWFViCdkuo/ybAO1t9yroJGymBnCRRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Zy+WWZlGJm1C6Jcaev8baiTY2nqMJV+J1OCMUJ/aeuHTR1D6rD7GGuaGACl+mylzqdHR+PI7/TLRsSFNe9/uy2JWKJUajEXahus0StB96ehirVHTDwUZA9yFuw5dv35YmaQNLToyXU2UpHNnds7hwKptShQWltdMKeOR8GPyRWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RK7Px/5z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5ZviqxXM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718184296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D73eoZ+ww6rBa72YElmXEJrsMwkJILvJ3E1tcTzlOPg=;
	b=RK7Px/5zEa+QIfqukF4cznz3qk+5c7lVMS9zdsSZ0pqf2sFZWsgfuDnHFo0TKsibA4Z9Y7
	+fjcNwNxvk1eZQxBs5XfyoXMesAJeObINYYIDsmJxgaGJPfPb85xwg8BHBJK/BMHAF5N4g
	jpkoZQrsOrfs8sm86gw5Uf0t/ZrxLiP6AGC50XauA1GzBW2HVg60259rlKodu9iJrWq9Gb
	SjpbT30xRIFSRkSnk+KniT2FmaiLHhEoEY5rMXjK9Y1fMTEBs3ghEFhC9uuWhnzZPcKATm
	n6RfdxlIM9Da+kWW6NU3e2j2UphfhRFYSXXVKd6ZEh1YFSNYLGzO6NxB6DyKdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718184296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D73eoZ+ww6rBa72YElmXEJrsMwkJILvJ3E1tcTzlOPg=;
	b=5ZviqxXM6cwlRUAog+MIbJm463ZHrTr/HS0phchzqQJVZW2/3I0ul5ppJkRUOoRYQtV4Rp
	SatC8K0n4KOrvwBw==
Date: Wed, 12 Jun 2024 11:24:53 +0200
Subject: [PATCH iwl-next] igc: Get rid of spurious interrupts
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-igc_irq-v1-1-49763284cb57@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAGRpaWYC/x2N0QqDMAwAf0XyvEArQ9RfkTHaLGpAq0tkE8R/X
 93jcQd3gLEKG7TFAcofMVlSBn8rgMaQBkZ5ZYbSlXdXeY8y0FP0jUTkqY5U1Y2DXMdgjFFDovH
 q52Ab6yVW5V72/6ID+U6YeN/gcZ4/S5Ca0nwAAAA=
To: Jesse Brandeburg <jesse.brandeburg@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4064; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=FGEm2thiLlo0TWFViCdkuo/ybAO1t9yroJGymBnCRRo=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBmaWln1kS9mMTjJHV3UcJf5d5++VGC6yETktOu0
 +6QUV50QDOJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZmlpZwAKCRDBk9HyqkZz
 ginIEACwTVTymBjwo6guYrWNwhcNf+Yfg2EnHaCxBIbg7u76sv4oll2YI0ocaRoydt58ElH5Mrg
 r+wLAXqHY7tR+50HgNai1M0yIMzB6MWwyoiTCzzDcCpKkdxT5OVzPaBmoTUEhJB9WNVBh8Pk6PI
 pERIha+QoNIAc2lKk0VO5nYZ1I4IU7vl0QBiezRhNuW6gnkkxIqp3ebjeVF8T3s44F+SjHsWuru
 CuiLRI/1pLqWzrTJhszWbiB9Rmg+5+D2rzC2LQqGJh38crSmXd2w4PC5C9gUss07vlXeNUbR4Ng
 2bK+esUyOH89OVl7st5SnPBJW+SmIl4RgZvpx6BAzBmlOcjSes+9Nh86qyFxbvu3s+enQObfbX5
 4VsuJjfsu9tC3hobWJ0MuUO77aBrV+15+4SgIzCtuenWiEXNDkjEuFRGoVy8+2zPVeWDRErHPL/
 /zoLIZvYhchYXi07wamEqOSvEg/PA3eprQ25wLpz0q0OBs4t7Xlz3SbXB/qdFwR+/1Khmaqsp4U
 vhKN67oyTWsZ2kQDKCCYNau/V0b3+//AUMovYHl5nH2evUJixXwRIXqFuCN2CKSLOzBytDeAwzV
 wh1Bro/4CdnWX/rkP0jjhliZ+bUYoRnCKe/yc3Dv9ce3p6KI+QZPqkgCoL6mDB9WA9C5SDMu5Ej
 4qszEWMPj1dMiZQ==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

When running the igc with XDP/ZC in busy polling mode with deferral of hard
interrupts, interrupts still happen from time to time. That is caused by
the igc task watchdog which triggers Rx interrupts periodically.

That mechanism has been introduced to overcome skb/memory allocation
failures [1]. So the Rx clean functions stop processing the Rx ring in case
of such failure. The task watchdog triggers Rx interrupts periodically in
the hope that memory became available in the mean time.

The current behavior is undesirable for real time applications, because the
driver induced Rx interrupts trigger also the softirq processing. However,
all real time packets should be processed by the application which uses the
busy polling method.

Therefore, only trigger the Rx interrupts in case of real allocation
failures. Introduce a new flag for signaling that condition.

[1] - https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=3be507547e6177e5c808544bd6a2efa2c7f1d436

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/intel/igc/igc.h      |  1 +
 drivers/net/ethernet/intel/igc/igc_main.c | 24 ++++++++++++++++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 8b14c029eda1..7bfe5030e2c0 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -682,6 +682,7 @@ enum igc_ring_flags_t {
 	IGC_RING_FLAG_TX_DETECT_HANG,
 	IGC_RING_FLAG_AF_XDP_ZC,
 	IGC_RING_FLAG_TX_HWTSTAMP,
+	IGC_RING_FLAG_RX_ALLOC_FAILED,
 };
 
 #define ring_uses_large_buffer(ring) \
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 305e05294a26..e666739dfac7 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2192,6 +2192,7 @@ static bool igc_alloc_mapped_page(struct igc_ring *rx_ring,
 	page = dev_alloc_pages(igc_rx_pg_order(rx_ring));
 	if (unlikely(!page)) {
 		rx_ring->rx_stats.alloc_failed++;
+		set_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags);
 		return false;
 	}
 
@@ -2208,6 +2209,7 @@ static bool igc_alloc_mapped_page(struct igc_ring *rx_ring,
 		__free_page(page);
 
 		rx_ring->rx_stats.alloc_failed++;
+		set_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags);
 		return false;
 	}
 
@@ -2659,6 +2661,7 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 		if (!skb) {
 			rx_ring->rx_stats.alloc_failed++;
 			rx_buffer->pagecnt_bias++;
+			set_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags);
 			break;
 		}
 
@@ -2739,6 +2742,7 @@ static void igc_dispatch_skb_zc(struct igc_q_vector *q_vector,
 	skb = igc_construct_skb_zc(ring, xdp);
 	if (!skb) {
 		ring->rx_stats.alloc_failed++;
+		set_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &ring->flags);
 		return;
 	}
 
@@ -5811,11 +5815,23 @@ static void igc_watchdog_task(struct work_struct *work)
 	if (adapter->flags & IGC_FLAG_HAS_MSIX) {
 		u32 eics = 0;
 
-		for (i = 0; i < adapter->num_q_vectors; i++)
-			eics |= adapter->q_vector[i]->eims_value;
-		wr32(IGC_EICS, eics);
+		for (i = 0; i < adapter->num_q_vectors; i++) {
+			struct igc_ring *rx_ring = adapter->rx_ring[i];
+
+			if (test_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags)) {
+				eics |= adapter->q_vector[i]->eims_value;
+				clear_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags);
+			}
+		}
+		if (eics)
+			wr32(IGC_EICS, eics);
 	} else {
-		wr32(IGC_ICS, IGC_ICS_RXDMT0);
+		struct igc_ring *rx_ring = adapter->rx_ring[0];
+
+		if (test_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags)) {
+			clear_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &rx_ring->flags);
+			wr32(IGC_ICS, IGC_ICS_RXDMT0);
+		}
 	}
 
 	igc_ptp_tx_hang(adapter);

---
base-commit: bb678f01804ccaa861b012b2b9426d69673d8a84
change-id: 20240611-igc_irq-ccc1c8bc6890

Best regards,
-- 
Kurt Kanzenbach <kurt@linutronix.de>


