Return-Path: <netdev+bounces-163217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F282AA299A5
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 20:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5DB18865C8
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 19:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753501FF1DE;
	Wed,  5 Feb 2025 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTWKDSHV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F80C1FF1BA
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 19:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782112; cv=none; b=c+eEDX65PSflWInvPbbowI851NR8ov6L49/5YWnl/E7OKabxgYowd9UZyU5JbKWDSh3z9KusrUvtsMYQlYBmsYhdluMnrwQyepuJApehmqaDcM8MGZkUh1FoOycVcHtb1AuZSm0DWnc6B4CrwX7nbGAIq6A/yXKyEsg33TJ64II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782112; c=relaxed/simple;
	bh=nYFnn35OV+y6c7HmVeg/IqZsbDvP2fo/4hfsVxGvARA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TeKe6dtuyQL17YrMNkgiit+32jWpwQ9BzbM04IbDcY3inv04eJy4Okwv6Ei8eOmvGvDtNT3vLnzk6LHK6ywjQXOqLPiyjdMnQfb1dWfQ/0ppoMMAck2eq9zV09tWbesk2bTgULPpW3h/kavpMn8QDKquYfcrrBCfQzhOpADjz5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTWKDSHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95405C4CEE4;
	Wed,  5 Feb 2025 19:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738782111;
	bh=nYFnn35OV+y6c7HmVeg/IqZsbDvP2fo/4hfsVxGvARA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gTWKDSHVv2tZ4u4xPUjzb0d8RqDM9bRIHnDhaZGZ4+1G1N7Z/Wuo46KYnxw5G/Pkt
	 ByKP1cm5U/pwlDBO4w0vMmamMcmQDDB8yviNojBQY6mFS4wj+wUt5hV8ZLNfTdyt1c
	 1ED2JOQtPIyOkXx+qlJF7Y6kHasVndoRMItc2Wuk9RkqXKj9J9do1sPn5W+S+FT8YM
	 F010XyxlBp8WuA69TpPhpvg+2TtV/e2saG/E8vEdIEBt49PQmaswbxYRWB99lmmM9s
	 Lw4SRoBhfdPbS7YOaCRBuadxF2JAU6CA2UV5fUfF/JqFvx+CjNRGaOyv+6nlFJED9R
	 6NNFooRzUpbbQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	almasrymina@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/3] net: devmem: don't call queue stop / start when the interface is down
Date: Wed,  5 Feb 2025 11:01:30 -0800
Message-ID: <20250205190131.564456-3-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205190131.564456-1-kuba@kernel.org>
References: <20250205190131.564456-1-kuba@kernel.org>
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


