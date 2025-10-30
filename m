Return-Path: <netdev+bounces-234428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A279C20938
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 15:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 540B442496C
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 14:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DE026B955;
	Thu, 30 Oct 2025 14:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T0Y+YHy5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B7326A1CF
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834293; cv=none; b=uPK13taUw7SHt0R3oo9+yaC79Bq/RZg4PWsgaXf+SAhp8UPdCEYMKdt/SWaNlJcB2zH+WYyec/pcFOSHj4/ke8q2eNvHR/+5gYiwqfDpci3BS1LgSO04I5hLsQqvXVm9g1JmOTjjaBuLVEozeXS7ch2XfWLUS5O6P3vVhMqNQh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834293; c=relaxed/simple;
	bh=cbRji5smRT1vcaorG6gHQjSz03HGWszJDkAlppuBN9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=atnAGI/qJG6GhDUu6+4m6QCF3CALRBIBdHIPP9arxvGozDH5CUuR4VI1kVwrSL3kM28W07vwlJxEC+jd5io+4CAmNDnixFMPJCrEoKmGXUML4IVDmKhRH62hA7N7j+fanyg0/d03YvP3VcSM1I0NiSB6lyynw6OaCCMPdgOsyl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T0Y+YHy5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761834289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mZVJ1MysJf9HvK2dLJ/M3JIjPeNWLhLG665s/jqHrkM=;
	b=T0Y+YHy5+rDNlyl92xelvxUB0bpk/HdbzXBhcWiy4mdwL9PlUVOcS3TN5ddrLzHrugnBkz
	xGDzUiWgMmVRRMMpjK97tEoM/hA9uqL0FiLQT3BfjJReBfP9fNytKr09GsAmf+vLs6piv8
	ukPA07CUUotdIPO7M5kNRRe5KMayeiY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-1Rhk3uxrN5-zOkrtqKrWAQ-1; Thu,
 30 Oct 2025 10:24:43 -0400
X-MC-Unique: 1Rhk3uxrN5-zOkrtqKrWAQ-1
X-Mimecast-MFC-AGG-ID: 1Rhk3uxrN5-zOkrtqKrWAQ_1761834282
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6FBDC1955EA6;
	Thu, 30 Oct 2025 14:24:42 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.237])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EFC431955BE3;
	Thu, 30 Oct 2025 14:24:39 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.18-rc4
Date: Thu, 30 Oct 2025 15:24:15 +0100
Message-ID: <20251030142415.29023-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Linus!

The following changes since commit ab431bc39741e9d9bd3102688439e1864c857a74:

  Merge tag 'net-6.18-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-10-23 07:03:18 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.18-rc4

for you to fetch changes up to 51e5ad549c43b557c7da1e4d1a1dcf061b4a5f6c:

  net: sctp: fix KMSAN uninit-value in sctp_inq_pop (2025-10-30 11:21:05 +0100)

----------------------------------------------------------------
Including fixes from wireless, Bluetooth and netfilter.

Current release - regressions:

  - tcp: fix too slow tcp_rcvbuf_grow() action

  - bluetooth: fix corruption in h4_recv_buf() after cleanup

Previous releases - regressions:

  - mptcp: restore window probe

  - bluetooth:
    - fix connection cleanup with BIG with 2 or more BIS
    - fix crash in set_mesh_sync and set_mesh_complete

  - batman-adv: release references to inactive interfaces

  - nic: ice: fix usage of logical PF id

  - nic: sfc: fix potential memory leak in efx_mae_process_mport()

Previous releases - always broken:

  - devmem: refresh devmem TX dst in case of route invalidation

  - netfilter: add seqadj extension for natted connections

  - wifi:
    - iwlwifi: fix potential use after free in iwl_mld_remove_link()
    - brcmfmac: fix crash while sending action frames in standalone AP Mode

  - eth: mlx5e: cancel tls RX async resync request in error flows

  - eth: ixgbe: fix memory leak and use-after-free in ixgbe_recovery_probe()

  - eth: hibmcge: fix rx buf avl irq is not re-enabled in irq_handle issue

  - eth: cxgb4: fix potential use-after-free in ipsec callback

  - eth: nfp: fix memory leak in nfp_net_alloc()

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Abdun Nihaal (2):
      sfc: fix potential memory leak in efx_mae_process_mport()
      nfp: xsk: fix memory leak in nfp_net_alloc()

