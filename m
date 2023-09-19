Return-Path: <netdev+bounces-35093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63CB7A6E8B
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 00:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71D91C20828
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 22:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861CF3B7B9;
	Tue, 19 Sep 2023 22:15:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64A83B285
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 22:15:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74248F7
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 15:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695161732; x=1726697732;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Bx6O4pqWprve4wLQTszMsqej5dpku+qqVpPqIWtKcgc=;
  b=gvNXIoEnrbYbVI69zCzX5IB2kP9x4LVXWsX9P5A+ROB9mzEQRDNUyova
   RJq2Pn3BSiznFcYAIlmRa+HnB3CNX7r1qp5yM+UDhtnn5H8QeWS+Vef4j
   HMVbD2LVpclXVx3RenN2IUr6+g2u8CXocg+8B1R+PhFGHBmo909+x4GkL
   LSlwQIUyKfN8HsgMiQK4I/ELWSpOo0sdbftzy2TWIzIC7qe7KA1nMyZaj
   8K6//RmTWrZ+xnXshyogaOkQR78uH7AlyJmbFq1pjtDdiP1sXiPqHsZ0x
   W5KyutYUNvWDPEYPp7vnkVKdqWJALljFgZZ3g8GmpWH6DYMReLJydnM/M
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="370378385"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="370378385"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 15:11:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="749644498"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="749644498"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by fmsmga007.fm.intel.com with ESMTP; 19 Sep 2023 15:11:46 -0700
Subject: [net-next PATCH v3 00/10] Introduce queue and NAPI support in
 netdev-genl (Was: Introduce NAPI queues support)
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Tue, 19 Sep 2023 15:27:14 -0700
Message-ID: <169516206704.7377.12938469824609831999.stgit@anambiarhost.jf.intel.com>
User-Agent: StGit/unknown-version
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add the capability to export the following via netdev-genl interface:
- queue information supported by the device
- NAPI information supported by the device

Introduce support for associating  queue and NAPI instance.
Extend the netdev_genl generic netlink family for netdev
with queue and NAPI data. 

The queue parameters exposed are:
- queue index
- queue type
- ifindex
- NAPI id associated with the queue
- tx maxrate
Additional rx and tx queue parameters can be exposed in follow up
patches by stashing them in netdev queue structures. XDP queue type
can also be supported in future.

The NAPI fields exposed are:
- NAPI id
- NAPI device ifindex
- Interrupt number associated with the NAPI instance
- PID for the NAPI thread

This series only supports 'get' ability for retrieving
certain queue and NAPI attributes. The 'set' ability for
configuring queue and associated NAPI instance via netdev-genl
will be submitted as a separate patch series.

Previous discussion at:
https://lore.kernel.org/netdev/c8476530638a5f4381d64db0e024ed49c2db3b02.camel@gmail.com/T/#m00999652a8b4731fbdb7bf698d2e3666c65a60e7

$ ./cli.py --spec netdev.yaml --do queue-get  --json='{"ifindex": 12, "q-id": 0, "q-type": 0}'
{'ifindex': 12, 'napi-id': 593, 'q-id': 0, 'q-type': 'rx'}

$ ./cli.py --spec netdev.yaml  --do queue-get --json='{"ifindex": 12, "q-id": 0, "q-type": 1}'
{'ifindex': 12, 'napi-id': 593, 'q-id': 0, 'q-type': 'tx', 'tx-maxrate': 0}

$ ./cli.py --spec netdev.yaml  --dump queue-get --json='{"ifindex": 12}'
[{'ifindex': 12, 'napi-id': 593, 'q-id': 0, 'q-type': 'rx'},
 {'ifindex': 12, 'napi-id': 594, 'q-id': 1, 'q-type': 'rx'},
 {'ifindex': 12, 'napi-id': 595, 'q-id': 2, 'q-type': 'rx'},
 {'ifindex': 12, 'napi-id': 596, 'q-id': 3, 'q-type': 'rx'},
 {'ifindex': 12, 'napi-id': 593, 'q-id': 0, 'q-type': 'tx', 'tx-maxrate': 0},
 {'ifindex': 12, 'napi-id': 594, 'q-id': 1, 'q-type': 'tx', 'tx-maxrate': 0},
 {'ifindex': 12, 'napi-id': 595, 'q-id': 2, 'q-type': 'tx', 'tx-maxrate': 0},
 {'ifindex': 12, 'napi-id': 596, 'q-id': 3, 'q-type': 'tx', 'tx-maxrate': 0}]

$ ./cli.py --spec netdev.yaml --do napi-get --json='{"napi-id": 593}'
{'ifindex': 12, 'irq': 291, 'napi-id': 593, 'pid': 3817}

$ ./cli.py --spec netdev.yaml --dump napi-get --json='{"ifindex": 12}'
[{'ifindex': 12, 'irq': 294, 'napi-id': 596, 'pid': 3814},
 {'ifindex': 12, 'irq': 293, 'napi-id': 595, 'pid': 3815},
 {'ifindex': 12, 'irq': 292, 'napi-id': 594, 'pid': 3816},
 {'ifindex': 12, 'irq': 291, 'napi-id': 593, 'pid': 3817}]

v2 -> v3
* Implemented queue as separate netlink object
with support for exposing per-queue paramters
* Removed queue-list associations with NAPI
* Addressed other review feedback WRT tracking list
iterations

v1 -> v2
* Removed multi-attr nest for NAPI object
* Added support for flat/individual NAPI objects
* Changed 'do' command to take napi-id as argument
* Supported filtered 'dump' (dump with ifindex for a netdev and dump for
  all netdevs)

RFC -> v1
* Changed to separate 'napi_get' command
* Added support to expose interrupt and PID for the NAPI
* Used list of netdev queue structs
* Split patches further and fixed code style and errors

---

Amritha Nambiar (10):
      netdev-genl: spec: Extend netdev netlink spec in YAML for queue
      net: Add queue and napi association
      ice: Add support in the driver for associating queue with napi
      netdev-genl: Add netlink framework functions for queue
      netdev-genl: spec: Extend netdev netlink spec in YAML for NAPI
      netdev-genl: Add netlink framework functions for napi
      netdev-genl: spec: Add irq in netdev netlink YAML spec
      net: Add NAPI IRQ support
      netdev-genl: spec: Add PID in netdev netlink YAML spec
      netdev-genl: Add PID for the NAPI thread


 Documentation/netlink/specs/netdev.yaml   |   92 ++++++++
 drivers/net/ethernet/intel/ice/ice_lib.c  |   60 +++++
 drivers/net/ethernet/intel/ice/ice_lib.h  |    4 
 drivers/net/ethernet/intel/ice/ice_main.c |    4 
 include/linux/netdevice.h                 |   13 +
 include/net/netdev_rx_queue.h             |    2 
 include/uapi/linux/netdev.h               |   28 ++
 net/core/dev.c                            |   39 +++
 net/core/netdev-genl-gen.c                |   50 ++++
 net/core/netdev-genl-gen.h                |    5 
 net/core/netdev-genl.c                    |  347 +++++++++++++++++++++++++++++
 tools/include/uapi/linux/netdev.h         |   28 ++
 tools/net/ynl/generated/netdev-user.c     |  295 +++++++++++++++++++++++++
 tools/net/ynl/generated/netdev-user.h     |  180 +++++++++++++++
 14 files changed, 1143 insertions(+), 4 deletions(-)

--

