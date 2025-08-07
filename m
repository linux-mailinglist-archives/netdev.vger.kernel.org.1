Return-Path: <netdev+bounces-212064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4324CB1DA62
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 16:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13F3D7A267E
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 14:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18C31A2390;
	Thu,  7 Aug 2025 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwDN4VG0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACDC611E;
	Thu,  7 Aug 2025 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754578181; cv=none; b=seGT6EMR/S8ZvN3wXwhYI62FGRW2rSqhKZddlI+u3yEK7EGD/W1ttPUzFKHMawfRKUDNZuyxrFLSXss3vJoDR6t3cSmkuKVjwWA29VGqccum7Xi0KX1r7MLM5kBvAd1ziPkIUJGVtlz+vLH1b0aI6C2cx7mDopmXVm2v1FHl59c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754578181; c=relaxed/simple;
	bh=IFWTg6TiKlUSHpwoiM0AKsYu+SDUeTwUkLonXsbAXWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mrg5ArtVJyyjXm8TGhA8PxYKq97OtwvRHnYERk1ia9jT3GYTNYoiWgrHxSZXoDaljIWJEFTKC32LYZVyn90QY90u5Dy4KIBRRQ3kl6MGiU5aWycte/taML2dR4cOxeqTrkzMQMuaCbxWxp58G3hOu4XrQkw7wjBseKpJTYawZxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwDN4VG0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F4AC4CEEB;
	Thu,  7 Aug 2025 14:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754578181;
	bh=IFWTg6TiKlUSHpwoiM0AKsYu+SDUeTwUkLonXsbAXWw=;
	h=From:To:Cc:Subject:Date:From;
	b=fwDN4VG05UyE9iJgZztVaJSgjKMPqVlYgXmSQ/djxUH7UxTUXPHc3G1c7GLNhfz3G
	 WEuPvmBHEYVwv43tZwWsbEQSaY4UjTlM+6M50X1z1idvnShyAejQ0Emto8O5CUCEtp
	 ytgj4cjuFSh6Nmzzct8/U0991EN+yqmkhJcO3MDICD2clpQXk9f39GCY67aHwxshCY
	 FfVYviyst2r0c9DP5ccRSn82CV5iChPGZGPLy5a9ktp0x2aGzE47o4KI8pmnftTZ/0
	 g7fV/HxNQ1O9Mag3/bVSU/e7pqvHzUWeEZxvM0UT4v4R/My9PlEZ8WHPJyrGV0lrrO
	 pO0Gj753IwC9Q==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL v2] Networking for v6.17-rc1
Date: Thu,  7 Aug 2025 07:49:40 -0700
Message-ID: <20250807144940.830533-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

