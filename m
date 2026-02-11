Return-Path: <netdev+bounces-258328-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GL+JAy29jGmisgAAu9opvQ
	(envelope-from <netdev+bounces-258328-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:32:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D676126A1D
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5407F30138A1
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3A323183C;
	Wed, 11 Feb 2026 17:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ELcBqkPt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B348033AD95
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770831144; cv=none; b=DlyfZ+U49tbH3MNwwRs4sfYc2V8Geu+89xZeF34zt+T6nrE5lFB3Casgzr40GZlP7DKLoG24V500iwxI4ha0M7zOcXJw3MQCzl7oTDZr3CdGW5rujiJvXVKg21K8O8hpTbzTlkr4tR0fjJ0XHNN3IkJZ9WynvERDF/69M1p/S1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770831144; c=relaxed/simple;
	bh=kKqQOv5QDmGZ8jtc9WTQs2+W7CpYcO4Mbo0vXnT2dnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MLyykAZ2uA5URRfzUqNkeWU3sF3OVn5z42TJZPhll85L8p5Ccyphw/cinLLcZ1ASQaYa+hhlC2Uf1jXOtaq7dgI+E6lLx46/Sbmpfg/Ld+y5Oq640Lz3I5GdgYbEZwnq3vJPyDqpStXyANujKCO160UEXCcGRlkkS7JY2gBxdG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ELcBqkPt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770831135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YblXdxmlakHmhhGRiCveQFBnKSPfX82n+tI8WzgZSbk=;
	b=ELcBqkPtGwpJYdxWB/GoVus4yr6HOL4Q+31O6gU5qW3w8qHLR9LF+jXGKhJzGI6D/e5Kpn
	gn0He27TvMY2KLLNQOmaqu4Ou6VY6VmExWPFYRC+JqAxsKt4lecMSBTLKFBVUrTQEjdOlT
	oNJM5W/JV74su+lX0g+CkEGKP3Si1tA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-aJZa9ijaMnWbB0TQM73fAw-1; Wed,
 11 Feb 2026 12:32:09 -0500
X-MC-Unique: aJZa9ijaMnWbB0TQM73fAw-1
X-Mimecast-MFC-AGG-ID: aJZa9ijaMnWbB0TQM73fAw_1770831128
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7609B19560AD;
	Wed, 11 Feb 2026 17:32:08 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.223])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B885530002D5;
	Wed, 11 Feb 2026 17:32:05 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for Linux 7.0
Date: Wed, 11 Feb 2026 18:30:15 +0100
Message-ID: <20260211173015.327542-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258328-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vmtest.sh:url]
X-Rspamd-Queue-Id: 2D676126A1D
X-Rspamd-Action: no action

Hi Linus!

I'm not aware of any conflicts with other trees, even if this includes some
changes to printk for the sake of netconsole.

The following changes since commit 8fdb05de0e2db89d8f56144c60ab784812e8c3b7:

  Merge tag 'net-6.19-rc9' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-02-05 09:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git net-next-7.0

for you to fetch changes up to 83310d613382f74070fc8b402f3f6c2af8439ead:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-02-11 15:14:35 +0100)

----------------------------------------------------------------
Networking changes for 7.0

Core & protocols
----------------

 - A significant effort all around the stack to guide the compiler to
   make the right choice when inlining code, to avoid unneeded calls for
   small helper and stack canary overhead in the fast-path. This
   generates better and faster code with very small or no text size
   increases, as in many cases the call generated more code than the
   actual inlined helper.

 - Extend AccECN implementation so that is now functionally complete,
   also allow the user-space enabling it on a per network namespace
   basis.

 - Add support for memory providers with large (above 4K) rx buffer.
   Paired with hw-gro, larger rx buffer sizes reduce the number of
   buffers traversing the stack, dincreasing single stream CPU usage by
   up to ~30%.

 - Do not add HBH header to Big TCP GSO packets. This simplifies the RX
   path, the TX path and the NIC drivers, and is possible because
   user-space taps can now interpret correctly such packets without the
   HBH hint.

 - Allow IPv6 routes to be configured with a gateway address that is
   resolved out of a different interface than the one specified, aligning
   IPv6 to IPv4 behavior.

 - Multi-queue aware sch_cake. This makes it possible to scale the rate
   shaper of sch_cake across multiple CPUs, while still enforcing a
   single global rate on the interface.

 - Add support for the nbcon (new buffer console) infrastructure to
   netconsole, enabling lock-free, priority-based console operations that
   are safer in crash scenarios.

 - Improve the TCP ipv6 output path to cache the flow information, saving
   cpu cycles, reducing cache line misses and stack use.

 - Improve netfilter packet tracker to resolve clashes for most protocols,
   avoiding unneeded drops on rare occasions.

 - Add IP6IP6 tunneling acceleration to the flowtable infrastructure.

 - Reduce tcp socket size by one cache line.

 - Notify neighbour changes atomically, avoiding inconsistencies between
   the notification sequence and the actual states sequence.

 - Add vsock namespace support, allowing complete isolation of vsocks
   across different network namespaces.

 - Improve xsk generic performances with cache-alignment-oriented
   optimizations.

 - Support netconsole automatic target recovery, allowing netconsole
   to reestablish targets when underlying low-level interface comes back
   online.

Driver API
----------

 - Support for switching the working mode (automatic vs manual) of a DPLL
   device via netlink.

 - Introduce PHY ports representation to expose multiple front-facing
   media ports over a single MAC.

 - Introduce "rx-polarity" and "tx-polarity" device tree properties, to
   generalize polarity inversion requirements for differential signaling.

 - Add helper to create, prepare and enable managed clocks.

Device drivers
--------------

 - Add Huawei hinic3 PF etherner driver.

 - Add DWMAC glue driver for Motorcomm YT6801 PCIe ethernet controller.

 - Add ethernet driver for MaxLinear MxL862xx switches

 - Remove parallel-port Ethernet driver.

 - Convert existing driver timestamp configuration reporting to
   hwtstamp_get and remove legacy ioctl().

 - Convert existing drivers to .get_rx_ring_count(), simplifing the RX
   ring count retrieval. Also remove the legacy fallback path.

 - Ethernet high-speed NICs:
   - Broadcom (bnxt, bng):
     - bnxt: add FW interface update to support FEC stats histogram and
       NVRAM defragmentation
     - bng: add TSO and H/W GRO support
   - nVidia/Mellanox (mlx5):
     - improve latency of channel restart operations, reducing the used
       H/W resources
     - add TSO support for UDP over GRE over VLAN
     - add flow counters support for hardware steering (HWS) rules
     - use a static memory area to store headers for H/W GRO, leading to
       12% RX tput improvement
   - Intel (100G, ice, idpf):
     - ice: reorganizes layout of Tx and Rx rings for cacheline
       locality and utilizes __cacheline_group* macros on the new layouts
     - ice: introduces Synchronous Ethernet (SyncE) support
   - Meta (fbnic):
     - adds debugfs for firmware mailbox and tx/rx rings vectors

 - Ethernet virtual:
   - geneve: introduce GRO/GSO support for double UDP encapsulation

 - Ethernet NICs consumer, and embedded:
   - Synopsys (stmmac):
     - some code refactoring and cleanups
   - RealTek (r8169):
     - add support for RTL8127ATF (10G Fiber SFP)
     - add dash and LTR support
   - Airoha:
     - AN8811HB 2.5 Gbps phy support
   - Freescale (fec):
     - add XDP zero-copy support
   - Thunderbolt:
     - add get link setting support to allow bonding
   - Renesas:
     - add support for RZ/G3L GBETH SoC

 - Ethernet switches:
   - Maxlinear:
     - support R(G)MII slow rate configuration
     - add support for Intel GSW150
   - Motorcomm (yt921x):
     - add DCB/QoS support
   - TI:
     - icssm-prueth: support bridging (STP/RSTP) via the switchdev
       framework

 - Ethernet PHYs:
   - Realtek:
     - enable SGMII and 2500Base-X in-band auto-negotiation
     - simplify and reunify C22/C45 drivers
   - Micrel: convert bindings to DT schema

 - CAN:
   - move skb headroom content into skb extensions, making CAN metadata
     access more robust

 - CAN drivers:
   - rcar_canfd:
     - add support for FD-only mode
     - add support for the RZ/T2H SoC
   - sja1000: cleanup the CAN state handling

 - WiFi:
   - implement EPPKE/802.1X over auth frames support
   - split up drop reasons better, removing generic RX_DROP
   - additional FTM capabilities: 6 GHz support, supported number of
     spatial streams and supported number of LTF repetitions
   - better mac80211 iterators to enumerate resources
   - initial UHR (Wi-Fi 8) support for cfg80211/mac80211

 - WiFi drivers:
   - Qualcomm/Atheros:
     - ath11k: support for Channel Frequency Response measurement
     - ath12k: a significant driver refactor to support
       multi-wiphy devices and and pave the way for future device support
       in the same driver (rather than splitting to ath13k)
     - ath12k: support for the QCC2072 chipset
   - Intel:
     - iwlwifi: partial Neighbor Awareness Networking (NAN) support
     - iwlwifi: initial support for U-NII-9 and IEEE 802.11bn
   - RealTek (rtw89):
     - preparations for RTL8922DE support

 - Bluetooth:
   - implement setsockopt(BT_PHY) to set the connection packet type/PHY
   - set link_policy on incoming ACL connections

 - Bluetooth drivers:
   - btusb: add support for MediaTek7920, Realtek RTL8761BU and 8851BE
   - btqca: add WCN6855 firmware priority selection feature

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Aaradhana Sahu (4):
      wifi: ath12k: Fix index decrement when array_len is zero
      wifi: ath12k: Add support RX PDEV stats
      wifi: ath12k: Add support TX hardware queue stats
      wifi: ath12k: clear stale link mapping of ahvif->links_map

Aditya Kumar Singh (1):
      wifi: mac80211: Update csa_finalize to use link_id

Ainy Kumari (2):
      wifi: cfg80211: add support for EPPKE Authentication Protocol
      wifi: cfg80211: add feature flag for (re)association frame encryption

Akiyoshi Kurita (1):
      dt-bindings: net: dsa: fix typos in bindings docs

Aleksander Jan Bajkowski (2):
      net: phy: mediatek: enable interrupts on AN7581
      net: airoha: implement get_link_ksettings

Alexander Lobakin (1):
      ice: reshuffle and group Rx and Tx queue fields by cachelines

Alexander Minchev (1):
      wifi: ath12k: remove redundant pci_set_drvdata() call

Alexander Sverdlin (2):
      dt-bindings: net: dsa: lantiq,gswip: add MaxLinear R(G)MII slew rate
      net: dsa: mxl-gsw1xx: Support R(G)MII slew rate configuration

Alexandru Gagniuc (1):
      wifi: ath11k: move .max_tx_ring to struct ath11k_hw_hal_params

Alexei Lazar (2):
      net/mlx5: Add IFC bits for extended ETS rate limit bandwidth value
      net/mlx5e: Extend TC max ratelimit using max_bw_value_msb

Ali Tariq (1):
      wifi: rtl8xxxu: fix slab-out-of-bounds in rtl8xxxu_sta_add

Alice Mikityanska (12):
      net/ipv6: Introduce payload_len helpers
      net/ipv6: Drop HBH for BIG TCP on TX side
      net/ipv6: Drop HBH for BIG TCP on RX side
      net/ipv6: Remove jumbo_remove step from TX path
      net/mlx5e: Remove jumbo_remove step from TX path
      net/mlx4: Remove jumbo_remove step from TX path
      ice: Remove jumbo_remove step from TX path
      bnxt_en: Remove jumbo_remove step from TX path
      gve: Remove jumbo_remove step from TX path
      net: mana: Remove jumbo_remove step from TX path
      bng_en: Remove jumbo_remove step from TX path
      net/ipv6: Remove HBH helpers

Allison Henderson (3):
      net/rds: Add per cp work queue
      net/rds: Give each connection path its own workqueue
      net/rds: Update struct rds_statistics to use u64 instead of uint64_t

Ally Heev (1):
      wifi: iwlwifi: mld: remove unused variable in d3.c

Alok Singh (12):
      wifi: ath12k: Move monitor ring processing to Wi-Fi 7 module
      wifi: ath12k: Move monitor status processing to Wi-Fi 7 module
      wifi: ath12k: Move MPDU pop functionality to Wi-Fi 7 module
      wifi: ath12k: Move RX status TLV parsing to Wi-Fi 7 module
      wifi: ath12k: Move TX monitor functionality to Wi-Fi 7 module
      wifi: ath12k: Move HT/VHT SIG processing to Wi-Fi 7 module
      wifi: ath12k: Move HE SIG processing to Wi-Fi 7 module
      wifi: ath12k: Move EHT SIG processing to Wi-Fi 7 module
      wifi: ath12k: Move remaining SIG TLV parsing to Wi-Fi 7 module
      wifi: ath12k: Move MU user processing to Wi-Fi 7 module
      wifi: ath12k: Move MSDU END TLV processing to Wi-Fi 7 module
      wifi: ath12k: Remove Wi-Fi 7 header dependencies from common ath12k module

Alok Tiwari (4):
      net: marvell: prestera: correct return type of prestera_ldr_wait_buf()
      octeontx2-pf: Fix header guard comment in otx2_devlink.h
      bng_en: fix misleading error message for generic firmware version
      net: marvell: prestera: fix FEC error message for SFP ports

Amith A (1):
      wifi: mac80211: use wiphy_hrtimer_work for CAC timeout

Anders Grahn (1):
      netfilter: nft_counter: fix reset of counters on 32bit archs

Andre Carvalho (6):
      netconsole: convert 'enabled' flag to enum for clearer state management
      netconsole: clear dev_name for devices bound by mac
      netconsole: introduce helpers for dynamic_netconsole_mutex lock/unlock
      netconsole: resume previously deactivated target
      selftests: netconsole: validate target resume
      netconsole: selftests: Move netconsole selftests to separate target

Andrew Lunn (14):
      net: ftgmac100: List all compatibles
      net: ftgmac100: Add match data containing MAC ID
      net: ftgmac100: Replace all of_device_is_compatible()
      net: ftgmac100: Use devm_alloc_etherdev()
      net: ftgmac100: Use devm_request_memory_region/devm_ioremap
      net: ftgmac100: Use devm_clk_get_enabled
      net: ftgmac100: Simplify error handling for ftgmac100_initial_mac
      net: ftgmac100: Move NCSI probe code into a helper
      net: ftgmac100: Always register the MDIO bus when it exists
      net: ftgmac100: Simplify legacy MDIO setup
      net: ftgmac100: Move DT probe into a helper
      net: ftgmac100: Remove redundant PHY_POLL
      net: ftgmac100: Simplify condition on HW arbitration
      net: ftgmac100: Fix wrong netif_napi_del in release

Andy Shevchenko (1):
      idpf: Fix kernel-doc descriptions to avoid warnings

Ankit Khushwaha (1):
      selftests/net/ipsec: Fix variable size type not at the end of struct

Anshumali Gaur (1):
      octeontx2-af: Fix PF driver crash with kexec kernel booting

Arkadiusz Kubalewski (1):
      ice: dpll: Support E825-C SyncE and dynamic pin discovery

Arnd Bergmann (3):
      vmw_vsock: bypass false-positive Wnonnull warning with gcc-16
      hinic3: select CONFIG_DIMLIB
      myri10ge: avoid uninitialized variable use

Avraham Stern (4):
      wifi: nl80211/cfg80211: add new FTM capabilities
      wifi: nl80211/cfg80211: clarify periodic FTM parameters for non-EDCA based ranging
      wifi: nl80211/cfg80211: add negotiated burst period to FTM result
      wifi: nl80211/cfg80211: support operating as RSTA in PMSR FTM request

Babis Chalios (2):
      ptp: vmclock: add vm generation counter
      ptp: vmclock: support device notifications

Baochen Qiang (20):
      wifi: ath12k: add the missing RCU lock in ath12k_dp_tx_free_txbuf()
      wifi: ath12k: move firmware stats request outside of atomic context
      wifi: ath12k: do WoW offloads only on primary link
      wifi: ath12k: refactor PCI window register access
      wifi: ath12k: refactor REO CMD ring handling
      wifi: ath12k: refactor REO status ring handling
      wifi: ath12k: fix preferred hardware mode calculation
      wifi: ath12k: refactor 320 MHz bandwidth support parsing
      wifi: ath12k: fix mac phy capability parsing
      wifi: ath12k: add hardware registers for QCC2072
      wifi: ath12k: add hardware parameters for QCC2072
      wifi: ath12k: support LPASS_SHARED target memory type
      wifi: ath12k: support downloading auxiliary ucode image for QCC2072
      wifi: ath12k: add HAL descriptor and ops for QCC2072
      wifi: ath12k: add hardware ops support for QCC2072
      wifi: ath12k: handle REO CMD ring for QCC2072
      wifi: ath12k: handle REO status ring for QCC2072
      wifi: ath12k: limit number of channels per WMI command
      wifi: ath12k: send peer meta data version to firmware
      wifi: ath12k: enable QCC2072 support

Bastien Curutchet (Schneider Electric) (9):
      net: dsa: microchip: Initialize IRQ's mask outside common_setup()
      net: dsa: microchip: Use dynamic irq offset
      net: dsa: microchip: Use regs[] to access REG_PTP_CLK_CTRL
      net: dsa: microchip: Use regs[] to access REG_PTP_RTC_NANOSEC
      net: dsa: microchip: Use regs[] to access REG_PTP_RTC_SEC
      net: dsa: microchip: Use regs[] to access REG_PTP_RTC_SUB_NANOSEC
      net: dsa: microchip: Use regs[] to access REG_PTP_SUBNANOSEC_RATE
      net: dsa: microchip: Use regs[] to access REG_PTP_MSG_CONF1
      net: dsa: microchip: Wrap timestamp reading in a function

Bastien Nocera (3):
      Bluetooth: btusb: Use pm_ptr instead of #ifdef CONFIG_PM
      Bluetooth: btnxpuart: Remove unneeded CONFIG_PM ifdef
      Bluetooth: btintel: Remove unneeded CONFIG_PM* #ifdef's

Benjamin Berg (2):
      wifi: iwlwifi: mld: decode VHT information for sniffer
      wifi: iwlwifi: mld: change cluster_id type to u8 array

Bhargava Marreddy (8):
      bng_en: Extend bnge_set_ring_params() for rx-copybreak
      bng_en: Add RX support
      bng_en: Handle an HWRM completion request
      bng_en: Add TX support
      bng_en: Add ndo_features_check support
      bng_en: Add support to handle AGG events
      bng_en: Add TPA related functions
      bng_en: Add support for TPA events

Biju Das (5):
      dt-bindings: can: renesas,rcar-canfd: Document renesas,fd-only property
      can: rcar_canfd: Add support for FD-Only mode
      dt-bindings: net: renesas,rzv2h-gbeth: Document Renesas RZ/G3L SoC
      net: stmmac: dwmac-renesas-gbeth: Add support for RZ/G3L SoC
      dt-bindings: net: renesas,rzv2h-gbeth: Document Renesas RZ/G3L RMII{tx,rx} clocks

Birger Koblitz (1):
      ixgbe: Add 10G-BX support

Bitterblue Smith (4):
      wifi: rtw88: 8822b: Avoid WARNING in rtw8822b_config_trx_mode()
      wifi: rtw88: Fix alignment fault in rtw_core_enable_beacon()
      wifi: rtw88: Use devm_kmemdup() in rtw_set_supported_band()
      wifi: rtw88: Fix inadvertent sharing of struct ieee80211_supported_band data

Bjørn Mork (3):
      net: phy: air_en8811h: factor out shareable code
      net: phy: air_en8811h: add Airoha AN8811HB support
      net: phy: air_en8811h: Add clk provider for an8811hb

Bluecross (1):
      Bluetooth: btusb: Add support for MediaTek7920 0489:e158

Bo Sun (1):
      octeontx2-af: CGX: fix bitmap leaks

Bobby Eshleman (14):
      net: devmem: convert binding refcount to percpu_ref
      tools/net/ynl: suppress jobserver warning in ynltool version detection
      vsock: add netns to vsock core
      virtio: set skb owner of virtio_transport_reset_no_sock() reply
      vsock: add netns support to virtio transports
      selftests/vsock: increase timeout to 1200
      selftests/vsock: add namespace helpers to vmtest.sh
      selftests/vsock: prepare vm management helpers for namespaces
      selftests/vsock: add vm_dmesg_{warn,oops}_count() helpers
      selftests/vsock: use ss to wait for listeners instead of /proc/net
      selftests/vsock: add tests for proc sys vsock ns_mode
      selftests/vsock: add namespace tests for CID collisions
      selftests/vsock: add tests for host <-> vm connectivity with namespaces
      selftests/vsock: add tests for namespace deletion

Breno Leitao (34):
      net: gve: convert to use .get_rx_ring_count
      net: stmmac: convert to use .get_rx_ring_count
      net: octeontx2: convert to use .get_rx_ring_count
      net: hinic: convert to use .get_rx_ring_count
      net: enic: convert to use .get_rx_ring_count
      net: funeth: convert to use .get_rx_ring_count
      net: niu: convert to use .get_rx_ring_count
      net: qede: convert to use .get_rx_ring_count
      net: hns: convert to use .get_rx_ring_count
      net: hns3: convert to use .get_rx_ring_count
      net: tsnep: convert to use .get_rx_ring_count
      net: mediatek: convert to use .get_rx_ring_count
      net: ena: convert to use .get_rx_ring_count
      net: lan743x: convert to use .get_rx_ring_count
      net: xgbe: convert to use .get_rx_ring_count
      net: cxgb4: convert to use .get_rx_ring_count
      net: macb: convert to use .get_rx_ring_count
      net: txgbe: convert to use .get_rx_ring_count
      netconsole: add target_state enum
      netconsole: add STATE_DEACTIVATED to track targets disabled by low level
      net: benet: convert to use .get_rx_ring_count
      net: atlantic: convert to use .get_rx_ring_count
      net: nfp: convert to use .get_rx_ring_count
      net: mana: convert to use .get_rx_ring_count
      net: fbnic: convert to use .get_rx_ring_count
      net: ionic: convert to use .get_rx_ring_count
      net: sfc: efx: convert to use .get_rx_ring_count
      net: sfc: siena: convert to use .get_rx_ring_count
      net: sfc: falcon: convert to use .get_rx_ring_count
      ethtool: remove ETHTOOL_GRXRINGS fallback through get_rxnfc
      printk: Add execution context (task name/CPU) to printk_info
      netconsole: extract message fragmentation into send_msg_udp()
      netconsole: convert to NBCON console infrastructure
      netconsole: Use printk context for CPU and task information

Carl Lee (1):
      nfc: nxp-nci: remove interrupt trigger type

Chen Ni (1):
      Bluetooth: btintel_pcie: Remove unnecessary check before kfree_skb()

Chen-Yu Tsai (1):
      wifi: mwifiex: Allocate dev name earlier for interface workqueue name

Chia-Yu Chang (13):
      selftests/net: gro: add self-test for TCP CWR flag
      tcp: ECT_1_NEGOTIATION and NEEDS_ACCECN identifiers
      tcp: disable RFC3168 fallback identifier for CC modules
      tcp: accecn: handle unexpected AccECN negotiation feedback
      tcp: accecn: retransmit downgraded SYN in AccECN negotiation
      tcp: add TCP_SYNACK_RETRANS synack_type
      tcp: accecn: retransmit SYN/ACK without AccECN option or non-AccECN SYN/ACK
      tcp: accecn: unset ECT if receive or send ACE=0 in AccECN negotiaion
      tcp: accecn: fallback outgoing half link to non-AccECN
      tcp: accecn: detect loss ACK w/ AccECN option and add TCP_ACCECN_OPTION_PERSIST
      tcp: accecn: add tcpi_ecn_mode and tcpi_option2 in tcp_info
      tcp: accecn: enable AccECN
      selftests/net: packetdrill: add TCP Accurate ECN cases

Chia-Yuan Li (1):
      wifi: rtw89: coex: update coex software control for RTL8922D

Chien Wong (1):
      wifi: ath11k: fix comment typo in monitor mode handling

