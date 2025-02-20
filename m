Return-Path: <netdev+bounces-168106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA43A3D884
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 12:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34AD19C283A
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 11:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04441F543F;
	Thu, 20 Feb 2025 11:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G++pR92V"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C63E1F540F
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 11:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050471; cv=none; b=qyjl/lyZ7ulKs0PxrykbbBRzUXA/X9u2jQNEFCHGrqdE97GiGDt+5Oa6zIgVDkxwI3C6UEy0IoDI48vk1UB6yz0MsAeOrjMvAufgDj+i3rFQOZflhOwzt7/5TRNncsAEsI+sVouer11VPWorBrxFRGuqciLAexAPpDZkccicmOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050471; c=relaxed/simple;
	bh=+jtaZ+T/3naFge+HHi8EHFMtDvXf03uXZVpRSJzTGSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=clFMJVmANTXriJjMR+tL610dfpR3dZglRcxV4eCqDwSZ7JY6tYno3yo0MzlrERjMUvt3UbEcwjif0gbSrQF9ZkMWIu11X6oU9AKiboGMl5XVCqZXBrDR0xsCM62N/ZgXrUiJfKy/6ImC8kWbqfkyaq2bSp9xOv6tg2JOFd4s8AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G++pR92V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740050468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QV1VmjWCfOEKaMpohPFJd5Sqcy247FJXoWH0SaVd8aY=;
	b=G++pR92VZkkrVWJ8h+GLnJJOfeRXqu26aPHIIvJrK9Jm/3jfxmQx2H65nTbFdrdKeIM7MP
	yE8ZA/ufeH8fyqfr1SK3pARvmubQMbxkcJxgyNGRz+TXLblLt/KhGYeu9tJWEB2cslAdtA
	HMiFb8WJY4cRZRjSu29Czxzt/PNqPv0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-7nPbkq3KNNOsHo2U2eUjPw-1; Thu,
 20 Feb 2025 06:21:04 -0500
X-MC-Unique: 7nPbkq3KNNOsHo2U2eUjPw-1
X-Mimecast-MFC-AGG-ID: 7nPbkq3KNNOsHo2U2eUjPw_1740050463
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 876981800878;
	Thu, 20 Feb 2025 11:21:03 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.216])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 71BE4300019F;
	Thu, 20 Feb 2025 11:21:01 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.14-rc4
Date: Thu, 20 Feb 2025 12:20:33 +0100
Message-ID: <20250220112033.26001-1-pabeni@redhat.com>
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

The following changes since commit 348f968b89bfeec0bb53dd82dba58b94d97fbd34:

  Merge tag 'net-6.14-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-02-13 12:17:04 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.14-rc4

for you to fetch changes up to dd3188ddc4c49cb234b82439693121d2c1c69c38:

  Merge branch 'net-remove-the-single-page-frag-cache-for-good' (2025-02-20 10:53:32 +0100)

----------------------------------------------------------------
Smaller than usual with no fixes from any subtree.

Current release - regressions:

  - core: fix race of rtnl_net_lock(dev_net(dev)).

Previous releases - regressions:

  - core: remove the single page frag cache for good

  - flow_dissector: fix handling of mixed port and port-range keys

  - sched: cls_api: fix error handling causing NULL dereference

  - tcp:
    - adjust rcvq_space after updating scaling ratio
    - drop secpath at the same time as we currently drop dst

  - eth: gtp: suppress list corruption splat in gtp_net_exit_batch_rtnl().

Previous releases - always broken:

  - vsock:
    - fix variables initialization during resuming
    - for connectible sockets allow only connected

  - eth: geneve: fix use-after-free in geneve_find_dev().

  - eth: ibmvnic: don't reference skb after sending to VIOS

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Breno Leitao (2):
      net: Add non-RCU dev_getbyhwaddr() helper
      arp: switch to dev_getbyhwaddr() in arp_req_set_public()

Cong Wang (4):
      flow_dissector: Fix handling of mixed port and port-range keys
      selftests/net/forwarding: Add a test case for tc-flower of mixed port and port-range
      flow_dissector: Fix port range key handling in BPF conversion
      selftests/bpf: Add a specific dst port matching

Gavrilov Ilia (1):
      drop_monitor: fix incorrect initialization order

Haoxiang Li (1):
      nfp: bpf: Add check for nfp_app_ctrl_msg_alloc()

