Return-Path: <netdev+bounces-164124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC2DA2CADE
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 19:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA9A188D8AD
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 18:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B2819DF5F;
	Fri,  7 Feb 2025 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BCRJZ9M7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CC619ADA2
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 18:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738951722; cv=none; b=mBaRyeRTBGbs/jmpEtRfV686UicYx5DWOhI4R35f9r2fCqpMkCfjZ8b/ANBQ7qFyZpJq5hNeHLkalsq7LQ9wnItzvAoxsMTd1e5YDwApjZZeDw9gcfwVBfCuhEsvIHxE4pVrZGSX6z6MMaMDh9xFDqTjBSilGEpUvdHvtgvoQag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738951722; c=relaxed/simple;
	bh=sAwdtgk0CrHBLbeGMTfCXrAD0j0R2rEF9a62rfdB4bA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cpYWZ70cwaKQ2PfJfVn2wZ0mwJcg7hr7Txepg3RplEyWnEej8c/g4TT5j/M1tkCo8svCoE4AuYIKKwNuc8IQ4KUz5HjTjg78qfhiop9VDR+VQ5gQHFtE0XzdV3sH6PmpA+ZGFsdd4Vkeac8RudJFW1Fn5eC2/+9HC4mFXcymsk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BCRJZ9M7; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738951720; x=1770487720;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sAwdtgk0CrHBLbeGMTfCXrAD0j0R2rEF9a62rfdB4bA=;
  b=BCRJZ9M7I98IXNH1e+xVORXgYl8aF7krL0XbpLpc1fobqUlgk4bias2o
   bW59mzRt92pm3rcrZgqIVkIHgfkE+y9vQro+61ezlLMZvhcazbpG6Dkf1
   zO4nwUVIjf7bOLOnFLH1AK2wM+9+7N4cVJ8A6Ef+RSGu3R91FCutAQcmu
   wnoN4ZvI7E3r1y+xaVzKP746r2Y/We4G6p1v0ej2gkk2S47Ql3mNAMQyb
   Yt1CT/8z4IXEltF6fr5hTQKozmX7YCi5f/csgEiZVG8sTM2cA/E533A8W
   LYPCr6y+a23NnuNHWYUImWdRK5yGinxy/WM2upRPorlZbOB8esuCDlqiU
   Q==;
X-CSE-ConnectionGUID: KRSP8ioJTNK5xtFANhXW5g==
X-CSE-MsgGUID: inKaEqB0Rz2z8nEcybOfww==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="39865626"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="39865626"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 10:08:39 -0800
X-CSE-ConnectionGUID: hu6FgR58SUO3fa+60xdZLg==
X-CSE-MsgGUID: qjuK7UQuTLS+v1gLOjAWrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112486301"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orviesa008.jf.intel.com with ESMTP; 07 Feb 2025 10:08:38 -0800
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH iwl-next 0/3] ice: decouple control of SMA/U.FL/SDP pins
Date: Fri,  7 Feb 2025 19:02:51 +0100
Message-Id: <20250207180254.549314-1-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously control of the dpll SMA/U.FL pins was partially done through
ptp API, decouple pins control from both interfaces (dpll and ptp).
Allow the SMA/U.FL pins control over a dpll subsystem, and leave ptp
related SDP pins control over a ptp subsystem.

Arkadiusz Kubalewski (1):
  ice: redesign dpll sma/u.fl pins control

Karol Kolacinski (2):
  ice: change SMA pins to SDP in PTP API
  ice: add ice driver PTP pin documentation

 .../device_drivers/ethernet/intel/ice.rst     |  13 +
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 952 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_dpll.h     |  23 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 254 +----
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   3 -
 5 files changed, 1011 insertions(+), 234 deletions(-)


