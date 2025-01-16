Return-Path: <netdev+bounces-158921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1C1A13C95
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 15:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38AB5188D21A
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 14:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CA11DED62;
	Thu, 16 Jan 2025 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YNHJdIG3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4C849652
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038797; cv=none; b=FdDvHcvZhUeWlrK/c3Hpu+HckwMDUNUGdFRLPZIsxYVtykcfSU/vPYKa7ii/mH/bPygSTSF8rYR7gU9LpFeXlvmIWqnXJr32Wq7eEWUsq8CEmqAhmJpqe4MPJiH8cSQRP5lXsWeRp4ICO243Yx80mWOOrh/QZY9koeLE/9HpvrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038797; c=relaxed/simple;
	bh=aZoJ8yKOVcTyhdcDZKoAXoRDUrFcUt8vqSXoXOGyM/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZVBwC2QEAWYDse+t3BaKLZz5CBCHDpedhpj/XeA1r470Bpi6HVOrqBj8cA1DbgvR+spC4S99zVheDJqjTGi+vGOvxR5Vd7VFWqveON9iMM6gRUqTewC53c+PqNzR1Yl7/2h1rdm2QvC5S1s7loXEvdV1CbpbuzvmB/5B79cD8m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YNHJdIG3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737038794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lmqnyM6paygcL11ztvty7HHmZ12XbcOFGCN7kT+k2ZQ=;
	b=YNHJdIG3BrQEBlamXJ29RtYBi7TeLqfAh117HalTBe3l+L27cazzy2p8caFkWfZa1fItih
	R0OuNc3rRAS5sIsmRA96Kjcuc29KaOOZMlRCVPTG+3m7AckW6fieY1/7xF6I/rl14T7BIV
	dovHAQZOq4oioT93CIVPUgjD6fQja6w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-z67BnCGvOmKthZtbRmYtNw-1; Thu,
 16 Jan 2025 09:46:30 -0500
X-MC-Unique: z67BnCGvOmKthZtbRmYtNw-1
X-Mimecast-MFC-AGG-ID: z67BnCGvOmKthZtbRmYtNw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67E951956058;
	Thu, 16 Jan 2025 14:46:29 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.78])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5D1EC195608A;
	Thu, 16 Jan 2025 14:46:27 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.13-rc8
Date: Thu, 16 Jan 2025 15:46:19 +0100
Message-ID: <20250116144619.40965-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi Linus!

Notably this includes fixes for a few regressions spotted very
recently. No known outstanding ones.

The following changes since commit c77cd47cee041bc1664b8e5fcd23036e5aab8e2a:

  Merge tag 'net-6.13-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-01-09 12:40:58 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.13-rc8

for you to fetch changes up to a50da36562cd62b41de9bef08edbb3e8af00f118:

  netdev: avoid CFI problems with sock priv helpers (2025-01-16 13:15:40 +0100)

----------------------------------------------------------------
Current release - regressions:

  - core: avoid CFI problems with sock priv helpers

  - xsk: bring back busy polling support

  - netpoll: ensure skb_pool list is always initialized

Current release - new code bugs:

  - core: make page_pool_ref_netmem work with net iovs

  - ipv4: route: fix drop reason being overridden in ip_route_input_slow

  - udp: make rehash4 independent in udp_lib_rehash()

Previous releases - regressions:

  - bpf: fix bpf_sk_select_reuseport() memory leak

  - openvswitch: fix lockup on tx to unregistering netdev with carrier

  - mptcp: be sure to send ack when mptcp-level window re-opens

  - eth: bnxt: always recalculate features after XDP clearing, fix null-deref

  - eth: mlx5: fix sub-function add port error handling

  - eth: fec: handle page_pool_dev_alloc_pages error

Previous releases - always broken:

  - vsock: some fixes due to transport de-assignment

  - eth: ice: fix E825 initialization

  - eth: mlx5e: fix inversion dependency warning while enabling IPsec tunnel

  - eth: gtp: destroy device along with udp socket's netns dismantle.

  - eth: xilinx: axienet: Fix IRQ coalescing packet count overflow

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Antoine Tenart (1):
      ipv4: route: fix drop reason being overridden in ip_route_input_slow

Artem Chernyshev (1):
      pktgen: Avoid out-of-bounds access in get_imix_entries

Chris Mi (1):
      net/mlx5: SF, Fix add port error handling

Dan Carpenter (1):
      nfp: bpf: prevent integer overflow in nfp_bpf_event_output()

Heiner Kallweit (2):
      r8169: remove redundant hwmon support
      net: ethernet: xgbe: re-add aneg to supported features in PHY quirks

Ilya Maximets (1):
      openvswitch: fix lockup on tx to unregistering netdev with carrier

Jakub Kicinski (4):
      eth: bnxt: always recalculate features after XDP clearing, fix null-deref
      Merge branch 'mptcp-fixes-for-connect-selftest-flakes'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      netdev: avoid CFI problems with sock priv helpers

John Sperbeck (1):
      net: netpoll: ensure skb_pool list is always initialized

Karol Kolacinski (4):
      ice: Fix E825 initialization
      ice: Fix quad registers read on E825
      ice: Fix ETH56G FC-FEC Rx offset value
      ice: Add correct PHY lane assignment

Kevin Groeneveld (1):
      net: fec: handle page_pool_dev_alloc_pages error

Kuniyuki Iwashima (3):
      gtp: Use for_each_netdev_rcu() in gtp_genl_dump_pdp().
      gtp: Destroy device along with udp socket's netns dismantle.
      pfcp: Destroy device along with udp socket's netns dismantle.

