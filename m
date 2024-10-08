Return-Path: <netdev+bounces-133159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D74995217
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35991F25E00
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C395E1DFDAB;
	Tue,  8 Oct 2024 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Az0hbCkN"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C70D1DFD80
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398506; cv=none; b=Swhymi/FbyvUhmZBZBZhZcANWERhrQf+F275/KDoj21hiaj1w1g8P2u+V2XLQ3hJ80+3zb57CrNJswBP+bqVx2MOu9+OxB7n5HSDvjBNtt0s59rFRZxJkOaXRvgGzE1upxSTdg3hUM70s4W4RMugPmY5CMbV8BWoe4bMcjtzAYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398506; c=relaxed/simple;
	bh=NRzt4vEd+fFdZlNDJvoGsC4ACxSgKz9bpb67V6XnKq8=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Na3SqH0JuEgcpGhvdwo3uzjyN5Hhpq2jtZz20tQBCvTN3x5GmQdsqxn02tUV4jAajIw34mAfTxAomiuXkzL5Zz3GBSxNzLmNpONMbSpQ2f2L1woDsrZ5134Xuzyl9XCLIRltmOicXUFjNQ9jEaQuq4aXJpSwSw6l7TpqwsqsLN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Az0hbCkN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=E7usBhorOp87ClqjW9UTVeA+osR8rUTJnPMF5IMx074=; b=Az0hbCkNSDmHPMc18maKLPCqFv
	QOugYdIVLKmK8BpTTmn4auZT13uk877ZdeFXuVzaojnup23ucAHj0gEBcRERug/USl7RvX9OBiTZA
	xFCA4ViWWse7NLLegis2x1SGoR6Y9u0VWDOZlis50QUvocFRhLerHalUC+gPxbXI7ZU/hFrUGUAn+
	cf4XcjcdtqO98TYFly/Fh2Aa0h4xHRtcT8o3QHaOF1wtcx8N1WkVseHbGg70dcNjZGTaacukIcNdr
	JHG6PVy9j+8XNen3a3Biln4rrTiww0vEHvyyFJ60n6gK4LhUflLqIEipZJMtD/cmrgRLPcFLCLZ5F
	ZaIjBQ0Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57358 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1syBPB-0007cX-0f;
	Tue, 08 Oct 2024 15:41:40 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1syBP9-006Unb-Q3; Tue, 08 Oct 2024 15:41:39 +0100
In-Reply-To: <ZwVEjCFsrxYuaJGz@shell.armlinux.org.uk>
References: <ZwVEjCFsrxYuaJGz@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 2/3] net: dsa: mv88e6xxx: return NULL when no PCS is
 present
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1syBP9-006Unb-Q3@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 08 Oct 2024 15:41:39 +0100

Rather than returning an EOPNOTSUPP error pointer when the switch
has no support for PCS, return NULL to indicate that no PCS is
required.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index ddc832e33f4b..af02a9f27189 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -868,7 +868,7 @@ mv88e6xxx_mac_select_pcs(struct phylink_config *config,
 {
 	struct dsa_port *dp = dsa_phylink_to_port(config);
 	struct mv88e6xxx_chip *chip = dp->ds->priv;
-	struct phylink_pcs *pcs = ERR_PTR(-EOPNOTSUPP);
+	struct phylink_pcs *pcs = NULL;
 
 	if (chip->info->ops->pcs_ops)
 		pcs = chip->info->ops->pcs_ops->pcs_select(chip, dp->index,
-- 
2.30.2


