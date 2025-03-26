Return-Path: <netdev+bounces-177789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57602A71BF8
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 17:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF713BDF04
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 16:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F431F4E25;
	Wed, 26 Mar 2025 16:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c26VCAd1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B403716A395;
	Wed, 26 Mar 2025 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007013; cv=none; b=ep1NBOeCKsMdjPgfkdoEVd//q61+R4ITvm3z7BXcJX9cUV+5/FzHfTEol/dxtGLqB5R6ykT4Xi65LKuGtCnVUPGOsDa8nwOphf0GOIBSvB0Zpq3YdGgTc7MqOROFz5+M47AccFklP3Mox0DevXKbeE/RzFHJ++wmTAoWCSvMbEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007013; c=relaxed/simple;
	bh=V1sM34Oc4obfo0Idrn76+NY8HRLMhNdvxpl8+vgHV1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S7sfdRAQsQSyw6tZhQ9m4mKSeDdubUyCExzELTks34Zu86CnN8xtVd7IA7QRQZ7tQEcAvlnW7YOyQnu3wzTC9xJWnAg7YBtZkvhA32eFcYjbKtuSuloZttKd7LAlhzfkI6kQ8WgPASP/jcHvIZWnD3wWByBt9DuIEWshQVZTPmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c26VCAd1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD587C4CEE2;
	Wed, 26 Mar 2025 16:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743007013;
	bh=V1sM34Oc4obfo0Idrn76+NY8HRLMhNdvxpl8+vgHV1I=;
	h=From:To:Cc:Subject:Date:From;
	b=c26VCAd1kREnyl9bnAwA8UEAnfZ0rwqFq8q9Skm1MK3GoE01Ybo1DnnwMdrbOQ8YR
	 AxYvcWDicEBzixbeAicN8krbPlFHYAqMZnxprDXsiyd82UfkxwxDtX0NwBe+EtuysA
	 iefZw0AcsEjVl47KHiXRYGTIWGiQOoLEldSbBWqjgzd865aeDPIO+g9UiWl+lAitc2
	 XiC8HPR+V29w6e2QjqH2BmOExjLJBCrD/pbRv5FzkvsvWEdC7s0GlWP962hJVkERq3
	 OxPIZxAVNSPUQeDhWZjwjLVGMEB18tC1DPk+mXdy9OGdMd4rX4Sw5VTv3fTNmAriQE
	 bkTHuRAB/pw4A==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking for v6.15
Date: Wed, 26 Mar 2025 09:36:51 -0700
Message-ID: <20250326163652.2730264-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus!

A bit late this time, due to badly timed vacations and unmovable
"work work". You will see at least 3 conflicts pulling this:

fs/eventpoll.c
 https://lore.kernel.org/all/20250228132953.78a2b788@canb.auug.org.au/

net/core/dev.c
 https://lore.kernel.org/all/20250228154312.06484c0d@canb.auug.org.au/

lib/Makefile
 https://lore.kernel.org/all/20250213151927.1674562e@canb.auug.org.au/
(note the file move)

The following changes since commit 5fc31936081919a8572a3d644f3fbb258038f337:

  Merge tag 'net-6.14-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-03-20 09:39:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.15

for you to fetch changes up to 023b1e9d265ca0662111a9df23d22b4632717a8a:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-03-26 09:32:10 -0700)

----------------------------------------------------------------
Networking changes for 6.15.

Core & protocols
----------------

 - Continue Netlink conversions to per-namespace RTNL lock
   (IPv4 routing, routing rules, routing next hops, ARP ioctls).

 - Continue extending the use of netdev instance locks. As a driver
   opt-in protect queue operations and (in due course) ethtool
   operations with the instance lock and not RTNL lock.

 - Support collecting TCP timestamps (data submitted, sent, acked)
   in BPF, allowing for transparent (to the application) and lower
   overhead tracking of TCP RPC performance.

 - Tweak existing networking Rx zero-copy infra to support zero-copy
   Rx via io_uring.

 - Optimize MPTCP performance in single subflow mode by 29%.

 - Enable GRO on packets which went thru XDP CPU redirect (were queued
   for processing on a different CPU). Improving TCP stream performance
   up to 2x.

 - Improve performance of contended connect() by 200% by searching
   for an available 4-tuple under RCU rather than a spin lock.
   Bring an additional 229% improvement by tweaking hash distribution.

 - Avoid unconditionally touching sk_tsflags on RX, improving
   performance under UDP flood by as much as 10%.

 - Avoid skb_clone() dance in ping_rcv() to improve performance under
   ping flood.

 - Avoid FIB lookup in netfilter if socket is available, 20% perf win.

 - Rework network device creation (in-kernel) API to more clearly
   identify network namespaces and their roles.
   There are up to 4 namespace roles but we used to have just 2 netns
   pointer arguments, interpreted differently based on context.

 - Use sysfs_break_active_protection() instead of trylock to avoid
   deadlocks between unregistering objects and sysfs access.

 - Add a new sysctl and sockopt for capping max retransmit timeout
   in TCP.

 - Support masking port and DSCP in routing rule matches.

 - Support dumping IPv4 multicast addresses with RTM_GETMULTICAST.

 - Support specifying at what time packet should be sent on AF_XDP
   sockets.

 - Expose TCP ULP diagnostic info (for TLS and MPTCP) to non-admin users.

 - Add Netlink YAML spec for WiFi (nl80211) and conntrack.

 - Introduce EXPORT_IPV6_MOD() and EXPORT_IPV6_MOD_GPL() for symbols
   which only need to be exported when IPv6 support is built as a module.

 - Age FDB entries based on Rx not Tx traffic in VxLAN, similar
   to normal bridging.

 - Allow users to specify source port range for GENEVE tunnels.

 - netconsole: allow attaching kernel release, CPU ID and task name
   to messages as metadata

Driver API
----------

 - Continue rework / fixing of Energy Efficient Ethernet (EEE) across
   the SW layers. Delegate the responsibilities to phylink where possible.
   Improve its handling in phylib.

 - Support symmetric OR-XOR RSS hashing algorithm.

 - Support tracking and preserving IRQ affinity by NAPI itself.

 - Support loopback mode speed selection for interface selftests.

Device drivers
--------------

 - Remove the IBM LCS driver for s390.

 - Remove the sb1000 cable modem driver.

 - Add support for SFP module access over SMBus.

 - Add MCTP transport driver for MCTP-over-USB.

 - Enable XDP metadata support in multiple drivers.

 - Ethernet high-speed NICs:
   - Broadcom (bnxt):
     - add PCIe TLP Processing Hints (TPH) support for new AMD platforms
     - support dumping RoCE queue state for debug
     - opt into instance locking
   - Intel (100G, ice, idpf):
     - ice: rework MSI-X IRQ management and distribution
     - ice: support for E830 devices
     - iavf: add support for Rx timestamping
     - iavf: opt into instance locking
   - nVidia/Mellanox:
     - mlx4: use page pool memory allocator for Rx
     - mlx5: support for one PTP device per hardware clock
     - mlx5: support for 200Gbps per-lane link modes
     - mlx5: move IPSec policy check after decryption
   - AMD/Solarflare:
     - support FW flashing via devlink
   - Cisco (enic):
     - use page pool memory allocator for Rx
     - enable 32, 64 byte CQEs
     - get max rx/tx ring size from the device
   - Meta (fbnic):
     - support flow steering and RSS configuration
     - report queue stats
     - support TCP segmentation
     - support IRQ coalescing
     - support ring size configuration
   - Marvell/Cavium:
     - support AF_XDP
   - Wangxun:
     - support for PTP clock and timestamping
   - Huawei (hibmcge):
     - checksum offload
     - add more statistics

 - Ethernet virtual:
   - VirtIO net:
     - aggressively suppress Tx completions, improve perf by 96% with
       1 CPU and 55% with 2 CPUs
     - expose NAPI to IRQ mapping and persist NAPI settings
   - Google (gve):
     - support XDP in DQO RDA Queue Format
     - opt into instance locking
   - Microsoft vNIC:
     - support BIG TCP

 - Ethernet NICs consumer, and embedded:
   - Synopsys (stmmac):
     - cleanup Tx and Tx clock setting and other link-focused cleanups
     - enable SGMII and 2500BASEX mode switching for Intel platforms
     - support Sophgo SG2044
   - Broadcom switches (b53):
     - support for BCM53101
   - TI:
     - iep: add perout configuration support
     - icssg: support XDP
   - Cadence (macb):
     - implement BQL
   - Xilinx (axinet):
     - support dynamic IRQ moderation and changing coalescing at runtime
     - implement BQL
     - report standard stats
   - MediaTek:
     - support phylink managed EEE
   - Intel:
     - igc: don't restart the interface on every XDP program change
   - RealTek (r8169):
     - support reading registers of internal PHYs directly
     - increase max jumbo packet size on RTL8125/RTL8126
   - Airoha:
     - support for RISC-V NPU packet processing unit
     - enable scatter-gather and support MTU up to 9kB
   - Tehuti (tn40xx):
     - support cards with TN4010 MAC and an Aquantia AQR105 PHY

 - Ethernet PHYs:
   - support for TJA1102S, TJA1121
   - dp83tg720: add randomized polling intervals for link detection
   - dp83822: support changing the transmit amplitude voltage
   - support for LEDs on 88q2xxx

 - CAN:
   - canxl: support Remote Request Substitution bit access
   - flexcan: add S32G2/S32G3 SoC

 - WiFi:
   - remove cooked monitor support
   - strict mode for better AP testing
   - basic EPCS support
   - OMI RX bandwidth reduction support
   - batman-adv: add support for jumbo frames

 - WiFi drivers:
   - RealTek (rtw88):
     - support RTL8814AE and RTL8814AU
   - RealTek (rtw89):
     - switch using wiphy_lock and wiphy_work
     - add BB context to manipulate two PHY as preparation of MLO
     - improve BT-coexistence mechanism to play A2DP smoothly
   - Intel (iwlwifi):
     - add new iwlmld sub-driver for latest HW/FW combinations
   - MediaTek (mt76):
     - preparation for mt7996 Multi-Link Operation (MLO) support
   - Qualcomm/Atheros (ath12k):
     - continued work on MLO
   - Silabs (wfx):
     - Wake-on-WLAN support

 - Bluetooth:
   - add support for skb TX SND/COMPLETION timestamping
   - hci_core: enable buffer flow control for SCO/eSCO
   - coredump: log devcd dumps into the monitor

 - Bluetooth drivers:
   - intel: add support to configure TX power
   - nxp: handle bootloader error during cmd5 and cmd7

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Aaradhana Sahu (8):
      wifi: ath: create common testmode_i.h file for ath drivers
      wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
      wifi: ath12k: add factory test mode support
      wifi: ath12k: Disable MLO in Factory Test Mode
      wifi: ath12k: Fetch regdb.bin file from board-2.bin
      wifi: ath12k: Enable MLO setup ready and teardown commands for single split-phy device
      wifi: ath12k: Remove dependency on single_chip_mlo_support for mlo_capable flag
      wifi: ath12k: Enable MLO for single split-phy PCI device

Aditya Kumar Singh (15):
      wifi: ath12k: update beacon template function to use arvif structure
      wifi: ath12k: fix handling of CSA offsets in beacon template command
      wifi: ath12k: update the latest CSA counter
      wifi: ath12k: prevent CSA counter to reach 0 and hit WARN_ON_ONCE
      wifi: ath12k: relocate ath12k_mac_ieee80211_sta_bw_to_wmi()
      wifi: ath12k: handle ath12k_mac_ieee80211_sta_bw_to_wmi() for link sta
      wifi: ath12k: eliminate redundant debug mask check in ath12k_dbg()
      wifi: ath12k: introduce ath12k_generic_dbg()
      wifi: ath12k: remove redundant vif settings during link interface creation
      wifi: ath12k: remove redundant logic for initializing arvif
      wifi: ath12k: use arvif instead of link_conf in ath12k_mac_set_key()
      wifi: ath12k: relocate a few functions in mac.c
      wifi: ath12k: allocate new links in change_vif_links()
      wifi: ath12k: handle link removal in change_vif_links()
      wifi: nl80211: store chandef on the correct link when starting CAC

Ahmed Zaki (5):
      net: move aRFS rmap management and CPU affinity to core
      net: ena: use napi's aRFS rmap notifers
      ice: clear NAPI's IRQ numbers in ice_vsi_clear_napi_queues()
      ice: use napi's irq affinity and rmap IRQ notifiers
      idpf: use napi's irq affinity

Akihiko Odaki (12):
      tun: Refactor CONFIG_TUN_VNET_CROSS_LE
      tun: Keep hdr_len in tun_get_user()
      tun: Decouple vnet from tun_struct
      tun: Decouple vnet handling
      tun: Extract the vnet handling code
      tap: Keep hdr_len in tap_get_user()
      tap: Use tun's vnet-related code
      tun: Pad virtio headers
      virtio_net: Split struct virtio_net_rss_config
      virtio_net: Fix endian with virtio_net_ctrl_rss
      virtio_net: Use new RSS config structs
      virtio_net: Allocate rss_hdr with devres

Akiva Goldberger (2):
      net/mlx5: Rename and move mlx5_esw_query_vport_vhca_id
      net/mlx5: Expose ICM consumption per function

Aleksander Jan Bajkowski (1):
      r8152: add vendor/device ID pair for Dell Alienware AW1022z

Alexander Duyck (6):
      eth: fbnic: add MAC address TCAM to debugfs
      eth: fbnic: set IFF_UNICAST_FLT to avoid enabling promiscuous mode when adding unicast addrs
      eth: fbnic: add IP TCAM programming
      eth: fbnic: support n-tuple filters
      eth: fbnic: support listing tcam content via debugfs
      net: phylink: Remove unused function pointer from phylink structure

Alexander Lobakin (12):
      unroll: add generic loop unroll helpers
      i40e: use generic unrolled_count() macro
      ice: use generic unrolled_count() macro
      xsk: add helper to get &xdp_desc's DMA and meta pointer in one go
      net: gro: decouple GRO from the NAPI layer
      net: gro: expose GRO init/cleanup to use outside of NAPI
      bpf: cpumap: switch to GRO from netif_receive_skb_list()
      bpf: cpumap: reuse skb array instead of a linked list to chain skbs
      net: skbuff: introduce napi_skb_cache_get_bulk()
      bpf: cpumap: switch to napi_skb_cache_get_bulk()
      veth: use napi_skb_cache_get_bulk() instead of xdp_alloc_skb_bulk()
      xdp: remove xdp_alloc_skb_bulk()

Alexander Sverdlin (1):
      net: ethernet: ti: cpsw_new: populate netdev of_node

Alexander Wetzel (3):
      wifi: nl80211/cfg80211: Stop supporting cooked monitor
      wifi: mac80211: Drop cooked monitor support
      wifi: mac80211: Add counter for all monitor interfaces

Alexei Lazar (2):
      net/mlx5: Extend Ethtool loopback selftest to support non-linear SKB
      net/mlx5: XDP, Enable TX side XDP multi-buffer support

Aloka Dixit (5):
      wifi: ath11k: refactor transmitted arvif retrieval
      wifi: ath11k: pass tx arvif for MBSSID and EMA beacon generation
      wifi: ath12k: refactor transmitted arvif retrieval
      wifi: ath12k: pass tx arvif for MBSSID and EMA beacon generation
      wifi: ath12k: pass BSSID index as input for EMA

Amir Tzin (5):
      net/mlx5e: Move RQs diagnose to a dedicated function
      net/mlx5e: Add direct TIRs to devlink rx reporter diagnose
      net/mlx5e: Expose RSS via devlink rx reporter diagnose
      net/mlx5: Lag, Enable Multiport E-Switch offloads on 8 ports LAG
      net/mlx5: fw reset, check bridge accessibility at earlier stage

Amit Cohen (6):
      mlxsw: Trap ARP packets at layer 2 instead of layer 3
      mlxsw: spectrum: Call mlxsw_sp_bridge_vxlan_{join, leave}() for VLAN-aware bridge
      mlxsw: spectrum_switchdev: Add an internal API for VXLAN leave
      mlxsw: spectrum_switchdev: Move mlxsw_sp_bridge_vxlan_join()
      mlxsw: Add VXLAN bridge ports to same hardware domain as physical bridge ports
      selftests: vxlan_bridge: Test flood with unresolved FDB entry

Andrei Botila (2):
      net: phy: nxp-c45-tja11xx: add match_phy_device to TJA1103/TJA1104
      net: phy: nxp-c45-tja11xx: add support for TJA1121

Andrew Kreimer (3):
      net: qed: fix typos
      wifi: rtw88: Fix a typo of debug message in rtw8723d_iqk_check_tx_failed()
      wifi: rtlwifi: rtl8192de: Fix typos of debug message of phy setting

Andy Shevchenko (7):
      drivers: net: xgene: Don't use "proxy" headers
      ieee802154: ca8210: Use proper setters and getters for bitwise types
      ieee802154: ca8210: Get platform data via dev_get_platdata()
      ieee802154: ca8210: Switch to using gpiod API
      dt-bindings: ieee802154: ca8210: Update polarity of the reset pin
      net: phy: Introduce PHY_ID_SIZE — minimum size for PHY ID string
      net: usb: asix: ax88772: Increase phy_name size

Anjaneyulu (3):
      wifi: iwlwifi: mvm: rename and move iwl_mvm_eval_dsm_rfi() to iwl_rfi_is_enabled_in_bios()
      wifi: iwlwifi: Unify TAS block list handling in regulatory.c
      wifi: cfg80211: allow IR in 20 MHz configurations

Anna Emese Nyiri (1):
      selftests: net: add support for testing SO_RCVMARK and SO_RCVPRIORITY

Antoine Tenart (5):
      net-sysfs: remove rtnl_trylock from device attributes
      net-sysfs: move queue attribute groups outside the default groups
      net-sysfs: prevent uncleared queues from being re-added
      net-sysfs: remove rtnl_trylock from queue attributes
      net-sysfs: remove unused initial ret values

Arnd Bergmann (10):
      octeontx2: hide unused label
      net: wangxun: fix LIBWX dependencies
      wifi: iwlegacy: don't warn for unused variables with DEBUG_FS=n
      pktgen: avoid unused-const-variable warning
      net: hisilicon: hns_mdio: remove incorrect ACPI_PTR annotation
      net: xgene-v2: remove incorrect ACPI_PTR annotation
      net: qed: make 'qed_ll2_ops_pass' as __maybe_unused
      wifi: iwlegacy: avoid size increase
      net: remove sb1000 cable modem driver
      net: airoha: fix CONFIG_DEBUG_FS check

Arseniy Krasnov (2):
      Bluetooth: hci_uart: fix race during initialization
      Bluetooth: hci_uart: Fix another race during initialization

Aswin Karuvally (1):
      s390/net: Remove LCS driver

Avraham Stern (4):
      wifi: iwlwifi: location api cleanup
      wifi: mac80211: allow 320 MHz FTM measurements
      wifi: iwlwifi: mvm: fix setting the TK when associated
      wifi: iwlwifi: mld: move the ftm initiator data to ftm-initiator.h

Avula Sri Charan (1):
      wifi: ath12k: Avoid napi_sync() before napi_enable()

Balamurugan Mahalingam (4):
      wifi: ath12k: Add EHT MCS support in Extended Rx statistics
      wifi: ath12k: Refactor the format of peer rate table information
      wifi: ath12k: Update HTT_TCL_METADATA version and bit mask definitions
      wifi: ath12k: Add support for MLO Multicast handling in driver

Baochen Qiang (1):
      wifi: ath12k: use link specific bss_conf as well in ath12k_mac_vif_cache_flush()

Bart Van Assche (1):
      wifi: ath12k: Fix locking in "QMI firmware ready" error paths

Benjamin Berg (4):
      wifi: mac80211: add HT and VHT basic set verification
      wifi: mac80211: tests: add tests for ieee80211_determine_chan_mode
      wifi: cfg80211: expose update timestamp to drivers
      wifi: iwlwifi: mld: assume wiphy is locked when getting BSS ifaces

Benjamin Lin (1):
      wifi: mt76: mt7996: revise TXS size

Biju Das (7):
      of: base: Add of_get_available_child_by_name()
      net: dsa: rzn1_a5psw: Use of_get_available_child_by_name()
      net: dsa: sja1105: Use of_get_available_child_by_name()
      net: ethernet: mtk-star-emac: Use of_get_available_child_by_name()
      net: ethernet: mtk_eth_soc: Use of_get_available_child_by_name()
      net: ethernet: actions: Use of_get_available_child_by_name()
      net: ibm: emac: Use of_get_available_child_by_name()

Birger Koblitz (1):
      net: sfp: add quirk for 2.5G OEM BX SFP

Bitterblue Smith (26):
      wifi: rtw88: Don't use static local variable in rtw8822b_set_tx_power_index_by_rate
      wifi: rtw88: Don't use static local variable in rtw8821c_set_tx_power_index_by_rate
      wifi: rtw88: Fix __rtw_download_firmware() for RTL8814AU
      wifi: rtw88: Fix download_firmware_validate() for RTL8814AU
      wifi: rtw88: Extend struct rtw_pwr_track_tbl for RTL8814AU
      wifi: rtw88: Extend rf_base_addr and rf_sipi_addr for RTL8814AU
      wifi: rtw88: Extend rtw_fw_send_ra_info() for RTL8814AU
      wifi: rtw88: Constify some more structs and arrays
      wifi: rtw88: Rename RTW_RATE_SECTION_MAX to RTW_RATE_SECTION_NUM
      wifi: rtw88: Extend TX power stuff for 3-4 spatial streams
      wifi: rtw88: Fix rtw_update_sta_info() for RTL8814AU
      wifi: rtw88: Fix rtw_mac_power_switch() for RTL8814AU
      wifi: rtw88: Fix rtw_desc_to_mcsrate() to handle MCS16-31
      wifi: rtw88: Fix rtw_init_ht_cap() for RTL8814AU
      wifi: rtw88: Fix rtw_init_vht_cap() for RTL8814AU
      wifi: rtw88: Fix rtw_rx_phy_stat() for RTL8814AU
      wifi: rtw88: Extend rtw_phy_config_swing_table() for RTL8814AU
      wifi: rtw88: Extend rtw_debugfs_get_phy_info() for RTL8814AU
      wifi: rtw88: Extend rtw_debugfs_get_tx_pwr_tbl() for RTL8814AU
      wifi: rtw88: Add some definitions for RTL8814AU
      wifi: rtw88: Add rtw8814a_table.c (part 1/2)
      wifi: rtw88: Add rtw8814a_table.c (part 2/2)
      wifi: rtw88: Add rtw8814a.{c,h}
      wifi: rtw88: Add rtw8814ae.c
      wifi: rtw88: Add rtw8814au.c
      wifi: rtw88: Enable the new RTL8814AE/RTL8814AU drivers

Breno Leitao (29):
      netconsole: selftest: Add test for fragmented messages
      netconsole: consolidate send buffers into netconsole_target struct
      netconsole: Rename userdata to extradata
      netconsole: Helper to count number of used entries
      netconsole: Introduce configfs helpers for sysdata features
      netconsole: Include sysdata in extradata entry count
      netconsole: add support for sysdata and CPU population
      netconsole: selftest: test for sysdata CPU
      netconsole: docs: Add documentation for CPU number auto-population
      trace: tcp: Add tracepoint for tcp_cwnd_reduction()
      net: Remove redundant variable declaration in __dev_change_flags()
      netdevsim: call napi_schedule from a timer context
      net: Remove shadow variable in netdev_run_todo()
      netconsole: prefix CPU_NR sysdata feature with SYSDATA_
      netconsole: Make boolean comparison consistent
      netconsole: refactor CPU number formatting into separate function
      netconsole: add taskname to extradata entry count
      netconsole: add configfs controls for taskname sysdata feature
      netconsole: add task name to extra data fields
      netconsole: docs: document the task name feature
      netconsole: selftest: add task name append testing
      netpoll: Optimize skb refilling on critical path
      netconsole: introduce 'release' as a new sysdata field
      netconsole: implement configfs for release_enabled
      netconsole: add 'sysdata' suffix to related functions
      netconsole: append release to sysdata
      selftests: netconsole: Add tests for 'release' feature in sysdata
      docs: netconsole: document release feature
      netpoll: Eliminate redundant assignment

Carolina Jubran (5):
      net/mlx5e: Avoid WARN_ON when configuring MQPRIO with HTB offload enabled
      net/mlx5: Rename devlink rate parent set function for leaf nodes
      net/mlx5: Introduce hierarchy level tracking on scheduling nodes
      net/mlx5: Preserve rate settings when creating a rate node
      net/mlx5: Add support for setting parent of nodes

Catalin Popescu (2):
      dt-bindings: net: rfkill-gpio: enable booting in blocked state
      net: rfkill: gpio: allow booting in blocked state

Chandra Mohan Sundar (1):
      selftests: net: Fix few spelling mistakes

Charalampos Mitrodimas (1):
      net: phy: qt2025: Fix hardware revision check comment

Chen Ni (2):
      qed: remove cast to pointers passed to kfree
      octeontx2-af: mcs: Remove redundant 'flush_workqueue()' calls

Chen-Yu Tsai (1):
      net: stmmac: dwmac-rk: Provide FIFO sizes for DWMAC 1000

Chenyuan Yang (1):
      netfilter: nfnetlink_queue: Initialize ctx to avoid memory allocation error

Chia-Yu Chang (1):
      tcp: use BIT() macro in include/net/tcp.h

Chiara Meiohas (3):
      net/mlx5: Add RDMA_CTRL HW capabilities
      net/mlx5: Allow the throttle mechanism to be more dynamic
      net/mlx5: Limit non-privileged commands

Chih-Kang Chang (1):
      wifi: rtw89: Parse channel from IE to correct invalid hardware reports during scanning

Ching-Te Ku (10):
      wifi: rtw89: coex: Add protect to avoid A2DP lag while Wi-Fi connecting
      wifi: rtw89: coex: Separated Wi-Fi connecting event from Wi-Fi scan event
      wifi: rtw89: coex: Update Wi-Fi/Bluetooth coexistence version to 7.0.2
      wifi: rtw89: coex: Assign value over than 0 to avoid firmware timer hang
      wifi: rtw89: coex: To avoid TWS serials A2DP lag, adjust slot arrangement
      wifi: rtw89: coex: Update Wi-Fi/Bluetooth coexistence version to 7.0.3
      wifi: rtw89: coex: RTL8852BT coexistence Wi-Fi firmware support for 0.29.122.0
      wifi: rtw89: coex: Fix coexistence report not show as expected
      wifi: rtw89: coex: Add parser for Bluetooth channel map report version 7
      wifi: rtw89: coex: Update Wi-Fi/Bluetooth coexistence version to 7.0.4

Choong Yong Liang (7):
      net: phylink: use pl->link_interface in phylink_expects_phy()
      net: pcs: xpcs: re-initiate clause 37 Auto-negotiation
      net: stmmac: configure SerDes on mac_finish
      net: stmmac: configure SerDes according to the interface mode
      net: stmmac: interface switching support for ADL-N platform
      stmmac: intel: Fix warning message for return value in intel_tsn_lane_is_available()
      stmmac: intel: interface switching support for RPL-P platform

Chris Packham (3):
      dt-bindings: net: Move realtek,rtl9301-switch to net
      dt-bindings: net: Add switch ports and interrupts to RTL9300
      dt-bindings: net: Add Realtek MDIO controller

Christophe JAILLET (1):
      wifi: mwifiex: Constify struct mwifiex_if_ops

ChunHao Lin (2):
      r8169: enable RTL8168H/RTL8168EP/RTL8168FP ASPM support
      r8169: disable RTL8126 ZRX-DC timeout

Ciprian Marian Costea (3):
      dt-bindings: can: fsl,flexcan: add S32G2/S32G3 SoC support
      can: flexcan: Add quirk to handle separate interrupt lines for mailboxes
      can: flexcan: add NXP S32G2/S32G3 SoC support

Claus Stovgaard (1):
      dt-bindings: net: dsa: b53: add BCM53101 support

Colin Ian King (2):
      wifi: ipw2x00: Fix spelling mistake "stablization" -> "stabilization"
      wifi: iwlwifi: Fix spelling mistake "Increate" -> "Increase"

Cosmin Ratiu (1):
      net/mlx5: Bridge, correct config option description

Csókás, Bence (1):
      net: fec: Refactor MAC reset to function

Damodharam Ammepalli (1):
      bnxt_en: add .set_module_eeprom_by_page() support

Dan Carpenter (5):
      ice: Fix signedness bug in ice_init_interrupt_scheme()
      net: Prevent use after free in netif_napi_set_irq_locked()
      eth: fbnic: fix memory corruption in fbnic_tlv_attr_get_string()
      wifi: iwlwifi: Fix uninitialized variable with __free()
      xfrm: Remove unnecessary NULL check in xfrm_lookup_with_ifid()

Daniel Borkmann (3):
      netkit: Remove double invocation to clear ipvs property flag
      geneve: Allow users to specify source port range
      geneve, specs: Add port range to rt_link specification

Daniel Gabay (1):
      wifi: iwlwifi: w/a FW SMPS mode selection

Daniel Golle (1):
      dsa: mt7530: Utilize REGMAP_IRQ for interrupt handling

Daniel Hsu (1):
      mctp: Fix incorrect tx flow invalidation condition in mctp-i2c

Daniel Zahka (1):
      eth: fbnic: support an additional RSS context

David Arinzon (1):
      net: ena: resolve WARN_ON when freeing IRQs

David E. Box (1):
      arch: x86: add IPC mailbox accessor function and add SoC register access

David S. Miller (7):
      Merge branch 'of_get_available_child_by_name'
      Merge branch 'netconsole-cpu-population'
      Merge branch 'net-mana-big-tcp'
      Merge branch 'am65-cpsw-cleanup'
      Merge branch 'mlx5-health-syndrome'
      Merge branch 'dynamic-possix-clocks-permission-checks'
      Merge branch 'tcp-accecn'

