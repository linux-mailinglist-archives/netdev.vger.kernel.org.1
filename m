Return-Path: <netdev+bounces-18025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BD17543A3
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 22:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F32D2822A1
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 20:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3610720FBA;
	Fri, 14 Jul 2023 20:16:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B83820F96
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 20:16:51 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7789A3AAC
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 13:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689365795; x=1720901795;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jlgefoL6ODmNWpLjs+B/gMONuJ7SxmvJTZr2NI8n6NY=;
  b=CGhHrPWGnSZ1XVjo52QiKRsh6gzOhqsEAbAA3jab7kfipnLe/vD+I2NR
   TlhWVOdwF/eRiB9P3AhgOTVvCgd98+G5NWqn94ZFMFzT0qGFtTrLAy7Qs
   umxqYIzEhXs6Dp6/psQVwfkZ3hnPkkNPJkn/BNGM/2FQ2W9kMPcbmGpve
   xY/XGoAEzmew4ZtjWRBoiZMB4KUyd3e7MkACmtBDWnzqFXdirEOVDEm73
   MSgKe0mK9Hxg9zmpObwrEo8KncnK/cMrHcze7DjhoeevDXCgfUbUsc4Ni
   FaxYUFIpyGpPE4em3x+EX2baZbGhSaO19Fn5Bv2UGEtjt9Kgdk1kuTlxs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="431744606"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="431744606"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 13:16:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="752168795"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="752168795"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga008.jf.intel.com with ESMTP; 14 Jul 2023 13:16:23 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/2][pull request] Intel Wired LAN Driver Updates 2023-07-14 (ice)
Date: Fri, 14 Jul 2023 13:10:39 -0700
Message-Id: <20230714201041.1717834-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series contains updates to ice driver only.

Petr Oros removes multiple calls made to unregister netdev and
devlink_port.

Michal fixes null pointer dereference that can occur during reload.

The following are changes since commit 9840036786d90cea11a90d1f30b6dc003b34ee67:
  gso: fix dodgy bit handling for GSO_UDP_L4
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Michal Swiatkowski (1):
  ice: prevent NULL pointer deref during reload

Petr Oros (1):
  ice: Unregister netdev and devlink_port only once

 drivers/net/ethernet/intel/ice/ice_base.c    |  2 ++
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 13 ++++++++--
 drivers/net/ethernet/intel/ice/ice_lib.c     | 27 --------------------
 drivers/net/ethernet/intel/ice/ice_main.c    | 10 ++++++--
 4 files changed, 21 insertions(+), 31 deletions(-)

-- 
2.38.1


