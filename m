Return-Path: <netdev+bounces-251496-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLc4M9BucWkPHAAAu9opvQ
	(envelope-from <netdev+bounces-251496-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:26:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 486935FEEC
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDA308E387D
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 14:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552E742EED2;
	Tue, 20 Jan 2026 14:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OAhpT0DA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE506439013
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917748; cv=none; b=vAE3XPdN2EgAx9AbSniS8UeijJT361tkmMrTQ2HCYUT7K5Yjwfo+eolzYZOnapnKGwh4S9P6YRCU/M/gh/xRWwNsBjuwpMVvO0aDaPVowT6WxW2VeyWY+Tk0wFpib06yMDEWBK12dpb80LbKi6BokMBlu3tEsKU4+BLR3wPflW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917748; c=relaxed/simple;
	bh=9IsVLdapNNbc/4CpLd1Dzy6K3wU47Fpio5/3FQinHeU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ze4sXz5A7gzV61UeCcBCgVpXn1+ASQ+5oMAl2JuYgjm+jifGPaSs0qoYJPMGUen+1TZewoR4L6yYlJ27nlqZApCLa+KbCz9oOOjyz+2z5Hr++yttAsw+wg0hWlOl2amisIEMomLnF1mOmd8R0IldOwGR3g0Ei7eIql3+yCfshzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OAhpT0DA; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768917746; x=1800453746;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9IsVLdapNNbc/4CpLd1Dzy6K3wU47Fpio5/3FQinHeU=;
  b=OAhpT0DAkDGXbyMggXBSohEb4TjZL2YnSkqSojTP6bZ9hAAWPCHoM77O
   +cyu4XJDmEnjpYifCKB1z62N/0PPHLnQ7gJG/5BU7y0K4GX94mmtC3U0P
   YswtlpK6F/OQmlULKodu6iJTvdYckYnDqb9RzOms0/qeHqcvnbeKAuY3q
   h9N4IFbpGHene7Uq1bvFS4wkjYIwX6xYPlIC/MjefYnj/7rOjSvnwjAXw
   9O88ykKbI1oh8FO+/GrAIzX+avK1tHRqyAJFVV63ZzO1yzQdp3fb2+uHD
   IlzYjpV4lUAw06Tr5gPo/FTtQ1okgCD26ee+0KOpgjzVXhlJtfFGci2v/
   Q==;
X-CSE-ConnectionGUID: /39OZFUuQt6C5bq/Ic6gHA==
X-CSE-MsgGUID: KwcKzPQ1STe2sOqb5n6FWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="72711743"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="72711743"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 06:02:26 -0800
X-CSE-ConnectionGUID: bDuEciD1TKCzSk9x3qaB1w==
X-CSE-MsgGUID: To4a+SLBQZKvwv5/erzmmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="210978884"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa004.fm.intel.com with ESMTP; 20 Jan 2026 06:02:25 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-next v2 0/6] ixgbe: enable EEE for E610 devices
Date: Tue, 20 Jan 2026 14:44:28 +0100
Message-Id: <20260120134434.1931602-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	DATE_IN_PAST(1.00)[34];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251496-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jedrzej.jagielski@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 486935FEEC
X-Rspamd-Action: no action

Align SW structs with latest FW changes related to EEE enablement.
Address compatibility issues caused by the buffer size changes.
Implement ethtool callbacks which can be used to enable/disable EEE, but
generally the feature itself is enabled by default. What's important it
works only for link speeds > 1Gb/s, so even if enabled, it gets down
anytime link conditions aren't met. Still cannot configure LPI timers
and EEE advertised speeds.

Jedrzej Jagielski (6):
  ixgbe: E610: add discovering EEE capability
  ixgbe: E610: use new version of 0x601 ACI command buffer
  ixgbe: E610: update EEE supported speeds
  ixgbe: E610: update ACI command structs with EEE fields
  ixgbe: move EEE config validation out of ixgbe_set_eee()
  ixgbe: E610: add EEE support

 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c |  73 +++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   1 +
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 244 ++++++++++++++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  30 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |   1 +
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    |  38 ++-
 include/linux/intel/libie/adminq.h            |   1 +
 7 files changed, 325 insertions(+), 63 deletions(-)

---
v2: get rid of eee state refactoring patch; rebase series to the recent
    dev-q branch
---
2.31.1


