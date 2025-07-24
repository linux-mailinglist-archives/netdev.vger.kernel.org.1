Return-Path: <netdev+bounces-209741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1A1B10AC4
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 14:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6D215655B3
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 12:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C19D2D46C4;
	Thu, 24 Jul 2025 12:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PkW0LwhM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FA740856
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753361960; cv=none; b=H/ApvFmpxtwL06xpnPGF6VxY3uXnn5emp4AQmue0MPGYHeLj+9D+EA6OJKlFG+tvC4EOql4so11nSDke2aHzyHl0cFwK8zfCL7UU3O03gpSXQz6AVen6LwFc0mmAhxiG33pcpyaO/ves6WSw3DAPdIl8NTZz3p6r/DtUfMJ7MPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753361960; c=relaxed/simple;
	bh=o+/xP/nRACgq6sYyyyENl6/+gxkfYdsCrg7JoE5NC9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FV1ecjKF5KeTJhdKDyfRtL2jZtFS6RmnR4lGK8ryvigVsLbmeb7t+vaKKt90TBB4iLk9+4JQj2AP9kcKkt5vF6bC2ScZFsT6gUyCA9fYCkMgr/2lBIRNKmMZGraC1UgHwynZ6gAQiXyp6WqxB/++x+uEnt+kaMAqIsWocrsQd34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PkW0LwhM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753361956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hZiwGdR7LRfu5HGHtwgbMQ2Giw34fi/j2EFOpcB/EYM=;
	b=PkW0LwhMqlXvJKDNQefH0QDmbZ98uzDpPOt2MDw4fF+BnL+w7zKq1+LJc3lypws7xpV0EP
	4vPMGqYq1H/V9dlDKNXJv4b0pi49TgPusvfTCo11Tt/GMY8VG/+L2tPENrFNejvE86fZXk
	EbkwU/eI+Hd0pYfuETFr1FLfmea1AF4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-q7td4VieOdeRbZQwU_ug0A-1; Thu,
 24 Jul 2025 08:59:13 -0400
X-MC-Unique: q7td4VieOdeRbZQwU_ug0A-1
X-Mimecast-MFC-AGG-ID: q7td4VieOdeRbZQwU_ug0A_1753361952
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9549419560B6;
	Thu, 24 Jul 2025 12:59:11 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.113])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4DCF119560AA;
	Thu, 24 Jul 2025 12:59:08 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.16-rc8
Date: Thu, 24 Jul 2025 14:58:59 +0200
Message-ID: <20250724125859.371031-1-pabeni@redhat.com>
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

The following changes since commit 6832a9317eee280117cd695fa885b2b7a7a38daf:

  Merge tag 'net-6.16-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-07-17 10:04:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.16-rc8

for you to fetch changes up to 291d5dc80eca1fc67a0fa4c861d13c101345501a:

  Merge tag 'ipsec-2025-07-23' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec (2025-07-24 12:30:40 +0200)

----------------------------------------------------------------
Including fixes from can and xfrm.

The TI regression notified last week is actually on our net-next tree,
it does not affect 6.16.
We are investigating a virtio regression which is quite hard to
reproduce - currently only our CI sporadically hits it. Hopefully it
should not be critical, and I'm not sure that an additional week would
be enough to solve it.

Current release - fix to a fix:

  - sched: sch_qfq: avoid sleeping in atomic context in qfq_delete_class

Previous releases - regressions:

  - xfrm:
    - set transport header to fix UDP GRO handling
    - delete x->tunnel as we delete x

  - eth: mlx5: fix memory leak in cmd_exec()

  - eth: i40e: when removing VF MAC filters, avoid losing PF-set MAC

  - eth: gve: fix stuck TX queue for DQ queue format

Previous releases - always broken:

  - can: fix NULL pointer deref of struct can_priv::do_set_mode

  - eth: ice: fix a null pointer dereference in ice_copy_and_init_pkg()

  - eth: ism: fix concurrency management in ism_cmd()

  - eth: dpaa2: fix device reference count leak in MAC endpoint handling

  - eth: icssg-prueth: fix buffer allocation for ICSSG

Misc:

  - selftests: mptcp: increase code coverage

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Chiara Meiohas (1):
      net/mlx5: Fix memory leak in cmd_exec()

Dennis Chen (1):
      i40e: report VF tx_dropped with tx_errors instead of tx_discards

Eyal Birger (1):
      xfrm: interface: fix use-after-free after changing collect_md xfrm interface

Fernando Fernandez Mancera (1):
      xfrm: ipcomp: adjust transport header after decompressing

Florian Fainelli (1):
      net: bcmasp: Restore programming of TX map vector register

Florian Westphal (1):
      selftests: netfilter: tone-down conntrack clash test

Halil Pasic (1):
      s390/ism: fix concurrency management in ism_cmd()

Haoxiang Li (1):
      ice: Fix a null pointer dereference in ice_copy_and_init_pkg()

Himanshu Mittal (1):
      net: ti: icssg-prueth: Fix buffer allocation for ICSSG

Jacek Kowalski (2):
      e1000e: disregard NVM checksum on tgp when valid checksum bit is not set
      e1000e: ignore uninitialized checksum word on tgp

