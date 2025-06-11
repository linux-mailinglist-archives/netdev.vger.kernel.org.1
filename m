Return-Path: <netdev+bounces-196467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F623AD4EB1
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8673A8232
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061431865E3;
	Wed, 11 Jun 2025 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eva4gneo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9EE282ED
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 08:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749631569; cv=none; b=aSvZwNhjvEDUxQRjL8hYj+tibJggMHu2v1dk3SJ4ERTCAt0N7NIs2BuG9TjdNwP3rv92tJ0IJ7+nhLL1h/2x/CD3WqEwTLuYiqoxg4IzfYzOLewvm0Jbl4OuY60LQPnv2yv3v9OpxT0Oo/Jsrio4MtS/rYqPOKN+PjxZMQJJ8Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749631569; c=relaxed/simple;
	bh=+hlyDmCmIQ4PsUfkbEueYhY4IaOnijscWCQJVN/4tnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dcaP99he7+gKJC1oF7FQpL5PR16IBg2LYj5i/y9U3ivAIg825kytSgEA4Gi+Qa1oejnpbgzRcwhlUZlGaH+pPUBQVHKY6YT+x+p6sUquj8HIcW/J4on1tygIgsmMib5HKWk6b5BY2Cx+NcxBiYg9PcMedwMmPSilacJ81w3pVx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eva4gneo; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749631569; x=1781167569;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+hlyDmCmIQ4PsUfkbEueYhY4IaOnijscWCQJVN/4tnQ=;
  b=eva4gneovopDVBHYVDgnnGbiz02YkcW9Qmh2DXGU0WFzchOxh8QQ6sv+
   QZp3sP85dyGUMANKZ+/XpuqFiKoQ8l17S/ds6oxwRl3WSR7k6sIp4lEJn
   0QAlO9sft5FaAEsUkVk2b8b+c10imFKWu/pO3ILa5feVkcTJws7UpIfVk
   8F00IUn0pGDuRmf+tImlmgaEvCJGzcYZo6m205Qwbkft1J/Kxs0gA2WSY
   THEoKkOFI8gDZ4LtWZjYCWpKI4x/WayvsYaK6YqOfa5JulrkL/Vwm5Nuf
   FO5piKdjOZ18d6uJZtX267ih8THSqBuuMFzL8x5CBHS3QXTy9WEsuo8eD
   Q==;
X-CSE-ConnectionGUID: F8nTOJyxQHecrRC+0AQhyg==
X-CSE-MsgGUID: 40+uDuHkQfqo3X5iJId2uA==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="62046150"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="62046150"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 01:46:08 -0700
X-CSE-ConnectionGUID: PgUZ6FMQQ5iE88b0EVrLEg==
X-CSE-MsgGUID: mv/cWiQBTwuxby+dZJQ7Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="152298372"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 11 Jun 2025 01:46:06 -0700
Received: from kord.igk.intel.com (kord.igk.intel.com [10.123.220.9])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 834F5332AE;
	Wed, 11 Jun 2025 09:46:05 +0100 (IST)
From: Konrad Knitter <konrad.knitter@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Konrad Knitter <konrad.knitter@intel.com>
Subject: [PATCH iwl-next v1 0/3] add override mask from factory settings
Date: Wed, 11 Jun 2025 11:01:19 +0200
Message-Id: <20250611090122.4312-1-konrad.knitter@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support for restoring settings and identifiers from factory settings
instead of using those found in the image during the update.
 
Restoring data from factory settings requires restoring both settings
and identifiers simultaneously. Other combinations are not supported.
 
The following command can be used to overwrite settings and
identifiers with data from factory settings.
 
$ devlink dev flash <pci-address> <update-image.bin> overwrite settings
     overwrite identifier overwrite from_factory_settings

Konrad Knitter (3):
  devlink: add overwrite mask from factory settings
  ice: add overwrite mask from factory settings
  ixgbe: add overwrite mask from factory settings

 Documentation/networking/devlink/devlink-flash.rst | 3 +++
 Documentation/networking/devlink/ice.rst           | 6 ++++++
 drivers/net/ethernet/intel/ice/ice_fw_update.c     | 4 ++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_fw_update.c | 6 ++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h | 1 +
 include/uapi/linux/devlink.h                       | 2 ++
 6 files changed, 22 insertions(+)

-- 
2.38.1


