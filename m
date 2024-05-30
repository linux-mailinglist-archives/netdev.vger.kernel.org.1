Return-Path: <netdev+bounces-99417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF5D8D4CCF
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 15:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263CE1C221E2
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 13:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB2617C234;
	Thu, 30 May 2024 13:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFjiyXSF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CDB27457
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 13:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717075902; cv=none; b=SZ96vgCZrxz5cmN7ju3QmJuDoZXdSyNO827Cd7O0VL104hiXYhQaXxOnenxGly6eTNWCQYLSGobwzVy8I4+7FXTDUKNENMtpfTwzZG+/PimHKKOs7GzlQfSmCimOGgTjWi42l9GudeN8PxlWx7Vclg/UkboAHoxnhsNrJWUsvmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717075902; c=relaxed/simple;
	bh=UrpnvgI3C9+2Nc+o/iBsxRoJDuQOoIqxWi6cVO/SOEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QUVy1Q+CIlSICE0FFv7FbZPJczlD38U9OtK1kB+raPrb5CfHjsKLHSeqeHaG9n0k0b2FCqcP14C6yt/IFgovNWlHy8updOr+SbCcaa0mHsu0iOhtjoL/fPXO1hLI7LZwbx7b7j5ZAB8BcNY59P4YK6rL6GufX8JNTZShsa0f3LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HFjiyXSF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717075899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8eke+j10vBOO1ZHgd+OBfRb2RnEzeYVDjJaOkUj9TKU=;
	b=HFjiyXSFB5MLyo0YnQeRJgHeKtsOz8ksJ+TftcF3c9fgcRcuqt6i1IhYvyL4TY46dllQac
	yLONuAKKvE91tSMa9P3Jiatj3OEaijyActO3rLXGBqvNqloy/9WZ0CTuLpM9zQ0GsadTod
	bBwMUZvtWjLjF/ugwgJ/9AEYYuFst/4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-2kqMDMVKMCedEgY7rXBIyQ-1; Thu, 30 May 2024 09:31:36 -0400
X-MC-Unique: 2kqMDMVKMCedEgY7rXBIyQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF37181227E;
	Thu, 30 May 2024 13:31:35 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7EC962818;
	Thu, 30 May 2024 13:31:34 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.10-rc2
Date: Thu, 30 May 2024 15:29:44 +0200
Message-ID: <20240530132944.37714-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Hi Linus!

The following changes since commit 66ad4829ddd0b5540dc0b076ef2818e89c8f720e:

  Merge tag 'net-6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-05-23 12:49:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.10-rc2

for you to fetch changes up to 13c7c941e72908b8cce5a84b45a7b5e485ca12ed:

  netdev: add qstat for csum complete (2024-05-30 12:15:56 +0200)

----------------------------------------------------------------
Including fixes from bpf and netfilter.

Current release - regressions:

  - gro: initialize network_offset in network layer

  - tcp: reduce accepted window in NEW_SYN_RECV state

Current release - new code bugs:

  - eth: mlx5e: do not use ptp structure for tx ts stats when not initialized

  - eth: ice: check for unregistering correct number of devlink params

Previous releases - regressions:

  - bpf: Allow delete from sockmap/sockhash only if update is allowed

  - sched: taprio: extend minimum interval restriction to entire cycle too

  - netfilter: ipset: add list flush to cancel_gc

  - ipv4: fix address dump when IPv4 is disabled on an interface

  - sock_map: avoid race between sock_map_close and sk_psock_put

  - eth: mlx5: use mlx5_ipsec_rx_status_destroy to correctly delete status rules

