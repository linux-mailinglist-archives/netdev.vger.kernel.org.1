Return-Path: <netdev+bounces-54110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D681806070
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 22:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3CC228207D
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 21:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585846E599;
	Tue,  5 Dec 2023 21:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oBh+HuTw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E42C18B
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 13:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701810779; x=1733346779;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XxCBGjE6gti0jSAZUAdfqF4X2o1B/74mSqezQ5Z6BVk=;
  b=oBh+HuTwb5+trWydgn6AmFbqhvzPsYEEB2phJPftnMkNvCwzxILRi4bQ
   C4Rh16samCb5Ff2oCiAxGu8FVzz1k1KQZ/C9MBB/IlAMgignqKPYXN6Dw
   fdCjG2MEIxX4mEJxg0+83kvIq111l4zMTei52K6be8ZNdtHmoIFUJ51fj
   lMbytr++m2xaoDww2DiR04soUYWbzxJyIarfJLgP/14L/S+adaMqFuRXf
   NeNzui1E/ewBMHmsOTHtxV2eJ09bPJSVqWHyoT8nwByIo0kfeYXKIb7EL
   fQ2vNhJ9Bipn4dghn8IjoztMxeI10RaoMwmdOIR17/vMSloAl8v3t3emb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="391126809"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="391126809"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:12:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="944406799"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="944406799"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga005.jf.intel.com with ESMTP; 05 Dec 2023 13:12:57 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	paul.m.stillwell.jr@intel.com,
	jacob.e.keller@intel.com,
	vaishnavi.tipireddy@intel.com,
	horms@kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v5 0/5][pull request] add v2 FW logging for ice driver
Date: Tue,  5 Dec 2023 13:12:43 -0800
Message-ID: <20231205211251.2122874-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Paul Stillwell says:

Firmware (FW) log support was added to the ice driver, but that version is
no longer supported. There is a newer version of FW logging (v2) that
adds more control knobs to get the exact data out of the FW
for debugging.

The interface for FW logging is debugfs. This was chosen based on
discussions here:
https://lore.kernel.org/netdev/20230214180712.53fc8ba2@kernel.org/ and
https://lore.kernel.org/netdev/20231012164033.1069fb4b@kernel.org/

We talked about using devlink in a variety of ways, but none of those
options made any sense for the way the FW reports data. We briefly talked
about using ethtool, but that seemed to go by the wayside. Ultimately it
seems like using debugfs is the way to go so re-implement the code to use
that.

FW logging is across all the PFs on the device so restrict the commands to
only PF0.

If the device supports FW logging then a directory named 'fwlog' will be
created under '/sys/kernel/debug/ice/<pci_dev>'. A variety of files will be
created to manage the behavior of logging. The following files will be
created:
- modules/<module>
- nr_messages
- enable
- log_size
- data

where
modules/<module> is used to read/write the log level for a specific module

nr_messages is used to determine how many events should be in each message
sent to the driver

enable is used to start/stop FW logging. This is a boolean value so only 1
or 0 are permissible values

log_size is used to configure the amount of memory the driver uses for log
data

data is used to read/clear the log data

Generally there is a lot of data and dumping that data to syslog will
result in a loss of data. This causes problems when decoding the data and
the user doesn't know that data is missing until later. Instead of dumping
the FW log output to syslog use debugfs. This ensures that all the data the
driver has gets retrieved correctly.

The FW log data is binary data that the FW team decodes to determine what
happened in firmware. The binary blob is sent to Intel for decoding.
---
v5:
- changed the log level configuration from a single file for all modules to a
  file per module.
- changed 'nr_buffs' to 'log_size' because users understand memory sizes
  better than a number of buffers
- changed 'resolution' to 'nr_messages' to better reflect what it represents
- updated documentation to reflect these changes
- updated documentation to indicate that FW logging must be disabled to
  clear the data. also clarified that any value written to the 'data' file will
  clear the data

v4: https://lore.kernel.org/netdev/20231005170110.3221306-1-anthony.l.nguyen@intel.com/
- removed CONFIG_DEBUG_FS wrapper around code because the debugfs calls handle
  this case already
- moved ice_debugfs_exit() call to remove unreachable code issue
- minor changes to documentation based on feedback

v3: https://lore.kernel.org/netdev/20230815165750.2789609-1-anthony.l.nguyen@intel.com/
- Adjust error path cleanup in ice_module_init() for unreachable code.

v2: https://lore.kernel.org/netdev/20230810170109.1963832-1-anthony.l.nguyen@intel.com/
- Rewrote code to use debugfs instead of devlink

v1: https://lore.kernel.org/netdev/20230209190702.3638688-1-anthony.l.nguyen@intel.com/

Previous discussion:
https://lore.kernel.org/netdev/fea3e7bc-db75-ce15-1330-d80483267ee2@intel.com/

The following are changes since commit fb70136ded2e1ea3cde27d0393cfadab4240a141:
  ipvlan: implement .parse_protocol hook function in ipvlan_header_ops
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Paul M Stillwell Jr (5):
  ice: remove FW logging code
  ice: configure FW logging
  ice: enable FW logging
  ice: add ability to read and configure FW log data
  ice: add documentation for FW logging

 .../device_drivers/ethernet/intel/ice.rst     | 141 +++
 drivers/net/ethernet/intel/ice/Makefile       |   4 +-
 drivers/net/ethernet/intel/ice/ice.h          |   9 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 161 ++--
 drivers/net/ethernet/intel/ice/ice_common.c   | 219 +----
 drivers/net/ethernet/intel/ice/ice_common.h   |   1 -
 drivers/net/ethernet/intel/ice/ice_debugfs.c  | 848 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_fwlog.c    | 475 ++++++++++
 drivers/net/ethernet/intel/ice/ice_fwlog.h    |  80 ++
 drivers/net/ethernet/intel/ice/ice_main.c     |  51 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |  23 +-
 11 files changed, 1697 insertions(+), 315 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_debugfs.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.h

-- 
2.41.0


