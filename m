Return-Path: <netdev+bounces-217742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DE1B39AB3
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0366D3BC866
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3582A30C63F;
	Thu, 28 Aug 2025 10:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="id74Fh8K"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C52B30C60A
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756378430; cv=none; b=Ya9/Z4el+ATPYj3tIzClVQUu7Wgo++beF3FWoBfgJdFrtnp6p8HMD2ayym2DWYtZvnL0WfU7ou7hYTDvCYi2Q9yu+x649y+UBf5AjfM0nOebxo1BCAMUESKc1t3ZObK/DP08wQEe5L21KBQkEwChRKwBvtCOVvmFj5iKcWHuAGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756378430; c=relaxed/simple;
	bh=fpOxiLuOmsV64OYbAVO2mB6WlQi2r85WgQ1WdMK67M0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DIrz8yOOhnei1Zxu1at7nMCMT3CbSoeIQWLngMl3C32HJNuEoG10fDjQh7BLHDkG0Sh/18mmUhC0gDKTHhe1EZsenEIJfbC7G/E1IWEaqkIXVv6/ZLNI7pjRcS7gsk6cIzG46AApsQllujggpCmiHbAuy+PbEeCrDBX2E37rd0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=id74Fh8K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756378427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YP5dwmSGWCMYaYOZfc8etZP+WaT0DdFgyqajlzaqeMY=;
	b=id74Fh8K42CsRy6gGrOnfRi2vYtzPHJTGN1j0919c7PfYuKSuhnY4APZZW8LcMwOXFXSjb
	49jJcEq0D3p0lBaqzWydAPneYL+qQ83zUI2KiNJUtYoLMKGh+44nJvAi5UTbNIfPCIgvZ5
	fAagP5tMbvWBsflyu69TYN2JAz5Ls7w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-2hJLXnT-PA-mGkcTUXwzNQ-1; Thu,
 28 Aug 2025 06:53:43 -0400
X-MC-Unique: 2hJLXnT-PA-mGkcTUXwzNQ-1
X-Mimecast-MFC-AGG-ID: 2hJLXnT-PA-mGkcTUXwzNQ_1756378422
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F2D7D1800366;
	Thu, 28 Aug 2025 10:53:41 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.170])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D964F3000198;
	Thu, 28 Aug 2025 10:53:39 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.17-rc4
Date: Thu, 28 Aug 2025 12:53:30 +0200
Message-ID: <20250828105330.27318-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Linus!

The following changes since commit 6439a0e64c355d2e375bd094f365d56ce81faba3:

  Merge tag 'net-6.17-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-08-21 13:51:15 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.17-rc4

for you to fetch changes up to 5189446ba995556eaa3755a6e875bc06675b88bd:

  net: ipv4: fix regression in local-broadcast routes (2025-08-28 10:52:30 +0200)

----------------------------------------------------------------
Including fixes from Bluetooth.

Current release - regressions:

  - ipv4: fix regression in local-broadcast routes

  - vsock: fix error-handling regression introduced in v6.17-rc1

Previous releases - regressions:

  - bluetooth:
    - mark connection as closed during suspend disconnect
    - fix set_local_name race condition

  - eth: ice: fix NULL pointer dereference on reset

  - eth: mlx5: fix memory leak in hws_pool_buddy_init error path

  - eth: bnxt_en: fix stats context reservation logic

  - eth: hv: fix loss of receive events from host during channel open

Previous releases - always broken:

  - page_pool: fix incorrect mp_ops error handling

  - sctp: initialize more fields in sctp_v6_from_sk()

  - eth: octeontx2-vf: fix max packet length errors

  - eth: idpf: fix Tx flow scheduling to avoid Tx timeouts

  - eth: bnxt_en: fix memory corruption during ifdown

  - eth: ice: fix incorrect counter for buffer allocation failures

  - eth: mlx5: fix lockdep assertion on sync reset unload event

  - eth: fbnic: fixup rtnl_lock and devl_lock handling

  - eth: xgmac: do not enable RX FIFO overflow interrupts

  - phy: mscc: fix when PTP clock is register and unregister

Misc:

  - add Telit Cinterion LE910C4-WWX new compositions

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alexander Duyck (2):
      fbnic: Fixup rtnl_lock and devl_lock handling related to mailbox code
      fbnic: Move phylink resume out of service_task and into open/close

