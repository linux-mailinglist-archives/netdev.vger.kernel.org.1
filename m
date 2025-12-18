Return-Path: <netdev+bounces-245410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7555ECCD046
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 18:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93D0D3015AB8
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 17:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2418221FBA;
	Thu, 18 Dec 2025 17:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EZfdDlBv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F08122F77E
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080139; cv=none; b=qqDNjLCAHrsnYq/5oT0L5obiDo8dgYJ8eiw7YYoHwwT9Jzyb2ZewZD6/fLNqHwvcIrWNtAQvmdY1ozDareBtB/NT7U0gBW0tBwPhfqMZGs2vPLCoFKdCZeMcTMVRgAKdWGMEUC87NoAcxQzEsh7jaLCCSzxHvbV8N3wP8dCyikw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080139; c=relaxed/simple;
	bh=PqGZrnVIfC1kht1QdJBvRQ8iJcbptj0M3hricbIK4k4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qyN2xv78ekePMRmQhvhEo/oj1s6pHnJE3mzlIfeFLgWRcYtKt8SweyhGm7KHayYXTO3V9q9JO89LcDnS+2QVr4CxmLvST8xzOS0hRyHpek1noWzT2V0t1kmesDn/wzpUyKgNNACnNhq16BNYGdgHxwp2G9nxDvE7gfkSsp7Bb6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EZfdDlBv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766080136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XjQyb8Ix6PmY8qSji4I+UJLkU3H5X8mxJFrfFHOQZrQ=;
	b=EZfdDlBvIP7Z0gts9v5ADA2zCtncsQebkEukN1ow+B8y8QkvqhNZigG1fERiKJFk2bi1oc
	IWSVck2v8zphgUhku91on6fzgek6UBiPtOsjzmHWTb6H6jNatnULy6QS8iQf9oFbEOhBjQ
	Cg6nO09OFI2sDJzLB3dL6HOeK8flvCk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-wMK5ct3LMjuHEkaCKh1Gbw-1; Thu,
 18 Dec 2025 12:48:54 -0500
X-MC-Unique: wMK5ct3LMjuHEkaCKh1Gbw-1
X-Mimecast-MFC-AGG-ID: wMK5ct3LMjuHEkaCKh1Gbw_1766080133
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1423818009C0;
	Thu, 18 Dec 2025 17:48:53 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.101])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 41E8219560B4;
	Thu, 18 Dec 2025 17:48:50 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.19-rc2
Date: Thu, 18 Dec 2025 18:48:41 +0100
Message-ID: <20251218174841.265968-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Linus!

The following changes since commit 8f7aa3d3c7323f4ca2768a9e74ebbe359c4f8f88:

  Merge tag 'net-next-6.19' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2025-12-03 17:24:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.19-rc2

for you to fetch changes up to 21a88f5d9ce0c328486073b75d082d85a1e98a8b:

  Merge tag 'linux-can-fixes-for-6.19-20251218' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can (2025-12-18 17:23:07 +0100)

----------------------------------------------------------------
Including fixes from netfilter and CAN.

Current release - regressions:

  - netfilter: nf_conncount: fix leaked ct in error paths

  - sched: act_mirred: fix loop detection

  - sctp: fix potential deadlock in sctp_clone_sock()

  - can: fix build dependency

  - eth: mlx5e: do not update BQL of old txqs during channel reconfiguration

Previous releases - regressions:

  - sched: ets: always remove class from active list before deleting it

  - inet: frags: flush pending skbs in fqdir_pre_exit()

  - netfilter:  nf_nat: remove bogus direction check

  - mptcp:
    - schedule rtx timer only after pushing data
    - avoid deadlock on fallback while reinjecting

  - can: gs_usb: fix error handling

  - eth: mlx5e:
    - avoid unregistering PSP twice
    - fix double unregister of HCA_PORTS component

  - eth: bnxt_en: fix XDP_TX path

  - eth: mlxsw: fix use-after-free when updating multicast route stats

Previous releases - always broken:

  - ethtool: avoid overflowing userspace buffer on stats query

  - openvswitch: fix middle attribute validation in push_nsh() action

  - eth: mlx5: fw_tracer, validate format string parameters

  - eth: mlxsw: spectrum_router: fix neighbour use-after-free

  - eth: ipvlan: ignore PACKET_LOOPBACK in handle_mode_l2()

Misc:

  - Jozsef Kadlecsik retires from maintaining netfilter

  - tools: ynl: fix build on systems with old kernel headers

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alexey Simakov (1):
      broadcom: b44: prevent uninitialized value usage

