Return-Path: <netdev+bounces-237702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DA8C4F227
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 17:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F3F2C4E389E
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 16:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55356377EBA;
	Tue, 11 Nov 2025 16:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kokgp7Ra"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16A93730EC;
	Tue, 11 Nov 2025 16:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762879961; cv=none; b=jlTdDW448BPA5E5c1xguEAlUbhxXbvmRf9IjYgEfh9SO31rp8Abwgw3l5QIL6GzgAaDC3xcnXAHUEgnrX3dwSJIMyXTG3hcBUP6uNCyz6beZozQexBLBfo/+Dva8dMJQUNIi+DkcIk2qkbnu12R/0XDmNuJm4UCMkGD+rb4rj+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762879961; c=relaxed/simple;
	bh=QS3TFWuwHYfnFtUUf2G1VSXpVmg82xEHmr0g8k6jmuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwOUhR/Oxb1D/I6Y5tkYODf1XmxO90/rNET778BTVL8zYn4DF+2SqVycgU2k1qYEhbYwAI+7tgzWdiafvEl1WxDj2KYzAkWe4cfV6S4p32YHjICysQvnkWFNT5M5kkcmhY5zMewKsZ4RgrE2F/YIuLs51Dl5JVIl1HNqYw7gY/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kokgp7Ra; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762879959; x=1794415959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QS3TFWuwHYfnFtUUf2G1VSXpVmg82xEHmr0g8k6jmuw=;
  b=kokgp7Ra4KLFqiTFAmbXXhm7B30TbZLmLwaptOIXvVTnnBYYV+zef94F
   1yigHdppD8bqLomBesWOZOox2UFzuucGYloKy37+IUWSvy1bdaaWTvXBr
   LQVaULiYwNzgak5mUD5kLz8kKdSQBNFkLcT7SadDqblZJ3SuiuAn+QPAT
   fPDnguGHFYAkG2X8Iab/oEb0HE7MA/DbA5FoqLuzp1lNcQLya16+rzzxP
   3r7PQ/opgFgod2DaIgoZJLtZGNnCfV65ZEVQBSLBWpfVC/huUQqUdOT3A
   Csxt9JqdWPhOdM3+jwETqdpXWNE+muwzlQHeL21QQxjrn+mIdSqe0jlOi
   A==;
X-CSE-ConnectionGUID: WNC8yBgbSCCLHUUwWkP0Vg==
X-CSE-MsgGUID: bZEZ1S51S9OYHtFIxwJBzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="64647241"
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="64647241"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 08:52:36 -0800
X-CSE-ConnectionGUID: BGLcAh3ITSGWFpZ05p/Tag==
X-CSE-MsgGUID: RgQ7KHTuR+SBeIWZf20zgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,297,1754982000"; 
   d="scan'208";a="194202542"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 11 Nov 2025 08:52:34 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 7575F99; Tue, 11 Nov 2025 17:52:33 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Richard Cochran <richardcochran@gmail.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v1 3/7] ptp: ocp: Refactor ptp_ocp_i2c_notifier_call()
Date: Tue, 11 Nov 2025 17:52:10 +0100
Message-ID: <20251111165232.1198222-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251111165232.1198222-1-andriy.shevchenko@linux.intel.com>
References: <20251111165232.1198222-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor ptp_ocp_i2c_notifier_call() to avoid unneeded local variable.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ptp/ptp_ocp.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 28243fb1d78f..1dbbca4197bc 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -4872,16 +4872,6 @@ ptp_ocp_i2c_notifier_call(struct notifier_block *nb,
 {
 	struct device *dev, *child = data;
 	struct ptp_ocp *bp;
-	bool add;
-
-	switch (action) {
-	case BUS_NOTIFY_ADD_DEVICE:
-	case BUS_NOTIFY_DEL_DEVICE:
-		add = action == BUS_NOTIFY_ADD_DEVICE;
-		break;
-	default:
-		return 0;
-	}
 
 	if (!i2c_verify_adapter(child))
 		return 0;
@@ -4894,10 +4884,17 @@ ptp_ocp_i2c_notifier_call(struct notifier_block *nb,
 
 found:
 	bp = dev_get_drvdata(dev);
-	if (add)
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
 		ptp_ocp_symlink(bp, child, "i2c");
-	else
+		break;
+	case BUS_NOTIFY_DEL_DEVICE:
 		sysfs_remove_link(&bp->dev.kobj, "i2c");
+		break;
+	default:
+		return 0;
+	}
 
 	return 0;
 }
-- 
2.50.1


