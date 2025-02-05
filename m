Return-Path: <netdev+bounces-163019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E9AA28C1A
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 14:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED04188A24C
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF25813AA27;
	Wed,  5 Feb 2025 13:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IJ2npVoz"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292E1136326
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 13:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762869; cv=none; b=afnstX01vL+kw+lqu87hHyyOCLTvO0A+RN56n9qofE6g+W0bFHehhVXWs2C96PymZI4JNhT4tZc5LFyjcz7XUaxn/A3J4U6Y37JMTRqvEMZf0W3ZaIs5Pd3Ng62qZ2U+KaIN19ZUDH3pSzWqbTkR+uPKFuYhKOFeXKM/Eb5JT/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762869; c=relaxed/simple;
	bh=FlnTT8+vKXxq0u9C0gjUSaAOgSfohUh82yFgJOybJ8k=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=bKeuLyWReBiB8O3VzJ+JROJx/0hWaityESl9c4nPTf5TTbi8Ozf8sDc3oi6qI3bF/EPqc0J+1tcRv2QXT9T+NxDb6knUhqKOXxm9MOQur/p+hlhQRvpq7tM9WKi/+D32m8/A8F+imX4cXot3l4rS/klaRcGaFU2r0sLtFDoq9+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IJ2npVoz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KOsTTbEIKnn1lDtoP6teYS5Q0yZvLkrVNJM/olKSH7k=; b=IJ2npVozHdBW7wFfF/cXSeTTlK
	MbS8ruqyb7O65yf/gA6tmVKBBa4Wd9H84YXRY+ngAlhEXyKOAsVuLsPBCopFqnAF/TTnhpQJGU8z7
	AprkCqpBKOT1b2aY2r6m1D6QP/jQJhqrfcbsdyvwkpuV5Ki5HMW4GSjSaIYo8jwlL3eQDyQsAnbHC
	lkX5VDyHOal4b4zezBXGiaKbRWXf1z+UqDujrdGgq7lAMOerFEl+B4VHPIOYmf4VO0XvzPyZOjfrD
	iJGGLiQwidLLLx8LeqCqmpsq8Mr6DRtH082/uVylJ2BfgQxUswi3kijn5jUWqEHtZw3l6KJfXEjld
	2b8oB4Hg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60668 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tffeH-0007Ch-0N;
	Wed, 05 Feb 2025 13:41:01 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tffdx-003ZIZ-JQ; Wed, 05 Feb 2025 13:40:41 +0000
In-Reply-To: <Z6NqGnM2yL7Ayo-T@shell.armlinux.org.uk>
References: <Z6NqGnM2yL7Ayo-T@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 12/14] net: stmmac: dwmac4: clear
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
Message-Id: <E1tffdx-003ZIZ-JQ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 05 Feb 2025 13:40:41 +0000

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


