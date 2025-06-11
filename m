Return-Path: <netdev+bounces-196672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C624AAD5DBD
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 20:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338903A301B
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 18:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA8922173D;
	Wed, 11 Jun 2025 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CDynZHo1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D79013A3F2
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749665007; cv=none; b=bx3DBgWLqF+otCbVP7Mjo9KFSBhslK49BHcH+ewPFMs5MttlX4A6nZcrfBkZswd2RoCvc5LyQyLb2x8C43eQHN91p83dNZVWEhaVPZ/GRGnOjFgFULKrac9FDbJO9ngdhzoAe6xEYEq7bVIpfGJk2AIE48ZnNV62WVm99If8VA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749665007; c=relaxed/simple;
	bh=/aVdoO2QJqPMb5dpAsNkKQVDF+UP4ApXq/tzLwU3wL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KiOzUXWZhxIrmARGbr0L+zeX+u9xtBAw5T7iaMeYc4SlSlUwJJwEmW3bEe2qxoOwRutb3kIu4X8BL9RCGxsgU4ScmO7fYS1iHDDnzRaLb8NPTu9rJ1BjUWVJwHtXkdPnnUqrc2W5GZ+yA8sW3yTAatxgCdcMSJm5xW90C4c+L5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CDynZHo1; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749665005; x=1781201005;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/aVdoO2QJqPMb5dpAsNkKQVDF+UP4ApXq/tzLwU3wL0=;
  b=CDynZHo1ReDlVQ/G3zq2LFblxtnLtNUx0TpRTdCGYB8A2gMr9Jki5Yc4
   uXfCFCC375VWTCJU2Jne4gTFoPfkf3yXEcUhOOMJE5cGiZgudp/a9ff3q
   klJL4+2LszUirWBr6m6Y8WSxIrLkelDFE20f7wpz6R1JWCtxSppjghp5n
   6oxhw9Z76cifCZrYYjwchZTSBEqq4cTVTYW6N8oWVdScY6ViH14+GrjiG
   eIPENmtYWcGqOQdsH1ix7g5aT4UPnO4uSgOPi4DWOH9iO0YYzVmMB9XKN
   SQgw6cOL//zV/0tr5w0R0IpDEU9O0fyTIsKyoRaJo9xksL4DajTpuNLHP
   w==;
X-CSE-ConnectionGUID: th5Lc1ynQ/+UpskxYOK8iQ==
X-CSE-MsgGUID: HwpWw0IoS7ypl0+Xd0aXwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51042530"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="51042530"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 11:03:25 -0700
X-CSE-ConnectionGUID: R6SgpyuASK27esVfn7wPqg==
X-CSE-MsgGUID: fKC0ILmORwmY0KUE8Kk+Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="152418240"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 11 Jun 2025 11:03:24 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	faizal.abdul.rahim@linux.intel.com,
	faizal.abdul.rahim@intel.com,
	chwee.lin.choong@intel.com,
	vladimir.oltean@nxp.com,
	horms@kernel.org,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com
Subject: [PATCH net-next 0/7][pull request] igc: harmonize queue priority and add preemptible queue support
Date: Wed, 11 Jun 2025 11:03:02 -0700
Message-ID: <20250611180314.2059166-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Faizal Rahim says:

MAC Merge support for frame preemption was previously added for igc:
https://lore.kernel.org/netdev/20250418163822.3519810-1-anthony.l.nguyen@intel.com/

This series builds on that work and adds support for:
- Harmonizing taprio and mqprio queue priority behavior, based on past
  discussions and suggestions:
  https://lore.kernel.org/all/20250214102206.25dqgut5tbak2rkz@skbuf/
- Enabling preemptible queue support for both taprio and mqprio, with
  priority harmonization as a prerequisite.

Patch organization:
- Patches 1-3: Preparation work for patches 6 and 7
- Patches 4-5: Queue priority harmonization
- Patches 6-7: Add preemptible queue support
---
IWL: https://lore.kernel.org/intel-wired-lan/20250519071911.2748406-1-faizal.abdul.rahim@intel.com/

The following are changes since commit 0097c4195b1d0ca57d15979626c769c74747b5a0:
  net: airoha: Add PPPoE offload support
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 1GbE

Faizal Rahim (7):
  igc: move TXDCTL and RXDCTL related macros
  igc: add DCTL prefix to related macros
  igc: refactor TXDCTL macros to use FIELD_PREP and GEN_MASK
  igc: assign highest TX queue number as highest priority in mqprio
  igc: add private flag to reverse TX queue priority in TSN mode
  igc: add preemptible queue support in taprio
  igc: add preemptible queue support in mqprio

 drivers/net/ethernet/intel/igc/igc.h         |  33 +++++-
 drivers/net/ethernet/intel/igc/igc_base.h    |   8 --
 drivers/net/ethernet/intel/igc/igc_defines.h |   1 +
 drivers/net/ethernet/intel/igc/igc_ethtool.c |  12 +-
 drivers/net/ethernet/intel/igc/igc_main.c    |  57 ++++++---
 drivers/net/ethernet/intel/igc/igc_tsn.c     | 116 ++++++++++++++++---
 drivers/net/ethernet/intel/igc/igc_tsn.h     |   5 +
 7 files changed, 189 insertions(+), 43 deletions(-)

-- 
2.47.1


