Return-Path: <netdev+bounces-59198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F77819D31
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 11:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 488161C227C4
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 10:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA6A208DF;
	Wed, 20 Dec 2023 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m2/HmB6r"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378CD20B19
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703069008; x=1734605008;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+4UmLkbg6xUes43FYzkPJiDYKjW+t0Oegw1qPEdaH00=;
  b=m2/HmB6raqz9x6ggF6XXpBQIKuNe41r6eD+yhSWNj9pkg+Vo51yqxkAf
   YI1y5UpEjS3wg74dWTdnjeTy4qMLRBTHDRFWpMDsSo10/FdFXRwdGlVEG
   tAxRd0wMOtJW1kcctHJHXhreXyZvoZsZIlSU4kllsMPMTGtIr1G/BlWq7
   SubG0taUtzq+xVyW5jU8aResJLqOW6UQ66GJzbzR6mWMHr5rxx3rXjAeL
   IroTqQShQyVyMk3405UTBb5EPVl+LOH3TQ8BOOjN0aGUBEsh6xrkpBToT
   S2VK8WKG/zJTcfJyx/3qnjGN2ZYQEvU9fbYNbfGk8jPnPORZ2EMqeF3GF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="17350723"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="17350723"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 02:43:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="846673246"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="846673246"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by fmsmga004.fm.intel.com with ESMTP; 20 Dec 2023 02:43:25 -0800
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v3 iwl-next 0/6] ice: fix timestamping in reset process
Date: Wed, 20 Dec 2023 11:43:17 +0100
Message-Id: <20231220104323.974456-1-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

PTP reset process has multiple places where timestamping can end up in
an incorrect state.

This series introduces a proper state machine for PTP and refactors
a large part of the code to ensure that timestamping does not break.


Jacob Keller (5):
  ice: pass reset type to PTP reset functions
  ice: rename verify_cached to has_ready_bitmap
  ice: rename ice_ptp_tx_cfg_intr
  ice: factor out ice_ptp_rebuild_owner()
  ice: stop destroying and reinitalizing Tx tracker during reset

Karol Kolacinski (1):
  ice: introduce PTP state machine

V2 -> V3: rebased the series fixed Tx timestamps missing
V1 -> V2: rebased the series and dropped already merged patches

 drivers/net/ethernet/intel/ice/ice.h         |   1 -
 drivers/net/ethernet/intel/ice/ice_ethtool.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c    |   4 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 231 +++++++++++--------
 drivers/net/ethernet/intel/ice/ice_ptp.h     |  38 ++-
 5 files changed, 172 insertions(+), 104 deletions(-)


base-commit: 087c173e92424354672c296f7164232aa3380bbd
-- 
2.40.1


