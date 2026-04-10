Return-Path: <netdev+bounces-277207-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QG+eG0Vh2GnScggAu9opvQ
	(envelope-from <netdev+bounces-277207-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 04:32:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DC53D171E
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 04:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 92A653010200
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 02:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20722C11C6;
	Fri, 10 Apr 2026 02:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O96eZuXQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C05625A354;
	Fri, 10 Apr 2026 02:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775788350; cv=none; b=tkg2p8G+tij3V+1NQCB/zvN3p4voIKsvPMacA5J0vbGQWKO2c2kdRME4iwylXCFt6dwI/2cd/TSMKwZo1Kyidk/9adAPRxDiMtKTncEJSq9J7EZfiF3D5gImNgxxSBR21BR7HX1QZAWCdFv0PNDH6NalBcFvDK0zPaK1ugfdS5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775788350; c=relaxed/simple;
	bh=wVncFe7SIQwq8Kgb0H/3/ttZShv2kknMzmQX3tCdVuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QehGQhz3+GrWttNkjwvqDNFGd26bQHAyLtJSWrDI+ajByXCWxmoBZ0Y5BAuxBds5FfkUrx6dvY2vsxAYjCKtpAfOP82ixOoXJiE+HmHun4y9VSyGM/t19wWzTkWU0/wzQSohcFlNCyJTd5Z6L98UA2NiqkPEvU/zpd7PnwcwPq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O96eZuXQ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775788349; x=1807324349;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wVncFe7SIQwq8Kgb0H/3/ttZShv2kknMzmQX3tCdVuU=;
  b=O96eZuXQ4WoWFxii+Cc35shDxCb6J+BkIBC44vnp8O5rVO3F3Wjzmk6m
   73bKqpd/AkdBkyb4Yj3vw8PSVG/vt/pbO0vh7I4a+BVlClJUNmah89jQB
   nfzIYwm2UxfjjuKBzGdR6TIx8E1MPiaLRQMLcIOp0n5bxtoFDYUzjQZNN
   q6+BC5d6SGQR/fVNMUMM/lbOpA0AZCTz0a6Zp6eIm1FrLkZPem3K1ExgF
   FZ3j3f7pa7c5aEwc0CekQhlGeUxsBzAkTi/q3YFKlagwgAcvfaKHbuQ/J
   deuJkVkv/nvUFdRryONBQdfmGbQLJdWEUrQPEq0w4QxQra/IwtcDh8Ywc
   w==;
X-CSE-ConnectionGUID: TxVF/OT8SWWPJ1AIJLQb5w==
X-CSE-MsgGUID: ooqHPET5Teyka51qHOnbHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76988412"
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="76988412"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 19:32:28 -0700
X-CSE-ConnectionGUID: /Q0DNbedQzm+3Gr5cJESAw==
X-CSE-MsgGUID: Z2bwjH9kRGqDrIYeAmS7xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="224214256"
Received: from unknown (HELO localhost.png.intel.com) ([10.107.255.31])
  by fmviesa006.fm.intel.com with ESMTP; 09 Apr 2026 19:32:24 -0700
From: KhaiWenTan <khai.wen.tan@linux.intel.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	ovidiu.panait.rb@renesas.com,
	vladimir.oltean@nxp.com
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	yoong.siang.song@intel.com,
	hong.aun.looi@intel.com,
	khai.wen.tan@intel.com,
	KhaiWenTan <khai.wen.tan@linux.intel.com>
Subject: [PATCH net 1/1] net: stmmac: Update default_an_inband before passing value to phylink_config
Date: Fri, 10 Apr 2026 10:07:35 +0800
Message-ID: <20260410020735.327590-1-khai.wen.tan@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,renesas.com,nxp.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277207-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khai.wen.tan@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.intel.com:mid]
X-Rspamd-Queue-Id: 74DC53D171E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

get_interfaces() will update both the plat->phy_interfaces and
mdio_bus_data->default_an_inband based on reading a SERDES register.

Therefore, we moved the priv->plat->get_interfaces() to be executed
first before assigning mdio_bus_data->default_an_inband to
config->default_an_inband to ensure default_an_inband is in correct
value during PHY setup.

Fixes: ca732e990fc8 ("net: stmmac: add get_interfaces() platform method")
Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 13d3cac056be..c92054648a7e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1345,10 +1345,6 @@ static int stmmac_phylink_setup(struct stmmac_priv *priv)
 	priv->tx_lpi_clk_stop = priv->plat->flags &
 				STMMAC_FLAG_EN_TX_LPI_CLOCKGATING;
 
-	mdio_bus_data = priv->plat->mdio_bus_data;
-	if (mdio_bus_data)
-		config->default_an_inband = mdio_bus_data->default_an_inband;
-
 	/* Get the PHY interface modes (at the PHY end of the link) that
 	 * are supported by the platform.
 	 */
@@ -1356,6 +1352,10 @@ static int stmmac_phylink_setup(struct stmmac_priv *priv)
 		priv->plat->get_interfaces(priv, priv->plat->bsp_priv,
 					   config->supported_interfaces);
 
+	mdio_bus_data = priv->plat->mdio_bus_data;
+	if (mdio_bus_data)
+		config->default_an_inband = mdio_bus_data->default_an_inband;
+
 	/* Set the platform/firmware specified interface mode if the
 	 * supported interfaces have not already been provided using
 	 * phy_interface as a last resort.
-- 
2.43.0


