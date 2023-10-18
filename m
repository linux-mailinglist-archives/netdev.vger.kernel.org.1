Return-Path: <netdev+bounces-42443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C5D7CEBF8
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 01:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78E5FB212EA
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 23:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADC5450CC;
	Wed, 18 Oct 2023 23:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JBQjpNwQ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F101A4292A
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 23:24:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382EF116
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 16:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697671489; x=1729207489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3oeLdPZ4E29kjd284PYRPlBekIGJzdbuvuJVazBGSfI=;
  b=JBQjpNwQkGZw0cOlIPqSwcwRH5I1FX+JOkS9qx0yHlj6q024xNq6B95o
   ykiKH0qmQ2MInquuH0UbuXHZFHYLxBr6XmfXE23zmKvSnGllEaTNzvfSN
   MbOYYXRT/cQu+wR49P7MlJBmzGZFEmQkpn8D9j0uj+0BiAmaHICtxsZRj
   5Uv+xbG+NkMPfDUETkNqswoHuIpz1mXc1Ek8miDQ1bwjnqudgt+GCwaUV
   +inNS444lZRNuCSUmUabK2s6eJz+hYeb+T2nyL6uVkLro/MrfPKM/emO2
   TZNlDrIW5W5uGRnl7C2dd2m0YKQGelqmIXTNGwxHcyxYFGMoxInpjY5Qj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="388996740"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="388996740"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 16:24:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="4732367"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.244.144])
  by fmviesa001.fm.intel.com with ESMTP; 18 Oct 2023 16:24:51 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	andrew@lunn.ch,
	horms@kernel.org,
	anthony.l.nguyen@intel.com,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH net-next v5 6/6] ice: Hook up 4 E830 devices by adding their IDs
Date: Wed, 18 Oct 2023 19:16:43 -0400
Message-ID: <20231018231643.2356-7-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018231643.2356-1-paul.greenwalt@intel.com>
References: <20231018231643.2356-1-paul.greenwalt@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pawel Chmielewski <pawel.chmielewski@intel.com>

As the previous patches provide support for E830 hardware, add E830
specific IDs to the PCI device ID table, so these devices can now be
probed by the kernel.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f47db07df679..66095e9b094e 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5611,6 +5611,10 @@ static const struct pci_device_id ice_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_1GBE) },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E823L_QSFP) },
 	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E822_SI_DFLT) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_BACKPLANE) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_QSFP56) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_SFP) },
+	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_SFP_DD) },
 	/* required last entry */
 	{}
 };
-- 
2.41.0