Chih-Kang Chang (8):
      wifi: rtw89: refine C2H reg event polling timeout for LPS
      wifi: rtw89: setting TBTT AGG number when mac port initialization
      wifi: rtw89: mcc: reset probe counter when receiving beacon
      wifi: rtw89: refine TX nulldata judgement when scan with 2 OP channels
      wifi: rtw89: 8922a: configure FW version for SCAN_OFFLOAD_EXTRA_OP feature
      wifi: rtw89: rfk: add rtw89_fw_h2c_rf_pre_ntfy_mcc for new WiFi 7 firmware
      wifi: rtw89: rfk: update rtw89_fw_h2c_rf_pre_ntfy_mcc format
      wifi: rtw89: wow: disable interrupt before swapping FW for 8922D

Chin-Yen Lee (4):
      wifi: rtw89: wow: use struct style to fill WOW CAM H2C command
      wifi: rtw89: wow: add WOW_CAM update function for 8922D
      wifi: rtw89: wow: abstract DMA check register for RTL8922DE
      wifi: rtw89: wow: add reason codes for disassociation in WoWLAN mode

Christophe Leroy (CS GROUP) (1):
      selftests: net: csum: Fix printk format in recv_get_packet_csum_status()

Chukun Pan (1):
      net: spacemit: display phy driver information

Clara Engler (1):
      ipv4: Improve martian logs

Cong Wang (1):
      MAINTAINERS: Remove myself from TC maintainers

Cosmin Ratiu (3):
      selftests: drv-net: psp: Better control the used PSP dev
      devlink: Reverse locking order for nested instances
      devlink: Refactor devlink_rate_nodes_check

D. Wythe (1):
      Revert "net/smc: Introduce TCP ULP support"

Dan Carpenter (3):
      wifi: ath12k: clean up on error in ath12k_dp_setup()
      net: stmmac: s32: use a syscon for S32_PHY_INTF_SEL_RGMII
      dt-bindings: net: nxp,s32-dwmac: Use the GPR syscon

Daniel Borkmann (9):
      net: Add queue-create operation
      net: Implement netdev_nl_queue_create_doit
      net: Add lease info to queue-get response
      net, ethtool: Disallow leased real rxqs to be resized
      xsk: Extend xsk_rcv_check validation
      xsk: Proxy pool management for leased queues
      netkit: Add single device mode for netkit
      netkit: Add netkit notifier to check for unregistering devices
      netkit: Add xsk support for af_xdp applications

Daniel Gabay (2):
      wifi: iwlwifi: mld: Remove wrong channel flags in scan cmd
      wifi: iwlwifi: mvm: Remove few redundant 6 GHz scan chan params

Daniel Golle (24):
      net: phy: realtek: fix whitespace in struct phy_driver initializers
      net: phy: realtek: implement configuring in-band an
      net: phy: move mmd_phy_read and mmd_phy_write to phylib.h
      net: phy: realtek: use paged access for MDIO_MMD_VEND2 in C22 mode
      net: phy: realtek: get rid of magic number in rtlgen_read_status()
      net: phy: mxl-gpy: implement SGMII in-band configuration
      net: phy: realtek: support interrupt also for C22 variants
      net: phy: realtek: simplify C22 reg access via MDIO_MMD_VEND2
      net: phy: realtek: reunify C22 and C45 drivers
      net: phy: realtek: demystify PHYSR register location
      net: phy: realtek: simplify bogus paged operations
      dt-bindings: net: dsa: lantiq,gswip: use correct node name
      dt-bindings: net: dsa: lantiq,gswip: add Intel GSW150
      net: dsa: lantiq: allow arbitrary MII registers
      net: dsa: lantiq: clean up phylink_get_caps switch statement
      net: dsa: mxl-gsw1xx: only setup SerDes PCS if it exists
      net: dsa: mxl-gsw1xx: add support for Intel GSW150
      dt-bindings: net: dsa: lantiq,gswip: reference common PHY properties
      net: dsa: mxl-gsw1xx: configure SerDes port polarities
      net: dsa: mxl-gsw1xx: validate chip ID
      dt-bindings: net: dsa: add MaxLinear MxL862xx
      net: dsa: add tag format for MxL862xx switches
      net: mdio: add unlocked mdiodev C45 bus accessors
      net: dsa: add basic initial driver for MxL862xx switches

Daniel Hodges (1):
      tipc: fix RCU dereference race in tipc_aead_users_dec()

Daniel Sedlak (1):
      tcp: clarify tcp_congestion_ops functions comments

Daniel Zahka (1):
      selftests: drv-net: psp: fix test flakes from racy connection close

Danielle Ratson (1):
      selftests: net: Add kernel selftest for RFC 4884

David Corvaglia (1):
      net: bridge: use sysfs_emit instead of sprintf

David Laight (1):
      mptcp: Change some dubious min_t(int, ...) to min()

David Wei (8):
      selftests/net: parametrise iou-zcrx.py with ksft_variants
      net: Proxy net_mp_{open,close}_rxq for leased queues
      net: Proxy netdev_queue_get_dma_dev for leased queues
      netkit: Implement rtnl_link_ops->alloc and ndo_queue_create
      selftests/net: Add bpf skb forwarding program
      selftests/net: Add env for container based tests
      selftests/net: Make NetDrvContEnv support queue leasing
      selftests/net: Add netkit container tests

David Woodhouse (5):
      dt-bindings: ptp: Add amazon,vmclock
      ptp: ptp_vmclock: Add device tree support
      ptp: ptp_vmclock: add 'VMCLOCK' to ACPI device match
      ptp: ptp_vmclock: remove dependency on CONFIG_ACPI
      ptp: ptp_vmclock: return TAI not UTC

David Yang (17):
      net: dsa: yt921x: Add LAG offloading support
      net: ifb: use u64_stats_t with u64_stats_sync properly
      xen/netfront: Use u64_stats_t with u64_stats_sync properly
      u64_stats: Introduce u64_stats_copy()
      net: bridge: mcast: fix memcpy with u64_stats
      macsec: fix memcpy with u64_stats
      vxlan: vnifilter: fix memcpy with u64_stats
      net: alacritech: Use u64_stats_t with u64_stats_sync properly
      netdevsim: use u64_stats_t with u64_stats_sync properly
      net: ethernet: ti: netcp: Use u64_stats_t with u64_stats_sync properly
      wifi: mac80211: use u64_stats_t with u64_stats_sync properly
      net: dsa: tag_yt921x: clarify priority and code fields
      net: dsa: tag_yt921x: add priority support
      net: dsa: yt921x: Refactor VLAN awareness setting
      net: dsa: yt921x: Refactor yt921x_chip_setup()
      net: dsa: yt921x: Add DCB/QoS support
      flow_offload: add const qualifiers to function arguments

Davide Caratti (1):
      net/sched: don't use dynamic lockdep keys with clsact/ingress/noqueue

Dian-Syuan Yang (3):
      wifi: rtw89: enhance connection stability when triggering beacon loss
      wifi: rtw89: 8852b: refine hardware parameters for RFE type 5
      wifi: rtw89: pci: restore LDO setting after device resume

Dimitri Daskalakis (2):
      Documentation: net: Fix typos in netdevices.rst
      selftests: drivers: net: hw: Modify toeplitz.c to poll for packets

Dipayaan Roy (1):
      net: mana: Implement ndo_tx_timeout and serialize queue resets per port.

Dmitry Baryshkov (1):
      wifi: ath10k: snoc: support powering on the device via pwrseq

Donald Hunter (13):
      tools: ynl: pylint suppressions and docstrings
      tools: ynl: fix pylint redefinition, encoding errors
      tools: ynl: fix pylint exception warnings
      tools: ynl: fix pylint dict, indentation, long lines, uninitialised
      tools: ynl: fix pylint misc warnings
      tools: ynl: fix pylint global variable related warnings
      tools: ynl: fix logic errors reported by pylint
      tools: ynl: ethtool: fix pylint issues
      tools: ynl: fix pylint issues in ynl_gen_rst
      tools: ynl-gen-c: suppress unhelpful pylint messages
      tools: ynl-gen-c: fix pylint warnings for returns, unused, redefined
      tools: ynl-gen-c: fix pylint None, type, dict, generators, init
      tools: ynl-gen-c: Fix remaining pylint warnings

Dragos Tatulea (3):
      net/mlx5e: RX, Drop oversized packets in non-linear mode
      net/mlx5e: SHAMPO, Improve allocation recovery
      net/mlx5e: SHAMPO, Switch to header memcpy

Emmanuel Grumbach (8):
      wifi: iwlwifi: mld: trigger a dump upon notification if needed
      wifi: iwlwifi: move lari helper functions to the op_mode
      wifi: iwlwifi: move iwl_get_lari_config_bitmap to the op_mode
      wifi: iwlwifi: acpi: cache the DSM functions
      wifi: iwlwifi: uefi: cache the DSM functions
      wifi: iwlwifi: split bios_value_u32 to separate the header
      wifi: iwlwifi: support V13 of iwl_lari_config_change_cmd
      wifi: iwlwifi: rename struct iwl_mcc_allowed_ap_type_cmd::offset_map

Eric Biggers (2):
      ipv6: Switch to higher-level SHA-1 functions
      lib/crypto: sha1: Remove low-level functions from API

Eric Dumazet (73):
      udp: udplite is unlikely
      net: fully inline backlog_unlock_irq_restore()
      net: add skbuff_clear() helper
      net: inline napi_skb_cache_get()
      net: minor __alloc_skb() optimization
      tcp: move tcp_rate_skb_sent() to tcp_output.c
      ipv6: add sysctl_ipv6_flowlabel group
      ipv6: annotate data-races from ip6_make_flowlabel()
      ipv6: annotate date-race in ipv6_can_nonlocal_bind()
      ipv6: annotate data-races in ip6_multipath_hash_{policy,fields}()
      ipv6: annotate data-races over sysctl.flowlabel_reflect
      ipv6: annotate data-races around sysctl.ip6_rt_gc_interval
      ipv6: exthdrs: annotate data-race over multiple sysctl
      ipv6: annotate data-races in net/ipv6/route.c
      net: split kmalloc_reserve() to allow inlining
      net: fclone allocation small optimization
      tcp: move tcp_rate_skb_delivered() to tcp_input.c
      tcp: preserve const qualifier in tcp_rsk() and inet_rsk()
      net: always inline __skb_incr_checksum_unnecessary()
      gro: inline tcp6_gro_receive()
      gro: inline tcp6_gro_complete()
      tcp: move tcp_rate_gen to tcp_input.c
      tcp: move tcp_rate_check_app_limited() to tcp.c
      tcp: move tcp_stream_memory_free() to tcp.c
      net: always inline skb_frag_unref() and __skb_frag_unref()
      gro: change the BUG_ON() in gro_pull_from_frag0()
      net: inline net_is_devmem_iov()
      net: inline get_netmem() and put_netmem()
      net: expand NETDEV_RSS_KEY_LEN to 256 bytes
      ipvlan: remove ipvlan_ht_addr_lookup()
      ipv4: igmp: annotate data-races around idev->mr_maxdelay
      net: include <linux/hex.h> from sysctl_net_core.c
      tcp: move sk_forced_mem_schedule() to tcp.c
      tcp: mark tcp_process_tlp_ack() as unlikely
      tcp: move tcp_rack_update_reo_wnd() to tcp_input.c
      tcp: move tcp_rack_advance() to tcp_input.c
      tcp: tcp_tx_timestamp() must look at the rtx queue
      selftest: packetdrill: add tcp_timestamping_tcp_tx_timestamp_bug.pkt
      selftests: drv-net: toeplitz: accept bigger rss keys
      ipv6: remove __inet6_csk_dst_check()
      ipv6: optimize fl6_update_dst()
      tcp: reduce tcp sockets size by one cache line
      net: l3mdev: use skb_dst_dev_rcu() in l3mdev_l3_out()
      net: add a debug check in __skb_push()
      ipv6: pass proto by value to ipv6_push_nfrag_opts() and ipv6_push_frag_opts()
      ipv6: add some unlikely()/likely() clauses in ip6_output.c
      ipv6: use __skb_push() in ip6_xmit()
      ipv6: use SKB_DROP_REASON_PKT_TOO_BIG in ip6_xmit()
      inet: add dst4_mtu() and dst6_mtu() helpers
      ipv6: use dst6_mtu() instead of dst_mtu()
      ipv4: use dst4_mtu() instead of dst_mtu()
      ipv6: colocate inet6_cork in inet_cork_full
      tcp: use __skb_push() in __tcp_transmit_skb()
      tcp: move tcp_rbtree_insert() to tcp_output.c
      tcp: split tcp_check_space() in two parts
      net_sched: sch_fq: tweak unlikely() hints in fq_dequeue()
      net: add vlan_get_protocol_offset_inline() helper
      inet: move reqsk_queue_alloc() to net/ipv4/inet_connection_sock.c
      tcp: move reqsk_fastopen_remove to net/ipv4/tcp_fastopen.c
      net: get rid of net/core/request_sock.c
      tcp: move __reqsk_free() out of line
      ipv6: change inet6_sk_rebuild_header() to use inet->cork.fl.u.ip6
      inet: RAW sockets using IPPROTO_RAW MUST drop incoming ICMP
      net_sched: sch_fq: rework fq_gc() to avoid stack canary
      tcp: inline tcp_filter()
      ipv6: do not use skb_header_pointer() in icmpv6_filter()
      ipv6: add daddr/final storage in struct ipv6_pinfo
      ipv6: use np->final in inet6_sk_rebuild_header()
      ipv6: use inet->cork.fl.u.ip6 and np->final in ip6_datagram_dst_update()
      ipv6: inet6_csk_xmit() and inet6_csk_update_pmtu() use inet->cork.fl.u.ip6
      tcp: populate inet->cork.fl.u.ip6 in tcp_v6_connect()
      tcp: populate inet->cork.fl.u.ip6 in tcp_v6_syn_recv_sock()
      tcp: inet6_csk_xmit() optimization

Eric Huang (5):
      wifi: rtw89: phy: extend register to read history 2 of PHY env_monitor
      wifi: rtw89: phy: update bb wrapper TPU init
      wifi: rtw89: phy: handle C2H event for PS mode report
      wifi: rtw89: phy: add H2C command to send detail RX gain and link parameters for PS mode
      wifi: rtw89: phy: update edcca log parsing for RTL8922D

Eric Joyner (1):
      ionic: Rate limit unknown xcvr type messages

Ethan Nelson-Moore (19):
      net: usb: sr9700: fix byte numbering in comments
      net: usb: sr9700: remove code to drive nonexistent MII
      net: remove HIPPI support and RoadRunner HIPPI driver
      net: atp: drop ancient parallel-port Ethernet driver
      net: usb: sr9700: use ETH_ALEN instead of magic number
      net: usb: sr9700: rename register write commands for clarity
      net: usb: smsc95xx: use phy_do_ioctl_running function
      net: usb: replace unnecessary get_link functions with usbnet_get_link
      net: usb: sr9700: replace magic numbers with register bit macros
      net: usb: int51x1: use usbnet_cdc_update_filter
      net: ethernet: neterion: s2io: remove unused driver
      net: usb: remove unnecessary get_drvinfo code and driver versions
      net: ax25: remove plumbing for never-implemented DAMA Master support
      net: ethernet: use module_pci_driver; remove useless driver versions
      net: remove unnecessary module_init/exit functions
      net: usb: introduce usbnet_mii_ioctl helper function
      net: usb: sr9700: remove code to drive nonexistent multicast filter
      net: arcnet: com20020-pci: use module_pci_driver
      net: ethernet: marvell: skge: remove incorrect conflicting PCI ID

Fan Gong (13):
      hinic3: Add PF framework
      hinic3: Add PF management interfaces
      hinic3: Add .ndo_tx_timeout and .ndo_get_stats64
      hinic3: Add .ndo_set_features and .ndo_fix_features
      hinic3: Add .ndo_features_check
      hinic3: Add .ndo_vlan_rx_add/kill_vid and .ndo_validate_addr
      hinic3: Add adaptive IRQ coalescing with DIM
      hinic3: Add mac filter ops
      hinic3: Add HW event handler
      hinic3: Fix code Style(remove empty lines between error handling)
      hinic3: Remove defensive txq_num check
      hinic3: Use array_size instead of multiplying
      hinic3: RQ use RQ_CTXT_PREF_CI_HI instead of SQ_CTXT_PREF_CI_HI

Felix Maurer (8):
      selftests: hsr: Add ping test for PRP
      selftests: hsr: Check duplicates on HSR with VLAN
      selftests: hsr: Add tests for faulty links
      hsr: Implement more robust duplicate discard for PRP
      selftests: hsr: Add tests for more link faults with PRP
      hsr: Implement more robust duplicate discard for HSR
      selftests: hsr: Add more link fault tests for HSR
      MAINTAINERS: Assign hsr selftests to HSR

Fernando Fernandez Mancera (2):
      netfilter: nf_conncount: increase the connection clean up limit to 64
      netfilter: nf_conncount: fix tracking of connections from localhost

Florian Westphal (11):
      netfilter: nf_tables: reset table validation state on abort
      netfilter: nf_conntrack: enable icmp clash support
      netfilter: don't include xt and nftables.h in unrelated subsystems
      netfilter: nf_conntrack: don't rely on implicit includes
      netfilter: nft_compat: add more restrictions on netlink attributes
      netfilter: xt_tcpmss: check remaining length before reading optlen
      netfilter: nft_set_rbtree: don't gc elements on insert
      netfilter: nfnetlink_queue: do shared-unconfirmed check before segmentation
      selftests: netfilter: nft_queue.sh: add udp fraglist gro test case
      selftests: netfilter: add IPV6_TUNNEL to config
      netfilter: nft_set_hash: fix get operation on big endian

Francesco Dolcini (1):
      net: fec: Add stop mode support on i.MX8DX/i.MX8QP

Frank Li (1):
      dt-bindings: net: dsa: microchip: Make pinctrl 'reset' optional

Gal Pressman (8):
      net/mlx5e: TSO for GRE over vlan
      net/mlx5e: TSO for UDP over GRE over vlan packets
      net/mlx5e: Remove GSO_PARTIAL for non _CSUM GRE
      ethtool: Clarify len/n_stats fields in/out semantics
      selftests: net: fix wrong boolean evaluation in __exit__
      udp: gso: Use single MSS length in UDP header for GSO_PARTIAL
      net/mlx5e: Remove redundant UDP length adjustment with GSO_PARTIAL
      net: aquantia: Remove redundant UDP length adjustment with GSO_PARTIAL

Geetha sowjanya (2):
      octeontx2-af: Workaround SQM/PSE stalls by disabling sticky
      octeontx2-pf: cn10k/cn20k: Update count_eot in NPA_LF_AURA_BATCH_FREE0

Geliang Tang (7):
      mptcp: add eat_recv_skb helper
      mptcp: implement .read_sock
      tcp: export tcp_splice_state
      mptcp: implement .splice_read
      selftests: mptcp: add splice io mode
      selftests: mptcp: connect: cover splice mode
      mptcp: allow overridden write_space to be invoked

Gerd Rausch (7):
      net/rds: No shortcut out of RDS_CONN_ERROR
      net/rds: rds_tcp_accept_one ought to not discard messages
      net/rds: Encode cp_index in TCP source port
      net/rds: rds_tcp_conn_path_shutdown must not discard messages
      net/rds: Kick-start TCP receiver after accept
      net/rds: Use the first lane until RDS_EXTHDR_NPATHS arrives
      net/rds: Trigger rds_send_ping() more than once

Grzegorz Nitka (1):
      ice: unify PHY FW loading status handler for E800 devices

Gustavo A. R. Silva (1):
      ipv4/inet_sock.h: Avoid thousands of -Wflex-array-member-not-at-end warnings

Hariprasad Kelam (1):
      octeontx2-pf: Unregister devlink on probe failure

Harsh Kumar Bijlani (14):
      wifi: ath12k: Move HTT code in dp.h to newly introduced files
      wifi: ath12k: Move HTT Rx specific code to newly introduced files
      wifi: ath12k: Move HTT Tx specific code to newly introduced files
      wifi: ath12k: Move HTT specific code from dp.c to newly introduced files
      wifi: ath12k: Refactor ath12k_vif structure
      wifi: ath12k: Move DP related functions from peer.c to dp_peer.c file
      wifi: ath12k: Rename ath12k_peer to ath12k_dp_link_peer
      wifi: ath12k: Add hash table for ath12k_link_sta in ath12k_base
      wifi: ath12k: Move ath12k_dp_link_peer list from ath12k_base to ath12k_dp
      wifi: ath12k: Add hash table for ath12k_dp_link_peer
      wifi: ath12k: Define ath12k_dp_peer structure & APIs for create & delete
      wifi: ath12k: Attach and detach ath12k_dp_link_peer to ath12k_dp_peer
      wifi: ath12k: Use ath12k_dp_peer in per packet Tx & Rx paths
      wifi: ath12k: Move DP specific link stats to DP link peer

Heiner Kallweit (11):
      net: phy: realtek: add dummy PHY driver for RTL8127ATF
      r8169: add support for RTL8127ATF (Fiber SFP)
      net: phy: fixed_phy: replace list of fixed PHYs with static array
      net: phy: fixed_phy: replace IDA with a bitmap
      net: ethernet: dnet: remove driver
      net: phy: remove unused fixup unregistering functions
      net: phy: simplify PHY fixup registration
      r8169: remove optional size argument in calls to strscpy
      net: ethernet: adi: make name member of struct adin1110_cfg a pointer
      net: dsa: loop: remove MDIO device modalias
      net: phy: remove modalias-based mdio bus matching

Hsiu-Ming Chang (1):
      wifi: rtw88: rtw8821cu: Add ID for Mercusys MU6H

Huacai Chen (2):
      net: stmmac: Fix typo from clk_scr_i to clk_csr_i
      net: stmmac: dwmac-loongson: Set clk_csr_i to 100-150MHz

Huang Chenming (1):
      wifi: cfg80211: Fix use_for flag update on BSS refresh

Håkon Bugge (1):
      net/rds: Clear reconnect pending bit

Ian MacDonald (1):
      net: thunderbolt: Allow reading link settings

Ido Schimmel (5):
      selftests: fib-onlink: Remove "wrong nexthop device" IPv4 tests
      selftests: fib-onlink: Remove "wrong nexthop device" IPv6 tests
      selftests: fib-onlink: Add a test case for IPv4 multicast gateway
      ipv6: Allow for nexthop device mismatch with "onlink"
      selftests: fib-onlink: Add test cases for nexthop device mismatch

Ilan Peer (6):
      wifi: iwlwifi: mld: Add support for NAN
      wifi: iwlwifi: mld: Handle rate selection for NAN interface
      wifi: iwlwifi: mld: Declare support for NAN capabilities
      wifi: iwlwifi: mld: Extend the NAN configuration
      wifi: iwlwifi: mld: Support changing NAN configuration
      wifi: iwlwifi: mld: Advertise support for multicast RX registration

Ilpo Järvinen (2):
      tcp: try to avoid safer when ACKs are thinned
      gro: flushing when CWR is set negatively affects AccECN

Ingyu Jang (1):
      wifi: brcmsmac: phy: Remove unreachable error handling code

Ivan Vecera (14):
      dpll: add dpll_device op to get supported modes
      dpll: add dpll_device op to set working mode
      dpll: zl3073x: Implement device mode setting support
      dpll: expose fractional frequency offset in ppt
      dpll: Allow associating dpll pin with a firmware node
      dpll: zl3073x: Associate pin with fwnode handle
      dpll: Support dynamic pin index allocation
      dpll: zl3073x: Add support for mux pin type
      dpll: Enhance and consolidate reference counting logic
      dpll: Add reference count tracking support
      drivers: Add support for DPLL reference count tracking
      dpll: zl3073x: Fix output pin phase adjustment sign
      dpll: zl3073x: Add output pin frequency helper
      dpll: zl3073x: Include current frequency in supported frequencies list

Jacky Chou (1):
      net: ftgmac100: Use devm_mdiobus_alloc/devm_of_mdiobus_register

Jacob Keller (5):
      ice: pass pointer to ice_fetch_u64_stats_per_ring
      ice: remove ice_q_stats struct and use struct_group
      ice: use u64_stats API to access pkts/bytes in dim sample
      ice: shorten ring stat names and add accessors
      ice: convert all ring stats to u64_stats_t

