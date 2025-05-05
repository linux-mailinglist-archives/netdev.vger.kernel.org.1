Return-Path: <netdev+bounces-187833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D514AA9D08
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 22:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F80E169D38
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 20:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F590265606;
	Mon,  5 May 2025 20:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GyLGbCI7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7CB34CF5
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746476082; cv=none; b=gAPpHEnkwsTPLlxgd1F0G1OdfMuscSA7sUiDi2NB3bA6jwy3nXpDzOnS6QB7OR42fIvBfdfaJoV4cRHzopb6jjGohSB/V3QcRMM8V0sGoRNqt/mosnlnjc5ro8ghgcjr4BTzayygPR94wlrDnN3qVpdS1XX3O//g5u2AsPZupjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746476082; c=relaxed/simple;
	bh=mAmTw853O4UNXFX6YsFjv+tnx+KBU9pCsTdd3ISM8iM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LLUldU0vMJDJfkfiR2fFimajCsbejc6rJFnT8IaP3DUSHQnuCz4I1yPg1y9mbBsxDgAqXDzc3YmfchKKnueE5EDKABX6TJV9EoTKWlOWW7SMm3+7+k6cfK46AdNWZugn6unpt17SWz6wOs/u45bwNuVsh4OamdY4Xz184mjQvkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GyLGbCI7; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746476080; x=1778012080;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=mAmTw853O4UNXFX6YsFjv+tnx+KBU9pCsTdd3ISM8iM=;
  b=GyLGbCI7ETRm0/5iMXTPHXKYQpGvcgJAvmKo3rPaL2Ghh4GBTN8WYpBS
   j4ROwR5euficce+8tUqyjD8buxUhjxvPfIAm/gQ2/XYZIUI3m3CD1bLwM
   kYyzogobqL34P6u20S5CpAwcRPyVHs9LdZ3HkMGTico07Tnk/8zVoRbUD
   Y05OmBWwtZX8OvDimSPXniiHYZeHHsUd2+nFvRYQJEj64gdUwa5Jb0vAb
   Q8c93zbLjUcgNVSDgAL8aM1V7uwpSGhBlsTtYZCtl8BaeA97/E8ZLkBNv
   36/W9ld7Pd5GuO7YyWKAZBmcsKoGawmcvDJL8MS79x3aMFVJnBw0aYD+L
   Q==;
X-CSE-ConnectionGUID: 5OPg2EcGTNSM+rOk1pcjWg==
X-CSE-MsgGUID: XKnZoG5tTrGITIXkKNp8eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="65635324"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="65635324"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 13:14:39 -0700
X-CSE-ConnectionGUID: gJ7iz3zkTyu5ibLBsilZ/w==
X-CSE-MsgGUID: bXwDivo5S4OnSfMzr4B1kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="158593552"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 13:14:39 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-next v2 0/2] net: intel: cleanup RSS hash configuration
 bits
Date: Mon, 05 May 2025 13:14:21 -0700
Message-Id: <20250505-jk-hash-ena-refactor-v2-0-c1f62aee1ffe@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB0cGWgC/32Oyw6CMBREf4V07TV9AcWV/2FclHKRKhbTEsQQ/
 t2CGzaynEzOmZlIQG8xkFMyEY+DDbZzMfBDQkyj3Q3BVjETTnlKJRdwf0CjQwPoNHistek7D4U
 2DHmphE6RRPQVGzuu2gux7xYcjj25xqaxIQKfdW9ga7+vHhhQECYXKksLKcvybF2P7dF0z2XpB
 wu6AyvBqJa5SmXON/DyZuDbB8UfCY+SnCqJulI1o9lWMs/zF2w3j1xEAQAA
X-Change-ID: 20250423-jk-hash-ena-refactor-9ac1e2b83a5e
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2

The virtchnl API does not define the RSS Hash configuration bits directly
in virtchnl.h, but instead implicitly relies on the hardware definitions
for X710 and X722 in the i40e driver.

This results in duplicating the same bit definitions across 3 drivers. The
actual virtchnl.h header makes no mention of this, and its very unclear
what the bits mean without deep knowledge of the way RSS configuration
works over virtchnl.

In addition, the use of the term 'hena' is confusing. It comes from the
I40E_PFQF_HENA registers, indicating which hash types are enabled.

Rename the 'hena' fields and related functions to use 'hashcfg' as a
shorthand for hash configuration.

We could define the enumeration of packet types in virtchnl.h. Indeed, this
is what the out-of-tree releases of virtchnl.h do. However, this is
somewhat confusing for i40e. The X710 and X722 hardware use these bits
directly with PF hardware registers. It looks confusing to use "VIRTCHNL_*"
names for such access.

Instead, we move these definitions to libie as part of new pctype.h header
file. This allows us to remove all duplicate definitions and have a single
place for Linux to define the bit meanings. The virtchnl.h header can point
to this enumeration to clarify where the values are defined.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes in v2:
- Convert kdoc comment in pctype.h to regular, since it feels too noisy to
  add a near-duplicate message for each enum value to the kdoc comment.
- Link to v1: https://lore.kernel.org/r/20250430-jk-hash-ena-refactor-v1-0-8310a4785472@intel.com

---
Jacob Keller (2):
      net: intel: rename 'hena' to 'hashcfg' for clarity
      net: intel: move RSS packet classifier types to libie

 drivers/net/ethernet/intel/i40e/i40e_txrx.h        | 43 ++++++------
 drivers/net/ethernet/intel/i40e/i40e_type.h        | 32 ---------
 drivers/net/ethernet/intel/iavf/iavf.h             | 10 +--
 drivers/net/ethernet/intel/iavf/iavf_txrx.h        | 40 ++++++-----
 drivers/net/ethernet/intel/iavf/iavf_type.h        | 32 ---------
 drivers/net/ethernet/intel/ice/ice_flow.h          | 68 ++++++------------
 drivers/net/ethernet/intel/ice/ice_virtchnl.h      |  4 +-
 include/linux/avf/virtchnl.h                       | 23 +++---
 include/linux/net/intel/libie/pctype.h             | 41 +++++++++++
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 81 +++++++++++-----------
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 25 +++----
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        | 25 +++----
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 46 ++++++------
 drivers/net/ethernet/intel/iavf/iavf_main.c        | 17 ++---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    | 33 ++++-----
 drivers/net/ethernet/intel/ice/ice_flow.c          | 45 ++++++------
 drivers/net/ethernet/intel/ice/ice_lib.c           |  2 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c      | 44 ++++++------
 .../ethernet/intel/ice/ice_virtchnl_allowlist.c    |  2 +-
 19 files changed, 286 insertions(+), 327 deletions(-)
---
base-commit: 836b313a14a316290886dcc2ce7e78bf5ecc8658
change-id: 20250423-jk-hash-ena-refactor-9ac1e2b83a5e

Best regards,
-- 
Jacob Keller <jacob.e.keller@intel.com>


