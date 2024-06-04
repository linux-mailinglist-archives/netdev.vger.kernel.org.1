Return-Path: <netdev+bounces-100550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83D38FB1C9
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 14:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 169B71C22019
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 12:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CA6145B06;
	Tue,  4 Jun 2024 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pe7XpP7n"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3770D15E8B
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717502765; cv=none; b=tHmSl/tvfu0Stx53pbLozqxxBr94XL3692nqQ0h0EpASOVUcfDCjP3CZYNychEKGzRMAQgrbqiVHs7fjFDDqTp86S8IJPtduGDKrgB+wgPlG7h94JPOk8V19KChCZtx8VWJFPHgRxl2jLIILkPHwTRBPzahDvpkM3rYezXNNU5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717502765; c=relaxed/simple;
	bh=o1YAN7FkOfKevY3c8bMdeaeCWTzVvn5YklFYqiI5QIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A2L6OAXPmNchXscJlIFQvosnewl7MsqFQieuO5/dFV2++WLChAHPNOxe5Man+1vpq2OJlpOvq9WP0ngPUQ0+vCRz54teKYcOBdvrNy0eNrVfSusR9X2rLns8ei+hyJD/XjF+3HbH4xY2ejqnaYdVk9fEdZdclNWVhFOCuhh6T5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pe7XpP7n; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717502764; x=1749038764;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o1YAN7FkOfKevY3c8bMdeaeCWTzVvn5YklFYqiI5QIg=;
  b=Pe7XpP7nackzy+KaDLcWWP1NCIG3GYIElx5pnE+0baMhxxANDeTdeedv
   U05EmqiQhSqYaitqyCuaAgZJfnp4mZhbpCcgDGJIO/knrla7j0fDeXRez
   SBfWzQ5BP2kUIkUjsp2B1f2fXYBOMHrMBFbmeJG7N3G022HKdlfaEI5VB
   PMqvtoEePPdl7RGRxX4TXrcYfCtNIWiE7q0jiHQqsz4s4WSlDWcxpu2OZ
   +KbdvNouI7q4/Te0ZdI7Asu42SftuxvYatYE3GJxSupJ/UGuUkhfTiNRd
   vgJyeiTwUQc53yv8j1DwTHjVp9nfMKUfZCQGZEIl/CaXy7wE8LtE5JZQT
   A==;
X-CSE-ConnectionGUID: TMEBcHjUQtS4oPqOifh/ow==
X-CSE-MsgGUID: Vg5gK+tKSH++rLV+dJVrNg==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="25444644"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="25444644"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 05:06:03 -0700
X-CSE-ConnectionGUID: uH6WIYOYRgGrthWecpPXCg==
X-CSE-MsgGUID: +wpCLEghTn+oawkQtHk5Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37086278"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by fmviesa007.fm.intel.com with ESMTP; 04 Jun 2024 05:06:02 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	richardcochran@gmail.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH net] ptp: Fix error message on failed pin verification
Date: Tue,  4 Jun 2024 14:05:27 +0200
Message-ID: <20240604120555.16643-1-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On failed verification of PTP clock pin, error message prints channel
number instead of pin index after "pin", which is incorrect.

Fix error message by adding channel number to the message and printing
pin number instead of channel number.

Fixes: 6092315dfdec ("ptp: introduce programmable pins.")
Cc: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/ptp/ptp_chardev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 7513018c9f9a..2067b0120d08 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -85,7 +85,8 @@ int ptp_set_pinfunc(struct ptp_clock *ptp, unsigned int pin,
 	}
 
 	if (info->verify(info, pin, func, chan)) {
-		pr_err("driver cannot use function %u on pin %u\n", func, chan);
+		pr_err("driver cannot use function %u and channel %u on pin %u\n",
+		       func, chan, pin);
 		return -EOPNOTSUPP;
 	}
 

base-commit: 2ab79514109578fc4b6df90633d500cf281eb689
-- 
2.43.0