Aloka Dixit (1):
      wifi: mac80211: reset FILS discovery and unsol probe resp intervals

Andrii Melnychenko (1):
      netfilter: nft_ct: add seqadj extension for natted connections

Bagas Sanjaya (2):
      MAINTAINERS: mark ISDN subsystem as orphan
      Documentation: netconsole: Remove obsolete contact people

Bui Quang Minh (1):
      virtio-net: drop the multi-buffer XDP packet in zerocopy

Calvin Owens (1):
      Bluetooth: fix corruption in h4_recv_buf() after cleanup

Cen Zhang (1):
      Bluetooth: hci_sync: fix race in hci_cmd_sync_dequeue_once

Chris Lu (1):
      Bluetooth: btmtksdio: Add pmctrl handling for BT closed state during reset

Cosmin Ratiu (1):
      net/mlx5: Don't zero user_count when destroying FDB tables

Dan Carpenter (1):
      wifi: iwlwifi: fix potential use after free in iwl_mld_remove_link()

Dr. David Alan Gilbert (1):
      MAINTAINERS: wcn36xx: Add linux-wireless list

Emanuele Ghidoli (1):
      net: phy: dp83867: Disable EEE support as not implemented

Emmanuel Grumbach (1):
      wifi: nl80211: call kfree without a NULL check

Eric Dumazet (3):
      trace: tcp: add three metrics to trace_tcp_rcvbuf_grow()
      tcp: add newval parameter to tcp_rcvbuf_grow()
      tcp: fix too slow tcp_rcvbuf_grow() action

Fernando Fernandez Mancera (1):
      netfilter: nft_connlimit: fix possible data race on connection count

Florian Westphal (1):
      netfilter: nft_ct: enable labels for get case too

Frédéric Danis (1):
      Revert "Bluetooth: L2CAP: convert timeouts to secs_to_jiffies()"

Gokul Sivakumar (1):
      wifi: brcmfmac: fix crash while sending Action Frames in standalone AP Mode

Grzegorz Nitka (3):
      ice: fix lane number calculation
      ice: fix destination CGU for dual complex E825
      ice: fix usage of logical PF id

Gustavo Luiz Duarte (1):
      netconsole: Fix race condition in between reader and writer of userdata

Hangbin Liu (1):
      tools: ynl: avoid print_field when there is no reply

Ivan Vecera (1):
      dpll: zl3073x: Fix output pin registration

Jakub Kicinski (10):
      Merge tag 'wireless-2025-10-23' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge tag 'for-net-2025-10-24' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge tag 'batadv-net-pullrequest-20251024' of https://git.open-mesh.org/linux-merge
      Merge branch 'bug-fixes-for-the-hibmcge-ethernet-driver'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch 'tcp-fix-receive-autotune-again'
      Merge branch 'mptcp-various-rare-sending-issues'
      Merge tag 'nf-25-10-29' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf
      Merge branch 'tls-introduce-and-use-rx-async-resync-request-cancel-function'
      Merge branch 'net-stmmac-fixes-for-stmmac-tx-vlan-insert-and-est'

Jijie Shao (4):
      net: hns3: return error code when function fails
      net: hibmcge: fix rx buf avl irq is not re-enabled in irq_handle issue
      net: hibmcge: remove unnecessary check for np_link_fail in scenarios without phy.
      net: hibmcge: fix the inappropriate netif_device_detach()

Jinliang Wang (1):
      net: mctp: Fix tx queue stall

Johan Hovold (1):
      Bluetooth: rfcomm: fix modem control handling

Johannes Berg (3):
      Merge tag 'ath-current-20251006' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      wifi: mac80211: fix key tailroom accounting leak
      Merge tag 'iwlwifi-fixes-2025-10-19' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

Karthik M (1):
      wifi: ath12k: free skb during idr cleanup callback

Kiran K (1):
      Bluetooth: btintel_pcie: Fix event packet loss issue

