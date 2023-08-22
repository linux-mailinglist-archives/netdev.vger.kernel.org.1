Return-Path: <netdev+bounces-29615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1EC7840F5
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 14:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642AE281076
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 12:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C3319BC1;
	Tue, 22 Aug 2023 12:41:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632327F
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 12:41:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27901BD
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 05:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692708057; x=1724244057;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yIUii6ab9AA+U3EikxNmFYGZ16eFCjLg9BahbV1nVjE=;
  b=KOTBbI2zSOT8voZAV9320zXcTK1/D7UAbqusW4ojPV0ZK/XnYZ+ph57j
   AJuBE3Lfs2SV42IHp9ImqurHDKmRlzRhunOAFjutCVcKSzLUbCnW0kuCE
   0G7vHS4Me+HOrQhuUTiW4VbanGRjp+4TybXeBaYhMhWgY9lXNeY9/bw2N
   5l6IM+03yh2+v4szxLgW1qTrv3IyRY0ykRFXYUadsxBCFqn+P46b8MBRE
   xd1iw3FSW+yXXPcQrUZkHMOheTTp0xsfcW7UH7oq/q1hYlj42Od01GBsd
   O6oWSsHDhKbz2enQii1Z4aincSq+I65C6aabA4nPLlYVDsu9nPZzrFx/S
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="376604589"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="376604589"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 05:40:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="771342886"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="771342886"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orsmga001.jf.intel.com with ESMTP; 22 Aug 2023 05:40:55 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v3 iwl-next 0/9] ice: fix timestamping in reset process
Date: Tue, 22 Aug 2023 14:40:35 +0200
Message-Id: <20230822124044.301654-1-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PTP reset process has multiple places where timestamping can end up in
an incorrect state.

This series introduces a proper state machine for PTP and refactors
a large part of the code to ensure that timestamping does not break.

Jacob Keller (8):
  ice: use ice_pf_src_tmr_owned where available
  ice: pass reset type to PTP reset functions
  ice: rename PTP functions and fields
  ice: factor out ice_ptp_rebuild_owner()
  ice: remove ptp_tx ring parameter flag
  ice: modify tstamp_config only during TS mode set
  ice: restore timestamp configuration after reset
  ice: stop destroying and reinitalizing Tx tracker during reset

Karol Kolacinski (1):
  ice: introduce PTP state machine

---
V2 -> V3: Adjusted commit authors and added base commit
V1 -> V2: Adjusted commit S-o-bs and messages

 drivers/net/ethernet/intel/ice/ice.h         |   1 -
 drivers/net/ethernet/intel/ice/ice_ethtool.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c    |  16 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 331 ++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_ptp.h     |  36 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c    |   3 -
 drivers/net/ethernet/intel/ice/ice_txrx.h    |   1 -
 7 files changed, 247 insertions(+), 143 deletions(-)


base-commit: c924ca3252117385328b3aa1b2b507b5c93c4c47
-- 
2.39.2


