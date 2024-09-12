Return-Path: <netdev+bounces-127831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F0E976C32
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 16:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E3421C23EE8
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 14:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BA81B9825;
	Thu, 12 Sep 2024 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KwirBg3x"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219C41B5EC6
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726151556; cv=none; b=WxDT6AqEcic0chLFvbnpRSFEwoH1AeQWSvsJSTeifiMvfk1LT3XsnPd5SLTuVijI3sYFT2AwWsToUdKytkW4cfXN3wmW6gAWU28n6mfzf9PVgjXkudRjTccL6yQXjzRgbJL7PLkY/17cn27FMwPjTv8BnY/abmAYVOsDIsKCj20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726151556; c=relaxed/simple;
	bh=/BodiEc17S7/DIKU24Ru/icx3qMyKYq6tY0b5ObeCwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RctTohvFMTntkjAI9FQ5928V7NHLyF5PN8Nl8hUh2g4WaLhGxPCmiiJTrV7saPabH/V8/BDr4+U2sXcJzg+kUyZt0V04p0fM1h+PSTihLXn1mZf01nzRZWticQHOZfteuV3N82Ndf6b42VnwlPHKCWhbkH7dVrBjtSWeB1KcA8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KwirBg3x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726151553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fsC+O+qEG3gI8UEDV23eqD3HgN4VSLaEw4QvzDQykuc=;
	b=KwirBg3xCs8IkD1XcOtcdACmfBD0lITtwJwQVUzXI3zSoRmOvP8U4JaBHxItZY6d/zSHxb
	Ti9q7ZqQ3Bp47olP59Vy/grrQ0JTu9F71nxuViGLTUvs+vQwn+AbnymKIkN8ZWsSm7UPjS
	Zwm8Fp1iaRwXqjn/00KBolWW13yXbLI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-53mrhI3nOXez2cl8446n9g-1; Thu,
 12 Sep 2024 10:32:29 -0400
X-MC-Unique: 53mrhI3nOXez2cl8446n9g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B0FE1193E8E4;
	Thu, 12 Sep 2024 14:32:27 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.160])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 66CE7196BCBD;
	Thu, 12 Sep 2024 14:32:15 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.11-rc8
Date: Thu, 12 Sep 2024 16:32:05 +0200
Message-ID: <20240912143205.15347-1-pabeni@redhat.com>
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

The following changes since commit d759ee240d3c0c4a19f4d984eb21c36da76bc6ce:

  Merge tag 'net-6.11-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-09-05 17:08:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.11-rc8

for you to fetch changes up to 3e705251d998c9688be0e7e0526c250fec24d233:

  net: netfilter: move nf flowtable bpf initialization in nf_flow_table_module_init() (2024-09-12 15:41:03 +0200)

----------------------------------------------------------------
There is a recently notified BT regression with no fix yet. I
*think* such fix will not land in the next week.

Including fixes from netfilter.

Current release - regressions:

  - core: tighten bad gso csum offset check in virtio_net_hdr

  - netfilter: move nf flowtable bpf initialization in nf_flow_table_module_init()

  - eth: ice: stop calling pci_disable_device() as we use pcim

  - eth: fou: fix null-ptr-deref in GRO.

Current release - new code bugs:

  - hsr: prevent NULL pointer dereference in hsr_proxy_announce()

Previous releases - regressions:

  - hsr: remove seqnr_lock

  - netfilter: nft_socket: fix sk refcount leaks

  - mptcp: pm: fix uaf in __timer_delete_sync

  - phy: dp83822: fix NULL pointer dereference on DP83825 devices

  - eth: revert "virtio_net: rx enable premapped mode by default"

  - eth: octeontx2-af: Modify SMQ flush sequence to drop packets

Previous releases - always broken:

  - eth: mlx5: fix bridge mode operations when there are no VFs

  - eth: igb: Always call igb_xdp_ring_update_tail() under Tx lock

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
----------------------------------------------------------------
Asbjørn Sloth Tønnesen (1):
      netlink: specs: mptcp: fix port endianness

Benjamin Poirier (1):
      net/mlx5: Fix bridge mode operations when there are no VFs

Carolina Jubran (3):
      net/mlx5: Explicitly set scheduling element and TSAR type
      net/mlx5: Add missing masks and QoS bit masks for scheduling elements
      net/mlx5: Verify support for scheduling element and TSAR type

Edward Adam Davis (1):
      mptcp: pm: Fix uaf in __timer_delete_sync

Eric Dumazet (1):
      net: hsr: remove seqnr_lock

Florian Westphal (2):
      netfilter: nft_socket: fix sk refcount leaks
      netfilter: nft_socket: make cgroupsv2 matching work with namespaces

Jacky Chou (1):
      net: ftgmac100: Enable TX interrupt to avoid TX timeout