Kohei Enju (5):
      ixgbe: fix memory leak and use-after-free in ixgbe_recovery_probe()
      igc: power up the PHY before the link test
      igb: use EOPNOTSUPP instead of ENOTSUPP in igb_get_sset_count()
      igc: use EOPNOTSUPP instead of ENOTSUPP in igc_ethtool_get_sset_count()
      ixgbe: use EOPNOTSUPP instead of ENOTSUPP in ixgbe_ptp_feature_enable()

Krzysztof Kozlowski (1):
      dt-bindings: net: sparx5: Narrow properly LAN969x register space windows

Lizhi Xu (1):
      usbnet: Prevents free active kevent

Loic Poulain (1):
      wifi: ath10k: Fix memory leak on unsupported WMI command

Luiz Augusto von Dentz (5):
      Bluetooth: ISO: Fix BIS connection dst_type handling
      Bluetooth: HCI: Fix tracking of advertisement set/instance 0x00
      Bluetooth: ISO: Fix another instance of dst_type handling
      Bluetooth: hci_conn: Fix connection cleanup with BIG with 2 or more BIS
      Bluetooth: hci_core: Fix tracking of periodic advertisement

Mark Pearson (1):
      wifi: ath11k: Add missing platform IDs for quirk table

Miaoqian Lin (1):
      net: usb: asix_devices: Check return value of usbnet_get_endpoints

Paolo Abeni (5):
      mptcp: fix subflow rcvbuf adjust
      mptcp: drop bogus optimization in __mptcp_check_push()
      mptcp: fix MSG_PEEK stream corruption
      mptcp: restore window probe
      mptcp: zero window probe mib

Pauli Virtanen (1):
      Bluetooth: MGMT: fix crash in set_mesh_sync and set_mesh_complete

Pavel Zhigulin (1):
      net: cxgb4/ch_ipsec: fix potential use-after-free in ch_ipsec_xfrm_add_state() callback

Petr Oros (3):
      tools: ynl: fix string attribute length to include null terminator
      dpll: spec: add missing module-name and clock-id to pin-get reply
      dpll: fix device-id-get and pin-id-get to return errors properly

Po-Hsu Lin (1):
      selftests: net: use BASH for bareudp testing

Rafał Miłecki (1):
      bcma: don't register devices disabled in OF

Rameshkumar Sundaram (1):
      wifi: ath11k: avoid bit operation on key flags

Ranganath V N (1):
      net: sctp: fix KMSAN uninit-value in sctp_inq_pop

Rohan G Thomas (3):
      net: stmmac: vlan: Disable 802.1AD tag insertion offload
      net: stmmac: Consider Tx VLAN offload tag length for maxSDU
      net: stmmac: est: Fix GCL bounds checks

Shahar Shitrit (3):
      net: tls: Change async resync helpers argument
      net: tls: Cancel RX async resync request on rcd_delta overflow
      net/mlx5e: kTLS, Cancel RX async resync request in error flows

Shivaji Kant (1):
      net: devmem: refresh devmem TX dst in case of route invalidation

Sven Eckelmann (1):
      batman-adv: Release references to inactive interfaces

