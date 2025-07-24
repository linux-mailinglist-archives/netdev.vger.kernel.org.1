Return-Path: <netdev+bounces-209843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052ECB110E5
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 20:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E0515A0D38
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 18:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE102ED85E;
	Thu, 24 Jul 2025 18:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iEh2/xGr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E9E2ED159
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 18:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381727; cv=none; b=lH726+2Gzxifxadb4XqTblTPUq7o3DiepXdkujayhyQJyVio5LpWX6+eNFCgb+aZWO3BNMi58Y5ctAWV50VIp5jlEHtTHv5KPlKhXx3XcE0VEFXf9Wc4RCehwT24F+2o1xc5wXNe5HE/X8jtEikjsB8ma1MndQziQMAkyatNaKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381727; c=relaxed/simple;
	bh=TcA21A1CLs/HFFneFHS/+RE3Iz28pAlRZQ1ZgqRiwy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7ppFZw0pQ5MwTZPO+Y38tT4QxfT8Dz5TQG93wgJnoiwlEhd12vf1KbWTWbUhDOAwEqtcxRh7kR5DjOkZKppGNcqxIMDLRVy5HbtY7ufV7pdWnD0O/s66sDuaVujJURDwAyEoet9G4rogl+OcrXah/Ky9x4tdmHB5/6rZb8FACc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iEh2/xGr; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753381726; x=1784917726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TcA21A1CLs/HFFneFHS/+RE3Iz28pAlRZQ1ZgqRiwy0=;
  b=iEh2/xGrqxEyhyjNYv7PeHyVnwqA/JkUdSpjx7ERlh+kvUrf1GUnAaPi
   bfIkixQqcWagxusoSrpuq5E/5/bu4ip2F+TAti+R1Ft6Hh5c+IAIAW1nB
   luvZt7CSAggLLbT0O3qYtN4zUUBZcgaXzvAmwZlHi83hQ/ikPa6pzDsEj
   9xwAxX3X02thaWXIQktPuZE5XKEWO8M+bdsZOJPBZANsH84HqmOKBBNat
   hOFUE8Nqy2/ZW7lCEEYH2ljOYsyLN6OKJe9MJJ+qtR7mmt/hi2dLees04
   YfHthrWaLiDBgpkGJFoPuT6k8mubGSKRp++Wc2sfPCNhmcc5NJySe1rj4
   A==;
X-CSE-ConnectionGUID: Hu4f9Na3QKC5jW4EPC1aDg==
X-CSE-MsgGUID: svrOq78BRoqCm28WZi7SEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55861404"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="55861404"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 11:28:39 -0700
X-CSE-ConnectionGUID: +mF7CUywQAqvPLqbKf6SeA==
X-CSE-MsgGUID: 6Jxqxv5ISYymGX9nNmW8IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="161096513"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 24 Jul 2025 11:28:38 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com, wq@web.codeaurora.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 8/8] i40e: use libie_aq_str
Date: Thu, 24 Jul 2025 11:28:24 -0700
Message-ID: <20250724182826.3758850-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250724182826.3758850-1-anthony.l.nguyen@intel.com>
References: <20250724182826.3758850-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

There is no need to store the err string in hw->err_str. Simplify it and
use common helper. hw->err_str is still used for other purpouse.

It should be marked that previously for unknown error the numeric value
was passed as a string. Now the "LIBIE_AQ_RC_UNKNOWN" is used for such
cases.

Add libie_aminq module in i40e Kconfig.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/Kconfig            |   1 +
 drivers/net/ethernet/intel/i40e/i40e_client.c |   7 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c |  52 -----
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c |   8 +-
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  22 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 209 +++++++-----------
 drivers/net/ethernet/intel/i40e/i40e_nvm.c    |   2 +-
 .../net/ethernet/intel/i40e/i40e_prototype.h  |   1 -
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  27 +--
 9 files changed, 105 insertions(+), 224 deletions(-)

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 29c03a9ce145..b05cc0d7a15d 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -231,6 +231,7 @@ config I40E
 	depends on PCI
 	select AUXILIARY_BUS
 	select LIBIE
+	select LIBIE_ADMINQ
 	select NET_DEVLINK
 	help
 	  This driver supports Intel(R) Ethernet Controller XL710 Family of
diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index 59263551c383..5f1a405cbbf8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -682,9 +682,7 @@ static int i40e_client_update_vsi_ctxt(struct i40e_info *ldev,
 	if (err) {
 		dev_info(&pf->pdev->dev,
 			 "couldn't get PF vsi config, err %pe aq_err %s\n",
-			 ERR_PTR(err),
-			 i40e_aq_str(&pf->hw,
-				     pf->hw.aq.asq_last_status));
+			 ERR_PTR(err), libie_aq_str(pf->hw.aq.asq_last_status));
 		return -ENOENT;
 	}
 
@@ -711,8 +709,7 @@ static int i40e_client_update_vsi_ctxt(struct i40e_info *ldev,
 			dev_info(&pf->pdev->dev,
 				 "update VSI ctxt for PE failed, err %pe aq_err %s\n",
 				 ERR_PTR(err),
-				 i40e_aq_str(&pf->hw,
-					     pf->hw.aq.asq_last_status));
+				 libie_aq_str(pf->hw.aq.asq_last_status));
 		}
 	}
 	return err;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 75074611285a..270e7e8cf9cf 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -68,58 +68,6 @@ int i40e_set_mac_type(struct i40e_hw *hw)
 	return status;
 }
 
