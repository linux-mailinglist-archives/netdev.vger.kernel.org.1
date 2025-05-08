Return-Path: <netdev+bounces-188977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2C4AAFB5F
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 15:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41CF11B62BC5
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 13:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B603C22CBEC;
	Thu,  8 May 2025 13:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/F7Okht"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C464E4B1E6D
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 13:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746711090; cv=none; b=TLjBqMVQsmzgUqASFgK8DzQPwxjmLXhWaw6/cjorRQ6G40p0aGfuB/DgiPhv0+PPbMOLRQBxivWhRd2s7bdItYW5M1paBPX+1LnlRm+2lHxwyU17ryx684RU8rsHD12cwVqbzAcvpoKyOIjBpyOYT7JZtt3cHQ1JgJRsWw+xtaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746711090; c=relaxed/simple;
	bh=IWyQOH4KJr7+U588TsFrW8c5cTPJb6v2JhKWRyh751Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T39HlDWyhh3/GnqyhNUMIOz5+1+wfu2J+xpHGYSy59y6DW/d2udhXQQme3Vp/qjCn0LX2Ju8u5Iwojw0XxChrz1opG3Wm5Rout61ZS1sRXdSffDVwx+14jUmGfJI6nQC6VrLXy/c/MAJTkpKE7Ns0lydnACEEW80RGm8gEujnkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U/F7Okht; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746711087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rwNgjc6JmrjE2tRvDj3ZVBmfYQMrw/czepg62caXD9M=;
	b=U/F7Okht8bGyiDFZU3hmVywfpJRk2X2Ya2DNmii3EP1XridSZ7d7aEe/rkEnKfuwg+pyVv
	bbgh2u7ogh6B0lpcVUf4wRlBCK3VyoZw/AaX395Wcp/lATp8QqcK0PpybdGXU/SuhG0mD1
	ybnuy8ehYLm1YlvOMSI3H5VM6MDP1Ic=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-EDork1TrMpmcVPyYQETBRQ-1; Thu,
 08 May 2025 09:31:21 -0400
X-MC-Unique: EDork1TrMpmcVPyYQETBRQ-1
X-Mimecast-MFC-AGG-ID: EDork1TrMpmcVPyYQETBRQ_1746711080
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D67519541B6;
	Thu,  8 May 2025 13:31:20 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.138])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 525A91953B85;
	Thu,  8 May 2025 13:31:17 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.15-rc6
Date: Thu,  8 May 2025 15:31:06 +0200
Message-ID: <20250508133106.37026-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi Linus!

The following changes since commit ebd297a2affadb6f6f4d2e5d975c1eda18ac762d:

  Merge tag 'net-6.15-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-05-01 10:37:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.15-rc6

for you to fetch changes up to 3c44b2d615e6ee08d650c2864fdc4e68493eac0c:

  Merge branch 'virtio-net-fix-total-qstat-values' (2025-05-08 11:56:14 +0200)

----------------------------------------------------------------
Including fixes from CAN, WiFi and netfilter.

We have still a comple of regressions open due to the recent
drivers locking refactor. The patches are in-flight, but not
ready yet.

Current release - regressions:

  - core: lock netdevices during dev_shutdown

  - sch_htb: make htb_deactivate() idempotent

  - eth: virtio-net: don't re-enable refill work too early

Current release - new code bugs:

  - eth: icssg-prueth: fix kernel panic during concurrent Tx queue access

Previous releases - regressions:

  - gre: fix again IPv6 link-local address generation.

  - eth: b53: fix learning on VLAN unaware bridges

