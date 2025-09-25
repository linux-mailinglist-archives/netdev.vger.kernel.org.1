Return-Path: <netdev+bounces-226412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F648B9FF31
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 16:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371F71B21C2D
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 14:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357012248A4;
	Thu, 25 Sep 2025 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="FBqAIEjf"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E124C98;
	Thu, 25 Sep 2025 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809627; cv=none; b=o/lqE4eYwxejBx+OZjj0khZvu3uVd1LKq/e5LCwmyrI1x9L5URlacVTSMMNzEHoEqGpTynf8GpKlc7akbkP0VY+R8o9hbM3yz45UfUva84mWdCxgKuI/Nh9dxPjto1GqqjvyWSPAFkPWDyIGdc136FIx5yALBcsVE++eOBTG9S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809627; c=relaxed/simple;
	bh=oQeUG9XGk5RTE/O8XVegSIwupJtyQgWbuQrCJEyfMNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TYKADN1t2SeK/NDq/A0yb60ofRTZ4D3J5Yn7YXQtveO0gv58M7pYk+5EB7xY90mto8PWMj6RWO5Ar4UMYbKtcgGsRcql0PXx05B+gLLzxO1FWWX9q+cks1uvL0Nlnb+bgjIDaiG4cZvQlgj3S4d9mLUi3htn1fQdjqmIDTG1wFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=FBqAIEjf; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=I0t7ozr8R0y7L7Ia/qOG5GKnLAJmLy1UlDO9kkxmSJw=; b=FBqAIEjfEYjB7gCRJfZ/zgmY87
	mDOE39iI2LRBclqTdgQT8ldj1khf6g/FtegjZwMwBmxWPg3NWSBPyQcLNdqfLHPLXfePo1xaAHkY9
	KfmAG1sJ/aY5STKe7z/qdgv+mkX4jlHWJqmjOnvzV6poZBfgZ8E61G6plgkdEUcruFyq0izcToLpA
	s2q6bw8X1ZiL0bt16WdLnmnB8BbX/cyg6vjVaULT/Hc6blqANh6c9GxC6n8P9l5foJ1z7KZPj6gRc
	HrUteKtA3XlO17gu+R0q7g0yT3w51lN8TqEiTuXdcv5F85OEPR6YWXCG9y5xr6xH6IqFx1MbnKfyT
	LQz9WM8A==;
Received: from [122.175.9.182] (port=9537 helo=cypher.couthit.local)
	by server.couthit.com with esmtpa (Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1v1mj2-00000005fRb-1Afp;
	Thu, 25 Sep 2025 10:13:36 -0400
From: Parvathi Pudi <parvathi@couthit.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	danishanwar@ti.com,
	parvathi@couthit.com,
	rogerq@kernel.org,
	pmohan@couthit.com,
	basharath@couthit.com,
	afd@ti.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	pratheesh@ti.com,
	prajith@ti.com,
	vigneshr@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	rogerq@ti.com,
	krishna@couthit.com,
	mohan@couthit.com
Subject: [PATCH net-next 0/3] RSTP SWITCH support for PRU-ICSSM Ethernet driver
Date: Thu, 25 Sep 2025 19:32:09 +0530
Message-ID: <20250925141246.3433603-1-parvathi@couthit.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: parvathi@couthit.com
X-Authenticated-Sender: server.couthit.com: parvathi@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi,

The DUAL-EMAC patch series for Megabit Industrial Communication Sub-system
(ICSSM), which provides the foundational support for Ethernet functionality
over PRU-ICSS on the TI SOCs (AM335x, AM437x, and AM57x), was merged into
net-next recently [1].

This patch series enhances the PRU-ICSSM Ethernet driver to support
RSTP SWITCH mode, which has been implemented based on "switchdev" and
interacts with "mstp daemon" to support Rapid Spanning Tree Protocol
(RSTP) as well.

Once the RSTP SWITCH mode is enabled, forwarding of Ethernet packets using
either the traditional store-and-forward mechanism or via cut-through is
offloaded to the two PRU based Ethernet interfaces available within the
ICSSM. The firmware running on the PRU inspects the STP port states and
performs multiple checks before forwarding a packet. This improves the
overall system performance and significantly reduces the packet forwarding
latency.

Protocol switching from dual EMAC to RSTP SWITCH mode can be done as follows.

Assuming eth2 and eth3 are the two physical ports of the ICSS2 instance:

>> brctl addbr br0
>> ip maddr add 01:80:c2:00:00:00 dev br0
>> ip link set dev br0 address $(cat /sys/class/net/eth2/address)
>> brctl addif br0 eth2
>> brctl addif br0 eth3
>> mstpd
>> brctl stp br0 on
>> mstpctl setforcevers br0 rstp
>> ip link set dev br0 up

To revert back to the default dual EMAC mode, the steps are as follows:

>> ip link set dev br0 down
>> brctl delif br0 eth2
>> brctl delif br0 eth3
>> brctl delbr br0

The patches presented in this series have gone through the patch verification
tools and no warnings or errors are reported.

Sample test logs obtained from AM33x, AM43x and AM57x verifying the
functionality on Linux next kernel are available here:

[Interface up Testing](https://gist.github.com/ParvathiPudi/ee90d6f7778f01660eec714d128ee224)

[Ping Testing](https://gist.github.com/ParvathiPudi/ea7fc58da454b9c1d15517f84a502ae2)

[Iperf Testing](https://gist.github.com/ParvathiPudi/505d8c6e9de231098215c59b66dee20b)

[1] https://lore.kernel.org/all/20250912104741.528721-1-parvathi@couthit.com/

Thanks and Regards,
Parvathi.

Roger Quadros (3):
  net: ti: icssm-prueth: Adds helper functions to configure and maintain
    FDB
  net: ti: icssm-prueth: Adds switchdev support for icssm_prueth driver
  net: ti: icssm-prueth: Adds support for ICSSM RSTP switch

 drivers/net/ethernet/ti/Makefile              |   2 +-
 drivers/net/ethernet/ti/icssm/icssm_prueth.c  | 554 +++++++++-
 drivers/net/ethernet/ti/icssm/icssm_prueth.h  |  27 +-
 .../ethernet/ti/icssm/icssm_prueth_fdb_tbl.h  |  66 ++
 .../ethernet/ti/icssm/icssm_prueth_switch.c   | 999 ++++++++++++++++++
 .../ethernet/ti/icssm/icssm_prueth_switch.h   |  37 +
 drivers/net/ethernet/ti/icssm/icssm_switch.h  |  82 ++
 .../net/ethernet/ti/icssm/icssm_switchdev.c   | 332 ++++++
 .../net/ethernet/ti/icssm/icssm_switchdev.h   |  13 +
 .../ti/icssm/icssm_vlan_mcast_filter_mmap.h   | 120 +++
 10 files changed, 2209 insertions(+), 23 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_fdb_tbl.h
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_switch.h
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_switchdev.c
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_switchdev.h
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_vlan_mcast_filter_mmap.h

-- 
2.43.0


