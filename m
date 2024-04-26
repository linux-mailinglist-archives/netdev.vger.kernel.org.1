Return-Path: <netdev+bounces-91763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A110E8B3C9E
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 18:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0826FB275ED
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 16:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A5E15623A;
	Fri, 26 Apr 2024 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JxRkDy/p"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE2F149C44
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714148281; cv=none; b=kAb4hV9TDPae1SMuyzSGSkrqOFn62hQxOyVCoWPf2/on4ZhIIFEAOhyZnEr8EZkmyhtTLHs2fmD3ZFLi86a4xtCnKQhmRHRVWb1RV29iWnecoFWJLE166r20oC5/L9BFjxX1dXxn+6WMoGdNO9qkeaZLVrGV3QeaWdh+TGr1Q1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714148281; c=relaxed/simple;
	bh=wqF0fNhuc0Jd1WOuGcLy5Cn/WskSKtZYWlWKJDPnXNo=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=WSVvZFTNxSaAC+5XV4/58ZyUaoSf31+tMf8VLCPg5DlRwj84lBIgw9XGqc+fjawARvwijsCcU5lDfCrk/RBRyLPyDBOg72QrwOfy8vS5rjVDbA0LUMmq9y+kIVRcX7XPGFRG7mmnNs8EYOsBRhlk6NMmwAXm7OyqzeRG0fpRUCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=JxRkDy/p; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ER7i8rKFLXX+EkSxgVuIuGCpltNNHVR5zAivD0WL6Tk=; b=JxRkDy/pE9KNbSu6+cigQ0kTqR
	+jFhAfzqvgPNVro0pfvAEL0DhGe9qgiMHSpFV6RT3BlftRw6Zyi1hS1A5VqFK9Q7KUnO9FVbdQXYv
	Nq1igqPHqWhyuZ4184EpI/kKuWLkxsbVQSPqc0Gx5XdhqQb5ZY0mIuZb7j+Og5Hwacs9P7/g1y7V8
	VEAqOSbkoeJPiwXwwneP/Q1Iigfqbouru3iIMK3KSgHmLJ24qRdaOvdjFJr7/onIPBwkNUvh5vYpf
	F5p2SoN49+J3dYO+4ScuooX8fE6UywzBcVuMsAKE7pJIJme/wSFuY/GZhng3UN2esnGtuKv4djU2C
	85Kgoqpw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35632 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1s0OGm-0000VZ-0K;
	Fri, 26 Apr 2024 17:17:52 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1s0OGn-009hgf-G6; Fri, 26 Apr 2024 17:17:53 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: mvpp2: use phylink_pcs_change() to report PCS
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
Message-Id: <E1s0OGn-009hgf-G6@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 26 Apr 2024 17:17:53 +0100

Use phylink_pcs_change() when reporting changes in PCS link state to
phylink as the interrupts are informing us about changes to the PCS
state.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 23adf53c2aa1..19253a0fb4fe 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3434,12 +3434,13 @@ static void mvpp2_isr_handle_ptp(struct mvpp2_port *port)
 		mvpp2_isr_handle_ptp_queue(port, 1);
 }
 
-static void mvpp2_isr_handle_link(struct mvpp2_port *port, bool link)
+static void mvpp2_isr_handle_link(struct mvpp2_port *port,
+				  struct phylink_pcs *pcs, bool link)
 {
 	struct net_device *dev = port->dev;
 
 	if (port->phylink) {
-		phylink_mac_change(port->phylink, link);
+		phylink_pcs_change(pcs, link);
 		return;
 	}
 
@@ -3472,7 +3473,7 @@ static void mvpp2_isr_handle_xlg(struct mvpp2_port *port)
 	if (val & MVPP22_XLG_INT_STAT_LINK) {
 		val = readl(port->base + MVPP22_XLG_STATUS);
 		link = (val & MVPP22_XLG_STATUS_LINK_UP);
-		mvpp2_isr_handle_link(port, link);
+		mvpp2_isr_handle_link(port, &port->pcs_xlg, link);
 	}
 }
 
@@ -3488,7 +3489,7 @@ static void mvpp2_isr_handle_gmac_internal(struct mvpp2_port *port)
 		if (val & MVPP22_GMAC_INT_STAT_LINK) {
 			val = readl(port->base + MVPP2_GMAC_STATUS0);
 			link = (val & MVPP2_GMAC_STATUS0_LINK_UP);
-			mvpp2_isr_handle_link(port, link);
+			mvpp2_isr_handle_link(port, &port->pcs_gmac, link);
 		}
 	}
 }
-- 
2.30.2


