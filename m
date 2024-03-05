Return-Path: <netdev+bounces-77640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A773A87271E
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 19:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368C71F29DF4
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 18:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B7F86644;
	Tue,  5 Mar 2024 18:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dSC+9zPM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC42C433AE;
	Tue,  5 Mar 2024 18:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665070; cv=none; b=ksWlCGpUu0qEb9bI1cM2ObfHvOTabTdTic/a3tJjfNU/l+ng1XdGsGUZ6zq/nMsOE9f7O1j50URl8Cf0rryWLznVNelykjq+m2H4SVXFCY3iV+wz4Qj6XUVjolsZUCyq5mqqGFi39eyBJ5tCxzttH64t6TMmrK29wHNIjp0l7Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665070; c=relaxed/simple;
	bh=x4eqt+1IRedySbHWBOOSEyKBNBVYN42H+1RYZYZUiuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnba7Qdqwfxs/5JqCQ3MawOejR5OvgZ8HAz+zFH+KbKGd4Mp+Pmi4G0RpX9Dl/SGg3WiOFq6wPfiMCafjQgZfnHUBI/YNcWWm3coyy9C5hf/KhdykwnBI62TmVp6xbYneCrHo/7ioK5j0HO8yNjTbKznfyrs5qvRl6O/QpJOY1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dSC+9zPM; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709665069; x=1741201069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x4eqt+1IRedySbHWBOOSEyKBNBVYN42H+1RYZYZUiuw=;
  b=dSC+9zPM9NuJP7WG6WvxqKAKmM2wZe/GQUv8IT4/AC4+2lwoYTYzXvdZ
   KHNf4UXKqFJX9E9zx88xvHtL7XaNwvYqU5z/6UiLMIb8IH+J8m204Jo+O
   sU3ZlLTV3G4Lj09pqwt5l8Ie7CHOHbJ+kKhc57Q7aajZ2RmqCgqm5tPa6
   P8DRdMhIlDHkpPubE0bUzMIZ9UuC0MAuDppDicesrIkn8da1nAM26WRAC
   BdBa3Dis8hu/W320DHGplYwNPpULPWHtjoaTS7KW8wzavrjE7FoBaZLo8
   wD96nG4zLGtsbHnlViq+acYBBoluM5RqhPvt/iUebUyOdknrn8B3hGXDB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4822219"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="4822219"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 10:57:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="9337229"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 05 Mar 2024 10:57:44 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Florian Kauer <florian.kauer@linutronix.de>,
	anthony.l.nguyen@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	sasha.neftin@intel.com,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net 7/8] igc: avoid returning frame twice in XDP_REDIRECT
Date: Tue,  5 Mar 2024 10:57:35 -0800
Message-ID: <20240305185737.3925349-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240305185737.3925349-1-anthony.l.nguyen@intel.com>
References: <20240305185737.3925349-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Kauer <florian.kauer@linutronix.de>

When a frame can not be transmitted in XDP_REDIRECT
(e.g. due to a full queue), it is necessary to free
it by calling xdp_return_frame_rx_napi.

However, this is the responsibility of the caller of
the ndo_xdp_xmit (see for example bq_xmit_all in
kernel/bpf/devmap.c) and thus calling it inside
igc_xdp_xmit (which is the ndo_xdp_xmit of the igc
driver) as well will lead to memory corruption.

In fact, bq_xmit_all expects that it can return all
frames after the last successfully transmitted one.
Therefore, break for the first not transmitted frame,
but do not call xdp_return_frame_rx_napi in igc_xdp_xmit.
This is equally implemented in other Intel drivers
such as the igb.

There are two alternatives to this that were rejected:
1. Return num_frames as all the frames would have been
   transmitted and release them inside igc_xdp_xmit.
   While it might work technically, it is not what
   the return value is meant to represent (i.e. the
   number of SUCCESSFULLY transmitted packets).
2. Rework kernel/bpf/devmap.c and all drivers to
   support non-consecutively dropped packets.
   Besides being complex, it likely has a negative
   performance impact without a significant gain
   since it is anyway unlikely that the next frame
   can be transmitted if the previous one was dropped.

