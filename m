Return-Path: <netdev+bounces-239370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB4DC673D0
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 05:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 808EF4E14C8
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 04:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B935274FD0;
	Tue, 18 Nov 2025 04:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mLnz63NY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF08F1624C5
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 04:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763439759; cv=none; b=XHXfgHwLyPqFdjAIXduSvs1xQxD06GZDeW4mWfBRnovPsbTbKfRHaxZo8AZY52AK/c9g4bAzkJqi6qZ38df2h8nPjug9ll1aHjwk1bQT8PB6v6FkFZ64vfGTJ5tIEikrnsoYiDIjdZCL+HodXGB9uZ8YaJJCgq2SliRsHiPy3wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763439759; c=relaxed/simple;
	bh=TG+f8mFqFQZKdFmpAfuFp3e9+EWf3Z2abx7yLO1SA1w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nJo273GmX4ddTgVgMNBzXbhWHZylTyLxYTIS2Q0sZEP8V86drxxjE4J2l8Oz8XC9JD6LFAq4R/bo1U/C1f2PKcBVKI+ju8/BTE3+qQ97Xsy/PnfdP56jDjvfwu4hoZ80PnTi4sNUZDs665m9IJgKM3xPZXmJ1/JcJIBCewgEIck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mLnz63NY; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763439758; x=1794975758;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TG+f8mFqFQZKdFmpAfuFp3e9+EWf3Z2abx7yLO1SA1w=;
  b=mLnz63NYrxsPuFfb68/SN8Kb7GAFXxz2qdAjm3l1v/zOQxksfQubnoSE
   pEZHvyLmPl4vCzF0SSUVVUc4CA4I8M/xz82KOFK4FWXWAYKhvilwKKntn
   tEn1lFpLAUqSueM8UIbqlVqeGcUZE8F0DAjTIVfWYpQaVSrLxFYelhwjY
   MXKQPjV4TWyzXuTjt+QbVvN3i9zRfQGfWk+lraCW095ZfQCwYW8QFtT0a
   ih/hS3esk7hOJ5hCPP15z1VE93k9xrBBzzusVcm+jHl6mqbpOtjx4XYm6
   PsWyvfuljN4+PYB+FuOT7jZeMPJTkFcr2+hth0CIT4QgJWSglmSivGD3c
   g==;
X-CSE-ConnectionGUID: mSgZPaNiRO6q1DTWmYg6AQ==
X-CSE-MsgGUID: 3c+lgg8nSf6kHLD3/Tea7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="82843561"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="82843561"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 20:22:37 -0800
X-CSE-ConnectionGUID: FQM6tLtXRfahRWQ2e/Hy5g==
X-CSE-MsgGUID: klmlslLXRpSlndRDJT6mIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="191086250"
Received: from aus-labsrv3.an.intel.com ([10.123.116.23])
  by fmviesa009.fm.intel.com with ESMTP; 17 Nov 2025 20:22:36 -0800
From: Sreedevi Joshi <sreedevi.joshi@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Sreedevi Joshi <sreedevi.joshi@intel.com>
Subject: [PATCH iwl-net 0/3] idpf: Fix issues in rxhash and rss lut logic
Date: Mon, 17 Nov 2025 22:22:25 -0600
Message-Id: <20251118042228.381667-1-sreedevi.joshi@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ethtool -K rxhash on/off and ethtool -x/-X related to setting up RSS LUT
indirection table have dependencies. There were some issues in the logic
that were resulting in NULL pointer issues and configuration constraints.
This series fixes these issues.

Sreedevi Joshi (3):
  idpf: Fix RSS LUT NULL pointer crash on early ethtool operations
  idpf: Fix RSS LUT configuration on down interfaces
  idpf: Fix RSS LUT NULL ptr issue after soft reset

 drivers/net/ethernet/intel/idpf/idpf.h        |  2 -
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 17 ++--
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 91 +++++++++----------
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 38 +++-----
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  5 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  9 +-
 6 files changed, 79 insertions(+), 83 deletions(-)

-- 
2.43.0


