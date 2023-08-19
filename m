Return-Path: <netdev+bounces-29069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 018D67818F1
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 12:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA80280F74
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 10:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DC64429;
	Sat, 19 Aug 2023 10:40:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FE8A51
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 10:40:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E842DEB1
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 02:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692438224; x=1723974224;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tRw9dLHguy5e/5iRm9Mr/7nX4y/bvWhuuCW+9pQB8f0=;
  b=lgyFLETYO+yUG0ZO+DL1ARU+u3bY+ru/inNao3T8KNgwb8CZXxmPXPdp
   0EeIX7DUBBNkhlMfyQhY6CJGJJBZ5xvJb6oYqCQQXBYGC+4aOPqvtQTw7
   WBUwooG17pjMD4w24N0WcnPQqaQBKyKjz5EYWuUxcXrhY+CR+8SH5ymnM
   FCfD1JNuYrRe53bxUrAzmQ6ojdJxoRUJJ57BMmiX/gU97ypwe7HmXttyF
   ysym6Z/CIdUApGmh/+AG1RhTPq4ngHnhP1yrMZWfW1GXWhVftegzOQqRH
   xOwjGnkLoEnpEmH9DHVFR9rqLoQnSZZuvBQZKpip7LjHtYiFZbcdGLh2h
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="352870279"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="352870279"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2023 02:43:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="878937808"
Received: from unknown (HELO localhost.jf.intel.com) ([10.166.244.168])
  by fmsmga001.fm.intel.com with ESMTP; 19 Aug 2023 02:43:47 -0700
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	pawel.chmielewski@intel.com,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH iwl-next v2 0/9] ice: Add basic E830 support 
Date: Sat, 19 Aug 2023 02:36:17 -0700
Message-Id: <20230819093617.14985-1-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is an initial patchset adding the basic support for E830. E830 is
the 200G ethernet controller family that is a follow on to the E810
100G family. The series adds new devices IDs, a new MAC type, several
registers and a support for new link speeds. As the new devices use
another version of ice_aqc_get_link_status_data admin command, the
driver should use different buffer length for this AQ command when
loaded on E830.

Alice Michael (1):
  ice: Add 200G speed/phy type use

Dan Nowlin (1):
  ice: Add support for E830 DDP package segment

Paul Greenwalt (4):
  ice: Add E830 device IDs, MAC type and registers
  ethtool: Add forced speed to supported link modes maps
  ethtool: Add missing ETHTOOL_LINK_MODE_ to forced speed map
  ice: Add ice_get_link_status_datalen

Pawel Chmielewski (3):
  ice: Refactor finding advertised link speed
  ice: Remove redundant zeroing of the fields.
  ice: Enable support for E830 device IDs

Change log:

v2: move qede Ethtool speed to link modes mapping to be shared by other
drivers (Andrew)

 drivers/net/ethernet/intel/ice/ice.h          |   1 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  48 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |  94 ++--
 drivers/net/ethernet/intel/ice/ice_ddp.c      | 426 +++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_ddp.h      |  27 +-
 drivers/net/ethernet/intel/ice/ice_devids.h   |  10 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 155 ++++---
 drivers/net/ethernet/intel/ice/ice_ethtool.h  |   8 +
 .../net/ethernet/intel/ice/ice_ethtool_fdir.c |  24 +-
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |  52 ++-
 drivers/net/ethernet/intel/ice/ice_main.c     |  71 +--
 drivers/net/ethernet/intel/ice/ice_type.h     |   6 +-
 .../ethernet/intel/ice/ice_virtchnl_fdir.c    |  29 +-
 .../net/ethernet/qlogic/qede/qede_ethtool.c   |  92 +---
 include/linux/ethtool.h                       | 154 +++++++
 net/ethtool/ioctl.c                           |  15 +
 16 files changed, 896 insertions(+), 316 deletions(-)

-- 
2.39.2


