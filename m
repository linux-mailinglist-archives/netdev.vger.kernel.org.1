Return-Path: <netdev+bounces-139262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A17F9B13AB
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 02:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06F9F1F215F5
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 00:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA699EC4;
	Sat, 26 Oct 2024 00:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dxa3N23y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D0D161;
	Sat, 26 Oct 2024 00:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729901155; cv=none; b=srb66OLpjBqb5ywJXWxSSebB7d20aaudLegkssydeuH5T2kKNbImO8B1YUcA5ve3iaQLeqYQZI+jllC5EaPi9oSIx0SvqxTYtE3N703s2d30iUJ7B1yCxJM5O4vwWFA0UQgcElD1Abl0cG4k5kOGl1K8TGskklFlM/gbu1lnwrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729901155; c=relaxed/simple;
	bh=/HiG+Q3c6VTFdPoIdpOgxiFl60WG0eeqXHpFPKtP0HI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U77VhxaevuXmpdTzeoA8JANdoQxbtbXirdVO5KJwzW3UvPyUPATLITRZJmIIpaZZXUxFwfxdxOueaciTQNjZC8XMLNY4aowkREAdwp5ew8zKMJJL34C3ky6oraSaxPtLwui/Izk7eV5yYo9XfpAcfa00mBF55u6nmfLxiXiKCSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dxa3N23y; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729901153; x=1761437153;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=/HiG+Q3c6VTFdPoIdpOgxiFl60WG0eeqXHpFPKtP0HI=;
  b=Dxa3N23y+MUbsDW38KjN2SVycO/U/iOaRrqVzkiJpUTwiahw6N/jmcH6
   aApbqfwlapUqeguzx78Fzc+xNcC4T4d5i1ko/n2HO0PYFPbKzH9S67ulD
   5BukEDCdtfGR2eaXBR6l6tLtzd2q8yXYySYPxf10nVrou3JE/MNb7GpSE
   PeRklO+qM2F6EMEilL2XBUTcuzvdEGPgRfGpFDFluxr9QuhRQWSYO7q3B
   tBVRyUHT8AU+JmhXVsRF/3hiZbzEiTkRUniyk17//LAL3apyvGy/WIP2M
   a8ALPoPwpk1/pxe7UnXZCSw4blrOGmVsWgIIuJ/rLQYQpHU29aA9FgVZW
   Q==;
X-CSE-ConnectionGUID: SOpVOP8rRpSrUE1WDIyJsA==
X-CSE-MsgGUID: Sv6HXLolTMq4v2nEyb5UIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="40959108"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="40959108"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 17:05:53 -0700
X-CSE-ConnectionGUID: /Wdg6TRzQ9GmGvtdBb6S3Q==
X-CSE-MsgGUID: OHLBx9OZTeOG8fnQhcyNkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="104386835"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 17:05:52 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next v2 0/9] lib: packing: introduce and use
 (un)pack_fields
Date: Fri, 25 Oct 2024 17:04:52 -0700
Message-Id: <20241025-packing-pack-fields-and-ice-implementation-v2-0-734776c88e40@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACUyHGcC/5WOwQqDMBBEf6XsuVsStaTtqf9RPGiy6lJdJQliE
 f+9If2CnoZhhnmzQyDPFOBx2sHTyoFnSaY4n8AOjfSE7JKHQhWVVqrCpbFvlj4rdkyjC9iIQ7a
 pOi0jTSSxiWkGW22ssXSj0pSQBhdPHW8Z9gKhiEJbhDolA4c4+09+seqc/4Ba/wNcNSp091Z35
 qqUqdSTJdJ4sfME9XEcX/9HdcLuAAAA
To: Vladimir Oltean <olteanv@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.14.1

This series improves the packing library with a new API for packing or
unpacking a large number of fields at once with minimal code footprint. The
API is then used to replace bespoke packing logic in the ice driver,
preparing it to handle unpacking in the future. Finally, the ice driver has
a few other cleanups related to the packing logic.

The pack_fields and unpack_fields functions have the following improvements
over the existing pack() and unpack() API:

 1. Packing or unpacking a large number of fields takes significantly less
    code. This significantly reduces the .text size for an increase in the
    .data size which is much smaller.

 2. The unpacked data can be stored in sizes smaller than u64 variables.
    This reduces the storage requirement both for runtime data structures,
    and for the rodata defining the fields. This scales with the number of
    fields used.

 3. Most of the error checking is done at compile time, rather than
    runtime via CHECK_PACKED_FIELD_* macros. This saves wasted computation
    time, *and* catches errors in the field definitions immediately instead
    of only after the offending code executes.

The actual packing and unpacking code still uses the u64 size
variables. However, these are converted to the appropriate field sizes when
storing or reading the data from the buffer.

One complexity is that the CHECK_PACKED_FIELD_* macros need to be defined
one per size of the packed_fields array. This is because we don't have a
good way to handle the ordering checks otherwise. The C pre-processor is
unable to generate and run variable length loops at compile time.

This is a significant amount of macro code, ~22,000 lines of code. To
ensure it is correct and to avoid needing to store this directly in the
kernel history, this file is generated as <generated/packing-checks.h> via
a small C program, gen_packing_checks. To generate this, we need to update
the top level Kbuild process to include the compilation of
gen_packing_checks and execution to generate the packing-checks.h file.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes in v2:
- Add my missing sign-off to the first patch
- Update the descriptions for a few patches
- Only generate CHECK_PACKED_FIELDS_N when another module selects it
- Add a new patch introducing wrapper structures for the packed Tx and Rx
  queue context, suggested by Vladimir.
- Drop the now unnecessary macros in ice, thanks to the new types
- Link to v1: https://lore.kernel.org/r/20241011-packing-pack-fields-and-ice-implementation-v1-0-d9b1f7500740@intel.com

---
Jacob Keller (6):
      ice: remove int_q_state from ice_tlan_ctx
      ice: use structures to keep track of queue context size
      ice: use <linux/packing.h> for Tx and Rx queue context data
      ice: reduce size of queue context fields
      ice: move prefetch enable to ice_setup_rx_ctx
      ice: cleanup Rx queue context programming functions

Vladimir Oltean (3):
      lib: packing: create __pack() and __unpack() variants without error checking
      lib: packing: demote truncation error in pack() to a warning in __pack()
      lib: packing: add pack_fields() and unpack_fields()

 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  11 +-
 drivers/net/ethernet/intel/ice/ice_common.h     |   5 +-
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h  |  49 +---
 include/linux/packing.h                         |  73 +++++
 drivers/net/dsa/sja1105/sja1105_static_config.c |   8 +-
 drivers/net/ethernet/intel/ice/ice_base.c       |   6 +-
 drivers/net/ethernet/intel/ice/ice_common.c     | 299 +++++---------------
 lib/gen_packing_checks.c                        | 193 +++++++++++++
 lib/packing.c                                   | 285 ++++++++++++++-----
 Kbuild                                          | 168 ++++++++++-
 drivers/net/ethernet/intel/Kconfig              |   3 +
 lib/Kconfig                                     | 361 +++++++++++++++++++++++-
 12 files changed, 1105 insertions(+), 356 deletions(-)
---
base-commit: 03fc07a24735e0be8646563913abf5f5cb71ad19
change-id: 20241004-packing-pack-fields-and-ice-implementation-b17c7ce8e373

Best regards,
-- 
Jacob Keller <jacob.e.keller@intel.com>


