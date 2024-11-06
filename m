Return-Path: <netdev+bounces-142297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 862729BE25D
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B81771C22E45
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 09:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4864E1D90C5;
	Wed,  6 Nov 2024 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vzjy73SR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00951D54F2;
	Wed,  6 Nov 2024 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730885075; cv=none; b=qOtpsF8hsVe9V9TXJx+7b9EDw7ifDtzxiYEehg62lzXs0INoLdCUy2szv8uRqPTjhQiVSiqNGRgINGoLHA+qQZ46Tm7xEqPBze7A8X+c+3zMX/dVCQ7JhHpEaC6idG39pOT0cx9DjJOh6tywXIOSu+SNCDJrsmAT7HYPrg0pnS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730885075; c=relaxed/simple;
	bh=lSx6RpfxeZDBlJRdZ14NbzOHSwa0eAELlC3WjgXjqSM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gq2w2sM5MowceVTqU3lFN9M6JU7QkSqHWt5bxYGn8IvaSQNd9U0MBBMbF92uZ0ZEJGZ0B9iIr4q1Dr7ceTlqEGZwXOFw3Z2wCnJboKnAfdo2q3HR0+hb+ZQulTo/gESahTPY6EDT5ozKp6a5RfEHp+yRsUXa/FCGlTSPIKExc5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vzjy73SR; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730885074; x=1762421074;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lSx6RpfxeZDBlJRdZ14NbzOHSwa0eAELlC3WjgXjqSM=;
  b=Vzjy73SR8pkXBEc7+s9rk7jWm+da1acF+LF8r7YBk+G62PSHnb4Dp9vI
   NaBtQaDFJMd/qI1SUsVYppO/PCIMUfLK2m8kL5QnF2kGeL7yFu+KrFiR4
   0addY0lk0c5J9JOK5UAngFhL/hHbls+k5ZZCLrr7X3e+Z1E1gpf2hcLAk
   Sdp1TKqMOAc4swJyh8PhLO27YXDQCGfI4mGK6rlre7wl0cnEtjLIvy5i/
   ofKsYUAONpm9v9HfRg9jplX77kxFfofNnv5OXai/QTeOFu+/vUGeoGwda
   AfCdbus46rSn+vepdx4djugX1qU8KkRUVjaJ1o8MLqS5Av07nQhoyYoU4
   A==;
X-CSE-ConnectionGUID: w+cAZjrvT6Wyiixxj33fcA==
X-CSE-MsgGUID: vUy6U90KS02x9j8zErGeGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34368386"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34368386"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 01:24:33 -0800
X-CSE-ConnectionGUID: UvcYAVK8TsO38gRbR87bwg==
X-CSE-MsgGUID: rLO9vz0hQOmdSHrVJtXe4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="115221974"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa001.fm.intel.com with ESMTP; 06 Nov 2024 01:24:11 -0800
Received: from kord.igk.intel.com (kord.igk.intel.com [10.123.220.9])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id F36F02877B;
	Wed,  6 Nov 2024 09:24:09 +0000 (GMT)
From: Konrad Knitter <konrad.knitter@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: jacob.e.keller@intel.com,
	netdev@vger.kernel.org,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Konrad Knitter <konrad.knitter@intel.com>
Subject: [PATCH iwl-next v2 0/3] support FW Recovery Mode
Date: Wed,  6 Nov 2024 10:36:40 +0100
Message-Id: <20241106093643.106476-1-konrad.knitter@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable update of card in FW Recovery Mode

v2: Update pldmfw commit description

Konrad Knitter (3):
  pldmfw: enable selected component update
  devlink: add devl guard
  ice: support FW Recovery Mode

 .../net/ethernet/intel/ice/devlink/devlink.c  |  8 ++-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  1 +
 .../net/ethernet/intel/ice/ice_fw_update.c    | 14 ++++-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  6 +++
 drivers/net/ethernet/intel/ice/ice_lib.h      |  1 +
 drivers/net/ethernet/intel/ice/ice_main.c     | 53 +++++++++++++++++++
 include/linux/pldmfw.h                        |  8 +++
 include/net/devlink.h                         |  1 +
 lib/pldmfw/pldmfw.c                           |  8 +++
 9 files changed, 97 insertions(+), 3 deletions(-)

-- 
2.38.1