Jacopo Scannella (1):
      Bluetooth: btusb: Add device ID for Realtek RTL8761BU

Jakub Kicinski (141):
      Merge branch 'rust-net-replace-kernel-c_str-with-c-strings'
      selftests: hw-net: rss-input-xfrm: try to enable the xfrm at the start
      Merge branch 'net-discard-pm_runtime_put-return-value'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'support-for-hwtstamp_get-in-phy-part-2'
      Merge branch 'tools-ynl-clean-up-pylint-issues'
      selftests: tls: avoid flakiness in data_steal
      selftests: drv-net: gro: increase the rcvbuf size
      selftests: forwarding: update PTP tcpdump patterns
      Merge branch 'mlx5-add-tso-support-for-udp-over-gre-over-vlan'
      Merge branch 'net-convert-drivers-to-get_rx_ring_count'
      selftests: net: py: capitalize defer queue and improve import
      selftests: net: py: ensure defer() is only used within a test case
      Merge branch 'bnxt_en-updates-for-net-next'
      tools: ynl: cli: introduce formatting for attr names in --list-attrs
      tools: ynl: cli: wrap the doc text if it's long
      tools: ynl: cli: improve --help
      tools: ynl: cli: add --doc as alias to --list-attrs
      tools: ynl: cli: factor out --list-attrs / --doc handling
      tools: ynl: cli: extract the event/notify handling in --list-attrs
      tools: ynl: cli: print reply in combined format if possible
      Merge branch 'tools-ynl-cli-improve-the-help-and-doc'
      Merge tag 'wireless-next-2026-01-12' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'net-stmmac-cleanups-and-low-priority-fixes'
      Merge branch 'add-dwmac-glue-driver-for-motorcomm-yt6801'
      Merge branch 'r8169-add-support-for-rtl8127atf-10g-fiber-sfp'
      Merge branch 'net-stmmac-pcs-clean-up-pcs-interrupt-handling'
      Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux
      selftests: net: py: teach ksft_pr() multi-line safety
      selftests: net: py: teach cmd() how to print itself
      selftests: drv-net: gro: use cmd print
      selftests: drv-net: gro: improve feature config
      selftests: drv-net: gro: run the test against HW GRO and LRO
      selftests: drv-net: gro: break out all individual test cases
      Merge branch 'selftests-drv-net-gro-enable-hw-gro-and-lro-testing'
      net: reduce indent of struct netdev_queue_mgmt_ops members
      eth: bnxt: adjust the fill level of agg queues with larger buffers
      Merge branch 'net-phy-introduce-phy-ports-representation'
      Merge branch 'ipv6-allow-for-nexthop-device-mismatch-with-onlink'
      Merge branch 'net-phy-fixed_phy-replace-list-of-fixed-phys-with-static-array'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge tag 'phy_common_properties' of git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy
      Merge branch 'net-phy-adin-enable-configuration-of-the-lp-termination-register'
      Merge branch 'net-airoha-init-block-ack-memory-region-for-mt7996-npu-offloading'
      Merge branch 'net-pcs-rzn1-miic-support-configurable-phy_link-polarity'
      Merge branch 'uapi-use-uapi-definitions-of-int_max-and-int_min'
      Merge branch 'net-phy-realtek-simplify-and-reunify-c22-c45-drivers'
      Merge branch 'selftests-net-improve-error-handling-in-passive-tfo-test'
      Merge branch 'net-convert-drivers-to-get_rx_ring_count-part-2'
      Merge branch 'ipv6-more-data-race-annotations'
      Merge branch 'dsa-mxl-gsw1xx-support-r-g-mii-slew-rate-configuration'
      Merge branch 'dpll-support-mode-switching'
      Merge branch 'net-thunderbolt-various-improvements'
      Merge branch 'net-mlx5e-save-per-channel-async-icosq-in-default'
      Revert "Merge branch 'netkit-support-for-io_uring-zero-copy-and-af_xdp'"
      Merge tag 'net-queue-rx-buf-len-v9' of https://github.com/isilence/linux
      Merge branch 'eth-fbnic-update-ipc-mailbox-support'
      Merge branch 'convert-the-micrel-bindings-to-dt-schema'
      selftests: drv-net: fix missing include in ncdevmem
      net: add kdoc for napi_consume_skb()
      Merge branch 'fix-typos-in-network-driver-code-comments'
      Merge branch 'add-devm_clk_bulk_get_optional_enable-helper-and-use-in-axi-ethernet-driver'
      Merge branch 'netconsole-support-automatic-target-recovery'
      Merge branch 'airoha-add-the-capability-to-read-firmware-binary-names-from-dts-for-airoha-npu-driver'
      Merge branch 'gro-inline-tcp6_gro_-receive-complete'
      Merge branch 'phy-polarity-inversion-via-generic-device-tree-properties'
      Merge branch 'phylink-link-callback-replay-helpers-for-sja1105-and-xpcs'
      Merge tag 'nf-next-26-01-20' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge tag 'nf-next-26-01-22' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge branch 'net-stmmac-dwmac-enforce-preamble-before-sfd-for-i-mx8mp'
      Merge branch 'tcp-remove-tcp_rate-c'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'net-convert-drivers-to-get_rx_ring_count-last-part'
      Merge branch 'geneve-introduce-double-tunnel-gso-gro-support'
      Merge branch 'selftest-extend-tun-virtio-coverage-for-gso-over-udp-tunnel'
      eth: bnxt: always set the queue mgmt ops
      net: introduce a trivial netdev_queue_config()
      net: move mp->rx_page_size validation to __net_mp_open_rxq()
      net: use netdev_queue_config() for mp restart
      net: add queue config validation callback
      eth: bnxt: plug bnxt_validate_qcfg() into qops
      Merge branch 'net-restore-the-structure-of-driver-facing-qcfg-api'
      Merge branch 'net-rds-rds-tcp-state-machine-and-message-loss-improvements'
      Merge branch 'u64_stats-introduce-u64_stats_copy'
      Merge branch 'net-few-critical-helpers-are-inlined-again'
      Merge branch 'net-neighbour-notify-changes-atomically'
      Merge branch '200GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'code-clean-up'
      Merge branch 'net-stmmac-rk-simplify-per-soc-configuration'
      Merge branch 'remove-low-level-sha-1-functions'
      Merge branch 'single-mss-length-in-udp-gso_partial'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'tcp-make-tcp_ack-faster'
      Merge branch 'tcp-tcp_tx_timestamp-fix'
      Merge tag 'for-net-next-2026-01-29' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'net-stmmac-report-active-phy-interface'
      Merge branch 'net-stmmac-rk-second-chunk-of-cleanups'
      Merge branch 'net-hinic3-fix-code-styles'
      eth: bnxt: make sure we populate the qcfg defaults on old FW/HW
      Merge branch 'airoha-an8811hb-2-5-gbps-phy-support'
      Merge tag 'wireless-next-2026-01-29' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'bng_en-enhancements-for-rx-and-tx-datapath'
      Merge branch 'eth-fbnic-add-debugfs-for-mbx-and-tx-rx'
      Merge branch 'net-wwan-add-nmea-port-type-support'
      Merge tag 'linux-can-next-for-6.20-20260131' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
      selftests: drv-net: rss: validate min RSS table size
      docs: networking: mention that RSS table should be 4x the queue count
      tools: ynl: cli: make the output compact
      Merge branch 'net-phy-dp83867-always-program-r-sgmii-enable-bits'
      Merge branch 'ipv6-misc-changes-in-output-path'
      Merge branch 'ptp-vmclock-add-vm-generation-counter-and-acpi-notification'
      Merge branch 'mptcp-implement-read_sock-and-splice_read'
      Merge branch 'add-support-for-renesas-rz-g3l-gbeth'
      Merge branch 'net-stmmac-pcs-preparation'
      Merge branch 'devlink-and-mlx5-support-cross-function-rate-scheduling'
      Merge branch 'net-stmmac-rk-cleanups-v3-mode-and-speed-for-most'
      Merge branch 'net-ethernet-renesas-rcar_gen4_ptp-hide-private-data'
      Merge branch 'stp-rstp-switch-support-for-pru-icssm-ethernet-driver'
      Merge branch 's32g-use-a-syscon-for-gpr'
      Merge branch 'mptcp-misc-features-for-v6-20-7-0'
      Merge tag 'wireless-next-2026-02-04' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'net-rds-rds-tcp-protocol-and-extension-improvements'
      Merge branch 'net-stmmac-fix-serdes-power-methods'
      Merge branch 'net-mlx5e-rx-datapath-enhancements'
      Merge branch 'net-stmmac-rk-final-cleanups-part'
      Merge branch 'tcp-remove-net-core-request_sock-c-and-no-longer-inline-__reqsk_free'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'net-cpsw_new-fix-multiple-issues-in-the-cpsw_probe-error-path'
      Merge branch 'mptcp-misc-fixes-for-v6-19-rc8'
      Merge branch 'dpll-zl3073x-include-current-frequency-in-supported-frequencies-list'
      Merge branch 'big-tcp-without-hbh-in-ipv6'
      eth: bnxt: gather and report HW-GRO stats
      tools: ynltool: factor out qstat dumping
      tools: ynltool: add qstats analysis for HW-GRO efficiency / savings
      Merge branch 'net-stats-tools-driver-tests-for-hw-gro'
      Merge branch 'net-netconsole-convert-to-nbcon-console-infrastructure'
      Merge branch 'bnxt_en-add-rss-context-resource-check'
      Merge tag 'nf-next-26-02-06' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge branch 'ipv6-tcp-no-longer-rebuild-fl6-at-each-transmit'

Jan Gerber (1):
      wifi: rtw89: 8852au: add support for TP TX30U Plus

Jan Hoffmann (1):
      net: phy: realtek: fix in-band capabilities for 2.5G PHYs

Jason Xing (2):
      xsk: advance cq/fq check when shared umem is used
      xsk: move cq_cached_prod_lock to avoid touching a cacheline in sending path

Javen Xu (3):
      r8169: add DASH support for RTL8127AP
      r8169: enable LTR support
      r8169: add support for extended chip version id and RTL9151AS

Jeff Johnson (1):
      Merge branch 'ath12k-ng' into ath-next

Jia-Hong Su (1):
      Bluetooth: hci_uart: fix null-ptr-deref in hci_uart_write_work

Jian Shen (1):
      net: hns3: fix double free issue for tx spare buffer

Jian Zhang (1):
      net: mctp-i2c: fix duplicate reception of old data

Jianpeng Chang (1):
      Bluetooth: MGMT: Fix memory leak in set_ssp_complete

Jiawen Wu (1):
      net: libwx: remove unused rx_buffer_pgcnt

Jiayuan Chen (3):
      net: atm: fix crash due to unvalidated vcc pointer in sigd_send()
      xfrm: fix ip_rt_bug race in icmp_route_lookup reverse path
      serial: caif: fix use-after-free in caif_serial ldisc_close()

Jijie Shao (2):
      net: hns3: extend HCLGE_FD_AD_QID to 11 bits
      net: hns3: extend HCLGE_FD_AD_COUNTER_NUM to 8 bits

Jinjie Ruan (1):
      netfilter: xt_time: use is_leap_year() helper

Jinseok Kim (1):
      net: sxgbe: fix typo in comment

Joe Damato (1):
      bnxt_en: Allow ntuple filters for drops

Johannes Berg (22):
      Merge tag 'ath-next-20260105' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      wifi: mac80211: unexport ieee80211_get_bssid()
      wifi: mac80211: improve interface iteration ergonomics
      wifi: mac80211: improve station iteration ergonomics
      wifi: mac80211_hwsim: remove NAN by default
      Merge tag 'rtw-next-2026-01-15' of https://github.com/pkshih/rtw
      wifi: mac80211: remove RX_DROP
      wifi: mac80211: mark iface work SKBs as consumed
      wifi: iwlwifi: fix 22000 series SMEM parsing
      wifi: iwlwifi: adjust LINK context NPCA API
      wifi: iwlwifi: add UHR TLC mode
      wifi: iwlwifi: fw: api: add UHR data definitions
      wifi: iwlwifi: mld: fix HE SIG-B MCS/DCM/compression
      wifi: iwlwifi: fw: api: add HE type for UHR ELR
      wifi: iwlwifi: cfg: remove iwl_be221_name
      Merge tag 'ath-next-20260120' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      Merge tag 'iwlwifi-next-2026-01-21' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next
      Merge tag 'rtw-next-2026-01-30' of https://github.com/pkshih/rtw
      wifi: ieee80211: add some initial UHR definitions
      wifi: cfg80211: add initial UHR support
      wifi: mac80211: add initial UHR support
      Merge tag 'ath-next-20260202' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Jonas Köppeler (2):
      net/sched: sch_cake: share shaper state across sub-instances of cake_mq
      selftests/tc-testing: add selftests for cake_mq qdisc

Jose Ignacio Tornos Martinez (1):
      wifi: rtw89: 8922a: set random mac if efuse contains zeroes

Joshua Hay (2):
      idpf: move some iterator declarations inside for loops
      idpf: remove vport pointer from queue sets

Junjie Cao (2):
      selftests: ptp: use KSFT_SKIP exit code for skip scenarios
      selftests: ptp: treat unsupported PHC operations as skip

Justin Chen (2):
      net: bcmasp: clean up some legacy logic
      net: bcmasp: streamline early exit in probe

Kavita Kavita (5):
      wifi: cfg80211: add support for key configuration before association
      wifi: mac80211: allow key installation before association
      wifi: mac80211: Check for MLE before appending in Authentication frame
      wifi: mac80211: add support for EPPKE authentication protocol in non-AP STA mode
      wifi: mac80211: add support for encryption/decryption of (Re)Association frames

Kevin Hao (6):
      net: macb: Replace open-coded device config retrieval with of_device_get_match_data()
      net: cpsw_new: Fix unnecessary netdev unregistration in cpsw_probe() error path
      net: cpsw_new: Fix potential unregister of netdev that has not been registered yet
      net: ti: icssg: Remove dedicated workqueue for ndo_set_rx_mode callback
      net: ti: icssg-prueth: Add optional dependency on HSR
      net: macb: Fix tx/rx malfunction after phy link down and up

Kiran Venkatappa (13):
      wifi: ath12k: Restructure PCI code to common and Wi-Fi 7 specific logic
      wifi: ath12k: Move Copy Engine configuration to Wi-Fi 7 specific file
      wifi: ath12k: Move Wi-Fi 7 WMI configuration to dedicated file
      wifi: ath12k: Move Wi-Fi 7 MHI configuration to dedicated file
      wifi: ath12k: Rename hw.c to Wi-Fi 7 specific implementation file
      wifi: ath12k: Rename ahb_hif_ops to reflect generic usage
      wifi: ath12k: Restructure ahb.c into common and Wi-Fi 7 specific modules
      wifi: ath12k: Move Wi-Fi 7 specific init routines to dedicated file
      wifi: ath12k: Move hw_init invocation to target-specific probe
      wifi: ath12k: Modularize driver into common and Wi-Fi 7 specific components
      wifi: ath12k: Rename ath12k_* symbols to ath12k_wifi7_* for clarity
      wifi: ath12k: Remove HAL defines from shared PCI code
      wifi: ath12k: Remove HAL define dependencies from shared AHB code

Krzysztof Kozlowski (12):
      dt-bindings: net: wireless: ath11k: Combine two if:then: clauses
      dt-bindings: bluetooth: qcom,qca2066-bt: Split to separate schema
      dt-bindings: bluetooth: qcom,qca9377-bt: Split to separate schema
      dt-bindings: bluetooth: qcom,qca6390-bt: Split to separate schema
      dt-bindings: bluetooth: qcom,wcn3950-bt: Split to separate schema
      dt-bindings: bluetooth: qcom,wcn3990-bt: Split to separate schema
      dt-bindings: bluetooth: qcom,wcn6750-bt: Split to separate schema
      dt-bindings: bluetooth: qcom,wcn6750-bt: Deprecate old supplies
      dt-bindings: bluetooth: qcom,wcn6855-bt: Split to separate schema
      dt-bindings: bluetooth: qcom,wcn6855-bt: Deprecate old supplies
      dt-bindings: bluetooth: qcom,wcn7850-bt: Split to separate schema
      dt-bindings: bluetooth: qcom,wcn7850-bt: Deprecate old supplies

Kuan-Chung Chen (6):
      wifi: rtw89: 8852b: increase beacon loss to 6 seconds
      wifi: rtw89: mlo: fix missing TX null-data 1 during link switch
      wifi: rtw89: mlo: fix incorrect link address in management frames
      wifi: rtw89: define TX/RX aggregation and MPDU capability per chip
      wifi: rtw89: fix potential zero beacon interval in beacon tracking
      wifi: rtw89: support EHT GI/LTF setting

Kunihiko Hayashi (1):
      net: ethernet: ave: Remove unnecessary 'out of memory' message

Kuniyuki Iwashima (3):
      ipv4: fib: Annotate access to struct fib_alias.fa_state.
      ipv4: Use EXPORT_IPV6_MOD_GPL() for ip_fib_metrics_init().
      af_unix: Fix memleak of newsk in unix_stream_connect().

Lachlan Hodges (3):
      wifi: cfg80211: include S1G_NO_PRIMARY flag when sending channel
      wifi: cfg80211: don't apply HT flags to S1G channels
      wifi: mac80211: correct ieee80211-{s1g/eht}.h include guard comments

Lad Prabhakar (6):
      dt-bindings: can: renesas,rcar-canfd: Specify reset-names
      dt-bindings: can: renesas,rcar-canfd: Document RZ/V2H(P) and RZ/V2N SoCs
      dt-bindings: can: renesas,rcar-canfd: Document RZ/T2H and RZ/N2H SoCs
      can: rcar_canfd: Add RZ/T2H support
      dt-bindings: net: pcs: renesas,rzn1-miic: Add phy_link property
      net: pcs: rzn1-miic: Add PHY_LINK active-level configuration support

Linmao Li (3):
      Bluetooth: hci_core: Export hci_discovery_active
      Bluetooth: btusb: Reject autosuspend if discovery is active
      Bluetooth: btusb: Remove duplicate entry for 0x13d3/0x3618

Lorenzo Bianconi (12):
      net: airoha: npu: Dump fw version during probe
      net: airoha: Use gdm port enum value whenever possible
      dt-bindings: net: airoha: npu: Add BA memory region
      net: airoha: npu: Init BA memory region if provided via DTS
      dt-bindings: net: airoha: npu: Add firmware-name property
      net: airoha: npu: Add the capability to read firmware names from dts
      netfilter: Add ctx pointer in nf_flow_skb_encap_protocol/nf_flow_ip4_tunnel_proto signature
      netfilter: Introduce tunnel metadata info in nf_flowtable_ctx struct
      netfilter: flowtable: Add IP6IP6 rx sw acceleration
      netfilter: flowtable: Add IP6IP6 tx sw acceleration
      selftests: netfilter: nft_flowtable.sh: Add IP6IP6 flowtable selftest
      wifi: mac80211: Add eMLSR/eMLMR action frame parsing support

Luiz Augusto von Dentz (4):
      Bluetooth: hci_conn: Fix using conn->le_{tx,rx}_phy as supported PHYs
      Bluetooth: L2CAP: Add support for setting BT_PHY
      Bluetooth: Fix using PHYs bitfields as PHY value
      Bluetooth: L2CAP: Fix not tracking outstanding TX ident

Lukas Bulwahn (1):
      MAINTAINERS: remove obsolete file entry in NETWORKING DRIVERS

Mahdi Faramarzpour (1):
      udp: add drop count for packets in udp_prod_queue

Manish Dharanenthiran (1):
      wifi: cfg80211: add cfg80211_stop_link() for per-link teardown

Marc Kleine-Budde (4):
      Merge patch series "Add FD-Only mode support for R-Car CANFD"
      Merge patch series "Add CANFD support to R9A09G056/057/077/087 SoCs"
      can: sja1000: sja1000_err(): make use of sja1000_get_berr_counter() to read error counters
      Merge patch series "can: sja1000: clean up CAN state handling"

Marco Crivellari (4):
      wifi: rtw89: add WQ_PERCPU to alloc_workqueue users
      hinic3: add WQ_PERCPU to alloc_workqueue users
      wifi: rtw88: add WQ_PERCPU to alloc_workqueue users
      ovpn: Replace use of system_wq with system_percpu_wq

Marek Behún (1):
      net: sfp: add quirk for Lantech 8330-265D

Mark Bloch (2):
      net/mlx5: fs, factor out flow counter bulk init
      net/mlx5: fs, split bulk init

Martin Hrůza (1):
      wifi: rtw88: Increase the RX gain before scanning

Matt Johnston (1):
      mctp i2c: initialise event handler read bytes

Matthieu Baerts (NGI0) (13):
      mptcp: pm: align endpoint flags size with the NL specs
      selftests: mptcp: diag: sort all #include
      selftests: mptcp: join: wait for estab event instead of MPJ
      selftests: mptcp: join: fix wait_mpj helper
      selftests: mptcp: join: userspace: wait for new events
      selftests: mptcp: join chk_stale_nr: avoid dup stats
      selftests: mptcp: join: avoid declaring i if not used
      selftests: mptcp: connect cleanup TFO setup
      selftests: mptcp: join: no SKIP mark for group checks
      mptcp: pm: in-kernel: always set ID as avail when rm endp
      mptcp: pm: in-kernel: clarify mptcp_pm_remove_anno_addr()
      mptcp: fix kdoc warnings
      selftests: mptcp: connect: fix maybe-uninitialize warn

Maxime Chevallier (14):
      dt-bindings: net: Introduce the ethernet-connector description
      net: ethtool: Introduce ETHTOOL_LINK_MEDIUM_* values
      net: phy: Introduce PHY ports representation
      net: phy: dp83822: Add support for phy_port representation
      dt-bindings: net: dp83822: Deprecate ti,fiber-mode
      net: phy: Create a phy_port for PHY-driven SFPs
      net: phy: Introduce generic SFP handling for PHY drivers
      net: phy: marvell-88x2222: Support SFP through phy_port interface
      net: phy: marvell: Support SFP through phy_port interface
      net: phy: marvell10g: Support SFP through phy_port
      net: phy: at803x: Support SFP through phy_port interface
      net: phy: qca807x: Support SFP through phy_port interface
      net: phy: Only rely on phy_port for PHY-driven SFP
      Documentation: networking: Document the phy_port infrastructure

Mengshi Wu (2):
      Bluetooth: hci_qca: Refactor HFP hardware offload capability handling
      Bluetooth: hci_qca: Enable HFP hardware offload for WCN6855 and WCN7850

Miaoqing Pan (3):
      wifi: ath12k: fix PCIE_LOCAL_REG_QRTR_NODE_ID definition for QCC2072
      wifi: ath11k: add usecase firmware handling based on device compatible
      dt-bindings: net: wireless: ath11k-pci: deprecate 'firmware-name' property

Michael Chan (6):
      bnxt_en: Update FW interface to 1.10.3.151
      bnxt_en: Add support for FEC bin histograms
      bnxt_en: Use a larger RSS indirection table on P5_PLUS chips
      bnxt_en: Implement ethtool_ops -> get_link_ext_state()
      bnxt_en: Refactor bnxt_need_reserve_rings()
      bnxt_en: Check RSS contexts in bnxt_need_reserve_rings()

Michael Dege (1):
      net: renesas: rswitch: fix forwarding offload statemachine

Michael Tretter (1):
      can: sja1000: sja1000_err(): use error counter for error state

Michal Swiatkowski (1):
      ice: use netif_get_num_default_rss_queues()

Mika Westerberg (3):
      net: thunderbolt: Allow changing MAC address of the device
      net: ethtool: Add support for 80Gbps speed
      bonding: 3ad: Add support for SPEED_80000

Mike Marciniszyn (Meta) (2):
      eth fbnic: Add debugfs hooks for firmware mailbox
      eth fbnic: Add debugfs hooks for tx/rx rings

Mingj Ye (1):
      net: usb: r8152: fix transmit queue timeout

