Return-Path: <netdev+bounces-261397-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEXJHr9ooGm+jQQAu9opvQ
	(envelope-from <netdev+bounces-261397-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:37:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 886111A8D68
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 16:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E48753114DDF
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 15:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F7D3D904D;
	Thu, 26 Feb 2026 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U35PRSrX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A712475D0
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118974; cv=none; b=NVD1/QjtdSGBM/mggTHAUBiR+OXK0U/aI8572+1Njsf4mQXeirWFiNwFNiqRyGpoMYlUIJC2JaMuepWQz+e/JZrv0HsLlzwLa9lxKrtUUzRpaufMEq8Tl1dXKRamf6kb6iVyT8EIZK/Dj1tgj3J/xURuWzsN/H+EgLCIWuOL7DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118974; c=relaxed/simple;
	bh=xPZFoULc2JwbaamFciNGqAmiOhKbnuUTs2vTk+Vqc70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BgJfv8M53aH1OPM95xF7nbzOpGMWFbHgR4PHjFJOchniEVwrSnP/UydVZSV/WSI82z0wpDnlvFf9D+gz216Q3hTk5g2rCh9vd7re0mgkCAKwLCuCoNIBEriASyTfg4HPRJLvAQtYzfQ98g8IFes42KLIopSAaAraqnU5yFAcefI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U35PRSrX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772118971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RtEl8sRnm/HrySb1Vc2xq9e0d9E2C+eHr3d6BxIgR4M=;
	b=U35PRSrXFQ9rf776jGnwymJb/5GSe/9Z4CxwsVNnDcPq7ozTeNtpZPWyHDJPpKJ8puasHz
	0BUaqRWIeT8rOEWAjCUrmCZi01o3rzABQZBvAW4m07XprEZufHXF/9Z53HQShQAlTaofWu
	AD7bAbQbnwWxnmKHC7rrWWajYZbolHQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-kGZZSJOPOxaRbnKLnURflQ-1; Thu,
 26 Feb 2026 10:16:07 -0500
X-MC-Unique: kGZZSJOPOxaRbnKLnURflQ-1
X-Mimecast-MFC-AGG-ID: kGZZSJOPOxaRbnKLnURflQ_1772118966
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9BC131800A3B;
	Thu, 26 Feb 2026 15:16:04 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.206])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BDC64180058C;
	Thu, 26 Feb 2026 15:16:02 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v7.0-rc2
Date: Thu, 26 Feb 2026 16:15:29 +0100
Message-ID: <20260226151529.259438-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261397-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 886111A8D68
X-Rspamd-Action: no action

Hi Linus!

The following changes since commit 8bf22c33e7a172fbc72464f4cc484d23a6b412ba:

  Merge tag 'net-7.0-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-02-19 10:39:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-7.0-rc2

for you to fetch changes up to baed0d9ba91d4f390da12d5039128ee897253d60:

  netfilter: nf_conntrack_h323: fix OOB read in decode_choice() (2026-02-26 12:50:42 +0100)

----------------------------------------------------------------
Including fixes from IPsec, Bluetooth and netfilter

Current release - regressions:

  - wifi: fix dev_alloc_name() return value check

  - rds: fix recursive lock in rds_tcp_conn_slots_available

Current release - new code bugs:

  - vsock: lock down child_ns_mode as write-once

Previous releases - regressions:

  - core:
    - do not pass flow_id to set_rps_cpu()
    - consume xmit errors of GSO frames

  - netconsole: avoid OOB reads, msg is not nul-terminated

  - netfilter: h323: fix OOB read in decode_choice()

  - tcp: re-enable acceptance of FIN packets when RWIN is 0

  - udplite: fix null-ptr-deref in __udp_enqueue_schedule_skb().

  - wifi: brcmfmac: fix potential kernel oops when probe fails

  - phy: register phy led_triggers during probe to avoid AB-BA deadlock

  - eth: bnxt_en: fix deleting of Ntuple filters

  - eth: wan: farsync: fix use-after-free bugs caused by unfinished tasklets

  - eth: xscale: check for PTP support properly