Thanh Quan (1):
      net: phy: dp83869: fix STRAP_OPMODE bitmask

 CREDITS                                            |  4 ++
 .../bindings/net/microchip,sparx5-switch.yaml      |  4 +-
 Documentation/netlink/specs/dpll.yaml              |  2 +
 Documentation/networking/netconsole.rst            |  3 -
 MAINTAINERS                                        |  9 +--
 drivers/bcma/main.c                                |  6 ++
 drivers/bluetooth/bpa10x.c                         |  4 +-
 drivers/bluetooth/btintel_pcie.c                   | 11 +--
 drivers/bluetooth/btmtksdio.c                      | 12 ++++
 drivers/bluetooth/btmtkuart.c                      |  4 +-
 drivers/bluetooth/btnxpuart.c                      |  4 +-
 drivers/bluetooth/hci_ag6xx.c                      |  2 +-
 drivers/bluetooth/hci_aml.c                        |  2 +-
 drivers/bluetooth/hci_ath.c                        |  2 +-
 drivers/bluetooth/hci_bcm.c                        |  2 +-
 drivers/bluetooth/hci_h4.c                         |  6 +-
 drivers/bluetooth/hci_intel.c                      |  2 +-
 drivers/bluetooth/hci_ll.c                         |  2 +-
 drivers/bluetooth/hci_mrvl.c                       |  6 +-
 drivers/bluetooth/hci_nokia.c                      |  4 +-
 drivers/bluetooth/hci_qca.c                        |  2 +-
 drivers/bluetooth/hci_uart.h                       |  2 +-
 drivers/dpll/dpll_netlink.c                        | 36 +++++-----
 drivers/dpll/zl3073x/dpll.c                        |  2 +-
 .../chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c    |  7 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_common.h    |  1 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c   | 10 +--
 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c    |  3 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c   |  1 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c  |  1 -
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  3 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c    |  9 ++-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h    |  2 +-
 drivers/net/ethernet/intel/ice/ice_common.c        | 35 ++++++++-
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c     |  2 +-
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h       |  1 +
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |  2 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |  5 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c       |  2 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c | 41 +++++++++--
 .../mellanox/mlx5/core/en_accel/ktls_txrx.h        |  4 ++
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |  4 ++
 .../net/ethernet/mellanox/mlx5/core/esw/legacy.c   |  1 -
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |  1 -
 .../net/ethernet/netronome/nfp/nfp_net_common.c    |  6 +-
 drivers/net/ethernet/sfc/mae.c                     |  4 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 32 ++++-----
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |  4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c  |  2 +-
 drivers/net/mctp/mctp-usb.c                        |  8 ++-
 drivers/net/netconsole.c                           | 21 +++---
 drivers/net/phy/dp83867.c                          |  6 ++
 drivers/net/phy/dp83869.c                          |  4 +-
 drivers/net/usb/asix_devices.c                     | 12 +++-
 drivers/net/usb/usbnet.c                           |  2 +
 drivers/net/virtio_net.c                           | 11 ++-
 drivers/net/wireless/ath/ath10k/wmi.c              |  1 +
 drivers/net/wireless/ath/ath11k/core.c             | 54 ++++++++++++--
 drivers/net/wireless/ath/ath11k/mac.c              | 10 +--
 drivers/net/wireless/ath/ath12k/mac.c              | 34 ++++-----
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |  3 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.c | 28 +++-----
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.h |  3 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.c      |  5 +-
 include/net/bluetooth/hci.h                        |  1 +
 include/net/bluetooth/hci_core.h                   |  1 +
 include/net/bluetooth/l2cap.h                      |  4 +-
 include/net/bluetooth/mgmt.h                       |  2 +-
 include/net/tcp.h                                  |  2 +-
 include/net/tls.h                                  | 25 +++----
 include/trace/events/tcp.h                         |  9 +++
 net/batman-adv/originator.c                        | 14 +++-
 net/bluetooth/hci_conn.c                           |  7 ++
 net/bluetooth/hci_event.c                          | 11 ++-
 net/bluetooth/hci_sync.c                           | 21 +++---
 net/bluetooth/iso.c                                | 10 ++-
 net/bluetooth/l2cap_core.c                         |  4 +-
 net/bluetooth/mgmt.c                               | 26 ++++---
 net/bluetooth/rfcomm/tty.c                         | 26 +++----
 net/core/devmem.c                                  | 27 ++++++-
 net/ipv4/tcp_input.c                               | 21 ++++--
 net/mac80211/cfg.c                                 |  3 +
 net/mac80211/key.c                                 | 11 ++-
 net/mptcp/mib.c                                    |  1 +
 net/mptcp/mib.h                                    |  1 +
 net/mptcp/protocol.c                               | 83 ++++++++++++++--------
 net/mptcp/protocol.h                               |  2 +-
 net/netfilter/nft_connlimit.c                      |  2 +-
 net/netfilter/nft_ct.c                             | 30 +++++++-
 net/sctp/input.c                                   |  2 +-
 net/tls/tls_device.c                               |  4 +-
 net/wireless/nl80211.c                             |  3 +-
 tools/net/ynl/lib/ynl-priv.h                       |  4 +-
 tools/net/ynl/pyynl/ethtool.py                     |  3 +
 tools/testing/selftests/net/bareudp.sh             |  2 +-
 96 files changed, 597 insertions(+), 285 deletions(-)