Ankit Khushwaha (1):
      selftests: tls: fix warning of uninitialized variable

Arnd Bergmann (2):
      can: fix build dependency
      net: ti: icssg-prueth: add PTP_1588_CLOCK_OPTIONAL dependency

Cosmin Ratiu (2):
      net/mlx5e: Avoid unregistering PSP twice
      net/mlx5e: Don't include PSP in the hard MTU calculations

Dan Carpenter (1):
      nfc: pn533: Fix error code in pn533_acr122_poweron_rdr()

Daniel Golle (5):
      net: dsa: mxl-gsw1xx: fix SerDes RX polarity
      net: dsa: lantiq_gswip: fix order in .remove operation
      net: dsa: mxl-gsw1xx: fix order in .remove operation
      net: dsa: mxl-gsw1xx: fix .shutdown driver operation
      net: dsa: mxl-gsw1xx: manually clear RANEG bit

Dmitry Skorodumov (1):
      ipvlan: Ignore PACKET_LOOPBACK in handle_mode_l2()

Eric Biggers (1):
      mptcp: select CRYPTO_LIB_UTILS instead of CRYPTO

Fernando Fernandez Mancera (1):
      netfilter: nf_conncount: fix leaked ct in error paths

Florian Westphal (5):
      selftests: netfilter: prefer xfail in case race wasn't triggered
      netfilter: nf_nat: remove bogus direction check
      netfilter: nf_tables: avoid chain re-validation if possible
      netfilter: nf_tables: avoid softlockup warnings in nft_chain_validate
      selftests: netfilter: packetdrill: avoid failure on HZ=100 kernel

Gal Pressman (1):
      ethtool: Avoid overflowing userspace buffer on stats query

Gerd Bayer (1):
      net/mlx5: Fix double unregister of HCA_PORTS component

Guenter Roeck (3):
      selftest: af_unix: Support compilers without flex-array-member-not-at-end support
      selftests: net: Fix build warnings
      selftests: net: tfo: Fix build warning

Ido Schimmel (3):
      mlxsw: spectrum_router: Fix possible neighbour reference count leak
      mlxsw: spectrum_router: Fix neighbour use-after-free
      mlxsw: spectrum_mr: Fix use-after-free when updating multicast route stats

Ilya Maximets (1):
      net: openvswitch: fix middle attribute validation in push_nsh() action

Ivan Galkin (1):
      net: phy: RTL8211FVD: Restore disabling of PHY-mode EEE

Jakub Kicinski (13):
      Merge branch 'mlxsw-three-m-router-fixes'
      ynl: add regen hint to new headers
      tools: ynl: fix build on systems with old kernel headers
      Merge branch 'mptcp-misc-fixes-for-v6-19-rc1'
      Merge branch 'selftests-fix-build-warnings-and-errors' (part)
      inet: frags: avoid theoretical race in ip_frag_reinit()
      inet: frags: add inet_frag_queue_flush()
      inet: frags: flush pending skbs in fqdir_pre_exit()
      netfilter: conntrack: warn when cleanup is stuck
      Merge branch 'inet-frags-flush-pending-skbs-in-fqdir_pre_exit'
      Merge branch 'selftests-forwarding-vxlan_bridge_1q_mc_ul-fix-flakiness'
      Merge tag 'nf-25-12-10' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge tag 'linux-can-fixes-for-6.19-20251210' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can

Jamal Hadi Salim (2):
      net/sched: ets: Always remove class from active list before deleting in ets_qdisc_change
      net/sched: act_mirred: fix loop detection

Jian Shen (3):
      net: hns3: using the num_tqps in the vf driver to apply for resources
      net: hns3: using the num_tqps to check whether tqp_index is out of range when vf get ring info from mbx
      net: hns3: add VLAN id validation before using

Jianbo Liu (2):
      net/mlx5e: Use ip6_dst_lookup instead of ipv6_dst_lookup_flow for MAC init
      net/mlx5e: Trigger neighbor resolution for unresolved destinations

Jozsef Kadlecsik (1):
      MAINTAINERS: Remove Jozsef Kadlecsik from MAINTAINERS file

Junrui Luo (1):
      caif: fix integer underflow in cffrml_receive()

Kuniyuki Iwashima (2):
      sctp: Fetch inet6_sk() after setting ->pinet6 in sctp_clone_sock().
      sctp: Clear inet_opt in sctp_v6_copy_ip_options().