David Wei (2):
      netdev: add io_uring memory provider info
      net: add helpers for setting a memory provider on an rx queue

David Wu (1):
      net: stmmac: dwmac-rk: Add GMAC support for RK3528

Davide Caratti (1):
      can: add protocol counter for AF_CAN sockets

Denis Kirjanov (1):
      netfilter: xt_hashlimit: replace vmalloc calls with kvmalloc

Dian-Syuan Yang (1):
      wifi: rtw89: set force HE TB mode when connecting to 11ax AP

Dimitri Fedrau (12):
      net: phy: marvell-88q2xxx: Add support for PHY LEDs on 88q2xxx
      dt-bindings: net: ethernet-phy: add property tx-amplitude-100base-tx-percent
      net: phy: Add helper for getting tx amplitude gain
      net: phy: dp83822: Add support for changing the transmit amplitude voltage
      net: phy: marvell-88q2xxx: align defines
      net: phy: marvell-88q2xxx: order includes alphabetically
      net: phy: marvell-88q2xxx: enable temperature sensor in mv88q2xxx_config_init
      net: phy: tja11xx: add support for TJA1102S
      net: phy: tja11xx: enable PHY in sleep mode for TJA1102S
      dt-bindings: can: fsl,flexcan: add transceiver capabilities
      can: flexcan: add transceiver capabilities
      net: phy: dp83822: fix transmit amplitude if CONFIG_OF_MDIO not defined

Dinesh Karthikeyan (4):
      wifi: ath12k: Support Sounding Stats
      wifi: ath12k: Support Latency Stats
      wifi: ath12k: Support Uplink OFDMA Trigger Stats
      wifi: ath12k: Support Received FSE Stats

Dmitry Antipov (4):
      wifi: ath9k: cleanup struct ath_tx_control and ath_tx_prepare()
      wifi: ath9k: use unsigned long for activity check timestamp
      wifi: ath9k: do not submit zero bytes to the entropy pool
      wifi: rtw89: rtw8852b{t}: fix TSSI debug timestamps

Dmitry Baryshkov (3):
      dt-bindings: net: bluetooth: qualcomm: document WCN3950
      Bluetooth: qca: simplify WCN399x NVM loading
      Bluetooth: qca: add WCN3950 support

Dmitry Safonov (7):
      selftests/net: Print TCP flags in more common format
      selftests/net: Provide tcp-ao counters comparison helper
      selftests/net: Fetch and check TCP-MD5 counters
      selftests/net: Add mixed select()+polling mode to TCP-AO tests
      selftests/net: Print the testing side in unsigned-md5
      selftests/net: Delete timeout from test_connect_socket()
      selftests/net: Drop timeout argument from test_client_verify()

Donald Hunter (10):
      tools/net/ynl: remove extraneous plural from variable names
      tools/net/ynl: support decoding indexed arrays as enums
      tools/net/ynl: support rendering C array members to strings
      tools/net/ynl: accept IP string inputs
      tools/net/ynl: add s8, s16 to valid scalars in ynl-gen-c
      tools/net/ynl: sanitise enums with leading digits in ynl-gen-c
      tools/net/ynl: add indexed-array scalar support to ynl-gen-c
      netlink: specs: support nested structs in genetlink legacy
      netlink: specs: add s8, s16 to genetlink schemas
      netlink: specs: wireless: add a spec for nl80211

Dorian Cruveiller (1):
      Bluetooth: btusb: Add new VID/PID for WCN785x

Doug Berger (14):
      net: bcmgenet: bcmgenet_hw_params clean up
      net: bcmgenet: add bcmgenet_has_* helpers
      net: bcmgenet: move feature flags to bcmgenet_priv
      net: bcmgenet: BCM7712 is GENETv5 compatible
      net: bcmgenet: extend bcmgenet_hfb_* API
      net: bcmgenet: move DESC_INDEX flow to ring 0
      net: bcmgenet: add support for RX_CLS_FLOW_DISC
      net: bcmgenet: remove dma_ctrl argument
      net: bcmgenet: consolidate dma initialization
      net: bcmgenet: introduce bcmgenet_[r|t]dma_disable
      net: bcmgenet: support reclaiming unsent Tx packets
      net: bcmgenet: move bcmgenet_power_up into resume_noirq
      net: bcmgenet: allow return of power up status
      net: bcmgenet: revise suspend/resume

Douglas Anderson (1):
      Bluetooth: btusb: mediatek: Add err code to btusb claim iso printout

Dr. David Alan Gilbert (19):
      wifi: libertas: main: remove unused functions
      wifi: libertas: cmd: remove unused functions
      wifi: libertas: Remove unused auto deep sleep code
      wifi: ipw2x00: Remove unused libipw_rx_any()
      mlx4: Remove unused functions
      net/mlx5: Remove unused mlx5dr_domain_sync
      mlxsw: spectrum_router: Remove unused functions
      cavium/liquidio: Remove unused lio_get_device_id
      wifi: iwlwifi: dvm: Remove unused iwl_rx_ant_restriction
      wifi: iwlwifi: mvm: Remove unused iwl_mvm_rx_missed_vap_notif
      wifi: iwlwifi: mvm: Remove unused iwl_mvm_ftm_*_add_pasn_sta functions
      wifi: iwlwifi: mvm: Remove unused iwl_mvm_ftm_add_pasn_sta
      wifi: iwlwifi: Remove unused iwl_bz_name
      wifi: iwlwifi: Remove old device data
      wifi: mwifiex: Remove unused mwifiex_uap_del_sta_data
      nfc: hci: Remove unused nfc_llc_unregister
      net: phylink: Remove unused phylink_init_eee
      Bluetooth: MGMT: Remove unused mgmt_pending_find_data
      Bluetooth: MGMT: Remove unused mgmt_*_discovery_complete

Easwar Hariharan (5):
      wifi: cfg80211: convert timeouts to secs_to_jiffies()
      Bluetooth: hci_vhci: convert timeouts to secs_to_jiffies()
      Bluetooth: MGMT: convert timeouts to secs_to_jiffies()
      Bluetooth: SMP: convert timeouts to secs_to_jiffies()
      Bluetooth: L2CAP: convert timeouts to secs_to_jiffies()

Edward Adam Davis (1):
      wifi: cfg80211: init wiphy_work before allocating rfkill fails

Edward Cree (7):
      sfc: parse headers of devlink flash images
      sfc: extend NVRAM MCDI handlers
      sfc: deploy devlink flash images to NIC over MCDI
      sfc: document devlink flash support
      sfc: rip out MDIO support
      sfc: update MCDI protocol headers
      sfc: support X4 devlink flash

Emil Tantilov (1):
      idpf: check error for register_netdev() on init

Emmanuel Grumbach (19):
      wifi: iwlwifi: remove the mvm prefix from iwl_mvm_ctdp_cmd
      wifi: iwlwifi: remove the version number from iwl_dts_measurement_notif_v2
      wifi: iwlwifi: remove the mvm prefix from iwl_mvm_aux_sta_cmd
      wifi: mac80211: set ieee80211_prep_tx_info::link_id upon Auth Rx
      wifi: mac80211: rework the Tx of the deauth in ieee80211_set_disassoc()
      wifi: iwlwifi: be less aggressive with re-probe
      wifi: iwlwifi: make no_160 more generic
      wifi: iwlwifi: properly set the names for SC devices
      wifi: iwlwifi: clarify the meaning of IWL_INIT_PHY
      wifi: iwlwifi: use 0xff instead of 0xffffffff for invalid
      wifi: iwlwifi: add support for external 32 KHz clock
      wifi: iwlwifi: export iwl_get_lari_config_bitmap
      wifi: iwlwifi: remember if the UATS table was read successfully
      wifi: iwlwifi: add support for BE213
      wifi: iwlwifi: fix the ECKV UEFI variable name
      wifi: iwlwifi: fix print for ECKV
      wifi: iwlwifi: mld: we support v6 of compressed_ba_notif
      wifi: iwlwifi: remove a buggy else statement in op_mode selection
      wifi: iwlwifi: do not use iwlmld for non-wifi7 devices

Eric Dumazet (51):
      neighbour: remove neigh_parms_destroy()
      net: flush_backlog() small changes
      tcp: do not export tcp_parse_mss_option() and tcp_mtup_init()
      tcp: rename inet_csk_{delete|reset}_keepalive_timer()
      tcp: remove tcp_reset_xmit_timer() @max_when argument
      tcp: add a @pace_delay parameter to tcp_reset_xmit_timer()
      tcp: use tcp_reset_xmit_timer()
      tcp: add the ability to control max RTO
      tcp: add tcp_rto_max_ms sysctl
      net: introduce EXPORT_IPV6_MOD() and EXPORT_IPV6_MOD_GPL()
      inetpeer: use EXPORT_IPV6_MOD[_GPL]()
      tcp: use EXPORT_IPV6_MOD[_GPL]()
      udp: use EXPORT_IPV6_MOD[_GPL]()
      inet: reduce inet_csk_clone_lock() indent level
      inet: consolidate inet_csk_clone_lock()
      ndisc: ndisc_send_redirect() cleanup
      batman-adv: adopt netdev_hold() / netdev_put()
      net-sysfs: restore behavior for not running devices
      tcp: be less liberal in TSEcr received while in SYN_RECV state
      ipv4: icmp: do not process ICMP_EXT_ECHOREPLY for broadcast/multicast addresses
      inet: ping: avoid skb_clone() dance in ping_rcv()
      tcp: add a drop_reason pointer to tcp_check_req()
      tcp: add four drop reasons to tcp_check_req()
      tcp: convert to dev_net_rcu()
      net: gro: convert four dev_net() calls
      tcp: remove READ_ONCE(req->ts_recent)
      tcp: tcp_set_window_clamp() cleanup
      tcp: use RCU in __inet{6}_check_established()
      tcp: optimize inet_use_bhash2_on_bind()
      tcp: add RCU management to inet_bind_bucket
      tcp: use RCU lookup in __inet_hash_connect()
      inet: fix lwtunnel_valid_encap_type() lock imbalance
      tcp: bring back NUMA dispersion in inet_ehash_locks_alloc()
      inet: change lport contribution to inet_ehashfn() and inet6_ehashfn()
      inet: call inet6_ehashfn() once from inet6_hash_connect()
      bpf: fix a possible NULL deref in bpf_map_offload_map_alloc()
      net: ethtool: use correct device pointer in ethnl_default_dump_one()
      udp: expand SKB_DROP_REASON_UDP_CSUM use
      hamradio: use netdev_lockdep_set_classes() helper
      inet: frags: add inet_frag_putn() helper
      ipv4: frags: remove ipq_put()
      inet: frags: change inet_frag_kill() to defer refcount updates
      inet: frags: save a pair of atomic operations in reassembly
      tcp: cache RTAX_QUICKACK metric in a hot cache line
      tcp: move icsk_clean_acked to a better location
      ipv6: fix _DEVADD() and _DEVUPD() macros
      tcp: avoid atomic operations on sk->sk_rmem_alloc
      net: reorganize IP MIB values (II)
      net: rfs: hash function change
      tcp/dccp: remove icsk->icsk_timeout
      tcp/dccp: remove icsk->icsk_ack.timeout

Eric Huang (1):
      wifi: rtw89: ps: update H2C command with more info for PS

Eric Woudstra (1):
      net: ethernet: mtk_ppe_offload: Allow QinQ, double ETH_P_8021Q only

Erni Sri Satya Vennela (1):
      net: mana: Add debug logs in MANA network driver

Ethan Carter Edwards (2):
      hamradio: baycom: replace strcpy() with strscpy()
      wifi: ath12k: cleanup ath12k_mac_mlo_ready()

Ezra Buehler (1):
      wifi: rtl8xxxu: Enable AP mode for RTL8192CU (RTL8188CUS)

Fabio Porcedda (6):
      net: usb: qmi_wwan: add Telit Cinterion FN990B composition
      net: usb: qmi_wwan: fix Telit Cinterion FN990A name
      net: usb: cdc_mbim: fix Telit Cinterion FN990A name
      net: usb: qmi_wwan: add Telit Cinterion FE990B composition
      net: usb: qmi_wwan: fix Telit Cinterion FE990A name
      net: usb: cdc_mbim: fix Telit Cinterion FE990A name

Felix Fietkau (5):
      wifi: mt76: scan: set vif offchannel link for scanning/roc
      wifi: mt76: mt7996: use the correct vif link for scanning/roc
      wifi: mt76: only mark tx-status-failed frames as ACKed on mt76x0/2
      wifi: mt76: mt7996: implement driver specific get_txpower function
      wifi: mt76: scan: fix setting tx_info fields

Florian Westphal (3):
      netlink: specs: add conntrack dump and stats dump support
      xfrm: state: make xfrm_state_lookup_byaddr lockless
      netfilter: fib: avoid lookup if socket is available

Frank Li (1):
      dt-bindings: can: fsl,flexcan: add i.MX94 support

Gal Pressman (15):
      net/mlx5: Remove stray semicolon in LAG port selection table creation
      net/mlx5e: Remove unused mlx5e_tc_flow_action struct
      ip_tunnel: Use ip_tunnel_info() helper instead of 'info + 1'
      net: Add options as a flexible array to struct ip_tunnel_info
      ethtool: Symmetric OR-XOR RSS hash
      net/mlx5e: Symmetric OR-XOR RSS hash control
      selftests: drv-net: Make rand_port() get a port more reliably
      selftests: drv-net-hw: Add a test for symmetric RSS hash
      coccinelle: Add missing (GE)NL_SET_ERR_MSG_* to strings ending with newline test
      net/mlx5: Remove newline at the end of a netlink error message
      sfc: Remove newline at the end of a netlink error message
      net: sched: Remove newline at the end of a netlink error message
      ice: dpll: Remove newline at the end of a netlink error message
      selftests: drv-net: rss_ctx: Don't assume indirection table is present
      net/mlx5: Remove NULL check before dev_{put, hold}

Gang Yan (2):
      selftests: mptcp: Add a tool to get specific msk_info
      selftests: mptcp: add a test for mptcp_diag_dump_one

Gavrilov Ilia (1):
      wifi: mac80211: fix integer overflow in hwmp_route_info_get()

Geert Uytterhoeven (3):
      ipv4: ip_gre: Fix set but not used warning in ipgre_err() if IPv4-only
      net: pcs: rzn1-miic: Convert to for_each_available_child_of_node() helper
      net: renesas: rswitch: Convert to for_each_available_child_of_node()

Geliang Tang (32):
      mptcp: pm: drop info of userspace_pm_remove_id_zero_address
      mptcp: pm: userspace: use GENL_REQ_ATTR_CHECK
      mptcp: pm: make three pm wrappers static
      mptcp: pm: drop skb parameter of get_addr
      mptcp: pm: add id parameter for get_addr
      mptcp: pm: reuse sending nlmsg code in get_addr
      mptcp: pm: drop skb parameter of set_flags
      mptcp: pm: change rem type of set_flags
      mptcp: pm: add local parameter for set_flags
      mptcp: pm: add a build check for userspace_pm_dump_addr
      mptcp: pm: add mptcp_pm_genl_fill_addr helper
      mptcp: pm: drop match in userspace_pm_append_new_local_addr
      mptcp: pm: drop inet6_sk after inet_sk
      mptcp: pm: use ipv6_addr_equal in addresses_equal
      mptcp: sched: split get_subflow interface into two
      sock: add sock_kmemdup helper
      net: use sock_kmemdup for ip_options
      mptcp: use sock_kmemdup for address entry
      mptcp: pm: in-kernel: avoid access entry without lock
      mptcp: pm: in-kernel: reduce parameters of set_flags
      mptcp: pm: use addr entry for get_local_id
      mptcp: pm: in-kernel: use kmemdup helper
      mptcp: pm: use pm variable instead of msk->pm
      mptcp: pm: only fill id_avail_bitmap for in-kernel pm
      mptcp: pm: add struct_group in mptcp_pm_data
      mptcp: pm: define struct mptcp_pm_ops
      mptcp: pm: register in-kernel and userspace PM
      mptcp: sysctl: set path manager by name
      mptcp: sysctl: map path_manager to pm_type
      mptcp: sysctl: map pm_type to path_manager
      mptcp: sysctl: add available_path_managers
      selftests: mptcp: add pm sysctl mapping tests

Gerhard Engleder (6):
      e1000e: Fix real-time violations on link up
      net: phy: Allow loopback speed selection for PHY drivers
      net: phy: Support speed selection for PHY loopback
      net: phy: micrel: Add loopback support
      net: phy: marvell: Align set_loopback() implementation
      tsnep: Select speed for loopback

Guangguan Wang (1):
      net/smc: use the correct ndev to find pnetid by pnetid table

Gustavo A. R. Silva (5):
      net: atlantic: Avoid -Wflex-array-member-not-at-end warnings
      cxgb4: Avoid a -Wflex-array-member-not-at-end warning
      wifi: qtnfmac: Avoid multiple -Wflex-array-member-not-at-end warnings
      net/mlx5e: Avoid a hundred -Wflex-array-member-not-at-end warnings
      wifi: iwlwifi: dvm: Avoid -Wflex-array-member-not-at-end warnings

Hangbin Liu (3):
      selftests: fib_nexthops: do not mark skipped tests as failed
      selftests/net: ensure mptcp is enabled in netns
      bonding: report duplicate MAC address in all situations

Hans-Frieder Vogt (7):
      net: phy: Add swnode support to mdiobus_scan
      net: phy: aquantia: add probe function to aqr105 for firmware loading
      net: phy: aquantia: search for firmware-name in fwnode
      net: phy: aquantia: add essential functions to aqr105 driver
      net: tn40xx: create swnode for mdio and aqr105 phy and add to mdiobus
      net: tn40xx: prepare tn40xx driver to find phy of the TN9510 card
      net: tn40xx: add pci-id of the aqr105-based Tehuti TN4010 cards

Hao Qin (1):
      Bluetooth: btmtk: Remove the resetting step before downloading the fw

Haoxiang Li (1):
      wifi: mt76: Add check for devm_kstrdup()

Hariprasad Kelam (1):
      Octeontx2-af: RPM: Register driver with PCI subsys IDs

Harshitha Ramamurthy (2):
      gve: convert to use netmem for DQO RDA mode
      gve: unlink old napi only if page pool exists

Heiner Kallweit (45):
      net: phy: realtek: make HWMON support a user-visible Kconfig symbol
      r8169: make Kconfig option for LED support user-visible
      net: phy: realtek: use string choices helpers
      r8169: don't scan PHY addresses > 0
      net: gianfar: simplify init_phy()
      net: phy: rename eee_broken_modes to eee_disabled_modes
      net: phy: rename phy_set_eee_broken to phy_disable_eee_mode
      net: phy: remove unused PHY_INIT_TIMEOUT and PHY_FORCE_TIMEOUT
      net: freescale: ucc_geth: remove unused PHY_INIT_TIMEOUT and PHY_CHANGE_TIME
      ixgene-v2: prepare for phylib stop exporting phy_10_100_features_array
      r8169: add support for Intel Killer E5000
      r8169: add PHY c45 ops for MDIO_MMD_VENDOR2 registers
      net: phy: realtek: improve mmd register access for internal PHY's
      net: phy: realtek: switch from paged to MMD ops in rtl822x functions
      net: phy: remove fixup-related definitions from phy.h which are not used outside phylib
      net: phy: stop exporting feature arrays which aren't used outside phylib
      net: phy: stop exporting phy_queue_state_machine
      net: phy: remove helper phy_is_internal
      net: phy: c45: improve handling of disabled EEE modes in generic ethtool functions
      net: phy: realtek: add helper RTL822X_VND2_C22_REG
      net: phy: realtek: add defines for shadowed c45 standard registers
      net: phy: move definition of phy_is_started before phy_disable_eee_mode
      net: phy: improve phy_disable_eee_mode
      net: phy: remove disabled EEE modes from advertising_eee in phy_probe
      net: phy: c45: Don't silently remove disabled EEE modes any longer when writing advertisement register
      net: phy: c45: use cached EEE advertisement in genphy_c45_ethtool_get_eee
      net: phy: c45: remove local advertisement parameter from genphy_c45_eee_is_active
      net: phy: remove unused feature array declarations
      net: phy: add phylib-internal.h
      net: phy: move PHY package code from phy_device.c to own source file
      net: phy: add getters for public members in struct phy_package_shared
      net: phy: qca807x: use new phy_package_shared getters
      net: phy: micrel: use new phy_package_shared getters
      net: phy: mediatek: use new phy_package_shared getters
      net: phy: mscc: use new phy_package_shared getters
      net: phy: move PHY package related code from phy.h to phy_package.c
      net: phy: remove remaining PHY package related definitions from phy.h
      r8169: increase max jumbo packet size on RTL8125/RTL8126
      net: phy: move PHY package MMD access function declarations from phy.h to phylib.h
      net: phy: remove unused functions phy_package_[read|write]_mmd
      r8169: switch away from deprecated pcim_iomap_table
      net: phy: realtek: remove call to devm_hwmon_sanitize_name
      net: phy: tja11xx: remove call to devm_hwmon_sanitize_name
      net: phy: mxl-gpy: remove call to devm_hwmon_sanitize_name
      net: phy: marvell-88q2xxx: remove call to devm_hwmon_sanitize_name

Henrik Brix Andersen (1):
      can: gs_usb: add VID/PID for the CANnectivity firmware

Herbert Xu (1):
      net: mctp: Remove unnecessary cast in mctp_cb

Huacai Chen (1):
      net: stmmac: dwmac-loongson: Set correct {tx,rx}_fifo_size

Huisong Li (5):
      net: aquantia: Use HWMON_CHANNEL_INFO macro to simplify code
      net: nfp: Use HWMON_CHANNEL_INFO macro to simplify code
      net: phy: marvell: Use HWMON_CHANNEL_INFO macro to simplify code
      net: phy: marvell10g: Use HWMON_CHANNEL_INFO macro to simplify code
      net: phy: aquantia: Use HWMON_CHANNEL_INFO macro to simplify code

Icenowy Zheng (1):
      wifi: mt76: mt76x2u: add TP-Link TL-WDN6200 ID to device table

Ido Schimmel (23):
      vxlan: Annotate FDB data races
      vxlan: Read jiffies once when updating FDB 'used' time
      vxlan: Always refresh FDB 'updated' time when learning is enabled
      vxlan: Refresh FDB 'updated' time upon 'NTF_USE'
      vxlan: Refresh FDB 'updated' time upon user space updates
      vxlan: Age out FDB entries based on 'updated' time
      vxlan: Avoid unnecessary updates to FDB 'used' time
      selftests: forwarding: vxlan_bridge_1d: Check aging while forwarding
      mlxsw: Enable Tx checksum offload
      net: fib_rules: Add port mask attributes
      net: fib_rules: Add port mask support
      ipv4: fib_rules: Add port mask matching
      ipv6: fib_rules: Add port mask matching
      net: fib_rules: Enable port mask usage
      netlink: specs: Add FIB rule port mask attributes
      selftests: fib_rule_tests: Add port range match tests
      selftests: fib_rule_tests: Add port mask match tests
      net: fib_rules: Add DSCP mask attribute
      ipv4: fib_rules: Add DSCP mask matching
      ipv6: fib_rules: Add DSCP mask matching
      net: fib_rules: Enable DSCP mask usage
      netlink: specs: Add FIB rule DSCP mask attribute
      selftests: fib_rule_tests: Add DSCP mask match tests

Ihor Matushchak (1):
      net: phy: phy_interface_t: Fix RGMII_TXID code comment

Ilan Peer (12):
      wifi: cfg80211: Fix trace print for removed links
      wifi: mac80211: Refactor ieee80211_sta_wmm_params()
      wifi: mac80211: Add support for EPCS configuration
      wifi: ieee80211: Add missing EHT MAC capabilities
      wifi: mac80211: Add processing of TTLM teardown frame
      wifi: iwlwifi: Indicate support for EPCS
      wifi: iwlwifi: mvm: Indicate support link reconfiguration
      wifi: mac80211: Fix possible integer promotion issue
      wifi: mac80211_hwsim: Fix MLD address translation
      wifi: cfg80211: Update the link address when a link is added
      wifi: mac80211: Notify cfg80211 about added link addresses
      wifi: iwlwifi: mld: Correctly configure the A-MSDU max lengths

Ilpo Järvinen (10):
      tcp: reorganize tcp_in_ack_event() and tcp_count_delivered()
      tcp: create FLAG_TS_PROGRESS
      tcp: extend TCP flags to allow AE bit/ACE field
      tcp: rework {__,}tcp_ecn_check_ce() -> tcp_data_ecn_check()
      tcp: helpers for ECN mode handling
      gso: AccECN support
      gro: prevent ACE field corruption & better AccECN handling
      tcp: AccECN support to tcp_add_backlog
      tcp: add new TCP_TW_ACK_OOW state and allow ECN bits in TOS
      tcp: Pass flags to __tcp_send_ack

Ilya Maximets (1):
      net: openvswitch: fix kernel-doc warnings in internal headers

Inochi Amaoto (4):
      dt-bindings: net: Add support for Sophgo SG2044 dwmac
      net: stmmac: platform: Group GMAC4 compatible check
      net: stmmac: platform: Add snps,dwmac-5.30a IP compatible string
      net: stmmac: Add glue layer for Sophgo SG2044 SoC

Ivan Abramov (1):
      ptp: ocp: Remove redundant check in _signal_summary_show

J. Neuschäfer (3):
      dt-bindings: net: Convert fsl,gianfar-{mdio,tbi} to YAML
      dt-bindings: net: fsl,gianfar-mdio: Update information about TBI
      dt-bindings: net: Convert fsl,gianfar to YAML

Jaakko Karrenpalo (2):
      net: hsr: Fix PRP duplicate detection
      net: hsr: Add KUnit test for PRP

Jacob Keller (16):
      ice: Add unified ice_capture_crosststamp
      virtchnl: add support for enabling PTP on iAVF
      virtchnl: add enumeration for the rxdid format
      iavf: add support for negotiating flexible RXDID format
      iavf: negotiate PTP capabilities
      iavf: add initial framework for registering PTP clock
      iavf: add support for indirect access to PHC time
      iavf: periodically cache PHC time
      iavf: refactor iavf_clean_rx_irq to support legacy and flex descriptors
      iavf: handle set and get timestamps ops
      iavf: add support for Rx timestamps to hotpath
      igb: reject invalid external timestamp requests for 82580-based HW
      renesas: reject PTP_STRICT_FLAGS as unsupported
      net: lan743x: reject unsupported external timestamp requests
      broadcom: fix supported flag check in periodic output function
      ptp: ocp: reject unsupported periodic output flags

