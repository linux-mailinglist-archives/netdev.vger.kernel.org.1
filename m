Return-Path: <netdev+bounces-126700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E85C9723DB
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 22:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15071C237FA
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 20:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0674318B493;
	Mon,  9 Sep 2024 20:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LiMjjxiH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BD118B46D
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 20:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725914350; cv=none; b=rkSelekU0pdcdQbZFsubVhYRLKBNEPTKkbhnliiAICEkbnma4oCazo9rNqCEdE8pO3aA7yZCrbOiowSG4Q8AtzCuSp7DO4zxuiQL/RfvVC2jcXCx6N6c+2CXS6Eq21tP4VwppyaUf5U4OY4ERuPtvuVlA6avig117w+usFWmhXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725914350; c=relaxed/simple;
	bh=aYmd3+COS+USN9mmcTDE7li6X29cDuYrVazlIQ+pBPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LcKrUDVJP3Rc0NXflX81HaOgW17xZmAmGDSorv04m1Ljgbu64WF5qXSKUq5yP6RKPya65ROKEFIVboEMssAnG3RYaw3noq7g/xepChnSIQ5Za17QMST6n5h7DGNdh5qszDgnClWdwLlikf6T8UHQ+3c60d47rypDjAS7ek8xZw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LiMjjxiH; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725914349; x=1757450349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aYmd3+COS+USN9mmcTDE7li6X29cDuYrVazlIQ+pBPc=;
  b=LiMjjxiHuIMJArZL/QSnYJACzo+1ZwiQuANRFBHPbSna7lLq9WdogoT9
   57ouFP2bw+JnNgnhOc8vKH5mAUkxr9CaBOv4iw4vR69g+sMrjKinC+jae
   8K9YbUKvwxO2X8ws9bQtPDA0W9p4c1DSTrPbpzM0RKTPnjhxkwWRZ4UUv
   IsfEsJGPjz0g9pUClTf8TvTSNcJEC8cZTf46aDfk0QYY878YaV/l/CdtF
   zvtOR+XV/ueTZNhGtkPw/9zhOca01D4EPO7TmOeT/IiRGPQ+1LUzQ0hDb
   pFTvx0M6h9+CUqDyd+Zgz6SbDDfDBscK1sK52SQSI+Om8SJtRYFYqLOPa
   g==;
X-CSE-ConnectionGUID: 7Hd0XHTuQ5KZLWssIDWHrg==
X-CSE-MsgGUID: QlGvy81AT+6pzhO6xb1ijQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24787132"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="24787132"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 13:39:01 -0700
X-CSE-ConnectionGUID: I0+ucAqlTASJ64Fllsgmqw==
X-CSE-MsgGUID: Ocq1oOSkQI6I4rBb6K1J4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="67054816"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 09 Sep 2024 13:38:50 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	pstanner@redhat.com,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 3/5] ice: stop calling pci_disable_device() as we use pcim
Date: Mon,  9 Sep 2024 13:38:39 -0700
Message-ID: <20240909203842.3109822-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20240909203842.3109822-1-anthony.l.nguyen@intel.com>
References: <20240909203842.3109822-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Our driver uses devres to manage resources, in particular we call
pcim_enable_device(), what also means we express the intent to get
automatic pci_disable_device() call at driver removal. Manual calls to
pci_disable_device() misuse the API.

Recent commit (see "Fixes" tag) has changed the removal action from
conditional (silent ignore of double call to pci_disable_device()) to
unconditional, but able to catch unwanted redundant calls; see cited
"Fixes" commit for details.

Since that, unloading the driver yields following warn+splat:

[70633.628490] ice 0000:af:00.7: disabling already-disabled device
[70633.628512] WARNING: CPU: 52 PID: 33890 at drivers/pci/pci.c:2250 pci_disable_device+0xf4/0x100
...
[70633.628744]  ? pci_disable_device+0xf4/0x100
[70633.628752]  release_nodes+0x4a/0x70
[70633.628759]  devres_release_all+0x8b/0xc0
[70633.628768]  device_unbind_cleanup+0xe/0x70
[70633.628774]  device_release_driver_internal+0x208/0x250
[70633.628781]  driver_detach+0x47/0x90
[70633.628786]  bus_remove_driver+0x80/0x100
[70633.628791]  pci_unregister_driver+0x2a/0xb0
[70633.628799]  ice_module_exit+0x11/0x3a [ice]

Note that this is the only Intel ethernet driver that needs such fix.

Fixes: f748a07a0b64 ("PCI: Remove legacy pcim_release()")
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Reviewed-by: Philipp Stanner <pstanner@redhat.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c7db88b517da..ea780d468579 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5363,7 +5363,6 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	ice_deinit(pf);
 err_init:
 	ice_adapter_put(pdev);
-	pci_disable_device(pdev);
 	return err;
 }
 
@@ -5470,7 +5469,6 @@ static void ice_remove(struct pci_dev *pdev)
 	ice_set_wake(pf);
 
 	ice_adapter_put(pdev);
-	pci_disable_device(pdev);
 }
 
 /**
-- 
2.42.0