-/**
- * i40e_aq_str - convert AQ err code to a string
- * @hw: pointer to the HW structure
- * @aq_err: the AQ error code to convert
- **/
-const char *i40e_aq_str(struct i40e_hw *hw, enum libie_aq_err aq_err)
-{
-	switch (aq_err) {
-	case LIBIE_AQ_RC_OK:
-		return "OK";
-	case LIBIE_AQ_RC_EPERM:
-		return "LIBIE_AQ_RC_EPERM";
-	case LIBIE_AQ_RC_ENOENT:
-		return "LIBIE_AQ_RC_ENOENT";
-	case LIBIE_AQ_RC_ESRCH:
-		return "LIBIE_AQ_RC_ESRCH";
-	case LIBIE_AQ_RC_EIO:
-		return "LIBIE_AQ_RC_EIO";
-	case LIBIE_AQ_RC_EAGAIN:
-		return "LIBIE_AQ_RC_EAGAIN";
-	case LIBIE_AQ_RC_ENOMEM:
-		return "LIBIE_AQ_RC_ENOMEM";
-	case LIBIE_AQ_RC_EACCES:
-		return "LIBIE_AQ_RC_EACCES";
-	case LIBIE_AQ_RC_EBUSY:
-		return "LIBIE_AQ_RC_EBUSY";
-	case LIBIE_AQ_RC_EEXIST:
-		return "LIBIE_AQ_RC_EEXIST";
-	case LIBIE_AQ_RC_EINVAL:
-		return "LIBIE_AQ_RC_EINVAL";
-	case LIBIE_AQ_RC_ENOSPC:
-		return "LIBIE_AQ_RC_ENOSPC";
-	case LIBIE_AQ_RC_ENOSYS:
-		return "LIBIE_AQ_RC_ENOSYS";
-	case LIBIE_AQ_RC_EMODE:
-		return "LIBIE_AQ_RC_EMODE";
-	case LIBIE_AQ_RC_ENOSEC:
-		return "LIBIE_AQ_RC_ENOSEC";
-	case LIBIE_AQ_RC_EBADSIG:
-		return "LIBIE_AQ_RC_EBADSIG";
-	case LIBIE_AQ_RC_ESVN:
-		return "LIBIE_AQ_RC_ESVN";
-	case LIBIE_AQ_RC_EBADMAN:
-		return "LIBIE_AQ_RC_EBADMAN";
-	case LIBIE_AQ_RC_EBADBUF:
-		return "LIBIE_AQ_RC_EBADBUF";
-	}
-
-	snprintf(hw->err_str, sizeof(hw->err_str), "%d", aq_err);
-	return hw->err_str;
-}
-
 /**
  * i40e_debug_aq
  * @hw: debug mask related to admin queue
diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c b/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
index 8aa43aefe84c..a2ccf4c5e30b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
@@ -136,7 +136,7 @@ static int i40e_dcbnl_ieee_setets(struct net_device *netdev,
 		dev_info(&pf->pdev->dev,
 			 "Failed setting DCB ETS configuration err %pe aq_err %s\n",
 			 ERR_PTR(ret),
-			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			 libie_aq_str(pf->hw.aq.asq_last_status));
 		return -EINVAL;
 	}
 
@@ -175,7 +175,7 @@ static int i40e_dcbnl_ieee_setpfc(struct net_device *netdev,
 		dev_info(&pf->pdev->dev,
 			 "Failed setting DCB PFC configuration err %pe aq_err %s\n",
 			 ERR_PTR(ret),
-			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			 libie_aq_str(pf->hw.aq.asq_last_status));
 		return -EINVAL;
 	}
 
@@ -226,7 +226,7 @@ static int i40e_dcbnl_ieee_setapp(struct net_device *netdev,
 		dev_info(&pf->pdev->dev,
 			 "Failed setting DCB configuration err %pe aq_err %s\n",
 			 ERR_PTR(ret),
-			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			 libie_aq_str(pf->hw.aq.asq_last_status));
 		return -EINVAL;
 	}
 
@@ -291,7 +291,7 @@ static int i40e_dcbnl_ieee_delapp(struct net_device *netdev,
 		dev_info(&pf->pdev->dev,
 			 "Failed setting DCB configuration err %pe aq_err %s\n",
 			 ERR_PTR(ret),
-			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			 libie_aq_str(pf->hw.aq.asq_last_status));
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 2b01eedf3605..86c72596617a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1462,7 +1462,7 @@ static int i40e_set_link_ksettings(struct net_device *netdev,
 			netdev_info(netdev,
 				    "Set phy config failed, err %pe aq_err %s\n",
 				    ERR_PTR(status),
-				    i40e_aq_str(hw, hw->aq.asq_last_status));
+				    libie_aq_str(hw->aq.asq_last_status));
 			err = -EAGAIN;
 			goto done;
 		}
@@ -1472,7 +1472,7 @@ static int i40e_set_link_ksettings(struct net_device *netdev,
 			netdev_dbg(netdev,
 				   "Updating link info failed with err %pe aq_err %s\n",
 				   ERR_PTR(status),
-				   i40e_aq_str(hw, hw->aq.asq_last_status));
+				   libie_aq_str(hw->aq.asq_last_status));
 
 	} else {
 		netdev_info(netdev, "Nothing changed, exiting without setting anything.\n");
@@ -1520,7 +1520,7 @@ static int i40e_set_fec_cfg(struct net_device *netdev, u8 fec_cfg)
 			netdev_info(netdev,
 				    "Set phy config failed, err %pe aq_err %s\n",
 				    ERR_PTR(status),
-				    i40e_aq_str(hw, hw->aq.asq_last_status));
+				    libie_aq_str(hw->aq.asq_last_status));
 			err = -EAGAIN;
 			goto done;
 		}
@@ -1534,7 +1534,7 @@ static int i40e_set_fec_cfg(struct net_device *netdev, u8 fec_cfg)
 			netdev_dbg(netdev,
 				   "Updating link info failed with err %pe aq_err %s\n",
 				   ERR_PTR(status),
-				   i40e_aq_str(hw, hw->aq.asq_last_status));
+				   libie_aq_str(hw->aq.asq_last_status));
 	}
 
 done:
@@ -1641,7 +1641,7 @@ static int i40e_nway_reset(struct net_device *netdev)
 	if (ret) {
 		netdev_info(netdev, "link restart failed, err %pe aq_err %s\n",
 			    ERR_PTR(ret),
-			    i40e_aq_str(hw, hw->aq.asq_last_status));
+			    libie_aq_str(hw->aq.asq_last_status));
 		return -EIO;
 	}
 
@@ -1758,19 +1758,19 @@ static int i40e_set_pauseparam(struct net_device *netdev,
 	if (aq_failures & I40E_SET_FC_AQ_FAIL_GET) {
 		netdev_info(netdev, "Set fc failed on the get_phy_capabilities call with err %pe aq_err %s\n",
 			    ERR_PTR(status),
-			    i40e_aq_str(hw, hw->aq.asq_last_status));
+			    libie_aq_str(hw->aq.asq_last_status));
 		err = -EAGAIN;
 	}
 	if (aq_failures & I40E_SET_FC_AQ_FAIL_SET) {
 		netdev_info(netdev, "Set fc failed on the set_phy_config call with err %pe aq_err %s\n",
 			    ERR_PTR(status),
-			    i40e_aq_str(hw, hw->aq.asq_last_status));
+			    libie_aq_str(hw->aq.asq_last_status));
 		err = -EAGAIN;
 	}
 	if (aq_failures & I40E_SET_FC_AQ_FAIL_UPDATE) {
 		netdev_info(netdev, "Set fc failed on the get_link_info call with err %pe aq_err %s\n",
 			    ERR_PTR(status),
-			    i40e_aq_str(hw, hw->aq.asq_last_status));
+			    libie_aq_str(hw->aq.asq_last_status));
 		err = -EAGAIN;
 	}
 
@@ -5375,8 +5375,7 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 			dev_info(&pf->pdev->dev,
 				 "couldn't set switch config bits, err %pe aq_err %s\n",
 				 ERR_PTR(ret),
-				 i40e_aq_str(&pf->hw,
-					     pf->hw.aq.asq_last_status));
+				 libie_aq_str(pf->hw.aq.asq_last_status));
 			/* not a fatal problem, just keep going */
 		}
 	}
