Return-Path: <netdev+bounces-289857-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WF/hJcyBDWrUyQUAu9opvQ
	(envelope-from <netdev+bounces-289857-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:41:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F6E58AF87
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D5D5F301D114
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 09:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FAA39934B;
	Wed, 20 May 2026 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kLKQIq4V"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B753C0603;
	Wed, 20 May 2026 09:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779270066; cv=none; b=Fzw1fn+TZT5YA6oMB4n53O1lVasXEAc+k+Fm6hVWNZK+XCE+g3QupRAM9MFNTVLPBtJB4aVjACIxd59gPK46zKvE2Kzuh9NgjnApLwjPWFSaor/QH7FWDLBmXlQAXvLt41TWACO3FsVTYTGY5aL7ZUg2vMUKvXOyZV2zSFjWHvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779270066; c=relaxed/simple;
	bh=/A8T628cXPkWxHavNgxSa3ZcoWcI2pIF/Evd/3UL7ZM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qG3GrSYcK8VBT4g8m1sGBCF5hl8UOEEen2WFpTESPqJI6Hs8jnOHViLndfTGFT0aVfksjLf0rHfLEO0uirSoskVjc1uah0Yrf7HiBKEaq0PcBFl2UrGS/1grNO0NFylctYTHY7rTKjgzjdFFglTl3P+9cRZBdvM6DtHZeqeAczc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kLKQIq4V; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779270063; x=1810806063;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/A8T628cXPkWxHavNgxSa3ZcoWcI2pIF/Evd/3UL7ZM=;
  b=kLKQIq4VNEnkc/OSybpVu24abJfBUj2AFOY9qNNBjCq+21hDBmBu0hvq
   MKfo3F5yyhwpxowutbE4DX2h57Lma9wzro3eCVgo2upgU0pBM5rAk49Jq
   2aAC6cymyafpUuqBCSy5SVOah3zI8lHsU+epNTw5EVGYdHLjWDx3oHLqK
   mEAno0PRal+rZ/A+iTJ3Sk+J/qj1i4UB6uCE/wgNe7XWBPt2mTW7id4fn
   bemCp1lEe/NqioB8JveCA/Hny15zRx8YpBguhWpXPdt0wwsIoW6f1eAo6
   vKOB+0TNG+0vLaAxn6OJkn4J05N9f0xvcVH2f8PRmSM/nquFse3e/sov9
   w==;
X-CSE-ConnectionGUID: XDYJsSf8RdiXZIPrdGukQQ==
X-CSE-MsgGUID: JWINTw8BTS2zN5s0baYLeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="90860315"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="90860315"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 02:41:01 -0700
X-CSE-ConnectionGUID: iamqZinyR5yRbm0rCtSyxA==
X-CSE-MsgGUID: ZAvFgQ5lRESp8xAnWwoWIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="240364996"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa007.jf.intel.com with ESMTP; 20 May 2026 02:40:56 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	poros@redhat.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	Prathosh.Satish@microchip.com,
	ivecera@redhat.com,
	jiri@resnulli.us,
	arkadiusz.kubalewski@intel.com,
	vadim.fedorenko@linux.dev,
	donald.hunter@gmail.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH v10 net-next 0/8] dpll/ice: Add generic DPLL type and full TX reference clock control for E825
Date: Wed, 20 May 2026 11:36:20 +0200
Message-Id: <20260520093628.3930705-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289857-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: A1F6E58AF87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

NOTE: This series is intentionally submitted on net-next (not
intel-wired-lan) as early feedback of DPLL subsystem changes is
welcomed. In the past possible approaches were discussed in [1].

This series adds TX reference clock support for E825 devices and exposes
TX clock selection and synchronization status via the Linux DPLL
subsystem.

Here is the high-level connection diagram for E825 device:
  +------------------------------------------------------------------+
  |                                                                  |
  |                           +-----------------------------+        |
  |                           |                             |        |
  |                           |         MAC                 |        |
  |                           |+------------+-----+         |        |
  |                           ||RX/1588 |PHC|tspll<----\    |        |
