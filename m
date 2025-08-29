Return-Path: <netdev+bounces-218229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC5FB3B892
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 12:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC391CC0F51
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 10:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4751627A451;
	Fri, 29 Aug 2025 10:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MrtscIBo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A621B1C3027
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756462694; cv=none; b=us93nBKpSHUtbLqtjXIITZnuStWWsA/qzvJH5+L1Yp/bSXZkSqN8dtjxGEn0RZdKZdKwmuwHClzY6uBV977lydQOJnWK5MhXKL1hjFTcUnP+3dMHLah5gp42qAs0jp72zrQPxQ0DSkdgvXNjf9IyuJ0dGk0QMsQs9Der+ghMJbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756462694; c=relaxed/simple;
	bh=6SqRA4GD1MVyoS2S80aiNNumaKmzWUa+dtluct8f0gc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=biLwH+mkgbdRJTU1Auz18F64yWGts6b7SICRc/A6/DajbydbA3B5IkGHFYTyvzEfHm3lJWmBEiG+7F2UcX5eWrYOHtXCwW1USbJCDjWMsYMwVzzk+M+n4shV7N79Wcw5gx9b7sT53lJLulBV8Xus5d0txjslnRxo6W6tlN3z9O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MrtscIBo; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756462692; x=1787998692;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6SqRA4GD1MVyoS2S80aiNNumaKmzWUa+dtluct8f0gc=;
  b=MrtscIBokUbe8BNJqvDShAcob9oXuLv3fIMhiC8AnkGHxKAmNJljvZ4b
   wFFRfRT5oSLFxyTPoOfZlMTQ8faNn//GvgjD52342oX2Zt375QCQMLsKB
   hSk7//5trrL2SUuaeJVhKHfpTUfTBpzTgCko6k/3EFHhGY5S8x4kicmJ1
   W0twiX8N0PFkr9K74m8Bc5civO/KZYsWJbL7pVaXjBBLwsSyCjcrKW/TX
   4JMLg/6z9TOBdWqpCOR+DR6n6J2dmE7hIAS99ImobdRQZLcYpPsljlSGX
   pkd/o4jm91xu0t11JT83TNq2sG2ls821u85Yu1AmLHxcQzcfxP2UbzGVl
   Q==;
X-CSE-ConnectionGUID: rp8qolAxThOuae2rGdaqjQ==
X-CSE-MsgGUID: kNc11Wy2RZmdP0o2g1/f6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="76199439"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="76199439"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 03:18:12 -0700
X-CSE-ConnectionGUID: XHTGe6zTT5O7l6Cg8mm26A==
X-CSE-MsgGUID: DTSLO3h5QJCuSJBT0iFU/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="207489195"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa001.jf.intel.com with ESMTP; 29 Aug 2025 03:18:10 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	mschmidt@redhat.com
Subject: [PATCH iwl-next v4 0/5] iavf and ice: GTP RSS support and flow enhancements
Date: Fri, 29 Aug 2025 10:18:03 +0000
Message-ID: <20250829101809.1022945-1-aleksandr.loktionov@intel.com>
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

