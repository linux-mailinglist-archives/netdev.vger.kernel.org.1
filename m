Return-Path: <netdev+bounces-123277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 322669645CF
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2B11F26006
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 13:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18D21A00C5;
	Thu, 29 Aug 2024 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BANVtfnB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13CD1946CA
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 13:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724936927; cv=none; b=UJwlMi7zJcf/Mn4q2vnca7qbVeK2EMluL7+vvjHSAGDeeVEA+SwU6RJuBFdwqebGD9tScWtGWNhSe323dm75imuAxZF5h1sVywqmXd1IxHq8dmsBDooEDMG1Caa1byhf46IX++aK/Ekfdvr8WYLN3BDPHz+QSakSTJaYhO5rsRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724936927; c=relaxed/simple;
	bh=8JXc3XaGArnrHvPJg4CaETkfU/rLBCqunZTKsdGAR0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OdmTLOKfhfNAUpWzBgv8vtqsI+1IWApCboori0UBP2T5C7VNsPY0fo16Bm6JVAGr1moW1enCasnO8X3dXysJYQCzx+SfJEDa7jUVAbZjdGGl3EL/1X3jmkgJhv6wPufHaZPuaDEuswRJ+tWk3irUeX/f5cEYlQn+kIOZ1aGuiew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BANVtfnB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724936924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yn4Bf159yToNngIfr56G5t7vuDV4EU9C00YNMjgf4xY=;
	b=BANVtfnBINFN+4gPj7sNhhQ7NtEJvlgqUdYbL3BijaDklHx6bmhGaYuWS23aKW8N5lP05y
	LvD7Sf4BbLutxub+DCqskF+/qeOCo54AJAi2mdPd+fmESQ7kkmflUKlGSSnqxlJACPXzdU
	Mf0Qb67dv7PoaaRP1XygTABhmZLPHfU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-hOS4RTxGPIu9I0KuObk1Dw-1; Thu,
 29 Aug 2024 09:08:41 -0400
X-MC-Unique: hOS4RTxGPIu9I0KuObk1Dw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CF5C1955BFC;
	Thu, 29 Aug 2024 13:08:39 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.217])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4D4361955F1B;
	Thu, 29 Aug 2024 13:08:36 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.11-rc6
Date: Thu, 29 Aug 2024 15:08:29 +0200
Message-ID: <20240829130829.39148-1-pabeni@redhat.com>
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

The following changes since commit aa0743a229366e8c1963f1b72a1c974a9d15f08f:

  Merge tag 'net-6.11-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-08-23 07:47:01 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.11-rc6

for you to fetch changes up to febccb39255f9df35527b88c953b2e0deae50e53:

  nfc: pn533: Add poll mod list filling check (2024-08-29 12:08:44 +0200)

----------------------------------------------------------------
Including fixes from bluetooth, wireless and netfilter.

No known outstanding regressions.

Current release - regressions:

  - wifi: iwlwifi: fix hibernation

  - eth: ionic: prevent tx_timeout due to frequent doorbell ringing

Previous releases - regressions:

  - sched: fix sch_fq incorrect behavior for small weights

  - wifi:
    - iwlwifi: take the mutex before running link selection
    - wfx: repair open network AP mode

  - netfilter: restore IP sanity checks for netdev/egress

  - tcp: fix forever orphan socket caused by tcp_abort

  - mptcp: close subflow when receiving TCP+FIN

  - bluetooth: fix random crash seen while removing btnxpuart driver

Previous releases - always broken:

  - mptcp: more fixes for the in-kernel PM

  - eth: bonding: change ipsec_lock from spin lock to mutex

  - eth: mana: fix race of mana_hwc_post_rx_wqe and new hwc response

Misc:

  - documentation: drop special comment style for net code

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Aleksandr Mishin (1):
      nfc: pn533: Add poll mod list filling check

Alexander Sverdlin (1):
      wifi: wfx: repair open network AP mode

Anjaneyulu (1):
      wifi: iwlwifi: fw: fix wgds rev 3 exact size

Avraham Stern (1):
      wifi: iwlwifi: mvm: allow 6 GHz channels in MLO scan

Benjamin Berg (1):
      wifi: iwlwifi: lower message level for FW buffer destination

Brett Creeley (1):
      ionic: Prevent tx_timeout due to frequent doorbell ringing

Cong Wang (1):
      gtp: fix a potential NULL pointer dereference

Daniel Gabay (3):
      wifi: mac80211: fix beacon SSID mismatch handling
      wifi: iwlwifi: mvm: fix iwl_mvm_scan_fits() calculation
      wifi: iwlwifi: mvm: fix iwl_mvm_max_scan_ie_fw_cmd_room()

Dmitry Antipov (1):
      wifi: mac80211: free skb on error path in ieee80211_beacon_get_ap()

Emmanuel Grumbach (5):
      wifi: iwlwifi: mvm: fix hibernation
      wifi: iwlwifi: mvm: take the mutex before running link selection
      wifi: iwlwifi: mvm: pause TCM when the firmware is stopped
      wifi: iwlwifi: mvm: don't wait for tx queues if firmware is dead
      wifi: iwlwifi: clear trans->state earlier upon error

Eric Dumazet (3):
      pktgen: use cpus_read_lock() in pg_net_init()
      net_sched: sch_fq: fix incorrect behavior for small weights
      net: busy-poll: use ktime_get_ns() instead of local_clock()

Haiyang Zhang (1):
      net: mana: Fix race of mana_hwc_post_rx_wqe and new hwc response

Jacky Chou (1):
      net: ftgmac100: Ensure tx descriptor updates are visible

