Return-Path: <netdev+bounces-91766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFB48B3CA1
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 18:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1FD1C21790
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 16:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2133B152DE6;
	Fri, 26 Apr 2024 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ytlTYlGB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EFC152511
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714148300; cv=none; b=tx+p4YBO8z10TrpKo6vNkxqJCjuqOuz1r7mldmvLH+mDbEfvkUMyJAIUH7Z9wzmhFeocy3V2m/Ja2ATWMvUGoWPFVijEnYbKJsdI7TA5iT3CqZdz5OpuP4otNVWOIPevFJJjypIapt/qC1NIT8LGhmnAsnki/dz7ypqfMoXGtTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714148300; c=relaxed/simple;
	bh=XPBDQnql6n2Ehr8o2ta6RvA26spl3TlE1dEDdlT49uk=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=TlSxY2N/auxAx6IviPRcwLfkYMSUApMkOeI8vQFVoKWhIt1dAykT1abwQmE4gGzJtQ9ZZKCf2ujqtniA8OW+XBfuG5JrDGstYKWGM2vn8RM/5TCs8wIx8s7L87Xp+fZJK+nbIGpi0zixE5jlg5oSUthkMDswEjA1CJcB0dcFE8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ytlTYlGB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/0R7kJXf7H8qiIvab3DxduespkkRFsxRkgwBqUJY7m0=; b=ytlTYlGBXIo8FXtEV4QlkXaQxs
	sSAE4k2zfSFUih2QlAzudsURlSQazjZvd2+ZNx9ADmw5+BK83xOnMHE7oM8OBlI793AXisJQZXhWB
	XzwKjgu0JVQ7D9xwWCbyMF9j2CY+ptNTafhKA3hXSsnhNyltjIkMAmOGFi7GnE+RIe5FG3E+EtOl2
	0sb6JuokjGF9XeUOsmVQnm05Q4qfLnrPlw8quvw0cPMzXrP+OgP6nCO2cNPH2JdLxZhYzqpbLjwfG
	PGK5ze+w/N6pyuxBsimFSw3GmahezNr/2rz9MlihSQuBreFTdoVGk86V1Ld9IpH5D1PopPMhfJGvy
	PR8Bgkdg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38516 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1s0OH1-0000W6-1c;
	Fri, 26 Apr 2024 17:18:07 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1s0OH2-009hgx-Qw; Fri, 26 Apr 2024 17:18:08 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: txgbe: use phylink_pcs_change() to report PCS
 link change events
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1s0OH2-009hgx-Qw@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 26 Apr 2024 17:18:08 +0100

Use phylink_pcs_change() when reporting changes in PCS link state to
phylink as the interrupts are informing us about changes to the PCS
state.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 93295916b1d2..5f502265f0a6 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -302,7 +302,7 @@ irqreturn_t txgbe_link_irq_handler(int irq, void *data)
 	status = rd32(wx, TXGBE_CFG_PORT_ST);
 	up = !!(status & TXGBE_CFG_PORT_ST_LINK_UP);
 
-	phylink_mac_change(wx->phylink, up);
+	phylink_pcs_change(&txgbe->xpcs->pcs, up);
 
 	return IRQ_HANDLED;
 }
-- 
2.30.2