Alexei Lazar (3):
      net/mlx5e: Update and set Xon/Xoff upon MTU set
      net/mlx5e: Update and set Xon/Xoff upon port speed set
      net/mlx5e: Set local Xoff after FW update

Boon Khai Ng (1):
      MAINTAINERS: Update maintainer information for Altera Triple Speed Ethernet Driver

Dipayaan Roy (1):
      net: hv_netvsc: fix loss of early receive events from host during channel open.

Emil Tantilov (1):
      ice: fix NULL pointer dereference in ice_unplug_aux_dev() on reset

Eric Dumazet (3):
      sctp: initialize more fields in sctp_v6_from_sk()
      l2tp: do not use sock_hold() in pppol2tp_session_get_sock()
      net: rose: fix a typo in rose_clear_routes()

Fabio Porcedda (1):
      net: usb: qmi_wwan: add Telit Cinterion LE910C4-WWX new compositions

Hariprasad Kelam (2):
      Octeontx2-vf: Fix max packet length errors
      Octeontx2-af: Fix NIX X2P calibration failures

Horatiu Vultur (1):
      phy: mscc: Fix when PTP clock is register and unregister

Jacob Keller (2):
      ice: don't leave device non-functional if Tx scheduler config fails
      ice: use fixed adapter index for E825C embedded devices

Jakub Kicinski (10):
      Merge branch 'fix-vsock-error-handling-regression-introduced-in-v6-17-rc1'
      Merge branch '200GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge tag 'for-net-2025-08-22' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      MAINTAINERS: retire Boris from TLS maintainers
      Merge branch 'bnxt_en-3-bug-fixes'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch 'mlx5-misc-fixes-2025-08-25'
      Merge branch 'net-stmmac-xgmac-minor-fixes'
      Merge branch 'introduce-refcount_t-for-reference-counting-of-rose_neigh'
      Merge branch 'locking-fixes-for-fbnic-driver'

Jedrzej Jagielski (1):
      ixgbe: fix ixgbe_orom_civd_info struct layout

Joshua Hay (6):
      idpf: add support for Tx refillqs in flow scheduling mode
      idpf: improve when to set RE bit logic
      idpf: simplify and fix splitq Tx packet rollback error path
      idpf: replace flow scheduling buffer ring with buffer pool
      idpf: stop Tx if there are insufficient buffer resources
      idpf: remove obsolete stashing code

Kuniyuki Iwashima (1):
      atm: atmtcp: Prevent arbitrary write in atmtcp_recv_control().

Lama Kayal (4):
      net/mlx5: HWS, Fix memory leak in hws_pool_buddy_init error path
      net/mlx5: HWS, Fix memory leak in hws_action_get_shared_stc_nic error flow
      net/mlx5: HWS, Fix uninitialized variables in mlx5hws_pat_calc_nop error flow
      net/mlx5: HWS, Fix pattern destruction in mlx5hws_pat_get_pattern error path

Ludovico de Nittis (2):
      Bluetooth: hci_event: Treat UNKNOWN_CONN_ID on disconnect as success
      Bluetooth: hci_event: Mark connection as closed during suspend disconnect

Luiz Augusto von Dentz (2):
      Bluetooth: hci_conn: Make unacked packet handling more robust
      Bluetooth: hci_event: Detect if HCI_EV_NUM_COMP_PKTS is unbalanced

Michael Chan (2):
      bnxt_en: Adjust TX rings if reservation is less than requested
      bnxt_en: Fix stats context reservation logic

Michal Kubiak (1):
      ice: fix incorrect counter for buffer allocation failures

Mina Almasry (1):
      page_pool: fix incorrect mp_ops error handling

Moshe Shemesh (4):
      net/mlx5: Reload auxiliary drivers on fw_activate
      net/mlx5: Fix lockdep assertion on sync reset unload event
      net/mlx5: Nack sync reset when SFs are present
      net/mlx5: Prevent flow steering mode changes in switchdev mode

Neil Mandir (1):
      net: macb: Disable clocks once

Oscar Maes (1):
      net: ipv4: fix regression in local-broadcast routes

Pavel Shpakovskiy (1):
      Bluetooth: hci_sync: fix set_local_name race condition

Rohan G Thomas (3):
      net: stmmac: xgmac: Do not enable RX FIFO Overflow interrupts
      net: stmmac: xgmac: Correct supported speed modes
      net: stmmac: Set CIC bit only for TX queues with COE

Sean Anderson (1):
      net: macb: Fix offset error in gem_update_stats