@@ -5455,8 +5454,7 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 					dev_warn(&pf->pdev->dev,
 						 "Starting FW LLDP agent failed: error: %pe, %s\n",
 						 ERR_PTR(status),
-						 i40e_aq_str(&pf->hw,
-							     adq_err));
+						 libie_aq_str(adq_err));
 					return -EINVAL;
 				}
 			}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index f4d913eeeac6..b83f823e4917 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -101,6 +101,7 @@ MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all), Debug mask (0x8XXXXXXX
 
 MODULE_DESCRIPTION("Intel(R) Ethernet Connection XL710 Network Driver");
 MODULE_IMPORT_NS("LIBIE");
+MODULE_IMPORT_NS("LIBIE_ADMINQ");
 MODULE_LICENSE("GPL v2");
 
 static struct workqueue_struct *i40e_wq;
@@ -1814,7 +1815,7 @@ static int i40e_set_mac(struct net_device *netdev, void *p)
 		if (ret)
 			netdev_info(netdev, "Ignoring error from firmware on LAA update, status %pe, AQ ret %s\n",
 				    ERR_PTR(ret),
-				    i40e_aq_str(hw, hw->aq.asq_last_status));
+				    libie_aq_str(hw->aq.asq_last_status));
 	}
 
 	/* schedule our worker thread which will take care of
@@ -1846,7 +1847,7 @@ static int i40e_config_rss_aq(struct i40e_vsi *vsi, const u8 *seed,
 			dev_info(&pf->pdev->dev,
 				 "Cannot set RSS key, err %pe aq_err %s\n",
 				 ERR_PTR(ret),
-				 i40e_aq_str(hw, hw->aq.asq_last_status));
+				 libie_aq_str(hw->aq.asq_last_status));
 			return ret;
 		}
 	}
@@ -1858,7 +1859,7 @@ static int i40e_config_rss_aq(struct i40e_vsi *vsi, const u8 *seed,
 			dev_info(&pf->pdev->dev,
 				 "Cannot set RSS lut, err %pe aq_err %s\n",
 				 ERR_PTR(ret),
-				 i40e_aq_str(hw, hw->aq.asq_last_status));
+				 libie_aq_str(hw->aq.asq_last_status));
 			return ret;
 		}
 	}
@@ -2351,8 +2352,7 @@ void i40e_aqc_del_filters(struct i40e_vsi *vsi, const char *vsi_name,
 		*retval = -EIO;
 		dev_info(&vsi->back->pdev->dev,
 			 "ignoring delete macvlan error on %s, err %pe, aq_err %s\n",
-			 vsi_name, ERR_PTR(aq_ret),
-			 i40e_aq_str(hw, aq_status));
+			 vsi_name, ERR_PTR(aq_ret), libie_aq_str(aq_status));
 	}
 }
 
@@ -2386,19 +2386,17 @@ void i40e_aqc_add_filters(struct i40e_vsi *vsi, const char *vsi_name,
 			set_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state);
 			dev_warn(&vsi->back->pdev->dev,
 				 "Error %s adding RX filters on %s, promiscuous mode forced on\n",
-				 i40e_aq_str(hw, aq_status), vsi_name);
+				 libie_aq_str(aq_status), vsi_name);
 		} else if (vsi->type == I40E_VSI_SRIOV ||
 			   vsi->type == I40E_VSI_VMDQ1 ||
 			   vsi->type == I40E_VSI_VMDQ2) {
 			dev_warn(&vsi->back->pdev->dev,
 				 "Error %s adding RX filters on %s, please set promiscuous on manually for %s\n",
-				 i40e_aq_str(hw, aq_status), vsi_name,
-					     vsi_name);
+				 libie_aq_str(aq_status), vsi_name, vsi_name);
 		} else {
 			dev_warn(&vsi->back->pdev->dev,
 				 "Error %s adding RX filters on %s, incorrect VSI type: %i.\n",
-				 i40e_aq_str(hw, aq_status), vsi_name,
-					     vsi->type);
+				 libie_aq_str(aq_status), vsi_name, vsi->type);
 		}
 	}
 }
@@ -2441,8 +2439,7 @@ i40e_aqc_broadcast_filter(struct i40e_vsi *vsi, const char *vsi_name,
 		set_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state);
 		dev_warn(&vsi->back->pdev->dev,
 			 "Error %s, forcing overflow promiscuous on %s\n",
-			 i40e_aq_str(hw, hw->aq.asq_last_status),
-			 vsi_name);
+			 libie_aq_str(hw->aq.asq_last_status), vsi_name);
 	}
 
 	return aq_ret;
@@ -2483,7 +2480,7 @@ static int i40e_set_promiscuous(struct i40e_pf *pf, bool promisc)
 			dev_info(&pf->pdev->dev,
 				 "Set default VSI failed, err %pe, aq_err %s\n",
 				 ERR_PTR(aq_ret),
-				 i40e_aq_str(hw, hw->aq.asq_last_status));
+				 libie_aq_str(hw->aq.asq_last_status));
 		}
 	} else {
 		aq_ret = i40e_aq_set_vsi_unicast_promiscuous(
@@ -2495,7 +2492,7 @@ static int i40e_set_promiscuous(struct i40e_pf *pf, bool promisc)
 			dev_info(&pf->pdev->dev,
 				 "set unicast promisc failed, err %pe, aq_err %s\n",
 				 ERR_PTR(aq_ret),
-				 i40e_aq_str(hw, hw->aq.asq_last_status));
+				 libie_aq_str(hw->aq.asq_last_status));
 		}
 		aq_ret = i40e_aq_set_vsi_multicast_promiscuous(
 						  hw,
@@ -2505,7 +2502,7 @@ static int i40e_set_promiscuous(struct i40e_pf *pf, bool promisc)
 			dev_info(&pf->pdev->dev,
 				 "set multicast promisc failed, err %pe, aq_err %s\n",
 				 ERR_PTR(aq_ret),
-				 i40e_aq_str(hw, hw->aq.asq_last_status));
+				 libie_aq_str(hw->aq.asq_last_status));
 		}
 	}
 
@@ -2813,7 +2810,7 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 				 "set multi promisc failed on %s, err %pe aq_err %s\n",
 				 vsi_name,
 				 ERR_PTR(aq_ret),
-				 i40e_aq_str(hw, hw->aq.asq_last_status));
+				 libie_aq_str(hw->aq.asq_last_status));
 		} else {
 			dev_info(&pf->pdev->dev, "%s allmulti mode.\n",
 				 cur_multipromisc ? "entering" : "leaving");
@@ -2834,7 +2831,7 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 				 cur_promisc ? "on" : "off",
 				 vsi_name,
 				 ERR_PTR(aq_ret),
-				 i40e_aq_str(hw, hw->aq.asq_last_status));
+				 libie_aq_str(hw->aq.asq_last_status));
 		}
 	}
 out:
@@ -2983,8 +2980,7 @@ void i40e_vlan_stripping_enable(struct i40e_vsi *vsi)
 		dev_info(&vsi->back->pdev->dev,
 			 "update vlan stripping failed, err %pe aq_err %s\n",
 			 ERR_PTR(ret),
-			 i40e_aq_str(&vsi->back->hw,
-				     vsi->back->hw.aq.asq_last_status));
+			 libie_aq_str(vsi->back->hw.aq.asq_last_status));
 	}
 }
 
@@ -3018,8 +3014,7 @@ void i40e_vlan_stripping_disable(struct i40e_vsi *vsi)
 		dev_info(&vsi->back->pdev->dev,
 			 "update vlan stripping failed, err %pe aq_err %s\n",
 			 ERR_PTR(ret),
-			 i40e_aq_str(&vsi->back->hw,
-				     vsi->back->hw.aq.asq_last_status));
+			 libie_aq_str(vsi->back->hw.aq.asq_last_status));
 	}
 }
 
@@ -3263,8 +3258,7 @@ int i40e_vsi_add_pvid(struct i40e_vsi *vsi, u16 vid)
 		dev_info(&vsi->back->pdev->dev,
 			 "add pvid failed, err %pe aq_err %s\n",
 			 ERR_PTR(ret),
-			 i40e_aq_str(&vsi->back->hw,
-				     vsi->back->hw.aq.asq_last_status));
+			 libie_aq_str(vsi->back->hw.aq.asq_last_status));
 		return -ENOENT;
 	}
 
@@ -5534,7 +5528,7 @@ static int i40e_vsi_get_bw_info(struct i40e_vsi *vsi)
 		dev_info(&pf->pdev->dev,
 			 "couldn't get PF vsi bw config, err %pe aq_err %s\n",
 			 ERR_PTR(ret),
-			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			 libie_aq_str(pf->hw.aq.asq_last_status));
 		return -EINVAL;
 	}
 
@@ -5545,7 +5539,7 @@ static int i40e_vsi_get_bw_info(struct i40e_vsi *vsi)
 		dev_info(&pf->pdev->dev,
 			 "couldn't get PF vsi ets bw config, err %pe aq_err %s\n",
 			 ERR_PTR(ret),
-			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			 libie_aq_str(pf->hw.aq.asq_last_status));
 		return -EINVAL;
 	}
 
@@ -5735,7 +5729,7 @@ int i40e_update_adq_vsi_queues(struct i40e_vsi *vsi, int vsi_offset)
 	if (ret) {
 		dev_info(&pf->pdev->dev, "Update vsi config failed, err %pe aq_err %s\n",
 			 ERR_PTR(ret),
-			 i40e_aq_str(hw, hw->aq.asq_last_status));
+			 libie_aq_str(hw->aq.asq_last_status));
 		return ret;
 	}
 	/* update the local VSI info with updated queue map */