Jakub Kicinski (4):
      Merge branch 'mlx5-misc-fixes-2025-07-17'
      Merge branch 'selftests-mptcp-connect-cover-alt-modes'
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge tag 'linux-can-fixes-for-6.16-20250722' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can

Jamie Bainbridge (1):
      i40e: When removing VF MAC filters, only check PF-set MAC

Jian Shen (2):
      net: hns3: fix concurrent setting vlan filter issue
      net: hns3: fixed vf get max channels bug

Jijie Shao (1):
      net: hns3: default enable tx bounce buffer when smmu enabled

Kees Cook (1):
      MAINTAINERS: Add in6.h to MAINTAINERS

Kito Xu (veritas501) (1):
      net: appletalk: Fix use-after-free in AARP proxy probe

Leon Romanovsky (1):
      xfrm: always initialize offload path

Ma Ke (3):
      bus: fsl-mc: Fix potential double device reference in fsl_mc_get_endpoint()
      dpaa2-eth: Fix device reference count leak in MAC endpoint handling
      dpaa2-switch: Fix device reference count leak in MAC endpoint handling

Marc Kleine-Budde (1):
      can: netlink: can_changelink(): fix NULL pointer deref of struct can_priv::do_set_mode

Matthieu Baerts (NGI0) (2):
      selftests: mptcp: connect: also cover alt modes
      selftests: mptcp: connect: also cover checksum

Nimrod Oren (1):
      selftests: drv-net: wait for iperf client to stop sending

Paolo Abeni (2):
      Merge branch 'there-are-some-bugfix-for-the-hns3-ethernet-driver'
      Merge tag 'ipsec-2025-07-23' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec

Praveen Kaligineedi (1):
      gve: Fix stuck TX queue for DQ queue format

Sabrina Dubroca (4):
      xfrm: state: initialize state_ptrs earlier in xfrm_state_find
      xfrm: state: use a consistent pcpu_id in xfrm_state_find
      xfrm: delete x->tunnel as we delete x
      Revert "xfrm: destroy xfrm_state synchronously on net exit path"

Shahar Shitrit (1):
      net/mlx5: E-Switch, Fix peer miss rules to use peer eswitch

Steffen Klassert (2):
      Merge branch 'xfrm: fixes for xfrm_state_find under preemption'
      Merge branch 'ipsec: fix splat due to ipcomp fallback tunnel'

Tobias Brunner (1):
      xfrm: Set transport header to fix UDP GRO handling

Xiang Mei (1):
      net/sched: sch_qfq: Avoid triggering might_sleep in atomic context in qfq_delete_class

Yonglong Liu (1):
      net: hns3: disable interrupt when ptp init failed

 MAINTAINERS                                        |   1 +
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |  19 ++-
 drivers/net/can/dev/dev.c                          |  12 +-
 drivers/net/can/dev/netlink.c                      |  12 ++
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c   |   3 +
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |  15 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-switch.c    |  15 +-
 drivers/net/ethernet/google/gve/gve_main.c         |  67 +++++----
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  31 ++++
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |   2 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  36 +++--
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c |   9 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |   6 +-
 drivers/net/ethernet/intel/e1000e/defines.h        |   3 +
 drivers/net/ethernet/intel/e1000e/ich8lan.c        |   2 +
 drivers/net/ethernet/intel/e1000e/nvm.c            |   6 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   6 +-
 drivers/net/ethernet/intel/ice/ice_ddp.c           |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |   4 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c | 108 +++++++-------
 drivers/net/ethernet/ti/icssg/icssg_config.c       | 158 ++++++++++++++-------
 drivers/net/ethernet/ti/icssg/icssg_config.h       |  80 +++++++++--
 drivers/net/ethernet/ti/icssg/icssg_prueth.c       |  20 ++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h       |   2 +
 drivers/net/ethernet/ti/icssg/icssg_switch_map.h   |   3 +
 drivers/s390/net/ism_drv.c                         |   3 +
 include/linux/ism.h                                |   1 +
 include/net/xfrm.h                                 |  15 +-
 net/appletalk/aarp.c                               |  24 +++-
 net/ipv4/ipcomp.c                                  |   2 +
 net/ipv4/xfrm4_input.c                             |   3 +
 net/ipv6/ipcomp6.c                                 |   2 +
 net/ipv6/xfrm6_input.c                             |   3 +
 net/ipv6/xfrm6_tunnel.c                            |   2 +-
 net/key/af_key.c                                   |   2 +-
 net/sched/sch_qfq.c                                |   7 +-
 net/xfrm/xfrm_device.c                             |   1 -
 net/xfrm/xfrm_interface_core.c                     |   7 +-
 net/xfrm/xfrm_ipcomp.c                             |   3 +-
 net/xfrm/xfrm_state.c                              |  69 ++++-----
 net/xfrm/xfrm_user.c                               |   3 +-
 tools/testing/selftests/drivers/net/lib/py/load.py |  23 ++-
 tools/testing/selftests/net/mptcp/Makefile         |   3 +-
 .../selftests/net/mptcp/mptcp_connect_checksum.sh  |   5 +
 .../selftests/net/mptcp/mptcp_connect_mmap.sh      |   5 +
 .../selftests/net/mptcp/mptcp_connect_sendfile.sh  |   5 +
 .../selftests/net/netfilter/conntrack_clash.sh     |  45 +++---
 47 files changed, 549 insertions(+), 306 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh


