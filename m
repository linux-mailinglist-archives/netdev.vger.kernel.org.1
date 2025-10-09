Return-Path: <netdev+bounces-228377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DF0BC94AD
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 15:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 079093AD881
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 13:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1561E2E8B60;
	Thu,  9 Oct 2025 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fuex2el4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC49A2E7F04
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 13:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760016378; cv=none; b=aIMoWO5fH5EU9kn3RCIFg39LAjjlQnCGMTVhMLIfpeD1g0HFaYcsajIRWBEGkTqWLrJvOhACEDuPhT1tTntqLrjEaMXMMI8DopThY3nVv1+1EDdCOTlY6JdjROp7rr4bELid43Fj7XLIPIbvkS0rUOCzt0H3lDLmorsiGeDpAp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760016378; c=relaxed/simple;
	bh=VPWcE0Xuu5GUODD7cWMvxX1PGvL/T98UvE8B+A6miSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P4wyLe1HRNxarasc/JTnw5LsYhRFjE1s/9FZr54w2I+GZB+rG2AV5ZwDEif5xJG49Sb4pyD83d+Ao5wYi7DMl6tbYnT588CQMATxKShhiuHx6WflT6Rocc8YuFIwYtUARrfkt7YYz6sL5oxY8qa1quUq3YGhVU7bmSxlp8JlkRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fuex2el4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760016373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hJtpfcp/G8o62hjdoIKw84mK7hW8TEY2gZji142cB8I=;
	b=Fuex2el4AVhHUrgT58wZ81ABiRogWODI9N+glZftXXN0rcf+jVs8XJuUpJdAG5S1T4eS0O
	CLXgqn2McLur4tUh/SxXUcT8mAg+ZLd3wGcjN9fuBlF8RjdqFzS6YVJ/mgQMGEqPqmn9pq
	eHe4LFAgj8p2q+//RZMXyCEkGjJPLPU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-upBHHFoZOaCaL7WXXJ6M2A-1; Thu,
 09 Oct 2025 09:26:10 -0400
X-MC-Unique: upBHHFoZOaCaL7WXXJ6M2A-1
X-Mimecast-MFC-AGG-ID: upBHHFoZOaCaL7WXXJ6M2A_1760016369
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0584F19560B0;
	Thu,  9 Oct 2025 13:26:09 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.151])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D0EE419560B4;
	Thu,  9 Oct 2025 13:26:06 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.18-rc1
Date: Thu,  9 Oct 2025 15:23:09 +0200
Message-ID: <20251009132309.35872-1-pabeni@redhat.com>
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

The following changes since commit 07fdad3a93756b872da7b53647715c48d0f4a2d0:

  Merge tag 'net-next-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2025-10-02 15:17:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.18-rc1

for you to fetch changes up to fea8cdf6738a8b25fccbb7b109b440795a0892cb:

  net: airoha: Fix loopback mode configuration for GDM2 port (2025-10-09 11:48:17 +0200)

----------------------------------------------------------------
Including fixes from netfilter.

Current release - regressions:

  - mlx5: fix pre-2.40 binutils assembler error

Current release - new code bugs:

  - net: psp: don't assume reply skbs will have a socket

  - eth: fbnic: fix missing programming of the default descriptor

Previous releases - regressions:

  - page_pool: fix PP_MAGIC_MASK to avoid crashing on some 32-bit arches

  - tcp:
    - take care of zero tp->window_clamp in tcp_set_rcvlowat()
    - don't call reqsk_fastopen_remove() in tcp_conn_request().

  - eth: ice: release xa entry on adapter allocation failure

  - eth: usb: asix: hold PM usage ref to avoid PM/MDIO + RTNL deadlock

Previous releases - always broken:

  - netfilter: validate objref and objrefmap expressions

  - sctp: fix a null dereference in sctp_disposition sctp_sf_do_5_1D_ce()

  - eth: mlx4: prevent potential use after free in mlx4_en_do_uc_filter()

  - eth: mlx5: prevent tunnel mode conflicts between FDB and NIC IPsec tables

  - eth: ocelot: fix use-after-free caused by cyclic delayed work

Misc:

  -  add support for MediaTek PCIe 5G HP DRMR-H01

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alexandr Sapozhnikov (1):
      net/sctp: fix a null dereference in sctp_disposition sctp_sf_do_5_1D_ce()