The following changes since commit d9104cec3e8fe4b458b74709853231385779001f:

  Merge tag 'bpf-next-6.17' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next (2025-07-30 09:58:50 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.17-rc1

for you to fetch changes up to ae633388cae349886f1a3cfb27aa092854b24c1b:

  pptp: fix pptp_xmit() error path (2025-08-07 07:47:04 -0700)

----------------------------------------------------------------
Previous releases - regressions:

 - netlink: avoid infinite retry looping in netlink_unicast()

Previous releases - always broken:

 - packet: fix a race in packet_set_ring() and packet_notifier()

 - ipv6: reject malicious packets in ipv6_gso_segment()

 - sched: mqprio: fix stack out-of-bounds write in tc entry parsing

 - net: drop UFO packets (injected via virtio) in udp_rcv_segment()

 - eth: mlx5: correctly set gso_segs when LRO is used, avoid false
   positive checksum validation errors

 - netpoll: prevent hanging NAPI when netcons gets enabled

 - phy: mscc: fix parsing of unicast frames for PTP timestamping

 - number of device tree / OF reference leak fixes

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Arnd Bergmann (1):
      ipa: fix compile-testing with qcom-mdt=m

Bence Csókás (1):
      net: mdio_bus: Use devm for getting reset GPIO

Buday Csaba (1):
      net: phy: smsc: add proper reset flags for LAN8710A

Christoph Paasch (1):
      net/mlx5: Correctly set gso_segs when LRO is used

Edward Cree (1):
      sfc: unfix not-a-typo in comment

Eric Dumazet (4):
      pptp: ensure minimal skb length in pptp_xmit()
      selftests: avoid using ifconfig
      ipv6: reject malicious packets in ipv6_gso_segment()
      pptp: fix pptp_xmit() error path

Fedor Pchelkin (1):
      netlink: avoid infinite retry looping in netlink_unicast()

Florian Fainelli (1):
      net: mdio: mdio-bcm-unimac: Correct rate fallback logic

Geert Uytterhoeven (2):
      dpll: Make ZL3073X invisible
      dpll: zl3073x: ZL3073X_I2C and ZL3073X_SPI should depend on NET

Heiner Kallweit (1):
      net: ftgmac100: fix potential NULL pointer access in ftgmac100_phy_disconnect

Horatiu Vultur (1):
      phy: mscc: Fix parsing of unicast frames

Ido Schimmel (2):
      selftests: net: Fix flaky neighbor garbage collection test
      selftests: netdevsim: Xfail nexthop test on slow machines

Jakub Kicinski (9):
      Merge branch 'net-ethernet-fix-device-leaks'
      netpoll: prevent hanging NAPI when netcons gets enabled
      netlink: specs: ethtool: fix module EEPROM input/output arguments
      eth: fbnic: unlink NAPIs from queues on error to open
      net: devmem: fix DMA direction on unmapping
      selftests: net: packetdrill: xfail all problems on slow machines
      Revert "net: mdio_bus: Use devm for getting reset GPIO"
      eth: fbnic: remove the debugging trick of super high page bias
      Merge branch 'eth-fbnic-fix-drop-stats-support'

Johan Hovold (5):
      net: dpaa: fix device leak when querying time stamp info
      net: enetc: fix device and OF node leak at probe
      net: gianfar: fix device leak when querying time stamp info
      net: mtk_eth_soc: fix device leak at probe
      net: ti: icss-iep: fix device and OF node leaks at probe

Krzysztof Kozlowski (1):
      dt-bindings: net: Replace bouncing Alexandru Tachici emails

Lorenzo Bianconi (2):
      net: airoha: Fix PPE table access in airoha_ppe_debugfs_foe_show()
      net: airoha: npu: Add missing MODULE_FIRMWARE macros

Luca Weiss (1):
      net: ipa: add IPA v5.1 and v5.5 to ipa_version_string()

Maher Azzouzi (1):
      net/sched: mqprio: fix stack out-of-bounds write in tc entry parsing

Meghana Malladi (1):
      net: ti: icssg-prueth: Fix skb handling for XDP_PASS

Michal Luczaj (1):
      kcm: Fix splice support

Michal Schmidt (1):
      benet: fix BUG when creating VFs

Mohsin Bashir (2):
      eth: fbnic: Fix tx_dropped reporting
      eth: fbnic: Lock the tx_dropped update

Quang Le (1):
      net/packet: fix a race in packet_set_ring() and packet_notifier()

Samiullah Khawaja (1):
      net: Update threaded state in napi config in netif_set_threaded

Sharath Chandra Vurukala (1):
      net: Add locking to protect skb->dev access in ip_output

Takamitsu Iwai (1):
      net/sched: taprio: enforce minimum value for picos_per_byte

Wang Liang (1):
      net: drop UFO packets in udp_rcv_segment()

 .../devicetree/bindings/net/adi,adin.yaml          |   2 +-
 .../devicetree/bindings/net/adi,adin1110.yaml      |   2 +-
 Documentation/netlink/specs/ethtool.yaml           |   6 +-
 drivers/dpll/zl3073x/Kconfig                       |  10 +-
 drivers/net/ethernet/airoha/airoha_npu.c           |   2 +
 drivers/net/ethernet/airoha/airoha_ppe.c           |  26 +++--
 drivers/net/ethernet/emulex/benet/be_cmds.c        |   2 +-
 drivers/net/ethernet/faraday/ftgmac100.c           |   7 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c |   4 +-
 drivers/net/ethernet/freescale/enetc/enetc_pf.c    |  14 ++-
 drivers/net/ethernet/freescale/gianfar_ethtool.c   |   4 +-
 drivers/net/ethernet/mediatek/mtk_wed.c            |   1 -
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c     |  14 ++-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c       |   4 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h       |   6 +-
 drivers/net/ethernet/sfc/tc_encap_actions.c        |   2 +-
 drivers/net/ethernet/ti/icssg/icss_iep.c           |  23 ++++-
 drivers/net/ethernet/ti/icssg/icssg_common.c       |  15 +--
 drivers/net/ipa/Kconfig                            |   2 +-
 drivers/net/ipa/ipa_sysfs.c                        |   6 +-
 drivers/net/mdio/mdio-bcm-unimac.c                 |   5 +-
 drivers/net/phy/mscc/mscc_ptp.c                    |   1 +
 drivers/net/phy/mscc/mscc_ptp.h                    |   1 +
 drivers/net/phy/smsc.c                             |   1 +
 drivers/net/ppp/pptp.c                             |  18 ++--
 include/linux/skbuff.h                             |  23 +++++
 include/net/dst.h                                  |  12 +++
 include/net/udp.h                                  |  24 +++--
 net/core/dev.c                                     |  26 ++---
 net/core/devmem.c                                  |   6 +-
 net/core/devmem.h                                  |   7 +-
 net/core/netpoll.c                                 |   7 ++
 net/ipv4/ip_output.c                               |  15 ++-
 net/ipv6/ip6_offload.c                             |   4 +-
 net/kcm/kcmsock.c                                  |   6 ++
 net/netlink/af_netlink.c                           |   2 +-
 net/packet/af_packet.c                             |  12 +--
 net/sched/sch_mqprio.c                             |   2 +-
 net/sched/sch_taprio.c                             |  21 +++-
 tools/testing/selftests/drivers/net/Makefile       |   1 +
 .../testing/selftests/drivers/net/napi_threaded.py | 111 +++++++++++++++++++++
 .../selftests/drivers/net/netdevsim/nexthop.sh     |   2 +-
 .../selftests/net/packetdrill/ksft_runner.sh       |  19 +---
 tools/testing/selftests/net/test_neigh.sh          |   6 +-
 tools/testing/selftests/net/vlan_hw_filter.sh      |  16 +--
 46 files changed, 363 insertions(+), 138 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/napi_threaded.py