Miri Korenblit (13):
      wifi: mac80211: don't send an unused argument to ieee80211_check_combinations
      wifi: mac80211: remove width argument from ieee80211_parse_bitrates
      wifi: cfg80211: allow only one NAN interface, also in multi radio
      wifi: cfg80211: stop NAN and P2P in cfg80211_leave
      wifi: cfg80211: limit NAN func management APIs to offloaded DE
      wifi: cfg80211: cleanup cluster_id when stopping NAN
      wifi: nl80211: ignore cluster id after NAN started
      wifi: iwlwifi: mvm: check the validity of noa_len
      wifi: iwlwifi: mld: support TLC command version 6
      wifi: iwlwifi: cfg: move the MODULE_FIRMWARE to the per-rf file
      wifi: iwlwifi: mld: fix chandef start calculation
      wifi: iwlwifi: mld: add an helper to update an EMLSR blocker
      wifi: iwlwifi: mld: prevent EMLSR when NAN is active

Mohsin Bashir (5):
      eth: fbnic: Use GFP_KERNEL to allocting mbx pages
      eth: fbnic: Allocate all pages for RX mailbox
      eth: fbnic: Reuse RX mailbox pages
      eth: fbnic: Remove retry support
      eth: fbnic: Update RX mbox timeout value

Moshe Shemesh (2):
      net/mlx5: Initialize bulk for single flow counters
      net/mlx5: Support devlink port state for host PF

Naga Bhavani Akella (1):
      Bluetooth: hci_sync: Add LE Channel Sounding HCI Command/event structures

Nidhish A N (3):
      wifi: iwlwifi: mld: Fix primary link selection logic
      wifi: iwlwifi: mvm: Cleanup MLO code
      wifi: iwlwifi: mvm: Remove link_id from time_events

Niklas Söderlund (4):
      net: ethernet: renesas: rcar_gen4_ptp: Move address assignment
      net: ethernet: renesas: rcar_gen4_ptp: Add helper to get clock index
      net: ethernet: renesas: rcar_gen4_ptp: Add helper to read time
      net: ethernet: renesas: rcar_gen4_ptp: Hide private data from users

Nimrod Oren (1):
      selftests: drv-net: rss_flow_label: skip unsupported devices

Oliver Hartkopp (7):
      can: use skb hash instead of private variable in headroom
      can: add CAN skb extension infrastructure
      can: move ifindex to CAN skb extensions
      can: move frame_len to CAN skb extensions
      can: remove private CAN skb headroom infrastructure
      can: gw: use can_gw_hops instead of sk_buff::csum_start
      net: skb: allow up to 8 skb extension ids

Or Har-Toov (4):
      net/mlx5: Add max_tx_speed and its CAP bit to IFC
      net/mlx5: Propagate LAG effective max_tx_speed to vports
      net/mlx5: Handle port and vport speed change events in MPESW
      net/mlx5: Add support for querying bond speed

Osose Itua (2):
      dt-bindings: net: adi,adin: document LP Termination property
      net: phy: adin: enable configuration of the LP Termination Register

Pablo Neira Ayuso (8):
      netfilter: nf_tables: add .abort_skip_removal flag for set types
      netfilter: nft_set_rbtree: translate rbtree to array for binary search
      netfilter: nft_set_rbtree: use binary search array in get command
      netfilter: nft_set_rbtree: remove seqcount_rwlock_t
      netfilter: nft_set_rbtree: fix bogus EEXIST with NLM_F_CREATE with null interval
      netfilter: nft_set_rbtree: check for partial overlaps in anonymous sets
      netfilter: nft_set_rbtree: validate element belonging to interval
      netfilter: nft_set_rbtree: validate open interval overlap

Pagadala Yesu Anjaneyulu (3):
      wifi: iwlwifi: fw: fix documentation reference for ap_type field
      wifi: iwlwifi: mld: refactor AP power type setting
      wifi: cfg80211: treat deprecated INDOOR_SP_AP_OLD control value as LPI mode

Paolo Abeni (42):
      Merge branch 'net-dsa-microchip-adjust-ptp-handling-to-ease-ksz8463-integration'
      Merge branch 'net-phy-realtek-various-improvements-for-2-5ge-phys'
      Merge branch 'r8169-add-dash-and-ltr-support'
      Merge branch 'multi-queue-aware-sch_cake'
      Merge branch 'net-rds-rds-tcp-bug-fix-collection-subset-1-work-queue-scalability'
      Merge branch 'xsk-move-cq_cached_prod_lock'
      Merge branch 'introduce-and-use-netif_xmit_timeout_ms-helper'
      Merge branch 'net-mlx5-hws-single-flow-counter-support'
      Merge branch 'net-hinic3-pf-initialization'
      Merge branch 'netkit-support-for-io_uring-zero-copy-and-af_xdp'
      t Merge branch 'a-series-of-minor-optimizations-of-the-bonding-module'
      net: introduce mangleid_features
      geneve: expose gso partial features for tunnel offload
      vxlan: expose gso partial features for tunnel offload
      geneve: add netlink support for GRO hint
      geneve: constify geneve_hlen()
      geneve: pass the geneve device ptr to geneve_build_skb()
      geneve: add GRO hint output path
      geneve: extract hint option at GRO stage
      geneve: use GRO hint option in the RX path
      selftests: net: tests for add double tunneling GRO/GSO
      Merge branch 'vsock-add-namespace-support-to-vhost-vsock-and-loopback'
      Merge branch 'net-dsa-lantiq-add-support-for-intel-gsw150'
      Merge branch 'extend-bit-width-in-the-flow-director-of-hns3-driver'
      Merge tag 'nf-next-26-01-29' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge branch 'net-phy-remove-modalias-based-mdio-device-bus-matching'
      Merge branch 'net-dsa-yt921x-add-dcb-qos-support'
      Merge branch 'accecn-protocol-case-handling-series'
      mptcp: do not account for OoO in mptcp_rcvbuf_grow()
      mptcp: fix receive space timestamp initialization
      mptcp: consolidate rcv space init
      trace: mptcp: add mptcp_rcvbuf_grow tracepoint
      Merge branch 'move-can-skb-headroom-content-to-skb-extensions'
      Merge branch 'dpll-core-improvements-and-ice-e825-c-synce-support'
      Merge branch 'net-dsa-mxl-gsw1xx-setup-polarities-and-validate-chip'
      Merge branch 'net-fec-improve-xdp-copy-mode-and-add-af_xdp-zero-copy-support'
      Merge branch 'hsr-implement-more-robust-duplicate-discard-algorithm'
      Merge branch 'net-ftgmac100-various-probe-cleanups'
      Merge branch 'disable-interrupts-and-ensure-dbell-updation'
      xfrm: reduce struct sec_path size
      Merge branch 'net-dsa-initial-support-for-maxlinear-mxl862xx-switches'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

Pavan Chebbi (3):
      bnxt_en: Add PTP .getcrosststamp() interface to get device/host times
      bnxt_en: Defrag the NVRAM region when resizing UPDATE region fails
      bnxt_en: Fix build break on non-x86 platforms

Pavan Kumar Linga (8):
      idpf: introduce local idpf structure to store virtchnl queue chunks
      idpf: introduce idpf_q_vec_rsrc struct and move vector resources to it
      idpf: move queue resources to idpf_q_vec_rsrc structure
      idpf: reshuffle idpf_vport struct members to avoid holes
      idpf: add rss_data field to RSS function parameters
      idpf: generalize send virtchnl message API
      idpf: avoid calling get_rx_ptypes for each vport
      idpf: generalize mailbox API

Pavankumar Nandeshwar (46):
      wifi: ath12k: Move hal_tx and hal_rx to wifi7 directory
      wifi: ath12k: Move hal_tx.h file to wifi7 directory
      wifi: ath12k: Move hal_rx.h file to wifi7 directory
      wifi: ath12k: Move HAL Rx wrapper APIs to dp_rx.h
      wifi: ath12k: Move Rx error related functions to wifi7 directory
      wifi: ath12k: Move hal_desc.h file to wifi7 directory
      wifi: ath12k: Move rx_desc.h file to wifi7 directory
      wifi: ath12k: Move rxdma ring config functions to wifi7 directory
      wifi: ath12k: Move rx error and defrag functions to wifi7 directory
      wifi: ath12k: Move regular msdu processing functions to wifi7 directory
      wifi: ath12k: Move srng processing to wifi7 directory
      wifi: ath12k: Separate arch specific part of RX APIs
      wifi: ath12k: Move arch specific REO functions to wifi7 directory
      wifi: ath12k: Move arch specific rx tid and related functions to wifi7 directory
      wifi: ath12k: Move arch specific tx APIs to wifi7 directory
      wifi: ath12k: Move ath12k_dp_tx and related APIs to wifi7 directory
      wifi: ath12k: Remove non-compact TLV support from QCN
      wifi: ath12k: Replace ops with direct calls for rxdma ring mask
      wifi: ath12k: Move hal_rx_ops callbacks to hal_ops
      wifi: ath12k: Add new infra for the rx path
      wifi: ath12k: Change the API prefixes to ath12k_wifi7 in tx/rx
      wifi: ath12k: Move srng config and hal_ops to hw specific hal files
      wifi: ath12k: Initialize desc_size through hal_init
      wifi: ath12k: Initialize hal_ops through hal_init
      wifi: ath12k: Move wbm_rbm_map to hw specific hal files
      wifi: ath12k: Move hal_params and regs to hal from hw
      wifi: ath12k: Add direct HAL pointer in ath12k_dp
      wifi: ath12k: Use hal handle instead of ab handle
      wifi: ath12k: Move HAL CE setup and SRNG related APIs to wifi7 directory
      wifi: ath12k: Move HAL SRNG shadow config and get ring id APIs to wifi7 directory
      wifi: ath12k: Move HAL CE desc related APIs to wifi7 directory
      wifi: ath12k: Move HAL CE status and set link desc addr APIs to wifi7 directory
      wifi: ath12k: Move HAL Tx, REO and link idle setup related APIs to wifi7 directory
      wifi: ath12k: Move HAL REO and Rx buf related APIs to wifi7 directory
      wifi: ath12k: Move HAL Cookie Conversion and RBM related APIs to wifi7 directory
      wifi: ath12k: Segregate the common and wifi7 specific structures
      wifi: ath12k: Remove the unused ring inits in wcn
      wifi: ath12k: Add callbacks in arch_ops for rx APIs
      wifi: ath12k: Move DP device stats to ath12k_dp
      wifi: ath12k: Add helper to free DP link peer
      wifi: ath12k: Remove the wifi7 header inclusions in common code
      wifi: ath12k: Move ath12k_dp_rx_frags_cleanup API to Wi-Fi 7
      wifi: ath12k: Move ath12k_dp_rx_get_peer_id API to Wi-Fi 7
      wifi: ath12k: Remove arch-specific HAL dependencies from common DP
      wifi: ath12k: Build all the files in wifi7 directory into ath12k_wifi7.ko
      wifi: ath12k: Use dp objects in performance critical paths

Pavel Begunkov (7):
      net: memzero mp params when closing a queue
      net: add bare bone queue configs
      net: pass queue rx page size from memory provider
      eth: bnxt: store rx buffer size per queue
      eth: bnxt: support qcfg provided rx page size
      selftests: iou-zcrx: test large chunk sizes
      io_uring/zcrx: document area chunking parameter

Peter Åstrand (1):
      wifi: wlcore: Add support for IGTK key

Petr Machata (8):
      net: core: neighbour: Add a neigh_fill_info() helper for when lock not held
      net: core: neighbour: Call __neigh_notify() under a lock
      net: core: neighbour: Extract ARP queue processing to a helper function
      net: core: neighbour: Process ARP queue later
      net: core: neighbour: Inline neigh_update_notify() calls
      net: core: neighbour: Reorder netlink & internal notification
      net: core: neighbour: Make one netlink notification atomically
      net: core: neighbour: Make another netlink notification atomically

Petr Oros (1):
      dpll: Add notifier chain for dpll events

Ping-Ke Shih (58):
      wifi: rtw89: correct use sequence of driver_data in skb->info
      wifi: rtw89: mac: reset power state before switching to power on
      wifi: rtw89: warn unexpected polling value of XTAL SI
      wifi: rtw89: wow: change type of WoWLAN pattern mask to __le32
      wifi: rtw89: efuse: read hardware version from efuse for WiFi 7 chips
      wifi: rtw89: read chip ID for RTL8922D variants
      wifi: rtw89: add default quirks as features to chip_info
      wifi: rtw89: rfk: update RFK pre info V2 for RTL8922D
      wifi: rtw89: update TXWD v3 for RTL8922D
      wifi: rtw89: update query RXDESC v3 for RTL8922D
      wifi: rtw89: fw: add DMAC v3 H2C command for RTL8922D
      wifi: rtw89: fw: add CMAC H2C command to initialize default value for RTL8922D
      wifi: rtw89: fw: add CMAC H2C command for association for RTL8922D
      wifi: rtw89: fw: add CMAC H2C command for TX AMPDU for RTL8922D
      wifi: rtw89: fw: add CMAC H2C command for TX time for RTL8922D
      wifi: rtw89: fw: add CMAC H2C command for punctured for RTL8922D
      wifi: rtw89: fw: consider hardware AID for firmware elements
      wifi: rtw89: fw: set RACK bit every 4 H2C command for WiFi 6 chips only
      wifi: rtw89: coex: make coex scoreboard as chip info
      wifi: rtw89: coex: update scoreboard value according to power state for two BT
      wifi: rtw89: mac: remove unnecessary return from rtw89_fwdl_secure_idmem_share_mode()
      wifi: rtw89: mac: add dle_mem and ple_{min,max}_qt quota for RTL8922D
      wifi: rtw89: mac: set quota 13 for PLE SNRPT
      wifi: rtw89: mac: update MPDU quota according to chip DLE definition
      wifi: rtw89: mac: update WP quota for RTL8922D
      wifi: rtw89: mac: define preload_init for generations
      wifi: rtw89: mac: configure DMA_STOP1 by predefined mask
      wifi: rtw89: mac: separate functions of CMAC power and function enable
      wifi: rtw89: mac: add an entry to enable MAC function in preinit
      wifi: rtw89: mac: set EDCCA configurations for RTL8922D
      wifi: rtw89: pci: validate sequence number of TX release report
      wifi: rtw89: disable EHT protocol by chip capabilities
      wifi: rtw89: align CUSTID defined by firmware
      wifi: rtw89: mac: correct page number for CSI response
      wifi: rtw89: mac: consider RTL8922D in MAC common flow
      wifi: rtw89: pci: consider RTL8922D in PCI common flow
      wifi: rtw89: mac: clear global interrupt right after power-on
      wifi: rtw89: phy: add {read,write}_rf_v3 for RTL8922D
      wifi: rtw89: phy: add ops rtw89_phy_gen_be_v1 for RTL8922D
      wifi: rtw89: phy: abstract start address and EHT of PHY status bitmap
      wifi: rtw89: phy: abstract BB wrap registers to share initial flow
      wifi: rtw89: phy: update BB wrapper RFSI
      wifi: rtw89: phy: write BB wrapper registers with flush
      wifi: rtw89: phy: refine initial flow of BB wrapper
      wifi: rtw89: phy: add chip_ops to calculate RX gain from efuse to support PS mode
      wifi: rtw89: phy: add firmware element of digital TX power compensation
      wifi: rtw89: mac: clear DTOP disable excluding CID7090 variant for RTL8922D
      wifi: rtw89: mac: set force MBA duration to 0
      wifi: rtw89: rfk: add firmware command to do TX IQK
      wifi: rtw89: rfk: add to print debug log of TX IQK
      wifi: rtw89: rfk: add firmware command to do CIM3K
      wifi: rtw89: rfk: add to print debug log of CIM3K
      wifi: rtw89: rfk: update RFK report format of IQK, DACK and TXGAPK
      wifi: rtw89: fw: correct content of DACK H2C command
      wifi: rtw89: phy: add PHY C2H event dummy handler for func 1-7 and 2-10
      wifi: rtw89: pci: validate release report content before using for RTL8922DE
      wifi: rtw89: mac: set MU group membership and position to registers
      wifi: rtw89: pci: warn if SPS OCP happens for RTL8922DE

Po-Hao Huang (3):
      wifi: rtw89: phy: fix incorrect power limit by mac_id
      wifi: rtw89: fix unable to receive probe responses under MLO connection
      wifi: rtw89: 8922a: add digital compensation for 2GHz

Qian Zhang (1):
      wifi: ath11k: Fix failure to connect to a 6 GHz AP

Qiliang Yuan (1):
      netns: optimize netns cleaning by batching unhash_nsid calls

Qingfang Deng (2):
      ppp: enable TX scatter-gather
      netfilter: flowtable: dedicated slab for flow entry

Rafael J. Wysocki (3):
      net: ethernet: ti: am65-cpsw: Discard pm_runtime_put() return value
      net: cadence: macb: Discard pm_runtime_put() return value
      net: wan: framer: Discard pm_runtime_put() return values

Rafał Miłecki (1):
      wifi: brcmfmac: rename function that frees vif

Raju Rangoju (2):
      amd-xgbe: add support for rx alignment errors
      amd-xgbe: do not select NET_SELFTESTS when INET is disabled

Randy Dunlap (7):
      wifi: brcmfmac: fix/add kernel-doc comments
      sfc: correct kernel-doc complaints
      wifi: ath5k: debug.h: fix enum ath5k_debug_level kernel-doc
      wifi: ath9k: debug.h: fix kernel-doc bad lines and struct ath_tx_stats
      wifi: ath9k: fix kernel-doc warnings in common-debug.h
      wifi: wil6210: fix a bunch of kernel-doc warnings
      net/iucv: clean up iucv kernel-doc warnings

René Rebe (1):
      net: sunhme: Fix sbus regression

Ripan Deuri (16):
      wifi: ath12k: Move the hal APIs to hardware specific files
      wifi: ath12k: unify HAL ops naming across chips
      wifi: ath12k: Remove hal_rx_ops and merge into hal_ops
      wifi: ath12k: Convert ath12k_dp member in ath12k_base to pointer
      wifi: ath12k: Support arch-specific DP device allocation
      wifi: ath12k: Rearrange DP fields in ath12k_hw_group struct
      wifi: ath12k: Add framework for hardware specific ieee80211_ops registration
      wifi: ath12k: Add framework for hardware specific DP interrupt handler
      wifi: ath12k: Refactor data path pdev struct
      wifi: ath12k: Rearrange PPDU radio stats
      wifi: ath12k: Rename hal_ops to ops
      wifi: ath12k: Drop hal_ prefix from hardware register names
      wifi: ath12k: Add lockdep warn for RCU
      wifi: ath12k: Move ieee80211_ops callback to the arch specific module
      wifi: ath12k: Replace lock/unlock with guard()
      wifi: ath12k: Skip DP peer creation for scan vdev

Rob Herring (Arm) (1):
      dt-bindings: net: rockchip-dwmac: Allow "dma-coherent"

Robert Marko (2):
      dt-bindings: net: mscc-miim: add microchip,lan9691-miim
      dt-bindings: net: sparx5: do not require phys when RGMII is used

Roger Quadros (3):
      net: ti: icssm-prueth: Add helper functions to configure and maintain FDB
      net: ti: icssm-prueth: Add switchdev support for icssm_prueth driver
      net: ti: icssm-prueth: Add support for ICSSM RSTP switch

Rohit Chourasia (1):
      wifi: rtlwifi: fix typo 'received' in comment

Roman Peshkichev (1):
      wifi: rtw88: fix DTIM period handling when conf->dtim_period is zero

Rosen Penev (1):
      wifi: ath9k: add OF dependency to AHB

Ross Vandegrift (1):
      wifi: ath11k: add pm quirk for Thinkpad Z13/Z16 Gen1

Russell King (Oracle) (53):
      net: stmmac: dwmac4: remove duplicated definitions
      net: stmmac: dwmac4: fix RX FIFO fill statistics
      net: stmmac: dwmac4: fix PTP message type field extraction
      net: stmmac: descs: fix buffer 1 off-by-one error
      net: stmmac: descs: use u32 for descriptors
      net: stmmac: descs: remove many xxx_SHIFT definitions
      net: stmmac: cores: remove many xxx_SHIFT definitions
      net: stmmac: arrange register fields after register offsets
      net: stmmac: remove unused definitions
      net: stmmac: use BIT_U32() and GENMASK_U32() for PCS registers
      net: stmmac: move and rename dwmac_pcs_isr()
      net: stmmac: pass struct stmmac_priv to host_irq_status() method
      net: stmmac: change arguments to PCS handler and use dev_info()
      net: stmmac: report PCS link changes to phylink
      net: stmmac: fix dwmac4 transmit performance regression
      net: stmmac: rk: avoid phy_power_on()
      net: stmmac: rk: get rid of rk_phy_power_ctl()
      net: stmmac: rk: convert rk3328 to use bsp_priv->id
      net: stmmac: rk: group MACPHY register offset and fields together
      net: stmmac: don't pass ioaddr to fix_soc_reset() method
      net: stmmac: qcom-ethqos: remove mac_base
      net: stmmac: thead: avoid conflicts with PHY_INTF_* definitions
      net: stmmac: report active PHY interface
      net: phylink: fix NULL pointer deref in phylink_major_config()
      net: stmmac: rk: fix missing reset_control_put()
      net: stmmac: rk: add GMAC_CLK_xx constants, simplify RGMII definitions
      net: stmmac: rk: add SoC specific ->init() method
      net: stmmac: clear half-duplex caps where unsupported
      net: stmmac: move most PCS register definitions to stmmac_pcs.c
      net: stmmac: handle integrated PCS phy_intf_sel separately
      net: stmmac: rk: convert to mask-based interface mode configuration
      net: stmmac: rk: convert rk3588 to mask-based interface mode config
      net: stmmac: rk: move speed GRF register offset to private data
      net: stmmac: rk: convert rk3588 to rk_set_reg_speed()
      net: stmmac: rk: remove rk3528 RMII clock initialisation
      net: stmmac: rk: use rk_encode_wm16() for RGMII clocks
      net: stmmac: rk: use rk_encode_wm16() for RMII speed
      net: stmmac: rk: use rk_encode_wm16() for RMII clock
      net: stmmac: rk: remove need for ->set_speed() method
      net: stmmac: rk: convert px30
      net: stmmac: add wrappers for serdes_power[up|down]() methods
      net: stmmac: add state tracking for legacy serdes power state
      net: stmmac: add missing serdes power down in error paths
      net: stmmac: move serdes power methods to stmmac_[open|release]()
      net: stmmac: remove support for lpi_intr_o
      net: stmmac: rk: introduce flags indicating support for RGMII/RMII
      net: stmmac: rk: replace empty set_to_rmii() with supports_rmii
      net: stmmac: rk: rk3328: gmac2phy only supports RMII
      net: stmmac: rk: rk3528: gmac0 only supports RMII
      net: stmmac: rk: use rk_encode_wm16() for clock selection
      net: stmmac: rk: rk3506, rk3528 and rk3588 have rmii_mode in clock register
      net: stmmac: imx: fix iMX93 register definitions
      net: stmmac: qcom-ethqos: fix qcom_ethqos_serdes_powerup()

Sai Pratyusha Magam (1):
      wifi: nl80211: Add support for EPP peer indication

Sayantan Nandy (1):
      net: airoha_eth: increase max MTU to 9220 for DSA jumbo frames

Scott Mitchell (2):
      netfilter: nfnetlink_queue: nfqnl_instance GFP_ATOMIC -> GFP_KERNEL_ACCOUNT allocation
      netfilter: nfnetlink_queue: optimize verdict lookup with hash table

Sean Anderson (3):
      net: xilinx: axienet: Use devres for resource management in probe path
      net: phy: dp83867: Program TX FIFO for all interfaces
      net: phy: dp83867: Always program R/SGMII enable bits

Sebastian Andrzej Siewior (1):
      declance: Remove IRQF_ONESHOT

Sergey Ryazanov (7):
      net: wwan: core: remove unused port_id field
      net: wwan: core: explicit WWAN device reference counting
      net: wwan: core: split port creation and registration
      net: wwan: core: split port unregister and stop
      net: wwan: add NMEA port support
      net: wwan: hwsim: refactor to support more port types
      net: wwan: hwsim: support NMEA port emulation

Shahar Shitrit (4):
      net: Introduce netif_xmit_timeout_ms() helper
      net: hns3: Use netif_xmit_timeout_ms() helper
      net/mlx5e: Refine TX timeout handling to skip non-timed-out SQ
      docs: tls: Enhance TLS resync async process documentation

