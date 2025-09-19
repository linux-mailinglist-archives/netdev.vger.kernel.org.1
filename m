Return-Path: <netdev+bounces-224828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF81B8AD56
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 19:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDAC517ECC7
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 17:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B8D322DBA;
	Fri, 19 Sep 2025 17:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LWqxtkwH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE786322C71
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758304465; cv=none; b=krluzpS4NFd+bCx7tMyzAIAHrcr9r7iCWA8oJH/cai4c7eJlzTPvsoJ37697asFzzkESdniYbVqPWNZTIjaC1A8rCQmrmdbBGfs1q+3XwVDhVSuEJzhgjE021Jw0X4hC+wfvM+0L16e2VZS5rmrlrFFzfupDXEW+PHBIpAdpDPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758304465; c=relaxed/simple;
	bh=NUukid5bWz8pnRe9ge7xxWRTRYMe1P1Yf9yLg8ZfUbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZ+zBDegRnDtYHabITjgQuu/ect/b6uIyENv/8BUqLZzUoiL+3tQm7d/6P3LLqNLJFtbU9S3nydLr89+IE50y4+0WcpMWycERR1Cthux7gY+QGfK7mpbnvwUKiW0B031Fm1nAps36zGfvEoVVP2k11w0rvuyhv8bEsafvdtWEuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LWqxtkwH; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758304464; x=1789840464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NUukid5bWz8pnRe9ge7xxWRTRYMe1P1Yf9yLg8ZfUbE=;
  b=LWqxtkwHpzXBPApSOAPVurMVnq/SIep0bAMrykOYhAzVP/3BP6LNalNQ
   mvsw+GVP+Z+EsRI4DMBKhFwrB5VGBjaSAg7/TiTiM7hkksgLVxrTAWIji
   JFYfyTcUqYi8m75uTsNOrE7UXCEO6xTyQGnvEpY27w3PboIKrXfk/rAqE
   kn296zn7ha30zxJx2Iy5JeFS+UD3t2WomzFwBtkPcHQxPMDoZt34UQLgV
   htrOqpy1PcLBw4df9zTqS1LdFYubncJIHlHyr35c1bMsXhgTMYFUSwGZ0
   gWNviDAUDPOYeIqs5W5y0f1ZE7pzJikVWkcxpqz1DbMctsTDDQiY2Pkvn
   A==;
X-CSE-ConnectionGUID: c6Q4w7/wQtKbfwravqBy4g==
X-CSE-MsgGUID: WiBRRdFaShukehAi3EwLBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="78097089"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="78097089"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 10:54:22 -0700
X-CSE-ConnectionGUID: V3AADDnWSQKkk98Ord0yhA==
X-CSE-MsgGUID: O1S/3Ly9Sw+D6wOI4FcnjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="176709491"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 19 Sep 2025 10:54:21 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH net-next 5/7] iavf: fix proper type for error code in iavf_resume()
Date: Fri, 19 Sep 2025 10:54:08 -0700
Message-ID: <20250919175412.653707-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250919175412.653707-1-anthony.l.nguyen@intel.com>
References: <20250919175412.653707-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

The variable 'err' in iavf_resume() is used to store the return value
of different functions, which return an int. Currently, 'err' is
declared as u32, which is semantically incorrect and misleading.

In the Linux kernel, u32 is typically reserved for fixed-width data
used in hardware interfaces or protocol structures. Using it for a
generic error code may confuse reviewers or developers into thinking
the value is hardware-related or size-constrained.

Replace u32 with int to reflect the actual usage and improve code
clarity and semantic correctness.

No functional change.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 69054af4689a..c2fbe443ef85 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -5491,7 +5491,7 @@ static int iavf_resume(struct device *dev_d)
 {
 	struct pci_dev *pdev = to_pci_dev(dev_d);
 	struct iavf_adapter *adapter;
-	u32 err;
+	int err;
 
 	adapter = iavf_pdev_to_adapter(pdev);
 
-- 
2.47.1


