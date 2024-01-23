Return-Path: <netdev+bounces-65002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9B4838C91
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 11:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E8A2869BA
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 10:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0206A5C906;
	Tue, 23 Jan 2024 10:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OF9l6J9P"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B16A5C8FD
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 10:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706007115; cv=none; b=Smy/vNDUaHtjDFltP7HfyyLI6wBxDeAkynDWnDLXXHBghh5ZX2rQYS5u8y/ob5Zx4k0jAha0DSF+fRkkkVkYZSWfInW5gzm+GjZ1OzwAOR36sYUQcvNwFZnpX/VrSCQpo7QIreok3hVK/HueCmDITkRhkivvur3RsQwJyNO0oFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706007115; c=relaxed/simple;
	bh=QVDzK7qu8Dn9oJm3knKewxlwsWJntp4EWgC54cySeok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bS4EyIb6E9YPlk1v0bNjgGqyEVH/kSKNIWl8OxWGDVTT99+WwEKi4h62MLQ3YoKSRAd1CVreYPJpl9FwPRouJnNLzKKJGDoq60u7jP9XD9vt86OSJB/99qj7FnqiineYscBkKR8CZrhqfTWQ7uxpAYAISJzCLS3A86KFPPOo7oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OF9l6J9P; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706007113; x=1737543113;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QVDzK7qu8Dn9oJm3knKewxlwsWJntp4EWgC54cySeok=;
  b=OF9l6J9P3MNAucn0NeKJ/YOcUCIiOijOOw3LQDYuU2Y2nDVyVnfF9Gll
   5Jo7Tc2wb6C+0mglm3tRc0rLh1zuit44v/POG+kzB/GWd9yKnHL23ox7E
   Mlv9fLl981NNEJUu1lhZkyF9VCRBU5EbQzeZx0pSC5ZNo0syx/oQaocdh
   TX1+WZwErnxNzqUn+tS7lBxP7nFp7jLe3Yn4dOy3jtO0N+qPr73iSQxlK
   GJUAJdsXcIieOnPHIJXI60fx7XzKNrRY6Jeoivbe0uthsBtSF6/cUTw4r
   YWh1tr5R2PJyhqx+DvXRvkyVIKTvkoFPie8ybM73iVRRMAIwxemLBlJDb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="8877574"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="8877574"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 02:51:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="34365363"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orviesa001.jf.intel.com with ESMTP; 23 Jan 2024 02:51:51 -0800
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v7 iwl-next 0/7] ice: fix timestamping in reset process
Date: Tue, 23 Jan 2024 11:51:24 +0100
Message-Id: <20240123105131.2842935-1-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PTP reset process has multiple places where timestamping can end up in
an incorrect state.

This series introduces a proper state machine for PTP and refactors
a large part of the code to ensure that timestamping does not break.

Jacob Keller (6):
  ice: pass reset type to PTP reset functions
  ice: rename verify_cached to has_ready_bitmap
  ice: don't check has_ready_bitmap in E810 functions
  ice: rename ice_ptp_tx_cfg_intr
  ice: factor out ice_ptp_rebuild_owner()
  ice: stop destroying and reinitalizing Tx tracker during reset

Karol Kolacinski (1):
  ice: introduce PTP state machine

V4 -> V6: patch 'ice: rename verify_cached to has_ready_bitmap' split into 2
V4 -> V5: rebased the series
V2 -> V3: rebased the series and fixed Tx timestamps missing
V1 -> V2: rebased the series and dropped already merged patches

 drivers/net/ethernet/intel/ice/ice.h         |   1 -
 drivers/net/ethernet/intel/ice/ice_ethtool.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c    |   4 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 229 +++++++++++--------
 drivers/net/ethernet/intel/ice/ice_ptp.h     |  34 ++-
 5 files changed, 164 insertions(+), 106 deletions(-)


base-commit: c8c06ff7ca5d9fc593fd634e3c3ff78a7e2bc5fe
-- 
2.40.1


