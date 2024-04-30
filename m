Return-Path: <netdev+bounces-92576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DF98B7F6F
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 20:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09ACFB22960
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 18:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A451836C1;
	Tue, 30 Apr 2024 18:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TgmjPiqb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22743181B8F
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 18:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714500405; cv=none; b=dEWrGF8qq+J9bRG7nI6PwipNyT3m8db6PqL6aPaYV69yrFHA6LdA8yfJeJMjoDlfPNQ7hJFORxmmlpIGVGX54XIKTY69zz3/KG31p8w3sua0+YqzJH+wgh29g0sc7knNaMC242t95ufsH9DST8a9TKgg0MJ+njNiw2MpRXqW9BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714500405; c=relaxed/simple;
	bh=HXIipd99Xtnp2b+D+9xoXtQUvThs34h2RGV3fdt+J5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s5t8TWIIwaOyO/V6kiZ9LgSsDNP9x2Hovz/8Bhsa+T9r4KvS6BeYrs5sgk89mWJRHhQ06QQciduCbKLZATX28fKcAsdmNZed3LuX02OUUWR1CEHROiH/idlniIun+Wi62AhfXWhaj4oVxz6JGvVmLwIVeXXX3l8KCHXRF1+gezg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TgmjPiqb; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714500404; x=1746036404;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HXIipd99Xtnp2b+D+9xoXtQUvThs34h2RGV3fdt+J5M=;
  b=TgmjPiqb7eSvIHrYdLofHA221o66uzYVjX6kNLQ3e36Xe1ozoYxWxGbb
   rL8UZr21+IWhzDP/mIDNlYTn9449hmRZG1mFu2rPeIClepK6Sj5TiWP07
   H//Z4ZGTnpiuvadulKKE2B95r7MU10lxFbNVau2X3EtNjHLRVxX1Y1Njf
   W/spliBD/VacZ+3WqzTRQwDW1r7OV5U8RC0zXpKlmQMgPirBlyOyvEloZ
   gnlTnx5mvH7+osADXqh6IT5uVAAuIeNtrdhm+BrKYrVw/g0RjSGi2tRDf
   wLFqkaDdmNcBHoISvddxf8fLN5wWDSj/n3vpgLI/uwuBdImODKcLcC8Qq
   A==;
X-CSE-ConnectionGUID: ARGqlE93RtmoMGDPnKnWiQ==
X-CSE-MsgGUID: ymflDRu1QLCAMJ3vJlDgNw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="20839408"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="20839408"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 11:06:43 -0700
X-CSE-ConnectionGUID: FXZHGr7JSUajwYHZtfb8fw==
X-CSE-MsgGUID: EQpRzHG6TVerJPTzgLzHjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="31147290"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 30 Apr 2024 11:06:43 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	ivecera@redhat.com
Subject: [PATCH net-next 0/7][pull request] i40e: cleanups & refactors
Date: Tue, 30 Apr 2024 11:06:30 -0700
Message-ID: <20240430180639.1938515-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ivan Vecera says:

This series do following:
Patch 1 - Removes write-only flags field from i40e_veb structure and
          from i40e_veb_setup() parameters
Patch 2 - Refactors parameter of i40e_notify_client_of_l2_param_changes()
          and i40e_notify_client_of_netdev_close()
Patch 3 - Refactors parameter of i40e_detect_recover_hung()
Patch 4 - Adds helper i40e_pf_get_main_vsi() to get main VSI and uses it
          in existing code
Patch 5 - Consolidates checks whether given VSI is the main one
Patch 6 - Adds helper i40e_pf_get_main_veb() to get main VEB and uses it
          in existing code
Patch 7 - Adds helper i40e_vsi_reconfig_tc() to reconfigure TC for
          particular and uses it to replace existing open-coded pieces

The following are changes since commit b45176703647e5302314c740a51e7d1054a7bd3c:
  Merge branch 'selftests-net-page_poll-allocation-error-injection'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 40GbE

Ivan Vecera (7):
  i40e: Remove flags field from i40e_veb
  i40e: Refactor argument of several client notification functions
  i40e: Refactor argument of i40e_detect_recover_hung()
  i40e: Add helper to access main VSI
  i40e: Consolidate checks whether given VSI is main
  i40e: Add helper to access main VEB
  i40e: Add and use helper to reconfigure TC for given VSI

 drivers/net/ethernet/intel/i40e/i40e.h        |  29 ++-
 drivers/net/ethernet/intel/i40e/i40e_client.c |  28 +--
 drivers/net/ethernet/intel/i40e/i40e_ddp.c    |   3 +-
 .../net/ethernet/intel/i40e/i40e_debugfs.c    |  36 ++--
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  29 ++-
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 200 ++++++++++--------
 drivers/net/ethernet/intel/i40e/i40e_ptp.c    |   6 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  16 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |   2 +-
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  14 +-
 10 files changed, 211 insertions(+), 152 deletions(-)

-- 
2.41.0


