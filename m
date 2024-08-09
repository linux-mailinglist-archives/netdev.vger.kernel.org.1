Return-Path: <netdev+bounces-117256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBB494D57F
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 19:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4BD282C31
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 17:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EB47B3E1;
	Fri,  9 Aug 2024 17:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OyBrr5l3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F9373452
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723224996; cv=none; b=QXEbcmoTxW1go4fUe1gyyw1uokOu2RCcTDUXedYgTjwChwNqtvq6AWbM3kkkVbe5kf6OHdHhZBryEQbimlH/Y9IgwH3gQFHCJV9qiTBeQxiTmpzKtKTR/8f8+mhhjdLNOWcTJPLyEiPFl/yCENtvZHC87yz6LOqENgpMt+9oEb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723224996; c=relaxed/simple;
	bh=Yiuc2KtuMk2IqGG6J/pHdWmb8AXM38ENsoKr5iAk44c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LMws/4dPZOgbDAbI1nVW0ZiMEZOSAbCU0OB+YlMYqYBiN19bZCnZjUnY/UerN5pS1x+TBP3C5L8Drnvt2/XFO1fMxhEZrT45ZZbuCFHrrXwIBhPD1kbTsunI1f+FZ44+dilq2pElCFwWmDKlVcBGGjNoAg0VxnuYgEq7r3bxsxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OyBrr5l3; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723224995; x=1754760995;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Yiuc2KtuMk2IqGG6J/pHdWmb8AXM38ENsoKr5iAk44c=;
  b=OyBrr5l3HVYwfsjqXAWVCDVG0A9t/3iw27R3hATfLRKIZlmhkzR1Nnie
   5Qi3qVxCmTREZ/w1E6WFIoENhC29hlQwanoqIwUE2gf6Lr24cWDcehydy
   UgG6FV21WK22cg8OORePUrhX352semAEmUQtnbS2YZskIVlgVbqp4JK0s
   /UqXNhh16N74KbNoJ0SxEmaGd2HirvbWxYrd7dIQy2nyhuBsH1QN4uDKi
   SoW57aunAzPFcGq4UnpVJYEEqXrvQ0yxWdKTxYJbO5dzUdCwSdd5k4bMS
   /SO8x3bbHbK8oMAt2CrAzNVzF2n5/ckrLXb06085NSATmdEeskuqOEASH
   w==;
X-CSE-ConnectionGUID: dVwOzq4iQ5OqrjtJReMyxQ==
X-CSE-MsgGUID: i+k+nEPKRHKbI60NwCGSOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21551242"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21551242"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 10:36:28 -0700
X-CSE-ConnectionGUID: yfCHjnYkRbmuAngXNFNnbg==
X-CSE-MsgGUID: nQK9uFD3RemrZm76sK44fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57589147"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 09 Aug 2024 10:36:27 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	ahmed.zaki@intel.com,
	madhu.chittim@intel.com,
	horms@kernel.org,
	hkelam@marvell.com
Subject: [PATCH net-next 00/13][pull request] ice: iavf: add support for TC U32 filters on VFs
Date: Fri,  9 Aug 2024 10:35:59 -0700
Message-ID: <20240809173615.2031516-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ahmed Zaki says:

The Intel Ethernet 800 Series is designed with a pipeline that has
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

[1]: https://lore.kernel.org/netdev/20230904021455.3944605-1-junfeng.guo@intel.com/
[2]: https://lore.kernel.org/intel-wired-lan/20230818064703.154183-1-junfeng.guo@intel.com/
---
iwl: https://lore.kernel.org/intel-wired-lan/20240725220810.12748-1-ahmed.zaki@intel.com/

The following are changes since commit 600a91931057bfec0afd665759c5574ed137cbea:
  Merge branch 'selftest-rds'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 40GbE

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
 drivers/net/ethernet/intel/iavf/iavf_fdir.c   |   89 +-
 drivers/net/ethernet/intel/iavf/iavf_fdir.h   |   13 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  160 +-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |   25 +-
 drivers/net/ethernet/intel/ice/Makefile       |    2 +
 drivers/net/ethernet/intel/ice/ice_common.h   |    1 +
 drivers/net/ethernet/intel/ice/ice_ddp.c      |   10 +-
 drivers/net/ethernet/intel/ice/ice_ddp.h      |   13 +
 .../net/ethernet/intel/ice/ice_flex_pipe.c    |   99 +-
 .../net/ethernet/intel/ice/ice_flex_pipe.h    |    7 +-
 drivers/net/ethernet/intel/ice/ice_flow.c     |  109 +-
 drivers/net/ethernet/intel/ice/ice_flow.h     |    5 +
 drivers/net/ethernet/intel/ice/ice_parser.c   | 2430 +++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_parser.h   |  540 ++++
 .../net/ethernet/intel/ice/ice_parser_rt.c    |  861 ++++++
 drivers/net/ethernet/intel/ice/ice_type.h     |    1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |    8 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |    4 +
 .../ethernet/intel/ice/ice_virtchnl_fdir.c    |  403 ++-
 include/linux/avf/virtchnl.h                  |   13 +-
 22 files changed, 4792 insertions(+), 90 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_parser.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_parser.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_parser_rt.c

-- 
2.42.0


