Return-Path: <netdev+bounces-248445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEFED08913
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 11:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DEA630056EF
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 10:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70887337BB4;
	Fri,  9 Jan 2026 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YMnybweT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F8D2D5A19;
	Fri,  9 Jan 2026 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767954692; cv=none; b=FUfVoB2Q3qiAMBhdtwiDjTZzTFPQI3GF8X9/+m7H9q/1/fiT5aMHeP797741Bac2yVLgUSs14PUh3IfbPKRyQCCEimfWd+rZKIFpfnPAz9w2vMoGfb8+uqwgk5lWsZSgaR3zFLGVRcrgCOyJPiFSOfUQrHLfrUTy5h+uDb7n9I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767954692; c=relaxed/simple;
	bh=EfFw6MozRHj1qEFaG0+tPEHxBQwyyGpVCIJCA5Ltyyo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kVRXqqBNMXQUxsyxlkuy0V7b6oLkqEk1N6f5D8n/pDx+e2xMwVqhwWtp/gMP/yckes62K9OoZAfnP2paJRv8ZUwYxgNo2nNtERRu+yRmPAYRkdYTHKQGJ/uyKlUFZtxifMKF8ygVJxzUcwJdOthUhkJmeDkDi48YtBHp9NOcY2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YMnybweT; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6093EZqd2938365;
	Fri, 9 Jan 2026 02:31:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=PIUSnERMq5fvelkdbrtClP8
	XhrG2FEcGHgk00Kw+0tI=; b=YMnybweT/w280JZYjg46tErj3OwL9mcIcQrzDDW
	6q0+yUzJFs34FZsUG5ugHWMPq7AB4VmZ3MPAbl8TBs5I0wO+djyYfqp9pHlHmiTx
	LZevvTjE7SQAwEcKPt46ODOrdwZPLX7OANOqLi9P1R2ZSUjSZIM+cnQd3sktqcaB
	3m4OJILZkDUgzfSpNOopmKfhdSN6nTdX0PqU/NFFAfzSNH3iFscYd0Xgck1zf8yz
	4i9atzrB0Ezko+LpQYrMg19d3GZImMld+C1hH3dET84zXvG4IauLKepvwMPIGnww
	uXAtdF0OxsMaidt+PWPizVu7WiONktHXLWEpEGWaMIUFNzA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bhwh2vmv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Jan 2026 02:31:21 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 9 Jan 2026 02:31:20 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 9 Jan 2026 02:31:20 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id C36A83F7089;
	Fri,  9 Jan 2026 02:31:16 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net-next v3 00/10] Switch support
Date: Fri, 9 Jan 2026 16:00:25 +0530
Message-ID: <20260109103035.2972893-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: lHrIpN_YkO9UkAfSF_9r-FsBhglW1ocx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA3NiBTYWx0ZWRfX3hcRiZ8ZtHJ4
 rcRlyNmVQeMHctKkRkdgWdinvPO0wVaexiDk4QScPEOJaCyyCQpo8JS+g0+C9ORFpBuH1rF3Lym
 kPu8u9Bpv4hPQ57FR9086jq6HygwDlB5/alqVg5mMB6k1VBhi86BLTRxRfqBSDI2C7opvFrhEBi
 lGTP7yr61TuKftOhSxrbRm6+828rVcsiWRShiOZTT+Ok5cLEkc2a5B2ClCWik6uTyVa1OB/usRb
 sKjssjUShYD4E/NWs0UWtNwzdib4zMEwbWgItiNabTGRIW2PA4aETHFIBkuBpL7ZgIOz5AWBTpU
 3uYlw3VLbpgKbIaMCFg8mMozoGz4xFJwugFK78VkxWvWJZl1axdJ3o0xorFXbo7R6PPCOr3wU5M
 KKZhkUGRsx5RP0IN8LkwdGNUpOK5LU4g1o2Yh9os6EyhcTyOKVi4D/xn7qH/5AZpWtznx6f4i9v
 wg6QPYdITrm93PhpDrw==
X-Authority-Analysis: v=2.4 cv=ROO+3oi+ c=1 sm=1 tr=0 ts=6960d8f9 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=4rCbcO1rH8UwRTBQTsMA:9
X-Proofpoint-ORIG-GUID: lHrIpN_YkO9UkAfSF_9r-FsBhglW1ocx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_03,2026-01-08_02,2025-10-01_01

Marvell CN10K switch hardware is capable of accelerating L2, L3,
and flow. The switch hardware runs an application that
creates a logical port for each representor device when representors
are enabled through devlink.

