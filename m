Return-Path: <netdev+bounces-283111-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HuCDLVK9GlSAQIAu9opvQ
	(envelope-from <netdev+bounces-283111-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 08:39:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8129E4AAAF5
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 08:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 843A4301ECC2
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 06:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F3E361675;
	Fri,  1 May 2026 06:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mO1tLbnC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C6735F5E1;
	Fri,  1 May 2026 06:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777617514; cv=none; b=RHr/R+iGgcjRjAtcQX7jNfKg0xHpj+QoXwqszV28C3pI78ar6Zwzd4yB8zak41OlAj/c6mq/Qv2K07lix9bI2wzKEOejwa2zLyO+KvCPglrPyzJFLkbXLsLC0pox58t8JgVZYQhQ1vzfC5Lu7EaOQaXNiNGRM3F5ZP6rBTzk//4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777617514; c=relaxed/simple;
	bh=krFGoxSPA0/jqDPKvHqen1fQjhlLvRhDjr8/WMo9Am4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ES8QJHHbG4USY4zVl2QTsUU5Y+fbreCXL9zHHkupfRH/mZmv9D9IG62OFhzA41+rrad3nx9Hscgdgv151EXbk1PQib0T4D4gkBa7tz/9u2BuW6o8XAqr78MUWS70jEg6K8FdRY7SFX+EHLrers00pc50/xFyjNlaAcOYt6nz8vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mO1tLbnC; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777617513; x=1809153513;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=krFGoxSPA0/jqDPKvHqen1fQjhlLvRhDjr8/WMo9Am4=;
  b=mO1tLbnC1FuM+XKc5KRS/cGdzEeA3k7/D8F1bQeRTtEyYVUNSs/yyS2F
   +J9LxaOvp37SxKPfCu9vRyDSvlLa2/AYhydOGN8yFC/Mquroh6HOH80ow
   ZP7L5UDaDAPviXXrT3Aavb/Jpsuvnuvcve97nHPcA7NO73EGruXLxR907
   4hkXdrtKRFt+bMoH3uHenRzUPkas0/NR8prpHtQ+j2RKna+c1xvpcxtMF
   aygxzhOovTLOCDe6uBX1oE2B4ylSuFTZXvZrgKOgo0GL1vL0bAGXRzjj6
   ItDfKOsolWQvbNQ5XORTx+/+zHzWFSSpgnVcZ1QSpJeEHTI13H7DBpcsO
   g==;
X-CSE-ConnectionGUID: mBIF5zB6Tcq6Boz5DRCY8g==
X-CSE-MsgGUID: hHlp84cQSGyAi+4r1N41gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="89271847"
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="89271847"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 23:38:31 -0700
X-CSE-ConnectionGUID: Gk9H0JHDS4KNSjl38phEiQ==
X-CSE-MsgGUID: Za4jdmWXRnGHIzYKoJaBHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; 
   d="scan'208";a="233752836"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 23:38:31 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 00/15] Intel Wired LAN Updates 2024-04-30 (ixgbe,
 i40e, ice)
Date: Thu, 30 Apr 2026 23:37:11 -0700
Message-Id: <20260430-jk-iwl-net-next-2026-04-30-v1-0-6f27ae1cd073@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWMyw6CMBBFf4XM2kkqVAz+imGB5QqDppq2PBLCv
 ztoXNzFyck9K0UEQaRLtlLAJFFeXuF4yMj1je/A0ipTbvLS2MLw8GCZn+yRdEviXbCxrKpFVZx
 cVZ6dBWngHXCX5Ru/0v9A9c/E8TbApb1N2/YBKwvL0ogAAAA=
X-Change-ID: 20260430-jk-iwl-net-next-2026-04-30-de935c967c4e
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Simon Horman <horms@kernel.org>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Ivan Vecera <ivecera@redhat.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Stefan Wegrzyn <stefan.wegrzyn@intel.com>
Cc: Piotr Kwapulinski <piotr.kwapulinski@intel.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Rinitha S <sx.rinitha@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>, 
 Byungchul Park <byungchul@sk.com>, 
 Alexander Nowlin <alexander.nowlin@intel.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Sunitha Mekala <sunithax.d.mekala@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=5080;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=krFGoxSPA0/jqDPKvHqen1fQjhlLvRhDjr8/WMo9Am4=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhswvXvE1+fuCJ1nGCzs5XWNKcNnsdcD8WvvktEud8y+yH
 +erdFDrKGVhEONikBVTZFFwCFl53XhCmNYbZzmYOaxMIEMYuDgFYCJh6owMr+V4trDZvMnUPpOk
 xZuaxR82dZ0Td729jGzok9CwJWtuM/wVeb68JjLOrPyMmc33uUqn7szifKtx8NayfvuQ42HiCxP
 5AQ==
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: 8129E4AAAF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283111-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]