Previous releases - always broken:

  - wifi: fix out-of-bounds access during multi-link element defragmentation

  - can:
    - initialize spin lock on device probe
    - fix order of unregistration calls

  - openvswitch: fix unsafe attribute parsing in output_userspace()

  - eth: virtio-net: fix total qstat values

  - eth: mtk_eth_soc: reset all TX queues on DMA free

  - eth: fbnic: firmware IPC mailbox fixes

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alexander Duyck (8):
      fbnic: Fix initialization of mailbox descriptor rings
      fbnic: Gate AXI read/write enabling on FW mailbox
      fbnic: Add additional handling of IRQs
      fbnic: Actually flush_tx instead of stalling out
      fbnic: Cleanup handling of completions
      fbnic: Improve responsiveness of fbnic_mbx_poll_tx_ready
      fbnic: Pull fbnic_fw_xmit_cap_msg use out of interrupt context
      fbnic: Do not allow mailbox to toggle to ready outside fbnic_mbx_poll_tx_ready

Andrew Lunn (1):
      dt-bindings: net: ethernet-controller: Add informative text about RGMII delays

Antonios Salios (1):
      can: m_can: m_can_class_allocate_dev(): initialize spin lock on device probe

Cong Wang (2):
      sch_htb: make htb_deactivate() idempotent
      selftests/tc-testing: Add a test case to cover basic HTB+FQ_CODEL case

Cosmin Ratiu (1):
      net: Lock netdevices during dev_shutdown

Daniel Golle (1):
      net: ethernet: mtk_eth_soc: reset all TX queues on DMA free

David Wei (1):
      tools: ynl-gen: validate 0 len strings from kernel

Eelco Chaudron (1):
      openvswitch: Fix unsafe attribute parsing in output_userspace()

Frank Wunderlich (1):
      net: ethernet: mtk_eth_soc: do not reset PSE when setting FE

Guillaume Nault (2):
      gre: Fix again IPv6 link-local address generation.
      selftests: Add IPv6 link-local address generation tests for GRE devices.

Jakub Kicinski (12):
      Merge branch 'net_sched-fix-a-regression-in-sch_htb'
      virtio-net: don't re-enable refill work too early when NAPI is disabled
      virtio-net: free xsk_buffs on error in virtnet_xsk_pool_enable()
      Merge branch 'gre-reapply-ipv6-link-local-address-generation-fix'
      Merge branch 'selftests-drv-net-fix-ping-py-test-failure'
      Merge tag 'linux-can-fixes-for-6.15-20250506' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
      Merge tag 'wireless-2025-05-06' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge tag 'nf-25-05-08' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge branch 'bug-fixes-from-xdp-patch-series'
      Merge branch 'net-dsa-b53-accumulated-fixes'
      net: export a helper for adding up queue stats
      virtio-net: fix total qstat values

Johannes Berg (1):
      wifi: iwlwifi: add support for Killer on MTL

Jonas Gorski (11):
      net: dsa: b53: allow leaky reserved multicast
      net: dsa: b53: keep CPU port always tagged again
      net: dsa: b53: fix clearing PVID of a port
      net: dsa: b53: fix flushing old pvid VLAN on pvid change
      net: dsa: b53: fix VLAN ID for untagged vlan on bridge leave
      net: dsa: b53: always rejoin default untagged VLAN on bridge leave
      net: dsa: b53: do not allow to configure VLAN 0
      net: dsa: b53: do not program vlans when vlan filtering is off
      net: dsa: b53: fix toggling vlan_filtering
      net: dsa: b53: fix learning on VLAN unaware bridges
      net: dsa: b53: do not set learning and unicast/multicast on up

Jozsef Kadlecsik (1):
      netfilter: ipset: fix region locking in hash types

Julian Anastasov (1):
      ipvs: fix uninit-value for saddr in do_output_route4

Kelsey Maes (1):
      can: mcp251xfd: fix TDC setting for low data bit rates

Lorenzo Bianconi (1):
      net: airoha: Add missing field to ppe_mbox_data struct

Marc Kleine-Budde (4):
      can: mcp251xfd: mcp251xfd_remove(): fix order of unregistration calls
      can: rockchip_canfd: rkcanfd_remove(): fix order of unregistration calls
      can: mcan: m_can_class_unregister(): fix order of unregistration calls
      Merge patch series "can: rx-offload: fix order of unregistration calls"

