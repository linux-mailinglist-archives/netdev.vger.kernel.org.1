Return-Path: <netdev+bounces-97029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 703D28C8D36
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 22:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D73D1C21E47
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 20:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0A913DDB0;
	Fri, 17 May 2024 20:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJlAWmsQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C324A65F;
	Fri, 17 May 2024 20:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715976866; cv=none; b=KdZnhtPnWatu5ZrOWx7Q74jr2crumhfWQYh3RTnJ5XMDZ+Iet238V5svZ2q/GRYVI/Mtu0Lv4PCL4ZYovJhBvV4aqTqTy6TojfmiZsuE5+rpuDkJfZaixGvqjXrTVicRGjimXoA5QVj9C+U33uKi1YNhI4RtN9hgc2O2MZlmco0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715976866; c=relaxed/simple;
	bh=AsAtcPWfIsP/bcM2zWmQJXqUBcqm2UxloNpGZgcPfMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S/b4jIwbTGdaLZH+F48QOmW1WL9Zx2K4S6sbnbJoTkMmKEtkrFy8TXsh+ubShWCtBuq9IOxfbEz++yC2RUditkh9s3PBuLOcRUJQ7iHWUGutg3lHIjy4CKKx7VIIyjWUD58F8RM5xoGk9rxAbh47qGZfMrpgDa0hwXhxO2FigqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJlAWmsQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6131FC2BD10;
	Fri, 17 May 2024 20:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715976866;
	bh=AsAtcPWfIsP/bcM2zWmQJXqUBcqm2UxloNpGZgcPfMk=;
	h=From:To:Cc:Subject:Date:From;
	b=kJlAWmsQXHARBSzpy+qzQUO2VA7IuUxC9Md73or2OoIUiMTmAf6JvZc3i+JmLqElz
	 kg2wNWygGSVywt0xfWSr0Ada7B+Mr8MhCaFbSbHVHhVTJNH2F9pTBdkYg/0Q3JkxAN
	 l7wNNYMzIQmAlh3uCcV/Qet3/o41aFpJwbJPVKK+bpG+1qT3sYuHIE5tcTViKIGdod
	 2ZirvQyd/OiwpjAW2XWchSmU2LQvkO0OZ4Lq/Of4kf8QWOZ+F4ix7IFmFQM7/RO5jw
	 mMObhEs+GxIlNG6ktI71N4cDM4SwdHvN8tuvQ/jQnC/aGomIo3/coK4/W/P2fzTOGo
	 R1vrV254hYlFg==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking merge window fixes
Date: Fri, 17 May 2024 13:14:25 -0700
Message-ID: <20240517201425.3080823-1-kuba@kernel.org>
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

The following changes since commit 1b294a1f35616977caddaddf3e9d28e576a1adbc:

  Merge tag 'net-next-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2024-05-14 19:42:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.10-rc0

for you to fetch changes up to fe56d6e4a99a40f50e64d5a8043f1fa838b1f7a1:

  selftests: net: local_termination: annotate the expected failures (2024-05-17 12:26:35 -0700)

----------------------------------------------------------------
Including fix from Andrii for the issue mentioned in our net-next PR,
the rest is unremarkable.

Current release - regressions:

 - virtio_net: fix missed error path rtnl_unlock after control queue
   locking rework

Current release - new code bugs:

 - bpf: fix KASAN slab-out-of-bounds in percpu_array_map_gen_lookup,
   caused by missing nested map handling

 - drv: dsa: correct initialization order for KSZ88x3 ports

Previous releases - regressions:

 - af_packet: do not call packet_read_pending() from tpacket_destruct_skb()
   fix performance regression

 - ipv6: fix route deleting failure when metric equals 0, don't assume
   0 means not set / default in this case

Previous releases - always broken:

 - bridge: couple of syzbot-driven fixes

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Andrii Nakryiko (3):
      libbpf: fix feature detectors when using token_fd
      bpf: save extended inner map info for percpu array maps as well
      selftests/bpf: add more variations of map-in-map situations

Chris Lew (1):
      net: qrtr: ns: Fix module refcnt

Daniel Jurgens (1):
      virtio_net: Fix missed rtnl_unlock

David S. Miller (1):
      Merge branch 'wangxun-fixes'

Eric Dumazet (2):
      netrom: fix possible dead-lock in nr_rt_ioctl()
      af_packet: do not call packet_read_pending() from tpacket_destruct_skb()

