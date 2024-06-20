Return-Path: <netdev+bounces-105362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1107910C1D
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 18:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4C31C208BE
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 16:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02431B29B6;
	Thu, 20 Jun 2024 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jW8l+4Qq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83CE1CD3D;
	Thu, 20 Jun 2024 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900614; cv=none; b=DXB3wzdlPefLlntfZVYO9qmLbtQqGDO9Vfz8QK1aqFOPXBdjTJv4rOEsp5dpvmB9WkhoxvfuytDBZahP0cXuZVB9g4qPo2xKvuWHA3TLb+CVP3MAnswGz9jnO/DklCR49w7HzdxGBcRxxFG93pxTI5CUfQ6Qnex31GdnR18e3tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900614; c=relaxed/simple;
	bh=cA6xfkPCA7PV7l7TkuYNFtjd8vwJZYn9Cq2GBBMIa9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tij0+4n6Utll9YI4amXDdmBS6Oyg/dyIYyuYPO6LJNSE8ystoQRbln+d5chYZxtIC5dGADXi8N3EA71lhSlZeyUMxN8l62c7NTB1exzpOiNYgwH0uWa+TX+iMRAEEzsgTRKwZbzyJ2zn/UWE8m7vvzTU/0hkGrq3J+0N9hXAHr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jW8l+4Qq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8179C2BD10;
	Thu, 20 Jun 2024 16:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718900614;
	bh=cA6xfkPCA7PV7l7TkuYNFtjd8vwJZYn9Cq2GBBMIa9Y=;
	h=From:To:Cc:Subject:Date:From;
	b=jW8l+4QqdYz41zrgkWVoXXMzEYTqoMMfLowBT6TRr4sth6chTVMZKOiUnsV/dlQRo
	 3U7BALa+BVXoUB5BfV9/6IHZklGl5of7D7q9P+cIVTcAydArnqGwEpOwTZfrt0HImy
	 gUpR/a3f3xuz8b2jK7S5KKAcnmm2pn0agod1LHA0asMoNPlUlQiuNqCEgj1fOzpu/a
	 Z3yfo9EfuJy3QD1pjdgJMb6wh0lZGIgcgYiRX9siwIdTsUvcbkyAKR4zTIaB7+i6zp
	 z421+QBvSyaKSn8VfHje+o0h+y+PiE47t0893bx733EitbeKCm6OEOzulMg81sCn+w
	 hjQNjQ8ZSqleg==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.10-rc5
Date: Thu, 20 Jun 2024 09:23:33 -0700
Message-ID: <20240620162333.2386649-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

Happy summer solstice! The line count is a bit inflated by a selftest
and update to a driver's FW interface header, in reality the PR is
slightly below average for us. We are expecting one driver fix from
Intel, but there are no big known issues.

The following changes since commit d20f6b3d747c36889b7ce75ee369182af3decb6b:

  Merge tag 'net-6.10-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-06-13 11:11:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.10-rc5

for you to fetch changes up to fba383985354e83474f95f36d7c65feb75dba19d:

  net: usb: rtl8150 fix unintiatilzed variables in rtl8150_get_link_ksettings (2024-06-20 07:15:17 -0700)

----------------------------------------------------------------
Including fixes from wireless, bpf and netfilter.

Current release - regressions:

 - ipv6: bring NLM_DONE out to a separate recv() again

Current release - new code bugs:

 - wifi: cfg80211: wext: set ssids=NULL for passive scans via old wext API

Previous releases - regressions:

 - wifi: mac80211: fix monitor channel setting with chanctx emulation
   (probably most awaited of the fixes in this PR, tracked by Thorsten)

 - usb: ax88179_178a: bring back reset on init, if PHY is disconnected

 - bpf: fix UML x86_64 compile failure with BPF

 - bpf: avoid splat in pskb_pull_reason(), sanity check added can be hit
   with malicious BPF

 - eth: mvpp2: use slab_build_skb() for packets in slab, driver was
   missed during API refactoring

 - wifi: iwlwifi: add missing unlock of mvm mutex

Previous releases - always broken:

 - ipv6: add a number of missing null-checks for in6_dev_get(), in case
   IPv6 disabling races with the datapath

 - bpf: fix reg_set_min_max corruption of fake_reg

 - sched: act_ct: add netns as part of the key of tcf_ct_flow_table

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Adrian Moreno (1):
      selftests: openvswitch: Set value to nla flags.

Aryan Srivastava (1):
      net: mvpp2: use slab_build_skb for oversized frames

Ayala Beker (1):
      wifi: iwlwifi: scan: correctly check if PSC listen period is needed

Dan Carpenter (1):
      ptp: fix integer overflow in max_vclocks_store

