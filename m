Return-Path: <netdev+bounces-281663-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJxtI1VS8Gk6RwEAu9opvQ
	(envelope-from <netdev+bounces-281663-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 08:23:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B45847E034
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 08:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A76D300823E
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 06:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CE8345738;
	Tue, 28 Apr 2026 06:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VixOC+kp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCCD1C5D5E;
	Tue, 28 Apr 2026 06:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777357392; cv=none; b=Dfo6x/OyOr6JNXR0rKwwRD/bltAI0sjIFBYpu7f46ZYUL7zKa851CVkuOEFl3VpvMKxokTkA+bfmCb7usrqTmj77MgHAL8Pf9BBVRodPfQSF0eXhJKOcziqBpAdqt9DZ2f5nvG+YGnxU2FBG/dsKJIhRLUGdPOM9geb2MvYXQjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777357392; c=relaxed/simple;
	bh=G5klac0z2QVk9ee66GRUdGMtTliec7PBh21kBi9IFyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=povaAiEKwX+3bHRs3Xc8PnhXqO6PqCq1kgg2AWb0uEFeY+LGpApsNt27ftXHQqHUUcok9BXmVwnM2uSI1M24+0K3ly2SlI8uHpNDlo++GYMFqCW39cqjhOCeD+rEXnKGAMoCxqrjr4ER/o0qHITZFskzZxNVxJrY609iDXXCnTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VixOC+kp; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777357390; x=1808893390;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=G5klac0z2QVk9ee66GRUdGMtTliec7PBh21kBi9IFyI=;
  b=VixOC+kpMPu47Ahbj9iDU4qiod2jrXuKswEywhdzHrTg6vlSqKiHzLlN
   bD1uBZoaQllxRB6icAZmIR586djEDdSPhA93sfavoTkpN3NYSOUfXrxf/
   L8QZs6E3oTFdVL7Rf8saWbilwGXu4z6gUwV7Zx8MrjvfFfTSx42ZPtvxW
   HZ+nN83jf015ds/7ITAxlci+mM9f8RHpXvqYRcFx7luehbbypH+9eDbGc
   86zWcjwUrSHgA5KmkEtBqI/GGtZzUmKMVA2XZf+LhuSivmDZDilJzqZ26
   BOj+nXifkf3nBkIAWQNaHT20FdHKtXsMUfQDPWCrUbVuKmOjEZXlw55M6
   A==;
X-CSE-ConnectionGUID: xG+fGlLKRTOzOrIOpFyINQ==
X-CSE-MsgGUID: tFFxJftlSCCZ9CqKfN5JFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78366107"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="78366107"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 23:23:01 -0700
X-CSE-ConnectionGUID: zt+B+SUwR1SA2xq6YIiuSg==
X-CSE-MsgGUID: Znre4iORQC60RyxHeo5/1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="232986846"
Received: from unknown (HELO localhost.png.intel.com) ([10.107.255.61])
  by orviesa010.jf.intel.com with ESMTP; 27 Apr 2026 23:22:59 -0700
From: KhaiWenTan <khai.wen.tan@linux.intel.com>
To: anthony.l.nguyen@intel.com,
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
Subject: [PATCH iwl-next v4 0/3] igc: add support for forcing link speed without autonegotiation
Date: Tue, 28 Apr 2026 14:00:06 +0800
Message-ID: <20260428060009.311393-1-khai.wen.tan@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1B45847E034
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-281663-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khai.wen.tan@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]

From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

This series adds support for forcing 10/100 Mb/s link speed via ethtool
when autonegotiation is disabled on the igc driver.

Changes in v4:
- Validate that autoneg is AUTONEG_ENABLE or AUTONEG_DISABLE early
  in igc_ethtool_set_link_ksettings() to avoid passing unexpected
  values to igc_handle_autoneg_disabled(). (Simon Horman)

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

v3 at:
https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20260422155701.7420-1-khai.wen.tan@linux.intel.com/

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
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 209 +++++++++++++------
 drivers/net/ethernet/intel/igc/igc_hw.h      |  10 +-
 drivers/net/ethernet/intel/igc/igc_mac.c     |  16 +-
 drivers/net/ethernet/intel/igc/igc_main.c    |   2 +-
 drivers/net/ethernet/intel/igc/igc_phy.c     |  65 +++++-
 drivers/net/ethernet/intel/igc/igc_phy.h     |   1 +
 8 files changed, 257 insertions(+), 90 deletions(-)

--
2.43.0