Leon Romanovsky (3):
      net/mlx5e: Fix inversion dependency warning while enabling IPsec tunnel
      net/mlx5e: Rely on reqid in IPsec tunnel mode
      net/mlx5e: Always start IPsec sequence number from 1

Mark Zhang (1):
      net/mlx5: Clear port select structure when fail to create

Michal Luczaj (1):
      bpf: Fix bpf_sk_select_reuseport() memory leak

Paolo Abeni (6):
      Merge branch 'gtp-pfcp-fix-use-after-free-of-udp-tunnel-socket'
      Merge branch 'vsock-some-fixes-due-to-transport-de-assignment'
      mptcp: be sure to send ack when mptcp-level window re-opens
      mptcp: fix spurious wake-up on under memory pressure
      selftests: mptcp: avoid spurious errors on disconnect
      Merge branch 'mlx5-misc-fixes-2025-01-15'

Patrisious Haddad (1):
      net/mlx5: Fix RDMA TX steering prio

Paul Barker (1):
      net: ravb: Fix max TX frame size for RZ/V2M

Paul Fertser (1):
      net/ncsi: fix locking in Get MAC Address handling

Pavel Begunkov (1):
      net: make page_pool_ref_netmem work with net iovs

Philo Lu (1):
      udp: Make rehash4 independent in udp_lib_rehash()

Sean Anderson (1):
      net: xilinx: axienet: Fix IRQ coalescing packet count overflow

Shradha Gupta (1):
      net: mana: Cleanup "mana" debugfs dir after cleanup of all children

Stanislav Fomichev (1):
      xsk: Bring back busy polling support

Stefano Garzarella (5):
      vsock/virtio: discard packets if the transport changes
      vsock/bpf: return early if transport is not assigned
      vsock/virtio: cancel close work in the destructor
      vsock: reset socket state when de-assigning the transport
      vsock: prevent null-ptr-deref in vsock_*[has_data|has_space]

Sudheer Kumar Doredla (1):
      net: ethernet: ti: cpsw_ale: Fix cpsw_ale_get_field()

Victor Nogueira (1):
      selftests: net: Adapt ethtool mq tests to fix in qdisc graft

Vladimir Oltean (2):
      net: pcs: xpcs: fix DW_VR_MII_DIG_CTRL1_2G5_EN bit being set for 1G SGMII w/o inband
      net: pcs: xpcs: actively unset DW_VR_MII_DIG_CTRL1_2G5_EN for 1G SGMII

Yishai Hadas (1):
      net/mlx5: Fix a lockdep warning as part of the write combining test

 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c        |  19 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  25 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c      |   7 -
 drivers/net/ethernet/freescale/fec_main.c          |  19 +-
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h    |   1 +
 drivers/net/ethernet/intel/ice/ice_common.c        |  51 ++++
 drivers/net/ethernet/intel/ice/ice_common.h        |   1 +
 drivers/net/ethernet/intel/ice/ice_main.c          |   6 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c           |  23 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h           |   4 +-
 drivers/net/ethernet/intel/ice/ice_ptp_consts.h    |   2 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c        | 263 +++++++++++----------
 drivers/net/ethernet/intel/ice/ice_type.h          |   2 -
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |  22 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c         |  12 +-
 .../mellanox/mlx5/core/en_accel/ipsec_offload.c    |  11 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |   1 +
 .../net/ethernet/mellanox/mlx5/core/lag/port_sel.c |   4 +-
 .../net/ethernet/mellanox/mlx5/core/sf/devlink.c   |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/wc.c       |  24 +-
 drivers/net/ethernet/microsoft/mana/gdma_main.c    |   4 +-
 drivers/net/ethernet/netronome/nfp/bpf/offload.c   |   3 +-
 drivers/net/ethernet/realtek/r8169_main.c          |  44 ----
 drivers/net/ethernet/renesas/ravb_main.c           |   1 +
 drivers/net/ethernet/ti/cpsw_ale.c                 |  14 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |   6 +
 drivers/net/gtp.c                                  |  26 +-
 drivers/net/pcs/pcs-xpcs.c                         |   4 +-
 drivers/net/pfcp.c                                 |  15 +-
 include/net/busy_poll.h                            |   8 -
 include/net/page_pool/helpers.h                    |   2 +-
 include/net/xdp.h                                  |   1 -
 include/net/xdp_sock_drv.h                         |  14 --
 net/core/filter.c                                  |  30 ++-
 net/core/netdev-genl-gen.c                         |  14 +-
 net/core/netpoll.c                                 |  10 +-
 net/core/pktgen.c                                  |   6 +-
 net/core/xdp.c                                     |   1 -
 net/ipv4/route.c                                   |   1 +
 net/ipv4/udp.c                                     |  46 ++--
 net/mptcp/options.c                                |   6 +-
 net/mptcp/protocol.h                               |   9 +-
 net/ncsi/internal.h                                |   2 +
 net/ncsi/ncsi-manage.c                             |  16 +-
 net/ncsi/ncsi-rsp.c                                |  19 +-
 net/openvswitch/actions.c                          |   4 +-
 net/vmw_vsock/af_vsock.c                           |  18 ++
 net/vmw_vsock/virtio_transport_common.c            |  36 ++-
 net/vmw_vsock/vsock_bpf.c                          |   9 +
 net/xdp/xsk.c                                      |  14 +-
 tools/net/ynl/ynl-gen-c.py                         |  16 +-
 .../drivers/net/netdevsim/tc-mq-visibility.sh      |   9 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.c  |  43 +++-
 54 files changed, 552 insertions(+), 399 deletions(-)