This patch series implements communication from Host OS to switch
HW and vice versa.

   |--------------------------------|
   |            HOST OS             |
   |                                |
   | eth0(rep-eth0)  eth1(rep-eth1) |
   |  |                 |           |
   |  |                 |           |
   ---------------------------------|
      |                 |
      |                 |
  ---------------------------------|
  |  lport0             lport1     |
  |                                |
  |            switch              |
  |                                |
  ---------------------------------|

When representors are created, corresponding "logical ports" are
created in switchdev. The switch hardware allocates a NIX PF and
configures its send queues. These send queues should be able to
transmit packets to any channel, as send queues as from same NIX PF.
Switch is capable of forwarding packets between these logical ports.

Notifier callbacks are registered to receive system events such as
FDB add/delete and FIB add/delete. Flow add/delete operations are
handled through the .ndo_setup_tc() interface. These events are
captured and processed by the NIC driver and forwarded to the switch
device through the AF driver. All message exchanges use the mailbox
interface.

Bridge acceleration:
FDB add/delete notifications are processed, and learned SMAC
information is sent to the switch hardware. The switch inserts a
hardware rule to accelerate packets destined to the MAC address.

Flow acceleration:
NFT and OVS applications call .ndo_setup_tc() to push rules to
hardware for acceleration. This interface is used to forward
rules to the switch hardware through the mailbox interface.

Ratheesh Kannoth (10):
  octeontx2-af: switch: Add AF to switch mbox and skeleton files
  Mbox message for AF to switch

  octeontx2-af: switch: Add switch dev to AF mboxes
  Switch to AF driver mbox messages

  octeontx2-pf: switch: Add pf files hierarchy
  PF skeleton files for bridge, fib and flow

  octeontx2-af: switch: Representor for switch port
  Switch ID is copied and sent to switch when Representors are
  enabled thru devlink. Upon receipt of the message, switch queries
  AF driver to get info on rep interfaces.

  octeontx2-af: switch: Enable Switch hw port for all channels
  Switch ports should be configured to TX packets on any channel.

  octeontx2-pf: switch: Register for notifier chains.
  Notifier callback for various system events.

  octeontx2: switch: L2 offload support
  Bridge (L2) offload support

  octeontx2: switch: L3 offload support
  FIB (L3) offload support.

  octeontx2: switch: Flow offload support
  Flow (5/7 tuple) offload support.

  octeontx2: switch: trace support
  Trace logs for flow and action

 .../net/ethernet/marvell/octeontx2/Kconfig    |  12 +
 .../ethernet/marvell/octeontx2/af/Makefile    |   2 +
 .../net/ethernet/marvell/octeontx2/af/mbox.h  | 219 ++++++
 .../net/ethernet/marvell/octeontx2/af/rvu.c   | 111 +++-
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   6 +
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  54 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   |  77 ++-
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  13 +-
 .../ethernet/marvell/octeontx2/af/rvu_rep.c   |   3 +-
 .../marvell/octeontx2/af/switch/rvu_sw.c      |  47 ++
 .../marvell/octeontx2/af/switch/rvu_sw.h      |  14 +
 .../marvell/octeontx2/af/switch/rvu_sw_fl.c   | 294 ++++++++
 .../marvell/octeontx2/af/switch/rvu_sw_fl.h   |  13 +
 .../marvell/octeontx2/af/switch/rvu_sw_l2.c   | 284 ++++++++
 .../marvell/octeontx2/af/switch/rvu_sw_l2.h   |  13 +
 .../marvell/octeontx2/af/switch/rvu_sw_l3.c   | 215 ++++++
 .../marvell/octeontx2/af/switch/rvu_sw_l3.h   |  11 +
 .../ethernet/marvell/octeontx2/nic/Makefile   |   8 +-
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  |  17 +-
 .../marvell/octeontx2/nic/otx2_txrx.h         |   2 +
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |   8 +
 .../net/ethernet/marvell/octeontx2/nic/rep.c  |  10 +
 .../marvell/octeontx2/nic/switch/sw_fdb.c     | 143 ++++
 .../marvell/octeontx2/nic/switch/sw_fdb.h     |  18 +
 .../marvell/octeontx2/nic/switch/sw_fib.c     | 133 ++++
 .../marvell/octeontx2/nic/switch/sw_fib.h     |  16 +
 .../marvell/octeontx2/nic/switch/sw_fl.c      | 544 +++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fl.h      |  15 +
 .../marvell/octeontx2/nic/switch/sw_nb.c      | 629 ++++++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_nb.h      |  31 +
 .../marvell/octeontx2/nic/switch/sw_trace.c   |  11 +
 .../marvell/octeontx2/nic/switch/sw_trace.h   |  82 +++
 32 files changed, 3040 insertions(+), 15 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_trace.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_trace.h

--
ChangeLog:
v1 -> v2: Fixed build errors
v2 -> v3: Fixed sparse error, Addressed comments from Alok, Kalesh
2.43.0

