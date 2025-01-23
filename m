Return-Path: <netdev+bounces-160442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DF6A19BE5
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 01:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE9816878C
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 00:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B9F9460;
	Thu, 23 Jan 2025 00:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNBm6oKt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F941E4A6
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 00:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737593126; cv=none; b=ZeFZGpW66+xDfm75vTAEmPrJO9x7iFiXYTluuwOfpjXAoXh0KAnPaYZuBAw40HxywI90PVRs+8z6bKfsYVsERqiixV49gK8WNWxsTWHrN92CxR2nOgpcMoPIYJAdbAVtKwpdGk2o3OEyMyZpvY0OvgqiP3AmheIdQ15811ypQnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737593126; c=relaxed/simple;
	bh=vGkBt8Pf/5Luo4P7MBonZccf2aO622i69T4f1Q47Ev0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUWPzjrsHtG8XSHeqowVZnkEiITVZx8LjGQBx8gl0lls/+OBRCLrXy+8+zKdfkG52ycjKOD58aEq6SHeErCvynmoIY6Yu2h4x4ZidsNCBGsbfXkggbp015oKaddm5EHgygHeOSkfvfT/tOolFZKxDJ9e0Z9X1OHoeF5uSC4NPVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNBm6oKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DB8C4CEE1;
	Thu, 23 Jan 2025 00:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737593126;
	bh=vGkBt8Pf/5Luo4P7MBonZccf2aO622i69T4f1Q47Ev0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KNBm6oKtScZc+rMe+d2nUbF+WjzKszyyZvaDeQu3EvYld4rME2G6m2frwwd9GbQsn
	 pZnCn3nS8Ig3g8Nf+vQdia6hebombwSnxcMlRMrlhBbM/d0sqKZnGjEIwiYcavtOjJ
	 175zhRAPrgkzY2+3y9v1UqNdc5SVD0z8tuPTpkMqjqejQ8SYF4TNbW/X9wWhzVLC98
	 FgWTohyBV1iEbj7mYMhYhXEb858oeDHaPS7xxrWLOmkGA2Zn+thVrr+3th0+gHzn6u
	 jjE+Blr4aySXYem2T08EStg4wyBLoaMxp2OXrvh6ygD7X2uM+BTpowPV3J+BCX8Yz0
	 53g300IkwoUEg==
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
Subject: [PATCH net v2 4/7] eth: 8139too: fix calling napi_enable() in atomic context
Date: Wed, 22 Jan 2025 16:45:17 -0800
Message-ID: <20250123004520.806855-5-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250123004520.806855-1-kuba@kernel.org>
References: <20250123004520.806855-1-kuba@kernel.org>
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
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