Lorenzo Bianconi (1):
      netfilter: always set route tuple out ifindex

Marc Kleine-Budde (2):
      can: gs_usb: gs_can_open(): fix error handling
      can: fix build dependency

Marcus Hughes (1):
      net: sfp: extend Potron XGSPON quirk to cover additional EEPROM variant

Mateusz Guzik (1):
      af_unix: annotate unix_gc_lock with __cacheline_aligned_in_smp

Matthieu Baerts (NGI0) (2):
      mptcp: pm: ignore unknown endpoint flags
      selftests: mptcp: pm: ensure unknown flags are ignored

Michael Chan (1):
      bnxt_en: Fix XDP_TX path

Moshe Shemesh (3):
      net/mlx5: make enable_mpesw idempotent
      net/mlx5: fw reset, clear reset requested on drain_fw_reset
      net/mlx5: Drain firmware reset in shutdown callback

Pablo Neira Ayuso (1):
      netfilter: nf_tables: remove redundant chain validation on register store

Paolo Abeni (9):
      Merge branch 'mlx5-misc-fixes-2025-12-01'
      mptcp: schedule rtx timer only after pushing data
      mptcp: avoid deadlock on fallback while reinjecting
      Merge branch 'net-dsa-lantiq-a-bunch-of-fixes'
      Merge branch 'mlx5-misc-fixes-2025-12-09'
      Merge tag 'nf-25-12-16' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge branch 'sctp-fix-two-issues-in-sctp_clone_sock'
      Merge branch 'there-are-some-bugfix-for-the-hns3-ethernet-driver'
      Merge tag 'linux-can-fixes-for-6.19-20251218' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can

Petr Machata (3):
      selftests: net: lib: tc_rule_stats_get(): Don't hard-code array index
      selftests: forwarding: vxlan_bridge_1q_mc_ul: Fix flakiness
      selftests: forwarding: vxlan_bridge_1q_mc_ul: Drop useless sleeping

René Rebe (1):
      r8169: fix RTL8117 Wake-on-Lan in DASH mode

Scott Mayhew (1):
      net/handshake: duplicate handshake cancellations leak socket

Shaurya Rane (1):
      net/hsr: fix NULL pointer dereference in prp_get_untagged_frame()

Shay Drory (3):
      net/mlx5: fw_tracer, Validate format string parameters
      net/mlx5: fw_tracer, Handle escaped percent properly
      net/mlx5: Serialize firmware reset with devlink

Slavin Liu (1):
      ipvs: fix ipv4 null-ptr-deref in route error path

Tariq Toukan (1):
      net/mlx5e: Do not update BQL of old txqs during channel reconfiguration

Tetsuo Handa (2):
      can: j1939: make j1939_session_activate() fail if device is no longer registered
      can: j1939: make j1939_sk_bind() fail if device is no longer registered

Thorsten Blum (1):
      net: phy: marvell-88q2xxx: Fix clamped value in mv88q2xxx_hwmon_write

Tim Hostetler (1):
      gve: Move gve_init_clock to after AQ CONFIGURE_DEVICE_RESOURCES call

Victor Nogueira (3):
      net/sched: ets: Remove drr class from the active list if it changes to strict
      selftests/tc-testing: Create tests to exercise ets classes active list misplacements
      selftests/tc-testing: Test case exercising potential mirred redirect deadlock

Wang Liang (1):
      netrom: Fix memory leak in nr_sendmsg()

Wei Fang (2):
      net: fec: ERR007885 Workaround for XDP TX path
      net: enetc: do not transmit redirected XDP frames when the link is down

