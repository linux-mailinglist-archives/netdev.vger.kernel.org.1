Return-Path: <netdev+bounces-122924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C53963326
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 22:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E855C1C23DE8
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 20:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5250C1AC442;
	Wed, 28 Aug 2024 20:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gzYMH+Ym"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5925E156C6F
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 20:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724878652; cv=none; b=sHaEQDjqPCA6g7O1CTZvCotBQuQRGLGs5BIdL2P3BqrPOHJ0mU0jVgEJQU3auguqvTVkRoOAzJ3ExAuE50GWrFGEeUIIboCKUnHoBTM+m7cYoUuZzdW9g4bLAtEXdTT8qXlShHnCYaw+Q10X2W7AvcWO0FCs0UNnBA8CqRcBOew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724878652; c=relaxed/simple;
	bh=cySKZdMTLgmyhw3lp7daIkseQEt1zFRwj7CiVn4czkk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VdpigWq20aQA7fp86Z/MZ8QAVF8jhhWg556jbSiUVd5LSs4fis48pUiQXdos5wGXoeI/vHObeIRmFj7bNLkTF40NIN761loFFaZKVLCACzIyC6r8ArFgXdaB6M2kUjC/e+IvdB+M4pnQaYVJvXmLsrgaQ9MAOdb1NTIfNUqgjIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gzYMH+Ym; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724878651; x=1756414651;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=cySKZdMTLgmyhw3lp7daIkseQEt1zFRwj7CiVn4czkk=;
  b=gzYMH+YmwZX/gcrlKbM3a1fLFSTqiQKXibx5dpCcbpIS66xQ8mVkD9pg
   68jFD10qADZpYugM4eM7WBq8ELtsSC6CdnQLNiyYopoJ6pqmSivWpdXZf
   tvab7/cEVwRwICBb/o8K2IF3Tahh0r5xGtr+CZSIzE2+cQHcZR4jb5TV7
   NPEr5X07AC/yopwHb+I8tV2RgEDp5A9S+7fCgK2/j/B1JGicPVDPHGMUe
   cY0xNcdwvwOrJcfTds4w520y9RDgZJ7af2+g0J8mTRdUZQ362Vusp6/Nr
   T4iGtzOMW8/EQctXSQV2KrH83l4r7NFOvCHOWHvvT2yG8/rIT+1SIbRzD
   Q==;
X-CSE-ConnectionGUID: wzLX1ESFSamfltseIKagVw==
X-CSE-MsgGUID: hFyiwXdKS5iUnoyfFeDTkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="34592597"
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="34592597"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 13:57:29 -0700
X-CSE-ConnectionGUID: 3wihyRQBRj+jFbFawAN3gg==
X-CSE-MsgGUID: t+VW1UmkRW+m1NH7FQsMiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="64049956"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 13:57:29 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-next v2 00/13] ice: use <linux/packing.h> for Tx and Rx
 queue context data
Date: Wed, 28 Aug 2024 13:57:16 -0700
Message-Id: <20240828-e810-live-migration-jk-prep-ctx-functions-v2-0-558ab9e240f5@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC2Pz2YC/5WOTQ7CIBCFr2Jm7RgYiVVX3sO4sDDa0UobQKxpe
 nexnsDl+8n73giRg3CE/WKEwFmidL4IWi7ANmd/ZRRXNJAio7aakLdaYSuZ8SHXcE6lj7c79oF
 7tGnAy9PbrxnRmY2rqdrVZDdQ9krlIsPMOoK8WvQ8JDiVpJGYuvCeT2Q95z8eVX/wskaFyhhiY
 kNuTQfxiduV7R5wmqbpA3LvYKLsAAAA
To: Vladimir Oltean <olteanv@gmail.com>, netdev <netdev@vger.kernel.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
X-Mailer: b4 0.14.0

This series refactors the Tx and Rx queue context data packing in the ice
driver to use the <linux/packing.h> API. This is intended to aid in the
future implementation of unpacking context data for live migration. While
it strictly does save a few bytes in the module according to bloat-o-meter,
the savings is quite minimal (~200 bytes).

While initially implementing the logic, it was discovered that the packing
code does not work properly if the provided buffer size is not a multiple
of 4 bytes. This is also fixed by this series, along with some general
improvements to the API including the addition of pack() and unpack().

First, several improvements and cleanups to the packing API are made:

An additional sanity check is added to packing() to ensure that the
bit indices do not point outside the bounds of the provided buffer.

The packing() implementation is adjusted to work correctly when given
an arbitrary buffer size.

The duplicate kernel-doc for packing() is removed from the header
file.