Jakub Kicinski (187):
      net: warn if NAPI instance wasn't shut down
      Merge branch 'net-sysfs-remove-the-rtnl_trylock-restart_syscall-construction'
      selftests: net: suppress ReST file generation when building selftests
      Merge branch 'vxlan-age-fdb-entries-based-on-rx-traffic'
      tools: ynl-gen: don't output external constants
      tools: ynl-gen: support limits using definitions
      tools: ynl: add all headers to makefile deps
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'io_uring-zero-copy-rx'
      Merge branch 'enic-use-page-pool-api-for-receiving-packets'
      Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'net-stmmac-yet-more-eee-updates'
      Merge branch 'add-usb-support-for-telit-cinterion-fn990b'
      net: refactor netdev_rx_queue_restart() to use local qops
      net: devmem: don't call queue stop / start when the interface is down
      net: page_pool: avoid false positive warning if NAPI was never added
      netdevsim: allow normal queue reset while down
      Merge branch 'net-improve-core-queue-api-handling-while-device-is-down'
      net: ethtool: prevent flow steering to RSS contexts which don't exist
      selftests: net-drv: test adding flow rule to invalid RSS context
      selftests: drv-net: rss_ctx: skip tests which need multiple contexts cleanly
      Merge branch 'eth-fbnic-support-rss-contexts-and-ntuple-filters'
      Merge branch 'xsk-the-lost-bits-from-chapter-iii'
      Merge branch 'net-xilinx-axienet-enable-adaptive-irq-coalescing-with-dim'
      Merge branch 'tun-unify-vnet-implementation'
      Merge branch 'fib-rules-convert-rtm_newrule-and-rtm_delrule-to-per-netns-rtnl'
      selftests: drv-net: remove an unnecessary libmnl include
      selftests: drv-net: factor out a DrvEnv base class
      selftests: drv-net: add helper for path resolution
      Merge branch 'net-phy-rename-eee_broken_mode'
      Merge branch 'use-hwmon_channel_info-macro-to-simplify-code'
      Merge branch 'sfc-support-devlink-flash'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      Merge branch 'rate-management-on-traffic-classes-misc'
      Merge branch 'use-phylib-for-reset-randomization-and-adjustable-polling'
      net: report csum_complete via qstats
      eth: fbnic: wrap tx queue stats in a struct
      eth: fbnic: report software Rx queue stats
      eth: fbnic: report software Tx queue stats
      eth: fbnic: re-sort the objects in the Makefile
      Merge branch 'eth-fbnic-report-software-queue-stats'
      Merge branch 'net: dsa: add support for phylink managed EEE'
      Merge branch 'netlink-specs-add-a-spec-for-nl80211-wiphy'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'net-add-export_ipv6_mod'
      Merge branch 'inet-better-inet_sock_set_state-for-passive-flows'
      Merge branch 'net-phylink-xpcs-stmmac-support-pcs-eee-configuration'
      Merge branch 'net-phy-realtek-improve-mmd-register-access-for-internal-phy-s'
      Merge branch 'net-phy-clean-up-phy-h'
      Merge branch 'bnxt_en-add-npar-1-2-and-tph-support'
      Merge branch 'net-phy-mediatek-add-token-ring-helper-functions'
      Merge branch 'mlx5-add-sensor-name-in-temperature-message'
      Merge branch 'net-phy-dp83822-add-support-for-changing-the-transmit-amplitude-voltage'
      Merge branch 'netdev-genl-add-an-xsk-attribute-to-queues'
      net: move stale comment about ntuple validation
      netdev: clarify GSO vs csum in qstats
      eth: fbnic: support TCP segmentation offload
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue
      eth: mlx4: create a page pool for Rx
      eth: mlx4: don't try to complete XDP frames in netpoll
      eth: mlx4: remove the local XDP fast-recycling ring
      eth: mlx4: use the page pool for Rx buffers
      Merge branch 'eth-mlx4-use-the-page-pool-for-rx-buffers'
      Merge branch 'net-cadence-macb-modernize-statistics-reporting'
      Merge branch 'net-phy-improve-and-simplify-eee-handling-in-phylib'
      Merge branch 'net-deduplicate-cookie-logic'
      Merge branch 'net-fib_rules-add-port-mask-support'
      Merge branch 'net-stmmac-further-cleanups'
      Merge branch 'mptcp-rx-path-refactor'
      selftests: drv-net: resolve remote interface name
      selftests: drv-net: get detailed interface info
      selftests: drv-net: store addresses in dict indexed by ipver
      selftests: drv-net: add a simple TSO test
      Merge branch 'selftests-drv-net-add-a-simple-tso-test'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'flexible-array-for-ip-tunnel-options'
      Merge branch 'support-ptp-clock-for-wangxun-nics'
      Merge branch 'some-pktgen-fixes-improvments-part-i'
      Merge branch 'mlx5-misc-enhancements-2025-02-19'
      selftests: drv-net: add a warning for bkg + shell + terminate
      selftests: drv-net: use cfg.rpath() in netlink xsk attr test
      selftests: drv-net: add missing new line in xdp_helper
      selftests: drv-net: probe for AF_XDP sockets more explicitly
      selftests: drv-net: add a way to wait for a local process
      selftests: drv-net: improve the use of ksft helpers in XSK queue test
      selftests: drv-net: rename queues check_xdp to check_xsk
      Merge branch 'selftests-drv-net-improve-the-queue-test-for-xsk'
      Merge branch 'dt-bindings-net-realtek-rtl9301-switch'
      Merge branch 'net-improve-netns-handling-in-rtnetlink'
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge branch 'net-fib_rules-add-dscp-mask-support'
      Merge branch 'mctp-add-mctp-over-usb-hardware-transport-binding'
      Merge branch 'net-remove-skb_flow_get_ports'
      Merge branch 'net-stmmac-thead-clean-up-clock-rate-setting'
      Merge branch 'net-mlx5e-move-ipsec-policy-check-after-decryption'
      Merge branch 'mptcp-pm-misc-cleanups-part-3'
      Merge branch 'net-stmmac-dwc-qos-clean-up-clock-initialisation'
      Merge branch 'symmetric-or-xor-rss-hash'
      Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux
      Merge branch 'expand-cmsg_ipv6-sh-with-ipv4-support'
      selftests: drv-net: add tests for napi IRQ affinity notifiers
      Merge branch 'net-napi-add-cpu-affinity-to-napi-config'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'add-missing-netlink-error-message-macros-to-coccinelle-test'
      Merge branch 'selftests-net-deflake-gro-tests-and-fix-return-value-and-output'
      Merge branch 'net-stmmac-cleanup-transmit-clock-setting'
      Merge branch 'inet-ping-remove-extra-skb_clone-consume_skb'
      Merge branch 'add-usb-net-support-for-telit-cinterion-fn990b'
      selftests: net: report output format as TAP 13 in Python tests
      Merge branch 'ipv4-fib-convert-rtm_newroute-and-rtm_delroute-to-per-netns-rtnl'
      Merge branch 'tcp-misc-changes'
      Merge branch 'add-sock_kmemdup-helper'
      Merge tag 'wireless-next-2025-03-04-v2' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge branch 'mptcp-improve-code-coverage-and-small-optimisations'
      Merge branch 'net-phy-nxp-c45-tja11xx-add-support-for-tja1121'
      Merge branch 'net-convert-gianfar-triple-speed-ethernet-controller-bindings-to-yaml'
      Merge branch 'eth-fbnic-cleanup-macros-and-string-function'
      selftests: drv-net: use env.rpath in the HDS test
      Merge branch 'tcp-scale-connect-under-pressure'
      Merge branch 'enable-sgmii-and-2500basex-interface-mode-switching-for-intel-platforms'
      Merge branch 'net-phy-move-phy-package-code-to-its-own-source-file'
      net: ethtool: try to protect all callback with netdev instance lock
      Merge branch 'net-hold-netdev-instance-lock-during-ndo-operations'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'tcp-even-faster-connect-under-stress'
      Merge branch 'net-stmmac-dwc-qos-add-fsd-eqos-support'
      selftests: net: fix error message in bpf_offload
      selftests: net: bpf_offload: add 'libbpf_global' to ignored maps
      Merge branch 'increase-maximum-mtu-to-9k-for-airoha-en7581-soc'
      selftests: openvswitch: don't hardcode the drop reason subsys
      Merge branch 'add-perout-configuration-support-in-iep-driver'
      Merge branch 'mlx5-misc-enhancements-2025-03-04'
      Merge branch 'riscv-sophgo-add-ethernet-support-for-sg2044'
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge branch 'net-bcmgenet-revise-suspend-resume'
      eth: fbnic: link NAPIs to page pools
      eth: fbnic: fix typo in compile assert
      eth: fbnic: support ring size configuration
      Merge branch 'eth-fbnic-support-ring-size-configuration'
      Merge branch 'tcp-ulp-diag-expose-more-to-non-net-admin-users'
      Merge branch 'net-phy-tja11xx-add-support-for-tja1102s'
      net: move misc netdev_lock flavors to a separate header
      Merge branch 'virtio-net-link-queues-to-napis'
      Merge branch 'follow-up-on-deduplicate-cookie-logic'
      Merge branch 'mptcp-pm-code-reorganisation'
      docs: netdev: add a note on selftest posting
      selftests: net: bump GRO timeout for gro/setup_veth
      Merge branch 'net-remove-rtnl_lock-from-the-callers-of-queue-apis'
      netdevsim: 'support' multi-buf XDP
      Merge branch 'r8169-enable-more-devices-aspm-support'
      Merge branch 'mlx5-cleanups-2025-03-19'
      Merge branch 'bnxt_en-fix-max_skb_frags-30'
      Merge branch 'fixes-for-mv88e6xxx-mainly-6320-family'
      Merge branch 'mlxsw-add-vxlan-to-the-same-hardware-domain-as-physical-bridge-ports'
      Merge branch 'sja1105-driver-fixes'
      Merge branch 'mlx5-misc-fixes-2025-03-18'
      Merge branch 'support-tcp_rto_min_us-and-tcp_delack_max_us-for-set-getsockopt'
      Merge branch 'af_unix-clean-up-headers'
      Merge branch 'net-xdp-add-missing-metadata-support-for-some-xdp-drvs'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch 'selftests-net-mixed-select-polling-mode-for-tcp-ao-tests'
      Merge branch 'mlx5-misc-enhancements-2025-03-19'
      Merge branch 'nexthop-convert-rtm_-new-del-nexthop-to-per-netns-rtnl'
      Merge branch 'sfc-devlink-flash-for-x4'
      Merge branch 'net-improve-stmmac-resume-rx-clocking'
      Merge branch 'net-stmmac-dwmac-rk-add-gmac-support-for-rk3528'
      Merge tag 'wireless-next-2025-03-20' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
      Merge tag 'nf-next-25-03-23' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next
      Merge tag 'ipsec-next-2025-03-24' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next
      Merge branch 'net-phy-sfp-add-single-byte-smbus-sfp-access'
      Revert "udp_tunnel: GRO optimizations"
      Merge branch 'virtio_net-fixes-and-improvements'
      net: bubble up taking netdev instance lock to callers of net_devmem_unbind_dmabuf()
      net: remove netif_set_real_num_rx_queues() helper for when SYSFS=n
      net: constify dev pointer in misc instance lock helpers
      net: explain "protection types" for the instance lock
      net: designate queue counts as "double ops protected" by instance lock
      net: designate queue -> napi linking as "ops protected"
      net: protect rxq->mp_params with the instance lock
      Merge branch 'net-skip-taking-rtnl_lock-for-queue-get'
      Merge branch 'tcp-dccp-remove-16-bytes-from-icsk'
      Merge branch 'stmmac-several-pci-related-improvements'
      Merge branch 'basic-xdp-support-for-dqo-rda-queue-format'
      Merge branch 'net-tn40xx-add-support-for-aqr105-based-cards'
      Merge tag 'for-net-next-2025-03-25' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next
      Merge branch 'net-usb-asix-ax88772-fix-potential-string-cut'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

Jan Glaza (3):
      virtchnl: make proto and filter action count unsigned
      ice: stop truncating queue ids when checking
      ice: validate queue quanta parameters to prevent OOB access

Janaki Ramaiah Thota (1):
      Bluetooth: hci_qca: use the power sequencer for wcn6750

Janik Haag (1):
      net: cn23xx: fix typos

Jason Wang (1):
      virtio-net: tweak for better TX performance in NAPI mode

Jason Xing (21):
      page_pool: avoid infinite loop to schedule delayed worker
      bpf: Support TCP_RTO_MAX_MS for bpf_setsockopt
      selftests/bpf: Add rto max for bpf_setsockopt test
      bpf: Add networking timestamping support to bpf_get/setsockopt()
      bpf: Prepare the sock_ops ctx and call bpf prog for TX timestamping
      bpf: Prevent unsafe access to the sock fields in the BPF timestamping callback
      bpf: Disable unsafe helpers in TX timestamping callbacks
      net-timestamp: Prepare for isolating two modes of SO_TIMESTAMPING
      bpf: Add BPF_SOCK_OPS_TSTAMP_SCHED_CB callback
      bpf: Add BPF_SOCK_OPS_TSTAMP_SND_SW_CB callback
      bpf: Add BPF_SOCK_OPS_TSTAMP_SND_HW_CB callback
      bpf: Add BPF_SOCK_OPS_TSTAMP_ACK_CB callback
      bpf: Add BPF_SOCK_OPS_TSTAMP_SENDMSG_CB callback
      bpf: Support selective sampling for bpf timestamping
      selftests/bpf: Add simple bpf tests in the tx path for timestamping feature
      tcp: bpf: Introduce bpf_sol_tcp_getsockopt to support TCP_BPF flags
      tcp: bpf: Support bpf_getsockopt for TCP_BPF_RTO_MIN
      tcp: bpf: Support bpf_getsockopt for TCP_BPF_DELACK_MAX
      selftests/bpf: Add bpf_getsockopt() for TCP_BPF_DELACK_MAX and TCP_BPF_RTO_MIN
      tcp: support TCP_RTO_MIN_US for set/getsockopt use
      tcp: support TCP_DELACK_MAX_US for set/getsockopt use

Jedrzej Jagielski (1):
      ixgbe: add support for thermal sensor event reception

Jeff Chen (3):
      wifi: mwifiex: Fix HT40 bandwidth issue.
      wifi: mwifiex: Fix premature release of RF calibration data.
      wifi: mwifiex: Fix RF calibration data download from file

Jeremy Clifton (1):
      Bluetooth: Fix code style warning

Jeremy Kerr (2):
      usb: Add base USB MCTP definitions
      net: mctp: Add MCTP USB transport driver

Jesse Brandeburg (1):
      ice: fix reservation of resources for RDMA when disabled

Jian Shen (1):
      net: hns3: use string choices helper

Jianbo Liu (21):
      net/mlx5: Add helper functions for PTP callbacks
      net/mlx5: Change parameters for PTP internal functions
      net/mlx5: Add init and destruction functions for a single HW clock
      net/mlx5: Add API to get mlx5_core_dev from mlx5_clock
      net/mlx5: Change clock in mlx5_core_dev to mlx5_clock pointer
      net/mlx5: Add devcom component for the clock shared by functions
      net/mlx5: Move PPS notifier and out_work to clock_state
      net/mlx5: Support one PTP device per hardware clock
      net/mlx5: Generate PPS IN event on new function for shared clock
      ethtool: Add support for 200Gbps per lane link modes
      net/mlx5: Add support for 200Gbps per lane link modes
      net/mlx5e: Support FEC settings for 200G per lane link modes
      net/mlx5e: Add helper function to update IPSec default destination
      net/mlx5e: Change the destination of IPSec RX SA miss rule
      net/mlx5e: Add correct match to check IPSec syndromes for switchdev mode
      net/mlx5e: Move IPSec policy check after decryption
      net/mlx5e: Skip IPSec RX policy check for crypto offload
      net/mlx5e: Add num_reserved_entries param for ipsec_ft_create()
      net/mlx5e: Add pass flow group for IPSec RX status table
      net/mlx5e: Support RX xfrm state selector's UPSPEC for packet offload
      net/mlx5e: TC, Don't offload CT commit if it's the last action

Jiande Lu (1):
      Bluetooth: btusb: Add 2 HWIDs for MT7922

Jiasheng Jiang (1):
      dpll: Add an assertion to check freq_supported_num

Jiawen Wu (8):
      net: wangxun: Add support for PTP clock
      net: wangxun: Support to get ts info
      net: wangxun: Add periodic checks for overflow and errors
      net: ngbe: Add support for 1PPS and TOD
      net: txgbe: Add basic support for new AML devices
      net: wangxun: Replace the judgement of MAC type with flags
      net: libwx: fix Tx descriptor content for some tunnel packets
      net: libwx: fix Tx L4 checksum

Jijie Shao (6):
      net: hibmcge: Add support for dump statistics
      net: hibmcge: Add support for checksum offload
      net: hibmcge: Add support for abnormal irq handling feature
      net: hibmcge: Add support for mac link exception handling feature
      net: hibmcge: Add support for BMC diagnose feature
      net: hibmcge: Add support for ioctl

Jing Su (1):
      dql: Fix dql->limit value when reset.

Jiri Pirko (1):
      ynl: devlink: add missing board-serial-number

Joe Damato (9):
      netdev-genl: Elide napi_id when not present
      documentation: networking: Add NAPI config
      netlink: Add nla_put_empty_nest helper
      netdev-genl: Add an XSK attribute to queues
      selftests: drv-net: Test queue xsk attribute
      virtio-net: Refactor napi_enable paths
      virtio-net: Refactor napi_disable paths
      virtio-net: Map NAPIs to queues
      virtio_net: Use persistent NAPI config

Johan Korsnes (1):
      net: au1000_eth: Mark au1000_ReleaseDB() static

Johannes Berg (42):
      wifi: mac80211: add strict mode disabling workarounds
      wifi: mac80211_hwsim: enable strict mode
      wifi: mac80211: remove misplaced drv_mgd_complete_tx() call
      wifi: mac80211: don't unconditionally call drv_mgd_complete_tx()
      wifi: mac80211: always send max agg subframe num in strict mode
      wifi: mac80211: aggregation: remove deflink accesses for MLO
      wifi: mac80211: enable removing assoc link
      wifi: iwlwifi: enable 320 MHz on slow PCIe links
      wifi: iwlwifi: cfg: separate 22000/BZ family HT params
      wifi: iwlwifi: fw: make iwl_send_dbg_dump_complete_cmd() static
      wifi: iwlwifi: use correct IMR dump variable
      wifi: iwlwifi: implement dump region split
      Merge tag 'rtw-next-2025-02-10-v2' of https://github.com/pkshih/rtw
      wifi: iwlwifi: add OMI bandwidth reduction APIs
      wifi: iwlwifi: remove mld/roc.c
      Merge tag 'ath-next-20250305' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      wifi: cfg80211: move link reconfig parameters into a struct
      wifi: cfg80211: allow setting extended MLD capa/ops
      wifi: mac80211: mlme: support extended MLD capa/ops in assoc
      wifi: mac80211: fix U-APSD check in ML reconfiguration
      wifi: cfg80211: improve supported_selector documentation
      wifi: mac80211: fix userspace_selectors corruption
      wifi: mac80211: fix warning on disconnect during failed ML reconf
      wifi: mac80211: fix ML reconf reset in disconnect
      wifi: mac80211: don't include MLE in ML reconf per-STA profile
      wifi: mac80211: set WMM in ML reconfiguration
      wifi: iwlwifi: mark Br device not integrated
      wifi: iwlwifi: fix debug actions order
      wifi: iwlwifi: mld: initialize regulatory early
      wifi: iwlwifi: mld: fix OMI time protection logic
      wifi: iwlwifi: mld: enable OMI bandwidth reduction on 6 GHz
      wifi: iwlwifi: mld: remove AP keys only for AP STA
      wifi: mac80211: remove SSID from ML reconf
      wifi: mac80211: use supported selectors from assoc in ML reconf
      wifi: cfg80211: expose cfg80211_chandef_get_width()
      wifi: mac80211: use cfg80211_chandef_get_width()
      Merge net-next/main to resolve conflicts
      wifi: mac80211: fix indentation in ieee80211_set_monitor_channel()
      wifi: nl80211: re-enable multi-link reconfiguration
      Merge tag 'rtw-next-2025-03-13' of https://github.com/pkshih/rtw
      Merge tag 'mt76-next-2025-03-19' of https://github.com/nbd168/wireless
      wifi: mt76: mt7996: fix locking in mt7996_mac_sta_rc_work()

John Daley (5):
      enic: Move RX functions to their own file
      enic: Simplify RX handler function
      enic: Use the Page Pool API for RX
      enic: remove copybreak tunable
      enic: add dependency on Page Pool

Jonas Gottlieb (1):
      Add OVN to `rtnetlink.h`

Jonas Karlman (7):
      dt-bindings: net: rockchip-dwmac: Require rockchip,grf and rockchip,php-grf
      net: stmmac: dwmac-rk: Validate GRF and peripheral GRF during probe
      net: stmmac: dwmac-rk: Remove unneeded GRF and peripheral GRF checks
      dt-bindings: net: rockchip-dwmac: Add compatible string for RK3528
      net: stmmac: dwmac-rk: Move integrated_phy_powerup/down functions
      net: stmmac: dwmac-rk: Add integrated_phy_powerdown operation
      net: stmmac: dwmac-rk: Add initial support for RK3528 integrated PHY

Jonathan Lennox (1):
      tc-tests: Update tc police action tests for tc buffer size rounding fixes.

Joshua Washington (6):
      gve: remove xdp_xsk_done and xdp_xsk_wakeup statistics
      gve: introduce config-based allocation for XDP
      gve: update GQ RX to use buf_size
      gve: merge packet buffer size fields
      gve: update XDP allocation path support RX buffer posting
      gve: add XDP DROP and PASS support for DQ

Jérôme Pouiller (5):
      wifi: wfx: align declarations between bus_spi.c and bus_sdio.c
      wifi: wfx: declare support for WoWLAN
      wifi: wfx: allow SPI device to wake up the host
      wifi: wfx: allow SDIO device to wake up the host
      wifi: wfx: allow to enable WoWLAN using NL80211

Kang Yang (1):
      wifi: ath11k: add srng->lock for ath11k_hal_srng_* in monitor mode

Karol Kolacinski (9):
      ice: Don't check device type when checking GNSS presence
      ice: Remove unnecessary ice_is_e8xx() functions
      ice: Use FIELD_PREP for timestamp values
      ice: Process TSYN IRQ in a separate function
      ice: Refactor ice_ptp_init_tx_*
      ice: rename ice_ptp_init_phc_eth56g function
      ice: Refactor E825C PHY registers info struct
      ice: E825C PHY register cleanup
      ice: ensure periodic output start time is in the future

Karthikeyan Periyasamy (9):
      wifi: ath12k: Refactor the monitor Rx parser handler argument
      wifi: ath12k: Refactor the monitor Tx/RX handler procedure arguments
      wifi: ath12k: Refactor Rx status TLV parsing procedure argument
      wifi: ath12k: Add HAL_PHYRX_GENERIC_U_SIG TLV parsing support
      wifi: ath12k: Add HAL_PHYRX_GENERIC_EHT_SIG TLV parsing support
      wifi: ath12k: Add HAL_RX_PPDU_START_USER_INFO TLV parsing support
      wifi: ath12k: Add HAL_PHYRX_OTHER_RECEIVE_INFO TLV parsing support
      wifi: ath12k: Update the peer id in PPDU end user stats TLV
      wifi: ath12k: Add peer extended Rx statistics debugfs support

Kees Cook (6):
      net/mlx4_core: Avoid impossible mlx4_db_alloc() order value
      wifi: mwifiex: Add __nonstring annotations for unterminated strings
      wifi: zd1211rw: Add __nonstring annotations for unterminated strings
      wifi: virt_wifi: Add __nonstring annotations for unterminated strings
      wifi: rtw88: Add __nonstring annotations for unterminated strings
      net: macb: Add __nonstring annotations for unterminated strings

Kevin Krakauer (3):
      selftests/net: have `gro.sh -t` return a correct exit code
      selftests/net: only print passing message in GRO tests when tests pass
      selftests/net: deflake GRO tests

Kiran K (8):
      Bluetooth: btintel: Add support for Intel Scorpius Peak
      Bluetooth: btintel_pcie: Add device id of Whale Peak
      Bluetooth: btintel: Add DSBR support for ScP
      Bluetooth: btintel_pcie: Setup buffers for firmware traces
      Bluetooth: btintel_pcie: Read hardware exception data
      Bluetooth: btintel_pcie: Add support for device coredump
      Bluetooth: btintel_pcie: Trigger device coredump on hardware exception
      t blameBluetooth: btintel: Fix leading white space

Kohei Enju (1):
      neighbour: Replace kvzalloc() with kzalloc() when GFP_ATOMIC is specified

Krzysztof Kozlowski (10):
      can: c_can: Drop useless final probe failure message
      can: c_can: Simplify handling syscon error path
      can: c_can: Use of_property_present() to test existence of DT property
      can: c_can: Use syscon_regmap_lookup_by_phandle_args
      dt-bindings: wireless: ath10k: Strip ath10k prefix from calibration properties
      dt-bindings: wireless: ath11k: Strip ath11k prefix from calibration property
      dt-bindings: wireless: ath12k: Strip ath12k prefix from calibration property
      wifi: ath10k: Deprecate qcom,ath10k-calibration-variant properties
      wifi: ath11k: Deprecate qcom,ath11k-calibration-variant properties
      dt-bindings: net: qcom,ipa: Correct indentation and style in DTS example

Kuan-Chung Chen (6):
      wifi: rtw89: 8922a: fix incorrect STA-ID in EHT MU PPDU
      wifi: rtw89: add support for HW TKIP crypto
      wifi: rtw89: add support for negative values of dBm to linear conversion
      wifi: rtw89: refine mechanism of TAS
      wifi: rtw89: enable dynamic antenna gain based on country
      wifi: rtw89: 8922a: enable dynamic antenna gain

Kunihiko Hayashi (1):
      net: stmmac: Correct usage of maximum queue number macros

Kuniyuki Iwashima (34):
      net: fib_rules: Don't check net in rule_exists() and rule_find().
      net: fib_rules: Pass net to fib_nl2rule() instead of skb.
      net: fib_rules: Split fib_nl2rule().
      ip: fib_rules: Fetch net from fib_rule in fib[46]_rule_configure().
      net: fib_rules: Factorise fib_newrule() and fib_delrule().
      net: fib_rules: Convert RTM_NEWRULE to per-netns RTNL.
      net: fib_rules: Add error_free label in fib_delrule().
      net: fib_rules: Convert RTM_DELRULE to per-netns RTNL.
      arp: Convert SIOCDARP and SIOCSARP to per-netns RTNL.
      ipv4: fib: Use cached net in fib_inetaddr_event().
      ipv4: fib: Allocate fib_info_hash[] and fib_info_laddrhash[] by kvcalloc().
      ipv4: fib: Allocate fib_info_hash[] during netns initialisation.
      ipv4: fib: Make fib_info_hashfn() return struct hlist_head.
      ipv4: fib: Remove fib_info_laddrhash pointer.
      ipv4: fib: Remove fib_info_hash_size.
      ipv4: fib: Add fib_info_hash_grow().
      ipv4: fib: Namespacify fib_info hash tables.
      ipv4: fib: Hold rtnl_net_lock() for ip_fib_net_exit().
      ipv4: fib: Hold rtnl_net_lock() in ip_rt_ioctl().
      ipv4: fib: Move fib_valid_key_len() to rtm_to_fib_config().
      ipv4: fib: Convert RTM_NEWROUTE and RTM_DELROUTE to per-netns RTNL.
      net: Remove RTNL dance for SIOCBRADDIF and SIOCBRDELIF.
      tcp/dccp: Remove inet_connection_sock_af_ops.addr2sockaddr().
      af_unix: Sort headers.
      af_unix: Move internal definitions to net/unix/.
      af_unix: Explicitly include headers for non-pointer struct fields.
      af_unix: Clean up #include under net/unix/.
      nexthop: Move nlmsg_parse() in rtm_to_nh_config() to rtm_new_nexthop().
      nexthop: Split nh_check_attr_group().
      nexthop: Move NHA_OIF validation to rtm_to_nh_config_rtnl().
      nexthop: Check NLM_F_REPLACE and NHA_ID in rtm_new_nexthop().
      nexthop: Remove redundant group len check in nexthop_create_group().
      nexthop: Convert RTM_NEWNEXTHOP to per-netns RTNL.
      nexthop: Convert RTM_DELNEXTHOP to per-netns RTNL.

Lad Prabhakar (1):
      dt-bindings: net: Define interrupt constraints for DWMAC vendor bindings

Lee Trager (3):
      eth: fbnic: Prepend TSENE FW fields with FBNIC_FW
      eth: fbnic: Update fbnic_tlv_attr_get_string() to work like nla_strscpy()
      eth: fbnic: Replace firmware field macros

Leon Romanovsky (9):
      bonding: delete always true device check
      xfrm: prevent high SEQ input in non-ESN mode
      xfrm: delay initialization of offload path till its actually requested
      xfrm: simplify SA initialization routine
      xfrm: rely on XFRM offload
      xfrm: provide common xdo_dev_offload_ok callback implementation
      xfrm: check for PMTU in tunnel mode for packet offload
      net/mlx5e: Separate address related variables to be in struct
      net/mlx5e: Properly match IPsec subnet addresses

Liang Jie (1):
      wifi: rtw89: Correct immediate cfg_len calculation for scan_offload_be

Lingbo Kong (10):
      wifi: ath12k: report station mode transmit rate
      wifi: ath12k: report station mode receive rate for IEEE 802.11be
      wifi: ath12k: report station mode signal strength
      wifi: ath12k: Add support for obtaining the buffer type ACPI function bitmap
      wifi: ath12k: Add Support for enabling or disabling specific features based on ACPI bitflag
      wifi: ath12k: Adjust the timing to access ACPI table
      wifi: ath12k: Add support for reading variant from ACPI to download board data file
      wifi: ath12k: Dump PDEV transmit rate HTT stats
      wifi: ath12k: Dump PDEV receive rate HTT stats
      wifi: ath12k: Dump additional PDEV receive rate HTT stats

Loic Poulain (2):
      bluetooth: btnxpuart: Support for controller wakeup gpio config
      dt-bindings: net: bluetooth: nxp: Add wakeup pin properties

Lorenzo Bianconi (48):
      net: airoha: Fix TSO support for header cloned skbs
      net: airoha: Move airoha_eth driver in a dedicated folder
      net: airoha: Move definitions in airoha_eth.h
      net: airoha: Move reg/write utility routines in airoha_eth.h
      net: airoha: Move register definitions in airoha_regs.h
      net: airoha: Move DSA tag in DMA descriptor
      net: dsa: mt7530: Enable Rx sptag for EN7581 SoC
      net: airoha: Enable support for multiple net_devices
      net: airoha: Move REG_GDM_FWD_CFG() initialization in airoha_dev_init()
      net: airoha: Rename airoha_set_gdm_port_fwd_cfg() in airoha_set_vip_for_gdm_port()
      dt-bindings: net: airoha: Add the NPU node for EN7581 SoC
      dt-bindings: net: airoha: Add airoha,npu phandle property
      net: airoha: Introduce Airoha NPU support
      net: airoha: Introduce flowtable offload support
      net: airoha: Add loopback support for GDM2
      net: airoha: Introduce PPE debugfs support
      net: airoha: Move min/max packet len configuration in airoha_dev_open()
      net: airoha: Enable Rx Scatter-Gather
      net: airoha: Introduce airoha_dev_change_mtu callback
      net: airoha: Increase max mtu to 9k
      net: airoha: Fix lan4 support in airoha_qdma_get_gdm_port()
      net: airoha: Enable TSO/Scatter Gather for LAN port
      net: airoha: Fix dev->dsa_ptr check in airoha_get_dsa_tag()
      wifi: mt76: mt7996: Add change_vif_links stub
      wifi: mt76: mt7996: Introduce mt7996_sta_link container
      wifi: mt76: mt7996: Add mt7996_sta_link struct in mt7996_vif_link
      wifi: mt76: mt7996: Add vif_cfg_changed callback
      wifi: mt76: mt7996: Add link_info_changed callback
      wifi: mt76: mt7996: Add mt7996_sta_state routine
      wifi: mt76: mt7996: Rely on mt7996_sta_link in sta_add/sta_remove callbacks
      wifi: mt76: mt7996: Support MLO in mt7996_mac_sta_event()
      wifi: mt76: mt7996: Rely on mt7996_vif/sta_link in twt teardown
      wifi: mt76: mt7996: Add mt7996_sta_link to mt7996_mcu_add_bss_info signature
      wifi: mt76: mt7996: rework mt7996_sta_hw_queue_read to support MLO
      wifi: mt76: mt7996: rework mt7996_mac_sta_rc_work to support MLO
      wifi: mt76: mt7996: rework mt7996_mac_sta_poll to support MLO
      wifi: mt76: mt7996: rework mt7996_update_mu_group to support MLO
      wifi: mt76: mt7996: rework mt7996_net_fill_forward_path to support MLO
      wifi: mt76: mt7996: set vif default link_id adding/removing vif links
      wifi: mt76: mt7996: rework mt7996_ampdu_action to support MLO
      wifi: mt76: mt7996: Update mt7996_tx to MLO support
      net: mvneta: Add metadata support for xdp mode
      net: mvpp2: Add metadata support for xdp mode
      net: netsec: Add metadata support for xdp mode
      net: octeontx2: Add metadata support for xdp mode
      net: ethernet: mediatek: Add metadata support for xdp mode
      net: mana: Add metadata support for xdp mode
      net: ti: cpsw: Add metadata support for xdp mode

