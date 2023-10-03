Return-Path: <netdev+bounces-37765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0648E7B7102
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 20:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 86D8D1F2118F
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 18:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E94B3B2B7;
	Tue,  3 Oct 2023 18:36:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1351B3AC1E
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 18:36:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86C2AB
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 11:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696358180; x=1727894180;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fTzKFu75PwflFK5vPw4iJL8YI6768mFc2vcJ3/KflLE=;
  b=jcahKgtCisxnoeJD4aB8gFpaZVh2hSjGBLiR/5+qWRBHnkVeIDfhviQX
   3/fHcPIOlejOn1Oo49Iuj/2VmTNOBU51hSnXKR+wEVzJNezaLE+Iru25e
   OvOltbPD2O+8MNoG7jD+BEduWQ136CyltUlsghAIlPLOsvaC7LbtYwn75
   JQ0wGUbDLvCB5jixSu/CXmTRJA4T/czf2sDLyobaiPjohhchBWZzcTL8a
   6Y2Es6pshfOJ75cNniCJKra5nloahQKmcSMm1XjhaDOzZq0cq55KNxJb/
   fEGTyriOqcW5TY7xEAttOr/AfsrIPXIJbFFzDuJg9eirr8fOTVdcyJ8/4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="4516710"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="4516710"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 11:36:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="874786501"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="874786501"
Received: from jbrandeb-spr1.jf.intel.com ([10.166.28.233])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 11:36:18 -0700
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	netdev@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v1 0/2] intel: format specifier cleanups
Date: Tue,  3 Oct 2023 11:36:01 -0700
Message-Id: <20231003183603.3887546-1-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Clean up some warnings from the W=1 build which moves the intel
directory back to "clean" state. This mostly involved converting to
using ethtool_sprintf where appropriate and kasprintf in other places.

The second patch goes the extra mile and cleans up -Wformat=2 warnings
as suggested by Alex Lobakin, since those flags will likely be turned on
as well.

gcc-12 runs clean after these changes, and clang-15 still has some minor
complaints as mentioned in patch-2.

Jesse Brandeburg (2):
  intel: fix string truncation warnings
  intel: fix format warnings

 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  6 ++-
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |  8 ++--
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 22 ++++-------
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  7 ++--
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  4 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c  |  4 +-
 drivers/net/ethernet/intel/igb/igb_main.c     | 37 +++++++++----------
 drivers/net/ethernet/intel/igc/igc_ethtool.c  |  5 ++-
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  4 +-
 9 files changed, 46 insertions(+), 51 deletions(-)


base-commit: e643597346c72ebb961ee79ebec34acc042e8ac2
-- 
2.39.3