Shamir Rabinovitch (1):
      net/rds: new extension header: rdma bytes

Shell Chen (1):
      Bluetooth: btusb: Add new VID/PID for RTL8852CE

Shin-Yi Lin (1):
      wifi: rtw89: Add default ID 28de:2432 for RTL8832CU

Shuai Zhang (3):
      Bluetooth: hci_qca: Fix SSR (SubSystem Restart) fail when BT_EN is pulled up by hw
      Bluetooth: btqca: move WCN7850 workaround to the caller
      Bluetooth: btqca: Add WCN6855 firmware priority selection feature

Simon Horman (4):
      octeontx2-pf: Remove unnecessary bounds check
      net: phy: Grammar update for comment in genphy_update_link
      net: stmmac: spelling corrections
      net/mlx5e: remove declarations of mlx5e_shampo_{fill_umr,dealloc_hd}

Slark Xiao (2):
      net: wwan: mhi: Add network support for Foxconn T99W760
      net: wwan: mhi_wwan_ctrl: Add NMEA channel support

Sreedevi Joshi (1):
      idpf: update idpf_up_complete() return type to void

Stefan Eichenberger (5):
      dt-bindings: net: micrel: Convert to DT schema
      dt-bindings: net: micrel: Convert micrel-ksz90x1.txt to DT schema
      net: phy: add a new phy_device flag to keep preamble before sfd
      net: phy: micrel: add option to keep the preamble before sfd for KSZ9131
      net: stmmac: dwmac-imx: keep preamble before sfd on i.MX8MP

Stefan Sørensen (3):
      Bluetooth: hci_conn: use mod_delayed_work for active mode timeout
      Bluetooth: hci_conn: Set link_policy on incoming ACL connections
      Bluetooth: mgmt: Add idle_timeout to configurable system parameters

Stefan Wiehler (1):
      net: ethernet: ti: cpsw_ale: Remove obsolete macros

Suraj Gupta (1):
      clk: Add devm_clk_bulk_get_optional_enable() helper

Szymon Wilczek (1):
      wifi: libertas: fix WARNING in usb_tx_block

Tamir Duberstein (2):
      rust: net: replace `kernel::c_str!` with C-Strings
      drivers: net: replace `kernel::c_str!` with C-Strings

Techie Ernie (1):
      Bluetooth: btusb: Add USB ID 0489:e112 for Realtek 8851BE

Thomas Bogendoerfer (1):
      bonding: only set speed/duplex to unknown, if getting speed failed

Thomas Fourier (2):
      atm: idt77252: Use sb_pool_remove()
      net: wan/fsl_ucc_hdlc: Fix dma_free_coherent() in uhdlc_memclean()

Thomas Weißschuh (3):
      uapi: add INT_MAX and INT_MIN constants
      ethtool: uapi: Use UAPI definition of INT_MAX
      netfilter: uapi: Use UAPI definition of INT_MAX and INT_MIN

Thorsten Blum (2):
      wl1251: Replace strncpy with strscpy in wl1251_acx_fw_version
      net: ipconfig: Remove outdated comment and indent code block

Toke Høiland-Jørgensen (5):
      net/sched: Export mq functions for reuse
      net/sched: sch_cake: Factor out config variables into separate struct
      net/sched: sch_cake: Add cake_mq qdisc for using cake on mq devices
      net/sched: sch_cake: Share config across cake_mq sub-qdiscs
      net/sched: cake: avoid separate allocation of struct cake_sched_config

Tonghao Zhang (4):
      net: bonding: use workqueue to make sure peer notify updated in lacp mode
      net: bonding: move bond_should_notify_peers, e.g. into rtnl lock block
      net: bonding: skip the 2nd trylock when first one fail
      net: bonding: add the READ_ONCE/WRITE_ONCE for outside lock accessing

Tuo Li (1):
      wifi: iwlegacy: 3945-rs: remove redundant pointer check in il3945_rs_tx_status() and il3945_rs_get_rate()

Uwe Kleine-König (5):
      wifi: wlcore: sdio: Use pm_ptr instead of #ifdef CONFIG_PM
      sdio: Provide a bustype shutdown function
      wifi: rsi: sdio: Migrate to use sdio specific shutdown function
      wifi: rtw88: sdio: Migrate to use sdio specific shutdown function
      Bluetooth: btmtksdio: Use pm_ptr instead of #ifdef CONFIG_PM

Vadim Fedorenko (6):
      net: phy: micrel: improve HW timestamping config logic
      net: phy: micrel: add HW timestamp configuration reporting
      net: phy: microchip_rds_ptp: improve HW ts config logic
      net: phy: microchip_rds_ptp: add HW timestamp configuration reporting
      net: remove legacy way to get/set HW timestamp config
      selftests: drv-net: extend HW timestamp test with ioctl

Vaibhav Gupta (1):
      Bluetooth: hci_bcm4377: Use generic power management

Venkateswara Naralasetty (6):
      wifi: ath11k: Add initialization and deinitialization sequence for CFR module
      wifi: ath11k: Register debugfs for CFR configuration
      wifi: ath11k: Add support unassociated client CFR
      wifi: ath11k: Register relayfs entries for CFR dump
      wifi: ath11k: Register DBR event handler for CFR data
      wifi: ath11k: Register handler for CFR capture event

Vikas Gupta (1):
      bnge/bng_re: Add a new HSI

Vimlesh Kumar (4):
      octeon_ep: reset firmware ready status
      octeon_ep: disable per ring interrupts
      octeon_ep: ensure dbell BADDR updation
      octeon_ep_vf: ensure dbell BADDR updation

Vishal Badole (1):
      xgbe: Use netlink extack to report errors to ethtool

Vivian Wang (1):
      net: spacemit: Remove broken flow control support

Vladimir Oltean (15):
      dt-bindings: phy: rename transmit-amplitude.yaml to phy-common-props.yaml
      dt-bindings: phy-common-props: create a reusable "protocol-names" definition
      dt-bindings: phy-common-props: ensure protocol-names are unique
      dt-bindings: phy-common-props: RX and TX lane polarity inversion
      phy: add phy_get_rx_polarity() and phy_get_tx_polarity()
      dt-bindings: net: airoha,en8811h: deprecate "airoha,pnswap-rx" and "airoha,pnswap-tx"
      net: phy: air_en8811h: deprecate "airoha,pnswap-rx" and "airoha,pnswap-tx"
      dt-bindings: net: pcs: mediatek,sgmiisys: deprecate "mediatek,pnswap"
      net: pcs: pcs-mtk-lynxi: pass SGMIISYS OF node to PCS
      net: pcs: pcs-mtk-lynxi: deprecate "mediatek,pnswap"
      net: phylink: simplify phylink_resolve() -> phylink_major_config() path
      net: phylink: introduce helpers for replaying link callbacks
      net: dsa: sja1105: let phylink help with the replay of link callbacks
      net: dsa: sja1105: re-merge sja1105_set_port_speed() and sja1105_set_port_config()
      net: dsa: eliminate local type for tc policers

Votokina Victoria (1):
      nfc: hci: shdlc: Stop timers and work before freeing context

Wei Fang (15):
      net: fec: add fec_txq_trigger_xmit() helper
      net: fec: add fec_rx_error_check() to check RX errors
      net: fec: add rx_shift to indicate the extra bytes padded in front of RX frame
      net: fec: add fec_build_skb() to build a skb
      net: fec: improve fec_enet_rx_queue()
      net: fec: add fec_enet_rx_queue_xdp() for XDP path
      net: fec: add tx_qid parameter to fec_enet_xdp_tx_xmit()
      net: fec: transmit XDP frames in bulk
      net: fec: remove unnecessary NULL pointer check when clearing TX BD ring
      net: fec: use switch statement to check the type of tx_buf
      net: fec: remove the size parameter from fec_enet_create_page_pool()
      net: fec: move xdp_rxq_info* APIs out of fec_enet_create_page_pool()
      net: fec: add fec_alloc_rxq_buffers_pp() to allocate buffers from page pool
      net: fec: improve fec_enet_tx_queue()
      net: fec: add AF_XDP zero-copy support

Wei Zhang (2):
      wifi: ath12k: add WMI support for spatial reuse parameter configuration
      wifi: ath12k: support OBSS PD configuration for AP mode

Will Rosenberg (1):
      cipso: harden use of skb_cow() in cipso_v4_skbuff_setattr()

Willem de Bruijn (2):
      selftests/net: packetdrill: add minimal client and server tests
      selftests: net: reduce txtimestamp deschedule flakes

William Tu (4):
      net/mlx5e: Move async ICOSQ lock into ICOSQ struct
      net/mlx5e: Use regular ICOSQ for triggering NAPI
      net/mlx5e: Move async ICOSQ to dynamic allocation
      net/mlx5e: Conditionally create async ICOSQ

Xu Du (7):
      selftest: tun: Format tun.c existing code
      selftest: tun: Introduce tuntap_helpers.h header for TUN/TAP testing
      selftest: tun: Refactor tun_delete to use tuntap_helpers
      selftest: tun: Add helpers for GSO over UDP tunnel
      selftest: tun: Add test for sending gso packet into tun
      selftest: tun: Add test for receiving gso packet from tun
      selftest: tun: Add test data for success and failure paths

Yael Chemla (1):
      net/mlx5: Fix 1600G link mode enum naming

Yao Zi (3):
      net: phy: motorcomm: Support YT8531S PHY in YT6801 Ethernet controller
      net: stmmac: Add glue driver for Motorcomm YT6801 ethernet controller
      MAINTAINERS: Assign myself as maintainer of Motorcomm DWMAC glue driver

Yeounsu Moon (1):
      net: dlink: replace printk() with netdev_{info,dbg}() in rio_probe1()

YiFei Zhu (1):
      idpf: export RX hardware timestamping information to XDP

Yicong Hui (3):
      net/benet: Fix typos in driver code comments
      net/micrel: Fix typos in micrel driver code comments
      net/xen-netback: Fix mispelling of "Software" as "Softare"

Yohei Kojima (2):
      selftests: net: fix passive TFO test to fail if child processes failed
      selftests: net: improve error handling in passive TFO test

Yumei Huang (1):
      ipv6: preserve insertion order for same-scope addresses

Yuto Hamaguchi (1):
      netfilter: nf_conntrack: Add allow_clash to generic protocol handler

Zenm Chen (3):
      wifi: rtw89: Add support for MSI AX1800 Nano (GUAX18N)
      wifi: rtw89: Add support for D-Link VR Air Bridge (DWA-F18)
      Bluetooth: btusb: Add USB ID 7392:e611 for Edimax EW-7611UXB

Zilin Guan (2):
      wifi: rtw89: debug: Fix memory leak in __print_txpwr_map()
      wifi: p54: Fix memory leak in p54_beacon_update()

Ziyi Guo (4):
      wifi: iwlegacy: add missing mutex protection in il3945_store_measurement()
      wifi: iwlegacy: add missing mutex protection in il4965_store_tx_power()
      wifi: ath10k: fix lock protection in ath10k_wmi_event_peer_sta_ps_state_chg()
      wifi: ath10k: sdio: add missing lock protection in ath10k_sdio_fw_crashed_dump()