Luiz Augusto von Dentz (6):
      Bluetooth: btintel_pci: Fix build warning
      Bluetooth: hci_core: Enable buffer flow control for SCO/eSCO
      Bluetooth: hci_vhci: Mark Sync Flow Control as supported
      HCI: coredump: Log devcd dumps into the monitor
      Bluetooth: hci_event: Fix handling of HCI_EV_LE_DIRECT_ADV_REPORT
      Bluetooth: MGMT: Add LL Privacy Setting

Lukas Bulwahn (3):
      MAINTAINERS: adjust entry in AIROHA ETHERNET DRIVER
      net: ethernet: Remove accidental duplication in Kconfig file
      MAINTAINERS: adjust the file entry in INTEL PMC CORE DRIVER

Lukasz Czapnik (1):
      ice: fix input validation for virtchnl BW

Manish Dharanenthiran (1):
      wifi: ath12k: Fix invalid data access in ath12k_dp_rx_h_undecap_nwifi

Manivannan Sadhasivam (3):
      wifi: ath11k: Clear affinity hint before calling ath11k_pcic_free_irq() in error path
      wifi: ath12k: Clear affinity hint before calling ath12k_pci_free_irq() in error path
      wifi: ath11k/ath12k: Replace irq_set_affinity_hint() with irq_set_affinity_and_hint()

Manoj Panicker (1):
      bnxt_en: Add TPH support in BNXT driver

Marc Kleine-Budde (3):
      Merge patch series "can: c_can: Simplify few things"
      Merge patch series "add FlexCAN support for S32G2/S32G3 SoCs"
      Merge patch series "can: flexcan: add transceiver capabilities"

Marcus Wichelmann (6):
      net: tun: Enable XDP metadata support
      net: tun: Enable transfer of XDP metadata to skb
      selftests/bpf: Move open_tuntap to network helpers
      selftests/bpf: Refactor xdp_context_functional test and bpf program
      selftests/bpf: Add test for XDP metadata support in tun driver
      selftests/bpf: Fix file descriptor assertion in open_tuntap helper

Marek Behún (7):
      net: dsa: mv88e6xxx: fix VTU methods for 6320 family
      net: dsa: mv88e6xxx: fix atu_move_port_mask for 6341 family
      net: dsa: mv88e6xxx: enable PVT for 6321 switch
      net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
      net: dsa: mv88e6xxx: enable STU methods for 6320 family
      net: dsa: mv88e6xxx: fix internal PHYs for 6320 family
      net: dsa: mv88e6xxx: workaround RGMII transmit delay erratum for 6320 family

Mark Bloch (2):
      net/mlx5: LAG, reload representors on LAG creation failure
      net/mlx5: Lag, use port selection tables when available

Mark Zhang (1):
      net/mlx5e: Use right API to free bitmap memory

Markus Elfring (1):
      tipc: Reduce scope for the variable “fdefq” in tipc_link_tnl_prepare()

Martin KaFai Lau (5):
      Merge branch 'bpf-support-setting-max-rto-for-bpf_setsockopt'
      Merge branch 'net-timestamp-bpf-extension-to-equip-applications-transparently'
      Merge branch 'xsk-tx-metadata-launch-time-support'
      Merge branch 'xdp-metadata-support-for-tun-driver'
      Merge branch 'tcp-add-some-rto-min-and-delack-max-bpf_getsockopt-supports'

Martin Schiller (1):
      net: sfp: add quirk for FS SFP-10GM-T copper SFP+ module

Mateusz Polchlopek (5):
      ice: refactor ice_fdir_create_dflt_rules() function
      libeth: move idpf_rx_csum_decoded and idpf_rx_extracted
      iavf: define Rx descriptors as qwords
      iavf: Implement checking DD desc field
      ice: fix using untrusted value of pkt_len in ice_vc_fdir_parse_raw()

Matthieu Baerts (NGI0) (32):
      mptcp: pm: userspace: flags: clearer msg if no remote addr
      mptcp: pm: more precise error messages
      mptcp: pm: improve error messages
      mptcp: pm: remove duplicated error messages
      mptcp: pm: mark missing address attributes
      mptcp: pm: use NL_SET_ERR_MSG_ATTR when possible
      mptcp: pm: remove unused ret value to set flags
      mptcp: pm: change to fullmesh only for 'subflow'
      mptcp: sched: reduce size for unused data
      mptcp: blackhole: avoid checking the state twice
      mptcp: pm: exit early with ADD_ADDR echo if possible
      tcp: clamp window like before the cleanup
      tcp: ulp: diag: always print the name if any
      tcp: ulp: diag: more info without CAP_NET_ADMIN
      mptcp: pm: remove '_nl' from mptcp_pm_nl_addr_send_ack
      mptcp: pm: remove '_nl' from mptcp_pm_nl_mp_prio_send_ack
      mptcp: pm: remove '_nl' from mptcp_pm_nl_work
      mptcp: pm: remove '_nl' from mptcp_pm_nl_rm_addr_received
      mptcp: pm: remove '_nl' from mptcp_pm_nl_subflow_chk_stale()
      mptcp: pm: remove '_nl' from mptcp_pm_nl_is_init_remote_addr
      mptcp: pm: kernel: add '_pm' to mptcp_nl_set_flags
      mptcp: pm: avoid calling PM specific code from core
      mptcp: pm: worker: split in-kernel and common tasks
      mptcp: pm: export mptcp_remote_address
      mptcp: pm: move generic helper at the top
      mptcp: pm: move generic PM helpers to pm.c
      mptcp: pm: split in-kernel PM specific code
      mptcp: pm: move Netlink PM helpers to pm_netlink.c
      selftests: drv-net: fix merge conflicts resolution
      mptcp: pm: split netlink and in-kernel init
      mptcp: sockopt: fix getting IPV6_V6ONLY
      mptcp: sockopt: fix getting freebind & transparent

Max Schulze (1):
      net: usb: asix_devices: add FiberGecko DeviceID

Maxim Mikityanskiy (2):
      netfilter: socket: Lookup orig tuple for IPv6 SNAT
      net/mlx5e: Fix ethtool -N flow-type ip4 to RSS context

Maxime Chevallier (16):
      net: ethtool: Export the link_mode_params definitions
      net: phy: Use an internal, searchable storage for the linkmodes
      net: phy: phy_caps: Move phy_speeds to phy_caps
      net: phy: phy_caps: Move __set_linkmode_max_speed to phy_caps
      net: phy: phy_caps: Introduce phy_caps_valid
      net: phy: phy_caps: Implement link_capabilities lookup by linkmode
      net: phy: phy_caps: Allow looking-up link caps based on speed and duplex
      net: phy: phy_device: Use link_capabilities lookup for PHY aneg config
      net: phylink: Use phy_caps_lookup for fixed-link configuration
      net: phy: drop phy_settings and the associated lookup helpers
      net: phylink: Add a mapping between MAC_CAPS and LINK_CAPS
      net: phylink: Convert capabilities to linkmodes using phy_caps
      net: phylink: Use phy_caps to get an interface's capabilities and modes
      net: stmmac: Call xpcs_config_eee_mult_fact() only when xpcs is present
      net: phy: sfp: Add support for SMBus module access
      net: mdio: mdio-i2c: Add support for single-byte SMBus operations

Meghana Malladi (2):
      net: ti: icss-iep: Add pwidth configuration for perout signal
      net: ti: icss-iep: Add phase offset configuration for perout signal

Miaoqing Pan (4):
      wifi: ath11k: fix memory leak in ath11k_xxx_remove()
      wifi: ath12k: fix memory leak in ath12k_pci_remove()
      wifi: ath11k: use union for vaddr and iaddr in target_mem_chunk
      wifi: ath11k: Add firmware coredump collection support

Michael Chan (11):
      bnxt_en: Set NPAR 1.2 support when registering with firmware
      bnxt_en: Refactor completion ring allocation logic for P5_PLUS chips
      bnxt_en: Refactor TX ring allocation logic
      bnxt_en: Refactor RX/RX AGG ring parameters setup for P5_PLUS
      bnxt_en: Pass NQ ID to the FW when allocating RX/RX AGG rings
      bnxt_en: Refactor TX ring free logic
      bnxt_en: Refactor bnxt_hwrm_nvm_req()
      bnxt_en: Update firmware interface to 1.10.3.97
      bnxt_en: Refactor bnxt_get_module_eeprom_by_page()
      bnxt_en: Mask the bd_cnt field in the TX BD properly
      bnxt_en: Linearize TX SKB if the fragments exceed the max

Michael-CY Lee (1):
      wifi: mt76: mt7996: remove unnecessary key->cipher check for BIP frames

Michal Michalik (1):
      ice: Implement PTP support for E830 devices

Michal Swiatkowski (9):
      ice: count combined queues using Rx/Tx count
      ice: devlink PF MSI-X max and min parameter
      ice: remove splitting MSI-X between features
      ice: get rid of num_lan_msix field
      ice, irdma: move interrupts code to irdma
      ice: treat dyn_allowed only as suggestion
      ice: enable_rdma devlink param
      ice: simplify VF MSI-X managing
      ice: init flow director before RDMA

Mikhail Lobanov (1):
      wifi: mac80211: check basic rates validity in sta_link_apply_parameters

Ming Yen Hsieh (16):
      wifi: mt76: mt7925: introduce MLO capability control
      wifi: mt76: mt7925: ensure wow pattern command align fw format
      wifi: mt76: mt7925: fix country count limitation for CLC
      wifi: mt76: mt7921: fix kernel panic due to null pointer dereference
      wifi: mt76: mt7925: fix the wrong link_idx when a p2p_device is present
      wifi: mt76: mt7925: fix the wrong simultaneous cap for MLO
      wifi: mt76: mt7925: adjust rm BSS flow to prevent next connection failure
      wifi: mt76: mt7925: integrate *mlo_sta_cmd and *sta_cmd
      wifi: mt76: mt7925: update the power-saving flow
      wifi: mt76: mt7925: load the appropriate CLC data based on hardware type
      wifi: mt76: mt7925: add EHT control support based on the CLC data
      wifi: mt76: mt7925: update the channel usage when the regd domain changed
      wifi: mt76: mt7925: remove unused acpi function for clc
      wifi: mt76: mt792x: extend MTCL of APCI to version3 for EHT control
      wifi: mt76: mt7925: add MTCL support to enhance the regulatory compliance
      wifi: mt76: mt792x: re-register CHANCTX_STA_CSA only for the mt7921 series

Minjoong Kim (1):
      atm: Fix NULL pointer dereference

Miri Korenblit (31):
      wifi: mac80211: ensure sdata->work is canceled before initialized.
      wifi: iwlwifi: don't warn during reprobe
      wifi: mac80211: add ieee80211_iter_chan_contexts_mtx
      wifi: iwlwifi: remove mvm prefix from iwl_mvm_esr_mode_notif
      wifi: iwlwifi: mld: add a debug level for PTP prints
      wifi: iwlwifi: mld: add a debug level for EHT prints
      wifi: iwlwifi: remove mvm prefix from iwl_mvm_d3_end_notif
      wifi: iwlwifi: add IWL_MAX_NUM_IGTKS macro
      wifi: iwlwifi: add Debug Host Command APIs
      wifi: iwlwifi: add iwlmld sub-driver
      wifi: iwlwifi: bump FW API to 98 for BZ/SC/DR devices
      wifi: iwlwifi: bump minimum API version in BZ/SC to 93
      wifi: iwlwifi: don't warn when if there is a FW error
      wifi: iwlwifi: mld: fix build with CONFIG_PM_SLEEP undefined
      wifi: iwlwifi: mld: fix SMPS W/A
      wifi: iwlwifi: mld: track channel_load_not_by_us
      wifi: iwlwifi: mld: refactor iwl_mld_valid_emlsr_pair
      wifi: iwlwifi: mld: use the right iface iterator in low_latency
      wifi: iwlwifi: mld: always do MLO scan before link selection
      wifi: iwlwifi: mld: fix bad RSSI handling
      wifi: iwlwifi: mld: avoid selecting bad links
      wifi: iwlwifi: mld: remove IWL_MLD_EMLSR_BLOCKED_FW
      wifi: iwlwifi: mld: prevent toggling EMLSR due to FW requests
      wifi: iwlwifi: mld: allow EMLSR for unequal bandwidth
      wifi: iwlwifi: mld: KUnit: introduce iwl_mld_kunit_link
      wifi: iwlwifi: mld: KUnit: create chanctx with a custom width
      wifi: iwlwifi: mld: KUnit: test iwl_mld_channel_load_allows_emlsr
      wifi: iwlwifi: mld: make iwl_mld_run_fw_init_sequence static
      wifi: iwlwifi: mld: fix copy/paste error
      wifi: iwlwifi: mld: iwl_mld_remove_link can't fail
      wifi: iwlwifi: mld: add debugfs to control MLO scan

Mohsin Bashir (4):
      eth: fbnic: Add ethtool support for IRQ coalescing
      eth: fbnic: Add PCIe registers dump
      eth: fbnic: Consolidate PUL_USER CSR section
      eth: fbnic: Update return value in kdoc

Moshe Shemesh (6):
      net/mlx5: Avoid report two health errors on same syndrome
      net/mlx5: Log health buffer data on any syndrome
      net/mlx5: fs, add API for sharing HWS action by refcount
      net/mlx5: fs, add support for flow meters HWS action
      net/mlx5: fs, add support for dest flow sampler HWS action
      net/mlx5: Start health poll after enable hca

Murad Masimov (1):
      ax25: Remove broken autobind

Neeraj Sanjay Kale (7):
      Bluetooth: btnxpuart: Move vendor specific initialization to .post_init
      Bluetooth: btnxpuart: Add support for HCI coredump feature
      dt-bindings: net: bluetooth: nxp: Add support to set BD address
      Bluetooth: btnxpuart: Add support to set BD address
      Bluetooth: btnxpuart: Add correct bootloader error codes
      Bluetooth: btnxpuart: Handle bootloader error during cmd5 and cmd7
      Bluetooth: btnxpuart: Fix kernel panic during FW release

Nick Child (1):
      ibmvnic: Use kernel helpers for hex dumps

Nicolas Bouchinet (1):
      netfilter: conntrack: Bound nf_conntrack sysctl writes

Nicolas Dichtel (5):
      skbuff: kill skb_flow_get_ports()
      net: remove '__' from __skb_flow_get_ports()
      net: rename netns_local to netns_immutable
      net: advertise netns_immutable property via netlink
      net: plumb extack in __dev_change_net_namespace()

Nicolas Escande (5):
      wifi: ath12k: fix skb_ext_desc leak in ath12k_dp_tx() error path
      wifi: ath11k: remove peer extra rssi update
      wifi: ath12k: fix ath12k_hal_tx_cmd_ext_desc_setup() info1 override
      wifi: ath12k: add support of station average signal strength
      wifi: ath12k: Add missing htt_metadata flag in ath12k_dp_tx()

Nikita Zhandarovich (1):
      wifi: mt76: mt7915: fix possible integer overflows in mt7915_muru_stats_show()

Niklas Söderlund (1):
      net: phy: marvell-88q2xxx: Init PHY private structure for mv88q211x

Nikolay Aleksandrov (1):
      MAINTAINERS: update bridge entry

Ninad Palsule (1):
      dt-bindings: net: faraday,ftgmac100: Add phys mode

Oleksij Rempel (5):
      net: phy: dp83td510: introduce LED framework support
      net: phy: Add support for driver-specific next update time
      net: phy: dp83tg720: Add randomized polling intervals for link detection
      can: j1939: Extend stack documentation with buffer size behavior
      net: dsa: microchip: fix DCB apptrust configuration on KSZ88x3

Oliver Hartkopp (1):
      can: canxl: support Remote Request Substitution bit access

P Praneesh (19):
      wifi: ath11k: Fix DMA buffer allocation to resolve SWIOTLB issues
      wifi: ath11k: Use dma_alloc_noncoherent for rx_tid buffer allocation
      wifi: ath12k: Add HTT source ring ID for monitor rings
      wifi: ath12k: Enable filter config for monitor destination ring
      wifi: ath12k: Avoid multiple times configuring monitor filter
      wifi: ath12k: Avoid code duplication in monitor ring processing
      wifi: ath12k: Restructure the code for monitor ring processing
      wifi: ath12k: Fix invalid entry fetch in ath12k_dp_mon_srng_process
      wifi: ath12k: Fix end offset bit definition in monitor ring descriptor
      wifi: ath12k: Add drop descriptor handling for monitor ring
      wifi: ath12k: Handle end reason for the monitor destination ring
      wifi: ath12k: Optimize NAPI budget by adjusting PPDU processing
      wifi: ath12k: Handle PPDU spread across multiple buffers
      wifi: ath12k: Avoid memory leak while enabling statistics
      wifi: ath12k: Handle monitor drop TLVs scenario
      wifi: ath12k: Enable monitor ring mask for QCN9274
      wifi: ath12k: fix the ampdu id fetch in the HAL_RX_MPDU_START TLV
      wifi: ath11k: fix RCU stall while reaping monitor destination ring
      wifi: ath12k: remove redundant declaration of ath12k_dp_rx_h_find_peer()

Pagadala Yesu Anjaneyulu (7):
      wifi: iwlwifi: mvm: cleanup of TAS structure and enums
      wifi: iwlwifi: Add new TAS disable reason for invalid table source
      wifi: iwlwifi: mvm: Fix bit size calculation in iwl_dbgfs_tas_get_status_read
      wifi: iwlwifi: mld: Rename WIPHY_DEBUGFS_HANDLER_WRAPPER to WIPHY_DEBUGFS_WRITE_HANDLER_WRAPPER
      wifi: iwlwifi: mld: Add support for WIPHY_DEBUGFS_READ_FILE_OPS_MLD macro
      wifi: iwlwifi: mld: Ensure wiphy lock is held during debugfs read operations
      wifi: iwlwifi: mld: add support for DHC_TOOLS_UMAC_GET_TAS_STATUS command

Paolo Abeni (55):
      Merge branch 'support-one-ptp-device-per-hardware-clock'
      Merge branch 'mptcp-pm-misc-cleanups-part-2'
      Merge branch 'tcp-allow-to-reduce-max-rto'
      net: avoid unconditionally touching sk_tsflags on RX
      Merge branch 'add-af_xdp-support-for-cn10k'
      Merge branch 'vxlan-join-leave-mc-group-when-reconfigured'
      Merge branch 'net-phy-marvell-88q2xxx-cleanup'
      mptcp: consolidate subflow cleanup
      mptcp: drop __mptcp_fastopen_gen_msk_ackseq()
      mptcp: move the whole rx path under msk socket lock protection
      mptcp: cleanup mem accounting
      net: dismiss sk_forward_alloc_get()
      mptcp: dismiss __mptcp_rmem()
      mptcp: micro-optimize __mptcp_move_skb()
      Merge tag 'linux-can-next-for-6.15-20250219' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
      Merge branch 'eth-fbnic-update-fbnic-driver'
      Merge branch 'bpf-cpumap-enable-gro-for-xdp_pass-frames'
      Merge branch 'some-pktgen-fixes-improvments-part-ii'
      Merge branch 'net-notify-users-when-an-iface-cannot-change-its-netns'
      Merge branch 'introduce-flowtable-hw-offloading-in-airoha_eth-driver'
      Merge branch 'support-some-enhances-features-for-the-hibmcge-driver'
      Merge branch 'netconsole-add-taskname-sysdata-support'
      Merge branch 'enic-enable-32-64-byte-cqes-and-get-max-rx-tx-ring-size-from-hw'
      Merge branch 'net-ti-icssg-prueth-add-native-mode-xdp-support'
      Merge branch 'net-stmmac-dwmac-rk-validate-grf-and-peripheral-grf-during-probe'
      Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge branch 'mlx5-support-hws-flow-meter-sampler-actions-in-fs-core'
      Merge branch 'net-phy-clean-up-phy-package-mmd-access-functions'
      Merge branch 'net-stmmac-avoid-unnecessary-work-in-stmmac_release-stmmac_dvr_remove'
      Merge branch 'net-phy-rework-linkmodes-handling-in-a-dedicated-file'
      Merge branch 'intel-wired-lan-driver-updates-2025-03-10-ice-ixgbe'
      Merge branch 'bnxt_en-driver-update'
      Merge branch 'mlx5-support-setting-a-parent-for-a-devlink-rate-node'
      udp_tunnel: create a fastpath GRO lookup.
      udp_tunnel: use static call for GRO hooks when possible
      Merge branch 'udp_tunnel-gro-optimizations'
      Merge tag 'batadv-next-pullrequest-20250313' of git://git.open-mesh.org/linux-merge
      Merge tag 'linux-can-next-for-6.15-20250314' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next
      Merge branch 'inet-frags-fully-use-rcu'
      Merge branch 'net-stmmac-remove-unnecessary-of_get_phy_mode-calls'
      Merge tag 'ieee802154-for-net-next-2025-03-10' of git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next
      Merge branch 'net-stmmac-deprecate-snps-en-tx-lpi-clockgating-property'
      Merge branch 'net-mlx5-hw-steering-cleanups'
      Merge branch 'net-bring-back-dev_addr_sem'
      Merge branch 'netconsole-allow-selection-of-egress-interface-via-mac-address'
      Merge branch 'support-loopback-mode-speed-selection'
      Merge branch 'net-ptp-fix-egregious-supported-flag-checks'
      Merge branch 'mptcp-pm-prep-work-for-new-ops-and-sysctl-knobs'
      Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge branch 'net-phy-remove-calls-to-devm_hwmon_sanitize_name'
      Merge branch 'netconsole-add-support-for-userdata-release'
      Merge branch 'mlx5e-support-recovery-counter-in-reset'
      net: introduce per netns packet chains

Patrisious Haddad (3):
      net/mlx5: Change POOL_NEXT_SIZE define value and make it global
      net/mlx5: Query ADV_RDMA capabilities
      net/mlx5: fs, add RDMA TRANSPORT steering domain support

Paul Blakey (1):
      net/mlx5e: CT: Filter legacy rules that are unrelated to nic

Paul Greenwalt (1):
      ice: Add E830 checksum offload support

Pauli Virtanen (5):
      net-timestamp: COMPLETION timestamp on packet tx completion
      Bluetooth: add support for skb TX SND/COMPLETION timestamping
      Bluetooth: ISO: add TX timestamping
      Bluetooth: L2CAP: add TX timestamping
      Bluetooth: SCO: add TX timestamping

Pavan Chebbi (1):
      bnxt_en: Add devlink support for ENABLE_ROCE nvm parameter

Pavel Begunkov (8):
      net: page_pool: don't cast mp param to devmem
      net: prefix devmem specific helpers
      net: generalise net_iov chunk owners
      net: page_pool: create hooks for custom memory providers
      net: page_pool: add callback for mp info printing
      net: page_pool: add a mp hook to unregister_netdevice*
      net: prepare for non devmem TCP memory providers
      net: page_pool: add memory provider helpers

Pedro Nishiyama (4):
      Bluetooth: Add quirk for broken READ_VOICE_SETTING
      Bluetooth: Add quirk for broken READ_PAGE_SCAN_TYPE
      Bluetooth: Disable SCO support if READ_VOICE_SETTING is unsupported/broken
      Bluetooth: btusb: Fix regression in the initialization of fake Bluetooth controllers

Pei Xiao (1):
      net: freescale: ucc_geth: make ugeth_mac_ops be static const

Peng Fan (1):
      net: ethernet: Drop unused of_gpio.h

Peter Seiderer (17):
      net: pktgen: replace ENOTSUPP with EOPNOTSUPP
      net: pktgen: enable 'param=value' parsing
      net: pktgen: fix hex32_arg parsing for short reads
      net: pktgen: fix 'rate 0' error handling (return -EINVAL)
      net: pktgen: fix 'ratep 0' error handling (return -EINVAL)
      net: pktgen: fix ctrl interface command parsing
      net: pktgen: fix access outside of user given buffer in pktgen_thread_write()
      net: pktgen: fix mix of int/long
      net: pktgen: remove extra tmp variable (re-use len instead)
      net: pktgen: remove some superfluous variable initializing
      net: pktgen: fix mpls maximum labels list parsing
      net: pktgen: fix access outside of user given buffer in pktgen_if_write()
      net: pktgen: fix mpls reset parsing
      net: pktgen: remove all superfluous index assignements
      selftest: net: add proc_net_pktgen
      net: pktgen: add strict buffer parsing index check
      selftest: net: update proc_net_pktgen (add more imix_weights test cases)

Petr Machata (6):
      bridge: mdb: Allow replace of a host-joined group
      vxlan: Drop 'changelink' parameter from vxlan_dev_configure()
      vxlan: Join / leave MC group after remote changes
      selftests: forwarding: lib: Move require_command to net, generalize
      selftests: test_vxlan_fdb_changelink: Convert to lib.sh
      selftests: test_vxlan_fdb_changelink: Add a test for MC remote change

Philipp Hahn (1):
      cdc_ether|r8152: ThinkPad Hybrid USB-C/A Dock quirk

Philipp Stanner (3):
      stmmac: loongson: Remove surplus loop
      stmmac: Remove pcim_* functions for driver detach
      stmmac: Replace deprecated PCI functions

Ping-Ke Shih (33):
      wifi: rtw89: phy: rename to RTW89_PHY_NUM as proper naming
      wifi: rtw89: phy: add PHY context array to support functions per PHY
      wifi: rtw89: phy: support env_monitor per PHY
      wifi: rtw89: phy: support DIG per PHY
      wifi: rtw89: phy: support ch_info per PHY
      wifi: rtw89: phy: support EDCCA per PHY
      wifi: rtw89: phy: support EDCCA log per PHY
      wifi: rtw89: phy: disable CFO track when two PHY are working simultaneously
      wifi: rtw89: add wiphy_lock() to work that isn't held wiphy_lock() yet
      wifi: rtw89: use wiphy_work() to replace ieee802111_work()
      wifi: rtw89: debugfs: implement file_ops::read/write to replace seq_file
      wifi: rtw89: debugfs: specify buffer size allocated by devm_kazlloc() for reading
      wifi: rtw89: debugfs: use wiphy_locked_debugfs_{read,write}() if needed
      wifi: rtw89: debugfs: use debugfs_short_fops
      wifi: rtw89: remove consumers of driver mutex
      wifi: rtw89: manual cosmetic along lockdep_assert_wiphy()
      wifi: rtw89: remove definition of driver mutex
      wifi: rtw89: pci: not assert wiphy_lock to free early_h2c for PCI probe/remove
      wifi: rtw89: call power_on ahead before selecting firmware
      wifi: rtw89: fw: validate multi-firmware header before accessing
      wifi: rtw89: fw: validate multi-firmware header before getting its size
      wifi: rtw89: regd: avoid using BITMAP_FROM_U64() to assign function bitmap
      wifi: rtw89: debugfs depends on CFG80211's one
      wifi: rtw89: mac: define registers of agg_limit and txcnt_limit to share common flow
      wifi: rtw89: add H2C command of TX time for WiFi 7 chips
      wifi: rtw89: fw: add blacklist to avoid obsolete secure firmware
      wifi: rtw89: fw: get sb_sel_ver via get_unaligned_le32()
      wifi: rtw89: fw: propagate error code from rtw89_h2c_tx()
      wifi: rtw89: fw: add debug message for unexpected secure firmware
      wifi: rtw89: fw: safely cast mfw_hdr pointer from firmware->data
      wifi: rtw89: fw: correct debug message format in rtw89_build_txpwr_trk_tbl_from_elm()
      wifi: rtw89: fw: don't reject firmware in blacklist to prevent breaking users
      wifi: rtw89: pci: correct ISR RDU bit for 8922AE

Piotr Kwapulinski (1):
      ixgbe: add PTP support for E610 device

Po-Hao Huang (2):
      wifi: rtw89: fw: use struct to fill role_maintain H2C command
      wifi: rtw89: fw: update role_maintain H2C command for roles operating on band 1

Pranav Tyagi (1):
      selftests: net: fix grammar in reuseaddr_ports_exhausted.c log message

Pranjal Shrivastava (1):
      net: Fix the devmem sock opts and msgs for parisc

Przemek Kitszel (1):
      ice: health.c: fix compilation on gcc 7.5

Purva Yeshi (1):
      af_unix: Fix undefined 'other' error

Qingfang Deng (3):
      net: ethernet: mediatek: add EEE support
      ppp: use IFF_NO_QUEUE in virtual interfaces
      net: stmmac: Fix accessing freed irq affinity_hint

Quan Zhou (2):
      wifi: mt76: mt7925: fix fails to enter low power mode in suspend state
      wifi: mt76: mt7925: Simplify HIF suspend handling to avoid suspend fail

Ramasamy Kaliappan (1):
      wifi: ath12k: Improve BSS discovery with hidden SSID in 6 GHz band

Rameshkumar Sundaram (1):
      wifi: ath12k: Fix pdev lookup in WBM error processing

Ramya Gnanasekar (3):
      wifi: ath12k: Request vdev stats from firmware
      wifi: ath12k: Request beacon stats from firmware
      wifi: ath12k: Request pdev stats from firmware

Razvan Grigore (3):
      wifi: mt76: add mt76_get_power_bound helper function
      wifi: mt76: mt7915: cleanup mt7915_get_power_bound
      wifi: mt76: mt7996: cleanup mt7996_get_power_bound

