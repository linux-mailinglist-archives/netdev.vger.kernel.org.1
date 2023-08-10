Return-Path: <netdev+bounces-26269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CDB7775F1
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 12:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863DD2820DF
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25BF1EA71;
	Thu, 10 Aug 2023 10:38:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958E846BA
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 10:38:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCFE10C3;
	Thu, 10 Aug 2023 03:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691663923; x=1723199923;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n/ok4NrU7F+F8sAu/7N+WQcM11TVUa5cAcBCcZXT/xs=;
  b=iNu2LKZ/ekEBwxR21RehOpPGhHtvMditHsbyko3gTru8imCDT/s9lFvH
   uWBXpelMcEvQz8qqBLHXu5o8zqQeNumCj27cTkqdFuzYNvd1lEJw1ZMM8
   GXDAUj1S1G8dkOhlFVHg0uXNrOKEHovq8xWaIq9hkUGsIKMk2RBa+dUzC
   KWc16VzgACnaJCEp+4D4/+aXANk38WDotI4/vIynfEIx38ed8HuNK+Fe1
   yqBf00KIfLDAaqxBQS0q5P9vctHVjI8SYn8wcuUgCUh0kF+YmX2Vh4/N5
   /pcBUTGZ1tVxgVxlyNM77muypZW1j/IEiHWxLcjkVErjp3xah6i7HYwT5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="370260803"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="370260803"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 03:38:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="767237163"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="767237163"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga001.jf.intel.com with ESMTP; 10 Aug 2023 03:38:40 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id A5DD2332B2;
	Thu, 10 Aug 2023 11:38:39 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Kees Cook <keescook@chromium.org>,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-hardening@vger.kernel.org,
	Steven Zou <steven.zou@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v1 0/7] introduce DEFINE_FLEX() macro
Date: Thu, 10 Aug 2023 06:35:02 -0400
Message-Id: <20230810103509.163225-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.40.1
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

Add DEFINE_FLEX() macro, that helps on-stack allocation of structures
with trailing flex array member.
Add const_flex_size() macro which is a wrapper to get size of data
allocated by DEFINE_FLEX().

Accompany new macros introduction with actual usage,
in the ice driver (hence targeting for netdev tree).

Obvious benefits include simpler resulting code, less heap usage,
less error checking. Less obvious is the fact that compiler has
more room to optimize, and as a whole, even with more stuff on the stack,
we end up with overall better (smaller) report from bloat-o-meter:
add/remove: 8/6 grow/shrink: 7/18 up/down: 2211/-2270 (-59)
(individual results in each patch).

Przemek Kitszel (7):
  overflow: add DEFINE_FLEX() for on-stack allocs
  ice: ice_sched_remove_elems: replace 1 elem array param by u32
  ice: drop two params of ice_aq_move_sched_elems()
  ice: make use of DEFINE_FLEX() in ice_ddp.c
  ice: make use of DEFINE_FLEX() for struct ice_aqc_add_tx_qgrp
  ice: make use of DEFINE_FLEX() for struct ice_aqc_dis_txq_item
  ice: make use of DEFINE_FLEX() in ice_switch.c

 drivers/net/ethernet/intel/ice/ice_common.c | 20 ++-----
 drivers/net/ethernet/intel/ice/ice_ddp.c    | 39 ++++---------
 drivers/net/ethernet/intel/ice/ice_lag.c    | 48 ++++------------
 drivers/net/ethernet/intel/ice/ice_lib.c    | 23 ++------
 drivers/net/ethernet/intel/ice/ice_sched.c  | 56 ++++++------------
 drivers/net/ethernet/intel/ice/ice_sched.h  |  6 +-
 drivers/net/ethernet/intel/ice/ice_switch.c | 63 +++++----------------
 drivers/net/ethernet/intel/ice/ice_xsk.c    | 22 +++----
 include/linux/overflow.h                    | 27 +++++++++
 9 files changed, 101 insertions(+), 203 deletions(-)


base-commit: 052059b663c957aea5a90f206ece4849f88f34bf
-- 
2.40.1


