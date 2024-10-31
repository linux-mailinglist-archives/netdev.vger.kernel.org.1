Return-Path: <netdev+bounces-140618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2ED9B743E
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 07:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 209A71C211CA
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 06:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B385823D1;
	Thu, 31 Oct 2024 06:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qa2iTsox"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F064437
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 06:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730354414; cv=none; b=c1IfAWcE+psGYEYM58KHvm+FAKtOhvAWb18pjXoP1YpHCMJoAOVagXZN9NwvsiFXyHglJptjVtjL2aPe/IXULtRAn8ZO3tPBPGHx8AjB+uYKbBhokzltSHOdvNlBP791KqS0p/yFMDfF+Bw5jLlICs1nJGHiIGnTE2NhE9KHBB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730354414; c=relaxed/simple;
	bh=l54SrFupOxwBcHNocWD3ESgVfm2sMM89Vj9IEhZ0Iy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jaQplU78ZWSjHWv/dcmtxBPCBUODtfWWQp61Bj+Sk87dGY1vM1QCBl81lB52MvyTGEtBtW5Ystkmczj+vMTnqE8fJ0EdIQwzqH5wHvjJkcNr2BFCR0oO6NOY41M3PGh4He1DE6/5Ear69/3z5TSmUM7ow4luQ0H7hlDfwKFlbWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qa2iTsox; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730354413; x=1761890413;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l54SrFupOxwBcHNocWD3ESgVfm2sMM89Vj9IEhZ0Iy8=;
  b=Qa2iTsoxxuolvbkZNDcfDXKxlbJrM00kKmXBII9cicBQZwMQeJ3DN0wI
   USb87Xvx1WKHjbCr+xpDbJPmqNUbDtBCF9kVmId4oqlFdG1leytlwdwZ+
   TXdPlQnwQk9VsK4dhjQtEOVlXjiomtD2bRSmfZCUAnohWcowBUdIpSmWz
   1BUyMDPOrQJ6x0Wlqeai/ubF9gQ2oJRWGfrvnfIaWCtNr0iPL3zIcle8d
   dicKSVBrJ/UXkVGF/PTaBujPG+GyoUzq/8kWhDiGBTBibwsNfAM99boVp
   bExkzRwAklGwNVbo+J2rnXHoFmrpDngYfP283Rx8iwafwLDkNHaljf9U9
   Q==;
X-CSE-ConnectionGUID: Dyz6dn6wTd6lh5kcqnJ2Tw==
X-CSE-MsgGUID: xtuamGVvSTeuH3g4gEmLCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30272907"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30272907"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 23:00:12 -0700
X-CSE-ConnectionGUID: YqNJV/gIQHGTsYnEu87VVA==
X-CSE-MsgGUID: 00NZNcEzT0GsQOhYHf1nvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82183625"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa007.fm.intel.com with ESMTP; 30 Oct 2024 23:00:10 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	sridhar.samudrala@intel.com
Subject: [iwl-next v1 0/3] ice: multiqueue on subfunction
Date: Thu, 31 Oct 2024 07:00:06 +0100
Message-ID: <20241031060009.38979-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patch is adding support for multiqueue on subfunction device.
mostly reuse pf code. Use max_io_eqs parameter as the max rx/tx queues
value.

Also add statistic as part of this changes.

Michal Swiatkowski (3):
  ice: support max_io_eqs for subfunction
  ice: ethtool support for SF
  ice: allow changing SF VSI queues number

 drivers/net/ethernet/intel/ice/devlink/port.c | 37 +++++++++++
 drivers/net/ethernet/intel/ice/ice.h          |  2 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 65 +++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_lib.c      | 63 ++++++++++--------
 drivers/net/ethernet/intel/ice/ice_sf_eth.c   |  1 +
 5 files changed, 128 insertions(+), 40 deletions(-)

-- 
2.42.0