+---+----+                    ||MUX     +---+-^---|    |    |        |
| E | RX >--------------------->              |   >--\ |    |        |
| T |    |    /---------------->              |   >-\| |    |        |
| H |----+    |               |+---------+----^---+ || |    |        |
| 1 | TX <----|----------------+TX MUX   < OCXO   | || |    |        |
|   |PLL |    |               ||         |--------| || |    |        |
+---+----+    |           /----+         <-ext_ref<-||-|----|------ext_ref
| E | RX >----/           |   ||         |--------+ || |    |        |
| T |    |                |   ||         <  SyncE | || |    |        |
| H |----+                |   |+-----------^------+ || |    |        |
| 2 | TX <----------------/   |            | /------||-/    |        |
|   |PLL |                    +------------|-|------||------+        |
+---+----+                              /--/ |      ||               |
| . | RX >---                           |    |      ||               |
| . |    |                   +----------|----|------||--+            |
| . |----+                   |        +-^-+--^+     ||  |            |
|   | TX <---                |        |EEC|PPS|     ||  |            |
|   |PLL |                   |        +-------+     ||  |            |
+---+----+                   |        |       <-CLK0/|  |            |
| E | RX >---                |        |  DPLL |      |  |            |
| T |    |                   |        |       <-CLK1-/  |            |
| H |----+                   |        |       |         |            |
| X | TX <---                |        |       <---SMA---<            |
|   |PLL |                   |        |       |         |            |
+---+----+                   |        |       <---GPS---<            |
  |                          |        |       |         |            |
  |                          |        |       <---...---<            |
  |                          |        |       |         |            |
  |                          |        +-------+         |            |
  |                          | External timing module   |            |
  |                          +--------------------------+            |
  +------------------------------------------------------------------+

E825 hardware contains a dedicated TX clock domain with per-port source
selection behavior that is distinct from PPS handling and from board-level
EEC distribution. TX reference clock selection is device-wide, shared
across ports, and mediated by firmware as part of link bring-up. As a
result, TX clock selection intent may differ from effective hardware
configuration, and software must verify outcome after link-up.

To support this, the series extends the DPLL core and the ice driver
incrementally. The series also introduces DPLL_TYPE_GENERIC as a broad
UAPI class for DPLL instances outside PPS/EEC categories. The intent is
to keep type naming reusable and scalable across different ASIC
topologies while preserving functional discoverability via
driver/device context and pin topology.

This follows netdev discussion guidance that UAPI type naming should avoid
location-specific or vendor-specific taxonomy, because such labels do not
scale across different ASIC designs. The function of a given DPLL instance
is already discoverable from driver/device context and pin topology, and
does not require an additional narrow type identifier in UAPI.

At the same time, a separate DPLL object is still needed for E825 TX clock
control/reporting semantics. Using DPLL_TYPE_GENERIC provides a reusable
class for devices outside PPS/EEC without overfitting UAPI naming to one
topology.

The relevant discussion is in [2].

Series content
- add a new generic DPLL type for devices outside PPS/EEC classes;
- relax DPLL pin registration rules for firmware-described shared pins
  and extend pin notifications with a source identifier;
- allow dynamic state control of SyncE reference pins where hardware
  supports it;
- add CPI infrastructure for PHY-side TX clock control on E825C;
- introduce a TX-clock DPLL device and TX reference clock pins
  (EXT_EREF0 and SYNCE) in the ice driver;
- extend the Restart Auto-Negotiation command to carry a TX reference
  clock index;
- implement hardware-backed TX reference clock switching, post-link
  verification, and TX synchronization reporting.

TXCLK pins report TX reference topology only. Actual synchronization
success is reported via DPLL lock status, updated after hardware
verification: external TX references report LOCKED, while the internal
ENET/TXCO source reports UNLOCKED.

This provides reliable TX reference selection and observability on E825
devices using standard DPLL interfaces, without conflating user intent
with effective hardware behavior.

[1] https://lore.kernel.org/netdev/20250905160333.715c34ac@kernel.org/
[2] https://lore.kernel.org/netdev/20260402230626.3826719-1-grzegorz.nitka@intel.com/

Changes in v10:
- rebased
Addressed AI review (Sashiko) concerns (all in patch 8/8):
- moved INIT_WORK(txclk_work) and added init_rwsem(txclk_notify_rwsem)
  next to mutex_init(&d->lock) in ice_dpll_init_e825() so both are
  initialized before any path that can fail and trigger ice_dpll_deinit()
- added struct rw_semaphore txclk_notify_rwsem to struct ice_dplls and
  used it (down_read across the whole critical region of
  ice_txclk_update_and_notify(), including the out-of-lock dpll_*_change_ntf()
  calls; down_write/up_write barrier in ice_dpll_deinit() to drain
  in-flight notifiers before pins and the TXC DPLL device are freed) -
  closes a use-after-free window on rmmod
