Return-Path: <netdev+bounces-102847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECEA90510A
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 13:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A036EB21222
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 11:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFDF16F0D1;
	Wed, 12 Jun 2024 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UszO4po+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0909016F0F0
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718190248; cv=none; b=og0AwjBm3tQfu4VJAkdhWtxErqk2THL3p+gOUsr1LvZGjhqNYVfYaKvXxY9K5hSW9ni2GFgIpMcW8xJZlXTPjduHs9ZpBYtQjS+vck9xdMESeBK5KVMQTofCTu6d5EG8jbzpbeCxCFjFDzVGvqF0WAsnQ5dbV/nLXXd6NQqpIPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718190248; c=relaxed/simple;
	bh=pw+RJOP5tBxwzihRkSI6e94yGizrIsoHviIc8xOIVv8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HZGbIbdy44LjJpjs2k41UNebld1mJAmOhLU/24dNinRBbV9DCDsc89lqUkA8F1Y/wHqmTI9ELgJ/qgPCBxt4wMzApZfTQbgtJoGllMfmlxNdzvJTuzxjfIHZuAFtbEvFUQgGt0dOtCL+2kZM73QpwFajPM8yamikgKKpDApFE3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UszO4po+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718190246; x=1749726246;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pw+RJOP5tBxwzihRkSI6e94yGizrIsoHviIc8xOIVv8=;
  b=UszO4po+mmM0972Ekn3K0Ajmegl7GtKbAIWW8vLzvID0u6S+cwhR53+m
   RFfC1CMv1O7kgnk3tSL2/9AB+iJbYj2SHB7RpBK/4gJLoZjmFdalx/+jB
   ttjU0NyBNqfzZbx6iqTjmhd0w356J2CkDtRyC6YRmACJxCHCL2DletKfZ
   BeDt84hpCXzr4susTj1MrKbuZY0nti92IJeiPWYnxKwguYKAr8HRj6Zxg
   Yj9A9Qy4hBA/zxZ/aiH5Vvt+ICbJtJ3KGX+aJgOG7uf2q2vJPAZN5lQkK
   bljQiQNDpV2szjKS9XbB3F5alOzIx4wkPBVxXy/T71GLqkP8wTXKDJkNM
   w==;
X-CSE-ConnectionGUID: jGtjltniTQyCCa0oYy4h+w==
X-CSE-MsgGUID: litA2gQOTky7Eh7ClnQBSA==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="37467999"
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="37467999"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 04:04:05 -0700
X-CSE-ConnectionGUID: YhHQvWt6T5yOp7WqOVD85A==
X-CSE-MsgGUID: yOaMtA6vRryqRzSsyA938A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="44151451"
Received: from unknown (HELO amlin-019-225.igk.intel.com) ([10.102.19.225])
  by fmviesa003.fm.intel.com with ESMTP; 12 Jun 2024 04:04:04 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Kelvin Kang <kelvin.kang@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH iwl-net v3] i40e: fix hot issue NVM content is corrupted after nvmupdate
Date: Wed, 12 Jun 2024 13:04:02 +0200
Message-Id: <20240612110402.3356700-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bug affects users only at the time when they try to update NVM, and
only F/W versions that generate errors while nvmupdate. For example X710DA2
with 0x8000ECB7 F/W is affected, but there are probably more...

After 230f3d53a547 patch, which should only replace F/W specific error codes
with Linux kernel generic, all EIO errors started to be converted into EAGAIN
which leads nvmupdate to retry until it timeouts and sometimes fails after
more than 20 minutes in the middle of NVM update, so NVM becomes corrupted.

Remove wrong EIO to EGAIN conversion and pass all errors as is.

Fixes: 230f3d53a547 ("i40e: remove i40e_status")
Co-developed-by: Kelvin Kang <kelvin.kang@intel.com>
Signed-off-by: Kelvin Kang <kelvin.kang@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
reproduction:
./nvmupdate64

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