base-commit: 233a2b1480a0bdf6b40d4debf58a07084e9921ff
prerequisite-patch-id: 2cda134043ccfc781dd595052cfc60a3e2ea48ea
prerequisite-patch-id: 62ac41823e7278621af3745a171aae07508711c8
prerequisite-patch-id: 1330728a760d99174344cb421336ae9b01e17f38
prerequisite-patch-id: ff2afa3e3a2c60a590d17a880b610e2a37e7af0c
prerequisite-patch-id: cbff95efd09cb57e17c68c464ee1e317d01cf822
prerequisite-patch-id: e5be07f7b169f2443c034f04e3d0a00a8d0a8894
prerequisite-patch-id: a5f362eec88b62ff098203469cef8534f176d2a8
prerequisite-patch-id: 545b9e38f61ccfd5b33ab9c3e3a6e7a9f899e306
prerequisite-patch-id: a74b6b981ecd8a320284454d75b1dfc9e555b5f0
prerequisite-patch-id: df0a5f503065fa5869b1c915721a54eb3c7394cb
prerequisite-patch-id: faebd604b0a6eb2a888e99b8977f803abe035abf
prerequisite-patch-id: b7543662f5225ce13a1c95749504c68ef4733aea
prerequisite-patch-id: a7297c1e743f01d118c7f77b39e5755f7a704e17
prerequisite-patch-id: 6f036cdf7bca2a272b153ecc5b3a767f41517c38
prerequisite-patch-id: bb790f877236aad43dae0bdbdceb0a3553260d10
prerequisite-patch-id: 2f53433b0d2a98cd42b18429bdbec1542b175b1f
prerequisite-patch-id: cc9bf85bb9d988d92ab6cb1524bf213ec1351032
prerequisite-patch-id: 112c048b7ae143edda05244b0d8b5ab928d3eff4
prerequisite-patch-id: 124be0607c41aebe292c7b81910857489027baf1
prerequisite-patch-id: b6b5f0e405d566879133d53c26fd998e9f330ff2
prerequisite-patch-id: 777e25e09efe2ec4863e3bebdb247bac3e037c85
prerequisite-patch-id: bf13dbef14d654b243150d4f2603eb90ae497058
prerequisite-patch-id: 76f1c5ef5dacad0600339d5cf843ca14fcfa9dde
prerequisite-patch-id: 586431a13be4f1ecf0adf450242aa7e90975d38f
prerequisite-patch-id: e5c687a47edf3659dca8519e4c5250bbea89171b
prerequisite-patch-id: 9f8081c59e275240cd76911fbede7d2737473357
prerequisite-patch-id: f4d6edba52edea1276e0095e132733f4438de720
prerequisite-patch-id: 5e7afab1204a42d90b8b6a14e3881cf1d4987954
prerequisite-patch-id: 708e14a83a03377f2909b3ce0d72d21a4619a03d
prerequisite-patch-id: ae9720262fb8d1f92b157865f02a9fc7d9aa1582
prerequisite-patch-id: 11c806ab6cc8d29c86218d5760ca22cf3ef2ae05
prerequisite-patch-id: 1aae146d6c20d41b4785d37962052a52c320ac3b
prerequisite-patch-id: 59b00a073b5055091ccf55905e746a372dfc5e8e
prerequisite-patch-id: 5b640578751b48ab50748dbe6f864ce14f1978c9
prerequisite-patch-id: 725ea892cdefd598a1841323c6e74efe160dd3fe
prerequisite-patch-id: 03bb4b3b1f37211fbcd379a19ebff5621c9d901f
prerequisite-patch-id: 877ab147dd7c2e56beeb97bc4651fef89590cc23
prerequisite-patch-id: 798f81cfb09f75af615986689658787d29427e85
prerequisite-patch-id: 4e64a22702fa030f57436da273da1093153cfa7a
prerequisite-patch-id: c8b8f75ae6c949e68a8ee0b6e7b09344a700663f
prerequisite-patch-id: 19fed1ea4aaa320e4a4e46f9c39c7e994f09c7d9
prerequisite-patch-id: 546c7611f620c90a054da039dd19cbc7339edb39
prerequisite-patch-id: 272344e3e7ca650f3833ad62ffa75aa3b080fd72
prerequisite-patch-id: b1d967b8973ec9320e239653773c7caa9d54de70
-- 
2.38.1


