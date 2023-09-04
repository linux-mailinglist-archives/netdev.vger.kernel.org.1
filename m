Return-Path: <netdev+bounces-31859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BD5790FF1
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 04:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A269280F35
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 02:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B929B396;
	Mon,  4 Sep 2023 02:15:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9A2381
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 02:15:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3F9A0
	for <netdev@vger.kernel.org>; Sun,  3 Sep 2023 19:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693793705; x=1725329705;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ogy0os4JaGZDL8iy4sMUtslIybt3Q8OaOOoeK0X7QX4=;
  b=RYVK4z0vFk6ClG8UpaunKx2YI+eKIY5YmGqrzwzTd1uav+9czdB8H6zz
   x2PnGaIscsx8600qPBl3XpxLCQQMsR1wIWIxtn9pTjVy7BQyWiEPYTxj7
   5VNx/qHU7D1JismyWupgE6ZnNIV9W4IL7ke5Og7imEY4ufAxe9r7L7eIU
   4POEqIIllkTcZXZAL0+Zi6FP3CNZVDnTUct6R6DWdLHMOZyr+MxsP7TBy
   tg9qzt91/uPvpdJ9CNALVNcDDMl24JLzBIrb2jarMk6jiiOXpCcDLCbb7
   yln/TVT0pCEKQabX6Ur8r2kIy2ubGiUEzhzRf17JnmH0YgKZAjhIxUwlb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="379215057"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="379215057"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2023 19:15:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="769826628"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="769826628"
Received: from dpdk-jf-ntb-v2.sh.intel.com ([10.67.119.19])
  by orsmga008.jf.intel.com with ESMTP; 03 Sep 2023 19:15:01 -0700
From: Junfeng Guo <junfeng.guo@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	qi.z.zhang@intel.com,
	ivecera@redhat.com,
	sridhar.samudrala@intel.com,
	horms@kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	Junfeng Guo <junfeng.guo@intel.com>
Subject: [PATCH iwl-next v9 00/15] Introduce the Parser Library
Date: Mon,  4 Sep 2023 10:14:40 +0800
Message-Id: <20230904021455.3944605-1-junfeng.guo@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Current software architecture for flow filtering offloading limited
the capability of Intel Ethernet 800 Series Dynamic Device
Personalization (DDP) Package. The flow filtering offloading in the
driver is enabled based on the naming parsers, each flow pattern is
represented by a protocol header stack. And there are multiple layers
(e.g., virtchnl) to maintain their own enum/macro/structure
to represent a protocol header (IP, TCP, UDP ...), thus the extra
parsers to verify if a pattern is supported by hardware or not as
well as the extra converters that to translate represents between
different layers. Every time a new protocol/field is requested to be
supported, the corresponding logic for the parsers and the converters
needs to be modified accordingly. Thus, huge & redundant efforts are
required to support the increasing flow filtering offloading features,
especially for the tunnel types flow filtering.

This patch set provides a way for applications to send down training
packets & masks (in binary) to the driver. Then these binary data
would be used by the driver to generate certain data that are needed
to create a filter rule in the filtering stage of switch/RSS/FDIR.

Note that the impact of a malicious rule in the raw packet filter is
limited to performance rather than functionality. It may affect the
performance of the workload, similar to other limitations in FDIR/RSS
on AVF. For example, there is no resource boundary for VF FDIR/RSS
rules, so one malicious VF could potentially make other VFs
inefficient in offloading.

The parser library is expected to include boundary checks to prevent
critical errors such as infinite loops or segmentation faults.
However, only implementing and validating the parser emulator in a
sandbox environment (like ebpf) presents a challenge.

The idea is to make the driver be able to learn from the DDP package
directly to understand how the hardware parser works (i.e., the
Parser Library), so that it can process on the raw training packet
(in binary) directly and create the filter rule accordingly.

Based on this Parser Library, the raw flow filtering of
switch/RSS/FDIR could be enabled to allow new flow filtering
offloading features to be supported without any driver changes (only
need to update the DDP package).

v9:
- Remove 'inline' of function in c file.
- Refactor bitfield process with FIELD_GET().
- Fix element access overrun of array key[].

v8: https://lore.kernel.org/netdev/20230824075500.1735790-1-junfeng.guo@intel.com/
- Refactor bits revert functions with existing bitrev8()/bitrev8x4().

v7: https://lore.kernel.org/netdev/20230823093158.782802-1-junfeng.guo@intel.com/
- Move/Add below marco to the first appeared commit:
ICE_PARSER_FLG_NUM and ICE_ERR_NOT_IMPL.

