Return-Path: <netdev+bounces-43704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B157D44CB
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 03:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AE73B20D3B
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 01:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E9946B8;
	Tue, 24 Oct 2023 01:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DSwoVWqV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928997E
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 01:17:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF50A1
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 18:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698110260; x=1729646260;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4UKdrT8a7rOt6qXnT2DqeGPYhcql3wDA8/mnxOIKlJ0=;
  b=DSwoVWqVuOgrzXepq0z73DZRE7ST0oG64xJqeQz3bu7yWk5IFKc+3jV6
   IZHbs52V6I7JwR7/MB3fm4jdvyHu1dZZz8rqbhFeS+BZcizN/8ALa1gbb
   urwRIx8O4bGven3Sg7fEH0QqDByYzPkbVJnguLp7wVDWHnC1J2qbnNlJq
   fG4iqIgK2KBL8AVRwZcKW7JvAeIY3OUPzCdcsjNH3HfFrJwQdpCdRFenX
   YMO2g/Rx7wJUo+LLiLpLRrQxn1P+4Moyi8tmfCIZBvF6w34Eg93AcS3sA
   GjHUrxEvWoidRidYwxQItUxo/4L9DeU/0urszoewYJFwsYKaLAE7B2+b3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="385857749"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="385857749"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 18:17:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="708111789"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="708111789"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orsmga003.jf.intel.com with ESMTP; 23 Oct 2023 18:17:40 -0700
Subject: [net-next PATCH v6 00/10] Introduce queue and NAPI support in
 netdev-genl (Was: Introduce NAPI queues support)
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Mon, 23 Oct 2023 18:33:19 -0700
Message-ID: <169811096816.59034.13985871730113977096.stgit@anambiarhost.jf.intel.com>
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

$ ./cli.py --spec netdev.yaml --do queue-get  --json='{"ifindex": 12, "queue-id": 0, "queue-type": 0}'
{'ifindex': 12, 'napi-id': 593, 'queue-id': 0, 'queue-type': 'rx'}

$ ./cli.py --spec netdev.yaml  --do queue-get --json='{"ifindex": 12, "queue-id": 0, "queue-type": 1}'
{'ifindex': 12, 'napi-id': 593, 'queue-id': 0, 'queue-type': 'tx'}

$ ./cli.py --spec netdev.yaml  --dump queue-get --json='{"ifindex": 12}'
[{'ifindex': 12, 'napi-id': 593, 'queue-id': 0, 'queue-type': 'rx'},
 {'ifindex': 12, 'napi-id': 594, 'queue-id': 1, 'queue-type': 'rx'},
 {'ifindex': 12, 'napi-id': 595, 'queue-id': 2, 'queue-type': 'rx'},
 {'ifindex': 12, 'napi-id': 596, 'queue-id': 3, 'queue-type': 'rx'},
 {'ifindex': 12, 'napi-id': 593, 'queue-id': 0, 'queue-type': 'tx'},
 {'ifindex': 12, 'napi-id': 594, 'queue-id': 1, 'queue-type': 'tx'},
 {'ifindex': 12, 'napi-id': 595, 'queue-id': 2, 'queue-type': 'tx'},
 {'ifindex': 12, 'napi-id': 596, 'queue-id': 3, 'queue-type': 'tx'}]

$ ./cli.py --spec netdev.yaml --do napi-get --json='{"napi-id": 593}'
{'ifindex': 12, 'irq': 291, 'napi-id': 593, 'pid': 3817}

$ ./cli.py --spec netdev.yaml --dump napi-get --json='{"ifindex": 12}'
[{'ifindex': 12, 'irq': 294, 'napi-id': 596, 'pid': 3814},
 {'ifindex': 12, 'irq': 293, 'napi-id': 595, 'pid': 3815},
 {'ifindex': 12, 'irq': 292, 'napi-id': 594, 'pid': 3816},
 {'ifindex': 12, 'irq': 291, 'napi-id': 593, 'pid': 3817}]

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


 Documentation/netlink/specs/netdev.yaml   |   88 ++++++++
 drivers/net/ethernet/intel/ice/ice_lib.c  |   64 ++++++
 drivers/net/ethernet/intel/ice/ice_lib.h  |    4 
 drivers/net/ethernet/intel/ice/ice_main.c |    4 
 include/linux/netdevice.h                 |   17 ++
 include/net/netdev_rx_queue.h             |    4 
 include/uapi/linux/netdev.h               |   27 ++
 net/core/dev.c                            |   49 ++++
 net/core/dev.h                            |    2 
 net/core/netdev-genl-gen.c                |   50 +++++
 net/core/netdev-genl-gen.h                |    5 
 net/core/netdev-genl.c                    |  320 +++++++++++++++++++++++++++++
 tools/include/uapi/linux/netdev.h         |   27 ++
 tools/net/ynl/generated/netdev-user.c     |  289 ++++++++++++++++++++++++++
 tools/net/ynl/generated/netdev-user.h     |  179 ++++++++++++++++
 15 files changed, 1125 insertions(+), 4 deletions(-)

--