Arnd Bergmann (1):
      net/mlx5: fix pre-2.40 binutils assembler error

Bhanu Seshu Kumar Valluri (2):
      net: usb: lan78xx: Fix lost EEPROM read timeout error(-ETIMEDOUT) in lan78xx_read_raw_eeprom
      net: doc: Fix typos in docs

Carolina Jubran (2):
      net/mlx5: Prevent tunnel mode conflicts between FDB and NIC IPsec tables
      net/mlx5e: Prevent tunnel reformat when tunnel mode not allowed

Cosmin Ratiu (1):
      net/mlx5e: Do not fail PSP init on missing caps

Dan Carpenter (1):
      net/mlx4: prevent potential use after free in mlx4_en_do_uc_filter()

Daniel Machon (1):
      net: sparx5/lan969x: fix flooding configuration on bridge join/leave

Duoming Zhou (1):
      net: mscc: ocelot: Fix use-after-free caused by cyclic delayed work

Eric Dumazet (1):
      tcp: take care of zero tp->window_clamp in tcp_set_rcvlowat()

Eric Woudstra (1):
      bridge: br_vlan_fill_forward_path_pvid: use br_vlan_group_rcu()

Erick Karanja (1):
      net: fsl_pq_mdio: Fix device node reference leak in fsl_pq_mdio_probe

Fernando Fernandez Mancera (1):
      netfilter: nft_objref: validate objref and objrefmap expressions

Florian Westphal (2):
      selftests: netfilter: nft_fib.sh: fix spurious test failures
      selftests: netfilter: query conntrack state to check for port clash resolution

Haotian Zhang (1):
      ice: ice_adapter: release xa entry on adapter allocation failure

Jakub Kicinski (13):
      net: psp: don't assume reply skbs will have a socket
      selftests: net: sort configs
      selftests: net: unify the Makefile formats
      selftests: drv-net: make linters happy with our imports
      eth: fbnic: fix missing programming of the default descriptor
      eth: fbnic: fix accounting of XDP packets
      eth: fbnic: fix saving stats from XDP_TX rings on close
      selftests: drv-net: xdp: rename netnl to ethnl
      selftests: drv-net: xdp: add test for interface level qstats
      eth: fbnic: fix reporting of alloc_failed qstats
      selftests: drv-net: fix linter warnings in pp_alloc_fail
      selftests: drv-net: pp_alloc_fail: lower traffic expectations
      selftests: drv-net: pp_alloc_fail: add necessary optoins to config

Kuniyuki Iwashima (1):
      tcp: Don't call reqsk_fastopen_remove() in tcp_conn_request().

Lorenzo Bianconi (1):
      net: airoha: Fix loopback mode configuration for GDM2 port

Maxime Chevallier (1):
      net: mdio: mdio-i2c: Hold the i2c bus lock during smbus transactions

Oleksij Rempel (1):
      net: usb: asix: hold PM usage ref to avoid PM/MDIO + RTNL deadlock

Paolo Abeni (3):
      Merge branch 'mlx5-misc-fixes-2025-10-05'
      Merge tag 'nf-25-10-08' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge branch 'eth-fbnic-fix-xdp_tx-and-xdp-vs-qstats'

Sammy Hsu (1):
      net: wwan: t7xx: add support for HP DRMR-H01

Sidharth Seela (1):
      selftest: net: ovpn: Fix uninit return values

Thomas Wismer (1):
      net: pse-pd: tps23881: Fix current measurement scaling