Jakub Kicinski (4):
      Merge tag 'for-net-2024-08-23' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge branch 'fixes-for-ipsec-over-bonding'
      Merge branch 'mptcp-close-subflow-when-receiving-tcp-fin-and-misc'
      Merge tag 'wireless-2024-08-28' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

Jamie Bainbridge (1):
      ethtool: check device is present when getting link settings

Jianbo Liu (3):
      bonding: implement xdo_dev_state_free and call it after deletion
      bonding: extract the use of real_device into local variable
      bonding: change ipsec_lock from spin lock to mutex

Johannes Berg (1):
      net: drop special comment style

Kiran K (1):
      Bluetooth: btintel: Allow configuring drive strength of BRI

Luiz Augusto von Dentz (1):
      Bluetooth: hci_core: Fix not handling hibernation actions

MD Danish Anwar (1):
      net: ti: icssg-prueth: Fix 10M Link issue on AM64x

Matthieu Baerts (NGI0) (19):
      mptcp: close subflow when receiving TCP+FIN
      selftests: mptcp: join: cannot rm sf if closed
      mptcp: sched: check both backup in retrans
      mptcp: pr_debug: add missing \n at the end
      mptcp: pm: reuse ID 0 after delete and re-add
      mptcp: pm: fix RM_ADDR ID for the initial subflow
      selftests: mptcp: join: check removing ID 0 endpoint
      mptcp: pm: send ACK on an active subflow
      mptcp: pm: skip connecting to already established sf
      mptcp: pm: reset MPC endp ID when re-added
      selftests: mptcp: join: check re-adding init endp with != id
      selftests: mptcp: join: no extra msg if no counter
      mptcp: pm: do not remove already closed subflows
      mptcp: pm: fix ID 0 endp usage after multiple re-creations
      selftests: mptcp: join: check re-re-adding ID 0 endp
      mptcp: avoid duplicated SUB_CLOSED events
      selftests: mptcp: join: validate event numbers
      mptcp: pm: ADD_ADDR 0 is not a new address
      selftests: mptcp: join: check re-re-adding ID 0 signal

Neeraj Sanjay Kale (1):
      Bluetooth: btnxpuart: Fix random crash seen while removing driver

Ondrej Mosnacek (1):
      sctp: fix association labeling in the duplicate COOKIE-ECHO case

Pablo Neira Ayuso (2):
      netfilter: nf_tables: restore IP sanity checks for netdev/egress
      netfilter: nf_tables_ipv6: consider network offset in netdev/egress validation

Paolo Abeni (2):
      Merge branch 'mptcp-more-fixes-for-the-in-kernel-pm'
      Merge tag 'nf-24-08-28' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Petr Machata (2):
      selftests: forwarding: no_forwarding: Down ports on cleanup
      selftests: forwarding: local_termination: Down ports on cleanup

Sascha Hauer (1):
      wifi: mwifiex: duplicate static structs used in driver instances

Sriram Yagnaraman (1):
      mailmap: update entry for Sriram Yagnaraman

Xueming Feng (1):
      tcp: fix forever orphan socket caused by tcp_abort

 .mailmap                                           |   1 +
 Documentation/process/coding-style.rst             |  12 --
 Documentation/process/maintainer-netdev.rst        |  17 ---
 drivers/bluetooth/btintel.c                        | 124 ++++++++++++++++
 drivers/bluetooth/btnxpuart.c                      |  20 ++-
 drivers/net/bonding/bond_main.c                    | 159 +++++++++++++-------
 drivers/net/ethernet/faraday/ftgmac100.c           |  26 +++-
 drivers/net/ethernet/microsoft/mana/hw_channel.c   |  62 ++++----
 drivers/net/ethernet/pensando/ionic/ionic_dev.h    |   2 +-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |   2 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c       |   1 +
 drivers/net/gtp.c                                  |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |  13 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |   2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h   |  12 ++
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  10 ++
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |  21 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |  42 ++++--
 .../wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c   |   3 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |  41 +++++-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |  32 +++-
 drivers/net/wireless/silabs/wfx/sta.c              |   5 +-
 drivers/nfc/pn533/pn533.c                          |   5 +
 include/net/bonding.h                              |   2 +-
 include/net/busy_poll.h                            |   2 +-
 include/net/netfilter/nf_tables_ipv4.h             |  10 +-
 include/net/netfilter/nf_tables_ipv6.h             |   5 +-
 net/bluetooth/hci_core.c                           |  10 +-
 net/core/net-sysfs.c                               |   2 +-
 net/core/pktgen.c                                  |   4 +-
 net/ethtool/ioctl.c                                |   3 +
 net/ipv4/tcp.c                                     |  18 ++-
 net/mac80211/mlme.c                                |   2 +-
 net/mac80211/tx.c                                  |   4 +-
 net/mptcp/fastopen.c                               |   4 +-
 net/mptcp/options.c                                |  50 +++----
 net/mptcp/pm.c                                     |  32 ++--
 net/mptcp/pm_netlink.c                             | 107 +++++++++-----
 net/mptcp/protocol.c                               |  65 ++++----
 net/mptcp/protocol.h                               |   9 +-
 net/mptcp/sched.c                                  |   4 +-
 net/mptcp/sockopt.c                                |   4 +-
 net/mptcp/subflow.c                                |  56 +++----
 net/sched/sch_fq.c                                 |   4 +-
 net/sctp/sm_statefuns.c                            |  22 ++-
 scripts/checkpatch.pl                              |  10 --
 .../selftests/net/forwarding/local_termination.sh  |   4 +
 .../selftests/net/forwarding/no_forwarding.sh      |   3 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 164 +++++++++++++++++----
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |   4 +
 52 files changed, 864 insertions(+), 365 deletions(-)


