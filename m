Return-Path: <netdev+bounces-213679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B3CB2641F
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 13:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 872553AF9D4
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 11:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437CB2F39D9;
	Thu, 14 Aug 2025 11:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BsqKCXk0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B20E2EFDAC
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 11:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755170510; cv=none; b=HvLvvxyz6eXb79verXosIN+ad0QiLQwC65aP2LVON9kD7zq6GhuxI0UA2/XWIOGyu3hyWdTg1r7ked1aRCUSOL5mGeXWMuBc0OlF1/d4GveV/suELMqyMsGybeemseQ4c9xb883hyjpvUt/K4v+k35LD+kt4ymqNxsH8FltEdOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755170510; c=relaxed/simple;
	bh=n+c54q/JIitz3ZcglzykxPKObG0OyoAyZeiO108zw6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LlFU31TR/qN0QFsyzqcUGKxdlAa636qnJCNlbp2LoXINJyfDNZ9jy6tQZZEu/KnHMZ1iHIqPQqm19A4w55D/ZiDRj53zTj1Ic3htFLZ4sNWmCB6Tpkok0egKOJw1ZkDVpHmerlvRcf7/YKag30Miui9LMEFdnOzBSh6utezOrtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BsqKCXk0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755170507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zfaxiYyd5Dr5mQ5lKs2Zw3QQyzDjjlKEaB38MzjfWHM=;
	b=BsqKCXk0TxKab5ql3cNqAvotjvy5AHVKdg5gSEFYYsL7i/gusNoc7VfNNs0JiGaCOgjj9B
	TIePcysbR+m/QcQvK35jxmxWCyraQnJlAb05tCiBuSn159Lo9VvNgr2f8WkWnh1/3R55gI
	dbASr1LsXNikejPL8oJ9ASfeN3uZnxM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-hfjVm0_QMDWueHjvpwrIvA-1; Thu,
 14 Aug 2025 07:21:43 -0400
X-MC-Unique: hfjVm0_QMDWueHjvpwrIvA-1
X-Mimecast-MFC-AGG-ID: hfjVm0_QMDWueHjvpwrIvA_1755170502
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90CFA1955BD9;
	Thu, 14 Aug 2025 11:21:42 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.79])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 87B4D18003FC;
	Thu, 14 Aug 2025 11:21:40 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.17-rc2
Date: Thu, 14 Aug 2025 13:21:01 +0200
Message-ID: <20250814112101.35891-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Linus!

The following changes since commit 37816488247ddddbc3de113c78c83572274b1e2e:

  Merge tag 'net-6.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-08-08 07:03:25 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.17-rc2

for you to fetch changes up to 4faff70959d51078f9ee8372f8cff0d7045e4114:

  net: usb: asix_devices: add phy_mask for ax88772 mdio bus (2025-08-14 10:09:28 +0200)

----------------------------------------------------------------
Including fixes from Netfilter and IPsec.

Current release - regressions:

  - netfilter: nft_set_pipapo:
    - don't return bogus extension pointer
    - fix null deref for empty set

Current release - new code bugs:

  - core: prevent deadlocks when enabling NAPIs with mixed kthread config

  - eth: netdevsim: Fix wild pointer access in nsim_queue_free().

Previous releases - regressions:

  - page_pool: allow enabling recycling late, fix false positive warning

  - sched: ets: use old 'nbands' while purging unused classes

  - xfrm:
    - restore GSO for SW crypto
    - bring back device check in validate_xmit_xfrm

  - tls: handle data disappearing from under the TLS ULP

  - ptp: prevent possible ABBA deadlock in ptp_clock_freerun()

  - eth: bnxt: fill data page pool with frags if PAGE_SIZE > BNXT_RX_PAGE_SIZE

  - eth: hv_netvsc: fix panic during namespace deletion with VF

Previous releases - always broken:

  - netfilter: fix refcount leak on table dump

  - vsock: do not allow binding to VMADDR_PORT_ANY

  - sctp: linearize cloned gso packets in sctp_rcv

  - eth: hibmcge: fix the division by zero issue

  - eth: microchip: fix KSZ8863 reset problem

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alok Tiwari (1):
      net: ti: icss-iep: Fix incorrect type for return value in extts_enable()

Arnd Bergmann (1):
      netfilter: add back NETFILTER_XTABLES dependencies

Buday Csaba (1):
      net: mdiobus: release reset_gpio in mdiobus_unregister_device()

