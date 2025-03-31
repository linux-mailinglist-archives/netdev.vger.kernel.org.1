Return-Path: <netdev+bounces-178400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD0FA76D91
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 21:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 306853A6240
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 19:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60445219A9D;
	Mon, 31 Mar 2025 19:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/0evjJl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE2D1B4138
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 19:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743450191; cv=none; b=jTkBM0PXRNdnEyEsA6eXlnFy2R658x/jNMT3d59kfqBRMTosqQQrDQHkWVjw197ngsOWMJIdq4zfDujceQ8R//yE2B3zY0xdU60Ev7EEMUZtfdhkPeR99O+CQ5CYKyw/OdE8wnKsDDeRxdSqKpHb2c/zlYi9nOcHzq5iTIvOCPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743450191; c=relaxed/simple;
	bh=JT7WjCTWPqx07GCgnSYyjt4N+4wmDRjWSCDjwmHT9n0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLngqrQtTvQjWeMmHTClQ5hdJPsa9WQSly4oHrKZaL0VM2SUj8GHjjDH1bY3CLetyJwr+6aNlfkaJlw2maaKfYWJFdOqO1duZzg61oyz3PKJOsxSqOlEKIyzrPM8IwFOdK0JhXObSUk56ONF0Ufi+EkfPCQbvGalqElh3R7fNTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/0evjJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2F9C4CEE3;
	Mon, 31 Mar 2025 19:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743450190;
	bh=JT7WjCTWPqx07GCgnSYyjt4N+4wmDRjWSCDjwmHT9n0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i/0evjJlFPkv3QbRq/IUQW3LgMTLbf8YaQmyEDIttVQLwws667yrtXjYLH3+vZQG3
	 t1rrLjCWIanNx6AifVsNLG5BTvYdh8XLHnlMZn+7nX+wxOaXeg3+ZSvDVsMeK6uo4R
	 2X1kSV9BsDSrk4t2qruxeb/rQV4n9a6Yy6Oiv/5VkUX/n5n09Xua6rgxLoZvkbyfWo
	 aqpKw3ujB75KIQfwvKm3iT3PB4O6qc4xYTMxreGzdthcZK9kI6pl1DWii2/agMXcB7
	 +V0ns7Nze25f2oQ8q3LO7QF7uH8VZ3zt+XeCdvCseC+P8p/602bWEcyOMWpLcsp5B/
	 2Ffa+DpKfh2+Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ap420073@gmail.com,
	asml.silence@gmail.com,
	almasrymina@google.com,
	dw@davidwei.uk,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 2/2] net: avoid false positive warnings in __net_mp_close_rxq()
Date: Mon, 31 Mar 2025 12:43:08 -0700
Message-ID: <20250331194308.2026940-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331194201.2026422-1-kuba@kernel.org>
References: <20250331194201.2026422-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit under Fixes solved the problem of spurious warnings when we
uninstall an MP from a device while its down. The __net_mp_close_rxq()
which is used by io_uring was not fixed. Move the fix over and reuse
__net_mp_close_rxq() in the devmem path.

Fixes: a70f891e0fa0 ("net: devmem: do not WARN conditionally after netdev_rx_queue_restart()")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/devmem.c          | 12 +++++-------
 net/core/netdev_rx_queue.c | 17 +++++++++--------
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index f2ce3c2ebc97..6e27a47d0493 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -116,21 +116,19 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 	struct netdev_rx_queue *rxq;
 	unsigned long xa_idx;
 	unsigned int rxq_idx;
-	int err;
 
 	if (binding->list.next)
 		list_del(&binding->list);
 
 	xa_for_each(&binding->bound_rxqs, xa_idx, rxq) {
-		WARN_ON(rxq->mp_params.mp_priv != binding);
-
-		rxq->mp_params.mp_priv = NULL;
-		rxq->mp_params.mp_ops = NULL;
+		const struct pp_memory_provider_params mp_params = {
+			.mp_priv	= binding,
+			.mp_ops		= &dmabuf_devmem_ops,
+		};
 
 		rxq_idx = get_netdev_rx_queue_index(rxq);
 
-		err = netdev_rx_queue_restart(binding->dev, rxq_idx);
-		WARN_ON(err && err != -ENETDOWN);
+		__net_mp_close_rxq(binding->dev, rxq_idx, &mp_params);
 	}
 
 	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index 556b5393ec9f..3e906c2950bd 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -154,17 +154,13 @@ void __net_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
 			const struct pp_memory_provider_params *old_p)
 {
 	struct netdev_rx_queue *rxq;
+	int err;
 
 	if (WARN_ON_ONCE(ifq_idx >= dev->real_num_rx_queues))
 		return;
 
 	rxq = __netif_get_rx_queue(dev, ifq_idx);
-
-	/* Callers holding a netdev ref may get here after we already
-	 * went thru shutdown via dev_memory_provider_uninstall().
-	 */
-	if (dev->reg_state > NETREG_REGISTERED &&
-	    !rxq->mp_params.mp_ops)
+	if (!rxq->mp_params.mp_ops)
 		return;
 
 	if (WARN_ON_ONCE(rxq->mp_params.mp_ops != old_p->mp_ops ||
@@ -173,13 +169,18 @@ void __net_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
 
 	rxq->mp_params.mp_ops = NULL;
 	rxq->mp_params.mp_priv = NULL;
-	WARN_ON(netdev_rx_queue_restart(dev, ifq_idx));
+	err = netdev_rx_queue_restart(dev, ifq_idx);
+	WARN_ON(err && err != -ENETDOWN);
 }
 
 void net_mp_close_rxq(struct net_device *dev, unsigned ifq_idx,
 		      struct pp_memory_provider_params *old_p)
 {
 	netdev_lock(dev);
-	__net_mp_close_rxq(dev, ifq_idx, old_p);
+	/* Callers holding a netdev ref may get here after we already
+	 * went thru shutdown via dev_memory_provider_uninstall().
+	 */
+	if (dev->reg_state <= NETREG_REGISTERED)
+		__net_mp_close_rxq(dev, ifq_idx, old_p);
 	netdev_unlock(dev);
 }
-- 
2.49.0


