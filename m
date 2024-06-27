Return-Path: <netdev+bounces-107311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CADA91A8AC
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C465BB23A55
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 14:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B1319598E;
	Thu, 27 Jun 2024 14:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKfz4fhu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3FA19581D
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497347; cv=none; b=KrDbjtizOUzZj/4KCDY+wmEx26t+rUQev28KZOg3iRdCjJP1dBy0cas/f59xmlM/9/ZCku11d0ELc2WKY54eMgISZ/LjRhgOEmylxIFJIR9+9oxRfxetQd9KsQ9YmqayXn93YERHMTXXJiS65ORnjOz0ccKqGoaYadRlFskjDgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497347; c=relaxed/simple;
	bh=n4HIkVyl2LxxKLdNc1L3vZhE8WXNvJbiOIbwjTU0EFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PafjVHeDxeDX//amwmMIh1ojvohEQMlzXN8rwxO3xzB9GzdwoJSs3D8ROKJ78bsK/daune/7+wkRrYhdOZ/R/T2dP5W3sDP+WODgywHJcrGWumBiFzEldQZZmcxG3yEsqk7Cb4in/dDhWGEoXNf/m6s8T98OchPn/Tkd/P1v9iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WKfz4fhu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719497344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m2MJw8DUeIzMnv5roWQI911cUTl2Nf3F1gSFyr8dYmc=;
	b=WKfz4fhuqpBXRn81seqNkNUh3UZD+2oB4eX0jp5zImc0Iec6JyHvYoHi4SjZImDwBGyz9j
	fHuLqrZYmaxCdWf6YQuB+MLBxit8qnCXQSer1rqnXBvPGWHz+E0em5uY2h9daB5LrKbqWQ
	146ptZUlLKsFFeqDrCtGo2QFBeo+L+Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-mmKBDl6xNbCav_PzwwuN8A-1; Thu,
 27 Jun 2024 10:09:01 -0400
X-MC-Unique: mmKBDl6xNbCav_PzwwuN8A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6A1F19560B0;
	Thu, 27 Jun 2024 14:08:59 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.168])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5DCBA19560A3;
	Thu, 27 Jun 2024 14:08:57 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.10-rc6
Date: Thu, 27 Jun 2024 16:08:37 +0200
Message-ID: <20240627140837.42758-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi Linus!

There are a bunch of regressions addressed by this PR, but hopefully
nothing spectacular. We are still waiting the driver fix from
Intel, mentioned by Jakub in the previous net PR.

The following changes since commit d5a7fc58da039903b332041e8c67daae36f08b50:

  Merge tag 'net-6.10-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-06-20 10:49:50 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.10-rc6

for you to fetch changes up to b62cb6a7e83622783100182d9b70e9c70393cfbe:

  Merge tag 'nf-24-06-27' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf (2024-06-27 13:00:50 +0200)

----------------------------------------------------------------
Including fixes from can, bpf and netfilter.

Current release - regressions:

  - core: add softirq safety to netdev_rename_lock

  - tcp: fix tcp_rcv_fastopen_synack() to enter TCP_CA_Loss for failed TFO

  - batman-adv: fix RCU race at module unload time

Current release - new code bugs:

Previous releases - regressions:

  - openvswitch: get related ct labels from its master if it is not confirmed

  - eth: bonding: fix incorrect software timestamping report

  - eth: mlxsw: fix memory corruptions on spectrum-4 systems

  - eth: ionic: use dev_consume_skb_any outside of napi

Previous releases - always broken:

  - netfilter: fully validate NFT_DATA_VALUE on store to data registers

  - unix: several fixes for OoB data

  - tcp: fix race for duplicate reqsk on identical SYN

  - bpf:
    - fix may_goto with negative offset.
    - fix the corner case with may_goto and jump to the 1st insn.
    - fix overrunning reservations in ringbuf

  - can:
    - j1939: recover socket queue on CAN bus error during BAM transmission
    - mcp251xfd: fix infinite loop when xmit fails

  - dsa: microchip: monitor potential faults in half-duplex mode

  - eth: vxlan: pull inner IP header in vxlan_xmit_one()

  - eth: ionic: fix kernel panic due to multi-buffer handling

Misc:

  - selftest: unix tests refactor and a lot of new cases added

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alexei Starovoitov (6):
      Merge branch 'bpf-fix-missed-var_off-related-to-movsx-in-verifier'
      bpf: Fix remap of arena.
      bpf: Fix the corner case with may_goto and jump to the 1st insn.
      selftests/bpf: Tests with may_goto and jumps to the 1st insn
      bpf: Fix may_goto with negative offset.
      selftests/bpf: Add tests for may_goto with negative offset.

Aryan Srivastava (1):
      net: mvpp2: fill-in dev_port attribute