The memory corruption can be reproduced with
the following script which leads to a kernel panic
after a few seconds.  It basically generates more
traffic than a i225 NIC can transmit and pushes it
via XDP_REDIRECT from a virtual interface to the
physical interface where frames get dropped.

   #!/bin/bash
   INTERFACE=enp4s0
   INTERFACE_IDX=`cat /sys/class/net/$INTERFACE/ifindex`

   sudo ip link add dev veth1 type veth peer name veth2
   sudo ip link set up $INTERFACE
   sudo ip link set up veth1
   sudo ip link set up veth2

   cat << EOF > redirect.bpf.c

   SEC("prog")
   int redirect(struct xdp_md *ctx)
   {
       return bpf_redirect($INTERFACE_IDX, 0);
   }

   char _license[] SEC("license") = "GPL";
   EOF
   clang -O2 -g -Wall -target bpf -c redirect.bpf.c -o redirect.bpf.o
   sudo ip link set veth2 xdp obj redirect.bpf.o

   cat << EOF > pass.bpf.c

   SEC("prog")
   int pass(struct xdp_md *ctx)
   {
       return XDP_PASS;
   }

   char _license[] SEC("license") = "GPL";
   EOF
   clang -O2 -g -Wall -target bpf -c pass.bpf.c -o pass.bpf.o
   sudo ip link set $INTERFACE xdp obj pass.bpf.o

   cat << EOF > trafgen.cfg

   {
     /* Ethernet Header */
     0xe8, 0x6a, 0x64, 0x41, 0xbf, 0x46,
     0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
     const16(ETH_P_IP),

     /* IPv4 Header */
     0b01000101, 0,   # IPv4 version, IHL, TOS
     const16(1028),   # IPv4 total length (UDP length + 20 bytes (IP header))
     const16(2),      # IPv4 ident
     0b01000000, 0,   # IPv4 flags, fragmentation off
     64,              # IPv4 TTL
     17,              # Protocol UDP
     csumip(14, 33),  # IPv4 checksum

     /* UDP Header */
     10,  0, 1, 1,    # IP Src - adapt as needed
     10,  0, 1, 2,    # IP Dest - adapt as needed
     const16(6666),   # UDP Src Port
     const16(6666),   # UDP Dest Port
     const16(1008),   # UDP length (UDP header 8 bytes + payload length)
     csumudp(14, 34), # UDP checksum

     /* Payload */
     fill('W', 1000),
   }
   EOF

   sudo trafgen -i trafgen.cfg -b3000MB -o veth1 --cpp

Fixes: 4ff320361092 ("igc: Add support for XDP_REDIRECT action")
Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index ba8d3fe186ae..81c21a893ede 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6487,7 +6487,7 @@ static int igc_xdp_xmit(struct net_device *dev, int num_frames,
 	int cpu = smp_processor_id();
 	struct netdev_queue *nq;
 	struct igc_ring *ring;
-	int i, drops;
+	int i, nxmit;
 
 	if (unlikely(!netif_carrier_ok(dev)))
 		return -ENETDOWN;
@@ -6503,16 +6503,15 @@ static int igc_xdp_xmit(struct net_device *dev, int num_frames,
 	/* Avoid transmit queue timeout since we share it with the slow path */
 	txq_trans_cond_update(nq);
 
-	drops = 0;
+	nxmit = 0;
 	for (i = 0; i < num_frames; i++) {
 		int err;
 		struct xdp_frame *xdpf = frames[i];
 
 		err = igc_xdp_init_tx_descriptor(ring, xdpf);
-		if (err) {
-			xdp_return_frame_rx_napi(xdpf);
-			drops++;
-		}
+		if (err)
+			break;
+		nxmit++;
 	}
 
 	if (flags & XDP_XMIT_FLUSH)
@@ -6520,7 +6519,7 @@ static int igc_xdp_xmit(struct net_device *dev, int num_frames,
 
 	__netif_tx_unlock(nq);
 
-	return num_frames - drops;
+	return nxmit;
 }
 
 static void igc_trigger_rxtxq_interrupt(struct igc_adapter *adapter,
-- 
2.41.0


