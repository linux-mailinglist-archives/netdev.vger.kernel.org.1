Return-Path: <netdev+bounces-110684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 334DA92DC04
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 00:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6414D1C20F20
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 22:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118731411DF;
	Wed, 10 Jul 2024 22:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DCcNgycB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C98433D8
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 22:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720651517; cv=none; b=BkgqeG1/VrTVObA6PYGn04yfF6Dc+UEBx1JAS0VIo2x0iIA7Fk+BhGVkh/iQ5Atj2UbWMgzOlho1nOuYavR5VaQmqvtoy6ONd2ihRSSGanELQhqg75ZQrvEZYt4h5bOffkvwScgFyJHlKc7GG9Z7qqkO2AZ68+RVskuJEJTjsfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720651517; c=relaxed/simple;
	bh=z2jtfrFbYMvXG3EnXXP1Xnr5qIcMcD6v+Ip6Py2DpHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QMc0Y+aa2hwZa/bJ2QQAPpi/GEJazygIlXK1NxI3O5yFKF0igj9EvEgvb3aXtTggJzUQfD9WPpJYl5BtnI9Zc41gkHLuHsjPshYnDdIWyO3c8EuCajgjiYzTo2C3R5o0FbLGuzEVogbSaQ+oI1sXqSknaFN68+ZjiUzoj4Q9aTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DCcNgycB; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720651515; x=1752187515;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z2jtfrFbYMvXG3EnXXP1Xnr5qIcMcD6v+Ip6Py2DpHE=;
  b=DCcNgycBtQt1tfzmE1xvVi0jYY85aEaWFrX4pp0sMY88Mdr44Uu6YbDD
   KTnUunBTbLtAmxMy8gvWl4LFxO2je+U5JISbZQWj97huDko/ldAg0Nppn
   TYko0g0wWsPNcu1tLwoEcr/z99K6a6vXigjOkG9NLXqqelloOJWO99K6i
   HrLpJ3d0DjgSd/gU7OzjPaQW4zkzKY1dLD/+jAhzYG+Y8kal2J58wtlEm
   ydlc4ORzDDrkd3M2RThTl02h5kaEt/pL+4ZB18H0asltOTImsNU82z24W
   EkoVfBqtUI/hKMRAEtsNl3eAmUPr2bhY18SZTiKDL2A4pMp7A+91uj7Y6
   A==;
X-CSE-ConnectionGUID: vt8ZuWqJSMSEkmpxGlAK8g==
X-CSE-MsgGUID: zzd7oP9tSfOaHQOMkWySqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="17624098"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="17624098"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 15:45:12 -0700
X-CSE-ConnectionGUID: M6GZhR/tSIGd3Pk0+mx04w==
X-CSE-MsgGUID: 9nZkdwt2Rai1dUQGqOvoyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="79084478"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 10 Jul 2024 15:45:10 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	leon@kernel.org,
	Kelvin Kang <kelvin.kang@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Brelinski <tony.brelinski@intel.com>
Subject: [PATCH net] i40e: fix: remove needless retries of NVM update
Date: Wed, 10 Jul 2024 15:44:54 -0700
Message-ID: <20240710224455.188502-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

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
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Tony Brelinski <tony.brelinski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.h b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
index ee86d2c53079..55b5bb884d73 100644
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
2.41.0