@@ -5791,7 +5785,7 @@ static int i40e_vsi_config_tc(struct i40e_vsi *vsi, u8 enabled_tc)
 			dev_info(&pf->pdev->dev,
 				 "Failed querying vsi bw info, err %pe aq_err %s\n",
 				 ERR_PTR(ret),
-				 i40e_aq_str(hw, hw->aq.asq_last_status));
+				 libie_aq_str(hw->aq.asq_last_status));
 			goto out;
 		}
 		if ((bw_config.tc_valid_bits & enabled_tc) != enabled_tc) {
@@ -5858,7 +5852,7 @@ static int i40e_vsi_config_tc(struct i40e_vsi *vsi, u8 enabled_tc)
 		dev_info(&pf->pdev->dev,
 			 "Update vsi tc config failed, err %pe aq_err %s\n",
 			 ERR_PTR(ret),
-			 i40e_aq_str(hw, hw->aq.asq_last_status));
+			 libie_aq_str(hw->aq.asq_last_status));
 		goto out;
 	}
 	/* update the local VSI info with updated queue map */
@@ -5871,7 +5865,7 @@ static int i40e_vsi_config_tc(struct i40e_vsi *vsi, u8 enabled_tc)
 		dev_info(&pf->pdev->dev,
 			 "Failed updating vsi bw info, err %pe aq_err %s\n",
 			 ERR_PTR(ret),
-			 i40e_aq_str(hw, hw->aq.asq_last_status));
+			 libie_aq_str(hw->aq.asq_last_status));
 		goto out;
 	}
 
@@ -5985,7 +5979,7 @@ int i40e_set_bw_limit(struct i40e_vsi *vsi, u16 seid, u64 max_tx_rate)
 		dev_err(&pf->pdev->dev,
 			"Failed set tx rate (%llu Mbps) for vsi->seid %u, err %pe aq_err %s\n",
 			max_tx_rate, seid, ERR_PTR(ret),
-			i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			libie_aq_str(pf->hw.aq.asq_last_status));
 	return ret;
 }
 
@@ -6061,7 +6055,7 @@ static void i40e_remove_queue_channels(struct i40e_vsi *vsi)
 				dev_info(&pf->pdev->dev,
 					 "Failed to delete cloud filter, err %pe aq_err %s\n",
 					 ERR_PTR(ret),
-					 i40e_aq_str(&pf->hw, last_aq_status));
+					 libie_aq_str(last_aq_status));
 			kfree(cfilter);
 		}
 
@@ -6196,7 +6190,7 @@ static int i40e_vsi_reconfig_rss(struct i40e_vsi *vsi, u16 rss_size)
 		dev_info(&pf->pdev->dev,
 			 "Cannot set RSS lut, err %pe aq_err %s\n",
 			 ERR_PTR(ret),
-			 i40e_aq_str(hw, hw->aq.asq_last_status));
+			 libie_aq_str(hw->aq.asq_last_status));
 		kfree(lut);
 		return ret;
 	}
@@ -6295,8 +6289,7 @@ static int i40e_add_channel(struct i40e_pf *pf, u16 uplink_seid,
 		dev_info(&pf->pdev->dev,
 			 "add new vsi failed, err %pe aq_err %s\n",
 			 ERR_PTR(ret),
-			 i40e_aq_str(&pf->hw,
-				     pf->hw.aq.asq_last_status));
+			 libie_aq_str(pf->hw.aq.asq_last_status));
 		return -ENOENT;
 	}
 
@@ -6542,9 +6535,7 @@ static int i40e_validate_and_set_switch_mode(struct i40e_vsi *vsi)
 	if (ret && hw->aq.asq_last_status != LIBIE_AQ_RC_ESRCH)
 		dev_err(&pf->pdev->dev,
 			"couldn't set switch config bits, err %pe aq_err %s\n",
-			ERR_PTR(ret),
-			i40e_aq_str(hw,
-				    hw->aq.asq_last_status));
+			ERR_PTR(ret), libie_aq_str(hw->aq.asq_last_status));
 
 	return ret;
 }
@@ -6743,8 +6734,7 @@ int i40e_veb_config_tc(struct i40e_veb *veb, u8 enabled_tc)
 	if (ret) {
 		dev_info(&pf->pdev->dev,
 			 "VEB bw config failed, err %pe aq_err %s\n",
-			 ERR_PTR(ret),
-			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			 ERR_PTR(ret), libie_aq_str(pf->hw.aq.asq_last_status));
 		goto out;
 	}
 
