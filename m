Return-Path: <netdev+bounces-40183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5301D7C6122
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 01:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833F21C20F0C
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 23:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA812B754;
	Wed, 11 Oct 2023 23:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cjXITkLt"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BEA2B741
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 23:33:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563599E
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697067227; x=1728603227;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QcD6xFWXdpaGRvMAQZxKv25EoKLowlxzorJwEIrsiPI=;
  b=cjXITkLtzNdTy6V9jrNNe2PO4bIF4MbLO45SQId92MJJWd1MxblDkvI2
   yeqVfvGWs4jVHYxJXMP3/D8vmwzf79yuKf12j4bgKF6eICXK8jU4HDBC+
   XolDxQaJ2hPvoEyJ1uj48mGN0mDIEQem8P2VPSiZ3Y6H7nWJyPG57WiL2
   TygAyVMyNJWC+kfo6kzmQNo5sNfUcQDnaHvBhTSvT6k7vMaVB7uh+IJxg
   ClAp/uZuZvbZgzUpgMAXHVmiw+wVoHuX1FwUiCpiYXD3Aw2451O/uCyhU
   1f3aVa1GwwTgCuzYx39n/T7ua9XzgnBbOvmGLlDbhUEPzR6Kss9HAH63u
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="388652582"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="388652582"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 16:33:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="824359284"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="824359284"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 16:33:46 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates 2023-10-11 (i40e, ice)
Date: Wed, 11 Oct 2023 16:33:31 -0700
Message-ID: <20231011233334.336092-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series contains fixes for the i40e and ice drivers.

Jesse adds handling to the ice driver which resetis the device when loading
on a crash kernel, preventing stale transactions from causing machine check
exceptions which could prevent capturing crash data.

Mateusz fixes a bug in the ice driver 'Safe mode' logic for handling the
device when the DDP is missing.

Michal fixes a crash when probing the i40e driver in the event that HW
registers are reporting invalid/unexpected values.

The following are changes since commit a950a5921db450c74212327f69950ff03419483a:
  net/smc: Fix pos miscalculation in statistics

I'm covering for Tony Nguyen while he's out, and don't have access to create
a pull request branch on his net-queue, so these are sent via mail only.

Jesse Brandeburg (1):
  ice: reset first in crash dump kernels

Mateusz Pacuszka (1):
  ice: Fix safe mode when DDP is missing

Michal Schmidt (1):
  i40e: prevent crash on probe if hw registers have invalid values

 drivers/net/ethernet/intel/i40e/i40e_common.c |  4 ++--
 drivers/net/ethernet/intel/ice/ice_main.c     | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

-- 
2.41.0


