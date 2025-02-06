Return-Path: <netdev+bounces-163697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C2DA2B605
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 23:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3239B3A6437
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 22:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A8023716E;
	Thu,  6 Feb 2025 22:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axr29uOb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F0D22FF5C
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 22:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738882614; cv=none; b=OCazwX7iYfxIceLax/lGaOO2N4GmUbdoVL5ny2FOde1e9fT6ZHvSid++S8e6KzAbDirWgI3pBxdzca39gideHzb/StHQPpbxVvrTVTEAC7IvbW7i4DBOmVZjn8P7eqxd9AsAzdywfefs2RtUIUyDqrEHCrnmDWTorlr+pjwj8dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738882614; c=relaxed/simple;
	bh=nYFnn35OV+y6c7HmVeg/IqZsbDvP2fo/4hfsVxGvARA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWhDtZbZgczNeAFZ03Q9KWtVMqwJEL5N2oHdAUhx66tLJNPPDYGSirFtBZhJg9qC8L6toIGmlrDmN+O0XYg8dnAfgy1RxHg/c28fuMA74qDcUzAummDekCW79/ihfqvHPrlr2SHdwhbu6YNzhYjp3FrF9aAf2TRMpwKB8wrQ4VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axr29uOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AB4C4CEE0;
	Thu,  6 Feb 2025 22:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738882613;
	bh=nYFnn35OV+y6c7HmVeg/IqZsbDvP2fo/4hfsVxGvARA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=axr29uObO5S9D/0AuEHD22qoSC3T6cBXCdMNS/CXjFF7Sq1GA72frfzknbat7F0m0
	 qScbsNLCA0IlnvK5FJLAB1BiO38Ilvpnuom/8ZtqWR+SL1p/gH/EPEH3QhM/7K2LD+
	 ZrOWTaRRcnoLmp7ED//CGAxUK2KxLEzR6R/MUPFSQ7I/rluKeMjB8FkOzTafeAwtFN
	 GShaRPLbHz8Lu+WXqf2ifjG6W/T22CY4ZGq/uekeX6iB9tFHi886nPL6fknUcVq8OH
	 uSSa61xiXk8S+R0VMrVZrFR4MkN4elAYgWKNDvCZEWfwVvnTRjgGitXVh4R2JqO6dK
	 UdKjPtGCc0h4g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	almasrymina@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 2/4] net: devmem: don't call queue stop / start when the interface is down
Date: Thu,  6 Feb 2025 14:56:36 -0800
Message-ID: <20250206225638.1387810-3-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206225638.1387810-1-kuba@kernel.org>
References: <20250206225638.1387810-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We seem to be missing a netif_running() check from the devmem
installation path. Starting a queue on a stopped device makes
no sense. We still want to be able to allocate the memory, just
to test that the device is indeed setting up the page pools
in a memory provider compatible way.

This is not a bug fix, because existing drivers check if
the interface is down as part of the ops. But new drivers
shouldn't have to do this, as long as they can correctly
alloc/free while down.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/netdev_queues.h |  4 ++++
 net/core/netdev_rx_queue.c  | 16 ++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index b02bb9f109d5..73d3401261a6 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -117,6 +117,10 @@ struct netdev_stat_ops {
  *
  * @ndo_queue_stop:	Stop the RX queue at the specified index. The stopped
  *			queue's memory is written at the specified address.
+ *
+ * Note that @ndo_queue_mem_alloc and @ndo_queue_mem_free may be called while
+ * the interface is closed. @ndo_queue_start and @ndo_queue_stop will only
+ * be called for an interface which is open.
  */
 struct netdev_queue_mgmt_ops {
 	size_t			ndo_queue_mem_size;
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index a5813d50e058..5352e0c1f37e 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -37,13 +37,17 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 	if (err)
 		goto err_free_new_queue_mem;
 
-	err = qops->ndo_queue_stop(dev, old_mem, rxq_idx);
-	if (err)
-		goto err_free_new_queue_mem;
+	if (netif_running(dev)) {
+		err = qops->ndo_queue_stop(dev, old_mem, rxq_idx);
+		if (err)
+			goto err_free_new_queue_mem;
 
-	err = qops->ndo_queue_start(dev, new_mem, rxq_idx);
-	if (err)
-		goto err_start_queue;
+		err = qops->ndo_queue_start(dev, new_mem, rxq_idx);
+		if (err)
+			goto err_start_queue;
+	} else {
+		swap(new_mem, old_mem);
+	}
 
 	qops->ndo_queue_mem_free(dev, old_mem);
 
-- 
2.48.1


