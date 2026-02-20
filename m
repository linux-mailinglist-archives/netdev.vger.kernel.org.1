Return-Path: <netdev+bounces-259681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJ4xIfsomGlqBwMAu9opvQ
	(envelope-from <netdev+bounces-259681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 10:27:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D228E16634E
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 10:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E97923006B30
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 09:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2023E320A0A;
	Fri, 20 Feb 2026 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UkffDY3w"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77C931ED8A
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 09:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771579594; cv=none; b=h5N54mbsH44i+6+NGibuY2rRMvXOsWBs3y8CWAL9ITkXnCn45TmFVVco8TLrEtbdWdQsXYvLQ3GMA2YqfZhrYld9+4ZRfF/MewkNVLK14kjdFtoPWSBwQz1P0XYsnAPiYKLHA1uSbyWrRxLEKnGNG3ZmTrrGDnriK4c3CnGDgH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771579594; c=relaxed/simple;
	bh=lyp5Xhf9Uz/O9UFSOZCogRvPaliG7+luXfZB0IaqxBM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=d67ZWmog43yWcJlc73mDvcGXBLbShDxLhxHQHtlfbq33UPEOQClpDkdPrRWxn+yLg6oiw7nWLN+FQuzGDqHVLHLuO0MJRWCrfQlp0iPgzk+3Hqq5/pozMmAYyvoEa5WOxeodDSp8z1zOykwQbMVcv+KjUg6KTspt3uABD5PfW9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UkffDY3w; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771579593; x=1803115593;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lyp5Xhf9Uz/O9UFSOZCogRvPaliG7+luXfZB0IaqxBM=;
  b=UkffDY3wk+ab6LhELTL3tWKK3/tvuNR0KBrV4ft/sS6SIS44AvQbByvd
   tXsjRyU5mZ6NwBDt/qRyxuDqFTo3H9dBKH/THXWq6LrbVsSiN5oo+knf0
   O/X0fxiMuyC8Ww+K0/tVDftBFS76R+1ORF0R0Yr8fjLjNHEamQPdqwUdb
   vM4mHRCZbkmKQsCj1E5Cw5Vukij14mhyuYqkGgejAKnYXrw9Zg+j8w2a9
   RYL2rYcZ4HN9QbHLd4Km0svvi7w8kzP72xUC9XCwDDKUJFVehPHNadbwG
   zi3Htwoop+SEb3uwtVPekzzaQ/z4u10avOk07AeAc6AgSMnwfi6DpZitq
   g==;
X-CSE-ConnectionGUID: 7dxZvdKpRZ6zEGc9JrpsBg==
X-CSE-MsgGUID: QLzHKsHBREetXJE70OV14w==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72373464"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="72373464"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 01:26:32 -0800
X-CSE-ConnectionGUID: F9BhZlYTQQOZit3tH1R8qw==
X-CSE-MsgGUID: ciKCG1nkSKGnR5j7B4vNqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="214030004"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa010.jf.intel.com with ESMTP; 20 Feb 2026 01:26:32 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v3 0/2] ice: implement symmetric RSS hash configuration
Date: Fri, 20 Feb 2026 10:26:28 +0100
Message-ID: <20260220092630.720082-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259681-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: D228E16634E
X-Rspamd-Action: no action

The ice driver has advertised symmetric RSS support via
supported_input_xfrm since the capability was added, but ice_set_rxfh()
ignored the input_xfrm parameter entirely, so enabling symmetric hashing
had no actual effect.

This series fixes that.  Patch 1 extends the ethtool core so that
drivers hashing GTP flows on TEID can report it honestly without
blocking symmetric-xor configuration.  Patch 2 wires up the ice driver.

The need for patch 1 surfaced because GTP flow profiles in ice always
include TEID in the hash.  ethtool_check_flow_types() calls
get_rxfh_fields() for every hashable flow type before allowing
symmetric-xor; ethtool_rxfh_config_is_sym() rejected any bitmap
containing RXH_GTP_TEID since it has no src/dst counterpart.  TEID
is the same value in both tunnel directions, so this rejection is
incorrect: including it does not break symmetry.

Rather than hiding TEID from the reported fields (which would silently
misrepresent hardware behaviour), patch 1 fixes the validator, and
patch 2 reports TEID honestly.

Tested with tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
on an E810 card running kernel 6.19-rc8.

---
v2 -> v3:
 - Split into 2 patches: ethtool core fix separate from driver change
 - Drop the RXH_GTP_TEID stripping workaround from the driver; instead
   fix ethtool_rxfh_config_is_sym() to accept TEID as intrinsically
   symmetric (patch 1)
 - Fix ice_get_rxfh_fields(): the v2 unconditional assignment
   "nfc->data = ICE_RSS_ALLOWED_FIELDS" clobbered fields set earlier in
   the same function; replaced with pair-completion using |= so only
   the missing half of a partial pair is filled in
 - Remove ICE_RSS_ALLOWED_FIELDS define (no longer needed)
 - Report RXH_GTP_TEID honestly for GTP flow types

v1 -> v2:
 - Preserve valid symmetric RSS fields instead of overwriting nfc->data
   unconditionally

Aleksandr Loktionov (2):
  ethtool: treat RXH_GTP_TEID as intrinsically symmetric
  ice: implement symmetric RSS hash configuration

 drivers/net/ethernet/intel/ice/ice_ethtool.c | 48 +++++++++++++---
 drivers/net/ethernet/intel/ice/ice_lib.c     |  7 ++-
 drivers/net/ethernet/intel/ice/ice_lib.h     |  1 +
 net/ethtool/common.c                         |  3 +
 4 files changed, 47 insertions(+), 12 deletions(-)

-- 
2.43.0

