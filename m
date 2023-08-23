Return-Path: <netdev+bounces-30086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBBD785F45
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 20:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4501F2812F6
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 18:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1390E1F922;
	Wed, 23 Aug 2023 18:10:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070621ED47
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 18:10:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FB1E50
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 11:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692814251; x=1724350251;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F85yF+dwSJT1mBnPsAjv6DMxkAEK5WD17S+AJ4oF0zM=;
  b=RZqXmsQjBGkgz5j2qjYPOoJ6X4FQeVmXTJiL3gCwGLW5xMZy2mmNG66v
   T16jbXQfIdlxJZWmhcOG+vdkmDCjju1UqtT35G1XMFugagnlLFUrMjgPD
   pdJMX87rLBRPsiIlTfptfbcVob3Bnxb6UjKzB9IHmln0itGeKcyGZkZT5
   rGwDP/uNTObuIkJOxVfh0a369ENwZDTGDizOod9HZWbjGvTlm+4Q8rjdN
   KO+OudrI1L5sa9wsUbLLVzK17mN+EIGPUAyjXaOPuIKqZn+nAiQvVdj3J
   6Cl/W6O0Kq6vctHGsB0GvKnl5RANqzHdnD7pf06or2RQsD4DbivB3J48n
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="364412283"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="364412283"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 11:10:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="802233624"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="802233624"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga008.fm.intel.com with ESMTP; 23 Aug 2023 11:10:45 -0700
Received: from baltimore.igk.intel.com (baltimore.igk.intel.com [10.102.21.1])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 7E393333FB;
	Wed, 23 Aug 2023 19:10:44 +0100 (IST)
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: intel-wired-lan@osuosl.org
Cc: netdev@vger.kernel.org,
	andrew@lunn.ch,
	aelior@marvell.com,
	manishc@marvell.com,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH iwl-next v3 0/8] ice: Add basic E830 support
Date: Wed, 23 Aug 2023 20:06:24 +0200
Message-Id: <20230823180633.2450617-1-pawel.chmielewski@intel.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is an initial patchset adding the basic support for E830. E830 is
the 200G ethernet controller family that is a follow on to the E810 100G
family. The series adds new devices IDs, a new MAC type, several registers
and a support for new link speeds. As the new devices use another version
of ice_aqc_get_link_status_data admin command, the driver should use
different buffer length for this AQ command when loaded on E830.

Alice Michael (1):
  ice: Add 200G speed/phy type use

Dan Nowlin (1):
  ice: Add support for E830 DDP package segment

Paul Greenwalt (3):
  ice: Add E830 device IDs, MAC type and registers
  ethtool: Add forced speed to supported link modes maps
  ice: Add ice_get_link_status_datalen

Pawel Chmielewski (3):
  ice: Refactor finding advertised link speed
  ice: Remove redundant zeroing of the fields.
  ice: Hook up 4 E830 devices by adding their IDs

 drivers/net/ethernet/intel/ice/ice.h          |   1 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  48 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |  94 ++--
 drivers/net/ethernet/intel/ice/ice_ddp.c      | 426 +++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_ddp.h      |  27 +-
 drivers/net/ethernet/intel/ice/ice_devids.h   |  10 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 218 ++++++---
 drivers/net/ethernet/intel/ice/ice_ethtool.h  |   8 +
 .../net/ethernet/intel/ice/ice_ethtool_fdir.c |  24 +-
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |  52 ++-
 drivers/net/ethernet/intel/ice/ice_main.c     |  73 +--
 drivers/net/ethernet/intel/ice/ice_type.h     |   6 +-
 .../ethernet/intel/ice/ice_virtchnl_fdir.c    |  29 +-
 .../net/ethernet/qlogic/qede/qede_ethtool.c   |  22 +-
 include/linux/ethtool.h                       |  20 +
 net/ethtool/ioctl.c                           |  15 +
 16 files changed, 818 insertions(+), 255 deletions(-)

-- 
2.37.3


