Return-Path: <netdev+bounces-281746-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJtgCFmG8GnuUQEAu9opvQ
	(envelope-from <netdev+bounces-281746-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:05:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9485D4822EF
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EE2833722E9
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7986038E5C5;
	Tue, 28 Apr 2026 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zvw9CDm0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE9838910D
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 09:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368404; cv=none; b=s/oAy9BG9/F4UdXI/+gdwjcehdbnACyd8WNVD7R78J9KElaxHR2Afbm1+xJ6CNQCquvaXx1ANJ+vITsNhMaIB95qEfvsNwgE1rXublsbBlU8bZ+ypit4nhkmPILKG+pmzkPqu8NvDX/OJoc7ev1+N5fVXifCwO8+lngO13SFJRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368404; c=relaxed/simple;
	bh=NPBLQJqucg7/CxKX3h1LojM1m977hcBM54QKuG8/OJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CwqyS+AVyh8JS8mFsxenYb89e6rjxBHFtlKsXkQ+hZCryHNbE8TMsFPYNKbH0tEwSQZc0dVKaAhBHtaBEwWMcovgEiclte9hx6NacLTgiw8FxJSnqZY1c00jDJDV3N0/qDHvfOOnNfVec6e6B2rkxHef7Rq0gXtFyjC4AeAy7Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zvw9CDm0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777368399; x=1808904399;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NPBLQJqucg7/CxKX3h1LojM1m977hcBM54QKuG8/OJ0=;
  b=Zvw9CDm0oZ8G1FmOqYFKX/j8MyQPfMWGwz/MiPg+d9Ba8b/vVOx6SNRG
   E95bMPEB1MQ4PkkPTl88LTW2qsDvDTe1LI7+BTNt9CeS2eh6/q+Rgxp03
   FK6s4VLRTth8ptSErXerKQ/ff5oPqlpvdrc/+bCcawuylm3yee/zXvLYf
   b+kOBeLk9HA0bYC6bazy9VPF2otyN+bPFBH5hi2zZsw32x1CeCiNapIYn
   ISOmgLgzWp/DvDIYWCnt7gaT85IwwdRUHAh8pwBbqaVmBaGYRJ9GzbJnt
   Su3KcHNd1LWEDO+RIYqxECiW4cmFkQEcG4kht4AkvTA/gDNFPke138BlA
   w==;
X-CSE-ConnectionGUID: zRCB01jBQ0iVi8u7ZqrD6Q==
X-CSE-MsgGUID: oOfP/95tQ+ieBRsWfKK0Rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="103731752"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="103731752"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 02:26:35 -0700
X-CSE-ConnectionGUID: Wzke/4szQrev/j5M+PO4pg==
X-CSE-MsgGUID: mK2Ni828QX2LTMAvEA+HGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="237861386"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa003.jf.intel.com with ESMTP; 28 Apr 2026 02:26:32 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id B5BEE2816F;
	Tue, 28 Apr 2026 10:26:29 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next 0/2] devlink, ice, mlx5: add init/fini ops for shared devlink for ice to use
Date: Tue, 28 Apr 2026 11:09:10 +0200
Message-Id: <20260428090912.3461-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9485D4822EF
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
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-281746-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Extend devlink by two callbacks used by shared devlink.
Callbacks provide option for the driver to have constructor/destructor
for the priv data attached to the shared devlink instance.

Use the callbacks from ice.
mlx5 is just touched to have additional param passed.

Non-null additional param for the constructor will be used by separate series.

Przemek Kitszel (2):
  devlink, mlx5: add init/fini ops for shared devlink
  ice: use shared devlink to store ice_adapters instead of custom xarray

 drivers/net/ethernet/intel/ice/ice_adapter.h  | 13 +--
 include/net/devlink.h                         | 26 +++++
 .../net/ethernet/intel/ice/devlink/devlink.c  |  3 +
 drivers/net/ethernet/intel/ice/ice_adapter.c  | 95 ++++++-------------
 drivers/net/ethernet/intel/ice/ice_main.c     |  4 +-
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  |  2 +-
 net/devlink/sh_dev.c                          | 39 +++++++-
 7 files changed, 106 insertions(+), 76 deletions(-)

-- 
2.39.3


