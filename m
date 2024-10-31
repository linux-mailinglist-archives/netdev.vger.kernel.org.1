Return-Path: <netdev+bounces-140743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06199B7C98
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 15:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FADB28328F
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 14:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD8119AD8D;
	Thu, 31 Oct 2024 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eegF9n4x"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBF842AA5
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730384334; cv=none; b=NBZwdgxiWr3VVY22akdNRw+Hj7jmkmIa8YGnb8AlBcpuAV9LgXyEkV/wzcG4lvzS1lyh29d7kEcvEROdoB4U+r0O7IskQE8nSTj4Y+rk5gJ4aZKFlUWG6d60Q8IW6wMiGXMb/+X8f0LTJzwP/d+N9mv+5eGwK0EnvpFP3L8W1ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730384334; c=relaxed/simple;
	bh=pyIaJuTIu2HHsApR52UlkQYRh2kNpEu6lWw815kZW+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IFnJCXwIDLIZhz5d9ijDjlMNuQHZlhuchTg2bkQDeJ2OTyiK31ALXjBnS8Ia+7ry2BwwPUQAH/GLUXASiuuUOBRGqwZr4nXtEOlLyBbrVybNWGlvVv6/pt+BIq/U1JNLs6ItSQl7ow+bCB2jdK4jDuhZGRJkZJff9GeEVsEEfgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eegF9n4x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730384330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PYAAlWETRD15vMxxt6nPCs+6wro0Fi29juJRShvtRJE=;
	b=eegF9n4xtNbGOKVl3yYUvm12p0c6CZaR+n2EYjD3Hp3t04XRumRqUPbFQQ3Jy0pbdyVnIO
	sTM8TMWB9XxVTFOa3z4/aLk/R4gdrGPcJjlIFauUcQT9gXH3rIop93Rjo8k+eZl4EXa5rr
	W7rMaaEBp42zyyCEpZ6jx1d8o0vugBA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-2tRVGBwSM466ImBOnXZwGQ-1; Thu,
 31 Oct 2024 10:18:46 -0400
X-MC-Unique: 2tRVGBwSM466ImBOnXZwGQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39E921955D63;
	Thu, 31 Oct 2024 14:18:45 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.32])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0D9AC30001B4;
	Thu, 31 Oct 2024 14:18:42 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.12-rc6
Date: Thu, 31 Oct 2024 15:17:48 +0100
Message-ID: <20241031141748.160214-1-pabeni@redhat.com>
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

The following changes since commit d44cd8226449114780a8554fd253c7e3d171a0a6:

  Merge tag 'net-6.12-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-10-24 16:43:50 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.12-rc6

for you to fetch changes up to 50ae879de107ca2fe2ca99180f6ba95770f32a62:

  Merge tag 'nf-24-10-31' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf (2024-10-31 12:13:08 +0100)

----------------------------------------------------------------
Including fixes from WiFi, bluetooth and netfilter.

No known new regressions outstanding.

Current release - regressions:

  - wifi: mt76: do not increase mcu skb refcount if retry is not supported

Current release - new code bugs:

  - wifi:
    - rtw88: fix the RX aggregation in USB 3 mode
    - mac80211: fix memory corruption bug in struct ieee80211_chanctx

Previous releases - regressions:

  - sched:
    - stop qdisc_tree_reduce_backlog on TC_H_ROOT
    - sch_api: fix xa_insert() error path in tcf_block_get_ext()

  - wifi:
    - revert "wifi: iwlwifi: remove retry loops in start"
    - cfg80211: clear wdev->cqm_config pointer on free

  - netfilter: fix potential crash in nf_send_reset6()

  - ip_tunnel: fix suspicious RCU usage warning in ip_tunnel_find()

  - bluetooth: fix null-ptr-deref in hci_read_supported_codecs

  - eth: mlxsw: add missing verification before pushing Tx header

  - eth: hns3: fixed hclge_fetch_pf_reg accesses bar space out of bounds issue

