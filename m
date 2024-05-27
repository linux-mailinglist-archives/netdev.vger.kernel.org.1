Return-Path: <netdev+bounces-98301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4058D0A38
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 20:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D8701F223A8
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 18:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C622015FA85;
	Mon, 27 May 2024 18:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l0n4UoIg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E21915FA80
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 18:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716836316; cv=none; b=RELkOYXTeuMGwaDRAUdy/89nk2eDNb1NCia1zb3diPdnqk3nW6EiiR6T6O+1g4BFwko8iFaLWnyhQlf+drTKV51Z6yDL8b+U9AmE3uF5/tIiNpsAlzVXyJcptwdrjrOEXppV8ErwQHcmZ5UZcm3XnMvi/ZCz1esC4esm8dGDNQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716836316; c=relaxed/simple;
	bh=KlcpWklQ5ACkWuplTx/6ZWYFd3VezVk6vhnqFjWNih8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gx3TVWB3cGD0z9Q5zIh0a9ph/u2twR2TBqLLuUt94IBDcGggJWu2407zvb07t7MlqoayzyA2qtV8EewDo9333oFQsGBBhRWc5u7jPwk9oUqVy+N959XILhRvSVMOXOky6TmGmxmgB27Z37AG4tX4PIw2PlPzXxLxmA4PPej1/EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l0n4UoIg; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716836314; x=1748372314;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KlcpWklQ5ACkWuplTx/6ZWYFd3VezVk6vhnqFjWNih8=;
  b=l0n4UoIguQ+qfY50fpr6RqRLRvCD61Rndv2nkdKYARX7mvUWF61mAPPF
   7nDunme+5E9f342+dRiUGBI6a6LUzTL/SMW9L1gF/i66C6lauK+AyH5Pn
   MUNDcVoHA6eF0CBNt8MQ9m4/a60kvuYxkUwYPr4yXmtZmXafIlIqHP3pc
   zvoiJUrNeVot92/4HGD7+J0yghNKFJC4eaetDCX1R8A4rnYRDa5/jD8Hm
   Pgm7SgRY6b4oTv0I9vsjkMwZpxgGJW/da8rNMOLIhSp7caQ3xTrod/0Ha
   5/15Nyntutn52Ck5oRaX4iei2SAMqlM9reUyN05yy0YWdje9ipOi0bc8s
   A==;
X-CSE-ConnectionGUID: WOYG17r9RIG/mQUS40XJ7w==
X-CSE-MsgGUID: qwLh9PRxSnaE25soEyf+YQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13353913"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="13353913"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 11:58:34 -0700
X-CSE-ConnectionGUID: zBfRQOdJRUuZMQzD2UgsWA==
X-CSE-MsgGUID: ou97szs1Tzy+zjMkMfpaGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="34910002"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.110.208])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 11:58:31 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	anthony.l.nguyen@intel.com,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH iwl-next v2 00/13] ice: iavf: add support for TC U32 filters on VFs
Date: Mon, 27 May 2024 12:57:57 -0600
Message-ID: <20240527185810.3077299-1-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

The Intel® Ethernet 800 Series is designed with a pipeline that has
an on-chip programmable capability called Dynamic Device Personalization
(DDP). A DDP package is loaded by the driver during probe time. The DDP
package programs functionality in both the parser and switching blocks in
the pipeline, allowing dynamic support for new and existing protocols.
Once the pipeline is configured, the driver can identify the protocol and
apply any HW action in different stages, for example, direct packets to
desired hardware queues (flow director), queue groups or drop.  

Patches 1-8 introduce a DDP package parser API that enables different
pipeline stages in the driver to learn the HW parser capabilities from 
the DDP package that is downloaded to HW. The parser library takes raw
packet patterns and masks (in binary) indicating the packet protocol fields
to be matched and generates the final HW profiles that can be applied at
the required stage. With this API, raw flow filtering for FDIR or RSS
could be done on new protocols or headers without any driver or Kernel
updates (only need to update the DDP package). These patches were submitted
before [1] but were not accepted mainly due to lack of a user.

Patches 9-11 extend the virtchnl support to allow the VF to request raw
flow director filters. Upon receiving the raw FDIR filter request, the PF
driver allocates and runs a parser lib instance and generates the hardware
profile definitions required to program the FDIR stage. These were also
submitted before [2].

Finally, patches 12 and 13 add TC U32 filter support to the iavf driver.
Using the parser API, the ice driver runs the raw patterns sent by the
user and then adds a new profile to the FDIR stage associated with the VF's
VSI. Refer to examples in patch 13 commit message.

[1]: Link: https://lore.kernel.org/netdev/20230904021455.3944605-1-junfeng.guo@intel.com/
[2]: Link: https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20230814/036333.html 

---
v2:
  - No changes, just cc netdev

Ahmed Zaki (2):
  iavf: refactor add/del FDIR filters
  iavf: add support for offloading tc U32 cls filters

Junfeng Guo (11):
  ice: add parser create and destroy skeleton
  ice: parse and init various DDP parser sections
  ice: add debugging functions for the parser sections
  ice: add parser internal helper functions
  ice: add parser execution main loop
  ice: support turning on/off the parser's double vlan mode
  ice: add UDP tunnels support to the parser
  ice: add API for parser profile initialization
  virtchnl: support raw packet in protocol header
  ice: add method to disable FDIR SWAP option
  ice: enable FDIR filters from raw binary patterns for VFs

 drivers/net/ethernet/intel/iavf/iavf.h        |   30 +
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |   59 +-
 drivers/net/ethernet/intel/iavf/iavf_fdir.c   |   85 +-
 drivers/net/ethernet/intel/iavf/iavf_fdir.h   |   13 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  148 +-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |   25 +-
 drivers/net/ethernet/intel/ice/Makefile       |    2 +
 drivers/net/ethernet/intel/ice/ice_common.h   |    1 +
 drivers/net/ethernet/intel/ice/ice_ddp.c      |   10 +-
 drivers/net/ethernet/intel/ice/ice_ddp.h      |   13 +
 .../net/ethernet/intel/ice/ice_flex_pipe.c    |   96 +-
 .../net/ethernet/intel/ice/ice_flex_pipe.h    |    7 +-
 drivers/net/ethernet/intel/ice/ice_flow.c     |  106 +-
 drivers/net/ethernet/intel/ice/ice_flow.h     |    4 +
 drivers/net/ethernet/intel/ice/ice_parser.c   | 2389 +++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_parser.h   |  540 ++++
 .../net/ethernet/intel/ice/ice_parser_rt.c    |  860 ++++++
 drivers/net/ethernet/intel/ice/ice_type.h     |    1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |    2 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |    8 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |    6 +-
 .../ethernet/intel/ice/ice_virtchnl_fdir.c    |  400 ++-
 include/linux/avf/virtchnl.h                  |   13 +-
 23 files changed, 4726 insertions(+), 92 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_parser.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_parser.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_parser_rt.c

-- 
2.43.0


