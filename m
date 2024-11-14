Return-Path: <netdev+bounces-144727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4149C84BB
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 09:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C616A2847CE
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 08:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAE51F6678;
	Thu, 14 Nov 2024 08:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MlMrFEFB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A001F76A6;
	Thu, 14 Nov 2024 08:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731572258; cv=none; b=IA5wcKgdPvIgwRpV+0xTmGOLA0mz/8q1yHBgrr2wXawoNAfgcYhJEUyoPfLznqbbb4tmdOxo2BDw+fFmtPCOoeiXywgk+VUR+1ypoS5NMmqh/2XEqfeX6eHsFg3FlDYnM3Uq0p0b7apd2M4flgWiB+aEbHM7eH+nFXZe9R+ws+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731572258; c=relaxed/simple;
	bh=xrJukahaxgNQYaY6Ib9PxdkI6uOeHardKxoJD+xZf7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DW/6d/cmmyr6gtM1ybktGowBbGaqBy9XH8v4sBfxWWPfbiVMR9Io4eweEbQHHpSydVuz5UHljX7O3KMP+P01eays35yL1KK+qF9qhGcXZ3ZIlf0/uaaZxUFgqv4ToWVzXCcp7Lp9D2PrpeMMwymYd3vlDAbryJNRPJF3a0reWlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MlMrFEFB; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731572258; x=1763108258;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xrJukahaxgNQYaY6Ib9PxdkI6uOeHardKxoJD+xZf7U=;
  b=MlMrFEFBLT9YeaZKjbMOg9TyU/k3CxrAr49Y6F3jevhDMtCud1BYgELT
   jjnJ5JLoiNenYZj3GxAsHJZHG0qjC9swX0fiJtxbULw7rpHMbbBxBQ9uj
   dcp4pbAN3Hq1MPuJ14Qp6WIOeR5xHroFWwVGT/JESCGjUc8SNY5wcFF0A
   trwwN4HDvXxGhjHCXKHq4rt0bqH8B9x4iMhPOvd6wNn3Z1FTzovRdes/Z
   s3/pam1vdAuw8C0ZjdHwnMOSYEVNSMaVdJaRHgEzSu0/CAzMcG33Dlqgy
   IO8qsXg0rQZx4HbFpmBem3gfJVcQhdIKB8fntthSC8CoxRFX8YkRlS/2L
   w==;
X-CSE-ConnectionGUID: d1AZ6g1XQzKBqEcxTgrqBA==
X-CSE-MsgGUID: bvkG2yKXT9+LIvEYxaV3RQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="42921287"
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="42921287"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 00:17:37 -0800
X-CSE-ConnectionGUID: 6xlRLCGzRvCeAy4d+oc+aA==
X-CSE-MsgGUID: U32PUQYWQBSJGnHUzKVuGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="88553864"
Received: from unknown (HELO YongLiang-Ubuntu20-iLBPG12.png.intel.com) ([10.88.229.33])
  by fmviesa010.fm.intel.com with ESMTP; 14 Nov 2024 00:17:33 -0800
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
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
Subject: [PATCH net v1 2/2] net: stmmac: set initial EEE policy configuration
Date: Thu, 14 Nov 2024 16:16:53 +0800
Message-Id: <20241114081653.3939346-3-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241114081653.3939346-1-yong.liang.choong@linux.intel.com>
References: <20241114081653.3939346-1-yong.liang.choong@linux.intel.com>
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
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7bf275f127c9..5fce52a9412e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1204,7 +1204,7 @@ static int stmmac_init_phy(struct net_device *dev)
 			netdev_err(priv->dev, "no phy at addr %d\n", addr);
 			return -ENODEV;
 		}
-
+		phy_support_eee(phydev);
 		ret = phylink_connect_phy(priv->phylink, phydev);
 	} else {
 		fwnode_handle_put(phy_fwnode);
-- 
2.34.1