Previous releases - always broken:

  - wifi: mac80211: do not pass a stopped vif to the driver in .get_txpower

  - netfilter: sanitize offset and length before calling skb_checksum()

  - core:
    - fix crash when config small gso_max_size/gso_ipv4_max_size
    - skip offload for NETIF_F_IPV6_CSUM if ipv6 header contains extension

  - mptcp: protect sched with rcu_read_lock

  - eth: ice: fix crash on probe for DPLL enabled E810 LOM

  - eth: macsec: fix use-after-free while sending the offloading packet

  - eth: stmmac: fix unbalanced DMA map/unmap for non-paged SKB data

  - eth: hns3: fix kernel crash when 1588 is sent on HIP08 devices

  - eth: mtk_wed: fix path of MT7988 WO firmware

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Amit Cohen (3):
      mlxsw: spectrum_ptp: Add missing verification before pushing Tx header
      mlxsw: pci: Sync Rx buffers for CPU
      mlxsw: pci: Sync Rx buffers for device

Anjaneyulu (1):
      wifi: iwlwifi: mvm: SAR table alignment

Arkadiusz Kubalewski (1):
      ice: fix crash on probe for DPLL enabled E810 LOM

Ben Greear (2):
      wifi: mac80211: Fix setting txpower with emulate_chanctx
      mac80211: fix user-power when emulating chanctx

Ben Hutchings (1):
      wifi: iwlegacy: Fix "field-spanning write" warning in il_enqueue_hcmd()

Benjamin Große (1):
      usb: add support for new USB device ID 0x17EF:0x3098 for the r8152 driver

Benoît Monin (2):
      net: usb: qmi_wwan: add Quectel RG650V
      net: skip offload for NETIF_F_IPV6_CSUM if ipv6 header contains extension

Bitterblue Smith (2):
      wifi: rtw88: Fix the RX aggregation in USB 3 mode
      wifi: rtlwifi: rtl8192du: Don't claim USB ID 0bda:8171

Chenming Huang (1):
      wifi: cfg80211: Do not create BSS entries for unsupported channels

Daniel Gabay (2):
      wifi: iwlwifi: mvm: Use the sync timepoint API in suspend
      wifi: iwlwifi: mvm: Fix response handling in iwl_mvm_send_recovery_cmd()

Daniel Golle (1):
      net: ethernet: mtk_wed: fix path of MT7988 WO firmware

David S. Miller (1):
      Merge tag 'wireless-2024-10-21' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

Dong Chenchen (1):
      netfilter: Fix use-after-free in get_info()

Emmanuel Grumbach (3):
      wifi: iwlwifi: mvm: don't leak a link on AP removal
      wifi: iwlwifi: mvm: don't add default link in fw restart flow
      Revert "wifi: iwlwifi: remove retry loops in start"

Eric Dumazet (1):
      netfilter: nf_reject_ipv6: fix potential crash in nf_send_reset6()

Felix Fietkau (3):
      wifi: mt76: do not increase mcu skb refcount if retry is not supported
      wifi: mac80211: do not pass a stopped vif to the driver in .get_txpower
      wifi: mac80211: skip non-uploaded keys in ieee80211_iter_keys

Florian Westphal (1):
      selftests: netfilter: nft_flowtable.sh: make first pass deterministic

Furong Xu (1):
      net: stmmac: TSO: Fix unbalanced DMA map/unmap for non-paged SKB data

Geert Uytterhoeven (2):
      mac80211: MAC80211_MESSAGE_TRACING should depend on TRACING
      wifi: brcm80211: BRCM_TRACING should depend on TRACING

Gustavo A. R. Silva (2):
      wifi: radiotap: Avoid -Wflex-array-member-not-at-end warnings
      wifi: mac80211: ieee80211_i: Fix memory corruption bug in struct ieee80211_chanctx

Hao Lan (4):
      net: hns3: fixed reset failure issues caused by the incorrect reset type
      net: hns3: fix missing features due to dev->features configuration too early
      net: hns3: Resolved the issue that the debugfs query result is inconsistent.
      net: hns3: fixed hclge_fetch_pf_reg accesses bar space out of bounds issue

Ido Schimmel (4):
      ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_init_flow()
      ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_find()
      mlxsw: spectrum_ipip: Fix memory leak when changing remote IPv6 address
      selftests: forwarding: Add IPv6 GRE remote change tests

