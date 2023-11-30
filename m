Return-Path: <netdev+bounces-52321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678BB7FE497
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 01:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E836282089
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 00:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEC0369;
	Thu, 30 Nov 2023 00:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J22s7Jex"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4034E10C9
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 16:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701303055; x=1732839055;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JLJrDHBEe9seMgjB40a54Y12EtEDAUz7UUnl3tYYxLs=;
  b=J22s7Jex5tAj80dCeWquukP7HVZZl3KW2Vu3UFJutnGAE5yKDY0isZq3
   HPOB54anf5IxaEL1z8nZ2Y6g4kYSAAoGdItqCb1DD1TXnpu+/Mx4nUI+7
   2j+zZA7ql+r/MlX4U1BXA9OMrOwbNtpTPGpYSW9DHwFKVBR40On0+a9EU
   S/8WHFfgCbqk3PcmWDWT34kFAzZSYK/23mkvEGiksbBHIVpf8Wc1acxdO
   mHRZVEq/6+UCxRJ806QEIGMpdcTjyyjxmo3xYRJJzTw+z7jL0kLwdXMjP
   QCdnevZq1Le6JV3jvg9Wzdq2NNRODtTLCAIgGOeZ2dwPzCWasGovuvs0v
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="112029"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="112029"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 16:10:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="839619137"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="839619137"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by fmsmga004.fm.intel.com with ESMTP; 29 Nov 2023 16:10:54 -0800
Subject: [net-next PATCH v10 00/11] Introduce queue and NAPI support in
 netdev-genl (Was: Introduce NAPI queues support)
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: edumazet@google.com, ast@kernel.org, sdf@google.com, lorenzo@kernel.org,
 tariqt@nvidia.com, daniel@iogearbox.net, anthony.l.nguyen@intel.com,
 lucien.xin@gmail.com, michael.chan@broadcom.com, sridhar.samudrala@intel.com,
 amritha.nambiar@intel.com
Date: Wed, 29 Nov 2023 16:27:22 -0800
Message-ID: <170130378595.5198.158092030504280163.stgit@anambiarhost.jf.intel.com>
User-Agent: StGit/unknown-version
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add the capability to export the following via netdev-genl interface:
- queue information supported by the device
- NAPI information supported by the device

Introduce support for associating queue and NAPI instance.
Extend the netdev_genl generic netlink family for netdev
with queue and NAPI data. 

The queue parameters exposed are:
- queue index
- queue type
- ifindex
- NAPI id associated with the queue

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

$ ./cli.py --spec netdev.yaml --do queue-get  --json='{"ifindex": 12, "id": 0, "type": 0}'
{'id': 0, 'ifindex': 12, 'napi-id': 593, 'type': 'rx'}

$ ./cli.py --spec netdev.yaml  --do queue-get --json='{"ifindex": 12, "id": 0, "type": 1}'
{'id': 0, 'ifindex': 12, 'napi-id': 593, 'type': 'tx'}

$ ./cli.py --spec netdev.yaml  --dump queue-get --json='{"ifindex": 12}'
[{'id': 0, 'ifindex': 12, 'napi-id': 593, 'type': 'rx'},
 {'id': 1, 'ifindex': 12, 'napi-id': 594, 'type': 'rx'},
 {'id': 2, 'ifindex': 12, 'napi-id': 595, 'type': 'rx'},
 {'id': 3, 'ifindex': 12, 'napi-id': 596, 'type': 'rx'},
 {'id': 0, 'ifindex': 12, 'napi-id': 593, 'type': 'tx'},
 {'id': 1, 'ifindex': 12, 'napi-id': 594, 'type': 'tx'},
 {'id': 2, 'ifindex': 12, 'napi-id': 595, 'type': 'tx'},
 {'id': 3, 'ifindex': 12, 'napi-id': 596, 'type': 'tx'}]

$ ./cli.py --spec netdev.yaml --do napi-get --json='{"id": 593}'
{'id': 593, 'ifindex': 12, 'irq': 291, 'pid': 3727}

$ ./cli.py --spec netdev.yaml --dump napi-get --json='{"ifindex": 12}'
[{'id': 596, 'ifindex': 12, 'irq': 294, 'pid': 3724},
 {'id': 595, 'ifindex': 12, 'irq': 293, 'pid': 3725},
 {'id': 594, 'ifindex': 12, 'irq': 292, 'pid': 3726},
 {'id': 593, 'ifindex': 12, 'irq': 291, 'pid': 3727}]

v9 -> v10
* Re-spin to resolve merge issues as page pool changes were accepted.

v8 -> v9
* Removed locked version __netif_queue_set_napi(), the function
netif_queue_set_napi() assumes lock is taken. Made changes to ice
driver to take the lock locally.
* Detach NAPI from queues by passing NULL to netif_queue_set_napi()
* Support to avoid listing queue and NAPI info of devices which are DOWN
* Includes support for bnxt driver.

v7 -> v8
* Removed $obj prefix from attribute names in yaml spec

v6 -> v7
* Added more documentation in spec file
* Addressed other review comments related to lock

v5 -> v6
* Fixed build warning in prototype for ice_queue_set_napi()

v4 -> v5
* Removed tx_maxrate in queue atrributes
* Added lock protection for queue->napi
* Addressed other review comments

v3 -> v4
Minor nits, changed function name, used list_for_each_entry in place
of _rcu

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

Jakub Kicinski (1):
      eth: bnxt: link NAPI instances to queues and IRQs


 Documentation/netlink/specs/netdev.yaml   |   94 ++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |   12 +
 drivers/net/ethernet/intel/ice/ice_base.c |   12 +
 drivers/net/ethernet/intel/ice/ice_lib.c  |   69 ++++++
 drivers/net/ethernet/intel/ice/ice_lib.h  |    4 
 drivers/net/ethernet/intel/ice/ice_main.c |    4 
 include/linux/netdevice.h                 |   14 +
 include/net/netdev_rx_queue.h             |    4 
 include/uapi/linux/netdev.h               |   27 ++
 net/core/dev.c                            |   41 +++-
 net/core/dev.h                            |    2 
 net/core/netdev-genl-gen.c                |   50 ++++
 net/core/netdev-genl-gen.h                |    5 
 net/core/netdev-genl.c                    |  331 +++++++++++++++++++++++++++++
 tools/include/uapi/linux/netdev.h         |   27 ++
 tools/net/ynl/generated/netdev-user.c     |  289 +++++++++++++++++++++++++
 tools/net/ynl/generated/netdev-user.h     |  178 ++++++++++++++++
 17 files changed, 1157 insertions(+), 6 deletions(-)

--

