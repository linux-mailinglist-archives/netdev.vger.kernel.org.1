Return-Path: <netdev+bounces-178946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B45EA799BA
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 03:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E00A13AAB85
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 01:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413EB13AA2D;
	Thu,  3 Apr 2025 01:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnBKRvB+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7DD13632B
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 01:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743644052; cv=none; b=SoUKEe+bQi1dzlXA9Pt3pJ/Kbdy8ACvbmM7fO8tZMV0fDnN4pAe8K/1YKYuqBUDd78pnkG3vZ+huLt+Gs8BIErVj3vT+JsiDzwUo2BIQN491BKxwu6SwxqOIZ9mzmgfsf39qXZzZ4JxwRwOa8Oq6IXk59/vPjeX/leytNDPV5TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743644052; c=relaxed/simple;
	bh=znOxjPc9ccOJANveVd6W4b8JmwvyXYVrTYw99PP3z00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JIUMAu1eXUKIotFjZMbyKFVIy9JGWbpfDrTeQIOiIMOBPn+Y8HoLP2rJ42YrLva+722rfsTNb6QhefABgTvlSLaoD+I5fPBM6lNe/EsPm85alu2AYK1p5Wlth3H7XNXtwXEbmk74mjS+h1CJ+dgMzAEzIZeeYO/ExwhIf5dvhbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnBKRvB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A98C4CEEB;
	Thu,  3 Apr 2025 01:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743644051;
	bh=znOxjPc9ccOJANveVd6W4b8JmwvyXYVrTYw99PP3z00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lnBKRvB+BSAAYNUvn29Xllo5XWsowKoW5uOb3Z8DKdwIcOs+gMQlIymLuWDh/KGcj
	 k/NA7R/Edn8fTLuV2vpicTAV36rBqoUNMipDS45MpjCKwvO5W8eGCIeA97S8R/nzPv
	 Lr83J0nxEtSGsLPQ0auWlaxuZ0wuT0F0EXiARX2HKLTsDEcsk8KxMQ6YDsvMiz3rFB
	 ak55M9nFdgRDEbHXfPJjrdfNHXbTd4mMVpB67JrNuF9mNaJDyT6V/viykrVyE2uFxF
	 lNnPvjuvPo2MC1qCUclBosBqIwf5ASmjc4Otk0W7XH1J1OXisEtywUux8qnpahGQ5r
	 d8/K7kKIG95jA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ap420073@gmail.com,
	almasrymina@google.com,
	asml.silence@gmail.com,
	dw@davidwei.uk,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v2 2/2] net: avoid false positive warnings in __net_mp_close_rxq()
Date: Wed,  2 Apr 2025 18:34:05 -0700
Message-ID: <20250403013405.2827250-3-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403013405.2827250-1-kuba@kernel.org>
References: <20250403013405.2827250-1-kuba@kernel.org>
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

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Fixes: a70f891e0fa0 ("net: devmem: do not WARN conditionally after netdev_rx_queue_restart()")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - don't split the registration check, it may cause a race if we just
   bail on the registration state and not on the MP being present,
   as we drop and re-take the instance lock after setting reg_state
v1: https://lore.kernel.org/20250331194308.2026940-1-kuba@kernel.org
---
 net/core/devmem.c          | 12 +++++-------
 net/core/netdev_rx_queue.c |  4 +++-
 2 files changed, 8 insertions(+), 8 deletions(-)

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
index 556b5393ec9f..d126f10197bf 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -154,6 +154,7 @@ void __net_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
 			const struct pp_memory_provider_params *old_p)
 {
 	struct netdev_rx_queue *rxq;
+	int err;
 
 	if (WARN_ON_ONCE(ifq_idx >= dev->real_num_rx_queues))
 		return;
@@ -173,7 +174,8 @@ void __net_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
 
 	rxq->mp_params.mp_ops = NULL;
 	rxq->mp_params.mp_priv = NULL;
-	WARN_ON(netdev_rx_queue_restart(dev, ifq_idx));
+	err = netdev_rx_queue_restart(dev, ifq_idx);
+	WARN_ON(err && err != -ENETDOWN);
 }
 
 void net_mp_close_rxq(struct net_device *dev, unsigned ifq_idx,
-- 
2.49.0