- ice_dpll_txclk_state_on_dpll_set(): reject pin states other than
  CONNECTED/DISCONNECTED with -EINVAL and NL_SET_ERR_MSG() instead of
  silently treating them as a connect request
- ice_dpll_txclk_work(): on a failed switch, capture old/new pin pointers
  under the lock and emit dpll_pin_change_ntf() after dropping it, so
  userspace sees the requested pin flip back to DISCONNECTED and the
  effective pin to CONNECTED
- ice_dpll_txclk_work(): only clear txclk_switch_requested / roll back
  tx_clk_req when no newer request arrived while the lock was dropped,
  so a re-queued worker run picks up the updated value
- ice_txclk_update_and_notify(): replaced the
  pf->dplls.txc.dpll = ERR_PTR(-ENODEV) "suppress notification" hack
  with an explicit local bool notify_dpll; the dpll_state update and
  the notification decision are made under the lock, the notification
  itself is emitted after unlock
- ice_ptp_setup_pf(): seed the per-PHY Tx reference clock usage map
  only on E825 and explained the "no locking needed" invariant in a
  comment (runs before pf->dplls.lock exists and before any link event
  or DPLL callback can observe the map)
- moved port_num/phy and tx_ref_clk locals into the E825-only branches
  where they are actually used
- ice_txclk_enable_peer(): use ice_pf_to_dev(pf) for dev_err() to match
  the rest of the file (was ice_hw_to_dev(&pf->hw))
- extended ctrl_pf->dplls.lock coverage in ice_txclk_set_clk() and
  ice_txclk_enable_peer() across both the usage check and the
  ice_cpi_ena_dis_clk_ref() AQ command so two PFs racing to switch to
  the same (phy, clk) cannot both observe clk_in_use == false and issue
  duplicate enables
Other:
- replaced ternary-for-statement-effect (`(clk == i) ? set_bit() :
  clear_bit();`) with plain if/else in the two tx_refclks bitmap loops
- dropped 15 unused CFG_*/CFG_RESERVED* SERDES field defines in
  ice_ptp_hw.h; kept only CFG_ICTL_PCS_REF_SEL_RX_NT,
  CFG_ICTL_PCS_REF_SEL_TX_NT and REF_SEL_NT_ENET/EREF0/SYNCE which are
  actually consumed
- updated kernel-doc for struct ice_dpll
Patch 7/8:
- cosmetic: removed a stray double space in the
  ice_aq_set_link_restart_an() prototype
Patches 1-6: unchanged

Changes in v9:
- rebased
- fixed kernel-doc: member 'module_name' not described in 'dpll_pin' (patch 2/8)
Addressed AI review concerns:
- reworded commit message to use 'src_clock_id' instead 'src_id' (patch 3/8)
- use rclk.num_parents when setting is_rclk_parent (patch 5/8)
- fixed retry mechanism in ice_cpi_wait_ack (patch 6/8)
- fixed txclk_switch_requested, tx_clk, tx_clk_req settings on HW
  failure (patch 8/8)
- use cancel_work_sync instead flush_work (patch 8/8)
- protect clearing ICE_FLAG_DPLL flag with mitex on DPLL
  deinit (patch 8/8)
- dpll_state update and the notify_dpll decision are made inside
  the lock (patch 8/8)

Changes in v8:
- rebased
Addressed AI review concerns:
- caching the module name in the pin object at allocation time and using
  the cached string in netlink paths (patch 2/8)
- dropped references to netlink in the commit message for (patch 3/8, it's
  internal notification only)
- replaced the commit 4/8 with the new one (relax the capability check in
  dpll_pin_state_set)
- resolved potential teradown race between ice_dpll_deinit_txclk_pins and
  ice_dpll_pin_notify_work() that is about to register the SYNCE pin
  (patch 5/8)
- resolved potential path deadlock during driver probe and error path
  (patch 5/8)
- relaxed kernel-doc regarding cpi mutex usage (patch 6/8)
- fixed ice_cpi.c header (patch 6/8)
- fix retry mechanism in ice_cpi_wait_req0_ack0 (patch 6/8)
- fix potrntial leaving LM.REQ stuck asserted on the hardware (patch 6/8)
- fix kernel-doc for ice_cpi_ena_dis_clk_ref
- removed unused CPI definitions (patch 6/8)
- fix header inclusion (patch 6/8)
- addressed Sashiko issues for patch (8/8)

