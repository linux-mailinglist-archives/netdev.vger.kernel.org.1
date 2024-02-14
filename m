Return-Path: <netdev+bounces-71799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2226E8551C7
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 19:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CD50B25EC0
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 18:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA0A12C7ED;
	Wed, 14 Feb 2024 18:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MlzhLu4q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3E31292D4
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 18:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933839; cv=none; b=QVfHoHG66EGH5Cct7Bff/NsDndaw2ECFGAB1pIvzZx7kzNGuJqR73XtDkCsRWKyXZQvUKAlsTK1/qkzvBKh5qZgq63vYgU/LO4qlJUAgSC1tO7SRT+ggps0ms0gOyyhZdbzUQvbOuinpDElowrHtfzcaZAjkdsKkz7Ddnk5zZ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933839; c=relaxed/simple;
	bh=PWXdIblookDijSfqMOMpSP4+lbqMrGUrpyCfsPTnJjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FFSdGrN5OmebA2aUwhVM6ky+AzoXK8g7DKIEGxDgWNXSGBqKjzy+WlqpFezhWbKYJxMNTax4Qsi3bSmUDYJL4sw1iIg6ezl2yUX/IPwVkYaiA+Mo59fQWbNgR4+GuyHGqM7yyiyFci8OXvKarKG0oeWAuriUozxV5salICi84cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MlzhLu4q; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707933838; x=1739469838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PWXdIblookDijSfqMOMpSP4+lbqMrGUrpyCfsPTnJjU=;
  b=MlzhLu4qGoqalZDzltKGLdb6vbFzgXedH6P47WKhGp+Kj/+bBk/GvpyI
   0ltyY/ZocvMc+BMsEJBY6pBzi/KpQuaFhqLWRqtlRnc/0vb010zLYs5H7
   5NihOcxuHUwLJWb7NaN1YsT//qMEPlYaz8JAy4AcALoySR2EdgzdTBZss
   BhRsk0Ey9VfU9PO4zqnaz4N5gUzLD5N4boC4MkfKpeu01FTwlVapKLgZw
   wV+qHZ0cq/eufWNrEENMNJBU/WaiGyloFSCmUx2xd7XuHp5Fy/6fPi7qY
   l8onsO9j569Qxsal/nSbeBygRkHr+CV6o0sB0Apqp68XO+NGnF2Ad1szj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="19505800"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="19505800"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 10:03:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="3251275"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 14 Feb 2024 10:03:55 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Kunwu Chan <chentao@kylinos.cn>,
	anthony.l.nguyen@intel.com,
	Kunwu Chan <kunwu.chan@hotmail.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net v2 1/2] igb: Fix string truncation warnings in igb_set_fw_version
Date: Wed, 14 Feb 2024 10:03:44 -0800
Message-ID: <20240214180347.3219650-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240214180347.3219650-1-anthony.l.nguyen@intel.com>
References: <20240214180347.3219650-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <chentao@kylinos.cn>

Commit 1978d3ead82c ("intel: fix string truncation warnings")
fixes '-Wformat-truncation=' warnings in igb_main.c by using kasprintf.

drivers/net/ethernet/intel/igb/igb_main.c:3092:53: warning：‘%d’ directive output may be truncated writing between 1 and 5 bytes into a region of size between 1 and 13 [-Wformat-truncation=]
 3092 |                                  "%d.%d, 0x%08x, %d.%d.%d",
      |                                                     ^~
drivers/net/ethernet/intel/igb/igb_main.c:3092:34: note：directive argument in the range [0, 65535]
 3092 |                                  "%d.%d, 0x%08x, %d.%d.%d",
      |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/igb/igb_main.c:3092:34: note：directive argument in the range [0, 65535]
drivers/net/ethernet/intel/igb/igb_main.c:3090:25: note：‘snprintf’ output between 23 and 43 bytes into a destination of size 32

kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure.

Fix this warning by using a larger space for adapter->fw_version,
and then fall back and continue to use snprintf.

Fixes: 1978d3ead82c ("intel: fix string truncation warnings")
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Cc: Kunwu Chan <kunwu.chan@hotmail.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb.h      |  2 +-
 drivers/net/ethernet/intel/igb/igb_main.c | 35 ++++++++++++-----------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index a2b759531cb7..3c2dc7bdebb5 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -637,7 +637,7 @@ struct igb_adapter {
 		struct timespec64 period;
 	} perout[IGB_N_PEROUT];
 
-	char fw_version[32];
+	char fw_version[48];
 #ifdef CONFIG_IGB_HWMON
 	struct hwmon_buff *igb_hwmon_buff;
 	bool ets;
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 4df8d4153aa5..cebb44f51d5f 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3069,7 +3069,6 @@ void igb_set_fw_version(struct igb_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
 	struct e1000_fw_version fw;
-	char *lbuf;
 
 	igb_get_fw_version(hw, &fw);
 
@@ -3077,34 +3076,36 @@ void igb_set_fw_version(struct igb_adapter *adapter)
 	case e1000_i210:
 	case e1000_i211:
 		if (!(igb_get_flash_presence_i210(hw))) {
-			lbuf = kasprintf(GFP_KERNEL, "%2d.%2d-%d",
-					 fw.invm_major, fw.invm_minor,
-					 fw.invm_img_type);
+			snprintf(adapter->fw_version,
+				 sizeof(adapter->fw_version),
+				 "%2d.%2d-%d",
+				 fw.invm_major, fw.invm_minor,
+				 fw.invm_img_type);
 			break;
 		}
 		fallthrough;
 	default:
 		/* if option rom is valid, display its version too */
 		if (fw.or_valid) {
-			lbuf = kasprintf(GFP_KERNEL, "%d.%d, 0x%08x, %d.%d.%d",
-					 fw.eep_major, fw.eep_minor,
-					 fw.etrack_id, fw.or_major, fw.or_build,
-					 fw.or_patch);
+			snprintf(adapter->fw_version,
+				 sizeof(adapter->fw_version),
+				 "%d.%d, 0x%08x, %d.%d.%d",
+				 fw.eep_major, fw.eep_minor, fw.etrack_id,
+				 fw.or_major, fw.or_build, fw.or_patch);
 		/* no option rom */
 		} else if (fw.etrack_id != 0X0000) {
-			lbuf = kasprintf(GFP_KERNEL, "%d.%d, 0x%08x",
-					 fw.eep_major, fw.eep_minor,
-					 fw.etrack_id);
+			snprintf(adapter->fw_version,
+				 sizeof(adapter->fw_version),
+				 "%d.%d, 0x%08x",
+				 fw.eep_major, fw.eep_minor, fw.etrack_id);
 		} else {
-			lbuf = kasprintf(GFP_KERNEL, "%d.%d.%d", fw.eep_major,
-					 fw.eep_minor, fw.eep_build);
+			snprintf(adapter->fw_version,
+				 sizeof(adapter->fw_version),
+				 "%d.%d.%d",
+				 fw.eep_major, fw.eep_minor, fw.eep_build);
 		}
 		break;
 	}
-
-	/* the truncate happens here if it doesn't fit */
-	strscpy(adapter->fw_version, lbuf, sizeof(adapter->fw_version));
-	kfree(lbuf);
 }
 
 /**
-- 
2.41.0