Jacob Keller (1):
      ice: fix accounting for filters shared by multiple VSIs

Jakub Kicinski (4):
      Merge branch 'revert-virtio_net-rx-enable-premapped-mode-by-default'
      Merge tag 'mlx5-fixes-2024-09-09' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch 'selftests-mptcp-misc-small-fixes'

Jeongjun Park (1):
      net: hsr: prevent NULL pointer dereference in hsr_proxy_announce()

Jiawen Wu (1):
      net: libwx: fix number of Rx and Tx descriptors

Kory Maincent (1):
      MAINTAINERS: Add ethtool pse-pd to PSE NETWORK DRIVER

Lorenzo Bianconi (1):
      net: netfilter: move nf flowtable bpf initialization in nf_flow_table_module_init()

Maher Sanalla (1):
      net/mlx5: Update the list of the PCI supported devices

Martyna Szapar-Mudlaw (1):
      ice: Fix lldp packets dropping after changing the number of channels

Matthieu Baerts (NGI0) (3):
      selftests: mptcp: join: restrict fullmesh endp on 1st sf
      selftests: mptcp: include lib.sh file
      selftests: mptcp: include net_helper.sh file

Michal Schmidt (1):
      ice: fix VSI lists confusion when adding VLANs

Muhammad Usama Anjum (1):
      fou: fix initialization of grc

Naveen Mamindlapalli (1):
      octeontx2-af: Modify SMQ flush sequence to drop packets

Paolo Abeni (1):
      Merge tag 'nf-24-09-12' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Przemek Kitszel (1):
      ice: stop calling pci_disable_device() as we use pcim

Sean Anderson (2):
      selftests: net: csum: Fix checksums for packets with non-zero padding
      net: dpaa: Pad packets to ETH_ZLEN

Shahar Shitrit (2):
      net/mlx5e: Add missing link modes to ptys2ethtool_map
      net/mlx5e: Add missing link mode to ptys2ext_ethtool_map

Sriram Yagnaraman (1):
      igb: Always call igb_xdp_ring_update_tail() under Tx lock

Tomas Paukrt (1):
      net: phy: dp83822: Fix NULL pointer dereference on DP83825 devices

Wei Fang (1):
      dt-bindings: net: tja11xx: fix the broken binding

Willem de Bruijn (1):
      net: tighten bad gso csum offset check in virtio_net_hdr

Xiaoliang Yang (1):
      net: dsa: felix: ignore pending status of TAS module when it's disabled

Xuan Zhuo (3):
      Revert "virtio_net: rx remove premapped failover code"
      Revert "virtio_net: big mode skip the unmap check"
      virtio_net: disable premapped mode by default

 .../devicetree/bindings/net/nxp,tja11xx.yaml       | 62 ++++++++++----
 Documentation/netlink/specs/mptcp_pm.yaml          |  1 -
 MAINTAINERS                                        |  1 +
 drivers/net/dsa/ocelot/felix_vsc9959.c             | 11 ++-
 drivers/net/ethernet/faraday/ftgmac100.h           |  2 +-
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c     |  9 +-
 drivers/net/ethernet/intel/ice/ice_lib.c           | 15 ++--
 drivers/net/ethernet/intel/ice/ice_main.c          |  2 -
 drivers/net/ethernet/intel/ice/ice_switch.c        |  4 +-
 drivers/net/ethernet/intel/igb/igb_main.c          | 17 +++-
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |  3 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    | 59 +++++++++++---
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   | 10 +++
 .../net/ethernet/mellanox/mlx5/core/esw/legacy.c   |  4 +-
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c  | 51 +++++++-----
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/qos.c      |  7 ++
 drivers/net/ethernet/wangxun/libwx/wx_type.h       |  6 +-
 drivers/net/phy/dp83822.c                          | 35 +++++---
 drivers/net/virtio_net.c                           | 95 +++++++++++-----------
 include/linux/mlx5/mlx5_ifc.h                      | 10 ++-
 include/linux/virtio_net.h                         |  3 +-
 net/hsr/hsr_device.c                               | 39 ++++-----
 net/hsr/hsr_forward.c                              |  4 +-
 net/hsr/hsr_main.h                                 |  6 +-
 net/hsr/hsr_netlink.c                              |  2 +-
 net/ipv4/fou_core.c                                |  4 +-
 net/mptcp/pm_netlink.c                             | 13 ++-
 net/netfilter/nf_flow_table_core.c                 |  6 ++
 net/netfilter/nf_flow_table_inet.c                 |  2 +-
 net/netfilter/nft_socket.c                         | 48 +++++++++--
 tools/testing/selftests/net/lib/csum.c             | 16 +++-
 tools/testing/selftests/net/mptcp/Makefile         |  2 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  4 +-
 34 files changed, 364 insertions(+), 190 deletions(-)


