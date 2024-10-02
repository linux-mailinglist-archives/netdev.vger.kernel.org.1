Return-Path: <netdev+bounces-131190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F0D98D286
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 13:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F501C20C4D
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 11:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1DC1EBFF8;
	Wed,  2 Oct 2024 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LT+CbkMk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808DF197A7C
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 11:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727870000; cv=none; b=AkH9TWADXgZILg0ro18wI0SZW4VNCtYns2dstveChmXEj+HQwl7LT/a+CKjSv4d1Y3jQEf1JExtLf2HEbyyozbH/VyW4y1y8vel3RMe/Yhm0Cpw1KjdILwLeDMMAJnvEk4cIAdymCl+rWaV+IfFBIRucUC92Xoc63smIPcj3Wy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727870000; c=relaxed/simple;
	bh=kcPe5wu23W0KcN/YzSanoOP4+gck7fThbzZePZEyrsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p4J9vlHA5HoFAOJDuCIOINzmhFxIWqCMJWsMMG/RW96cwGz1q5FtY0Rxzf2hsgPzeTZiawAbzVU3uKtVIQXaIioHNtm3aIn6jYU9UVaY1vF5hbMz5tqpDAxHLvg1O9ue0K1LshyLAR9J5eLZqSqC+wY7YOX6vGf3csud7XpTCUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LT+CbkMk; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727869998; x=1759405998;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kcPe5wu23W0KcN/YzSanoOP4+gck7fThbzZePZEyrsQ=;
  b=LT+CbkMkOxFQnjyNPW8Ng2WYvTnxgZQ5WQOh+evYFpo6C0yjxwmG2RFF
   tO4dsi7709GA8v4L9o3PDIxcf3GitWNt0XB/axm1cc1bXbCvXvsj817+V
   zcnkZbzHgfAofufcPpywnYuCWeIpdDbNDAUU4Z2KmomBPcXWhGooAqlQ4
   8uwqlC0ooRKjY83ijVJhR7fXoeU8HOw/j8xlMdFlwwk/BfsVGyCS24h7d
   aReG2vgxcEESlXiH2gfDW3MspgI/PGPWSUSkqDtyAQjRxZ7WHpSpayBL3
   1r3PTEdFP06oVmIpTrC+4k/rfcygeaTTDbkfSSJciRpb/1pXB/kwmqM6s
   w==;
X-CSE-ConnectionGUID: /C+Gv5QjTqe84OZSrE7n5w==
X-CSE-MsgGUID: ImmygBPhQl2wdoXfkspOjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="27183842"
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="27183842"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 04:53:18 -0700
X-CSE-ConnectionGUID: j4tzPV4sQ8auhekKuqpEpA==
X-CSE-MsgGUID: t9FGusYQQvOl22mERRm8vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="78396372"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 02 Oct 2024 04:53:16 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.246.21])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 2944927BD5;
	Wed,  2 Oct 2024 12:53:14 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next 0/4] ice: init HW before ice_adapter
Date: Wed,  2 Oct 2024 13:50:20 +0200
Message-ID: <20241002115304.15127-6-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series moves ice_init_hw() call to be prior to ice_adapter init.
To do so we need:
 (patch 1) move waiting for FW into ice_init_hw();
 (patch 2) split ice_init_hw() out of ice_init_dev(), so it could be
           manually called in ice_init(). The change mandates similar
           split in ice_devlink_reinit_up(). To keep things consistent
           ice_deinit_hw() is also extracted to be called manually.

(Patch 4) finally changes the order in ice_probe() to move ice_adapter
          init past the ice_init_hw() call.
Patch 3 does minor cleanup after patch 2, to keep diffs more readable.

The whole motivation is to have ability to act on the number of PFs
in ice_adapter initialization. This series is not doing that (but I've
print-tested that such number is correct there).
Code is also a bit cleaner, so overall it's good to go in an incremental
fashion IMO.

Przemek Kitszel (4):
  ice: c827: move wait for FW to ice_init_hw()
  ice: split ice_init_hw() out from ice_init_dev()
  ice: minor: rename goto labels from err to unroll
  ice: ice_probe: init ice_adapter after HW init

 drivers/net/ethernet/intel/ice/ice_common.h   |   1 -
 .../net/ethernet/intel/ice/devlink/devlink.c  |  10 +-
 drivers/net/ethernet/intel/ice/ice_common.c   | 110 ++++++++++++------
 drivers/net/ethernet/intel/ice/ice_main.c     |  88 +++++---------
 4 files changed, 110 insertions(+), 99 deletions(-)


base-commit: c94f1e05dfa83f1a8875111756c52955d721e60f
-- 
2.46.0


