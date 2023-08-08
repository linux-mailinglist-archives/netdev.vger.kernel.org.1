Return-Path: <netdev+bounces-25584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D38774D70
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 23:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352C4281815
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 21:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27642174FA;
	Tue,  8 Aug 2023 21:57:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDD215AF3
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 21:57:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384BA12D
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 14:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691531830; x=1723067830;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jSmjDBFvz599KO5wK2z0HqeeKcIlqZcHOwNCsIbC4D0=;
  b=QkGaTwSqcwEnl7P9tHkMKkohiHHfXyh0YasLPNELXsXZAv6q7U9p7ufK
   oanpVyM9n5nUwBPjH5ndqVxKGdzbkBzvcUhFW1yOX+OQVvX/2sUZI6fU9
   RRhy8W/2sV8hQnPJDSOfsI8zkBUrCa1QBD0mUBnXo/QTOQk07svkZ+4uj
   z518IE7vamtCeMWp7VrFZJeYB3k7LzPHDnLTSWaS+OOL7uHQkXi02toYp
   s+mQMRpx72Xf+8jHfYOaO4PyCEorIngqkF2xwNflL4ne68HIPsD1PA2Fg
   PMSrs59tJyI91d7nJ3+WtUnLn4GKRpRa0U798TWUWYln8VH8F+NxwIyr6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="368420278"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="368420278"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 14:57:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="821569632"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="821569632"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Aug 2023 14:57:07 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id B0B7B33744;
	Tue,  8 Aug 2023 22:57:06 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Simon Horman <horms@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v4 0/3] ice: split ice_aq_wait_for_event() func into two
Date: Tue,  8 Aug 2023 17:54:14 -0400
Message-Id: <20230808215417.117910-1-przemyslaw.kitszel@intel.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mitigate race between registering on wait list and receiving
AQ Response from FW.

The first patch fixes bound check to be more inclusive;
the second one refactors code to make the third one smaller,
which is an actual fix for the race.

Thanks Simon Horman for pushing into split, it's easier to follow now.

v4: remove excessive newlines, thanks Tony for catching this up
v3: split into 3 commits

Przemek Kitszel (3):
  ice: ice_aq_check_events: fix off-by-one check when filling buffer
  ice: embed &ice_rq_event_info event into struct ice_aq_task
  ice: split ice_aq_wait_for_event() func into two

 drivers/net/ethernet/intel/ice/ice.h          | 21 +++-
 .../net/ethernet/intel/ice/ice_fw_update.c    | 45 +++++----
 drivers/net/ethernet/intel/ice/ice_main.c     | 99 ++++++++++---------
 3 files changed, 93 insertions(+), 72 deletions(-)


base-commit: b91d6ff19e94ec46cf6473e7d50ec11615e9ede6
-- 
2.40.1


