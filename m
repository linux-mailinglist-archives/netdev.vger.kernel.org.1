Return-Path: <netdev+bounces-223644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D89B59CF3
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 18:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08AEC1BC0091
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5C22877D8;
	Tue, 16 Sep 2025 16:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oHYso7ip"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3768F31FEFE;
	Tue, 16 Sep 2025 16:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038597; cv=none; b=V9Lv9er6lJM9Stq5o+ev26zNSRxC8alSPD9RGelh7pXTLya4cyEAZxZBs7UnkZ8qQ6DV8h/y9usiKIJkGgSnFrStALYqsP2q2r0yC3oiU0hlgOXZvXRbiCtXNHYdIUTjWaJYxIgy9Hh2e6VlzOLO+ssvJ0SkK2ASQVbgHIDcOpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038597; c=relaxed/simple;
	bh=Y3oq6iu4hMkc15Bb7DayMWSnsQ4mDxaKl21fY4WENAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lZC80bhOP46tzkBI1d2gvHFVUspBfNILyFrnqHvFqsA39V2XS2SXvMmsb0j6K5w0ZlfqUpsAPxrFAVqYRiadWBZcT2h8eMNImjT1rlqhEPEimrSYfLzOBxmS3nKg6SPQFuZdUZFoSKwYGE/UrcvHA/x00d2E/KelMKWqx2dgE78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oHYso7ip; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758038585; x=1789574585;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y3oq6iu4hMkc15Bb7DayMWSnsQ4mDxaKl21fY4WENAw=;
  b=oHYso7ipUwKmKAl0vvI01lmhfPfnwiHc44sWcAXBIrONVWmTW7ZXEnQa
   iw7ZWAQBmVV/7Kp0MG7xadNk5HMvys6A8RRkyNVCtalELMweKEArMXuV2
   RN0WvrTqUJNPC6u9pODfjCEmnfeuZ5ZOzQvCbKXsYzaXZ3GOcpGUi23ZX
   tIeORzqUBFx7xsPmNj2Wy9ub76kjK0K4YfMO5LG6311m/3lkQVr/WUy8A
   Q1QQ8a3JLAcu+WozsgLaM1MaSCH4wI6Ge81RSwSUi+J8NRqZSCiE2KYCq
   f5HLZWt2JvPZZ2vIjGUxUOzw4QwIw9MKrfksVP20XIXtDP7r1iHDYHFoY
   Q==;
X-CSE-ConnectionGUID: AE1txbitQfOgMwhkjnb8Jg==
X-CSE-MsgGUID: hi3D1AEMSIG6f3CGW09oSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60253325"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="60253325"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:03:04 -0700
X-CSE-ConnectionGUID: /NaHcznnRSKXw68qFLgrrw==
X-CSE-MsgGUID: e06QmDa/RnS8XPbnl/BbFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="179362246"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa005.fm.intel.com with ESMTP; 16 Sep 2025 09:03:01 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Simon Horman <horms@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] libie: fix linking with libie_{adminq,fwlog} when CONFIG_LIBIE=n
Date: Tue, 16 Sep 2025 18:01:18 +0200
Message-ID: <20250916160118.2209412-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Initially, libie contained only 1 module and I assumed that new modules
in its folder would depend on it.
However, Michał did a good job and libie_{adminq,fwlog} are completely
independent, but libie/ is still traversed by Kbuild only under
CONFIG_LIBIE != n.
This results in undefined references with certain kernel configs.

Tell Kbuild to always descend to libie/ to be able to build each module
regardless of whether the basic one is enabled.
If none of CONFIG_LIBIE* is set, Kbuild will just create an empty
built-in.a there with no side effects.

Fixes: 641585bc978e ("ixgbe: fwlog support for e610")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/all/202509140606.j8z3rE73-lkp@intel.com
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Closes: https://lore.kernel.org/all/CA+G9fYvH8d6pJRbHpOCMZFjgDCff3zcL_AsXL-nf5eB2smS8SA@mail.gmail.com
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
Sending directly to net-next to quickly unbreak net-next and
linux-next builds.
Also to net-next as the blamed commit landed recently and is
not present in any other tree.
---
 drivers/net/ethernet/intel/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/Makefile b/drivers/net/ethernet/intel/Makefile
index 04c844ef4964..9a37dc76aef0 100644
--- a/drivers/net/ethernet/intel/Makefile
+++ b/drivers/net/ethernet/intel/Makefile
@@ -4,7 +4,7 @@
 #
 
 obj-$(CONFIG_LIBETH) += libeth/
-obj-$(CONFIG_LIBIE) += libie/
+obj-y += libie/
 
 obj-$(CONFIG_E100) += e100.o
 obj-$(CONFIG_E1000) += e1000/
-- 
2.51.0


