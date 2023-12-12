Return-Path: <netdev+bounces-56586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9B080F7FA
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 21:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3B21F21483
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 20:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3671C64129;
	Tue, 12 Dec 2023 20:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UhlaIkVB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9395399
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 12:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702413380; x=1733949380;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=p9KX2KQINv54USVNcdXC034dTIyNVuC3Jjm+ipqDpEY=;
  b=UhlaIkVBmfOgq1PcPOEtiMjoAWCbTYrULwuRgFrZqtRFJF2wVgTtdACj
   WFjvEKafwZzoCvwwzGuYU1CB1K+EFzr0nu+PbmFJ6i2wDvIH0XYwBYNpx
   eC7kKFGzJ4KhXdL2zDKd6qjdtEIhVWgF4Fw5cIkZ+RuVhoAtdYQRV9rRz
   1Yc4rFi46oGbsoW9sY4TTgwA1qvVFD5B2ObItEYWRV+ZC5zkRdDJjtAx6
   /x43Jk4WHN+siRl76CiUSzDafW1RVMsXwsNZ8jLZ32tcG27S5D7DK4gZt
   y3GWQcEAo0z7FMFKhvP2FBU4qLyrMPGU6GCty7jXp6nybwz6w1P1EijmQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="16418336"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="16418336"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 12:36:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="839577696"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="839577696"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga008.fm.intel.com with ESMTP; 12 Dec 2023 12:36:18 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates 2023-12-12 (iavf)
Date: Tue, 12 Dec 2023 12:36:06 -0800
Message-ID: <20231212203613.513423-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to iavf driver only.

Piotr reworks Flow Director states to deal with issues in restoring
filters.

Slawomir fixes shutdown processing as it was missing needed calls.

The following are changes since commit 810c38a369a0a0ce625b5c12169abce1dd9ccd53:
  net/rose: Fix Use-After-Free in rose_ioctl
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE

Piotr Gardocki (2):
  iavf: Introduce new state machines for flow director
  iavf: Handle ntuple on/off based on new state machines for flow
    director

Slawomir Laba (1):
  iavf: Fix iavf_shutdown to call iavf_remove instead iavf_close

 drivers/net/ethernet/intel/iavf/iavf.h        |   1 +
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |  27 ++-
 drivers/net/ethernet/intel/iavf/iavf_fdir.h   |  15 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 179 ++++++++++++------
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  71 ++++++-
 5 files changed, 219 insertions(+), 74 deletions(-)

-- 
2.41.0


