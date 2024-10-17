Return-Path: <netdev+bounces-136587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C85C9A2388
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 15:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20B7E1F2873A
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 13:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6C01DDA24;
	Thu, 17 Oct 2024 13:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TIYwifYr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B04E1D414F
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 13:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729171257; cv=none; b=nS1nH1qIWSLrdbWb+KGeViGfsmR51WIaIpImisFOKmnA3BlcKTTTcvlA7Tcf+BoYFB4181+vugfF7QSVrXwDSXo5jvr89MF9wz21Wy7H08Q7/PSwebMn/lny7DoX2zqZgEt3LPJBFTpIo8AMEBVddne23ZTVkSLWxNvI1Jv8ySw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729171257; c=relaxed/simple;
	bh=NzJhhipDZb35AICStOIKhEB9krp61SfQC3M2rwqYBz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GlShNfjLGP33ty2opFR+PMh7ZvI5IIJgarrIVHSN9JsVJWp+6KBTNjQwAlGQ9co8L7BsvhYeAt3KJrxOL0uclp1atKPwmwcdzQo/QCy60oMyOtzTiuFhwrcXkoMigeNYc0x+BxVWstu5c5etGhMahF9f4vLcGBkeQSJkzmX34qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TIYwifYr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729171253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a6cytotUdBddDw5jnQSlR5INjTs6onX4pnsgVbgz4YY=;
	b=TIYwifYrZpGQz9O18GrYvPi+Gv4U1LK3HFKKGAUSosgxSEI2bkLsCzJIlpvLOtWkVIOQsp
	DsoAI+h+Is2OjMmknND8MY/cXhmokjgGXgCQP/BiiyyrfX7wplqlgOEJqrX/sO1997/tdU
	g+dNNUZ9vQC/4YpjssAhGvUJG5trbVg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-ebA1-nPwOTGhNjCd_Z4HKA-1; Thu,
 17 Oct 2024 09:20:49 -0400
X-MC-Unique: ebA1-nPwOTGhNjCd_Z4HKA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 65A2B195608A;
	Thu, 17 Oct 2024 13:20:48 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.210])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D8A0A300018D;
	Thu, 17 Oct 2024 13:20:45 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.12-rc4
Date: Thu, 17 Oct 2024 15:20:22 +0200
Message-ID: <20241017132022.37781-1-pabeni@redhat.com>
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

The following changes since commit 1d227fcc72223cbdd34d0ce13541cbaab5e0d72f:

  Merge tag 'net-6.12-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-10-10 12:36:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.12-rc4

for you to fetch changes up to cb560795c8c2ceca1d36a95f0d1b2eafc4074e37:

  Merge branch 'mlx5-misc-fixes-2024-10-15' (2024-10-17 12:14:11 +0200)

----------------------------------------------------------------
No contributions from subtrees.

Current release - new code bugs:

  - eth: mlx5: HWS, don't destroy more bwc queue locks than allocated

Previous releases - regressions:

  - ipv4: give an IPv4 dev to blackhole_netdev

  - udp: compute L4 checksum as usual when not segmenting the skb

  - tcp/dccp: don't use timer_pending() in reqsk_queue_unlink().

  - eth: mlx5e: don't call cleanup on profile rollback failure

  - eth: microchip: vcap api: fix memory leaks in vcap_api_encode_rule_test()

  - eth: enetc: disable Tx BD rings after they are empty

  - eth: macb: avoid 20s boot delay by skipping MDIO bus registration for fixed-link PHY

Previous releases - always broken:

  - posix-clock: fix missing timespec64 check in pc_clock_settime()

  - genetlink: hold RCU in genlmsg_mcast()

  - mptcp: prevent MPC handshake on port-based signal endpoints

  - eth: vmxnet3: fix packet corruption in vmxnet3_xdp_xmit_frame

  - eth: stmmac: dwmac-tegra: fix link bring-up sequence

  - eth: bcmasp: fix potential memory leak in bcmasp_xmit()