v6: https://lore.kernel.org/netdev/20230821081438.2937934-1-junfeng.guo@intel.com/
- Move `rt` field setting to the correct commit (first introduced).

v5: https://lore.kernel.org/netdev/20230821023833.2700902-1-junfeng.guo@intel.com/
- Update copyrights of new files to be 2023 only.
- Update patch set series prefix.
- Fix typo on patch 2 commit message.

v4: https://lore.kernel.org/intel-wired-lan/20230817094240.2584745-1-junfeng.guo@intel.com/
- Update cover letter series title.

v3: https://lore.kernel.org/intel-wired-lan/20230817093442.2576997-1-junfeng.guo@intel.com/
- Replace magic hardcoded values with macros.
- Use size_t to avoid superfluous type cast to uintptr_t in function
  ice_parser_sect_item_get.
- Prefix for static local function names to avoid namespace pollution.
- Use strstarts() function instead of self implementation.

v2: https://lore.kernel.org/intel-wired-lan/20230605054641.2865142-1-junfeng.guo@intel.com/
- Fix build warnings.

Junfeng Guo (15):
  ice: add parser create and destroy skeleton
  ice: init imem table for parser
  ice: init metainit table for parser
  ice: init parse graph cam tables for parser
  ice: init boost tcam and label tables for parser
  ice: init ptype marker tcam table for parser
  ice: init marker and protocol group tables for parser
  ice: init flag redirect table for parser
  ice: init XLT key builder for parser
  ice: add parser runtime skeleton
  ice: add internal help functions
  ice: add parser execution main loop
  ice: support double vlan mode configure for parser
  ice: add tunnel port support for parser
  ice: add API for parser profile initialization

 drivers/net/ethernet/intel/ice/Makefile       |  11 +
 drivers/net/ethernet/intel/ice/ice_bst_tcam.c | 353 ++++++++
 drivers/net/ethernet/intel/ice/ice_bst_tcam.h |  40 +
 drivers/net/ethernet/intel/ice/ice_common.h   |   3 +
 drivers/net/ethernet/intel/ice/ice_ddp.c      |  10 +-
 drivers/net/ethernet/intel/ice/ice_ddp.h      |  14 +
 drivers/net/ethernet/intel/ice/ice_flg_rd.c   |  77 ++
 drivers/net/ethernet/intel/ice/ice_flg_rd.h   |  19 +
 drivers/net/ethernet/intel/ice/ice_imem.c     | 324 +++++++
 drivers/net/ethernet/intel/ice/ice_imem.h     | 132 +++
 drivers/net/ethernet/intel/ice/ice_metainit.c | 193 ++++
 drivers/net/ethernet/intel/ice/ice_metainit.h |  47 +
 drivers/net/ethernet/intel/ice/ice_mk_grp.c   |  51 ++
 drivers/net/ethernet/intel/ice/ice_mk_grp.h   |  17 +
 drivers/net/ethernet/intel/ice/ice_parser.c   | 562 ++++++++++++
 drivers/net/ethernet/intel/ice/ice_parser.h   | 140 +++
 .../net/ethernet/intel/ice/ice_parser_rt.c    | 841 ++++++++++++++++++
 .../net/ethernet/intel/ice/ice_parser_rt.h    |  73 ++
 .../net/ethernet/intel/ice/ice_parser_util.h  |  37 +
 drivers/net/ethernet/intel/ice/ice_pg_cam.c   | 444 +++++++++
 drivers/net/ethernet/intel/ice/ice_pg_cam.h   |  73 ++
 .../net/ethernet/intel/ice/ice_proto_grp.c    |  94 ++
 .../net/ethernet/intel/ice/ice_proto_grp.h    |  24 +
 drivers/net/ethernet/intel/ice/ice_ptype_mk.c |  73 ++
 drivers/net/ethernet/intel/ice/ice_ptype_mk.h |  23 +
 drivers/net/ethernet/intel/ice/ice_tmatch.h   |  40 +
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 drivers/net/ethernet/intel/ice/ice_xlt_kb.c   | 259 ++++++
 drivers/net/ethernet/intel/ice/ice_xlt_kb.h   |  34 +
 29 files changed, 4004 insertions(+), 5 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_bst_tcam.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_bst_tcam.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_flg_rd.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_flg_rd.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_imem.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_imem.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_metainit.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_metainit.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_mk_grp.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_mk_grp.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_parser.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_parser.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_parser_rt.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_parser_rt.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_parser_util.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_pg_cam.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_pg_cam.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_proto_grp.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_proto_grp.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_ptype_mk.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_ptype_mk.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_tmatch.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_xlt_kb.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_xlt_kb.h

-- 
2.25.1