Jakub Kicinski (3):
      Merge branch 'mptcp-sched-fix-some-lock-issues'
      Merge tag 'wireless-2024-10-29' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge branch 'mlxsw-fixes'

Jian Shen (3):
      net: hns3: add sync command to sync io-pgtable
      net: hns3: don't auto enable misc vector
      net: hns3: initialize reset_timer before hclgevf_misc_irq_init()

Jianbo Liu (1):
      macsec: Fix use-after-free while sending the offloading packet

Jie Wang (1):
      net: hns3: fix kernel crash when 1588 is sent on HIP08 devices

Johannes Berg (2):
      wifi: cfg80211: clear wdev->cqm_config pointer on free
      wifi: iwlwifi: mvm: fix 6 GHz scan construction

Kalle Valo (1):
      Merge tag 'ath-current-20241016' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Levi Zim (1):
      docs: networking: packet_mmap: replace dead links with archive.org links

Ley Foon Tan (1):
      net: stmmac: dwmac4: Fix high address display by updating reg_space[] from register values

Liu Jing (1):
      selftests: netfilter: remove unused parameter

Manikanta Pubbisetty (1):
      wifi: ath10k: Fix memory leak in management tx

Matt Johnston (1):
      mctp i2c: handle NULL header address

Matthieu Baerts (NGI0) (2):
      mptcp: init: protect sched with rcu_read_lock
      selftests: mptcp: list sysctl data

Michal Swiatkowski (1):
      ice: block SF port creation in legacy mode

Miri Korenblit (1):
      wifi: iwlwifi: mvm: really send iwl_txpower_constraints_cmd

Pablo Neira Ayuso (2):
      gtp: allow -1 to be specified as file description from userspace
      netfilter: nft_payload: sanitize offset and length before calling skb_checksum()

Paolo Abeni (4):
      Merge branch 'intel-wired-lan-driver-fixes-2024-10-21-igb-ice'
      Merge branch 'there-are-some-bugfix-for-the-hns3-ethernet-driver'
      Merge tag 'for-net-2024-10-30' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge tag 'nf-24-10-31' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Pedro Tammela (1):
      net/sched: stop qdisc_tree_reduce_backlog on TC_H_ROOT

Peiyang Wang (1):
      net: hns3: default enable tx bounce buffer when smmu enabled

Ping-Ke Shih (2):
      wifi: rtw89: coex: add debug message of link counts on 2/5GHz bands for wl_info v7
      wifi: rtw89: pci: early chips only enable 36-bit DMA on specific PCI hosts

Remi Pommarel (3):
      wifi: cfg80211: Add wiphy_delayed_work_pending()
      wifi: mac80211: Convert color collision detection to wiphy work
      wifi: ath11k: Fix invalid ring usage in full monitor mode

Sungwoo Kim (1):
      Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs

Ville Syrjälä (1):
      wifi: iwlegacy: Clear stale interrupts before resuming device

Vladimir Oltean (1):
      net/sched: sch_api: fix xa_insert() error path in tcf_block_get_ext()

Wander Lairson Costa (1):
      igb: Disable threaded IRQ for igb_msix_other

Wang Liang (1):
      net: fix crash when config small gso_max_size/gso_ipv4_max_size