Previous releases - always broken:

  - core: fix __dst_negative_advice() race

  - bpf:
    - fix multi-uprobe PID filtering logic
    - fix pkt_type override upon netkit pass verdict

  - netfilter: tproxy: bail out if IP has been disabled on the device

  - af_unix: annotate data-race around unix_sk(sk)->addr

  - eth: mlx5e: fix UDP GSO for encapsulated packets

  - eth: idpf: don't enable NAPI and interrupts prior to allocating Rx buffers

  - eth: i40e: fully suspend and resume IO operations in EEH case

  - eth: octeontx2-pf: free send queue buffers incase of leaf to inner

  - eth: ipvlan: dont Use skb->sk in ipvlan_process_v{4,6}_outbound

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alexander Lobakin (2):
      page_pool: fix &page_pool_params kdoc issues
      idpf: don't enable NAPI and interrupts prior to allocating Rx buffers

Alexander Maltsev (1):
      netfilter: ipset: Add list flush to cancel_gc

Alexander Mikhalitsyn (1):
      ipv4: correctly iterate over the target netns in inet_dump_ifaddr()

Alexei Starovoitov (1):
      Merge branch 'fix-bpf-multi-uprobe-pid-filtering-logic'

Andrii Nakryiko (5):
      bpf: fix multi-uprobe PID filtering logic
      bpf: remove unnecessary rcu_read_{lock,unlock}() in multi-uprobe attach logic
      libbpf: detect broken PID filtering logic for multi-uprobe
      selftests/bpf: extend multi-uprobe tests with child thread case
      selftests/bpf: extend multi-uprobe tests with USDTs

Carolina Jubran (1):
      net/mlx5e: Use rx_missed_errors instead of rx_dropped for reporting buffer exhaustion

Daniel Borkmann (4):
      netkit: Fix setting mac address in l2 mode
      netkit: Fix pkt_type override upon netkit pass verdict
      selftests/bpf: Add netkit tests for mac address
      selftests/bpf: Add netkit test for pkt_type

Dave Ertman (1):
      ice: check for unregistering correct number of devlink params

David S. Miller (1):
      Merge branch 'mlx5-fixes'

Edward Adam Davis (1):
      nfc/nci: Add the inconsistency check between the input data length and count

Eric Dumazet (3):
      netfilter: nfnetlink_queue: acquire rcu_read_lock() in instance_destroy_rcu()
      tcp: reduce accepted window in NEW_SYN_RECV state
      net: fix __dst_negative_advice() race

Eric Garver (1):
      netfilter: nft_fib: allow from forward/input without iif selector

Florian Westphal (1):
      netfilter: tproxy: bail out if IP has been disabled on the device

Friedrich Vock (1):
      bpf: Fix potential integer overflow in resolve_btfids

Gal Pressman (2):
      net/mlx5: Fix MTMP register capability offset in MCAM register
      net/mlx5e: Fix UDP GSO for encapsulated packets

Geliang Tang (1):
      selftests: hsr: Fix "File exists" errors for hsr_ping

Hariprasad Kelam (1):
      Octeontx2-pf: Free send queue buffers incase of leaf to inner

Horatiu Vultur (1):
      net: micrel: Fix lan8841_config_intr after getting out of sleep mode

Hui Wang (1):
      e1000e: move force SMBUS near the end of enable_ulp function

Ido Schimmel (1):
      ipv4: Fix address dump when IPv4 is disabled on an interface

Jacob Keller (1):
      ice: fix accounting if a VLAN already exists

Jakub Kicinski (5):
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      Merge branch 'intel-wired-lan-driver-updates-2024-05-23-ice-idpf'
      Merge branch 'selftests-mptcp-mark-unstable-subtests-as-flaky'
      Merge branch 'intel-wired-lan-driver-updates-2024-05-28-e1000e-i40e-ice'
      netdev: add qstat for csum complete

Jakub Sitnicki (3):
      bpf: Allow delete from sockmap/sockhash only if update is allowed
      Revert "bpf, sockmap: Prevent lock inversion deadlock in map delete elem"
      selftests/bpf: Cover verifier checks for mutating sockmap/sockhash

Kuniyuki Iwashima (2):
      af_unix: Annotate data-race around unix_sk(sk)->addr.
      af_unix: Read sk->sk_hash under bindlock during bind().

