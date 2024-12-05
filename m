Return-Path: <netdev+bounces-149313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9F99E5198
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A2D281CE2
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 09:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED0F1D61BC;
	Thu,  5 Dec 2024 09:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="r+vW3LCL"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169E41D5175
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 09:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391762; cv=none; b=N4l7ayqigb7iKWOySXmCxD/igVQzY6AMl+gl7D4ig377+o49IXdVZMjeKEcTyWBAdkJuFeHeOoWMWrKCR+tRknMPipYzPsaqxC/5+bNCLY/fDqtFTgiRobq0xgty8YAa+ZjDhUvLR5qz1lROIBKvNt4nG6MoV0vvxGTtbjkJQuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391762; c=relaxed/simple;
	bh=Os4VsgzXjBhPZmUspXh/221AhUe6eUkXlatUL0yIKMU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Vwen44FMmQoKL5+hiJnnq+z8Jc3H5JDl7xFMZ09XybDgtzKUiQRGffAhnyWnYiRGYCiA7VHZXqWj/0pMbrxyOhhtSgxtj3xYqb/+OgNTwkt062WogvibzOuudMfREy+s3nvKM4vs6u2Jb0vp9vDMT98BFeohBhp9wjJPmmx0lQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=r+vW3LCL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qeEQYmHFBqqeSJrmP9qmqrphebl43pVxJVKiNxT2TKM=; b=r+vW3LCLwMyiGgXknPLK9/SbKW
	MD6fXBzkA0CAbuC1mN0LfDVrVQsspfVIoYyBUG6VK2Ft+J71LnyZjnXIyCbc0doCzXeiKJ5wp4C/o
	9eWxP/yTDA1svOl5K+d0xZJ2nnku9M+nCpzPZZYKHHZQecNBiNNIUOnziGMpq0B45rnpvgyss06aB
	SedVV0PS/dBHq7GGPZXHS9zQKj43nbuu1rW0/kymDmaMP6olnTiefzseZzFBaQHKfD9kpgQlOFZHT
	7c4T1bRVMqs4caq9DrgfaRF2TlBz5D8D7SN2w9P/FpLZEVnT9bPx3osWZisOPXy8BPARwOshuRTVt
	Cr+gW4UQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59750 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tJ8NX-0004UG-2R;
	Thu, 05 Dec 2024 09:42:36 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tJ8NW-006L5V-I9; Thu, 05 Dec 2024 09:42:34 +0000
In-Reply-To: <Z1F1b8eh8s8T627j@shell.armlinux.org.uk>
References: <Z1F1b8eh8s8T627j@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jose Abreu <Jose.Abreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 3/3] net: pcs: xpcs: implement pcs_inband_caps()
 method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tJ8NW-006L5V-I9@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 05 Dec 2024 09:42:34 +0000

Report the PCS inband capabilities to phylink for XPCS.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 7246a910728d..f70ca39f0905 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -567,6 +567,33 @@ static int xpcs_validate(struct phylink_pcs *pcs, unsigned long *supported,
 	return 0;
 }
 
+static unsigned int xpcs_inband_caps(struct phylink_pcs *pcs,
+				     phy_interface_t interface)
+{
+	struct dw_xpcs *xpcs = phylink_pcs_to_xpcs(pcs);
+	const struct dw_xpcs_compat *compat;
+
+	compat = xpcs_find_compat(xpcs, interface);
+	if (!compat)
+		return 0;
+
+	switch (compat->an_mode) {
+	case DW_AN_C73:
+		return LINK_INBAND_ENABLE;
+
+	case DW_AN_C37_SGMII:
+	case DW_AN_C37_1000BASEX:
+		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
+
+	case DW_10GBASER:
+	case DW_2500BASEX:
+		return LINK_INBAND_DISABLE;
+
+	default:
+		return 0;
+	}
+}
+
 void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces)
 {
 	const struct dw_xpcs_compat *compat;
@@ -1306,6 +1333,7 @@ static const struct dw_xpcs_desc xpcs_desc_list[] = {
 
 static const struct phylink_pcs_ops xpcs_phylink_ops = {
 	.pcs_validate = xpcs_validate,
+	.pcs_inband_caps = xpcs_inband_caps,
 	.pcs_pre_config = xpcs_pre_config,
 	.pcs_config = xpcs_config,
 	.pcs_get_state = xpcs_get_state,
-- 
2.30.2