Budimir Markovic (1):
      vsock: Do not allow binding to VMADDR_PORT_ANY

Clark Wang (1):
      net: phy: nxp-c45-tja11xx: fix the PHY ID mismatch issue when using C45

Dan Carpenter (1):
      netfilter: conntrack: clean up returns in nf_conntrack_log_invalid_sysctl()

Dave Hansen (3):
      MAINTAINERS: Mark Intel WWAN IOSM driver as orphaned
      MAINTAINERS: Mark Intel PTP DFL ToD as orphaned
      MAINTAINERS: Remove bouncing T7XX reviewer

David Wei (1):
      bnxt: fill data page pool with frags if PAGE_SIZE > BNXT_RX_PAGE_SIZE

Davide Caratti (2):
      net/sched: ets: use old 'nbands' while purging unused classes
      selftests: net/forwarding: test purge of active DWRR classes

Fabio Porcedda (1):
      net: usb: qmi_wwan: add Telit Cinterion FN990A w/audio composition

Florian Westphal (5):
      MAINTAINERS: resurrect my netfilter maintainer entry
      netfilter: ctnetlink: fix refcount leak on table dump
      netfilter: ctnetlink: remove refcounting in expectation dumpers
      netfilter: nft_set_pipapo: don't return bogus extension pointer
      netfilter: nft_set_pipapo: fix null deref for empty set

Frederic Weisbecker (1):
      ipvs: Fix estimator kthreads preferred affinity

Haiyang Zhang (1):
      hv_netvsc: Fix panic during namespace deletion with VF

Jakub Kicinski (11):
      Merge tag 'nf-25-08-07' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge branch 'there-are-some-bugfix-for-hibmcge-ethernet-driver'
      net: page_pool: allow enabling recycling late, fix false positive warning
      selftests: drv-net: don't assume device has only 2 queues
      net: update NAPI threaded config even for disabled NAPIs
      net: prevent deadlocks when enabling NAPIs with mixed kthread config
      tls: handle data disappearing from under the TLS ULP
      selftests: tls: test TCP stealing data from under the TLS socket
      Merge tag 'nf-25-08-13' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge branch '10GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch 'ets-use-old-nbands-while-purging-unused-classes'

Jedrzej Jagielski (2):
      devlink: let driver opt out of automatic phys_port_name generation
      ixgbe: prevent from unwanted interface name changes

Jeff Layton (1):
      ref_tracker: use %p instead of %px in debugfs dentry name

Jeongjun Park (1):
      ptp: prevent possible ABBA deadlock in ptp_clock_freerun()

Jijie Shao (3):
      net: hibmcge: fix rtnl deadlock issue
      net: hibmcge: fix the division by zero issue
      net: hibmcge: fix the np_link_fail error reporting issue

Jordan Rife (1):
      docs: Fix name for net.ipv4.udp_child_hash_entries

Kuniyuki Iwashima (1):
      netdevsim: Fix wild pointer access in nsim_queue_free().

MD Danish Anwar (1):
      net: ti: icssg-prueth: Fix emac link speed handling

Matt Johnston (1):
      net: mctp: Fix bad kfree_skb in bind lookup test

Pablo Neira Ayuso (2):
      netfilter: nft_socket: remove WARN_ON_ONCE with huge level value
      netfilter: nf_tables: reject duplicate device on updates

Paolo Abeni (3):
      Merge branch 'fix-broken-link-with-th1520-gmac-when-linkspeed-changes'
      Merge branch 'net-prevent-deadlocks-and-mis-configuration-with-per-napi-threaded-config'
      Merge tag 'ipsec-2025-08-11' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec

Russell King (Oracle) (2):
      net: stmmac: rk: put the PHY clock on remove
      net: stmmac: dwc-qos: fix clk prepare/enable leak on probe failure

Sabrina Dubroca (4):
      xfrm: flush all states in xfrm_state_fini
      xfrm: restore GSO for SW crypto
      xfrm: bring back device check in validate_xmit_xfrm
      udp: also consider secpath when evaluating ipsec use for checksumming

Stanislav Fomichev (2):
      net: lapbether: ignore ops-locked netdevs
      hamradio: ignore ops-locked netdevs

Steffen Klassert (1):
      Merge branch 'xfrm: some fixes for GSO with SW crypto'

Sven Stegemann (1):
      net: kcm: Fix race condition in kcm_unattach()

Tristram Ha (1):
      net: dsa: microchip: Fix KSZ8863 reset problem

