Return-Path: <netdev+bounces-187096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F49AA4ED5
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 16:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C828B188A1CD
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 14:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9959525D1F4;
	Wed, 30 Apr 2025 14:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PUrxa8lb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21422B9A9;
	Wed, 30 Apr 2025 14:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746023890; cv=none; b=cR6CrsVlhbVfy1xpY0sGCec5SzDuxwBwcggc3UwcKKUJ0CisgYscEhcvmAz7xaINWlroNZbfGFS+t+8aWKTRTp8rqSusqtrLWRg6MTGYyHmXMZn+usSr1qRtzzICH0L5cPbVwdmzZTwzSLPblqD8hgfX9TP4qO6B0cMzE3O/WsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746023890; c=relaxed/simple;
	bh=XTeb/V05SMLTptJNxoOGRKH8ypSvBSWvVzWBfz9OxAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RbR+nHzZFMg58sxslkDicQ/Ji9bXAgsyjzzwN4kHPpBaGFKYlvz/vEqmh8yyfLNhofxEO8+WsGD64hTUSc1x2vplfocxt+fFWigd0OR/VQTxPSm+CsDG0QxavSSa396Kgy+G6S9fx4OuvJkywsLz4hJfZCDDykn4Obyt9AkgV1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PUrxa8lb; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746023889; x=1777559889;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XTeb/V05SMLTptJNxoOGRKH8ypSvBSWvVzWBfz9OxAQ=;
  b=PUrxa8lb79sUcH3Uh4xdcBJR0fXKzfVJg89QoxKQoy+x/jr9qRmOrCzl
   EM8i4M7z45y1qv8q1H31OxSqq0iWQ2NEJnLt3lgoUXZ9GYfCAsd4ICxPP
   fg5jAIlFS5MWQgHkn7n0Mm1cIP+/r/0iwojsRsqdGh/QhtZz3lPg5MX6z
   a9djtD3hkT1ygH82CWTNtTi8VL4gyqYPPABFYijreOP8gBGdoipVwwgOY
   u1xPgCywkmZEQ9T3dC5Z685x8c86lucSIySy8q1o+mpKrD8PZVU+lZscX
   HQGQprzJMB8ZuArbpvUuZZaD/QrM+qA06i59Kk0nduLuvxEqYiuoKUM6c
   Q==;
X-CSE-ConnectionGUID: 99pyfKB2R9i8LpP6lxWFQQ==
X-CSE-MsgGUID: U+j1aAzPQcyJtBOHnymEsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="73072879"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="73072879"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 07:38:08 -0700
X-CSE-ConnectionGUID: LGD0t8ZzRQOKnM0888XfNw==
X-CSE-MsgGUID: NZlU0TNiT0yVl6Qq0PZnLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="138946263"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 30 Apr 2025 07:38:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4F8859F; Wed, 30 Apr 2025 17:38:03 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v1 1/1] net: phy: Refactor fwnode_get_phy_node()
Date: Wed, 30 Apr 2025 17:38:02 +0300
Message-ID: <20250430143802.3714405-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor to check if the fwnode we got is correct and return if so,
otherwise do additional checks. Using same pattern in all conditionals
makes it slightly easier to read and understand.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/phy/phy_device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index f85c172c446c..2eb735e68dd8 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3265,12 +3265,12 @@ struct fwnode_handle *fwnode_get_phy_node(const struct fwnode_handle *fwnode)
 
 	/* Only phy-handle is used for ACPI */
 	phy_node = fwnode_find_reference(fwnode, "phy-handle", 0);
-	if (is_acpi_node(fwnode) || !IS_ERR(phy_node))
+	if (!IS_ERR(phy_node) || is_acpi_node(fwnode))
 		return phy_node;
 	phy_node = fwnode_find_reference(fwnode, "phy", 0);
-	if (IS_ERR(phy_node))
-		phy_node = fwnode_find_reference(fwnode, "phy-device", 0);
-	return phy_node;
+	if (!IS_ERR(phy_node))
+		return phy_node;
+	return fwnode_find_reference(fwnode, "phy-device", 0);
 }
 EXPORT_SYMBOL_GPL(fwnode_get_phy_node);
 
-- 
2.47.2


