Return-Path: <netdev+bounces-223079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD29B57D88
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3E13A5C10
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 13:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7298319843;
	Mon, 15 Sep 2025 13:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LzibfhuQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC32D3148B2
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 13:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943574; cv=none; b=qGalWnSr3G2pufqV9qTxVbVa1TXzPDMcIUZ/Forx+uCJS5an1uw31vMr1aiD4twwElznOs01y5UjomgS1mQKqY1LXX4dZef59TTWXvGgqTLfolR/9A8ioHfX5CW8AVqlVm0ih4FAgD0UTwkjZfCgF4E+8CZZyi0XroBF7zI2xqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943574; c=relaxed/simple;
	bh=2EWzJkrz3A3fwypSvViuBqhRWGtrvE7GvbjIg5VhLoA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=a0efQy2nx8duhdjCPqxp1Si4JDKS/lDsW2GdvimC4zZngY6hhrWUc3RXg77XybBnhYEAh7qgSQTc9IEt0SO63cVBd88rY/k2yt5r4Al7aORQxPLW2GyEG5tNDWu9fUPsOLn9rIz1AXygoLqDJ0rkuGEyBDkroxSMVtd3jZhH/94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LzibfhuQ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757943573; x=1789479573;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2EWzJkrz3A3fwypSvViuBqhRWGtrvE7GvbjIg5VhLoA=;
  b=LzibfhuQa5z9MfB4n4vNR3muL2/JLLsYcw45Mp9knhB2qz/WNZ05G8Lw
   6lAkKL2o/XOclYcYMXT7yYk+zjcEtZktXsjUZoMOsSCIeR6kn0r3nI6w0
   uVYIyjERh8wZhT305qMpawcPXsGyBs3C51G23DpiJ5TtjIUdp+a1gXQ/h
   iMOzTSd727bdEBw6jBmbVQjQMAMGi/X9ebVphiqwUlIRzq9Vrv0y73dkT
   084rn7ijhWUN3GlxeWHVDKoscyXa7SnJPGys0zjUkflaRvne/9LG86eZ2
   UFjKumtWgpqYiyO+tAo9zCE0q/4ycuSvo0a4emCLdqZuoMWrYEvpH6th7
   Q==;
X-CSE-ConnectionGUID: 6vaziJJyS5WpAQld+c955A==
X-CSE-MsgGUID: YMB9sYLLTlKh1MnvzUWrvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64008069"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64008069"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 06:39:31 -0700
X-CSE-ConnectionGUID: EPy7YuN9QjyBDN3JXNmn5g==
X-CSE-MsgGUID: vby4lyzjQQa2CIF5JqX6/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="205421474"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa002.jf.intel.com with ESMTP; 15 Sep 2025 06:39:29 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	mschmidt@redhat.com,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v5 0/5] iavf and ice: GTP RSS support and flow enhancements
Date: Mon, 15 Sep 2025 13:39:23 +0000
Message-ID: <20250915133928.3308335-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces support for Receive Side Scaling (RSS)
configuration of GTP (GPRS Tunneling Protocol) flows via the ethtool
interface on virtual function (VF) interfaces in the iavf driver.

The implementation enables fine-grained traffic distribution for
GTP-based mobile workloads, including GTPC and GTPU encapsulations, by
extending the advanced RSS infrastructure. This is particularly beneficial
for virtualized network functions (VNFs) and user plane functions (UPFs)
in 5G and LTE deployments.

Key features:
 - Adds new RSS flow segment headers and hash field definitions for GTP
   protocols.
 - Enhances ethtool parsing logic to support GTP-specific flow types.
 - Updates the virtchnl interface to propagate GTP RSS configuration to PF.
 - Extends the ICE driver to support GTP RSS configuration for VFs.

changelog:
v5:
   -fix NULL ptr dereference and minor improvements in 1/5 & 2/5
v4:
   -remove redundant bitmask in iavf_adv_rss.c for dmesg
v3:
   -fix kdoc-s in ice_virtchnl_rss.c
v2:
   - reduce much repetition with ice_hash_{remove,moveout}() calls
     (Przemek, leftover from internal review)
   - now applies on Tony's tree

v1/RFC: https://lore.kernel.org/intel-wired-lan/20250811111213.2964512-1-aleksandr.loktionov@intel.com

Aleksandr Loktionov (4):
  ice: add flow parsing for GTP and new protocol field support
  ice: add virtchnl and VF context support for GTP RSS
  ice: improve TCAM priority handling for RSS profiles
  iavf: add RSS support for GTP protocol via ethtool

Przemek Kitszel (1):
  ice: extend PTYPE bitmap coverage for GTP encapsulated flows

 .../net/ethernet/intel/iavf/iavf_adv_rss.c    |  119 +-
 .../net/ethernet/intel/iavf/iavf_adv_rss.h    |   31 +
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |   89 ++
 .../net/ethernet/intel/ice/ice_flex_pipe.c    |   91 +-
 .../net/ethernet/intel/ice/ice_flex_type.h    |    1 +
 drivers/net/ethernet/intel/ice/ice_flow.c     |  251 ++-
 drivers/net/ethernet/intel/ice/ice_flow.h     |   94 +-
 .../ethernet/intel/ice/ice_protocol_type.h    |   20 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   48 +
 .../net/ethernet/intel/ice/ice_virtchnl_rss.c | 1404 ++++++++++++++++-
 include/linux/avf/virtchnl.h                  |   50 +
 11 files changed, 2070 insertions(+), 128 deletions(-)

--
2.47.1