Daniel Borkmann (3):
      bpf: Fix reg_set_min_max corruption of fake_reg
      bpf: Reduce stack consumption in check_stack_write_fixed_off
      selftests/bpf: Add test coverage for reg_set_min_max handling

David Ruth (1):
      net/sched: act_api: fix possible infinite loop in tcf_idr_check_alloc()

David S. Miller (1):
      Merge branch 'virtio_net-csum-xdp-fixes'

Dmitry Antipov (1):
      wifi: cfg80211: wext: add extra SIOCSIWSCAN data check

Dmitry Safonov (1):
      net/tcp_ao: Don't leak ao_info on error-path

En-Wei Wu (1):
      ice: avoid IRQ collision to fix init failure on ACPI S3 resume

Eric Dumazet (4):
      tcp: clear tp->retrans_stamp in tcp_rcv_fastopen_synack()
      ipv6: prevent possible NULL deref in fib6_nh_init()
      ipv6: prevent possible NULL dereference in rt6_probe()
      xfrm6: check ip6_dst_idev() return value in xfrm6_get_saddr()

Florian Westphal (1):
      bpf: Avoid splat in pskb_pull_reason

Gavrilov Ilia (1):
      netrom: Fix a memory leak in nr_heartbeat_expiry()

Geetha sowjanya (1):
      octeontx2-pf: Fix linking objects into multiple modules

Heng Qi (2):
      virtio_net: checksum offloading handling fix
      virtio_net: fixing XDP for fully checksummed packets handling

Ignat Korchagin (1):
      net: do not leave a dangling sk pointer, when socket creation fails

Jakub Kicinski (6):
      Merge tag 'wireless-2024-06-14' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      netdev-genl: fix error codes when outputting XDP features
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      ipv6: bring NLM_DONE out to a separate recv() again
      Merge branch 'bnxt_en-bug-fixes-for-net'

Jianguo Wu (4):
      seg6: fix parameter passing when calling NF_HOOK() in End.DX4 and End.DX6 behaviors
      netfilter: move the sysctl nf_hooks_lwtunnel into the netfilter core
      selftests: add selftest for the SRv6 End.DX4 behavior with netfilter
      selftests: add selftest for the SRv6 End.DX6 behavior with netfilter

Jiri Pirko (1):
      selftests: virtio_net: add forgotten config options

Johannes Berg (2):
      wifi: cfg80211: wext: set ssids=NULL for passive scans
      wifi: mac80211: fix monitor channel with chanctx emulation

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: improve reset check

Jozsef Kadlecsik (1):
      netfilter: ipset: Fix suspicious rcu_dereference_protected()

Kenton Groombridge (1):
      wifi: mac80211: Avoid address calculations via out of bounds array indexing

Maciej Żenczykowski (1):
      bpf: fix UML x86_64 compile failure

Marcin Szycik (1):
      ice: Fix VSI list rule with ICE_SW_LKUP_LAST type

Matthieu Baerts (NGI0) (1):
      selftests: mptcp: userspace_pm: fixed subtest names

Michael Chan (2):
      bnxt_en: Update firmware interface to 1.10.3.44
      bnxt_en: Set TSO max segs on devices with limits

Oleksij Rempel (3):
      net: phy: dp83tg720: wake up PHYs in managed mode
      net: phy: dp83tg720: get master/slave configuration in link down state
      net: stmmac: Assign configured channel value to EXTTS event

Oliver Neukum (1):
      net: usb: rtl8150 fix unintiatilzed variables in rtl8150_get_link_ksettings

Ondrej Mosnacek (2):
      cipso: fix total option length computation
      cipso: make cipso_v4_skbuff_delattr() fully remove the CIPSO options

Paolo Abeni (2):
      Merge branch 'net-lan743x-fixes-for-multiple-wol-related-issues'
      Merge tag 'nf-24-06-19' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Paul Greenwalt (1):
      ice: fix 200G link speed message log

Pavan Chebbi (1):
      bnxt_en: Restore PTP tx_avail count in case of skb_pad() error

Raju Lakkaraju (3):
      net: lan743x: disable WOL upon resume to restore full data path operation
      net: lan743x: Support WOL at both the PHY and MAC appropriately
      net: phy: mxl-gpy: Remove interrupt mask clearing from config_init

Remi Pommarel (1):
      wifi: mac80211: Recalc offload when monitor stop

Shaul Triebitz (2):
      wifi: iwlwifi: mvm: unlock mvm mutex
      wifi: iwlwifi: mvm: fix ROC version check

Simon Horman (2):
      selftests: openvswitch: Use bash as interpreter
      octeontx2-pf: Add error handling to VLAN unoffload handling

Stanislav Fomichev (1):
      MAINTAINERS: mailmap: Update Stanislav's email address

Stefan Wahren (1):
      qca_spi: Make interrupt remembering atomic

