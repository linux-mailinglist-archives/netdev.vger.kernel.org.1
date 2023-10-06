Return-Path: <netdev+bounces-38491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589407BB3A3
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 10:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11EF2281FB1
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 08:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BD479C7;
	Fri,  6 Oct 2023 08:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e3+VC7pb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5951FDF
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 08:59:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1431E93
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 01:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696582748; x=1728118748;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rl/oq4vZZkxmt8tz9m1oSjV3dhA8/XMPKLc+ZU6990I=;
  b=e3+VC7pbMqnJXV+2lHOGntSkf+iJ4YhXgq2YEKn3yjfIRCZVBO2cSLoI
   MFBpfTybbJl8iwW8qlLj5uMoc719F8MmtSXaIm0Fj1g5YmbH6qJxlJPA6
   OPPFN0+299rwaMjMU2iL5gRWc2+mO5qD+JcYPIbFbgJS7lEEd7/UQ6WOC
   olGbRNejLbcRCNBlHCuvqVnCQ+5gvo/gu9PRk1FrrpJgcfhZ3GdAkiPlI
   KzX2ZFbRLefLddBZdLKkA3vI1RUhvJtCh0UJUj1g4TAcN+BGefL2HcaWj
   Tbx8K+R3gJohXm7EoXeQiUbyna8SsoHKVIMbTWKUIYHgPwrSesNlHjTkD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="447897851"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="447897851"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 01:58:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="755785039"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="755785039"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by fmsmga007.fm.intel.com with ESMTP; 06 Oct 2023 01:58:55 -0700
Subject: [net-next PATCH v4 00/10] Introduce queue and NAPI support in
 netdev-genl (Was: Introduce NAPI queues support)
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Fri, 06 Oct 2023 02:14:37 -0700
Message-ID: <169658340079.3683.13049063254569592908.stgit@anambiarhost.jf.intel.com>
User-Agent: StGit/unknown-version
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
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
patches by stashing them in netdev queue structures.  XDP queue type
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
{'ifindex': 12, 'napi-id': 593, 'queue-id': 0, 'queue-type': 'tx', 'tx-maxrate': 0}

$ ./cli.py --spec netdev.yaml  --dump queue-get --json='{"ifindex": 12}'
[{'ifindex': 12, 'napi-id': 593, 'queue-id': 0, 'queue-type': 'rx'},
 {'ifindex': 12, 'napi-id': 594, 'queue-id': 1, 'queue-type': 'rx'},
 {'ifindex': 12, 'napi-id': 595, 'queue-id': 2, 'queue-type': 'rx'},
 {'ifindex': 12, 'napi-id': 596, 'queue-id': 3, 'queue-type': 'rx'},
 {'ifindex': 12, 'napi-id': 593, 'queue-id': 0, 'queue-type': 'tx', 'tx-maxrate': 0},
 {'ifindex': 12, 'napi-id': 594, 'queue-id': 1, 'queue-type': 'tx', 'tx-maxrate': 0},
 {'ifindex': 12, 'napi-id': 595, 'queue-id': 2, 'queue-type': 'tx', 'tx-maxrate': 0},
 {'ifindex': 12, 'napi-id': 596, 'queue-id': 3, 'queue-type': 'tx', 'tx-maxrate': 0}]

$ ./cli.py --spec netdev.yaml --do napi-get --json='{"napi-id": 593}'
{'ifindex': 12, 'irq': 291, 'napi-id': 593, 'pid': 3817}

$ ./cli.py --spec netdev.yaml --dump napi-get --json='{"ifindex": 12}'
[{'ifindex': 12, 'irq': 294, 'napi-id': 596, 'pid': 3814},
 {'ifindex': 12, 'irq': 293, 'napi-id': 595, 'pid': 3815},
 {'ifindex': 12, 'irq': 292, 'napi-id': 594, 'pid': 3816},
 {'ifindex': 12, 'irq': 291, 'napi-id': 593, 'pid': 3817}]

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


 Documentation/netlink/specs/netdev.yaml   |   92 ++++++++
 drivers/net/ethernet/intel/ice/ice_lib.c  |   62 +++++
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
 tools/net/ynl/generated/netdev-user.h     |  181 +++++++++++++++
 14 files changed, 1146 insertions(+), 4 deletions(-)

--

