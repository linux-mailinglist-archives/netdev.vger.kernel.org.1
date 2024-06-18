Return-Path: <netdev+bounces-104544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B205990D2A9
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 15:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A243A1C228DB
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC8415AAB1;
	Tue, 18 Jun 2024 13:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="luCTMmq3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E9B13D8B6
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716885; cv=none; b=IoazrONMyX5+G899Y8nargK/fzMejha2BuBY/9hhpF0UdV5uNnrQ8sbYQp2+EWsHMQJGmgMsH9ptPI6GU+i9BbrXO/X1RR5cvDAnHdDQBQJvYJN+w/huk19+lGAjjZUnf83t7u94FbX85MagcD89hW1Ww5u6BrXY1Jc99o5EK8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716885; c=relaxed/simple;
	bh=wy7j2R85Pbh6Ocvt3qLCd/PJ4DM68J2wxPkzjTBaZ3E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U1VDALHSsJ0i9vaodi+P5+hqUT5sJ0bOcYzqTWsa4j4NuAPQRVgkXWqb096TCp2B+Vo50jwcgWEmJRdmWJJkUpf5z8ZzYNOY3a9L9P2Bmyt3Wc+ihi07Ybr3Fi+N3SXPZkDS60T51t9xfQXlNKB8TXtxA/1JBkkZMfoA3If7CSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=luCTMmq3; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718716884; x=1750252884;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wy7j2R85Pbh6Ocvt3qLCd/PJ4DM68J2wxPkzjTBaZ3E=;
  b=luCTMmq3zggm8DBfqgvd49iJgKpsaocKos+eL0SC2QsEATfU/pCwJAyz
   fAWPbyjVP6ZhenKfm0pV6GzbAjEdqXKMmbwXZsnqYIeBspTNEvvBcWeBF
   0msAkV7a8EZGSBYvZkGq/VWAusrodP1mzoG0cdVMc9JbFKg2yJSe9AsYb
   gZpMu7nOmkgDjGYFgebjya2Zjggk8OKQmczlpQBXCOeDbJirWmKY2+cXu
   wH5fjuL6DABHpS3OaYGwsu6gQXMfxwB7CNJNjiHemUWsS15yCDDnxPwye
   NiJ5aatYlFxOKF5cSkGR9WwfmqnBbv4o3ulsuubgTvXM5NgsdNA7NOjek
   g==;
X-CSE-ConnectionGUID: QoSF6L0BSUeYeQGpyp2YsA==
X-CSE-MsgGUID: NcEdpFr3SCqgBuEpvIukMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="41002051"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41002051"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 06:21:14 -0700
X-CSE-ConnectionGUID: A2te/nlgSiWgiljpCu8qjw==
X-CSE-MsgGUID: 9ZfXCtzbRT+gsPyXEmTY3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41500950"
Received: from unknown (HELO amlin-019-225.igk.intel.com) ([10.102.19.225])
  by fmviesa008.fm.intel.com with ESMTP; 18 Jun 2024 06:21:12 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Kelvin Kang <kelvin.kang@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH iwl-net v4] i40e: fix hot issue NVM content is corrupted after nvmupdate
Date: Tue, 18 Jun 2024 15:21:11 +0200
Message-Id: <20240618132111.3193963-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bug affects users only at the time when they try to update NVM, and
only F/W versions that generate errors while nvmupdate. For example, X710DA2
with 0x8000ECB7 F/W is affected, but there are probably more...

Command for reproduction is just NVM update:
 ./nvmupdate64

In the log instead of:
 i40e_nvmupd_exec_aq err I40E_ERR_ADMIN_QUEUE_ERROR aq_err I40E_AQ_RC_ENOMEM)
appears:
 i40e_nvmupd_exec_aq err -EIO aq_err I40E_AQ_RC_ENOMEM

But the problematic code did silently convert EIO into EAGAIN which forced
nvmupdate to ignore EAGAIN error and retry the same operation until timeout.
That's why NVM update takes 20+ minutes to finish with the fail in the end.

After commit 230f3d53a547 ("i40e: remove i40e_status"), which should only
replace F/W specific error codes with Linux kernel generic, all EIO errors
suddenly started to be converted into EAGAIN which leads nvmupdate to retry
until it timeouts and sometimes fails after more than 20 minutes in the
middle of NVM update, so NVM becomes corrupted.

Remove wrong EIO to EGAIN conversion and pass all errors as is.

Fixes: 230f3d53a547 ("i40e: remove i40e_status")
Co-developed-by: Kelvin Kang <kelvin.kang@intel.com>
Signed-off-by: Kelvin Kang <kelvin.kang@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
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


