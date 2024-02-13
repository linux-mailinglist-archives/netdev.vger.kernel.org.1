Return-Path: <netdev+bounces-71126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 849AE8526D4
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 02:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4063F285272
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 01:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA75126295;
	Tue, 13 Feb 2024 01:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iwv8NWtT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227221B7E6
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 01:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707786363; cv=none; b=oWGecXXADBM1JFC+ZF1j6ZnoXXzMdh1Gm377KtcGCySqaw+qub5pG5wkRhY7qGABPZadyi0xudoxJI28VVI0yVPQ3Rlfhh/Pj2VLF1s/SLQaC9v5IygKy4MpHlrjwmBq/uxEtjjzTkELElQGmtgifoA2Ff8ZB4ugB/zhkwNtFp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707786363; c=relaxed/simple;
	bh=c4dzWXtMlY2dRiUBcDkwmMn0qPlOU6UVompOWB2w/i8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qNbM0s1dhKiCorN+D29+uUrq3ac7HaZGMXP7G4Uv8l6VzGA8s0oCKELwwWOZWxngOkzI5Ss1KIjPQxHghIQ9ZyKgf28bSpjAIFSTn1H0JqR5plO8ipIEYjjN/KwnllD6v6M66HMsI2le6s6+gh1ScoRZXd2AygPvtv4wPnF7UQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iwv8NWtT; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707786362; x=1739322362;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c4dzWXtMlY2dRiUBcDkwmMn0qPlOU6UVompOWB2w/i8=;
  b=Iwv8NWtTppQ7k2d2aUMYnp/jSPxMjIdDX8z/Y+extdmBkszjyKgjK6Ya
   6IKW84we3E2g9bNlfz3bgutef2wKjq5xFDn8wsSBeLy8SjS0wLbSyeP95
   kHPez2JyaGDJRcWpRoZ6dcPW7aezV+4i/RHDfs5N5y3Vblr7z5LxqhRIe
   AST0/FBnRuiJF9fGIXrGevpf5/xyxxnJQKeNnl2ljJfRsdiYqXIF5qpz5
   UPL9nTMZyRr9lRG6icOnA8dkKO79oHU2MTFgy/Pyzl1Sac1wlTPR7fCeO
   lnzM6NWyN0uq35CATaFqml6ZV2OUx/nJCSNzl2POcXgZRi6Ng+mpFcHVq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="436927644"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="436927644"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 17:05:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="911651329"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="911651329"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga002.fm.intel.com with ESMTP; 12 Feb 2024 17:05:42 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates 2024-02-12 (i40e)
Date: Mon, 12 Feb 2024 17:05:35 -0800
Message-ID: <20240213010540.1085039-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to i40e driver only.

Ivan Vecera corrects the looping value used while waiting for queues to
be disabled as well as an incorrect mask being used for DCB
configuration.

Maciej resolves an issue related to XDP traffic; removing a double call to
i40e_pf_rxq_wait() and accounting for XDP rings when stopping rings.

The following are changes since commit 5b3fbd61b9d1f4ed2db95aaf03f9adae0373784d:
  net: sysfs: Fix /sys/class/net/<iface> path for statistics
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE

Ivan Vecera (2):
  i40e: Fix waiting for queues of all VSIs to be disabled
  i40e: Fix wrong mask used during DCB config

Maciej Fijalkowski (2):
  i40e: avoid double calling i40e_pf_rxq_wait()
  i40e: take into account XDP Tx queues when stopping rings

 drivers/net/ethernet/intel/i40e/i40e_dcb.c  |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c | 24 +++++++++------------
 2 files changed, 11 insertions(+), 15 deletions(-)

-- 
2.41.0


