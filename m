Return-Path: <netdev+bounces-160136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0234A187A2
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 23:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 865FD3A478E
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 22:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7AF1F8AF3;
	Tue, 21 Jan 2025 22:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mErSIeIb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464CD1F8AE7
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 22:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737497727; cv=none; b=p7E1uYVF+Fo45hd+rhW17lamLeBCSIVfHs7aFC8J2EYIgH2n7pOSt0dO4uFOxVr3Mo1OAE3qbsIiAt83M7sbR1u11Kzlh6onQ5rQjUlB9GPySrOdcOYCC+fqD+Vff3eHXorDWdUAKONtpVciVs7mtfL0Cmwfl7xfZ2zeNlOvbec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737497727; c=relaxed/simple;
	bh=RVXd6jpXjaab+pAQiX0FG7P9WydgFoNtTYFZTuXU1EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KoaY/nslal8pJOhcMmkutitFTjvEm0Pj/thYyeOhwxczuxYRAdyo8/YTQSNt3oXRLGmSSuvxlmyGZZORmZIm59jT0lFF/lWd+/lJpBgEHzNcIjhX4EEufG12VbAxsIfkEhePcYA/NuJ1odcOvZeWIuKTI5Bni7vPD5Z7PvBDj4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mErSIeIb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A4EC4CEE7;
	Tue, 21 Jan 2025 22:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737497726;
	bh=RVXd6jpXjaab+pAQiX0FG7P9WydgFoNtTYFZTuXU1EM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mErSIeIbFlkso2GDewp9lJyYjCxXiAYrpiHbBHul034cUghMbVuZq1oH9a3kYi0i+
	 CJdjMNRuDols5oSxkGpIx4DfUCmj3rAPahm/lQ8k61DGn4RDrmHXixA7e9Sc/dcQoQ
	 RiHWmSk6Rvh0h+tRjd6FCw1jF+cFQH2JhRoaYtJcwy6nMcu999up4CvVB21d35FAGy
	 +B+bnwu02ncBkT3QBAfU8zVYcwd53Nwa6LexPXnQOftDBUXoSWkxqXsw6ecFK1hOsT
	 3lg176UeFgnxYgmfmQpdr6YAFlbPYFMf4RFxuTANuTej06VcNxEbl+s2aNpuUGZhaA
	 JySWVXhsnUE0g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	dan.carpenter@linaro.org,
	Jakub Kicinski <kuba@kernel.org>,
	rain.1986.08.12@gmail.com,
	zyjzyj2000@gmail.com,
	kuniyu@amazon.com,
	romieu@fr.zoreil.com
Subject: [PATCH net-next 3/7] eth: forcedeth: fix calling napi_enable() in atomic context
Date: Tue, 21 Jan 2025 14:15:15 -0800
Message-ID: <20250121221519.392014-4-kuba@kernel.org>
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

napi_enable() may sleep now, take netdev_lock() before np->lock.

Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/dcfd56bc-de32-4b11-9e19-d8bd1543745d@stanley.mountain
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: rain.1986.08.12@gmail.com
CC: zyjzyj2000@gmail.com
CC: kuniyu@amazon.com
CC: romieu@fr.zoreil.com
---
 drivers/net/ethernet/nvidia/forcedeth.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/nvidia/forcedeth.c b/drivers/net/ethernet/nvidia/forcedeth.c
index b00df57f2ca3..499e5e39d513 100644
--- a/drivers/net/ethernet/nvidia/forcedeth.c
+++ b/drivers/net/ethernet/nvidia/forcedeth.c
@@ -5562,6 +5562,7 @@ static int nv_open(struct net_device *dev)
 	/* ask for interrupts */
 	nv_enable_hw_interrupts(dev, np->irqmask);
 
+	netdev_lock(dev);
 	spin_lock_irq(&np->lock);
 	writel(NVREG_MCASTADDRA_FORCE, base + NvRegMulticastAddrA);
 	writel(0, base + NvRegMulticastAddrB);
@@ -5580,7 +5581,7 @@ static int nv_open(struct net_device *dev)
 	ret = nv_update_linkspeed(dev);
 	nv_start_rxtx(dev);
 	netif_start_queue(dev);
-	napi_enable(&np->napi);
+	napi_enable_locked(&np->napi);
 
 	if (ret) {
 		netif_carrier_on(dev);
@@ -5597,6 +5598,7 @@ static int nv_open(struct net_device *dev)
 			round_jiffies(jiffies + STATS_INTERVAL));
 
 	spin_unlock_irq(&np->lock);
+	netdev_unlock(dev);
 
 	/* If the loopback feature was set while the device was down, make sure
 	 * that it's set correctly now.
-- 
2.48.1


