Return-Path: <netdev+bounces-150822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C179EBAD0
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 21:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A348E1888548
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 20:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87661226877;
	Tue, 10 Dec 2024 20:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e9QYzUHr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA9C23ED44
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 20:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733862450; cv=none; b=PlAbr4ifYx/qyk7TC6C4lJhehLphHpD0+9DhiB+WPaQNqMNLXiSed/Y5o9jrY7IqwmYJUmS1BeI97megXieJ79MZcPyVytwG9bESE6uw6R9FIuEf++WX/FR13hYsWSwZMSwyCow7wbF/VYbmd/a+/IMuylTvk7r6LX84FOLSG7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733862450; c=relaxed/simple;
	bh=l1XIKvxTsEZovHnYo6v/2oJ4fMMlZgt6+fY6cO5i5I4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ARmwby5KSBzTLcU16NKaJ2jrbvkdV2Q2OOwmAUyZpyuARXnNolQ8litMnX0BW1Cn2o68ezpf5o8glHExxdoPu307l2kd5V53T4GG6KfnwFFVV+QOgxOakEck2jwq1ftaXKwyugAyjBqLUvbsdJHDV48s0zTeI+nbClggOgyPtWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e9QYzUHr; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733862448; x=1765398448;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=l1XIKvxTsEZovHnYo6v/2oJ4fMMlZgt6+fY6cO5i5I4=;
  b=e9QYzUHrBZhfQbWdCSEheCXmHOVc9w3pYD+dKi+aoAKOOaHFP6nEKas6
   N5xkEqqgmcXx2gTCBPpbRvPMZPJ0PTddW/wBN9G51E+9GFmboQTd4QZPm
   YEl+RvK7M6vMpSfrUgG8RlKpR5YlPEB9MsQVUi4hF2luCOE7mNdWPqTo8
   3ySaFHesLQC4gMJ1eVIRbZ8++WVFVkE9/PMuJExTJOlp8E3pQSsOHZeyR
   ModeSA/w847bU1BcZtKLLYG/spVDx80fDd81LIAdKTkqGWp3gLWgtt7Qx
   ivU1H4yMYUKy8O35NL3vjo/+tX0df2gSYbtyBQxBGiOzv4a/8UXoGXBHd
   g==;
X-CSE-ConnectionGUID: X2odNnHTSqOrIj9/DFHJkA==
X-CSE-MsgGUID: UwcYvcmpRRK5RgLY6LMc/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34147272"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="34147272"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 12:27:27 -0800
X-CSE-ConnectionGUID: uZsSA74ARc2jFkxj/aDTuw==
X-CSE-MsgGUID: wTGg4+H3Qz+vJmIEBH2CMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="126424076"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 12:27:27 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next v10 00/10] lib: packing: introduce and use
 (un)pack_fields
Date: Tue, 10 Dec 2024 12:27:09 -0800
Message-Id: <20241210-packing-pack-fields-and-ice-implementation-v10-0-ee56a47479ac@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB2kWGcC/5XTyWrDMBAG4FcJOkdF+5JT36P0II9GiWiiBNuYl
 JB3r+JS4jonXSS08M2PBt3IgH3Ggew2N9LjlId8LnXB2XZD4BDKHmmOdYMIJhRnTNFLgK9c9vN
 MU8ZjHGgokWaoV0+XI56wjGGsDu24BQvoUFpJKnjpMeXrXO2DFBxpwetIPuvJIQ/juf+eY0x8P
 v8tyHlLwYlTRqPveLKaMavYey4jHt/gfJrLTGJBC91Ei0pbqaw14By+0vJJc2aaaFlp0CpI8Il
 7bxf0dvNH2mZSWNDGBBBKmnVatUzrmmhVaceDT0qAZKjXtF7Qje3TD5oBq+/s0XR2TZsl3ZbaV
 NqE5DqjXTAg17R90nVoom2lMQqB0qEB8/IgbknLJto92ojROIwJtXtJ7Zd009+c/NxGcEl00Ur
 xj77f7z81GwV+GgQAAA==
X-Change-ID: 20241004-packing-pack-fields-and-ice-implementation-b17c7ce8e373
To: Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.2

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
    runtime, via CHECK_PACKED_FIELD macros.

