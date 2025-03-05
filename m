Return-Path: <netdev+bounces-172204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEB2A50DC2
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 22:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883CE3B08BD
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 21:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D14525BAD1;
	Wed,  5 Mar 2025 21:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AbzF9UDk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973262571D4
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 21:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210560; cv=none; b=BLO4GQjgAsPI+2drLZHpzWRCRFTkTuTnGdI6sK8h1LtgMvdqwJm8eURjD0nfWv+cCkNuvsiZ+kN+wzEdBT+Xb65wd2maQQ7MCv3q559qPZwUTnPsSBJVQp89S2ba/+AnN/0ZrgEEur21BO4hLbXOpcAQkeSNi54uUhJEp9DKSGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210560; c=relaxed/simple;
	bh=FBY0045wBL5ihR8jndBaO69CIUkCfNCzJFf1G0zHtYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kwkClJzlEv75hzJoHyrYPimGnwNcjyHucSYo/ZQQxxAy5lkX+6WUQoEp834D/nuqO7hJU1yAK6jbhfsdTp7/c7cyBDhaAOekcIGAlU+Btp6MvyQ3iA0NmDdOFC9jhdUaD0vQguKl78JI1MyZYlImhrGmxZ1YjHLb3K00j1nJ3O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AbzF9UDk; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741210558; x=1772746558;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FBY0045wBL5ihR8jndBaO69CIUkCfNCzJFf1G0zHtYY=;
  b=AbzF9UDkZBaMwRKWa+W4j+FrT3Xb1Yxnp7i8YdezFOSXlLNpCEGElLb5
   w98YQJzREilAxi7x3s/JFIUfOOVytQcZn+7fw3rIQ/R90g7MkXNtDK5X0
   UuVB/pLwkLyjs1p8ygp5l+46AIHQlBwW5LrTHkaAWTUG1jmCI+V8M7qk+
   0sMYN7aFXGtbbAorkUgNhurC3KsgphzwEbRyoKZUnHNC5tKVw9nkt6dL5
   c0bs29se86sitiEvHQ2y8/w3jNAxoBpzNtue3aGt3iZz6/7CEEUxQm703
   j5fQum4+1f7bloh8FCbsiiDJ8PKxvGAaGalGqgFw6F4UAW1u5nWX/A+C7
   g==;
X-CSE-ConnectionGUID: +4EJa56/Qd62GZaTuthR4A==
X-CSE-MsgGUID: aXxQy+34SEKAs37+mNBIAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53606473"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="53606473"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 13:35:57 -0800
X-CSE-ConnectionGUID: o5iIuP3lR86KV8Nf+AWEhg==
X-CSE-MsgGUID: vzjW4ANyREuJIIWO4FD4pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="123828476"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 05 Mar 2025 13:35:55 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates 2025-03-05 (ice)
Date: Wed,  5 Mar 2025 13:35:42 -0800
Message-ID: <20250305213549.1514274-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ice driver.

Larysa removes modification of destination override that caused LLDP
packets to be blocked.

Grzegorz fixes a memory leak in aRFS.

Marcin resolves an issue with operation of switchdev and LAG.

Przemek adjusts order of calls for registering devlink in relation to
health reporters.

The following are changes since commit 3c9231ea6497dfc50ac0ef69fff484da27d0df66:
  net-timestamp: support TCP GSO case for a few missing flags
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Grzegorz Nitka (1):
  ice: fix memory leak in aRFS after reset

Larysa Zaremba (1):
  ice: do not configure destination override for switchdev

Marcin Szycik (1):
  ice: Fix switchdev slow-path in LAG

Przemek Kitszel (1):
  ice: register devlink prior to creating health reporters

 drivers/net/ethernet/intel/ice/ice_arfs.c    |  2 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c |  6 -----
 drivers/net/ethernet/intel/ice/ice_lag.c     | 27 ++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_lib.c     | 18 -------------
 drivers/net/ethernet/intel/ice/ice_lib.h     |  4 ---
 drivers/net/ethernet/intel/ice/ice_main.c    |  4 +--
 drivers/net/ethernet/intel/ice/ice_txrx.c    |  4 ++-
 7 files changed, 33 insertions(+), 32 deletions(-)

-- 
2.47.1