Changes in v7:
- rebased
- replace TXC-specific DPLL type with DPLL_TYPE_GENERIC (patch 1/8)
- update TXC framework to use DPLL_TYPE_GENERIC instead of DPLL_TYPE_GENERIC
  (patch 5/8)
- AI-review: added short trailing comment to the local mutex declaration
  to satisfy checkpatch report (patch 6/8)

Changes in v6:
 - rebased
 - AI-review: fix unprotected concurrent access to shared clock
   bitmap (patch 8/8)
 - AI-review: fix potential issue in tx-clk pin state request handling
   ('already set' early-exit based now on tx_clk_req comparison, patch 8/8)
 - AI-review: CPI transaction serialization (patch 6/8) 

Changes in v5:
 - rebased
 - reworded cover letter
 - replace 'ntfy_src' new argument name with 'src_clk_id' and use it
   consistently in DPLL notification calls (patch 3/8)
 - reworded commit message (patch 5/8)
 - use FIELD_PREP/GENMSK macros instead of struct bitfields (patch 6/8)
 - reworded commit message (patch 5/8, patch 8/8)
 - refactor the code to avoid sleeping while DPLL mutex is held (using
   work_queue, patch 8/8)
 - added TXCLK pins and TXC DPLL notifications (patch 8/8)
 - removed 'unused clock disable' mechanism from the scope of this series

Changes in v4:
 - rebased
 - edited, shortened the commit message in 3/8 patch
 - moved ice_get_ctrl_pf to the header file (patch 8/8) and
   removed duplicated static definitions from ice_ptp and ice_txlck
   modules
 - add NULL/invalid pointer checker for returned pointer from
   ice_get_ctrl_pf (patch 8/8)
 - edited error message in case AN restart failure (patch 8/8)

Changes in v3:
- improved commit message (patch 1/8, AI review comment)
- improved deinitialization path in ice_dpll_deinit_txclk_pins to
  avoid potential NULL dereference. NULL checking moved to
  ice_dpll_unregister_pins (patch 5/8, found by AI review)
- removed redundant semicolon (patch 6/8)

Changes in v2:
- rebased
- added autogenerated DPLL files (patch 1/8)
- fixed checkpatch 'parenthesis alignment' warning (patch 2/8)
- fixed error path in ice_dpll_init_txclk_pins (AI warning, patch 5/8)
- fixed kdoc warnings (patch 6/8, patch 8/8)

Grzegorz Nitka (8):
  dpll: add generic DPLL type
  dpll: allow registering FW-identified pin with a different DPLL
  dpll: extend pin notifier with notification source ID
  dpll: allow fwnode pins to attempt state change without capability bit
  ice: introduce TXC DPLL device and TX ref clock pin framework for E825
  ice: implement CPI support for E825C
  ice: add Tx reference clock index handling to AN restart command
  ice: implement E825 TX ref clock control and TXC hardware sync status

 Documentation/netlink/specs/dpll.yaml         |   3 +
 drivers/dpll/dpll_core.c                      |  34 +-
 drivers/dpll/dpll_core.h                      |   5 +-
 drivers/dpll/dpll_netlink.c                   |  26 +-
 drivers/dpll/dpll_netlink.h                   |   4 +-
 drivers/dpll/dpll_nl.c                        |   2 +-
 drivers/net/ethernet/intel/ice/Makefile       |   2 +-
 drivers/net/ethernet/intel/ice/ice.h          |  12 +
 drivers/net/ethernet/intel/ice/ice_adapter.c  |   4 +
 drivers/net/ethernet/intel/ice/ice_adapter.h  |   7 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_common.c   |   5 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |   2 +-
 drivers/net/ethernet/intel/ice/ice_cpi.c      | 362 ++++++++++++++
 drivers/net/ethernet/intel/ice/ice_cpi.h      |  58 +++
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 468 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_dpll.h     |  36 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |   3 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  37 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   7 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  37 ++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  17 +
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |   5 +-
 drivers/net/ethernet/intel/ice/ice_txclk.c    | 320 ++++++++++++
 drivers/net/ethernet/intel/ice/ice_txclk.h    |  40 ++
 drivers/net/ethernet/intel/ice/ice_type.h     |   2 +
 include/linux/dpll.h                          |   1 +
 include/uapi/linux/dpll.h                     |   2 +
 28 files changed, 1442 insertions(+), 61 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_cpi.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_cpi.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_txclk.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_txclk.h


base-commit: 794cd1c77f53309f5eb8c05b4b833ad3723eccff
-- 
2.39.3


