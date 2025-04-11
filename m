Return-Path: <netdev+bounces-181815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6588A8683D
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCBD99A07C9
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 21:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD0A298CDC;
	Fri, 11 Apr 2025 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SBGRG6N6"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F30298CC6
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 21:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744406836; cv=none; b=stwuGQhTA4laCc3q75RIY26BocuWZp2I43cXOxVNffnd7mwLuuZT2t1ItAEO/mjzyOozBzmqwiqo0V2KUUNYFSeWH02TazbPVnCIYytVVfO1XYfEUA8rITXA0UiA6xbW71ZY3bAbbxbv93SotNWa/2LS18jgkFmHyJtB5jLYHxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744406836; c=relaxed/simple;
	bh=ClbzMp0CdCN6fhO7emY87mUK8YRHJTvj/Om0jsJvcAM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ocLPhb3LTQP8pal9hzNXS5tQIqcyBtGmuDZlUG0ZudIC+vzEe/c9g9ZNaaW4VahB1ZLK+sZRPDGMuGbA45m0vXNGjfYvRWHNOYdgypTbqOz4DsJlR8H9FT7qsCk2ab+2jhy87oolFNXGLOPw0YWXsLkpzO23Te1aDINqdk1BHBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=SBGRG6N6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rlMcDZstaUV49AJpSfXd6u1CdqcwGzANCHEj3LjTlhI=; b=SBGRG6N6/4ngpdbGnMHacemO6M
	drroJVGBVAPXxzjbWIPMi6Cx7TC0uO/Fd0MULyIHa4y3rX9MCIPzbaK3V69+Rer1glZERrmzvOqL6
	UJUAOPO68K/lpZIZjVgENw5RwVDzs2exthH3f7xmxqNqU4lHrNMofxbq1PgG68I6uxLtr6PHTkF+i
	lo78N/6+ykeONtnDopywdBAJVTkhtSmJD44DgFRApXPFgHa6kwzQEp6bZsbqgUmjOAskAw3Ve/776
	MM0OGKMrQjY6UcXUwoJaUys6V2sT0bRugK9NDLh6GN2IQRpQpdwavD8beLtPYwV7LWCy62KFOf2jU
	IjbFEeXQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42458 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u3Lu1-0003ri-0M;
	Fri, 11 Apr 2025 22:27:09 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u3LtP-000COv-Ut; Fri, 11 Apr 2025 22:26:31 +0100
In-Reply-To: <Z_mI94gkKkBslWmv@shell.armlinux.org.uk>
References: <Z_mI94gkKkBslWmv@shell.armlinux.org.uk>
From: Russell King <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RFC net-next 1/5] net: mvpp2: add support for hardware
 timestamps
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u3LtP-000COv-Ut@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 11 Apr 2025 22:26:31 +0100

Add support for hardware timestamps in (e.g.) the PHY by calling
skb_tx_timestamp() as close as reasonably possible to the point that
the hardware is instructed to send the queued packets.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 416a926a8281..e3f8aa139d1e 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4439,6 +4439,8 @@ static netdev_tx_t mvpp2_tx(struct sk_buff *skb, struct net_device *dev)
 		txq_pcpu->count += frags;
 		aggr_txq->count += frags;
 
+		skb_tx_timestamp(skb);
+
 		/* Enable transmit */
 		wmb();
 		mvpp2_aggr_txq_pend_desc_add(port, frags);
-- 
2.30.2


