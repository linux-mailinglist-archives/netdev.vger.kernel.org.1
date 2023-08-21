Return-Path: <netdev+bounces-29470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C0478361E
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 01:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0252F1C20925
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 23:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4D9174E8;
	Mon, 21 Aug 2023 23:10:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810EB23DF
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 23:10:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE03130
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 16:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692659404; x=1724195404;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PDTZ+k98H3gZ4oU7x6/EZWF4QoZeRIf5yXTv49u1QB4=;
  b=lHEBTcYG+WwEHDyfe2DxJe4pWEaGp6Vuy/9VFon9uYIYylaM3mnjz23o
   0X5nnY2aXDc8oE1r2oRmGudfMOaVmEgTb6lPKTULZJxMicKIl+PXG+T/0
   MICNm8LbjGf7r7fcLdNPtCvQmv6Zar4mGWen/7ACrCWY4wwTKtxHDBNhI
   HN9loUGQiWpbBnqrwiuJKA+NAzj9P95gw4SiiS9/fwajF9tPdvUxorbJU
   dQ0aGrs8NoljGkGgsUm8AP6ZvcTDhwE/Xe02UYKFajsVmK9fNDqOOc7K5
   nCdAuDEDAIsOhLaTWeBcJwbwFNM4tSGcOdQncAECBccjbSFHk0DDpix8s
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="404723860"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="404723860"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 16:10:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="765543020"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="765543020"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orsmga008.jf.intel.com with ESMTP; 21 Aug 2023 16:10:03 -0700
Subject: [net-next PATCH v2 0/9] Introduce NAPI queues support
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Mon, 21 Aug 2023 16:25:09 -0700
Message-ID: <169266003844.10199.10450480941022607696.stgit@anambiarhost.jf.intel.com>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Introduce support for associating NAPI instances with
corresponding RX and TX queue set. Add the capability
to export NAPI information supported by the device.
Extend the netdev_genl generic netlink family for netdev
with NAPI data. The NAPI fields exposed are:
- NAPI id
- NAPI device ifindex
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

$ ./cli.py --spec netdev.yaml --do napi-get --json='{"napi-id": 385}'
{'ifindex': 12,
 'irq': 291,
 'napi-id': 385,
 'pid': 3614,
 'rx-queues': [0],
 'tx-queues': [0]}

$ ./cli.py --spec netdev.yaml --dump napi-get --json='{"ifindex": 12}'
[{'ifindex': 12,
  'irq': 294,
  'napi-id': 596,
  'pid': 12361,
  'rx-queues': [3],
  'tx-queues': [3]},
 {'ifindex': 12,
  'irq': 293,
  'napi-id': 595,
  'pid': 12360,
  'rx-queues': [2],
  'tx-queues': [2]},
 {'ifindex': 12,
  'irq': 292,
  'napi-id': 594,
  'pid': 12359,
  'rx-queues': [1],
  'tx-queues': [1]},
 {'ifindex': 12,
  'irq': 291,
  'napi-id': 593,
  'pid': 12358,
  'rx-queues': [0],
  'tx-queues': [0]}]

v2 -> v1
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


 Documentation/netlink/specs/netdev.yaml   |   52 ++++++++
 drivers/net/ethernet/intel/ice/ice_lib.c  |   60 ++++++++++
 drivers/net/ethernet/intel/ice/ice_lib.h  |    4 +
 drivers/net/ethernet/intel/ice/ice_main.c |    4 -
 include/linux/netdevice.h                 |   34 +++++
 include/net/netdev_rx_queue.h             |    7 +
 include/uapi/linux/netdev.h               |   13 ++
 net/core/dev.c                            |   53 ++++++++
 net/core/net-sysfs.c                      |   11 --
 net/core/netdev-genl-gen.c                |   24 ++++
 net/core/netdev-genl-gen.h                |    2 
 net/core/netdev-genl.c                    |  182 +++++++++++++++++++++++++++++
 tools/include/uapi/linux/netdev.h         |   13 ++
 tools/net/ynl/generated/netdev-user.c     |  177 ++++++++++++++++++++++++++++
 tools/net/ynl/generated/netdev-user.h     |   83 +++++++++++++
 tools/net/ynl/ynl-gen-c.py                |    2 
 16 files changed, 704 insertions(+), 17 deletions(-)

--

