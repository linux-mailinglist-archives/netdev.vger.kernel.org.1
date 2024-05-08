Return-Path: <netdev+bounces-94594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5B18BFF35
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 15:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14EB71C22A05
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 13:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB40A84FC5;
	Wed,  8 May 2024 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaQUOyRi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9744284FBC
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175907; cv=none; b=fvE95FeHjbrYOTLmCr2Habxm/PnKWiBKlaCoEr7ZiFFx++idZV8BYUPTr102+xuzRQhkFqGBsHVKWc9g0YbAa67t/jq5cztnd1j5EBHu1/d/D9B5ywf4pe05DnzxLC5lAXD6kviWonfTU2nBvBh8QhM13k8IxFRgAzEiTaI1Vp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175907; c=relaxed/simple;
	bh=F0nL0zgBsydiONR9YZ6PzSZCDngoX1GDUDMpm5fpygk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AOhnpjGgicbuQiR7CMxhFLHlNcHK12GIGsgRf5qcv35NcE1nARJQQZ/wk/DlFirk0O47NPJEPEBU0BTXKjsvF9E7ChetqpvRgAKUEJslg2DaCQocgMUtQlMxBiupe/6uPs+fvwkgESh8l6QyIVoJ2IuuTirK4rwFn6T7QB9nmYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaQUOyRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C278EC2BD11;
	Wed,  8 May 2024 13:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715175907;
	bh=F0nL0zgBsydiONR9YZ6PzSZCDngoX1GDUDMpm5fpygk=;
	h=From:To:Cc:Subject:Date:From;
	b=kaQUOyRi160d5DTuaTIMK1KpaKcufAKV+QHIs2Jb/YDoaDc9tzLYoi/QH09dtrKaN
	 8sguv95UvauwWlH0VsR6JuHTcwTT5CYx4ZhtmIoAhyqTJ81CJGzNuTeBtsUwq3sJih
	 /73bHGngD90iP1gVTpmYh+2gUbymq/KyfRFD9p59bxQHaT3a4BNNu0HajrtZylTu83
	 87XUiTgfnwEYTPK5c9JIqoiAwRi8o565mLG06zQnBp4wODhdk+dVuyBc62YLUSQtyX
	 R9qal5/nXN5azj2wO74jkotXx7GFGbT3Ut9q5we9Z/eCGpCgLcNhtl7rmMNe3jVORA
	 GWCZRVMI9Rmjw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Erhard Furtner <erhard_f@mailbox.org>,
	robh@kernel.org,
	elder@kernel.org,
	wei.fang@nxp.com,
	bhupesh.sharma@linaro.org,
	benh@kernel.crashing.org
Subject: [PATCH net] eth: sungem: remove .ndo_poll_controller to avoid deadlocks
Date: Wed,  8 May 2024 06:45:04 -0700
Message-ID: <20240508134504.3560956-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Erhard reports netpoll warnings from sungem:

  netpoll_send_skb_on_dev(): eth0 enabled interrupts in poll (gem_start_xmit+0x0/0x398)
  WARNING: CPU: 1 PID: 1 at net/core/netpoll.c:370 netpoll_send_skb+0x1fc/0x20c

gem_poll_controller() disables interrupts, which may sleep.
We can't sleep in netpoll, it has interrupts disabled completely.
Strangely, gem_poll_controller() doesn't even poll the completions,
and instead acts as if an interrupt has fired so it just schedules
NAPI and exits. None of this has been necessary for years, since
netpoll invokes NAPI directly.

Fixes: fe09bb619096 ("sungem: Spring cleaning and GRO support")
Reported-and-tested-by: Erhard Furtner <erhard_f@mailbox.org>
Link: https://lore.kernel.org/all/20240428125306.2c3080ef@legion
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: robh@kernel.org
CC: elder@kernel.org
CC: wei.fang@nxp.com
CC: bhupesh.sharma@linaro.org
CC: benh@kernel.crashing.org
---
 drivers/net/ethernet/sun/sungem.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
index 9bd1df8308d2..d3a2fbb14140 100644
--- a/drivers/net/ethernet/sun/sungem.c
+++ b/drivers/net/ethernet/sun/sungem.c
@@ -949,17 +949,6 @@ static irqreturn_t gem_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-#ifdef CONFIG_NET_POLL_CONTROLLER
-static void gem_poll_controller(struct net_device *dev)
-{
-	struct gem *gp = netdev_priv(dev);
-
-	disable_irq(gp->pdev->irq);
-	gem_interrupt(gp->pdev->irq, dev);
-	enable_irq(gp->pdev->irq);
-}
-#endif
-
 static void gem_tx_timeout(struct net_device *dev, unsigned int txqueue)
 {
 	struct gem *gp = netdev_priv(dev);
@@ -2839,9 +2828,6 @@ static const struct net_device_ops gem_netdev_ops = {
 	.ndo_change_mtu		= gem_change_mtu,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address    = gem_set_mac_address,
-#ifdef CONFIG_NET_POLL_CONTROLLER
-	.ndo_poll_controller    = gem_poll_controller,
-#endif
 };
 
 static int gem_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
-- 
2.45.0