Previous releases - always broken:

  - tcp: fix potential race in tcp_v6_syn_recv_sock()

  - kcm: fix zero-frag skb in frag_list on partial sendmsg error

  - xfrm:
    - fix race condition in espintcp_close()
    - always flush state and policy upon NETDEV_UNREGISTER event

  - bluetooth:
    - purge error queues in socket destructors
    - fix response to L2CAP_ECRED_CONN_REQ

  - eth: mlx5:
    - fix circular locking dependency in dump
    - fix "scheduling while atomic" in IPsec MAC address query

  - eth: gve: fix incorrect buffer cleanup for QPL

  - eth: team: avoid NETDEV_CHANGEMTU event when unregistering slave

  - eth: usb: validate USB endpoints

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Andrew Lunn (1):
      net: phy: register phy led_triggers during probe to avoid AB-BA deadlock

Ankit Garg (1):
      gve: fix incorrect buffer cleanup in gve_tx_clean_pending_packets for QPL

Ariel Silver (1):
      wifi: mac80211: bounds-check link_id in ieee80211_ml_reconfiguration

Bobby Eshleman (3):
      selftests/vsock: change tests to respect write-once child ns mode
      vsock: lock down child_ns_mode as write-once
      vsock: document write-once behavior of the child_ns_mode sysctl

Chen-Yu Tsai (1):
      wifi: mwifiex: Fix dev_alloc_name() return value check

Daniel Hodges (1):
      wifi: libertas: fix use-after-free in lbs_free_adapter()

Daniil Dulov (1):
      wifi: cfg80211: cancel rfkill_block work in wiphy_unregister()

Dipayaan Roy (1):
      net: mana: Fix double destroy_workqueue on service rescan PCI path

Dmitry Torokhov (1):
      net: phy: qcom: qca807x: normalize return value of gpio_get

Duoming Zhou (1):
      net: wan: farsync: Fix use-after-free bugs caused by unfinished tasklets

Eric Dumazet (3):
      tcp: fix potential race in tcp_v6_syn_recv_sock()
      psp: use sk->sk_hash in psp_write_headers()
      net: do not pass flow_id to set_rps_cpu()

Felix Gu (1):
      dpll: zl3073x: Remove redundant cleanup in devm_dpll_init()

Fernando Fernandez Mancera (1):
      net/rds: fix recursive lock in rds_tcp_conn_slots_available

Greg Kroah-Hartman (5):
      nfc: pn533: properly drop the usb interface reference on disconnect
      net: usb: pegasus: validate USB endpoints
      net: usb: kalmia: validate USB endpoints
      net: usb: kaweth: validate USB endpoints
      vsock: Use container_of() to get net namespace in sysctl handlers

Heitor Alves de Siqueira (1):
      Bluetooth: purge error queues in socket destructors

Hyunwoo Kim (2):
      espintcp: Fix race condition in espintcp_close()
      tls: Fix race condition in tls_sw_cancel_work_tx()

Ido Schimmel (1):
      selftests: team: Add a reference count leak test

Ivan Vecera (1):
      dpll: zl3073x: fix REF_PHASE_OFFSET_COMP register width for some chip IDs

Jakub Kicinski (9):
      Merge tag 'ipsec-2026-02-20' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec
      Merge branch 'bnxt_en-fix-rss-context-and-ntuple-filter-issues'
      MAINTAINERS: include all of framer under pef2256
      netconsole: avoid OOB reads, msg is not nul-terminated
      Merge branch 'tcp-re-enable-acceptance-of-fin-packets-when-rwin-is-0'
      Merge branch 'team-fix-reference-count-leak-when-changing-port-netns'
      Merge tag 'wireless-2026-02-25' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge branch 'mlx5-misc-fixes-2026-02-24'
      net: consume xmit errors of GSO frames

Jianbo Liu (1):
      net/mlx5e: Fix "scheduling while atomic" in IPsec MAC address query

Jiayuan Chen (2):
      xfrm6: fix uninitialized saddr in xfrm6_get_saddr()
      kcm: fix zero-frag skb in frag_list on partial sendmsg error

Jinwang Li (1):
      Bluetooth: hci_qca: Cleanup on all setup failures

Johannes Berg (2):
      wifi: cfg80211: wext: fix IGTK key ID off-by-one
      wifi: radiotap: reject radiotap with unknown bits

Junrui Luo (1):
      dpaa2-switch: validate num_ifs to prevent out-of-bounds write

Kuniyuki Iwashima (1):
      udplite: Fix null-ptr-deref in __udp_enqueue_schedule_skb().

Leon Romanovsky (1):
      xfrm: skip templates check for packet offload tunnel mode

Linus Walleij (1):
      net: ethernet: xscale: Check for PTP support properly