MD Danish Anwar (1):
      net: ti: icssg-prueth: Fix start counter for ft1 filter

Maher Sanalla (1):
      net/mlx5: Lag, do bond only if slaves agree on roce state

Mathieu Othacehe (1):
      net: phy: micrel: set soft_reset callback to genphy_soft_reset for KSZ8061

Matt Jan (1):
      connector: Fix invalid conversion in cn_proc.h

Matthieu Baerts (NGI0) (4):
      selftests: mptcp: lib: support flaky subtests
      selftests: mptcp: simult flows: mark 'unbalanced' tests as flaky
      selftests: mptcp: join: mark 'fastclose' tests as flaky
      selftests: mptcp: join: mark 'fail' tests as flaky

Minda Chen (1):
      MAINTAINERS: dwmac: starfive: update Maintainer

Pablo Neira Ayuso (2):
      netfilter: nft_payload: restore vlan q-in-q match support
      netfilter: nft_payload: skbuff vlan metadata mangle support

Paolo Abeni (1):
      Merge tag 'nf-24-05-29' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Parthiban Veerasooran (1):
      net: usb: smsc95xx: fix changing LED_SEL bit value updated from EEPROM

Paul Greenwalt (1):
      ice: fix 200G PHY types to link speed mapping

Rahul Rameshbabu (3):
      net/mlx5: Use mlx5_ipsec_rx_status_destroy to correctly delete status rules
      net/mlx5e: Fix IPsec tunnel mode offload feature check
      net/mlx5e: Do not use ptp structure for tx ts stats when not initialized

Rob Herring (Arm) (2):
      dt-bindings: net: pse-pd: microchip,pd692x0: Fix missing "additionalProperties" constraints
      dt-bindings: net: pse-pd: ti,tps23881: Fix missing "additionalProperties" constraints

Roded Zats (1):
      enic: Validate length of nl attributes in enic_set_vf_port

Shahab Vahedi (1):
      ARC, bpf: Fix issues reported by the static analyzers

Shay Agroskin (1):
      net: ena: Fix redundant device NUMA node override

Tariq Toukan (1):
      net/mlx5: Do not query MPIR on embedded CPU function

Thadeu Lima de Souza Cascardo (1):
      sock_map: avoid race between sock_map_close and sk_psock_put

Thinh Tran (2):
      i40e: factoring out i40e_suspend/i40e_resume
      i40e: Fully suspend and resume IO operations in EEH case

Thorsten Blum (1):
      docs: netdev: Fix typo in Signed-off-by tag

Tristram Ha (1):
      net: dsa: microchip: fix RGMII error in KSZ DSA driver

Vladimir Oltean (2):
      net/sched: taprio: make q->picos_per_byte available to fill_sched_entry()
      net/sched: taprio: extend minimum interval restriction to entire cycle too

Willem de Bruijn (1):
      net: gro: initialize network_offset in network layer

Xiaolei Wang (1):
      net:fec: Add fec_enet_deinit()

Xu Kuohai (1):
      MAINTAINERS: Add myself as reviewer of ARM64 BPF JIT