Misc:

  - add Andrew Lunn as a co-maintainer of all networking drivers

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alessandro Zanni (2):
      selftests: net/rds: add module not found
      selftests: drivers: net: fix name not defined

Colin Ian King (1):
      octeontx2-af: Fix potential integer overflows on integer shifts

Cosmin Ratiu (4):
      net/mlx5: HWS, don't destroy more bwc queue locks than allocated
      net/mlx5: HWS, use lock classes for bwc locks
      net/mlx5: Unregister notifier on eswitch init failure
      net/mlx5e: Don't call cleanup on profile rollback failure

Daniel Borkmann (1):
      vmxnet3: Fix packet corruption in vmxnet3_xdp_xmit_frame

Daniel Machon (1):
      net: sparx5: fix source port register when mirroring

Eric Dumazet (2):
      netdevsim: use cond_resched() in nsim_dev_trap_report_work()
      genetlink: hold RCU in genlmsg_mcast()

Felix Fietkau (1):
      net: ethernet: mtk_eth_soc: fix memory corruption during fq dma init

Jakub Kicinski (5):
      Merge branch 'net-enetc-fix-some-issues-of-xdp'
      MAINTAINERS: add Andrew Lunn as a co-maintainer of all networking drivers
      Merge branch 'posix-clock-fix-missing-timespec64-check-for-ptp-clock'
      Merge branch 'mptcp-prevent-mpc-handshake-on-port-based-signal-endpoints'
      Merge branch 'net-phy-mdio-bcm-unimac-add-bcm6846-variant'

Jakub Sitnicki (1):
      udp: Compute L4 checksum as usual when not segmenting the skb

Jinjie Ruan (3):
      posix-clock: Fix missing timespec64 check in pc_clock_settime()
      net: lan743x: Remove duplicate check
      net: microchip: vcap api: Fix memory leaks in vcap_api_encode_rule_test()

Kai Shen (1):
      net/smc: Fix memory leak when using percpu refs

Kuniyuki Iwashima (1):
      tcp/dccp: Don't use timer_pending() in reqsk_queue_unlink().

Li RongQing (1):
      net/smc: Fix searching in list of known pnetids in smc_pnet_add_pnetid

Linus Walleij (2):
      dt-bindings: net: brcm,unimac-mdio: Add bcm6846-mdio
      net: phy: mdio-bcm-unimac: Add BCM6846 support

Maher Sanalla (1):
      net/mlx5: Check for invalid vector index on EQ creation

Matthieu Baerts (NGI0) (1):
      mptcp: pm: fix UaF read in mptcp_pm_nl_rm_addr_or_subflow

Niklas Söderlund (1):
      net: ravb: Only advertise Rx/Tx timestamps if hardware supports it

Oleksij Rempel (1):
      net: macb: Avoid 20s boot delay by skipping MDIO bus registration for fixed-link PHY

Oliver Neukum (1):
      net: usb: usbnet: fix race in probe failure

Paolo Abeni (3):
      mptcp: prevent MPC handshake on port-based signal endpoints
      selftests: mptcp: join: test for prohibited MPC to port-based endp
      Merge branch 'mlx5-misc-fixes-2024-10-15'

Paritosh Dixit (1):
      net: stmmac: dwmac-tegra: Fix link bring-up sequence

Peter Rashleigh (1):
      net: dsa: mv88e6xxx: Fix the max_vid definition for the MV88E6361

Sabrina Dubroca (1):
      macsec: don't increment counters for an unrelated SA

Shay Drory (1):
      net/mlx5: Fix command bitmask initialization

Vladimir Oltean (1):
      net: dsa: vsc73xx: fix reception from VLAN-unaware bridges

Wang Hai (5):
      net: ethernet: aeroflex: fix potential memory leak in greth_start_xmit_gbit()
      net: xilinx: axienet: fix potential memory leak in axienet_start_xmit()
      net: ethernet: rtsn: fix potential memory leak in rtsn_start_xmit()
      net: systemport: fix potential memory leak in bcm_sysport_xmit()
      net: bcmasp: fix potential memory leak in bcmasp_xmit()

