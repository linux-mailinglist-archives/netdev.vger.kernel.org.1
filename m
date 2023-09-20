Return-Path: <netdev+bounces-35304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEFD7A8B32
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 20:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13DFC281802
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 18:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303DC450C0;
	Wed, 20 Sep 2023 18:09:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29A01A583
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 18:09:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8C4C6;
	Wed, 20 Sep 2023 11:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695233349; x=1726769349;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=elYWzz2UFhp1lnM2zveFDnfbZqlMLy9beu05ox7gCOA=;
  b=aBitdiOrA3sdkuMhfCEcWQKkBfYwewl9W/l3GwG5A3yGTj62uI9ZcLoI
   QWGC4fadwTscPHz4rpAIpkpWlGoVXH2MsE+t6bkaIhYyUl6L1AdcCKpvd
   TxUUWpXs6QK3vUHiktOvMKHSgA0RSvXLLEIJQtb3Qpceb6wCGe2p3jV6b
   eFzmvH/myKEyXCIWJ1B1b/KszNW71HVTtU6eEzvrfM5/Jf+QmYlv2M3ee
   ZLwJysu+NpgPMszZ5buYwqZYP1zDTDfWFQWGRqGn0C4D+7OVebGVEZP1q
   hKLiF+kJewspxmiZogSnYiBgDHyjtum5NOUlID7NYpGhliBIbJagUwgWe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359685140"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="359685140"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:09:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="870469679"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="870469679"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orsmga004.jf.intel.com with ESMTP; 20 Sep 2023 11:09:06 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Michal Michalik <michal.michalik@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/3] net/intel: fix link-time undefined reference errors
Date: Wed, 20 Sep 2023 20:07:42 +0200
Message-ID: <20230920180745.1607563-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Recently, several link-time issues were spotted in the ethernet/intel/
folder thanks to Kbuild bots and linux-next.
The fixes are pretty straightforward, just some stubs and CONFIG_*
guards, so resolve all of them in one shot and unbreak randconfig
builds.

Alexander Lobakin (3):
  ice: fix undefined references to ice_is_*() when
    !CONFIG_PTP_1588_CLOCK
  ice: fix undefined references from DPLL code when
    !CONFIG_PTP_1588_CLOCK
  idpf: fix undefined reference to tcp_gro_complete() when !CONFIG_INET

 drivers/net/ethernet/intel/ice/Makefile     |  5 ++---
 drivers/net/ethernet/intel/ice/ice_main.c   |  8 ++++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 25 ++++++++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c |  3 +++
 4 files changed, 34 insertions(+), 7 deletions(-)

---
Directly to netdev/net-next, build bots are not happy and the next
linux-next is approaching :s
-- 
2.41.0


