Return-Path: <netdev+bounces-241899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F1EC89D93
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 13:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA1313B2F2C
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 12:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B143717A2E6;
	Wed, 26 Nov 2025 12:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="J7CGlAGI"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D35027462;
	Wed, 26 Nov 2025 12:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764161202; cv=none; b=RqTgcmvrO/ycI+k9EHF7P7glXwRcdEgMus42qdknzQn0mlScfV+K0rES0HY9IF7QuKIhlmUWq5iq5IsJakPU/cZwy3lD7V+gTnsq8xQ5dWvwpLYBiDduWTuphFhNmZdl6yjx3XZAzhuicqUiVjpIKRlWMTWR3NN1+LNSPDbDVcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764161202; c=relaxed/simple;
	bh=9YHrNOoT2Mqw9BQJ9/yu9eVaaO7ZwgULe9YF9xcYOvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QohOf9/r9t3JtMNgcxEdqKcTbE3a0RH5OVHL/kbpkfVM090X/cyESEjN1JZ1CEau4qM/HHDXq0CbUnR7qzOzLasc/S6EDCZakAB8YKk+XBXoai/HPTB0W9UjQYgzvvNLLDI4QN87shZ94R43pvZ0t7DjBxYOJf3fEzEgAKAHZDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=J7CGlAGI; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fouBHXkYq1jKxUVMFoPGNaZP6tNfUs3+u20LuZ/Yr+0=; b=J7CGlAGIvlh4JZEv8uxv2WhrWf
	fI5JgzY5jCQhrqz0QSLiUNXhFAVqSsA87UZ1mVqIP6uv9I9QYSSNVXlBX0bxaZF0kglKE2sWbRwRa
	9SLWdQzpRoAibGkG0VX33UjLaSwJpfHErdbcPMdIqxYDTqaNL2WyOH7/HkcCwF4JYK6MoBfj2KXRB
	K/bD0kJXqKYqOJuJKeMemxsI1BqZQDcAsHpYD4jmp1nm8he5JoXL439gzTsSr/vRZV+iDLJ8Gjgri
	HykZOnzr1DQrUNbFowAL56Tw/GsNhCvPuqNz7EtbdZ4ubVYa6/E4r/g+KRtyv+BhU7FjCAoPvcOyW
	wQ3uvQHg==;
Received: from [122.175.9.182] (port=35239 helo=cypher.couthit.local)
	by server.couthit.com with esmtpa (Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1vOEur-0000000ClrJ-0IEX;
	Wed, 26 Nov 2025 07:46:37 -0500
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
	alok.a.tiwari@oracle.com,
	horms@kernel.org,
	pratheesh@ti.com,
	j-rameshbabu@ti.com,
	vigneshr@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	rogerq@ti.com,
	krishna@couthit.com,
	mohan@couthit.com
Subject: [PATCH net-next v7 0/3] STP/RSTP SWITCH support for PRU-ICSSM Ethernet driver
Date: Wed, 26 Nov 2025 18:14:19 +0530
Message-ID: <20251126124602.2624264-1-parvathi@couthit.com>
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

This patch series enhances the PRU-ICSSM Ethernet driver to support bridge
(STP/RSTP) SWITCH mode, which has been implemented using the "switchdev"
framework and interacts with the "mstp daemon" for STP and RSTP management
in userspace.

When the  SWITCH mode is enabled, forwarding of Ethernet packets using
either the traditional store-and-forward mechanism or via cut-through is
offloaded to the two PRU based Ethernet interfaces available within the
ICSSM. The firmware running on the PRU inspects the bridge port states and
performs necessary checks before forwarding a packet. This improves the
overall system performance and significantly reduces the packet forwarding
latency.

Protocol switching from Dual-EMAC to bridge (STP/RSTP) SWITCH mode can be
done as follows.

Assuming eth2 and eth3 are the two physical ports of the ICSS2 instance:

>> brctl addbr br0
>> ip maddr add 01:80:c2:00:00:00 dev br0
>> ip link set dev br0 address $(cat /sys/class/net/eth2/address)
>> brctl addif br0 eth2
>> brctl addif br0 eth3
>> mstpd
>> brctl stp br0 on
# STP to RSTP mode
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

[Interface up Testing](https://gist.github.com/ParvathiPudi/f8936dbecd14aaec841b9920d1d1877a)

[Ping Testing](https://gist.github.com/ParvathiPudi/3f9c3f0eb925ab5c8ddc10f0503be8d1)

[Iperf Testing](https://gist.github.com/ParvathiPudi/1715a4772c3b90e9ac168a5ce266b63e)

[1] https://lore.kernel.org/all/20250912104741.528721-1-parvathi@couthit.com/

This is the v7 of the patch series [v1]. This version of the patchset
addresses the comments made on [v6] of the series.

Changes from v6 to v7:

*) Addressed Jakub Kicinski comments on patch 2 of the series.
*) Rebased the series on latest net-next.

Changes from v5 to v6:

*) Addressed Simon Horman comments on patch 1, 2 and 3 of the series.
*) Rebased the series on latest net-next.

