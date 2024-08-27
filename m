Return-Path: <netdev+bounces-122439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 895BF961526
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 19:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472E7289E96
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 17:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E1C1CFEAE;
	Tue, 27 Aug 2024 17:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8Y8f6VW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA48145025;
	Tue, 27 Aug 2024 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778614; cv=none; b=tWnraHoGNhcqrZsS083KpxNg3FyFo/qb5MLYfySx6YbGJ3SyE/vaqZEfDg2FRUoWyyvtozBB6lqg1VdWSW6yonREIQVjxVyrmgBHIYxYGXDcC8LshWiIc/rt57ySBo1BVRqLuX1QHcpZlvDNWAMIZfE74FPtqrKobgVeNUlTEXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778614; c=relaxed/simple;
	bh=UJMrm3Z4E90c5LDZAHNsoo9YLgJsalTpZPZfOVABDdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R9yAqsoeSZZMQk+P5XPP0fezQqr2j5oO1tQ8J66MH/plZWbaLclkUWw9julLJwOikWYws6sx27kNbuJyCD2YUWXBbNiDroWvg3EhEvxGiTIwiYlQvheGS1tknrWyUDHOomsigic0pIKet7q8n4qlG9sPQoOLf396F690elHc8oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n8Y8f6VW; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724778611; x=1756314611;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UJMrm3Z4E90c5LDZAHNsoo9YLgJsalTpZPZfOVABDdI=;
  b=n8Y8f6VWFh+4Qr7tfcSgsDSFkDsCTv2SnPRKahy+i0b59GSWe1Wde1Hu
   Tfj7Ro+zzBK4Q3JI3Lw2JyX7eHsLA1gCgOgveyjeSVR8ZdeO+0kp5whav
   hzm84bOIlelQaUJCo3XJOaNAe8/opxbp+sijhAeQutrpRvQfHh0ZQxMv2
   4bzHZ4GNFsGntsGXSAiNRE3PcSN5Q+lhOKqq6OPaDli8pA6ruGrwZqLka
   NGA+ulo/UaDCClyY9QCVdZQhWXaGE2v/iWu0JsTJzQqgs4+rTuxzblNi1
   IYCBlDcOkizU5rW8lu3GNIkJnm6G6EB/XjjWeORjXZv1r1kDHWZyS0myO
   w==;
X-CSE-ConnectionGUID: 9a09wnzlTnucps7TXmt/KQ==
X-CSE-MsgGUID: k+F/iuSxT8C5Cp8xXSKCiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="34429743"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="34429743"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 10:10:10 -0700
X-CSE-ConnectionGUID: WrnGbHAIRhGJCoIbZ+B/UQ==
X-CSE-MsgGUID: iX/9fUCrQYu+UNXm8l1yKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="62923144"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 27 Aug 2024 10:10:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B8EE0142; Tue, 27 Aug 2024 20:10:06 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Robert Marko <robimarko@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v1 1/1] net: dsa: mv88e6xxx: Remove stale comment
Date: Tue, 27 Aug 2024 20:10:05 +0300
Message-ID: <20240827171005.2301845-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GPIOF_DIR_* definitions are legacy and subject to remove.
Taking this into account, remove stale comment.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/dsa/mv88e6xxx/global2_scratch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/global2_scratch.c b/drivers/net/dsa/mv88e6xxx/global2_scratch.c
index 61ab6cc4fbfc..53a6d3ed63b3 100644
--- a/drivers/net/dsa/mv88e6xxx/global2_scratch.c
+++ b/drivers/net/dsa/mv88e6xxx/global2_scratch.c
@@ -146,7 +146,7 @@ static int mv88e6352_g2_scratch_gpio_set_data(struct mv88e6xxx_chip *chip,
  * @chip: chip private data
  * @pin: gpio index
  *
- * Return: 0 for output, 1 for input (same as GPIOF_DIR_XXX).
+ * Return: 0 for output, 1 for input.
  */
 static int mv88e6352_g2_scratch_gpio_get_dir(struct mv88e6xxx_chip *chip,
 					     unsigned int pin)
-- 
2.43.0.rc1.1336.g36b5255a03ac