Sreekanth Reddy (1):
      bnxt_en: Fix memory corruption when FW resources change during ifdown

Subash Abhinov Kasiviswanathan (1):
      MAINTAINERS: rmnet: Update email addresses

Takamitsu Iwai (3):
      net: rose: split remove and free operations in rose_remove_neigh()
      net: rose: convert 'use' field to refcount_t
      net: rose: include node references in rose_neigh refcount

Vladimir Riabchun (1):
      mISDN: hfcpci: Fix warning when deleting uninitialized timer

Will Deacon (2):
      net: Introduce skb_copy_datagram_from_iter_full()
      vsock/virtio: Fix message iterator handling on transmit path

Yang Li (1):
      Bluetooth: hci_event: Disconnect device when BIG sync is lost

Yeounsu Moon (1):
      net: dlink: fix multicast stats being counted incorrectly

luoguangfei (1):
      net: macb: fix unregister_netdev call order in macb_remove()

 CREDITS                                            |   7 +
 MAINTAINERS                                        |   7 +-
 drivers/atm/atmtcp.c                               |  17 +-
 drivers/isdn/hardware/mISDN/hfcpci.c               |  12 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  36 +-
 drivers/net/ethernet/cadence/macb_main.c           |  11 +-
 drivers/net/ethernet/dlink/dl2k.c                  |   2 +-
 drivers/net/ethernet/intel/ice/ice.h               |   1 +
 drivers/net/ethernet/intel/ice/ice_adapter.c       |  49 +-
 drivers/net/ethernet/intel/ice/ice_adapter.h       |   4 +-
 drivers/net/ethernet/intel/ice/ice_ddp.c           |  44 +-
 drivers/net/ethernet/intel/ice/ice_idc.c           |  10 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |  16 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c          |   2 +-
 .../net/ethernet/intel/idpf/idpf_singleq_txrx.c    |  61 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        | 723 ++++++++-------------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h        |  87 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c      |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h |   2 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |   7 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |  14 +
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |   4 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |   1 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   3 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c   |  10 +
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c   |  13 +-
 drivers/net/ethernet/marvell/octeontx2/nic/rep.h   |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c  |   2 +-
 .../ethernet/mellanox/mlx5/core/en/port_buffer.c   |   3 +-
 .../ethernet/mellanox/mlx5/core/en/port_buffer.h   |  12 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  19 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |  15 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c | 126 ++--
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h |   1 +
 .../net/ethernet/mellanox/mlx5/core/sf/devlink.c   |  10 +
 drivers/net/ethernet/mellanox/mlx5/core/sf/sf.h    |   6 +
 .../mellanox/mlx5/core/steering/hws/action.c       |   2 +-
 .../mellanox/mlx5/core/steering/hws/pat_arg.c      |   6 +-
 .../mellanox/mlx5/core/steering/hws/pool.c         |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c     |   4 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c        |  15 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  13 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c |   9 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   6 +-
 drivers/net/hyperv/netvsc.c                        |  17 +-
 drivers/net/hyperv/rndis_filter.c                  |  23 +-
 drivers/net/phy/mscc/mscc.h                        |   4 +
 drivers/net/phy/mscc/mscc_main.c                   |   4 +-
 drivers/net/phy/mscc/mscc_ptp.c                    |  34 +-
 drivers/net/usb/qmi_wwan.c                         |   3 +
 include/linux/atmdev.h                             |   1 +
 include/linux/skbuff.h                             |   2 +
 include/net/bluetooth/hci_sync.h                   |   2 +-
 include/net/rose.h                                 |  18 +-
 net/atm/common.c                                   |  15 +-
 net/bluetooth/hci_conn.c                           |  58 +-
 net/bluetooth/hci_event.c                          |  25 +-
 net/bluetooth/hci_sync.c                           |   6 +-
 net/bluetooth/mgmt.c                               |   9 +-
 net/core/datagram.c                                |  14 +
 net/core/page_pool.c                               |   6 +-
 net/ipv4/route.c                                   |  10 +-
 net/l2tp/l2tp_ppp.c                                |  25 +-
 net/rose/af_rose.c                                 |  13 +-
 net/rose/rose_in.c                                 |  12 +-
 net/rose/rose_route.c                              |  62 +-
 net/rose/rose_timer.c                              |   2 +-
 net/sctp/ipv6.c                                    |   2 +
 net/vmw_vsock/virtio_transport_common.c            |   8 +-
 69 files changed, 982 insertions(+), 789 deletions(-)


