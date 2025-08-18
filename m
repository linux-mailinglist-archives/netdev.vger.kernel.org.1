Return-Path: <netdev+bounces-214550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC04B2A1CA
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 14:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDAF84E28B4
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 12:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E276927A465;
	Mon, 18 Aug 2025 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BBAR51Em"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BEE3218A9
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520767; cv=none; b=DXjMiKdWXP/EJ4784yVwxnPqtHdmsC1wsh2DVlIdQPi6SosaICaUy8kU5dODh/t2dMuQ1GcNejeNdpXdAAdxQB28XsQW3ocN4fL11GE/97XtasR8Bt/idiSO8rqHv5cUf3BioiZ98hiKzxMBliMDMxgbWXtE0UKoGtI9Hp/1Z6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520767; c=relaxed/simple;
	bh=rhBvuqypf5LHhK3Z0/md04qrIWQLJc20kETHaLtkhz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S9lr/YVsvE1x++KVSjnULRF+VVSujkB7DKdjPBfYPaMpUGbZfiuCZku26ZCKRJs62HKMTDFZGaKUsQ9KXC/ZNFz+5Vf5hxfgkk1s+zINWFLVu/vU869wUoNIiA++Z3Rgj8m5LrPHcteCGZdv6LVyEE4w5nkFbAwRFwgNV7Iy1Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BBAR51Em; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755520766; x=1787056766;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rhBvuqypf5LHhK3Z0/md04qrIWQLJc20kETHaLtkhz8=;
  b=BBAR51EmTHE0JUGRMMdV61Zv+eo0nywgQZweEyI7ZCl+TQsO3RsR7R8K
   a379+753HpdUwNcjdnZHEXER5nPen7z+IAm3wivI2Jz9G1noyu/cmy8/1
   uf1771aJ5bkEkEhgiLAauvR1AZ51oFS1w8A+mxO4NKFB+57CyxZFEaaco
   k0NHY1U+6eUkvzK7D5ljzciFQPimt5OI2fec9RiTreMco2Bfqt0IeQxQR
   M8BVVHK2tlhFQITdrYzKjEPldhstHxMk+JWpNgz80TuQC0SCJqIQL0BNA
   xr/ebGkWdQ6OoMtMyvduj+YkGU1Nzf936MCRTuejjLcAtD/1YhRIpzdyy
   Q==;
X-CSE-ConnectionGUID: 1YmMHjHUQJ622dgs44Dicg==
X-CSE-MsgGUID: a3iFRjmGSbCuhE+t/1uKdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="75309118"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="75309118"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 05:39:25 -0700
X-CSE-ConnectionGUID: pvPjU/daSye+9qRi2vocuQ==
X-CSE-MsgGUID: sr99iaffTTK7C9J8GI07RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="172906306"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa005.jf.intel.com with ESMTP; 18 Aug 2025 05:39:20 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	mschmidt@redhat.com
Subject: [PATCH iwl-next v2 0/5] iavf and ice: GTP RSS support and flow enhancements
Date: Mon, 18 Aug 2025 12:39:12 +0000
Message-ID: <20250818123918.238640-1-aleksandr.loktionov@intel.com>
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