Zong-Zhe Yang (17):
      wifi: rtw89: ser: enable error IMR after recovering from L1
      wifi: rtw89: ser: L1 skip polling status if FW runs event mode
      wifi: rtw89: debug: add ser_counters dbgfs
      wifi: rtw89: debug: support SER L0/L1 simulation via halt H2C
      wifi: rtw89: regd: 6 GHz power type marks default when inactive
      wifi: rtw89: pre-handle RF calibration on link when needed
      wifi: rtw89: fw: change FW feature map to a BITMAP
      wifi: rtw89: fw: introduce helper for disabling FW feature configuration
      wifi: rtw89: 8922a: tweak RFK_PRE_NOTIFY FW feature configuration to align handling
      wifi: rtw89: refine mis-ordered entries in FW feature table
      wifi: rtw89: fw: change WITH_RFK_PRE_NOTIFY to be a FW feature group
      wifi: rtw89: phy: update TSSI flow for RTL8922D
      wifi: rtw89: 8922a: configure FW version for SIM_SER_L0L1_BY_HALT_H2C
      wifi: rtw89: get designated link to replace link instance 0
      wifi: rtw89: regd: update regulatory map to R73-R54
      wifi: rtw89: debug: rename mac/ctrl error to L0/L1 error
      wifi: rtw89: debug: tweak Wi-Fi 7 SER L0/L1 simulation methods

 CREDITS                                            |     8 +
 Documentation/.renames.txt                         |     1 -
 Documentation/PCI/pci-error-recovery.rst           |     1 -
 Documentation/admin-guide/sysctl/net.rst           |    13 +-
 .../devicetree/bindings/net/adi,adin.yaml          |    14 +
 .../devicetree/bindings/net/airoha,en7581-npu.yaml |    28 +-
 .../devicetree/bindings/net/airoha,en8811h.yaml    |    11 +-
 .../net/bluetooth/qcom,bluetooth-common.yaml       |    25 +
 .../bindings/net/bluetooth/qcom,qca2066-bt.yaml    |    49 +
 .../bindings/net/bluetooth/qcom,qca6390-bt.yaml    |    64 +
 .../bindings/net/bluetooth/qcom,qca9377-bt.yaml    |    58 +
 .../bindings/net/bluetooth/qcom,wcn3950-bt.yaml    |    67 +
 .../bindings/net/bluetooth/qcom,wcn3990-bt.yaml    |    66 +
 .../bindings/net/bluetooth/qcom,wcn6750-bt.yaml    |    91 +
 .../bindings/net/bluetooth/qcom,wcn6855-bt.yaml    |    99 +
 .../bindings/net/bluetooth/qcom,wcn7850-bt.yaml    |    94 +
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml |   259 -
 .../bindings/net/can/renesas,rcar-canfd.yaml       |   117 +-
 .../devicetree/bindings/net/dsa/lantiq,gswip.yaml  |    32 +-
 .../bindings/net/dsa/marvell,mv88e6xxx.yaml        |     2 +-
 .../bindings/net/dsa/maxlinear,mxl862xx.yaml       |   161 +
 .../devicetree/bindings/net/dsa/microchip,ksz.yaml |     3 +
 .../bindings/net/ethernet-connector.yaml           |    56 +
 .../devicetree/bindings/net/ethernet-phy.yaml      |    18 +
 .../devicetree/bindings/net/micrel,gigabit.yaml    |   253 +
 .../devicetree/bindings/net/micrel-ksz90x1.txt     |   228 -
 Documentation/devicetree/bindings/net/micrel.txt   |    57 -
 Documentation/devicetree/bindings/net/micrel.yaml  |   131 +
 .../bindings/net/microchip,sparx5-switch.yaml      |    15 +-
 .../devicetree/bindings/net/mscc,miim.yaml         |    11 +-
 .../devicetree/bindings/net/nxp,s32-dwmac.yaml     |    13 +
 .../bindings/net/pcs/mediatek,sgmiisys.yaml        |     7 +-
 .../bindings/net/pcs/renesas,rzn1-miic.yaml        |     7 +
 .../bindings/net/renesas,rzv2h-gbeth.yaml          |    81 +-
 .../devicetree/bindings/net/rockchip-dwmac.yaml    |     2 +
 .../devicetree/bindings/net/snps,dwmac.yaml        |     3 +
 .../devicetree/bindings/net/ti,dp83822.yaml        |     9 +-
 .../bindings/net/wireless/qcom,ath11k-pci.yaml     |     1 +
 .../bindings/net/wireless/qcom,ath11k.yaml         |     9 -
 .../devicetree/bindings/phy/phy-common-props.yaml  |   157 +
 .../bindings/phy/transmit-amplitude.yaml           |   103 -
 .../devicetree/bindings/ptp/amazon,vmclock.yaml    |    46 +
 Documentation/netlink/specs/dpll.yaml              |    12 +
 Documentation/netlink/specs/mptcp_pm.yaml          |     1 +
 Documentation/netlink/specs/rt-link.yaml           |     3 +
 Documentation/netlink/specs/tc.yaml                |     3 +
 .../networking/device_drivers/ethernet/index.rst   |     1 -
 .../device_drivers/ethernet/neterion/s2io.rst      |   196 -
 Documentation/networking/index.rst                 |     1 +
 Documentation/networking/iou-zcrx.rst              |    20 +
 Documentation/networking/ip-sysctl.rst             |     4 +-
 .../networking/net_cachelines/tcp_sock.rst         |     1 +
 Documentation/networking/netdevices.rst            |     4 +-
 Documentation/networking/phy-port.rst              |   111 +
 Documentation/networking/phy.rst                   |    22 +-
 Documentation/networking/scaling.rst               |    12 +-
 Documentation/networking/timestamping.rst          |     7 +-
 Documentation/networking/tls-offload.rst           |    30 +
 MAINTAINERS                                        |    61 +-
 arch/mips/configs/ip27_defconfig                   |     1 -
 arch/mips/configs/loongson2k_defconfig             |     1 -
 arch/mips/configs/mtx1_defconfig                   |     3 -
 arch/powerpc/configs/powernv_defconfig             |     1 -
 arch/powerpc/configs/ppc64_defconfig               |     1 -
 arch/powerpc/configs/ppc6xx_defconfig              |     1 -
 arch/powerpc/configs/skiroot_defconfig             |     1 -
 arch/s390/configs/debug_defconfig                  |     1 -
 arch/s390/configs/defconfig                        |     1 -
 drivers/atm/idt77252.c                             |     4 +-
 drivers/bluetooth/btintel_pcie.c                   |     3 +-
 drivers/bluetooth/btmtksdio.c                      |     8 +-
 drivers/bluetooth/btnxpuart.c                      |     6 +-
 drivers/bluetooth/btqca.c                          |    58 +-
 drivers/bluetooth/btusb.c                          |    26 +-
 drivers/bluetooth/hci_bcm4377.c                    |    11 +-
 drivers/bluetooth/hci_intel.c                      |    10 +-
 drivers/bluetooth/hci_qca.c                        |    52 +-
 drivers/clk/clk-devres.c                           |    50 +
 drivers/dpll/Kconfig                               |    15 +
 drivers/dpll/dpll_core.c                           |   288 +-
 drivers/dpll/dpll_core.h                           |    11 +
 drivers/dpll/dpll_netlink.c                        |    87 +-
 drivers/dpll/dpll_nl.c                             |     1 +
 drivers/dpll/zl3073x/core.c                        |     7 +-
 drivers/dpll/zl3073x/core.h                        |    30 +
 drivers/dpll/zl3073x/dpll.c                        |   178 +-
 drivers/dpll/zl3073x/dpll.h                        |     2 +
 drivers/dpll/zl3073x/out.h                         |    17 +
 drivers/dpll/zl3073x/prop.c                        |    34 +-
 drivers/infiniband/hw/bng_re/Makefile              |     2 +-
 drivers/infiniband/hw/bng_re/bng_fw.c              |     2 +-
 drivers/infiniband/hw/bng_re/bng_res.c             |     4 +-
 drivers/infiniband/hw/bng_re/bng_res.h             |     2 +-
 drivers/infiniband/hw/bng_re/bng_roce_hsi.h        |  6450 ++++++++++
 drivers/infiniband/hw/bng_re/bng_tlv.h             |     2 +-
 drivers/infiniband/hw/bnxt_re/main.c               |     4 +-
 drivers/infiniband/hw/mlx5/main.c                  |     2 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |     6 +-
 drivers/mmc/core/sdio_bus.c                        |    25 +
 drivers/net/Kconfig                                |     3 +-
 drivers/net/Makefile                               |     1 -
 drivers/net/arcnet/com20020-pci.c                  |    15 +-
 drivers/net/arcnet/com20020.c                      |    16 -
 drivers/net/bonding/bond_3ad.c                     |    16 +-
 drivers/net/bonding/bond_main.c                    |   128 +-
 drivers/net/caif/caif_serial.c                     |     5 +-
 drivers/net/can/dev/skb.c                          |   123 +-
 drivers/net/can/rcar/rcar_canfd.c                  |    32 +-
 drivers/net/can/sja1000/sja1000.c                  |    58 +-
 drivers/net/can/vxcan.c                            |    15 +-
 drivers/net/dsa/Kconfig                            |     3 +
 drivers/net/dsa/Makefile                           |     1 +
 drivers/net/dsa/dsa_loop.c                         |     8 +-
 drivers/net/dsa/lantiq/Kconfig                     |     5 +-
 drivers/net/dsa/lantiq/lantiq_gswip.c              |    46 +-
 drivers/net/dsa/lantiq/lantiq_gswip.h              |     7 +-
 drivers/net/dsa/lantiq/lantiq_gswip_common.c       |    33 +-
 drivers/net/dsa/lantiq/mxl-gsw1xx.c                |   255 +-
 drivers/net/dsa/lantiq/mxl-gsw1xx.h                |    13 +
 drivers/net/dsa/microchip/ksz_common.c             |    15 +-
 drivers/net/dsa/microchip/ksz_common.h             |     7 +
 drivers/net/dsa/microchip/ksz_ptp.c                |    63 +-
 drivers/net/dsa/microchip/ksz_ptp_reg.h            |    16 +-
 drivers/net/dsa/mt7530-mdio.c                      |     4 +-
 drivers/net/dsa/mxl862xx/Kconfig                   |    12 +
 drivers/net/dsa/mxl862xx/Makefile                  |     3 +
 drivers/net/dsa/mxl862xx/mxl862xx-api.h            |   675 +
 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h            |    49 +
 drivers/net/dsa/mxl862xx/mxl862xx-host.c           |   245 +
 drivers/net/dsa/mxl862xx/mxl862xx-host.h           |    12 +
 drivers/net/dsa/mxl862xx/mxl862xx.c                |   476 +
 drivers/net/dsa/mxl862xx/mxl862xx.h                |    16 +
 drivers/net/dsa/ocelot/felix.c                     |     4 +-
 drivers/net/dsa/sja1105/sja1105_main.c             |    88 +-
 drivers/net/dsa/yt921x.c                           |   496 +-
 drivers/net/dsa/yt921x.h                           |    75 +-
 drivers/net/ethernet/8390/8390.c                   |    14 -
 drivers/net/ethernet/8390/8390p.c                  |    11 -
 drivers/net/ethernet/Kconfig                       |    13 -
 drivers/net/ethernet/Makefile                      |     2 -
 drivers/net/ethernet/adi/adin1110.c                |     2 +-
 drivers/net/ethernet/airoha/airoha_eth.c           |    41 +-
 drivers/net/ethernet/airoha/airoha_eth.h           |     2 +-
 drivers/net/ethernet/airoha/airoha_npu.c           |    60 +-
 drivers/net/ethernet/alacritech/slic.h             |    50 +-
 drivers/net/ethernet/alacritech/slicoss.c          |     8 +-
 drivers/net/ethernet/amazon/ena/ena_ethtool.c      |    22 +-
 drivers/net/ethernet/amd/Kconfig                   |     2 +-
 drivers/net/ethernet/amd/declance.c                |     2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-common.h        |     3 +
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c           |     8 +
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c           |     1 +
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c       |    64 +-
 drivers/net/ethernet/amd/xgbe/xgbe.h               |     1 +
 .../net/ethernet/aquantia/atlantic/aq_ethtool.c    |    18 +-
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c    |     3 -
 drivers/net/ethernet/broadcom/asp2/bcmasp.c        |    32 +-
 drivers/net/ethernet/broadcom/asp2/bcmasp.h        |    36 -
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c   |    58 +-
 drivers/net/ethernet/broadcom/bnge/Makefile        |     3 +-
 drivers/net/ethernet/broadcom/bnge/bnge.h          |     2 +-
 drivers/net/ethernet/broadcom/bnge/bnge_auxr.c     |     2 +-
 drivers/net/ethernet/broadcom/bnge/bnge_devlink.c  |     2 +-
 drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h   |   446 +
 drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h     |     2 +-
 drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c |    67 +-
 drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h |     2 +
 drivers/net/ethernet/broadcom/bnge/bnge_netdev.c   |   409 +-
 drivers/net/ethernet/broadcom/bnge/bnge_netdev.h   |   123 +-
 drivers/net/ethernet/broadcom/bnge/bnge_rmem.c     |     2 +-
 drivers/net/ethernet/broadcom/bnge/bnge_txrx.c     |  1642 +++
 drivers/net/ethernet/broadcom/bnge/bnge_txrx.h     |   126 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   253 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |    14 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |   131 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c      |    51 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c      |     6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h      |     2 +-
 drivers/net/ethernet/cadence/macb_main.c           |    40 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c |    11 +-
 drivers/net/ethernet/cisco/enic/enic_ethtool.c     |    11 +-
 drivers/net/ethernet/dlink/dl2k.c                  |    17 +-
 drivers/net/ethernet/dnet.c                        |   877 --
 drivers/net/ethernet/dnet.h                        |   220 -
 drivers/net/ethernet/emulex/benet/be.h             |     8 +-
 drivers/net/ethernet/emulex/benet/be_cmds.c        |     6 +-
 drivers/net/ethernet/emulex/benet/be_cmds.h        |     6 +-
 drivers/net/ethernet/emulex/benet/be_ethtool.c     |    43 +-
 drivers/net/ethernet/emulex/benet/be_hw.h          |     6 +-
 drivers/net/ethernet/emulex/benet/be_main.c        |    16 +-
 drivers/net/ethernet/engleder/tsnep_ethtool.c      |    11 +-
 drivers/net/ethernet/faraday/ftgmac100.c           |   356 +-
 drivers/net/ethernet/freescale/fec.h               |    14 +-
 drivers/net/ethernet/freescale/fec_main.c          |  1649 ++-
 .../net/ethernet/fungible/funeth/funeth_ethtool.c  |    14 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c      |    11 +-
 drivers/net/ethernet/google/gve/gve_main.c         |     9 +-
 drivers/net/ethernet/google/gve/gve_tx_dqo.c       |     3 -
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   |    16 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |    23 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |    12 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |    11 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |    11 +-
 drivers/net/ethernet/huawei/hinic/hinic_ethtool.c  |    19 +-
 drivers/net/ethernet/huawei/hinic3/Kconfig         |     1 +
 drivers/net/ethernet/huawei/hinic3/Makefile        |     1 +
 drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c   |     3 -
 drivers/net/ethernet/huawei/hinic3/hinic3_csr.h    |     6 +
 drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c    |     3 +-
 drivers/net/ethernet/huawei/hinic3/hinic3_filter.c |   417 +
 .../net/ethernet/huawei/hinic3/hinic3_hw_comm.c    |   115 +
 .../net/ethernet/huawei/hinic3/hinic3_hw_comm.h    |     6 +
 .../net/ethernet/huawei/hinic3/hinic3_hw_intf.h    |    24 +
 drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c  |    99 +-
 drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h  |    21 +
 drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c   |    90 +-
 drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h   |    23 +
 drivers/net/ethernet/huawei/hinic3/hinic3_irq.c    |    97 +-
 drivers/net/ethernet/huawei/hinic3/hinic3_lld.c    |    58 +-
 drivers/net/ethernet/huawei/hinic3/hinic3_main.c   |   186 +-
 drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c   |    55 +-
 drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h   |     2 +
 drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.c   |   313 +-
 drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.h   |    53 +
 .../ethernet/huawei/hinic3/hinic3_mgmt_interface.h |    69 +
 .../net/ethernet/huawei/hinic3/hinic3_netdev_ops.c |   377 +-
 .../net/ethernet/huawei/hinic3/hinic3_nic_cfg.c    |   290 +-
 .../net/ethernet/huawei/hinic3/hinic3_nic_cfg.h    |    47 +
 .../net/ethernet/huawei/hinic3/hinic3_nic_dev.h    |    60 +-
 drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c |     6 +-
 drivers/net/ethernet/huawei/hinic3/hinic3_rx.c     |    27 +
 drivers/net/ethernet/huawei/hinic3/hinic3_rx.h     |    21 +
 drivers/net/ethernet/huawei/hinic3/hinic3_tx.c     |    34 +-
 drivers/net/ethernet/huawei/hinic3/hinic3_tx.h     |    16 +
 drivers/net/ethernet/intel/ice/ice.h               |     3 -
 drivers/net/ethernet/intel/ice/ice_base.c          |     4 +-
 drivers/net/ethernet/intel/ice/ice_common.c        |    79 +-
 drivers/net/ethernet/intel/ice/ice_dpll.c          |   758 +-
 drivers/net/ethernet/intel/ice/ice_dpll.h          |    30 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |    31 +-
 drivers/net/ethernet/intel/ice/ice_irq.c           |     5 +-
 drivers/net/ethernet/intel/ice/ice_lib.c           |    71 +-
 drivers/net/ethernet/intel/ice/ice_lib.h           |     6 +
 drivers/net/ethernet/intel/ice/ice_main.c          |   196 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c           |    32 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c        |     9 +-
 drivers/net/ethernet/intel/ice/ice_tspll.c         |   217 +
 drivers/net/ethernet/intel/ice/ice_tspll.h         |    13 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c          |    49 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h          |   199 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c      |     5 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h      |     2 +-
 drivers/net/ethernet/intel/ice/ice_type.h          |     6 +
 drivers/net/ethernet/intel/ice/ice_xsk.c           |     4 +-
 drivers/net/ethernet/intel/idpf/idpf.h             |   179 +-
 drivers/net/ethernet/intel/idpf/idpf_dev.c         |    18 +-
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c     |    93 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c         |   238 +-
 drivers/net/ethernet/intel/idpf/idpf_ptp.c         |    17 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |   810 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h        |    44 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c      |    21 +-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c    |  1096 +-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.h    |    88 +-
 drivers/net/ethernet/intel/idpf/xdp.c              |    79 +-
 drivers/net/ethernet/intel/idpf/xdp.h              |    26 +-
 drivers/net/ethernet/intel/idpf/xsk.c              |    12 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c     |     7 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |     2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c       |    45 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h       |     2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h      |     2 +
 .../net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c |    47 +-
 .../net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c |    66 +-
 .../net/ethernet/marvell/octeon_ep/octep_main.h    |     2 +-
 .../marvell/octeon_ep/octep_regs_cn9k_pf.h         |    31 +
 .../marvell/octeon_ep/octep_regs_cnxk_pf.h         |     2 +
 drivers/net/ethernet/marvell/octeon_ep/octep_rx.c  |     8 +-
 .../ethernet/marvell/octeon_ep_vf/octep_vf_cn9k.c  |     3 +-
 .../ethernet/marvell/octeon_ep_vf/octep_vf_cnxk.c  |    39 +-
 .../ethernet/marvell/octeon_ep_vf/octep_vf_main.h  |     2 +-
 .../ethernet/marvell/octeon_ep_vf/octep_vf_rx.c    |     8 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |     2 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c    |    11 +
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |    12 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |    13 +-
 .../ethernet/marvell/octeontx2/nic/otx2_devlink.h  |     2 +-
 .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c  |    22 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |     1 +
 .../ethernet/marvell/prestera/prestera_ethtool.c   |     5 -
 .../net/ethernet/marvell/prestera/prestera_pci.c   |     2 +-
 drivers/net/ethernet/marvell/skge.c                |     1 -
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |    34 +-
 drivers/net/ethernet/mellanox/mlx4/en_tx.c         |    42 +-
 drivers/net/ethernet/mellanox/mlx5/core/dpll.c     |    18 +-
 drivers/net/ethernet/mellanox/mlx5/core/ecpf.c     |     5 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |    48 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/dcbnl.h |     4 +
 .../net/ethernet/mellanox/mlx5/core/en/params.c    |    23 -
 .../ethernet/mellanox/mlx5/core/en/reporter_tx.c   |     1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h  |     1 -
 .../net/ethernet/mellanox/mlx5/core/en/xsk/rx.c    |     3 +
 .../net/ethernet/mellanox/mlx5/core/en/xsk/tx.c    |     6 +-
 .../mellanox/mlx5/core/en_accel/en_accel.h         |    17 -
 .../ethernet/mellanox/mlx5/core/en_accel/ktls.c    |    10 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c |    26 +-
 .../mellanox/mlx5/core/en_accel/ktls_txrx.h        |     3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c |    66 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |     2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   429 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |   382 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |    75 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c  |    37 +-
 .../ethernet/mellanox/mlx5/core/esw/devlink_port.c |     2 +
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |    48 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |    10 +
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |    55 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h  |     3 +-
 .../net/ethernet/mellanox/mlx5/core/fs_counters.c  |    47 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_pool.c  |    16 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_pool.h  |     5 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |   215 +
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h  |    11 +
 .../net/ethernet/mellanox/mlx5/core/lag/mpesw.c    |    39 +
 .../net/ethernet/mellanox/mlx5/core/lag/mpesw.h    |    14 +
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |     5 +-
 drivers/net/ethernet/mellanox/mlx5/core/port.c     |    30 +-
 .../mellanox/mlx5/core/steering/hws/fs_hws_pools.c |     8 +-
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    |    74 +
 drivers/net/ethernet/mellanox/mlxsw/pci.c          |    12 -
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h        |    12 +
 drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c    |   407 +
 drivers/net/ethernet/meta/fbnic/fbnic_devlink.c    |     8 +-
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c    |    14 +-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c         |    44 +-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h         |    10 +
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c        |    24 +-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c        |     4 +
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c       |    28 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h       |     6 +
 drivers/net/ethernet/micrel/ks8842.c               |     4 +-
 drivers/net/ethernet/micrel/ks8851_common.c        |     2 +-
 drivers/net/ethernet/micrel/ks8851_spi.c           |     4 +-
 drivers/net/ethernet/micrel/ksz884x.c              |     4 +-
 drivers/net/ethernet/microchip/lan743x_ethtool.c   |    13 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |    80 +-
 drivers/net/ethernet/microsoft/mana/mana_ethtool.c |    13 +-
 drivers/net/ethernet/myricom/myri10ge/myri10ge.c   |    28 +-
 drivers/net/ethernet/neterion/Kconfig              |    35 -
 drivers/net/ethernet/neterion/Makefile             |     6 -
 drivers/net/ethernet/neterion/s2io-regs.h          |   958 --
 drivers/net/ethernet/neterion/s2io.c               |  8572 -------------
 drivers/net/ethernet/neterion/s2io.h               |  1124 --
 .../net/ethernet/netronome/nfp/nfp_net_ethtool.c   |    11 +-
 .../net/ethernet/pensando/ionic/ionic_ethtool.c    |    25 +-
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c    |    12 +-
 drivers/net/ethernet/realtek/8139too.c             |    40 +-
 drivers/net/ethernet/realtek/Kconfig               |    16 +-
 drivers/net/ethernet/realtek/Makefile              |     1 -
 drivers/net/ethernet/realtek/atp.c                 |   886 --
 drivers/net/ethernet/realtek/atp.h                 |   262 -
 drivers/net/ethernet/realtek/r8169.h               |     3 +-
 drivers/net/ethernet/realtek/r8169_firmware.c      |     2 +-
 drivers/net/ethernet/realtek/r8169_main.c          |   243 +-
 drivers/net/ethernet/renesas/rcar_gen4_ptp.c       |    34 +-
 drivers/net/ethernet/renesas/rcar_gen4_ptp.h       |    18 +-
 drivers/net/ethernet/renesas/rswitch_l2.c          |    15 +-
 drivers/net/ethernet/renesas/rswitch_main.c        |    11 +-
 drivers/net/ethernet/renesas/rtsn.c                |    30 +-
 drivers/net/ethernet/samsung/sxgbe/sxgbe_mtl.c     |     2 +-
 drivers/net/ethernet/sfc/ef100_ethtool.c           |     1 +
 drivers/net/ethernet/sfc/ethtool.c                 |     1 +
 drivers/net/ethernet/sfc/ethtool_common.c          |    11 +-
 drivers/net/ethernet/sfc/ethtool_common.h          |     1 +
 drivers/net/ethernet/sfc/falcon/ethtool.c          |    12 +-
 drivers/net/ethernet/sfc/nic.h                     |     7 +-
 drivers/net/ethernet/sfc/siena/ethtool.c           |     1 +
 drivers/net/ethernet/sfc/siena/ethtool_common.c    |    11 +-
 drivers/net/ethernet/sfc/siena/ethtool_common.h    |     1 +
 drivers/net/ethernet/sis/sis900.c                  |    31 +-
 drivers/net/ethernet/smsc/epic100.c                |    35 +-
 drivers/net/ethernet/socionext/sni_ave.c           |     4 +-
 drivers/net/ethernet/spacemit/k1_emac.c            |   111 +-
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |     9 +
 drivers/net/ethernet/stmicro/stmmac/Makefile       |     1 +
 drivers/net/ethernet/stmicro/stmmac/common.h       |     7 +-
 drivers/net/ethernet/stmicro/stmmac/descs.h        |     7 -
 drivers/net/ethernet/stmicro/stmmac/descs_com.h    |    48 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c    |    43 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  |     4 -
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |    22 +-
 .../net/ethernet/stmicro/stmmac/dwmac-motorcomm.c  |   384 +
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    |    15 +-
 .../ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c  |     1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     |  1245 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c    |    28 +-
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |     5 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |     4 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c  |    10 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac100.h     |    36 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac1000.h    |    72 +-
 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   |    28 +-
 .../net/ethernet/stmicro/stmmac/dwmac1000_dma.c    |    18 +-
 .../net/ethernet/stmicro/stmmac/dwmac100_core.c    |     6 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c |     3 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h       |    79 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |    35 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c |    70 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.h |     8 -
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c   |    46 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h   |   167 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c   |     2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac_dma.h    |   172 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c    |    10 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |    41 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |    27 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_descs.c   |    39 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c |    76 +-
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c     |    29 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.c         |     2 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |     4 +-
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c     |     4 +-
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c    |    25 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |     3 +-
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |    15 +-
 .../net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c  |     2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   190 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |     2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c   |    45 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h   |    68 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |     8 -
 .../net/ethernet/stmicro/stmmac/stmmac_selftests.c |     2 +-
 drivers/net/ethernet/sun/niu.c                     |    11 +-
 drivers/net/ethernet/sun/sunhme.c                  |     3 +
 drivers/net/ethernet/ti/Kconfig                    |     1 +
 drivers/net/ethernet/ti/Makefile                   |     2 +-
 drivers/net/ethernet/ti/am65-cpsw-ethtool.c        |     5 +-
 drivers/net/ethernet/ti/cpsw_ale.c                 |     5 -
 drivers/net/ethernet/ti/cpsw_ethtool.c             |     5 +-
 drivers/net/ethernet/ti/cpsw_new.c                 |    15 +-
 drivers/net/ethernet/ti/icssg/icssg_common.c       |     1 -
 drivers/net/ethernet/ti/icssg/icssg_prueth.c       |    13 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h       |     1 -
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c   |     9 +-
 drivers/net/ethernet/ti/icssm/icssm_prueth.c       |   545 +-
 drivers/net/ethernet/ti/icssm/icssm_prueth.h       |    20 +-
 .../net/ethernet/ti/icssm/icssm_prueth_fdb_tbl.h   |    76 +
 .../net/ethernet/ti/icssm/icssm_prueth_switch.c    |  1065 ++
 .../net/ethernet/ti/icssm/icssm_prueth_switch.h    |    37 +
 drivers/net/ethernet/ti/icssm/icssm_switch.h       |   103 +
 drivers/net/ethernet/ti/icssm/icssm_switchdev.c    |   333 +
 drivers/net/ethernet/ti/icssm/icssm_switchdev.h    |    13 +
 .../ti/icssm/icssm_vlan_mcast_filter_mmap.h        |   120 +
 drivers/net/ethernet/ti/netcp.h                    |     8 +-
 drivers/net/ethernet/ti/netcp_core.c               |    16 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        |    17 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c |    12 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |    83 +-
 drivers/net/geneve.c                               |   557 +-
 drivers/net/hamradio/hdlcdrv.c                     |    20 -
 drivers/net/hippi/Kconfig                          |    40 -
 drivers/net/hippi/Makefile                         |     6 -
 drivers/net/hippi/rrunner.c                        |  1687 ---
 drivers/net/hippi/rrunner.h                        |   848 --
 drivers/net/ifb.c                                  |    18 +-
 drivers/net/ipvlan/ipvlan_core.c                   |    55 +-
 drivers/net/macsec.c                               |     6 +-
 drivers/net/mctp/mctp-i2c.c                        |     9 +
 drivers/net/net_failover.c                         |    13 -
 drivers/net/netconsole.c                           |   450 +-
 drivers/net/netdevsim/netdev.c                     |     7 +-
 drivers/net/netdevsim/netdevsim.h                  |     8 +-
 drivers/net/netdevsim/psp.c                        |    18 +-
 drivers/net/ovpn/peer.c                            |     2 +-
 drivers/net/pcs/Kconfig                            |     1 +
 drivers/net/pcs/pcs-mtk-lynxi.c                    |    63 +-
 drivers/net/pcs/pcs-rzn1-miic.c                    |   105 +-
 drivers/net/phy/Kconfig                            |     1 +
 drivers/net/phy/Makefile                           |     2 +-
 drivers/net/phy/adin.c                             |    20 +
 drivers/net/phy/air_en8811h.c                      |   499 +-
 drivers/net/phy/ax88796b_rust.rs                   |     7 +-
 drivers/net/phy/dp83822.c                          |    71 +-
 drivers/net/phy/dp83867.c                          |    63 +-
 drivers/net/phy/fixed_phy.c                        |    83 +-
 drivers/net/phy/marvell-88x2222.c                  |    94 +-
 drivers/net/phy/marvell.c                          |    92 +-
 drivers/net/phy/marvell10g.c                       |    49 +-
 drivers/net/phy/mdio_device.c                      |    13 -
 drivers/net/phy/mediatek/mtk-ge-soc.c              |     2 +
 drivers/net/phy/micrel.c                           |    58 +-
 drivers/net/phy/microchip_rds_ptp.c                |    34 +-
 drivers/net/phy/motorcomm.c                        |     4 +
 drivers/net/phy/mxl-gpy.c                          |    61 +-
 drivers/net/phy/phy-caps.h                         |     6 +
 drivers/net/phy/phy-core.c                         |     8 +
 drivers/net/phy/phy_caps.c                         |    67 +
 drivers/net/phy/phy_device.c                       |   427 +-
 drivers/net/phy/phy_port.c                         |   212 +
 drivers/net/phy/phylib-internal.h                  |     6 -
 drivers/net/phy/phylib.h                           |     5 +
 drivers/net/phy/phylink.c                          |    79 +-
 drivers/net/phy/qcom/at803x.c                      |    77 +-
 drivers/net/phy/qcom/qca807x.c                     |    72 +-
 drivers/net/phy/qt2025.rs                          |     5 +-
 drivers/net/phy/realtek/realtek_main.c             |   432 +-
 drivers/net/phy/sfp.c                              |     8 +-
 drivers/net/ppp/ppp_generic.c                      |    30 +-
 drivers/net/thunderbolt/main.c                     |    53 +
 drivers/net/usb/Kconfig                            |     2 +-
 drivers/net/usb/aqc111.c                           |     5 -
 drivers/net/usb/asix.h                             |     3 -
 drivers/net/usb/asix_common.c                      |     8 -
 drivers/net/usb/asix_devices.c                     |    30 +-
 drivers/net/usb/ax88172a.c                         |     2 +-
 drivers/net/usb/ax88179_178a.c                     |     8 +-
 drivers/net/usb/catc.c                             |     7 -
 drivers/net/usb/dm9601.c                           |    27 +-
 drivers/net/usb/int51x1.c                          |    39 +-
 drivers/net/usb/mcs7830.c                          |    15 +-
 drivers/net/usb/pegasus.c                          |     3 -
 drivers/net/usb/r8152.c                            |    12 +-
 drivers/net/usb/rtl8150.c                          |     3 -
 drivers/net/usb/sierra_net.c                       |    14 +-
 drivers/net/usb/smsc75xx.c                         |     7 +-
 drivers/net/usb/smsc95xx.c                         |    13 +-
 drivers/net/usb/sr9700.c                           |   251 +-
 drivers/net/usb/sr9700.h                           |    22 +-
 drivers/net/usb/sr9800.c                           |    30 +-
 drivers/net/usb/sr9800.h                           |     3 +-
 drivers/net/usb/usbnet.c                           |     8 +
 drivers/net/vxlan/vxlan_core.c                     |    16 +-
 drivers/net/vxlan/vxlan_vnifilter.c                |     2 +-
 drivers/net/wan/framer/framer-core.c               |     6 +-
 drivers/net/wan/fsl_ucc_hdlc.c                     |     8 +-
 drivers/net/wireless/ath/ath10k/sdio.c             |     6 +
 drivers/net/wireless/ath/ath10k/snoc.c             |    53 +-
 drivers/net/wireless/ath/ath10k/snoc.h             |     3 +
 drivers/net/wireless/ath/ath10k/wmi.c              |     4 +-
 drivers/net/wireless/ath/ath11k/Kconfig            |    11 +
 drivers/net/wireless/ath/ath11k/Makefile           |     1 +
 drivers/net/wireless/ath/ath11k/cfr.c              |  1023 ++
 drivers/net/wireless/ath/ath11k/cfr.h              |   308 +
 drivers/net/wireless/ath/ath11k/core.c             |   108 +-
 drivers/net/wireless/ath/ath11k/core.h             |    23 +-
 drivers/net/wireless/ath/ath11k/dbring.c           |    50 +-
 drivers/net/wireless/ath/ath11k/dbring.h           |     8 +-
 drivers/net/wireless/ath/ath11k/debug.h            |     8 +-
 drivers/net/wireless/ath/ath11k/debugfs.c          |     2 +-
 drivers/net/wireless/ath/ath11k/debugfs_sta.c      |   142 +-
 drivers/net/wireless/ath/ath11k/dp.c               |    12 +-
 drivers/net/wireless/ath/ath11k/dp.h               |     1 -
 drivers/net/wireless/ath/ath11k/dp_tx.c            |     9 +-
 drivers/net/wireless/ath/ath11k/hal.c              |     3 +-
 drivers/net/wireless/ath/ath11k/hw.c               |    19 +-
 drivers/net/wireless/ath/ath11k/hw.h               |     8 +-
 drivers/net/wireless/ath/ath11k/mac.c              |    23 +-
 drivers/net/wireless/ath/ath11k/reg.c              |     9 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |   147 +-
 drivers/net/wireless/ath/ath11k/wmi.h              |    97 +-
 drivers/net/wireless/ath/ath12k/Makefile           |     8 +-
 drivers/net/wireless/ath/ath12k/ahb.c              |   165 +-
 drivers/net/wireless/ath/ath12k/ahb.h              |    31 +-
 drivers/net/wireless/ath/ath12k/ce.c               |   326 +-
 drivers/net/wireless/ath/ath12k/ce.h               |     7 +-
 drivers/net/wireless/ath/ath12k/cmn_defs.h         |    20 +
 drivers/net/wireless/ath/ath12k/core.c             |    75 +-
 drivers/net/wireless/ath/ath12k/core.h             |   179 +-
 drivers/net/wireless/ath/ath12k/dbring.c           |     6 +-
 drivers/net/wireless/ath/ath12k/debug.c            |     8 +-
 drivers/net/wireless/ath/ath12k/debugfs.c          |     8 +-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.c    |   197 +-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.h    |    85 +-
 drivers/net/wireless/ath/ath12k/debugfs_sta.c      |    62 +-
 drivers/net/wireless/ath/ath12k/dp.c               |   561 +-
 drivers/net/wireless/ath/ath12k/dp.h               |  1742 +--
 drivers/net/wireless/ath/ath12k/dp_cmn.h           |   106 +
 drivers/net/wireless/ath/ath12k/dp_htt.c           |  1353 ++
 drivers/net/wireless/ath/ath12k/dp_htt.h           |  1546 +++
 drivers/net/wireless/ath/ath12k/dp_mon.c           |  3685 +-----
 drivers/net/wireless/ath/ath12k/dp_mon.h           |    58 +-
 drivers/net/wireless/ath/ath12k/dp_peer.c          |   690 +
 drivers/net/wireless/ath/ath12k/dp_peer.h          |   182 +
 drivers/net/wireless/ath/ath12k/dp_rx.c            |  3522 +-----
 drivers/net/wireless/ath/ath12k/dp_rx.h            |   191 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c            |  1634 +--
 drivers/net/wireless/ath/ath12k/dp_tx.h            |    39 +-
 drivers/net/wireless/ath/ath12k/fw.c               |    10 +-
 drivers/net/wireless/ath/ath12k/fw.h               |     3 +-
 drivers/net/wireless/ath/ath12k/hal.c              |  2134 +---
 drivers/net/wireless/ath/ath12k/hal.h              |  1523 ++-
 drivers/net/wireless/ath/ath12k/htc.c              |     3 +-
 drivers/net/wireless/ath/ath12k/hw.c               |  1680 ---
 drivers/net/wireless/ath/ath12k/hw.h               |    96 +-
 drivers/net/wireless/ath/ath12k/mac.c              |  1255 +-
 drivers/net/wireless/ath/ath12k/mac.h              |   142 +-
 drivers/net/wireless/ath/ath12k/mhi.c              |   132 +-
 drivers/net/wireless/ath/ath12k/mhi.h              |     5 +-
 drivers/net/wireless/ath/ath12k/pci.c              |   255 +-
 drivers/net/wireless/ath/ath12k/pci.h              |    49 +-
 drivers/net/wireless/ath/ath12k/peer.c             |   453 +-
 drivers/net/wireless/ath/ath12k/peer.h             |   112 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |   180 +-
 drivers/net/wireless/ath/ath12k/qmi.h              |    16 +
 drivers/net/wireless/ath/ath12k/testmode.c         |     3 +-
 drivers/net/wireless/ath/ath12k/wifi7/Makefile     |    20 +
 drivers/net/wireless/ath/ath12k/wifi7/ahb.c        |    75 +
 drivers/net/wireless/ath/ath12k/wifi7/ahb.h        |    20 +
 drivers/net/wireless/ath/ath12k/wifi7/ce.c         |   973 ++
 drivers/net/wireless/ath/ath12k/wifi7/ce.h         |    22 +
 drivers/net/wireless/ath/ath12k/wifi7/core.c       |    68 +
 drivers/net/wireless/ath/ath12k/wifi7/core.h       |    11 +
 drivers/net/wireless/ath/ath12k/wifi7/dp.c         |   181 +
 drivers/net/wireless/ath/ath12k/wifi7/dp.h         |    20 +
 drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c     |  3385 +++++
 drivers/net/wireless/ath/ath12k/wifi7/dp_mon.h     |    23 +
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c      |  2246 ++++
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h      |    60 +
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c      |   978 ++
 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h      |    16 +
 drivers/net/wireless/ath/ath12k/wifi7/hal.c        |   713 ++
 drivers/net/wireless/ath/ath12k/wifi7/hal.h        |   561 +
 .../net/wireless/ath/ath12k/{ => wifi7}/hal_desc.h |   331 +-
 .../net/wireless/ath/ath12k/wifi7/hal_qcc2072.c    |   503 +
 .../net/wireless/ath/ath12k/wifi7/hal_qcc2072.h    |    13 +
 .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.c    |  1038 ++
 .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.h    |    45 +
 .../net/wireless/ath/ath12k/{ => wifi7}/hal_rx.c   |   284 +-
 .../net/wireless/ath/ath12k/{ => wifi7}/hal_rx.h   |   424 +-
 .../ath/ath12k/{rx_desc.h => wifi7/hal_rx_desc.h}  |    72 +-
 .../net/wireless/ath/ath12k/{ => wifi7}/hal_tx.c   |    23 +-
 .../net/wireless/ath/ath12k/{ => wifi7}/hal_tx.h   |    30 +-
 .../net/wireless/ath/ath12k/wifi7/hal_wcn7850.c    |   809 ++
 .../net/wireless/ath/ath12k/wifi7/hal_wcn7850.h    |    40 +
 drivers/net/wireless/ath/ath12k/wifi7/hw.c         |  1049 ++
 drivers/net/wireless/ath/ath12k/wifi7/hw.h         |    13 +
 drivers/net/wireless/ath/ath12k/wifi7/mhi.c        |   138 +
 drivers/net/wireless/ath/ath12k/wifi7/mhi.h        |    11 +
 drivers/net/wireless/ath/ath12k/wifi7/pci.c        |   215 +
 drivers/net/wireless/ath/ath12k/wifi7/pci.h        |    12 +
 drivers/net/wireless/ath/ath12k/wifi7/wmi.c        |   110 +
 drivers/net/wireless/ath/ath12k/wifi7/wmi.h        |    15 +
 drivers/net/wireless/ath/ath12k/wmi.c              |   334 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |    61 +-
 drivers/net/wireless/ath/ath12k/wow.c              |    21 +-
 drivers/net/wireless/ath/ath5k/debug.h             |     4 +-
 drivers/net/wireless/ath/ath9k/Kconfig             |     2 +-
 drivers/net/wireless/ath/ath9k/common-debug.h      |     8 +-
 drivers/net/wireless/ath/ath9k/common.c            |    12 -
 drivers/net/wireless/ath/ath9k/debug.h             |    15 +-
 drivers/net/wireless/ath/wil6210/wil6210.h         |    33 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |     4 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.h         |     8 +-
 .../wireless/broadcom/brcm80211/brcmfmac/core.c    |     4 +-
 .../broadcom/brcm80211/brcmsmac/phy/phy_lcn.c      |     9 +-
 drivers/net/wireless/intel/iwlegacy/3945-mac.c     |     2 +
 drivers/net/wireless/intel/iwlegacy/3945-rs.c      |     7 +-
 drivers/net/wireless/intel/iwlegacy/4965-mac.c     |     2 +
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |    12 -
 drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c     |    12 +
 drivers/net/wireless/intel/iwlwifi/cfg/rf-pe.c     |     1 -
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |   117 +-
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h    |   159 +-
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |    34 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  |     2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h     |    41 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     |    95 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |     2 +
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c |   206 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h |     9 +-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h    |    17 +-
 drivers/net/wireless/intel/iwlwifi/fw/smem.c       |     8 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c       |    72 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h       |     2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |     1 -
 drivers/net/wireless/intel/iwlwifi/mld/Makefile    |     2 +-
 drivers/net/wireless/intel/iwlwifi/mld/d3.c        |     2 -
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c   |     6 +-
 drivers/net/wireless/intel/iwlwifi/mld/iface.c     |    21 +-
 drivers/net/wireless/intel/iwlwifi/mld/iface.h     |     2 +
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c  |   114 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c       |     3 +
 drivers/net/wireless/intel/iwlwifi/mld/mld.h       |     3 +
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c       |    59 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.h       |     5 +
 drivers/net/wireless/intel/iwlwifi/mld/nan.c       |   299 +
 drivers/net/wireless/intel/iwlwifi/mld/nan.h       |    28 +
 drivers/net/wireless/intel/iwlwifi/mld/notif.c     |    13 +
 drivers/net/wireless/intel/iwlwifi/mld/notif.h     |     1 +
 drivers/net/wireless/intel/iwlwifi/mld/power.c     |    37 +-
 .../net/wireless/intel/iwlwifi/mld/regulatory.c    |    66 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c        |   142 +-
 drivers/net/wireless/intel/iwlwifi/mld/scan.c      |    12 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.c       |     3 +-
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c       |    85 +-
 drivers/net/wireless/intel/iwlwifi/mld/tx.c        |    11 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |    51 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   202 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      |    22 -
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |    25 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |    68 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c   |     6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c   |    29 -
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |   193 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |    28 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |    60 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |     8 -
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |    18 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c      |     4 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |    39 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.h    |     4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |    51 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |     4 -
 drivers/net/wireless/intersil/p54/main.c           |     4 +-
 drivers/net/wireless/marvell/libertas/if_usb.c     |     2 +
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |    13 +-
 drivers/net/wireless/realtek/rtl8xxxu/core.c       |     1 +
 .../wireless/realtek/rtlwifi/btcoexist/rtl_btc.c   |    13 -
 drivers/net/wireless/realtek/rtlwifi/regd.c        |     2 +-
 drivers/net/wireless/realtek/rtw88/main.c          |    54 +-
 drivers/net/wireless/realtek/rtw88/main.h          |     2 +-
 drivers/net/wireless/realtek/rtw88/phy.c           |    20 +
 drivers/net/wireless/realtek/rtw88/phy.h           |     2 +
 drivers/net/wireless/realtek/rtw88/rtw8723cs.c     |     2 +-
 drivers/net/wireless/realtek/rtw88/rtw8723ds.c     |     2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821cs.c     |     2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821cu.c     |     2 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c      |     3 +-
 drivers/net/wireless/realtek/rtw88/rtw8822bs.c     |     2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822cs.c     |     2 +-
 drivers/net/wireless/realtek/rtw88/sdio.c          |     3 +-
 drivers/net/wireless/realtek/rtw88/sdio.h          |     2 +-
 drivers/net/wireless/realtek/rtw88/usb.c           |     3 +-
 drivers/net/wireless/realtek/rtw89/cam.c           |   134 +
 drivers/net/wireless/realtek/rtw89/cam.h           |   129 +
 drivers/net/wireless/realtek/rtw89/chan.c          |    69 +-
 drivers/net/wireless/realtek/rtw89/chan.h          |     2 +
 drivers/net/wireless/realtek/rtw89/core.c          |   237 +-
 drivers/net/wireless/realtek/rtw89/core.h          |   198 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |   162 +-
 drivers/net/wireless/realtek/rtw89/debug.h         |     1 +
 drivers/net/wireless/realtek/rtw89/efuse.c         |     4 -
 drivers/net/wireless/realtek/rtw89/efuse.h         |     6 +
 drivers/net/wireless/realtek/rtw89/efuse_be.c      |    26 +
 drivers/net/wireless/realtek/rtw89/fw.c            |  1203 +-
 drivers/net/wireless/realtek/rtw89/fw.h            |   521 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |   199 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |   102 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |    44 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |   696 +-
 drivers/net/wireless/realtek/rtw89/pci.c           |    22 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |    57 +-
 drivers/net/wireless/realtek/rtw89/pci_be.c        |   138 +-
 drivers/net/wireless/realtek/rtw89/phy.c           |   428 +-
 drivers/net/wireless/realtek/rtw89/phy.h           |    36 +-
 drivers/net/wireless/realtek/rtw89/phy_be.c        |   563 +-
 drivers/net/wireless/realtek/rtw89/ps.c            |     4 +-
 drivers/net/wireless/realtek/rtw89/reg.h           |   934 +-
 drivers/net/wireless/realtek/rtw89/regd.c          |    21 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |    10 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |    10 +-
 drivers/net/wireless/realtek/rtw89/rtw8852au.c     |     4 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |    32 +-
 .../net/wireless/realtek/rtw89/rtw8852b_common.c   |     2 -
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |     8 +
 drivers/net/wireless/realtek/rtw89/rtw8852bu.c     |     2 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |    10 +-
 drivers/net/wireless/realtek/rtw89/rtw8852cu.c     |     2 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |    89 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c  |    48 +-
 drivers/net/wireless/realtek/rtw89/ser.c           |    10 +
 drivers/net/wireless/realtek/rtw89/txrx.h          |    22 +
 drivers/net/wireless/realtek/rtw89/usb.c           |     2 +-
 drivers/net/wireless/realtek/rtw89/wow.c           |    14 +-
 drivers/net/wireless/realtek/rtw89/wow.h           |     1 +
 drivers/net/wireless/rsi/rsi_91x_main.c            |    29 -
 drivers/net/wireless/rsi/rsi_91x_sdio.c            |     5 +-
 drivers/net/wireless/ti/wl1251/acx.c               |    11 +-
 drivers/net/wireless/ti/wlcore/cmd.h               |     1 +
 drivers/net/wireless/ti/wlcore/main.c              |     9 +
 drivers/net/wireless/ti/wlcore/sdio.c              |     6 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c      |     2 -
 drivers/net/wwan/Kconfig                           |     1 +
 drivers/net/wwan/mhi_wwan_ctrl.c                   |     1 +
 drivers/net/wwan/mhi_wwan_mbim.c                   |     3 +-
 drivers/net/wwan/wwan_core.c                       |   278 +-
 drivers/net/wwan/wwan_hwsim.c                      |   201 +-
 drivers/net/xen-netback/hash.c                     |     2 +-
 drivers/net/xen-netfront.c                         |    24 +-
 drivers/nfc/nxp-nci/i2c.c                          |     2 +-
 drivers/phy/Kconfig                                |    22 +
 drivers/phy/Makefile                               |     2 +
 drivers/phy/phy-common-props-test.c                |   422 +
 drivers/phy/phy-common-props.c                     |   209 +
 drivers/ptp/Kconfig                                |     2 +-
 drivers/ptp/ptp_ocp.c                              |    18 +-
 drivers/ptp/ptp_vmclock.c                          |   236 +-
 drivers/vhost/vsock.c                              |    44 +-
 include/crypto/sha1.h                              |    10 -
 include/dt-bindings/phy/phy.h                      |     4 +
 include/linux/audit.h                              |     1 -
 include/linux/bnge/hsi.h                           | 12609 +++++++++++++++++++
 include/linux/bnxt/hsi.h                           |   167 +-
 include/linux/can/core.h                           |     1 +
 include/linux/can/skb.h                            |    38 +-
 include/linux/clk.h                                |    23 +
 include/linux/console.h                            |     8 +
 include/linux/dpll.h                               |    64 +-
 include/linux/ethtool.h                            |    36 +-
 include/linux/framer/framer.h                      |     5 +-
 include/linux/hippidevice.h                        |    40 -
 include/linux/ieee80211-eht.h                      |    13 +-
 include/linux/ieee80211-s1g.h                      |     2 +-
 include/linux/ieee80211-uhr.h                      |   220 +
 include/linux/ieee80211.h                          |    40 +-
 include/linux/if_vlan.h                            |    51 +-
 include/linux/inetdevice.h                         |     2 +-
 include/linux/ipv6.h                               |    35 +-
 include/linux/mdio.h                               |    14 +-
 include/linux/mlx5/device.h                        |     5 +
 include/linux/mlx5/driver.h                        |     1 +
 include/linux/mlx5/mlx5_ifc.h                      |    16 +-
 include/linux/mlx5/port.h                          |     2 +-
 include/linux/mlx5/vport.h                         |     6 +
 include/linux/mmc/sdio_func.h                      |     1 +
 include/linux/mod_devicetable.h                    |     1 -
 include/linux/netdevice.h                          |     6 +-
 include/linux/netfilter/nf_conntrack_proto_gre.h   |     3 -
 include/linux/pci_ids.h                            |     3 -
 include/linux/pcs/pcs-mtk-lynxi.h                  |     5 +-
 include/linux/phy.h                                |    72 +-
 include/linux/phy/phy-common-props.h               |    32 +
 include/linux/phy_port.h                           |    99 +
 include/linux/phylink.h                            |    12 +-
 include/linux/skbuff.h                             |     6 +-
 include/linux/skbuff_ref.h                         |    10 +-
 include/linux/stmmac.h                             |    20 +-
 include/linux/tcp.h                                |     9 +-
 include/linux/u64_stats_sync.h                     |    25 +
 include/linux/udp.h                                |     2 +-
 include/linux/usb/usbnet.h                         |     1 +
 include/linux/virtio_vsock.h                       |     9 +-
 include/linux/wwan.h                               |     2 +
 include/net/af_vsock.h                             |    61 +-
 include/net/ax25.h                                 |     8 +-
 include/net/bluetooth/bluetooth.h                  |    47 +-
 include/net/bluetooth/hci.h                        |   336 +-
 include/net/bluetooth/hci_core.h                   |     9 +
 include/net/bluetooth/hci_sync.h                   |     3 +
 include/net/bluetooth/l2cap.h                      |     3 +-
 include/net/bonding.h                              |     2 +
 include/net/can.h                                  |    28 +
 include/net/cfg80211.h                             |   117 +-
 include/net/dsa.h                                  |    12 +-
 include/net/dst.h                                  |     6 +
 include/net/flow_offload.h                         |    34 +-
 include/net/gro.h                                  |     5 +-
 include/net/inet6_connection_sock.h                |     4 +-
 include/net/inet_ecn.h                             |    20 +-
 include/net/inet_sock.h                            |    24 +-
 include/net/ip6_route.h                            |     6 +
 include/net/ipv6.h                                 |   145 +-
 include/net/iucv/iucv.h                            |   207 +-
 include/net/l3mdev.h                               |     7 +-
 include/net/mac80211.h                             |   140 +-
 include/net/mana/gdma.h                            |     7 +-
 include/net/mana/mana.h                            |     3 +-
 include/net/net_namespace.h                        |     5 +
 include/net/netdev_queues.h                        |    73 +-
 include/net/netdev_rx_queue.h                      |     2 +
 include/net/netfilter/nf_conntrack.h               |     1 +
 include/net/netfilter/nf_conntrack_count.h         |     1 +
 include/net/netfilter/nf_conntrack_tuple.h         |     2 +-
 include/net/netfilter/nf_queue.h                   |     4 +
 include/net/netfilter/nf_tables.h                  |     7 +-
 include/net/netfilter/nf_tables_ipv6.h             |     4 +-
 include/net/netmem.h                               |    32 +-
 include/net/netns/ipv6.h                           |    10 +-
 include/net/netns/vsock.h                          |    21 +
 include/net/page_pool/types.h                      |     1 +
 include/net/phy/realtek_phy.h                      |     7 +
 include/net/pkt_sched.h                            |    24 +
 include/net/request_sock.h                         |    11 +-
 include/net/sch_priv.h                             |    27 +
 include/net/sock.h                                 |    11 +-
 include/net/tcp.h                                  |   103 +-
 include/net/tcp_ecn.h                              |   103 +-
 include/net/udp.h                                  |     8 +-
 include/net/udp_tunnel.h                           |    32 +
 include/net/xfrm.h                                 |    10 +-
 include/net/xsk_buff_pool.h                        |     5 -
 include/trace/events/mptcp.h                       |    80 +
 include/trace/events/tcp.h                         |     2 +-
 include/uapi/linux/dpll.h                          |     1 +
 include/uapi/linux/ethtool.h                       |    28 +-
 include/uapi/linux/if_link.h                       |     1 +
 include/uapi/linux/mptcp_pm.h                      |     2 +-
 include/uapi/linux/netfilter_bridge.h              |     9 +-
 include/uapi/linux/netfilter_ipv4.h                |     9 +-
 include/uapi/linux/netfilter_ipv6.h                |     7 +-
 include/uapi/linux/nl80211.h                       |   107 +-
 include/uapi/linux/pkt_sched.h                     |     1 +
 include/uapi/linux/tcp.h                           |    26 +-
 include/uapi/linux/typelimits.h                    |     8 +
 include/uapi/linux/vmclock-abi.h                   |    20 +
 kernel/printk/internal.h                           |     8 +
 kernel/printk/nbcon.c                              |    16 +
 kernel/printk/printk.c                             |    54 +-
 kernel/printk/printk_ringbuffer.h                  |     5 +
 lib/Kconfig.debug                                  |    12 +
 lib/crypto/sha1.c                                  |    63 +-
 net/802/Makefile                                   |     1 -
 net/802/hippi.c                                    |   193 -
 net/atm/signaling.c                                |    56 +-
 net/ax25/Kconfig                                   |    14 -
 net/ax25/ax25_dev.c                                |     2 -
 net/bluetooth/hci_conn.c                           |   162 +-
 net/bluetooth/hci_core.c                           |     1 +
 net/bluetooth/hci_event.c                          |    79 +-
 net/bluetooth/hci_sync.c                           |   125 +-
 net/bluetooth/iso.c                                |    10 +-
 net/bluetooth/l2cap_core.c                         |    46 +-
 net/bluetooth/l2cap_sock.c                         |    20 +-
 net/bluetooth/mgmt_config.c                        |    21 +
 net/bridge/br_multicast.c                          |     2 +-
 net/bridge/br_netfilter_ipv6.c                     |     2 +-
 net/bridge/br_stp_if.c                             |     8 +-
 net/bridge/br_sysfs_br.c                           |   108 +-
 net/bridge/br_sysfs_if.c                           |    32 +-
 net/bridge/netfilter/nf_conntrack_bridge.c         |     7 +-
 net/can/Kconfig                                    |     1 +
 net/can/af_can.c                                   |    23 +-
 net/can/bcm.c                                      |    26 +-
 net/can/gw.c                                       |    42 +-
 net/can/isotp.c                                    |    46 +-
 net/can/j1939/socket.c                             |    16 +-
 net/can/j1939/transport.c                          |    39 +-
 net/can/raw.c                                      |    23 +-
 net/core/Makefile                                  |     3 +-
 net/core/dev.c                                     |    24 +-
 net/core/dev.h                                     |     5 +
 net/core/dev_ioctl.c                               |    60 +-
 net/core/devmem.c                                  |    27 +-
 net/core/devmem.h                                  |    17 +-
 net/core/gro.c                                     |     4 +-
 net/core/neighbour.c                               |   150 +-
 net/core/net_namespace.c                           |    34 +-
 net/core/netdev_config.c                           |    78 +
 net/core/netdev_rx_queue.c                         |    53 +-
 net/core/request_sock.c                            |   127 -
 net/core/skbuff.c                                  |   166 +-
 net/core/sock.c                                    |    16 +-
 net/core/sysctl_net_core.c                         |    11 +-
 net/devlink/core.c                                 |     6 +-
 net/devlink/dev.c                                  |     7 +-
 net/devlink/devl_internal.h                        |     6 +-
 net/devlink/rate.c                                 |    13 +-
 net/dsa/Kconfig                                    |     7 +
 net/dsa/Makefile                                   |     1 +
 net/dsa/tag_mxl862xx.c                             |   110 +
 net/dsa/tag_yt921x.c                               |    89 +-
 net/dsa/user.c                                     |     5 +-
 net/ethtool/common.c                               |   301 +-
 net/hsr/hsr_framereg.c                             |   362 +-
 net/hsr/hsr_framereg.h                             |    39 +-
 net/hsr/prp_dup_discard_test.c                     |   156 +-
 net/ipv4/Makefile                                  |     2 +-
 net/ipv4/cipso_ipv4.c                              |     3 +-
 net/ipv4/fib_lookup.h                              |     6 +-
 net/ipv4/fib_trie.c                                |     4 +-
 net/ipv4/icmp.c                                    |   139 +-
 net/ipv4/igmp.c                                    |     4 +-
 net/ipv4/inet_connection_sock.c                    |    24 +-
 net/ipv4/ip_output.c                               |    17 +-
 net/ipv4/ip_sockglue.c                             |     2 +-
 net/ipv4/ipconfig.c                                |    89 +-
 net/ipv4/ipmr.c                                    |     2 +-
 net/ipv4/metrics.c                                 |     2 +-
 net/ipv4/netfilter/nf_reject_ipv4.c                |     2 +-
 net/ipv4/ping.c                                    |     7 +-
 net/ipv4/raw.c                                     |     7 +-
 net/ipv4/route.c                                   |     8 +-
 net/ipv4/sysctl_net_ipv4.c                         |     4 +-
 net/ipv4/tcp.c                                     |    84 +-
 net/ipv4/tcp_cong.c                                |     5 +-
 net/ipv4/tcp_fastopen.c                            |    86 +
 net/ipv4/tcp_input.c                               |   305 +-
 net/ipv4/tcp_ipv4.c                                |    37 +-
 net/ipv4/tcp_minisocks.c                           |    43 +-
 net/ipv4/tcp_offload.c                             |     3 +-
 net/ipv4/tcp_output.c                              |   117 +-
 net/ipv4/tcp_rate.c                                |   209 -
 net/ipv4/tcp_recovery.c                            |    75 -
 net/ipv4/tcp_timer.c                               |     3 +
 net/ipv4/udp.c                                     |    32 +-
 net/ipv4/udp_offload.c                             |     6 +-
 net/ipv6/Makefile                                  |     2 +-
 net/ipv6/addrconf.c                                |    23 +-
 net/ipv6/af_inet6.c                                |    61 +-
 net/ipv6/datagram.c                                |    21 +-
 net/ipv6/exthdrs.c                                 |    79 +-
 net/ipv6/icmp.c                                    |     9 +-
 net/ipv6/inet6_connection_sock.c                   |    65 +-
 net/ipv6/ip6_fib.c                                 |    12 +-
 net/ipv6/ip6_gre.c                                 |     2 +-
 net/ipv6/ip6_input.c                               |     2 +-
 net/ipv6/ip6_offload.c                             |    79 +-
 net/ipv6/ip6_output.c                              |   122 +-
 net/ipv6/ip6_tunnel.c                              |    33 +-
 net/ipv6/ipv6_sockglue.c                           |     4 +-
 net/ipv6/output_core.c                             |     7 +-
 net/ipv6/raw.c                                     |    34 +-
 net/ipv6/route.c                                   |    41 +-
 net/ipv6/sit.c                                     |     2 +-
 net/ipv6/tcp_ipv6.c                                |    78 +-
 net/ipv6/tcpv6_offload.c                           |    12 +-
 net/ipv6/udp.c                                     |     5 +-
 net/ipv6/udp_offload.c                             |     3 +-
 net/iucv/iucv.c                                    |   227 +-
 net/mac80211/Makefile                              |     2 +-
 net/mac80211/cfg.c                                 |    60 +-
 net/mac80211/driver-ops.h                          |    21 +
 net/mac80211/drop.h                                |    46 +-
 net/mac80211/eht.c                                 |   175 +
 net/mac80211/ieee80211_i.h                         |    36 +-
 net/mac80211/iface.c                               |    18 +-
 net/mac80211/link.c                                |     4 +-
 net/mac80211/main.c                                |    15 +-
 net/mac80211/mlme.c                                |   164 +-
 net/mac80211/parse.c                               |    25 +-
 net/mac80211/rx.c                                  |   148 +-
 net/mac80211/sta_info.c                            |    35 +-
 net/mac80211/sta_info.h                            |    84 +-
 net/mac80211/trace.h                               |    32 +
 net/mac80211/tx.c                                  |     4 +-
 net/mac80211/uhr.c                                 |    30 +
 net/mac80211/util.c                                |   126 +-
 net/mac80211/wpa.c                                 |     6 +-
 net/mptcp/pm_kernel.c                              |    29 +-
 net/mptcp/protocol.c                               |   275 +-
 net/mptcp/protocol.h                               |    12 +-
 net/mptcp/subflow.c                                |     2 -
 net/mptcp/token.c                                  |    16 +-
 net/netfilter/ipvs/ip_vs_xmit.c                    |     2 +-
 net/netfilter/nf_conncount.c                       |    30 +-
 net/netfilter/nf_conntrack_bpf.c                   |     1 +
 net/netfilter/nf_conntrack_h323_main.c             |     1 +
 net/netfilter/nf_conntrack_netlink.c               |     1 +
 net/netfilter/nf_conntrack_ovs.c                   |     2 +-
 net/netfilter/nf_conntrack_proto_generic.c         |     1 +
 net/netfilter/nf_conntrack_proto_gre.c             |     2 +
 net/netfilter/nf_conntrack_proto_icmp.c            |     1 +
 net/netfilter/nf_conntrack_proto_icmpv6.c          |     1 +
 net/netfilter/nf_flow_table_core.c                 |    12 +-
 net/netfilter/nf_flow_table_ip.c                   |   245 +-
 net/netfilter/nf_flow_table_offload.c              |     1 +
 net/netfilter/nf_flow_table_path.c                 |     1 +
 net/netfilter/nf_log_syslog.c                      |     2 +-
 net/netfilter/nf_nat_ovs.c                         |     3 +
 net/netfilter/nf_nat_proto.c                       |     1 +
 net/netfilter/nf_synproxy_core.c                   |     1 +
 net/netfilter/nf_tables_api.c                      |    37 +-
 net/netfilter/nfnetlink_queue.c                    |   342 +-
 net/netfilter/nft_compat.c                         |    13 +-
 net/netfilter/nft_counter.c                        |     4 +-
 net/netfilter/nft_flow_offload.c                   |     1 +
 net/netfilter/nft_set_hash.c                       |     9 +-
 net/netfilter/nft_set_pipapo.c                     |     2 +
 net/netfilter/nft_set_rbtree.c                     |   800 +-
 net/netfilter/nft_synproxy.c                       |     1 +
 net/netfilter/xt_tcpmss.c                          |     2 +-
 net/netfilter/xt_time.c                            |     8 +-
 net/nfc/hci/llc_shdlc.c                            |     8 +
 net/packet/af_packet.c                             |     5 +-
 net/rds/cong.c                                     |     2 +-
 net/rds/connection.c                               |    38 +-
 net/rds/ib_recv.c                                  |     2 +-
 net/rds/ib_send.c                                  |    44 +-
 net/rds/message.c                                  |    66 +-
 net/rds/rds.h                                      |   170 +-
 net/rds/recv.c                                     |    39 +-
 net/rds/send.c                                     |   139 +-
 net/rds/stats.c                                    |     1 +
 net/rds/tcp.c                                      |    28 +-
 net/rds/tcp.h                                      |    27 +-
 net/rds/tcp_connect.c                              |    79 +-
 net/rds/tcp_listen.c                               |   212 +-
 net/rds/tcp_recv.c                                 |     6 +-
 net/rds/tcp_send.c                                 |     4 +-
 net/rds/threads.c                                  |    16 +-
 net/sched/act_ct.c                                 |     2 +
 net/sched/act_ctinfo.c                             |     1 +
 net/sched/sch_api.c                                |     2 +-
 net/sched/sch_cake.c                               |   495 +-
 net/sched/sch_fq.c                                 |    28 +-
 net/sched/sch_generic.c                            |     8 +-
 net/sched/sch_mq.c                                 |    71 +-
 net/smc/af_smc.c                                   |    91 +-
 net/tipc/crypto.c                                  |     2 +-
 net/unix/af_unix.c                                 |    11 +-
 net/vmw_vsock/af_vsock.c                           |   335 +-
 net/vmw_vsock/hyperv_transport.c                   |     7 +-
 net/vmw_vsock/virtio_transport.c                   |    22 +-
 net/vmw_vsock/virtio_transport_common.c            |    62 +-
 net/vmw_vsock/vmci_transport.c                     |    28 +-
 net/vmw_vsock/vsock_loopback.c                     |    22 +-
 net/wireless/core.c                                |    38 +-
 net/wireless/core.h                                |     4 +-
 net/wireless/nl80211.c                             |   172 +-
 net/wireless/pmsr.c                                |    27 +-
 net/wireless/reg.c                                 |    17 +-
 net/wireless/scan.c                                |     2 +-
 net/wireless/sysfs.c                               |     2 +-
 net/wireless/trace.h                               |    13 +-
 net/wireless/util.c                                |   106 +-
 net/xdp/xsk.c                                      |    15 +-
 net/xdp/xsk_buff_pool.c                            |     6 +-
 net/xdp/xsk_queue.h                                |     5 +
 rust/kernel/net/phy.rs                             |     6 +-
 rust/kernel/pci/id.rs                              |     1 -
 tools/net/ynl/pyynl/cli.py                         |   285 +-
 tools/net/ynl/pyynl/ethtool.py                     |    47 +-
 tools/net/ynl/pyynl/lib/__init__.py                |    10 +-
 tools/net/ynl/pyynl/lib/doc_generator.py           |     3 +-
 tools/net/ynl/pyynl/lib/nlspec.py                  |    77 +-
 tools/net/ynl/pyynl/lib/ynl.py                     |   208 +-
 tools/net/ynl/pyynl/ynl_gen_c.py                   |   178 +-
 tools/net/ynl/pyynl/ynl_gen_rst.py                 |     2 +
 tools/net/ynl/ynltool/Makefile                     |     2 +-
 tools/net/ynl/ynltool/qstats.c                     |   171 +-
 tools/testing/selftests/Makefile                   |     1 +
 tools/testing/selftests/drivers/net/Makefile       |     6 -
 tools/testing/selftests/drivers/net/gro.c          |   543 +-
 tools/testing/selftests/drivers/net/gro.py         |   166 +-
 tools/testing/selftests/drivers/net/hw/Makefile    |     1 +
 tools/testing/selftests/drivers/net/hw/iou-zcrx.c  |    72 +-
 tools/testing/selftests/drivers/net/hw/iou-zcrx.py |   157 +-
 tools/testing/selftests/drivers/net/hw/ncdevmem.c  |     1 +
 .../selftests/drivers/net/hw/nic_timestamp.py      |   128 +-
 tools/testing/selftests/drivers/net/hw/rss_drv.py  |    88 +
 .../selftests/drivers/net/hw/rss_flow_label.py     |    11 +-
 .../selftests/drivers/net/hw/rss_input_xfrm.py     |    44 +-
 tools/testing/selftests/drivers/net/hw/toeplitz.c  |    28 +-
 tools/testing/selftests/drivers/net/lib/py/env.py  |     8 +-
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |    35 +-
 .../selftests/drivers/net/netconsole/Makefile      |    19 +
 .../selftests/drivers/net/netconsole/config        |     6 +
 .../drivers/net/{ => netconsole}/netcons_basic.sh  |     2 +-
 .../net/{ => netconsole}/netcons_cmdline.sh        |     2 +-
 .../net/{ => netconsole}/netcons_fragmented_msg.sh |     2 +-
 .../net/{ => netconsole}/netcons_overflow.sh       |     2 +-
 .../drivers/net/netconsole/netcons_resume.sh       |   124 +
 .../net/{ => netconsole}/netcons_sysdata.sh        |     2 +-
 .../net/{ => netconsole}/netcons_torture.sh        |     2 +-
 tools/testing/selftests/drivers/net/psp.py         |     6 +-
 .../testing/selftests/drivers/net/psp_responder.c  |    50 +-
 tools/testing/selftests/net/.gitignore             |     1 +
 tools/testing/selftests/net/Makefile               |    18 +-
 tools/testing/selftests/net/config                 |     1 +
 tools/testing/selftests/net/double_udp_encap.sh    |   393 +
 tools/testing/selftests/net/fib-onlink-tests.sh    |    28 +-
 .../selftests/net/forwarding/local_termination.sh  |    18 +-
 tools/testing/selftests/net/hsr/Makefile           |     2 +
 tools/testing/selftests/net/hsr/hsr_ping.sh        |   207 +-
 tools/testing/selftests/net/hsr/link_faults.sh     |   378 +
 tools/testing/selftests/net/hsr/prp_ping.sh        |   147 +
 tools/testing/selftests/net/hsr/settings           |     2 +-
 tools/testing/selftests/net/icmp_rfc4884.c         |   679 +
 tools/testing/selftests/net/ioam6.sh               |     2 +-
 tools/testing/selftests/net/ipsec.c                |    11 +-
 tools/testing/selftests/net/lib/csum.c             |     2 +-
 tools/testing/selftests/net/lib/py/ksft.py         |    44 +-
 tools/testing/selftests/net/lib/py/utils.py        |    32 +-
 tools/testing/selftests/net/mptcp/Makefile         |     1 +
 tools/testing/selftests/net/mptcp/mptcp_connect.c  |    98 +-
 .../selftests/net/mptcp/mptcp_connect_splice.sh    |     5 +
 tools/testing/selftests/net/mptcp/mptcp_diag.c     |    27 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |   107 +-
 tools/testing/selftests/net/netfilter/config       |     1 +
 .../selftests/net/netfilter/nft_flowtable.sh       |    69 +-
 tools/testing/selftests/net/netfilter/nft_queue.sh |   142 +-
 .../packetdrill/tcp_accecn_2nd_data_as_first.pkt   |    24 +
 .../tcp_accecn_2nd_data_as_first_connect.pkt       |    30 +
 .../tcp_accecn_3rd_ack_after_synack_rxmt.pkt       |    19 +
 .../tcp_accecn_3rd_ack_ce_updates_received_ce.pkt  |    18 +
 .../tcp_accecn_3rd_ack_lost_data_ce.pkt            |    22 +
 .../net/packetdrill/tcp_accecn_3rd_dups.pkt        |    26 +
 .../packetdrill/tcp_accecn_acc_ecn_disabled.pkt    |    13 +
 .../tcp_accecn_accecn_then_notecn_syn.pkt          |    28 +
 .../packetdrill/tcp_accecn_accecn_to_rfc3168.pkt   |    18 +
 .../tcp_accecn_client_accecn_options_drop.pkt      |    34 +
 .../tcp_accecn_client_accecn_options_lost.pkt      |    38 +
 .../packetdrill/tcp_accecn_clientside_disabled.pkt |    12 +
 ...cp_accecn_close_local_close_then_remote_fin.pkt |    25 +
 .../tcp_accecn_delivered_2ndlargeack.pkt           |    25 +
 .../tcp_accecn_delivered_falseoverflow_detect.pkt  |    31 +
 .../packetdrill/tcp_accecn_delivered_largeack.pkt  |    24 +
 .../packetdrill/tcp_accecn_delivered_largeack2.pkt |    25 +
 .../packetdrill/tcp_accecn_delivered_maxack.pkt    |    25 +
 .../packetdrill/tcp_accecn_delivered_updates.pkt   |    70 +
 .../selftests/net/packetdrill/tcp_accecn_ecn3.pkt  |    12 +
 .../tcp_accecn_ecn_field_updates_opt.pkt           |    35 +
 .../net/packetdrill/tcp_accecn_ipflags_drop.pkt    |    14 +
 .../net/packetdrill/tcp_accecn_listen_opt_drop.pkt |    16 +
 .../tcp_accecn_multiple_syn_ack_drop.pkt           |    28 +
 .../packetdrill/tcp_accecn_multiple_syn_drop.pkt   |    18 +
 .../packetdrill/tcp_accecn_negotiation_bleach.pkt  |    23 +
 .../packetdrill/tcp_accecn_negotiation_connect.pkt |    23 +
 .../packetdrill/tcp_accecn_negotiation_listen.pkt  |    26 +
 .../tcp_accecn_negotiation_noopt_connect.pkt       |    23 +
 .../tcp_accecn_negotiation_optenable.pkt           |    23 +
 .../packetdrill/tcp_accecn_no_ecn_after_accecn.pkt |    20 +
 .../selftests/net/packetdrill/tcp_accecn_noopt.pkt |    27 +
 .../net/packetdrill/tcp_accecn_noprogress.pkt      |    27 +
 .../tcp_accecn_notecn_then_accecn_syn.pkt          |    28 +
 .../packetdrill/tcp_accecn_rfc3168_to_fallback.pkt |    18 +
 .../packetdrill/tcp_accecn_rfc3168_to_rfc3168.pkt  |    18 +
 .../net/packetdrill/tcp_accecn_sack_space_grab.pkt |    28 +
 .../tcp_accecn_sack_space_grab_with_ts.pkt         |    39 +
 .../tcp_accecn_serverside_accecn_disabled1.pkt     |    20 +
 .../tcp_accecn_serverside_accecn_disabled2.pkt     |    20 +
 .../packetdrill/tcp_accecn_serverside_broken.pkt   |    19 +
 .../tcp_accecn_serverside_ecn_disabled.pkt         |    19 +
 .../net/packetdrill/tcp_accecn_serverside_only.pkt |    18 +
 ...accecn_syn_ace_flags_acked_after_retransmit.pkt |    18 +
 .../packetdrill/tcp_accecn_syn_ace_flags_drop.pkt  |    16 +
 ...cn_syn_ack_ace_flags_acked_after_retransmit.pkt |    27 +
 .../tcp_accecn_syn_ack_ace_flags_drop.pkt          |    26 +
 .../net/packetdrill/tcp_accecn_syn_ce.pkt          |    13 +
 .../net/packetdrill/tcp_accecn_syn_ect0.pkt        |    13 +
 .../net/packetdrill/tcp_accecn_syn_ect1.pkt        |    13 +
 .../net/packetdrill/tcp_accecn_synack_ce.pkt       |    27 +
 .../tcp_accecn_synack_ce_updates_delivered_ce.pkt  |    22 +
 .../net/packetdrill/tcp_accecn_synack_ect0.pkt     |    24 +
 .../net/packetdrill/tcp_accecn_synack_ect1.pkt     |    24 +
 .../net/packetdrill/tcp_accecn_synack_rexmit.pkt   |    15 +
 .../net/packetdrill/tcp_accecn_synack_rxmt.pkt     |    25 +
 .../net/packetdrill/tcp_accecn_tsnoprogress.pkt    |    26 +
 .../net/packetdrill/tcp_accecn_tsprogress.pkt      |    25 +
 .../selftests/net/packetdrill/tcp_basic_client.pkt |    24 +
 .../selftests/net/packetdrill/tcp_basic_server.pkt |    35 +
 .../tcp_timestamping_tcp_tx_timestamp_bug.pkt      |    70 +
 tools/testing/selftests/net/tfo.c                  |    13 +-
 tools/testing/selftests/net/tfo_passive.sh         |    13 +-
 tools/testing/selftests/net/tls.c                  |    16 +-
 tools/testing/selftests/net/tun.c                  |   898 +-
 tools/testing/selftests/net/tuntap_helpers.h       |   390 +
 tools/testing/selftests/net/txtimestamp.c          |    10 +-
 tools/testing/selftests/ptp/phc.sh                 |    60 +-
 .../tc-testing/tc-tests/qdiscs/cake_mq.json        |   559 +
 tools/testing/selftests/vsock/settings             |     2 +-
 tools/testing/selftests/vsock/vmtest.sh            |  1055 +-
 1252 files changed, 94757 insertions(+), 48974 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/qcom,bluetooth-common.yaml
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/qcom,qca2066-bt.yaml
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/qcom,qca6390-bt.yaml
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/qcom,qca9377-bt.yaml
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/qcom,wcn3950-bt.yaml
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/qcom,wcn3990-bt.yaml
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6750-bt.yaml
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6855-bt.yaml
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/qcom,wcn7850-bt.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
 create mode 100644 Documentation/devicetree/bindings/net/dsa/maxlinear,mxl862xx.yaml
 create mode 100644 Documentation/devicetree/bindings/net/ethernet-connector.yaml
 create mode 100644 Documentation/devicetree/bindings/net/micrel,gigabit.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
 delete mode 100644 Documentation/devicetree/bindings/net/micrel.txt
 create mode 100644 Documentation/devicetree/bindings/net/micrel.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/phy-common-props.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/transmit-amplitude.yaml
 create mode 100644 Documentation/devicetree/bindings/ptp/amazon,vmclock.yaml
 delete mode 100644 Documentation/networking/device_drivers/ethernet/neterion/s2io.rst
 create mode 100644 Documentation/networking/phy-port.rst
 create mode 100644 drivers/infiniband/hw/bng_re/bng_roce_hsi.h
 create mode 100644 drivers/net/dsa/mxl862xx/Kconfig
 create mode 100644 drivers/net/dsa/mxl862xx/Makefile
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-api.h
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-host.c
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-host.h
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx.c
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_txrx.h
 delete mode 100644 drivers/net/ethernet/dnet.c
 delete mode 100644 drivers/net/ethernet/dnet.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_filter.c
 delete mode 100644 drivers/net/ethernet/neterion/Kconfig
 delete mode 100644 drivers/net/ethernet/neterion/Makefile
 delete mode 100644 drivers/net/ethernet/neterion/s2io-regs.h
 delete mode 100644 drivers/net/ethernet/neterion/s2io.c
 delete mode 100644 drivers/net/ethernet/neterion/s2io.h
 delete mode 100644 drivers/net/ethernet/realtek/atp.c
 delete mode 100644 drivers/net/ethernet/realtek/atp.h
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_fdb_tbl.h
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_switch.h
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_switchdev.c
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_switchdev.h
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_vlan_mcast_filter_mmap.h
 delete mode 100644 drivers/net/hippi/Kconfig
 delete mode 100644 drivers/net/hippi/Makefile
 delete mode 100644 drivers/net/hippi/rrunner.c
 delete mode 100644 drivers/net/hippi/rrunner.h
 create mode 100644 drivers/net/phy/phy_port.c
 create mode 100644 drivers/net/wireless/ath/ath11k/cfr.c
 create mode 100644 drivers/net/wireless/ath/ath11k/cfr.h
 create mode 100644 drivers/net/wireless/ath/ath12k/cmn_defs.h
 create mode 100644 drivers/net/wireless/ath/ath12k/dp_cmn.h
 create mode 100644 drivers/net/wireless/ath/ath12k/dp_htt.c
 create mode 100644 drivers/net/wireless/ath/ath12k/dp_htt.h
 create mode 100644 drivers/net/wireless/ath/ath12k/dp_peer.c
 create mode 100644 drivers/net/wireless/ath/ath12k/dp_peer.h
 delete mode 100644 drivers/net/wireless/ath/ath12k/hw.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/Makefile
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/ahb.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/ahb.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/ce.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/ce.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/core.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/core.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_mon.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal.h
 rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_desc.h (91%)
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.h
 rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_rx.c (80%)
 rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_rx.h (75%)
 rename drivers/net/wireless/ath/ath12k/{rx_desc.h => wifi7/hal_rx_desc.h} (97%)
 rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_tx.c (87%)
 rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_tx.h (88%)
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hw.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hw.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/mhi.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/mhi.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/pci.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/pci.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/wmi.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/wmi.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/nan.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/nan.h
 create mode 100644 drivers/phy/phy-common-props-test.c
 create mode 100644 drivers/phy/phy-common-props.c
 create mode 100644 include/linux/bnge/hsi.h
 delete mode 100644 include/linux/hippidevice.h
 create mode 100644 include/linux/ieee80211-uhr.h
 create mode 100644 include/linux/phy/phy-common-props.h
 create mode 100644 include/linux/phy_port.h
 create mode 100644 include/net/can.h
 create mode 100644 include/net/netns/vsock.h
 create mode 100644 include/net/phy/realtek_phy.h
 create mode 100644 include/net/sch_priv.h
 create mode 100644 include/uapi/linux/typelimits.h
 delete mode 100644 net/802/hippi.c
 create mode 100644 net/core/netdev_config.c
 delete mode 100644 net/core/request_sock.c
 create mode 100644 net/dsa/tag_mxl862xx.c
 delete mode 100644 net/ipv4/tcp_rate.c
 create mode 100644 net/mac80211/uhr.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/rss_drv.py
 create mode 100644 tools/testing/selftests/drivers/net/netconsole/Makefile
 create mode 100644 tools/testing/selftests/drivers/net/netconsole/config
 rename tools/testing/selftests/drivers/net/{ => netconsole}/netcons_basic.sh (98%)
 rename tools/testing/selftests/drivers/net/{ => netconsole}/netcons_cmdline.sh (97%)
 rename tools/testing/selftests/drivers/net/{ => netconsole}/netcons_fragmented_msg.sh (98%)
 rename tools/testing/selftests/drivers/net/{ => netconsole}/netcons_overflow.sh (97%)
 create mode 100755 tools/testing/selftests/drivers/net/netconsole/netcons_resume.sh
 rename tools/testing/selftests/drivers/net/{ => netconsole}/netcons_sysdata.sh (99%)
 rename tools/testing/selftests/drivers/net/{ => netconsole}/netcons_torture.sh (98%)
 create mode 100755 tools/testing/selftests/net/double_udp_encap.sh
 create mode 100755 tools/testing/selftests/net/hsr/link_faults.sh
 create mode 100755 tools/testing/selftests/net/hsr/prp_ping.sh
 create mode 100644 tools/testing/selftests/net/icmp_rfc4884.c
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first_connect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_after_synack_rxmt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_ce_updates_received_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_lost_data_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_dups.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_acc_ecn_disabled.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_then_notecn_syn.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_to_rfc3168.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_lost.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_clientside_disabled.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_close_local_close_then_remote_fin.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_2ndlargeack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_falseoverflow_detect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack2.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_maxack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_updates.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_ecn3.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_ecn_field_updates_opt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_ipflags_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_listen_opt_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_ack_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_bleach.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_connect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_listen.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_noopt_connect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_optenable.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_no_ecn_after_accecn.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_noopt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_noprogress.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_notecn_then_accecn_syn.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_fallback.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_rfc3168.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab_with_ts.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled1.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled2.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_broken.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_ecn_disabled.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_only.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_acked_after_retransmit.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_acked_after_retransmit.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect0.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect1.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce_updates_delivered_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect0.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect1.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rexmit.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rxmt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_tsnoprogress.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_tsprogress.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_basic_client.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_basic_server.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_timestamping_tcp_tx_timestamp_bug.pkt
 create mode 100644 tools/testing/selftests/net/tuntap_helpers.h
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/cake_mq.json


