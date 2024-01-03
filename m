Return-Path: <netdev+bounces-61179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D10822C7D
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 12:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1240B219BD
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 11:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15A31A28F;
	Wed,  3 Jan 2024 11:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DPhFDyz/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136C419469;
	Wed,  3 Jan 2024 11:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704283009; x=1735819009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C3p46caV8CRS4j/dEHJyoZnEtIablwurupbiv6nNHMI=;
  b=DPhFDyz/my2D02keicqCZv6T6z8Du1LA10nwV56+pQPlU7Xd8VVcaryI
   hFo9KXImss8K+ygnr7CkKwLCf4FXenB8+5pWqsYSjhpfaCzquL7tb9IpX
   vDpjWYuoS9Lkb0kLcWsLfZAncIzdz86DJ67+r2oZdLcpiEi7LgvlZJtKY
   1clerfFKahg6Sc1b83i7fG8BoKu3w2Hkc59MgfHOZmwhPtEtB7y37ZF+P
   G9tkCIuSlpAZnHnPO8pwS5bVd/TtMIku+eamU5XYrKguKdZxqQ+QtvMEE
   ValEAEH7eUa/l0LKramYG5HBlKbtFzs2nrEjp8g846gyqDfWkPRBl1oa8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="428169541"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="428169541"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 03:56:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="1111348097"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="1111348097"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jan 2024 03:56:41 -0800
From: lakshmi.sowjanya.d@intel.com
To: tglx@linutronix.de,
	jstultz@google.com,
	giometti@enneenne.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	andriy.shevchenko@linux.intel.com,
	eddie.dong@intel.com,
	christopher.s.hall@intel.com,
	jesse.brandeburg@intel.com,
	davem@davemloft.net,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	pandith.n@intel.com,
	mallikarjunappa.sangannavar@intel.com,
	thejesh.reddy.t.r@intel.com,
	lakshmi.sowjanya.d@intel.com
Subject: [RFC PATCH v3 06/11] ALSA: hda: remove convert_art_to_tsc()
Date: Wed,  3 Jan 2024 17:25:57 +0530
Message-Id: <20240103115602.19044-7-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240103115602.19044-1-lakshmi.sowjanya.d@intel.com>
References: <20240103115602.19044-1-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

Remove convert_art_to_tsc() function call, Pass system clock cycles and
clocksource ID as input to get_device_system_crosststamp().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
---
 sound/pci/hda/hda_controller.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index c42e9ffff9db..787521d7f3b1 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -457,7 +457,8 @@ static int azx_get_sync_time(ktime_t *device,
 	*device = ktime_add_ns(*device, (wallclk_cycles * NSEC_PER_SEC) /
 			       ((HDA_MAX_CYCLE_VALUE + 1) * runtime->rate));
 
-	*system = convert_art_to_tsc(tsc_counter);
+	system->cycles = tsc_counter;
+	system->cs_id = CSID_X86_ART;
 
 	return 0;
 }
-- 
2.35.3


