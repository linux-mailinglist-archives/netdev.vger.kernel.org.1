Return-Path: <netdev+bounces-179872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94FEA7ECD3
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8EA446F40
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F13224256;
	Mon,  7 Apr 2025 18:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Ox9FUI/i"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F258A2561B3
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 18:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052388; cv=none; b=IQijuWiBSGlogAvbBvIgPALQQvUG6l6ws+goe/69ZJuFLhRO7/MtphDPM6iGiuXhgap79qaQDZx0XjCPSNCUIEd+2S0mbaDavVEjuf1yknPc9BEYzg83kpJQXYOzMJTxIiwYh8fswykOKYVUkG8U57pyyRYfNnQp5YKDCbOaGck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052388; c=relaxed/simple;
	bh=siMibg+sWeuqV2H+mIURJ3pPFUQVRhu6ppr+8HGTt8E=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=X9Bh/4E14HFH4kZbsTgPTMQiGIypQDoCl1nHGjdkVcWsKO4ab3llHOQETuY06P2pV1L7XTA2a+OCOl62lwcXvhujRNpXn8gOdblkE3WUUSc8jEV/JZthV4qT0PGEr+CRqV+eBXGjQ8/1bNKEa9yuplrxtCoRDqF+/Nx+jN8rB/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Ox9FUI/i; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6OUrCzCldOGuSSzB6HzeF4lCjN38tssC9VPeOMCVpQA=; b=Ox9FUI/idEBlHs9dz8SvPkf/v8
	sWb/15TPPiO7QJVwSf1HH0lBUGQqA2cgxJVXzwddGI07XLbaQiDnPMgiPliPfmIECeCZBcWPLpkPi
	7zZlLxe2l8ag6/r0K6cuU5ElLX76rWN6qmpjpovkpsSiZFJhxXzcDXWbzLn+EpJ8IlNr5aMUL+h5W
	AF6cnwBKMuXAqd1AqEw02CBU9PBopD5EYgE7biRCdjF5+xEXNgRzk/TwNyjiU3jpOiJV7cc0pk6UB
	EVCVF7NNuXKXqWMPazYQGPAXrq9+A2LMPywE0EgiG7h9qX2KrRA1bqZ/sicmQqn+pHXJwCA9aadUV
	mRmZFYhA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44394 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u1rh4-0006AC-1K;
	Mon, 07 Apr 2025 19:59:38 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u1rgY-0013gv-CL; Mon, 07 Apr 2025 19:59:06 +0100
In-Reply-To: <Z_QgOTC1hOSkIdur@shell.armlinux.org.uk>
References: <Z_QgOTC1hOSkIdur@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Richard Cochran <richardcochran@gmail.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH net-next 4/5] net: stmmac: remove eee_usecs_rate
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u1rgY-0013gv-CL@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 07 Apr 2025 19:59:06 +0100

plat_dat->eee_users_rate is now unused, so remove this member.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 include/linux/stmmac.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index c4ec8bb8144e..8aed09d65b4a 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -276,7 +276,6 @@ struct plat_stmmacenet_data {
 	int mac_port_sel_speed;
 	int has_xgmac;
 	u8 vlan_fail_q;
-	unsigned long eee_usecs_rate;
 	struct pci_dev *pdev;
 	int int_snapshot_num;
 	int msi_mac_vec;
-- 
2.30.2