@@ -6753,8 +6743,7 @@ int i40e_veb_config_tc(struct i40e_veb *veb, u8 enabled_tc)
 	if (ret) {
 		dev_info(&pf->pdev->dev,
 			 "Failed getting veb bw config, err %pe aq_err %s\n",
-			 ERR_PTR(ret),
-			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			 ERR_PTR(ret), libie_aq_str(pf->hw.aq.asq_last_status));
 	}
 
 out:
@@ -6835,7 +6824,7 @@ static int i40e_resume_port_tx(struct i40e_pf *pf)
 		dev_info(&pf->pdev->dev,
 			 "Resume Port Tx failed, err %pe aq_err %s\n",
 			  ERR_PTR(ret),
-			  i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			  libie_aq_str(pf->hw.aq.asq_last_status));
 		/* Schedule PF reset to recover */
 		set_bit(__I40E_PF_RESET_REQUESTED, pf->state);
 		i40e_service_event_schedule(pf);
@@ -6859,8 +6848,7 @@ static int i40e_suspend_port_tx(struct i40e_pf *pf)
 	if (ret) {
 		dev_info(&pf->pdev->dev,
 			 "Suspend Port Tx failed, err %pe aq_err %s\n",
-			 ERR_PTR(ret),
-			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			 ERR_PTR(ret), libie_aq_str(pf->hw.aq.asq_last_status));
 		/* Schedule PF reset to recover */
 		set_bit(__I40E_PF_RESET_REQUESTED, pf->state);
 		i40e_service_event_schedule(pf);
@@ -6899,8 +6887,7 @@ static int i40e_hw_set_dcb_config(struct i40e_pf *pf,
 	if (ret) {
 		dev_info(&pf->pdev->dev,
 			 "Set DCB Config failed, err %pe aq_err %s\n",
-			 ERR_PTR(ret),
-			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			 ERR_PTR(ret), libie_aq_str(pf->hw.aq.asq_last_status));
 		goto out;
 	}
 
@@ -7016,8 +7003,7 @@ int i40e_hw_dcb_config(struct i40e_pf *pf, struct i40e_dcbx_config *new_cfg)
 	if (ret) {
 		dev_info(&pf->pdev->dev,
 			 "Modify Port ETS failed, err %pe aq_err %s\n",
-			 ERR_PTR(ret),
-			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			 ERR_PTR(ret), libie_aq_str(pf->hw.aq.asq_last_status));
 		goto out;
 	}
 
@@ -7056,8 +7042,7 @@ int i40e_hw_dcb_config(struct i40e_pf *pf, struct i40e_dcbx_config *new_cfg)
 	if (ret) {
 		dev_info(&pf->pdev->dev,
 			 "DCB Updated failed, err %pe aq_err %s\n",
-			 ERR_PTR(ret),
-			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			 ERR_PTR(ret), libie_aq_str(pf->hw.aq.asq_last_status));
 		goto out;
 	}
 
@@ -7140,8 +7125,7 @@ int i40e_dcb_sw_default_config(struct i40e_pf *pf)
 	if (err) {
 		dev_info(&pf->pdev->dev,
 			 "Enable Port ETS failed, err %pe aq_err %s\n",
-			 ERR_PTR(err),
-			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			 ERR_PTR(err), libie_aq_str(pf->hw.aq.asq_last_status));
 		err = -ENOENT;
 		goto out;
 	}
@@ -7220,8 +7204,7 @@ static int i40e_init_pf_dcb(struct i40e_pf *pf)
 	} else {
 		dev_info(&pf->pdev->dev,
 			 "Query for DCB configuration failed, err %pe aq_err %s\n",
-			 ERR_PTR(err),
-			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			 ERR_PTR(err), libie_aq_str(pf->hw.aq.asq_last_status));
 	}
 
 out:
@@ -7477,8 +7460,7 @@ static int i40e_force_link_state(struct i40e_pf *pf, bool is_up)
 	if (err) {
 		dev_err(&pf->pdev->dev,
 			"failed to get phy cap., ret =  %pe last_status =  %s\n",
-			ERR_PTR(err),
-			i40e_aq_str(hw, hw->aq.asq_last_status));
+			ERR_PTR(err), libie_aq_str(hw->aq.asq_last_status));
 		return err;
 	}
 	speed = abilities.link_speed;
@@ -7489,8 +7471,7 @@ static int i40e_force_link_state(struct i40e_pf *pf, bool is_up)
 	if (err) {
 		dev_err(&pf->pdev->dev,
 			"failed to get phy cap., ret =  %pe last_status =  %s\n",
-			ERR_PTR(err),
-			i40e_aq_str(hw, hw->aq.asq_last_status));
+			ERR_PTR(err), libie_aq_str(hw->aq.asq_last_status));
 		return err;
 	}
 
@@ -7534,8 +7515,7 @@ static int i40e_force_link_state(struct i40e_pf *pf, bool is_up)
 	if (err) {
 		dev_err(&pf->pdev->dev,
 			"set phy config ret =  %pe last_status =  %s\n",
-			ERR_PTR(err),
-			i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			ERR_PTR(err), libie_aq_str(pf->hw.aq.asq_last_status));
 		return err;
 	}
 
@@ -7875,8 +7855,7 @@ static int i40e_fwd_ring_up(struct i40e_vsi *vsi, struct net_device *vdev,
 		}
 		dev_info(&pf->pdev->dev,
 			 "Error adding mac filter on macvlan err %pe, aq_err %s\n",
-			  ERR_PTR(ret),
-			  i40e_aq_str(hw, aq_err));
+			  ERR_PTR(ret), libie_aq_str(aq_err));
 		netdev_err(vdev, "L2fwd offload disabled to L2 filter error\n");
 	}
 
@@ -7948,8 +7927,7 @@ static int i40e_setup_macvlans(struct i40e_vsi *vsi, u16 macvlan_cnt, u16 qcnt,
 	if (ret) {
 		dev_info(&pf->pdev->dev,
 			 "Update vsi tc config failed, err %pe aq_err %s\n",
-			 ERR_PTR(ret),
-			 i40e_aq_str(hw, hw->aq.asq_last_status));
+			 ERR_PTR(ret), libie_aq_str(hw->aq.asq_last_status));
 		return ret;
 	}
 	/* update the local VSI info with updated queue map */
@@ -8164,8 +8142,7 @@ static void i40e_fwd_del(struct net_device *netdev, void *vdev)
 			} else {
 				dev_info(&pf->pdev->dev,
 					 "Error deleting mac filter on macvlan err %pe, aq_err %s\n",
-					  ERR_PTR(ret),
-					  i40e_aq_str(hw, aq_err));
+					  ERR_PTR(ret), libie_aq_str(aq_err));
 			}
 			break;
 		}
