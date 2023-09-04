Return-Path: <netdev+bounces-31925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDC5791726
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 14:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F72280ED8
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 12:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065391FD6;
	Mon,  4 Sep 2023 12:34:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2241844
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 12:34:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE441AD;
	Mon,  4 Sep 2023 05:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693830858; x=1725366858;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iKfzgQRKi4T83ZPeBZBBiIz3Sz7wRs1LrWoQjTTTZqo=;
  b=JqLZPtw31kI0Al7lmcMM++5EcMDrTHM3H//rbLrkhve1n/CpailILYVq
   Cy8VC947xG6B5d8iauT/81BBN17S+BKeKRnXmEjCN5ViJ/E0F0DPlJKDl
   uyir+tw6bY8khjGCqkTJVZ2Qafsv6itWZYdTw7iYJ15/frk6VjcDP84WT
   KsPuwKkFoN+5FNLjCa2wqdg5cYf3IsVGkZDvbODl0pSKVB3f3G1U5rhz/
   X82IT79GUmHb6iMdSTebIs4IpdFApBrm+RIJ/Iud6Bl3lM3fKuOOFWl92
   1ufvOJZ+17zPJO8NOP0vDZryK34ikWako/wIs4wWLjPqrztFy7ZdecF/J
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="373977128"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="373977128"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 05:34:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="740749728"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="740749728"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga002.jf.intel.com with ESMTP; 04 Sep 2023 05:34:15 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 0964133BF2;
	Mon,  4 Sep 2023 13:34:13 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-hardening@vger.kernel.org,
	Steven Zou <steven.zou@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Anthony Nguyen <anthony.l.nguyen@intel.com>,
	David Laight <David.Laight@ACULAB.COM>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [RFC net-next v4 0/7] introduce DEFINE_FLEX() macro
Date: Mon,  4 Sep 2023 08:31:00 -0400
Message-Id: <20230904123107.116381-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add DEFINE_FLEX() macro, that helps on-stack allocation of structures
with trailing flex array member.
Expose __struct_size() macro which reads size of data allocated
by DEFINE_FLEX().

Accompany new macros introduction with actual usage,
in the ice driver - hence targeting for netdev tree
- please me know if it is best approach here?

Obvious benefits include simpler resulting code, less heap usage,
less error checking. Less obvious is the fact that compiler has
more room to optimize, and as a whole, even with more stuff on the stack,
we end up with overall better (smaller) report from bloat-o-meter:
add/remove: 8/6 grow/shrink: 7/18 up/down: 2211/-2270 (-59)
(individual results in each patch).

v4: _Static_assert() to ensure compiletime const count param
v3: tidy up 1st patch
v2: Kees: reusing __struct_size() instead of doubling it as a new macro

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
 include/linux/compiler_types.h              | 32 +++++++----
 include/linux/fortify-string.h              |  4 --
 include/linux/overflow.h                    | 35 ++++++++++++
 11 files changed, 130 insertions(+), 218 deletions(-)


base-commit: bd6c11bc43c496cddfc6cf603b5d45365606dbd5
-- 
2.40.1


