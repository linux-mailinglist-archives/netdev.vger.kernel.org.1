Return-Path: <netdev+bounces-127011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BB69739E4
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 16:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A103628A20B
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 14:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2BC1922DC;
	Tue, 10 Sep 2024 14:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R8MtDX9W"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FA717C22F
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725978722; cv=none; b=KrdUX/DOUrVfMlwHLA6SCPc4FErW31/dpp6ZSk5TpFTlJ8p+6oqbF0bGHE06jc3Wk43dK8I3MqXcb+VWeR4JQkcWoBrTdOX7OEjyIBfpWYs6Feai9Qu2kOyMTqvRtSn6A1yQInu/cBihJcFKb+uHHM+W302a8pcwZozFnJAhY7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725978722; c=relaxed/simple;
	bh=3hcp8+pAra2wUh/heml2tFFmFimwTQeFtKzYEfoO9Rw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n3TDPvANCDs6jJ5wjy2zrVw2gSfwDrxYy9WBNpFEt/hhkGyT3yNm6Ct1PrOD2sYafPyuKzU77lIcCKcNWerh4ouTtott0Gd9GvkGeGywFZ5hvJEmVRbmIvwC1lqzbyeoaFCiYHvJAu9OWjvZQ0WycrWJc+4ORxchuqcxgVvm5v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R8MtDX9W; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725978718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+oMkdY5wNveZPHLOfaFU6K4sHgZemWN98P6jp40gR8Y=;
	b=R8MtDX9WqhGoceuOs3djsIcC71ayA4ENR/0KKxDtIiyAY1M/I/avGKeAxua5ycYGhgy9cN
	TgYTQJe3dKH4F7MmYvTY2Lk+ktVZwDuCS9mSrLUguXDR9J092vAku0dv/BTmxhSTM5Dr1Y
	yofbaBJmcp+urWt0Nv4i/yuTRvZgjfM=
From: Sean Anderson <sean.anderson@linux.dev>
To: Madalin Bucur <madalin.bucur@nxp.com>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net v2] net: dpaa: Pad packets to ETH_ZLEN
Date: Tue, 10 Sep 2024 10:31:44 -0400
Message-Id: <20240910143144.1439910-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When sending packets under 60 bytes, up to three bytes of the buffer
following the data may be leaked. Avoid this by extending all packets to
ETH_ZLEN, ensuring nothing is leaked in the padding. This bug can be
reproduced by running

	$ ping -s 11 destination

Fixes: 9ad1a3749333 ("dpaa_eth: add support for DPAA Ethernet")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- Fix the nonlinear varable becoming out-of-sync with the skb's
  linearization state by padding the packet before anything else.

 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index cfe6b57b1da0..4a55e521c17e 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2272,12 +2272,12 @@ static netdev_tx_t
 dpaa_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
 {
 	const int queue_mapping = skb_get_queue_mapping(skb);
-	bool nonlinear = skb_is_nonlinear(skb);
 	struct rtnl_link_stats64 *percpu_stats;
 	struct dpaa_percpu_priv *percpu_priv;
 	struct netdev_queue *txq;
 	struct dpaa_priv *priv;
 	struct qm_fd fd;
+	bool nonlinear;
 	int offset = 0;
 	int err = 0;
 
@@ -2287,6 +2287,13 @@ dpaa_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
 
 	qm_fd_clear_fd(&fd);
 
+	/* Packet data is always read as 32-bit words, so zero out any part of
+	 * the skb which might be sent if we have to pad the packet
+	 */
+	if (__skb_put_padto(skb, ETH_ZLEN, false))
+		goto enomem;
+
+	nonlinear = skb_is_nonlinear(skb);
 	if (!nonlinear) {
 		/* We're going to store the skb backpointer at the beginning
 		 * of the data buffer, so we need a privately owned skb
-- 
2.35.1.1320.gc452695387.dirty