Zichen Xie (1):
      netdevsim: Add trailing zero to terminate the string in nsim_nexthop_bucket_activity_write()

 Documentation/networking/packet_mmap.rst           |  5 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |  4 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 59 ++++++++++++-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |  2 +
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 33 ++++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 45 ++++++++--
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c |  3 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_regs.c    |  9 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 40 +++++++--
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c  |  9 +-
 .../net/ethernet/intel/ice/devlink/devlink_port.c  |  6 ++
 drivers/net/ethernet/intel/ice/ice_dpll.c          | 70 ++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c        | 21 ++++-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h        |  1 +
 drivers/net/ethernet/intel/igb/igb_main.c          |  2 +-
 drivers/net/ethernet/mediatek/mtk_wed_wo.h         |  4 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c          | 25 ++++--
 .../net/ethernet/mellanox/mlxsw/spectrum_ipip.c    | 26 +++++-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c |  7 ++
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c   |  8 ++
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h   |  2 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 22 +++--
 drivers/net/gtp.c                                  | 22 +++--
 drivers/net/macsec.c                               |  3 +-
 drivers/net/mctp/mctp-i2c.c                        |  3 +
 drivers/net/netdevsim/fib.c                        |  4 +-
 drivers/net/usb/qmi_wwan.c                         |  1 +
 drivers/net/usb/r8152.c                            |  1 +
 drivers/net/wireless/ath/ath10k/wmi-tlv.c          |  7 +-
 drivers/net/wireless/ath/ath10k/wmi.c              |  2 +
 drivers/net/wireless/ath/ath11k/dp_rx.c            |  7 +-
 drivers/net/wireless/ath/wil6210/txrx.c            |  2 +-
 drivers/net/wireless/broadcom/brcm80211/Kconfig    |  1 +
 drivers/net/wireless/intel/ipw2x00/ipw2100.c       |  2 +-
 drivers/net/wireless/intel/ipw2x00/ipw2200.h       |  2 +-
 drivers/net/wireless/intel/iwlegacy/common.c       | 15 +++-
 drivers/net/wireless/intel/iwlegacy/common.h       | 12 +++
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       | 96 +++++++++++++---------
 drivers/net/wireless/intel/iwlwifi/fw/init.c       |  4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       | 28 +++++--
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h       |  3 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  2 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        | 10 +--
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  | 12 ++-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  | 34 +++++---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |  6 +-
 drivers/net/wireless/marvell/libertas/radiotap.h   |  4 +-
 drivers/net/wireless/mediatek/mt76/mcu.c           |  7 +-
 drivers/net/wireless/microchip/wilc1000/mon.c      |  4 +-
 .../net/wireless/realtek/rtlwifi/rtl8192du/sw.c    |  1 -
 drivers/net/wireless/realtek/rtw88/usb.c           |  1 -
 drivers/net/wireless/realtek/rtw89/coex.c          |  2 +
 drivers/net/wireless/realtek/rtw89/pci.c           | 48 +++++++++--
 drivers/net/wireless/virtual/mac80211_hwsim.c      |  4 +-
 include/net/cfg80211.h                             | 44 ++++++++++
 include/net/ieee80211_radiotap.h                   | 43 +++++-----
 include/net/ip_tunnels.h                           |  2 +-
 net/bluetooth/hci_sync.c                           | 18 ++--
 net/core/dev.c                                     |  4 +
 net/core/rtnetlink.c                               |  4 +-
 net/ipv4/ip_tunnel.c                               |  2 +-
 net/ipv6/netfilter/nf_reject_ipv6.c                | 15 ++--
 net/mac80211/Kconfig                               |  2 +-
 net/mac80211/cfg.c                                 | 25 ++++--
 net/mac80211/ieee80211_i.h                         | 10 ++-
 net/mac80211/key.c                                 | 42 ++++++----
 net/mac80211/link.c                                |  7 +-
 net/mac80211/main.c                                |  2 +
 net/mptcp/protocol.c                               |  2 +
 net/netfilter/nft_payload.c                        |  3 +
 net/netfilter/x_tables.c                           |  2 +-
 net/sched/cls_api.c                                |  1 +
 net/sched/sch_api.c                                |  2 +-
 net/wireless/core.c                                |  8 ++
 net/wireless/scan.c                                |  4 +
 .../selftests/net/forwarding/ip6gre_flat.sh        | 14 ++++
 .../selftests/net/forwarding/ip6gre_flat_key.sh    | 14 ++++
 .../selftests/net/forwarding/ip6gre_flat_keys.sh   | 14 ++++
 .../selftests/net/forwarding/ip6gre_hier.sh        | 14 ++++
 .../selftests/net/forwarding/ip6gre_hier_key.sh    | 14 ++++
 .../selftests/net/forwarding/ip6gre_hier_keys.sh   | 14 ++++
 .../testing/selftests/net/forwarding/ip6gre_lib.sh | 80 ++++++++++++++++++
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  9 ++
 .../selftests/net/netfilter/conntrack_dump_flush.c |  6 +-
 .../selftests/net/netfilter/nft_flowtable.sh       | 39 +++++----
 85 files changed, 964 insertions(+), 249 deletions(-)