Jakub Kicinski (7):
      MAINTAINERS: create entry for ethtool MAC merge
      tcp: adjust rcvq_space after updating scaling ratio
      MAINTAINERS: trim the GVE entry
      Merge branch 'net-fix-race-of-rtnl_net_lock-dev_net-dev'
      Merge branch 'gtp-geneve-suppress-list_del-splat-during-exit_batch_rtnl'
      Merge branch 'flow_dissector-fix-handling-of-mixed-port-and-port-range-keys'
      Merge branch 'net-core-improvements-to-device-lookup-by-hardware-address'

Jeroen de Borst (1):
      gve: Update MAINTAINERS

Joshua Washington (1):
      gve: set xdp redirect target only when it is available

Julian Ruess (1):
      s390/ism: add release function for struct device

Junnan Wu (1):
      vsock/virtio: fix variables initialization during resuming

Kory Maincent (1):
      net: pse-pd: pd692x0: Fix power limit retrieval

Kuniyuki Iwashima (6):
      geneve: Fix use-after-free in geneve_find_dev().
      net: Add net_passive_inc() and net_passive_dec().
      net: Fix dev_net(dev) race in unregister_netdevice_notifier_dev_net().
      dev: Use rtnl_net_dev_lock() in unregister_netdev().
      gtp: Suppress list corruption splat in gtp_net_exit_batch_rtnl().
      geneve: Suppress list corruption splat in geneve_destroy_tunnels().

Michal Luczaj (4):
      sockmap, vsock: For connectible sockets allow only connected
      vsock/bpf: Warn on socket without transport
      selftest/bpf: Adapt vsock_delete_on_close to sockmap rejecting unconnected
      selftest/bpf: Add vsock test for sockmap rejecting unconnected

Nick Child (1):
      ibmvnic: Don't reference skb after sending to VIOS

Nick Hu (1):
      net: axienet: Set mac_managed_pm

Paolo Abeni (4):
      Merge branch 'sockmap-vsock-for-connectible-sockets-allow-only-connected'
      net: allow small head cache usage with large MAX_SKB_FRAGS values
      Revert "net: skb: introduce and use a single page frag cache"
      Merge branch 'net-remove-the-single-page-frag-cache-for-good'

Pierre Riteau (1):
      net/sched: cls_api: fix error handling causing NULL dereference

Sabrina Dubroca (1):
      tcp: drop secpath at the same time as we currently drop dst

Stephan Gerhold (1):
      net: wwan: mhi_wwan_mbim: Silence sequence number glitch errors

Yu-Chun Lin (1):
      sctp: Fix undefined behavior in left shift operation

 MAINTAINERS                                        |   9 +-
 drivers/net/ethernet/google/gve/gve.h              |  10 ++
 drivers/net/ethernet/google/gve/gve_main.c         |   6 +-
 drivers/net/ethernet/ibm/ibmvnic.c                 |   4 +-
 drivers/net/ethernet/netronome/nfp/bpf/cmsg.c      |   2 +
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |   1 +
 drivers/net/geneve.c                               |  16 +--
 drivers/net/gtp.c                                  |   5 -
 drivers/net/pse-pd/pd692x0.c                       |   2 +-
 drivers/net/wwan/mhi_wwan_mbim.c                   |   2 +-
 drivers/s390/net/ism_drv.c                         |  14 ++-
 include/linux/netdevice.h                          |   3 +-
 include/net/gro.h                                  |   3 +
 include/net/net_namespace.h                        |  11 +++
 include/net/tcp.h                                  |  14 +++
 net/core/dev.c                                     | 108 +++++++++++++++++---
 net/core/drop_monitor.c                            |  29 +++---
 net/core/flow_dissector.c                          |  49 +++++----
 net/core/gro.c                                     |   3 -
 net/core/net_namespace.c                           |   8 +-
 net/core/skbuff.c                                  | 110 ++-------------------
 net/core/sock_map.c                                |   3 +
 net/ipv4/arp.c                                     |   2 +-
 net/ipv4/tcp_fastopen.c                            |   4 +-
 net/ipv4/tcp_input.c                               |  20 ++--
 net/ipv4/tcp_ipv4.c                                |   2 +-
 net/sched/cls_api.c                                |   2 +-
 net/sctp/stream.c                                  |   2 +-
 net/vmw_vsock/af_vsock.c                           |   3 +
 net/vmw_vsock/virtio_transport.c                   |  10 +-
 net/vmw_vsock/vsock_bpf.c                          |   2 +-
 .../bpf/prog_tests/flow_dissector_classification.c |   7 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c       |  70 +++++++++----
 .../net/forwarding/tc_flower_port_range.sh         |  46 +++++++++
 34 files changed, 365 insertions(+), 217 deletions(-)