Luiz Augusto von Dentz (5):
      Bluetooth: L2CAP: Fix invalid response to L2CAP_ECRED_RECONF_REQ
      Bluetooth: L2CAP: Fix result of L2CAP_ECRED_CONN_RSP when MTU is too short
      Bluetooth: L2CAP: Fix response to L2CAP_ECRED_CONN_REQ
      Bluetooth: L2CAP: Fix not checking output MTU is acceptable on L2CAP_ECRED_CONN_REQ
      Bluetooth: L2CAP: Fix missing key size check for L2CAP_LE_CONN_REQ

Marek Szyprowski (1):
      wifi: brcmfmac: Fix potential kernel oops when probe fails

Mariusz Skamra (1):
      Bluetooth: Fix CIS host feature condition

Martin Pålsson (1):
      net: usb: lan78xx: scan all MDIO addresses on LAN7801

Mohd Ayaan Anwar (1):
      MAINTAINERS: Update maintainer entry for QUALCOMM ETHQOS ETHERNET DRIVER

Paolo Abeni (2):
      Merge tag 'for-net-2026-02-23' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
      Merge branch 'vsock-add-write-once-semantics-to-child_ns_mode'

Pavan Chebbi (3):
      bnxt_en: Fix RSS context delete logic
      bnxt_en: Fix deleting of Ntuple filters
      selftests: drv-net: rss_ctx: test RSS contexts persist after ifdown/up

Ralf Lici (1):
      ovpn: tcp - fix packet extraction from stream

Ramanathan Choodamani (1):
      wifi: mac80211: set default WMM parameters on all links

Russell King (Oracle) (1):
      net: stmmac: fix timestamping configuration after suspend/resume

Satish Kharat (1):
      MAINTAINERS: update enic and usnic maintainers

Sebastian Andrzej Siewior (1):
      net: Drop the lock in skb_may_tx_timestamp()

Shay Drory (4):
      net/mlx5: DR, Fix circular locking dependency in dump
      net/mlx5: LAG, disable MPESW in lag_disable_change()
      net/mlx5: E-switch, Clear legacy flag when moving to switchdev
      net/mlx5: Fix missing devlink lock in SRIOV enable error path

Shyam Sundar S K (1):
      MAINTAINERS: Update AMD XGBE driver maintainers

Simon Baatz (2):
      tcp: re-enable acceptance of FIN packets when RWIN is 0
      selftests/net: packetdrill: Verify acceptance of FIN packets when RWIN is 0

Tetsuo Handa (2):
      xfrm: always flush state and policy upon NETDEV_UNREGISTER event
      team: avoid NETDEV_CHANGEMTU event when unregistering slave

Tung Nguyen (1):
      tipc: fix duplicate publication key in tipc_service_insert_publ()

Vahagn Vardanian (2):
      wifi: mac80211: fix NULL pointer dereference in mesh_rx_csa_frame()
      netfilter: nf_conntrack_h323: fix OOB read in decode_choice()

Vladimir Oltean (1):
      net: dsa: sja1105: protect link replay helpers against NULL phylink instance

