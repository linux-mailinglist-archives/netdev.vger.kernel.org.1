Return-Path: <netdev+bounces-161374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B15A20D8B
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652E63A44E3
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5243F1D61B9;
	Tue, 28 Jan 2025 15:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jf5RPJXm"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EEC1D7E5C
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079293; cv=none; b=qiDqB2CyJ6WqZaLA6+dWOhhzom0H94xS3AferqXoPODwgDRlKAr6A1caExE2lzcIsGAu8257zronpjerWTbnhiLuHJvHMWwucOyi+rCabjaztkdPJs16YIYQBolwk6H50RSVfaVUTBCQUT+4dhPST29HyWv968DXZnODmw/XbNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079293; c=relaxed/simple;
	bh=FlnTT8+vKXxq0u9C0gjUSaAOgSfohUh82yFgJOybJ8k=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=R8ZJHn5TY5Yc3CQXMnW/ghuS9b3eEODzTTDD5ATljH9IkV4OWFPTB7gP5V1ljkH+uUkvEciYdKHMd5cQti+1Lb8j6PREWqF3fX4j9m8q7z4kU6SupR2kG4V/jVt/+iloM9yIvM2C/D7EKP9kFyhGK8MmohJy2TfIYP1ZehUfHyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jf5RPJXm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KOsTTbEIKnn1lDtoP6teYS5Q0yZvLkrVNJM/olKSH7k=; b=jf5RPJXm7QPeusxBSDM96GLvKP
	aaFex/REZNch/cfb9BENRZXIbOoIZH818x7HEhrpCxVrHj184z71pAFTjIomidNTN/ARIRGhOU+Pg
	WHg9V5IRVKwNbd5+nJB7ebHBLuJguE0MZOtVFaJAxZU/Ma9KpCEgooPg8U1MiUxbGGvaLP7IpsFfQ
	mrAuVWEeQrPusg0H0NCN01MGeYn+gOBcOrZehlm7K92JXeGg8+yhOqFRGQ+GsYyGipEqQBQC5YoMh
	kOVgt6G/GDQnSfE9EJ+tN3kuDPmkrIGijfow4PDvJuCtJo+G6E7gw0sE0AwKsHEE3fD//swjzwcoD
	a7UkPLtQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50182 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tcnor-0007Vr-21;
	Tue, 28 Jan 2025 15:48:05 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tcnoY-0037HE-A6; Tue, 28 Jan 2025 15:47:46 +0000
In-Reply-To: <Z5j7yCYSsQ7beznD@shell.armlinux.org.uk>
References: <Z5j7yCYSsQ7beznD@shell.armlinux.org.uk>
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
	Paolo Abeni <pabeni@redhat.com>,
	 Vladimir Oltean <olteanv@gmail.com>,
	 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH RFC net-next 12/22] net: stmmac: dwmac4: clear
 LPI_CTRL_STATUS_LPITCSE too
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tcnoY-0037HE-A6@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 28 Jan 2025 15:47:46 +0000

Ensure that LPI_CTRL_STATUS_LPITCSE is also appropriately cleared when
disabling LPI or enabling LPI without TX clock gating.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index dc2d8c096fa3..ed42e1477cf8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -410,7 +410,7 @@ static int dwmac4_set_lpi_mode(struct mac_device_info *hw,
 	}
 
 	mask = LPI_CTRL_STATUS_LPIATE | LPI_CTRL_STATUS_LPIEN |
-	       LPI_CTRL_STATUS_LPITXA;
+	       LPI_CTRL_STATUS_LPITXA | LPI_CTRL_STATUS_LPITCSE;
 
 	value |= readl(ioaddr + GMAC4_LPI_CTRL_STATUS) & ~mask;
 	writel(value, ioaddr + GMAC4_LPI_CTRL_STATUS);
-- 
2.30.2