Chen Ni (1):
      can: kvaser_usb: fix return value for hif_usb_send_regout

Daniel Borkmann (2):
      bpf: Fix overrunning reservations in ringbuf
      selftests/bpf: Add more ring buffer test coverage

Daniele Palmas (1):
      net: usb: qmi_wwan: add Telit FN912 compositions

Daniil Dulov (1):
      xdp: Remove WARN() from __xdp_reg_mem_model()

David S. Miller (2):
      Merge branch 'mlxsw-fixes'
      Merge branch 'phy-microchip-ksz-9897-errata'

Enguerrand de Ribaucourt (3):
      net: phy: micrel: add Microchip KSZ 9477 to the device table
      net: dsa: microchip: use collision based back pressure mode
      net: dsa: microchip: monitor potential faults in half-duplex mode

Eric Dumazet (1):
      net: add softirq safety to netdev_rename_lock

Frank Li (1):
      dt-bindings: net: fman: remove ptp-timer from required list

Guillaume Nault (1):
      vxlan: Pull inner IP header in vxlan_xmit_one().

Hangbin Liu (1):
      bonding: fix incorrect software timestamping report

Ido Schimmel (2):
      mlxsw: pci: Fix driver initialization with Spectrum-4
      mlxsw: spectrum_buffers: Fix memory corruptions on Spectrum-4 systems

Jakub Kicinski (3):
      Merge tag 'linux-can-fixes-for-6.10-20240621' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
      Merge tag 'batadv-net-pullrequest-20240621' of git://git.open-mesh.org/linux-merge
      Merge tag 'for-netdev' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/bpf/bpf

Jan Sokolowski (1):
      ice: Rebuild TC queues on VSI queue reconfiguration

Jianguo Wu (1):
      netfilter: fix undefined reference to 'netfilter_lwtunnel_*' when CONFIG_SYSCTL=n

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: improve link status logs

Kory Maincent (2):
      net: pse-pd: Kconfig: Fix missing firmware loader config select
      netlink: specs: Fix pse-set command attributes

Kuniyuki Iwashima (12):
      selftest: af_unix: Add Kconfig file.
      selftest: af_unix: Remove test_unix_oob.c.
      selftest: af_unix: Add msg_oob.c.
      af_unix: Stop recv(MSG_PEEK) at consumed OOB skb.
      af_unix: Don't stop recv(MSG_DONTWAIT) if consumed OOB skb is at the head.
      selftest: af_unix: Add non-TCP-compliant test cases in msg_oob.c.
      af_unix: Don't stop recv() at consumed ex-OOB skb.
      selftest: af_unix: Add SO_OOBINLINE test cases in msg_oob.c
      selftest: af_unix: Check SIGURG after every send() in msg_oob.c
      selftest: af_unix: Check EPOLLPRI after every send()/recv() in msg_oob.c
      af_unix: Fix wrong ioctl(SIOCATMARK) when consumed OOB skb is at the head.
      selftest: af_unix: Check SIOCATMARK after every send()/recv() in msg_oob.c.

Linus Lüssing (1):
      Revert "batman-adv: prefer kfree_rcu() over call_rcu() with free-only callbacks"

Ma Ke (1):
      net: mana: Fix possible double free in error handling path

Matt Bobrowski (1):
      bpf: Update BPF LSM maintainer list

Neal Cardwell (1):
      tcp: fix tcp_rcv_fastopen_synack() to enter TCP_CA_Loss for failed TFO

Nick Child (2):
      ibmvnic: Free any outstanding tx skbs during scrq reset
      ibmvnic: Add tx check to prevent skb leak

Oleksij Rempel (2):
      net: can: j1939: enhanced error handling for tightly received RTS messages in xtp_rx_rts_session_new
      net: can: j1939: recover socket queue on CAN bus error during BAM transmission

Pablo Neira Ayuso (1):
      netfilter: nf_tables: fully validate NFT_DATA_VALUE on store to data registers

Paolo Abeni (2):
      Merge branch 'af_unix-fix-bunch-of-msg_oob-bugs-and-add-new-tests'
      Merge tag 'nf-24-06-27' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Ratheesh Kannoth (1):
      octeontx2-pf: Fix coverity and klockwork issues in octeon PF driver

Shannon Nelson (2):
      net: remove drivers@pensando.io from MAINTAINERS
      ionic: use dev_consume_skb_any outside of napi

Shigeru Yoshida (1):
      net: can: j1939: Initialize unused data in j1939_send_one()

Sven Eckelmann (1):
      batman-adv: Don't accept TT entries for out-of-spec VIDs

Taehee Yoo (1):
      ionic: fix kernel panic due to multi-buffer handling

