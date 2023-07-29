Return-Path: <netdev+bounces-22477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFBA767990
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 02:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01D51C21989
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 00:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215E919E;
	Sat, 29 Jul 2023 00:32:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135774432
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 00:32:05 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A70E10CB
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 17:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690590724; x=1722126724;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j45U52sjHHcNPhHYfU0F+bO6u/i6o2cMAz+txxzsJXs=;
  b=WPE13b+ri/bWppm2oGKC8Az/yENFQsxH89x3QCw8bU30Z144fDLXVTZY
   i3eCwDfPTY+AdZEZP4dN2h6XIGvz0UX/nMH1S3vS62x1Zd6N57b30VdJ1
   kF7O7ZpZ6nsrQmuQwYF7QYnECCdL+K0yXTxELH+Yws8/+2RIFbwl5Kdx5
   4TJkYuoFsVkACuXnvNly8UeSbpi39Wka9b3vRy5rLYzwGJSY7bgCZddl/
   9p3Z5c/XHPVuwcLX0zBxtH+dr+t1dZ+j4AOJODeXEO7kVQefrTIpiZva3
   Nb1e5pmZd6P5bzthlE849FTnvl9mHJXw8RaS6Wnr3Mrl60Am/qZlmmtG6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="358742035"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="358742035"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 17:32:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="851403786"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="851403786"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orsmga004.jf.intel.com with ESMTP; 28 Jul 2023 17:32:04 -0700
Subject: [net-next PATCH v1 0/9] Introduce NAPI queues support
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Fri, 28 Jul 2023 17:46:51 -0700
Message-ID: <169059098829.3736.381753570945338022.stgit@anambiarhost.jf.intel.com>
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
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Introduce support for associating NAPI instances with
corresponding RX and TX queue set. Add the capability
to export NAPI information supported by the device.
Extend the netdev_genl generic netlink family for netdev
with NAPI data. The NAPI fields exposed are:
- NAPI id
- queue/queue-set (both RX and TX) associated with each
  NAPI instance
- Interrupt number associated with the NAPI instance
- PID for the NAPI thread

This series only supports 'get' ability for retrieving
certain NAPI attributes. The 'set' ability for setting
queue[s] associated with a NAPI instance via netdev-genl
will be submitted as a separate patch series.

Previous discussion at:
https://lore.kernel.org/netdev/c8476530638a5f4381d64db0e024ed49c2db3b02.camel@gmail.com/T/#m00999652a8b4731fbdb7bf698d2e3666c65a60e7

$ ./cli.py --spec netdev.yaml  --do napi-get --json='{"ifindex": 6}'

[{'ifindex': 6},
 {'napi-info': [{'irq': 296,
                 'napi-id': 390,
                 'pid': 3475,
                 'rx-queues': [5],
                 'tx-queues': [5]},
                {'irq': 295,
                 'napi-id': 389,
                 'pid': 3474,
                 'rx-queues': [4],
                 'tx-queues': [4]},
                {'irq': 294,
                 'napi-id': 388,
                 'pid': 3473,
                 'rx-queues': [3],
                 'tx-queues': [3]},
                {'irq': 293,
                 'napi-id': 387,
                 'pid': 3472,
                 'rx-queues': [2],
                 'tx-queues': [2]},
                {'irq': 292,
                 'napi-id': 386,
                 'pid': 3471,
                 'rx-queues': [1],
                 'tx-queues': [1]},
                {'irq': 291,
                 'napi-id': 385,
                 'pid': 3470,
                 'rx-queues': [0],
                 'tx-queues': [0]}]}]
 
RFC -> v1
* Changed to separate 'napi_get' command
* Added support to expose interrupt and PID for the NAPI
* Used list of netdev queue structs
* Split patches further and fixed code style and errors

---

Amritha Nambiar (9):
      net: Introduce new fields for napi and queue associations
      ice: Add support in the driver for associating napi with queue[s]
      netdev-genl: spec: Extend netdev netlink spec in YAML for NAPI
      net: Move kernel helpers for queue index outside sysfs
      netdev-genl: Add netlink framework functions for napi
      netdev-genl: spec: Add irq in netdev netlink YAML spec
      net: Add NAPI IRQ support
      netdev-genl: spec: Add PID in netdev netlink YAML spec
      netdev-genl: Add PID for the NAPI thread


 Documentation/netlink/specs/netdev.yaml   |   54 ++++++
 drivers/net/ethernet/intel/ice/ice_lib.c  |   60 ++++++
 drivers/net/ethernet/intel/ice/ice_lib.h  |    4 
 drivers/net/ethernet/intel/ice/ice_main.c |    4 
 include/linux/netdevice.h                 |   41 ++++
 include/uapi/linux/netdev.h               |   20 ++
 net/core/dev.c                            |   53 ++++++
 net/core/net-sysfs.c                      |   11 -
 net/core/netdev-genl-gen.c                |   17 ++
 net/core/netdev-genl-gen.h                |    2 
 net/core/netdev-genl.c                    |  270 +++++++++++++++++++++++++++++
 tools/include/uapi/linux/netdev.h         |   20 ++
 tools/net/ynl/generated/netdev-user.c     |  232 +++++++++++++++++++++++++
 tools/net/ynl/generated/netdev-user.h     |   67 +++++++
 tools/net/ynl/ynl-gen-c.py                |    2 
 15 files changed, 841 insertions(+), 16 deletions(-)

--

