Return-Path: <netdev+bounces-16528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EB574DB4F
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 18:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FAD91C20B2C
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 16:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA26114262;
	Mon, 10 Jul 2023 16:40:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3B713AFC
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 16:40:46 +0000 (UTC)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C03C0
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689007245; x=1720543245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yuldbeEaCRbWThGzwfH7svk8OQc2dsWx0uOpjohIKbw=;
  b=Lth4O4jqazACD3ZkXk9sk0PAb7JZiSrqdkmdzDTMu7sjSGzruuBuGQns
   AF1cKr2/Amr4Tw6Ke9zNtUk7dpwC7fhE9gwqfkcfkNc+Wd34jd16NkqDN
   v4ZhmcWzJ0bQ+CO0VkE2MphJQ5gckbFIhkXZ7rSQPqqF6eu4z4VsIClws
   kwDwGNo7HIKHQqiWImLUllf7KbzWN0Ux/56U3A4bqRgks6cttTa63MhS3
   a6A/ewFAvNvXJHPah+WlT5w8pENCHDqFJdPYJd2dj2TjlCDJ5csO847tp
   I1ASTOCCuIn5vsA8WMEk1Pvne8+3/5mbcihlTlQjGwgbZdNwN4jl7Ulbs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="364431388"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="364431388"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 09:40:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="810867158"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="810867158"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jul 2023 09:40:43 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Florian Kauer <florian.kauer@linutronix.de>,
	anthony.l.nguyen@intel.com,
	kurt@linutronix.de,
	vinicius.gomes@intel.com,
	muhammad.husaini.zulkifli@intel.com,
	tee.min.tan@linux.intel.com,
	aravindhan.gunasekaran@intel.com,
	sasha.neftin@intel.com,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net 4/6] igc: No strict mode in pure launchtime/CBS offload
Date: Mon, 10 Jul 2023 09:35:01 -0700
Message-Id: <20230710163503.2821068-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710163503.2821068-1-anthony.l.nguyen@intel.com>
References: <20230710163503.2821068-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Florian Kauer <florian.kauer@linutronix.de>

The flags IGC_TXQCTL_STRICT_CYCLE and IGC_TXQCTL_STRICT_END
prevent the packet transmission over slot and cycle boundaries.
This is important for taprio offload where the slots and
cycles correspond to the slots and cycles configured for the
network.

However, the Qbv offload feature of the i225 is also used for
enabling TX launchtime / ETF offload. In that case, however,
the cycle has no meaning for the network and is only used
internally to adapt the base time register after a second has
passed.

Enabling strict mode in this case would unnecessarily prevent
the transmission of certain packets (i.e. at the boundary of a
second) and thus interferes with the ETF qdisc that promises
transmission at a certain point in time.

Similar to ETF, this also applies to CBS offload that also should
not be influenced by strict mode unless taprio offload would be
enabled at the same time.

This fully reverts
commit d8f45be01dd9 ("igc: Use strict cycles for Qbv scheduling")
but its commit message only describes what was already implemented
before that commit. The difference to a plain revert of that commit
is that it now copes with the base_time = 0 case that was fixed with
commit e17090eb2494 ("igc: allow BaseTime 0 enrollment for Qbv")

In particular, enabling strict mode leads to TX hang situations
under high traffic if taprio is applied WITHOUT taprio offload
but WITH ETF offload, e.g. as in

    sudo tc qdisc replace dev enp1s0 parent root handle 100 taprio \
	    num_tc 1 \
	    map 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 \
	    queues 1@0 \
	    base-time 0 \
	    sched-entry S 01 300000 \
	    flags 0x1 \
	    txtime-delay 500000 \
	    clockid CLOCK_TAI
    sudo tc qdisc replace dev enp1s0 parent 100:1 etf \
	    clockid CLOCK_TAI \
	    delta 500000 \
	    offload \
	    skip_sock_check

and traffic generator

    sudo trafgen -i traffic.cfg -o enp1s0 --cpp -n0 -q -t1400ns

with traffic.cfg

    #define ETH_P_IP        0x0800

    {
      /* Ethernet Header */
      0x30, 0x1f, 0x9a, 0xd0, 0xf0, 0x0e,  # MAC Dest - adapt as needed
      0x24, 0x5e, 0xbe, 0x57, 0x2e, 0x36,  # MAC Src  - adapt as needed
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
      10,  0, 48, 1,   # IP Src - adapt as needed
      10,  0, 48, 10,  # IP Dest - adapt as needed
      const16(5555),   # UDP Src Port
      const16(6666),   # UDP Dest Port
      const16(1008),   # UDP length (UDP header 8 bytes + payload length)
      csumudp(14, 34), # UDP checksum

      /* Payload */
      fill('W', 1000),
    }

and the observed message with that is for example

 igc 0000:01:00.0 enp1s0: Detected Tx Unit Hang
   Tx Queue             <0>
   TDH                  <d0>
   TDT                  <f0>
   next_to_use          <f0>
   next_to_clean        <d0>
 buffer_info[next_to_clean]
   time_stamp           <ffff661f>
   next_to_watch        <00000000245a4efb>
   jiffies              <ffff6e48>
   desc.status          <1048000>

Fixes: d8f45be01dd9 ("igc: Use strict cycles for Qbv scheduling")
Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_tsn.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index b76ebfc10b1d..a9c08321aca9 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -132,8 +132,28 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 		wr32(IGC_STQT(i), ring->start_time);
 		wr32(IGC_ENDQT(i), ring->end_time);
 
-		txqctl |= IGC_TXQCTL_STRICT_CYCLE |
-			IGC_TXQCTL_STRICT_END;
+		if (adapter->taprio_offload_enable) {
+			/* If taprio_offload_enable is set we are in "taprio"
+			 * mode and we need to be strict about the
+			 * cycles: only transmit a packet if it can be
+			 * completed during that cycle.
+			 *
+			 * If taprio_offload_enable is NOT true when
+			 * enabling TSN offload, the cycle should have
+			 * no external effects, but is only used internally
+			 * to adapt the base time register after a second
+			 * has passed.
+			 *
+			 * Enabling strict mode in this case would
+			 * unnecessarily prevent the transmission of
+			 * certain packets (i.e. at the boundary of a
+			 * second) and thus interfere with the launchtime
+			 * feature that promises transmission at a
+			 * certain point in time.
+			 */
+			txqctl |= IGC_TXQCTL_STRICT_CYCLE |
+				IGC_TXQCTL_STRICT_END;
+		}
 
 		if (ring->launchtime_enable)
 			txqctl |= IGC_TXQCTL_QUEUE_MODE_LAUNCHT;
-- 
2.38.1