Remi Pommarel (1):
      wifi: ath12k: remove return for empty tx bitrate in mac_op_sta_statistics

Rex Lu (1):
      wifi: mt76: mt7996: fix SER reset trigger on WED reset

Ritvik Gupta (1):
      Documentation: dpaa2 ethernet switch driver: Fix spelling

Robin van der Gracht (1):
      can: rockchip_canfd: rkcanfd_chip_fifo_setup(): remove duplicated setup of RX FIFO

Roger Quadros (8):
      net: ethernet: ti: am65-cpsw: remove am65_cpsw_nuss_tx_compl_packets_2g()
      net: ethernet: ti: am65_cpsw: remove cpu argument am65_cpsw_run_xdp
      net: ethernet: ti: am65-cpsw: use return instead of goto in am65_cpsw_run_xdp()
      net: ethernet: ti: am65_cpsw: move am65_cpsw_put_page() out of am65_cpsw_run_xdp()
      net: ethernet: ti am65_cpsw: Drop separate TX completion functions
      net: ti: icssg-prueth: Use page_pool API for RX buffer allocation
      net: ti: icssg-prueth: introduce and use prueth_swdata struct for SWDATA
      net: ti: icssg-prueth: Add XDP support

Roopni Devanathan (2):
      wifi: ath12k: Support Uplink MUMIMO Trigger Stats
      wifi: ath12k: Add NULL check to validate tpc_stats

Rosen Penev (1):
      wifi: ath9k: return by of_get_mac_address

Ruffalo Lavoisier (1):
      dt-binding: can: mcp251xfd: remove duplicate word

Russell King (Oracle) (79):
      net: pcs: rzn1-miic: fill in PCS supported_interfaces
      net: stmmac: delete software timer before disabling LPI
      net: stmmac: ensure LPI is disabled when disabling EEE
      net: stmmac: dwmac4: ensure LPIATE is cleared
      net: stmmac: split stmmac_init_eee() and move to phylink methods
      net: stmmac: remove priv->dma_cap.eee test in tx_lpi methods
      net: stmmac: remove unnecessary priv->eee_active tests
      net: stmmac: remove unnecessary priv->eee_enabled tests
      net: stmmac: clear priv->tx_path_in_lpi_mode when disabling LPI
      net: stmmac: remove unnecessary LPI disable when enabling LPI
      net: stmmac: use common LPI_CTRL_STATUS bit definitions
      net: stmmac: add new MAC method set_lpi_mode()
      net: stmmac: dwmac4: clear LPI_CTRL_STATUS_LPITCSE too
      net: stmmac: use stmmac_set_lpi_mode()
      net: stmmac: remove old EEE methods
      net: phylink: provide phylink_mac_implements_lpi()
      net: dsa: allow use of phylink managed EEE support
      net: dsa: mt7530: convert to phylink managed EEE
      net: phylink: add support for notifying PCS about EEE
      net: xpcs: add function to configure EEE clock multiplying factor
      net: stmmac: call xpcs_config_eee_mult_fact()
      net: xpcs: convert to phylink managed EEE
      net: stmmac: remove calls to xpcs_config_eee()
      net: xpcs: remove xpcs_config_eee() from global scope
      net: xpcs: clean up xpcs_config_eee()
      net: xpcs: group EEE code together
      net: remove phylink_pcs .neg_mode boolean
      net: xpcs: rearrange register definitions
      net: stmmac: clarify priv->pause and pause module parameter
      net: stmmac: remove useless priv->flow_ctrl
      net: stmmac: "speed" passed to fix_mac_speed is an int
      net: stmmac: print stmmac_init_dma_engine() errors using netdev_err()
      net: stmmac: qcom-ethqos: use rgmii_clock() to set the link clock
      net: stmmac: thead: use rgmii_clock() for RGMII clock rate
      net: stmmac: thead: ensure divisor gives proper rate
      net: stmmac: dwc-qos: name struct plat_stmmacenet_data consistently
      net: stmmac: dwc-qos: clean up clock initialisation
      net: stmmac: provide set_clk_tx_rate() hook
      net: stmmac: provide generic implementation for set_clk_tx_rate method
      net: stmmac: dwc-qos: use generic stmmac_set_clk_tx_rate()
      net: stmmac: starfive: use generic stmmac_set_clk_tx_rate()
      net: stmmac: s32: use generic stmmac_set_clk_tx_rate()
      net: stmmac: intel: use generic stmmac_set_clk_tx_rate()
      net: stmmac: imx: use generic stmmac_set_clk_tx_rate()
      net: stmmac: rk: switch to use set_clk_tx_rate() hook
      net: stmmac: ipq806x: switch to use set_clk_tx_rate() hook
      net: stmmac: meson: switch to use set_clk_tx_rate() hook
      net: stmmac: thead: switch to use set_clk_tx_rate() hook
      net: stmmac: mostly remove "buf_sz"
      net: stmmac: avoid shadowing global buf_sz
      net: stmmac: simplify phylink_suspend() and phylink_resume() calls
      net: stmmac: remove write-only priv->speed
      net: phylink: expand on .pcs_config() method documentation
      net: stmmac: remove redundant racy tear-down in stmmac_dvr_remove()
      net: stmmac: remove unnecessary stmmac_mac_set() in stmmac_release()
      net: stmmac: qcom-ethqos: remove of_get_phy_mode()
      net: stmmac: mediatek: remove of_get_phy_mode()
      net: stmmac: anarion: remove of_get_phy_mode()
      net: stmmac: ipq806x: remove of_get_phy_mode()
      net: stmmac: meson8b: remove of_get_phy_mode()
      net: stmmac: rk: remove of_get_phy_mode()
      net: stmmac: sti: remove of_get_phy_mode()
      net: stmmac: sun8i: remove of_get_phy_mode()
      net: stmmac: sunxi: remove of_get_phy_mode()
      net: stmmac: allow platforms to use PHY tx clock stop capability
      net: stmmac: starfive: use PHY capability for TX clock stop
      net: stmmac: stm32: use PHY capability for TX clock stop
      riscv: dts: starfive: remove "snps,en-tx-lpi-clockgating" property
      ARM: dts: stm32: remove "snps,en-tx-lpi-clockgating" property
      dt-bindings: deprecate "snps,en-tx-lpi-clockgating" property
      net: stmmac: deprecate "snps,en-tx-lpi-clockgating" property
      net: phy: fix genphy_c45_eee_is_active() for disabled EEE
      net: phy: realtek: disable PHY-mode EEE
      net: phylink: add phylink_prepare_resume()
      net: stmmac: address non-LPI resume failures properly
      net: stmmac: socfpga: remove phy_resume() call
      net: phylink: add functions to block/unblock rx clock stop
      net: stmmac: block PHY RXC clock-stop
      net: phylink: force link down on major_config failure

Ryohei Kinugawa (1):
      docs/kcm: Fix typo "BFP"

Salvatore Bonaccorso (1):
      wifi: b43: Replace outdated firmware URL

Sankararaman Jayaraman (1):
      vmxnet3: unregister xdp rxq info in the reset path

Sarika Sharma (2):
      wifi: cfg80211: reorg sinfo structure elements for mesh
      wifi: mac80211: refactor populating mesh related fields in sinfo

Sathishkumar Muruganandam (1):
      wifi: ath12k: encode max Tx power in scan channel list command

Satish Kharat (8):
      enic: Move function from header file to c file
      enic: enic rq code reorg
      enic: enic rq extended cq defines
      enic: enable rq extended cq support
      enic: remove unused function cq_enet_wq_desc_dec
      enic: added enic_wq.c and enic_wq.h
      enic: cleanup of enic wq request completion path
      enic: get max rq & wq entries supported by hw, 16K queues

Sean Anderson (9):
      net: xilinx: axienet: Combine CR calculation
      net: xilinx: axienet: Support adjusting coalesce settings while running
      net: xilinx: axienet: Get coalesce parameters from driver state
      net: xilinx: axienet: Enable adaptive IRQ coalescing with DIM
      net: xilinx: axienet: Implement BQL
      net: cadence: macb: Convert to get_stats64
      net: cadence: macb: Report standard stats
      net: cadence: macb: Implement BQL
      net: cadence: macb: Synchronize standard stats

Sean Wang (2):
      Revert "wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_ba for MLO"
      Bluetooth: btmtksdio: Prevent enabling interrupts after IRQ handler removal

Shahar Shitrit (14):
      net/mlx5: Apply rate-limiting to high temperature warning
      net/mlx5: Prefix temperature event bitmap with '0x' for clarity
      net/mlx5: Modify LSB bitmask in temperature event to include only the first bit
      net/mlx5: Add sensor name to temperature event message
      net/mlx5e: Refactor ptys2ethtool_adver_link()
      net/mlx5e: Introduce ptys2ethtool_process_link()
      net/mlx5e: Change eth_proto parameter naming
      net/mlx5e: Separate extended link modes request from link modes type selection
      net/mlx5: Add new health syndrome error and crr bit offset
      net/mlx5: Expose crr in health buffer
      net/mlx5: Add trust lockdown error to health syndrome print function
      net/mlx5: Relocate function declarations from port.h to mlx5_core.h
      net/mlx5: Refactor link speed handling with mlx5_link_info struct
      net/mlx5e: Enable lanes configuration when auto-negotiation is off

Shaul Triebitz (2):
      wifi: iwlwifi: support ROC version 6
      wifi: iwlwifi: add twt operation cmd

Shay Drory (1):
      net/mlx5: Update pfnum retrieval for devlink port attributes

Shayne Chen (16):
      wifi: mt76: mt7996: Add mt7996_mac_sta_change_links callback
      wifi: mt76: Check link_conf pointer in mt76_connac_mcu_sta_basic_tlv()
      wifi: mt76: mt7996: Update mt7996_mcu_add_sta to MLO support
      wifi: mt76: mt7996: Rely on mt7996_vif_link in mt7996_mcu_twt_agrt_update signature
      wifi: mt76: mt7996: Update mt7996_mcu_add_rate_ctrl to MLO
      wifi: mt76: mt7996: Add mt7996_mcu_sta_mld_setup_tlv() and mt7996_mcu_sta_eht_mld_tlv()
      wifi: mt76: mt7996: Add mt7996_mcu_teardown_mld_sta rouine
      wifi: mt76: mt7996: rework mt7996_mac_write_txwi() for MLO support
      wifi: mt76: mt7996: Rely on wcid_to_sta in mt7996_mac_add_txs_skb()
      wifi: mt76: mt7996: rework mt7996_rx_get_wcid to support MLO
      wifi: mt76: mt7996: rework mt7996_sta_set_4addr and mt7996_sta_set_decap_offload to support MLO
      wifi: mt76: mt7996: rework mt7996_set_hw_key to support MLO
      wifi: mt76: mt7996: remove mt7996_mac_enable_rtscts()
      wifi: mt76: mt7996: rework mt7996_mcu_add_obss_spr to support MLO
      wifi: mt76: mt7996: rework mt7996_mcu_beacon_inband_discov to support MLO
      wifi: mt76: mt7996: rework set/get_tsf callabcks to support MLO

Shradha Gupta (2):
      net: mana: Allow tso_max_size to go up-to GSO_MAX_SIZE
      hv_netvsc: Use VF's tso_max_size value when data path is VF

Siddh Raman Pant (1):
      netlink: Unset cb_running when terminating dump on release

Simei Su (1):
      ice: support Rx timestamp on flex descriptor

Simon Horman (3):
      net/mlx5: Avoid unnecessary use of comma operator
      tty: caif: removed unused function debugfs_tx()
      net: tulip: avoid unused variable warning

Simon Wunderlich (1):
      batman-adv: Start new development cycle

Sky Huang (5):
      net: phy: mediatek: Change to more meaningful macros
      net: phy: mediatek: Add token ring access helper functions in mtk-phy-lib
      net: phy: mediatek: Add token ring set bit operation support
      net: phy: mediatek: Add token ring clear bit operation support
      net: phy: mediatek: Move some macros to phy-lib for later use

Soeren Moch (1):
      wifi: rtl8xxxu: retry firmware download on error

Somnath Kotur (4):
      bnxt_en: Refactor completion ring free routine
      bnxt_en: Refactor bnxt_free_tx_rings() to free per TX ring
      bnxt_en: Reallocate RX completion ring for TPH support
      bnxt_en: Extend queue stop/start for TX rings

Song Yoong Siang (6):
      igc: Avoid unnecessary link down event in XDP_SETUP_PROG process
      xsk: Add launch time hardware offload support to XDP Tx metadata
      selftests/bpf: Add launch time request to xdp_hw_metadata
      net: stmmac: Add launch time support to XDP ZC
      igc: Refactor empty frame insertion for launch time support
      igc: Add launch time support to XDP ZC

Sowmiya Sree Elavalagan (2):
      wifi: ath12k: Add Support to Parse TPC Event from Firmware
      wifi: ath12k: Add Support to Calculate and Display TPC Values

Stanislav Fomichev (23):
      net: hold netdev instance lock during ndo_open/ndo_stop
      net: hold netdev instance lock during nft ndo_setup_tc
      net: sched: wrap doit/dumpit methods
      net: hold netdev instance lock during qdisc ndo_setup_tc
      net: hold netdev instance lock during queue operations
      net: hold netdev instance lock during rtnetlink operations
      net: hold netdev instance lock during ioctl operations
      net: hold netdev instance lock during sysfs operations
      net: hold netdev instance lock during ndo_bpf
      net: replace dev_addr_sem with netdev instance lock
      net: add option to request netdev instance lock
      docs: net: document new locking reality
      eth: bnxt: remove most dependencies on RTNL
      net: revert to lockless TC_SETUP_BLOCK and TC_SETUP_FT
      eth: bnxt: switch to netif_close
      eth: bnxt: request unconditional ops lock
      eth: bnxt: add missing netdev lock management to bnxt_dl_reload_up
      net: create netdev_nl_sock to wrap bindings list
      net: add granular lock for the netdev netlink socket
      net: drop rtnl_lock for queue_mgmt operations
      Revert "net: replace dev_addr_sem with netdev instance lock"
      net: reorder dev_addr_sem lock
      net: vlan: don't propagate flags on open

Stefano Jordhani (1):
      net: use napi_id_valid helper

Steffen Klassert (1):
      Merge branch 'Support-PMTU-in-tunnel-mode-for-packet-offload'

Stephen Rothwell (1):
      unix: fix up for "apparmor: add fine grained af_unix mediation"

Suchit (1):
      selftests: net: Fix minor typos in MPTCP and psock tests

Sudeep Holla (1):
      net: phy: fixed_phy: transition to the faux device interface

Suman Ghosh (6):
      octeontx2-pf: use xdp_return_frame() to free xdp buffers
      octeontx2-pf: Add AF_XDP non-zero copy support
      octeontx2-pf: AF_XDP zero copy receive support
      octeontx2-pf: Reconfigure RSS table after enabling AF_XDP zerocopy on rx queue
      octeontx2-pf: Prepare for AF_XDP
      octeontx2-pf: AF_XDP zero copy transmit support

Sven Eckelmann (8):
      batman-adv: Drop batadv_priv_debug_log struct
      batman-adv: Add support for jumbo frames
      batman-adv: Use consistent name for mesh interface
      batman-adv: Limit number of aggregated packets directly
      batman-adv: Switch to bitmap helper for aggregation handling
      batman-adv: Use actual packet count for aggregated packets
      batman-adv: Limit aggregation size to outgoing MTU
      batman-adv: add missing newlines for log macros

Swathi K S (3):
      net: stmmac: refactor clock management in EQoS driver
      dt-bindings: net: Add FSD EQoS device tree bindings
      net: stmmac: dwc-qos: Add FSD EQoS support

Taehee Yoo (1):
      eth: bnxt: fix out-of-range access of vnic_info array

Tamir Duberstein (1):
      blackhole_dev: convert self-test to KUnit

Tariq Toukan (2):
      net/mlx5e: Always select CONFIG_PAGE_POOL_STATS
      net/mlx5e: TX, Utilize WQ fragments edge for multi-packet WQEs

Ted Chen (1):
      vxlan: Remove unnecessary comments for vxlan_rcv() and vxlan_err_lookup()

Thorsten Blum (7):
      sctp: Remove commented out code
      net/rds: Replace deprecated strncpy() with strscpy_pad()
      net: ethernet: renesas: rcar_gen4_ptp: Remove bool conversion
      net/mlx5: Use secs_to_jiffies() instead of msecs_to_jiffies()
      sctp: Remove unused payload from sctp_idatahdr
      wifi: mt76: mt7925: Remove unnecessary if-check
      netfilter: xtables: Use strscpy() instead of strscpy_pad()

Torben Nielsen (1):
      net: dsa: b53: mdio: add support for BCM53101

Uday Shankar (2):
      net, treewide: define and use MAC_ADDR_STR_LEN
      netconsole: allow selection of egress interface via MAC address

Vasuthevan Maheswaran (1):
      bnxt_en: Add support for a new ethtool dump flag 3

Vijay Satija (1):
      Bluetooth: btintel: Add support to configure TX power

Vinith Kumar R (1):
      wifi: ath12k: Report proper tx completion status to mac80211

Vladimir Oltean (3):
      net: dsa: sja1105: fix displaced ethtool statistics counters
      net: dsa: sja1105: reject other RX filters than HWTSTAMP_FILTER_PTP_V2_L2_EVENT
      net: dsa: sja1105: fix kasan out-of-bounds warning in sja1105_table_delete_entry()

Wang Liang (2):
      bonding: check xdp prog when set bond mode
      net: fix NULL pointer dereference in l3mdev_l3_rcv

WangYuli (3):
      netfilter: nf_tables: Only use nf_skip_indirect_calls() when MITIGATION_RETPOLINE
      docs: networking: strparser: Fix a typo
      mlxsw: spectrum_acl_bloom_filter: Workaround for some LLVM versions

Wen Gong (2):
      wifi: ath11k: update channel list in reg notifier instead reg worker
      wifi: ath11k: update channel list in worker when wait flag is set

Wentao Guan (1):
      Bluetooth: HCI: Add definition of hci_rp_remote_name_req_cancel

Willem de Bruijn (14):
      tcp: only initialize sockcm tsflags field
      net: initialize mark in sockcm_init
      ipv4: initialize inet socket cookies with sockcm_init
      ipv4: remove get_rttos
      icmp: reflect tos through ip cookie rather than updating inet_sk
      ipv6: replace ipcm6_init calls with ipcm6_init_sk
      ipv6: initialize inet socket cookies with sockcm_init
      selftests/net: prepare cmsg_ipv6.sh for ipv4
      selftests/net: expand cmsg_ipv6.sh with ipv4
      net: skb: free up one bit in tx_flags
      selftests/net: add proc_net_pktgen to .gitignore
      ipv6: remove leftover ip6 cookie initializer
      ipv6: save dontfrag in cork
      selftests/net: expand cmsg_ip with MSG_MORE

William Tu (3):
      net/mlx5e: reduce the max log mpwrq sz for ECPF and reps
      net/mlx5e: reduce rep rxq depth to 256 for ECPF
      net/mlx5e: set the tx_queue_len for pfifo_fast

Wojtek Wasko (3):
      posix-clock: Store file pointer in struct posix_clock_context
      ptp: Add PHC file mode checks. Allow RO adjtime() without FMODE_WRITE.
      testptp: Add option to open PHC in readonly mode

Wolfram Sang (2):
      net: phy: broadcom: don't include '<linux/pm_wakeup.h>' directly
      net: wwan: t7xx: don't include '<linux/pm_wakeup.h>' directly

Xiao Liang (13):
      rtnetlink: Lookup device in target netns when creating link
      rtnetlink: Pack newlink() params into struct
      net: Use link/peer netns in newlink() of rtnl_link_ops
      ieee802154: 6lowpan: Validate link netns in newlink() of rtnl_link_ops
      net: ip_tunnel: Don't set tunnel->net in ip_tunnel_init()
      net: ip_tunnel: Use link netns in newlink() of rtnl_link_ops
      net: ipv6: Init tunnel link-netns before registering dev
      net: ipv6: Use link netns in newlink() of rtnl_link_ops
      net: xfrm: Use link netns in newlink() of rtnl_link_ops
      rtnetlink: Remove "net" from newlink params
      rtnetlink: Create link directly in target net namespace
      selftests: net: Add python context manager for netns entering
      selftests: net: Add test cases for link and peer netns

Yael Chemla (5):
      net/mlx5: Add IFC bits for PPCNT recovery counters group
      net/mlx5e: Ensure each counter group uses its PCAM bit
      net/mlx5e: Access PHY layer counter group as other counter groups
      net/mlx5e: Get counter group size by FW capability
      net/mlx5e: Expose port reset cycle recovery counter via ethtool

Yevgeny Kliteynik (3):
      net/mlx5: HWS, remove unused code for alias flow tables
      net/mlx5: HWS, use list_move() instead of del/add
      net/mlx5: HWS, log the unsupported mask in definer

Yu Zhang(Yuriy) (2):
      wifi: ath11k: add support for MU EDCA
      wifi: ath11k: fix wrong overriding for VHT Beamformee STS Capability

Yu-Chun Lin (1):
      net: stmmac: Use str_enabled_disabled() helper

Yue Haibing (2):
      mptcp: Remove unused declaration mptcp_set_owner_r()
      net: skbuff: Remove unused skb_add_data()

Yui Washizu (1):
      docs: fix the path of example code and example commands for device memory TCP

Yuyang Huang (2):
      netlink: support dumping IPv4 multicast addresses
      selftests/net: Add selftest for IPv4 RTM_GETMULTICAST support

Zenm Chen (1):
      wifi: rtw88: Add support for Mercusys MA30N and D-Link DWA-T185 rev. A1

Zijun Hu (1):
      Bluetooth: btusb: Add 13 USB device IDs for Qualcomm WCN785x

Ziwei Xiao (1):
      gve: Add RSS cache for non RSS device option scenario

Zong-Zhe Yang (4):
      wifi: rtw89: regd: support loading regd table from fw element
      wifi: rtw89: regd: handle supported regulatory functions by country
      wifi: rtw89: regd: refactor init/setup flow and prototype
      wifi: rtw89: cleanup unused rtwdev::roc_work