@@ -9476,8 +9453,7 @@ static int i40e_handle_lldp_event(struct i40e_pf *pf,
 			dev_info(&pf->pdev->dev,
 				 "Failed querying DCB configuration data from firmware, err %pe aq_err %s\n",
 				 ERR_PTR(ret),
-				 i40e_aq_str(&pf->hw,
-					     pf->hw.aq.asq_last_status));
+				 libie_aq_str(pf->hw.aq.asq_last_status));
 		}
 		goto exit;
 	}
@@ -10286,8 +10262,7 @@ static void i40e_enable_pf_switch_lb(struct i40e_pf *pf)
 	if (ret) {
 		dev_info(&pf->pdev->dev,
 			 "couldn't get PF vsi config, err %pe aq_err %s\n",
-			 ERR_PTR(ret),
-			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			 ERR_PTR(ret), libie_aq_str(pf->hw.aq.asq_last_status));
 		return;
 	}
 	ctxt.flags = I40E_AQ_VSI_TYPE_PF;
@@ -10298,8 +10273,7 @@ static void i40e_enable_pf_switch_lb(struct i40e_pf *pf)
 	if (ret) {
 		dev_info(&pf->pdev->dev,
 			 "update vsi switch failed, err %pe aq_err %s\n",
-			 ERR_PTR(ret),
-			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			 ERR_PTR(ret), libie_aq_str(pf->hw.aq.asq_last_status));
 	}
 }
 
@@ -10322,8 +10296,7 @@ static void i40e_disable_pf_switch_lb(struct i40e_pf *pf)
 	if (ret) {
 		dev_info(&pf->pdev->dev,
 			 "couldn't get PF vsi config, err %pe aq_err %s\n",
-			 ERR_PTR(ret),
-			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			 ERR_PTR(ret), libie_aq_str(pf->hw.aq.asq_last_status));
 		return;
 	}
 	ctxt.flags = I40E_AQ_VSI_TYPE_PF;
@@ -10334,8 +10307,7 @@ static void i40e_disable_pf_switch_lb(struct i40e_pf *pf)
 	if (ret) {
 		dev_info(&pf->pdev->dev,
 			 "update vsi switch failed, err %pe aq_err %s\n",
-			 ERR_PTR(ret),
-			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			 ERR_PTR(ret), libie_aq_str(pf->hw.aq.asq_last_status));
 	}
 }
 
@@ -10475,8 +10447,7 @@ static int i40e_get_capabilities(struct i40e_pf *pf,
 			dev_info(&pf->pdev->dev,
 				 "capability discovery failed, err %pe aq_err %s\n",
 				 ERR_PTR(err),
-				 i40e_aq_str(&pf->hw,
-					     pf->hw.aq.asq_last_status));
+				 libie_aq_str(pf->hw.aq.asq_last_status));
 			return -ENODEV;
 		}
 	} while (err);
@@ -10613,8 +10584,7 @@ static int i40e_rebuild_cloud_filters(struct i40e_vsi *vsi, u16 seid)
 			dev_dbg(&pf->pdev->dev,
 				"Failed to rebuild cloud filter, err %pe aq_err %s\n",
 				ERR_PTR(ret),
-				i40e_aq_str(&pf->hw,
-					    pf->hw.aq.asq_last_status));
+				libie_aq_str(pf->hw.aq.asq_last_status));
 			return ret;
 		}
 	}
@@ -10855,8 +10825,7 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 	ret = i40e_init_adminq(&pf->hw);
 	if (ret) {
 		dev_info(&pf->pdev->dev, "Rebuild AdminQ failed, err %pe aq_err %s\n",
-			 ERR_PTR(ret),
-			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			 ERR_PTR(ret), libie_aq_str(pf->hw.aq.asq_last_status));
 		goto clear_recovery;
 	}
 	i40e_get_oem_version(&pf->hw);
@@ -10967,8 +10936,7 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 					 I40E_AQ_EVENT_MODULE_QUAL_FAIL), NULL);
 	if (ret)
 		dev_info(&pf->pdev->dev, "set phy mask fail, err %pe aq_err %s\n",
-			 ERR_PTR(ret),
-			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			 ERR_PTR(ret), libie_aq_str(pf->hw.aq.asq_last_status));
 
 	/* Rebuild the VSIs and VEBs that existed before reset.
 	 * They are still in our local switch element arrays, so only
@@ -11066,8 +11034,7 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 		if (ret)
 			dev_info(&pf->pdev->dev, "link restart failed, err %pe aq_err %s\n",
 				 ERR_PTR(ret),
-				 i40e_aq_str(&pf->hw,
-					     pf->hw.aq.asq_last_status));
+				 libie_aq_str(pf->hw.aq.asq_last_status));
 	}
 	/* reinit the misc interrupt */
 	if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags)) {
@@ -11098,8 +11065,7 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 		dev_warn(&pf->pdev->dev,
 			 "Failed to restore promiscuous setting: %s, err %pe aq_err %s\n",
 			 pf->cur_promisc ? "on" : "off",
-			 ERR_PTR(ret),
-			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			 ERR_PTR(ret), libie_aq_str(pf->hw.aq.asq_last_status));
 
 	i40e_reset_all_vfs(pf, true);
 
@@ -12305,8 +12271,7 @@ static int i40e_get_rss_aq(struct i40e_vsi *vsi, const u8 *seed,
 			dev_info(&pf->pdev->dev,
 				 "Cannot get RSS key, err %pe aq_err %s\n",
 				 ERR_PTR(ret),
-				 i40e_aq_str(&pf->hw,
-					     pf->hw.aq.asq_last_status));
+				 libie_aq_str(pf->hw.aq.asq_last_status));
 			return ret;
 		}
 	}
@@ -12319,8 +12284,7 @@ static int i40e_get_rss_aq(struct i40e_vsi *vsi, const u8 *seed,
 			dev_info(&pf->pdev->dev,
 				 "Cannot get RSS lut, err %pe aq_err %s\n",
 				 ERR_PTR(ret),
-				 i40e_aq_str(&pf->hw,
-					     pf->hw.aq.asq_last_status));
+				 libie_aq_str(pf->hw.aq.asq_last_status));
 			return ret;
 		}
 	}
@@ -12981,8 +12945,7 @@ static int i40e_udp_tunnel_set_port(struct net_device *netdev,
 				     NULL);
 	if (ret) {
 		netdev_info(netdev, "add UDP port failed, err %pe aq_err %s\n",
-			    ERR_PTR(ret),
-			    i40e_aq_str(hw, hw->aq.asq_last_status));
+			    ERR_PTR(ret), libie_aq_str(hw->aq.asq_last_status));
 		return -EIO;
 	}
 
@@ -13001,8 +12964,7 @@ static int i40e_udp_tunnel_unset_port(struct net_device *netdev,
 	ret = i40e_aq_del_udp_tunnel(hw, ti->hw_priv, NULL);
 	if (ret) {
 		netdev_info(netdev, "delete UDP port failed, err %pe aq_err %s\n",
-			    ERR_PTR(ret),
-			    i40e_aq_str(hw, hw->aq.asq_last_status));
+			    ERR_PTR(ret), libie_aq_str(hw->aq.asq_last_status));
 		return -EIO;
 	}
 
