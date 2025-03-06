Return-Path: <netdev+bounces-172442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FBFA54A96
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 13:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC62A3A4D4D
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 12:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEDE20B20A;
	Thu,  6 Mar 2025 12:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3eST6MG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA43D20A5C6
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 12:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741263840; cv=none; b=I1mdWefrjJ2+lBUkKPmvKsuoq/Ih8q3lzQS41LohbOsKNAy9G6Qmt+wJpSyIy8rLbHQhrKRBpy7DJphOzmlQHywOytJpVs+8/BDzTRmMFJxyN8QA9PIDqK2LaHvkO0sMONWkMmcCybpGEvrdx+UUaZb3Ymsa6HBL2v+AhHnVp7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741263840; c=relaxed/simple;
	bh=ym2UI+/DVc+FX4NViTGlLJydqmh8h7xVuxY4ut1K9G8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b7h2oM7t+HD7VtHsEpP1OUUnzsjSGM8YetCX9myaRBEaVNombCqzpIFyJNXQUH0oMuL6r/pCTYEZ1+eSr+GyGvD36sm0GrIYHRHhufXceHTVPyMIuYD/WAI1B4at9SlCm6JCK0999OKCDIlSdM90lfS02qEBrSi+I5fMD/AE3r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S3eST6MG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741263836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a9+U3W7blKCSVJ/P43dTMQCw4/GD/uUym29Go1Jn5IQ=;
	b=S3eST6MGj3APMNT+RMnFXiKeZbiEWodtXxcnsl2m22fIM4dsfN4n6Qjs73Z3DPQJoIcMf5
	U6s9tdPddFn+3VBM0Jn9ZH3tr3wjRBCJnFRotdGAPz0vN7Q4MBVRxOJ+0Zkqll9VBSrrvT
	JbUhgOGlv72nyNXMc2tSvfrTHSfDYXQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-Ark_q4_pP72LLtzdyo5zSw-1; Thu,
 06 Mar 2025 07:23:53 -0500
X-MC-Unique: Ark_q4_pP72LLtzdyo5zSw-1
X-Mimecast-MFC-AGG-ID: Ark_q4_pP72LLtzdyo5zSw_1741263832
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B47C18009FC;
	Thu,  6 Mar 2025 12:23:52 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.236])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 514F71955DCE;
	Thu,  6 Mar 2025 12:23:49 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.14-rc6
Date: Thu,  6 Mar 2025 13:23:40 +0100
Message-ID: <20250306122340.27248-1-pabeni@redhat.com>
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

The following changes since commit 1e15510b71c99c6e49134d756df91069f7d18141:

  Merge tag 'net-6.14-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-02-27 09:32:42 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.14-rc6

for you to fetch changes up to 5da15a9c11c1c47ef573e6805b60a7d8a1687a2a:

  net: ipv6: fix missing dst ref drop in ila lwtunnel (2025-03-06 11:08:45 +0100)

----------------------------------------------------------------
We have been notified of a TLS regression that will be addressed
via the MM tree.

Including fixes from bluetooth and wireless.

Current release - new code bugs:

  - wifi: nl80211: disable multi-link reconfiguration

Previous releases - regressions:

  - gso: fix ownership in __udp_gso_segment

  - wifi: iwlwifi:
    - fix A-MSDU TSO preparation
    - free pages allocated when failing to build A-MSDU

  - ipv6: fix dst ref loop in ila lwtunnel

  - mptcp: fix 'scheduling while atomic' in mptcp_pm_nl_append_new_local_addr

  - bluetooth: add check for mgmt_alloc_skb() in mgmt_device_connected()

  - ethtool: allow NULL nlattrs when getting a phy_device

  - eth: be2net: fix sleeping while atomic bugs in be_ndo_bridge_getlink

Previous releases - always broken:

  - core: support TCP GSO case for a few missing flags

  - wifi: mac80211:
    - fix vendor-specific inheritance
    - cleanup sta TXQs on flush

  - llc: do not use skb_get() before dev_queue_xmit()

  - eth: ipa: nable checksum for IPA_ENDPOINT_AP_MODEM_{RX,TX} for v4.7

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alexander Wetzel (3):
      wifi: mac80211: Cleanup sta TXQs on flush
      wifi: mac80211: remove debugfs dir for virtual monitor
      wifi: mac80211: Fix sparse warning for monitor_sdata

Antoine Tenart (1):
      net: gso: fix ownership in __udp_gso_segment

Antonio Quartulli (1):
      mailmap: remove unwanted entry for Antonio Quartulli

Emmanuel Grumbach (3):
      wifi: iwlwifi: mvm: don't dump the firmware state upon RFKILL while suspend
      wifi: iwlwifi: mvm: don't try to talk to a dead firmware
      wifi: iwlwifi: mvm: use the right version of the rate API

Eric Dumazet (1):
      llc: do not use skb_get() before dev_queue_xmit()

Haoxiang Li (2):
      Bluetooth: Add check for mgmt_alloc_skb() in mgmt_remote_name()
      Bluetooth: Add check for mgmt_alloc_skb() in mgmt_device_connected()

