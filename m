Return-Path: <netdev+bounces-157716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F80A0B5F5
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 12:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BADC63A3F56
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 11:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A688D46B5;
	Mon, 13 Jan 2025 11:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="T+m+cyWo"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1411C1CAA61
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 11:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736768773; cv=none; b=T3hfjuS0XabeokuqBT2T6q5ay/GAkoVVCGiZfOAjemUn5XaOIyLYRdjjN5ouzukIEyJ0cIDTzCl7topNXzvSavOQxp15OFBSC826e1on9kJIrYNTPdiC8h51vZnkU0ZtoKlupj0aFm7xXQP3X4s4e4No6MSPQMSn02kAVJJCi/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736768773; c=relaxed/simple;
	bh=6QMEns8Cu6Dha6A8Xw7qvmkDW1dxX9QW0UaDlcn1HjM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=jKPVJb/fQDEJH9KMewVRS0GCWW1SbguUk3hXSZUny5YcDWBkTzuiXjViwYJSWKrF1GwuDj/1Dw/JP93MRV0PZCHP65jNWT7FoonE6EC3borsqpmi4tLGoXUUsaHLppt30CGiNviwNYae2JKCmga2E1JYAwTCUBnUjZ+SeG7igVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=T+m+cyWo; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=01Z6NUQGGVdbdysyHi9D4NLqyojbqR+9GRrkbvVdFFQ=; b=T+m+cyWomkZSFmtWRgo7licQxk
	NvfzfAJ1ovjuv71ka1EmpDj0ZlEI2HY1wnUj8pwBsXm1OVWhG0G7tGMjm2+e42kRtpfAgfDv67G6T
	XrxR/Y6xnjDwGaQWrQjg+KYrn3ED0Yq8R8IkF/NF0IPvUa8h9pdKJgYCpZTh6FlEaM7Xaog065Qpt
	WZvOMg8WiHAQ9m44puZksVWP7JPgKUdKiTp02rpyJk8EJ7oW/ZjvNO+6sL29nJXeOjlOp8Cecavo7
	xhexAXMuynJWK10Gz0rawMrWG59AQAYzXm04QSOItIe9x4BRY1BnnHXzFC7PRSVC/tvllwSb5GCAy
	XldcMVoQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48028 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tXItQ-0006V9-0L;
	Mon, 13 Jan 2025 11:46:04 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tXIt7-000MB0-0W; Mon, 13 Jan 2025 11:45:45 +0000
In-Reply-To: <Z4T84SbaC4D-fN5y@shell.armlinux.org.uk>
References: <Z4T84SbaC4D-fN5y@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Eric Woudstra <ericwouds@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 2/9] net: stmmac: correct priv->eee_sw_timer_en
 setting
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tXIt7-000MB0-0W@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 13 Jan 2025 11:45:45 +0000

If we are disabling EEE/LPI, then we should not be enabling software
mode. The only time when we should is if EEE is active, and we are
wanting to use software-timed EEE mode.

Therefore, in the disable path of stmmac_eee_init(), ensure that
priv->eee_sw_timer_en is set false as we are going to be calling
del_timer_sync() on the timer.

This will allow us to simplify some fast-path tests in later patches.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 8130b0f614d8..f1e416b03349 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -478,7 +478,7 @@ static void stmmac_eee_init(struct stmmac_priv *priv, bool active)
 	if (!priv->eee_active) {
 		if (priv->eee_enabled) {
 			netdev_dbg(priv->dev, "disable EEE\n");
-			priv->eee_sw_timer_en = true;
+			priv->eee_sw_timer_en = false;
 			stmmac_disable_hw_lpi_timer(priv);
 			del_timer_sync(&priv->eee_ctrl_timer);
 			stmmac_set_eee_timer(priv, priv->hw, 0,
-- 
2.30.2


