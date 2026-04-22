Return-Path: <netdev+bounces-280485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGRgFkv16Gl3SAIAu9opvQ
	(envelope-from <netdev+bounces-280485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:20:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA6144878E
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 586843007A69
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AB635295C;
	Wed, 22 Apr 2026 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mab07/N0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA46220F49;
	Wed, 22 Apr 2026 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874808; cv=none; b=XuCCHY/8emQzunJBADNZN0bSGvwGG6vxGscsfB/h4MKKAHRGRXwNq1mbbg2wFlSdjxt02uqhT7yeEYnSx7nAHn/gFyIvFpGoCK3we5Im7l0ewDpda4UaF/UjFatVhemoOQBeWw/VDhm4nflDJ1zlWfMUlVFPZVxONHnd/EbFZE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874808; c=relaxed/simple;
	bh=Ut5giVmbsImJs8yL0H3YCWudMqhBdgqTW7EV5XSP3Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MoECGbYV/RFT7yl8zS2X7RXEyYTdKULuGN0/UCNl7IwCJlGrQuUYxO+ZLh3OcjvCZg/4uVJFXotrvPlpJdKcFhsRqOKNBeo3nqqjt+YLqZ0rEhVuMRXItlDUWS/ynBs9+1RBI53zF94I4XdHsZlQIU6z1S9YLoR9pzr4rvoIenY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mab07/N0; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776874807; x=1808410807;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ut5giVmbsImJs8yL0H3YCWudMqhBdgqTW7EV5XSP3Ls=;
  b=Mab07/N0Vtn2iOpegP8DeFUyfcfnQ/R4RIk/UFNxnIq4vdUE1i+0jHsY
   /A4pcPObUVqqCEcytg9xizmv/Be9uNRoQQBwSNsJHxUHrGa87upOC++53
   +ELbocZkxmqQouhndW8E4t6HE5wmBIYAGGSSv31lChxtAF5N0lgs5gL6m
   e/gi+z6XIa9yZFQSCoSWpiCeM075pxUlhy+H9YYm9xpVL688C7+xApXRT
   nUbNyGib2Xhw8aWuGTcAbygxPZBsb9lJYW+JpwnvfAKBOYk8dahl+g8un
   jpuqS+ZTCBzuIVLnhabHv0fqOSVnzEDtuaXZB+MqhqFPxC9jbCWJviQxW
   w==;
X-CSE-ConnectionGUID: ufrzjZwCROGfZT+szV/8OA==
X-CSE-MsgGUID: GfeZEEVeQ4mtbOy2q7aCvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="88134460"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="88134460"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 09:20:07 -0700
X-CSE-ConnectionGUID: w0LEF1wJTcy4bK6zG8h0tw==
X-CSE-MsgGUID: g1ONIYzqTkuMuwXE53Wm/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="228052418"
Received: from unknown (HELO localhost.png.intel.com) ([10.107.255.61])
  by fmviesa010.fm.intel.com with ESMTP; 22 Apr 2026 09:20:03 -0700
From: KhaiWenTan <khai.wen.tan@linux.intel.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	faizal.abdul.rahim@intel.com,
	hong.aun.looi@intel.com,
	khai.wen.tan@intel.com,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Subject: [PATCH iwl-next v3 0/3] igc: add support for forcing link speed without autonegotiation
Date: Wed, 22 Apr 2026 23:56:58 +0800
Message-ID: <20260422155701.7420-1-khai.wen.tan@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280485-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khai.wen.tan@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ozlabs.org:url,intel.com:dkim,intel.com:email,linux.intel.com:mid]
X-Rspamd-Queue-Id: 6DA6144878E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

This series adds support for forcing 10/100 Mb/s link speed via ethtool
when autonegotiation is disabled on the igc driver.

Changes in v3:
- Modify condition from "if (duplex == DUPLEX_HALF)" to
  "if (duplex != DUPLEX_FULL)". (Simon Horman)

Changes in v2:
- When forcing half-duplex, set hw->fc.requested_mode = igc_fc_none,
  since half-duplex cannot support flow control per IEEE 802.3.
  (Simon Horman)
- Split the original single patch into three patches for clarity:
  patches 1 and 2 are preparatory cleanups; patch 3 carries the
  functional change.

v2 at:
https://patchwork.kernel.org/project/netdevbpf/patch/20260416015520.6090-4-khai.wen.tan@linux.intel.com/

v1 at:
https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20260409072747.217836-1-khai.wen.tan@linux.intel.com/

Faizal Rahim (3):
  igc: remove unused autoneg_failed field
  igc: move autoneg-enabled settings into igc_handle_autoneg_enabled()
  igc: add support for forcing link speed without autonegotiation

 drivers/net/ethernet/intel/igc/igc_base.c    |  35 +++-
 drivers/net/ethernet/intel/igc/igc_defines.h |   9 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 203 +++++++++++++------
 drivers/net/ethernet/intel/igc/igc_hw.h      |  10 +-
 drivers/net/ethernet/intel/igc/igc_mac.c     |  16 +-
 drivers/net/ethernet/intel/igc/igc_main.c    |   2 +-
 drivers/net/ethernet/intel/igc/igc_phy.c     |  65 +++++-
 drivers/net/ethernet/intel/igc/igc_phy.h     |   1 +
 8 files changed, 251 insertions(+), 90 deletions(-)

--
2.43.0


