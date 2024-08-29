Return-Path: <netdev+bounces-123397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB86C964B55
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 18:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98AE12831F8
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 16:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0421B6525;
	Thu, 29 Aug 2024 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="e8VISQ1G"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DB11B530F;
	Thu, 29 Aug 2024 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948146; cv=none; b=QwF6q+JLR5lO1073QOw9xthkjMwHDxLvqdGu3kifMioUeaqYqZrVSVnMY0PUtVuJnIPC/HYNfwNANK6cVar6nkFByGJJVec4LsNYCXJwZUs5Fnk938o5qZDEJNsi+MaUeYwkYV51K7fqDkFSu5eYkcNl12NtYITsQY1D8MxTQN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948146; c=relaxed/simple;
	bh=BgPq7ornHtxD4EsfsDXjaOnsgM71ANY2Bm64NQPmdJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1Bj3JeB7vV86f0as0ozHmR8qQxma1lbVzJXvqFlLwNGaGyQGGXxsuD5PykO3NvTVdOVVbC1NbFzRlErc8F5w4SKx2qCDkYK6RWBFa451+OMAITcyIKyVGI72H6eU2uIQ1J1xFn+LwfAg+j1riJCMxZotTc6rPpuBjo5acwqSbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=e8VISQ1G; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9FAAFE000D;
	Thu, 29 Aug 2024 16:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724948137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dikhKHIOkEIPXGWcRLGhXSpACwbwEwFF3Ey6JTJR82I=;
	b=e8VISQ1GtrSQhVtoN35M4u1mxjTx/5DzcSIu7PiYLZkIiuNG3KSdnNRev4Ret56FRIBufd
	uiqPuyc92XKxrtpIYzqDDeCtkIgApV5rrznf+76RXQoU0NcbmJSKyY9VXIOwGJb9diGchZ
	bmsnSpkH3FYKvJxhPlRUZ3S0OYVPf9AOI6sroQCQGMUYoUdqnzLdCX/Tj3DCSx6o4nckQB
	khtaKznwsIGSSmY/sQWECcGZT+SgMHgkku3Y+mWPkPFN3VXsMNJTT75dFOAxiFxF8rnvOi
	ZaIBAUjYwkIiacSghaNrIEqQcp9posiw91ndY2rJNXLrgmCr+asCNx3aMpGF8g==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Herve Codina <herve.codina@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH net-next v2 3/7] net: ethernet: fs_enet: drop the .adjust_link custom fs_ops
Date: Thu, 29 Aug 2024 18:15:26 +0200
Message-ID: <20240829161531.610874-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240829161531.610874-1-maxime.chevallier@bootlin.com>
References: <20240829161531.610874-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

There's no in-tree user for the fs_ops .adjust_link() function, so we
can always use the generic one in fe_enet-main.

Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c | 7 +------
 drivers/net/ethernet/freescale/fs_enet/fs_enet.h      | 1 -
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
index 2b48a2a5e32d..caca81b3ccb6 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
@@ -649,12 +649,7 @@ static void fs_adjust_link(struct net_device *dev)
 	unsigned long flags;
 
 	spin_lock_irqsave(&fep->lock, flags);
-
-	if (fep->ops->adjust_link)
-		fep->ops->adjust_link(dev);
-	else
-		generic_adjust_link(dev);
-
+	generic_adjust_link(dev);
 	spin_unlock_irqrestore(&fep->lock, flags);
 }
 
diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet.h b/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
index 21c07ac05225..abe4dc97e52a 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
@@ -77,7 +77,6 @@ struct fs_ops {
 	void (*free_bd)(struct net_device *dev);
 	void (*cleanup_data)(struct net_device *dev);
 	void (*set_multicast_list)(struct net_device *dev);
-	void (*adjust_link)(struct net_device *dev);
 	void (*restart)(struct net_device *dev);
 	void (*stop)(struct net_device *dev);
 	void (*napi_clear_event)(struct net_device *dev);
-- 
2.45.2


