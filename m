Return-Path: <netdev+bounces-106627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 637B8917090
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 20:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED741F22CF6
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 18:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C1C1369B6;
	Tue, 25 Jun 2024 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ForO7w/n"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DDE144306
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719341400; cv=none; b=pTJHj43t3wzFB2R2++h/VwwpUUxIk0ZuyiFJgIQfuz3lJQdiLK/Yd5uqvEeZBNzrJgUkf7VhEos8fiTK7l4MwBc9CD1PM1P2lvkFdvRog+QI+3n0uWIFE2rkc98b6N+hVMelVBqQ0DVsI3ZD83dBgJO8HD2ZuWez4wGG3YV80Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719341400; c=relaxed/simple;
	bh=I9+x5dwtD4RCBDpgMKxC/11FGcUFxcGqqLv62GSTPTY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AETCWM9VFw8GkBzdISSnm8qk+0djuCnsu6RQhG+hAV7qy9VkdT/5clT4d7wvCS6ZYv/axMLqsyuS9zsHBAr9SkqMrLqbGE3Xe/DiGG7qpT5ijD3MPKuA/f419jEFSFpFpGb2fmVWYLKlnWaOeCykDcLUvnonp1+Vc6Wt7MuHiY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ForO7w/n; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719341397; x=1750877397;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I9+x5dwtD4RCBDpgMKxC/11FGcUFxcGqqLv62GSTPTY=;
  b=ForO7w/nQ7ctS0r6SCJeLUGgo8t7SoNW9r4T976dUeBGAoEJzEXOdCL2
   gYGNTCDvTuhI2/cXt4xLNGrsDQaL6LMfEDjD3fSAHHonVbNeRUAn6xD2g
   vM2nbK2ihpaEqGHuOoWoD6B7ixnVy/MWL0nkgGtI6Ek66tW0LmMKvli3r
   N/sdYYVUsV/xGMa7GI87Xz3taX3V1/iJQ+O2ZqdyEbkWiVBbl/ndaSs7N
   WciyM0MmmO8/0Exo9UEF6ZKaYRPHwwJEhz2FbJ5Uy/VSYI5PcFg5r+MIm
   uCZGhVXB0Z709o4amhgZRaRs09gN/sbACq3gdVgw4L49GH5QXXcdIrVVG
   g==;
X-CSE-ConnectionGUID: Jsd5eLFmSIqsZybCMxaWJw==
X-CSE-MsgGUID: W3/hHp76S6CLn7gg3EzNwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="26969771"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="26969771"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 11:49:56 -0700
X-CSE-ConnectionGUID: CpKab/YiTq64pFtkTZ4gEQ==
X-CSE-MsgGUID: sjZqw6orQU2SYiFkfvWxEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48192336"
Received: from unknown (HELO amlin-019-225.igk.intel.com) ([10.102.19.225])
  by fmviesa005.fm.intel.com with ESMTP; 25 Jun 2024 11:49:56 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Kelvin Kang <kelvin.kang@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH iwl-net v5] i40e: fix: remove needless retries of NVM update 
Date: Tue, 25 Jun 2024 20:49:53 +0200
Message-Id: <20240625184953.621684-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove wrong EIO to EGAIN conversion and pass all errors as is.

After commit 230f3d53a547 ("i40e: remove i40e_status"), which should only
replace F/W specific error codes with Linux kernel generic, all EIO errors
suddenly started to be converted into EAGAIN which leads nvmupdate to retry
until it timeouts and sometimes fails after more than 20 minutes in the
middle of NVM update, so NVM becomes corrupted.

The bug affects users only at the time when they try to update NVM, and
only F/W versions that generate errors while nvmupdate. For example, X710DA2
with 0x8000ECB7 F/W is affected, but there are probably more...

Command for reproduction is just NVM update:
 ./nvmupdate64

In the log instead of:
 i40e_nvmupd_exec_aq err I40E_ERR_ADMIN_QUEUE_ERROR aq_err I40E_AQ_RC_ENOMEM)
appears:
 i40e_nvmupd_exec_aq err -EIO aq_err I40E_AQ_RC_ENOMEM
 i40e: eeprom check failed (-5), Tx/Rx traffic disabled

The problematic code did silently convert EIO into EAGAIN which forced
nvmupdate to ignore EAGAIN error and retry the same operation until timeout.
That's why NVM update takes 20+ minutes to finish with the fail in the end.

Fixes: 230f3d53a547 ("i40e: remove i40e_status")
Co-developed-by: Kelvin Kang <kelvin.kang@intel.com>
Signed-off-by: Kelvin Kang <kelvin.kang@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v4->v5 commit message update
https://lore.kernel.org/netdev/20240618132111.3193963-1-aleksandr.loktionov@intel.com/T/#u
v3->v4 commit message update
v2->v3 commit messege typos
v1->v2 commit message update
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.h b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
index ee86d2c..55b5bb8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
@@ -109,10 +109,6 @@ static inline int i40e_aq_rc_to_posix(int aq_ret, int aq_rc)
 		-EFBIG,      /* I40E_AQ_RC_EFBIG */
 	};
 
-	/* aq_rc is invalid if AQ timed out */
-	if (aq_ret == -EIO)
-		return -EAGAIN;
-
 	if (!((u32)aq_rc < (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0]))))
 		return -ERANGE;
 
-- 
2.25.1