Yue Haibing (1):
      ipvlan: Dont Use skb->sk in ipvlan_process_v{4,6}_outbound

 .../bindings/net/pse-pd/microchip,pd692x0.yaml     |  11 +-
 .../bindings/net/pse-pd/ti,tps23881.yaml           |  18 ++
 Documentation/netlink/specs/netdev.yaml            |   4 +
 Documentation/process/maintainer-netdev.rst        |   2 +-
 MAINTAINERS                                        |   3 +-
 arch/arc/net/bpf_jit.h                             |   2 +-
 arch/arc/net/bpf_jit_arcv2.c                       |  10 +-
 arch/arc/net/bpf_jit_core.c                        |  22 +-
 drivers/net/dsa/microchip/ksz_common.c             |   2 +-
 drivers/net/ethernet/amazon/ena/ena_com.c          |  11 -
 drivers/net/ethernet/cisco/enic/enic_main.c        |  12 +
 drivers/net/ethernet/freescale/fec_main.c          |  10 +
 drivers/net/ethernet/intel/e1000e/ich8lan.c        |  22 ++
 drivers/net/ethernet/intel/e1000e/netdev.c         |  18 --
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 258 +++++++++++----------
 drivers/net/ethernet/intel/ice/devlink/devlink.c   |  31 ++-
 drivers/net/ethernet/intel/ice/ice_common.c        |  10 +
 drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c  |  11 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c         |   1 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |  12 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h        |   1 +
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c   |   4 +
 .../mellanox/mlx5/core/en_accel/en_accel.h         |   8 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c         |   3 +-
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.h       |  17 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |   4 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |  12 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c   |  12 +-
 drivers/net/ethernet/ti/icssg/icssg_classifier.c   |   2 +-
 drivers/net/ipvlan/ipvlan_core.c                   |   4 +-
 drivers/net/netkit.c                               |  30 ++-
 drivers/net/phy/micrel.c                           |  11 +-
 drivers/net/usb/smsc95xx.c                         |  11 +-
 drivers/nfc/virtual_ncidev.c                       |   4 +
 include/linux/etherdevice.h                        |   8 +
 include/linux/mlx5/mlx5_ifc.h                      |   4 +-
 include/net/dst_ops.h                              |   2 +-
 include/net/page_pool/types.h                      |   5 +-
 include/net/request_sock.h                         |  12 +
 include/net/sock.h                                 |  13 +-
 include/uapi/linux/cn_proc.h                       |   3 +-
 include/uapi/linux/netdev.h                        |   1 +
 kernel/bpf/verifier.c                              |  10 +-
 kernel/trace/bpf_trace.c                           |  10 +-
 net/core/sock_map.c                                |  22 +-
 net/ethernet/eth.c                                 |   4 +-
 net/ipv4/af_inet.c                                 |   2 +-
 net/ipv4/devinet.c                                 |   7 +-
 net/ipv4/netfilter/nf_tproxy_ipv4.c                |   2 +
 net/ipv4/route.c                                   |  22 +-
 net/ipv4/tcp_ipv4.c                                |   7 +-
 net/ipv4/tcp_minisocks.c                           |   7 +-
 net/ipv6/ip6_offload.c                             |   2 +-
 net/ipv6/route.c                                   |  29 +--
 net/ipv6/tcp_ipv6.c                                |   7 +-
 net/netfilter/ipset/ip_set_list_set.c              |   3 +
 net/netfilter/nfnetlink_queue.c                    |   2 +
 net/netfilter/nft_fib.c                            |   8 +-
 net/netfilter/nft_payload.c                        |  95 ++++++--
 net/sched/sch_taprio.c                             |  14 +-
 net/unix/af_unix.c                                 |  19 +-
 net/xfrm/xfrm_policy.c                             |  11 +-
 tools/bpf/resolve_btfids/main.c                    |   2 +-
 tools/include/uapi/linux/netdev.h                  |   1 +
 tools/lib/bpf/features.c                           |  31 ++-
 tools/testing/selftests/bpf/prog_tests/tc_netkit.c |  94 ++++++++
 .../selftests/bpf/prog_tests/uprobe_multi_test.c   | 134 ++++++++++-
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 tools/testing/selftests/bpf/progs/test_tc_link.c   |  35 ++-
 tools/testing/selftests/bpf/progs/uprobe_multi.c   |  50 +++-
 .../selftests/bpf/progs/verifier_sockmap_mutate.c  | 187 +++++++++++++++
 tools/testing/selftests/net/hsr/hsr_ping.sh        |   2 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  10 +-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  30 ++-
 tools/testing/selftests/net/mptcp/simult_flows.sh  |   6 +-
 .../tc-testing/tc-tests/qdiscs/taprio.json         |  44 ++++
 78 files changed, 1179 insertions(+), 381 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c