Ziyi Guo (2):
      net: usb: kaweth: remove TX queue manipulation in kaweth_set_rx_mode
      net: usb: pegasus: enable basic endpoint checking

 Documentation/admin-guide/sysctl/net.rst           |   3 +
 MAINTAINERS                                        |  10 +--
 drivers/bluetooth/hci_qca.c                        |  24 ++---
 drivers/dpll/zl3073x/core.c                        |   7 +-
 drivers/dpll/zl3073x/core.h                        |  28 ++++++
 drivers/dpll/zl3073x/dpll.c                        |   7 +-
 drivers/dpll/zl3073x/ref.c                         |  25 ++++--
 drivers/dpll/zl3073x/regs.h                        |   1 +
 drivers/net/dsa/sja1105/sja1105_main.c             |   9 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  13 +--
 .../net/ethernet/freescale/dpaa2/dpaa2-switch.c    |   7 ++
 drivers/net/ethernet/google/gve/gve_tx_dqo.c       |  56 ++++++------
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |   3 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |   8 +-
 .../net/ethernet/mellanox/mlx5/core/lag/mpesw.c    |   8 +-
 .../net/ethernet/mellanox/mlx5/core/lag/mpesw.h    |   5 ++
 drivers/net/ethernet/mellanox/mlx5/core/sriov.c    |   2 +
 .../mellanox/mlx5/core/steering/sws/dr_dbg.c       |   4 +-
 drivers/net/ethernet/microsoft/mana/gdma_main.c    |   5 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |   4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   1 +
 drivers/net/ethernet/xscale/ixp4xx_eth.c           |   5 +-
 drivers/net/ethernet/xscale/ptp_ixp46x.c           |   3 +
 drivers/net/netconsole.c                           |   3 +-
 drivers/net/ovpn/tcp.c                             |  53 +++++++----
 drivers/net/phy/phy_device.c                       |  25 ++++--
 drivers/net/phy/qcom/qca807x.c                     |   2 +-
 drivers/net/team/team_core.c                       |  26 ++++--
 drivers/net/usb/kalmia.c                           |   7 ++
 drivers/net/usb/kaweth.c                           |  15 +++-
 drivers/net/usb/lan78xx.c                          |   2 -
 drivers/net/usb/pegasus.c                          |  48 ++++++++--
 drivers/net/wan/farsync.c                          |   2 +
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |   7 +-
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |   7 +-
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.h    |   2 +-
 drivers/net/wireless/marvell/libertas/main.c       |   4 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |   2 +-
 drivers/nfc/pn533/usb.c                            |   1 +
 include/net/af_vsock.h                             |  13 ++-
 include/net/bluetooth/l2cap.h                      |   8 +-
 include/net/inet_connection_sock.h                 |   4 +-
 include/net/netns/vsock.h                          |   3 +
 include/net/sock.h                                 |   2 +-
 include/net/tcp.h                                  |   4 +-
 net/bluetooth/hci_sock.c                           |   1 +
 net/bluetooth/hci_sync.c                           |   2 +-
 net/bluetooth/iso.c                                |   1 +
 net/bluetooth/l2cap_core.c                         |  95 ++++++++++++++------
 net/bluetooth/l2cap_sock.c                         |  16 +++-
 net/bluetooth/sco.c                                |   1 +
 net/core/dev.c                                     |  35 +++++---
 net/core/skbuff.c                                  |  23 +++--
 net/ipv4/syncookies.c                              |   2 +-
 net/ipv4/tcp_fastopen.c                            |   2 +-
 net/ipv4/tcp_input.c                               |  18 +++-
 net/ipv4/tcp_ipv4.c                                |   8 +-
 net/ipv4/tcp_minisocks.c                           |   2 +-
 net/ipv4/udplite.c                                 |   3 +-
 net/ipv6/tcp_ipv6.c                                |  98 +++++++++-----------
 net/ipv6/udplite.c                                 |   3 +-
 net/ipv6/xfrm6_policy.c                            |   7 +-
 net/kcm/kcmsock.c                                  |  21 ++++-
 net/mac80211/link.c                                |   2 +
 net/mac80211/mesh.c                                |   3 +
 net/mac80211/mlme.c                                |   3 +
 net/mptcp/subflow.c                                |   6 +-
 net/netfilter/nf_conntrack_h323_asn1.c             |   2 +-
 net/psp/psp_main.c                                 |  39 +++++++-
 net/rds/connection.c                               |   3 +
 net/rds/tcp_listen.c                               |  28 ++----
 net/smc/af_smc.c                                   |   6 +-
 net/socket.c                                       |   2 +-
 net/tipc/name_table.c                              |   6 +-
 net/tls/tls_sw.c                                   |   2 +-
 net/vmw_vsock/af_vsock.c                           |  19 ++--
 net/wireless/core.c                                |   1 +
 net/wireless/radiotap.c                            |   4 +-
 net/wireless/wext-compat.c                         |   2 +-
 net/xfrm/espintcp.c                                |   2 +-
 net/xfrm/xfrm_device.c                             |  12 ++-
 net/xfrm/xfrm_policy.c                             |  11 ++-
 tools/testing/selftests/drivers/net/hw/rss_ctx.py  | 100 ++++++++++++++++++++-
 tools/testing/selftests/drivers/net/team/Makefile  |   1 +
 .../testing/selftests/drivers/net/team/refleak.sh  |  17 ++++
 .../net/packetdrill/tcp_rcv_zero_wnd_fin.pkt       |  27 ++++++
 tools/testing/selftests/vsock/vmtest.sh            |  41 ++++-----
 88 files changed, 826 insertions(+), 331 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/team/refleak.sh
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_zero_wnd_fin.pkt


