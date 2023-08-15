Return-Path: <netdev+bounces-27731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384F777D08C
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 19:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D6422813E0
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 17:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61761156EE;
	Tue, 15 Aug 2023 17:06:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D8D13ADE
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 17:06:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36D21737
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 10:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692119184; x=1723655184;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vAay4aUIZuVTeeiacV1F/Nc32BXID36g7Uvf8bixLJg=;
  b=kOxZOmlDEilhM5AtY4qIyQc6nWdWurwNZK7QdKwJ84JsyUFPoFr2HOkZ
   EQFYozHhkvC/7AMNyzW3P4UZ6RWR+K61MAFz8/l1LByXbiFeUcKtg/m4P
   4hTOCsCzBZKat6yFXBLJq9d9/m4ZnLTXn/bocGpceRKY8S2k09wPUuJ5m
   3+yOGzAvoMz80YUA1KwuMd6RyOypyH20178BqolCaRhIdXzMXDpBsk/nz
   p1qTNDA+G94hmIHlhRy2XlNgWfs+TNzrY1kKPcLOXln1liLOxo/S9EcQ+
   RiEz/w4keTERT9Ap4aTHSIYv/qxx8QK3g0025GsclAS7IRq+bXAHGBSbk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="362483531"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="362483531"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 10:04:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="733913243"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="733913243"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga002.jf.intel.com with ESMTP; 15 Aug 2023 10:04:47 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	paul.m.stillwell.jr@intel.com,
	jacob.e.keller@intel.com,
	horms@kernel.org
Subject: [PATCH net-next v3 0/5][pull request] add v2 FW logging for ice driver
Date: Tue, 15 Aug 2023 09:57:45 -0700
Message-Id: <20230815165750.2789609-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
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

Paul Stillwell says:

Firmware (FW) log support was added to the ice driver, but that version is
no longer supported. There is a newer version of FW logging (v2) that
adds more control knobs to get the exact data out of the FW
for debugging.

The interface for FW logging is debugfs. This was chosen based on a
discussion here:
https://lore.kernel.org/netdev/20230214180712.53fc8ba2@kernel.org/
We talked about using devlink in a variety of ways, but none of those
options made any sense for the way the FW reports data. We briefly talked
about using ethtool, but that seemed to go by the wayside. Ultimately it
seems like using debugfs is the way to go so re-implement the code to use
that.

FW logging is across all the PFs on the device so restrict the commands to
only PF0.

If FW logging is supported then a directory named 'fwlog' will be created
under '/sys/kernel/debug/ice/<pci_dev>'. A variety of files will be created
to manage the behavior of logging. The following files will be created:
- modules
- resolution
- enable
- nr_buffs
- data

where modules is used to read/write the configuration for FW logging

resolution is used to determine how often to send FW logging events to the
driver

enable is used to start/stop FW logging. This is a boolean value so only 1
or 0 are permissible values

nr_buffs is used to configure the number of data buffers the driver uses
for log data

data is used to read/clear the log data

Generally there is a lot of data and dumping that data to syslog will
result in a loss of data. This causes problems when decoding the data and
the user doesn't know that data is missing until later. Instead of dumping
the FW log output to syslog use debugfs. This ensures that all the data the
driver has gets retrieved correctly.

The FW log data is binary data that the FW team decodes to determine what
happened in firmware. The binary blob is sent to Intel for decoding.
---
v3:
- Adjust error path cleanup in ice_module_init() for unreachable code.

v2: https://lore.kernel.org/netdev/20230810170109.1963832-1-anthony.l.nguyen@intel.com/
- Rewrote code to use debugfs instead of devlink

v1: https://lore.kernel.org/netdev/20230209190702.3638688-1-anthony.l.nguyen@intel.com/

Previous discussion:
https://lore.kernel.org/netdev/fea3e7bc-db75-ce15-1330-d80483267ee2@intel.com/

The following are changes since commit 479b322ee6feaff612285a0e7f22c022e8cd84eb:
  net: dsa: mv88e6060: add phylink_get_caps implementation
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Paul M Stillwell Jr (5):
  ice: remove FW logging code
  ice: configure FW logging
  ice: enable FW logging
  ice: add ability to read FW log data and configure the number of log
    buffers
  ice: add documentation for FW logging

 .../device_drivers/ethernet/intel/ice.rst     | 117 +++
 drivers/net/ethernet/intel/ice/Makefile       |   4 +-
 drivers/net/ethernet/intel/ice/ice.h          |  18 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 161 ++--
 drivers/net/ethernet/intel/ice/ice_common.c   | 219 +----
 drivers/net/ethernet/intel/ice/ice_common.h   |   1 -
 drivers/net/ethernet/intel/ice/ice_debugfs.c  | 807 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_fwlog.c    | 450 ++++++++++
 drivers/net/ethernet/intel/ice/ice_fwlog.h    |  78 ++
 drivers/net/ethernet/intel/ice/ice_main.c     |  51 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |  23 +-
 11 files changed, 1614 insertions(+), 315 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_debugfs.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.h

-- 
2.38.1