This series includes updates to support Energy-Efficient Ethernet (EEE) on
E610 devices in the ixgbe driver, support for an unmanaged DPLL output on
E830, as well as some other minor cleanups and improvements across ixgbe,
i40e, and ice.

Jedrzej begins with the first six patches preparing the ixgbe driver to
support EEE, adding a EEE capability flag, updating the supported EEE
speeds, updating the ACI command structures with the fields related to
EEE, moving the EEE config validation out for re-use, and finally
implementing the EEE support for E610 hardware.

Piotr adds some extended dynamic debug output for the Admin Command
Interface used by E610 in the ixgbe driver. This adds debug tracing for the
ACI which is disabled by default but can be enabled through the standard
dynamic debug interfaces.

Piotr also removes a redundant self assignment in ixgbe_aci_send_cmd_execute().

Aleksandr fixes the ixgbe_update_flash_X550() logic to prevent unaligned
access in ixgbe_host_interface_command(). Note: this has no functional
change on x86, and is being sent through net-next as it is considered a
minor cleanup.

Jacob (hi!) modifies the i40e driver to only timestamp PTP event packets,
instead of timestamping every V2 event frame. This avoids wasting the
limited number of timestamp slots for frames which the PTP protocol does
not care about.

Jacob also extends the devlink flash notification message reporting that
users can activate the new firmware via devlink reload to explicitly
indicate the required "fw_activate" action.

Byungchul Park  fixes the ice_lbtest_receive_frames() function to use
netmem_desc instead of the page structure.

Przemyslaw Korba fixes a truncation warning in ice_dpll_init_fwnode_pins()
by increasing the allowed length of the pin_name string on the stack to 16.

Ivan Vecera adds some bounds checking to ice_dpll_rclk_state_on_pin_get/set()
and moves the CGU register macros to be under the header guard ifdef in
ice_dpll.h

Finally, Arkadiusz Kubalewski adds support for an unmanaged DPLL interface
on E830 devices. This enables users to check the DPLL lock status and
obtain relevant configuration information through the DPLL netlink, even
though the physical DPLL settings are hard coded within the hardware and
thus and unable to be modified.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Aleksandr Loktionov (1):
      ixgbe: fix unaligned u32 access in ixgbe_update_flash_X550()

Arkadiusz Kubalewski (1):
      ice: add support for unmanaged DPLL on E830 NIC

Byungchul Park (1):
      ice: access @pp through netmem_desc instead of page

Ivan Vecera (1):
      ice: dpll: fix rclk pin state get and misplaced header macros

Jacob Keller (2):
      i40e: only timestamp PTP event packets
      ice: mention fw_activate action along with devlink reload

Jedrzej Jagielski (6):
      ixgbe: E610: add discovering EEE capability
      ixgbe: E610: update EEE supported speeds
      ixgbe: E610: use new version of 0x601 ACI command buffer
      ixgbe: E610: update ACI command structs with EEE fields
      ixgbe: move EEE config validation out of ixgbe_set_eee()
      ixgbe: E610: add EEE support

Piotr Kwapulinski (2):
      ixgbe: E610: add ACI dynamic debug
      ixgbe: E610: remove redundant assignment

Przemyslaw Korba (1):
      ice: dpll: Fix compilation warning

 drivers/net/ethernet/intel/i40e/i40e_register.h    |  10 +
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h    |  12 +
 drivers/net/ethernet/intel/ice/ice_common.h        |   8 +
 drivers/net/ethernet/intel/ice/ice_dpll.h          |  43 +--
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h        |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h      |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h      |   2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h |  32 ++-
 include/linux/net/intel/libie/adminq.h             |   1 +
 drivers/net/ethernet/intel/i40e/i40e_ptp.c         |   9 +-
 drivers/net/ethernet/intel/ice/devlink/health.c    |   4 +
 drivers/net/ethernet/intel/ice/ice_common.c        | 136 +++++++++
 drivers/net/ethernet/intel/ice/ice_dpll.c          | 307 +++++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |   2 +-
 drivers/net/ethernet/intel/ice/ice_fw_update.c     |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |  11 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c        |  46 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c      | 193 +++++++++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   | 244 +++++++++++++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |  30 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c      |   2 +-
 .../device_drivers/ethernet/intel/ice.rst          |  83 ++++++
 22 files changed, 1057 insertions(+), 122 deletions(-)
---
base-commit: 82968921d206abeef34bbfdb643d62a08dc7fe30
change-id: 20260430-jk-iwl-net-next-2026-04-30-de935c967c4e

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>


