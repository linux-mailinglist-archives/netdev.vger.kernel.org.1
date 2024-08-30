Return-Path: <netdev+bounces-123646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9EE966049
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 13:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8282C1F236CD
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 11:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0867D192D93;
	Fri, 30 Aug 2024 11:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bI7yCg4v"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB8B190685
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 11:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725016239; cv=none; b=dh8aX6FNQogXt8ZMxrUg5TpJSSu7LUUxyphjLdVavJCg5R6eRSxyn0oSDpOWLu1or7CnH6MbzYwSKN26DTrdpZJZFwrXZu/nQsN5r14y8uhQ9NH38RbSZm+FgzM8tY5p6RiLjPDjz4OGQlQV6YE7byzSYZgzlQzfnLRXZf7tfbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725016239; c=relaxed/simple;
	bh=NtTOOuyHAWtbaPGb4uJuSSxIBMIlghCEwU/dKFHFg6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AQ/IDGKYg9Az4vDPGY1cTyZSr/X0m/2W8NyvUetCTHVclkXQpItNbL7QRJPYh9u6H6/RWylhZiB1IHlGWNwbzGK5m6mG54L4GYCDE+rq+ED8fXU/Qq/lnulEA4ZC5jfcLWzEgk+KLyFbx7t9hqhiTWEWP0IQamRBJXUpE2FqWRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bI7yCg4v; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725016239; x=1756552239;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NtTOOuyHAWtbaPGb4uJuSSxIBMIlghCEwU/dKFHFg6w=;
  b=bI7yCg4vNiV6m02ly4Lk/Tk2t/BXi/9bWqo77/0ByWztHfkFZqNDkUaR
   FUblaajnTlbPRr23OMO6lV84f6sA13N4GxOCi0ZAIGc67D2boILT1ZWTU
   iA5QGR0L4EvwvX0Wy6GsxYxVBCDWDoahqLDilRroHFenxeiBMBAoVNZ1b
   9WoVazvVbhbjSdoEflhTXywFBWdMtGaGsQyqHAPsqEXrspYhRCLtYkMc3
   mahw3MG718IOEnto8yUzelPKzpMyynx5INEt+bCSWt4FJgTxkBUg47DQd
   Ns7QBfppbKvydWT2QEgFkVbTzosK9S7wDUK4ThP7eh7TJVC36pp6x9mvz
   A==;
X-CSE-ConnectionGUID: +gmX9fktTquu+sh+AZ9xpw==
X-CSE-MsgGUID: b2p9NZgoSbaZpl4S3Ldt7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23517575"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="23517575"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 04:10:38 -0700
X-CSE-ConnectionGUID: pmX8JsBGSqWguzqqBl0FiA==
X-CSE-MsgGUID: uZLl58ThTGafKERSAWojDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="68273553"
Received: from kkolacin-desk1.igk.intel.com ([10.217.160.108])
  by fmviesa005.fm.intel.com with ESMTP; 30 Aug 2024 04:10:36 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v4 iwl-next 0/7] ice: Cleanup and refactor PTP pin handling
Date: Fri, 30 Aug 2024 13:07:16 +0200
Message-ID: <20240830111028.1112040-9-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series cleans up current PTP GPIO pin handling, fixes minor bugs,
refactors implementation for all products, introduces SDP (Software
Definable Pins) for E825C and implements reading SDP section from NVM
for E810 products.

Karol Kolacinski (5):
  ice: Implement ice_ptp_pin_desc
  ice: Add SDPs support for E825C
  ice: Align E810T GPIO to other products
  ice: Cache perout/extts requests and check flags
  ice: Disable shared pin on E810 on setfunc

Sergey Temerkhanov (1):
  ice: Enable 1PPS out from CGU for E825C products

Yochai Hagvi (1):
  ice: Read SDP section from NVM for pin definitions

 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |    9 +
 drivers/net/ethernet/intel/ice/ice_gnss.c     |    4 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 1121 +++++++++--------
 drivers/net/ethernet/intel/ice/ice_ptp.h      |  119 +-
 .../net/ethernet/intel/ice/ice_ptp_consts.h   |    2 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  103 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   72 +-
 7 files changed, 784 insertions(+), 646 deletions(-)

V3 -> V4: rebased patchset and replaced uints with unsigned ints
V2 -> V3: swapped in/out pin numbers in all patches introducing them
V1 -> V2: fixed formatting issues for:
          - ice: Implement ice_ptp_pin_desc
          - ice: Add SDPs support for E825C
          - ice: Align E810T GPIO to other products
          - ice: Cache perout/extts requests and check flags
          - ice: Disable shared pin on E810 on setfunc
          - ice: Enable 1PPS out from CGU for E825C products

base-commit: 05b5f6e89970647ddaaca100f545ef6e1f7989f8
-- 
2.46.0