Changes from v4 to v5:

*) Addressed ALOK TIWARI comments on patch 1 of the series.
*) Rebased the series on latest net-next.

Changes from v3 to v4:

*) Addressed Andrew Lunn comments on patch 1 and 2 of the series.
*) Rebased the series on latest net-next.

Changes from v2 to v3:

*) Dropped the RFC tag.
*) Addressed  MD Danish Anwar comments on patch 3 of the series.
*) Rebased the series on latest net-next.

Changes from v1 to v2 :

*) Added RFC tag as net-next is closed now.
*) Updated the cover letter of the series to generalize and indicate support for
both STP and RSTP along with subject change as per Andrew Lunn's suggestion.
*) Addressed the Andrew Lunn's comments on patch 1 of the series.
*) Rebased the series on latest net-next.

[v1] https://lore.kernel.org/all/20250925141246.3433603-1-parvathi@couthit.com/
[v2] https://lore.kernel.org/all/20251006104908.775891-1-parvathi@couthit.com/
[v3] https://lore.kernel.org/all/20251014124018.1596900-1-parvathi@couthit.com/
[v4] https://lore.kernel.org/all/20251110125539.31052-1-parvathi@couthit.com/
[v5] https://lore.kernel.org/all/20251113101229.675141-1-parvathi@couthit.com/
[v6] https://lore.kernel.org/all/20251124135800.2219431-1-parvathi@couthit.com/

Thanks and Regards,
Parvathi.

Roger Quadros (3):
  net: ti: icssm-prueth: Add helper functions to configure and maintain
    FDB
  net: ti: icssm-prueth: Add switchdev support for icssm_prueth driver
  net: ti: icssm-prueth: Add support for ICSSM RSTP switch

 drivers/net/ethernet/ti/Makefile              |    2 +-
 drivers/net/ethernet/ti/icssm/icssm_prueth.c  |  517 +++++++-
 drivers/net/ethernet/ti/icssm/icssm_prueth.h  |   20 +-
 .../ethernet/ti/icssm/icssm_prueth_fdb_tbl.h  |   76 ++
 .../ethernet/ti/icssm/icssm_prueth_switch.c   | 1062 +++++++++++++++++
 .../ethernet/ti/icssm/icssm_prueth_switch.h   |   37 +
 drivers/net/ethernet/ti/icssm/icssm_switch.h  |  103 ++
 .../net/ethernet/ti/icssm/icssm_switchdev.c   |  338 ++++++
 .../net/ethernet/ti/icssm/icssm_switchdev.h   |   13 +
 .../ti/icssm/icssm_vlan_mcast_filter_mmap.h   |  120 ++
 10 files changed, 2265 insertions(+), 23 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_fdb_tbl.h
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_switch.h
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_switchdev.c
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_switchdev.h
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_vlan_mcast_filter_mmap.h

-- 
2.43.0