@@ -13892,8 +13854,7 @@ static int i40e_add_vsi(struct i40e_vsi *vsi)
 			dev_info(&pf->pdev->dev,
 				 "couldn't get PF vsi config, err %pe aq_err %s\n",
 				 ERR_PTR(ret),
-				 i40e_aq_str(&pf->hw,
-					     pf->hw.aq.asq_last_status));
+				 libie_aq_str(pf->hw.aq.asq_last_status));
 			return -ENOENT;
 		}
 		vsi->info = ctxt.info;
@@ -13922,8 +13883,7 @@ static int i40e_add_vsi(struct i40e_vsi *vsi)
 				dev_info(&pf->pdev->dev,
 					 "update vsi failed, err %d aq_err %s\n",
 					 ret,
-					 i40e_aq_str(&pf->hw,
-						     pf->hw.aq.asq_last_status));
+					 libie_aq_str(pf->hw.aq.asq_last_status));
 				ret = -ENOENT;
 				goto err;
 			}
@@ -13942,8 +13902,7 @@ static int i40e_add_vsi(struct i40e_vsi *vsi)
 				dev_info(&pf->pdev->dev,
 					 "update vsi failed, err %pe aq_err %s\n",
 					 ERR_PTR(ret),
-					 i40e_aq_str(&pf->hw,
-						    pf->hw.aq.asq_last_status));
+					 libie_aq_str(pf->hw.aq.asq_last_status));
 				ret = -ENOENT;
 				goto err;
 			}
@@ -13966,8 +13925,7 @@ static int i40e_add_vsi(struct i40e_vsi *vsi)
 					 "failed to configure TCs for main VSI tc_map 0x%08x, err %pe aq_err %s\n",
 					 enabled_tc,
 					 ERR_PTR(ret),
-					 i40e_aq_str(&pf->hw,
-						    pf->hw.aq.asq_last_status));
+					 libie_aq_str(pf->hw.aq.asq_last_status));
 			}
 		}
 		break;
@@ -14061,8 +14019,7 @@ static int i40e_add_vsi(struct i40e_vsi *vsi)
 			dev_info(&vsi->back->pdev->dev,
 				 "add vsi failed, err %pe aq_err %s\n",
 				 ERR_PTR(ret),
-				 i40e_aq_str(&pf->hw,
-					     pf->hw.aq.asq_last_status));
+				 libie_aq_str(pf->hw.aq.asq_last_status));
 			ret = -ENOENT;
 			goto err;
 		}
@@ -14092,8 +14049,7 @@ static int i40e_add_vsi(struct i40e_vsi *vsi)
 	if (ret) {
 		dev_info(&pf->pdev->dev,
 			 "couldn't get vsi bw info, err %pe aq_err %s\n",
-			 ERR_PTR(ret),
-			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			 ERR_PTR(ret), libie_aq_str(pf->hw.aq.asq_last_status));
 		/* VSI is already added so not tearing that up */
 		ret = 0;
 	}
@@ -14541,8 +14497,7 @@ static int i40e_veb_get_bw_info(struct i40e_veb *veb)
 	if (ret) {
 		dev_info(&pf->pdev->dev,
 			 "query veb bw config failed, err %pe aq_err %s\n",
-			 ERR_PTR(ret),
-			 i40e_aq_str(&pf->hw, hw->aq.asq_last_status));
+			 ERR_PTR(ret), libie_aq_str(hw->aq.asq_last_status));
 		goto out;
 	}
 
@@ -14551,8 +14506,7 @@ static int i40e_veb_get_bw_info(struct i40e_veb *veb)
 	if (ret) {
 		dev_info(&pf->pdev->dev,
 			 "query veb bw ets config failed, err %pe aq_err %s\n",
-			 ERR_PTR(ret),
-			 i40e_aq_str(&pf->hw, hw->aq.asq_last_status));
+			 ERR_PTR(ret), libie_aq_str(hw->aq.asq_last_status));
 		goto out;
 	}
 
@@ -14740,8 +14694,7 @@ static int i40e_add_veb(struct i40e_veb *veb, struct i40e_vsi *vsi)
 	if (ret) {
 		dev_info(&pf->pdev->dev,
 			 "couldn't add VEB, err %pe aq_err %s\n",
-			 ERR_PTR(ret),
-			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			 ERR_PTR(ret), libie_aq_str(pf->hw.aq.asq_last_status));
 		return -EPERM;
 	}
 
@@ -14751,16 +14704,14 @@ static int i40e_add_veb(struct i40e_veb *veb, struct i40e_vsi *vsi)
 	if (ret) {
 		dev_info(&pf->pdev->dev,
 			 "couldn't get VEB statistics idx, err %pe aq_err %s\n",
-			 ERR_PTR(ret),
-			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			 ERR_PTR(ret), libie_aq_str(pf->hw.aq.asq_last_status));
 		return -EPERM;
 	}
 	ret = i40e_veb_get_bw_info(veb);
 	if (ret) {
 		dev_info(&pf->pdev->dev,
 			 "couldn't get VEB bw info, err %pe aq_err %s\n",
-			 ERR_PTR(ret),
-			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			 ERR_PTR(ret), libie_aq_str(pf->hw.aq.asq_last_status));
 		i40e_aq_delete_element(&pf->hw, veb->seid, NULL);
 		return -ENOENT;
 	}
@@ -14955,9 +14906,7 @@ int i40e_fetch_switch_configuration(struct i40e_pf *pf, bool printconfig)
 		if (ret) {
 			dev_info(&pf->pdev->dev,
 				 "get switch config failed err %d aq_err %s\n",
-				 ret,
-				 i40e_aq_str(&pf->hw,
-					     pf->hw.aq.asq_last_status));
+				 ret, libie_aq_str(pf->hw.aq.asq_last_status));
 			kfree(aq_buf);
 			return -ENOENT;
 		}
@@ -15002,8 +14951,7 @@ static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit, bool lock_acqui
 	if (ret) {
 		dev_info(&pf->pdev->dev,
 			 "couldn't fetch switch config, err %pe aq_err %s\n",
-			 ERR_PTR(ret),
-			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			 ERR_PTR(ret), libie_aq_str(pf->hw.aq.asq_last_status));
 		return ret;
 	}
 	i40e_pf_reset_stats(pf);
@@ -15030,8 +14978,7 @@ static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit, bool lock_acqui
 			dev_info(&pf->pdev->dev,
 				 "couldn't set switch config bits, err %pe aq_err %s\n",
 				 ERR_PTR(ret),
-				 i40e_aq_str(&pf->hw,
-					     pf->hw.aq.asq_last_status));
+				 libie_aq_str(pf->hw.aq.asq_last_status));
 			/* not a fatal problem, just keep going */
 		}
 		pf->last_sw_conf_valid_flags = valid_flags;