Toke Høiland-Jørgensen (1):
      page_pool: Fix PP_MAGIC_MASK to avoid crashing on some 32-bit arches

 drivers/net/ethernet/airoha/airoha_eth.c           |   4 +-
 drivers/net/ethernet/airoha/airoha_regs.h          |   3 +
 drivers/net/ethernet/freescale/fsl_pq_mdio.c       |   2 +
 drivers/net/ethernet/intel/ice/ice_adapter.c       |  10 +-
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c     |   2 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |  38 ++-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.h   |   2 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c         |  32 ++-
 .../net/ethernet/mellanox/mlx5/core/en_accel/psp.c |  10 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |   5 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  18 +-
 drivers/net/ethernet/mellanox/mlx5/core/wc.c       |   2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c    |   6 +-
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c        |   8 +
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c     |  23 +-
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h     |   1 +
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c       |  74 +++--
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h       |   7 +
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |   5 +
 .../ethernet/microchip/sparx5/sparx5_switchdev.c   |  12 +
 .../net/ethernet/microchip/sparx5/sparx5_vlan.c    |  10 -
 drivers/net/ethernet/mscc/ocelot_stats.c           |   2 +-
 drivers/net/mdio/mdio-i2c.c                        |  39 ++-
 drivers/net/pse-pd/tps23881.c                      |   2 +-
 drivers/net/usb/asix_devices.c                     |  29 ++
 drivers/net/usb/lan78xx.c                          |  11 +-
 drivers/net/wwan/t7xx/t7xx_pci.c                   |   1 +
 include/linux/mm.h                                 |  22 +-
 include/linux/phy.h                                |   4 +-
 include/net/psp/functions.h                        |   4 +-
 net/bridge/br_vlan.c                               |   2 +-
 net/core/page_pool.c                               |  76 +++--
 net/ipv4/ip_output.c                               |   2 +-
 net/ipv4/tcp.c                                     |   5 +-
 net/ipv4/tcp_input.c                               |   1 -
 net/ipv6/tcp_ipv6.c                                |   2 +-
 net/netfilter/nft_objref.c                         |  39 +++
 net/psp/psp_sock.c                                 |   4 +-
 net/sctp/sm_statefuns.c                            |   3 +-
 net/tipc/crypto.c                                  |   2 +-
 net/tipc/topsrv.c                                  |   4 +-
 tools/testing/selftests/drivers/net/Makefile       |   4 +-
 .../testing/selftests/drivers/net/bonding/Makefile |  21 +-
 tools/testing/selftests/drivers/net/bonding/config |   8 +-
 tools/testing/selftests/drivers/net/config         |   2 +-
 tools/testing/selftests/drivers/net/dsa/Makefile   |  12 +-
 tools/testing/selftests/drivers/net/hds.py         |   3 +-
 tools/testing/selftests/drivers/net/hw/Makefile    |   8 +-
 tools/testing/selftests/drivers/net/hw/config      |   4 +
 .../selftests/drivers/net/hw/pp_alloc_fail.py      |  36 ++-
 .../selftests/drivers/net/lib/py/__init__.py       |  41 ++-
 .../selftests/drivers/net/netdevsim/Makefile       |   4 +-
 tools/testing/selftests/drivers/net/team/Makefile  |  11 +-
 .../selftests/drivers/net/virtio_net/Makefile      |  13 +-
 tools/testing/selftests/drivers/net/xdp.py         |  99 ++++++-
 tools/testing/selftests/net/Makefile               | 313 +++++++++++++--------
 tools/testing/selftests/net/af_unix/Makefile       |  10 +-
 tools/testing/selftests/net/af_unix/config         |   2 +-
 tools/testing/selftests/net/config                 | 140 ++++-----
 tools/testing/selftests/net/forwarding/Makefile    |  56 ++--
 tools/testing/selftests/net/forwarding/config      |  30 +-
 tools/testing/selftests/net/hsr/Makefile           |   6 +-
 tools/testing/selftests/net/hsr/config             |   4 +-
 tools/testing/selftests/net/lib/Makefile           |  14 +-
 tools/testing/selftests/net/mptcp/Makefile         |  32 ++-
 tools/testing/selftests/net/mptcp/config           |  44 +--
 tools/testing/selftests/net/netfilter/Makefile     |  89 +++---
 tools/testing/selftests/net/netfilter/config       |  52 ++--
 .../selftests/net/netfilter/nf_nat_edemux.sh       |  58 ++--
 tools/testing/selftests/net/netfilter/nft_fib.sh   |  13 +-
 tools/testing/selftests/net/ovpn/Makefile          |  12 +-
 tools/testing/selftests/net/ovpn/config            |  12 +-
 tools/testing/selftests/net/ovpn/ovpn-cli.c        |   2 +
 tools/testing/selftests/net/packetdrill/Makefile   |  10 +-
 tools/testing/selftests/net/packetdrill/config     |   4 +-
 tools/testing/selftests/net/rds/Makefile           |  10 +-
 tools/testing/selftests/net/tcp_ao/config          |   2 +-
 77 files changed, 1113 insertions(+), 596 deletions(-)