Ilan Peer (2):
      wifi: iwlwifi: Free pages allocated when failing to build A-MSDU
      wifi: iwlwifi: Fix A-MSDU TSO preparation

Jakub Kicinski (4):
      Merge tag 'for-net-2025-02-27' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      net: dsa: rtl8366rb: don't prompt users for LED control
      Merge tag 'wireless-2025-03-04' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge branch 'fixes-for-ipa-v4-7'

Jason Xing (1):
      net-timestamp: support TCP GSO case for a few missing flags

Jiayuan Chen (1):
      ppp: Fix KMSAN uninit-value warning with bpf

Johannes Berg (6):
      wifi: iwlwifi: fw: allocate chained SG tables for dump
      wifi: iwlwifi: mvm: clean up ROC on failure
      wifi: iwlwifi: limit printed string from FW file
      wifi: mac80211: fix MLE non-inheritance parsing
      wifi: mac80211: fix vendor-specific inheritance
      wifi: nl80211: disable multi-link reconfiguration

Justin Iurman (2):
      net: ipv6: fix dst ref loop in ila lwtunnel
      net: ipv6: fix missing dst ref drop in ila lwtunnel

Krister Johansen (1):
      mptcp: fix 'scheduling while atomic' in mptcp_pm_nl_append_new_local_addr

Lorenzo Bianconi (1):
      net: dsa: mt7530: Fix traffic flooding for MMIO devices

Luca Weiss (3):
      net: ipa: Fix v4.7 resource group names
      net: ipa: Fix QSB data for v4.7
      net: ipa: Enable checksum for IPA_ENDPOINT_AP_MODEM_{RX,TX} for v4.7

Matt Johnston (1):
      mctp i3c: handle NULL header address

Matthias Proske (1):
      wifi: brcmfmac: keep power during suspend if board requires it

Maxime Chevallier (1):
      net: ethtool: netlink: Allow NULL nlattrs when getting a phy_device

Miri Korenblit (1):
      wifi: iwlwifi: fw: avoid using an uninitialized variable

Nikita Zhandarovich (1):
      wifi: cfg80211: regulatory: improve invalid hints checking

Nikolay Aleksandrov (1):
      be2net: fix sleeping while atomic bugs in be_ndo_bridge_getlink

Oscar Maes (1):
      vlan: enforce underlying device type

Peiyang Wang (1):
      net: hns3: make sure ptp clock is unregister and freed if hclge_ptp_get_cycle returns an error

Philipp Stanner (1):
      stmmac: loongson: Pass correct arg to PCI function

Salah Triki (1):
      bluetooth: btusb: Initialize .owner field of force_poll_sync_fops

Vitaliy Shevtsov (2):
      wifi: nl80211: reject cooked mode if it is set along with other flags
      caif_virtio: fix wrong pointer check in cfv_probe()

 .mailmap                                           |   1 -
 drivers/bluetooth/btusb.c                          |   1 +
 drivers/net/caif/caif_virtio.c                     |   2 +-
 drivers/net/dsa/mt7530.c                           |   8 +-
 drivers/net/dsa/realtek/Kconfig                    |   2 +-
 drivers/net/ethernet/emulex/benet/be.h             |   2 +-
 drivers/net/ethernet/emulex/benet/be_cmds.c        | 197 ++++++++++-----------
 drivers/net/ethernet/emulex/benet/be_main.c        |   2 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c |   2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |   6 +-
 drivers/net/ipa/data/ipa_data-v4.7.c               |  18 +-
 drivers/net/mctp/mctp-i3c.c                        |   3 +
 drivers/net/ppp/ppp_generic.c                      |  28 ++-
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |  20 ++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |  86 ++++++---
 drivers/net/wireless/intel/iwlwifi/fw/dump.c       |   3 +
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  77 +++++---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |   7 +
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |   8 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |   2 +
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h |   5 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c  |   6 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       |  20 ++-
 net/8021q/vlan.c                                   |   3 +-
 net/bluetooth/mgmt.c                               |   5 +
 net/ethtool/cabletest.c                            |   8 +-
 net/ethtool/linkstate.c                            |   2 +-
 net/ethtool/netlink.c                              |   6 +-
 net/ethtool/netlink.h                              |   5 +-
 net/ethtool/phy.c                                  |   2 +-
 net/ethtool/plca.c                                 |   6 +-
 net/ethtool/pse-pd.c                               |   4 +-
 net/ethtool/stats.c                                |   2 +-
 net/ethtool/strset.c                               |   2 +-
 net/ipv4/tcp_offload.c                             |  11 +-
 net/ipv4/udp_offload.c                             |   8 +-
 net/ipv6/ila/ila_lwt.c                             |   4 +-
 net/llc/llc_s_ac.c                                 |  49 ++---
 net/mac80211/driver-ops.c                          |  10 +-
 net/mac80211/iface.c                               |  11 +-
 net/mac80211/mlme.c                                |   1 +
 net/mac80211/parse.c                               | 135 +++++++++-----
 net/mac80211/util.c                                |   5 +-
 net/mptcp/pm_netlink.c                             |  18 +-
 net/wireless/nl80211.c                             |   7 +-
 net/wireless/reg.c                                 |   3 +-
 47 files changed, 499 insertions(+), 316 deletions(-)


