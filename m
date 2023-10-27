Return-Path: <netdev+bounces-44815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F36F7D9F32
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 20:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F7471C21107
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 18:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D86A3B7A0;
	Fri, 27 Oct 2023 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S2qXDfZx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEB73B2BE
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 17:59:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14CD129
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 10:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698429592; x=1729965592;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WO1aoR1DQuqxO6ycRYvSyvbdIrQ3353kEWxOQwEYrWE=;
  b=S2qXDfZxKNdOU4CfqrXrr2kdbybs9o21LCZT3idAzzzDHZ6yQbh3ewut
   3WW9PmfSqgRDqpHX2pJ78q6gL4pdx+IOosTPEroXrAYoSoANvKBFmBF8E
   L/PPTZ//hgM/LirgUd07ttfdv2Acu6p+Lgck7gp5vFty8S/LDwN2jy47p
   pRe/XgAjNdZ3if/e2V+o8nWj28L8PVr1j08aEx6f1CnUYwaVc991Zj0w/
   28lQTQ1UEZ5HZBo2vbh7yc0De1Dz+Qe8o410J6L7MKFxAKN1+BpE7dUBI
   9C/1/nzmzCEU4srhdrB4AfYrIoX7Lz79aUMDVhbHSOItzfJieTJN4mrOJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="391695504"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="391695504"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 10:59:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="830064614"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="830064614"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 10:59:47 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next v2 0/8] Intel Wired LAN Driver Updates for 2023-10-23 (iavf)
Date: Fri, 27 Oct 2023 10:59:33 -0700
Message-ID: <20231027175941.1340255-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series includes iAVF driver cleanups from Michal Schmidt.

Michal removes and updates stale comments, fixes some locking anti-patterns,
improves handling of resets when the PF is slow, avoids unnecessary
duplication of netdev state, refactors away some duplicate code, and finally
removes the never-actually-used client interface.

Changes since v1:
* Dropped patch ("iavf: in iavf_down, disable queues when removing the
  driver") which was applied directly to net.
* Fixed a merge conflict due to 7db311104388 ("iavf: initialize waitqueues
  before starting watchdog_task").

V1 was originally posted at:
https://lore.kernel.org/netdev/20231027104109.4f536f51@kernel.org/T/#mfadbdb39313eeccc616fdee80a4fdd6bda7e2822

Michal Schmidt (8):
  iavf: fix comments about old bit locks
  iavf: simplify mutex_trylock+sleep loops
  iavf: in iavf_down, don't queue watchdog_task if comms failed
  iavf: fix the waiting time for initial reset
  iavf: rely on netdev's own registered state
  iavf: use unregister_netdev
  iavf: add a common function for undoing the interrupt scheme
  iavf: delete the iavf client interface

 drivers/net/ethernet/intel/iavf/Makefile      |   2 +-
 drivers/net/ethernet/intel/iavf/iavf.h        |  28 -
 drivers/net/ethernet/intel/iavf/iavf_client.c | 578 ------------------
 drivers/net/ethernet/intel/iavf/iavf_client.h | 169 -----
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 137 +----
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  14 -
 6 files changed, 28 insertions(+), 900 deletions(-)
 delete mode 100644 drivers/net/ethernet/intel/iavf/iavf_client.c
 delete mode 100644 drivers/net/ethernet/intel/iavf/iavf_client.h


base-commit: 3a04927f8d4b7a4f008f04af41e31173002eb1ea
-- 
2.41.0


