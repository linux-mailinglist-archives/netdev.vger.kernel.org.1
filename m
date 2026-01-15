Return-Path: <netdev+bounces-250194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B333DD24E93
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 15:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64CAD3014ADD
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 14:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0613A1CF8;
	Thu, 15 Jan 2026 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gchudFpJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854FB39E6FE
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768486857; cv=none; b=hMpPZNa/kg+BO76Z7BF94/GyrjA04omDyQ04TlDJ3N6CmBsmP0pmWJra16KP+6NBbaHvGa35IXiJ0QyZQxkz6SFrmBI/j/tPKIeVZRtOTFYYqCz3UgJKcR0mAG4B5jntUotaR7e8wd9xaMK0dzPUJiSKmCXsnRpoqv8LoERZaJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768486857; c=relaxed/simple;
	bh=9WwYWMAyoTOBd81ExILLv42Nu11m4M75+GvwGKVzYwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fcdydIogsamvq2enFMJJ8eK17cw7ZD/n+ATTjXxx28FaZ+vipBZnyzTB96OEb2pebUypkCqwlmkdg5T3KPqv/PBZZYqgSXXCXK6ejoXS/5VW+AKmQA6mrDRHPX/pVGCPWTkKYMmogRKlnaskOi4E54mRsz6L8iNF9q8pzepdTIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gchudFpJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768486854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZnBfyslz1VZPVHtozFWvQFTbTw3A4g1xbszDbOULat4=;
	b=gchudFpJkENyWouqycC52Niur5+1vkNZb5Vd9Ih70XrAwdncZkVQE8qilikLDhV/1BlCrm
	zPczEs5pxwSWk1rwHXA+qaOYHHd0DRc4lWi8Gk6WFXQKVO28xzF5QokC+QAlfZU2fBKNI8
	/q9AiNt4hb5uNRO6wG92b9MkbjmGU0A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-gmfAxk8EOtmDKIWm4GeohQ-1; Thu,
 15 Jan 2026 09:20:48 -0500
X-MC-Unique: gmfAxk8EOtmDKIWm4GeohQ-1
X-Mimecast-MFC-AGG-ID: gmfAxk8EOtmDKIWm4GeohQ_1768486846
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5535185FD0E;
	Thu, 15 Jan 2026 14:20:42 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.60])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AE80B18007D2;
	Thu, 15 Jan 2026 14:20:40 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.19-rc6
Date: Thu, 15 Jan 2026 15:20:11 +0100
Message-ID: <20260115142011.254549-1-pabeni@redhat.com>
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

The following changes since commit f2a3b12b305c7bb72467b2a56d19a4587b6007f9:

  Merge tag 'net-6.19-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-01-08 08:40:35 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.19-rc6

for you to fetch changes up to 851822aec1a3359ecb7a4767d7f4a32336043c2f:

  Merge tag 'linux-can-fixes-for-6.19-20260115' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can (2026-01-15 13:13:01 +0100)

----------------------------------------------------------------
Including fixes from bluetooth, can and IPsec.

Current release - regressions:

  - net: add net.core.qdisc_max_burst

  - can: propagate CAN device capabilities via ml_priv

Previous releases - regressions:

  - dst: fix races in rt6_uncached_list_del() and rt_del_uncached_list()

  - ipv6: fix use-after-free in inet6_addr_del().

  - xfrm: fix inner mode lookup in tunnel mode GSO segmentation

  - ip_tunnel: spread netdev_lockdep_set_classes()

  - ip6_tunnel: use skb_vlan_inet_prepare() in __ip6_tnl_rcv()

  - bluetooth: hci_sync: enable PA sync lost event

  - eth: virtio-net:
    - fix the deadlock when disabling rx NAPI
    - fix misalignment bug in struct virtnet_info

Previous releases - always broken:

  - ipv4: ip_gre: make ipgre_header() robust

  - can: fix SSP_SRC in cases when bit-rate is higher than 1 MBit.

  - eth: mlx5e: profile change fix

  - eth: octeon_ep_vf: fix free_irq dev_id mismatch in IRQ rollback

  - eth: macvlan: fix possible UAF in macvlan_forward_source()

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Aditya Garg (1):
      net: hv_netvsc: reject RSS hash key programming without RX indirection table

Antony Antony (1):
      xfrm: set ipv4 no_pmtu_disc flag only on output sa when direction is set

Bui Quang Minh (3):
      virtio-net: don't schedule delayed refill worker
      virtio-net: remove unused delayed refill worker
      virtio-net: clean up __virtnet_rx_pause/resume

Donald Hunter (1):
      tools: ynl: render event op docs correctly

Eric Dumazet (9):
      ipv4: ip_tunnel: spread netdev_lockdep_set_classes()
      net: bridge: annotate data-races around fdb->{updated,used}
      ip6_tunnel: use skb_vlan_inet_prepare() in __ip6_tnl_rcv()
      net: update netdev_lock_{type,name}
      macvlan: fix possible UAF in macvlan_forward_source()
      ipv4: ip_gre: make ipgre_header() robust
      net: add net.core.qdisc_max_burst
      dst: fix races in rt6_uncached_list_del() and rt_del_uncached_list()
      net/sched: sch_qfq: do not free existing class in qfq_change_class()

Gal Pressman (2):
      selftests: drv-net: fix RPS mask handling in toeplitz test
      selftests: drv-net: fix RPS mask handling for high CPU numbers

Gustavo A. R. Silva (1):
      virtio_net: Fix misalignment bug in struct virtnet_info