@@ -15933,8 +15880,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 					 I40E_AQ_EVENT_MODULE_QUAL_FAIL), NULL);
 	if (err)
 		dev_info(&pf->pdev->dev, "set phy mask fail, err %pe aq_err %s\n",
-			 ERR_PTR(err),
-			 i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			 ERR_PTR(err), libie_aq_str(pf->hw.aq.asq_last_status));
 
 	/* VF MDD event logs are rate limited to one second intervals */
 	ratelimit_state_init(&pf->mdd_message_rate_limit, 1 * HZ, 1);
@@ -15956,8 +15902,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		if (err)
 			dev_info(&pf->pdev->dev, "link restart failed, err %pe aq_err %s\n",
 				 ERR_PTR(err),
-				 i40e_aq_str(&pf->hw,
-					     pf->hw.aq.asq_last_status));
+				 libie_aq_str(pf->hw.aq.asq_last_status));
 	}
 	/* The main driver is (mostly) up and happy. We need to set this state
 	 * before setting up the misc vector or we get a race and the vector
@@ -16088,8 +16033,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	err = i40e_aq_get_phy_capabilities(hw, false, false, &abilities, NULL);
 	if (err)
 		dev_dbg(&pf->pdev->dev, "get requested speeds ret =  %pe last_status =  %s\n",
-			ERR_PTR(err),
-			i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			ERR_PTR(err), libie_aq_str(pf->hw.aq.asq_last_status));
 	pf->hw.phy.link_info.requested_speeds = abilities.link_speed;
 
 	/* set the FEC config due to the board capabilities */
@@ -16099,8 +16043,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	err = i40e_aq_get_phy_capabilities(hw, false, true, &abilities, NULL);
 	if (err)
 		dev_dbg(&pf->pdev->dev, "get supported phy types ret =  %pe last_status =  %s\n",
-			ERR_PTR(err),
-			i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			ERR_PTR(err), libie_aq_str(pf->hw.aq.asq_last_status));
 
 	/* make sure the MFS hasn't been set lower than the default */
 #define MAX_FRAME_SIZE_DEFAULT 0x2600
diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index 5dfbe71205e6..ed3c54e36be3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -1053,7 +1053,7 @@ static int i40e_nvmupd_exec_aq(struct i40e_hw *hw,
 		i40e_debug(hw, I40E_DEBUG_NVM,
 			   "%s err %pe aq_err %s\n",
 			   __func__, ERR_PTR(status),
-			   i40e_aq_str(hw, hw->aq.asq_last_status));
+			   libie_aq_str(hw->aq.asq_last_status));
 		*perrno = i40e_aq_rc_to_posix(status, hw->aq.asq_last_status);
 		return status;
 	}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index bd54f06b43cd..aef5de53ce3b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -46,7 +46,6 @@ void i40e_debug_aq(struct i40e_hw *hw, enum i40e_debug_mask mask,
 
 bool i40e_check_asq_alive(struct i40e_hw *hw);
 int i40e_aq_queue_shutdown(struct i40e_hw *hw, bool unloading);
-const char *i40e_aq_str(struct i40e_hw *hw, enum libie_aq_err aq_err);
 
 int i40e_aq_get_rss_lut(struct i40e_hw *hw, u16 seid,
 			bool pf_lut, u8 *lut, u16 lut_size);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index b232edf68ab1..45ce6b0f4501 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1290,9 +1290,8 @@ i40e_set_vsi_promisc(struct i40e_vf *vf, u16 seid, bool multi_enable,
 
 			dev_err(&pf->pdev->dev,
 				"VF %d failed to set multicast promiscuous mode err %pe aq_err %s\n",
-				vf->vf_id,
-				ERR_PTR(aq_ret),
-				i40e_aq_str(&pf->hw, aq_err));
+				vf->vf_id, ERR_PTR(aq_ret),
+				libie_aq_str(aq_err));
 
 			return aq_ret;
 		}
@@ -1306,9 +1305,8 @@ i40e_set_vsi_promisc(struct i40e_vf *vf, u16 seid, bool multi_enable,
 
 			dev_err(&pf->pdev->dev,
 				"VF %d failed to set unicast promiscuous mode err %pe aq_err %s\n",
-				vf->vf_id,
-				ERR_PTR(aq_ret),
-				i40e_aq_str(&pf->hw, aq_err));
+				vf->vf_id, ERR_PTR(aq_ret),
+				libie_aq_str(aq_err));
 		}
 
 		return aq_ret;
@@ -1323,9 +1321,8 @@ i40e_set_vsi_promisc(struct i40e_vf *vf, u16 seid, bool multi_enable,
 
 			dev_err(&pf->pdev->dev,
 				"VF %d failed to set multicast promiscuous mode err %pe aq_err %s\n",
-				vf->vf_id,
-				ERR_PTR(aq_ret),
-				i40e_aq_str(&pf->hw, aq_err));
+				vf->vf_id, ERR_PTR(aq_ret),
+				libie_aq_str(aq_err));
 
 			if (!aq_tmp)
 				aq_tmp = aq_ret;
@@ -1339,9 +1336,8 @@ i40e_set_vsi_promisc(struct i40e_vf *vf, u16 seid, bool multi_enable,
 
 			dev_err(&pf->pdev->dev,
 				"VF %d failed to set unicast promiscuous mode err %pe aq_err %s\n",
-				vf->vf_id,
-				ERR_PTR(aq_ret),
-				i40e_aq_str(&pf->hw, aq_err));
+				vf->vf_id, ERR_PTR(aq_ret),
+				libie_aq_str(aq_err));
 
 			if (!aq_tmp)
 				aq_tmp = aq_ret;
@@ -3748,8 +3744,7 @@ static void i40e_del_all_cloud_filters(struct i40e_vf *vf)
 			dev_err(&pf->pdev->dev,
 				"VF %d: Failed to delete cloud filter, err %pe aq_err %s\n",
 				vf->vf_id, ERR_PTR(ret),
-				i40e_aq_str(&pf->hw,
-					    pf->hw.aq.asq_last_status));
+				libie_aq_str(pf->hw.aq.asq_last_status));
 
 		hlist_del(&cfilter->cloud_node);
 		kfree(cfilter);
@@ -3851,7 +3846,7 @@ static int i40e_vc_del_cloud_filter(struct i40e_vf *vf, u8 *msg)
 		dev_err(&pf->pdev->dev,
 			"VF %d: Failed to delete cloud filter, err %pe aq_err %s\n",
 			vf->vf_id, ERR_PTR(ret),
-			i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			libie_aq_str(pf->hw.aq.asq_last_status));
 		goto err;
 	}
 
@@ -3987,7 +3982,7 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf *vf, u8 *msg)
 		dev_err(&pf->pdev->dev,
 			"VF %d: Failed to add cloud filter, err %pe aq_err %s\n",
 			vf->vf_id, ERR_PTR(aq_ret),
-			i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
+			libie_aq_str(pf->hw.aq.asq_last_status));
 		goto err_free;
 	}
 
-- 
2.47.1


