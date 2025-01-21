Return-Path: <netdev+bounces-160137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D97A187A3
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 23:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F153A83FD
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 22:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1801F8EE5;
	Tue, 21 Jan 2025 22:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzzuWPen"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C838A1F8AFF
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 22:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737497727; cv=none; b=s3Y5gK1HNCiE3xsVJia/fmuVZ/fBXvF+iPeqZZiGkxu/r/rNd85oi08YDsoraKw8+CjdWPC00fIvVFfgyux/R9NBpkr4Wy0ZEdFYAfNwzBIGGpREVXulwNoS6kRxll4EzVFaomjiSKXN+q7AUy+3fe1EKIYTwIoHa4HP726cSHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737497727; c=relaxed/simple;
	bh=u17lnN/Hc380OVmm9BFmck7oiK1HBGfeNvmA5exOGME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRAh9qiC2mKDVtXtUG2iehJ2a4CqrcytgaL6z48hfNwrG8LaRBCCwy79GSmDFzqLmfRW5tiXGMLP7AS/zTH+D1gtjr449297e71cZWADQZkjJsOBJH/46npwCIebywwuQk0q2LE7IAeFHdfdsj4UAtbj8hjHVLLy2eQhU8ZJRwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzzuWPen; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46CCC4CEE6;
	Tue, 21 Jan 2025 22:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737497727;
	bh=u17lnN/Hc380OVmm9BFmck7oiK1HBGfeNvmA5exOGME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HzzuWPenNMEpWWvQ5wHGjmvZAIUr1kzvN8mL5UH3NmsapD13FJ84/uEmthQe2ExSR
	 jGoKo8kd2lfH7YvmPT/0oeg6GLZoBhTRL7WPyX28RB0tXEmMqgXNTfcJyWrc2iYt8A
	 Yay7EnYNjF9c77lIZm5lNqnk4DTwWnzxrxnWqjDf5MDDvhJwuTlOYT5X3g1DgxIU/p
	 rj8hw2oB4STmWML8wBtS4MUm89CvlRMA8IHXWFePB5Fp1VfMtY7KhqkjoByZQxwWBq
	 15B6U/+ZLjFZPs3XQkGXdV99/4gxh8REyTT/AffBzJkidqu+4i4RYWxQjNmb3OnJuc
	 zS3OMXtnyuxkA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	dan.carpenter@linaro.org,
	Jakub Kicinski <kuba@kernel.org>,
	romieu@fr.zoreil.com,
	kuniyu@amazon.com
Subject: [PATCH net-next 4/7] eth: 8139too: fix calling napi_enable() in atomic context
Date: Tue, 21 Jan 2025 14:15:16 -0800
Message-ID: <20250121221519.392014-5-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250121221519.392014-1-kuba@kernel.org>
References: <20250121221519.392014-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

napi_enable() may sleep now, take netdev_lock() before tp->lock and
tp->rx_lock.

Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/dcfd56bc-de32-4b11-9e19-d8bd1543745d@stanley.mountain
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: romieu@fr.zoreil.com
CC: kuniyu@amazon.com
---
 drivers/net/ethernet/realtek/8139too.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/8139too.c b/drivers/net/ethernet/realtek/8139too.c
index 9ce0e8a64ba8..a73dcaffa8c5 100644
--- a/drivers/net/ethernet/realtek/8139too.c
+++ b/drivers/net/ethernet/realtek/8139too.c
@@ -1684,6 +1684,7 @@ static void rtl8139_tx_timeout_task (struct work_struct *work)
 	if (tmp8 & CmdTxEnb)
 		RTL_W8 (ChipCmd, CmdRxEnb);
 
+	netdev_lock(dev);
 	spin_lock_bh(&tp->rx_lock);
 	/* Disable interrupts by clearing the interrupt mask. */
 	RTL_W16 (IntrMask, 0x0000);
@@ -1694,11 +1695,12 @@ static void rtl8139_tx_timeout_task (struct work_struct *work)
 	spin_unlock_irq(&tp->lock);
 
 	/* ...and finally, reset everything */
-	napi_enable(&tp->napi);
+	napi_enable_locked(&tp->napi);
 	rtl8139_hw_start(dev);
 	netif_wake_queue(dev);
 
 	spin_unlock_bh(&tp->rx_lock);
+	netdev_unlock(dev);
 }
 
 static void rtl8139_tx_timeout(struct net_device *dev, unsigned int txqueue)
-- 
2.48.1


