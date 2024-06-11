Return-Path: <netdev+bounces-102521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C102D903756
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 11:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08B51C20A85
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 09:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB8717623A;
	Tue, 11 Jun 2024 09:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jI5HG1Ax"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304972230F
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 09:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718096532; cv=none; b=XcZcYqcwQknjHHkwt9B5m4foMm/YH6suF2llaP2QfFxif398PiMjtJ4gwXaYvnLHWAEKM8jOOxNYdpC8Ttp2VvER6p7K1/QCKDCP9cq5Syy1JKLLFtdgPBBHhPHhgUa1LoW+yRu0VOPD7oYHe+FJJo58fhwELS7oRt95sEg+2ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718096532; c=relaxed/simple;
	bh=o5oMdw1jtOwX+wVFtzv419bPWRR3QoJ7tZR1sp+wrL8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nn4LmFf4m9g+GZoloVJ/LPoPdgV0A48NcxIGB2pEqd2t4mehRb2mpRlkDk7sHEe0wugCCBmF8QwPJB72CDMcD2Oqv7IYcm3pZpr1ShS9wSjOz3YVwQUlx8eVlShfmulMuH9NcVRVQORSPmUDvLE4dAw2bU0fxXISsyRoae0FBq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jI5HG1Ax; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718096531; x=1749632531;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o5oMdw1jtOwX+wVFtzv419bPWRR3QoJ7tZR1sp+wrL8=;
  b=jI5HG1AxaID7K8zkxhSsIbYEPS9cf9cXG2NA3zMnDd9QdiSkZ3z0KVVP
   Nzyut8CNFOdHlOjBYCU5HWaYt/+hMHLI+vWBaxD77RLH5lL8tlVcAwq+N
   9c1P/XRFNN3Q2U6jho9Y+HTdBqYOxMfe8z5gh96vrAtZ1aXoAeKl7rWYY
   uX5wgU9PGyfpSoLWpJIG0pgU5+wAhX6O/9Ry4+6mgmkbfhD9oUNMxf2L8
   Mmt377N0vCGFPmS/ivx1FcFEuGZBizU1F7k057zj7Cntj8aj008ICyLNU
   8fb3kIHArzWyRIItxPUnxLJ2plMi6u9sfFfRi/1tB2xOEuk8ZU8O4qqkZ
   w==;
X-CSE-ConnectionGUID: bSe5zya2RGG9LexDQcfkbQ==
X-CSE-MsgGUID: /Uy4ccn2RQaz7tPmTjhMrQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="26195830"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="26195830"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 02:02:10 -0700
X-CSE-ConnectionGUID: TlDpxxU1T2WvZyGuOmK6vQ==
X-CSE-MsgGUID: USs4J3iBRUeREVwNTbFocw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="43927406"
Received: from unknown (HELO amlin-019-225.igk.intel.com) ([10.102.19.225])
  by fmviesa004.fm.intel.com with ESMTP; 11 Jun 2024 02:02:08 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Kelvin Kang <kelvin.kang@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH iwl-net v2] i40e: fix hot issue NVM content is corrupted after nvmupdate
Date: Tue, 11 Jun 2024 11:02:07 +0200
Message-Id: <20240611090207.2661520-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bug affects users ionly at the time when they try to update NVM, and
only F/W versions that generate errors while nvmupdate. For example X710DA2
with 0x8000ECB7 F/W is affected, but there are probably more...

After 230f3d53a547 patch, which should only replace F/W specific error codes
into Linux kernel generic, all I/O errors started to be converted into EAGAIN
which leads nvmupdate to retry until it timeout so nvmupdate sometimes
fails after more than 20 minutes in the middle of NVM update,
so NVM becomes corrupted.

Remove wrong EIO to EGAIN conversion and pass all errors as is.

Fixes: 230f3d53a547 ("i40e: remove i40e_status")
Co-developed-by: Kelvin Kang <kelvin.kang@intel.com>
Signed-off-by: Kelvin Kang <kelvin.kang@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
reproduction:
./nvmupdate64

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


