Return-Path: <netdev+bounces-277944-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBwuDlZU3GnwPQkAu9opvQ
	(envelope-from <netdev+bounces-277944-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 04:26:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D24EF3E6C66
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 04:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E95B3003342
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 02:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2FE21D3E2;
	Mon, 13 Apr 2026 02:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GCWOMtms"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848071D61A3;
	Mon, 13 Apr 2026 02:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776047185; cv=none; b=VpXXRpLamHJgUKa7ssfSt4ksfy1ZqbHMkz61C+HIVT1lgAntucy1v9MfBKTB8JsxqEvobdwLAAq570aNjhDewfoSLCpvCkWNeHlxMD8jFoJlZWUt9OP4jwbTRvjWyxoeawLfBhQLE2RZlwY2NLD17/PCTTrqJW3YrCOFkhKHPTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776047185; c=relaxed/simple;
	bh=cYFFXHwwvGuibt1PZzWRliLfIKEX30gWC7CvWsMh4B0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uuiVBF/HYG2h7daG4VdmFDTqJf+8lVZr6UsY8FouqMLT6+U/PbG+shamZ0OtmQqvo3YUVApM9PzmB+CMrxMOMsubVDQ+4vYgxcFFNVXEA841rVHb7e7ElN/bX6uaNrzNqelcv1TynH0bzSUe+XsG1/IrcgnvJi2NXMZ6ZTdUPFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GCWOMtms; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776047184; x=1807583184;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cYFFXHwwvGuibt1PZzWRliLfIKEX30gWC7CvWsMh4B0=;
  b=GCWOMtmslMQP2hkBy4gg3q0xbaKcvQnmLlOJEtFDQXDi0z1lSxCHd6Be
   tPN/z6y+VUSsnQMBnAvNslL+lgI/yCbEEjWgd9p/IM0Qie7KdmoEbYqoH
   qxDMTAJ4XfAbyvKLvZPgV2L5EN4M/qbL895BELPwaFY5MOLcuPPPbKhVR
   W3RV+RU7FVVXanbEY9qrkJncYVyZC0RxW6LQjUYp/s3YXCXCzmcn1axsP
   H5labKOuiBXjMJyjLcfx+si+5GZ75I+brubz4WBL26n/dzsvcbUlFLUws
   mrdmDOri5DOmcQmPV62Wyr0Sx3k9AMMubA7q2pxTQaPUaO+CGx/gWgUVU
   A==;
X-CSE-ConnectionGUID: JF7aTiB8QSKmiwkL3NulPQ==
X-CSE-MsgGUID: 3VrYx76ySf2MPpK0PmS9HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="76995060"
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="76995060"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 19:26:23 -0700
X-CSE-ConnectionGUID: jXtFVFBiTOGC3ltGX6nwmA==
X-CSE-MsgGUID: XXTjSMEWRLGlIxVqUw5xug==
X-ExtLoop1: 1
Received: from unknown (HELO localhost.png.intel.com) ([10.107.255.31])
  by fmviesa003.fm.intel.com with ESMTP; 12 Apr 2026 19:26:19 -0700
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
Subject: [PATCH net,v2 1/1] net: stmmac: Update default_an_inband before passing value to phylink_config
Date: Mon, 13 Apr 2026 10:03:39 +0800
Message-ID: <20260413020339.68426-1-khai.wen.tan@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,renesas.com,nxp.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277944-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: D24EF3E6C66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

get_interfaces() will update both the plat->phy_interfaces and
mdio_bus_data->default_an_inband based on reading a SERDES register. As
get_interfaces() will be called after default_an_inband had already been
read, dwmac-intel regressed as a result with incorrect default_an_inband
value in phylink_config.

Therefore, we moved the priv->plat->get_interfaces() to be executed first
before assigning mdio_bus_data->default_an_inband to
config->default_an_inband to ensure default_an_inband is in correct value.

Fixes: d3836052fe09 ("net: stmmac: intel: convert speed_mode_2500() to get_interfaces()")
Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>
---
v2:
  - update commit message for better understanding (Russell King)
  - corrected the blamed commit (Russell King)
v1: https://patchwork.kernel.org/project/netdevbpf/patch/20260410020735.327590-1-khai.wen.tan@linux.intel.com/
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