Hangbin Liu (2):
      selftests/net/lib: no need to record ns name if it already exist
      selftests/net: reduce xfrm_policy test time

Herve Codina (1):
      net: lan966x: remove debugfs directory in probe() error path

Jakub Kicinski (3):
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
      selftests: net: local_termination: annotate the expected failures

Jiawen Wu (3):
      net: wangxun: fix to change Rx features
      net: wangxun: match VLAN CTAG and STAG features
      net: txgbe: fix to control VLAN strip

Martin KaFai Lau (2):
      selftests/bpf: Adjust test_access_variable_array after a kernel function name change
      selftests/bpf: Adjust btf_dump test to reflect recent change in file_operations

Michal Schmidt (1):
      idpf: don't skip over ethtool tcp-data-split setting

Nikolay Aleksandrov (3):
      net: bridge: xmit: make sure we have at least eth header len bytes
      selftests: net: bridge: increase IGMP/MLD exclude timeout membership interval
      net: bridge: mst: fix vlan use-after-free

Oleksij Rempel (1):
      net: dsa: microchip: Correct initialization order for KSZ88x3 ports

Puranjay Mohan (2):
      bpf, docs: Fix the description of 'src' in ALU instructions
      MAINTAINERS: Update ARM64 BPF JIT maintainer

Ravi Gunasekaran (2):
      dt-bindings: net: ti: Update maintainers list
      MAINTAINERS: net: Update reviewers for TI's Ethernet drivers

Ronald Wahl (1):
      net: ks8851: Fix another TX stall caused by wrong ISR flag handling

Sagar Cheluvegowda (1):
      dt-bindings: net: qcom: ethernet: Allow dma-coherent

Tom Parkin (1):
      l2tp: fix ICMP error handling for UDP-encap sockets

Tony Battersby (1):
      bonding: fix oops during rmmod

xu xin (1):
      net/ipv6: Fix route deleting failure when metric equals 0

 .../bpf/standardization/instruction-set.rst        |  5 +-
 .../devicetree/bindings/net/qcom,ethqos.yaml       |  2 +
 .../devicetree/bindings/net/ti,cpsw-switch.yaml    |  1 -
 .../bindings/net/ti,k3-am654-cpsw-nuss.yaml        |  1 -
 .../devicetree/bindings/net/ti,k3-am654-cpts.yaml  |  1 -
 MAINTAINERS                                        |  3 +-
 drivers/net/bonding/bond_main.c                    | 13 ++---
 drivers/net/dsa/microchip/ksz_dcb.c                | 10 ++++
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c     |  3 +-
 drivers/net/ethernet/micrel/ks8851_common.c        | 18 +------
 .../net/ethernet/microchip/lan966x/lan966x_main.c  |  6 ++-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c         |  2 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        | 56 ++++++++++++++++++++--
 drivers/net/ethernet/wangxun/libwx/wx_lib.h        |  2 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h       | 22 +++++++++
 drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c   | 18 +++++--
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c      |  1 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c | 18 +++++--
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c    | 31 ++++++++++++
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h    |  1 +
 drivers/net/virtio_net.c                           |  6 +--
 kernel/bpf/map_in_map.c                            |  4 +-
 net/bridge/br_device.c                             |  6 +++
 net/bridge/br_mst.c                                | 16 ++++---
 net/ipv6/route.c                                   |  5 +-
 net/l2tp/l2tp_core.c                               | 44 ++++++++++++-----
 net/netrom/nr_route.c                              | 19 +++-----
 net/packet/af_packet.c                             |  3 +-
 net/qrtr/ns.c                                      | 27 +++++++++++
 tools/lib/bpf/bpf.c                                |  2 +-
 tools/lib/bpf/features.c                           |  2 +-
 tools/testing/selftests/bpf/prog_tests/btf_dump.c  |  2 +-
 tools/testing/selftests/bpf/progs/map_kptr.c       | 10 ++++
 .../bpf/progs/test_access_variable_array.c         |  2 +-
 .../selftests/net/forwarding/bridge_igmp.sh        |  6 +--
 .../testing/selftests/net/forwarding/bridge_mld.sh |  6 +--
 .../selftests/net/forwarding/local_termination.sh  | 30 +++++++-----
 tools/testing/selftests/net/lib.sh                 |  6 ++-
 tools/testing/selftests/net/xfrm_policy.sh         |  4 +-
 39 files changed, 304 insertions(+), 110 deletions(-)