shantiprasad shettar (1):
      bnxt_en: Query FW parameters when the CAPS_CHANGE bit is set

 CREDITS                                            |     4 +
 Documentation/arch/s390/driver-model.rst           |     2 +-
 .../devicetree/bindings/net/airoha,en7581-eth.yaml |    10 +
 .../devicetree/bindings/net/airoha,en7581-npu.yaml |    84 +
 .../bindings/net/amlogic,meson-dwmac.yaml          |     6 +
 .../bindings/net/bluetooth/nxp,88w8987-bt.yaml     |    18 +-
 .../bindings/net/bluetooth/qualcomm-bluetooth.yaml |     2 +
 .../devicetree/bindings/net/can/fsl,flexcan.yaml   |    57 +-
 .../bindings/net/can/microchip,mcp251xfd.yaml      |     2 +-
 .../devicetree/bindings/net/dsa/brcm,b53.yaml      |     2 +
 .../devicetree/bindings/net/ethernet-phy.yaml      |     6 +
 .../devicetree/bindings/net/faraday,ftgmac100.yaml |     3 +
 .../devicetree/bindings/net/fsl,gianfar-mdio.yaml  |   112 +
 .../devicetree/bindings/net/fsl,gianfar.yaml       |   248 +
 .../devicetree/bindings/net/fsl-tsec-phy.txt       |    80 +-
 .../devicetree/bindings/net/ieee802154/ca8210.txt  |     2 +-
 .../devicetree/bindings/net/intel,dwmac-plat.yaml  |     6 +
 .../devicetree/bindings/net/mediatek-dwmac.yaml    |     6 +
 .../devicetree/bindings/net/nxp,dwmac-imx.yaml     |     8 +
 .../devicetree/bindings/net/qcom,ipa.yaml          |   124 +-
 .../bindings/net/realtek,rtl9301-mdio.yaml         |    86 +
 .../{mfd => net}/realtek,rtl9301-switch.yaml       |    63 +-
 .../devicetree/bindings/net/rfkill-gpio.yaml       |     5 +
 .../devicetree/bindings/net/rockchip-dwmac.yaml    |    47 +-
 .../devicetree/bindings/net/snps,dwmac.yaml        |    10 +-
 .../bindings/net/sophgo,sg2044-dwmac.yaml          |   126 +
 .../devicetree/bindings/net/stm32-dwmac.yaml       |    10 +
 .../devicetree/bindings/net/tesla,fsd-ethqos.yaml  |   118 +
 .../bindings/net/toshiba,visconti-dwmac.yaml       |     6 +
 .../bindings/net/wireless/qcom,ath10k.yaml         |    25 +-
 .../bindings/net/wireless/qcom,ath11k-pci.yaml     |     9 +-
 .../bindings/net/wireless/qcom,ath11k.yaml         |     7 +
 .../bindings/net/wireless/qcom,ath12k-wsi.yaml     |    13 +-
 Documentation/netlink/genetlink-c.yaml             |     7 +-
 Documentation/netlink/genetlink-legacy.yaml        |    10 +-
 Documentation/netlink/genetlink.yaml               |     7 +-
 Documentation/netlink/specs/conntrack.yaml         |   643 +
 Documentation/netlink/specs/devlink.yaml           |     1 +
 Documentation/netlink/specs/netdev.yaml            |    38 +-
 Documentation/netlink/specs/nl80211.yaml           |  2000 ++
 Documentation/netlink/specs/rt_addr.yaml           |    23 +
 Documentation/netlink/specs/rt_link.yaml           |    19 +
 Documentation/netlink/specs/rt_rule.yaml           |    15 +
 Documentation/networking/batman-adv.rst            |     2 +-
 .../networking/device_drivers/cable/index.rst      |    18 -
 .../networking/device_drivers/cable/sb1000.rst     |   222 -
 .../ethernet/freescale/dpaa2/switch-driver.rst     |     2 +-
 .../ethernet/mellanox/mlx5/counters.rst            |     5 +
 Documentation/networking/device_drivers/index.rst  |     1 -
 Documentation/networking/devlink/bnxt.rst          |     2 +
 Documentation/networking/devlink/ice.rst           |    11 +
 Documentation/networking/devlink/mlx5.rst          |     4 +
 Documentation/networking/devlink/sfc.rst           |    16 +-
 Documentation/networking/devmem.rst                |     5 +-
 Documentation/networking/ethtool-netlink.rst       |     2 +-
 Documentation/networking/ip-sysctl.rst             |    17 +-
 Documentation/networking/j1939.rst                 |   675 +
 Documentation/networking/kcm.rst                   |     2 +-
 Documentation/networking/mptcp-sysctl.rst          |    23 +
 Documentation/networking/napi.rst                  |    33 +-
 .../net_cachelines/inet_connection_sock.rst        |     5 +-
 .../networking/net_cachelines/net_device.rst       |     2 +-
 .../net_cachelines/netns_ipv4_sysctl.rst           |     1 +
 Documentation/networking/net_cachelines/snmp.rst   |     1 +
 .../networking/net_cachelines/tcp_sock.rst         |     1 +
 Documentation/networking/netconsole.rst            |   104 +-
 Documentation/networking/netdevices.rst            |    71 +-
 Documentation/networking/scaling.rst               |    21 +-
 Documentation/networking/strparser.rst             |     2 +-
 Documentation/networking/switchdev.rst             |     2 +-
 Documentation/networking/timestamping.rst          |     8 +
 Documentation/networking/xfrm_device.rst           |     3 +-
 Documentation/networking/xsk-tx-metadata.rst       |    62 +
 Documentation/process/maintainer-netdev.rst        |     8 +
 MAINTAINERS                                        |    10 +-
 arch/arm/boot/dts/st/stm32mp151.dtsi               |     1 -
 arch/parisc/include/uapi/asm/socket.h              |    12 +-
 arch/powerpc/configs/ppc6xx_defconfig              |     1 -
 arch/riscv/boot/dts/starfive/jh7110.dtsi           |     2 -
 arch/s390/include/asm/irq.h                        |     1 -
 arch/s390/kernel/irq.c                             |     1 -
 drivers/acpi/acpi_pnp.c                            |     2 -
 drivers/bluetooth/bfusb.c                          |     3 +-
 drivers/bluetooth/btintel.c                        |   341 +
 drivers/bluetooth/btintel.h                        |    24 +
 drivers/bluetooth/btintel_pcie.c                   |   582 +-
 drivers/bluetooth/btintel_pcie.h                   |    93 +
 drivers/bluetooth/btmtk.c                          |    10 -
 drivers/bluetooth/btmtksdio.c                      |     3 +-
 drivers/bluetooth/btnxpuart.c                      |   407 +-
 drivers/bluetooth/btqca.c                          |    27 +-
 drivers/bluetooth/btqca.h                          |     4 +
 drivers/bluetooth/btusb.c                          |    36 +-
 drivers/bluetooth/hci_ldisc.c                      |    19 +-
 drivers/bluetooth/hci_qca.c                        |    27 +-
 drivers/bluetooth/hci_uart.h                       |     1 +
 drivers/bluetooth/hci_vhci.c                       |     5 +-
 drivers/dpll/dpll_core.c                           |     5 +-
 drivers/gpio/gpiolib-of.c                          |     9 +
 drivers/infiniband/hw/irdma/hw.c                   |     2 -
 drivers/infiniband/hw/irdma/main.c                 |    46 +-
 drivers/infiniband/hw/irdma/main.h                 |     3 +
 drivers/infiniband/ulp/ipoib/ipoib_netlink.c       |     9 +-
 drivers/net/Kconfig                                |    24 -
 drivers/net/Makefile                               |     1 -
 drivers/net/amt.c                                  |    13 +-
 drivers/net/bareudp.c                              |     9 +-
 drivers/net/bonding/bond_main.c                    |    50 +-
 drivers/net/bonding/bond_netlink.c                 |     6 +-
 drivers/net/bonding/bond_options.c                 |     3 +
 drivers/net/caif/caif_serial.c                     |    14 -
 drivers/net/can/c_can/c_can_platform.c             |    51 +-
 drivers/net/can/dev/netlink.c                      |     4 +-
 drivers/net/can/flexcan/flexcan-core.c             |    62 +-
 drivers/net/can/flexcan/flexcan.h                  |     6 +
 drivers/net/can/rockchip/rockchip_canfd-core.c     |     5 -
 drivers/net/can/usb/gs_usb.c                       |     5 +
 drivers/net/can/vxcan.c                            |     7 +-
 drivers/net/dsa/Kconfig                            |     1 +
 drivers/net/dsa/b53/b53_common.c                   |    14 +
 drivers/net/dsa/b53/b53_mdio.c                     |     1 +
 drivers/net/dsa/b53/b53_priv.h                     |     2 +
 drivers/net/dsa/b53/b53_serdes.c                   |     1 -
 drivers/net/dsa/microchip/ksz8.c                   |    11 +-
 drivers/net/dsa/microchip/ksz_dcb.c                |   231 +-
 drivers/net/dsa/mt7530.c                           |   310 +-
 drivers/net/dsa/mt7530.h                           |     8 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |    44 +-
 drivers/net/dsa/mv88e6xxx/pcs-6185.c               |     1 -
 drivers/net/dsa/mv88e6xxx/pcs-6352.c               |     1 -
 drivers/net/dsa/mv88e6xxx/pcs-639x.c               |     4 -
 drivers/net/dsa/qca/qca8k-8xxx.c                   |     1 -
 drivers/net/dsa/rzn1_a5psw.c                       |     8 +-
 drivers/net/dsa/sja1105/sja1105_ethtool.c          |     9 +-
 drivers/net/dsa/sja1105/sja1105_mdio.c             |     6 +-
 drivers/net/dsa/sja1105/sja1105_ptp.c              |    20 +-
 drivers/net/dsa/sja1105/sja1105_static_config.c    |     6 +-
 drivers/net/dummy.c                                |     1 +
 drivers/net/ethernet/Kconfig                       |     1 +
 drivers/net/ethernet/Makefile                      |     1 +
 drivers/net/ethernet/actions/owl-emac.c            |     7 +-
 drivers/net/ethernet/adi/adin1110.c                |     2 +-
 drivers/net/ethernet/airoha/Kconfig                |    27 +
 drivers/net/ethernet/airoha/Makefile               |     9 +
 .../net/ethernet/{mediatek => airoha}/airoha_eth.c |  1372 +-
 drivers/net/ethernet/airoha/airoha_eth.h           |   552 +
 drivers/net/ethernet/airoha/airoha_npu.c           |   520 +
 drivers/net/ethernet/airoha/airoha_npu.h           |    34 +
 drivers/net/ethernet/airoha/airoha_ppe.c           |   910 +
 drivers/net/ethernet/airoha/airoha_ppe_debugfs.c   |   181 +
 drivers/net/ethernet/airoha/airoha_regs.h          |   803 +
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |    47 +-
 drivers/net/ethernet/amd/au1000_eth.c              |     2 +-
 drivers/net/ethernet/apm/xgene-v2/main.c           |     4 +-
 drivers/net/ethernet/apm/xgene-v2/mdio.c           |    16 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.c  |    10 +-
 .../net/ethernet/aquantia/atlantic/aq_drvinfo.c    |    14 +-
 .../aquantia/atlantic/hw_atl/hw_atl_utils.h        |     1 -
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   730 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |    15 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c |     9 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c  |   112 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.h  |     2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |    85 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h      |   143 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c    |     6 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c      |    16 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c      |    18 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c      |     7 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |  1085 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.h     |    52 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c |    89 +-
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |     6 +-
 drivers/net/ethernet/brocade/bna/bnad.c            |     1 +
 drivers/net/ethernet/cadence/macb.h                |   132 +-
 drivers/net/ethernet/cadence/macb_main.c           |   231 +-
 .../ethernet/cavium/liquidio/cn23xx_pf_device.c    |    76 +-
 .../net/ethernet/cavium/liquidio/octeon_device.c   |    16 -
 .../net/ethernet/cavium/liquidio/octeon_device.h   |     7 -
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h         |     7 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |    21 -
 .../chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c    |    16 -
 drivers/net/ethernet/cisco/enic/Kconfig            |     1 +
 drivers/net/ethernet/cisco/enic/Makefile           |     2 +-
 drivers/net/ethernet/cisco/enic/cq_desc.h          |    25 +-
 drivers/net/ethernet/cisco/enic/cq_enet_desc.h     |   142 +-
 drivers/net/ethernet/cisco/enic/enic.h             |    17 +-
 drivers/net/ethernet/cisco/enic/enic_ethtool.c     |    51 +-
 drivers/net/ethernet/cisco/enic/enic_main.c        |   343 +-
 drivers/net/ethernet/cisco/enic/enic_res.c         |    87 +-
 drivers/net/ethernet/cisco/enic/enic_res.h         |    11 +-
 drivers/net/ethernet/cisco/enic/enic_rq.c          |   436 +
 drivers/net/ethernet/cisco/enic/enic_rq.h          |     8 +
 drivers/net/ethernet/cisco/enic/enic_wq.c          |   117 +
 drivers/net/ethernet/cisco/enic/enic_wq.h          |     7 +
 drivers/net/ethernet/cisco/enic/vnic_cq.h          |    45 +-
 drivers/net/ethernet/cisco/enic/vnic_devcmd.h      |    19 +
 drivers/net/ethernet/cisco/enic/vnic_enet.h        |     5 +
 drivers/net/ethernet/cisco/enic/vnic_rq.h          |     4 +-
 drivers/net/ethernet/cisco/enic/vnic_wq.h          |     2 +-
 drivers/net/ethernet/cortina/gemini.c              |     1 +
 drivers/net/ethernet/dec/tulip/tulip_core.c        |     7 +-
 drivers/net/ethernet/engleder/tsnep_main.c         |    25 +-
 drivers/net/ethernet/freescale/fec_main.c          |    52 +-
 drivers/net/ethernet/freescale/fec_ptp.c           |     1 -
 drivers/net/ethernet/freescale/fman/fman_dtsec.c   |     1 -
 drivers/net/ethernet/freescale/gianfar.c           |    14 +-
 drivers/net/ethernet/freescale/ucc_geth.c          |     2 +-
 drivers/net/ethernet/freescale/ucc_geth.h          |     2 -
 drivers/net/ethernet/google/gve/gve.h              |    94 +-
 drivers/net/ethernet/google/gve/gve_adminq.c       |    70 +-
 .../net/ethernet/google/gve/gve_buffer_mgmt_dqo.c  |    45 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c      |    90 +-
 drivers/net/ethernet/google/gve/gve_main.c         |   384 +-
 drivers/net/ethernet/google/gve/gve_rx.c           |    30 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c       |   110 +-
 drivers/net/ethernet/google/gve/gve_tx.c           |    41 +-
 drivers/net/ethernet/google/gve/gve_tx_dqo.c       |    31 +-
 drivers/net/ethernet/google/gve/gve_utils.c        |     6 +-
 drivers/net/ethernet/hisilicon/hibmcge/Makefile    |     2 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_common.h    |   122 +
 .../net/ethernet/hisilicon/hibmcge/hbg_debugfs.c   |     7 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_diagnose.c  |   348 +
 .../net/ethernet/hisilicon/hibmcge/hbg_diagnose.h  |    11 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c   |    58 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.h   |     1 +
 .../net/ethernet/hisilicon/hibmcge/hbg_ethtool.c   |   298 +
 .../net/ethernet/hisilicon/hibmcge/hbg_ethtool.h   |     5 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c    |    10 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c   |    55 +-
 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c  |   103 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c  |    22 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.h  |     2 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h   |   105 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c  |   181 +-
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   |     4 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |    24 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |     3 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c |    63 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |    14 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c    |     2 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c |     3 +-
 drivers/net/ethernet/hisilicon/hns_mdio.c          |     2 +-
 drivers/net/ethernet/ibm/emac/core.c               |     7 +-
 drivers/net/ethernet/ibm/ibmvnic.c                 |    30 +-
 drivers/net/ethernet/intel/Kconfig                 |     3 +-
 drivers/net/ethernet/intel/e1000e/mac.c            |    15 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c         |     4 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.h         |    10 +-
 drivers/net/ethernet/intel/iavf/Makefile           |     2 +
 drivers/net/ethernet/intel/iavf/iavf.h             |    35 +-
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |     2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |   245 +-
 drivers/net/ethernet/intel/iavf/iavf_ptp.c         |   485 +
 drivers/net/ethernet/intel/iavf/iavf_ptp.h         |    47 +
 drivers/net/ethernet/intel/iavf/iavf_trace.h       |     6 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c        |   437 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.h        |    24 +-
 drivers/net/ethernet/intel/iavf/iavf_type.h        |   235 +-
 drivers/net/ethernet/intel/iavf/iavf_types.h       |    34 +
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c    |   203 +
 drivers/net/ethernet/intel/ice/devlink/devlink.c   |   102 +
 drivers/net/ethernet/intel/ice/devlink/health.c    |     6 +-
 drivers/net/ethernet/intel/ice/ice.h               |    30 +-
 drivers/net/ethernet/intel/ice/ice_arfs.c          |    33 +-
 drivers/net/ethernet/intel/ice/ice_arfs.h          |     2 -
 drivers/net/ethernet/intel/ice/ice_base.c          |    20 +-
 drivers/net/ethernet/intel/ice/ice_common.c        |   211 +-
 drivers/net/ethernet/intel/ice/ice_common.h        |     7 +-
 drivers/net/ethernet/intel/ice/ice_ddp.c           |     4 +-
 drivers/net/ethernet/intel/ice/ice_dpll.c          |    14 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |    11 +-
 drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c  |    21 +-
 drivers/net/ethernet/intel/ice/ice_gnss.c          |    31 +-
 drivers/net/ethernet/intel/ice/ice_gnss.h          |     4 +-
 drivers/net/ethernet/intel/ice/ice_hw_autogen.h    |    12 +
 drivers/net/ethernet/intel/ice/ice_idc.c           |    64 +-
 drivers/net/ethernet/intel/ice/ice_irq.c           |   275 +-
 drivers/net/ethernet/intel/ice/ice_irq.h           |    13 +-
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h     |     9 +-
 drivers/net/ethernet/intel/ice/ice_lib.c           |    66 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |    96 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c           |   517 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h           |    17 +-
 drivers/net/ethernet/intel/ice/ice_ptp_consts.h    |    75 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c        |   430 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h        |    63 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c         |   154 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c          |    27 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h          |     2 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c      |    26 +
 drivers/net/ethernet/intel/ice/ice_type.h          |     9 -
 drivers/net/ethernet/intel/ice/ice_vf_lib.h        |     3 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c      |   119 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.h      |     6 +
 .../ethernet/intel/ice/ice_virtchnl_allowlist.c    |     7 +
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c |    24 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c           |     4 +-
 drivers/net/ethernet/intel/ice/ice_xsk.h           |     8 -
 drivers/net/ethernet/intel/idpf/idpf_lib.c         |    32 +-
 .../net/ethernet/intel/idpf/idpf_singleq_txrx.c    |    51 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c        |    38 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h        |    25 +-
 drivers/net/ethernet/intel/igb/igb_ptp.c           |     6 +
 drivers/net/ethernet/intel/igc/igc.h               |     1 +
 drivers/net/ethernet/intel/igc/igc_main.c          |   146 +-
 drivers/net/ethernet/intel/igc/igc_xdp.c           |    19 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |     1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c     |    21 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |     4 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c       |    13 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h |     3 +
 drivers/net/ethernet/intel/ixgbevf/ipsec.c         |    21 -
 drivers/net/ethernet/marvell/mvneta.c              |     6 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |    10 +-
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c    |    14 +-
 .../net/ethernet/marvell/octeontx2/af/mcs_rvu_if.c |     1 -
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h    |     2 +
 .../net/ethernet/marvell/octeontx2/nic/Makefile    |     2 +-
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c |     7 +-
 .../ethernet/marvell/octeontx2/nic/cn10k_ipsec.c   |    15 -
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |   122 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |    17 +-
 .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c  |     6 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |    34 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |   201 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.h |     9 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c   |    14 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_xsk.c  |   225 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_xsk.h  |    24 +
 .../net/ethernet/marvell/octeontx2/nic/qos_sq.c    |     2 +-
 .../net/ethernet/marvell/prestera/prestera_main.c  |     3 +-
 drivers/net/ethernet/mediatek/Kconfig              |     8 -
 drivers/net/ethernet/mediatek/Makefile             |     1 -
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |    81 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.h        |    11 +
 drivers/net/ethernet/mediatek/mtk_ppe_offload.c    |    22 +-
 drivers/net/ethernet/mediatek/mtk_star_emac.c      |     7 +-
 drivers/net/ethernet/mellanox/mlx4/alloc.c         |    28 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c         |   119 +-
 drivers/net/ethernet/mellanox/mlx4/en_tx.c         |    17 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4.h          |     6 -
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h       |    15 +-
 drivers/net/ethernet/mellanox/mlx4/port.c          |    20 -
 drivers/net/ethernet/mellanox/mlx5/core/Kconfig    |     5 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |   120 +-
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c  |     3 +-
 .../mellanox/mlx5/core/diag/reporter_vnic.c        |    46 +
 drivers/net/ethernet/mellanox/mlx5/core/dpll.c     |     2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |    14 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/fs.h    |     4 +-
 .../net/ethernet/mellanox/mlx5/core/en/params.c    |    16 +-
 .../net/ethernet/mellanox/mlx5/core/en/params.h    |     1 -
 drivers/net/ethernet/mellanox/mlx5/core/en/port.c  |    73 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/port.h  |     1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c   |     4 +-
 .../ethernet/mellanox/mlx5/core/en/reporter_rx.c   |   121 +-
 .../ethernet/mellanox/mlx5/core/en/reporter_tx.c   |     1 -
 drivers/net/ethernet/mellanox/mlx5/core/en/rss.c   |    28 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/rss.h   |     7 +-
 .../net/ethernet/mellanox/mlx5/core/en/rx_res.c    |    20 +-
 .../net/ethernet/mellanox/mlx5/core/en/rx_res.h    |    10 +-
 .../ethernet/mellanox/mlx5/core/en/tc/act/act.h    |     5 -
 .../net/ethernet/mellanox/mlx5/core/en/tc/act/ct.c |    11 +
 .../net/ethernet/mellanox/mlx5/core/en/tc/meter.c  |     5 +
 .../net/ethernet/mellanox/mlx5/core/en/tc/meter.h  |    13 +
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c |    29 +
 .../net/ethernet/mellanox/mlx5/core/en/tc_tun.c    |     9 +-
 .../ethernet/mellanox/mlx5/core/en/tc_tun_encap.c  |     9 +-
 .../ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c  |     2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/tir.c   |     2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/tir.h   |     1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/trap.c  |     2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h  |    17 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   |    60 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h   |     6 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/rx.c    |     6 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/setup.c |     2 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |    97 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.h   |    40 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c         |   741 +-
 .../mellanox/mlx5/core/en_accel/ipsec_stats.c      |     1 +
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |   150 +-
 .../ethernet/mellanox/mlx5/core/en_fs_ethtool.c    |     2 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |    56 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |     7 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |    22 +-
 .../net/ethernet/mellanox/mlx5/core/en_selftest.c  |     3 +
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |   133 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h |     8 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |     7 +-
 .../ethernet/mellanox/mlx5/core/esw/acl/helper.c   |     2 +-
 .../net/ethernet/mellanox/mlx5/core/esw/bridge.c   |     6 +-
 .../ethernet/mellanox/mlx5/core/esw/devlink_port.c |     4 +-
 .../net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c |    15 +-
 .../net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h |     5 +
 .../net/ethernet/mellanox/mlx5/core/esw/legacy.c   |     2 +-
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c  |   146 +-
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h  |    12 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |    36 +-
 drivers/net/ethernet/mellanox/mlx5/core/events.c   |    36 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c   |     2 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |   178 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h  |    20 +-
 .../net/ethernet/mellanox/mlx5/core/fs_ft_pool.c   |     6 +-
 .../net/ethernet/mellanox/mlx5/core/fs_ft_pool.h   |     2 -
 drivers/net/ethernet/mellanox/mlx5/core/fw.c       |     7 +
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c |    15 +-
 drivers/net/ethernet/mellanox/mlx5/core/health.c   |    15 +-
 drivers/net/ethernet/mellanox/mlx5/core/hwmon.c    |     5 +
 drivers/net/ethernet/mellanox/mlx5/core/hwmon.h    |     1 +
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |    45 +-
 .../net/ethernet/mellanox/mlx5/core/lag/mpesw.c    |     4 -
 .../net/ethernet/mellanox/mlx5/core/lag/port_sel.c |     2 +-
 .../net/ethernet/mellanox/mlx5/core/lib/clock.c    |   586 +-
 .../net/ethernet/mellanox/mlx5/core/lib/clock.h    |    39 +-
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.h   |     1 +
 .../ethernet/mellanox/mlx5/core/lib/fs_chains.c    |     5 +-
 .../net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c   |    19 +
 .../net/ethernet/mellanox/mlx5/core/lib/fs_ttc.h   |     1 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |    31 +-
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |    94 +
 drivers/net/ethernet/mellanox/mlx5/core/port.c     |   165 +-
 .../net/ethernet/mellanox/mlx5/core/sf/devlink.c   |     2 +-
 .../ethernet/mellanox/mlx5/core/steering/hws/bwc.c |     2 +-
 .../ethernet/mellanox/mlx5/core/steering/hws/cmd.c |     6 -
 .../ethernet/mellanox/mlx5/core/steering/hws/cmd.h |     3 -
 .../mellanox/mlx5/core/steering/hws/definer.c      |     6 +-
 .../mellanox/mlx5/core/steering/hws/fs_hws.c       |   231 +-
 .../mellanox/mlx5/core/steering/hws/fs_hws.h       |    24 +
 .../mellanox/mlx5/core/steering/hws/fs_hws_pools.c |    41 +-
 .../mellanox/mlx5/core/steering/hws/pat_arg.c      |     3 +-
 .../mellanox/mlx5/core/steering/sws/dr_domain.c    |    24 -
 .../mellanox/mlx5/core/steering/sws/dr_send.c      |    33 -
 .../mellanox/mlx5/core/steering/sws/dr_types.h     |     1 -
 .../mellanox/mlx5/core/steering/sws/mlx5dr.h       |     2 -
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    |    25 +
 drivers/net/ethernet/mellanox/mlxsw/pci.c          |     2 +
 drivers/net/ethernet/mellanox/mlxsw/pci_hw.h       |     5 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |    30 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h     |     7 +-
 .../mellanox/mlxsw/spectrum_acl_bloom_filter.c     |    27 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c  |    48 -
 .../net/ethernet/mellanox/mlxsw/spectrum_router.h  |     1 -
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   |    66 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_trap.c    |    12 +-
 drivers/net/ethernet/mellanox/mlxsw/trap.h         |     5 +-
 drivers/net/ethernet/meta/fbnic/Makefile           |     3 +-
 drivers/net/ethernet/meta/fbnic/fbnic.h            |     9 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.c        |     1 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h        |    84 +-
 drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c    |   174 +
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c    |   882 +-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c         |   101 +-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h         |     8 +-
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c     |    50 +-
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h     |     9 +
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c    |     1 -
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c        |   356 +-
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.h        |    35 +
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.c        |    55 +-
 drivers/net/ethernet/meta/fbnic/fbnic_tlv.h        |    39 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c       |   269 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h       |    33 +-
 drivers/net/ethernet/micrel/ks8851_spi.c           |     2 -
 drivers/net/ethernet/microchip/lan743x_ptp.c       |     6 +
 .../net/ethernet/microchip/lan966x/lan966x_main.c  |     1 -
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |     1 -
 drivers/net/ethernet/microsoft/mana/gdma_main.c    |    50 +-
 drivers/net/ethernet/microsoft/mana/hw_channel.c   |     6 +-
 drivers/net/ethernet/microsoft/mana/mana_bpf.c     |     2 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |    68 +-
 drivers/net/ethernet/netronome/nfp/crypto/ipsec.c  |    11 -
 drivers/net/ethernet/netronome/nfp/nfp_hwmon.c     |    40 +-
 drivers/net/ethernet/qlogic/qed/qed_main.c         |     2 +-
 drivers/net/ethernet/qlogic/qed/qed_sriov.c        |     8 +-
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c |     9 +-
 drivers/net/ethernet/realtek/Kconfig               |     3 +-
 drivers/net/ethernet/realtek/r8169_main.c          |    82 +-
 drivers/net/ethernet/renesas/ravb_ptp.c            |     3 +-
 drivers/net/ethernet/renesas/rcar_gen4_ptp.c       |     2 +-
 drivers/net/ethernet/renesas/rswitch.c             |     7 +-
 drivers/net/ethernet/rocker/rocker_main.c          |     2 +-
 drivers/net/ethernet/sfc/Kconfig                   |     5 +-
 drivers/net/ethernet/sfc/Makefile                  |     2 +-
 drivers/net/ethernet/sfc/ef10.c                    |     8 +-
 drivers/net/ethernet/sfc/ef100_netdev.c            |     1 -
 drivers/net/ethernet/sfc/efx.c                     |    24 -
 drivers/net/ethernet/sfc/efx_common.c              |     1 +
 drivers/net/ethernet/sfc/efx_devlink.c             |    13 +
 drivers/net/ethernet/sfc/efx_reflash.c             |   522 +
 drivers/net/ethernet/sfc/efx_reflash.h             |    20 +
 drivers/net/ethernet/sfc/fw_formats.h              |   114 +
 drivers/net/ethernet/sfc/mae.c                     |     2 +-
 drivers/net/ethernet/sfc/mcdi.c                    |   115 +-
 drivers/net/ethernet/sfc/mcdi.h                    |    22 +-
 drivers/net/ethernet/sfc/mcdi_pcol.h               | 13822 ++++-------
 drivers/net/ethernet/sfc/mcdi_port.c               |    59 +-
 drivers/net/ethernet/sfc/mcdi_port_common.c        |    11 -
 drivers/net/ethernet/sfc/net_driver.h              |    11 +-
 drivers/net/ethernet/sfc/tc.c                      |     6 +-
 drivers/net/ethernet/smsc/smsc911x.c               |     1 -
 drivers/net/ethernet/socionext/netsec.c            |     7 +-
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |    12 +
 drivers/net/ethernet/stmicro/stmmac/Makefile       |     1 +
 drivers/net/ethernet/stmicro/stmmac/common.h       |    18 +-
 .../net/ethernet/stmicro/stmmac/dwmac-anarion.c    |    21 +-
 .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    |   174 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c    |    29 +-
 .../net/ethernet/stmicro/stmmac/dwmac-intel-plat.c |    24 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  |   233 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h  |    29 +
 .../net/ethernet/stmicro/stmmac/dwmac-ipq806x.c    |    27 +-
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |    33 +-
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   |     8 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c  |     9 +-
 .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    |     6 +-
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    |    33 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     |   564 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c    |    22 +-
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |    20 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c |    75 +
 .../net/ethernet/stmicro/stmmac/dwmac-starfive.c   |    27 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c    |    20 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c  |     1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |     8 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c  |     8 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c  |    46 +-
 .../net/ethernet/stmicro/stmmac/dwmac-visconti.c   |     2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac1000.h    |    13 +-
 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   |    35 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h       |    12 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |    98 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |     9 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |    49 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |    21 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |    16 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   338 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  |     3 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c   |    24 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |    22 +-
 .../net/ethernet/stmicro/stmmac/stmmac_selftests.c |     8 +-
 drivers/net/ethernet/tehuti/tn40.c                 |     9 +-
 drivers/net/ethernet/tehuti/tn40.h                 |    33 +
 drivers/net/ethernet/tehuti/tn40_mdio.c            |    84 +-
 drivers/net/ethernet/ti/Kconfig                    |     1 +
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |   211 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.h           |     8 +
 drivers/net/ethernet/ti/cpsw.c                     |     6 +-
 drivers/net/ethernet/ti/cpsw_new.c                 |     9 +-
 drivers/net/ethernet/ti/icssg/icss_iep.c           |    63 +-
 drivers/net/ethernet/ti/icssg/icssg_common.c       |   421 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c       |   131 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h       |    47 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c   |    58 +-
 drivers/net/ethernet/wangxun/Kconfig               |     3 +
 drivers/net/ethernet/wangxun/libwx/Makefile        |     2 +-
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.c    |   105 +-
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.h    |     4 +
 drivers/net/ethernet/wangxun/libwx/wx_hw.c         |   236 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.h         |     1 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        |   142 +-
 drivers/net/ethernet/wangxun/libwx/wx_ptp.c        |   883 +
 drivers/net/ethernet/wangxun/libwx/wx_ptp.h        |    20 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h       |   135 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c   |     2 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c      |    20 +-
 drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c      |    11 +
 drivers/net/ethernet/wangxun/ngbe/ngbe_type.h      |     5 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_ethtool.c |     2 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_hw.c      |     6 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c     |     7 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c    |    56 +-
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c     |    16 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_type.h    |    14 +
 drivers/net/ethernet/xilinx/Kconfig                |     1 +
 drivers/net/ethernet/xilinx/xilinx_axienet.h       |    29 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |   319 +-
 drivers/net/geneve.c                               |    62 +-
 drivers/net/gtp.c                                  |    10 +-
 drivers/net/hamradio/baycom_par.c                  |     4 +-
 drivers/net/hamradio/baycom_ser_fdx.c              |     2 +-
 drivers/net/hamradio/baycom_ser_hdx.c              |     4 +-
 drivers/net/hamradio/bpqether.c                    |    25 +-
 drivers/net/hyperv/hyperv_net.h                    |     2 +
 drivers/net/hyperv/netvsc_drv.c                    |    16 +
 drivers/net/hyperv/rndis_filter.c                  |    13 +-
 drivers/net/ieee802154/ca8210.c                    |    78 +-
 drivers/net/ipvlan/ipvlan.h                        |     3 +-
 drivers/net/ipvlan/ipvlan_l3s.c                    |     1 -
 drivers/net/ipvlan/ipvlan_main.c                   |     9 +-
 drivers/net/ipvlan/ipvtap.c                        |     6 +-
 drivers/net/loopback.c                             |     3 +-
 drivers/net/macsec.c                               |    10 +-
 drivers/net/macvlan.c                              |    22 +-
 drivers/net/macvtap.c                              |     6 +-
 drivers/net/mctp/Kconfig                           |    10 +
 drivers/net/mctp/Makefile                          |     1 +
 drivers/net/mctp/mctp-i2c.c                        |     2 +-
 drivers/net/mctp/mctp-usb.c                        |   385 +
 drivers/net/mdio/mdio-i2c.c                        |    79 +-
 drivers/net/net_failover.c                         |     2 +-
 drivers/net/netconsole.c                           |   393 +-
 drivers/net/netdevsim/bpf.c                        |     3 +-
 drivers/net/netdevsim/ethtool.c                    |     2 -
 drivers/net/netdevsim/ipsec.c                      |    11 -
 drivers/net/netdevsim/netdev.c                     |    78 +-
 drivers/net/netdevsim/netdevsim.h                  |     2 +-
 drivers/net/netkit.c                               |    15 +-
 drivers/net/pcs/pcs-lynx.c                         |     1 -
 drivers/net/pcs/pcs-mtk-lynxi.c                    |     1 -
 drivers/net/pcs/pcs-rzn1-miic.c                    |    22 +-
 drivers/net/pcs/pcs-xpcs.c                         |   105 +-
 drivers/net/pcs/pcs-xpcs.h                         |    26 +-
 drivers/net/pfcp.c                                 |     9 +-
 drivers/net/phy/Kconfig                            |     2 +-
 drivers/net/phy/Makefile                           |     3 +-
 drivers/net/phy/adin1100.c                         |     5 +-
 drivers/net/phy/aquantia/aquantia_firmware.c       |     7 +-
 drivers/net/phy/aquantia/aquantia_hwmon.c          |    32 +-
 drivers/net/phy/aquantia/aquantia_main.c           |   240 +-
 drivers/net/phy/bcm-phy-ptp.c                      |     3 +-
 drivers/net/phy/bcm54140.c                         |     1 +
 drivers/net/phy/broadcom.c                         |     2 +-
 drivers/net/phy/dp83822.c                          |    38 +
 drivers/net/phy/dp83867.c                          |     5 +-
 drivers/net/phy/dp83td510.c                        |   187 +
 drivers/net/phy/dp83tg720.c                        |    78 +
 drivers/net/phy/fixed_phy.c                        |    16 +-
 drivers/net/phy/marvell-88q2xxx.c                  |   282 +-
 drivers/net/phy/marvell.c                          |    98 +-
 drivers/net/phy/marvell10g.c                       |    24 +-
 drivers/net/phy/mdio_bus.c                         |    14 +
 drivers/net/phy/mediatek/mtk-ge-soc.c              |   277 +-
 drivers/net/phy/mediatek/mtk-ge.c                  |    76 +-
 drivers/net/phy/mediatek/mtk-phy-lib.c             |    77 +
 drivers/net/phy/mediatek/mtk.h                     |    15 +
 drivers/net/phy/micrel.c                           |    33 +-
 drivers/net/phy/mscc/mscc_main.c                   |     2 +
 drivers/net/phy/mscc/mscc_ptp.c                    |    14 +-
 drivers/net/phy/mxl-gpy.c                          |    19 +-
 drivers/net/phy/nxp-c45-tja11xx.c                  |    94 +-
 drivers/net/phy/nxp-tja11xx.c                      |    57 +-
 drivers/net/phy/phy-c45.c                          |    55 +-
 drivers/net/phy/phy-caps.h                         |    63 +
 drivers/net/phy/phy-core.c                         |   318 +-
 drivers/net/phy/phy.c                              |   157 +-
 drivers/net/phy/phy_caps.c                         |   359 +
 drivers/net/phy/phy_device.c                       |   416 +-
 drivers/net/phy/phy_led_triggers.c                 |     2 +
 drivers/net/phy/phy_package.c                      |   350 +
 drivers/net/phy/phylib-internal.h                  |    27 +
 drivers/net/phy/phylib.h                           |    34 +
 drivers/net/phy/phylink.c                          |   561 +-
 drivers/net/phy/qcom/qca807x.c                     |    16 +-
 drivers/net/phy/qt2025.rs                          |     2 +-
 drivers/net/phy/realtek/Kconfig                    |     8 +-
 drivers/net/phy/realtek/realtek_hwmon.c            |     7 +-
 drivers/net/phy/realtek/realtek_main.c             |   130 +-
 drivers/net/phy/sfp.c                              |    95 +-
 drivers/net/phy/xilinx_gmii2rgmii.c                |     7 +-
 drivers/net/ppp/ppp_generic.c                      |    14 +-
 drivers/net/ppp/pppoe.c                            |     1 +
 drivers/net/ppp/pptp.c                             |     1 +
 drivers/net/sb1000.c                               |  1179 -
 drivers/net/tap.c                                  |   166 +-
 drivers/net/team/team_core.c                       |     9 +-
 drivers/net/tun.c                                  |   221 +-
 drivers/net/tun_vnet.h                             |   186 +
 drivers/net/usb/asix_devices.c                     |    17 +
 drivers/net/usb/ax88172a.c                         |    12 +-
 drivers/net/usb/cdc_ether.c                        |     7 +
 drivers/net/usb/cdc_mbim.c                         |     4 +-
 drivers/net/usb/qmi_wwan.c                         |     6 +-
 drivers/net/usb/r8152.c                            |     7 +
 drivers/net/usb/r8153_ecm.c                        |     6 +
 drivers/net/veth.c                                 |    11 +-
 drivers/net/virtio_net.c                           |   265 +-
 drivers/net/vmxnet3/vmxnet3_drv.c                  |    10 +-
 drivers/net/vrf.c                                  |    14 +-
 drivers/net/vxlan/vxlan_core.c                     |    68 +-
 drivers/net/wireguard/device.c                     |     7 +-
 drivers/net/wireless/ath/ath10k/core.c             |    13 +-
 drivers/net/wireless/ath/ath11k/Makefile           |     1 +
 drivers/net/wireless/ath/ath11k/ahb.c              |     4 +-
 drivers/net/wireless/ath/ath11k/core.c             |    11 +-
 drivers/net/wireless/ath/ath11k/core.h             |    13 +-
 drivers/net/wireless/ath/ath11k/coredump.c         |    52 +
 drivers/net/wireless/ath/ath11k/coredump.h         |    79 +
 drivers/net/wireless/ath/ath11k/dp.c               |    35 +-
 drivers/net/wireless/ath/ath11k/dp.h               |     6 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c            |   133 +-
 drivers/net/wireless/ath/ath11k/fw.c               |     3 +-
 drivers/net/wireless/ath/ath11k/hif.h              |     7 +
 drivers/net/wireless/ath/ath11k/mac.c              |   145 +-
 drivers/net/wireless/ath/ath11k/mhi.c              |     5 +
 drivers/net/wireless/ath/ath11k/mhi.h              |     1 +
 drivers/net/wireless/ath/ath11k/pci.c              |   195 +-
 drivers/net/wireless/ath/ath11k/qmi.c              |    19 +-
 drivers/net/wireless/ath/ath11k/qmi.h              |    10 +-
 drivers/net/wireless/ath/ath11k/reg.c              |   107 +-
 drivers/net/wireless/ath/ath11k/reg.h              |     3 +-
 drivers/net/wireless/ath/ath11k/testmode.c         |    80 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |    11 +-
 drivers/net/wireless/ath/ath11k/wmi.h              |    11 +-
 drivers/net/wireless/ath/ath12k/Makefile           |     3 +-
 drivers/net/wireless/ath/ath12k/acpi.c             |   202 +-
 drivers/net/wireless/ath/ath12k/acpi.h             |    40 +-
 drivers/net/wireless/ath/ath12k/core.c             |   103 +-
 drivers/net/wireless/ath/ath12k/core.h             |   139 +-
 drivers/net/wireless/ath/ath12k/debug.c            |     6 +-
 drivers/net/wireless/ath/ath12k/debug.h            |    10 +-
 drivers/net/wireless/ath/ath12k/debugfs.c          |  1191 +-
 drivers/net/wireless/ath/ath12k/debugfs.h          |   115 +-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.c    |  1238 +-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.h    |   453 +-
 drivers/net/wireless/ath/ath12k/debugfs_sta.c      |   337 +
 drivers/net/wireless/ath/ath12k/debugfs_sta.h      |    24 +
 drivers/net/wireless/ath/ath12k/dp.c               |     5 +-
 drivers/net/wireless/ath/ath12k/dp.h               |    82 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           |  1425 +-
 drivers/net/wireless/ath/ath12k/dp_mon.h           |    11 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |    66 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h            |     8 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c            |   253 +-
 drivers/net/wireless/ath/ath12k/dp_tx.h            |     4 +-
 drivers/net/wireless/ath/ath12k/hal_desc.h         |     5 +-
 drivers/net/wireless/ath/ath12k/hal_rx.h           |   442 +-
 drivers/net/wireless/ath/ath12k/hal_tx.h           |    10 +-
 drivers/net/wireless/ath/ath12k/hw.c               |     8 +-
 drivers/net/wireless/ath/ath12k/mac.c              |   870 +-
 drivers/net/wireless/ath/ath12k/mac.h              |    10 +-
 drivers/net/wireless/ath/ath12k/pci.c              |    22 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |    23 +-
 drivers/net/wireless/ath/ath12k/reg.h              |     5 +-
 drivers/net/wireless/ath/ath12k/rx_desc.h          |    12 +-
 drivers/net/wireless/ath/ath12k/testmode.c         |   395 +
 drivers/net/wireless/ath/ath12k/testmode.h         |    40 +
 drivers/net/wireless/ath/ath12k/wmi.c              |  1176 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |   290 +-
 drivers/net/wireless/ath/ath12k/wow.c              |     3 +-
 drivers/net/wireless/ath/ath9k/ath9k.h             |     3 +-
 drivers/net/wireless/ath/ath9k/common-spectral.c   |     4 +-
 drivers/net/wireless/ath/ath9k/init.c              |     4 +-
 drivers/net/wireless/ath/ath9k/xmit.c              |     9 -
 drivers/net/wireless/ath/{ath11k => }/testmode_i.h |    54 +-
 drivers/net/wireless/broadcom/b43/main.c           |     2 +-
 drivers/net/wireless/intel/ipw2x00/ipw2200.c       |     2 +-
 drivers/net/wireless/intel/ipw2x00/libipw.h        |     2 -
 drivers/net/wireless/intel/ipw2x00/libipw_rx.c     |    91 -
 drivers/net/wireless/intel/iwlegacy/4965-rs.c      |    18 +-
 drivers/net/wireless/intel/iwlegacy/common.h       |     2 -
 drivers/net/wireless/intel/iwlwifi/Kconfig         |    15 +-
 drivers/net/wireless/intel/iwlwifi/Makefile        |     5 +-
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c     |     1 -
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c     |     1 -
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |    21 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c        |     8 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |    14 +-
 drivers/net/wireless/intel/iwlwifi/dvm/commands.h  |   132 +-
 drivers/net/wireless/intel/iwlwifi/dvm/tt.c        |    11 -
 drivers/net/wireless/intel/iwlwifi/dvm/tt.h        |     1 -
 drivers/net/wireless/intel/iwlwifi/fw/api/alive.h  |     4 +-
 .../net/wireless/intel/iwlwifi/fw/api/commands.h   |     7 +-
 .../net/wireless/intel/iwlwifi/fw/api/context.h    |     6 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h     |     2 +-
 .../net/wireless/intel/iwlwifi/fw/api/datapath.h   |    19 +-
 .../net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h    |     9 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h  |    42 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/dhc.h    |   226 +
 .../net/wireless/intel/iwlwifi/fw/api/location.h   |    66 +-
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h    |    95 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/phy.h    |    22 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h     |    52 +
 drivers/net/wireless/intel/iwlwifi/fw/api/sta.h    |     1 +
 .../net/wireless/intel/iwlwifi/fw/api/time-event.h |    42 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |   108 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h        |     3 -
 drivers/net/wireless/intel/iwlwifi/fw/dhc-utils.h  |    75 +
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c |    56 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h |     4 +
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h    |     2 +
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c       |    13 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h       |     4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |    30 +-
 .../wireless/intel/iwlwifi/iwl-context-info-gen3.h |     8 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c   |    10 +-
 drivers/net/wireless/intel/iwlwifi/iwl-debug.h     |     9 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |    36 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |    34 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c     |    10 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |    11 +-
 drivers/net/wireless/intel/iwlwifi/mld/Makefile    |    16 +
 drivers/net/wireless/intel/iwlwifi/mld/agg.c       |   670 +
 drivers/net/wireless/intel/iwlwifi/mld/agg.h       |   127 +
 drivers/net/wireless/intel/iwlwifi/mld/ap.c        |   344 +
 drivers/net/wireless/intel/iwlwifi/mld/ap.h        |    45 +
 drivers/net/wireless/intel/iwlwifi/mld/coex.c      |    40 +
 drivers/net/wireless/intel/iwlwifi/mld/coex.h      |    15 +
 drivers/net/wireless/intel/iwlwifi/mld/constants.h |    88 +
 drivers/net/wireless/intel/iwlwifi/mld/d3.c        |  1998 ++
 drivers/net/wireless/intel/iwlwifi/mld/d3.h        |    51 +
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c   |  1082 +
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.h   |   244 +
 .../net/wireless/intel/iwlwifi/mld/ftm-initiator.c |   451 +
 .../net/wireless/intel/iwlwifi/mld/ftm-initiator.h |    29 +
 drivers/net/wireless/intel/iwlwifi/mld/fw.c        |   536 +
 drivers/net/wireless/intel/iwlwifi/mld/hcmd.h      |    56 +
 drivers/net/wireless/intel/iwlwifi/mld/iface.c     |   671 +
 drivers/net/wireless/intel/iwlwifi/mld/iface.h     |   233 +
 drivers/net/wireless/intel/iwlwifi/mld/key.c       |   358 +
 drivers/net/wireless/intel/iwlwifi/mld/key.h       |    39 +
 drivers/net/wireless/intel/iwlwifi/mld/led.c       |   100 +
 drivers/net/wireless/intel/iwlwifi/mld/led.h       |    29 +
 drivers/net/wireless/intel/iwlwifi/mld/link.c      |  1213 +
 drivers/net/wireless/intel/iwlwifi/mld/link.h      |   153 +
 .../net/wireless/intel/iwlwifi/mld/low_latency.c   |   339 +
 .../net/wireless/intel/iwlwifi/mld/low_latency.h   |    68 +
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c  |  2670 +++
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.h  |    13 +
 drivers/net/wireless/intel/iwlwifi/mld/mcc.c       |   329 +
 drivers/net/wireless/intel/iwlwifi/mld/mcc.h       |    17 +
 drivers/net/wireless/intel/iwlwifi/mld/mld.c       |   720 +
 drivers/net/wireless/intel/iwlwifi/mld/mld.h       |   582 +
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c       |  1076 +
 drivers/net/wireless/intel/iwlwifi/mld/mlo.h       |   167 +
 drivers/net/wireless/intel/iwlwifi/mld/notif.c     |   759 +
 drivers/net/wireless/intel/iwlwifi/mld/notif.h     |    35 +
 drivers/net/wireless/intel/iwlwifi/mld/phy.c       |   155 +
 drivers/net/wireless/intel/iwlwifi/mld/phy.h       |    55 +
 drivers/net/wireless/intel/iwlwifi/mld/power.c     |   396 +
 drivers/net/wireless/intel/iwlwifi/mld/power.h     |    33 +
 drivers/net/wireless/intel/iwlwifi/mld/ptp.c       |   321 +
 drivers/net/wireless/intel/iwlwifi/mld/ptp.h       |    45 +
 .../net/wireless/intel/iwlwifi/mld/regulatory.c    |   393 +
 .../net/wireless/intel/iwlwifi/mld/regulatory.h    |    23 +
 drivers/net/wireless/intel/iwlwifi/mld/roc.c       |   224 +
 drivers/net/wireless/intel/iwlwifi/mld/roc.h       |    20 +
 drivers/net/wireless/intel/iwlwifi/mld/rx.c        |  2060 ++
 drivers/net/wireless/intel/iwlwifi/mld/rx.h        |    72 +
 drivers/net/wireless/intel/iwlwifi/mld/scan.c      |  2008 ++
 drivers/net/wireless/intel/iwlwifi/mld/scan.h      |   136 +
 .../wireless/intel/iwlwifi/mld/session-protect.c   |   222 +
 .../wireless/intel/iwlwifi/mld/session-protect.h   |   102 +
 drivers/net/wireless/intel/iwlwifi/mld/sta.c       |  1289 +
 drivers/net/wireless/intel/iwlwifi/mld/sta.h       |   266 +
 drivers/net/wireless/intel/iwlwifi/mld/stats.c     |   513 +
 drivers/net/wireless/intel/iwlwifi/mld/stats.h     |    22 +
 .../net/wireless/intel/iwlwifi/mld/tests/Makefile  |     5 +
 drivers/net/wireless/intel/iwlwifi/mld/tests/agg.c |   663 +
 .../net/wireless/intel/iwlwifi/mld/tests/hcmd.c    |    62 +
 .../intel/iwlwifi/mld/tests/link-selection.c       |   303 +
 .../net/wireless/intel/iwlwifi/mld/tests/link.c    |   110 +
 .../net/wireless/intel/iwlwifi/mld/tests/module.c  |    11 +
 drivers/net/wireless/intel/iwlwifi/mld/tests/rx.c  |   353 +
 .../net/wireless/intel/iwlwifi/mld/tests/utils.c   |   474 +
 .../net/wireless/intel/iwlwifi/mld/tests/utils.h   |   134 +
 drivers/net/wireless/intel/iwlwifi/mld/thermal.c   |   438 +
 drivers/net/wireless/intel/iwlwifi/mld/thermal.h   |    36 +
 drivers/net/wireless/intel/iwlwifi/mld/time_sync.c |   240 +
 drivers/net/wireless/intel/iwlwifi/mld/time_sync.h |    26 +
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c       |   700 +
 drivers/net/wireless/intel/iwlwifi/mld/tlc.h       |    23 +
 drivers/net/wireless/intel/iwlwifi/mld/tx.c        |  1374 ++
 drivers/net/wireless/intel/iwlwifi/mld/tx.h        |    77 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |     2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |    38 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |   123 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-responder.c |    86 -
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |    54 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |    23 -
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |    24 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |     3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |     2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |    19 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |     6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c        |     2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |    61 -
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h       |     4 -
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |     6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c        |     4 +-
 .../wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c   |     5 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   261 +-
 .../net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |     4 +-
 drivers/net/wireless/intel/iwlwifi/tests/devinfo.c |    15 +-
 drivers/net/wireless/marvell/libertas/cmd.c        |   143 +-
 drivers/net/wireless/marvell/libertas/cmd.h        |    10 -
 drivers/net/wireless/marvell/libertas/cmdresp.c    |     1 -
 drivers/net/wireless/marvell/libertas/decl.h       |     4 -
 drivers/net/wireless/marvell/libertas/dev.h        |     4 -
 drivers/net/wireless/marvell/libertas/main.c       |    88 +-
 drivers/net/wireless/marvell/mwifiex/11n.c         |     6 +-
 drivers/net/wireless/marvell/mwifiex/cfp.c         |     2 +-
 drivers/net/wireless/marvell/mwifiex/fw.h          |    14 +
 drivers/net/wireless/marvell/mwifiex/main.c        |     8 +-
 drivers/net/wireless/marvell/mwifiex/main.h        |     4 +-
 drivers/net/wireless/marvell/mwifiex/pcie.c        |     4 +-
 drivers/net/wireless/marvell/mwifiex/sdio.c        |     4 +-
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c     |    18 +-
 drivers/net/wireless/marvell/mwifiex/uap_event.c   |    16 -
 drivers/net/wireless/marvell/mwifiex/usb.c         |     4 +-
 drivers/net/wireless/mediatek/mt76/channel.c       |     3 +
 drivers/net/wireless/mediatek/mt76/eeprom.c        |     4 +
 drivers/net/wireless/mediatek/mt76/mac80211.c      |    16 +-
 drivers/net/wireless/mediatek/mt76/mt76.h          |     8 +
 .../net/wireless/mediatek/mt76/mt76_connac3_mac.h  |     3 +
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |     6 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c    |     3 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c    |     3 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci.c    |     3 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c    |     4 +-
 .../net/wireless/mediatek/mt76/mt7915/debugfs.c    |    53 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |     4 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h    |    12 -
 drivers/net/wireless/mediatek/mt76/mt7921/main.c   |     1 +
 drivers/net/wireless/mediatek/mt76/mt7925/init.c   |    96 +
 drivers/net/wireless/mediatek/mt76/mt7925/main.c   |   164 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c    |   274 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h    |     6 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h |    36 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h        |    19 +-
 .../net/wireless/mediatek/mt76/mt792x_acpi_sar.c   |   123 +-
 .../net/wireless/mediatek/mt76/mt792x_acpi_sar.h   |    18 +-
 drivers/net/wireless/mediatek/mt76/mt792x_core.c   |     3 +-
 .../net/wireless/mediatek/mt76/mt7996/debugfs.c    |    56 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |   306 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |   984 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |   638 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h    |    47 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   |     5 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |    79 +-
 drivers/net/wireless/mediatek/mt76/scan.c          |    21 +-
 drivers/net/wireless/mediatek/mt76/tx.c            |     3 +-
 drivers/net/wireless/quantenna/qtnfmac/qlink.h     |    21 +-
 drivers/net/wireless/realtek/rtl8xxxu/8192c.c      |     2 +
 drivers/net/wireless/realtek/rtl8xxxu/core.c       |    17 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/phy.c   |     6 +-
 drivers/net/wireless/realtek/rtw88/Kconfig         |    25 +
 drivers/net/wireless/realtek/rtw88/Makefile        |     9 +
 drivers/net/wireless/realtek/rtw88/debug.c         |    59 +-
 drivers/net/wireless/realtek/rtw88/fw.c            |    15 +
 drivers/net/wireless/realtek/rtw88/fw.h            |     1 +
 drivers/net/wireless/realtek/rtw88/mac.c           |     7 +-
 drivers/net/wireless/realtek/rtw88/main.c          |    58 +-
 drivers/net/wireless/realtek/rtw88/main.h          |    45 +-
 drivers/net/wireless/realtek/rtw88/pci.c           |     4 +-
 drivers/net/wireless/realtek/rtw88/phy.c           |   215 +-
 drivers/net/wireless/realtek/rtw88/phy.h           |    20 +-
 drivers/net/wireless/realtek/rtw88/reg.h           |    69 +-
 drivers/net/wireless/realtek/rtw88/rtw8723d.c      |     4 +-
 drivers/net/wireless/realtek/rtw88/rtw8814a.c      |  2257 ++
 drivers/net/wireless/realtek/rtw88/rtw8814a.h      |    62 +
 .../net/wireless/realtek/rtw88/rtw8814a_table.c    | 23930 +++++++++++++++++++
 .../net/wireless/realtek/rtw88/rtw8814a_table.h    |    40 +
 drivers/net/wireless/realtek/rtw88/rtw8814ae.c     |    31 +
 drivers/net/wireless/realtek/rtw88/rtw8814au.c     |    54 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c      |    16 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c      |    16 +-
 drivers/net/wireless/realtek/rtw88/rtw8822bu.c     |     4 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c      |     2 +-
 drivers/net/wireless/realtek/rtw88/rtw88xxa.c      |     2 +-
 drivers/net/wireless/realtek/rtw88/rx.c            |     6 +
 drivers/net/wireless/realtek/rtw88/sar.c           |     2 +-
 drivers/net/wireless/realtek/rtw88/sdio.c          |     2 +-
 drivers/net/wireless/realtek/rtw88/usb.c           |     2 +-
 drivers/net/wireless/realtek/rtw88/util.c          |     3 +-
 drivers/net/wireless/realtek/rtw89/Kconfig         |     2 +-
 drivers/net/wireless/realtek/rtw89/cam.c           |     6 +
 drivers/net/wireless/realtek/rtw89/chan.c          |    38 +-
 drivers/net/wireless/realtek/rtw89/chan.h          |     2 +-
 drivers/net/wireless/realtek/rtw89/coex.c          |  2843 ++-
 drivers/net/wireless/realtek/rtw89/coex.h          |    18 +-
 drivers/net/wireless/realtek/rtw89/core.c          |   240 +-
 drivers/net/wireless/realtek/rtw89/core.h          |   208 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |  2055 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |   369 +-
 drivers/net/wireless/realtek/rtw89/fw.h            |   103 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |    80 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |     5 +
 drivers/net/wireless/realtek/rtw89/mac80211.c      |   284 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |     8 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |    56 +-
 drivers/net/wireless/realtek/rtw89/pci_be.c        |     2 +-
 drivers/net/wireless/realtek/rtw89/phy.c           |   787 +-
 drivers/net/wireless/realtek/rtw89/phy.h           |    22 +-
 drivers/net/wireless/realtek/rtw89/ps.c            |     6 +-
 drivers/net/wireless/realtek/rtw89/reg.h           |    44 +-
 drivers/net/wireless/realtek/rtw89/regd.c          |   601 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |    26 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |    26 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |    26 +-
 .../net/wireless/realtek/rtw89/rtw8852b_common.c   |     6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  |    13 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |    26 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c |    13 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |    28 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |    74 +-
 drivers/net/wireless/realtek/rtw89/sar.c           |   436 +-
 drivers/net/wireless/realtek/rtw89/sar.h           |    10 +-
 drivers/net/wireless/realtek/rtw89/ser.c           |    17 +-
 drivers/net/wireless/realtek/rtw89/util.c          |   234 +-
 drivers/net/wireless/realtek/rtw89/util.h          |    13 +-
 drivers/net/wireless/realtek/rtw89/wow.c           |     7 +-
 drivers/net/wireless/silabs/wfx/bus.h              |     1 +
 drivers/net/wireless/silabs/wfx/bus_sdio.c         |    54 +
 drivers/net/wireless/silabs/wfx/bus_spi.c          |    47 +-
 drivers/net/wireless/silabs/wfx/main.c             |    14 +
 drivers/net/wireless/silabs/wfx/sta.c              |    25 +
 drivers/net/wireless/silabs/wfx/sta.h              |     3 +
 drivers/net/wireless/virtual/mac80211_hwsim.c      |    15 +-
 drivers/net/wireless/virtual/virt_wifi.c           |    10 +-
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c       |     2 +-
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c         |     1 +
 drivers/net/wwan/t7xx/t7xx_pci.c                   |     1 -
 drivers/net/wwan/wwan_core.c                       |    16 +-
 drivers/nvmem/brcm_nvram.c                         |     2 +-
 drivers/nvmem/layouts/u-boot-env.c                 |     2 +-
 drivers/of/base.c                                  |    27 +
 drivers/ptp/ptp_chardev.c                          |    16 +
 drivers/ptp/ptp_ocp.c                              |     7 +-
 drivers/s390/net/Kconfig                           |    11 +-
 drivers/s390/net/Makefile                          |     1 -
 drivers/s390/net/lcs.c                             |  2385 --
 drivers/s390/net/lcs.h                             |   342 -
 fs/eventpoll.c                                     |     8 +-
 include/linux/avf/virtchnl.h                       |   139 +-
 include/linux/cpu_rmap.h                           |     1 +
 include/linux/ethtool.h                            |    13 +-
 include/linux/filter.h                             |     1 +
 include/linux/ieee80211.h                          |    12 +
 include/linux/if_bridge.h                          |     6 +-
 include/linux/if_ether.h                           |     3 +
 include/linux/if_macvlan.h                         |     6 +-
 include/linux/ipv6.h                               |     1 +
 include/linux/mlx4/device.h                        |     3 +-
 include/linux/mlx5/device.h                        |    13 +
 include/linux/mlx5/driver.h                        |    39 +-
 include/linux/mlx5/eswitch.h                       |     2 +
 include/linux/mlx5/fs.h                            |    13 +-
 include/linux/mlx5/mlx5_ifc.h                      |    64 +-
 include/linux/mlx5/port.h                          |    86 +-
 include/linux/net/intel/iidc.h                     |     2 +
 include/linux/netdev_features.h                    |     8 +-
 include/linux/netdevice.h                          |   180 +-
 include/linux/netpoll.h                            |     7 +
 include/linux/of.h                                 |     9 +
 include/linux/pcs/pcs-xpcs.h                       |     3 +-
 include/linux/phy.h                                |   271 +-
 include/linux/phylink.h                            |    49 +-
 include/linux/platform_data/x86/intel_pmc_ipc.h    |    94 +
 include/linux/posix-clock.h                        |     6 +-
 include/linux/ppp_channel.h                        |     3 +-
 include/linux/qed/qed_ll2_if.h                     |     2 +-
 include/linux/rtnetlink.h                          |     1 +
 include/linux/sctp.h                               |     2 -
 include/linux/skbuff.h                             |    50 +-
 include/linux/stmmac.h                             |    15 +-
 include/linux/tcp.h                                |     5 +
 include/linux/unroll.h                             |    44 +
 include/linux/usb/mctp-usb.h                       |    30 +
 include/linux/usb/r8152.h                          |     1 +
 include/net/af_unix.h                              |    81 +-
 include/net/ax25.h                                 |     1 -
 include/net/bluetooth/bluetooth.h                  |     1 +
 include/net/bluetooth/hci.h                        |    34 +
 include/net/bluetooth/hci_core.h                   |    27 +-
 include/net/bluetooth/l2cap.h                      |     7 +-
 include/net/bluetooth/mgmt.h                       |     1 +
 include/net/bonding.h                              |     1 +
 include/net/busy_poll.h                            |    21 +-
 include/net/cfg80211.h                             |    88 +-
 include/net/dropreason-core.h                      |     9 +
 include/net/dropreason.h                           |     6 -
 include/net/dst_metadata.h                         |     7 +-
 include/net/fib_rules.h                            |    27 +-
 include/net/gro.h                                  |    38 +-
 include/net/hotdata.h                              |     1 -
 include/net/inet6_connection_sock.h                |     2 -
 include/net/inet6_hashtables.h                     |     2 +-
 include/net/inet_connection_sock.h                 |    33 +-
 include/net/inet_frag.h                            |     6 +-
 include/net/inet_hashtables.h                      |    11 +-
 include/net/ip.h                                   |    26 +-
 include/net/ip_fib.h                               |     2 +
 include/net/ip_tunnels.h                           |    12 +-
 include/net/ipv6.h                                 |    22 +-
 include/net/ipv6_frag.h                            |     5 +-
 include/net/libeth/rx.h                            |    47 +
 include/net/lwtunnel.h                             |    12 +-
 include/net/mac80211.h                             |    38 +-
 include/net/mctp.h                                 |     2 +-
 include/net/mptcp.h                                |    19 +-
 include/net/net_namespace.h                        |     3 +
 include/net/netdev_lock.h                          |   101 +
 include/net/netdev_netlink.h                       |    12 +
 include/net/netdev_queues.h                        |     5 +
 include/net/netdev_rx_queue.h                      |     3 +-
 include/net/netfilter/nft_fib.h                    |    21 +
 include/net/netlink.h                              |    15 +
 include/net/netmem.h                               |    21 +-
 include/net/netns/ipv4.h                           |     4 +
 include/net/page_pool/memory_provider.h            |    45 +
 include/net/page_pool/types.h                      |     4 +
 include/net/rps.h                                  |     2 +-
 include/net/rtnetlink.h                            |    40 +-
 include/net/sock.h                                 |    35 +-
 include/net/tcp.h                                  |   137 +-
 include/net/xdp.h                                  |     1 -
 include/net/xdp_sock.h                             |    10 +
 include/net/xdp_sock_drv.h                         |    44 +-
 include/net/xfrm.h                                 |    21 +-
 include/net/xsk_buff_pool.h                        |     8 +
 include/trace/events/tcp.h                         |     6 +
 include/uapi/linux/batman_adv.h                    |    18 +-
 include/uapi/linux/bpf.h                           |    30 +
 include/uapi/linux/can.h                           |     3 +-
 include/uapi/linux/errqueue.h                      |     1 +
 include/uapi/linux/ethtool.h                       |    22 +
 include/uapi/linux/fib_rules.h                     |     3 +
 include/uapi/linux/if_cablemodem.h                 |    23 -
 include/uapi/linux/if_link.h                       |     7 +
 include/uapi/linux/if_xdp.h                        |    10 +
 include/uapi/linux/net_tstamp.h                    |     6 +-
 include/uapi/linux/netdev.h                        |    16 +
 include/uapi/linux/nl80211.h                       |    72 +-
 include/uapi/linux/rtnetlink.h                     |     1 +
 include/uapi/linux/snmp.h                          |    13 +-
 include/uapi/linux/tcp.h                           |    12 +-
 include/uapi/linux/usb/ch9.h                       |     1 +
 include/uapi/linux/virtio_net.h                    |    13 +
 io_uring/napi.c                                    |     4 +-
 kernel/bpf/btf.c                                   |     1 +
 kernel/bpf/cpumap.c                                |   150 +-
 kernel/bpf/offload.c                               |    11 +-
 kernel/time/posix-clock.c                          |     3 +-
 lib/Kconfig.debug                                  |    20 +-
 lib/Makefile                                       |     2 +-
 ...{test_blackhole_dev.c => blackhole_dev_kunit.c} |    47 +-
 lib/cpu_rmap.c                                     |     2 +-
 lib/dynamic_queue_limits.c                         |     2 +-
 lib/net_utils.c                                    |     4 +-
 net/8021q/vlan_dev.c                               |    36 +-
 net/8021q/vlan_netlink.c                           |     9 +-
 net/atm/mpc.c                                      |     2 +
 net/ax25/af_ax25.c                                 |    30 +-
 net/ax25/ax25_route.c                              |    74 -
 net/batman-adv/Makefile                            |     2 +-
 net/batman-adv/bat_algo.c                          |     8 +-
 net/batman-adv/bat_iv_ogm.c                        |   105 +-
 net/batman-adv/bat_v.c                             |    28 +-
 net/batman-adv/bat_v_elp.c                         |    16 +-
 net/batman-adv/bat_v_ogm.c                         |    42 +-
 net/batman-adv/bitarray.c                          |     2 +-
 net/batman-adv/bridge_loop_avoidance.c             |   106 +-
 net/batman-adv/distributed-arp-table.c             |    68 +-
 net/batman-adv/distributed-arp-table.h             |     4 +-
 net/batman-adv/fragmentation.c                     |     2 +-
 net/batman-adv/gateway_client.c                    |    38 +-
 net/batman-adv/gateway_common.c                    |     8 +-
 net/batman-adv/hard-interface.c                    |   158 +-
 net/batman-adv/hard-interface.h                    |    12 +-
 net/batman-adv/log.c                               |     2 +-
 net/batman-adv/log.h                               |    10 +-
 net/batman-adv/main.c                              |    42 +-
 net/batman-adv/main.h                              |    24 +-
 .../{soft-interface.c => mesh-interface.c}         |   206 +-
 .../{soft-interface.h => mesh-interface.h}         |    22 +-
 net/batman-adv/multicast.c                         |   182 +-
 net/batman-adv/multicast_forw.c                    |    30 +-
 net/batman-adv/netlink.c                           |   180 +-
 net/batman-adv/netlink.h                           |     2 +-
 net/batman-adv/network-coding.c                    |    64 +-
 net/batman-adv/originator.c                        |    58 +-
 net/batman-adv/routing.c                           |    42 +-
 net/batman-adv/send.c                              |    36 +-
 net/batman-adv/send.h                              |     4 +-
 net/batman-adv/tp_meter.c                          |    30 +-
 net/batman-adv/trace.h                             |     2 +-
 net/batman-adv/translation-table.c                 |   198 +-
 net/batman-adv/translation-table.h                 |     4 +-
 net/batman-adv/tvlv.c                              |    26 +-
 net/batman-adv/types.h                             |    78 +-
 net/bluetooth/6lowpan.c                            |     3 +-
 net/bluetooth/coredump.c                           |    28 +-
 net/bluetooth/hci_conn.c                           |   122 +
 net/bluetooth/hci_core.c                           |    77 +-
 net/bluetooth/hci_event.c                          |    32 +-
 net/bluetooth/hci_sync.c                           |    32 +-
 net/bluetooth/iso.c                                |    24 +-
 net/bluetooth/l2cap_core.c                         |    45 +-
 net/bluetooth/l2cap_sock.c                         |    15 +-
 net/bluetooth/mgmt.c                               |    52 +-
 net/bluetooth/mgmt_util.c                          |    17 -
 net/bluetooth/mgmt_util.h                          |     4 -
 net/bluetooth/sco.c                                |    19 +-
 net/bluetooth/smp.c                                |     4 +-
 net/bridge/br_device.c                             |     4 +-
 net/bridge/br_ioctl.c                              |    36 +-
 net/bridge/br_mdb.c                                |     2 +-
 net/bridge/br_netlink.c                            |     6 +-
 net/bridge/br_private.h                            |     3 +-
 net/caif/chnl_net.c                                |     5 +-
 net/can/af_can.c                                   |     2 +
 net/can/bcm.c                                      |     1 +
 net/can/isotp.c                                    |     1 +
 net/can/raw.c                                      |     7 +-
 net/core/Makefile                                  |     2 +-
 net/core/dev.c                                     |   642 +-
 net/core/dev.h                                     |    32 +-
 net/core/dev_api.c                                 |   335 +
 net/core/dev_ioctl.c                               |    87 +-
 net/core/devmem.c                                  |    94 +-
 net/core/devmem.h                                  |    51 +-
 net/core/dst.c                                     |     6 +-
 net/core/fib_rules.c                               |   223 +-
 net/core/filter.c                                  |   125 +-
 net/core/flow_dissector.c                          |    10 +-
 net/core/gro.c                                     |   103 +-
 net/core/hotdata.c                                 |     1 -
 net/core/lwtunnel.c                                |    23 +-
 net/core/neighbour.c                               |    13 +-
 net/core/net-procfs.c                              |    28 +-
 net/core/net-sysfs.c                               |   418 +-
 net/core/net_namespace.c                           |     2 +
 net/core/netdev-genl-gen.c                         |     4 +-
 net/core/netdev-genl-gen.h                         |     6 +-
 net/core/netdev-genl.c                             |    83 +-
 net/core/netdev_rx_queue.c                         |   112 +-
 net/core/netpoll.c                                 |    67 +-
 net/core/page_pool.c                               |    73 +-
 net/core/page_pool_user.c                          |     9 +-
 net/core/pktgen.c                                  |   344 +-
 net/core/rtnetlink.c                               |   102 +-
 net/core/secure_seq.c                              |     2 +-
 net/core/selftests.c                               |     4 +-
 net/core/skbuff.c                                  |   117 +
 net/core/sock.c                                    |    41 +-
 net/core/xdp.c                                     |    10 -
 net/dccp/ipv4.c                                    |     5 -
 net/dccp/ipv6.c                                    |    13 +-
 net/dccp/output.c                                  |     5 +-
 net/dccp/timer.c                                   |     8 +-
 net/dsa/conduit.c                                  |    17 +-
 net/dsa/user.c                                     |    27 +-
 net/ethtool/cabletest.c                            |    21 +-
 net/ethtool/cmis_fw_update.c                       |     8 +-
 net/ethtool/common.c                               |    45 +
 net/ethtool/common.h                               |     7 -
 net/ethtool/features.c                             |     8 +-
 net/ethtool/ioctl.c                                |    31 +-
 net/ethtool/module.c                               |     9 +-
 net/ethtool/netlink.c                              |    13 +
 net/ethtool/phy.c                                  |    21 +-
 net/ethtool/rss.c                                  |     4 +
 net/ethtool/tsinfo.c                               |    10 +-
 net/hsr/Kconfig                                    |    18 +
 net/hsr/Makefile                                   |     2 +
 net/hsr/hsr_device.c                               |     4 +-
 net/hsr/hsr_forward.c                              |     4 +-
 net/hsr/hsr_framereg.c                             |    99 +-
 net/hsr/hsr_framereg.h                             |     8 +-
 net/hsr/hsr_main.h                                 |     2 +
 net/hsr/hsr_netlink.c                              |    12 +-
 net/hsr/prp_dup_discard_test.c                     |   212 +
 net/ieee802154/6lowpan/core.c                      |    10 +-
 net/ieee802154/6lowpan/reassembly.c                |    27 +-
 net/ieee802154/core.c                              |    10 +-
 net/ipv4/af_inet.c                                 |     2 +-
 net/ipv4/arp.c                                     |    12 +-
 net/ipv4/bpf_tcp_ca.c                              |     2 +-
 net/ipv4/devinet.c                                 |    77 +-
 net/ipv4/fib_frontend.c                            |    78 +-
 net/ipv4/fib_rules.c                               |    59 +-
 net/ipv4/fib_semantics.c                           |   206 +-
 net/ipv4/fib_trie.c                                |    22 -
 net/ipv4/icmp.c                                    |    39 +-
 net/ipv4/igmp.c                                    |    14 +-
 net/ipv4/igmp_internal.h                           |    17 +
 net/ipv4/inet_connection_sock.c                    |    97 +-
 net/ipv4/inet_diag.c                               |     6 +-
 net/ipv4/inet_fragment.c                           |    31 +-
 net/ipv4/inet_hashtables.c                         |   122 +-
 net/ipv4/inet_timewait_sock.c                      |     2 +-
 net/ipv4/inetpeer.c                                |     8 +-
 net/ipv4/ip_fragment.c                             |    48 +-
 net/ipv4/ip_gre.c                                  |    38 +-
 net/ipv4/ip_output.c                               |     3 +-
 net/ipv4/ip_tunnel.c                               |    10 +-
 net/ipv4/ip_vti.c                                  |     9 +-
 net/ipv4/ipip.c                                    |     9 +-
 net/ipv4/ipmr.c                                    |     2 +-
 net/ipv4/netfilter/nft_fib_ipv4.c                  |    11 +-
 net/ipv4/nexthop.c                                 |   184 +-
 net/ipv4/ping.c                                    |    26 +-
 net/ipv4/proc.c                                    |     1 +
 net/ipv4/raw.c                                     |     6 +-
 net/ipv4/syncookies.c                              |     9 +-
 net/ipv4/sysctl_net_ipv4.c                         |    10 +
 net/ipv4/tcp.c                                     |   166 +-
 net/ipv4/tcp_dctcp.c                               |     2 +-
 net/ipv4/tcp_dctcp.h                               |     2 +-
 net/ipv4/tcp_diag.c                                |    21 +-
 net/ipv4/tcp_fastopen.c                            |     8 +-
 net/ipv4/tcp_input.c                               |   191 +-
 net/ipv4/tcp_ipv4.c                                |   114 +-
 net/ipv4/tcp_metrics.c                             |     6 +-
 net/ipv4/tcp_minisocks.c                           |    61 +-
 net/ipv4/tcp_offload.c                             |    12 +-
 net/ipv4/tcp_output.c                              |    69 +-
 net/ipv4/tcp_timer.c                               |    72 +-
 net/ipv4/udp.c                                     |    75 +-
 net/ipv4/udp_offload.c                             |     2 +-
 net/ipv6/exthdrs.c                                 |     3 +-
 net/ipv6/fib6_rules.c                              |    57 +-
 net/ipv6/icmp.c                                    |     7 +-
 net/ipv6/inet6_connection_sock.c                   |    14 -
 net/ipv6/inet6_hashtables.c                        |    40 +-
 net/ipv6/ip6_gre.c                                 |    29 +-
 net/ipv6/ip6_output.c                              |    11 +-
 net/ipv6/ip6_tunnel.c                              |    21 +-
 net/ipv6/ip6_vti.c                                 |    15 +-
 net/ipv6/ip6mr.c                                   |     2 +-
 net/ipv6/ndisc.c                                   |     8 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c            |    27 +-
 net/ipv6/netfilter/nf_socket_ipv6.c                |    23 +
 net/ipv6/netfilter/nft_fib_ipv6.c                  |    19 +-
 net/ipv6/ping.c                                    |     3 -
 net/ipv6/raw.c                                     |    15 +-
 net/ipv6/reassembly.c                              |    29 +-
 net/ipv6/route.c                                   |     6 +-
 net/ipv6/sit.c                                     |    23 +-
 net/ipv6/tcp_ipv6.c                                |    69 +-
 net/ipv6/tcpv6_offload.c                           |     2 +-
 net/ipv6/udp.c                                     |    12 +-
 net/ipv6/udp_offload.c                             |     2 +-
 net/l2tp/l2tp_eth.c                                |     1 +
 net/l2tp/l2tp_ip6.c                                |     8 +-
 net/l2tp/l2tp_ppp.c                                |     1 +
 net/mac80211/agg-rx.c                              |    22 +-
 net/mac80211/agg-tx.c                              |     9 +-
 net/mac80211/cfg.c                                 |    46 +-
 net/mac80211/chan.c                                |    20 +-
 net/mac80211/debugfs.c                             |    44 +-
 net/mac80211/debugfs_sta.c                         |     7 +-
 net/mac80211/driver-ops.h                          |     3 +-
 net/mac80211/drop.h                                |    21 +-
 net/mac80211/ethtool.c                             |     2 +-
 net/mac80211/ieee80211_i.h                         |    43 +-
 net/mac80211/iface.c                               |    76 +-
 net/mac80211/main.c                                |    16 +-
 net/mac80211/mesh_hwmp.c                           |    14 +-
 net/mac80211/mlme.c                                |   720 +-
 net/mac80211/rx.c                                  |   219 +-
 net/mac80211/sta_info.c                            |    64 +-
 net/mac80211/status.c                              |    34 +-
 net/mac80211/tests/Makefile                        |     2 +-
 net/mac80211/tests/chan-mode.c                     |   254 +
 net/mac80211/tests/util.c                          |     6 +-
 net/mac80211/tx.c                                  |     5 +-
 net/mac80211/util.c                                |     3 +-
 net/mac80211/wbrf.c                                |     3 +-
 net/mptcp/Makefile                                 |     2 +-
 net/mptcp/ctrl.c                                   |   145 +-
 net/mptcp/diag.c                                   |    42 +-
 net/mptcp/fastopen.c                               |    27 +-
 net/mptcp/options.c                                |     1 -
 net/mptcp/pm.c                                     |   662 +-
 net/mptcp/pm_kernel.c                              |  1412 ++
 net/mptcp/pm_netlink.c                             |  1933 +-
 net/mptcp/pm_userspace.c                           |   275 +-
 net/mptcp/protocol.c                               |   332 +-
 net/mptcp/protocol.h                               |    99 +-
 net/mptcp/sched.c                                  |    39 +-
 net/mptcp/sockopt.c                                |    28 +
 net/mptcp/subflow.c                                |    36 +-
 net/netfilter/nf_conntrack_standalone.c            |    12 +-
 net/netfilter/nf_log_syslog.c                      |     8 +-
 net/netfilter/nf_tables_core.c                     |    11 +-
 net/netfilter/nfnetlink_queue.c                    |     2 +-
 net/netfilter/xt_hashlimit.c                       |    12 +-
 net/netfilter/xt_repldata.h                        |     2 +-
 net/netlink/af_netlink.c                           |     1 +
 net/nfc/hci/llc.c                                  |    11 -
 net/nfc/hci/llc.h                                  |     1 -
 net/openvswitch/datapath.h                         |    20 +-
 net/openvswitch/vport-internal_dev.c               |     2 +-
 net/openvswitch/vport.h                            |     9 +
 net/packet/af_packet.c                             |     9 +-
 net/rds/stats.c                                    |     3 +-
 net/rfkill/rfkill-gpio.c                           |     3 +
 net/sched/act_tunnel_key.c                         |     8 +-
 net/sched/em_meta.c                                |     2 +-
 net/sched/sch_api.c                                |   216 +-
 net/sched/sch_qfq.c                                |     2 +-
 net/sctp/protocol.c                                |     7 +-
 net/smc/smc_pnet.c                                 |     8 +-
 net/socket.c                                       |    35 +-
 net/tipc/link.c                                    |     3 +-
 net/tls/tls_device.c                               |     8 +-
 net/tls/tls_main.c                                 |     4 +-
 net/unix/af_unix.c                                 |    70 +-
 net/unix/af_unix.h                                 |    72 +
 net/unix/diag.c                                    |    18 +-
 net/unix/garbage.c                                 |    33 +-
 net/unix/sysctl_net_unix.c                         |     6 +-
 net/unix/unix_bpf.c                                |     5 +-
 net/wireless/chan.c                                |    13 +-
 net/wireless/core.c                                |    19 +-
 net/wireless/core.h                                |     7 +-
 net/wireless/mlme.c                                |    17 +-
 net/wireless/nl80211.c                             |    62 +-
 net/wireless/rdev-ops.h                            |    10 +-
 net/wireless/reg.c                                 |     4 +-
 net/wireless/scan.c                                |     8 +-
 net/wireless/trace.h                               |    19 +-
 net/wireless/util.c                                |     4 +-
 net/xdp/xsk.c                                      |     9 +-
 net/xdp/xsk_buff_pool.c                            |    49 +-
 net/xfrm/xfrm_device.c                             |    46 +-
 net/xfrm/xfrm_interface_core.c                     |    15 +-
 net/xfrm/xfrm_output.c                             |     6 +-
 net/xfrm/xfrm_policy.c                             |     2 +-
 net/xfrm/xfrm_state.c                              |    54 +-
 net/xfrm/xfrm_user.c                               |    14 +-
 scripts/coccinelle/misc/newline_in_nl_msg.cocci    |    13 +-
 tools/include/uapi/linux/bpf.h                     |    30 +
 tools/include/uapi/linux/if_xdp.h                  |    10 +
 tools/include/uapi/linux/netdev.h                  |    16 +
 tools/net/ynl/Makefile.deps                        |     5 +-
 tools/net/ynl/pyynl/lib/ynl.py                     |    46 +-
 tools/net/ynl/pyynl/ynl_gen_c.py                   |    36 +-
 tools/testing/selftests/bpf/network_helpers.c      |    28 +
 tools/testing/selftests/bpf/network_helpers.h      |     3 +
 .../testing/selftests/bpf/prog_tests/lwt_helpers.h |    29 -
 .../selftests/bpf/prog_tests/net_timestamping.c    |   239 +
 .../bpf/prog_tests/xdp_context_test_run.c          |   145 +-
 tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c  |     4 +-
 tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c  |     4 +-
 .../testing/selftests/bpf/progs/bpf_tracing_net.h  |     1 +
 .../testing/selftests/bpf/progs/net_timestamping.c |   248 +
 tools/testing/selftests/bpf/progs/setget_sockopt.c |     3 +
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  |    53 +-
 tools/testing/selftests/bpf/xdp_hw_metadata.c      |   168 +-
 tools/testing/selftests/drivers/net/.gitignore     |     2 +
 tools/testing/selftests/drivers/net/Makefile       |     5 +
 tools/testing/selftests/drivers/net/README.rst     |     4 +-
 tools/testing/selftests/drivers/net/config         |     1 +
 tools/testing/selftests/drivers/net/hds.py         |     3 +-
 tools/testing/selftests/drivers/net/hw/Makefile    |     6 +
 tools/testing/selftests/drivers/net/hw/csum.py     |    50 +-
 tools/testing/selftests/drivers/net/hw/devmem.py   |     6 +-
 tools/testing/selftests/drivers/net/hw/irq.py      |    99 +
 tools/testing/selftests/drivers/net/hw/ncdevmem.c  |     1 -
 tools/testing/selftests/drivers/net/hw/rss_ctx.py  |    48 +-
 .../selftests/drivers/net/hw/rss_input_xfrm.py     |    87 +
 tools/testing/selftests/drivers/net/hw/tso.py      |   241 +
 .../selftests/drivers/net/hw/xdp_dummy.bpf.c       |    13 +
 tools/testing/selftests/drivers/net/lib/py/env.py  |   137 +-
 .../selftests/drivers/net/lib/sh/lib_netcons.sh    |    24 +
 .../drivers/net/netcons_fragmented_msg.sh          |   122 +
 .../selftests/drivers/net/netcons_sysdata.sh       |   242 +
 tools/testing/selftests/drivers/net/ping.py        |    22 +-
 tools/testing/selftests/drivers/net/queues.py      |    45 +-
 tools/testing/selftests/drivers/net/xdp_helper.c   |   151 +
 tools/testing/selftests/net/.gitignore             |     2 +
 tools/testing/selftests/net/Makefile               |     9 +-
 tools/testing/selftests/net/bpf_offload.py         |     5 +-
 tools/testing/selftests/net/cmsg_ip.sh             |   187 +
 tools/testing/selftests/net/cmsg_ipv6.sh           |   154 -
 tools/testing/selftests/net/cmsg_sender.c          |   114 +-
 tools/testing/selftests/net/config                 |     8 +
 tools/testing/selftests/net/fcnal-test.sh          |     4 +-
 tools/testing/selftests/net/fdb_flush.sh           |     2 +-
 tools/testing/selftests/net/fib_nexthops.sh        |     9 +-
 tools/testing/selftests/net/fib_rule_tests.sh      |    74 +
 tools/testing/selftests/net/forwarding/README      |     2 +-
 .../testing/selftests/net/forwarding/bridge_mdb.sh |     2 +-
 tools/testing/selftests/net/forwarding/lib.sh      |    10 -
 .../selftests/net/forwarding/vxlan_bridge_1d.sh    |    10 +
 .../selftests/net/forwarding/vxlan_bridge_1q.sh    |    15 +
 tools/testing/selftests/net/gro.c                  |     8 +-
 tools/testing/selftests/net/gro.sh                 |     7 +-
 tools/testing/selftests/net/ip_local_port_range.sh |     4 +-
 tools/testing/selftests/net/lib.sh                 |    19 +
 tools/testing/selftests/net/lib/py/__init__.py     |     4 +-
 tools/testing/selftests/net/lib/py/ksft.py         |     7 +-
 tools/testing/selftests/net/lib/py/netns.py        |    18 +
 tools/testing/selftests/net/lib/py/utils.py        |    89 +-
 tools/testing/selftests/net/lib/py/ynl.py          |     4 +
 tools/testing/selftests/net/link_netns.py          |   141 +
 tools/testing/selftests/net/mptcp/Makefile         |     2 +-
 tools/testing/selftests/net/mptcp/diag.sh          |    27 +
 tools/testing/selftests/net/mptcp/mptcp_diag.c     |   272 +
 tools/testing/selftests/net/mptcp/simult_flows.sh  |     2 +-
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |    30 +-
 tools/testing/selftests/net/netns-name.sh          |    10 +
 tools/testing/selftests/net/nl_netdev.py           |    18 +-
 .../selftests/net/openvswitch/openvswitch.sh       |    11 +-
 tools/testing/selftests/net/proc_net_pktgen.c      |   690 +
 tools/testing/selftests/net/psock_tpacket.c        |     2 +-
 .../selftests/net/reuseaddr_ports_exhausted.c      |     2 +-
 tools/testing/selftests/net/rtnetlink.py           |    30 +
 tools/testing/selftests/net/setup_veth.sh          |     3 +-
 tools/testing/selftests/net/so_rcv_listener.c      |   168 +
 tools/testing/selftests/net/tcp_ao/connect-deny.c  |    58 +-
 tools/testing/selftests/net/tcp_ao/connect.c       |    22 +-
 tools/testing/selftests/net/tcp_ao/icmps-discard.c |    17 +-
 .../testing/selftests/net/tcp_ao/key-management.c  |    76 +-
 tools/testing/selftests/net/tcp_ao/lib/aolib.h     |   114 +-
 .../testing/selftests/net/tcp_ao/lib/ftrace-tcp.c  |     7 +-
 tools/testing/selftests/net/tcp_ao/lib/sock.c      |   315 +-
 tools/testing/selftests/net/tcp_ao/restore.c       |    75 +-
 tools/testing/selftests/net/tcp_ao/rst.c           |    47 +-
 tools/testing/selftests/net/tcp_ao/self-connect.c  |    18 +-
 tools/testing/selftests/net/tcp_ao/seq-ext.c       |    30 +-
 tools/testing/selftests/net/tcp_ao/unsigned-md5.c  |   118 +-
 tools/testing/selftests/net/test_blackhole_dev.sh  |    11 -
 tools/testing/selftests/net/test_so_rcv.sh         |    73 +
 .../selftests/net/test_vxlan_fdb_changelink.sh     |   111 +-
 tools/testing/selftests/net/ynl.mk                 |     3 +-
 tools/testing/selftests/ptp/testptp.c              |    37 +-
 .../tc-testing/tc-tests/actions/police.json        |    10 +-
 1522 files changed, 127616 insertions(+), 39548 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
 create mode 100644 Documentation/devicetree/bindings/net/fsl,gianfar-mdio.yaml
 create mode 100644 Documentation/devicetree/bindings/net/fsl,gianfar.yaml
 create mode 100644 Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
 rename Documentation/devicetree/bindings/{mfd => net}/realtek,rtl9301-switch.yaml (66%)
 create mode 100644 Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
 create mode 100644 Documentation/devicetree/bindings/net/tesla,fsd-ethqos.yaml
 create mode 100644 Documentation/netlink/specs/conntrack.yaml
 create mode 100644 Documentation/netlink/specs/nl80211.yaml
 delete mode 100644 Documentation/networking/device_drivers/cable/index.rst
 delete mode 100644 Documentation/networking/device_drivers/cable/sb1000.rst
 create mode 100644 drivers/net/ethernet/airoha/Kconfig
 create mode 100644 drivers/net/ethernet/airoha/Makefile
 rename drivers/net/ethernet/{mediatek => airoha}/airoha_eth.c (66%)
 create mode 100644 drivers/net/ethernet/airoha/airoha_eth.h
 create mode 100644 drivers/net/ethernet/airoha/airoha_npu.c
 create mode 100644 drivers/net/ethernet/airoha/airoha_npu.h
 create mode 100644 drivers/net/ethernet/airoha/airoha_ppe.c
 create mode 100644 drivers/net/ethernet/airoha/airoha_ppe_debugfs.c
 create mode 100644 drivers/net/ethernet/airoha/airoha_regs.h
 create mode 100644 drivers/net/ethernet/cisco/enic/enic_rq.c
 create mode 100644 drivers/net/ethernet/cisco/enic/enic_rq.h
 create mode 100644 drivers/net/ethernet/cisco/enic/enic_wq.c
 create mode 100644 drivers/net/ethernet/cisco/enic/enic_wq.h
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_diagnose.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_diagnose.h
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_ptp.c
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_ptp.h
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_types.h
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/otx2_xsk.h
 create mode 100644 drivers/net/ethernet/sfc/efx_reflash.c
 create mode 100644 drivers/net/ethernet/sfc/efx_reflash.h
 create mode 100644 drivers/net/ethernet/sfc/fw_formats.h
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_ptp.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_ptp.h
 create mode 100644 drivers/net/mctp/mctp-usb.c
 create mode 100644 drivers/net/phy/phy-caps.h
 create mode 100644 drivers/net/phy/phy_caps.c
 create mode 100644 drivers/net/phy/phy_package.c
 create mode 100644 drivers/net/phy/phylib-internal.h
 create mode 100644 drivers/net/phy/phylib.h
 delete mode 100644 drivers/net/sb1000.c
 create mode 100644 drivers/net/tun_vnet.h
 create mode 100644 drivers/net/wireless/ath/ath11k/coredump.c
 create mode 100644 drivers/net/wireless/ath/ath11k/coredump.h
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_sta.c
 create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_sta.h
 create mode 100644 drivers/net/wireless/ath/ath12k/testmode.c
 create mode 100644 drivers/net/wireless/ath/ath12k/testmode.h
 rename drivers/net/wireless/ath/{ath11k => }/testmode_i.h (50%)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/api/dhc.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/dhc-utils.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/Makefile
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/agg.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/agg.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/ap.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/ap.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/coex.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/coex.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/constants.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/d3.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/d3.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/debugfs.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/fw.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/hcmd.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/iface.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/iface.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/key.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/key.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/led.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/led.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/link.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/link.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/low_latency.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/low_latency.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/mac80211.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/mcc.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/mcc.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/mld.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/mld.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/mlo.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/mlo.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/notif.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/notif.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/phy.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/phy.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/power.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/power.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/ptp.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/ptp.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/regulatory.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/regulatory.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/roc.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/roc.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/rx.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/rx.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/scan.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/scan.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/session-protect.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/session-protect.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/sta.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/sta.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/stats.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/stats.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/Makefile
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/agg.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/hcmd.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/link.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/module.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/rx.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/utils.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/thermal.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/thermal.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/time_sync.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/time_sync.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tlc.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tlc.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tx.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tx.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8814a.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8814a.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8814a_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8814a_table.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8814ae.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8814au.c
 delete mode 100644 drivers/s390/net/lcs.c
 delete mode 100644 drivers/s390/net/lcs.h
 create mode 100644 include/linux/platform_data/x86/intel_pmc_ipc.h
 create mode 100644 include/linux/usb/mctp-usb.h
 create mode 100644 include/net/netdev_lock.h
 create mode 100644 include/net/netdev_netlink.h
 create mode 100644 include/net/page_pool/memory_provider.h
 delete mode 100644 include/uapi/linux/if_cablemodem.h
 rename lib/{test_blackhole_dev.c => blackhole_dev_kunit.c} (68%)
 rename net/batman-adv/{soft-interface.c => mesh-interface.c} (83%)
 rename net/batman-adv/{soft-interface.h => mesh-interface.h} (50%)
 create mode 100644 net/core/dev_api.c
 create mode 100644 net/hsr/prp_dup_discard_test.c
 create mode 100644 net/ipv4/igmp_internal.h
 create mode 100644 net/mac80211/tests/chan-mode.c
 create mode 100644 net/mptcp/pm_kernel.c
 create mode 100644 net/unix/af_unix.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/net_timestamping.c
 create mode 100644 tools/testing/selftests/bpf/progs/net_timestamping.c
 create mode 100644 tools/testing/selftests/drivers/net/.gitignore
 create mode 100755 tools/testing/selftests/drivers/net/hw/irq.py
 create mode 100755 tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
 create mode 100755 tools/testing/selftests/drivers/net/hw/tso.py
 create mode 100644 tools/testing/selftests/drivers/net/hw/xdp_dummy.bpf.c
 create mode 100755 tools/testing/selftests/drivers/net/netcons_fragmented_msg.sh
 create mode 100755 tools/testing/selftests/drivers/net/netcons_sysdata.sh
 create mode 100644 tools/testing/selftests/drivers/net/xdp_helper.c
 create mode 100755 tools/testing/selftests/net/cmsg_ip.sh
 delete mode 100755 tools/testing/selftests/net/cmsg_ipv6.sh
 create mode 100755 tools/testing/selftests/net/link_netns.py
 create mode 100644 tools/testing/selftests/net/mptcp/mptcp_diag.c
 create mode 100644 tools/testing/selftests/net/proc_net_pktgen.c
 create mode 100755 tools/testing/selftests/net/rtnetlink.py
 create mode 100644 tools/testing/selftests/net/so_rcv_listener.c
 delete mode 100755 tools/testing/selftests/net/test_blackhole_dev.sh
 create mode 100755 tools/testing/selftests/net/test_so_rcv.sh

