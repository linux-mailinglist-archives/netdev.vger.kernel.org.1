Return-Path: <netdev+bounces-43668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F037D430A
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 01:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F69DB20C46
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 23:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E2D241F1;
	Mon, 23 Oct 2023 23:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fXJKYyBc"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43AF22EF0
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 23:08:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62969BD
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 16:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698102512; x=1729638512;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gP7Ziiz6mVI0rxTUTcOeycOPuZcJ4CC58CzZ/t8TgMw=;
  b=fXJKYyBcQxQrEW1afiyysxVPffvgAgbPK1Vjk3PABa2J67iLR9k/qG7U
   zfG6y8s4b98JMVNcp2Psbkc2bMpX208Nwu+hqBrBMWwg7cVVU4sjfafBu
   j2ItnsYx4slPlXW9jxwpDno58AYU1K+AGgmSBOfGKzPHJ0wqwTijUpt02
   37FlDAAq0oIEHpmJEQlL2ZxAbUsHmTPq5PIE/TLu+f665oUXY/dn9ssJv
   fIWKWs2cBLzb9zVnbFmI8tq2JPReDES6tPrUImk2jtr+LcptA+xeLjeo4
   RHg5DKmzbJRMyHN0IbqJCDablKEoKUEasVzXr4EKvrTsAORFkSIFI9sih
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="5573690"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="5573690"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 16:08:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="793288313"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="793288313"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 16:08:30 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 0/9]  Intel Wired LAN Driver Updates for 2023-10-23 (iavf)
Date: Mon, 23 Oct 2023 16:08:16 -0700
Message-ID: <20231023230826.531858-1-jacob.e.keller@intel.com>
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

Michal Schmidt (9):
  iavf: fix comments about old bit locks
  iavf: simplify mutex_trylock+sleep loops
  iavf: in iavf_down, don't queue watchdog_task if comms failed
  iavf: in iavf_down, disable queues when removing the driver
  iavf: fix the waiting time for initial reset
  iavf: rely on netdev's own registered state
  iavf: use unregister_netdev
  iavf: add a common function for undoing the interrupt scheme
  iavf: delete the iavf client interface

 drivers/net/ethernet/intel/iavf/Makefile      |   2 +-
 drivers/net/ethernet/intel/iavf/iavf.h        |  28 -
 drivers/net/ethernet/intel/iavf/iavf_client.c | 578 ------------------
 drivers/net/ethernet/intel/iavf/iavf_client.h | 169 -----
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 139 +----
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  14 -
 6 files changed, 29 insertions(+), 901 deletions(-)
 delete mode 100644 drivers/net/ethernet/intel/iavf/iavf_client.c
 delete mode 100644 drivers/net/ethernet/intel/iavf/iavf_client.h


base-commit: d6e48462e88fe7efc78b455ecde5b0ca43ec50b7
-- 
2.41.0


