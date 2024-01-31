Return-Path: <netdev+bounces-67691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C53F6844989
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 22:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F6D285633
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 21:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AF038DDE;
	Wed, 31 Jan 2024 21:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="E/k/izPS"
X-Original-To: netdev@vger.kernel.org
Received: from mx09lb.world4you.com (mx09lb.world4you.com [81.19.149.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF7538FBC
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 21:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735635; cv=none; b=KKCnyX4mGiL4e7CMqJkG6dDqNQxfrvgYS160yd5v87FnRvJmTaB5VO6ZoeQedlLUd45d5sgjq9rwiPev94rz4/Kw2AEFjevoRVQE0hM8GzlX0NdE2iejf+5Nw2Cpc6YUwXaRDeQ8C61bLXz9L8x5u9BZVtjLDHSG83NSOeQNWUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735635; c=relaxed/simple;
	bh=0GzdDX6jlXGHnx6OlK0zBo02ZtRXI+osVI30Omwkta0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K5JVx/WjbI/NfpSfEDKgZ5VqGE/gG/BdvuUA2JeNB0VQKbyccGGJ5f7znttXqIvE3GAhn6Q8Db7aQhC0MRLJSNj/hQ+K8a5F2/r/ME8aC19YGz6GkrLflxg/dg4aZA7FpRXAnqJXYH6TeCcIp/acX/PZqplqbqg2+au3SVIZIxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=E/k/izPS; arc=none smtp.client-ip=81.19.149.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=R0NnrnDlYMiMd1rIVo/82qokjkeNumIX3+6whPk/xhM=; b=E/k/izPSv2/tnRQ9XyTJpi3H0n
	e3kHfVyR9X9Cw0PRiO9287XyhgEa6POS2diZ85Ic3weza1fK0zj+GfPujQ2z/3yEBLED8tffxfdXI
	jbWA8cOYanWJ39dz3rIrPEe1Rj7Y+1OMD54cOiMsO3o+hYyVXNqk5I7kakOMDZJ9+txs=;
Received: from [88.117.59.234] (helo=hornet.engleder.at)
	by mx09lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1rVHbW-0003oE-1j;
	Wed, 31 Jan 2024 21:54:42 +0100
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: [PATCH net-next] tsnep: Add helper for RX XDP_RING_NEED_WAKEUP flag
Date: Wed, 31 Jan 2024 21:54:34 +0100
Message-Id: <20240131205434.63409-1-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

Similar chunk of code is used in tsnep_rx_poll_zc() and
tsnep_rx_reopen_xsk() to maintain the RX XDP_RING_NEED_WAKEUP flag.
Consolidate the code to common helper function.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
---
 drivers/net/ethernet/engleder/tsnep_main.c | 23 +++++++++++-----------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index 11d49d08d017..332d561cb8a4 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -1275,6 +1275,14 @@ static int tsnep_rx_refill_zc(struct tsnep_rx *rx, int count, bool reuse)
 	return desc_refilled;
 }
 
+static void tsnep_xsk_rx_need_wakeup(struct tsnep_rx *rx, int desc_available)
+{
+	if (desc_available)
+		xsk_set_rx_need_wakeup(rx->xsk_pool);
+	else
+		xsk_clear_rx_need_wakeup(rx->xsk_pool);
+}
+
 static bool tsnep_xdp_run_prog(struct tsnep_rx *rx, struct bpf_prog *prog,
 			       struct xdp_buff *xdp, int *status,
 			       struct netdev_queue *tx_nq, struct tsnep_tx *tx)
@@ -1636,10 +1644,7 @@ static int tsnep_rx_poll_zc(struct tsnep_rx *rx, struct napi_struct *napi,
 		desc_available -= tsnep_rx_refill_zc(rx, desc_available, false);
 
 	if (xsk_uses_need_wakeup(rx->xsk_pool)) {
-		if (desc_available)
-			xsk_set_rx_need_wakeup(rx->xsk_pool);
-		else
-			xsk_clear_rx_need_wakeup(rx->xsk_pool);
+		tsnep_xsk_rx_need_wakeup(rx, desc_available);
 
 		return done;
 	}
@@ -1784,14 +1789,8 @@ static void tsnep_rx_reopen_xsk(struct tsnep_rx *rx)
 	 * first polling would be too late as need wakeup signalisation would
 	 * be delayed for an indefinite time
 	 */
-	if (xsk_uses_need_wakeup(rx->xsk_pool)) {
-		int desc_available = tsnep_rx_desc_available(rx);
-
-		if (desc_available)
-			xsk_set_rx_need_wakeup(rx->xsk_pool);
-		else
-			xsk_clear_rx_need_wakeup(rx->xsk_pool);
-	}
+	if (xsk_uses_need_wakeup(rx->xsk_pool))
+		tsnep_xsk_rx_need_wakeup(rx, tsnep_rx_desc_available(rx));
 }
 
 static bool tsnep_pending(struct tsnep_queue *queue)
-- 
2.39.2


