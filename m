Return-Path: <netdev+bounces-146427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3839D359E
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 09:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5457B210B7
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 08:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9AC15B547;
	Wed, 20 Nov 2024 08:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O8IJJmf9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599171422C7;
	Wed, 20 Nov 2024 08:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732091944; cv=none; b=Cq2+Ihsabb/W+3Y3zj1Mv517wvEg+gcQOqxPBF7fLD31eYco/drwOqr+QeFOLC4FisbdhuONDReTt1RvOeNoVdJ3LSlQMuirALi6qrLwMC224rt3vxK69FfJg6mhte+FjHQHKE0D6+801CKoyiWTGgAru5l9dR5bsTs7sIux9Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732091944; c=relaxed/simple;
	bh=Ju3HdLFruvE1TxsgSL4HDmmuhZmrCfLaoDXxyMk3h08=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dbRpq4AribE2GiahtWP2KJXYIPPEMdf2BINcBqKgeDY6lEtISVnUmCK/j4lT0gn1/2wtO+HzZsPo7t+EJp3RQLzqZiuvh3ssMkwPg+BpqNsI4O0sCJKlsj0zNaadR/HL1Xv2wUreInyrsD6Av02brOto5kQR84vtZhs11Q5zRZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O8IJJmf9; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732091943; x=1763627943;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ju3HdLFruvE1TxsgSL4HDmmuhZmrCfLaoDXxyMk3h08=;
  b=O8IJJmf9P5yGaVCZBJcX4UPRqP5EeteTcADMWHXBKhy10TnzfnU4cSpy
   k8lDOG/ofjga32vZ/m+W9eUxu89Q8N1MSQ3D1eQs7IBaDsN8YpfSnMwj6
   OPDAaBEw2nBRNWFfqV5AJMNlqQ/u9u9WoBfochM+Odp7p+wM1bkbsoTbP
   Qni6Ik4pEV7JuvTg4FdSuNpQwt153zmXIEHEPNL8QTrUgbgEM9yAAjo8A
   kBqRJtC9nrMZ5M6NsdxH4+vr4lcDog0vrNS3nDIvUuhwFOOvlCXInzQsd
   Ehxa+d84edoz7Q/d62mAQ/gfR6DFtYEprv6AJLcCyzi12obe4nFS8UU5K
   w==;
X-CSE-ConnectionGUID: 4fO6yhLWSPOSdz4waAYC7g==
X-CSE-MsgGUID: OZWTAB5BSkCSkwX6C10JaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="43205711"
X-IronPort-AV: E=Sophos;i="6.12,169,1728975600"; 
   d="scan'208";a="43205711"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 00:39:01 -0800
X-CSE-ConnectionGUID: cauhdcDOSv62S1GL+vEbmw==
X-CSE-MsgGUID: vruHfDFvR26AJFa6jwC9wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,169,1728975600"; 
   d="scan'208";a="89994218"
Received: from unknown (HELO YongLiang-Ubuntu20-iLBPG12.png.intel.com) ([10.88.229.33])
  by fmviesa008.fm.intel.com with ESMTP; 20 Nov 2024 00:38:58 -0800
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net 1/1] net: stmmac: set initial EEE policy configuration
Date: Wed, 20 Nov 2024 16:38:18 +0800
Message-Id: <20241120083818.1079456-1-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the initial eee_cfg values to have 'ethtool --show-eee ' display
the initial EEE configuration.

Fixes: 49168d1980e2 ("net: phy: Add phy_support_eee() indicating MAC support EEE")
Cc: <stable@vger.kernel.org>
Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7bf275f127c9..766213ee82c1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1205,6 +1205,9 @@ static int stmmac_init_phy(struct net_device *dev)
 			return -ENODEV;
 		}
 
+		if (priv->dma_cap.eee)
+			phy_support_eee(phydev);
+
 		ret = phylink_connect_phy(priv->phylink, phydev);
 	} else {
 		fwnode_handle_put(phy_fwnode);
-- 
2.34.1


