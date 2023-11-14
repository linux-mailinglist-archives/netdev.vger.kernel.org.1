Return-Path: <netdev+bounces-47781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AD67EB62F
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 19:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3CCCB20B89
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 18:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFB3D2E8;
	Tue, 14 Nov 2023 18:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="geh8yHwE"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AA63399A
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 18:15:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B943120
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 10:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699985719; x=1731521719;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DeAx5bfonjNXKwktw5JjgFDViZVsfpLZttW63kmAMpQ=;
  b=geh8yHwEFbX5ujp+EpSOlBzf46LyZ2qXVx41MMi43T038QUfhNxXjNvQ
   m3iN+1mpLGZwalYeT49fTarL3OUu07I2CB81oKiF48/KOALxpBrLY3TEs
   kiOYWphi3fEPjHanXh2wCqw0URs3ZXG3mJelwE81CBZOkcB80xzYuj2XM
   1wy+FyxD10/5tWGO9+0iUzKiiXfRWp7KmJMeT3WlQ/VBcNzErzO6RBNjL
   eNuKMGNAmr/ATeDUen+5FRZugmIAHpU8HJbSlaE324FCbhjeRsbaSxrf0
   f8CyoMxT5Y1THOh2TYiqrEjwNwx/xpKQ2yIzVuWDehK4+/3KDo970/Q9i
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390514435"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="390514435"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 10:15:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="741160921"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="741160921"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga006.jf.intel.com with ESMTP; 14 Nov 2023 10:15:01 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	michal.swiatkowski@linux.intel.com,
	wojciech.drewek@intel.com,
	marcin.szycik@intel.com,
	piotr.raczynski@intel.com
Subject: [PATCH net-next 00/15][pull request] ice: one by one port representors creation
Date: Tue, 14 Nov 2023 10:14:20 -0800
Message-ID: <20231114181449.1290117-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Michal Swiatkowski says:

Currently ice supports creating port representors only for VFs. For that
use case they can be created and removed in one step.

This patchset is refactoring current flow to support port representor
creation also for subfunctions and SIOV. In this case port representors
need to be created and removed one by one. Also, they can be added and
removed while other port representors are running.

To achieve that we need to change the switchdev configuration flow.
Three first patches are only cosmetic (renaming, removing not used code).
Next few ones are preparation for new flow. The most important one
is "add VF representor one by one". It fully implements new flow.

New type of port representor (for subfunction) will be introduced in
follow up patchset.

The following are changes since commit 89cdf9d556016a54ff6ddd62324aa5ec790c05cc:
  Merge tag 'net-6.7-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Michal Swiatkowski (15):
  ice: rename switchdev to eswitch
  ice: remove redundant max_vsi_num variable
  ice: remove unused control VSI parameter
  ice: track q_id in representor
  ice: use repr instead of vf->repr
  ice: track port representors in xarray
  ice: remove VF pointer reference in eswitch code
  ice: make representor code generic
  ice: return pointer to representor
  ice: allow changing SWITCHDEV_CTRL VSI queues
  ice: set Tx topology every time new repr is added
  ice: realloc VSI stats arrays
  ice: add VF representors one by one
  ice: adjust switchdev rebuild path
  ice: reserve number of CP queues

 drivers/net/ethernet/intel/ice/ice.h          |  13 +-
 drivers/net/ethernet/intel/ice/ice_devlink.c  |  29 +
 drivers/net/ethernet/intel/ice/ice_devlink.h  |   1 +
 drivers/net/ethernet/intel/ice/ice_eswitch.c  | 562 ++++++++++--------
 drivers/net/ethernet/intel/ice/ice_eswitch.h  |  22 +-
 .../net/ethernet/intel/ice/ice_eswitch_br.c   |  22 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  81 ++-
 drivers/net/ethernet/intel/ice/ice_main.c     |   6 +-
 drivers/net/ethernet/intel/ice/ice_repr.c     | 195 +++---
 drivers/net/ethernet/intel/ice/ice_repr.h     |   9 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c    |  20 +-
 drivers/net/ethernet/intel/ice/ice_tc_lib.c   |   4 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   9 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   2 +-
 14 files changed, 553 insertions(+), 422 deletions(-)

-- 
2.41.0


