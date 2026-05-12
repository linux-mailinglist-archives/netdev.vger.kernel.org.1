Return-Path: <netdev+bounces-287189-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBI9Gm47A2oa2AEAu9opvQ
	(envelope-from <netdev+bounces-287189-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:38:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AA5522B37
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 16:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 400F634C482B
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 14:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B31237204C;
	Tue, 12 May 2026 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fPuh2nCk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C8E3A7D9C
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594949; cv=none; b=c8RqXihwWCWaE8WPchvqBQJ+yd2VdR+ruitc8UoFWJ2FyfFu1rOjQXF4tFunYjgyl8g0D3/bmT7FxRux5tHezoy/CFnCfVbS8cVKKETQnxYNIyhcKqnmZIyzaKTjK2guvt977AJqNjIIuNOGsLsLqqEBzy6pG9Y+c2aO1Eaibho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594949; c=relaxed/simple;
	bh=1QbhqWzNyRHVTuQ47MMCc6rfzXEtjyZgMK5EqjaYeKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YTok1p8tmkE7gevsO+6uIyVjrcOdmY/xyBk+h9e1c1yPzle6Or2efGoLYl2AZy94YQiYx9d3H72x9Vg+gjBohVwPmEEXeDRUV1eR2CvP8QZPevWnwtYBmaWr1JRnatBmodVQVzRUcqEUQWpe4Wmx/Wq21fxRdFFX+l2R5fdfRW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fPuh2nCk; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778594947; x=1810130947;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1QbhqWzNyRHVTuQ47MMCc6rfzXEtjyZgMK5EqjaYeKA=;
  b=fPuh2nCkRVy1jeL3zap+d3lnKOp4DTuJ72KTOohk/mXVMiabkyE2ZpCW
   KOnftyGoM7jwgEt5HK7RAHDLfL8WcKqiuHHfZ/Xfow1qZMgXYY/Hg14hw
   p5cvHnIAZBg+PTtig063s+MO90TbBthD6wZ03j1z/9SxQYHjAS5UGAdvg
   OKbOfYcXGlDvG5BFzTsR8IDLo2N9N/wW8RBMg3ATZuVAp0KmEScfRCdZj
   5MiiB3iheXCZiEdubi6traRI/rwJraSxq4Zb3iyVPAQKiB20JsN6/dq9A
   ouLpbEiv7DtKzEx0zZJjWC/waODAOVWl4oprjbCwh0VPAm3gq6nq4g3Vq
   g==;
X-CSE-ConnectionGUID: PpXLW91nRZGn2sD+a4cl/g==
X-CSE-MsgGUID: pcGKL+fGQdWQHAEZGhS/aQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="96929652"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="96929652"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 07:09:07 -0700
X-CSE-ConnectionGUID: pjX5sqaGQS2N5koXoX3fVg==
X-CSE-MsgGUID: Aas4KuVwRAiDUOj5bV3lxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="275892466"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa001.jf.intel.com with ESMTP; 12 May 2026 07:09:06 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v2 0/8] ixgbe: small cleanups and improvements
Date: Tue, 12 May 2026 16:08:56 +0200
Message-ID: <20260512140904.4105236-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C3AA5522B37
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287189-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Eight independent cleanups and improvements for the ixgbe driver,
grouped by theme:

Naming / type hygiene (patches 1-2):
  Patch 1 renames ixgbe_q_vector::numa_node to ::node.  The field name
  shadows the struct device numa_node accessor, causing a sparse warning.
  The rename aligns with other Intel drivers (ice, igc).

  Patch 2 changes local error-code variables from u32 to int in six
  functions across ixgbe_main.c, ixgbe_phy.c and ixgbe_x550.c.  Storing
  a signed errno in an unsigned type works by accident for truthiness
  checks but breaks exact comparisons and proper propagation.

Bug fix (patch 3):
  Patch 3 rejects duplicate FDIR perfect-filter rules before programming
  hardware.  The same 5-tuple with a different sw_idx would silently
  consume a second scarce FDIR slot and confuse rule deletion.
  Returns -EEXIST to userspace on duplicate rather than -EINVAL.

