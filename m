Return-Path: <netdev+bounces-137671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 092D79A9421
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 01:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9824BB21361
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 23:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12661FF041;
	Mon, 21 Oct 2024 23:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fR47LIds"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B3E1FDFA7
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 23:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729553193; cv=none; b=ikadgV1Ua9bw+x8LHrH3eG1yU1RqjTJTGmYqkkuZW6Ac1eFinPPuStQg68hXuwTByl++/nvOkbziGJyKHsZfdW16BqNqaumPHxDn9btCw+ma0PxmEfpIiYj+fmeX8dY25FC7nFoxTg6sEyd+JsbNrs888ydxE48sZN/Eeo5Flz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729553193; c=relaxed/simple;
	bh=T6Xdhp+QGxzi75hIfIiSpf5fDPg8pdEiGB00dxKLu0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lE8I9LpQvgJmyMvC2ibw0eD70071qu9McNzUL7WZTb4NuVNcZ6UIcGKWcATQUb9VCzrLlR7HKQ8E20jmWW+8WrAk1z2OKSp6YSrxaemXaCycqz91VASkvsWEbpwfROjqRoLxRupTQom4vF/bX1WvVxNyFYSkb/N2z4Qshn4MFyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fR47LIds; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729553192; x=1761089192;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=T6Xdhp+QGxzi75hIfIiSpf5fDPg8pdEiGB00dxKLu0Q=;
  b=fR47LIdsZaVf8/Jq84Dnpb9EvqcNwo2SaIwZI7KY3tf+53IC1T7abKbj
   DE8M3OUEBpjx6n9ejxmYfXvVgYf18QD+UiC2dFDYDnj86A3M7LaCxI1k2
   WSQ5Gmj0fbj7nvzpt62THR3aGQWuaLSnHZrMr2f/LH9xFLhqGucfQk1ht
   sZmk6ye5w7p3dnbzfjVWkRPtsu68VAaH3p0m5d7zyI2Gj8qFiWU8ljnJY
   D6k0EGZCQ6UWglIMoLyNmmICX1OOxOiKgEip4TNx+vYLGPGCiVBQyA9C2
   DnyA/bj8C5iK3+UzTk19uNXHaoP1FRJdwRB/f/l0xWA6vKEQfR44Mmxd+
   A==;
X-CSE-ConnectionGUID: wyGbaRAiTyizm/BK2dK4+A==
X-CSE-MsgGUID: w5JYx9oqR4G+Wi9LczfVBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="31927041"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="31927041"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 16:26:30 -0700
X-CSE-ConnectionGUID: U8jrkRCvRsSRsFd3DYn2ZA==
X-CSE-MsgGUID: uJ8yYuQ/TD2Xi3OJ1vPceA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="79761741"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 16:26:30 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 21 Oct 2024 16:26:24 -0700
Subject: [PATCH net 1/3] igb: Disable threaded IRQ for igb_msix_other
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-iwl-2024-10-21-iwl-net-fixes-v1-1-a50cb3059f55@intel.com>
References: <20241021-iwl-2024-10-21-iwl-net-fixes-v1-0-a50cb3059f55@intel.com>
In-Reply-To: <20241021-iwl-2024-10-21-iwl-net-fixes-v1-0-a50cb3059f55@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jeff Garzik <jgarzik@redhat.com>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 Piotr Raczynski <piotr.raczynski@intel.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Milena Olech <milena.olech@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Michal Michalik <michal.michalik@intel.com>, 
 netdev <netdev@vger.kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Jacob Keller <jacob.e.keller@intel.com>, 
 Wander Lairson Costa <wander@redhat.com>, Yuying Ma <yuma@redhat.com>, 
 Rafal Romanowski <rafal.romanowski@intel.com>
X-Mailer: b4 0.14.1

From: Wander Lairson Costa <wander@redhat.com>

During testing of SR-IOV, Red Hat QE encountered an issue where the
ip link up command intermittently fails for the igbvf interfaces when
using the PREEMPT_RT variant. Investigation revealed that
e1000_write_posted_mbx returns an error due to the lack of an ACK
from e1000_poll_for_ack.

The underlying issue arises from the fact that IRQs are threaded by
default under PREEMPT_RT. While the exact hardware details are not
available, it appears that the IRQ handled by igb_msix_other must
be processed before e1000_poll_for_ack times out. However,
e1000_write_posted_mbx is called with preemption disabled, leading
to a scenario where the IRQ is serviced only after the failure of
e1000_write_posted_mbx.

To resolve this, we set IRQF_NO_THREAD for the affected interrupt,
ensuring that the kernel handles it immediately, thereby preventing
the aforementioned error.

Reproducer:

    #!/bin/bash

    # echo 2 > /sys/class/net/ens14f0/device/sriov_numvfs
    ipaddr_vlan=3
    nic_test=ens14f0
    vf=${nic_test}v0

    while true; do
	    ip link set ${nic_test} mtu 1500
	    ip link set ${vf} mtu 1500
	    ip link set $vf up
	    ip link set ${nic_test} vf 0 vlan ${ipaddr_vlan}
	    ip addr add 172.30.${ipaddr_vlan}.1/24 dev ${vf}
	    ip addr add 2021:db8:${ipaddr_vlan}::1/64 dev ${vf}
	    if ! ip link show $vf | grep 'state UP'; then
		    echo 'Error found'
		    break
	    fi
	    ip link set $vf down
    done

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Fixes: 9d5c824399de ("igb: PCI-Express 82575 Gigabit Ethernet driver")
Reported-by: Yuying Ma <yuma@redhat.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index f1d088168723..b83df5f94b1f 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -907,7 +907,7 @@ static int igb_request_msix(struct igb_adapter *adapter)
 	int i, err = 0, vector = 0, free_vector = 0;
 
 	err = request_irq(adapter->msix_entries[vector].vector,
-			  igb_msix_other, 0, netdev->name, adapter);
+			  igb_msix_other, IRQF_NO_THREAD, netdev->name, adapter);
 	if (err)
 		goto err_out;
 

-- 
2.47.0.265.g4ca455297942


