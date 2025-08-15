Return-Path: <netdev+bounces-214046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD8AB27F3B
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 13:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61DF9621F0E
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 11:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A210288528;
	Fri, 15 Aug 2025 11:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QsXGLXZT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5AB2857CC
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 11:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755257579; cv=none; b=Pj5pPjzC114YzreWxMTvOd0Y5tgldPtTQVP+/1mUzfWW1C+37F0TGRCauCseGoQqVwQwvX0WB4Zqgji1Fuz1By9QS9y6vkDUUk4EHm2pOmknrBP8ianTf1VAL/m+8FUCgf6bUh2pQSmAtHi3pUsw2dpa2ZMbhs1xJated+j8CiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755257579; c=relaxed/simple;
	bh=6V1V70BQ4Q+AxwUdpm3kO/vfskRU+EpEesDYh5QUUUc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=mMqYlt8a0dvc1uFC3vjXRl0czC71lC6CrkZ8UP8G+gUY5CBswEdM8F+2ScqnqFLdm/GVGobSYAz9Ew1lx2z8kmJNMyqAZdjdMvMQehnhA3TKVMu0BNEJzkkuDJvdxs28g3wDj5V/QGb4AnWxe3kf79MJ6kVVWIbg3auTpmyxmSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QsXGLXZT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=L5QznbrBfDm0CPpP6OtoR4rI+fX53G8dzea0w5ykP4s=; b=QsXGLXZTbdNE7RhlJrrwjNzk26
	H4Bn+abraD56BuNOH4VeZZbgz/jv6LbiFIYQ6nYWs+/1KMSJSmjOhygJb23jBr8Czf1v358C3sSJR
	dBLJupkR86jVyo5qPX/m0xTWGmON7XpZWcgugcCviqMMQbBI4qS845d6J/FT7csXfRxCb9nZ7+iD9
	DPljddYQccMSf3WEd+ma5q5tAnkTq/pbS/FhQFolFrq1PL588EuIRjGOZDxXG+AJhKKmuBUfK9KE0
	zYTnXcV51G5wuJo6DaDy2UcMTE86nzoCXvmWpsqu6W8O4Yv7n9bpxzXCwhrWNShkS+OsjLnkgDJDE
	FpWUH3wg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60298 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1umsfy-000122-16;
	Fri, 15 Aug 2025 12:32:50 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1umsfF-008vKc-Kt; Fri, 15 Aug 2025 12:32:05 +0100
In-Reply-To: <aJ8avIp8DBAckgMc@shell.armlinux.org.uk>
References: <aJ8avIp8DBAckgMc@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 4/7] net: stmmac: remove unnecessary "stmmac: wakeup
 enable" print
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1umsfF-008vKc-Kt@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 15 Aug 2025 12:32:05 +0100

Printing "stmmac: wakeup enable" to the kernel log isn't useful - it
doesn't identify the adapter, and is effectively nothing more than a
debugging print. This information can be discovered by looking at
/sys/device.../power/wakeup as the device_set_wakeup_enable() call
updates this sysfs file.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index cd2fb92ac84c..58542b72cc01 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -816,7 +816,6 @@ static int stmmac_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 	}
 
 	if (wol->wolopts) {
-		pr_info("stmmac: wakeup enable\n");
 		device_set_wakeup_enable(priv->device, 1);
 		/* Avoid unbalanced enable_irq_wake calls */
 		if (priv->wol_irq_disabled)
-- 
2.30.2


