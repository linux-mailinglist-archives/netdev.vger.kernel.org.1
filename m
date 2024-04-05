Return-Path: <netdev+bounces-85339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F6F89A53C
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 21:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80BF2283DED
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 19:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFCF174ED1;
	Fri,  5 Apr 2024 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZ0CFfG4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3829D173347
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712346682; cv=none; b=RxV9DJn1YDxtfM9OyIlzIys8p7Nr4whhHOp3HS5HB7h2RQtC0pCExwwmnOmEhLJAXe7tDYwfTK6cwiKaJyLbgb88mUE0y9zXngBV2rnV257+2kLWda9U1wdnk+wFuTJfjxsfaPtyYGfeIWvy48Y6vSLZoxDsjUPgErTOeKcLA50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712346682; c=relaxed/simple;
	bh=/au1sU+uR/i1GW+/jDnW5mMp4zXuodYvEHXrH2uVGPw=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=JP+Z4+dmXI9jg02BlklxM7ksALpQcq31q2CUMbFR7gPLLiCspzB4iFh6wio5uC6CkON0tOduY0XXmuipFsaDw9ARRRCwscSNL9lXmff+1F8b98zAhVrSJ+nE+cOyIdvQwkm9qk96Sb2pJXxRyPcoLLPDhdGlqRrROxR0YY9cHpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QZ0CFfG4; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712346682; x=1743882682;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/au1sU+uR/i1GW+/jDnW5mMp4zXuodYvEHXrH2uVGPw=;
  b=QZ0CFfG4sP/r1i1QGVzoqsT3x9kFROCIgOIBnGKfaSTSSDEHmd/HMOpC
   tSDCebGkv2TMEJa7exPFH9wNYCsMt9oyeRPwDiiLB1y8YnKa3+AeZKSH5
   BDKklndodOUiin/5KR8ezf1LpP7ZaUDrk7XNn3DoAf0TOGf2IbcDCgkgB
   6sCl/8gjuz/6zrjtyr7rUmoAp+GEIlUrh+0OFA9QDA3usd+VYkO4GdJ1e
   35e6D40885LrmyWzeCsMupfGSDRr5ULDfhcOWqj9Xp0yzvXDj4amWe1S+
   zWecghXBvoj19UM6zKcettB/dvDcQnKOIayl4PrXgfR1eIMbrZkebh7fg
   g==;
X-CSE-ConnectionGUID: 6ZG2If+nRpSbIWMRofPa+A==
X-CSE-MsgGUID: FDXeiFCQSYWnrB3rZI9AsA==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7817628"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="7817628"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 12:51:21 -0700
X-CSE-ConnectionGUID: OqSD04w0QxeGfY3BJc+V0Q==
X-CSE-MsgGUID: l7iANjJRQamfyoLpmxD0EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="19700633"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orviesa006.jf.intel.com with ESMTP; 05 Apr 2024 12:51:21 -0700
Subject: [net-next,RFC PATCH 0/5] Configuring NAPI instance for a queue
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net
Cc: edumazet@google.com, pabeni@redhat.com, ast@kernel.org, sdf@google.com,
 lorenzo@kernel.org, tariqt@nvidia.com, daniel@iogearbox.net,
 anthony.l.nguyen@intel.com, lucien.xin@gmail.com, hawk@kernel.org,
 sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Fri, 05 Apr 2024 13:09:28 -0700
Message-ID: <171234737780.5075.5717254021446469741.stgit@anambiarhost.jf.intel.com>
User-Agent: StGit/unknown-version
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Support user configurability of queue<->NAPI association. The netdev-genl
interface is extended with 'queue-set' command. Currently, the set
command enables associating a NAPI ID for a queue, but can also be extended
to support configuring other attributes. To set the NAPI attribute, the
command requires the queue identifiers and the ID of the NAPI instance that
the queue has to be associated with.

Previous discussion:
https://lore.kernel.org/netdev/32e32635-ca75-99b8-2285-1d87a29b6d89@intel.com/

Example:
$ ./cli.py --spec netdev.yaml --do queue-set  --json='{"ifindex": 12, "id": 0, "type": 0, "napi-id": 595}'
{'id': 0, 'ifindex': 12, 'napi-id': 595, 'type': 'rx'}

The queue<->NAPI association is achieved by mapping the queue to the
corresponding interrupt vector. This interface, thereby, exposes
configurability of the queue<->vector mapping.

The interface is generic such that any Tx or Rx queue[s] can be associated
with a NAPI instance. So, it is possible to have multiple queues (Tx queues
only, Rx queues only or both Tx and Rx queues) on a NAPI/vector. This is a
step away from the usual 1:1 queue<->vector model, although the queue-pair
association can still be retained by configuring the Tx[n]-Rx[n] queue-pair
to the same NAPI instance.

The usecase for configuring NAPI pollers to queues this way from the userspace
is to limit the number of pollers (by sharing multiple queues on a vector).
This allows to have more cores for application threads by reducing the cores
needed for poller threads.

Patch 1-2 introduces the kernel interface hooks to set the NAPI ID attribute
for a queue.
Patch 3-4 prepares the ice driver for device configuration. The queue<->vector
mapping configured from userspace would not be reflected in the HW unless the
queue is reset. Currently, the driver supports only reset of the entire VSI or
a queue-pair. Resetting the VSI for each queue configuration is an overkill.
So, add the ice driver support to reset a vector. Also, add support to handle
vectors that gets unused due to the dynamic nature of configurability.
Patch 5 implements the support for queue<->NAPI configuration in the ice driver.

Testing Hints:
1. Move a Rx queue from its current NAPI to a different NAPI during traffic
2. Move a Rx queue back to its initial NAPI during traffic
3. Move all Rx queues of NAPI-A to NAPI-B during traffic
4. Repeat the tests above for Tx queue
5. Move all Tx and Rx queues of a NAPI to a new NAPI during traffic
6. Move a queue to an unused NAPI during traffic

---

Amritha Nambiar (5):
      netdev-genl: spec: Extend netdev netlink spec in YAML for queue-set
      netdev-genl: Add netlink framework functions for queue-set NAPI
      ice: Add support to enable/disable a vector
      ice: Handle unused vectors dynamically
      ice: Add driver support for ndo_queue_set_napi


 Documentation/netlink/specs/netdev.yaml   |   20 +
 drivers/net/ethernet/intel/ice/ice.h      |   13 +
 drivers/net/ethernet/intel/ice/ice_lib.c  |  667 +++++++++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_lib.h  |   12 +
 drivers/net/ethernet/intel/ice/ice_main.c |   15 -
 drivers/net/ethernet/intel/ice/ice_xsk.c  |   34 -
 include/linux/netdevice.h                 |    7 
 include/uapi/linux/netdev.h               |    1 
 net/core/netdev-genl-gen.c                |   15 +
 net/core/netdev-genl-gen.h                |    1 
 net/core/netdev-genl.c                    |  120 +++++
 tools/include/uapi/linux/netdev.h         |    1 
 12 files changed, 845 insertions(+), 61 deletions(-)

--

