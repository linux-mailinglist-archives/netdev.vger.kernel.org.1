Return-Path: <netdev+bounces-57634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39536813AE4
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 20:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E75282F0D
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 19:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F35069794;
	Thu, 14 Dec 2023 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hsxsiyiQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6E06A00D
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 19:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702582893; x=1734118893;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UJnkZjYV6NwEJB76JSLCWcOnjUe+aOD8o4Db97xokYE=;
  b=hsxsiyiQTm7wNFd35G9wVUpLzb8omUX5HJzJQi1IPqQ/Ie1Lke3zXUDI
   dXI/ehYuoqbGtnfQ5yFfjpRvy0aExpoQrC3VvMjHr0d77/B0Qgr/2ubJ6
   CrvN39zERBF0kyzSOwcV7y8WttllQX6AVkdQGtJ5KNSfABTECIJy180KU
   xPVMGSHr13wfKqwOHKG2OL1C36R5ysC0JPp2uCcHL0+NhwF/eWiY2Io4W
   6F4u8cciaDniOzSC0M1VZZmW3/6v28NT5HRChH6cBGHsxTpd0NdlY+H9Z
   sYHD2Sk6c4rrnd6ZjIHrWLQBU3vPEhQ/tA7sqEamH7ObZF91ykgjj/ttq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="399013844"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="399013844"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 11:41:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="750666525"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="750666525"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga006.jf.intel.com with ESMTP; 14 Dec 2023 11:41:31 -0800
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
Subject: [PATCH net-next v6 0/5][pull request] add v2 FW logging for ice driver
Date: Thu, 14 Dec 2023 11:40:35 -0800
Message-ID: <20231214194042.2141361-1-anthony.l.nguyen@intel.com>
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
v6:
- use seq_printf() for outputting module info when reading from 'module' file
- replace code that created argc and argv for handling command line input
- removed checks in all the _read() and _write() functions to see if FW logging
  is supported because the files will not exist if it is not supported
- removed warnings on allocation failures on debugfs file creation failures
- removed a newline between memory allocation and checking if the memory was
  allocated
- fixed cases where we could just return the value from a function call
  instead of saving the value in a variable
- moved the check for PFO in ice_fwlog_init() to an earlier patch
- reworked all of argument scanning in the _write() functions in ice_debugfs.c
  to remove adding characters past the end of the buffer

v5: https://lore.kernel.org/netdev/20231205211251.2122874-1-anthony.l.nguyen@intel.com/
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

The following are changes since commit 1b666016d0ad4a879dcd3d9188635ad68c4b16ce:
  net: mvpp2: add support for mii
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Paul M Stillwell Jr (5):
  ice: remove FW logging code
  ice: configure FW logging
  ice: enable FW logging
  ice: add ability to read and configure FW log data
  ice: add documentation for FW logging

 .../device_drivers/ethernet/intel/ice.rst     | 141 ++++
 drivers/net/ethernet/intel/ice/Makefile       |   4 +-
 drivers/net/ethernet/intel/ice/ice.h          |   9 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 161 +++--
 drivers/net/ethernet/intel/ice/ice_common.c   | 219 +-----
 drivers/net/ethernet/intel/ice/ice_common.h   |   1 -
 drivers/net/ethernet/intel/ice/ice_debugfs.c  | 667 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_fwlog.c    | 470 ++++++++++++
 drivers/net/ethernet/intel/ice/ice_fwlog.h    |  79 +++
 drivers/net/ethernet/intel/ice/ice_main.c     |  48 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |  23 +-
 11 files changed, 1507 insertions(+), 315 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_debugfs.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.h

-- 
2.41.0