Tristram Ha (2):
      net: dsa: microchip: fix initial port flush problem
      net: dsa: microchip: fix wrong register write when masking interrupt

Vitor Soares (1):
      can: mcp251xfd: fix infinite loop when xmit fails

Xin Long (1):
      openvswitch: get related ct labels from its master if it is not confirmed

Yonghong Song (3):
      bpf: Add missed var_off setting in set_sext32_default_val()
      bpf: Add missed var_off setting in coerce_subreg_to_size_sx()
      selftests/bpf: Add a few tests to cover

Yunseong Kim (1):
      tracing/net_sched: NULL pointer dereference in perf_trace_qdisc_reset()

luoxuanqiang (1):
      Fix race for duplicate reqsk on identical SYN

 .../devicetree/bindings/net/fsl,fman-dtsec.yaml    |   1 -
 Documentation/netlink/specs/ethtool.yaml           |   7 +-
 MAINTAINERS                                        |   4 +-
 drivers/net/bonding/bond_main.c                    |   3 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c     |  14 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c       |  55 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h          |   5 +
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   |   2 +-
 drivers/net/dsa/microchip/ksz9477.c                |  61 +-
 drivers/net/dsa/microchip/ksz9477.h                |   2 +
 drivers/net/dsa/microchip/ksz9477_reg.h            |  11 +-
 drivers/net/dsa/microchip/ksz_common.c             |  13 +-
 drivers/net/dsa/microchip/ksz_common.h             |   1 +
 drivers/net/ethernet/ibm/ibmvnic.c                 |  18 +
 drivers/net/ethernet/intel/ice/ice_main.c          |  10 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |   1 +
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |  10 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_reg.h  |  55 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |   2 +-
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c   |   3 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c          |  18 +-
 drivers/net/ethernet/mellanox/mlxsw/reg.h          |   2 +
 .../net/ethernet/mellanox/mlxsw/spectrum_buffers.c |  20 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |   2 +
 drivers/net/ethernet/pensando/ionic/ionic_dev.h    |   4 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |   2 +-
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c   |  55 +-
 drivers/net/phy/micrel.c                           |   1 +
 drivers/net/pse-pd/Kconfig                         |   1 +
 drivers/net/usb/ax88179_178a.c                     |   6 +-
 drivers/net/usb/qmi_wwan.c                         |   2 +
 drivers/net/vxlan/vxlan_core.c                     |   9 +-
 include/net/inet_connection_sock.h                 |   2 +-
 include/net/netfilter/nf_tables.h                  |   5 +
 include/trace/events/qdisc.h                       |   2 +-
 kernel/bpf/arena.c                                 |  16 +-
 kernel/bpf/ringbuf.c                               |  31 +-
 kernel/bpf/verifier.c                              |  61 +-
 net/batman-adv/originator.c                        |  27 +
 net/batman-adv/translation-table.c                 |  47 +-
 net/can/j1939/main.c                               |   6 +-
 net/can/j1939/transport.c                          |  21 +-
 net/core/dev.c                                     |  12 +-
 net/core/xdp.c                                     |   4 +-
 net/dccp/ipv4.c                                    |   7 +-
 net/dccp/ipv6.c                                    |   7 +-
 net/ipv4/inet_connection_sock.c                    |  17 +-
 net/ipv4/tcp_input.c                               |  45 +-
 net/netfilter/nf_hooks_lwtunnel.c                  |   3 +
 net/netfilter/nf_tables_api.c                      |   8 +-
 net/netfilter/nft_lookup.c                         |   3 +-
 net/openvswitch/conntrack.c                        |   7 +-
 net/unix/af_unix.c                                 |  37 +-
 tools/testing/selftests/bpf/Makefile               |   2 +-
 tools/testing/selftests/bpf/prog_tests/ringbuf.c   |  56 ++
 .../selftests/bpf/progs/test_ringbuf_write.c       |  46 ++
 .../bpf/progs/verifier_iterating_callbacks.c       | 146 ++++
 tools/testing/selftests/bpf/progs/verifier_movsx.c |  63 ++
 tools/testing/selftests/net/.gitignore             |   1 -
 tools/testing/selftests/net/af_unix/Makefile       |   2 +-
 tools/testing/selftests/net/af_unix/config         |   3 +
 tools/testing/selftests/net/af_unix/msg_oob.c      | 734 +++++++++++++++++++++
 .../testing/selftests/net/af_unix/test_unix_oob.c  | 436 ------------
 63 files changed, 1663 insertions(+), 594 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_write.c
 create mode 100644 tools/testing/selftests/net/af_unix/config
 create mode 100644 tools/testing/selftests/net/af_unix/msg_oob.c
 delete mode 100644 tools/testing/selftests/net/af_unix/test_unix_oob.c