Performance (patch 4):
  Patch 4 replaces the busy-wait udelay(1000) in the SECRX_RDY poll
  loop with usleep_range(10, 20) and raises the iteration count from
  40 to 4000.  Because usleep_range(min, max) is guaranteed to sleep
  at least 'min' us, 4000 * 10 us preserves the original 40 ms
  minimum-wait-before-timeout; worst-case grows to ~80 ms (acceptable
  since SECRX_RDY failing to assert is non-fatal and only logged).
  Typical stall on fast hardware drops from up to ~1 ms per iteration
  to ~10-20 us.

Code quality (patches 5-8):
  Patch 5 replaces ktime_to_ns(ktime_get_real()) with the direct
  ktime_get_real_ns() helper.

  Patch 6 factors the three-line autoneg-restart sequence duplicated in
  ixgbe_setup_phy_link_generic() and ixgbe_setup_phy_link_tnx() into a
  static helper ixgbe_restart_auto_neg().  The helper checks the return
  value of read_reg() and returns early on error to avoid writing
  uninitialized data to the PHY register.

  Patches 7-8 improve the adaptive-ITR algorithm in two steps:
    7/8: Limit ITR decrease in latency mode to at most
         IXGBE_ITR_ADAPTIVE_MIN_INC (2 us) per step so that ACK-driven
         workloads do not overdrive interrupt rate.  Uses max_t() to
         ensure the clamp never drives ITR below the algorithm's own
         computation.
    8/8: Add IXGBE_ITR_ADAPTIVE_MASK_USECS (= IXGBE_ITR_ADAPTIVE_LATENCY
         - 1) to replace the open-coded ~IXGBE_ITR_ADAPTIVE_LATENCY
         mask in ixgbe_set_itr() with the cleaner AND form.

---
Changes since v1:
  - Collected Reviewed-by: Simon Horman <horms@kernel.org> on
    patches 1, 4, 6, 7, 8.
  - Patch 4 (SECRX_RDY): tightened commit message wording for the
    worst-case bound to reflect that on a loaded system actual
    scheduler wakeup latency may exceed the nominal 4000 * 20 us =
    ~80 ms upper bound; clarified that the timeout is non-fatal (only
    a debug message is logged, return is unconditionally 0).  No code
    change.
  - Patch 3 (prevent duplicate FDIR perfect filter rules):
    * Dropped the e_warn() in ixgbe_match_ethtool_fdir_entry();
      -EEXIST returned to userspace is sufficient.
    * Reordered locals in ixgbe_add_ethtool_fdir_entry() for
      reverse-Christmas-tree (`int err = -EINVAL;` moved above
      `u8 queue;`).
    The same-sw_idx skip in ixgbe_match_ethtool_fdir_entry() is
    intentional and required: ixgbe_update_ethtool_fdir_entry() (the
    caller of the add path) deletes any existing rule at the same
    sw_idx and replaces it, implementing the standard ethtool
    "set rule at location N" overwrite semantic.  Rejecting matching
    sw_idx with -EEXIST would break idempotent re-application and the
    legitimate replace-at-same-location path.
  - Patches 2, 5: no review feedback received; no change.

Aleksandr Loktionov (1):
  ixgbe: use int instead of u32 for error code variables

Alexander Duyck (2):
  ixgbe: limit ITR decrease in latency mode to prevent ACK overdrive
  ixgbe: add IXGBE_ITR_ADAPTIVE_MASK_USECS constant

Jacob Keller (2):
  ixgbe: rename numa_node to node in struct ixgbe_q_vector
  ixgbe: use ktime_get_real_ns() in ixgbe_ptp_reset()

Jakub Chylkowski (1):
  ixgbe: extract ixgbe_restart_auto_neg() to avoid code duplication

Maciej Rabeda (1):
  ixgbe: increase SECRX_RDY polling frequency in
    ixgbe_disable_rx_buff_generic

Piotr Skajewski (1):
  ixgbe: prevent adding duplicate FDIR perfect filter rules

 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  3 +-
 .../net/ethernet/intel/ixgbe/ixgbe_common.c   |  5 +--
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 27 +++++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 19 ++++++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 42 +++++++++++--------
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c  |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 12 +++---
 8 files changed, 77 insertions(+), 35 deletions(-)

-- 
2.52.0