The packing API gaves the pack() and unpack() wrappers which simplify
the use of packing, and enable better const correctness checking.

The pack() and unpack() implementations are separated and packing()
becomes a simple wrapper that selects between the two operations. This is
intended to improve the logic as several conditionals can be dropped.

A suite of KUnit tests for the packing API have been added, based on
simple selftests originally developed by Vladimir.

Additional unit tests for the packing library are added.

A bug in the QUIRK_MSB_ON_THE_RIGHT of the packing API is fixed, along with
additional unit tests covering this behavior.

Following the improvements to the packing API, the ice driver is
refactored:

The int_q_state field is removed from the ice_tlan_ctx structure and
packing definitions. This field is not used, and can't even be properly
packed or unpacked as its size exceeds 8 bytes.

The existing packing code based on ice_set_ctx() is ripped out and replaced
with an implementation based on pack().

The sizes of fields in ice_tlan_ctx and ice_rlan_ctx are updated to better
reflect their actual size.

The setting of the prefetch enable bit in the Rx context is moved into
ice_setup_rx_ctx() where the rest of the Rx context is configured. This is
less surprising than having the ice_write_rxq_ctx() always overwrite that
field of the context.

The copy_rxq_ctx_to_hw() and ice_write_rxq_ctx() are updated to align with
modern kernel style guidelines. This includes removing an unnecessary NULL
check, updating the kdoc descriptions to align with the check-kdoc, and
making ice_copy_rxq_ctx_to_hw() void. This ensures the style for these
functions will match the style for the similar functions needed to enable
live migration in a future series.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes in v2:
- Fix netdev address
- Drop unnecessary fixes tag in prefetch enable patch
- Add a module description to the KUnit tests
- Mark the test cases array in packing_test.c static
- Prefer 'Return:' over 'Returns:' for kdoc
- Link to v1: https://lore.kernel.org/r/20240827-e810-live-migration-jk-prep-ctx-functions-v1-0-0442e2e42d32@intel.com

I opted to include the packing changes in this series to Intel Wired LAN,
because the changes are only required due to the new use with the ice
driver. I also do not believe any existing driver uses
QUIRK_MSB_ON_THE_RIGHT, so I don't think the fix for that quirk needs to go
through net or stable either.

The packing library changes were discussed here:
https://lore.kernel.org/netdev/a0338310-e66c-497c-bc1f-a597e50aa3ff@intel.com/

In addition, several of the changes are taken from Vladimir's github:
https://github.com/vladimiroltean/linux/tree/packing-selftests

Strictly, the changes for pack() and unpack() are not required by ice, but
Vladimir requested that we try to use the new API so that I am not adding
another driver which needs updating in the future. In addition, pack() and
unpack() enable const checking.

---
Jacob Keller (8):
      lib: packing: add KUnit tests adapted from selftests
      lib: packing: add additional KUnit tests
      lib: packing: fix QUIRK_MSB_ON_THE_RIGHT behavior
      ice: remove int_q_state from ice_tlan_ctx
      ice: use <linux/packing.h> for Tx and Rx queue context data
      ice: reduce size of queue context fields
      ice: move prefetch enable to ice_setup_rx_ctx
      ice: cleanup Rx queue context programming functions

Vladimir Oltean (5):
      lib: packing: refuse operating on bit indices which exceed size of buffer
      lib: packing: adjust definitions and implementation for arbitrary buffer lengths
      lib: packing: remove kernel-doc from header file
      lib: packing: add pack() and unpack() wrappers over packing()
      lib: packing: duplicate pack() and unpack() implementations

 drivers/net/ethernet/intel/ice/ice_common.h    |  13 +-
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h |  33 +-
 include/linux/packing.h                        |  32 +-
 drivers/net/ethernet/intel/ice/ice_base.c      |   6 +-
 drivers/net/ethernet/intel/ice/ice_common.c    | 333 ++++++--------------
 lib/packing.c                                  | 304 ++++++++++++------
 lib/packing_test.c                             | 412 +++++++++++++++++++++++++
 Documentation/core-api/packing.rst             |  71 +++++
 MAINTAINERS                                    |   1 +
 lib/Kconfig                                    |  12 +
 lib/Makefile                                   |   1 +
 11 files changed, 840 insertions(+), 378 deletions(-)
---
base-commit: 2c163922de69983e6ccedeb5c00dec85b6a17283
change-id: 20240812-e810-live-migration-jk-prep-ctx-functions-d46db279b2c6

Best regards,
-- 
Jacob Keller <jacob.e.keller@intel.com>