Wei Fang (5):
      net: enetc: remove xdp_drops statistic from enetc_xdp_drop()
      net: enetc: block concurrent XDP transmissions during ring reconfiguration
      net: enetc: disable Tx BD rings after they are empty
      net: enetc: disable NAPI after all rings are disabled
      net: enetc: add missing static descriptor and inline keyword

Xin Long (1):
      ipv4: give an IPv4 dev to blackhole_netdev

Yevgeny Kliteynik (2):
      net/mlx5: HWS, removed wrong access to a number of rules variable
      net/mlx5: HWS, fixed double free in error flow of definer layout

 .../devicetree/bindings/net/brcm,unimac-mdio.yaml  |   1 +
 MAINTAINERS                                        |   1 +
 drivers/net/dsa/mv88e6xxx/chip.c                   |   2 +-
 drivers/net/dsa/vitesse-vsc73xx-core.c             |   1 -
 drivers/net/ethernet/aeroflex/greth.c              |   3 +-
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c   |   1 +
 drivers/net/ethernet/broadcom/bcmsysport.c         |   1 +
 drivers/net/ethernet/cadence/macb_main.c           |  14 ++-
 drivers/net/ethernet/freescale/enetc/enetc.c       |  56 +++++++---
 drivers/net/ethernet/freescale/enetc/enetc.h       |   1 +
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |   4 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |   8 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/eq.c       |   6 ++
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |   5 +-
 .../mellanox/mlx5/core/steering/hws/mlx5hws_bwc.c  |   4 +-
 .../mlx5/core/steering/hws/mlx5hws_context.h       |   1 +
 .../mlx5/core/steering/hws/mlx5hws_definer.c       |   4 +-
 .../mellanox/mlx5/core/steering/hws/mlx5hws_send.c |  22 +++-
 drivers/net/ethernet/microchip/lan743x_ptp.c       |  35 +++----
 .../net/ethernet/microchip/sparx5/sparx5_mirror.c  |  12 +--
 .../net/ethernet/microchip/vcap/vcap_api_kunit.c   |   2 +
 drivers/net/ethernet/renesas/ravb_main.c           |  25 +++--
 drivers/net/ethernet/renesas/rtsn.c                |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c  |  14 ++-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |   2 +
 drivers/net/macsec.c                               |  18 ----
 drivers/net/mdio/mdio-bcm-unimac.c                 |   1 +
 drivers/net/netdevsim/dev.c                        |  15 +--
 drivers/net/usb/usbnet.c                           |   1 +
 drivers/net/vmxnet3/vmxnet3_xdp.c                  |   2 +-
 drivers/target/target_core_user.c                  |   2 +-
 include/linux/fsl/enetc_mdio.h                     |   3 +-
 include/net/genetlink.h                            |   3 +-
 kernel/time/posix-clock.c                          |   3 +
 net/ipv4/devinet.c                                 |  35 +++++--
 net/ipv4/inet_connection_sock.c                    |  21 +++-
 net/ipv4/udp.c                                     |   4 +-
 net/ipv6/udp.c                                     |   4 +-
 net/l2tp/l2tp_netlink.c                            |   4 +-
 net/mptcp/mib.c                                    |   1 +
 net/mptcp/mib.h                                    |   1 +
 net/mptcp/pm_netlink.c                             |   3 +-
 net/mptcp/protocol.h                               |   1 +
 net/mptcp/subflow.c                                |  11 ++
 net/netlink/genetlink.c                            |  28 ++---
 net/smc/smc_pnet.c                                 |   2 +-
 net/smc/smc_wr.c                                   |   6 +-
 net/wireless/nl80211.c                             |   8 +-
 tools/testing/selftests/net/lib/py/nsim.py         |   1 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 115 +++++++++++++++------
 tools/testing/selftests/net/rds/test.py            |   5 +-
 53 files changed, 351 insertions(+), 179 deletions(-)