Tony Ambardar (2):
      compiler_types.h: Define __retain for __attribute__((__retain__))
      bpf: Harden __bpf_kfunc tag against linker kfunc removal

Wojciech Drewek (1):
      ice: implement AQ download pkg retry

Xiaolei Wang (1):
      net: stmmac: No need to calculate speed divider when offload is disabled

Xin Long (2):
      tipc: force a dst refcount before doing decryption
      sched: act_ct: add netns into the key of tcf_ct_flow_table

Yue Haibing (1):
      netns: Make get_net_ns() handle zero refcount net

 .mailmap                                           |   1 +
 MAINTAINERS                                        |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   8 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h      | 311 +++++++++++--------
 drivers/net/ethernet/intel/ice/ice_ddp.c           |  23 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |  10 +-
 drivers/net/ethernet/intel/ice/ice_switch.c        |   6 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |   5 +-
 .../net/ethernet/marvell/octeontx2/nic/Makefile    |   3 +-
 .../ethernet/marvell/octeontx2/nic/otx2_dcbnl.c    |   7 +
 .../ethernet/marvell/octeontx2/nic/otx2_devlink.c  |   2 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |   5 +-
 drivers/net/ethernet/microchip/lan743x_ethtool.c   |  44 ++-
 drivers/net/ethernet/microchip/lan743x_main.c      |  48 ++-
 drivers/net/ethernet/microchip/lan743x_main.h      |  28 ++
 drivers/net/ethernet/qualcomm/qca_debug.c          |   6 +-
 drivers/net/ethernet/qualcomm/qca_spi.c            |  16 +-
 drivers/net/ethernet/qualcomm/qca_spi.h            |   3 +-
 .../net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c  |   6 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |  40 +--
 drivers/net/phy/dp83tg720.c                        |  38 ++-
 drivers/net/phy/mxl-gpy.c                          |  58 ++--
 drivers/net/usb/ax88179_178a.c                     |  18 +-
 drivers/net/usb/rtl8150.c                          |   3 +-
 drivers/net/virtio_net.c                           |  32 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |   2 +
 drivers/ptp/ptp_sysfs.c                            |   3 +-
 include/linux/bpf_verifier.h                       |   2 +
 include/linux/btf.h                                |   2 +-
 include/linux/compiler_types.h                     |  23 ++
 include/net/netns/netfilter.h                      |   3 +
 kernel/bpf/verifier.c                              |  25 +-
 net/core/filter.c                                  |   5 +
 net/core/net_namespace.c                           |   9 +-
 net/core/netdev-genl.c                             |  16 +-
 net/core/sock.c                                    |   3 +
 net/ipv4/cipso_ipv4.c                              |  75 +++--
 net/ipv4/tcp_ao.c                                  |   6 +-
 net/ipv4/tcp_input.c                               |   1 +
 net/ipv6/ip6_fib.c                                 |   3 +-
 net/ipv6/route.c                                   |   4 +-
 net/ipv6/seg6_local.c                              |   8 +-
 net/ipv6/xfrm6_policy.c                            |   8 +-
 net/mac80211/driver-ops.c                          |  17 ++
 net/mac80211/iface.c                               |  22 +-
 net/mac80211/scan.c                                |  17 +-
 net/mac80211/util.c                                |   2 +-
 net/netfilter/core.c                               |  13 +-
 net/netfilter/ipset/ip_set_core.c                  |  11 +-
 net/netfilter/nf_conntrack_standalone.c            |  15 -
 net/netfilter/nf_hooks_lwtunnel.c                  |  67 ++++
 net/netfilter/nf_internals.h                       |   6 +
 net/netrom/nr_timer.c                              |   3 +-
 net/sched/act_api.c                                |   3 +-
 net/sched/act_ct.c                                 |  16 +-
 net/tipc/node.c                                    |   1 +
 net/wireless/scan.c                                |  12 +-
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 .../selftests/bpf/progs/verifier_or_jmp32_k.c      |  41 +++
 .../selftests/drivers/net/virtio_net/config        |   8 +-
 tools/testing/selftests/net/Makefile               |   2 +
 tools/testing/selftests/net/config                 |   2 +
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |  46 +--
 .../selftests/net/openvswitch/openvswitch.sh       |   2 +-
 .../testing/selftests/net/openvswitch/ovs-dpctl.py |   2 +-
 .../selftests/net/srv6_end_dx4_netfilter_test.sh   | 335 ++++++++++++++++++++
 .../selftests/net/srv6_end_dx6_netfilter_test.sh   | 340 +++++++++++++++++++++
 70 files changed, 1558 insertions(+), 353 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_or_jmp32_k.c
 create mode 100755 tools/testing/selftests/net/srv6_end_dx4_netfilter_test.sh
 create mode 100755 tools/testing/selftests/net/srv6_end_dx6_netfilter_test.sh