Meghana Malladi (3):
      net: ti: icssg-prueth: Set XDP feature flags for ndev
      net: ti: icssg-prueth: Fix kernel panic during concurrent Tx queue access
      net: ti: icssg-prueth: Report BQL before sending XDP packets

Michael-CY Lee (1):
      wifi: mac80211: fix the type of status_code for negotiated TID to Link Mapping

Mohsin Bashir (3):
      selftests: drv: net: fix test failure on ipv6 sys
      selftests: drv: net: avoid skipping tests
      selftests: drv: net: add version indicator

Oliver Hartkopp (1):
      can: gw: fix RCU/BH usage in cgw_create_job()

Paolo Abeni (2):
      Merge branch 'fbnic-fw-ipc-mailbox-fixes'
      Merge branch 'virtio-net-fix-total-qstat-values'

Paul Chaignon (2):
      bpf: Scrub packet on bpf_redirect_peer
      bpf: Clarify handling of mark and tstamp by redirect_peer

Przemek Kitszel (1):
      ice: use DSN instead of PCI BDF for ice_adapter index

Stanislav Fomichev (1):
      net: add missing instance lock to dev_set_promiscuity

Veerendranath Jakkam (1):
      wifi: cfg80211: fix out-of-bounds access during multi-link element defragmentation

 .../bindings/net/ethernet-controller.yaml          |  97 +++++++++-
 drivers/net/can/m_can/m_can.c                      |   3 +-
 drivers/net/can/rockchip/rockchip_canfd-core.c     |   2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c     |  42 ++++-
 drivers/net/dsa/b53/b53_common.c                   | 207 +++++++++++++++------
 drivers/net/dsa/b53/b53_priv.h                     |   3 +
 drivers/net/dsa/bcm_sf2.c                          |   1 +
 drivers/net/ethernet/airoha/airoha_npu.c           |  10 +-
 drivers/net/ethernet/intel/ice/ice_adapter.c       |  47 ++---
 drivers/net/ethernet/intel/ice/ice_adapter.h       |   6 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |  19 +-
 drivers/net/ethernet/meta/fbnic/fbnic.h            |   8 +-
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h        |   2 +
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c         | 197 ++++++++++++--------
 drivers/net/ethernet/meta/fbnic/fbnic_irq.c        | 142 +++++++++-----
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c        |   6 -
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c     |   5 +-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c        |  14 +-
 drivers/net/ethernet/ti/icssg/icssg_common.c       |  15 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c       |  16 +-
 drivers/net/virtio_net.c                           |  23 ++-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   2 +
 include/linux/ieee80211.h                          |   2 +-
 include/linux/netdevice.h                          |   1 +
 include/net/netdev_queues.h                        |   6 +
 include/uapi/linux/bpf.h                           |   3 +
 net/can/gw.c                                       | 149 +++++++++------
 net/core/dev.c                                     |  18 +-
 net/core/dev_api.c                                 |  23 +++
 net/core/filter.c                                  |   1 +
 net/core/netdev-genl.c                             |  69 +++++--
 net/ipv6/addrconf.c                                |  15 +-
 net/mac80211/mlme.c                                |  12 +-
 net/netfilter/ipset/ip_set_hash_gen.h              |   2 +-
 net/netfilter/ipvs/ip_vs_xmit.c                    |  27 +--
 net/openvswitch/actions.c                          |   3 +-
 net/sched/sch_htb.c                                |  15 +-
 net/wireless/scan.c                                |   2 +-
 tools/include/uapi/linux/bpf.h                     |   3 +
 tools/net/ynl/lib/ynl.c                            |   2 +-
 tools/testing/selftests/drivers/net/ping.py        |  45 +++--
 tools/testing/selftests/net/Makefile               |   1 +
 tools/testing/selftests/net/gre_ipv6_lladdr.sh     | 177 ++++++++++++++++++
 .../tc-testing/tc-tests/infra/qdiscs.json          |  35 ++++
 44 files changed, 1049 insertions(+), 429 deletions(-)
 create mode 100755 tools/testing/selftests/net/gre_ipv6_lladdr.sh