The actual packing and unpacking code still uses the u64 size
variables. However, these are converted to the appropriate field sizes when
storing or reading the data from the buffer.

This version now uses significantly improved macro checks, thanks to the
work of Vladimir. We now only need 300 lines of macro for the generated
checks. In addition, each new check only requires 4 lines of code for its
macro implementation and 1 extra line in the CHECK_PACKED_FIELDS macro.
This is significantly better than previous versions which required ~2700
lines.

The CHECK_PACKED_FIELDS macro uses __builtin_choose_expr to select the
appropriately sized CHECK_PACKED_FIELDS_N macro. This enables directly
adding CHECK_PACKED_FIELDS calls into the pack_fields and unpack_fields
macros. Drivers no longer need to call the CHECK_PACKED_FIELDS_N macros
directly, and we do not need to modify Kbuild or introduce multiple CONFIG
options.

The code for the CHECK_PACKED_FIELDS_(0..50) and CHECK_PACKED_FIELDS itself
can be generated from the C program in scripts/gen_packed_field_checks.c.
This little C program may be used in the future to update the checks to
more sizes if a driver with more than 50 fields appears in the future.
The total amount of required code is now much smaller, and we don't
anticipate needing to increase the size very often. Thus, it makes sense to
simply commit the result directly instead of attempting to modify Kbuild to
automatically generate it.

This version uses the 5-argument format of pack_fields and unpack_fields,
with the size of the packed buffer passed as one of the arguments. We do
enforce that the compiler can tell its a constant using
__builtin_constant_p(), ensuring that the size checks are handled at
compile time. We could reduce these to 4 arguments and require that the
passed in pbuf be of a type which has the appropriate size. I opted against
that because it makes the API less flexible and a bit less natural to use
in existing code.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes in v10:
- Use '_u8' and '_u16' suffix instead of '_s' and '_m', for packed_field_*
  and (un)pack_fields_*.
- Add gen_packed_field_checks to scripts/.gitignore
- Add a note to the kdoc for the pack_fields_* and unpack_fields_*
  functions about preferring use of the macro.
- Link to v9: https://lore.kernel.org/r/20241204-packing-pack-fields-and-ice-implementation-v9-0-81c8f2bd7323@intel.com

Changes in v9:
- Use BUILD_BUG_ON_MSG to provide more useful and detailed error messages,
  including the field array name, associated field index values, and the
  actual rule being violated. This improves the usability of the resulting
  error messages, especially for users unfamiliar with the API
  requirements.
- New implementation of CHECK_PACKED_FIELD and CHECK_PACKED_FIELD_OVERLAP,
  taking the reference of the total array field directly. This allows
  tail-calling the CHECK_PACKED_FIELD_OVERLAP from within
  CHECK_PACKED_FIELD, significantly reducing the number of lines required
  to implement all the macros.
- Drop the ARRAY_SIZE checks from the CHECK_PACKED_FIELDS_* macros. These
  were only necessary when users called the macros directly. Now that we
  always use __builtin_choose_expr to determine which one to call, this is
  a waste of the CPU cycles.
- Implement each CHECK_PACKED_FIELD_N recursively, by calling the previous
  CHECK_PACKED_FIELD_* macro. This means each additional macro now only
  needs 4 lines of code, instead of scaling linearly with the size of N.
  This is possible now that we no longer directly check the ARRAY_SIZE in
  each macro.
- Use do {} while(0) for implementing the multiline checks in each
  CHECK_PACKED_FIELD_* macro, instead of statement expressions. This helps
  with GCC giving up on processing due to the multiple layers of statement
  expressions when evaluating the CHECK_PACKED_FIELD_* macros.
- Link to v8: https://lore.kernel.org/r/20241203-packing-pack-fields-and-ice-implementation-v8-0-2ed68edfe583@intel.com

Changes in v8:
- Add my missing SOB on one of the patches
- Remove include/linux/packing_types.h and put the generated code directly
  into include/linux/packing.h
- Split documentation to its own patch, and use the proposed documentation
  from Vladimir
- Link to v7: https://lore.kernel.org/r/20241202-packing-pack-fields-and-ice-implementation-v7-0-ed22e38e6c65@intel.com