caoping (1):
      net/handshake: restore destructor on submit failure

 CREDITS                                            |  1 +
 MAINTAINERS                                        |  1 -
 drivers/net/can/Kconfig                            |  7 +-
 drivers/net/can/Makefile                           |  2 +-
 drivers/net/can/dev/Makefile                       |  5 +-
 drivers/net/can/usb/gs_usb.c                       |  2 +-
 drivers/net/dsa/lantiq/lantiq_gswip.c              |  3 -
 drivers/net/dsa/lantiq/lantiq_gswip.h              |  2 -
 drivers/net/dsa/lantiq/lantiq_gswip_common.c       | 19 +++--
 drivers/net/dsa/lantiq/mxl-gsw1xx.c                | 46 ++++++++--
 drivers/net/ethernet/broadcom/b44.c                |  3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c      |  3 +-
 drivers/net/ethernet/freescale/enetc/enetc.c       |  3 +-
 drivers/net/ethernet/freescale/fec_main.c          |  7 +-
 drivers/net/ethernet/google/gve/gve_main.c         | 17 ++--
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  3 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |  4 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  4 +-
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c  |  5 ++
 .../ethernet/mellanox/mlx5/core/diag/fw_tracer.c   | 97 +++++++++++++++++++---
 .../ethernet/mellanox/mlx5/core/diag/fw_tracer.h   |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |  2 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |  8 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  1 -
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |  6 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  6 ++
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c | 48 +++++++++--
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.h |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |  1 +
 .../net/ethernet/mellanox/mlx5/core/lag/mpesw.c    | 11 ++-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |  1 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c  |  2 +
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c  | 27 +++---
 drivers/net/ethernet/realtek/r8169_main.c          |  5 +-
 drivers/net/ethernet/ti/Kconfig                    |  3 +-
 drivers/net/ipvlan/ipvlan_core.c                   |  3 +
 drivers/net/phy/marvell-88q2xxx.c                  |  2 +-
 drivers/net/phy/realtek/realtek_main.c             |  4 -
 drivers/net/phy/sfp.c                              |  2 +
 drivers/nfc/pn533/usb.c                            |  2 +-
 include/net/inet_frag.h                            | 18 +---
 include/net/ipv6_frag.h                            |  9 +-
 include/net/netfilter/nf_tables.h                  | 34 ++++++--
 include/uapi/linux/energy_model.h                  |  1 +
 include/uapi/linux/mptcp.h                         |  1 +
 kernel/power/em_netlink_autogen.c                  |  1 +
 kernel/power/em_netlink_autogen.h                  |  1 +
 net/caif/cffrml.c                                  |  9 +-
 net/can/Kconfig                                    |  1 -
 net/can/j1939/socket.c                             |  6 ++
 net/can/j1939/transport.c                          |  2 +
 net/ethtool/ioctl.c                                | 30 +++++--
 net/handshake/request.c                            |  8 +-
 net/hsr/hsr_forward.c                              |  2 +
 net/ipv4/inet_fragment.c                           | 55 +++++++++++-
 net/ipv4/ip_fragment.c                             | 22 ++---
 net/mptcp/Kconfig                                  |  2 +-
 net/mptcp/pm_netlink.c                             |  3 +-
 net/mptcp/protocol.c                               | 22 +++--
 net/netfilter/ipvs/ip_vs_xmit.c                    |  3 +
 net/netfilter/nf_conncount.c                       | 25 +++---
 net/netfilter/nf_conntrack_core.c                  |  3 +
 net/netfilter/nf_flow_table_path.c                 |  4 +-
 net/netfilter/nf_nat_core.c                        | 14 +---
 net/netfilter/nf_tables_api.c                      | 84 +++++++++++++++----
 net/netrom/nr_out.c                                |  4 +-
 net/openvswitch/flow_netlink.c                     | 13 ++-
 net/sched/act_mirred.c                             |  9 ++
 net/sched/sch_ets.c                                |  6 +-
 net/sctp/ipv6.c                                    |  2 +
 net/sctp/socket.c                                  |  7 +-
 net/unix/garbage.c                                 |  2 +-
 tools/net/ynl/Makefile.deps                        |  2 +
 tools/testing/selftests/net/af_unix/Makefile       |  7 +-
 tools/testing/selftests/net/forwarding/config      |  1 +
 .../net/forwarding/vxlan_bridge_1q_mc_ul.sh        | 76 +++++++----------
 tools/testing/selftests/net/lib.sh                 |  3 +-
 tools/testing/selftests/net/lib/ksft.h             |  6 +-
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |  4 +
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c      | 11 +++
 .../selftests/net/netfilter/conntrack_clash.sh     |  9 +-
 .../net/netfilter/conntrack_reverse_clash.c        | 13 ++-
 .../net/netfilter/conntrack_reverse_clash.sh       |  2 +
 .../packetdrill/conntrack_syn_challenge_ack.pkt    |  2 +-
 tools/testing/selftests/net/tfo.c                  |  3 +-
 tools/testing/selftests/net/tls.c                  |  2 +-
 .../tc-testing/tc-tests/actions/mirred.json        | 46 ++++++++++
 .../tc-testing/tc-tests/infra/qdiscs.json          | 78 +++++++++++++++++
 88 files changed, 769 insertions(+), 269 deletions(-)


