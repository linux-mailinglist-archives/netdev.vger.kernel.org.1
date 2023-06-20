Return-Path: <netdev+bounces-12356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBC3737331
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 19:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903AD1C20CC7
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 17:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EF914278;
	Tue, 20 Jun 2023 17:49:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDD42AB5B
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 17:49:37 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182F310F9
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 10:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687283376; x=1718819376;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2succr18dl806iuzWf4XaWi3VsZCcnOh45xJwwDWrGg=;
  b=a3CZgYqA5CLiZyeALOkAplWxOaI8MTnMNF0KNpPAEkUx1itd4AXSfuSI
   WhdF1pxeaYS231aZubXdB8jK0k2+qQFkLp21K7/RyApl5LyWsVXhRRk0q
   /NjAOu9/vgX3GfMJhzd1Y7/hpFVb0hS+MQy0HCfxLuD/hIs1KI+E/yHpT
   qP7beMEwqkocZ43Qb+xKKJOaUAhSGu/0MYiijrJg1fDiIgK8LGv+0/K1s
   g478YpbeyCo++ClvGwlWU5FbUwPFy00bPqKM06B39zWxWJpM74U5GWaT9
   m2CvG/JrajiUySFLz8SPAFw/hHPWcaHXjo39/zDLKBfOgWhqEj6MiiGGS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="339554243"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="339554243"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 10:49:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="838300564"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="838300564"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 20 Jun 2023 10:49:35 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	wojciech.drewek@intel.com,
	jiri@resnulli.us,
	ivecera@redhat.com,
	simon.horman@corigine.com
Subject: [PATCH net-next 00/12][pull request] ice: switchdev bridge offload
Date: Tue, 20 Jun 2023 10:44:11 -0700
Message-Id: <20230620174423.4144938-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wojciech Drewek says:

Linux bridge provides ability to learn MAC addresses and vlans
detected on bridge's ports. As a result of this, FDB (forward data base)
entries are created and they can be offloaded to the HW. By adding
VF's port representors to the bridge together with the uplink netdev,
we can learn VF's and link partner's MAC addresses. This is achieved
by slow/exception-path, where packets that do not match any filters
(FDB entries in this case) are send to the bridge ports.

Driver keeps track of the netdevs added to the bridge
by listening for NETDEV_CHANGEUPPER event. We distinguish two types
of bridge ports: uplink port and VF's representor port. Linux
bridge always learns src MAC of the packet on rx path. With the
current slow-path implementation, it means that we will learn
VF's MAC on port repr (when the VF transmits the packet) and
link partner's MAC on uplink (when we receive it on uplink from LAN).

The driver is notified about learning of the MAC/VLAN by
SWITCHDEV_FDB_{ADD|DEL}_TO_DEVICE events. This is followed by creation
of the HW filter. The direction of the filter is based on port
type (uplink or VF repr). In case of the uplink, rule forwards
the packets to the LAN (matching on link partner's MAC). When the
notification is received on VF repr then the rule forwards the
packets to the associated VF (matching on VF's MAC).

This approach would not work on its own however. This is because if
one of the directions is offloaded, then the bridge would not be able
to learn the other one. If the egress rule is added (learned on uplink)
then the response from the VF will be sent directly to the LAN.
The packet will not got through slow-path, it would not be seen on
VF's port repr. Because of that, the bridge would not learn VF's MAC.

This is solved by introducing guard rule. It prevents forward rule from
working until the opposite direction is offloaded.

Aging is not fully supported yet, aging time is static for now. The
follow up submissions will introduce counters that will allow us to
keep track if the rule is actually being used or not.

A few fixes/changes are needed for this feature to work with ice driver.
These are introduced in first 5 patches.

The following are changes since commit 712557f210723101717570844c95ac0913af74d7:
  Merge branch 'ptp-adjphase-cleanups'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Marcin Szycik (2):
  ice: Add guard rule when creating FDB in switchdev
  ice: Add VLAN FDB support in switchdev mode

Michal Swiatkowski (2):
  ice: implement bridge port vlan
  ice: implement static version of aging

Pawel Chmielewski (1):
  ice: add tracepoints for the switchdev bridge

Wojciech Drewek (7):
  ice: Skip adv rules removal upon switchdev release
  ice: Prohibit rx mode change in switchdev mode
  ice: Don't tx before switchdev is fully configured
  ice: Disable vlan pruning for uplink VSI
  ice: Unset src prune on uplink VSI
  ice: Implement basic eswitch bridge setup
  ice: Switchdev FDB events support

 drivers/net/ethernet/intel/ice/Makefile       |    2 +-
 drivers/net/ethernet/intel/ice/ice.h          |    5 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c  |   46 +-
 .../net/ethernet/intel/ice/ice_eswitch_br.c   | 1302 +++++++++++++++++
 .../net/ethernet/intel/ice/ice_eswitch_br.h   |  121 ++
 drivers/net/ethernet/intel/ice/ice_lib.c      |   25 +
 drivers/net/ethernet/intel/ice/ice_lib.h      |    1 +
 drivers/net/ethernet/intel/ice/ice_main.c     |    4 +-
 drivers/net/ethernet/intel/ice/ice_repr.c     |    2 +-
 drivers/net/ethernet/intel/ice/ice_repr.h     |    3 +-
 drivers/net/ethernet/intel/ice/ice_switch.c   |  150 +-
 drivers/net/ethernet/intel/ice/ice_switch.h   |    6 +-
 drivers/net/ethernet/intel/ice/ice_trace.h    |   90 ++
 drivers/net/ethernet/intel/ice/ice_type.h     |    1 +
 .../ethernet/intel/ice/ice_vf_vsi_vlan_ops.c  |  186 +--
 .../ethernet/intel/ice/ice_vf_vsi_vlan_ops.h  |    4 +
 .../net/ethernet/intel/ice/ice_vsi_vlan_lib.c |   84 +-
 .../net/ethernet/intel/ice/ice_vsi_vlan_lib.h |    8 +
 .../net/ethernet/intel/ice/ice_vsi_vlan_ops.h |    1 +
 19 files changed, 1855 insertions(+), 186 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_eswitch_br.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_eswitch_br.h

-- 
2.38.1