Changes in v7:
- Dropped the RFC tag for submission to net-next
- Link to v6: https://lore.kernel.org/r/20241118-packing-pack-fields-and-ice-implementation-v6-0-6af8b658a6c3@intel.com

Changes in v6:
- Revert to macro checks similar to v2.
- Add a __builtin_choose_expr() based macro to automatically select the
  appropriate size macro.
- Keep the pbuflen check separate from the main loop check, similar to v5.
- Link to v5: https://lore.kernel.org/r/20241111-packing-pack-fields-and-ice-implementation-v5-0-80c07349e6b7@intel.com

Changes in v5:
- Fix printf format specifier for the sym->st_size
- Link to v4: https://lore.kernel.org/r/20241108-packing-pack-fields-and-ice-implementation-v4-0-81a9f42c30e5@intel.com

Changes in v4:
- Move the buffer size checks to (un)pack_fields() macros.
- Enforce use of a sized type of the packed buffer, removing the now
  unnecessary pbuflen argument of (un)pack_fields().
- Drop exporting the buffer size to modpost.
- Simplify modpost implementation to directly check each symbol in the
  handle_packed_field_symbol() function. This removes the need for a hash,
  and is ultimately much simpler now that modpost doesn't need the size of
  the target buffer.
- Fix the width check to correctly calculate the width and compare it
  properly.
- Refactor modpost messages to consistently report the module name first,
  the symbol name second, and the field number 3rd.
- Correctly implement overlap checks in the modpost, rather than only
  checking field ordering.
- Link to v3: https://lore.kernel.org/r/20241107-packing-pack-fields-and-ice-implementation-v3-0-27c566ac2436@intel.com

Changes in v3:
- Replace macro-based C pre-processor checks with checks implemented in
  modpost.
- Move structure definitions into  <linux/packing_types.h> to enable reuse
  within modpost.
- Add DECLARE_PACKED_FIELDS_S and DECLARE_PACKED_FIELDS_M to enable
  automatically generating the buffer size constants and the section
  attributes.
- Add additional unit tests for the pack_fields and unpack_fields APIs.
- Update documentation with an explanation of the new API as well as some
  example code.
- Link to v2: https://lore.kernel.org/r/20241025-packing-pack-fields-and-ice-implementation-v2-0-734776c88e40@intel.com

Changes in v2:
- Add my missing sign-off to the first patch
- Update the descriptions for a few patches
- Only generate CHECK_PACKED_FIELDS_N when another module selects it
- Add a new patch introducing wrapper structures for the packed Tx and Rx
  queue context, suggested by Vladimir.
- Drop the now unnecessary macros in ice, thanks to the new types
- Link to v1: https://lore.kernel.org/r/20241011-packing-pack-fields-and-ice-implementation-v1-0-d9b1f7500740@intel.com

---
Jacob Keller (7):
      lib: packing: document recently added APIs
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

 Makefile                                        |   4 +
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  11 +-
 drivers/net/ethernet/intel/ice/ice_common.h     |   5 +-
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h  |  49 +--
 include/linux/packing.h                         | 425 ++++++++++++++++++++++++
 drivers/net/dsa/sja1105/sja1105_static_config.c |   8 +-
 drivers/net/ethernet/intel/ice/ice_base.c       |   6 +-
 drivers/net/ethernet/intel/ice/ice_common.c     | 293 ++++------------
 lib/packing.c                                   | 293 ++++++++++++----
 lib/packing_test.c                              |  61 ++++
 scripts/gen_packed_field_checks.c               |  37 +++
 Documentation/core-api/packing.rst              | 118 ++++++-
 MAINTAINERS                                     |   1 +
 drivers/net/ethernet/intel/Kconfig              |   1 +
 scripts/.gitignore                              |   1 +
 scripts/Makefile                                |   2 +-
 16 files changed, 955 insertions(+), 360 deletions(-)
---
base-commit: a0e1fc921cb0651cd11469bf5378ec342bf7094d
change-id: 20241004-packing-pack-fields-and-ice-implementation-b17c7ce8e373

Best regards,
-- 
Jacob Keller <jacob.e.keller@intel.com>