Jakub Kicinski (6):
      MAINTAINERS: add docs and selftest to the TLS file list
      Merge branch 'virtio-net-fix-the-deadlock-when-disabling-rx-napi'
      Merge tag 'for-net-2026-01-09' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge tag 'linux-can-fixes-for-6.19-20260109' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
      Merge branch 'mlx5e-profile-change-fix'
      Merge branch 'selftests-couple-of-fixes-in-toeplitz-rps-cases'

Jianbo Liu (1):
      xfrm: Fix inner mode lookup in tunnel mode GSO segmentation

Jijie Shao (1):
      net: phy: motorcomm: fix duplex setting error for phy leds

Kery Qi (1):
      net: octeon_ep_vf: fix free_irq dev_id mismatch in IRQ rollback

Kuniyuki Iwashima (1):
      ipv6: Fix use-after-free in inet6_addr_del().

Lorenzo Bianconi (1):
      net: airoha: Fix typo in airoha_ppe_setup_tc_block_cb definition

Marc Kleine-Budde (2):
      can: gs_usb: gs_usb_receive_bulk_callback(): fix URB memory leak
      Merge patch series "can: raw: better approach to instantly reject unsupported CAN frames"

Oliver Hartkopp (3):
      Revert "can: raw: instantly reject unsupported CAN frames"
      can: propagate CAN device capabilities via ml_priv
      can: raw: instantly reject disabled CAN frames

Ondrej Ille (1):
      can: ctucanfd: fix SSP_SRC in cases when bit-rate is higher than 1 MBit.

Paolo Abeni (2):
      Merge tag 'ipsec-2026-01-14' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec
      Merge tag 'linux-can-fixes-for-6.19-20260115' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can

Saeed Mahameed (4):
      net/mlx5e: Fix crash on profile change rollback failure
      net/mlx5e: Don't store mlx5e_priv in mlx5e_dev devlink priv
      net/mlx5e: Pass netdev to mlx5e_destroy_netdev instead of priv
      net/mlx5e: Restore destroying state bit after profile cleanup

Stefano Garzarella (1):
      vsock/test: add a final full barrier after run all tests

Szymon Wilczek (1):
      can: etas_es58x: allow partial RX URB allocation to succeed

Tetsuo Handa (1):
      net: can: j1939: j1939_xtp_rx_rts_session_active(): deactivate session upon receiving the second rts

Yang Li (1):
      Bluetooth: hci_sync: enable PA Sync Lost event

 Documentation/admin-guide/sysctl/net.rst           |   8 +
 MAINTAINERS                                        |   4 +-
 drivers/net/can/Kconfig                            |   7 +-
 drivers/net/can/Makefile                           |   2 +-
 drivers/net/can/ctucanfd/ctucanfd_base.c           |   2 +-
 drivers/net/can/dev/Makefile                       |   5 +-
 drivers/net/can/dev/dev.c                          |  27 ++++
 drivers/net/can/dev/netlink.c                      |   1 +
 drivers/net/can/usb/etas_es58x/es58x_core.c        |   2 +-
 drivers/net/can/usb/gs_usb.c                       |   2 +
 drivers/net/can/vcan.c                             |  15 ++
 drivers/net/can/vxcan.c                            |  15 ++
 .../ethernet/marvell/octeon_ep_vf/octep_vf_main.c  |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |  13 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  86 ++++++----
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  15 +-
 drivers/net/hyperv/netvsc_drv.c                    |   3 +
 drivers/net/macvlan.c                              |  20 ++-
 drivers/net/phy/motorcomm.c                        |   4 +-
 drivers/net/virtio_net.c                           | 175 +++++----------------
 include/linux/can/can-ml.h                         |  24 +++
 include/linux/can/dev.h                            |   8 +-
 include/linux/soc/airoha/airoha_offload.h          |   4 +-
 include/net/dropreason-core.h                      |   6 +
 include/net/hotdata.h                              |   1 +
 include/net/ip_tunnels.h                           |  13 +-
 net/bluetooth/hci_sync.c                           |   1 +
 net/bridge/br_fdb.c                                |  28 ++--
 net/bridge/br_input.c                              |   4 +-
 net/can/j1939/transport.c                          |  10 +-
 net/can/raw.c                                      |  51 ++----
 net/core/dev.c                                     |  31 ++--
 net/core/dst.c                                     |   1 +
 net/core/hotdata.c                                 |   1 +
 net/core/sysctl_net_core.c                         |   7 +
 net/ipv4/esp4_offload.c                            |   4 +-
 net/ipv4/ip_gre.c                                  |  11 +-
 net/ipv4/ip_tunnel.c                               |   5 +-
 net/ipv4/route.c                                   |   4 +-
 net/ipv6/addrconf.c                                |   4 +-
 net/ipv6/esp6_offload.c                            |   4 +-
 net/ipv6/ip6_tunnel.c                              |   2 +-
 net/ipv6/route.c                                   |   4 +-
 net/sched/sch_qfq.c                                |   6 +-
 net/xfrm/xfrm_state.c                              |   1 +
 tools/net/ynl/pyynl/lib/doc_generator.py           |   9 +-
 tools/testing/selftests/drivers/net/hw/toeplitz.c  |   4 +-
 tools/testing/selftests/drivers/net/hw/toeplitz.py |   6 +-
 tools/testing/vsock/util.c                         |  12 ++
 49 files changed, 381 insertions(+), 293 deletions(-)