Xin Long (1):
      sctp: linearize cloned gso packets in sctp_rcv

Xu Yang (1):
      net: usb: asix_devices: add phy_mask for ax88772 mdio bus

Yao Zi (3):
      dt-bindings: net: thead,th1520-gmac: Describe APB interface clock
      net: stmmac: thead: Get and enable APB clock on initialization
      riscv: dts: thead: Add APB clocks for TH1520 GMACs

 .../devicetree/bindings/net/thead,th1520-gmac.yaml |  6 +-
 Documentation/networking/ip-sysctl.rst             |  2 +-
 MAINTAINERS                                        |  8 +--
 arch/riscv/boot/dts/thead/th1520.dtsi              | 10 ++--
 drivers/net/dsa/microchip/ksz8.c                   | 20 ++++---
 drivers/net/dsa/microchip/ksz_common.c             |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          | 21 +++++--
 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c   | 14 ++---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c    | 15 ++++-
 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.h  |  7 ++-
 drivers/net/ethernet/intel/ixgbe/devlink/devlink.c |  1 +
 .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    | 13 +----
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     |  6 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c  | 14 +++++
 drivers/net/ethernet/ti/icssg/icss_iep.c           |  3 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c       |  6 ++
 drivers/net/hamradio/bpqether.c                    |  2 +-
 drivers/net/hyperv/hyperv_net.h                    |  3 +
 drivers/net/hyperv/netvsc_drv.c                    | 29 +++++++++-
 drivers/net/netdevsim/netdev.c                     | 10 +++-
 drivers/net/phy/mdio_bus.c                         |  1 +
 drivers/net/phy/mdio_bus_provider.c                |  3 -
 drivers/net/phy/nxp-c45-tja11xx.c                  | 23 ++++----
 drivers/net/usb/asix_devices.c                     |  1 +
 drivers/net/usb/qmi_wwan.c                         |  1 +
 drivers/net/wan/lapbether.c                        |  2 +-
 drivers/ptp/ptp_private.h                          |  5 ++
 drivers/ptp/ptp_vclock.c                           |  7 +++
 include/linux/netdevice.h                          |  5 +-
 include/net/devlink.h                              |  6 +-
 include/net/ip_vs.h                                | 13 +++++
 include/net/kcm.h                                  |  1 -
 include/net/page_pool/types.h                      |  2 +
 kernel/kthread.c                                   |  1 +
 lib/ref_tracker.c                                  |  2 +-
 net/bridge/netfilter/Kconfig                       |  1 +
 net/core/dev.c                                     | 12 +++-
 net/core/dev.h                                     |  8 +++
 net/core/page_pool.c                               | 29 ++++++++++
 net/devlink/port.c                                 |  2 +-
 net/ipv4/netfilter/Kconfig                         |  3 +
 net/ipv4/udp_offload.c                             |  2 +-
 net/ipv6/netfilter/Kconfig                         |  1 +
 net/ipv6/xfrm6_tunnel.c                            |  2 +-
 net/kcm/kcmsock.c                                  | 10 +---
 net/mctp/test/route-test.c                         |  1 -
 net/netfilter/ipvs/ip_vs_est.c                     |  3 +-
 net/netfilter/nf_conntrack_netlink.c               | 65 ++++++++++------------
 net/netfilter/nf_conntrack_standalone.c            |  6 +-
 net/netfilter/nf_tables_api.c                      | 30 ++++++++++
 net/netfilter/nft_set_pipapo.c                     |  5 +-
 net/netfilter/nft_set_pipapo_avx2.c                | 12 ++--
 net/netfilter/nft_socket.c                         |  2 +-
 net/sched/sch_ets.c                                | 11 ++--
 net/sctp/input.c                                   |  2 +-
 net/tls/tls.h                                      |  2 +-
 net/tls/tls_strp.c                                 | 11 +++-
 net/tls/tls_sw.c                                   |  3 +-
 net/vmw_vsock/af_vsock.c                           |  3 +-
 net/xfrm/xfrm_device.c                             | 12 +++-
 net/xfrm/xfrm_state.c                              |  2 +-
 .../testing/selftests/drivers/net/napi_threaded.py | 10 ++--
 tools/testing/selftests/net/forwarding/sch_ets.sh  |  1 +
 .../selftests/net/forwarding/sch_ets_tests.sh      |  8 +++
 tools/testing/selftests/net/tls.c                  | 63 +++++++++++++++++++++
 65 files changed, 429 insertions(+), 157 deletions(-)


