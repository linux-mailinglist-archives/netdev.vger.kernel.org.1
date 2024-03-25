Return-Path: <netdev+bounces-81764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AB488B5D4
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 01:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CAB2B267E2
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 20:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389CC45BF1;
	Mon, 25 Mar 2024 20:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="An9UOG6d"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A4945BE1
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 20:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398393; cv=none; b=rEe3fzHd0Q+idNCccpIjdbDmLQEtjttJERn1DTCKCXT0aWPwszJsHyJDJ8vFCgpYYQ3W+nWC483dyxyW8M8FuMyATicD8jS5KFSiEFsug9MqkfzH4BZJm7pnX6iteN+muE3zHImaKXtTGsQY+wIJOVdOJRUz7p8bmrZE7VL9r2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398393; c=relaxed/simple;
	bh=oWJImHsSTHdsfbsyLj8GJCOglvXZ8mTrNjUGpdZoSRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pA6cqi0w0mMybeMwdZH5SMPnZbe7SQnSX9wNeeQwzVGmFW2FT8/ZZRUCz786rtGwXLvqrQfC/j34znX1jm4NUaEGKmxYFhC0Ycs+YyCphCBJM6umrWrN2SW4BMp67sFpsEHROwOWUqlqkbjZCZF427O59MfJ990zLp5nQpzSxqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=An9UOG6d; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711398392; x=1742934392;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oWJImHsSTHdsfbsyLj8GJCOglvXZ8mTrNjUGpdZoSRg=;
  b=An9UOG6d7EPolsYWbHWmQUQztURv51muX0RtngR0mC4Pp0sL3BHhdzf0
   JQXm9U29aD0FS9utBdXxTeq8K9XH0VnMFDb/2uagLKQALZStBQhG9OU+4
   uqp54sVRy2cIH4hDMMMJamYqhJfKUHEIKpxfGj0nk8PlDZlh8EEOFGItw
   IDtOXg4iHTYHHN+B8WKuosXT69zVc4EW+G/2lJyudIrQTaXzudSQe0+PY
   qlXq7CEYuKPTdMZopQXhDkEhetfY8Ij5wQmSlQfTi0RWH/JjWVpfNHZDQ
   hd16ItPEp4r6xlBzfopPLlTlGw9BhyN+2mv/n3JcU8gSg+/58/wg1i/iP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="10219629"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="10219629"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 13:26:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="15787361"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 25 Mar 2024 13:26:29 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	michal.swiatkowski@linux.intel.com
Subject: [PATCH net-next 0/8][pull request] ice: use less resources in switchdev
Date: Mon, 25 Mar 2024 13:26:08 -0700
Message-ID: <20240325202623.1012287-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Michal Swiatkowski says:

Switchdev is using one queue per created port representor. This can
quickly lead to Rx queue shortage, as with subfunction support user
can create high number of PRs.

Save one MSI-X and 'number of PRs' * 1 queues.
Refactor switchdev slow-path to use less resources (even no additional
resources). Do this by removing control plane VSI and move its
functionality to PF VSI. Even with current solution PF is acting like
uplink and can't be used simultaneously for other use cases (adding
filters can break slow-path).

In short, do Tx via PF VSI and Rx packets using PF resources. Rx needs
additional code in interrupt handler to choose correct PR netdev.
Previous solution had to queue filters, it was way more elegant but
needed one queue per PRs. Beside that this refactor mostly simplifies
switchdev configuration.

The following are changes since commit 537c2e91d3549e5d6020bb0576cf9b54a845255f:
  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Michal Swiatkowski (8):
  ice: remove eswitch changing queues algorithm
  ice: do Tx through PF netdev in slow-path
  ice: default Tx rule instead of to queue
  ice: control default Tx rule in lag
  ice: remove switchdev control plane VSI
  ice: change repr::id values
  ice: do switchdev slow-path Rx using PF VSI
  ice: count representor stats

 drivers/net/ethernet/intel/ice/ice.h          |   7 -
 drivers/net/ethernet/intel/ice/ice_base.c     |  44 +--
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   4 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c  | 362 +++---------------
 drivers/net/ethernet/intel/ice/ice_eswitch.h  |  13 +-
 drivers/net/ethernet/intel/ice/ice_lag.c      |  53 ++-
 drivers/net/ethernet/intel/ice/ice_lag.h      |   3 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  49 +--
 drivers/net/ethernet/intel/ice/ice_main.c     |  10 +-
 drivers/net/ethernet/intel/ice/ice_repr.c     | 126 +++---
 drivers/net/ethernet/intel/ice/ice_repr.h     |  24 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c    |   3 -
 drivers/net/ethernet/intel/ice/ice_switch.c   |   4 +
 drivers/net/ethernet/intel/ice/ice_switch.h   |   5 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h     |   1 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  11 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 -
 .../net/ethernet/intel/ice/ice_vsi_vlan_ops.c |   1 -
 18 files changed, 232 insertions(+), 489 deletions(-)

-- 
2.41.0


