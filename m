Return-Path: <netdev+bounces-247281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 420E9CF66E5
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 03:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C546C3007642
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 02:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A3622D9F7;
	Tue,  6 Jan 2026 02:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="N6V+NbRX"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8615823958A;
	Tue,  6 Jan 2026 02:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767665724; cv=none; b=skOMi3z3mPazpUaONjyH3KlRsFIakO2OtLwbJaDWOzDZfvldDEz+akk5AbBE6BxpHbXll7oUF411rABiNpF+FASz89R24PBnBX24CzE11ysdKpmEKbhE4ZKahWVG9ZMaGag1inity9zBuPLLlcNG6Jd/Vsq8Mhm+cIdIE/rTjzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767665724; c=relaxed/simple;
	bh=nsWKt4cJdqeB+NZfhAMjidnaEGvHutgyVLOc15joNTM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o04Y0qdc7Wn52swdMOi+IJiUd4M7/7UbfbaYSEZ7ha00WiFsP5UIAX4fXF4vuBqE77tN98plsQt7DJMOahzUOlPshskzvj1f4FoAo+Cj3xeeB42yJE79zzsPrxSgSv7+up79uNwZ4BkyjVyaA61IyDQlHWtl+2g8vHPIzzUBpL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=N6V+NbRX; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6060m4f4128514;
	Mon, 5 Jan 2026 18:15:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=bZx9IZYIY0MB2soLEOeJSwN
	de9zBOyIlfNgBs642VsU=; b=N6V+NbRXYLaQ7lgvXedYC4ZXPMTKaV7tus1ic8f
	3NHKpT1y/m/ILyYHKdvFB3wkemnyKbU+L97Hv4D6WleGbhnudy37W8qw5IvwjqdM
	89uDJynEaJamJ3hoLg9ByYR7UOY62MkmmUKmqDjhACdoMbEc7H9gMS5kFE01RkBA
	idnpncRU89yKHm4ZK61o3TidGADSmkqR0+9VZv/S2P1MihlqNn5IoPnKtssQhjY4
	4VwV8QkmqnN0YrkTn+fTxItCcrb+g8c3M+t3yYNuksAxchJgGM52rD0Yp4f4lYtj
	84hb5IQTcVXejXIy4mjwiLRoxH7/C0H892ZKib9/yf37DyA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bg9crhvw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 18:15:11 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 5 Jan 2026 18:15:25 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 5 Jan 2026 18:15:25 -0800
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 915373F70C4;
	Mon,  5 Jan 2026 18:15:08 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andrew+netdev@lunn.ch>
CC: <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH net-next 00/10] Switch support
Date: Tue, 6 Jan 2026 07:44:37 +0530
Message-ID: <20260106021447.2359108-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAxOCBTYWx0ZWRfX6bHM4hmSLvq5
 00YrxdEQomZD6oB187AU3l7NMgIJiYjdfe/857w+O4spTl+SWAkPiANyXoJfnsGd7ppE/MvdTN1
 vIJpsvfNkceVjhZRH0n9xx+GxRel5EZvo3UP1QQKVR5X3es88Rws9M0Wq0L6bS+ISej0ysmdNOq
 yp6Go6JpI/xwOs3dZngMjeexUyMZAndtUosUMz1ywLTRomK5awuyZSOOhAoCTqfkqQFjVGJJ6E7
 1If5+TJVSouVpV1DNIiLj9vGzRhf1WvwXFYnnN1ddrtcylkYle8HywdvAy+iu4RgtXTl01fh8E0
 NeoXUWs8vR/d9Rh1yK18K1wRpcZfuGO/8MBvpyUz29Z4AdDAz415jVSr9Yz8G7GzPh5rb4SCfmd
 BYZVlbcdp0gkiLr2ENLQxRv3+CxBTZCibNC4ZY15ZvSmpdz7W1YO+rQUBaNJTY1VhPFf+INs/V2
 s5j1eKwQcOXSndUyADw==
X-Proofpoint-ORIG-GUID: g5aNJ5kuTTialMBGZqhfV5AA0laPcydT
X-Authority-Analysis: v=2.4 cv=aLr9aL9m c=1 sm=1 tr=0 ts=695c702f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=4rCbcO1rH8UwRTBQTsMA:9
X-Proofpoint-GUID: g5aNJ5kuTTialMBGZqhfV5AA0laPcydT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01

Marvell CN10K switch hardware is capable of accelerating L2, L3,
and flow. The switch hardware runs an application that
creates a virtual port for each representor device when representors
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
  |  port0             port1       |
  |                                |
  |            switch              |
  |                                |
  ---------------------------------|

When representors are created, corresponding "ports" are created in
switchdev. The switch hardware allocates a NIX PF and configures its
send queues. These send queues should be able to transmit
packets to any channel, as send queues as from same NIX PF.

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
NFT and OVS applications call .ndo_setup_tc() to push rules to hardware
for acceleration. This interface is used to forward rules to the
switch hardware through the mailbox interface.

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
2.43.0

