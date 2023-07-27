Return-Path: <netdev+bounces-22058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A14765CD7
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 22:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5064C28227E
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 20:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5313E1C9E8;
	Thu, 27 Jul 2023 20:04:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CEF1C9E1
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 20:04:28 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19AFB5
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 13:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690488266; x=1722024266;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qaywXe8iR5IUTsieUFGbfyAWzxrFsbNUo4aYt+nMx4w=;
  b=Cv+KFK0IiFsmo7uqehq9QI6FqjlIz2MCDEm5tFf5VWj5+CjacrLzBvzr
   zaBFs/7cxf36ij09RMsMLJRcqIv6sIXDpoojQAqGcdmHAC3ihIGPlxpsQ
   6Cs/Bu1RglH4d7+HM91JxZFUt1+KYZGhxUhukZ+96wXr9A6ISgbZlYX4n
   Q1Hnhva5odsbX1gORKX6gAauc6DRjc6Jr4HiZOkyat/+uyumDsNhuMkCu
   XOy77mJIZSyz1tk6LW+3SLy7JoTkJ/K7+9DO5fiEt7KMSJFCjsrsaQWZM
   xiFso8F4GLAjA8Nz7pRq9ckJzuX5RJOfMBm37C4RSpryu15YoU1yWAhnp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="348030234"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="348030234"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 13:04:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="756825957"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="756825957"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga008.jf.intel.com with ESMTP; 27 Jul 2023 13:04:10 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	david.m.ertman@intel.com,
	daniel.machon@microchip.com,
	simon.horman@corigine.com
Subject: [PATCH net-next v2 00/10][pull request] ice: Implement support for SRIOV + LAG
Date: Thu, 27 Jul 2023 12:57:50 -0700
Message-Id: <20230727195800.204461-1-anthony.l.nguyen@intel.com>
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
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dave Ertman says:

Implement support for SRIOV VF's on interfaces that are in an
aggregate interface.

The first interface added into the aggregate will be flagged as
the primary interface, and this primary interface will be
responsible for managing the VF's resources.  VF's created on the
primary are the only VFs that will be supported on the aggregate.
Only Active-Backup mode will be supported and only aggregates whose
primary interface is in switchdev mode will be supported.

The ice-lag DDP must be loaded to support this feature.

Additional restrictions on what interfaces can be added to the aggregate
and still support SRIOV VFs are:
- interfaces have to all be on the same physical NIC
- all interfaces have to have the same QoS settings
- interfaces have to have the FW LLDP agent disabled
- only the primary interface is to be put into switchdev mode
- no more than two interfaces in the aggregate
---
v2:
- Move NULL check for q_ctx in ice_lag_qbuf_recfg() earlier (patch 6)

v1: https://lore.kernel.org/netdev/20230726182141.3797928-1-anthony.l.nguyen@intel.com/

The following are changes since commit 9d0cd5d25f7d45bce01bbb3193b54ac24b3a60f3:
  Merge branch 'virtio-vsock-some-updates-for-msg_peek-flag'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Dave Ertman (9):
  ice: Add driver support for firmware changes for LAG
  ice: changes to the interface with the HW and FW for SRIOV_VF+LAG
  ice: implement lag netdev event handler
  ice: process events created by lag netdev event handler
  ice: Flesh out implementation of support for SRIOV on bonded interface
  ice: support non-standard teardown of bond interface
  ice: enforce interface eligibility and add messaging for SRIOV LAG
  ice: enforce no DCB config changing when in bond
  ice: update reset path for SRIOV LAG support

Jacob Keller (1):
  ice: Correctly initialize queue context values

 drivers/net/ethernet/intel/ice/ice.h          |    5 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   53 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |   56 +
 drivers/net/ethernet/intel/ice/ice_common.h   |    4 +
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c   |   50 +
 drivers/net/ethernet/intel/ice/ice_lag.c      | 1951 +++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_lag.h      |   34 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |    2 +-
 drivers/net/ethernet/intel/ice/ice_lib.h      |    1 +
 drivers/net/ethernet/intel/ice/ice_main.c     |   36 +-
 drivers/net/ethernet/intel/ice/ice_sched.c    |   37 +-
 drivers/net/ethernet/intel/ice/ice_sched.h    |   21 +
 drivers/net/ethernet/intel/ice/ice_switch.c   |   88 +-
 drivers/net/ethernet/intel/ice/ice_switch.h   |   29 +
 drivers/net/ethernet/intel/ice/ice_type.h     |    2 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |    2 +
 16 files changed, 2182 insertions(+), 189 deletions(-)

-- 
2.38.1


